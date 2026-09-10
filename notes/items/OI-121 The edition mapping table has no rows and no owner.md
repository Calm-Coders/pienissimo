---
id: OI-121
type: open-item
status: open
owner: Aurel Mrruku
with: Fabrizio Paganelli
org: both
raised: 2026-09-04
updated: 2026-09-09
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

## 2026-09-07 - the table has rows, and the picture is worse

**Correction: the table is not empty.** An `org-status-check` run against
Pienissimo UAT, reported by **Aurel Mrruku in the ROMI Salesforce group DM at
10:04 CEST**, found **4 mapping rows, 3 of them active, covering 3 distinct
products**.

🔴 **That makes the exposure sharper, not smaller.** The same report puts it at
**226 of 229 products with no active mapping**, against **17 of 22 orders already
on `Incassato`** — up from 12 of 15 at the 2 September check. A throwing code path
now covers 99% of the catalogue.

⚠ **This run did not open the org.** The numbers above are from ROMI's own check
as posted to Slack, not from an inspection performed here, and that check ran at
repo commit `012d49d` — **before** `d562af0` landed. The org check's own caveat
applies: it ran in report mode and reconciled nothing, so `STATUS.md`, the Notion
mirror and the register's `build_state` do not carry any of it.

🟢 **When the rows get entered is now on the record.** The
[7 September internal follow-up](../meetings/2026-09-07%20Follow-up%20Interno.md)
agreed the sequence: **initial product load by Excel, then manual
product-to-campaign mapping with start and end dates, planned for the days
immediately before go-live.** That is the first statement anywhere of _when_.

🔴 **It still names nobody**, which is the half of this item that has not moved.
And two things now press on it:

- **Go-live may have moved to 21 September**
  ([OI-124](OI-124%20Go-live%20moved%20from%206%20to%2021%20October.md)).
  "The days immediately before go-live" is a moving target that has just moved
  two weeks earlier, into a week that also contains the approval gate.
- **The sequencing warning above is now the plan.** This note flagged that a
  `Product2` reload replacing records would orphan mapping rows entered first
  ([OI-98](OI-98%20The%20Mexal%20article%20registry%20is%20being%20re-created.md)).
  The agreed order — **load products first, map afterwards** — is the safe one.
  🟢 Recorded as resolved by design rather than by luck.

⚠ **`Product2` fell from 281 to 229** between the 2 and 7 September org checks,
consistent with [OI-98](OI-98%20The%20Mexal%20article%20registry%20is%20being%20re-created.md)
and **unrecorded until now**. Whatever rows exist were entered against that
smaller set.

## 2026-09-09 - a second source of orders, and the throw is unchanged

Commit **`a53345a`** (Anita Aga, PR **#37**, merged 18:41 CEST) builds
quote-to-order generation
([the build](../objects/The%20commercial%20process%20automation.md)). The
`assignCampaigns` exception this note is built on is **not modified** — same
message, same unhandled throw, still called from the transition into
`Incassato`.

What changed is the population of orders that will eventually meet it:

- 🟢 **Not immediately worse.** Orders created from an accepted quote are born in
  **`Ordinato`**, not `Incassato`, so generation itself does not trip the
  exception. The failure stays where it was — at the moment somebody marks an
  order paid.
- 🔴 **But orders now arrive from a third direction.** WooCommerce traffic,
  hand-creation, and now **any quote reaching `Accettato`** — including from the
  unauthenticated community page
  ([the auth risk](../risks/Risk%20-%20the%20community%20pages%20have%20no%20application-level%20authentication.md)).
  Every one of them is an order that cannot be collected until a mapping row
  covers its product and date.
- 🔴 **The Order also now closes its Opportunity won** on the same
  `Incassato` transition. The `assignCampaigns` throw rolls the whole
  transaction back, so **a missing mapping row now also blocks the opportunity
  from closing** — the failure is visible in the sales pipeline, not just in
  ticketing.

**The item is unchanged in substance and more urgent in effect. Still nobody owns
the rows, and there is still no date for entering them beyond "the days
immediately before go-live".**
