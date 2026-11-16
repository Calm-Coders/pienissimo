public without sharing class MexalInvoiceSyncScheduler implements Schedulable {
  // Two runs a day, 05:30 and 13:30 (approved by the client, 2026-11-16).
  // After the customer sync (:15), so new Mexal customer codes are already on
  // their Accounts when the invoices are linked.
  public static final String JOB_NAME_0530 = 'Mexal Fatture e Scadenziario Sync - 05:30';
  public static final String JOB_NAME_1330 = 'Mexal Fatture e Scadenziario Sync - 13:30';
  public static final String CRON_0530 = '0 30 5 * * ?';
  public static final String CRON_1330 = '0 30 13 * * ?';
  // The single nightly job used until 2026-11-16 (03:30).
  public static final String LEGACY_JOB_NAME = 'Mexal Fatture e Scadenziario Sync - Nightly';

  public void execute(SchedulableContext context) {
    System.enqueueJob(new MexalInvoiceSyncJob());
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
        JOB_NAME_0530 + suffix,
        CRON_0530,
        new MexalInvoiceSyncScheduler()
      ),
      System.schedule(
        JOB_NAME_1330 + suffix,
        CRON_1330,
        new MexalInvoiceSyncScheduler()
      )
    };
  }
}
