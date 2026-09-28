trigger QuoteLineItemTrigger on QuoteLineItem(
  before insert,
  before update,
  after insert,
  after delete
) {
  if (Trigger.isBefore) {
    if (Trigger.isInsert) {
      QuoteLineItemTriggerHandler.beforeSave(Trigger.new, null);
    }

    if (Trigger.isUpdate) {
      QuoteLineItemTriggerHandler.beforeSave(Trigger.new, Trigger.oldMap);
    }
  }

  if (Trigger.isAfter && Trigger.isDelete) {
    QuoteLineItemTriggerHandler.afterDelete(Trigger.old);
  }

  if (Trigger.isAfter && Trigger.isInsert) {
    QuoteLineItemTriggerHandler.afterInsert(Trigger.new);
  }
}
