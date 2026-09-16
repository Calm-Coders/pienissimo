---
id: ref-bundleproductassignment-logic
type: reference
status: active
updated: 2026-09-16
source: force-app/main/default/lwc/bundleProductAssignment/bundleProductAssignment.js
---

# How bundleProductAssignment works

This explains the local source inspected on 16 September 2026, including
uncommitted changes. It is not a verification of the deployed Salesforce org.

## Purpose and product types

`bundleProductAssignment` is a Product (`Product2`) screen quick action for
choosing the contents of a bundle and assigning part of its selling price to
each component. Each saved row is a `BundleComponent__c` record.

- The parent Product must have record type `Bundle`, enforced by the
  `Bundle__c` lookup filter.
- The component Product must have record type `Item`, enforced by the
  `Product__c` lookup filter. A Bundle cannot be a component of another Bundle.
- The picker additionally requires `IsActive = true` and `Solo_Bundle__c = true`.
  Solo Bundle means the Item is intended for bundles; it does not change its
  record type into Bundle.
- An Item can belong to multiple bundles, with a separate quantity and assigned
  price in each. The picker excludes products already in the current draft.

## Opening the action

Salesforce supplies `recordId`. Its setter calls Apex `getBundleContext`, which
loads the parent name, selling price and existing component rows. Saving stays
disabled until this succeeds. `contextVersion` prevents an older load response
from replacing a newer one.

The component keeps three collections:

| Collection         | Purpose                                                             |
| ------------------ | ------------------------------------------------------------------- |
| `rows`             | Main table draft, including unsaved additions and edits             |
| `savedRows`        | Last loaded or saved snapshot, used when reselecting a removed Item |
| `selectedProducts` | Pending cards in the Add view, not yet moved to the main table      |

## Adding products

1. **Aggiungi** opens the picker and calls Apex `searchProducts`.
2. Search matches `ProductCode`, not the product name. It always passes
   `bundleOnly: true` and no ticket-generation filter. Apex returns up to 50
   matches per page, ordered by Id; the next page uses the last Id as a cursor.
3. **Scegli** creates a pending card with quantity 1 and a blank required row
   amount. If the product was saved earlier and removed from this draft, the
   card restores the saved row and its original values.
4. Enter a quantity and the total amount assigned to that row. **Aggiungi un
   altro** validates the pending cards before reopening search.
5. **Aggiungi tutti** moves the cards into the main table draft. It does not
   write anything to Salesforce.
6. **Salva bundle** in the Add view stages those cards and saves the entire
   draft, including existing table edits and removals.

Search requests have a version counter so late responses cannot overwrite a
newer search or repopulate a closed picker. Search errors have a retry path.

## Prices and quantities

The bundle selling price comes from `Bundle_Selling_Price__c` and is read-only
in this action. The user manually assigns component amounts; there is no
automatic proportional allocation.

| Display                             | Calculation                                                                     |
| ----------------------------------- | ------------------------------------------------------------------------------- |
| Listino riga                        | Item reference unit price multiplied by quantity                                |
| Importo assegnato alla riga         | User-entered total for the entire row                                           |
| Importo per unita                   | Assigned row amount divided by quantity                                         |
| Sconto                              | `(1 - assigned amount / line list price) * 100`; a dash when list price is zero |
| Totale assegnato                    | Sum of row amounts in both the main draft and pending cards                     |
| Da assegnare / Assegnato in eccesso | Selling price minus assigned total, rounded to cents                            |

Changing quantity does not multiply the assigned row amount. For example,
with invented values, quantity 2 and assigned amount 100 means 50 per unit,
not a row total of 200.

## Editing, removing and saving

Inline quantity and amount edits immediately update the local table and totals.
The delete icon removes a row from the draft only. These actions mark the draft
as dirty; they do not call Apex to persist changes.

`pricing.js` requires a positive integer quantity and a finite, nonnegative row
amount with at most two decimal places. Every submitted row must have a Product.
Zero is an allowed amount; a blank pending-card amount is not.

If the assigned total differs from the selling price, Save asks whether to
continue. A difference is a warning, not a mandatory balancing rule.

On confirmation, `handleSave` sends the complete draft to `saveComponents` as
JSON containing each row's Id, Product Id, quantity and assigned amount. Apex:

1. Loads the parent's existing components and validates the submitted rows.
2. Rejects an existing component Id belonging to a different bundle.
3. Updates quantity and amount on changed existing rows and inserts new rows.
4. Deletes existing components omitted from the submitted list. An empty list
   therefore removes all components when the save is allowed to proceed.
5. Returns fresh bundle context, which replaces the local saved snapshot.

The server performs deletes before upserts in the same Apex transaction.
Salesforce lookup filters and other component automation also apply at save.
The LWC's picker filters should not be confused with server-side validation of
every possible API caller.

A successful save shows a toast, closes the quick action and dispatches a
record refresh. If saving fails, an error toast appears and the draft remains
available for correction. A save started from the Add view leaves its staged
cards in the main table if the save fails or the variance confirmation is declined.

## Back and Cancel

**Indietro** asks before discarding pending cards, then returns to the main
table. Existing main-table draft edits remain. **Annulla** asks before discarding
a dirty main draft, then closes and refreshes the action. Neither action saves.

## Source files

- [LWC JavaScript](../force-app/main/default/lwc/bundleProductAssignment/bundleProductAssignment.js)
- [LWC template](../force-app/main/default/lwc/bundleProductAssignment/bundleProductAssignment.html)
- [Row validation](../force-app/main/default/lwc/bundleProductAssignment/pricing.js)
- [Quick action configuration](../force-app/main/default/lwc/bundleProductAssignment/bundleProductAssignment.js-meta.xml)
- [Apex controller](../force-app/main/default/classes/BundleProductAssignmentController.cls)
- [Parent lookup](../force-app/main/default/objects/BundleComponent__c/fields/Bundle__c.field-meta.xml)
- [Component lookup](../force-app/main/default/objects/BundleComponent__c/fields/Product__c.field-meta.xml)
