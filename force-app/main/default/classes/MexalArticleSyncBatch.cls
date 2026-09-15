public with sharing class MexalArticleSyncBatch implements Database.Batchable<String>, Database.AllowsCallouts {
  private static final String FLOW_NAME = 'Mexal_Articoli_Sync';
  private static final Integer FALLBACK_LOOKBACK_HOURS = 24;

  public Iterable<String> start(Database.BatchableContext context) {
    return new List<String>{ MexalArticleSyncService.ACTION_NAME };
  }

  public void execute(Database.BatchableContext context, List<String> scope) {
    Datetime syncStartedAt = System.now();

    for (String actionName : scope) {
      runArticleSync(actionName, syncStartedAt);
    }
  }

  public void finish(Database.BatchableContext context) {
  }

  private static void runArticleSync(
    String actionName,
    Datetime syncStartedAt
  ) {
    try {
      Datetime modifiedSince = MexalSyncCursorService.getLastSuccessfulSync(
        actionName,
        FALLBACK_LOOKBACK_HOURS
      );

      MexalArticleSyncService.Result result = MexalArticleSyncService.syncModifiedSince(
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
        'Sync articoli Mexal fallita.',
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

  private static Boolean isCleanSuccess(MexalArticleSyncService.Result result) {
    return result != null &&
      result.success &&
      result.failedSaves == 0 &&
      result.skippedRows == 0 &&
      result.skippedBundleMatches == 0;
  }

  private static String buildSuccessMessage(
    MexalArticleSyncService.Result result
  ) {
    return 'Sync articoli Mexal completata. Returned=' +
      result.articlesReturned +
      ', upserted=' +
      result.upsertedProducts +
      ', requestValue=' +
      result.requestValue +
      '.';
  }

  private static String buildFailureMessage(
    MexalArticleSyncService.Result result
  ) {
    if (result == null) {
      return 'Sync articoli Mexal fallita: risultato vuoto.';
    }

    return 'Sync articoli Mexal non completata in modo pulito. Success=' +
      String.valueOf(result.success) +
      ', statusCode=' +
      String.valueOf(result.statusCode) +
      ', returned=' +
      String.valueOf(result.articlesReturned) +
      ', mapped=' +
      String.valueOf(result.mappedProducts) +
      ', upserted=' +
      String.valueOf(result.upsertedProducts) +
      ', skippedRows=' +
      String.valueOf(result.skippedRows) +
      ', skippedBundleMatches=' +
      String.valueOf(result.skippedBundleMatches) +
      ', failedSaves=' +
      String.valueOf(result.failedSaves) +
      ', errors=' +
      String.join(result.saveErrors, ' | ') +
      '.';
  }
}
