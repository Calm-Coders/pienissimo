@isTest
private class BundleComponentTriggerHandlerTest {
  private static Id recordTypeId(String developerName) {
    return [
      SELECT Id
      FROM RecordType
      WHERE SObjectType = 'Product2' AND DeveloperName = :developerName
      LIMIT 1
    ]
    .Id;
  }

  private static Product2 makeBundle(String name, Decimal sellingPrice) {
    return new Product2(
      Name = name,
      IsActive = true,
      RecordTypeId = recordTypeId('Bundle'),
      Bundle_Selling_Price__c = sellingPrice
    );
  }

  private static Product2 makeItem(
    String name,
    String code,
    Decimal listPrice
  ) {
    return new Product2(
      Name = name,
      ProductCode = code,
      IsActive = true,
      RecordTypeId = recordTypeId('Item'),
      Product_Price__c = listPrice
    );
  }

  @isTest
  static void sharedProductCarriesADifferentSpreadInEachBundle() {
    Product2 stageBundle = makeBundle('Stage bundle', 1000);
    Product2 summerBundle = makeBundle('Promo Summer', 1990);
    insert new List<Product2>{ stageBundle, summerBundle };

    Product2 sharedItem = makeItem(
      'Un anno con Pienissimo',
      'TEST-SHARED',
      900
    );
    Product2 otherItem = makeItem('Camerieri Venditori', 'TEST-OTHER', 400);
    insert new List<Product2>{ sharedItem, otherItem };

    Test.startTest();
    insert new List<BundleComponent__c>{
      new BundleComponent__c(
        Bundle__c = stageBundle.Id,
        Product__c = sharedItem.Id,
        Spread_Price__c = 700
      ),
      new BundleComponent__c(
        Bundle__c = stageBundle.Id,
        Product__c = otherItem.Id,
        Spread_Price__c = 300
      ),
      new BundleComponent__c(
        Bundle__c = summerBundle.Id,
        Product__c = sharedItem.Id,
        Spread_Price__c = 1590
      ),
      new BundleComponent__c(
        Bundle__c = summerBundle.Id,
        Product__c = otherItem.Id,
        Spread_Price__c = 400
      )
    };
    Test.stopTest();

    Map<Id, Product2> bundles = new Map<Id, Product2>(
      [
        SELECT Id, Spread_Total__c, Spread_Variance__c
        FROM Product2
        WHERE Id IN (:stageBundle.Id, :summerBundle.Id)
      ]
    );

    System.assertEquals(
      1000,
      bundles.get(stageBundle.Id).Spread_Total__c,
      'Stage bundle spreads should sum to its fixed selling price'
    );
    System.assertEquals(
      1990,
      bundles.get(summerBundle.Id).Spread_Total__c,
      'Summer bundle spreads should sum to its fixed selling price'
    );
    System.assertEquals(
      0,
      bundles.get(stageBundle.Id).Spread_Variance__c,
      'A reconciled bundle should show zero variance'
    );

    // The point of the junction: one product, two bundles, two different spreads.
    List<BundleComponent__c> shared = [
      SELECT Spread_Price__c
      FROM BundleComponent__c
      WHERE Product__c = :sharedItem.Id
      ORDER BY Spread_Price__c
    ];
    System.assertEquals(
      2,
      shared.size(),
      'Shared product should belong to both bundles'
    );
    System.assertEquals(700, shared[0].Spread_Price__c);
    System.assertEquals(1590, shared[1].Spread_Price__c);
  }

  @isTest
  static void spreadTotalFollowsEditsAndDeletes() {
    Product2 bundle = makeBundle('Stage bundle', 1000);
    insert bundle;
    Product2 item = makeItem('Item A', 'TEST-A', 500);
    Product2 secondItem = makeItem('Item B', 'TEST-B', 500);
    insert new List<Product2>{ item, secondItem };

    BundleComponent__c first = new BundleComponent__c(
      Bundle__c = bundle.Id,
      Product__c = item.Id,
      Spread_Price__c = 400
    );
    BundleComponent__c second = new BundleComponent__c(
      Bundle__c = bundle.Id,
      Product__c = secondItem.Id,
      Spread_Price__c = 600
    );
    insert new List<BundleComponent__c>{ first, second };

    Test.startTest();
    first.Spread_Price__c = 450;
    update first;
    System.assertEquals(
      1050,
      [SELECT Spread_Total__c FROM Product2 WHERE Id = :bundle.Id]
      .Spread_Total__c,
      'Total should follow a spread edit'
    );

    delete second;
    Test.stopTest();

    System.assertEquals(
      450,
      [SELECT Spread_Total__c FROM Product2 WHERE Id = :bundle.Id]
      .Spread_Total__c,
      'Total should follow a component deletion'
    );
  }

  @isTest
  static void sameProductTwiceInOneBundleIsRejected() {
    Product2 bundle = makeBundle('Stage bundle', 1000);
    insert bundle;
    Product2 item = makeItem('Item A', 'TEST-A', 500);
    insert item;

    insert new BundleComponent__c(
      Bundle__c = bundle.Id,
      Product__c = item.Id,
      Spread_Price__c = 400
    );

    Test.startTest();
    Boolean rejected = false;
    try {
      insert new BundleComponent__c(
        Bundle__c = bundle.Id,
        Product__c = item.Id,
        Spread_Price__c = 600
      );
    } catch (DmlException e) {
      rejected = true;
      System.assert(
        e.getMessage().contains('already a component of this bundle'),
        'Expected the duplicate guard to fire, got: ' + e.getMessage()
      );
    }
    Test.stopTest();

    System.assert(
      rejected,
      'Adding the same product twice to one bundle should be rejected'
    );
  }
}
