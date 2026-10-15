---
id: ref-regole-codifica-workbook
type: reference
status: active
owner: Fabrizio Paganelli
org: Pienissimo
raised: 2026-10-12
updated: 2026-10-12
depends_on: [OI-48, OI-98, OI-217]
source: Google Drive 1L6RTAi-DF3plieM6oKQbj7KyktX2sAFR, modified 2026-10-12T09:11:19Z
---

# The Regole Codifica Codici Articolo workbook

**The client's written rule for how an article code is composed — the convention
[OI-98](items/OI-98%20The%20Mexal%20article%20registry%20is%20being%20re-created.md)
said was coming, found in Drive rather than announced. It moved on the morning of
12 October, the day before the production confirmation, and it is the first
fixed-format article-code scheme this project has seen.**

Drive id `1L6RTAi-DF3plieM6oKQbj7KyktX2sAFR`, `.xlsx`, one sheet `Foglio1`,
owner **`fabrizio.pienissimo@gmail.com`**. Created **2026-09-21T08:26:02Z**,
modified **2026-10-12T09:11:19Z**. It sits in the same folder as
[`Articoli Salesforce.xlsx`](The%20Articoli%20Salesforce%20article%20registry.md),
`anar_PIE.csv` and `anar_PIE_ricla.xlsx`, so it was delivered with the registry
and no sweep had opened it.

⚠ **Owned from a personal Gmail account**, like the rest of that folder. Noted
because it is the client's only delivery channel for the registry and it is not
a company surface.

## The scheme

Seven columns: `NOME EVENTO`, `EVENTO`, `BIGLIETTO`, `BUNDLE`, `NUMERO`,
`CODICE`, `DESCRIZIONE`. `CODICE` is the concatenation of the four before it, in
order, fixed width:

| Position | Column | Carries |
| -------- | ------ | ------- |
| 1–2 | `EVENTO` | the event, as a two-letter prefix |
| 3 | `BIGLIETTO` | the ticket tier, one letter |
| 4 | `BUNDLE` | a two-valued flag, `N` or `S` |
| 5–8 | `NUMERO` | a four-digit block |

**No code values are copied here**, per
[docs/publishing.md](../docs/publishing.md). The shape is the finding.

## 🔑 Three things this settles

1. **The `Natura` decode is confirmed from the client's own document.**
   The 09/10 call restated it as _first letter biglietto, second bundle_, after a
   false start, and [MAP.md](../MAP.md) flagged it as worth a code check. Here it
   is in writing: position 3 is the tier, position 4 is the bundle flag. 🟢 The
   restated reading was right.
2. **`OI-48`'s mechanism has changed shape.**
   [OI-48](items/OI-48%20Bundle-only%20article%20codes.md) records the bundle-only
   codes as a **`"(B)"` naming convention**. In this scheme there is no suffix: a
   bundle-only article is the **same code with position 4 flipped**, so the
   twin-code rule becomes positional. The sheet shows both variants present for
   the events it covers. ⚠ Nobody has said the `"(B)"` convention was dropped;
   the document simply does not use it.
3. **The format chaos the namespace note documents is designed out.**
   [The article code namespace](objects/The%20article%20code%20namespace.md)
   records three incompatible shapes coexisting in one 29-row sheet and the
   instruction to treat `_ARCOD` as an opaque string. This scheme is single and
   fixed-width. ⚠ **That instruction still stands** — the old codes are still in
   the org and in Mexal, and
   [the normalisation risk](risks/Risk%20-%20normalising%20an%20article%20code%20merges%20two%20products.md)
   applies with more force across a re-coding, not less.

## The event table, and what it is worth

A second block lists **ten events** with their two-letter prefixes: Tour, Food
Marketing Festival, Pienissimo Live, Academy, Odb Live, Sold Out, Happy Team,
Mastery, Pienissimo Intensive, Camerieri Venditori.

🔑 **This is the event list the project has been owed by mail since the first
sweeps** — the `requirements-check` skill still carries it as a promised,
unreceived artifact. It arrived as a tab in a workbook nobody announced.

🔑 **The same ten events are the picklist values of `Product2.Evento__c`**, built
today on a developer branch — see
[the Evento field on the product](objects/The%20Evento%20field%20on%20the%20product.md).
⚠ Two spellings differ: the workbook says `ODB LIVE` and `CAMERIERI VENDITORI`,
while the picklist keeps `Odb` and `Camerieri Venditori` active and has
**deactivated** `Odb Live` and `Camerieri`. Somebody reconciled the two lists;
nothing records who or against what.

## 🔴 It is a convention, not yet a registry

Codes are populated for **two of the ten events only** — Camerieri Venditori and
Food Marketing Festival, fifteen rows between them, each a tier crossed with the
bundle flag and a priced/complimentary pair. The remaining eight events have a
prefix and nothing else.

That is the measure of
[OI-217](items/OI-217%20The%20article%20code%20revision%20needs%20direction%20approval.md):
Fabrizio Paganelli put the revision at **20–30 codes** and cannot clean Mexal
until direction approves. Fifteen rows for two events is consistent with a draft
in progress, and the file moving on **12 October** — the day before the 13/10
confirmation — is consistent with him preparing it. ⚠ **Neither is established.**
No mail, message or meeting in this sweep's window mentions the workbook at all.

## What to do with it

- Do **not** treat it as the live registry. `Articoli Salesforce.xlsx` and the
  Mexal anagrafica are what the sync reads.
- Do **not** build the positional decode into code yet. The scheme is the
  client's draft, OI-217's approval has not happened, and
  [OI-47](items/OI-47%20Product%20flags%20at%20import.md) and
  [OI-76](items/OI-76%20Ticket%20type%20picklist%20on%20the%20product.md) exist
  precisely to stop meaning being read out of a code string.
- **Ask Fabrizio Paganelli whether this is the scheme going to direction**, and
  whether the eight unpopulated events are in scope for 21 October.
