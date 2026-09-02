---
id: obj-full-permission-product-fields
type: object
status: resolved
owner: Aurel Mrruku
org: ROMI
raised: 2026-09-02
updated: 2026-09-02
source: PermissionSet Full_Permission retrieved from Pienissimo UAT, 2026-09-02
---

# Full Permission granted six of twenty-six product fields

**A system administrator could not see most of the article registry**, and the
cause was field-level security, not a missing field.

The `Full_Permission` permission set - whose own description claims _"Read and
edit access to all custom objects and custom fields in this project"_ - granted
**6 of `Product2`'s 26 custom fields**: `Bundle_Selling_Price__c`,
`Calculated_Bundle_Price__c`, `Parent__c`, `Product_Price__c`,
`Spread_Total__c` and `Spread_Variance__c`.

**Everything to do with the article registry was missing** - `Evento__c`,
`Genera_Biglietto__c`, `Solo_Bundle__c`, `Tipologia__c`, `Anno_Solare__c`,
`ARTPR__c`, `Bundle_Type__c`, all seven `Livello_*__c`, `Price_1__c`,
`Price_2__c`, `WooCommerce_Product_Id__c`, and the two fields created earlier the
same day.

## Fixed 2026-09-02

Nineteen field grants added, deployed to Pienissimo UAT and verified: the
running user now describes **26 of 26** custom fields, with only the formula
`Spread_Variance__c` not updateable, as intended.

🟢 **It was org-only and is now in source control.** `Full_Permission` was one of
the three permission sets
[the 25 August org check found in the org and not in `force-app/`](../risks/Risk%20-%20the%20Biglietto%20Apex%20stack%20is%20not%20in%20source%20control.md).
Fixing it required retrieving it, so it is now committed at
`force-app/main/default/permissionsets/Full_Permission.permissionset-meta.xml`.
**One of the three org-only permission sets is closed**; `DocuSign` and
`Sales_User` are still org-only.

## Two things worth keeping

- **`Code__c` is deliberately absent from the grant.** It is
  **universally required** (`<required>true</required>`), and a universally
  required field is always visible and **cannot carry field-level security** - a
  deploy that lists one fails. Its absence from a permission set is therefore not
  evidence of a gap.
- **A permission set's description is not a specification.** This one asserted
  complete coverage and delivered 23%. When asking "can the user see this
  field?", read the `fieldPermissions`, not the prose.

⚠ **`Tipo_Biglietto__c` and `Stato_Bundle__c` are now granted here as well as in
[`Product_Registry_Admin`](../items/OI-76%20Ticket%20type%20picklist%20on%20the%20product.md).**
That is consistent with "editable by system administrators only" **only for as
long as `Full_Permission` is itself assigned to administrators alone**. It
currently has two assignees. If it ever widens, the admin-only rule on those two
fields is silently gone.
