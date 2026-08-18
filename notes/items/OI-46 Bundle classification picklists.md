---
id: OI-46
type: open-item
status: in-progress
owner: Fabrizio Paganelli
with: ROMI
org: both
raised: 2026-07-23
updated: 2026-08-18
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

✅ **Something was delivered on 2026-08-07 — and on 2026-08-18 we learned what.**
Fabrizio Paganelli wrote to a thread titled **"Lista Eventi, Codici prodotto,
esempio Bundle"** at 12:17 CEST that day; Elena Spini thanked him 21 minutes
later and added Aurel to the thread. His message could not be retrieved for
eleven days — it survived only as an empty quoted stub — so the record could not
say whether the event list had arrived.

Aurel Mrruku asked Elena to forward it on 2026-08-14. **She forwarded it on
2026-08-18 at 09:41 CEST.** Fabrizio's message carries **no body text and one
attachment, `Prodotti e Bundle.xlsx`** — see
[the workbook](../The%20Prodotti%20e%20Bundle%20workbook.md). The empty stub is
explained: the content was always the attachment.

⚠ **Do not close this item yet. Nobody has opened the file.** Whether it
contains the definitive 7-event list is **unverified** — the mail subject says
"Lista Eventi", the filename says "Prodotti e Bundle". No connected tool can
read a Gmail attachment, and the file is in neither Drive nor Slack. **It needs
a human to download it.** Until then this stays `in-progress`: the delivery is
confirmed, its sufficiency is not. Do not re-request the list from the client.

Re-requested at the 2026-08-06 session alongside
[prices](OI-87%20Real%20catalogue%20prices%20still%20outstanding.md) and
[bundle-only codes](OI-48%20Bundle-only%20article%20codes.md) — one day before
that thread.
