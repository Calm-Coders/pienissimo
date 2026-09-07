trigger OrderTrigger on Order(after insert, after update) {
  if (Trigger.isAfter) {
    if (Trigger.isInsert) {
      OrderTriggerHandler.afterInsert(Trigger.new);
    }

    if (Trigger.isUpdate) {
      OrderTriggerHandler.afterUpdate(Trigger.new, Trigger.oldMap);
    }
  }
}
