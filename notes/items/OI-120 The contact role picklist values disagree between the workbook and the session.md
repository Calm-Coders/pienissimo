---
id: OI-120
type: open-item
status: open
owner: Elisa Migliano
with: Andrea Di Cicco
org: both
raised: 2026-09-04
updated: 2026-09-04
depends_on: [OI-24]
source: notes/meetings/2026-09-04 Data Model Parte 2.md
---

# OI-120 - The contact role picklist values disagree between the workbook and the session

**Two artefacts written the same afternoon give the contact role picklist
different values.**

[Data Model Parte 2](../meetings/2026-09-04%20Data%20Model%20Parte%202.md) agreed
a single Contact carrying a role picklist, rather than one Contact record per
role. The Gemini **Decisioni** block and the transcript both give three values:

> `commerciale` · `amministrativo` · `amministrativo e commerciale`

The client's shared workbook, saved at **15:03:03Z** — during the same call —
carries on its `Referente` sheet:

> `Ruolo — Vedi nota` … `Amministrativo/Commerciale/Piattaforma`

Three values in both. Two of the three match. **The third does not**:
`amministrativo e commerciale` in the room, **`Piattaforma`** in the workbook.

## Why the difference matters

They are not variants of one idea. `amministrativo e commerciale` is a
**combination** value, and it exists for a specific reason: it is what lets one
Contact record serve both roles, which is the whole point of the decision —
avoiding duplicate contacts. `Piattaforma` is a **third, different** role, and it
does not solve that problem.

The distinction is load-bearing downstream. The session established that
**commercial contacts receive the event tickets** and administrative ones do not.
A ticket-recipient rule written against a value set that lacks the combination
value will silently exclude every contact who is both.

## What is probably true, and why it should not be assumed

The likeliest reading is that `Piattaforma` predates the session — the workbook
sheet is largely a Zoho field inventory, and `Ruolo` carries `Vedi nota`, which
reads like a placeholder for a decision taken elsewhere. In that case the session
value set supersedes it and the workbook simply was not updated for this row.

**But the workbook was rebuilt during the call**, other rows in it *do* reflect
the session's decisions (`Contatto principale — isPrimary` is there), and
`Piattaforma` is a plausible real role at a company that sells a software
platform. So this is a genuine ambiguity, not obviously a stale cell.

⚠ **Do not resolve it by picking the newer file.** Both are from 4 September and
the timestamps do not separate them meaningfully.

## What to ask

One question to Elisa Migliano: **are the values `commerciale`,
`amministrativo`, `amministrativo e commerciale` — or is `Piattaforma` a fourth
role that also has to exist?** If both are true the picklist has four values, and
the ticket-recipient rule needs to say what a `Piattaforma` contact receives.

**No date.** It blocks the picklist action assigned to Andrea Di Cicco, which
itself carries no date, and Fase 1 development ends 10 September.
