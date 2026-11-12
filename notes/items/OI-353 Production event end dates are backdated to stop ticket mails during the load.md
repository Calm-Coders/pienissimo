---
id: OI-353
type: open-item
status: in-progress
owner: Aurel Mrruku
with: Fabrizio Paganelli, Elisa Migliano
org: both
raised: 2026-11-10
updated: 2026-11-12
depends_on: [OI-230]
blocks: [go-live]
severity: high
source: notes/meetings/2026-11-10 Follow-up Interno.md
---

# OI-353 - Production event end dates are backdated to stop ticket mails during the load

**To keep the invoice and scadenziario migration from mailing real ticket links to
real customers, the live editions' `Data fine evento` is deliberately set to a past
date in production. The guard was agreed on 10 November and applied on 12 November.
🔴 The date it must be restored to was never fixed, and if the restore is missed no
ticket will ever be sent for those editions — silently.**

## Why the guard is needed

The ticket nomination mail fires on a record automatism, not a batch: registration
link present, `Stato raccolta` ready, `Data invio biglietto` reached, and —
after 10/11 — only while `Data fine evento` is still in the future. The migration
loads invoices and collections, which push assets to `Disponibile`, which is the
trigger. Aurel Mrruku, on the 10/11 call:

> _"essere sicuri che quando ci facciamo l'aggiornamento dei biglietti … la data
> fine evento in sales force dell'evento di adesso **lo dobbiamo mettere un giorno
> prima del giorno in cui faremo l'import** delle fatture, delle scadenze, cosi in
> automatico siamo sicuri che non mandiamo i biglietti"_

🔴 **Emptying the field is not an option**: _"se e senza data gli va in errore il
flusso."_

## What was set

| | |
| --- | --- |
| Value agreed | **1 November 2026** — _"Metterei la data dell'evento fine evento l'1 di novembre, fin quando carichiamo"_ |
| Restore date named | ⚠ _"non so, **il 30 di novembre** gli mettiamo la data"_ — a guess, in a sentence beginning "I don't know" |
| Editions affected | **Pienissimo Live 2026** (the event of the 24th-26th) and, added on 12/11, **Pienissimo Intensive** — _"Anche l'intensi\[ve\] sarebbe meglio evitare che partano i biglietti"_ |
| Who | agreed as Aurel Mrruku's job on 10/11 — _"Lo cambio io"_ — **done by the client instead** |

🔑 **The fields were not on the layout.** On the 12/11 client call Aurel Mrruku
found `Data fine evento`, `Data inizio evento`, `Data invio biglietto` and `Data
evento` present in production but absent from the Edizione record page, and added
them **directly in production**, mid-call: _"li metto direttamente in produzione,
poi li aggiustiamo."_ ⚠ Another undocumented direct production edit.

🟢 **Applied the same afternoon by the client.** Fabrizio Paganelli, 13:43:15Z:
_"per essere piu sicuri che non partano involontariamente i biglietti, abbiamo
pensato di impostare le Edizioni 'vecchie' in questo modo"_ (with a screenshot).
Aurel Mrruku approved at 15:21:34Z: _"Mi torna. **Piu condizioni non sodisfatti
sono meglio e.**"_ Confirmed done at 16:35:54Z: _"abbiamo sistemato l'anagrafica
degli eventi/edizioni."_

⚠ The screenshot was **not opened**, so the exact values written are not recorded
here.

## The risk that remains

1. 🔴 **No restore date and no owner.** The field is used by nothing else — _"questa
   data e usata solo in questa casistica"_ — so nothing will fail loudly. If it is
   not restored, **no nomination mail is ever sent for those editions, in silence.**
2. 🔴 **Pienissimo Live runs 24-26 November**, inside the window the date is
   suppressed for, and its tickets are Zoho's anyway —
   [OI-361](OI-361%20Pienissimo%20Live%20attendance%20cannot%20be%20recorded%20in%20Salesforce.md).
3. ⚠ The second guard, the **test recipient filter holding two ROMI addresses**, is
   also still on and must come off at the same time — and the wait intervals are
   still **in minutes**, not days.
4. 🟢 Aurel Mrruku proposed a bounded live check instead of a blind load: _"forse
   conviene domani … non prendo tutti scadenziari\[o\], ma prendo solo 5 6 10 non so,
   per vedere se parte il flusso di marketing."_

## What is owed

- A real restore date, an owner for it, and a check that the mails then flow.
- Confirmation to the client that the dates on their own records are temporary —
  ⚠ it was agreed on 10/11 that they would be told _"prima di fare la
  migrazione"_; they were told on 12/11 and proposed it themselves, so this is met.
