trigger LeadConversionTrigger on Lead(after update) {
  if (Trigger.isAfter && Trigger.isUpdate) {
    LeadConversionTriggerHandler.afterUpdate(Trigger.new, Trigger.oldMap);
  }
}
