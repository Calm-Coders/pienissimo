/**
 * Moves participant document generation out of the site guest user's
 * transaction. The registration publishes one Participant_Document_Request__e
 * per ticket Asset; the event trigger runs as the internal user named in
 * ParticipantDocumentRequestTriggerConfig and queues the rendering job, which
 * therefore runs as that user too. The guest user cannot render the
 * Visualforce PDF, so the job must never be queued from its transaction.
 */
public without sharing class ParticipantTicketDocumentRequests {
  public static void publish(Set<Id> assetIds) {
    if (assetIds == null || assetIds.isEmpty()) {
      return;
    }

    List<Participant_Document_Request__e> requests = new List<Participant_Document_Request__e>();
    for (Id assetId : assetIds) {
      requests.add(
        new Participant_Document_Request__e(
          Asset_Id__c = String.valueOf(assetId)
        )
      );
    }

    List<String> errors = new List<String>();
    for (Database.SaveResult result : EventBus.publish(requests)) {
      if (!result.isSuccess()) {
        for (Database.Error error : result.getErrors()) {
          errors.add(error.getMessage());
        }
      }
    }
    if (!errors.isEmpty()) {
      throw new ParticipantTicketDocumentRequestException(
        'Participant document requests were not published: ' +
        String.join(errors, '; ')
      );
    }
  }

  public static void handle(List<Participant_Document_Request__e> requests) {
    Set<Id> assetIds = new Set<Id>();
    for (Participant_Document_Request__e request : requests) {
      Id assetId = parseAssetId(request.Asset_Id__c);
      if (assetId != null) {
        assetIds.add(assetId);
      }
    }

    if (!assetIds.isEmpty()) {
      System.enqueueJob(new ParticipantTicketDocumentJob(assetIds));
    }
  }

  private static Id parseAssetId(String rawId) {
    if (String.isBlank(rawId)) {
      return null;
    }

    try {
      Id recordId = (Id) rawId;
      return recordId.getSObjectType() == Asset.SObjectType ? recordId : null;
    } catch (Exception e) {
      return null;
    }
  }

  public class ParticipantTicketDocumentRequestException extends Exception {
  }
}
