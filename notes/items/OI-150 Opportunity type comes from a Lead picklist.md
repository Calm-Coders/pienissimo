---
id: OI-150
type: open-item
status: in-progress
owner: Anita Aga
org: ROMI
raised: 2026-09-21
updated: 2026-09-23
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

## 2026-09-23 — org-status check

Read-only check of Pienissimo UAT, 08:01–08:40Z, `DevMain` at `61f2a53`. Nothing was deployed or changed.

- 🔴 **The mapping is not in UAT.** The org runs `LeadConversionQueueable` as of `08b97cc` (21/09). It still **forces every converted Opportunity to `Standart`** and never reads `Lead.Tipo_Opportunita__c`. **A check-only deploy validates and changes nothing**, and nobody deployed the 22/09 version afterwards. (verified, token comparison of the org body against every commit)
- 🟢 The rest is deployed: `Lead.Tipo_Opportunita__c` (read/edit through `Full_Permission`), both Lead record types and the three Opportunity record types.
- ⚠ So the **24/09 session would show a picklist that does nothing at conversion**. See [OI-170](OI-170%20DevMain%20is%20ahead%20of%20UAT%20on%20the%20Lead%20conversion%20and%20quote-line%20paths.md).
- ⚠ `Standart` is still the Opportunity record type's developer name in the org.
