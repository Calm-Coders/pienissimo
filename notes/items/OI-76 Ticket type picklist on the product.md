---
id: OI-76
type: open-item
status: resolved
owner: Fabrizio Paganelli
with: ROMI
org: both
raised: 2026-08-06
updated: 2026-09-02
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

## 2026-08-24 - the 20 August client session ruled on it

Recovered on 2026-08-24: the [20 August asset session](../meetings/2026-08-20%20Flusso%20Asset%20Biglietti.md) took the decision
this item has been waiting for, and minuted it **to the client** the same
evening.

**The "tipo biglietto" field is added and maintained manually on the Salesforce
side.** The reason is a hard constraint Fabrizio Paganelli stated in that
meeting: **Mexal supports at most three article classifications**, which cannot
carry event, ticket type and variants (omaggio, aggiuntivo) at once. So the
field cannot come down from the registry the way
[the product flags](OI-47%20Product%20flags%20at%20import.md) were meant to.

- **Owner of keeping it current: amministrazione — Fabrizio Paganelli and Elisa
  Migliano**, with periodic verification reminders.
- **The one-off mass update of existing products at go-live is ROMI's**, so it
  does not land on Rebecca Marmo.

This resolves the _ownership_ question and reverses the assumption above that the
values would arrive as a registry column. **Do not ask for a tier column at the
26 August review** — ask instead for the agreed value list, because the client
has now accepted that the list lives in Salesforce.

**Still open**, and the reason this item is not resolved: the field does not
exist in `force-app/`, and the value list has never been written down. The
registry evidence from `Prodotti e Bundle.xlsx` (`EXECUTIVE`, `GOLD`, `DIAMOND`,
with seven of nine events carrying no tier) remains the best available basis, but
nobody has ratified it as the picklist.

⚠ Also unresolved and now explicitly parked in the minute: whether this same
product-master field covers the **marketing segmentation** need (tags vs
segments). Assigned in the minute to "Fabrizio ROMI" —
[Fabrizio Mastracci](../people/Fabrizio%20Mastracci%20-%20marketing%20automation%20ROMI.md),
not Paganelli.

## 2026-08-26 - the tiers are confirmed out loud, the carrier is not

At the [26 August Mexal review](../meetings/2026-08-26%20Review%20Temi%20Integrazione%20Mexal.md),
Fabrizio Paganelli listed the tiers from memory when Aurel Mrruku asked how many
there were: **_"c'è Executive… Gold e Diamond."_**

That is the registry's list exactly. **`Silver` and `Dinamond` are both dead** —
the first was an illustrative example read as literal in the 06 August minute, the
second a typo in the 20 August diagram. Neither needs chasing again.

**The carrier is still undecided.** Fabrizio Paganelli offered Mexal's `gruppo
merceologico` — hierarchical, parent/child levels — as the field that could hold
the ticket type, and Andrea Di Cicco tested it live: the code came over the API as
`GRP merch`, but **the level did not**. Aurel Mrruku pushed the other way,
preferring a dedicated field once he heard there were three values —
_"se sono tre meglio se lasciamo un campo a sé"_ — and the discussion ended with
Fabrizio Paganelli saying _"facciamo una prova"_ rather than a decision.

So the record now holds **two answers to where ticket type lives**: the
20 August client minute says Salesforce, maintained by hand; the 26 August session
put Mexal's `gruppo merceologico` back on the table without retracting it. **Later
evidence does not win here** — the 26 August discussion did not conclude. Treat
the 20 August ruling as standing and the Mexal option as an open alternative.

⚠ Whichever way it lands, [OI-98](OI-98%20The%20Mexal%20article%20registry%20is%20being%20re-created.md)
governs the timing: the article registry is being re-created, and the tier values
this note cites were parsed from an extract of the registry being replaced.

## 2026-09-02 - assigned as a build action, and the first values arrived

Two things landed on the same day.

**The 2 September meeting turned this into an assigned action on Aurel Mrruku** -
"Aggiungere su Salesforce il campo Tipo Biglietto modificabile esclusivamente
dagli amministratori di sistema"
([the meeting](../meetings/2026-09-02%20Follow-up%20Anagrafica%20Articoli.md)).
That confirms the 24 August design - a manually maintained Salesforce field owned
by amministrazione - and adds the access rule: **system administrators only**.
⚠ Recorded from Gemini notes; whether it is a picklist or free text was not
minuted.

**The first values are known.** `Anagrafica Articoli.xlsx` carries a
`Tipo Biglietto` column with three values - **`Executive`, `Diamond`, `Gold`** -
populated on **13 of 43 rows** and empty on the other 30. It applies to exactly
two events: Camerieri Venditori (Executive only) and Food Marketing Festival (all
three). So the field is **sparse by design**, not incompletely filled: most
events have no tiers.

**The field does not exist.** Verified 2026-09-02 by Tooling `FieldDefinition`
against Pienissimo UAT and by inspection of `force-app/`: `Product2` has no
`Tipo_Biglietto__c` in either. `Tipologia__c` (Text 255) exists, but nothing in
the record establishes it as the ticket type and it should not be assumed to be.

Until the field exists, the 13 rows that carry a tier **cannot be loaded with
their tier**, and that is one of the two things blocking
[the workbook](../The%20Anagrafica%20Articoli%20workbook.md) from going into the
org.

## 2026-09-02 - built

`Product2.Tipo_Biglietto__c` exists: **restricted picklist**, values
`Executive` / `Diamond` / `Gold`, deployed to Pienissimo UAT and committed to
`force-app/`. Populated on the four bundle-only articles that carry a tier.

**"Editable by system administrators only" is expressed as a permission set**,
`Product_Registry_Admin`, which grants edit on this field and
`Stato_Bundle__c` and nothing else. Assigning it to nobody but administrators is
what enforces the rule - the field itself has no other grant. Doing it this way
rather than by editing a profile in the org keeps it in source control, against
[the org-only pattern](../risks/Risk%20-%20integration%20credentials%20exist%20only%20in%20the%20org.md).

⚠ The field is a **picklist**; the meeting did not say whether it should be one.
Three values are what the registry currently uses, and the picklist is restricted,
so a fourth tier will need a deploy rather than a typed value. Confirm when the
transcript is drilled.

⚠ The 13 workbook rows that carry a tier are **not** all loaded - only the four
bundle-only ones are. The other nine are Mexal articles, most of which are not in
the org at all.

## 2026-09-02 — confirmed from the transcript, with the access rule attached

This item was resolved from the Gemini summary of the
[2 September session](../meetings/2026-09-02%20Follow-up%20Anagrafica%20Articoli.md).
The transcript adds three things the summary did not carry:

- **Why it left Mexal.** Elisa Migliano's own question opened the call — _"vale
  la pena di impegnare un campo di mexal per solo 15 codici articolo?"_ — and the
  answer is no. That also **retires the double-coding trick** agreed on
  26 August, where one scarce Mexal field was to carry _genera biglietto_ and
  _bundle_ packed together: freeing `tipo biglietto` frees the field.
- **The access rule is stricter than "administrators".** Elisa Migliano:
  _"questo menù dell'anagrafica prodotti deve essere visibile esclusivamente
  all'account amministrazione@pienissimo.com."_ The built
  `Product_Registry_Admin` permission set carries the rule; **whether it is
  granted to that account alone has not been checked.**
- 🔴 **There is no validation and both sides know it.** Aurel Mrruku said so
  plainly: _"non c'è automatismo per beccare quella problematica… se metti su un
  prodotto una tipologia di biglietto che non c'entra niente con quel prodotto,
  lì non ti posso aiutare."_ The mitigation is access control, and the exposure
  is a wrong ticket type on a live product with nothing to catch it.

**Volume**: about 15 codes carry a value, out of a course registry of 40-50 rows,
so roughly twenty manual updates a year. Aurel Mrruku drew the line at scale —
fine at 13, not at 100-200 — and if the format ever changes (_"la mastery
facciamo Gold e Diamond"_) the field can be moved back to Mexal and mapped.

⚠ **Elisa Migliano also asked for _"ulteriori cinque sei campi"_ on Salesforce
only**, decoupled from Mexal, for free mapping. They were not named and they are
not in any tracker row.
