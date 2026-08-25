---
id: risk-orderitem-tranche-undeployed
type: risk
status: open
severity: high
owner: Aurel Mrruku
org: ROMI
raised: 2026-08-25
updated: 2026-08-25
depends_on: [OI-50]
blocks: [OI-75, go-live]
source: org-status-check against Pienissimo UAT, 2026-08-25
evidence: sf sobject describe OrderItem vs force-app/main/default/objects/OrderItem/fields/
---

# Risk - OrderItem Tranche is in the repository but not in the org

**`OrderItem.Tranche__c` is committed to `force-app/` and does not exist in
Pienissimo UAT.** This is the reverse of every other divergence in this project,
and it is the more dangerous direction.

| Side           | `OrderItem` custom fields            |
| -------------- | ------------------------------------ |
| `force-app/`   | `Data_Scadenza__c`, **`Tranche__c`** |
| Pienissimo UAT | `Data_Scadenza__c`                   |

## Why it matters more than a missing field usually would

[OI-50](../items/OI-50%20Tranche%20object.md) settled that when an accepted
quote generates the Order, **the tranche reference and payment date propagate to
the corresponding Order Items**, and that those copied values are the
operational keys used to group what was sold and reconcile the lines with Mexal.
`OrderItem.Tranche__c` is that propagation. Without it in the org:

- nothing carries the tranche from Quote to Order in UAT;
- Mexal reconciliation at line level (DM-17, ORD-01) cannot be demonstrated;
- [ticket availability](../items/OI-75%20Ticket%20availability%20rule.md), which
  keys release to a fully paid tranche, has no path from payment back to the
  ticket.

## Why it is easy to miss

The usual failure mode here is the org holding things the repository does not —
[the Biglietto stack](Risk%20-%20the%20Biglietto%20Apex%20stack%20is%20not%20in%20source%20control.md),
now the tranche controller and LWC. Anyone reading `force-app/` to answer "is
tranche propagation built?" finds the field, the `QuoteLineItem.Tranche__c`
twin, and the object, and concludes yes. **The repository is the optimistic
source here, not the conservative one.**

`sf project retrieve preview` does not catch it either: Pienissimo UAT is a
partial sandbox with no source tracking and the command fails with
`NonSourceTrackedOrgError`. It was found by comparing `sf sobject describe`
output against the field directory, component by component.

## What closes it

Deploy the field, or state that propagation is deliberately deferred. Either is
fine; the current state — committed, undeployed, and reading as done — is not.
This is a deploy action and belongs to Aurel Mrruku; **this check is read-only
and did not perform it.**
