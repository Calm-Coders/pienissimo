public without sharing class AssetQrService {
  public static void syncCampaignMembers(List<CampaignMember> campaignMembers) {
    if (campaignMembers == null || campaignMembers.isEmpty()) {
      return;
    }

    Set<Id> contactIds = new Set<Id>();
    Set<Id> campaignIds = new Set<Id>();
    Set<String> campaignMemberTicketKeys = new Set<String>();

    for (CampaignMember campaignMember : campaignMembers) {
      if (
        campaignMember.ContactId != null &&
        campaignMember.CampaignId != null
      ) {
        contactIds.add(campaignMember.ContactId);
        campaignIds.add(campaignMember.CampaignId);
        campaignMemberTicketKeys.add(
          String.valueOf(campaignMember.ContactId) +
            ':' +
            String.valueOf(campaignMember.CampaignId)
        );
      }
    }

    if (contactIds.isEmpty()) {
      return;
    }

    List<ContentVersion> qrFiles = new List<ContentVersion>();
    Set<Id> documentAssetIds = new Set<Id>();

    for (Asset assetRecord : [
      SELECT Id, ContactId, Campaign__c
      FROM Asset
      WHERE ContactId IN :contactIds AND Campaign__c IN :campaignIds
    ]) {
      String ticketKey =
        String.valueOf(assetRecord.ContactId) +
        ':' +
        String.valueOf(assetRecord.Campaign__c);

      if (campaignMemberTicketKeys.contains(ticketKey)) {
        String qrId = String.valueOf(assetRecord.Id);
        qrFiles.add(
          new ContentVersion(
            Title = 'Ticket QR - ' + qrId,
            PathOnClient = 'Ticket-QR-' + qrId + '.bmp',
            VersionData = TicketQrImage.generate(qrId),
            FirstPublishLocationId = assetRecord.Id
          )
        );
        documentAssetIds.add(assetRecord.Id);
      }
    }

    if (!qrFiles.isEmpty()) {
      insert qrFiles;
    }
    // Runs as the site guest user during registration, which cannot render
    // the PDF: hand the work to the event subscriber's internal user.
    ParticipantTicketDocumentRequests.publish(documentAssetIds);
  }
}
