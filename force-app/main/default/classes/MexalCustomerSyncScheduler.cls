public without sharing class MexalCustomerSyncScheduler implements Schedulable {
  // Two runs a day, 05:15 and 13:15 (approved by the client, 2026-11-16).
  public static final String JOB_NAME_0515 = 'Mexal Clienti Sync - 05:15';
  public static final String JOB_NAME_1315 = 'Mexal Clienti Sync - 13:15';
  public static final String CRON_0515 = '0 15 5 * * ?';
  public static final String CRON_1315 = '0 15 13 * * ?';
  // The single nightly job used until 2026-11-16 (02:00).
  public static final String LEGACY_JOB_NAME = 'Mexal Sync - Nightly';

  public void execute(SchedulableContext context) {
    // Articles run on their own schedule: MexalArticleSyncScheduler, :00.
    // Invoices and scadenzario too: MexalInvoiceSyncScheduler, :30.
    Database.executeBatch(new MexalCustomerSyncBatch(), 1);
  }

  // The cron runs in the time zone of the user who schedules the job.
  public static List<Id> scheduleDaily() {
    return scheduleDaily('');
  }

  // Job names are unique in the org, and a test sees the real jobs: tests pass
  // a suffix so they never collide with the live schedule.
  public static List<Id> scheduleDaily(String nameSuffix) {
    String suffix = nameSuffix == null ? '' : nameSuffix;
    return new List<Id>{
      System.schedule(
        JOB_NAME_0515 + suffix,
        CRON_0515,
        new MexalCustomerSyncScheduler()
      ),
      System.schedule(
        JOB_NAME_1315 + suffix,
        CRON_1315,
        new MexalCustomerSyncScheduler()
      )
    };
  }
}
