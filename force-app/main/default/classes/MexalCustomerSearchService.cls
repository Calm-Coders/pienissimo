public with sharing class MexalCustomerSearchService {
  public static final String ACTION_NAME = 'Mexal_Clienti_Ricerca';

  public class Result {
    @AuraEnabled
    public Boolean success;
    @AuraEnabled
    public Integer statusCode;
    @AuraEnabled
    public String body;
    @AuraEnabled
    public Integer bodyLength;
    @AuraEnabled
    public Id integrationLogId;
    @AuraEnabled
    public String requestDateTime;
    @AuraEnabled
    public String mexalProcessedDateTime;
    @AuraEnabled
    public Integer customersReturned;
    @AuraEnabled
    public Integer matchedByMexalCode;
    @AuraEnabled
    public Integer matchedByPartitaIva;
    @AuraEnabled
    public Integer unmatchedAccounts;
    @AuraEnabled
    public Integer ambiguousMatches;
    @AuraEnabled
    public Integer insertedAccounts;
    @AuraEnabled
    public Integer updatedAccounts;
    @AuraEnabled
    public Integer failedSaves;
    @AuraEnabled
    public List<String> saveErrors;
    @AuraEnabled
    public List<Account> mappedAccounts;
    @AuraEnabled
    public String message;

    public Result() {
      success = false;
      bodyLength = 0;
      customersReturned = 0;
      matchedByMexalCode = 0;
      matchedByPartitaIva = 0;
      unmatchedAccounts = 0;
      ambiguousMatches = 0;
      insertedAccounts = 0;
      updatedAccounts = 0;
      failedSaves = 0;
      saveErrors = new List<String>();
      mappedAccounts = new List<Account>();
    }
  }

  public class MexalCustomerSearchException extends Exception {
  }

  private class MatchResolution {
    Set<Integer> ambiguousIndexes = new Set<Integer>();
  }

  @AuraEnabled
  public static Result searchModifiedSince(Datetime modifiedSince) {
    if (modifiedSince == null) {
      throw new MexalCustomerSearchException(
        'La data di ultima modifica e obbligatoria.'
      );
    }

    String mexalDateTime = formatMexalDateTime(modifiedSince);
    MexalSearchCalloutService.Result httpResult = MexalSearchCalloutService.search(
      ACTION_NAME,
      buildModifiedSinceRequest(mexalDateTime)
    );

    return buildResult(httpResult, mexalDateTime);
  }

  @AuraEnabled
  public static Result searchByCustomerCode(String codiceClienteMexal) {
    if (String.isBlank(codiceClienteMexal)) {
      throw new MexalCustomerSearchException(
        'Il codice cliente Mexal e obbligatorio.'
      );
    }

    String normalizedCode = codiceClienteMexal.trim();
    MexalSearchCalloutService.Result httpResult = MexalSearchCalloutService.search(
      ACTION_NAME,
      buildCustomerCodeRequest(normalizedCode)
    );

    return buildResult(httpResult, normalizedCode);
  }

  private static Map<String, Object> buildModifiedSinceRequest(
    String mexalDateTime
  ) {
    return new Map<String, Object>{
      'filtri' => new List<Object>{
        new Map<String, Object>{
          'campo' => 'data_ult_mod',
          'condizione' => '>=',
          'valore' => mexalDateTime
        }
      }
    };
  }

  private static Map<String, Object> buildCustomerCodeRequest(
    String codiceClienteMexal
  ) {
    return new Map<String, Object>{
      'filtri' => new List<Object>{
        new Map<String, Object>{
          'campo' => 'codice',
          'condizione' => '=',
          'valore' => codiceClienteMexal
        }
      }
    };
  }

  private static String formatMexalDateTime(Datetime value) {
    return value.format('yyyyMMdd HHmmss');
  }

  private static Result buildResult(
    MexalSearchCalloutService.Result httpResult,
    String mexalDateTime
  ) {
    Result result = new Result();
    result.requestDateTime = mexalDateTime;

    if (httpResult == null) {
      result.message = 'Nessuna risposta dal servizio Mexal.';
      return result;
    }

    result.success = httpResult.success;
    result.statusCode = httpResult.statusCode;
    result.body = httpResult.body;
    result.bodyLength = String.isBlank(httpResult.body)
      ? 0
      : httpResult.body.length();
    mapResponseBody(result);
    result.integrationLogId = getLastLogId(httpResult.integrationLogs);
    result.message = result.success
      ? 'Ricerca clienti Mexal completata.'
      : 'Ricerca clienti Mexal fallita.';
    return result;
  }

  private static void mapResponseBody(Result result) {
    if (!result.success || String.isBlank(result.body)) {
      return;
    }

    Object response = JSON.deserializeUntyped(result.body);
    if (!(response instanceof Map<String, Object>)) {
      return;
    }

    Map<String, Object> responseMap = (Map<String, Object>) response;
    result.mexalProcessedDateTime = getString(responseMap, 'data_ric_elab');

    Object dati = responseMap.get('dati');
    if (!(dati instanceof List<Object>)) {
      return;
    }

    List<Object> customers = (List<Object>) dati;
    result.customersReturned = customers.size();

    for (Object customer : customers) {
      if (customer instanceof Map<String, Object>) {
        result.mappedAccounts.add(
          mapCustomerToAccount((Map<String, Object>) customer)
        );
      }
    }

    MatchResolution matchResolution = resolveAccountMatches(result);
    saveMatchedAccounts(result, matchResolution);
  }

  private static MatchResolution resolveAccountMatches(Result result) {
    MatchResolution matchResolution = new MatchResolution();

    if (result.mappedAccounts.isEmpty()) {
      return matchResolution;
    }

    Set<String> mexalCodes = new Set<String>();
    Set<String> partitaIvaValues = new Set<String>();

    for (Account account : result.mappedAccounts) {
      if (!String.isBlank(account.Codice_Cliente_Mexal__c)) {
        mexalCodes.add(normalizeMatchKey(account.Codice_Cliente_Mexal__c));
      }
      if (!String.isBlank(account.Partita_IVA__c)) {
        partitaIvaValues.add(normalizeMatchKey(account.Partita_IVA__c));
      }
    }

    if (mexalCodes.isEmpty() && partitaIvaValues.isEmpty()) {
      result.unmatchedAccounts = result.mappedAccounts.size();
      return matchResolution;
    }

    Map<String, List<Account>> accountsByMexalCode = new Map<String, List<Account>>();
    Map<String, List<Account>> accountsByPartitaIva = new Map<String, List<Account>>();

    for (Account existingAccount : [
      SELECT Id, Name, Codice_Cliente_Mexal__c, Partita_IVA__c
      FROM Account
      WHERE
        RecordType.DeveloperName = 'Azienda'
        AND (Codice_Cliente_Mexal__c IN :mexalCodes
        OR Partita_IVA__c IN :partitaIvaValues)
    ]) {
      addAccountByKey(
        accountsByMexalCode,
        existingAccount.Codice_Cliente_Mexal__c,
        existingAccount
      );
      addAccountByKey(
        accountsByPartitaIva,
        existingAccount.Partita_IVA__c,
        existingAccount
      );
    }

    for (Integer index = 0; index < result.mappedAccounts.size(); index++) {
      Account mappedAccount = result.mappedAccounts[index];
      if (
        tryAssignSingleMatch(
          mappedAccount,
          accountsByMexalCode,
          mappedAccount.Codice_Cliente_Mexal__c
        )
      ) {
        result.matchedByMexalCode++;
        continue;
      }

      if (
        hasAmbiguousMatch(
          accountsByMexalCode,
          mappedAccount.Codice_Cliente_Mexal__c
        )
      ) {
        result.ambiguousMatches++;
        matchResolution.ambiguousIndexes.add(index);
        continue;
      }

      if (
        tryAssignSingleMatch(
          mappedAccount,
          accountsByPartitaIva,
          mappedAccount.Partita_IVA__c
        )
      ) {
        result.matchedByPartitaIva++;
        continue;
      }

      if (
        hasAmbiguousMatch(accountsByPartitaIva, mappedAccount.Partita_IVA__c)
      ) {
        result.ambiguousMatches++;
        matchResolution.ambiguousIndexes.add(index);
      } else {
        result.unmatchedAccounts++;
      }
    }

    return matchResolution;
  }

  private static void saveMatchedAccounts(
    Result result,
    MatchResolution matchResolution
  ) {
    if (result.mappedAccounts.isEmpty()) {
      return;
    }

    List<Account> accountsToUpdate = new List<Account>();

    for (Integer index = 0; index < result.mappedAccounts.size(); index++) {
      if (matchResolution.ambiguousIndexes.contains(index)) {
        continue;
      }

      Account account = result.mappedAccounts[index];
      if (String.isBlank(account.Name)) {
        result.failedSaves++;
        result.saveErrors.add(
          buildSaveError(account, 'Account Name mancante.')
        );
        continue;
      }

      if (account.Id == null) {
        result.unmatchedAccounts++;
        result.saveErrors.add(
          buildSaveError(
            account,
            'Cliente Mexal non abbinato ad Account Salesforce esistente.'
          )
        );
      } else {
        accountsToUpdate.add(account);
      }
    }

    try {
      AccountTriggerHandler.setBypassMexalCustomerUpdate(true);
      applySaveResults(Database.update(accountsToUpdate, false), true, result);
    } finally {
      AccountTriggerHandler.setBypassMexalCustomerUpdate(false);
    }
  }

  private static void applySaveResults(
    List<Database.SaveResult> saveResults,
    Boolean isUpdate,
    Result result
  ) {
    for (Database.SaveResult saveResult : saveResults) {
      if (saveResult.isSuccess()) {
        if (isUpdate) {
          result.updatedAccounts++;
        } else {
          result.insertedAccounts++;
        }
        continue;
      }

      result.failedSaves++;
      result.saveErrors.add(buildSaveError(saveResult));
    }
  }

  private static String buildSaveError(Database.SaveResult saveResult) {
    List<String> messages = new List<String>();
    for (Database.Error error : saveResult.getErrors()) {
      messages.add(error.getStatusCode() + ': ' + error.getMessage());
    }
    return String.join(messages, ' | ');
  }

  private static String buildSaveError(Account account, String message) {
    return message +
      ' Codice Cliente Mexal=' +
      emptyIfBlank(account.Codice_Cliente_Mexal__c) +
      ', Partita IVA=' +
      emptyIfBlank(account.Partita_IVA__c);
  }

  private static void addAccountByKey(
    Map<String, List<Account>> accountsByKey,
    String rawKey,
    Account account
  ) {
    String key = normalizeMatchKey(rawKey);
    if (String.isBlank(key)) {
      return;
    }

    if (!accountsByKey.containsKey(key)) {
      accountsByKey.put(key, new List<Account>());
    }
    accountsByKey.get(key).add(account);
  }

  private static Boolean tryAssignSingleMatch(
    Account mappedAccount,
    Map<String, List<Account>> accountsByKey,
    String rawKey
  ) {
    List<Account> matches = accountsByKey.get(normalizeMatchKey(rawKey));
    if (matches == null || matches.size() != 1) {
      return false;
    }

    mappedAccount.Id = matches[0].Id;
    if (String.isBlank(mappedAccount.Name)) {
      mappedAccount.Name = matches[0].Name;
    }
    return true;
  }

  private static Boolean hasAmbiguousMatch(
    Map<String, List<Account>> accountsByKey,
    String rawKey
  ) {
    List<Account> matches = accountsByKey.get(normalizeMatchKey(rawKey));
    return matches != null && matches.size() > 1;
  }

  private static String normalizeMatchKey(String value) {
    return String.isBlank(value) ? null : value.trim().toUpperCase();
  }

  private static String emptyIfBlank(String value) {
    return String.isBlank(value) ? '' : value;
  }

  private static Account mapCustomerToAccount(Map<String, Object> customer) {
    Account account = new Account();
    account.Codice_Cliente_Mexal__c = getString(customer, 'codice');
    account.Partita_IVA__c = getString(customer, 'partita_iva');
    account.Codice_Fiscale__c = getString(customer, 'codice_fiscale');
    account.Name = chooseFirstPopulated(
      getString(customer, 'ragione_sociale'),
      getString(customer, 'codice')
    );
    account.BillingStreet = getString(customer, 'indirizzo');
    account.BillingPostalCode = getString(customer, 'cap');
    account.BillingCity = getString(customer, 'localita');
    account.BillingState = getString(customer, 'provincia');
    account.BillingCountry = getString(customer, 'cod_paese');
    account.Phone = getString(customer, 'telefono');
    account.Fax = getString(customer, 'fax');
    account.Email__c = normalizeEmail(getString(customer, 'email'));
    account.PEC__c = normalizeEmail(getString(customer, 'pec'));
    account.Codice_Destinatario_SDI__c = getString(customer, 'codice_sdi');
    return account;
  }

  private static String chooseFirstPopulated(
    String firstValue,
    String secondValue
  ) {
    return String.isBlank(firstValue) ? secondValue : firstValue;
  }

  private static String chooseFirstPopulated(
    String firstValue,
    String secondValue,
    String thirdValue
  ) {
    return chooseFirstPopulated(
      chooseFirstPopulated(firstValue, secondValue),
      thirdValue
    );
  }

  private static String getString(
    Map<String, Object> source,
    String fieldName
  ) {
    if (source == null || !source.containsKey(fieldName)) {
      return null;
    }

    Object value = source.get(fieldName);
    return value == null ? null : String.valueOf(value);
  }

  private static String normalizeEmail(String value) {
    return String.isBlank(value) ? null : value.trim().toLowerCase();
  }

  private static Id getLastLogId(List<Integration_Log__c> integrationLogs) {
    if (integrationLogs == null || integrationLogs.isEmpty()) {
      return null;
    }

    return integrationLogs[integrationLogs.size() - 1].Id;
  }
}
