---
id: OI-154
type: open-item
status: open
owner: Fabrizio Paganelli
org: Pienissimo
raised: 2026-09-21
updated: 2026-09-21
depends_on: [OI-24]
blocks: [OI-121, go-live]
severity: gating
source: notes/meetings/2026-09-21 Interna Temi Mexal.md
---

# OI-154 - The client import extraction is missing the article classification

🟢 **The client delivered the Zoho migration data on 21/09** — the first time it
has arrived. 🔴 **The article classification the data model depends on is not in
it.**

## What arrived

Fabrizio Paganelli shared a Drive folder `SALESFORCE` on **2026-09-21T08:30Z**,
from a **personal Google account outside the ROMI organisation**, with one
subfolder per table:

`ACCOUNT` · `ARTICOLI` · `CAMPAGNE` · `LEAD` · `LOCALI` · `OPPORTUNITA` ·
`PREVENTIVI` · `REFERENTI`

Each holds the source extraction plus a file whose name contains `salesforce`.
This answers the four gaps
[OI-24](OI-24%20Data%20model%20workbook.md) has carried for six sessions — the
**Lead** table and the **Locale** children among them — and it supersedes the
shared-spreadsheet approach
([OI-88](OI-88%20Zoho%20import%20template%20owed%20to%20Pienissimo.md)): he did not
use Elena Spini's template.

⚠ **These files contain real customer records.** Their existence is recorded here;
**no value from them is.** The largest is an ~12 MB Zoho company export.

## Why he abandoned the template

Data-format anomalies. His own example, by mail on 19/09: the **client code, a
text field, becomes a number** when pasted into the shared sheet. He rebuilt the
extraction as one Excel per table, fed by Power Query from a Zoho CSV.

🔴 **This is the
[article-code risk](../risks/Risk%20-%20normalising%20an%20article%20code%20merges%20two%20products.md)
observed in the client's own tooling**, before any import has run. Aurel Mrruku
confirmed the mechanism independently: _"quando diventa numero fa un
arrotondamento sull'Excel"_.

## What is missing

Aurel Mrruku reviewed the `ARTICOLI` extraction live at
[the 21/09 Mexal internal](../meetings/2026-09-21%20Interna%20Temi%20Mexal.md):

> **_"Non ha fatto niente, praticamente."_**

- The fields the data model added — **whether the article generates a ticket**,
  and **whether it is included in bundles** — are **not populated**. Those are the
  fields the combination logic was to be built on.
- `natura articolo` exists and carries short codes.
- **_"Aveva detto che farebbe performance plus, performance plus rinnovo. Se vedi
  non ha fatto bundle."_** — the bundle classification is absent.
- Roughly a thousand articles.

Fabrizio Paganelli had already told Elena Spini by phone **to wait**, because
further doubts arose during the extraction.

## Why it is gating

- **[OI-121](OI-121%20The%20edition%20mapping%20table%20has%20no%20rows%20and%20no%20owner.md) cannot
  close without it** — 40 of 43 ticket-generating products are unmapped, and the
  mapping needs exactly the ticket flag this extraction omits.
- **`natura` → `genera biglietto` + `is bundle`** was the 16/09 ruling
  ([Data Model Parte 5](../meetings/2026-09-16%20Data%20Model%20Parte%205.md)),
  implemented as a custom transformation. A transformation over an unpopulated
  source produces nothing.
- The **first UAT session is 24 September**, and ticket and campaign UAT is 30
  September.

## Open

- 🔴 **Fabrizio Paganelli owes the completed classification**, and has flagged his
  own doubts rather than a date.
- 🔴 **Someone must decide whether UAT starts on incomplete article data.** Elena
  Spini's position on 21/09 was to start regardless: _"io faccio partire lo stesso
  i test… perché sennò non ci siamo più coi tempi. […] Appena riusciamo li
  importiamo."_
- ⚠ **The registry cleanup question is live too.** Fabrizio Paganelli wants the
  superfluous codes removed, but historical movements would then have no code to
  reference — raised at
  [the 21/09 client call](../meetings/2026-09-21%20Test%20WooCommerce%20e%20Temi%20Mexal.md)
  and unresolved.
