---
id: OI-239
type: open-item
status: open
owner: Aurel Mrruku
with: Il gruppo
org: ROMI
raised: 2026-10-14
updated: 2026-10-14
depends_on: [OI-228]
blocks: [go-live]
severity: gating
source: notes/meetings/2026-10-14 UAT Test e2e.md
---

# OI-239 - The Mexal scadenzario sync must run every half hour and nothing schedules it

**The 14/10 e2e agreed that the Mexal-to-Salesforce sync should run every half
hour to an hour so the data is current during the working day. What exists is a
03:00 nightly job and a script Aurel Mrruku hands people to run by hand from the
developer console. Nothing schedules the agreed frequency.**

## How it was agreed

[The 14/10 e2e](../meetings/2026-10-14%20UAT%20Test%20e2e.md):

- `01:14:18` — the invoice and scadenzario did not appear until forced. Aurel
  Mrruku recalled the **03:00 job** and _"fornisce uno script eseguibile da
  Fabrizio per forzare la sincronizzazione manuale in 2-3 minuti"_.
- `01:23:29` — a **second** script, pasted in chat, run by Elisa Migliano from
  the Salesforce console to update the states.
- `01:27:42` — Aurel Mrruku and Elena Spini checked the limits **on production**:
  **3,360,000 API requests a month, 112,000 a day**.
- `01:29:36` — each sync cycle costs **two calls** (fatture and scadenzario), on
  top of account creation and Anticipay, and

  > _"viene concordato di impostare l'esecuzione periodica dello script (ogni
  > mezz'ora o un'ora) per avere i dati aggiornati senza superare i limiti"_

- `01:59:48` — Elisa Migliano asked for the alignment procedure again and noted
  down the manual instructions: developer console, Debug, wait 2 to 4 minutes.

The next-step list assigns _"Ottimizzare sincronizzazione"_ to **`[Il gruppo]`**.

## Why this is a row

- 🔴 **A group owner is not an owner**, and go-live is **21 October**. The same
  defect as [OI-233](OI-233%20Bundle%20access%20for%20tutor%20profiles%20is%20undefined.md).
- 🔴 **The operating model the client walked away with is a manual script.** Two
  people were taught to paste Apex into the developer console to make the
  financial data current. That is the procedure in force until something
  schedules it, and it is being taught to administrative users a week before
  go-live.
- 🔑 **The arithmetic was not done out loud.** At two calls per cycle, every half
  hour is ~96 calls a day against a 112,000 ceiling — the limit is not the
  constraint, which means **nothing in the session explains why the frequency
  stopped at half-hourly** rather than being driven by business need.
- ⚠ **It lands on an unresolved scheduling problem.** The four nightly jobs
  already have no agreed run-as user
  ([OI-228](OI-228%20The%20nightly%20schedulers%20have%20no%20run-as%20user%20and%20the%20first%20run%20is%20imminent.md)),
  whose tracker row is **still blank in both status columns**. Adding a
  half-hourly job inherits that problem and multiplies it: a sync running as the
  wrong user writes nothing and reports nothing, 48 times a day.
- ⚠ **The limits were read in production, where none of this is scheduled.** The
  article classes in Prod date from 04/10 and Prod has **no Mexal sync jobs at
  all** — the developer's own note in
  [the article sync record](../objects/The%20Mexal%20article%20sync%20to%20Product2.md).

## What closing it looks like

A scheduled job at the agreed frequency, in UAT and in Prod, running as a named
user, with the manual script retired as the normal procedure — and a row in
[the manual-steps tracker](../Manual%20Steps%20Pienissimo%20tracker.md) if it
stays manual in Prod.
