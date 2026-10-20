---
id: OI-273
type: open-item
status: open
owner: Elena Spini
with: Sabatino Rinaldi
org: both
raised: 2026-10-20
updated: 2026-10-20
source: Gmail 1a158b6e3e4cee81
---

# OI-273 - How the event date fields must be filled for multi-day events is unanswered

**The client asked how `data evento`, `data inizio` and `data fine` are meant to
be filled and used, specifically for events running over several days. ROMI has
the answer internally and has not sent it. The example the client chose,
Pienissimo Live on 24–26 November, falls after the go-live date they proposed in
the same mail.**

## What was asked

[The 20/10 mail](OI-268%20The%20client%20proposed%20a%20go-live%20calendar%20of%2016%20November.md),
§4:

> _"Vi chiediamo un chiarimento su come vanno compilati e come vengono usati i
> campi "data evento", "data inizio" e "data fine", soprattutto per gli eventi di
> più giorni (es. Pienissimo Live dal 24 al 26 novembre). Per la Mastery dobbiamo
> ancora decidere tra biglietto unico con una sola scansione e controllo accessi
> giornaliero: ne riparliamo nella fase 2."_

🟢 **The Mastery half is explicitly deferred by the client to Fase 2** — single
ticket with one scan versus per-day access control. That is a client-side
deferral of a ticketing model decision, and it is the second one in this mail
(Food Marketing Festival and Tour being the first).

## 🟡 ROMI's answer exists and has not been given

At [the 17:01 internal call](../meetings/2026-10-20%20Follow-up%20Interno.md),
Aurel Mrruku answered it in one line, from history:

> _"Abbiamo detto che data evento sarebbe la data inizio evento, perché lo
> volevano loro la data evento, perché la data inizio non gli andava bene."_

So **`data evento` is the event start date**, and it exists because the client
asked for that label rather than `data inizio`. Elena Spini checked the Edizione
on screen and read back _"giorni effettivi dell'evento, data inizio evento"_,
then arrived at the practical answer herself — _"lo compili il giorno che inizia,
il giorno che finisce"_ — and added that the behaviour had been tested
(Aurel Mrruku: _"abbiamo fatto anche il test"_).

⚠ **None of this has been written to the client.** Elena Spini's reply was
deferred to the morning of 21 October.

🔑 **The durable finding is not the answer, it is that the question was asked at
all.** The field exists in the shape it does *because the client specified it*,
and the client is now asking what it means. Her reaction in the call was about
the author's attention rather than the model — _"il tasso di attenzione è -2 …
e poi chiede 'ah come compilo date d'inizio?'"_ — but the record shows the naming
decision was never documented anywhere the client could read it. ⚠ **Checking
whether a note or either prose document states the `data evento` semantics was
not done in this sweep.**

## What closing it looks like

The semantics sent to the client in writing, and the same sentence placed
wherever the Edizione's date fields are described, so the question cannot be
asked a third time.
