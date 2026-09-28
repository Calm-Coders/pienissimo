public with sharing class AnticipayAccountRefreshQueueable implements Queueable, Database.AllowsCallouts {
  private final List<Id> accountIds;
  private final List<Id> sourceRecordIds;

  public AnticipayAccountRefreshQueueable(List<Id> accountIds) {
    this(accountIds, accountIds);
  }

  public AnticipayAccountRefreshQueueable(
    List<Id> accountIds,
    List<Id> sourceRecordIds
  ) {
    this.accountIds = accountIds == null
      ? new List<Id>()
      : new List<Id>(accountIds);
    this.sourceRecordIds = sourceRecordIds == null
      ? new List<Id>()
      : new List<Id>(sourceRecordIds);
  }

  public void execute(QueueableContext context) {
    if (accountIds.isEmpty()) {
      return;
    }

    Id accountId = accountIds.remove(0);
    Id sourceRecordId = sourceRecordIds.isEmpty()
      ? accountId
      : sourceRecordIds.remove(0);
    AnticipayAccountService.refreshAccount(accountId, sourceRecordId);

    if (!accountIds.isEmpty()) {
      System.enqueueJob(
        new AnticipayAccountRefreshQueueable(accountIds, sourceRecordIds)
      );
    }
  }
}
