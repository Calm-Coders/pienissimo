---
id: risk-biglietto-not-in-scm
type: risk
status: open
severity: high
owner: Aurel Mrruku
org: ROMI
raised: 2026-08-14
updated: 2026-08-14
source: force-app/main/default/classes vs org verification 2026-08-03
---

# Risk - the Biglietto Apex stack is not in source control

Six Apex classes are **Active in Pienissimo UAT and absent from
`force-app/`**: `BigliettoTriggerHandler`, `BigliettoDocuSignService`,
`BigliettoDocuSignQueueable`, `BigliettoPdfService`, `BigliettoPdfQueueable`,
`BigliettoPdfBatch`. So is the `DocuSign_Envelope_Id__c` field on
`Biglietto__c`.

The repository holds seven Apex classes; none of them is on that list. The org
verification of 2026-08-03 found all six Active, with DocuSign sending and PDF
generation "genuinely implemented" — roughly 270 lines of the most
integration-sensitive code in the project.

**What goes wrong.** A `sf project deploy start` from this repository does not
carry them. A scratch org or a fresh sandbox does not have them. Nobody can
review them, and if the UAT org is refreshed or the metadata is overwritten,
they are gone with no copy anywhere. The 2026-08-06 session made DocuSign
binding for quotes and contracts, so this code is on the critical path to
go-live.

**The fix is a retrieve, not a decision.** Pull the six classes and the field
into `force-app/` and commit, then keep them there. Doing so also makes
[OI-66](../items/OI-66%20No%20test%20classes%20for%20the%20Biglietto%20stack.md)
actionable — you cannot write tests for code you cannot see.

Related: [the Biglietto build](../objects/The%20Biglietto%20build.md),
[the build ahead of the record](../objects/The%20build%20ahead%20of%20the%20record.md).
