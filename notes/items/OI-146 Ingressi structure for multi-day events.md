---
id: OI-146
type: open-item
status: open
owner: Aurel Mrruku
org: both
raised: 2026-09-18
updated: 2026-09-22
depends_on: [OI-24]
source: notes/meetings/2026-09-18 Data Model Parte 6.md
---

# OI-146 - Ingressi structure for multi-day events

Agreed at [Data Model Parte 6](../meetings/2026-09-18%20Data%20Model%20Parte%206.md)
(`01:42:47`, `01:48:59`, `01:50:33`, `01:59:16`) — **then suspended the same
evening.**

## The design

A new **`ingressi` entity, child of the ticket / asset**, auto-populated from the
**periods defined on the child campaign**, recording the **date and time of each
individual entry**.

It exists because multi-day events break the one-ticket-one-entry assumption.
Fabrizio Paganelli's example: the **Mastery is a single annual event of six days
spread over two months** (`01:36:07`). The same shape applies to Pienissimo Live
and the Academy.

Aurel Mrruku's summary at `01:59:16`: the campaign structure determines the periods
and therefore the entries attached to each generated ticket; verification happens
**both** at campaign level (the container and its periods) and at ticket / asset
level (the actual entry dates).

## Suspended

⚠ **Elena Spini stopped the build the same evening.** DM to Aurel Mrruku, 18/09
17:51:09 CEST:

> _"per il discorso periodo/ingressi che è uscito oggi in call non fare nulla, ok?
> poi ne riparliamo lunedì"_

She had already parked it inside the session itself (`02:02:25`), deciding to take
it away and work it through internally.

🔴 **Monday 21/09 came and went and no artifact revisits it.** Three sessions ran
that day and the `ingressi` topic appears in none of them. So the action item from
Parte 6 is **not late — it is suspended**, and the suspension has not been lifted.

## Open

- 🔴 **Lift or confirm the suspension.** The client agreed a structure in a
  client-facing session; ROMI then told its own developer to build nothing. If it
  is not built, the client has agreed to something that will not exist at UAT.
- 🔴 **Ticket UAT is 30 September** — `Biglietti (Asset), Campagne ed Eventi`.
  That is the session where its absence becomes visible.
- ⚠ **Scan data cannot reach it anyway.** There is no API flow to receive scan
  results from the external scanning app, and Elena Spini put that logic in Fase 2
  ([the session note](../meetings/2026-09-18%20Data%20Model%20Parte%206.md)). An
  entry structure with no automatic entry source records only what someone types.
- ⚠ No register row covers it.

## 🔴 2026-09-22 — still suspended, and the client asked for more of it

**Four days of silence on the suspension, and then the client extended the design.**
Fabrizio Paganelli, by mail at **22/09 15:05:00Z** (thread `Codice Cliente per test`, to
Aurel Mrruku, cc Elena Spini and Elisa Migliano):

> _"Mi è venuto in mente dopo che avevamo il tema anche di aggiungere nell'anagrafica
> prodotto un **fattore di conversione per determinare il numero di ingressi**, in base
> al ragionamento che facevamo la scorsa settimana per Evento => Edizione => Biglietti
> => Ingressi."_

So the client now wants a **conversion factor on the product** that yields the number of
entries a ticket is worth — a second field on the same `Evento → Edizione → Biglietti →
Ingressi` chain whose build ROMI has halted.

Aurel Mrruku deferred it at **15:07:37Z**: _"Facciamo domani che devo testare le API in
questo momento."_ ⚠ **No answer on the substance, and no mention of the suspension.**
The client does not know the structure he is extending is not being built.

⚠ Note the shape it takes: the conversion factor is a **product field**, arriving the
same day the product gains a **tranche-count field**
([OI-167](OI-167%20Plus%20orders%20explode%20from%20a%20tranche%20count%20on%20the%20product.md)).
The product registry is becoming the place where quantities are declared, and the article
extraction being reviewed on 23/09 does not carry either field.

## What the 22/09 sessions add

- 🟢 **The entry source now exists in principle.** The check-in app
  ([OI-161](OI-161%20The%20event%20check-in%20app%20must%20integrate%20with%20Salesforce.md))
  is the automatic scan source this note said was missing — and its agreed Fase 1 scope
  is **one check-in for the whole event**, explicitly *not* per day. So for a multi-day
  event the app will deliver **one** presence, where `ingressi` was designed to record
  each entry's date and time.
- 🔴 **That is a direct collision.** Either `ingressi` records a single entry for a
  six-day Mastery, or something other than the app populates it. Neither was discussed
  on 22/09, in either session.
- 🔴 **Ticket UAT is 30 September**, eight days out, with the structure suspended, the
  client adding to it, and its only data source scoped to one row per event.

🔴 **The armed trigger of 21/09 fires again, harder**: the suspension is now five days
old, unlifted, and the client has been allowed to build on top of it in writing.
