// Reads the Mexal detail of each Fattura__c and upserts its Riga_Fattura__c,
// then links invoice -> order and order line -> invoice.
// Mexal omits repeated or empty values in row arrays: the order reference sits
// on the first row of its block and applies to the rows that follow, and a
// zero price is not returned at all.
public without sharing class MexalInvoiceLineImportBatch implements Database.Batchable<SObject>, Database.AllowsCallouts {
  // One detail callout per invoice; stays well inside the 100-callout limit.
  public static final Integer SCOPE_SIZE = 50;
  private static final String ORDER_SIGLA = 'OC';

  private final Boolean onlyWithoutLines;
  private final Set<Id> invoiceIds;
  private final Boolean continueWithScadenzario;

  public MexalInvoiceLineImportBatch(Boolean onlyWithoutLines) {
    this.onlyWithoutLines = onlyWithoutLines == true;
    this.invoiceIds = null;
    this.continueWithScadenzario = false;
  }

  // Nightly sync (MexalInvoiceSyncJob): the given invoices, then the
  // scadenzario step when continueWithScadenzario is true.
  public MexalInvoiceLineImportBatch(
    Set<Id> invoiceIds,
    Boolean continueWithScadenzario
  ) {
    this.onlyWithoutLines = false;
    this.invoiceIds = invoiceIds == null ? new Set<Id>() : invoiceIds;
    this.continueWithScadenzario = continueWithScadenzario == true;
  }

  public Database.QueryLocator start(Database.BatchableContext context) {
    if (invoiceIds != null) {
      return Database.getQueryLocator(
        [
          SELECT
            Id,
            Chiave_Mexal__c,
            Sigla__c,
            Serie__c,
            Numero__c,
            Codice_Cliente_Mexal__c,
            Account__c
          FROM Fattura__c
          WHERE Id IN :invoiceIds
        ]
      );
    }
    if (onlyWithoutLines) {
      return Database.getQueryLocator(
        [
          SELECT
            Id,
            Chiave_Mexal__c,
            Sigla__c,
            Serie__c,
            Numero__c,
            Codice_Cliente_Mexal__c,
            Account__c
          FROM Fattura__c
          WHERE Id NOT IN (SELECT Fattura__c FROM Riga_Fattura__c)
        ]
      );
    }
    return Database.getQueryLocator(
      [
        SELECT
          Id,
          Chiave_Mexal__c,
          Sigla__c,
          Serie__c,
          Numero__c,
          Codice_Cliente_Mexal__c,
          Account__c
        FROM Fattura__c
      ]
    );
  }

  public void execute(
    Database.BatchableContext context,
    List<Fattura__c> invoices
  ) {
    importLines(invoices);
  }

  public void finish(Database.BatchableContext context) {
    if (continueWithScadenzario) {
      System.enqueueJob(
        new MexalInvoiceSyncJob(MexalInvoiceSyncJob.STEP_SCADENZARIO)
      );
    }
  }

  private class InvoiceLine {
    Integer rowIndex;
    Integer lineId;
    String lineType;
    String articleCode;
    String description;
    Decimal quantity;
    Decimal price;
    String vatCode;
    String orderKey;
    String originSigla;
    String originKey;
    Integer originLineId;
  }

  public static void importLines(List<Fattura__c> invoices) {
    List<Integration_Log__c> errorLogs = new List<Integration_Log__c>();
    Map<Id, List<InvoiceLine>> linesByInvoiceId = new Map<Id, List<InvoiceLine>>();
    Map<Id, Decimal> totalByInvoiceId = new Map<Id, Decimal>();

    // All callouts first: no DML may precede a callout in the transaction.
    for (Fattura__c invoice : invoices) {
      if (
        String.isBlank(invoice.Sigla__c) ||
        invoice.Serie__c == null ||
        invoice.Numero__c == null ||
        String.isBlank(invoice.Codice_Cliente_Mexal__c)
      ) {
        continue;
      }
      MexalSearchCalloutService.Result detail;
      try {
        detail = MexalSearchCalloutService.getMovementDetail(
          invoice.Sigla__c,
          invoice.Serie__c.intValue(),
          invoice.Numero__c.intValue(),
          invoice.Codice_Cliente_Mexal__c,
          false
        );
      } catch (Exception error) {
        errorLogs.add(
          errorLog(
            'Dettaglio fattura ' +
              invoice.Chiave_Mexal__c +
              ': ' +
              error.getMessage()
          )
        );
        continue;
      }
      if (detail == null || detail.success != true) {
        if (detail != null) {
          errorLogs.addAll(detail.integrationLogs);
        }
        continue;
      }
      Map<String, Object> body = parseDetail(detail.body);
      if (body == null) {
        continue;
      }
      linesByInvoiceId.put(invoice.Id, parseLines(body));
      Decimal total = parseDecimal(
        firstIndexedValue(body.get('tot_documento'))
      );
      if (total != null) {
        totalByInvoiceId.put(invoice.Id, total);
      }
    }

    Map<Id, Fattura__c> invoicesById = new Map<Id, Fattura__c>(invoices);
    Set<String> orderKeys = new Set<String>();
    Set<String> articleCodes = new Set<String>();
    for (List<InvoiceLine> lines : linesByInvoiceId.values()) {
      for (InvoiceLine line : lines) {
        if (line.orderKey != null) {
          orderKeys.add(line.orderKey);
        }
        if (!String.isBlank(line.articleCode)) {
          articleCodes.add(line.articleCode);
        }
      }
    }

    Map<String, Id> productIdByCode = new Map<String, Id>();
    for (Product2 product : [
      SELECT Id, External_Product_Code__c
      FROM Product2
      WHERE External_Product_Code__c IN :articleCodes
    ]) {
      productIdByCode.put(
        normalize(product.External_Product_Code__c),
        product.Id
      );
    }

    Map<String, Order> ordersByKey = new Map<String, Order>();
    if (!orderKeys.isEmpty()) {
      for (Order orderRecord : [
        SELECT
          Id,
          AccountId,
          ID_Ordine_Mexal__c,
          (
            SELECT
              Id,
              Quantity,
              Mexal_Line_Number__c,
              Data_Scadenza__c,
              Product2.ProductCode,
              Product2.External_Product_Code__c
            FROM OrderItems
            ORDER BY Mexal_Line_Number__c
          )
        FROM Order
        WHERE ID_Ordine_Mexal__c IN :orderKeys
      ]) {
        ordersByKey.put(normalize(orderRecord.ID_Ordine_Mexal__c), orderRecord);
      }
    }

    // Rates already imported for these invoices, to pay each matched order line.
    Map<Id, List<Scadenza_Fattura__c>> deadlinesByInvoiceId = new Map<Id, List<Scadenza_Fattura__c>>();
    for (Scadenza_Fattura__c deadline : [
      SELECT Id, Fattura__c, Data_Scadenza__c, Pagata__c
      FROM Scadenza_Fattura__c
      WHERE Fattura__c IN :linesByInvoiceId.keySet()
    ]) {
      if (!deadlinesByInvoiceId.containsKey(deadline.Fattura__c)) {
        deadlinesByInvoiceId.put(
          deadline.Fattura__c,
          new List<Scadenza_Fattura__c>()
        );
      }
      deadlinesByInvoiceId.get(deadline.Fattura__c).add(deadline);
    }

    List<Riga_Fattura__c> lineRecords = new List<Riga_Fattura__c>();
    Map<Id, Fattura__c> invoiceUpdates = new Map<Id, Fattura__c>();
    Map<Id, OrderItem> orderItemUpdates = new Map<Id, OrderItem>();
    Set<Id> usedOrderItemIds = new Set<Id>();

    for (Id invoiceId : linesByInvoiceId.keySet()) {
      Fattura__c invoice = invoicesById.get(invoiceId);
      Fattura__c invoiceUpdate = new Fattura__c(Id = invoiceId);
      if (totalByInvoiceId.containsKey(invoiceId)) {
        invoiceUpdate.Totale_Documento__c = totalByInvoiceId.get(invoiceId);
      }
      // Distinct Mexal order keys, in row order.
      List<String> invoiceOrderKeys = new List<String>();

      for (InvoiceLine line : linesByInvoiceId.get(invoiceId)) {
        if (
          line.orderKey != null && !invoiceOrderKeys.contains(line.orderKey)
        ) {
          invoiceOrderKeys.add(line.orderKey);
        }
        Order orderRecord = line.orderKey == null
          ? null
          : ordersByKey.get(line.orderKey);
        OrderItem orderLine = orderRecord == null
          ? null
          : matchOrderLine(orderRecord, line, usedOrderItemIds);

        lineRecords.add(
          new Riga_Fattura__c(
            Fattura__c = invoiceId,
            Chiave_Mexal__c = invoice.Chiave_Mexal__c + '+' + line.lineId,
            ID_Riga_Mexal__c = line.lineId,
            Tipo_Riga__c = line.lineType,
            Codice_Articolo__c = truncate(line.articleCode, 80),
            Prodotto__c = productIdByCode.get(normalize(line.articleCode)),
            Descrizione__c = truncate(line.description, 255),
            Quantita__c = line.quantity,
            Prezzo__c = line.price,
            Codice_IVA__c = truncate(line.vatCode, 20),
            Riferimento_Ordine_Mexal__c = line.orderKey,
            Documento_Origine__c = line.originKey,
            ID_Riga_Origine__c = line.originLineId,
            Ordine__c = orderRecord == null ? null : orderRecord.Id,
            Riga_Ordine__c = orderLine == null ? null : orderLine.Id
          )
        );

        // The invoice takes the Account of its order.
        if (orderRecord != null && invoiceUpdate.Ordine__c == null) {
          invoiceUpdate.Ordine__c = orderRecord.Id;
          invoiceUpdate.Account__c = orderRecord.AccountId;
        }
        if (orderLine != null) {
          Scadenza_Fattura__c deadline = MexalInvoiceImportService.matchDeadline(
            deadlinesByInvoiceId.get(invoiceId),
            orderLine.Data_Scadenza__c
          );
          OrderItem orderItemUpdate = new OrderItem(
            Id = orderLine.Id,
            Fattura__c = invoiceId,
            Scadenza_Fattura__c = deadline == null ? null : deadline.Id
          );
          // The line's payment state follows its Mexal rate; the tranche
          // follows its lines (OrderItemTriggerHandler).
          orderItemUpdate.Mexal_Payment_Status__c = deadline == null
            ? 'Invoiced'
            : (deadline.Pagata__c ? 'Paid' : 'Unpaid');
          orderItemUpdates.put(orderLine.Id, orderItemUpdate);
        }
      }
      invoiceUpdate.Riferimento_Ordine_Mexal__c = invoiceOrderKeys.isEmpty()
        ? null
        : truncate(String.join(invoiceOrderKeys, ', '), 255);
      invoiceUpdates.put(invoiceId, invoiceUpdate);
    }

    // The scadenzario carries no order reference: each due date takes its
    // invoice's Mexal order keys and Salesforce order.
    List<Scadenza_Fattura__c> deadlineUpdates = new List<Scadenza_Fattura__c>();
    for (Scadenza_Fattura__c deadline : [
      SELECT Id, Fattura__c
      FROM Scadenza_Fattura__c
      WHERE Fattura__c IN :invoiceUpdates.keySet()
    ]) {
      Fattura__c invoiceUpdate = invoiceUpdates.get(deadline.Fattura__c);
      Id accountId = invoiceUpdate.Account__c != null
        ? invoiceUpdate.Account__c
        : invoicesById.get(deadline.Fattura__c).Account__c;
      deadlineUpdates.add(
        new Scadenza_Fattura__c(
          Id = deadline.Id,
          Account__c = accountId,
          Riferimento_Ordine_Mexal__c = invoiceUpdate.Riferimento_Ordine_Mexal__c,
          Ordine__c = invoiceUpdate.Ordine__c
        )
      );
    }

    Database.upsert(lineRecords, Riga_Fattura__c.Chiave_Mexal__c, false);
    Database.update(invoiceUpdates.values(), false);
    Database.update(deadlineUpdates, false);
    Database.update(orderItemUpdates.values(), false);
    if (!errorLogs.isEmpty()) {
      Database.insert(errorLogs, false);
    }
  }

  // Origin = the order: id_riga_orig is the order's id_riga. Otherwise (the
  // invoice is its own origin, as for file-imported orders) match the first
  // unused order line with the same article and quantity.
  private static OrderItem matchOrderLine(
    Order orderRecord,
    InvoiceLine line,
    Set<Id> usedOrderItemIds
  ) {
    if (line.originSigla == ORDER_SIGLA && line.originLineId != null) {
      for (OrderItem orderLine : orderRecord.OrderItems) {
        if (orderLine.Mexal_Line_Number__c == line.originLineId) {
          usedOrderItemIds.add(orderLine.Id);
          return orderLine;
        }
      }
    }
    for (OrderItem orderLine : orderRecord.OrderItems) {
      if (usedOrderItemIds.contains(orderLine.Id)) {
        continue;
      }
      String code = String.isBlank(orderLine.Product2.External_Product_Code__c)
        ? orderLine.Product2.ProductCode
        : orderLine.Product2.External_Product_Code__c;
      if (
        normalize(code) == normalize(line.articleCode) &&
        orderLine.Quantity == line.quantity
      ) {
        usedOrderItemIds.add(orderLine.Id);
        return orderLine;
      }
    }
    return null;
  }

  private static List<InvoiceLine> parseLines(Map<String, Object> body) {
    Map<Integer, Object> lineIds = indexValues(body.get('id_riga'));
    Map<Integer, Object> lineTypes = indexValues(body.get('tp_riga'));
    Map<Integer, Object> codes = indexValues(body.get('codice_articolo'));
    Map<Integer, Object> descriptions = indexValues(body.get('descr_articolo'));
    Map<Integer, Object> quantities = indexValues(body.get('quantita'));
    Map<Integer, Object> prices = indexValues(body.get('prezzo'));
    Map<Integer, Object> vatCodes = indexValues(body.get('cod_iva'));
    Map<Integer, Object> orderSiglas = indexValues(body.get('sigla_ordine'));
    Map<Integer, Object> orderSeries = indexValues(body.get('serie_ordine'));
    Map<Integer, Object> orderNumbers = indexValues(body.get('numero_ordine'));
    Map<Integer, Object> originSiglas = indexValues(body.get('sigla_doc_orig'));
    Map<Integer, Object> originSeries = indexValues(body.get('serie_doc_orig'));
    Map<Integer, Object> originNumbers = indexValues(
      body.get('numero_doc_orig')
    );
    Map<Integer, Object> originLineIds = indexValues(body.get('id_riga_orig'));

    List<Integer> rowIndexes = new List<Integer>(lineIds.keySet());
    rowIndexes.sort();

    List<InvoiceLine> lines = new List<InvoiceLine>();
    String currentOrderKey;
    String currentOriginSigla;
    String currentOriginKey;
    for (Integer rowIndex : rowIndexes) {
      if (
        orderSiglas.containsKey(rowIndex) || orderNumbers.containsKey(rowIndex)
      ) {
        currentOrderKey = documentKey(
          orderSiglas.get(rowIndex),
          orderSeries.get(rowIndex),
          orderNumbers.get(rowIndex)
        );
      }
      if (
        originSiglas.containsKey(rowIndex) ||
        originNumbers.containsKey(rowIndex)
      ) {
        currentOriginSigla = asString(originSiglas.get(rowIndex));
        currentOriginKey = documentKey(
          originSiglas.get(rowIndex),
          originSeries.get(rowIndex),
          originNumbers.get(rowIndex)
        );
      }

      InvoiceLine line = new InvoiceLine();
      line.rowIndex = rowIndex;
      line.lineId = parseInteger(lineIds.get(rowIndex));
      line.lineType = asString(lineTypes.get(rowIndex));
      line.articleCode = asString(codes.get(rowIndex));
      line.description = asString(descriptions.get(rowIndex));
      line.quantity = parseDecimal(quantities.get(rowIndex));
      Decimal price = parseDecimal(prices.get(rowIndex));
      line.price = price == null ? 0 : price;
      line.vatCode = asString(vatCodes.get(rowIndex));
      line.orderKey = currentOrderKey;
      line.originSigla = currentOriginSigla == null
        ? null
        : currentOriginSigla.trim().toUpperCase();
      line.originKey = currentOriginKey;
      line.originLineId = parseInteger(originLineIds.get(rowIndex));
      lines.add(line);
    }
    return lines;
  }

  private static String documentKey(Object sigla, Object serie, Object numero) {
    String siglaValue = asString(sigla);
    Integer numberValue = parseInteger(numero);
    if (String.isBlank(siglaValue) || numberValue == null || numberValue == 0) {
      return null;
    }
    Integer serieValue = parseInteger(serie);
    return siglaValue.trim().toUpperCase() +
      '+' +
      (serieValue == null ? 0 : serieValue) +
      '+' +
      numberValue;
  }

  private static Map<String, Object> parseDetail(String body) {
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

  private static Object firstIndexedValue(Object value) {
    Map<Integer, Object> values = indexValues(value);
    if (values.isEmpty()) {
      return value instanceof List<Object> ? null : value;
    }
    List<Integer> indexes = new List<Integer>(values.keySet());
    indexes.sort();
    return values.get(indexes[0]);
  }

  private static Integration_Log__c errorLog(String message) {
    return new Integration_Log__c(
      Flow_Name__c = 'Mexal_Fatture_Righe',
      Inbound_Outbound__c = 'Inbound',
      Is_Error__c = true,
      Exception_Message__c = truncate(message, 32000)
    );
  }

  private static String asString(Object value) {
    return value == null ? null : String.valueOf(value).trim();
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

  private static String truncate(String value, Integer maxLength) {
    if (value == null) {
      return null;
    }
    return value.length() > maxLength ? value.substring(0, maxLength) : value;
  }
}
