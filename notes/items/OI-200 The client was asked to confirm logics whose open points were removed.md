---
id: OI-200
type: open-item
status: open
owner: Elena Spini
org: ROMI
raised: 2026-10-01
updated: 2026-10-01
depends_on: [OI-197]
blocks: [OI-184]
source: notes/The agreed Asset and ticket send logic document.md
---

# OI-200 - The client was asked to confirm logics whose open points were removed

**Elena Spini asked Pienissimo in writing to confirm the ticket logics. The copy
they received is the internal document with two sections cut, and one of the two
is a list of seven questions headed `Open point da confermare con il cliente`.
The people who were supposed to answer them were not shown them.**

## What happened

| Time (01/10) | Event |
| --- | --- |
| 12:17 CEST | Elena Spini posts the internal document to the marketing group DM |
| 12:19 CEST | _"al cliente darò un'altra versione senza la parte di op e possibili problemi"_ |
| 12:23 CEST | Aurel Mrruku: _"OK , GRZ"_ |
| 18:16–18:22Z | The client version is created and edited |
| 18:25Z | Mailed to Fabrizio Paganelli, Rebecca Marmo, Sabatino Rinaldi, Marco Montesi, `amministrazione@`, cc Aurel Mrruku |

The request:

> _"Vi chiedo cortesemente di darmi riscontro a questa mail per conferma di
> avvenuta lettura e di presa visione del documento condiviso e **conferma delle
> relative logiche**."_

## 🔴 The distinction that matters

Two sections were removed and they are not the same kind of thing.

- **`POSSIBILI PROBLEMI`** is headed _"Nota interna, da rimuovere prima dell'invio
  al cliente."_ 🟢 **Removing it is correct** — it is ROMI's own risk review and
  it says so.
- **`Open point da confermare con il cliente`** is, by its own heading, **the list
  of things the client is supposed to decide**. 🔴 Removing it leaves the client
  confirming a flow whose seven undecided points ROMI has already identified, and
  **it removes the one chance this mail had to close them**.

⚠ Nothing in the record suggests this was deliberate concealment. Elena Spini's
Slack line collapses both sections into _"op e possibili problemi"_ and she had
been working past 21:00 the night before. The effect is the problem, not the
intent.

## 🔴 What stays unanswered

The seven points are listed in full in
[the document note](../The%20agreed%20Asset%20and%20ticket%20send%20logic%20document.md).
Three of them are live blockers rather than details:

- **When the link goes out.** The document ties it only to the first `Disponibile`
  asset. The internal review's first and highest-rated problem is that this
  ignores the edition's `Data_Invio_Biglietto__c` and would open nomination up to
  eleven months early — **a case Fabrizio Paganelli explicitly excluded at the
  30/09 UAT**. The client has not been asked to confirm the rule that the client
  himself set.
- **Who manually unlocks a payment that lands too late.** An unassigned operational
  duty, five days from go-live.
- **Which asset state a credit note produces** —
  [OI-157](OI-157%20Credit%20notes%20and%20storni%20are%20unbuilt%20and%20undefined.md),
  still Fase 2, now also a gap in a document the client is being asked to sign off.

## 🔴 Why it is time-critical

- **There is no next client meeting booked.** The mail states it:
  _"nel prossimo incontro utile (ancora da concordare, non in programma)."_ Mail
  is currently the only channel to the client.
- **Go-live is 06/10**, production deploys over the weekend of 03–04/10, and the
  team's own end-to-end check is **08/10** — two days after go-live.
- A confirmation obtained on this text would become the agreed baseline, and
  [OI-184](OI-184%20Register%20v1.6%20goes%20to%20the%20client%20as%20one%20change%20set%20at%20UAT%20close.md)
  will carry it into the register at UAT close.

## What closing it looks like

A follow-up mail on the same thread putting the seven points to the client as
questions. ⚠ **This procedure does not send mail** — see the guardrails in
`.agents/skills/requirements-check/SKILL.md`. It is Elena Spini's to send, and it
is recorded here because nobody else is tracking it.
