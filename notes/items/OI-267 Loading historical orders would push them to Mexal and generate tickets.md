---
id: OI-267
type: open-item
status: open
owner: Aurel Mrruku
org: ROMI
raised: 2026-10-20
updated: 2026-10-29
depends_on: []
blocks: [OI-244, OI-274, go-live]
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

## 2026-10-21 — a bypass was agreed, and it is the one this note asked for

🟢 At [the afternoon design session](../meetings/2026-10-21%20Tema%20Migrazione.md)
Aurel Mrruku committed to exactly the suppression this note said was missing:

> _"Io posso fare in modo che io genero l'ordine in Sales force e non invio
> l'ordine su M[ex]al perché c'è anche questo problema e perché c'è un
> automatismo. Ogni volta che si crea un ordine su sales force viene inviato verso
> MEX[A]L. Quindi devo bloccare l'invio dell'ordine su [M]ex[a]l, devo salvare in
> questa chiave le informazioni che ci sono già su Mexal, quindi l'ID dell'ordine."_

So the design is: suppress transmission, and instead store the **Mexal order key
the record already has** — `sigla` + `serie` + `numero` + `data ordine`
([OI-275](OI-275%20The%20Mexal%20order%20key%20is%20not%20unique%20without%20the%20order%20date.md)) —
so that invoices arriving later still match. That answers the question this note
left open, which was how a migrated order would ever reconcile if it never went
to Mexal.

🟢 **The ticket side is also addressed, differently from what this note assumed.**
Assets _will_ be generated by the import, deliberately, and the unwanted ones are
mass-deleted afterwards via dummy editions —
[OI-276](OI-276%20Dummy%20import%20editions%20are%20needed%20to%20load%20historical%20orders.md).
The Performance Plus contract automation is bypassed as well —
[OI-280](OI-280%20Performance%20Plus%20contract%20generation%20must%20be%20bypassed%20for%20migrated%20orders.md).

🔴 **Nothing is built.** `AUTOMATIC_MEXAL_CREATION_ENABLED` is still `true` and
`Origine__c` is still unchecked on `origin/DevMain` at `228be1d`; none of today's
four commits touches `OrderMexalIntegrationService.cls`. The note stays `open` and
gating until the condition exists in source.

⚠ **It is a migration-only condition that has to come back out.** Aurel Mrruku
said so for the edizione reversal — _"quando andremo in produzione dopo il
caricamento massivo, io devo ricambiare queste logiche perché deve stare il flusso
quello normale"_ — and the same applies to the Mexal suppression and the contract
bypass. **Nothing records who removes them, when, or how it is verified** — and
they are being added days before a live go-live.

## 🟡 2026-10-28 - the Mexal send is bypassed for `Origine__c = 'Mexal'`, in UAT only

On Aurel Mrruku's request, `OrderMexalIntegrationService.enqueueForCreatedOrders`
now skips any order with `Origine__c = 'Mexal'`. That method, called from
`OrderTriggerHandler.afterInsert`, is the only automatic entry point to the Mexal
order send. Deployed to **Pienissimo UAT** only. Before the deploy the UAT class
was identical to the repository's. Not committed, and not in Prod.

Verified with a rolled-back anonymous insert in UAT: a `Mexal`-origin order
stays with a blank `Mexal_Integration_Status__c`, and no queueable is
enqueued.

Still open from this note: the import script must set `Origine__c = 'Mexal'`.
The agent overwrite in `beforeInsert` is unchanged. Tickets are still created
for ticket lines: the edizione now resolves for every line of the 23/10 file,
see [OI-244](OI-244%20Historical%20orders%20will%20be%20migrated%20from%20Mexal%20by%20spreadsheet.md),
but 1,446 lines land on a future event.

## 🔴 2026-10-28 - every Mexal call is blocked in UAT, on Aurel Mrruku's order

At 15:12 UTC a Mexal customer-creation error email went out. Its source was
**not** the historical load. A UAT Account created that afternoon without a
Mexal code had its quote signed through DocuSign, and the signature created a
`Salesforce`-origin order. As that account's first order, the integration
tried an Anticipay check (404), a Mexal customer creation (400, so nothing was
created in Mexal) and the order send, which failed.

Aurel Mrruku then ordered that every call to Mexal be blocked, customers
included. In **Pienissimo UAT**:

- The named credential `Mexal` is set to `calloutStatus = Disabled`. Every
  Mexal callout routes through it: customers, orders, articles, invoices and
  searches. A read-only search now fails with no HTTP status.
- The three nightly jobs are aborted: `Mexal Articoli Sync - Nightly`
  (`0 0 1 * * ?`), `Mexal Sync - Nightly` (`0 0 2 * * ?`) and
  `Mexal Fatture e Scadenziario Sync - Nightly` (`0 30 3 * * ?`).

To restore: set the named credential back to `Enabled` (same URL) and
reschedule the three jobs. Prod was not changed.

🟢 **Fully reopened the same day, on Aurel Mrruku's request.** The named
credential `Mexal` is back to `Enabled`, with the URL unchanged. The three
nightly jobs were rescheduled through each scheduler's `scheduleNightly()`,
with the same names, crons and owner (Aurel Mrruku) and timezone
Europe/Rome; all three are in `WAITING`. The first run is the night of 29/10.
The `Origine__c = 'Mexal'` send bypass stays in place.

🟢 **2026-10-29 - the `Origine__c = 'Mexal'` send bypass is in Prod** (quick deploy
`0AfSW000001KQU20AO`, 168/168 tests). The production load is no longer blocked
by the Mexal send; the agent overwrite and ticket generation still apply.

🟡 **2026-10-29 - Prod has the Mexal action configuration, but no token.** On
Aurel Mrruku's request the 10 `Integration_Configuration2__c` Mexal rows were
copied from UAT to Prod, without sync cursors (empty API-key and token fields
in UAT too). A read-only article search from Prod as Tech Romi then failed
before sending: `Field Mexal_External_Credential.MexalToken does not exist`.
Tech Romi does have access to `Mexal_Principal` through `Full_Permission`, so the
`MexalToken` authentication parameter has not been entered on the Prod
principal yet. That is a manual Setup step. Until it is done, every Prod Mexal
call (customer, order, invoice) fails, and no Mexal nightly job is scheduled in Prod.

🟢 **2026-10-29 (later) - Prod reaches Mexal.** After the token was entered on the
Prod principal, the same read-only article search from Prod returned HTTP 200
with data. From now on, Prod customer and order creation sends to Mexal for real.
Still open: whether UAT stops writing to the same Mexal company, and
scheduling the Prod nightly jobs.
