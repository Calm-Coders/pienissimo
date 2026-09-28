public with sharing class MexalMaggazinoDetailService {
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
    public String sigla;
    @AuraEnabled
    public Integer serie;
    @AuraEnabled
    public Integer numero;
    @AuraEnabled
    public String customerCode;
    @AuraEnabled
    public Integer rowsReturned;
    @AuraEnabled
    public Integer mappedInvoiceLines;
    @AuraEnabled
    public Integer unmappedInvoiceLines;
    @AuraEnabled
    public Integer paidInvoiceLines;
    @AuraEnabled
    public Integer unpaidInvoiceLines;
    @AuraEnabled
    public Integer invoiceLinesWithoutPaymentMatch;
    @AuraEnabled
    public Integer paymentStatusUpdates;
    @AuraEnabled
    public List<MexalInvoiceOrderLineMappingService.LineMapping> mappings;
    @AuraEnabled
    public String message;

    public Result() {
      success = false;
      bodyLength = 0;
      rowsReturned = 0;
      mappedInvoiceLines = 0;
      unmappedInvoiceLines = 0;
      paidInvoiceLines = 0;
      unpaidInvoiceLines = 0;
      invoiceLinesWithoutPaymentMatch = 0;
      paymentStatusUpdates = 0;
      mappings = new List<MexalInvoiceOrderLineMappingService.LineMapping>();
    }
  }

  public class MexalMaggazinoDetailException extends Exception {
  }

  @AuraEnabled
  public static Result getDetail(
    String sigla,
    Integer serie,
    Integer numero,
    String customerCode
  ) {
    return getDetail(
      sigla,
      serie,
      numero,
      customerCode,
      new List<MexalScadenzarioSearchService.ScadenzarioDocument>()
    );
  }

  public static Result getDetail(
    String sigla,
    Integer serie,
    Integer numero,
    String customerCode,
    List<MexalScadenzarioSearchService.ScadenzarioDocument> scadenzarioDocuments
  ) {
    validateKey(sigla, serie, numero, customerCode);

    MexalSearchCalloutService.Result httpResult = MexalSearchCalloutService.getMovementDetail(
      sigla,
      serie,
      numero,
      customerCode
    );

    return buildResult(
      sigla,
      serie,
      numero,
      customerCode,
      httpResult,
      scadenzarioDocuments
    );
  }

  public static Result getDetail(
    MexalMaggazinoSearchService.MaggazinoDocument document
  ) {
    return getDetail(
      document,
      new List<MexalScadenzarioSearchService.ScadenzarioDocument>()
    );
  }

  public static Result getDetail(
    MexalMaggazinoSearchService.MaggazinoDocument document,
    List<MexalScadenzarioSearchService.ScadenzarioDocument> scadenzarioDocuments
  ) {
    if (document == null) {
      throw new MexalMaggazinoDetailException(
        'Documento movimenti magazzino obbligatorio.'
      );
    }

    return getDetail(
      document.sigla,
      document.serie,
      document.numero,
      document.customerCode,
      scadenzarioDocuments
    );
  }

  private static void validateKey(
    String sigla,
    Integer serie,
    Integer numero,
    String customerCode
  ) {
    if (sigla != 'FT') {
      throw new MexalMaggazinoDetailException(
        'Il dettaglio movimenti magazzino e previsto solo per documenti FT.'
      );
    }
    if (serie == null || numero == null || String.isBlank(customerCode)) {
      throw new MexalMaggazinoDetailException(
        'Chiave documento FT Mexal incompleta.'
      );
    }
  }

  private static Result buildResult(
    String sigla,
    Integer serie,
    Integer numero,
    String customerCode,
    MexalSearchCalloutService.Result httpResult,
    List<MexalScadenzarioSearchService.ScadenzarioDocument> scadenzarioDocuments
  ) {
    Result result = new Result();
    result.sigla = sigla;
    result.serie = serie;
    result.numero = numero;
    result.customerCode = customerCode;

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
    result.integrationLogId = getLastLogId(httpResult.integrationLogs);
    result.rowsReturned = countRows(httpResult.body);
    mapInvoiceLines(result, httpResult.body, scadenzarioDocuments);
    result.message = result.success
      ? 'Dettaglio movimento magazzino Mexal completato.'
      : 'Dettaglio movimento magazzino Mexal fallito.';
    return result;
  }

  private static void mapInvoiceLines(
    Result result,
    String body,
    List<MexalScadenzarioSearchService.ScadenzarioDocument> scadenzarioDocuments
  ) {
    if (result.success != true) {
      return;
    }

    MexalInvoiceOrderLineMappingService.Result mappingResult = MexalInvoiceOrderLineMappingService.mapInvoiceDetail(
      body,
      scadenzarioDocuments
    );
    result.mappedInvoiceLines = mappingResult.matchedLines;
    result.unmappedInvoiceLines = mappingResult.unmatchedLines;
    result.paidInvoiceLines = mappingResult.paidLines;
    result.unpaidInvoiceLines = mappingResult.unpaidLines;
    result.invoiceLinesWithoutPaymentMatch = mappingResult.linesWithoutPaymentMatch;
    result.mappings = mappingResult.mappings;
  }

  private static Integer countRows(String body) {
    if (String.isBlank(body)) {
      return 0;
    }

    Object response = JSON.deserializeUntyped(body);
    if (!(response instanceof Map<String, Object>)) {
      return 0;
    }

    Object dati = ((Map<String, Object>) response).get('dati');
    if (dati instanceof List<Object>) {
      return ((List<Object>) dati).size();
    }

    return dati == null ? 0 : 1;
  }

  private static Id getLastLogId(List<Integration_Log__c> integrationLogs) {
    if (integrationLogs == null || integrationLogs.isEmpty()) {
      return null;
    }

    return integrationLogs[integrationLogs.size() - 1].Id;
  }
}
