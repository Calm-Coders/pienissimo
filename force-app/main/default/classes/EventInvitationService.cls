/**
 * Internal ticket automation. One Event Link belongs to exactly one
 * Order-Campaign pair.
 */
public without sharing class EventInvitationService implements Schedulable {
  private static final String COLLECTION_PENDING = 'Pending';
  private static final String COLLECTION_READY = 'Ready';
  private static final String COLLECTION_COMPLETED = 'Completed';
  private static final String COLLECTION_CANCELLED = 'Cancelled';
  private static final String TICKET_ORDERED = 'Ordinato';
  private static final String TICKET_AVAILABLE = 'Disponibile';
  private static final String TICKET_WAIVED = 'Rinuncia';
  private static Boolean isRecalculating = false;

  private class CollectionSummary {
    public Integer total = 0;
    public Integer ordered = 0;
    public Integer available = 0;
    public Integer waived = 0;
  }

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

    Map<String, Event_Invitation__c> candidatesByOrderCampaign = new Map<String, Event_Invitation__c>();
    for (Asset ticket : tickets) {
      Id orderId = orderIdByOrderItemId.get(ticket.Order_Product__c);
      if (orderId != null) {
        Order orderRecord = ordersById.get(orderId);
        candidatesByOrderCampaign.put(
          key(orderId, ticket.Campaign__c),
          new Event_Invitation__c(
            Order__c = orderId,
            Account__c = orderRecord.AccountId,
            Campaign__c = ticket.Campaign__c
          )
        );
      }
    }
    if (candidatesByOrderCampaign.isEmpty()) {
      return;
    }

    // Serialise concurrent ticket generation for the same Order. The composite
    // Order_Key__c remains the database-level final duplicate guard.
    Set<Id> orderIds = ordersById.keySet();
    List<Order> lockedOrders = [
      SELECT Id, AccountId
      FROM Order
      WHERE Id IN :orderIds
      FOR UPDATE
    ];

    Set<Id> candidateOrderIds = ordersById.keySet();
    for (Event_Invitation__c existing : [
      SELECT Id, Order__c, Campaign__c
      FROM Event_Invitation__c
      WHERE Order__c IN :candidateOrderIds
    ]) {
      candidatesByOrderCampaign.remove(
        key(existing.Order__c, existing.Campaign__c)
      );
    }

    if (!candidatesByOrderCampaign.isEmpty()) {
      insert candidatesByOrderCampaign.values();
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
    Map<Id, Campaign> campaignsById = loadCampaigns(invitations);
    Set<String> seenOrderCampaignKeys = new Set<String>();

    for (Event_Invitation__c invitation : invitations) {
      Order orderRecord = ordersById.get(invitation.Order__c);
      if (orderRecord == null) {
        invitation.Order__c.addError(
          'Seleziona l ordine a cui appartiene il link evento.'
        );
        continue;
      }
      String orderCampaignKey = key(orderRecord.Id, invitation.Campaign__c);
      if (seenOrderCampaignKeys.contains(orderCampaignKey)) {
        invitation.Order__c.addError(
          'Esiste gia un link evento per questo ordine e questa campagna.'
        );
        continue;
      }
      seenOrderCampaignKeys.add(orderCampaignKey);

      invitation.Account__c = orderRecord.AccountId;
      invitation.Order_Key__c = orderCampaignKey;
      // Retired legacy key. Invitation identity is Order + Campaign, not
      // Account + Campaign.
      invitation.Account_Campaign_Key__c = null;

      Campaign campaignRecord = campaignsById.get(invitation.Campaign__c);
      invitation.Send_After__c = campaignRecord == null ||
        campaignRecord.Data_Invio_Biglietto__c == null
        ? null
        : DateTime.newInstance(
            campaignRecord.Data_Invio_Biglietto__c,
            Time.newInstance(0, 0, 0, 0)
          );

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
        oldRecord.Order__c != invitation.Order__c ||
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
      }
    }

    rejectExistingOrderCampaignLinks(invitations, seenOrderCampaignKeys);
  }

  public static void afterSave(
    List<Event_Invitation__c> invitations,
    Map<Id, Event_Invitation__c> oldMap
  ) {
    List<Id> ids = new List<Id>();
    Set<Id> idsToRecalculate = new Set<Id>();
    for (Event_Invitation__c invitation : invitations) {
      Event_Invitation__c oldRecord = oldMap == null
        ? null
        : oldMap.get(invitation.Id);
      if (
        oldRecord == null ||
        oldRecord.Order__c != invitation.Order__c ||
        oldRecord.Campaign__c != invitation.Campaign__c ||
        oldRecord.Token__c != invitation.Token__c
      ) {
        ids.add(invitation.Id);
      }
      if (
        oldRecord == null ||
        oldRecord.Order__c != invitation.Order__c ||
        oldRecord.Campaign__c != invitation.Campaign__c ||
        oldRecord.Recipient_Contact__c != invitation.Recipient_Contact__c ||
        oldRecord.Send_After__c != invitation.Send_After__c ||
        oldRecord.Token__c != invitation.Token__c ||
        oldRecord.URL_Status__c != invitation.URL_Status__c ||
        oldRecord.Registration_Url__c != invitation.Registration_Url__c ||
        oldRecord.Status__c != invitation.Status__c
      ) {
        idsToRecalculate.add(invitation.Id);
      }
    }
    if (
      !ids.isEmpty() &&
      Limits.getQueueableJobs() < Limits.getLimitQueueableJobs()
    ) {
      System.enqueueJob(new EventInvitationUrlJob(ids));
    }
    if (!isRecalculating && !idsToRecalculate.isEmpty()) {
      recalculateForInvitationIds(idsToRecalculate);
    }
  }

  public static void recalculateForAssets(
    List<Asset> assets,
    Map<Id, Asset> oldMap
  ) {
    Set<Id> orderItemIds = new Set<Id>();
    List<Asset> assetVersions = new List<Asset>();
    if (assets != null) {
      assetVersions.addAll(assets);
    }
    if (oldMap != null) {
      assetVersions.addAll(oldMap.values());
    }
    for (Asset assetRecord : assetVersions) {
      if (assetRecord.Order_Product__c != null) {
        orderItemIds.add(assetRecord.Order_Product__c);
      }
    }
    if (orderItemIds.isEmpty()) {
      return;
    }

    Map<Id, Id> orderIdByOrderItemId = new Map<Id, Id>();
    for (OrderItem line : [
      SELECT Id, OrderId
      FROM OrderItem
      WHERE Id IN :orderItemIds
    ]) {
      orderIdByOrderItemId.put(line.Id, line.OrderId);
    }

    Set<Id> orderIds = new Set<Id>();
    Set<String> affectedKeys = new Set<String>();
    for (Asset assetRecord : assetVersions) {
      Id orderId = orderIdByOrderItemId.get(assetRecord.Order_Product__c);
      if (orderId != null) {
        orderIds.add(orderId);
        affectedKeys.add(key(orderId, assetRecord.Campaign__c));
      }
    }
    if (orderIds.isEmpty()) {
      return;
    }

    Set<Id> invitationIds = new Set<Id>();
    for (Event_Invitation__c invitation : [
      SELECT Id, Order__c, Campaign__c
      FROM Event_Invitation__c
      WHERE Order__c IN :orderIds
    ]) {
      if (
        affectedKeys.contains(key(invitation.Order__c, invitation.Campaign__c))
      ) {
        invitationIds.add(invitation.Id);
      }
    }
    recalculateForInvitationIds(invitationIds);
  }

  public static void refreshCampaignSendDates(Set<Id> campaignIds) {
    if (campaignIds == null || campaignIds.isEmpty()) {
      return;
    }
    List<Event_Invitation__c> invitations = [
      SELECT Id
      FROM Event_Invitation__c
      WHERE Campaign__c IN :campaignIds
    ];
    if (!invitations.isEmpty()) {
      update invitations;
    }
  }

  @InvocableMethod(label='Ricalcola stato raccolta inviti evento')
  public static void recalculateInvitationStatus(List<Id> invitationIds) {
    recalculateForInvitationIds(
      invitationIds == null ? new Set<Id>() : new Set<Id>(invitationIds)
    );
  }

  public void execute(SchedulableContext context) {
    Set<Id> activeInvitationIds = new Map<Id, Event_Invitation__c>(
        [
          SELECT Id
          FROM Event_Invitation__c
          WHERE Status__c IN (:COLLECTION_PENDING, :COLLECTION_READY)
        ]
      )
      .keySet();
    recalculateForInvitationIds(activeInvitationIds);
  }

  public static String scheduleHourly() {
    return System.schedule(
      'Event Invitation Collection Status',
      '0 0 * * * ?',
      new EventInvitationService()
    );
  }

  public static void recalculateForInvitationIds(Set<Id> invitationIds) {
    if (isRecalculating || invitationIds == null || invitationIds.isEmpty()) {
      return;
    }

    List<Event_Invitation__c> invitations = [
      SELECT
        Id,
        Order__c,
        Campaign__c,
        Campaign__r.Data_Invio_Biglietto__c,
        Send_After__c,
        Status__c
      FROM Event_Invitation__c
      WHERE Id IN :invitationIds
    ];
    Set<Id> orderIds = new Set<Id>();
    for (Event_Invitation__c invitation : invitations) {
      if (invitation.Order__c != null) {
        orderIds.add(invitation.Order__c);
      }
    }

    Map<String, CollectionSummary> summaryByKey = new Map<String, CollectionSummary>();
    if (!orderIds.isEmpty()) {
      for (Asset ticket : [
        SELECT Status, Campaign__c, Order_Product__r.OrderId
        FROM Asset
        WHERE
          Order_Product__r.OrderId IN :orderIds
          AND RecordType.DeveloperName = 'Ticket'
      ]) {
        String orderCampaignKey = key(
          ticket.Order_Product__r.OrderId,
          ticket.Campaign__c
        );
        CollectionSummary summary = summaryByKey.get(orderCampaignKey);
        if (summary == null) {
          summary = new CollectionSummary();
          summaryByKey.put(orderCampaignKey, summary);
        }
        summary.total++;
        if (ticket.Status == TICKET_ORDERED) {
          summary.ordered++;
        } else if (ticket.Status == TICKET_AVAILABLE) {
          summary.available++;
        } else if (ticket.Status == TICKET_WAIVED) {
          summary.waived++;
        }
      }
    }

    List<Event_Invitation__c> updates = new List<Event_Invitation__c>();
    for (Event_Invitation__c invitation : invitations) {
      if (invitation.Status__c == COLLECTION_CANCELLED) {
        continue;
      }
      DateTime desiredSendAfter = invitation.Campaign__r == null ||
        invitation.Campaign__r.Data_Invio_Biglietto__c == null
        ? null
        : DateTime.newInstance(
            invitation.Campaign__r.Data_Invio_Biglietto__c,
            Time.newInstance(0, 0, 0, 0)
          );
      CollectionSummary summary = summaryByKey.get(
        key(invitation.Order__c, invitation.Campaign__c)
      );
      String desiredStatus;
      if (summary == null || summary.total == 0) {
        desiredStatus = COLLECTION_PENDING;
      } else if (summary.available > 0) {
        desiredStatus = COLLECTION_READY;
      } else if (summary.ordered > 0) {
        desiredStatus = COLLECTION_PENDING;
      } else if (summary.waived == summary.total) {
        desiredStatus = COLLECTION_CANCELLED;
      } else {
        desiredStatus = COLLECTION_COMPLETED;
      }
      if (
        invitation.Status__c != desiredStatus ||
        invitation.Send_After__c != desiredSendAfter
      ) {
        updates.add(
          new Event_Invitation__c(
            Id = invitation.Id,
            Send_After__c = desiredSendAfter,
            Status__c = desiredStatus
          )
        );
      }
    }

    if (!updates.isEmpty()) {
      isRecalculating = true;
      try {
        update updates;
      } finally {
        isRecalculating = false;
      }
    }
  }

  private static void rejectExistingOrderCampaignLinks(
    List<Event_Invitation__c> invitations,
    Set<String> orderCampaignKeys
  ) {
    if (orderCampaignKeys.isEmpty()) {
      return;
    }

    Set<Id> orderIds = new Set<Id>();
    for (Event_Invitation__c invitation : invitations) {
      if (invitation.Order__c != null) {
        orderIds.add(invitation.Order__c);
      }
    }

    Map<String, Id> existingInvitationIdByKey = new Map<String, Id>();
    for (Event_Invitation__c existing : [
      SELECT Id, Order__c, Campaign__c
      FROM Event_Invitation__c
      WHERE Order__c IN :orderIds
    ]) {
      existingInvitationIdByKey.put(
        key(existing.Order__c, existing.Campaign__c),
        existing.Id
      );
    }

    for (Event_Invitation__c invitation : invitations) {
      Id existingId = existingInvitationIdByKey.get(
        key(invitation.Order__c, invitation.Campaign__c)
      );
      if (existingId != null && existingId != invitation.Id) {
        invitation.Order__c.addError(
          'Esiste gia un link evento per questo ordine e questa campagna.'
        );
      }
    }
  }

  private static String key(Id orderId, Id campaignId) {
    if (orderId == null) {
      return null;
    }
    return campaignId == null
      ? String.valueOf(orderId)
      : String.valueOf(orderId) + ':' + String.valueOf(campaignId);
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
