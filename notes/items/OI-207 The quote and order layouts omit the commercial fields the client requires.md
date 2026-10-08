---
id: OI-207
type: open-item
status: open
owner: Aurel Mrruku
with: Pienissimo
org: both
raised: 2026-10-05
updated: 2026-10-08
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

## 🟡 2026-10-06 - part of it landed, on the community-page branch

PR **#82** (`DEV_modifycomunityquotepage`, merged `59d4264` at 20:07 CEST)
carries Rexhina Hysi's three commits, whose own message states the intent:
_"bundle fic price to be fixed, **added firlds to comunity page**, fic pdf to
show always field ybder tale"_ (`95d0be0`).

What is verifiable in source:

| Landed | Evidence |
| --- | --- |
| 🟢 **Line discount** | new `QuoteLineItem.Discount_Pct__c`, label **`Sconto %`**, percent(5,2) — _"Percentuale di sconto inserita durante la creazione delle tranche Performance Plus. Il prezzo finale rimane memorizzato in UnitPrice per evitare una seconda applicazione dello sconto."_ |
| 🟢 **The quote PDF** | `QuotePdf.page` +39 then reworked in `30fb71c`, and `QuotePdfController` +19 — the _"show always field under table"_ fix |
| 🟢 **The quote screen** | `quoteManageProducts` html/js/css reworked (+98 js), `QuoteManageProductsController` +53, `QuoteLineItemsController` +7 |
| 🟢 **The acceptance community page** | `quoteAcceptancePage` html/css reworked (+117 css), `QuoteAcceptanceController` +169 |
| 🟢 **A quote-line record page** | new `Quote_Line_Item_Record_Page.flexipage` (377 lines), `f84d356` |
| 🟢 **Agente** | `Agente__c` added to `Account`, `Lead` and `Quote`; `Quote_Compact_Layout` created |

## 🔴 Why this row stays open

**This sweep did not verify the five named fields against the seven surfaces.**
What it establishes is that the commercial-fields work started and that the
**discount** has a field. The row named **unit list price, quantity, unit of
measure, line discount and net price**, on every layout, community page and
document, plus the logo:

- **Line discount** — 🟢 has a field now.
- **Unit list price, quantity, unit of measure, net price** — ⚠ **not confirmed.**
  Standard `QuoteLineItem` already carries `UnitPrice`, `Quantity` and
  `TotalPrice`; whether they are now *on the layouts, the community page and the
  PDF* is a layout and page question this sweep did not open the org to answer.
- **Unit of measure** — ⚠ no field named in the diff, on `QuoteLineItem` or
  `Product2`. The likeliest genuine gap.
- **The logo** — ⚠ nothing in the diff addresses it.

⚠ **Not deployed to Prod** by anything this sweep can see, and
`Quote_Record_Page.flexipage` *lost* 10 lines in `95d0be0` while
`Product_Record_Page` lost 10 in `f84d356` — removals this sweep did not read.

🔴 **A test class was edited, not written:** `QuoteCommercialTest.cls` **-6
lines** in `f84d356`, and `Product2.Is_Plus__c` was deleted (-10). Recorded
because coverage is the standing brief; **no test was written, proposed or
scaffolded by this run.**

**To close:** confirm the five fields on each of the seven surfaces in the org,
and settle unit of measure and the logo.

## 🟡 2026-10-08 - reviewed internally, not verified with the client

At [the 08/10 internal session](../meetings/2026-10-08%20Internal%20Test.md)
Elena Spini and Aurel Mrruku went through the quote and community fields and
**confirmed the presence of unit of measure, quantity, list price, amount, total
discount, due date and payment method**. That is the list this item was opened
for, and it includes the **unit of measure** the 06/10 entry recorded as
untouched.

⚠ **Three reasons this does not close the item.**

- It is a **ROMI-internal review**, four people, no client in the room. What
  OI-207 asks for is Fabrizio Paganelli seeing the fields on the surfaces he
  found them missing from — scheduled for the **12/10 e2e session**.
- **The logo was not mentioned.** It was an explicit part of the 05/10 ruling.
- **The seven surfaces were not enumerated.** The session reviewed the quote
  screen and the community page; orders, the PDF and the acceptance page were
  not walked through field by field.

🟢 Of record from the same session, adjacent to this item: the quote e-mail
template is split into a dynamic opening with the quote codes and a static tail
carrying the interaction buttons; and **mobile optimisation of the acceptance
page matters because 80% of recipients open the mail on a phone** — raised with
no owner and no date.

🔴 The stale-PDF problem the same session ruled on is
[OI-221](OI-221%20The%20quote%20PDF%20does%20not%20regenerate%20when%20the%20quote%20changes.md),
and it is not built.
