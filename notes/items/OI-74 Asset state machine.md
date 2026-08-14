---
id: OI-74
type: open-item
status: open
owner: ROMI
org: ROMI
raised: 2026-08-06
updated: 2026-08-14
depends_on: [OI-75]
source: meetings/results/2026-08-06-chiusura-punti-aperti.md
requirement: BIG-05
---

# OI-74 - Asset state machine

Final as of 2026-08-06: **Ordinato → Disponibile → Assegnato → Utilizzato /
Non utilizzato**. Triggers and rationale are in
[the ticket lifecycle](../flows/The%20ticket%20lifecycle.md).

_Assegnato_ was nearly dropped when digital signature left the ticket flow —
with no signature there seemed to be no moment between "available" and "used".
Sabatino Rinaldi kept it for reporting: _"ci fa statistica per capire quante
persone hanno il biglietto nelle mani."_

⚠ **The set is incomplete — a sixth state exists and is not in the machine.**
Elena Spini's `PIENISSIMO - Project Status` document (6 August) specifies that a
credit note on an event product cancels the linked tickets by setting the asset
to **"rinuncia al servizio"** — see
[OI-54](OI-54%20Credit%20note%20flow.md). That state appears in no version of the
lifecycle recorded from the session. Add it before configuring the picklist, or
credit notes will have nowhere to put a cancelled ticket.

**Design agreed, build pending.** `Biglietto__c.Status__c` in UAT still carries
the old signature-era values — the 29 existing records read _In attesa firma_
and _Caricato_, states this machine does not contain. Reconfiguring the
picklist means deciding what happens to those records; they are development
data, so deletion is probably right, but say so rather than assume it.

Related: [the Biglietto build](../objects/The%20Biglietto%20build.md), and
[the object diverged from the approved proposal](../risks/Risk%20-%20the%20Biglietto%20object%20diverged%20from%20the%20approved%20proposal.md).
