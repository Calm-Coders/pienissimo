public with sharing class MexalOrderSendService {
  private static final String DEFAULT_DOCUMENT_TYPE = 'OC';
  private static final String BOOK_DOCUMENT_TYPE = 'BC';
  private static final Integer SANDBOX_SERIES = 10;
  private static final Integer PRODUCTION_SERIES = 1;
  private static final Integer AUTO_NUMBER = 0;
  private static final Long NEW_LINE_ID = 0;
  private static final String ARTICLE_LINE_TYPE = 'R';
  private static final String SERVICE_VAT_CODE = 'E01';
  private static final String BOOK_VAT_CODE = 'E10';
  private static Integer resolvedDocumentSeries;

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
        Codice_Agente__c,
        EffectiveDate,
        OrderNumber,
        Quote__c,
        Condizione_di_Pagamento__c,
        WooCommerce_Order_Key__c,
        (
          SELECT
            Id,
            OrderItemNumber,
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

    if (String.isBlank(orderRecord.Condizione_di_Pagamento__c)) {
      throw new MexalOrderSendException(
        'Condizione di pagamento obbligatoria per creare l ordine Mexal.'
      );
    }

    if (String.isBlank(orderRecord.Codice_Agente__c)) {
      throw new MexalOrderSendException(
        'Codice agente obbligatorio per creare l ordine Mexal.'
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
    String documentType = DEFAULT_DOCUMENT_TYPE;
    Map<String, Object> payload = new Map<String, Object>();
    payload.put('sigla', documentType);
    payload.put('serie', resolveDocumentSeries());
    payload.put('numero', AUTO_NUMBER);
    payload.put('cod_conto', orderRecord.Account.Codice_Cliente_Mexal__c);
    if (!String.isBlank(orderRecord.Codice_Agente__c)) {
      payload.put('codice_agente', orderRecord.Codice_Agente__c.trim());
    }
    payload.put('data_documento', formatDate(orderRecord.EffectiveDate));
    putIntegerValue(
      payload,
      'id_pagamento',
      orderRecord.Condizione_di_Pagamento__c
    );
    putLineArrays(payload, orderRecord.OrderItems, documentType);
    return payload;
  }

  private static void putLineArrays(
    Map<String, Object> payload,
    List<OrderItem> orderLines,
    String documentType
  ) {
    List<Object> lineIds = new List<Object>();
    List<Object> lineTypes = new List<Object>();
    List<Object> articleCodes = new List<Object>();
    List<Object> quantities = new List<Object>();
    List<Object> prices = new List<Object>();
    List<Object> vatCodes = new List<Object>();
    List<Object> dueDates = new List<Object>();
    String vatCode = resolveVatCode(documentType);
    Integer lineNumber = 1;

    for (OrderItem line : orderLines) {
      lineIds.add(new List<Object>{ lineNumber, resolveLineId(line) });
      lineTypes.add(new List<Object>{ lineNumber, ARTICLE_LINE_TYPE });
      articleCodes.add(
        new List<Object>{ lineNumber, resolveProductCode(line) }
      );
      quantities.add(new List<Object>{ lineNumber, line.Quantity });
      prices.add(new List<Object>{ lineNumber, line.UnitPrice });
      vatCodes.add(new List<Object>{ lineNumber, vatCode });
      String dueDate = formatDate(line.Data_Scadenza__c);
      if (!String.isBlank(dueDate)) {
        dueDates.add(new List<Object>{ lineNumber, dueDate });
      }
      lineNumber++;
    }

    payload.put('id_riga', lineIds);
    payload.put('tp_riga', lineTypes);
    payload.put('codice_articolo', articleCodes);
    payload.put('quantita', quantities);
    payload.put('prezzo', prices);
    payload.put('cod_iva', vatCodes);
    if (!dueDates.isEmpty()) {
      payload.put('dt_sca_riga', dueDates);
    }
  }

  // id_riga is the OrderItem autonumber, so the line identity is known before
  // the send. Mexal keeps a numeric id_riga as sent (test 06/10, OC/10/9) and
  // rejects a non-numeric one; 0 lets Mexal number the lines by position.
  private static Long resolveLineId(OrderItem line) {
    return String.isBlank(line.OrderItemNumber)
      ? NEW_LINE_ID
      : Long.valueOf(line.OrderItemNumber);
  }

  private static String resolveVatCode(String documentType) {
    if (documentType == DEFAULT_DOCUMENT_TYPE) {
      return SERVICE_VAT_CODE;
    }
    if (documentType == BOOK_DOCUMENT_TYPE) {
      return BOOK_VAT_CODE;
    }
    throw new MexalOrderSendException(
      'Codice IVA Mexal non configurato per la sigla ' + documentType + '.'
    );
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

  public static String resolveProductCode(OrderItem line) {
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
    result.mexalDocumentSerie = resolveDocumentSeries();
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

  private static Integer resolveDocumentSeries() {
    if (resolvedDocumentSeries == null) {
      Organization currentOrganization = [
        SELECT IsSandbox
        FROM Organization
        LIMIT 1
      ];
      resolvedDocumentSeries = currentOrganization.IsSandbox
        ? SANDBOX_SERIES
        : PRODUCTION_SERIES;
    }
    return resolvedDocumentSeries;
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
      if (headerName == 'location') {
        String numberFromLocation = findMexalOrderNumberInLocation(headerValue);
        if (!String.isBlank(numberFromLocation)) {
          return numberFromLocation;
        }
      }
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

  private static String findMexalOrderNumberInLocation(String location) {
    if (String.isBlank(location)) {
      return null;
    }

    String documentKey = location.trim();
    Integer queryIndex = documentKey.indexOf('?');
    if (queryIndex >= 0) {
      documentKey = documentKey.substring(0, queryIndex);
    }

    Integer slashIndex = documentKey.lastIndexOf('/');
    if (slashIndex >= 0) {
      documentKey = documentKey.substring(slashIndex + 1);
    }

    List<String> parts = documentKey.split('\\+');
    return parts.size() >= 3 ? parts[2].trim() : null;
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

  private static void putValue(
    Map<String, Object> payload,
    String fieldName,
    String value
  ) {
    payload.put(fieldName, String.isBlank(value) ? '' : value.trim());
  }

  private static void putIntegerValue(
    Map<String, Object> payload,
    String fieldName,
    String value
  ) {
    if (String.isBlank(value)) {
      return;
    }

    try {
      payload.put(fieldName, Integer.valueOf(value.trim()));
    } catch (Exception error) {
      throw new MexalOrderSendException(
        'Valore numerico non valido per ' + fieldName + ': ' + value
      );
    }
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
