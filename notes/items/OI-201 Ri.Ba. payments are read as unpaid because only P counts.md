---
id: OI-201
type: open-item
status: open
owner: Aurel Mrruku
org: ROMI
raised: 2026-10-02
updated: 2026-10-02
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

| Step | Where |
| --- | --- |
| `deadline.paid` | `MexalScadenzarioSearchService.mapDeadlines` |
| `mapping.paid` | `MexalInvoiceOrderLineMappingService.matchPaymentDeadlines` |
| `OrderItem.Mexal_Payment_Status__c = 'Paid'` | `MexalInvoiceOrderLineMappingService.resolveOrderItemPaymentStatus` |
| `Tranche__c.Completamente_Pagata__c` / `Stato__c` | `OrderItemTriggerHandler.recalculateTranches` |
| Asset → `Disponibile` | `OrderItemTriggerHandler.markTicketsAvailableForFullyPaidTranches` |
| Order → `Incassato` | `OrderItemTriggerHandler.markOrdersCollectedForFullyPaidTranches` |
| Opportunity → `Chiusa/Vinta` | `OrderTriggerHandler.closeWonOpportunitiesForConfirmedOrders` |
| Contract `importo incassato` | `PerformancePlusContractService.refreshAmounts` |

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
