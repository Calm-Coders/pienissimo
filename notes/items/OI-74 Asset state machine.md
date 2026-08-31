---
id: OI-74
type: open-item
status: open
owner: ROMI
org: ROMI
raised: 2026-08-06
updated: 2026-08-26
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

## 2026-08-24 - evidence on `Rinuncia`, but still no ruling

The [19 August MKT session](../meetings/2026-08-19%20Flussi%20MKT%20Biglietti.md) is the first minuted discussion of _rinuncia_,
and it describes it as a **funnel concept, not an asset status**:

- It is one of the marketing tags — **`rinuncia`, `iscritto`, `presente`** — used
  to drive segments, alongside post-event uses such as surveys to attendees and
  targeted offers to those who declined.
- The **decline link** in the funnel exists to remove the contact from subsequent
  communications immediately.
- Rebecca Marmo is minuted saying the decline applies to **the whole
  participation — all associated tickets** — not to one ticket.

That last point cuts against `Rinuncia` being a per-Asset status, since Asset
status is per-ticket. But **nobody put the question in those terms**, so this is
evidence, not a ruling.

The same session narrates the asset states as `ordinato` → `pagato` /
disponibile → `assegnato` → `utilizzato`, with `annullato` on a name-change
request and an automatism **three days after the event** moving unscanned tickets
to `non utilizzato`. **`Rinuncia` is not in that list** — while
[the master diagram](../The%20newest%20design%20diagram.md) still draws it as a box annotated _"Avviene nella
comunicazione dei partecipanti o accetta o rinuncia"_.

**Still open, and still blocking.** The diagram and the minute now disagree, so
the question is sharper than before rather than closed: is `Rinuncia` a seventh
Asset status, another name for `Annullato`, or a marketing tag that never touches
the Asset record? Build nothing until someone rules.

## 2026-08-25 - org check: the configured states are the pre-06-August design

Verified read-only against **Pienissimo UAT**. `Biglietto__c.Status__c` carries
**nine values**, and they are not the agreed four:

`Caricato · Disponibile · In attesa partecipante · In attesa firma · Firmato ·
Emesso · Utilizzato · No Show · Annullato`

Against [the agreed lifecycle](../flows/The%20ticket%20lifecycle.md) —
`Ordinato → Disponibile → Assegnato → Utilizzato / Non utilizzato`:

| Agreed 2026-08-06 | In the org                                                        |
| ----------------- | ----------------------------------------------------------------- |
| `Ordinato`        | 🔴 absent — `Caricato` occupies the entry slot                    |
| `Disponibile`     | present                                                           |
| `Assegnato`       | 🔴 absent — `In attesa partecipante` / `Emesso` may be the intent |
| `Utilizzato`      | present                                                           |
| `Non utilizzato`  | `No Show`                                                         |

🔴 **`In attesa firma` and `Firmato` are still configured, and they were struck
outright on 2026-08-06** when digital signature left the ticket flow. They are
not dormant: **30 of the 37 tickets in UAT sit in `In attesa firma`**, with the
other 7 in `Caricato`. Every ticket in the org is parked in a state the agreed
design deletes, and none has ever reached `Disponibile`.

`Rinuncia` — the seventh state drawn on
[the 19 August diagram](../The%20ticket%20flow%20diagram%20of%2019%20August.md)
and never minuted — is **not** configured. The build has not promoted the
drawing into a decision, which is correct.

This state machine has to be rebuilt on standard **Asset** in any case
([OI-41](OI-41%20Asset%20and%20ticket%20data%20model.md)), where `Status` today
holds stock Salesforce values and nothing else. So the question is not how to
correct these nine values but which four to configure on the target object.

## 2026-08-26 - re-verified, unchanged

Re-checked read-only against **Pienissimo UAT**, this time with Tooling
`FieldDefinition` rather than `sf sobject describe`, so the reading is not
affected by field-level security. Nothing moved.

`Biglietto__c.Status__c` still carries the same nine values. Still **30 of 37
tickets in `In attesa firma`**, 7 in `Caricato`, **0 ever `Disponibile`**, and
**0 QR codes generated**. `Rinuncia` is still not configured.

Standard **Asset** still carries **zero custom fields** — confirmed against
`FieldDefinition`, so this is not an FLS artefact — and holds **one record**,
named `Test`, with an empty `Status`.

⚠ One number in the paragraphs above needs reading with care: the 2026-08-20
section says _"the 29 existing UAT records"_. That was the count on 20 August;
it has been **37** since 25 August. The argument it supports — that
reconfiguring the picklist means deciding what happens to the stranded records —
is unaffected, and the queue is eight records longer.

The migration this note defers to is **cheaper to do now than it will ever be**,
and there is a worked example one object away:
[OI-59](OI-59%20Quote%20workflow%20configuration.md) records `Quote.Status`
being replaced on 26 August with the agreed Italian values while three of its
four records were left sitting on deactivated ones. Same operation, four records
instead of thirty-seven.
