---
id: meeting-2026-09-22-logiche-spacchettamento-righe
type: meeting
status: resolved
owner: Aurel Mrruku
org: both
raised: 2026-09-22
updated: 2026-09-22
source: Drive Gemini notes + transcript doc 1h1_w2X2un6AZGfXyrQGCxjjAqI0fVspKL1xR5Bqwizg (read in full)
---

# 2026-09-22 Logiche Spacchettamento Righe

**Client session, 1h06m54s, 22/09 11:22 CEST.** Aurel Mrruku, Elena Spini,
Fabrizio Paganelli, Elisa Migliano. Booked on 21/09 to finish the tranche
discussion that the 21/09 16:00 call cut short.

🔑 **This is the session that dismantles the previous night's headline.** The
tranche-to-invoice problem recorded in
[OI-143](../items/OI-143%20The%20tranche%20invoice%20date%20must%20be%20re-keyed%20by%20hand%20into%20Mexal.md)
rested on two assumptions Fabrizio Paganelli corrected here: that invoice date and
line due date must coincide, and that the date is the only join key. **Neither is
true, and the client already works the way the design needs.**

## How Plus orders actually work today

Fabrizio Paganelli demonstrated it live on Mexal. A Performance Plus sale is
**one order with n lines**, all carrying the **same article code** (`PLUS…`),
quantity 1, the listino price, a discount and a netto — and the **tutor types a
`data scadenza` on each line**, progressively (30/06, 31/07, …).

> _"Oggi come oggi facciamo un ordine con 12 righe tutte utilizzando plus…"_

The order then **passes unchanged** from Salesforce to Mexal —
_"passerà paro paro su Mexal"_ — and administration invoices each line at its own
period.

## The correction that matters

Aurel Mrruku: _"Avevamo detto che la data fattura e la data scadenza dovevano
coincidere."_ **They do not, by design.**

- The line due date is **commercial**: when the customer must pay. _"ai tutor non
  li possiamo far ragionare con la testa amministrativa."_
- Administration **translates** it: a line due 30/06 is invoiced **01/06**, so the
  customer pays by 30/06.
- 🔑 **The join key is structural, not the date.** Fabrizio Paganelli:
  _"lavorare sulla data di scadenza ci creerà dei casini in futuro. Noi dobbiamo
  lavorare su elementi strutturali delle tabelle."_
- 🔴 **And no automation may rest on scadenziario due dates at all**, because they
  move: a Ri.Ba. returned unpaid regenerates a new due date, and piani di rientro
  are agreed case by case. _"sulle date di scadenza è bene non fare nessun tipo di
  automatismo di programma perché è un casino."_
- The scadenziario carries **data, numero and codice cliente of the invoice**, so
  the chain is invoice → order → order line, and the tranche state follows from
  that. Aurel Mrruku: _"se è così è facile perché io non devo fare nessuna logica
  customizzata in base alla data di scadenza."_

🔴 **What the chain still needs is a shared order-line identifier.** Salesforce's
15/18-character id cannot travel to Mexal. Fabrizio Paganelli:
_"aggiungiamo un campo negli ordini dove ci sia un numero di riga ordine che possa
essere trasferito a Mexal… perché se non facciamo così ci salta per aria tutto il
castello."_ Subordinated to a technical check with Mirko Merendi —
[the 15:00 session](2026-09-22%20Test%20Mexal.md) took it up.
→ [OI-166](../items/OI-166%20The%20order%20line%20needs%20a%20shared%20identifier%20for%20Mexal.md)

## Agreed

1. 🟢 **Plus products explode from a tranche count held on the product.** One
   article code, one numeric field; entering it once generates n order lines with
   a date grid. Fabrizio Paganelli: _"potrebbe essere una cosa che facilita il
   lavoro di inserimento degli ordini da parte dei tutor"_; the field is
   Salesforce-only, _"uno di quei campi derivati"_. He will create a single code
   per cadence instead of `1 di 5`, `2 di 5` style codes. Instalment counts in use
   today: **5, 10 and 12** — and the mechanism is dynamic, so 8 is possible.
   → [OI-167](../items/OI-167%20Plus%20orders%20explode%20from%20a%20tranche%20count%20on%20the%20product.md)
2. 🟢 **Bundles already reach Mexal as their component articles**, each with its
   own due date — confirmed live, not inferred.
   → [OI-144](../items/OI-144%20Bundles%20must%20be%20split%20into%20order%20lines%20for%20Mexal.md)
3. 🟢 **The bundle total is spread over the components weighted by listino value
   and quantity, with a manual per-line override.** Fabrizio Paganelli's own use
   case is zeroing a free event inside a bundle and pushing the difference onto
   the other lines. He explicitly declined a cleverer algorithm: _"una volta che
   tu mi fai la regola che mi spalma il valore totale del bundle in modo ponderato
   rispetto al valore di listino, io sono a posto"_ — bundles are built by
   administration _"8-10 volte all'anno"_.
4. 🟢 **Old asterisk-prefixed article codes will be flagged `annullato`** to clean
   the registry.

## Left open in this session

- 🔴 **Per-line payment conditions.** Fabrizio Paganelli and Elisa Migliano want a
  coded condition (e.g. `A1` = 50% now, 50% later) instead of free text in the
  order notes — today administration reads the note and edits the payment method
  by hand before invoicing. Both suspected the condition exists only on the order
  header. Deferred to Mirko Merendi, and **settled against them** the same
  afternoon → [OI-160](../items/OI-160%20Payment%20conditions%20cannot%20vary%20by%20order%20line.md)
- 🔴 **The Mastery cannot be split.** _"il problema vero è la Mastery che costa
  6.0xx. Io non posso mettere più righe per lo stesso biglietto"_ — one ticket,
  one line, and a split payment plan on it has no mechanism. _"ragioniamoci."_
- 🔴 **The import data needs a line-by-line review.** Elena Spini objected that
  she cannot check every field: _"io non la posso controllare una per uno."_
  Fabrizio Paganelli kept the Zoho field names so re-extraction stays cheap, and
  offered as many calls as it takes: _"possiamo fare anche 10 call su questo
  argomento perché se scaziamo qui scaziamo tutto."_ **`Check Data Import` was
  booked in-session for 23/09 10:00–12:00.**
  → [OI-165](../items/OI-165%20Data%20migration%20was%20never%20planned%20or%20estimated.md)

## 🔑 `natura articolo` is the classification

Elena Spini queried the Mexal technical columns in the extraction. Fabrizio
Paganelli's answer supersedes the 21/09 reading:

> _"Natura è genera biglietto, solo bundle / non genera biglietto, solo bundle /
> genera biglietto, altri ordini / non genera biglietto, altri ordini. Era quella
> cosa che avevamo condiviso con Aurel."_

So the classification **is** in the extraction, encoded as a four-way Mexal code
rather than as two added flags. `tipo articolo` (`ACZZ`) is a Mexal-only technical
field and need not travel. Aurel Mrruku, on the same file: _"Ho visto già che ci
sono i campi per capire se devi generare un biglietto e fa parte di un bundle."_
→ [OI-154](../items/OI-154%20The%20client%20import%20extraction%20is%20missing%20the%20article%20classification.md)

## Calendar

- **23/09 10:00–12:00 `Check Data Import`** — booked in-session, client + Aurel
  Mrruku (invitation sent 22/09 10:12Z).
- **6 October UAT extended to 10:00–13:00** to fold in the Mexal invoicing logic
  and a WooCommerce walk-through. Fabrizio Paganelli asked that the commercial
  part sit next to a session Marco Montesi attends; 5 October was rejected by him
  because Mondays are exposed — _"il rischio che mi chiamino di là"_, as happened
  on 21/09.

## ⚠ Not ingested

The recording continues after the call ends and captures Fabrizio Paganelli
talking to colleagues about an unrelated customer payment, and a complaint that
**the client's marketing team does not read email** — a mail sent that morning to
Cristian, Sabatino Rinaldi and the marketing team went unanswered until he chased
it on WhatsApp. Only the mail-reading fact is recorded, and only because ROMI is
waiting on Sabatino Rinaldi by mail
([OI-14](../items/OI-14%20Marketing%20forms%20and%20subdomain.md)). **`Cristian` is
uncertain** — surname not stated, not in the people notes, and not added.
Everything else in that passage is personal and deliberately omitted.
