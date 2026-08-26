---
id: OI-47
type: open-item
status: open
owner: ROMI
org: ROMI
raised: 2026-07-23
updated: 2026-08-26
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

## 2026-08-25 - org check: both flags exist, one is used

Verified read-only against **Pienissimo UAT**, across 280 `Product2` records.

| Flag                  | Requirement | True on      |
| --------------------- | ----------- | ------------ |
| `Genera_Biglietto__c` | BUN-12      | **4** of 280 |
| `Solo_Bundle__c`      | BUN-13      | **0** of 280 |

`Solo_Bundle__c` was committed on 4 August to close this item and **has never
been set on a single product**. The field satisfies the requirement's letter;
the behaviour it is supposed to drive — hiding an article from tutors in direct
sales — cannot be observed, because nothing is flagged and there is no
automation reading the flag.

`Genera_Biglietto__c` has moved: the register's `build_state` recorded it as
"true on zero products" on 2026-08-03, and four products now carry it. Those
four are what `OrderBigliettoTrigger` acts on.

Import-time population of both flags is still owed and depends on
[the Zoho workbook](OI-24%20Data%20model%20workbook.md).

## 2026-08-26 - both flags get a Mexal carrier, and one gets a caveat

The [26 August Mexal review](../meetings/2026-08-26%20Review%20Temi%20Integrazione%20Mexal.md)
answered the question this note leaves open — _"whether the event flag falls on
the Mexal side or the Salesforce side"_ — and answered it for both flags.

**Mexal carries them, in the `natura` field (`COD_Natura` over the API).** Tested
live: Fabrizio Paganelli created a `natura` value against article `CS_00154` and
Andrea Di Cicco saw it arrive over the API within seconds. `natura` is a lookup
to a managed base table, **not free text**, so an operator cannot invent a value —
which was Andrea Di Cicco's first objection and is now answered.

**The value convention is not chosen.** Fabrizio Paganelli takes the scheme to
Pienissimo's direction on **31 August**.

⚠ **`Solo_Bundle__c` alone does not do the job.** Aurel Mrruku established in the
same session that a ticket-generating article and its bundle-only twin must be
**two distinct article codes**, not one code with a flag —
_"devi per forza avere due prodotti, non lo puoi fare un unico prodotto."_ The
flag marks which is which; it does not remove the need for the twin. See
[OI-48](OI-48%20Bundle-only%20article%20codes.md), where the opposite reading was
recorded on 24 August.

Fabrizio Paganelli will **configure two test articles** carrying the new flags
next week. That is the first thing that will actually populate either field.

⚠ Aurel Mrruku floated encoding both booleans as four `natura` values, then
backed away from it when ticket type turned out to have three values; Andrea Di
Cicco called it _"un po' complicato"_. **No conclusion** — do not build against
the combination scheme.
