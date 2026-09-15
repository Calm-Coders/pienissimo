trigger AccountTrigger on Account(before delete, after update) {
  if (Trigger.isBefore && Trigger.isDelete) {
    AccountTriggerHandler.beforeDelete(Trigger.old);
  }

  if (Trigger.isAfter && Trigger.isUpdate) {
    AccountTriggerHandler.afterUpdate(Trigger.new, Trigger.oldMap);
  }
}
