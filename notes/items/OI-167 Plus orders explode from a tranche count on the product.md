---
id: OI-167
type: open-item
status: in-progress
owner: Aurel Mrruku
with: Fabrizio Paganelli
org: both
raised: 2026-09-22
updated: 2026-09-22
depends_on: [OI-50]
requirement: [ORD-02]
source: notes/meetings/2026-09-22 Logiche Spacchettamento Righe.md
---

# OI-167 - Plus orders explode from a tranche count on the product

🟢 **Agreed with the client at
[the 11:22 session](../meetings/2026-09-22%20Logiche%20Spacchettamento%20Righe.md),
confirmed with the vendor at
[Test Mexal](../meetings/2026-09-22%20Test%20Mexal.md), and demonstrated working at
[the 17:00 pre-UAT session](../meetings/2026-09-22%20Test%20Interni%20Pre-UAT%20Parte%202.md)
— all on the same day.**

## The mechanism

A **numeric field on the product** holds the number of tranches. Entering that product
once on the offer generates **n order lines**, all with the **same article code**,
quantity 1, the product's price, and a **grid of due dates** the user fills in. The
lines are named `1 di n`, `2 di n`…

This is how the client already sells Performance Plus on Mexal: one order, 12 lines,
all `PLUS…`, each with its own `data scadenza`. Aurel Mrruku:
_"quei beati ordini plus è semplicemente lo stesso prodotto n volte."_

## Why it was accepted

- Fabrizio Paganelli: it _"facilita il lavoro di inserimento degli ordini da parte dei
  tutor"_ and avoids a separate article code per cadence.
- It removes the guessing: a tutor cannot enter four lines where five are owed.
- Aurel Mrruku: _"non devo customizzare niente a livello di Salesforce"_ beyond the
  field itself.
- **Cadences in use: 5, 10 and 12** — and the mechanism is dynamic, so 8 works too.

## Consequences to carry

- ⚠ **It is a Salesforce-only field**, like the article levels — Fabrizio Paganelli:
  _"uno di quei campi derivati che dovremmo gestire solo su Sales Force."_ It is **not**
  in the Zoho extraction, so it is a mapping addition mid-import
  ([OI-165](OI-165%20Data%20migration%20was%20never%20planned%20or%20estimated.md)).
- 🟢 Fabrizio Paganelli will **set it to 5 temporarily** to test the date grid, and
  decide whether to create new article codes or update the existing ones.
- 🟢 The old `1 di 5` / `2 di 5` style codes, and the asterisk-prefixed ones, are being
  **flagged `annullato`**.
- ⚠ It supersedes the shape of
  [OI-142](OI-142%20Fractional%20product%20records%20for%20tranche%20payment.md): the
  fractional records exist, but as **one code repeated n times**, not as separate
  half/third/quarter products.

## Open

- ⚠ **The due dates are still typed by hand, per line.** No cadence rule (monthly,
  quarterly) is agreed, so nothing derives date 2 from date 1.
- ⚠ **`ORD-02` still describes the old mechanism.** Its rewording is bundled with
  [OI-143](OI-143%20The%20tranche%20invoice%20date%20must%20be%20re-keyed%20by%20hand%20into%20Mexal.md);
  the Italian is the signed text and a human owns the change.
- ⚠ **Performance Plus service dates** default to the end of next year with users
  trained to correct them — agreed at the pre-UAT session, and a data-quality risk
  nobody owns.
