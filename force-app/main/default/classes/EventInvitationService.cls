/**
 * Internal ticket automation. One Event Link belongs to exactly one Order.
 * Campaign remains ticket presentation data and never determines invitation
 * identity or uniqueness.
 */
public without sharing class EventInvitationService {
  public static void ensureForAssets(List<Asset> tickets) {
    Set<Id> orderItemIds = new Set<Id>();
    for (Asset ticket : tickets) {
      if (ticket.Order_Product__c != null) {
        orderItemIds.add(ticket.Order_Product__c);
      }
    }
    if (orderItemIds.isEmpty()) {
      return;
    }

    Map<Id, Order> ordersById = new Map<Id, Order>();
    Map<Id, Id> orderIdByOrderItemId = new Map<Id, Id>();
    for (OrderItem line : [
      SELECT Id, OrderId, Order.AccountId
      FROM OrderItem
      WHERE Id IN :orderItemIds
    ]) {
      orderIdByOrderItemId.put(line.Id, line.OrderId);
      ordersById.put(
        line.OrderId,
        new Order(Id = line.OrderId, AccountId = line.Order.AccountId)
      );
    }
    if (ordersById.isEmpty()) {
      return;
    }

    Map<Id, Id> representativeCampaignIdByOrderId = new Map<Id, Id>();
    for (Asset ticket : tickets) {
      Id orderId = orderIdByOrderItemId.get(ticket.Order_Product__c);
      if (
        orderId != null &&
        ticket.Campaign__c != null &&
        !representativeCampaignIdByOrderId.containsKey(orderId)
      ) {
        representativeCampaignIdByOrderId.put(orderId, ticket.Campaign__c);
      }
    }

    // Serialise concurrent ticket generation for the same Order. Order_Key__c
    // remains the database-level final guard against duplicate Event Links.
    Set<Id> orderIds = ordersById.keySet();
    List<Order> lockedOrders = [
      SELECT Id, AccountId
      FROM Order
      WHERE Id IN :orderIds
      FOR UPDATE
    ];

    Map<Id, Event_Invitation__c> candidatesByOrderId = new Map<Id, Event_Invitation__c>();
    for (Order orderRecord : lockedOrders) {
      candidatesByOrderId.put(
        orderRecord.Id,
        new Event_Invitation__c(
          Order__c = orderRecord.Id,
          Account__c = orderRecord.AccountId,
          Campaign__c = representativeCampaignIdByOrderId.get(orderRecord.Id)
        )
      );
    }

    Set<Id> candidateOrderIds = candidatesByOrderId.keySet();
    List<Event_Invitation__c> existingInvitationsToComplete = new List<Event_Invitation__c>();
    for (Event_Invitation__c existing : [
      SELECT Id, Order__c, Campaign__c
      FROM Event_Invitation__c
      WHERE Order__c IN :candidateOrderIds
    ]) {
      candidatesByOrderId.remove(existing.Order__c);
      Id representativeCampaignId = representativeCampaignIdByOrderId.get(
        existing.Order__c
      );
      if (existing.Campaign__c == null && representativeCampaignId != null) {
        existingInvitationsToComplete.add(
          new Event_Invitation__c(
            Id = existing.Id,
            Campaign__c = representativeCampaignId
          )
        );
      }
    }

    if (!existingInvitationsToComplete.isEmpty()) {
      update existingInvitationsToComplete;
    }
    if (!candidatesByOrderId.isEmpty()) {
      insert candidatesByOrderId.values();
    }
  }

  public static void beforeSave(
    List<Event_Invitation__c> invitations,
    Map<Id, Event_Invitation__c> oldMap
  ) {
    Map<Id, Order> ordersById = loadOrders(invitations);
    Map<Id, Contact> principalContactByAccountId = loadPrincipalContacts(
      ordersById.values()
    );
    Set<Id> seenOrderIds = new Set<Id>();

    for (Event_Invitation__c invitation : invitations) {
      Order orderRecord = ordersById.get(invitation.Order__c);
      if (orderRecord == null) {
        invitation.Order__c.addError(
          'Seleziona l ordine a cui appartiene il link evento.'
        );
        continue;
      }
      if (seenOrderIds.contains(orderRecord.Id)) {
        invitation.Order__c.addError(
          'Esiste gia un link evento per questo ordine.'
        );
        continue;
      }
      seenOrderIds.add(orderRecord.Id);

      invitation.Account__c = orderRecord.AccountId;
      invitation.Order_Key__c = key(orderRecord.Id);
      // Retired uniqueness key: Campaign does not identify an Event Link.
      invitation.Account_Campaign_Key__c = null;

      Contact principalContact = principalContactByAccountId.get(
        orderRecord.AccountId
      );
      if (invitation.Recipient_Contact__c == null && principalContact != null) {
        invitation.Recipient_Contact__c = principalContact.Id;
      }

      Event_Invitation__c oldRecord = oldMap == null
        ? null
        : oldMap.get(invitation.Id);
      Boolean relationshipChanged =
        oldRecord == null ||
        oldRecord.Order__c != invitation.Order__c;
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

    rejectExistingOrderLinks(invitations, seenOrderIds);
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
        oldRecord.Order__c != invitation.Order__c ||
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
  }

  private static void rejectExistingOrderLinks(
    List<Event_Invitation__c> invitations,
    Set<Id> orderIds
  ) {
    if (orderIds.isEmpty()) {
      return;
    }

    Map<Id, Id> existingInvitationIdByOrderId = new Map<Id, Id>();
    for (Event_Invitation__c existing : [
      SELECT Id, Order__c
      FROM Event_Invitation__c
      WHERE Order__c IN :orderIds
    ]) {
      existingInvitationIdByOrderId.put(existing.Order__c, existing.Id);
    }

    for (Event_Invitation__c invitation : invitations) {
      Id existingId = existingInvitationIdByOrderId.get(invitation.Order__c);
      if (existingId != null && existingId != invitation.Id) {
        invitation.Order__c.addError(
          'Esiste gia un link evento per questo ordine.'
        );
      }
    }
  }

  private static String key(Id orderId) {
    return orderId == null ? null : String.valueOf(orderId);
  }

  private static Map<Id, Order> loadOrders(
    List<Event_Invitation__c> invitations
  ) {
    Set<Id> orderIds = new Set<Id>();
    for (Event_Invitation__c invitation : invitations) {
      if (invitation.Order__c != null) {
        orderIds.add(invitation.Order__c);
      }
    }
    if (orderIds.isEmpty()) {
      return new Map<Id, Order>();
    }

    return new Map<Id, Order>(
      [SELECT Id, AccountId FROM Order WHERE Id IN :orderIds]
    );
  }

  private static Map<Id, Contact> loadPrincipalContacts(List<Order> orders) {
    Set<Id> accountIds = new Set<Id>();
    for (Order orderRecord : orders) {
      if (orderRecord.AccountId != null) {
        accountIds.add(orderRecord.AccountId);
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
