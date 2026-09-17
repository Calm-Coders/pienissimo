---
id: OI-141
type: open-item
status: open
owner: Aurel Mrruku
with: Andrea Di Cicco
org: ROMI
raised: 2026-09-17
updated: 2026-09-17
depends_on: [OI-140]
blocks: [go-live]
source: notes/meetings/2026-09-17 Follow-up Interno.md
---

# OI-141 - Contract object for Performance Plus orders

Decided at [the 17/09 internal follow-up](../meetings/2026-09-17%20Follow-up%20Interno.md).
**Nothing builds it.**

## The decision

When an order of type **Performance Plus** or **attivazione/rinnovo** is
generated, a **Contract record linked to the order is created automatically**
(`00:40:30`, `00:47:16`). Aurel Mrruku placed the creation **at the moment the
order is transmitted to Mexal**.

Elena Spini's reason for wanting the object at all: these orders need their
**state, total value, invoiced amount and collected amount** tracked over a life
longer than a single order. She gave an order-count and a per-order value for the
category; **neither figure is recorded here** — see
[docs/publishing.md](../../docs/publishing.md).

## How it is meant to be populated

🔴 **Through Mexal APIs that nobody at ROMI has the contract for.** The financial
fields — invoiced, collected, overdue, unpaid issued invoices — come from the
`scoperto clienti` / `scadenziario` calls, returned **aggregated per customer
code** (`00:58:46`, `01:00:43`). The notes' own `Da approfondire` block records
the alignment as **deferred to a session with Andrea** (`00:51:43`, `00:57:12`).

🟢 **That session is booked.** `[PIENISSIMO] - Temi Mexal`, **Friday 18 September
10:00–11:00 CEST**, Elena Spini organising, Aurel Mrruku and **Andrea Di Cicco**
invited — the invitation went out at 13:17:39Z the same afternoon. It is the
first thing to put Andrea Di Cicco back in a room since
[OI-139](OI-139%20Andrea%20Di%20Cicco%20is%20winding%20down%20with%20four%20integration%20questions%20unanswered.md).

⚠ **A one-hour slot now carries five outstanding questions plus this one.**
OI-110, OI-102, OI-125 and OI-135 are all his, all older, and none is on that
invitation's subject line.

## Dates are manual

The **signature date does not coincide with the start of service**. The
operational team — the notes say _"user strategies"_, the transcript
_strategist_ — enters contract **start and end dates by hand through a banner**
on the order (`00:55:19`, `01:11:11`). ⚠ Which team that is in ROMI's or
Pienissimo's own naming is **not established**; both sources use the English
term loosely and no person is named.

## What decides that a contract is needed

A **specific product code** on the offer determines whether a contract is
generated automatically (`01:04:06`). 🔴 **That code does not exist yet.** Elena
Spini: only ~2,000 sample codes and a further ~200 products have been sent, so
there is still no definitive product-code file, and a **dedicated parameter** has
to stand in for it. This is the same gap as **the article codes the client has
owed since the 14/08 sweep**.

## Open

- 🔴 **The contract data model is undefined** — the notes say so explicitly, and
  the *activation field* with it (`01:11:11`).
- 🔴 **No register row covers it.** Nothing in
  `requirements/pienissimo-requirements.yaml` describes a Contract object. This
  is new scope stated internally by ROMI, eight days before UAT opens, and it is
  **not for a sweep to allocate a requirement id.**
- 🔴 **No Mexal test environment is known to exist** for exercising
  `scoperto clienti` — the standing finding of the 14/09 DM still holds.
- ⚠ The financial figures come back **per customer code, not per contract**
  (`00:58:46`), so how one customer's several contracts are told apart is
  unanswered.
