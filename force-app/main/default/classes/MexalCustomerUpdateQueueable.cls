public with sharing class MexalCustomerUpdateQueueable implements Queueable, Database.AllowsCallouts {
  private static final String FLOW_NAME = 'Mexal_Clienti_Modifica';

  private final List<Id> accountIds;

  public MexalCustomerUpdateQueueable(Set<Id> accountIds) {
    this.accountIds = accountIds == null
      ? new List<Id>()
      : new List<Id>(accountIds);
  }

  public void execute(QueueableContext context) {
    for (Id accountId : accountIds) {
      try {
        MexalCustomerCreateService.Result result = MexalCustomerCreateService.updateForAccount(
          accountId
        );
        if (result == null || result.success != true) {
          MexalIntegrationLogger.logError(
            FLOW_NAME,
            'Modifica cliente Mexal fallita per Account ' +
              String.valueOf(accountId) +
              ': ' +
              (result == null ? 'nessun risultato' : result.message),
            null
          );
        }
      } catch (Exception error) {
        MexalIntegrationLogger.logError(
          FLOW_NAME,
          'Modifica cliente Mexal fallita per Account ' +
          String.valueOf(accountId),
          error
        );
      }
    }
  }
}
