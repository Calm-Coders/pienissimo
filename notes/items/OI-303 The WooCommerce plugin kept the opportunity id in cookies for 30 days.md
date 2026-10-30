---
id: OI-303
type: open-item
status: resolved
owner: Sabatino Rinaldi
org: Pienissimo
raised: 2026-10-30
updated: 2026-10-30
depends_on: []
blocks: []
source: notes/meetings/2026-10-30 Connessione WooCommerce.md
---

# OI-303 - The WooCommerce plugin kept the opportunity id in cookies for 30 days

**The WooCommerce plugin stored the opportunity identifier in the cookie and the
session for thirty days and did not clear it on purchase, so later orders from the
same browser were attached to an opportunity that had already been closed.
Sabatino Rinaldi wrote and deployed the fix during the call.**

## The fault

Found in [the 30 October WooCommerce call](../meetings/2026-10-30%20Connessione%20WooCommerce.md),
`00:25:23`: Aurel Mrruku noticed that test orders were being associated with a
**pre-existing opportunity**. Sabatino Rinaldi identified the cause as a plugin
bug — the opportunity id was **held in cookies and sessions for 30 days, surviving
the completion of a purchase**.

## The rule that replaces it

> _"Si stabilisce che l'ID dell'opportunità debba essere utilizzato una sola volta
> e rimosso da cookie e sessione subito dopo il completamento dell'ordine."_

**The opportunity id is single-use.** 🔑 This is a contract on the WooCommerce side
of the integration, not a Salesforce behaviour, and it is the client's plugin.

## The fix

Sabatino Rinaldi **developed and uploaded an updated plugin to the site during the
session** (`00:28:36`), clearing the identifier immediately after purchase. Marked
`resolved` on that basis.

## What is not verified

1. ⚠ **No version, no file, no commit.** The plugin is the client's and lives
   outside this repository; the record is the meeting note.
2. ⚠ **No regression test is recorded.** Subsequent orders in the same call did
   exercise the path, but no test asserts that a second order from one browser
   gets a fresh opportunity.
3. 🔑 **Orders already mis-attributed were not swept.** Thirty days of cookie
   lifetime precede the fix, and nobody has looked for orders bound to the wrong
   opportunity in UAT or in production.
