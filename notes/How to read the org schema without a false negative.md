---
id: ref-org-schema-reading
type: reference
status: active
owner: Aurel Mrruku
org: ROMI
raised: 2026-08-26
updated: 2026-09-02
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

## 2026-09-02 - the same failure, a different instrument

The rule below was written about **fields** and `sf sobject describe`. A second
instance turned up on 2 September, in a different tool, with the same shape: an
instrument that cannot see something reports **nothing** rather than **cannot
tell**.

**`org-status-check`'s own inventory reported ZERO EmailTemplates in Pienissimo
UAT**, and recorded no unavailability for the type — so the run treated the
absence as fact. SOQL against `EmailTemplate` returns **88**, including the
project's own `WooCommerce_Checkout_Link`, active, in
`Unfiled Public Classic Email Templates`.

The cause: **Metadata API `listMetadata` cannot enumerate folder-scoped types
without being given a folder.** `EmailTemplate` is folder-scoped. Asked without
one, it returns an empty list and no error.

The 2026-08-26 build state carried a `not_built` entry asserting the org had
"zero ... EmailTemplate". That claim rested entirely on this artefact and has
been **withdrawn** in the 2026-09-02 block, recorded as `LIM-01`.

### The generalised rule

> **An empty result from an instrument that cannot enumerate the thing is not
> absence. It is silence.**

Before recording any absence, name the authority that was searched and check it
was capable of answering:

| Question                          | Instrument that can answer                          | Instrument that will lie by omission         |
| --------------------------------- | --------------------------------------------------- | -------------------------------------------- |
| Does a field exist?               | Tooling `FieldDefinition`                           | `sf sobject describe`, ordinary SOQL         |
| Does an email template exist?     | SOQL on `EmailTemplate`                             | Metadata API `listMetadata` without a folder |
| Does a Flow exist?                | `FlowDefinitionView` **and** Metadata API, agreeing | either one alone                             |
| Is a component in the repository? | exact `rg` or file enumeration                      | semantic code search                         |

The Flow row is there because the same run **did** get it right: zero Flows was
confirmed twice, by an empty Metadata API list _and_ by `FlowDefinitionView`
returning 79 namespaced flows and no project one. Two instruments agreeing is
what let that finding stand while the EmailTemplate one fell.
