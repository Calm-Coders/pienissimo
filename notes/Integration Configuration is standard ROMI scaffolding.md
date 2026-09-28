---
id: convention-integration-framework
type: reference
status: active
org: ROMI
updated: 2026-08-14
---

# Integration Configuration is standard ROMI scaffolding

`Integration_Configuration__c`, `Integration_Log__c` and `API_Callout_Engine`
are **ROMI's standard integration scaffolding**. They are asked for and built on
every project, not designed fresh for this one.

That is why they carry **no requirement id, no tracker row and no meeting** —
correctly so. Do not raise their absence from the written record as a finding,
and do not open an item asking who specified them.

| Component                     | Role                                                                 |
| ----------------------------- | -------------------------------------------------------------------- |
| `Integration_Configuration__c` | Per-integration configuration — endpoints, credentials reference, toggles. 16 fields |
| `Integration_Log__c`          | Callout audit trail. 10 fields                                        |
| `API_Callout_Engine`          | The generic callout layer both sit behind                             |

Committed 4–5 August by
[Anita Aga](people/Anita%20Aga%20-%20Salesforce%20developer%20ROMI.md).

**What still belongs to this project** is what gets configured on top of it: the
[Mexal integration](flows/The%20Mexal%20integration.md) — nightly delta GETs,
callout size limits, the rinvio-ordine button — and the
[WooCommerce webhooks](items/OI-49%20WooCommerce%20checkout-link%20flow.md). Those
are project requirements and are tracked as such. The scaffolding underneath
them is not.

⚠ `API_Callout_Engine` has **no test class** in this repository. Standard
scaffolding still counts toward the org's Apex coverage, so it belongs in
[the test suite](risks/Risk%20-%20production%20deploy%20is%20blocked%20by%20Apex%20coverage.md)
when that is called — worth checking then whether the house version ships with
tests that were simply not committed here.
