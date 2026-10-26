trigger OpportunityTrigger on Opportunity(
  before insert,
  before update,
  after update
) {
  if (Trigger.isBefore) {
    if (Trigger.isInsert) {
      OpportunityTriggerHandler.beforeInsert(Trigger.new);
    }
    OpportunityTriggerHandler.beforeSave(
      Trigger.new,
      Trigger.isUpdate ? Trigger.oldMap : null
    );
  }
  if (Trigger.isAfter && Trigger.isUpdate) {
    OpportunityTriggerHandler.afterUpdate(Trigger.new, Trigger.oldMap);
  }
}
