---
id: risk-biglietto-diverged
type: risk
status: open
severity: medium
owner: Aurel Mrruku
org: ROMI
raised: 2026-08-03
updated: 2026-08-14
depends_on: [OI-41]
source: meetings/proposals/2026-07-13-asset-ticket-data-model.md
---

# Risk - the Biglietto object diverged from the approved proposal

ROMI's own data-model proposal of 2026-07-13
([OI-41](../items/OI-41%20Asset%20and%20ticket%20data%20model.md)) specified the
**standard Asset object** — one record per ticket, a five-status lifecycle, a
flow-synced CampaignMember. What was built is a **custom object**,
[`Biglietto__c`](../objects/The%20Biglietto%20build.md).

No meeting minuted the change. The proposal was never formally reviewed by
Elena Spini and Andrea Di Cicco as OI-41 asks, so the divergence was never
approved or rejected — it simply happened, and the recaps still describe the
design in terms of assets.

**Why it matters beyond naming.** Standard Asset carries product, account,
contact, serial number, install/usage dates, lifecycle status and a hierarchy
out of the box, and reports and Service features understand it. A custom object
means rebuilding whatever of that is needed, and the analytics goal — no-show
and room-composition dashboards indexed against campaigns — is exactly the kind
of reporting that leans on standard objects.

It also leaves the written record inconsistent: `REQUIREMENTS.md`, the
requirement register and the open-items tracker discuss assets; the org and the
repository contain `Biglietto__c`.

**The decision is probably fine and simply needs to be made and recorded.**
Either ratify the custom object and correct the documents, or state why the
standard object should have been used — before the
[dedicated asset-flow review](../items/OI-82%20Asset%20flow%20needs%20a%20dedicated%20review.md)
designs further work on top of it.
