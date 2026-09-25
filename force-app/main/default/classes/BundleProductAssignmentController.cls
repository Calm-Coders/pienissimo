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
    @AuraEnabled
    public Boolean bundleOnly;
    @AuraEnabled
    public Boolean generatesTicket;

    public ItemOption(Product2 product) {
      id = product.Id;
      name = product.Name;
      productCode = product.ProductCode;
      productPrice = null;
    }
  }

  public class ProductSearchPage {
    @AuraEnabled
    public List<ItemOption> items = new List<ItemOption>();
    @AuraEnabled
    public Boolean hasMore;
    @AuraEnabled
    public Id nextCursor;
  }

  // Keyset pagination keeps every matching item reachable without an OFFSET cap.
  // Exclusions come from the draft, so removed memberships can be selected again.
  @AuraEnabled
  public static ProductSearchPage searchProducts(
    String searchTerm,
    Boolean bundleOnly,
    Boolean generatesTicket,
    List<Id> excludedProductIds,
    Id afterId
  ) {
    Set<Id> excludedIds = excludedProductIds == null
      ? new Set<Id>()
      : new Set<Id>(excludedProductIds);
    String term =
      '%' +
      (String.isBlank(searchTerm) ? '' : searchTerm.trim()) +
      '%';
    String queryText =
      'SELECT Id, Name, ProductCode, ' +
      'Solo_Bundle__c, Genera_Biglietto__c FROM Product2 ' +
      'WHERE RecordType.DeveloperName = \'Item\' AND IsActive = TRUE ' +
      'AND Id NOT IN :excludedIds ' +
      'AND (ProductCode LIKE :term OR Name LIKE :term)';
    if (bundleOnly != null) {
      queryText += ' AND Solo_Bundle__c = :bundleOnly';
    }
    if (generatesTicket != null) {
      queryText += ' AND Genera_Biglietto__c = :generatesTicket';
    }
    if (afterId != null) {
      queryText += ' AND Id > :afterId';
    }
    queryText += ' ORDER BY Id LIMIT 51';
    List<Product2> products = Database.query(queryText);
    ProductSearchPage result = new ProductSearchPage();
    result.hasMore = products.size() > 50;
    Set<Id> productIds = new Set<Id>();
    for (Product2 product : products) {
      productIds.add(product.Id);
    }
    Map<Id, Decimal> standardPrices = standardPricesByProduct(productIds);
    for (Integer index = 0; index < Math.min(products.size(), 50); index++) {
      Product2 product = products[index];
      ItemOption option = new ItemOption(product);
      option.productPrice = standardPrices.get(product.Id);
      option.bundleOnly = product.Solo_Bundle__c;
      option.generatesTicket = product.Genera_Biglietto__c;
      result.items.add(option);
      result.nextCursor = product.Id;
    }
    return result;
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
      listPrice = null;
      spreadPrice = component.Spread_Price__c;
    }
  }

  public class BundleContext {
    @AuraEnabled
    public String bundleName;
    @AuraEnabled
    public Decimal fixedPrice;
    @AuraEnabled
    public Decimal calculatedBundlePrice;
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
        Calculated_Bundle_Price__c,
        Spread_Total__c,
        Spread_Variance__c
      FROM Product2
      WHERE Id = :bundleId
      LIMIT 1
    ];

    BundleContext context = new BundleContext();
    context.bundleName = bundle.Name;
    context.fixedPrice = bundle.Bundle_Selling_Price__c;
    context.calculatedBundlePrice = bundle.Calculated_Bundle_Price__c == null
      ? bundle.Spread_Total__c
      : bundle.Calculated_Bundle_Price__c;
    context.spreadTotal = bundle.Spread_Total__c;
    context.variance = bundle.Spread_Variance__c;
    context.components = new List<ComponentRow>();

    List<BundleComponent__c> components = [
      SELECT
        Id,
        Product__c,
        Product__r.Name,
        Product__r.ProductCode,
        Quantity__c,
        Spread_Price__c
      FROM BundleComponent__c
      WHERE Bundle__c = :bundleId
      ORDER BY Product__r.Name
    ];
    Set<Id> componentProductIds = new Set<Id>();
    for (BundleComponent__c component : components) {
      componentProductIds.add(component.Product__c);
    }
    Map<Id, Decimal> standardPrices = standardPricesByProduct(
      componentProductIds
    );
    for (BundleComponent__c component : components) {
      ComponentRow row = new ComponentRow(component);
      row.listPrice = standardPrices.get(component.Product__c);
      context.components.add(row);
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
          SELECT Id, Name, ProductCode
          FROM Product2
          WHERE
            RecordTypeId = :itemRecordTypeId
            AND IsActive = TRUE
            AND Id NOT IN :alreadyLinked
          ORDER BY Name
          LIMIT :MAX_RESULTS
        ]
      : [
          SELECT Id, Name, ProductCode
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
    Set<Id> productIds = new Set<Id>();
    for (Product2 product : products) {
      productIds.add(product.Id);
    }
    Map<Id, Decimal> standardPrices = standardPricesByProduct(productIds);
    for (Product2 product : products) {
      ItemOption option = new ItemOption(product);
      option.productPrice = standardPrices.get(product.Id);
      results.add(option);
    }
    return results;
  }

  // Reconciles the bundle's components to exactly what the UI submitted:
  // rows without an id are added, existing rows are re-priced, missing rows are unlinked.
  @AuraEnabled
  public static BundleContext saveComponents(
    Id bundleId,
    Decimal fixedPrice,
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
      if (input.spreadPrice == null) {
        throw new AuraHandledException(
          'Inserisci lo sconto o il prezzo totale della riga per ogni prodotto.'
        );
      }
      Decimal spread = input.spreadPrice;
      Decimal quantity = (input.quantity == null ||
        input.quantity < 1)
        ? 1
        : input.quantity;
      if (
        quantity != quantity.setScale(0) ||
        spread < 0 ||
        spread != spread.setScale(2)
      ) {
        throw new AuraHandledException(
          'Inserisci una quantita intera positiva e un importo non negativo con massimo due decimali.'
        );
      }
      Id componentId = String.isBlank(input.id) ? null : (Id) input.id;
      Id productId = String.isBlank(input.productId)
        ? null
        : (Id) input.productId;

      // A row that would be inserted without a product trips the Product_Required rule,
      // whose message gives no clue which row is at fault. Say so precisely instead.
      Boolean isExisting =
        componentId != null && existingById.containsKey(componentId);
      if (componentId != null && !isExisting) {
        throw new AuraHandledException(
          'Una riga non appartiene a questo bundle. Ricarica la pagina.'
        );
      }
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

  private static Map<Id, Decimal> standardPricesByProduct(Set<Id> productIds) {
    Map<Id, Decimal> prices = new Map<Id, Decimal>();
    if (productIds.isEmpty()) {
      return prices;
    }
    for (PricebookEntry entry : [
      SELECT Product2Id, UnitPrice
      FROM PricebookEntry
      WHERE
        Product2Id IN :productIds
        AND Pricebook2.IsStandard = TRUE
        AND IsActive = TRUE
    ]) {
      prices.put(entry.Product2Id, entry.UnitPrice);
    }
    return prices;
  }
}
