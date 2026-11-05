---
id: decision-no-margin-left
type: decision
status: resolved
owner: Gianpaolo Motta
with: Elena Spini
org: ROMI
raised: 2026-10-26
updated: 2026-10-30
depends_on: []
blocks: []
source: Slack C0B5T3RB4FM 2026-10-30 15:30 CET
---

# Decision - new scope after 26 October goes to Fase 2

**ROMI's staffing authority ruled on 26 October that the Pienissimo project has no
margin left to absorb further work. Everything that arrives from that point is to
be routed into Fase 2. The ruling was made internally and published to the project
channel on 30 October.**

## The ruling

Elena Spini, `#tproj-pienissimo` (`C0B5T3RB4FM`), **2026-10-30 15:30 CET**, under
`Red flags`:

> _"**Margine finito:** Gianpaolo ci ha detto il **26/10** che su questo progetto
> **non c'è più margine per assorbire altro**, quindi **tutto quello che arriva ora
> va in Fase 2**."_

🔑 **The decision is dated 26 October and surfaced on 30 October.** Four days of
new requirements were taken in between — the bundle picklist asks
([OI-299](../items/OI-299%20Bundle%20creation%20offers%20the%20wrong%20Anno%20Accademico%20values%20and%20too%20few%20Bundle%20Type%20values.md)),
tutor training ([OI-300](../items/OI-300%20Tutor%20training%20and%20tutor%20test%20access%20are%20unplanned.md)),
the WooCommerce contract flow
([OI-304](../items/OI-304%20Contracts%20for%20WooCommerce%20stage%20sales%20are%20not%20generated.md))
— and **none of them is marked as Fase 2 anywhere.**

## The numbers published with it

| | |
| --- | --- |
| Days to finish | **15** |
| Previous figure | **26** |
| Difference | **10 days consumed by the team on the migration** |

🔑 **This books the migration cost that nobody had budgeted.** The ten-plus man-days
Aurel Mrruku reported internally on 28/10 — _"solo di migrazione abbiamo speso una
10 di gg"_ — are now charged against the project's own remaining estimate rather
than sitting outside it. ⚠ **It is an absorption, not a recovery**: the days are
spent and the remaining budget is smaller by exactly that amount.

## How it interacts with the other gates

- 🔑 **It is not the Change Request mechanism.**
  [OI-285](../items/OI-285%20ROMI%20asked%20the%20client%20to%20route%20future%20out%20of%20scope%20requirements%20through%20change%20requests.md)
  asked the client to raise CRs; this rules internally on where new work is
  *booked*. ⚠ **Whether a Fase 2 item needs a CR, or a CR lands in Fase 2, is not
  stated.**
- 🔑 **Nor is it the UI-batching ruling.**
  [UI changes are batched into one ad hoc release](Decision%20-%20UI%20changes%20are%20batched%20into%20one%20ad%20hoc%20release.md)
  defers UI work to a single release **inside** the current phase. This ruling
  sends new scope **out** of it. ⚠ A UI change collected into Marco Montesi's file
  could be read as either.
- 🔴 **[OI-308](../items/OI-308%20Fase%202%20maintenance%20was%20left%20out%20of%20the%20estimate.md)
  has nowhere to fall back to.** Maintenance was omitted from the Fase 2 estimate,
  and Fase 1 can no longer absorb it.

## What is not decided

1. ⚠ **The client has not been told.** This is an internal red flag in a ROMI
   channel. Nothing records it being said to Pienissimo.
2. ⚠ **No item has been reclassified.** The ruling is four days old and the board
   is unchanged.
3. ⚠ **Gold/Executive ticket communications are the one named Fase 2 item**, per
   the same recap — _"confermate in Fase 2"_.
