---
id: OI-267
type: open-item
status: open
owner: Aurel Mrruku
org: ROMI
raised: 2026-10-20
updated: 2026-10-20
depends_on: []
blocks: [OI-244, go-live]
severity: gating
source: force-app/main/default/classes/OrderMexalIntegrationService.cls
---

# OI-267 - Loading historical orders would push them to Mexal and generate tickets

**Inserting a historical order into Salesforce today runs the same automation as a
new sale. Nothing in the order triggers distinguishes a migrated order, so the
spreadsheet migration in
[OI-244](OI-244%20Historical%20orders%20will%20be%20migrated%20from%20Mexal%20by%20spreadsheet.md)
cannot be loaded — not even the small UAT test batch — until a bypass exists.**

Found by reading the source on `DevMain` at `9fe42fb`, 2026-10-20. No load was
attempted.

## What fires on insert

| Trigger                         | Effect on a migrated record                                                                                                                                                                                                                                 |
| ------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `OrderTrigger` after insert     | `OrderMexalIntegrationService.enqueueForCreatedOrders` queues **every** order with an `AccountId` for creation in Mexal, and treats the first order per account as a first order. `AUTOMATIC_MEXAL_CREATION_ENABLED = true`; `Origine__c` is never checked. |
| — in a sandbox                  | `ALLOW_MEXAL_QUEUE_IN_SANDBOX = true` in both the service and the queueable, so UAT sends too — to the **live Mexal company**, series `10` ([the Mexal integration](../flows/The%20Mexal%20integration.md)).                                                |
| `OrderTrigger` before insert    | Overwrites `Codice_Agente__c` from the Account's **current** agent when there is no Quote — the historical agent on the order is lost.                                                                                                                      |
| `OrderItemTrigger` after insert | `OrderTriggerHandler.createTicketsForOrderLines` creates ticket assets for any line whose product has `Genera_Biglietto__c` — tickets for past events.                                                                                                      |

## Also needed before a load

- **No external-id key on Order or OrderItem for Mexal.** `ID_Ordine_Mexal__c` is
  a formula and `WooCommerce_Order_Key__c` is the only external id, so an upsert
  load has nothing to key on. A Mexal order key (sigla, serie, year if numbering
  restarts yearly, number) and a line key are needed.
- **Prod is behind UAT on the fields the load uses** (describe, 2026-10-20):
  `Order.Codice_Agente__c`, `Order.Quote__c`, `Order.Mexal_Integration_Error__c`,
  `OrderItem.Data_Scadenza__c`, `Tranche__c`, `Fattura__c`,
  `Scadenza_Fattura__c` are absent for the CLI user, the `Excluded` value of
  `Mexal_Integration_Status__c` is missing, and `Fattura__c` / `Riga_Fattura__c`
  are not queryable at all.
- **Prod has 16 Accounts, none with `Codice_Cliente_Mexal__c`, and two active
  price book entries.** UAT has 8,146 Mexal-coded Accounts and 1,100 coded
  products but only 81 active standard price book entries. Every article on a
  historical line needs an active entry before its line can insert.
  ⚠ Rechecked the same day: every coded UAT product **has** a standard entry
  (1,119), but **1,038 entries are inactive**, all on inactive products — the
  ones the 09/10 `cod_grp_merc` alignment switched off, which are exactly the
  historical articles. `PricebookEntryId` is required on `OrderItem` and has no
  external id, so the line file must be resolved to ids before the load, and
  the inactive entries reactivated for the load window and switched off after.
- **Existing UAT invoices will not relink by themselves.**
  `MexalInvoiceLineImportBatch` only picks invoices that have no lines yet, and
  513 of 515 UAT invoices have no `Ordine__c`. Relinking after the order load
  needs its own run.

Closing it means: a migration bypass (on `Origine__c = 'Mexal'` or an explicit
switch) covering all three triggers, the two external-id fields, and the Prod
metadata gap closed — deployed to UAT before the first test batch.
