---
id: trace-2026-08-31
type: reference
status: active
updated: 2026-08-31
watermark_used: 2026-08-28T22:00Z
external_watermark: 2026-08-31T22:00Z
account: a.mrruku@romicompany.com
---

# Source trace 2026-08-31

**Watermark for the next `requirements-check` run: 2026-08-31T22:00Z.**

**Watermark used for this run: 2026-08-28T22:00Z** — from
[the 28 August trace](Source%20trace%202026-08-28.md), selected by its `updated:`
frontmatter field, not by filename order. The window covers **29, 30 and 31
August**; the 29th and 30th were a weekend and are empty on every source.

**The client sent one thing and it was the important one.** No meeting ran. The
night's other two findings are ROMI-side: a marketing invitation, and — for the
**second consecutive run** — an `org-status-check` whose results were never
written back, this time carrying a data-loss incident with an expiring recovery
window.

## Sources searched

All read-only. **Nothing was sent, replied to, shared, modified or marked read**,
with the single carve-out of the nightly report to `C0BQD34LLF4`.

| Source     | Query / scope                                                                 | Result                                                                                       |
| ---------- | ----------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------- |
| **Gmail**  | `pienissimo after:2026/08/28`                                                 | 5 threads, **2 new** — the Anticipay API mail and the MKT invitation                         |
| **Gmail**  | all mail `after:2026/08/28 -in:draft`                                         | 40 threads. Only the same 2 are Pienissimo; the rest is Daze, BE.MA, LIFE365, TFP, Permo, bitmobility, 247.it and Salesforce admin notices |
| **Slack**  | workspace-wide incl. private channels, DMs and group DMs, `pienissimo`        | 6 hits, **1 new** — the 31/08 org-status report in `C0BQD34LLF4` and Aurel Mrruku's self-DM  |
| **Slack**  | workspace-wide, `biglietto` + WooCommerce/Mexal/Anticipay terms, after 28/08  | 4 hits, all the same org-status report — no other project content                            |
| **Slack**  | `#tproj-pienissimo` (`C0B5T3RB4FM`), read directly, 8 messages back           | **Silent again.** Newest post still Elena Spini's 28/08 status, already held                 |
| **Slack**  | Canvas *Link utili Pienissimo* (`F0BD2H5A9HT`), re-read in full               | **Unchanged.** Newest entry still **20.08** — now **five** client sessions behind             |
| **Drive**  | `modifiedTime > 2026-08-28T20:00:00Z`, fully paged (2 pages)                  | 11 items, **0 Pienissimo** — all BE.MA, Daze, LIFE365 or bitmobility                          |
| **Fathom** | all meetings created after 2026-08-25                                         | **0 recordings.** Unchanged since 06 Aug — recordings still land in Drive, not Fathom          |
| **Repo**   | `git log --all` for each deleted Biglietto component                          | **0 commits, all eight** — evidence the org check did not have                                 |

## Found

### 1. 🟢 The Anticipay API documentation arrived, four days early

Mail _"Pienissimo - Documentazione API per chiamata informazioni aziende"_,
**Andrea Parmeggiani → Aurel Mrruku, 31 August 16:15Z**, cc Elena Spini,
`amministrazione@pienissimo.com`, Fabrizio Paganelli and Sabatino Rinaldi. One
attachment: **`Documentazione API – Salesforce.pdf`**.

He owed it by **Friday 4 September** and sent it on Monday the 31st. This is the
first client commitment on this project delivered ahead of its date, and it turns
the **1 September 10:00** follow-up from a chase into a review.

⚠ **The PDF is unread.** This sweep cannot open a Gmail attachment. The same gap
as the WooCommerce payload on 27 August, which needed Aurel Mrruku to download it
by hand — carried forward below as the cheapest outstanding ask.

🔴 **The mail body alone carries a new contract fact.** For the test period the
middleware **serves only from the Pienissimo cache and does not forward to
Anticipay**; at the end of testing it will forward, transparently to ROMI. So an
uncached P.IVA returns nothing, and a test-period `404` cannot be distinguished
from a genuine "not found" — the agreed error semantics give `404` one meaning and
during testing it carries two. The switch is Pienissimo Software's to flip, on **no
named date and with no signal to ROMI**. Folded into
[OI-94](../items/OI-94%20Anticipay%20is%20called%20through%20the%20Pienissimo%20middleware.md)
and [OI-95](../items/OI-95%20Which%20Anticipay%20fields%20land%20in%20Salesforce.md).

### 2. 🔴🔴 A destructive deploy removed `Biglietto__c`, its 37 records and seven unversioned Apex components

`org-status-check` ran **31 August 09:36–09:52Z** against `00DMA000004nMMr2AM`
(partial sandbox, **API 68.0**, was 67.0) at repo `7294717`, inventoried 1,049 org
components against 156 in the repo — and closed, again, with _"no note or
requirement mutated, nothing published."_ Its findings existed **only in Slack**
until this sweep. That is the second run in a row, and the 28 August trace
predicted exactly this.

**The object and its 37 records are gone.** Not migrated: Asset went 4 → 5, not
4 → 41. Recycle-bin recovery is roughly 15 days, so the window closes around
**12 September**, one day after Fase 1 development is due to end. **The only
finding in the current record that decays if nobody acts.**
[The dataset risk](../risks/Risk%20-%20the%20Biglietto%20UAT%20ticket%20dataset%20was%20deleted.md).

**The mechanism, which the org check explicitly did not establish, is in the
repository.** Commit **`5d8cdb3`** — Anita Aga, 28 August 18:10 CEST — deletes the
object from `force-app/` and adds
`manifest/biglietto-cleanup-destructiveChangesPost.xml`, naming the object, tab,
layout, list view, six Apex classes, a trigger and a Visualforce page. A planned
cleanup following the 24 August Asset decision. **Whether an export was taken
first is recorded nowhere**, and that is the whole of the recovery decision.

🔴 **The code half is worse, and this sweep corrected the org check's reading of
it.** `git log --all` returns **zero commits touching any of the eight deleted
components, on any branch** — they were never in source control at all. So ~270
lines of the DocuSign send path and the PDF stack are gone from their only copy,
code that had demonstrably run (19 of the 37 records carried an envelope id). The
org check called this _"drift resolved by deletion from both sides"_; **there were
never two sides**, and a deleted Apex class has no user-facing restore the way a
deleted object does.
[The code risk](../risks/Risk%20-%20the%20Biglietto%20Apex%20stack%20is%20not%20in%20source%20control.md).

### 3. 🔴 The same pattern is live again on WooCommerce, and three smaller findings

- **`WoocommerceOrderService` (org, 23,087 chars, modified 31/08) is not in source
  control**, while the repo's unshipped `WooCommerceOrderEndpoint` claims the same
  `urlMapping`. A clean deploy would publish a second class on a live route and
  orphan the working one. New note:
  [the deploy risk](../risks/Risk%20-%20a%20clean%20deploy%20would%20orphan%20the%20live%20WooCommerce%20endpoint.md).
- **The duplicate-order contract changed silently** from `409` to `200` with
  `duplicate: true`. A contract change on a live integration whose counterparty
  was never told — Sabatino Rinaldi's plugin can no longer tell "created" from
  "already existed" by status code, and the tests are this week.
  [OI-104](../items/OI-104%20The%20WooCommerce%20payload%20has%20no%20idempotency%20key.md).
- **`INT-16` survived a full rewrite still unauthenticated.** The service is still
  `global without sharing`; its only `Authorization` handling redacts the header
  for logging. Four days of real production traffic with no application-level auth.
  [OI-102](../items/OI-102%20Salesforce%20endpoint%20and%20token%20for%20the%20WooCommerce%20plugin.md).
- **Coverage 0% of 1,571 lines across 21 classes**, from 1,769 across 28 — ⚠ the
  entire fall is the deleted code, **no test was written**. The largest uncovered
  class is now `WoocommerceOrderService` at 396, which cannot be read from the
  repository.

### 4. 🟢 A marketing session is booked, the first since 19 August

`[PIENISSIMO]- Interna Flussi MKT`, **Monday 7 September 10:00–11:00 CEST**,
invitation 31 August 16:07Z — Elena Spini, Aurel Mrruku, Fabrizio Mastracci,
ROMI-internal. The natural forum for `30 vs 60` and the plain-text style
constraint, both of which
[OI-81](../items/OI-81%20Event%20communication%20funnel.md) has carried undecided
while the flow is being built. ⚠ No agenda was published, and both questions have a
client-side dependency an internal meeting cannot discharge.

## What it changed

**Nine notes updated, three created.** **No requirement changed**, so the YAML
register and both prose requirement documents are untouched — nothing the client
has signed moved tonight.

| Written | Because |
| --- | --- |
| `Risk - the Biglietto UAT ticket dataset was deleted` | **new** — 37 records gone, recovery window closing ~12 Sept |
| `Risk - a clean deploy would orphan the live WooCommerce endpoint` | **new** — two classes, one live route, one of them unversioned |
| `Source trace 2026-08-31` | **new** — this note, and the next run's watermark |
| `Risk - the Biglietto Apex stack is not in source control` | the risk **materialised**; severity → critical; the org check's "resolved" reading corrected |
| `Risk - production deploy is blocked by Apex coverage` | 1,571/21 measured; the fall is deleted code, not progress |
| `The Biglietto build` | status → **superseded**; kept as the only surviving description of the object |
| `OI-66` | status → **superseded**; its subject was deleted, not covered |
| `OI-94` | the API doc arrived; the cache-only test mode recorded |
| `OI-95` | the prerequisite is discharged; the decision still has no date |
| `OI-102` | `INT-16` re-verified after a rewrite; the tests are live |
| `OI-104` | the class was rewritten and renamed; 409 → 200 |
| `OI-81` | the 7 September session gives both open questions a forum |
| `MAP.md`, `INDEX.md` | the 31/08 block, the two new risks, four corrected rows |

Also: `open-items.md` **and** `.it.md` rows **66, 81, 94, 95, 102, 104**; a new
**§22** in `DEVELOPMENT-RECAP.md` **and** `.it.md`, plus the §21.10 build table
corrected in both — it still said the WooCommerce endpoint was "not created".

## Deliberately not ingested

- **The 31/08 Salesforce account mails** for `techromi@pienissimo.com` — a new
  verification method, an unrecognised-browser notice and an account-verification
  mail for `ability-customization-52152.my.salesforce.com`, which is **not** the
  Pienissimo UAT org (`00DMA000004nMMr2AM`). Routine authentication traffic, no
  project content. **No credential or verification value was read or copied.**
  Recorded so the next run does not re-open them.
- **LIFE365** — the 03/09 Data Model invitation and that project's own nightly
  report. **IUAD** — its nightly report, which mentions Pienissimo only in
  passing. Different clients.
- **Daze** (`Campi chiave sf per oggetto`, the SAL notes, the case-email
  exercise), **BE.MA** (blueprint, questionnaire, field workbook), **TFP**
  (Tableau estimate), **Permo**, **bitmobility**, **247.it**. Other projects.

## Still unreachable / still owed

Carried forward, with tonight's movement marked.

- 🔴 **NEW — `Documentazione API – Salesforce.pdf`**, attached to Andrea
  Parmeggiani's 31/08 16:15Z mail. **The cheapest outstanding ask in the record**
  and the most valuable: it is the Anticipay API contract and the 1 September call
  is about it. Needs a human to download it, exactly as the WooCommerce payload did
  on 28 August.
- 🔴 **NEW — whether an export was taken before the 28/08 destructive deploy.**
  Only Anita Aga can answer. It decides whether the 37 records and the DocuSign
  evidence are worth recovering before ~12 September.
- 🔴 **The Salesforce endpoint and token** ROMI owes Pienissimo
  ([OI-102](../items/OI-102%20Salesforce%20endpoint%20and%20token%20for%20the%20WooCommerce%20plugin.md)).
  **The tests it blocks started today** and the endpoint is still unauthenticated.
- 🔴 **The marketing package** — DNS records, funnel screenshots, newsletter and
  header graphics (Matteo Distaso, Rebecca Marmo). Ten to eleven days overdue.
- 🔴 **The 100+ form review** — nine weeks, confirmed outstanding by ROMI's PM on
  28/08 and unmoved since.
- 🟡 **WooCommerce CK/CS credentials** — still genuinely ambiguous, still
  undecided, not owed and not closed.
- 🔴 **A Mexal test company** — serie 10 is still a test lane inside production
  data. No owner. WooCommerce has the same gap, unnamed.
- 🔴 **Mexal's coded-value dictionaries** — asked for by email, unanswered.
- **Marco Montesi's preset quote-expiry timings** per product category.
- **The Pienissimo 30 July marketing follow-up** notes — never circulated.
- **The Zoho data-model workbook** ([OI-24](../items/OI-24%20Data%20model%20workbook.md))
  and ROMI's **import template** ([OI-88](../items/OI-88%20Zoho%20import%20template%20owed%20to%20Pienissimo.md)).
- ⚠ **The Slack canvas is now five client sessions behind** — newest entry 20.08,
  missing 25 Aug Anticipay, 26 Aug Mexal and both 27 Aug WooCommerce sessions,
  plus the two 24 Aug internals. Unchanged for a third week.
- ⚠ **`STATUS.md`, its Notion mirror and the Flows page** are still owed by
  `org-status-check` — **third trace running**. This sweep did not open the org.

## Method notes worth keeping

- 🔴 **The stranded-org-check problem is now a pattern, not an incident.** The
  28 August trace added "check for a recent `org-status-check` report on Slack as
  part of this sweep" as a method note. Tonight that check is what surfaced a
  **data-loss incident with an expiring recovery window** that had been sitting
  unread in a group DM for fourteen hours. Two runs, two stranded reports. This is
  worth fixing at the source rather than catching nightly: the two procedures
  still do not talk to each other, and the nightly sweep is now load-bearing for
  the org check's findings reaching anyone.
- **Check the repository before believing an org check's "I could not establish
  this".** The 31 August run said plainly that it verified the deletion but *not*
  the mechanism and *not* whether an export was taken. The mechanism was one
  `git show` away — a named commit, a destructive-changes manifest, an author and
  a timestamp. An org check reads the org by design; the repository half is this
  procedure's to add.
- 🔴 **A metric that improves because code was destroyed is not an improvement.**
  Coverage went from 1,769 uncovered lines to 1,571 and every line of the
  difference is the deleted Biglietto stack. Reported without that sentence
  attached, it reads as movement toward the 75% floor. Any summary of coverage on
  this project between now and the test task must carry the correction with it.
- **"Resolved by deletion from both sides" deserved checking, and did not survive
  it.** The org check's phrasing implied the code existed in the repository and
  was removed there too. `git log --all` says it never existed anywhere but the
  org. The difference between "tidied up" and "destroyed the only copy" is the
  whole finding, and it turned on one command.
- **A client meeting a deadline early is itself worth reporting.** Nothing in this
  record has arrived ahead of its date before. It is a fact about how this
  counterparty is behaving now, and it belongs in the report next to the failures.
