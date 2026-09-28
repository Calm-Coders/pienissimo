---
id: risk-mexal-chain-org-only
type: risk
status: resolved
severity: high
owner: Aurel Mrruku
org: ROMI
raised: 2026-09-14
updated: 2026-09-15
depends_on: [OI-116, OI-125]
blocks: [go-live]
requirement: [INT-01, INT-05]
source: org-status-check against Pienissimo UAT, 2026-09-14 10:51Z
evidence: Tooling ApexClass CreatedDate and Body vs force-app at cc3c571; FieldDefinition on Order
---

# Risk - the Mexal order integration exists only in the org

**Nine Apex classes and two `Order` fields implementing the entire
order-to-Mexal chain were created in Pienissimo UAT on 2026-09-14 and are in no
branch of this repository.** Roughly 28,000 characters of Apex, written between
09:12 and 10:33 UTC. See
[the build](../objects/The%20order%20to%20Mexal%20integration%20chain.md).

This is the **fourth** instance of the same pattern, and it is by far the
largest.

| Component                                  | Discovered     | Outcome                                                                                              |
| ------------------------------------------ | -------------- | ---------------------------------------------------------------------------------------------------- |
| The Biglietto Apex stack, 7 components     | 2026-08-31     | Deleted from the org 28 Aug. **Gone** — never in git                                                 |
| A second Flow                              | 2026-08-31     | Deleted with no source copy                                                                          |
| `Anticipay` / `DocuSign` named credentials | 2026-09-02     | Still org-only — [the risk](Risk%20-%20integration%20credentials%20exist%20only%20in%20the%20org.md) |
| **The order-to-Mexal chain, 9 classes**    | **2026-09-14** | **Org-only today**                                                                                   |

## Why this one is worse than its predecessors

- **It is the largest single body of unversioned work on the project** — more
  Apex than the repository's three Mexal classes combined.
- **It is on the critical path.** It is the integration Fase 1 exists to
  deliver, and it implements
  [the Anticipay-before-Mexal decision](../decisions/Decision%20-%20first%20order%20runs%20Anticipay%20before%20Mexal%20customer%20creation.md)
  and the missing caller from
  [OI-125](../items/OI-125%20Mexal%20customer%20update%20needs%20a%20PUT%20method.md).
  Losing it loses the answers, not just the code.
- **The repository actively contradicts it.** `force-app/`'s
  `OrderTriggerHandler.afterInsert` calls
  `AnticipayOrderAutomation.enqueueForFirstOrders`; the org's calls
  `OrderMexalIntegrationService.enqueueForCreatedOrders`. **A deploy from
  `DevMain` today would silently revert the chain to the old behaviour** and
  leave nine classes orphaned, referencing a handler that no longer calls them.
- **Three repository classes were edited in the org on top of it** —
  `MexalCustomerCreateService`, `MexalCustomerSearchService` and
  `MexalSearchCalloutService` all now differ from their committed source. The
  create service was repointed from `MexalSearchCalloutService.createCustomer`
  to `MexalHttpClient.createCustomer`, a class that does not exist in git.

## The mitigation is a retrieve, and it is cheap

`sf project retrieve start` for the nine classes, the two `Order` fields and the
three edited classes, on a branch, today. The work is written and tested by
hand; only its custody is at risk. Every week this stays org-only, the divergence
between `force-app/` and the org grows and the retrieve gets harder to review.

⚠ **Do not deploy `DevMain` to this org before the retrieve.** That is the
specific action that destroys the work.

## 2026-09-14 evening — the retrieve happened, on a branch, seven hours later

`e06a1b4` (Anita Aga, pushed 18:05 CEST to `DevAnita`, **PR #43 opened 16:06Z and
still open**) is the retrieve this risk asked for. **40 files, +2,057 / −143.**

🟢 **Eight of the nine org-only classes are now in `force-app/`** —
`OrderMexalIntegrationService`, `OrderMexalIntegrationQueueable`,
`MexalOrderSendService`, `MexalCustomerSyncBatch`, `MexalCustomerSyncScheduler`,
`MexalSyncCursorService`, `MexalCustomerUpdateQueueable`, `MexalIntegrationLogger`
— together with `Order.Mexal_Integration_Status__c` and
`Order.Mexal_Order_Number__c`.

🟢 **The contradiction is resolved in the right direction.**
`OrderTriggerHandler.afterInsert` now calls
`OrderMexalIntegrationService.enqueueForCreatedOrders`, and
`AnticipayOrderAutomation.cls` is **deleted**. The "a deploy from `DevMain`
silently reverts the chain" failure mode ends when this merges.

🟢 **More arrived than was org-only this morning** — an active Account validation
rule ([OI-117](../items/OI-117%20Administrative%20fields%20lock%20once%20the%20Mexal%20customer%20code%20is%20set.md)'s
lock), a second batch pair for articles, four watermark fields on
`Integration_Configuration2__c`, and both named credentials
([the credentials risk](Risk%20-%20integration%20credentials%20exist%20only%20in%20the%20org.md)).

### What this does not close

- 🔴 **`MexalHttpClient` is in neither the commit nor any reference in it.** The
  morning check recorded that class in the org and recorded
  `MexalCustomerCreateService` repointed onto it. The committed
  `MexalCustomerCreateService` names no `MexalHttpClient` at all, so **what was
  committed is not byte-identical to what is running** — it is a reconciled
  version, not a raw retrieve. ⚠ Inferred by comparing the 14/09 org record with
  this commit; **the org was not re-opened tonight** and the next
  `org-status-check` should confirm whether an orphaned `MexalHttpClient` is still
  live in UAT.
- 🔴 **It is unmerged.** `DevMain` at `dc0c824` still carries the old
  `OrderTriggerHandler` and none of the nine classes. **Until PR #43 merges, every
  sentence of this risk still holds for `DevMain`.**
- 🔴 **No review.** PR #43 was opened 53 seconds after the push, with the title
  "Dev anita" and no description — the third consecutive Mexal PR with no
  description. It is, at least, the first not merged within seven minutes.

**Status moves to in-progress.** It closes when PR #43 merges and an
`org-status-check` confirms `force-app/` and the org agree.

## 2026-09-15 — PR #43 merged. This risk is closed.

**`23f1375`, 2026-09-15 08:07:04Z**, merged PR #43 into `DevMain`. Every sentence
above that was qualified with "until PR #43 merges" is now discharged:

- 🟢 **`DevMain` carries the chain.** `OrderTriggerHandler.afterInsert` calls
  `OrderMexalIntegrationService.enqueueForCreatedOrders` on the line everything is
  built from. `AnticipayOrderAutomation.cls` is gone. **The "a deploy from
  `DevMain` silently reverts the chain" failure mode no longer exists.**
- 🟢 **The 2026-09-15 `org-status-check` confirms it from the other side**: all 48
  repository Apex classes and triggers are deployed, and 44 of them are
  token-equivalent to UAT. That is the confirmation this note said it needed.
- 🟢 **`MexalHttpClient` is absent from both sides.** The same check reports it in
  neither the repository nor UAT, so the orphaned-class question raised on 14/09
  resolves as **no orphan** — it was a transient the reconciliation removed.

⚠ **One commit rode in with the merge and is a finding of its own.** `1830fce`
(Anita Aga, 10:02:54 CEST, five minutes before the merge) adds an
`isSandbox()` early return to `enqueueForCreatedOrders`, so the chain this risk
fought to preserve **does not execute in UAT at all** —
[OI-137](../items/OI-137%20The%20order%20to%20Mexal%20chain%20is%20disabled%20in%20every%20sandbox.md).
Custody is solved; exercisability is now the open question.

⚠ **The pattern this note tracks is not closed, only this instance.** The
2026-09-15 check still finds org-only metadata in UAT: a `ContactTriggerHandler`
and `ContactTrigger`, one Account field and four invitation fields — though PR #44,
merged the same afternoon, brought the Contact automation and the invitation
fields into source. The DocuSign credentials remain org-only
([the credentials risk](Risk%20-%20integration%20credentials%20exist%20only%20in%20the%20org.md)).

**Status: resolved.**
