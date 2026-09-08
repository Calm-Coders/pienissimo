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
    Map<Id, Campaign> campaignById = loadCampaigns(invitations);
    Map<Id, Contact> principalContactByAccountId = loadPrincipalContacts(
      invitations
    );

    for (Event_Invitation__c invitation : invitations) {
      invitation.Account_Campaign_Key__c = key(
        invitation.Account__c,
        invitation.Campaign__c
      );
      Campaign campaign = campaignById.get(invitation.Campaign__c);
      Contact principalContact = principalContactByAccountId.get(
        invitation.Account__c
      );

      invitation.Send_After__c = campaign == null ||
        campaign.Data_Invio_Biglietto__c == null
        ? null
        : DateTime.newInstance(
            campaign.Data_Invio_Biglietto__c,
            Time.newInstance(0, 0, 0, 0)
          );
      if (invitation.Recipient_Contact__c == null && principalContact != null) {
        invitation.Recipient_Contact__c = principalContact.Id;
      }

      Event_Invitation__c oldRecord = oldMap == null
        ? null
        : oldMap.get(invitation.Id);
      Boolean relationshipChanged =
        oldRecord == null ||
        oldRecord.Account__c != invitation.Account__c ||
        oldRecord.Campaign__c != invitation.Campaign__c;
      Boolean tokenMissing = String.isBlank(invitation.Token__c);

      if (relationshipChanged || tokenMissing) {
        invitation.Token__c = generateToken();
      }

      if (
        relationshipChanged ||
        tokenMissing ||
        oldRecord.Token__c != invitation.Token__c
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
        oldRecord.Campaign__c != invitation.Campaign__c ||
        oldRecord.Token__c != invitation.Token__c
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

  private static Map<Id, Campaign> loadCampaigns(
    List<Event_Invitation__c> invitations
  ) {
    Set<Id> campaignIds = new Set<Id>();
    for (Event_Invitation__c invitation : invitations) {
      if (invitation.Campaign__c != null) {
        campaignIds.add(invitation.Campaign__c);
      }
    }

    if (campaignIds.isEmpty()) {
      return new Map<Id, Campaign>();
    }

    return new Map<Id, Campaign>(
      [
        SELECT Id, Data_Invio_Biglietto__c
        FROM Campaign
        WHERE Id IN :campaignIds
      ]
    );
  }

  private static Map<Id, Contact> loadPrincipalContacts(
    List<Event_Invitation__c> invitations
  ) {
    Set<Id> accountIds = new Set<Id>();
    for (Event_Invitation__c invitation : invitations) {
      if (invitation.Account__c != null) {
        accountIds.add(invitation.Account__c);
      }
    }

    Map<Id, Contact> result = new Map<Id, Contact>();
    if (accountIds.isEmpty()) {
      return result;
    }

    Set<Id> duplicatePrincipalAccountIds = new Set<Id>();
    for (Contact contactRecord : [
      SELECT Id, AccountId, Email
      FROM Contact
      WHERE
        AccountId IN :accountIds
        AND Contatto_Principale__c = TRUE
        AND Email != NULL
      ORDER BY CreatedDate ASC
    ]) {
      if (result.containsKey(contactRecord.AccountId)) {
        duplicatePrincipalAccountIds.add(contactRecord.AccountId);
      } else {
        result.put(contactRecord.AccountId, contactRecord);
      }
    }

    for (Id accountId : duplicatePrincipalAccountIds) {
      result.remove(accountId);
    }

    return result;
  }

  private static String generateToken() {
    return EncodingUtil.convertToHex(Crypto.generateAesKey(256)).toLowerCase();
  }
}
