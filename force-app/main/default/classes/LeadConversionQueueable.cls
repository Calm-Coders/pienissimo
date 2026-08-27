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

    Map<String, Contact> contactsByEmail = getContactsByEmail(leadsToConvert);
    List<Database.LeadConvert> conversionRequests = new List<Database.LeadConvert>();

    for (Lead leadRecord : leadsToConvert) {
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

      Contact matchingContact = contactsByEmail.get(
        normalizeEmail(leadRecord.Email)
      );
      applyExistingContactMatch(conversionRequest, matchingContact);

      conversionRequests.add(conversionRequest);
    }

    convertLeads(conversionRequests);
  }

  private static void convertLeads(
    List<Database.LeadConvert> conversionRequests
  ) {
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

      logConversionFailures(Database.convertLead(conversionBatch, false));
    }
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

  private static void applyExistingContactMatch(
    Database.LeadConvert conversionRequest,
    Contact matchingContact
  ) {
    if (matchingContact == null || matchingContact.AccountId == null) {
      return;
    }

    conversionRequest.setAccountId(matchingContact.AccountId);
    conversionRequest.setContactId(matchingContact.Id);
  }

  private static Map<String, Contact> getContactsByEmail(List<Lead> leads) {
    Set<String> emails = new Set<String>();
    for (Lead leadRecord : leads) {
      String email = normalizeEmail(leadRecord.Email);
      if (email != null) {
        emails.add(email);
      }
    }

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
