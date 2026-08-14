---
id: OI-55
type: open-item
status: resolved
owner: ROMI
with: Elisa Migliano
org: both
raised: 2026-07-22
updated: 2026-08-14
source: meetings/results/2026-08-06-chiusura-punti-aperti.md
---

# OI-55 - No coherence control on bundle composition

Nothing prevents administration attaching an article that does not match the
bundle's category. Raised on 22 July with a proposed fix: categorise items
upstream at article-code creation — bundle-usable, generates-ticket,
bundle-only-hidden-from-tutors — the same lever as
[the product flags](OI-47%20Product%20flags%20at%20import.md).

**Resolved on 2026-08-06 by deciding not to fix it.** The team explicitly
confirmed **no rigid automated validation**: administration is responsible, and
eligibility is pre-constrained only by the product flags. Bundles are created
only in Salesforce and only by administration, which is what makes that
defensible.

Marked resolved because the decision was taken, not because the exposure went
away. The exposure is carried forward as
[an accepted risk](../risks/Risk%20-%20no%20coherence%20control%20on%20bundle%20composition.md) —
and note that the flags the decision leans on are
[set on zero products today](OI-47%20Product%20flags%20at%20import.md).
