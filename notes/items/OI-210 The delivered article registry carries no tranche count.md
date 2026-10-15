---
id: OI-210
type: open-item
status: open
owner: Fabrizio Paganelli
with: ROMI
org: both
raised: 2026-10-05
updated: 2026-10-14
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

## 🔑 2026-10-14 — the contradiction resolved in practice: the field model won, and the count was typed in by hand

**After seven consecutive sweeps finding nothing on this row, the 14/10 e2e
settled it by doing it.**

[The e2e](../meetings/2026-10-14%20UAT%20Test%20e2e.md) (`00:24:04`–`00:40:46`):
to get past the category blocks Elisa Migliano created two new product codes on
Mexal, `plus_N05` and `plus_N06`. Then, after permission problems on the
Salesforce side,

> _"Aurel mrruku aggiorna i permessi del profilo amministrativo e **imposta
> manualmente il numero di tranche (quattro tranche) per i nuovi prodotti**"_

after which she entered the per-instalment due dates on the quote. The renewal
later in the same session used product **`N07 / plus-06`** _"suddiviso in quattro
tranche"_ (`01:34:41`).

### Which of the three statements is now operative

| Source | Model | Status after 14/10 |
| --- | --- | --- |
| 05/10 UAT `Concordato` | one article, a tranche-count **field** | 🟢 **this is what the build and the session use** |
| `Articoli Salesforce.xlsx` | one article **per tranche**, count in the description | 🔴 not used by this flow |
| `NR_Tranche` column | the field exists and is **empty** | 🔴 **still empty, and now bypassed** |

🟢 **So the agreed model is the built model**, and
[OI-167](OI-167%20Plus%20orders%20explode%20from%20a%20tranche%20count%20on%20the%20product.md)'s
input exists on the product.

🔴 **What has not changed is where the number comes from.** It was **typed in by
a developer, per product, in a client session**. The registry column that was
supposed to supply it is still blank on all 1,010 rows, and nothing in any source
says who populates it or when.

⚠ **Two consequences nobody raised:**

- **Every new Plus product needs a manual step.** Two were created and set by
  hand in this session alone. Unless the registry is populated or Mexal carries
  the count, each future Plus article arrives with a blank tranche count — and
  the nightly article sync will create it that way. It belongs in
  [the manual-steps tracker](../Manual%20Steps%20Pienissimo%20tracker.md) and is
  not in it.
- 🔑 **The article sync does not write it.** The 14/10 sync work added
  `Categoria_Articolo__c` from `sigla_cat_sta` + `nr_cat_sta`
  ([the sync note](../objects/The%20Mexal%20article%20sync%20to%20Product2.md)) and
  says nothing about a tranche field, so a Mexal-created Plus article has a
  category and no tranche count. ⚠ **Whether Mexal holds the count at all is
  still unestablished** — the original question of this row.
