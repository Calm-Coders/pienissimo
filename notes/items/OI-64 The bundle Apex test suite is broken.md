---
id: OI-64
type: open-item
status: open
owner: Aurel Mrruku
org: ROMI
raised: 2026-08-03
updated: 2026-08-25
blocks: [go-live]
severity: gating
source: meetings/open-items.md row 64
evidence: test run against Pienissimo UAT, 2026-08-03
---

# OI-64 - The bundle Apex test suite is broken

`Product2.Code__c` was made **required** (`IsNillable = false`) at some point
after 16 July. Every test that inserts a `Product2` without a code now dies with
`REQUIRED_FIELD_MISSING`.

Verified by running the suite on 2026-08-03: **9 of 10 tests fail**, only
`missingBundleIdIsRejected` passes. Org-wide coverage is **1%**, against the
75% Salesforce requires to deploy.

This is a **regression** — it directly contradicts the "8 Apex tests green"
recorded on 16 July when the bundle demo was accepted.

The fix is small: set `Code__c` in the test factories in
`BundleComponentTriggerHandlerTest` and
`BundleProductAssignmentControllerTest`. Nothing ships until it is done —
see [the deploy risk](../risks/Risk%20-%20production%20deploy%20is%20blocked%20by%20Apex%20coverage.md)
and its larger sibling
[OI-66](OI-66%20No%20test%20classes%20for%20the%20Biglietto%20stack.md).

Related: [OI-67](OI-67%20Products%20with%20no%20code.md) is the data-side
consequence of the same field change.

## 2026-08-25 - org check: coverage is 0%, not 1%

Verified read-only against **Pienissimo UAT**. `ApexCodeCoverageAggregate`
returns **24 classes and triggers, every one of them at zero lines covered** —
1028 uncovered lines, nothing covered anywhere in the org. The figure carried
since 2026-08-03 was 1%; the correct figure today is **0%** against the 75%
production floor.

That includes the four classes in `force-app/` that _are_ test classes —
`BundleComponentTriggerHandlerTest`, `BundleProductAssignmentControllerTest`,
`OrderBigliettoTriggerHandlerTest` — which means **no test run has succeeded in
this org recently enough to leave a coverage record**. The suite is not merely
failing on assertions; it is producing no coverage at all.

Sixteen of the 24 entries are stock Experience Cloud scaffolding
(`Communities*`, `Site*`, `ChangePassword*`, `MyProfilePage*`,
`ForgotPassword*`, `MicrobatchSelfReg*`) which ship with the org and drag the
denominator down without belonging to this project. They still have to be
covered or excluded before a production deploy — see
[the deploy risk](../risks/Risk%20-%20production%20deploy%20is%20blocked%20by%20Apex%20coverage.md).
