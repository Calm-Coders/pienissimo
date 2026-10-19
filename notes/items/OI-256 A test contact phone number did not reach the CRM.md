---
id: OI-256
type: open-item
status: open
owner: Fabrizio Mastracci
with: Aurel Mrruku
org: ROMI
raised: 2026-10-16
updated: 2026-10-16
depends_on: [OI-163]
source: notes/meetings/2026-10-16 UAT Flussi MKT Biglietti.md
---

# OI-256 - A test contact phone number did not reach the CRM

**During the 16 October UAT the client entered three participants and found one
contact with no phone number — the only real number of the three. The room's
explanation was that the contact already existed and was reused. Nobody verified
it, and the explanation is itself a statement about contact deduplication.**

## What happened

At [the 16/10 UAT session](../meetings/2026-10-16%20UAT%20Flussi%20MKT%20Biglietti.md)
(`00:45:39`), after nominating three participants, Sabatino Rinaldi noticed:

> _"non vedo il numero di telefono di uno dei tre contatti? Solo uno dei tre è
> saltato."_

Pressed twice on whether he had entered it, he was consistent and specific:

> _"Certo che l'ho messo." … "È l'unico numero vero dei tre che ho messo. Mi
> ricordo perché era il mio."_

Fabrizio Mastracci confirmed the absence from the CRM record on screen — _"sul
tuo contatto in CRM non vedo il numero di telefono"_.

## The explanation offered, and its status

Sabatino Rinaldi then recalled a confirmation message appearing as he typed:

> _"quando nominavo questo biglietto, mentre lo nominavo e ho messo il numero,
> quando ho finito, sotto è comparsa una frase in verde, se non sbaglio, che
> diceva numero trovato."_

Aurel Mrruku read that as a match against an existing contact — _"esiste già …
molto prob[abil]mente l'hai già associato a un contatto che hai fatto, forse hai
fatto il primo giro con lo stesso numero, con la stessa mail"_ — and Sabatino
Rinaldi agreed: _"di sicuro c'era già"_.

Aurel Mrruku also noted the environment: _"sei anche in ambiente di produzione,
può essere che c'è qualcosa di sbagliato dietro"_.

🔑 **Read carefully, the explanation is not reassuring.** If an existing contact
is matched and reused, the participant's entered phone number is **silently
discarded** rather than updated. That is plausibly correct behaviour — do not
overwrite a known contact from a form — but it was **never stated as a design
decision anywhere in the record**, and from the client's seat it looks like data
loss.

## Open

- 🔴 **Nobody verified it.** The Gemini notes assign _"Verifica contatto"_ to
  Fabrizio Mastracci — _"Verificare la causa della mancata sincronizzazione del
  numero di telefono nel CRM per il contatto segnalato"_ — and no source records
  an outcome.
- 🔴 **The intended rule is unwritten**: on matching an existing contact, does
  the nomination form update blank fields, update all fields, or update none?
  Neither the asset flow notes nor the register say.
- ⚠ **It happened in production**, during a fake-data test — so the matched
  contact is a real production record, and the test wrote against it.
- ⚠ **It touches live work.** `05cdd3b` (Rexhina Hysi, 16/10) reworks Lead and
  Contact duplicate rules and the conversion Apex the same day, and the related
  lead-conversion deduplication question is still open
  ([OI-163](OI-163%20Lead%20conversion%20has%20no%20agreed%20duplicate%20rule.md)).
  **Whether the two are connected is not established** — the nomination path is
  not the lead-conversion path — but the same question (when is a contact the
  same person) is unanswered on both.

## What closing it looks like

The specific contact is checked, the match-and-reuse behaviour is confirmed or
corrected, and the field-update rule on a matched contact is written down.
