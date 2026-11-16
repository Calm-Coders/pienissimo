---
id: OI-372
type: open-item
status: open
owner: Fabrizio Paganelli
with: Aurel Mrruku
org: both
raised: 2026-11-16
updated: 2026-11-16
depends_on: [OI-351]
blocks: []
severity: normal
source: notes/meetings/2026-11-16 Ultimi Check PROD.md
---

# OI-372 - Several principal contacts per Azienda were collapsed to the last one

**The client's referenti file flagged more than one principal contact on the same
company. Salesforce allows one. The loader kept whichever row came last and the
rest silently lost the flag. The client was told to check them as he works, which
is not a plan, and the first production quote of the morning hit the problem
immediately.**

## What happened

Aurel Mrruku, walking the migration on the 16/11 call:

> _"mentre gli stavo caricando ho notato che c'erano sul file Excel **diversi
> contatti principali sulla stessa azienda**. Col meccanismo che abbiamo noi tu puoi
> avere **solo un contatto principale**. E quello che ho fatto io: ho preso
> praticamente **l'ultimo contatto principale**."_

His own mitigation, verbatim:

> _"sui contatti e secondo me opportuno di fare un check su quelli che sono contatti
> principali, mentre fate gli ordini, per esempio. Le prime volte fate sempre un
> check: qual e il contatto principale sulle aziende?"_

The trigger that enforces the rule was already known: the 13/11 journal records
**159 rows flagged `Contatto principale = Yes` in the file that could not be
applied**, because the trigger keeps one principal per Azienda. What is new is the
resolution rule — last row wins — and that it was handed to the client as a
habit rather than a correction task.

## It bit on the first quote

Within the same call, building the test quote, Aurel Mrruku had to stop Fabrizio
Paganelli:

> _"vai un attimo sull'utente perche **Fabrizio di Pienissimo aveva cambiato il
> contatto principale** su Pienissimo … vedi che ha messo come contatto principale
> l'altro Fabrizio."_

Then: _"cambia sia la mail che mettilo come contatto principale, **perche aveva
messo la sua mail per fare dei test** per non ricevere te."_ So on the test
account the principal contact and its email had both been repointed for an earlier
test and never put back, and the quote would have gone to the wrong address.

## Why it stays open

- **Nobody knows how many are wrong.** 159 file rows could not be applied; how
  many Aziende now carry a principal contact the client would not have chosen is
  not established, and no list was produced.
- 🔴 **The quote acceptance mail goes to the principal contact.** A wrong principal
  means a client-facing quote sent to the wrong person, found only when someone
  notices.
- **"Check it while you work" has no owner and no end.** There is no report, no
  list view and no reconciliation against the file.
- ⚠ Test data left behind on live accounts is the second instance of this pattern
  in production; see
  [OI-315](OI-315%20Production%20test%20records%20cannot%20be%20deleted.md).

## Needs doing

Produce the list of Aziende where the file flagged more than one principal
contact, and give it to the client as a task with an owner — not as a habit.
