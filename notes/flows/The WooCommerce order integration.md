---
id: flow-woocommerce
type: flow
status: in-progress
owner: Aurel Mrruku
with: Sabatino Rinaldi
org: both
updated: 2026-08-27
depends_on: [OI-49, OI-102]
requirement: INT-14
source: meetings/2026-08-27-test-integrazione-woocommerce-transcript.it.md
---

# The WooCommerce order integration

How a WooCommerce order becomes a Salesforce order. Settled across the two
sessions of **27 August 2026**:
[the 10:00 design session](../meetings/2026-08-27%20Integrazione%20WooCommerce.md)
and
[the 16:00 test session](../meetings/2026-08-27%20Test%20Integrazione%20WooCommerce.md).

The **checkout-link** half of the story — how the opportunity id gets *into* the
cart — is [OI-49](../items/OI-49%20WooCommerce%20checkout-link%20flow.md). This
note is the return leg.

## Direction

🟢 **WooCommerce pushes. Salesforce does not poll.** Outbound from WooCommerce,
inbound to Salesforce. Aurel Mrruku, 27/08: _"è una comunicazione outbound lato
vostro, inbound lato sales force"_.

This closes `INT-14`, open since the requirements went out, and it closes it
more specifically than the standing recommendation of "webhook":

| Option | Outcome |
| ------ | ------- |
| Salesforce scheduled pull | ❌ rejected — Salesforce has no order to poll for |
| Stock WooCommerce webhook | ❌ **evaluated live 27/08 and rejected** — one topic per webhook, no multi-select, no control of the body; would push every order in every state and cannot carry the customer structure |
| **Custom plugin, PHP action hook on order status transition** | ✅ **agreed and built** |

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

One JSON body carrying three sub-structures — **order**, **customer**, **order
lines**. Aurel Mrruku maps them to Salesforce wrappers.

Observed on screen 27/08 (an observation of the demo, not a schema):

- **Order** — WooCommerce order key, status/event, totals, traffic/tracking
  source.
- **Customer** — nome, ragione sociale, partita IVA. Carried **twice**, once
  WooCommerce-native and once in the Funnel Kit shape; kept as-is by agreement,
  ROMI reads the WooCommerce-native copy.
- **Line** — **`SC` product code**, product name, quantity, subtotal, total.

The authoritative copy is the text file Sabatino Rinaldi mailed to Aurel Mrruku
at **2026-08-27 14:20Z** (subject _"Integrazione woo commerce - salesforce"_, cc
Andrea Di Cicco and Elena Spini, attachment `Payload woo-salesforce`).
⚠ **No connected tool can read a Gmail attachment**, so the field list above is
what the record holds until someone downloads it.

## The Salesforce side — stated, not built

- A **distinct order type keyed on the WooCommerce order key**, so a
  Woo-originated order is identifiable.
- **Product match on the `SC` code** — the same article code as
  [the article code namespace](../objects/The%20article%20code%20namespace.md), and
  therefore exposed to
  [OI-98](../items/OI-98%20The%20Mexal%20article%20registry%20is%20being%20re-created.md).
- **Create the customer** when the payload's customer is not found. Scenario 1
  of the three the client stated.
- **No P.IVA check on arrival.** Validation stays on the Salesforce → Mexal leg
  — see [OI-73](../items/OI-73%20VAT%20validation%20moves%20into%20Salesforce.md)
  for why that needs confirming with Elisa Migliano and Elena Spini.

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
- **Whether the opportunity id travels signed** (`INT-16`). The delivered plugin
  appears to pass it in clear — the demo URL carried a literal opportunity
  value — but this was not stated aloud, so treat it as **uncertain** and decide
  it explicitly.
- **Field overlap with Mexal** —
  [OI-103](../items/OI-103%20WooCommerce%20and%20Mexal%20field%20overlap.md).
- **Stage sales are untested** —
  [OI-101](../items/OI-101%20Stage%20sales%20must%20be%20in%20the%20WooCommerce%20test%20set.md).
