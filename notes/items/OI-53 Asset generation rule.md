---
id: OI-53
type: open-item
status: in-progress
owner: ROMI
org: ROMI
raised: 2026-07-22
updated: 2026-08-14
source: meetings/open-items.md row 53
requirement: BIG-02
---

# OI-53 - Asset generation rule

Every order containing an "evento" product auto-creates a **Campaign** if one
does not exist, plus **one Asset per event article code** — including
multi-event bundles and tutor-entered orders.

Terminology fixed in the same session: **the Asset is the record, the QR is a
value inside it.**

**Partly built, and the tracker does not know.** The 2026-08-03 org check
concluded "nothing creates a Biglietto from an Order". On 4 August
[Anita Aga](../people/Anita%20Aga%20-%20Salesforce%20developer%20ROMI.md)
committed `OrderBigliettoTrigger`, its handler and a test class — _"Added logic
for biglietto creation after order confirmed"_. See
[the build ahead of the record](../objects/The%20build%20ahead%20of%20the%20record.md).

What has **not** been verified is whether that trigger implements this rule or
a simpler one: campaign auto-creation, the per-event-code fan-out on bundles,
and the tutor-entered path all need checking against the code before this item
is closed. The companion rule that
[a Mexal event product creates the Campaign](OI-77%20Mexal%20event%20product%20creates%20the%20Campaign.md)
on nightly sync is separate and untouched.
