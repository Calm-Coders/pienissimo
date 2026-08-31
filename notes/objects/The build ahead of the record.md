---
id: build-ahead-of-record
type: object
status: active
owner: Aurel Mrruku
org: ROMI
updated: 2026-08-27
source: git log 2026-08-03..2026-08-13 + force-app/main/default
evidence: repository working tree on DevMain, commit 8712344
---

# The build ahead of the record

> **The repository is roughly a week ahead of every tracker in this project.**
> The 2026-08-03 org verification recorded in `meetings/open-items.md` is the
> newest published statement of what exists. Six of the things it lists as "not
> built at all" were committed between 4 and 7 August, and the written record
> was never updated to match.

Committed after the org check by the
[Calm-Coders developers working for ROMI](../Calm-Coders%20on%20GitHub%20means%20ROMI.md) —
[Anita Aga](../people/Anita%20Aga%20-%20Salesforce%20developer%20ROMI.md),
[Sara Aga](../people/Sara%20Aga%20-%20Salesforce%20developer%20ROMI.md) and
[Rexhina Hysi](../people/Rexhina%20Hysi%20-%20Salesforce%20developer%20ROMI.md):

| In the repository now                                                                       | The 08-03 check said                           | Item                                                                     |
| ------------------------------------------------------------------------------------------- | ---------------------------------------------- | ------------------------------------------------------------------------ |
| `OrderBigliettoTrigger` + handler + **test class**                                          | "nothing creates a Biglietto from an Order"    | [OI-53](../items/OI-53%20Asset%20generation%20rule.md)                   |
| `Product2.Solo_Bundle__c`                                                                   | "missing"                                      | [OI-47](../items/OI-47%20Product%20flags%20at%20import.md)               |
| `Product2.WooCommerce_Product_Id__c`, `Opportunity.WooCommerce_Order_Id__c`                 | "neither exists"                               | [OI-49](../items/OI-49%20WooCommerce%20checkout-link%20flow.md)          |
| `OrderItem.Data_Scadenza__c`                                                                | "Order and OrderItem carry zero custom fields" | [OI-50](../items/OI-50%20Tranche%20object.md)                            |
| `Opportunity.Tipo_Opportunita__c`                                                           | not mentioned                                  | [OI-70](../items/OI-70%20Performance%20Plus%20opportunity%20typing.md)   |
| `Account.Nome_Locale__c`, loss-reason picklists on Lead/Opportunity/Quote                   | not mentioned                                  | —                                                                        |
| `Integration_Configuration__c` (16 fields), `Integration_Log__c` (10), `API_Callout_Engine` | **not mentioned anywhere, by anyone**          | —                                                                        |
| `ProductTrigger` deleted                                                                    | "still present"                                | [OI-44](../items/OI-44%20Delete%20the%20deprecated%20bundle%20fields.md) |

Still genuinely absent from the repository: **`Tranche__c`** — the object the
whole instalment and ticket-release design rests on — and the deprecated
`Parent__c` / `Calculated_Bundle_Price__c` fields that
[OI-44](../items/OI-44%20Delete%20the%20deprecated%20bundle%20fields.md) asks to
remove.

**One row on that table is not a gap.**
`Integration_Configuration__c` / `Integration_Log__c` / `API_Callout_Engine` are
[ROMI's standard integration scaffolding](../Integration%20Configuration%20is%20standard%20ROMI%20scaffolding.md),
built on every project. They carry no requirement id because they are not a
project requirement. Do not re-flag them.

Everything else on the table **is** a gap in the record: real project
requirements, built and never written up.

**The corrective action is on the record, not on the build:** re-run
`org-status-check` against UAT, then regenerate the tracker rows so the
client-facing view stops understating what is finished.

The reverse divergence also exists — the org holds Apex the repository does not:
[the Biglietto stack is not in source control](../risks/Risk%20-%20the%20Biglietto%20Apex%20stack%20is%20not%20in%20source%20control.md).

## 2026-08-25 - the pattern held, and one row of the table above is now wrong

Verified read-only against **Pienissimo UAT**.

**Correction to the paragraph above.** It reads "Still genuinely absent from the
repository: **`Tranche__c`**". That is no longer true — Anita Aga committed the
object on 2026-08-24 (`15a741d`) and it is live in the org with six records.
[OI-50](../items/OI-50%20Tranche%20object.md) carries the detail. The deprecated
`Product2.Parent__c` and `Calculated_Bundle_Price__c` fields **are** still
present, in both the org and `force-app/` —
[OI-44](../items/OI-44%20Delete%20the%20deprecated%20bundle%20fields.md) stands.

**The divergence runs in three directions now, not two.**

| Direction                    | Example                                                                                                  |
| ---------------------------- | -------------------------------------------------------------------------------------------------------- |
| Repository ahead of trackers | the tranche stack, built 24–25 Aug, recorded nowhere until this check                                    |
| Org ahead of repository      | `QuoteTrancheController`, `quoteCreateTranche`, `Quote.Crea_Tranche`, and the seven Biglietto components |
| **Repository ahead of org**  | 🔴 **`OrderItem.Tranche__c`** — committed, never deployed                                                |

The third is new and is the dangerous one, because `force-app/` reads as though
tranche-to-order propagation exists. It does not run in UAT.

The corrective action is unchanged and still on the record: retrieve the
org-only components into source control, then regenerate the tracker rows.

## 2026-08-26 - the third direction was a measurement error

Verified read-only against **Pienissimo UAT**. The table immediately above says
the divergence runs in three directions. **It runs in two.**

The third row — _"Repository ahead of org: `OrderItem.Tranche__c`, committed,
never deployed"_ — **is wrong**. The field is in the org. It was created
2026-08-24T15:18:02Z and reported missing because `sf sobject describe` is
filtered by the running user's field-level security and the field is granted to
nobody. See
[the risk](../risks/Risk%20-%20OrderItem%20Tranche%20is%20invisible%20to%20every%20user.md)
and [how to read the org schema](../How%20to%20read%20the%20org%20schema%20without%20a%20false%20negative.md).
Every other field comparison in the 25 August check was re-run against Tooling
`FieldDefinition`, which is not FLS-filtered, and **only this one was affected**.

So the standing picture is the original two:

| Direction                    | State on 2026-08-26                                                                   |
| ---------------------------- | ------------------------------------------------------------------------------------- |
| Repository ahead of trackers | still true — the tranche stack reached `DevMain` before any tracker named it          |
| Org ahead of repository      | still true, and now **only the Biglietto stack** plus the `Tranche__c-Tranche Layout` |

🟢 **The org-ahead direction shrank for the first time.** PR #12 (`dc513c6`,
merged 2026-08-26) retrieved six of the seven org-only tranche components into
`force-app/`, one day after they were deployed. That is the corrective action
this note has been asking for, performed without being asked.

🔴 **The Biglietto stack has not moved since 22 July**, and is three components
larger than recorded — the `BigliettoPdf` Visualforce page, the `DocuSign` named
credential and the `BundleComponent__c` custom tab all belong on the list.

The corrective action is now narrow and nameable: **retrieve the Biglietto
stack and the Tranche layout.** Everything else is committed.


## 2026-08-27 - a third divergence, and this one is failing in the org

🔴 **The org runs a version of `LeadConversionQueueable` that is not in
`force-app/`, and it throws.** A Salesforce error mail at 15:08:13Z reports the
queueable failing in the Pienissimo **partial sandbox** with
_"No such column 'Servizio_Interesse__c' on entity 'Lead'"_ at
`LeadConversionQueueable.execute` line 22 — which is exactly the SOQL statement
in the repository copy, except that the repository copy **does not select that
field**.

The field's metadata **is** in `force-app/`
(`objects/Lead/fields/Servizio_Interesse__c.field-meta.xml`, committed in
`225b172 Added logic for Lead flux`), and the sandbox says it is not there. So
the divergence runs in both directions on a single feature: class ahead in the
org, field ahead in the repository.

This widens the corrective list from "retrieve the Biglietto stack and the
Tranche layout" to include **reconciling the Lead conversion stack**. Full
detail and the alternatives not yet ruled out:
[the risk note](../risks/Risk%20-%20LeadConversionQueueable%20is%20broken%20in%20the%20Pienissimo%20sandbox.md).

⚠ Unlike the earlier entries in this note, which are bookkeeping problems, this
one is **breaking a running feature**. Lead conversion does not complete in that
sandbox.
