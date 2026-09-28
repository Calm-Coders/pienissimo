---
id: risk-arcod-normalisation
type: risk
status: open
owner: ROMI
org: ROMI
raised: 2026-08-24
updated: 2026-09-21
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

## 2026-09-02 - the first live instances, and there are three

This risk has been theoretical since 24 August. `Anagrafica Articoli.xlsx`, read
2026-09-02, contains **three real pairs** that collapse onto one another under
the obvious normalisation - strip non-alphanumerics, drop the leading zeros of
the numeric tail:

| Normalised | The two real codes                                                        |
| ---------- | ------------------------------------------------------------------------- |
| `CS3`      | `CS-00003` Camerieri Venditori Executive / `CS000003` Sold Out Aggiuntivo |
| `CS58`     | `CS000058` FMF Gold / `CS-00058` FMF Gold (OMAGGIO)                       |
| `CS61`     | `CS-00061` FMF Gold Aggiuntivo / `CS-0061` O.D.B. Live Omaggio            |

**Two of the three cross different events entirely.** The third is worse in kind
than it looks: it merges a **paid** ticket with its **free** twin, which is a
revenue error rather than a reporting one.

And this is from a **43-row extract of the course articles alone**. The full
registry is ~1000 codes and
[is being re-created](../items/OI-98%20The%20Mexal%20article%20registry%20is%20being%20re-created.md).

**Salesforce will not do this to us by itself.** `Product2.Code__c` is unique and
case-insensitive, but the hyphen and the leading zeros are ordinary characters to
it, so all 43 codes coexist happily. Verified against the deployed field on
2026-09-02.

**The exposure is entirely in ROMI's own mapping code, and it is sharper than
this note previously said.** `Code__c` is an **external id**. An upsert keyed on
a normalised code does not error and does not create a duplicate - it **silently
overwrites one product with the other**. The failure is invisible at the moment
it happens.

**The rule to carry into the import template and the Zoho workbook is unchanged
and now has evidence behind it:** `_ARCOD` is an opaque string. Never trim it,
never strip its punctuation, never re-pad it, and never compare two codes by
anything but exact string equality.

## 🔴 2026-09-19 / 2026-09-21 - observed in the client's own tooling, twice

**This risk stopped being hypothetical in this window.** It was demonstrated inside
the import template ROMI supplied, and then again on the live WooCommerce leg.

**1. The template converted a text code to a number.** Fabrizio Paganelli, by mail
19/09 17:02Z, explaining why he abandoned Elena Spini's shared sheet:

> _"in alcuni casi mi dava delle anomalie dovute probabilmente ad un tema di formato
> dati. Esempio il codice cliente (formato testo) mi diventa un numero quando vado ad
> incollare i dati nella tabella"_

Aurel Mrruku confirmed the mechanism independently at
[the 21/09 Mexal internal](../meetings/2026-09-21%20Interna%20Temi%20Mexal.md):
_"quando diventa numero fa un arrotondamento sull'Excel"_. **A rounding, on an
identifier.** → [OI-88](../items/OI-88%20Zoho%20import%20template%20owed%20to%20Pienissimo.md)

**2. Codes did not match across the two systems on the live test.** At
[the 21/09 client call](../meetings/2026-09-21%20Test%20WooCommerce%20e%20Temi%20Mexal.md)
the WooCommerce order would not reach Salesforce: **products with no SKU, and SKUs
that do not exist in the Salesforce instance** (`00:18:33`). It took several
attempts and an explicit hand-off of a code that exists on both sides to get one
order through. Aurel Mrruku's remark while doing it — that his copy carries a
separator the other side's does not — is this risk in miniature.

**3. And the mitigation now has a cost.** Fabrizio Paganelli wants the superfluous
codes cleaned out of the registry, **but if historical movements are imported they
would have no code to reference** (`00:20:35`, `00:22:25`). So the registry cannot
simply be tidied.

⚠ The import template was supposed to be the place this rule was carried. It was
delivered, and **the rule was not carried — it was triggered.**
