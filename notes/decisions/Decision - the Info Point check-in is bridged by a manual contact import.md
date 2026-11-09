---
id: decision-infopoint-manual-bridge
type: decision
status: active
owner: Elena Spini
with: Fabrizio Paganelli
org: both
raised: 2026-11-09
updated: 2026-11-09
depends_on: []
blocks: []
source: notes/meetings/2026-11-09 Review temi Fase 2.md
---

# Decision - the Info Point check-in is bridged by a manual contact import

**Agreed with the client on 9 November: until the Info Point integration ships,
contacts met at event check-in are collected on an Excel template supplied by ROMI
and imported in bulk against the account id. It is explicitly a stopgap, it is
inside release R2, and the integration it stands in for moves to February 2027.**

## What was agreed

[The 09/11 client review](../meetings/2026-11-09%20Review%20temi%20Fase%202.md),
transcript `00:30:41`, Elena Spini:

> _"dato che in questa fase ancora non c'è la logica di infopoint … **vi diamo noi
> una sorta di template Excel** da compilare direttamente il giorno dell'evento al
> check-in … andate su Sales\[force\], vedete che il ristorante tal dei tali
> effettivamente non ha associato quel contatto … **Andate a inserire i nuovi dati
> del contatto associato a quell'account** … per fare poi **l'import massivo**."_

Fabrizio Paganelli recognised it from an earlier conversation with Elisa Migliano:
_"Sì, sì, me la ricordo."_ The Gemini summary records it under **Concordato**.

🔑 **The join is the account id**, settled on the internal call the same morning:
_"mettermi l'ID di quell'account, il riferimento di quell'account e poi far salire
il contatto."_

## Its boundaries, as stated

- 🔑 **It is temporary and said to be so**: _"è solo una pezza per … aspettare
  l'infopoint che poi è il rilascio tre di febbraio"_.
- **It sits in R2**, go-live 14/01/2027, as _"Import contatti provvisorio"_ — see
  [the Fase 2 offer](../The%20Fase%202%20offer.md).
- **R3 replaces it**: the offer's R3 slide reads _"Sostituisce l'import massivo dei
  contatti di R2"_.
- 🔴 **What it replaces is an integration that does not exist at all.** Elena
  Spini, internal call: Info Point is _"l'integrazione che manca totale"_.

## Why the bridge was needed

The Info Point content was pulled out of the January release so the scadenziario
could go first, at the client's insistence — see
[the internal review](../meetings/2026-11-09%20INTERNA%20Review%20temi%20Fase%202.md).
**This decision is what made that reordering possible**; without it, check-in
contact capture would have had no path until February.

⚠ **Why Info Point exists, recorded here for completeness**: restaurant referents
present at an event add contacts for their own venue, today against Zoho. Elena
Spini attributes the explanation to Elisa Migliano.

## What it does not cover

- ⚠ **Orphan tickets and the post-event anomaly report** stay with the R3
  integration; the manual bridge is contacts only.
- ⚠ **Who prepares the template, and when.** No owner or date was given, and the
  first event after the decision is **Pienissimo Live, 24-26 November** — before
  R2 ships.
- 🔴 **The production Info Point connection has an unresolved timeout** against
  Andrea Parmeggiani — see
  [OI-312](../items/OI-312%20Anticipay%20times%20out%20in%20production.md), where the
  09/11 call established that the timeout Elena Spini remembered was Anticipay's.
