public with sharing class OrderMexalRetryController {
  @AuraEnabled
  public static String retryMexalIntegration(Id orderId) {
    try {
      OrderMexalIntegrationService.retryFailedOrder(orderId);
      return 'Reinvio a Mexal avviato.';
    } catch (Exception error) {
      AuraHandledException auraError = new AuraHandledException(
        error.getMessage()
      );
      auraError.setMessage(error.getMessage());
      throw auraError;
    }
  }
}
