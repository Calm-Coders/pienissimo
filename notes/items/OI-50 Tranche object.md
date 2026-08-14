---
id: OI-50
type: open-item
status: open
owner: ROMI
org: ROMI
raised: 2026-07-22
updated: 2026-08-15
blocks: [OI-75, go-live]
severity: gating
source: meetings/open-items.md row 50
---

# OI-50 - Tranche object

"Rate" was renamed **tranche** and becomes a custom object, auto-created from
order-line due dates: lines sharing a due date form one tranche.

The whole order — all lines — goes Salesforce → Mexal with the **tranche
reference travelling at line level, not as an object**. Mexal updates payment
status per line; Salesforce aggregates upward to the tranche. **Mexal never
writes the tranche.** At invoicing, n Mexal invoices become n Salesforce
invoices.

**Tranche states** — in [the diagram](../The%20newest%20design%20diagram.md) and
already in the requirement register: a tranche is _"un contenitore di un
sottoinsieme delle righe d'ordine con scadenza di pagamento a livello di riga"_.
On deposit, **the first tranche goes straight to `CHIUSO/ACQUISITO`; subsequent
tranches are created in `CREATO`**. Mexal updates payment status at order-line
level and Salesforce aggregates upward onto the tranche.

⚠ That state name is shared with the Order, deliberately — the register records
it as a **name collision**, set manually by administration on the order and
automatically on the first tranche. But the 6 August session **struck
`Chiuso acquisito` from the order** and replaced the order states with
`Ordinato → Fatturato → Incassato`. Whether the tranche keeps the old name, or
`Incassato` is the same milestone renamed, is settled nowhere —
[OI-69](OI-69%20Order%20state%20model.md). Resolve before configuring either.

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
