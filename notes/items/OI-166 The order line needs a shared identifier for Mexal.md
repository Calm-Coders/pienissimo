---
id: OI-166
type: open-item
status: in-progress
owner: Aurel Mrruku
with: Mirko Merendi
org: both
raised: 2026-09-22
updated: 2026-09-24
depends_on: [OI-143]
blocks: [OI-50]
source: notes/meetings/2026-09-22 Logiche Spacchettamento Righe.md
---

# OI-166 - The order line needs a shared identifier for Mexal

**The residue of
[OI-143](OI-143%20The%20tranche%20invoice%20date%20must%20be%20re-keyed%20by%20hand%20into%20Mexal.md)
once the date stopped being the join key.** Raised by Fabrizio Paganelli at
[the 11:22 session](../meetings/2026-09-22%20Logiche%20Spacchettamento%20Righe.md) and
taken to the vendor at
[Test Mexal](../meetings/2026-09-22%20Test%20Mexal.md) four hours later.

## The requirement

To know which tranche an incoming payment settles, Salesforce must walk
**scadenziario → invoice → order → order line**. The last hop needs an identifier both
systems hold. Salesforce's own id is 15 or 18 characters and **cannot travel**.

Fabrizio Paganelli:

> _"aggiungiamo un campo negli ordini dove ci sia un numero di riga ordine che possa
> essere trasferito a Mexal… perché se non facciamo così ci salta per aria tutto il
> castello e non riusciamo a tracciare la scadenza delle fatture incassate con il
> riferimento dell'ordine."_

His precedent: Zoho too has an 18-character order id **and** a separate order number
that is what actually reaches Mexal.

## What the vendor established

- **Mexal assigns its own order number**, progressive, returned on save.
- The invoice carries the order's **sigla + numero ordine**.
- The scadenziario carries **codice cliente, serie documento, numero documento, data
  documento** — the invoice key.
- `Rif_NR attuale`, the external-reference field, can hold a foreign id but is capped
  at **16 characters**.

🔴 **Aurel Mrruku decided to key on Mexal's order number and keep Mexal's numbering
standard**, rather than push a Salesforce number into `Rif_NR attuale` or mint a
10-character Salesforce numbering field.

## The gap that remains

⚠ **The two sessions do not close on the same object.** The morning agreed a *line*
identifier; the afternoon settled an *order* identifier. Mexal's invoice references the
**order**, and the scadenziario references the **invoice** — so which Salesforce order
**line** a payment settles is not yet established from either end. For a Plus order
that is n lines of the same article code, distinguishable only by due date, this is
exactly the case that matters.

## Open

- 🔴 **Establish the line-level hop explicitly with Mirko Merendi.** Mexal has a
  `numero riga ordine`; nothing in this sweep confirms it survives into the invoice or
  the scadenziario.
- 🔴 **Build the field.** Nothing in `force-app/` carries an order-line number for
  Mexal as at `cf9b6b6`.
- ⚠ Once settled, `ORD-02` and `ORD-03` need rewording — see
  [OI-143](OI-143%20The%20tranche%20invoice%20date%20must%20be%20re-keyed%20by%20hand%20into%20Mexal.md).

## ⚠ 2026-09-24 — the Business Blueprint states this as settled

`Business_Blueprint_Pienissimo.docx` §6.3, written 24/09 and due to the client on 25/09
([OI-179](OI-179%20The%20Business%20Blueprint%20goes%20to%20the%20client%20with%20unchecked%20points.md)):

> _"Aggancio Tranche ↔ Fattura Mexal. L'aggancio con il sistema Mexal è basato sul numero
> di riga d'ordine."_

and, on the return leg: Mexal updates payment status **per line**, and Salesforce marks a
tranche paid only when every line in it is paid in full.

⚠ **That is this note's open question, answered in a document rather than in a meeting.**
Nothing in the swept sources records the client, Mirko Merendi or Kreosoft agreeing that
the order line number is the shared key — and Mirko Merendi's 22/09 field list named the
invoice join as `sigla + numero ordine` and the scadenzario join as
`codice cliente, serie, numero, data documento`, neither of which is a line number.

🔴 **A statement in a client-facing blueprint is not the same as an agreement**, and the
section carries the author's own `● Check con Aurel` marker. **This row stays open.**
