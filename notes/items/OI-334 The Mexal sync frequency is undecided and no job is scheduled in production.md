---
id: OI-334
type: open-item
status: open
owner: Aurel Mrruku
with: Fabrizio Paganelli
org: both
raised: 2026-11-04
updated: 2026-11-13
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

| Proposed by        | Shape                                                                                                                                                |
| ------------------ | ---------------------------------------------------------------------------------------------------------------------------------------------------- |
| Fabrizio Paganelli | _"lo possiamo fare anche due o tre volte al giorno, male non ci fa"_                                                                                 |
| Aurel Mrruku       | _"ogni 6 ore tipo … però di notte ogni 6 ore non ti serve"_; 07:00, lunch, 17:00                                                                     |
| Fabrizio Paganelli | **20:00 to close the day** — _"la sera alle 8:00, così si prende tutta la giornata"_ — so tutors arrive to fresh data; then _"una volta ogni 2 ore"_ |
| Fabrizio Paganelli | pushing further — _"se si potesse fare anche una volta alle 9"_                                                                                      |
| Aurel Mrruku       | the brake — _"Non esageriamo … si può fare, ma non vorrei andare vicino ai limiti"_                                                                  |

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

## 🔴 2026-11-12 - confirmed in ROMI's own tracker, and named as Aurel Mrruku's

[The Manual Steps tracker](../Manual%20Steps%20Pienissimo%20tracker.md), modified
2026-11-12 16:50:30Z, records the scheduled-jobs row as **partially done in
production**:

> _"**QuoteNegotiationAgingBatch -> only this is done the others should be done by
> Aurel**"_

So of the four jobs in the tracker's own script, three are **not scheduled in
production**: `MexalArticleSyncScheduler`, `MexalCustomerSyncScheduler` and
`MexalInvoiceSyncScheduler`. This is written confirmation of the `CronTrigger`
finding of 4 November, and it now carries a named owner.

🔴 **Four days before the client's users start**, and every Mexal result of the past
ten days has come from a hand-run sync.

⚠ **The frequency is still undecided.** Nothing in this window chooses one, and the
12/11 client call did not raise it — even while the load schedule was agreed in
detail. The one adjacent fact: a nightly Mexal update is assumed to exist. Elena
Spini, on the article-registry manoeuvre: _"non va la notte comunque l'aggiornamento
di quello che modifica Mexal?"_ → Aurel Mrruku, _"in teoria si, **ma qualcuno deve
controllare**"_, and he chose a manual run on Monday at 09:00 instead:
_"lunedi mattina entro tipo verso le 9 e faccio un aggiornamento che spero che non
duri piu di mezz'ora."_ 🔑 **That is a person, not a schedule.**

See [OI-301](OI-301%20Three%20production%20manual%20setup%20steps%20are%20outstanding.md).

## 🟢 2026-11-13 - the three nightly jobs are scheduled in Prod

Scheduled at 17:20 CET with the repository script, owner Tech Romi, Europe/Rome:
**01:00 articles, 02:00 customers, 03:30 invoices and scadenzario**, alongside the existing
03:00 quote reminders. The frequency was never discussed with the client as a number, so
this is the standard nightly pattern of the repository, not a decision; the mail to the
client states the times so they can object. The first runs catch up from the stale cursors
(articles from 02/11, invoices and rates from 04/11, customers 24 hours). Detail:
[JOURNAL.md](../../JOURNAL.md).

## 🔴 2026-11-13 - the nightly invoice sync does not cross the year end

`MexalSearchCalloutService` sends `Anno=<year the job runs>` and the nightly invoice job
never sets `accountingYear`. Mexal keeps one archive per accounting year, so from
**1 January 2027** the 03:30 job searches only the 2027 archive: invoices issued or edited
in the 2026 archive after the last good run of **31 December 2026 03:30** are never
imported, and nothing re-reads them. Invoice lines are safe (the line batch asks in the
invoice's own year) and the scadenzario is not split by year, but a rate whose invoice header
is missing stays "without invoice". Two ways to close it: a manual `importByDocumentDate`
backfill on 2 January over the last days of December followed by the line batch, or a code
change so the job also searches the previous year's archive in January. Neither is done yet.

## 🔑 2026-11-13 - the year-end behaviour was tested against Mexal (read-only)

Same searches run with the accounting year in the `Coordinate-Gestionale` header set to
2025, 2026 and 2027, no log row, no write:

| Search                               | Anno=2025          | Anno=2026          | Anno=2027 |
| ------------------------------------ | ------------------ | ------------------ | --------- |
| Invoices (movimenti, 05-12 Oct 2026) | 0 rows             | 118 rows           | HTTP 400  |
| Scadenzario (same window)            | 118                | 118                | HTTP 400  |
| Articles (modified since 12/11)      | identical response | identical response | HTTP 400  |
| Customers (modified since 12/11)     | 200, same data     | 200                | HTTP 400  |

- **Invoices are split by year** (the 2025 archive holds none of the October 2026 invoices).
- **The scadenzario, the articles and the customers are not**: the response is the same
  whichever valid year is sent.
- 🔴 **2027 returns HTTP 400 on every search**: _"6001 - errore gestionale [Non e' possibile
  aprire l'azienda 'PIE'|Data 01/01/2027 non gestita]"_. The accounting year 2027 is not
  open in Mexal yet. From 1 January 2027 all four nightly jobs would fail until the client
  opens it (their cursors are kept, so articles, customers and rates would catch up, but the
  invoices of the last day of 2026 would still be missed, see above).
- Fix options: the client opens 2027 before 31/12; and in code, send the latest year Mexal
  manages (fall back to the previous year on error 6001) and search the invoices in both the
  current and the previous year's archive each night. Neither is done.

## 🟢 2026-11-13 - the year-end fix is written and live in UAT, not yet in Prod

`MexalSearchCalloutService` now repeats a read-only search once with the previous year when
Mexal answers 6001 ("year not open") and the year was automatic, and
`MexalInvoiceImportService.importInvoicesModifiedSince` reads the previous year's archive
(at least 31 days back) as well as the current one and merges the rows. Deployed to UAT
(`0AfMA00000DBGGT0A5`) and exercised against Mexal with a simulated 1 January: 3 callouts,
244 unique invoices, no error. 🔴 **Prod is waiting for a short window**: Salesforce refuses
to validate or deploy a class that scheduled jobs use, so the three Mexal jobs have to be
aborted, the classes deployed, and the jobs scheduled again. The client still has to open 2027
in Mexal; until then the fallback keeps every job working on 2026.

## 🟢 2026-11-13 - the year-end fix is in Prod

Deployed to **Pienissimo Prod** after aborting and re-creating the three Mexal jobs: quick
deploy `0AfSW000001M4nZ0AS`, validated with 59 tests and 87.7% / 88.5% coverage on the two
classes. From now the invoice job reads the current and the previous year's archive (at least
31 days back) and every read-only search falls back to the previous year when Mexal has not
opened the new one. The client does **not** have to open 2027 for this to work. The jobs are
scheduled again at 01:00, 02:00 and 03:30; the change is uncommitted in the repository. The
earlier red section on this item (the nightly sync does not cross the year end) is resolved
by it.

## 2026-11-13 - the scadenzario needs no two-year read (tested in Prod, read-only)

Asked to do for the scadenzario what was done for the invoices, the search `Mexal_Scadenzario_Ricerca`
was run in Prod with the header year set to 2024, 2025 and 2026 on three requests: documents dated
Oct 2025 (82,907 bytes in each year), modified since 01/11/2026 (222,664 bytes in each) and
documents dated Dec 2024 (90,827 bytes for 2024 and 2025, the 2026 call timed out at 120 s).
The response is the same whichever year is sent, so the scadenzario is one archive for all
years and a single call already carries rates of 2025 and 2026 invoices. A second call would
return the same rows and double a 30-60 s request. Nothing was changed. Its protection at
year end is the year fallback (deployed 0AfSW000001M4nZ0AS) and the invoice headers now read
from two archives. Open option, not chosen: re-read the last week of the scadenzario each night.
