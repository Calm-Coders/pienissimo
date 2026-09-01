---
id: OI-66
type: open-item
status: superseded
owner: ROMI
org: ROMI
raised: 2026-08-03
updated: 2026-08-31
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

## 2026-08-26 - the numbers, restated

Re-measured read-only against **Pienissimo UAT**. Uncovered lines in the
project's own Apex, largest first: `QuoteTrancheController` **185**,
`BundleProductAssignmentController` 132, `OrderBigliettoTriggerHandler` 123,
`API_Callout_Engine` 109, `BigliettoDocuSignService` 94,
`BundleComponentTriggerHandler` 65, `BigliettoPdfService` 53,
`BigliettoDocuSignQueueable` 50, `BigliettoTriggerHandler` 49,
`BigliettoPdfQueueable` 15, `BigliettoPdfBatch` 9, plus the three triggers at 22
between them. Zero covered, everywhere.

One scoping change for whoever writes the suite: `QuoteTrancheController` is now
**in `force-app/`** (PR #12, 2026-08-26), so it can be read and tested from the
repository. The six Biglietto classes still cannot — they remain org-only, which
is why this item depends on
[the source-control risk](../risks/Risk%20-%20the%20Biglietto%20Apex%20stack%20is%20not%20in%20source%20control.md).

## 2026-08-31 - superseded: the stack this item covers no longer exists

**All six classes named at the top of this note, plus `BigliettoTrigger` and the
`BigliettoPdf` page, were deleted from Pienissimo UAT on 28 August.** The 31
August `org-status-check` counts 31 Apex classes where 28 August counted 37.

So this item closes without a line of test code being written, and **that is not
a good outcome** — the ~270 lines it tracked were never covered *and* are now
gone entirely, with
[no copy in source control anywhere](../risks/Risk%20-%20the%20Biglietto%20Apex%20stack%20is%20not%20in%20source%20control.md).
Nothing was tested; the subject was removed.

**What this changes for whoever writes the suite**, which is still one separate
late task and still not this note's to schedule:

- The brief is now **21 classes and 1,571 uncovered lines**, not 28 and 1,769.
  The entire 198-line reduction is the deleted Biglietto code — **no test was
  written**, so the apparent improvement is nothing of the kind.
- The three largest targets are now `WoocommerceOrderService` **396**,
  `QuoteTrancheController` **386** and `LeadConversionQueueable` **148**.
- ⚠ `WoocommerceOrderService` is the deployed WooCommerce class and it is
  [not in source control](../risks/Risk%20-%20a%20clean%20deploy%20would%20orphan%20the%20live%20WooCommerce%20endpoint.md),
  so the largest single test target cannot currently be read from the repository
  — exactly the condition that made this item unactionable for four weeks.

[OI-64](OI-64%20The%20bundle%20Apex%20test%20suite%20is%20broken.md) and
[the deploy risk](../risks/Risk%20-%20production%20deploy%20is%20blocked%20by%20Apex%20coverage.md)
are **unaffected and stay gating**. Coverage is still 0% against a 75% floor.
