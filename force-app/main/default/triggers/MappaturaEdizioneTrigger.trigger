trigger MappaturaEdizioneTrigger on Mappatura_Edizione__c(
  before insert,
  before update,
  after insert
) {
  if (Trigger.isBefore) {
    MappaturaEdizioneTriggerHandler.beforeSave(Trigger.new, Trigger.oldMap);
  } else if (Trigger.isInsert) {
    MappaturaEdizioneTriggerHandler.afterInsert(Trigger.new);
  }
}
