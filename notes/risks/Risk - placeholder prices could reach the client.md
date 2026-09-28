---
id: risk-placeholder-prices
type: risk
status: open
severity: high
owner: Aurel Mrruku
org: ROMI
raised: 2026-07-16
updated: 2026-08-14
depends_on: [OI-42, OI-87]
source: meetings/open-items.md rows 42 and 87
---

# Risk - placeholder prices could reach the client

**Every catalogue price in Pienissimo UAT is a ROMI invention.** Ten products
carry numbers Aurel Mrruku made up so the ACADEMY 2026 bundle could be rebuilt —
CAMERIERI 1.200, SOLD OUT 1.500, PIENISSIMO LIVE 900, O.D.B. LIVE 700, FMF GOLD
1.500, MASTERY 800, MANUALE 1st/2nd/3rd 600 each, HAPPY TEAM 500 — each tagged
`[PLACEHOLDER …]` on the product record. The bundle spreads on top of them come
from a pro-rata split, not from a price list.

The totals reconcile, which is the danger: a demo built on them looks correct.

**What goes wrong.** A bundle demo, a report screenshot, or the published
catalogue-analysis artifact reaches Pienissimo showing prices for their own
products that they never set. It reads as ROMI having decided their pricing,
and every per-product revenue figure derived from it is fiction.

The mitigation is the tag and this note, not a control. Nothing in the org
prevents showing a placeholder record.

Real prices have been requested repeatedly —
[OI-87](../items/OI-87%20Real%20catalogue%20prices%20still%20outstanding.md), raised
again on 2026-08-06 — and are owed by Fabrizio Paganelli and Elisa Migliano.
Until they arrive, treat any price-bearing output as internal only. The
published "Analisi Catalogo Prodotti" artifact listed in the README is accurate
on structure and **wrong on every number**.
