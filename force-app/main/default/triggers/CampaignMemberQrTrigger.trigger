trigger CampaignMemberQrTrigger on CampaignMember(after insert) {
  AssetQrService.syncCampaignMembers(Trigger.new);
}
