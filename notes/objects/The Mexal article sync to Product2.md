---
id: build-mexal-article-sync
type: object
status: in-progress
owner: Anita Aga
org: ROMI
raised: 2026-09-14
updated: 2026-10-09
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

## VAT code - `alq_iva` to `Product2.Alq_Iva__c` (08/10)

Added at Aurel Mrruku's request. The sync now writes Mexal's `alq_iva` to a new
**Text(10)** field, `Alq_Iva__c`, labelled "Aliquota IVA".

- **It is a Mexal VAT code, not a percentage.** In the UAT article logs, Mexal
  sends the code padded with spaces. Of 219 rows, 215 were the exempt code
  `E00` and 4 were `17`. The sync trims the padding. What `17` stands for in
  Mexal's VAT table has **not been asked**.
- Like the other synced values, a blank `alq_iva` never clears a value already
  stored.
- Read-only for everyone, through `Full_Permission` (the same as `Natura__c`),
  and shown as read-only on the Product record page next to Natura.
- **Deployed to Pienissimo UAT only, not committed, not in Prod.** Verified by
  syncing one `E00` article and one `17` article by code in UAT: the stored
  values were `E00` and `17`.
- ⚠ **UAT has drifted from the repo on the Product record page.** UAT carries an
  `Is_Plus__c` field instance (and the field itself) that is not in the
  repository. The new field was added to UAT's own version of the page so that
  `Is_Plus__c` stays. Deploying the repository flexipage would remove it. The UAT
  field permission was granted with a `FieldPermissions` record rather than a
  permission-set deploy.

### Full re-sync in UAT, 08/10

All articles were synced once, with a cutoff of 2000-01-01 and **without moving
the nightly cursor**.

- **Results:** Mexal returned **1,052** articles. 1,051 were upserted, 0 failed,
  and 1 was skipped because its code matches a non-Item Product2.
- **Mexal's own distribution:** 914 `E00`, 15 `E10`, 4 `17`, and **119 sent with
  no code**.
- **UAT Item products after the sync:** 914 `E00`, 15 `E10`, 4 `17`, and 135
  blank. The 135 blanks break down as:
  - **118 have no code in Mexal itself** (5 of them active);
  - **17 active products are not in Mexal's response at all.**

  These lines go to Mexal with the `E01`/`E10` fallback.

- ⚠ **Run synchronously from anonymous Apex, the full sync used 9.9 s of the
  10 s CPU limit.** The nightly batch runs asynchronously with a 60 s limit, so
  it is safe. But a long-range `syncModifiedSince` started from the UI will
  fail as the catalogue grows.

## Active state from `cod_grp_merc` (09/10)

**Decision (Aurel Mrruku, 2026-10-09): Mexal's `cod_grp_merc` decides
`Product2.IsActive`. `S` = active, anything else = inactive.** Mexal uses the
field as a yes/no flag, not as a group code
([the integration](../flows/The%20Mexal%20integration.md)).

- **The sync:** `cod_grp_merc` was added to the article search fields. When the
  response carries it, it sets `IsActive` on **new and existing** products. It
  overrides `gest_annullato` / `gest_attiva` and the earlier rule that kept the
  Salesforce state on existing products. If the key is missing from the response,
  the old behaviour applies.
- **Deployed to Pienissimo UAT only, not committed, not in Prod.** Verified from
  UAT with a read-only `Mexal_Articoli_Ricerca`: status 200, `cod_grp_merc`
  present. ⚠ The nightly run only picks up articles whose `data_ult_mod` moved.
  **Not verified:** whether changing `cod_grp_merc` in Mexal moves `data_ult_mod`.
- **One-off alignment in UAT:** Mexal has 1,076 articles, 33 of them `S`. Of
  UAT's 1,068 Items, 1,051 match a Mexal article. **235 `N` Items were
  deactivated** (bulk job `750MA00000RlewvYAB`, 235/235 succeeded). After this,
  the 9 `S` Items are active and the 1,042 `N` Items are inactive.
- **Left untouched:** the **17 Items with no Mexal article**, all still active.
  They are demo and test products created by hand in July and September. Also
  untouched: the bundles, and **Prod**. Prod's only two Items are the
  `TEST MKT` products from 04/10, neither of which is in Mexal.
- 🔴 **24 of the 33 `S` articles have no Product2 in UAT** (none of the 33 is in
  Prod). The nightly sync will only create them once they are modified in Mexal.

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

## ⚠ Correction, 2026-10-09: the `cod_grp_merc` change is committed

The section above says _"Deployed to Pienissimo UAT only, not committed, not in
Prod."_ The note was written **in the commit that made the change**, so the
middle clause was stale on arrival. `c147aa0` (Aurel Mrruku, 09/10 16:56 CEST) is
**in `DevMain`** via PR #91. `DevMain` head is **`edc063b`**.

🔴 **"not in Prod" still holds.** And the decision it implements is explicitly
**temporary** — the field is a stand-in for `flag annullato`, adopted so the
client would not have to touch a field Zoho still depends on, with a production
code change implied if it is ever reverted. Aurel Mrruku asked for a business
decision on it in the room and did not get one. That is
[OI-226](../items/OI-226%20The%20gruppo%20merceologico%20stands%20in%20for%20the%20flag%20annullato%20only%20for%20the%20tests.md),
and this note should not be read as recording a settled rule.

🟢 **The client reports the Mexal side done.** Fabrizio Paganelli, 09/10
10:41:49Z: _"ho sistemato l'anagrafica su Mexal… Ho valorizzato a S il campo
Gruppo Articolo (in sostituzione provvisoria del flag annullato) Così facendo i
prodotti attivi (per fare i test) sono poco più di 30 codici."_ Aurel Mrruku
replied at 14:24:35Z that he had made the changes and **updated the products for
the UAT**. ⚠ _"in sostituzione provvisoria"_ is the client's own wording, so both
sides have the workaround on record as provisional.

⚠ **Just over 30 active codes** is the client's figure and it is close to, but
not the same as, the **33 `S` articles** this note records from the Mexal scan.
Neither number was re-measured after his correction; the article **categories**
were being hand-fixed in Mexal the same morning too.
