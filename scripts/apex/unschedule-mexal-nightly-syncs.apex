// Removes the three nightly Mexal syncs scheduled by
// scripts/apex/schedule-mexal-nightly-syncs.apex. Other scheduled jobs are left
// alone.
//
//   sf apex run --target-org "Pienissimo UAT" --file scripts/apex/unschedule-mexal-nightly-syncs.apex

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
