public without sharing class MexalArticleSyncScheduler implements Schedulable {
  // Two runs a day, 05:00 and 13:00 (approved by the client, 2026-11-16).
  // Customers follow at :15 and invoices at :30.
  public static final String JOB_NAME_0500 = 'Mexal Articoli Sync - 05:00';
  public static final String JOB_NAME_1300 = 'Mexal Articoli Sync - 13:00';
  public static final String CRON_0500 = '0 0 5 * * ?';
  public static final String CRON_1300 = '0 0 13 * * ?';
  // The single nightly job used until 2026-11-16 (01:00).
  public static final String LEGACY_JOB_NAME = 'Mexal Articoli Sync - Nightly';

  public void execute(SchedulableContext context) {
    Database.executeBatch(new MexalArticleSyncBatch(), 1);
  }

  // The cron runs in the time zone of the user who schedules the job.
  public static List<Id> scheduleDaily() {
    return new List<Id>{
      System.schedule(
        JOB_NAME_0500,
        CRON_0500,
        new MexalArticleSyncScheduler()
      ),
      System.schedule(JOB_NAME_1300, CRON_1300, new MexalArticleSyncScheduler())
    };
  }
}
