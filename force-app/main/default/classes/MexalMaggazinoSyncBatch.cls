public with sharing class MexalMaggazinoSyncBatch implements Database.Batchable<String>, Database.AllowsCallouts {
  private static final String FLOW_NAME = 'Mexal_Movimenti_Magazzino_Sync';
  private static final Integer FALLBACK_LOOKBACK_HOURS = 24;
  private static final Integer MAX_DETAIL_CALLOUTS_PER_EXECUTE = 90;

  public Iterable<String> start(Database.BatchableContext context) {
    return new List<String>{ MexalMaggazinoSearchService.ACTION_NAME };
  }

  public void execute(Database.BatchableContext context, List<String> scope) {
    Datetime syncStartedAt = System.now();

    for (String actionName : scope) {
      runMaggazinoSync(actionName, syncStartedAt);
    }
  }

  public void finish(Database.BatchableContext context) {
  }

  private static void runMaggazinoSync(
    String actionName,
    Datetime syncStartedAt
  ) {
    try {
      Datetime modifiedSince = MexalSyncCursorService.getLastSuccessfulSync(
        actionName,
        FALLBACK_LOOKBACK_HOURS
      );

      MexalMaggazinoSearchService.Result result = MexalMaggazinoSearchService.searchModifiedSince(
        modifiedSince
      );

      if (!isCleanSearchSuccess(result)) {
        String failureMessage = buildSearchFailureMessage(result);
        MexalSyncCursorService.markFailed(actionName, failureMessage);
        MexalIntegrationLogger.logError(FLOW_NAME, failureMessage, null);
        return;
      }

      MexalScadenzarioSearchService.Result scadenzarioResult = MexalScadenzarioSearchService.searchModifiedSince(
        modifiedSince
      );
      if (!isCleanScadenzarioSuccess(scadenzarioResult)) {
        String failureMessage = buildScadenzarioFailureMessage(
          scadenzarioResult
        );
        MexalSyncCursorService.markFailed(actionName, failureMessage);
        MexalIntegrationLogger.logError(FLOW_NAME, failureMessage, null);
        return;
      }

      DetailSyncSummary detailSummary = fetchFtDetails(
        result.documents,
        scadenzarioResult.documents
      );
      if (detailSummary.success) {
        MexalSyncCursorService.markSuccessful(actionName, syncStartedAt);
        MexalIntegrationLogger.logInfo(
          FLOW_NAME,
          buildSuccessMessage(result, detailSummary)
        );
        return;
      }

      String failureMessage = buildDetailFailureMessage(result, detailSummary);
      MexalSyncCursorService.markFailed(actionName, failureMessage);
      MexalIntegrationLogger.logError(FLOW_NAME, failureMessage, null);
    } catch (Exception error) {
      markFailedWithoutBlockingLog(actionName, error.getMessage());
      MexalIntegrationLogger.logError(
        FLOW_NAME,
        'Sync movimenti magazzino Mexal fallita.',
        error
      );
    }
  }

  private static void markFailedWithoutBlockingLog(
    String actionName,
    String message
  ) {
    try {
      MexalSyncCursorService.markFailed(actionName, message);
    } catch (Exception ignored) {
    }
  }

  private static Boolean isCleanSearchSuccess(
    MexalMaggazinoSearchService.Result result
  ) {
    return result != null && result.success && result.skippedRows == 0;
  }

  private static Boolean isCleanScadenzarioSuccess(
    MexalScadenzarioSearchService.Result result
  ) {
    return result != null && result.success && result.skippedRows == 0;
  }

  private static DetailSyncSummary fetchFtDetails(
    List<MexalMaggazinoSearchService.MaggazinoDocument> documents,
    List<MexalScadenzarioSearchService.ScadenzarioDocument> scadenzarioDocuments
  ) {
    DetailSyncSummary summary = new DetailSyncSummary();
    if (documents == null || documents.isEmpty()) {
      summary.success = true;
      return summary;
    }

    for (MexalMaggazinoSearchService.MaggazinoDocument document : documents) {
      if (document == null || document.sigla != 'FT') {
        continue;
      }

      if (summary.detailsRequested >= MAX_DETAIL_CALLOUTS_PER_EXECUTE) {
        summary.failureMessage = 'Troppi documenti FT da dettagliare in una singola esecuzione batch.';
        return summary;
      }

      summary.detailsRequested++;
      MexalMaggazinoDetailService.Result detail = MexalMaggazinoDetailService.getDetail(
        document,
        scadenzarioDocuments
      );
      if (detail != null && detail.success) {
        summary.detailsSucceeded++;
        summary.rowsReturned += detail.rowsReturned == null
          ? 0
          : detail.rowsReturned;
        summary.mappedInvoiceLines += detail.mappedInvoiceLines == null
          ? 0
          : detail.mappedInvoiceLines;
        summary.unmappedInvoiceLines += detail.unmappedInvoiceLines == null
          ? 0
          : detail.unmappedInvoiceLines;
        summary.paidInvoiceLines += detail.paidInvoiceLines == null
          ? 0
          : detail.paidInvoiceLines;
        summary.unpaidInvoiceLines += detail.unpaidInvoiceLines == null
          ? 0
          : detail.unpaidInvoiceLines;
        summary.invoiceLinesWithoutPaymentMatch += detail.invoiceLinesWithoutPaymentMatch ==
          null
          ? 0
          : detail.invoiceLinesWithoutPaymentMatch;
        if (detail.mappings != null) {
          summary.mappings.addAll(detail.mappings);
        }
      } else {
        summary.detailsFailed++;
      }
    }

    summary.success = summary.detailsFailed == 0;
    if (summary.success) {
      summary.paymentStatusUpdates = MexalInvoiceOrderLineMappingService.updateOrderItemPaymentStatuses(
        summary.mappings
      );
    }
    return summary;
  }

  private static String buildSuccessMessage(
    MexalMaggazinoSearchService.Result result,
    DetailSyncSummary detailSummary
  ) {
    return 'Sync movimenti magazzino Mexal completata. Returned=' +
      result.documentsReturned +
      ', ftDocuments=' +
      result.ftDocumentsReturned +
      ', detailsRequested=' +
      detailSummary.detailsRequested +
      ', detailsSucceeded=' +
      detailSummary.detailsSucceeded +
      ', detailRowsReturned=' +
      detailSummary.rowsReturned +
      ', mappedInvoiceLines=' +
      detailSummary.mappedInvoiceLines +
      ', unmappedInvoiceLines=' +
      detailSummary.unmappedInvoiceLines +
      ', paidInvoiceLines=' +
      detailSummary.paidInvoiceLines +
      ', unpaidInvoiceLines=' +
      detailSummary.unpaidInvoiceLines +
      ', invoiceLinesWithoutPaymentMatch=' +
      detailSummary.invoiceLinesWithoutPaymentMatch +
      ', paymentStatusUpdates=' +
      detailSummary.paymentStatusUpdates +
      ', requestDateTime=' +
      result.requestDateTime +
      '.';
  }

  private static String buildSearchFailureMessage(
    MexalMaggazinoSearchService.Result result
  ) {
    if (result == null) {
      return 'Sync movimenti magazzino Mexal fallita: risultato vuoto.';
    }

    return 'Sync movimenti magazzino Mexal non completata in modo pulito. Success=' +
      String.valueOf(result.success) +
      ', statusCode=' +
      String.valueOf(result.statusCode) +
      ', returned=' +
      String.valueOf(result.documentsReturned) +
      ', ftDocuments=' +
      String.valueOf(result.ftDocumentsReturned) +
      ', skippedRows=' +
      String.valueOf(result.skippedRows) +
      '.';
  }

  private static String buildScadenzarioFailureMessage(
    MexalScadenzarioSearchService.Result result
  ) {
    if (result == null) {
      return 'Sync scadenzario Mexal fallita: risultato vuoto.';
    }

    return 'Sync scadenzario Mexal non completata in modo pulito. Success=' +
      String.valueOf(result.success) +
      ', statusCode=' +
      String.valueOf(result.statusCode) +
      ', returned=' +
      String.valueOf(result.documentsReturned) +
      ', paymentRows=' +
      String.valueOf(result.paymentRowsReturned) +
      ', skippedRows=' +
      String.valueOf(result.skippedRows) +
      '.';
  }

  private static String buildDetailFailureMessage(
    MexalMaggazinoSearchService.Result result,
    DetailSyncSummary detailSummary
  ) {
    String failureReason = String.isBlank(detailSummary.failureMessage)
      ? 'uno o piu dettagli FT non sono stati letti correttamente'
      : detailSummary.failureMessage;

    return 'Sync movimenti magazzino Mexal non completata: ' +
      failureReason +
      '. Returned=' +
      String.valueOf(result.documentsReturned) +
      ', ftDocuments=' +
      String.valueOf(result.ftDocumentsReturned) +
      ', detailsRequested=' +
      String.valueOf(detailSummary.detailsRequested) +
      ', detailsSucceeded=' +
      String.valueOf(detailSummary.detailsSucceeded) +
      ', detailsFailed=' +
      String.valueOf(detailSummary.detailsFailed) +
      ', mappedInvoiceLines=' +
      String.valueOf(detailSummary.mappedInvoiceLines) +
      ', unmappedInvoiceLines=' +
      String.valueOf(detailSummary.unmappedInvoiceLines) +
      ', paidInvoiceLines=' +
      String.valueOf(detailSummary.paidInvoiceLines) +
      ', unpaidInvoiceLines=' +
      String.valueOf(detailSummary.unpaidInvoiceLines) +
      ', invoiceLinesWithoutPaymentMatch=' +
      String.valueOf(detailSummary.invoiceLinesWithoutPaymentMatch) +
      ', paymentStatusUpdates=' +
      String.valueOf(detailSummary.paymentStatusUpdates) +
      '.';
  }

  private class DetailSyncSummary {
    Boolean success = false;
    Integer detailsRequested = 0;
    Integer detailsSucceeded = 0;
    Integer detailsFailed = 0;
    Integer rowsReturned = 0;
    Integer mappedInvoiceLines = 0;
    Integer unmappedInvoiceLines = 0;
    Integer paidInvoiceLines = 0;
    Integer unpaidInvoiceLines = 0;
    Integer invoiceLinesWithoutPaymentMatch = 0;
    Integer paymentStatusUpdates = 0;
    List<MexalInvoiceOrderLineMappingService.LineMapping> mappings = new List<MexalInvoiceOrderLineMappingService.LineMapping>();
    String failureMessage;
  }
}
