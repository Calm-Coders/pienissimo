---
id: OI-284
type: open-item
status: open
owner: Fabrizio Paganelli
with: Mirko Merendi
org: both
raised: 2026-10-22
updated: 2026-10-22
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

| Party              | Position                                                                 |
| ------------------ | ------------------------------------------------------------------------ |
| **Aurel Mrruku**   | Send **net price and list price only**; derive the discount. _"sconto viene calcolato in automatico per non avere problemi di scontistica."_ Rounding is why: _"25,2% in [Sales]force non coincide con 25,2% in ERP."_ |
| **Fabrizio Paganelli** | _"sarebbe più corretto usare solo la percentuale"_, dismissing the rounding exposure — _"se è 0,01 di differenza sul totale fattura cambia poco."_ |

🔑 **Mexal's own input rules make both forms necessary and neither sufficient**,
as he described them: a percentage discount is entered as `20`, a direct price
reduction as a **negative absolute value**. _"Ha delle regole abbastanza
stringenti."_

⚠ **The exchange ended because Elena Spini had to leave** — _"Noi dobbiamo
scappare"_ — not because anything was settled.

## 🟢 It produced an action the same day

| When (UTC)   | What                                                                                     |
| ------------ | ---------------------------------------------------------------------------------------- |
| **15:04:49** | Fabrizio Paganelli → Elena Spini, cc Mirko Merendi, `amministrazione@`, Aurel Mrruku (Gmail `1a16424bb89d3e8a`): _"ho parlato con Mirko poco fa per il tema prezzo di listino, sconti, e importo netto da passare sugli ordini. Avreste disponibilità per una call il prossimo lunedì 26, per definire la questione?"_ |
| **16:54:27** | Elena Spini: _"per noi è ok, avete preferenze di orario? … per noi è ok tranne 14-15."_ |

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
