---
id: OI-287
type: open-item
status: open
owner: Aurel Mrruku
org: ROMI
raised: 2026-10-26
updated: 2026-10-26
depends_on: [OI-284]
blocks: [go-live]
severity: gating
source: notes/meetings/2026-10-26 Tema Ordini Mexal.md
---

# OI-287 - The Mexal line discount is sent as a line total instead of per unit

**Kreosoft said the `sconto` value is applied per unit and the sender must
divide it by the line quantity. The code committed and deployed to production
the same day multiplies by the quantity instead, on a stated belief that Mexal
divides — which nothing in this record supports. Every discounted order line
with a quantity above one would carry a discount the quantity over, and the
client says quantity two happens often.**

## What Kreosoft specified

[The 26/10 call](../meetings/2026-10-26%20Tema%20Ordini%20Mexal.md), `00:05:00`
onward. Mirko Merendi, twice:

> _"lo sconto a valore va sulla quantità, quindi se ci sono due quantità e c'è
> lo sconto di €400 **devi mettere -200, devi dividere per le quantità**, hai
> capito?"_
>
> _"è uno sconto che va sulla quantità, quindi devi devi sempre dividere sulla …
> Quindi se è meno €1500 e ce ne sono tre, **devi dividere per tre**."_

Fabrizio Paganelli restated it back and named the consequence of getting it
wrong:

> _"se tu passi uno sconto totale sulla riga di €1500, quello sconto totale
> quando lo passi a Mexal **lo devi dividere per le quantità** sempre di quella
> riga. **Altrimenti dopo sbagliamo veramente a fatturare** se non è così."_

So the number written into `sconto` is a **per-unit** reduction. Mexal applies
it across the line quantity; the sender divides.

## What was built

`MexalOrderSendService.resolveLineDiscount`, committed by Aurel Mrruku in
`e9919fb` (26/10 14:30 CET) and deployed to `Pienissimo Prod` the same
afternoon:

```apex
return ((line.Prezzo_Listino__c - line.UnitPrice) * line.Quantity)
  .setScale(2, System.RoundingMode.HALF_UP);
```

with the comment:

> `// Mexal reads a sconto prefixed with '-' as an amount, not a percentage, and`
> `// divides it by the line quantity (format given by Mexal, 26/10).`

🔴 **The comment asserts the opposite of what the call established**, and the
code follows the comment.

## Why the arithmetic is wrong

Both operands are per-unit, by the repository's own definitions:

- `OrderItem.Prezzo_Listino__c` is described in its own metadata as
  _"Prezzo **unitario** prima dello sconto"_.
- `UnitPrice` is the net **unit** price;
  `QuoteTriggerHandler.netUnitPrice` computes it as `TotalPrice / Quantity`.

So `Prezzo_Listino__c - UnitPrice` is already the **per-unit** discount, which
is exactly the value Mexal wants. Multiplying it by `Quantity` produces the
**line total**. Sent into a field Mexal reads per unit, the discount applied
becomes the line total × quantity.

**Worked example**, using Mirko Merendi's own numbers: list 2,000, net 1,500,
quantity 2.

| | Per unit | Line |
| --- | --- | --- |
| Correct `sconto` | `-500` | Mexal applies 500 × 2 = **1,000** |
| What the code sends | `-1000` | Mexal applies 1,000 × 2 = **2,000** |

The invoice is discounted twice over. At quantity 3 it is three times over. At
quantity 1 — which Mirko Merendi guessed covers ~95% of lines — the two agree,
which is why a casual test would pass.

## Why it is not already caught

- 🔴 **It is in production.** It shipped in the DevMain deploy
  `0AfSW000001K5Kj0AK` (26/10), with
  `OrderItem.Prezzo_Listino__c` and `QuoteLineItem.Discount_Pct__c`.
- 🔴 **No discounted order has been sent to Mexal end to end** — stated in
  [OI-284](OI-284%20The%20listino%20sconto%20and%20netto%20mapping%20for%20Mexal%20orders%20is%20undefined.md)
  and in the 26/10 journal entries, both times as the next step.
- ⚠ **The Apex test asserts the payload, not the correctness.** The test that
  came with the deploy checks `sconto` = `"-100,5"` against a computed
  expectation; it encodes the same assumption as the code.
- 🟢 The quantity-1 path, the decimal form (comma, two decimals) and the
  negative-sign convention are all **right** — this row is only the quantity
  factor.

## What is uncertain, stated as uncertainty

⚠ **Nobody has observed Mexal's behaviour on a quantity-above-one discounted
line.** This row rests on what the ERP vendor said in the call and what the
client repeated back, against what the code's comment claims without a cited
source. Those cannot both be true. The call is the better evidence — it is
first-hand from the vendor, it was restated and confirmed by the client, and
the comment's _"format given by Mexal, 26/10"_ points at that same call.

⚠ Aurel Mrruku's own line at `00:10` is the likely origin of the inversion:
_"io il prezzo di listino prezzo netto ce l'ho moltiplicato per quantità, quindi
faccio la stessa cosa anch'io. Quindi anche lo sconto è praticamente
moltiplicato per quantità."_ It went unchallenged. But the field he then built
is per-unit by its own description, so the premise does not hold for the code
that exists.

## What settles it

One discounted order with **quantity 2** sent to Mexal, and a look at the
resulting document. That is already the open next step for
[OI-284](OI-284%20The%20listino%20sconto%20and%20netto%20mapping%20for%20Mexal%20orders%20is%20undefined.md);
this row says the test must not use quantity 1.

## Related

- ⚠ **`SAL-12` still reads _"Tutors on fixed price list, no discretionary
  discounts"_, `status: agreed`** — a seventh session in which discounting is
  built and the register is not cited.
- The rounding exposure is separate and was **accepted by both sides** in the
  same call: Mexal's rounding is not configurable (_"gli arrotondamenti non si
  toccano"_) and a one-cent difference was waived aloud by Fabrizio Paganelli.
  That is a decision, not a defect.
