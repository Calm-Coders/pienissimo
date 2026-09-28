---
id: trace-2026-09-03-nightly
type: reference
status: active
updated: 2026-09-03
watermark_used: 2026-09-02T22:00Z
external_watermark: 2026-09-03T22:00Z
account: a.mrruku@romicompany.com
---

# Source trace 2026-09-03 nightly

**Watermark for the next `requirements-check` run: 2026-09-03T22:00Z.**

**Watermark used for this run: 2026-09-02T22:00Z** — named in the first line of
[the 02/09 nightly trace](Source%20trace%202026-09-02%20nightly.md), which is
also the newest note in this folder by `updated:`. For the first time in three
runs the frontmatter and the text agree; no disambiguation was needed.

The window covers **3 September**. Unlike the 2 September window, **none of it
was in the record before this sweep started** — no org check ran, no drill
happened during the day, and the day's two largest events (a two-hour client
session and an 82-file merge) were both unrecorded when the sweep began.

## Sources searched

All read-only. **Nothing was sent, replied to, drafted, shared, modified or
marked read**, with the single carve-out of the nightly report to `C0BQD34LLF4`.

| Source     | Query / scope                                                                | Result                                                                                       |
| ---------- | ------------------------------------------------------------------------------ | ---------------------------------------------------------------------------------------------- |
| **Gmail**  | `pienissimo after:2026/09/02 -in:draft`                                      | 13 threads, **4 new** — the Data Model Gemini notes, two Salesforce notices, one invitation |
| **Gmail**  | all mail `after:2026/09/02 -in:draft`, 50 threads, every Pienissimo hit read in full | 48 threads. The rest are LIFE365, TFP, Permo, Daze, 247 and internal                  |
| **Gmail**  | thread `1a066fbea1ef034c` — Data Model Parte 1 notes                          | **read in full** — 19 next steps                                                            |
| **Gmail**  | thread `1a067e4465f95941` — Follow-up Interno reschedule                       | **read in full**, including the organiser's note and the event id                            |
| **Gmail**  | threads `1a066adff60f21b6`, `1a0664ddb24e8d36`, `1a067877eb2b9a12`             | **read in full** — the site welcome, the production My Domain, two publication notices      |
| **Drive**  | `modifiedTime > 2026-09-02T22:00:00Z`, paged                                  | 5 items, **3 Pienissimo** — the workbook, the `.drawio`, the meeting folder                 |
| **Drive**  | `title contains 'Data Model' and modifiedTime > 2026-09-02T22:00Z`            | the 03/09 meeting folder and its Gemini shortcut; **no separate transcript file**            |
| **Drive**  | folder `1eHS-gB6z2QVCrkOBTTbCVKC5pLMcJgV_`                                    | **one shortcut only** — no recording shortcut, unlike the LIFE365 folder the same morning   |
| **Drive**  | Gemini doc `13hcZziWG2KEXVl8cDuWvChn4fYQMpcBUeRfKiuYDXuY`                     | **read in full — summary, Decisioni, 22 detail bullets and the complete 2h08m transcript**  |
| **Drive**  | `Campi Oggetti, Flussi e Utenti Salesforce - Pienissimo.xlsx` (11:11:04Z)     | **read in full** — every sheet                                                              |
| **Slack**  | workspace-wide incl. private channels, DMs and group DMs, `pienissimo after:09-02` | 2 hits, **2 new** — Rexhina Hysi DM, Elena Spini DM                                    |
| **Slack**  | both DM channels read directly from the watermark                             | full history in window                                                                       |
| **Slack**  | `#tproj-pienissimo` read directly                                             | **silent** — newest message is still Elena Spini's 28/08 status post                        |
| **Slack**  | canvas `F0BD2H5A9HT`                                                          | **re-read in full this run**, closing the 02/09 gap — newest entry is still **20.08**       |
| **Fathom** | `list_meetings` from 25/08; `search_meetings` "Pienissimo", `recorded_by: anyone`, from 01/08 | **one meeting exists in the whole window (06/08) and it does not match.** Gap closed |
| **GitHub** | `Calm-Coders/pienissimo` PR #31; `git diff` of the merge against `DevMain`    | 82 files, +4,402 lines, **pure additions** — no vault file was reverted                     |
| **Repo**   | the two new Apex controllers, read directly                                   | entry points, DML and `resolveAccess` inspected                                              |

## Found

### 1. 🟢 Data Model Parte 1 ran, and the customer registry has an owner

Client-facing, 10:59 CEST, **booked for one hour and run to 2h08m**. Everything
of substance is in
[the minute](../meetings/2026-09-03%20Data%20Model%20Parte%201.md). What changed
the record:

- **The anagrafica ownership model**, which was not written down anywhere before:
  Salesforce creates → pushes to Mexal before the order → **Mexal owns it** →
  **nightly batch** returns changes → **Salesforce locks its administrative
  fields** on `Codice Cliente Mexal`. Two unbuilt halves: `OI-116`, `OI-117`.
- **`OI-110` half answered from the opposite direction** — the commission fields
  are inherited from the tutor, freeze on the order, and Mexal reconciles itself.
- **`OI-95` improved sharply** — the legal-rep block struck from the template,
  the mapping to follow the live response.
- **Every Salesforce label and state to be translated into Italian**, agreed and
  unpriced.
- Five further new rows: `OI-112`, `OI-113`, `OI-114`, `OI-115`, `OI-118`.

⚠ **The Gemini document carried the transcript on first reading**, unlike
2 September. The standing move from that run — re-open the same document later —
was unnecessary here, but remains correct as a default.

### 2. 🔴 An entire Experience Cloud community was merged, and it is in no tracker

PR **#31**, Rexhina Hysi → `DevMain`, merged by Aurel Mrruku at **15:02:59Z**,
**82 files, +4,402 lines** — [the build](../objects/The%20Landing%20Page%20community.md).
It builds `OI-68` and `OI-78` on one site, **answers `OI-86` by build while
`OI-86` is still open**, **skips DocuSign** on the quote page, and **has no
application-level authentication** on either page —
[the risk](../risks/Risk%20-%20the%20community%20pages%20have%20no%20application-level%20authentication.md).

**Published to the UAT sandbox at 13:48Z and 14:10Z — before it was merged.**

⚠ **The authentication finding was verified by reading the code, not inferred.**
`resolveAccess` parses two ids, queries two objects and throws only if either is
absent; `submitAction` writes `Quote.Status` after a status check and nothing
else. ⚠ **What the site's guest user can actually reach was not verified** —
that needs the org, and this sweep did not open it.

### 3. 🟢 The shared workbook was rebuilt four minutes after the call

Modified **11:11:04Z**. The `NON UTILIZZATO O OBSOLETO` block is **gone**, the
Account sheet is sectioned into the four groups the meeting defined, and the
renames and additions are already applied. The Preventivo sheet gained
`Tipologia Attività`; an **Asset sheet (`F-14`)** appeared.

🔴 **The four gaps recorded on 2 September are unchanged**: the Ordine field
list, Utenti, Profili and the initial-load plan (`C-1`–`C-6`). `Flussi` still
holds only F-1 and F-2.

⚠ **`LIVELLO_0` through `LIVELLO_6`** sit in the Articoli sheet's `Nuovi Campi`
column — seven fields in no note and in no minuted session.

⚠ **The file still holds live customer records.** Recorded here; nothing copied.

### 4. ⚠ Two calendar facts, both from mail nobody sent to this project

- **Gianpaolo Motta corroborates the 9–11 September offsite in writing**, in a
  mail to an external contact about a different client: _"(da mercoledì a venerdì
  saremo out)"_. The record had it only from Elena Spini's passing remark.
- **Elena Spini is off 14–15 September** and moved the internal follow-up's
  14 September occurrence to **Thu 17 Sept 14:15–15:15 CEST**, lengthening the
  recurring slot to an hour.

### 5. ⚠ The production My Domain is provisioned

`pienissimo.my.salesforce.com` is _"ready to be deployed"_ (Salesforce, 08:06Z)
and has not been deployed. **First movement on the production org in the record.**
Note the distinction: the UAT sandbox is `ability-customization-52152--partial`,
and every org check so far has run against it.

### 6. ⚠ The design diagram moved and was not decoded

`Flows & Objects.drawio`, modified **09:20:01Z** by Elena Spini, ~100 minutes
before the session — probably preparation for it. **The Drive text reader cannot
render `application/vnd.jgraph.mxfile`**; every previous decode in the record was
done by hand from the XML. **What changed is unknown**, and that is a statement
about this run, not about the file.

### 7. 🟢 Fathom is genuinely empty, and the canvas is worse than recorded

The 02/09 trace left both open. Both are now closed as findings:

- **Fathom** searched org-wide from 1 August: the account holds **one meeting in
  the whole window (06/08)** and it does not match this project. The last Fathom
  result on Pienissimo remains 06/08. **Not a gap — an absence.**
- **The canvas was re-read in full** rather than checked for update events. Its
  newest entry is still **20.08**, so it is now **eight client sessions behind**:
  25/08, 26/08, 27/08 ×2, 01/09, 02/09, 03/09.

### 8. ⚠ Mail in the window that is not this project's

LIFE365 (a Data Model session, an Update Interno, and a three-mail sync-architecture
thread from Luca Bacchi), TFP/Tableau (an estimate negotiation), Permo/Zucchetti,
Daze (a WhatsApp routing flow error), 247, a `[Vision] - Appunti` folder share,
and an internal `Sync Romi Aurel` call about Agentforce, G2 and a CMS. **None
ingested.**

⚠ **One near-miss worth naming.** Elena Spini's DM to Aurel Mrruku at 10:08 CEST
links a spreadsheet and then writes _"PIENISSIMO"_ two messages later. **The
spreadsheet is `Campi Oggetti, Flussi e Utenti Salesforce - LIFE365.xlsx`** — the
LIFE365 twin of this project's workbook, same title pattern, different client.
The word "PIENISSIMO" that follows is her switching subject to ask him to join
the Data Model call, not a label on the file. **Do not ingest that link.**

## What it changed

**Ten notes created, eighteen updated.**

| Written                                                | Because                                                              |
| -------------------------------------------------------- | ---------------------------------------------------------------------- |
| `Source trace 2026-09-03 nightly`                      | **new** — this note                                                  |
| `2026-09-03 Data Model Parte 1`                        | **new** — the minute, from the full transcript                       |
| `The Landing Page community`                           | **new** — the build, from the merged code                            |
| `Risk - the community pages have no application-level authentication` | **new** — gating, verified by reading the controllers |
| `OI-112` … `OI-118`                                    | **new** — seven rows from the session                                |
| `OI-24`                                                | the workbook rebuilt; the four gaps unchanged                        |
| `OI-59`                                                | the agreed picklist values reached built code                        |
| `OI-68`, `OI-78`, `OI-86`                              | built, and what the build did and did not settle                     |
| `OI-95`, `OI-108`                                      | the legal-rep block struck; the mapping follows the live response    |
| `OI-99`                                                | Parte 1 ran, and did not reach its agenda                            |
| `OI-109`                                               | the SDI is back, from Mexal                                          |
| `OI-110`                                               | half answered, from the other direction                              |
| `OI-111`                                               | a quote page shipped without DocuSign in it                          |
| `The Mexal integration`                                | the registry leg, agent reconciliation, `codice alternativo`          |
| `The quote to order flow`, `The ticket lifecycle`      | each now has a front door and no downstream                          |
| `The newest design diagram`                            | moved a fifth time, **not decoded**                                  |
| `Risk - production deploy is blocked by Apex coverage` | +844 uncovered lines                                                 |
| `Risk - the whole remaining build lands after Ferragosto` | the offsite in writing, plus 14–15 September                      |
| `Rexhina Hysi`                                         | first delivery, one day after assignment                             |
| `MAP.md`, `INDEX.md`                                   | the live position and the new notes                                  |

Also: rows **112**–**118** plus a sweep blockquote and eleven touched rows in
`open-items.md` **and** `.it.md`; a new **§28** in `DEVELOPMENT-RECAP.md` **and**
`.it.md`.

**No requirement changed.** Three arguably should and were left alone
deliberately, because requirements do not move on a note's authority and
`build_state` is `org-status-check`'s to rewrite from a live org, which this
sweep did not open:

- **`BIG-18`** — the participant landing page now exists, on a Salesforce
  community, with no recorded decision that it should.
- **`SAL-16`** — the quote acceptance page exists and omits the DocuSign step the
  requirement describes.
- **`INT-16`** — its recommendation of a signed token now has a third
  unauthenticated surface to cover, not one.

## Deliberately not done

- **No mail was sent.** The queue for Andrea Parmeggiani is now **four** questions
  (the error bodies, the `dascita` typo, the `env=test` date, and the ATECO
  source) and none has been dispatched.
- **No token, price, VAT number, codice fiscale, IBAN, PEC or personal name from
  a customer record was written into the repository.**
- **No Apex test class was written or proposed.** The +844 uncovered lines are
  recorded against the coverage records and nothing more.
- **The org was not opened.** `STATUS.md`, its Notion mirror and the Flows page
  are owed for a sixth run and remain `org-status-check`'s to produce.
- **The `.drawio` was not decoded** — the reader cannot render the format.
- **Nothing in the merged code was changed.** The authentication finding is
  raised for a human to schedule, not patched.

## Gaps in this run

- 🔴 **What the Landing Page site's guest user can actually reach is unverified.**
  It decides whether the authentication finding is anonymous access or horizontal
  privilege between community members. **It is a finding either way**, but the
  next `org-status-check` should settle which.
- ⚠ **The `.drawio` decode is owed** and should be taken before Parte 2 on
  4 September — the record shows design changes land in that file before they
  reach a minute.
- ⚠ **Andrea Di Cicco's JSON update and test send, owed since 2 September, have
  still appeared on no source.** They now block two rows (`OI-110`, `OI-113`)
  rather than one.

## Method note

**A pull request is a source, and this sweep found more in one than in the
mailbox.** The 3 September merge changed the answer to three open items, created
a gating risk and departed from an agreed design — and it announced itself
nowhere except a bare link in a Slack DM. No mail, no channel post, no PR
description.

**So `git log` on the working branch belongs in the sweep, at the same standing
as Gmail and Drive.** The 02/09 run checked `force-app/` for two named fields; a
general check of what landed since the watermark would have surfaced this in one
command. Standing move from here: **diff `DevMain` against the previous trace's
commit before writing the report.**
