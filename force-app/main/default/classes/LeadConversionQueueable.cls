public with sharing class LeadConversionQueueable implements Queueable {
  private static final String QUALIFIED_STATUS = 'Qualificato';
  private static final String CONVERTED_STATUS = 'Convertito';
  private static final Integer OPPORTUNITY_NAME_LIMIT = 120;
  private static final Integer LEAD_CONVERT_BATCH_SIZE = 100;
  private static final String USER_ID_PREFIX = '005';

  private final List<Id> leadIds;

  public LeadConversionQueueable(List<Id> leadIds) {
    this.leadIds = new List<Id>();
    if (leadIds != null) {
      this.leadIds.addAll(leadIds);
    }
  }

  public void execute(QueueableContext context) {
    if (leadIds.isEmpty()) {
      return;
    }

    List<Lead> leadsToConvert = [
      SELECT
        Id,
        FirstName,
        LastName,
        Company,
        Email,
        OwnerId,
        Status,
        IsConverted
      FROM Lead
      WHERE
        Id IN :leadIds
        AND IsConverted = FALSE
        AND Status = :QUALIFIED_STATUS
      ORDER BY CreatedDate, Id
    ];

    if (leadsToConvert.isEmpty()) {
      return;
    }

    Set<String> emails = getNormalizedEmails(leadsToConvert);
    Map<String, Contact> contactsByEmail = getContactsByEmail(emails);
    Map<String, Account> accountsByLeadEmail = getAccountsByLeadEmail(emails);
    List<Database.LeadConvert> conversionRequests = new List<Database.LeadConvert>();
    Map<Id, String> leadEmailById = new Map<Id, String>();

    for (Lead leadRecord : leadsToConvert) {
      String normalizedEmail = normalizeEmail(leadRecord.Email);
      if (normalizedEmail != null) {
        leadEmailById.put(leadRecord.Id, normalizedEmail);
      }

      Database.LeadConvert conversionRequest = new Database.LeadConvert();
      conversionRequest.setLeadId(leadRecord.Id);
      conversionRequest.setConvertedStatus(CONVERTED_STATUS);
      conversionRequest.setDoNotCreateOpportunity(false);
      conversionRequest.setOpportunityName(buildOpportunityName(leadRecord));
      conversionRequest.setSendNotificationEmail(false);

      Id conversionOwnerId = resolveConversionOwnerId(leadRecord.OwnerId);
      if (conversionOwnerId != null) {
        conversionRequest.setOwnerId(conversionOwnerId);
      }

      applyExistingEmailMatch(
        conversionRequest,
        contactsByEmail.get(normalizedEmail),
        accountsByLeadEmail.get(normalizedEmail)
      );

      conversionRequests.add(conversionRequest);
    }

    List<Database.LeadConvertResult> conversionResults = convertLeads(
      conversionRequests
    );
    updateConvertedAccountLeadEmails(conversionResults, leadEmailById);
  }

  private static List<Database.LeadConvertResult> convertLeads(
    List<Database.LeadConvert> conversionRequests
  ) {
    List<Database.LeadConvertResult> conversionResults = new List<Database.LeadConvertResult>();
    for (
      Integer startIndex = 0;
      startIndex < conversionRequests.size();
      startIndex += LEAD_CONVERT_BATCH_SIZE
    ) {
      Integer endIndex = Math.min(
        startIndex + LEAD_CONVERT_BATCH_SIZE,
        conversionRequests.size()
      );
      List<Database.LeadConvert> conversionBatch = new List<Database.LeadConvert>();
      for (Integer index = startIndex; index < endIndex; index++) {
        conversionBatch.add(conversionRequests[index]);
      }

      conversionResults.addAll(Database.convertLead(conversionBatch, false));
    }

    logConversionFailures(conversionResults);
    return conversionResults;
  }

  private static void logConversionFailures(
    List<Database.LeadConvertResult> conversionResults
  ) {
    for (Database.LeadConvertResult result : conversionResults) {
      if (result.isSuccess()) {
        continue;
      }

      for (Database.Error error : result.getErrors()) {
        System.debug(
          LoggingLevel.ERROR,
          'Lead conversion failed for Lead ' +
            result.getLeadId() +
            ': ' +
            error.getStatusCode() +
            ' - ' +
            error.getMessage()
        );
      }
    }
  }

  private static void applyExistingEmailMatch(
    Database.LeadConvert conversionRequest,
    Contact matchingContact,
    Account matchingAccount
  ) {
    if (matchingContact != null && matchingContact.AccountId != null) {
      conversionRequest.setAccountId(matchingContact.AccountId);
      conversionRequest.setContactId(matchingContact.Id);
      return;
    }

    if (matchingAccount != null) {
      conversionRequest.setAccountId(matchingAccount.Id);
    }
  }

  private static Set<String> getNormalizedEmails(List<Lead> leads) {
    Set<String> emails = new Set<String>();
    for (Lead leadRecord : leads) {
      String email = normalizeEmail(leadRecord.Email);
      if (email != null) {
        emails.add(email);
      }
    }

    return emails;
  }

  private static Map<String, Contact> getContactsByEmail(Set<String> emails) {
    Map<String, Contact> contactsByEmail = new Map<String, Contact>();
    if (emails.isEmpty()) {
      return contactsByEmail;
    }

    for (Contact contactRecord : [
      SELECT Id, AccountId, Email
      FROM Contact
      WHERE Email IN :emails
      ORDER BY CreatedDate, Id
    ]) {
      String email = normalizeEmail(contactRecord.Email);
      if (email == null) {
        continue;
      }

      Contact existingContact = contactsByEmail.get(email);
      if (
        existingContact == null ||
        (existingContact.AccountId == null &&
        contactRecord.AccountId != null)
      ) {
        contactsByEmail.put(email, contactRecord);
      }
    }

    return contactsByEmail;
  }

  private static Map<String, Account> getAccountsByLeadEmail(
    Set<String> emails
  ) {
    Map<String, Account> accountsByLeadEmail = new Map<String, Account>();
    if (emails.isEmpty()) {
      return accountsByLeadEmail;
    }

    for (Account accountRecord : [
      SELECT Id, Lead_Email__c
      FROM Account
      WHERE Lead_Email__c IN :emails
      ORDER BY CreatedDate, Id
    ]) {
      String email = normalizeEmail(accountRecord.Lead_Email__c);
      if (email != null && !accountsByLeadEmail.containsKey(email)) {
        accountsByLeadEmail.put(email, accountRecord);
      }
    }

    return accountsByLeadEmail;
  }

  private static void updateConvertedAccountLeadEmails(
    List<Database.LeadConvertResult> conversionResults,
    Map<Id, String> leadEmailById
  ) {
    Set<Id> accountIds = new Set<Id>();
    Map<Id, String> leadEmailByAccountId = new Map<Id, String>();
    for (Database.LeadConvertResult result : conversionResults) {
      if (!result.isSuccess() || result.getAccountId() == null) {
        continue;
      }

      String email = leadEmailById.get(result.getLeadId());
      if (email == null) {
        continue;
      }

      accountIds.add(result.getAccountId());
      leadEmailByAccountId.put(result.getAccountId(), email);
    }

    if (accountIds.isEmpty()) {
      return;
    }

    List<Account> accountsToUpdate = new List<Account>();
    for (Account accountRecord : [
      SELECT Id, Lead_Email__c
      FROM Account
      WHERE Id IN :accountIds
    ]) {
      if (String.isBlank(accountRecord.Lead_Email__c)) {
        accountsToUpdate.add(
          new Account(
            Id = accountRecord.Id,
            Lead_Email__c = leadEmailByAccountId.get(accountRecord.Id)
          )
        );
      }
    }

    if (!accountsToUpdate.isEmpty()) {
      update accountsToUpdate;
    }
  }

  private static String normalizeEmail(String email) {
    return String.isBlank(email) ? null : email.trim().toLowerCase();
  }

  private static Id resolveConversionOwnerId(Id leadOwnerId) {
    return String.valueOf(leadOwnerId).startsWith(USER_ID_PREFIX)
      ? null
      : UserInfo.getUserId();
  }

  private static String buildOpportunityName(Lead leadRecord) {
    String baseName = String.isBlank(leadRecord.Company)
      ? buildLeadName(leadRecord)
      : leadRecord.Company.trim();

    return baseName.length() > OPPORTUNITY_NAME_LIMIT
      ? baseName.substring(0, OPPORTUNITY_NAME_LIMIT)
      : baseName;
  }

  private static String buildLeadName(Lead leadRecord) {
    List<String> nameParts = new List<String>();
    if (!String.isBlank(leadRecord.FirstName)) {
      nameParts.add(leadRecord.FirstName.trim());
    }
    if (!String.isBlank(leadRecord.LastName)) {
      nameParts.add(leadRecord.LastName.trim());
    }

    return nameParts.isEmpty()
      ? 'Lead qualificato'
      : String.join(nameParts, ' ');
  }
}
