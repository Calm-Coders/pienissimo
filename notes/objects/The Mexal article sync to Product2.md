---
id: build-mexal-article-sync
type: object
status: in-progress
owner: Anita Aga
org: ROMI
raised: 2026-09-14
updated: 2026-09-14
depends_on: [OI-116, OI-121]
requirement: [INT-01, BIG-02]
source: commit e06a1b4 on DevAnita, PR #43, read at 2026-09-14
---

# The Mexal article sync to Product2

**A second scheduled Mexal batch arrived on 14 September, alongside the customer
one: it pulls the Mexal article anagrafica and upserts it onto `Product2`.**

Built by `e06a1b4` (Anita Aga, 18:05 CEST, **PR #43 — open and unmerged**). Two
new classes, `MexalArticleSyncBatch` (110 lines) and `MexalArticleSyncService`
(534 lines). Read from the commit; **not inspected in any org**.

## What it does

- **Action name `Mexal_Articoli_Ricerca`** — one of the six rows already present
  in `Integration_Configuration2__c`, so it is configured by name on arrival.
- **It shares the customer sync's watermark.** `MexalSyncCursorService` supplies
  `getLastSuccessfulSync(actionName, fallbackHours)` with a 24-hour fallback, and
  the batch calls `markSuccessful` / `markFailed` per action. The cursor is
  per-action, so articles and customers advance independently
  ([OI-116](../items/OI-116%20Nightly%20Mexal%20to%20Salesforce%20anagrafica%20sync.md)).
- **It upserts on `Product2.External_Product_Code__c`** via `Database.upsert`
  with partial success, and counts `upsertedProducts`, `failedSaves`,
  `skippedRows` and `saveErrors` into a `Result` object.
- **Every run logs** through `MexalIntegrationLogger`, info on a clean run and
  error otherwise, and a failure is recorded on the cursor rather than thrown
  away.
- `syncByArticleCode(String)` exists alongside `syncModifiedSince(Datetime)`, so
  a single article can be refreshed on demand.

## 🟢 It guards the bundle boundary

The service counts a `skippedBundleMatches` case and refuses the row with
_"Articolo Mexal non sincronizzato perche il codice corrisponde a un Product2 non
Item"_ — a Mexal article whose code collides with a non-Item `Product2` is
**skipped, not merged**. That is the failure mode
[the article-code merge risk](../risks/Risk%20-%20normalising%20an%20article%20code%20merges%20two%20products.md)
describes, and this is the first code in the project to defend against it.

## 🔴 What it is not

- **It is not the edition mapping.** It writes `Product2`; it does not create
  `Mappatura_Edizione__c` rows. **40 of 43 ticket-generating products are still
  unmapped** and
  [OI-121](../items/OI-121%20The%20edition%20mapping%20table%20has%20no%20rows%20and%20no%20owner.md)
  is untouched by this build. Do not read "article sync exists" as "the mapping
  problem moved".
- **It is not scheduled.** Like the customer batch, it has no `CronTrigger`. One
  `System.schedule` call, an hour to choose, and nobody has chosen.
- **It is not in `DevMain`** and it has no test class — recorded as brief only in
  [OI-64](../items/OI-64%20The%20bundle%20Apex%20test%20suite%20is%20broken.md).
- ⚠ **Nothing states where the Mexal article list comes from relative to the
  catalogue the client owes.** The bundle-only article codes and the catalogue
  prices are still outstanding by mail; whether this sync makes them unnecessary
  is **unasked**, not answered.
