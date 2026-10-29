---
id: OI-284
type: open-item
status: in-progress
owner: Fabrizio Paganelli
with: Mirko Merendi
org: both
raised: 2026-10-22
updated: 2026-10-26
depends_on: [OI-207, OI-244]
blocks: [go-live]
source: notes/meetings/2026-10-22 Check Excel Migrazione.md
---

# OI-284 - The listino sconto and netto mapping for Mexal orders is undefined

**An order leaving Salesforce must carry list price, discount and net price into
Mexal, and no one has said which Mexal fields those are. The Salesforce fields
exist. The Mexal side is Kreosoft's to name, the client has now asked them, and
a call is requested for Monday 26 October — three weeks before go-live, with the
two parties already disagreeing about whether the discount travels as a
percentage or an amount.**

Raised at `00:26:29`–`00:28:32` of
[the 22/10 session](../meetings/2026-10-22%20Check%20Excel%20Migrazione.md).

## The requirement, in the client's words

> _"quando si genera l'ordine bisogna che ci portiamo tutte queste informazioni,
> prezzo di listino, sconti, netto … non possiamo fare delle fatture solo al
> netto"_

🔑 **The reason is invoicing, not display.** A Pienissimo invoice has to show what
the customer was charged against the list price; a net-only line cannot produce
it.

## Where it stands

🟢 **Salesforce is ready.** Aurel Mrruku, three times in ninety seconds:
_"io ce li ho i campi"_, _"ce l'hai per forza"_, _"basta che Mirko mi dica …
quali sono da mappare."_ This row is therefore **not ROMI build work** until the
mapping exists.

🔴 **Mexal is not named.** Aurel Mrruku pushed it straight back to the client —
_"Dovevi parlare con Mirko"_ — and told him to mail Kreosoft from the call:
_"manda direttamente una mail adesso a Mirko, così ci indica."_

## 🔴 The open disagreement: percentage or amount

This is the substance and it is **unresolved**.

| Party                  | Position                                                                                                                                                                                                               |
| ---------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Aurel Mrruku**       | Send **net price and list price only**; derive the discount. _"sconto viene calcolato in automatico per non avere problemi di scontistica."_ Rounding is why: _"25,2% in [Sales]force non coincide con 25,2% in ERP."_ |
| **Fabrizio Paganelli** | _"sarebbe più corretto usare solo la percentuale"_, dismissing the rounding exposure — _"se è 0,01 di differenza sul totale fattura cambia poco."_                                                                     |

🔑 **Mexal's own input rules make both forms necessary and neither sufficient**,
as he described them: a percentage discount is entered as `20`, a direct price
reduction as a **negative absolute value**. _"Ha delle regole abbastanza
stringenti."_

⚠ **The exchange ended because Elena Spini had to leave** — _"Noi dobbiamo
scappare"_ — not because anything was settled.

## 🟢 It produced an action the same day

| When (UTC)   | What                                                                                                                                                                                                                                                                                                                   |
| ------------ | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **15:04:49** | Fabrizio Paganelli → Elena Spini, cc Mirko Merendi, `amministrazione@`, Aurel Mrruku (Gmail `1a16424bb89d3e8a`): _"ho parlato con Mirko poco fa per il tema prezzo di listino, sconti, e importo netto da passare sugli ordini. Avreste disponibilità per una call il prossimo lunedì 26, per definire la questione?"_ |
| **16:54:27** | Elena Spini: _"per noi è ok, avete preferenze di orario? … per noi è ok tranne 14-15."_                                                                                                                                                                                                                                |

⚠ **No slot was fixed** at the time of this sweep, and ⚠ **nothing records what
Mirko Merendi told him** — the mail reports the conversation, not its content.

## Why it is `blocks: go-live`

The agreed calendar puts the technical release at ~9 November and Salesforce live
on 16 November
([OI-268](OI-268%20The%20client%20proposed%20a%20go-live%20calendar%20of%2016%20November.md)).
An order that reaches Mexal without the price breakdown produces a wrong invoice
on the first live day, and the mapping has to be agreed, built and tested before
then. **At the time of writing the first step — a meeting — has no hour.**

## ⚠ And it is the fifth session on discounting with `SAL-12` uncited

`SAL-12` in the register reads _"Tutors on fixed price list, no discretionary
discounts"_, `status: agreed`. A client-led call is now booked to define how
discounts travel to the ERP. **Neither party has cited the requirement in any of
the five sessions where discounting has been discussed.** Reported for a human,
as on 19/10, 20/10 and 21/10 — the register is not amended from a note.

## What closing it looks like

Kreosoft names the Mexal fields for list price, discount and net; the percentage
vs amount question is decided on the record with the rounding exposure stated;
the mapping is built and one order is verified end to end in UAT against a Mexal
invoice.

## 2026-10-23 - the call has an hour, the gap is narrower than this note said

### 🟢 The meeting is fixed

|                                      |                                                                                                              |
| ------------------------------------ | ------------------------------------------------------------------------------------------------------------ |
| **Title**                            | `[ROMI-PIENISSIMO] - Tema Ordini Mexal`                                                                      |
| **When**                             | **Monday 26 October 2026, 11:00–12:00 (GMT+1)**                                                              |
| **Agenda, verbatim from the invite** | _"Tema prezzo di listino, sconti, e importo netto da passare sugli ordini"_                                  |
| **Invited**                          | Aurel Mrruku, `amministrazione@pienissimo.com`, **Mirko Merendi (`mirko@kreosoft.com`)**, Fabrizio Paganelli |
| **Sent**                             | Elena Spini, 2026-10-23T07:40:11Z (Gmail `1a167b3fe401b85f`)                                                 |

How it was settled: Fabrizio Paganelli 06:23:24Z — _"Per me sarebbe meglio la
mattina dalle 11.00 in poi"_; Elena Spini 07:40:44Z — _"Ho mandato il meeting,
se dovessero esserci problemi di orario, fatemi sapere."_

🟢 **The "no hour fixed" warning above is closed.** ⚠ Note the invite says
**GMT+1**: European summer time ends on 25 October, so this is 11:00 CET, the
day the clocks change.

🔑 **Kreosoft is in the room.** This is the first meeting in the record that
invites Mirko Merendi, which is what the 22/10 blocker needed — the Mexal field
names are his to give.

### 🟢🔑 `netto` already reaches Mexal — the gap is the list price

From [the 16:00 call](../meetings/2026-10-23%20Import%20Ordini%20Migrazione.md),
Aurel Mrruku:

> _"io aspetto a sto punto solo Mirco [Mirko] di indicarmi qual è il campo
> sull'ordine, sulla riga dell'ordine più che sull'ordine te la posso far passare
> anche l'amount netto, quindi di listino, scusa che il netto lo passiamo già"_

Three corrections to the 22/10 account:

1. 🟢 **`netto` is not missing.** _"il netto lo passiamo già"_ — it is already
   transmitted. What is undefined is **listino** (and therefore the discount).
2. 🔑 **The missing field is on the order _line_**, not the header — _"sulla
   riga dell'ordine più che sull'ordine."_
3. 🟢 **ROMI's only dependency is Kreosoft.** _"aspetto … solo Mirco"_ — no ROMI
   build work is blocked on anything else.

### 🟢 The client sent a worked example for the call

Fabrizio Paganelli, 2026-10-23T13:15:53Z on the `Richiesta Call` thread
(`1a16424bb89d3e8a`), to Elena Spini and Aurel Mrruku, cc
`amministrazione@pienissimo.com` and Mirko Merendi:

> _"Per l'incontro di lunedì, vi inoltro un esempio di Fattura, dove nelle due
> righe potete vedere le 2 modalità di gestione degli sconti."_

Attachment: **`Esempio SCONTI.pdf`**, ~880 KB.

🔑 **It is the first artifact in the record that shows both discount forms
side by side on one document**, which is exactly the thing the 22/10
disagreement lacked — the percentage form and the negative-absolute form on two
lines of the same invoice.

⚠ **It was not opened by this sweep.** It is a **real customer invoice**: it
carries a customer, catalogue prices and article-code values, all of which the
publishing rules keep out of these records. Recorded by filename, sender,
recipients, timestamp and stated purpose only.
🔴 **A human has to open it before Monday** — it is the agenda document.

### ⚠ Unchanged

- 🔴 **The percentage-versus-amount disagreement was not reopened** on 23/10 and
  stands exactly as the table above records it.
- ⚠ **Still nothing records what Mirko Merendi told Fabrizio Paganelli** on
  22 October. Three sources now refer to that conversation — the 22/10 mail, the
  23/10 invite agenda and the call — and **none contains its content.**
- 🔴 **`SAL-12` is uncited for a sixth session.** A client call with the ERP
  vendor is now booked to define how discounts travel, while the register reads
  _"no discretionary discounts"_, `status: agreed`. Reported for a human, as on
  19/10, 20/10, 21/10 and 22/10 — the register is not amended from a note.
- 🔴 Against a **9 November production deploy** and **16 November live**
  ([OI-268](OI-268%20The%20client%20proposed%20a%20go-live%20calendar%20of%2016%20November.md)),
  the mapping has 14 days to be agreed, built and verified end to end.

## 2026-10-26 - Mexal gave the format, and it is built in source

🟢 **The format is settled.** Aurel Mrruku, relaying Mexal on 26/10 (the day of
the `Tema Ordini Mexal` call; ⚠ the call itself is not drilled in this record):
the order carries a line-level `sconto` array, one `[line number, "-amount"]`
pair per discounted line. The leading `-` means an **amount, not a
percentage**, and Mexal **divides it by the line quantity** — a `"-1000"`
discount on a quantity-2 line is 500 per item.

🔑 **So the percentage-versus-amount question above is closed: amount.** And
because Mexal subtracts the discount from `prezzo`, `prezzo` must now be the
**pre-discount** price — sending the net, as before, would discount twice.

**What was built (source only, not deployed, not committed):**

- **`OrderItem.Prezzo_Listino__c`** (Currency) — the unit price before the
  discount. `UnitPrice` stays the net, so totals, tranches, payment schedules
  and invoice matching are unchanged.
- **`QuoteTriggerHandler`** fills it at quote-to-order conversion from the quote
  line: net `UnitPrice` and `Discount_Pct__c` rebuild the pre-discount price;
  the catalogue `ListPrice` is used when it matches (Items, bundle
  components), the rebuilt price otherwise (Plus tranches, whose `ListPrice` is
  the whole product's). A line with no discount gets no value.
- **`MexalOrderSendService`**: for a line with `Prezzo_Listino__c` above
  `UnitPrice`, `prezzo` is the pre-discount price and `sconto` is
  `-(Prezzo_Listino__c - UnitPrice) × Quantity`; Mexal's division lands
  exactly on the net. Lines without it are sent as before, and `sconto` is
  omitted when no line has one.
- `Full_Permission` read-only FLS on the new field. Validated by dry run in UAT.

⚠ **Open:**

- **Only quote-converted orders carry the discount.** WooCommerce and migrated
  orders have no `Prezzo_Listino__c` and are sent as before; WooCommerce's
  `discount_total` is not mapped.
- **Orders already converted** before this change have no value and send no
  discount.
- 🟢 **The decimal form is answered.** Mirko Merendi to Aurel Mrruku by mail,
  26/10: **comma** separator, **at most two decimals**. `MexalOrderSendService`
  now sends `"-1500"`, `"-12,5"`, `"-0,05"` (checked in UAT by anonymous Apex);
  the amount is already rounded to two decimals. ⚠ Still not sent to Mexal
  end to end.
- **[OI-283](OI-283%20Discounts%20cannot%20be%20edited%20on%20an%20existing%20order.md)**:
  when discount editing on an existing order is built, it must maintain
  `Prezzo_Listino__c` too.
- **Prod lacks `QuoteLineItem.Discount_Pct__c`**, so this ships with the quote
  discount feature, and as Apex it falls under
  [the coverage gate](../risks/Risk%20-%20production%20deploy%20is%20blocked%20by%20Apex%20coverage.md).

## 2026-10-26 - deployed to Prod

🟢 `OrderItem.Prezzo_Listino__c`, `QuoteLineItem.Discount_Pct__c`, the
conversion and the `sconto` send went to Prod with the DevMain deploy
`0AfSW000001K5Kj0AK`; a test covers the payload (`prezzo` = list price,
`sconto` = `"-100,5"`). ⚠ **Still no discounted order sent to Mexal end to
end**, and `Full_Permission` read access on the new field came with the
permission-set deploy.

## 2026-10-26 - the mapping is defined, and the build contradicts it

🟢🔑 **This row's question is answered.** Kreosoft attended
[the 11:00 call](../meetings/2026-10-26%20Tema%20Ordini%20Mexal.md) — the first
meeting in the record that includes them — and Mirko Merendi named the mechanism
at `00:05:00`: `prezzo` carries the **list price**, `sconto` carries the
discount, and Mexal derives the line value — _"c'ha il prezzo e c'ha lo sconto e
poi lui ricalcola il valore della riga."_ Two forms, distinguished by sign: an
**amount** with a leading minus (_"Basta che te passi lo sconto con il meno
davanti"_), a **percentage** as a bare number (_"basta che passi il numero senza
il meno"_).

🟢 **The 22/10 disagreement resolved itself**: Aurel Mrruku took the amount form
— _"se ti passo sconto valore ancora meglio"_ — and Fabrizio Paganelli, who had
argued for percentages, did not reopen it.

🟢 **The decimal form came by mail the same day.** Mirko Merendi to Aurel Mrruku,
14:27:33Z (Gmail `1a1789d5116a2788`), answering a question sent at 13:39:55Z:
**comma** separator, **at most two decimals**. And at 11:56:24Z, before the
details: _"Nel prezzo unitario su Mexal devi inserire il prezzo di listino e poi
applicare lo sconto. In questo modo, Mexal calcolerà automaticamente il prezzo
totale della riga del prodotto."_ 🔑 So the **unit-price field now carries
listino where it used to carry netto** — the same field, different content.

🔴🔑 **But the per-unit rule was missed, and the build is wrong.** Mirko Merendi
said twice that the value discount applies **per unit** and the sender must
divide by the line quantity, and Fabrizio Paganelli restated it and named the
consequence — _"Altrimenti dopo sbagliamo veramente a fatturare se non è così."_
The code committed at 14:30 CET and deployed to production that afternoon
**multiplies** by quantity instead. Raised as
[OI-287](OI-287%20The%20Mexal%20line%20discount%20is%20sent%20as%20a%20line%20total%20instead%20of%20per%20unit.md),
which supersedes the claim in this note's own 26/10 build section that _"Mexal
divides it by the line quantity"_ — ⚠ **that sentence is unsourced and is
contradicted by the call it cites.**

🟢 **Rounding is settled as a tolerance, not a mechanism.** Mexal's rounding is
not configurable — _"gli arrotondamenti non si toccano"_ — and both sides waived
the exposure aloud: Fabrizio Paganelli, _"quando facciamo la fattura, se c'è un
centesimo non me ne frega niente. L'importante è che non si fermino gli
ordini."_ ⚠ Aurel Mrruku's worked case (a €1,000 discount over three units, _"per
tre periodico"_) was acknowledged and not solved.

⚠ **Quantities above one are not rare.** Mirko Merendi guessed _"al 95% loro
hanno sempre quantità uno"_; Fabrizio Paganelli corrected him on the spot —
_"abbiamo anche spesso diversi casi dove abbiamo le quantità due"_, possibly
three.

⚠ **The Mexal field name is still not in this record.** Aurel Mrruku asked for
it and Mirko Merendi **pasted an example into the Google Meet chat**, which the
transcript does not capture. Four sources now refer to what Kreosoft specified
and none contains the field name.

🔴 **Still no discounted order sent to Mexal end to end** — and when one is sent,
it must use **quantity 2**, or it will pass while wrong.
