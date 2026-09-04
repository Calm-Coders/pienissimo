public with sharing class AnticipayAccountService {
  private static final String API_NAME = 'Anticipay_Account_Check';
  private static final String ENV_SANDBOX = 'test';
  private static final String ENV_PRODUCTION = 'prod';

  private static final Boolean IS_SANDBOX = [
    SELECT IsSandbox
    FROM Organization
    LIMIT 1
  ]
  .IsSandbox;

  public class Result {
    @AuraEnabled
    public Boolean success;
    @AuraEnabled
    public Integer httpStatus;
    @AuraEnabled
    public String message;
    @AuraEnabled
    public Id accountId;
    @AuraEnabled
    public Id sourceRecordId;
    @AuraEnabled
    public String sourceRecordObjectApiName;
    @AuraEnabled
    public List<Integration_Log__c> integrationLogs;

    public Result() {
      success = false;
      integrationLogs = new List<Integration_Log__c>();
    }
  }

  public class Response {
    @AuraEnabled
    public Boolean success;
    @AuraEnabled
    public Integer status;
    @AuraEnabled
    public String message;
    @AuraEnabled
    public String error;
    @AuraEnabled
    public Info info;
  }

  public class Info {
    @AuraEnabled
    public String ragione_sociale;
    @AuraEnabled
    public String indirizzo;
    @AuraEnabled
    public String citta;
    @AuraEnabled
    public String provincia;
    @AuraEnabled
    public String cap;
    @AuraEnabled
    public String pec;
    @AuraEnabled
    public String nome_legale_rappresentante;
    @AuraEnabled
    public String codice_fiscale_legale_rappresentante;
    @AuraEnabled
    public String data_di_dascita_legale_rappresentante;
    @AuraEnabled
    public String luogo_nascita_legale_rappresentante;
    @AuraEnabled
    public String indirizzo_legale_rappresentante;
  }

  @AuraEnabled
  public static Result refreshRecord(Id recordId) {
    Result result = new Result();

    if (recordId == null) {
      result.message = 'L\'ID record e obbligatorio.';
      return result;
    }

    result.sourceRecordId = recordId;
    result.sourceRecordObjectApiName = String.valueOf(
      recordId.getSObjectType()
    );

    if (recordId.getSObjectType() == Account.SObjectType) {
      return refreshAccount(recordId, recordId);
    }

    if (recordId.getSObjectType() == Order.SObjectType) {
      Order orderRecord = [
        SELECT Id, AccountId
        FROM Order
        WHERE Id = :recordId
        LIMIT 1
      ];

      if (orderRecord.AccountId == null) {
        result.httpStatus = 400;
        result.message = 'L\'ordine non ha un Account associato.';
        return result;
      }

      return refreshAccount(orderRecord.AccountId, recordId);
    }

    result.httpStatus = 400;
    result.message = 'Record non supportato per Anticipay.';
    return result;
  }

  @AuraEnabled
  public static Result refreshAccount(Id accountId) {
    return refreshAccount(accountId, accountId);
  }

  public static Result refreshAccount(Id accountId, Id sourceRecordId) {
    Result result = new Result();
    result.accountId = accountId;
    result.sourceRecordId = sourceRecordId;

    if (sourceRecordId != null) {
      result.sourceRecordObjectApiName = String.valueOf(
        sourceRecordId.getSObjectType()
      );
    }

    if (accountId == null) {
      result.message = 'L\'ID account e obbligatorio.';
      return result;
    }

    Account accountRecord = [
      SELECT Id, Anticipay_Consolidato__c, Partita_IVA__c
      FROM Account
      WHERE Id = :accountId
      LIMIT 1
    ];

    if (accountRecord.Anticipay_Consolidato__c) {
      result.success = true;
      result.message = 'Account gia consolidato da Anticipay.';
      return result;
    }

    if (String.isBlank(accountRecord.Partita_IVA__c)) {
      result.httpStatus = 400;
      result.message = 'La Partita IVA e obbligatoria.';
      return result;
    }

    String partitaIva = accountRecord.Partita_IVA__c.trim();

    Map<String, String> pathParams = new Map<String, String>{
      'env' => IS_SANDBOX ? ENV_SANDBOX : ENV_PRODUCTION,
      'piva' => partitaIva
    };

    API_Callout_Engine.Result engineResult = API_Callout_Engine.callApi(
      API_NAME,
      null,
      true,
      pathParams
    );

    result.integrationLogs = engineResult.integrationLogs;
    result.httpStatus = getLastHttpStatus(engineResult.integrationLogs);

    if (engineResult.payload == null) {
      result.message = buildFailureMessage(result.httpStatus);
      AnticipayErrorNotificationService.sendIfError(result);
      return result;
    }

    Response response = (Response) engineResult.payload;

    if (response.status != null) {
      result.httpStatus = response.status;
    }

    if (response.success != true || response.info == null) {
      result.message = firstNonBlank(
        response.message,
        response.error,
        buildFailureMessage(result.httpStatus)
      );
      AnticipayErrorNotificationService.sendIfError(result);
      return result;
    }

    update mapResponseToAccount(accountId, response.info);

    result.success = true;
    result.message = 'Dati Account aggiornati da Anticipay.';
    return result;
  }

  private static Account mapResponseToAccount(Id accountId, Info info) {
    Account accountRecord = new Account(Id = accountId);

    putString(accountRecord, Account.Name, info.ragione_sociale);
    putString(accountRecord, Account.BillingStreet, info.indirizzo);
    putString(accountRecord, Account.BillingCity, info.citta);
    putString(accountRecord, Account.BillingState, info.provincia);
    putString(accountRecord, Account.BillingPostalCode, info.cap);
    putString(accountRecord, Account.PEC__c, info.pec);
    putString(
      accountRecord,
      Account.Nome_Legale_Rappresentante__c,
      info.nome_legale_rappresentante
    );
    putString(
      accountRecord,
      Account.Codice_Fiscale_Legale_Rappresentante__c,
      info.codice_fiscale_legale_rappresentante
    );
    putString(
      accountRecord,
      Account.Luogo_Nascita_Legale_Rappresentante__c,
      info.luogo_nascita_legale_rappresentante
    );
    putString(
      accountRecord,
      Account.Indirizzo_Legale_Rappresentante__c,
      info.indirizzo_legale_rappresentante
    );

    Date birthDate = parseDate(info.data_di_dascita_legale_rappresentante);
    if (birthDate != null) {
      accountRecord.Data_Nascita_Legale_Rappresentante__c = birthDate;
    }

    accountRecord.Anticipay_Consolidato__c = true;

    return accountRecord;
  }

  private static void putString(
    Account accountRecord,
    Schema.SObjectField field,
    String value
  ) {
    if (!String.isBlank(value)) {
      accountRecord.put(field, value.trim());
    }
  }

  private static Date parseDate(String value) {
    if (String.isBlank(value)) {
      return null;
    }

    String cleanValue = value.trim();

    try {
      return Date.valueOf(cleanValue);
    } catch (Exception ignored) {
      // Try the Italian display format commonly used for dates.
    }

    try {
      List<String> dateParts = cleanValue.split('/');
      if (dateParts.size() == 3) {
        return Date.newInstance(
          Integer.valueOf(dateParts[2]),
          Integer.valueOf(dateParts[1]),
          Integer.valueOf(dateParts[0])
        );
      }
    } catch (Exception ignored) {
      return null;
    }

    return null;
  }

  private static Integer getLastHttpStatus(List<Integration_Log__c> logs) {
    if (logs == null || logs.isEmpty()) {
      return null;
    }

    String statusCode = logs[logs.size() - 1].Response_State__c;
    if (String.isBlank(statusCode)) {
      return null;
    }

    try {
      return Integer.valueOf(statusCode);
    } catch (Exception ignored) {
      return null;
    }
  }

  private static String buildFailureMessage(Integer httpStatus) {
    if (httpStatus == 400) {
      return 'Anticipay ha rifiutato la Partita IVA.';
    }
    if (httpStatus == 401) {
      return 'Autorizzazione Anticipay fallita.';
    }
    if (httpStatus == 404) {
      return 'Anticipay non ha trovato l\'azienda.';
    }
    if (httpStatus == 500) {
      return 'Il middleware Anticipay ha restituito un errore interno.';
    }
    return 'Aggiornamento Account da Anticipay fallito.';
  }

  private static String firstNonBlank(
    String firstValue,
    String secondValue,
    String fallback
  ) {
    if (!String.isBlank(firstValue)) {
      return firstValue;
    }
    if (!String.isBlank(secondValue)) {
      return secondValue;
    }
    return fallback;
  }
}
