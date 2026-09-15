public with sharing class MexalMaggazinoSearchService {
  public static final String ACTION_NAME = 'Mexal_Movimenti_Magazzino_Ricerca';

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
    public Integer documentsReturned;
    @AuraEnabled
    public Integer ftDocumentsReturned;
    @AuraEnabled
    public Integer skippedRows;
    @AuraEnabled
    public List<MaggazinoDocument> documents;
    @AuraEnabled
    public String message;

    public Result() {
      success = false;
      bodyLength = 0;
      documentsReturned = 0;
      ftDocumentsReturned = 0;
      skippedRows = 0;
      documents = new List<MaggazinoDocument>();
    }
  }

  public class MaggazinoDocument {
    @AuraEnabled
    public String sigla;
    @AuraEnabled
    public Integer serie;
    @AuraEnabled
    public Integer numero;
    @AuraEnabled
    public String customerCode;
    @AuraEnabled
    public String documentDate;
    @AuraEnabled
    public String orderSigla;
    @AuraEnabled
    public Integer orderSerie;
    @AuraEnabled
    public Integer orderNumber;
    @AuraEnabled
    public String orderDate;
    @AuraEnabled
    public String lastModifiedDateTime;
  }

  public class MexalMaggazinoSearchException extends Exception {
  }

  @AuraEnabled
  public static Result searchModifiedSince(Datetime modifiedSince) {
    if (modifiedSince == null) {
      throw new MexalMaggazinoSearchException(
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
          'campo' => 'sigla',
          'condizione' => '=',
          'valore' => 'FT'
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
      ? 'Ricerca movimenti magazzino Mexal completata.'
      : 'Ricerca movimenti magazzino Mexal fallita.';
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

    List<Object> rows = (List<Object>) dati;
    result.documentsReturned = rows.size();

    for (Object row : rows) {
      if (!(row instanceof Map<String, Object>)) {
        result.skippedRows++;
        continue;
      }

      MaggazinoDocument document = mapMaggazinoDocument(
        (Map<String, Object>) row
      );
      result.documents.add(document);
      if (document.sigla == 'FT') {
        result.ftDocumentsReturned++;
      }
    }
  }

  private static MaggazinoDocument mapMaggazinoDocument(
    Map<String, Object> source
  ) {
    MaggazinoDocument document = new MaggazinoDocument();
    document.sigla = getString(source, 'sigla');
    document.serie = parseInteger(source.get('serie'));
    document.numero = parseInteger(source.get('numero'));
    document.customerCode = getString(source, 'cod_conto');
    document.documentDate = getString(source, 'data_documento');
    document.orderSigla = getIndexedString(source, 'sigla_ordine');
    document.orderSerie = parseInteger(getIndexedValue(source, 'serie_ordine'));
    document.orderNumber = parseInteger(
      getIndexedValue(source, 'numero_ordine')
    );
    document.orderDate = getIndexedString(source, 'data_ordine');
    document.lastModifiedDateTime = getString(source, 'data_ult_mod');
    return document;
  }

  private static Object getIndexedValue(
    Map<String, Object> source,
    String fieldName
  ) {
    if (source == null || !source.containsKey(fieldName)) {
      return null;
    }

    Object value = source.get(fieldName);
    if (!(value instanceof List<Object>)) {
      return value;
    }

    List<Object> rows = (List<Object>) value;
    if (rows.isEmpty() || !(rows[0] instanceof List<Object>)) {
      return null;
    }

    List<Object> firstRow = (List<Object>) rows[0];
    return firstRow.size() < 2 ? null : firstRow[1];
  }

  private static String getIndexedString(
    Map<String, Object> source,
    String fieldName
  ) {
    Object value = getIndexedValue(source, fieldName);
    return value == null ? null : String.valueOf(value);
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

  private static Id getLastLogId(List<Integration_Log__c> integrationLogs) {
    if (integrationLogs == null || integrationLogs.isEmpty()) {
      return null;
    }

    return integrationLogs[integrationLogs.size() - 1].Id;
  }
}
