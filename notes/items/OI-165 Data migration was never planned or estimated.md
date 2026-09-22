---
id: OI-165
type: open-item
status: open
owner: Aurel Mrruku
with: Elena Spini
org: ROMI
raised: 2026-09-22
updated: 2026-09-22
depends_on: [OI-154, OI-24]
blocks: [go-live]
severity: gating
source: notes/meetings/2026-09-22 Update Interno Aurel Elena.md
---

# OI-165 - Data migration was never planned or estimated

**Stated plainly by Aurel Mrruku at
[the internal update](../meetings/2026-09-22%20Update%20Interno%20Aurel%20Elena.md),
22/09 14:31 CEST:**

> _"sulla migrazione degli ordini… sinceramente io non avevo messo in piano, non avevo
> calcolato il tempo per la migrazione dei dati. Non sarà una cosa che si farà in un
> giorno."_

**Go-live is 21 October and Zoho expires 31 October.**

## What makes it more than a schedule gap

- 🔴 **The environment sequence is unbuilt.** Today's work is in a sandbox. Production
  means **moving the structures, migrating the data, then granting access** — in that
  order, with no slot for it on the calendar.
- 🔴 **The data is not clean.** Aurel Mrruku's specific worry is **missing links
  between the ids**, and the **insertion order** that would restore them. Elena Spini
  on the extraction: _"fanno cagare."_
- ⚠ **Historical orders are the hard part.** Fabrizio Paganelli kept the full product
  and customer registries deliberately, because a historical order portfolio cannot be
  imported if its article codes were filtered out: _"se non ci metto il codice
  articolo, come faccio a portarmi dentro i dati?"_ So the migration cannot be trimmed
  to the clean subset.
- ⚠ **The demo will use real records, not test ones** — Elena Spini's call, because
  _"conoscendo i miei polli, se vedono 'test' si agitano, non capiscono niente"_. That
  makes a partial, imperfect import a UAT dependency rather than a post-UAT task.
- **A field was added to the model on 22/09** (the product tranche count,
  [OI-167](OI-167%20Plus%20orders%20explode%20from%20a%20tranche%20count%20on%20the%20product.md)),
  so the mapping is still moving while the import is being prepared.

## What is scheduled

🟢 **`Check Data Import`, 23/09 10:00–12:00**, booked in-session at
[the 11:22 client call](../meetings/2026-09-22%20Logiche%20Spacchettamento%20Righe.md) —
Aurel Mrruku, Elena Spini, Fabrizio Paganelli, Elisa Migliano. Its purpose is to walk
the field list object by object and decide what travels. Fabrizio Paganelli offered as
many sessions as it takes: _"possiamo fare anche 10 call su questo argomento, perché se
scaziamo qui scaziamo tutto."_

🟢 On 23/09 the team also intends to **import the client's accounts and delete the test
ones**, per
[the pre-UAT session](../meetings/2026-09-22%20Test%20Interni%20Pre-UAT%20Parte%202.md).

## Open

- 🔴 **Estimate the migration and put it on the plan.** Nobody has. Elena Spini's
  `#tproj-pienissimo` post of 21/09 carries `Stima giornate a finire: 30` with no unit
  stated, and this work is not visibly inside it.
- 🔴 **Decide the production sequence and who does it.**
- ⚠ The 2026 extraction is a **Saturday snapshot** from Zoho, re-extractable by design,
  so a cut-over refresh is possible — but not planned.
