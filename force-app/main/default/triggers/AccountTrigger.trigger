trigger AccountTrigger on Account(
  before insert,
  before update,
  before delete,
  after update
) {
  if (Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate)) {
    AccountTriggerHandler.beforeSave(Trigger.new);
  }

  if (Trigger.isBefore && Trigger.isDelete) {
    AccountTriggerHandler.beforeDelete(Trigger.old);
  }

  if (Trigger.isAfter && Trigger.isUpdate) {
    AccountTriggerHandler.afterUpdate(Trigger.new, Trigger.oldMap);
  }
}
