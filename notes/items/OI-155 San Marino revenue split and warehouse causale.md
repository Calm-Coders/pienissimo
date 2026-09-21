---
id: OI-155
type: open-item
status: open
owner: Fabrizio Paganelli
with: Mirko Merendi
org: both
raised: 2026-09-18
updated: 2026-09-21
depends_on: [OI-144]
source: notes/meetings/2026-09-18 Data Model Parte 6.md
---

# OI-155 - San Marino revenue split and warehouse causale

Raised by Fabrizio Paganelli at
[Data Model Parte 6](../meetings/2026-09-18%20Data%20Model%20Parte%206.md)
(`00:14:47`, `00:16:13`), tracing the order flow from the CRM through the warehouse
to Mexal's prima nota.

**San Marino fiscal law requires sales revenue to be split between Italy, San
Marino and abroad.** The split is compulsory, and the **warehouse-movement causale
must be tracked correctly** so the revenue lands on the right accounts in the prima
nota.

⚠ Distinct from the 16/09 ruling that **San Marino has no VAT** and Mexal uses
fixed exemption codes ([Data Model Parte 5](../meetings/2026-09-16%20Data%20Model%20Parte%205.md)).
That was about VAT; this is about revenue classification. **Not a contradiction.**

## What is known about the causale

From Mirko Merendi's 11 August answers, re-read at
[the 21/09 Mexal internal](../meetings/2026-09-21%20Interna%20Temi%20Mexal.md):

- On `scoperto clienti`, **only causale `F` applies**.
- **The causale in use is `1`; for testing, `10`.** This is the origin of the
  _"cambiare il valore del codice da 1 a 10"_ action item from the pre-UAT session.

Neither statement addresses the Italy / San Marino / abroad split.

## Open

- 🔴 **The accounting mapping session is the deliverable.** The Parte 6 action item
  reads: Fabrizio Paganelli, Elena Spini and Aurel Mrruku to meet **Mirko Merendi**
  to analyse the data flow to Mexal and define the traceability of warehouse
  causali and accounting accounts for the prima nota. ✅ **Booked: `Test Mexal`,
  22/09 15:00–17:00**, with `mirko@kreosoft.com` on the invitation. Fabrizio
  Paganelli undertook to contact him by mail.
- 🔴 **Nothing in the record says how Salesforce classifies a sale by destination**,
  nor which field carries it on the order payload.
- ⚠ **[OI-144](OI-144%20Bundles%20must%20be%20split%20into%20order%20lines%20for%20Mexal.md)
  interacts with this.** If a bundle becomes n order lines, it becomes n warehouse
  movements. Fabrizio Paganelli's concern about movement structure and Elisa
  Migliano's 18/09 objection to child products are the same worry.
- ⚠ No register row covers the revenue split.
