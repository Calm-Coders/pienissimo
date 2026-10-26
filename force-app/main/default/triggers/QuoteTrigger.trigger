trigger QuoteTrigger on Quote(
  before insert,
  before update,
  after insert,
  after update
) {
  if (Trigger.isBefore) {
    QuoteTriggerHandler.beforeSave(
      Trigger.new,
      Trigger.isUpdate ? Trigger.oldMap : null
    );
  }

  if (Trigger.isAfter && Trigger.isInsert) {
    QuoteTriggerHandler.afterInsert(Trigger.new);
  }

  if (Trigger.isAfter && Trigger.isUpdate) {
    QuoteTriggerHandler.afterUpdate(Trigger.new, Trigger.oldMap);
  }
}
