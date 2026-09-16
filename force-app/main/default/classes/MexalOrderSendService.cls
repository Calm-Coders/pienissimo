public with sharing class MexalOrderSendService {
  private static final String DEFAULT_DOCUMENT_TYPE = 'OC';
  private static final Integer DEFAULT_SERIES = 10;
  private static final Integer AUTO_NUMBER = 0;
  private static final Integer NEW_LINE_ID = 0;
  private static final String ARTICLE_LINE_TYPE = 'R';
  private static final String DEFAULT_VAT_CODE = '22';

  public class Result {
    public Boolean success;
    public Integer statusCode;
    public String body;
    public Id integrationLogId;
    public Id orderId;
    public String mexalOrderNumber;
    public String mexalDocumentSigla;
    public Integer mexalDocumentSerie;
    public Integer mexalDocumentNumber;
    public String mexalCustomerCode;
    public Map<Id, Integer> lineNumbersByOrderItemId;
    public Map<String, Object> requestPayload;
    public String message;

    public Result() {
      success = false;
      lineNumbersByOrderItemId = new Map<Id, Integer>();
      requestPayload = new Map<String, Object>();
    }
  }

  public class MexalOrderSendException extends Exception {
  }

  public static Result sendOrder(Id orderId) {
    if (orderId == null) {
      throw new MexalOrderSendException('Ordine obbligatorio.');
    }

    Order orderRecord = loadOrder(orderId);
    validateOrder(orderRecord);

    Map<String, Object> payload = buildOrderPayload(orderRecord);
    MexalSearchCalloutService.Result calloutResult = MexalSearchCalloutService.createOrder(
      payload
    );

    Result result = buildResult(orderRecord, payload, calloutResult);
    if (result.success != true) {
      throw new MexalOrderSendException(result.message);
    }

    return result;
  }

  private static Order loadOrder(Id orderId) {
    return [
      SELECT
        Id,
        AccountId,
        Account.Codice_Cliente_Mexal__c,
        EffectiveDate,
        OrderNumber,
        Quote__c,
        WooCommerce_Order_Key__c,
        (
          SELECT
            Id,
            Description,
            Quantity,
            UnitPrice,
            TotalPrice,
            Data_Scadenza__c,
            Product2Id,
            Product2.External_Product_Code__c,
            Product2.ProductCode,
            PricebookEntry.Product2.External_Product_Code__c,
            PricebookEntry.Product2.ProductCode
          FROM OrderItems
          ORDER BY CreatedDate, Id
        )
      FROM Order
      WHERE Id = :orderId
      LIMIT 1
    ];
  }

  private static void validateOrder(Order orderRecord) {
    if (orderRecord.AccountId == null) {
      throw new MexalOrderSendException(
        'Ordine senza Account: impossibile inviare a Mexal.'
      );
    }

    if (String.isBlank(orderRecord.Account.Codice_Cliente_Mexal__c)) {
      throw new MexalOrderSendException(
        'Codice cliente Mexal mancante sull Account.'
      );
    }

    if (orderRecord.OrderItems == null || orderRecord.OrderItems.isEmpty()) {
      throw new MexalOrderSendException(
        'Ordine senza righe: impossibile inviare a Mexal.'
      );
    }

    for (OrderItem line : orderRecord.OrderItems) {
      if (String.isBlank(resolveProductCode(line))) {
        throw new MexalOrderSendException(
          'Codice articolo Mexal mancante sulla riga ordine ' + line.Id + '.'
        );
      }
    }
  }

  private static Map<String, Object> buildOrderPayload(Order orderRecord) {
    Map<String, Object> payload = new Map<String, Object>();
    payload.put('sigla', DEFAULT_DOCUMENT_TYPE);
    payload.put('serie', DEFAULT_SERIES);
    payload.put('numero', AUTO_NUMBER);
    payload.put('cod_conto', orderRecord.Account.Codice_Cliente_Mexal__c);
    payload.put('data_documento', formatDate(orderRecord.EffectiveDate));
    putLineArrays(payload, orderRecord.OrderItems);
    return payload;
  }

  private static void putLineArrays(
    Map<String, Object> payload,
    List<OrderItem> orderLines
  ) {
    List<Object> lineIds = new List<Object>();
    List<Object> lineTypes = new List<Object>();
    List<Object> articleCodes = new List<Object>();
    List<Object> quantities = new List<Object>();
    List<Object> vatCodes = new List<Object>();
    Integer lineNumber = 1;

    for (OrderItem line : orderLines) {
      lineIds.add(new List<Object>{ lineNumber, NEW_LINE_ID });
      lineTypes.add(new List<Object>{ lineNumber, ARTICLE_LINE_TYPE });
      articleCodes.add(
        new List<Object>{ lineNumber, resolveProductCode(line) }
      );
      quantities.add(new List<Object>{ lineNumber, line.Quantity });
      vatCodes.add(new List<Object>{ lineNumber, DEFAULT_VAT_CODE });
      lineNumber++;
    }

    payload.put('id_riga', lineIds);
    payload.put('tp_riga', lineTypes);
    payload.put('codice_articolo', articleCodes);
    payload.put('quantita', quantities);
    payload.put('cod_iva', vatCodes);
  }

  private static Map<Id, Integer> buildLineNumberMap(
    List<OrderItem> orderLines
  ) {
    Map<Id, Integer> lineNumbersByOrderItemId = new Map<Id, Integer>();
    Integer lineNumber = 1;

    for (OrderItem line : orderLines) {
      lineNumbersByOrderItemId.put(line.Id, lineNumber);
      lineNumber++;
    }

    return lineNumbersByOrderItemId;
  }

  private static String resolveProductCode(OrderItem line) {
    if (line.Product2 != null) {
      String productCode = firstNonBlank(
        line.Product2.External_Product_Code__c,
        line.Product2.ProductCode
      );
      if (productCode != null) {
        return productCode;
      }
    }

    if (line.PricebookEntry != null && line.PricebookEntry.Product2 != null) {
      return firstNonBlank(
        line.PricebookEntry.Product2.External_Product_Code__c,
        line.PricebookEntry.Product2.ProductCode
      );
    }

    return null;
  }

  private static Result buildResult(
    Order orderRecord,
    Map<String, Object> payload,
    MexalSearchCalloutService.Result calloutResult
  ) {
    Result result = new Result();
    result.orderId = orderRecord.Id;
    result.mexalDocumentSigla = DEFAULT_DOCUMENT_TYPE;
    result.mexalDocumentSerie = DEFAULT_SERIES;
    result.mexalCustomerCode = orderRecord.Account.Codice_Cliente_Mexal__c;
    result.lineNumbersByOrderItemId = buildLineNumberMap(
      orderRecord.OrderItems
    );
    result.requestPayload = payload;

    if (calloutResult == null) {
      result.message = 'Nessuna risposta dal servizio Mexal.';
      return result;
    }

    result.success = calloutResult.success;
    result.statusCode = calloutResult.statusCode;
    result.body = calloutResult.body;
    result.integrationLogId = getLastLogId(calloutResult.integrationLogs);
    result.mexalOrderNumber = findMexalOrderNumber(calloutResult);
    result.mexalDocumentNumber = parseInteger(result.mexalOrderNumber);
    result.message = result.success
      ? 'Creazione ordine Mexal completata.'
      : 'Creazione ordine Mexal fallita.';
    return result;
  }

  private static String findMexalOrderNumber(
    MexalSearchCalloutService.Result calloutResult
  ) {
    String numberFromHeaders = findMexalOrderNumberInHeaders(
      calloutResult.responseHeaders
    );
    if (!String.isBlank(numberFromHeaders)) {
      return numberFromHeaders;
    }

    return findMexalOrderNumberInBody(calloutResult.body);
  }

  private static String findMexalOrderNumberInHeaders(
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
        headerName.contains('numero') ||
        headerName.contains('ordine') ||
        headerName.contains('document')
      ) {
        return headerValue;
      }
    }

    return null;
  }

  private static String findMexalOrderNumberInBody(String body) {
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
        'numero',
        'numero_ordine',
        'numero_documento',
        'ordine',
        'documento'
      }
    ) {
      Object value = response.get(key);
      if (value != null && !String.isBlank(String.valueOf(value))) {
        return String.valueOf(value).trim();
      }
    }

    return null;
  }

  private static String formatDate(Date value) {
    return value == null
      ? null
      : String.valueOf(value.year()).leftPad(4, '0') +
        String.valueOf(value.month()).leftPad(2, '0') +
        String.valueOf(value.day()).leftPad(2, '0');
  }

  private static String firstNonBlank(String firstValue, String secondValue) {
    if (!String.isBlank(firstValue)) {
      return firstValue.trim();
    }

    return String.isBlank(secondValue) ? null : secondValue.trim();
  }

  private static Integer parseInteger(String value) {
    if (String.isBlank(value)) {
      return null;
    }

    try {
      return Integer.valueOf(value.trim());
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
