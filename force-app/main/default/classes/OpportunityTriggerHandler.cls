public with sharing class OpportunityTriggerHandler {
  private static final String LOCALE_RECORD_TYPE = 'Locale';

  public static void beforeSave(List<Opportunity> opportunities) {
    normalizeCommercialAccounts(opportunities);
  }

  private static void normalizeCommercialAccounts(
    List<Opportunity> opportunities
  ) {
    Set<Id> accountIds = new Set<Id>();
    for (Opportunity opportunityRecord : opportunities) {
      if (opportunityRecord.AccountId != null) {
        accountIds.add(opportunityRecord.AccountId);
      }
    }

    if (accountIds.isEmpty()) {
      return;
    }

    Map<Id, Account> accountsById = new Map<Id, Account>(
      [
        SELECT Id, RecordType.DeveloperName
        FROM Account
        WHERE Id IN :accountIds
      ]
    );

    Set<Id> localeAccountIds = new Set<Id>();
    for (Account accountRecord : accountsById.values()) {
      if (accountRecord.RecordType.DeveloperName == LOCALE_RECORD_TYPE) {
        localeAccountIds.add(accountRecord.Id);
      }
    }

    if (localeAccountIds.isEmpty()) {
      return;
    }

    Map<Id, Id> commercialAccountIdsByLocaleId = CommercialAccountResolver.resolveAll(
      localeAccountIds
    );

    for (Opportunity opportunityRecord : opportunities) {
      if (!localeAccountIds.contains(opportunityRecord.AccountId)) {
        continue;
      }

      Id localeAccountId = opportunityRecord.AccountId;
      Id commercialAccountId = commercialAccountIdsByLocaleId.get(
        localeAccountId
      );
      if (commercialAccountId == null) {
        continue;
      }

      opportunityRecord.Locale__c = localeAccountId;
      opportunityRecord.AccountId = commercialAccountId;
    }
  }
}
