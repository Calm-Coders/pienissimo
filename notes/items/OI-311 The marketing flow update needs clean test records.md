---
id: OI-311
type: open-item
status: open
owner: Fabrizio Mastracci
with: Elena Spini
org: ROMI
raised: 2026-11-02
updated: 2026-11-02
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
