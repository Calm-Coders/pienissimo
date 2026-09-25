---
id: OI-186
type: open-item
status: open
owner: Elena Spini
with: Fabrizio Paganelli
org: both
raised: 2026-09-25
updated: 2026-09-25
blocks: [go-live]
source: notes/meetings/2026-09-25 Interna post UAT Contratto e Fase Due.md
---

# OI-186 - The Salesforce user list and profiles were never agreed with the client

**Elena Spini, at
[the 25/09 internal session](../meetings/2026-09-25%20Interna%20post%20UAT%20Contratto%20e%20Fase%20Due.md)
(`00:30:00`), reading her own Business Blueprint section aloud:
_"cosa mai sentita, mai parlato? Ruoli, permessi, profili."_**

Go-live is **21 October** ([OI-124](OI-124%20Go-live%20moved%20from%206%20to%2021%20October.md)).
Nobody can be given a login without a profile, and the client has never been asked.

## What exists

- **Four profiles, inferred from the org chart**, not from a conversation. Elena
  Spini derived them from the organigramma ROMI asked for at project start and
  named them as **direzione/amministrazione, front office, delivery and marketing**.
  She said so explicitly — _"questo è il loro organigramma che gli avevamo chiesto
  all'inizio… e dandogli questo organigramma ho cavato fuori"_ — and asked whether
  four is too many.
- 🔴 **No user list.** Aurel Mrruku: _"No, io non ce l'ho… Abbiamo la lista degli
  agenti, però non vuol dire che tutti quelli sono [utenti]."_ He has **about 18
  agent codes**; Elena Spini confirmed those are not all agents and are not the
  user list. ⚠ The licence count is not known to either of them.

## Aurel Mrruku's position

Not a blocker technically, and not worth design effort: _"se tutti vedono tutto,
sinceramente non perderei tanto tempo sui profili"_. He can build groups once the
structures and data exist, and understands the client has **no requirement to hide
records from each other**, so the four profiles could be merged. Elena Spini's
caveat: everyone seeing everything is not the same as everyone being able to
**change** everything.

## Open

- 🔴 **Get the user list from Fabrizio Paganelli.** It was booked for the
  **28/09 10:00** session alongside the Contratto — _"ne dobbiamo parlare anche
  questo con il buon Fabrizio"_. Nothing records it on the invitation's agenda.
- 🔴 **Confirm the four profiles with the client, or collapse them**, before any
  login is issued.
- 🔴 **Establish the licence count.** Aurel Mrruku recalled _"sei user"_ from an
  early conversation; Elena Spini said it is now more and neither could say.
- ⚠ This is upstream of
  [OI-180](OI-180%20Client%20UAT%20users%20are%20withheld%20until%20a%20director%20review.md).
  That row waits on Daniela Morgese's review; **this one waits on a list that does
  not exist**, which is the harder of the two.
- ⚠ No register row covers profiles, roles or permission sets.
