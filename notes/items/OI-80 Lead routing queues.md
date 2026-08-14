---
id: OI-80
type: open-item
status: open
owner: Marco Montesi
with: ROMI
org: both
raised: 2026-08-06
updated: 2026-08-14
source: meetings/results/2026-08-06-chiusura-punti-aperti.md
---

# OI-80 - Lead routing queues

Zoho today round-robins one lead per tutor. Marco Montesi reports it no longer
works.

Agreed direction: **queues segmented by service type and/or geography**
(province or region), with automatic assignment driven by lead-level fields.

⚠ **Load-based automatic assignment is not available on their licences** — it
is a Case-oriented capability. So the practical answer is **rules plus mass
transfer**: select many leads and reassign in two clicks when a tutor frees up.
That is a meaningful downgrade from what "automatic assignment" implies, and it
should be stated plainly to Pienissimo rather than discovered at UAT.

**Marco Montesi owes the concrete desiderata** once he has seen the real
platform — which means this cannot progress until he has hands-on access.

The queue design also has to fit the lead/opportunity split confirmed on 31
July: marketing converts leads to opportunities, tutors work recalls through
automatic tasks and dedicated states, and qualified contacts skip the early
stages. Related configuration:
[OI-59](OI-59%20Quote%20workflow%20configuration.md).
