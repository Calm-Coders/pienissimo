---
id: OI-46
type: open-item
status: in-progress
owner: Fabrizio Paganelli
with: ROMI
org: both
raised: 2026-07-23
updated: 2026-08-14
source: meetings/open-items.md row 46
requirement: BUN-07
---

# OI-46 - Bundle classification picklists

**anno solare** (master) → **evento** (dependent picklist, showing only that
year's events) + **tipologia di bundle** (independent of both — "Anno con
Pienissimo", "…Ripetente", other).

The event seed is **7 canonical events**: Tour, Food Marketing Festival,
Pienissimo Live, Academy, Sold Out, O.D.B. Live, Camerieri Venditori, Mastery —
Happy Team sells nothing.

⚠ **Use "anno solare", never "anno accademico".** The academic year (May →
September) is a distinct Pienissimo concept used for ticket generation. Keeping
them separate is deliberate.

Values are re-created clean from Fabrizio Paganelli's lists, **not** migrated
from `LIVELLO_3`/`LIVELLO_4`.

**Fields built, data absent.** `Anno_Solare__c`, `Evento__c` and
`Bundle_Type__c` all exist on `Product2` and are **populated on zero bundles**.
Fabrizio owes the definitive seven-event list — started live in a mail thread
on 23 July, still not delivered as of the 2026-08-06 session, where it was
re-requested alongside
[prices](OI-87%20Real%20catalogue%20prices%20still%20outstanding.md) and
[bundle-only codes](OI-48%20Bundle-only%20article%20codes.md).
