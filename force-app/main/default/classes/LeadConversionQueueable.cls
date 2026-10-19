public without sharing class LeadConversionQueueable implements Queueable {
  private static final String QUALIFIED_STATUS = 'Qualificato';
  private static final String CONVERTED_STATUS = 'Convertito';
  private static final String AZIENDA_RECORD_TYPE = 'Azienda';

  private static final String STANDARD_OPPORTUNITY_RECORD_TYPE = 'Vendita_Standard';
  private static final String PLUS_OPPORTUNITY_RECORD_TYPE = 'Plus_Attivazione_Rinnovo';
  private static final String STANDARD_OPPORTUNITY_TYPE = 'Vendita da tutor';
  private static final String PLUS_ACTIVATION_OPPORTUNITY_TYPE = 'Performance Plus - Attivazione';
  private static final String PLUS_RENEWAL_OPPORTUNITY_TYPE = 'Performance Plus - Rinnovo';

  private static final Integer OPPORTUNITY_NAME_LIMIT = 120;
  private static final Integer LEAD_CONVERT_BATCH_SIZE = 100;
  private static final String USER_ID_PREFIX = '005';

  private final List<Id> leadIds;
  private final Map<Id, String> previousStatusByLeadId;

  public LeadConversionQueueable(List<Id> leadIds) {
    this(leadIds, null);
  }

  public LeadConversionQueueable(
    List<Id> leadIds,
    Map<Id, String> previousStatusByLeadId
  ) {
    this.leadIds = new List<Id>();
    this.previousStatusByLeadId = new Map<Id, String>();

    if (leadIds != null) {
      this.leadIds.addAll(leadIds);
    }
    if (previousStatusByLeadId != null) {
      this.previousStatusByLeadId.putAll(previousStatusByLeadId);
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
        Phone,
        Partita_IVA__c,
        OwnerId,
        Status,
        IsConverted,
        Tipo_Opportunita__c,
        Agente__c
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

    Savepoint conversionSavepoint = Database.setSavepoint();
    try {
      Map<Id, Id> accountIdsByLeadId = convertQualifiedLeads(leadsToConvert);
      publishCompletionEvents(leadsToConvert, true, accountIdsByLeadId);
    } catch (Exception conversionError) {
      Database.rollback(conversionSavepoint);
      System.debug(
        LoggingLevel.ERROR,
        'Lead conversion transaction rolled back: ' +
        conversionError.getMessage()
      );
      if (!restorePreviousLeadStatuses(leadsToConvert)) {
        throw conversionError;
      }
      publishCompletionEvents(leadsToConvert, false, null);
    }
  }

  private static void publishCompletionEvents(
    List<Lead> processedLeads,
    Boolean succeeded,
    Map<Id, Id> accountIdsByLeadId
  ) {
    List<Lead_Conversion_Completed__e> completionEvents = new List<Lead_Conversion_Completed__e>();
    for (Lead leadRecord : processedLeads) {
      Id accountId = accountIdsByLeadId == null
        ? null
        : accountIdsByLeadId.get(leadRecord.Id);
      completionEvents.add(
        new Lead_Conversion_Completed__e(
          Account_Id__c = accountId == null ? null : String.valueOf(accountId),
          Lead_Id__c = String.valueOf(leadRecord.Id),
          Succeeded__c = succeeded
        )
      );
    }

    for (
      Database.SaveResult publishResult : EventBus.publish(completionEvents)
    ) {
      if (!publishResult.isSuccess()) {
        System.debug(
          LoggingLevel.ERROR,
          'Lead conversion completion event was not published: ' +
          publishResult.getErrors()[0].getMessage()
        );
      }
    }
  }

  private static Map<Id, Id> convertQualifiedLeads(List<Lead> leadsToConvert) {
    Map<Id, Id> accountIdsByLeadId = resolveConversionAccounts(leadsToConvert);

    Map<String, Contact> contactsByAccountAndPersonKey = getContactsByAccountAndPersonKey(
      leadsToConvert,
      new Set<Id>(accountIdsByLeadId.values())
    );

    List<Database.LeadConvert> conversionRequests = new List<Database.LeadConvert>();

    Map<Id, String> leadEmailById = new Map<Id, String>();

    Map<Id, String> leadOpportunityTypeById = new Map<Id, String>();

    for (Lead leadRecord : leadsToConvert) {
      String normalizedEmail = normalizeEmail(leadRecord.Email);

      if (normalizedEmail != null) {
        leadEmailById.put(leadRecord.Id, normalizedEmail);
      }

      leadOpportunityTypeById.put(
        leadRecord.Id,
        normalizeOpportunityType(leadRecord.Tipo_Opportunita__c)
      );

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

      Id accountId = accountIdsByLeadId.get(leadRecord.Id);

      if (accountId != null) {
        conversionRequest.setAccountId(accountId);

        Contact matchingContact = contactsByAccountAndPersonKey.get(
          buildAccountPersonKey(
            accountId,
            normalizeEmail(leadRecord.Email),
            normalizePhone(leadRecord.Phone)
          )
        );

        if (matchingContact != null) {
          conversionRequest.setContactId(matchingContact.Id);
        }
      }

      conversionRequests.add(conversionRequest);
    }

    List<Database.LeadConvertResult> conversionResults = convertLeads(
      conversionRequests
    );

    /*
     * NEW LOGIC
     *
     * If Lead conversion created a new Contact,
     * set Contatto_Principale__c = true.
     *
     * Existing Contacts used during conversion
     * are not modified.
     */
    setPrimaryContactOnNewContacts(
      conversionResults,
      contactsByAccountAndPersonKey
    );

    setConvertedOpportunityTypes(conversionResults, leadOpportunityTypeById);

    updateConvertedAccountLeadEmails(conversionResults, leadEmailById);

    Map<Id, Id> convertedAccountIdsByLeadId = new Map<Id, Id>();
    for (Database.LeadConvertResult result : conversionResults) {
      convertedAccountIdsByLeadId.put(
        result.getLeadId(),
        result.getAccountId()
      );
    }
    return convertedAccountIdsByLeadId;
  }

  private Boolean restorePreviousLeadStatuses(List<Lead> leadsToRestore) {
    List<Lead> statusUpdates = new List<Lead>();
    for (Lead leadRecord : leadsToRestore) {
      String previousStatus = previousStatusByLeadId.get(leadRecord.Id);
      if (String.isBlank(previousStatus)) {
        return false;
      }
      statusUpdates.add(new Lead(Id = leadRecord.Id, Status = previousStatus));
    }

    LeadConversionTriggerHandler.setAutomationBypassed(true);
    try {
      update statusUpdates;
    } finally {
      LeadConversionTriggerHandler.setAutomationBypassed(false);
    }
    return true;
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
    requireEveryConversionToSucceed(conversionResults);

    return conversionResults;
  }

  /*
   * NEW METHOD
   *
   * Sets Contatto_Principale__c = true only
   * on Contacts created by Lead conversion.
   *
   * Contacts that existed before conversion
   * remain unchanged.
   */
  private static void setPrimaryContactOnNewContacts(
    List<Database.LeadConvertResult> conversionResults,
    Map<String, Contact> existingContacts
  ) {
    Set<Id> existingContactIds = new Set<Id>();

    if (existingContacts != null) {
      for (Contact contactRecord : existingContacts.values()) {
        if (contactRecord != null) {
          existingContactIds.add(contactRecord.Id);
        }
      }
    }

    List<Contact> contactsToUpdate = new List<Contact>();

    for (Database.LeadConvertResult result : conversionResults) {
      if (!result.isSuccess() || result.getContactId() == null) {
        continue;
      }

      /*
       * If this Contact already existed
       * before conversion, don't modify it.
       */
      if (existingContactIds.contains(result.getContactId())) {
        continue;
      }

      contactsToUpdate.add(
        new Contact(Id = result.getContactId(), Contatto_Principale__c = true)
      );
    }

    if (!contactsToUpdate.isEmpty()) {
      update contactsToUpdate;
    }
  }

  private static void setConvertedOpportunityTypes(
    List<Database.LeadConvertResult> conversionResults,
    Map<Id, String> leadOpportunityTypeById
  ) {
    Set<Id> opportunityIds = new Set<Id>();

    Set<String> recordTypeDeveloperNames = new Set<String>();

    Map<Id, String> opportunityTypeByOpportunityId = new Map<Id, String>();

    for (Database.LeadConvertResult result : conversionResults) {
      if (!result.isSuccess() || result.getOpportunityId() == null) {
        continue;
      }

      opportunityIds.add(result.getOpportunityId());

      String opportunityType = leadOpportunityTypeById.get(result.getLeadId());

      opportunityTypeByOpportunityId.put(
        result.getOpportunityId(),
        opportunityType
      );

      recordTypeDeveloperNames.add(
        getOpportunityRecordTypeDeveloperName(opportunityType)
      );
    }

    if (opportunityIds.isEmpty()) {
      return;
    }

    Map<String, Id> recordTypeIdsByDeveloperName = getOpportunityRecordTypeIds(
      recordTypeDeveloperNames
    );

    List<Opportunity> opportunitiesToUpdate = new List<Opportunity>();

    for (Id opportunityId : opportunityIds) {
      String opportunityType = opportunityTypeByOpportunityId.get(
        opportunityId
      );

      String recordTypeDeveloperName = getOpportunityRecordTypeDeveloperName(
        opportunityType
      );

      opportunitiesToUpdate.add(
        new Opportunity(
          Id = opportunityId,
          RecordTypeId = recordTypeIdsByDeveloperName.get(
            recordTypeDeveloperName
          ),
          Tipo_Opportunita__c = opportunityType
        )
      );
    }

    update opportunitiesToUpdate;
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

  private static void requireEveryConversionToSucceed(
    List<Database.LeadConvertResult> conversionResults
  ) {
    Integer failureCount = 0;
    String firstFailure;

    for (Database.LeadConvertResult result : conversionResults) {
      if (result.isSuccess()) {
        continue;
      }

      failureCount++;
      if (firstFailure == null) {
        Database.Error[] errors = result.getErrors();
        firstFailure = errors.isEmpty()
          ? 'Unknown conversion error for Lead ' + result.getLeadId()
          : 'Lead ' +
            result.getLeadId() +
            ': ' +
            errors[0].getStatusCode() +
            ' - ' +
            errors[0].getMessage();
      }
    }

    if (failureCount > 0) {
      throw new LeadConversionException(
        'Lead conversion rolled back because ' +
          failureCount +
          ' conversion(s) failed. First failure: ' +
          firstFailure
      );
    }
  }

  private static Map<Id, Id> resolveConversionAccounts(List<Lead> leads) {
    Map<Id, Id> accountIdsByLeadId = new Map<Id, Id>();

    Set<String> vatNumbers = getNormalizedVatNumbers(leads);

    Map<String, Account> accountsByVat = getAccountsByVat(vatNumbers);

    Map<Id, Id> commercialAccountIdsByAccountId = resolveAccountIds(
      accountsByVat.values()
    );

    for (Lead leadRecord : leads) {
      Account matchingAccount = accountsByVat.get(
        normalizeVat(leadRecord.Partita_IVA__c)
      );

      if (matchingAccount != null) {
        accountIdsByLeadId.put(
          leadRecord.Id,
          commercialAccountIdsByAccountId.get(matchingAccount.Id)
        );
      }
    }

    createMissingAziendaAccounts(leads, accountIdsByLeadId);

    return accountIdsByLeadId;
  }

  private static void createMissingAziendaAccounts(
    List<Lead> leads,
    Map<Id, Id> accountIdsByLeadId
  ) {
    Id aziendaRecordTypeId = getAziendaAccountRecordTypeId();

    List<Account> accountsToInsert = new List<Account>();

    Map<Integer, Id> leadIdByAccountIndex = new Map<Integer, Id>();

    for (Lead leadRecord : leads) {
      if (accountIdsByLeadId.containsKey(leadRecord.Id)) {
        continue;
      }

      leadIdByAccountIndex.put(accountsToInsert.size(), leadRecord.Id);

      accountsToInsert.add(
        new Account(
          Name = buildAccountName(leadRecord),
          RecordTypeId = aziendaRecordTypeId,
          Lead_Email__c = normalizeEmail(leadRecord.Email),
          Partita_IVA__c = normalizeVat(leadRecord.Partita_IVA__c),
          Phone = leadRecord.Phone,
          Agente__c = leadRecord.Agente__c
        )
      );
    }

    if (accountsToInsert.isEmpty()) {
      return;
    }

    insert accountsToInsert;

    for (Integer index = 0; index < accountsToInsert.size(); index++) {
      accountIdsByLeadId.put(
        leadIdByAccountIndex.get(index),
        accountsToInsert[index].Id
      );
    }
  }

  private static Set<String> getNormalizedVatNumbers(List<Lead> leads) {
    Set<String> vatNumbers = new Set<String>();

    for (Lead leadRecord : leads) {
      String vatNumber = normalizeVat(leadRecord.Partita_IVA__c);

      if (vatNumber != null) {
        vatNumbers.add(vatNumber);
      }
    }

    return vatNumbers;
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

  private static Map<String, Contact> getContactsByAccountAndPersonKey(
    List<Lead> leads,
    Set<Id> accountIds
  ) {
    Map<String, Contact> contactsByAccountAndPersonKey = new Map<String, Contact>();

    if (accountIds.isEmpty()) {
      return contactsByAccountAndPersonKey;
    }

    Set<String> emails = getNormalizedEmails(leads);

    if (emails.isEmpty()) {
      return contactsByAccountAndPersonKey;
    }

    for (Contact contactRecord : [
      SELECT Id, AccountId, Email, Phone
      FROM Contact
      WHERE AccountId IN :accountIds AND Email IN :emails
      ORDER BY CreatedDate, Id
    ]) {
      String contactKey = buildAccountPersonKey(
        contactRecord.AccountId,
        normalizeEmail(contactRecord.Email),
        normalizePhone(contactRecord.Phone)
      );

      if (
        contactKey != null &&
        !contactsByAccountAndPersonKey.containsKey(contactKey)
      ) {
        contactsByAccountAndPersonKey.put(contactKey, contactRecord);
      }
    }

    return contactsByAccountAndPersonKey;
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

  private static String buildAccountPersonKey(
    Id accountId,
    String email,
    String phone
  ) {
    if (accountId == null || email == null || phone == null) {
      return null;
    }

    return String.valueOf(accountId) + '|' + email + '|' + phone;
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

  private static String buildAccountName(Lead leadRecord) {
    return String.isBlank(leadRecord.Company)
      ? buildLeadName(leadRecord)
      : leadRecord.Company.trim();
  }

  private static Id getAziendaAccountRecordTypeId() {
    List<RecordType> recordTypes = [
      SELECT Id
      FROM RecordType
      WHERE SObjectType = 'Account' AND DeveloperName = :AZIENDA_RECORD_TYPE
      LIMIT 1
    ];

    if (recordTypes.isEmpty()) {
      throw new LeadConversionException(
        'Account record type Azienda was not found'
      );
    }

    return recordTypes[0].Id;
  }

  private static Map<String, Id> getOpportunityRecordTypeIds(
    Set<String> recordTypeDeveloperNames
  ) {
    Map<String, Id> recordTypeIdsByDeveloperName = new Map<String, Id>();

    for (RecordType recordType : [
      SELECT Id, DeveloperName
      FROM RecordType
      WHERE
        SObjectType = 'Opportunity'
        AND DeveloperName IN :recordTypeDeveloperNames
    ]) {
      recordTypeIdsByDeveloperName.put(recordType.DeveloperName, recordType.Id);
    }

    for (String recordTypeDeveloperName : recordTypeDeveloperNames) {
      if (!recordTypeIdsByDeveloperName.containsKey(recordTypeDeveloperName)) {
        throw new LeadConversionException(
          'Opportunity record type ' +
            recordTypeDeveloperName +
            ' was not found'
        );
      }
    }

    return recordTypeIdsByDeveloperName;
  }

  private static String normalizeOpportunityType(String opportunityType) {
    return String.isBlank(opportunityType)
      ? STANDARD_OPPORTUNITY_TYPE
      : opportunityType.trim();
  }

  private static String getOpportunityRecordTypeDeveloperName(
    String opportunityType
  ) {
    if (
      opportunityType == PLUS_ACTIVATION_OPPORTUNITY_TYPE ||
      opportunityType == PLUS_RENEWAL_OPPORTUNITY_TYPE
    ) {
      return PLUS_OPPORTUNITY_RECORD_TYPE;
    }

    return STANDARD_OPPORTUNITY_RECORD_TYPE;
  }

  public class LeadConversionException extends Exception {
  }
}
