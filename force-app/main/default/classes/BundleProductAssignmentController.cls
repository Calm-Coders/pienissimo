public with sharing class BundleProductAssignmentController {
  private static final Integer MAX_RESULTS = 100;

  public class ItemOption {
    @AuraEnabled
    public Id id;
    @AuraEnabled
    public String name;
    @AuraEnabled
    public String productCode;
    @AuraEnabled
    public Decimal productPrice;

    public ItemOption(Product2 product) {
      id = product.Id;
      name = product.Name;
      productCode = product.ProductCode;
      productPrice = product.Product_Price__c;
    }
  }

  public class ComponentRow {
    @AuraEnabled
    public Id id;
    @AuraEnabled
    public Id productId;
    @AuraEnabled
    public String name;
    @AuraEnabled
    public String productCode;
    @AuraEnabled
    public Decimal quantity;
    @AuraEnabled
    public Decimal listPrice;
    @AuraEnabled
    public Decimal spreadPrice;

    public ComponentRow(BundleComponent__c component) {
      id = component.Id;
      productId = component.Product__c;
      name = component.Product__r.Name;
      productCode = component.Product__r.ProductCode;
      quantity = component.Quantity__c;
      listPrice = component.List_Price__c;
      spreadPrice = component.Spread_Price__c;
    }
  }

  public class BundleContext {
    @AuraEnabled
    public String bundleName;
    @AuraEnabled
    public Decimal fixedPrice;
    @AuraEnabled
    public Decimal spreadTotal;
    @AuraEnabled
    public Decimal variance;
    @AuraEnabled
    public List<ComponentRow> components;
  }

  // This type is deserialized explicitly from JSON. Letting the LWC/Apex bridge coerce a
  // List<ComponentInput> can silently create blank rows for nested wrapper classes.
  public class ComponentInput {
    public String id;
    public String productId;
    public Decimal quantity;
    public Decimal spreadPrice;
  }

  @AuraEnabled
  public static BundleContext getBundleContext(Id bundleId) {
    if (bundleId == null) {
      throw new AuraHandledException('Missing bundle record id.');
    }

    Product2 bundle = [
      SELECT
        Id,
        Name,
        Bundle_Selling_Price__c,
        Spread_Total__c,
        Spread_Variance__c
      FROM Product2
      WHERE Id = :bundleId
      LIMIT 1
    ];

    BundleContext context = new BundleContext();
    context.bundleName = bundle.Name;
    context.fixedPrice = bundle.Bundle_Selling_Price__c;
    context.spreadTotal = bundle.Spread_Total__c;
    context.variance = bundle.Spread_Variance__c;
    context.components = new List<ComponentRow>();

    for (BundleComponent__c component : [
      SELECT
        Id,
        Product__c,
        Product__r.Name,
        Product__r.ProductCode,
        Quantity__c,
        List_Price__c,
        Spread_Price__c
      FROM BundleComponent__c
      WHERE Bundle__c = :bundleId
      ORDER BY Product__r.Name
    ]) {
      context.components.add(new ComponentRow(component));
    }

    return context;
  }

  // Products already in this bundle are excluded. Products sitting in OTHER bundles are
  // deliberately offered: a product may belong to several bundles, each with its own spread.
  @AuraEnabled
  public static List<ItemOption> searchItems(Id bundleId, String searchTerm) {
    if (bundleId == null) {
      throw new AuraHandledException('Missing bundle record id.');
    }

    Id itemRecordTypeId = getRecordTypeId('Item');
    if (itemRecordTypeId == null) {
      return new List<ItemOption>();
    }

    Set<Id> alreadyLinked = new Set<Id>();
    for (BundleComponent__c component : [
      SELECT Product__c
      FROM BundleComponent__c
      WHERE Bundle__c = :bundleId
    ]) {
      alreadyLinked.add(component.Product__c);
    }

    String normalizedSearchTerm = String.isBlank(searchTerm)
      ? null
      : '%' + searchTerm.trim() + '%';

    List<Product2> products = normalizedSearchTerm == null
      ? [
          SELECT Id, Name, ProductCode, Product_Price__c
          FROM Product2
          WHERE
            RecordTypeId = :itemRecordTypeId
            AND IsActive = TRUE
            AND Id NOT IN :alreadyLinked
          ORDER BY Name
          LIMIT :MAX_RESULTS
        ]
      : [
          SELECT Id, Name, ProductCode, Product_Price__c
          FROM Product2
          WHERE
            RecordTypeId = :itemRecordTypeId
            AND IsActive = TRUE
            AND Id NOT IN :alreadyLinked
            AND (Name LIKE :normalizedSearchTerm
            OR ProductCode LIKE :normalizedSearchTerm)
          ORDER BY Name
          LIMIT :MAX_RESULTS
        ];

    List<ItemOption> results = new List<ItemOption>();
    for (Product2 product : products) {
      results.add(new ItemOption(product));
    }
    return results;
  }

  // Reconciles the bundle's components to exactly what the UI submitted:
  // rows without an id are added, existing rows are re-priced, missing rows are unlinked.
  @AuraEnabled
  public static BundleContext saveComponents(
    Id bundleId,
    String componentsJson
  ) {
    if (bundleId == null) {
      throw new AuraHandledException('Missing bundle record id.');
    }
    List<ComponentInput> components = new List<ComponentInput>();
    if (!String.isBlank(componentsJson)) {
      try {
        components = (List<ComponentInput>) JSON.deserialize(
          componentsJson,
          List<ComponentInput>.class
        );
      } catch (JSONException jsonError) {
        throw new AuraHandledException(
          'The component list could not be read. Reload and try again.'
        );
      }
      if (components == null) {
        components = new List<ComponentInput>();
      }
    }

    Map<Id, BundleComponent__c> existingById = new Map<Id, BundleComponent__c>(
      [
        SELECT Id, Product__c, Quantity__c, Spread_Price__c
        FROM BundleComponent__c
        WHERE Bundle__c = :bundleId
      ]
    );

    List<BundleComponent__c> toUpsert = new List<BundleComponent__c>();
    Set<Id> keptIds = new Set<Id>();

    for (ComponentInput input : components) {
      if (input == null) {
        throw new AuraHandledException(
          'The component list contains an empty row. Reload and try again.'
        );
      }
      Decimal spread = input.spreadPrice == null ? 0 : input.spreadPrice;
      Decimal quantity = (input.quantity == null ||
        input.quantity < 1)
        ? 1
        : input.quantity;
      Id componentId = String.isBlank(input.id) ? null : (Id) input.id;
      Id productId = String.isBlank(input.productId)
        ? null
        : (Id) input.productId;

      // A row that would be inserted without a product trips the Product_Required rule,
      // whose message gives no clue which row is at fault. Say so precisely instead.
      Boolean isExisting =
        componentId != null && existingById.containsKey(componentId);
      if (!isExisting && productId == null) {
        throw new AuraHandledException(
          'A component row arrived without a product (id=' +
            input.id +
            ', quantity=' +
            quantity +
            ', spread=' +
            spread +
            '). This is a bug in the configurator, not your data - please report it.'
        );
      }

      if (isExisting) {
        keptIds.add(componentId);
        BundleComponent__c existing = existingById.get(componentId);
        if (
          existing.Spread_Price__c != spread ||
          existing.Quantity__c != quantity
        ) {
          toUpsert.add(
            new BundleComponent__c(
              Id = componentId,
              Quantity__c = quantity,
              Spread_Price__c = spread
            )
          );
        }
      } else {
        toUpsert.add(
          new BundleComponent__c(
            Bundle__c = bundleId,
            Product__c = productId,
            Quantity__c = quantity,
            Spread_Price__c = spread
          )
        );
      }
    }

    List<BundleComponent__c> toDelete = new List<BundleComponent__c>();
    for (Id existingId : existingById.keySet()) {
      if (!keptIds.contains(existingId)) {
        toDelete.add(existingById.get(existingId));
      }
    }

    if (!toDelete.isEmpty()) {
      delete toDelete;
    }
    if (!toUpsert.isEmpty()) {
      upsert toUpsert;
    }

    return getBundleContext(bundleId);
  }

  private static Id getRecordTypeId(String developerName) {
    List<RecordType> recordTypes = [
      SELECT Id
      FROM RecordType
      WHERE SObjectType = 'Product2' AND DeveloperName = :developerName
      LIMIT 1
    ];

    return recordTypes.isEmpty() ? null : recordTypes[0].Id;
  }
}
