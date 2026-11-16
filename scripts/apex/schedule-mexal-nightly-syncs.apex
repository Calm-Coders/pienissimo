// Schedules the Mexal syncs: two rounds a day, one job every 15 minutes, in the
// order they depend on (approved by the client, 2026-11-16):
//   05:00 / 13:00  Mexal Articoli Sync - HH:00                (MexalArticleSyncScheduler)
//   05:15 / 13:15  Mexal Clienti Sync - HH:15                 (MexalCustomerSyncScheduler)
//   05:30 / 13:30  Mexal Fatture e Scadenziario Sync - HH:30  (MexalInvoiceSyncScheduler)
//
// The cron runs in the time zone of the user who runs this script: run it as a
// user on Europe/Rome. Safe to re-run: the six jobs, and the old 01:00 / 02:00 /
// 03:30 nightly jobs if still present, are aborted and scheduled again.
//
//   sf apex run --target-org "Pienissimo UAT" --file scripts/apex/schedule-mexal-nightly-syncs.apex
//
// Check the result with scripts/soql/scheduled-apex-jobs.soql.

Set<String> jobNames = new Set<String>{
  MexalArticleSyncScheduler.JOB_NAME_0500,
  MexalArticleSyncScheduler.JOB_NAME_1300,
  MexalArticleSyncScheduler.LEGACY_JOB_NAME,
  MexalCustomerSyncScheduler.JOB_NAME_0515,
  MexalCustomerSyncScheduler.JOB_NAME_1315,
  MexalCustomerSyncScheduler.LEGACY_JOB_NAME,
  MexalInvoiceSyncScheduler.JOB_NAME_0530,
  MexalInvoiceSyncScheduler.JOB_NAME_1330,
  MexalInvoiceSyncScheduler.LEGACY_JOB_NAME
};
for (CronTrigger existing : [
  SELECT Id, CronJobDetail.Name
  FROM CronTrigger
  WHERE CronJobDetail.Name IN :jobNames
]) {
  System.abortJob(existing.Id);
  System.debug('Aborted ' + existing.CronJobDetail.Name);
}

System.debug('Running user time zone: ' + UserInfo.getTimeZone().getID());
System.debug(
  'Scheduled articles: ' + MexalArticleSyncScheduler.scheduleDaily()
);
System.debug(
  'Scheduled customers: ' + MexalCustomerSyncScheduler.scheduleDaily()
);
System.debug(
  'Scheduled invoices: ' + MexalInvoiceSyncScheduler.scheduleDaily()
);
