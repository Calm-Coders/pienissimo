public without sharing class OrderPdfService implements Queueable, Database.AllowsCallouts {
  private static final String WOOCOMMERCE_ORIGIN = 'WooCommerce';

  public static Order requireWooCommerceOrder(Id orderId) {
    if (orderId == null || orderId.getSObjectType() != Order.SObjectType) {
      throw new OrderPdfException('Ordine non valido.');
    }
    List<Order> orders = [
      SELECT
        Id,
        OrderNumber,
        Origine__c,
        Contract_Pdf_Type__c,
        (SELECT Id FROM OrderItems LIMIT 1)
      FROM Order
      WHERE Id = :orderId
    ];
    if (orders.isEmpty() || orders[0].Origine__c != WOOCOMMERCE_ORIGIN) {
      throw new OrderPdfException(
        'Il PDF ordine e disponibile solo per ordini WooCommerce.'
      );
    }
    if (
      !new Set<String>{ 'Item', 'Bundle', 'Plus' }
        .contains(orders[0].Contract_Pdf_Type__c)
    ) {
      throw new OrderPdfException(
        'Categoria del contratto ordine non configurata.'
      );
    }
    if (orders[0].OrderItems.isEmpty()) {
      throw new OrderPdfException('L ordine non contiene righe prodotto.');
    }
    return orders[0];
  }

  @AuraEnabled
  public static Id generatePdf(Id orderId) {
    Savepoint pdfSavepoint;
    try {
      Order orderRecord = requireWooCommerceOrder(orderId);
      String title = 'Contratto-Ordine-' + orderRecord.OrderNumber;
      Id existing = existingDocument(orderId, title);
      if (existing != null) {
        return existing;
      }
      PageReference document = Page.QuotePdf;
      document.getParameters().put('id', String.valueOf(orderId));
      // As in QuotePdfService, render before DML or locking (PDF rendering is a callout).
      Blob body = document.getContentAsPDF();
      if (body == null || body.size() == 0) {
        throw new OrderPdfException('Il documento PDF generato e vuoto.');
      }
      Order currentOrder = [
        SELECT Id, Origine__c, Contract_Pdf_Type__c
        FROM Order
        WHERE Id = :orderId
        FOR UPDATE
      ];
      if (
        currentOrder.Origine__c != WOOCOMMERCE_ORIGIN ||
        currentOrder.Contract_Pdf_Type__c != orderRecord.Contract_Pdf_Type__c
      ) {
        throw new OrderPdfException(
          'I dati dell ordine sono cambiati. Il PDF non e stato salvato.'
        );
      }
      // Serialize concurrent requests without deleting an existing or signed contract.
      existing = existingDocument(orderId, title);
      if (existing != null) {
        return existing;
      }
      pdfSavepoint = Database.setSavepoint();
      ContentVersion file = new ContentVersion(
        Title = title,
        PathOnClient = title + '.pdf',
        VersionData = body,
        FirstPublishLocationId = orderId
      );
      insert file;
      Id documentId = [
        SELECT ContentDocumentId
        FROM ContentVersion
        WHERE Id = :file.Id
      ]
      .ContentDocumentId;
      List<ContentDocumentLink> links = [
        SELECT Id
        FROM ContentDocumentLink
        WHERE ContentDocumentId = :documentId AND LinkedEntityId = :orderId
      ];
      for (ContentDocumentLink link : links) {
        link.ShareType = 'V';
        link.Visibility = 'AllUsers';
      }
      update links;
      return documentId;
    } catch (Exception error) {
      if (pdfSavepoint != null) {
        Database.rollback(pdfSavepoint);
      }
      AuraHandledException handledError = new AuraHandledException(
        'Generazione PDF ordine non riuscita: ' + error.getMessage()
      );
      handledError.setMessage(
        'Generazione PDF ordine non riuscita: ' + error.getMessage()
      );
      throw handledError;
    }
  }

  private static Id existingDocument(Id orderId, String title) {
    for (ContentDocumentLink link : [
      SELECT ContentDocumentId, ContentDocument.Title
      FROM ContentDocumentLink
      WHERE LinkedEntityId = :orderId
    ]) {
      if (link.ContentDocument.Title == title) {
        return link.ContentDocumentId;
      }
    }
    return null;
  }

  public class OrderPdfException extends Exception {
  }

  // Product classification captured during the WooCommerce import.
  public static final String ITEM = 'Item';
  public static final String BUNDLE = 'Bundle';
  public static final String PLUS = 'Plus';

  // Classify the purchased products before WooCommerce bundles become order lines.
  public static String classify(Set<Id> productIds) {
    if (productIds == null || productIds.isEmpty()) {
      throw new ClassificationException('Nessun prodotto da classificare.');
    }
    Map<Id, Product2> products = new Map<Id, Product2>(
      [
        SELECT Id, RecordType.DeveloperName, Categoria_Articolo__c
        FROM Product2
        WHERE Id IN :productIds
      ]
    );
    if (products.size() != productIds.size()) {
      throw new ClassificationException('Prodotto non disponibile.');
    }
    Map<String, String> plusCategories = PerformancePlusContractService.contractTypeByCategory();
    Set<Id> plusBundles = new Set<Id>();
    Set<Id> bundleIds = new Set<Id>();
    for (Product2 product : products.values()) {
      if (
        product.RecordType != null &&
        product.RecordType.DeveloperName == BUNDLE
      ) {
        bundleIds.add(product.Id);
      }
    }
    if (!bundleIds.isEmpty()) {
      for (BundleComponent__c component : [
        SELECT Bundle__c, Product__r.Categoria_Articolo__c
        FROM BundleComponent__c
        WHERE Bundle__c IN :bundleIds
      ]) {
        if (
          plusCategories.containsKey(component.Product__r.Categoria_Articolo__c)
        ) {
          plusBundles.add(component.Bundle__c);
        }
      }
    }
    Set<String> types = new Set<String>();
    for (Product2 product : products.values()) {
      if (
        plusCategories.containsKey(product.Categoria_Articolo__c) ||
        plusBundles.contains(product.Id)
      ) {
        types.add(PLUS);
      } else if (bundleIds.contains(product.Id)) {
        types.add(BUNDLE);
      } else if (
        product.RecordType != null &&
        product.RecordType.DeveloperName == ITEM
      ) {
        types.add(ITEM);
      } else {
        throw new ClassificationException(
          'Tipo prodotto non supportato per il contratto.'
        );
      }
    }
    if (types.size() != 1) {
      throw new ClassificationException(
        'Un ordine WooCommerce deve contenere una sola categoria di contratto.'
      );
    }
    return new List<String>(types)[0];
  }

  public class ClassificationException extends Exception {
  }

  // Visualforce controller: loads the committed order and its lines.
  private static final Integer MAX_LINES = 500;
  public Order orderRecord { get; private set; }
  public List<LineRow> lines { get; private set; }
  public String currencyCode { get; private set; }
  public String generatedDate { get; private set; }
  private Decimal grossTotal = 0;
  private Boolean plusRenewal = false;

  public OrderPdfService() {
    Id orderId;
    try {
      orderId = (Id) ApexPages.currentPage().getParameters().get('id');
    } catch (Exception error) {
      throw new OrderPdfException('Ordine non valido.');
    }
    // Guard the page as well as the service: direct page URLs cannot bypass origin checks.
    requireWooCommerceOrder(orderId);
    Boolean multiCurrency = Schema.SObjectType.Order.fields.getMap()
      .containsKey('CurrencyIsoCode');
    String queryText =
      'SELECT Id, OrderNumber, EffectiveDate, TotalAmount, Origine__c, Contract_Pdf_Type__c, ' +
      'BillingStreet, BillingPostalCode, BillingCity, BillingState, BillingCountry, ' +
      'toLabel(Condizione_di_Pagamento__c), Account.Name, Account.BillingStreet, ' +
      'Account.BillingPostalCode, Account.BillingCity, Account.BillingState, Account.BillingCountry, ' +
      'Account.Partita_IVA__c, Account.Nome_Legale_Rappresentante__c, Account.PEC__c, Owner.Name' +
      (multiCurrency ? ', CurrencyIsoCode' : '') +
      ' FROM Order WHERE Id = :orderId';
    orderRecord = (Order) Database.query(queryText);
    currencyCode = multiCurrency
      ? (String) orderRecord.get('CurrencyIsoCode')
      : UserInfo.getDefaultCurrency();
    generatedDate = QuotePdfController.formatDate(orderRecord.EffectiveDate);
    List<OrderItem> items = [
      SELECT
        Id,
        Product2.Name,
        Product2.QuantityUnitOfMeasure,
        Product2.Categoria_Articolo__c,
        Description,
        Quantity,
        Prezzo_Listino__c,
        Discount_Pct__c,
        UnitPrice,
        TotalPrice,
        Data_Scadenza__c,
        Tranche__r.Data_Scadenza__c
      FROM OrderItem
      WHERE OrderId = :orderId
      ORDER BY CreatedDate, Id
      LIMIT 501
    ];
    if (items.isEmpty() || items.size() > MAX_LINES) {
      throw new OrderPdfException(
        'Il PDF ordine richiede da 1 a 500 righe prodotto.'
      );
    }
    Map<String, String> plusCategories = PerformancePlusContractService.contractTypeByCategory();
    lines = new List<LineRow>();
    for (OrderItem item : items) {
      LineRow row = new LineRow(item);
      lines.add(row);
      grossTotal += item.Quantity * resolveUnitListPrice(item);
      if (
        plusCategories.get(item.Product2.Categoria_Articolo__c) == 'Rinnovo'
      ) {
        plusRenewal = true;
      }
    }
  }

  public String getCustomerName() {
    return orderRecord.Account == null ? '' : orderRecord.Account.Name;
  }
  public String getLegalAddress() {
    Account customer = orderRecord.Account;
    return customer == null
      ? ''
      : address(
          customer.BillingStreet,
          customer.BillingPostalCode,
          customer.BillingCity,
          customer.BillingState,
          customer.BillingCountry
        );
  }
  public String getBillingAddress() {
    String result = address(
      orderRecord.BillingStreet,
      orderRecord.BillingPostalCode,
      orderRecord.BillingCity,
      orderRecord.BillingState,
      orderRecord.BillingCountry
    );
    return String.isBlank(result) ? getLegalAddress() : result;
  }
  public String getListPriceTotal() {
    return QuotePdfController.money(grossTotal);
  }
  public String getDiscountTotal() {
    return QuotePdfController.money(grossTotal - orderRecord.TotalAmount);
  }
  public String getTotalPrice() {
    return QuotePdfController.money(orderRecord.TotalAmount);
  }
  public String getGrandTotal() {
    return getTotalPrice();
  }
  public String getTutor() {
    return orderRecord.Owner.Name;
  }
  public Boolean getIsPlusOpportunity() {
    return orderRecord.Contract_Pdf_Type__c == 'Plus';
  }
  public Boolean getIsPerformancePlusRenewal() {
    return plusRenewal;
  }

  private static Decimal resolveUnitListPrice(OrderItem item) {
    // Use the original price captured by the import. For historical lines with
    // no captured list price, retain the net price rather than invent a discount.
    return item.Prezzo_Listino__c == null
      ? item.UnitPrice
      : item.Prezzo_Listino__c;
  }

  private static String address(
    String street,
    String postalCode,
    String city,
    String state,
    String country
  ) {
    List<String> parts = new List<String>();
    for (
      String part : new List<String>{ street, postalCode, city, state, country }
    ) {
      if (String.isNotBlank(part)) {
        parts.add(part);
      }
    }
    return String.join(parts, ' ');
  }

  public class LineRow {
    public String name { get; private set; }
    public String description { get; private set; }
    public String unitOfMeasure { get; private set; }
    public Decimal quantity { get; private set; }
    public String listPrice { get; private set; }
    public String amount { get; private set; }
    public String discount { get; private set; }
    public String total { get; private set; }
    public String dueDate { get; private set; }

    public LineRow(OrderItem item) {
      name = item.Product2.Name;
      description = item.Description;
      unitOfMeasure = item.Product2.QuantityUnitOfMeasure;
      quantity = item.Quantity;
      Decimal unitListPrice = OrderPdfService.resolveUnitListPrice(item);
      Decimal gross = item.Quantity * unitListPrice;
      listPrice = QuotePdfController.money(unitListPrice);
      amount = QuotePdfController.money(gross);
      discount = QuotePdfController.percentage(item.Discount_Pct__c);
      total = QuotePdfController.money(item.TotalPrice);
      dueDate = QuotePdfController.formatDate(
        item.Data_Scadenza__c != null
          ? item.Data_Scadenza__c
          : item.Tranche__r?.Data_Scadenza__c
      );
    }
  }

  // Queueable entry point: renders in a separate transaction after import commits.
  private Id queuedOrderId;

  public OrderPdfService(Id orderId) {
    this.queuedOrderId = orderId;
  }

  public void execute(QueueableContext context) {
    try {
      generatePdf(queuedOrderId);
    } catch (Exception error) {
      insert new Integration_Log__c(
        Flow_Name__c = 'OrderPdfService.generatePdf',
        Is_Error__c = true,
        Exception_Message__c = ('Order ' +
          queuedOrderId +
          ': ' +
          error.getMessage())
          .left(32768),
        Exception_StackTrace__c = error.getStackTraceString().left(32768)
      );
    }
  }
}
