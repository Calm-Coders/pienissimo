public with sharing class BundleComponentTriggerHandler {
  public static void handleAfterInsert(List<BundleComponent__c> newComponents) {
    rejectDuplicateProducts(newComponents);
    recalculateSpreadTotals(collectBundleIds(newComponents, null));
  }

  public static void handleAfterUpdate(
    List<BundleComponent__c> newComponents,
    Map<Id, BundleComponent__c> oldMap
  ) {
    rejectDuplicateProducts(newComponents);
    recalculateSpreadTotals(collectBundleIds(newComponents, oldMap.values()));
  }

  public static void handleAfterDelete(List<BundleComponent__c> oldComponents) {
    recalculateSpreadTotals(collectBundleIds(oldComponents, null));
  }

  public static void handleAfterUndelete(
    List<BundleComponent__c> newComponents
  ) {
    rejectDuplicateProducts(newComponents);
    recalculateSpreadTotals(collectBundleIds(newComponents, null));
  }

  // A product may sit in many bundles, but only once within the same bundle —
  // otherwise its revenue would be double counted against that bundle.
  private static void rejectDuplicateProducts(
    List<BundleComponent__c> components
  ) {
    Set<Id> bundleIds = new Set<Id>();
    for (BundleComponent__c component : components) {
      bundleIds.add(component.Bundle__c);
    }

    Set<Id> incomingIds = new Set<Id>();
    for (BundleComponent__c component : components) {
      incomingIds.add(component.Id);
    }

    Map<Id, Set<Id>> existingProductsByBundle = new Map<Id, Set<Id>>();
    for (BundleComponent__c existing : [
      SELECT Id, Bundle__c, Product__c
      FROM BundleComponent__c
      WHERE Bundle__c IN :bundleIds AND Id NOT IN :incomingIds
    ]) {
      if (!existingProductsByBundle.containsKey(existing.Bundle__c)) {
        existingProductsByBundle.put(existing.Bundle__c, new Set<Id>());
      }
      existingProductsByBundle.get(existing.Bundle__c).add(existing.Product__c);
    }

    for (BundleComponent__c component : components) {
      Set<Id> taken = existingProductsByBundle.get(component.Bundle__c);
      if (taken == null) {
        taken = new Set<Id>();
        existingProductsByBundle.put(component.Bundle__c, taken);
      }
      if (taken.contains(component.Product__c)) {
        component.addError(
          'This product is already a component of this bundle. ' +
          'A product can belong to several bundles, but only once per bundle.'
        );
      } else {
        taken.add(component.Product__c);
      }
    }
  }

  private static Set<Id> collectBundleIds(
    List<BundleComponent__c> components,
    List<BundleComponent__c> priorVersions
  ) {
    Set<Id> bundleIds = new Set<Id>();
    for (BundleComponent__c component : components) {
      if (component.Bundle__c != null) {
        bundleIds.add(component.Bundle__c);
      }
    }
    if (priorVersions != null) {
      for (BundleComponent__c component : priorVersions) {
        if (component.Bundle__c != null) {
          bundleIds.add(component.Bundle__c);
        }
      }
    }
    return bundleIds;
  }

  private static void recalculateSpreadTotals(Set<Id> bundleIds) {
    if (bundleIds.isEmpty()) {
      return;
    }

    Map<Id, Decimal> totalsByBundleId = new Map<Id, Decimal>();
    for (Id bundleId : bundleIds) {
      totalsByBundleId.put(bundleId, 0);
    }

    for (AggregateResult row : [
      SELECT Bundle__c bundleId, SUM(Spread_Price__c) spreadTotal
      FROM BundleComponent__c
      WHERE Bundle__c IN :bundleIds
      GROUP BY Bundle__c
    ]) {
      totalsByBundleId.put(
        (Id) row.get('bundleId'),
        (Decimal) row.get('spreadTotal')
      );
    }

    List<Product2> bundlesToUpdate = new List<Product2>();
    for (Id bundleId : totalsByBundleId.keySet()) {
      bundlesToUpdate.add(
        new Product2(
          Id = bundleId,
          Spread_Total__c = totalsByBundleId.get(bundleId)
        )
      );
    }

    update bundlesToUpdate;
  }
}
