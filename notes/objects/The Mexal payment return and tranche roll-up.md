---
id: build-mexal-payment-tranche-rollup
type: object
status: in-progress
owner: Anita Aga
org: ROMI
raised: 2026-09-15
updated: 2026-10-14
depends_on: [OI-50, OI-116, OI-137]
requirement: [ORD-03, ORD-04, INT-01]
source: commit 400c195, Anita Aga, 2026-09-15 18:00:39 CEST, PR #45 open against DevMain
evidence: git show 400c195 --stat; OrderItemTriggerHandler.cls read in full; the five service classes read by structure
---

# The Mexal payment return and tranche roll-up

**`400c195` builds the return leg of the Mexal integration: invoice lines and
the scadenzario come back from Mexal, land on Order Items as a payment status,
and roll up onto the tranche.** This is the thing
[ORD-03 and AC-06](../items/OI-50%20Tranche%20object.md) describe, and it is the
first code on the project that closes that loop.

**30 files, +2,290 / −21, seven new Apex classes.** It is **open and unmerged**
as PR #45 ("Automation for tranch payment, added custom fields in Order and
Order…"), opened 2026-09-15 16:07:59Z, **one minute after the push** — the
fourth consecutive Mexal PR with a truncated title and no description.

## What it builds

| Component                             | Lines | What it does                                                                                  |
| ------------------------------------- | ----- | --------------------------------------------------------------------------------------------- |
| `MexalInvoiceOrderLineMappingService` | 606   | Matches Mexal invoice lines to Order Items and derives `Paid` / `Unpaid` / `No Payment Match` |
| `MexalScadenzarioSearchService`       | 332   | Calls the `Mexal_Scadenzario_Ricerca` action — the payment-schedule read                      |
| `MexalMaggazinoSyncBatch`             | 286   | A **third** nightly batch, over warehouse movements, on the same cursor service               |
| `MexalMaggazinoSearchService`         | 249   | The `ricerca` half of the warehouse read                                                      |
| `MexalMaggazinoDetailService`         | 225   | The per-document detail read, capped at 90 detail callouts per `execute`                      |
| `OrderItemTriggerHandler`             | 148   | The tranche roll-up                                                                           |
| `MexalOrderMappingService`            | 59    | Writes the Mexal document coordinates back onto the Order and its lines after a send          |

Six new fields: `Order.Mexal_Customer_Code__c`, `Mexal_Document_Sigla__c`,
`Mexal_Document_Serie__c`, `Mexal_Document_Number__c`;
`OrderItem.Mexal_Line_Number__c`, `Mexal_Payment_Status__c`.

## The roll-up implements ORD-03 as written

`OrderItemTriggerHandler.afterUpdate` recalculates a tranche whenever a line's
`Tranche__c` or `Mexal_Payment_Status__c` changes — on both the old and the new
tranche, so a line moved between tranches recalculates both. The states are
`Aperta` → `Parzialmente Pagata` → `Pagata`, and **`Pagata` is reached only when
every line on the tranche is `Paid`**, which is the requirement text:

> _"Mexal updates payment per order line; Salesforce recalculates the tranche and
> marks it fully paid only when every included line is fully paid"_ — `ORD-03`

The 2026-09-15 `org-status-check` reported that an exhaustive search of source
and deployed Apex found **only initialization to false and no roll-up writer**.
That was true of `DevMain` at `23f1375`, eight hours before this push. **It is
the writer.**

## Two other things arrived in the same commit

🟢 **[OI-117](../items/OI-117%20Administrative%20fields%20lock%20once%20the%20Mexal%20customer%20code%20is%20set.md)'s
principal is fixed.** The `Lock_Mexal_Synced_Admin_Fields` validation rule moves
from `$Profile.Name <> "System Administrator"` to
`NOT($Permission.Edit_Mexal_Synced_Admin_Fields)`, against a new custom
permission. The 3 September session asked for "editable only by amministrazione";
a literal profile name could not express that and a custom permission can. **The
red flag raised on 14 September is answered** — subject to somebody actually
assigning the permission.

🔴 **A third unscheduled batch.** `MexalCustomerSyncScheduler.execute` now runs
`MexalCustomerSyncBatch`, `MexalArticleSyncBatch` **and**
`MexalMaggazinoSyncBatch`. Three batches now depend on one `System.schedule`
call that still has not been made
([OI-116](../items/OI-116%20Nightly%20Mexal%20to%20Salesforce%20anagrafica%20sync.md)),
and the hour it runs is still unspecified — open since 3 September.

## What this does not settle

- 🔴 **It is unmerged.** Everything above is true of `DevAnita`, not `DevMain`.
- 🔴 **The scadenzario read is a read; nothing schedules it.** The batch chain
  covers customers, articles and warehouse movements. How and when the invoice
  and payment-status pass runs is not visible in this commit.
- 🔴 **It compounds the coverage position** — see
  [OI-64](../items/OI-64%20The%20bundle%20Apex%20test%20suite%20is%20broken.md) and
  [the deploy risk](../risks/Risk%20-%20production%20deploy%20is%20blocked%20by%20Apex%20coverage.md).
  Recorded as brief only; no test was written, proposed or scaffolded.
- ⚠ **`MexalMaggazinoSyncBatch` was read by structure, not line by line**, and
  the warehouse-movement sync has **no requirement id and no minuted request** in
  this record. What it is for, and who asked for it, is not established.
- ⚠ **The spelling `Maggazino` is a typo** for _magazzino_, and it is baked into
  three class names. Cheap to fix now, permanent once deployed.

## 2026-09-25 - the roll-up now reaches the order

Aurel Mrruku decided that the order goes `Incassato` when **every tranche on it** is
`Pagata`. The roll-up gained a third step,
`markOrdersCollectedForFullyPaidTranches`, after the tranche update and the ticket
release. The existing `OrderTriggerHandler` then closes the Opportunity. Written on
`DevMain`, uncommitted, not deployed. Detail and open edges:
[OI-69](../items/OI-69%20Order%20state%20model.md).

## 2026-10-06 - the invoice and scadenzario pass now saves records and is scheduled

The return leg was rebuilt around records. Invoices, invoice lines and rates
are now saved as `Fattura__c`, `Riga_Fattura__c` and `Scadenza_Fattura__c`,
and a nightly job runs them in order:

1. **Invoices:** `MexalInvoiceImportService.importInvoicesModifiedSince`.
   It reads FT movements whose Mexal `data_ult_mod` is past the cursor.
2. **Lines:** `MexalInvoiceLineImportBatch`. It links the invoice to the order
   and each order line to its invoice.
3. **Scadenzario:** `importScadenzarioModifiedSince`. It saves the rates, and
   `linkOrderLines` gives each order line its rate and `Paid` / `Unpaid`.

The tranche roll-up above is unchanged and follows from the order lines.

The job is `MexalInvoiceSyncJob`, scheduled by `MexalInvoiceSyncScheduler` at
03:30. It keeps two cursors on `Integration_Configuration2__c`:
`Mexal_Movimenti_Magazzino_Ricerca` and `Mexal_Scadenzario_Ricerca`.

🟢 **`MexalMaggazinoSyncBatch` is off `MexalCustomerSyncScheduler`.** It made
the same two Mexal searches and wrote only `Mexal_Payment_Status__c`, so the
new job replaces it. The class stays in source because `MexalIntegrationTest`
still calls it.

🟢 **A rate counts as paid on `P` or `E`**, through the `Pagata__c` formula.
That closes
[OI-201](../items/OI-201%20Ri.Ba.%20payments%20are%20read%20as%20unpaid%20because%20only%20P%20counts.md)
in code.

⚠ **Status:** working tree only, not committed or deployed. The dry-run deploy
to Pienissimo UAT compiled. Prod has none of the three invoice objects and no
Mexal row in `Integration_Configuration2__c`. Only `Full_Permission` grants
access to the three objects.

## 🔑 2026-10-14 — the return leg ran on a real invoice, in front of the client

**Until today no source recorded this path running on anything but a test. The
[14/10 e2e](../meetings/2026-10-14%20UAT%20Test%20e2e.md) drove it twice in one
session, with the client's administrative lead at the keyboard.**

The sequence, as the record has it (`01:07:56`–`01:23:29`):

1. One order — `OC 1023`, €20,000 — split into **four invoicing tranches** in
   Mexal through *emissione differita documenti*, filtered on the RSM services.
2. A trial print produced **invoice 10, €5,000**, posted automatically against
   customer **50171** with **bonifico** payment.
3. The invoice did **not** appear in Salesforce on its own. Aurel Mrruku recalled
   the **03:00 nightly job** and supplied a script to force the sync by hand in
   2–3 minutes (developer console → Debug, wait 2–4 minutes).
4. In Salesforce the **amount, the tranche and the payment state `non pagato`**
   were read in the scadenze and fatture sections, with the order roll-up showing
   **ordinato €20,000 · fatturato €5,000 · incassato €0 · da fatturare €15,000**.
5. Elisa Migliano registered the €5,000 collection to close the accounting
   entry, and ran a **second** script from the console to update the states.

🟢 **So the roll-up this note describes works on real Mexal data**, and the four
figures reconcile against a single order split into four tranches.

🔴 **The frequency is the finding.** Twice in one session the data was only
current because somebody pasted Apex into a console. The session agreed to
schedule the sync **every half hour to an hour** —
[OI-239](../items/OI-239%20The%20Mexal%20scadenzario%20sync%20must%20run%20every%20half%20hour%20and%20nothing%20schedules%20it.md)
— and nothing does. API limits were read on production in the same block:
**3,360,000 requests a month, 112,000 a day**, with each cycle costing two calls.

⚠ **`E` was still not exercised.** The payment was a bonifico, so
[OI-212](../items/OI-212%20A%20Ri.Ba.%20rate%20reads%20as%20paid%20before%20its%20due%20date.md)'s
defect — Mexal status `E` reading as paid before the due date — **did not fire
and was not tested**. A future-dated bonifico correctly read `non pagato`, which
is the predicate behaving on the one status it handles correctly.
