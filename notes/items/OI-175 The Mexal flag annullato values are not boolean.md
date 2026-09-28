---
id: OI-175
type: open-item
status: open
owner: Fabrizio Paganelli
with: Aurel Mrruku
org: both
raised: 2026-09-23
updated: 2026-09-23
depends_on: [OI-154]
source: notes/meetings/2026-09-23 Check Data Import.md
---

# OI-175 - The Mexal flag annullato values are not boolean

**[Check Data Import](../meetings/2026-09-23%20Check%20Data%20Import.md), `00:05:59` and
`00:12:26`.**

Fabrizio Paganelli questioned how the **`annullato` flag** on the Mexal product registry
behaves — specifically for reprinting old documents and for stock movements. Aurel Mrruku
set the Salesforce rule: **a disabled product stays visible on existing offers and
orders, and is blocked only on new ones.**

🔴 **The Mexal value is not a boolean.** Its actual domain was not stated in the session.
So the import needs a transformation, and the transformation needs the value list.

## Who owes what

| Owner | Owes |
| ----- | ----- |
| Fabrizio Paganelli | The **exact values** `flag annullato` takes in Mexal |
| Aurel Mrruku | The **transformation on import** into Salesforce, once the values are confirmed |

## Why it is small and still worth a row

🟢 **The article import already ran on 23/09 without it** — 1,010 articles upserted, with
cancelled rows loaded as inactive on a `S` convention supplied inside ROMI rather than by
the client. That convention is **unconfirmed by Mexal**. If the real domain has more than
two values, the active/inactive split of 197 / 813 is wrong and nobody would notice until
a tutor cannot select a product.

⚠ Recorded in the branch-side note on
[OI-154](OI-154%20The%20client%20import%20extraction%20is%20missing%20the%20article%20classification.md),
not on `DevMain` — see the trace for why that note was not edited here.
