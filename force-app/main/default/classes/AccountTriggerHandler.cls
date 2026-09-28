public with sharing class AccountTriggerHandler {
  private static final String AZIENDA_RECORD_TYPE = 'Azienda';
  private static final String LOCALE_RECORD_TYPE = 'Locale';
  private static Boolean bypassMexalCustomerUpdate = false;

  public static void afterUpdate(
    List<Account> newAccounts,
    Map<Id, Account> oldAccountMap
  ) {
    if (bypassMexalCustomerUpdate) {
      return;
    }

    Set<Id> accountIdsToSync = new Set<Id>();

    for (Account accountRecord : newAccounts) {
      Account oldAccount = oldAccountMap == null
        ? null
        : oldAccountMap.get(accountRecord.Id);

      if (
        accountRecord.Id != null &&
        !String.isBlank(accountRecord.Codice_Cliente_Mexal__c) &&
        hasMexalUpdateTriggerFieldChanged(accountRecord, oldAccount)
      ) {
        accountIdsToSync.add(accountRecord.Id);
      }
    }

    if (!accountIdsToSync.isEmpty()) {
      System.enqueueJob(new MexalCustomerUpdateQueueable(accountIdsToSync));
    }
  }

  public static void setBypassMexalCustomerUpdate(Boolean bypass) {
    bypassMexalCustomerUpdate = bypass == true;
  }

  public static void beforeDelete(List<Account> oldAccounts) {
    Id aziendaRecordTypeId = accountRecordTypeId(AZIENDA_RECORD_TYPE);
    if (aziendaRecordTypeId == null) {
      return;
    }

    Set<Id> aziendaIds = new Set<Id>();
    for (Account accountRecord : oldAccounts) {
      if (accountRecord.RecordTypeId == aziendaRecordTypeId) {
        aziendaIds.add(accountRecord.Id);
      }
    }

    if (aziendaIds.isEmpty()) {
      return;
    }

    Set<Id> aziendeWithLocales = new Set<Id>();
    for (AggregateResult result : [
      SELECT ParentId parentId
      FROM Account
      WHERE
        ParentId IN :aziendaIds
        AND RecordType.DeveloperName = :LOCALE_RECORD_TYPE
      GROUP BY ParentId
    ]) {
      aziendeWithLocales.add((Id) result.get('parentId'));
    }

    for (Account accountRecord : oldAccounts) {
      if (aziendeWithLocales.contains(accountRecord.Id)) {
        accountRecord.addError(
          'Non puoi eliminare una Azienda con Locale collegati.'
        );
      }
    }
  }

  private static Id accountRecordTypeId(String developerName) {
    List<RecordType> recordTypes = [
      SELECT Id
      FROM RecordType
      WHERE SObjectType = 'Account' AND DeveloperName = :developerName
      LIMIT 1
    ];

    return recordTypes.isEmpty() ? null : recordTypes[0].Id;
  }

  private static Boolean hasMexalUpdateTriggerFieldChanged(
    Account accountRecord,
    Account oldAccount
  ) {
    if (oldAccount == null) {
      return false;
    }

    return accountRecord.Email__c != oldAccount.Email__c ||
      accountRecord.Phone != oldAccount.Phone ||
      accountRecord.Partita_IVA__c != oldAccount.Partita_IVA__c ||
      accountRecord.Name != oldAccount.Name;
  }
}
