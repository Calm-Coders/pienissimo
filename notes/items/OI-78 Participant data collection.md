---
id: OI-78
type: open-item
status: open
owner: Aurel Mrruku
with: Elena Spini
org: ROMI
raised: 2026-08-06
updated: 2026-09-07
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

## 2026-08-24 - the client walked through their current version of it

The [19 August MKT session](../meetings/2026-08-19%20Flussi%20MKT%20Biglietti.md) covered the participant flow in enough detail to
build against, as it works today in Zoho:

- The communication carries a **link containing the Account id**, redirecting to
  a landing page where the referente who bought the tickets names the attendees —
  **Nome, Cognome, Email** — with **as many rows as tickets purchased**.
- **Fields autocomplete if the contact already exists**: entering a known email
  makes the system recognise the contact and fill the rest; otherwise a new
  contact is created and associated to the company.
- On confirmation, each participant is emailed **the ticket, the QR code and the
  authorisation and profiling-consent documentation**.
- The QR code carries the **campaign member id**, per
  [OI-84](OI-84%20Campaign%20Member%20handling%20for%20manual%20check-in.md).
- Rebecca Marmo showed that the current system uses **variable fields (`CF1`,
  `CF2`, …)** pulled from the CRM to personalise both the emails and the landing
  page, which is how one funnel serves several concurrent events.

**On a late withdrawal**, the group agreed that notification needs **no complex
logic** — it can be handled by manual communication, provided the system allows
the state to be updated.

Not settled here: who hosts the page —
[OI-86](OI-86%20Who%20hosts%20the%20participant%20landing%20page.md) — and
whether it is the same surface as the quote landing page in
[OI-68](OI-68%20Quote%20acceptance%20landing%20page.md).

## 2026-09-03 - built

`lwc/participantRegistrationPage` and `ParticipantRegistrationController` (576
lines) merged to `DevMain` in PR **#31**, written by Rexhina Hysi, published to
the UAT sandbox the same day —
[the Landing Page community](../objects/The%20Landing%20Page%20community.md).

The controller matches this note's specification closely: it is entered with an
**account id and a campaign id**, returns the account, campaign and event dates
with **one `TicketRow` per visible Asset**, and looks a contact up by email
before creating one — the autocompletion Rebecca Marmo demonstrated on 19 August.
Assets are filtered to statuses `Disponibile` and `Assegnato`.

🟢 **The field divergence this note flagged has been resolved by the build.**
`TicketRow` carries `firstName`, `lastName`, `email` **and `phone`** — the
6 August field list, not the 19 August diagram's three. That is a defensible
choice and it was made silently; **confirm it rather than discover it later.**

⚠ **Still not visible in the code**, so still open on the design:

- **Campaign Member creation** — this note's core mechanism. The controller reads
  the Campaign but nothing in it adds members.
- **The QR document and its mail.** The QR is supposed to carry the campaign
  member id ([OI-84](OI-84%20Campaign%20Member%20handling%20for%20manual%20check-in.md)).
- **The name-change-before-the-event path** and its regenerated QR.

So the data-entry surface exists and the downstream half does not.

🔴 **It is reachable with an account id and a campaign id and nothing else** —
and this note's own mechanism is a marketing mail carrying the account id in the
link. See
[the authentication risk](../risks/Risk%20-%20the%20community%20pages%20have%20no%20application-level%20authentication.md).

⚠ **[OI-86](OI-86%20Who%20hosts%20the%20participant%20landing%20page.md) — the
blocker this note has waited on since 6 August — was never answered.** It was
overtaken.

## 2026-09-07 - rinuncia joins this page, and the flow around it is specified

🔴 **The community page has to grow a rinuncia path.** Agreed ROMI-internally at
[the marketing session](../meetings/2026-09-07%20Interna%20Flussi%20MKT.md): the
option is removed from the marketing email and handled on the community instead,
because Marketing Cloud cannot resolve *which assets* an email button refers to,
and a guided path can
([the decision](../decisions/Decision%20-%20rinuncia%20moves%20from%20the%20marketing%20email%20to%20the%20community.md)).
This is unbuilt work on a page that merged on 3 September, arriving after the
Fase 1 development deadline.

⚠ **What the button does is unspecified beyond the tickets** —
[OI-127](OI-127%20What%20a%20total%20rinuncia%20does%20to%20orders%20and%20assets.md).
Rinuncia cancels **all** tickets and is never partial, in writing since 20 August.
The order behind them and the credit toward future events are open.

🟢 **The collection mechanism was walked through and matches what is built**: the
buyer receives a link by email, enters participants against the tickets bought,
and that generates the QR code, the contact and the CampaignMember tied to the
product and the event date. Asset states named in session: `disponibile`,
`utilizzato`, `annullato`.

🔴 **Who the link goes to is now settled, and it is not the titolare.**
[Data Model Parte 3](../meetings/2026-09-07%20Data%20Model%20Parte%203.md) settled
that the recipient is whoever the **preventivo** was made out to — possibly an
assistant — and that the `contatto principale` flag is set manually by tutors and
**is sometimes absent**. Agreed shape for the form\'s contact field: **mandatory,
free selection among the account\'s contacts, pre-filled with the contatto
principale where one exists, editable**. ⚠ Aurel Mrruku added that the address the
link is sent to lives on the **Account** and _"non è detto che la stessa mail sarà
la mail del contatto principale"_ — which bears on
[the invitation build](../flows/Proposed%20event%20invitations%20for%20participant%20registration.md),
where a recipient contact is resolved.

🔴 **`Ruolo iscrizione` must exist on the form.** `titolare` / `collaboratore`,
chosen by the customer at ticket compilation and **not editable by Pienissimo**.

**New**: [OI-126](OI-126%20An%20asset%20flag%20for%20incomplete%20participant%20data.md)
— a Salesforce flag marking tickets whose participant data is not yet filled in,
so the nurturing flow can key off it.
