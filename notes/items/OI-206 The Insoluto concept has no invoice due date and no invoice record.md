---
id: OI-206
type: open-item
status: open
owner: Aurel Mrruku
with: Elena Spini
org: ROMI
raised: 2026-10-02
updated: 2026-10-02
depends_on: [OI-141]
requirement: ORD-07
source: notes/The Business Blueprint delivered to the client.md
---

# OI-206 - The Insoluto concept has no invoice due date and no invoice record

**The Business Blueprint delivered to the client on 02/10 introduces `Insoluto` —
an invoice issued, unpaid, and past its due date — and commits to weekly and
monthly scheduled reports on it. When Elena Spini read the clause out at the
Pre-UAT the same evening, neither she nor Aurel Mrruku could say where the
invoice due date lives, or whether there is an invoice record at all.**

## The commitment, as delivered to the client

Business Blueprint §6.2, in the Contract block:

> _"Introduce il concetto di 'Insoluto': fattura emessa e non pagata con data di
> scadenza antecedente alla data del controllo, oggetto di report schedulati
> settimanali (a commerciali/amministrazione) e mensili (tranche in scadenza il
> mese successivo)."_

This matches the register's existing
[ORD-07](../../requirements/pienissimo-requirements.yaml) — a weekly overdue
report every Monday to Marco Montesi and administration — but goes further: it
adds the monthly forward-looking view and names the commercialista in the
discussion.

## 🔴 What the Pre-UAT established

Reading the clause aloud at
[the 02/10 Interna Pre-UAT Plus](../meetings/2026-10-02%20Interna%20Pre-UAT%20Plus.md),
Elena Spini and Aurel Mrruku worked through what it needs and found two holes:

- **The invoice due date.** Aurel Mrruku: _"data scadenza fattura. I don't know if
  we have it. Do we have data scadenza fattura?"_ He went looking and did not
  confirm it.
- **The invoice record itself.** Aurel Mrruku: _"the standard object or we haven't
  created at all … Can we use the standard one?"_ Elena Spini: _"I think that if
  I'm not wrong you have the object but you cannot use it."_ Left unresolved.

The due date does exist in the integration: `MexalScadenzarioSearchService` reads
`dt_sca_pg` per deadline and `MexalInvoiceOrderLineMappingService` matches on
`orderItemDueDate`. 🔴 But it is used transiently to pair a scadenziario row with
an order line — **nothing persists an invoice-level due date on a Salesforce
record**, so there is no field for a report to filter on.

## 🔴 And the reports were removed

The Performance Plus contract work the same day built, and then **removed on
request**, the reports attached to the contract. Elena Spini's own reaction to the
clause was _"schedule report and that's it … I don't mind about this. We need the
logic before everything on contratto at this point."_ So the Blueprint promises
scheduled reports that the repository has deliberately not built, and the thing
they would filter on does not exist.

## Dependency worth naming

Insoluto is defined on **payment state**, so it inherits
[OI-201](OI-201%20Ri.Ba.%20payments%20are%20read%20as%20unpaid%20because%20only%20P%20counts.md):
while `E` reads as unpaid, every Ri.Ba.-settled invoice past its due date would
appear on an insoluto report as a genuine default. ⚠ **A report that flags paying
customers as insolvent, sent weekly to commercials and the accountant, is worse
than no report.**

## What closing it looks like

A decision on where invoice-level data lives (standard `Invoice`, a custom object,
or fields on the order), then the due date persisted, then the two reports. None
of it is started. ⚠ The clause is in a document **carrying signature lines for
ROMI Srl and Pienissimo Srl**.
