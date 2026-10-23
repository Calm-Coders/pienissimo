---
id: OI-274
type: open-item
status: in-progress
owner: Aurel Mrruku
with: Fabrizio Paganelli
org: both
raised: 2026-10-21
updated: 2026-10-23
depends_on: [OI-244, OI-267, OI-276]
blocks: [go-live]
severity: gating
source: notes/meetings/2026-10-21 Check Dati Migrazione e OP.md
---

# OI-274 - The historical ticket balance has no migration path

**Customers hold about a thousand paid, unused tickets for events that have not
happened yet. A bulk order import does not create them: the Asset, its state and
the marketing link are all produced by the quote-acceptance automation, which a
spreadsheet load never runs. Neither party had this in scope, both said so on
the record, and the client escalated it to their project lead mid-call.**

Raised by Aurel Mrruku at `00:22:42` of
[the 21/10 morning session](../meetings/2026-10-21%20Check%20Dati%20Migrazione%20e%20OP.md)
and worked on for the rest of the day; a design exists as of
[the afternoon session](../meetings/2026-10-21%20Tema%20Migrazione.md) but nothing
is built.

## Why the import does not produce tickets

Aurel Mrruku, `00:22:42` and `00:38:21`:

> _"quando viene creato l'ordine da questa migrazione, non stiamo prevedendo la
> creazione degli asset con tutti gli stati degli asset … io non ho eseguito
> nessuna logica di creazione del biglietto, creazione delle asset."_

> _"Nel momento in cui un'offerta proprio viene accettata, viene firmata … c'è un
> meccanismo dietro le quinte che in base al prodotto che è stato aggiunto su
> quell'offerta viene generato un asset sull'ordine appena creato e questo asset
> per noi è il biglietto, solo che ha diversi stati."_

Four things are missing from a bulk load, in his own enumeration:

1. the Asset itself;
2. its state — and whether the client's states map onto Salesforce's at all
   (_"Se avete gli stessi stati voi con noi, se no come dobbiamo mappare gli
   stati?"_);
3. the marketing link object that joins the ticket to the campagna, with its
   date logic (_"data inizio campagna, data invio biglietto"_);
4. the physical ticket, which exists only once the community link is used —
   _"il biglietto fisico viene generato solo da community, dal link e non ce
   l'abbiamo e non l'abbiamo previsto."_

The edizione binding is the hard part: it is derived from the **order creation
date** through the mapping table, and in a bulk load every order carries the
load date. _"Tutte le date saranno quel giorno perché l'ordine è creato."_

## The client's case

Fabrizio Paganelli's worked example, `00:27:28` — a customer who bought in
September holds a Food Marketing Festival ticket (attended), a Pienissimo Live
ticket and an Academy ticket (both still to come), all invoiced and paid:

> _"su Zo[ho] quei biglietti si sono già generati e sono già disponibili perché ho
> già pagato tutto … Io volevo capire, se vi passo gli ordini completi così come
> sono, come funziona il cinema dei biglietti?"_

> _"non è che possiamo dire ai nostri clienti a te non viene l'evento perché
> abbiamo fatto la migrazione, non c'è il biglietto … Insomma, non possiamo non
> prevedere sta cosa."_

He noted the precedent: on the earlier Kip → Zoho migration the ticket balance
was moved customer by customer with a dedicated movement.

## 🔑 It was never in scope, and that is agreed

Aurel Mrruku:

> _"non era stato mai parlato di migrazione di biglietti, Fabrizio? … portare i
> biglietti da Zo[ho] in Sales Force? Mai."_

Elena Spini:

> _"c'è tanto di documento, di email, di qualsiasi cosa in cui si è parlato di
> migrazione solo di queste cose."_

Fabrizio Paganelli did not contest it: _"se era stato parlato, non parlato, non
lo so, è passato troppo tempo, però adesso ti sto chiedendo come facciamo?"_

🔴 **Sabatino Rinaldi, brought in at `00:32:55`, put the blame on ROMI** — the
sharpest client escalation in the record:

> _"tocca trovare una soluzione perché non è possibile arriva a sto punto dove non
> ci siam posti prima sto problema … io il 21 di ottobre stiamo parlando di queste
> cose da tanto tempo, quindi mi aspetto da parte vostra dovete portarci una
> soluzione."_

Aurel Mrruku rejected it: _"qua non sono per niente d'accordo con te … se tu non
mi dici che voglio questi record in sales force, come ti devo dire io come portare
questi record in sales?"_ ⚠ **No ruling was made on whose omission it was, and no
change request was raised** — unlike OI-259, nobody in the room used the word.

## Volume

| Source | Figure |
| ------ | ------ |
| Fabrizio Paganelli | _"saranno un migliaio, secondo me"_ |
| Sabatino Rinaldi | _"Sì, dai, saremo lì. Non superiamo i migliori [il migliaio]"_ |

Aurel Mrruku's threshold for doing it by hand was **500** — _"stiamo parlando di
500 facciamo a mano … perché ci mettiamo 3[-]4 giorni"_ — and doing it by hand
means running the whole procedure per customer anyway, i.e. a zero-value quote
and order per customer. He also warned the manual route is not simply available:
_"Ma non hai le strutture per farlo a mano. Non è stato previsto di farlo a mano …
Non si può fare. Si deve sviluppare qualcosa da parte per forza."_

## The design that now exists

From [the afternoon session](../meetings/2026-10-21%20Tema%20Migrazione.md):

- Tickets **are** generated by the import, for every line, against editions
  prepared in advance and matched on **invoice date** instead of order date.
- History that must not produce live tickets goes against **dummy editions** and
  the tickets are then mass-deleted —
  [OI-276](OI-276%20Dummy%20import%20editions%20are%20needed%20to%20load%20historical%20orders.md).
- 🟢 **Pienissimo Live 2026 is taken out of the problem entirely**: its edizione
  will not exist in Salesforce and the November event runs on Zoho.
- Corrections afterwards: a tutor can cancel an Asset by hand, but **adding** a
  ticket needs a script or a zero-value quote-and-order run by Aurel Mrruku,
  because _"il biglietto è legato a un prodotto che è legato a una campagna."_

## Still open

- 🔴 Nothing is built. The code conditions are Aurel Mrruku's, estimated at
  **2–3 days, 4 at worst**, in UAT only.
- ⚠ Whether the client's ticket states map onto the Salesforce Asset states —
  he asked for the structure, _"campi, valori sui campi"_, and Fabrizio
  Paganelli undertook to supply it. Not sent as of this sweep.
- ⚠ The Pienissimo Live ticket-send question is answered both ways inside one
  call; see the afternoon note.
- ⚠ `Pienissimo 360`, offered by Sabatino Rinaldi as an alternative route into
  Salesforce by API, appears in no project record and nobody has evaluated it.

## 2026-10-23 - ROMI answered in writing, and the subject vanished from the room

🟢🔑 **The escalation has a written answer.** Elena Spini, Gmail
`1a158b6e3e4cee81` message `1a1683c78db0218b`, **10:09:04Z**, to Sabatino
Rinaldi and Fabrizio Paganelli with the client's whole project group in copy:

> _"ci tengo a segnalare che stiamo facendo il possibile per includere anche i
> requisiti per la migrazione dei biglietti arrivati in settimana, sebbene non
> fossero previsti nella pianificazione iniziale né nel BBP approvato"_

This is the first ROMI reply to _"mi aspetto da parte vostra dovete portarci una
soluzione"_ and it does two things at once:

- 🟢 **Accepts the work** — _"stiamo facendo il possibile per includere"_.
- 🔑 **Puts the scope objection on the record, naming the approved BBP**, which
  is stronger than the verbal _"Mai"_ of 21 October because it cites a document
  rather than a recollection.

⚠ **It still does not answer his question.** He asked *how* the tickets get into
Salesforce. The mail gives **no mechanism, no date and no owner**, and
🔴 **nothing has been built** since.

⚠ **It is not called a change request.** The CR ask in the same mail is
explicitly _"in futuro"_ —
[OI-285](OI-285%20ROMI%20asked%20the%20client%20to%20route%20future%20out%20of%20scope%20requirements%20through%20change%20requests.md).
🔑 **So this item is being absorbed with the objection recorded and no
commercial consequence attached.** That is a deliberate choice and it is
nobody's stated decision.

🔴 **The client did not respond to this paragraph.** They answered the calendar
part of the same thread at 10:41:34Z and said nothing about the tickets or the
BBP — see [OI-268](OI-268%20The%20client%20proposed%20a%20go-live%20calendar%20of%2016%20November.md).

### ⚠ And it was not mentioned in the day's client call

[The 16:00 call](../meetings/2026-10-23%20Import%20Ordini%20Migrazione.md) ran
six minutes on the product registry and never reached it. **Second consecutive
client call with no mention**, two days after the client's own project lead made
it ROMI's problem, and on the day ROMI answered it in writing. Nothing from
Fabrizio Paganelli's side acknowledges the answer.

### Still unanswered from the 21/10 list

- ⚠ The client's **ticket field and value structure** — undertaken by Fabrizio
  Paganelli, **not sent**, now three days.
- ⚠ **`Pienissimo 360`** — still appears in no project record and nobody has
  evaluated it.
- 🔴 **2–3 days of UAT build**, unstarted, against a first import on ~9 November
  and a production extract due **13 November 09:00**
  ([OI-268](OI-268%20The%20client%20proposed%20a%20go-live%20calendar%20of%2016%20November.md)).
