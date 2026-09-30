---
id: OI-184
type: open-item
status: open
owner: Aurel Mrruku
with: Elena Spini
org: both
raised: 2026-09-25
updated: 2026-09-28
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

| Change                                                                                              | Where                                                         | Agreed at                                                                          |
| --------------------------------------------------------------------------------------------------- | ------------------------------------------------------------- | ---------------------------------------------------------------------------------- |
| Quote state **`Firmato`**; the order is generated at it                                             | `state_machines.quote`; prose §state machines                 | UAT 24/09                                                                          |
| Tranches also defined **at bundle creation**, inherited by quotes, used as-is by WooCommerce orders | `ORD-01`, `ORD-02`, `DM-17`, glossary `TRANCHE`               | UAT 25/09                                                                          |
| Bundle year = **anno accademico**; **evento di origine**; **Presenza piattaforma**                  | `BUN-08`, glossary                                            | UAT 25/09                                                                          |
| Opportunity type **WooCommerce** (Recall Tutor / Pack Tutor) replaces Recall tutor                  | `SAL-21`, `state_machines.order.opportunity_types`            | UAT 25/09                                                                          |
| Order goes **`Incassato` automatically when every tranche is paid**; replaces the manual 5-day step | `ORD-14`, `state_machines.order.rules`; prose §state machines | ROMI 25/09 ([OI-69](OI-69%20Order%20state%20model.md)), not yet seen by the client |

## Open

- ⚠ **The prose documents jumped from 1.4 to 1.6.** The YAML was at 1.5 (go-live move,
  09/09) but the prose headers still said 1.4. v1.6 covers both.
- 🔴 **More UAT changes are coming** (Preventivi, Biglietti 30/09, WooCommerce re-test
  02/10, Mexal 06/10, marketing 07/10). Each needs adding to this set before it is sent,
  or v1.6 goes out already stale.
- ⚠ `rifiutato` (24/09) is still unlabelled, and `DIV-07` (quote labels vs org) is still
  open. Neither is in v1.6.
- Who sends it, and in what form (a diff or the full document), is not decided.

## 2026-09-28 - the change set grew again, and one open flag above is discharged

🟢 **`rifiutato` is no longer unlabelled.** The client settled it at
[the 28/09 session](../meetings/2026-09-28%20Tema%20Contratti%20e%20Open%20Point.md):
the state stays **`Rifiutato`** and the reason becomes **`sostituito da altro
preventivo`** (replacing `per scelta altro preventivo`). See
[OI-59](OI-59%20Quote%20workflow%20configuration.md). ⚠ **`DIV-07` — the quote labels
against the org — is untouched and still open.**

🔴 **Four further client-agreed changes now belong in this change set**, all from
28/09 and none yet in the register:

| Change                                                                                                      | Register target                                    |
| ----------------------------------------------------------------------------------------------------------- | -------------------------------------------------- |
| Quote reason **`sostituito da altro preventivo`**; state `Rifiutato` unchanged                               | `state_machines.quote`, prose quote-state section  |
| **Contract is the customer's contractual history**, one per order, read across the Account                    | `ORD-05` ([OI-141](OI-141%20Contract%20object%20for%20Performance%20Plus%20orders.md)) |
| Contract fields `ordinato` / `fatturato` / `incassato`, manual **`data di attivazione`**, text `strategist` + `digital` | `ORD-05`                                           |
| **Performance Plus identified by Mexal `categoria articolo` `C10` / `C11`**                                   | no row exists ([OI-188](OI-188%20Performance%20Plus%20products%20are%20identified%20by%20the%20Mexal%20article%20category.md)) |

🟢 **And one boundary is now client-confirmed rather than ROMI-decided:** credit
notes and the wrong-payment correction are **Fase 2 with Fabrizio Paganelli's
agreement** ([OI-157](OI-157%20Credit%20notes%20and%20storni%20are%20unbuilt%20and%20undefined.md)).
That is a scope statement the client has made, and it belongs in whatever goes out.

⚠ **The register was NOT amended in this sweep and stays at v1.6.** Allocating a
requirement id for the article-category mechanism, and restructuring `ORD-05` for
the reversed Contract purpose, are **not a sweep's call** — and the note above
already says v1.6 goes out as one change set at UAT close. The UAT sessions
remaining before that close are now **30/09, 02/10, 05/10, 06/10 and 16/10**.
