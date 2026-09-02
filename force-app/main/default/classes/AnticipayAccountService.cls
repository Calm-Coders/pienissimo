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
  public static Result refreshAccount(Id accountId) {
    Result result = new Result();
    result.accountId = accountId;

    if (accountId == null) {
      result.message = 'Account Id is required.';
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
      result.message = 'Account already consolidated by Anticipay.';
      return result;
    }

    if (String.isBlank(accountRecord.Partita_IVA__c)) {
      result.message = 'Account Partita IVA is required.';
      return result;
    }

    Map<String, String> pathParams = new Map<String, String>{
      'env' => IS_SANDBOX ? ENV_SANDBOX : ENV_PRODUCTION,
      'piva' => accountRecord.Partita_IVA__c
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
      return result;
    }

    update mapResponseToAccount(accountId, response.info);

    result.success = true;
    result.message = 'Anticipay Account data refreshed.';
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
      return 'Anticipay rejected the VAT number.';
    }
    if (httpStatus == 401) {
      return 'Anticipay authorization failed.';
    }
    if (httpStatus == 404) {
      return 'Anticipay did not find the company.';
    }
    if (httpStatus == 500) {
      return 'Anticipay middleware returned an internal error.';
    }
    return 'Anticipay Account refresh failed.';
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
