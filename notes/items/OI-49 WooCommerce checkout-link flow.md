---
id: OI-49
type: open-item
status: in-progress
owner: Aurel Mrruku
with: Sabatino Rinaldi
org: both
raised: 2026-07-31
updated: 2026-09-17
requirement: [INT-12, INT-13, INT-14, ORD-12]
source: meetings/open-items.md row 49
---

# OI-49 - WooCommerce checkout-link flow

A workstream decided on 31 July. The tutor generates a checkout URL from the
Opportunity carrying `sf_opp_id`; a WooCommerce mu-plugin
(`sf-opportunity-tracker.php`) stores it as order meta `_sf_opportunity_id` and
exposes it via REST as `sf_opportunity_id`; Salesforce reads the order, writes
back, and moves the Opportunity to Closed Won. Spec:
`Integrazione_Salesforce_WooCommerce.docx` (Sabatino Rinaldi, 31/07).

**Pull versus webhook is CLOSED: webhooks.**

📅 **The technical meeting is scheduled: Thursday 27 August 2026, 10:00–11:30** —
_"integrazione tecnica con WooCommerce tramite Webhook, comprensiva dello
scambio di credenziali"_. Invited: Aurel Mrruku, Andrea Di Cicco, Sabatino
Rinaldi. (Earlier notes said 26 August; the invitation says the 27th.)

**One of the two open decisions is now closed.** Elena Spini's
`PIENISSIMO - Project Status` document (6 August) states **"I coupon sono
esclusi dalla prima fase"** — so the negotiated-price-via-dynamic-coupon option
is out for phase 1, leaving the **WooCommerce listino** as the price source of
truth. Still open: whether the opportunity id travels **in clear or as a signed
token**.

**The spec itself was read on 2026-08-14** — it carries the complete mu-plugin
source, the URL anatomy (`?add-to-cart=[IDs]&quantity[ID]=N&coupon=X&sf_opp_id=Y`),
the REST contract (`GET /wp-json/wc/v3/orders/{id}` returning `sf_opportunity_id`
at top level), and an operational checklist split by team. Its closing section
lists **five** points for the two teams to agree; the records tracked two:

| Point to agree              | State                                                      |
| --------------------------- | ---------------------------------------------------------- |
| Pull vs webhook             | ✅ **closed — webhooks**                                   |
| Price source of truth       | ✅ **closed — coupons excluded from phase 1**              |
| ID in clear vs signed token | 🔴 open                                                    |
| **URL parameter name**      | 🔴 open — `sf_opp_id` is only the snippet default          |
| **ID format**               | 🔴 open — 15/18-char Salesforce id, or a custom identifier |

The last two were never tracked anywhere. Both are trivial to settle and both
break the integration silently if the two sides assume differently.

⚠ The spec's worked examples use an **invented** shop and invented prices
(`pienissimo-academy.it`, €497 / €297 / €150). They are not a price source.

The same document pins the sale-origin discriminator, which had been loose:
**"da palco"** is identified by the **product code on the WooCommerce order**;
**"recall tutor"** by a **mandatory field on the Opportunity** the tutor must
fill before generating the link. That field is the one carried by
[OI-70](OI-70%20Performance%20Plus%20opportunity%20typing.md).

**Partly built, unrecorded.** `Product2.WooCommerce_Product_Id__c` and
`Opportunity.WooCommerce_Order_Id__c` were both committed in early August,
after the org check that said neither existed —
[the build ahead of the record](../objects/The%20build%20ahead%20of%20the%20record.md).
Still to do: the link-generator button with product and quantity pickers, the
pre-filled email template, the joint PHP call, and an end-to-end test.

## 2026-08-25 - org check: the id fields exist and hold nothing

Verified read-only against **Pienissimo UAT**. Both fields from the INT-13 build
list are configured, in the org and in `force-app/`:

- `Product2.WooCommerce_Product_Id__c` — **populated on 0 of 280 products**
- `Opportunity.WooCommerce_Order_Id__c` — present

Nothing else on the INT-13 list exists: **no link-generator button** (the only
custom quick actions in the org are `Product2.Add_Products` and
`Quote.Crea_Tranche`), no Flow, no email template driving checkout, and no
named credential or callout configuration pointing at WooCommerce.
`API_Callout_Engine` and `Integration_Configuration__c` are
[ROMI's standard scaffolding](../Integration%20Configuration%20is%20standard%20ROMI%20scaffolding.md)
and are not WooCommerce-specific.

`Biglietto__c.Fonte_Acquisto__c` does carry a `WooCommerce` value, so the
_downstream_ attribution is ready for a channel that cannot yet transact.

Credentials are due at the **27 August** WooCommerce session. This check finds
nothing that would be blocked by anything other than those credentials and the
build time.

## 2026-08-27 - both sessions ran, and the client side is built

Two sessions the same day:
[the 10:00 design session](../meetings/2026-08-27%20Integrazione%20WooCommerce.md)
(Elena Spini, Aurel Mrruku, Andrea Di Cicco, Sabatino Rinaldi, Fabrizio
Paganelli, Elisa Migliano) and
[the 16:00 test session](../meetings/2026-08-27%20Test%20Integrazione%20WooCommerce.md)
(Aurel Mrruku and Sabatino Rinaldi only). The return leg — how a WooCommerce
order becomes a Salesforce order — now has its own note:
[the WooCommerce order integration](../flows/The%20WooCommerce%20order%20integration.md).

🟢 **The checkout-link flow was confirmed end to end and approved aloud by Elena
Spini.** Salesforce creates the opportunity → it emits an email with a tracked
link carrying the opportunity id → the customer lands on the WooCommerce cart →
on the order reaching the trigger state the plugin pushes it back to Salesforce
with that id. The same mechanism serves the unknown-customer and known-customer
cases, minus the first leg.

### The five points, re-scored

| Point to agree              | State on 2026-08-27                                                                                                                                                                                |
| --------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Pull vs webhook             | ✅ closed — **neither**: a custom plugin on a PHP order-status action hook                                                                                                                         |
| Price source of truth       | ✅ closed — coupons excluded from phase 1                                                                                                                                                          |
| ID in clear vs signed token | 🔴 **answered by the payload, 28/08: in clear.** No signature, nonce or timestamp anywhere in the body. `INT-16` still recommends a signed token, so register and implementation now disagree      |
| URL parameter name          | 🟢 **answered: `sf_opportunity_id`**, at the top level of the payload and again as `_sf_opportunity_id` in `meta_data`. The record's `sf_opp_id` was only the snippet default and is not what runs |
| ID format                   | 🟢 **answered: the 15-character Salesforce id**, case-sensitive                                                                                                                                    |

⚠ The last three were decided **by the implementation** rather than by the two
sides agreeing. That is the failure mode this table was written to prevent, and
it happened. The payload file settles what the values _are_
([the payload contract](../The%20WooCommerce%20payload%20contract.md), decoded
28/08); it does not settle whether anyone **accepts** them — in particular the
clear-text id, which contradicts `INT-16`.

### What changed in the design

- 🔴 **The mu-plugin is superseded.** `sf-opportunity-tracker.php` from
  `Integrazione_Salesforce_WooCommerce.docx` is not what runs. Sabatino Rinaldi
  wrote his **own WooCommerce plugin, v1.3, permanently active**, and Pienissimo
  owns it. ROMI does not maintain client-side code here.
- 🔴 **The URL anatomy shrinks.** Carts are built with **Funnel Kit**, and the
  funnel URL already contains the product — so no `add-to-cart`, no `quantity`.
  The link Salesforce generates carries the **opportunity id alone**. The
  link-generator button therefore needs no product or quantity pickers, which
  removes work from the INT-13 build list.
- 🟢 **A manual re-send button** exists on the WooCommerce order.
- 🔴 **Credentials were not exchanged**, despite the invitation promising it.
  The blocking credential has reversed direction and is now ROMI's —
  [OI-102](OI-102%20Salesforce%20endpoint%20and%20token%20for%20the%20WooCommerce%20plugin.md).

### Still to do on the Salesforce side

Unchanged from the 25 August org check, and now urgent: the link-generator
button, the pre-filled email template, the inbound endpoint, the Woo-keyed order
type, the `SC` product match, the customer-create path. **None of it exists.**
The one thing that moved is that the client side is real and waiting.

Also open: [OI-101](OI-101%20Stage%20sales%20must%20be%20in%20the%20WooCommerce%20test%20set.md)
(stage sales untested) and
[OI-103](OI-103%20WooCommerce%20and%20Mexal%20field%20overlap.md) (field merge).

## 2026-08-28 - the payload file was opened

Aurel Mrruku downloaded Sabatino Rinaldi's 27/08 attachment and it was decoded
into [the WooCommerce payload contract](../The%20WooCommerce%20payload%20contract.md);
the artifact is preserved at `Payload woo-salesforce.json` in the repository
root. ⚠ It is **one example order**, so it is authoritative on the payload's
_structure_ and not on what any particular field will contain in production.

On structure it closed two of the five points above and answered the third
against the register's recommendation. It also showed that the envelope carries
**no idempotency key and nothing signed** —
[OI-104](OI-104%20The%20WooCommerce%20payload%20has%20no%20idempotency%20key.md).

## 🔴 2026-09-16 - two new open points, and the person who settles them is unreachable

Two sources moved this row on the same day, and they meet in the middle.

### The session

At [Data Model Parte 5](../meetings/2026-09-16%20Data%20Model%20Parte%205.md)
Aurel Mrruku raised a case the spec does not cover: **an offer carrying several
products that are not wrapped in a single bundle.** The URL anatomy supports it —
`?add-to-cart=[IDs]` takes comma-separated ids — but nobody has tested whether
the shop, the mu-plugin and the reconciliation behave when it does.

What the room could establish is that **the links actually sent to event
attendees carry predefined bundle ids** — _bundle 1_, _bundle 2_ — not product
ids composed per offer. So the mechanism in daily use is narrower than the
mechanism in the spec.

That produced the session's one explicit `Da approfondire`: **post-event tutor
sales may be bundles only**, pending Sabatino Rinaldi. And a named action for
Elena Spini and Elisa Migliano: **ask him whether the product id in the
Salesforce-generated link is always the bundle id.**

### The Notebook summary

That evening (18:51–19:04 CEST) Elena Spini pasted into her DM with Aurel Mrruku
a long restatement of the id mechanism, prefaced _"from Notebook"_ — the project
**NotebookLM** notebook linked from the `#tproj-pienissimo` canvas. It attributes
its content to the **Business Review of 31/07** and the **bundle demo of
16/07**, both already sources for this row.

⚠ **It is an AI restatement of meetings this record already holds, not a new
statement by anyone.** Nothing in it is a fresh decision, and no participant
confirmed it. Read as such, three of its points are worth keeping because they
name things this row has never named:

1. **The WooCommerce product id and the SKU are different keys, deliberately.**
   The numeric WooCommerce id (the summary's example: `247`) drives `add-to-cart`;
   amministrazione keeps invoicing on Mexal article codes. The summary attributes
   the reassurance to Sabatino Rinaldi answering **Fabrizio Paganelli's** worry
   about having to realign codes across three systems by hand.
2. **A cron is proposed to sync the WooCommerce catalogue into Salesforce**, so
   every Salesforce product already knows its WooCommerce id and the tutor never
   types one — the "Crea link" button offers a product-name search instead.
   🔴 **Nothing of this exists.** The register's `INT-13` build list names
   "product and opportunity WooCommerce id fields, link generator"; the
   25/08 org check found none of it, and no sweep since has found it either.
   **The cron has no owner, no date and no requirement row of its own.**
3. **Why the opportunity id and not the VAT number or the email** — a customer
   with two open deals would be ambiguous; the opportunity id closes exactly the
   one the recall belongs to.

Elena Spini's own conclusion, 18:58:47 — _"a quanto pare Sabatino aveva
ragione.........però capiamo meglio domani quando ci sentiamo"_ — points at the
**internal meeting of 17/09**, where this is expected to be picked up.

### Where that leaves the five points

| Point to agree                                 | State                                                                                                                                            |
| ---------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------ |
| Pull vs webhook                                | ✅ closed — webhooks                                                                                                                             |
| Price source of truth                          | ✅ closed — coupons excluded from phase 1                                                                                                        |
| ID in clear vs signed token                    | 🔴 open — and now decided _differently_ on the participant page, which took an opaque token on 15/09 while this link still sends the id in clear |
| URL parameter name                             | ✅ closed 28/08 — `sf_opportunity_id`                                                                                                            |
| ID format                                      | ✅ closed 28/08 — the 15-character form                                                                                                          |
| **Is the product id always a bundle id?**      | 🔴 **new, 16/09** — owed by Sabatino Rinaldi                                                                                                     |
| **Multi-product offers with no single bundle** | 🔴 **new, 16/09** — untested, unowned                                                                                                            |

🔴 **Both new points need Sabatino Rinaldi, and he is not answering.** Elisa
Migliano reported him on tour with the client's direction; Elena Spini and Aurel
Mrruku confirmed **no WhatsApp reply the previous week**. The same is true of
[OI-102](OI-102%20Salesforce%20endpoint%20and%20token%20for%20the%20WooCommerce%20plugin.md),
where he has been waiting for a filtered collection since 08/09 — so he is
simultaneously the person owed something and the person owing two answers.

## ⚠ 2026-09-17 - Aurel Mrruku disputed the mechanism before the NotebookLM paste

The 16 September run recorded Elena Spini's NotebookLM restatement (18:51–19:04
CEST) but not what preceded it. **Three messages from Aurel Mrruku at
15:55–15:56 CEST, nearly three hours earlier, are the reason she went and
checked:**

> _"nella call con lui ci siamo detti che viene generato l'opp in SF e viene
> associato il prodotto sulla opp e generato il link. **non mi pare di aver
> parlato di menu a tendina**"_

> _"poi anche sta cosa che è uscito oggi dei boundle noon boundle noon mi torna"_

> _"mai sentito e disegnato un caso del genere"_

So the sequence is: **Aurel Mrruku contests the product-selection mechanism and
the bundle/non-bundle split → Elena Spini queries NotebookLM → pastes the result
→ concludes _"a quanto pare Sabatino aveva ragione"_.**

⚠ **This matters for how the NotebookLM output is weighed.** It is not a
spontaneous restatement; it is an AI summary produced to settle a disagreement
between two people who were both in the meetings, and **the participant who
disputed it has not agreed with it**. It remains an AI summary of records this
repository already holds, and the searchable-dropdown detail is contradicted by
a named participant.

🔑 **The venue is today.** Elena Spini's _"capiamo meglio domani quando ci
sentiamo"_ points at `[PIENISSIMO] - Follow-up Interno`, **17/09 14:15–15:15
CEST**, organiser Elena Spini, with Aurel Mrruku and Federico Mastracci invited.
⚠ **Andrea Di Cicco has declined it** — see
[OI-139](OI-139%20Andrea%20Di%20Cicco%20is%20winding%20down%20with%20four%20integration%20questions%20unanswered.md).
It was moved from 14/09 to today on 16/09 at 16:05Z. **If it produces notes or a
recording, drill it** — it is the first movement on this row's two open points.

## 🔑 2026-09-17 (nightly) - the 31/07 spec was edited this morning and still documents the superseded mechanism

`Integrazione_Salesforce_WooCommerce.docx` (`1LYXxqKldoJeLRdjbZdfurZaRFxf2hsIC`,
owner `sabatinopienissimo@gmail.com`) carries `modifiedTime`
**2026-09-17T07:40:42Z**. **No trace note before this one records the change**,
although that timestamp falls inside the window the 11:00Z run swept — so it was
either missed or mis-triaged there.

**Read in full on the nightly run. Nothing in it was answered.**

- Its closing section still lists the **same five points to agree**, none of them
  resolved: URL parameter name, ID format, price handling, integration
  direction, and ID in clear versus signed token.
- It still specifies the **mu-plugin** `sf-opportunity-tracker.php` **v1.0.0** —
  superseded on 27/08 by Sabatino Rinaldi's own plugin (v1.3, always active).
- It still specifies the **long URL**,
  `?add-to-cart=247,312,485&quantity[485]=2&coupon=…&sf_opp_id=…` — superseded on
  27/08, when the link shrank to **the opportunity id alone** because the Funnel
  Kit carts already carry the product.
- **Neither of the two answers owed by Sabatino Rinaldi since 16/09 is in it:**
  whether the product id in the Salesforce-generated link is always a bundle id,
  and what becomes of multi-product offers not wrapped in a single bundle.

⚠ **The document is not an answer to those two questions — it is a record of the
design the build moved away from.** Its _Esempio 2_ is precisely a multi-product
offer, three product ids concatenated with commas plus a per-id quantity, which
is the mechanism the 27/08 session replaced.

⚠ **One visible corruption.** The sample REST response now reads
`"line_items": [ciao` — a stray word inside the JSON array of a code sample. It
**cannot be dated from this repository**: no note quotes that block verbatim.
Drive returns the file's `owner` but **no last-modifying user**, so **who made
this morning's edit is unknown and is not inferred here.**

🔑 **This is the `DGM-2` defect a second time.** The document is cited as a source
in [REQUIREMENTS.md](../../REQUIREMENTS.md), in
[REQUISITI.it.md](../../REQUISITI.it.md) and at the head of this note, and it
documents a mechanism the build superseded three weeks ago. Unlike the diagram,
**this file is still being touched** — so it is live rather than abandoned, and a
reader who follows the citation is handed the retired design.

## 🔑 2026-09-17 (evening) - the link generator was built, and it is the design the 27/08 session replaced

`af8a42b` (Anita Aga, 16:50:57 CEST, `DevAnita`), merged to `DevMain` in **PR
#47** at **15:01:32Z** as `d779109`. It adds the `Genera_Link` quick action on
the Opportunity, the `wooGenerateLink` LWC, an `Opportunity.Checkout_Link__c`
URL field, and rewrites the `WooCommerce_Checkout_Link` email template and its
controller. **This is the link-generator button that had been outstanding since
the 25 August org check.**

### What it emits

```
https://www.pienissimo.it/checkout?add-to-cart=<woo product id>&sf_opportunity_id=<15/18-char Opportunity id>
```

🔴 **That is the pre-27/08 URL anatomy.** The 27/08 design session recorded, in
this note's own words, that carts are built with **Funnel Kit**, the funnel URL
already contains the product, so there is **no `add-to-cart`, no `quantity`**,
and _"the link Salesforce generates carries the opportunity id alone"_ — with
the explicit consequence that _"the link-generator button therefore needs no
product or quantity pickers"_. The built button does carry `add-to-cart`, and
its only input **is** a product picker.

🔴 **And the tutor types the WooCommerce product id by hand.** `wooGenerateLink`
renders a single free-text `lightning-input` bound to `productWooCommerceId`;
there is no catalogue lookup, no `Product2` query, no dropdown. That is the
opposite of what the record holds on both sides:

- Sabatino Rinaldi and Aurel Mrruku, 31/07 and 16/07, as restated by Elena Spini
  on 16/09: _"il tutor non dovrà mai conoscere o digitare a memoria gli ID
  numerici di WooCommerce… gli apparirà una finestra con un menù a tendina a
  ricerca guidata per nome prodotto"_;
- the same source's proposed **cron to sync the WooCommerce catalogue into
  Salesforce** so every Salesforce product already knows its Woo id. That cron
  does not exist, has no owner and no date — and this build is what depends on it.

⚠ **Aurel Mrruku disputed the searchable-dropdown detail on 16/09** (§ above),
so the record already carried a contradiction there. What is new is that **the
build has now taken a side**, and it took the manual-entry side without anyone
recording a decision.

### On the two questions Sabatino Rinaldi owes

- **Is the product id in the link always a bundle id?** The build emits exactly
  **one** `add-to-cart` value, so it behaves as if the answer were yes — but it
  does not enforce it, and nothing validates that the typed id is a bundle.
- **What happens to multi-product offers not wrapped in one bundle?** The build
  has **no answer**: one id, one field, no concatenation. The related constraint
  landed in the same commit —
  [OI-140](OI-140%20Three%20Opportunity%20record%20types.md)'s
  `QuoteLineItemTriggerHandler` refuses a quote that mixes a Bundle with Item
  products. **So the question is being closed by implementation rather than by
  the person who owns it**, which is the failure mode the five-point table in
  this note exists to prevent — for the second time.

### Not verified

The base URL `https://www.pienissimo.it/checkout` is hardcoded in the LWC. **No
swept source states that this is the Funnel Kit checkout path**, and the 27/08
session said the funnel URL carries the product. Whether the built link resolves
to anything on the client's site is **unknown and was not tested** — the org was
not opened tonight.
