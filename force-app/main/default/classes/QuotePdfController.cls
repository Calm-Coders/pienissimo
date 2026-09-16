public without sharing class QuotePdfController {
  private static final Integer MAX_LINES = 500;
  public Quote quoteRecord { get; private set; }
  public List<LineRow> lines { get; private set; }
  public String currencyCode { get; private set; }
  public String generatedDate { get; private set; }

  public QuotePdfController() {
    String rawId = ApexPages.currentPage().getParameters().get('id');
    Id quoteId;
    try {
      quoteId = (Id) rawId;
    } catch (Exception e) {
      throw new QuotePdfException('Preventivo non valido.');
    }
    requireDraft(quoteId);
    Boolean multiCurrency = Schema.SObjectType.Quote.fields.getMap()
      .containsKey('CurrencyIsoCode');
    String queryText =
      'SELECT Id, Name, QuoteNumber, Status, ExpirationDate, Description, ' +
      'BillingName, BillingStreet, BillingPostalCode, BillingCity, BillingState, BillingCountry, ' +
      'Subtotal, TotalPrice, Tax, ShippingHandling, GrandTotal, Modalita_Pagamento_PDF__c, ' +
      'Account.Name, Account.BillingStreet, Account.BillingPostalCode, Account.BillingCity, ' +
      'Account.BillingState, Account.BillingCountry, Account.Partita_IVA__c, ' +
      'Account.Nome_Legale_Rappresentante__c, Account.PEC__c, Opportunity.Owner.Name' +
      (multiCurrency ? ', CurrencyIsoCode' : '') +
      ' FROM Quote WHERE Id = :quoteId';
    quoteRecord = (Quote) Database.queryWithBinds(
      queryText,
      new Map<String, Object>{ 'quoteId' => quoteId },
      AccessLevel.USER_MODE
    )[0];
    currencyCode = multiCurrency
      ? (String) quoteRecord.get('CurrencyIsoCode')
      : UserInfo.getDefaultCurrency();
    generatedDate = formatDate(Date.today());
    List<QuoteLineItem> items = [
      SELECT
        Id,
        Product2.Name,
        Description,
        Quantity,
        ListPrice,
        UnitPrice,
        Discount,
        TotalPrice,
        Data_Scadenza__c,
        Tranche__r.Data_Scadenza__c
      FROM QuoteLineItem
      WHERE QuoteId = :quoteId
      WITH USER_MODE
      ORDER BY SortOrder ASC NULLS LAST, CreatedDate ASC, Id ASC
      LIMIT 501
    ];
    if (items.isEmpty()) {
      throw new QuotePdfException(
        'Aggiungi almeno una riga al preventivo prima di generare il PDF.'
      );
    }
    if (items.size() > MAX_LINES) {
      throw new QuotePdfException(
        'Il PDF supporta al massimo 500 righe. Suddividi il preventivo.'
      );
    }
    lines = new List<LineRow>();
    for (QuoteLineItem item : items) {
      lines.add(new LineRow(item));
    }
  }

  public static Quote requireDraft(Id quoteId) {
    if (quoteId == null || quoteId.getSObjectType() != Quote.SObjectType) {
      throw new QuotePdfException('Preventivo non valido.');
    }
    List<Quote> records = [
      SELECT Id, QuoteNumber, Status
      FROM Quote
      WHERE Id = :quoteId
      WITH USER_MODE
    ];
    if (records.isEmpty()) {
      throw new QuotePdfException(
        'Preventivo non disponibile o accesso non consentito.'
      );
    }
    if (records[0].Status != 'Bozza') {
      throw new QuotePdfException(
        'Il PDF puo essere generato solo quando il preventivo e in Bozza.'
      );
    }
    return records[0];
  }

  public String getCustomerName() {
    return quoteRecord.Account == null
      ? quoteRecord.BillingName
      : quoteRecord.Account.Name;
  }
  public String getLegalAddress() {
    Account customer = quoteRecord.Account;
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
      quoteRecord.BillingStreet,
      quoteRecord.BillingPostalCode,
      quoteRecord.BillingCity,
      quoteRecord.BillingState,
      quoteRecord.BillingCountry
    );
    return String.isBlank(result) ? getLegalAddress() : result;
  }
  public String getExpirationDate() {
    return formatDate(quoteRecord.ExpirationDate);
  }
  public String getSubtotal() {
    return money(quoteRecord.Subtotal);
  }
  public String getTotalPrice() {
    return money(quoteRecord.TotalPrice);
  }
  public String getTax() {
    return money(quoteRecord.Tax);
  }
  public String getShipping() {
    return money(quoteRecord.ShippingHandling);
  }
  public String getGrandTotal() {
    return money(quoteRecord.GrandTotal);
  }
  public Boolean getHasTax() {
    return quoteRecord.Tax != null && quoteRecord.Tax != 0;
  }
  public Boolean getHasShipping() {
    return quoteRecord.ShippingHandling != null &&
      quoteRecord.ShippingHandling != 0;
  }
  public String getTutor() {
    return quoteRecord.Opportunity == null
      ? ''
      : quoteRecord.Opportunity.Owner.Name;
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
  public static String formatDate(Date value) {
    return value == null
      ? ''
      : String.valueOf(value.day()).leftPad(2, '0') +
        '/' +
        String.valueOf(value.month()).leftPad(2, '0') +
        '/' +
        value.year();
  }
  public static String money(Decimal value) {
    if (value == null) {
      return '';
    }
    String sign = value < 0 ? '-' : '';
    String raw = String.valueOf(value.abs().setScale(2));
    List<String> parts = raw.split('\\.');
    String whole = parts[0];
    String result = '';
    while (whole.length() > 3) {
      result = '.' + whole.right(3) + result;
      whole = whole.left(whole.length() - 3);
    }
    return sign +
      whole +
      result +
      ',' +
      (parts.size() > 1 ? parts[1].rightPad(2, '0') : '00');
  }
  public class LineRow {
    public String name { get; private set; }
    public String description { get; private set; }
    public Decimal quantity { get; private set; }
    public String listPrice { get; private set; }
    public String amount { get; private set; }
    public String discount { get; private set; }
    public String total { get; private set; }
    public String dueDate { get; private set; }
    public LineRow(QuoteLineItem item) {
      name = item.Product2.Name;
      description = item.Description;
      quantity = item.Quantity;
      listPrice = money(item.ListPrice);
      Decimal gross = item.Quantity * item.UnitPrice;
      amount = money(gross);
      discount = money(gross - item.TotalPrice);
      total = money(item.TotalPrice);
      dueDate = formatDate(
        item.Data_Scadenza__c != null
          ? item.Data_Scadenza__c
          : (item.Tranche__r == null ? null : item.Tranche__r.Data_Scadenza__c)
      );
    }
  }
  public class QuotePdfException extends Exception {
  }
}
