---
id: OI-13
type: open-item
status: in-progress
owner: Andrea Di Cicco
with: Aurel Mrruku
org: ROMI
raised: 2026-07-02
updated: 2026-08-14
depends_on: [OI-48, OI-87]
source: meetings/open-items.md row 13
requirement: BUN-01
---

# OI-13 - Bundle effort estimate and client demo

The bundle solution: a ROMI effort estimate plus a working demo in the test
environment. The acceptance criterion was **product-level statistics via spread
prices**, and it is met — see
[the junction](../objects/The%20BundleComponent%20junction.md) and
`meetings/proposals/2026-07-16-bundle-spread-demo.md`.

**The client approved the model** in the week of 22–24 July: invoicing is per
**elementary product**, not a lump sum; the bundle name becomes the Mexal
description while code and due-date references stay at line level; **only
administration** may create bundles in Salesforce, single products keep coming
from Mexal. The 2026-08-06 session removed the duplicate stage-sale bundle
mechanism, moving that split onto
[opportunity typing](OI-70%20Performance%20Plus%20opportunity%20typing.md).

**Two things are still outstanding**, and they are not the hard parts:

1. **Show it to Pienissimo** — which needs
   [real prices](OI-87%20Real%20catalogue%20prices%20still%20outstanding.md) and
   [example bundle codes](OI-48%20Bundle-only%20article%20codes.md), or the demo
   runs on [invented numbers](../risks/Risk%20-%20placeholder%20prices%20could%20reach%20the%20client.md).
2. **Andrea Di Cicco's effort estimate**, outstanding since early July.

The blueprint must flag "in giallo fosforescente" that BLO blocks and €0
omaggio lines disappear at invoicing.
