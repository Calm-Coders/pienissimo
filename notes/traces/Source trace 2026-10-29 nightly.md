---
id: trace-2026-10-29-nightly
type: reference
status: active
updated: 2026-10-29
watermark_used: 2026-10-28T22:00Z
external_watermark: 2026-10-29T22:00Z
account: a.mrruku@romicompany.com
---

# Source trace 2026-10-29 nightly

**Watermark for the next `requirements-check` run: 2026-10-29T22:00Z, single
value.**

**Watermark used: 2026-10-28T22:00Z**, the `external_watermark` stated by
[the 28/10 nightly trace](Source%20trace%202026-10-28%20nightly.md), selected by
`updated:` frontmatter. Scheduled nightly run, executed 2026-10-29 ~21:45Z.
**One day.**

🟢🔑 **The release reached `Prod`, production now reaches Mexal for real, the
client delivered the Lead file on the day he promised it — and three new faults
opened the same day.**

🟢 **Environment note.** The clone opened on `main` (two commits, config only)
with none of the knowledge layer in the working tree; `DevMain` did not exist
locally and was created with `git checkout DevMain` against the fetched remote
branch. **Twenty-five runs, same opening pattern.**

## Sources searched

| Source | Query / scope | Result |
| ------ | ------------- | ------ |
| **Gmail** | `pienissimo after:2026/10/28 -in:draft`, 50 requested, 13 estimated | 🔑 **Nine new messages across six threads.** New threads: **`Bundle`** (11:04Z) · **`Test Vendite Bundle tramite woocommerce`** (14:06Z) · the **flow-error notification** (14:29Z) · the **`Test e2e PROD`** invitation (14:49Z) · the **`Rapido Allineamento Aurel / Elena`** invitation (17:29Z). New messages on **`Import Ordini`** (4 since the watermark, now 20) and **`Trasferimento dati`** (1) |
| **Gmail** | second pass, `(from:salesforce.com OR kreosoft OR merendi OR mexal OR woocommerce OR docusign OR sabatino OR referenti OR lead) after:2026/10/28`, 22 estimated | 🆕 **Three org-generated items the project-name query missed**, and a large volume of other-client noise. Kept: the **certificate notice** (13:15Z) and **three org-wide-sharing-default completions** (16:56, 17:16, 17:24Z). ⚠ **Discarded as another client**: `Twentyfourseven Srl` site publishes, its `OrderTrigger` exception and debug-log cap; `java-saas-7462--uat`; `admin.daze@`; the ROMI-ZUCCHET 3CX forward |
| **Gmail** | `get_message 1a186fc3e17d7577` (PLAIN_TEXT, ~1.77 MB message) | 🟢🔑 **The day's single most important item.** Sabatino Rinaldi 09:27:06Z delivers **`lead-da-importare.csv`** — _"ho preparato il CSV dei Lead da importare … Questi Lead sono utenti che non hanno mai acquistato nulla in Pienissimo"_ — **and states the `Lead from Zoho = TRUE` decision himself**, attributing it to a call with Elena Spini → [OI-290](../items/OI-290%20Lead%20and%20Referenti%20migration%20data%20is%20owed%20by%20the%20client.md), [OI-295](../items/OI-295%20Leads%20imported%20from%20Zoho%20must%20be%20distinguishable%20from%20new%20leads.md) |
| **Gmail** | `search_threads` listing of thread `1a168166785585be` (4 new of 20) | **The correction round.** 09:55:32Z Aurel Mrruku asks for special characters stripped and the file as Excel · 09:56:37Z _"Ok a breve sistemo"_ · 13:08:02Z _"Credo che adesso sia corretto"_ with a fresh ~1.44 MB attachment. ⚠ **Neither attachment opened** |
| **Gmail** | `get_message 1a18754d1f496ff6` (PLAIN_TEXT) | 🆕 **Three client asks from bundle testing** → [OI-299](../items/OI-299%20Bundle%20creation%20offers%20the%20wrong%20Anno%20Accademico%20values%20and%20too%20few%20Bundle%20Type%20values.md). ⚠ Three PNG screenshots **not opened** |
| **Gmail** | `get_message 1a188112eb9acee3` (PLAIN_TEXT) | 🔴🔑 **The third failure of the production ticket flow**, 07:29 org time, org **`00Dbl000005BSMH`** = production, `Schema field not found. Entity: Asset, Field: QR_Id__c` → [OI-289](../items/OI-289%20The%20production%20ticket%20dispatch%20flow%20references%20a%20field%20that%20does%20not%20exist.md). 🔑 **Answers a standing unreachable: the field does not exist in Prod** |
| **Gmail** | `get_message 1a187fc40582fdda` and `1a18822d71394556` (PLAIN_TEXT) | 🔴 The WooCommerce bundle report, symptomless → [OI-298](../items/OI-298%20WooCommerce%20bundle%20orders%20from%20a%20new%20customer%20do%20not%20reach%20Salesforce.md). 🟢 **`Test e2e PROD`, Tuesday 3 November 09:30–11:30 CET**, Elisa Migliano, Fabrizio Paganelli and Sabatino Rinaldi (optional) invited → [OI-268](../items/OI-268%20The%20client%20proposed%20a%20go-live%20calendar%20of%2016%20November.md) |
| **Gmail** | `get_message 1a1884b8e0d02735` (PLAIN_TEXT) | 🆕 **Marco Montesi's two questions** on tutor training and whether all tutors test under his account → [OI-300](../items/OI-300%20Tutor%20training%20and%20tutor%20test%20access%20are%20unplanned.md). ⚠ Two images not opened |
| **Gmail** | `get_message 1a187d4805c6bb81` (PLAIN_TEXT) | ⚠ **Vendor broadcast, no project obligation.** Salesforce `ACTION REQUIRED: Prepare for Certificate Changes` — dual-use certificate deprecation, TLS lifespans to 47 days **by March 2029**, Mozilla root set. Webinars 4–5 November. 🔑 **No dated action inside the project window**; recorded here and **not** made an item |
| **Gmail** | `get_message 1a188b0bbf11b186` (PLAIN_TEXT) | ⚠ **Three `Sandbox: Processing complete` org-wide-sharing-default changes** at 16:56, 17:16 and 17:24Z. **The bodies name no org and no object**, so they are **not attributed to Pienissimo** — recorded as an unresolved signal, nothing written to any item |
| **Drive** | `modifiedTime > '2026-10-28T22:00:00Z'`, **2 pages, 19 files** | 🔑 **Four Pienissimo items.** **`lead-da-importare.csv`** (`1P7oWyZrfg5SlKVbTJtMDK1HDllYjs5ZH`, **1,621,714 B**, created 09:27:06Z) · its **Google Sheet conversion** `lead-da-importare` (`1yLlFmZNfn1rURAR0hHfyvlg729c1H0crX7w_jsRXTAw`, **565,809 B**, 09:51:52Z) · 🆕 **`Manual Steps Pienissimo`** (`1u-LgUKVlGK9ePyjMzZ_uJjXniHluo5_449siHgAIBHo`, owner `r.hysi@romicompany.com`, **1,024 B**, modified **15:06:07Z**) · the client's **SALESFORCE** folder, unchanged since 28/10 13:54Z |
| **Drive** | `read_file_content` on `Manual Steps Pienissimo` | 🆕🔴 **New to these records, and it is a go-live artifact.** Five manual steps, `Status Uat` / `Status Prod`; **three unticked for Prod**, one of them unticked for both → [OI-301](../items/OI-301%20Three%20production%20manual%20setup%20steps%20are%20outstanding.md). 🟢 **ROMI-internal, no customer data** — read in full, ~1 KB |
| **Drive** | the rest of both pages | **Other clients or ROMI-internal.** `Zucchet Documentazione integrazione 3CX` notes and transcript · `Fase due 247` folder and notes (`l.savi@`) · `Business Blueprint - Vision` 1–4, `Open Point`, **`Registro CR - Vision`**, `Vision – Gantt di progetto, test, SAL, formazione e change request` (all `d.losco@`) · `SALESFORCE recap points to fix` (`tiziana.petruzzi@247.it`) · `[Guida] Il tuo primo agente` (`a.prastani@`). Ignored, **not counted as missing sources** |
| **Drive** | the client's `LEAD` / `REFERENTI` folders | 🔑 **Nothing new.** The parent `SALESFORCE` folder has not been touched since 28/10 13:54Z, so **the Lead file came by mail and not through the client's own folder** — consistent with Sabatino Rinaldi attaching it himself |
| **Slack** | `slack_read_channel C0BQD34LLF4` (dev group), `oldest` 1793224800 | **1 message — this sweep's own 28/10 report** (23:02:09 CET, just past the watermark). 🔴 **No human reply: thirty-nine nights** |
| **Slack** | `slack_read_channel C0B5T3RB4FM` (`#tproj-pienissimo`), same bound | **0 messages.** Silent |
| **Slack** | `slack_read_channel D0B5QHS2T7H` (Elena Spini DM), same bound + one thread | 🟢🔑 **11 messages, the richest source again.** 12:17:33 the Bundle asks triaged · 🔑 **12:18:48 the UI-batching ruling** and 13:03:07 _"lo aggiungiamo al file che ho chiesto di fare a Marco"_ → [the decision](../decisions/Decision%20-%20UI%20changes%20are%20batched%20into%20one%20ad%20hoc%20release.md) · 12:27–12:29 🔑 **the invoice-date-not-id bug, found live** · 15:20–15:36 the client left without support · 🔑 **16:02:51 the day's densest message** — the WooCommerce diagnosis with its log id, the PROD e2e confirmation, the DocuSign cost waiver, and the UI file told to the client. ⚠ 16:09 is ROMI-ZUCCHET, ignored |
| **Slack** | `slack_read_channel C0C38JJ9D1T` (marketing group DM), same bound | 🟡 **2 messages.** 12:48:58 Aurel Mrruku: _"se cambio il dominio di SF e metto pienissimo a te da problemi ?"_ · 14:34:37 Fabrizio Mastracci: _"non penso"_. 🔑 **A My Domain change to `pienissimo` is being considered** — it would rewrite every org URL. ⚠ **Nothing says it was done**; recorded here, not as an item |
| **Slack** | `slack_read_canvas F0BD2H5A9HT` (`Link utili Pienissimo`) | **Unchanged.** Newest entry still 20.08.2026 — **70 days**. Re-read per the skill |
| **Fathom** | `list_meetings created_after 2026-10-28T22:00Z`, 3 pages | **0 meetings.** 🔴 **Twenty-eighth consecutive run with no Pienissimo meeting** |
| **Git** | `fetch origin`, `log --all --since 2026-10-28T22:00:00Z`, `for-each-ref` | 🟢🔑 **`DevMain` `d9d18e3` → `7f648a8`, and `UAT` and `Prod` moved for the first time since 26/10.** `b1be858` (PR #117 → DevAnita28, 09:24) · `882f53c` _"fix match fattura con id righa"_ (12:30) · `cd8dc4c` _"deploy on prod"_ (14:30) · `8f039ce` (**PR #118** DevMain → UAT, 16:50) · `7905945` (**PR #119** UAT → Prod, 16:51) · `7f648a8` _"abbilitato le integrazioni mexal"_ (18:03) |
| **Repo** | `git show` on `7f648a8`, `882f53c`, `cd8dc4c` | 🔑 **`7f648a8` changes no code** — only `JOURNAL.md` and OI-267, so the Mexal enabling happened in an org and the commit records it. `882f53c` is the real change: `MexalInvoiceImportService`, `MexalInvoiceLineImportBatch` and `ScadenzaFatturaTriggerHandler`. **All three commits updated their own notes**, so the 29/10 repo-side work was **already held and was not re-ingested** |
| **Repo** | `grep -n -B2 -A10 resolveLineDiscount MexalOrderSendService.cls` | 🔴 **[OI-287](../items/OI-287%20The%20Mexal%20line%20discount%20is%20sent%20as%20a%20line%20total%20instead%20of%20per%20unit.md) unchanged** — the multiplication by `Quantity` and the comment asserting Mexal divides are both still there. **Fourth night, and now in a production org that reaches Mexal for real** |
| **Repo** | register greps (`version`, `go_live`, `zoho_expiry`, `SAL-12`) | **None changed.** Version **1.6**; `go_live: 2026-11-16`; `zoho_expiry: 2026-10-31` — 🔴 **two days away**; `SAL-12` still _"Tutors on fixed price list, no discretionary discounts"_, `status: agreed` |
| **Repo** | `ls notes/items` max-id scan | Max existing id **297**, so this run allocated **298**, **299**, **300** and **301**; next free is **302** |

## Found

1. 🟢🔑 **The release reached production, and production reaches Mexal.** `UAT` and
   `Prod` both moved — PR #118 and PR #119, 16:50 and 16:51 CET — after a quick
   deploy at 14:30. The `MexalToken` was entered on the Prod principal and a
   read-only call returned HTTP 200. 🔑 **The consequence is behavioural, not
   administrative**: a customer or order created in production now sends to Mexal
   for real, so **a production test order is a real Mexal document**, and nobody
   has said who cleans those up.
2. 🟢🔑 **The client met his written commitment, and with his own voice.**
   `lead-da-importare.csv` arrived 09:27:06Z from **Sabatino Rinaldi himself** —
   **the first message in his own words to reach this mailbox**. Both halves of
   the migration data are now delivered. ⚠ Two correction rounds ended on
   _"Credo che adesso sia corretto"_, which is not a verification, and neither
   file was opened.
3. 🟢🔑 **[OI-295](../items/OI-295%20Leads%20imported%20from%20Zoho%20must%20be%20distinguishable%20from%20new%20leads.md)'s
   "the client has not been told" is superseded by the client himself.** He states
   the `Lead from Zoho = TRUE` solution unprompted, attributes it to a 28/10 call
   with Elena Spini, and gives the operational reason — _"i commerciali sanno che
   non sono da lavorare (per il momento)"_. 🔴 **The field is still not built and
   the file it must mark is in hand.**
4. 🔴🔑 **[OI-289](../items/OI-289%20The%20production%20ticket%20dispatch%20flow%20references%20a%20field%20that%20does%20not%20exist.md)
   failed a third time, and that answers a standing unreachable: `Asset.QR_Id__c`
   does not exist in production.** 🔑 **And it is not release-induced** — a second
   release landed the same day and the flow fails identically, because the flow is
   org-only and no deploy touches it. ⚠ **Three notifications, three days, no
   recorded action.**
5. 🆕🔴 **New: [OI-298](../items/OI-298%20WooCommerce%20bundle%20orders%20from%20a%20new%20customer%20do%20not%20reach%20Salesforce.md)**
   — a WooCommerce bundle order from a **new customer** never reaches Salesforce.
   Integration log `a05MA00000GsbhJYAR`, UAT sandbox, **unread**. Now on the 30/10
   WooCommerce agenda, which Elena Spini widened to Elisa Migliano and Fabrizio
   Paganelli.
6. 🆕🔴 **New: [OI-301](../items/OI-301%20Three%20production%20manual%20setup%20steps%20are%20outstanding.md)**
   — a ROMI checklist new to these records leaves **three production steps
   unticked**: the `ParticipantDocumentRequestTrigger` subscriber user, the
   WooCommerce default agent, and **the nightly Mexal jobs, unticked for both
   environments**. 🔑 Independently corroborated: a production inspection the same
   day found no Mexal job scheduled at all.
7. 🆕🟡 **New: [OI-299](../items/OI-299%20Bundle%20creation%20offers%20the%20wrong%20Anno%20Accademico%20values%20and%20too%20few%20Bundle%20Type%20values.md)**
   — bundle creation still offers calendar years in `Anno Accademico`, `Bundle
   Type` holds two values, and a 16:9 screen was asked for. ⚠ **The client named
   no replacement values for either picklist.**
8. 🆕🟡 **New: [OI-300](../items/OI-300%20Tutor%20training%20and%20tutor%20test%20access%20are%20unplanned.md)**
   — tutor training has no plan, owner or date, and 🔴 **the client proposed that
   all tutors test under his own account**. Unanswered either way.
9. 🟢🔑 **An end-to-end production test is booked for Tuesday 3 November
   09:30–11:30 CET**, the first with the client in the room, and 🟢 **the client
   authorized unlimited production test orders and waved away the DocuSign cost**
   — ⚠ with a joke ceiling of _"fino a 10€"_ that is not a budget, and relayed
   through a ROMI DM rather than in writing.
10. 🔑 **A ruling reached the client the same day it was made**: UI changes are no
    longer taken one at a time; the client collects them into a single file —
    Marco Montesi's — for one ad hoc release. ⚠ **No date, and it is not a Change
    Request ruling.** Field and data changes were explicitly **not** batched, and
    nobody defined where "UI" ends.
11. 🔑 **The 29/10 invoice fix has a provenance worth keeping**: the rate match was
    on the invoice **date** and not the line **id**, and Aurel Mrruku found it
    believing he had already changed it — _"ed ero sicuro di averlo cambiato ---
    ma a quanto pare no."_ Already recorded on OI-244 by the commit itself.

## The register

⚠ **Nothing found tonight calls for a register change, and nothing was changed.**
OI-298 through OI-301 are a defect, two configuration asks and a setup checklist.
Version stays **1.6**; `go_live: 2026-11-16` and `zoho_expiry: 2026-10-31` as
earlier runs left them.

🔴 **`SAL-12` was not amended and is now uncited for a tenth session.** Reported
for a human, as on every run since 19/10. ⚠ **`DM-07`'s competitor-list conflict
is unchanged.**

🔑 **The absences remain findings**, and two new ones join tonight. No register row
covers the **order-to-Mexal price breakdown** (OI-284/OI-287), **ticket migration**
(OI-274), **Lead or Contact migration** (OI-290, with OI-295 inside it), **note
capture** (OI-292), **template editability**, **a client-side run of the invoice
and incassi jobs** (OI-294), 🆕 **bundle picklist content** (OI-299) or 🆕 **tutor
training** (OI-300).

⚠ **The Italian wording in `REQUISITI.it.md` still needs a human's eye** —
unchanged, nine runs on.

## Corrections to the record

- 🔑 **`--partial` is the Pienissimo UAT sandbox, and that changes a reading.** The
  WooCommerce integration log sits on
  `ability-customization-52152--partial.sandbox`, which the org-verification header
  of [the tracker](../../meetings/open-items.md) identifies as
  `a.mrruku@pienissimo.uat`. **So OI-298 and OI-296 are failures in the same org,
  one day apart, both on a new customer, both with unread logs.** A shared cause is
  **not** established — the directions are opposite — but they are no longer two
  unrelated environments, and the earlier draft of OI-298 that called `--partial`
  "neither UAT nor production" was corrected in this run before it was committed.
- 🔑 **"Prod and UAT have not moved since 26 October" no longer holds.** Carried by
  the 27/10 and 28/10 records as evidence that the production load was a rehearsal.
  Both branches moved on 29/10. The rehearsal reading **stays true for 28/10** and
  is simply overtaken; the dates are cited on both sides.
- 🔑 **The production target of _"spero entro venerdì"_ was beaten by a day.** The
  28/10 record closed on a slip to Friday 30 October; the release went on Thursday
  29 October. ⚠ **What went to production is the branch delta, not the historical
  data load** — nothing tonight says the 7,721 orders were loaded into Prod.
- ⚠ **The 28/10 reading of OI-295 as "decided in a ROMI DM and not communicated"
  was true when written and is now superseded** — by a phone call that happened
  **the same day** the note said the client had not been told. 🔑 **The lesson is
  about the medium, not the fact**: a decision taken by phone leaves no trace in
  these sources, and this sweep only caught it because the client repeated it back.
- ⚠ **Three org-wide-sharing-default changes are recorded without an org.** The
  notification bodies name neither the organisation nor the object. They are
  **not** attributed to Pienissimo and nothing was written to any item.
- ⚠ **The Salesforce certificate notice is a vendor broadcast, not a project
  obligation.** Its only near dates are webinars on 4–5 November; the substantive
  deadline is March 2029. Recorded in the sources table, **not** made an item.
- 🔴 **The pre-existing defects are unchanged**: rows **163–174 remain duplicated**
  in `meetings/open-items.md` **and** `.it.md` with the copies still differing; the
  **Risks table in `INDEX.md` is still malformed**; row `| 83  |` is still padded;
  **both `DEVELOPMENT-RECAP` files still carry a precedence line ending at §45**
  while they now end at **§73** — sixth run flagged, still an editorial ruling
  rather than a mechanical edit.
- 🆕⚠ **`INDEX.md` stopped indexing trace notes after 2026-10-22.** The 23/10,
  26/10, 27/10 and 28/10 traces have no row. **Tonight's row was added; the four
  gaps were not backfilled** — writing four other runs' descriptions is not this
  run's to invent. Flagged for a human.
- ⚠ **`JOURNAL.md` holds ~140 entries against the protocol's "keep the twenty most
  recent"**, and is ~420 KB. **Fifth run to flag it.**
- ⚠ **`MAP.md` still carries two `## Where the project stands` headings**;
  tonight's entry went into the **first**, which is the live block.

## Not done in this run

- The org was **not** opened. `STATUS.md` was not regenerated and the Notion mirror
  stays stale. 🔑 **It matters more than usual tonight**: whether `Asset.QR_Id__c`
  can simply be created in Prod (OI-289), what logs `a05MA00000GsbhJYAR` and
  `a05MA00000GqqcPYAR` say (OI-298, OI-296), whether the three manual steps of
  OI-301 are genuinely undone, whether the nightly Mexal jobs are scheduled in
  Prod, and whether account send is back on in UAT.
- **No Apex test was written, proposed or scaffolded**, per the standing
  instruction. [OI-64](../items/OI-64%20The%20bundle%20Apex%20test%20suite%20is%20broken.md),
  [OI-66](../items/OI-66%20No%20test%20classes%20for%20the%20Biglietto%20stack.md) and
  [the deploy risk](../risks/Risk%20-%20production%20deploy%20is%20blocked%20by%20Apex%20coverage.md)
  are unchanged; the risk stays `resolved`. ⚠ Recorded as an absence: the 29/10
  deploy passed **168/168 tests at 77.8%**, and OI-287's test still asserts the
  payload rather than the arithmetic.
- **OI-212 was not fixed**, a seventeenth night, in production.
- **`lead-da-importare.csv`, its Sheet conversion and the 13:08Z corrected
  attachment were not opened** — real Lead records. Recorded by id, size, owner and
  timestamp only; **row count unknown**.
- **`Referenti Salesforce_V2.xlsx`, `Contatti_Zoho_CRM_`, `Account
  Salesforce_V2.xlsx`, `Categorie Prodotto.xlsx`, `Utenti Area Commerciale.xlsx`
  and the OI-265 picklist workbook were not opened** — real customer, contact or
  staff records, or no tool here fetches them. **Eighth day for the picklist
  workbook; OI-265 unmoved.**
- **The 380 MB Import Ordini recording of 28/10 was still not opened** — no tool
  here reads an MP4, and its transcript is empty. **Second night.**
- **The `DEVELOPMENT-RECAP` precedence headers, the `INDEX.md` Risks table, the
  duplicated tracker rows and the four missing trace rows were not repaired.**
- **`prettier:verify` was not run** (no `node_modules`); `vault:check` is
  dependency-free and was.

## Still unreachable

🆕 **What integration log `a05MA00000GsbhJYAR` says** — the one artifact that would
explain the WooCommerce failure · 🆕 **whether the three unticked production manual
steps are genuinely undone**, and 🆕 **whether `QuoteNegotiationAgingBatch` was
restored** after the deployment · 🆕 **whether the Lead file carries the `codice
cliente esterno` join**, and how many rows it holds · 🆕 **what should replace the
calendar years in `Anno Accademico`, and which `Bundle Type` values to add** · 🆕
**how tutor training will be organised, and whether the tutors get users of their
own** · 🆕 **whether the Salesforce My Domain was actually changed to `pienissimo`**
· 🆕 **which org the three sharing-default changes were made in** · 🆕 **whether the
historical data load has been run in production at all**, as distinct from the
branch delta · **whether `Asset.QR_Id__c` can simply be created in Prod** — the
field is now confirmed absent there · **whether account sending to Mexal is back on
in UAT**, and what `a05MA00000GqqcPYAR` says · **whether UAT stops writing to the
same Mexal company as production** · **what was actually said in the 28/10 14:07
call** — 57 minutes, 380 MB, no transcript · **what `ID riga Mexal` was agreed to
mean** · **who `cdg@pienissimo.com` is** · **what shape the `Lead from Zoho` marker
takes in metadata, and its API name** · **whether the OLD edizione links get
deleted or deactivated, and what "link" means** · **who absorbs the ten-plus
man-days the migration has cost** · **whether Mexal's accounting-year archive
behaves as the code assumes** — never put to Kreosoft · **whether the production
file will arrive with the `610.00001` transformation already applied** · **the
WooCommerce production endpoints** — the 30/10 meeting now carries two subjects ·
**whether the retired agent codes are in the delivered list** · **what the
Categoria Prodotto description inconsistencies are** · **whether the product
synchronisation flows are actually on** · **what _"template completamente
personalizzabili"_ means** · **Rexhina Hysi's leaving date, her replacement, and
who inherits `Devmain_LeadChecks` and `Devmain_QuoteTriggerChanges`** · **who
Claudio is**, and **which Andrea** the Fase 2 estimate went to · **how many
commitments sit in the Zoho tutor calendars, and who re-enters them** · what Mexal
actually does with a `sconto` on a quantity-above-one line — the one measurement
that settles OI-287 · the Mexal discount field name, pasted into a meeting chat and
captured nowhere · how many Azienda accounts have a blank `Agente__c` · what
happens to the data-model fields Zoho cannot fill · whether Lead consent fields
survive the migration · whether Gianpaolo Motta's Fase 2 ruling will be said to the
client · whether the client accepts the Change Request regime (**sixth day of
silence**) · which profile the UAT user `005MA00000Gh60y` holds · where the
`rinunciato` asset write lives · which of the three dummy-edizione mechanisms is the
one · who reverses the whole-catalogue activation, and when · how many credit notes
leave the 2024 history · the contents of the picklist workbook · whether the ~80
live Performance Plus contracts are migrated, hand-entered or abandoned · whether
the client's lawyer permits the legal-representative fields · the client's ticket
field/value structure (undertaken 21/10, **eight days**) · what `Pienissimo 360` is
· 🔴 **whether Pienissimo hold a Zoho contract past 31 October** (**eleventh run,
two days out**) · which four `Dettaglio Motivazione Uscita` values OI-259 means ·
whether a contract-expiry alert rule exists in the org (OI-272) · which production
user is to be copied for the marketing tests · what _"utente metà bloccato"_ means
for WhatsApp · whether a test order created in production reaches live Mexal — 🔑
**now answerable, and the answer is probably yes** · whether Sabatino Rinaldi's user
exists · what Fabrizio Mastracci's _"nuova change request"_ referred to · the 30/07
marketing notes `1uJCE4NW9nbdI38ADmt66svUT1MRmkyYd24uI0hegAD0` · Zoom tier ·
training hours · who owns tutor training now · the Woo instance · DocuSign prod
config · `Get Campaign` and the campaign-ID gap · Jira `PIEN` ·
`Flows & Objects.drawio` · the _diretta_ form.
