---
id: OI-65
type: open-item
status: open
owner: ROMI
with: Fabrizio Paganelli
org: both
raised: 2026-08-03
updated: 2026-08-14
depends_on: [OI-43, OI-87]
source: meetings/open-items.md row 65
evidence: Pienissimo UAT, 2026-08-03
---

# OI-65 - ACADEMY 2026 no longer reconciles

In UAT: `Bundle_Selling_Price__c` **9.800** against `Spread_Total__c` **11.222**
— a `Spread_Variance__c` of **−1.422**.

Its components are now four records — ACADEMY SESSIONE SINGOLA 5.000,
CAMERIERI VENDITORI BASE ×3 at 1.000, PIENISSIMO LIVE EDIZIONE EXTRA 2.222, UN
ANNO CON PIENISSIMO 1.000 — not the ten real CS codes with variance 0 that were
recorded on 16 July when the bundle was rebuilt from the real Zoho order.

**Per-product revenue on this bundle is currently wrong**, which is the one
thing the [junction model](../objects/The%20BundleComponent%20junction.md) exists
to protect.

This is exactly the failure mode
[OI-43](OI-43%20Spread%20variance%20does%20not%20block%20saving.md) predicted,
now demonstrated with live data, and it strengthens the case for making a
non-zero variance block the save. Correcting it needs
[real prices](OI-87%20Real%20catalogue%20prices%20still%20outstanding.md) from
Fabrizio Paganelli — the current figures are
[placeholders](../risks/Risk%20-%20placeholder%20prices%20could%20reach%20the%20client.md).
