---
id: OI-233
type: open-item
status: open
owner: Aurel Mrruku
with: Fabrizio Paganelli
org: both
raised: 2026-10-13
updated: 2026-10-13
blocks: [go-live]
source: notes/meetings/2026-10-13 Feedback Test UAT.md
---

# OI-233 - Bundle access for tutor profiles is undefined

**Fabrizio Paganelli asked at the 13 October UAT session that tutor profiles not
be able to quote or order on bundles. Aurel Mrruku said it can be done by
removing bundle visibility from those profiles. Defining which profile gets what
was deferred to a later discussion, with no owner and no date.**

## What was said

[The 13/10 Feedback Test UAT](../meetings/2026-10-13%20Feedback%20Test%20UAT.md),
`00:56:34`:

> _"Fabrizio Paganelli solleva la questione relativa ai permessi dei tutor,
> evidenziando che profili non autorizzati non dovrebbero poter creare preventivi
> o ordini sui bundle. Aurel mrruku spiega che è possibile limitare l'accesso
> rimuovendo la visibilità dei bundle per specifici profili utente."_

Gemini files it under **`Da approfondire`**, the only item there:

> _"La configurazione dei permessi specifici per impedire ai tutor di inserire
> offerte sui bundle è stata rinviata a un confronto successivo per definire i
> profili di accesso."_

The next-step list assigns it to **`[Il gruppo]`** — _"Definire i permessi di
accesso per ogni profilo utente in merito alla gestione dei bundle."_ 🔴 **A
group owner is not an owner.**

## Why it is more than a permission tidy-up

- 🔑 **It is a commercial control, stated by the person who runs
  administration.** A bundle's price is fixed at creation and
  [bundles are excluded from manual discounting](OI-145%20Order%20header%20discounts%20are%20removed.md);
  a tutor quoting a bundle is a tutor pricing something they are not meant to
  price.
- ⚠ **"Tutor" is not a profile in any project record.** The records carry
  `Campaign_Management`, `Ticket_Asset_Management`, `Product_Registry_Admin`,
  `Participant_Document_Generation` and `Full_Permission`, plus Agente product
  access. **Which org profile a tutor holds is not established**, so the ask
  cannot be implemented as stated.
- ⚠ **The proposed mechanism has a side effect nobody raised.** Removing bundle
  *visibility* from a profile also hides bundles the tutor may legitimately need
  to see — on an existing order, a ticket, or a renewal. Read access and create
  access were not distinguished in the room.
- ⚠ **`recall tutor/pack tutor` is in the 14/10 e2e scope**, so tutor-facing
  products are being tested the day after this was deferred.

## Open

- 🔴 **Name an owner and a date.** Currently neither.
- 🔴 **Establish which profile or permission set a tutor actually has** in UAT
  and Prod.
- ⚠ **Decide read versus create**, not just visibility.
- ⚠ No register row covers profile-level product access.
