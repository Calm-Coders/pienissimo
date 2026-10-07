---
id: MTG-2026-10-07-uat-woocommerce-mexal
type: meeting
status: resolved
owner: Elena Spini
org: both
raised: 2026-10-07
updated: 2026-10-07
depends_on: [OI-213, OI-214, OI-215, OI-216, OI-217, OI-218, OI-219, OI-206, OI-208]
source: Drive 1qsWO7dkpFEcOW8-k4R2WvMY4bYSeorCioqYnYQCGtZo (Gemini notes)
---

# 2026-10-07 UAT Integrazione WooCommerce e Mexal

**Client session, 10:00 CEST, ~2h18m.** Elena Spini · Aurel Mrruku ·
**Fabrizio Paganelli · Sabatino Rinaldi · Elisa Migliano**.

🔑 **The first session to drive a WooCommerce order the whole way — shop →
Salesforce → Anticipay → Mexal → invoice → scadenzario → collected — and the
first time the nightly invoice sync was watched moving an order to paid against
a real collection registered in Mexal.**

⚠ **The Gemini notes date every milestone in August** ("12 agosto", "13
agosto", "16 agosto", "21 agosto"). The months are a transcription error: the
go-live of record is **21 October** ([OI-124](../items/OI-124%20Go-live%20moved%20from%206%20to%2021%20October.md))
and the calendar invitation Elena Spini sent at 12:27:17Z the same day places
the e2e session at **Mon 12 Oct 2026 16:00–18:00**, matching the notes' own
"dalle 16:00 alle 18:00". The October readings are used throughout this note.

## Concordato — five rulings

- 🔑 **WooCommerce payment methods map to Mexal codes.** Credit card and PayPal
  (through BrainTree) → code `2`, _rimessa diretta_. Bank transfer → code `12`,
  _bonifico data fattura_. Fabrizio Paganelli and Elisa Migliano also named
  code `20` for _bonifico fine mese data fattura_ and, later, code `64` for
  fine-mese/RID inside bundles; `12` is the one adopted for the WooCommerce
  tests. The mapping table itself is still Aurel Mrruku's to write
  ([OI-219](../items/OI-219%20Default%20payment%20method%20and%20agent%20for%20WooCommerce%20and%20Palco%20orders.md)).
- **An order keeps the agent it was created with.** Changing the agent on the
  customer registry afterwards does not move orders already created. Fabrizio
  Paganelli and Elena Spini: the agent is inherited from the customer registry
  **at order creation**, and the relevant fields are the agent category and the
  commission category.
- **Book purchases are funnelled onto the new WooCommerce shop** being
  configured. Sabatino Rinaldi and Fabrizio Paganelli confirmed book purchases
  generate delivery notes (`BC`), and that all products and orders move to the
  single shop Sabatino Rinaldi manages.
- **UAT credentials go to Fabrizio Paganelli and Elisa Migliano only**,
  explicitly excluding commercial staff. Elisa Migliano proposed it after Aurel
  Mrruku raised that testing against real registry data could corrupt both
  Mexal and Salesforce; test accounts are to be used instead.
- **Confirmation for the production release is due on 13 October**, with later
  changes still possible. Elena Spini tied it to marketing's ticket tests in
  production on 16 October and the 21 October go-live.

## Da approfondire — one

- **The default payment method for bundles.** Deferred pending formal proposals
  from Aurel Mrruku and Elisa Migliano
  ([OI-219](../items/OI-219%20Default%20payment%20method%20and%20agent%20for%20WooCommerce%20and%20Palco%20orders.md)).

## What the end-to-end run established

🟢 **The standard cycle completed.** Aurel Mrruku summarised the sequence that
ran: offer created, quote sent, signed digitally, customer and order
synchronised to Mexal, invoices and scadenzari retrieved by the scheduled jobs,
order lines and payment links updated, opportunity set to closed-won.

🟢🔑 **The 03:30 invoice sync was verified against a real collection.** Aurel
Mrruku showed the structure linking invoices to customers, orders and
scadenzari, keyed on the year, the document type and the progressive line
identifier, tracking residual amount, payment state and days late. Fabrizio
Paganelli registered a collection in Mexal; after Aurel Mrruku ran the sync, the
order's state on Salesforce moved to **paid on its own**, updating the history
and the individual order lines. **This is the first verification of the
[OI-206](../items/OI-206%20The%20Insoluto%20concept%20has%20no%20invoice%20due%20date%20and%20no%20invoice%20record.md)
/ [OI-208](../items/OI-208%20Overdue%20and%20upcoming%20payments%20are%20not%20distinguished%20on%20the%20contract.md)
build against live ERP data**, four days after the objects were created.

🔴 **Four distinct failures stopped an order reaching Mexal**, each one now its
own row:

- Order lines arrive in state `S` (sospeso) and cannot be invoiced
  ([OI-213](../items/OI-213%20Mexal%20order%20lines%20arrive%20suspended%20and%20cannot%20be%20invoiced.md)).
- The agent code is mandatory and WooCommerce orders may carry no agent
  ([OI-214](../items/OI-214%20The%20Mexal%20order%20send%20requires%20an%20agent%20code%20WooCommerce%20orders%20lack.md)).
- A bundle article code used by the shop did not exist in Mexal; Fabrizio
  Paganelli offered to create it or supply a current code
  ([OI-217](../items/OI-217%20The%20article%20code%20revision%20needs%20direction%20approval.md)).
- The document `causale` came through unvalued, which matters for San Marino
  electronic invoicing; Fabrizio Paganelli owes Aurel Mrruku the correct code
  through the API.

🔴 **Anticipay does not cover San Marino.** Aurel Mrruku established it operates
only for Italian addresses, which led the room to prefer the Italy state for
compatible addresses; foreign customers go straight from Salesforce to Mexal and
must supply a partita IVA
([OI-215](../items/OI-215%20Anticipay%20does%20not%20cover%20San%20Marino%20addresses.md)).

🔴 **The shop pushed its unsent order backlog into Salesforce.** Enabling the
send to Salesforce by hand forwarded every order not previously sent, so past
orders for real customers landed in Salesforce unexpectedly. Sabatino Rinaldi
will correct the behaviour in the plugin
([OI-216](../items/OI-216%20The%20WooCommerce%20plugin%20flushed%20its%20unsent%20order%20backlog%20into%20Salesforce.md)).
⚠ **This answers the question Aurel Mrruku put to Sabatino Rinaldi at 10:34:40Z
on 06/10** — the WooCommerce orders appearing in Salesforce were **not** client
tests.

⚠ **Real customer records were visible in the run.** The backlog carried named
past customers, and the live tests used real registry data, fictitious partite
IVA and a real collection figure. **The values are deliberately not recorded
here**; that they exist in the recording and in the notes document is the fact
worth keeping.

## Still unsettled at the end of the session

- 🔴 **Direction has not read the Business Blueprint** while the production
  confirmation is due on 13 October. Fabrizio Paganelli raised doubts about the
  timeline on exactly that ground; Sabatino Rinaldi undertook to forward the
  document to Daniela Morgese and read it himself
  ([OI-218](../items/OI-218%20Direction%20has%20not%20seen%20the%20Business%20Blueprint%20before%20the%2013%20October%20confirmation.md)).
- **Bundle, recall tutor, performance plus and renewal paths are untested.**
  Fabrizio Paganelli named them; the e2e session of 12 October is where they go.
- **Showcase events** (Tour, Food) admit participants with unknown registry data
  or fictitious partite IVA, and foreign customers fall outside Anticipay — the
  administrative handling was discussed and not resolved.
- Elena Spini owes a **training calendar** proposal for sessions from the
  following week.
- A **dedicated mailbox** for automatic system notifications is owed to Aurel
  Mrruku by the group.
