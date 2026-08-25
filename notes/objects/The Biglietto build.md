---
id: obj-biglietto
type: object
status: in-progress
owner: ROMI
org: ROMI
updated: 2026-08-25
source: meetings/open-items.md org verification 2026-08-03
requirement: BIG-03
---

# The Biglietto build

`Biglietto__c` is the custom object that reproduces Zoho's "magazzino
biglietti" — one record per ticket. It is live in UAT and partly in the
repository.

**In `force-app/`:** the object with twelve fields — `Status__c`, `QR_Id__c`,
`Data_Firma__c`, `Data_CheckIn__c`, `Fattura_Pagata__c`, `Fattura_Rif__c`,
`Anno_Competenza__c`, `Fonte_Acquisto__c`, and lookups to Campaign, Contact,
Product and Order Product — plus `OrderBigliettoTrigger` and its handler and
test class, which create tickets when an order is confirmed.

**In the org but not in `force-app/`:** `BigliettoTriggerHandler`,
`BigliettoDocuSignService`, `BigliettoDocuSignQueueable`, `BigliettoPdfService`,
`BigliettoPdfQueueable`, `BigliettoPdfBatch`, and the
`DocuSign_Envelope_Id__c` field. See
[the source-control risk](../risks/Risk%20-%20the%20Biglietto%20Apex%20stack%20is%20not%20in%20source%20control.md).

**This is now a legacy UAT implementation, not the target data model.**
`meetings/proposals/2026-07-13-asset-ticket-data-model.md`
([OI-41](../items/OI-41%20Asset%20and%20ticket%20data%20model.md)) specified the
**standard Asset** object. A custom object was built instead. On 2026-08-24 the
object choice was resolved in favour of standard Salesforce Asset; the direct
instruction did not name the decision-maker.

No Asset replacement or migration is built yet. ROMI must map the twelve known
fields, relationships, order-trigger behaviour and the six org-only Apex
classes to Asset, then decide what to migrate, rewrite or retire. Until that is
done, `Biglietto__c` remains the actual UAT implementation and the divergence
risk remains open.

Two things are settled and not yet built into it: the
[state machine](../flows/The%20ticket%20lifecycle.md) agreed on 2026-08-06
([OI-74](../items/OI-74%20Asset%20state%20machine.md)) and the
[availability rule](../items/OI-75%20Ticket%20availability%20rule.md) that keys
release to a fully paid tranche invoice.

The stack has **no test coverage at all** —
[OI-66](../items/OI-66%20No%20test%20classes%20for%20the%20Biglietto%20stack.md) —
and has [never run end to end](../risks/Risk%20-%20the%20ticket%20lifecycle%20has%20never%20run%20end%20to%20end.md).

## 2026-08-25 - org check: the data confirms it has never run

Verified read-only against **Pienissimo UAT**.

**37 `Biglietto__c` records exist**, and every one is stalled before release:

| `Status__c`       | Records |
| ----------------- | ------- |
| `In attesa firma` | **30**  |
| `Caricato`        | 7       |

**Zero tickets have reached `Disponibile`**, `Emesso` or `Utilizzato`. The 30
sitting in `In attesa firma` are waiting on a digital signature step that was
**struck from the design on 2026-08-06** — they are parked against a state the
agreed lifecycle deletes, and nothing will ever move them.

The org-only Apex list in this note is confirmed unchanged, last modified
2026-07-22. Add to it, previously unrecorded: the `Biglietto__c` **custom tab**,
the **Biglietto Layout**, and the `DocuSign`, `Full_Permission` and `Sales_User`
**permission sets**, none of which are in `force-app/`.

The twelve fields are confirmed; the org additionally holds
`DocuSign_Envelope_Id__c` as this note already records.

This strengthens rather than changes the conclusion: `Biglietto__c` is a legacy
UAT implementation of a superseded design, holding 37 records that would all
have to be re-stated under the four agreed states before they could migrate to
standard Asset — which itself carries
[zero custom fields](../items/OI-41%20Asset%20and%20ticket%20data%20model.md).
