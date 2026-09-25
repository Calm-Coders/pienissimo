---
id: trace-2026-09-25-nightly
type: reference
status: active
updated: 2026-09-25
watermark_used: 2026-09-25T13:00Z
external_watermark: 2026-09-25T22:00Z
account: a.mrruku@romicompany.com
---

# Source trace 2026-09-25 nightly

**Watermark for the next `requirements-check` run: 2026-09-25T22:00Z, single value.**

**Watermark used: 2026-09-25T13:00Z**, the `external_watermark` stated by
[the 25/09 on-demand trace](Source%20trace%202026-09-25.md). The scheduled nightly run,
executed 2026-09-25 21:44Z.

⚠ **Environment note, recorded because it cost the first part of the run.** The session
opened on a clone that held **only `main`** — a bare Salesforce DX scaffold of 17 files at
`279783d`, with no `AGENTS.md`, no `notes/` and no `DevMain`. `DevMain` exists on the
remote and was simply not fetched. `git fetch origin DevMain` and a checkout recovered the
project. **A future run that finds an empty-looking repository should fetch before
concluding anything.**

## Sources searched

| Source     | Query / scope                                                                        | Result                                                                                                                                                                                                       |
| ---------- | ------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| **Fathom** | `list_meetings created_after 2026-09-25T13:00Z`, summaries + action items, 3 pages    | **0 meetings**                                                                                                                                                                                               |
| **Drive**  | `modifiedTime > '2026-09-25T13:00:00Z'`, 2 pages, 25 files + a title search           | 🔑 **`Interna post UAT` transcript** (read in full, 53,502 chars) · 🔑 **`Alignment pienissimo` Gemini notes + transcript** (read in full) · 🔑 **`Testbook_UAT_Lead_Opportunita`** new, in a new `03 UAT` folder · **`Business_Blueprint_Pienissimo.docx` re-saved 15:59:39Z** · **`Flows & Objects.drawio` modified 15:19:59Z** |
| **Gmail**  | `pienissimo after:2026/09/25 -in:draft`, 40 requested, 15 estimated; 4 threads opened | 🔑 **`[ROMI-PIENISSIMO] - Recap Sessioni UAT`** 17:27Z, read in full · 🔑 **two `UAT: Flussi MKT Biglietti` reschedules**, both read in full · meeting-records mail for `Interna post UAT` · 8 further invitations |
| **Slack**  | workspace-wide `after:2026-09-24`, by timestamp, 20 results                           | 4 results, **nothing new on Pienissimo after 13:00Z** — the 15:19–15:30 CEST exchange arranging the alignment call, and a Teatro Franco Parenti DM (different client, ignored)                                 |
| **Slack**  | `C0BQD34LLF4` (dev group), from 25/09 13:00Z                                          | 5 messages: the on-demand report at 15:23 CEST, then `bejm nje call ?` → `te krijoj meet?` → `yes plz`. **No human reply to the report.**                                                                     |
| **Slack**  | `slack_search_channels "tproj-pienissimo"`                                            | **No channel found by that name** — as on 24/09 and 25/09. ⚠ The skill still names it as a required scope; **it may no longer exist or may be named differently.**                                            |
| **Git**    | `fetch --all --prune`, `log --all --since 2026-09-25T13:00:00Z`                       | 🔑 **4 commits**; `DevMain` advanced `ab318f3` → **`a5f9370`**                                                                                                                                                |
| **Repo**   | `git diff` merge-base → `a5f9370`, field metadata read directly                       | 🔑 **PR #62 merged 18:07 CEST**: `Bundle_Tranch__c` + `BundleTranchController` + `bundleCreateTranch` LWC + Campaign fields · 🔴 **`Firmato` still absent from `force-app`** (grep, zero hits)                   |

## Found

1. 🟢🔑 **[OI-181](../items/OI-181%20Stage-sale%20bundles%20need%20their%20tranches%20defined%20at%20bundle%20creation.md)
   was built the same day it was raised.** PR
   [#62](https://github.com/Calm-Coders/pienissimo/pull/62) (`a5f9370`, 18:07 CEST) adds
   **`Bundle_Tranch__c`** — a tranche template on the bundle product — with
   `Data_Scadenza__c` described in its own metadata as _"Due date copied to the quote
   tranche created from this bundle template"_, plus `Tranche__c.Bundle_Tranch__c` joining
   an inherited quote tranche back to its template. 🔴 **The WooCommerce order side is not
   in the diff**, and 02/10 is the WooCommerce re-test.
2. 🔑 **[Interna post UAT Contratto e Fase Due](../meetings/2026-09-25%20Interna%20post%20UAT%20Contratto%20e%20Fase%20Due.md)**
   (17:00 CEST, 1h05m05s, Aurel Mrruku + Elena Spini): the `Contract` object is
   **Performance Plus only**, created at **`Firmato`**, `stato` reduced to
   `nuovo`/`rinnovo` off the opportunity record type — and **its builder argues it should
   not exist** ([OI-141](../items/OI-141%20Contract%20object%20for%20Performance%20Plus%20orders.md),
   [OI-168](../items/OI-168%20Contract%20logic%20is%20not%20started%20and%20is%20on%20the%205%20October%20UAT.md)).
   Put to Fabrizio Paganelli **Mon 28/09 10:00**.
3. 🔑 **Tranche states read live out of the org: `aperto` · `parzialmente pagato` ·
   `pagato`** — the Business Blueprint had all three wrong, and the order reaches
   `Incassato` only when **every** tranche is `pagato`
   ([OI-50](../items/OI-50%20Tranche%20object.md)).
4. 🟢 **The Business Blueprint was not sent to the client**, because the morning session
   had changed the quote state machine and the bundle logic
   ([OI-179](../items/OI-179%20The%20Business%20Blueprint%20goes%20to%20the%20client%20with%20unchecked%20points.md)).
5. 🔴 **Marketing UAT moved twice more — 16:34Z to 15/10, 16:52Z to 16/10** — past the
   13/10 approval deadline, with the client told in writing that the marketing flows will
   be tested **in production after the switch**
   ([OI-177](../items/OI-177%20The%20marketing%20flow%20UAT%20needs%20production.md)).
6. **New: [OI-185](../items/OI-185%20The%20participant%20name%20change%20regenerates%20the%20ticket%20as%20a%20new%20asset.md)**
   (gating, not ready for 30/09) ·
   **[OI-186](../items/OI-186%20The%20Salesforce%20user%20list%20and%20profiles%20were%20never%20agreed%20with%20the%20client.md)** ·
   **[OI-187](../items/OI-187%20The%20UAT%20testbook%20is%20with%20the%20client%20for%20comment.md)**.
7. 🟢 **Fase 2 by ROMI decision, unconfirmed by the client:** note di credito, storni and
   payment correction ([OI-157](../items/OI-157%20Credit%20notes%20and%20storni%20are%20unbuilt%20and%20undefined.md)).
8. 🟢 **QR generation at ticket creation has an owner for the first time** — Rexhina Hysi,
   from [the 15:31 alignment call](../meetings/2026-09-25%20Alignment%20Interno%20Prodotti%20e%20Bundle.md).
9. ⚠ **Project health, ROMI-internal:** both participants state the project is over
   budget; Aurel Mrruku puts the true size at about a year. Fase 2 is to be sold with
   maintenance (~5 days/month); Elena Spini reports Fabrizio Paganelli _"non vuole
   spendere"_ and has still to raise it with **Giampaolo**, for whom no person note exists.

## The register

**Amended? No. Version stays 1.6.** Finding 3 speaks directly to the open conflict in
`state_machines.tranche` (`status: conflict`, `states: [CREATO, CHIUSO/ACQUISITO]`) and to
**RC-07** in both prose documents — but the evidence is **a person reading a screen share,
not an org query**, and the register's own reconciliation text says not to configure the
label until OI-69 is resolved.

So the observation was recorded as **evidence in all three surfaces** — the YAML
`reconciliation` field, `REQUIREMENTS.md` §RC-07 and `REQUISITI.it.md` §RC-07, English and
Italian in the same session — **with the normative `states:` list and the `conflict` status
left untouched**. 🔴 **A human owes an org query, and then RC-07 and OI-69 close together.**

## Not done in this run

- The org was **not** opened, so `STATUS.md` was not regenerated and the Notion mirror
  stays stale. Every build claim here is repository arithmetic against `DevMain` at
  `a5f9370`; the tranche picklist is a quoted screen share.
- No transcript was copied into `meetings/` and no per-meeting recap was written in
  `meetings/results/`, as on every run since 27/08.
- **No Apex test class was written, proposed or scaffolded**, per the standing instruction.
- ⚠ **`DEVELOPMENT-RECAP.it.md` §47 (24/09) is still missing.** Third run flagging it; it
  is a translation backlog item, not a consequence of tonight's findings.

## Still unreachable

- **`Flows & Objects.drawio`** — **modified 15:19:59Z**, the second movement in two days,
  and still an `mxfile` the Drive reader cannot parse. **Two days of edits to the project's
  own design diagram are invisible to the record.** Ask for a PNG or PDF export.
- **`Testbook_UAT_Lead_Opportunita_2026-09-24_v2_1.xlsx`** — deliberately not opened: a
  client-facing workbook that may carry customer records. Its rows are unverified against
  the 24/09 rulings.
- **`Business_Blueprint_Pienissimo.docx`** — re-saved 15:59:39Z during the session; the
  revised text was not read, so which of the seven `● Check con Aurel` markers are now
  discharged is unknown.
- **`Alignment pienissimo` recordings** (two files) — not transcribable here; the Gemini
  notes carried the substance.
- **`#tproj-pienissimo`** — no channel of that name is findable in the workspace, third
  run running.
- **The 30/07 marketing notes**, standing.
- **The 12:30 CEST internal Elena Spini ↔ Aurel Mrruku call of 25/09** — still no artifact;
  ⚠ the 17:00 session does not appear to be it, being a different slot with its own record.

**Nothing 404'd.**
