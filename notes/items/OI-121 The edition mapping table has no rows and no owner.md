---
id: OI-121
type: open-item
status: open
owner: Aurel Mrruku
with: Fabrizio Paganelli
org: both
raised: 2026-09-04
updated: 2026-09-04
depends_on: [OI-96, OI-98]
blocks: [OI-53, OI-84]
source: notes/objects/The Mappatura Edizione object.md
---

# OI-121 - The edition mapping table has no rows and no owner

**`Mappatura_Edizione__c` shipped on 4 September, it is populated by hand, and
nobody has been asked to populate it.**

The object and its matching logic are built and are a faithful implementation of
[OI-96](OI-96%20Edition%20mapping%20table%20on%20Salesforce.md) —
[the build note](../objects/The%20Mappatura%20Edizione%20object.md). What does not
exist is the data.

## Why an empty table is not merely "unconfigured"

`OrderBigliettoTriggerHandler.assignCampaigns` **throws** when no active mapping
matches a ticket-generating product at the order date:

> _"Nessuna mappatura edizione trovata per il prodotto … alla data ordine …"_

It is called from the path that generates tickets when an Order **transitions
into `Incassato`**. So the precise consequence is:

🔴 **Any ticket-generating order cannot be moved to `Incassato` until a mapping
row covers its product and its order date.** The exception is unhandled, so the
status update rolls back.

Three facts make that more than theoretical:

- **The order lifecycle is live.** The 2 September org check found `Incassato`
  on **12 of 15** orders — this is a state the business actually uses.
- **43 products carry `Genera_Biglietto__c`** after the 2 September registry
  reload, so the affected set is most of the catalogue that matters.
- **Orders arrive by themselves.** `WoocommerceOrderService` creates orders from
  live shop traffic; whoever later marks one paid meets this.

## What has to be decided, not just done

**Who owns the rows.** OI-96 records the mechanism and Fabrizio Paganelli's
worked example — Food Marketing Festival 2027 taking orders from 1 Oct 2025 to
30 Sep 2026 — and his statement that the dates are arbitrary:
_"puoi mettere data a piacere… io mi baso solo su quelle date."_ It names nobody
as the maintainer. The windows are commercial decisions, so they are probably
Pienissimo's; the table is in Salesforce, so entering them is probably ROMI's.
**Nothing says.**

**When they can be entered.** ⚠ `Prodotto__c` is a lookup to `Product2`, so every
row references a product record by id. Fabrizio Paganelli intends to **close all
~1000 Mexal article codes and re-create them**
([OI-98](OI-98%20The%20Mexal%20article%20registry%20is%20being%20re-created.md)).
If that reload replaces `Product2` records rather than updating them, mapping
rows entered first are orphaned. **Sequence the two.**

**What the fallback is.** Today an unmapped product blocks a business state
transition with an Apex exception message. That is a defensible choice for a
system where every ticket must have an edition — and an undefensible user
experience if it happens to an administrator closing a routine order. Nobody has
been asked whether a blocking error is the intended behaviour, or whether an
unmapped line should generate a ticket with no campaign and a report to chase.

## Also worth stating

🟢 **The overlap guard means the table cannot be filled carelessly.**
`MappaturaEdizioneTriggerHandler` refuses two active rows for the same product
with overlapping windows. Whoever enters the data will meet that rule, and it is
the right rule — but it means a bulk load has to be clean on the first attempt
rather than corrected afterwards.

**No date, and it is inside the Fase 1 window.** Development ends **10
September**, three of whose four remaining working days fall inside ROMI's 9–11
September offsite
([the compressed calendar](../risks/Risk%20-%20the%20whole%20remaining%20build%20lands%20after%20Ferragosto.md)).
