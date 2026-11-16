// Removes the Mexal syncs scheduled by
// scripts/apex/schedule-mexal-nightly-syncs.apex (the six 05:xx / 13:xx jobs),
// and the old 01:00 / 02:00 / 03:30 nightly jobs if still present. Other
// scheduled jobs are left alone.
//
//   sf apex run --target-org "Pienissimo UAT" --file scripts/apex/unschedule-mexal-nightly-syncs.apex

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
