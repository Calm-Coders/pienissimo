---
id: lead-record-type-list-views
type: reference
status: in-progress
org: ROMI
raised: 2026-10-02
updated: 2026-10-02
source: User request, 2026-10-02
---

# Lead record type list views

Two operational Lead list views are built in source:

| View              | Filter                    |
| ----------------- | ------------------------- |
| `Lead - Standard` | Lead record type Standard |
| `Lead - Diretta`  | Lead record type Diretta  |

Both show the Lead, company, status, source and source detail, intended Opportunity
type, recontact date, agent and owner. `Lead.Tipo_Record_Lista__c` exposes the record
type developer name as a read-only formula so the list views can filter reliably using
the same pattern already used for Account and Opportunity.

The metadata is repository-only and has not been deployed.

Check-only deployment `0AfMA00000CqFvJ0AV` validated the formula field and both list
views successfully against the configured Pienissimo sandbox on 2 October 2026.
