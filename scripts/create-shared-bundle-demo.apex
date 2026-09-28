// Idempotent demo data for showing that one Item can belong to multiple bundles.
Map<String, Product2> itemsByCode = new Map<String, Product2>();
for (Product2 item : [
  SELECT Id, Name, ProductCode
  FROM Product2
  WHERE ProductCode IN ('CS-00003', 'CS-00004', 'CS-00157', 'CS-00007', 'CS-00009')
  AND RecordType.DeveloperName = 'Item'
]) {
  itemsByCode.put(item.ProductCode, item);
}

Set<String> requiredItemCodes = new Set<String>{
  'CS-00003',
  'CS-00004',
  'CS-00157',
  'CS-00007',
  'CS-00009'
};
if (!itemsByCode.keySet().containsAll(requiredItemCodes)) {
  requiredItemCodes.removeAll(itemsByCode.keySet());
  throw new IllegalArgumentException(
    'Missing Item products required by the shared-bundle demo: ' +
    String.join(new List<String>(requiredItemCodes), ', ')
  );
}

Id bundleRecordTypeId = Product2.SObjectType.getDescribe()
  .getRecordTypeInfosByDeveloperName()
  .get('Bundle')
  .getRecordTypeId();

Map<String, Product2> bundlesByCode = new Map<String, Product2>();
for (Product2 bundle : [
  SELECT Id, Name, ProductCode, Bundle_Selling_Price__c
  FROM Product2
  WHERE ProductCode IN ('DEMO-SHARED-START', 'DEMO-SHARED-GROWTH')
]) {
  bundlesByCode.put(bundle.ProductCode, bundle);
}

List<Product2> bundles = new List<Product2>();
bundles.add(
  new Product2(
    Id = bundlesByCode.get('DEMO-SHARED-START')?.Id,
    Name = 'DEMO - START PIENISSIMO (ITEM CONDIVISI)',
    ProductCode = 'DEMO-SHARED-START',
    IsActive = true,
    RecordTypeId = bundleRecordTypeId,
    Bundle_Selling_Price__c = 3000
  )
);
bundles.add(
  new Product2(
    Id = bundlesByCode.get('DEMO-SHARED-GROWTH')?.Id,
    Name = 'DEMO - GROWTH PIENISSIMO (ITEM CONDIVISI)',
    ProductCode = 'DEMO-SHARED-GROWTH',
    IsActive = true,
    RecordTypeId = bundleRecordTypeId,
    Bundle_Selling_Price__c = 4200
  )
);
upsert bundles;

Map<String, Id> bundleIdsByCode = new Map<String, Id>();
for (Product2 bundle : bundles) {
  bundleIdsByCode.put(bundle.ProductCode, bundle.Id);
}

delete [
  SELECT Id
  FROM BundleComponent__c
  WHERE Bundle__c IN :bundleIdsByCode.values()
];

List<BundleComponent__c> components = new List<BundleComponent__c>{
  // Shared by both bundles.
  new BundleComponent__c(
    Bundle__c = bundleIdsByCode.get('DEMO-SHARED-START'),
    Product__c = itemsByCode.get('CS-00003').Id,
    Quantity__c = 1,
    Spread_Price__c = 1500
  ),
  new BundleComponent__c(
    Bundle__c = bundleIdsByCode.get('DEMO-SHARED-GROWTH'),
    Product__c = itemsByCode.get('CS-00003').Id,
    Quantity__c = 1,
    Spread_Price__c = 2300
  ),
  new BundleComponent__c(
    Bundle__c = bundleIdsByCode.get('DEMO-SHARED-START'),
    Product__c = itemsByCode.get('CS-00004').Id,
    Quantity__c = 1,
    Spread_Price__c = 800
  ),
  new BundleComponent__c(
    Bundle__c = bundleIdsByCode.get('DEMO-SHARED-GROWTH'),
    Product__c = itemsByCode.get('CS-00004').Id,
    Quantity__c = 1,
    Spread_Price__c = 1000
  ),
  new BundleComponent__c(
    Bundle__c = bundleIdsByCode.get('DEMO-SHARED-START'),
    Product__c = itemsByCode.get('CS-00157').Id,
    Quantity__c = 1,
    Spread_Price__c = 25
  ),
  new BundleComponent__c(
    Bundle__c = bundleIdsByCode.get('DEMO-SHARED-GROWTH'),
    Product__c = itemsByCode.get('CS-00157').Id,
    Quantity__c = 1,
    Spread_Price__c = 25
  ),
  // One item unique to each bundle.
  new BundleComponent__c(
    Bundle__c = bundleIdsByCode.get('DEMO-SHARED-START'),
    Product__c = itemsByCode.get('CS-00007').Id,
    Quantity__c = 1,
    Spread_Price__c = 675
  ),
  new BundleComponent__c(
    Bundle__c = bundleIdsByCode.get('DEMO-SHARED-GROWTH'),
    Product__c = itemsByCode.get('CS-00009').Id,
    Quantity__c = 1,
    Spread_Price__c = 875
  )
};
insert components;

System.debug(
  LoggingLevel.INFO,
  'Created shared-bundle demo: ' + JSON.serialize(bundleIdsByCode)
);
