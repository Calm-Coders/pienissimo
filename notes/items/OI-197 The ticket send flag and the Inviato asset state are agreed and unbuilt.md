---
id: OI-197
type: open-item
status: open
owner: Aurel Mrruku
with: Fabrizio Mastracci
org: ROMI
raised: 2026-09-30
updated: 2026-10-05
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

| Piece                                                                 | Owner              | Built? |
| --------------------------------------------------------------------- | ------------------ | ------ |
| Boolean flag → `true` on confirmation of **at least one** participant | Aurel Mrruku       | 🔴 no  |
| Marketing Cloud query intercepting records with the flag set          | Fabrizio Mastracci | 🔴 no  |
| Transactional send, per participant, to the participant's own address | Fabrizio Mastracci | 🔴 no  |
| Write-back field on the asset after the send, to stop re-sends        | Fabrizio Mastracci | 🔴 no  |
| `Inviato` asset state, written **as soon as the record is modified**  | Aurel Mrruku       | 🔴 no  |

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

## 🔑 2026-10-01 - the written document arrived, and two pieces of this row changed

[The specification this row was deferred on now exists](../The%20agreed%20Asset%20and%20ticket%20send%20logic%20document.md).
Elena Spini wrote it overnight, reviewed it with Aurel Mrruku at
[the 01/10 Interna](../meetings/2026-10-01%20Interna.md) and mailed it to the
client at 18:25Z. **The deferral recorded above is lifted.**

Two substantive changes to the contract as this row recorded it:

- 🔴 **`Inviato` was dropped.** Aurel Mrruku re-offered the eighth state; Elena
  Spini declined it — _"No, sì, sì, più che assegnato. Va bene, chi se ne frega.
  Assegnati."_ It is absent from both versions of the document. Tracking moved to
  `Ticket_Sent__c` plus `Ticket_Sent_Date__c` on top of `Assegnato`.
  ⚠ **This reverses the 30/09 Post UAT agreement after one day, between the same
  two people, and neither named it as a reversal.** The `Inviato` row in the
  table above is therefore superseded, not outstanding.
- 🟢 **The flag has a name and is built**: `Ready_for_Ticket_Dispatch__c` on
  `Asset`, written by `ParticipantRegistrationController.cls:524`.
  🔴 **The two write-back fields were built on `Order`** — a separate defect,
  [OI-199](OI-199%20The%20ticket%20send%20flag%20fields%20are%20split%20across%20Asset%20and%20Order.md).

### Re-verified against `DevMain` `618e646` (01/10 18:54 CEST)

| Piece                                            | Built?                                                                                                                                           |
| ------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------ |
| Flag on confirmation of at least one participant | 🟢 **yes** — `Asset.Ready_for_Ticket_Dispatch__c`, and the controller sets it                                                                    |
| Marketing Cloud query on the flag                | 🔴 no                                                                                                                                            |
| Per-participant transactional send               | 🔴 no                                                                                                                                            |
| Write-back after the send                        | ⚠ fields exist, **on the wrong object** — [OI-199](OI-199%20The%20ticket%20send%20flag%20fields%20are%20split%20across%20Asset%20and%20Order.md) |
| `Inviato` asset state                            | ⬛ **withdrawn** — `AssetStatus` still carries seven values, and an eighth is no longer wanted                                                   |

### 🟢 The spec now has a date

Aurel Mrruku's action item to give Fabrizio Mastracci the field specification is
recorded at [the 01/10 Pre UAT](../meetings/2026-10-01%20Pre%20UAT.md) as
**due 02/10**. This row's _"neither action item carries a date"_ no longer holds
for his side.

🔴 **Production deploys over the weekend of 03–04/10**, with records created in
production from Monday 05/10, so the object question in
[OI-199](OI-199%20The%20ticket%20send%20flag%20fields%20are%20split%20across%20Asset%20and%20Order.md)
has to be settled before that deploy, not after.

## 2026-10-05 - write-back fields moved to Asset

`Ticket_Sent__c` and `Ticket_Sent_Date__c` now exist on `Asset` in source and in Prod
(`0AfSW000001HiiP0AS`), next to `Ready_for_Ticket_Dispatch__c`. See
[OI-199](OI-199%20The%20ticket%20send%20flag%20fields%20are%20split%20across%20Asset%20and%20Order.md).
The Marketing Cloud query, the transactional send and the write-back activity itself
are still unbuilt on the Marketing Cloud side.
