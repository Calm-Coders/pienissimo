---
id: record-type-list-views
type: reference
status: in-progress
org: ROMI
raised: 2026-10-01
updated: 2026-10-01
source: User request, 2026-10-01
---

# Record type list views for Account Opportunity and Quote

Eight operational list views are built in source and deployed to the configured
`pienissimo partial` sandbox.

## Views

| Object      | View                                     | Filter                                      |
| ----------- | ---------------------------------------- | ------------------------------------------- |
| Account     | `Aziende - Operativo`                    | Account record type `Azienda`               |
| Account     | `Locali - Operativo`                     | Account record type `Locale`                |
| Opportunity | `Opportunita - Vendita Standard`         | Opportunity type `Vendita_Standard`         |
| Opportunity | `Opportunita - Plus Attivazione Rinnovo` | Opportunity type `Plus_Attivazione_Rinnovo` |
| Opportunity | `Opportunita - WooCommerce`              | Opportunity type `WooCommerce`              |
| Quote       | `Preventivi - Vendita Standard`          | Parent Opportunity is `Vendita_Standard`    |
| Quote       | `Preventivi - Plus Attivazione Rinnovo`  | Parent Opportunity is Plus                  |
| Quote       | `Preventivi - WooCommerce`               | Parent Opportunity is `WooCommerce`         |

The columns are tailored to each process: customer or venue context, owner, stage,
amount, close or expiry date, primary quote, payment condition, DocuSign state, and
WooCommerce identifiers where applicable.

## Technical routing

Salesforce rejected the standard record-type token as a list-view filter for Account and
Opportunity. Read-only formula fields expose the record type developer name instead:

- `Account.Tipo_Record_Lista__c`
- `Opportunity.Tipo_Record_Lista__c`

Quote has no project record types. `Quote.Tipo_Opportunita_Lista__c` exposes the parent
Opportunity record type so Quote views follow the same Standard / Plus / WooCommerce
split. All three fields are readable and non-editable in `Full_Permission`.

Check-only deployment `0AfMA00000CpkrV0AR` succeeded on 1 October 2026 with all 12
components valid. Deployment `0AfMA00000CpkwL0AR` then succeeded with 17 of 17 scoped
components and no errors. An org read-back returned all eight list views.
