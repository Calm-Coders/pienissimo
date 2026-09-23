---
id: OI-159
type: open-item
status: in-progress
owner: Fabrizio Paganelli
with: Mirko Merendi
org: both
raised: 2026-09-22
updated: 2026-09-23
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


## 🟢 2026-09-23 — answered by the client, line by line

**Fabrizio Paganelli replied 23/09 12:16:50Z** to Mirko Merendi's 22/09 mail, annotating
each field in place, to Mirko Merendi, `amministrazione@`, cc Aurel Mrruku, Elena Spini,
Andrea Di Cicco. _"rispondo alla mail di Mirko con alcune note. Ci aggiorniamo domani."_

**Order fields**

| Field | Ruling |
| ----- | ------ |
| Causale | **not expected** from Salesforce — the Mexal procedure fills it |
| Tipologia pagamento | 🔑 **expected from Salesforce** |
| Agente | 🔑 **expected from Salesforce** |
| Riferimento amministrazione PA | not expected — Mexal procedure |
| Contropartita di riga | not expected — Mexal procedure |
| Tipologia merce di riga | not expected — Mexal procedure |
| Valore provvigione agente di riga | not expected — Mexal procedure |
| Gestione ratei di riga (data inizio / fine) | **to be provided for** in orders going to Mexal |

**Customer fields** — `Agente di default`, `Zona` and `Categoria provvigionale` are each
_"presente tra i campi considerati da Salesforce"_. The Italian e-invoicing branch
(fatturazione elettronica, sezionale IVA 3, PDF `FT`) was **deliberately not answered**:
_"di questo punto ne parliamo domani insieme"_ →
[OI-173](OI-173%20San%20Marino%20fiscal%20transcoding%20table.md).

### What this changes

- 🟢 **The 22/09 gap _"nobody has answered Mirko Merendi's field-split question"_ is
  closed**, in 20 hours.
- 🟢 **`Gestione ratei di riga` is no longer unaccounted for.** It was this note's one
  item that nothing in the record covered. Fabrizio Paganelli's answer is that **no
  current case needs start/end accrual dates**, but the orders heading to Mexal should
  provide for them — _"è giusto tenere in considerazione questo aspetto"_. So it is
  **design headroom, not a build item**.
- 🟢 **The `Agente` and `Tipologia pagamento` answers are Salesforce's to fill**, which
  is exactly what `7eab757` began building the same evening →
  [OI-169](OI-169%20Agent%20code%20and%20commissions%20come%20from%20the%20customer%20record.md).
- 🔴 **Five of eight order fields belong to Mirko Merendi's scheduled Mexal job**, which
  is **written by Kreosoft and does not exist yet in this record**. Salesforce sending a
  correct order is not the same as Mexal receiving a complete one.
- ⚠ `Causale` is now answered at the level of *who fills it* (Mexal), which leaves the
  11/08 value question (`1` vs `10`) moot for Salesforce.
