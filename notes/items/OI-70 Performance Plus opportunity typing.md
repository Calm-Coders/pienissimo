---
id: OI-70
type: open-item
status: in-progress
owner: ROMI
org: both
raised: 2026-08-06
updated: 2026-08-14
source: meetings/results/2026-08-06-chiusura-punti-aperti.md
---

# OI-70 - Performance Plus opportunity typing

A Performance Plus opportunity **must be typed by the tutor at creation** —
**attivazione** versus **rinnovo** — because contract generation depends on it.
Manual by design; no attempt to infer it.

The field exists: `Opportunity.Tipo_Opportunita__c` was committed on 7 August,
after the last org check and with no tracker row noting it — see
[the build ahead of the record](../objects/The%20build%20ahead%20of%20the%20record.md).

What remains is the part that makes it work: **making it mandatory** at
creation for the right record type, and wiring it to
[contract auto-generation](OI-51%20Contract%20auto-generation%20keyed%20to%20product%20code.md),
which is keyed to the product code rather than to order status.

The same session used opportunity typing to carry the **stage-sale versus
tutor-recall split**, replacing a second bundle mechanism that was dropped. So
this field now does two jobs, and only one of them is written down as a
requirement.
