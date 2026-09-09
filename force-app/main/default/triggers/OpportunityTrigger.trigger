trigger OpportunityTrigger on Opportunity(before insert, before update) {
  if (Trigger.isBefore) {
    OpportunityTriggerHandler.beforeSave(Trigger.new);
  }
}
