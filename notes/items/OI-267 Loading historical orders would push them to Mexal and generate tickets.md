---
id: OI-267
type: open-item
status: open
owner: Aurel Mrruku
org: ROMI
raised: 2026-10-20
updated: 2026-10-21
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
Assets *will* be generated by the import, deliberately, and the unwanted ones are
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
