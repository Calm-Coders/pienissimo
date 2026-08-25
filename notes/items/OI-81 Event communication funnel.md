---
id: OI-81
type: open-item
status: open
owner: Elena Spini
with: Rebecca Marmo
org: both
raised: 2026-08-06
updated: 2026-08-24
blocks: [OI-86]
source: meetings/results/2026-08-06-chiusura-punti-aperti.md
requirement: BIG-06
---

# OI-81 - Event communication funnel

The event communication funnel **automates at 60 days before the event** — a
30-to-60-day window, chosen to cut no-shows — driven by account tags plus the
event date, and auto-sending the participant-data link.

**Multi-event bundles get per-event communications**, each on its own
countdown. That is the detail that makes this more than a scheduled email: one
purchase can produce several independent funnels running months apart.

A dedicated marketing-funnel meeting is to be held with Rebecca Marmo, Marco
Montesi and Matteo, and Rebecca is to join **all** flow, field and ticket calls
from now on.

📅 **Now scheduled: 19 August 2026.** Elena Spini's 7 August status names it —
_"il 19.08 meeting per definire i due flussi MKT"_ — and notes that **both
marketing flows will be ticket-focused**, now that the ticket flow is confirmed.
It carries [OI-86](OI-86%20Who%20hosts%20the%20participant%20landing%20page.md)
with it, which blocks
[OI-78](OI-78%20Participant%20data%20collection.md).

⚠ The marketing workstream has its own long-standing block —
[OI-14](OI-14%20Marketing%20forms%20and%20subdomain.md), open since 23 June — so
this funnel is being designed on top of a stream that is not itself unblocked.

## 2026-08-19 - a second send, with no date on it

[The 19 August ticket flow diagram](../The%20ticket%20flow%20diagram%20of%2019%20August.md)
draws the funnel as **two communications, not one**: the known one _"A 30-60
giorni dall'evento"_, and a second marked **_"A XX giorni dall'evento"_**. The
`XX` is literal — a placeholder left in the file. So the funnel's second send
exists in the design and **its timing is an open decision**, owned with the rest
of this item.

**Whether the 19 August session actually took place is unconfirmed.** The
diagram landed that afternoon and matches the subject, but there is no
recording, no canvas entry and no message — see the diagram note. If the
session did run, **it is unminuted**, and this item cannot close on a drawing.

## 2026-08-24 - two flows, one unresolved number, and a hard style constraint

The [19 August MKT session](../meetings/2026-08-19%20Flussi%20MKT%20Biglietti.md) specified the funnel:

- **Two distinct flows, not one.** The first, at **30 or 60 days** before the
  event, exists to reduce the no-show rate. The second, close to the event,
  sends the participant-list link and collects the data.
- ⚠ **30 vs 60 is not settled.** The minute carries both figures and then an
  action for Elisa Migliano and Rebecca Marmo to **confirm with Matteo Distaso
  which it is**. Elsewhere in the same session the participant-list request is
  said to go out "usually 60 days before, though it can vary by case".
- **Style is a constraint, not a preference.** Matteo Distaso specified plain
  text — **no header, no images, no buttons** — written so as to read as coming
  from Giuliano personally. This rules out the graphical newsletter template a
  Marketing Cloud build would otherwise default to, and it should be recorded
  before anyone designs one.
- The current Zoho funnel drives off **tags on the contact** (`rinuncia`,
  `iscritto`, `presente`) and if/else branches checking whether the user filled
  the form or clicked a link. Rebecca Marmo and Matteo Distaso owe screenshots so
  [Fabrizio Mastracci](../people/Fabrizio%20Mastracci%20-%20marketing%20automation%20ROMI.md)
  can rebuild it.

The master diagram's `A 30-60 giorni dall'evento` and `A XX giorni dall'evento`
boxes match this exactly — the `XX` is genuinely undecided, not a placeholder
someone forgot.
