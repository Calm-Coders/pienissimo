---
id: OI-88
type: open-item
status: open
owner: ROMI
org: ROMI
raised: 2026-08-06
updated: 2026-08-15
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
