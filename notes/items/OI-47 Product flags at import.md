---
id: OI-47
type: open-item
status: in-progress
owner: ROMI
org: ROMI
raised: 2026-07-23
updated: 2026-08-15
source: meetings/open-items.md row 47
---

# OI-47 - Product flags at import

Two admin-toggleable flags on the product/article object, replacing logic that
read a letter out of the product code:

- **"genera biglietto" (yes/no)** — maintains the set of codes that generate a
  ticket. No development needed to change the set.
- **"solo bundle" (yes/no)** — marks bundle-only codes that tutors cannot use
  in direct sales, because agents earn no commission on bundle sales.

Article codes are unique and stable — Fabrizio Paganelli confirmed they are not
changed — so the ticket-generating set stays intact across years.

**Both fields now exist.** `Genera_Biglietto__c` was found in the 2026-08-03
org check, flagged true on **zero products**. `Solo_Bundle__c` was reported
missing by that same check and was committed on 7 August —
[the build ahead of the record](../objects/The%20build%20ahead%20of%20the%20record.md).

So the mechanism is built and **no product is flagged**. Until the data is
entered, nothing generates a ticket and no code is protected from tutor sale —
which is the only thing standing between administration and
[an incoherent bundle](../risks/Risk%20-%20no%20coherence%20control%20on%20bundle%20composition.md),
since that risk was accepted on the basis of these flags.

Feeds [the workbook](OI-24%20Data%20model%20workbook.md).
