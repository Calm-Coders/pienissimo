---
id: OI-41
type: open-item
status: superseded
owner: Aurel Mrruku
org: ROMI
raised: 2026-07-13
updated: 2026-08-14
source: meetings/proposals/2026-07-13-asset-ticket-data-model.md
---

# OI-41 - Asset and ticket data model

ROMI's draft proposal of 2026-07-13: use the **standard Asset** object, one
record per ticket, a five-status lifecycle, a flow-synced CampaignMember. To be
validated with Elena Spini and Andrea Di Cicco, then folded into the
[data model workbook](OI-24%20Data%20model%20workbook.md).

**The review never happened, and the build went another way.** `Biglietto__c`
is a custom object — see
[the Biglietto build](../objects/The%20Biglietto%20build.md) and
[the divergence risk](../risks/Risk%20-%20the%20Biglietto%20object%20diverged%20from%20the%20approved%20proposal.md).

Marked `superseded` rather than resolved because the item asked for a decision
and got a fait accompli. The proposal document is still the most complete
written treatment of the ticket data model and is worth reading before the
[dedicated asset-flow review](OI-82%20Asset%20flow%20needs%20a%20dedicated%20review.md),
provided you read it as a rejected alternative rather than as the current
design.

Superseded in substance by
[OI-74](OI-74%20Asset%20state%20machine.md) for the lifecycle and
[OI-53](OI-53%20Asset%20generation%20rule.md) for creation.
