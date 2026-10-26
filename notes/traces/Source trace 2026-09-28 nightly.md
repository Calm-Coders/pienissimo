---
id: trace-2026-09-28-nightly
type: reference
status: active
updated: 2026-09-28
watermark_used: 2026-09-25T22:00Z
external_watermark: 2026-09-28T22:00Z
account: a.mrruku@romicompany.com
---

# Source trace 2026-09-28 nightly

**Watermark for the next `requirements-check` run: 2026-09-28T22:00Z, single value.**

**Watermark used: 2026-09-25T22:00Z**, the `external_watermark` stated by
[the 25/09 nightly trace](Source%20trace%202026-09-25%20nightly.md). The scheduled
nightly run, executed 2026-09-28 21:45Z.

⚠ **This run covers three days, not one.** 26/09 and 27/09 had no sweep. The 28/09
session that wrote the Apex suite and deployed `DevMain` to Prod was **not** a
requirements-check and left no trace note, so the watermark correctly stood at 25/09.

⚠ **Environment note, second run in a row.** The session again opened on a clone
holding **only `main`** — the bare 17-file Salesforce scaffold at `279783d`, with no
`AGENTS.md`, no `notes/` and no `DevMain`. `git fetch --all` and a checkout recovered
the project in under a minute. The 25/09 trace predicted exactly this; **the
prediction paid off.** Fetch before concluding anything about an empty-looking
repository.

## Sources searched

| Source     | Query / scope                                                                                          | Result                                                                                                                                                                                                                                                              |
| ---------- | ------------------------------------------------------------------------------------------------------ | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Fathom** | `list_meetings created_after 2026-09-25T22:00Z`, summaries + action items, 3 pages                      | **0 meetings** — fifth consecutive run with nothing                                                                                                                                                                                                                  |
| **Gmail**  | `pienissimo after:2026/09/25 -in:draft`, 40 requested, 17 estimated                                     | 🔑 **DocuSign credentials, 28/09 10:27Z** · 🔑 meeting-records mail for **`Tema Contratti + Open Point`** · the 25/09 `Recap Sessioni UAT` and reschedules (all pre-watermark, already held)                                                                          |
| **Gmail**  | `(from/to/cc:pienissimo.com OR ROMI-PIENISSIMO OR kreosoft) after:2026/09/26 -in:draft`                  | **2 threads, nothing beyond the above.** No event list, no bundle-only article codes, no catalogue prices, no Mexal WEBAPI credentials                                                                                                                                 |
| **Drive**  | `modifiedTime > '2026-09-25T22:00:00Z'`, **2 pages, 25 files**                                          | 🔑 **`Tema Contratti` transcript** (read in full, 60,638 chars) · **`Articoli Salesforce.xlsx`** 08:51Z · **`Campagne Salesforce.xlsx`** 14:44Z · **`Testbook_UAT_Lead_Opportunita`** 09:03Z · **`Flows & Objects.drawio`** 09:03Z · rest are other clients             |
| **Drive**  | `title/fullText contains 'Tema Contratti'` / `'Contratti'`, 20 results                                   | The 28/09 transcript doc + its folder and shortcut; the 08/07 `Esempi Email - CONTRATTI` PDF (old, already held)                                                                                                                                                      |
| **Drive**  | `get_file_metadata` on the lead document shared in DM 10:06 CEST                                        | ⚠ **`flusso_operativo_lead.docx` is a LIFE365 document**, not Pienissimo — see below                                                                                                                                                                                 |
| **Slack**  | `slack_read_channel C0BQD34LLF4` (dev group), from 25/09 22:00Z                                          | **1 new message:** Aurel Mrruku's ChatGPT-generated org-status report, 27/09 11:42 CEST. **No human reply to any nightly report.**                                                                                                                                    |
| **Slack**  | workspace-wide `keywords:["pienissimo"] after:2026-09-25`, by timestamp                                  | 🟢🔑 **`#tproj-pienissimo` FOUND — `C0B5T3RB4FM`** · Elena Spini's project status, 28/09 09:07 CEST                                                                                                                                                                   |
| **Slack**  | `slack_read_channel C0B5T3RB4FM`, from 25/09 22:00Z                                                     | **1 message** — the 28/09 status, read in full                                                                                                                                                                                                                       |
| **Slack**  | `from:<@U0B2WQ41HTQ> after:2026-09-25` (Elena Spini, all channels + DMs)                                 | 🔑 **4 DMs to Aurel Mrruku** (the lead document, the DocuSign confirmation, the 29/09 morning claim) · 2 `#team-romi-tech` messages on **OTP SMS providers** — not Pienissimo, ignored · her `#tproj-life365` status — different client, ignored                        |
| **Slack**  | `keywords:["contratto"] after:2026-09-25`, workspace-wide                                                | 3 results, nothing new — a `#tproj-pulingross` thread (different client) and two already-read messages                                                                                                                                                                |
| **Git**    | `fetch --all --prune`, `log --all --since 2026-09-25T22:00:00Z`                                          | 🔑 **16 commits**; `DevMain` advanced `7d79069` → **`55101d2`**; PRs **#63, #64, #65, #66** merged; new branch `DevMain_exposeEndpoint`                                                                                                                                |
| **Repo**   | `git show --stat` on 8 commits; `WoocommerceOrderService.cls` read directly; `grep` for `Firmato`/`Standart`; `Tranche__c.Stato__c` picklist read | 🔑 **the bundle order side verified line by line** · 🟢 `Standart` gone from `force-app` except two test-code references · 🔴 **`Firmato` still zero hits**                                                                                                          |

## Found

1. 🔑 **[Tema Contratti e Open Point](../meetings/2026-09-28%20Tema%20Contratti%20e%20Open%20Point.md)**
   (28/09 10:02 CEST, 1h03m02s, Aurel Mrruku · Elena Spini · **Fabrizio Paganelli**),
   drilled from the full transcript. **The Contract object survives, with its purpose
   reversed:** it is the **customer's contractual history**, one record per order, with
   the multi-year view read off the Account. Aurel Mrruku's 25/09 objection was put to
   the client and **discharged, not overruled**
   ([OI-141](../items/OI-141%20Contract%20object%20for%20Performance%20Plus%20orders.md),
   [OI-168](../items/OI-168%20Contract%20logic%20is%20not%20started%20and%20is%20on%20the%205%20October%20UAT.md)).
   Five further rulings in the same session: `data di attivazione` manual with the term
   running from it; new text fields `strategist` / `digital`; **credit notes and the
   payment correction client-confirmed Fase 2**; **permissions — `tutti vedono tutto`,
   one profile, no roles**; **`rifiutato` settled as a reason**.
2. 🟢🔑 **The gating WooCommerce order gap is closed in the repository.** `0086681` /
   PR #64 rewrites `WoocommerceOrderService.cls` (+525/−187). **Verified by reading the
   class**, not the commit message: bundle tranches from `Bundle_Tranch__c`, line
   amounts from `BundleComponent__c.Unit_Spread__c` (**payload price ignored**), and
   `Incassato` only `if (!orderBuildPlan.hasBundleTranches())`
   ([OI-181](../items/OI-181%20Stage-sale%20bundles%20need%20their%20tranches%20defined%20at%20bundle%20creation.md)).
3. 🟢🔑 **`Standart` → `Standard` is done**, seven runs after first being flagged.
   `3bd0801` replaces the `Standart` / `Recall_Tutor` opportunity record types with
   `Vendita_Standard` / `WooCommerce`, adds `Plus_Attivazione_Rinnovo` and
   `Origine_WooCommerce__c`
   ([OI-182](../items/OI-182%20A%20WooCommerce%20opportunity%20record%20type%20replaces%20Recall%20Tutor.md)).
4. 🔑 **New: [OI-188](../items/OI-188%20Performance%20Plus%20products%20are%20identified%20by%20the%20Mexal%20article%20category.md)**
   (gating) — Performance Plus is identified by the Mexal `categoria articolo`: `C10`
   attivazione, `C11` rinnovo, `C20` an ordinary sale. Aurel Mrruku **withdrew his own
   mapping-table proposal**. 🔴 Fabrizio Paganelli owes new article codes carrying a
   tranche count, **no date, UAT 05/10**.
5. 🟢 **QR generation built** (`AssetQrService`, `BarcodeGenerator` 796 lines,
   `TicketQrImage`) by Rexhina Hysi, via PR #63 — but **not** the cambio-nominativo
   regeneration, and ticket UAT is **30/09**
   ([OI-185](../items/OI-185%20The%20participant%20name%20change%20regenerates%20the%20ticket%20as%20a%20new%20asset.md)).
   `TicketQrLookupService.cls` (317 lines) exists on `DevMain_exposeEndpoint` only, **no
   PR** ([OI-161](../items/OI-161%20The%20event%20check-in%20app%20must%20integrate%20with%20Salesforce.md)).
6. 🟢 **DocuSign credentials arrived** 28/09 10:27Z, chased by Fabrizio Paganelli
   himself ~25 minutes earlier in the call. **Values recorded nowhere**
   ([OI-111](../items/OI-111%20DocuSign%20licences%20are%20not%20confirmed%20with%20the%20client.md)).
7. 🔑 **Elena Spini's `#tproj-pienissimo` status (28/09 09:07 CEST)** carries three
   facts found nowhere else: **PROD by 12/10** behind the 16/10 marketing UAT
   ([OI-177](../items/OI-177%20The%20marketing%20flow%20UAT%20needs%20production.md)),
   **Infopoint deferred to Fase 2** and named for the first time
   ([OI-161](../items/OI-161%20The%20event%20check-in%20app%20must%20integrate%20with%20Salesforce.md)),
   and **~27 days to finish** on a 21/10 go-live. Also a new **06/10 Mexal integration
   UAT** and the client's outstanding **Web Form templates**.
8. ⚠ **The 27/09 org-status report in the dev group** (Aurel Mrruku, ChatGPT-generated,
   `DevMain` `be6d570` vs UAT) is **prior evidence, not a new finding** — its gap list
   matches the record. Its two hard numbers are worth keeping: **UAT `Contract` has 0
   custom fields**, and **Apex coverage in UAT is 0 / 9,146 lines** against a 75% gate.
   ⚠ That coverage figure is *UAT*; the **Prod** deploy of 28/09 ran 142 tests at
   **88.8%**. Two different orgs, not a contradiction.

## The register

**Amended? No. Version stays 1.6.**

Four client-agreed changes from 28/09 now belong in the change set that
[OI-184](../items/OI-184%20Register%20v1.6%20goes%20to%20the%20client%20as%20one%20change%20set%20at%20UAT%20close.md)
says goes out at UAT close: the quote reason `sostituito da altro preventivo`; the
Contract's reversed purpose and cardinality; its field list; and the `C10`/`C11`
categorisation, **for which no register row exists at all**.

They were **not** written into the YAML, because two of them are structural:
restructuring `ORD-05` around a contractual-history object, and allocating a
requirement id for a mechanism the client confirmed verbally, are **not a sweep's
call** — and OI-184 already holds that v1.6 ships as one reviewed change set. 🟢 One
existing flag *was* discharged in the note: `rifiutato` is no longer unlabelled.
🔴 `DIV-07` remains open.

## Not done in this run

- The org was **not** opened, so `STATUS.md` was not regenerated and the Notion mirror
  stays stale. Every build claim is repository arithmetic against `DevMain` `55101d2`.
- No transcript was copied into `meetings/` and no per-meeting recap was written in
  `meetings/results/`, as on every run since 27/08.
- **No Apex test was written, proposed or scaffolded**, per the standing instruction.
  ⚠ Two stale `'Standart'` references were *found* in `TestDataFactory.cls` and
  **recorded only**, for whoever takes that task.
- `npm run prettier:verify` was not run (no `node_modules`), so tonight's markdown is
  unformatted.
- ⚠ **`DEVELOPMENT-RECAP.it.md` §47 (24/09) is still missing** — fourth run flagging
  it. A translation backlog item, not a consequence of tonight's findings.
- The 27/09 org-status report was **not re-verified**; it is cited as its author's
  claim.

## Still unreachable

- **`Flows & Objects.drawio`** — modified **again at 09:03:32Z on 28/09**, the third
  day running, and still an `mxfile` the Drive reader cannot parse. **Three
  consecutive days of edits to the project's own design diagram are invisible to the
  record.** Ask Elena Spini for a PNG or PDF export.
- **`Testbook_UAT_Lead_Opportunita_2026-09-24_v2_1.xlsx`** — **modified 09:03:13Z on
  28/09** and deliberately not opened (client-facing, may carry customer records).
  ⚠ **Whether that edit is the client's review or Elena Spini's revision is unknown**,
  and it is the one artifact that would show whether the client has responded.
- **`Articoli Salesforce.xlsx`** (08:51:54Z) and **`Campagne Salesforce.xlsx`**
  (14:44:12Z), both owned by Fabrizio Paganelli — **not opened.** They hold article
  codes and, for the first, very likely catalogue prices. The article-category
  semantics were obtained from the transcript instead, which is the safer route. ⚠ The
  campaign workbook moving the day before the **30/09** campaigns-and-tickets UAT is
  worth a human's eye on the edition mapping rows.
- **`Business_Blueprint_Pienissimo.docx`** — did **not** move in this window (last
  saved 25/09 15:59Z). Elena Spini says an internal revision is in progress and she
  still intends to deliver it this week; which `● Check con Aurel` markers are
  discharged remains unknown.
- **The 30/07 marketing notes**, standing.
- **The 12:30 CEST internal call of 25/09** — still no artifact, third run.
- ⚠ **`flusso_operativo_lead.docx`** (Drive `1shgAo93GEtWcJoN2Aujs2E70VI72HTXk`),
  shared by Elena Spini to Aurel Mrruku at 28/09 10:06 CEST as _"un documento che ci
  aveva condiviso uno dei loro SALES per la gestione dei LEAD … e poi dimenticato"_.
  **Its contents are LIFE365** — _"LIFE365 – Flusso operativo lead"_, by Giacomo
  Chelli, 19 June 2026, with CreditSafe checks and Sales Manager channels. The Fathom
  link in the same message is also LIFE365. **Per the skill this is a different
  client's file and is not counted as a missing Pienissimo source** — but at the start
  of the 28/09 call Elena Spini said she owed Aurel Mrruku _"la documentazione quella
  cosa lì da implementare per i lead"_ and was forwarding it. 🔴 **Either it was
  mis-sent, or a LIFE365 document is being offered as the Pienissimo lead model. A
  human should ask her which — the Pienissimo lead documentation may still be owed.**

**Nothing 404'd.**

## 🟢🔑 Retrieval correction: `#tproj-pienissimo` exists

The 24/09, 25/09 and 25/09-nightly traces all reported the channel as **not findable
in the workspace**, and the last of them suggested the skill was naming a dead scope.
**That was wrong.** The channel is `C0B5T3RB4FM`; `slack_search_channels` cannot find
it, while message search and `slack_read_channel` both can. Recorded as
[The Pienissimo Slack channel and its id](../The%20Pienissimo%20Slack%20channel%20and%20its%20id.md)
so it cannot be lost again.

⚠ **Three runs of client-facing project status were missed because of it** — low
traffic, high value. Tonight's single message carried the 12/10 PROD objective, the
Infopoint deferral and a days-to-finish estimate, none of which appear anywhere else.

## Conflict left open

⚠ At 13:01 CEST Elena Spini told Aurel Mrruku in DM: **_"Fabrizio ha confermato per
domani mattina"_** — a Tuesday 29/09 morning follow-up. In the recorded call three
hours earlier Fabrizio Paganelli said Pienissimo is **unreachable on 29/09**: _"domani
… siamo irreperibili praticamente, quindi domani non ce la facciamo in nessun modo"_,
their biggest company event of the year. **Both statements are recorded; neither is
corrected. Do not assume either.**
