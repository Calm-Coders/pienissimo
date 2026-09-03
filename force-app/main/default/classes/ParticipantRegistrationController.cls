@RestResource(urlMapping='/participant-registration/*')
global without sharing class ParticipantRegistrationController {
  private static final String COMPLETED_STATE = 'COMPLETED';
  private static final String READY_STATE = 'READY';
  private static final String ASSIGNED_STATUS = 'Assegnato';

  private static final Set<String> VISIBLE_STATUSES = new Set<String>{
    'Disponibile',
    'Assegnato'
  };

  // =========================================================
  // RESPONSE / REQUEST CLASSES
  // =========================================================

  global class TicketRow {
    public Id assetId;
    public String ticketName;
    public String productName;
    public String campaignName;
    public Date eventStartDate;
    public Boolean editable;
    public Boolean assigned;
    public String firstName;
    public String lastName;
    public String email;
    public String phone;
  }

  global class PageResponse {
    public String state;
    public String message;

    public String accountId;
    public String accountName;

    public String campaignId;
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
    public String campaignId;
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
    public Campaign campaign;
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

  // =========================================================
  // GET
  // =========================================================

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
      System.debug(
        LoggingLevel.ERROR,
        'ParticipantRegistrationController GET RequestException: ' +
        requestError.getMessage()
      );

      writeError(requestError);
    } catch (Exception unexpectedError) {
      System.debug(
        LoggingLevel.ERROR,
        'ParticipantRegistrationController GET unexpected error: ' +
        unexpectedError.getMessage()
      );

      System.debug(LoggingLevel.ERROR, unexpectedError.getStackTraceString());

      writeUnexpectedError();
    }
  }

  // =========================================================
  // POST
  // =========================================================

  @HttpPost
  global static void doPost() {
    configureResponse();

    Savepoint savepoint = Database.setSavepoint();

    try {
      System.debug(LoggingLevel.INFO, 'Participant Registration POST started');

      SubmissionRequest request = parseSubmission();

      System.debug(LoggingLevel.INFO, 'POST accountId: ' + request.accountId);

      System.debug(LoggingLevel.INFO, 'POST campaignId: ' + request.campaignId);

      System.debug(
        LoggingLevel.INFO,
        'POST participant count: ' +
        (request.participants == null ? 0 : request.participants.size())
      );

      AccessContext access = resolveAccess(
        request.accountId,
        request.campaignId
      );

      PageResponse response = saveParticipants(access, request.participants);

      writeJson(200, response);
    } catch (RequestException requestError) {
      Database.rollback(savepoint);

      System.debug(
        LoggingLevel.ERROR,
        'POST RequestException: ' +
          requestError.responseCode +
          ' - ' +
          requestError.getMessage()
      );

      writeError(requestError);
    } catch (Exception unexpectedError) {
      Database.rollback(savepoint);

      System.debug(
        LoggingLevel.ERROR,
        'POST unexpected error: ' + unexpectedError.getMessage()
      );

      System.debug(LoggingLevel.ERROR, unexpectedError.getStackTraceString());

      writeUnexpectedError();
    }
  }

  // =========================================================
  // PAGE LOAD
  // =========================================================

  private static void handlePageLoad() {
    String accountId = RestContext.request.params.get('accountId');

    String campaignId = RestContext.request.params.get('campaignId');

    System.debug(LoggingLevel.INFO, 'Page load accountId: ' + accountId);

    System.debug(LoggingLevel.INFO, 'Page load campaignId: ' + campaignId);

    AccessContext access = resolveAccess(accountId, campaignId);

    writeJson(200, buildPage(access));
  }

  // =========================================================
  // CONTACT LOOKUP
  // =========================================================

  private static void handleContactLookup() {
    AccessContext access = resolveAccess(
      RestContext.request.params.get('accountId'),
      RestContext.request.params.get('campaignId')
    );

    String email = normalizeEmail(RestContext.request.params.get('email'));

    System.debug(LoggingLevel.INFO, 'Contact lookup email: ' + email);

    if (!isValidEmail(email)) {
      throw new RequestException(
        400,
        'INVALID_EMAIL',
        'Inserisci un indirizzo email valido.'
      );
    }

    List<Contact> contacts = [
      SELECT Id, FirstName, LastName, Phone, Email
      FROM Contact
      WHERE AccountId = :access.account.Id AND Email = :email
      ORDER BY CreatedDate ASC
      LIMIT 2
    ];

    System.debug(LoggingLevel.INFO, 'Contacts found: ' + contacts.size());

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

  // =========================================================
  // ACCESS VALIDATION
  // =========================================================

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

    if (accounts.isEmpty()) {
      throw invalidLink();
    }

    List<Campaign> campaigns = [
      SELECT Id, Name, StartDate, EndDate
      FROM Campaign
      WHERE Id = :campaignId
      LIMIT 1
    ];

    if (campaigns.isEmpty()) {
      throw invalidLink();
    }

    AccessContext result = new AccessContext();

    result.account = accounts[0];

    result.campaign = campaigns[0];

    return result;
  }

  // =========================================================
  // BUILD PAGE RESPONSE
  // =========================================================

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
      : 'La lista dei partecipanti è già stata inviata.';

    return response;
  }

  // =========================================================
  // SAVE PARTICIPANTS
  // =========================================================

  private static PageResponse saveParticipants(
    AccessContext access,
    List<ParticipantInput> inputs
  ) {
    System.debug(LoggingLevel.INFO, 'saveParticipants started');

    if (inputs == null || inputs.isEmpty()) {
      throw new RequestException(
        400,
        'EMPTY_LIST',
        'Completa tutti i biglietti prima di salvare.'
      );
    }

    /*
     * IMPORTANT:
     * lockRecords = TRUE here.
     *
     * queryVisibleAssets() therefore uses FOR UPDATE
     * WITHOUT ORDER BY.
     */
    List<Asset> visibleAssets = queryVisibleAssets(
      access.account.Id,
      access.campaign.Id,
      true
    );

    System.debug(
      LoggingLevel.INFO,
      'Visible locked Assets found: ' + visibleAssets.size()
    );

    Map<Id, Asset> eligibleAssets = new Map<Id, Asset>();

    for (Asset ticket : visibleAssets) {
      if (ticket.ContactId == null) {
        eligibleAssets.put(ticket.Id, ticket);
      }
    }

    System.debug(
      LoggingLevel.INFO,
      'Eligible Assets: ' + eligibleAssets.size()
    );

    System.debug(
      LoggingLevel.INFO,
      'Submitted participant count: ' + inputs.size()
    );

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

        /*
         * Put the unsaved Contact into
         * the map.
         *
         * After insert, Salesforce populates
         * participant.Id automatically.
         */
        contactByEmail.put(email, participant);
      }
    }

    System.debug(
      LoggingLevel.INFO,
      'Contacts to create: ' + contactsToCreate.size()
    );

    if (!contactsToCreate.isEmpty()) {
      insert contactsToCreate;

      System.debug(LoggingLevel.INFO, 'Contacts inserted successfully');
    }

    List<Asset> assetsToUpdate = new List<Asset>();

    for (ParticipantInput input : inputs) {
      Id assetId = parseAssetId(input.assetId);

      String normalizedEmail = normalizeEmail(input.email);

      Contact participant = contactByEmail.get(normalizedEmail);

      if (participant == null || participant.Id == null) {
        System.debug(
          LoggingLevel.ERROR,
          'No Contact found for email: ' + normalizedEmail
        );

        throw new RequestException(
          500,
          'CONTACT_NOT_FOUND',
          'Non è stato possibile associare il partecipante al biglietto.'
        );
      }

      System.debug(
        LoggingLevel.INFO,
        'Updating Asset ' + assetId + ' with Contact ' + participant.Id
      );

      assetsToUpdate.add(
        new Asset(
          Id = assetId,
          ContactId = participant.Id,
          Status = ASSIGNED_STATUS
        )
      );
    }

    if (!assetsToUpdate.isEmpty()) {
      update assetsToUpdate;

      System.debug(
        LoggingLevel.INFO,
        'Assets updated successfully: ' + assetsToUpdate.size()
      );
    }

    PageResponse response = buildPage(access);

    response.message = 'I dati dei partecipanti sono stati salvati.';

    System.debug(LoggingLevel.INFO, 'saveParticipants completed successfully');

    return response;
  }

  // =========================================================
  // FIND EXISTING CONTACTS
  // =========================================================

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
        409,
        'AMBIGUOUS_CONTACT',
        'Esistono più contatti con la stessa email. Contatta il tuo referente.'
      );
    }

    return result;
  }

  // =========================================================
  // QUERY ASSETS
  // =========================================================

  private static List<Asset> queryVisibleAssets(
    Id accountId,
    Id campaignId,
    Boolean lockRecords
  ) {
    String queryText =
      'SELECT ' +
      'Id, ' +
      'Name, ' +
      'Status, ' +
      'ContactId, ' +
      'Campaign__c, ' +
      'Campaign__r.Name, ' +
      'Campaign__r.StartDate, ' +
      'Campaign__r.EndDate, ' +
      'Contact.FirstName, ' +
      'Contact.LastName, ' +
      'Contact.Email, ' +
      'Contact.Phone, ' +
      'Product2.Name ' +
      'FROM Asset ' +
      'WHERE AccountId = :accountId ' +
      'AND Campaign__c = :campaignId ' +
      'AND Status IN :VISIBLE_STATUSES ';

    /*
     * Salesforce does NOT allow our explicit
     * ORDER BY when using FOR UPDATE here.
     *
     * SAVE:
     *      FOR UPDATE
     *
     * PAGE LOAD:
     *      ORDER BY
     */
    if (lockRecords) {
      queryText += 'FOR UPDATE';
    } else {
      queryText +=
        'ORDER BY ' +
        'Campaign__r.StartDate, ' +
        'Campaign__r.Name, ' +
        'Product2.Name, ' +
        'Name';
    }

    System.debug(LoggingLevel.INFO, 'queryVisibleAssets query: ' + queryText);

    List<Asset> assets = Database.query(queryText);

    System.debug(
      LoggingLevel.INFO,
      'queryVisibleAssets rows: ' + assets.size()
    );

    return assets;
  }

  // =========================================================
  // PARTICIPANT VALIDATION
  // =========================================================

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

  // =========================================================
  // PARSE REQUEST
  // =========================================================

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
      String requestBody = RestContext.request.requestBody.toString();

      System.debug(
        LoggingLevel.INFO,
        'Participant registration request body: ' + requestBody
      );

      return (SubmissionRequest) JSON.deserializeStrict(
        requestBody,
        SubmissionRequest.class
      );
    } catch (RequestException requestError) {
      throw requestError;
    } catch (Exception invalidJson) {
      System.debug(
        LoggingLevel.ERROR,
        'Invalid request JSON: ' + invalidJson.getMessage()
      );

      throw new RequestException(
        400,
        'INVALID_REQUEST',
        'La richiesta non è valida.'
      );
    }
  }

  // =========================================================
  // ID PARSERS
  // =========================================================

  private static Id parseAccountId(String rawId) {
    if (String.isBlank(rawId)) {
      return null;
    }

    try {
      Id recordId = (Id) rawId;

      return (recordId.getSObjectType() == Account.SObjectType)
        ? recordId
        : null;
    } catch (Exception invalidId) {
      return null;
    }
  }

  private static Id parseCampaignId(String rawId) {
    if (String.isBlank(rawId)) {
      return null;
    }

    try {
      Id recordId = (Id) rawId;

      return (recordId.getSObjectType() == Campaign.SObjectType)
        ? recordId
        : null;
    } catch (Exception invalidId) {
      return null;
    }
  }

  private static Id parseAssetId(String rawId) {
    if (String.isBlank(rawId)) {
      return null;
    }

    try {
      Id recordId = (Id) rawId;

      return (recordId.getSObjectType() == Asset.SObjectType) ? recordId : null;
    } catch (Exception invalidId) {
      return null;
    }
  }

  // =========================================================
  // EMAIL
  // =========================================================

  private static String normalizeEmail(String email) {
    return email == null ? null : email.trim().toLowerCase();
  }

  private static Boolean isValidEmail(String email) {
    return (!String.isBlank(email) &&
    Pattern.matches('^[^\\s@]+@[^\\s@]+\\.[^\\s@]+$', email));
  }

  // =========================================================
  // ERRORS
  // =========================================================

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

  // =========================================================
  // HTTP RESPONSE
  // =========================================================

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
