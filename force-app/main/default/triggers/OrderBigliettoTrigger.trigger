trigger OrderBigliettoTrigger on Order(after insert, after update) {
  if (Trigger.isAfter) {
    if (Trigger.isInsert) {
      OrderBigliettoTriggerHandler.afterInsert(Trigger.new);
    }

    if (Trigger.isUpdate) {
      OrderBigliettoTriggerHandler.afterUpdate(Trigger.new, Trigger.oldMap);
    }
  }
}
