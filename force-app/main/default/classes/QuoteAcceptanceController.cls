public without sharing class QuoteAcceptanceController {
  private static final String READY_STATE = 'READY';
  private static final String ACCEPTED_STATE = 'ACCEPTED';
  private static final String REJECTED_STATE = 'REJECTED';
  private static final String LOCKED_STATE = 'LOCKED';
  private static final String SIGNING_STATE = 'SIGNING';
  private static final String ACCEPT_ACTION = 'accept';
  private static final String REJECT_ACTION = 'reject';
  private static final String ACCEPTED_STATUS = 'Accettato';
  private static final String REJECTED_STATUS = 'Rifiutato';
  private static final String DOCUSIGN_STATUS_SENT = 'Sent';
  private static final String DOCUSIGN_STATUS_COMPLETED = 'Completed';
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
    public String productCode { get; set; }
    @AuraEnabled
    public Decimal quantity { get; set; }
    @AuraEnabled
    public Decimal unitPrice { get; set; }
    @AuraEnabled
    public Decimal totalPrice { get; set; }
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
        ensureCanSendDocuSign(quoteRecord);
        update new Quote(
          Id = quoteRecord.Id,
          Status = ACCEPTED_STATUS,
          DocuSign_Status__c = DOCUSIGN_STATUS_SENT
        );
        DocuSignQuoteEnvelopeService.enqueue(quoteRecord.Id);
      } else {
        update new Quote(Id = quoteRecord.Id, Status = REJECTED_STATUS);
      }

      String message = normalizedAction == ACCEPT_ACTION
        ? 'Il preventivo e stato confermato. La richiesta di firma e stata inviata al contatto principale.'
        : 'Il preventivo e stato annullato.';
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

    for (QuoteLineItem line : [
      SELECT
        Id,
        Quantity,
        UnitPrice,
        TotalPrice,
        Product2.Name,
        Product2.ProductCode
      FROM QuoteLineItem
      WHERE QuoteId = :quoteId
      ORDER BY CreatedDate, Id
    ]) {
      QuoteLineRow row = new QuoteLineRow();
      row.id = line.Id;
      row.productName = line.Product2 == null ? null : line.Product2.Name;
      row.productCode = line.Product2 == null
        ? null
        : line.Product2.ProductCode;
      row.quantity = line.Quantity;
      row.unitPrice = line.UnitPrice;
      row.totalPrice = line.TotalPrice;
      response.lines.add(row);
    }

    return response;
  }

  private static Quote queryQuote(Id quoteId, Boolean lockRecord) {
    String queryText =
      'SELECT Id, Name, QuoteNumber, Status, ExpirationDate, Subtotal, ' +
      'TotalPrice, GrandTotal, DocuSign_Status__c, DocuSign_Envelope_Id__c, ' +
      'Account.Name, Account.Email_Contatto_Principale__c, Opportunity.Name ' +
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
    if (status == ACCEPTED_STATUS) {
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
    if (
      quoteRecord.Account == null ||
      String.isBlank(quoteRecord.Account.Email_Contatto_Principale__c)
    ) {
      throw new RequestException(
        'Email contatto principale mancante. Contatta il referente Pienissimo.'
      );
    }
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
