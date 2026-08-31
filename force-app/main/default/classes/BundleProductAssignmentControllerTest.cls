@isTest
private class BundleProductAssignmentControllerTest {
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
      Code__c = 'TEST-BUNDLE-' + name.replace(' ', '-'),
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
      Code__c = code,
      ProductCode = code,
      IsActive = true,
      RecordTypeId = recordTypeId('Item'),
      Product_Price__c = listPrice
    );
  }

  private static BundleProductAssignmentController.ComponentInput input(
    Id componentId,
    Id productId,
    Decimal spread
  ) {
    return input(componentId, productId, spread, 1);
  }

  private static BundleProductAssignmentController.ComponentInput input(
    Id componentId,
    Id productId,
    Decimal spread,
    Decimal quantity
  ) {
    BundleProductAssignmentController.ComponentInput row = new BundleProductAssignmentController.ComponentInput();
    row.id = componentId;
    row.productId = productId;
    row.spreadPrice = spread;
    row.quantity = quantity;
    return row;
  }

  private static BundleProductAssignmentController.BundleContext save(
    Id bundleId,
    List<BundleProductAssignmentController.ComponentInput> components
  ) {
    return BundleProductAssignmentController.saveComponents(
      bundleId,
      components == null ? null : JSON.serialize(components)
    );
  }

  @isTest
  static void saveComponentsAddsRepricesAndUnlinks() {
    Product2 bundle = makeBundle('Stage bundle', 1000);
    insert bundle;
    Product2 first = makeItem('Item A', 'TEST-A', 600);
    Product2 second = makeItem('Item B', 'TEST-B', 500);
    Product2 third = makeItem('Item C', 'TEST-C', 400);
    insert new List<Product2>{ first, second, third };

    Test.startTest();
    // Add two components.
    BundleProductAssignmentController.BundleContext afterAdd = save(
      bundle.Id,
      new List<BundleProductAssignmentController.ComponentInput>{
        input(null, first.Id, 600),
        input(null, second.Id, 400)
      }
    );
    System.assertEquals(
      2,
      afterAdd.components.size(),
      'Both components should be linked'
    );
    System.assertEquals(
      1000,
      afterAdd.spreadTotal,
      'Spreads should sum to the fixed price'
    );
    System.assertEquals(0, afterAdd.variance, 'Bundle should reconcile');

    // Reprice the first, drop the second, add the third.
    Id firstComponentId;
    for (
      BundleProductAssignmentController.ComponentRow row : afterAdd.components
    ) {
      if (row.productId == first.Id) {
        firstComponentId = row.id;
      }
    }

    BundleProductAssignmentController.BundleContext afterEdit = save(
      bundle.Id,
      new List<BundleProductAssignmentController.ComponentInput>{
        input(firstComponentId, first.Id, 700),
        input(null, third.Id, 300)
      }
    );
    Test.stopTest();

    System.assertEquals(
      2,
      afterEdit.components.size(),
      'Dropped component should be unlinked'
    );
    System.assertEquals(
      1000,
      afterEdit.spreadTotal,
      'Bundle should still reconcile'
    );

    Map<Id, Decimal> spreadByProduct = new Map<Id, Decimal>();
    for (
      BundleProductAssignmentController.ComponentRow row : afterEdit.components
    ) {
      spreadByProduct.put(row.productId, row.spreadPrice);
    }
    System.assertEquals(
      700,
      spreadByProduct.get(first.Id),
      'First should be repriced'
    );
    System.assertEquals(
      300,
      spreadByProduct.get(third.Id),
      'Third should be added'
    );
    System.assert(
      !spreadByProduct.containsKey(second.Id),
      'Second should be gone'
    );
  }

  @isTest
  static void searchOffersProductsHeldByOtherBundlesButNotThisOne() {
    Product2 stage = makeBundle('Stage bundle', 1000);
    Product2 summer = makeBundle('Promo Summer', 1990);
    insert new List<Product2>{ stage, summer };
    Product2 shared = makeItem('Un anno con Pienissimo', 'TEST-SHARED', 900);
    Product2 free = makeItem('Camerieri Venditori', 'TEST-FREE', 400);
    insert new List<Product2>{ shared, free };

    insert new BundleComponent__c(
      Bundle__c = summer.Id,
      Product__c = shared.Id,
      Spread_Price__c = 850
    );

    Test.startTest();
    List<BundleProductAssignmentController.ItemOption> offered = BundleProductAssignmentController.searchItems(
      stage.Id,
      null
    );
    Test.stopTest();

    Set<Id> offeredIds = new Set<Id>();
    for (BundleProductAssignmentController.ItemOption option : offered) {
      offeredIds.add(option.id);
    }

    // The whole point of the junction: a product already in another bundle stays available.
    System.assert(
      offeredIds.contains(shared.Id),
      'A product held by another bundle must still be offered'
    );
    System.assert(
      offeredIds.contains(free.Id),
      'An unused product must be offered'
    );

    insert new BundleComponent__c(
      Bundle__c = stage.Id,
      Product__c = shared.Id,
      Spread_Price__c = 700
    );
    Set<Id> afterLinkIds = new Set<Id>();
    for (
      BundleProductAssignmentController.ItemOption option : BundleProductAssignmentController.searchItems(
        stage.Id,
        null
      )
    ) {
      afterLinkIds.add(option.id);
    }
    System.assert(
      !afterLinkIds.contains(shared.Id),
      'A product already in THIS bundle must not be offered again'
    );
  }

  @isTest
  static void searchFiltersByNameOrCode() {
    Product2 bundle = makeBundle('Stage bundle', 1000);
    insert bundle;
    insert new List<Product2>{
      makeItem('Pienissimo Live', 'TEST-LIVE', 600),
      makeItem('Food Marketing Festival', 'TEST-FMF', 300)
    };

    Test.startTest();
    List<BundleProductAssignmentController.ItemOption> byName = BundleProductAssignmentController.searchItems(
      bundle.Id,
      'Pienissimo'
    );
    List<BundleProductAssignmentController.ItemOption> byCode = BundleProductAssignmentController.searchItems(
      bundle.Id,
      'TEST-FMF'
    );
    Test.stopTest();

    System.assertEquals(
      1,
      byName.size(),
      'Name search should match one product'
    );
    System.assertEquals('Pienissimo Live', byName[0].name);
    System.assertEquals(
      1,
      byCode.size(),
      'Code search should match one product'
    );
    System.assertEquals('TEST-FMF', byCode[0].productCode);
  }

  @isTest
  static void contextReportsDriftWhenSpreadsDoNotReconcile() {
    Product2 bundle = makeBundle('Stage bundle', 1000);
    insert bundle;
    Product2 item = makeItem('Item A', 'TEST-A', 600);
    insert item;
    insert new BundleComponent__c(
      Bundle__c = bundle.Id,
      Product__c = item.Id,
      Spread_Price__c = 400
    );

    Test.startTest();
    BundleProductAssignmentController.BundleContext context = BundleProductAssignmentController.getBundleContext(
      bundle.Id
    );
    Test.stopTest();

    System.assertEquals('Stage bundle', context.bundleName);
    System.assertEquals(1000, context.fixedPrice);
    System.assertEquals(400, context.spreadTotal);
    System.assertEquals(
      600,
      context.variance,
      'Unattributed remainder should surface'
    );
    System.assertEquals(
      600,
      context.components[0].listPrice,
      'List price formula should resolve'
    );
  }

  // The ACADEMY 2026 order sells several components in pairs, so the spread is a line
  // figure and the unit spread has to fall out of it.
  @isTest
  static void quantityIsCarriedAndDrivesUnitSpreadAndLineDiscount() {
    Product2 bundle = makeBundle('Academy', 9800);
    insert bundle;
    Product2 pair = makeItem(
      'Camerieri Venditori Executive',
      'TEST-CS-00001',
      1200
    );
    insert pair;

    Test.startTest();
    save(
      bundle.Id,
      new List<BundleProductAssignmentController.ComponentInput>{
        input(null, pair.Id, 1900, 2)
      }
    );
    Test.stopTest();

    BundleComponent__c saved = [
      SELECT
        Quantity__c,
        List_Price__c,
        Line_List_Price__c,
        Spread_Price__c,
        Unit_Spread__c,
        Discount_Pct__c
      FROM BundleComponent__c
      WHERE Bundle__c = :bundle.Id
    ];
    System.assertEquals(2, saved.Quantity__c, 'Quantity should persist');
    System.assertEquals(
      2400,
      saved.Line_List_Price__c,
      'Line list = list x qty'
    );
    System.assertEquals(
      1900,
      saved.Spread_Price__c,
      'Spread is the line figure'
    );
    System.assertEquals(
      950,
      saved.Unit_Spread__c,
      'Unit spread = line spread / qty'
    );
    System.assertEquals(
      20.83,
      saved.Discount_Pct__c.setScale(2),
      'Discount must compare the spread against the LINE list price, not the unit price'
    );

    BundleProductAssignmentController.BundleContext context = BundleProductAssignmentController.getBundleContext(
      bundle.Id
    );
    System.assertEquals(
      2,
      context.components[0].quantity,
      'Quantity should reach the UI'
    );
  }

  @isTest
  static void quantityDefaultsToOneWhenAbsentOrInvalid() {
    Product2 bundle = makeBundle('Stage bundle', 1000);
    insert bundle;
    Product2 item = makeItem('Item A', 'TEST-A', 500);
    insert item;

    Test.startTest();
    BundleProductAssignmentController.BundleContext context = save(
      bundle.Id,
      new List<BundleProductAssignmentController.ComponentInput>{
        input(null, item.Id, 400, 0)
      }
    );
    Test.stopTest();

    System.assertEquals(
      1,
      context.components[0].quantity,
      'A quantity below one must fall back to one rather than blow up the unit spread'
    );
  }

  @isTest
  static void missingBundleIdIsRejected() {
    Test.startTest();
    Integer failures = 0;
    try {
      BundleProductAssignmentController.getBundleContext(null);
    } catch (Exception e) {
      failures++;
    }
    try {
      BundleProductAssignmentController.searchItems(null, null);
    } catch (Exception e) {
      failures++;
    }
    try {
      save(null, null);
    } catch (Exception e) {
      failures++;
    }
    Test.stopTest();

    System.assertEquals(
      3,
      failures,
      'All three entry points should reject a null bundle id'
    );
  }
}
