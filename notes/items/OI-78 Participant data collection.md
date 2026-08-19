---
id: OI-78
type: open-item
status: open
owner: Aurel Mrruku
with: Elena Spini
org: ROMI
raised: 2026-08-06
updated: 2026-08-19
depends_on: [OI-86]
source: meetings/results/2026-08-06-chiusura-punti-aperti.md
requirement: BIG-18
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

## The mechanism, as drawn on 2026-08-19

[The 19 August ticket flow diagram](../The%20ticket%20flow%20diagram%20of%2019%20August.md)
specifies what the 06 August session left as an outline:

- Marketing sends the communication carrying a **link with the Account ID
  embedded in it**, redirecting to the landing page.
- The referent who bought the tickets supplies the list as
  **"Nome Cognome Email"** — three fields. ⚠ Note the divergence: the 06 August
  session recorded **name, surname, email _and phone_**. The diagram drops the
  phone. Neither is obviously later than the other in intent; **the field list
  is not settled**.
- **The number of rows to complete equals the number of tickets purchased** —
  the row count is derived, not free-form.
- On confirmation an SFDC flow **creates the Contacts that are not already in
  the CRM and matches the ones that are**, then **adds Campaign Members** to the
  chosen campaign/event. A mail then delivers the QR code.

**One branch was drawn and struck out**: _"Se quell'Account ha acquistato più
eventi: scelta dell'evento al quale si fa riferimento"_ carries a line-through
in the file. A plausible reading is that the page never needs to ask, because
each event already runs its own countdown and its own communication
([OI-81](OI-81%20Event%20communication%20funnel.md)) — but a struck box is not a
recorded decision, and this is worth one sentence of confirmation.

Build pending, and it needs
[OI-86](OI-86%20Who%20hosts%20the%20participant%20landing%20page.md) answered
first — the diagram still does not say **who hosts the page**, only what it
does. The manual check-in path leaves
[OI-84](OI-84%20Campaign%20Member%20handling%20for%20manual%20check-in.md)
undesigned; the diagram's `CASO 2` confirms it stays manual, with **no
automation at all**.
