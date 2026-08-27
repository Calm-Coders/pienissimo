---
id: OI-49
type: open-item
status: in-progress
owner: Aurel Mrruku
with: Sabatino Rinaldi
org: both
raised: 2026-07-31
updated: 2026-08-27
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

| Point to agree              | State on 2026-08-27                                                          |
| --------------------------- | ---------------------------------------------------------------------------- |
| Pull vs webhook             | ✅ closed — **neither**: a custom plugin on a PHP order-status action hook    |
| Price source of truth       | ✅ closed — coupons excluded from phase 1                                     |
| ID in clear vs signed token | 🔴 **still open, and drifting** — the delivered plugin appears to pass it in clear; nobody said so aloud. `INT-16` still recommends a signed token |
| URL parameter name          | 🔴 open in the record — **fixed in practice** by the delivered plugin; the value is in the payload file nobody has opened |
| ID format                   | 🔴 same                                                                       |

⚠ The last three are now being decided **by the implementation** rather than by
the two sides agreeing. That is the failure mode this table was written to
prevent.

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
