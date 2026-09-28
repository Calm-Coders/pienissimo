---
id: OI-162
type: open-item
status: open
owner: Elena Spini
with: Elisa Migliano
org: both
raised: 2026-09-22
updated: 2026-09-23
depends_on: [OI-161]
source: notes/meetings/2026-09-22 Temi QR Code Biglietti.md
---

# OI-162 - Infopoint and orphan tickets are deferred to Fase 2

Decided at
[Temi QR Code Biglietti](../meetings/2026-09-22%20Temi%20QR%20Code%20Biglietti.md)
by **Elena Spini and Elisa Migliano together**, because UAT and the Fase 1 release
come first.

## What Infopoint is

A section of the client's check-in app
([OI-161](OI-161%20The%20event%20check-in%20app%20must%20integrate%20with%20Salesforce.md))
used by Andrea Parmeggiani and Elisa Migliano to **search or hand-enter contacts and
their companies** at the desk, recording a presence as a manual movement equivalent
to a scan. It covers attendees with no registration, with wrong data, or not in the
database at all — restaurant staff who change constantly are the example given.

⚠ **Both Elena Spini and Elisa Migliano said this screen is new relative to the flows
previously agreed.**

## Why it cannot be a small change

🔴 Aurel Mrruku's objection is structural: Salesforce ties **contact → order → asset
→ campaign member**, and **a ticket created with no order is an orphan record that
corrupts the statistics.** Infopoint creates exactly those.

It would need **four endpoints**: contact search and insert, company search, campaign
search, ticket search and create — with contact search **generic, not scoped to the
event**, precisely because the person may have no registration. The cases: existing
ticket; existing contact with no ticket; new contact with an orphan or negative
ticket.

## What is carried into Fase 1 anyway

- **Last-minute and on-site payments** already produce orders whose ticket does not
  exist, or attendance with no order. Andrea Parmeggiani's priority is recording
  presence in real time and fixing the paperwork next day — so the orphan case will
  occur during Fase 1 whether or not Infopoint is integrated.
- 🟢 **Elisa Migliano's post-event report** — tickets created with no order or
  contract, for manual clean-up — was confirmed feasible **provided the app sends the
  data**, which in Fase 1 it will not.

## Open

- ⚠ **Record what happens at a Fase 1 event when someone arrives with no ticket.**
  The deferral removes the integration, not the situation.
- ⚠ The deferral is a **ROMI-and-administration decision**; no Fase 2 scope line
  carries it yet.


## 2026-09-23 — the infopoint link survives the deferral

**[Check Data Import](../meetings/2026-09-23%20Check%20Data%20Import.md), `01:26:45`,
`01:29:03`.** Reviewing the child-campaign fields, Elena Spini and Aurel Mrruku **removed
the registration-form block field** and **confirmed the infopoint registration link is
present** on the edition.

⚠ So the **link** stays in Fase 1 while the **desk mode behind it** is deferred. Nothing
in the session says what the link does at a Fase 1 event, and this note's open question —
what happens when someone arrives without a ticket — is untouched.

🟢 Reinforced from the same session: the multi-entry logic this deferral sits beside is
now explicitly Fase 2 →
[the decision](../decisions/Decision%20-%20ingressi%20live%20on%20the%20campaign%20edition%20and%20are%20Fase%202.md).
