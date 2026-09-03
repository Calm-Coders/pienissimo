trigger ProductCodeTrigger on Product2(before insert, before update) {
  if (Trigger.isBefore) {
    if (Trigger.isInsert) {
      ProductCodeTriggerHandler.beforeInsert(Trigger.new);
    }

    if (Trigger.isUpdate) {
      ProductCodeTriggerHandler.beforeUpdate(Trigger.new);
    }
  }
}
