trigger MappaturaEdizioneTrigger on Mappatura_Edizione__c(
  before insert,
  before update
) {
  if (Trigger.isBefore) {
    MappaturaEdizioneTriggerHandler.beforeSave(Trigger.new, Trigger.oldMap);
  }
}
