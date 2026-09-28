---
id: trace-2026-09-10-nightly
type: reference
status: active
updated: 2026-09-10
watermark_used: 2026-09-09T22:00Z
external_watermark: 2026-09-10T22:00Z
account: a.mrruku@romicompany.com
---

# Source trace 2026-09-10

**Watermark for the next `requirements-check` run: 2026-09-10T22:00Z.**

**Watermark used for this run: 2026-09-09T22:00Z**, the `external_watermark` of
[the 09/09 nightly trace](Source%20trace%202026-09-09%20nightly.md), which is the
newest note in this folder by `updated:` (tied with the 09/09 interactive trace,
broken by the nightly's later `watermark_used`).

🟢 **The 09/09 method note was honoured and the watermark checks out.** That note
warned that a declared watermark is only as good as the moment the sweep actually
ran, after the interactive trace claimed `22:00Z` at 10:28Z. This time the two
agree: commit `9113453` is timestamped **21:50:20Z**, ten minutes before the
declared `22:00Z`, so **no blind spot** — and `git log --all` confirms no commit
landed in that ten-minute gap. The check was made rather than assumed.

The repository was on `main` in a detached head at session start; `git checkout
DevMain` failed because the clone carried only `main`. Resolved with
`git checkout -B DevMain origin/DevMain`. **This is the third consecutive run to
hit the single-branch clone problem** — 09/09 recorded it too. It is a property of
the session's clone, not of the repository.

## Sources searched

All read-only. **Nothing was sent, replied to, drafted, shared, modified or
marked read.** This is the **scheduled nightly run**, so the single Slack
carve-out applied: one report to `C0BQD34LLF4`, the ROMI Salesforce dev group. No
other message was sent anywhere.

| Source     | Query / scope                                                                                       | Result                                                            |
| ---------- | --------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------- |
| **Gmail**  | `pienissimo after:2026/09/09 -in:draft`, 30-thread page                                             | 1 thread, **0 messages new** — both already held (08/09, 09/09)   |
| **Gmail**  | all mail `after:2026/09/09 -in:draft`, 40-thread page                                               | 12 threads; **none this project's**                               |
| **Slack**  | workspace-wide incl. private, DMs and group DMs, keyword `pienissimo`, `after:2026-09-09`           | 1 result, **a sibling `[LIFE365]` nightly report**                 |
| **Slack**  | workspace-wide `after:2026-09-09`, no keyword, sorted by timestamp                                  | 20 messages, **0 about this project**                             |
| **Slack**  | DM `D0AQ0FMHFM1` (Aurel Mrruku ↔ Andrea Di Cicco) read directly, 30 messages                        | **the chase is still unanswered; he was present** — §3            |
| **Slack**  | DM `D0BKK1D5GF9` (Aurel Mrruku ↔ Anita Aga) read directly, then the file itself                     | **the run's credential finding** — §2                             |
| **Slack**  | `#tproj-pienissimo` (`C0B5T3RB4FM`), 6 messages back                                                | Last post still **04/09 19:48**, already held                     |
| **Slack**  | `C0BQD34LLF4` dev group, 10 messages back                                                           | Newest still the **09/09 23:50 nightly report** — own automation  |
| **Drive**  | `modifiedTime > 2026-09-09T22:00:00Z`, paged                                                        | 5 items — Permo, Daze ×2, ROMI WEEK START ×2. **0 Pienissimo**    |
| **Drive**  | `title contains 'Pienissimo' or fullText contains 'Pienissimo'`, 20 newest                          | newest Pienissimo item still **08/09**                            |
| **Fathom** | `list_meetings` from 2026-09-09, 3 pages                                                            | **0 meetings**                                                    |
| **Git**    | `git fetch origin`, `git log --all --since='2026-09-09 21:00'`, all branch heads                    | **2 commits, both on `DevAnita`**                                 |
| **Git**    | `bc2ed5d` read: full diff, both new Apex classes in full, field, permission set, LWC and quick action | **the run's headline finding** — §1                             |
| **GitHub** | `list_pull_requests` state `all`, 6 newest                                                          | **PR #39 is OPEN**; #38 was a `DevMain → DevAnita` sync           |
| **Repo**   | `AGENTS.md`, `MAP.md`, `INDEX.md`, the write protocol, the 09/09 nightly trace, OI-50/64/102/109/110/116/117/125, the Mexal flow note, the scaffolding note, three risk notes | read directly |

## Found

### 1. 🟢🔴 PR #39 — the first Mexal Apex, open and unmerged

**`bc2ed5d`** (Anita Aga, _"Edited Create Tranch Lwc, and opportunity custom path,
added logic for Mexal Integration"_), pushed **2026-09-10 17:58 CEST**, opened as
**PR #39 `Dev anita`** at 18:00:37 CEST against `DevMain`. **17 files, +682 / −94
lines, +496 new Apex.** Full detail:
[the build note](../objects/The%20first%20Mexal%20integration%20Apex.md).

🔴 **It is not merged.** `DevMain` still ends at `9113453`, last night's own
commit. PR #39 has no review and no description. **Everything recorded from it is
proposed code, and the record says so at every mention.**

**a. 🟢 The first Mexal transport this repository has ever held.**
`MexalSearchCalloutService` is authenticated by **Named Credential**, keeps the
secret out of `Integration_Log__c` on purpose, and is **hard-guarded read-only**
by three independent checks. It cannot write to Mexal by construction. After the
sixty-year JWT, this is the first integration built the way the record has been
asking for.

**b. 🟢🔴 [OI-116](../items/OI-116%20Nightly%20Mexal%20to%20Salesforce%20anagrafica%20sync.md)
gets a read, not a sync.** Fourteen customer fields map onto `Account`, but there
is **no DML anywhere**, and **the nightly job is commented out by design** with
the code naming its own blocker — the sync window unspecified since 3 September.

**c. 🔴 A shipping file now references an org-only credential.**
`Full_Permission` grants `Mexal_External_Credential-Mexal_Principal` and the repo
has **no `namedCredentials/` directory at all**. The org-only pattern has stopped
being an absence and started **breaking deploys**
([the risk](../risks/Risk%20-%20integration%20credentials%20exist%20only%20in%20the%20org.md)).

**d. 🔴 `Integration_Configuration__c` still holds zero rows**, and two are now
needed by exact name. Second OI-121-shaped table in a week.

**e. 🟢 The unpriced Italianisation decision of 3 September is being built** —
first evidence anyone is executing it.

**f. 🔴 +496 uncovered Apex lines**, estimate past **4,182**, last test run still
**4 August**, and the brief now includes an **HTTP callout class** for the first
time. **Brief only — nothing acted on, no test written or proposed.**

**g. ⚠ One probable mapping defect**, flagged not asserted: `IBAN__c` prefers
`banca_appoggio` over the assembled IBAN.

### 2. 🔑🔴 The Mexal WEBAPI credential was pasted into a Slack DM

`Mexal Dev v.2.postman_collection` (32.7 KB), Aurel Mrruku → Anita Aga, DM
`D0BKK1D5GF9`, **14:45:51 CEST**. **All fourteen requests carry the live
Passepartout `Authorization` header**
([the risk](../risks/Risk%20-%20Salesforce%20integration%20credentials%20were%20circulated%20in%20plaintext.md)).
**Third credential in plaintext in seven days.** ⚠ **No value copied.**

The commit in §1 landed **three hours and thirteen minutes later** and implements
the collection's customer-search call.

The collection is also the first readable statement of the Mexal contract, and it
moves five records — the `PIE`/`PE` correction, the `anno` contradiction,
[OI-125](../items/OI-125%20Mexal%20customer%20update%20needs%20a%20PUT%20method.md)'s
PUT, [OI-110](../items/OI-110%20Agent%20and%20network%20fields%20are%20missing%20from%20the%20Mexal%20order%20call.md)'s
negative answer, [OI-50](../items/OI-50%20Tranche%20object.md)'s evasione
mechanism and [OI-109](../items/OI-109%20Codice%20destinatario%20SDI%20as%20a%20twelfth%20Anticipay%20field.md)'s
settled ambiguity. All of it is in
[the flow note](../flows/The%20Mexal%20integration.md#2026-09-10---the-wire-facts-arrive-and-the-first-apex-is-written).

### 3. ⚠ A second day of silence on the WooCommerce collection

DM `D0AQ0FMHFM1`. Aurel Mrruku's 09/09 chase is **still unanswered**, and this
time the offsite does not explain it alone: **Andrea Di Cicco posted in the same
DM at 14:44, 14:45:59, 14:46:34, 14:46:47, 14:46:53, 14:47:09 and 14:47:19 CEST**
on Teatro Franco Parenti and Sapimed — _"sto rispondendo a qualche email"_, _"ora
abbiamo pausa fino alle 3"_. **He was present and did not answer.**
([OI-102](../items/OI-102%20Salesforce%20endpoint%20and%20token%20for%20the%20WooCommerce%20plugin.md).)

⚠ **Read as a dropped ball, not refusal.** But it has now survived a promise
(08/09), a chase (09/09) and a demonstrated presence (10/09).

### 4. ⚠ Everything else in the window belongs to another client

- **Gmail** — Daze sandbox notifications, a `Reception Calendar` site publish and
  Salesforce membership mails for **247/Twentyfourseven** (`java-saas-7462`), the
  `Deployment Status UAT ==> PROD` thread with `@247.it` (Mehak Luthra asking
  whether **15 September** still holds; Aurel Mrruku replying _"approximately 60%
  of the work"_), Permo/Zucchetti, a BIT MOBILITY certificate alert and two
  Winter '27 release notices. **None is this project's org. Not ingested.**
- **Slack** — the sibling `[LIFE365]` nightly report (23:16, Aurel Mrruku's own
  automation), `#gen-time-tracking`, `#1gen-romi-company`, `#team-romi-tech`,
  `#tproj-via-fratelli-lombardi-1`.
- **Drive** — the five files touched belong to Permo, Daze and the **ROMI WEEK
  START** folder. **The Pienissimo `.drawio` and the workbook did not move.**
- **Fathom** — no recording since 08/09. **No meeting happened; nothing to drill.**

## What it changed

**One note created, ten updated. No requirement changed; the register was not
touched.**

| Written                                                            | Because                                                        |
| ------------------------------------------------------------------ | ---------------------------------------------------------------- |
| `The first Mexal integration Apex`                                 | **new** — the PR #39 build note                                 |
| `The Mexal integration` (flow)                                     | the wire facts; the `PE` → `PIE` correction                     |
| `OI-116`                                                           | a read, not a sync; the nightly job commented out by design     |
| `OI-125`                                                           | PUT settled on the wire; still nothing sends it                 |
| `OI-110`                                                           | the wire question answered negatively                           |
| `OI-109`                                                           | the 03/09 ambiguity settled by build, toward Mexal              |
| `OI-50`                                                            | the evasione mechanism; the missing per-line due date           |
| `OI-102`                                                           | second day unanswered, and he was present                       |
| `OI-64`                                                            | two classes on the brief, first callout class                   |
| `The integration scaffolding has never been configured`            | two config rows now needed by exact name                        |
| `Risk - Salesforce integration credentials were circulated in plaintext` | third instance in seven days                              |
| `Risk - integration credentials exist only in the org`             | the pattern now breaks a deploy                                 |
| `Risk - production deploy is blocked by Apex coverage`             | +496 lines, brief only                                          |
| `MAP.md`, `INDEX.md`                                               | the live position and the new note                              |
| `open-items.md` / `.it.md` rows 50, 102, 109, 110, 116, 125        | regenerated from the notes, both languages                      |
| `DEVELOPMENT-RECAP.md` / `.it.md` §34                              | the build and the collection, both languages                    |

### The register was deliberately not changed

Nothing found this run is a requirement-level change. The two candidates were
weighed and both fall short:

1. **The `PIE`/`PE` correction** is a factual correction inside a note, not a
   requirement. `azienda` appears in no requirement id.
2. **[OI-110](../items/OI-110%20Agent%20and%20network%20fields%20are%20missing%20from%20the%20Mexal%20order%20call.md)'s
   negative answer** touches `INT-01`, but it is a **reading of one Postman
   collection**, not a statement from Mexal. Writing "the order header cannot
   carry the agent fields" into `REQUISITI.it.md` — the text the client signs — on
   that evidence would be asserting more than is known.

**Pre-committed trigger for the next run:** *when Mirko Merendi at Kreosoft, or
any Mexal-side source, states whether the `ordini-clienti` create call can carry
`cod_agente`, `zona` and `classificatore rete` — record it against `INT-01` and,
if the answer is no, raise the commission-attribution consequence as a
requirement-level change in both prose documents in one session.*

The 09/09 trigger — *when somebody names the canonical quote-state spelling* —
**did not fire.** No state value changed in `bc2ed5d`, only the labels around
them. It stands unchanged.

## Deliberately not done

- **No mail sent, no message replied to, nothing marked read, no Drive file
  modified or shared.** One Slack message to `C0BQD34LLF4` under the nightly
  carve-out.
- **No Apex test class was written or proposed.** The +496 lines are recorded as
  brief in [OI-64](../items/OI-64%20The%20bundle%20Apex%20test%20suite%20is%20broken.md)
  and [the deploy risk](../risks/Risk%20-%20production%20deploy%20is%20blocked%20by%20Apex%20coverage.md).
- **No credential, token, price, article code, VAT number, IBAN or personal datum**
  was written into the repository. The Postman collection was **read in full** to
  extract the contract; its `Authorization` value, and the synthetic test
  customer's fields, were not transcribed.
- **PR #39 was not reviewed, commented on, approved or merged.** It is not this
  procedure's to touch, and it is somebody else's pull request.
- **The org was not opened.** `STATUS.md`, its Notion mirror and the Flows page
  are owed by `org-status-check` for a **twelfth** run, and are now provably
  behind two merges and one open PR.
- **Whether the `Mexal` named credential or the two `Integration_Configuration__c`
  rows were created in UAT during the day is unknown** — a repository reading
  cannot see it.
- **The `.drawio` was not decoded** — it did not move.
- **The two `[TEST]` email PDFs and the funnel screenshots were not opened**,
  fourth run. **`Stima Task` still unattributed**, fifth run.

## Gaps in this run

- 🔴 **Fase 1 development was due to end today**, per ROMI's own project plan. It
  ends with the Mexal integration on an unreviewed PR, DocuSign unconfirmed, and
  no UAT ever run.
- 🔴 **UAT starts in thirteen days and no UAT has ever been run.** One day closer;
  nothing in today's traffic addresses it.
- 🔴 **The four blocking decisions put to the client on 08/09 are still
  unanswered**, and three of four addressees are still silent. Unchanged for a
  second day.
- 🔴 **DocuSign still blocks two things** — the licences are unconfirmed and the
  order path built on 09/09 skips the envelope. Nothing moved.
- ⚠ **Every build claim here is repository arithmetic on an unmerged branch.**
  Nothing was verified against the org.
- ⚠ **`#tproj-pienissimo`'s status block still says go-live 6 October**, three
  days after the register moved to 21 October, and the canvas is now ten client
  sessions behind.
- ⚠ **`MAP.md` is far over its own stated 5 KB budget**, and this run added to it
  again. Raised on 08/09, 09/09, in the 09/09 nightly, and here.
