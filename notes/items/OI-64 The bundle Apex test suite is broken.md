---
id: OI-64
type: open-item
status: open
owner: Aurel Mrruku
org: ROMI
raised: 2026-08-03
updated: 2026-09-10
blocks: [go-live]
severity: gating
source: meetings/open-items.md row 64
evidence: test run against Pienissimo UAT, 2026-08-03
---

# OI-64 - The bundle Apex test suite is broken

## 2026-09-07 - invitation source added to the future suite brief

The [invitation foundation](../flows/Proposed%20event%20invitations%20for%20participant%20registration.md)
adds three Apex classes and EventInvitationTrigger, and changes the order
handler after Asset insertion. Include repeated bundle purchases, multi-event
grouping, concurrent Account-Campaign creation and preservation of existing
invitations in the later suite. Source only; check-only compilation passed,
no coverage measured and no test classes written. Existing production gate and
the separately requested suite policy remain unchanged.

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

## 2026-08-26 - re-measured: 1069 uncovered lines

Still 24 entries in `ApexCodeCoverageAggregate`, still **zero covered**, and the
uncovered total is now **1069** (1028 on 25 August). The difference is entirely
`QuoteTrancheController`, whose recorded figure rose from 144 to 185 without the
class changing — the snapshot caught up with the 25 August deploy.

No test run has succeeded in this org since. The suite remains a single task,
requested separately before the production deploy.

## 2026-09-02 - still gating, and the coverage figure needs reading correctly

Verified against Pienissimo UAT, 08:05-08:14Z. Org coverage: **0 covered, 1,646
uncovered, 0%**. Still gating; the item does not move.

Two facts this run adds:

- **Both test classes named above are deployed in the org** —
  `BundleComponentTriggerHandlerTest` (6,235 chars) and
  `BundleProductAssignmentControllerTest` (10,320 chars), alongside
  `OrderBigliettoTriggerHandlerTest` (7,151). So the suite exists; the question
  is whether it passes.
- **It has not been run since `2026-08-04`.** That run enqueued 10 methods,
  completed 10 and failed **0**. The 9-of-10 failure recorded on 2026-08-03 was
  the day before.

So the evidence that `Code__c` still breaks the suite is **a month old and was
superseded the next day by a clean run**. Whether the regression was fixed,
whether it returned as classes changed through 31 August, and what coverage
those tests actually produce are all **unknown** — the stored 0% is an
unmeasured aggregate, not a result. See
[the deploy risk](../risks/Risk%20-%20production%20deploy%20is%20blocked%20by%20Apex%20coverage.md).

**Nothing here changes what to do**: the suite is written as one task before the
production deploy, on request. This check ran no tests and wrote none. But when
that task is called, **start by running what exists** — the brief may be smaller
than the record implies.

## 2026-09-09 - the commercial automation joins the brief, and one existing test is now stale

**Commit `a53345a`** (Anita Aga, PR **#37**, merged 18:41 CEST) adds **+729 net
Apex lines** across six classes
([the build](../objects/The%20commercial%20process%20automation.md)). Added to the
brief for the separately requested suite:

- **`QuoteTriggerHandler`** (219 lines, new) — quote-to-order generation, locale
  inheritance and mismatch error, opportunity stage advance. Cases worth naming:
  a quote accepted twice, a quote with no lines, a quote whose opportunity is not
  `Qualificato`, a line carrying a tranche, and the double-generation guard.
- **`OpportunityTriggerHandler`** (62 lines, new) — the `Locale` → parent
  `Azienda` rewrite before save. Cases: an opportunity on an `Azienda` already,
  a `Locale` with no resolvable parent, a bulk insert mixing both.
- **`LeadConversionTriggerHandler`** (248 lines, new) and the reworked
  `LeadConversionQueueable` (+134).
- **`OrderTriggerHandler`** (+47) — opportunity close-won on `Incassato`.
- **`WoocommerceOrderService`** (+19) — the `Azienda` record type stamp, and the
  new throw when that record type is absent.

🔴 **`OrderTriggerHandlerTest` is now behind the class it covers.** The commit
adds `closeWonOpportunitiesForConfirmedOrders` to `OrderTriggerHandler` and
**does not touch its test**. Whether the test still compiles and what it now
fails to assert are both **unknown — not checked this run**.

**Nothing was run and nothing was written.** This is brief maintenance only, per
the standing instruction; the suite stays Aurel Mrruku's to request in one pass
before the production deploy.

## 2026-09-10 - two more classes on the brief, and a new category

**`bc2ed5d`** (Anita Aga, PR **#39**, **open**) adds `MexalSearchCalloutService`
(260 lines) and `MexalCustomerSearchService` (236 lines). **+496 lines, no
tests.**

🔴 **The brief now includes an HTTP callout class for the first time on the Mexal
side.** `MexalSearchCalloutService` cannot reach any coverage without an
`HttpCalloutMock` — or without the house scaffolding's own mock path, since
`Integration_Configuration__c` already carries `Use_Mock__c`,
`Mock_API_Scenario__c` and `Mock_Apex_Class__c`. **Whoever writes the suite should
check that path first rather than hand-rolling mocks.**

Worth testing when the suite is commissioned, listed so the brief is complete:

- the three read-only guards in `MexalSearchCalloutService` — the action
  allow-list, the `/ricerca` suffix check and the POST-only check — each of which
  throws a distinct message;
- `chooseHierarchyConfiguration`'s user → profile → org precedence;
- `MexalCustomerSearchService.mapCustomerToAccount`, all fourteen assignments,
  including the **IBAN reconstruction** and the `banca_appoggio` precedence that
  [the build note](../objects/The%20first%20Mexal%20integration%20Apex.md) flags
  as a probable defect;
- the untyped-JSON paths that return silently on an unexpected shape.

⏸ **Brief only. Nothing was acted on; no test class was written or proposed.**
