// Schedules the three nightly Mexal syncs, in the order they depend on:
//   01:00  Mexal Articoli Sync - Nightly                 (MexalArticleSyncScheduler)
//   02:00  Mexal Sync - Nightly (customers)              (MexalCustomerSyncScheduler)
//   03:30  Mexal Fatture e Scadenziario Sync - Nightly   (MexalInvoiceSyncScheduler)
//
// The cron runs in the time zone of the user who runs this script: run it as a
// user on Europe/Rome. Safe to re-run: a job already scheduled under the same
// name is aborted and scheduled again.
//
//   sf apex run --target-org "Pienissimo UAT" --file scripts/apex/schedule-mexal-nightly-syncs.apex
//
// Check the result with scripts/soql/scheduled-apex-jobs.soql.

Set<String> jobNames = new Set<String>{
  MexalArticleSyncScheduler.JOB_NAME,
  MexalCustomerSyncScheduler.JOB_NAME,
  MexalInvoiceSyncScheduler.JOB_NAME
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
  'Scheduled articles: ' + MexalArticleSyncScheduler.scheduleNightly()
);
System.debug(
  'Scheduled customers: ' + MexalCustomerSyncScheduler.scheduleNightly()
);
System.debug(
  'Scheduled invoices: ' + MexalInvoiceSyncScheduler.scheduleNightly()
);
