---
id: OI-96
type: open-item
status: open
owner: Aurel Mrruku
with: Fabrizio Paganelli
org: both
raised: 2026-08-26
updated: 2026-09-04
depends_on: [OI-46, OI-77]
blocks: [OI-53, OI-84]
source: notes/meetings/2026-08-26 Review Temi Integrazione Mexal.md
---

# OI-96 - Edition mapping table on Salesforce

**A new, manually maintained Salesforce table that decides which event edition
an order line belongs to.** Agreed in principle at the
[26 August Mexal review](../meetings/2026-08-26%20Review%20Temi%20Integrazione%20Mexal.md).

## The shape

One row per combination:

| Column        | Meaning                                                            |
| ------------- | ------------------------------------------------------------------ |
| article code  | the Mexal `_ARCOD`                                                 |
| data inizio   | start of an **order-date** window                                  |
| data fine     | end of that window                                                 |
| edizione      | the Campagna Figlio this window maps to                            |
| **colonna G** | the **event date**, entered by hand, unrelated to the window above |

At order time, each **order line** is matched on the **order date** against the
window for its article code, and takes the edition from the row that matches.

## Three properties that are easy to get wrong

1. **It resolves per order line, not per order.** Elena Spini asked and Fabrizio
   Paganelli confirmed: _"a livello di riga ordine."_ One order legitimately
   splits across editions when it carries articles with different windows.
2. **The windows are arbitrary.** They are **not** the calendar year of the
   edition and **not** the event's own dates — they are the period during which
   orders for that edition are taken, set by hand. Fabrizio Paganelli's worked
   example: Food Marketing Festival 2027 takes orders from 1 Oct 2025 to
   30 Sep 2026. Aurel Mrruku restated it back and got confirmation:
   _"puoi mettere data a piacere… io mi baso solo su quelle date."_
3. **The order date governs, not the tranche date.** Tranches exist only to
   define payments — see [OI-50](OI-50%20Tranche%20object.md).

## Why column G exists separately

The order-date window is deliberately unrelated to when the event happens, so it
cannot drive anything post-event. Column G carries the real event date, and it is
what the **no-show deactivation** keys on: three days after the campaign ends,
un-consumed tickets go to not-consumed. Elena Spini asked for that logic; Aurel
Mrruku asked for the extra column to support it.

## 🔴 What it replaces

**The "one active child campaign per parent" rule, which is now dead.** Elena
Spini killed it in the session — a bundle spanning two events cannot resolve to a
single active edition. See
[the campaign parent and child model](../objects/The%20campaign%20parent%20and%20child%20model.md),
where that rule was recorded as the agreed 24 August configuration.

It also supplies, at last, the concrete mechanism behind
[OI-46](OI-46%20Bundle%20classification%20picklists.md)'s ruling that the edition
comes from the order date rather than the product. `Product2.Anno_Solare__c` is
not merely unnecessary now — this table is what does its job.

## What is not settled

⚠ **The Gemini decision list files this under "Da approfondire", and it is the
only item there.** Aurel Mrruku asked for a dedicated hour with concrete worked
examples before anything is built: _"mettiamo un esempio di ordine con diversi
prodotti che cadono su campagne diverse."_ **That session is not scheduled.**

Also unstated:

- **Which object this table is.** Custom object, custom metadata type, or
  something else — nobody said. It is described only as _"una tabella aggiuntiva
  su Salesforce… gestita a mano"_.
- **Who maintains it.** Administration is implied by "we configure it by hand",
  but no owner was named.
- **What happens when an order date falls in no window, or in two.** No rule was
  discussed. Given Fabrizio Paganelli's own _"dobbiamo essere svizzeri nella
  gestione di questa tabella"_, gaps and overlaps are the obvious failure mode
  and there is no control against either.

**Entirely unbuilt.** Nothing in `force-app/` implements it.


## ✅ 2026-09-04 — built, and faithfully

**`Mappatura_Edizione__c` exists**, merged to `DevMain` in PR #34 (commit
`68c4342`, Anita Aga). The field-by-field decode, the matching logic and what was
added beyond the specification are in
[the build note](../objects/The%20Mappatura%20Edizione%20object.md).

🟢 **All three properties this note flagged as easy to get wrong are honoured** —
resolution is per order line **and per bundle component**, the windows are
order-date windows matched on `Order.EffectiveDate`, and _colonna G_ exists as
`Data_Evento__c` with its purpose written into the field description.

🟢 **Two things were built that nobody specified**: the product key is a
**lookup to `Product2`** rather than a text article code, and **overlapping
active windows are refused** by a before-save trigger. Both are improvements on
what this note described.

🔴 **The table is empty and has no maintainer** — and because the matching code
throws rather than degrading, an unmapped product now blocks an order's move to
`Incassato`. That is
[OI-121](OI-121%20The%20edition%20mapping%20table%20has%20no%20rows%20and%20no%20owner.md).

**This item stays open until the rows exist.** The mechanism is delivered; the
mapping it exists to hold is not.
