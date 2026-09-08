---
id: OI-129
type: open-item
status: open
owner: Elisa Migliano
with: Marco Montesi
org: Pienissimo
raised: 2026-09-08
updated: 2026-09-08
depends_on: [OI-123, OI-24]
source: notes/meetings/2026-09-08 Data Model Parte 4.md
---

# OI-129 - The locale questionnaire field list and the locale API

**The locale now has a home — an Account record type — but not a field list. Two
client deliverables were assigned in Parte 4 and neither has a date.**

## What is owed

From the `Passaggi successivi` of
[Data Model Parte 4](../meetings/2026-09-08%20Data%20Model%20Parte%204.md), both on
**Elisa Migliano**:

1. **The field list for the locale questionnaire**, produced with **Marco
   Montesi** — _"Elaborare e fornire la lista dei campi richiesti da Marco
   Montesi per il questionario relativo ai locali."_
2. **Whether an API exists for the locale anagrafica** — _"Consultare gli
   sviluppatori per la disponibilità delle API relative all'anagrafica dei
   locali."_

A third, related action is hers too: **update the locale anagrafica to match the
agreed structure**.

## Why it is a separate row from OI-123

[OI-123](OI-123%20The%20Zoho%20questionnaire%20fields%20have%20no%20home.md) asked
*where the fields go*. That is answered and closed: they go on a `Locale` Account
([the decision](../decisions/Decision%20-%20Account%20record%20types%20split%20Azienda%20and%20Locale.md)),
and the record types are built and committed.

What is open now is *which fields*, and *whether the data can be loaded at all*.
The dozen field names OI-123 lists are the **Zoho** questionnaire as Elisa
Migliano recited it; Marco Montesi's list may not be the same set. The build
cannot proceed on the Zoho list.

## 🔴 The API question is the one with teeth

Nothing in the record says how locale data reaches Salesforce. The migration
plan covers Lead, Account, Referente, Opportunità, Offerta and Articoli
([OI-24](OI-24%20Data%20model%20workbook.md)); **locali are not in it**, because
until 8 September they were not in the model. If there is no API and no export,
the locali are hand-entered or they do not migrate.

⚠ The questionnaire data Marco Montesi described is **from 2022**. Whether stale
operating data is worth migrating at all is a question nobody asked in the room.

## Why it matters now

**Data migration is formally in stand-by** pending the data model closing
([the client mail](OI-128%20Client%20confirmation%20of%20the%2021%20October%20plan%20and%20the%20Fase%202%20perimeter.md)),
and this is now one of the things the data model is waiting on. Parte 5 (16/09)
is products, quotes and orders; Parte 6 (18/09) is campaigns and leads. **Neither
covers locali**, so there is no booked session in which this closes.
