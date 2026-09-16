---
id: OI-137
type: open-item
status: open
owner: Anita Aga
with: Aurel Mrruku
org: ROMI
raised: 2026-09-15
updated: 2026-09-15
depends_on: [OI-116, OI-135]
blocks: [go-live]
requirement: [INT-01, INT-05, NFR-06]
source: commit 1830fce, Anita Aga, 2026-09-15 10:02:54 CEST, merged to DevMain in PR #43
evidence: force-app/main/default/classes/OrderMexalIntegrationService.cls:13,257-259
---

# OI-137 - The order to Mexal chain is disabled in every sandbox

**`1830fce` makes order creation skip the Mexal chain in any sandbox org. UAT is
a sandbox. UAT opens on 23 September.**

## What changed

Commit `1830fce`, "Added an check to not do the callout on order creation",
eight lines, merged to `DevMain` five minutes later as part of PR #43:

```apex
public static void enqueueForCreatedOrders(List<Order> newOrders) {
  if (isSandbox()) {
    return;
  }
  ...
}

private static Boolean isSandbox() {
  return [SELECT IsSandbox FROM Organization LIMIT 1].IsSandbox;
}
```

The guard is an **unconditional early return at the entry point of the chain**.
It is not an endpoint switch and not a mock: in a sandbox the trigger fires, the
method returns, and nothing downstream runs — no Anticipay step, no Mexal
customer create, no Mexal order create, no `Mexal_Integration_Status__c`, no
`Integration_Log__c` row.

## Why it was almost certainly done

It is a direct answer to
[the production-ERP risk](../risks/Risk%20-%20the%20Mexal%20integration%20is%20developed%20against%20the%20production%20ERP.md):
the only Mexal target in the record is Pienissimo's live billing system, and a
UAT order would otherwise create a real customer and a real order in it. Read
that way the guard is the responsible thing to have shipped, and it was shipped
the morning after the risk was recorded.

⚠ **This reading is inferred from the commit and its timing. No swept source
states the reason** — the commit message does not, PR #43 has no description, and
no message on any channel discusses it.

## Why it is nevertheless a problem

1. 🔴 **The integration Fase 1 exists to deliver cannot be exercised in UAT.**
   UAT runs **23 September – 13 October**, approval by 13 October, go-live
   21 October. A guard on `Organization.IsSandbox` means the first time the
   order-to-Mexal chain ever executes end to end from an order will be **in
   production, after acceptance**.
2. 🔴 **It silently invalidates the acceptance criteria that depend on it.**
   `INT-05` and `AC-06`-adjacent scenarios cannot be demonstrated. A tester
   creating an order in UAT will see a blank `Mexal_Integration_Status__c` and
   have no way to tell "correctly skipped" from "broken".
3. 🔴 **A finer-grained mechanism already existed and was not used.**
   `MexalSearchCalloutService.buildEndpoint` has selected
   `Named_Credential_Sandbox__c` over `Named_Credential_Prod__c` on
   `Integration_Configuration2__c` since `bc2ed5d` (10 September), and
   `Integration_Configuration2__c` also carries `Use_Mock__c`,
   `Mock_API_Scenario__c` and `Mock_Apex_Class__c`. The chain could have been
   pointed at a Mexal test company or a mock instead of switched off.
4. 🔴 **It is asymmetric.** Only `enqueueForCreatedOrders` is guarded. The
   customer create/update path, both sync batches and the manual Account button
   are not — so a sandbox can still write customers to Mexal, just not orders.
5. ⚠ **Nothing will remove it.** There is no configuration, custom setting or
   custom permission behind the check; it is compiled behaviour. Going live means
   editing Apex, deploying, and having the first real execution be the production
   one.

## What a person must decide

1. **How is the order-to-Mexal chain accepted, if not in UAT?** Either a Mexal
   test company is obtained (question 1 of the production-ERP risk, still
   unanswered), or the mock path is used, or the client is told explicitly that
   this integration is accepted on evidence other than a UAT run.
2. **Should the guard be configuration rather than code?** `Use_Mock__c` and the
   sandbox named credential already exist for exactly this.
3. **Who removes it before go-live, and how is that verified?** Name the person
   and the check. A forgotten `isSandbox()` is invisible in production only in the
   sense that the integration simply never runs.
