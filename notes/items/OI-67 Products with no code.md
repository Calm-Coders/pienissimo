---
id: OI-67
type: open-item
status: open
owner: ROMI
with: Fabrizio Paganelli
org: both
raised: 2026-08-03
updated: 2026-08-14
depends_on: [OI-64]
source: meetings/open-items.md row 67
---

# OI-67 - Products with no code

**31 `Product2` records have no `Code__c`** although the field is now required
— grandfathered rows that predate the change, including **all three bundle
records**.

Any attempt to edit and save one fails validation. That includes the bundles,
which are the records administration is most likely to touch: correcting
[ACADEMY 2026](OI-65%20ACADEMY%202026%20no%20longer%20reconciles.md) means saving
a record that cannot currently be saved.

Decide whether to **backfill** the codes or **exempt** the affected rows. A
backfill needs Fabrizio Paganelli, since the codes have to match the Mexal
article master — the same registry that owes
[the bundle-only codes](OI-48%20Bundle-only%20article%20codes.md).

Same root cause as
[OI-64](OI-64%20The%20bundle%20Apex%20test%20suite%20is%20broken.md): making
`Code__c` required was done without sweeping either the existing data or the
test factories.
