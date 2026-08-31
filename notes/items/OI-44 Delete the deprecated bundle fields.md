---
id: OI-44
type: open-item
status: in-progress
owner: Andrea Di Cicco
org: ROMI
raised: 2026-07-16
updated: 2026-08-25
source: meetings/open-items.md row 44
---

# OI-44 - Delete the deprecated bundle fields

Remove `Parent__c`, `Calculated_Bundle_Price__c`, `ProductTriggerHandler` and
`ProductTrigger` — the legacy self-lookup bundle model superseded by
[the junction](../objects/The%20BundleComponent%20junction.md) on 16 July.
Deactivated and unused since, but still present in UAT, and they must be
removed in production too.

**Half of this is already done and the tracker does not know.**
[Rexhina Hysi](../people/Rexhina%20Hysi%20-%20Salesforce%20developer%20ROMI.md) deleted
`ProductTrigger` on 5 August — commit `ba842ad`, _"delete product trigger since
is inactive and not needed logic"_ — merged in PR #8. The tracker still shows
the whole item blocked on Andrea Di Cicco's review.

Still present in `force-app/main/default/objects/Product2/fields/`:
`Parent__c` and `Calculated_Bundle_Price__c`.

So the remaining work is the two fields, and the open question is whether the
review that was meant to gate this ever happened — one of several places where
[the build ran ahead of the record](../objects/The%20build%20ahead%20of%20the%20record.md).

## 2026-08-25 - org check: both fields still present, in both places

Verified read-only against **Pienissimo UAT**. `Product2.Parent__c` and
`Product2.Calculated_Bundle_Price__c` are still defined in the org **and** still
in `force-app/main/default/objects/Product2/fields/`. Nothing has been deleted.
The item stays open.
