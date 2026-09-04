public with sharing class OrderBigliettoTriggerHandler {
  private static final String CONFIRMED_STATUS = 'Incassato';
  private static final String INITIAL_TICKET_STATUS = 'Ordinato';
  private static final String TICKET_RECORD_TYPE_DEVELOPER_NAME = 'Ticket';
  private static Id ticketRecordTypeId;

  private class TicketGenerationException extends Exception {
  }

  public static void afterInsert(List<Order> newOrders) {
    AnticipayOrderAutomation.enqueueForFirstOrders(newOrders);
    createTicketsForConfirmedOrders(newOrders, null);
  }

  public static void afterUpdate(
    List<Order> newOrders,
    Map<Id, Order> oldOrderMap
  ) {
    createTicketsForConfirmedOrders(newOrders, oldOrderMap);
  }

  private static void createTicketsForConfirmedOrders(
    List<Order> orders,
    Map<Id, Order> oldOrderMap
  ) {
    Set<Id> confirmedOrderIds = new Set<Id>();

    for (Order orderRecord : orders) {
      Order oldOrder = oldOrderMap == null
        ? null
        : oldOrderMap.get(orderRecord.Id);

      if (
        orderRecord.Status == CONFIRMED_STATUS &&
        (oldOrder == null ||
        oldOrder.Status != CONFIRMED_STATUS)
      ) {
        confirmedOrderIds.add(orderRecord.Id);
      }
    }

    if (confirmedOrderIds.isEmpty()) {
      return;
    }

    List<OrderItem> orderLines = [
      SELECT
        Id,
        OrderId,
        Quantity,
        Product2Id,
        Product2.Name,
        Product2.Genera_Biglietto__c,
        Order.AccountId,
        Order.EffectiveDate
      FROM OrderItem
      WHERE OrderId IN :confirmedOrderIds
    ];

    if (orderLines.isEmpty()) {
      return;
    }

    Map<Id, List<BundleComponent__c>> componentsByBundleId = getComponentsByBundleId(
      orderLines
    );
    List<TicketSource> ticketSources = buildTicketSources(
      orderLines,
      componentsByBundleId
    );

    if (ticketSources.isEmpty()) {
      return;
    }

    assignCampaigns(ticketSources);

    Set<Id> orderItemIds = new Set<Id>();
    Set<Id> productIds = new Set<Id>();
    for (TicketSource source : ticketSources) {
      orderItemIds.add(source.orderItemId);
      productIds.add(source.productId);
    }

    Map<String, Integer> existingTicketCounts = new Map<String, Integer>();
    for (AggregateResult result : [
      SELECT
        Order_Product__c orderLineId,
        Product2Id productId,
        COUNT(Id) ticketCount
      FROM Asset
      WHERE Order_Product__c IN :orderItemIds AND Product2Id IN :productIds
      GROUP BY Order_Product__c, Product2Id
    ]) {
      existingTicketCounts.put(
        ticketKey((Id) result.get('orderLineId'), (Id) result.get('productId')),
        (Integer) result.get('ticketCount')
      );
    }

    List<Asset> ticketsToInsert = new List<Asset>();
    Id assetTicketRecordTypeId = getTicketRecordTypeId();

    for (TicketSource source : ticketSources) {
      Integer existingTicketCount = existingTicketCounts.containsKey(
          ticketKey(source.orderItemId, source.productId)
        )
        ? existingTicketCounts.get(
            ticketKey(source.orderItemId, source.productId)
          )
        : 0;

      for (
        Integer sequence = existingTicketCount + 1;
        sequence <= source.quantity;
        sequence++
      ) {
        ticketsToInsert.add(
          new Asset(
            Name = buildTicketName(source.productName, sequence),
            RecordTypeId = assetTicketRecordTypeId,
            Status = INITIAL_TICKET_STATUS,
            AccountId = source.accountId,
            Product2Id = source.productId,
            Campaign__c = source.campaignId,
            Order_Product__c = source.orderItemId,
            Fattura_Pagata__c = false
          )
        );
      }
    }

    if (!ticketsToInsert.isEmpty()) {
      insert ticketsToInsert;
    }
  }

  private static Map<Id, List<BundleComponent__c>> getComponentsByBundleId(
    List<OrderItem> orderLines
  ) {
    Set<Id> productIds = new Set<Id>();
    for (OrderItem line : orderLines) {
      if (line.Product2Id != null) {
        productIds.add(line.Product2Id);
      }
    }

    Map<Id, List<BundleComponent__c>> componentsByBundleId = new Map<Id, List<BundleComponent__c>>();
    if (productIds.isEmpty()) {
      return componentsByBundleId;
    }

    for (BundleComponent__c component : [
      SELECT
        Bundle__c,
        Product__c,
        Product__r.Name,
        Product__r.Genera_Biglietto__c,
        Quantity__c
      FROM BundleComponent__c
      WHERE Bundle__c IN :productIds
    ]) {
      if (!componentsByBundleId.containsKey(component.Bundle__c)) {
        componentsByBundleId.put(
          component.Bundle__c,
          new List<BundleComponent__c>()
        );
      }

      componentsByBundleId.get(component.Bundle__c).add(component);
    }

    return componentsByBundleId;
  }

  private static List<TicketSource> buildTicketSources(
    List<OrderItem> orderLines,
    Map<Id, List<BundleComponent__c>> componentsByBundleId
  ) {
    List<TicketSource> sources = new List<TicketSource>();

    for (OrderItem line : orderLines) {
      Integer orderQuantity = wholeNumber(line.Quantity);
      if (
        orderQuantity <= 0 ||
        line.Product2Id == null ||
        line.Order == null ||
        line.Order.AccountId == null
      ) {
        continue;
      }

      List<BundleComponent__c> components = componentsByBundleId.get(
        line.Product2Id
      );

      if (components != null && !components.isEmpty()) {
        for (BundleComponent__c component : components) {
          if (
            component.Product__c == null ||
            component.Product__r == null ||
            component.Product__r.Genera_Biglietto__c != true
          ) {
            continue;
          }

          Integer componentQuantity = wholeNumber(component.Quantity__c);
          if (componentQuantity <= 0) {
            continue;
          }

          sources.add(
            new TicketSource(
              line.Id,
              line.Order.AccountId,
              line.Order.EffectiveDate,
              component.Product__c,
              component.Product__r.Name,
              orderQuantity * componentQuantity
            )
          );
        }

        continue;
      }

      if (line.Product2.Genera_Biglietto__c == true) {
        sources.add(
          new TicketSource(
            line.Id,
            line.Order.AccountId,
            line.Order.EffectiveDate,
            line.Product2Id,
            line.Product2.Name,
            orderQuantity
          )
        );
      }
    }

    return sources;
  }

  private static void assignCampaigns(List<TicketSource> ticketSources) {
    Set<Id> productIds = new Set<Id>();
    Date minOrderDate;
    Date maxOrderDate;

    for (TicketSource source : ticketSources) {
      if (source.productId != null) {
        productIds.add(source.productId);
      }

      if (source.orderDate == null) {
        throw new TicketGenerationException(
          'Data ordine mancante: impossibile determinare la campagna del biglietto.'
        );
      }

      minOrderDate = minOrderDate == null ||
        source.orderDate < minOrderDate
        ? source.orderDate
        : minOrderDate;
      maxOrderDate = maxOrderDate == null ||
        source.orderDate > maxOrderDate
        ? source.orderDate
        : maxOrderDate;
    }

    if (productIds.isEmpty()) {
      return;
    }

    List<Mappatura_Edizione__c> mappings = [
      SELECT Prodotto__c, Data_Inizio__c, Data_Fine__c, Campagna__c
      FROM Mappatura_Edizione__c
      WHERE
        Attiva__c = TRUE
        AND Prodotto__c IN :productIds
        AND Data_Inizio__c <= :maxOrderDate
        AND Data_Fine__c >= :minOrderDate
    ];

    for (TicketSource source : ticketSources) {
      List<Mappatura_Edizione__c> matches = new List<Mappatura_Edizione__c>();

      for (Mappatura_Edizione__c mapping : mappings) {
        if (
          mapping.Prodotto__c == source.productId &&
          mapping.Data_Inizio__c <= source.orderDate &&
          mapping.Data_Fine__c >= source.orderDate
        ) {
          matches.add(mapping);
        }
      }

      if (matches.isEmpty()) {
        throw new TicketGenerationException(
          'Nessuna mappatura edizione trovata per il prodotto ' +
            source.productName +
            ' alla data ordine ' +
            String.valueOf(source.orderDate) +
            '.'
        );
      }

      if (matches.size() > 1) {
        throw new TicketGenerationException(
          'Mappature edizione sovrapposte per il prodotto ' +
            source.productName +
            ' alla data ordine ' +
            String.valueOf(source.orderDate) +
            '.'
        );
      }

      source.campaignId = matches[0].Campagna__c;
    }
  }

  private static Integer wholeNumber(Decimal value) {
    return value == null ? 0 : value.intValue();
  }

  private static String ticketKey(Id orderItemId, Id productId) {
    return String.valueOf(orderItemId) + ':' + String.valueOf(productId);
  }

  private class TicketSource {
    private Id orderItemId;
    private Id accountId;
    private Date orderDate;
    private Id productId;
    private String productName;
    private Integer quantity;
    private Id campaignId;

    private TicketSource(
      Id orderItemId,
      Id accountId,
      Date orderDate,
      Id productId,
      String productName,
      Integer quantity
    ) {
      this.orderItemId = orderItemId;
      this.accountId = accountId;
      this.orderDate = orderDate;
      this.productId = productId;
      this.productName = productName;
      this.quantity = quantity;
    }
  }

  private static String buildTicketName(String productName, Integer sequence) {
    String safeProductName = String.isBlank(productName)
      ? 'Biglietto'
      : productName;

    String name = safeProductName + ' #' + String.valueOf(sequence);
    return name.length() > 80 ? name.substring(0, 80) : name;
  }

  private static Id getTicketRecordTypeId() {
    if (ticketRecordTypeId == null) {
      List<RecordType> recordTypes = [
        SELECT Id
        FROM RecordType
        WHERE
          SObjectType = 'Asset'
          AND DeveloperName = :TICKET_RECORD_TYPE_DEVELOPER_NAME
        LIMIT 1
      ];

      ticketRecordTypeId = recordTypes.isEmpty() ? null : recordTypes[0].Id;
    }

    return ticketRecordTypeId;
  }
}
