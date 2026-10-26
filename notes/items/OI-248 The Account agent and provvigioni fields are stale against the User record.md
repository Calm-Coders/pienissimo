---
id: OI-248
type: open-item
status: open
owner: Aurel Mrruku
org: ROMI
raised: 2026-10-15
updated: 2026-10-15
depends_on: [OI-169]
source: notes/meetings/2026-10-15 Migrazione e Go-Live.md
---

# OI-248 - The Account agent and provvigioni fields are stale against the User record

**Changing the agent on an Account leaves `codice agente`, `categoria
provvigioni` and `zona` showing the previous agent's values. The order build no
longer reads them — it reads the User — so the order is correct and the screen
is wrong. Found on screen by the client during the 15/10 walkthrough.**

Found at [the 15/10 session](../meetings/2026-10-15%20Migrazione%20e%20Go-Live.md)
(`01:05`–`01:10`).

## What was seen

Aurel Mrruku changed the Account's agent to a different user live on screen.
Fabrizio Paganelli, reading the fields below: _"però qui è rimasto 19, vedo"_ —
the old agent code, after the agent had been replaced.

Aurel Mrruku confirmed it and explained why it does not break the order:

> _"qua sotto è rimasto, però io non fa riferimento a questo campo … quando creo
> l'ordine non mi baso [su] questi due campi … li aggiorno, metto il campo
> aggiornato, non prendo il campo dall'account, ma lo prendo il campo
> dall'utente."_

> _"questi sono i campi di creazione quando è stato creato l'utente … non c'è un
> aggiornamento di questi campi se cambi l'agente."_

He demonstrated the correct path: with the agent set to a different user, the
order picks up that user's code from the User record — _"prima era 19, adesso
prenderà 17"_ — because the lookup moved out of the trigger onto the User.

## What was agreed

Fabrizio Paganelli asked for them to be removed outright: _"Allora togli
addirittura i campi perché sennò facciamo casino"_ … _"se è così o me li nascondi
o me li metti aggiornati di là … perché sennò dopo vado via di testa io, lo sai.
Sono un amministrativo."_

Aurel Mrruku chose the second: **keep the fields and keep them current** —
_"Lo aggiorno anche nell'interfaccia … Te li metto aggiornati di là. Hai
ragione."_

Fabrizio Paganelli also confirmed the behaviour he expects, and the two agreed
they were describing the same thing: _"se io cambio l'agente mi deve cambiare
anche la categoria provvigioni cliente."_

A second, smaller ask in the same exchange: **`Agente ID` is not on the layout**
and he wants it visible — _"quello lì se me lo puoi mettere lì che io lo veda
anche nella schermata"_. Aurel Mrruku agreed.

## Why it is a row

🟢 **The integration is not affected.** The order reads the User, which is
correct, so nothing wrong has reached Mexal through this.

🔴 **But the Account screen is the administrative source of truth for the people
who will use it.** Fabrizio Paganelli intends to work commission and agent data
from this layout, and
[OI-247](OI-247%20Only%20the%20responsabile%20commerciale%20may%20edit%20the%20provvigioni%20fields.md)
makes the same section editable by the commercial lead. A field that silently
shows the former agent's commission category, in a section whose whole purpose is
commission, is the kind of defect that is discovered by someone acting on it.

⚠ **It also matters for the migration.** Historical orders are about to be loaded
with their agent references
([OI-244](OI-244%20Historical%20orders%20will%20be%20migrated%20from%20Mexal%20by%20spreadsheet.md));
the same session recorded that agents have carried different codes over time.
Stale per-Account copies of a code are the same class of problem at ~10,000-row
scale.

⚠ **The history is relevant.** The lookup living on the User rather than on the
Account is the resolution of
[OI-178](OI-178%20Two%20agent%20field%20implementations%20exist%20on%20two%20branches.md);
[OI-169](OI-169%20Agent%20code%20and%20commissions%20come%20from%20the%20customer%20record.md)
is the rule that agent code and commissions derive from the customer record.
These Account fields are the residue of the earlier implementation and nobody had
cleaned them up.

Closing it means the three fields either refreshed when the agent changes or
removed from the layout, plus `Agente ID` made visible — and a check that no
report, flow or formula reads the stale copies.
