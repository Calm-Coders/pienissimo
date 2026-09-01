---
id: risk-woo-endpoint-orphan
type: risk
status: open
severity: high
owner: Aurel Mrruku
org: ROMI
raised: 2026-08-31
updated: 2026-08-31
depends_on: [OI-102]
blocks: [OI-49]
requirement: [INT-14, INT-16]
source: org-status-check 2026-08-31 09:36-09:52Z
---

# Risk - a clean deploy would orphan the live WooCommerce endpoint

**Two different Apex classes claim the same REST route, and only one of them is
in source control — the other is the one actually taking live traffic.**

Found by the `org-status-check` of **2026-08-31, 09:36–09:52Z**:

| | In `force-app/` | In the org |
| --- | --- | --- |
| Class | `WooCommerceOrderEndpoint` | `WoocommerceOrderService` |
| Size | 16,789 chars | 23,087 chars |
| `urlMapping` | `/woocommerce/orders/*` | `/woocommerce/orders/*` |
| Deployed | **no** | **yes, and modified 31 August** |
| Versioned | yes | **no** |

**A `sf project deploy start` from this repository would publish a second class
on a route that already has one**, and orphan the class that is currently
serving the WooCommerce plugin. Salesforce resolves a duplicated `urlMapping`
non-deterministically, so the failure would not necessarily be loud — it would
be a live integration quietly answering from the wrong implementation.

## Why this is not a theoretical drift

The org class is **live and being exercised**. The same run counted **16 inbound
integration log rows** (13×200, 1×409 historical, 2×500) and **7 Orders**
carrying a WooCommerce key — up from 5 logs and 2 orders on 28 August. The
integration tests Pienissimo scheduled for the week of 31 August run against
this class, not against the repository's.

The org copy was **modified on 31 August**, so it is under active development in
the org, unversioned, while the repository's copy is stale and unshipped.

## 🔴 This is the same failure that just destroyed the Biglietto stack

Three days ago the Biglietto Apex was in exactly this position: deployed, working,
never committed. On 28 August a destructive deploy removed it and **it is gone**,
because no copy existed anywhere else —
[the record of that](Risk%20-%20the%20Biglietto%20Apex%20stack%20is%20not%20in%20source%20control.md).
`WoocommerceOrderService` is now the most valuable unversioned artifact on the
project and it is on the critical path to a 6 October go-live.

## The fix, in order

1. **Retrieve `WoocommerceOrderService` into `force-app/` and commit it today.**
   That is a command, not a decision, and it removes the loss risk entirely.
2. **Then** decide which class is the real one. Two implementations of one
   endpoint is a fork, and the repository's copy is 6,300 characters shorter —
   somebody rewrote it in the org and the repository never heard.
3. Delete the loser, or retire its `urlMapping`, before any deploy from
   `force-app/` reaches this org.

Until step 1 is done, **nobody should deploy Apex to Pienissimo UAT from this
repository.**

Related: [the WooCommerce order integration](../flows/The%20WooCommerce%20order%20integration.md),
[OI-102](../items/OI-102%20Salesforce%20endpoint%20and%20token%20for%20the%20WooCommerce%20plugin.md),
[OI-104](../items/OI-104%20The%20WooCommerce%20payload%20has%20no%20idempotency%20key.md),
[the build ahead of the record](../objects/The%20build%20ahead%20of%20the%20record.md).
