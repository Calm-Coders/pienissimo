@isTest
private class OrderBigliettoTriggerHandlerTest {
  private static Account makeAccount() {
    Account account = new Account(Name = 'Test Account');
    insert account;
    return account;
  }

  private static Product2 makeProduct(String name, Boolean generatesTicket) {
    return makeProduct(name, generatesTicket, null);
  }

  private static Product2 makeProduct(
    String name,
    Boolean generatesTicket,
    String recordTypeDeveloperName
  ) {
    Product2 product = new Product2(
      Name = name,
      ProductCode = 'TEST-' + name.replace(' ', '-'),
      IsActive = true,
      Genera_Biglietto__c = generatesTicket
    );

    if (recordTypeDeveloperName != null) {
      product.RecordTypeId = recordTypeId(recordTypeDeveloperName);
    }

    insert product;
    return product;
  }

  private static Id recordTypeId(String developerName) {
    return [
      SELECT Id
      FROM RecordType
      WHERE SObjectType = 'Product2' AND DeveloperName = :developerName
      LIMIT 1
    ]
    .Id;
  }

  private static Id assetTicketRecordTypeId() {
    return [
      SELECT Id
      FROM RecordType
      WHERE SObjectType = 'Asset' AND DeveloperName = 'Ticket'
      LIMIT 1
    ]
    .Id;
  }

  private static PricebookEntry makePricebookEntry(Product2 product) {
    Id pricebookId = Test.getStandardPricebookId();

    PricebookEntry entry = new PricebookEntry(
      Pricebook2Id = pricebookId,
      Product2Id = product.Id,
      UnitPrice = 100,
      IsActive = true
    );
    insert entry;
    return entry;
  }

  private static Order makeDraftOrder(Account account) {
    Order orderRecord = new Order(
      AccountId = account.Id,
      EffectiveDate = Date.today(),
      Status = 'Draft',
      Pricebook2Id = Test.getStandardPricebookId()
    );
    insert orderRecord;
    return orderRecord;
  }

  private static OrderItem makeOrderItem(
    Order orderRecord,
    PricebookEntry entry,
    Decimal quantity
  ) {
    OrderItem line = new OrderItem(
      OrderId = orderRecord.Id,
      PricebookEntryId = entry.Id,
      Quantity = quantity,
      UnitPrice = entry.UnitPrice
    );
    insert line;
    return line;
  }

  @isTest
  static void incassatoOrderCreatesTicketsForFlaggedProducts() {
    Account account = makeAccount();
    Product2 eventProduct = makeProduct('Pienissimo Live', true);
    Product2 ordinaryProduct = makeProduct('Manuale Operativo', false);
    PricebookEntry eventEntry = makePricebookEntry(eventProduct);
    PricebookEntry ordinaryEntry = makePricebookEntry(ordinaryProduct);
    Order orderRecord = makeDraftOrder(account);
    OrderItem eventLine = makeOrderItem(orderRecord, eventEntry, 3);
    OrderItem ordinaryLine = makeOrderItem(orderRecord, ordinaryEntry, 2);

    Test.startTest();
    orderRecord.Status = 'Incassato';
    update orderRecord;
    Test.stopTest();

    List<Asset> tickets = [
      SELECT
        Status,
        RecordTypeId,
        Product2Id,
        Order_Product__c,
        Fattura_Pagata__c
      FROM Asset
      WHERE Order_Product__c IN (:eventLine.Id, :ordinaryLine.Id)
      ORDER BY Name
    ];

    System.assertEquals(
      3,
      tickets.size(),
      'Only the flagged event product line should generate tickets'
    );

    for (Asset ticket : tickets) {
      System.assertEquals('Ordinato', ticket.Status);
      System.assertEquals(assetTicketRecordTypeId(), ticket.RecordTypeId);
      System.assertEquals(eventProduct.Id, ticket.Product2Id);
      System.assertEquals(eventLine.Id, ticket.Order_Product__c);
      System.assertEquals(false, ticket.Fattura_Pagata__c);
    }
  }

  @isTest
  static void repeatedIncassatoDoesNotCreateDuplicates() {
    Account account = makeAccount();
    Product2 eventProduct = makeProduct('Food Marketing Festival', true);
    PricebookEntry eventEntry = makePricebookEntry(eventProduct);
    Order orderRecord = makeDraftOrder(account);
    OrderItem eventLine = makeOrderItem(orderRecord, eventEntry, 2);

    orderRecord.Status = 'Incassato';
    update orderRecord;

    Test.startTest();
    update orderRecord;
    Test.stopTest();

    System.assertEquals(
      2,
      [
        SELECT COUNT()
        FROM Asset
        WHERE Order_Product__c = :eventLine.Id
      ],
      'Updating an already Incassato order must not create duplicate tickets'
    );
  }

  @isTest
  static void incassatoTopsUpOnlyMissingTickets() {
    Account account = makeAccount();
    Product2 eventProduct = makeProduct('Academy', true);
    PricebookEntry eventEntry = makePricebookEntry(eventProduct);
    Order orderRecord = makeDraftOrder(account);
    OrderItem eventLine = makeOrderItem(orderRecord, eventEntry, 2);

    insert new Asset(
      Name = 'Existing ticket',
      RecordTypeId = assetTicketRecordTypeId(),
      Status = 'Ordinato',
      AccountId = account.Id,
      Product2Id = eventProduct.Id,
      Order_Product__c = eventLine.Id
    );

    Test.startTest();
    orderRecord.Status = 'Incassato';
    update orderRecord;
    Test.stopTest();

    System.assertEquals(
      2,
      [
        SELECT COUNT()
        FROM Asset
        WHERE Order_Product__c = :eventLine.Id
      ],
      'Incassato should create only the missing tickets for the order line'
    );
  }

  @isTest
  static void bundleLineCreatesTicketsForFlaggedComponentsOnly() {
    Account account = makeAccount();
    Product2 bundle = makeProduct('Anno con Pienissimo', false, 'Bundle');
    Product2 eventComponent = makeProduct('Pienissimo Live', true, 'Item');
    Product2 nonEventComponent = makeProduct(
      'Manuale Operativo',
      false,
      'Item'
    );

    insert new List<BundleComponent__c>{
      new BundleComponent__c(
        Bundle__c = bundle.Id,
        Product__c = eventComponent.Id,
        Quantity__c = 2,
        Spread_Price__c = 1000
      ),
      new BundleComponent__c(
        Bundle__c = bundle.Id,
        Product__c = nonEventComponent.Id,
        Quantity__c = 1,
        Spread_Price__c = 100
      )
    };

    PricebookEntry bundleEntry = makePricebookEntry(bundle);
    Order orderRecord = makeDraftOrder(account);
    OrderItem bundleLine = makeOrderItem(orderRecord, bundleEntry, 1);

    Test.startTest();
    orderRecord.Status = 'Incassato';
    update orderRecord;
    Test.stopTest();

    List<Asset> tickets = [
      SELECT RecordTypeId, Product2Id, Order_Product__c
      FROM Asset
      WHERE Order_Product__c = :bundleLine.Id
    ];

    System.assertEquals(
      2,
      tickets.size(),
      'The bundle should create tickets only for flagged event components'
    );

    for (Asset ticket : tickets) {
      System.assertEquals(
        assetTicketRecordTypeId(),
        ticket.RecordTypeId,
        'Generated Assets should use the Ticket record type'
      );
      System.assertEquals(
        eventComponent.Id,
        ticket.Product2Id,
        'Ticket product should be the flagged bundle component'
      );
      System.assertEquals(
        bundleLine.Id,
        ticket.Order_Product__c,
        'Ticket should keep the sold bundle order line as its commercial origin'
      );
    }
  }
}
