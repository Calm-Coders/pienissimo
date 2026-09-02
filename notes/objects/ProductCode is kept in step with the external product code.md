---
id: obj-productcode-sync-trigger
type: object
status: resolved
owner: Aurel Mrruku
org: ROMI
raised: 2026-09-02
updated: 2026-09-02
depends_on: [obj-code-field-retired]
source: External_Product_Code__c and ProductCodeTrigger in Pienissimo UAT, 2026-09-02
---

# ProductCode is kept in step with the external product code

The article code lives in **two** fields on `Product2`, on purpose, and a trigger
keeps them from drifting.

| Field                      | Role                                                                           |
| -------------------------- | ------------------------------------------------------------------------------ |
| `External_Product_Code__c` | **The key.** Unique, case-insensitive, `externalId`, `idLookup`. Not required. |
| `ProductCode`              | **The human-facing copy.** Standard field, on layouts, no constraints.         |

`ProductCodeTrigger` copies the first into the second on before-insert and
before-update. **No SOQL, no DML, no duplicate logic** - a before-save
assignment, so it costs nothing in bulk.

## Uniqueness is the index, not the trigger

**The unique index on `External_Product_Code__c` is what guarantees uniqueness**,
atomically at commit - including across **parallel Bulk API batches**, which no
trigger can do. Proven in the org: a duplicate insert fails with the platform's
own message,

```
duplicate value found: External_Product_Code__c duplicates value on record
with id: 01tMA00000Fl3eYYAR
```

not with anything the trigger says. An earlier version of this trigger checked
for duplicates itself; that was removed as redundant once the unique field
existed.

## The one-way rule

A **blank** `External_Product_Code__c` leaves `ProductCode` untouched rather than
clearing it. This is a **copy, not a mirror**, so it never destroys a value set
by hand or by an older import. The consequence to know: a product can carry a
`ProductCode` with no external code - two do today, both of which have neither.

## Verified in the org, 2026-09-02

| Case                                             | Result                                |
| ------------------------------------------------ | ------------------------------------- |
| Insert with external code, `ProductCode` omitted | `ProductCode` populated automatically |
| Change the external code                         | `ProductCode` follows                 |
| Duplicate external code                          | blocked **by the index**              |
| Blank external code                              | `ProductCode` left alone              |

Data state after the change: **229 products, 227 carrying both fields, 0 with an
external code and no `ProductCode`.**

## History worth keeping

This replaced a duplicate-checking trigger, which itself replaced an attempt at a
declarative duplicate rule. 🔴 **The declarative route is impossible** - a
matching-rule deploy is refused with _"The Product2 object is invalid"_, because
Salesforce Duplicate Management supports Account, Contact, Lead, Person Account
and custom objects only. **Do not try it again.**

The sequence went: `Code__c` (unique, required) →
[deleted](The%20article%20code%20moved%20from%20Code__c%20to%20ProductCode.md) →
`ProductCode` alone, unguarded → duplicate-checking trigger, which could not
close the parallel-batch race → `External_Product_Code__c`, which can, because
the guarantee is back in the database where it started.

⚠ **The trigger still adds ~35 uncovered Apex lines** to
[the coverage deficit](../risks/Risk%20-%20production%20deploy%20is%20blocked%20by%20Apex%20coverage.md)
and has no test. It belongs in that task's brief.
