---
id: obj-biglietto
type: object
status: in-progress
owner: ROMI
org: ROMI
updated: 2026-08-15
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

**The build diverged from the design that was proposed.**
`meetings/proposals/2026-07-13-asset-ticket-data-model.md`
([OI-41](../items/OI-41%20Asset%20and%20ticket%20data%20model.md)) specified the
**standard Asset** object. A custom object was built instead. The decision was
never minuted, and the recaps still describe the lifecycle in terms of assets.

Two things are settled and not yet built into it: the
[state machine](../flows/The%20ticket%20lifecycle.md) agreed on 2026-08-06
([OI-74](../items/OI-74%20Asset%20state%20machine.md)) and the
[availability rule](../items/OI-75%20Ticket%20availability%20rule.md) that keys
release to a fully paid tranche invoice.

The stack has **no test coverage at all** —
[OI-66](../items/OI-66%20No%20test%20classes%20for%20the%20Biglietto%20stack.md) —
and has [never run end to end](../risks/Risk%20-%20the%20ticket%20lifecycle%20has%20never%20run%20end%20to%20end.md).
