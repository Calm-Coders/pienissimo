public with sharing class MexalOrderLineSyncService {
  private static final String ARTICLE_LINE_TYPE = 'R';

  public class Result {
    @AuraEnabled
    public Boolean aligned;
    @AuraEnabled
    public String message;
    @AuraEnabled
    public Integer linesUpdated;

    public Result() {
      aligned = false;
      linesUpdated = 0;
    }
  }

  public class MexalOrderLineSyncException extends Exception {
  }

  private class MexalLine {
    Integer position;
    Integer lineId;
    String articleCode;
    Decimal quantity;
  }

  // Reads the created document back from Mexal and stores the real id_riga
  // on each OrderItem. Lines are matched by position, the order in which
  // MexalOrderSendService sent them; article code and quantity must agree.
  public static Result syncOrderLines(Id orderId) {
    Order orderRecord = loadOrder(orderId);
    if (
      String.isBlank(orderRecord.Mexal_Document_Sigla__c) ||
      orderRecord.Mexal_Document_Serie__c == null ||
      orderRecord.Mexal_Document_Number__c == null
    ) {
      throw new MexalOrderLineSyncException(
        'Chiave documento Mexal mancante sull ordine.'
      );
    }

    MexalSearchCalloutService.Result calloutResult = MexalSearchCalloutService.getOrderDetail(
      orderRecord.Mexal_Document_Sigla__c,
      orderRecord.Mexal_Document_Serie__c.intValue(),
      orderRecord.Mexal_Document_Number__c.intValue()
    );
    if (calloutResult == null || calloutResult.success != true) {
      throw new MexalOrderLineSyncException(
        'Lettura righe ordine Mexal fallita' +
        (calloutResult == null ||
          calloutResult.statusCode == null
          ? '.'
          : ' (HTTP ' + calloutResult.statusCode + ').')
      );
    }

    List<MexalLine> mexalLines = parseArticleLines(calloutResult.body);
    List<OrderItem> orderLines = orderRecord.OrderItems;
    Result result = new Result();

    String mismatch = findMismatch(orderLines, mexalLines);
    if (mismatch != null) {
      result.message = mismatch;
      return result;
    }

    List<OrderItem> updates = new List<OrderItem>();
    for (Integer index = 0; index < orderLines.size(); index++) {
      updates.add(
        new OrderItem(
          Id = orderLines[index].Id,
          Mexal_Line_Number__c = mexalLines[index].lineId
        )
      );
    }
    update updates;

    result.aligned = true;
    result.linesUpdated = updates.size();
    result.message = 'Righe ordine Mexal allineate.';
    return result;
  }

  // Clears positional line numbers so that invoice and payment matching never
  // runs on a line identity Mexal did not confirm.
  public static void clearLineNumbers(Id orderId) {
    List<OrderItem> updates = new List<OrderItem>();
    for (OrderItem line : [
      SELECT Id
      FROM OrderItem
      WHERE OrderId = :orderId AND Mexal_Line_Number__c != NULL
    ]) {
      updates.add(new OrderItem(Id = line.Id, Mexal_Line_Number__c = null));
    }
    if (!updates.isEmpty()) {
      update updates;
    }
  }

  private static Order loadOrder(Id orderId) {
    return [
      SELECT
        Id,
        Mexal_Document_Sigla__c,
        Mexal_Document_Serie__c,
        Mexal_Document_Number__c,
        (
          SELECT
            Id,
            Quantity,
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

  private static String findMismatch(
    List<OrderItem> orderLines,
    List<MexalLine> mexalLines
  ) {
    if (orderLines.size() != mexalLines.size()) {
      return 'Numero righe diverso: Salesforce ' +
        orderLines.size() +
        ', Mexal ' +
        mexalLines.size() +
        '.';
    }

    for (Integer index = 0; index < orderLines.size(); index++) {
      OrderItem orderLine = orderLines[index];
      MexalLine mexalLine = mexalLines[index];
      Integer lineNumber = index + 1;

      if (mexalLine.lineId == null) {
        return 'Riga ' + lineNumber + ': id_riga Mexal mancante.';
      }

      String salesforceCode = normalize(
        MexalOrderSendService.resolveProductCode(orderLine)
      );
      if (salesforceCode != normalize(mexalLine.articleCode)) {
        return 'Riga ' +
          lineNumber +
          ': codice articolo diverso (Salesforce ' +
          salesforceCode +
          ', Mexal ' +
          normalize(mexalLine.articleCode) +
          ').';
      }

      if (
        orderLine.Quantity == null ||
        mexalLine.quantity == null ||
        orderLine.Quantity != mexalLine.quantity
      ) {
        return 'Riga ' +
          lineNumber +
          ': quantita diversa (Salesforce ' +
          orderLine.Quantity +
          ', Mexal ' +
          mexalLine.quantity +
          ').';
      }
    }

    return null;
  }

  private static List<MexalLine> parseArticleLines(String body) {
    Map<String, Object> detail = parseDetailBody(body);
    if (detail == null) {
      throw new MexalOrderLineSyncException(
        'Risposta dettaglio ordine Mexal non leggibile.'
      );
    }

    Map<Integer, Object> lineIds = indexValues(detail.get('id_riga'));
    Map<Integer, Object> lineTypes = indexValues(detail.get('tp_riga'));
    Map<Integer, Object> articleCodes = indexValues(
      detail.get('codice_articolo')
    );
    Map<Integer, Object> quantities = indexValues(detail.get('quantita'));

    List<Integer> positions = new List<Integer>(lineIds.keySet());
    positions.sort();

    List<MexalLine> lines = new List<MexalLine>();
    for (Integer position : positions) {
      Object lineType = lineTypes.get(position);
      if (
        lineType != null &&
        String.valueOf(lineType).trim() != ARTICLE_LINE_TYPE
      ) {
        continue;
      }

      MexalLine line = new MexalLine();
      line.position = position;
      line.lineId = parseInteger(lineIds.get(position));
      line.articleCode = articleCodes.get(position) == null
        ? null
        : String.valueOf(articleCodes.get(position));
      line.quantity = parseDecimal(quantities.get(position));
      lines.add(line);
    }

    return lines;
  }

  private static Map<String, Object> parseDetailBody(String body) {
    if (String.isBlank(body)) {
      return null;
    }

    Object decoded = JSON.deserializeUntyped(body);
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

  // Mexal returns line fields as [[position, value], ...].
  private static Map<Integer, Object> indexValues(Object value) {
    Map<Integer, Object> valuesByPosition = new Map<Integer, Object>();
    if (!(value instanceof List<Object>)) {
      return valuesByPosition;
    }

    for (Object row : (List<Object>) value) {
      if (!(row instanceof List<Object>)) {
        continue;
      }

      List<Object> indexedRow = (List<Object>) row;
      if (indexedRow.size() < 2) {
        continue;
      }

      Integer position = parseInteger(indexedRow[0]);
      if (position != null) {
        valuesByPosition.put(position, indexedRow[1]);
      }
    }

    return valuesByPosition;
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

  private static String normalize(String value) {
    return String.isBlank(value) ? '' : value.trim().toUpperCase();
  }
}
