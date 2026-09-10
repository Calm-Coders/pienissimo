public with sharing class MexalCustomerSearchService {
  private static final String ACTION_NAME = 'Mexal_Clienti_Ricerca';

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
    public List<Account> mappedAccounts;
    @AuraEnabled
    public String message;

    public Result() {
      success = false;
      bodyLength = 0;
      customersReturned = 0;
      mappedAccounts = new List<Account>();
    }
  }

  public class MexalCustomerSearchException extends Exception {
  }

  // Automatic daily search is intentionally paused while the Mexal sync
  // schedule and date window are finalized. Use searchModifiedSince(...) for
  // controlled testing, then re-enable this helper for the nightly job.
  // @AuraEnabled
  // public static Result searchModifiedToday() {
  //   return searchModifiedSince(startOfToday());
  // }
  //
  // Future nightly schedule, still inactive by design:
  // 1. Re-enable searchModifiedToday() above, or replace it with a persisted
  //    watermark once the final sync window is decided.
  // 2. Create a small Schedulable class that calls this service once per night.
  // 3. Schedule it with this cron expression for 02:00 every day:
  //    System.schedule(
  //      'Mexal Customer Search - Nightly',
  //      '0 0 2 * * ?',
  //      new MexalCustomerSearchScheduler()
  //    );
  //
  // public with sharing class MexalCustomerSearchScheduler implements Schedulable {
  //   public void execute(SchedulableContext context) {
  //     MexalCustomerSearchService.searchModifiedToday();
  //   }
  // }

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

  private static String formatMexalDateTime(Datetime value) {
    return value.format('yyyyMMdd HHmmss');
  }

  // private static Datetime startOfToday() {
  //   return Datetime.newInstance(Date.today(), Time.newInstance(0, 0, 0, 0));
  // }

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
  }

  private static Account mapCustomerToAccount(Map<String, Object> customer) {
    Account account = new Account();
    account.Codice_Cliente_Mexal__c = getString(customer, 'codice');
    account.Partita_IVA__c = getString(customer, 'partita_iva');
    account.Codice_Fiscale__c = getString(customer, 'codice_fiscale');
    account.Name = chooseFirstPopulated(
      getString(customer, 'ragione_sociale'),
      getString(customer, 'denominazione'),
      getString(customer, 'cognome')
    );
    account.BillingStreet = getString(customer, 'indirizzo');
    account.BillingPostalCode = getString(customer, 'cap');
    account.BillingCity = getString(customer, 'localita');
    account.BillingState = getString(customer, 'provincia');
    account.BillingCountry = getString(customer, 'cod_paese');
    account.Phone = getString(customer, 'telefono');
    account.Website = getString(customer, 'url');
    account.PEC__c = getString(customer, 'pec');
    account.IBAN__c = chooseFirstPopulated(
      getString(customer, 'banca_appoggio'),
      buildIban(customer)
    );
    account.Codice_Destinatario_SDI__c = getString(customer, 'codice_sdi');
    return account;
  }

  private static String buildIban(Map<String, Object> customer) {
    String country = getString(customer, 'pae_iban');
    String checkDigits = getString(customer, 'cin_iban');
    String ibanBody = getString(customer, 'iban_libero');

    if (
      String.isBlank(country) ||
      String.isBlank(checkDigits) ||
      String.isBlank(ibanBody)
    ) {
      return null;
    }

    return country + checkDigits.leftPad(2, '0') + ibanBody;
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

  private static Id getLastLogId(List<Integration_Log__c> integrationLogs) {
    if (integrationLogs == null || integrationLogs.isEmpty()) {
      return null;
    }

    return integrationLogs[integrationLogs.size() - 1].Id;
  }
}
