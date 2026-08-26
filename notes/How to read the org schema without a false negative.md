---
id: ref-org-schema-reading
type: reference
status: active
owner: Aurel Mrruku
org: ROMI
raised: 2026-08-26
updated: 2026-08-26
source: org-status-check against Pienissimo UAT, 2026-08-26
---

# How to read the org schema without a false negative

Written after the 2026-08-25 org check reported a field missing from Pienissimo
UAT that was in fact deployed. The instrument was wrong, not the org. This note
exists so the next check does not repeat it.

## The trap

**`sf sobject describe` returns only the fields the running user can see.** A
custom field with no field-level-security grant is absent from its output, and
absent in exactly the same way as a field that was never created. SOQL behaves
the same: `SELECT Tranche__c FROM OrderItem` returns `INVALID_FIELD — No such
column`, not a permission error.

So the comparison "describe output versus the `force-app/` field directory",
which is how repository-versus-org divergence was established on 2026-08-25,
**cannot distinguish _not deployed_ from _deployed and invisible_**. It reported
`OrderItem.Tranche__c` as never deployed. It had been created on 24 August and
simply granted to nobody —
[the risk](risks/Risk%20-%20OrderItem%20Tranche%20is%20invisible%20to%20every%20user.md).

A System Administrator profile is no protection: FLS on a custom field is not
implied by the administrator profile, and the field was invisible to Aurel
Mrruku's own admin user.

## What to use instead

Both of these are Tooling API objects and neither is FLS-filtered.

| Question                          | Query                                                                                                                                 |
| --------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------- |
| Does the field exist?             | `SELECT QualifiedApiName FROM FieldDefinition WHERE EntityDefinition.QualifiedApiName = '<Object>'`                                   |
| Who can see it?                   | `SELECT Parent.Profile.Name, Parent.Name, PermissionsRead, PermissionsEdit FROM FieldPermissions WHERE Field = '<Object>.<Field>__c'` |
| When was it created, and by whom? | `SELECT DeveloperName, TableEnumOrId, CreatedDate, LastModifiedDate, LastModifiedBy.Name FROM CustomField`                            |

Read them together. `FieldDefinition` alone answers existence and says nothing
about whether anyone can use the field, which on this project turned out to be
the more interesting half.

**A `FieldPermissions` result whose only rows are `sfdcInternalInt__*` or
`sfdc_*` permission sets means nobody has been granted the field.** Those are
platform internals; they are not a project grant.

**An auto-named permission set like `X00ex00000018ozT_128_09_43_34_1` is a
profile's field permissions surfacing in the `FieldPermissions` table.** It is
how a Profile grant appears here, and it is a real grant — do not dismiss it as
scaffolding the way the `sfdc_*` rows should be dismissed.

## The rest of the toolkit still stands

`sf org list metadata` is not FLS-filtered and remains correct for components —
objects, classes, triggers, flows, layouts, permission sets, quick actions.
Object-level presence has never been the problem here; field-level presence was.

⚠ **`sf project retrieve preview` cannot be used on this project at all.**
Pienissimo UAT is a partial sandbox without source tracking and the command
fails with `NonSourceTrackedOrgError`. Divergence has to be established
component by component, which is why the instrument used to do it matters.

Related: [the build ahead of the record](objects/The%20build%20ahead%20of%20the%20record.md),
[the Biglietto stack is not in source control](risks/Risk%20-%20the%20Biglietto%20Apex%20stack%20is%20not%20in%20source%20control.md).
