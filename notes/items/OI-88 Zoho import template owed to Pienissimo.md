---
id: OI-88
type: open-item
status: resolved
owner: ROMI
org: ROMI
raised: 2026-08-06
updated: 2026-09-21
depends_on: [OI-24, OI-79]
blocks: [go-live]
severity: gating
source: Drive - PIENISSIMO - Project Status.docx, open point 13
---

# OI-88 - Zoho import template owed to Pienissimo

**ROMI owes Pienissimo the template they load the Zoho export into.** Recorded
as open point 13 in Elena Spini's `PIENISSIMO - Project Status` document of
2026-08-06, marked 🔴 **high**, explicitly dependent on the field mapping
(open points 4 and 12 there, [OI-24](OI-24%20Data%20model%20workbook.md) and
[OI-79](OI-79%20Migration%20volumes%20and%20mapping%20method.md) here).

This had no row in the tracker and no note until this sweep, which matters
because **it is the only migration item ROMI owns**. Every other migration
blocker is on Pienissimo — the field lists, the registry cleanup, the Lead and
Referente sheets. The chain is:

1. Pienissimo lists the Zoho fields worth moving, in Zoho labels (OI-24, OI-79);
2. **ROMI turns that into an import template** — this item;
3. Pienissimo fills it from the Zoho export;
4. Aurel Mrruku maps at insert time after a joint field-by-field call.

Step 2 sitting unowned in the record means the client can complete step 1 and
still be unable to start step 3.

The import is planned for **~1 September**, with the team back roughly 24–26
August — see
[the compressed calendar](../risks/Risk%20-%20the%20whole%20remaining%20build%20lands%20after%20Ferragosto.md).

## 🟢 2026-09-18 / 2026-09-21 - delivered, declined, and replaced by the client's own files

**ROMI delivered the template and the client did not use it.**

- **18/09 19:38 CEST** — Elena Spini sent Fabrizio Paganelli and Elisa Migliano a
  shared Google Sheet for the UAT data import. Instructions: **all** products must
  be entered, other objects may be partial (ideally the whole Zoho dataset); each
  sheet corresponds exactly to the Data Model fields; keep the Data Model file open
  alongside because the per-field notes were not all reproduced for space.
- **19/09 19:02 CEST** — Fabrizio Paganelli reported it **done, and done
  differently**: _"non ho utilizzato il file condiviso perché in alcuni casi mi dava
  delle anomalie dovute probabilmente ad un tema di formato dati."_ His example is
  the one this project has feared since August: **the client code, a text field,
  becomes a number** when pasted in. He rebuilt it as one Excel per table, fed by
  **Power Query from a Zoho CSV**, so changes and updates stay easy.
- **21/09 08:30Z** — he shared a Drive folder instead.

🔴 **So the template's own format broke the rule it was supposed to carry.** This
row existed to make sure the import template stated that
[`_ARCOD` is an opaque string](../risks/Risk%20-%20normalising%20an%20article%20code%20merges%20two%20products.md).
The template was delivered, the client hit exactly that failure inside it, and
worked around it by leaving the template. **The rule was not carried; it was
demonstrated.** Aurel Mrruku confirmed the mechanism independently on 21/09.

→ what actually arrived, and what is missing from it:
[OI-154](OI-154%20The%20client%20import%20extraction%20is%20missing%20the%20article%20classification.md)
