---
id: trace-2026-09-09-nightly
type: reference
status: active
updated: 2026-09-09
watermark_used: 2026-09-09T10:28Z
external_watermark: 2026-09-09T22:00Z
account: a.mrruku@romicompany.com
---

# Source trace 2026-09-09 nightly

**Watermark for the next `requirements-check` run: 2026-09-09T22:00Z.**

**Watermark used for this run: 2026-09-09T10:28Z** — and that needs explaining,
because it is **not** what the previous trace's frontmatter says.

[The 09/09 interactive trace](Source%20trace%202026-09-09.md) is the newest note in
this folder by `updated:` and declares `external_watermark: 2026-09-09T22:00Z`.
But it was **written and committed at 12:28 CEST (10:28Z)** — commit `2dbcdca`,
_"requirements check 09/09 Aurel"_ — so it claimed an end-of-day watermark it had
not actually swept to. **Roughly eleven hours of 9 September were inside its
declared window and outside its actual coverage**, and two commits landed in them.

This run therefore swept **the whole of 9 September** and deduplicated against
what that trace already records. The declared watermark is honoured going
forward; nothing is double-counted.

⚠ **Method note for the next run: a watermark is only as good as the moment the
sweep actually ran.** Prefer the run time to the declared end-of-day value when
the two differ, or re-sweep the overlap. Writing `22:00Z` at 10:28Z creates a
silent blind spot that only a later run's git check can catch.

The repository was already on `DevMain`; the single-branch `main` clone problem
recurred once at checkout and was resolved by `git fetch origin DevMain`.

## Sources searched

All read-only. **Nothing was sent, replied to, drafted, shared, modified or marked
read.** This is the **scheduled nightly run**, so the single Slack carve-out
applied: one report to `C0BQD34LLF4`, the ROMI Salesforce dev group. No other
message was sent anywhere.

| Source      | Query / scope                                                                                      | Result                                                     |
| ----------- | -------------------------------------------------------------------------------------------------- | ---------------------------------------------------------- |
| **Gmail**   | `pienissimo after:2026/09/09 -in:draft`, 50-thread page                                            | 1 thread, **0 messages new to the record**                 |
| **Gmail**   | all mail `after:2026/09/09 -in:draft`, 50-thread page                                              | 4 threads; **3 carry a 09/09 message, none this project's** |
| **Gmail**   | counterpart domains + Kreosoft, `newer_than:3d` (`from:`/`to:`/`cc:`)                              | 6 threads, **all already held**                            |
| **Slack**   | workspace-wide incl. private, DMs and group DMs, `pienissimo after:2026-09-08`                     | 2 results, **both other projects' nightly reports**        |
| **Slack**   | workspace-wide `after:2026-09-08`, no keyword, sorted by timestamp                                 | 18 messages, **1 about this project**                      |
| **Slack**   | DM `D0AQ0FMHFM1` (Aurel Mrruku ↔ Andrea Di Cicco) read directly, 25 messages                       | **the run's mail/chat finding**                            |
| **Drive**   | `modifiedTime > 2026-09-09T00:00:00Z`, paged                                                       | 5 items, **0 Pienissimo**                                  |
| **Drive**   | `title contains 'Pienissimo' or fullText contains 'Pienissimo'`, 25 newest                         | newest Pienissimo item still **08/09**                     |
| **Fathom**  | `list_meetings` from 08/09, 3 pages                                                                | **0 meetings**                                             |
| **Git**     | `git fetch origin`, `git log --all` since `bfc0c7e`                                                | **4 commits, 2 of them after the 09/09 trace**             |
| **Git**     | `a53345a` read: full diff stat, 6 Apex classes, value set, validation rule, field metadata          | **the run's headline finding**                             |
| **Repo**    | `AGENTS.md`, `MAP.md`, `INDEX.md`, the write protocol, the 09/09 trace, OI-50/59/64/102/121, the register, three risk notes | read directly                    |

## Found

### 1. 🟢🔴 PR #37 — the commercial process automation, merged after the morning sweep

**`a53345a`** (Anita Aga, _"Added automations for opportunity, order and relating
commercial processes to Azienda record type"_), merged to `DevMain` by Aurel
Mrruku at **18:41 CEST** as `0fe07f6`. **30 files, +1,499 / −74 lines, +729 net
Apex.** Full detail:
[the build note](../objects/The%20commercial%20process%20automation.md).

It is the second half of
[the Azienda/Locale split](../decisions/Decision%20-%20Account%20record%20types%20split%20Azienda%20and%20Locale.md)
— and, unannounced in any message, it builds **quote-to-order generation**.

**a. 🟢 An accepted quote generates its order, carrying the tranche.**
`QuoteTriggerHandler.createOrdersForAcceptedQuotes` creates the Order and copies
every quote line to an order line **with `Tranche__c` and `Data_Scadenza__c`**.
That closes the gap [OI-50](../items/OI-50%20Tranche%20object.md) has carried
since 25 August — `OrderItem.Tranche__c` finally has a writer — and supplies the
Mexal tracciato's `data di scadenza`. 🔴 Only quote-born orders get one, and
**payment aggregation is now the only genuinely unbuilt gap of the three**.

**b. 🔴 DocuSign is absent from the entire diff.** The agreed design signs, then
orders. This orders with no envelope, seven days after
[OI-111](../items/OI-111%20DocuSign%20licences%20are%20not%20confirmed%20with%20the%20client.md)
recorded that nobody has confirmed the client owns DocuSign. **Nothing connects
the two. Ask, do not infer.**

**c. 🟢 The Opportunity lifecycle exists and matches the register exactly.** Five
stages, an `opportunityCustomPath` LWC, and two automated transitions.
⚠ **This corrects a first reading taken in this run**: the values were initially
recorded as disagreeing with the design diagram. They match
`state_machines.opportunity.states` **character for character**; it is
[OI-59](../items/OI-59%20Quote%20workflow%20configuration.md)'s own table,
transcribed from the 6 August diagram, that carries the looser spelling. The
register governs, and the build is right. 🔴 **The _Quote_ states are the real
disagreement** — the register has never matched the code, **disagrees with
itself** (`build_state` carries the code spelling), and this commit hard-codes it
in a third class.

**d. 🟢 Azienda/Locale is now built end to end** — `Locale__c` on Opportunity,
Order and Quote; parent normalisation before save; a hierarchy validation rule;
WooCommerce stamping the record type. 🔴 And a **new failure mode on a live
inbound route**: `WoocommerceOrderService` now throws when the `Azienda` record
type is missing, which **production does not have**.

**e. 🔴 The unauthenticated community page now creates commercial records.** The
controller was not touched; what it causes was. An anonymous click on a bare quote
id now inserts an Order and its lines and advances the Opportunity
([the risk](../risks/Risk%20-%20the%20community%20pages%20have%20no%20application-level%20authentication.md)).
**Nothing shows this being considered.**

**f. 🔴 +729 uncovered Apex lines**, estimate past **3,686**, still zero covered,
last test run **still 4 August**. `OrderTriggerHandlerTest` was **not updated**
for the behaviour added to the class it covers. **Brief only — nothing acted on,
no test written or proposed.**

### 2. ⚠ The filtered WooCommerce collection was chased again, and did not come

DM `D0AQ0FMHFM1`, **12:26:28 / 12:26:37 CEST**, Aurel Mrruku to Andrea Di Cicco:

> _"ciao"_ / _"alla fine non mhai passato la collectioon :="_

**No reply**, read at 23:35 CEST — roughly eleven hours. Andrea Di Cicco had
promised the filtered version _"tra le 5 e le 6"_ on 08/09. So Sabatino Rinaldi
still holds the **pre-filter** collection, **the sixty-year JWT is still
unrotated**, and no test result has come back
([OI-102](../items/OI-102%20Salesforce%20endpoint%20and%20token%20for%20the%20WooCommerce%20plugin.md)).

⚠ Not read as evasion: **9–11 September is the ROMI offsite**, which is a
sufficient explanation for a same-day silence.

### 3. ⚠ Everything else in the window belongs to another client or another project

- **Gmail** — a Jira weekly digest (Permo) and a Salesforce certificate-expiry
  alert for a **BIT MOBILITY** sandbox, both already dismissed by the 09/09 trace.
  **Not this project's org. Not ingested.**
- **Slack** — two sibling nightly reports (`[IUAD]` 23:34, `[LIFE365]` 23:14, both
  Aurel Mrruku's own automation), an Albanian-language DM about test-environment
  tables with Finesa Sullenjeri, `#gen-time-tracking`, `#gen-chat-cazzeggio`.
- **Drive** — the five files touched on 09/09 are Permo, Daze and the
  **ROMI WEEK START** meeting folder. ⚠ That folder **corroborates the offsite in
  a third independent place**: `ROMI WEEK START - 2026/09/09 15:57 CEST`, created
  by Aurel Mrruku. **The Pienissimo `.drawio` and the workbook did not move.**
- **Fathom** — no recording since 08/09. **No meeting happened; nothing to drill.**

## What it changed

**One note created, eight updated. No requirement changed; the register was not
touched.**

| Written                                                    | Because                                                       |
| ---------------------------------------------------------- | -------------------------------------------------------------- |
| `The commercial process automation`                        | **new** — the PR #37 build note                                |
| `OI-50`                                                    | the propagation gap of 25 August closes; aggregation is left   |
| `OI-59`                                                    | the Opportunity half is built; the Quote-state disagreement    |
| `OI-102`                                                   | chased again, unanswered, JWT still unrotated                  |
| `OI-121`                                                   | a third source of orders; the throw now also blocks close-won  |
| `OI-64`                                                    | the suite brief grows; `OrderTriggerHandlerTest` left behind   |
| `Decision - Account record types split Azienda and Locale` | the Process Ownership half is built                            |
| `Risk - the community pages have no application-level authentication` | an anonymous click now creates records            |
| `Risk - production deploy is blocked by Apex coverage`     | +729 lines, brief only                                         |
| `The Landing Page community`                               | "no order generation" is no longer true                        |
| `MAP.md`, `INDEX.md`                                       | the live position and the new note                             |
| `open-items.md` / `.it.md` rows 50, 59, 102, 121           | regenerated from the notes, both languages                     |
| `DEVELOPMENT-RECAP.md` / `.it.md` §33                      | the build, both languages                                      |

### The register was deliberately not changed

The Quote-state disagreement found in §1c **is** a requirement-level defect, and
fixing it would touch `state_machines.quote.states`, `REQUIREMENTS.md` and
`REQUISITI.it.md`. It was **not** touched, for two reasons:

1. **Nobody has decided which spelling is canonical.** The register carries one,
   three built classes carry another, and the register's own `build_state` block
   carries the *code* spelling — so the document disagrees with itself and the
   correct direction is a judgement, not a transcription.
2. `REQUISITI.it.md` is **the text the client signs**. Changing a state name in it
   is a contract edit. The 09/09 morning run moved the register only because
   Aurel Mrruku authorised it in session against a pre-committed trigger; there is
   no such authorisation here.

**Pre-committed trigger for the next run**, in the spirit of the 08/09 method
note: *when somebody names the canonical quote-state spelling, change
`state_machines.quote.states`, the `build_state` component string, and every
occurrence in `REQUIREMENTS.md` and `REQUISITI.it.md` in one session — and expect
the three Apex classes (`QuoteAcceptanceController`, `QuoteTrancheController`,
`QuoteTriggerHandler`) to need the same edit if the register's spelling wins.*

## Deliberately not done

- **No mail sent, no message replied to, nothing marked read, no Drive file
  modified or shared.** One Slack message to `C0BQD34LLF4` under the nightly
  carve-out.
- **No Apex test class was written or proposed.** The +729 lines are recorded as
  brief in [OI-64](../items/OI-64%20The%20bundle%20Apex%20test%20suite%20is%20broken.md)
  and [the deploy risk](../risks/Risk%20-%20production%20deploy%20is%20blocked%20by%20Apex%20coverage.md)
  and nothing was acted on.
- **No credential, token, price, article code, VAT number, IBAN or personal datum**
  was written into the repository.
- **The org was not opened.** `STATUS.md`, its Notion mirror and the Flows page are
  owed by `org-status-check` for an **eleventh** run — and are now provably behind
  two merges, not one.
- **`LeadConversionQueueable`'s refactor was not verified line by line.** It is
  recorded as *read as* an extract-to-handler refactor, not asserted to be
  behaviour-preserving.
- **No test was run**, `vault:check` excepted. Whether `OrderTriggerHandlerTest`
  still compiles is unknown and belongs to the suite task.
- **The `.drawio` was not decoded** — it did not move.
- **The two `[TEST]` email PDFs and the funnel screenshots were not opened**, third
  run. **`Stima Task` still unattributed**, fourth run.

## Gaps in this run

- 🔴 **UAT starts in fourteen days and no UAT has ever been run.** One day closer;
  nothing in today's traffic addresses it.
- 🔴 **DocuSign now blocks two things, not one** — the licences are unconfirmed
  **and** the newly built order path skips the envelope entirely.
- 🔴 **The four blocking decisions are still unanswered** and three of four
  addressees are still silent, unchanged from this morning.
- ⚠ **Every build claim here is repository arithmetic.** Nothing was verified
  against the org, and the last org check predates both of the last two merges.
- ⚠ **`MAP.md` is far over its own stated 5 KB budget**, and this run added to it.
  Raised on 08/09, 09/09 and again here.
