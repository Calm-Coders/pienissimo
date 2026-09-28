public without sharing class QuoteNegotiationAgingBatch implements Database.Batchable<SObject>, Schedulable {
  public static final String JOB_NAME = 'Quote Negotiation Aging - Daily';
  public static final String DAILY_0300_CRON = '0 0 3 * * ?';

  private static final Integer DAYS_IN_NEGOTIATION = 5;
  private static final String NEGOTIATION_STATUS = 'In Trattativa';
  private static final String AWAITING_ACCEPTANCE_STATUS = 'In Attesa Accettazione';

  public Database.QueryLocator start(Database.BatchableContext context) {
    Date cutoffDate = Date.today().addDays(-DAYS_IN_NEGOTIATION);
    Datetime fallbackCutoff = Datetime.newInstance(
      cutoffDate,
      Time.newInstance(23, 59, 59, 999)
    );
    return Database.getQueryLocator(
      [
        SELECT Id
        FROM Quote
        WHERE
          Status = :NEGOTIATION_STATUS
          AND (In_Trattativa_Dal__c <= :cutoffDate
          OR (In_Trattativa_Dal__c = NULL
          AND LastModifiedDate <= :fallbackCutoff))
      ]
    );
  }

  public void execute(Database.BatchableContext context, List<SObject> scope) {
    List<Quote> quotesToUpdate = new List<Quote>();
    for (SObject record : scope) {
      quotesToUpdate.add(
        new Quote(Id = record.Id, Status = AWAITING_ACCEPTANCE_STATUS)
      );
    }

    if (!quotesToUpdate.isEmpty()) {
      Database.update(quotesToUpdate, false);
    }
  }

  public void finish(Database.BatchableContext context) {
  }

  public void execute(SchedulableContext context) {
    Database.executeBatch(new QuoteNegotiationAgingBatch(), 200);
  }

  public static Id scheduleDaily() {
    return System.schedule(
      JOB_NAME,
      DAILY_0300_CRON,
      new QuoteNegotiationAgingBatch()
    );
  }
}
