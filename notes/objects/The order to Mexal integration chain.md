---
id: obj-order-mexal-chain
type: object
status: active
owner: Aurel Mrruku
org: ROMI
raised: 2026-09-14
updated: 2026-09-14
depends_on: [OI-116, OI-117, OI-125]
blocks: [go-live]
requirement: INT-01
source: org-status-check against Pienissimo UAT, 2026-09-14 10:51Z
evidence: Tooling ApexClass CreatedDate/Body, CronTrigger, AsyncApexJob, Integration_Configuration2__c row query
---

# The order to Mexal integration chain

**The whole order-to-Mexal integration was written on 2026-09-14 between 09:12
and 10:33 UTC, directly in the Pienissimo UAT org, by Aurel Mrruku. None of it
is in this repository.**

Found by the org-status-check of 2026-09-14. Nine Apex classes were created in
the org that morning and exist in no branch of this repository; three Mexal
classes that _are_ in the repository were edited in the org on top of them.

## What was built

| Class in the org                 | Created (UTC) | Role                                          |
| -------------------------------- | ------------- | --------------------------------------------- |
| `OrderMexalIntegrationService`   | 09:12         | Orchestrates the chain; owns each step        |
| `OrderMexalIntegrationQueueable` | 09:12         | Chains the steps, one queueable per step      |
| `MexalOrderSendService`          | 09:12         | Sends the order itself to Mexal               |
| `MexalHttpClient`                | 09:44         | The transport, replacing direct callout calls |
| `MexalIntegrationLogger`         | 09:44         | Writes `Integration_Log__c`                   |
| `MexalCustomerSyncBatch`         | 09:44         | The nightly anagrafica batch                  |
| `MexalCustomerSyncScheduler`     | 09:44         | Its `Schedulable`                             |
| `MexalSyncCursorService`         | 09:44         | The sync watermark                            |
| `MexalCustomerUpdateQueueable`   | 10:33         | Pushes an admin-field edit back to Mexal      |

Two `Order` fields were added with them and are also org-only:
`Mexal_Integration_Status__c` (picklist) and `Mexal_Order_Number__c`.

## The chain implements the agreed sequence exactly

`OrderTriggerHandler.afterInsert` in the org calls
`OrderMexalIntegrationService.enqueueForCreatedOrders`. The queueable then runs
one step per job:

```
Mark Running -> [Anticipay, first order only] -> Mexal Customer -> Mexal Order
```

🟢 **This is
[the sequencing decision of 11 September](../decisions/Decision%20-%20first%20order%20runs%20Anticipay%20before%20Mexal%20customer%20creation.md),
built.** "First order" is resolved by querying for earlier orders on the same
Account, not assumed. The Anticipay step is skipped when
`Account.Anticipay_Consolidato__c` is already true, and **its failure is
non-blocking** — it logs and the Mexal chain continues.

🟢 **[OI-125](../items/OI-125%20Mexal%20customer%20update%20needs%20a%20PUT%20method.md)
has its caller at last.** `runMexalCustomerStep` calls
`MexalCustomerCreateService.createForAccount` when the Account has no Mexal code
and it is the first order, and `updateForAccount` — the PUT — when it already
has one. The block comment that stood in for this on 11 September is gone. A
non-first order with no Mexal code throws rather than guessing.

🟢 Failures are caught per step, written to `Integration_Log__c` with the step
name, and **the remaining orders still run** — one bad order does not strand the
batch.

## What is still missing

🔴 **Nothing is scheduled.** `MexalCustomerSyncScheduler` exists as a class, and
the org holds **seven `CronTrigger` rows, all Salesforce platform jobs** — comm
sitemap, SRT, ReportType, Metalytics. No Mexal job is scheduled.
[OI-116](../items/OI-116%20Nightly%20Mexal%20to%20Salesforce%20anagrafica%20sync.md)
therefore keeps its diagnosis: **a sync with no schedule**. The watermark it was
blocked on now exists in code as `MexalSyncCursorService`; the window is still
unchosen.

🔴 **The chain has never run.** All **30** orders in UAT have an empty
`Mexal_Integration_Status__c`, and `AsyncApexJob` for the last seven days holds
no `OrderMexalIntegrationQueueable` row. Only `MexalCustomerUpdateQueueable` has
executed, **once**. Two Accounts carry a Mexal code.

🔴 **It is not in source control.** See
[the risk](../risks/Risk%20-%20the%20Mexal%20order%20integration%20exists%20only%20in%20the%20org.md).

## What it answers about OI-117

[OI-117](../items/OI-117%20Administrative%20fields%20lock%20once%20the%20Mexal%20customer%20code%20is%20set.md)
asked for a **lock**: administrative fields read-only once the Mexal code is
set. The org now does the **opposite**. `AccountTriggerHandler.afterUpdate`
watches `Email__c`, `Phone`, `Partita_IVA__c` and `Name` on an Account that
already carries a Mexal code and **enqueues `MexalCustomerUpdateQueueable` to
push the edit to Mexal**.

⚠ That is a coherent design — Salesforce stays editable and Mexal is kept in
step — but **it is not the design that was agreed on 3 September, and no minute
records the change**. It also does not remove the silent-overwrite exposure
OI-117 exists for: the nightly inbound batch and this outbound push now write
the same fields in opposite directions, and no conflict rule has been chosen.
