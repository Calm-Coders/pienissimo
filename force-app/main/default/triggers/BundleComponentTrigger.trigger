trigger BundleComponentTrigger on BundleComponent__c(
  after insert,
  after update,
  after delete,
  after undelete
) {
  if (Trigger.isAfter) {
    if (Trigger.isInsert) {
      BundleComponentTriggerHandler.handleAfterInsert(Trigger.new);
    } else if (Trigger.isUpdate) {
      BundleComponentTriggerHandler.handleAfterUpdate(
        Trigger.new,
        Trigger.oldMap
      );
    } else if (Trigger.isDelete) {
      BundleComponentTriggerHandler.handleAfterDelete(Trigger.old);
    } else if (Trigger.isUndelete) {
      BundleComponentTriggerHandler.handleAfterUndelete(Trigger.new);
    }
  }
}
