trigger EventInvitationCampaignTrigger on Campaign(after update) {
  Set<Id> changedCampaignIds = new Set<Id>();
  for (Campaign campaignRecord : Trigger.new) {
    if (
      campaignRecord.Data_Invio_Biglietto__c !=
      Trigger.oldMap.get(campaignRecord.Id).Data_Invio_Biglietto__c
    ) {
      changedCampaignIds.add(campaignRecord.Id);
    }
  }
  EventInvitationService.refreshCampaignSendDates(changedCampaignIds);
}
