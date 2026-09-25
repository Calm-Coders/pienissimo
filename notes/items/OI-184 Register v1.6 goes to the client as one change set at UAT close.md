---
id: OI-184
type: open-item
status: open
owner: Aurel Mrruku
with: Elena Spini
org: both
raised: 2026-09-25
updated: 2026-09-25
depends_on: [OI-151, OI-181, OI-182, OI-46]
source: drill-me session 2026-09-25
---

# OI-184 - Register v1.6 goes to the client as one change set at UAT close

**Decided via drill-me, 2026-09-25 (Aurel Mrruku):** amend the requirements register
**now**, and send the changes to the client for signature **as one change set when UAT
closes** (approval due ~13/10), not one at a time during UAT.

## What v1.6 contains

Applied the same session to `requirements/pienissimo-requirements.yaml`,
`REQUIREMENTS.md` and `REQUISITI.it.md`:

| Change                                                                                              | Where                                              | Agreed at |
| --------------------------------------------------------------------------------------------------- | -------------------------------------------------- | --------- |
| Quote state **`Firmato`**; the order is generated at it                                             | `state_machines.quote`; prose §state machines      | UAT 24/09 |
| Tranches also defined **at bundle creation**, inherited by quotes, used as-is by WooCommerce orders | `ORD-01`, `ORD-02`, `DM-17`, glossary `TRANCHE`    | UAT 25/09 |
| Bundle year = **anno accademico**; **evento di origine**; **Presenza piattaforma**                  | `BUN-08`, glossary                                 | UAT 25/09 |
| Opportunity type **WooCommerce** (Recall Tutor / Pack Tutor) replaces Recall tutor                  | `SAL-21`, `state_machines.order.opportunity_types` | UAT 25/09 |

## Open

- ⚠ **The prose documents jumped from 1.4 to 1.6.** The YAML was at 1.5 (go-live move,
  09/09) but the prose headers still said 1.4. v1.6 covers both.
- 🔴 **More UAT changes are coming** (Preventivi, Biglietti 30/09, WooCommerce re-test
  02/10, Mexal 06/10, marketing 07/10). Each needs adding to this set before it is sent,
  or v1.6 goes out already stale.
- ⚠ `rifiutato` (24/09) is still unlabelled, and `DIV-07` (quote labels vs org) is still
  open. Neither is in v1.6.
- Who sends it, and in what form (a diff or the full document), is not decided.
