---
id: OI-230
type: open-item
status: open
owner: Aurel Mrruku
with: Fabrizio Mastracci
org: ROMI
raised: 2026-10-13
updated: 2026-10-13
depends_on: [OI-197, OI-199]
blocks: [go-live]
severity: gating
requirement: BIG-06
source: Salesforce flow error mail, 2026-10-13T12:39:42Z
---

# OI-230 - The ticket confirmation request flow queries a relationship name as a field

**A second customer-facing ticket flow is failing in production.
`Invio Richiesta conferma biglietto Flow` asks `Event_Invitation__c` for a column
called `Recipient_Contact__r` — the relationship name, not a field — so the query
is invalid and the element can never succeed. It is a deterministic failure, not
an intermittent one.**

🔴 **And it is not new. This same flow errored on 08/10 at version 1; it is now
version 7 and still failing, with the same upstream cause unfixed.** Six
revisions in five days moved the failure downstream without addressing it.

## 🔴 Two failures, five days and six versions apart

| | **2026-10-08 06:45:34Z** | **2026-10-13 12:39:42Z** |
| --- | --- | --- |
| Flow API name | `flow_701SW00000fouUCYAY_1791380294345` | **the same** |
| Version | **1** | **7** |
| Activation | Attivo | Attivo |
| Run as | `Tech Romi (005SW00000PV5Ja)` | **the same** |
| `$Record` at launch | `null` | `null` |
| Duration | 15 s | 16 s |
| `Get Campaign` | 🔴 _"Impossibile trovare i record"_ | 🔴 **identical** |
| then | `ASSEGNAZIONE: Imposta Step` → `LOOP: Loop Step` (`Esegui loop: null`, `Iterazione: 0`) → `PAUSA: Wait Step`, paused | `ASSEGNAZIONE: Imposta Step` → `PAUSA: Wait Step`, paused and resumed → `Get Invitation` |
| Reported error | mail ends at the pause; no error element named | 🔴 **hard SOQL error on `Recipient_Contact__r`** |

🔑 **The constant across both is `Get Campaign` finding nothing** — the very first
element, with `$Record = null`, in a flow whose API name is derived from a
campaign id. Between the two mails the `Loop Step` was removed and a second
`Get` was added, so the visible failure moved downstream **while the upstream
cause stayed exactly where it was.**

⚠ **The 08/10 occurrence was swept and logged** — it is cited in
[OI-225](OI-225%20The%20ticket%20dispatch%20flow%20sends%20to%20a%20null%20recipient%20and%20fails%20the%20asset%20write.md)
as _"a second mail of the same shape and the same org id … the 08/10 sweep logged
it without identifying the org"_ — **but no item was raised for it and nothing was
done.** That is the process finding here: a production flow error sat in the
record for five days as a footnote to another row.

## The 13/10 error

Flow error mail to `a.mrruku@romicompany.com`, **2026-10-13T12:39:42Z**. Aurel
Mrruku forwarded it to Fabrizio Mastracci and Elena Spini at **13:38:31Z**; no
reply is in any source this sweep can read. 🟢 **That forward is the first time
anyone is recorded reacting to this flow at all.**

> _Errore nell'elemento `Get_Records_2` (FlowRecordLookup)._
>
> `SELECT Id, Recipient_Contact__r, Order__c,`
> `^ ERROR at Row:1:Column:12 No such column 'Recipient_Contact__r' on entity`
> `'Event_Invitation__c'.`

🔑 **The field itself is not missing.** `Recipient_Contact__c` exists in source
control — `force-app/main/default/objects/Event_Invitation__c/fields/Recipient_Contact__c.field-meta.xml`
— and is referenced by the layout, two validation rules, `Full_Permission` and
`EventInvitationService` (lines 141-142, 195). **The flow asks for the `__r`
suffix where it needs `__c`.** A relationship name is not selectable on its own;
only a field through it (`Recipient_Contact__r.Name`) or the id field
(`Recipient_Contact__c`) is.

⚠ **So this cannot be a data condition or a race.** Every interview that reaches
`Get_Records_2` fails the same way, on every record, until the flow is edited.

🔑 **Two things here match OI-225 exactly:** a `Get` returning
_"Impossibile trovare i record"_ while the flow carries on, and a **`Wait Step`**
between the trigger and the fetch. That is the architecture
[Marketing described as built](../The%20marketing%20ticket%20send%20logics%20as%20written%20by%20Marketing.md)
— a fixed short wait, then a fetch of something rendered asynchronously.
**Two active production flows now share the pattern and both are failing.**

## 🔑 The flow is campaign-generated, and runs as Tech Romi

- **API name** `flow_701SW00000fouUCYAY_1791380294345` — the
  `flow_<CampaignId>_<timestamp>` shape Marketing Cloud Growth creates from a
  campaign. **Type:** `Flusso AutoLaunched`. **Version 7, Attivo.** ⚠ The
  embedded `701…` is a **Campaign id**, and `Get Campaign` is the element that
  finds nothing — worth checking whether the flow's own campaign still exists and
  is in scope for the running user.
- **Builder id** `301SW00000g5VW6`.
- 🔴 **`Utente corrente: Tech Romi (005SW00000PV5Ja)`** — the interview was
  started by **Tech Romi**, a ROMI user, not by a Pienissimo administrator. ⚠
  Same class of exposure as
  [OI-228](OI-228%20The%20nightly%20schedulers%20have%20no%20run-as%20user%20and%20the%20first%20run%20is%20imminent.md),
  now observed in a flow rather than a scheduled job, and with a named user.
- 🔴 **`force-app/main/default/flows/` is empty.** As with OI-225, this flow is
  **org-only**: it is not in source control, it cannot be diffed, and a metadata
  deploy will not carry the fix. Editing it is a manual org change.

## Which org

**`Organizzazione: Pienissimo srl (00Dbl000005BSMH)`**, host
`ability-customization-52152.my.salesforce.com`. See the evidence chain in
[OI-225](OI-225%20The%20ticket%20dispatch%20flow%20sends%20to%20a%20null%20recipient%20and%20fails%20the%20asset%20write.md#which-org-this-is):
this sweep treats it as **Pienissimo production**.

## Why it is gating

The **16/10 Marketing UAT** exists to test the ticket sends, go-live is
**21/10**, and this flow is one of the pieces
[OI-197](OI-197%20The%20ticket%20send%20flag%20and%20the%20Inviato%20asset%20state%20are%20agreed%20and%20unbuilt.md)
records as agreed. It is active in production and structurally incapable of
completing.

## Open

- 🔴 **Fix the field reference in `Get_Records_2`** — `Recipient_Contact__c`, or
  a field through `Recipient_Contact__r`. Owner: Aurel Mrruku. This is an org
  edit; nothing in the repository can carry it.
- 🔴 **Why `Get Campaign` finds nothing** — unchanged across version 1 and
  version 7, upstream of everything else, and the same symptom OI-225 shows.
  **This is the root cause to chase, not the SOQL error.** Unexplained in both
  rows for five days.
- ⚠ **Whether any participant received a broken or missing confirmation
  request.** Needs the org.
- ⚠ **Why the flow runs as Tech Romi**, and whether it should.
- ⚠ **How many interviews have failed.** Two mails are two interviews; the flow
  is on version 7, active, and only two error mails exist in the mailbox for it.
  **Whether that means two failures or two notifications is not established** —
  Salesforce suppresses repeat flow-error mail per version.
- ⚠ **Who revised it six times**, and against what. No commit can show it: the
  flow is not in source control.
