---
id: OI-135
type: open-item
status: open
owner: Andrea Di Cicco
with: Aurel Mrruku
org: ROMI
raised: 2026-09-14
updated: 2026-09-14
depends_on: [OI-125]
requirement: INT-05
source: Slack DM D0AQ0FMHFM1, Aurel Mrruku, 2026-09-14 12:08 CEST
---

# OI-135 - Who must be told when Salesforce starts creating Mexal orders

**Aurel Mrruku asked who has to be notified before Salesforce begins creating
orders in Mexal. Nobody answered.**

Slack DM `D0AQ0FMHFM1`, 14 September **12:08:00 CEST**:

> _"poi per la creazione di un ordine chi devo avvisare ?"_

It was asked in the middle of the customer-PUT exchange with Andrea Di Cicco, who
answered the two questions on either side of it — the `204` response and the
absence of a PATCH — and **did not answer this one**. It was not raised again
that day.

## Why it is a row and not a passing remark

- **The order leg is built.** `MexalOrderSendService` and
  `OrderMexalIntegrationService` create orders in Mexal, and
  `OrderTriggerHandler.afterInsert` enqueues the chain on every new Order
  ([the build](../objects/The%20order%20to%20Mexal%20integration%20chain.md)).
  Whatever notification is owed is owed **now**, not at go-live.
- **The target is the live ERP**
  ([the risk](../risks/Risk%20-%20the%20Mexal%20integration%20is%20developed%20against%20the%20production%20ERP.md)).
  An order appearing in Pienissimo's billing system without warning is a business
  event, not a technical one.
- **The customer side had a named counterpart and the order side has never had
  one.** Mexal answers have come from Andrea Di Cicco and, for the contract
  questions, **Mirko Merendi at Kreosoft**. Who owns the order endpoint on the
  Mexal side is not recorded anywhere in these notes.

## What is not known

- ⚠ **Whether "avvisare" means a technical enablement** (an endpoint, a
  permission, a company code) **or a business heads-up to Pienissimo
  amministrazione.** The message does not say, and guessing either way would be
  fabrication.
- ⚠ Whether it was answered verbally. Aurel Mrruku and Andrea Di Cicco spoke by
  call at 17:30 the same day; **no record of that call exists** and its content is
  not in any swept source.

## What a person must do

**Ask Andrea Di Cicco, or Mirko Merendi at Kreosoft, who has to be notified before
Salesforce creates orders in Mexal — and record the answer here.** This sits with
the standing unasked question for Kreosoft about
[`cod_agente`, `zona` and `classificatore rete` on the order call](OI-110%20Agent%20and%20network%20fields%20are%20missing%20from%20the%20Mexal%20order%20call.md),
which has now gone unasked for five days. **Both are questions for the same
person; ask them together.**
