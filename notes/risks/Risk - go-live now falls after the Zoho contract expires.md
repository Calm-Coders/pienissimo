---
id: risk-go-live-after-zoho-expiry
type: risk
status: open
owner: Elena Spini
org: both
raised: 2026-10-15
updated: 2026-10-15
depends_on: [OI-243]
blocks: [go-live]
severity: gating
source: notes/items/OI-243 Go-live moved from 21 October to 2 November.md
---

# Risk - go-live now falls after the Zoho contract expires

**Zoho CRM expires 31 October 2026. As of 15 October the go-live is 2 November.
The overlap between the outgoing and incoming CRM is no longer thin — it is
negative, by two days, and no source in this project has noticed.**

## The arithmetic

| Go-live date       | Set by                                             | Overlap with Zoho |
| ------------------ | -------------------------------------------------- | ----------------- |
| 6 October 2026     | the signed requirements                            | 25 days           |
| 21 October 2026    | [OI-124](../items/OI-124%20Go-live%20moved%20from%206%20to%2021%20October.md), 08/09 | 10 days           |
| **2 November 2026**| [OI-243](../items/OI-243%20Go-live%20moved%20from%2021%20October%20to%202%20November.md), 15/10 | **−2 days**       |

The Zoho expiry is of record in several places and has never been disputed:
`requirements/pienissimo-requirements.yaml:469` states the assumption as
_"Zoho expires 31 October 2026; dual-run window is ~3 weeks"_;
[OI-04](../items/OI-04%20Scope%20against%20the%20go-live%20date.md) carries
**31 October — Zoho contract expires** in its milestone table; and
[OI-165](../items/OI-165%20Data%20migration%20was%20never%20planned%20or%20estimated.md)
repeats _"Go-live is 21 October and Zoho expires 31 October"_ twice.

🔴 **The register's stated assumption is now false in direction, not degree.** A
three-week dual run became ten days in September and is now a gap.

## Why it is more than a diary clash

1. 🔴 **Pending offers are re-entered by hand, from Zoho.** Fabrizio Paganelli
   at [the 15/10 session](../meetings/2026-10-15%20Migrazione%20e%20Go-Live.md):
   the users _"dovrebbero prendere e andare a vedere tutte le offerte che hanno
   pending su Zo[h]o e inserirle anche su Sales Force"_. That is the operational
   half of [OI-172](../items/OI-172%20Historical%20quotes%20and%20offers%20are%20not%20migrated.md),
   and it requires a readable Zoho **after** 31 October unless it is done first.
   Nobody has been given that task, a volume or a deadline.
2. 🔴 **The real migration load is scheduled for the go-live day itself.** Aurel
   Mrruku: _"nel giorno in cui si va in produzione, facciamo la migrazione da
   quel momento in poi"_
   ([OI-244](../items/OI-244%20Historical%20orders%20will%20be%20migrated%20from%20Mexal%20by%20spreadsheet.md)).
   If anything in that load fails, the fallback system is already gone.
3. ⚠ **The migration source moved to Mexal, which softens but does not remove
   it.** Historical orders now come from Mexal rather than Zoho, so the bulk
   migration no longer depends on a live Zoho. The pending-offer re-entry and
   any lookup against history still do.
4. 🔴 **The client says 2 November will not be met.** If it slips, the gap grows
   day for day, and the 27 October Go/No-Go falls **before** the expiry while the
   go-live falls after — so the decision is taken while Zoho is still alive and
   executed when it is not.

## What is not established

- ⚠ **Whether the Zoho contract can be or has been extended.** No source in this
  repository says. The 31 October date has been treated as fixed since June.
- ⚠ **What "expires" means operationally** — read-only access, a grace period, or
  data loss. Nothing records it, and the difference decides how serious this is.
- ⚠ **Whether anyone on either side has connected the two dates.** Zoho is named
  nowhere in the 15/10 session and nowhere in the 15/10 mail, which is the only
  evidence available and is evidence of absence, not of a decision.

## What a human has to do

1. **Ask what happens to Zoho after 31 October**, and get the answer in writing.
   One question to Fabrizio Paganelli or Sabatino Rinaldi settles the severity of
   this whole row.
2. **If it cannot be extended**, either the go-live moves back inside October or
   the pending-offer re-entry and any Zoho-dependent lookup must complete before
   31 October — which means naming an owner for it this week.
3. **Correct the register's dual-run assumption** when `CTX-02` moves.
