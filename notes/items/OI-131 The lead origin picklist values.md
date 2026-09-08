---
id: OI-131
type: open-item
status: open
owner: Elisa Migliano
org: Pienissimo
raised: 2026-09-08
updated: 2026-09-08
depends_on: [OI-24]
source: notes/meetings/2026-09-08 Data Model Parte 4.md
---

# OI-131 - The lead origin picklist values

**`Origine` becomes a picklist instead of free text, on Aurel Mrruku's insistence.
The client owes the value list and it has no date.**

## What was agreed

Recorded under `Concordato` in
[Data Model Parte 4](../meetings/2026-09-08%20Data%20Model%20Parte%204.md):

> _"Viene stabilito l'uso di una picklist per l'origine lead basata su una lista
> di valori concordata."_

Aurel Mrruku proposed the picklist over a free-text field _"onde evitare errori e
caos gestionale"_; Elisa Migliano and Elena Spini agreed in full. The action is
Elisa Migliano's: **provide the list of values for the origin dropdown.**

## Why this is not a small row

The Opportunity naming rule agreed in the same session **keys off provenance**:
opportunities created from QR-code scans and web forms get a standardised name
assigned by Marketing Cloud plus a back-end trigger, **based on where the form
came from**. If the origin vocabulary is not fixed, the naming automation has
nothing stable to switch on.

It is also the field the marketing funnels feed. `Origine lead` was **deleted
from the Contact** in Parte 2 (4 September) as part of the contact clean-up; this
is the Lead-side field and it survives.

⚠ **Nothing says whether the list must cover the Zoho history.** Existing leads
carry Zoho origin values — the workbook's Lead sheet shows `Chat` among them. A
picklist that does not contain the historic values will not accept the migrated
records, and **data migration is in stand-by waiting on exactly this kind of
closure** ([the client mail](OI-128%20Client%20confirmation%20of%20the%2021%20October%20plan%20and%20the%20Fase%202%20perimeter.md)).

## Where it closes

Leads are **Parte 6, Friday 18 September**, with Rebecca Marmo. That is the first
booked session that covers the object — and the fourth deferral of the Lead
table ([OI-24](OI-24%20Data%20model%20workbook.md)).
