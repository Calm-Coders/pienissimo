---
id: OI-327
type: open-item
status: open
owner: Fabrizio Paganelli
with: Aurel Mrruku
org: both
raised: 2026-11-03
updated: 2026-11-03
depends_on: [OI-309]
blocks: [OI-320]
source: notes/meetings/2026-11-03 Test e2e PROD.md
---

# OI-327 - The blow product codes carry the wrong gruppo merceologico

**The client set a whole family of product codes to the wrong flag value, which
activated them in Salesforce. He spotted it himself on the production test. Fixing it
in Mexal is not enough: Aurel Mrruku has to delete and re-insert the products,
because the nightly refresh is switched off.**

## What happened

Adding products to his test quote in
[the 3 November e2e session](../meetings/2026-11-03%20Test%20e2e%20PROD.md), Fabrizio
Paganelli saw too many:

> _"Ah, perché t'ho messo adesso tutti questi. **Ho sbagliato io.** Qui c'è una
> valanga di roba, vedi? Tutti questi prodotti qua che iniziano per `blow`. Ho
> sbagliato io. **Li ho messi a S, invece dovevo metterli a N.**"_

He asked whether correcting it would propagate overnight. It will not:

> **Aurel Mrruku:** _"**Gli devo cancellare e poi li devo rimettere.**"_

Fabrizio Paganelli noted the action for himself as _"modificare gruppo merceologico"_.

## 🔑 The numbers, from the org

- **1093 products** are loaded in production. Aurel Mrruku counted them live: _"In
  totale sono 1093."_
- About **500** carry the `gruppo merceologico` value that activates them — _"erano
  tipo 500 qualcosa"_, checked the previous evening.
- ⚠ **How many of those 500 are the wrongly-flagged `blow` codes is not known.**
  Fabrizio Paganelli's _"una valanga di roba"_ is all the record has.

## 🔑 It corroborates OI-309 from the org

Aurel Mrruku described the activation criterion unprompted and Fabrizio Paganelli
supplied the field name:

> **Aurel Mrruku:** _"Ovviamente sul campo, non su `annullato`, ma sull'altro, quello
> codice, ho dimenticato come si chiama l'altro campo"_
> **Fabrizio Paganelli:** _"gruppo merceologico"_

🔑 **So [OI-309](OI-309%20The%20product%20activation%20criterion%20must%20switch%20from%20gruppo%20merceologico%20to%20the%20Mexal%20flag.md)
is now confirmed from a live production inspection**, not only from the
2 November call. ⚠ **And this item is a direct consequence of it**: because activation
keys on `gruppo merceologico` rather than on Mexal's `annullato` flag, a registry
classification mistake silently activates a product family.

## Why it is open

1. 🔴 **Not corrected.** Fabrizio Paganelli must fix the values; Aurel Mrruku must then
   delete and re-insert the products.
2. 🔴 **It blocks the manual mapping rebuild.** Aurel Mrruku set the order explicitly:
   the mapping comes _"dopo che è messa a posto i prodotti"_. See
   [OI-320](OI-320%20Event%20and%20Edizione%20mappings%20cannot%20be%20moved%20between%20orgs.md).
3. 🔑 **The nightly refresh cannot be relied on, by decision.** Aurel Mrruku declined
   to enable the integrations mid-test: _"non voglio spaccare qualcosa adesso perché
   dobbiamo fare dei giri completi, poi alla fine devo abilitare gli API."_ Elena
   Spini pushed to enable them and was overruled.
4. ⚠ **The registry extract is still owed** — the activation criterion switch is a
   production release with no date, which Fabrizio Paganelli offered as 1 February
   2027 and disclaimed in the same breath.
5. ⚠ **No price or article-code value is recorded here**, per the publishing rules;
   `blow` is the code prefix the client named aloud.

## Related

- [The Articoli Salesforce article registry](../The%20Articoli%20Salesforce%20article%20registry.md)
- [The Regole Codifica Codici Articolo workbook](../The%20Regole%20Codifica%20Codici%20Articolo%20workbook.md)
