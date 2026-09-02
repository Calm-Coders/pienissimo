---
id: obj-code-field-retired
type: object
status: resolved
owner: Aurel Mrruku
org: ROMI
raised: 2026-09-02
updated: 2026-09-02
depends_on: [OI-49]
source: Product2.Code__c deletion in Pienissimo UAT, 2026-09-02
---

# The article code moved from Code__c to ProductCode

**`Product2.Code__c` is deleted.** The article code now lives in the standard
**`ProductCode`** field, in the org and in `force-app/`.

Aurel Mrruku asked for the field to go, was told what it was load-bearing for,
and confirmed. This note records what had to move first, and the one protection
that was given up.

## Why it could not be a straight delete

`Code__c` was not the unused field an early reading of it suggested. On the day
it was removed it held the article code for **207 of 230 products**, and it was
the key the **live WooCommerce integration** matched incoming orders against.
Salesforce also refuses to delete a field referenced in Apex.

## What was done, in order

1. **Six stale duplicates deleted.** `Code__c` and `ProductCode` were disjoint
   namespaces, which hid six codes naming **two different articles each** -
   `CS-00007`, `CS-00129`, `CS-00132`, `CS-00133`, `CS-00156`, `CS-00157`. In
   every pair the `Code__c` side was **inactive** and the `ProductCode` side
   **active**, so the inactive six went. Merging the namespaces is what surfaced
   them; they had been invisible while the two fields were separate.
2. **207 codes copied `Code__c` -> `ProductCode`.** Verified afterwards: **228 of
   230** products carry a code, the two without are records that had neither
   field, and **no record lost its code**.
3. **`WoocommerceOrderService` repointed** - the SOQL, the map key, the
   `productIdToScCode` mapping and the error text now use `ProductCode`. This is
   the class taking live WooCommerce traffic
   ([the flow](../flows/The%20WooCommerce%20order%20integration.md)).
4. **Three test classes repointed.** All three already set `ProductCode`
   alongside `Code__c`, so the change was a **de-duplication**, not an addition -
   the deploy caught it as `Duplicate field initialization`.
5. **Removed from the surfaces that showed it** - two layouts, two flexipages and
   the `Bundle_Demo` permission set. `ProductCode` was already on all four pages,
   so these were removals rather than swaps.
6. **Deleted** via `manifest/code-field-destructiveChanges.xml`. Verified absent
   by Tooling `FieldDefinition`.

## 🔴 What was given up

**`Code__c` was `unique`, `externalId` and case-insensitive. `ProductCode` is a
plain standard text field with none of those.**

So the org has **lost its only structural guard against two products sharing an
article code**. That matters more here than it would on most projects, because
[normalising an article code merges two products](../risks/Risk%20-%20normalising%20an%20article%20code%20merges%20two%20products.md)
is a live risk with **three proven instances** in the client's own registry, and
because ~1000 codes are about to be re-created
([OI-98](../items/OI-98%20The%20Mexal%20article%20registry%20is%20being%20re-created.md)).

🟢 **There are zero duplicate `ProductCode` values today** - checked immediately
after the migration. That is a starting position, not a guarantee.

⚠ **Nothing now stops the next import from creating one.** If duplicate
protection is wanted back, the options are a `unique` custom field again, a
validation rule, or a duplicate rule on `ProductCode`. **None is in place**, and
this is the one consequence of the deletion that is worth revisiting before the
registry reload.

⚠ **`Code__c` was also the upsert key an integration would naturally reach for.**
Any future mapping document that still names it is now wrong -
[the workbook decode](../The%20Anagrafica%20Articoli%20workbook.md) and
[the WooCommerce payload contract](../The%20WooCommerce%20payload%20contract.md)
were both written while it existed.
