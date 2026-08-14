---
id: obj-bundlecomponent
type: object
status: resolved
owner: Aurel Mrruku
org: ROMI
updated: 2026-08-14
source: meetings/proposals/2026-07-16-bundle-spread-demo.md
requirement: BUN-01
---

# The BundleComponent junction

The bundle data model, built 2026-07-16 and **approved by the client** in the
week of 22–24 July. This is the one part of the build that is designed,
demonstrated, accepted and in source control.

`BundleComponent__c` is a junction between a bundle product and its component
products: `Bundle__c` + `Product__c` lookups, `Quantity__c`, `Spread_Price__c`,
and the `Unit_Spread__c`, `Line_List_Price__c`, `List_Price__c`,
`Discount_Pct__c` formulas. `BundleComponentTrigger` and its handler are
active; `BundleProductAssignmentController` and the `bundleProductAssignment`
LWC give administration a configurator.

**The spread price lives on the link, not on the product.** That is what makes
per-product revenue survive a bundle sale — the acceptance criterion Pienissimo
set — and it is why the same product can sit in two bundles at different
spreads. It replaced a `Parent__c` self-lookup on `Product2` that allowed a
product into only one bundle and held one global price;
[OI-44](../items/OI-44%20Delete%20the%20deprecated%20bundle%20fields.md) is the
cleanup of that predecessor.

`Product2` carries the bundle header: `Bundle_Selling_Price__c`,
`Spread_Total__c`, `Spread_Variance__c`, and the
[classification picklists](../items/OI-46%20Bundle%20classification%20picklists.md).

Two live defects sit on top of it:
[the test suite is broken](../items/OI-64%20The%20bundle%20Apex%20test%20suite%20is%20broken.md)
and [ACADEMY 2026 no longer reconciles](../items/OI-65%20ACADEMY%202026%20no%20longer%20reconciles.md) —
the second being exactly the failure
[OI-43](../items/OI-43%20Spread%20variance%20does%20not%20block%20saving.md)
predicted.
