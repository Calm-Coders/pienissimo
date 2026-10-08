@RestResource(urlMapping='/ticket-qr/*')
global with sharing class TicketQrLookupService {
  private static final String FLOW_NAME = 'TicketQrLookupService.lookup';

  @HttpGet
  global static TicketQrLookupResponse lookup() {
    return lookupByQrId(qrIdFromRequest(RestContext.request), false);
  }

  @HttpPost
  global static TicketQrLookupResponse lookupFromBody() {
    return lookupByQrId(qrIdFromBody(RestContext.request), true);
  }

  private static TicketQrLookupResponse lookupByQrId(
    String qrId,
    Boolean shouldCheckIn
  ) {
    Integration_Log__c logRec = new Integration_Log__c();
    initializeLog(logRec);
    RestResponse response = RestContext.response;
    if (response != null) {
      response.addHeader('Content-Type', 'application/json');
    }

    try {
      Id scannedId = parseId(qrId);
      if (
        scannedId == null ||
        scannedId.getSObjectType() != Asset.SObjectType
      ) {
        return writeAndReturn(
          logRec,
          errorResponse(
            400,
            'INVALID_QR_ID',
            'Fornisci un ID Asset valido presente nel codice QR.'
          )
        );
      }

      Asset ticket = findTicketAsset(scannedId);
      if (ticket == null) {
        return writeAndReturn(
          logRec,
          errorResponse(
            404,
            'TICKET_ASSET_NOT_FOUND',
            'Nessun biglietto trovato per il codice QR.'
          )
        );
      }

      if (
        shouldCheckIn &&
        ticket.Status != 'Assegnato' &&
        ticket.Status != 'Utilizzato'
      ) {
        TicketQrLookupResponse invalidStatus = errorResponse(
          409,
          'INVALID_ASSET_STATUS',
          'Il biglietto deve essere in stato Assegnato prima del check-in.'
        );
        invalidStatus.contact = new ContactDto(ticket.Contact);
        invalidStatus.campaign = new CampaignDto(ticket.Campaign__r);
        invalidStatus.asset = new AssetDto(ticket);
        return writeAndReturn(logRec, invalidStatus);
      }

      Boolean wasAlreadyCheckedIn = ticket.Status == 'Utilizzato';
      if (shouldCheckIn && !wasAlreadyCheckedIn) {
        ticket.Status = 'Utilizzato';
        ticket.Data_CheckIn__c = System.now();
        update ticket;
      }

      TicketQrLookupResponse result = new TicketQrLookupResponse();
      result.success = true;
      result.message = !shouldCheckIn
        ? null
        : wasAlreadyCheckedIn
            ? 'Il check-in del biglietto è già stato effettuato.'
            : 'Check-in del biglietto effettuato correttamente.';
      result.contact = new ContactDto(ticket.Contact);
      result.campaign = new CampaignDto(ticket.Campaign__r);
      result.asset = new AssetDto(ticket);
      setStatusCode(200);
      return writeAndReturn(logRec, result);
    } catch (Exception e) {
      TicketQrLookupResponse result = errorResponse(
        500,
        'UNEXPECTED_ERROR',
        'Si è verificato un errore imprevisto durante la lettura del codice QR.'
      );
      logRec.Exception_Message__c = e.getMessage();
      logRec.Exception_StackTrace__c = e.getStackTraceString();
      return writeAndReturn(logRec, result);
    } finally {
      Database.insert(logRec, false);
    }
  }

  private static String qrIdFromBody(RestRequest request) {
    if (request == null || request.requestBody == null) {
      return null;
    }

    try {
      TicketQrLookupRequest payload = (TicketQrLookupRequest) JSON.deserialize(
        request.requestBody.toString(),
        TicketQrLookupRequest.class
      );
      return payload == null || String.isBlank(payload.qrId)
        ? null
        : payload.qrId.trim();
    } catch (Exception invalidBody) {
      return null;
    }
  }

  private static Asset findTicketAsset(Id assetId) {
    List<Asset> assets = [
      SELECT
        Id,
        Name,
        Status,
        Data_CheckIn__c,
        Product2.Name,
        Contact.Name,
        Contact.Email,
        Contact.Phone,
        Contact.Account.Name,
        Campaign__r.Name,
        Campaign__r.Data_Evento__c,
        Campaign__r.Orario_Inizio__c,
        Campaign__r.Luogo__c,
        Campaign__r.StartDate,
        Campaign__r.EndDate
      FROM Asset
      WHERE Id = :assetId
      LIMIT 1
    ];
    return assets.isEmpty() ? null : assets[0];
  }

  private static String qrIdFromRequest(RestRequest request) {
    if (request == null) {
      return null;
    }

    String queryValue = request.params == null
      ? null
      : request.params.get('qrId');
    if (!String.isBlank(queryValue)) {
      return queryValue.trim();
    }

    String uri = request.requestURI;
    if (String.isBlank(uri)) {
      return null;
    }

    List<String> uriParts = uri.split('/');
    return uriParts.isEmpty()
      ? null
      : EncodingUtil.urlDecode(uriParts[uriParts.size() - 1], 'UTF-8').trim();
  }

  private static Id parseId(String rawId) {
    if (String.isBlank(rawId)) {
      return null;
    }

    try {
      return (Id) rawId.trim();
    } catch (Exception invalidId) {
      return null;
    }
  }

  private static TicketQrLookupResponse errorResponse(
    Integer statusCode,
    String errorCode,
    String message
  ) {
    setStatusCode(statusCode);
    TicketQrLookupResponse result = new TicketQrLookupResponse();
    result.success = false;
    result.errorCode = errorCode;
    result.message = message;
    return result;
  }

  private static TicketQrLookupResponse writeAndReturn(
    Integration_Log__c logRec,
    TicketQrLookupResponse result
  ) {
    Integer statusCode = RestContext.response == null
      ? null
      : RestContext.response.statusCode;
    Boolean isError = result == null || result.success != true;

    logRec.Is_Error__c = isError;
    logRec.Response_State__c = statusCode == null
      ? null
      : String.valueOf(statusCode);
    logRec.Response_Body__c = JSON.serialize(result).abbreviate(131072);
    if (isError && String.isBlank(logRec.Exception_Message__c)) {
      logRec.Exception_Message__c = result == null ? null : result.message;
    }

    return result;
  }

  private static void initializeLog(Integration_Log__c logRec) {
    RestRequest request = RestContext.request;
    logRec.Flow_Name__c = FLOW_NAME;
    logRec.Inbound_Outbound__c = 'Inbound';
    logRec.Is_Error__c = false;
    logRec.Request_Endpoint__c = request == null ? null : request.resourcePath;
    logRec.Request_Headers__c = requestHeaders(request);
    logRec.Request_Body__c = request == null ||
      request.requestBody == null
      ? null
      : request.requestBody.toString().abbreviate(131072);
  }

  private static String requestHeaders(RestRequest request) {
    if (
      request == null ||
      request.headers == null ||
      request.headers.isEmpty()
    ) {
      return null;
    }

    Map<String, String> safeHeaders = new Map<String, String>();
    for (String headerName : request.headers.keySet()) {
      if (headerName != null && headerName.equalsIgnoreCase('Authorization')) {
        safeHeaders.put(headerName, '[REDACTED]');
      } else {
        safeHeaders.put(headerName, request.headers.get(headerName));
      }
    }
    return JSON.serialize(safeHeaders).abbreviate(131072);
  }

  private static void setStatusCode(Integer statusCode) {
    if (RestContext.response != null) {
      RestContext.response.statusCode = statusCode;
    }
  }

  global class TicketQrLookupResponse {
    public Boolean success;
    public String errorCode;
    public String message;
    public ContactDto contact;
    public CampaignDto campaign;
    public AssetDto asset;
  }

  global class TicketQrLookupRequest {
    public String qrId;
  }

  global class ContactDto {
    public String name;
    public String email;
    public String phone;
    public String accountName;

    public ContactDto(Contact contact) {
      if (contact == null) {
        return;
      }

      name = contact.Name;
      email = contact.Email;
      phone = contact.Phone;
      accountName = contact.Account == null ? null : contact.Account.Name;
    }
  }

  global class CampaignDto {
    public String name;
    public Date eventDate;
    public Time startTime;
    public String place;
    public Date startDate;
    public Date endDate;

    public CampaignDto(Campaign campaign) {
      if (campaign == null) {
        return;
      }

      name = campaign.Name;
      eventDate = campaign.Data_Evento__c;
      startTime = campaign.Orario_Inizio__c;
      place = campaign.Luogo__c;
      startDate = campaign.StartDate;
      endDate = campaign.EndDate;
    }
  }

  global class AssetDto {
    public String name;
    public String status;
    public String productName;
    public Datetime checkInDate;

    public AssetDto(Asset assetRecord) {
      name = assetRecord.Name;
      status = assetRecord.Status;
      checkInDate = assetRecord.Data_CheckIn__c;
      productName = assetRecord.Product2 == null
        ? null
        : assetRecord.Product2.Name;
    }
  }
}
