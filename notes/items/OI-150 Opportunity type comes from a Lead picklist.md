---
id: OI-150
type: open-item
status: in-progress
owner: Anita Aga
org: ROMI
raised: 2026-09-21
updated: 2026-09-22
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

- ⚠ **The Lead conversion path is now built in source.**
  `Lead.Tipo_Opportunita__c` carries the same four values as
  `Opportunity.Tipo_Opportunita__c`, and `LeadConversionQueueable` maps converted
  Opportunities to `Standart`, `Plus_Attivazione_Rinnovo` or `Recall_Tutor`.
  Blank Lead values default to `Vendita da tutor` / `Standart`, preserving the
  previous behavior. The change passed a check-only Salesforce deploy on
  2026-09-22 (`0AfMA00000Cl1rN0AR`).
- ⚠ **The picklist values were inferred from the existing Opportunity field.**
  No client sentence has explicitly confirmed that this is the final Lead value
  set.
- 🔴 **`Standart` is still misspelt** in the API name and the label on `DevMain`
  — see [OI-140](OI-140%20Three%20Opportunity%20record%20types.md). A Lead picklist
  that resolves to a misspelt developer name inherits the misspelling.
- ⚠ Lead and Opportunity UAT is **24 September**.
