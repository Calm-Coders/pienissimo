---
id: OI-269
type: open-item
status: open
owner: Aurel Mrruku
with: Fabrizio Paganelli
org: both
raised: 2026-10-20
updated: 2026-10-20
depends_on: [OI-250, OI-186]
blocks: [go-live]
source: Gmail 1a158b6e3e4cee81
---

# OI-269 - Event communications must be differentiated by ticket type

**The client has declared differentiated communications per ticket type a
requirement rather than a Fase 2 wish. The Asset that represents a ticket does
not carry a ticket type, so the requirement cannot be built as asked; and
neither ROMI person could establish from the mail what "differentiated" means.**

## What was asked

In [the client's 20/10 mail](OI-268%20The%20client%20proposed%20a%20go-live%20calendar%20of%2016%20November.md),
§3, Sabatino Rinaldi:

> _"Vi ricordiamo la necessità di differenziare le comunicazioni in base al tipo
> di biglietto (es. Gold ed Executive): sappiamo che è previsto più avanti, ma
> per noi è un requisito."_

🔑 **The sentence does two things at once**: it concedes ROMI scheduled it later,
and overrides that with _"per noi è un requisito"_. Arriving the day after the
client proposed a new go-live calendar and four days after the Fase 1 scope
freeze in [OI-243](OI-243%20Go-live%20moved%20from%2021%20October%20to%202%20November.md),
it is the second piece of new build scope to land after that freeze — the first
being [OI-250](OI-250%20The%20reminder%20wait%20intervals%20must%20be%20configurable%20per%20edizione.md).

## 🔴 Why it cannot be built as asked

At [the 17:01 internal call](../meetings/2026-10-20%20Follow-up%20Interno.md),
Aurel Mrruku traced the data path and found it broken at the Asset:

> _"il template dell'email deve essere diverso in base alla tipologia del
> biglietto, ma noi non ce l'abbiamo una tipologia del biglietto, in teoria
> dipende dal prodotto … quando generiamo l'asset dobbiamo tenere sull'asset
> anche la tipologia del biglietto **che nessuno l'ha detto** e lui deve
> filtrare."_

- **The product does carry one.** He located a `tipo biglietto` field on the
  article, a restricted picklist that allows blank, **not on the layout** —
  _"c'è blank, però è restrict, vedi che è una picklist."_ He recalled it as
  having three values; the record does not confirm the count, so it is not
  asserted here.
- **The Asset does not.** Ticket generation does not copy the type onto the
  Asset, so a journey selecting a template per ticket type has nothing to read.
- **So the work is**: carry the type onto the Asset at generation, then branch
  the sends on it — which touches the same journey OI-250 would rebuild.

⚠ `Gold` and `Executive` are given by the client as examples (_"es."_). **Whether
they are values of the product's existing picklist is unverified** — the
picklist's values were not read in this sweep, and the product field is not on a
layout anyone has screenshotted.

## 🔴 Nobody at ROMI knows what the requirement contains

Elena Spini could not interpret it, repeatedly, in the call:

> _"nella sua testa quali comunicazioni diverse? … Che comunicazioni? Ma poi
> cosa? Quali comunicazioni? Cioè che che requisito è?"_

Her best guess was that it may be trivial — _"forse vuole il rifiuta uno blu e
uno rosso"_ — and she recorded being blindsided by the mail as a whole:
_"io sono proprio sconvolta del fatto che nessuno mi abbia parlato prima di sta
mail, cioè che è arrivata così senza preavviso."_

Aurel Mrruku's reading is that it implies the client building separate campaigns
per type — _"Fabrizio si dovrebbe fare delle campagne diverse"_ — which is an
operational consequence nobody has put to the client.

⚠ **So the scope is undetermined in both directions**: how many templates, which
ticket types, and whether the branching is ROMI's build or the client's campaign
configuration. **None of it can be estimated until asked.**

## What closing it looks like

The client states which ticket types need which communications; ROMI confirms
whether the product picklist already models them; the type is carried onto the
Asset at generation; and the sends branch on it — or the item is put to the
client as Fase 2 with the freeze cited, which is the one thing ROMI has not yet
done with it.
