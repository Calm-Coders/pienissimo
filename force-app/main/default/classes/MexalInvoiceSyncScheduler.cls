public with sharing class MexalInvoiceSyncScheduler implements Schedulable {
  public static final String JOB_NAME = 'Mexal Fatture e Scadenziario Sync - Nightly';
  // After the 02:00 customer sync, so new Mexal customer codes are already on
  // their Accounts when the invoices are linked.
  public static final String NIGHTLY_0330_CRON = '0 30 3 * * ?';

  public void execute(SchedulableContext context) {
    System.enqueueJob(new MexalInvoiceSyncJob());
  }

  // The cron runs in the time zone of the user who schedules the job.
  public static Id scheduleNightly() {
    return System.schedule(
      JOB_NAME,
      NIGHTLY_0330_CRON,
      new MexalInvoiceSyncScheduler()
    );
  }
}
