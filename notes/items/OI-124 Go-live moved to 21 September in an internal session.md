---
id: OI-124
type: open-item
status: open
owner: Elena Spini
with: Aurel Mrruku
org: ROMI
raised: 2026-09-07
updated: 2026-09-07
blocks: [go-live]
requirement: CTX-02
source: notes/meetings/2026-09-07 Follow-up Interno.md
---

# OI-124 - Go-live moved to 21 September in an internal session

**The 7 September internal follow-up agreed a go-live of 21 September 2026 with
approval by 13 September. Every governing document in this repository says
6 October 2026. Nothing has been changed, because an internal meeting summary is
not the authority for a date the client signs.**

## What was decided

From [the session](../meetings/2026-09-07%20Follow-up%20Interno.md), recorded by
Gemini under `Concordato`:

> _"È stato concordato di fissare la data di Go Live al 21 settembre, con
> l'approvazione fissata entro il 13 dello stesso mese."_

And in the detail: release to production **precedes** go-live, approval lands
**by 13 September**, and the change is described as adding weeks of development
and test to arrive at 21 September.

Present: Elena Spini, Aurel Mrruku, Andrea Di Cicco, Fabrizio Mastracci. **No
client.**

## 🔴 What the record says instead

| Where | What it says |
| ----- | ------------ |
| `REQUIREMENTS.md` / `REQUISITI.it.md` — **`CTX-02`** | **Go-live 6 October 2026**, focused on the WooCommerce and Mexal integrations |
| Both documents, priority key | `M` = _indispensable for the 6 October 2026 go-live_ |
| Both documents, milestone table | **6 October 2026 — Go-live** |
| Both documents, Fase 2 rule | requests endangering **6 October 2026** are automatically Fase 2 candidates |
| `MAP.md` | go-live Fase 1 **6 October**, Fase 2 **9 November** |
| `DEVELOPMENT-RECAP` §10.1, both languages | "the date is 6 October 2026", published by Elena Spini in every weekly status since 26 June |

`REQUISITI.it.md` is **the document presented to Pienissimo for signature**. The
date is not decoration in it: three separate mechanisms in the requirements —
the `M` priority definition, the milestone table and the Fase 2 escalation rule —
are all keyed to it.

## 🔴 The direction is the surprising part

21 September is **fifteen days earlier** than 6 October, not later. The session
describes it as a *slittamento* that **adds** development and test weeks, which
only makes sense against a plan whose go-live was earlier than 21 September. **No
such plan is in this repository.** Either:

- the working plan in ROMI's own project tooling has diverged from the signed
  requirements and this is a slip **within that plan**, or
- go-live has genuinely been pulled forward by two weeks.

The two readings have opposite consequences for everything downstream and the
notes do not distinguish them. **Ask; do not infer.**

## What it collides with

- **Zoho expires 31 October 2026.** A 21 September go-live widens the dual-run
  window rather than narrowing it — the one effect that is unambiguously good.
- **Fase 1 development ends 10 September**, inside the 9–12 September offsite.
  Approval by **13 September** is the first working day after it.
- **Elena Spini is off 14 and 15 September.** Approval on the 13th (a Sunday) or
  the days immediately after runs into that.
- **The product-to-campaign mapping** is planned for "the days immediately before
  go-live" ([OI-121](OI-121%20The%20edition%20mapping%20table%20has%20no%20rows%20and%20no%20owner.md)).
  Those days just moved by two weeks and the table still has no named owner.
- **Aurel Mrruku's own list of what is still open** at the same session: the
  community, DocuSign document handling, lead conversion, the WooCommerce
  integration. None of them is finished.
- **Client demonstration sessions are being organised from 24 September** — after
  the proposed go-live, not before it.

## What a human has to do

1. **Say which date governs.** If 21 September is real, `CTX-02` and the two
   milestone tables have to change **in both languages in the same session**, and
   the client has to be told, because the Italian is the operative text.
2. **Say whether the client has agreed.** Nothing in any source this run reached
   shows Pienissimo being asked. The decision was taken in a ROMI-internal room.
3. **Reconcile the plan.** If ROMI's internal plan carries a different date from
   the signed requirements, that gap is itself the finding.

**Until then the register stands at 6 October and this row carries the conflict.**
