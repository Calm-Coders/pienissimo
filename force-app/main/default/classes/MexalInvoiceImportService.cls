// Imports Mexal invoices (sigla FT) into Fattura__c and their payment rows into
// Scadenza_Fattura__c. The invoice header comes from movimenti-magazzino, the
// rows and their stato_pagamento from the scadenzario (causale FE); the two
// join on the invoice key sigla + serie + numero + anno documento.
// The nightly sync (MexalInvoiceSyncJob) runs the invoices first, then their
// lines (MexalInvoiceLineImportBatch), then the scadenzario.
public with sharing class MexalInvoiceImportService {
  public static final String MOVEMENT_SEARCH_ACTION = 'Mexal_Movimenti_Magazzino_Ricerca';
  public static final String SCADENZARIO_SEARCH_ACTION = 'Mexal_Scadenzario_Ricerca';
  private static final String INVOICE_SIGLA = 'FT';
  private static final String INVOICE_CAUSALE = 'FE';
  private static final String PAYMENT_STATUS_PAID = 'Paid';
  private static final String PAYMENT_STATUS_UNPAID = 'Unpaid';
  private static final Set<String> PAYMENT_STATUSES = new Set<String>{
    'P',
    'E'
  };

  public class Result {
    @AuraEnabled
    public Integer invoicesReturned = 0;
    @AuraEnabled
    public Integer scadenzarioDocumentsReturned = 0;
    @AuraEnabled
    public Integer invoicesSaved = 0;
    @AuraEnabled
    public Integer deadlinesSaved = 0;
    @AuraEnabled
    public Integer deadlinesWithoutInvoice = 0;
    @AuraEnabled
    public Integer invoicesWithoutAccount = 0;
    @AuraEnabled
    public Integer orderLinesUpdated = 0;
    @AuraEnabled
    public List<String> errors = new List<String>();
    // Invoices saved by this run, for the lines import.
    public Set<Id> invoiceIds = new Set<Id>();
  }

  public class MexalInvoiceImportException extends Exception {
  }

  private class InvoiceHeader {
    Integer serie;
    Integer numero;
    String customerCode;
    String documentDate;
    String lastModified;
  }

  private class Deadline {
    Integer rowIndex;
    Date dueDate;
    Decimal amount;
    String paymentStatus;
  }

  // Invoices whose Mexal movement changed since modifiedSince.
  public static Result importInvoicesModifiedSince(Datetime modifiedSince) {
    if (modifiedSince == null) {
      throw new MexalInvoiceImportException(
        'Data di ultima modifica obbligatoria.'
      );
    }
    List<Object> movementRows = search(
      MOVEMENT_SEARCH_ACTION,
      new List<Object>{
        filter('sigla', '=', INVOICE_SIGLA),
        filter('data_ult_mod', '>=', modifiedSince.format('yyyyMMdd HHmmss'))
      },
      true
    );
    Result result = new Result();
    saveInvoices(movementRows, result);
    return result;
  }

  // Scadenzario documents changed since modifiedSince: a payment recorded in
  // Mexal moves data_ult_mod, so this also picks up rates on older invoices.
  public static Result importScadenzarioModifiedSince(Datetime modifiedSince) {
    if (modifiedSince == null) {
      throw new MexalInvoiceImportException(
        'Data di ultima modifica obbligatoria.'
      );
    }
    List<Object> scadenzarioRows = search(
      SCADENZARIO_SEARCH_ACTION,
      new List<Object>{
        filter('causale', '=', INVOICE_CAUSALE),
        filter('data_ult_mod', '>=', modifiedSince.format('yyyyMMdd HHmmss'))
      },
      true
    );
    Result result = new Result();
    saveDeadlines(scadenzarioRows, result);
    return result;
  }

  // Backfill by document date, in one transaction: both searches run before
  // any DML. Run MexalInvoiceLineImportBatch afterwards for the lines.
  public static Result importByDocumentDate(Date fromDate) {
    if (fromDate == null) {
      throw new MexalInvoiceImportException('Data iniziale obbligatoria.');
    }
    String mexalDate = Datetime.newInstance(
        fromDate,
        Time.newInstance(0, 0, 0, 0)
      )
      .format('yyyyMMdd');

    List<Object> movementRows = search(
      MOVEMENT_SEARCH_ACTION,
      new List<Object>{
        filter('sigla', '=', INVOICE_SIGLA),
        filter('data_documento', '>=', mexalDate)
      },
      false
    );
    // Only the last callout logs: a log insert before a callout is not allowed.
    List<Object> scadenzarioRows = search(
      SCADENZARIO_SEARCH_ACTION,
      new List<Object>{
        filter('causale', '=', INVOICE_CAUSALE),
        filter('data_documento', '>=', mexalDate)
      },
      true
    );

    Result result = new Result();
    saveInvoices(movementRows, result);
    saveDeadlines(scadenzarioRows, result);
    return result;
  }

  private static void saveInvoices(List<Object> movementRows, Result result) {
    result.invoicesReturned = movementRows.size();

    List<InvoiceHeader> headers = new List<InvoiceHeader>();
    Set<String> customerCodes = new Set<String>();
    for (Object row : movementRows) {
      Map<String, Object> source = (Map<String, Object>) row;
      InvoiceHeader header = new InvoiceHeader();
      header.serie = parseInteger(source.get('serie'));
      header.numero = parseInteger(source.get('numero'));
      header.customerCode = getString(source, 'cod_conto');
      header.documentDate = getString(source, 'data_documento');
      header.lastModified = getString(source, 'data_ult_mod');
      if (header.serie == null || header.numero == null) {
        result.errors.add('Fattura senza serie o numero ignorata.');
        continue;
      }
      headers.add(header);
      if (!String.isBlank(header.customerCode)) {
        customerCodes.add(header.customerCode);
      }
    }

    Map<String, Id> accountIdByCode = new Map<String, Id>();
    for (Account accountRecord : [
      SELECT Id, Codice_Cliente_Mexal__c
      FROM Account
      WHERE Codice_Cliente_Mexal__c IN :customerCodes
    ]) {
      accountIdByCode.put(
        accountRecord.Codice_Cliente_Mexal__c,
        accountRecord.Id
      );
    }

    // An invoice already linked to an order keeps the order's Account.
    Set<String> invoiceKeys = new Set<String>();
    for (InvoiceHeader header : headers) {
      invoiceKeys.add(
        invoiceKey(header.serie, header.numero, parseDate(header.documentDate))
      );
    }
    Map<String, Id> orderAccountIdByInvoiceKey = new Map<String, Id>();
    for (Fattura__c existing : [
      SELECT Chiave_Mexal__c, Ordine__r.AccountId
      FROM Fattura__c
      WHERE Chiave_Mexal__c IN :invoiceKeys AND Ordine__c != NULL
    ]) {
      orderAccountIdByInvoiceKey.put(
        existing.Chiave_Mexal__c,
        existing.Ordine__r.AccountId
      );
    }

    Datetime syncedAt = System.now();
    List<Fattura__c> invoices = new List<Fattura__c>();
    for (InvoiceHeader header : headers) {
      Date documentDate = parseDate(header.documentDate);
      String key = invoiceKey(header.serie, header.numero, documentDate);
      Fattura__c invoice = new Fattura__c(
        Name = INVOICE_SIGLA + ' ' + header.serie + '/' + header.numero,
        Chiave_Mexal__c = key,
        Tipo_Documento__c = 'Fattura',
        Sigla__c = INVOICE_SIGLA,
        Serie__c = header.serie,
        Numero__c = header.numero,
        Data_Documento__c = documentDate,
        Causale__c = INVOICE_CAUSALE,
        Codice_Cliente_Mexal__c = header.customerCode,
        Ultima_Modifica_Mexal__c = parseDatetime(header.lastModified),
        Ultima_Sincronizzazione__c = syncedAt
      );
      Id accountId = orderAccountIdByInvoiceKey.containsKey(key)
        ? orderAccountIdByInvoiceKey.get(key)
        : accountIdByCode.get(header.customerCode);
      // Left unset rather than null, so an upsert never clears an Account.
      if (accountId == null) {
        result.invoicesWithoutAccount++;
      } else {
        invoice.Account__c = accountId;
      }
      invoices.add(invoice);
    }

    result.invoicesSaved = countSaved(
      Database.upsert(invoices, Fattura__c.Chiave_Mexal__c, false),
      result.errors,
      result.invoiceIds
    );
  }

  // Rates are saved only for invoices already in Salesforce: the invoices
  // step runs first, so a missing invoice is outside the imported range.
  private static void saveDeadlines(
    List<Object> scadenzarioRows,
    Result result
  ) {
    result.scadenzarioDocumentsReturned = scadenzarioRows.size();

    Map<String, List<Deadline>> deadlinesByInvoiceKey = new Map<String, List<Deadline>>();
    for (Object row : scadenzarioRows) {
      Map<String, Object> source = (Map<String, Object>) row;
      Integer serie = parseInteger(source.get('serie'));
      Integer numero = parseInteger(source.get('numero'));
      if (serie == null || numero == null) {
        result.errors.add('Scadenzario senza serie o numero ignorato.');
        continue;
      }
      deadlinesByInvoiceKey.put(
        invoiceKey(
          serie,
          numero,
          parseDate(getString(source, 'data_documento'))
        ),
        mapDeadlines(source)
      );
    }

    Map<String, Fattura__c> invoicesByKey = new Map<String, Fattura__c>();
    for (Fattura__c invoice : [
      SELECT
        Id,
        Chiave_Mexal__c,
        Account__c,
        Ordine__c,
        Riferimento_Ordine_Mexal__c
      FROM Fattura__c
      WHERE Chiave_Mexal__c IN :deadlinesByInvoiceKey.keySet()
    ]) {
      invoicesByKey.put(invoice.Chiave_Mexal__c, invoice);
    }

    List<Scadenza_Fattura__c> deadlines = new List<Scadenza_Fattura__c>();
    for (String key : deadlinesByInvoiceKey.keySet()) {
      Fattura__c invoice = invoicesByKey.get(key);
      if (invoice == null) {
        result.deadlinesWithoutInvoice++;
        continue;
      }
      for (Deadline row : deadlinesByInvoiceKey.get(key)) {
        deadlines.add(
          new Scadenza_Fattura__c(
            Fattura__c = invoice.Id,
            Chiave_Mexal__c = key + '+' + row.rowIndex,
            Numero_Rata__c = row.rowIndex,
            Data_Scadenza__c = row.dueDate,
            Importo__c = row.amount,
            Stato_Pagamento_Mexal__c = row.paymentStatus,
            // The scadenzario carries no order reference: each rate takes
            // the Mexal order keys, the order and the Account of its invoice.
            Account__c = invoice.Account__c,
            Ordine__c = invoice.Ordine__c,
            Riferimento_Ordine_Mexal__c = invoice.Riferimento_Ordine_Mexal__c
          )
        );
      }
    }

    Set<Id> savedDeadlineIds = new Set<Id>();
    result.deadlinesSaved = countSaved(
      Database.upsert(deadlines, Scadenza_Fattura__c.Chiave_Mexal__c, false),
      result.errors,
      savedDeadlineIds
    );

    Set<Id> invoiceIds = new Set<Id>();
    for (Scadenza_Fattura__c deadline : deadlines) {
      if (savedDeadlineIds.contains(deadline.Id)) {
        invoiceIds.add(deadline.Fattura__c);
      }
    }
    result.orderLinesUpdated = linkOrderLines(invoiceIds, result.errors);
  }

  // Each invoiced order line takes its rate and Paid / Unpaid from it; the
  // tranche follows its lines (OrderItemTriggerHandler). A rate whose lines
  // all sit on one tranche is linked to that tranche.
  public static Integer linkOrderLines(
    Set<Id> invoiceIds,
    List<String> errors
  ) {
    if (invoiceIds == null || invoiceIds.isEmpty()) {
      return 0;
    }

    Map<Id, List<Scadenza_Fattura__c>> deadlinesByInvoiceId = new Map<Id, List<Scadenza_Fattura__c>>();
    Map<Id, Scadenza_Fattura__c> deadlinesById = new Map<Id, Scadenza_Fattura__c>();
    for (Scadenza_Fattura__c deadline : [
      SELECT Id, Fattura__c, Data_Scadenza__c, Pagata__c, Tranche__c
      FROM Scadenza_Fattura__c
      WHERE Fattura__c IN :invoiceIds
      ORDER BY Numero_Rata__c
    ]) {
      if (!deadlinesByInvoiceId.containsKey(deadline.Fattura__c)) {
        deadlinesByInvoiceId.put(
          deadline.Fattura__c,
          new List<Scadenza_Fattura__c>()
        );
      }
      deadlinesByInvoiceId.get(deadline.Fattura__c).add(deadline);
      deadlinesById.put(deadline.Id, deadline);
    }

    List<OrderItem> lineUpdates = new List<OrderItem>();
    Map<Id, Set<Id>> trancheIdsByDeadlineId = new Map<Id, Set<Id>>();
    for (OrderItem line : [
      SELECT
        Id,
        Fattura__c,
        Data_Scadenza__c,
        Tranche__c,
        Scadenza_Fattura__c,
        Mexal_Payment_Status__c
      FROM OrderItem
      WHERE Fattura__c IN :invoiceIds
    ]) {
      Scadenza_Fattura__c deadline = matchDeadline(
        deadlinesByInvoiceId.get(line.Fattura__c),
        line.Data_Scadenza__c
      );
      if (deadline == null) {
        continue;
      }
      if (!trancheIdsByDeadlineId.containsKey(deadline.Id)) {
        trancheIdsByDeadlineId.put(deadline.Id, new Set<Id>());
      }
      trancheIdsByDeadlineId.get(deadline.Id).add(line.Tranche__c);

      String status = deadline.Pagata__c
        ? PAYMENT_STATUS_PAID
        : PAYMENT_STATUS_UNPAID;
      if (
        line.Scadenza_Fattura__c != deadline.Id ||
        line.Mexal_Payment_Status__c != status
      ) {
        lineUpdates.add(
          new OrderItem(
            Id = line.Id,
            Scadenza_Fattura__c = deadline.Id,
            Mexal_Payment_Status__c = status
          )
        );
      }
    }

    List<Scadenza_Fattura__c> deadlineUpdates = new List<Scadenza_Fattura__c>();
    for (Id deadlineId : trancheIdsByDeadlineId.keySet()) {
      Set<Id> trancheIds = trancheIdsByDeadlineId.get(deadlineId);
      if (trancheIds.size() != 1 || trancheIds.contains(null)) {
        continue;
      }
      Id trancheId = new List<Id>(trancheIds)[0];
      if (deadlinesById.get(deadlineId).Tranche__c != trancheId) {
        deadlineUpdates.add(
          new Scadenza_Fattura__c(Id = deadlineId, Tranche__c = trancheId)
        );
      }
    }

    Integer updated = countSaved(
      Database.update(lineUpdates, false),
      errors,
      null
    );
    countSaved(Database.update(deadlineUpdates, false), errors, null);
    return updated;
  }

  // The rate with the line's due date (Salesforce sends it as dt_sca_riga and
  // Mexal raises one rate per date); an invoice with a single rate pays all its lines.
  public static Scadenza_Fattura__c matchDeadline(
    List<Scadenza_Fattura__c> deadlines,
    Date lineDueDate
  ) {
    if (deadlines == null || deadlines.isEmpty()) {
      return null;
    }
    if (deadlines.size() == 1) {
      return deadlines[0];
    }
    for (Scadenza_Fattura__c deadline : deadlines) {
      if (lineDueDate != null && deadline.Data_Scadenza__c == lineDueDate) {
        return deadline;
      }
    }
    return null;
  }

  private static String invoiceKey(
    Integer serie,
    Integer numero,
    Date documentDate
  ) {
    return String.join(
      new List<String>{
        INVOICE_SIGLA,
        String.valueOf(serie),
        String.valueOf(numero),
        documentDate == null ? '' : String.valueOf(documentDate.year())
      },
      '+'
    );
  }

  private static List<Object> search(
    String actionName,
    List<Object> filters,
    Boolean insertLog
  ) {
    MexalSearchCalloutService.Result httpResult = MexalSearchCalloutService.sendReadOnly(
      actionName,
      new Map<String, Object>{ 'filtri' => filters },
      insertLog
    );
    if (httpResult == null || httpResult.success != true) {
      throw new MexalInvoiceImportException(
        'Ricerca Mexal ' +
          actionName +
          ' fallita' +
          (httpResult == null ? '.' : ' (HTTP ' + httpResult.statusCode + ').')
      );
    }
    Object dati = ((Map<String, Object>) JSON.deserializeUntyped(
        httpResult.body
      ))
      .get('dati');
    return dati instanceof List<Object>
      ? (List<Object>) dati
      : new List<Object>();
  }

  private static Map<String, Object> filter(
    String field,
    String condition,
    String value
  ) {
    return new Map<String, Object>{
      'campo' => field,
      'condizione' => condition,
      'valore' => value
    };
  }

  // Mexal returns row fields as [[rowIndex, value], ...].
  private static List<Deadline> mapDeadlines(Map<String, Object> source) {
    Map<Integer, Object> dueDates = indexValues(source.get('dt_sca_pg'));
    Map<Integer, Object> amounts = indexValues(source.get('imp_scadenza'));
    Map<Integer, Object> statuses = indexValues(source.get('stato_pagamento'));
    Set<Integer> indexes = new Set<Integer>(dueDates.keySet());
    indexes.addAll(amounts.keySet());
    List<Integer> sortedIndexes = new List<Integer>(indexes);
    sortedIndexes.sort();

    List<Deadline> rows = new List<Deadline>();
    for (Integer rowIndex : sortedIndexes) {
      Deadline row = new Deadline();
      row.rowIndex = rowIndex;
      row.dueDate = parseDate(
        dueDates.get(rowIndex) == null
          ? null
          : String.valueOf(dueDates.get(rowIndex))
      );
      row.amount = parseDecimal(amounts.get(rowIndex));
      String status = statuses.get(rowIndex) == null
        ? null
        : String.valueOf(statuses.get(rowIndex)).trim().toUpperCase();
      row.paymentStatus = PAYMENT_STATUSES.contains(status) ? status : null;
      rows.add(row);
    }
    return rows;
  }

  private static Map<Integer, Object> indexValues(Object value) {
    Map<Integer, Object> valuesByIndex = new Map<Integer, Object>();
    if (!(value instanceof List<Object>)) {
      return valuesByIndex;
    }
    for (Object row : (List<Object>) value) {
      if (row instanceof List<Object> && ((List<Object>) row).size() >= 2) {
        Integer index = parseInteger(((List<Object>) row)[0]);
        if (index != null) {
          valuesByIndex.put(index, ((List<Object>) row)[1]);
        }
      }
    }
    return valuesByIndex;
  }

  // savedIds, when given, collects the ids of the saved records.
  private static Integer countSaved(
    List<Database.UpsertResult> saveResults,
    List<String> errors,
    Set<Id> savedIds
  ) {
    Integer saved = 0;
    for (Database.UpsertResult saveResult : saveResults) {
      if (saveResult.isSuccess()) {
        saved++;
        if (savedIds != null) {
          savedIds.add(saveResult.getId());
        }
        continue;
      }
      addErrors(saveResult.getErrors(), errors);
    }
    return saved;
  }

  private static Integer countSaved(
    List<Database.SaveResult> saveResults,
    List<String> errors,
    Set<Id> savedIds
  ) {
    Integer saved = 0;
    for (Database.SaveResult saveResult : saveResults) {
      if (saveResult.isSuccess()) {
        saved++;
        if (savedIds != null) {
          savedIds.add(saveResult.getId());
        }
        continue;
      }
      addErrors(saveResult.getErrors(), errors);
    }
    return saved;
  }

  private static void addErrors(
    List<Database.Error> saveErrors,
    List<String> errors
  ) {
    for (Database.Error error : saveErrors) {
      if (errors != null && errors.size() < 20) {
        errors.add(error.getStatusCode() + ': ' + error.getMessage());
      }
    }
  }

  private static String getString(Map<String, Object> source, String field) {
    Object value = source.get(field);
    return value == null ? null : String.valueOf(value);
  }

  private static Integer parseInteger(Object value) {
    Decimal decimalValue = parseDecimal(value);
    return decimalValue == null ? null : decimalValue.intValue();
  }

  private static Decimal parseDecimal(Object value) {
    if (value == null) {
      return null;
    }
    try {
      return Decimal.valueOf(String.valueOf(value).trim());
    } catch (Exception ignored) {
      return null;
    }
  }

  // Mexal dates are yyyyMMdd.
  private static Date parseDate(String value) {
    if (String.isBlank(value) || value.trim().length() < 8) {
      return null;
    }
    String digits = value.trim().substring(0, 8);
    try {
      return Date.newInstance(
        Integer.valueOf(digits.substring(0, 4)),
        Integer.valueOf(digits.substring(4, 6)),
        Integer.valueOf(digits.substring(6, 8))
      );
    } catch (Exception ignored) {
      return null;
    }
  }

  // Mexal timestamps are 'yyyyMMdd HHmmss', in the company's local time.
  private static Datetime parseDatetime(String value) {
    Date day = parseDate(value);
    if (day == null) {
      return null;
    }
    String trimmed = value.trim();
    if (trimmed.length() < 15) {
      return Datetime.newInstance(day, Time.newInstance(0, 0, 0, 0));
    }
    try {
      return Datetime.newInstance(
        day,
        Time.newInstance(
          Integer.valueOf(trimmed.substring(9, 11)),
          Integer.valueOf(trimmed.substring(11, 13)),
          Integer.valueOf(trimmed.substring(13, 15)),
          0
        )
      );
    } catch (Exception ignored) {
      return Datetime.newInstance(day, Time.newInstance(0, 0, 0, 0));
    }
  }
}
