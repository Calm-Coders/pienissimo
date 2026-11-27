---
id: trace-2026-11-27-nightly
type: reference
status: active
updated: 2026-11-27
watermark_used: 2026-11-26T22:00Z
external_watermark: 2026-11-27T22:00Z
account: a.mrruku@romicompany.com
---

# Source trace 2026-11-27 nightly

**Watermark for the next `requirements-check` run: 2026-11-27T22:00Z, single
value.**

**Watermark used: 2026-11-26T22:00Z**, the `external_watermark` stated by
[the 26/11 nightly trace](Source%20trace%202026-11-26%20nightly.md), selected by
`updated:` frontmatter. Scheduled nightly run, executed 2026-11-27 ~21:50Z.
**One day.**

🔑 **The headline: the client never started using the platform.** ROMI's first
weekly status since the PEC says so outright, reports that Pienissimo has gone on
working in **Zoho**, and records a client request of 25 November for **a new data
import and a new start date** — the antecedent _"la nuova migrazione"_ has lacked
for three days. The same post names **the scadenziario and the credit notes as the
only residual Fase 1 items**, reversing the perimeter slide its own author wrote
thirty hours earlier. And **from 1 December the project has neither its technical
lead nor the developer who built its only live work.**

🟢 **Environment note.** The clone opened on **`main`** (two commits, config only)
with none of the knowledge layer in the working tree; `DevMain` did not exist
locally and `git checkout DevMain` needed a `git fetch origin DevMain` first.
**Forty-third run, same opening pattern.** Working tree **clean** at start,
`DevMain` at **`0cca57a`**.

⚠ **`MAP.md`'s first 130 lines are ~104 KB**, not the ~120-line read the read
protocol assumes. The head was taken as a **2.5 KB byte slice** plus a line-start
scan instead.

## Sources searched

| Source | Query / scope | Result |
| ------ | ------------- | ------ |
| **Gmail** | `pienissimo after:2026/11/26 -in:draft`, 50 requested | 🔴 **0 threads.** Nothing at all under the project name in the window |
| **Gmail** | `after:2026/11/26 (pienissimo.com OR pienissimo.pro OR "ROMI-PIENISSIMO" OR kreosoft OR mexal OR scadenziario OR biglietto OR PEC OR contestazione OR "nota di credito" OR migrazione OR perimetro)` | **3 threads, 0 Pienissimo** — Zucchet/ZCT invoicing, Life365 production credentials, Permo/DVM article images. ⚠ The Life365 thread carries a **JWT assertion in the message body**; recorded as having happened, **value not copied**, and it is another project |
| **Gmail** | `after:2026/11/26` by participant address — Rinaldi, Paganelli, Montesi, Migliano, Merendi, Parmeggiani, Morgese, `amministrazione@pienissimo.pro` | 🔴 **0 threads. No client mail in the window at all — a seventh day** |
| **Gmail** | `after:2026/11/24 (pec.it OR raccomandata OR legale OR avvocato OR "art. 1454" OR "messa in mora" OR diffida OR inadempimento OR "nuova migrazione" OR "importazione dei dati")` | **10 threads, 1 Pienissimo** — the 25/11 training calendar mail, **pre-watermark, still one message, still `UNREAD`**. 🔴 **The PEC and ROMI's reply are still not in this mailbox**, a **seventh** day. 🔴 **No mail carries Fabrizio Paganelli's 25/11 import request** |
| **Slack** | `slack_read_channel C0B5T3RB4FM` (`#tproj-pienissimo`), `oldest` 1795730400 | 🔑 **THE FINDING. 1 message** — Elena Spini's weekly status, **27/11 17:00:00 CET**, the first on this channel since the PEC → **OI-387**, OI-380, OI-386, OI-385, OI-378, OI-377, OI-381, OI-376 |
| **Slack** | `slack_read_thread C0B5T3RB4FM 1795795200.249479` | **No replies.** Nobody has responded to the status post |
| **Slack** | `slack_read_channel D0B5QHS2T7H` (Elena Spini DM) | 🔴 **0 new messages** since the 26/11 18:08 3CX line (another project). The 26/11 huddle remains unreadable |
| **Slack** | `slack_read_channel C0C38JJ9D1T` (marketing group DM) | 🔴 **0 new messages.** The 25/11 calendar repost and the consent thread unchanged |
| **Slack** | `slack_read_channel C0BQD34LLF4` (ROMI dev group) | 🔴 **10 messages, every one of them mine**, newest 26/11 23:00:29 CET. **No human has ever replied to a nightly report** |
| **Slack** | `slack_search_public_and_private` `pienissimo`, `after:2026-11-26`, sorted by time | **1 result** — the status post. Nothing else anywhere |
| **Slack** | `slack_search_public_and_private` `scadenziario` · `migrazione` · `perimetro`, each `after:2026-11-26` | **1 result each, all the same status post.** `migrazione` also returned the `#tproj-vision` status — another project |
| **Slack** | `slack_search_public_and_private` `anita`, `after:2026-11-26` | 🔑 **2 results, 1 decisive** — `D0CEWML860G`, Davide Losco **15:58:57 CET**, _"Abilito Anita a VFL1 su clockify ok?"_ → **OI-384** |
| **Slack** | `slack_search_public_and_private` `clockify from:<@U0BP306HH9N>` `after:2026-11-26`, with context | 🔑 **The replies.** Aurel Mrruku **16:38:26** _"ciao ok , fino il 30 non mette niente"_ and **16:38:35** _"poi dal 1 inizia lei"_ → **OI-384**. ⚠ The same thread asks who closes a departing colleague's accounts — **another project's staffing, not copied** |
| **Slack** | `slack_search_public_and_private` `after:2026-11-26 is:dm`, 20 results, newest first | **Confirms the sweep is complete.** The only Pienissimo item is the channel status post. The rest LIFE365, VISION/Vape, VFL1, 3CX, Clockify and a git question — all other projects |
| **Slack** | `slack_read_canvas F0BD2H5A9HT` (`Link utili Pienissimo`) | **Unchanged.** Newest entry still 20.08.2026 — **99 days**. Re-read per the skill |
| **Drive** | `modifiedTime > '2026-11-26T22:00:00Z' and trashed = false`, 40 requested, `modifiedTime desc` | **14 files, 🔴 none Pienissimo** — VISION ×5, Daze ×2, Permo, VFL1, 247.it, Easystor/WMS ×3, `[ROMI] Slide Team`. **A sixth day with no Pienissimo Drive activity** |
| **Drive** | `(title contains 'Pienissimo'/'scadenziario'/'perimetro'/'migrazione') and modifiedTime > watermark` | 🔴 **0 hits.** **`Pienissimo_Offerta_Fase_2_V_4.1.pptx` was not touched after 26/11 11:43:11Z**, which is what makes OI-386's contradiction documentary. No copy of the PEC, none of ROMI's reply, nothing on the new import |
| **Fathom** | `list_meetings created_after 2026-11-26T22:00Z`, 3 pages, summaries on | 🔴 **0 meetings. Nothing at all, a forty-sixth consecutive run** |
| **Repo** | `grep force-app` for `Recommended_Products__c`, `Cross_Sell_Product__c`, `Additional_Email__c`, org id `00Dbl0000062Kar` | ⚠ **Exclusion check, deliberate.** A Marketing Cloud production message in a group DM (27/11 17:56:50 CET) cites these; **none exists in this repository**, so it is **another project** and was excluded rather than guessed at |
| **Git** | `fetch --all`, `log --all --since 2026-11-26T22:00Z`, `status` | 🔴 **0 commits in the window** on any branch. Tree **clean** at start, `DevMain` at `0cca57a` |
| **GitHub** | `list_pull_requests` state all, sorted by update | 🟢 **0 open pull requests**, a third day. The five most recently touched are all merged; newest merge still #132, 25/11 |
| **Repo** | `JOURNAL.md` head, `MAP.md` head slice, `ls notes/items` max-id scan | Watermark and state confirmed. Max existing id **386**; **387 allocated this run, next free is 388** |

## Found

1. 🔑🔴 **[OI-387 — the client is not using Salesforce and has asked for a new
   import and a new start date](../items/OI-387%20The%20client%20is%20not%20using%20Salesforce%20and%20has%20asked%20for%20a%20new%20import%20and%20a%20new%20start%20date.md)**
   — **new note, the only id allocated this run.** Elena Spini, `#tproj-pienissimo`
   **27/11 17:00:00 CET**: _"**Avvio sulla piattaforma: Pienissimo non la usa
   ancora.** In questi giorni hanno continuato a lavorare su Zoho e **Fabrizio P.
   (25/11) ci chiede una nuova importazione dei dati e una nuova data di avvio su
   Salesforce**"_, with _"Avvio senza data"_ as her own red flag. 🔑 **The first
   explicit statement in the record that the go-live of 16 November did not take**,
   sitting beside ROMI's standing position that Fase 1 has been in production since
   that date — delivered but not adopted. 🔴 **The request itself is in no reachable
   source**: 0 Gmail, 0 Slack, 0 Drive, 0 Fathom. 🔴 **No scope** for the import and
   🔴 **no forecast** for the project — close date and days-to-finish both _"da
   definire dopo la call del 30/11"_. ⚠ Zoho still in use on 27 November implies a
   contract extension past 31 October that nobody recorded; **recorded as an
   inference**.

2. 🔑 **[The residual perimeter reversed itself in thirty hours](../items/OI-380%20The%20client%20wants%20the%20scadenziario%20and%20the%20credit%20notes%20as%20soon%20as%20possible.md)**
   — **OI-380 and
   [OI-386](../items/OI-386%20The%20residual%20Fase%201%20list%20omits%20the%20scadenziario%20and%20the%20credit%20notes.md)
   updated.** The same status post says _"**Per noi mancano solo scadenziario e note
   di credito**"_ and puts both on the 30/11 agenda — **precisely the two items the
   `CRONOPROGRAMMA` slide of 26/11 11:43:11Z omits**, while the slide's three items
   are reported done or scheduled. **Later evidence wins**: internally they are
   residual **Fase 1**, which is the classification the client has demanded since
   20/11. ⚠ **The deck was not corrected** — verified: no Drive modification after
   11:43:11Z — so the only *written* perimeter still omits them and still prices them
   `R1` 14/12/2026 and `R6` 12/04/2027. ⚠ Nothing records which version ROMI will
   present. **Both dates cited, per the protocol.**

3. 🔑🔴 **[Anita Aga's move off the project has a date — 1 December](../items/OI-384%20Anita%20Aga%20is%20being%20reallocated%20off%20Pienissimo%20while%20Fase%202%20is%20stopped.md)**
   — **OI-384 updated.** `D0CEWML860G`: Davide Losco **15:58:57 CET**, _"Abilito
   Anita a VFL1 su clockify ok?"_; Aurel Mrruku **16:38:26** _"ciao ok , fino il 30
   non mette niente"_ and **16:38:35** _"poi dal 1 inizia lei"_. Time booking on the
   receiving project is enabled and **she starts there on 1 December**. 🔴 Still not
   agreed with her in any source, still not approved above Aurel Mrruku, share of
   her time still unstated. 🔴 **The premise was contradicted three hours later** by
   the status post's new migration and new start date. ⚠ **From 1/12 the project has
   neither her nor its technical lead**, on the day the marketing check runs in
   production.

4. 🔑 **[The 30 November call now has four outputs and an antecedent](../items/OI-385%20A%20scope%20perimeter%20call%20and%20a%20new%20migration%20are%20planned%20for%2030%20November.md)**
   — **OI-385 updated.** _"la nuova migrazione"_ finally has a referent — Fabrizio
   Paganelli's 25/11 request — but **no scope, three days out**. The call is expected
   to produce the complete list of what the client expects, a ruling on the
   scadenziario and the credit notes, a migration plan **and** a new start date, in
   one hour; the perimeter and the date are then to be fixed *after* it by Elena
   Spini. 🔴 **No substitute named for 30/11 or 1/12, a third day.**

5. 🟢 **[The lost training sessions are explained and rescheduled](../items/OI-378%20Marketing%20training%20is%20undelivered%20and%20the%20client%20did%20not%20attend%20the%20final%20test.md)**
   — **OI-378 updated.** _"le sessioni del 24 e 26/11 sono saltate per Pienissimo
   Live"_ — ⚠ ROMI's account, unconfirmed by any client source, and nothing records
   who cancelled them. Rescheduled **3/12 Modulo 1** and **4/12 Modulo 2**, with
   **1/12** the final flow check **in production** including reminder timings and
   conditional on a client test campaign that still has no owner. 🔴 **The client has
   not replied to the calendar** — thread still one message, still unread, a second
   day.

6. 🟢 **[The deploy consent is attributed in a status document](../items/OI-381%20The%20report%20and%20dashboard%20remediation%20is%20unmerged%20and%20due%20in%20production%20on%20a%20holiday.md)**
   — **OI-381 and
   [OI-377](../items/OI-377%20Reports%20and%20dashboards%20were%20never%20built%20and%20have%20no%20requirements.md)
   updated.** _"Report e dashboard: **in PROD dal 25/11, con l'ok di Angelo**"_ — the
   first time the authorisation is stated as **Angelo Pastorelli's** in a status
   document rather than inferred from a chat thread. 🔴 **Gianpaolo Motta's position
   is still unrecorded.** 🔴 **The acceptance test now has no taker at all**, because
   the client is not using the platform, and the **tranche report is unscheduled with
   three days to month end** while its author leaves on 1/12.

7. 🔴 **[The freeze is contradicted by a published plan](../items/OI-376%20All%20Pienissimo%20work%20is%20frozen%20except%20reports%20and%20dashboards.md)**
   — **OI-376 updated.** The status sets out four client sessions, a perimeter
   exercise, a migration and a new start date with an owner. **Nothing in the record
   has lifted the 19/11 _"il resto fermi tutti"_**; the freeze has stopped describing
   the project rather than being revoked.

## Not done, and why

- **The org was not opened.** `STATUS.md` and its Notion mirror are **stale** and
  step 6 of `org-status-check` was **not** run. ⚠ Nothing in this window was a
  metadata change — 0 commits, 0 PRs, no release — so the org-vs-record gap did not
  widen; what remains unanswered is whether anything was deployed outside source
  control.
- **No meeting was drilled, because no meeting happened.** Fathom returned 0 for a
  forty-sixth run, Drive holds no new Pienissimo recording or transcript, and the
  only new artifact in the window is a Slack status post, which is not a meeting.
  **`drill-meeting` was not invoked.**
- **No Apex test class was written or proposed.** Standing instruction. OI-64, OI-66
  and [the deploy risk](../risks/Risk%20-%20production%20deploy%20is%20blocked%20by%20Apex%20coverage.md)
  are unchanged and were not acted on.
- ⚠ **The Fase 2 deck was not re-read** — deliberately. It did not change in the
  window, and confirming that is what makes OI-386's contradiction documentary. The
  `150` vs `58 - 78` discrepancy therefore remains unresolved.
- ⚠ **Elena Spini's change workbook of 13/11 was again not found** — a **tenth**
  window.
- **The client change sheet was not re-read** — no Drive edit in the window, so
  OI-344 stands at 7 `SI` / 4 `IN LAVORAZIONE` / 2 `NON SI FA` / 6 blank.
- **No customer-data workbook or attachment was opened.** None was offered.
- **The 26/11 12:02 Slack huddle still could not be read** — huddles leave no
  transcript this account can reach.
- ⚠ **A Marketing Cloud production message was excluded after a check, not a
  guess.** A group DM of 27/11 17:56:50 CET reports Marketing Cloud connected to a
  production org and syncing `Recommended_Products__c`, `Cross_Sell_Product__c` and
  `Additional_Email__c`. **None of those fields exists in this repository**, and the
  cited org id appears nowhere in the records, so it is another project.
- ⚠ **A JWT assertion in a Life365 mail body was seen and not copied.** Recorded
  here as having occurred; the value is not in the repository, and it is another
  project.
- ⚠ **Another project's departing colleague** is named in the same DM that carried
  the OI-384 finding. **Deliberately not copied** — other-project staffing, personal
  to them.
- **OI-336, OI-343, OI-345, OI-347 to OI-374, OI-379, OI-382, OI-383 were not
  updated** — **no new evidence in this window.** ⚠ Most are frozen rather than open.
- **The requirement register was not touched** — stays **v1.6**. ⚠ The reports and
  dashboards are production metadata with no requirement; **a second migration is now
  a client request with none**; and the residual-Fase-1 perimeter exists as a slide
  and a chat line that disagree with each other.
- **VISION / VapeItalia, Life365, Permo / DVM / doydesign, 247.it, Zucchet / ZCT /
  3CX, IUAD, VFL1, Daze, Easystor / WMS and `[ROMI] Slide Team` were excluded** —
  other projects, per the skill.
- **`prettier:verify` was not run** (not executable in this environment, as on
  previous runs).

## Still unreachable

Named precisely enough to ask someone for them:

- 🆕🔴 **Fabrizio Paganelli's request of 25 November itself** — its wording, channel
  and recipient — and **the scope of the new import**: which objects and files,
  replace or supplement the 13/11 load, how existing Salesforce records reconcile,
  Fase 1 or Fase 2. **Before 30 November 10:00** (OI-387, OI-385).
- 🆕🔴 **Why the client has not adopted the platform** — no source states a reason;
  the PEC is the only candidate in the record (OI-387).
- 🆕⚠ **Whether Pienissimo's Zoho contract was extended past 31 October**, and until
  when — implied by the client still working in Zoho, recorded nowhere (OI-387).
- 🆕🔴 **Which perimeter ROMI will put to the client on 30 November** — the
  `CRONOPROGRAMMA` slide, which omits the scadenziario and the credit notes, or the
  weekly status, which says they are the only two things left (OI-386, OI-380).
- 🆕⚠ **Whether the Fase 2 deck will be corrected**, and whether it is sent to the
  client in its present state (OI-386).
- 🆕🔴 **A new start date** for the platform, which by ROMI's own plan cannot exist
  before 30 November (OI-387).
- 🆕⚠ **Whether Anita Aga agreed to the move**, and **whether anyone above Aurel
  Mrruku approved it** — now dated to **1 December** and still recorded nowhere but a
  one-to-one DM (OI-384).
- 🔴 **Who represents the build on 30 November and 1 December** — a third day
  unanswered, no substitute named, and **from 1 December neither the technical lead
  nor Anita Aga is on the project**; 1/12 runs **in production**.
- 🔴 **Whether the 30 November perimeter, once agreed, is put to the client in
  writing as the closed scope.**
- 🔴 **Whether the client accepts the 30/11-4/12 calendar** — no reply at all, the
  mail still unread, a second day (OI-378).
- ⚠ **Who configures the client-side test campaign for 1 December** (OI-378).
- ⚠ **Who agreed that the note di credito belong in April** — the deck asserts _"in
  accordo con voi"_ and nothing records it (OI-386).
- ⚠ **What was agreed in the Slack huddle of 26/11 12:02:47 CET**, and **whether a
  second pre-call check is booked** before Monday 10:00.
- ⚠ **Who "Daniele" is** in Angelo Pastorelli's _"eravamo rimasti cosi con Daniele"_
  of 25/11, and **what the 24 November voice message said** (OI-380).
- ⚠ **Whether client contact on the clarifications call, the migration and the new
  start date is authorised**, by name, by Angelo Pastorelli or Gianpaolo Motta
  (OI-375, OI-385).
- 🔴 **Gianpaolo Motta's ok or refusal on the production release** — never recorded
  at any point (OI-381).
- 🔴 **Who may see the reports and dashboards**, and **whether the client tests them**
  — now doubly blocked, since the client is not using the platform (OI-377, OI-381,
  OI-387).
- 🔴 **The tranche report schedule**, due before month end — **three days left**
  (OI-377, OI-381).
- ⚠ **Whether anything was deployed to Pienissimo Prod outside source control.**
- 🔴 **The PEC of 17 November itself** — its text, heads of claim and above all **the
  term it fixes under art. 1454 c.c.** — **and ROMI's reply as sent**, with receipts.
  **Confirmed not in this mailbox**, so ask Angelo Pastorelli, Elena Spini or
  Gianpaolo Motta for the PEC mailbox copy. **Seventh day.**
- 🔴 **The detailed rebuttal ROMI reserved**, and the Fase 2 chronology behind it.
- 🔴 **Any record of the 20/11 14:30 meeting**, and of the four private contacts with
  the client's direction (20/11, 23/11, 24/11 voice message, and Angelo Pastorelli's
  _"oggi la sento"_ outcome).
- **Whether the calendar of next activities ROMI promised in its reply was handed
  over.**
- **Rebecca M's surname** (OI-378).
- **Fabrizio Mastracci's scaletta** for the two training modules — a **tenth**
  window — **ROMI's training record**, and **whether the 19/11 test pack was ever
  sent** (OI-378).
- **The WhatsApp number, its block date and Meta's stated reason**, and who at
  Pienissimo is dealing with it — formally the client's job per the deck (OI-382).
- **Whether no Biglietto from migrated data is correct or a defect**, with an owner
  (OI-373) — ⚠ now bearing on the new import.
- ⚠ **What the two Slack audio messages of 20/11 morning say** — still not
  transcribable by this account.
- **The contract clause that makes reports and dashboards a deliverable**, quoted,
  and the contractual training provision behind the 20-hour figure (OI-377, OI-378)
  — **ninth day**.
- **Who may write to the client about anything other than training**, by name
  (OI-375, OI-381, OI-383, OI-385).
- **Whether the order PDF DocuSign configuration exists in production** (OI-373,
  OI-374) — eighth day.
- **Whether any real WooCommerce order has ever been taken end to end in
  production** — eighth day.
- **Whether a production quote PDF now prints an Italian date** (OI-358).
- **Whether the three Mexal schedulers in production run as `amministratore
  pienissimo`** (OI-301, OI-334), and **the written run instructions and the job-times
  mail to Sabatino Rinaldi** — ninth day (OI-370).
- **The restore date for the event end dates**, with an owner (OI-353).
- **Whether ROMI accepts or contests the Blueprint claim** — **no reply in
  twenty-two days** (OI-343) — and `OP-1`, `OP-2`, `OP-4` of the R0 analysis, a
  twenty-fourth day.
- **Which articles the live WooCommerce shop sells**, set against those deactivated
  on 15/11, and whether the deferred retest passed (OI-366).
- **Leaving dates and successors for Marco Montesi and Sabatino Rinaldi** (OI-357).
- **Fabrizio Mastracci's go-ahead on the Pienissimo Live forms**, and **which field
  they write for the marketing consent** (OI-371, OI-340 — **thirteenth window**),
  which the 4 December Modulo 2 session will train on.
- **The id-extraction date and format for Pienissimo Live attendance**, and the
  written specification Elisa Migliano asked for (OI-361); **which event Andrea
  Parmeggiani's QR scanner will be ready for** (OI-323).
- **A list of the Aziende with more than one flagged principal contact** (OI-372).
- **Which cleanup option, A or B, for the 50,000 referenti leads** (OI-351), and **a
  corrected mail to the client** replacing the 11/11 approval (OI-352).
- **Whether `numero tranche` and `tipo biglietto` are now defined per article**
  (OI-329).
- **The contract with the missing third signature** (OI-336).
- **Whether the ticket flow's `Recipient_Contact__r` query was ever fixed** —
  unmentioned for a twelfth window (OI-230).
- **The written production user list by role**, the marketing and Performance Plus
  profiles (OI-356, OI-363).
- **Whether the six tutors completed MFA/passkey enrolment** (OI-300).
- **The exact boundaries of Mexal's nightly maintenance window** (OI-334).
- **The picklist workbook** (OI-265, **thirty-fourth day**).
- **The Mexal WEBAPI credentials, the event list, the bundle-only article codes and
  the catalogue prices** — all four owed by mail, confirmed absent again.
- **The twelve `PLUS_B` values** · **what `lead-web-to-lead (2).html` is** ·
  **whether the standing 30/07 marketing follow-up notes exist at all**.
- **Who created fields and changed a layout in Prod without telling anyone** (raised
  13/11, never answered).

## Written back

- **1 new item id — [OI-387](../items/OI-387%20The%20client%20is%20not%20using%20Salesforce%20and%20has%20asked%20for%20a%20new%20import%20and%20a%20new%20start%20date.md).
  Next free is 388.**
- **1 new note**: OI-387.
- **8 notes updated** (`updated:` bumped to 2026-11-27): **OI-376**, **OI-377**,
  **OI-378**, **OI-380**, **OI-381**, **OI-384**, **OI-385**, **OI-386**. **No
  status changes** — every item stays as it was.
- **MAP.md** — new nightly entry at the top, `Last updated` chain extended.
- **INDEX.md** — 8 item rows amended, 1 item row added (OI-387), 1 trace row
  added. Note count **655 → 657** (OI-387 and this trace).
- **`meetings/open-items.md` and `.it.md`** — **8 regenerated rows each** (#376,
  #377, #378, #380, #381, #384, #385, #386) and **1 new row each** (#387),
  last-touched bumped on each.
- **`meetings/DEVELOPMENT-RECAP.md` and `.it.md`** — a new dated update section in
  both.
- **This trace**, and a `JOURNAL.md` entry.
- **Register untouched — v1.6.**
- **No credentials, prices, article codes or personal data were copied.** ⚠ Three
  deliberate omissions: the **JWT assertion** in the Life365 mail body, the name of
  **another project's departing colleague** in the DM that carried the OI-384
  finding, and the Google Meet join links on the calendar mail.
