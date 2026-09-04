public with sharing class AnticipayOrderAutomation {
  public static void enqueueForFirstOrders(List<Order> newOrders) {
    if (newOrders == null || newOrders.isEmpty()) {
      return;
    }

    Set<Id> orderIds = new Set<Id>();
    Set<Id> accountIds = new Set<Id>();
    Map<Id, Id> firstOrderIdByAccountId = new Map<Id, Id>();
    for (Order orderRecord : newOrders) {
      if (orderRecord.Id != null) {
        orderIds.add(orderRecord.Id);
      }
      if (orderRecord.AccountId != null) {
        accountIds.add(orderRecord.AccountId);
        if (!firstOrderIdByAccountId.containsKey(orderRecord.AccountId)) {
          firstOrderIdByAccountId.put(orderRecord.AccountId, orderRecord.Id);
        }
      }
    }

    if (accountIds.isEmpty()) {
      return;
    }

    Set<Id> accountsWithPreviousOrders = new Set<Id>();
    for (AggregateResult result : [
      SELECT AccountId accountId
      FROM Order
      WHERE AccountId IN :accountIds AND Id NOT IN :orderIds
      GROUP BY AccountId
    ]) {
      accountsWithPreviousOrders.add((Id) result.get('accountId'));
    }

    List<Id> accountIdsToRefresh = new List<Id>();
    List<Id> sourceRecordIdsToRefresh = new List<Id>();
    for (Account accountRecord : [
      SELECT Id, Anticipay_Consolidato__c
      FROM Account
      WHERE Id IN :accountIds
    ]) {
      if (
        accountRecord.Anticipay_Consolidato__c != true &&
        !accountsWithPreviousOrders.contains(accountRecord.Id)
      ) {
        accountIdsToRefresh.add(accountRecord.Id);
        sourceRecordIdsToRefresh.add(
          firstOrderIdByAccountId.get(accountRecord.Id)
        );
      }
    }

    if (!accountIdsToRefresh.isEmpty()) {
      System.enqueueJob(
        new AnticipayAccountRefreshQueueable(
          accountIdsToRefresh,
          sourceRecordIdsToRefresh
        )
      );
    }
  }
}
