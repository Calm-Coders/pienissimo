---
id: flow-ticket-confirmation-request
type: flow
status: active
owner: Fabrizio Mastracci
org: ROMI
raised: 2026-11-09
updated: 2026-11-09
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
