---
id: OI-98
type: open-item
status: open
owner: Fabrizio Paganelli
org: Pienissimo
raised: 2026-08-26
updated: 2026-08-26
blocks: [OI-46, OI-47, OI-48, OI-76, OI-93]
source: notes/meetings/2026-08-26 Review Temi Integrazione Mexal.md
---

# OI-98 - The Mexal article registry is being re-created

**Fabrizio Paganelli intends to close every current Mexal article code and mint
new ones**, against the classification rules the project has agreed, and
probably alongside a revision of the price lists.

It was the opening statement of the
[26 August Mexal review](../meetings/2026-08-26%20Review%20Temi%20Integrazione%20Mexal.md):

> _"vorrei chiudere tutti i codici prodotto che abbiamo adesso e crearne di nuovi
> in base alle regole che in qualche modo ci siamo dati fino ad oggi tra di noi…
> è probabile che ci sia l'intenzione di rivedere un attimo i listini, quindi
> cambiare i prezzi di listino."_

Context: **roughly 1000 article codes exist**, many of them the residue of past
practice.

## Status

**Not yet approved.** He takes it to Pienissimo's direction on **Monday
31 August**, having already floated it with them, and will pass ROMI the revised
registry afterwards — _"vi ripasso tutta l'anagrafica già revisionata"_. He
expects to finish the work **the following week**.

## Why it matters more than a data refresh

Every artifact in this project that names an article code is provisional until
this lands:

- [`Prodotti e Bundle.xlsx`](../The%20Prodotti%20e%20Bundle%20workbook.md), the
  client's own registry extract, read on 24 August. Its codes, its prices and its
  worked bundle `PACK-93` may all be superseded.
- [OI-46](OI-46%20Bundle%20classification%20picklists.md)'s event list and
  [OI-76](OI-76%20Ticket%20type%20picklist%20on%20the%20product.md)'s tier
  evidence, both derived by parsing article names from that workbook.
- [OI-48](OI-48%20Bundle-only%20article%20codes.md), because the new codes are
  where the bundle-only twins will be minted.
- [OI-93](OI-93%20Bundle%20components%20should%20be%20priced%20articles.md).
- The 280 `Product2` rows already in UAT.

⚠ **Price lists are in scope of the revision.** That does not change
[OI-87](OI-87%20Real%20catalogue%20prices%20still%20outstanding.md) — the prices
were delivered — but it means the delivered prices have a shelf life. As always,
**no price value goes into this repository**; record that they change, never what
they change to.

⚠ It also puts a **second re-coding** in front of the go-live: the migration
already has to carry Zoho's codes across
([OI-79](OI-79%20Migration%20volumes%20and%20mapping%20method.md)), and
[normalising an article code merges two products](../risks/Risk%20-%20normalising%20an%20article%20code%20merges%20two%20products.md)
is the standing warning about touching them at all.

**Nobody in the session connected this to the go-live date.** Fase 1 development
ends 10 September; a registry re-created "next week" arrives with days to spare
and no stated migration plan for the old codes already in UAT.

## 2026-09-01 - the first extract arrived, scoped to the courses

**Fabrizio Paganelli mailed `Anagrafica Articoli.xlsx` on 1 September 14:04Z** to
Elena Spini, Aurel Mrruku and Andrea Di Cicco, for the 2 September _Follow-up
Anagrafica Articoli_ session: _"un estratto di anagrafica articoli **con solo i
corsi**"_, plus a proposal for bundle-only codes
([OI-48](OI-48%20Bundle-only%20article%20codes.md)) and _"un paio di domande"_ for
ROMI.

Two things this tells the record, and one it does not:

- 🟢 **The re-creation is under way and producing artifacts**, eleven days after
  it was announced. This is the first tangible output of it.
- ⚠ **It is an extract, not the registry.** Scoped to the courses only, out of
  roughly 1000 codes. It does not tell anyone whether the other ~900 have been
  touched, nor whether these are the **new** codes or the **current** ones being
  reviewed. Fabrizio Paganelli's wording — _"estratto di anagrafica articoli"_ —
  is ambiguous and should not be resolved by guessing.
- 🔴 **The workbook has not been read** — this sweep cannot open a Gmail
  attachment. Everything above comes from the mail body.

**The 2 September session is the place to establish which it is**, and to ask the
question this item has carried since 26 August: what happens to the 280
`Product2` rows already in UAT, and to the codes the migration must carry across.
Nothing in the mail addresses it.
