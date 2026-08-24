---
id: OI-50
type: open-item
status: open
owner: ROMI
org: ROMI
raised: 2026-07-22
updated: 2026-08-24
blocks: [OI-75, go-live]
severity: gating
source: Aurel Mrruku direct decision, 2026-08-24; meetings/open-items.md row 50
---

# OI-50 - Tranche object

On 2026-08-24 **Aurel Mrruku decided the creation point and mechanics**. "Rate"
is renamed **tranche** and becomes a custom object defined **inside the Quote,
after its products have been selected**.

Creation is guided rather than inferred after the sale. For each tranche the
user selects the Quote Line Items to include and supplies the planned payment
due date. Every selected Quote Line Item stores both the tranche reference and
that date. One line belongs to one tranche; one tranche contains one or more
lines.

When an accepted quote generates the Order, the tranche reference and payment
date propagate to the corresponding Order Items. Those copied values are the
operational keys used to group what was sold and reconcile the lines with
Mexal. **The Order does not create the tranche:** it inherits the commercial
plan already defined on the Quote.

The whole order — all lines — goes Salesforce → Mexal with the **tranche
reference and payment date travelling at line level, not as an object**. Mexal
updates payment status per line; Salesforce aggregates upward to the tranche. **Mexal never
writes the tranche.** At invoicing, n Mexal invoices become n Salesforce
invoices.

**The tranche payment state is derived, never written by Mexal.** Mexal updates
payment status at Order Item / invoice-line level and Salesforce recalculates
the parent tranche. A partial payment closes nothing: only when **every line in
the tranche is fully paid** does the tranche move to its final paid state.

The API name of that final state is still open. Conceptually it is
`Pagata`/`Incassata`; do not implement `CHIUSO/ACQUISITO` merely because the old
diagram uses it. The unresolved label remains tracked in
[OI-69](OI-69%20Order%20state%20model.md).

**`Tranche__c` does not exist**, in the org or in the repository. What does
exist, committed 4 August and mentioned in no tracker, is
`OrderItem.Data_Scadenza__c` — the line-level due date the design is built on.
That is only the downstream field. The Quote-side tranche action, Quote Line
Item tranche reference/date, propagation and aggregation mechanism do not
exist.

This is the most consequential unbuilt object in the project.
[Ticket availability](OI-75%20Ticket%20availability%20rule.md) depends on
tranche-level invoicing, which means the whole
[ticket lifecycle](../flows/The%20ticket%20lifecycle.md) is downstream of an
object nobody has started — and the build restarts
[in the last week of August](../risks/Risk%20-%20the%20whole%20remaining%20build%20lands%20after%20Ferragosto.md).

## 2026-08-24 - the catalogue blocco is not this tranche

[`Prodotti e Bundle.xlsx`](../The%20Prodotti%20e%20Bundle%20workbook.md), read
on 2026-08-24, shows a bundle composed of five `BLO-` **blocchi**, and its own
headings call their contents _"i componenti **delle tranche**"_. So `BLOCCO` is
the client's word for tranche, and it exists **in the catalogue, before any
order** — with its own article code.

Aurel's decision separates the two meanings. A `BLO-` record is a
**catalogue-side bundle block**; it does not create `Tranche__c` during product
import. The operational payment tranche is created later, on the Quote, from an
explicit selection of Quote Line Items and a payment due date. Detail:
[a bundle is two levels deep](../objects/A%20bundle%20is%20two%20levels%20deep.md).
