---
id: meeting-2026-11-10-follow-up-interno
type: meeting
status: resolved
owner: Elena Spini
with: Aurel Mrruku, Fabrizio Mastracci
org: ROMI
raised: 2026-11-10
updated: 2026-11-12
depends_on: []
blocks: []
source: Drive 1m5nSMyFT_9VpZlK9mbK_NpKl14FZ1zwllfmFpL0GbfA
---

# 2026-11-10 - Follow-up Interno

**Forty-two minutes, Elena Spini, Aurel Mrruku and Fabrizio Mastracci. The ticket
send flow was walked screen by screen and two rules were found missing from it;
the production event dates were agreed to be backdated to stop real customers
being mailed during the migration; and the Referenti decision was reported back.**

## Attendees

- **Elena Spini** (ROMI)
- **Aurel Mrruku** (ROMI)
- **Fabrizio Mastracci** (ROMI, marketing build)
- 🔴 **Nobody from Pienissimo.**

## Sources

| | |
| --- | --- |
| Gemini notes + full transcript | Drive `1m5nSMyFT_9VpZlK9mbK_NpKl14FZ1zwllfmFpL0GbfA`, 30,314 chars, **read in full** |
| Duration | **00:41:42** |
| Recording | `1U6n_m7CuKi2yzdrfEI7kw_bNXsoQ4eZT`, **467 MB, not opened** |
| ⚠ | **No separate transcript document exists** — notes and transcript are one file |

## The ticket send flow, as its author describes it

🟢🔑 Three entry conditions, confirmed by Fabrizio Mastracci:

| Condition | Field |
| --- | --- |
| Registration link present and published | `Link registrazione` |
| Collection state ready | label `Stato raccolta`, **API `status_G`** |
| Ticket send date reached | `Data invio biglietto`, _"equal or greater … today"_ |

**It is an automatism on the record, not a scheduled batch**: _"e un automatismo
sul record che quando trova queste tre condizioni … parte l'invio."_ The reminder
loop is **15 reminders, not 11**, driven by a step counter — _"ogni step viene
aggiunto un piu uno e la persona quindi a seconda dello step riceve la stessa
mail"_ — with exits on completion, on the Rinuncia CTA, and on the wait-interval
running out.

## The two rules that were missing

1. 🔴 **A send date in the future never fires.** Aurel Mrruku pressed it for eight
   minutes: _"deve succedere qualcosa per svegliare l'automatismo"_. Fabrizio
   Mastracci: _"In questo momento non lo posso fare perche la data io prima da
   regola vecchia facevo che la data invio biglietto non deve essere vuota."_ A
   formula will not do it — _"non fa scattare i flow, i trigger"_.
2. 🔴 **The exit on event end date had been written and lost.** Aurel Mrruku:
   _"devi fare anche un controllo che se la data di fine evento e oggi o e maggiore
   di oggi deve uscire da questo ciclo."_ Fabrizio Mastracci: _"La avevo messo la
   regola … perche quella e una regola vecchia. **Mi ero dimenticato.** Hai
   ragione."_

🆕 A new field **`Invio_Oggi__c` on Event Invitation** was created by Fabrizio
Mastracci later the same evening (marketing group DM, 17:54 CET) to carry the
date comparison. ⚠ Not verified in the org by this run.

See [the ticket confirmation request flow](../flows/The%20ticket%20confirmation%20request%20flow.md)
and 🔴 [OI-230](../items/OI-230%20The%20ticket%20confirmation%20request%20flow%20queries%20a%20relationship%20name%20as%20a%20field.md)
— **a second consecutive session editing this flow in which nobody names the
`Recipient_Contact__r` query that cannot succeed.**

## Test guards that must come off before go-live

⚠ **Wait intervals are set in minutes for testing** — _"adesso e messo a minuti
perche siamo in fase di test"_ — and are to become days.
⚠ **The recipient filter holds two ROMI addresses only**, Fabrizio Mastracci's and
Elena Spini's. He asked to keep it on through the load: _"non vorrei
sinceramente che arrivassero cose ai clienti finali."_

## The decision to backdate production event dates

🔑 Aurel Mrruku proposed setting `Data fine evento` on the live editions to **1
November**, before the invoice and scadenziario load, so no ticket mail can leave:
_"Metterei la data dell'evento fine evento l'1 di novembre, fin quando carichiamo.
Poi quando carichiamo abbiamo finito, non so, **il 30 di novembre** gli mettiamo la
data"_. Emptying the field is not an option — _"se e senza data gli va in errore il
flusso"_. The edition named is **Pienissimo Live**, the 24th.
→ [OI-353](../items/OI-353%20Production%20event%20end%20dates%20are%20backdated%20to%20stop%20ticket%20mails%20during%20the%20load.md)

## Also agreed

- 🟢 **WooCommerce `plus` orders are all acceptances, never new sales** — they are
  stage orders, and that flag decides whether the contract chain runs →
  [the decision](../decisions/Decision%20-%20WooCommerce%20plus%20orders%20are%20acceptances.md).
- 🔑 The Referenti outcome was reported: Lead standard, `lead from zoho` true plus
  a `referenti marketing` flag, cleanup on the client →
  [OI-351](../items/OI-351%20Referenti%20without%20a%20Mexal%20code%20are%20imported%20as%20marketing%20leads.md).
- ⚠ **Landing pages**: Fabrizio Mastracci was to send the HTML forms to Sabatino
  Rinaldi and Matteo Distaso in a new chat. **Still not evidenced delivered.**
- A marketing walkthrough for the client was sought for this week and slipped;
  it was finally booked on 12/11 for **Thursday 19 November 09:30**.
