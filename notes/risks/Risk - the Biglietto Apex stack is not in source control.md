---
id: risk-biglietto-not-in-scm
type: risk
status: open
severity: high
owner: Aurel Mrruku
org: ROMI
raised: 2026-08-14
updated: 2026-08-25
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

## 2026-08-25 - org check: still true, and it now has a second instance

Verified read-only against **Pienissimo UAT**. All seven Biglietto components
are still org-only, unchanged since 2026-07-22: `BigliettoTrigger`,
`BigliettoTriggerHandler`, `BigliettoDocuSignService`,
`BigliettoDocuSignQueueable`, `BigliettoPdfService`, `BigliettoPdfQueueable`,
`BigliettoPdfBatch`, and the `DocuSign_Envelope_Id__c` field. Also org-only and
never noted: the `Biglietto__c` custom tab, the `Biglietto Layout`, and the
`DocuSign`, `Full_Permission` and `Sales_User` permission sets.

🔴 **The pattern repeated on 2026-08-25 with the tranche build.**
`QuoteTrancheController`, the `quoteCreateTranche` LWC, the `Quote.Crea_Tranche`
quick action, `Tranche__c.Importo_Previsto__c`, `Tranche__c.Sequenza__c`, the
`Tranche_Management` permission set and the Tranche layout are **in the org and
not in `force-app/`** — deployed the same day this check ran. The object shell
and the Quote Line Item lookup _are_ committed, which makes the divergence
harder to spot than the Biglietto one: the repository looks like it has the
tranche, and does not have the half that does the work. See
[OI-50](../items/OI-50%20Tranche%20object.md).

This is no longer a historical artefact of one July sprint. It is **how work is
currently reaching the org**, and every unretrieved component is lost if the
sandbox is refreshed. Retrieval is `sf project retrieve start` against a named
manifest — deliberately not run by this check, which is read-only.

⚠ `sf project retrieve preview` **cannot be used to detect this**. Pienissimo
UAT is a partial sandbox without source tracking and the command errors with
`NonSourceTrackedOrgError`. The comparison above was done component by
component against `sf org list metadata`.
