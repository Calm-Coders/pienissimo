---
id: OI-52
type: open-item
status: open
owner: ROMI
org: ROMI
raised: 2026-07-22
updated: 2026-08-14
depends_on: [OI-50]
source: meetings/open-items.md row 52
---

# OI-52 - Two scheduled reports

Both must be always available and refreshed, with no manual launch:

- **Insoluti**, weekly (Monday was the example), to sales and administration:
  invoices issued, unpaid, and due before the check date. **Production is
  removed from the distribution list.**
- **Tranche in scadenza**, emailed to administration before month end, listing
  the tranches expiring next month.

Neither exists. Both depend on
[the tranche object](OI-50%20Tranche%20object.md), which has not been built, and
on invoices arriving back from Mexal with payment status per line — see
[the Mexal integration](../flows/The%20Mexal%20integration.md).

These are small in build terms and disproportionately visible: they are the
first thing administration will use daily, and the second one is how Pienissimo
learns which tickets are about to become releasable under
[the availability rule](OI-75%20Ticket%20availability%20rule.md).

Worth building the same week as the tranche object rather than as a later
reporting pass.
