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
      Code__c = 'TEST-' + name.replace(' ', '-'),
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
  static void activatingOrderCreatesTicketsForFlaggedProducts() {
    Account account = makeAccount();
    Product2 eventProduct = makeProduct('Pienissimo Live', true);
    Product2 ordinaryProduct = makeProduct('Manuale Operativo', false);
    PricebookEntry eventEntry = makePricebookEntry(eventProduct);
    PricebookEntry ordinaryEntry = makePricebookEntry(ordinaryProduct);
    Order orderRecord = makeDraftOrder(account);
    OrderItem eventLine = makeOrderItem(orderRecord, eventEntry, 3);
    OrderItem ordinaryLine = makeOrderItem(orderRecord, ordinaryEntry, 2);

    Test.startTest();
    orderRecord.Status = 'Activated';
    update orderRecord;
    Test.stopTest();

    List<Biglietto__c> tickets = [
      SELECT Status__c, Product__c, Order_Product__c, Fattura_Pagata__c
      FROM Biglietto__c
      WHERE Order_Product__c IN (:eventLine.Id, :ordinaryLine.Id)
      ORDER BY Name
    ];

    System.assertEquals(
      3,
      tickets.size(),
      'Only the flagged event product line should generate tickets'
    );

    for (Biglietto__c ticket : tickets) {
      System.assertEquals('Caricato', ticket.Status__c);
      System.assertEquals(eventProduct.Id, ticket.Product__c);
      System.assertEquals(eventLine.Id, ticket.Order_Product__c);
      System.assertEquals(false, ticket.Fattura_Pagata__c);
    }
  }

  @isTest
  static void repeatedActivationDoesNotCreateDuplicates() {
    Account account = makeAccount();
    Product2 eventProduct = makeProduct('Food Marketing Festival', true);
    PricebookEntry eventEntry = makePricebookEntry(eventProduct);
    Order orderRecord = makeDraftOrder(account);
    OrderItem eventLine = makeOrderItem(orderRecord, eventEntry, 2);

    orderRecord.Status = 'Activated';
    update orderRecord;

    Test.startTest();
    update orderRecord;
    Test.stopTest();

    System.assertEquals(
      2,
      [
        SELECT COUNT()
        FROM Biglietto__c
        WHERE Order_Product__c = :eventLine.Id
      ],
      'Updating an already activated order must not create duplicate tickets'
    );
  }

  @isTest
  static void activationTopsUpOnlyMissingTickets() {
    Account account = makeAccount();
    Product2 eventProduct = makeProduct('Academy', true);
    PricebookEntry eventEntry = makePricebookEntry(eventProduct);
    Order orderRecord = makeDraftOrder(account);
    OrderItem eventLine = makeOrderItem(orderRecord, eventEntry, 2);

    insert new Biglietto__c(
      Name = 'Existing ticket',
      Status__c = 'Caricato',
      Product__c = eventProduct.Id,
      Order_Product__c = eventLine.Id
    );

    Test.startTest();
    orderRecord.Status = 'Activated';
    update orderRecord;
    Test.stopTest();

    System.assertEquals(
      2,
      [
        SELECT COUNT()
        FROM Biglietto__c
        WHERE Order_Product__c = :eventLine.Id
      ],
      'Activation should create only the missing tickets for the order line'
    );
  }

  @isTest
  static void bundleLineCreatesTicketsForFlaggedComponentsOnly() {
    Account account = makeAccount();
    Product2 bundle = makeProduct('Anno con Pienissimo', false, 'Bundle');
    Product2 eventComponent = makeProduct('Pienissimo Live', true, 'Item');
    Product2 nonEventComponent = makeProduct('Manuale Operativo', false, 'Item');

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
    orderRecord.Status = 'Activated';
    update orderRecord;
    Test.stopTest();

    List<Biglietto__c> tickets = [
      SELECT Product__c, Order_Product__c
      FROM Biglietto__c
      WHERE Order_Product__c = :bundleLine.Id
    ];

    System.assertEquals(
      2,
      tickets.size(),
      'The bundle should create tickets only for flagged event components'
    );

    for (Biglietto__c ticket : tickets) {
      System.assertEquals(
        eventComponent.Id,
        ticket.Product__c,
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
