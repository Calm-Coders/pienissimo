---
id: OI-43
type: open-item
status: open
owner: ROMI
with: Fabrizio Paganelli
org: both
raised: 2026-07-16
updated: 2026-08-14
blocks: [OI-65]
source: meetings/open-items.md row 43
requirement: BUN-04
---

# OI-43 - Spread variance does not block saving

Decide whether a non-zero `Spread_Variance__c` should prevent a bundle being
saved.

Today the variance is **displayed** — red in the configurator, a field on the
record — but nothing stops a bundle whose spreads do not add up to its selling
price. Such a bundle is sellable, and every per-product revenue figure derived
from it is silently wrong.

When this was raised on 16 July it was a prediction. It is no longer:
[ACADEMY 2026 now sits at −1.422](OI-65%20ACADEMY%202026%20no%20longer%20reconciles.md)
in UAT, with the wrong components attached, in a small careful team, before
go-live volumes.

The 2026-08-06 session separately decided **not** to constrain bundle
composition
([the accepted risk](../risks/Risk%20-%20no%20coherence%20control%20on%20bundle%20composition.md)).
If that stands and this one is also left open, nothing at all guards the
integrity of a bundle. Deciding this one is the cheaper of the two — a
validation rule on the header, not a rethink of who may build bundles.
