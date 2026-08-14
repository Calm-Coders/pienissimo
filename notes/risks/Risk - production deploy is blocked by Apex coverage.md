---
id: risk-coverage-blocks-deploy
type: risk
status: open
severity: high
owner: Aurel Mrruku
org: ROMI
raised: 2026-08-03
updated: 2026-08-14
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
