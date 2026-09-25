---
id: decision-products-from-mexal-bundles-in-salesforce
type: decision
status: active
owner: Fabrizio Paganelli
with: Elena Spini
org: both
raised: 2026-09-25
updated: 2026-09-25
requirement: BUN-06
source: notes/meetings/2026-09-25 UAT Recall Tutor e Bundle.md
---

# Decision - single products come only from Mexal and only bundles are built in Salesforce

Stated at [UAT Recall Tutor e Bundle](../meetings/2026-09-25%20UAT%20Recall%20Tutor%20e%20Bundle.md),
`01:04:09`–`01:05:25`. Elena Spini asked and Fabrizio Paganelli confirmed:

> _"l'anagrafica prodotti, tranne i bundle, arriva tutta da Mexal."_ —
> _"I prodotti nascono da Mexal, i codici articolo nascono da Mexal e basta"_ —
> _"tranne i bundle."_

## What it means

- **No single product (an _item_) is created in Salesforce.** The option to create
  one on the product-creation screen goes. Test items made by ROMI are test data only.
- **Bundles are the only products born in Salesforce, and only Fabrizio Paganelli
  creates them** (Elena Spini: _"sarà una cosa che fa solo Fabrizio"_). A tutor never
  creates a bundle. On a quote the tutor can only re-date the bundle's tranches
  ([OI-181](../items/OI-181%20Stage-sale%20bundles%20need%20their%20tranches%20defined%20at%20bundle%20creation.md)).
- **A bundle's product code is mandatory.** It is the key a WooCommerce order uses
  to find the bundle.

This confirms register `BUN-06` (_"Bundles created by administration only;
products stay configured in Mexal"_) and does not change it. What is new is the
**UI consequence**: the item path is removed, not just discouraged.

## Open

- ⚠ Nothing yet enforces "only Fabrizio Paganelli" (a profile, a permission set or
  a validation). As of this session it is a convention.
