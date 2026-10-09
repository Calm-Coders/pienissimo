---
id: OI-145
type: open-item
status: open
owner: Aurel Mrruku
org: both
raised: 2026-09-18
updated: 2026-10-09
source: notes/meetings/2026-09-18 Data Model Parte 6.md
---

# OI-145 - Order header discounts are removed

Agreed at [Data Model Parte 6](../meetings/2026-09-18%20Data%20Model%20Parte%206.md)
(`00:13:20`, `00:14:47`), client-facing.

**Discounts exist only on article lines.** Fabrizio Paganelli opened by proposing
an order-header discount for global rounding; after a technical exchange with
Aurel Mrruku the group **removed header-level discounting entirely**, to avoid
having to allocate it proportionally back across the lines.

Two related rulings from the same block:

- **Fixed prices are preferred over percentage discounts**, because of decimal
  rounding in Mexal and SAP. Entering a fixed price **overwrites** a percentage set
  earlier on the same line (`00:07:18`, `00:10:11`).
- **Bundles are excluded from manual discounting** — the bundle price is set at
  creation (`00:06:05`).

## What the invoice must show

Fabrizio Paganelli's commercial requirement (`00:11:45`): the customer must see
**quantity, list price, total value, discount applied and net amount** on the
invoice. ✅ The PDF side is satisfied — the two source-controlled quote templates
derive exactly those from `QuoteLineItem` per
[the PDF field mappings](../Quote%20PDF%20field%20mappings.md).

🔴 **The Mexal side is not verified.** Aurel Mrruku agreed to check with Andrea Di
Cicco that the API carries all five values through. **That check has not happened**
— neither the 21/09 Mexal internal nor the client call touched discounts.

## Open

- 🔴 **Verify the discount fields travel on the order API to Mexal.** Owner: Aurel
  Mrruku with Andrea Di Cicco. The 22/09 `Test Mexal` session with Mirko Merendi is
  the venue.
- ⚠ **Nothing builds the removal.** Whether an order-header discount field exists
  in the org today, and needs removing rather than merely not being used, is
  unchecked — **the org was not opened.**
- ⚠ No register row covers discounting.

## 2026-10-06 - Mexal receives the net price

**Decision (Aurel Mrruku, 2026-10-06): the order sends Mexal the net line price; no
separate `sconto` is sent.**

What was established first:

- **Mexal does expose a line discount.** The field is `sconto`, an alphanumeric
  per-line array next to `prezzo`, confirmed by the live `?info=true` schema read
  on 18/09. The `ManWebapi3_0.pdf` manual never names it for order lines. Andrea Di
  Cicco's [mapping workbook](../The%20Mexal%20integration%20mapping%20workbook.md)
  maps it on the `Get Fatture` sheet only (`sconto`, `varchar(17)`). Its value
  format (`10`, `10+5`, an amount) is **unverified**: the read-only scan of real
  order lines was blocked by the session's permission rules.
- 🔴 **Bug found in source:** the quote-to-order conversion in
  `QuoteTriggerHandler` copied `QuoteLineItem.UnitPrice`, which is the price before
  the line `Discount`, and dropped the discount. A discounted quote therefore
  produced an order, and a Mexal document, at the **full price**, while the quote
  PDF and the tranches (built on `TotalPrice`) showed the net figure.

**Fix:** `OrderItem.UnitPrice` is now `QuoteLineItem.TotalPrice / Quantity`,
rounded to 2 decimals. This matches the WooCommerce path, which already sends
`total / quantity`. **Deployed to Pienissimo UAT on 2026-10-06** (deploy
`0AfMA00000CrTjK0AV`, read back). Before the deploy, the UAT class differed from
source only by this change. Not deployed to Prod, not committed, and not tested
end to end with a discounted quote.

Consequences:

- ⚠ **Fabrizio Paganelli's invoice requirement is only partly met on the Mexal
  side.** The Mexal invoice shows the net unit price, not list price plus discount.
  The quote PDF still shows all five values.
- ⚠ When the quantity is above 1 and the discount does not divide evenly, the line
  total can differ from the quote by a few cents.
- ⚠ Orders already created from discounted quotes keep the full price. Whether any
  exist in UAT or Prod is **unchecked**.

## 🔴 2026-10-09 — the client raised it himself, and it is worse than "not verified"

At [the 09/10 call](../meetings/2026-10-09%20Accesso%20e%20Tema%20Prodotti.md)
(`00:14:07`–`00:16:44`) **Fabrizio Paganelli brought this up unprompted**, and
the exchange turns the open check above into a known gap.

**His requirement, restated:**

> _"quando escono le fatture io ho bisogno che ci sia prezzo di listino, lo
> sconto e il netto evidenziato nelle fatture."_

**Aurel Mrruku's answer — the order tracciato has no such fields:**

> _"noi non li passiamo, noi abbiamo solo un prezzo nel tracciato, non ci sono i
> campi per prezzo di listino eccetera sui campi che ha fornito Mirko."_

Looking at a live test order together, they confirmed the single value Salesforce
sends **is the net price** (_"è il prezzo scontato quello, è il prezzo netto
praticamente"_).

🔴 **So the check OI-145 was carrying is answered in the negative.** Of the five
values Fabrizio Paganelli required on 18/09 — quantity, list price, total value,
discount applied, net amount — the Mexal order payload carries the net amount and
**not the list price or the discount**. The quote PDF still derives all five
(✅ above); the invoice, which is what the customer receives from Mexal, cannot.

⚠ **This was already known once and parked.** Aurel Mrruku recalled asking Mirko
Merendi exactly this: there is **another Mexal interface** that accepts the
breakdown, and Mirko Merendi **advised against it over rounding errors** —
_"ha detto che c'è un altro servizio, ma ha detto che non lo consiglia perché ci
sono problemi sugli arrotondamenti"_. The 18/09 session had reached the same
conclusion from the other side: fixed prices are preferred over percentage
discounts **because** of decimal rounding in Mexal. The rounding objection and
the invoice requirement are in direct conflict and nobody has resolved them.

🟡 **Two possibilities neither man ruled out**, recorded as open rather than
answered: that Mexal **derives** the list price and discount itself from the
article's own listino when it invoices (Fabrizio Paganelli: _"Può darsi che
questo prezzo qui lo metta lui in automatico"_), and that the field simply exists
and was missed (Aurel Mrruku: _"guarda se c'è il campo a me 5 minuti costa"_).

**Action, with a date at last:** a call with **Mirko Merendi next week** on
_"listino, sconto e netto in fattura"_ — on the 09/10 next-step list, in Elena
Spini's 09/10 status post, and slipped from Friday afternoon because Mirko
Merendi does not work then. ⚠ **Still no booking**, and the production
confirmation is 13/10.

🔑 **Why this is now a go-live row and not a tidy-up.** The invoice is the
document the customer receives and the one Fabrizio Paganelli, who runs
administration, says must show the discount. If Mexal cannot render it from what
Salesforce sends, the options are a second Mexal interface its own vendor
advises against, a derivation nobody has confirmed, or invoices that do not show
a discount the customer was promised.
