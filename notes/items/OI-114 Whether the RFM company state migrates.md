---
id: OI-114
type: open-item
status: open
owner: Elisa Migliano
with: Marco Montesi
org: Pienissimo
raised: 2026-09-03
updated: 2026-09-03
depends_on: [OI-24]
requirement: DAT-02
source: notes/meetings/2026-09-03 Data Model Parte 1.md
---

# OI-114 - Whether the RFM company state migrates

**`Stato Azienda` classifies customers by an RFM matrix — recency, frequency,
monetary value — into buckets like _dormienti_ and _attivi_. Nobody in the room
could say whether Salesforce needs it.**

Left pending at
[Data Model Parte 1](../meetings/2026-09-03%20Data%20Model%20Parte%201.md). Elena
Spini and Elisa Migliano will put it to **Marco Montesi**, who runs sales and is
the person the classification exists for.

Its sibling field `Stato cliente` — tied to obsolete entry questionnaires — was
deleted outright in the same pass. `Stato Azienda` survived only because nobody
present owned the answer.

## What is actually being asked

Two different questions, and they should not be collapsed:

1. **Does the value migrate?** A computed classification carried across as a
   static field goes stale the day after import.
2. **Does the calculation move?** If the RFM buckets are to stay current in
   Salesforce, something has to recompute them — and that is a build nobody has
   scoped, eleven days after Fase 1 development was due to have started on it.

The session recorded only that the field is pending, not which of these was
meant. **Ask for both when the answer comes back.**

🟢 **The register already answers the second question.** `DAT-02` reads _"RFM
matrix rebuilt natively, order-date based, per product line"_, priority `S`,
status **agreed**. So the calculation is contractually meant to **move**, not the
value to be carried across — and it is meant to be rebuilt from order dates, per
product line, which is more specific than anything said in the session. **Nobody
in the room cited it.** Put `DAT-02` in front of Marco Montesi with the question,
rather than asking it cold.

⚠ Marco Montesi is named in the record as sales lead but has been in **no
session this project has minuted**. Routing a decision to him has no established
path; Elisa Migliano owns getting the answer.

**No date was set.**
