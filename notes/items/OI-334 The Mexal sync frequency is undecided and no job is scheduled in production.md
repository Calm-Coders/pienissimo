---
id: OI-334
type: open-item
status: open
owner: Aurel Mrruku
with: Fabrizio Paganelli
org: both
raised: 2026-11-04
updated: 2026-11-04
depends_on: [OI-301]
blocks: [go-live]
severity: gating
source: notes/meetings/2026-11-04 Continuazione Test e2e PROD.md
---

# OI-334 - The Mexal sync frequency is undecided and no job is scheduled in production

**Aurel Mrruku told the client the Mexal invoice and scadenzario sync runs at
03:00 and asked him how many times a day it should run. No frequency was chosen.
And a production inspection the same day found no Mexal scheduled job in Prod at
all — so the 03:00 run he described does not exist there.**

## The conversation

In [the 04/11 session](../meetings/2026-11-04%20Continuazione%20Test%20e2e%20PROD.md),
after the collection had synced back:

> **Aurel Mrruku:** _"Io per il momento li ho lasciati solo alle 3:00 di mattina.
> Se poi dobbiamo decidere quante volte al giorno fare questa cosa."_

Duration was not the constraint — _"se sono pochi stiamo parlando di un paio di
minuti"_ — so the discussion was about shape:

| Proposed by        | Shape                                                                        |
| ------------------ | ---------------------------------------------------------------------------- |
| Fabrizio Paganelli | _"lo possiamo fare anche due o tre volte al giorno, male non ci fa"_          |
| Aurel Mrruku       | _"ogni 6 ore tipo … però di notte ogni 6 ore non ti serve"_; 07:00, lunch, 17:00 |
| Fabrizio Paganelli | **20:00 to close the day** — _"la sera alle 8:00, così si prende tutta la giornata"_ — so tutors arrive to fresh data; then _"una volta ogni 2 ore"_ |
| Fabrizio Paganelli | pushing further — _"se si potesse fare anche una volta alle 9"_              |
| Aurel Mrruku       | the brake — _"Non esageriamo … si può fare, ma non vorrei andare vicino ai limiti"_ |

🟢 **Load was sized out loud and is not the risk**: four Mexal callouts per order
on send, plus the Anticipay call; ~100 WooCommerce orders a day at the top, and
_"500 ordini al giorno non succederà mai"_ — Aurel Mrruku concluded _"facciamo
1000, penso che non hai problemi"_. His safety net is the log: _"se qualcosa va
male capisco, lo posso rimettere in piedi"_ — `Integration_Log__c`.

🔴 **The outcome was deferred, not decided** — Fabrizio Paganelli: _"adesso ci
penseremo."_ The auto-notes list it under _Da approfondire_.

## 🔴🔑 The premise is false in production

A production inspection on the morning of **4 November**, run to re-sync invoices
and the scadenzario for the previous week, found:

> **No `Mexal Fatture e Scadenziario Sync - Nightly` job is scheduled in Prod — no
> `Mexal%` CronTrigger exists at all.** The sync completed only because it was
> enqueued by hand.

So:

1. 🔴 **The 03:00 run Aurel Mrruku described to the client is not running in the
   org he described it in.** Whether he meant UAT is not stated anywhere.
2. 🔴 **Nothing in production keeps invoices, due dates, asset availability or the
   order `Fatturato`/`Incassato` states current** unless somebody starts it. Every
   result demonstrated on 3 and 4 November was produced by a hand-run sync.
3. ⚠ **Scheduling them is a known outstanding manual step**
   ([OI-301](OI-301%20Three%20production%20manual%20setup%20steps%20are%20outstanding.md)) and
   the 4 November session recorded the decision as _"not recorded in a note yet"_.
4. ⚠ **A latent test failure travels with the schedule**:
   `schedulerRegistersTheNightlyJob` fails wherever a _"Mexal Sync - Nightly"_ job
   already exists — true in UAT today, and true in Prod the moment these jobs are
   scheduled.

## Why it matters

Go-live for users is **16 November**. A frequency that is never chosen defaults to
whatever is in the org, and what is in the org is nothing. Tutors arriving on the
morning of the 16th would see payment states as of whenever someone last ran a job
by hand.

**Closing it:** a chosen frequency, written down, with the corresponding
`CronTrigger` records verified present in `Pienissimo Prod` under a named owner.
