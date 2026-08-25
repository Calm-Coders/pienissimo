---
id: OI-75
type: open-item
status: open
owner: ROMI
with: Elisa Migliano
org: both
raised: 2026-08-06
updated: 2026-08-24
depends_on: [OI-50]
source: meetings/results/2026-08-06-chiusura-punti-aperti.md
---

# OI-75 - Ticket availability rule

**A ticket becomes available when the tranche invoice carrying its order line
is paid in full.** Partial payment releases nothing. This supersedes every
earlier wording.

The tranche is defined earlier on the Quote: the user selects its Quote Line
Items and supplies the payment due date. The tranche reference and date then
propagate to the corresponding Order Items. Each tranche is invoiced
separately, so per-event release comes out of tranche-level invoicing —
[OI-50](OI-50%20Tranche%20object.md).

⚠ **Tranche composition follows customer payment convenience, not events.** An
event's ticket can sit behind unrelated items in the same invoice. There is no
way to release by event.

**The invoice must arrive in Salesforce, and the match is on `numero di riga
d'ordine`.** Two other candidate keys were killed in session by
[Elisa Migliano](../people/Elisa%20Migliano%20-%20Pienissimo%20administration.md):
**by date**, because the tranche date is a presumed collection date and they
invoice in advance; and **by product**, because _"un tutor può mettere anche lo
stesso codice due volte nello stesso ordine."_

🔴 **The key this rule depends on is not in the integration mapping.**
`Integrazioni pienissimo.xlsx` — Kreosoft's field mapping, opened 2026-08-14 —
defines the **Get Fatture** target structure as `numero_fattura`,
`data_fattura`, `codice_cliente`, `codice_agente`, `note_testata`,
`codice_prodotto`, `quantita`, `prezzo_unitario`, `sconto`, `totale_riga`,
`aliquota_iva`, `codice_pagamento` and **`numero_ordine`** — documented as
`serie_ordine/numero_ordine`.

**There is no order _line_ number in it.** The rule agreed on 2026-08-06 matches
on _numero di riga d'ordine_ because Elisa killed the two alternatives; the
mapping delivers only the order number, which cannot separate two lines of the
same order — and she killed by-product precisely because a tutor can put the
same code twice on one order.

The data exists at source: Mirko Merendi's two-step retrieval returns _"l'elenco
completo dei campi anche le righe"_ per document. So this is a **mapping gap,
not a Mexal limitation** — the line number must be added to the Get Fatture
target structure before the release rule can be built. **Raise it at the
27 August call**; until then treat ticket release as unimplementable as
specified.

`Get Scoperto` is the better-shaped payment-state source: it carries
`numero_ordine`, `data_scadenza`, `codice_causale` (take only **FE**) and
`stato_pagamento` (`P` = paid, empty = unpaid). See
[the Mexal integration](../flows/The%20Mexal%20integration.md).

## 2026-08-24 - confirmed by the client, with the ordering constraint spelled out

The [19 August MKT session](../meetings/2026-08-19%20Flussi%20MKT%20Biglietti.md) put this on the record as an agreed decision:
**ticket availability is subordinate to payment of the corresponding order
tranche, in chronological order.**

Elena Spini and Elisa Migliano worked the case explicitly: where an order carries
several tranches, a ticket becomes available only when its own instalment is
paid, and **failure to pay an earlier instalment blocks access to the later
events**. So the rule is not "this tranche paid" but "this tranche and every
tranche before it".

The [20 August session](../meetings/2026-08-20%20Flusso%20Asset%20Biglietti.md) then confirmed the correction path when an
instalment is booked against the wrong invoice — see
[OI-91](OI-91%20Aggiornamento%20Incasso%20button.md) and
[OI-92](OI-92%20Mexal%20Scadenziario%20as%20the%20trigger%20to%20reverse%20an%20asset.md).

The ordering constraint is the part most likely to be missed in implementation:
it makes availability a function of the whole payment history of the order, not
of one tranche's status.
