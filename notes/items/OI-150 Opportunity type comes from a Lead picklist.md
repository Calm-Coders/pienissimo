---
id: OI-150
type: open-item
status: open
owner: Anita Aga
org: ROMI
raised: 2026-09-21
updated: 2026-09-21
depends_on: [OI-140, OI-149]
source: notes/meetings/2026-09-21 Test Interni Pre-UAT.md
---

# OI-150 - Opportunity type comes from a Lead picklist

Agreed at
[the 21/09 pre-UAT session](../meetings/2026-09-21%20Test%20Interni%20Pre-UAT.md)
(`00:27:41`). Elena Spini proposed **a picklist on the Lead that determines the
type of Opportunity generated at conversion**, from what the customer asked for.

**This is the selection mechanism
[OI-140](OI-140%20Three%20Opportunity%20record%20types.md) lacked.** Three record
types were built on 17/09 and merged, chosen "at creation" — with nothing stating
how. The gap Aurel Mrruku had named in the 17/09 internal was precisely _"come
capirò io che … è un ordine bundle? È un ordine standard o un ordine plus?"_. For
the **tutor-created** path this answers it.

⚠ **It does not answer the WooCommerce path.** An order arriving from WooCommerce
has no Lead, and
[the payload contract](../The%20WooCommerce%20payload%20contract.md) still carries
no order type. That remains owed by Sabatino Rinaldi and unasked — a third open
question on the same counterpart, now three weeks old.

## Open

- 🔴 **Nothing builds it** — no picklist, no conversion mapping in `force-app/`.
- 🔴 **The picklist values are unstated.** They must map onto `Standart`,
  `Plus_Attivazione_Rinnovo` and `Recall_Tutor`, and nobody has written the mapping
  down.
- 🔴 **`Standart` is still misspelt** in the API name and the label on `DevMain`
  — see [OI-140](OI-140%20Three%20Opportunity%20record%20types.md). A Lead picklist
  that resolves to a misspelt developer name inherits the misspelling.
- ⚠ Lead and Opportunity UAT is **24 September**.
