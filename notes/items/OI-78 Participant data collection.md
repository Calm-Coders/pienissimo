---
id: OI-78
type: open-item
status: open
owner: Aurel Mrruku
with: Elena Spini
org: ROMI
raised: 2026-08-06
updated: 2026-08-14
depends_on: [OI-86]
source: meetings/results/2026-08-06-chiusura-punti-aperti.md
requirement: BIG-09
---

# OI-78 - Participant data collection

The buyer — the company owner who paid, and initial holder of every ticket —
gets a landing page with **one row per ticket** and enters **name, surname,
email and phone** per participant. Each becomes a Contact linked to the asset,
created if absent, and is added as a **Campaign Member**. Each participant then
receives their own QR document to print.

Two edge cases were specified:

- **Name change before the event** — a button on the account lists its assets:
  cancel the old one, enter the new holder, **a new QR is generated** (the
  document prints name and event above the code), and updated documentation
  goes **to the new address**.
- **Substitution or missing documents at check-in** — staff verify ticket,
  order and payment, the attendee **re-signs the paper form**, staff key it in.
  **No QR is issued.**

The commonest case is not substitution but people who never printed or never
received the mail. Elisa Migliano named the live root cause: clients who
unsubscribed from marketing email stopped receiving their tickets — _"era un
cane che si mordeva la coda."_

Build pending, and it needs
[OI-86](OI-86%20Who%20hosts%20the%20participant%20landing%20page.md) answered
first. The manual check-in path leaves
[OI-84](OI-84%20Campaign%20Member%20handling%20for%20manual%20check-in.md) undesigned.
