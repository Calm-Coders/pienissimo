public with sharing class LeadConversionTriggerHandler {
  private static final String NON_RISPONDE_STATUS = 'Non Risponde';
  private static final String DUPLICATE_LEAD_ERROR = 'Esiste gia un Lead aperto con la stessa email e lo stesso telefono.';
  private static final String CONTACT_ACCOUNT_CONFLICT_ERROR = 'La Partita IVA del Lead appartiene a una Azienda diversa dal Contact trovato con la stessa email e lo stesso telefono.';
  private static final String FOLLOW_UP_TASK_SUBJECT = 'Ricontattare Lead - Non Risponde';
  private static final String FOLLOW_UP_TASK_DESCRIPTION = 'Il Lead e stato spostato in Non Risponde. Ricontattare il prospect.';
  private static final String TASK_STATUS_OPEN = 'Open';
  private static final String TASK_PRIORITY_NORMAL = 'Normal';
  private static final String QUALIFIED_STATUS = 'Qualificato';
  private static Boolean conversionJobEnqueued = false;

  public static void beforeSave(List<Lead> newLeads, Map<Id, Lead> oldLeadMap) {
    preventDuplicateOpenLeads(newLeads);
    preventQualificationAccountConflicts(newLeads, oldLeadMap);
  }

  public static void afterUpdate(
    List<Lead> newLeads,
    Map<Id, Lead> oldLeadMap
  ) {
    List<Task> followUpTasks = buildNonRispondeFollowUpTasks(
      newLeads,
      oldLeadMap
    );
    if (!followUpTasks.isEmpty()) {
      insert followUpTasks;
    }

    enqueueLeadConversions(newLeads, oldLeadMap);
  }

  private static void preventDuplicateOpenLeads(List<Lead> newLeads) {
    Set<String> leadKeys = new Set<String>();
    Set<String> duplicateKeysInBatch = new Set<String>();
    Set<String> emails = new Set<String>();
    Set<Id> currentLeadIds = new Set<Id>();

    for (Lead leadRecord : newLeads) {
      if (leadRecord.Id != null) {
        currentLeadIds.add(leadRecord.Id);
      }

      String email = normalizeEmail(leadRecord.Email);
      String phone = normalizePhone(leadRecord.Phone);
      if (email == null || phone == null) {
        continue;
      }

      String leadKey = buildPersonKey(email, phone);
      if (leadKeys.contains(leadKey)) {
        duplicateKeysInBatch.add(leadKey);
      }
      leadKeys.add(leadKey);
      emails.add(email);
    }

    if (leadKeys.isEmpty()) {
      return;
    }

    Set<String> duplicateKeys = new Set<String>();
    duplicateKeys.addAll(duplicateKeysInBatch);

    for (Lead existingLead : [
      SELECT Id, Email, Phone
      FROM Lead
      WHERE IsConverted = FALSE AND Email IN :emails
    ]) {
      if (currentLeadIds.contains(existingLead.Id)) {
        continue;
      }

      String existingEmail = normalizeEmail(existingLead.Email);
      String existingPhone = normalizePhone(existingLead.Phone);
      if (existingEmail == null || existingPhone == null) {
        continue;
      }

      String existingKey = buildPersonKey(existingEmail, existingPhone);
      if (leadKeys.contains(existingKey)) {
        duplicateKeys.add(existingKey);
      }
    }

    if (duplicateKeys.isEmpty()) {
      return;
    }

    for (Lead leadRecord : newLeads) {
      String leadKey = buildPersonKey(
        normalizeEmail(leadRecord.Email),
        normalizePhone(leadRecord.Phone)
      );
      if (duplicateKeys.contains(leadKey)) {
        leadRecord.Email.addError(DUPLICATE_LEAD_ERROR);
      }
    }
  }

  private static void preventQualificationAccountConflicts(
    List<Lead> newLeads,
    Map<Id, Lead> oldLeadMap
  ) {
    List<Lead> leadsToCheck = new List<Lead>();
    Set<String> emails = new Set<String>();
    Set<String> vatNumbers = new Set<String>();

    for (Lead leadRecord : newLeads) {
      Lead oldLead = oldLeadMap == null ? null : oldLeadMap.get(leadRecord.Id);
      Boolean isNewQualification =
        leadRecord.IsConverted != true &&
        leadRecord.Status == QUALIFIED_STATUS &&
        (oldLead == null ||
        oldLead.Status != QUALIFIED_STATUS);

      String email = normalizeEmail(leadRecord.Email);
      String phone = normalizePhone(leadRecord.Phone);
      String vatNumber = normalizeVat(leadRecord.Partita_IVA__c);
      if (
        !isNewQualification ||
        email == null ||
        phone == null ||
        vatNumber == null
      ) {
        continue;
      }

      leadsToCheck.add(leadRecord);
      emails.add(email);
      vatNumbers.add(vatNumber);
    }

    if (leadsToCheck.isEmpty()) {
      return;
    }

    Map<String, Account> accountsByVat = getAccountsByVat(vatNumbers);
    Map<Id, Id> commercialAccountIdsByAccountId = resolveAccountIds(
      accountsByVat.values()
    );
    Map<String, List<Contact>> contactsByPersonKey = getContactsByPersonKey(
      emails
    );

    Set<Id> contactAccountIds = new Set<Id>();
    for (List<Contact> contactGroup : contactsByPersonKey.values()) {
      for (Contact contactRecord : contactGroup) {
        if (contactRecord.AccountId != null) {
          contactAccountIds.add(contactRecord.AccountId);
        }
      }
    }
    Map<Id, Id> commercialAccountIdsByContactAccountId = CommercialAccountResolver.resolveAll(
      contactAccountIds
    );

    for (Lead leadRecord : leadsToCheck) {
      Account accountByVat = accountsByVat.get(
        normalizeVat(leadRecord.Partita_IVA__c)
      );
      if (accountByVat == null) {
        continue;
      }

      Id leadCommercialAccountId = commercialAccountIdsByAccountId.get(
        accountByVat.Id
      );
      String personKey = buildPersonKey(
        normalizeEmail(leadRecord.Email),
        normalizePhone(leadRecord.Phone)
      );
      List<Contact> matchingContacts = contactsByPersonKey.get(personKey);
      if (matchingContacts == null) {
        continue;
      }

      for (Contact contactRecord : matchingContacts) {
        Id contactCommercialAccountId = commercialAccountIdsByContactAccountId.get(
          contactRecord.AccountId
        );
        if (
          contactCommercialAccountId != null &&
          contactCommercialAccountId != leadCommercialAccountId
        ) {
          leadRecord.Partita_IVA__c.addError(CONTACT_ACCOUNT_CONFLICT_ERROR);
          break;
        }
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
    for (Lead leadRecord : newLeads) {
      Lead oldLead = oldLeadMap.get(leadRecord.Id);
      if (
        leadRecord.IsConverted != true &&
        leadRecord.Status == QUALIFIED_STATUS &&
        oldLead.Status != QUALIFIED_STATUS
      ) {
        qualifiedLeadIds.add(leadRecord.Id);
      }
    }

    if (!qualifiedLeadIds.isEmpty()) {
      conversionJobEnqueued = true;
      System.enqueueJob(new LeadConversionQueueable(qualifiedLeadIds));
    }
  }

  private static Map<String, Account> getAccountsByVat(Set<String> vatNumbers) {
    Map<String, Account> accountsByVat = new Map<String, Account>();
    if (vatNumbers.isEmpty()) {
      return accountsByVat;
    }

    for (Account accountRecord : [
      SELECT Id, Partita_IVA__c
      FROM Account
      WHERE Partita_IVA__c IN :vatNumbers
      ORDER BY CreatedDate, Id
    ]) {
      String vatNumber = normalizeVat(accountRecord.Partita_IVA__c);
      if (vatNumber != null && !accountsByVat.containsKey(vatNumber)) {
        accountsByVat.put(vatNumber, accountRecord);
      }
    }

    return accountsByVat;
  }

  private static Map<Id, Id> resolveAccountIds(List<Account> accountRecords) {
    Set<Id> accountIds = new Set<Id>();
    for (Account accountRecord : accountRecords) {
      accountIds.add(accountRecord.Id);
    }

    return CommercialAccountResolver.resolveAll(accountIds);
  }

  private static Map<String, List<Contact>> getContactsByPersonKey(
    Set<String> emails
  ) {
    Map<String, List<Contact>> contactsByPersonKey = new Map<String, List<Contact>>();
    if (emails.isEmpty()) {
      return contactsByPersonKey;
    }

    for (Contact contactRecord : [
      SELECT Id, AccountId, Email, Phone
      FROM Contact
      WHERE Email IN :emails
      ORDER BY CreatedDate, Id
    ]) {
      String email = normalizeEmail(contactRecord.Email);
      String phone = normalizePhone(contactRecord.Phone);
      if (email == null || phone == null) {
        continue;
      }

      String personKey = buildPersonKey(email, phone);
      if (!contactsByPersonKey.containsKey(personKey)) {
        contactsByPersonKey.put(personKey, new List<Contact>());
      }
      contactsByPersonKey.get(personKey).add(contactRecord);
    }

    return contactsByPersonKey;
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
