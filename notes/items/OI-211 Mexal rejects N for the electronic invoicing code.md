---
id: OI-211
type: open-item
status: open
owner: Aurel Mrruku
with: Mirko Merendi
org: both
raised: 2026-10-06
updated: 2026-10-07
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

## Update 2026-10-07 — `N` is confirmed invalid, the value set still is not

The call this item was due at took place:
[Temi Integrazione Mexal](../meetings/2026-10-07%20Temi%20Integrazione%20Mexal.md),
12:16 CEST, with Mirko Merendi present.

🟢 **`N` is rejected by Mexal, confirmed by trying it.** Aurel Mrruku: _"io ho
provato con N e mi diceva che non esiste questo"_, and the `N` came from a list
the client supplied for San Marino — _"San Marino mi è stato dato un elenco e in
quell'elenco c'era il valore N"_.

🟢 **Aurel Mrruku has switched the value to `P`.** _"Io ho cambiato adesso la N
con la S, scusa, la N con la P… per San Marino."_

🔴 **Four values are in play and two people disagree.** Fabrizio Paganelli, from
a live customer record, reports _"fattura elettronica B2B S non gestita"_ and
says he had told Aurel Mrruku **`M`**. Mirko Merendi's only word on the exchange
is _"Giusto"_. So `N`, `P`, `S` and `M` all appear in one conversation, and
**no transcoding table was produced.** The hedge this item was raised on —
_"a quanto pare"_ — is not resolved; `P` is now in use on the strength of one
failed attempt with `N`, not of a vendor statement.

🟡 **A formal next step now carries it.** Mirko Merendi is to _"analizzare
l'errore riguardante il codice nazione o residenza fiscale segnalato e comunicare
la soluzione"_ — the country-code / fiscal-residence error, which is the same
field cluster. That is the route to the value set.

⚠ **The field also sits in the lock list.** The 07/10 ruling on
[OI-209](OI-209%20Mexal%20anagrafica%20updates%20only%20propagate%20when%20an%20order%20is%20sent.md)
names fiscal residence among the fields to be blindati in Salesforce and
corrected in Mexal — Fabrizio Paganelli's worked example is precisely changing
the electronic-invoicing type and fiscal residence in Mexal after Italy was
entered by mistake. And
[OI-215](OI-215%20Anticipay%20does%20not%20cover%20San%20Marino%20addresses.md) records
the opposite pull: Anticipay only serves Italian addresses.

**Stays open.** It moved from "unanswered" to "one value eliminated, one adopted
without confirmation".
