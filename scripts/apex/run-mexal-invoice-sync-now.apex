// Runs the Mexal invoice sync once, now, without waiting for the 03:30 job:
// invoices -> invoice lines -> scadenzario, then order lines and tranches.
// Each step reads what changed in Mexal since its last successful run (24 hours
// on the first run). Logs to Integration_Log__c as
// Mexal_Fatture_Scadenzario_Sync.
//
// Run the customer sync first if new Mexal customers may be involved: invoices
// are linked to Accounts by Mexal customer code.
//
//   sf apex run --target-org "Pienissimo UAT" --file scripts/apex/run-mexal-invoice-sync-now.apex

System.debug('Queueable job: ' + System.enqueueJob(new MexalInvoiceSyncJob()));
