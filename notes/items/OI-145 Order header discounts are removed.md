---
id: OI-145
type: open-item
status: open
owner: Aurel Mrruku
org: both
raised: 2026-09-18
updated: 2026-09-21
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
