---
id: obj-bundle-two-levels
type: object
status: active
owner: ROMI
org: both
raised: 2026-08-24
updated: 2026-08-24
depends_on: [OI-50]
source: Prodotti e Bundle.xlsx, sheet "Esempio di Bundle"
---

# A bundle is two levels deep

The `Esempio di Bundle` sheet in
[the workbook](../The%20Prodotti%20e%20Bundle%20workbook.md) is the first time
the client has shown a whole bundle rather than described one. It is **not a
flat list of articles**. It has a middle level.

```
PACK-93   ACADEMY 2026 - UN ANNO CON PIENISSIMO (NUOVI)   <- the bundle
  BLO-0299  BLOCCO I   - ACADEMY 2026 - ANNO C            <- a tranche
     CS-…     two articles, qty 1 each
  BLO-0300  BLOCCO II  - ACADEMY 2026 - ANNO              <- a tranche
     CS-…     two articles, qty 2 each
  BLO-0301  BLOCCO III …   one article,  qty 2
  BLO-0302  BLOCCO IV  …   one article,  qty 2
  BLO-0303  BLOCCO V   …   one article,  qty 2
```

The five `BLO-` rows are **filled green in the source file** — the client
formatted them as the grouping level deliberately, they are not incidental rows.

## The middle level is the tranche

The sheet's two headings both name it outright: _"i componenti **delle
tranche**…"_. So `BLOCCO` is the client's own word for what ROMI calls a
**tranche**, and this is the first client-side artefact that shows the
bundle → tranche → article hierarchy as data rather than as a diagram.

That matters for [OI-50](../items/OI-50%20Tranche%20object.md), which calls
`Tranche__c` "the most consequential unbuilt object in the project". OI-50
derives a tranche from **order-line due dates** — lines sharing a due date form
one tranche. This workbook shows the grouping also exists **on the product side,
before an order is ever placed**, as a named, coded entity with its own article
code. Those are two different things wearing the same name, and the register
does not currently distinguish them:

- **`BLO-0299`** — a _product-side_ block, part of the bundle's definition. It
  exists in the catalogue whether or not anyone buys it.
- **The tranche of OI-50** — an _order-side_ grouping, created from due dates
  after the sale, carrying payment state up from Mexal.

⚠ **Unresolved: are they the same object at two life stages, or two objects?**
Nothing in the record decides this. It needs deciding before `Tranche__c` is
built, because the answer changes whether the object is created at import from
`BLO-` codes or at order time from due dates. Raise it at the
**2026-08-26 Mexal review**.

## What the current build does with it

The Salesforce side models bundle composition as `BundleComponent__c`, a
junction between two `Product2` records carrying a per-bundle `Spread_Price__c`
— it replaced the old `Product2.Parent__c` lookup on 2026-07-16, precisely
because one lookup could not put a product in more than one bundle nor carry a
per-bundle price.

**That junction is flat.** It goes bundle → article directly, with no level in
between, so it cannot currently express `PACK-93 → BLO-0300 → CS-00003`. Either
the blocco level collapses into a field on the junction, or it becomes a record
in its own right. Also undecided.

## Quantity is per blocco, not per bundle

Blocco I carries quantity 1 of each of its two articles; blocchi II–V carry
quantity 2. A buyer of this bundle therefore receives **twelve tickets across
seven articles**, not one of each. Any asset-generation rule that assumes one
asset per bundle component line is wrong — see
[the asset generation rule](../items/OI-53%20Asset%20generation%20rule.md).
