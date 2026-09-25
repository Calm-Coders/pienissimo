public without sharing class DocuSignQuoteEnvelopeService {
  private static final String ACTION_CREATE_ENVELOPE = 'DocuSign_Create_Envelope';
  private static final String DEFAULT_NAMED_CREDENTIAL = 'DocuSign';
  private static final String CONTENT_TYPE_JSON = 'application/json';
  private static final String SIGNATURE_TITLE_TOKEN = 'da firmare';
  private static final String STATUS_SENT = 'Sent';
  private static final String STATUS_COMPLETED = 'Completed';
  private static final String STATUS_DECLINED = 'Declined';
  private static final String STATUS_ERROR = 'Error';
  private static final String QUOTE_ACCEPTED_STATUS = 'Accettato';

  private static final Boolean IS_SANDBOX = [
    SELECT IsSandbox
    FROM Organization
    LIMIT 1
  ]
  .IsSandbox;

  public class DocuSignEnvelopeException extends Exception {
  }

  private class SigningDocument {
    public String title;
    public String fileExtension;
    public Blob body;
  }

  public static void enqueue(Id quoteId) {
    System.enqueueJob(new DocuSignQuoteEnvelopeQueueable(quoteId));
  }

  public static void sendEnvelope(Id quoteId) {
    try {
      Quote quoteRecord = loadQuote(quoteId, true);
      validateReadyToSend(quoteRecord);

      SigningDocument document = loadSigningDocument(quoteId);
      String requestBody = buildEnvelopeRequest(quoteRecord, document);
      HttpRequest request = buildRequest(requestBody);
      Integration_Log__c logRow = buildLog(request);

      Long sentAt = Datetime.now().getTime();
      HttpResponse response = new Http().send(request);
      Long receivedAt = Datetime.now().getTime();

      logResponse(logRow, response, sentAt, receivedAt);
      insert logRow;

      if (isErrorStatusCode(response.getStatusCode())) {
        markQuoteError(quoteId);
        return;
      }

      String envelopeId = parseEnvelopeId(response.getBody());
      if (String.isBlank(envelopeId)) {
        markQuoteError(quoteId);
        throw new DocuSignEnvelopeException(
          'DocuSign did not return an envelope id.'
        );
      }

      update new Quote(
        Id = quoteId,
        DocuSign_Envelope_Id__c = envelopeId,
        DocuSign_Status__c = STATUS_SENT
      );
    } catch (Exception error) {
      markQuoteError(quoteId);
      logException(error);
    }
  }

  public static void markCompleted(String envelopeId) {
    if (String.isBlank(envelopeId)) {
      throw new DocuSignEnvelopeException('Envelope id obbligatorio.');
    }

    List<Quote> quotes = [
      SELECT Id
      FROM Quote
      WHERE DocuSign_Envelope_Id__c = :envelopeId
      LIMIT 1
      FOR UPDATE
    ];
    if (quotes.isEmpty()) {
      throw new DocuSignEnvelopeException(
        'Nessun preventivo trovato per envelope DocuSign ' + envelopeId + '.'
      );
    }

    update new Quote(
      Id = quotes[0].Id,
      DocuSign_Status__c = STATUS_COMPLETED,
      Status = QUOTE_ACCEPTED_STATUS,
      Is_Signed__c = true
    );
  }

  public static void markDeclined(String envelopeId) {
    if (String.isBlank(envelopeId)) {
      throw new DocuSignEnvelopeException('Envelope id obbligatorio.');
    }

    List<Quote> quotes = [
      SELECT Id
      FROM Quote
      WHERE DocuSign_Envelope_Id__c = :envelopeId
      LIMIT 1
      FOR UPDATE
    ];
    if (quotes.isEmpty()) {
      throw new DocuSignEnvelopeException(
        'Nessun preventivo trovato per envelope DocuSign ' + envelopeId + '.'
      );
    }

    update new Quote(Id = quotes[0].Id, DocuSign_Status__c = STATUS_DECLINED);
  }

  private static Quote loadQuote(Id quoteId, Boolean lockRecord) {
    if (quoteId == null || quoteId.getSObjectType() != Quote.SObjectType) {
      throw new DocuSignEnvelopeException('Preventivo non valido.');
    }

    String queryText =
      'SELECT Id, Name, QuoteNumber, AccountId, DocuSign_Envelope_Id__c, ' +
      'DocuSign_Status__c, Email, Account.Name, ' +
      'Account.Nome_Legale_Rappresentante__c ' +
      'FROM Quote WHERE Id = :quoteId LIMIT 1';
    if (lockRecord) {
      queryText += ' FOR UPDATE';
    }

    List<Quote> quotes = Database.query(queryText);
    if (quotes.isEmpty()) {
      throw new DocuSignEnvelopeException('Preventivo non disponibile.');
    }
    return quotes[0];
  }

  private static void validateReadyToSend(Quote quoteRecord) {
    if (quoteRecord.AccountId == null) {
      throw new DocuSignEnvelopeException(
        'Collega il preventivo a un account prima di inviare DocuSign.'
      );
    }
    if (quoteRecord.Account == null || String.isBlank(quoteRecord.Email)) {
      throw new DocuSignEnvelopeException('Email mancante sul preventivo.');
    }
    if (quoteRecord.DocuSign_Status__c == STATUS_COMPLETED) {
      throw new DocuSignEnvelopeException(
        'Il preventivo ha gia una richiesta DocuSign attiva.'
      );
    }
    if (
      quoteRecord.DocuSign_Status__c == STATUS_SENT &&
      String.isNotBlank(quoteRecord.DocuSign_Envelope_Id__c)
    ) {
      throw new DocuSignEnvelopeException(
        'Il preventivo ha gia una richiesta DocuSign attiva.'
      );
    }
  }

  private static SigningDocument loadSigningDocument(Id quoteId) {
    String titlePattern = '%' + SIGNATURE_TITLE_TOKEN + '%';
    List<ContentDocumentLink> links = [
      SELECT
        ContentDocumentId,
        ContentDocument.Title,
        ContentDocument.FileExtension
      FROM ContentDocumentLink
      WHERE
        LinkedEntityId = :quoteId
        AND ContentDocument.Title LIKE :titlePattern
      ORDER BY ContentDocument.LastModifiedDate DESC
      LIMIT 1
    ];

    if (links.isEmpty()) {
      throw new DocuSignEnvelopeException(
        'Nessun PDF da firmare collegato al preventivo.'
      );
    }

    ContentVersion version = [
      SELECT Title, FileExtension, VersionData
      FROM ContentVersion
      WHERE ContentDocumentId = :links[0].ContentDocumentId AND IsLatest = TRUE
      LIMIT 1
    ];

    SigningDocument document = new SigningDocument();
    document.title = String.isBlank(version.Title)
      ? links[0].ContentDocument.Title
      : version.Title;
    document.fileExtension = String.isBlank(version.FileExtension)
      ? links[0].ContentDocument.FileExtension
      : version.FileExtension;
    document.body = version.VersionData;
    return document;
  }

  private static String buildEnvelopeRequest(
    Quote quoteRecord,
    SigningDocument document
  ) {
    String recipientEmail = quoteRecord.Email;
    String recipientName = resolveRecipientName(quoteRecord);
    String fileExtension = String.isBlank(document.fileExtension)
      ? 'pdf'
      : document.fileExtension.toLowerCase();

    Map<String, Object> envelope = new Map<String, Object>{
      'emailSubject' => 'Preventivo ' +
      quoteRecord.QuoteNumber +
      ' - firma digitale',
      'documents' => new List<Object>{
        new Map<String, Object>{
          'documentBase64' => EncodingUtil.base64Encode(document.body),
          'name' => document.title +
          '.' +
          fileExtension,
          'fileExtension' => fileExtension,
          'documentId' => '1'
        }
      },
      'recipients' => new Map<String, Object>{
        'signers' => new List<Object>{
          new Map<String, Object>{
            'email' => recipientEmail.trim(),
            'name' => recipientName,
            'recipientId' => '1',
            'routingOrder' => '1',
            'tabs' => new Map<String, Object>{
              'signHereTabs' => new List<Object>{
                new Map<String, Object>{
                  'anchorString' => '/sig1/',
                  'anchorUnits' => 'pixels',
                  'anchorXOffset' => '0',
                  'anchorYOffset' => '0'
                }
              }
            }
          }
        }
      },
      'status' => 'sent'
    };

    return JSON.serialize(envelope);
  }

  private static String resolveRecipientName(Quote quoteRecord) {
    List<Contact> principalContacts = [
      SELECT Name, Email
      FROM Contact
      WHERE AccountId = :quoteRecord.AccountId AND Contatto_Principale__c = TRUE
      ORDER BY LastModifiedDate DESC
      LIMIT 1
    ];
    if (!principalContacts.isEmpty()) {
      return principalContacts[0].Name;
    }

    if (
      quoteRecord.Account != null &&
      String.isNotBlank(quoteRecord.Account.Nome_Legale_Rappresentante__c)
    ) {
      return quoteRecord.Account.Nome_Legale_Rappresentante__c;
    }

    return quoteRecord.Account == null ? 'Cliente' : quoteRecord.Account.Name;
  }

  private static HttpRequest buildRequest(String requestBody) {
    Integration_Configuration2__c config = resolveConfiguration();
    if (config == null || String.isBlank(config.Endpoint_Path__c)) {
      throw new DocuSignEnvelopeException(
        'Configurazione DocuSign_Create_Envelope mancante.'
      );
    }

    String namedCredential = IS_SANDBOX
      ? config.Named_Credential_Sandbox__c
      : config.Named_Credential_Prod__c;
    if (String.isBlank(namedCredential)) {
      namedCredential = DEFAULT_NAMED_CREDENTIAL;
    }

    HttpRequest request = new HttpRequest();
    request.setEndpoint(
      'callout:' + namedCredential + normalizePath(config.Endpoint_Path__c)
    );
    request.setMethod(
      String.isBlank(config.HTTP_Method__c) ? 'POST' : config.HTTP_Method__c
    );
    request.setHeader('Content-Type', CONTENT_TYPE_JSON);
    request.setHeader('Accept', CONTENT_TYPE_JSON);
    request.setTimeout(
      config.Timeout__c == null ? 120000 : Integer.valueOf(config.Timeout__c)
    );
    request.setBody(requestBody);
    return request;
  }

  private static Integration_Configuration2__c resolveConfiguration() {
    List<Integration_Configuration2__c> configs = [
      SELECT
        Azione__c,
        Endpoint_Path__c,
        HTTP_Method__c,
        Name,
        Named_Credential_Prod__c,
        Named_Credential_Sandbox__c,
        Timeout__c
      FROM Integration_Configuration2__c
      WHERE
        Azione__c = :ACTION_CREATE_ENVELOPE
        OR Name = :ACTION_CREATE_ENVELOPE
      ORDER BY Name
      LIMIT 1
    ];
    return configs.isEmpty() ? null : configs[0];
  }

  private static String normalizePath(String path) {
    return path.startsWith('/') ? path : '/' + path;
  }

  private static Integration_Log__c buildLog(HttpRequest request) {
    return new Integration_Log__c(
      Flow_Name__c = ACTION_CREATE_ENVELOPE,
      Inbound_Outbound__c = 'Outbound',
      Request_Endpoint__c = request.getEndpoint(),
      Request_Body__c = 'DocuSign envelope create request with PDF omitted from log.'
    );
  }

  private static void logResponse(
    Integration_Log__c logRow,
    HttpResponse response,
    Long sentAt,
    Long receivedAt
  ) {
    logRow.Response_State__c = String.valueOf(response.getStatusCode());
    logRow.Is_Error__c = isErrorStatusCode(response.getStatusCode());
    logRow.Response_Body__c = abbreviate(
      'Elapsed ms: ' +
        String.valueOf(receivedAt - sentAt) +
        '\n' +
        response.getBody()
    );
  }

  private static void logException(Exception error) {
    try {
      insert new Integration_Log__c(
        Flow_Name__c = ACTION_CREATE_ENVELOPE,
        Inbound_Outbound__c = 'Outbound',
        Is_Error__c = true,
        Exception_Message__c = abbreviate(
          error.getTypeName() + '\n' + error.getMessage()
        ),
        Exception_StackTrace__c = abbreviate(error.getStackTraceString())
      );
    } catch (Exception ignored) {
    }
  }

  private static void markQuoteError(Id quoteId) {
    if (quoteId == null) {
      return;
    }
    try {
      update new Quote(Id = quoteId, DocuSign_Status__c = STATUS_ERROR);
    } catch (Exception ignored) {
    }
  }

  private static String parseEnvelopeId(String responseBody) {
    if (String.isBlank(responseBody)) {
      return null;
    }
    Map<String, Object> body = (Map<String, Object>) JSON.deserializeUntyped(
      responseBody
    );
    Object envelopeId = body.get('envelopeId');
    return envelopeId == null ? null : String.valueOf(envelopeId);
  }

  private static Boolean isErrorStatusCode(Integer statusCode) {
    return statusCode == null || statusCode < 200 || statusCode >= 300;
  }

  private static String abbreviate(String value) {
    return value == null ? null : value.abbreviate(131072);
  }
}
