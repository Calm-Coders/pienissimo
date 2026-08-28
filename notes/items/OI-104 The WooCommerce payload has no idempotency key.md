---
id: OI-104
type: open-item
status: open
owner: Aurel Mrruku
with: Sabatino Rinaldi
org: both
raised: 2026-08-28
updated: 2026-08-28
depends_on: [OI-102]
blocks: [OI-49]
requirement: [INT-11, INT-14, INT-16]
source: Payload woo-salesforce.json
---

# OI-104 - The WooCommerce payload has no idempotency key

**The envelope has no field the endpoint could use to recognise a repeat
delivery.**

This is a statement about the **structure** of the body Sabatino Rinaldi's plugin
sends — see
[the WooCommerce payload contract](../The%20WooCommerce%20payload%20contract.md).
It carries no idempotency key, no signature and no send timestamp; the only dates
in it are the WooCommerce order's own lifecycle dates, which are identical across
two deliveries of the same order.

That would not matter if an order were only ever pushed once. Three things from
the 27 August record say otherwise, none of them inferred from the sample:

- 🟢 The plugin has a **manual re-send button**, minuted as a feature in
  [the flow note](../flows/The%20WooCommerce%20order%20integration.md) — the
  WooCommerce twin of the Mexal _"rinvio ordine"_ button. Re-sending an order that
  already went is its entire purpose.
- The trigger fires on **two** states, `in lavorazione` **and** `completato`
  (`ORD-12`). An order that passes through both — the bank-transfer path, where
  administration flips it by hand — plausibly posts twice by design. Nobody has
  said whether the plugin suppresses the second.
- Any HTTP retry on a timeout re-posts.

## The consequence

Without a dedupe rule the endpoint creates a **second Salesforce order** for the
same WooCommerce order. On a stage sale that means duplicate contract generation
([OI-101](OI-101%20Stage%20sales%20must%20be%20in%20the%20WooCommerce%20test%20set.md)),
and downstream a duplicate asset.

## What to do about it

**The fix is ROMI's and it is cheap**, which is why this is a note and not an
escalation. The payload does carry a stable natural key — `order.id` and
`order_key`:

- Store the WooCommerce order key on the Woo-originated order type that
  [the flow note](../flows/The%20WooCommerce%20order%20integration.md) already
  calls for, and make it **unique**.
- On a repeat, **update rather than insert** — which is also what makes the
  re-send button useful after a correction, its stated purpose.
- Decide what a re-send may overwrite once the order has moved on in Salesforce.
  That one is a genuine design question, not a mechanical one.

## The security half

Same absent envelope, so it belongs in the same decision:

🔴 **Nothing in the body is signed.** The Opportunity id is carried as a plain
field and there is no signature, nonce or timestamp beside it. So the **header
token** ROMI still owes under
[OI-102](OI-102%20Salesforce%20endpoint%20and%20token%20for%20the%20WooCommerce%20plugin.md)
is the entire authentication of this integration, and anyone holding it can post
an arbitrary order against an arbitrary opportunity id.

That may be an acceptable trade for phase 1. It has simply never been **stated
and accepted**, and `INT-16` still carries the opposite recommendation. Decide it
and close `INT-16` either way.

⚠ Do not record the token itself here or anywhere in the repository — see
[docs/publishing.md](../../docs/publishing.md).
