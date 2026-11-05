---
id: OI-205
type: open-item
status: open
owner: Aurel Mrruku
with: Rexhina Hysi
org: ROMI
raised: 2026-10-02
updated: 2026-11-04
depends_on: [OI-69]
source: notes/meetings/2026-10-02 Interna Pre-UAT Plus.md
---

# OI-205 - The tranche carries no value so the client cannot see what each one is worth

**`Tranche__c` holds dates and a paid state but not an amount. The client asked
for the tranche value; Aurel Mrruku confirmed at the 02/10 Pre-UAT that it is
missing — and missing on every tranche, not only on Performance Plus.**

## What was said

At [the 02/10 Interna Pre-UAT Plus](../meetings/2026-10-02%20Interna%20Pre-UAT%20Plus.md),
after driving a five-tranche Performance Plus quote through to a signed order:

> Aurel Mrruku: _"One thing that they asked was the value … the value of the
> tranche."_
> Elena Spini: _"what is missing on the tranche level is the price basically the
> same price of the … riga ordine, riga offerta."_
> Aurel Mrruku: _"Yes. But missing on **all** the tranches, not only here,
> everywhere."_

Rexhina Hysi asked whether it should be spread; the conclusion was that the value
comes from the order/quote lines assigned to that tranche.

## 🔴 The second half, which is the harder half

Aurel Mrruku:

> _"but they want it on the tranche — update order is updated then you need to
> update the value too."_

So it is not a formula on a static set. Lines can be reassigned between tranches
and an order can be amended, and the tranche amount has to follow. A roll-up
summary is the obvious shape, but `Tranche__c` is not a master-detail parent of
`OrderItem` — the link is the `Tranche__c` lookup **on** `OrderItem`, which
`OrderItemTriggerHandler.recalculateTranches` already walks to maintain
`Completamente_Pagata__c` and `Stato__c`. The same pass could total the lines.

## Why it is wanted

- The Performance Plus contract shows `ordinato`, `fatturato` and `incassato` at
  contract level, and the tranche is the level at which the client actually
  collects. Without a tranche amount the numbers cannot be reconciled by eye.
- The Blueprint's `Insoluto` reporting
  ([OI-206](OI-206%20The%20Insoluto%20concept%20has%20no%20invoice%20due%20date%20and%20no%20invoice%20record.md))
  asks for a monthly report of **tranche falling due next month**. A due date with
  no amount is not a report anybody can act on.
- ⚠ Attributed to the client — _"they asked"_ — but this sweep found **no meeting,
  mail or minute naming who asked or when**. Treat the attribution as unconfirmed
  until someone produces it.

## 🟢🔑 2026-11-04 - the client asked for it himself, in his own words

**The unconfirmed attribution at the bottom of this note is now confirmed.** In
[the 04/11 production session](../meetings/2026-11-04%20Continuazione%20Test%20e2e%20PROD.md),
with the signed order open on screen, Fabrizio Paganelli: _"guardavo qui che non
vedo … l'importo della tranche, però forse non si può mettere, non mi ricordo."_

Aurel Mrruku confirmed the gap, the cause and the remedy — and the remedy is the
one this note already proposed:

> _"non l'abbiamo lasciato l'importo della tranche. Vabbè, si può mettere in
> teoria."_
>
> _"non gli importa perché la tranche qua è un record di Salesforce, non è
> l'insieme \[delle righe\] … **devo fare un collegamento degli item con le
> tranche, devo fare una formula.**"_

🔑 **So the shape is agreed**: total the `OrderItem` rows carrying the `Tranche__c`
lookup, exactly the pass `OrderItemTriggerHandler.recalculateTranches` already
makes.

🔴 **It was explicitly deprioritised on the call, conditional on being chased.**
Aurel Mrruku: _"si può fare, se me lo ricordi poi, ma cerchiamo di andare
avanti"_; Fabrizio Paganelli accepted: _"queste qui sono cose più di rifinitura."_
⚠ **So the item now depends on somebody reminding him, and nobody was named to do
it.**

Related: the same session produced a parallel ask for a **line-total discount in
value** on the product-entry screen —
[OI-330](OI-330%20The%20product%20selection%20screen%20is%20unusable%20for%20multiple%20products.md),
ask 4 — the same complaint about values the client can read against percentages the
system prefers.
