---
id: OI-97
type: open-item
status: resolved
owner: Andrea Di Cicco
with: Elisa Migliano
org: both
raised: 2026-08-26
updated: 2026-09-02
depends_on: [OI-58]
source: notes/meetings/2026-09-02 Follow-up Anagrafica Articoli.md
---

# OI-97 - Fiscal residence on the customer registry

✅ **Resolved 2026-09-02: Salesforce derives the value automatically from the
country code.** See [the decision](#the-decision-2026-09-02) at the foot of this
note. The rest of the note is the finding as it stood, and still describes why
the field exists.

**Mexal's `tipo nazionalità` is mandatory when creating a customer over the
WEBAPI, and the country code alone will not satisfy it.**

Found the hard way at the
[26 August Mexal review](../meetings/2026-08-26%20Review%20Temi%20Integrazione%20Mexal.md):
Andrea Di Cicco's live customer-creation call failed with
_"tipo nazionalità errato"_ before he had set the field. He had assumed
`codice paese` was sufficient.

## What it is

In the Mexal UI the field is called **`residenza fiscale`**. Fabrizio Paganelli:

> _"è fondamentale perché dobbiamo sempre distinguere tra Italia, San Marino,
> Città del Vaticano, Unione Europea ed extra Unione Europea… impatta sulle
> regole di trasmissione delle fatture all'ufficio tributario."_

So it is a **five-way fiscal classification**, not a country:

| Value            |
| ---------------- |
| Italia           |
| San Marino       |
| Città del Vaticano |
| Unione Europea   |
| extra Unione Europea |

**Pienissimo operates under San Marino tax rules**, which is why the distinction
is not cosmetic — it changes how an invoice is transmitted to the *ufficio
tributario*.

## Why it is its own item

Salesforce is the system where accounts are created for new customers, and the
Mexal call is downstream of that. If the Account carries only a country, the
integration cannot populate a mandatory Mexal field and **customer creation
fails** — which is exactly what happened on air.

So this needed a decision — whether Salesforce carries the fiscal-residence value
as its own field on Account, or derives it from the country with a mapping ROMI
owns. It went undiscussed for a week and was **taken on 2 September in favour of
deriving it**; see [the decision](#the-decision-2026-09-02) below.

Related: [OI-73](OI-73%20VAT%20validation%20moves%20into%20Salesforce.md), which
validates the VAT number on the same Account, and
[OI-79](OI-79%20Migration%20volumes%20and%20mapping%20method.md), because existing
customers migrated from Zoho will need the value backfilled.

## ⚠ The API documentation is incomplete

This was not the only mandatory field missing from the docs. Andrea Di Cicco, in
the same attempt: _"tutti sti campi non c'erano sulla documentazione."_ He also
had to guess `valuta = 1` and **still does not know whether 1 means euro** —
_"devo capire che cosa significa, cioè se uno è euro oppure uno è dollaro."_

Treat the Mexal WEBAPI documentation as a partial description of the contract.
The authority is what the API rejects. This belongs with
[the Mexal integration](../flows/The%20Mexal%20integration.md).

🔴 **On Slack an hour later, Andrea Di Cicco generalised it**, in the ROMI group
DM with Elena Spini and Aurel Mrruku (18:16 CEST):

> _"il fatto è che loro hanno dei valori che sono tipo per valuta: 1,2,3,4 — che
> lato nostro non sappiamo."_

So this is not one missing field. **Mexal's coded-value dictionaries are unknown
to ROMI as a class**: the API demands and returns integer codes whose meanings
live in Mexal base tables that are neither documented nor mapped. He had already
asked for them by email — _"cosa che gli avevo chiesto di fare nell'email per
vedere se c'erano tutti i campi che servivano"_ — and it is unanswered.

**Getting the dictionaries is the concrete ask**, and it belongs on the
2 September agenda ([OI-99](OI-99%20Customer%20registry%20deep%20mapping%20session.md)).

## Evidence

Customer **`501.08721` "Test Roni"** was created successfully once the field was
set, and confirmed on Fabrizio Paganelli's screen. Order **`OC11`** followed on
serie 10. Both are **live production records** —
[there is still no Mexal test company](OI-58%20Mexal%20integration%20mechanics.md).

## The decision, 2026-09-02

**Derived from the country code, not typed and not carried as an independent
field.** Settled at the
[2 September session](../meetings/2026-09-02%20Follow-up%20Anagrafica%20Articoli.md)
between Elisa Migliano and Andrea Di Cicco:

> Elisa Migliano: _"noi qui abbiamo la possibilità di andare ad alimentare il tipo
> nazionalità in base al codice del paese."_
> Andrea Di Cicco: _"volendo sì, si può fare come mapping."_

Her reason is data quality at the source, from experience: past invoices went out
wrong to foreign subjects, and _"se riusciamo già a blindarlo all'origine siamo a
posto."_

**The five values as she named them on 2 September:**

| Value          |
| -------------- |
| Italia         |
| Unione Europea |
| Estero non-UE  |
| San Marino     |
| Vaticano       |

Same five as Fabrizio Paganelli's on 26 August, in different words
(_"Estero no Unione Europea"_ for extra-UE, `Vaticano` for Città del Vaticano).
🔴 **The exact Mexal codes behind each value are still not written down anywhere**
— the decision fixes the mapping rule, not the values it maps onto, and this is
the same coded-value gap the note describes above.

⚠ **The country-code list has a source and nobody has read it.** Elisa Migliano:
_"sono tutte le nazioni e sulle API dovresti avere una tabella che si chiama
paese dove sono tutte codificate."_ Andrea Di Cicco: _"non ci avevo fatto caso,
poi dopo le controllo."_ So the mapping input is a full ISO-scale country list
from a Mexal table, not a handful of acronyms, and **the table is identified but
unread** — read it before writing the mapping.

🟢 The same session settled two of the other unknowns in this note by asking
Elisa Migliano directly: **the currency is Euro only** and fixed, and **only
listino 1 is used.**
