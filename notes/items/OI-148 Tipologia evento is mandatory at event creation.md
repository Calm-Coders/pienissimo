---
id: OI-148
type: open-item
status: open
owner: Aurel Mrruku
org: both
raised: 2026-09-18
updated: 2026-09-21
source: notes/meetings/2026-09-18 Data Model Parte 6.md
---

# OI-148 - Tipologia evento is mandatory at event creation

Agreed at [Data Model Parte 6](../meetings/2026-09-18%20Data%20Model%20Parte%206.md)
(`01:22:51`). Fabrizio Paganelli proposed the field; **Aurel Mrruku ruled it
mandatory at the moment the event is created.**

Initial values, as the group defined them: **live (dal vivo)**, **online /
streaming**, **webinar**, and a default **altro**.

## Open

- 🔴 **Nothing builds it.** No picklist, no required-field enforcement in
  `force-app/` as of `0317348`.
- ⚠ **The value set is "initial" by the group's own words**, so it is not closed.
  It is also the fourth picklist on this project whose values were agreed verbally
  and never delivered as a list — compare
  [OI-115](OI-115%20Tipologia%20Attivita%20values%20and%20its%20move%20to%20the%20quote.md),
  where a field was made mandatory and global **while empty**.
- ⚠ **A mandatory field with no values blocks record creation.** If this is built
  before the values are confirmed, event creation breaks in UAT — exactly the
  OI-115 failure, repeated.
- ⚠ Zoom meeting ID was kept on the campaign for online events, so the two fields
  interact.
- ⚠ No register row covers it.
