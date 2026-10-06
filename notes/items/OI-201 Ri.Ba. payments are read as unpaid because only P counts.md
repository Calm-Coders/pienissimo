---
id: OI-201
type: open-item
status: resolved
owner: Aurel Mrruku
org: ROMI
raised: 2026-10-02
updated: 2026-10-06
depends_on: [OI-69]
blocks: [OI-75, OI-141, go-live]
severity: gating
requirement: ORD-14
source: notes/meetings/2026-10-02 Interna Pre-UAT Plus.md
---

# OI-201 - Ri.Ba. payments are read as unpaid because only P counts

**Kreosoft confirmed in writing on 02/10 that the Mexal scadenziario field
`stato_pagamento` has exactly three values — empty, `P` and `E` — and that `E`
(Ri.Ba. issued) is to be counted as paid, the same as `P`. The repository counts
only `P`. Every invoice settled by Ri.Ba. therefore reads as unpaid, and the
whole availability chain stalls behind it.**

## The contract, as stated by the ERP vendor

Aurel Mrruku asked Mirko Merendi at **14:55Z** on 02/10, having seen `"E"` come
back from the live Scadenziario call. Mirko Merendi answered at **15:11Z**:

> _"In merito allo stato pagamento, `"E"` riguarda l'emissione della Ri.Ba.,
> quindi a mio parere puoi considerarla pagata al pari dello stato `"P"`.
> Di conseguenza, gli unici stati da considerare sono: vuoto, P ed E."_

Thread `Ordine cliente`, Kreosoft ↔ ROMI ↔ Pienissimo, 02/10. This is the first
time the value domain of this field has been stated by its owner.

## 🔴 What the repository does

`MexalScadenzarioSearchService.cls:205`:

```apex
deadline.paid = deadline.paymentStatus == 'P';
```

`E` is not matched, so a Ri.Ba.-settled deadline is `paid = false`.

## 🔴 The chain it blocks

Every step below is in `DevMain` at `6778b58` and reads the flag above.

| Step                                              | Where                                                               |
| ------------------------------------------------- | ------------------------------------------------------------------- |
| `deadline.paid`                                   | `MexalScadenzarioSearchService.mapDeadlines`                        |
| `mapping.paid`                                    | `MexalInvoiceOrderLineMappingService.matchPaymentDeadlines`         |
| `OrderItem.Mexal_Payment_Status__c = 'Paid'`      | `MexalInvoiceOrderLineMappingService.resolveOrderItemPaymentStatus` |
| `Tranche__c.Completamente_Pagata__c` / `Stato__c` | `OrderItemTriggerHandler.recalculateTranches`                       |
| Asset → `Disponibile`                             | `OrderItemTriggerHandler.markTicketsAvailableForFullyPaidTranches`  |
| Order → `Incassato`                               | `OrderItemTriggerHandler.markOrdersCollectedForFullyPaidTranches`   |
| Opportunity → `Chiusa/Vinta`                      | `OrderTriggerHandler.closeWonOpportunitiesForConfirmedOrders`       |
| Contract `importo incassato`                      | `PerformancePlusContractService.refreshAmounts`                     |

So for a customer who pays by Ri.Ba.: **the tranche never goes `Pagata`, the
tickets never go `Disponibile`, the order never reaches `Incassato`, the
opportunity never closes won, and the Performance Plus contract under-reports
what has been collected** — indefinitely, because nothing else ever sets the
flag.

Ri.Ba. is an ordinary Italian collection method, not an edge case, and Aurel
Mrruku has already seen `[[1, "E"]]` in live data.

## Why it is time-critical

- **`Scadenziario / Scoperto Cliente (GET)` is on the agenda of the client
  integration UAT on Wednesday 07/10, 10:00–13:00.**
- The production deploy is **over the weekend 03–04/10**, from `DevMain`.
- Aurel Mrruku said so himself at the 02/10 Pre-UAT, before Mirko's answer
  arrived: _"The problem is that if we start testing and the values are not
  defined, it's going to be a mess."_

## The rule Aurel Mrruku stated, once the answer had landed

Spoken at the Pre-UAT and the nearest thing to a specification that exists:

- lookup is `ricerca scadenziario` **per codice cliente**;
- a scadenziario row exists for that customer → the invoice exists → **fatturata**;
- row present, no `P` and no `E` → **fatturata, non incassata**;
- **`P` or `E` → incassata**;
- no scadenziario row at all → no payment information for that invoice.

⚠ **He also said it still needs the client's confirmation** — _"but we need
confirm by them"_ — and undertook to write it down: _"I'm going to type it
today."_ Nothing in this sweep shows that it was written down.

## 🟢 The picklist already has room for the distinction

`OrderItem.Mexal_Payment_Status__c` is a restricted picklist with four values:
`Invoiced`, `Paid`, `Unpaid`, `No Payment Match`. `resolveOrderItemPaymentStatus`
only ever writes the last three; **`Invoiced` is defined and never set.** The
four values map onto Aurel Mrruku's rule above almost exactly, so the fix is a
value test, not a data-model change.

## What closing it looks like

One predicate — `'P'` or `'E'` — plus a decision on whether `Invoiced` should
carry the fatturata-non-incassata case that `Unpaid` currently carries. ⚠ **This
procedure does not change Apex**; it is recorded here because the vendor's answer
arrived four hours before the deploy weekend and nothing in the repository has
moved since.

## 🔴 2026-10-05 - three days on, the line is unchanged and the state list is now owed twice

Checked against `DevMain` `d526189`: `MexalScadenzarioSearchService.cls:205`
still reads

```apex
deadline.paid = deadline.paymentStatus == 'P';
```

Mirko Merendi's written answer landed 02/10 at 15:11Z. Since then the
production deploy weekend has happened, fourteen commits have landed and five
PRs have merged — **none of them touches this predicate.** Nothing in Gmail,
Slack or Drive in the 02/10–05/10 window records a decision on it.

🔑 **The client has now been asked for the same list.** At
[the 05/10 UAT](../meetings/2026-10-05%20UAT%20Performance%20Plus%20e%20Gestione%20date%20pagamento.md)
Fabrizio Paganelli was assigned:

> _"Mappare stati scadenziario: Identificare tutti i possibili stati e codici
> presenti nello scadenziario di Mexal. Fornire una lista completa per
> configurare correttamente la distinzione tra fatturato e incassato nel
> database."_

So the vendor has answered and the client has been tasked with answering, while
the one line that consumes the answer is untouched. ⚠ Nobody in the session
mentioned that the answer already exists in writing on the `Ordine cliente`
thread, which Fabrizio Paganelli is himself on.

🔴 **It now blocks a second item.**
[OI-208](OI-208%20Overdue%20and%20upcoming%20payments%20are%20not%20distinguished%20on%20the%20contract.md)
asks for unsettled amounts split into `scaduto` and `a scadere`. While `E`
reads as unpaid, every Ri.Ba.-settled invoice past due appears as overdue — in
a view built for Fabrizio Paganelli.

**Next:** `Scadenziario (GET)` is on the WooCommerce/Mexal UAT agenda for
07/10, and `[ROMI-PIENISSIMO] - Temi Integrazione Mexal` is booked **07/10
12:15–13:00** with Mirko Merendi in the room. ⚠ The two overlap.

## 🟢 2026-10-06 - resolved in the new invoice import, UAT check pending

**Decision (Aurel Mrruku, 06/10):** Kreosoft's answer is enough. `E` counts as
paid, like `P`. No further client confirmation is needed for this item.

**Where it is implemented:** the payment state is no longer read from
`MexalScadenzarioSearchService`. The new import saves each Mexal rate as a
`Scadenza_Fattura__c` record, and the formula `Scadenza_Fattura__c.Pagata__c`
is `OR(ISPICKVAL(Stato_Pagamento_Mexal__c, "P"), ISPICKVAL(Stato_Pagamento_Mexal__c, "E"))`.
The rate then drives the rest of the chain:

| Step                                                    | Where                                                                       |
| ------------------------------------------------------- | --------------------------------------------------------------------------- |
| Rate saved, `Pagata__c` = `P` or `E`                    | `MexalInvoiceImportService.saveDeadlines`                                   |
| `OrderItem.Mexal_Payment_Status__c` = `Paid` / `Unpaid` | `MexalInvoiceImportService.linkOrderLines`, `ScadenzaFatturaTriggerHandler` |
| Invoice with no matched rate → `Invoiced`               | `MexalInvoiceLineImportBatch`                                               |
| Tranche, tickets, order, opportunity                    | `OrderItemTriggerHandler`, unchanged                                        |

This also settles the `Invoiced` question above: a line invoiced but not yet
matched to a rate is `Invoiced`, a matched rate gives `Paid` or `Unpaid`.

The nightly job `MexalInvoiceSyncJob` (scheduler `MexalInvoiceSyncScheduler`,
03:30) runs invoices, then their lines, then the scadenzario.
`MexalMaggazinoSyncBatch`, the only caller of the old `'P'`-only test, has
been removed from the nightly scheduler. `MexalScadenzarioSearchService.cls:205`
still reads `== 'P'`, but nothing scheduled uses it any more.

⚠ **What remains:**

- The code is in the working tree only: not committed, not deployed. A
  dry-run deploy to Pienissimo UAT compiled.
- Verify in UAT, after the deploy, on one invoice settled by Ri.Ba.: the rate
  reads `Pagata`, the order line `Paid`, and the tranche follows.
- A Ri.Ba. returned unpaid is the `Insoluto` question,
  [OI-206](OI-206%20The%20Insoluto%20concept%20has%20no%20invoice%20due%20date%20and%20no%20invoice%20record.md),
  not this item.

## 🟢 2026-10-06 (nightly sweep) - it is committed, and the old predicate was fixed too

Two corrections to the section above, both verified against `origin/DevMain`
**`59d4264`**:

🟢 **The code is committed.** `731c7ac` ("Preparazione UAT invio ordine", Aurel
Mrruku, 20:06 CEST) carries `MexalInvoiceImportService` (635 lines),
`MexalInvoiceLineImportBatch` (539), `MexalInvoiceSyncJob` (142),
`MexalInvoiceSyncScheduler`, and the new `Fattura__c` and `Scadenza_Fattura__c`
objects. The "working tree only, not committed" note above was written before
that commit and is superseded.

🟢 **`MexalScadenzarioSearchService` no longer tests `'P'` alone.** The sentence
above — _"still reads `== 'P'`, but nothing scheduled uses it any more"_ — is out
of date. The predicate now reads:

```apex
deadline.paid =
  deadline.paymentStatus == 'P' ||
  deadline.paymentStatus == 'E';
```

**Fixed by Anita Aga in `b74c8c4`**, _"Added field for Mexal, added mapping on
Mexal order creation flux, fixed the logic in anticipay"_, committed **2026-10-05
at 18:46:01 +0200** — i.e. **before the previous sweep's 22:00Z watermark, on an
unmerged branch.** The 05/10 report's "did not move at `d526189`" was correct for
`DevMain` and blind to the branch. It reached `DevMain` today through **PR #81**
(merge `c9f8ae0`, 12:23 CEST).

So **both** paths now count `E` as paid: the live scadenzario search service and
the new nightly rate records. The item is resolved in code on the merged branch.

⚠ **Unchanged:** nothing is verified against real data and nothing is in Prod.
The UAT check on one Ri.Ba.-settled invoice — rate `Pagata`, order line `Paid`,
tranche follows — is **still owed**, and `Scadenziario (GET)` is on the client
agenda for **07/10 12:15**. Prod has no `Integration_Configuration2__c` rows for
Mexal and no Mexal job scheduled.
