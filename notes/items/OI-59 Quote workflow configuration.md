---
id: OI-59
type: open-item
status: open
owner: Elena Spini
with: Marco Montesi
org: both
raised: 2026-07-31
updated: 2026-08-14
source: meetings/open-items.md row 59
requirement: SAL-10
---

# OI-59 - Quote workflow configuration

From the 31 July business review. The lead/opportunity flow itself was
**confirmed** there; these are the residual configuration items.

- **5-day validity**, with the expiry date a **mandatory field at send**
- automatic alerts to tutor and client **on day 2 and at expiry**
- a **"qualificato da ricontattare"** state
- a **manual quote-creation button**

**Marco Montesi owes the list of preset expiry timings** per product category
and business line. Without it the 5-day default is the only rule, and the
client's own annotated diagram asked for the ability to **revive expired
quotes** — which is a related behaviour nobody has specified.

Configuration, not design. `Quote` in the repository carries one custom field
(`Motivazione_Da_Ricontattare__c`), so the state exists and the timing rules do
not.

Downstream of [OI-68](OI-68%20Quote%20acceptance%20landing%20page.md) in
[the quote to order flow](../flows/The%20quote%20to%20order%20flow.md).
