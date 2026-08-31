---
id: flow-woocommerce
type: flow
status: in-progress
owner: Aurel Mrruku
with: Sabatino Rinaldi
org: both
updated: 2026-08-28
depends_on: [OI-49, OI-102, OI-104]
requirement: INT-14
source: meetings/2026-08-27-test-integrazione-woocommerce-transcript.it.md
---

# The WooCommerce order integration

How a WooCommerce order becomes a Salesforce order. Settled across the two
sessions of **27 August 2026**:
[the 10:00 design session](../meetings/2026-08-27%20Integrazione%20WooCommerce.md)
and
[the 16:00 test session](../meetings/2026-08-27%20Test%20Integrazione%20WooCommerce.md).

The **checkout-link** half of the story — how the opportunity id gets _into_ the
cart — is [OI-49](../items/OI-49%20WooCommerce%20checkout-link%20flow.md). This
note is the return leg.

## Direction

🟢 **WooCommerce pushes. Salesforce does not poll.** Outbound from WooCommerce,
inbound to Salesforce. Aurel Mrruku, 27/08: _"è una comunicazione outbound lato
vostro, inbound lato sales force"_.

This closes `INT-14`, open since the requirements went out, and it closes it
more specifically than the standing recommendation of "webhook":

| Option                                                        | Outcome                                                                                                                                                                                  |
| ------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Salesforce scheduled pull                                     | ❌ rejected — Salesforce has no order to poll for                                                                                                                                        |
| Stock WooCommerce webhook                                     | ❌ **evaluated live 27/08 and rejected** — one topic per webhook, no multi-select, no control of the body; would push every order in every state and cannot carry the customer structure |
| **Custom plugin, PHP action hook on order status transition** | ✅ **agreed and built**                                                                                                                                                                  |

## The trigger

**Order status becomes `in lavorazione` (processing) or `completato`
(completed).** Any payment method — bank transfer, card, PayPal — verified live
on 27/08.

🔴 **This reverses `ORD-12`.** The register and the design diagram carry _"a
WooCommerce order is not visible in Salesforce until its WooCommerce status is
COMPLETATO"_, sourced from DGM-2 and never confirmed. The built plugin fires on
**processing as well**. Later evidence wins: the rule is now
**processing OR completed**. Both dates cited in the register entry.

Consequence: **every order line arrives paid.** WooCommerce only ever holds paid
orders in those two states, so there is no line-level payment status in the
payload and none is needed.

## The client-side component

A **WooCommerce/WordPress plugin written and owned by Sabatino Rinaldi**,
at **version 1.3** as of 27/08, permanently active on the Pienissimo shop.

⚠ **This supersedes the mu-plugin `sf-opportunity-tracker.php`** described in
`Integrazione_Salesforce_WooCommerce.docx` and still named in `INT-13`. ROMI
does not write or maintain the client-side code. What ROMI owes instead is the
endpoint and the token —
[OI-102](../items/OI-102%20Salesforce%20endpoint%20and%20token%20for%20the%20WooCommerce%20plugin.md).

It also carries a **manual re-send button** on the WooCommerce order, so a
corrected order can be pushed again without a state change. That is the
WooCommerce twin of the Mexal _"rinvio ordine"_ button in
[the Mexal integration](The%20Mexal%20integration.md).

**Carts are built with Funnel Kit.** The checkout URL is a funnel URL that
already contains the product, so the link Salesforce generates carries the
**opportunity id only** — no product id, no quantity parameters. This narrows
the URL anatomy recorded in
[OI-49](../items/OI-49%20WooCommerce%20checkout-link%20flow.md).

## The payload

🟢 **The payload file was downloaded and decoded on 2026-08-28.** The full field
list and the parsing hazards are in
[the WooCommerce payload contract](../The%20WooCommerce%20payload%20contract.md);
the artifact is preserved in the repository root as `Payload woo-salesforce.json`,
verified identical to the copy Sabatino Rinaldi mailed to Aurel Mrruku on
**2026-08-27 at 14:20:18Z** (subject _"Integrazione woo commerce - salesforce"_,
cc Andrea Di Cicco and Elena Spini).

⚠ **It is one example order.** It is authoritative on the **structure** of the
body — the keys, their nesting and their types — and on nothing else. Which
fields a production order actually populates is not settled by it.

One JSON object with **14 top-level keys**. The three sub-structures observed on
screen on 27 August are all there, and the shape is wider than the demo suggested:

- **`sf_opportunity_id` sits at the top level** of the body, and again inside
  `meta_data` as `_sf_opportunity_id`. It is the **15-character** Salesforce id.
- **Order** — `order` (id, number, order key, status, currency, dates),
  `totals`, `payment`, plus an `event` name identifying the trigger.
- **Customer** — `customer`, `billing`, `shipping`, `fiscal` (company, venue,
  VAT, tax code, SDI, PEC) and `profile`. ROMI reads these structured blocks; the
  `meta_data` array carries the same information again as raw WordPress form rows
  and should be ignored, because it is un-normalised and moves whenever the
  checkout form is edited.
- **Line** — `item_id`, `product_id`, `variation_id`, `sku`, `name`, `quantity`
  and the money fields. `sku` is the natural place for the article code the
  product match needs.
- Also in the contract: `funnel`, `tracking`, `shipping_lines`, `coupons`,
  `tax_lines`, `fee_lines`, `refunds`.

🔴 **The envelope carries no idempotency key, no signature and no send
timestamp** — next to a plugin that has a manual re-send button and a trigger
that fires on two states
([OI-104](../items/OI-104%20The%20WooCommerce%20payload%20has%20no%20idempotency%20key.md)).

## The Salesforce side — stated, not built

- A **distinct order type keyed on the WooCommerce order key**, so a
  Woo-originated order is identifiable.
- **Product match on the `SC` code** — the same article code as
  [the article code namespace](../objects/The%20article%20code%20namespace.md), and
  therefore exposed to
  [OI-98](../items/OI-98%20The%20Mexal%20article%20registry%20is%20being%20re-created.md).
  The payload's `sku` on the order line is where it would arrive; confirm with
  Sabatino Rinaldi that the real catalogue populates it.
- **Create the customer** when the payload's customer is not found. Scenario 1
  of the three the client stated.
- **No P.IVA check on arrival.** Validation stays on the Salesforce → Mexal leg
  — see [OI-73](../items/OI-73%20VAT%20validation%20moves%20into%20Salesforce.md)
  for why that needs confirming with Elisa Migliano and Elena Spini.
- **Idempotent on the WooCommerce order key**, because the plugin can re-send and
  the trigger fires on two states —
  [OI-104](../items/OI-104%20The%20WooCommerce%20payload%20has%20no%20idempotency%20key.md).
  Not stated in either session; it follows from the envelope having no dedupe
  field of its own.

**Nothing of this exists in the org.** As of the 2026-08-26 org check there is
no Flow, no named credential and no `Integration_Configuration__c` row for
WooCommerce, and `Product2.WooCommerce_Product_Id__c` is populated on 0 of 280
products —
[the integration scaffolding has never been configured](../objects/The%20integration%20scaffolding%20has%20never%20been%20configured.md).

## Still open

- **Does Salesforce ever call WooCommerce?** The original spec had Salesforce
  reading the order back over `GET /wp-json/wc/v3/orders/{id}`. With the plugin
  pushing a complete payload that read-back may be unnecessary — but nobody said
  so, and `INT-11` still carries _"CK/CS credentials owed"_. **Unresolved, and
  it decides whether the WooCommerce credentials are still needed at all.**
- **Two WooCommerce instances.** `INT-11` records two; both sessions dealt with
  one shop. Never revisited.
- **Whether the opportunity id travels signed** (`INT-16`). 🔴 **No longer
  uncertain: it does not.** The decoded payload carries the 15-character
  opportunity id in clear, with no signature, nonce or timestamp anywhere in the
  body. `INT-16` still recommends a signed token, so the register and the
  implementation now disagree. The **header token is the whole authentication** —
  decide and record whether that is accepted for phase 1
  ([OI-104](../items/OI-104%20The%20WooCommerce%20payload%20has%20no%20idempotency%20key.md)).
- **Field overlap with Mexal** —
  [OI-103](../items/OI-103%20WooCommerce%20and%20Mexal%20field%20overlap.md).
- **Stage sales are untested** —
  [OI-101](../items/OI-101%20Stage%20sales%20must%20be%20in%20the%20WooCommerce%20test%20set.md).
- **What Salesforce does with a refund.** `refunds` and `totals.total_refunded`
  are in the contract; no behaviour has ever been specified, and a refund
  plausibly has to reverse an asset — which is
  [OI-92](../items/OI-92%20Mexal%20Scadenziario%20as%20the%20trigger%20to%20reverse%20an%20asset.md),
  the item with no forum.
