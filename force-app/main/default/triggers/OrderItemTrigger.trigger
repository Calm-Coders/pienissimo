trigger OrderItemTrigger on OrderItem(after insert, after update) {
  if (Trigger.isAfter) {
    if (Trigger.isInsert) {
      OrderItemTriggerHandler.afterInsert(Trigger.new);
    }

    if (Trigger.isUpdate) {
      OrderItemTriggerHandler.afterUpdate(Trigger.new, Trigger.oldMap);
    }
  }
}
