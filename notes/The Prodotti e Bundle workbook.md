---
id: ref-prodotti-e-bundle-workbook
type: reference
status: active
owner: Fabrizio Paganelli
org: Pienissimo
raised: 2026-08-07
updated: 2026-08-24
source: Gmail - Fwd "Lista Eventi, Codici prodotto, esempio Bundle", Elena Spini to Aurel Mrruku, 2026-08-18T07:41:32Z; workbook read 2026-08-24
---

# The Prodotti e Bundle workbook

`Prodotti e Bundle.xlsx` — Fabrizio Paganelli's attachment to the thread
**"Lista Eventi, Codici prodotto, esempio Bundle"**, sent **2026-08-07 at 12:17
CEST**, forwarded by Elena Spini on 2026-08-18, and **read on 2026-08-24**.

**A copy now lives in the repository root** as `Prodotti e Bundle.xlsx`, beside
`anar_PIE_ricla.xlsx`, so no agent has to ask a human to fetch it again.

⚠ **The workbook carries real catalogue prices.** They are in the file, which is
private. They must never be copied into `notes/`, the recaps or
[site/](../site/) — [docs/publishing.md](../docs/publishing.md). This note
records **structure only**, never a value.

## Provenance

The file's own metadata settles that it was built for this mail: author
`Pienissimo`, **created 2026-08-07 09:51 UTC, last modified 10:16 UTC** — that
is 12:16 CEST, **one minute before Fabrizio sent it**. It is not a recycled
export. Three visible sheets, no hidden rows, columns or sheets, no formulas, no
cell comments.

## What it answers

| Sheet               | Rows              | Answers                                                                                                                                                                                                     |
| ------------------- | ----------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `Lista Eventi`      | 11 events + type  | [OI-46](items/OI-46%20Bundle%20classification%20picklists.md) — the event list, **and a fifth column of meaning nobody asked for: an event _type_**                                                         |
| `Lista Prodotti`    | 29 articles       | [OI-87](items/OI-87%20Real%20catalogue%20prices%20still%20outstanding.md) — **real list prices, delivered**                                                                                                 |
| `Esempio di Bundle` | one bundle, twice | [OI-48](items/OI-48%20Bundle-only%20article%20codes.md) — the bundle-only codes, **and a change request nobody asked for**: [OI-93](items/OI-93%20Bundle%20components%20should%20be%20priced%20articles.md) |

This is the long-promised `anagrafica prodotti` from the 2026-07-22 action on
Fabrizio — the match is now confirmed by contents, not just by subject line.
**The review meeting that action paired with it is still owed.**

## `Lista Eventi` — eleven events, in four types

Columns: `NOME EVENTO`, `tipologia evento`. The events are grouped by type with
blank spacer rows, which is the client's own grouping, not an artefact:

- **Evento a pagamento (7)** — Academy, Camerieri Venditori, Food Marketing
  Festival, Happy Team, Mastery, Odb, Pienissimo Live. Food Marketing Festival
  is written **`Evento a pagamento/gratuito`** — it is attendable both ways.
- **Evento gratuito (2)** — Sold Out, Tour.
- **Evento annullato (1)** — Golden Numbers.
- **Evento in fase di ridefinizione (1)** — Pienissimo Intensive.

Two of these names — **Golden Numbers** and **Pienissimo Intensive** — appear
**nowhere else in this project's entire record**. They are new information.

⚠ **There is no year column anywhere in the workbook.** See the warning under
`Anno_Solare__c` below.

## `Lista Prodotti` — the article registry

Columns: `LIVELLO_6` (the event the article belongs to), `_ARCOD` (the Mexal
article code), `Articolo` (the name), `Prezzo Listino` (**the list price —
never reproduce**). 29 articles across 9 of the 11 events.

**Golden Numbers and Pienissimo Intensive have no articles** — consistent with
being cancelled and under redefinition.

Structure worth knowing, none of it price:

- `LIVELLO_6` is the event grouping, and it confirms L6 as the maintained level
  — the 07/23 decode said only L0 and L6 are kept.
- Each event carries up to three **variants distinguished only by a suffix in
  the article name**: the base article, `OMAGGIO` (complimentary, always zero),
  and `AGGIUNTIVO` (an additional seat).
- Tier words appear **inside the article name** for one event only: Food
  Marketing Festival has `EXECUTIVE`, `GOLD` and `DIAMOND`; Camerieri Venditori
  has `EXECUTIVE` alone. No other event carries a tier. See
  [OI-76](items/OI-76%20Ticket%20type%20picklist%20on%20the%20product.md) — this
  settles the vocabulary but **does not** deliver the field.
- **The Tour is six articles, one per city** — Padova, Brescia, Milano,
  Pescara, Roma, Catania — each named `TOUR PIENISSIMO 2026 <CITTA>`, all free.
  One event, six saleable instances, with **the year and the city readable only
  out of the name string**.
- Code shapes are inconsistent — see
  [the article code namespace](objects/The%20article%20code%20namespace.md) and
  [the normalisation risk](risks/Risk%20-%20normalising%20an%20article%20code%20merges%20two%20products.md).

## `Esempio di Bundle` — the same bundle drawn twice

One bundle, `PACK-93` — _ACADEMY 2026 - UN ANNO CON PIENISSIMO (NUOVI)_ —
presented in two versions under two headings:

1. **`BUNDLE COME SONO ADESSO`** _(i componenti delle tranche sono articoli
   omaggio)_ — how bundles are composed today.
2. **`BUNDLE COME LO VORREMMO`** _(i componenti delle tranche sono articoli non
   omaggio)_ — how Pienissimo wants them composed.

The two lists are structurally identical; only the component codes change, each
`OMAGGIO` article swapped for its priced twin. That swap is a **client change
request** and is now tracked as
[OI-93](items/OI-93%20Bundle%20components%20should%20be%20priced%20articles.md).

The structure it reveals is
[two levels deep](objects/A%20bundle%20is%20two%20levels%20deep.md), and the
client's own word for the middle level is **tranche** — which is direct client
evidence for [OI-50](items/OI-50%20Tranche%20object.md).

## What it does _not_ answer

- **No ticket-type field and no event flag.** `Lista Prodotti` has four
  columns; neither the tier nor "does this generate a ticket" is among them.
  Tier is still only readable by parsing the article name, which is the exact
  practice [OI-76](items/OI-76%20Ticket%20type%20picklist%20on%20the%20product.md)
  and [OI-47](items/OI-47%20Product%20flags%20at%20import.md) exist to end. Both
  stay open.
- **No "(B)" bundle-only codes.** OI-48 expected ~10 new codes on a `(B)`
  naming convention. The workbook shows something different — see
  [OI-48](items/OI-48%20Bundle-only%20article%20codes.md).
- **No anno solare.** Nothing in the workbook says which calendar year an event
  or article belongs to, except the literal `2026` inside the six Tour names.
