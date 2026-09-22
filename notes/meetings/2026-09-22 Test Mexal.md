---
id: meeting-2026-09-22-test-mexal
type: meeting
status: resolved
owner: Aurel Mrruku
org: both
raised: 2026-09-22
updated: 2026-09-22
source: Drive Gemini notes + transcript doc 1NOvt6dtl9C34gO9yNhuPkds4yuG4MCFDUIPr81xKBa4 (notes read in full)
---

# 2026-09-22 Test Mexal

**Client + vendor session, 1h41m, 22/09 15:00 CEST.** Aurel Mrruku, Elena Spini
(left early), Andrea Di Cicco, Fabrizio Paganelli, Elisa Migliano and
**Mirko Merendi (Kreosoft)** — the first session in this record where the Mexal
vendor, the client's registry owner and ROMI's integrator are in the same call
with Postman open.

🔑 **It closes the order → invoice → scadenziario question that
[OI-143](../items/OI-143%20The%20tranche%20invoice%20date%20must%20be%20re-keyed%20by%20hand%20into%20Mexal.md)
was raised for, and it proves order creation end to end against the live API.**

## What was proved live

- A **POST created a real customer order** on Mexal, which returned the sigla and
  progressive number it had assigned, on a test account code Fabrizio Paganelli supplied
  in the call. **Neither the account code nor the document number is reproduced here.**
- A **GET on the same document** returned every line: article codes,
  descriptions, quantities — all populated correctly.
- **Mexal assigns the order number itself** and returns it on save. Aurel Mrruku
  will key on **Mexal's order number**, not the Salesforce id, which the API
  cannot take.

## The link, as the vendor states it

| Layer         | Carries                                                       |
| ------------- | ------------------------------------------------------------- |
| Order         | Mexal's own sigla + progressive number, returned on save       |
| Invoice       | the order's **sigla + numero ordine**                          |
| Scadenziario  | **codice cliente, serie documento, numero documento, data documento** |

- Once invoiced, an order is **no longer searchable as an open order**; it is
  tracked inside the invoice, and partial invoicing reduces the residual.
- The **scadenziario holds invoices, not orders.** Aurel Mrruku will extract it in
  bulk **every evening** to refresh Salesforce.
- ⚠ **Year filtering differs by archive.** Warehouse movements and orders are
  filtered by the header year; the scadenziario is ultra-annual. Across a year
  boundary Aurel Mrruku will therefore always make **two calls, previous year and
  current year**.
- `Rif_NR attuale`, the external-reference field, could hold a Salesforce id but
  is capped at **16 characters**. He considered a dedicated 10-character
  Salesforce numbering field and **decided to keep Mexal's numbering standard**.
  → [OI-166](../items/OI-166%20The%20order%20line%20needs%20a%20shared%20identifier%20for%20Mexal.md)

## Agreed

1. 🟢 **Salesforce sends a simple order; a scheduled Mexal procedure enriches it.**
   Mirko Merendi will build a periodic job on Mexal that fills **provvigioni,
   tipo merce and contropartita di riga** after import, rather than loading those
   into the Salesforce API call. `TP_merce RSM_FE` exists on the article registry,
   but neither tipo merce nor contropartita is exposed on the order-line body.
   Fabrizio Paganelli agreed, explicitly to simplify ROMI's build.
   → [OI-159](../items/OI-159%20Mexal%20order%20fields%20Salesforce%20does%20not%20populate.md)
2. 🟢 **`codice agente` and `categoria provvigionale` belong to the customer, not
   the operator.** The order inherits the agent from the customer record — not
   from whichever Salesforce user typed it, which may be a shared account.
   Salesforce must populate zona and categoria provvigionale on the customer
   creation call (7–8 predefined values, tied to tutors).
   → [OI-169](../items/OI-169%20Agent%20code%20and%20commissions%20come%20from%20the%20customer%20record.md)
3. 🔴 **Line-level payment conditions are impossible, and the business will adapt
   instead.** Mirko Merendi: the only field available on an order line is the
   **due date**. There are no hidden fields; extra line data views exist but
   require constant manual interaction, and additional descriptions risk being
   printed on the invoice. The group decided **unanimously** not to force the
   system. Fabrizio Paganelli will instead **delete the obsolete payment-condition
   codes and create new structured ones for the Salesforce integration**, keeping
   them loose because customers move between bonifico, Ri.Ba. and recovery plans.
   → [OI-160](../items/OI-160%20Payment%20conditions%20cannot%20vary%20by%20order%20line.md)
4. 🟢 **Books use a bolla.** Goods need document type `BC`; Mirko Merendi
   recommends keeping order → bolla → fattura so mandatory e-invoicing for goods
   stays manageable.
5. 🟢 **Article registry decisions**: `tipo articolo` is dropped (Mexal-only);
   `categoria statistica` is two Mexal fields, alphabetic + numeric, and will be
   **stored and shown combined** in Salesforce (`C10 Performance Plus` style);
   article **`livelli` become a picklist** using the exact text of the level-zero
   values, prefixes `A`/`B`/`C`/`D` included, because Fabrizio Paganelli sorts
   reports on them. Level-zero categories: consulenze, eventi, prodotti, software
   a debito, articoli obsoleti. `gruppo articolo` is empty in Mexal; Salesforce's
   own lookup handles the bundle hierarchy. Listino prices stay as they are.
6. 🟢 **The product `numero tranche` field is confirmed** and Fabrizio Paganelli
   will set it to 5 temporarily to test the date grid.
   → [OI-167](../items/OI-167%20Plus%20orders%20explode%20from%20a%20tranche%20count%20on%20the%20product.md)

## Accounting consequence worth keeping

Issued invoices post to **different accounts by product-and-customer combination**
— services vs products, Italy vs abroad vs San Marino — and **one invoice can hold
a book and a course**, so the account is decided **per line**, from order data.
That is the same San Marino split
[OI-155](../items/OI-155%20San%20Marino%20revenue%20split%20and%20warehouse%20causale.md)
records, now with its Mexal mechanism named: contropartita di riga + tipo merce.

## Owed out of this session

| Who                | What                                                                  |
| ------------------ | --------------------------------------------------------------------- |
| Fabrizio Paganelli | test customer codes by mail — **delivered 22/09 13:25Z**              |
| Fabrizio Paganelli | **transcodifiche for `natura articolo` and `categoria statistica`**, cc Elena Spini — **delivered 22/09 14:21Z and 14:23Z, as screenshots** |
| Fabrizio Paganelli | the predefined commission-category values                             |
| Fabrizio Paganelli | clean up the payment-condition codes                                  |
| Mirko Merendi      | review the old customisation and list what the import procedures do   |
| Aurel Mrruku       | tipo merce / contropartita handling, the two-year API calls, the product tranche field, test orders and invoices |

⚠ Mirko Merendi then wrote separately at **15:54Z** listing the order and customer
fields the old import populated and Salesforce currently does not — recorded in
[OI-159](../items/OI-159%20Mexal%20order%20fields%20Salesforce%20does%20not%20populate.md).

## ⚠ Caveats

- **New article codes with an `FM` prefix** were created by Fabrizio Paganelli for
  bundle testing. Old codes stay deactivated while administration owns the
  registry.
- The link between ticket products and child campaigns was discussed as the basis
  for QR generation — the same ground as
  [the 10:32 session](2026-09-22%20Temi%20QR%20Code%20Biglietti.md).
- **No article code, account code, price or customer value from this session is
  reproduced in this repository.**
