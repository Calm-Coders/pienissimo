trigger ProductTrigger on Product2(
  after insert,
  after update,
  after delete,
  after undelete
) {
  if (Trigger.isAfter) {
    if (Trigger.isInsert) {
      ProductTriggerHandler.handleAfterInsert(Trigger.new);
    } else if (Trigger.isUpdate) {
      ProductTriggerHandler.handleAfterUpdate(Trigger.new, Trigger.oldMap);
    } else if (Trigger.isDelete) {
      ProductTriggerHandler.handleAfterDelete(Trigger.old);
    } else if (Trigger.isUndelete) {
      ProductTriggerHandler.handleAfterUndelete(Trigger.new);
    }
  }
}
