---
id: OI-297
type: open-item
status: open
owner: Aurel Mrruku
with: Elena Spini
org: ROMI
raised: 2026-10-28
updated: 2026-10-28
depends_on: [OI-276, OI-291]
blocks: [go-live]
source: Slack D0B5QHS2T7H 2026-10-28 17:18 CET
---

# OI-297 - The OLD edizione links are unresolved before the production load

**The UAT historical load leaves the retired "OLD" edizioni carrying live links.
What to do with them was raised the evening of the load, deferred to the next
day, and left with two incompatible answers on the table: delete them, or change
their state. Whichever is chosen has to be decided before the same load runs in
production.**

## How it surfaced

Slack DM `D0B5QHS2T7H`, immediately after the UAT import completed:

> **Aurel Mrruku, 2026-10-28 17:18:19 CET:** _"importazione fatta"_
>
> **17:18:41:** _"in uat ho fatto dei controlli, **domani dobbiamo capire con i
> link delle edizioni old che si fa**"_
>
> **17:18:47:** _"forse meglio che li forzo"_

and then, in a thread at **17:35:22 CET**:

> **Elena Spini:** _"per i link OLD brutalmente non si può fare massive update
> `>>DELETE` e ciao?"_
>
> **Aurel Mrruku, 17:35:55:** _"si si puo"_ · **17:36:02:** _"si puo ance
> cambiare stato"_
>
> **Elena Spini, 18:01:03:** _"io farei così, perché poi magari ci cliccano e boh
> almeno così non vedono nulla e fine"_

## What is actually unresolved

1. 🔴 **Delete or deactivate — not the same thing.** Elena Spini's stated reason
   is that a user might click the link (_"magari ci cliccano … almeno così non
   vedono nulla"_). Deleting destroys the historical association; a state change
   keeps it and hides it. **Nothing weighs the two**, and the orders just loaded
   bind to these records.
2. 🔑 **"Link" is not defined in the exchange.** The record cannot say whether it
   means the public marketing links of an edizione, the mappatura-edizione rows,
   or the Campaign hierarchy — all three are in play this week. ⚠ **Not guessed.**
3. ⚠ **The OLD edizioni are the client's own construct**, visible in the 27/10
   mail thread _Mappatura Edizioni_ (_"per Academy non trovo 'Academy OLD'"_,
   Gmail `1a17d81184363beb`), and a campaign the client had to be told to
   activate. A unilateral ROMI delete would remove records the client put there.
4. 🔴 **It is deferred to "domani" with no owner written down** and no note of
   whether the same treatment is planned for the production load.

## Why it matters beyond UAT

[OI-291](OI-291%20Changing%20an%20edizione%20date%20does%20not%20update%20its%20product%20mappings.md)
records that an edizione's date range is copied into each of its ~20 product
mappings at creation, and
[OI-276](OI-276%20Dummy%20import%20editions%20are%20needed%20to%20load%20historical%20orders.md)
records that the agreed workaround for unscheduled events is a far-past or
far-future date, chosen precisely so _"marketing non prenderà il link"_. 🔑 **The
OLD links are the same problem arriving from the other side** — the date rule was
supposed to stop a retired edizione being reachable, and the load has produced
reachable retired edizioni anyway.
