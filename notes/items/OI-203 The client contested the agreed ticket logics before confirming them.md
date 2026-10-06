---
id: OI-203
type: open-item
status: resolved
owner: Elena Spini
with: Fabrizio Paganelli
org: both
raised: 2026-10-02
updated: 2026-10-06
depends_on: [OI-197, OI-200]
blocks: [OI-184, go-live]
severity: gating
source: notes/The Business Blueprint delivered to the client.md
---

# OI-203 - The client contested the agreed ticket logics before confirming them

**The written confirmation [OI-200](OI-200%20The%20client%20was%20asked%20to%20confirm%20logics%20whose%20open%20points%20were%20removed.md)
was waiting for arrived on 02/10, and it is a rejection. Fabrizio Paganelli and
Sabatino Rinaldi say two of the document's additional business rules do not add
up, and they asked for a separate call. ROMI's answer is not to change the
logic but to demonstrate it live at Monday's existing meeting.**

## The exchange

| Time (02/10) | Event |
| --- | --- |
| 13:55:56Z | Elena Spini mails the **Business Blueprint** to Fabrizio Paganelli, `amministrazione@`, Sabatino Rinaldi, Marco Montesi and Rebecca Marmo, cc Aurel Mrruku and Fabrizio Mastracci, asking them to re-read it ahead of autonomous testing from next week |
| 14:19:31Z | **Fabrizio Paganelli replies on that thread:** _"io e Sabatino abbiamo letto il documento. Non ci torna il paragrafo Regole di Business Aggiuntive, sia il punto 1 che il punto 2. Vi chiediamo se possiamo fare una call aggiuntiva Mercoledì 7 ottobre"_ |
| 16:17:18Z | Elena Spini replies that she thinks they mean the **other** document — `PIENISSIMO – INTERNA Asset e invio biglietti`, sent the previous evening — and proposes using the **meeting already booked for Monday** instead of adding a call on the 7th, to show the logic live |

## 🟢 Which document they meant is now settled

**The Business Blueprint has no section called `Regole di Business Aggiuntive`.**
Its §6 runs 6.1 Lead → Opportunità, 6.2 Preventivi/Contratti/Ordine, 6.3 Bundle,
Mappatura Edizione e Tranche, 6.4 Flusso Ticket/Asset — read in full on 02/10.
So Elena Spini's reading is correct: the objection is against
[the 01/10 logic document](../The%20agreed%20Asset%20and%20ticket%20send%20logic%20document.md),
replied to on the wrong thread.

She said as much internally the same evening at
[the Pre-UAT](../meetings/2026-10-02%20Interna%20Pre-UAT%20Plus.md):
_"Fabrizio reply on the wrong email because he was talking about the document
that we were saying."_

## 🔴 What they are objecting to

Elena Spini, same session, identifying the two points:

> _"regole di business aggiuntive is the logic of everything. So aggregation
> multievento per ordine and all the logic that we were saying that is impossible
> to change."_

So the contested rules are the **multi-event aggregation per order** —
[OI-196](OI-196%20Whether%20tickets%20are%20sent%20when%20the%20buyer%20names%20only%20some%20participants.md)'s
territory — and she adds that they also objected to **the `Rinuncia` part**:
_"they say that part of rinuncia but who cares I don't mind."_

⚠ **These are the logics the 30/09 UAT confirmed with the client in the room.**
Elena Spini's own status post says so: _"Fabrizio P. e Sabatino hanno contestato
alcune delle logiche fondamentali del flusso dei biglietti, confermate nel meeting
di due giorni fa."_

## 🔴 The position ROMI has taken

Not to revisit the rules, but to persuade:

> _"I think that as soon as he will see the link it will change his mind because
> **he doesn't have any idea of what we are talking about** and I really want to
> make them change their mind."_ — Elena Spini, 02/10 Pre-UAT

Aurel Mrruku agreed to the plan. The vehicle is the **Monday 05/10 meeting**,
with a live demonstration instead of the Wednesday 07/10 call Fabrizio Paganelli
asked for. ⚠ **As of this sweep the client has not agreed to that substitution** —
Elena Spini's mail ends _"Fatemi sapere se per voi va bene procedere così."_

## 🔴 Why this is gating

- A `Rinuncia` objection is not a misunderstanding that a demo settles. The
  granularity has been stated four different ways in four days and **the two
  client-facing documents disagree with each other** — see
  [OI-75](OI-75%20Ticket%20availability%20rule.md).
- [OI-184](OI-184%20Register%20v1.6%20goes%20to%20the%20client%20as%20one%20change%20set%20at%20UAT%20close.md)
  was going to carry this document into the register as the v1.6 change set. It
  cannot carry a rejected text.
- The seven `Open point da confermare con il cliente` that OI-200 records as cut
  from the client's copy **still have not been put to them**, and the client has
  now objected to the document anyway.
- The client begins **testing in autonomy next week** against logics two of its
  own leads have said do not add up.

## What closing it looks like

Either the client accepts the rules at the 05/10 meeting **and that acceptance is
recorded in writing**, or the rules change. ⚠ A demonstration that ends in verbal
agreement, with no mail behind it, leaves this row exactly where it is.

## 🔑 2026-10-05 - a second client voice accepts the Blueprint, and the contested rule was rebuilt the same day

Three movements, none of them a resolution.

### 🟢 Marco Montesi accepts the Blueprint

At 13:20:02Z, on the same thread, the sales lead replied:
_"**direi che torna tutto**, giusto tre precisazioni"_. The **first client
acceptance this project has received in writing**, and it comes from a
different person than the rejection. His three points are questions, not
objections — recorded in
[the Blueprint note](../The%20Business%20Blueprint%20delivered%20to%20the%20client.md).
⚠ **Nobody has answered him.**

So the client's written position is now split: Fabrizio Paganelli and Sabatino
Rinaldi reject the 01/10 logic document's `Regole di Business Aggiuntive`;
Marco Montesi accepts the Blueprint. Those are two documents, and Elena Spini's
02/10 mail established the confusion. Her proposed substitution — a live demo
at Monday's meeting instead of the Wednesday call they asked for — **happened**:
Monday held the Performance Plus UAT and the Lead session. 🔴 **Neither covered
the contested paragraph.** The link discussion was explicitly deferred, on
grounds of fatigue, to 06/10 10:00.

### 🔑 The contested rule has been rebuilt — before the conversation

The objection was to the **aggregazione multievento per ordine**. At the 17:15
session Elena Spini previewed the fix as a proposal for the next day:
_"passare da un link per ordine a un link per edizione"_.

🟢 It was already built. Commit `4a6fe3f`, **17:39 CEST**, _"event invitation
lik for each campaign"_ — 391 lines in `EventInvitationService`, two new
triggers, and
[Decision - Event Links belong to Order Campaign pairs](../decisions/Decision%20-%20Event%20Links%20belong%20to%20Order%20Campaign%20pairs.md),
which supersedes the one-link-per-Order design. One Event Link per
Order-Campaign pair, its own token and URL, scoped submission and `Rinuncia`.

⚠ So the change the client is to be consulted on tomorrow was in the repository
before the consultation, and the rejected rule is **already gone**. That is a
better outcome than persuasion and a worse process than agreement: if they ask
for something else on 06/10, the rebuild is sunk work.

### 🔴 ROMI's internal view is still that the client has not understood it

Aurel Mrruku and Elena Spini at 10:01, on the same design:
_"**Ma loro non vogliono neanche quel link**, se ti ricordi, per come glielo
stiamo proponendo"_ and _"ma non l'hanno pensata sta cosa."_ And Aurel Mrruku
had conceded the real defect himself — `Event_Invitation__c.Campaign__c` was
taking _"la prima campagna che ha trovato"_, which is problem #2 of the risk
table, live in production. **The client's objection was, on the merits,
correct.**

## 🟢 2026-10-06 - the client adopted the rule, in the direction it had already been rebuilt

At **[the 06/10 client session](../meetings/2026-10-06%20Form%20Link%20per%20partecipanti.md)**
(10:02 CEST, ~1h30m) — the consultation this was deferred to — the room agreed:

> _"Generazione dei link per singola edizione: viene adottata la logica di
> generare un link di nomina separato per ciascuna edizione inclusa in un ordine
> anziché un link unico per ordine."_

**Point 1 of the contested paragraph is settled**, and settled as the client
wanted it: per edition, not per order. Elena Spini presented it, Fabrizio
Paganelli and Sabatino Rinaldi — the two who rejected it — were in the room, and
nothing in the notes records a dissent.

**Point 2, the `Rinuncia` part, is settled too.** The rule is now stated per
edition and conditioned on nomination state: the button is visible while no
participant has been confirmed for that edition, and **hidden and permanently
disabled** as soon as one is. Later renunciations go to an offline procedure —
the Tutor aziendale or Assistenza. Aurel Mrruku demonstrated the behaviour live
(two nominativi of three, button gone).

### The document was corrected and re-sent the same day

Elena Spini posted the confirmed text into the marketing group DM at 14:40:28
CEST, prefaced _"questo è stato quello confermato"_, with **`per Ordine` struck
through and replaced by `per edizione`**. The client-facing
`PIENISSIMO – Logiche Asset e Invio Biglietti.docx` carries the amended heading
and was modified at **12:46:10Z**, then re-shared to the five client recipients
at **12:47:00Z** asking for written confirmation
([OI-200](OI-200%20The%20client%20was%20asked%20to%20confirm%20logics%20whose%20open%20points%20were%20removed.md)).

### 🔑 What this says about the 05/10 rebuild

`4a6fe3f` landed at 17:39 CEST on 05/10, before the consultation, and the
consultation went the way the commit had already gone. **The work is not sunk.**
That vindicates the direction, not the sequence: the outcome was decided by the
client agreeing the next morning, not by the commit, and had they asked for
something else the 391 lines would have been wasted. Recorded as a process
observation, not as a defect.

⚠ **Still open, and tracked elsewhere:** written confirmation of the amended
document has been **requested but not received** (OI-200), and the seven
`Open point da confermare con il cliente` are **still absent** from the client's
copy. This row closes on the two contested rules only.
