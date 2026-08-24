---
id: MTG-2026-08-24-leadopty
type: meeting
status: resolved
owner: Elena Spini
org: ROMI
raised: 2026-08-24
updated: 2026-08-24
source: Drive - "[PIENISSIMO] - Interna per update flusso Lead/Opty Aurel / Elena - 2026/08/24 16:00 CEST - Appunti di Gemini", doc 1Zjgxblp9WM1AzMZ9yRWRsL3LUVR-PCWF3xWrzLVyK_A
---

# 2026-08-24 Interna per update flusso Lead-Opty

**ROMI-internal working session, 24 August 2026, 16:00 CEST** — Elena Spini and
Aurel Mrruku only. No client present. Gemini notes, transcript and a recording
all exist.

This is the session MAP.md had scheduled and the 21 August sweep named as the
cheapest forum for the three unresolved rulings. It did not answer those three;
it specified the Lead and Quote build instead, in more detail than any prior
session.

⚠ **ROMI-internal design decisions, not client agreement.** Nothing here was put
to Pienissimo. Where one of these contradicts a minuted client session, the
client's minute governs until reconciled — see the conflict recorded below.

## Agreed — Lead

- **Lead from the live event is identified by a `Lead Source` field, not a
  Record Type.**
- **Form 2 auto-qualifies**: it creates Account, Contact and Opportunity, reusing
  an existing Account when the email matches.
- **No duplicate lead** is created when the email matches an existing Account or
  Contact — it proceeds straight to an Opportunity where one is needed.
- **`Non risponde`** set manually triggers automatic creation of a call task with
  a **reminder notification after 48 hours**.
- **`Primo contatto`** requires the tutor to create the follow-up task **manually**
  — the system imposes no due date.
- **`Non qualificato`** requires an exit reason, selected through a **flow with a
  popup**.

See [OI-80](../items/OI-80%20Lead%20routing%20queues.md).

## Agreed — Quote and Opportunity

- **Quotes go out both by email and as a link to a custom landing page / portal**,
  built as a custom **LWC** to control external access. Aurel Mrruku to build a
  PoC. See [OI-68](../items/OI-68%20Quote%20acceptance%20landing%20page.md).
- **Tranches are created and managed manually by the user at Quote (offerta)
  level, before the order is generated.** See
  [OI-50](../items/OI-50%20Tranche%20object.md).
- **Products and tranches may only be edited while the quote is in Bozza.** Once
  it is "in attesa di accettazione", no further changes.
- **Quote creation is permitted only during `trattativa`**, with an automatic move
  into that state if a quote is raised from `qualificato`.
- **Primary-quote logic**: accepting the primary quote automatically rejects all
  other quotes on the opportunity; **rejecting the primary quote moves the whole
  opportunity to rejected**.
- **Expiry**: a trigger sets the quote expiry date to **5 days from sending**, and
  the tutor may shorten it manually down to the current day.
- **Reminder**: if two days after the opportunity moves to `trattativa` the quote
  is still not accepted, a notification and a reminder task are generated, plus a
  **reminder email to the client** from a dedicated template.
- **`Da ricontattare` requires mandatory fields** — reason and recontact date —
  enforced by trigger, both for the generic case and for the "preventivo inviato"
  case.

See [OI-59](../items/OI-59%20Quote%20workflow%20configuration.md).

## ⚠ Conflict with the 20 August client minute

The [20 August session](2026-08-20%20Flusso%20Asset%20Biglietti.md) minuted, to the
client, that marking "Da ricontattare" **does not** generate a task and that an
informational **banner** is used instead. This session specifies a **validation
rule plus trigger** on the same state, and its action list still carries
_"Configurare notifiche reminder"_.

These are not flatly contradictory — a banner and a validation rule can coexist —
but the "no automatic task" ruling is a client-facing commitment and the internal
session did not reference it. **Do not build either until someone reconciles
them.** Recorded on [OI-59](../items/OI-59%20Quote%20workflow%20configuration.md).

## Actions

| Owner | Action |
| ----- | ------ |
| Aurel Mrruku | Build a PoC landing page for external quote visibility |
| Aurel Mrruku | Implement validation and triggers for the mandatory "da ricontattare" fields |
| Aurel Mrruku | Set the trigger computing quote expiry at 5 days from "in trattativa" |
| Aurel Mrruku | Define the initial state and due dates for tranches |
| Aurel Mrruku | Clarify the technical spec for the two order types, WooCommerce vs internal |
| The group | Add a hidden field to the Web-to-Lead form to track direct provenance |
| The group | Automate the call task on manual `Non risponde` |
| The group | Configure custom reminder notifications with a 48h automatic reminder |
| The group | Build the `Non qualificato` popup flow for exit reasons |
| The group | Implement tranche creation and management on the quote |
| The group | Discuss the order handling with Andrea Di Cicco |
| Elena Spini | Ask for more detail on the requirements and data for the "diretta" forms |
| Elena Spini | Send Andrea Di Cicco an update to settle the final steps of the flows |
| Elena Spini | Get the reminder email template copy from Marco Montesi |

The last row is the same item the 20 August minute assigned to Marco Montesi and
Elisa Migliano — it is one outstanding ask, not two.
