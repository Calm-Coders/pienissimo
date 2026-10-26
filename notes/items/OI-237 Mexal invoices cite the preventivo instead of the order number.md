---
id: OI-237
type: open-item
status: open
owner: Elisa Migliano
with: Mirko Merendi
org: both
raised: 2026-10-14
updated: 2026-10-14
source: notes/meetings/2026-10-14 UAT Test e2e.md
---

# OI-237 - Mexal invoices cite the preventivo instead of the order number

**The trial invoice printed during the 14/10 e2e carries a reference wording
pointing at the quote. Elisa Migliano wants it to cite the order number, and the
change has to be made by Mirko Merendi in Mexal.**

## What the record says

[The 14/10 e2e](../meetings/2026-10-14%20UAT%20Test%20e2e.md) (`01:09:25`): she
produced a trial print — **invoice number 10, €5,000**, the first of four
tranches of `OC 1023` — and

> _"segnala che la dicitura testuale dovrà essere modificata da Mirko per fare
> riferimento al numero d'ordine anziché al preventivo"_

The next step: _"Chiedere a Mirko di modificare la dicitura di riferimento nelle
fatture indicando Ordine al posto del valore attuale."_

## Why it is a row

- **The invoice is the customer-facing document.** It is the same argument that
  makes [OI-145](OI-145%20Order%20header%20discounts%20are%20removed.md) a
  go-live row rather than a tidy-up.
- 🔑 **With tranche invoicing the reference matters more, not less.** One order
  produces four invoices through Mexal's emissione differita. A customer
  reconciling four invoices against one commercial document needs them to name
  the same document, and the order is the one that exists in both systems.
- ⚠ **It is a Mexal-side configuration change, not a Salesforce one.** Nothing
  ROMI can build closes it, and the owner is the client's consultant.

⚠ **Small, cheap and easily lost** — it is one line in a template, buried in a
next-step list of twelve, with the same owner and the same counterparty as
[OI-236](OI-236%20The%20Mexal%20order%20carries%20no%20tipo%20merce%20and%20no%20provvigioni%20percentage.md)
and OI-145. Recorded separately so it is not dropped when the bigger ask is
discussed.

## What closing it looks like

An invoice produced from a Salesforce order whose reference wording names the
order number.
