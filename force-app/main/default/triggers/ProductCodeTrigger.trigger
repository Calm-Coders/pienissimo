trigger ProductCodeTrigger on Product2(
  before insert,
  before update,
  after insert
) {
  if (Trigger.isBefore) {
    if (Trigger.isInsert) {
      ProductCodeTriggerHandler.beforeInsert(Trigger.new);
    }

    if (Trigger.isUpdate) {
      ProductCodeTriggerHandler.beforeUpdate(Trigger.new);
    }
  }

  if (Trigger.isAfter && Trigger.isInsert) {
    ProductCodeTriggerHandler.afterInsert(Trigger.new);
  }
}
