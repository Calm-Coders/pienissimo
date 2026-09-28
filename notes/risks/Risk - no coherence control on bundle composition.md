---
id: risk-bundle-coherence
type: risk
status: open
severity: medium
owner: Pienissimo
org: both
raised: 2026-07-22
updated: 2026-08-14
depends_on: [OI-47, OI-55]
source: meetings/open-items.md status update 2026-08-06
---

# Risk - no coherence control on bundle composition

Nothing prevents administration attaching an article that does not belong to a
bundle's category. The 2026-08-06 session **decided not to fix it**: no rigid
automated validation, administration is responsible, and eligibility is
pre-constrained only by the product flags in
[OI-47](../items/OI-47%20Product%20flags%20at%20import.md).

This is an **accepted** risk, not an unnoticed one. It is recorded here because
accepted risks stop being visible once the meeting that accepted them scrolls
out of the tracker, and because two conditions could change the calculus:

- bundles are created **only in Salesforce, only by administration** — a small,
  trained group, which is what makes the acceptance defensible today;
- but the same session left
  [a non-zero spread variance free to save](../items/OI-43%20Spread%20variance%20does%20not%20block%20saving.md),
  and [ACADEMY 2026 has already drifted](../items/OI-65%20ACADEMY%202026%20no%20longer%20reconciles.md)
  to a variance of −1.422 with the wrong components attached.

So the failure mode the team accepted has already occurred once in UAT, before
go-live volumes, with the careful group. The combination of "no composition
check" and "no reconciliation check" means a wrong bundle is silently sellable
and silently corrupts per-product revenue — the exact statistic the junction
model was built to protect.

Worth re-asking after the first real event, not before.
