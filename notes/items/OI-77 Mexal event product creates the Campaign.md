---
id: OI-77
type: open-item
status: open
owner: ROMI
org: ROMI
raised: 2026-08-06
updated: 2026-08-14
depends_on: [OI-76]
source: meetings/results/2026-08-06-chiusura-punti-aperti.md
---

# OI-77 - Mexal event product creates the Campaign

**A Mexal event product auto-creates the matching Salesforce Campaign** on the
nightly product sync, so attendance indexes against the campaign when the QR is
scanned.

One campaign per event edition; campaign members are participants carrying a
check-in status of participated or no-show. That is the data source for the
no-show and room-composition analytics the project was justified by.

Depends on the **event flag** on the product master, which
[OI-76](OI-76%20Ticket%20type%20picklist%20on%20the%20product.md) asks Fabrizio
Paganelli to create and which does not exist.

Note the overlap with
[OI-53](OI-53%20Asset%20generation%20rule.md), where an **order** containing an
event product creates the Campaign if absent. Two different triggers can create
the same record — the nightly product sync and the order — so whichever is
built second has to be idempotent. Nobody has written down which is
authoritative, and `OrderBigliettoTrigger` was already committed on 4 August
without this rule being decided.

Nightly product sync mechanics:
[the Mexal integration](../flows/The%20Mexal%20integration.md).
