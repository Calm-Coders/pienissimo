---
id: decision-notes-related-list
type: decision
status: resolved
owner: Elena Spini
with: Aurel Mrruku
org: ROMI
raised: 2026-10-27
updated: 2026-10-27
depends_on: [OI-292]
blocks: []
source: notes/meetings/2026-10-27 Follow-up Interno.md
---

# Notes live in a related list and not a field on orders

**ROMI refused a free-text note field on orders, quotes and accounts, and
granted the standard Notes related list on Lead, Account and Opportunity
instead. The reason is that a payment arrangement typed into a note on an order
is an agreement nobody can enforce and everybody later cites.**

## The decision

Taken in [the 27/10 internal follow-up](../meetings/2026-10-27%20Follow-up%20Interno.md)
by Elena Spini with Aurel Mrruku's agreement, and communicated to the client the
same evening (Gmail `1a17e66e3c2b5772`, 17:27:02Z).

- ❌ **No note field on orders or quotes.** _"negli ordini, nei preventivi,
  nell'azienda eccetera cerchiamo di tener duro di evitare di mettere."_
- ✅ **The standard Notes related list on Lead, Account and Opportunity.**
- The note is a **memo only**: no automation, no flow, no notification, and never
  binding on a process. That caveat went to the client in writing.
- A **"cattivo pagatore"** marker was discussed and ruled already covered by the
  existing `categoria statistica cliente`.

## Why

Elena Spini, `00:14:08`–`00:15:17`, from experience of the predecessor system:

> _"Loro fanno un ordine, lo fanno alla c\*\*\*\*, scusate il termine, e poi nel
> campo not[e] scrivono il cliente pagherà a €350 il 15 dicembre, al €275 al 29
> di novembre … E poi dopo vengono da me e mi dicono 'Ah, ma perché al cliente
> gli hai fatto …' … c'è scritto nel campo note."_
>
> _"siccome io questa qui è una cosa che **voglio stroncare** … **aiutatemi a fare
> muro**, non lo mettiamo."_

🔑 **The objection is to a payment schedule living in prose** beside a system that
has a scadenzario for exactly that. Aurel Mrruku confirmed the field itself was
trivial to add — _"se vuole gli possiamo agire anche un campo su tutti gli
oggetti, non è un problema"_ — so this is a product decision, not a technical
limit.

## Where it came from

Marco Montesi, Gmail `1a17d77a1132e4da`, 2026-10-27 13:05:53Z: _"se un tutor deve
**scrivere appunti** e mettere giù **note** su un lead/account, dove le può
inserire?"_ — and, earlier the same morning, from the whole commercial team in an
⚠ **unrecorded session**: _"La prima cosa che mi hanno chiesto ma il campo note
dov'è?"_

Marco Montesi had also proposed adding a task or logging a call for the purpose;
Elena Spini rejected that as a category error — _"non ha senso … quella è
un'attività"_ — and asked Aurel Mrruku to explain the distinction to him.

## Status

The decision is made and published to the client. **The configuration does not
exist** — [OI-292](../items/OI-292%20The%20Notes%20related%20lists%20on%20Lead%20Account%20and%20Opportunity%20are%20not%20built.md).
