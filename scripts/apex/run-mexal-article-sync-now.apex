// Runs the Mexal article sync once, now, without waiting for the 01:00 job.
// Reads articles modified in Mexal since the last successful run (24 hours on
// the first run) into Product2. Logs to Integration_Log__c as
// Mexal_Articoli_Sync.
//
//   sf apex run --target-org "Pienissimo UAT" --file scripts/apex/run-mexal-article-sync-now.apex

System.debug(
  'Batch job: ' + Database.executeBatch(new MexalArticleSyncBatch(), 1)
);
