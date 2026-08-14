---
id: OI-50
type: open-item
status: open
owner: ROMI
org: ROMI
raised: 2026-07-22
updated: 2026-08-14
blocks: [OI-75, go-live]
severity: gating
source: meetings/open-items.md row 50
requirement: ORD-06
---

# OI-50 - Tranche object

"Rate" was renamed **tranche** and becomes a custom object, auto-created from
order-line due dates: lines sharing a due date form one tranche.

The whole order — all lines — goes Salesforce → Mexal with the **tranche
reference travelling at line level, not as an object**. Mexal updates payment
status per line; Salesforce aggregates upward to the tranche. **Mexal never
writes the tranche.** At invoicing, n Mexal invoices become n Salesforce
invoices.

**`Tranche__c` does not exist**, in the org or in the repository. What does
exist, committed 4 August and mentioned in no tracker, is
`OrderItem.Data_Scadenza__c` — the line-level due date the design is built on.
So the input to the mechanism is there and the mechanism is not.

This is the most consequential unbuilt object in the project.
[Ticket availability](OI-75%20Ticket%20availability%20rule.md) depends on
tranche-level invoicing, which means the whole
[ticket lifecycle](../flows/The%20ticket%20lifecycle.md) is downstream of an
object nobody has started — and the build restarts
[in the last week of August](../risks/Risk%20-%20the%20whole%20remaining%20build%20lands%20after%20Ferragosto.md).
