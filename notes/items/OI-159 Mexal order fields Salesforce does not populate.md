---
id: OI-159
type: open-item
status: open
owner: Fabrizio Paganelli
with: Mirko Merendi
org: both
raised: 2026-09-22
updated: 2026-09-22
depends_on: [OI-169]
blocks: [go-live]
source: notes/meetings/2026-09-22 Test Mexal.md
---

# OI-159 - Mexal order fields Salesforce does not populate

**Raised by Mirko Merendi (Kreosoft) by mail at 2026-09-22 15:54Z**, immediately
after [the Test Mexal session](../meetings/2026-09-22%20Test%20Mexal.md), to
Fabrizio Paganelli and Elisa Migliano, copying Aurel Mrruku, Elena Spini and
Andrea Di Cicco.

The old Zoho-to-Mexal import filled fields the new Salesforce order does not.

## On the order

`Causale` · `Tipologia pagamento` · `Agente` · `Riferimento amministrazione PA` ·
`Contropartita di riga` · `Tipologia merce di riga` ·
`Valore provvigione agente di riga` · `Gestione ratei di riga (data inizio e data
fine)`

## On the customer

`Agente di default` · `Zona` · `Categoria provvigionale` · and for Italian
customers: **electronic-invoicing activation, sezionale IVA 3, and inclusion of the
`FT` PDF attachment**.

## The question he asks

> _"Ti chiedo di valutare quali di questi campi dovranno essere aggiornati dalla
> nostra procedura e quali, invece, dovranno essere inseriti direttamente da
> Salesforce durante l'importazione dei dati."_

**The split is not decided.** In the session, the agreed direction was that
Salesforce sends a simple order and a **scheduled Mexal procedure** written by
Mirko Merendi then fills **provvigioni, tipo merce and contropartita di riga** —
partly because neither tipo merce nor contropartita is exposed on the order-line
body of the API at all. The mail widens the list beyond those three, and it is
addressed to the client, not to ROMI.

## Why it matters before UAT

- **Mexal integration UAT is 6 October** and go-live 21 October. A field nobody
  fills is a silent gap that only appears in accounting.
- 🔴 **`Gestione ratei di riga (data inizio e data fine)`** is the one item on the
  list nothing in this record accounts for. It is per-line accrual dates, adjacent
  to the tranche mechanism settled the same day
  ([OI-143](OI-143%20The%20tranche%20invoice%20date%20must%20be%20re-keyed%20by%20hand%20into%20Mexal.md))
  and never mentioned in it.
- **`Riferimento amministrazione PA`** and the Italian e-invoicing flags are
  compliance fields, not conveniences.

## Open

- 🔴 **Fabrizio Paganelli owes the field-by-field split**: Kreosoft procedure vs
  Salesforce. Nobody has answered the mail as at this sweep.
- 🔴 **`Causale` has a known value question**: the 11/08 Kreosoft answers say the
  causale in use is `1` and tests may use `10` — recorded at the 21/09 pre-UAT
  session as an action and not yet closed.
- ⚠ Whether the accrual dates are a requirement or a Mexal-internal nicety is
  unestablished, and **allocating a requirement id is a human's call.**
