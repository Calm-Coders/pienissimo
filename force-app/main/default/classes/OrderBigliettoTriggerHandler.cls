public with sharing class OrderBigliettoTriggerHandler {
  private static final String ACTIVATED_STATUS = 'Activated';
  private static final String INITIAL_TICKET_STATUS = 'Caricato';

  public static void afterInsert(List<Order> newOrders) {
    createTicketsForActivatedOrders(newOrders, null);
  }

  public static void afterUpdate(
    List<Order> newOrders,
    Map<Id, Order> oldOrderMap
  ) {
    createTicketsForActivatedOrders(newOrders, oldOrderMap);
  }

  private static void createTicketsForActivatedOrders(
    List<Order> orders,
    Map<Id, Order> oldOrderMap
  ) {
    Set<Id> activatedOrderIds = new Set<Id>();

    for (Order orderRecord : orders) {
      Order oldOrder = oldOrderMap == null
        ? null
        : oldOrderMap.get(orderRecord.Id);

      if (
        orderRecord.Status == ACTIVATED_STATUS &&
        (oldOrder == null || oldOrder.Status != ACTIVATED_STATUS)
      ) {
        activatedOrderIds.add(orderRecord.Id);
      }
    }

    if (activatedOrderIds.isEmpty()) {
      return;
    }

    List<OrderItem> orderLines = [
      SELECT
        Id,
        OrderId,
        Quantity,
        Product2Id,
        Product2.Name,
        Product2.Genera_Biglietto__c
      FROM OrderItem
      WHERE OrderId IN :activatedOrderIds
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

    Set<Id> orderItemIds = new Set<Id>();
    Set<Id> productIds = new Set<Id>();
    for (TicketSource source : ticketSources) {
      orderItemIds.add(source.orderItemId);
      productIds.add(source.productId);
    }

    Map<String, Integer> existingTicketCounts = new Map<String, Integer>();
    for (AggregateResult result : [
      SELECT Order_Product__c orderLineId, Product__c productId, COUNT(Id) ticketCount
      FROM Biglietto__c
      WHERE Order_Product__c IN :orderItemIds AND Product__c IN :productIds
      GROUP BY Order_Product__c, Product__c
    ]) {
      existingTicketCounts.put(
        ticketKey(
          (Id) result.get('orderLineId'),
          (Id) result.get('productId')
        ),
        (Integer) result.get('ticketCount')
      );
    }

    List<Biglietto__c> ticketsToInsert = new List<Biglietto__c>();

    for (TicketSource source : ticketSources) {
      Integer existingTicketCount = existingTicketCounts.containsKey(
          ticketKey(source.orderItemId, source.productId)
        )
        ? existingTicketCounts.get(ticketKey(source.orderItemId, source.productId))
        : 0;

      for (
        Integer sequence = existingTicketCount + 1;
        sequence <= source.quantity;
        sequence++
      ) {
        ticketsToInsert.add(
          new Biglietto__c(
            Name = buildTicketName(source.productName, sequence),
            Status__c = INITIAL_TICKET_STATUS,
            Product__c = source.productId,
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
      if (orderQuantity <= 0 || line.Product2Id == null) {
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
            line.Product2Id,
            line.Product2.Name,
            orderQuantity
          )
        );
      }
    }

    return sources;
  }

  private static Integer wholeNumber(Decimal value) {
    return value == null ? 0 : value.intValue();
  }

  private static String ticketKey(Id orderItemId, Id productId) {
    return String.valueOf(orderItemId) + ':' + String.valueOf(productId);
  }

  private class TicketSource {
    private Id orderItemId;
    private Id productId;
    private String productName;
    private Integer quantity;

    private TicketSource(
      Id orderItemId,
      Id productId,
      String productName,
      Integer quantity
    ) {
      this.orderItemId = orderItemId;
      this.productId = productId;
      this.productName = productName;
      this.quantity = quantity;
    }
  }

  private static String buildTicketName(String productName, Integer sequence) {
    String safeProductName = String.isBlank(productName) ? 'Biglietto' : productName;

    String name = safeProductName + ' #' + String.valueOf(sequence);
    return name.length() > 80 ? name.substring(0, 80) : name;
  }
}
