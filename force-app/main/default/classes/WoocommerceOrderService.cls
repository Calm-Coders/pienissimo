@RestResource(urlMapping='/woocommerce/orders/*')
global without sharing class WoocommerceOrderService {
  private static final String FLOW_NAME = 'WoocommerceOrderService.createOrder';
  private static final String BUNDLE_RECORD_TYPE = 'Bundle';
  private static final String CREATED_STATUS = 'Incassato';
  private static final String INITIAL_STATUS = 'Ordinato';
  private static final String TRANCHE_STATUS_OPEN = 'Aperta';
  private static final String AZIENDA_RECORD_TYPE = 'Azienda';

  @HttpPost
  global static void createOrder() {
    Integration_Log__c logRec = new Integration_Log__c();
    initializeLog(logRec);
    Savepoint orderCreationSavepoint;

    try {
      RestRequest req = RestContext.request;
      String rawBody = req == null ||
        req.requestBody == null
        ? null
        : req.requestBody.toString();
      logRec.Request_Body__c = rawBody;
      logRec.Request_Headers__c = requestHeaders(req);

      WooCommerceOrderPayload payload = parsePayload(rawBody);
      validatePayload(payload);

      Order existingOrder = findExistingOrder(payload.orderKey());
      if (existingOrder != null) {
        writeDuplicateOrder(logRec, existingOrder, payload);
        return;
      }

      Id payloadOpportunityId = opportunityId(payload);
      Id pricebookId = getStandardPricebookId();
      Map<String, Product2> productsByScCode = getProductsByScCode(
        payload.orderLines()
      );
      OrderBuildPlan orderBuildPlan = buildOrderBuildPlan(
        payload.orderLines(),
        productsByScCode
      );
      Map<Id, PricebookEntry> entriesByProductId = getPricebookEntries(
        orderBuildPlan.productIds(),
        pricebookId
      );

      orderCreationSavepoint = Database.setSavepoint();
      CustomerResolution customer = resolveCustomer(
        payload,
        payloadOpportunityId
      );

      Order orderRec = new Order(
        AccountId = customer.accountId,
        EffectiveDate = payload.orderDate(),
        Status = INITIAL_STATUS,
        Pricebook2Id = pricebookId,
        Origine__c = 'WooCommerce',
        OpportunityId = payloadOpportunityId,
        WooCommerce_Order_Key__c = payload.orderKey()
      );

      insert orderRec;

      insertOrderLines(orderRec.Id, orderBuildPlan, entriesByProductId);

      if (!orderBuildPlan.hasBundleTranches()) {
        orderRec.Status = CREATED_STATUS;
        update orderRec;
      }

      updateOpportunity(payload, orderRec.Id);
      writeSuccess(
        logRec,
        orderRec.Id,
        customer.accountId,
        customer.contactId,
        customer.contactWarning,
        false
      );
    } catch (Exception e) {
      if (orderCreationSavepoint != null) {
        Database.rollback(orderCreationSavepoint);
      }
      writeError(logRec, e);
    } finally {
      insert logRec;
    }
  }

  private static WooCommerceOrderPayload parsePayload(String rawBody) {
    if (String.isBlank(rawBody)) {
      throw new WooCommerceOrderException('Request body is required');
    }

    return (WooCommerceOrderPayload) JSON.deserialize(
      rawBody,
      WooCommerceOrderPayload.class
    );
  }

  private static void validatePayload(WooCommerceOrderPayload payload) {
    if (payload == null) {
      throw new WooCommerceOrderException('Invalid WooCommerce payload');
    }
    if (String.isBlank(payload.orderKey())) {
      throw new WooCommerceOrderException('WooCommerce order key is required');
    }
    if (payload.orderKey().length() > 80) {
      throw new WooCommerceOrderException(
        'WooCommerce order key is too long for Order.WooCommerce_Order_Key__c'
      );
    }
    if (String.isBlank(payload.sf_opportunity_id)) {
      validateCustomerPayload(payload);
    } else {
      opportunityId(payload);
    }
    if (payload.orderLines().isEmpty()) {
      throw new WooCommerceOrderException(
        'At least one WooCommerce order line is required'
      );
    }

    for (WooCommerceOrderLinePayload line : payload.orderLines()) {
      if (String.isBlank(line.scCode())) {
        throw new WooCommerceOrderException(
          'Every WooCommerce order line must include the SKU/SC code'
        );
      }
      if (line.quantity == null || line.quantity <= 0) {
        throw new WooCommerceOrderException(
          'Quantity must be greater than zero for SC code ' + line.scCode()
        );
      }
      if (line.unitPrice() == null) {
        throw new WooCommerceOrderException(
          'Total or subtotal is required for SC code ' + line.scCode()
        );
      }
    }
  }

  private static void validateCustomerPayload(WooCommerceOrderPayload payload) {
    if (String.isBlank(payload.partitaIva())) {
      throw new WooCommerceOrderException(
        'VAT number is required when sf_opportunity_id is missing'
      );
    }
    if (String.isBlank(customerAccountName(payload))) {
      throw new WooCommerceOrderException(
        'Customer or company name is required when sf_opportunity_id is missing'
      );
    }
    if (String.isBlank(payload.billingCountry())) {
      throw new WooCommerceOrderException(
        'Billing country is required when sf_opportunity_id is missing'
      );
    }
  }

  private static Order findExistingOrder(String wooCommerceOrderKey) {
    List<Order> orders = [
      SELECT Id, AccountId
      FROM Order
      WHERE WooCommerce_Order_Key__c = :wooCommerceOrderKey
      LIMIT 1
    ];

    return orders.isEmpty() ? null : orders[0];
  }

  private static Id getOpportunityAccountId(Id opportunityId) {
    List<Opportunity> opportunities = [
      SELECT AccountId
      FROM Opportunity
      WHERE Id = :opportunityId
      LIMIT 1
    ];
    if (opportunities.isEmpty()) {
      throw new WooCommerceOrderException(
        'No Opportunity found for sf_opportunity_id: ' + opportunityId
      );
    }
    if (opportunities[0].AccountId == null) {
      throw new WooCommerceOrderException(
        'Opportunity ' + opportunityId + ' does not have an Account'
      );
    }

    return opportunities[0].AccountId;
  }

  private static CustomerResolution resolveCustomer(
    WooCommerceOrderPayload payload,
    Id payloadOpportunityId
  ) {
    if (payloadOpportunityId != null) {
      return new CustomerResolution(
        getOpportunityAccountId(payloadOpportunityId),
        null,
        null
      );
    }

    Account accountRecord = findAccountByVat(payload.partitaIva());
    if (accountRecord == null) {
      accountRecord = createAccount(payload);
    }

    Id commercialAccountId = CommercialAccountResolver.resolve(
      accountRecord.Id
    );
    Contact contactRecord;
    String contactWarning;
    try {
      contactRecord = findOrCreateContact(commercialAccountId, payload);
    } catch (Exception error) {
      contactWarning = 'Order created without Contact: ' + error.getMessage();
      System.debug(LoggingLevel.WARN, contactWarning);
    }
    return new CustomerResolution(
      commercialAccountId,
      contactRecord == null ? null : contactRecord.Id,
      contactWarning
    );
  }

  private static Account findAccountByVat(String partitaIva) {
    String normalizedVat = normalizeVat(partitaIva);
    List<Account> accounts = [
      SELECT Id, Partita_IVA__c
      FROM Account
      WHERE Partita_IVA__c = :normalizedVat
      ORDER BY CreatedDate, Id
      LIMIT 2
    ];

    if (accounts.size() > 1) {
      throw new WooCommerceOrderException(
        'Multiple Accounts found for the WooCommerce VAT number'
      );
    }
    return accounts.isEmpty() ? null : accounts[0];
  }

  private static Account createAccount(WooCommerceOrderPayload payload) {
    Account accountRecord = new Account(
      Name = limitLength(customerAccountName(payload), 255),
      RecordTypeId = getAziendaAccountRecordTypeId(),
      Lead_Email__c = payload.email(),
      Email__c = payload.email(),
      Partita_IVA__c = normalizeVat(payload.partitaIva()),
      Codice_Fiscale__c = payload.taxCode(),
      PEC__c = payload.pecEmail(),
      Codice_Destinatario_SDI__c = payload.sdiCode(),
      Phone = payload.phone(),
      Nome_Locale__c = payload.venueName(),
      BillingStreet = payload.billingStreet(),
      BillingCity = payload.billingCity(),
      BillingState = payload.billingState(),
      BillingPostalCode = payload.billingPostalCode(),
      BillingCountry = payload.billingCountry(),
      ShippingStreet = payload.shippingStreet(),
      ShippingCity = payload.shippingCity(),
      ShippingState = payload.shippingState(),
      ShippingPostalCode = payload.shippingPostalCode(),
      ShippingCountry = payload.shippingCountry()
    );
    insert accountRecord;
    return accountRecord;
  }

  private static Contact findOrCreateContact(
    Id accountId,
    WooCommerceOrderPayload payload
  ) {
    String email = payload.email();
    if (String.isBlank(email)) {
      throw new WooCommerceOrderException(
        'Billing email is missing; Contact matching was skipped'
      );
    }
    List<Contact> contacts = [
      SELECT Id, AccountId, Email, Contatto_Principale__c
      FROM Contact
      WHERE Email = :email
      ORDER BY Contatto_Principale__c DESC, CreatedDate, Id
    ];

    Contact matchingContact;
    List<Contact> orphanContacts = new List<Contact>();
    for (Contact contactRecord : contacts) {
      if (contactRecord.AccountId == accountId && matchingContact == null) {
        matchingContact = contactRecord;
      } else if (contactRecord.AccountId == null) {
        orphanContacts.add(contactRecord);
      }
    }

    if (matchingContact == null) {
      if (orphanContacts.size() > 1) {
        throw new WooCommerceOrderException(
          'Multiple Contacts without an Account use the WooCommerce billing email'
        );
      }

      if (orphanContacts.size() == 1) {
        matchingContact = orphanContacts[0];
        matchingContact.AccountId = accountId;
        update matchingContact;
      } else {
        matchingContact = new Contact(
          AccountId = accountId,
          FirstName = limitLength(payload.firstName(), 40),
          LastName = limitLength(customerContactLastName(payload), 80),
          Email = email,
          Phone = payload.phone(),
          MailingStreet = payload.billingStreet(),
          MailingCity = payload.billingCity(),
          MailingState = payload.billingState(),
          MailingPostalCode = payload.billingPostalCode(),
          MailingCountry = payload.billingCountry()
        );
        insertContactAllowingDuplicates(matchingContact);
      }
    }

    setAsPrincipalContactWhenMissing(accountId, matchingContact);
    return matchingContact;
  }

  private static void insertContactAllowingDuplicates(Contact contactRecord) {
    Database.DMLOptions options = new Database.DMLOptions();
    options.DuplicateRuleHeader.AllowSave = true;
    Database.SaveResult result = Database.insert(contactRecord, options);
    if (!result.isSuccess()) {
      throw new WooCommerceOrderException(
        'Unable to create Contact: ' + result.getErrors()[0].getMessage()
      );
    }
  }

  private static void setAsPrincipalContactWhenMissing(
    Id accountId,
    Contact contactRecord
  ) {
    if (contactRecord.Contatto_Principale__c == true) {
      return;
    }

    Integer principalContacts = [
      SELECT COUNT()
      FROM Contact
      WHERE AccountId = :accountId AND Contatto_Principale__c = TRUE
    ];
    if (principalContacts == 0) {
      update new Contact(Id = contactRecord.Id, Contatto_Principale__c = true);
      contactRecord.Contatto_Principale__c = true;
    }
  }

  private static Id getAziendaAccountRecordTypeId() {
    List<RecordType> recordTypes = [
      SELECT Id
      FROM RecordType
      WHERE SObjectType = 'Account' AND DeveloperName = :AZIENDA_RECORD_TYPE
      LIMIT 1
    ];
    if (recordTypes.isEmpty()) {
      throw new WooCommerceOrderException(
        'Account record type Azienda was not found'
      );
    }
    return recordTypes[0].Id;
  }

  private static Map<String, Product2> getProductsByScCode(
    List<WooCommerceOrderLinePayload> lines
  ) {
    Set<String> scCodes = new Set<String>();
    for (WooCommerceOrderLinePayload line : lines) {
      scCodes.add(line.scCode());
    }

    Map<String, Product2> productsByScCode = new Map<String, Product2>();
    for (Product2 productRec : [
      SELECT Id, Name, ProductCode, RecordType.DeveloperName
      FROM Product2
      WHERE ProductCode IN :scCodes
    ]) {
      productsByScCode.put(productRec.ProductCode, productRec);
    }

    List<String> missingScCodes = new List<String>();
    for (String scCode : scCodes) {
      if (!productsByScCode.containsKey(scCode)) {
        missingScCodes.add(scCode);
      }
    }
    if (!missingScCodes.isEmpty()) {
      throw new WooCommerceOrderException(
        'No Salesforce Product2.ProductCode match for SC code(s): ' +
        String.join(missingScCodes, ', ')
      );
    }

    return productsByScCode;
  }

  private static OrderBuildPlan buildOrderBuildPlan(
    List<WooCommerceOrderLinePayload> lines,
    Map<String, Product2> productsByScCode
  ) {
    OrderBuildPlan plan = new OrderBuildPlan();
    Set<Id> bundleIds = new Set<Id>();

    for (WooCommerceOrderLinePayload line : lines) {
      Product2 productRec = productsByScCode.get(line.scCode());
      if (isBundleProduct(productRec)) {
        bundleIds.add(productRec.Id);
      }
    }

    Map<Id, List<BundleComponent__c>> componentsByBundleId = getBundleComponentsByBundleId(
      bundleIds
    );
    Map<Id, List<Bundle_Tranch__c>> templatesByBundleId = getBundleTranchesByBundleId(
      bundleIds
    );

    for (WooCommerceOrderLinePayload line : lines) {
      Product2 productRec = productsByScCode.get(line.scCode());
      if (!isBundleProduct(productRec)) {
        plan.lines.add(
          new OrderLineDraft(
            productRec.Id,
            line.quantity,
            line.unitPrice(),
            null,
            null
          )
        );
        continue;
      }

      List<BundleComponent__c> components = componentsByBundleId.get(
        productRec.Id
      );
      if (components == null || components.isEmpty()) {
        throw new WooCommerceOrderException(
          'Il bundle ' +
            productRec.ProductCode +
            ' non ha componenti configurati.'
        );
      }

      List<Bundle_Tranch__c> templates = templatesByBundleId.get(productRec.Id);
      if (templates == null || templates.isEmpty()) {
        throw new WooCommerceOrderException(
          'Il bundle ' +
            productRec.ProductCode +
            ' non ha tranche configurate. Configura le tranche sul bundle prima di acquisire ordini WooCommerce.'
        );
      }

      Map<Id, Bundle_Tranch__c> templatesById = new Map<Id, Bundle_Tranch__c>(
        templates
      );
      Map<Id, Boolean> templateHasComponent = new Map<Id, Boolean>();
      for (Bundle_Tranch__c template : templates) {
        plan.bundleTranchesById.put(template.Id, template);
        templateHasComponent.put(template.Id, false);
      }

      for (BundleComponent__c component : components) {
        if (component.Bundle_Tranch__c == null) {
          throw new WooCommerceOrderException(
            'Assegna ogni componente del bundle ' +
              productRec.ProductCode +
              ' a una tranche prima di acquisire ordini WooCommerce.'
          );
        }
        if (!templatesById.containsKey(component.Bundle_Tranch__c)) {
          throw new WooCommerceOrderException(
            'Una tranche assegnata a un componente del bundle ' +
              productRec.ProductCode +
              ' non appartiene a questo bundle.'
          );
        }
        if (component.Product__c == null) {
          throw new WooCommerceOrderException(
            'Configura il prodotto su ogni componente del bundle ' +
              productRec.ProductCode +
              '.'
          );
        }
        if (component.Quantity__c == null || component.Quantity__c <= 0) {
          throw new WooCommerceOrderException(
            'Configura una quantita maggiore di zero per ogni componente del bundle ' +
              productRec.ProductCode +
              '.'
          );
        }
        if (component.Unit_Spread__c == null || component.Unit_Spread__c < 0) {
          throw new WooCommerceOrderException(
            'Configura gli importi dei componenti del bundle ' +
              productRec.ProductCode +
              ' prima di acquisire ordini WooCommerce.'
          );
        }

        Decimal bundleQuantity = line.quantity == null ? 1 : line.quantity;
        plan.lines.add(
          new OrderLineDraft(
            component.Product__c,
            component.Quantity__c * bundleQuantity,
            component.Unit_Spread__c,
            component.Bundle_Tranch__c,
            'Bundle: ' + productRec.Name
          )
        );
        templateHasComponent.put(component.Bundle_Tranch__c, true);
      }

      for (Id templateId : templateHasComponent.keySet()) {
        if (templateHasComponent.get(templateId) != true) {
          throw new WooCommerceOrderException(
            'Ogni tranche del bundle ' +
              productRec.ProductCode +
              ' deve avere almeno un componente assegnato.'
          );
        }
      }
    }

    return plan;
  }

  private static Map<Id, List<BundleComponent__c>> getBundleComponentsByBundleId(
    Set<Id> bundleIds
  ) {
    Map<Id, List<BundleComponent__c>> componentsByBundleId = new Map<Id, List<BundleComponent__c>>();
    if (bundleIds.isEmpty()) {
      return componentsByBundleId;
    }

    for (BundleComponent__c component : [
      SELECT
        Bundle__c,
        Product__c,
        Quantity__c,
        Unit_Spread__c,
        Bundle_Tranch__c
      FROM BundleComponent__c
      WHERE Bundle__c IN :bundleIds
      ORDER BY Bundle__c, Product__r.Name, Id
    ]) {
      if (!componentsByBundleId.containsKey(component.Bundle__c)) {
        componentsByBundleId.put(
          component.Bundle__c,
          new List<BundleComponent__c>()
        );
      }
      componentsByBundleId.get(component.Bundle__c).add(component);
    }

    return componentsByBundleId;
  }

  private static Map<Id, List<Bundle_Tranch__c>> getBundleTranchesByBundleId(
    Set<Id> bundleIds
  ) {
    Map<Id, List<Bundle_Tranch__c>> templatesByBundleId = new Map<Id, List<Bundle_Tranch__c>>();
    if (bundleIds.isEmpty()) {
      return templatesByBundleId;
    }

    for (Bundle_Tranch__c template : [
      SELECT Id, Bundle__c, Name, Sequenza__c, Data_Scadenza__c
      FROM Bundle_Tranch__c
      WHERE Bundle__c IN :bundleIds
      ORDER BY Bundle__c, Sequenza__c, CreatedDate, Id
    ]) {
      if (!templatesByBundleId.containsKey(template.Bundle__c)) {
        templatesByBundleId.put(
          template.Bundle__c,
          new List<Bundle_Tranch__c>()
        );
      }
      templatesByBundleId.get(template.Bundle__c).add(template);
    }

    return templatesByBundleId;
  }

  private static Id getStandardPricebookId() {
    List<Pricebook2> pricebooks = [
      SELECT Id
      FROM Pricebook2
      WHERE IsStandard = TRUE
      LIMIT 1
    ];
    if (pricebooks.isEmpty()) {
      throw new WooCommerceOrderException('Standard Price Book was not found');
    }

    return pricebooks[0].Id;
  }

  private static Map<Id, PricebookEntry> getPricebookEntries(
    Set<Id> productIds,
    Id pricebookId
  ) {
    Map<Id, PricebookEntry> entriesByProductId = new Map<Id, PricebookEntry>();
    for (PricebookEntry entry : [
      SELECT Id, Product2Id
      FROM PricebookEntry
      WHERE
        Pricebook2Id = :pricebookId
        AND Product2Id IN :productIds
        AND IsActive = TRUE
    ]) {
      entriesByProductId.put(entry.Product2Id, entry);
    }

    List<String> missingScCodes = new List<String>();
    for (Id productId : productIds) {
      if (!entriesByProductId.containsKey(productId)) {
        missingScCodes.add(String.valueOf(productId));
      }
    }
    if (!missingScCodes.isEmpty()) {
      throw new WooCommerceOrderException(
        'No active PricebookEntry for SC code(s): ' +
        String.join(missingScCodes, ', ')
      );
    }

    return entriesByProductId;
  }

  private static void insertOrderLines(
    Id orderId,
    OrderBuildPlan orderBuildPlan,
    Map<Id, PricebookEntry> entriesByProductId
  ) {
    Map<Id, Tranche__c> tranchesByBundleTemplateId = createOrderTranches(
      orderBuildPlan
    );

    List<OrderItem> orderItems = new List<OrderItem>();
    for (OrderLineDraft line : orderBuildPlan.lines) {
      PricebookEntry entry = entriesByProductId.get(line.productId);
      Tranche__c tranche = line.bundleTranchId == null
        ? null
        : tranchesByBundleTemplateId.get(line.bundleTranchId);
      orderItems.add(
        new OrderItem(
          OrderId = orderId,
          PricebookEntryId = entry.Id,
          Quantity = line.quantity,
          UnitPrice = line.unitPrice,
          Description = line.description,
          Tranche__c = tranche == null ? null : tranche.Id,
          Data_Scadenza__c = tranche == null ? null : tranche.Data_Scadenza__c
        )
      );
    }

    insert orderItems;
  }

  private static Map<Id, Tranche__c> createOrderTranches(
    OrderBuildPlan orderBuildPlan
  ) {
    Map<Id, Tranche__c> tranchesByBundleTemplateId = new Map<Id, Tranche__c>();
    if (orderBuildPlan.bundleTranchesById.isEmpty()) {
      return tranchesByBundleTemplateId;
    }

    Map<Id, Decimal> amountByTemplateId = new Map<Id, Decimal>();
    for (OrderLineDraft line : orderBuildPlan.lines) {
      if (line.bundleTranchId == null) {
        continue;
      }
      Decimal amount = amountByTemplateId.containsKey(line.bundleTranchId)
        ? amountByTemplateId.get(line.bundleTranchId)
        : 0;
      amountByTemplateId.put(line.bundleTranchId, amount + line.amount());
    }

    List<Tranche__c> tranches = new List<Tranche__c>();
    for (
      Bundle_Tranch__c template : orderBuildPlan.bundleTranchesById.values()
    ) {
      tranches.add(
        new Tranche__c(
          Name = trancheNameFromBundleTemplate(template),
          Data_Scadenza__c = template.Data_Scadenza__c,
          Sequenza__c = template.Sequenza__c,
          Importo_Previsto__c = amountByTemplateId.get(template.Id),
          Stato__c = TRANCHE_STATUS_OPEN,
          Completamente_Pagata__c = false,
          Bundle_Tranch__c = template.Id
        )
      );
    }
    insert tranches;

    for (Tranche__c tranche : tranches) {
      tranchesByBundleTemplateId.put(tranche.Bundle_Tranch__c, tranche);
    }

    return tranchesByBundleTemplateId;
  }

  private static String trancheNameFromBundleTemplate(
    Bundle_Tranch__c template
  ) {
    String sourceName = String.isBlank(template.Name)
      ? null
      : template.Name.trim();
    String sequenceLabel = sequenceLabel(template.Sequenza__c);

    if (String.isBlank(sourceName)) {
      return String.isBlank(sequenceLabel) ? 'Tranche' : 'T' + sequenceLabel;
    }

    String upperName = sourceName.toUpperCase();
    if (upperName.startsWith('BT')) {
      return 'T' + sourceName.substring(2);
    }
    if (upperName.startsWith('T')) {
      return sourceName;
    }

    return String.isBlank(sequenceLabel)
      ? 'T - ' + sourceName
      : 'T' + sequenceLabel + ' - ' + sourceName;
  }

  private static String sequenceLabel(Decimal sequence) {
    if (sequence == null) {
      return null;
    }
    return sequence == sequence.setScale(0)
      ? String.valueOf(sequence.intValue())
      : String.valueOf(sequence);
  }

  private static void updateOpportunity(
    WooCommerceOrderPayload payload,
    Id orderId
  ) {
    if (String.isBlank(payload.sf_opportunity_id)) {
      return;
    }

    Id opportunityId = opportunityId(payload);

    Opportunity opportunityRec = new Opportunity(Id = opportunityId);
    putOpportunityValue(
      opportunityRec,
      'WooCommerce_Order_Id__c',
      payload.orderIdentifier()
    );
    update opportunityRec;
  }

  private static void initializeLog(Integration_Log__c logRec) {
    RestRequest req = RestContext.request;
    logRec.Flow_Name__c = FLOW_NAME;
    logRec.Inbound_Outbound__c = 'Inbound';
    logRec.Is_Error__c = false;
    logRec.Request_Endpoint__c = req == null ? null : req.resourcePath;
  }

  private static void writeSuccess(
    Integration_Log__c logRec,
    Id orderId,
    Id accountId,
    Id contactId,
    String contactWarning,
    Boolean duplicate
  ) {
    Map<String, Object> responseBody = new Map<String, Object>{
      'success' => true,
      'duplicate' => duplicate,
      'orderId' => orderId,
      'accountId' => accountId,
      'contactId' => contactId
    };
    if (!String.isBlank(contactWarning)) {
      responseBody.put('warning', contactWarning);
    }
    writeResponse(logRec, 200, responseBody, false);
  }

  private static void writeDuplicateOrder(
    Integration_Log__c logRec,
    Order existingOrder,
    WooCommerceOrderPayload payload
  ) {
    Map<String, Object> responseBody = new Map<String, Object>{
      'success' => false,
      'duplicate' => true,
      'message' => 'WooCommerce order already exists',
      'orderId' => existingOrder.Id,
      'accountId' => existingOrder.AccountId
    };

    logRec.Exception_Message__c = 'WooCommerce order already exists';
    writeResponse(logRec, 409, responseBody, true);
  }

  private static void writeError(Integration_Log__c logRec, Exception e) {
    Map<String, Object> responseBody = new Map<String, Object>{
      'success' => false,
      'message' => e.getMessage()
    };

    logRec.Exception_Message__c = e.getMessage();
    logRec.Exception_StackTrace__c = e.getStackTraceString();
    writeResponse(logRec, 500, responseBody, true);
  }

  private static void writeResponse(
    Integration_Log__c logRec,
    Integer statusCode,
    Map<String, Object> responseBody,
    Boolean isError
  ) {
    String responseJson = JSON.serialize(responseBody);
    RestContext.response.statusCode = statusCode;
    RestContext.response.addHeader('Content-Type', 'application/json');
    RestContext.response.responseBody = Blob.valueOf(responseJson);

    logRec.Is_Error__c = isError;
    logRec.Response_State__c = String.valueOf(statusCode);
    logRec.Response_Body__c = responseJson;
  }

  private static String requestHeaders(RestRequest req) {
    if (req == null || req.headers == null || req.headers.isEmpty()) {
      return null;
    }

    Map<String, String> safeHeaders = new Map<String, String>();
    for (String headerName : req.headers.keySet()) {
      if (headerName != null && headerName.equalsIgnoreCase('Authorization')) {
        safeHeaders.put(headerName, '[REDACTED]');
      } else {
        safeHeaders.put(headerName, req.headers.get(headerName));
      }
    }
    return JSON.serialize(safeHeaders).abbreviate(131072);
  }

  private static Boolean hasOpportunityField(String fieldName) {
    return Opportunity.SObjectType.getDescribe()
      .fields.getMap()
      .containsKey(fieldName);
  }

  private static void putOpportunityValue(
    Opportunity opportunityRec,
    String fieldName,
    String value
  ) {
    if (!String.isBlank(value) && hasOpportunityField(fieldName)) {
      opportunityRec.put(fieldName, value);
    }
  }

  private static Boolean isBundleProduct(Product2 productRec) {
    return productRec != null &&
      productRec.RecordType != null &&
      productRec.RecordType.DeveloperName == BUNDLE_RECORD_TYPE;
  }

  private class CustomerResolution {
    public Id accountId;
    public Id contactId;
    public String contactWarning;

    public CustomerResolution(
      Id accountId,
      Id contactId,
      String contactWarning
    ) {
      this.accountId = accountId;
      this.contactId = contactId;
      this.contactWarning = contactWarning;
    }
  }

  private class OrderBuildPlan {
    public List<OrderLineDraft> lines = new List<OrderLineDraft>();
    public Map<Id, Bundle_Tranch__c> bundleTranchesById = new Map<Id, Bundle_Tranch__c>();

    public Set<Id> productIds() {
      Set<Id> productIds = new Set<Id>();
      for (OrderLineDraft line : lines) {
        productIds.add(line.productId);
      }
      return productIds;
    }

    public Boolean hasBundleTranches() {
      return !bundleTranchesById.isEmpty();
    }
  }

  private class OrderLineDraft {
    public Id productId;
    public Decimal quantity;
    public Decimal unitPrice;
    public Id bundleTranchId;
    public String description;

    public OrderLineDraft(
      Id productId,
      Decimal quantity,
      Decimal unitPrice,
      Id bundleTranchId,
      String description
    ) {
      this.productId = productId;
      this.quantity = quantity;
      this.unitPrice = unitPrice;
      this.bundleTranchId = bundleTranchId;
      this.description = description;
    }

    public Decimal amount() {
      Decimal normalizedQuantity = quantity == null ? 0 : quantity;
      Decimal normalizedUnitPrice = unitPrice == null ? 0 : unitPrice;
      return normalizedQuantity * normalizedUnitPrice;
    }
  }

  private static String normalizeEmail(String email) {
    return String.isBlank(email) ? null : email.trim().toLowerCase();
  }

  private static String normalizeVat(String vatNumber) {
    return String.isBlank(vatNumber) ? null : vatNumber.trim().toUpperCase();
  }

  private static String customerAccountName(WooCommerceOrderPayload payload) {
    return firstNotBlank(
      new List<String>{
        payload.companyName(),
        payload.billingCompany(),
        payload.venueName(),
        payload.fullName()
      }
    );
  }

  private static String customerContactLastName(
    WooCommerceOrderPayload payload
  ) {
    return firstNotBlank(
      new List<String>{
        payload.lastName(),
        payload.fullName(),
        payload.billingCompany(),
        payload.email()
      }
    );
  }

  private static String clean(String value) {
    return String.isBlank(value) ? null : value.trim();
  }

  private static String limitLength(String value, Integer maxLength) {
    if (value == null || value.length() <= maxLength) {
      return value;
    }
    return value.substring(0, maxLength);
  }

  private static String firstNotBlank(List<String> values) {
    for (String value : values) {
      if (!String.isBlank(value)) {
        return value.trim();
      }
    }
    return null;
  }

  private static String street(String address1, String address2) {
    List<String> parts = new List<String>();
    if (!String.isBlank(address1)) {
      parts.add(address1.trim());
    }
    if (!String.isBlank(address2)) {
      parts.add(address2.trim());
    }
    return parts.isEmpty() ? null : String.join(parts, '\n');
  }

  private static Id opportunityId(WooCommerceOrderPayload payload) {
    if (payload == null || String.isBlank(payload.sf_opportunity_id)) {
      return null;
    }

    try {
      return (Id) payload.sf_opportunity_id;
    } catch (Exception e) {
      throw new WooCommerceOrderException(
        'Invalid sf_opportunity_id: ' + payload.sf_opportunity_id
      );
    }
  }

  private static Decimal parseDecimal(String value) {
    String cleanValue = clean(value);
    return String.isBlank(cleanValue) ? null : Decimal.valueOf(cleanValue);
  }

  private static Date firstDate(List<String> values) {
    for (String value : values) {
      String cleanValue = clean(value);
      if (String.isBlank(cleanValue) || cleanValue.length() < 10) {
        continue;
      }

      try {
        return Date.valueOf(cleanValue.substring(0, 10));
      } catch (Exception e) {
        continue;
      }
    }

    return Date.today();
  }

  public class WooCommerceOrderPayload {
    public String event;
    public String sf_opportunity_id;
    public WooCommerceOrderBlock order;
    public WooCommerceBillingPayload billing;
    public WooCommerceShippingPayload shipping;
    public WooCommerceFiscalPayload fiscal;
    public WooCommercePaymentPayload payment;
    public WooCommerceTotalsPayload totals;
    public WooCommerceCustomerPayload customer;
    public WooCommerceProfilePayload profile;
    public WooCommerceFunnelPayload funnel;
    public WooCommerceTrackingPayload tracking;
    public List<WooCommerceOrderLinePayload> line_items;

    public String orderKey() {
      return order == null ? null : order.order_key;
    }

    public String orderIdentifier() {
      if (order == null) {
        return null;
      }
      return firstNotBlank(
        new List<String>{
          order.id == null ? null : String.valueOf(order.id),
          order.order_key
        }
      );
    }

    public Date orderDate() {
      if (order == null) {
        return Date.today();
      }
      return firstDate(
        new List<String>{
          order.date_paid,
          order.date_completed,
          order.date_created,
          order.date_modified
        }
      );
    }

    public List<WooCommerceOrderLinePayload> orderLines() {
      return line_items == null
        ? new List<WooCommerceOrderLinePayload>()
        : line_items;
    }

    public String firstName() {
      return billing == null ? null : clean(billing.first_name);
    }

    public String lastName() {
      return billing == null ? null : clean(billing.last_name);
    }

    public String fullName() {
      String firstName = firstName();
      String lastName = lastName();
      String combinedName = String.join(
          new List<String>{
            String.isBlank(firstName) ? '' : firstName,
            String.isBlank(lastName) ? '' : lastName
          },
          ' '
        )
        .trim();

      return firstNotBlank(
        new List<String>{ combinedName, firstName, lastName }
      );
    }

    public String billingCompany() {
      return billing == null ? null : clean(billing.company);
    }

    public String companyName() {
      return fiscal == null ? null : clean(fiscal.company_name);
    }

    public String venueName() {
      return fiscal == null ? null : clean(fiscal.venue_name);
    }

    public String email() {
      return billing == null ? null : normalizeEmail(billing.email);
    }

    public String phone() {
      return billing == null ? null : clean(billing.phone);
    }

    public String partitaIva() {
      return fiscal == null ? null : clean(fiscal.vat_number);
    }

    public String taxCode() {
      return fiscal == null ? null : clean(fiscal.tax_code);
    }

    public String sdiCode() {
      return fiscal == null ? null : clean(fiscal.sdi_code);
    }

    public String pecEmail() {
      return fiscal == null ? null : normalizeEmail(fiscal.pec_email);
    }

    public String billingStreet() {
      return billing == null
        ? null
        : street(billing.address_1, billing.address_2);
    }

    public String billingCity() {
      return billing == null ? null : clean(billing.city);
    }

    public String billingState() {
      return billing == null ? null : clean(billing.state);
    }

    public String billingPostalCode() {
      return billing == null ? null : clean(billing.postcode);
    }

    public String billingCountry() {
      return billing == null ? null : clean(billing.country);
    }

    public String shippingStreet() {
      return shipping == null
        ? billingStreet()
        : street(shipping.address_1, shipping.address_2);
    }

    public String shippingCity() {
      return shipping == null ? billingCity() : clean(shipping.city);
    }

    public String shippingState() {
      return shipping == null ? billingState() : clean(shipping.state);
    }

    public String shippingPostalCode() {
      return shipping == null ? billingPostalCode() : clean(shipping.postcode);
    }

    public String shippingCountry() {
      return shipping == null ? billingCountry() : clean(shipping.country);
    }
  }

  public class WooCommerceOrderBlock {
    public Long id;
    public String order_key;
    public String status;
    public String currency_x;
    public Boolean prices_include_tax;
    public String created_via;
    public String date_created;
    public String date_modified;
    public String date_paid;
    public String date_completed;
  }

  public class WooCommerceBillingPayload {
    public String first_name;
    public String last_name;
    public String company;
    public String email;
    public String phone;
    public String address_1;
    public String address_2;
    public String city;
    public String state;
    public String postcode;
    public String country;
  }

  public class WooCommerceShippingPayload {
    public String first_name;
    public String last_name;
    public String company;
    public String phone;
    public String address_1;
    public String address_2;
    public String city;
    public String state;
    public String postcode;
    public String country;
  }

  public class WooCommerceFiscalPayload {
    public String company_name;
    public String venue_name;
    public String vat_number;
    public String tax_code;
    public String sdi_code;
    public String pec_email;
  }

  public class WooCommercePaymentPayload {
    public String method;
    public String method_title;
    public String transaction_id;
  }

  public class WooCommerceTotalsPayload {
    public String subtotal;
    public String discount_total;
    public String shipping_total;
    public String tax_total;
    public String total;
    public String total_refunded;
  }

  public class WooCommerceCustomerPayload {
    public Long id;
    public Boolean is_guest;
    public String ip_address;
    public String user_agent;
    public String customer_note;
  }

  public class WooCommerceProfilePayload {
    public String business_type;
    public Boolean marketing_consent;
    public Boolean terms_accepted;
  }

  public class WooCommerceFunnelPayload {
    public String source_url;
    public Long checkout_page_id;
    public Long funnel_id;
  }

  public class WooCommerceTrackingPayload {
    public String utm_source;
    public String utm_medium;
    public String utm_campaign;
    public String utm_term;
    public String utm_content;
    public String referrer;
    public String first_landing_url;
    public String first_click;
    public String device;
    public String browser;
  }

  public class WooCommerceOrderLinePayload {
    public Long item_id;
    public Long product_id;
    public Long variation_id;
    public String sku;
    public String name;
    public Decimal quantity;
    public String subtotal;
    public String subtotal_tax;
    public String total;
    public String total_tax;
    public String tax_class;

    public String scCode() {
      return clean(sku);
    }

    public Decimal unitPrice() {
      Decimal amount = parseDecimal(total);
      if (amount == null) {
        amount = parseDecimal(subtotal);
      }
      return amount == null ||
        quantity == null ||
        quantity == 0
        ? null
        : amount / quantity;
    }
  }

  public class WooCommerceOrderException extends Exception {
  }
}
