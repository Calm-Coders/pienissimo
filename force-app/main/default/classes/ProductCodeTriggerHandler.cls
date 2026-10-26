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
 * The code copy is a before-save assignment with no SOQL and no DML. After
 * save, the standard price book entry follows Price_1__c (Mexal listino 1, the
 * only listino in use): it is created at that price and updated when it
 * changes, so quotes and orders price the article as Mexal does.
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

  public static void afterUpdate(
    List<Product2> newProducts,
    Map<Id, Product2> oldProductsById
  ) {
    updateStandardPricebookEntries(newProducts, oldProductsById);
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

    Id standardPricebookId = getStandardPricebookId();
    if (standardPricebookId == null) {
      return;
    }

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
          UnitPrice = productRec.Price_1__c == null ? 0 : productRec.Price_1__c,
          IsActive = true
        )
      );
    }

    if (!entriesToInsert.isEmpty()) {
      insert entriesToInsert;
    }
  }

  // A cleared Price_1__c leaves the entry as it is: a blank price is missing
  // data, not a price of zero. Omaggi are zero in Mexal, so they stay zero.
  private static void updateStandardPricebookEntries(
    List<Product2> newProducts,
    Map<Id, Product2> oldProductsById
  ) {
    Map<Id, Decimal> newPriceByProductId = new Map<Id, Decimal>();
    for (Product2 productRec : newProducts) {
      Decimal newPrice = productRec.Price_1__c;
      if (
        newPrice != null &&
        newPrice != oldProductsById.get(productRec.Id).Price_1__c
      ) {
        newPriceByProductId.put(productRec.Id, newPrice);
      }
    }

    if (newPriceByProductId.isEmpty()) {
      return;
    }

    Id standardPricebookId = getStandardPricebookId();
    if (standardPricebookId == null) {
      return;
    }

    List<PricebookEntry> entriesToUpdate = new List<PricebookEntry>();
    for (PricebookEntry entry : [
      SELECT Id, Product2Id, UnitPrice
      FROM PricebookEntry
      WHERE
        Pricebook2Id = :standardPricebookId
        AND Product2Id IN :newPriceByProductId.keySet()
    ]) {
      Decimal newPrice = newPriceByProductId.get(entry.Product2Id);
      if (entry.UnitPrice != newPrice) {
        entry.UnitPrice = newPrice;
        entriesToUpdate.add(entry);
      }
    }

    if (!entriesToUpdate.isEmpty()) {
      update entriesToUpdate;
    }
  }

  private static Id getStandardPricebookId() {
    if (Test.isRunningTest()) {
      return Test.getStandardPricebookId();
    }

    List<Pricebook2> pricebooks = [
      SELECT Id
      FROM Pricebook2
      WHERE IsStandard = TRUE
      LIMIT 1
    ];

    return pricebooks.isEmpty() ? null : pricebooks[0].Id;
  }
}
