---
id: OI-242
type: open-item
status: in-progress
owner: Aurel Mrruku
with: Elena Spini
org: ROMI
raised: 2026-10-14
updated: 2026-10-16
depends_on: [OI-147]
source: Slack C0C38JJ9D1T 2026-10-14
---

# OI-242 - The community Rinuncia button must show the public refusal text

**Elena Spini asked for the community ticket `RINUNCIA` button to land the
visitor on the text published at `pienissimo.com/rifiuta-evento`. Aurel Mrruku
set out what that actually costs, pushed back on the timing, and the change was
deferred to the production rollout rather than ruled on.**

## The exchange

Marketing group DM, **14 October**, Elena Spini with Aurel Mrruku and Fabrizio
Mastracci. Times CEST.

| Time | Who | What |
| --- | --- | --- |
| 15:13:54 | Elena Spini | _"post clicl sul tasto rinuncia degli biglietti della community mi riesci a far vedere questo testo?"_ with the `pienissimo.com/rifiuta-evento` link |
| 15:14:32 | Elena Spini | _"ovviamente so che è fattibile BUT facilmente?"_ |
| 15:20:01 | Aurel Mrruku | _"io posso fare tutto ma non adesso"_ — half a day just to retest every flow |
| 15:20:49 | Aurel Mrruku | _"abbiamo fatto gli UAT, ci hano detto che va bene …"_ |
| 15:25:12 | Elena Spini | Friday she will say that clicking RINUNCIA shows that text, _"FINE ---- massimo delle modifiche che possiamo fare"_ |
| 15:25:46 | Elena Spini | _"venerdì non ci sarà il testo glielo faremo vedere quando porteremo tutti in PROD"_ |
| 15:27:17 | Aurel Mrruku | _"il button rinuncia ha dietro un action che fa delle modifiche sui dati"_ |
| 15:31:44 | Elena Spini | _"asp Aurel ho detto che non si cambia nulla infatti"_ |
| 15:33:39 | Aurel Mrruku | _"devo togliere il button quando non clicki rinuncia ma fai il giro normale. devo dividere il link e creare 2 pagine sulla community"_ |
| 15:34:31 | Aurel Mrruku | _"la pagina del rinuncia deve avere una logicha sulla renderizazione che ti manda in rinunciato i asset ecc"_ |
| 15:34:46 | Aurel Mrruku | _"si deve cambiare anche la parte mobile"_ |
| 15:35:25 | Elena Spini | voice note: _"non è cambiato niente, cioè, semplicemente il tasto rinuncia è quello che avevi già fatto. Punto."_ |
| 15:35:52 | — | a huddle starts; **what was settled in it is unreadable** |

## What the disagreement actually is

🔑 **The two are describing different things and neither says so.** Elena Spini
is asking for a **confirmation page** — static copy after the click. Aurel Mrruku
is answering about the **button's behaviour**: the existing `RINUNCIA` action
writes data, moving the asset to `rinunciato`, so a page that renders the text
must either carry that logic or be reached after it. His four consequences —
split the link, two community pages, hide the button on the normal path, and the
mobile view — follow from that reading, and they are not addressed in the record.

🔴 **The outcome is a deferral, not a decision.** Elena Spini's position settles
at _"non si cambia nulla"_ for Friday, with the text shown _"quando porteremo
tutti in PROD"_. **So the ask stands, unscheduled, pointed at the production
rollout** — which is 21 October.

⚠ **Fabrizio Mastracci's contribution is of record and bears on nothing
technical**: _"Poi non capisco onestamente questo stravolgimento del nostro
lavoro da quali oculate e attente analisi derivino"_ (14:57:42). Noted because
the exchange is the first in the record where ROMI staff treat a client-side
request as unreasoned, and there have now been several.

## Why it is a row

- The `RINUNCIA` path is the renunciation half of the ticket lifecycle —
  [OI-147](OI-147%20Unused%20tickets%20close%20three%20days%20after%20the%20event.md)
  and the asset states — and it is **customer-facing**.
- ⚠ **It is scheduled against the production rollout with no owner for the
  rollout step itself**, and the person who would build it has said he cannot
  this week.
- ⚠ **The huddle at 15:35:52 may have settled it.** Voice is not a source this
  procedure can read. **Whatever was agreed there is not in the record** — the
  third time a Pienissimo decision has gone into a huddle.

## What closing it looks like

A ruling on whether the confirmation text is Fase 1 or waits, and if it is Fase 1
a design that separates the data-writing action from the page the visitor sees.

## 🔑 2026-10-16 — ruled on in session, and the client won

**The deferral closed. The 16 October UAT put the renunciation design in front
of the people who own it, and the outcome is the opposite of ROMI's stated
advice.** See
[the session](../meetings/2026-10-16%20UAT%20Flussi%20MKT%20Biglietti.md),
`00:22:38`–`01:05:15`.

### What was decided

| Change | Owner | Status |
| --- | --- | --- |
| **Both `accetta` and `rifiuta` buttons in the invitation mail**, pointing at the **same** landing page | Matteo Distaso, Rebecca Marmo (copy); ROMI builds | 🔴 Agreed, not built |
| **A double-confirm pop-up** on the renunciation page — _"La rinuncia è definitiva. Sei veramente sicuro?"_ | Aurel Mrruku | 🔴 Agreed, not built |
| **Enlarge the renunciation button**, and check the mobile rendering | Aurel Mrruku | 🔴 Agreed, not built |

### Why it matters that the client won

🔑 **Elena Spini's own position — recorded in this note on 14/10 and restated
three times in the session — was that two buttons landing on one page is
misleading.** She conceded explicitly (`00:41:43`):

> _"se per i vostri clienti pensate che va bene così alziamo le mani e ci
> veniamo incontro in questo modo. Fare questo Fabrizio e Aurel non penso sia un
> problema."_

**Matteo Distaso's reason is a business one and it is on the record**: a refusal
hidden a page deep will not be used, so the refusal data will be wrong and the
rooms will be empty —

> _"i tassi di rifiuta noi dalla mail crolleranno … e noi attribuiremo sta cosa
> al fatto che la gente vuol venire ma poi ci troviamo le sale vuote"_

**Aurel Mrruku's objection is also on the record, unanswered:**

> _"Tu apri la mail in un cellulare, hai attiva rinuncia, per sbaglio hai fatto
> rinuncia, hai già spaccato tutto e hai perso tutti i biglietti."_
>
> _"cerchiamo di fare le cose non solo i happy path"_

🟢 **The double-confirm pop-up is the concession back**, and it was Matteo
Distaso who asked for it (`01:02:30`) — _"mettiamo un bel pop-up che dice 'La
rinuncia è definitiva. Sei veramente sicuro?'"_ — after Aurel Mrruku raised the
accidental-click case. Aurel Mrruku confirmed it costs nothing: _"è
completamente è tutta custom questa pagina, quindi possiamo fare tutto quello
che serve"_.

### 🔴 Three things the decision leaves open

1. **The recovery path went to Fase 2 in the same session** —
   [OI-253](OI-253%20Restoring%20a%20ticket%20after%20an%20accidental%20rinuncia%20is%20Fase%202.md).
   So the button ships in Fase 1 and the undo does not.
2. **Two of Aurel Mrruku's four 14/10 consequences were never addressed**: that
   an `accetta` click should remove the renunciation option, and that a holder
   invited to two events can open the older mail and renounce a booking already
   accepted. He raised both again on 16/10 (`00:39:17`); the conversation moved
   on.
3. ⚠ **An existing rule limits the new button.** Once the first participant name
   is entered the first ticket is issued and **renunciation is no longer
   possible for that block** (`00:25:11`). A `rifiuta` button in the mail will
   therefore sometimes land on a page with no renunciation control. Elena Spini
   said so aloud — _"ho già messo un nome, non vedrò mai più rinuncia"_ — and
   added _"forse sarebbe meglio togliere questo bottone"_. **Nobody ruled on
   it.**

### What is still unanswered from 14/10

🟢 **The huddle question is partly answered**: the 14/10 15:35:52 voice huddle is
no longer the only record of the renunciation design, because the 16/10 session
re-decided it in text. ⚠ **But the original ask in this note — landing the
visitor on the text published at `pienissimo.com/rifiuta-evento` — was never
mentioned on 16/10.** The published-copy requirement is neither confirmed nor
withdrawn. It is now the only part of this row with no ruling at all.
