---
id: OI-105
type: open-item
status: open
owner: Andrea Parmeggiani
with: Aurel Mrruku
org: both
raised: 2026-09-01
updated: 2026-09-01
depends_on: [OI-94]
blocks: [OI-95]
requirement: INT-18
source: notes/The Anticipay middleware API contract.md
---

# OI-105 - The Anticipay date of birth field name is misspelled

**`data_di_dascita_legale_rappresentante`.** It should be `nascita`. The
middleware returns the legal representative's date of birth under a key with a
typo in it.

It is **not a slip in the documentation** — the string appears identically in
both places the document names it: the sample `200` response and the field
description table. That is as much evidence as a specification can give that it
is the wire format.

## Why this needs a decision and not just a note

Whoever writes the Apex has to bind to the literal string. Two outcomes, and
they are not symmetrical:

| If ROMI codes `dascita` and Pienissimo | Result                                                                                                   |
| -------------------------------------- | -------------------------------------------------------------------------------------------------------- |
| never fixes it                         | works, forever, with a typo in the integration                                                           |
| fixes it quietly                       | **the date of birth silently becomes null** — a `200 OK` with a missing field, no error, no notification |

The second is the dangerous one. Nothing in the agreed error protocol fires: the
call succeeds, the payload parses, one field is absent. Under the
[OI-94](OI-94%20Anticipay%20is%20called%20through%20the%20Pienissimo%20middleware.md)
overwrite rule a null could also **overwrite a good stored value**.

The rest of the block is inconsistent anyway — `data_di_dascita_`,
`luogo_nascita_`, `indirizzo_` — so no defensive parser can guess the name from
a pattern. See
[the contract](../The%20Anticipay%20middleware%20API%20contract.md).

## The ask

Put it to **Andrea Parmeggiani at the 1 September call**, as a straight binary:

1. **Fix it now**, before anyone codes against it — cheapest, since ROMI has
   written nothing yet and no other consumer is named.
2. **Freeze it as-is** and record in writing that `dascita` is the contract and
   will not change.

Either is workable. **What is not workable is leaving it undecided**, because
the build starts against whichever spelling is in front of the developer.

⚠ This only matters if `data_di_dascita_legale_rappresentante` is one of the
fields Fabrizio Paganelli and Elisa Migliano choose to store
([OI-95](OI-95%20Which%20Anticipay%20fields%20land%20in%20Salesforce.md)). If the
legal representative's date of birth is dropped — and
[OI-108](OI-108%20The%20Anticipay%20payload%20carries%20personal%20data%20of%20the%20legale%20rappresentante.md)
argues it probably should be — this item closes without anyone fixing anything.
**Do not spend the 1 September call on it before the field-selection question.**

## 2026-09-01 - the escape hatch closed, and nobody raised the typo

Both conditions above resolved against this item on the same day.

- 🔴 **The date of birth is being stored.** The
  [1 September call](../meetings/2026-09-01%20Follow-up%20Integrazione%20Anticipay.md)
  took **all eleven fields** onto the Account
  ([OI-95](OI-95%20Which%20Anticipay%20fields%20land%20in%20Salesforce.md)), so
  the "this may close itself" caveat no longer applies.
- 🔴 **It was never mentioned.** The field-selection question came first, exactly
  as advised — and then the call ended without anyone looking at the key names.

So the item stands, unchanged in substance and **more urgent than when it was
written**: the mapping is now committed work with nine days to 10 September, and
whoever builds it will code against `data_di_dascita_legale_rappresentante`
because that is what the wire sends.

⚠ **Practical guidance, since the decision has not been taken:** build against
the misspelled key as documented, and keep the *Salesforce* field name correctly
spelled. A rename on Pienissimo Software's side then costs one line in the
mapping rather than a field rename in the org. Do not let the typo propagate into
Salesforce metadata.

**The ask is unchanged and now belongs to the next contact with Andrea
Parmeggiani** — most naturally the same mail that chases the error response
bodies, which is the one genuinely blocking thing left
([OI-107](OI-107%20The%20Anticipay%20error%20path%20does%20not%20reach%20the%20integration%20log%20intact.md)).
Ask both in one message rather than two.
