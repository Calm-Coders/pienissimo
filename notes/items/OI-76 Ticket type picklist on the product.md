---
id: OI-76
type: open-item
status: open
owner: Fabrizio Paganelli
with: ROMI
org: both
raised: 2026-08-06
updated: 2026-08-15
source: meetings/results/2026-08-06-chiusura-punti-aperti.md
requirement: BIG-04
---

# OI-76 - Ticket type picklist on the product

**Ticket type becomes a picklist on the product record** — Gold, Silver,
Executive and so on — instead of being inferred from the product-code name. One
event can then carry distinct asset types.

This is the same move as
[the product flags](OI-47%20Product%20flags%20at%20import.md): stop reading meaning
out of a code string, put it in a field an admin can maintain. Taken together
they remove the last places where the article code is parsed rather than read.

Fabrizio Paganelli is to add the ticket-info fields **and the event flag** to
the product master. Neither exists yet.

The event flag is the more urgent half: it is what
[the asset generation rule](OI-53%20Asset%20generation%20rule.md) keys on to decide
that an order line produces a ticket, and what
[the nightly Mexal sync](OI-77%20Mexal%20event%20product%20creates%20the%20Campaign.md)
would use to auto-create a Campaign. Both are specified against a flag that has
not been created.
