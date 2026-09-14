---
id: risk-mexal-chain-org-only
type: risk
status: open
severity: high
owner: Aurel Mrruku
org: ROMI
raised: 2026-09-14
updated: 2026-09-14
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
