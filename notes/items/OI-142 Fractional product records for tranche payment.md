---
id: OI-142
type: open-item
status: open
owner: Aurel Mrruku
org: ROMI
raised: 2026-09-17
updated: 2026-09-17
depends_on: [OI-50]
source: notes/meetings/2026-09-17 Follow-up Interno.md
---

# OI-142 - Fractional product records for tranche payment

Decided at [the 17/09 internal follow-up](../meetings/2026-09-17%20Follow-up%20Interno.md)
(`00:34:58`, approved `00:38:21`). **Nothing builds it.**

## The decision

High-value courses cannot be instalment-paid against a single product line, so
**fractional product records are created in the anagrafica** — halves, thirds,
quarters of the parent course — each one tying to its own Mexal invoice. Elena
Spini approved the approach and proposed taking it to the client immediately.

⚠ The session named two courses and their catalogue prices, and a third product
with its order value. **None of those figures is recorded here** — see
[docs/publishing.md](../../docs/publishing.md). What matters for the record is
the mechanism, not the amounts.

## Why it exists

It is the answer to the gap
[Data Model Parte 5](../meetings/2026-09-16%20Data%20Model%20Parte%205.md) opened
on 16/09: Elisa Migliano showed that tutors build multi-line quotes whose due
dates do not match Mexal's monthly invoices, and **explain the instalments by
hand in the quote PDF's notes field**. The record had been treating tranches as a
bundle property; she corrected that, and this is ROMI's first proposal since.

## How it relates to the tranche line design

The same session also settled the line-level shape (`01:15:36`): tranches are
**separate order lines carrying the same product code with the price divided**,
with **start and end dates entered by hand per tranche**, for the calculation and
for the send to Mexal. → [OI-50](OI-50%20Tranche%20object.md)

⚠ **The two mechanisms are not obviously the same.** One splits the *product
registry*; the other splits the *order lines* under one product code. The notes
carry both in the same session and reconcile neither, and the `Da approfondire`
block records that instalments-as-order-lines and their send to Mexal still need
_"una verifica congiunta con i referenti"_.

## Open

- 🔴 **Which mechanism wins** — fractional products, split order lines, or both
  in different cases. Not decided.
- 🔴 **Fractional products multiply the article registry**, and the article codes
  are owned by Mexal and still owed by the client. Who creates the fractional
  codes, and on which side, is unstated.
- 🔴 **No register row covers it.** ORD-03 / AC-06 describe the tranche payment
  roll-up, not a split product registry.
- ⚠ **Not put to the client.** Elena Spini proposed doing so; Friday's call is
  the first opportunity.
