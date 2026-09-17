trigger QuoteLineItemTrigger on QuoteLineItem(before insert, before update) {
  if (Trigger.isBefore) {
    if (Trigger.isInsert) {
      QuoteLineItemTriggerHandler.beforeSave(Trigger.new, null);
    }

    if (Trigger.isUpdate) {
      QuoteLineItemTriggerHandler.beforeSave(Trigger.new, Trigger.oldMap);
    }
  }
}
