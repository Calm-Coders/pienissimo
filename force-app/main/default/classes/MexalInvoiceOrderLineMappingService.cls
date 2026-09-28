public with sharing class MexalInvoiceOrderLineMappingService {
  private static final String PAYMENT_STATUS_PAID = 'Paid';
  private static final String PAYMENT_STATUS_UNPAID = 'Unpaid';
  private static final String PAYMENT_STATUS_NO_MATCH = 'No Payment Match';

  public class Result {
    @AuraEnabled
    public Integer invoiceLinesReturned;
    @AuraEnabled
    public Integer matchedLines;
    @AuraEnabled
    public Integer unmatchedLines;
    @AuraEnabled
    public Integer paidLines;
    @AuraEnabled
    public Integer unpaidLines;
    @AuraEnabled
    public Integer linesWithoutPaymentMatch;
    @AuraEnabled
    public Integer paymentStatusUpdates;
    @AuraEnabled
    public List<LineMapping> mappings;

    public Result() {
      invoiceLinesReturned = 0;
      matchedLines = 0;
      unmatchedLines = 0;
      paidLines = 0;
      unpaidLines = 0;
      linesWithoutPaymentMatch = 0;
      paymentStatusUpdates = 0;
      mappings = new List<LineMapping>();
    }
  }

  public class LineMapping {
    @AuraEnabled
    public String invoiceSigla;
    @AuraEnabled
    public Integer invoiceSerie;
    @AuraEnabled
    public Integer invoiceNumber;
    @AuraEnabled
    public Integer invoiceLineIndex;
    @AuraEnabled
    public String customerCode;
    @AuraEnabled
    public String orderSigla;
    @AuraEnabled
    public Integer orderSerie;
    @AuraEnabled
    public Integer orderNumber;
    @AuraEnabled
    public Integer orderLineNumber;
    @AuraEnabled
    public String articleCode;
    @AuraEnabled
    public Id orderId;
    @AuraEnabled
    public Id orderItemId;
    @AuraEnabled
    public Id trancheId;
    @AuraEnabled
    public Date orderItemDueDate;
    @AuraEnabled
    public Integer paymentDeadlineIndex;
    @AuraEnabled
    public Decimal paymentDeadlineAmount;
    @AuraEnabled
    public String paymentStatus;
    @AuraEnabled
    public Boolean paymentMatched;
    @AuraEnabled
    public Boolean paid;
    @AuraEnabled
    public Boolean matched;
  }

  private class OrderKey {
    String sigla;
    Integer serie;
    Integer numero;
    String customerCode;

    String value() {
      return String.join(
        new List<String>{
          normalize(sigla),
          String.valueOf(serie),
          String.valueOf(numero),
          normalize(customerCode)
        },
        '|'
      );
    }
  }

  public static Result mapInvoiceDetail(String detailBody) {
    return mapInvoiceDetail(
      detailBody,
      new List<MexalScadenzarioSearchService.ScadenzarioDocument>()
    );
  }

  public static Result mapInvoiceDetail(
    String detailBody,
    List<MexalScadenzarioSearchService.ScadenzarioDocument> scadenzarioDocuments
  ) {
    Result result = new Result();
    Map<String, Object> detail = parseDetailBody(detailBody);
    if (detail == null) {
      return result;
    }

    result.mappings = buildLineMappings(detail);
    result.invoiceLinesReturned = result.mappings.size();
    matchSalesforceLines(result.mappings);
    matchPaymentDeadlines(result.mappings, scadenzarioDocuments);

    for (LineMapping mapping : result.mappings) {
      if (mapping.matched == true) {
        result.matchedLines++;
      } else {
        result.unmatchedLines++;
      }

      if (mapping.paymentMatched != true) {
        result.linesWithoutPaymentMatch++;
      } else if (mapping.paid == true) {
        result.paidLines++;
      } else {
        result.unpaidLines++;
      }
    }

    return result;
  }

  private static List<LineMapping> buildLineMappings(
    Map<String, Object> detail
  ) {
    List<LineMapping> mappings = new List<LineMapping>();
    Set<Integer> lineIndexes = getLineIndexes(detail);

    for (Integer lineIndex : lineIndexes) {
      LineMapping mapping = new LineMapping();
      mapping.invoiceSigla = getString(detail, 'sigla');
      mapping.invoiceSerie = parseInteger(detail.get('serie'));
      mapping.invoiceNumber = parseInteger(detail.get('numero'));
      mapping.customerCode = getString(detail, 'cod_conto');
      mapping.invoiceLineIndex = lineIndex;
      mapping.orderSigla = firstNonBlank(
        getIndexedString(detail, 'sigla_ordine', lineIndex),
        getIndexedString(detail, 'sigla_doc_orig', lineIndex)
      );
      mapping.orderSerie = firstNonNull(
        parseInteger(getIndexedValue(detail, 'serie_ordine', lineIndex)),
        parseInteger(getIndexedValue(detail, 'serie_doc_orig', lineIndex))
      );
      mapping.orderNumber = firstNonNull(
        parseInteger(getIndexedValue(detail, 'numero_ordine', lineIndex)),
        parseInteger(getIndexedValue(detail, 'numero_doc_orig', lineIndex))
      );
      mapping.orderLineNumber = parseInteger(
        getIndexedValue(detail, 'id_riga_orig', lineIndex)
      );
      mapping.articleCode = getIndexedString(
        detail,
        'codice_articolo',
        lineIndex
      );
      mapping.matched = false;
      mapping.paymentMatched = false;
      mapping.paid = false;
      mappings.add(mapping);
    }

    return mappings;
  }

  private static void matchSalesforceLines(List<LineMapping> mappings) {
    if (mappings == null || mappings.isEmpty()) {
      return;
    }

    Set<String> siglas = new Set<String>();
    Set<Decimal> series = new Set<Decimal>();
    Set<Decimal> numbers = new Set<Decimal>();
    Set<String> customerCodes = new Set<String>();
    Set<Decimal> lineNumbers = new Set<Decimal>();

    for (LineMapping mapping : mappings) {
      if (!String.isBlank(mapping.orderSigla)) {
        siglas.add(mapping.orderSigla);
      }
      if (mapping.orderSerie != null) {
        series.add(Decimal.valueOf(mapping.orderSerie));
      }
      if (mapping.orderNumber != null) {
        numbers.add(Decimal.valueOf(mapping.orderNumber));
      }
      if (!String.isBlank(mapping.customerCode)) {
        customerCodes.add(mapping.customerCode);
      }
      if (mapping.orderLineNumber != null) {
        lineNumbers.add(Decimal.valueOf(mapping.orderLineNumber));
      }
    }

    if (
      siglas.isEmpty() ||
      series.isEmpty() ||
      numbers.isEmpty() ||
      customerCodes.isEmpty() ||
      lineNumbers.isEmpty()
    ) {
      return;
    }

    Map<String, Order> ordersByKey = new Map<String, Order>();
    Set<Id> orderIds = new Set<Id>();
    for (Order orderRecord : [
      SELECT
        Id,
        Mexal_Document_Sigla__c,
        Mexal_Document_Serie__c,
        Mexal_Document_Number__c,
        Mexal_Customer_Code__c
      FROM Order
      WHERE
        Mexal_Document_Sigla__c IN :siglas
        AND Mexal_Document_Serie__c IN :series
        AND Mexal_Document_Number__c IN :numbers
        AND Mexal_Customer_Code__c IN :customerCodes
    ]) {
      ordersByKey.put(buildOrderKey(orderRecord), orderRecord);
      orderIds.add(orderRecord.Id);
    }

    if (orderIds.isEmpty()) {
      return;
    }

    Map<String, OrderItem> orderItemsByKey = new Map<String, OrderItem>();
    for (OrderItem line : [
      SELECT Id, OrderId, Mexal_Line_Number__c, Tranche__c, Data_Scadenza__c
      FROM OrderItem
      WHERE OrderId IN :orderIds AND Mexal_Line_Number__c IN :lineNumbers
    ]) {
      orderItemsByKey.put(
        buildOrderLineKey(line.OrderId, line.Mexal_Line_Number__c),
        line
      );
    }

    for (LineMapping mapping : mappings) {
      Order orderRecord = ordersByKey.get(buildOrderKey(mapping));
      if (orderRecord == null || mapping.orderLineNumber == null) {
        continue;
      }

      OrderItem line = orderItemsByKey.get(
        buildOrderLineKey(orderRecord.Id, mapping.orderLineNumber)
      );
      if (line == null) {
        continue;
      }

      mapping.orderId = orderRecord.Id;
      mapping.orderItemId = line.Id;
      mapping.trancheId = line.Tranche__c;
      mapping.orderItemDueDate = line.Data_Scadenza__c;
      mapping.matched = true;
    }
  }

  private static void matchPaymentDeadlines(
    List<LineMapping> mappings,
    List<MexalScadenzarioSearchService.ScadenzarioDocument> scadenzarioDocuments
  ) {
    if (
      mappings == null ||
      mappings.isEmpty() ||
      scadenzarioDocuments == null ||
      scadenzarioDocuments.isEmpty()
    ) {
      return;
    }

    Map<String, MexalScadenzarioSearchService.PaymentDeadline> deadlinesByKey = new Map<String, MexalScadenzarioSearchService.PaymentDeadline>();
    for (
      MexalScadenzarioSearchService.ScadenzarioDocument document : scadenzarioDocuments
    ) {
      if (
        document == null ||
        document.serie == null ||
        document.numero == null ||
        String.isBlank(document.customerCode) ||
        document.deadlines == null
      ) {
        continue;
      }

      for (
        MexalScadenzarioSearchService.PaymentDeadline deadline : document.deadlines
      ) {
        if (deadline == null || deadline.dueDate == null) {
          continue;
        }

        deadlinesByKey.put(
          buildPaymentKey(
            document.customerCode,
            document.serie,
            document.numero,
            deadline.dueDate
          ),
          deadline
        );
      }
    }

    if (deadlinesByKey.isEmpty()) {
      return;
    }

    for (LineMapping mapping : mappings) {
      if (
        mapping.invoiceSerie == null ||
        mapping.invoiceNumber == null ||
        String.isBlank(mapping.customerCode) ||
        mapping.orderItemDueDate == null
      ) {
        continue;
      }

      MexalScadenzarioSearchService.PaymentDeadline deadline = deadlinesByKey.get(
        buildPaymentKey(
          mapping.customerCode,
          mapping.invoiceSerie,
          mapping.invoiceNumber,
          mapping.orderItemDueDate
        )
      );
      if (deadline == null) {
        continue;
      }

      mapping.paymentDeadlineIndex = deadline.rowIndex;
      mapping.paymentDeadlineAmount = deadline.amount;
      mapping.paymentStatus = deadline.paymentStatus;
      mapping.paymentMatched = true;
      mapping.paid = deadline.paid;
    }
  }

  public static Integer updateOrderItemPaymentStatuses(
    List<LineMapping> mappings
  ) {
    if (mappings == null || mappings.isEmpty()) {
      return 0;
    }

    Map<Id, String> statusByOrderItemId = new Map<Id, String>();
    for (LineMapping mapping : mappings) {
      if (
        mapping == null ||
        mapping.matched != true ||
        mapping.orderItemId == null
      ) {
        continue;
      }

      String newStatus = resolveOrderItemPaymentStatus(mapping);
      if (String.isBlank(newStatus)) {
        continue;
      }

      Id orderItemId = mapping.orderItemId;
      String existingStatus = statusByOrderItemId.get(orderItemId);
      statusByOrderItemId.put(
        orderItemId,
        chooseMoreCompleteStatus(existingStatus, newStatus)
      );
    }

    if (statusByOrderItemId.isEmpty()) {
      return 0;
    }

    List<OrderItem> updates = new List<OrderItem>();
    for (Id orderItemId : statusByOrderItemId.keySet()) {
      updates.add(
        new OrderItem(
          Id = orderItemId,
          Mexal_Payment_Status__c = statusByOrderItemId.get(orderItemId)
        )
      );
    }

    update updates;
    return updates.size();
  }

  private static String resolveOrderItemPaymentStatus(LineMapping mapping) {
    if (mapping.paymentMatched != true) {
      return PAYMENT_STATUS_NO_MATCH;
    }

    return mapping.paid == true ? PAYMENT_STATUS_PAID : PAYMENT_STATUS_UNPAID;
  }

  private static String chooseMoreCompleteStatus(
    String existingStatus,
    String newStatus
  ) {
    if (String.isBlank(existingStatus)) {
      return newStatus;
    }
    if (
      existingStatus == PAYMENT_STATUS_PAID ||
      newStatus == PAYMENT_STATUS_PAID
    ) {
      return PAYMENT_STATUS_PAID;
    }
    if (
      existingStatus == PAYMENT_STATUS_UNPAID ||
      newStatus == PAYMENT_STATUS_UNPAID
    ) {
      return PAYMENT_STATUS_UNPAID;
    }
    return PAYMENT_STATUS_NO_MATCH;
  }

  private static Map<String, Object> parseDetailBody(String detailBody) {
    if (String.isBlank(detailBody)) {
      return null;
    }

    Object decoded = JSON.deserializeUntyped(detailBody);
    if (!(decoded instanceof Map<String, Object>)) {
      return null;
    }

    Map<String, Object> response = (Map<String, Object>) decoded;
    Object dati = response.get('dati');
    if (
      dati instanceof List<Object> &&
      !((List<Object>) dati).isEmpty() &&
      ((List<Object>) dati)[0] instanceof Map<String, Object>
    ) {
      return (Map<String, Object>) ((List<Object>) dati)[0];
    }

    return response;
  }

  private static Set<Integer> getLineIndexes(Map<String, Object> detail) {
    Set<Integer> indexes = new Set<Integer>();
    for (
      String fieldName : new List<String>{
        'id_riga',
        'id_riga_orig',
        'codice_articolo',
        'numero_ordine',
        'numero_doc_orig'
      }
    ) {
      Object value = detail.get(fieldName);
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

  private static String buildOrderKey(Order orderRecord) {
    return String.join(
      new List<String>{
        normalize(orderRecord.Mexal_Document_Sigla__c),
        formatDecimalKey(orderRecord.Mexal_Document_Serie__c),
        formatDecimalKey(orderRecord.Mexal_Document_Number__c),
        normalize(orderRecord.Mexal_Customer_Code__c)
      },
      '|'
    );
  }

  private static String buildOrderKey(LineMapping mapping) {
    OrderKey key = new OrderKey();
    key.sigla = mapping.orderSigla;
    key.serie = mapping.orderSerie;
    key.numero = mapping.orderNumber;
    key.customerCode = mapping.customerCode;
    return key.value();
  }

  private static String buildOrderLineKey(Id orderId, Decimal lineNumber) {
    return String.valueOf(orderId) + '|' + formatDecimalKey(lineNumber);
  }

  private static String buildOrderLineKey(Id orderId, Integer lineNumber) {
    return String.valueOf(orderId) + '|' + String.valueOf(lineNumber);
  }

  private static String buildPaymentKey(
    String customerCode,
    Integer serie,
    Integer numero,
    Date dueDate
  ) {
    return String.join(
      new List<String>{
        normalize(customerCode),
        String.valueOf(serie),
        String.valueOf(numero),
        String.valueOf(dueDate)
      },
      '|'
    );
  }

  private static Object getIndexedValue(
    Map<String, Object> source,
    String fieldName,
    Integer lineIndex
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
      if (indexedRow.size() >= 2 && parseInteger(indexedRow[0]) == lineIndex) {
        return indexedRow[1];
      }
    }

    return null;
  }

  private static String getIndexedString(
    Map<String, Object> source,
    String fieldName,
    Integer lineIndex
  ) {
    Object value = getIndexedValue(source, fieldName, lineIndex);
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

  private static Integer firstNonNull(Integer firstValue, Integer secondValue) {
    return firstValue == null ? secondValue : firstValue;
  }

  private static String firstNonBlank(String firstValue, String secondValue) {
    return String.isBlank(firstValue) ? secondValue : firstValue;
  }

  private static String normalize(String value) {
    return String.isBlank(value) ? '' : value.trim();
  }

  private static String formatDecimalKey(Decimal value) {
    return value == null ? 'null' : String.valueOf(value.intValue());
  }
}
