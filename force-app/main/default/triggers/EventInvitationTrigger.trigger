trigger EventInvitationTrigger on Event_Invitation__c(
  before insert,
  before update,
  after insert,
  after update
) {
  if (Trigger.isBefore) {
    EventInvitationService.beforeSave(Trigger.new, Trigger.oldMap);
  } else {
    EventInvitationService.afterSave(Trigger.new, Trigger.oldMap);
  }
}
