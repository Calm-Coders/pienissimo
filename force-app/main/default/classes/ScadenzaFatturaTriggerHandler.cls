// A Mexal rate drives the order lines of its invoice: when its payment state
// changes, those OrderItems take the invoice's Paid / Unpaid, and
// OrderItemTriggerHandler rolls that up onto the tranche, the tickets and the order.
public without sharing class ScadenzaFatturaTriggerHandler {
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

  // A rate has no line reference: every order line of its invoice takes the
  // invoice's payment state again.
  public static void syncOrderLines(Set<Id> deadlineIds) {
    if (deadlineIds == null || deadlineIds.isEmpty()) {
      return;
    }

    Set<Id> invoiceIds = new Set<Id>();
    for (Scadenza_Fattura__c deadline : [
      SELECT Fattura__c
      FROM Scadenza_Fattura__c
      WHERE Id IN :deadlineIds AND Fattura__c != NULL
    ]) {
      invoiceIds.add(deadline.Fattura__c);
    }

    List<String> errors = new List<String>();
    MexalInvoiceImportService.linkOrderLines(invoiceIds, errors);
    if (!errors.isEmpty()) {
      throw new ScadenzaFatturaSyncException(String.join(errors, '\n'));
    }
  }

  public class ScadenzaFatturaSyncException extends Exception {
  }
}
