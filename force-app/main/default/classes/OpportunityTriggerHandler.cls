public without sharing class OpportunityTriggerHandler {
  private static final String LOCALE_RECORD_TYPE = 'Locale';
  private static final String QUALIFIED_STAGE = 'Qualificato';
  private static final String RECONTACT_STAGE = 'Da ricontattare';
  private static final String QUOTE_RECONTACT_STAGE = 'Da ricontattare - Prev. inviato';
  private static final String CLOSED_LOST_STAGE = 'Chiusa/Persa';
  private static final String REJECTED_QUOTE_STATUS = 'Rifiutato';

  public static void beforeInsert(List<Opportunity> opportunities) {
    defaultStage(opportunities);
    defaultCloseDate(opportunities);
  }

  public static void beforeSave(
    List<Opportunity> opportunities,
    Map<Id, Opportunity> oldOpportunityMap
  ) {
    stampRecontactDates(opportunities, oldOpportunityMap);
    normalizeCommercialAccounts(opportunities);
  }

  private static void stampRecontactDates(
    List<Opportunity> opportunities,
    Map<Id, Opportunity> oldOpportunityMap
  ) {
    for (Opportunity opportunityRecord : opportunities) {
      Opportunity oldOpportunity = oldOpportunityMap == null
        ? null
        : oldOpportunityMap.get(opportunityRecord.Id);
      Boolean stageChanged =
        oldOpportunity == null ||
        oldOpportunity.StageName != opportunityRecord.StageName;

      if (!stageChanged) {
        continue;
      }
      if (opportunityRecord.StageName == RECONTACT_STAGE) {
        opportunityRecord.Data_Da_Ricontattare__c = Date.today();
      } else if (opportunityRecord.StageName == QUOTE_RECONTACT_STAGE) {
        opportunityRecord.Data_Da_Ricontattare_Preventivo__c = Date.today();
      }
    }
  }

  public static void afterUpdate(
    List<Opportunity> opportunities,
    Map<Id, Opportunity> oldOpportunityMap
  ) {
    rejectQuotesForClosedLostOpportunities(opportunities, oldOpportunityMap);
  }

  private static void rejectQuotesForClosedLostOpportunities(
    List<Opportunity> opportunities,
    Map<Id, Opportunity> oldOpportunityMap
  ) {
    Set<Id> closedLostOpportunityIds = new Set<Id>();
    for (Opportunity opportunityRecord : opportunities) {
      Opportunity oldOpportunity = oldOpportunityMap.get(opportunityRecord.Id);
      if (
        opportunityRecord.StageName == CLOSED_LOST_STAGE &&
        oldOpportunity.StageName != CLOSED_LOST_STAGE
      ) {
        closedLostOpportunityIds.add(opportunityRecord.Id);
      }
    }

    if (closedLostOpportunityIds.isEmpty()) {
      return;
    }

    List<Quote> quotesToReject = new List<Quote>();
    for (Quote quoteRecord : [
      SELECT Id
      FROM Quote
      WHERE
        OpportunityId IN :closedLostOpportunityIds
        AND Status != :REJECTED_QUOTE_STATUS
    ]) {
      quotesToReject.add(
        new Quote(Id = quoteRecord.Id, Status = REJECTED_QUOTE_STATUS)
      );
    }

    if (!quotesToReject.isEmpty()) {
      update quotesToReject;
    }
  }

  private static void defaultStage(List<Opportunity> opportunities) {
    for (Opportunity opportunityRecord : opportunities) {
      if (String.isBlank(opportunityRecord.StageName)) {
        opportunityRecord.StageName = QUALIFIED_STAGE;
      }
    }
  }

  private static void defaultCloseDate(List<Opportunity> opportunities) {
    Date nextYearEnd = Date.newInstance(Date.today().year() + 1, 12, 31);
    for (Opportunity opportunityRecord : opportunities) {
      if (opportunityRecord.CloseDate == null) {
        opportunityRecord.CloseDate = nextYearEnd;
      }
    }
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
