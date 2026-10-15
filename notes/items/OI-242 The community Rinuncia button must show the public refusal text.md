---
id: OI-242
type: open-item
status: open
owner: Aurel Mrruku
with: Elena Spini
org: ROMI
raised: 2026-10-14
updated: 2026-10-14
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
