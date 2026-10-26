---
id: OI-228
type: open-item
status: open
owner: Rexhina Hysi
with: Aurel Mrruku
org: ROMI
raised: 2026-10-12
updated: 2026-10-13
depends_on: [OI-59]
blocks: [go-live]
severity: gating
source: Google Drive 1u-LgUKVlGK9ePyjMzZ_uJjXniHluo5_449siHgAIBHo, modified 2026-10-12T10:20:03Z
---

# OI-228 - The nightly schedulers have no run-as user and the first run is imminent

**A third row appeared on [the Manual Steps tracker](../Manual%20Steps%20Pienissimo%20tracker.md)
today: the four nightly jobs must be scheduled by the Pienissimo administrator,
not by whoever deploys. It is the first row blank in `Status Uat` as well as
`Status Prod` — and one of those four jobs was scheduled today by someone else,
with its first run at 03:00 CEST on 13 October.**

## The requirement, as the sheet states it

Row 3, headed _"run all scheduled jobs as amministratore pienissimo"_, carries
Apex that aborts any existing `CronTrigger` for four job names and re-creates
them:

- `MexalArticleSyncScheduler` — nightly
- `MexalCustomerSyncScheduler` — nightly
- `MexalInvoiceSyncScheduler` — nightly
- `QuoteNegotiationAgingBatch` — daily

A scheduled Apex job **runs as the user who scheduled it**. That is not metadata
and no deploy carries it, which is why the row exists at all.

## 🔴 Why it is urgent rather than housekeeping

[OI-59](OI-59%20Quote%20workflow%20configuration.md), written by the developer the
same day, records the collision in its own words:

> _"A later live check on 2026-10-12 found no schedule by that name. The user
> asked to schedule it, so `QuoteNegotiationAgingBatch.scheduleDaily()` created
> job `08eMA00000YU7OfYAL`. It is `WAITING` on cron `0 0 3 * * ?`, with its first
> run on 2026-10-13 at 03:00 CEST."_

So a job that this sheet says must run as the Pienissimo administrator was
scheduled from a working session, in UAT, hours before its first execution.
⚠ **Which user owns `08eMA00000YU7OfYAL` is not established** — this sweep does
not open the org. It is the user who ran `scheduleDaily()`, and the sheet exists
because that is usually the wrong one.

## What each job touches if it runs as the wrong user

| Job | What a visibility gap costs |
| --- | --- |
| `MexalArticleSyncScheduler` | `Product2.IsActive`, now driven by the gruppo merceologico ([OI-226](OI-226%20The%20gruppo%20merceologico%20stands%20in%20for%20the%20flag%20annullato%20only%20for%20the%20tests.md)) |
| `MexalCustomerSyncScheduler` | the customer anagrafica Mexal owns after creation |
| `MexalInvoiceSyncScheduler` | invoices and scadenzari — the records behind the payment state |
| `QuoteNegotiationAgingBatch` | quote ageing, the five-day validity and the new 48-hour reminder |

⚠ **This is the same class of failure as
[OI-223](OI-223%20The%20Mexal%20order%20send%20failed%20because%20the%20integration%20classes%20ran%20with%20sharing.md)**
— an integration that fails because the executing user cannot see what it
queries. That one cost a UAT order send and was found from an exception mail.

## What closing it looks like

The three Mexal rows and the ageing job are confirmed as scheduled **by the
Pienissimo administrator** in UAT, `Status Uat` is filled, and the same is done
and recorded for Prod. ⚠ Nothing on the sheet assigns the Prod column on any of
its three rows.

## 🔴 2026-10-13 — the first run has happened and the row is still blank

[The tracker](../Manual%20Steps%20Pienissimo%20tracker.md) was modified again
today at **09:29:13Z**. The sheet is now `A1:C5` — a **fourth** row — and the
run-as-user row is **unchanged and still the only row blank in both `Status Uat`
and `Status Prod`**.

So the sequence is on the record:

1. `QuoteNegotiationAgingBatch.scheduleDaily()` created job `08eMA00000YU7OfYAL`
   on 12/10, `WAITING`, cron `0 0 3 * * ?`.
2. Its **first run fell at 03:00 CEST on 13/10**.
3. The sheet was edited **six and a half hours later**, and the row requiring
   those jobs to run as the Pienissimo administrator **was not ticked**.

🔴 **The job therefore ran as whoever scheduled it, which is what the row exists
to prevent.** ⚠ **What it did is not established** — this sweep does not open the
org, and nothing in mail, chat or any meeting mentions the 03:00 run, its outcome,
or an error from it. **Absence of a failure report is not evidence it succeeded**;
`QuoteNegotiationAgingBatch` ageing quotes it cannot see fails silently by doing
nothing.

⚠ The three Mexal schedulers are a separate question: nothing records them as
scheduled in UAT at all, so there may be no first run to have missed.

🔑 **A named instance of the same class turned up today in a flow rather than a
job.** [OI-230](OI-230%20The%20ticket%20confirmation%20request%20flow%20queries%20a%20relationship%20name%20as%20a%20field.md)'s
production flow runs as **`Tech Romi` (`005SW00000PV5Ja`)**, a ROMI user, and
fails on its first `Get`. ⚠ That is not proof of a sharing problem — the query is
also malformed — but it is the first time this project has a **named** non-client
user executing automation in production.

## The fourth row

_"remove unecessary buttons from object list view"_ — `Done` in UAT, blank for
Prod. Built and committed the same day as `9e97f46`; the developer's `JOURNAL.md`
entry records which buttons Salesforce refuses to exclude and which objects the
repo cannot cover. 🔴 **`Status Prod` is now blank on all four rows**, eight days
from go-live.
