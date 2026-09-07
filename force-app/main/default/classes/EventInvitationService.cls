/**
 * Internal ticket automation. System visibility makes the Account-Campaign key
 * unique even when orders and invitations belong to different internal users.
 * This class is not exposed to the community.
 */
public without sharing class EventInvitationService {
  public static void ensureForAssets(List<Asset> tickets) {
    Map<String, Event_Invitation__c> candidates = new Map<String, Event_Invitation__c>();
    Set<Id> accountIds = new Set<Id>();
    for (Asset ticket : tickets) {
      if (ticket.AccountId == null || ticket.Campaign__c == null) {
        continue;
      }
      accountIds.add(ticket.AccountId);
      candidates.put(
        key(ticket.AccountId, ticket.Campaign__c),
        new Event_Invitation__c(
          Account__c = ticket.AccountId,
          Campaign__c = ticket.Campaign__c
        )
      );
    }
    if (candidates.isEmpty()) {
      return;
    }
    // Serialize concurrent ticket generation for the same company before
    // checking for an existing invitation. The unique field is the final guard.
    List<Account> lockedAccounts = [
      SELECT Id
      FROM Account
      WHERE Id IN :accountIds
      FOR UPDATE
    ];
    Set<String> keys = candidates.keySet();
    for (Event_Invitation__c existing : [
      SELECT Account_Campaign_Key__c
      FROM Event_Invitation__c
      WHERE Account_Campaign_Key__c IN :keys
    ]) {
      candidates.remove(existing.Account_Campaign_Key__c);
    }
    if (!candidates.isEmpty()) {
      insert candidates.values();
    }
  }

  public static void beforeSave(
    List<Event_Invitation__c> invitations,
    Map<Id, Event_Invitation__c> oldMap
  ) {
    for (Event_Invitation__c invitation : invitations) {
      invitation.Account_Campaign_Key__c = key(
        invitation.Account__c,
        invitation.Campaign__c
      );
      Event_Invitation__c oldRecord = oldMap == null
        ? null
        : oldMap.get(invitation.Id);
      if (
        oldRecord == null ||
        oldRecord.Account__c != invitation.Account__c ||
        oldRecord.Campaign__c != invitation.Campaign__c
      ) {
        invitation.Registration_Url__c = null;
        invitation.URL_Status__c = 'Pending';
        invitation.URL_Refreshed_At__c = null;
        invitation.Last_URL_Error__c = null;
        invitation.Status__c = 'Pending';
      }
    }
  }

  public static void afterSave(
    List<Event_Invitation__c> invitations,
    Map<Id, Event_Invitation__c> oldMap
  ) {
    List<Id> ids = new List<Id>();
    for (Event_Invitation__c invitation : invitations) {
      Event_Invitation__c oldRecord = oldMap == null
        ? null
        : oldMap.get(invitation.Id);
      if (
        oldRecord == null ||
        oldRecord.Account__c != invitation.Account__c ||
        oldRecord.Campaign__c != invitation.Campaign__c
      ) {
        ids.add(invitation.Id);
      }
    }
    if (
      !ids.isEmpty() &&
      Limits.getQueueableJobs() < Limits.getLimitQueueableJobs()
    ) {
      System.enqueueJob(new EventInvitationUrlJob(ids));
    }
    // If another automation exhausted the transaction's queueable allowance,
    // the explicit Pending URL state is retained. The refresh Flow action can
    // prepare these invitations before dispatch without blocking the order.
  }

  private static String key(Id accountId, Id campaignId) {
    if (accountId == null || campaignId == null) {
      return null;
    }
    return String.valueOf(accountId) + ':' + String.valueOf(campaignId);
  }
}
