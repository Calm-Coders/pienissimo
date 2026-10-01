---
id: OI-197
type: open-item
status: open
owner: Aurel Mrruku
with: Fabrizio Mastracci
org: ROMI
raised: 2026-09-30
updated: 2026-09-30
depends_on: [OI-126, OI-74, OI-198]
blocks: [OI-177]
requirement: BIG-06
source: notes/meetings/2026-09-30 Post UAT.md
---

# OI-197 - The ticket send flag and the Inviato asset state are agreed and unbuilt

**The Salesforce-to-Marketing-Cloud send contract was settled in detail at the
30/09 Post UAT: a boolean flag Salesforce sets on participant confirmation, a
Marketing Cloud query on that flag, a transactional send, and a write-back to an
`Inviato` asset state. None of the three pieces exists in `force-app`, and the
marketing flow Fabrizio Mastracci has to build depends on all of them.**

## The contract

| Piece | Owner | Built? |
| --- | --- | --- |
| Boolean flag → `true` on confirmation of **at least one** participant | Aurel Mrruku | 🔴 no |
| Marketing Cloud query intercepting records with the flag set | Fabrizio Mastracci | 🔴 no |
| Transactional send, per participant, to the participant's own address | Fabrizio Mastracci | 🔴 no |
| Write-back field on the asset after the send, to stop re-sends | Fabrizio Mastracci | 🔴 no |
| `Inviato` asset state, written **as soon as the record is modified** | Aurel Mrruku | 🔴 no |

Elena Spini's recap (`01:06:17`): the link from `Event_Invitation__c` leads to the
compilation page, and on confirmation of at least one participant's data Aurel
Mrruku must set a boolean flag to `true` for the ticket send. Fabrizio Mastracci
and Aurel Mrruku agreed Marketing Cloud runs a query to intercept records updated
with that flag active (`01:07:56`).

🔑 **"At least one" is the trigger, not "all".** That is the direct consequence of
the client's ruling the same afternoon — see
[OI-196](OI-196%20Whether%20tickets%20are%20sent%20when%20the%20buyer%20names%20only%20some%20participants.md).

## The send is transactional, and that was a decision

Elena Spini raised the Marketing Cloud credit cost of immediate sends against a
nightly batch. Fabrizio Mastracci: a QR ticket needs no branching logic, it is a
transactional email fired as soon as a record is updated with the flag to `true`.
The room agreed to **immediate transactional sending, eliminating the nightly
processing** (`01:14:05`–`01:16:02`).

⚠ **The volume objection was answered with an architecture, not a measurement.**
Aurel Mrruku worried about Salesforce updating thousands of records a day
(`00:36:02`); the answer was Data Cloud datagraphs and real-time queries. Nobody
put a number on it.

## Verified against the repository

At `DevMain` `0b6b828` (30/09 12:32 CEST):

- `AssetStatus.standardValueSet` carries **seven** values —
  `Ordinato · Disponibile · Rinuncia · Assegnato · Utilizzato · Non utilizzato ·
  Annullato`. **`Inviato` is absent.**
- `Asset` carries `Anno_Competenza__c`, `Campaign__c`, `Data_CheckIn__c`,
  `Fattura_Pagata__c`, `Fattura_Rif__c`, `Fonte_Acquisto__c`,
  `Order_Product__c`, `QR_Id__c`. **No send flag and no sent-timestamp field.**
- `Fattura_Pagata__c` is a checkbox described as _"Set when the payment/invoice
  confirmation arrives from the accounting flow"_ — invoice-level, **not** the
  per-tranche granularity the client required. See
  [OI-198](OI-198%20The%20asset%20does%20not%20say%20which%20tranche%20paid%20for%20it.md).

## 🔴 What makes this gating

- **Aurel Mrruku committed the data structures to production for Monday 05/10**
  (`01:03:47`), and `PIENISSIMO - Interna Check PROD per MKT` is booked 05/10
  09:30 ([OI-177](OI-177%20The%20marketing%20flow%20UAT%20needs%20production.md)).
  Marketing cannot be configured against structures that are not there.
- **Fabrizio Mastracci is blocked on the spec.** His own UAT action item is to
  update the flow to intercept the single ticket row on the new criterion, and
  Aurel Mrruku's is to _"fornire le specifiche tecniche e le indicazioni sul campo
  del biglietto"_. 🔴 **Neither action item carries a date.**
- **Marketing UAT is 16/10.**

## 🔴 Deferred by name

The **filtering criteria for paid tickets inside the nominativi link** is the one
item the Post UAT files under `Da approfondire`, deferred _"in attesa di
istruzioni scritte definitive"_. **Elena Spini owes that document** — her action
item is to define the agreed flow in writing and share it with the team.

Until it exists, the flag's read side is specified only by a meeting recording.

## ⚠ Not the same as OI-126

[OI-126](OI-126%20An%20asset%20flag%20for%20incomplete%20participant%20data.md) asks
how Marketing Cloud **queries completeness** for the reminder ladder. This row is
the **send** trigger and the send's write-back. The 30/09 sessions answered this
one and left OI-126's aggregate — tickets held versus tickets completed, per
contact per campaign — still unplaced.
