---
id: OI-74
type: open-item
status: open
owner: ROMI
org: ROMI
raised: 2026-08-06
updated: 2026-08-20
depends_on: [OI-75]
source: meetings/results/2026-08-06-chiusura-punti-aperti.md
requirement: BIG-17
---

# OI-74 - Asset state machine

Final as of 2026-08-06: **Ordinato → Disponibile → Assegnato → Utilizzato /
Non utilizzato**. Triggers and rationale are in
[the ticket lifecycle](../flows/The%20ticket%20lifecycle.md).

_Assegnato_ was nearly dropped when digital signature left the ticket flow —
with no signature there seemed to be no moment between "available" and "used".
Sabatino Rinaldi kept it for reporting: _"ci fa statistica per capire quante
persone hanno il biglietto nelle mani."_

## The list is six states, and the sixth is `Annullato`

[The newest design diagram](../The%20newest%20design%20diagram.md) —
`Flows & Objects.drawio`, modified **6 August 15:22**, the afternoon of the
closing session — gives the Asset Status list explicitly:

**`Ordinato` · `Disponibile` · `Assegnato` · `Utilizzato` · `Non utilizzato` ·
`Annullato`**

`Disponibile` is annotated _"Fattura pagata - a livello di tranche/rate"_, which
matches [OI-75](OI-75%20Ticket%20availability%20rule.md). The credit-note logic on
the Ordini page of the same diagram sets selected assets to **`Annullato`**.

**The requirement register already carries all six**, with transitions —
`Assegnato → Annullato` on _"name change (option 1) or credit note"_,
`Assegnato → Non utilizzato` three days after the event. Nothing needs
re-extracting here.

## 🔴 Reopened 2026-08-19 - a seventh box appeared, and it is not a synonym

[The 19 August ticket flow diagram](../The%20ticket%20flow%20diagram%20of%2019%20August.md)
draws the status row with **seven** boxes, not six:

**`Ordinato` · `Disponibile` · `Rinuncia` · `Assegnato` · `Utilizzato` ·
`Non utilizzato` · `Annullato`**

`Rinuncia` and `Annullato` are drawn as **separate boxes in the same row**, so
the ruling recorded above — that _rinuncia_ is loose prose for `Annullato` and
only `Annullato` should be configured — **can no longer be assumed**. The new
box is annotated _"Avviene nella comunicazione dei partecipanti o accetta o
rinuncia"_, which places it at a specific and different moment: the referent
declines **when asked for the participant list**, before any ticket is assigned.
`Annullato`'s recorded triggers are a name change or a credit note, both later.

Read at face value they are two different events, and the earlier reading — one
state, two names — was the reasonable inference from the evidence that existed
on 06 August. **Later evidence wins, but this evidence is a diagram with no
minute behind it**, so nothing is settled here.

### 🔴 Escalated 2026-08-20 - it is in the master now, not just a side file

`Flows & Objects.drawio` was re-decoded on **20 August at its
2026-08-20T15:36:24Z version** and the seven-box row **has been folded into the
master**, on the `Flusso Biglietti` page, with the same annotation. See
[the newest design diagram](../The%20newest%20design%20diagram.md).

That removes the one comfort in the 19 August reading. `Rinuncia` is no longer
confined to a standalone drawing that might have been a sketch — it now sits in
**the file the requirement register is checked against**, which is what
`BIG-17`'s six states are validated from. The register was still **not**
changed: nothing here is minuted, and a picklist is not reconfigured off an
unminuted drawing. But the gap between the register and its own source document
is now real, and it widens every day it is left.

**The ask is unchanged and one sentence long.** Elena Spini or Sabatino Rinaldi:
is `Rinuncia` a seventh state, or another name for `Annullato`?

**This is a human decision and must not be inferred.** Elena Spini drew it; she
or Sabatino Rinaldi can say in one sentence whether `Rinuncia` is a seventh
state to configure or a label for the same outcome. Until then **do not
reconfigure the picklist** — building six or building seven are different
migrations, and the 29 existing UAT records are already stranded on the old
signature-era values.

⚠ The naming outlier is the prose: Elena's `PIENISSIMO - Project Status.docx`
and [the client's June document](../The%20client%20June%20requirements%20document.md)
both call the state **"rinuncia al servizio"**. **Configure `Annullato`** — the
diagram and the register agree — and correct the prose. See
[OI-54](OI-54%20Credit%20note%20flow.md).

**It is not a late addition.** _Rinuncia al servizio_ is a Pienissimo
requirement from **11 June 2026**, in
[their own requirements document](../The%20client%20June%20requirements%20document.md),
owned by Fabrizio Paganelli: the inverse flow for a client who withdraws from a
service already partly invoiced. It has been outside the tracker for two months.

**Design agreed, build pending.** `Biglietto__c.Status__c` in UAT still carries
the old signature-era values — the 29 existing records read _In attesa firma_
and _Caricato_, states this machine does not contain. Reconfiguring the
picklist means deciding what happens to those records; they are development
data, so deletion is probably right, but say so rather than assume it.

Related: [the Biglietto build](../objects/The%20Biglietto%20build.md), and
[the object diverged from the approved proposal](../risks/Risk%20-%20the%20Biglietto%20object%20diverged%20from%20the%20approved%20proposal.md).
