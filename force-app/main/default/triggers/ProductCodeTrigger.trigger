trigger ProductCodeTrigger on Product2(
  before insert,
  before update,
  after insert,
  after update
) {
  if (Trigger.isBefore) {
    if (Trigger.isInsert) {
      ProductCodeTriggerHandler.beforeInsert(Trigger.new);
    }

    if (Trigger.isUpdate) {
      ProductCodeTriggerHandler.beforeUpdate(Trigger.new);
    }
  }

  if (Trigger.isAfter) {
    if (Trigger.isInsert) {
      ProductCodeTriggerHandler.afterInsert(Trigger.new);
    }

    if (Trigger.isUpdate) {
      ProductCodeTriggerHandler.afterUpdate(Trigger.new, Trigger.oldMap);
    }
  }
}
