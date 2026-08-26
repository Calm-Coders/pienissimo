---
id: OI-66
type: open-item
status: open
owner: ROMI
org: ROMI
raised: 2026-08-03
updated: 2026-08-25
blocks: [go-live]
depends_on: [risk-biglietto-not-in-scm]
severity: gating
source: meetings/open-items.md row 66
---

# OI-66 - No test classes for the Biglietto stack

`BigliettoTriggerHandler`, `BigliettoDocuSignService`,
`BigliettoDocuSignQueueable`, `BigliettoPdfService`, `BigliettoPdfQueueable`
and `BigliettoPdfBatch` are all Active in UAT with **0 lines covered** — about
**270 uncovered lines**.

Combined with [OI-64](OI-64%20The%20bundle%20Apex%20test%20suite%20is%20broken.md),
this is the single biggest obstacle to a production deploy.

**It cannot be started as written.** None of those six classes is in
`force-app/` — they exist only in the org, which is
[a risk in its own right](../risks/Risk%20-%20the%20Biglietto%20Apex%20stack%20is%20not%20in%20source%20control.md).
The first step is a retrieve, not a test class.

Note also that the 2026-08-06 session **removed DocuSign from the ticket flow**;
participants now sign on paper. Before writing coverage for
`BigliettoDocuSignService`, confirm the code is still wanted — testing a path
the design deleted would be worse than leaving it uncovered.

The `OrderBigliettoTriggerHandler` committed on 4 August **does** ship with a
test class.

## 2026-08-25 - org check: the uncovered surface grew

Verified read-only against **Pienissimo UAT**. The six Biglietto classes remain
at zero coverage, and **a seventh uncovered class joined them**:
`QuoteTrancheController` (144 uncovered lines), deployed to the org on
2026-08-25 with no test class — it is now the single largest uncovered class in
the org, ahead of `BundleProductAssignmentController`.

Uncovered lines in the project's own Apex, largest first:
`QuoteTrancheController` 144, `BundleProductAssignmentController` 132,
`OrderBigliettoTriggerHandler` 123, `API_Callout_Engine` 109,
`BigliettoDocuSignService` 94, `BundleComponentTriggerHandler` 65,
`BigliettoPdfService` 53, `BigliettoDocuSignQueueable` 50,
`BigliettoTriggerHandler` 49, `BigliettoPdfQueueable` 15, `BigliettoPdfBatch` 9,
plus the three triggers at 22 between them.

Scope for the suite when it is commissioned has therefore widened from the
Biglietto stack to **the tranche stack as well**. See
[OI-50](OI-50%20Tranche%20object.md).
