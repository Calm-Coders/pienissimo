---
id: risk-biglietto-not-in-scm
type: risk
status: open
severity: critical
owner: Aurel Mrruku
org: ROMI
raised: 2026-08-14
updated: 2026-08-31
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

## 2026-08-26 - the tranche half is fixed; the Biglietto half is not, and it is bigger than recorded

Verified read-only against **Pienissimo UAT**.

🟢 **The tranche instance recorded above is closed.** PR #12 (`dc513c6`, merged
2026-08-26) brought `QuoteTrancheController`, the `quoteCreateTranche` LWC,
`Quote.Crea_Tranche`, `Tranche__c.Importo_Previsto__c`,
`Tranche__c.Sequenza__c` and the `Tranche_Management` permission set into
`force-app/`. The committed controller is byte-identical to the org copy. **One
component from that list is still org-only: the `Tranche__c-Tranche Layout`.**

That is the pattern working as it should — deployed 25 August, retrieved and
committed 26 August, one day of exposure.

🔴 **The Biglietto stack has not moved since 22 July.** Still org-only:
`BigliettoTrigger`, `BigliettoTriggerHandler`, `BigliettoDocuSignService`,
`BigliettoDocuSignQueueable`, `BigliettoPdfService`, `BigliettoPdfQueueable`,
`BigliettoPdfBatch`, `Biglietto__c.DocuSign_Envelope_Id__c`, the `Biglietto__c`
custom tab and the `Biglietto Layout`.

**Three components belong on that list and were never recorded:**

| Component                       | What it is                                                  |
| ------------------------------- | ----------------------------------------------------------- |
| `BigliettoPdf` Visualforce page | the actual PDF template `BigliettoPdfService` renders       |
| `DocuSign` named credential     | the only named credential in the org; the DocuSign endpoint |
| `BundleComponent__c` custom tab | org-only alongside the `Biglietto__c` tab already recorded  |

Without the page and the named credential, the six classes could not run in a
fresh org even if they were retrieved — the stack is not self-contained without
them.

**This code has demonstrably run.** `DocuSign_Envelope_Id__c` is populated on
**19 of the 37** `Biglietto__c` records. This is not dormant scaffolding whose
loss would be theoretical; it is the only integration on the project with a live
endpoint and a history of successful calls, and it exists in exactly one place.

The `DocuSign`, `Full_Permission` and `Sales_User` permission sets remain
org-only, unchanged.

**The fix is unchanged and is still a retrieve, not a decision.**

## 2026-08-31 - the risk materialised: the code was deleted, and there was never a copy

**This note warned for seventeen days that these components existed in exactly
one place. On 28 August that place was wiped.**

The `org-status-check` of **2026-08-31, 09:36–09:52Z** found all seven Biglietto
Apex components gone from the org — 31 classes now against 37 on 28 August. The
destructive-changes manifest added by commit **`5d8cdb3`** (Anita Aga, 28 August
18:10 CEST) names them explicitly: `BigliettoTriggerHandler`,
`BigliettoDocuSignService`, `BigliettoDocuSignQueueable`, `BigliettoPdfService`,
`BigliettoPdfQueueable`, `BigliettoPdfBatch`, the `BigliettoTrigger` and the
`BigliettoPdf` Visualforce page.

🔴 **Verified against the whole of git history: not one of those eight components
has ever existed in this repository, on any branch.** `git log --all` returns
zero commits touching any of their files. The only committed Biglietto Apex was
`OrderBigliettoTrigger`, which is a different component.

So the loss is total. Roughly **270 lines of the most integration-sensitive code
on the project** — the DocuSign send path and the PDF generation stack — are
gone from the only copy that existed. This code had **demonstrably run**: 19 of
the 37 deleted records carried a populated `DocuSign_Envelope_Id__c`.

⚠ **The 31 August org check reported this as _"the Biglietto Apex source-control
drift is resolved, albeit by deletion from both sides."_ That reading is wrong
and should not be carried forward.** There were never two sides. The drift is not
resolved; the unversioned half was destroyed, which is the outcome this note
existed to prevent. A deleted custom object can be undeleted from the recycle bin
for ~15 days; **deleted Apex classes have no equivalent user-facing restore**, so
the code and the records are not one recovery problem, and the code is the harder
half.

**What a human must establish**, and only Anita Aga and Aurel Mrruku can:
whether any retrieve, export or sandbox copy of those eight components exists
anywhere outside the org — a local `force-app/` working copy that was never
committed, an IDE workspace, a prior sandbox refresh. If one does, commit it
today. If none does, the DocuSign and PDF implementation has to be written again
from scratch, and the record should say so plainly rather than carry it as
"built".

🔴 **The pattern has a third instance, live right now.** The same 31 August check
found the deployed WooCommerce class is not in source control either — see
[the deploy risk it creates](Risk%20-%20a%20clean%20deploy%20would%20orphan%20the%20live%20WooCommerce%20endpoint.md).
That one is the current integration on the critical path to go-live, and it is in
exactly the position the Biglietto stack was in on 26 August.

Related: [the records half of the same deploy](Risk%20-%20the%20Biglietto%20UAT%20ticket%20dataset%20was%20deleted.md).
