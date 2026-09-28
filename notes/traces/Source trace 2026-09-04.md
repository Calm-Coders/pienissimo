---
id: trace-2026-09-04-nightly
type: reference
status: active
updated: 2026-09-04
watermark_used: 2026-09-03T22:00Z
external_watermark: 2026-09-04T22:00Z
account: a.mrruku@romicompany.com
---

# Source trace 2026-09-04

**Watermark for the next `requirements-check` run: 2026-09-04T22:00Z.**

**Watermark used for this run: 2026-09-03T22:00Z** — named in the first line of
[the 03/09 nightly trace](Source%20trace%202026-09-03%20nightly.md), which is also
the newest note in this folder by `updated:`. Frontmatter and text agree for the
second run running; no disambiguation was needed.

The window covers **4 September**.

⚠ **The session started against a repository that did not contain the project.**
The clone was single-branch on `main`, which holds two commits and no vault;
`DevMain` existed on the remote but had not been fetched. `git fetch origin`
followed by `git checkout -B DevMain origin/DevMain` recovered it. Worth knowing
because a future run that finds `AGENTS.md` missing is looking at the wrong
branch, not at an empty repository.

## Sources searched

All read-only. **Nothing was sent, replied to, drafted, shared, modified or
marked read**, with the single carve-out of the nightly report to `C0BQD34LLF4`.

| Source     | Query / scope                                                                        | Result                                                                                       |
| ---------- | ------------------------------------------------------------------------------------ | -------------------------------------------------------------------------------------------- |
| **Gmail**  | `pienissimo after:2026/09/03 -in:draft`                                               | 9 threads, **5 new** — Parte 2 notes, the Parte 4 invitation, the Assertion thread, the Notion request, a security-token notice |
| **Gmail**  | all mail `after:2026/09/03 -in:draft`, 50-thread page, every Pienissimo hit read in full | 31 threads. The rest are Daze, LIFE365, Interstudio Viaggi, 247, TFP and internal        |
| **Gmail**  | thread `1a06cf9cead9fd12` — Data Model Parte 2 Gemini notes                           | **read in full**                                                                             |
| **Gmail**  | thread `1a06ccdecfdcba44` — _"Pienissimo Assertion"_                                  | **read in full**, both messages and the attachment manifest                                  |
| **Gmail**  | thread `1a06cae16641cd03` — the Notion access request                                 | **read in full**                                                                             |
| **Gmail**  | thread `1a06d4b89a8f0a1d` — _"Deployment Status UAT ==> PROD"_                        | **read in full — not this project.** See below                                              |
| **Gmail**  | `from:andrea.p@pienissimo.pro OR from:pienissimo.pro newer_than:5d`                   | **1 thread, newest message 02/09 10:18Z** — the 04/09 mails are absent                      |
| **Gmail**  | `anticipay OR ateco newer_than:4d`                                                    | 3 threads, all previously held. **Confirms the absence above**                              |
| **Gmail**  | `subject:"Data Model" newer_than:3d`                                                  | 9 threads — established that Parte 3 has no cancellation and Parte 4 is new                 |
| **Drive**  | `modifiedTime > 2026-09-03T22:00:00Z`, paged                                          | 5 items, **2 Pienissimo** — the workbook and the Parte 2 folder                             |
| **Drive**  | `title contains 'Data Model' and modifiedTime > watermark`                            | the Parte 2 folder, **with both a Gemini shortcut and a Recording shortcut**                 |
| **Drive**  | folder `1kp6muaWUH_vE-_7xk_LzKECvh0T9G-Ii`                                            | two shortcuts — unlike Parte 1, which had no recording                                       |
| **Drive**  | Gemini doc `1tX8bHeijfhLKgZpdlEdfKHWs9WhiA_dsxqhEshvkHts`                             | **read in full — summary, Decisioni, 13 detail bullets and the complete 1h01m33s transcript** |
| **Drive**  | `Campi Oggetti, Flussi e Utenti Salesforce - Pienissimo.xlsx` (15:03:03Z)              | **read in full** — every sheet                                                              |
| **Slack**  | workspace-wide incl. private channels, DMs and group DMs, `pienissimo after:09-03`    | 5 hits, **4 new**                                                                            |
| **Slack**  | `#tproj-pienissimo` read directly                                                     | **one new post** (Elena Spini, 19:48 CEST) — first since 28/08                              |
| **Slack**  | DM `D0BKK1D5GF9` (Anita Aga) read directly from the watermark                          | one message, carrying the Postman collection                                                 |
| **Slack**  | file `F0BV0K9EH70` — `Pienissimo.postman_collection.json`                              | **read in full**; contents characterised, **no value copied**                               |
| **Slack**  | canvas `F0BD2H5A9HT`                                                                  | re-read in full — newest entry still **20.08**, now **nine** sessions behind                |
| **Fathom** | `list_meetings` from 01/09, 3 pages                                                   | **0 meetings.** Consistent with the 03/09 finding — an absence, not a gap                   |
| **Git**    | `git diff 8057075..HEAD` on `DevMain`                                                  | **40 files, +2,078 / −267** across PRs #32, #33, #34 — where most of this run's findings were |
| **Repo**   | `Mappatura_Edizione__c` metadata, `MappaturaEdizioneTriggerHandler`, `OrderBigliettoTriggerHandler`, the four Anticipay classes, `API_Callout_Engine`, `Account/fields/` | read directly |

## Found

### 1. 🟢 Data Model Parte 2 ran, kept to its hour, and finished the contact registry

Client-facing, 16:04 CEST, **1h01m33s** — the first of these sessions not to
overrun. Everything of substance is in
[the minute](../meetings/2026-09-04%20Data%20Model%20Parte%202.md). What changed
the record: the **hidden shipping mirror**, the **contact role picklist**, the
**contact editable on the quote** with a self-deactivating primary flag, five
Contact fields deleted, `Keap Id Esterno` held pending a check, and
`Azienda Precedente` confirmed as the Mexal `codice alternativo` link.

⚠ **The Gemini document carried the transcript on first reading**, as on 3
September. Two runs in a row; the standing move of re-opening the document later
remains correct as a default but has now been unnecessary twice.

### 2. 🟢 OI-112 is resolved, and the mail that proves it is missing

Anticipay will return **the ATECO code, its description and the codice fiscale**,
in the same call. Established verbally by Elisa Migliano, who asked Andrea
Parmeggiani directly rather than waiting for ROMI's queued mail.

🔴 **Andrea Parmeggiani's two 4 September mails are not in this mailbox.** Elisa
Migliano says he wrote — _"ha mandato adesso due mail praticamente Andrea"_ — and
Aurel Mrruku confirms both seeing it (_"ho visto"_) and working on it 20 minutes
before the call. Searched three ways: by sender, by domain over five days, and by
keyword (`anticipay OR ateco`) over four. **The newest message from
`andrea.p@pienissimo.pro` in this account is still 2 September 10:18Z.**

So the item is resolved **on the meeting record, not on the document**, and the
exact field names and types are in a mail nobody has retrieved. It is a fourth
revision of the API documentation that the record does not hold.

### 3. 🔴 The edition mapping table shipped, and it is empty

PR **#34** (`68c4342`, Anita Aga, merged by Aurel Mrruku 16:06 CEST) builds
`Mappatura_Edizione__c` — [the build note](../objects/The%20Mappatura%20Edizione%20object.md).
`OI-96` is implemented faithfully and improved on in two ways nobody specified.

🔴 `assignCampaigns` **throws** on no match, and it runs when an Order moves to
`Incassato`. The table is hand-maintained, has no rows, and has no named owner
([OI-121](../items/OI-121%20The%20edition%20mapping%20table%20has%20no%20rows%20and%20no%20owner.md)).

⚠ **The narrow reading was checked and matters.** The first reading of
`afterInsert` suggested every inbound WooCommerce order would throw. It does not:
ticket generation is gated on `Status == 'Incassato'`, so order **creation** is
unaffected and the **status transition** is what blocks. Recorded because the
wrong version of this finding would have been alarming and false.

### 4. ✅ Two records were wrong, and a `git diff` found them

Both fixed **2 September** in commit `9b38d1a`, both already in `DevMain` at the
03/09 trace's own commit `8057075`, both carried forward unchecked by two sweeps:

- **OI-107's three code defects are all fixed** — verified by reading
  `API_Callout_Engine` at `HEAD` **and** at `8057075`, to establish that the fix
  predates this window rather than landing in it.
- **The Anticipay field-build risk is resolved** — `Account/fields/` holds ten
  files; `git ls-tree` at `8057075` shows the same ten, so these are **not** new
  in this window either.

⚠ **Neither is a "new since the watermark" finding.** They are stale-record
corrections, and the report should not present them as movement.

### 5. 🔴 The WooCommerce endpoint exists, and two credentials are loose

The Postman collection carries a JWT-bearer assertion with an expiry ~60 years
out and a live UAT access token, circulated by mail and Slack —
[the risk](../risks/Risk%20-%20Salesforce%20integration%20credentials%20were%20circulated%20in%20plaintext.md).
**Nothing was copied into the repository.**

🟢 The authentication design is **better** than the record feared — platform
OAuth, not a static shared secret. ⚠ **`INT-16` was deliberately not closed**:
the class-level check was not re-verified, and a Postman file is not evidence
about what the endpoint enforces.

⚠ **The collection's test payload matches the recorded contract exactly** — same
14 top-level keys, 15-character `sf_opportunity_id`. **No contract change.**

### 6. ⚠ The channel post is a template, and reading it as news would be wrong

`#tproj-pienissimo` broke a week's silence at 19:48 CEST. Its **Red flags** block
is **byte-identical to the posts of 28/08, 07/08, 31/07, 24/07, 17/07 and
10/07** — the phase-2 scope dispute, Sabatino Rinaldi's _"tutto ok a Daniela"_,
GLS/Teachable/Zoho. Its **Next step** line still reads _"02/09 meeting Follow-up
Anagrafica Articoli"_, a meeting that has already happened.

**Only the Status attività line is new**: the data-model sessions are the current
activity, and **Sabatino Rinaldi has stopped answering his phone** because the
client is busy with an event — which corroborates, from a second source, what
Elena Spini and Elisa Migliano said in the session.

🔴 **A first reading of this post as new movement on the phase-2 dispute was
wrong and was caught by diffing it against the channel history.** Recorded as a
standing hazard: **this status post is a recycled template, and its red-flag
block must be diffed before it is mined.**

### 7. ⚠ Two calendar facts that disagree with each other

`Parte 4` was booked (Tue 8 Sept 12:00–13:00, no Andrea Di Cicco, no Sabatino
Rinaldi cc) while `Parte 3` remains on Mon 7 Sept 11:00 with both. No
cancellation on any source ([OI-99](../items/OI-99%20Customer%20registry%20deep%20mapping%20session.md)).

### 8. ⚠ Mail in the window that is not this project's

- **`Deployment Status UAT ==> PROD`** (Aurel Mrruku, 16:49Z) — **read in full
  precisely because the subject is a near-miss**: the Pienissimo production My
  Domain was provisioned the day before. It is **247**: recipients
  `@247.it`, 77 custom objects, ~24,800 custom fields, Incoterms/Season/World
  Region reference data, and a "Sandro". Pienissimo UAT holds 1,072 components.
  **Not ingested.**
- Daze SAL of 4/09 and two cancelled Daze events; a `Campi chiave sf per oggetto`
  spreadsheet shared by Daniele Macchia (Daze); LIFE365 sync-architecture thread;
  Interstudio Viaggi; a Salesforce sandbox security-token reset at 08:32Z, which
  names no org and is **not attributed**; marketing spam. **None ingested.**

## What it changed

**Eight notes created, twelve updated.**

| Written                                                     | Because                                                       |
| ------------------------------------------------------------- | --------------------------------------------------------------- |
| `Source trace 2026-09-04`                                   | **new** — this note                                           |
| `2026-09-04 Data Model Parte 2`                             | **new** — the minute, from the full transcript                |
| `The Mappatura Edizione object`                             | **new** — the build, from the metadata and Apex                |
| `Risk - Salesforce integration credentials were circulated in plaintext` | **new** — gating                                  |
| `OI-119` … `OI-122`                                         | **new** — four rows                                            |
| `OI-107`                                                    | **resolved in code**, and stale for two sweeps                |
| `Risk - the Anticipay field build has not started`          | **resolved**, and stale from the day it was written           |
| `OI-112`                                                    | **resolved** — ATECO, its description and codice fiscale      |
| `OI-96`                                                     | built, and faithfully                                          |
| `OI-102`                                                    | endpoint and auth exist; the client has neither                |
| `OI-111`                                                    | reconfirmed verbally, a named contact, nothing written        |
| `OI-99`                                                     | Parte 2 ran; Parte 4 added while Parte 3 stands                |
| `OI-24`                                                     | the workbook rebuilt again; the four gaps unchanged           |
| `OI-110`                                                    | now a stated client requirement on the Ordine sheet            |
| `OI-113`                                                    | a workaround adopted before the answer                        |
| `The campaign parent and child model`                       | the record types exist at last                                 |
| `Risk - production deploy is blocked by Apex coverage`      | ~+600 more uncovered lines                                     |
| `MAP.md`, `INDEX.md`                                        | the live position and the new notes                            |

Also: rows **119**–**122** plus a sweep blockquote and nine touched rows in
`open-items.md` **and** `.it.md`; a new **§29** in `DEVELOPMENT-RECAP.md` **and**
`.it.md`.

**No requirement changed.** Two arguably could and were left alone deliberately,
because requirements do not move on a note's authority and `build_state` is
`org-status-check`'s to rewrite from a live org, which this sweep did not open:

- **`INT-18`** — the documented Anticipay response gains at least three fields.
  The change is real but rests on a mail this sweep could not retrieve.
- **`INT-16`** — its recommendation of a signed token is partly answered by an
  OAuth flow, but what the endpoint class actually enforces was not re-verified.

## Deliberately not done

- **No mail was sent.** The queue for Andrea Parmeggiani is now **three**
  questions, not four — the ATECO one answered itself — and none has been
  dispatched.
- **No token, assertion, price, VAT number, codice fiscale, IBAN, PEC or personal
  name from a customer record was written into the repository.**
- **No Apex test class was written or proposed.** The ~600 new uncovered lines
  are recorded against the coverage records and nothing more.
- **The org was not opened.** `STATUS.md`, its Notion mirror and the Flows page
  are owed for a seventh run and remain `org-status-check`'s to produce.
- **The `.drawio` was not decoded** — it did not move in this window (still
  03/09 09:20:01Z), and the reader still cannot render the format.
- **Nothing in the merged code was changed**, and the Notion access request was
  not answered.

## Gaps in this run

- 🔴 **Andrea Parmeggiani's two 04/09 mails are unreachable** and carry the
  authoritative ATECO field list. **Ask Aurel Mrruku which mailbox has them.**
- ⚠ **Path-parameter support in `API_Callout_Engine` was not verified.**
  `AnticipayAccountService` grew by 80 lines and the engine now takes a
  `pathParams` argument, so it has probably been addressed — but it was not read
  closely enough to assert, and the record still lists it as missing.
- ⚠ **Nothing was verified against the org.** Every build claim in this run is
  the repository. The next `org-status-check` should confirm the Anticipay
  fields, `Mappatura_Edizione__c`, the Campaign record types, and what the
  WooCommerce route actually enforces.
- ⚠ **The Parte 2 recording was not opened.** The transcript was complete, so it
  was not needed — but a recording shortcut existed for this session where Parte
  1 had none, and nobody has checked whether the earlier sessions' recordings
  appeared late too.

## Method notes

**An org check is a photograph of a moving branch.** Two records in this run were
wrong because a 2 September org check ran hours before a 2 September commit, and
two subsequent sweeps trusted the photograph. The 3 September run concluded that
a pull request is a source; the other half of that lesson is that **a `git diff`
against the previous trace's commit must run before any build claim is
reported**, not only to find new work. It cost one command and corrected two
gating records.

**A recurring status post is not a source of news until it is diffed.** The
`#tproj-pienissimo` template carries its red-flag block forward verbatim for two
months. Read cold, it looks like a fresh escalation of the phase-2 dispute.
**Diff it against the previous post before extracting anything from it.**
