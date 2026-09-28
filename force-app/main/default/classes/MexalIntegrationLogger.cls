public with sharing class MexalIntegrationLogger {
  public static void logInfo(String flowName, String message) {
    insert buildLog(flowName, false, message, null);
  }

  public static void logError(
    String flowName,
    String message,
    Exception error
  ) {
    insert buildLog(flowName, true, message, error);
  }

  private static Integration_Log__c buildLog(
    String flowName,
    Boolean isError,
    String message,
    Exception error
  ) {
    Integration_Log__c logRow = new Integration_Log__c(
      Flow_Name__c = flowName,
      Inbound_Outbound__c = 'Outbound',
      Is_Error__c = isError,
      Response_Body__c = abbreviate(message)
    );

    if (error != null) {
      logRow.Exception_Message__c = abbreviate(
        error.getTypeName() + '\n' + error.getMessage()
      );
      logRow.Exception_StackTrace__c = abbreviate(error.getStackTraceString());
    }

    return logRow;
  }

  private static String abbreviate(String value) {
    return value == null ? null : value.abbreviate(131072);
  }
}
