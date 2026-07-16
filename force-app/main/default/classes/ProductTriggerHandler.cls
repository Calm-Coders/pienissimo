/**
 * DEPRECATED (2026-07-16) — superseded by BundleComponent__c and BundleComponentTriggerHandler.
 *
 * This class maintains Calculated_Bundle_Price__c by summing the list prices of the products
 * hanging off Product2.Parent__c. That model was retired when the junction was accepted:
 * it allows a product in only one bundle, cannot hold a per-bundle spread price, and computes
 * the bundle price upward from its components instead of spreading a fixed price downward.
 *
 * ProductTrigger is deactivated, so nothing here runs. Code and fields are kept in place for
 * review before deletion; do not extend this class.
 */
public with sharing class ProductTriggerHandler {
  public static void handleAfterInsert(List<Product2> newProducts) {
    recalculateBundlePrices(collectParentIds(newProducts));
  }

  public static void handleAfterUpdate(
    List<Product2> newProducts,
    Map<Id, Product2> oldMap
  ) {
    Set<Id> affectedBundleIds = new Set<Id>();

    for (Product2 newProduct : newProducts) {
      Product2 oldProduct = oldMap.get(newProduct.Id);
      if (
        newProduct.Parent__c != oldProduct.Parent__c ||
        newProduct.Product_Price__c != oldProduct.Product_Price__c
      ) {
        if (newProduct.Parent__c != null) {
          affectedBundleIds.add(newProduct.Parent__c);
        }
        if (oldProduct.Parent__c != null) {
          affectedBundleIds.add(oldProduct.Parent__c);
        }
      }
    }

    recalculateBundlePrices(affectedBundleIds);
  }

  public static void handleAfterDelete(List<Product2> oldProducts) {
    recalculateBundlePrices(collectParentIds(oldProducts));
  }

  public static void handleAfterUndelete(List<Product2> newProducts) {
    recalculateBundlePrices(collectParentIds(newProducts));
  }

  private static Set<Id> collectParentIds(List<Product2> products) {
    Set<Id> parentIds = new Set<Id>();
    for (Product2 product : products) {
      if (product.Parent__c != null) {
        parentIds.add(product.Parent__c);
      }
    }
    return parentIds;
  }

  private static void recalculateBundlePrices(Set<Id> candidateBundleIds) {
    if (candidateBundleIds.isEmpty()) {
      return;
    }

    Id bundleRecordTypeId = getBundleRecordTypeId();
    if (bundleRecordTypeId == null) {
      return;
    }

    Map<Id, Product2> bundlesById = new Map<Id, Product2>(
      [
        SELECT Id
        FROM Product2
        WHERE Id IN :candidateBundleIds AND RecordTypeId = :bundleRecordTypeId
      ]
    );

    if (bundlesById.isEmpty()) {
      return;
    }

    Map<Id, Decimal> bundleTotalsById = new Map<Id, Decimal>();
    for (AggregateResult ar : [
      SELECT Parent__c parentId, SUM(Product_Price__c) totalPrice
      FROM Product2
      WHERE Parent__c IN :bundlesById.keySet()
      GROUP BY Parent__c
    ]) {
      bundleTotalsById.put(
        (Id) ar.get('parentId'),
        (Decimal) ar.get('totalPrice')
      );
    }

    List<Product2> productsToUpdate = new List<Product2>();
    for (Id bundleId : bundlesById.keySet()) {
      productsToUpdate.add(
        new Product2(
          Id = bundleId,
          Calculated_Bundle_Price__c = bundleTotalsById.containsKey(bundleId)
            ? bundleTotalsById.get(bundleId)
            : 0
        )
      );
    }

    if (!productsToUpdate.isEmpty()) {
      update productsToUpdate;
    }
  }

  private static Id getBundleRecordTypeId() {
    List<RecordType> bundleRecordTypes = [
      SELECT Id
      FROM RecordType
      WHERE SObjectType = 'Product2' AND DeveloperName = 'Bundle'
      LIMIT 1
    ];

    return bundleRecordTypes.isEmpty() ? null : bundleRecordTypes[0].Id;
  }
}
