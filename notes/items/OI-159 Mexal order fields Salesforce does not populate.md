---
id: OI-159
type: open-item
status: in-progress
owner: Fabrizio Paganelli
with: Mirko Merendi
org: both
raised: 2026-09-22
updated: 2026-09-24
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

## 🟢 2026-09-24 — the API field names arrived, and the last open line got a label

**Mirko Merendi, 24/09 08:46:51Z**, on the `Ordine cliente` thread, _"come concordato al
telefono ti invio elenco dei campi che troverai su api"_ — the names Aurel Mrruku needs to
map the integration:

| Salesforce owes, on the **order** | Mexal API field |
| --------------------------------- | --------------- |
| Tipologia pagamento | `id_pagamento` |
| Agente | `codice_agente` |
| Gestione ratei di riga | `dt_inizio_rateo`, `dt_fine_rateo` |

| On the **customer** | Mexal API field |
| ------------------- | --------------- |
| Agente | `cod_agente` |
| Zona | `cod_zona` |
| Categoria provvigionale | `cod_cat_pr` |
| Paese | `cod_paese` |
| Residenza fiscale | `tp_nazionalita` |
| Fatturazione elettronica | `gest_fatt_el` |
| Sezionale IVA | `serie_fatt_el` |
| Inclusione allegato PDF | `cod_modu_allega` |
| Valuta | `valuta` — **mandatory on create, fixed to 1** |
| Listino | `cod_listino` — **mandatory on create, fixed to 1** |

🔑 **Two mandatory-on-create constraints are new.** `valuta` and `cod_listino` must be sent
on every customer creation, both fixed to `1`. Nothing in the record previously said the
Mexal customer create had required fields Salesforce does not otherwise hold.

Aurel Mrruku acknowledged at 09:16:35Z: _"Presa visione"_.

### `Gestione ratei di riga` — from headroom to a named field pair

At [Temi Mexal Anagrafiche/Indirizzi](../meetings/2026-09-24%20Temi%20Mexal%20Anagrafiche%20Indirizzi.md)
`00:15:51` Fabrizio Paganelli asked for the two dates on the order-line track and
explained where they come from: a **software platform product Pienissimo no longer
sells**, invoiced for a year, whose accruals were computed from an activation start and
end date. Selling only courses, the case does not arise.

> _"ad oggi possiamo lasciarlo non gestito"_

Agreed label: **`data inizio competenza contabile`** / **`data fine competenza
contabile`**, chosen to be distinct from the other date fields already on the order.
🟢 **Still headroom, not Fase 1 build work** — but now with field names, an agreed label,
and a stated reason to exist.

### Payment types: a synchronisation constraint with no owner

Mexal accounting carries roughly **700** payment methods; Fabrizio Paganelli undertook to
filter to the ones actually used — _"anziché dartene 150 te ne do cinque"_ — and sent
**`Codici Pagamento.xlsx`** at 10:08:51Z with the note _"sono solo 4"_. ⚠ Five in the
call, four in the mail; not reconciled.

🔴 **Aurel Mrruku, `00:21:35`: if a payment type is added in Mexal it must be added in
Salesforce by hand, with the same nomenclature.** Mirko Merendi's reason is that the
values belong to the client, so no automated refresh can own them. **Nothing records who
watches for drift.**

### Who fills what, restated by Mexal

Mirko Merendi confirmed the five _"non previsto"_ lines are Mexal's own: the **causale** is
derived from customer type and whether products or services are sold; **contropartita di
riga** and the **agent commission** he calculates; **tipologia merce** comes from the
article master; **riferimento amministrazione PA** lives on the customer record.
Fabrizio Paganelli said he would audit the article master for gaps while he was in there.
