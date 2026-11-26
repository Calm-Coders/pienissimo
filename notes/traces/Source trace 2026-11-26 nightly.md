---
id: trace-2026-11-26-nightly
type: reference
status: active
updated: 2026-11-26
watermark_used: 2026-11-25T22:00Z
external_watermark: 2026-11-26T22:00Z
account: a.mrruku@romicompany.com
---

# Source trace 2026-11-26 nightly

**Watermark for the next `requirements-check` run: 2026-11-26T22:00Z, single
value.**

**Watermark used: 2026-11-25T22:00Z**, the `external_watermark` stated by
[the 25/11 nightly trace](Source%20trace%202026-11-25%20nightly.md), selected by
`updated:` frontmatter. Scheduled nightly run, executed 2026-11-26 ~21:50Z.
**One day.**

🔑 **The headline: the perimeter the 30 November call exists to establish has
already been written — into the Fase 2 offer deck the client's PEC contests in
full — and it omits the scadenziario and the credit notes, which the same deck
still prices as Fase 2. The pre-call check that was meant to prepare that meeting
produced an empty transcript and an unrecorded huddle, and the client said nothing
at all.**

🟢 **Environment note.** The clone opened on **`main`** (two commits, config only)
with none of the knowledge layer in the working tree; `DevMain` did not exist
locally and `git checkout DevMain` needed a `git fetch` first. **Forty-second run,
same opening pattern.** Working tree **clean** at start, `DevMain` at **`850ceaa`**.

⚠ **`MAP.md`'s first 130 lines are ~104 KB**, not the ~120-line read the read
protocol assumes. The head was taken as a **9 KB byte slice** instead.

## Sources searched

| Source | Query / scope | Result |
| ------ | ------------- | ------ |
| **Gmail** | `pienissimo after:2026/11/25 -in:draft`, 50 requested | **4 threads, all already held** — the training calendar mail (25/11 18:21Z), the two calendar invitations, the PR #132 merge notification. 🔴 **Nothing after the watermark** |
| **Gmail** | `after:2026/11/25 (pienissimo.com OR pienissimo.pro OR "ROMI-PIENISSIMO" OR kreosoft OR mexal OR scadenziario OR biglietto OR PEC OR contestazione OR "nota di credito")` | **6 threads, 1 Pienissimo** — the training thread, pre-watermark. The rest Life365, Permo/DVM, IUAD, Zucchet ×2 |
| **Gmail** | `after:2026/11/25` by participant address — Sabatino Rinaldi, Fabrizio Paganelli, Daniela, Matteo D, amministrazione, Rebecca M, plus `mirko`/`merendi`/`parmeggiani`/`montesi`/`migliano` | 🔴 **1 thread, the pre-watermark training one. No client mail in the window at all** |
| **Gmail** | `after:2026/11/23 (romiagency@pec.it OR pec.it OR raccomandata OR legale OR avvocato OR "art. 1454" OR "messa in mora" OR diffida OR inadempimento)` | 🔴 **10 threads, 0 relevant** — all other projects. **The PEC and ROMI's reply are still not in this mailbox**, a **sixth** day |
| **Slack** | `slack_read_channel C0B5T3RB4FM` (`#tproj-pienissimo`), `oldest` 1795644000 | 🔴 **0 messages.** No new top-level traffic since 24/11 |
| **Slack** | `slack_read_thread C0B5T3RB4FM 1795533272.952249` (the consent thread) | **3 replies, all already held.** No new reply; re-read per the skill because this is how 25/11's finding surfaced |
| **Slack** | `slack_read_channel C0C38JJ9D1T` (marketing group DM) | **0 new top-level messages.** The five of 25/11 re-confirmed |
| **Slack** | `slack_read_thread C0C38JJ9D1T 1795632002.288839` | 🔑 **1 new reply.** Elena Spini **26/11 09:08:53 CET**: _"vero me l'avevi pure detto ma non l ho segnato e speravo di ricordarmi male"_ → **OI-385** |
| **Slack** | `slack_read_channel D0B5QHS2T7H` (Elena Spini DM) | 🔑 **THE FINDING. 9 new messages, 11:39-18:08 CET.** The Meet request, Aurel Mrruku's four replies, _"mi serve un giusto un check pre call con i pazzi per lunedi"_, _"tanto piu se tu non ci sarai"_, and 🔴 **`A huddle started` at 12:02:47** → **the meeting note**, OI-385. The 18:08 message is 3CX, another project |
| **Slack** | `slack_read_channel C0BQD34LLF4` (ROMI dev group) | 🔴 **10 messages, every one of them mine.** **No human has ever replied to a nightly report** |
| **Slack** | `slack_search_public_and_private` `pienissimo`, `after:2026-11-25` | **2 results** — the DM line already read, and a Google Calendar bot post |
| **Slack** | `slack_search_public_and_private` `after:2026-11-25 is:dm`, 20 messages | **Confirms the sweep is complete.** The only Pienissimo messages are those in `D0B5QHS2T7H` and the group-DM thread reply. The rest VISION/Vape, Life365, Permo, 3CX and a git-branch question — all other projects |
| **Slack** | `slack_search_public_and_private` `scadenziario` · `migrazione` · `perimetro` · `anita`, each `after:2026-11-25` | 🔴 **0 results each.** Scadenziario a **sixth** day; the migration undiscussed anywhere; OI-384 unmoved |
| **Slack** | `slack_read_canvas F0BD2H5A9HT` (`Link utili Pienissimo`) | **Unchanged.** Newest entry still 20.08.2026 — **98 days**. Re-read per the skill |
| **Drive** | `modifiedTime > '2026-11-25T22:00:00Z' and trashed = false`, 40 requested, `modifiedTime desc` | **17 files, 3 Pienissimo**: 🔑 **`Pienissimo_Offerta_Fase_2_V_4.1.pptx` modified 11:42:08Z**, plus the new Meet transcript and its shortcut folder. The rest VISION ×6, 247.it, Permo, VFL1, `[ROMI] Slide Team`, a shared-drive price list |
| **Drive** | `(title contains 'Pienissimo'/'PEC'/'scadenziario'/'perimetro'/'migrazione'/'nota di credito') and modifiedTime > watermark` | **4 hits** — the deck, the transcript, its shortcut and its folder. 🔴 **No copy of the PEC, none of ROMI's reply, nothing on the new migration** |
| **Drive** | `read_file_content` on the Meet transcript `1KzK4bOYwPQP7RTbkbC7On0hNuf-I1Lr46ddxFihq4Yk` | 🔴 **1,024 bytes, read in full — NO project content.** Six lines, one speaker, domestic → **the meeting note** |
| **Drive** | `list_file_revisions` on `1G8uQOTnfvLIDFHJdrIXVpxI30mLTXhwr` | 🔑 **One revision only: Elena Spini, 2026-11-26 11:43:11Z** → **OI-386** |
| **Drive** | `read_file_content` on `Pienissimo_Offerta_Fase_2_V_4.1.pptx` | 🔑 **V.4.1 read at last**, resolving the standing _"what V.4.1 changes is unknown"_. The `CRONOPROGRAMMA` residual slide, the per-release pricing and the revised total → **OI-386**, [the Fase 2 offer](../The%20Fase%202%20offer.md). ⚠ **No euro figure transcribed** |
| **Drive** | `get_file_metadata` on `1u6RdPUE…` and `1Z5J223o…` | ⚠ **Exclusion check.** `Blueprint - Signed.pdf` and `Aggiunte progettuati - signed.pdf`, created 26/11 14:03, sit in **`Blueprint` under `[Vision] - Fase Progettuale`** — **VISION, not Pienissimo**. Not confused with OI-343's Blueprint claim |
| **Fathom** | `list_meetings created_after 2026-11-25T22:00Z`, 3 pages, summaries on | 🔴 **0 meetings. Nothing at all, a forty-fifth consecutive run** — including the call that was recorded in Google Meet today |
| **Git** | `fetch --all`, `log --all --since 2026-11-25T22:00Z`, `status` | 🔴 **0 commits in the window.** Tree **clean** at start, `DevMain` at `850ceaa` |
| **GitHub** | `list_pull_requests` state all, sorted by update | 🟢 **0 open pull requests**, a second day. Newest is #132, merged 25/11T17:10:26Z |
| **Repo** | `JOURNAL.md` head, `MAP.md` head slice, `ls notes/items` max-id scan | Watermark and state confirmed. Max existing id **385**; **386 allocated this run, next free is 387** |

## Found

1. 🔑🔴 **[OI-386 — the residual Fase 1 list omits the scadenziario and the credit
   notes](../items/OI-386%20The%20residual%20Fase%201%20list%20omits%20the%20scadenziario%20and%20the%20credit%20notes.md)**
   — **new note, the only id allocated this run.** Elena Spini edited
   `Pienissimo_Offerta_Fase_2_V_4.1.pptx` at **11:43:11Z**, its only recorded
   revision since 20/11, adding a slide titled _"Cronoprogramma attivita residue ·
   Le attivita ancora aperte per la fase 1"_. It carries **three** items — report &
   dashboard, formazione marketing, configurazione WhatsApp. 🔴 **The scadenziario
   and the note di credito are absent**, and 🔑 **the same deck still prices them as
   `R1` 14/12/2026 and `R6` 12/04/2027** — R6 justified as _"collocata ad aprile in
   accordo con voi"_, **an agreement nothing records** and one the 20/11 demand
   contradicts. 🔴 Also absent: OI-344's sixteen changes, _"la nuova migrazione"_
   itself, the order-PDF DocuSign config, the backdated event end dates, the
   inactive WooCommerce products, the referenti leads, and the 13/11 workbook.
   ⚠ **A Fase 1 closure list inside the Fase 2 offer the PEC contests in full.**
   ⚠ Two rows already stale: _"In produzione lunedi"_ against a Wednesday release,
   _"data da concordare"_ against the 1/12 fixed the night before.

2. 🔴 **[The 26/11 pre-call check left no record](../meetings/2026-11-26%20Rapido%20Allineamento.md)**
   — **new meeting note.** `PIENISSIMO - Rapido Allineamento`, invited 25/11
   18:29Z for **26/11 11:30-12:00 CET**, to Aurel Mrruku alone. 🔴 **The Google
   Meet transcript is 1,024 bytes and holds no project content** — six lines, one
   speaker, domestic. The two **missed each other by about fifteen minutes** (she
   asked 11:39, he answered 11:54) and the substance moved to a **Slack huddle at
   12:02:47 CET**, which leaves no transcript. 🔑 The purpose is attested: _"mi
   serve un giusto un check pre call con i pazzi per lunedi"_, _"tanto piu se tu
   non ci sarai"_. 🔴 **No Fathom, no Gemini notes.** ⚠ The deck edit at 11:43:11Z
   falls inside the slot; **the link is timing only and is recorded as inferred.**

3. 🔴 **[The 30/11 and 1/12 coverage gap is acknowledged and unfilled](../items/OI-385%20A%20scope%20perimeter%20call%20and%20a%20new%20migration%20are%20planned%20for%2030%20November.md)**
   — **OI-385 updated.** Elena Spini in thread, **26/11 09:08:53 CET**: _"vero me
   l'avevi pure detto ma non l ho segnato e speravo di ricordarmi male"_ 😅 — so the
   absence was known, was not recorded, and **no substitute is named for either
   session**; 1/12 runs in production. 🔴 **The migration is still undefined** and
   **the client has not acknowledged the calendar**.

4. 🔴 **[A sixth day on the scadenziario and the credit notes, and the omission is
   now documentary](../items/OI-380%20The%20client%20wants%20the%20scadenziario%20and%20the%20credit%20notes%20as%20soon%20as%20possible.md)**
   — **OI-380 updated.** The warning this note carried — _"if they are not raised
   in it they may be excluded by it"_ — **is no longer a forecast about a meeting;
   it is the state of the only written perimeter that exists.** Verified negative
   across all four sources.

5. 🔑 **[V.4.1 read at last](../The%20Fase%202%20offer.md)** — the Fase 2 offer note
   updated. Seven releases, `150 giornate`, 12 April 2027 and the ten maintenance
   days unchanged from V.4; **new** are the residual-Fase-1 slide, a per-release
   price breakdown, a separately priced maintenance line, a revised total, _"Seguira
   documento tecnico"_, a `Mag` timeline column with the client's events, and R3's
   _"Confronto con Andrea sui dati dell'app"_ (⚠ which Andrea is not stated).
   ⚠ **The 20/11 modification by Angelo Pastorelli recorded earlier does not appear
   in the revision list**, which holds one entry; both are kept as their sources
   report them.

6. 🆕 **[Reports and dashboards reach a client-facing commercial document](../items/OI-377%20Reports%20and%20dashboards%20were%20never%20built%20and%20have%20no%20requirements.md)**
   — **OI-377 updated.** First time, as item `01` — ⚠ **with the wrong date**.
   🔴 Register still **v1.6**, contract clause unquoted an **eighth** day, no
   acceptance test, no visibility decision, **tranche report unscheduled with four
   days to month end**.

7. ⚠ **[Two ROMI documents disagree on the final marketing test](../items/OI-378%20Marketing%20training%20is%20undelivered%20and%20the%20client%20did%20not%20attend%20the%20final%20test.md)**
   — **OI-378 updated.** The deck says _"data da concordare"_; the mail of the
   previous evening fixed **1 December**. 🔴 **The client has not replied to the
   calendar at all**, so all four sessions are unconfirmed client-side.

8. 🆕 **[The WhatsApp remedy is allocated in writing](../items/OI-382%20WhatsApp%20is%20blocked%20because%20Meta%20blocked%20the%20client%20number.md)**
   — **OI-382 updated.** _"Non dipende da ROMI … Lo sblocco e in carico a
   Pienissimo"_. ⚠ ROMI's own assertion in its own sales document, not an agreed
   position.

9. 🔴 **[The freeze is being planned around in writing](../items/OI-376%20All%20Pienissimo%20work%20is%20frozen%20except%20reports%20and%20dashboards.md)**
   — **OI-376 updated.** The freeze has never been formally lifted, and **the
   contested Fase 2 deck itself was worked on**. ⚠ In two days: a promised
   migration, a perimeter call and a deck edit, on no authorisation beyond the
   training mail.

## Not done, and why

- **The org was not opened.** `STATUS.md` and its Notion mirror are **stale** and
  step 6 of `org-status-check` was **not** run. ⚠ Nothing in this window was a
  metadata change, so the org-vs-record gap did not widen; what remains unanswered
  is whether anything was deployed outside source control.
- **No meeting was drilled in the full sense, because there was nothing to drill.**
  The one new meeting record in the window was read in full — all 1,024 bytes of
  it — and contains no project content. It is recorded as a meeting note with that
  finding, not re-drilled, and it cost ~0.3k tokens.
- **No Apex test class was written or proposed.** Standing instruction. OI-64,
  OI-66 and [the deploy risk](../risks/Risk%20-%20production%20deploy%20is%20blocked%20by%20Apex%20coverage.md)
  are unchanged and were not acted on. ⚠ Noted in passing: on 26/11 Sara Aga
  offered to generate test classes with AI on **another** project (`Vision-VapeItalia`)
  and Aurel Mrruku told her not to — _"mos u merr me test klasat aman se do behen prap
  ne fund"_. **Different repository, different client; recorded only because it
  restates the same standing preference, and not acted on here.**
- ⚠ **`Pienissimo_Offerta_Fase_2_V_4.1.pptx` was read this time**, deliberately,
  because it changed in the window and its contents were a standing unknown blocking
  OI-342 and OI-385. **No euro figure, catalogue price or article code was
  transcribed**, and the note says so explicitly.
- **The `Pienissimo_Project_Plan_Fase2` deck was not re-read** — it did not change
  in the window — so the `150` vs `58 - 78` discrepancy is unresolved.
- ⚠ **Elena Spini's change workbook of 13/11 was again not found** — a **ninth**
  window.
- **The client change sheet was not re-read** — no Drive edit in the window, so
  OI-344 stands at 7 `SI` / 4 `IN LAVORAZIONE` / 2 `NON SI FA` / 6 blank.
- **No customer-data workbook or attachment was opened.** None was offered.
- **The 12:02 Slack huddle could not be read** — huddles leave no transcript this
  account can reach, and its duration is not stated.
- **OI-336, OI-343, OI-345, OI-347 to OI-374, OI-379, OI-381, OI-383, OI-384 were
  not updated** — **no new evidence in this window.** ⚠ Most are frozen rather
  than open.
- **The requirement register was not touched** — stays **v1.6**. ⚠ The reports and
  dashboards are production metadata with no requirement; a **migration** is being
  planned with none; and the residual-Fase-1 perimeter now exists as a slide rather
  than as a requirement.
- **VISION / VapeItalia, Life365, Permo / DVM / doydesign, 247.it, Zucchet / 3CX,
  IUAD, VFL1, the Vision Blueprint PDFs and `[ROMI] Slide Team` were excluded** —
  other projects, per the skill.
- **`prettier:verify` was not run** (not executable in this environment, as on
  previous runs).

## Still unreachable

Named precisely enough to ask someone for them:

- 🆕🔴 **Whether the scadenziario and the credit notes are inside the Fase 1
  perimeter or not** — the ruling OI-380 has waited six days for, now urgent
  because a written list exists **without** them (OI-386), **before 30 November
  10:00**.
- 🆕🔴 **Whether the `CRONOPROGRAMMA` slide is the perimeter ROMI will present**,
  and **whether the deck is sent to the client in this state** (OI-386).
- 🆕⚠ **What was agreed in the Slack huddle of 26/11 12:02:47 CET**, if anything,
  and **whether a second pre-call check is booked** before Monday 10:00.
- 🆕⚠ **Who agreed that the note di credito belong in April** — the deck asserts
  _"in accordo con voi"_ and nothing records it, against the client's 20/11 demand.
- 🔴 **What "la nuova migrazione" is** — scope, data, trigger, requester, Fase 1 or
  Fase 2 — **before 30 November 10:00** (OI-385). Absent from the residual list it
  should belong to.
- 🔴 **Who represents the build on 30 November and 1 December** — acknowledged
  unresolved on 26/11, no substitute named, and 1/12 runs **in production**.
- 🔴 **Whether the 30 November perimeter, once agreed, is put to the client in
  writing as the closed scope.**
- 🔴 **Whether the client accepts the 30/11-4/12 calendar** — no reply at all
  (OI-378).
- ⚠ **Who configures the client-side test campaign for 1 December** (OI-378).
- ⚠ **Who "Daniele" is** in Angelo Pastorelli's _"eravamo rimasti cosi con
  Daniele"_ of 25/11, and **what the 24 November voice message said** (OI-380).
- ⚠ **Whether client contact on the clarifications call and the migration is
  authorised**, by name, by Angelo Pastorelli or Gianpaolo Motta (OI-375, OI-385).
- 🔴 **Gianpaolo Motta's ok or refusal on the production release** — never recorded
  at any point (OI-381).
- 🔴 **Who may see the reports and dashboards**, and **whether the client tests
  them now that they are live** — asked 24/11, unanswered (OI-377, OI-381).
- 🔴 **The tranche report schedule**, due before month end — **four days left**
  (OI-377, OI-381).
- ⚠ **Whether anything was deployed to Pienissimo Prod outside source control.**
- 🔴 **The PEC of 17 November itself** — its text, heads of claim and above all
  **the term it fixes under art. 1454 c.c.** — **and ROMI's reply as sent**, with
  receipts. **Confirmed not in this mailbox**, so ask Angelo Pastorelli, Elena
  Spini or Gianpaolo Motta for the PEC mailbox copy. **Sixth day.**
- 🔴 **The detailed rebuttal ROMI reserved**, and the Fase 2 chronology behind it.
- 🔴 **Any record of the 20/11 14:30 meeting**, and of the four private contacts
  with the client's direction (20/11, 23/11, 24/11 voice message, and Angelo
  Pastorelli's _"oggi la sento"_ outcome).
- 🔴 **Whether Anita Aga stays assigned to Pienissimo**, and **whether anyone above
  Aurel Mrruku knows** she is being offered elsewhere (OI-384).
- **Whether the calendar of next activities ROMI promised in its reply was handed
  over.**
- **Rebecca M's surname** (OI-378).
- **Fabrizio Mastracci's scaletta** for the two training modules — a **ninth**
  window — **ROMI's training record**, and **whether the 19/11 test pack was ever
  sent** (OI-378).
- **The WhatsApp number, its block date and Meta's stated reason**, and who at
  Pienissimo is dealing with it — now formally the client's job per the deck
  (OI-382).
- **Whether no Biglietto from migrated data is correct or a defect**, with an owner
  (OI-373).
- ⚠ **What the two Slack audio messages of 20/11 morning say** — still not
  transcribable by this account.
- **The contract clause that makes reports and dashboards a deliverable**, quoted,
  and the contractual training provision behind the 20-hour figure (OI-377,
  OI-378) — **eighth day**.
- **Who may write to the client about anything other than training**, by name
  (OI-375, OI-381, OI-383, OI-385).
- **Whether the order PDF DocuSign configuration exists in production** (OI-373,
  OI-374) — seventh day.
- **Whether any real WooCommerce order has ever been taken end to end in
  production** — seventh day.
- **Whether a production quote PDF now prints an Italian date** (OI-358).
- **Whether the three Mexal schedulers in production run as `amministratore
  pienissimo`** (OI-301, OI-334), and **the written run instructions and the
  job-times mail to Sabatino Rinaldi** — eighth day (OI-370).
- **The restore date for the event end dates**, with an owner (OI-353).
- **Whether ROMI accepts or contests the Blueprint claim** — **no reply in
  twenty-one days** (OI-343) — and `OP-1`, `OP-2`, `OP-4` of the R0 analysis, a
  twenty-third day.
- **Which articles the live WooCommerce shop sells**, set against those deactivated
  on 15/11, and whether the deferred retest passed (OI-366).
- **Leaving dates and successors for Marco Montesi and Sabatino Rinaldi** (OI-357).
- **Fabrizio Mastracci's go-ahead on the Pienissimo Live forms**, and **which field
  they write for the marketing consent** (OI-371, OI-340 — **twelfth window**),
  which the 4 December Modulo 2 session will train on.
- **The id-extraction date and format for Pienissimo Live attendance**, and the
  written specification Elisa Migliano asked for (OI-361); **which event Andrea
  Parmeggiani's QR scanner will be ready for** (OI-323).
- **A list of the Aziende with more than one flagged principal contact** (OI-372).
- **Which cleanup option, A or B, for the 50,000 referenti leads** (OI-351), and
  **a corrected mail to the client** replacing the 11/11 approval (OI-352).
- **Whether `numero tranche` and `tipo biglietto` are now defined per article**
  (OI-329).
- **The contract with the missing third signature** (OI-336).
- **Whether the ticket flow's `Recipient_Contact__r` query was ever fixed** —
  unmentioned for an eleventh window (OI-230).
- **The written production user list by role**, the marketing and Performance Plus
  profiles (OI-356, OI-363).
- **Whether the six tutors completed MFA/passkey enrolment** (OI-300).
- **The exact boundaries of Mexal's nightly maintenance window** (OI-334).
- **The picklist workbook** (OI-265, **thirty-third day**).
- **The Mexal WEBAPI credentials, the event list, the bundle-only article codes
  and the catalogue prices** — all four owed by mail, confirmed absent again.
- **Whether Pienissimo holds a Zoho contract past 31 October** — **twenty-sixth
  run**.
- **The twelve `PLUS_B` values** · **what `lead-web-to-lead (2).html` is** ·
  **whether the standing 30/07 marketing follow-up notes exist at all**.
- **Who created fields and changed a layout in Prod without telling anyone**
  (raised 13/11, never answered).

## Written back

- **1 new item id — [OI-386](../items/OI-386%20The%20residual%20Fase%201%20list%20omits%20the%20scadenziario%20and%20the%20credit%20notes.md).
  Next free is 387.**
- **2 new notes**: OI-386 and
  [the 26/11 meeting note](../meetings/2026-11-26%20Rapido%20Allineamento.md).
- **7 notes updated** (`updated:` bumped to 2026-11-26): **OI-376**, **OI-377**,
  **OI-378**, **OI-380**, **OI-382**, **OI-385** and
  [the Fase 2 offer](../The%20Fase%202%20offer.md). **No status changes** — every
  item stays as it was.
- **MAP.md** — new nightly entry at the top, `Last updated` chain extended.
- **INDEX.md** — 6 item rows amended, 1 item row added (OI-386), 1 meeting row
  added, 1 trace row added. Note count **652 → 655**.
- **`meetings/open-items.md` and `.it.md`** — **6 regenerated rows each** (#376,
  #377, #378, #380, #382, #385) and **1 new row each** (#386), last-touched bumped
  on each.
- **`meetings/DEVELOPMENT-RECAP.md` and `.it.md`** — a new dated update section in
  both.
- **This trace**, and a `JOURNAL.md` entry.
- **Register untouched — v1.6.**
- **No credentials, prices, article codes or personal data were copied.** ⚠ Three
  deliberate omissions: **every euro figure in the Fase 2 deck**, the Google Meet
  join links on the calendar invitations, and the domestic content of the 26/11
  transcript beyond what was needed to establish that it holds no project facts.
