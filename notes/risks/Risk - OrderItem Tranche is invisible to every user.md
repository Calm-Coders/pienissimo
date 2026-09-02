---
id: risk-orderitem-tranche-undeployed
type: risk
status: resolved
severity: high
owner: Aurel Mrruku
org: ROMI
raised: 2026-08-25
updated: 2026-09-02
depends_on: [OI-50]
blocks: [OI-75, go-live]
source: org-status-check against Pienissimo UAT, 2026-08-26
resolved_by: org-status-check 2026-09-02 08:05-08:14Z
evidence: Tooling FieldDefinition + FieldPermissions on OrderItem.Tranche__c, Pienissimo UAT
---

# Risk - OrderItem Tranche is invisible to every user

> ✅ **Resolved 2026-09-02.** `Tranche_Management` now grants read and edit
> on `OrderItem.Tranche__c`. The field is no longer invisible. Read
> [the resolution](#2026-09-02---resolved) — the _propagation_ half of this
> note is still unbuilt and did not move.

**`OrderItem.Tranche__c` exists in Pienissimo UAT and no profile or project
permission set grants read or edit on it.** It is therefore invisible to every
human user, System Administrator included, and unreadable from SOQL.

| Instrument                           | What it reports                                          |
| ------------------------------------ | -------------------------------------------------------- |
| Tooling `FieldDefinition`            | `OrderItem.Tranche__c` — **present**                     |
| `sf sobject describe OrderItem`      | absent                                                   |
| `SELECT Tranche__c FROM OrderItem`   | `INVALID_FIELD: No such column`                          |
| `FieldPermissions WHERE Field = '…'` | one row only — `sfdc_a360_sfcrm_data_extract`, read-only |

`sfdc_a360_sfcrm_data_extract` is a Salesforce-internal permission set. It is
not assigned to project users and it is not the grant this field needs.

The field was created **2026-08-24T15:18:02Z by Aurel Mrruku**, in the same
minute as its Quote-side twin `QuoteLineItem.Tranche__c` (15:17:41Z). The twin
**is** granted, read and edit, by the `Tranche_Management` permission set. The
Order-side field was left out of that permission set — it carries no
`OrderItem` object permission and no `OrderItem.Tranche__c` field permission at
all. `OrderItem.Data_Scadenza__c`, the other half of the propagation pair, is
granted through the System Administrator profile and is visible.

## ⚠ This supersedes the diagnosis recorded on 2026-08-25

The 2026-08-25 check recorded this note under the title _"OrderItem Tranche is
in the repository but not in the org"_ and concluded the field had been
committed and never deployed. **That was wrong.** The field is deployed. The
finding was a false negative produced by the instrument, not by the org.

**`sf sobject describe` filters its field list by the running user's
field-level security.** A field with no FLS grant is simply absent from the
output, and is indistinguishable there from a field that was never created. The
comparison method the 2026-08-25 check used — `describe` output against the
`force-app/` field directory — cannot tell those two cases apart.

**Use Tooling `FieldDefinition` for existence and `FieldPermissions` for
visibility.** Neither is FLS-filtered. See
[how to read the org's schema](../How%20to%20read%20the%20org%20schema%20without%20a%20false%20negative.md).

## Why it still matters as much

The conclusion the old note reached survives its diagnosis: **tranche-to-order
propagation cannot run in UAT today.** The reasons are now two, and both are
open.

1. **No user can read or write the field.** Any Apex that enforces FLS, any
   layout, any list view, any report and any integration running as a project
   user is blocked. `QuoteTrancheController` already performs explicit
   `isAccessible` / `isUpdateable` checks on its Quote-side fields, so code
   written to the same standard on the Order side would refuse to run.
2. **Nothing populates it.** Nothing in `force-app/` references
   `OrderItem.Tranche__c` — not the classes, not the triggers, not the LWC. The
   propagation step [OI-50](../items/OI-50%20Tranche%20object.md) specifies,
   copying the tranche reference and payment date onto the Order Items when an
   accepted quote generates the Order, has no implementation on either side.

Without it, Mexal reconciliation at line level (DM-17, ORD-01) cannot be
demonstrated, and [ticket availability](../items/OI-75%20Ticket%20availability%20rule.md),
which keys release to a fully paid tranche, has no path from payment back to the
ticket.

## What closes it

Add `OrderItem` object permission and `OrderItem.Tranche__c` field permission to
the `Tranche_Management` permission set — the field is already there to grant —
and then build the propagation. Or state that propagation is deliberately
deferred, and say so where the trackers can see it. The current state, in which
the field exists, is invisible, and `force-app/` reads as though the feature is
done, is the one option that is not fine.

Both are write actions and belong to Aurel Mrruku; **this check is read-only and
performed neither.**

## 2026-09-02 - Resolved

**The permission gap is closed.** `FieldPermissions` for
`OrderItem.Tranche__c` on 2026-09-02 returns two rows, not one:

| Permission set                                       | Read | Edit |
| ---------------------------------------------------- | ---- | ---- |
| `Tranche_Management`                                 | yes  | yes  |
| `sfdc_a360_sfcrm_data_extract` (Salesforce internal) | yes  | no   |

The `QuoteLineItem` twin carries the identical pair, so the asymmetry this note
was written about is gone. `OrderItem` inherits object access from `Order`,
which carries 72 grant rows, so field and object access line up.

### Two caveats that keep this from being "done"

**Reach is one user.** `Tranche_Management` is assigned to exactly **one** active
user against 8 active users in the org — the same as every other project
permission set. The field is visible in principle and to almost nobody in
practice; that is tracked separately as `DIV-09` in the register's build state.

**Propagation is still unbuilt, and this note always said so.** On 2026-09-02,
**0 of 18** `OrderItem` records carry a tranche, `Completamente_Pagata__c` is
true on none of the 19 tranches, and nothing in `force-app/` writes either side.
Making the field visible did not make anything fill it. That half belongs to
[OI-50](../items/OI-50%20Tranche%20object.md) and is unchanged.
