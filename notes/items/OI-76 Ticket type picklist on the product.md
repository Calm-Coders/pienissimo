---
id: OI-76
type: open-item
status: open
owner: Fabrizio Paganelli
with: ROMI
org: both
raised: 2026-08-06
updated: 2026-08-24
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

## ✅ 2026-08-24 - the registry settles the vocabulary, not the field

[`Prodotti e Bundle.xlsx`](../The%20Prodotti%20e%20Bundle%20workbook.md) was
read on 2026-08-24 and it does answer the tier question the note above parks —
though only as evidence, not as a delivered field.

**The tiers that exist in the client's registry are `EXECUTIVE`, `GOLD` and
`DIAMOND`.** Across all 29 articles:

- Food Marketing Festival carries all three.
- Camerieri Venditori carries **`EXECUTIVE` only**.
- The other seven events carry no tier at all.

So both contested values are wrong. **`Dinamond` is `Diamond` misspelt** — the
20 August diagram edit was a typo, not a new tier. And **`Silver` does not exist
anywhere in the registry**; the minuted 06 August line _"camerieri venditori
Silver ha un codice diverso da camerieri venditori gold"_ names two tiers for an
event that has **neither** — Camerieri Venditori has one tier, `EXECUTIVE`. The
example was illustrative and was read as literal.

⚠ **Tier is not a uniform picklist.** Seven of nine selling events have no tier
at all, and only one event has more than one. A restricted picklist of three
values applied to every product would be mostly blank and would invite an admin
to invent a tier where the client has none.

### The item stays open, because the field still does not exist

`Lista Prodotti` has **four columns** — `LIVELLO_6`, `_ARCOD`, `Articolo`,
`Prezzo Listino`. There is **no ticket-type column and no event flag**. The tier
is still readable only by parsing the article name string, which is the precise
practice this item exists to end. Fabrizio Paganelli has not added the fields to
the product master; the workbook is the proof, not the delivery.

On the Salesforce side the flag half **is already built** and the record did not
say so: `Product2.Genera_Biglietto__c` exists in `force-app`, as does
`Solo_Bundle__c` for [OI-47](OI-47%20Product%20flags%20at%20import.md). What is
missing is anything upstream to populate them from — another instance of
[the build running ahead of the record](../objects/The%20build%20ahead%20of%20the%20record.md).

Ask for the tier column at the **2026-08-26 Mexal review**, and ask for it as a
column in the registry rather than as a list of values.
