---
id: risk-mexal-callout-after-dml
type: risk
status: open
severity: high
owner: Aurel Mrruku
org: ROMI
raised: 2026-09-28
updated: 2026-09-28
blocks: [go-live]
requirement: [INT-01, INT-05]
source: Apex test suite run against Pienissimo Prod (check-only), 2026-09-28; UAT Integration_Log__c rows of 2026-09-24
---

# Risk - Mexal writes fail after their own log insert

Every Mexal call made through `MexalSearchCalloutService` inserts an
`Integration_Log__c` row straight after the HTTP response. Salesforce forbids a
callout once the transaction has uncommitted DML, so **any second Mexal call in
the same transaction fails** with `System.CalloutException: You have uncommitted
work pending`.

Two production paths make a second call:

- **`MexalCustomerCreateService`**: create or update the customer, update the
  Account, then create the shipping address. The shipping-address call always
  fails. **Observed in UAT on 2026-09-24 10:37Z**: the `Mexal_Indirizzi_Spedizione_Creazione`
  log carries exactly that exception, followed by
  `Creazione indirizzo di spedizione Mexal fallita` on `Mexal_Clienti_Modifica`.
- **`MexalMaggazinoSyncBatch`**: search the warehouse movements, then the
  scadenzario, then one detail per invoice. Only the first call can succeed, so
  **the nightly payment sync can never complete**. That leaves the OrderItem
  payment status, the tranche roll-up and the automatic `Incassato` without
  their data source.

Smaller defect of the same family: `MexalMaggazinoDetailService` and
`MexalOrderSendService` parse the response body as JSON even on an HTTP
error, so a non-JSON error body throws a `JSONException` instead of being
reported. The batch and the order queueable catch it.

**The tests assert current behaviour and do not hide it.** `MexalIntegrationTest`
makes one callout per test. `warehouseBatchRecordsTheSecondCalloutFailure` and the
customer-create tests assert the failure path.

**Fix direction (not done):** collect the log rows and insert them after the
last callout in the transaction, or split each extra call into its own
queueable.
