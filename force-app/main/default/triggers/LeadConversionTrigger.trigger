trigger LeadConversionTrigger on Lead(
  before insert,
  before update,
  after update
) {
  if (Trigger.isBefore) {
    LeadConversionTriggerHandler.beforeSave(Trigger.new, Trigger.oldMap);
  }

  if (Trigger.isAfter && Trigger.isUpdate) {
    LeadConversionTriggerHandler.afterUpdate(Trigger.new, Trigger.oldMap);
  }
}
