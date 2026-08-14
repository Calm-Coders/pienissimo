---
id: risk-ferragosto-compression
type: risk
status: open
severity: high
owner: Elena Spini
org: both
raised: 2026-08-06
updated: 2026-08-14
blocks: [go-live]
source: meetings/results/2026-08-06-chiusura-punti-aperti.md
---

# Risk - the whole remaining build lands after Ferragosto

Everything material was pushed past the Italian August break in the 2026-08-06
session. Sabatino Rinaldi, Aurel Mrruku and Andrea Parmeggiani are out until
roughly **24–26 August**; Elisa Migliano returns **17 August**.

Starting in the final week of August, against a **6 October go-live** and a
**31 October** Zoho expiry:

- the [WooCommerce webhook build](../items/OI-49%20WooCommerce%20checkout-link%20flow.md) — credential exchange and payload testing begin 26 August
- the [VAT validation integration](../items/OI-73%20VAT%20validation%20moves%20into%20Salesforce.md), whose provider is still unconfirmed
- the [Zoho field mapping](../items/OI-79%20Migration%20volumes%20and%20mapping%20method.md), with a joint field-by-field call still to hold
- the [asset flow review](../items/OI-82%20Asset%20flow%20needs%20a%20dedicated%20review.md), which both Elisa and Elena admit is under-specified
- the [marketing funnel design](../items/OI-81%20Event%20communication%20funnel.md), meeting not yet scheduled
- the [phase 2 estimate](../items/OI-83%20No%20phase%202%20estimate.md), explicitly deferred to after the holidays

That is roughly five weeks of calendar between the restart and go-live, for
work that includes two integrations not yet started, an object
(`Tranche__c`) that does not exist, and a
[coverage debt](Risk%20-%20production%20deploy%20is%20blocked%20by%20Apex%20coverage.md)
that blocks deployment on its own. The data import was planned for ~1 September
and depends on a workbook Pienissimo has not finished.

Nothing about this was framed as a risk in the session — the return dates were
recorded as logistics.
