---
id: OI-142
type: open-item
status: superseded
owner: Aurel Mrruku
org: ROMI
raised: 2026-09-17
updated: 2026-09-22
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

## 🔴 2026-09-18 - the client's operational authority objected

**One day after ROMI took this position internally, Elisa Migliano argued against
it in a client-facing session.**

At [Data Model Parte 6](../meetings/2026-09-18%20Data%20Model%20Parte%206.md)
(`02:12:47`) Elena Spini, Elisa Migliano and Aurel Mrruku discussed exactly the
case this note was written for: a high-value course the customer pays in
instalments. Elisa Migliano's position:

- **Splitting the order into sub-orders or multiple products creates complex
  movement problems in both Salesforce and Mexal**, affecting invoice issuance and
  ticket availability.
- When Elena Spini and Aurel Mrruku floated child products explicitly, **she
  objected that it would alter the structure of the accounting movements.**

🔑 **Her counter-proposal** (`02:21:11`): **dedicated Salesforce fields for the
instalments and their invoice dates**, mirroring what tutors already type by hand,
so Mexal receives the payment plan. Aurel Mrruku confirmed that is feasible on the
Salesforce side. → [OI-50](OI-50%20Tranche%20object.md)

**Later evidence wins, and this is a client objection to a ROMI position.** The
"which mechanism wins" question this note already carried is now answered in one
direction on the client's side: **not fractional products**, because of the
accounting movements.

⚠ **And her alternative is defeated on the Mexal side three days later.** Mexal
exposes no field for an invoice due date, so the payment plan cannot be transmitted
at all — see
[OI-143](OI-143%20The%20tranche%20invoice%20date%20must%20be%20re-keyed%20by%20hand%20into%20Mexal.md).
**So both mechanisms on the table have now been ruled out by someone**, and the
22/09 `Logiche Spacchettamento Righe` session opens with no surviving proposal.

## ⚠ SUPERSEDED 2026-09-22 — the shape exists, but as one code repeated

The 22/09 client sessions settled the mechanism, and it is **not** separate
half/third/quarter product records. It is **one article code entered once, exploded into
n order lines** from a tranche count held on the product —
[OI-167](OI-167%20Plus%20orders%20explode%20from%20a%20tranche%20count%20on%20the%20product.md).

Aurel Mrruku, at
[the internal update](../meetings/2026-09-22%20Update%20Interno%20Aurel%20Elena.md), on
finding the client's own extraction already labelled `frazione 1`, `frazione 2`,
`frazione 3`: the fractional idea was **their historical practice**, and the current
practice replaced it with a single `PLUS…` code used n times. Fabrizio Paganelli, at
[the 11:22 session](../meetings/2026-09-22%20Logiche%20Spacchettamento%20Righe.md), on the
old `1 di 5` / `2 di 5` codes: _"sono codici articolo in qualche modo vecchi. Adesso noi
tendiamo ad utilizzare il plus."_ They are being flagged `annullato`.

🔴 **One case survives and has no mechanism at all**: a single high-value ticket such as
the Mastery (~€6,0xx) that the customer pays in instalments. It cannot be split into
several product lines — _"non posso mettere più righe per lo stesso biglietto"_ — and
per-line payment conditions are impossible on Mexal. Fabrizio Paganelli deferred it:
_"ragioniamoci."_ Carried in
[OI-160](OI-160%20Payment%20conditions%20cannot%20vary%20by%20order%20line.md).

⚠ **Elisa Migliano's 18/09 objection to fractional products is therefore moot**, and she
has not been told — the design she objected to is not the one being built.
