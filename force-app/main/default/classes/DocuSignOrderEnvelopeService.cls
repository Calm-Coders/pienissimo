public without sharing class DocuSignOrderEnvelopeService {
  public class OrderEnvelopeException extends Exception {
  }

  // Each order has its own searchable attempt history in the existing log object.
  // A committed Queued attempt is the reservation; an Order lock alone is released
  // by HTTP callouts and cannot prevent two concurrent sends.
  private static String flowName(Id orderId) {
    return 'DocuSign_Order_Envelope_' + orderId;
  }

  public static void enqueue(Id orderId) {
    System.enqueueJob(new DocuSignOrderEnvelopeQueueable(orderId));
  }

  @AuraEnabled(cacheable=true)
  public static String getLatestErrorMessage(Id orderId) {
    Map<String, String> details = getLatestErrorDetails(orderId);
    return details == null ? null : details.get('message');
  }

  @AuraEnabled(cacheable=true)
  public static Map<String, String> getLatestErrorDetails(Id orderId) {
    if (orderId == null) {
      return null;
    }
    List<Order> orders = [
      SELECT Id, DocuSign_Status__c, DocuSign_Error__c
      FROM Order
      WHERE Id = :orderId
      WITH USER_MODE
      LIMIT 1
    ];
    if (orders.isEmpty() || orders[0].DocuSign_Status__c != 'Error') {
      return null;
    }
    // Older failures predate the Order error field. After checking access to the
    // Order and its error fields, expose only that Order's latest error message and log ID.
    String errorFlow = flowName(orderId) + '_Error';
    List<Integration_Log__c> errors = [
      SELECT Id, Exception_Message__c
      FROM Integration_Log__c
      WHERE Flow_Name__c = :errorFlow AND Is_Error__c = TRUE
      ORDER BY CreatedDate DESC, Id DESC
      LIMIT 1
    ];
    String message = String.isNotBlank(orders[0].DocuSign_Error__c)
      ? orders[0].DocuSign_Error__c
      : (errors.isEmpty() ? null : errors[0].Exception_Message__c);
    return new Map<String, String>{
      'message' => message,
      'logId' => errors.isEmpty() ? null : String.valueOf(errors[0].Id)
    };
  }

  @AuraEnabled
  public static String retryDocuSign(Id orderId) {
    try {
      // The retry entry point honours record and field read access; the background
      // service writes tracking fields that agents intentionally cannot edit.
      List<Order> orders = [
        SELECT Id, DocuSign_Status__c, DocuSign_Envelope_Id__c
        FROM Order
        WHERE Id = :orderId
        WITH USER_MODE
        LIMIT 1
      ];
      if (orders.isEmpty()) {
        throw new OrderEnvelopeException('Ordine non disponibile.');
      }
      retryFailedOrder(orderId);
      return 'Reinvio contratto DocuSign avviato.';
    } catch (Exception error) {
      AuraHandledException handled = new AuraHandledException(
        error.getMessage()
      );
      handled.setMessage(error.getMessage());
      throw handled;
    }
  }

  private static void retryFailedOrder(Id orderId) {
    Order record = loadOrder(orderId);
    validateEligible(record);
    if (
      record.DocuSign_Status__c != 'Error' ||
      String.isNotBlank(record.DocuSign_Envelope_Id__c)
    ) {
      throw new OrderEnvelopeException(
        'Il reinvio e disponibile solo dopo un errore e senza un envelope gia collegato.'
      );
    }
    validatePreviousAttempt(orderId);
    enqueue(orderId);
  }

  // PDF rendering and the envelope HTTP call must run in different transactions.
  // Returns a committed reservation, including a snapshot of the exact signer/PDF.
  public static Id prepareEnvelope(Id orderId) {
    Order record = loadOrder(orderId);
    if (record.Origine__c != 'WooCommerce' || hasEnvelope(record)) {
      return null;
    }
    validateEligible(record);
    validatePreviousAttempt(orderId);
    // The PDF does not require a signer. Keep it available if recipient validation fails.
    Id documentId = OrderPdfService.generatePdf(orderId);
    ContentVersion document = [
      SELECT Id, FileExtension
      FROM ContentVersion
      WHERE ContentDocumentId = :documentId AND IsLatest = TRUE
      LIMIT 1
    ];
    if (document.FileExtension != 'pdf') {
      throw new OrderEnvelopeException(
        'Il file del contratto ordine deve essere un PDF.'
      );
    }

    // Recheck after rendering and lock before reserving the send.
    record = [
      SELECT
        Id,
        AccountId,
        Origine__c,
        Contract_Pdf_Type__c,
        Mexal_Integration_Status__c,
        Mexal_Order_Number__c,
        Mexal_Document_Number__c,
        DocuSign_Status__c,
        DocuSign_Envelope_Id__c
      FROM Order
      WHERE Id = :orderId
      FOR UPDATE
    ];
    if (hasEnvelope(record)) {
      return null;
    }
    validateEligible(record);
    validatePreviousAttempt(orderId);
    Contact recipient = primaryContact(record.AccountId);
    Integration_Log__c attempt = new Integration_Log__c(
      Flow_Name__c = flowName(orderId),
      Inbound_Outbound__c = 'Outbound',
      Response_State__c = 'Queued',
      Is_Error__c = false,
      Request_Body__c = JSON.serialize(
        new Map<String, Object>{
          'orderId' => orderId,
          'versionId' => document.Id,
          'contactId' => recipient.Id,
          'recipientName' => recipient.Name,
          'recipientEmail' => recipient.Email
        }
      )
    );
    insert attempt;
    return attempt.Id;
  }

  public static void sendEnvelope(Id orderId, Id attemptId) {
    Integration_Log__c attempt;
    Boolean uncertain = false;
    try {
      Order record = loadOrder(orderId);
      if (hasEnvelope(record)) {
        return;
      }
      validateEligible(record);
      attempt = [
        SELECT Id, Flow_Name__c, Request_Body__c, Response_State__c
        FROM Integration_Log__c
        WHERE Id = :attemptId
        LIMIT 1
      ];
      if (attempt.Flow_Name__c != flowName(orderId)) {
        attempt = null;
        throw new OrderEnvelopeException(
          'Tentativo DocuSign non disponibile per questo ordine.'
        );
      }
      if (attempt.Response_State__c != 'Queued') {
        // A repeated worker must not release an Unknown/Sent reservation.
        return;
      }
      Map<String, Object> snapshot = (Map<String, Object>) JSON.deserializeUntyped(
        attempt.Request_Body__c
      );
      Id versionId = (Id) String.valueOf(snapshot.get('versionId'));
      ContentVersion document = [
        SELECT Id, Title, FileExtension, VersionData
        FROM ContentVersion
        WHERE Id = :versionId
        LIMIT 1
      ];
      Contact recipient = primaryContact(record.AccountId);
      if (
        String.valueOf(recipient.Id) !=
        String.valueOf(snapshot.get('contactId')) ||
        recipient.Name != String.valueOf(snapshot.get('recipientName')) ||
        recipient.Email != String.valueOf(snapshot.get('recipientEmail'))
      ) {
        throw new OrderEnvelopeException(
          'Il contatto principale e cambiato. Ripreparare il contratto prima dell invio.'
        );
      }
      HttpRequest request = DocuSignQuoteEnvelopeService.buildRequest(
        buildEnvelopeBody(record.OrderNumber, document, recipient, attemptId)
      );
      // No DML precedes the callout. Persist only metadata, never the PDF/base64.
      uncertain = true;
      HttpResponse response = new Http().send(request);
      Integer code = response.getStatusCode();
      if (code < 200 || code >= 300) {
        uncertain =
          code >= 500 ||
          code == 408 ||
          code == 409 ||
          (response.getBody() != null &&
          response.getBody().contains('DUPLICATE_TRANSACTION_ID'));
        throw new OrderEnvelopeException(
          'DocuSign HTTP ' + code + ': ' + response.getBody().abbreviate(2000)
        );
      }
      Map<String, Object> body = (Map<String, Object>) JSON.deserializeUntyped(
        response.getBody()
      );
      String envelopeId = (String) body.get('envelopeId');
      if (String.isBlank(envelopeId)) {
        throw new OrderEnvelopeException(
          'DocuSign non ha restituito l envelope id. Verificare l invio prima di riprovare.'
        );
      }
      // Keep the returned id in the durable attempt even if the Order update fails.
      attempt.Response_State__c = 'Sent';
      attempt.Response_Body__c = envelopeId;
      attempt.Request_Endpoint__c = request.getEndpoint();
      update attempt;
      update new Order(
        Id = orderId,
        DocuSign_Envelope_Id__c = envelopeId,
        DocuSign_Status__c = 'Sent',
        DocuSign_Error__c = null
      );
    } catch (Exception error) {
      // Sent means an envelope is known to exist; never create another one.
      if (attempt != null) {
        if (
          attempt.Response_State__c != 'Sent' &&
          attempt.Response_State__c != 'Unknown'
        ) {
          attempt.Response_State__c = uncertain ? 'Unknown' : 'Error';
        }
        attempt.Is_Error__c = true;
        attempt.Exception_Message__c = error.getMessage().abbreviate(131072);
        attempt.Exception_StackTrace__c = error.getStackTraceString()
          .abbreviate(131072);
        update attempt;
      }
      recordFailure(orderId, error);
    }
  }

  public static void recordFailure(Id orderId, Exception error) {
    Order record = loadOrder(orderId);
    // A duplicate request must never turn an existing envelope into an Error.
    if (hasEnvelope(record)) {
      return;
    }
    update new Order(
      Id = orderId,
      DocuSign_Status__c = 'Error',
      DocuSign_Error__c = error.getMessage().abbreviate(131072)
    );
    insert new Integration_Log__c(
      Flow_Name__c = flowName(orderId) + '_Error',
      Inbound_Outbound__c = 'Outbound',
      Is_Error__c = true,
      Exception_Message__c = error.getMessage().abbreviate(131072),
      Exception_StackTrace__c = error.getStackTraceString().abbreviate(131072)
    );
  }

  // An unexpected worker/persistence failure must never release an uncertain send.
  public static void recordWorkerFailure(
    Id orderId,
    Id attemptId,
    Exception error
  ) {
    if (attemptId != null) {
      Integration_Log__c attempt = [
        SELECT Id, Response_State__c
        FROM Integration_Log__c
        WHERE Id = :attemptId
      ];
      if (attempt.Response_State__c != 'Sent') {
        attempt.Response_State__c = 'Unknown';
      }
      attempt.Is_Error__c = true;
      attempt.Exception_Message__c = error.getMessage().abbreviate(131072);
      update attempt;
    }
    recordFailure(orderId, error);
  }

  private static Order loadOrder(Id orderId) {
    if (orderId == null || orderId.getSObjectType() != Order.SObjectType) {
      throw new OrderEnvelopeException('Ordine non valido.');
    }
    return [
      SELECT
        Id,
        OrderNumber,
        AccountId,
        Origine__c,
        Contract_Pdf_Type__c,
        Mexal_Integration_Status__c,
        Mexal_Order_Number__c,
        Mexal_Document_Number__c,
        DocuSign_Envelope_Id__c,
        DocuSign_Status__c
      FROM Order
      WHERE Id = :orderId
      LIMIT 1
    ];
  }

  private static Boolean hasEnvelope(Order record) {
    return String.isNotBlank(record.DocuSign_Envelope_Id__c) ||
      new Set<String>{ 'Sent', 'Completed', 'Declined' }
        .contains(record.DocuSign_Status__c);
  }

  private static void validateEligible(Order record) {
    if (
      record.Origine__c != 'WooCommerce' ||
      record.AccountId == null ||
      !new Set<String>{ 'Item', 'Bundle', 'Plus' }
        .contains(record.Contract_Pdf_Type__c)
    ) {
      throw new OrderEnvelopeException(
        'Invio contratto disponibile solo per ordini WooCommerce con Account e tipo PDF configurato.'
      );
    }
    if (
      !new Set<String>{ 'Sent', 'Sent_Lines_Not_Aligned' }
        .contains(record.Mexal_Integration_Status__c) ||
      (String.isBlank(record.Mexal_Order_Number__c) &&
      record.Mexal_Document_Number__c == null)
    ) {
      throw new OrderEnvelopeException(
        'Attendere la registrazione dell ordine su Mexal prima di inviare il contratto.'
      );
    }
  }

  private static Contact primaryContact(Id accountId) {
    List<Contact> contacts = [
      SELECT Id, Name, Email
      FROM Contact
      WHERE AccountId = :accountId AND Contatto_Principale__c = TRUE
      LIMIT 2
    ];
    if (contacts.size() != 1) {
      throw new OrderEnvelopeException(
        'Configurare un contatto principale sull\'Account per inviare il contratto.'
      );
    }
    if (String.isBlank(contacts[0].Email)) {
      throw new OrderEnvelopeException(
        'Email mancante sul contatto principale dell Account.'
      );
    }
    return contacts[0];
  }

  private static void validatePreviousAttempt(Id orderId) {
    String flow = flowName(orderId);
    List<Integration_Log__c> attempts = [
      SELECT Response_State__c
      FROM Integration_Log__c
      WHERE
        Flow_Name__c = :flow
        AND Response_State__c IN ('Queued', 'Unknown', 'Sent')
      LIMIT 1
    ];
    if (!attempts.isEmpty()) {
      throw new OrderEnvelopeException(
        'Esiste gia un invio DocuSign in corso o da verificare. Controllare il log prima di un nuovo invio.'
      );
    }
  }

  private static String buildEnvelopeBody(
    String orderNumber,
    ContentVersion document,
    Contact recipient,
    Id attemptId
  ) {
    return JSON.serialize(
      new Map<String, Object>{
        'emailSubject' => 'Contratto ordine ' +
        orderNumber +
        ' - firma digitale',
        'transactionId' => String.valueOf(attemptId),
        'documents' => new List<Object>{
          new Map<String, Object>{
            'documentBase64' => EncodingUtil.base64Encode(document.VersionData),
            'name' => document.Title + '.pdf',
            'fileExtension' => 'pdf',
            'documentId' => '1'
          }
        },
        'recipients' => new Map<String, Object>{
          'signers' => new List<Object>{
            new Map<String, Object>{
              'email' => recipient.Email.trim(),
              'name' => recipient.Name,
              'recipientId' => '1',
              'routingOrder' => '1',
              'tabs' => new Map<String, Object>{
                'signHereTabs' => new List<Object>{
                  new Map<String, Object>{
                    'anchorString' => '/sig1/',
                    'anchorIgnoreIfNotPresent' => 'false',
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
      }
    );
  }
}
