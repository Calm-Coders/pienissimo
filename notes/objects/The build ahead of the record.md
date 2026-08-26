---
id: build-ahead-of-record
type: object
status: active
owner: Aurel Mrruku
org: ROMI
updated: 2026-08-25
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
