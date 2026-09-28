public with sharing class MexalSyncCursorService {
  private static final Integer DEFAULT_LOOKBACK_HOURS = 24;

  public class CursorException extends Exception {
  }

  public static Datetime getLastSuccessfulSync(String actionName) {
    return getLastSuccessfulSync(actionName, DEFAULT_LOOKBACK_HOURS);
  }

  public static Datetime getLastSuccessfulSync(
    String actionName,
    Integer fallbackLookbackHours
  ) {
    Integration_Configuration2__c config = getConfigurationForUpdate(
      actionName
    );

    if (config.Last_Successful_Sync__c != null) {
      return config.Last_Successful_Sync__c;
    }

    Integer lookbackHours = config.Initial_Sync_Lookback_Hours__c == null
      ? fallbackLookbackHours
      : config.Initial_Sync_Lookback_Hours__c.intValue();

    if (lookbackHours == null || lookbackHours <= 0) {
      lookbackHours = DEFAULT_LOOKBACK_HOURS;
    }

    return System.now().addHours(-lookbackHours);
  }

  public static void markSuccessful(String actionName, Datetime nextCursor) {
    if (nextCursor == null) {
      throw new CursorException('Cursor sync timestamp obbligatorio.');
    }

    Integration_Configuration2__c config = getConfigurationForUpdate(
      actionName
    );
    config.Last_Successful_Sync__c = nextCursor;
    config.Last_Sync_Status__c = 'Success';
    config.Last_Sync_Error__c = null;
    update config;
  }

  public static void markFailed(String actionName, String message) {
    Integration_Configuration2__c config = getConfigurationForUpdate(
      actionName
    );
    config.Last_Sync_Status__c = 'Failed';
    config.Last_Sync_Error__c = abbreviate(message);
    update config;
  }

  private static Integration_Configuration2__c getConfigurationForUpdate(
    String actionName
  ) {
    if (String.isBlank(actionName)) {
      throw new CursorException('Azione integrazione obbligatoria.');
    }

    List<Integration_Configuration2__c> configs = [
      SELECT
        Id,
        Initial_Sync_Lookback_Hours__c,
        Last_Successful_Sync__c,
        Last_Sync_Error__c,
        Last_Sync_Status__c
      FROM Integration_Configuration2__c
      WHERE Azione__c = :actionName
      LIMIT 1
      FOR UPDATE
    ];

    if (configs.isEmpty()) {
      throw new CursorException(
        'Configurazione integrazione non trovata per azione: ' + actionName
      );
    }

    return configs[0];
  }

  private static String abbreviate(String value) {
    return value == null ? null : value.abbreviate(255);
  }
}
