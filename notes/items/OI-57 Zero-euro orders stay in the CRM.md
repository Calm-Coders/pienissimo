---
id: OI-57
type: open-item
status: open
owner: ROMI
org: ROMI
raised: 2026-07-14
updated: 2026-08-15
source: meetings/open-items.md row 57
requirement: BIG-09
---

# OI-57 - Zero-euro orders stay in the CRM

**Free tickets are recorded as zero-euro orders in Salesforce and are not
transferred to Mexal.** They exist in the CRM to fire the automatic
ticket-generation flow; there is nothing to invoice, so the ERP never sees them.

Rule agreed, implementation pending.

It matters more than it looks. The September tour is roughly 90% new audience
attending free events, so zero-euro orders are the **majority** of ticket
volume in the first month after go-live — and they take a path that skips the
system of record for invoicing.

It also collides with
[ticket availability](OI-75%20Ticket%20availability%20rule.md), which releases a
ticket when the tranche invoice is **paid in full**. A zero-euro order produces
no invoice at all, so the rule as written never fires for exactly the tickets
the tour depends on. Either free orders bypass the availability gate explicitly,
or they never become _Disponibile_. Nobody has written down which.

Interacts with
[the account-creation policy for free tour tickets](OI-29%20Account%20creation%20policy%20for%20free%20tour%20tickets.md).
