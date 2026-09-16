---
id: trace-2026-09-14-nightly
type: reference
status: active
updated: 2026-09-14
watermark_used: 2026-09-11T22:00Z
external_watermark: 2026-09-14T22:00Z
mail_watermark: 2026-09-11T22:00Z
account: a.mrruku@romicompany.com
---

# Source trace 2026-09-14

**Watermark for the next `requirements-check` run: 2026-09-14T22:00Z — except
Gmail, which stays at 2026-09-11T22:00Z.**

🔴 **The watermark is split on purpose.** Gmail was unreachable this run (expired
OAuth token, non-interactive session, **zero mail queries ran**). Mail was not
searched and returned nothing — those are different things, and carrying the mail
watermark forward would silently skip three days of the one source that has
carried every substantive client event on this project. **Do not collapse the two
values.**

**Watermark used for this run: 2026-09-11T22:00Z**, the `external_watermark` of
[the 11/09 trace](Source%20trace%202026-09-11.md), which is the newest note in
this folder by `updated:`.

⚠ **This run covers three days, not one.** There is no trace note for 12 or 13
September and no `JOURNAL.md` entry for either, so **whether a nightly run fired
on those days and found nothing, or did not fire at all, cannot be established
from the repository.** The window was swept as 11/09 22:00Z → 14/09 22:00Z and
nothing inside it is assumed already held. `git log --all --since='2026-09-11
21:00'` returns four commits and the earliest is `cc3c571` at 21:46:55Z on 11/09
— **eleven minutes before the declared watermark, inside it, and already held**.
No blind spot on the git side.

⚠ **The JOURNAL is three entries behind the traces.** Its newest entry is
**09/09**; traces exist for 10/09 and 11/09 with no matching handoff. This run
writes one.

## Sources searched

All read-only. **Nothing was sent, replied to, drafted, shared, modified or
marked read.** This is the **scheduled nightly run**, so the single Slack
carve-out applied: one report to `C0BQD34LLF4`, the ROMI Salesforce dev group. No
other message was sent anywhere.

| Source      | Query / scope                                                                                                       | Result                                                                                        |
| ----------- | --------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------- |
| **Gmail**   | `pienissimo after:2026/09/11 -in:draft` and all-mail `after:2026/09/11 -in:draft`                                   | 🔴 **NOT SEARCHED** — MCP server returned _"requires re-authorization (token expired)"_ on both |
| **Slack**   | workspace-wide incl. private, DMs and group DMs, keyword `pienissimo`, `after:2026-09-11`                           | 5 results — §1, §2; the rest own automation                                                    |
| **Slack**   | workspace-wide `after:2026-09-11`, **no keyword**, sorted by timestamp, 20 results                                  | 20 live results back to 14/09 17:11 — **0 further Pienissimo items**; Banca Etica, Permo, LIFE365 sibling report, `#gen-chat-cazzeggio`, time-tracking bot |
| **Slack**   | DM `D0AQ0FMHFM1` (Aurel Mrruku ↔ Andrea Di Cicco) read directly, 40 messages                                        | **29 new messages on 14/09, 11:34–17:29 CEST** — §1                                            |
| **Slack**   | DM `D0BKK1D5GF9` (Aurel Mrruku ↔ Anita Aga) read directly, 25 messages                                              | **unchanged since 10/09 14:45:51**                                                             |
| **Slack**   | `#tproj-pienissimo` (`C0B5T3RB4FM`), 10 messages back                                                               | Last post still **04/09 19:48**; still says **go-live 6 October**                              |
| **Slack**   | canvas `F0BD2H5A9HT` (`Link utili Pienissimo`) re-read in full                                                      | **unchanged**; newest entry still **20.08.26**                                                 |
| **Slack**   | `C0BQD34LLF4` dev group, 8 messages back                                                                            | Newest is the **14/09 13:21 org-status-check report** — own automation, already in `dc0c824`   |
| **Drive**   | `modifiedTime > '2026-09-11T22:00:00Z'`, paged                                                                      | 5 items — Permo ×2, Daze ×1, ROMI internal ×2. **0 Pienissimo**                                |
| **Fathom**  | `list_meetings` from 2026-09-11, 3 pages                                                                            | **0 meetings** — nothing to drill                                                              |
| **Git**     | `git fetch origin`, `git log --all --since='2026-09-11 21:00'`, all nine branch heads                               | **4 commits** — §3                                                                             |
| **Git**     | `e06a1b4` read in full: diffstat, name-status, both credential files, the validation rule, `OrderTriggerHandler`, `AccountTriggerHandler`, `AccountTrigger`, the article sync, the four config fields, the decision-note diff, a `MexalHttpClient` reference grep | **the bulk of this run** |
| **GitHub**  | `list_pull_requests` state `all`, 6 newest                                                                          | **PR #43 OPEN**; #42 merged 14/09 07:28Z; #39–#41 merged                                       |
| **Repo**    | `AGENTS.md`, `MAP.md`, `INDEX.md`, the write protocol, the skill, the 11/09 trace, `JOURNAL.md` head, OI-64/102/116/117/125, both org-only risks, the chain build note | read directly |

## Found

### 1. 🟢🔴 The Mexal customer PUT, executed — and there is no PATCH

Slack DM `D0AQ0FMHFM1`, **14/09 11:34–15:19 CEST**, Aurel Mrruku ↔ Andrea Di
Cicco. Full detail in
[OI-125](../items/OI-125%20Mexal%20customer%20update%20needs%20a%20PUT%20method.md).

- 🟢 **_"ho testato direttamente da SF e va todos bien"_ (12:07:44)** — a customer
  update issued **from Salesforce** succeeded. The execution evidence OI-125 has
  asked for since 7 September, though as a direct test rather than through the
  Order chain.
- 🟢 **`PUT /clienti/{codice}` returns `204 No Content`.** _"il put ci da 204 ma no
  body"_ → Andrea Di Cicco: _"vedi gli header"_. Corroborates the built code,
  which reads the Mexal code from the response headers.
- 🔴 **_"Non c'è la patch"_ (15:18:38).** Aurel asked twice. Every update is a
  full-body replace, and **his own objection — _"se hanno dei campi auto complite
  il put crea dei nuovi"_ — is unanswered.**
- 🔴 **Andrea Di Cicco posted a screenshot at 11:58:42** (`image.png`, 41.2 KB),
  apparently of the PUT request in the collection. **Deliberately not opened** —
  the collection it comes from carries a live credential header
  ([the risk](../risks/Risk%20-%20Salesforce%20integration%20credentials%20were%20circulated%20in%20plaintext.md)).
  Existence recorded; nothing copied.

### 2. 🔑🔴 The integration is being built against Mexal production

Same DM, **12:07:03**, Andrea Di Cicco: **_"ricordati che è sempre produzione"_**
— after Aurel Mrruku had already tested, and answered _"si ho creato un mio
cliente"_. New note:
[the risk](../risks/Risk%20-%20the%20Mexal%20integration%20is%20developed%20against%20the%20production%20ERP.md).

**No Mexal test environment appears anywhere in this record.** Every Mexal call
described in these notes targets one named credential, and the nightly scheduler
is one `System.schedule` call away from running against it.

And **_"poi per la creazione di un ordine chi devo avvisare ?"_ (12:08:00) was
never answered** — new
[OI-135](../items/OI-135%20Who%20must%20be%20told%20when%20Salesforce%20starts%20creating%20Mexal%20orders.md).

### 3. 🟢🔴 `e06a1b4` — the org-only chain reaches source control, on an open PR

**`e06a1b4`**, Anita Aga, pushed **18:05:45 CEST** to `DevAnita`; **PR #43** opened
**16:06:38Z**, **open and unmerged** as at this sweep. **40 files, +2,057 / −143.**

Seven hours earlier the same day, the org-status-check had reported this work as
org-only ([the risk](../risks/Risk%20-%20the%20Mexal%20order%20integration%20exists%20only%20in%20the%20org.md)).
**The retrieve it asked for happened the same evening.**

**a. 🟢 Eight of the nine classes, both `Order` fields, and the trigger fix.**
`OrderTriggerHandler.afterInsert` now calls
`OrderMexalIntegrationService.enqueueForCreatedOrders`;
`AnticipayOrderAutomation.cls` is deleted.

**b. 🟢 [OI-117](../items/OI-117%20Administrative%20fields%20lock%20once%20the%20Mexal%20customer%20code%20is%20set.md)'s
lock exists, and the morning reading is superseded.** An **active**
`Lock_Mexal_Synced_Admin_Fields` validation rule covers thirteen administrative
fields once `Codice_Cliente_Mexal__c` is set. The 14/09 org check read the
outbound push as built _instead of_ the lock; **both were built.**

**c. 🟢 The conflict rule exists.** `AccountTriggerHandler.setBypassMexalCustomerUpdate`,
set by `MexalCustomerSearchService` around the inbound sync's DML. The echo loop
between inbound batch and outbound push is closed in code. ⚠ The **substantive**
winner is still undecided — a user edit is still silently overwritten by the
nightly read.

**d. 🔴 The lock and the push do not cover the same fields.** Thirteen locked,
**four** pushed (`Email__c`, `Phone`, `Partita_IVA__c`, `Name`). An admin editing
`Codice_Fiscale__c`, `PEC__c`, `Codice_Destinatario_SDI__c` or the billing address
changes Salesforce and not Mexal. And the principal is `$Profile.Name <> "System
Administrator"` — a literal profile name, **not the amministrazione grouping the
3 September session asked for**.

**e. 🟢 [OI-116](../items/OI-116%20Nightly%20Mexal%20to%20Salesforce%20anagrafica%20sync.md)
gets watermark storage and a twin.** Four new `Integration_Configuration2__c`
fields, and `MexalArticleSyncBatch` + `MexalArticleSyncService`
([the build](../objects/The%20Mexal%20article%20sync%20to%20Product2.md)) sharing
the same cursor service. 🔴 **Nothing is scheduled** — committing a `Schedulable`
does not schedule it.

**f. 🟢 `namedCredentials/` and `externalCredentials/` exist at last.** `Mexal` and
`Anticipay`, with auth headers declared as **merge-field references**, so **no
secret entered the repository** — the shape
[the credentials risk](../risks/Risk%20-%20integration%20credentials%20exist%20only%20in%20the%20org.md)
asked for. 🔴 `DocuSign` still org-only.

**g. 🔴 `MexalHttpClient` is neither committed nor referenced.** The morning check
found it in the org with `MexalCustomerCreateService` repointed onto it; a grep
across the whole commit returns nothing. **What landed is a reconciled version,
not a raw retrieve.** ⚠ Inferred from two records — **the org was not opened
tonight**, and the next `org-status-check` should establish whether an orphaned
`MexalHttpClient` is still live in UAT.

**h. ⚠ A second decision arrived inside a commit.** `e06a1b4` also edits
[the Anticipay-before-Mexal decision note](../decisions/Decision%20-%20first%20order%20runs%20Anticipay%20before%20Mexal%20customer%20creation.md),
recording that **Aurel Mrruku decided on 2026-09-14** that edits to exactly those
four Account fields must trigger the `Modifica` PUT, and that an Anticipay failure
is non-blocking. **No swept source corroborates either**; the attribution is
recorded as given. This is the second time a decision has reached the repository
through a code commit rather than a meeting.

**i. 🔴 Process.** PR #43 was opened **53 seconds** after the push, titled "Dev
anita", **no description, no review** — the third consecutive Mexal PR with no
description. It is at least the first not merged within seven minutes.

**j. 🔴 Coverage.** +2,057 lines on top of the morning's **0 covered / 4,737
uncovered / 0%**, now including two `Batchable` classes with callouts, two
`Queueable` chains and a trigger-driven async path. The new validation rule will
also **fail any existing test that updates a Mexal-linked Account as a non-admin
user**. **Brief only — no test written, proposed or scaffolded.**

### 4. ⚠ A sixth day of silence on the WooCommerce collection

`D0AQ0FMHFM1` carried 29 messages on 14 September and **the WooCommerce
collection was not mentioned once**
([OI-102](../items/OI-102%20Salesforce%20endpoint%20and%20token%20for%20the%20WooCommerce%20plugin.md)).
The 09/09 chase is unanswered for six days, through a window in which the same two
people discussed a different integration at length and spoke by call.

### 5. ⚠ Everything else in the window belongs to another client or another project

- **Slack** — `#tproj-sidea-bancaetica` going live, a Permo mapping DM with Finesa
  Sullenjeri, `#gen-chat-cazzeggio`, `#gen-time-tracking`, and the `[LIFE365]`
  sibling nightly report (Aurel Mrruku's own automation). **Not ingested.**
- **Slack, Aurel Mrruku ↔ Gianpaolo Motta, 17:27–17:48** — a recap of active
  projects naming _"Daze, 247, Permo, teatro, pienissimo, banca etica"_ as
  _"proggetti attivi con lavoro continuo"_. **Confirms this project is active;
  contains nothing about its requirements.** Not ingested.
- **Drive** — 5 items touched: Permo ×2, Daze ×1, and two ROMI-internal
  spreadsheets (`Persone ruoli figure capacity competenze`, `Piano ferie/assenze`).
  **0 Pienissimo.** The `.drawio` and the workbook did not move.
- **Fathom** — no recording since 08/09. **No meeting happened; nothing to drill.**

## What it changed

**Three notes created, eight updated. No requirement changed; the register was not
touched.**

| Written                                                        | Because                                                          |
| ---------------------------------------------------------------- | ------------------------------------------------------------------ |
| `The Mexal article sync to Product2`                           | **new** — the second Mexal batch                                  |
| `Risk - the Mexal integration is developed against the production ERP` | **new** — _"ricordati che è sempre produzione"_            |
| `OI-135 Who must be told when Salesforce starts creating Mexal orders` | **new** — an unanswered question on a built path            |
| `OI-117`                                                       | the lock was built after all, and so was a conflict rule          |
| `OI-116`                                                       | batch, scheduler and watermark storage reach source; still unscheduled |
| `OI-125`                                                       | the PUT executed; 204 no body; **no PATCH exists**                |
| `OI-102`                                                       | sixth day, through a busy DM                                      |
| `OI-64`                                                        | +2,057 lines and a validation rule that will break existing tests |
| `Risk - the Mexal order integration exists only in the org`    | the retrieve happened → `in-progress`                             |
| `Risk - integration credentials exist only in the org`         | two of three credentials in source, secrets left in the org       |
| `Risk - production deploy is blocked by Apex coverage`         | +2,057 uncovered, against a production ERP                        |
| `The order to Mexal integration chain`                         | now in source, on an open PR                                      |
| `MAP.md`, `INDEX.md`                                           | the live position, three new notes, the trace row                 |
| `open-items.md` / `.it.md` rows 64, 102, 116, 117, 125 + **new row 135** | regenerated from the notes, both languages               |
| `DEVELOPMENT-RECAP.md` / `.it.md` §37                          | the build and the DM, both languages                              |

### The register was deliberately not changed

Nothing found this run is a requirement-level change.

- **The chain reaching source control is custody, not scope.** `INT-01` and
  `INT-05` already require what was committed.
- **The 14/09 trigger-field decision narrows an implementation detail**, not a
  requirement. It is also uncorroborated outside the commit that carries it.
- **The production-ERP finding is a risk, not a requirement change** — no
  requirement states which Mexal environment is used, which is itself worth
  noticing but is not a change to the signed text.

**The 11/09 pre-committed trigger fired, and its condition is now half-met.** It
read: _if the `Modifica` caller is uncommented, or the nightly scheduler is
switched on, without OI-117's lock existing — raise it as a requirement-level risk
against `INT-01`._ The `Modifica` caller **is** live. **But the lock now exists**,
so the trigger's premise fails and no register change follows. ⚠ **Re-armed in
sharper form for the next run:** _if the scheduler is switched on, or the nightly
batch runs, while the outbound push still covers only four of the thirteen locked
fields — raise it against `INT-01` in both prose documents in one session, because
nine administrative fields can then diverge silently between the two systems._

**A second trigger, new:** _if any source states that Mexal has a test company or
sandbox — or states that it does not — record it against the production-ERP risk
immediately and, if there is none, put the question to the client before the
scheduler is switched on._

The **10/09 trigger** — Kreosoft on `cod_agente` / `zona` / `classificatore rete`
— **did not fire. Nobody has asked him**, fifth day. It now has a companion in
OI-135; **both are questions for the same person.**

The **09/09 trigger** — the canonical quote-state spelling — **did not fire.**

## Deliberately not done

- **No mail sent, no message replied to, nothing marked read, no Drive file
  modified or shared.** One Slack message to `C0BQD34LLF4` under the nightly
  carve-out.
- 🔴 **Gmail was not searched at all** — see the split watermark above.
- **No Apex test class was written, proposed or scaffolded.** The +2,057 lines are
  recorded as brief in [OI-64](../items/OI-64%20The%20bundle%20Apex%20test%20suite%20is%20broken.md)
  and [the deploy risk](../risks/Risk%20-%20production%20deploy%20is%20blocked%20by%20Apex%20coverage.md).
- **The decision note edited by `e06a1b4` was not touched on `DevMain`.** It is
  modified on `DevAnita` and arrives when PR #43 merges; editing the same file
  here would create a merge conflict on someone else's work. Its content is
  recorded in OI-117 and above instead. **Deliberate.**
- **PR #43 was not reviewed, commented on, approved or merged.** It is not this
  procedure's to touch.
- **No credential, token, price, article code, VAT number, IBAN or personal datum**
  was written into the repository. The Mexal auth-header *shape* and the endpoint
  hostnames are recorded; **no secret value is**. Andrea Di Cicco's 11:58
  screenshot was deliberately not opened.
- **The org was not opened.** Every build claim here is repository arithmetic
  against a commit. `org-status-check` ran this morning, so the org record is
  fourteen hours old rather than six days — but it **predates `e06a1b4`
  entirely**.
- **`MexalArticleSyncService` was read by structure, not line by line** — 534
  lines, summarised from its `Result` fields, its SOQL and its upsert. A close
  reading is owed if the article mapping becomes contested.
- **The `.drawio` was not decoded** — it did not move. The two `[TEST]` email PDFs
  and the funnel screenshots were not opened, **sixth run**. **`Stima Task` still
  unattributed, seventh run.**

## Gaps in this run

- 🔴 **Gmail unreachable.** An expired OAuth token, in a non-interactive session,
  needs a human to reconnect at claude.ai → Settings → Connectors. **Mail is where
  every substantive client event on this project has arrived** — the go-live
  change, the Fase 2 perimeter, the plan deck. Three days of it are unread.
- 🔴 **Nothing is scheduled, and now there are two batches to schedule.** It is one
  `System.schedule` call and one chosen hour, and it has been the whole remaining
  task for OI-116 since 11 September.
- 🔴 **A write integration is being developed against the customer's live billing
  system**, with at least one test customer created in it.
- 🔴 **PR #43 is open with the entire Mexal integration in it, no description and
  no review.** Until it merges, every "org-only" statement in the record still
  holds for `DevMain`.
- 🔴 **UAT opens 23 September — nine days — and no UAT has ever been run.** The
  four blocking decisions put to the client on 08/09 are, as far as this run can
  see, still unanswered; **mail would be where an answer arrived, and mail was not
  readable.**
- 🔴 **40 of 43 ticket-generating products still unmapped** (#121), unchanged. The
  article sync does **not** address it.
- ⚠ **`#tproj-pienissimo` still says go-live 6 October**, ten days after the
  register moved to 21 October, and the canvas is still ten client sessions behind.
- ⚠ **`MAP.md` is far over its own stated 5 KB budget** and **this run added to it
  again.** Raised on 08/09, 09/09, 10/09, 11/09 and here. **Fifth consecutive
  request; no run has been authorised to act on it.**

## Method

**The lesson of 11/09 was _re-read your own most recent record against the code_.
Tonight it applied to a record fourteen hours old.** The morning org-status-check
concluded that OI-117 had been "answered by building the opposite" — a push
instead of a lock. That was true of the org at 10:51Z and false of the project by
18:05. A sweep that had trusted the morning's own report as current state would
have reported the sharpest red finding of the day backwards.

The corollary is narrower and worth keeping: **an org check and a sweep measure
different things, and on this project they can disagree within the same day.** The
org check reads what is running; this procedure reads what has been recorded and
committed. When they diverge, neither is wrong — **the gap between them is the
finding**, and tonight the gap was seven hours wide and closed in the right
direction.
