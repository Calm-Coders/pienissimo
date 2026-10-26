trigger EventInvitationAssetTrigger on Asset(
  after insert,
  after update,
  after delete,
  after undelete
) {
  EventInvitationService.recalculateForAssets(
    Trigger.isDelete ? Trigger.old : Trigger.new,
    Trigger.isUpdate ? Trigger.oldMap : null
  );
}
