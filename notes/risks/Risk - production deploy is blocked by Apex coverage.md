---
id: risk-coverage-blocks-deploy
type: risk
status: open
severity: high
owner: Aurel Mrruku
org: ROMI
raised: 2026-08-03
updated: 2026-09-09
depends_on: [OI-64, OI-66]
blocks: [go-live]
source: meetings/open-items.md org verification 2026-08-03
---

# Risk - production deploy is blocked by Apex coverage

## 2026-09-07 - invitation source extends the production coverage brief

Three new Apex classes and EventInvitationTrigger, plus an order-handler call,
implement [the invitation foundation](../flows/Proposed%20event%20invitations%20for%20participant%20registration.md)
in local source only. Salesforce check-only validation with NoTestRun passed;
no tests were added, no live coverage changed or was measured, and this is not
production readiness. OI-64 and OI-66 carry the added scenarios for the separate
suite task. Production coverage remains gating; it is not a Phase 1 feature-work
blocker under the existing user decision.

Org-wide Apex coverage in UAT was **1%** on 2026-08-03. Salesforce requires
**75%** to deploy to production. Until that gap closes, nothing in this project
can ship, however finished the design is.

Two causes, both tracked:

- [OI-64](../items/OI-64%20The%20bundle%20Apex%20test%20suite%20is%20broken.md) —
  making `Product2.Code__c` required broke every bundle test that inserts a
  product without a code. Nine of ten fail.
- [OI-66](../items/OI-66%20No%20test%20classes%20for%20the%20Biglietto%20stack.md) —
  the Biglietto DocuSign and PDF classes have no tests at all, ~270 uncovered
  lines, and are
  [not even in the repository](Risk%20-%20the%20Biglietto%20Apex%20stack%20is%20not%20in%20source%20control.md).

**Why this is a risk and not just a task.** The go-live is 6 October and the
Zoho contract ends 31 October, so there is no version of the plan in which the
deploy slips. The suite is deliberately scheduled as one late block rather than
drip-fed — Aurel requests it as its own task before the production deploy — but
that concentrates the whole gap against a fixed date, with the team
[away until the last week of August](Risk%20-%20the%20whole%20remaining%20build%20lands%20after%20Ferragosto.md).

**Scope, for when it is called.** OI-64 is small — set `Code__c` in the two test
factories. OI-66 is ~270 uncovered lines across six classes and needs
[the retrieve](Risk%20-%20the%20Biglietto%20Apex%20stack%20is%20not%20in%20source%20control.md)
done first, since those classes are not in the repository.
`API_Callout_Engine` has no test class either; check whether the
[house scaffolding](../Integration%20Configuration%20is%20standard%20ROMI%20scaffolding.md)
ships with one.

## 2026-08-25 - org check: the floor is further away, not nearer

Verified read-only against **Pienissimo UAT**. Coverage is **0%**, not the 1%
this risk has carried since 2026-08-03: 24 classes and triggers, 1028 uncovered
lines, **zero covered**. Meanwhile `QuoteTrancheController` (144 lines) was
deployed on 2026-08-25 with no test, so the gap to the 75% floor widened on the
same day it was measured.

The risk is unchanged in kind and worse in degree. It stays **high** and
**gating**, and it stays a single late task at Aurel Mrruku's request — see
[OI-64](../items/OI-64%20The%20bundle%20Apex%20test%20suite%20is%20broken.md) and
[OI-66](../items/OI-66%20No%20test%20classes%20for%20the%20Biglietto%20stack.md).

## 2026-08-26 - org check: 1069 uncovered lines, still zero covered

Re-measured read-only against **Pienissimo UAT**. Same 24 classes and triggers,
**zero lines covered**, and the uncovered total has risen from 1028 to
**1069**.

The whole of the increase is `QuoteTrancheController`, recorded at 144 uncovered
lines on 25 August and reporting **185** today. Its body has not been modified
in the org since **2026-08-25T12:50:07Z**, so the code did not grow — the
coverage snapshot did, having caught up with the deploy. Treat 1069 as the
first complete measurement of the tranche stack rather than as a regression.

Nothing else moved. The floor is 75%; the org is at 0%. This stays **high**,
stays **gating**, and stays one late task at Aurel Mrruku's request.

## 2026-08-31 - org check: 1571 uncovered lines, still zero covered, and the drop is not progress

Re-measured read-only against **Pienissimo UAT** by the `org-status-check` of
09:36–09:52Z. **0 lines covered of 1,571, across 21 classes** — down from 1,769
across 28.

⚠ **Read the decrease correctly.** The whole of it is the seven Biglietto classes
[deleted from the org on 28 August](Risk%20-%20the%20Biglietto%20Apex%20stack%20is%20not%20in%20source%20control.md).
**No test was written.** Coverage did not improve; the denominator shrank because
code was destroyed. A summary that reports "1,769 → 1,571" as movement toward the
floor would be wrong in the most misleading possible direction.

Largest uncovered, first: `WoocommerceOrderService` **396**,
`QuoteTrancheController` **386**, `LeadConversionQueueable` **148**.

🔴 **The largest target is unversioned.** `WoocommerceOrderService` is the live
WooCommerce endpoint and exists only in the org —
[the deploy risk](Risk%20-%20a%20clean%20deploy%20would%20orphan%20the%20live%20WooCommerce%20endpoint.md).
It cannot be read from `force-app/`, so it cannot be tested from `force-app/`
either. Retrieving it is a prerequisite of the test task, and it is a one-command
prerequisite that nobody has run.

⚠ The register still records `current: "1%"`. It has been 0% on every measurement
since 25 August.

The floor is 75%; the org is at 0%. This stays **high**, stays **gating**, and
stays one late task at Aurel Mrruku's request. Nothing here proposes writing it.

## 2026-09-02 - the number is real, but it is not a measurement

Verified against Pienissimo UAT, 08:05-08:14Z. `ApexCodeCoverageAggregate`
reports **0 covered, 1,646 uncovered, 0%** — up from 1,571 lines on 31 August as
code lands. Against a 75% floor, nothing can ship. **That part is unchanged and
still gating.**

But the figure has been read too literally across the record, and the correction
matters when the suite is finally written:

**The last Apex test run in this org is `2026-08-04T08:53Z`** — 10 methods
enqueued, 10 completed, **0 failed**. Project classes have changed continuously
since, through 31 August. `ApexCodeCoverageAggregate` is populated only _by a
test run_ and is invalidated when classes recompile, so the stored 0% is
measuring **nothing about the current code**.

> Read it as **unmeasured**, not as **measured at zero**.

The practical difference: "0% coverage" has been cited as evidence that the
tests are broken or absent. Neither is established. **Three project test classes
are deployed** — `BundleComponentTriggerHandlerTest` (6,235 chars),
`BundleProductAssignmentControllerTest` (10,320) and
`OrderBigliettoTriggerHandlerTest` (7,151) — and on their last recorded run they
passed.

⚠ **This does not mean coverage is secretly fine.** Three test classes against
twelve project classes and 1,646 lines will not reach 75%, and the deploy gate
computes coverage at deploy time regardless of what is stored. The honest
position is that **nobody currently knows the real figure**, and the only way to
learn it is to run the suite.

**No test was run by this check, and none was written or offered.** The suite
remains one task, requested separately before the production deploy.

⚠ [OI-66](../items/OI-66%20No%20test%20classes%20for%20the%20Biglietto%20stack.md) is
**superseded, not fixed** — its ~270 lines were deleted with the Biglietto stack
on 28 August rather than covered. The fall from 1,769 lines is that deletion, not
progress.

## 2026-09-02 - deferred by explicit decision, and still gating

Aurel Mrruku, the same day: _"in this faase we dont care about the coverage
too"_. Recorded as
[a decision](../decisions/Decision%20-%20Apex%20coverage%20is%20not%20a%20Fase%201%20concern.md).

**What changes:** coverage stops being reported as a live blocker on Fase 1
build work. It is a known, accepted, dated deferral, not a finding.

**What does not change:** this risk **stays open, stays high and stays gating**,
per the standing instruction in [AGENTS.md](../../AGENTS.md) that the coverage
records remain current as the brief for the test task. The 75% floor is computed
by Salesforce **at the production deploy** and is indifferent to what phase the
project calls itself. Deferring costs nothing in a sandbox and everything on the
day of the deploy, and the window in which the suite must be written and pass —
between the **10 September** end of Fase 1 development and the **6 October**
go-live — is still not scheduled and still not estimated.

🟢 One thing genuinely improved: **`WoocommerceOrderService` is now committed**
and byte-identical to the deployed class
([the orphan-route risk, resolved](Risk%20-%20a%20clean%20deploy%20would%20orphan%20the%20live%20WooCommerce%20endpoint.md)).
The largest single uncovered target — 396 lines — could not be tested from
`force-app/` before, and now can. The one-command prerequisite this note flagged
on 31 August is met.

Nothing here writes, proposes or offers a test.

## 2026-09-03 - the deficit grew by 844 lines in one day

PR **#31** added two Apex controllers to `DevMain` with no tests:
`ParticipantRegistrationController` (**576 lines**) and
`QuoteAcceptanceController` (**268 lines**) —
[the Landing Page community](../objects/The%20Landing%20Page%20community.md).

Against the last measurement of **1,571 uncovered lines across 21 classes, zero
covered** (31 August, from the org), the repository now carries roughly **844 more
uncovered lines**. ⚠ That figure is arithmetic on the repository, **not a
measurement** — the org has not been opened since 2 September and the last actual
Apex test run remains **4 August**.

The deficit continues to grow as code lands, which is the pattern this risk has
recorded since 25 August (1,028 → 1,769 → 1,571 → ~2,415).

**Unchanged in substance:** coverage is
[deliberately deferred out of Fase 1](../decisions/Decision%20-%20Apex%20coverage%20is%20not%20a%20Fase%201%20concern.md)
and is **not** a blocker on current build work. It still gates the production
deploy, and the suite is still unscheduled between the 10 September end of build
and the 6 October go-live. **Recorded, not acted on** — the suite is written once,
as its own task, when Aurel Mrruku asks for it.

⚠ The two new classes are the first uncovered code that sits on an
**internet-facing write path**
([the authentication risk](Risk%20-%20the%20community%20pages%20have%20no%20application-level%20authentication.md)),
which changes what the eventual test suite has to cover, not when it is written.

## 2026-09-04 — a second large uncovered increment, four days after the first

Two merges on 4 September add roughly **another 600 uncovered lines** to
`DevMain`, on top of the +844 recorded on 3 September:

| Class                                      | Lines added | From                                   |
| ------------------------------------------ | ----------- | -------------------------------------- |
| `AnticipayErrorNotificationService`        | 188         | PR #32 — the Anticipay failure mail    |
| `MappaturaEdizioneTriggerHandler`          | 132         | PR #34 — edition mapping overlap guard |
| `OrderBigliettoTriggerHandler` (additions) | ~93         | PR #34 — campaign assignment           |
| `AnticipayAccountService` (additions)      | ~80         | PR #32                                 |
| `AnticipayOrderAutomation`                 | 63          | PR #32                                 |
| `AnticipayAccountRefreshQueueable`         | 38          | PR #32                                 |
| `anticipayAccountRefreshAction` (LWC JS)   | 112         | PR #32                                 |

**Recorded, not acted on**, per the standing instruction: the test suite is
Aurel Mrruku's to request as its own task before the production deploy, and
[Apex coverage is not a Fase 1 concern](../decisions/Decision%20-%20Apex%20coverage%20is%20not%20a%20Fase%201%20concern.md).

⚠ **Two of the new classes are branch-heavy in ways that will make the eventual
suite larger than the line count suggests** — worth knowing when the task is
scoped, not now. `MappaturaEdizioneTriggerHandler` has an in-transaction path and
an against-existing path with an insert/update distinction; `assignCampaigns` has
three distinct throw conditions on a trigger path that rolls back a business
state transition. **Both are exactly the kind of code where an untested edge
becomes a production incident**, and `assignCampaigns` in particular now sits
between a live order lifecycle and a table with no rows
([OI-121](../items/OI-121%20The%20edition%20mapping%20table%20has%20no%20rows%20and%20no%20owner.md)).

⚠ **The last measured figure is still 4 August.** Everything since is a line
count from `git diff`, not a coverage run — the number remains **unmeasured, not
measured at zero**.

## 2026-09-07 - the org puts a number on it: 0 of 2,741 lines

An `org-status-check` run against Pienissimo UAT, reported by **Aurel Mrruku in
the ROMI Salesforce group DM at 10:04 CEST**, measured the org rather than the
diff:

- **0 of 2,741 covered lines.**
- **Lines grew 1,646 → 2,741 (+1,095) since 2 September.**
- **The last Apex test run is still 2026-08-04**, while code landed through
  4 September.
- Its own verdict: _"The 75% production floor cannot be evidenced today."_
  Classified `partial / aligned / uncovered`.

🟢 **This confirms the standing caveat rather than overturning it**: the figure is
**unmeasured, not measured at zero**. Nothing has run since 4 August.

⚠ **And it predates the largest single addition.** The check ran at repo commit
`012d49d`; commit **`d562af0`** landed later the same day carrying
`EventInvitationService` (107 lines), `EventInvitationUrlJob` (110),
`ParticipantCommunityUrl` (60) and `EventInvitationTrigger` (12) — roughly **290
further uncovered lines** on top of the 2,741.

**Recorded, not acted on.** The suite remains Aurel Mrruku\'s to request as its own
task before the production deploy.

🔴 **The window for it just narrowed.** This risk has been scheduled against
"between the 10 September end of build and the 6 October go-live". The
7 September internal follow-up agreed **go-live 21 September with approval by
13 September**
([OI-124](../items/OI-124%20Go-live%20moved%20from%206%20to%2021%20October.md)).
If that date holds, the unscheduled test task has to fit **between 10 and 13
September**, three of which are the company offsite. **Nobody has connected the
two.**

## 2026-09-08 - 0 of 2,957 lines, and the deploy window is now dated

The org check of 8 September, 16:31-16:39 CEST, reports the stored aggregate as
**0 covered / 2,957 uncovered lines (0%, 42 entries)** against live UAT — up from
**2,741** the day before, which is the invitation stack and now `c877631`'s
`AccountTriggerHandler`, `CommercialAccountResolver` and the `AnticipayAccountService`
additions.

| Date      | Uncovered lines | Source                                      |
| --------- | --------------- | ------------------------------------------- |
| 31/08     | 1,571           | org check                                   |
| 02/09     | 1,646           | org check                                   |
| 07/09     | 2,741           | ROMI org check, posted to the dev group     |
| **08/09** | **2,957**       | **ROMI org check, posted to the dev group** |

🔴 **The window is no longer open-ended.** The client has been told go-live is
**21 October** with production release preceding it, and a first production deploy
was estimated the same day at **"almeno un paio di settimane"**
([OI-124](../items/OI-124%20Go-live%20moved%20from%206%20to%2021%20October.md)).
Salesforce requires 75% org-wide coverage to deploy to production. **At 0% the
deploy fails, whatever else is ready.**

⚠ **The last actual Apex test run is still 4 August.** The figure remains
**UNMEASURED, not measured at zero**, and it predates almost all current code.

⏸ **Nothing was done about it and nothing should be.** Coverage remains
[deliberately deferred in Fase 1](../decisions/Decision%20-%20Apex%20coverage%20is%20not%20a%20Fase%201%20concern.md),
and the test suite is a separate task Aurel Mrruku requests in one pass before the
production deploy. **This record stays current as the brief for that task and is
not acted on.** The brief now additionally covers `AccountTriggerHandler`,
`CommercialAccountResolver` and the Account record-type validation rules.

## 2026-09-09 - the brief grows by 729 Apex lines in one merge

Commit **`a53345a`** (Anita Aga, PR **#37**, merged 18:41 CEST) adds **+729 net
Apex lines** across six classes
([the build](../objects/The%20commercial%20process%20automation.md)):

| Class                          | Net lines | New?                 |
| ------------------------------ | --------- | -------------------- |
| `LeadConversionTriggerHandler` | +248      | new (extract)        |
| `QuoteTriggerHandler`          | +219      | **new**              |
| `LeadConversionQueueable`      | +134      | refactored           |
| `OpportunityTriggerHandler`    | +62       | **new**              |
| `OrderTriggerHandler`          | +47       | existing             |
| `WoocommerceOrderService`      | +19       | existing             |

⚠ **This is arithmetic on the repository, not an org measurement.** The last
measured figure is **0 of 2,957** from the 08/09 ROMI org check, which ran
16:31–16:39 CEST on **8** September and therefore predates both `c877631`'s merge
and this one. Read the two together as _"at least 2,957 + 729, still zero
covered"_ — and the last actual Apex test run is **still 4 August**.

| Date      | Uncovered lines           | Source                                  |
| --------- | ------------------------- | --------------------------------------- |
| 31/08     | 1,571                     | org check                               |
| 02/09     | 1,646                     | org check                               |
| 07/09     | 2,741                     | ROMI org check, posted to the dev group |
| 08/09     | 2,957                     | ROMI org check, posted to the dev group |
| **09/09** | **≥ 3,686** _(estimated)_ | **repository arithmetic on `a53345a`**  |

🔴 **Two new classes carry commercial write paths and have no tests at all** —
`QuoteTriggerHandler` inserts Orders and OrderItems, `OpportunityTriggerHandler`
rewrites `AccountId` before save. Both are the kind of code where an untested
edge case corrupts data rather than throwing.

⚠ Note the repository does contain three test classes —
`OrderTriggerHandlerTest`, `BundleComponentTriggerHandlerTest`,
`BundleProductAssignmentControllerTest`. `OrderTriggerHandlerTest` **was not
updated** for the opportunity-closing behaviour added to the class it covers, so
whatever it asserted about `OrderTriggerHandler` is now incomplete. **Whether it
still compiles was not checked, and checking it is part of the suite task, not
this run.**

⏸ **Recorded, not acted on. No test class was written or proposed.**
