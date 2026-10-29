---
id: risk-team-shrinks-before-fase-2
type: risk
status: open
owner: Aurel Mrruku
org: ROMI
raised: 2026-10-27
updated: 2026-10-27
depends_on: []
blocks: []
source: notes/meetings/2026-10-27 Follow-up Interno.md
---

# Risk - the delivery team shrinks before Fase 2

**One of the two Salesforce developers is moving to another project, and a
second ROMI contributor's afternoons are already committed elsewhere. Both
signals landed on 27 October, while the production release is mid-flight and
twelve days before the agreed technical release.**

## The statements

**Rexhina Hysi is leaving.** Aurel Mrruku in
[the 27/10 internal follow-up](../meetings/2026-10-27%20Follow-up%20Interno.md),
`00:18:46`:

> _"Abbiamo già iniziato i manual step, però **Regina andrà su un altro
> progetto**, quindi serve solo con Ana … quindi **se c'è una fase due a breve
> saremo solo in due, non in tre**."_

⚠ _"Regina"_ is the transcript's rendering of **Rexhina Hysi**; _"Ana"_ /
_"Ana Sapilo"_ is its rendering of **Anita Aga**. Read from context — both are the
only developers on the project — and flagged rather than silently corrected.

**Fabrizio Mastracci's afternoons are committed elsewhere.** Slack marketing group
DM `C0C38JJ9D1T`, 2026-10-27 09:13:46 CET:

> _"Hai ragione devo aggiornare gli ooo, perché **ora i pomeriggi sono impegnato
> su altri fronti**"_

He missed the 17:00 alignment the same day (_"io non ci sono"_, 09:10:15 CET), and
offered work in exchange for time: _"io ho chiaro i task e devo lavorarci, se mi
dai qualche giorno ti porto direttamente le cose fatte."_

## Why it is a risk and not just a staffing note

1. 🔴 **The timing.** Rexhina Hysi was performing production permission work the
   same evening the departure was announced — Slack `C0BQD34LLF4` 18:03:28 CET,
   _"done added also the permission set Agente to these users"_
   ([OI-293](../items/OI-293%20The%20agent%20registry%20for%20the%20production%20load%20may%20be%20incomplete.md)).
   The manual steps of the production release are explicitly shared between her
   and Anita Aga.
2. 🔴 **Her unmerged work.** `Devmain_LeadChecks` and
   `Devmain_QuoteTriggerChanges` are hers; both last moved 26/10. Whoever
   inherits them inherits
   [OI-286](../items/OI-286%20Lead%20conversion%20throws%20in%20UAT%20when%20the%20user%20cannot%20create%20a%20Task.md)'s
   neighbourhood and the quote trigger.
3. 🔑 **It is a precondition the Fase 2 estimate does not state.** The man-day
   figures in [the Fase 2 estimate](../The%20Fase%202%20estimate.md) were set the
   same hour, and nothing in them accounts for two developers rather than three.
   Aurel Mrruku drew the link himself — the sentence is one clause.
4. ⚠ **No date, no replacement, no handover.** None of the three is mentioned.
   The decision appears to be made elsewhere in ROMI; the project record holds
   only this remark.

## What would close it

A stated leaving date, a named owner for the unmerged branches, and either a
replacement or a Fase 2 estimate that is explicitly two-developer. None exists.
