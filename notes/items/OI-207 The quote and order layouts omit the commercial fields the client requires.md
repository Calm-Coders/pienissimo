---
id: OI-207
type: open-item
status: open
owner: Aurel Mrruku
with: Pienissimo
org: both
raised: 2026-10-05
updated: 2026-10-05
depends_on: [OI-205]
blocks: [go-live]
source: notes/meetings/2026-10-05 UAT Performance Plus e Gestione date pagamento.md
---

# OI-207 - The quote and order layouts omit the commercial fields the client requires

**Testing a Performance Plus renewal at the 05/10 client UAT, Fabrizio
Paganelli found that the unit list price, the quantity, the unit of measure,
the line discount and the net price are absent from the quote screen and from
the quote itself.** The client requires all of them, per line, on every
interface and every document.

## What was asked

Marco Montesi and Fabrizio Paganelli both put it as commercial transparency:
the customer must see the starting price and the discount applied for each
line, reconciling to the total value of the offer. Elena Spini extended the
list and the surfaces:

> _"le pagine della community e i documenti devono includere prezzo di listino,
> quantità, importo, sconto, totale netto e unità di misura."_

Agreed in the session, as three separate `Concordato` rulings:

- the quote carries **`Totale Listino`, `Totale Netto` and `Sconto Totale`** as
  commercial information visible to the customer;
- **list price, quantity, discount, net amount and due date** appear on every
  screen, quote and order;
- the layouts of screens, orders and quotes are **aligned**, so
  administration, sales and the customer see the same figures.

Plus the **Pienissimo logo, top left** on the quote layout.

## Why it was missing

Aurel Mrruku accepted the finding and explained it without being asked:
the build had concentrated on process logic rather than on pagination —
_"inizialmente ci si era concentrati sulla logica di processo piuttosto che
sull'impaginazione"_. ⚠ He had also **removed the negative-discount
restriction** on 01/10 with no compensating check, so any price can be entered
on a line that does not display its list price.

## State

🟢 The fields exist on the standard objects. The Campi Oggetti workbook's
`Voci offerta` and `Articoli opportunità` sheets both list `Prezzo di listino`,
`Prezzo di vendita`, `Quantità`, `Sconto`, `Totale parziale`, `Prezzo totale`
and `Unità di Misura`; its `Preventivo` sheet carries `Sconto Totale` and
`Totale Listino`. **So this was specified by the client in their own workbook
and the build did not render it** — the same pattern as
`Data invio automatico biglietti`.

🔴 `Unità di Misura` is listed in that workbook with **no API name**, and the
05/10 next steps have Aurel Mrruku adding it to the Plus products and
populating it in the next tests. The article registry
([the registry note](../The%20Articoli%20Salesforce%20article%20registry.md))
already carries a `Unità di Misura` column, so the values have a source.

🔴 **Seven surfaces are in scope**, not one: the quote screen, the order
screen, the quote PDF, the order layout, the community/participation pages, the
quote-acceptance page and the renewal summary table that the same session
decided is the only document a renewal sends.

## Why it matters now

The client begins testing in autonomy **this week**, and
[OI-205](OI-205%20The%20tranche%20carries%20no%20value%20so%20the%20client%20cannot%20see%20what%20each%20one%20is%20worth.md)
already records that the tranche carries no amount. A customer-facing quote
that shows neither a line's list price nor its tranche's value is not a
commercial document, and the Business Blueprint carrying signature lines for
both companies is already with them.
