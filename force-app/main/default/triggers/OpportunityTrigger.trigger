trigger OpportunityTrigger on Opportunity(before insert, before update) {
  if (Trigger.isBefore) {
    if (Trigger.isInsert) {
      OpportunityTriggerHandler.beforeInsert(Trigger.new);
    }
    OpportunityTriggerHandler.beforeSave(Trigger.new);
  }
}
