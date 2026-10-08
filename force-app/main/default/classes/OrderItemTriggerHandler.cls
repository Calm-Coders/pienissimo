public without sharing class OrderItemTriggerHandler {
  private static final String PAYMENT_STATUS_PAID = 'Paid';
  private static final String TRANCHE_STATUS_OPEN = 'Aperta';
  private static final String TRANCHE_STATUS_PARTIAL = 'Parzialmente Pagata';
  private static final String TRANCHE_STATUS_PAID = 'Pagata';
  private static final String TICKET_RECORD_TYPE_DEVELOPER_NAME = 'Ticket';
  private static final String TICKET_STATUS_ORDERED = 'Ordinato';
  private static final String TICKET_STATUS_AVAILABLE = 'Disponibile';
  private static final String ORDER_STATUS_COLLECTED = 'Incassato';

  public static void afterInsert(List<OrderItem> newLines) {
    OrderTriggerHandler.createTicketsForOrderLines(newLines);
  }

  public static void afterUpdate(
    List<OrderItem> newLines,
    Map<Id, OrderItem> oldLineMap
  ) {
    Set<Id> trancheIds = new Set<Id>();
    Set<Id> contractOrderIds = new Set<Id>();

    for (OrderItem line : newLines) {
      OrderItem oldLine = oldLineMap == null ? null : oldLineMap.get(line.Id);
      if (oldLine == null) {
        continue;
      }

      if (
        line.Mexal_Payment_Status__c != oldLine.Mexal_Payment_Status__c ||
        line.TotalPrice != oldLine.TotalPrice ||
        line.Data_Scadenza__c != oldLine.Data_Scadenza__c
      ) {
        contractOrderIds.add(line.OrderId);
      }

      if (
        line.Tranche__c != oldLine.Tranche__c ||
        line.Mexal_Payment_Status__c != oldLine.Mexal_Payment_Status__c ||
        line.Fattura__c != oldLine.Fattura__c ||
        line.Scadenza_Fattura__c != oldLine.Scadenza_Fattura__c
      ) {
        if (line.Tranche__c != null) {
          trancheIds.add(line.Tranche__c);
        }
        if (oldLine.Tranche__c != null) {
          trancheIds.add(oldLine.Tranche__c);
        }
      }
    }

    recalculateTranches(trancheIds);
    PerformancePlusContractService.refreshAmounts(contractOrderIds);
  }

  private static void recalculateTranches(Set<Id> trancheIds) {
    if (trancheIds == null || trancheIds.isEmpty()) {
      return;
    }

    Map<Id, TrancheRollup> rollupsByTrancheId = new Map<Id, TrancheRollup>();
    for (Id trancheId : trancheIds) {
      rollupsByTrancheId.put(trancheId, new TrancheRollup());
    }

    for (OrderItem line : [
      SELECT
        Id,
        Tranche__c,
        Mexal_Payment_Status__c,
        Data_Scadenza__c,
        Fattura__c,
        Scadenza_Fattura__r.Data_Scadenza__c
      FROM OrderItem
      WHERE Tranche__c IN :trancheIds
    ]) {
      TrancheRollup rollup = rollupsByTrancheId.get(line.Tranche__c);
      if (rollup == null) {
        continue;
      }

      rollup.totalLines++;
      if (line.Mexal_Payment_Status__c == PAYMENT_STATUS_PAID) {
        rollup.paidLines++;
        continue;
      }

      // An open line is either still to invoice, or invoiced with a due date:
      // the Mexal rate's date, else the line's own.
      if (line.Fattura__c == null) {
        rollup.linesToInvoice++;
        continue;
      }
      Date dueDate = line.Scadenza_Fattura__r != null &&
        line.Scadenza_Fattura__r.Data_Scadenza__c != null
        ? line.Scadenza_Fattura__r.Data_Scadenza__c
        : line.Data_Scadenza__c;
      if (
        dueDate != null &&
        (rollup.firstOpenDueDate == null ||
        dueDate < rollup.firstOpenDueDate)
      ) {
        rollup.firstOpenDueDate = dueDate;
      }
    }

    List<Tranche__c> trancheUpdates = new List<Tranche__c>();
    Set<Id> fullyPaidTrancheIds = new Set<Id>();
    for (Id trancheId : rollupsByTrancheId.keySet()) {
      TrancheRollup rollup = rollupsByTrancheId.get(trancheId);
      if (rollup.isFullyPaid()) {
        fullyPaidTrancheIds.add(trancheId);
      }
      trancheUpdates.add(
        new Tranche__c(
          Id = trancheId,
          Completamente_Pagata__c = rollup.isFullyPaid(),
          Stato__c = rollup.status(),
          Prima_Scadenza_Aperta__c = rollup.firstOpenDueDate,
          Righe_Da_Fatturare__c = rollup.linesToInvoice
        )
      );
    }

    if (!trancheUpdates.isEmpty()) {
      update trancheUpdates;
    }

    markTicketsAvailableForFullyPaidTranches(fullyPaidTrancheIds);
    markOrdersCollectedForFullyPaidTranches(fullyPaidTrancheIds);
  }

  // An Order is Incassato once every tranche on its lines is Pagata (OI-69).
  private static void markOrdersCollectedForFullyPaidTranches(
    Set<Id> trancheIds
  ) {
    if (trancheIds == null || trancheIds.isEmpty()) {
      return;
    }

    Set<Id> orderIds = new Set<Id>();
    for (OrderItem line : [
      SELECT OrderId
      FROM OrderItem
      WHERE Tranche__c IN :trancheIds
    ]) {
      orderIds.add(line.OrderId);
    }

    if (orderIds.isEmpty()) {
      return;
    }

    Set<Id> ordersWithUnpaidTranches = new Set<Id>();
    for (OrderItem line : [
      SELECT OrderId, Tranche__r.Stato__c
      FROM OrderItem
      WHERE OrderId IN :orderIds AND Tranche__c != NULL
    ]) {
      if (line.Tranche__r.Stato__c != TRANCHE_STATUS_PAID) {
        ordersWithUnpaidTranches.add(line.OrderId);
      }
    }

    List<Order> orderUpdates = new List<Order>();
    for (Order orderRecord : [
      SELECT Id
      FROM Order
      WHERE Id IN :orderIds AND Status != :ORDER_STATUS_COLLECTED
    ]) {
      if (!ordersWithUnpaidTranches.contains(orderRecord.Id)) {
        orderUpdates.add(
          new Order(Id = orderRecord.Id, Status = ORDER_STATUS_COLLECTED)
        );
      }
    }

    if (!orderUpdates.isEmpty()) {
      update orderUpdates;
    }
  }

  private static void markTicketsAvailableForFullyPaidTranches(
    Set<Id> trancheIds
  ) {
    if (trancheIds == null || trancheIds.isEmpty()) {
      return;
    }

    Set<Id> paidOrderItemIds = new Set<Id>();
    for (OrderItem line : [
      SELECT Id
      FROM OrderItem
      WHERE Tranche__c IN :trancheIds
    ]) {
      paidOrderItemIds.add(line.Id);
    }

    if (paidOrderItemIds.isEmpty()) {
      return;
    }

    List<Asset> ticketUpdates = new List<Asset>();
    for (Asset ticket : [
      SELECT Id, Status, Fattura_Pagata__c
      FROM Asset
      WHERE
        Order_Product__c IN :paidOrderItemIds
        AND RecordType.DeveloperName = :TICKET_RECORD_TYPE_DEVELOPER_NAME
        AND (Status = :TICKET_STATUS_ORDERED
        OR Fattura_Pagata__c = FALSE)
    ]) {
      ticketUpdates.add(
        new Asset(
          Id = ticket.Id,
          Status = TICKET_STATUS_AVAILABLE,
          Fattura_Pagata__c = true
        )
      );
    }

    if (!ticketUpdates.isEmpty()) {
      update ticketUpdates;
    }
  }

  private class TrancheRollup {
    Integer totalLines = 0;
    Integer paidLines = 0;
    Integer linesToInvoice = 0;
    Date firstOpenDueDate;

    Boolean isFullyPaid() {
      return totalLines > 0 && paidLines == totalLines;
    }

    String status() {
      if (isFullyPaid()) {
        return TRANCHE_STATUS_PAID;
      }
      if (paidLines > 0) {
        return TRANCHE_STATUS_PARTIAL;
      }
      return TRANCHE_STATUS_OPEN;
    }
  }
}
