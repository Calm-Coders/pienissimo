---
id: OI-247
type: open-item
status: open
owner: Aurel Mrruku
with: Fabrizio Paganelli
org: both
raised: 2026-10-15
updated: 2026-10-15
depends_on: [OI-186]
blocks: [go-live]
source: notes/meetings/2026-10-15 Migrazione e Go-Live.md
---

# OI-247 - Only the responsabile commerciale may edit the provvigioni fields

**The Account's commission section — categoria provvigione, zona, codice agente
esterno — must be editable by the commercial lead and by nobody else on the
commercial side. Agreed with a reason in the room, and it is the first
field-level permission requirement the project has stated for a role that does
not exist yet.**

Agreed at [the 15/10 session](../meetings/2026-10-15%20Migrazione%20e%20Go-Live.md)
(`01:00`–`01:05`).

## The model as walked through on screen

Aurel Mrruku shared the Account layout and named four sections:

| Section                        | Editable by                                                            |
| ------------------------------ | ---------------------------------------------------------------------- |
| **Dati Mexal**                 | administration only — _"non devono essere toccabili dai commerciali"_   |
| **Dati commerciali**           | commerciali                                                            |
| **Mexal dati per provvigioni** | 🔴 **the responsabile commerciale only** — this row                     |
| technical fields               | nobody operationally; they carried the Zoho id for the migration        |

The split already exists in the build — _"questo è stato detto, per quello
l'abbiamo diviso in due"_ — and the commission fields sit in the Mexal group
because _"sono dati che finiscono in Mexal"_.

## The ruling, and the reason

Fabrizio Paganelli: _"devono essere modificabili da parte del responsabile
commerciale, quindi solo da parte di Marco."_

Aurel Mrruku proposed opening it to all commerciali — _"Ma lasciamo a tutti i
commerciali a sto punto"_ — and **both Fabrizio Paganelli and Elena Spini
refused**, with the reason stated plainly:

> _"Io che sono il commerciale a non posso decidere io quali clienti assegnarmi.
> Eh, non va bene."_

🔑 **The control being asked for is not about commission values, it is about
customer ownership.** The use case he gave is bulk reassignment: _"Io posso
prendere 100 clienti di Fabrizio e darli ad Elena, prendere 150 di clienti di
Elena e darli ad Aurel."_ A salesperson who can edit this can award themselves
accounts.

**`Agente` itself moves to the commercial section** and stays editable even after
the order has reached Mexal — Aurel Mrruku: _"lo facciamo che lo può modificare
sempre a sto punto … quindi lo metto sui dati commerciali."_

## 🔴 What is unresolved

1. **The profile does not exist.** A _responsabile commerciale_ appears in no
   profile list in these records —
   [OI-186](OI-186%20The%20Salesforce%20user%20list%20and%20profiles%20were%20never%20agreed%20with%20the%20client.md),
   and the same gap blocks
   [OI-233](OI-233%20Bundle%20access%20for%20tutor%20profiles%20is%20undefined.md)
   for tutors. Aurel Mrruku's own framing — _"deve avere un permesso, diciamo, a
   [parte] per Marco, non per tutti i commerciali"_ — describes a permission set
   that has not been designed.
2. ⚠ **The requirement is undermined in the same breath.** Fabrizio Paganelli
   immediately added that Marco Montesi will not do the work himself: _"dopo
   Marco questa cosa qui non la fa, capito? La fa fare qualcun altro."_ If the
   task is delegated, a permission scoped to one person either blocks the real
   operator or gets handed around. **Nobody addressed this** and it is the whole
   difficulty of the row.
3. **It cannot be built before the permissions work starts**, and that work is
   deliberately deferred until the tests are signed off — see
   [OI-240](OI-240%20Marco%20Montesi%20needs%20a%20Salesforce%20user%20before%20go-live.md).
   Marco Montesi is meanwhile getting **System Admin**, under which he can edit
   everything including the Mexal section, which Elena Spini flagged as temporary:
   _"lui adesso pure nei test la vedrà questa cosa, ma … con i permessi giusti
   non li potrà editare."_

Closing it means a named permission set, applied to a named profile, with the
commission fields writable by it and read-only to every other commercial user —
and a decision about delegation.
