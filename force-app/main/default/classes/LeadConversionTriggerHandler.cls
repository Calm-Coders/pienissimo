public without sharing class LeadConversionTriggerHandler {
  private static final String NON_RISPONDE_STATUS = 'Non Risponde';
  private static final String DUPLICATE_LEAD_ERROR = 'Esiste gia un Lead aperto con la stessa Partita IVA oppure con la stessa email e lo stesso telefono.';
  private static final String FOLLOW_UP_TASK_SUBJECT = 'Ricontattare Lead - Non Risponde';
  private static final String FOLLOW_UP_TASK_DESCRIPTION = 'Il Lead e stato spostato in Non Risponde. Ricontattare il prospect.';
  private static final String TASK_STATUS_OPEN = 'Open';
  private static final String TASK_PRIORITY_NORMAL = 'Normal';
  private static final String QUALIFIED_STATUS = 'Qualificato';
  private static Boolean conversionJobEnqueued = false;
  private static Boolean automationBypassed = false;

  public static void beforeSave(List<Lead> newLeads, Map<Id, Lead> oldLeadMap) {
    if (automationBypassed) {
      return;
    }
    preventDuplicateOpenLeads(newLeads);
  }

  public static void afterUpdate(
    List<Lead> newLeads,
    Map<Id, Lead> oldLeadMap
  ) {
    if (automationBypassed) {
      return;
    }
    copyConvertedFields(newLeads, oldLeadMap);

    List<Task> followUpTasks = buildNonRispondeFollowUpTasks(
      newLeads,
      oldLeadMap
    );
    if (!followUpTasks.isEmpty()) {
      insert followUpTasks;
    }

    enqueueLeadConversions(newLeads, oldLeadMap);
  }

  public static void setAutomationBypassed(Boolean bypassed) {
    automationBypassed = bypassed == true;
  }

  private static void copyConvertedFields(
    List<Lead> newLeads,
    Map<Id, Lead> oldLeadMap
  ) {
    Map<Id, Opportunity> opportunitiesToUpdate = new Map<Id, Opportunity>();
    Map<Id, Account> accountsToUpdate = new Map<Id, Account>();
    Map<Id, String> leadEmailByAccountId = new Map<Id, String>();

    for (Lead leadRecord : newLeads) {
      Lead oldLead = oldLeadMap.get(leadRecord.Id);
      if (oldLead.IsConverted == true || leadRecord.IsConverted != true) {
        continue;
      }

      if (leadRecord.ConvertedOpportunityId != null) {
        opportunitiesToUpdate.put(
          leadRecord.ConvertedOpportunityId,
          new Opportunity(
            Id = leadRecord.ConvertedOpportunityId,
            Categoria__c = leadRecord.Categoria__c,
            Sottocategoria__c = leadRecord.Sottocategoria__c,
            UTM_Campaign__c = leadRecord.UTM_Campaign__c,
            UTM_Content__c = leadRecord.UTM_Content__c,
            UTM_Medium__c = leadRecord.UTM_Medium__c,
            UTM_Source__c = leadRecord.UTM_Source__c,
            UTM_Term__c = leadRecord.UTM_Term__c
          )
        );
      }

      if (leadRecord.ConvertedAccountId != null) {
        String normalizedEmail = normalizeEmail(leadRecord.Email);
        if (normalizedEmail != null) {
          leadEmailByAccountId.put(
            leadRecord.ConvertedAccountId,
            normalizedEmail
          );
        }

        accountsToUpdate.put(
          leadRecord.ConvertedAccountId,
          new Account(
            Id = leadRecord.ConvertedAccountId,
            Consenso_Profilazione__c = leadRecord.Consenso_Profilazione__c,
            Informativa_Privacy__c = leadRecord.Informativa_Privacy__c,
            Tipologia_Attivita_Globale__c = leadRecord.Tipologia_Attivita_Globale__c
          )
        );
      }
    }

    if (!opportunitiesToUpdate.isEmpty()) {
      update opportunitiesToUpdate.values();
    }
    if (!accountsToUpdate.isEmpty()) {
      Set<Id> convertedAccountIds = accountsToUpdate.keySet();
      for (Account accountRecord : [
        SELECT Id, Email__c, Lead_Email__c
        FROM Account
        WHERE Id IN :convertedAccountIds
      ]) {
        if (!leadEmailByAccountId.containsKey(accountRecord.Id)) {
          continue;
        }

        String leadEmail = leadEmailByAccountId.get(accountRecord.Id);
        Account accountUpdate = accountsToUpdate.get(accountRecord.Id);
        if (String.isBlank(accountRecord.Email__c)) {
          accountUpdate.Email__c = leadEmail;
        }
        if (String.isBlank(accountRecord.Lead_Email__c)) {
          accountUpdate.Lead_Email__c = leadEmail;
        }
      }

      update accountsToUpdate.values();
    }
  }

  private static void preventDuplicateOpenLeads(List<Lead> newLeads) {
    Set<String> vatKeys = new Set<String>();
    Set<String> personKeys = new Set<String>();
    Set<String> duplicateVatKeys = new Set<String>();
    Set<String> duplicatePersonKeys = new Set<String>();
    Set<String> emails = new Set<String>();
    Set<Id> currentLeadIds = new Set<Id>();

    for (Lead leadRecord : newLeads) {
      if (leadRecord.Id != null) {
        currentLeadIds.add(leadRecord.Id);
      }

      String email = normalizeEmail(leadRecord.Email);
      String phone = normalizePhone(leadRecord.Phone);
      String vatNumber = normalizeVat(leadRecord.Partita_IVA__c);
      String personKey = buildPersonKey(email, phone);

      if (vatNumber != null) {
        if (vatKeys.contains(vatNumber)) {
          duplicateVatKeys.add(vatNumber);
        }
        vatKeys.add(vatNumber);
      }

      if (personKey != null) {
        if (personKeys.contains(personKey)) {
          duplicatePersonKeys.add(personKey);
        }
        personKeys.add(personKey);
        emails.add(email);
      }
    }

    if (vatKeys.isEmpty() && personKeys.isEmpty()) {
      return;
    }

    Map<String, Object> queryBinds = new Map<String, Object>();
    List<String> matchConditions = new List<String>();
    if (!vatKeys.isEmpty()) {
      queryBinds.put('vatValues', vatKeys);
      matchConditions.add('Partita_IVA__c IN :vatValues');
    }
    if (!emails.isEmpty()) {
      queryBinds.put('emailValues', emails);
      matchConditions.add('Email IN :emailValues');
    }

    List<Lead> existingOpenLeads = Database.queryWithBinds(
      'SELECT Id, Email, Phone, Partita_IVA__c ' +
        'FROM Lead ' +
        'WHERE IsConverted = false AND (' +
        String.join(matchConditions, ' OR ') +
        ')',
      queryBinds,
      AccessLevel.SYSTEM_MODE
    );

    for (Lead existingLead : existingOpenLeads) {
      if (currentLeadIds.contains(existingLead.Id)) {
        continue;
      }

      String existingEmail = normalizeEmail(existingLead.Email);
      String existingPhone = normalizePhone(existingLead.Phone);
      String existingVatNumber = normalizeVat(existingLead.Partita_IVA__c);
      String existingPersonKey = buildPersonKey(existingEmail, existingPhone);

      if (existingVatNumber != null && vatKeys.contains(existingVatNumber)) {
        duplicateVatKeys.add(existingVatNumber);
      }
      if (existingPersonKey != null && personKeys.contains(existingPersonKey)) {
        duplicatePersonKeys.add(existingPersonKey);
      }
    }

    if (duplicateVatKeys.isEmpty() && duplicatePersonKeys.isEmpty()) {
      return;
    }

    for (Lead leadRecord : newLeads) {
      String vatNumber = normalizeVat(leadRecord.Partita_IVA__c);
      String personKey = buildPersonKey(
        normalizeEmail(leadRecord.Email),
        normalizePhone(leadRecord.Phone)
      );
      if (
        duplicateVatKeys.contains(vatNumber) ||
        duplicatePersonKeys.contains(personKey)
      ) {
        leadRecord.addError(DUPLICATE_LEAD_ERROR);
      }
    }
  }

  private static List<Task> buildNonRispondeFollowUpTasks(
    List<Lead> newLeads,
    Map<Id, Lead> oldLeadMap
  ) {
    List<Task> followUpTasks = new List<Task>();
    for (Lead leadRecord : newLeads) {
      Lead oldLead = oldLeadMap.get(leadRecord.Id);
      if (
        leadRecord.IsConverted != true &&
        leadRecord.Status == NON_RISPONDE_STATUS &&
        oldLead.Status != NON_RISPONDE_STATUS
      ) {
        followUpTasks.add(
          new Task(
            ActivityDate = Date.today().addDays(2),
            Description = FOLLOW_UP_TASK_DESCRIPTION,
            IsReminderSet = true,
            OwnerId = leadRecord.OwnerId,
            Priority = TASK_PRIORITY_NORMAL,
            ReminderDateTime = System.now().addHours(48),
            Status = TASK_STATUS_OPEN,
            Subject = FOLLOW_UP_TASK_SUBJECT,
            WhoId = leadRecord.Id
          )
        );
      }
    }

    return followUpTasks;
  }

  private static void enqueueLeadConversions(
    List<Lead> newLeads,
    Map<Id, Lead> oldLeadMap
  ) {
    if (conversionJobEnqueued) {
      return;
    }

    List<Id> qualifiedLeadIds = new List<Id>();
    Map<Id, String> previousStatusByLeadId = new Map<Id, String>();
    for (Lead leadRecord : newLeads) {
      Lead oldLead = oldLeadMap.get(leadRecord.Id);
      if (
        leadRecord.IsConverted != true &&
        leadRecord.Status == QUALIFIED_STATUS &&
        oldLead.Status != QUALIFIED_STATUS
      ) {
        qualifiedLeadIds.add(leadRecord.Id);
        previousStatusByLeadId.put(leadRecord.Id, oldLead.Status);
      }
    }

    if (!qualifiedLeadIds.isEmpty()) {
      conversionJobEnqueued = true;
      System.enqueueJob(
        new LeadConversionQueueable(qualifiedLeadIds, previousStatusByLeadId)
      );
    }
  }

  private static String buildPersonKey(String email, String phone) {
    return email == null || phone == null ? null : email + '|' + phone;
  }

  private static String normalizeEmail(String email) {
    return String.isBlank(email) ? null : email.trim().toLowerCase();
  }

  private static String normalizePhone(String phone) {
    if (String.isBlank(phone)) {
      return null;
    }

    String normalizedPhone = phone.replaceAll('[^0-9]', '');
    return String.isBlank(normalizedPhone) ? null : normalizedPhone;
  }

  private static String normalizeVat(String vatNumber) {
    return String.isBlank(vatNumber) ? null : vatNumber.trim().toUpperCase();
  }
}
