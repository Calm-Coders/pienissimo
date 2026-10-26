trigger OrderTrigger on Order(before insert, after insert, after update) {
  if (Trigger.isBefore && Trigger.isInsert) {
    OrderTriggerHandler.beforeInsert(Trigger.new);
  }

  if (Trigger.isAfter) {
    if (Trigger.isInsert) {
      OrderTriggerHandler.afterInsert(Trigger.new);
    }

    if (Trigger.isUpdate) {
      OrderTriggerHandler.afterUpdate(Trigger.new, Trigger.oldMap);
    }
  }
}
