---
id: OI-200
type: open-item
status: open
owner: Elena Spini
org: ROMI
raised: 2026-10-01
updated: 2026-10-06
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
- Production deploys over the weekend of **03–04/10**, and the
  team's own end-to-end check is **08/10** — two days after go-live.
- A confirmation obtained on this text would become the agreed baseline, and
  [OI-184](OI-184%20Register%20v1.6%20goes%20to%20the%20client%20as%20one%20change%20set%20at%20UAT%20close.md)
  will carry it into the register at UAT close.

## What closing it looks like

A follow-up mail on the same thread putting the seven points to the client as
questions. ⚠ **This procedure does not send mail** — see the guardrails in
`.agents/skills/requirements-check/SKILL.md`. It is Elena Spini's to send, and it
is recorded here because nobody else is tracking it.

## 🔴 2026-10-02 - the confirmation arrived, and it is a rejection

The reply this row was waiting on came at **14:19:31Z on 02/10** — and it came on
the **Business Blueprint thread**, not this one. Fabrizio Paganelli and Sabatino
Rinaldi reject two of the document's additional business rules and ask for a
separate call.

So the mail did not obtain the confirmation it asked for, and **the seven
`Open point da confermare con il cliente` have still never been put to the
client**. They are now stranded behind a rejection of the surrounding text.

🔴 **This row no longer closes on its own.** The follow-up mail it asks for would
now land into an open dispute. Whatever is agreed at the 05/10 meeting has to carry
the seven points with it, or they stay open into client-autonomous testing. The
dispute itself is
[OI-203](OI-203%20The%20client%20contested%20the%20agreed%20ticket%20logics%20before%20confirming%20them.md).

## 2026-10-06 - the document was amended and re-sent, and the open points are still not in it

`PIENISSIMO – Logiche Asset e Invio Biglietti.docx`
(`1p4W9ekBWZbVMh0ts6ui_xSIwOHZLMG4z`) was **modified at 12:46:10Z** and
re-shared by Elena Spini at **12:47:00Z** to Fabrizio Paganelli,
`amministrazione@`, Rebecca Marmo, Sabatino Rinaldi and Marco Montesi, cc Aurel
Mrruku and Fabrizio Mastracci:

> _"A fronte del meeting di oggi vi ri-condivido il link del documento aggiornato
> per il tema in oggetto relativo alle logiche di invio biglietti. Vi chiedo
> cortesemente di darmi riscontro a…"_

Read in full this sweep. What changed and what did not:

🟢 **The contested paragraph is amended.** `Aggregazione Multi-Evento per Ordine`
now reads **per edizione**, and the `Rinuncia` rule is stated per edition —
the two points of
[OI-203](OI-203%20The%20client%20contested%20the%20agreed%20ticket%20logics%20before%20confirming%20them.md),
settled at [the 06/10 session](../meetings/2026-10-06%20Form%20Link%20per%20partecipanti.md).

🔴 **The seven `Open point da confermare con il cliente` are still absent.** A
second client-facing version has now gone out without them. The people meant to
answer them have still never been shown them — including **when the link goes
out**, whose wording would open nomination up to eleven months early, a case
Fabrizio Paganelli excluded at the 30/09 UAT. ⚠ This is the point of this row and
it has not moved in five days.

🟢 The internal `POSSIBILI PROBLEMI` table is still correctly absent.

### 🔴 Two blanks the client is being asked to confirm

- **The Marketing Cloud selection query has no condition.** Step 3 reads
  _"Query di Selezione: Eseguire una query per recuperare tutti i record che
  soddisfano la seguente condizione:"_ — **and then nothing.** The condition is
  empty in the delivered document. Fabrizio Mastracci wrote the working version
  himself on 05/10
  ([the send contract](../The%20marketing%20ticket%20send%20logics%20as%20written%20by%20Marketing.md))
  and it did not reach the document.
- **The flag's object is still printed as an open question to ROMI's own
  developer:** _"Oggetto per il Flag: Asset ? da confermare con Aurel"_. That
  question was **answered and deployed on 05/10** —
  [OI-199](OI-199%20The%20ticket%20send%20flag%20fields%20are%20split%20across%20Asset%20and%20Order.md)
  is `resolved`, the three fields are on `Asset` in Prod, and the `Order` copies
  are deleted. The client is reading a stale question about a settled fact.

⚠ The tracking fields named in step 4 — `Ticket_Sent__c` and
`Ticket_Sent_Date__c` — are now correct against the build, so the document is
internally inconsistent: step 2 asks which object, step 4 assumes the answer.

### Still owed

**Written confirmation.** Elena Spini asked for it twice now, on 01/10 and
06/10. The 02/10 reply was a rejection; this sweep found **no reply to the 06/10
re-send** at the watermark. The document remains unusable as the carrier for
[OI-184](OI-184%20Register%20v1.6%20goes%20to%20the%20client%20as%20one%20change%20set%20at%20UAT%20close.md)
until it is both complete and confirmed.
