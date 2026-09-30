public without sharing class AssetQrService {
  public static void syncCampaignMembers(List<CampaignMember> campaignMembers) {
    if (campaignMembers == null || campaignMembers.isEmpty()) {
      return;
    }

    Set<Id> contactIds = new Set<Id>();
    Set<Id> campaignIds = new Set<Id>();
    Map<String, Id> memberIdByTicketKey = new Map<String, Id>();

    for (CampaignMember campaignMember : campaignMembers) {
      if (
        campaignMember.ContactId != null &&
        campaignMember.CampaignId != null
      ) {
        contactIds.add(campaignMember.ContactId);
        campaignIds.add(campaignMember.CampaignId);
        memberIdByTicketKey.put(
          String.valueOf(campaignMember.ContactId) +
            ':' +
            String.valueOf(campaignMember.CampaignId),
          campaignMember.Id
        );
      }
    }

    if (contactIds.isEmpty()) {
      return;
    }

    List<Asset> assetsToUpdate = new List<Asset>();
    List<ContentVersion> qrFiles = new List<ContentVersion>();
    Set<Id> documentAssetIds = new Set<Id>();

    for (Asset assetRecord : [
      SELECT Id, ContactId, Campaign__c, QR_Id__c
      FROM Asset
      WHERE ContactId IN :contactIds AND Campaign__c IN :campaignIds
    ]) {
      Id memberId = memberIdByTicketKey.get(
        String.valueOf(assetRecord.ContactId) +
          ':' +
          String.valueOf(assetRecord.Campaign__c)
      );

      if (memberId != null) {
        if (assetRecord.QR_Id__c != String.valueOf(memberId)) {
          assetsToUpdate.add(
            new Asset(Id = assetRecord.Id, QR_Id__c = String.valueOf(memberId))
          );
        }
        qrFiles.add(
          new ContentVersion(
            Title = 'Ticket QR - ' + String.valueOf(memberId),
            PathOnClient = 'Ticket-QR-' + String.valueOf(memberId) + '.bmp',
            VersionData = TicketQrImage.generate(String.valueOf(memberId)),
            FirstPublishLocationId = assetRecord.Id
          )
        );
        documentAssetIds.add(assetRecord.Id);
      }
    }

    if (!assetsToUpdate.isEmpty()) {
      update assetsToUpdate;
    }
    if (!qrFiles.isEmpty()) {
      insert qrFiles;
    }
    // Runs as the site guest user during registration, which cannot render
    // the PDF: hand the work to the event subscriber's internal user.
    ParticipantTicketDocumentRequests.publish(documentAssetIds);
  }
}
