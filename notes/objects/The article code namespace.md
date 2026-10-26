---
id: obj-article-code-namespace
type: object
status: active
owner: Fabrizio Paganelli
org: Pienissimo
raised: 2026-08-24
updated: 2026-10-12
source: Prodotti e Bundle.xlsx, sheets "Lista Prodotti" and "Esempio di Bundle"
---

# The article code namespace

Decoded from [the Prodotti e Bundle workbook](../The%20Prodotti%20e%20Bundle%20workbook.md)
on 2026-08-24. This is the first time the project has seen the client's real
`_ARCOD` values in bulk rather than as examples quoted in a meeting.

## Three prefixes, three meanings

| Prefix   | Means                                                               | Seen in                                    |
| -------- | ------------------------------------------------------------------- | ------------------------------------------ |
| `CS…`    | A saleable article — a ticket to an event                           | `Lista Prodotti`, all 29 rows              |
| `BLO-…`  | A **blocco** — the middle level of a bundle, the client's _tranche_ | `Esempio di Bundle`, `BLO-0299`…`BLO-0303` |
| `PACK-…` | The bundle header itself                                            | `Esempio di Bundle`, `PACK-93`             |

This matches the 2026-07-23 decode of `anar_PIE_ricla.xlsx` exactly — `_ARTIP`
**A** = ordinary product, **Z** = rata/block = `BLO-`, **C** = bundle = `PACK-`
— and is the independent confirmation that decode never had. See
[Fabrizio Paganelli](../people/Fabrizio%20Paganelli%20-%20Pienissimo%20product%20and%20registry.md).

⚠ **ROMI decided on 2026-07-23 not to migrate the C/Z/BLO/PACK apparatus**, on
the grounds that it existed only to build bundles-of-instalments inside Mexal.
The client's 2026-08-07 deliverable expresses its target bundle model **in that
same apparatus**. Whichever way that is resolved, note that the client is still
describing bundles in `PACK`/`BLO` terms two weeks after ROMI dropped them.

## `CS` codes have no single format

Three shapes coexist in one 29-row sheet:

| Shape                         | Example    | Count |
| ----------------------------- | ---------- | ----- |
| `CS` + 6 digits, no separator | `CS000114` | 9     |
| `CS-` + 5 digits              | `CS-00001` | 18    |
| `CS-` + 4 digits              | `CS-0118`  | 2     |

There is no rule behind which article gets which shape — the same event mixes
them, and the priced and complimentary twins of one product routinely differ in
shape. **Treat `_ARCOD` as an opaque string.** Never trim, zero-pad, strip the
separator or case-fold it, in an import, a match or a dedup:
[the normalisation risk](../risks/Risk%20-%20normalising%20an%20article%20code%20merges%20two%20products.md)
says what breaks if you do.

`Product2.Code__c` is the unique, case-insensitive external id these land in, so
a normalising import does not fail loudly — it merges two different products or
trips the unique constraint.

## Meaning lives in the name string, not in a field

The four columns are `LIVELLO_6`, `_ARCOD`, `Articolo`, `Prezzo Listino`. Every
other attribute is embedded in `Articolo`:

- **Variant** — a bare name, or the suffix `OMAGGIO` (complimentary, always
  zero-priced) or `AGGIUNTIVO` (an extra seat).
- **Tier** — `EXECUTIVE`, `GOLD`, `DIAMOND`. Food Marketing Festival carries all
  three; Camerieri Venditori carries `EXECUTIVE` only; the other seven events
  carry none. There is **no `SILVER` and no `DINAMOND` anywhere in the
  registry** — see
  [OI-76](../items/OI-76%20Ticket%20type%20picklist%20on%20the%20product.md).
- **Year and city** — only on the Tour: `TOUR PIENISSIMO 2026 PADOVA` and five
  more.

This is precisely the practice
[OI-47](../items/OI-47%20Product%20flags%20at%20import.md) and
[OI-76](../items/OI-76%20Ticket%20type%20picklist%20on%20the%20product.md) exist
to end: stop reading meaning out of a code or a name, put it in a field an admin
maintains. The workbook shows the client has **not yet added those fields** —
so the fields exist on the Salesforce side and there is nothing upstream to
populate them from.

## 🔴 2026-08-26 - this namespace is scheduled to be replaced

Everything decoded in this note is an extract of a registry Fabrizio Paganelli
intends to **close and re-create in full** —
[OI-98](../items/OI-98%20The%20Mexal%20article%20registry%20is%20being%20re-created.md),
stated at the opening of the
[26 August Mexal review](../meetings/2026-08-26%20Review%20Temi%20Integrazione%20Mexal.md)
and going to Pienissimo's direction on **31 August**.

Roughly **1000 article codes** exist, many of them residue of past practice. The
new codes will be minted against the classification rules the project has agreed,
and a **price-list revision is likely alongside**.

Two consequences for this note:

1. The prefix decoding stays true of the **current** namespace and may not survive
   the new one. Treat it as a description of what is in UAT today, not as the
   convention going forward.
2. **The twin-code rule is now part of the namespace**, not a flag on top of it: a
   ticket-generating article and its bundle-only counterpart are **two distinct
   codes** — Aurel Mrruku, _"devi per forza avere due prodotti"_, Fabrizio
   Paganelli, _"avrà il codice A… l'altro… avrà il codice B."_ See
   [OI-48](../items/OI-48%20Bundle-only%20article%20codes.md).

⚠ [Normalising an article code merges two products](../risks/Risk%20-%20normalising%20an%20article%20code%20merges%20two%20products.md)
applies with more force after a re-coding, not less.

## 🔑 2026-10-12 - the replacement namespace is written down

The namespace this note decodes is the **current** one, and §"this namespace is
scheduled to be replaced" anticipated a successor minted against agreed rules.
That successor now exists as a document:
[the Regole Codifica Codici Articolo workbook](../The%20Regole%20Codifica%20Codici%20Articolo%20workbook.md),
modified **2026-10-12 at 09:11:19Z**.

It is **single and fixed-width** — event prefix, ticket tier, bundle flag,
numeric block — which designs out the three coexisting `CS…` / `CS-…` shapes
documented above, and puts the prefix apparatus (`CS`, `BLO-`, `PACK-`) aside
entirely.

🟢 **Two of this note's open readings are confirmed by it.**

1. **The twin-code rule is part of the namespace**, exactly as §2 of the 08/26
   section says — but as a **position**, not a `"(B)"` suffix. See
   [OI-48](../items/OI-48%20Bundle-only%20article%20codes.md).
2. **The `Natura` decode is right.** The 09/10 call restated it as _first letter
   biglietto, second bundle_ and [MAP.md](../../MAP.md) flagged it for a code
   check; the client's own document puts the tier at position 3 and the bundle
   flag at position 4.

🔴 **The instruction to treat `_ARCOD` as an opaque string does not relax.** The
old codes are still in the org and in Mexal, the re-coding has not happened
([OI-98](../items/OI-98%20The%20Mexal%20article%20registry%20is%20being%20re-created.md)),
and across two coexisting namespaces
[the normalisation risk](../risks/Risk%20-%20normalising%20an%20article%20code%20merges%20two%20products.md)
is larger, not smaller. **Do not build the positional decode into code**: that is
what [OI-47](../items/OI-47%20Product%20flags%20at%20import.md) and
[OI-76](../items/OI-76%20Ticket%20type%20picklist%20on%20the%20product.md) exist to
prevent, and the field that would hold the event properly now exists — see
[the Evento field on the product](The%20Evento%20field%20on%20the%20product.md).
