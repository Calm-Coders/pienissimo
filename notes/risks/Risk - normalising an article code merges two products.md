---
id: risk-arcod-normalisation
type: risk
status: open
owner: ROMI
org: ROMI
raised: 2026-08-24
updated: 2026-08-24
depends_on: [OI-24]
blocks: [OI-13]
source: Prodotti e Bundle.xlsx, sheet "Lista Prodotti"
---

# Risk - normalising an article code merges two products

The client's article codes come in
[three incompatible shapes](../objects/The%20article%20code%20namespace.md). The
natural engineering reflex — normalise before matching — silently destroys data
here, because **distinct products differ only by a separator or a leading
zero**.

## The concrete collisions

Two pairs in a 29-row sheet, both real, both live:

- `CS-00061` and `CS-0061` differ by **one leading zero**. They are not variants
  of each other: they belong to **different events**, and one is priced while
  the other is complimentary. Strip the dash and zero-pad to a common width and
  they become the same key.
- `CS000058` and `CS-00058` differ by **the separator alone**. They are the
  priced and complimentary twins of the _same_ product — so a merge looks
  plausible and is still wrong: it destroys the distinction the whole
  `OMAGGIO` mechanism rests on, and
  [OI-93](../items/OI-93%20Bundle%20components%20should%20be%20priced%20articles.md)
  turns exactly on that distinction.

## Why it will not fail loudly

`Product2.Code__c` is `unique`, `externalId` **and `caseSensitive=false`**. A
normalising import therefore has two failure modes, neither of which is a clean
error at the right moment:

1. Upsert on the normalised key — the second row **overwrites** the first, and
   one product silently vanishes with its price.
2. Insert on the normalised key — the unique constraint fires **at load time**,
   far from the transform that caused it, as an opaque duplicate-value error.

Both surface as a data problem during the ~1 September import, not as a code
problem now.

## The rule

**`_ARCOD` is an opaque string.** Match on it byte-for-byte. No trim, no pad, no
separator strip, no case fold, in any import mapping, matching rule, dedup or
Mexal reconciliation. If a mapping needs a normalised form for humans to read,
carry it in a **separate** field and never key on it.

This binds the [Zoho import template](../items/OI-88%20Zoho%20import%20template%20owed%20to%20Pienissimo.md)
and the [data model workbook](../items/OI-24%20Data%20model%20workbook.md), both
of which are still being written and can still get this right cheaply.
