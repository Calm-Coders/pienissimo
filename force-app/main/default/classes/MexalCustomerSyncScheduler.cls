public with sharing class MexalCustomerSyncScheduler implements Schedulable {
  public static final String JOB_NAME = 'Mexal Sync - Nightly';
  public static final String NIGHTLY_0200_CRON = '0 0 2 * * ?';

  public void execute(SchedulableContext context) {
    Database.executeBatch(new MexalCustomerSyncBatch(), 1);
    Database.executeBatch(new MexalArticleSyncBatch(), 1);
    Database.executeBatch(new MexalMaggazinoSyncBatch(), 1);
  }

  public static Id scheduleNightly() {
    return System.schedule(
      JOB_NAME,
      NIGHTLY_0200_CRON,
      new MexalCustomerSyncScheduler()
    );
  }
}
