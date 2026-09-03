@RestResource(urlMapping='/woocommerce/orders/*')
global without sharing class WoocommerceOrderService {
  private static final String FLOW_NAME = 'WoocommerceOrderService.createOrder';
  private static final String CREATED_STATUS = 'Incassato';
  private static final String INITIAL_STATUS = 'Ordinato';

  @HttpPost
  global static void createOrder() {
    Integration_Log__c logRec = new Integration_Log__c();
    initializeLog(logRec);

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

      Id accountId = getOrCreateAccount(payload);
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
        Status = INITIAL_STATUS,
        Pricebook2Id = pricebookId,
        Origine__c = 'WooCommerce',
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

      updateOpportunity(payload, orderRec.Id);
      writeSuccess(logRec, orderRec.Id, accountId, false);
    } catch (Exception e) {
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

  private static Order findExistingOrder(String wooCommerceOrderKey) {
    List<Order> orders = [
      SELECT Id, AccountId
      FROM Order
      WHERE WooCommerce_Order_Key__c = :wooCommerceOrderKey
      LIMIT 1
    ];

    return orders.isEmpty() ? null : orders[0];
  }

  private static Id getOrCreateAccount(WooCommerceOrderPayload payload) {
    Id opportunityAccountId = getOpportunityAccountId(payload);
    if (opportunityAccountId != null) {
      return opportunityAccountId;
    }

    Id accountId = findAccount(payload);
    if (accountId != null) {
      return accountId;
    }

    Account accountRec = new Account(
      Name = limitLength(accountName(payload), 255),
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
    putAccountValue(accountRec, 'Lead_Email__c', payload.email());
    putAccountValue(accountRec, 'Partita_IVA__c', payload.partitaIva());
    putAccountValue(accountRec, 'Nome_Locale__c', payload.venueName());
    putAccountValue(accountRec, 'Phone', payload.phone());
    insert accountRec;

    createContact(accountRec.Id, payload);
    return accountRec.Id;
  }

  private static Id getOpportunityAccountId(WooCommerceOrderPayload payload) {
    Id opportunityId = opportunityId(payload);
    if (opportunityId == null) {
      return null;
    }

    List<Opportunity> opportunities = [
      SELECT AccountId
      FROM Opportunity
      WHERE Id = :opportunityId
      LIMIT 1
    ];
    if (opportunities.isEmpty()) {
      throw new WooCommerceOrderException(
        'No Opportunity found for sf_opportunity_id: ' +
        payload.sf_opportunity_id
      );
    }

    return opportunities[0].AccountId;
  }

  private static Id findAccount(WooCommerceOrderPayload payload) {
    String email = payload.email();
    String partitaIva = payload.partitaIva();

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

    return null;
  }

  private static void createContact(
    Id accountId,
    WooCommerceOrderPayload payload
  ) {
    if (
      String.isBlank(payload.email()) &&
      String.isBlank(payload.firstName()) &&
      String.isBlank(payload.lastName())
    ) {
      return;
    }

    insert new Contact(
      AccountId = accountId,
      FirstName = limitLength(payload.firstName(), 40),
      LastName = limitLength(contactLastName(payload), 80),
      Email = payload.email(),
      Phone = payload.phone(),
      MailingStreet = payload.billingStreet(),
      MailingCity = payload.billingCity(),
      MailingState = payload.billingState(),
      MailingPostalCode = payload.billingPostalCode(),
      MailingCountry = payload.billingCountry()
    );
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
      SELECT Id, ProductCode
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
      productIdToScCode.put(productRec.Id, productRec.ProductCode);
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
    List<WooCommerceOrderLinePayload> lines,
    Map<String, Product2> productsByScCode,
    Map<Id, PricebookEntry> entriesByProductId
  ) {
    List<OrderItem> orderItems = new List<OrderItem>();
    for (WooCommerceOrderLinePayload line : lines) {
      Product2 productRec = productsByScCode.get(line.scCode());
      PricebookEntry entry = entriesByProductId.get(productRec.Id);
      orderItems.add(
        new OrderItem(
          OrderId = orderId,
          PricebookEntryId = entry.Id,
          Quantity = line.quantity,
          UnitPrice = line.unitPrice()
        )
      );
    }

    insert orderItems;
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

  private static Boolean hasAccountField(String fieldName) {
    return Account.SObjectType.getDescribe()
      .fields.getMap()
      .containsKey(fieldName);
  }

  private static Boolean hasOpportunityField(String fieldName) {
    return Opportunity.SObjectType.getDescribe()
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

  private static void putOpportunityValue(
    Opportunity opportunityRec,
    String fieldName,
    String value
  ) {
    if (!String.isBlank(value) && hasOpportunityField(fieldName)) {
      opportunityRec.put(fieldName, value);
    }
  }

  private static String accountName(WooCommerceOrderPayload payload) {
    String name = firstNotBlank(
      new List<String>{
        payload.companyName(),
        payload.billingCompany(),
        payload.fullName(),
        payload.venueName()
      }
    );
    return String.isBlank(name) ? 'WooCommerce customer' : name;
  }

  private static String contactLastName(WooCommerceOrderPayload payload) {
    String lastName = payload.lastName();
    if (!String.isBlank(lastName)) {
      return lastName;
    }

    String firstName = payload.firstName();
    if (!String.isBlank(firstName)) {
      return firstName;
    }

    String company = payload.billingCompany();
    return String.isBlank(company) ? 'WooCommerce customer' : company;
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
