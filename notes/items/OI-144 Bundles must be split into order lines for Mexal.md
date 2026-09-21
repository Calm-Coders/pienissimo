---
id: OI-144
type: open-item
status: open
owner: Aurel Mrruku
org: ROMI
raised: 2026-09-21
updated: 2026-09-21
depends_on: [OI-143]
blocks: [go-live]
requirement: [ORD-02]
source: notes/meetings/2026-09-21 Interna Temi Mexal.md
---

# OI-144 - Bundles must be split into order lines for Mexal

A direct consequence of
[OI-143](OI-143%20The%20tranche%20invoice%20date%20must%20be%20re-keyed%20by%20hand%20into%20Mexal.md),
established at
[the 21/09 Mexal internal](../meetings/2026-09-21%20Interna%20Temi%20Mexal.md).

## The problem

A bundle is one product that parents n products, and the standing ruling is that
it is **transmitted to Mexal as a single element — one order line**. But the
tranche due date lives **on the order line**. One line cannot carry n tranche
dates.

Aurel Mrruku: _"se mi fanno passare solo una riga, come cavolo farò io a passare
la data di scadenza a loro?"_ The same holds for Performance Plus: one product,
x instalments.

## What he decided to do

Split them. He had reached this over the weekend and opened the call with it:

> _"anche i bundle sono costretto a separarli, quindi devo cambiare un attimo il
> modo in cui si calcola la somma totale nei bundle"_

and confirmed the fallback during the call: _"se per i bundle per qualche motivo
vogliono poi mandare tutti gli item del bundle come singolo item, lo gestisco
anche in quel modo là."_

## Why it matters

- ⚠ **It contradicts the standing ruling** that a bundle reaches Mexal as one
  element. That ruling is in the record as the reason the bundle is modelled as a
  single sellable product.
- 🔴 **It changes how a bundle total is computed**, by his own statement. Nothing
  in the record describes the new calculation, and no commit yet implements it.
- ⚠ It interacts with the bundle-mix constraint built on 17/09
  ([OI-140](OI-140%20Three%20Opportunity%20record%20types.md)), which enforces
  one Bundle **or** Item products on a quote and never both — a rule about the
  quote, where this is a rule about the outbound order payload.
- 🔴 **Nobody outside ROMI has been asked.** Whether Mexal will accept n lines for
  what the catalogue calls one article, and what that does to the warehouse
  movements Fabrizio Paganelli cares about
  ([OI-155](OI-155%20San%20Marino%20revenue%20split%20and%20warehouse%20causale.md)),
  is unestablished. The 22/09 session with Mirko Merendi is where to ask.

## Open

- 🔴 Confirm with Mirko Merendi that n lines per bundle is acceptable on the Mexal
  side, and what it does to the accounting movements.
- 🔴 Record the new bundle-total calculation before it is built.
- ⚠ Reconcile with the single-element ruling, citing both dates.
