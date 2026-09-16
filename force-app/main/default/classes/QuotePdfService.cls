public without sharing class QuotePdfService {
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
      if (currentQuote.Status != 'Bozza') {
        throw new QuotePdfController.QuotePdfException(
          'Lo stato del preventivo e cambiato. Il PDF non e stato salvato.'
        );
      }
      String title =
        'Preventivo-' +
        quoteRecord.QuoteNumber +
        '-' +
        Datetime.now().format('yyyyMMdd-HHmmss');
      ContentVersion file = new ContentVersion(
        Title = title,
        PathOnClient = title + '.pdf',
        VersionData = body,
        FirstPublishLocationId = quoteId
      );
      insert as user file;
      return [
        SELECT ContentDocumentId
        FROM ContentVersion
        WHERE Id = :file.Id
        WITH USER_MODE
      ]
      .ContentDocumentId;
    } catch (QuotePdfController.QuotePdfException e) {
      throw new AuraHandledException(e.getMessage());
    } catch (Exception e) {
      throw new AuraHandledException(
        'Generazione PDF non riuscita. Verifica i dati del preventivo e i permessi di lettura, accesso alla pagina PDF e creazione File. Dettaglio: ' +
        e.getMessage()
      );
    }
  }
}
