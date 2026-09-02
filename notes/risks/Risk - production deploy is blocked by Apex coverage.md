---
id: risk-coverage-blocks-deploy
type: risk
status: open
severity: high
owner: Aurel Mrruku
org: ROMI
raised: 2026-08-03
updated: 2026-09-02
depends_on: [OI-64, OI-66]
blocks: [go-live]
source: meetings/open-items.md org verification 2026-08-03
---

# Risk - production deploy is blocked by Apex coverage

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
