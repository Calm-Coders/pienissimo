public without sharing class QuoteAcceptanceController {
  private static final String READY_STATE = 'READY';
  private static final String ACCEPTED_STATE = 'ACCEPTED';
  private static final String REJECTED_STATE = 'REJECTED';
  private static final String LOCKED_STATE = 'LOCKED';
  private static final String SIGNING_STATE = 'SIGNING';
  private static final String ACCEPT_ACTION = 'accept';
  private static final String REJECT_ACTION = 'reject';
  private static final String ACCEPTED_STATUS = 'Accettato';
  private static final String SIGNED_STATUS = 'Firmato';
  private static final String REJECTED_STATUS = 'Rifiutato';
  private static final String DOCUSIGN_STATUS_SENT = 'Sent';
  private static final String DOCUSIGN_STATUS_COMPLETED = 'Completed';
  private static final String BUNDLE_RECORD_TYPE = 'Bundle';
  private static final String PLUS_RENEWAL_OPPORTUNITY_TYPE = 'Performance Plus - Rinnovo';
  private static final Set<String> ACTIONABLE_STATUSES = new Set<String>{
    'In Trattativa',
    'In Attesa Accettazione'
  };

  public class QuoteLineRow {
    @AuraEnabled
    public Id id { get; set; }
    @AuraEnabled
    public String productName { get; set; }
    @AuraEnabled
    public String description { get; set; }
    @AuraEnabled
    public String unitOfMeasure { get; set; }
    @AuraEnabled
    public Decimal quantity { get; set; }
    @AuraEnabled
    public Decimal listPrice { get; set; }
    @AuraEnabled
    public Decimal amount { get; set; }
    @AuraEnabled
    public Decimal discount { get; set; }
    @AuraEnabled
    public Decimal totalPrice { get; set; }
    @AuraEnabled
    public Date dueDate { get; set; }
  }

  public class PageResponse {
    @AuraEnabled
    public String state { get; set; }
    @AuraEnabled
    public String message { get; set; }
    @AuraEnabled
    public Boolean canAct { get; set; }
    @AuraEnabled
    public String quoteId { get; set; }
    @AuraEnabled
    public String quoteName { get; set; }
    @AuraEnabled
    public String quoteNumber { get; set; }
    @AuraEnabled
    public String status { get; set; }
    @AuraEnabled
    public String docusignStatus { get; set; }
    @AuraEnabled
    public String accountName { get; set; }
    @AuraEnabled
    public String opportunityName { get; set; }
    @AuraEnabled
    public Date expirationDate { get; set; }
    @AuraEnabled
    public Decimal subtotal { get; set; }
    @AuraEnabled
    public Decimal totalPrice { get; set; }
    @AuraEnabled
    public Decimal grandTotal { get; set; }
    @AuraEnabled
    public List<QuoteLineRow> lines { get; set; }

    public PageResponse() {
      lines = new List<QuoteLineRow>();
    }
  }

  private class RequestException extends Exception {
  }

  @AuraEnabled(cacheable=true)
  public static PageResponse loadPage(String quoteId) {
    try {
      Id parsedQuoteId = parseQuoteId(quoteId);
      if (parsedQuoteId == null) {
        throw invalidLink();
      }
      return buildPage(parsedQuoteId, null);
    } catch (RequestException requestError) {
      throw handled(requestError.getMessage());
    } catch (Exception unexpectedError) {
      throw handled(
        'Non e stato possibile completare la richiesta. Riprova piu tardi.'
      );
    }
  }

  @AuraEnabled
  public static PageResponse submitAction(String quoteId, String action) {
    Savepoint savepoint = Database.setSavepoint();

    try {
      Id parsedQuoteId = parseQuoteId(quoteId);
      String normalizedAction = normalizeAction(action);

      if (parsedQuoteId == null) {
        throw invalidLink();
      }
      if (normalizedAction == null) {
        throw new RequestException(
          'Seleziona una azione valida per il preventivo.'
        );
      }

      Quote quoteRecord = queryQuote(parsedQuoteId, true);
      if (!ACTIONABLE_STATUSES.contains(quoteRecord.Status)) {
        throw new RequestException(
          'Il preventivo non puo essere modificato da questo collegamento.'
        );
      }

      if (normalizedAction == ACCEPT_ACTION) {
        if (isPerformancePlusRenewal(quoteRecord)) {
          update new Quote(
            Id = quoteRecord.Id,
            Status = SIGNED_STATUS,
            Is_Signed__c = true
          );
        } else {
          ensureCanSendDocuSign(quoteRecord);
          update new Quote(
            Id = quoteRecord.Id,
            Status = ACCEPTED_STATUS,
            DocuSign_Status__c = DOCUSIGN_STATUS_SENT
          );
          DocuSignQuoteEnvelopeService.enqueue(quoteRecord.Id);
        }
      } else {
        update new Quote(Id = quoteRecord.Id, Status = REJECTED_STATUS);
      }

      String message;
      if (normalizedAction == REJECT_ACTION) {
        message = 'Il preventivo e stato annullato.';
      } else if (isPerformancePlusRenewal(quoteRecord)) {
        message = 'Il rinnovo Performance Plus e stato confermato. Non e richiesta la firma.';
      } else {
        message = 'Il preventivo e stato confermato. La richiesta di firma e stata inviata al contatto principale.';
      }
      return buildPage(parsedQuoteId, message);
    } catch (RequestException requestError) {
      Database.rollback(savepoint);
      throw handled(requestError.getMessage());
    } catch (Exception unexpectedError) {
      Database.rollback(savepoint);
      throw handled(
        'Non e stato possibile completare la richiesta. Riprova piu tardi.'
      );
    }
  }

  private static PageResponse buildPage(Id quoteId, String actionMessage) {
    Quote quoteRecord = queryQuote(quoteId, false);
    PageResponse response = new PageResponse();
    response.quoteId = quoteRecord.Id;
    response.quoteName = String.isBlank(quoteRecord.Name)
      ? quoteRecord.QuoteNumber
      : quoteRecord.Name;
    response.quoteNumber = quoteRecord.QuoteNumber;
    response.status = quoteRecord.Status;
    response.docusignStatus = quoteRecord.DocuSign_Status__c;
    response.accountName = quoteRecord.Account == null
      ? null
      : quoteRecord.Account.Name;
    response.opportunityName = quoteRecord.Opportunity == null
      ? null
      : quoteRecord.Opportunity.Name;
    response.expirationDate = quoteRecord.ExpirationDate;
    response.subtotal = quoteRecord.Subtotal;
    response.totalPrice = quoteRecord.TotalPrice;
    response.grandTotal = quoteRecord.GrandTotal;
    response.canAct = canSubmitAction(quoteRecord);
    response.state = stateForStatus(quoteRecord);
    response.message = String.isBlank(actionMessage)
      ? defaultMessage(response.state)
      : actionMessage;

    List<QuoteLineItem> quoteLines = [
      SELECT
        Id,
        Description,
        Quantity,
        ListPrice,
        UnitPrice,
        Discount,
        Discount_Pct__c,
        TotalPrice,
        Data_Scadenza__c,
        Tranche__r.Data_Scadenza__c,
        Product2Id,
        Product2.Name,
        Product2.QuantityUnitOfMeasure,
        Product2.RecordType.DeveloperName
      FROM QuoteLineItem
      WHERE QuoteId = :quoteId
      ORDER BY CreatedDate, Id
    ];

    Map<Id, List<BundleComponent__c>> componentsByBundleId = bundleComponentsByBundleId(
      quoteLines
    );
    for (QuoteLineItem line : quoteLines) {
      List<BundleComponent__c> components = componentsByBundleId.get(
        line.Product2Id
      );
      if (isBundleLine(line)) {
        if (components == null || components.isEmpty()) {
          throw new RequestException(
            'Il bundle del preventivo non contiene prodotti collegati. Contatta il tuo referente Pienissimo.'
          );
        }
        for (BundleComponent__c component : components) {
          response.lines.add(bundleComponentRow(line, component));
        }
        continue;
      }

      response.lines.add(quoteLineRow(line));
    }

    return response;
  }

  private static Map<Id, List<BundleComponent__c>> bundleComponentsByBundleId(
    List<QuoteLineItem> quoteLines
  ) {
    Set<Id> bundleIds = new Set<Id>();
    for (QuoteLineItem line : quoteLines) {
      if (isBundleLine(line)) {
        bundleIds.add(line.Product2Id);
      }
    }

    Map<Id, List<BundleComponent__c>> componentsByBundleId = new Map<Id, List<BundleComponent__c>>();
    if (bundleIds.isEmpty()) {
      return componentsByBundleId;
    }

    for (BundleComponent__c component : [
      SELECT
        Id,
        Bundle__c,
        Quantity__c,
        Spread_Price__c,
        Unit_Spread__c,
        Product__r.Name,
        Product__r.Description,
        Product__r.QuantityUnitOfMeasure,
        Bundle_Tranch__r.Data_Scadenza__c
      FROM BundleComponent__c
      WHERE Bundle__c IN :bundleIds
      ORDER BY Bundle_Tranch__r.Sequenza__c, Product__r.Name, Id
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

  private static Boolean isBundleLine(QuoteLineItem line) {
    return line.Product2 != null &&
      line.Product2.RecordType != null &&
      line.Product2.RecordType.DeveloperName == BUNDLE_RECORD_TYPE;
  }

  private static QuoteLineRow quoteLineRow(QuoteLineItem line) {
    QuoteLineRow row = new QuoteLineRow();
    row.id = line.Id;
    row.productName = line.Product2 == null ? null : line.Product2.Name;
    row.description = line.Description;
    row.unitOfMeasure = line.Product2 == null
      ? null
      : line.Product2.QuantityUnitOfMeasure;
    row.quantity = line.Quantity;
    row.listPrice = line.ListPrice;
    row.amount =
      (line.Quantity == null ? 0 : line.Quantity) *
      (line.ListPrice == null ? 0 : line.ListPrice);
    row.discount = row.amount - (line.TotalPrice == null ? 0 : line.TotalPrice);
    row.totalPrice = line.TotalPrice;
    row.dueDate = quoteLineDueDate(line);
    return row;
  }

  private static QuoteLineRow bundleComponentRow(
    QuoteLineItem bundleLine,
    BundleComponent__c component
  ) {
    Decimal bundleQuantity = bundleLine.Quantity == null
      ? 0
      : bundleLine.Quantity;
    Decimal componentQuantity = component.Quantity__c == null
      ? 0
      : component.Quantity__c;
    Decimal unitPrice = component.Unit_Spread__c == null
      ? 0
      : component.Unit_Spread__c;

    QuoteLineRow row = new QuoteLineRow();
    row.id = component.Id;
    row.productName = component.Product__r == null
      ? null
      : component.Product__r.Name;
    row.description = component.Product__r == null
      ? null
      : component.Product__r.Description;
    row.unitOfMeasure = component.Product__r == null
      ? null
      : component.Product__r.QuantityUnitOfMeasure;
    row.quantity = bundleQuantity * componentQuantity;
    row.listPrice = unitPrice;
    row.amount =
      bundleQuantity *
      (component.Spread_Price__c == null ? 0 : component.Spread_Price__c);
    row.discount = 0;
    row.totalPrice = row.amount;
    row.dueDate = quoteLineDueDate(bundleLine);
    if (row.dueDate == null && component.Bundle_Tranch__r != null) {
      row.dueDate = component.Bundle_Tranch__r.Data_Scadenza__c;
    }
    return row;
  }

  private static Date quoteLineDueDate(QuoteLineItem line) {
    return line.Data_Scadenza__c != null
      ? line.Data_Scadenza__c
      : (line.Tranche__r == null ? null : line.Tranche__r.Data_Scadenza__c);
  }

  private static Quote queryQuote(Id quoteId, Boolean lockRecord) {
    String queryText =
      'SELECT Id, Name, QuoteNumber, Status, ExpirationDate, Subtotal, ' +
      'TotalPrice, GrandTotal, DocuSign_Status__c, DocuSign_Envelope_Id__c, ' +
      'Email, Account.Name, Opportunity.Name, Opportunity.Tipo_Opportunita__c ' +
      'FROM Quote WHERE Id = :quoteId LIMIT 1';

    if (lockRecord) {
      queryText += ' FOR UPDATE';
    }

    List<Quote> quotes = Database.query(queryText);
    if (quotes.isEmpty()) {
      throw invalidLink();
    }
    return quotes[0];
  }

  private static String stateForStatus(String status) {
    if (status == ACCEPTED_STATUS || status == SIGNED_STATUS) {
      return ACCEPTED_STATE;
    }
    if (status == REJECTED_STATUS) {
      return REJECTED_STATE;
    }
    if (ACTIONABLE_STATUSES.contains(status)) {
      return READY_STATE;
    }
    return LOCKED_STATE;
  }

  private static Boolean canSubmitAction(Quote quoteRecord) {
    return ACTIONABLE_STATUSES.contains(quoteRecord.Status) &&
      quoteRecord.DocuSign_Status__c != DOCUSIGN_STATUS_SENT &&
      quoteRecord.DocuSign_Status__c != DOCUSIGN_STATUS_COMPLETED;
  }

  private static String stateForStatus(Quote quoteRecord) {
    if (
      ACTIONABLE_STATUSES.contains(quoteRecord.Status) &&
      quoteRecord.DocuSign_Status__c == DOCUSIGN_STATUS_SENT
    ) {
      return SIGNING_STATE;
    }
    return stateForStatus(quoteRecord.Status);
  }

  private static String defaultMessage(String state) {
    if (state == SIGNING_STATE) {
      return 'La richiesta di firma e gia stata inviata.';
    }
    if (state == ACCEPTED_STATE) {
      return 'Il preventivo e gia stato confermato.';
    }
    if (state == REJECTED_STATE) {
      return 'Il preventivo e gia stato annullato.';
    }
    if (state == LOCKED_STATE) {
      return 'Il preventivo non e disponibile per una azione da questo collegamento.';
    }
    return null;
  }

  private static void ensureCanSendDocuSign(Quote quoteRecord) {
    if (
      quoteRecord.DocuSign_Status__c == DOCUSIGN_STATUS_SENT ||
      quoteRecord.DocuSign_Status__c == DOCUSIGN_STATUS_COMPLETED
    ) {
      throw new RequestException(
        'La richiesta di firma DocuSign e gia stata inviata.'
      );
    }
    if (quoteRecord.Account == null || String.isBlank(quoteRecord.Email)) {
      throw new RequestException(
        'Email mancante sul preventivo. Contatta il referente Pienissimo.'
      );
    }
  }

  private static Boolean isPerformancePlusRenewal(Quote quoteRecord) {
    return quoteRecord.Opportunity != null &&
      quoteRecord.Opportunity.Tipo_Opportunita__c ==
      PLUS_RENEWAL_OPPORTUNITY_TYPE;
  }

  private static String normalizeAction(String action) {
    if (String.isBlank(action)) {
      return null;
    }

    String normalized = action.trim().toLowerCase();
    if (
      normalized == ACCEPT_ACTION ||
      normalized == 'confirm' ||
      normalized == 'conferma'
    ) {
      return ACCEPT_ACTION;
    }
    if (
      normalized == REJECT_ACTION ||
      normalized == 'cancel' ||
      normalized == 'annulla' ||
      normalized == 'rifiuta'
    ) {
      return REJECT_ACTION;
    }
    return null;
  }

  private static Id parseQuoteId(String rawId) {
    if (String.isBlank(rawId)) {
      return null;
    }

    try {
      Id recordId = (Id) rawId;
      return recordId.getSObjectType() == Quote.SObjectType ? recordId : null;
    } catch (Exception invalidId) {
      return null;
    }
  }

  private static RequestException invalidLink() {
    return new RequestException('Questo collegamento non e valido.');
  }

  private static AuraHandledException handled(String message) {
    return new AuraHandledException(message);
  }
}
