public with sharing class MexalCustomerSyncBatch implements Database.Batchable<String>, Database.AllowsCallouts {
  private static final String FLOW_NAME = 'Mexal_Clienti_Sync';
  private static final Integer FALLBACK_LOOKBACK_HOURS = 24;

  public Iterable<String> start(Database.BatchableContext context) {
    return new List<String>{ MexalCustomerSearchService.ACTION_NAME };
  }

  public void execute(Database.BatchableContext context, List<String> scope) {
    Datetime syncStartedAt = System.now();

    for (String actionName : scope) {
      runCustomerSync(actionName, syncStartedAt);
    }
  }

  public void finish(Database.BatchableContext context) {
  }

  private static void runCustomerSync(
    String actionName,
    Datetime syncStartedAt
  ) {
    try {
      Datetime modifiedSince = MexalSyncCursorService.getLastSuccessfulSync(
        actionName,
        FALLBACK_LOOKBACK_HOURS
      );

      MexalCustomerSearchService.Result result = MexalCustomerSearchService.searchModifiedSince(
        modifiedSince
      );

      if (isCleanSuccess(result)) {
        MexalSyncCursorService.markSuccessful(actionName, syncStartedAt);
        MexalIntegrationLogger.logInfo(FLOW_NAME, buildSuccessMessage(result));
        return;
      }

      String failureMessage = buildFailureMessage(result);
      MexalSyncCursorService.markFailed(actionName, failureMessage);
      MexalIntegrationLogger.logError(FLOW_NAME, failureMessage, null);
    } catch (Exception error) {
      markFailedWithoutBlockingLog(actionName, error.getMessage());
      MexalIntegrationLogger.logError(
        FLOW_NAME,
        'Sync clienti Mexal fallita.',
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

  private static Boolean isCleanSuccess(
    MexalCustomerSearchService.Result result
  ) {
    return result != null &&
      result.success &&
      result.failedSaves == 0 &&
      result.ambiguousMatches == 0;
  }

  private static String buildSuccessMessage(
    MexalCustomerSearchService.Result result
  ) {
    return 'Sync clienti Mexal completata. Returned=' +
      result.customersReturned +
      ', updated=' +
      result.updatedAccounts +
      ', unmatched=' +
      result.unmatchedAccounts +
      ', requestDateTime=' +
      result.requestDateTime +
      '.';
  }

  private static String buildFailureMessage(
    MexalCustomerSearchService.Result result
  ) {
    if (result == null) {
      return 'Sync clienti Mexal fallita: risultato vuoto.';
    }

    return 'Sync clienti Mexal non completata in modo pulito. Success=' +
      String.valueOf(result.success) +
      ', statusCode=' +
      String.valueOf(result.statusCode) +
      ', returned=' +
      String.valueOf(result.customersReturned) +
      ', ambiguous=' +
      String.valueOf(result.ambiguousMatches) +
      ', failedSaves=' +
      String.valueOf(result.failedSaves) +
      ', errors=' +
      String.join(result.saveErrors, ' | ') +
      '.';
  }
}
