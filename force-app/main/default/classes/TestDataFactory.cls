/**
 * Shared test data for the Pienissimo suite.
 *
 * Every builder inserts its record unless the method name starts with "build".
 * Record types are resolved by developer name, never by id, so the factory
 * works in every org the metadata is deployed to.
 */
@isTest
public class TestDataFactory {
  private static final Map<String, Id> RECORD_TYPE_IDS = new Map<String, Id>();
  private static Integer sequence = 0;

  public static Id recordTypeId(String sObjectType, String developerName) {
    String key = sObjectType + '.' + developerName;
    if (!RECORD_TYPE_IDS.containsKey(key)) {
      List<RecordType> recordTypes = [
        SELECT Id
        FROM RecordType
        WHERE SObjectType = :sObjectType AND DeveloperName = :developerName
        LIMIT 1
      ];
      RECORD_TYPE_IDS.put(
        key,
        recordTypes.isEmpty() ? null : recordTypes[0].Id
      );
    }
    return RECORD_TYPE_IDS.get(key);
  }

  public static void assertContains(String actual, String expected) {
    // AuraHandledException.getMessage() is "Script-thrown exception" inside a
    // test unless setMessage was called; then only the throw can be asserted.
    System.assertNotEquals(null, actual, 'Expected an error: ' + expected);
    if (actual == 'Script-thrown exception') {
      return;
    }
    System.assert(
      actual.contains(expected),
      'Expected "' + expected + '" in: ' + actual
    );
  }

  public static String unique(String prefix) {
    sequence++;
    return prefix + '-' + String.valueOf(sequence);
  }

  // ---------------------------------------------------------------- Accounts

  // Names carry a sequence suffix: production runs an Account duplicate rule.
  public static Account buildAzienda(String name) {
    Account accountRecord = new Account(
      Name = unique(name),
      RecordTypeId = recordTypeId('Account', 'Azienda'),
      Partita_IVA__c = unique('IT0000000'),
      Email__c = 'azienda' + String.valueOf(sequence) + '@example.com',
      Phone = '0212345' + String.valueOf(sequence),
      BillingStreet = 'Via Roma 1',
      BillingPostalCode = '20100',
      BillingCity = 'Milano',
      BillingState = 'MI',
      BillingCountry = 'IT'
    );
    return accountRecord;
  }

  public static Account azienda(String name) {
    Account accountRecord = buildAzienda(name);
    insertAllowingDuplicates(accountRecord);
    return accountRecord;
  }

  public static Account locale(String name, Id parentId) {
    Account accountRecord = new Account(
      Name = unique(name),
      RecordTypeId = recordTypeId('Account', 'Locale'),
      ParentId = parentId
    );
    insertAllowingDuplicates(accountRecord);
    return accountRecord;
  }

  public static Contact contact(Id accountId, String email, Boolean principal) {
    Contact contactRecord = new Contact(
      AccountId = accountId,
      FirstName = unique('Nome'),
      LastName = unique('Rossi'),
      Email = email,
      Phone = '333' + String.valueOf(1000000 + sequence),
      Contatto_Principale__c = principal
    );
    insertAllowingDuplicates(contactRecord);
    return contactRecord;
  }

  // Production runs Account, Contact and Lead duplicate rules; test data
  // is deliberately similar, so it saves past them.
  public static Database.DMLOptions allowDuplicates() {
    Database.DMLOptions options = new Database.DMLOptions();
    options.DuplicateRuleHeader.AllowSave = true;
    return options;
  }

  // DuplicateRuleHeader is honoured only by Database.insert with options.
  public static void insertAllowingDuplicates(SObject record) {
    insertAllowingDuplicates(new List<SObject>{ record });
  }

  public static void insertAllowingDuplicates(List<SObject> records) {
    for (
      Database.SaveResult result : Database.insert(records, allowDuplicates())
    ) {
      if (!result.isSuccess()) {
        throw new DmlException(String.valueOf(result.getErrors()));
      }
    }
  }

  // The user every test runs as: the deploying profile plus Full_Permission.
  // New fields carry no FLS for the profile until a permission set grants it,
  // and the USER_MODE queries in the controllers enforce FLS. Full_Permission
  // also holds the custom permission the Lock_Mexal_Synced_Admin_Fields rule
  // checks. Created once per test through its own runAs, so setup DML never
  // mixes with the test's data DML.
  public static User runner() {
    List<User> existing = [
      SELECT Id
      FROM User
      WHERE Username LIKE 'pienissimo.runner%@pienissimo.test'
      LIMIT 1
    ];
    if (!existing.isEmpty()) {
      return existing[0];
    }
    User runnerUser;
    System.runAs(new User(Id = UserInfo.getUserId())) {
      runnerUser = mexalAdminUser();
    }
    return runnerUser;
  }

  public static User mexalAdminUser() {
    User adminUser = new User(
      ProfileId = UserInfo.getProfileId(),
      Username = unique('pienissimo.runner') + '@pienissimo.test',
      LastName = 'Mexal Admin',
      Email = 'mexal.admin@example.com',
      Alias = 'mxadm',
      TimeZoneSidKey = 'Europe/Rome',
      LocaleSidKey = 'it_IT',
      EmailEncodingKey = 'UTF-8',
      LanguageLocaleKey = 'it',
      Agente__c = 'TEST-AGENTE'
    );
    insert adminUser;
    List<PermissionSet> permissionSets = [
      SELECT Id
      FROM PermissionSet
      WHERE Name = 'Full_Permission'
      LIMIT 1
    ];
    if (!permissionSets.isEmpty()) {
      insert new PermissionSetAssignment(
        AssigneeId = adminUser.Id,
        PermissionSetId = permissionSets[0].Id
      );
    }
    return adminUser;
  }

  // ---------------------------------------------------------------- Products

  public static Product2 buildItem(String name, String code) {
    return new Product2(
      Name = name,
      ProductCode = code,
      External_Product_Code__c = code,
      IsActive = true,
      RecordTypeId = recordTypeId('Product2', 'Item'),
      Product_Price__c = 100
    );
  }

  public static Product2 item(String name, String code) {
    Product2 product = buildItem(name, code);
    insert product;
    return product;
  }

  public static Product2 buildBundle(String name, String code, Decimal price) {
    return new Product2(
      Name = name,
      ProductCode = code,
      External_Product_Code__c = code,
      IsActive = true,
      RecordTypeId = recordTypeId('Product2', 'Bundle'),
      Bundle_Selling_Price__c = price
    );
  }

  public static Product2 bundle(String name, String code, Decimal price) {
    Product2 product = buildBundle(name, code, price);
    insert product;
    return product;
  }

  // ProductCodeTrigger already creates a zero-priced standard entry on insert.
  public static PricebookEntry standardEntry(Id productId, Decimal unitPrice) {
    Id pricebookId = Test.getStandardPricebookId();
    List<PricebookEntry> entries = [
      SELECT Id, UnitPrice, IsActive, Product2Id, Pricebook2Id
      FROM PricebookEntry
      WHERE Pricebook2Id = :pricebookId AND Product2Id = :productId
      LIMIT 1
    ];
    PricebookEntry entry;
    if (entries.isEmpty()) {
      entry = new PricebookEntry(
        Pricebook2Id = pricebookId,
        Product2Id = productId,
        UnitPrice = unitPrice,
        IsActive = true
      );
      insert entry;
    } else {
      entry = entries[0];
      entry.UnitPrice = unitPrice;
      entry.IsActive = true;
      update entry;
    }
    return entry;
  }

  // Makes Pricebook2.IsStandard filters see the standard pricebook.
  public static void activateStandardPricebook() {
    update new Pricebook2(Id = Test.getStandardPricebookId(), IsActive = true);
  }

  public static BundleComponent__c bundleComponent(
    Id bundleId,
    Id productId,
    Decimal spread
  ) {
    BundleComponent__c component = new BundleComponent__c(
      Bundle__c = bundleId,
      Product__c = productId,
      Quantity__c = 1,
      Spread_Price__c = spread
    );
    insert component;
    return component;
  }

  // ------------------------------------------------------ Commercial chain

  public static Opportunity opportunity(Id accountId) {
    return opportunity(accountId, 'Standart');
  }

  // Record types: Standart, Plus_Attivazione_Rinnovo, Recall_Tutor.
  public static Opportunity opportunity(
    Id accountId,
    String recordTypeDeveloperName
  ) {
    Opportunity opportunityRecord = new Opportunity(
      Name = unique('Opportunita'),
      AccountId = accountId,
      StageName = 'Qualificato',
      CloseDate = Date.today().addDays(30),
      Pricebook2Id = Test.getStandardPricebookId(),
      RecordTypeId = recordTypeId('Opportunity', recordTypeDeveloperName)
    );
    insert opportunityRecord;
    return opportunityRecord;
  }

  public static Quote quote(Id opportunityId) {
    Quote quoteRecord = new Quote(
      Name = unique('Preventivo'),
      OpportunityId = opportunityId,
      Pricebook2Id = Test.getStandardPricebookId(),
      Status = 'Bozza'
    );
    insert quoteRecord;
    return quoteRecord;
  }

  public static QuoteLineItem quoteLine(
    Id quoteId,
    PricebookEntry entry,
    Decimal quantity,
    Decimal unitPrice
  ) {
    QuoteLineItem line = new QuoteLineItem(
      QuoteId = quoteId,
      PricebookEntryId = entry.Id,
      Product2Id = entry.Product2Id,
      Quantity = quantity,
      UnitPrice = unitPrice
    );
    insert line;
    return line;
  }

  public static Order order(Id accountId) {
    Order orderRecord = new Order(
      AccountId = accountId,
      EffectiveDate = Date.today(),
      Status = 'Ordinato',
      Pricebook2Id = Test.getStandardPricebookId()
    );
    insert orderRecord;
    return orderRecord;
  }

  public static OrderItem orderItem(
    Id orderId,
    PricebookEntry entry,
    Decimal quantity
  ) {
    OrderItem line = new OrderItem(
      OrderId = orderId,
      PricebookEntryId = entry.Id,
      Quantity = quantity,
      UnitPrice = entry.UnitPrice
    );
    insert line;
    return line;
  }

  public static Tranche__c tranche(Id quoteId, Integer sequenceNumber) {
    Tranche__c trancheRecord = new Tranche__c(
      Quote__c = quoteId,
      Sequenza__c = sequenceNumber,
      Data_Scadenza__c = Date.today().addMonths(sequenceNumber),
      Stato__c = 'Aperta'
    );
    insert trancheRecord;
    return trancheRecord;
  }

  // ---------------------------------------------------------------- Campaigns

  public static Campaign parentCampaign(String name) {
    Campaign campaign = new Campaign(
      Name = name,
      IsActive = true,
      RecordTypeId = recordTypeId('Campaign', 'Campagna_Padre')
    );
    insert campaign;
    return campaign;
  }

  public static Campaign childCampaign(String name, Id parentId) {
    Campaign campaign = new Campaign(
      Name = name,
      IsActive = true,
      RecordTypeId = recordTypeId('Campaign', 'Campagna_Figlio'),
      ParentId = parentId,
      StartDate = Date.today().addDays(-1),
      EndDate = Date.today().addDays(10),
      Data_Evento__c = Date.today().addDays(10),
      Data_Invio_Biglietto__c = Date.today()
    );
    insert campaign;
    return campaign;
  }

  public static Mappatura_Edizione__c mapping(Id productId, Id campaignId) {
    Mappatura_Edizione__c mappingRecord = new Mappatura_Edizione__c(
      Prodotto__c = productId,
      Campagna__c = campaignId,
      Attiva__c = true
    );
    insert mappingRecord;
    return mappingRecord;
  }

  // ------------------------------------------------------------ Integrations

  public static Integration_Configuration2__c integrationConfig(
    String actionName,
    String method,
    String path
  ) {
    return new Integration_Configuration2__c(
      Name = actionName.abbreviate(38),
      Azione__c = actionName,
      HTTP_Method__c = method,
      Endpoint_Path__c = path,
      Named_Credential_Prod__c = 'Test_Credential',
      Named_Credential_Sandbox__c = 'Test_Credential',
      Timeout__c = 60000,
      Content_Type_JSON__c = true,
      Content_Type_Encoded__c = false,
      Use_Mock__c = false
    );
  }

  // One row per integration action the code calls, with valid method/path.
  public static void integrationConfigs() {
    Integration_Configuration2__c anticipay = integrationConfig(
      'Anticipay_Account_Check',
      'GET',
      '/anticipay/{env}/{piva}'
    );
    anticipay.Response_Wrapper_Class__c = 'AnticipayAccountService.Response';
    insert anticipay;
    insert new List<Integration_Configuration2__c>{
      integrationConfig(
        'Mexal_Clienti_Ricerca',
        'POST',
        '/webapi/risorse/clienti/ricerca'
      ),
      integrationConfig(
        'Mexal_Articoli_Ricerca',
        'POST',
        '/webapi/risorse/articoli/ricerca'
      ),
      integrationConfig(
        'Mexal_Movimenti_Magazzino_Ricerca',
        'POST',
        '/webapi/risorse/documenti/movimenti-magazzino/ricerca'
      ),
      integrationConfig(
        'Mexal_Movimenti_Magazzino_Dettaglio',
        'GET',
        '/webapi/risorse/documenti/movimenti-magazzino/{sigla}+{serie}+{numero}?cod_conto={cod_conto}'
      ),
      integrationConfig(
        'Mexal_Scadenzario_Ricerca',
        'POST',
        '/webapi/risorse/scadenzario/ricerca'
      ),
      integrationConfig(
        'Mexal_Clienti_Creazione',
        'POST',
        '/webapi/risorse/clienti'
      ),
      integrationConfig(
        'Mexal_Clienti_Modifica',
        'PUT',
        '/webapi/risorse/clienti/{codice}'
      ),
      integrationConfig(
        'Mexal_Ordini_Creazione',
        'POST',
        '/webapi/risorse/documenti/ordini-clienti'
      ),
      integrationConfig(
        'Mexal_Indirizzi_Spedizione_Creazione',
        'POST',
        '/webapi/risorse/indirizzi-spedizione'
      ),
      integrationConfig(
        'DocuSign_Create_Envelope',
        'POST',
        '/restapi/v2.1/accounts/1/envelopes'
      )
    };
  }
}
