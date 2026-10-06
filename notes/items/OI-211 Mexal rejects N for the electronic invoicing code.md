---
id: OI-211
type: open-item
status: open
owner: Aurel Mrruku
with: Mirko Merendi
org: both
raised: 2026-10-06
updated: 2026-10-06
depends_on: [OI-112, OI-173]
blocks: [OI-134]
source: Gmail thread 1a0c9d4a7c6c7850 message 1a1117a1a51fb89a, 2026-10-06 13:49:38Z
---

# OI-211 - Mexal rejects N for the electronic invoicing code

**The value `N` the client supplied for `Codice Fatturazione Elettronica` is not
accepted by Mexal. Aurel Mrruku reports the admitted values appear to be `P` or
`S`, and has asked Kreosoft to confirm the mapping.**

On the `Ordine cliente` thread at **13:49:38Z**, to Mirko Merendi, cc Fabrizio
Paganelli, Elena Spini, `a.dicicco@`, `amministrazione@`:

> _"Sto notando che il valore fornito "N" per il campo Codice Fatturazione
> Elettronica non va bene, i valori ammessi da mexal a quanto pare sono "P" o
> "S"."_

## Why it matters

The field is part of the registry payload Salesforce writes when it creates a
customer and transmits an order to Mexal. A value Mexal refuses fails the write,
so this sits directly on the order-send path that
[the Mexal integration](../flows/The%20Mexal%20integration.md) carries and that
`[ROMI-PIENISSIMO] - Temi Integrazione Mexal` takes up on **07/10 12:15**.

## State

- ⚠ **Aurel Mrruku's reading of the admitted values is explicitly hedged** —
  _"a quanto pare"_. `P` and `S` are not confirmed by the vendor, and no
  transcoding table for this field exists in the records.
- The source of the `N` is the client: it is among the values supplied on this
  same thread. Which document carried it has not been traced by this sweep.
- 🔴 **Unanswered at this watermark.** Mirko Merendi has not replied, and the
  thread's previous message was his 02/10 15:11Z answer on `stato_pagamento`.
- It belongs with the other San Marino / fiscal transcoding work in
  [OI-173](OI-173%20San%20Marino%20fiscal%20transcoding%20table.md), which already
  holds the country-code and payment-method tables from the 24/09 exchange.

## What closing it looks like

Kreosoft states the admitted value set for the field in writing, the mapping
lands in the transcoding configuration rather than in code, and one order with a
San Marino customer transmits cleanly.
