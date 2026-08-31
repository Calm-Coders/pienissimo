---
id: OI-93
type: open-item
status: open
owner: Fabrizio Paganelli
with: ROMI
org: both
raised: 2026-08-07
updated: 2026-08-24
depends_on: [OI-50]
blocks: [OI-13]
source: Prodotti e Bundle.xlsx, sheet "Esempio di Bundle"
---

# OI-93 - Bundle components should be priced articles

**A client change request that nobody asked for and nobody had read.** It has
been sitting in the ROMI mailbox since **2026-08-07**, unopened until
2026-08-24, inside
[the Prodotti e Bundle workbook](../The%20Prodotti%20e%20Bundle%20workbook.md).

The `Esempio di Bundle` sheet shows one bundle — `PACK-93`, _ACADEMY 2026 - UN
ANNO CON PIENISSIMO (NUOVI)_ — drawn **twice**, under two headings that are the
whole request:

| Heading                                                                            | Meaning                                                                                         |
| ---------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------- |
| `BUNDLE COME SONO ADESSO` _(i componenti delle tranche sono articoli omaggio)_     | Today, every component of a tranche is the **`OMAGGIO`** — zero-priced — variant of the article |
| `BUNDLE COME LO VORREMMO` _(i componenti delle tranche sono articoli non omaggio)_ | Pienissimo wants each component to be the **real, priced** article instead                      |

The two lists are otherwise identical — same bundle, same five blocchi, same
quantities. Only the component codes change, each `OMAGGIO` code swapped for its
priced twin (`CS-0061` → `CS-00165`, `CS-00003` for `CS-00001`, and so on).

**One component does not swap.** `CS-00002 SOLD OUT OMAGGIO` stays complimentary
in both versions — consistent with Sold Out being an `Evento gratuito` with no
priced article in the registry at all. So the rule is not "no component is ever
free"; it is "a component that _has_ a price should carry it".

## Why the client wants it

Not stated in the file — there is **no body text in the mail and no comment in
the workbook**. The commercially obvious reason is that a bundle built out of
zero-priced components cannot attribute revenue to the events inside it: every
euro lands on the bundle header and each event looks like it earned nothing.
**This reading is inference, not client testimony — do not present it back to
Pienissimo as their stated reason.** Ask at the review meeting.

## What it costs ROMI — possibly nothing

The Salesforce build may already satisfy this. `BundleComponent__c` carries a
per-component **`Spread_Price__c`**, and `Product2` carries
`Bundle_Selling_Price__c` (what the client actually pays), `Spread_Total__c`
(the sum of the component spreads) and `Spread_Variance__c` (the difference,
which must be zero). That apparatus exists for exactly one purpose — spreading a
bundle's price across its components so per-product revenue adds up — which is
what "componenti non omaggio" asks for.

⚠ **But it is not the same mechanism.** The client is asking to change **which
article code** sits in the bundle; ROMI's design keeps the code and attaches a
**spread price** to the junction. Those produce the same revenue answer and
**different data**: under the client's version the bundle references
`CS-00165 O.D.B. LIVE`, under ROMI's it references `CS-0061 O.D.B. LIVE OMAGGIO`
with a non-zero spread. Which one Mexal receives, and which one an asset is
generated from, is not the same question.

**Do not assume this is already built.** Confirm which of the two models is
being delivered, then close or keep this open on that answer.

## Also unresolved

- If components carry list prices, the sum of the components is **not** the
  bundle price — the bundle is sold at a discount. `Spread_Variance__c` is the
  field that would catch a mismatch, and nothing currently populates the client
  side of that comparison.
- The swap uses **base** articles, never the `AGGIUNTIVO` ones, even where a
  blocco takes quantity 2. So `AGGIUNTIVO` is not "the second seat in a bundle";
  its role is still unexplained.

Raise at the **2026-08-26 Mexal review** — Fabrizio Paganelli is an invitee, it
is the first client-facing session since the workbook arrived, and this is his
document.
