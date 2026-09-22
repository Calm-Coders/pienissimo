---
id: OI-154
type: open-item
status: in-progress
owner: Fabrizio Paganelli
org: Pienissimo
raised: 2026-09-21
updated: 2026-09-22
depends_on: [OI-24]
blocks: [OI-121, go-live]
severity: downgraded 2026-09-22
source: notes/meetings/2026-09-21 Interna Temi Mexal.md
update_source: notes/meetings/2026-09-22 Logiche Spacchettamento Righe.md
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

## 🟢 CORRECTED 2026-09-22 — the classification is there, encoded

⚠ **The 21/09 reading above was wrong about the substance, right about the confusion.**

At [Logiche Spacchettamento Righe](../meetings/2026-09-22%20Logiche%20Spacchettamento%20Righe.md)
Elena Spini queried the Mexal technical columns and Fabrizio Paganelli answered:

> _"Natura è genera biglietto, solo bundle / non genera biglietto, solo bundle /
> genera biglietto, altri ordini / non genera biglietto, altri ordini. Era quella cosa
> che avevamo condiviso con Aurel."_

**`natura articolo` carries the whole classification as a four-way code** — the exact
pairing the 16/09 ruling needs — rather than as two separately populated flags. That is
why the added columns looked empty: the information is in the Mexal field the 21/09
review read as _"short codes"_.

Aurel Mrruku, on the same file in the same session: _"Ho visto già che ci sono i campi
per capire se devi generare un biglietto e fa parte di un bundle."_ He still wants a
joint pass over the product registry — _"è la parte che mi preoccupa di più"_ — plus a
clean-up of what is not needed.

🟢 **The transcodifica arrived the same day.** Fabrizio Paganelli's action at
[Test Mexal](../meetings/2026-09-22%20Test%20Mexal.md) was to mail the transcoding
tables for `natura articolo` and `categoria statistica`, cc Elena Spini. **Two mails
landed at 14:21:22Z and 14:23:34Z** — subjects `Natura Articoli` (from
`direzione@pienissimo.pro`) and `Categoria Statistica Articoli` (from
`fabrizio.p@pienissimo.com`).

🔴 **Both are screenshots and nothing else.** Each message body is a single embedded
`image001.png` with no text, so **the legend cannot be read by any tool available to
this job**, and it cannot be diffed against the extraction or turned into a picklist
without a person transcribing it. ⚠ `direzione@pienissimo.pro` is a **sender not
previously in this record**; whose mailbox it is was not stated and **has not been
inferred**.

🟢 **And the `ARTICOLI` extraction was updated.** `Articoli Salesforce.xlsx` in the
client's `ARTICOLI` folder has `modifiedTime` **2026-09-22T14:36:37Z**, thirteen minutes
after the second screenshot — so Fabrizio Paganelli reworked it after the session. **Not
opened; it carries real customer and catalogue data.**

## What this changes

- 🟢 **`OI-121` is no longer blocked on a missing field**, only on the mapping work
  itself: the ticket flag exists.
- 🔴 **Still owed, and now the narrow gap: the legend as data.** A screenshot is not a
  transcodifica table. Either someone types the values out, or the client re-sends them
  as text.
- ⚠ **`categoria statistica` decisions from 22/09 must land with it**: it is two Mexal
  fields, alphabetic + numeric, to be **stored and shown combined** in Salesforce
  (`C10 Performance Plus` style). `tipo articolo` is dropped as Mexal-only. Article
  `livelli` become a picklist using the exact level-zero text including the `A`/`B`/`C`/`D`
  sort prefixes.
- ⚠ **`Check Data Import` on 23/09 10:00–12:00** is where the field list gets walked.
- ⚠ The gating concern about **starting UAT on incomplete article data** stands, but it
  is now about registry clean-up and the unread legend, not a missing classification.
