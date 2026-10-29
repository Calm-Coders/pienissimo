---
id: OI-292
type: open-item
status: open
owner: Aurel Mrruku
with: Elena Spini
org: ROMI
raised: 2026-10-27
updated: 2026-10-28
depends_on: []
blocks: []
source: notes/meetings/2026-10-27 Follow-up Interno.md
---

# OI-292 - The Notes related lists on Lead Account and Opportunity are not built

**The sales team asked for a note field, ROMI refused it and promised the
standard Notes related list instead. The answer has already been sent to the
client in writing. The configuration does not exist yet, it is last on the
technical lead's list, and it has no date.**

## The commitment, in writing to the client

Elena Spini to Marco Montesi, Gmail `1a17e66e3c2b5772`, **2026-10-27 17:27:02Z**,
cc Fabrizio Paganelli, `amministrazione@pienissimo.com`, Aurel Mrruku:

> _"**Gestione di appunti e note:** possiamo abilitare l'oggetto standard dedicato
> alle **Note**, che può essere associato sia a Lead e Account sia alle
> Opportunità."_
>
> _"vi suggeriamo di utilizzarlo con parsimonia e di tenere presente che si tratta
> esclusivamente di un campo memo ad uso interno: trattandosi di semplice testo
> libero, **non attiva automatismi, flussi o notifiche di sistema**, né può essere
> vincolante per bloccare o gestire processi automatici. **Serve unicamente come
> promemoria personale per i tutor.**"_

🔑 The caveat is deliberate and matches the reasoning behind
[the decision](../decisions/Notes%20live%20in%20a%20related%20list%20and%20not%20a%20field%20on%20orders.md):
the note is a memo, never an instruction the system honours.

## Why it is open

🔴 **Nothing is configured.** Slack, ROMI dev group DM
`D0B5QHS2T7H`, 2026-10-27:

> **Elena Spini, 18:05:57 CET:** _"poi mi mette le related list NOTE su
> lead/account e oprty???"_
>
> **Aurel Mrruku, 18:13:41 CET:** _"e nelle ultime cose da fare per me :)"_
>
> **Aurel Mrruku, 18:13:51 CET:** _"però Si lo farò"_

So: committed, undated, and explicitly behind the production release work.

## Scope discrepancy to resolve

⚠ **Three objects were promised to the client; two were agreed in the meeting.**

- The meeting decision was **Lead and Account**. Elena Spini on Opportunity:
  _"se dopo hanno bisogno di mettere il campo in un opportunity non me ne frega
  niente"_ — permission, not a commitment.
- The mail to Marco Montesi names **Lead, Account and Opportunità**.
- The Slack ask names **lead/account e oprty**.

**The later evidence and the client-facing text both include Opportunity**, so
Opportunity is in scope. Recorded because the meeting minute alone would read
otherwise.

## Context

Elena Spini's stated motive for answering quickly, Slack `D0B5QHS2T7H`
18:16:59 CET: _"I know but almeno sta tranquillo Marco."_ The request came out of
an **unrecorded 27/10 morning session with the whole commercial team**, whose
first question was where the note field was.

⚠ **Not in the requirement register.** No row covers note capture on any object.

## ⚠ 2026-10-28 - the client replied, and may not want it after all

Marco Montesi answered Elena Spini's 27/10 point-by-point mail inline, Gmail
`1a181f71b664c0a6`, **10:03:36Z**:

> on the Notes object — _"So che Fabrizio non è molto propenso ad abilitare questa
> funzione, in realtà spataccandoci **l'ho trovata**, poi vedremo se lasciarla o
> no. Grazie"_
>
> on the Zoho calendar — _"Ok, qui **faranno il trasferimento a mano**."_

Two things follow:

1. ⚠ **The commitment may be unwanted.** The requester says he has already found
   the Notes feature himself and that the client will decide later whether to
   keep it, while naming Fabrizio Paganelli as opposed — which matches ROMI's own
   reluctance (_"aiutatemi a fare muro"_). 🔑 **Nobody has withdrawn the written
   promise**, so the item stays open: ROMI undertook in writing on 27/10 to
   enable the related lists on Lead, Account and Opportunity, and nothing is
   configured.
2. 🟢 **The Zoho calendar decision is accepted and owned.** The client will
   re-enter the tutors' commitments by hand — see
   [the decision](../decisions/The%20Zoho%20tutor%20calendar%20is%20not%20migrated%20to%20Salesforce.md).
   ⚠ **How many commitments that is remains unknown**, and nobody has given the
   work a date or a person.
