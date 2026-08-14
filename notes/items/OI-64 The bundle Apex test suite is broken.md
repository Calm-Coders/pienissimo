---
id: OI-64
type: open-item
status: open
owner: Aurel Mrruku
org: ROMI
raised: 2026-08-03
updated: 2026-08-14
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
