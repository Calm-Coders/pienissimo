---
id: OI-309
type: open-item
status: open
owner: Fabrizio Paganelli
with: Aurel Mrruku
org: both
raised: 2026-11-02
updated: 2026-11-03
depends_on: [OI-98]
blocks: []
source: notes/meetings/2026-11-02 Tema Contratti WooCommerce.md
---

# OI-309 - The product activation criterion must switch from gruppo merceologico to the Mexal flag

**Salesforce decides whether a Mexal article is active from the `gruppo
merceologico` field, not from Mexal's own `annullato` flag. That was a temporary
arrangement for the first load and production has already gone live on it. The
client owes a date on which the criterion flips to the flag, and the flip is a
production release, not a setting.**

## What is in production

Aurel Mrruku, on [2 November](../meetings/2026-11-02%20Tema%20Contratti%20WooCommerce.md):

> _"Prima era su annullato, poi mi hai detto che la prima volta lo dobbiamo fare
> almeno inattivo. Ho usato il campo gruppo merceologico, però abbiamo detto che
> questo campo poi deve essere trasformato in quell[o] attivo non annullato."_

So the sync reads **`gruppo merceologico`** today, in **both UAT and production**.
Fabrizio Paganelli's own framing of what he had asked for: all articles with Mexal
`flag annullato = no` are visible in Salesforce, which produced _"un po' di
confusione"_ in the first period.

## Why it is not a switch anyone can throw

> _"se per qualche motivo tu non usi il gruppo merceologico, ma vuoi usare
> l'annullato, non annullato, io devo cambiare la logica, quindi devo fare un
> piccolo rilascio in produzione perché in ambiente [U]AT si fa in un minuto, in
> produzione quel minuto diventa 2 ore."_

The two hours are Salesforce's required validation and test-class coverage, which
is the same ceiling described in
[the deploy risk](../risks/Risk%20-%20production%20deploy%20is%20blocked%20by%20Apex%20coverage.md).

## What is owed, and by whom

🔴 **Fabrizio Paganelli must name a date** — _"tu mi devi decidere una data in cui
mi devi dire da questa data in poi … non devi prendere più … il gruppo
merceologico, ma devi prendere il flag annullato"_. He accepted the action
(_"adesso io mi segno questa cosa"_) and floated **1 February 2027** explicitly as
a placeholder, _"per assurdo … per dire una data a caso"_, while saying he wants it
closed sooner.

🔑 **The date must fall after production entry** — Aurel Mrruku: _"deve essere per
forza successiva l'entrata in produzione, perché io sono già in produzione con il
flag … di gruppo merceologico"_.

## Why it matters

1. 🔴 **No date exists.** The only one spoken aloud was disclaimed as arbitrary in
   the same sentence, and nothing records it anywhere else.
2. ⚠ **It will land outside Fase 1 and outside the Fase 2 release plan.** Neither
   [the Fase 2 offer](../The%20Fase%202%20offer.md) nor the project plan carries it,
   and by then the only vehicle is the maintenance arrangement that
   [OI-308](OI-308%20Fase%202%20maintenance%20was%20left%20out%20of%20the%20estimate.md)
   says is unpriced.
3. 🟢 **The concern that prompted it is answered.** Fabrizio Paganelli feared that
   cancelling products in Mexal would leave the open Mexal orders uninvoiceable;
   Aurel Mrruku's answer is that he touches nothing in Mexal — _"Tu non devi fare
   niente su [Mexal]"_ — and simply re-applies Mexal's configuration to Salesforce
   after the load.
4. ⚠ **Right now the two systems disagree on purpose.** Fabrizio Paganelli:
   _"adesso io ho tanti prodotti che hanno il flag attivo, ma il gruppo
   merceologico inattivo"_, and in UAT Aurel Mrruku set everything active for the
   load. **Nothing records which products that is, in which org, as of today.**

⚠ **No register row covers the product-activation criterion.**

## 🔑 2026-11-03 - confirmed from the production org, with numbers

[The e2e production session](../meetings/2026-11-03%20Test%20e2e%20PROD.md)
corroborates this row from a live inspection rather than from a meeting. Aurel Mrruku,
describing how he had enabled the products the evening before:

> _"Ovviamente sul campo, non su `annullato`, ma sull'altro, quello codice, ho
> dimenticato come si chiama l'altro campo"_

and Fabrizio Paganelli supplied the name: **_"gruppo merceologico"_**.

🔑 **The numbers, counted live:**

- **1093 products** loaded in production — _"In totale sono 1093."_
- About **500** carry the activating value — _"erano tipo 500 qualcosa"_.

🔴🔑 **And the first consequence has already happened.** Fabrizio Paganelli had set the
whole `blow` code family to the wrong value and activated it by accident — _"Li ho
messi a S, invece dovevo metterli a N"_ — see
[OI-327](OI-327%20The%20blow%20product%20codes%20carry%20the%20wrong%20gruppo%20merceologico.md).
**That is the risk this row describes, demonstrated in production nine days before the
migration**: a registry classification mistake silently activates a product family,
where reading Mexal's `annullato` flag would not.

🔑 **Correcting it in Mexal is not enough.** Aurel Mrruku: _"Gli devo cancellare e poi
li devo rimettere"_, because **the nightly refresh and the API integrations are
deliberately switched off in production** — _"non voglio spaccare qualcosa adesso perché
dobbiamo fare dei giri completi, poi alla fine devo abilitare gli API"_. Elena Spini
pushed to enable them to test and was overruled.

⚠ **Fabrizio Paganelli still owes the switch date.** Nothing on 3 November moved it; his
**1 February 2027**, disclaimed as _"una data a caso"_ in the same breath, stands as the
only figure.
