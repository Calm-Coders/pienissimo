---
id: trace-2026-09-15-nightly
type: reference
status: active
updated: 2026-09-15
watermark_used: 2026-09-14T22:00Z
external_watermark: 2026-09-15T22:00Z
mail_watermark: 2026-09-11T22:00Z
account: a.mrruku@romicompany.com
---

# Source trace 2026-09-15

**Watermark for the next `requirements-check` run: 2026-09-15T22:00Z — except
Gmail, which stays at 2026-09-11T22:00Z.**

🔴 **The split watermark is now four days wide, and this is the second
consecutive run it has survived.** Gmail was unreachable again — the MCP server
answered _"needs you to sign in again"_ and then disconnected, in a
non-interactive session, so **zero mail queries ran**. Carrying the mail
watermark forward would silently skip four days of the one source that has
carried every substantive client event on this project. **Do not collapse the two
values.** Mail was **not searched**; it did not return nothing.

**Watermark used for this run: 2026-09-14T22:00Z**, the `external_watermark` of
[the 14/09 trace](Source%20trace%202026-09-14.md), which is the newest note in
this folder by `updated:`. The JOURNAL's newest entry was 14/09, so the two
agreed and there is no blind spot on the repository side.

## Sources searched

All read-only. **Nothing was sent, replied to, drafted, shared, modified or
marked read.** This is the **scheduled nightly run**, so the single Slack
carve-out applied: one report to `C0BQD34LLF4`, the ROMI Salesforce dev group. No
other message was sent anywhere.

| Source     | Query / scope                                                                                                          | Result                                                                                                       |
| ---------- | ---------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------ |
| **Gmail**  | `pienissimo after:2026/09/11 -in:draft`                                                                                | 🔴 **NOT SEARCHED** — _"MCP server Gmail needs you to sign in again"_, then the connector disconnected        |
| **Slack**  | workspace-wide incl. private, DMs and group DMs, keyword `pienissimo`, `after:2026-09-14`                               | 2 results — §3 (PR #44 review request) and the 15/09 org-status-check report (own automation)                 |
| **Slack**  | workspace-wide `after:2026-09-14`, **no keyword**, sorted by timestamp, 20 results                                      | 20 live results back to 15/09 16:58 — **0 further Pienissimo items**; BE-MA, Cassa in Cloud, LIFE365 sibling report, time-tracking bot |
| **Slack**  | DM `D0AQ0FMHFM1` (Aurel Mrruku ↔ Andrea Di Cicco), 25 messages                                                          | **no message on 15/09 at all** — last is 14/09 17:28:57 CEST                                                  |
| **Slack**  | DM `D0BKK1D5GF9` (Aurel Mrruku ↔ Anita Aga), 20 messages                                                               | **unchanged since 10/09 14:45:51**                                                                           |
| **Slack**  | DM `D0B33NLB7NF` (Aurel Mrruku ↔ Rexhina Hysi), 20 messages                                                            | **3 new on 15/09** — §3                                                                                      |
| **Slack**  | `#tproj-pienissimo` (`C0B5T3RB4FM`), 8 messages back                                                                   | Last status post still **04/09 19:48**; still says **go-live 6 October**. Only new event: Rexhina Hysi joined the channel 15/09 10:27:42 |
| **Slack**  | canvas `F0BD2H5A9HT` (`Link utili Pienissimo`) re-read in full                                                          | **unchanged**; newest entry still **20.08.26**                                                               |
| **Drive**  | `modifiedTime > '2026-09-14T22:00:00Z'`, paged                                                                          | 5 items — Permo ×2, Daze ×1, 247 folder, **and `Flows & Objects.drawio`** — §5                                |
| **Fathom** | `list_meetings` from 2026-09-14, 3 pages                                                                               | **0 meetings** — nothing to drill                                                                            |
| **Git**    | `git fetch origin --prune`, `git log --all --since='2026-09-14 21:00'`, all nine branch heads                           | **9 commits** — §1, §2, §4                                                                                   |
| **Git**    | `1830fce` read in full; PR #44 read as `git diff 23f1375 f51365b`; `400c195` diffstat + `OrderItemTriggerHandler` in full + five service headers; `ParticipantRegistrationController` lines 1, 185–240, 361; `EventInvitationService.generateToken`; `MexalSearchCalloutService.buildEndpoint`; `git log -S Named_Credential_Sandbox__c` | **the bulk of this run** |
| **GitHub** | `list_pull_requests` state `all`, 6 newest, sorted by update                                                            | **#43 merged 08:07:04Z · #44 merged 13:43:52Z · #45 OPEN**                                                   |
| **Repo**   | `AGENTS.md`, `MAP.md`, `INDEX.md` (targeted), the write protocol, the skill, the 14/09 trace, OI-50/64/102/116/117/135, three risks, the chain build note, the register at BIG-18/INT-16/ORD-03/AC-06, both prose docs at BIG-18 | read directly |

## Found

### 1. 🟢 PR #43 merged — the custody risk is closed

**`23f1375`, 2026-09-15 08:07:04Z.** The order-to-Mexal chain, the OI-117
validation rule, the article sync and both named credentials are on `DevMain`.

The 15/09 `org-status-check` report in `C0BQD34LLF4` (10:52 CEST, own automation)
confirms it from the org side: **all 48 repository Apex classes and triggers
deployed, 44 token-equivalent to UAT**, and **`MexalHttpClient` absent from both
sides** — so the 14/09 orphaned-class question resolves as **no orphan**; what was
committed was a reconciled version and the transient is gone.

[The org-only chain risk](../risks/Risk%20-%20the%20Mexal%20order%20integration%20exists%20only%20in%20the%20org.md)
moves to **resolved**.
[The credentials risk](../risks/Risk%20-%20integration%20credentials%20exist%20only%20in%20the%20org.md)
moves to **in-progress** — Mexal and Anticipay are in source with secrets left in
the org as merge-field references; **DocuSign is still org-only**.

### 2. 🔴 `1830fce` — the chain is switched off in every sandbox

Eight lines, pushed **10:02:54 CEST**, merged five minutes later inside PR #43:
an unconditional `if (isSandbox()) { return; }` at the top of
`OrderMexalIntegrationService.enqueueForCreatedOrders`. **UAT is a sandbox.**

Full reading:
[OI-137](../items/OI-137%20The%20order%20to%20Mexal%20chain%20is%20disabled%20in%20every%20sandbox.md).
In short: 🟢 it is a genuine answer to
[the production-ERP risk](../risks/Risk%20-%20the%20Mexal%20integration%20is%20developed%20against%20the%20production%20ERP.md)
recorded the night before, and it shipped the next morning; ⚠ **the reason is
inferred** from the commit and its timing and is stated by no source; 🔴 **UAT
opens 23 September and acceptance is due 13 October**, so the first end-to-end
order run would be in production; 🔴 a finer mechanism existed and was not used;
🔴 it is asymmetric — customers can still be written to Mexal production from a
sandbox.

**It also explains a line that has been read as a symptom for two days**: "all 31
Orders carry a blank `Mexal_Integration_Status__c`" is now the designed
behaviour of the UAT org, not evidence that the chain is broken.

### 3. 🟢🔴 PR #44 merged — tokens on the participant page, and a public write to Order status

**`f51365b`, 13:43:52Z**, Rexhina Hysi, **+2,487 / −123 across 31 files.**
Requested for review in DM `D0B33NLB7NF` at **15:10:28 CEST** — _"kur te kesh
kohe"_ — Aurel Mrruku answered _"on it"_ at 15:20:56 and _"me von ma shpjego cesht
ber"_ at 15:21:02, and merged it at 15:43. 🟢 **The first Mexal-era PR where a
review was explicitly asked for and acknowledged.**

🟢 **The invitation and participant stack reaches source**, which closes the org
check's own drift finding #9: `ContactTriggerHandler`, `ContactTrigger`, a
rewritten `ParticipantRegistrationController`, `Event_Invitation__c.Token__c`,
Campaign event dates, a Campaign and a Contact record page, `Rinuncia` as a real
`AssetStatus` value.

🟢 **The link is now an opaque per-invitation token** — 64 hex characters from
`EncodingUtil.convertToHex(Crypto.generateAesKey(256))` — instead of raw Account
and Campaign ids. **This supersedes `BIG-18` in practice**, and the register and
both prose documents now carry a dated supersession clause. It is also the pattern
`INT-16` recommended and was refused for the WooCommerce checkout link, so the
same trade-off is now live in two places and decided aloud in neither.

🔑🔴 **The same public page can set an order to `Incassato`.**
`ParticipantRegistrationController` is `public without sharing` and exposes
`@AuraEnabled markOrderIncassato(String token)`, writing
`Order.Status = 'Incassato'` on every Order behind the invitation's visible
Assets; the LWC renders it as a **"Segna ordine incassato"** button. New:
[OI-136](../items/OI-136%20Public%20participant%20link%20can%20mark%20an%20order%20Incassato.md).
The token is strong; what it authorises is not bounded — no expiry, no revocation
short of invalidating a link already sent, no attribution, and no requirement
authorises it.

⚠ **A note arrived inside the commit** —
[the batch recap](../objects/Aurel%20requested%20the%20participant%20invitation%20batch.md),
158 lines, `source: User instruction to Codex on 2026-09-15`, attributing the work
to Aurel Mrruku. **No swept source corroborates the attribution**, and the note
**does not mention the `Incassato` button at all**. This is the **third** time a
decision or recap has reached this repository through a code commit rather than a
meeting. Left as committed; indexed, not rewritten.

### 4. 🟢 PR #45 opened — the tranche roll-up, unmerged

**`400c195`, 16:07:59Z**, Anita Aga, **+2,290 / −21 across 30 files, seven new
Apex classes**, PR opened **one minute after the push**, title truncated, no
description. Full reading:
[the build](../objects/The%20Mexal%20payment%20return%20and%20tranche%20roll-up.md).

🟢 **`OrderItemTriggerHandler` is the tranche roll-up** the 15/09 org check
reported missing after an exhaustive search — `Pagata` only when every line is
`Paid`, which is `ORD-03` and `AC-06` verbatim. The per-line status comes from the
Mexal scadenzario.
🟢 **OI-117's principal is fixed** — `NOT($Permission.Edit_Mexal_Synced_Admin_Fields)`
against a new custom permission, replacing the literal profile name. 🔴 Nothing
grants it yet, which locks the thirteen fields for everyone.
🔴 **A third unscheduled batch** — `MexalMaggazinoSyncBatch` joins the scheduler
nobody has called. ⚠ Warehouse-movement sync has **no requirement id and no
minuted request** anywhere in this record.
⚠ `Maggazino` is a misspelling of _magazzino_, baked into three class names.

### 5. ⚠ `Flows & Objects.drawio` moved an eighth time, and was not decoded

`11ly3iGQc1smlY8IybSnUMQBGXbZ-ddbx`, owned by Elena Spini, modified
**2026-09-15T08:29:51Z** and viewed by this account two minutes later. It is
`DGM-2`, the master design file, and **the `source:` of `BIG-18`** — the very
requirement the build superseded seven hours after this edit.

🔴 **Not decoded, fourth consecutive run.** The file is 133 KB of plain mxfile XML
delivered as base64 through the Drive tool; there is no way to fetch it into a
shell for processing without first materialising ~178 KB of base64 in context and
writing it back out, which would cost more of this session's window than the rest
of the sweep combined. Recorded as an absence, not as nothing.

**The specific question it would answer:** did Elena Spini change the participant
landing flow on the morning of 15 September — before PR #44 replaced the Account
ID link with a token — or was the edit elsewhere in the diagram? The two events
are seven hours apart on the same day and the diagram is the requirement's source.
**A run with room to decode it should do so next.**

### 6. 🔴 First test run in forty-two days: 37 pass, 4 fail

From the 15/09 `org-status-check`: a run against UAT before the audit recorded
**37 pass / 4 fail**, all four `OrderTriggerHandlerTest` methods, **blocked by the
missing edition mappings of
[OI-121](../items/OI-121%20The%20edition%20mapping%20table%20has%20no%20rows%20and%20no%20owner.md)** —
40 of 43 ticket-generating products still unmapped, surfacing as a red test rather
than a data gap. Coverage **0 covered / 5,095 uncovered / 0%**, measured at 08:47Z
and therefore **before** the day's 4,777 new lines.

**Brief only. No test class was written, proposed or scaffolded.**

### 7. ⚠ Everything else in the window belongs to another client

- **Slack** — `#team-romi-tech` on BE-MA, Field Service and Cassa in Cloud;
  `#tproj-bema`; a Permo DM; `#gen-time-tracking`; and the `[LIFE365]` sibling
  nightly report, which independently reports **Gmail unreachable on its own run**.
  **Not ingested.**
- **Drive** — Permo ×2, Daze ×1, a 247 folder. **0 new Pienissimo documents**; the
  workbook did not move.
- **Fathom** — no recording since 08/09. **No meeting happened; nothing to drill.**
- **`#tproj-pienissimo`** — no status post since 04/09, **eleven days**, and it
  still says go-live 6 October, seven days after the register moved to 21 October.

## What it changed

**Three notes created, nine updated. `BIG-18` changed in the register and in both
prose documents.**

| Written                                                             | Because                                                                    |
| ------------------------------------------------------------------- | -------------------------------------------------------------------------- |
| `OI-136 Public participant link can mark an order Incassato`        | **new** — a guest-reachable write to `Order.Status`                        |
| `OI-137 The order to Mexal chain is disabled in every sandbox`      | **new** — `isSandbox()` vs a UAT that opens in eight days                  |
| `The Mexal payment return and tranche roll-up`                      | **new** — PR #45's seven classes and the ORD-03 writer                     |
| `Risk - the Mexal order integration exists only in the org`         | PR #43 merged → **resolved**                                               |
| `Risk - integration credentials exist only in the org`              | two of three in source → **in-progress**; DocuSign still org-only          |
| `Risk - the Mexal integration is developed against the production ERP` | a **correction** to the 14/09 reading, plus the sandbox guard           |
| `Risk - production deploy is blocked by Apex coverage`              | 5,095 uncovered before 4,777 more; first run in 42 days                    |
| `The order to Mexal integration chain`                              | merged, then gated on `IsSandbox`, then given a return leg                 |
| `OI-117`                                                            | the principal is a custom permission now; nothing grants it                |
| `OI-116`                                                            | merged; a third batch; still nothing scheduled                             |
| `OI-102`                                                            | seventh day, through a DM that carried nothing at all                      |
| `OI-64`                                                             | 37 pass / 4 fail; 5,095 uncovered; the brief gains a guest write           |
| `OI-50`                                                             | gap 2 — the aggregation — is built, on an open PR                          |
| `MAP.md`, `INDEX.md`                                                | the live position, three new notes, the committed note, the trace row      |
| `open-items.md` / `.it.md` rows 50, 64, 102, 116, 117, 135 + **new rows 136, 137** | regenerated from the notes, both languages                |
| `DEVELOPMENT-RECAP.md` / `.it.md` §38                               | the three PRs and the sandbox guard, both languages                        |
| `requirements/pienissimo-requirements.yaml`, `REQUIREMENTS.md`, `REQUISITI.it.md` | **`BIG-18`** superseded in practice by the token link         |

### Why `BIG-18` was changed and nothing else was

`BIG-18`'s text says the participant landing is _"reached by a link carrying the
Account ID"_. As of `f51365b` on `DevMain` that is **false**, and the sentence sits
in the document the client signs. It was therefore given a **dated supersession
clause** in the same style the register already uses for `INT-16` — recording what
the build did, keeping `status: to_confirm`, and **inventing no decision**. Nobody
has agreed the token mechanism; the register now says that too.

Nothing else moved:

- **PR #43 merging is custody, not scope.** `INT-01` and `INT-05` already require
  what merged.
- **The sandbox guard is a delivery risk, not a requirement change.** No
  requirement states which Mexal environment is used or where acceptance happens —
  which is itself the finding, and is why `OI-137` exists rather than a register
  edit.
- **The tranche roll-up implements `ORD-03`/`AC-06` as written.** No change needed;
  the requirement was already right.
- **The `Incassato` button is not covered by any requirement.** Recording it as an
  authorised behaviour would be the fabrication. It is `OI-136`, and `BIG-18`'s
  clause points at it.

### Triggers

**The 14/09 trigger fired and its premise holds.** It read: _if the scheduler is
switched on, or the nightly batch runs, while the outbound push still covers only
four of the thirteen locked fields — raise it against `INT-01`._ **Nothing is
scheduled**, so it has not fired. ⚠ **Re-armed and sharpened:** the principal is
now a custom permission that **nothing grants**, so the next run must check
whether a permission set grants `Edit_Mexal_Synced_Admin_Fields` — if PR #45
merges without one, amministrazione is locked out of the thirteen fields the
03/09 session promised them, which is a client-facing regression against `INT-01`.

**The Mexal-test-environment trigger did not fire.** No source states that Mexal
has a test company or that it does not. ⚠ **But the ground shifted**: the
sandbox/production named-credential split has existed since 10 September, so the
question is now narrower — *what is `Named_Credential_Sandbox__c` set to in the
six `Integration_Configuration2__c` rows?* The next `org-status-check` can answer
it without asking anybody.

**A new trigger:** _if PR #45 merges, or any `System.schedule` call appears, check
whether `MexalMaggazinoSyncBatch` has acquired a requirement id or a minuted
request. A nightly warehouse sync against the client's production ERP with no
recorded request is scope nobody agreed._

**A second new trigger:** _if any source shows a human discussing the `Incassato`
button — approving it, questioning it, or using it — record it against OI-136
immediately. Until then it is a finding this repository raised and no person has
seen._

The **10/09 trigger** — Kreosoft on `cod_agente` / `zona` / `classificatore rete`
— **did not fire. Nobody has asked him**, sixth day, and `OI-135` is now equally
stale. The **09/09 trigger** — the canonical quote-state spelling — **did not
fire.**

## Deliberately not done

- **No mail sent, no message replied to, nothing marked read, no Drive file
  modified or shared.** One Slack message to `C0BQD34LLF4` under the nightly
  carve-out.
- 🔴 **Gmail was not searched at all**, second consecutive run — see the split
  watermark above.
- **No Apex test class was written, proposed or scaffolded.** The day's 4,777 new
  lines and the 4 failures are recorded as brief in
  [OI-64](../items/OI-64%20The%20bundle%20Apex%20test%20suite%20is%20broken.md) and
  [the deploy risk](../risks/Risk%20-%20production%20deploy%20is%20blocked%20by%20Apex%20coverage.md).
- **PR #45 was not reviewed, commented on, approved or merged.** Not this
  procedure's to touch. Neither was the developer-authored note that arrived in
  PR #44 — it is indexed and cited, not rewritten.
- **The org was not opened.** Every build claim here is repository arithmetic
  against commits, plus the 15/09 `org-status-check` report as a swept source. The
  org record is therefore fourteen hours old and **predates PR #44 and PR #45
  entirely**.
- **The `.drawio` was not decoded** — §5, with the reason and the question it owes.
- **`MexalMaggazinoSyncBatch`, `MexalScadenzarioSearchService` and
  `MexalInvoiceOrderLineMappingService` were read by structure, not line by line.**
  Close readings are owed if the warehouse or payment mapping becomes contested.
- **No credential, token value, price, article code, VAT number, IBAN or personal
  datum** was written into the repository. The invitation token's *generation
  method* is recorded; **no token value is**. The Mexal auth-header shape and
  endpoint hostnames are recorded; **no secret value is**.
- **The two `[TEST]` email PDFs and the funnel screenshots were not opened**,
  seventh run. **`Stima Task` still unattributed, eighth run.**

## Gaps in this run

- 🔴 **Gmail unreachable, two runs running.** An expired OAuth token in a
  non-interactive session needs a human at claude.ai → Settings → Connectors.
  **Four days of the project's primary client channel are unread**, across a window
  containing UAT preparation and four blocking decisions put to the client on 08/09.
  **This is the highest-value action available to a person tonight.**
- 🔴 **UAT opens 23 September — eight days — and the order-to-Mexal integration
  cannot run in it by design.** Nothing in the record says how `INT-01`/`INT-05`
  get accepted.
- 🔴 **A guest-reachable write to order payment state is on `DevMain`**, unreviewed
  as a design question by any human.
- 🔴 **Still nothing scheduled, and now three batches wait on it.** Twelve days
  since the sync window was first raised.
- 🔴 **40 of 43 ticket-generating products still unmapped** (#121) — unchanged, and
  now the direct cause of four red tests.
- ⚠ **`#tproj-pienissimo` has had no status post for eleven days** and still says
  go-live 6 October. The canvas is still ten client sessions behind.
- ⚠ **`MAP.md` is far over its own stated 5 KB budget and this run added to it
  again.** Raised 08/09, 09/09, 10/09, 11/09, 14/09 and here — **sixth consecutive
  request; no run has been authorised to act on it.**

## Method

**The lesson of this run is that a sweep must re-read the code behind its own
notes, not just the notes.** Two corrections came out of that:

1. The production-ERP risk, written last night, asserted that _"nothing
   distinguishes a test target from a live one, so there is no configuration a
   developer could switch."_ `git log -S Named_Credential_Sandbox__c` shows the
   switch has existed since **10 September** — five days before the note claimed it
   did not. The note was wrong when written, and only reading the code caught it.
2. "All 31 Orders carry a blank Mexal integration status" has been read as
   evidence of an unexercised chain for two days. Eight lines of `1830fce` turn it
   into the **expected** reading for a sandbox. The metric did not change; what it
   means did.

The corollary for the next run: **when a number stops moving, ask whether
something started preventing it from moving.** A guard shipped quietly looks
exactly like a feature that never ran.
