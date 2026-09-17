public without sharing class QuotePdfService {
  private static final String DRAFT_STATUS = 'Bozza';
  private static final String NEGOTIATION_STATUS = 'In Trattativa';
  private static final String SIGNATURE_TITLE_TOKEN = 'da firmare';

  @AuraEnabled
  public static Id generatePdf(Id quoteId) {
    try {
      Quote quoteRecord = QuotePdfController.requireDraft(quoteId);
      PageReference document = Page.QuotePdf;
      document.getParameters().put('id', String.valueOf(quoteId));
      // Rendering is a callout: all DML and record locking must follow it.
      Blob body = document.getContentAsPDF();
      if (body == null || body.size() == 0) {
        throw new QuotePdfController.QuotePdfException(
          'Il documento PDF generato e vuoto.'
        );
      }
      Quote currentQuote = [
        SELECT Id, Status
        FROM Quote
        WHERE Id = :quoteId
        WITH USER_MODE
        FOR UPDATE
      ];
      if (currentQuote.Status != DRAFT_STATUS) {
        throw new QuotePdfController.QuotePdfException(
          'Lo stato del preventivo e cambiato. Il PDF non e stato salvato.'
        );
      }
      deleteExistingSigningFiles(quoteId);
      String title =
        'Preventivo-' +
        quoteRecord.QuoteNumber +
        '-da firmare-' +
        Datetime.now().format('yyyyMMdd-HHmmss');
      ContentVersion file = new ContentVersion(
        Title = title,
        PathOnClient = title + '.pdf',
        VersionData = body,
        FirstPublishLocationId = quoteId
      );
      insert as user file;
      Id documentId = [
        SELECT ContentDocumentId
        FROM ContentVersion
        WHERE Id = :file.Id
        WITH USER_MODE
      ]
      .ContentDocumentId;
      update as user new Quote(Id = quoteId, Status = NEGOTIATION_STATUS);
      return documentId;
    } catch (QuotePdfController.QuotePdfException e) {
      throw new AuraHandledException(e.getMessage());
    } catch (Exception e) {
      throw new AuraHandledException(
        'Generazione PDF non riuscita. Verifica i dati del preventivo e i permessi di lettura, accesso alla pagina PDF e creazione File. Dettaglio: ' +
        e.getMessage()
      );
    }
  }

  private static void deleteExistingSigningFiles(Id quoteId) {
    List<ContentDocument> documentsToDelete = new List<ContentDocument>();
    for (ContentDocumentLink link : [
      SELECT ContentDocumentId, ContentDocument.Title
      FROM ContentDocumentLink
      WHERE LinkedEntityId = :quoteId
      WITH USER_MODE
    ]) {
      String title = link.ContentDocument.Title;
      if (
        title != null && title.toLowerCase().contains(SIGNATURE_TITLE_TOKEN)
      ) {
        documentsToDelete.add(new ContentDocument(Id = link.ContentDocumentId));
      }
    }
    if (!documentsToDelete.isEmpty()) {
      delete as user documentsToDelete;
    }
  }
}
