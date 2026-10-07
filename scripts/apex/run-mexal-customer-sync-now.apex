// Runs the Mexal customer sync once, now, without waiting for the 02:00 job.
// Reads customers modified in Mexal since the last successful run (24 hours on
// the first run) into Account. Logs to Integration_Log__c as
// Mexal_Clienti_Sync.
//
//   sf apex run --target-org "Pienissimo UAT" --file scripts/apex/run-mexal-customer-sync-now.apex

System.debug(
  'Batch job: ' + Database.executeBatch(new MexalCustomerSyncBatch(), 1)
);
