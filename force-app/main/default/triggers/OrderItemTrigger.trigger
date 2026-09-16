trigger OrderItemTrigger on OrderItem(after update) {
  if (Trigger.isAfter) {
    if (Trigger.isUpdate) {
      OrderItemTriggerHandler.afterUpdate(Trigger.new, Trigger.oldMap);
    }
  }
}
