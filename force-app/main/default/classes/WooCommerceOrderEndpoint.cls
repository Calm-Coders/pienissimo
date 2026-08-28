@RestResource(urlMapping='/woocommerce/orders/*')
global without sharing class WooCommerceOrderEndpoint {
  private static final String FLOW_NAME = 'WooCommerceOrderEndpoint.createOrder';
  private static final String DRAFT_STATUS = 'Draft';
  private static final String CREATED_STATUS = 'Incassato';

  @HttpPost
  global static void createOrder() {
    Integration_Log__c logRec = new Integration_Log__c();
    initializeLog(logRec);

    try {
      String rawBody = RestContext.request.requestBody == null
        ? null
        : RestContext.request.requestBody.toString();
      logRec.Request_Body__c = rawBody;

      WooCommerceOrderWrapper payload = parsePayload(rawBody);
      validatePayload(payload);

      Order existingOrder = findExistingOrder(payload.orderKey());
      if (existingOrder != null) {
        writeDuplicateOrderError(
          logRec,
          existingOrder.Id,
          existingOrder.AccountId,
          payload.orderKey()
        );
        return;
      }

      Id accountId = getOrCreateAccount(payload.customer());
      Id pricebookId = getStandardPricebookId();
      Map<String, Product2> productsByScCode = getProductsByScCode(
        payload.orderLines()
      );
      Map<Id, PricebookEntry> entriesByProductId = getPricebookEntries(
        productsByScCode.values(),
        pricebookId
      );

      Order orderRec = new Order(
        AccountId = accountId,
        EffectiveDate = payload.orderDate(),
        Status = DRAFT_STATUS,
        Pricebook2Id = pricebookId,
        WooCommerce_Order_Key__c = payload.orderKey()
      );
      insert orderRec;

      insertOrderLines(
        orderRec.Id,
        payload.orderLines(),
        productsByScCode,
        entriesByProductId
      );

      orderRec.Status = CREATED_STATUS;
      update orderRec;

      writeSuccess(logRec, orderRec.Id, accountId, false);
    } catch (Exception e) {
      writeError(logRec, e);
    } finally {
      insert logRec;
    }
  }

  private static WooCommerceOrderWrapper parsePayload(String rawBody) {
    if (String.isBlank(rawBody)) {
      throw new WooCommerceOrderException('Request body is required');
    }

    return (WooCommerceOrderWrapper) JSON.deserialize(
      rawBody,
      WooCommerceOrderWrapper.class
    );
  }

  private static void validatePayload(WooCommerceOrderWrapper payload) {
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
    if (payload.orderLines().isEmpty()) {
      throw new WooCommerceOrderException(
        'At least one WooCommerce order line is required'
      );
    }

    for (WooCommerceOrderLineWrapper line : payload.orderLines()) {
      if (String.isBlank(line.scCode())) {
        throw new WooCommerceOrderException(
          'Every WooCommerce order line must include the SC code'
        );
      }
      if (line.quantity() == null || line.quantity() <= 0) {
        throw new WooCommerceOrderException(
          'Quantity must be greater than zero for SC code ' + line.scCode()
        );
      }
      if (line.unitPrice() == null) {
        throw new WooCommerceOrderException(
          'Unit price, total or subtotal is required for SC code ' +
          line.scCode()
        );
      }
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

  private static Id getOrCreateAccount(WooCommerceCustomerWrapper customer) {
    Id accountId = findAccount(customer);
    if (accountId != null) {
      return accountId;
    }

    Account accountRec = new Account(
      Name = limitLength(accountName(customer), 255)
    );
    putAccountValue(
      accountRec,
      'Lead_Email__c',
      customer == null ? null : normalizeEmail(customer.email)
    );
    putAccountValue(
      accountRec,
      'Partita_IVA__c',
      customer == null ? null : clean(customer.partitaIva())
    );
    putAccountValue(
      accountRec,
      'Phone',
      customer == null ? null : clean(customer.phone)
    );
    insert accountRec;

    createContact(accountRec.Id, customer);
    return accountRec.Id;
  }

  private static Id findAccount(WooCommerceCustomerWrapper customer) {
    if (customer == null) {
      return null;
    }

    String email = normalizeEmail(customer.email);
    String partitaIva = clean(customer.partitaIva());

    if (
      !String.isBlank(email) &&
      !String.isBlank(partitaIva) &&
      hasAccountField('Lead_Email__c') &&
      hasAccountField('Partita_IVA__c')
    ) {
      List<Account> accounts = Database.query(
        'SELECT Id FROM Account WHERE Lead_Email__c = :email ' +
        'AND Partita_IVA__c = :partitaIva LIMIT 1'
      );
      if (!accounts.isEmpty()) {
        return accounts[0].Id;
      }
    }

    if (String.isBlank(email)) {
      return null;
    }

    List<Contact> contacts = [
      SELECT AccountId
      FROM Contact
      WHERE Email = :email AND AccountId != NULL
      LIMIT 1
    ];

    return contacts.isEmpty() ? null : contacts[0].AccountId;
  }

  private static void createContact(
    Id accountId,
    WooCommerceCustomerWrapper customer
  ) {
    if (
      customer == null ||
      (String.isBlank(customer.email) &&
      String.isBlank(customer.firstName()) &&
      String.isBlank(customer.lastName()))
    ) {
      return;
    }

    insert new Contact(
      AccountId = accountId,
      FirstName = limitLength(clean(customer.firstName()), 40),
      LastName = limitLength(contactLastName(customer), 80),
      Email = normalizeEmail(customer.email),
      Phone = clean(customer.phone)
    );
  }

  private static Map<String, Product2> getProductsByScCode(
    List<WooCommerceOrderLineWrapper> lines
  ) {
    Set<String> scCodes = new Set<String>();
    for (WooCommerceOrderLineWrapper line : lines) {
      scCodes.add(line.scCode());
    }

    Map<String, Product2> productsByScCode = new Map<String, Product2>();
    for (Product2 productRec : [
      SELECT Id, Code__c
      FROM Product2
      WHERE Code__c IN :scCodes
    ]) {
      productsByScCode.put(productRec.Code__c, productRec);
    }

    List<String> missingScCodes = new List<String>();
    for (String scCode : scCodes) {
      if (!productsByScCode.containsKey(scCode)) {
        missingScCodes.add(scCode);
      }
    }
    if (!missingScCodes.isEmpty()) {
      throw new WooCommerceOrderException(
        'No Salesforce Product2.Code__c match for SC code(s): ' +
        String.join(missingScCodes, ', ')
      );
    }

    return productsByScCode;
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
    List<Product2> products,
    Id pricebookId
  ) {
    Set<Id> productIds = new Set<Id>();
    Map<Id, String> productIdToScCode = new Map<Id, String>();
    for (Product2 productRec : products) {
      productIds.add(productRec.Id);
      productIdToScCode.put(productRec.Id, productRec.Code__c);
    }

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
        missingScCodes.add(productIdToScCode.get(productId));
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
    List<WooCommerceOrderLineWrapper> lines,
    Map<String, Product2> productsByScCode,
    Map<Id, PricebookEntry> entriesByProductId
  ) {
    List<OrderItem> orderItems = new List<OrderItem>();
    for (WooCommerceOrderLineWrapper line : lines) {
      Product2 productRec = productsByScCode.get(line.scCode());
      PricebookEntry entry = entriesByProductId.get(productRec.Id);
      orderItems.add(
        new OrderItem(
          OrderId = orderId,
          PricebookEntryId = entry.Id,
          Quantity = line.quantity(),
          UnitPrice = line.unitPrice()
        )
      );
    }

    insert orderItems;
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
    Boolean duplicate
  ) {
    Map<String, Object> responseBody = new Map<String, Object>{
      'success' => true,
      'duplicate' => duplicate,
      'orderId' => orderId,
      'accountId' => accountId
    };
    writeResponse(logRec, 200, responseBody, false);
  }

  private static void writeDuplicateOrderError(
    Integration_Log__c logRec,
    Id orderId,
    Id accountId,
    String wooCommerceOrderKey
  ) {
    String message =
      'Duplicate WooCommerce order key already exists: ' + wooCommerceOrderKey;
    Map<String, Object> responseBody = new Map<String, Object>{
      'success' => false,
      'duplicate' => true,
      'message' => message,
      'orderId' => orderId,
      'accountId' => accountId
    };

    logRec.Exception_Message__c = message;
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

  private static Boolean hasAccountField(String fieldName) {
    return Account.SObjectType.getDescribe()
      .fields.getMap()
      .containsKey(fieldName);
  }

  private static void putAccountValue(
    Account accountRec,
    String fieldName,
    String value
  ) {
    if (!String.isBlank(value) && hasAccountField(fieldName)) {
      accountRec.put(fieldName, value);
    }
  }

  private static String accountName(WooCommerceCustomerWrapper customer) {
    if (customer == null) {
      return 'WooCommerce customer';
    }
    if (!String.isBlank(customer.company)) {
      return customer.company.trim();
    }

    String fullName = String.join(
        new List<String>{
          clean(customer.firstName()),
          clean(customer.lastName())
        },
        ' '
      )
      .trim();
    return String.isBlank(fullName) ? 'WooCommerce customer' : fullName;
  }

  private static String contactLastName(WooCommerceCustomerWrapper customer) {
    if (!String.isBlank(customer.lastName())) {
      return customer.lastName().trim();
    }
    if (!String.isBlank(customer.firstName())) {
      return customer.firstName().trim();
    }
    if (!String.isBlank(customer.company)) {
      return customer.company.trim();
    }
    return 'WooCommerce customer';
  }

  private static String normalizeEmail(String email) {
    return String.isBlank(email) ? null : email.trim().toLowerCase();
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

  global class WooCommerceOrderWrapper {
    public String orderKey;
    public String order_key;
    public String orderId;
    public String order_id;
    public String id;
    public String effectiveDate;
    public String date_paid;
    public String date_created;
    public WooCommerceCustomerWrapper customer;
    public WooCommerceCustomerWrapper billing;
    public List<WooCommerceOrderLineWrapper> lines;
    public List<WooCommerceOrderLineWrapper> line_items;

    public String orderKey() {
      return firstNotBlank(
        new List<String>{ orderKey, order_key, orderId, order_id, id }
      );
    }

    public Date orderDate() {
      return firstDate(
        new List<String>{ effectiveDate, date_paid, date_created }
      );
    }

    public WooCommerceCustomerWrapper customer() {
      return customer == null ? billing : customer;
    }

    public List<WooCommerceOrderLineWrapper> orderLines() {
      if (lines != null) {
        return lines;
      }
      if (line_items != null) {
        return line_items;
      }
      return new List<WooCommerceOrderLineWrapper>();
    }
  }

  global class WooCommerceCustomerWrapper {
    public String firstName;
    public String first_name;
    public String lastName;
    public String last_name;
    public String company;
    public String email;
    public String phone;
    public String partitaIva;
    public String partita_iva;
    public String vat;
    public String vat_number;

    public String partitaIva() {
      return firstNotBlank(
        new List<String>{ partitaIva, partita_iva, vat, vat_number }
      );
    }

    public String firstName() {
      return firstNotBlank(new List<String>{ firstName, first_name });
    }

    public String lastName() {
      return firstNotBlank(new List<String>{ lastName, last_name });
    }
  }

  global class WooCommerceOrderLineWrapper {
    public String SC;
    public String scCode;
    public String productCode;
    public String product_code;
    public String sku;
    public Decimal quantity;
    public Decimal qty;
    public Decimal unitPriceValue;
    public Decimal unit_price;
    public Decimal price;
    public Decimal total;
    public Decimal subtotal;

    public String scCode() {
      return firstNotBlank(
        new List<String>{ SC, scCode, productCode, product_code, sku }
      );
    }

    public Decimal quantity() {
      return quantity == null ? qty : quantity;
    }

    public Decimal unitPrice() {
      Decimal explicitUnitPrice = firstDecimal(
        new List<Decimal>{ unitPriceValue, unit_price, price }
      );
      if (explicitUnitPrice != null) {
        return explicitUnitPrice;
      }

      Decimal amount = total == null ? subtotal : total;
      Decimal lineQuantity = quantity();
      return amount == null ||
        lineQuantity == null ||
        lineQuantity == 0
        ? null
        : amount / lineQuantity;
    }
  }

  global class WooCommerceOrderException extends Exception {
  }

  private static String firstNotBlank(List<String> values) {
    for (String value : values) {
      if (!String.isBlank(value)) {
        return value.trim();
      }
    }
    return null;
  }

  private static Decimal firstDecimal(List<Decimal> values) {
    for (Decimal value : values) {
      if (value != null) {
        return value;
      }
    }
    return null;
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
}
