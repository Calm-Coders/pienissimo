---
id: OI-311
type: open-item
status: open
owner: Fabrizio Mastracci
with: Elena Spini
org: ROMI
raised: 2026-11-02
updated: 2026-11-04
depends_on: []
blocks: [OI-81]
uncertain: which flow
source: Slack marketing group DM C0C38JJ9D1T, 2026-11-02
---

# OI-311 - The marketing flow update needs clean test records

**The marketing-automation flow is nearly rebuilt and its author is blocked on
test data: he needs four or five clean records and has none. The answer offered
was the client's own test orders, tomorrow.**

## The exchange

Slack marketing group DM `C0C38JJ9D1T`, 2 November — the first traffic in that
conversation since it fell silent.

- 10:19:30 CET, Elena Spini: _"holaaaa 🙂 @Fabrizio Mastracci te come sei messo per
  l'aggiornamento del tuo flusso?"_
- 10:30:12, Fabrizio Mastracci: _"stanno procedendo e ho quasi terminato"_
- 10:47:38: 🟢 _"scherzi a parte ho quasi terminato, appena finito faccio un recap
  delle leogiche che gestisce cosi vediamo se torna adesso"_
- 11:23:24: _"a che punto siamo con il porting? @Elena Spini"_
- 11:42:55, Elena Spini: _"a te che serve? domani faremo degli ordini di prova con
  il cliente e nel caso potrai usare quelli"_
- 11:59:07, Fabrizio Mastracci: 🔴 _"Mi servono dei record puliti , anche 4-5 vanno
  bene"_

🟢 Elena Spini proposed an internal follow-up at 10:48:33 and it was accepted with
a ✅.

## What is open

1. 🔴 **Nobody has supplied the records.** The conversation ends on the ask. The
   offer on the table is to reuse the **client test orders of 3 November** — which
   are the `Test e2e PROD` session of
   [OI-268](OI-268%20The%20client%20proposed%20a%20go-live%20calendar%20of%2016%20November.md),
   **in production**, against a Mexal that now answers for real.
2. ⚠ **Which flow this is, is not stated.** Fabrizio Mastracci owns the event
   communication funnel
   ([OI-81](OI-81%20Event%20communication%20funnel.md)) and the ticket dispatch flow
   ([OI-225](OI-225%20The%20ticket%20dispatch%20flow%20sends%20to%20a%20null%20recipient%20and%20fails%20the%20asset%20write.md),
   [OI-289](OI-289%20The%20production%20ticket%20dispatch%20flow%20references%20a%20field%20that%20does%20not%20exist.md)).
   _"il tuo flusso"_ identifies neither. **Marked uncertain rather than guessed.**
3. 🟢 **A recap of the logic it handles is promised** when he finishes —
   the first written description of that flow anyone has offered. ⚠ Not delivered.
4. ⚠ **"a che punto siamo con il porting?"** went to Elena Spini, who answered
   about the import rather than a porting: _"alla fine verrà fatto in un volta
   pre-golive"_. **Whether "porting" means the data import or something else is
   not established.**

## 2026-11-03 - the clean records slipped a day, and the dirty ones caused an incident

**The marketing group DM moved twice.** At **12:57 CET**, after Elena Spini and Aurel
Mrruku worked through the spurious ticket mail, she wrote _"mmmmm…peggio mi sento allora
ahah lo vediamo dopo in call"_ — ⚠ **the call is not identified and no outcome is
recorded.**

🆕 At **18:14 CET** Elena Spini set the next step to Fabrizio Mastracci:

> _"quando ci vogliamo fissare un momento con Aurel per fare un giro completo? domani
> finiamo i test per creazione di ordini da usare come **"test corretti-non sporchi"**"_

🔑 **So the clean records this row waits on are tomorrow's — 4 November — not today's**,
and they come out of
[the continuation session](../meetings/2026-11-03%20Test%20e2e%20PROD.md) at
14:30-16:00. A three-way walkthrough with Aurel Mrruku is to be scheduled and has no
date.

🔴🔑 **Meanwhile the unclean production data produced a live send to the client.** A
ticket-nomination email fired at 12:33 CET for an order whose assets were still
`ordinato`, because the event link had reached `pronto` — see
[OI-313](OI-313%20The%20ticket%20nomination%20email%20fired%20for%20assets%20still%20in%20ordinato.md).
Elena Spini diagnosed it in this same DM at 12:46 CET: _"secondo me il problema qui è
che il link era in PRONTO."_

⚠ **Which flow Fabrizio Mastracci has rebuilt is still not stated**, a second day, and
it is now impossible to say from the record whether his rebuild is implicated in the
12:33 send or not.

🟢 **Aurel Mrruku brought the community into production during the day** — _"e ho portato
su la community"_, 12:48 CET — which was one of the session's own next steps. 🔴 **The
Notes object is still not released.**

## 🟢🔑 2026-11-04 - the records exist now, and they were made on purpose

**The blocker is cleared.** The orders put through production in
[the 04/11 e2e session](../meetings/2026-11-04%20Continuazione%20Test%20e2e%20PROD.md)
were created explicitly for this, and Aurel Mrruku said so twice on the call:

> _"così prepariamo anche dei biglietti per Fabrizio di Romi, così lui può già
> mettere in piedi \[le logiche\] … non ha mai testato coi dati reali in produzione
> l'invio delle mail con i biglietti."_
>
> _"mi servono questi biglietti perché quando faremo i test con marketing domani
> siano dei dati reali."_

The brief he gave the client was specific: _"una decina di biglietti con tre ordini
diversi"_, then _"quattro cinque prodotti in due tre tranche"_ with _"quantità tipo
quattro a ciascuno"_. Two orders were completed and fully settled, with assets
reaching `Disponibile` in production.

🆕 **A marketing test is scheduled for 5 November** — Aurel Mrruku: _"quando faremo
i test con marketing domani"_, with himself, Fabrizio Mastracci and Elena Spini,
_"che non abbiamo mai fatto un test in produzione reale"_. ⚠ **No time is recorded
and no invitation was found in this sweep.**

🔴 **And the fault this item was waiting to exclude reproduced during the very
session that made the records.** The ticket email fired again for `ordinato`
assets, and Aurel Mrruku's diagnosis this time names **the marketing flow's own
filter**, on a version _"fatto un mese e mezzo fa"_ that was never updated — see
[OI-313](OI-313%20The%20ticket%20nomination%20email%20fired%20for%20assets%20still%20in%20ordinato.md).
🔑 **So the clean records arrive at the same moment the flow is implicated**, and
the question point 2 above kept open — which flow Fabrizio Mastracci rebuilt — is
still unanswered in writing.
