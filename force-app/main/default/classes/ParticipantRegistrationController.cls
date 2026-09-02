@RestResource(urlMapping='/participant-registration/*')
global without sharing class ParticipantRegistrationController {
  private static final String AVAILABLE_STATUS = 'Disponibile';
  private static final Set<String> VISIBLE_STATUSES = new Set<String>{
    'Disponibile',
    'Assegnato'
  };

  global class TicketRow {
    public Id assetId;
    public String ticketName;
    public String productName;
    public String campaignName;
    public Date eventStartDate;
    public Boolean editable;
    public String firstName;
    public String lastName;
    public String email;
    public String phone;
  }

  global class PageResponse {
    public String state;
    public String message;
    public String accountName;
    public String campaignName;
    public Date eventStartDate;
    public Date eventEndDate;
    public List<TicketRow> tickets = new List<TicketRow>();
  }

  global class ContactResponse {
    public Boolean found = false;
    public String firstName;
    public String lastName;
    public String phone;
  }

  global class SubmissionRequest {
    public String accountId;
    public List<ParticipantInput> participants;
  }

  global class ParticipantInput {
    public String assetId;
    public String firstName;
    public String lastName;
    public String email;
    public String phone;
  }

  private class AccessContext {
    public Account account;
  }

  private class ErrorResponse {
    public String state;
    public String message;

    private ErrorResponse(String state, String message) {
      this.state = state;
      this.message = message;
    }
  }

  private class RequestException extends Exception {
    public Integer httpStatus;
    public String responseCode;

    private RequestException(
      Integer httpStatus,
      String responseCode,
      String message
    ) {
      this.httpStatus = httpStatus;
      this.responseCode = responseCode;
      this.setMessage(message);
    }
  }

  @HttpGet
  global static void doGet() {
    configureResponse();
    try {
      if (RestContext.request.requestURI.endsWith('/contact')) {
        handleContactLookup();
      } else {
        handlePageLoad();
      }
    } catch (RequestException requestError) {
      writeError(requestError);
    } catch (Exception unexpectedError) {
      writeUnexpectedError();
    }
  }

  @HttpPost
  global static void doPost() {
    configureResponse();
    Savepoint savepoint = Database.setSavepoint();
    try {
      SubmissionRequest request = parseSubmission();
      AccessContext access = resolveAccess(request.accountId);
      writeJson(200, saveParticipants(access, request.participants));
    } catch (RequestException requestError) {
      Database.rollback(savepoint);
      writeError(requestError);
    } catch (Exception unexpectedError) {
      Database.rollback(savepoint);
      writeUnexpectedError();
    }
  }

  private static void handlePageLoad() {
    AccessContext access = resolveAccess(
      RestContext.request.params.get('accountId')
    );
    writeJson(200, buildPage(access));
  }

  private static void handleContactLookup() {
    AccessContext access = resolveAccess(
      RestContext.request.params.get('accountId')
    );
    String email = normalizeEmail(RestContext.request.params.get('email'));
    if (!isValidEmail(email)) {
      throw new RequestException(
        400,
        'INVALID_EMAIL',
        'Inserisci un indirizzo email valido.'
      );
    }

    List<Contact> contacts = [
      SELECT FirstName, LastName, Phone
      FROM Contact
      WHERE AccountId = :access.account.Id AND Email = :email
      ORDER BY CreatedDate ASC
      LIMIT 2
    ];
    if (contacts.size() > 1) {
      throw new RequestException(
        409,
        'AMBIGUOUS_CONTACT',
        'Esistono più contatti con questa email. Contatta il tuo referente.'
      );
    }

    ContactResponse response = new ContactResponse();
    if (!contacts.isEmpty()) {
      response.found = true;
      response.firstName = contacts[0].FirstName;
      response.lastName = contacts[0].LastName;
      response.phone = contacts[0].Phone;
    }
    writeJson(200, response);
  }

  private static AccessContext resolveAccess(String rawAccountId) {
    Id accountId = parseAccountId(rawAccountId);
    if (accountId == null) {
      throw invalidLink();
    }
    List<Account> accounts = [
      SELECT Id, Name
      FROM Account
      WHERE Id = :accountId
      LIMIT 1
    ];
    if (accounts.isEmpty()) {
      throw invalidLink();
    }
    AccessContext result = new AccessContext();
    result.account = accounts[0];
    return result;
  }

  private static PageResponse buildPage(AccessContext access) {
    PageResponse response = new PageResponse();
    response.accountName = access.account.Name;
    List<Asset> tickets = queryVisibleAssets(access.account.Id, false);
    Set<Id> campaignIds = new Set<Id>();
    Integer editableCount = 0;

    for (Asset ticket : tickets) {
      TicketRow row = new TicketRow();
      row.assetId = ticket.Id;
      row.ticketName = ticket.Name;
      row.productName = ticket.Product2 == null ? null : ticket.Product2.Name;
      row.campaignName = ticket.Campaign__r.Name;
      row.eventStartDate = ticket.Campaign__r.StartDate;
      row.editable =
        ticket.Status == AVAILABLE_STATUS &&
        ticket.ContactId == null;
      if (row.editable) {
        editableCount++;
      }
      campaignIds.add(ticket.Campaign__c);
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
    if (campaignIds.size() == 1) {
      response.campaignName = tickets[0].Campaign__r.Name;
      response.eventStartDate = tickets[0].Campaign__r.StartDate;
      response.eventEndDate = tickets[0].Campaign__r.EndDate;
    } else {
      response.campaignName = 'Più eventi';
    }
    response.state = editableCount > 0 ? 'READY' : 'COMPLETED';
    response.message = editableCount > 0
      ? null
      : 'La lista dei partecipanti è già stata inviata.';
    return response;
  }

  private static PageResponse saveParticipants(
    AccessContext access,
    List<ParticipantInput> inputs
  ) {
    if (inputs == null || inputs.isEmpty()) {
      throw new RequestException(
        400,
        'EMPTY_LIST',
        'La lista dei partecipanti è vuota.'
      );
    }

    List<Asset> visibleAssets = queryVisibleAssets(access.account.Id, true);
    Map<Id, Asset> eligibleAssets = new Map<Id, Asset>();
    for (Asset ticket : visibleAssets) {
      if (ticket.Status == AVAILABLE_STATUS && ticket.ContactId == null) {
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
    for (ParticipantInput input : inputs) {
      Id assetId = (Id) input.assetId;
      Contact participant = contactByEmail.get(normalizeEmail(input.email));
      assetsToUpdate.add(new Asset(Id = assetId, ContactId = participant.Id));
    }
    update assetsToUpdate;

    PageResponse response = buildPage(access);
    response.state = 'COMPLETED';
    response.message = 'I dati dei partecipanti sono stati salvati.';
    return response;
  }

  private static Map<String, Contact> findExistingContacts(
    Id accountId,
    Set<String> emails
  ) {
    Map<String, Contact> result = new Map<String, Contact>();
    Set<String> duplicateEmails = new Set<String>();
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
        409,
        'AMBIGUOUS_CONTACT',
        'Esistono più contatti con la stessa email. Contatta il tuo referente.'
      );
    }
    return result;
  }

  private static List<Asset> queryVisibleAssets(
    Id accountId,
    Boolean lockRecords
  ) {
    String queryText =
      'SELECT Id, Name, Status, ContactId, Campaign__c, ' +
      'Campaign__r.Name, Campaign__r.StartDate, Campaign__r.EndDate, ' +
      'Contact.FirstName, Contact.LastName, Contact.Email, Contact.Phone, ' +
      'Product2.Name FROM Asset WHERE AccountId = :accountId ' +
      'AND Campaign__c != null AND Status IN :VISIBLE_STATUSES ' +
      'ORDER BY Campaign__r.StartDate, Campaign__r.Name, Product2.Name, Name';
    if (lockRecords) {
      queryText += ' FOR UPDATE';
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
      if (
        !previous.firstName.trim().equalsIgnoreCase(input.firstName.trim()) ||
        !previous.lastName.trim().equalsIgnoreCase(input.lastName.trim()) ||
        previous.phone.trim() != input.phone.trim()
      ) {
        throw new RequestException(
          400,
          'CONFLICTING_DUPLICATE_EMAIL',
          'La stessa email contiene dati diversi in più righe.'
        );
      }
    } else {
      participantByEmail.put(email, input);
    }
    submittedAssetIds.add(assetId);
  }

  private static SubmissionRequest parseSubmission() {
    if (
      RestContext.request.requestBody == null ||
      RestContext.request.requestBody.size() == 0
    ) {
      throw new RequestException(
        400,
        'INVALID_REQUEST',
        'La richiesta è vuota.'
      );
    }
    try {
      return (SubmissionRequest) JSON.deserializeStrict(
        RestContext.request.requestBody.toString(),
        SubmissionRequest.class
      );
    } catch (Exception invalidJson) {
      throw new RequestException(
        400,
        'INVALID_REQUEST',
        'La richiesta non è valida.'
      );
    }
  }

  private static Id parseAccountId(String rawId) {
    try {
      Id recordId = (Id) rawId;
      return recordId.getSObjectType() == Account.SObjectType ? recordId : null;
    } catch (Exception invalidId) {
      return null;
    }
  }

  private static Id parseAssetId(String rawId) {
    try {
      Id recordId = (Id) rawId;
      return recordId.getSObjectType() == Asset.SObjectType ? recordId : null;
    } catch (Exception invalidId) {
      return null;
    }
  }

  private static String normalizeEmail(String email) {
    return email == null ? null : email.trim().toLowerCase();
  }

  private static Boolean isValidEmail(String email) {
    return !String.isBlank(email) &&
      Pattern.matches('^[^\\s@]+@[^\\s@]+\\.[^\\s@]+$', email);
  }

  private static RequestException invalidLink() {
    return new RequestException(
      404,
      'INVALID',
      'Questo collegamento non è valido.'
    );
  }

  private static RequestException invalidParticipant() {
    return new RequestException(
      400,
      'INVALID_PARTICIPANT',
      'Completa nome, cognome, email e telefono per ogni partecipante.'
    );
  }

  private static RequestException staleTickets() {
    return new RequestException(
      409,
      'TICKET_LIST_CHANGED',
      'La lista dei biglietti è cambiata. Ricarica la pagina prima di continuare.'
    );
  }

  private static void configureResponse() {
    RestContext.response.addHeader('Cache-Control', 'no-store, private');
    RestContext.response.addHeader('Pragma', 'no-cache');
    RestContext.response.addHeader('X-Content-Type-Options', 'nosniff');
  }

  private static void writeError(RequestException error) {
    writeJson(
      error.httpStatus,
      new ErrorResponse(error.responseCode, error.getMessage())
    );
  }

  private static void writeUnexpectedError() {
    writeJson(
      500,
      new ErrorResponse(
        'SERVER_ERROR',
        'Non è stato possibile completare la richiesta. Riprova più tardi.'
      )
    );
  }

  private static void writeJson(Integer statusCode, Object body) {
    RestContext.response.statusCode = statusCode;
    RestContext.response.addHeader('Content-Type', 'application/json');
    RestContext.response.responseBody = Blob.valueOf(JSON.serialize(body));
  }
}
