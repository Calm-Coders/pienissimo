public with sharing class MexalCustomerCreateService {
  private static final String AUTO_CUSTOMER_CODE = '501.AUTO';

  public class Result {
    @AuraEnabled
    public Boolean success;
    @AuraEnabled
    public Integer statusCode;
    @AuraEnabled
    public String body;
    @AuraEnabled
    public List<String> responseHeaders;
    @AuraEnabled
    public Id integrationLogId;
    @AuraEnabled
    public Id accountId;
    @AuraEnabled
    public String generatedCustomerCode;
    @AuraEnabled
    public Boolean duplicatePartitaIva;
    @AuraEnabled
    public String duplicateCustomerCode;
    @AuraEnabled
    public Boolean accountUpdated;
    @AuraEnabled
    public Map<String, Object> requestPayload;
    @AuraEnabled
    public String message;

    public Result() {
      success = false;
      responseHeaders = new List<String>();
      duplicatePartitaIva = false;
      accountUpdated = false;
      requestPayload = new Map<String, Object>();
    }
  }

  public class MexalCustomerCreateException extends Exception {
  }

  @AuraEnabled
  public static Result createForAccount(Id accountId) {
    if (accountId == null) {
      throw new MexalCustomerCreateException('Account obbligatorio.');
    }

    Account account = loadAccount(accountId);
    if (!String.isBlank(account.Codice_Cliente_Mexal__c)) {
      /*
       * Future Modifica Cliente path:
       *
       * Map<String, Object> payload = buildUpdatePayload(account);
       * MexalSearchCalloutService.Result calloutResult = MexalSearchCalloutService.updateCustomer(
       *   account.Codice_Cliente_Mexal__c,
       *   payload
       * );
       *
       * Result result = buildResult(account.Id, payload, calloutResult);
       * result.generatedCustomerCode = account.Codice_Cliente_Mexal__c;
       * result.message = result.success
       *   ? 'Modifica cliente Mexal completata.'
       *   : 'Modifica cliente Mexal fallita.';
       * return result;
       */
      throw new MexalCustomerCreateException(
        'Account gia collegato a Mexal: ' + account.Codice_Cliente_Mexal__c
      );
    }

    Map<String, Object> payload = buildCreatePayload(account);
    MexalSearchCalloutService.Result calloutResult = MexalSearchCalloutService.createCustomer(
      payload
    );

    Result result = buildResult(account.Id, payload, calloutResult);
    updateAccountWithGeneratedCode(account, result);
    return result;
  }

  private static Account loadAccount(Id accountId) {
    return [
      SELECT
        Id,
        Name,
        Codice_Cliente_Mexal__c,
        Partita_IVA__c,
        Codice_Fiscale__c,
        BillingStreet,
        BillingPostalCode,
        BillingCity,
        BillingState,
        BillingCountry,
        Phone,
        Fax,
        Email__c,
        PEC__c,
        Codice_Destinatario_SDI__c,
        Azienda_Precedente__r.Codice_Cliente_Mexal__c
      FROM Account
      WHERE Id = :accountId
      LIMIT 1
    ];
  }

  private static Map<String, Object> buildCreatePayload(Account account) {
    Map<String, Object> payload = new Map<String, Object>();
    putValue(payload, 'codice', AUTO_CUSTOMER_CODE);
    putValue(
      payload,
      'cod_alternativo',
      account.Azienda_Precedente__r == null
        ? null
        : account.Azienda_Precedente__r.Codice_Cliente_Mexal__c
    );
    putValue(payload, 'cod_paese', account.BillingCountry);
    putValue(payload, 'codice_fiscale', account.Codice_Fiscale__c);
    putValue(payload, 'partita_iva', account.Partita_IVA__c);
    putValue(payload, 'ragione_sociale', account.Name);
    putValue(payload, 'indirizzo', account.BillingStreet);
    putValue(payload, 'cap', account.BillingPostalCode);
    putValue(payload, 'localita', account.BillingCity);
    putValue(payload, 'provincia', account.BillingState);
    putValue(payload, 'telefono', account.Phone);
    putValue(payload, 'fax', account.Fax);
    putValue(payload, 'email', account.Email__c);
    putValue(payload, 'pec', account.PEC__c);
    putValue(payload, 'codice_sdi', account.Codice_Destinatario_SDI__c);
    putValue(payload, 'cod_agente', null);
    putValue(payload, 'tp_nazionalita', deriveFiscalResidenceCode(account));

    // Settled by the customer-registry review: Pienissimo uses listino 1 and Euro only.
    payload.put('cod_listino', 1);
    payload.put('valuta', 1);
    putValue(payload, 'gest_fatt_el', deriveElectronicInvoiceType(account));
    return payload;
  }

  private static Map<String, Object> buildUpdatePayload(Account account) {
    Map<String, Object> payload = buildCreatePayload(account);
    payload.remove('codice');
    return payload;
  }

  private static String deriveFiscalResidenceCode(Account account) {
    String country = normalizeCountry(account.BillingCountry);
    if (country == 'IT' || country == 'ITALIA' || country == 'ITALY') {
      return 'I';
    }
    return null;
  }

  private static String deriveElectronicInvoiceType(Account account) {
    return deriveFiscalResidenceCode(account) == 'I' ? 'S' : null;
  }

  private static String normalizeCountry(String value) {
    return String.isBlank(value) ? null : value.trim().toUpperCase();
  }

  private static void putValue(
    Map<String, Object> payload,
    String fieldName,
    String value
  ) {
    payload.put(fieldName, String.isBlank(value) ? '' : value.trim());
  }

  private static Result buildResult(
    Id accountId,
    Map<String, Object> payload,
    MexalSearchCalloutService.Result calloutResult
  ) {
    Result result = new Result();
    result.accountId = accountId;
    result.requestPayload = payload;

    if (calloutResult == null) {
      result.message = 'Nessuna risposta dal servizio Mexal.';
      return result;
    }

    result.success = calloutResult.success;
    result.statusCode = calloutResult.statusCode;
    result.body = calloutResult.body;
    result.responseHeaders = calloutResult.responseHeaders;
    result.integrationLogId = getLastLogId(calloutResult.integrationLogs);
    result.generatedCustomerCode = findGeneratedCustomerCode(calloutResult);
    result.duplicateCustomerCode = findDuplicatePartitaIvaCustomerCode(
      calloutResult.body
    );
    result.duplicatePartitaIva = !String.isBlank(result.duplicateCustomerCode);
    if (String.isBlank(result.generatedCustomerCode)) {
      result.generatedCustomerCode = result.duplicateCustomerCode;
    }
    result.message = result.success
      ? 'Creazione cliente Mexal completata.'
      : buildFailureMessage(result);
    return result;
  }

  private static void updateAccountWithGeneratedCode(
    Account account,
    Result result
  ) {
    if (String.isBlank(result.generatedCustomerCode)) {
      return;
    }

    update new Account(
      Id = account.Id,
      Codice_Cliente_Mexal__c = result.generatedCustomerCode
    );
    result.accountUpdated = true;
  }

  private static String buildFailureMessage(Result result) {
    if (result.duplicatePartitaIva) {
      return 'Cliente Mexal gia esistente per la stessa partita IVA: ' +
        result.duplicateCustomerCode;
    }
    return 'Creazione cliente Mexal fallita.';
  }

  private static String findGeneratedCustomerCode(
    MexalSearchCalloutService.Result calloutResult
  ) {
    String codeFromHeaders = findGeneratedCustomerCodeInHeaders(
      calloutResult.responseHeaders
    );
    if (!String.isBlank(codeFromHeaders)) {
      return codeFromHeaders;
    }
    return findGeneratedCustomerCodeInBody(calloutResult.body);
  }

  private static String findGeneratedCustomerCodeInHeaders(
    List<String> responseHeaders
  ) {
    if (responseHeaders == null) {
      return null;
    }

    for (String header : responseHeaders) {
      if (String.isBlank(header)) {
        continue;
      }

      List<String> parts = header.split('=', 2);
      if (parts.size() != 2) {
        continue;
      }

      String headerName = parts[0].toLowerCase();
      String headerValue = parts[1].trim();
      if (
        headerName.contains('codice') ||
        headerName.contains('cliente') ||
        headerName.contains('customer')
      ) {
        return headerValue;
      }
      if (headerName == 'location') {
        String locationCode = lastPathSegment(headerValue);
        if (!String.isBlank(locationCode)) {
          return locationCode;
        }
      }
    }

    return null;
  }

  private static String findDuplicatePartitaIvaCustomerCode(String body) {
    String detail = getErrorDetail(body);
    if (
      String.isBlank(detail) ||
      !detail.toLowerCase().contains('partita iva esiste gia')
    ) {
      return null;
    }

    Integer startIndex = detail.lastIndexOf('<');
    Integer endIndex = detail.lastIndexOf('>');
    if (startIndex < 0 || endIndex <= startIndex) {
      return null;
    }

    return detail.substring(startIndex + 1, endIndex).trim();
  }

  private static String getErrorDetail(String body) {
    if (String.isBlank(body)) {
      return null;
    }

    Object decoded = JSON.deserializeUntyped(body);
    if (!(decoded instanceof Map<String, Object>)) {
      return null;
    }

    Map<String, Object> response = (Map<String, Object>) decoded;
    Object errorValue = response.get('error');
    if (!(errorValue instanceof Map<String, Object>)) {
      return null;
    }

    Map<String, Object> error = (Map<String, Object>) errorValue;
    Object detail = error.get('response-detail');
    return detail == null ? null : String.valueOf(detail);
  }

  private static String findGeneratedCustomerCodeInBody(String body) {
    if (String.isBlank(body)) {
      return null;
    }

    Object decoded = JSON.deserializeUntyped(body);
    if (!(decoded instanceof Map<String, Object>)) {
      return null;
    }

    Map<String, Object> response = (Map<String, Object>) decoded;
    for (
      String key : new List<String>{
        'codice',
        'codice_cliente',
        'cod_cliente',
        'cliente'
      }
    ) {
      Object value = response.get(key);
      if (value != null && !String.isBlank(String.valueOf(value))) {
        return String.valueOf(value).trim();
      }
    }

    return null;
  }

  private static String lastPathSegment(String value) {
    if (String.isBlank(value)) {
      return null;
    }

    String trimmed = value.trim();
    Integer queryIndex = trimmed.indexOf('?');
    if (queryIndex >= 0) {
      trimmed = trimmed.substring(0, queryIndex);
    }

    List<String> parts = trimmed.split('/');
    return parts.isEmpty() ? null : parts[parts.size() - 1];
  }

  private static Id getLastLogId(List<Integration_Log__c> integrationLogs) {
    if (integrationLogs == null || integrationLogs.isEmpty()) {
      return null;
    }

    return integrationLogs[integrationLogs.size() - 1].Id;
  }
}
