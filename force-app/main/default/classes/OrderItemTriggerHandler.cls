public with sharing class OrderItemTriggerHandler {
  private static final String PAYMENT_STATUS_PAID = 'Paid';
  private static final String TRANCHE_STATUS_OPEN = 'Aperta';
  private static final String TRANCHE_STATUS_PARTIAL = 'Parzialmente Pagata';
  private static final String TRANCHE_STATUS_PAID = 'Pagata';
  private static final String TICKET_RECORD_TYPE_DEVELOPER_NAME = 'Ticket';
  private static final String TICKET_STATUS_AVAILABLE = 'Disponibile';

  public static void afterUpdate(
    List<OrderItem> newLines,
    Map<Id, OrderItem> oldLineMap
  ) {
    Set<Id> trancheIds = new Set<Id>();

    for (OrderItem line : newLines) {
      OrderItem oldLine = oldLineMap == null ? null : oldLineMap.get(line.Id);
      if (oldLine == null) {
        continue;
      }

      if (
        line.Tranche__c != oldLine.Tranche__c ||
        line.Mexal_Payment_Status__c != oldLine.Mexal_Payment_Status__c
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
      SELECT Id, Tranche__c, Mexal_Payment_Status__c
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
          Stato__c = rollup.status()
        )
      );
    }

    if (!trancheUpdates.isEmpty()) {
      update trancheUpdates;
    }

    markTicketsAvailableForFullyPaidTranches(fullyPaidTrancheIds);
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
        AND (Status != :TICKET_STATUS_AVAILABLE
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
