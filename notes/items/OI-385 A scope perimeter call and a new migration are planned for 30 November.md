---
id: OI-385
type: open-item
status: open
owner: Elena Spini
with: Fabrizio Mastracci, Aurel Mrruku, Sabatino Rinaldi, Fabrizio Paganelli
org: both
raised: 2026-11-25
updated: 2026-11-25
depends_on: [OI-375, OI-376, OI-380]
blocks: [fase-1-closure]
severity: high
uncertain: which Fabrizio Elena Spini means by "il perimetro delle cose che mancano per FABRIZIO" is not stated - Fabrizio Mastracci is a participant in the group DM where she wrote it, which makes him the likelier reading, but Fabrizio Paganelli is a named recipient of the client mail on the same subject. Nothing states what the "nuova migrazione" covers, which data it moves, who asked for it, or whether it is Fase 1 or Fase 2
source: Gmail thread 1a213f12a0542f0a 2026-11-25 19:21 CET and Slack C0C38JJ9D1T 2026-11-25 19:26-19:40 CET
---

# OI-385 - A scope perimeter call and a new migration are planned for 30 November

**ROMI has put a scope-closure meeting on the client's calendar for Monday 30
November and has told the client it will plan "a new migration" in it. Internally
the purpose is stated plainly: establish the perimeter of what is missing so the
client cannot later add to it. The technical lead will not be there.**

This is the first new *work* planned since the PEC of 17 November
([OI-375](OI-375%20Pienissimo%20sent%20a%20PEC%20contesting%20the%20implementation%20and%20suspending%20the%20go-live.md))
and it is planned while Fase 2 is still formally stopped
([OI-376](OI-376%20All%20Pienissimo%20work%20is%20frozen%20except%20reports%20and%20dashboards.md)).

## What the client has been told

Elena Spini's calendar mail of **25 November 19:21 CET**, first item
([the thread](OI-378%20Marketing%20training%20is%20undelivered%20and%20the%20client%20did%20not%20attend%20the%20final%20test.md)):

> _"**Call di chiarimenti e next step** - Focus sulle attivita necessarie per
> procedere (verifica di cosa manca rispetto a quanto gia consegnato) e
> **pianificazione della nuova migrazione**. Quando: lunedi 30 novembre, dalle
> 10:00 alle 11:00"_

🔴 **"La nuova migrazione" appears with the definite article and no antecedent.**
No source this account can reach says what it covers, what data it moves, who
asked for it, what triggered it, or whether it is Fase 1 scope or Fase 2. The
only migration in the records is the original Zoho → Salesforce one, and the last
import check on record is [12 November](../meetings/2026-11-12%20Check%20Pre-Import.md).

🔑 **The calendar invitation names the real subject.** Sent by Elena Spini
**25/11 12:12 CET**, Google Meet, Monday 30 November 10:00-11:00 (GMT+1):

> **`PH: Pienissimo PERIMETRO`**

⚠ So the client has the agenda as _"chiarimenti e next step"_ and the internal
calendar calls it **perimeter**.

## What ROMI says internally

Marketing group DM (Aurel Mrruku, Elena Spini, Fabrizio Mastracci), **25
November**, minutes after the mail went out:

| Time CET | Who | Said |
| --- | --- | --- |
| 19:26:41 | Elena Spini | Reposts the four-session calendar, _"per i nostri amici di PIENISSIMO"_ |
| **19:27:13** | Elena Spini | 🔑 _"[Aurel Mrruku] **a te interessa solo la prima call** - dobbiamo capire **tutto il perimetro delle cose che mancano** per FABRIZIO"_ |
| **19:27:40** | Elena Spini | 🔑 _"**se poi si sveglia il giorno X a dire aaaa ma c'era anche questo ora e veramente NO**"_ |
| 19:40:02 | Aurel Mrruku | 🔴 _"ciao, **io non ci sono il 30 e l 1**"_ |

🔑 **The stated purpose is defensive scope closure.** 19:27:40 is the clearest
statement anywhere in the record of why the perimeter is being fixed now: to
foreclose the client adding items later. ⚠ That is a legitimate aim under a
notice to perform, but it is a **ROMI-internal** framing of a meeting the client
has been sold as _"chiarimenti e next step"_, and nothing records that the client
has been told the output is a closed list.

🔴 **The one person Elena Spini says the call concerns will not attend.** She
names the first call as the one that matters to Aurel Mrruku; thirteen minutes
later he says he is out on both 30 November and 1 December. ⚠ No substitute is
named, and the 1 December session he also misses is the **final marketing check,
run in production**.

## Why this is an item

1. 🔴 **A migration is being promised to a client with no written scope, no
   estimate and no Fase 1 / Fase 2 ruling** — exactly the pattern that produced
   the scadenziario and credit-note dispute
   ([OI-380](OI-380%20The%20client%20wants%20the%20scadenziario%20and%20the%20credit%20notes%20as%20soon%20as%20possible.md)).
2. 🔴 **It is new work during a freeze that was lifted for two things only** —
   reports/dashboards and training contact
   ([OI-376](OI-376%20All%20Pienissimo%20work%20is%20frozen%20except%20reports%20and%20dashboards.md)).
   Nothing authorises a migration.
3. ⚠ **The perimeter will be established in a one-hour call without the
   technical lead**, against a 16-item client change sheet that is still
   7 `SI` / 4 `IN LAVORAZIONE` / 2 `NON SI FA` / 6 blank
   ([OI-344](OI-344%20The%20client%20sent%20sixteen%20Sales%20flow%20changes%20and%20none%20is%20triaged.md))
   and Elena Spini's 13/11 change workbook, which has never been found.
4. ⚠ **Client contact has widened beyond the training authorisation.** Angelo
   Pastorelli's instruction of 24/11 covered _"le proposte per le call di
   formazione"_; a clarifications call, a perimeter exercise and a migration plan
   are not that
   ([OI-375](OI-375%20Pienissimo%20sent%20a%20PEC%20contesting%20the%20implementation%20and%20suspending%20the%20go-live.md)).

## What is owed

- 🔴 **A written definition of "la nuova migrazione"** — scope, data, trigger,
  owner, and whether it is Fase 1 or Fase 2 — **before 30 November 10:00**.
- 🔴 **Who represents the build on 30 November and 1 December**, given Aurel
  Mrruku's absence.
- 🔴 **Whether the perimeter list, once agreed, is put to the client in writing**
  as the closed scope — otherwise the exercise does not achieve the thing it is
  being held for.
- **Whether the scadenziario and the credit notes enter that perimeter**, which
  is the first venue where they could.
- **Confirmation that client contact on these subjects is authorised**, by name,
  by Angelo Pastorelli or Gianpaolo Motta.
- **The client-side test campaign** for 1 December, with an owner.
