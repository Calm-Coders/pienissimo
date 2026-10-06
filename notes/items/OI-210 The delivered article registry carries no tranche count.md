---
id: OI-210
type: open-item
status: open
owner: Fabrizio Paganelli
with: ROMI
org: both
raised: 2026-10-05
updated: 2026-10-05
depends_on: [OI-167, OI-188]
blocks: [go-live]
source: notes/The Articoli Salesforce article registry.md
---

# OI-210 - The delivered article registry carries no tranche count

**`Articoli Salesforce.xlsx` arrived on 2026-10-05 with an `NR_Tranche` column
in its header and that column empty on all 1,010 rows.** The tranche count is
the one thing
[OI-188](OI-188%20Performance%20Plus%20products%20are%20identified%20by%20the%20Mexal%20article%20category.md)
recorded Fabrizio Paganelli as owing — _"new article codes carrying a tranche
count"_, undated since 28/09 — and it is the input
[OI-167](OI-167%20Plus%20orders%20explode%20from%20a%20tranche%20count%20on%20the%20product.md)
needs to explode a Plus order.

## The contradiction, within one day

The 05/10 client UAT agreed, as a `Concordato`:

> _"**Struttura unificata dei prodotti Plus** — I prodotti Performance Plus
> vengono configurati come un unico articolo con un campo dedicato al numero di
> tranche in base ai codici concordati."_

🔴 **The registry delivered that same morning is built the other way.** Each
tranche is its own article, with the number written into the description as free
text: `PERFORMANCE PLUS TRANCHE 1/5` through `5/5`, `PERFORMANCE PLUS TRANCHE
OMAGGIO 1/5`…`4/5`, `PERFORMANCE PLUS TRANCHE MENSILE 2 (RINNOVO)`,
`CONSULENZA STRATEGICA SUL WEB TRANCHE 1`…`4`. Twenty-three active `C10`
articles and four active `C11`.

So there are three incompatible statements of the same model:

| Source | Model |
| --- | --- |
| 05/10 UAT `Concordato` | one article, a tranche-count **field** |
| `Articoli Salesforce.xlsx`, 05/10 09:24Z | one article **per tranche**, count in the description |
| `NR_Tranche` column | the field exists and is **empty** |

## What this blocks

- 🔴 Nothing can read a tranche count. A Plus quote's tranches were configured
  **by hand** in the UAT — four monthly due dates entered live — which is what
  OI-167 exists to automate.
- 🔴 Parsing `1/5` out of a description would normalise an article's meaning
  from its text, which is exactly what
  [the article-code risk](../risks/Risk%20-%20normalising%20an%20article%20code%20merges%20two%20products.md)
  forbids.
- ⚠ Fabrizio Paganelli flagged in the session that some codes are **disabled or
  cancelled**, and the registry confirms it: `PLUS-310 RINNOVO PERFORMANCE
  (EXT)` sits under `C11`. A selection rule over `C10`/`C11` will offer
  retired codes unless it also tests `Flag_Annullato`.
- ⚠ `Product_Category_Rule__mdt` keys on the category, not the tranche count,
  so this is additive work on top of a built mechanism rather than a change to
  it.

## The ask

**One of the two models has to go, and it is the client's call** because the
article codes are theirs. Either `NR_Tranche` is populated on a single article
per offer, or the agreed `Concordato` is withdrawn and the per-tranche articles
stand — in which case OI-167's explosion has nothing to explode from and the
UAT's manual tranche entry is the design.

🔴 The Performance Plus UAT was today. It passed on a hand-built quote.
