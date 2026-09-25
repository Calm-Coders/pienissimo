---
id: OI-171
type: open-item
status: open
owner: unassigned
org: ROMI
raised: 2026-09-23
updated: 2026-09-23
depends_on: [OI-144, OI-145]
blocks: [OI-170]
source: org-status-check against Pienissimo UAT, 2026-09-23 08:01-08:40Z
evidence: Tooling ApexClass.Body and LightningComponentResource.Source compared against every commit on every remote branch; no match
---

# OI-171 - A bundle discount was deployed to UAT from no commit

**At 07:59–08:00 UTC on 23/09**, about fifteen minutes before this check read the org,
`QuoteManageProductsController` and all three source files of the
`quoteManageProducts` LWC were changed in Pienissimo UAT. **The org content matches
no commit on any remote branch**, including `DevMain` at `61f2a53`. The four branches
pushed on 22–23/09 do not contain it either.

## What the org has that git does not

A **bundle-only discount and manual price** in the quote's Manage Products
component:

- the selection carries `discount` (percentage) and `manualPrice`;
- either one is accepted, **never both**, and **only for a bundle**. Single
  articles are rejected with _"Sconto e prezzo manuale sono disponibili solo per i
  bundle."_;
- the discount must be 0–100 with at most two decimals. The manual price must be
  non-negative;
- a manual price replaces the unit price. A discount keeps the list price and
  writes the standard `QuoteLineItem.Discount`;
- the component displays the list price.

Size: the controller is **911 lines in the org and 865 in git**. The LWC is 372
lines of HTML against 327, and 680 lines of JS against 651.

## Who

The change was made by the **`ROMI COMPANY`** user, a System Administrator account
that does not match any named person in the record. **The org evidence cannot tell
who made it.** (inferred) It was probably a developer deploying local work before
committing it.

## Whether it was requested

⚠ **Not established.** It may implement part of
[OI-144](OI-144%20Bundles%20must%20be%20split%20into%20order%20lines%20for%20Mexal.md)
(a manual override on the bundle spread) or follow from
[OI-145](OI-145%20Order%20header%20discounts%20are%20removed.md) (header discounts
removed). Neither note describes a percentage discount on the bundle line. Check
this against the source before calling it agreed or unrequested.

## Why it matters

- 🔴 **Any deploy of `DevMain` to UAT overwrites it.** That includes the deploy
  [OI-170](OI-170%20DevMain%20is%20ahead%20of%20UAT%20on%20the%20Lead%20conversion%20and%20quote-line%20paths.md)
  needs before Lead UAT. The two items must be handled **in order: commit this,
  then deploy.**
- ⚠ Quote UAT is **25/09**, and Manage Products is part of that session.
- ⚠ This is the **fifth time** work has been found in the org and missing from source
  control. The earlier cases were the Biglietto stack, WooCommerce, the credentials
  and the Mexal chain. The last of those was resolved on 14–15/09.

## Open

- 🔴 **The author commits and pushes it**, on a branch with a PR, before anyone
  deploys `DevMain` to UAT.
- ⚠ Record whether the bundle discount was requested, and by whom.
