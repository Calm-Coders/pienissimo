---
id: OI-377
type: open-item
status: in-progress
owner: Anita Aga
with: Aurel Mrruku, Elena Spini, Marco Montesi
org: both
raised: 2026-11-19
updated: 2026-11-19
depends_on: [OI-375]
blocks: []
severity: gating
uncertain: that reports and dashboards are a contract deliverable rests on Elena Spini's statement on the 19/11 call - the contract itself was not read in this sweep and the requirement register carries no reporting requirement
source: notes/meetings/2026-11-19 INTERNA Check temi PEC.md
---

# OI-377 - Reports and dashboards were never built and have no requirements

**Reports and dashboards are the first named ground of the PEC. ROMI's project
manager accepts they are in the contract and were never built, and states the
client never gave a requirement for them. On 19 November ROMI began inventing
one so that the PEC reply can say the deliverable exists.**

First surfaced as a PEC ground on
[the 19/11 internal call](../meetings/2026-11-19%20INTERNA%20Check%20temi%20PEC.md).
Parent: [OI-375](OI-375%20Pienissimo%20sent%20a%20PEC%20contesting%20the%20implementation%20and%20suspending%20the%20go-live.md).

## What is admitted

Elena Spini, on the call:

> _"una delle contestazioni … di PEC e appunto che **manca dashboard e report**"_
> — and later, flatly: _"**le dashboard che mancano, che sono nel contratto e
> mancano**, ok?"_

🔴 **So the deliverable is accepted as contractual and accepted as absent.**
⚠ The contract was not read in this sweep, and
[the requirement register](../../requirements/pienissimo-requirements.yaml) is at
**v1.6** with no reporting or analytics requirement in it. **Which contract
clause this is has never been recorded anywhere in this repository.**

## The requirement problem

🔴 **There is no requirement.** _"dato che allora **non c'hanno dato nessun
requisito**"_, and again: _"cioe non ho neanch'io il requisito. Se vuoi che mi
invento qualcosa te lo invento."_

The only requirement in existence is one sentence, attributed to **Marco
Montesi**: _"vogliono capire la situazione di lead e opportunity"_. ⚠ He is the
commercial lead who has resigned
([OI-357](OI-357%20The%20client%20commercial%20lead%20and%20the%20web%20counterpart%20are%20both%20leaving.md)),
so the only stated requirement has no owner on the client side.

🔑 **A requirements meeting was planned and never held.** Elena Spini: _"dovevamo
fare dei … un meeting di requisiti"_. That meeting is one of the things the PEC
is now about.

## What is being built instead

See [OI-376](OI-376%20All%20Pienissimo%20work%20is%20frozen%20except%20reports%20and%20dashboards.md)
for the authorisation and its limits.

| | |
| --- | --- |
| Content | Lead and Opportunity reports — standard report types, standard folders, _"tutto standard. Base."_ — one Home-page dashboard for the agents; plus two reports on orders and invoices, added on Aurel Mrruku's offer |
| Environment | **UAT**, explicitly not production |
| Builder | **Anita Aga**, from 19/11 |
| Review | internal, **20/11 09:30 CET** |
| Purpose, as stated | _"cosi almeno nella risposta noi diciamo che abbiamo tutto"_ |

🔴 **It is being specified by the supplier to answer a legal notice, not by the
client to meet a need.** Aurel Mrruku objected to exactly that — _"inventiamo
qualcosa, mandiamo la mail, confermiamo, poi buttiamo su la roba perche stiamo
facendo la stessa cosa dall'inizio di questo progetto"_ — and built it anyway.

⚠ **Fabrizio Mastracci's reading of the ask** is worth keeping, because it is the
only estimate of its real size on the record: _"uno gli fa un report lead status
equal new e gli risbatte dentro una dashboard"_, and _"vogliono tre report … con
lead uguale new. Se questa e motivo di contenzioso, tieni, prenditi questa
cosa."_

## What is owed

- 🔴 **The contract clause** that makes reports and dashboards a deliverable,
  quoted, so the scope of the obligation is known rather than guessed.
- 🔴 **A written requirement from the client**, or an explicit record that ROMI
  specified it unilaterally and why.
- **A ruling on whether this goes to production at all**, given the freeze and
  the UAT-only instruction.
- ⚠ **Whether the register needs a reporting requirement at v1.7.** If reports
  are contractual they belong in it; nothing has been agreed and the register is
  untouched.
