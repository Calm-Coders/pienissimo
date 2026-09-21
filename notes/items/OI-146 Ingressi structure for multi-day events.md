---
id: OI-146
type: open-item
status: open
owner: Aurel Mrruku
org: both
raised: 2026-09-18
updated: 2026-09-21
depends_on: [OI-24]
source: notes/meetings/2026-09-18 Data Model Parte 6.md
---

# OI-146 - Ingressi structure for multi-day events

Agreed at [Data Model Parte 6](../meetings/2026-09-18%20Data%20Model%20Parte%206.md)
(`01:42:47`, `01:48:59`, `01:50:33`, `01:59:16`) — **then suspended the same
evening.**

## The design

A new **`ingressi` entity, child of the ticket / asset**, auto-populated from the
**periods defined on the child campaign**, recording the **date and time of each
individual entry**.

It exists because multi-day events break the one-ticket-one-entry assumption.
Fabrizio Paganelli's example: the **Mastery is a single annual event of six days
spread over two months** (`01:36:07`). The same shape applies to Pienissimo Live
and the Academy.

Aurel Mrruku's summary at `01:59:16`: the campaign structure determines the periods
and therefore the entries attached to each generated ticket; verification happens
**both** at campaign level (the container and its periods) and at ticket / asset
level (the actual entry dates).

## Suspended

⚠ **Elena Spini stopped the build the same evening.** DM to Aurel Mrruku, 18/09
17:51:09 CEST:

> _"per il discorso periodo/ingressi che è uscito oggi in call non fare nulla, ok?
> poi ne riparliamo lunedì"_

She had already parked it inside the session itself (`02:02:25`), deciding to take
it away and work it through internally.

🔴 **Monday 21/09 came and went and no artifact revisits it.** Three sessions ran
that day and the `ingressi` topic appears in none of them. So the action item from
Parte 6 is **not late — it is suspended**, and the suspension has not been lifted.

## Open

- 🔴 **Lift or confirm the suspension.** The client agreed a structure in a
  client-facing session; ROMI then told its own developer to build nothing. If it
  is not built, the client has agreed to something that will not exist at UAT.
- 🔴 **Ticket UAT is 30 September** — `Biglietti (Asset), Campagne ed Eventi`.
  That is the session where its absence becomes visible.
- ⚠ **Scan data cannot reach it anyway.** There is no API flow to receive scan
  results from the external scanning app, and Elena Spini put that logic in Fase 2
  ([the session note](../meetings/2026-09-18%20Data%20Model%20Parte%206.md)). An
  entry structure with no automatic entry source records only what someone types.
- ⚠ No register row covers it.
