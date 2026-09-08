public with sharing class AccountTriggerHandler {
  private static final String AZIENDA_RECORD_TYPE = 'Azienda';
  private static final String LOCALE_RECORD_TYPE = 'Locale';

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
}
