public with sharing class MexalScadenzarioSearchService {
  public static final String ACTION_NAME = 'Mexal_Scadenzario_Ricerca';

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
    public Integer documentsReturned;
    @AuraEnabled
    public Integer paymentRowsReturned;
    @AuraEnabled
    public Integer skippedRows;
    @AuraEnabled
    public List<ScadenzarioDocument> documents;
    @AuraEnabled
    public String message;

    public Result() {
      success = false;
      bodyLength = 0;
      documentsReturned = 0;
      paymentRowsReturned = 0;
      skippedRows = 0;
      documents = new List<ScadenzarioDocument>();
    }
  }

  public class ScadenzarioDocument {
    @AuraEnabled
    public String customerCode;
    @AuraEnabled
    public String documentDate;
    @AuraEnabled
    public Integer serie;
    @AuraEnabled
    public Integer numero;
    @AuraEnabled
    public String causale;
    @AuraEnabled
    public String lastModifiedDateTime;
    @AuraEnabled
    public List<PaymentDeadline> deadlines;

    public ScadenzarioDocument() {
      deadlines = new List<PaymentDeadline>();
    }
  }

  public class PaymentDeadline {
    @AuraEnabled
    public Integer rowIndex;
    @AuraEnabled
    public Date dueDate;
    @AuraEnabled
    public Decimal amount;
    @AuraEnabled
    public String paymentStatus;
    @AuraEnabled
    public Boolean paid;
  }

  public class MexalScadenzarioSearchException extends Exception {
  }

  @AuraEnabled
  public static Result searchModifiedSince(Datetime modifiedSince) {
    if (modifiedSince == null) {
      throw new MexalScadenzarioSearchException(
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
          'campo' => 'causale',
          'condizione' => '=',
          'valore' => 'FE'
        },
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
      ? 'Ricerca scadenzario Mexal completata.'
      : 'Ricerca scadenzario Mexal fallita.';
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

    Object dati = ((Map<String, Object>) response).get('dati');
    if (!(dati instanceof List<Object>)) {
      return;
    }

    List<Object> rows = (List<Object>) dati;
    result.documentsReturned = rows.size();

    for (Object row : rows) {
      if (!(row instanceof Map<String, Object>)) {
        result.skippedRows++;
        continue;
      }

      ScadenzarioDocument document = mapScadenzarioDocument(
        (Map<String, Object>) row
      );
      result.documents.add(document);
      result.paymentRowsReturned += document.deadlines.size();
    }
  }

  private static ScadenzarioDocument mapScadenzarioDocument(
    Map<String, Object> source
  ) {
    ScadenzarioDocument document = new ScadenzarioDocument();
    document.customerCode = getString(source, 'codice');
    document.documentDate = getString(source, 'data_documento');
    document.serie = parseInteger(source.get('serie'));
    document.numero = parseInteger(source.get('numero'));
    document.causale = getString(source, 'causale');
    document.lastModifiedDateTime = getString(source, 'data_ult_mod');
    document.deadlines = mapDeadlines(source);
    return document;
  }

  private static List<PaymentDeadline> mapDeadlines(
    Map<String, Object> source
  ) {
    List<PaymentDeadline> deadlines = new List<PaymentDeadline>();
    for (Integer rowIndex : getDeadlineIndexes(source)) {
      PaymentDeadline deadline = new PaymentDeadline();
      deadline.rowIndex = rowIndex;
      deadline.dueDate = parseDate(
        getIndexedValue(source, 'dt_sca_pg', rowIndex)
      );
      deadline.amount = parseDecimal(
        getIndexedValue(source, 'imp_scadenza', rowIndex)
      );
      deadline.paymentStatus = getIndexedString(
        source,
        'stato_pagamento',
        rowIndex
      );
      deadline.paid = deadline.paymentStatus == 'P';
      deadlines.add(deadline);
    }
    return deadlines;
  }

  private static Set<Integer> getDeadlineIndexes(Map<String, Object> source) {
    Set<Integer> indexes = new Set<Integer>();
    for (
      String fieldName : new List<String>{
        'dt_sca_pg',
        'imp_scadenza',
        'stato_pagamento'
      }
    ) {
      Object value = source.get(fieldName);
      if (!(value instanceof List<Object>)) {
        continue;
      }

      for (Object row : (List<Object>) value) {
        if (!(row instanceof List<Object>)) {
          continue;
        }

        List<Object> indexedRow = (List<Object>) row;
        if (!indexedRow.isEmpty()) {
          Integer index = parseInteger(indexedRow[0]);
          if (index != null) {
            indexes.add(index);
          }
        }
      }
    }
    return indexes;
  }

  private static Object getIndexedValue(
    Map<String, Object> source,
    String fieldName,
    Integer rowIndex
  ) {
    Object value = source.get(fieldName);
    if (!(value instanceof List<Object>)) {
      return value;
    }

    for (Object row : (List<Object>) value) {
      if (!(row instanceof List<Object>)) {
        continue;
      }

      List<Object> indexedRow = (List<Object>) row;
      if (indexedRow.size() >= 2 && parseInteger(indexedRow[0]) == rowIndex) {
        return indexedRow[1];
      }
    }
    return null;
  }

  private static String getIndexedString(
    Map<String, Object> source,
    String fieldName,
    Integer rowIndex
  ) {
    Object value = getIndexedValue(source, fieldName, rowIndex);
    return value == null ? null : String.valueOf(value);
  }

  private static String getString(
    Map<String, Object> source,
    String fieldName
  ) {
    Object value = source.get(fieldName);
    return value == null ? null : String.valueOf(value);
  }

  private static Integer parseInteger(Object value) {
    if (value == null) {
      return null;
    }
    try {
      return Integer.valueOf(String.valueOf(value));
    } catch (Exception ignored) {
      return null;
    }
  }

  private static Decimal parseDecimal(Object value) {
    if (value == null) {
      return null;
    }
    try {
      return Decimal.valueOf(String.valueOf(value));
    } catch (Exception ignored) {
      return null;
    }
  }

  private static Date parseDate(Object value) {
    if (value == null) {
      return null;
    }

    String rawValue = String.valueOf(value);
    if (rawValue.length() != 8) {
      return null;
    }

    try {
      return Date.newInstance(
        Integer.valueOf(rawValue.substring(0, 4)),
        Integer.valueOf(rawValue.substring(4, 6)),
        Integer.valueOf(rawValue.substring(6, 8))
      );
    } catch (Exception ignored) {
      return null;
    }
  }

  private static Id getLastLogId(List<Integration_Log__c> integrationLogs) {
    if (integrationLogs == null || integrationLogs.isEmpty()) {
      return null;
    }

    return integrationLogs[integrationLogs.size() - 1].Id;
  }
}
