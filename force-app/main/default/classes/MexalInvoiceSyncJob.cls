// Nightly Mexal invoice sync, in order:
// 1. invoices (FT) modified since the last run -> Fattura__c;
// 2. their lines (MexalInvoiceLineImportBatch) -> Riga_Fattura__c, linking
//    invoice -> order and order line -> invoice;
// 3. the scadenzario (FE) modified since the last run -> Scadenza_Fattura__c,
//    whose rates set Paid / Unpaid on the order lines; the tranches follow
//    their lines (OrderItemTriggerHandler).
// Each Mexal search runs in its own transaction, since a callout cannot
// follow DML. Each step keeps its own cursor on Integration_Configuration2__c.
public without sharing class MexalInvoiceSyncJob implements Queueable, Database.AllowsCallouts {
  public static final String STEP_INVOICES = 'Fatture';
  public static final String STEP_SCADENZARIO = 'Scadenzario';
  private static final String FLOW_NAME = 'Mexal_Fatture_Scadenzario_Sync';
  private static final Integer FALLBACK_LOOKBACK_HOURS = 24;
  // Invoices whose lines failed to import are retried on the next run.
  private static final Integer MAX_INVOICES_WITHOUT_LINES = 2000;

  private final String stepName;

  public MexalInvoiceSyncJob() {
    this(STEP_INVOICES);
  }

  public MexalInvoiceSyncJob(String stepName) {
    this.stepName = stepName == STEP_SCADENZARIO
      ? STEP_SCADENZARIO
      : STEP_INVOICES;
  }

  public void execute(QueueableContext context) {
    if (stepName == STEP_SCADENZARIO) {
      syncScadenzario();
      return;
    }

    Set<Id> invoiceIds = syncInvoices();
    for (Fattura__c invoice : [
      SELECT Id
      FROM Fattura__c
      WHERE Id NOT IN (SELECT Fattura__c FROM Riga_Fattura__c)
      LIMIT :MAX_INVOICES_WITHOUT_LINES
    ]) {
      invoiceIds.add(invoice.Id);
    }
    // The lines batch starts the scadenzario step when it finishes.
    Database.executeBatch(
      new MexalInvoiceLineImportBatch(invoiceIds, true),
      MexalInvoiceLineImportBatch.SCOPE_SIZE
    );
  }

  private static Set<Id> syncInvoices() {
    String actionName = MexalInvoiceImportService.MOVEMENT_SEARCH_ACTION;
    Datetime syncStartedAt = System.now();
    try {
      MexalInvoiceImportService.Result result = MexalInvoiceImportService.importInvoicesModifiedSince(
        MexalSyncCursorService.getLastSuccessfulSync(
          actionName,
          FALLBACK_LOOKBACK_HOURS
        )
      );
      closeStep(
        actionName,
        syncStartedAt,
        result,
        'Sync fatture Mexal: returned=' +
          result.invoicesReturned +
          ', saved=' +
          result.invoicesSaved +
          ', withoutAccount=' +
          result.invoicesWithoutAccount
      );
      return result.invoiceIds;
    } catch (Exception error) {
      failStep(actionName, 'Sync fatture Mexal fallita.', error);
      return new Set<Id>();
    }
  }

  private static void syncScadenzario() {
    String actionName = MexalInvoiceImportService.SCADENZARIO_SEARCH_ACTION;
    Datetime syncStartedAt = System.now();
    try {
      MexalInvoiceImportService.Result result = MexalInvoiceImportService.importScadenzarioModifiedSince(
        MexalSyncCursorService.getLastSuccessfulSync(
          actionName,
          FALLBACK_LOOKBACK_HOURS
        )
      );
      closeStep(
        actionName,
        syncStartedAt,
        result,
        'Sync scadenzario Mexal: returned=' +
          result.scadenzarioDocumentsReturned +
          ', deadlinesSaved=' +
          result.deadlinesSaved +
          ', withoutInvoice=' +
          result.deadlinesWithoutInvoice +
          ', orderLinesUpdated=' +
          result.orderLinesUpdated
      );
    } catch (Exception error) {
      failStep(actionName, 'Sync scadenzario Mexal fallita.', error);
    }
  }

  // A run with save errors keeps the cursor, so the next run fetches the same
  // window again; the upserts on Chiave_Mexal__c make that safe.
  private static void closeStep(
    String actionName,
    Datetime syncStartedAt,
    MexalInvoiceImportService.Result result,
    String summary
  ) {
    if (result.errors.isEmpty()) {
      MexalSyncCursorService.markSuccessful(actionName, syncStartedAt);
      MexalIntegrationLogger.logInfo(FLOW_NAME, summary);
      return;
    }
    String message = summary + '\n' + String.join(result.errors, '\n');
    MexalSyncCursorService.markFailed(actionName, message);
    MexalIntegrationLogger.logError(FLOW_NAME, message, null);
  }

  private static void failStep(
    String actionName,
    String message,
    Exception error
  ) {
    try {
      MexalSyncCursorService.markFailed(
        actionName,
        message + ' ' + error.getMessage()
      );
    } catch (Exception cursorError) {
      // No configuration row for the action: the log below still records it.
      System.debug(LoggingLevel.WARN, cursorError.getMessage());
    }
    MexalIntegrationLogger.logError(FLOW_NAME, message, error);
  }
}
