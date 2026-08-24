---
id: OI-47
type: open-item
status: open
owner: ROMI
org: ROMI
raised: 2026-07-23
updated: 2026-08-24
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

## 2026-08-24 - the division of labour is agreed

The [19 August MKT session](../meetings/2026-08-19%20Flussi%20MKT%20Biglietti.md) agreed where products come from, which is the
premise this item depends on:

**Anything with an economic value is created on Mexal and carried to Salesforce
by batch. The bundle layer is Salesforce-only.**

Elena Spini, Fabrizio Mastracci and Elisa Migliano are minuted settling it, with
the ticket-generation logic kept as a separate function from the product sync.

That confirms the direction of travel for the flags — they have to originate in
the Mexal product master, not be maintained in Salesforce. ⚠ **Except that
[OI-76](OI-76%20Ticket%20type%20picklist%20on%20the%20product.md) went the other
way the next day**: because Mexal supports at most three article
classifications, the client agreed on 20 August that **ticket type is maintained
manually in Salesforce**.

So the rule is not uniform. Product identity and price come down from Mexal;
classification that Mexal cannot carry is maintained in Salesforce by
amministrazione. Whether the **event flag** falls on the Mexal side or the
Salesforce side of that line has not been stated, and it is the flag
[OI-53](OI-53%20Asset%20generation%20rule.md) keys on.
