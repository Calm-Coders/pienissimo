---
id: OI-198
type: open-item
status: open
owner: Aurel Mrruku
org: ROMI
raised: 2026-09-30
updated: 2026-09-30
depends_on: [OI-50, OI-75]
blocks: [OI-197]
requirement: BIG-17
source: notes/meetings/2026-09-30 Post UAT.md
---

# OI-198 - The asset does not say which tranche paid for it

**The client made ticket availability conditional on the specific tranche behind
that ticket being invoiced and collected. The Asset object has no field naming
that tranche, so neither the participant page nor the marketing filter can
implement the rule as stated.**

## The rule it has to serve

Fabrizio Paganelli, [30/09 UAT](../meetings/2026-09-30%20UAT%20Biglietti%20Asset%20Campagne%20ed%20Eventi.md)
(`01:30:33`):

> _"All'interno di un ordine bundle i biglietti si rendono disponibili se i
> biglietti contenuti in quella tranche hanno una fattura e hanno un incasso."_

So availability is **per tranche within the order**, not per order. A bundle whose
instalments fall in January, February, April, May and September releases each
event's tickets only when that event's own tranche is settled.

## What the page needs on top of it

At the [Post UAT](../meetings/2026-09-30%20Post%20UAT.md) (`01:18:41`) Elena Spini
proposed filtering the participant page **by tranche**; Aurel Mrruku objected that
one order can carry several tranches and several events, so the page must show
**all paid tickets across all paid tranches at once**. Agreed.

🔑 **Both readings need the same missing field.** Showing every paid tranche still
requires knowing, per asset, which tranche paid for it. Aurel Mrruku took it as
his own action item: _"Aggiungere un campo sull'asset che specifichi la tranche
pagata per consentire un filtraggio corretto durante il flusso."_

## Verified against the repository

At `DevMain` `0b6b828`, `Asset` custom fields are `Anno_Competenza__c`,
`Campaign__c`, `Data_CheckIn__c`, `Fattura_Pagata__c`, `Fattura_Rif__c`,
`Fonte_Acquisto__c`, `Order_Product__c`, `QR_Id__c`.

- 🔴 **No lookup to a tranche.** Nothing references `Tranch` on the object.
- ⚠ `Fattura_Pagata__c` is a **checkbox** — _"Set when the payment/invoice
  confirmation arrives from the accounting flow"_. It records that an invoice was
  paid, not **which** tranche, and a bundle asset therefore cannot distinguish its
  own instalment from another.
- ⚠ `Fattura_Rif__c` holds an invoice reference. Whether the tranche can be
  derived from it rather than stored is **not decided and was not discussed**; the
  tranche object is [OI-50](OI-50%20Tranche%20object.md).

## Open

- **Which shape** — a lookup to the tranche record, or a derivation through
  `Fattura_Rif__c`. Nobody chose.
- **What sets it** — the order-creation path that generates the asset, or the
  payment write-back. Unstated.
- ⚠ **Who reconciles it with `Disponibile`.** The state is already annotated
  _"Fattura pagata - a livello di tranche/rate"_ in the design diagram and in
  [OI-75](OI-75%20Ticket%20availability%20rule.md), so the rule has been on the
  record since August **with no field to carry it**.
- 🔴 **Aurel Mrruku's action item has no date**, and he has committed the data
  structures to production for **Monday 05/10**.

⚠ **The gate will first be tested against forced data.** Aurel Mrruku said he will
**force invoices manually and simulate payment** to test billing (`01:22:43`), so
the first exercise of this rule will not involve Mexal.
