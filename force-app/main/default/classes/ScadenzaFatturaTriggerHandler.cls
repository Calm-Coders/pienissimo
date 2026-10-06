// A Mexal rate drives the order lines it pays: when its payment state changes,
// the linked OrderItems take Paid / Unpaid, and OrderItemTriggerHandler rolls
// that up onto the tranche, the tickets and the order.
public without sharing class ScadenzaFatturaTriggerHandler {
  private static final String PAYMENT_STATUS_PAID = 'Paid';
  private static final String PAYMENT_STATUS_UNPAID = 'Unpaid';

  public static void afterUpdate(
    List<Scadenza_Fattura__c> deadlines,
    Map<Id, Scadenza_Fattura__c> oldDeadlines
  ) {
    Set<Id> changedIds = new Set<Id>();
    for (Scadenza_Fattura__c deadline : deadlines) {
      Scadenza_Fattura__c oldDeadline = oldDeadlines.get(deadline.Id);
      if (
        oldDeadline == null ||
        deadline.Stato_Pagamento_Mexal__c !=
        oldDeadline.Stato_Pagamento_Mexal__c ||
        deadline.Data_Scadenza__c != oldDeadline.Data_Scadenza__c
      ) {
        changedIds.add(deadline.Id);
      }
    }
    syncOrderLines(changedIds);
  }

  public static void syncOrderLines(Set<Id> deadlineIds) {
    if (deadlineIds == null || deadlineIds.isEmpty()) {
      return;
    }

    List<OrderItem> updates = new List<OrderItem>();
    for (OrderItem line : [
      SELECT Id, Mexal_Payment_Status__c, Scadenza_Fattura__r.Pagata__c
      FROM OrderItem
      WHERE Scadenza_Fattura__c IN :deadlineIds
    ]) {
      String status = line.Scadenza_Fattura__r.Pagata__c
        ? PAYMENT_STATUS_PAID
        : PAYMENT_STATUS_UNPAID;
      if (line.Mexal_Payment_Status__c != status) {
        updates.add(
          new OrderItem(Id = line.Id, Mexal_Payment_Status__c = status)
        );
      }
    }

    if (!updates.isEmpty()) {
      update updates;
    }
  }
}
