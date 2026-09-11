---
id: trace-2026-09-11-nightly
type: reference
status: active
updated: 2026-09-11
watermark_used: 2026-09-10T22:00Z
external_watermark: 2026-09-11T22:00Z
account: a.mrruku@romicompany.com
---

# Source trace 2026-09-11

**Watermark for the next `requirements-check` run: 2026-09-11T22:00Z.**

**Watermark used for this run: 2026-09-10T22:00Z**, the `external_watermark` of
[the 10/09 trace](Source%20trace%202026-09-10.md), which is the newest note in
this folder by `updated:`.

🟢 **The watermark checks out.** Last night's commit `f7af67a` is timestamped
**21:48:48Z**, eleven minutes before the declared `22:00Z`, and
`git log --all --since='2026-09-10 21:00'` shows nothing in the gap. **No blind
spot.** Checked, not assumed — third consecutive run to make this check rather
than inherit the claim.

⚠ **The single-branch clone problem did not recur this run in the form the last
three traces describe**, but a variant did: the clone opened in a **detached HEAD
on `main`** carrying only `main`, and `git fetch origin` brought the other eight
branches down. `git checkout DevMain` then worked normally. **Fourth consecutive
run to spend a step on the session's clone.**

## Sources searched

All read-only. **Nothing was sent, replied to, drafted, shared, modified or
marked read.** This is the **scheduled nightly run**, so the single Slack
carve-out applied: one report to `C0BQD34LLF4`, the ROMI Salesforce dev group. No
other message was sent anywhere.

| Source     | Query / scope                                                                                     | Result                                                             |
| ---------- | --------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------- |
| **Gmail**  | `pienissimo after:2026/09/10 -in:draft`, 30-thread page                                           | **`{}` — zero threads**                                             |
| **Gmail**  | all mail `after:2026/09/10 -in:draft`, 40-thread page                                             | 11 threads; **none this project's** — §4                            |
| **Slack**  | workspace-wide incl. private, DMs and group DMs, keyword `pienissimo`, `after:2026-09-10`         | 2 results, **both other clients** — a `[LIFE365]` sibling report and a Banca Etica DM |
| **Slack**  | workspace-wide `after:2026-09-10`, no keyword, sorted by timestamp, 20 results                    | **0 about this project** — Permo, Banca Etica, time-tracking bot     |
| **Slack**  | DM `D0BKK1D5GF9` (Aurel Mrruku ↔ Anita Aga) read directly, 30 messages                            | **unchanged since 10/09 14:45:51**                                  |
| **Slack**  | DM `D0AQ0FMHFM1` (Aurel Mrruku ↔ Andrea Di Cicco) read directly, 25 messages                      | **unchanged since 10/09 14:47:19** — §3                             |
| **Slack**  | `#tproj-pienissimo` (`C0B5T3RB4FM`), 6 messages back                                              | Last post still **04/09 19:48**; still says **go-live 6 October**    |
| **Slack**  | canvas `F0BD2H5A9HT` (`Link utili Pienissimo`) re-read in full                                    | **unchanged**; newest entry still **20.08.26**                      |
| **Slack**  | `C0BQD34LLF4` dev group, 8 messages back                                                          | Newest still the **10/09 23:49 nightly report** — own automation     |
| **Drive**  | `modifiedTime > 2026-09-10T22:00:00Z`, paged                                                      | 3 items — Permo ×1, Daze ×2. **0 Pienissimo**                       |
| **Drive**  | `title contains 'Pienissimo' or fullText contains 'Pienissimo'`, 15 newest                        | newest Pienissimo item still **08/09**                              |
| **Fathom** | `list_meetings` from 2026-09-10, 3 pages                                                          | **0 meetings**                                                      |
| **Git**    | `git fetch origin`, `git log --all --since='2026-09-10 21:00'`, all nine branch heads             | **4 commits** — §1, §2                                              |
| **Git**    | `b9cfc1b` and `80420cf` read: full diffstat, name-status, all four Mexal Apex classes, the permission set, the object metadata, the new decision note | **the whole of this run** |
| **GitHub** | `list_pull_requests` state `all`, 6 newest                                                        | **#39, #40 and #41 all merged; nothing open**                       |
| **Repo**   | `AGENTS.md`, `MAP.md`, `INDEX.md`, the write protocol, the 10/09 trace, the skill, OI-64/102/116/117/125, the first-Mexal-Apex note, the scaffolding note, two risk notes | read directly |

## Found

**Every external source was empty. The entire run came from `git` and GitHub.**
That is the mirror image of a normal sweep and the second consecutive day it has
happened — see **Method**.

### 1. ✅ PR #39 merged, and two of its findings were superseded nine hours later

**`b9cfc1b`, merged 2026-09-11 08:27Z (10:27 CEST).** Yesterday's Mexal read Apex
is now on `DevMain`. Two claims recorded against it last night no longer hold, and
[the build note](../objects/The%20first%20Mexal%20integration%20Apex.md) now opens
with that correction:

- _"cannot create or modify a Mexal record, by construction"_ — **superseded**;
- _"no DML … OI-116 is a read, not yet a sync"_ — **superseded**.

⚠ **Neither was wrong when written.** They described `bc2ed5d` accurately; the code
moved. The lesson is the standing one about photographs of moving branches, this
time applied to a record only twenty-four hours old.

### 2. 🟢🔴 PR #41 — the Mexal integration starts writing

**`80420cf`** (Anita Aga, _"Added logic for API calls (Ricerca,Creazione,Modifica)
rebuilt the Integration Configuration object."_), pushed **17:57 CEST**, PR opened
**17:58**, **merged 18:05** — **seven minutes, no description, no review**.
**32 files, +1,326 / −193.** Full detail:
[the build note](../objects/The%20Mexal%20customer%20create%20and%20update%20path.md).

**a. 🟢 The read-only guard was extended, not removed.** Two allow-lists now:
`READ_ONLY_ACTIONS` unchanged, plus `WRITE_ACTIONS` holding exactly
`Mexal_Clienti_Creazione` and `Mexal_Clienti_Modifica` behind separate
validation. The write surface is closed and named. Named Credential auth
unchanged; the secret still never reaches the log.

**b. 🟢 The create path works the right way round.** `codice = '501.AUTO'` so Mexal
assigns the number; the generated code is recovered from response headers or body
and **written back to `Account.Codice_Cliente_Mexal__c`**. The duplicate
`partita IVA` error is **parsed**, returning the colliding customer's code.

**c. 🟢🔴 [OI-116](../items/OI-116%20Nightly%20Mexal%20to%20Salesforce%20anagrafica%20sync.md)
gains DML and keeps its blocker.** Partial-success `insert`/`update`, `Azienda`
record type, ambiguous matches skipped. **The nightly job is still commented out
with the identical wording.** The row moves from _a read, not a sync_ to **a sync
with no schedule**.

**d. 🔴 [OI-125](../items/OI-125%20Mexal%20customer%20update%20needs%20a%20PUT%20method.md)
is built and uncalled.** `PUT /clienti/{codice}` exists; an already-linked Account
throws, and the caller sits above it as a block comment.

**e. 🔴 [OI-117](../items/OI-117%20Administrative%20fields%20lock%20once%20the%20Mexal%20customer%20code%20is%20set.md)
is the day's real exposure.** Two writers now set the Mexal code; **the lock is
still unbuilt.** The divergence that row has warned of since 3 September is now
reachable in running code.

**f. 🔴 `Integration_Configuration__c` → `Integration_Configuration2__c`**,
Hierarchy → List custom setting, `SetupOwnerId` resolution deleted. The rename is
very likely forced by Salesforce; **the `2` suffix is permanent**. Still zero
rows; **four now needed by exact name**. The fate of the original object in the
org is unrecorded.

**g. 🔴 The undeployable credential reference reached `DevMain`.**
`Full_Permission` still grants `Mexal_External_Credential-Mexal_Principal` with
**no `namedCredentials/` directory in the repository at all**. Yesterday on a
branch; **today on the mainline**
([the risk](../risks/Risk%20-%20integration%20credentials%20exist%20only%20in%20the%20org.md)).

**h. ⚠ A decision arrived outside the sweep**, committed straight into the repo by
`80420cf`:
[Anticipay before Mexal customer creation](../decisions/Decision%20-%20first%20order%20runs%20Anticipay%20before%20Mexal%20customer%20creation.md),
`source: Aurel Mrruku, direct instruction to the agent session, 2026-09-11`. **No
swept source corroborates it**, and none is expected to. 🔴 **The shipped code does
not follow it** — a synchronous Account button, no Anticipay step, no queueing, no
Order trigger. Recorded as a gap, not a contradiction: the note says itself that
it does not activate the flow.

**i. 🔴 Coverage.** **30 Apex classes, 8,193 lines**, measured. Last test run still
**4 August**. The brief now includes a class that **creates records in an external
ERP**. ⚠ The 8,193 figure is a whole-repository count on a **different basis** from
the running "+N uncovered lines" estimate, and is recorded as measured rather than
reconciled with it. **Brief only — nothing acted on, no test written or proposed.**

### 3. ⚠ A third day of silence on the WooCommerce collection

DM `D0AQ0FMHFM1` has **not moved since 10/09 14:47:19 CEST**. Aurel Mrruku's 09/09
chase is unanswered for a third day
([OI-102](../items/OI-102%20Salesforce%20endpoint%20and%20token%20for%20the%20WooCommerce%20plugin.md)).

### ✅ A correction to the 10/09 trace

That trace read Andrea Di Cicco's **14:44** message in this DM as part of the
Teatro Franco Parenti / Sapimed exchange around it. It is not: **the 14:44:05
message is the file `Mexal Dev v.2.postman_collection` itself.** So the collection
that produced the entire Mexal build **originated with Andrea Di Cicco**, who sent
it to Aurel Mrruku; Aurel Mrruku forwarded it to Anita Aga at **14:45:51**. The
10/09 trace and the build note both name Aurel Mrruku as its source.

⚠ **It does not soften OI-102.** He delivered the **Mexal** collection that day and
still has not delivered the **WooCommerce** one — which sharpens rather than
excuses the silence.

### 4. ⚠ Everything else in the window belongs to another client

- **Gmail** — a Daze `Pricebook test` sheet shared by Stefano Merlini, a Zucchetti
  access exchange with Roberto Catto (Permo), two Salesforce login-experience
  notices, Daze sandbox mails, a BIT MOBILITY certificate alert, and the
  `Deployment Status UAT ==> PROD` thread with `@247.it`. **None is this project's
  org. Not ingested.**
- **Slack** — the `[LIFE365]` and `[IUAD]` sibling nightly reports (Aurel Mrruku's
  own automations), a Banca Etica/Sidea DM with Rexhina Hysi and Gianpaolo Motta,
  a Permo DM with Finesa Sullenjeri, `#gen-time-tracking`.
- **Drive** — three files touched, all Permo and Daze. **The Pienissimo `.drawio`
  and the workbook did not move.**
- **Fathom** — no recording since 08/09. **No meeting happened; nothing to drill.**

## What it changed

**One note created, ten updated. No requirement changed; the register was not
touched.**

| Written                                                          | Because                                                       |
| ------------------------------------------------------------------ | --------------------------------------------------------------- |
| `The Mexal customer create and update path`                      | **new** — the PR #41 build note                                |
| `The first Mexal integration Apex`                               | merged; two of its claims superseded the same day              |
| `The Mexal integration` (flow)                                   | the integration becomes bidirectional                          |
| `OI-116`                                                         | DML arrived, schedule did not                                  |
| `OI-117`                                                         | two writers now set the Mexal code; the lock is still unbuilt  |
| `OI-125`                                                         | the PUT is built and has no caller                             |
| `OI-102`                                                         | third day; and the 10/09 attribution corrected                 |
| `OI-64`                                                          | the brief gains an ERP-writing class                           |
| `The integration scaffolding has never been configured`          | the rename and retype; four rows now needed                    |
| `Risk - integration credentials exist only in the org`           | the defect reached `DevMain`                                   |
| `Risk - production deploy is blocked by Apex coverage`           | two merges; 30 classes, 8,193 lines                            |
| `Decision - first order runs Anticipay before Mexal...`          | build state recorded against it (it arrived outside the sweep) |
| `MAP.md`, `INDEX.md`                                             | the live position, the new note, four missing trace rows       |
| `open-items.md` / `.it.md` rows 64, 102, 116, 117, 125           | regenerated from the notes, both languages                     |
| `DEVELOPMENT-RECAP.md` / `.it.md` §35                            | the build, both languages                                      |

### The register was deliberately not changed

Nothing found this run is a requirement-level change. The strongest candidate was
weighed and falls short:

**The Mexal write path touches `INT-01`**, but `INT-01` already specifies the
Salesforce → Mexal customer creation agreed on 3 September. **Building the thing a
requirement already requires is not a change to the requirement.** What is new is
implementation state, and `build_state` is refreshed by `org-status-check` against
the org, not by this procedure against a diff.

**Pre-committed trigger for the next run:** *if the `Modifica` caller is
uncommented, or the nightly scheduler is switched on, without
[OI-117](../items/OI-117%20Administrative%20fields%20lock%20once%20the%20Mexal%20customer%20code%20is%20set.md)'s
lock existing — raise it as a requirement-level risk against `INT-01` in both
prose documents in one session, because at that point the registry can silently
lose a user edit in production.*

The 10/09 trigger — *when Mirko Merendi at Kreosoft, or any Mexal-side source,
states whether the `ordini-clienti` create call can carry `cod_agente`, `zona` and
`classificatore rete`* — **did not fire.** Nobody has asked him. It stands
unchanged, for a second day.

The 09/09 trigger — *when somebody names the canonical quote-state spelling* —
**did not fire.** No state value changed in `80420cf`.

## Deliberately not done

- **No mail sent, no message replied to, nothing marked read, no Drive file
  modified or shared.** One Slack message to `C0BQD34LLF4` under the nightly
  carve-out.
- **No Apex test class was written or proposed.** The new classes are recorded as
  brief in [OI-64](../items/OI-64%20The%20bundle%20Apex%20test%20suite%20is%20broken.md)
  and [the deploy risk](../risks/Risk%20-%20production%20deploy%20is%20blocked%20by%20Apex%20coverage.md).
- **No credential, token, price, article code, VAT number, IBAN or personal datum**
  was written into the repository. The Mexal payload field *names* are recorded;
  no value is.
- **PR #41 was not reviewed, commented on or reopened.** It was merged before this
  run began, and it is not this procedure's to touch.
- **The decision note committed by `80420cf` was not rewritten** — only appended
  to, with the build state as measured. Its `source:` attribution is recorded as
  given, not independently verified.
- **The org was not opened.** `STATUS.md`, its Notion mirror and the Flows page are
  owed by `org-status-check` for a **thirteenth** run, and are now provably behind
  four merges.
- **Whether the `Mexal` named credential, the `Integration_Configuration2__c` rows,
  or the fate of the old configuration object exist in UAT is unknown** — a
  repository reading cannot see any of it.
- **The `.drawio` was not decoded** — it did not move.
- **The two `[TEST]` email PDFs and the funnel screenshots were not opened**, fifth
  run. **`Stima Task` still unattributed**, sixth run.

## Gaps in this run

- 🔴 **A write integration to the billing system merged seven minutes after it was
  opened, with no description and no review.** The code is good; the process
  around it is not, and this is the second consecutive Mexal PR to carry no
  description.
- 🔴 **The credential defect is now on `DevMain`** and blocks a clean deploy.
  **Twelve days to UAT.**
- 🔴 **OI-117's lock is unbuilt while two writers now set its trigger field.**
- 🔴 **UAT starts in twelve days and no UAT has ever been run.** Nothing in today's
  traffic addresses it.
- 🔴 **The four blocking decisions put to the client on 08/09 are still
  unanswered**, third day. **DocuSign still blocks the quote flow.**
- 🔴 **`anno` is still wrong in two directions** — collection `2025`, code current
  year — second day, nobody has chosen.
- ⚠ **Every build claim here is repository arithmetic.** Nothing was verified
  against the org, and the last org check (08/09 16:31Z) now predates four merges.
- ⚠ **`#tproj-pienissimo` still says go-live 6 October**, four days after the
  register moved to 21 October, and the canvas is still ten client sessions behind.
- ⚠ **`MAP.md` is far over its own stated 5 KB budget** — it is now roughly 44k
  tokens, nine times what `INDEX.md` advertises for it — **and this run added to it
  again.** Raised on 08/09, 09/09, 10/09 and here. **This is the fourth
  consecutive request and no run has been authorised to act on it.**

## Method

**Two consecutive days where every external source was empty and the whole finding
came from `git`.** Last night's lesson was _when nothing is in the mail, read the
DMs and the branch heads_. Today the DMs were empty too, and only `git log --all`
and two diffs carried the run.

The sharper lesson is the second one: **re-read your own most recent record against
the code, not only the sources.** Two findings written twenty-four hours ago —
_"cannot write by construction"_ and _"no DML anywhere"_ — were both false by the
time this run started, and neither Gmail, Slack, Drive nor Fathom would ever have
said so. A sweep that trusts yesterday's note as current state, on a project where
merges land at 18:05, reports the opposite of the truth.
