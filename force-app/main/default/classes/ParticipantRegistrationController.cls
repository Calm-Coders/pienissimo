public without sharing class ParticipantRegistrationController {
  private static final String COMPLETED_STATE = 'COMPLETED';
  private static final String READY_STATE = 'READY';
  private static final String AVAILABLE_STATUS = 'Disponibile';
  private static final String ASSIGNED_STATUS = 'Assegnato';
  private static final String WAIVED_STATUS = 'Rinuncia';

  private static final Set<String> PARTICIPANT_EDITABLE_STATUSES = new Set<String>{
    AVAILABLE_STATUS
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
    public String status { get; set; }
    @AuraEnabled
    public Boolean editable { get; set; }
    @AuraEnabled
    public Boolean assigned { get; set; }
    @AuraEnabled
    public Boolean canRinuncia { get; set; }
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
    public String orderId { get; set; }
    @AuraEnabled
    public String orderNumber { get; set; }
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
    @AuraEnabled
    public List<ParticipationGroup> groups { get; set; }

    public PageResponse() {
      tickets = new List<TicketRow>();
      groups = new List<ParticipationGroup>();
    }
  }

  public class ParticipationGroup {
    @AuraEnabled
    public String groupId { get; set; }
    @AuraEnabled
    public String campaignName { get; set; }
    @AuraEnabled
    public Date eventStartDate { get; set; }
    @AuraEnabled
    public Boolean canRinuncia { get; set; }
    @AuraEnabled
    public List<TicketRow> tickets { get; set; }

    public ParticipationGroup() {
      tickets = new List<TicketRow>();
      canRinuncia = true;
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
    public Event_Invitation__c invitation;
    public Account account;
    public Order orderRecord;
  }

  private class RequestException extends Exception {
  }

  @AuraEnabled(cacheable=true)
  public static PageResponse loadPage(String token) {
    try {
      return buildPage(resolveAccess(token));
    } catch (RequestException requestError) {
      throw handled(requestError.getMessage());
    } catch (Exception unexpectedError) {
      throw handled(
        'Non e stato possibile completare la richiesta. Riprova piu tardi.'
      );
    }
  }

  @AuraEnabled(cacheable=true)
  public static ContactResponse findContact(String token, String email) {
    try {
      AccessContext access = resolveAccess(token);
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
    String token,
    List<ParticipantInput> participants
  ) {
    Savepoint savepoint = Database.setSavepoint();

    try {
      AccessContext access = resolveAccess(token);
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

  @AuraEnabled
  public static PageResponse markTicketRinuncia(String token, String assetId) {
    return markParticipationGroupRinuncia(token, assetId);
  }

  @AuraEnabled
  public static PageResponse markParticipationGroupRinuncia(
    String token,
    String groupAssetId
  ) {
    Savepoint savepoint = Database.setSavepoint();

    try {
      AccessContext access = resolveAccess(token);
      Id parsedAssetId = parseAssetId(groupAssetId);
      if (parsedAssetId == null) {
        throw staleTickets();
      }

      List<Asset> orderTickets = queryOrderAssets(access.orderRecord.Id, true);
      Asset selectedTicket;
      for (Asset ticket : orderTickets) {
        if (ticket.Id == parsedAssetId) {
          selectedTicket = ticket;
          break;
        }
      }
      if (selectedTicket == null) {
        throw staleTickets();
      }
      if (selectedTicket.Status != AVAILABLE_STATUS) {
        throw staleTickets();
      }

      List<Asset> ticketsToUpdate = new List<Asset>();
      for (Asset ticket : orderTickets) {
        if (ticket.Campaign__c != selectedTicket.Campaign__c) {
          continue;
        }
        if (ticket.Status == ASSIGNED_STATUS) {
          throw rinunciaBlockedByAssignedTicket();
        }
        if (ticket.Status != WAIVED_STATUS) {
          ticketsToUpdate.add(
            new Asset(Id = ticket.Id, Status = WAIVED_STATUS)
          );
        }
      }

      if (ticketsToUpdate.isEmpty()) {
        throw staleTickets();
      }

      update ticketsToUpdate;

      PageResponse response = buildPage(access);
      if (response.tickets.isEmpty()) {
        response.state = COMPLETED_STATE;
      }
      response.message = 'Rinuncia registrata.';
      return response;
    } catch (RequestException requestError) {
      Database.rollback(savepoint);
      throw handled(requestError.getMessage());
    } catch (Exception unexpectedError) {
      Database.rollback(savepoint);
      throw handled(
        'Non e stato possibile registrare la rinuncia. Riprova piu tardi.'
      );
    }
  }

  private static AccessContext resolveAccess(String rawToken) {
    String token = normalizeToken(rawToken);

    if (!isValidToken(token)) {
      throw invalidLink();
    }

    List<Event_Invitation__c> invitations = [
      SELECT
        Id,
        Status__c,
        Account__c,
        Account__r.Name,
        Order__c,
        Order__r.Id,
        Order__r.OrderNumber,
        Order__r.AccountId
      FROM Event_Invitation__c
      WHERE Token__c = :token
      LIMIT 2
    ];

    if (invitations.size() != 1) {
      throw invalidLink();
    }

    Event_Invitation__c invitation = invitations[0];
    if (
      invitation.Account__c == null ||
      invitation.Account__r == null ||
      invitation.Order__c == null ||
      invitation.Order__r == null ||
      invitation.Order__r.AccountId != invitation.Account__c ||
      invitation.Status__c == 'Cancelled'
    ) {
      throw invalidLink();
    }

    AccessContext result = new AccessContext();
    result.invitation = invitation;
    result.account = new Account(
      Id = invitation.Account__c,
      Name = invitation.Account__r.Name
    );
    result.orderRecord = invitation.Order__r;
    return result;
  }

  private static PageResponse buildPage(AccessContext access) {
    PageResponse response = new PageResponse();
    response.accountId = access.account.Id;
    response.accountName = access.account.Name;
    response.orderId = access.orderRecord.Id;
    response.orderNumber = access.orderRecord.OrderNumber;

    List<Asset> orderTickets = queryOrderAssets(access.orderRecord.Id, false);
    Map<Id, ParticipationGroup> groupsByCampaignId = new Map<Id, ParticipationGroup>();
    Set<Id> campaignsWithAssignedTickets = new Set<Id>();
    Boolean ungroupedTicketsIncludeAssigned = false;

    for (Asset ticket : orderTickets) {
      if (ticket.Status != ASSIGNED_STATUS) {
        continue;
      }
      if (ticket.Campaign__c == null) {
        ungroupedTicketsIncludeAssigned = true;
      } else {
        campaignsWithAssignedTickets.add(ticket.Campaign__c);
      }
    }

    Integer requiredParticipantCount = 0;

    for (Asset ticket : orderTickets) {
      if (
        ticket.Status != AVAILABLE_STATUS &&
        ticket.Status != ASSIGNED_STATUS &&
        ticket.Status != WAIVED_STATUS
      ) {
        continue;
      }

      TicketRow row = new TicketRow();
      row.assetId = ticket.Id;
      row.ticketName = ticket.Name;
      row.productName = ticket.Product2 == null ? null : ticket.Product2.Name;
      row.status = ticket.Status;
      row.campaignName = ticket.Campaign__r == null
        ? null
        : ticket.Campaign__r.Name;
      row.eventStartDate = ticket.Campaign__r == null
        ? null
        : displayEventDate(ticket.Campaign__r);
      row.assigned = ticket.Status == ASSIGNED_STATUS;
      row.editable =
        !row.assigned && PARTICIPANT_EDITABLE_STATUSES.contains(ticket.Status);
      row.canRinuncia = ticket.Campaign__c == null
        ? !ungroupedTicketsIncludeAssigned
        : !campaignsWithAssignedTickets.contains(ticket.Campaign__c);

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

      // Assigned and waived tickets remain visible in read-only summaries at
      // the bottom of the page, but are not part of the editable groups.
      if (row.assigned || ticket.Status == WAIVED_STATUS) {
        continue;
      }

      ParticipationGroup participationGroup = groupsByCampaignId.get(
        ticket.Campaign__c
      );
      if (participationGroup == null) {
        participationGroup = new ParticipationGroup();
        participationGroup.groupId = ticket.Id;
        participationGroup.campaignName = row.campaignName == null
          ? 'Partecipazione'
          : row.campaignName;
        participationGroup.eventStartDate = row.eventStartDate;
        groupsByCampaignId.put(ticket.Campaign__c, participationGroup);
        response.groups.add(participationGroup);
      }
      participationGroup.tickets.add(row);
      participationGroup.canRinuncia =
        participationGroup.canRinuncia && row.canRinuncia;
    }

    if (response.tickets.isEmpty()) {
      response.state = 'NO_TICKETS';
      response.message = 'Non ci sono biglietti disponibili per questo account.';
      return response;
    }

    response.state = requiredParticipantCount > 0
      ? READY_STATE
      : COMPLETED_STATE;
    Boolean onlyWaivedTickets =
      requiredParticipantCount == 0 &&
      !response.tickets.isEmpty() &&
      campaignsWithAssignedTickets.isEmpty() &&
      !ungroupedTicketsIncludeAssigned;
    response.message = requiredParticipantCount > 0
      ? null
      : onlyWaivedTickets
          ? 'La rinuncia e gia stata registrata.'
          : 'La lista dei partecipanti e gia stata inviata.';

    return response;
  }

  private static PageResponse saveParticipants(
    AccessContext access,
    List<ParticipantInput> inputs
  ) {
    if (inputs == null || inputs.isEmpty()) {
      throw new RequestException(
        'Inserisci almeno un partecipante prima di salvare.'
      );
    }

    List<Asset> visibleAssets = queryOrderAssets(access.orderRecord.Id, true);

    Map<Id, Asset> eligibleAssets = new Map<Id, Asset>();

    for (Asset ticket : visibleAssets) {
      if (
        ticket.ContactId == null &&
        PARTICIPANT_EDITABLE_STATUSES.contains(ticket.Status)
      ) {
        eligibleAssets.put(ticket.Id, ticket);
      }
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
    Map<Id, Set<Id>> contactIdsByCampaignId = new Map<Id, Set<Id>>();

    for (ParticipantInput input : inputs) {
      Id assetId = parseAssetId(input.assetId);
      Contact participant = contactByEmail.get(normalizeEmail(input.email));

      if (participant == null || participant.Id == null) {
        throw new RequestException(
          'Non e stato possibile associare il partecipante al biglietto.'
        );
      }

      Asset eligibleAsset = eligibleAssets.get(assetId);
      if (eligibleAsset.Campaign__c != null) {
        if (!contactIdsByCampaignId.containsKey(eligibleAsset.Campaign__c)) {
          contactIdsByCampaignId.put(eligibleAsset.Campaign__c, new Set<Id>());
        }
        contactIdsByCampaignId.get(eligibleAsset.Campaign__c)
          .add(participant.Id);
      }
      assetsToUpdate.add(
        new Asset(
          Id = assetId,
          ContactId = participant.Id,
          Status = ASSIGNED_STATUS,
          Ready_for_Ticket_Dispatch__c = true
        )
      );
    }

    if (!assetsToUpdate.isEmpty()) {
      update assetsToUpdate;
    }

    insertMissingCampaignMembers(contactIdsByCampaignId);

    return buildPage(access);
  }

  private static void insertMissingCampaignMembers(
    Map<Id, Set<Id>> contactIdsByCampaignId
  ) {
    if (contactIdsByCampaignId == null || contactIdsByCampaignId.isEmpty()) {
      return;
    }

    Set<Id> allContactIds = new Set<Id>();
    Set<Id> campaignIds = contactIdsByCampaignId.keySet();
    for (Set<Id> contactIds : contactIdsByCampaignId.values()) {
      allContactIds.addAll(contactIds);
    }
    Set<String> existingKeys = new Set<String>();

    for (CampaignMember member : [
      SELECT CampaignId, ContactId
      FROM CampaignMember
      WHERE CampaignId IN :campaignIds AND ContactId IN :allContactIds
    ]) {
      existingKeys.add(member.CampaignId + ':' + member.ContactId);
    }

    List<CampaignMember> membersToCreate = new List<CampaignMember>();

    for (Id campaignId : contactIdsByCampaignId.keySet()) {
      for (Id contactId : contactIdsByCampaignId.get(campaignId)) {
        if (!existingKeys.contains(campaignId + ':' + contactId)) {
          membersToCreate.add(
            new CampaignMember(CampaignId = campaignId, ContactId = contactId)
          );
        }
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

  private static List<Asset> queryOrderAssets(Id orderId, Boolean lockRecords) {
    String queryText =
      'SELECT Id, Name, Status, ContactId, Campaign__c, Campaign__r.Name, ' +
      'Campaign__r.Data_Evento__c, Campaign__r.StartDate, Campaign__r.EndDate, Contact.FirstName, ' +
      'Contact.LastName, Contact.Email, Contact.Phone, Product2.Name, Order_Product__c ' +
      'FROM Asset WHERE Order_Product__r.OrderId = :orderId ';

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
      !isValidPhone(input.phone) ||
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

  private static Date displayEventDate(Campaign campaign) {
    if (campaign == null) {
      return null;
    }
    return campaign.Data_Evento__c == null
      ? campaign.StartDate
      : campaign.Data_Evento__c;
  }

  private static String normalizeToken(String token) {
    return token == null ? null : token.trim().toLowerCase();
  }

  private static Boolean isValidEmail(String email) {
    return (!String.isBlank(email) &&
    Pattern.matches('^[^\\s@]+@[^\\s@]+\\.[^\\s@]+$', email));
  }

  private static Boolean isValidPhone(String phone) {
    return (!String.isBlank(phone) &&
    Pattern.matches('^[0-9]{6,15}$', phone.trim()));
  }

  private static Boolean isValidToken(String token) {
    return !String.isBlank(token) && Pattern.matches('^[0-9a-f]{64}$', token);
  }

  private static RequestException invalidLink() {
    return new RequestException('Questo collegamento non e valido.');
  }

  private static RequestException invalidParticipant() {
    return new RequestException(
      'Completa nome, cognome, email e telefono e verifica che i formati siano validi.'
    );
  }

  private static RequestException staleTickets() {
    return new RequestException(
      'La lista dei biglietti e cambiata. Ricarica la pagina prima di continuare.'
    );
  }

  private static RequestException rinunciaBlockedByAssignedTicket() {
    return new RequestException(
      'La rinuncia non e disponibile perche un biglietto del gruppo e gia assegnato.'
    );
  }

  private static AuraHandledException handled(String message) {
    return new AuraHandledException(message);
  }
}
