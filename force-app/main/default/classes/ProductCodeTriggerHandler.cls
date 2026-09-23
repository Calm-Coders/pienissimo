/**
 * Keeps Product2.ProductCode in step with External_Product_Code__c.
 *
 * External_Product_Code__c is the article code's unique, case-insensitive
 * external id and the upsert key for the Mexal and WooCommerce integrations.
 * ProductCode is the human-facing copy - it is what layouts show and what
 * anything reading the standard field expects. This class copies the first into
 * the second so the two cannot drift.
 *
 * Uniqueness is NOT enforced here. The unique index on
 * External_Product_Code__c does that atomically at commit, including across
 * parallel Bulk API batches, which no trigger can guarantee.
 *
 * No SOQL and no DML - a before-save assignment, so it costs nothing in bulk.
 */
public without sharing class ProductCodeTriggerHandler {
  public static void beforeInsert(List<Product2> newProducts) {
    syncProductCode(newProducts);
  }

  public static void beforeUpdate(List<Product2> newProducts) {
    syncProductCode(newProducts);
  }

  public static void afterInsert(List<Product2> newProducts) {
    createStandardPricebookEntries(newProducts);
  }

  private static void syncProductCode(List<Product2> newProducts) {
    for (Product2 productRec : newProducts) {
      String externalCode = productRec.External_Product_Code__c;

      // A blank external code leaves ProductCode as it is rather than clearing
      // it. This is a one-way copy, not a mirror, so it never destroys a value
      // that was set by hand or by an older import.
      if (String.isBlank(externalCode)) {
        continue;
      }

      if (productRec.ProductCode != externalCode) {
        productRec.ProductCode = externalCode;
      }
    }
  }

  private static void createStandardPricebookEntries(
    List<Product2> newProducts
  ) {
    if (newProducts.isEmpty()) {
      return;
    }

    Id standardPricebookId = [
      SELECT Id
      FROM Pricebook2
      WHERE IsStandard = TRUE
      LIMIT 1
    ]
    .Id;

    Set<Id> productIds = new Map<Id, Product2>(newProducts).keySet();
    Set<Id> productsWithStandardEntry = new Set<Id>();
    for (PricebookEntry existingEntry : [
      SELECT Product2Id
      FROM PricebookEntry
      WHERE Pricebook2Id = :standardPricebookId AND Product2Id IN :productIds
    ]) {
      productsWithStandardEntry.add(existingEntry.Product2Id);
    }

    List<PricebookEntry> entriesToInsert = new List<PricebookEntry>();
    for (Product2 productRec : newProducts) {
      if (productsWithStandardEntry.contains(productRec.Id)) {
        continue;
      }

      entriesToInsert.add(
        new PricebookEntry(
          Pricebook2Id = standardPricebookId,
          Product2Id = productRec.Id,
          UnitPrice = 0,
          IsActive = true
        )
      );
    }

    if (!entriesToInsert.isEmpty()) {
      insert entriesToInsert;
    }
  }
}
