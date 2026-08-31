---
id: risk-biglietto-diverged
type: risk
status: open
severity: medium
owner: Aurel Mrruku
org: ROMI
raised: 2026-08-03
updated: 2026-08-24
depends_on: [OI-41]
source: meetings/proposals/2026-07-13-asset-ticket-data-model.md
---

# Risk - the Biglietto object diverged from the approved proposal

ROMI's own data-model proposal of 2026-07-13
([OI-41](../items/OI-41%20Asset%20and%20ticket%20data%20model.md)) specified the
**standard Asset object** — one record per ticket, a five-status lifecycle, a
flow-synced CampaignMember. What was built is a **custom object**,
[`Biglietto__c`](../objects/The%20Biglietto%20build.md).

**The object choice was resolved on 2026-08-24: the target is the standard
Salesforce Asset object.** The direct instruction did not identify the
decision-maker. The current custom build is therefore an implementation gap,
not an alternative awaiting ratification.

**Why it matters beyond naming.** Standard Asset carries product, account,
contact, serial number, install/usage dates, lifecycle status and a hierarchy
out of the box, and reports and Service features understand it. A custom object
means rebuilding whatever of that is needed, and the analytics goal — no-show
and room-composition dashboards indexed against campaigns — is exactly the kind
of reporting that leans on standard objects.

The org and repository still contain `Biglietto__c`, including six active Apex
classes in UAT for DocuSign and PDF generation. Before replacement, ROMI must
map every field, relationship and automation to Asset and decide which existing
logic is migrated, rewritten or retired. The effort has not been estimated.

Do not build further ticket functionality on `Biglietto__c` as though it were
the target model. The migration plan must be settled before the
[dedicated asset-flow review](../items/OI-82%20Asset%20flow%20needs%20a%20dedicated%20review.md)
adds more work on top of the custom object.
