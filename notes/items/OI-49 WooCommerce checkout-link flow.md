---
id: OI-49
type: open-item
status: in-progress
owner: Aurel Mrruku
with: Sabatino Rinaldi
org: both
raised: 2026-07-31
updated: 2026-08-25
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
