---
id: OI-199
type: open-item
status: open
owner: Aurel Mrruku
with: Rexhina Hysi
org: ROMI
raised: 2026-10-01
updated: 2026-10-02
depends_on: [OI-197]
blocks: [OI-177, go-live]
severity: gating
requirement: BIG-06
source: notes/meetings/2026-10-01 Interna.md
---

# OI-199 - The ticket send flag fields are split across Asset and Order

**The three send-tracking fields specified on 01/10 were built the same evening,
but on two different objects: the flag went on `Asset`, the two write-back fields
went on `Order`. The Marketing Cloud selection query the document specifies
cannot be run against either object, and an order-level boolean cannot record a
per-participant send at all.**

## What was specified

[The logic document](../The%20agreed%20Asset%20and%20ticket%20send%20logic%20document.md),
section `Flusso Operativo`, points 3 and 4:

> `Ready_for_Ticket_Dispatch__c = TRUE AND Ticket_Sent__c = FALSE`

and, after the send, `Ticket_Sent__c = TRUE` plus `Ticket_Sent_Date__c`.

🔴 **The object was explicitly left open.** The document carries _"Oggetto per il
Flag: Asset ? da confermare con Aurel"_, and at
[the 01/10 Interna](../meetings/2026-10-01%20Interna.md) Aurel Mrruku said _"Può
essere su campaign, può essere su asset"_, Elena Spini _"esatto da capire."_ The
question was never answered; the fields were built anyway, hours later.

## What was built

`5b19caa` (Rexhina Hysi, _"all the changes dine today"_, 01/10 18:43 CEST),
merged to `DevMain` in `367799b` via PR **#73**. Verified at `DevMain` `618e646`:

| Field | Object | Type |
| --- | --- | --- |
| `Ready_for_Ticket_Dispatch__c` | 🟢 `Asset` | Checkbox |
| `Ticket_Sent__c` | 🔴 **`Order`** | Checkbox |
| `Ticket_Sent_Date__c` | 🔴 **`Order`** | DateTime |

`ParticipantRegistrationController.cls:524` already sets
`Ready_for_Ticket_Dispatch__c = true` on the Asset, so the write side is live.

## 🔴 Why this does not work

1. **The query cannot be written.** `Ready_for_Ticket_Dispatch__c` is on `Asset`
   and `Ticket_Sent__c` is on `Order`. Fabrizio Mastracci's selection needs both
   predicates on the records it sends for; as built it is a cross-object query
   from Marketing Cloud, which is what the internal review warned against.
2. **The granularity is wrong, and it is wrong in a way the client ruled on.**
   The send is **per participant** — each participant gets their own ticket at
   their own address, agreed at the
   [Post UAT](../meetings/2026-09-30%20Post%20UAT.md), and the client ruled at the
   [30/09 UAT](../meetings/2026-09-30%20UAT%20Biglietti%20Asset%20Campagne%20ed%20Eventi.md)
   that naming three of five sends three.
   **One boolean on the Order cannot express "three of these five have been
   sent."** The second send to the same order would find `Ticket_Sent__c` already
   `TRUE` and be suppressed, or clear it and re-send the first three.
3. **The de-duplication guarantee is lost.** The write-back exists specifically so
   a ticket is not sent again on following days. At order level it cannot do that
   job for a partially named order — which, after
   [OI-196](OI-196%20Whether%20tickets%20are%20sent%20when%20the%20buyer%20names%20only%20some%20participants.md),
   is the normal case rather than the exception.

## 🔑 This was predicted in writing, the same day, before it was built

The internal version of the logic document carries it as problem **#5**:

> _"Se il flag sta sul campaign member e `Ticket_Sent__c` sull'asset, la query di
> Fabrizio unisce due oggetti. **Suggerimento:** mettere i tre campi (Ready,
> Sent, Sent\_Date) sullo stesso oggetto."_

The document was posted to the marketing group DM at **12:17 CEST**. The fields
were committed at **18:43 CEST**. ⚠ The warning named the wrong second object —
it guessed campaign member, the build used `Order` — but the failure mode is the
one it described.

⚠ Aurel Mrruku declined to read that section in the morning call, and the section
was removed from the copy sent to the client.

## What it would take

Move `Ticket_Sent__c` and `Ticket_Sent_Date__c` onto `Asset` beside
`Ready_for_Ticket_Dispatch__c`. Nothing reads them yet — a repository grep finds
them only in their own field definitions and in the `Full_Permission` and
`Ticket_Asset_Management` permission sets — so the change is cheap **today** and
expensive once Marketing Cloud is configured against them.

🔴 **Fabrizio Mastracci is due the field spec on 02/10**
([01/10 Pre UAT](../meetings/2026-10-01%20Pre%20UAT.md)), and production goes out
**over the weekend of 03–04/10** with records created from Monday 05/10. If the
spec he receives names these fields as built, the marketing flow is configured
against the wrong object.

## Not the same as OI-197

[OI-197](OI-197%20The%20ticket%20send%20flag%20and%20the%20Inviato%20asset%20state%20are%20agreed%20and%20unbuilt.md)
is the contract and the pieces that do not exist — the Marketing Cloud query, the
transactional send, the write-back activity. This row is the one piece that
**does** exist and is on the wrong object.

## 🔴 2026-10-02 - unchanged, and the window has closed

Checked against `DevMain` at `6778b58`. **The three fields are exactly where they
were**: `Ready_for_Ticket_Dispatch__c` on `Asset`,
`Ticket_Sent__c` and `Ticket_Sent_Date__c` on `Order`. Nothing was moved, and no
decision was recorded anywhere in today's sources.

🔴 **The field spec for Fabrizio Mastracci was due today** and there is no sign of
it. The production deploy is **over the weekend 03–04/10**, from this branch, and
the internal PROD check that exists to let him finish the Marketing flows is
**Monday 05/10 10:00**. The window in which moving two fields was free is the one
that closes with that deploy.

🟢 **One hypothesis can be closed.** The last two traces carried
`Campi Oggetti, Flussi e Utenti Salesforce - Pienissimo.xlsx` as possibly holding
the answer to which object should carry the flags. It was read in full on 02/10 and
**it does not** — its `Asset` block lists four fields and none of them is a send
flag. See [the workbook note](../The%20Campi%20Oggetti%20Flussi%20e%20Utenti%20workbook.md).

🔑 **But the same workbook names a field that nobody has considered**:
`Campagna Figlia` carries **`Data invio automatico biglietti`**. A send date has had
a documented home on the edition since July, and the design that was built ignores
it. That is worth putting on the table alongside the Asset-versus-Order question
rather than settling the object in isolation.
