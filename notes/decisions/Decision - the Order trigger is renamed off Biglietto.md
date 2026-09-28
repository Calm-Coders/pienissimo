---
id: decision-order-trigger-rename
type: decision
status: resolved
owner: Aurel Mrruku
org: ROMI
raised: 2026-09-07
updated: 2026-09-07
depends_on: [obj-biglietto]
blocks: []
source: Aurel Mrruku, direct instruction to the agent session, 2026-09-07
---

# Decision - the Order trigger is renamed off Biglietto

**The Order trigger and its handler drop `Biglietto` from their names.** They
are one-per-object components on `Order` and are named for the object, matching
every other trigger in the repository.

| Old name                           | New name                  |
| ---------------------------------- | ------------------------- |
| `OrderBigliettoTrigger`            | `OrderTrigger`            |
| `OrderBigliettoTriggerHandler`     | `OrderTriggerHandler`     |
| `OrderBigliettoTriggerHandlerTest` | `OrderTriggerHandlerTest` |

## Why

- **The old name is stale.** `Biglietto__c` was superseded by standard **Asset**
  on 2026-08-24 - see [the Biglietto build](../objects/The%20Biglietto%20build.md).
  The handler builds `List<Asset>`; no `Biglietto__c` remains in it. Only the
  `Product2.Genera_Biglietto__c` flag keeps the Italian domain term, correctly.
- **The old name was narrower than the behaviour.** The single Order trigger
  already dispatches Anticipay order automation and, since 2026-09-07,
  [event invitation creation](../flows/Proposed%20event%20invitations%20for%20participant%20registration.md)
  alongside ticket generation. A purpose-scoped name invites a second trigger on
  `Order`, which would make execution order undefined.

## The deploy is destructive, not additive

The org still carries `OrderBigliettoTrigger` **Active**. Deploying the renamed
components alone would leave **two triggers on `Order`**, both creating tickets
from the same confirmed order. The old three components must be deleted in the
same deployment, using
`manifest/order-trigger-rename-destructiveChanges.xml` with
`manifest/order-trigger-rename-empty-package.xml`.

Not yet deployed to any org. Source-only as of 2026-09-07.

## What was deliberately not changed

Historical records keep the old name, because it was the true name on the date
they describe: past `JOURNAL.md` entries, org coverage tables in
[the deploy risk](../risks/Risk%20-%20production%20deploy%20is%20blocked%20by%20Apex%20coverage.md)
and [OI-66](../items/OI-66%20No%20test%20classes%20for%20the%20Biglietto%20stack.md),
commit citations in [OI-53](../items/OI-53%20Asset%20generation%20rule.md), and
the preserved org snapshots under `.org-status-cache/`. `STATUS.md` describes
the org and stays correct until the destructive deploy runs.
