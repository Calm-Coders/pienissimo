// Seeds more TEST MKT orders for the marketing ticket flow, as on 2026-10-04:
// per order, an Azienda account and its principal contact, one line on a TEST
// MKT ticket product, then Ordinato -> Incassato, which creates the tickets
// (Asset) and the Event Link. Nothing is sent to Mexal while
// OrderMexalIntegrationService.AUTOMATIC_MEXAL_CREATION_ENABLED is false.
// The contact email is copied from the existing TEST MKT principal contacts,
// so it stays whatever marketing set there.
// Run: sf apex run --target-org "Pienissimo Prod" --file scripts/apex/seed-test-mkt-orders.apex

Integer orderCount = 6;
List<String> productCodes = new List<String>{ 'TESTMKT-ACADEMY', 'TESTMKT-CV' };
List<Integer> quantities = new List<Integer>{ 1, 2, 3 };

Account template = [
  SELECT RecordTypeId, Email_Contatto_Principale__c
  FROM Account
  WHERE Name = 'TEST MKT - Azienda 1'
  LIMIT 1
];
String contactEmail = [
  SELECT Email
  FROM Contact
  WHERE
    Account.Name LIKE 'TEST MKT - Azienda%'
    AND Contatto_Principale__c = TRUE
  ORDER BY Account.Name
  LIMIT 1
]
.Email;
Integer firstIndex =
  [SELECT COUNT() FROM Account WHERE Name LIKE 'TEST MKT - Azienda %'] + 1;

// The test contacts share one email on purpose, so duplicate rules are told to allow the save.
Database.DMLOptions allowDuplicates = new Database.DMLOptions();
allowDuplicates.DuplicateRuleHeader.allowSave = true;

Map<String, PricebookEntry> entryByCode = new Map<String, PricebookEntry>();
for (PricebookEntry entry : [
  SELECT Id, UnitPrice, Product2.ProductCode, Pricebook2Id
  FROM PricebookEntry
  WHERE
    Pricebook2.IsStandard = TRUE
    AND Product2.ProductCode IN :productCodes
    AND IsActive = TRUE
]) {
  entryByCode.put(entry.Product2.ProductCode, entry);
}

List<Account> accounts = new List<Account>();
for (Integer i = 0; i < orderCount; i++) {
  Integer n = firstIndex + i;
  accounts.add(
    new Account(
      Name = 'TEST MKT - Azienda ' + n,
      RecordTypeId = template.RecordTypeId,
      BillingStreet = 'Via di Test ' + n,
      BillingCity = 'Milano',
      BillingState = 'MI',
      BillingPostalCode = '20100',
      BillingCountry = 'IT',
      Codice_Destinatario_SDI__c = '0000000',
      Partita_IVA__c = 'IT99' + String.valueOf(n).leftPad(9, '0'),
      Residenza_Fiscale__c = 'I',
      Email_Contatto_Principale__c = contactEmail
    )
  );
}
Database.insert(accounts, allowDuplicates);

List<Contact> contacts = new List<Contact>();
List<Order> orders = new List<Order>();
for (Integer i = 0; i < orderCount; i++) {
  Integer n = firstIndex + i;
  contacts.add(
    new Contact(
      AccountId = accounts[i].Id,
      FirstName = 'Test MKT',
      LastName = 'Partecipante ' + n,
      Email = contactEmail,
      Contatto_Principale__c = true
    )
  );
  orders.add(
    new Order(
      AccountId = accounts[i].Id,
      Pricebook2Id = entryByCode.get(productCodes[0]).Pricebook2Id,
      EffectiveDate = Date.today(),
      Status = 'Ordinato',
      Description = 'TEST MKT - ordine di test per i flussi marketing'
    )
  );
}
Database.insert(contacts, allowDuplicates);
insert orders;

List<OrderItem> lines = new List<OrderItem>();
for (Integer i = 0; i < orderCount; i++) {
  PricebookEntry entry = entryByCode.get(
    productCodes[Math.mod(i, productCodes.size())]
  );
  lines.add(
    new OrderItem(
      OrderId = orders[i].Id,
      PricebookEntryId = entry.Id,
      Quantity = quantities[Math.mod(i, quantities.size())],
      UnitPrice = entry.UnitPrice
    )
  );
}
insert lines;

for (Order orderRecord : orders) {
  orderRecord.Status = 'Incassato';
}
update orders;

for (Order orderRecord : [
  SELECT
    OrderNumber,
    Account.Name,
    Status,
    (SELECT Product2.ProductCode, Quantity FROM OrderItems)
  FROM Order
  WHERE Id IN :orders
  ORDER BY OrderNumber
]) {
  System.debug(
    LoggingLevel.ERROR,
    'SEED ' +
      orderRecord.OrderNumber +
      ' | ' +
      orderRecord.Account.Name +
      ' | ' +
      orderRecord.Status +
      ' | ' +
      orderRecord.OrderItems[0].Product2.ProductCode +
      ' x' +
      orderRecord.OrderItems[0].Quantity
  );
}
System.debug(
  LoggingLevel.ERROR,
  'SEED tickets=' +
    [SELECT COUNT() FROM Asset WHERE Account.Id IN :accounts] +
    ' eventLinks=' +
    [SELECT COUNT() FROM Event_Invitation__c WHERE Order__c IN :orders]
);
