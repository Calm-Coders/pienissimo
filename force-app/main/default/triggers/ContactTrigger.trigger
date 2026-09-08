trigger ContactTrigger on Contact(
  after insert,
  after update,
  after delete,
  after undelete
) {
  if (Trigger.isAfter) {
    if (Trigger.isInsert) {
      ContactTriggerHandler.afterInsert(Trigger.new);
    }

    if (Trigger.isUpdate) {
      ContactTriggerHandler.afterUpdate(Trigger.new, Trigger.oldMap);
    }

    if (Trigger.isDelete) {
      ContactTriggerHandler.afterDelete(Trigger.old);
    }

    if (Trigger.isUndelete) {
      ContactTriggerHandler.afterUndelete(Trigger.new);
    }
  }
}
