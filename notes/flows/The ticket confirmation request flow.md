---
id: flow-ticket-confirmation-request
type: flow
status: active
owner: Fabrizio Mastracci
org: ROMI
raised: 2026-11-09
updated: 2026-11-12
depends_on: []
blocks: []
source: Slack C0C38JJ9D1T, 2026-11-09 16:41 CET
---

# The ticket confirmation request flow

**The flow that chases a participant for their ticket details. Written out in full
by its author on 9 November, in answer to Elena Spini, after months in which these
records held its trigger but not its stop conditions or its cadence.**

Source: Fabrizio Mastracci, marketing group DM, **2026-11-09 16:41:43 CET**, with
one screenshot ⚠ **not opened**. This is a description by the person who built it,
**not an org inspection** — nothing in this session looked at the flow metadata.

## When it starts

> _"Quando l'invito evento passa a **Stato Raccolta "Pronto"** e ha il **link
> registrazione** e la **data invio biglietto** compilati."_

🔑 **Three conditions, not one.** This record already held that `stato raccolta` →
`pronto` requires the event's order lines to be `pagato` (marketing group DM,
6 November); the registration link and the ticket-send date are additional gates
named here for the first time.

See [Proposed event invitations for participant registration](Proposed%20event%20invitations%20for%20participant%20registration.md).

## What it does

Sends the request mail, then the reminders. The cadence is data, not code:

> _"Il **Wait Interval 1** è l'attesa prima della mail 1, il 2 è l'attesa prima
> della mail 2, e così via. Dalla sezione Wait Interval della campagna puoi
> compilarne quanti ne vuoi e, come da loro richiesta, inserire tutti i valori che
> vogliono (ad esempio prime due mail wait di 2 gg, successive di 3 gg etc)"_

🔑 **So the number of reminders and the gap between them are per-campaign fields**,
filled in by the client's marketing side, not a ROMI configuration change.

## When it stops

Five exit conditions, as given:

1. the ticket is completed by the customer through the landing page;
2. the customer clicks **Rinuncia** in the mail or on the landing page;
3. **the event date has passed**;
4. **the next Wait Interval is empty** — _"Rebecca se ha un evento con 4 email
   compila per esempio da 1 a 4 … al 5 il flow vede il campo vuoto per quello
   specifico evento e quindi butta fuori la persona"_;
5. **fifteen mails have already gone out** — _"è il tetto massimo richiesto da
   loro"_.

🔑 **The empty-interval exit is the control the client actually uses**, and it
means a mis-filled campaign silently stops chasing rather than erring.

⚠ **Condition 2 is where [the rinuncia decision](../decisions/Decision%20-%20rinuncia%20moves%20from%20the%20marketing%20email%20to%20the%20community.md)
applies**; this description does not say which surface is live.

## The mail content

> _"Nella campagna, dentro Details sotto Wait Interval, c'è la sezione **"Campi
> dinamici mail"** (data, orari, luogo, indirizzo, parcheggio). Quello che scrivi
> lì compare nella mail."_

And the hand-off at the end: _"Quando il biglietto viene assegnato, **la mail col
biglietto parte da sola**."_

## Why this matters beyond documentation

1. 🔑 **It is the evidence base for the question Rebecca Marmo has to answer** —
   the timing between these sends and the event date, which the 9 November client
   review routed to her
   ([OI-350](../items/OI-350%20The%20R2%20date%20and%20the%20ticket%20email%20timing%20conditions%20need%20Rebecca.md)).
2. 🔑 **It bears directly on the reverse gear.** If a collection is reversed after
   these mails have gone out, the asset has to go back while the participant has
   already been chased — the objection Aurel Mrruku raised on 9 November
   ([OI-331](../items/OI-331%20A%20reversed%20collection%20cannot%20move%20the%20order%20and%20asset%20states%20back.md)).
   **Exit condition 3 is the only time-based brake, and it fires at the event, not
   at payment.**
3. ⚠ **These are the flows switched off for the order migration** and due back on
   after the 12-13 November delta
   ([OI-244](../items/OI-244%20Historical%20orders%20will%20be%20migrated%20from%20Mexal%20by%20spreadsheet.md)).
   With fifteen mails possible per participant, the reason for switching them off
   before loading 8,162 historical orders is now explicit.

## 🔴 The same flow is carried as broken in production

🔑 **This description does not mention a defect, and the record holds one.**
[OI-230](../items/OI-230%20The%20ticket%20confirmation%20request%20flow%20queries%20a%20relationship%20name%20as%20a%20field.md)
— **gating, open since 13 October** — says `Invio Richiesta conferma biglietto Flow`
queries `Event_Invitation__c` for `Recipient_Contact__r`, a relationship name rather
than a field, so the element can never succeed; it had already failed on 08/10 at
version 1 and was still failing at version 7.

⚠ **Whether that is fixed is not established by this description.** Fabrizio
Mastracci wrote out how the flow is meant to behave, in business terms, in answer to
a question about configuring it — **not as a status report** — and nothing in this
window states that the query error was corrected. **The two records must be
reconciled by someone who can open the flow.**

## Still unrecorded

- ⚠ **The flow's API name and the campaign object's field names.** The description
  is in business terms throughout.
- ⚠ **The landing pages.** Fabrizio Mastracci undertook the same morning, 09:02:24
  CET: _"entro fine gg ti passo le landing page"_. **Nothing in this sweep shows
  them delivered.**

## 🔑 2026-11-10 - walked on screen, and two rules were added

**On the [10/11 follow-up](../meetings/2026-11-10%20Follow-up%20Interno.md) Fabrizio
Mastracci showed the draft flow and the three descriptions above were confirmed
field by field — then two rules were found missing and added.**

### The entry conditions, as confirmed

| Condition | Field |
| --- | --- |
| Registration link present and published | `Link registrazione` |
| Collection state ready | label `Stato raccolta`, **API `status_G`** — _"la label e stato raccolta, ma l'API e status_G"_ |
| Send date reached | `Data invio biglietto`, **equal or greater than today** |

🔑 **It is an automatism on the record, not a batch**: _"e un automatismo sul record
che quando trova queste tre condizioni … parte l'invio."_ The loop runs on a step
counter: _"ogni step viene aggiunto un piu uno e la persona quindi a seconda dello
step riceve la stessa mail qui dentro, quindi lo step 1 riceve la mail 1, lo step 2
riceve la mail 2."_

🔑 **Fifteen reminders, not eleven** — _"ci sono 15 reminder. Non piu 11."_ The first
mail goes out immediately on entry; each later one is spaced by its wait interval,
which the client sets per campaign.

### The two rules that were missing

1. 🆕 **A send date in the future never fired.** Aurel Mrruku pressed it for eight
   minutes — _"deve succedere qualcosa per svegliare l'automatismo, per dire 'Guarda
   che oggi e il momento di inviare il primo reminder'"_ — and a formula will not do
   it: _"non fa scattare i flow, i trigger."_ Fabrizio Mastracci had only required
   the field to be non-empty: _"la data invio biglietto non deve essere vuota."_
   🆕 Field **`Invio_Oggi__c` on Event Invitation**, created the same evening, now
   carries the comparison — _"mi serve per calcolare che la data di invio biglietto
   sia uguale a oggi cosi passano solo biglietti della data corrente"_.
2. 🆕 **The exit on event end date had been written and lost.** Aurel Mrruku: _"se la
   data di fine evento … deve uscire da questo ciclo"_. Fabrizio Mastracci: _"La
   avevo messo la regola … perche quella e una regola vecchia. **Mi ero
   dimenticato.**"_

🔑 So the full window is **from `Data invio biglietto` to `Data fine evento`** —
_"il tempo in cui vengono mandate queste mail e dalla data invio biglietto fino alla
data del fine dell'evento"_ — and that is why backdating the end date suppresses the
flow entirely ([OI-353](../items/OI-353%20Production%20event%20end%20dates%20are%20backdated%20to%20stop%20ticket%20mails%20during%20the%20load.md)).

🟢 Reported complete on 12/11, relayed by Elena Spini on the client call: _"la logica
e gia stata fatta … quindi per invio dei biglietti tutto ok."_

### ⚠ Two test guards still in place

- **The recipient filter holds two ROMI addresses only** — Fabrizio Mastracci's and
  Elena Spini's — deliberately kept through the migration: _"non vorrei
  sinceramente che arrivassero cose ai clienti finali."_
- **The wait intervals are in minutes, not days**: _"adesso e messo a minuti perche
  siamo in fase di test."_

Both must come off when the flows are reactivated.

### 🔴 And the gating defect is still unnamed

[OI-230](../items/OI-230%20The%20ticket%20confirmation%20request%20flow%20queries%20a%20relationship%20name%20as%20a%20field.md)
has been gating since 13 October on a query that cannot succeed. **It was not
mentioned in this session either** — a second consecutive hour of work on this flow
without it coming up.
