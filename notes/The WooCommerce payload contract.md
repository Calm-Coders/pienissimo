---
id: REF-woo-payload
type: reference
status: open
owner: Aurel Mrruku
with: Sabatino Rinaldi
org: both
raised: 2026-08-27
updated: 2026-08-28
depends_on: [OI-102]
blocks: [OI-104]
requirement: [INT-11, INT-14, INT-16, ORD-12]
source: Payload woo-salesforce.json
---

# The WooCommerce payload contract

The decode of the JSON body Sabatino Rinaldi's plugin posts to Salesforce. It is
the return leg of
[the WooCommerce order integration](flows/The%20WooCommerce%20order%20integration.md);
the outbound half is
[OI-49](items/OI-49%20WooCommerce%20checkout-link%20flow.md).

**Provenance.** Mailed by Sabatino Rinaldi to Aurel Mrruku on
**2026-08-27 at 14:20:18Z**, subject _"Integrazione woo commerce - salesforce"_,
cc Andrea Di Cicco and Elena Spini, body _"Ecco il payload:"_. The attachment was
extensionless; preserved in the repository root as
`Payload woo-salesforce.json`, verified identical to the mailed original.
**Downloaded and decoded 2026-08-28** — until then the record held only what was
observed on screen during the 27 August test session.

## How to read it

⚠ **This is one example order, and Sabatino Rinaldi has said so.** It is
authoritative on the **structure** of the body — which keys exist, how they nest,
what type each holds — and on nothing else.

**Do not draw conclusions from its values.** The sample is a €50 test product
bought through a test funnel, so an empty field in it means only that this
particular order had nothing there. Which fields a production order populates,
what a real article code looks like, how VAT appears on a taxable order and what
a bundle line contains are all **unanswered**, and none of them should be raised
as findings against the sample. Ask Sabatino Rinaldi instead.

⚠ It also carries one real person's contact and address data, entered by
Sabatino Rinaldi himself. **Never copy a value out of it** into `notes/`, the
recaps, `STATUS.md` or [site/](../site/) — the same rule that governs
[the Mexal mapping workbook](The%20Mexal%20integration%20mapping%20workbook.md).
This note describes fields only.

## Shape

One JSON object, 14 top-level keys.

| Key                                                              | Type   | Carries                                                                                            |
| ---------------------------------------------------------------- | ------ | -------------------------------------------------------------------------------------------------- |
| `event`                                                          | string | the trigger name — the order-status transition that fired                                          |
| `sf_opportunity_id`                                              | string | **the Salesforce Opportunity id, at top level**                                                    |
| `order`                                                          | object | id, number, order key, status, currency, `prices_include_tax`, `created_via`, four lifecycle dates |
| `totals`                                                         | object | subtotal, discounts, shipping, tax, total, total refunded                                          |
| `payment`                                                        | object | method code, method title, transaction id                                                          |
| `customer`                                                       | object | WooCommerce customer id, guest flag, IP, user agent, customer note                                 |
| `billing`                                                        | object | name, company, email, phone, full address, ISO country                                             |
| `shipping`                                                       | object | the same minus email                                                                               |
| `fiscal`                                                         | object | company name, venue name, VAT number, tax code, SDI code, PEC                                      |
| `profile`                                                        | object | business type, marketing consent, terms accepted                                                   |
| `funnel`                                                         | object | source URL, checkout page id, funnel id                                                            |
| `tracking`                                                       | object | five UTM fields, referrer, first landing URL, first click, device, browser                         |
| `line_items`                                                     | array  | one object per ordered line                                                                        |
| `shipping_lines`, `coupons`, `tax_lines`, `fee_lines`, `refunds` | arrays | the standard WooCommerce collections                                                               |
| `meta_data`                                                      | array  | raw WordPress meta rows, `{key, value}`                                                            |

### The line

`item_id`, `product_id`, `variation_id`, `sku`, `name`, `quantity`, `subtotal`,
`subtotal_tax`, `total`, `total_tax`, `tax_class`, `meta`.

`product_id` is the WordPress post id. **`sku` is where an article code would
arrive** — the field the agreed `SC`-code product match needs. Confirm with
Sabatino Rinaldi that the real catalogue populates it, and with what.

### The customer blocks

`customer`, `billing`, `shipping`, `fiscal` and `profile` are the plugin's
normalised structures; `meta_data` carries the same information again as the raw
Italian checkout-form rows. **Read the structured blocks and ignore the
`meta_data` rows** — they are un-normalised and will move whenever the checkout
form is edited.

## What it settles

Three points that
[OI-49](items/OI-49%20WooCommerce%20checkout-link%20flow.md) has carried as open
since 31 July. All three are structural, so the sample does answer them:

| Point                  | Answer from the payload                                                                                                                                                 |
| ---------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Parameter name**     | `sf_opportunity_id` at the top level, and `_sf_opportunity_id` again inside `meta_data`. The record's `sf_opp_id` was only the snippet default and is **not** what runs |
| **Id format**          | the **15-character** Salesforce id, not the 18-character form. Case-sensitive — do not upper-case it before matching                                                    |
| **In clear or signed** | 🔴 **in clear.** There is no signature, HMAC, nonce or send timestamp field anywhere in the envelope. `INT-16`'s `signed_token` recommendation is dead in practice      |

⚠ All three were decided **by the implementation**, not by the two sides
agreeing — the failure mode OI-49's table was written to prevent. They are
recorded here as observed fact; someone still has to accept them aloud.

It also confirms, from the wire rather than from the demo:

- 🟢 The `event` key and the order status field carry the trigger, matching
  `ORD-12` as corrected on 27 August.
- 🟢 **Funnel Kit is the cart**, as OI-49 records: the `funnel` block carries a
  funnel id and a checkout page id.
- 🟢 The payment block carries the WooCommerce method code, so the bank-transfer
  path `ORD-12` describes is distinguishable at the endpoint.

## Implementation hazards

Structural, and each one costs a debugging session if it is met at runtime
instead of read here:

1. 🔴 **`meta_data[].value` is heterogeneous** — string, object **and** array all
   appear as the `value` of different rows. A typed Apex wrapper on `meta_data`
   throws. Deserialize untyped, or skip the array entirely, which is the
   recommendation anyway.
2. 🔴 **`tracking.first_click` is not ISO 8601** — unpadded and with no timezone,
   while every `order` date is ISO 8601 with an offset. `Datetime.valueOf()`
   fails on it. Parse it defensively or drop it.
3. **Every monetary value is a string, and the decimal formatting is not
   consistent between the `totals` block and the line block.** Parse with
   `Decimal.valueOf`; never assume the decimal places.
4. **`order.id` is a number, `order.number` is a string.** They are not the same
   field — key on `order.id` or `order_key`, never on `number`.
5. **Lifecycle dates are nullable** — `date_completed` is null on a
   not-yet-completed order. Null-check every date.
6. **The plugin's empty is an empty string, not null**, throughout. Use
   `String.isBlank`, not `!= null`.
7. **`variation_id` is 0 when there is no variation**, not null.

## What the envelope does not carry

Structural absences, not empty values:

- 🔴 **No idempotency key, no signature, no send timestamp** — beside a plugin
  that has a manual re-send button.
  [OI-104](items/OI-104%20The%20WooCommerce%20payload%20has%20no%20idempotency%20key.md).
- **No shop identifier.** `INT-11` records **two** WooCommerce instances; no
  top-level key says which one sent the body. If the second is ever wired up, the
  endpoint cannot tell them apart.
- **No refund behaviour on the Salesforce side.** `refunds` and
  `totals.total_refunded` are in the contract and nobody has said what Salesforce
  does when they are non-empty — which touches asset reversal, and therefore
  [OI-92](items/OI-92%20Mexal%20Scadenziario%20as%20the%20trigger%20to%20reverse%20an%20asset.md),
  the item with no forum.

## Still to confirm with Sabatino Rinaldi

The sample cannot answer these; one reply from him can:

1. **The full set of `event` values.** The endpoint must switch on the exact
   strings, and `ORD-12` says two states fire.
2. **Whether `sku` is populated on the real catalogue, and with what** — the
   article code, or a shop-local code. The product match depends on it.
3. **Whether a bundle arrives as one line or as several**, and whether
   `line_items[].meta` carries the components —
   [a bundle is two levels deep](objects/A%20bundle%20is%20two%20levels%20deep.md).
4. **How a taxable order looks** — `tax_lines`, `total_tax` and the
   `prices_include_tax` flag together.
5. **Whether the re-send button re-posts the identical body**, `event` included.
6. **Whether `refunds` is ever populated**, or refunds are handled only in Mexal.
