public without sharing class MexalArticleSyncScheduler implements Schedulable {
  public static final String JOB_NAME = 'Mexal Articoli Sync - Nightly';
  public static final String NIGHTLY_0100_CRON = '0 0 1 * * ?';

  public void execute(SchedulableContext context) {
    Database.executeBatch(new MexalArticleSyncBatch(), 1);
  }

  // The cron runs in the time zone of the user who schedules the job.
  public static Id scheduleNightly() {
    return System.schedule(
      JOB_NAME,
      NIGHTLY_0100_CRON,
      new MexalArticleSyncScheduler()
    );
  }
}
