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
}
