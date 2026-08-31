---
id: OI-80
type: open-item
status: in-progress
owner: Marco Montesi
with: ROMI
org: both
raised: 2026-08-06
updated: 2026-08-26
requirement: [SAL-18, SAL-04]
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

## 2026-08-24 - the lead rules are specified

The [24 August Lead/Opty session](../meetings/2026-08-24%20Interna%20per%20update%20flusso%20Lead-Opty.md) settled the lead-side mechanics, all
ROMI-internal and not yet put to the client:

- **Leads from the live event are identified by a `Lead Source` field, not by a
  Record Type.** This reverses the working assumption that "diretta" would be its
  own record type.
- **Form 2 auto-qualifies** — it creates Account, Contact and Opportunity,
  reusing an existing Account when the email matches.
- **No duplicate lead** where the email matches an existing Account or Contact;
  it goes straight to an Opportunity if one is needed.
- **`Non risponde`**, set manually, creates a call task automatically with a
  **48-hour reminder notification**.
- **`Primo contatto`** leaves the follow-up task to the tutor to create by hand,
  with no system-imposed due date.
- **`Non qualificato`** requires an exit reason chosen through a **flow with a
  popup**.

An open action asks for a **hidden field on the Web-to-Lead form** to track
direct provenance, and Elena Spini is to get more detail on what the "diretta"
forms actually need.

The `CODE` container for custom assignment remains as drawn in
[the master diagram](../The%20newest%20design%20diagram.md), which confirms ROMI can support assignment by Marco
Montesi's choice.
