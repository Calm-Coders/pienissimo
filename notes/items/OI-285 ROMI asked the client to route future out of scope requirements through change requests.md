---
id: OI-285
type: open-item
status: open
owner: Elena Spini
with: Sabatino Rinaldi
org: ROMI
raised: 2026-10-23
updated: 2026-10-26
depends_on: [OI-274]
source: Gmail 1a158b6e3e4cee81, message 1a1683c78db0218b, 2026-10-23T10:09:04Z
---

# OI-285 - ROMI asked the client to route future out of scope requirements through change requests

**On 23 October ROMI put two things to the client in writing for the first time:
that the ticket-balance migration was in neither the initial plan nor the
approved Business Blueprint, and that from now on out-of-scope requirements must
be handled formally as Change Requests. It is a governance request, it is
addressed to the client's whole project group, and at the time of this sweep it
is unanswered.**

## The mail

Elena Spini → Sabatino Rinaldi and Fabrizio Paganelli, **2026-10-23 10:09:04Z**,
cc Marco Montesi, Elisa Migliano, `amministrazione@pienissimo.com`, Matteo
Distaso, Rebecca Marmo, Aurel Mrruku and Fabrizio Mastracci — Gmail thread
`1a158b6e3e4cee81`, message `1a1683c78db0218b`. It is a chase on the go-live
thread ([OI-268](OI-268%20The%20client%20proposed%20a%20go-live%20calendar%20of%2016%20November.md))
and carries three paragraphs.

### 1. 🔑 ROMI's written position on the ticket migration

> _"ci tengo a segnalare che stiamo facendo il possibile per includere anche i
> requisiti per la migrazione dei biglietti arrivati in settimana, sebbene non
> fossero previsti nella pianificazione iniziale né nel BBP approvato"_

🔑 **This is the first written ROMI answer to Sabatino Rinaldi's 21 October
escalation** ([OI-274](OI-274%20The%20historical%20ticket%20balance%20has%20no%20migration%20path.md)),
where he said _"mi aspetto da parte vostra dovete portarci una soluzione."_
The reply does both things at once: it **accepts the work** —
_"stiamo facendo il possibile per includere"_ — and **records that it was not
in scope**, naming the approved
[BBP](../The%20Business%20Blueprint%20delivered%20to%20the%20client.md) as the
authority.

⚠ **It does not call the ticket migration itself a change request.** The CR
ask below is explicitly _"in futuro"_. So this item is being absorbed
unbilled, with the scope objection on the record but no commercial consequence
attached to it.

⚠ **And it does not answer the question he asked**, which was how the tickets
get into Salesforce. No mechanism, no date, no owner is given.

### 2. 🔑 The request itself

> _"Per garantire il rispetto dei tempi anche in vista della Fase 2, vorremmo
> concordare che in futuro eventuali requisiti fuori ambito non definiti a monte
> dovranno essere gestiti formalmente tramite Change Request (CR)."_

Three things to note about the wording:

- 🔑 **The stated reason is schedule, not money** — _"per garantire il rispetto
  dei tempi"_ — which is also the argument that makes it hard to refuse.
- It is framed as something to **agree** (_"vorremmo concordare"_), not as a
  contractual term being asserted. **So it needs a client reply to exist.**
- It points at **Fase 2**, which has no agreed perimeter in this record beyond
  the §14 rule and the items already pushed into it.

### 3. 🟢 The date is reaffirmed

> _"Confermate le indicazioni condivise in precedenza, riteniamo che la data del
> 16/11 rimanga per noi un target del tutto raggiungibile."_

Recorded against
[OI-268](OI-268%20The%20client%20proposed%20a%20go-live%20calendar%20of%2016%20November.md),
which is where it matters: it is **ROMI's own written acceptance of 16
November**, which that note had flagged as missing from this mailbox.

## 🔴 Why it is a row and not a footnote

This project has repeatedly identified scope growth and then not acted on it.
The record holds at least five instances where new scope arrived and **nobody
used the word CR to the client**:

| Item | What grew |
| ---- | --------- |
| [OI-250](OI-250%20The%20reminder%20wait%20intervals%20must%20be%20configurable%20per%20edizione.md) | 11 interval fields became 15, templates _"completamente personalizzabili"_ |
| [OI-269](OI-269%20Event%20communications%20must%20be%20differentiated%20by%20ticket%20type.md) | communications per ticket type, against an Asset that carries no ticket type |
| [OI-274](OI-274%20The%20historical%20ticket%20balance%20has%20no%20migration%20path.md) | ~1,000 historical tickets |
| [OI-277](OI-277%20A%20read-only%20Mandato%20RID%20field%20is%20required%20on%20the%20account.md) · [OI-278](OI-278%20The%20account%20layout%20omits%20the%20legal%20representative%20data.md) · [OI-279](OI-279%20The%20tutor%20account%20creation%20screen%20must%20be%20simplified.md) | three new scope rows in one day |
| [OI-282](OI-282%20The%20client%20is%20owed%20a%20technical%20integration%20document.md) | a technical document, no date or scope |

🔑 **[OI-259](OI-259%20A%20lost%20lead%20marked%20non%20interessato%20must%20carry%20a%20mandatory%20free%20text%20reason.md)
is the one counter-example**, and only internally: Aurel Mrruku said _"digli che
è una CR"_ in a ROMI-only call on 20 October, and the record does not show it
reaching the client. **This mail is the first time the mechanism is put to the
client at all.**

## ⚠ What is unresolved

- 🔴 **No reply.** As at this sweep the mail is ~12 hours old. The client did
  answer the *calendar* paragraph of the same thread at 10:41:34Z and
  **said nothing about the CR paragraph or the BBP paragraph** — see
  [OI-268](OI-268%20The%20client%20proposed%20a%20go-live%20calendar%20of%2016%20November.md).
  🔑 **Selective agreement is the finding**: they accepted the dates and left
  the governance ask unanswered.
- ⚠ **No CR process exists in this record.** Nothing names a form, an
  approver, a price basis or a turnaround. `Registro CR` exists in Drive for
  **another** ROMI client, not for Pienissimo.
- ⚠ **No boundary is stated** for what counts as _"fuori ambito"_, and the
  authority it leans on — the approved BBP — is a document this repository holds
  only in summary.
- ⚠ **It is retrospective in effect but prospective in wording.** Whether the
  five rows above are re-opened as CRs, or written off, is not addressed.

## What closing it looks like

The client replies accepting or refusing the CR route; if accepted, the process
is written down somewhere both sides can cite, and the already-grown scope is
either billed, waived, or explicitly left as it is. **Until then nothing has
changed except that ROMI's position is on the record.**

## 2026-10-26 - ROMI answered its own question internally

🔑 **The client is still silent on the CR paragraph** — three days, and nothing
in this sweep's mail or chat addresses it.

🟢🔑 **ROMI set the boundary for itself instead.** `#tproj-pienissimo`, 26/10
13:13:44 CET, Gianpaolo Motta to Elena Spini: _"su questo progetto non abbiamo
più margine per assorbire cose in più, spostagliele alla fase 2"_ (one 👍, no
reply). Recorded as
[a decision](../decisions/ROMI%20will%20absorb%20no%20further%20scope%20in%20Fase%201.md).
It is a staffing-authority ruling, not an opinion — the same person signs off
the project's remaining days.

🔴 **The gap this row identified is unchanged and now demonstrable.** Twenty
minutes after that instruction, Elena Spini mailed the client asking for Lead
and Referenti migration data
([OI-290](OI-290%20Lead%20and%20Referenti%20migration%20data%20is%20owed%20by%20the%20client.md))
— scope that appears in no plan and no BBP — **without calling it a Change
Request or a Fase 2 item.** ⚠ Whether she had read the instruction is not
established. Either way: **the mechanism exists in two places now, internally and
in a mail to the client, and it has still never been applied to anything.**
