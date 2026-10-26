---
id: OI-204
type: open-item
status: in-progress
owner: Aurel Mrruku
with: Sabatino Rinaldi
org: both
raised: 2026-10-02
updated: 2026-10-08
depends_on: [OI-160]
blocks: [go-live]
source: notes/meetings/2026-10-02 UAT WooCommerce e Bundle.md
---

# OI-204 - WooCommerce payment codes need a mapping table to Mexal

**Agreed at the 02/10 client UAT: WooCommerce's payment-method codes are not
Mexal's, so a conversion table is needed between them. It does not exist, and
Aurel Mrruku owes the documentation for how it is maintained.**

## What was agreed

From the `Concordato` block of the 02/10 `UAT: WooCommerce + Bundle`:

> **Tabella di mappatura per i metodi di pagamento** — _"Viene stabilito l'uso di
> una tabella di mappatura per associare i codici dei metodi di pagamento di
> WooCommerce a quelli di Mexal."_

How it came up
([01:05:40](https://docs.google.com/document/d/1-t2XHtTO9ePWyO4mdqpDBId1KA89u4enpF8y2EWaM00/edit#heading=h.xjtasi6nq4os)–[01:06:46](https://docs.google.com/document/d/1-t2XHtTO9ePWyO4mdqpDBId1KA89u4enpF8y2EWaM00/edit#heading=h.bv6oklkwdy5p)):
Fabrizio Paganelli asked Sabatino Rinaldi whether he could use the payment codes
already in the system or had to use WooCommerce's. Sabatino Rinaldi said
WooCommerce's. Aurel Mrruku then said a mapping table is needed and **undertook
to supply documentation on how to do it**.

**WooCommerce currently exposes three methods** — bonifico, carta, PayPal
(Sabatino Rinaldi, same exchange).

## 🔴 Why this is not already solved by OI-160

[OI-160](OI-160%20Payment%20conditions%20cannot%20vary%20by%20order%20line.md) was
closed on 02/10 by building the Global Value Set `Condizione_di_Pagamento`, whose
**API names are the Mexal codes** sent as `id_pagamento` and whose labels are the
descriptions. That is the Salesforce → Mexal leg, from the four codes Fabrizio
Paganelli supplied by spreadsheet on 24/09.

This row is the **WooCommerce → Salesforce** leg in front of it. The inbound
order carries a WooCommerce method name, and nothing in the repository turns that
into one of the four Mexal codes. Aurel Mrruku restated the gap internally the
same day at [the 12:22 Interna](../meetings/2026-10-02%20Interna.md):

> _"lo stesso discorso che ho fatto a Sabatino oggi che mi ha detto che no, non
> sono gli stessi codici, in qualche modo dobbiamo fare una mappatura."_

## 🟢 One thing that was ruled out

Elena Spini had drafted a **daily GET sync of the payment-conditions table from
Mexal** into the integration agenda. Aurel Mrruku removed it at the 12:22
Interna: the table arrived **by spreadsheet**, not over the API, and
`condizione di pagamento` is an order-level four-value picklist, not an entity
with its own call. ⚠ So there is no automatic refresh of these codes by design —
if Mexal's codes change, somebody edits the value set by hand.

## What is unresolved

- Which object holds the mapping — custom metadata like
  `Residenza_Fiscale__mdt` and `Product_Category_Rule__mdt` would match the
  pattern the project has settled into, but nothing has been decided.
- Who maintains it. The bundle-code precedent is that Administration does it by
  hand.
- What happens to an inbound order whose WooCommerce method has no mapping row.
- Aurel Mrruku's documentation, which is an open action item from the UAT.

⚠ The WooCommerce and Mexal integration UAT with the client is **Wednesday 07/10,
10:00–13:00**, and `Creazione Ordini (POST)` towards Mexal is on its agenda.

## 🟢 Built 08/10 - the WooCommerce to Salesforce leg, in UAT only

`WoocommerceOrderService` now sets `Order.Condizione_di_Pagamento__c` from the
inbound `payment` block, using the 07/10 rulings. It is deployed to **Pienissimo
UAT only**. It is committed on `DevMain` as `534d1fb` and is **not in Prod**.

| `payment.method` (as sent on 07/10) | `method_title` seen | Code |
| ----------------------------------- | ------------------- | ---- |
| `bacs`                              | Bonifico bancario   | `12` |
| `stripe`                            | Carta, Credit card  | `2`  |
| `braintree_paypal`                  | PayPal              | `2`  |
| `braintree_credit_card`             | Carta di Credito    | `2`  |

- The table keys on the **gateway code**, because Stripe sent two different
  labels for one method on the same morning. If the code is not in the table,
  the label decides: `bonifico` gives `12`, and `carta`, `card` or `paypal`
  give `2`.
- **If neither matches, the field is left blank and the order is still
  created.** `MexalOrderSendService` then refuses to send it to Mexal
  (_"Condizione di pagamento obbligatoria"_), so a new gateway shows up at
  send time and is never silently miscoded.
- ⚠ **Two card gateways are live**: Stripe and Braintree both sent card
  payments in the 07/10 UAT logs. The session named only Braintree.
- The table is an Apex constant, **not custom metadata**. Changing it needs a
  deploy. Who maintains it and where it should live are still open, as above.
- **Verified 08/10:** a real 07/10 logged payload was replayed in UAT inside a
  rolled-back transaction, once per method. All four codes came out as listed,
  an unknown code with the label "Carta di Credito" gave `2`, and an unknown
  method gave blank. No records were left behind.
