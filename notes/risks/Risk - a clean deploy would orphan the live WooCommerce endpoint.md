---
id: risk-woo-endpoint-orphan
type: risk
status: resolved
severity: high
owner: Aurel Mrruku
org: ROMI
raised: 2026-08-31
updated: 2026-09-02
depends_on: [OI-102]
blocks: [OI-49]
requirement: [INT-14, INT-16]
source: org-status-check 2026-08-31 09:36-09:52Z
resolved_by: org-status-check 2026-09-02 08:05-08:14Z
---

# Risk - a clean deploy would orphan the live WooCommerce endpoint

> ✅ **Resolved 2026-09-02.** Both halves of the collision are gone: the
> unversioned class is now committed and byte-identical to the deployed one,
> and the duplicate has been removed. Read
> [the resolution](#2026-09-02---resolved) before acting on anything below.
> The 31 August account is kept intact.

**Two different Apex classes claim the same REST route, and only one of them is
in source control — the other is the one actually taking live traffic.**

Found by the `org-status-check` of **2026-08-31, 09:36–09:52Z**:

|              | In `force-app/`            | In the org                      |
| ------------ | -------------------------- | ------------------------------- |
| Class        | `WooCommerceOrderEndpoint` | `WoocommerceOrderService`       |
| Size         | 16,789 chars               | 23,087 chars                    |
| `urlMapping` | `/woocommerce/orders/*`    | `/woocommerce/orders/*`         |
| Deployed     | **no**                     | **yes, and modified 31 August** |
| Versioned    | yes                        | **no**                          |

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

## 2026-09-02 - Resolved

**The route collision no longer exists.** Verified against Pienissimo UAT on
2026-09-02, 08:05-08:14Z:

|                                          | 2026-08-31                  | 2026-09-02                  |
| ---------------------------------------- | --------------------------- | --------------------------- |
| `WooCommerceOrderEndpoint`               | in `force-app/`, undeployed | **removed from both sides** |
| `WoocommerceOrderService`                | deployed, unversioned       | **deployed AND committed**  |
| `@RestResource` mappings in `force-app/` | 2 classes, 1 route          | **1 class, 1 route**        |

The fix landed in `158c2d0` (31 Aug, Anita Aga). The deployed class body was
read back through the Tooling API and compared to
`force-app/main/default/classes/WoocommerceOrderService.cls`: after normalising
line endings the two are **identical**. The raw sizes differ by 848 characters,
which is exactly the CRLF-versus-LF difference across the file's ~848 lines —
not a content difference.

So a clean deploy now publishes the class that is already running, on the route
it is already serving. Nothing is orphaned.

### What this does not resolve

The class is safe from the _deploy_; it is not otherwise finished.
**`INT-16` is still unauthenticated** — the endpoint remains `global without
sharing` with no token or signature check, so the header token ROMI owes under
[OI-102](../items/OI-102%20Salesforce%20endpoint%20and%20token%20for%20the%20WooCommerce%20plugin.md)
is still the entire authentication. That is a separate open item and this
resolution says nothing about it.
