---
id: OI-104
type: open-item
status: in-progress
owner: Aurel Mrruku
with: Sabatino Rinaldi
org: both
raised: 2026-08-28
updated: 2026-08-31
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

## 2026-08-28 - the dedupe half is already built; the security half is not

The `org-status-check` run of **2026-08-28, 14:45–14:56Z** inspected the
endpoint. **The statement at the top of this note is still exactly true — the
payload carries no key — but the conclusion drawn from it was too pessimistic:
the implementation derives one.**

🟢 **The fix prescribed above exists in the org.**
`Order.WooCommerce_Order_Key__c` is **unique** and an **external id**, checked
before insert, returning **409** on a duplicate. That is, line for line, the
"make it unique and update rather than insert" recommendation — built before
this note proposed it.

🟢 **And it is exercised, not merely present.** The run found **5 inbound
integration log rows** (3×200, 1×409, 1×500) and **2 Orders** carrying a
WooCommerce key. The 409 is a real duplicate that the endpoint actually
rejected.

🔴 **One residual defect, and it is genuine.** The check is
**SOQL-then-insert**, so two concurrent deliveries of the same order both read
"absent" and then race onto the unique index; the loser surfaces as a **500**,
not a clean 409. The single 500 observed has that shape — but **causation is not
established**, and the run says so. Two states firing plus a manual re-send
button is precisely the traffic that produces concurrency, so this is worth
closing properly rather than waiting to see.

🔴 **The security half is untouched and is now verified, not inferred.**
`INT-16`: the endpoint is `@RestResource`, `global without sharing`, and an
exhaustive search of the class found **no token and no signature check
anywhere** — only a `Content-Type` response header. So the reading above is
confirmed from the code, not just from the envelope: **authentication rests
entirely on the Salesforce session**, and the header token owed under
[OI-102](OI-102%20Salesforce%20endpoint%20and%20token%20for%20the%20WooCommerce%20plugin.md)
is the whole of it.

**What is left of this item**, therefore, is narrower than when it was raised
and is all ROMI-side:

1. Close the SOQL-then-insert race (upsert on the external id, or catch the
   duplicate-value exception and convert it to the 409 the caller expects).
2. Decide what a re-send may overwrite once the order has moved on in
   Salesforce — **still open, still the real design question**, and untouched by
   any of the above.
3. Settle `INT-16` in one direction or the other, with OI-102.

**Basis: the org, inspected 2026-08-28.** This sweep did not open the org
itself; it is recording a run that did. The tracker row and the register entry
both still describe the pre-28-August reading.

## 2026-08-31 - the class was rewritten and the duplicate contract changed silently

The `org-status-check` of **2026-08-31, 09:36–09:52Z** found the endpoint
**rewritten and renamed** since 28 August — the deployed class is now
`WoocommerceOrderService` (23,087 chars), it was modified that same day, and it
is [not in source control at all](../risks/Risk%20-%20a%20clean%20deploy%20would%20orphan%20the%20live%20WooCommerce%20endpoint.md).
Everything below is about a class nobody can review in a diff.

🔴 **The duplicate response changed, and no one recorded it.** A repeat delivery
now returns **HTTP 200 with `duplicate: true`** in the body, and updates the
Opportunity, where on 28 August it returned **409**.

That is defensible on its own terms — idempotent-success is a normal choice, and
arguably a friendlier one for a plugin that retries. **The problem is that it is
a contract change on a live integration that the counterparty was never told
about.** Sabatino Rinaldi's plugin has a manual re-send button; whatever it does
today with a 409 it will now do with a 200, and it can only tell "created" from
"already existed" by parsing the body flag. If it branches on status code, it now
reports every duplicate as a fresh success.

**Somebody has to tell Sabatino Rinaldi before the integration tests this week.**
This is a one-line message, and it is the cheapest thing on this note.

⚠ It also means the record now describes the endpoint three different ways —
`409` in the 28 August section above, `409` in the tracker row and the register,
and `200 + duplicate: true` in the org. The org is right; the rest is stale.

🟢 **Still being exercised, harder than before.** 16 inbound log rows (13×200,
1×409 historical, 2×500) and **7** Orders carrying a WooCommerce key, up from 5
logs and 2 orders. The single historical 409 is the last artifact of the old
contract.

🔴 **Both residuals survived the rewrite intact.**

- The **SOQL-then-insert race** is unchanged, and the 500 count has gone from 1
  to 2. Causation is still not established, and two 500s is still not evidence —
  but it is the direction the race would push it, and the traffic has roughly
  tripled.
- **`INT-16` is unchanged and re-verified.** The rewritten service is still
  `global without sharing` with no token or signature check anywhere. Its only
  handling of `Authorization` **redacts the header for logging** (lines 418–427)
  — which proves the header is received and stored safely, and proves nothing
  about it being checked. The token owed under
  [OI-102](OI-102%20Salesforce%20endpoint%20and%20token%20for%20the%20WooCommerce%20plugin.md)
  is still the entire authentication of this integration.

**Basis: the org, inspected 2026-08-31.** This sweep did not open the org; it is
recording a run that did, whose findings were otherwise never published.
