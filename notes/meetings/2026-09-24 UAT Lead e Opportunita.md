---
id: meeting-2026-09-24-uat-lead-opportunita
type: meeting
status: active
owner: Elena Spini
org: both
raised: 2026-09-24
updated: 2026-09-24
source: Drive, Appunti di Gemini + Trascrizione, 2026-09-24 15:00 CEST
---

# 2026-09-24 UAT Lead e Opportunita

**The first client acceptance session of the project.** 24/09, 15:00 CEST, ~2h08m.
Invited: Marco Montesi, Fabrizio Paganelli, `amministrazione@`, Sabatino Rinaldi
(Pienissimo); Elena Spini, Aurel Mrruku (ROMI). Elisa Migliano joined for the DocuSign
passage. Gemini notes + full transcript read (155,961 characters).

It ran end to end: lead in by form, conversion, opportunity, quote, tranche, PDF,
acceptance on the Community, DocuSign signature, order. **Nothing in it was rejected.**
Seven improvements were agreed, one label was reopened, and two defects surfaced live.

## What the client agreed

| Ruling                                | Detail                                                                                                                                                                                            |
| ------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Lead assignment**                   | Incoming leads go to **one named person** who redistributes, not to a queue — queues require a manual pull. Marco Montesi asked to hold high-value leads himself                                  |
| **Agent is mandatory to qualify**     | A Lead cannot reach `Qualificato` without an agent/tutor. Fabrizio Paganelli: **"agente" and "tutor" are synonyms**, and the value goes to Mexal                                                  |
| **Generic opportunity close date**    | Last day of **the following year**, by convention                                                                                                                                                 |
| **Primary quote**                     | Many quotes per opportunity; one is primary and its value rolls onto the opportunity. If the winning quote was never marked primary, the first quote to be accepted becomes primary automatically |
| **Tranche total on screen**           | Show each tranche's total next to its due date; show the running sum while products are being picked                                                                                              |
| **Unit of measure in the PDF**        | Add the `unità di misura` column to the quote PDF table                                                                                                                                           |
| **Sender and CC**                     | Replace the generic _"team Pienissimo"_ sender with the **agent's name**; add a **CC field** so a collaborator or director can receive the proposal                                               |
| **New quote state `Firmato`**         | Distinct from `Accettato`. `Accettato` = confirmed on the Community; `Firmato` = the signed document came back from DocuSign                                                                      |
| **Order on signature**                | The order is generated automatically when the quote reaches `Firmato`                                                                                                                             |
| **Opportunity Closed Won at incasso** | Only when the order is collected, not at signature                                                                                                                                                |
| **Multiple quotes per opportunity**   | Accepting one sets the others to a final rejected state, for statistics                                                                                                                           |
| **Daniela Morgese sees it last**      | A 2–3 hour walkthrough once the core is finished, "99 percent" refined                                                                                                                            |

## Reopened: the word "rifiutato"

Accepting one quote automatically sets every other quote on the opportunity to
`Rifiutato`. **Fabrizio Paganelli and Marco Montesi both objected to the label** — those
quotes represent real work done during a negotiation, not a customer rejection. Marco
Montesi proposed recording the reason (the close of another offer) through a description
or a flag driven by the automation; Fabrizio Paganelli wants a won opportunity to show a
column with the count of quotes produced, so a salesperson's effort is visible without
polluting lost opportunities — explicitly to beat a limit of the previous system.

⚠ **The mechanism is agreed; the wording is not.** The Gemini notes file this under
_"Da approfondire"_, and no alternative label was chosen in the room.

## Two defects, live in front of the client

- 🔴 **Every lead from the form gets the `Diretta` record type.** At `00:41:46`
  Elena Spini: _"Sono tutti record type diretta, ecco perché si vedono così. Quindi è
  sbagliato."_ In the DM at **15:43:58 CEST**, during the session: _"nulla mette solo rt
  diretta"_; Aurel Mrruku: _"asp che li chiedoo il htm correto"_. The blank-record-type
  defect is fixed — the wrong-record-type defect replaces it →
  [OI-176](../items/OI-176%20Web%20to%20Lead%20assigns%20every%20lead%20the%20Diretta%20record%20type.md).
- 🔴 **The first DocuSign send failed on the edition mapping.** Aurel Mrruku, `01:26:58`:
  _"non ti arriverà mai DocuSign perché ho messo dei prodotti che non sono sulla
  mappatura"_. He restated the cause at `01:39:14`: ticket-type products with no link to
  a child campaign. The same fault raised a sandbox Apex exception at 11:13Z the same
  day — `Nessuna mappatura edizione trovata per il prodotto ACADEMY alla data ordine
2026-09-24`, `OrderTriggerHandler.assignCampaigns` line 334.

## What worked

- 🟢 **A DocuSign envelope reached a client-domain recipient.** Fabrizio Paganelli,
  `01:31:50`: _"Sì, l'ho ricevuta."_ He signed in the DocuSign test environment and
  received the completed PDF at `01:45:31`; Aurel Mrruku received it too. **The block in
  [OI-174](../items/OI-174%20ROMI%20mail%20blocks%20DocuSign%20envelopes%20to%20the%20dev%20team.md)
  is ROMI-side only** — the question that item asked is answered.
- 🟢 **A duplicate check fires on lead conversion.** At `00:29:22`–`00:33:41` conversion
  found a matching account and contact by name and email across Leads, Contacts and
  Accounts, and offered merge or create. Fabrizio Paganelli walked the logic back and
  confirmed it → [OI-163](../items/OI-163%20Lead%20conversion%20has%20no%20agreed%20duplicate%20rule.md).
- 🟢 The agent block on `Qualificato` was demonstrated and accepted, not merely proposed.
- 🟢 `Non Risponde` generated the callback task live, with an editable date.
- 🟢 `Non Qualificato` requires an exit reason and detail, and blocks conversion.
- 🟢 **Sabatino Rinaldi on the WooCommerce integration**: the best one delivered so far,
  proved in twenty minutes of testing after a week of checks.

## Data anomalies found in the imported accounts

Aurel Mrruku raised these from the `Account_NEW` load before the session and again at
`00:23:28`: **one tutor has two accounts carrying different agent codes**, and **another
has no agent code at all**. Fabrizio Paganelli offered two explanations — a pending
overnight alignment, or private customers who are never invoiced. Agreed: Aurel Mrruku
merges the duplicate, **Fabrizio Paganelli checks the agent codes on Mexal**, because
they must match the codes on the orders.

⚠ The codes and the individuals' names are **not reproduced here**; they are customer
and personnel data. See
[OI-169](../items/OI-169%20Agent%20code%20and%20commissions%20come%20from%20the%20customer%20record.md).

## Access, and who may touch the org

- 🔴 **The client still has no UAT users.** Sabatino Rinaldi asked to explore on his own;
  Elena Spini and Aurel Mrruku asked him to wait until the data fixes and tests are
  done, **indicatively 6 October**. The action item reads: release the hardened logins
  _"una volta completata la revisione da parte di Daniela"_ →
  [OI-180](../items/OI-180%20Client%20UAT%20users%20are%20withheld%20until%20a%20director%20review.md).
- Aurel Mrruku: the account load took about **six hours** and more fields still need
  correcting; bad input (wrong email addresses, missing P.IVA) breaks order generation.

## Still owed by the client

- **The marketing templates.** The forms shown were HTML simulations; Sabatino Rinaldi
  has not supplied the chosen templates. Definitive landing pages come later with
  Marketing Cloud.
- **How a `Standard` lead is meant to enter the system.** Aurel Mrruku at `00:41:46`:
  _"gli standard di solito come dovranno entrare in sistema?"_ Sabatino Rinaldi described
  web forms with pre-filled hidden fields (provenienza, tutor, mercato) and UTM
  parameters; Elena Spini put the question to Marco Montesi. **No ruling is recorded.**

## Next

- **WooCommerce integration test, Fri 25/09 10:30**, with Sabatino Rinaldi and Elisa
  Migliano; Marco Montesi is to be shown how the checkout link is generated. Elena Spini
  is to send Sabatino Rinaldi the invitation →
  [OI-158](../items/OI-158%20No%20UAT%20session%20is%20booked%20for%20the%20checkout-link%20flow.md).
- **All test activity finished by 6 October**, product at "99 percent", then Daniela
  Morgese's review, then client logins.
- Aurel Mrruku owes a detail note on product-to-campaign mapping by merchandise category.
