---
id: decision-ingressi-edition-fase2
type: decision
status: active
owner: Elena Spini
with: Aurel Mrruku
org: both
raised: 2026-09-23
updated: 2026-09-23
depends_on: [OI-146, OI-161]
source: notes/meetings/2026-09-23 Check Data Import.md
---

# Decision - ingressi live on the campaign edition and are Fase 2

**Taken at [Check Data Import](../meetings/2026-09-23%20Check%20Data%20Import.md),
`01:54:56`–`02:01:26`, with the client asking the question and ROMI answering it.**

## The question Fabrizio Paganelli put

His own written request of 22/09 15:05Z, restated in the room: a **conversion factor on
the product registry** determining how many entries a ticket is worth — _"un biglietto
Mastery e un biglietto sono sei ingressi […] dove la mettiamo? In quale tabella?"_

## The answer

🔴 **Not on the product.** Aurel Mrruku and Elena Spini placed it on the **campaign
edition**:

> **Fabrizio Paganelli:** _"Quindi non c'è bisogno di mettere nulla a livello di
> anagrafica articolo?"_ **Aurel Mrruku:** _"Di anagrafica articolo, no. Di anagrafica
> campagna."_ […] _"andrai nell'edizione, quindi nel figlio di Mastery 2027, avrai la
> possibilità di creare il record di ingresso per quella campagna."_

Fabrizio Paganelli restated it back and had it confirmed three times: invoicing quantity
one of a Mastery generates the ticket **and** its six entries, from the edition.

🔴 **And all of it is Fase 2.** Elena Spini closed the topic:

> _"questa cosa qua è appunto la fase due, quindi tutte le logiche di dove metteremo
> questi campi le vedremo poi. Cioè, secondo me è inutile parlare adesso."_

🟢 **Fase 1 behaviour is stated plainly** by Fabrizio Paganelli: _"Oggi facciamo che un
biglietto è un ingresso, anche se viene 6 giorni diversi."_ **One ticket, one entry —
including for a six-day Mastery.**

## The mechanism, for when Fase 2 comes

Entries are defined on the **edition** as **blocks of dates** (Aurel Mrruku's example:
1–3 December as a first block, a second block possibly months later). On ticket
generation the block structure is copied **onto the ticket**, because the ticket is
linked to the edition. A scan writes the entry date into the matching block.

🔑 **The scan is an inbound API call to Salesforce.** Aurel Mrruku, `01:58:52`: when
Andrea Parmeggiani's app scans a ticket and something is wrong, Salesforce must _"restituire
un errore parlante"_ — e.g. that only one of three entries in the previous block was used.
This is the first statement in the record of what the check-in integration is **for**,
beyond updating the asset. → [OI-161](../items/OI-161%20The%20event%20check-in%20app%20must%20integrate%20with%20Salesforce.md)

⚠ Aurel Mrruku noted the data model for it is still undefined — _"manca un data model"_ —
and that is exactly what Elena Spini deferred.

## What this settles

- 🟢 **The 22/09 written request is answered.** The client asked for a product field and
  was told, with reasons, that the structure lives elsewhere and is not being built now.
  He accepted: _"Ok, perfetto."_
- 🟢 **The `ingressi` suspension is no longer an undisclosed ROMI-side stop.** A
  client-facing session has ruled the work Fase 2. The four-run-old trigger — _"ROMI is
  taking written requirements for a structure it has told its own developer not to
  build"_ — **is discharged by the client being told.**
- 🔴 **The Fase 1 gap is now explicit rather than hidden.** A six-day Mastery records one
  entry. Ticket UAT is **30/09**; that is where it becomes visible to the client, and it
  is now a stated scope line rather than a surprise.
