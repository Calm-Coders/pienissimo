---
id: OI-46
type: open-item
status: in-progress
owner: Fabrizio Paganelli
with: ROMI
org: both
raised: 2026-07-23
updated: 2026-08-15
source: meetings/open-items.md row 46
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

⚠ **The event list may already have been delivered — verify before chasing.**
On 2026-08-07 at 12:17 CEST Fabrizio Paganelli wrote to a thread titled
**"Lista Eventi, Codici prodotto, esempio Bundle"**, and Elena Spini replied at
12:38 — _"Grazie Fabrizio, aggiungo anche Aurel al thread."_ The thanks and the
subject both suggest delivery.

**It could not be confirmed on 2026-08-14.** Fabrizio's message is not
retrievable from the ROMI mailbox: it survives only as an empty quoted stub
inside Elena's reply, consistent with content carried as an **attachment**, and
it does not appear under a `from:` search.

✉️ **Asked. Aurel Mrruku replied on that thread on 2026-08-14** to establish what
Fabrizio actually sent. **Awaiting Elena Spini's answer** — she is on leave until
17 August, so expect nothing before the 19 August meeting. Do not re-request the
list from the client until she replies.

Re-requested at the 2026-08-06 session alongside
[prices](OI-87%20Real%20catalogue%20prices%20still%20outstanding.md) and
[bundle-only codes](OI-48%20Bundle-only%20article%20codes.md) — one day before
that thread.
