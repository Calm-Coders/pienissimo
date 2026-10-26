---
id: meeting-2026-10-22-check-excel-migrazione
type: meeting
status: resolved
owner: Aurel Mrruku
org: both
raised: 2026-10-22
updated: 2026-10-22
source: meetings/2026-10-22-check-excel-migrazione-transcript.it.md
---

# 2026-10-22 Check Excel Migrazione

**Client call, 15:00 CEST, 00:40:19.** Fabrizio Paganelli for Pienissimo; Elena
Spini and Aurel Mrruku for ROMI (`amministrazione@pienissimo.com` invited, not
heard). Requested by Fabrizio Paganelli the previous evening — _"io ho fatto una
prima bozza. Avete 15-30 minuti domani?"_ — to walk his populated migration
spreadsheet line by line. **It turned the 21/10 design into a set of concrete
exclusion rules, and it exposed two things the design had not reached: the
four-part key is not unique on its own, and discounts cannot be edited on an
order once it exists.**

Full raw transcript preserved at
[meetings/2026-10-22-check-excel-migrazione-transcript.it.md](../../meetings/2026-10-22-check-excel-migrazione-transcript.it.md).
⚠ Booked for 14:30, moved to 15:00 at Fabrizio Paganelli's request the same
morning (Gmail `1a15f68fbc913929`, 08:57:00Z). Elena Spini had said she would not
attend and did attend.

## What was agreed

All of this is the client proposing and Aurel Mrruku accepting, in the order it
happened:

| Decision                                                                        | Where               |
| ------------------------------------------------------------------------------- | ------------------- |
| **Extract starts 1 January 2024** — so three commercial years, 2024 included    | `00:01:16`          |
| **Order rows whose key fields are empty are excluded from the migration**        | `00:13:13`–`00:16:10` |
| **All invoices and scadenzario entries are imported anyway**, order or no order | `00:15:10`          |
| **Tranche date = invoice date**                                                  | `00:17:26`          |
| **Payment condition forced to `12`** (bonifico data fattura) on all history      | `00:18:55`          |
| **Missing agent code → existing code `610`**, the generic secretariat agent      | `00:18:55`          |
| **Credit notes excluded**, kept in a separate file for a later phase             | `00:20:16`          |
| **~1,000 `SW` platform-sale lines deleted, not imported**                        | `00:20:16`          |
| **All products must be activated before the load**                               | `00:16:10`, `00:29:45` |

### 🔑 The key is not unique on its own, and the fix is exclusion

**Fabrizio Paganelli demonstrated on screen that `sigla` + `serie` + `numero` +
`data ordine` repeats across different customers.** The cause is invoices issued
with no preliminary order — _"ci arriva l'ordine direttamente su Ma[x]al e noi lo
fatturiamo"_ — which leave all four fields empty or zero, so every such row
collides with every other.

He proposed adding the customer code to the key. Aurel Mrruku refused, twice, on
structural grounds: the customer attaches to the order, not the line, and
_"la struttura che abbiamo implementato non ci permette di fare sta cosa"_. He
also refused the obvious workaround — Fabrizio Paganelli offered to invent the
missing order numbers, _"Va bene, me lo invento io"_ — because the key has to
match what Mexal will later send on the invoice: _"deve essere sul database
perché poi quando arriverà la fattura per collegarsi a quell'ordine deve
coincidere."_

🟢 **Resolved by dropping the rows**: _"su questi record dove … questi quattro
campi qui non sono compilati, io questi non te li passo così non abbiamo
anomalie"_ — accepted, _"ok, ok, perfetto."_

🔑 **So the uniqueness of the import key is now conditional on an extract-side
filter**, not on the key itself. Nothing in Salesforce enforces it. See
[OI-275](../items/OI-275%20The%20Mexal%20order%20key%20is%20not%20unique%20without%20the%20order%20date.md).

⚠ **What those rows are** was established and is small but not nothing: the €27
book, and 2024 oddities — _"nel 24 avevamo un sacco di porcheria"_. Their
invoices still arrive, unlinked to any order line. **The customer-facing
consequence of a historical sale with no order was not discussed.**

### 🔑 Discounts cannot be edited on an existing order

Fabrizio Paganelli tested the tutor's own path — insert an order, generate the
PDF, notice a missing discount, go back and add it — and could not. Aurel Mrruku
confirmed it from the team: _"mi hanno detto che hanno fatto fino adesso solo
quando li aggiungi, quindi non quando li modifichi"_, and _"l'hanno messo solo
qua e hanno messo anche il tasto cancella a destra, però non … l'hanno ancora
finito su modifiche."_

This is new and is recorded as
[OI-283](../items/OI-283%20Discounts%20cannot%20be%20edited%20on%20an%20existing%20order.md).
⚠ **Fabrizio Paganelli deliberately withheld his design opinion** — _"visto che
ci state lavorando non dico niente … sennò corro rischio di dire delle
stupidate"_ — and Elena Spini's direct question, _"tu qua la modifica come
pensavi di farla, Fabrizio?"_, went unanswered. **So the requirement for the edit
path has still never been stated by the client.**

### 🔴 Listino, sconto and netto: unmapped, and the two sides disagree

The oldest unfinished thread in the call. Fabrizio Paganelli: _"quando si genera
l'ordine bisogna che ci portiamo tutte queste informazioni, prezzo di listino,
sconti, netto … non possiamo fare delle fatture solo al netto."_ Aurel Mrruku's
answer is that this is not his to settle — _"io ce li ho i campi … Dovevi parlare
con Mirko"_ — and his design preference is explicit:

> _"in teoria non ti serve lo sconto, basta che ti dà prezzo netto, prezzo
> listino e sconto viene calcolato in automatico per non avere problemi di
> scontistica."_

🔴 **Fabrizio Paganelli disagreed in the room** — _"sarebbe più corretto usare
solo la percentuale"_ — against Aurel Mrruku's rounding argument, _"25,2% in
[Sales]force non coincide con 25,2% in ERP"_. Fabrizio Paganelli waved it off
(_"se è 0,01 di differenza sul totale fattura cambia poco"_) and the exchange
ended with Elena Spini saying they had to leave. **Nothing was decided.**

🔑 **Mexal's own rule was stated and is the constraint both must live with**: a
percentage discount is written as `20`, a direct price reduction as a negative
absolute value — _"ha delle regole abbastanza stringenti."_

🟢 **It produced an action the same day.** Fabrizio Paganelli spoke to Mirko
Merendi and mailed Elena Spini at 15:04:49Z asking for a call on **Monday 26
October**; she accepted at 16:54:27Z, _"per noi è ok … tranne 14-15"_.
⚠ **No slot was fixed.** Recorded as
[OI-284](../items/OI-284%20The%20listino%20sconto%20and%20netto%20mapping%20for%20Mexal%20orders%20is%20undefined.md).

### 🟡 A second edizione mechanism was offered

Aurel Mrruku proposed a flag rather than the dummy editions of
[OI-276](../items/OI-276%20Dummy%20import%20editions%20are%20needed%20to%20load%20historical%20orders.md):
_"se vuoi ti faccio un campo sull'edizione lo chiamo old, quindi vecchio,
edizione vecchia. E per non generare il link sulle edizioni vecchie"_. Fabrizio
Paganelli did not engage — _"adesso io faccio fatica a seguirti perché sto
pensando a questo tracciato"_ — and the call moved on. ⚠ **Two mechanisms for
the same problem are now on the record and neither has been withdrawn.**

The precondition attached to it is firm and new: **every product must be active
before the mapping can be done**, _"i prodotti devono essere attivi …
Io ti devo abilitare prima tutti i prodotti"_, restated as a closing action,
_"E dobbiamo abilitare tutti i prodotti."_ Fabrizio Paganelli accepted it as
temporary. ⚠ **Nobody said what activating the whole catalogue does to the live
UAT product list, or who reverses it.**

## Volumes, restated

| Period              | Order lines                   |
| ------------------- | ----------------------------- |
| From 1 January 2024 | ~30,000                       |
| From 1 January 2025 | ~9,000                        |
| `SW` platform lines | ~1,000, mostly 2024, deleted  |
| Orders not yet invoiced, today | **5** (he then counted 7 on screen) |

⚠ The 5/7 discrepancy is in the transcript and is not reconciled; he expects the
number to be larger at the real migration.

## Next steps as recorded

1. **[Fabrizio Paganelli]** mail Mirko Merendi to define the netto / listino /
   sconto field mapping — 🟢 **done the same afternoon**, and it produced the
   26/10 call request.
2. **[Fabrizio Paganelli]** send the finished migration list to Aurel Mrruku —
   _"appena finisci mandami l'el[enco]"_. ⚠ No date.
3. **[Both]** enable all products so the migration can run.

## ⚠ What this call did not touch

- **[OI-274](../items/OI-274%20The%20historical%20ticket%20balance%20has%20no%20migration%20path.md)**,
  the ticket-balance blocker escalated to ROMI the day before. **Not mentioned
  once.**
- **[OI-212](../items/OI-212%20A%20Ri.Ba.%20rate%20reads%20as%20paid%20before%20its%20due%20date.md)** —
  but the call restated the chain that runs through it, with Fabrizio Paganelli
  working it out aloud and agreeing it: the scadenzario names the invoice, the
  invoice names the order, the order lines are updated paid or unpaid from there.
  🔴 **The predicate doing that is the one this record calls wrong, unchanged a
  twelfth night.**
- **Zoho.** Not named. ⚠ Sixth consecutive run.
