---
id: meeting-2026-09-25-uat-recall-tutor-bundle
type: meeting
status: active
owner: Elena Spini
org: both
raised: 2026-09-25
updated: 2026-09-25
source: Drive, Appunti di Gemini + Trascrizione, 2026-09-25 10:30 CEST (doc 1LqDYIf6U-GLsxAJ28h3JvTZ8wnaEW3_owShE8fY1-b4, 154,062 characters, read in full)
---

# 2026-09-25 UAT Recall Tutor e Bundle

**The second client acceptance session. It did not accept the flow it was booked
for: it found that the WooCommerce design had been built on a wrong premise.**
25/09, 10:30 CEST, **2h13m50s**. Invited: Marco Montesi, Fabrizio Paganelli,
`amministrazione@`, Sabatino Rinaldi (Pienissimo); Elena Spini, Aurel Mrruku
(ROMI). Elisa Migliano joined around `00:10:10` and had left by `00:19:58`; the
recording is to be sent to her.

⚠ **Speaker labels.** The first `Giuliano Lanzetti` lines are someone who _"sono
entrato con il profilo di Giuliano"_ and rejoined under their own name,
**probably Fabrizio Paganelli (uncertain)**. `Marco` is Marco Montesi throughout.
The Gemini summary lists as _agreed_ a "bundle modificabile" flag that the
transcript leaves unresolved (see below). Where the two disagree, this note
follows the transcript.

## What was shown and accepted

- **The Recall Tutor opportunity.** Chosen at creation from the three record
  types. It has **no quote phase**. Two buttons: generate the checkout link
  (base URL + funnel name + opportunity ID), and send the checkout email. The
  funnel name is supplied by the client. **In operation Matteo Distaso supplies
  the cart/funnel names** (Sabatino Rinaldi, `00:11:22`). A wrong link can be
  tested from the same screen.
- **The WooCommerce order arrived under the opportunity**, in state `Ordinato`,
  after two live fixes (below). Marco Montesi and Sabatino Rinaldi followed it
  end to end.
- **Configura Bundle**: only products whose `natura` makes them sellable in a
  bundle are offered. Each line can take a percentage discount or a manual price,
  and an omaggio line stays at zero. **Saving is blocked when the line total does
  not equal the declared bundle price.** Fabrizio Paganelli asked for exactly that
  check (`01:05:25`).
- **A custom post-conversion page** replaces the standard Path after Lead
  conversion. It refreshes the page and lands the user on the Account or Contact,
  fixing the stale-header defect seen on 24/09 (Aurel Mrruku, `00:02:46`).

## Rulings

| Ruling                                         | Detail                                                                                                                                                                                                                                                                                                                                                                                             |
| ---------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Checkout email: a button, not a raw link**   | This hides the opportunity ID. A raw link _"sembra anche una cosa maliziosa"_ (Aurel Mrruku, agreed by Elena Spini, `00:17:08`)                                                                                                                                                                                                                                                                    |
| **Checkout email: personalised and prefilled** | Recipient prefilled with the **primary contact's email**, still editable. Greeting by the customer's name instead of _"gentile cliente"_, and signed by the **agent/tutor** instead of _"team Pienissimo"_. Marco Montesi: _"questa cosa… è fondamentale"_                                                                                                                                         |
| **Single products come only from Mexal**       | _"l'anagrafica prodotti, tranne i bundle, arriva tutta da Mexal"_ (Fabrizio Paganelli, `01:04:09`). The button that creates a simple product in Salesforce goes. **Only bundles are created in Salesforce, and only by Fabrizio Paganelli** → [the decision](../decisions/Decision%20-%20single%20products%20come%20only%20from%20Mexal%20and%20only%20bundles%20are%20built%20in%20Salesforce.md) |
| **Bundle product code is mandatory**           | It is the key WooCommerce uses to find the bundle in Salesforce (Aurel Mrruku, `01:05:25`)                                                                                                                                                                                                                                                                                                         |
| **Bundle fields renamed and added**            | 🔑 `anno solare` → **`Anno accademico`** (a reversal, see [OI-46](../items/OI-46%20Bundle%20classification%20picklists.md)); `Evento` → **`Evento di origine`**, the event at which the bundle was proposed; new flag **`Presenza piattaforma`** (yes/no: the software platform given free inside the bundle)                                                                                      |
| **Stage-sale orders go to Mexal unattended**   | No human check between WooCommerce and Mexal for stage sales: the tutor sells _"esattamente quello che è stato venduto da palco da Giuliano"_ (Fabrizio Paganelli, confirmed by Elena Spini, `01:02:54`)                                                                                                                                                                                           |
| **Tailored tutor sales never use WooCommerce** | Sabatino Rinaldi, `01:41:07`: otherwise _"significa avere un reparto che fa solo quello"_. They stay quote-based, and card payment goes through a separate payment link (Nexi today). Marco Montesi is steering customers away from cards towards direct debit                                                                                                                                     |
| **Fixed packages may use WooCommerce**         | Anything decided in advance that the tutor cannot change (a Summer Pack, a fixed Anno con Pienissimo with a deposit) can be sold through WooCommerce, the same way as a recall. Marco Montesi wants WooCommerce used _"quanto più possibile"_                                                                                                                                                      |
| **A WooCommerce opportunity type**             | The Recall Tutor type is widened into a **WooCommerce** type, with a mandatory picklist for the origin: **Recall Tutor** or **Pack Tutor** (Fabrizio Paganelli's label, `01:56:38`) → [OI-182](../items/OI-182%20A%20WooCommerce%20opportunity%20record%20type%20replaces%20Recall%20Tutor.md)                                                                                                     |
| **Origin is read from the bundle parent**      | The same article (for example Academy) inside two different bundles is told apart through order line → product → **parent bundle**. Agreed by Fabrizio Paganelli, Elena Spini and Aurel Mrruku, `02:04:06`                                                                                                                                                                                         |

## 🔑 The finding: stage-sale bundles need their tranches on the bundle

Fabrizio Paganelli explained how a stage sale works (`00:36:13`–`01:00:14`). He
builds the bundle with its **total**, its lines and **a due date on every line**.
He then gives Sabatino Rinaldi the bundle code and the **first-tranche amount**.
WooCommerce sells only that first tranche, **but Salesforce must receive the whole
bundle order**. Under Zoho today, the completed WooCommerce order creates a parent
order for the whole bundle and one child order per tranche. The administration
then releases each tranche to Mexal by hand, month by month.

**ROMI had built tranches only at the quote stage**
([OI-50](../items/OI-50%20Tranche%20object.md)), and a stage sale has no quote.
Aurel Mrruku, `00:44:30`: _"questo peso proprio mi mancava… mai considerato"_.
Fabrizio Paganelli had _"fino ad oggi… sempre inteso"_ that he would set the due
dates on the bundle itself.

**Resolution in the room:** tranche creation also moves to **bundle creation**.
An order arriving from WooCommerce takes its tranches from the bundle, and
Salesforce ignores the WooCommerce price. A quote that uses the bundle
**inherits the tranches as defaults, and the tutor can change the dates and move
lines between tranches**. The tutor never changes the bundle's components.
Fabrizio Paganelli's minimum per line is: article code, quantity, list price,
discount and due date. **Aurel Mrruku estimates at least one week**, `02:05:08` →
[OI-181](../items/OI-181%20Stage-sale%20bundles%20need%20their%20tranches%20defined%20at%20bundle%20creation.md).

⚠ **The "bundle modificabile" flag is not settled.** Fabrizio Paganelli proposed
it (`00:46:03`). Aurel Mrruku answered with the inherit-then-edit design, which
makes the flag unnecessary for quotes. Gemini records the flag as agreed and
gives Fabrizio Paganelli an action to define it.

## Four kinds of sale, as the client now states them

Fabrizio Paganelli's own schema (`01:46:50`), restated by Sabatino Rinaldi at
`01:51:41`:

| Kind                                           | Created by              | Opportunity?   | Payment channel                                      |
| ---------------------------------------------- | ----------------------- | -------------- | ---------------------------------------------------- |
| Stage sale, direct (QR code in the room)       | administration's bundle | **no**         | WooCommerce                                          |
| Stage sale, indirect (**Recall Tutor**)        | the same bundle         | yes            | WooCommerce link                                     |
| Fixed package sold by a tutor (**Pack Tutor**) | administration's bundle | yes            | WooCommerce link                                     |
| Tailored sale by a tutor                       | the tutor, on a quote   | yes (Standard) | bank transfer or payment link, **never WooCommerce** |

A stage-sale customer scans a QR code and enters their own data, including the
VAT number. Bank transfer leaves the order for the administration to complete.
Card or PayPal moves it automatically to `in lavorazione`. **WooCommerce sends
the customer's details, and Salesforce must match an existing customer or create
the Account and Contact** (Sabatino Rinaldi, `01:59:49`). Aurel Mrruku noted that
creating the order also calls Mexal and Anticipay. Sabatino Rinaldi showed a
section of his plugin, **currently disabled**, that would send any self-service
order (a ticket, for example) to Salesforce.

## Two defects fixed live, both known

1. **HTTP 500 from Salesforce**: the product on a pre-existing test order was
   inactive and had no price. Aurel Mrruku activated it.
2. **`TicketGenerationException`: no edition mapping for the product.** Aurel
   Mrruku created a Mappatura Edizione row pointing the product at a test edition
   on the spot. It is the same throw-don't-degrade path as 24/09
   ([OI-96](../items/OI-96%20Edition%20mapping%20table%20on%20Salesforce.md)).

Also noted: an order created through the integration should show the
**integration user**, not the developer who configured it. And the order's value
was empty because the mapping carries no prices.

## Deferred

- **Checkout email template**: a dynamic template in code (a developer is needed
  to change the base text, though each email stays editable in the pop-up), or
  standard Salesforce email templates (an admin can edit them, but they cannot
  pull the tutor's name). **Left to the client**. Fabrizio Paganelli wants every
  customer-facing text reviewed with the direction first →
  [OI-183](../items/OI-183%20The%20checkout%20email%20template%20choice%20is%20with%20the%20client.md).
- A button to create an opportunity straight from the Account (Aurel Mrruku's
  proposal; not answered).

## Calendar changes

- 🔴 **The marketing environment is only reachable in production**, so the
  **Fri 2 October session (Flussi MKT and tickets, with Rebecca Marmo) becomes a
  re-run of the WooCommerce flow**. A bundle will be built live from Fabrizio
  Paganelli's codes, Sabatino Rinaldi will create the matching product, and a
  non-bundle self-service ticket purchase will also be tested. **Marketing moves to
  7 October.** Sabatino Rinaldi is to tell Rebecca Marmo.
- **Wed 30 September stays**: campaigns (parent and child) and tickets in
  Salesforce, **no marketing**.
- Elena Spini: _"per te hai lunedì e martedì per fare il deploy"_ (28–29/09). Aurel
  Mrruku pushed back that a deploy also needs records, and the Account load alone
  took a day and a half. It was **left for the two of them to settle afterwards** →
  [OI-177](../items/OI-177%20The%20marketing%20flow%20UAT%20needs%20production.md).

## How the room ended

Marco Montesi, `01:43:19`: _"una parte di questa riunione… la dobbiamo rifare
perché io mi son perso"_. Elena Spini agreed that all of it would be redone.
Marco Montesi then closed supportively: changes along the way are normal.
**The recall flow was demonstrated working, but the client does not consider it
accepted.** It is re-run on 2 October.

## Also in the sweep

- **Contacts are not migrated yet** (Aurel Mrruku, `00:05:41`), so test Accounts
  have no one to send the checkout email to.
- An unrecorded ROMI-internal call, Elena Spini ↔ Aurel Mrruku, 12:30–13:00 CEST
  the same day (_"entra qui please cosi registriamo se dovesse servire"_). **No
  notes or recording were found.**
- A new internal meeting `[PIENISSIMO] - Interna` is booked for **Fri 2 Oct 17:00
  CEST** (invitation from Elena Spini, 11:06Z).
