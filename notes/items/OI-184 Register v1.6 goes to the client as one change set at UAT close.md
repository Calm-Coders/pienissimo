---
id: OI-184
type: open-item
status: open
owner: Aurel Mrruku
with: Elena Spini
org: both
raised: 2026-09-25
updated: 2026-09-30
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

## 2026-09-30 - the Biglietti UAT this note was waiting for happened, and it reversed two register-adjacent rulings

The open flag above names **"Biglietti 30/09"** as one of the sessions whose changes
must join this set before it is sent. It ran. **Four client-agreed changes come out
of it, and two of them are reversals rather than additions** — which makes them more
important to the change set than ordinary increments, because the current text says
the opposite.

| Change | Register target | Agreed at |
| --- | --- | --- |
| **Ticket send on partial naming**: the named tickets are sent, the unnamed stay `Disponibile` and are burned near the event. **Reverses** the all-or-nothing rule ROMI agreed internally on 29/09 | `BIG-06`, and the funnel prose ([OI-196](OI-196%20Whether%20tickets%20are%20sent%20when%20the%20buyer%20names%20only%20some%20participants.md)) | UAT 30/09 |
| **Nothing is sent — ticket, QR or nomination request — until that tranche's invoice is paid and collected**, per tranche inside a bundle order, stated as an inderogable administrative directive | `BIG-17` / `BIG-06`, `Disponibile`'s definition ([OI-74](OI-74%20Asset%20state%20machine.md), [OI-75](OI-75%20Ticket%20availability%20rule.md)) | UAT 30/09 |
| **The mapping window is the campaign's `data inizio` / `fine competenza`**, not the event dates — and consequently **one order can no longer span two editions**. **Reverses** the per-order-line resolution confirmed by the same person on 26/08 | `BIG-13`-adjacent / the mapping-table prose ([OI-96](OI-96%20Edition%20mapping%20table%20on%20Salesforce.md)) | UAT 30/09 |
| **The rinuncia button is hidden once the first ticket is named** | the funnel prose ([OI-196](OI-196%20Whether%20tickets%20are%20sent%20when%20the%20buyer%20names%20only%20some%20participants.md)) | UAT 30/09 |

🔴 **The register was not amended tonight, and the version stays 1.6.** Two reasons,
both of them this note's own rules:

1. **This note is the mechanism** — v1.6 goes to the client as one reviewed change
   set at UAT close, not one row at a time during UAT. A nightly sweep adding
   contract-bound text to `REQUISITI.it.md`, which is the document the client signs,
   is not that review.
2. **A reversal needs a human to confirm it is a reversal.** Neither the mapping
   change nor the send-rule change was acknowledged in the room as overturning an
   earlier agreement, and the 26/08 per-order-line ruling was confirmed by the same
   client representative who overturned it. That reconciliation belongs to the
   review, not to a sweep.

⚠ **`Inviato` is deliberately excluded from the table above.** It was agreed at the
ROMI-internal Post UAT, not with the client, and the register already carries a
worked precedent for exactly this: `BIG-17`'s inline comment refuses the seventh
`Rinuncia` box because the edit was unminuted. An eighth state from an internal
session is weaker evidence than that, not stronger. It is tracked as a build item in
[OI-197](OI-197%20The%20ticket%20send%20flag%20and%20the%20Inviato%20asset%20state%20are%20agreed%20and%20unbuilt.md).

⚠ **The set is now large enough to be a risk in itself.** v1.6 was drawn on 25/09
with five changes; it has since taken four from 28/09 and four more from 30/09, with
**WooCommerce 02/10, Performance Plus / Contratto 05/10, Mexal 06/10 and marketing
16/10 still to come**, against an approval due ~13/10. 🔴 **`DIV-07` is still open**,
and **who sends it and in what form is still undecided** — with under two weeks left.
