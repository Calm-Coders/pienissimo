# Custom bundle demo — spread prices (open item #13)

Built 2026-07-16 in **Pienissimo UAT** (`a.mrruku@pienissimo.uat`, partial sandbox).
Answers the acceptance criterion agreed on 07/07: _product-level revenue must stay measurable when a product is sold inside a bundle_.

## 1. What was already in the org, and why it could not be demoed

The pre-existing build models the bundle **on Product2 itself**: record types `Bundle` / `Item`, a self-lookup `Parent__c` on the component, and `Product_Price__c` / `Calculated_Bundle_Price__c` / `Bundle_Selling_Price__c`. It fails the criterion on four counts:

| Problem                                                     | Consequence                                                                                                                                                                                                                 |
| ----------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `Parent__c` is a single lookup                              | A product can belong to **one** bundle only. `BundleProductAssignmentController.saveAssignments` silently reparents an item already owned by another bundle, emptying it.                                                   |
| Price lives on the product                                  | One global price per product — no way to give it a different value in a different bundle.                                                                                                                                   |
| `Calculated_Bundle_Price__c` = SUM of component list prices | Price flows **upward**. The agreed design fixes the bundle price and spreads it **downward**. `Bundle_Selling_Price__c` is written nowhere and spreads nothing (Bundle 1: selling price €300 vs components summing €2,170). |
| Legacy data still present                                   | `SOLD OUT OMAGGIO` at €0 and a `BLO-0308` code, both retired on 07/02.                                                                                                                                                      |

**Update, same day — the junction was accepted (Aurel).** The `Parent__c` model has since been migrated and deprecated; see §6.

## 2. What was added

`BundleComponent__c` — a junction between a bundle and a component product. **The spread price lives on the link, not on the product.** That single move is what makes both the shared product and the per-bundle spread possible.

```
Product2 (RT = Bundle)
  Bundle_Selling_Price__c   fixed at configuration, manual extra discount only
  Spread_Total__c           SUM of component spreads (Apex-maintained)
  Spread_Variance__c        Bundle_Selling_Price__c - Spread_Total__c  → must be 0
        |
        |  BundleComponent__c
        +--- Product__c        lookup (Item record type)
        |    Spread_Price__c   the share of the bundle price for THIS product in THIS bundle
        |    List_Price__c     formula: the product's own catalogue price
        |    Discount_Pct__c   formula: implicit discount of spread vs list
```

Components: `BundleComponentTrigger` + `BundleComponentTriggerHandler` (maintains `Spread_Total__c`; rejects the same product twice **within one** bundle), `BundleComponentTriggerHandlerTest` (3 tests, all passing, 93% coverage on the handler), validation rules `Bundle_Required` / `Product_Required`, permission set `Bundle_Demo`.

### Two platform constraints worth knowing

Product2 accepts **neither master-detail children nor cascade/restrict lookups**. Two consequences, both worked around, neither a blocker:

- `Spread_Total__c` cannot be a roll-up summary → maintained in Apex.
- `Bundle__c` / `Product__c` cannot be _required lookups_ → enforced by validation rules.

The new trigger does not disturb the existing one: `ProductTriggerHandler` only reacts to changes on `Parent__c` / `Product_Price__c`, so writing `Spread_Total__c` does not re-enter it.

## 3. The demo, as run

Two bundles that deliberately **share two products at different spreads** — the stage-sale case and the tutor Promo Summer case Fabrizio described on 07/07.

**Step 1 — each bundle reconciles to its fixed price** (variance 0):

| Bundle                                                   | Fixed selling price | Spread total | Variance |
| -------------------------------------------------------- | ------------------- | ------------ | -------- |
| `[DEMO] VENDITA DA PALCO - FOOD MARKETING FESTIVAL 2026` | 1.000               | 1.000        | 0        |
| `[DEMO] PROMO SUMMER 2026`                               | 1.990               | 1.990        | 0        |

**Step 2 — the same product carries a different spread in each bundle:**

| Bundle           | Product                    | List | Spread  | Discount |
| ---------------- | -------------------------- | ---- | ------- | -------- |
| VENDITA DA PALCO | UN ANNO CON PIENISSIMO     | 900  | **700** | 22,22%   |
| VENDITA DA PALCO | CAMERIERI VENDITORI        | 400  | **300** | 25%      |
| PROMO SUMMER     | UN ANNO CON PIENISSIMO     | 900  | **850** | 5,56%    |
| PROMO SUMMER     | CAMERIERI VENDITORI        | 400  | **340** | 15%      |
| PROMO SUMMER     | PIENISSIMO LIVE            | 600  | 500     | 16,67%   |
| PROMO SUMMER     | FOOD MARKETING FESTIVAL    | 300  | 300     | 0%       |
| PROMO SUMMER     | MANUALE OPERATIVO DIGITALE | 200  | **0**   | **100%** |

The manual is the retired-omaggio pattern done the new way: a **real product code at 100% discount**, not a €0 line — the client sees the value given.

**Step 3 — the acceptance criterion. Revenue per individual product, aggregated across bundles:**

```sql
SELECT Product__r.ProductCode, Product__r.Name,
       COUNT(Id) bundles, SUM(Spread_Price__c) revenue
FROM BundleComponent__c
GROUP BY Product__r.ProductCode, Product__r.Name
ORDER BY SUM(Spread_Price__c) DESC
```

| Product                    | In bundles | Revenue |
| -------------------------- | ---------- | ------- |
| UN ANNO CON PIENISSIMO     | **2**      | 1.550   |
| CAMERIERI VENDITORI        | **2**      | 640     |
| PIENISSIMO LIVE            | 1          | 500     |
| FOOD MARKETING FESTIVAL    | 1          | 300     |
| MANUALE OPERATIVO DIGITALE | 1          | 0       |

Statistics survive, and they survive **per bundle** — `UN ANNO CON PIENISSIMO` correctly contributes 700 from one bundle and 850 from the other. The `Parent__c` model cannot produce this table at all.

## 4. Open points to raise when showing this

_(§4 written before the junction was accepted; statuses updated in place.)_

1. **Confirm the rule with Pienissimo**: a product reused across bundles is visible in the 07/07 transcript (Fabrizio: _"un bundle potrebbe essere un anno con Pienissimo … oppure un bundle con un anno di Pienissimo che può essere camerieri di venditori più piattaforma"_), but it was never recorded as a decision. Accepted internally on 07/16 and now recorded in the tracker — but Pienissimo has still not confirmed it. (#13)
2. **Nothing yet enforces variance = 0.** The field exposes the drift and the configurator shows it in red; neither blocks a save. Decide whether a non-zero variance should be a hard error at configuration time. (#43)
3. **Order side is not built** (deliberately out of scope here): bundle as one order line expanding to components, and the one-bundle-per-order rule.
4. **The migrated spreads are ROMI's arithmetic, not Pienissimo's decision** — see §6. (#42)
5. **Demo data cleanup**: everything is prefixed `[DEMO]` / `DEMO-*` and can be removed with one query.
6. **Legacy bundle data looks wrong** and should be confirmed before it informs any real bundle: `ACADEMY 2026` sells at €1.000 against a single priced component listing at €180 (a −455% "discount", i.e. a markup), and `Bundle 1` sells at €300 against €2.170 of list price (86% off every line). Both smell like leftover test data. (#45)

## 5. Migration and retirement of the `Parent__c` model (2026-07-16)

The junction was accepted, so the legacy model was migrated and switched off. **Nothing was deleted** — the code and fields remain for Andrea's review (#44).

**Components migrated.** Every `Parent__c` child became a `BundleComponent__c` record. No spread existed to carry over, so each bundle's fixed selling price was split **pro-rata by component list price**, with the rounding remainder given to the largest component so the bundle lands on exactly zero variance:

| Bundle       | Fixed | Components (list → spread)                                    | Variance |
| ------------ | ----- | ------------------------------------------------------------- | -------- |
| Bundle 1     | 300   | Item 3 1.800 → 248,85 · Item1 190 → 26,27 · Item2 180 → 24,88 | 0        |
| ACADEMY 2026 | 1.000 | MANUALE 1°TRANCHE 180 → 1.000 · SOLD OUT OMAGGIO 0 → 0        | 0        |

⚠ **These numbers reconcile but were computed, not decided.** Real spreads must be set per bundle by the business (#42).

**UI rewired.** `BundleProductAssignmentController` and the `bundleProductAssignment` LWC no longer touch `Parent__c`. The quick action now edits spreads per component and shows bundle price / spread total / variance live as you type, in red when they don't reconcile. Its search deliberately **offers products that already belong to other bundles** — the old one hid them and silently stole them on save.

**Switched off, not deleted:**

- `ProductTrigger` → **Inactive** (its only job was the retired pricing)
- `ProductTriggerHandler` → deprecation header, logic untouched for review
- `Parent__c`, `Calculated_Bundle_Price__c` → deprecation notes in field descriptions; no longer written by anything

**Verification:** 8 Apex tests green — `BundleProductAssignmentController` 98%, `BundleComponentTriggerHandler` 93%. All four bundles in the org reconcile to variance 0.

**One incident worth recording.** During the work, the old quick action was used on the demo stage bundle, setting `Parent__c` on two `[DEMO]` products. The migration then picked those up and double-allocated onto a bundle that already had junction records, pushing it to €1.428,57 against a €1.000 fixed price. Repaired, and the demo is back to variance 0 — but it is a live demonstration of exactly why two competing models cannot coexist, and why #44 should not sit open indefinitely.

## 6. Worked example — the real ACADEMY 2026 order (built in UAT, `PACK-95`)

Taken from the actual Zoho order. This is the clearest illustration of what the new model changes, because the old order is a textbook specimen of the retired pattern.

### What Zoho shows today

Six `BLO` block codes carry **all** the money; every real product is a €0 "omaggio" line:

| Code     | Description                            | Qty | Price     | Due                |
| -------- | -------------------------------------- | --- | --------- | ------------------ |
| BLO-0308 | BLOCCO I — ACADEMY 2026                | 1   | **1.800** | acconto all'ordine |
| CS-00002 | SOLD OUT OMAGGIO                       | 1   | 0         | acconto all'ordine |
| CS-0061  | O.D.B. LIVE OMAGGIO                    | 1   | 0         | acconto all'ordine |
| CS-00129 | MANUALE OPERATIVO DIGITALE - 1°TRANCHE | 1   | 0         | acconto all'ordine |
| BLO-0309 | BLOCCO II — ACADEMY 2026               | 1   | **1.500** | 28/02/2026         |
| CS-00001 | CAMERIERI VENDITORI EXECUTIVE OMAGGIO  | 2   | 0         | 28/02/2026         |
| CS-00155 | HAPPY TEAM (OMAGGIO)                   | 2   | 0         | 28/02/2026         |
| BLO-0310 | BLOCCO III — ACADEMY 2026              | 1   | **2.000** | 31/03/2026         |
| CS-0118  | MASTERY OMAGGIO                        | 2   | 0         | 31/03/2026         |
| BLO-0311 | BLOCCO IV — ACADEMY 2026               | 1   | **1.500** | 30/04/2026         |
| CS-00058 | FOOD MARKETING FESTIVAL GOLD OMAGGIO   | 2   | 0         | 30/04/2026         |
| CS-00132 | MANUALE OPERATIVO DIGITALE - 2°TRANCHE | 1   | 0         | 30/04/2026         |
| BLO-0312 | BLOCCO V — ACADEMY 2026                | 1   | **1.500** | 31/05/2026         |
| CS-00133 | MANUALE OPERATIVO DIGITALE - 3°TRANCHE | 1   | 0         | 31/05/2026         |
| BLO-0313 | BLOCCO VI — ACADEMY 2026               | 1   | **1.500** | 30/06/2026         |
| CS-00006 | PIENISSIMO LIVE OMAGGIO                | 2   | 0         | 30/06/2026         |

The order says the client paid **€9.800** and that Camerieri Venditori was worth **nothing**. Per-product revenue is not merely hard here — it is absent by construction. Note also that the blocks are _payment dates_, not products: BLOCCO III is 2.000 because that month's instalment is 2.000, and it bundles Mastery only because Mastery happens to fall in that month.

### The same order under the junction model

**One thing splits into two**, because the Zoho order conflates them:

**(a) The bundle** — `ACADEMY 2026`, fixed price **€9.800** (the six blocks summed). The omaggio lines become real codes carrying a spread:

| Code     | Product                                | Qty | List  | Line list  | Spread (line) | Unit spread | Discount   |
| -------- | -------------------------------------- | --- | ----- | ---------- | ------------- | ----------- | ---------- |
| CS-00001 | CAMERIERI VENDITORI EXECUTIVE          | 2   | 1.200 | 2.400      | 1.900         | 950         | 20,83%     |
| CS-00002 | SOLD OUT                               | 1   | 1.500 | 1.500      | 1.100         | 1.100       | 26,67%     |
| CS-00006 | PIENISSIMO LIVE                        | 2   | 900   | 1.800      | 1.300         | 650         | 27,78%     |
| CS-0061  | O.D.B. LIVE                            | 1   | 700   | 700        | 500           | 500         | 28,57%     |
| CS-00058 | FOOD MARKETING FESTIVAL GOLD           | 2   | 1.500 | 3.000      | 2.200         | 1.100       | 26,67%     |
| CS-0118  | MASTERY                                | 2   | 800   | 1.600      | 1.200         | 600         | 25,00%     |
| CS-00129 | MANUALE OPERATIVO DIGITALE - 1°TRANCHE | 1   | 600   | 600        | 400           | 400         | 33,33%     |
| CS-00132 | MANUALE OPERATIVO DIGITALE - 2°TRANCHE | 1   | 600   | 600        | 400           | 400         | 33,33%     |
| CS-00133 | MANUALE OPERATIVO DIGITALE - 3°TRANCHE | 1   | 600   | 600        | 400           | 400         | 33,33%     |
| CS-00155 | HAPPY TEAM                             | 2   | 500   | 1.000      | 400           | 200         | 60,00%     |
|          |                                        |     |       | **13.800** | **9.800**     |             | **28,99%** |

Fixed price 9.800 · spread total 9.800 · **variance 0** (verified in UAT).

⚠ **The list prices are placeholders invented by ROMI** (#42) — the Zoho order shows every component at €0, so no catalogue price was available to migrate. The structure and the arithmetic are real; these ten numbers are not, and must be replaced before this is shown to Pienissimo. Each product record carries a `[PLACEHOLDER …]` description saying so.

**(b) The payment schedule** — the six blocks are instalments, not products, and become order lines with due dates (order side, not yet built):

| Was      | Amount    | Due                |
| -------- | --------- | ------------------ |
| BLO-0308 | 1.800     | acconto all'ordine |
| BLO-0309 | 1.500     | 28/02/2026         |
| BLO-0310 | 2.000     | 31/03/2026         |
| BLO-0311 | 1.500     | 30/04/2026         |
| BLO-0312 | 1.500     | 31/05/2026         |
| BLO-0313 | 1.500     | 30/06/2026         |
|          | **9.800** |                    |

The BLO codes disappear entirely: nothing is left for them to carry once the money lives on the components and the dates live on the instalments.

### What this example forced into the model

The screenshot exposed a gap: five lines have **quantity 2**. `BundleComponent__c` had no quantity, so `Quantity__c` was added, `Spread_Price__c` is now explicitly the **line** figure, and `Unit_Spread__c` / `Line_List_Price__c` derive from it. The discount now compares the spread against the line list price — without that, Camerieri Venditori would have reported a 20,83% discount as if it were −58%.

### Why it answers Fabrizio

Zoho: _"the client paid 9.800 for six blocks."_ Salesforce: _"the client paid 9.800, of which Food Marketing Festival Gold earned 2.200, Camerieri Venditori 1.900 (950 per head), Happy Team 400 at a 60% discount."_ Same money, same codes, same client — the difference is that the second sentence can be reported on.

## 7. Bearing on the licence question

The custom route delivers the fixed price, the per-bundle spread, the shared product and the product-level statistics — with one junction object, ~150 lines of Apex and two formula fields. Nothing here needed Revenue Cloud's pricing engine, which is consistent with Elena's 07/07 point that the bundle is _"semplicemente un contenitore che avrà un prezzo, non ci sono delle logiche del prezzo dietro le quinte."_ If the demo is accepted, the licence gap escalation (#13, >50% of revenue) can close on the custom solution.
