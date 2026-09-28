---
id: OI-130
type: open-item
status: open
owner: Elisa Migliano
with: Marco Montesi
org: Pienissimo
raised: 2026-09-08
updated: 2026-09-08
depends_on: [OI-24]
source: notes/meetings/2026-09-08 Data Model Parte 4.md
---

# OI-130 - The opportunity category and subcategory dependency matrix

**Dependent picklists for `categoria` and `sottocategoria` on the Opportunity
were agreed in Parte 4, conditional on a dependency matrix the client owes. The
build is blocked on a spreadsheet.**

## What was agreed

Recorded under `Concordato` in
[Data Model Parte 4](../meetings/2026-09-08%20Data%20Model%20Parte%204.md):

> _"Le picklist dipendenti per categoria e sottocategoria sull'opportunità
> vengono implementate a seguito dell'invio della relativa mappatura."_

Aurel Mrruku asked whether the two fields should be free or dependent; Elisa
Migliano asked for **dependent picklists restored** — they existed in Zoho — and
Aurel Mrruku accepted **on receipt of the dependency matrix** from Elisa Migliano
and Marco Montesi.

## What the fields are for

They record **where a commercial request came from and what it was about** —
Elisa Migliano's examples were requests picked up during courses or at trade
fairs, mapped to the specific product of interest, `Pienissimo Pro` among them.
So the pair is the Opportunity's own provenance breakdown, distinct from the
lead-origin picklist in
[OI-131](OI-131%20The%20lead%20origin%20picklist%20values.md).

## What is owed

- **The dependency matrix** — which `sottocategoria` values are valid under which
  `categoria` — from Elisa Migliano to Aurel Mrruku.
- A prior step in the same action list: Elisa Migliano **transfers the category
  and subcategory values to Marco Montesi for commercial review** before the
  matrix is final.

⚠ **No date on either**, and the second gates the first.

## The trap this walks into

Dependent picklists in Salesforce carry a failure mode this project has already
hit: **a value must be assigned to every record type before records can use it**,
and a metadata retrieve does not reveal whether it was
([the note](../How%20to%20add%20a%20picklist%20value%20that%20records%20can%20actually%20use.md)).
Account now has **two** record types, `Azienda` and `Locale`
([the decision](../decisions/Decision%20-%20Account%20record%20types%20split%20Azienda%20and%20Locale.md)),
and Campaign has two more. Whoever builds this should assign values across every
record type and verify in the org, not in the retrieve.
