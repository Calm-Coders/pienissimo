trigger AccountTrigger on Account(before delete) {
  if (Trigger.isBefore && Trigger.isDelete) {
    AccountTriggerHandler.beforeDelete(Trigger.old);
  }
}
