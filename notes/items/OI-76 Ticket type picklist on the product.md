---
id: OI-76
type: open-item
status: open
owner: Fabrizio Paganelli
with: ROMI
org: both
raised: 2026-08-06
updated: 2026-08-20
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

## ⚠ 2026-08-20 - a tier name changed in the diagram, unminuted

The values are **not settled**, and one of them just moved. On 20 August the
master design file's product-code example changed from
_"Camerieri Venditori 26 **Silver**"_ to _"Camerieri Venditori 26 **Dinamond**"_
— see [the newest design diagram](../The%20newest%20design%20diagram.md).

The 19 August standalone drawing still said `Silver`, and so does the minuted
06 August session, where Elena Spini says _"camerieri venditori Silver ha un
codice diverso da camerieri venditori gold."_ So an **unminuted diagram edit has
replaced a term that a meeting put on the record.** `Dinamond` is almost
certainly _Diamond_ misspelt.

**Do not put either value into a picklist yet.** This picklist's values come
from Fabrizio Paganelli's product master, which does not exist; a tier list
reverse-engineered from example strings in a drawing would be guesswork. Ask for
the tier list when asking for the fields — and note that the tiers may be
exactly what
[`Prodotti e Bundle.xlsx`](../The%20Prodotti%20e%20Bundle%20workbook.md) answers,
if anyone opens it.

The event flag is the more urgent half: it is what
[the asset generation rule](OI-53%20Asset%20generation%20rule.md) keys on to decide
that an order line produces a ticket, and what
[the nightly Mexal sync](OI-77%20Mexal%20event%20product%20creates%20the%20Campaign.md)
would use to auto-create a Campaign. Both are specified against a flag that has
not been created.
