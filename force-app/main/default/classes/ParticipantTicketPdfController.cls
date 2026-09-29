public without sharing class ParticipantTicketPdfController {
  public Asset ticket { get; private set; }
  private List<QrRow> qrRows;

  public ParticipantTicketPdfController() {
    Id assetId = parseAssetId(
      ApexPages.currentPage().getParameters().get('id')
    );
    if (assetId == null) {
      throw new ParticipantTicketPdfException('Biglietto non valido.');
    }

    List<Asset> tickets = [
      SELECT
        Id,
        Name,
        QR_Id__c,
        Account.Name,
        Contact.FirstName,
        Contact.LastName,
        Contact.Email,
        Contact.Phone,
        Campaign__r.Name,
        Campaign__r.Data_Evento__c,
        Campaign__r.Data_Inizio_Evento__c,
        Campaign__r.Data_Fine_Evento__c,
        Campaign__r.StartDate,
        Campaign__r.EndDate,
        Campaign__r.Luogo__c,
        Campaign__r.Indirizzo__c,
        Campaign__r.Orario_Inizio__c,
        Campaign__r.Parcheggio__c,
        Product2.Name,
        Product2.Tipo_Biglietto__c
      FROM Asset
      WHERE Id = :assetId
      LIMIT 1
    ];

    if (tickets.isEmpty()) {
      throw new ParticipantTicketPdfException('Biglietto non trovato.');
    }

    ticket = tickets[0];
  }

  public String getEventName() {
    return ticket.Campaign__r == null ? '' : ticket.Campaign__r.Name;
  }

  public String getEventDate() {
    if (ticket.Campaign__r == null) {
      return '';
    }

    Date value = ticket.Campaign__r.Data_Evento__c;
    if (value == null) {
      value = ticket.Campaign__r.Data_Inizio_Evento__c;
    }
    if (value == null) {
      value = ticket.Campaign__r.StartDate;
    }

    return formatDate(value);
  }

  public String getParticipantName() {
    if (ticket.Contact == null) {
      return '';
    }

    return joinNonBlank(
      new List<String>{ ticket.Contact.FirstName, ticket.Contact.LastName },
      ' '
    );
  }

  public String getParticipantEmail() {
    return ticket.Contact == null ? '' : ticket.Contact.Email;
  }

  public String getParticipantPhone() {
    return ticket.Contact == null ? '' : ticket.Contact.Phone;
  }

  public String getAccountName() {
    return ticket.Account == null ? '' : ticket.Account.Name;
  }

  public String getTicketName() {
    return ticket.Name;
  }

  public String getTicketType() {
    if (ticket.Product2 == null) {
      return '';
    }

    return String.isBlank(ticket.Product2.Tipo_Biglietto__c)
      ? ticket.Product2.Name
      : ticket.Product2.Tipo_Biglietto__c;
  }

  public String getLocationName() {
    return ticket.Campaign__r == null ? '' : ticket.Campaign__r.Luogo__c;
  }

  public String getAddress() {
    return ticket.Campaign__r == null ? '' : ticket.Campaign__r.Indirizzo__c;
  }

  public String getCheckInTime() {
    if (
      ticket.Campaign__r == null ||
      ticket.Campaign__r.Orario_Inizio__c == null
    ) {
      return '';
    }

    Time value = ticket.Campaign__r.Orario_Inizio__c;
    return String.valueOf(value.hour()).leftPad(2, '0') +
      ':' +
      String.valueOf(value.minute()).leftPad(2, '0');
  }

  public String getParking() {
    return ticket.Campaign__r == null ? '' : ticket.Campaign__r.Parcheggio__c;
  }

  public String getGeneratedDate() {
    return formatDate(Date.today());
  }

  public String getEventLocationLine() {
    return joinNonBlank(
      new List<String>{ getLocationName(), getAddress() },
      ' - '
    );
  }

  public List<QrRow> getQrRows() {
    if (qrRows == null) {
      qrRows = buildQrRows(ticket.QR_Id__c);
    }
    return qrRows;
  }

  public Boolean getHasQrCode() {
    return !getQrRows().isEmpty();
  }

  private static Id parseAssetId(String rawId) {
    if (String.isBlank(rawId)) {
      return null;
    }

    try {
      Id recordId = (Id) rawId;
      return recordId.getSObjectType() == Asset.SObjectType ? recordId : null;
    } catch (Exception e) {
      return null;
    }
  }

  private static String formatDate(Date value) {
    return value == null
      ? ''
      : String.valueOf(value.day()).leftPad(2, '0') +
        '/' +
        String.valueOf(value.month()).leftPad(2, '0') +
        '/' +
        value.year();
  }

  private static String joinNonBlank(List<String> values, String separator) {
    List<String> parts = new List<String>();
    for (String value : values) {
      if (String.isNotBlank(value)) {
        parts.add(value);
      }
    }
    return String.join(parts, separator);
  }

  private static List<QrRow> buildQrRows(String payload) {
    List<QrRow> rows = new List<QrRow>();
    if (String.isBlank(payload)) {
      return rows;
    }

    String pattern = BarcodeGenerator.getPattern(payload, 'qr');
    if (String.isBlank(pattern)) {
      return rows;
    }

    List<String> patternRows = pattern.split('\n');
    Integer quietModules = 4;
    Integer moduleCount = patternRows.size() + quietModules * 2;

    for (Integer rowIndex = 0; rowIndex < moduleCount; rowIndex++) {
      QrRow row = new QrRow();
      row.modules = new List<Boolean>();
      for (Integer columnIndex = 0; columnIndex < moduleCount; columnIndex++) {
        Integer patternRow = rowIndex - quietModules;
        Integer patternColumn = columnIndex - quietModules;
        Boolean dark =
          patternRow >= 0 &&
          patternRow < patternRows.size() &&
          patternColumn >= 0 &&
          patternColumn < patternRows.size() &&
          patternRows[patternRow].charAt(patternColumn) == 49;
        row.modules.add(dark);
      }
      rows.add(row);
    }

    return rows;
  }

  public class QrRow {
    public List<Boolean> modules { get; set; }
  }

  public class ParticipantTicketPdfException extends Exception {
  }
}
