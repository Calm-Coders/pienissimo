---
id: OI-202
type: open-item
status: open
owner: Fabrizio Paganelli
with: Aurel Mrruku
org: both
raised: 2026-10-02
updated: 2026-10-02
blocks: [go-live]
source: notes/meetings/2026-10-02 UAT WooCommerce e Bundle.md
---

# OI-202 - Anticipay does not recognise sole traders absent from the registro imprese

**Fabrizio Paganelli raised at the 02/10 client UAT that a `ditta individuale`
can hold a perfectly valid Italian VAT number and still not appear in the
registro delle imprese, in which case Anticipay does not recognise it. The
Business Blueprint handles only "not found" as `non applicabile`, so these
customers land in the manual queue by design and nobody has said how many there
are.**

## What was said

At the 02/10 `UAT: WooCommerce + Bundle`, during Aurel Mrruku's walk-through of
the Anticipay check that precedes the Mexal customer creation
([00:58:35](https://docs.google.com/document/d/1-t2XHtTO9ePWyO4mdqpDBId1KA89u4enpF8y2EWaM00/edit#heading=h.vzfhd5tcvi77)),
Fabrizio Paganelli flagged the criticality of **valid VAT numbers of sole traders
that are not in the registro delle imprese and are therefore not recognised by
Anticipay**. No resolution was recorded in the room and no action item was
assigned.

## Why it matters now

- The 02/10 session **agreed** that on receiving a WooCommerce order the
  Anticipay call runs **before** the account and order go to Mexal. So the
  unrecognised case now sits on the inbound e-commerce path, not only on the
  tutor-entered path.
- The Business Blueprint delivered to the client the same afternoon states the
  rule as: the call is made regardless of declared nationality and a negative
  outcome (foreign subject or VAT not found) is handled as **`non applicabile`**,
  with an informative mail to Amministrazione and **without blocking the order**.
  🟢 So nothing breaks. 🔴 But a sole trader is neither foreign nor invalid —
  it is a legitimate Italian customer being routed to manual handling, and the
  blueprint does not distinguish the case.
- Pienissimo's primary target is restaurant owners, so sole traders are not a
  marginal population. ⚠ **Nobody has estimated the volume**, and this sweep
  found no figure in any source.

## What is unresolved

- Whether Anticipay offers a second lookup for subjects outside the registro
  imprese, or whether the answer is simply that the check does not apply to them.
- Whether the legal-representative fields the check exists to populate can be
  filled another way for these accounts, or stay empty.
- Who works the manual queue. This is the same unassigned operational duty that
  [OI-200](OI-200%20The%20client%20was%20asked%20to%20confirm%20logics%20whose%20open%20points%20were%20removed.md)
  records for late payments.

⚠ Raised by the client, not by ROMI, and left in the room. Recorded here because
the integration UAT on **Wednesday 07/10** has `Check Anagrafica Anticipay` as
its second agenda item.
