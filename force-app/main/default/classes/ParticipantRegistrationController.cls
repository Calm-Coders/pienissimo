public without sharing class ParticipantRegistrationController {
  private static final String COMPLETED_STATE = 'COMPLETED';
  private static final String READY_STATE = 'READY';
  private static final String ASSIGNED_STATUS = 'Assegnato';

  private static final Set<String> VISIBLE_STATUSES = new Set<String>{
    'Disponibile',
    'Assegnato'
  };

  public class TicketRow {
    @AuraEnabled
    public Id assetId { get; set; }
    @AuraEnabled
    public String ticketName { get; set; }
    @AuraEnabled
    public String productName { get; set; }
    @AuraEnabled
    public String campaignName { get; set; }
    @AuraEnabled
    public Date eventStartDate { get; set; }
    @AuraEnabled
    public Boolean editable { get; set; }
    @AuraEnabled
    public Boolean assigned { get; set; }
    @AuraEnabled
    public String firstName { get; set; }
    @AuraEnabled
    public String lastName { get; set; }
    @AuraEnabled
    public String email { get; set; }
    @AuraEnabled
    public String phone { get; set; }
  }

  public class PageResponse {
    @AuraEnabled
    public String state { get; set; }
    @AuraEnabled
    public String message { get; set; }
    @AuraEnabled
    public String accountId { get; set; }
    @AuraEnabled
    public String accountName { get; set; }
    @AuraEnabled
    public String campaignId { get; set; }
    @AuraEnabled
    public String campaignName { get; set; }
    @AuraEnabled
    public Date eventStartDate { get; set; }
    @AuraEnabled
    public Date eventEndDate { get; set; }
    @AuraEnabled
    public List<TicketRow> tickets { get; set; }

    public PageResponse() {
      tickets = new List<TicketRow>();
    }
  }

  public class ContactResponse {
    @AuraEnabled
    public Boolean found { get; set; }
    @AuraEnabled
    public String firstName { get; set; }
    @AuraEnabled
    public String lastName { get; set; }
    @AuraEnabled
    public String phone { get; set; }

    public ContactResponse() {
      found = false;
    }
  }

  public class ParticipantInput {
    @AuraEnabled
    public String assetId { get; set; }
    @AuraEnabled
    public String firstName { get; set; }
    @AuraEnabled
    public String lastName { get; set; }
    @AuraEnabled
    public String email { get; set; }
    @AuraEnabled
    public String phone { get; set; }
  }

  private class AccessContext {
    public Account account;
    public Campaign campaign;
  }

  private class RequestException extends Exception {
  }

  @AuraEnabled(cacheable=true)
  public static PageResponse loadPage(String accountId, String campaignId) {
    try {
      return buildPage(resolveAccess(accountId, campaignId));
    } catch (RequestException requestError) {
      throw handled(requestError.getMessage());
    } catch (Exception unexpectedError) {
      throw handled(
        'Non e stato possibile completare la richiesta. Riprova piu tardi.'
      );
    }
  }

  @AuraEnabled(cacheable=true)
  public static ContactResponse findContact(
    String accountId,
    String campaignId,
    String email
  ) {
    try {
      AccessContext access = resolveAccess(accountId, campaignId);
      String normalizedEmail = normalizeEmail(email);

      if (!isValidEmail(normalizedEmail)) {
        throw new RequestException('Inserisci un indirizzo email valido.');
      }

      List<Contact> contacts = [
        SELECT Id, FirstName, LastName, Phone, Email
        FROM Contact
        WHERE AccountId = :access.account.Id AND Email = :normalizedEmail
        ORDER BY CreatedDate ASC
        LIMIT 2
      ];

      if (contacts.size() > 1) {
        throw new RequestException(
          'Esistono piu contatti con questa email. Contatta il tuo referente.'
        );
      }

      ContactResponse response = new ContactResponse();

      if (!contacts.isEmpty()) {
        response.found = true;
        response.firstName = contacts[0].FirstName;
        response.lastName = contacts[0].LastName;
        response.phone = contacts[0].Phone;
      }

      return response;
    } catch (RequestException requestError) {
      throw handled(requestError.getMessage());
    } catch (Exception unexpectedError) {
      throw handled(
        'Non e stato possibile completare la richiesta. Riprova piu tardi.'
      );
    }
  }

  @AuraEnabled
  public static PageResponse savePage(
    String accountId,
    String campaignId,
    List<ParticipantInput> participants
  ) {
    Savepoint savepoint = Database.setSavepoint();

    try {
      AccessContext access = resolveAccess(accountId, campaignId);
      PageResponse response = saveParticipants(access, participants);
      response.message = 'I dati dei partecipanti sono stati salvati.';
      return response;
    } catch (RequestException requestError) {
      Database.rollback(savepoint);
      throw handled(requestError.getMessage());
    } catch (Exception unexpectedError) {
      Database.rollback(savepoint);
      throw handled(
        'Non e stato possibile completare la richiesta. Riprova piu tardi.'
      );
    }
  }

  private static AccessContext resolveAccess(
    String rawAccountId,
    String rawCampaignId
  ) {
    Id accountId = parseAccountId(rawAccountId);
    Id campaignId = parseCampaignId(rawCampaignId);

    if (accountId == null || campaignId == null) {
      throw invalidLink();
    }

    List<Account> accounts = [
      SELECT Id, Name
      FROM Account
      WHERE Id = :accountId
      LIMIT 1
    ];

    List<Campaign> campaigns = [
      SELECT Id, Name, StartDate, EndDate
      FROM Campaign
      WHERE Id = :campaignId
      LIMIT 1
    ];

    if (accounts.isEmpty() || campaigns.isEmpty()) {
      throw invalidLink();
    }

    AccessContext result = new AccessContext();
    result.account = accounts[0];
    result.campaign = campaigns[0];
    return result;
  }

  private static PageResponse buildPage(AccessContext access) {
    PageResponse response = new PageResponse();
    response.accountId = access.account.Id;
    response.accountName = access.account.Name;
    response.campaignId = access.campaign.Id;
    response.campaignName = access.campaign.Name;
    response.eventStartDate = access.campaign.StartDate;
    response.eventEndDate = access.campaign.EndDate;

    List<Asset> tickets = queryVisibleAssets(
      access.account.Id,
      access.campaign.Id,
      false
    );

    Integer requiredParticipantCount = 0;

    for (Asset ticket : tickets) {
      TicketRow row = new TicketRow();
      row.assetId = ticket.Id;
      row.ticketName = ticket.Name;
      row.productName = ticket.Product2 == null ? null : ticket.Product2.Name;
      row.campaignName = ticket.Campaign__r == null
        ? null
        : ticket.Campaign__r.Name;
      row.eventStartDate = ticket.Campaign__r == null
        ? null
        : ticket.Campaign__r.StartDate;
      row.assigned = ticket.ContactId != null;
      row.editable = !row.assigned && VISIBLE_STATUSES.contains(ticket.Status);

      if (row.editable) {
        requiredParticipantCount++;
      }

      if (ticket.Contact != null) {
        row.firstName = ticket.Contact.FirstName;
        row.lastName = ticket.Contact.LastName;
        row.email = ticket.Contact.Email;
        row.phone = ticket.Contact.Phone;
      }

      response.tickets.add(row);
    }

    if (tickets.isEmpty()) {
      response.state = 'NO_TICKETS';
      response.message = 'Non ci sono biglietti disponibili per questo account.';
      return response;
    }

    response.state = requiredParticipantCount > 0
      ? READY_STATE
      : COMPLETED_STATE;
    response.message = requiredParticipantCount > 0
      ? null
      : 'La lista dei partecipanti e gia stata inviata.';

    return response;
  }

  private static PageResponse saveParticipants(
    AccessContext access,
    List<ParticipantInput> inputs
  ) {
    if (inputs == null || inputs.isEmpty()) {
      throw new RequestException(
        'Completa tutti i biglietti prima di salvare.'
      );
    }

    List<Asset> visibleAssets = queryVisibleAssets(
      access.account.Id,
      access.campaign.Id,
      true
    );

    Map<Id, Asset> eligibleAssets = new Map<Id, Asset>();

    for (Asset ticket : visibleAssets) {
      if (ticket.ContactId == null) {
        eligibleAssets.put(ticket.Id, ticket);
      }
    }

    if (inputs.size() != eligibleAssets.size()) {
      throw staleTickets();
    }

    Set<Id> submittedAssetIds = new Set<Id>();
    Map<String, ParticipantInput> participantByEmail = new Map<String, ParticipantInput>();

    for (ParticipantInput input : inputs) {
      validateParticipant(
        input,
        eligibleAssets,
        submittedAssetIds,
        participantByEmail
      );
    }

    Map<String, Contact> contactByEmail = findExistingContacts(
      access.account.Id,
      participantByEmail.keySet()
    );

    List<Contact> contactsToCreate = new List<Contact>();

    for (String email : participantByEmail.keySet()) {
      if (!contactByEmail.containsKey(email)) {
        ParticipantInput input = participantByEmail.get(email);

        Contact participant = new Contact(
          AccountId = access.account.Id,
          FirstName = input.firstName.trim(),
          LastName = input.lastName.trim(),
          Email = input.email.trim(),
          Phone = input.phone.trim()
        );

        contactsToCreate.add(participant);
        contactByEmail.put(email, participant);
      }
    }

    if (!contactsToCreate.isEmpty()) {
      insert contactsToCreate;
    }

    List<Asset> assetsToUpdate = new List<Asset>();
    Set<Id> participantContactIds = new Set<Id>();

    for (ParticipantInput input : inputs) {
      Id assetId = parseAssetId(input.assetId);
      Contact participant = contactByEmail.get(normalizeEmail(input.email));

      if (participant == null || participant.Id == null) {
        throw new RequestException(
          'Non e stato possibile associare il partecipante al biglietto.'
        );
      }

      participantContactIds.add(participant.Id);
      assetsToUpdate.add(
        new Asset(
          Id = assetId,
          ContactId = participant.Id,
          Status = ASSIGNED_STATUS
        )
      );
    }

    insertMissingCampaignMembers(access.campaign.Id, participantContactIds);

    if (!assetsToUpdate.isEmpty()) {
      update assetsToUpdate;
    }

    return buildPage(access);
  }

  private static void insertMissingCampaignMembers(
    Id campaignId,
    Set<Id> contactIds
  ) {
    if (contactIds == null || contactIds.isEmpty()) {
      return;
    }

    Set<Id> existingContactIds = new Set<Id>();

    for (CampaignMember member : [
      SELECT ContactId
      FROM CampaignMember
      WHERE CampaignId = :campaignId AND ContactId IN :contactIds
    ]) {
      existingContactIds.add(member.ContactId);
    }

    List<CampaignMember> membersToCreate = new List<CampaignMember>();

    for (Id contactId : contactIds) {
      if (!existingContactIds.contains(contactId)) {
        membersToCreate.add(
          new CampaignMember(CampaignId = campaignId, ContactId = contactId)
        );
      }
    }

    if (!membersToCreate.isEmpty()) {
      insert membersToCreate;
    }
  }

  private static Map<String, Contact> findExistingContacts(
    Id accountId,
    Set<String> emails
  ) {
    Map<String, Contact> result = new Map<String, Contact>();
    Set<String> duplicateEmails = new Set<String>();

    if (emails == null || emails.isEmpty()) {
      return result;
    }

    for (Contact participant : [
      SELECT Id, Email
      FROM Contact
      WHERE AccountId = :accountId AND Email IN :emails
      ORDER BY CreatedDate ASC
    ]) {
      String email = normalizeEmail(participant.Email);

      if (result.containsKey(email)) {
        duplicateEmails.add(email);
      } else {
        result.put(email, participant);
      }
    }

    if (!duplicateEmails.isEmpty()) {
      throw new RequestException(
        'Esistono piu contatti con la stessa email. Contatta il tuo referente.'
      );
    }

    return result;
  }

  private static List<Asset> queryVisibleAssets(
    Id accountId,
    Id campaignId,
    Boolean lockRecords
  ) {
    String queryText =
      'SELECT Id, Name, Status, ContactId, Campaign__c, Campaign__r.Name, ' +
      'Campaign__r.StartDate, Campaign__r.EndDate, Contact.FirstName, ' +
      'Contact.LastName, Contact.Email, Contact.Phone, Product2.Name ' +
      'FROM Asset WHERE AccountId = :accountId AND Campaign__c = :campaignId ' +
      'AND Status IN :VISIBLE_STATUSES ';

    if (lockRecords) {
      queryText += 'FOR UPDATE';
    } else {
      queryText += 'ORDER BY Campaign__r.StartDate, Campaign__r.Name, Product2.Name, Name';
    }

    return Database.query(queryText);
  }

  private static void validateParticipant(
    ParticipantInput input,
    Map<Id, Asset> eligibleAssets,
    Set<Id> submittedAssetIds,
    Map<String, ParticipantInput> participantByEmail
  ) {
    if (input == null) {
      throw invalidParticipant();
    }

    Id assetId = parseAssetId(input.assetId);

    if (
      assetId == null ||
      !eligibleAssets.containsKey(assetId) ||
      submittedAssetIds.contains(assetId)
    ) {
      throw staleTickets();
    }

    String email = normalizeEmail(input.email);

    if (
      String.isBlank(input.firstName) ||
      input.firstName.trim().length() > 40 ||
      String.isBlank(input.lastName) ||
      input.lastName.trim().length() > 80 ||
      !isValidEmail(email) ||
      email.length() > 80 ||
      String.isBlank(input.phone) ||
      input.phone.trim().length() > 40
    ) {
      throw invalidParticipant();
    }

    if (participantByEmail.containsKey(email)) {
      ParticipantInput previous = participantByEmail.get(email);
      Boolean sameFirstName = previous.firstName
        .trim()
        .equalsIgnoreCase(input.firstName.trim());
      Boolean sameLastName = previous.lastName
        .trim()
        .equalsIgnoreCase(input.lastName.trim());
      Boolean samePhone = previous.phone.trim() == input.phone.trim();

      if (!sameFirstName || !sameLastName || !samePhone) {
        throw new RequestException(
          'La stessa email contiene dati diversi in piu righe.'
        );
      }
    } else {
      participantByEmail.put(email, input);
    }

    submittedAssetIds.add(assetId);
  }

  private static Id parseAccountId(String rawId) {
    return parseId(rawId, Account.SObjectType);
  }

  private static Id parseCampaignId(String rawId) {
    return parseId(rawId, Campaign.SObjectType);
  }

  private static Id parseAssetId(String rawId) {
    return parseId(rawId, Asset.SObjectType);
  }

  private static Id parseId(String rawId, Schema.SObjectType expectedType) {
    if (String.isBlank(rawId)) {
      return null;
    }

    try {
      Id recordId = (Id) rawId;
      return recordId.getSObjectType() == expectedType ? recordId : null;
    } catch (Exception invalidId) {
      return null;
    }
  }

  private static String normalizeEmail(String email) {
    return email == null ? null : email.trim().toLowerCase();
  }

  private static Boolean isValidEmail(String email) {
    return (!String.isBlank(email) &&
    Pattern.matches('^[^\\s@]+@[^\\s@]+\\.[^\\s@]+$', email));
  }

  private static RequestException invalidLink() {
    return new RequestException('Questo collegamento non e valido.');
  }

  private static RequestException invalidParticipant() {
    return new RequestException(
      'Completa nome, cognome, email e telefono per ogni partecipante.'
    );
  }

  private static RequestException staleTickets() {
    return new RequestException(
      'La lista dei biglietti e cambiata. Ricarica la pagina prima di continuare.'
    );
  }

  private static AuraHandledException handled(String message) {
    return new AuraHandledException(message);
  }
}
