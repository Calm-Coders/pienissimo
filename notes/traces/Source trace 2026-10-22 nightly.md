---
id: trace-2026-10-22-nightly
type: reference
status: active
updated: 2026-10-22
watermark_used: 2026-10-21T22:00Z
external_watermark: 2026-10-22T22:00Z
account: a.mrruku@romicompany.com
---

# Source trace 2026-10-22 nightly

**Watermark for the next `requirements-check` run: 2026-10-22T22:00Z, single
value.**

**Watermark used: 2026-10-21T22:00Z**, the `external_watermark` stated by
[the 21/10 nightly trace](Source%20trace%202026-10-21%20nightly.md), selected by
`updated:` frontmatter. Scheduled nightly run, executed 2026-10-22 ~21:45Z. One
day.

🟢🔑 **The migration moved from design to data, and the import key turned out not
to be unique on its own.**

🟢 **Environment note.** The clone opened on `main` (two commits, config only)
with none of the knowledge layer in the working tree; `DevMain` did not exist
locally and was created with `git checkout -B DevMain origin/DevMain` against the
fetched remote branch. **Twenty runs, same opening pattern.**

## Sources searched

| Source | Query / scope | Result |
| ------ | ------------- | ------ |
| **Gmail** | `pienissimo after:2026/10/21 -in:draft`, 50 requested, 13 estimated | 🔑 **Five new items.** The **picklist workbook**, resent by Elisa Migliano 07:42:18Z · **two calendar invitations** for the same call (08:43:22Z 14:30, updated 09:32:03Z 15:00) · the **`Importazione dati Storici`** scheduling exchange (2 new messages) · the **Gemini meeting-notes mail** 13:51:37Z · the new **`Richiesta Call`** thread (2 messages) · **one more Anticipay 404** 10:23:52Z |
| **Gmail** | `get_message 1a1628f97114b701` (PLAIN_TEXT, attachments listed) | 🟢🔑 **The workbook this project has chased for thirteen sweeps exists and is identified.** `Mappatura_Categorie_Sottocategorie_Origine Lead_Tipologiattività.xlsx`, from `amministrazione@pienissimo.com` to Elena Spini, cc Aurel Mrruku, Fabrizio Paganelli, Marco Montesi: _"Allego nuovamente il file"_ — **resent, not corrected**, answering Marco Montesi's 21/10 _"qui deve essere saltato qualcosa"_. ⚠ **Contents not read**: this sweep has no tool that fetches a Gmail attachment. Eight inline images and a `~WRD0003.jpg` also unopened → [OI-265](../items/OI-265%20Opportunity%20Categoria%20and%20Sottocategoria%20values%20do%20not%20match%20the%20client%20registry.md) |
| **Gmail** | `get_thread 1a16424bb89d3e8a` (PLAIN_TEXT, both messages) | 🔑 **A new client call is requested for Monday 26 October, on discounting.** Fabrizio Paganelli → Elena Spini 15:04:49Z, cc Mirko Merendi: _"ho parlato con Mirko poco fa per il tema prezzo di listino, sconti, e importo netto da passare sugli ordini. Avreste disponibilità per una call il prossimo lunedì 26?"_ Elena Spini 16:54:27Z: _"per noi è ok … tranne 14-15."_ ⚠ **No slot fixed**, and ⚠ **nothing records what Kreosoft said** → [OI-284](../items/OI-284%20The%20listino%20sconto%20and%20netto%20mapping%20for%20Mexal%20orders%20is%20undefined.md) |
| **Gmail** | thread `1a15f68fbc913929` (from the search preview) | 🟢 **The 21/10 mail was answered and the call happened.** Elena Spini 08:42:29Z: _"metto un slot post-pranzo con Aurel (io non ci sarò)"_; Fabrizio Paganelli 08:57:00Z: _"potete posticipare alle 15.00?"_ ⚠ She said she would not attend and **did** attend |
| **Gmail** | the 10:23:52Z sandbox mail (subject read; `TEST - Azienda non trovata`, account `001MA000013uSdlYAE`) | 🟢 **Expected UAT behaviour, not a defect** — the Anticipay call is redirected at the client's own database to save credits, established 21/10. **Five such mails in three days.** Body not re-read |
| **Drive** | `modifiedTime > '2026-10-21T22:00:00Z'`, **2 pages, 23 files** | 🔑 **One Pienissimo item**: `[ROMI-PIENISSIMO] - Check Excel Migrazione - 2026/10/22 15:00 CEST - Appunti di Gemini` (Doc `1L2z6cxW5yt54UmhUa3J6lNxf5ghz1u9NM-634X2APSA`, 26,144 bytes, owner Elena Spini, shared 13:50:37Z), with its folder and shortcut. ⚠ **No MP4**, as on 19/10, 20/10 and 21/10 |
| **Drive** | `read_file_content` on that doc, then split | 🔑 **Read in full, once.** ~45,000 characters: the Gemini notes read directly, the transcript **preserved verbatim** at `meetings/2026-10-22-check-excel-migrazione-transcript.it.md` (30.8 KB). Completeness checked: it ends on _"Trascrizione terminata dopo 00:40:19"_ |
| **Drive** | `get_file_metadata` on `DTT_SHR_Mappatura_form_handler_campi_v3.xlsx` (`1VN4Kdv4UNVPaIC34O4g8z65jbykpM2T3`, owner Elena Spini, shared with this account 13:32:51Z, modified 13:55:22Z) | 🟢 **Classified at last, after three nights unclassified: another client.** The content snippet names Pardot form handlers, the brands `EL`/`SHR`/`WL`/`LBT`/`DTT` and _Laborability_. **Not Pienissimo.** One metadata call was worth it precisely because the earlier `OLD_DTT…` file had been left open, and because it is now owned by this project's PM and shared with its dev lead — which is what made it look live |
| **Drive** | `Referenti Salesforce.xlsx` (`1TTtHAc0Rmh7NV2b5_K0FIbVQrYoWtsC2`) | **Unchanged since 21/10 13:59:19Z.** ⚠ **Deliberately not opened** — 10 MB of real customer contact records, recorded by id, size and modified time only, per the standing constraint |
| **Drive** | `[ROMI-WILEGAL]`, `Allineamento 247 interno`, `[Vision] - Fase Progettuale` (Open Point, Registro CR, Blueprint parts 1–4, Mule credits, `claude_task-sales-cloud-vision.md`), `ZONE AGENTI`, `Organigramma e ruoli.pdf`, `Preassegnazione lead.pdf`, `[ROMI] Slide Team`, 247 extracts | **Other clients or ROMI-internal.** Ignored, and **not counted as missing sources** |
| **Slack** | `slack_read_channel C0BQD34LLF4` (dev group), `oldest` 1792620000 = 2026-10-21T22:00Z | 🟡 **6 messages, 5 human.** 12:30:33–12:31:18 CEST: Aurel Mrruku posted a **bilingual roll-up of outstanding client requests** (IT then EN), generated with Claude — a status summary, not new requirement input, though it states **`Product_Record_Page` still lacked the `Livello_0…6__c` fields with 1,010 products already populated**, which his own commits then fixed hours later. 14:59:42–15:04:27: Anita Aga _"a e ke prekur fullin"_ → Aurel Mrruku _"e kam prek dhe un"_ → _"okej"_ — 🔑 **the human trace of the `Full_Permission` collision the 22/10 journal records**, two people deploying the same permission set. The sixth message is this procedure's own 21/10 report. 🔴 **Still no reply to any nightly report — thirty-two nights** |
| **Slack** | `slack_read_channel C0B5T3RB4FM` (`#tproj-pienissimo`), same bound | **0 messages.** Silent |
| **Slack** | `slack_read_channel C0C38JJ9D1T` (marketing group DM), same bound | **0 messages.** Silent a second day |
| **Slack** | `slack_read_channel D0B5QHS2T7H` (Elena Spini DM), same bound | **31 messages, and the Pienissimo half is small but decisive.** 09:09:14 _"Fabrizio vuole farti vedere l'excel che ha fatto dice 15 min"_ · 10:38:44 she fixes the slot, _"io non ci sono"_ · 10:40:26 🔑 _"ti chiederei anche di chiedergli info sul file che ci ha girato Elisa"_ · 10:41:06 🔴 **_"vogliono cambiare i valori di un campo picklist su lead e opty ma quel file fa cagare quindi capire che vogliono"_** · 11:16:46 _"Fabrizio chiede di posticipare alle 3 -.-"_ · 11:26:54 Aurel Mrruku, _"appena ho del tempo do un'occhiata"_. ⚠ **The remaining ~20 messages (11:18–12:58) are a different project** — opened _"ciao . Life"_, covering LIFE365, Luca's integration doubts, `flusso_operativo_lead.docx` and lead-lifecycle redesign. **Read and not ingested**; see the note below |
| **Slack** | `slack_read_canvas F0BD2H5A9HT` (`Link utili Pienissimo`) | **Unchanged.** Newest entry still 20.08.2026 — **63 days**. Re-read per the skill; still the only source of the 30/07 marketing notes link |
| **Fathom** | `list_meetings created_after 2026-10-21T22:00Z`, summaries, 3 pages | **0 meetings.** 🔴 **Twenty-third consecutive run with no Pienissimo meeting**, on a day with a 40-minute recorded Pienissimo client call captured by Google |
| **Git** | `fetch origin`, `log --all --since 2026-10-21T22:00:00Z` | 🟢 **8 commits, 2 new branches, no PRs.** `DevMain` moved `228be1d` → **`653f8e2`**: `d0706d1` (12:02), `3b5baa1` (12:22), `d3efbb0` (12:52), `653f8e2` (14:43) — **all four by Aurel Mrruku, pushed straight to `DevMain`**. Unmerged: `2a24195`, `041a7d5`, `aaa8be1` (Anita Aga, `DevAnita22`), `ff13eb1`, `3d4cf9b` (Rexhina Hysi, `Devmain_LeadChecks`) |
| **Repo** | `git show --stat` on the four `DevMain` commits | `d0706d1` the four-part order key — `MexalInvoiceLineImportBatch`, `Mexal_Document_Date__c`, `ID_Ordine_Mexal__c`, plus **MAP, JOURNAL and OI-275's own note** · `3b5baa1` **AGENTS.md, JOURNAL and OI-275 only** · `d3efbb0` the product page, `Gruppo_Merceologico__c`, `MexalArticleSyncService`, **plus OI-279 and the 13/10 meeting note** · `653f8e2` layouts and the unit-of-measure value set. 🔑 **Three of the four carry knowledge-layer edits made by a human outside this procedure** |
| **Repo** | `git log -1 origin/DevMain -- MexalScadenzarioSearchService.cls` | 🔴 **OI-212 unchanged a twelfth night** — still `f292b72`, 08/10 |
| **Repo** | `grep AUTOMATIC_MEXAL_CREATION_ENABLED OrderMexalIntegrationService.cls` on `653f8e2` | 🔴 **OI-267 unbuilt** — still `true` |
| **Repo** | `ls notes/items` max-id scan | Max existing id **282**, so this run allocated **283** and **284**; next free is **285** |
| **Repo** | register greps for a changed requirement | **None.** No requirement's text, priority or status changed; version stays 1.6; `go_live: 2026-11-16` and `zoho_expiry: 2026-10-31` as left on 21/10 |

## Found

1. 🟢🔑 **The migration has data for the first time.**
   [OI-244](../items/OI-244%20Historical%20orders%20will%20be%20migrated%20from%20Mexal%20by%20spreadsheet.md)'s
   scope question, open since 15 October, is answered — **the extract starts
   1 January 2024** — and eight exclusion rules were agreed in forty minutes:
   keyless rows dropped, all invoices and scadenzari imported regardless, tranche
   date = invoice date, payment condition forced to `12`, missing agent → `610`,
   credit notes deferred, ~1,000 `SW` lines deleted, orders before lines.
2. 🔴🔑 **The import key is not unique on its own.**
   [OI-275](../items/OI-275%20The%20Mexal%20order%20key%20is%20not%20unique%20without%20the%20order%20date.md)
   was built and closed on 21/10; on 22/10 the client showed it repeating across
   customers, because invoices issued without an order leave all four fields
   empty. Both structural repairs were refused and **it is fixed by excluding the
   rows** — so **uniqueness now lives in the client's spreadsheet**, with nothing
   in Salesforce enforcing or detecting it.
3. 🔴 **New:
   [OI-283](../items/OI-283%20Discounts%20cannot%20be%20edited%20on%20an%20existing%20order.md)
   — discounts cannot be edited on an existing order.** Found by the client
   walking his own tutors' most likely mistake; confirmed in the room as
   incomplete work. ⚠ **He then declined to say what the right behaviour is**, so
   the requirement is still unstated.
4. 🔴 **New:
   [OI-284](../items/OI-284%20The%20listino%20sconto%20and%20netto%20mapping%20for%20Mexal%20orders%20is%20undefined.md)
   — listino / sconto / netto has no Mexal mapping**, and ROMI and the client
   disagree in the open about percentage versus amount. 🟢 A call is requested
   for **26 October** and ⚠ has no hour.
5. 🟢🔑 **The picklist workbook arrived after thirteen sweeps — and ROMI cannot
   use it.** 🔑 **The problem has changed shape**: not whose list is current, but
   that the client's own source file does not say. The blocking step is now a
   question to the client, assigned to Aurel Mrruku and unanswered.
6. 🟡 **A competing edizione mechanism is on the record.** An `old` flag versus
   the dummy editions agreed on 21/10; the client did not engage and **neither
   was withdrawn** ([OI-276](../items/OI-276%20Dummy%20import%20editions%20are%20needed%20to%20load%20historical%20orders.md)).
   With it, a new precondition: **all products must be activated before the
   load**, ⚠ with nobody named to reverse it — **the fourth migration-only
   condition without an owner for its removal.**
7. 🔴 **The whole historical collection state still runs through
   [OI-212](../items/OI-212%20A%20Ri.Ba.%20rate%20reads%20as%20paid%20before%20its%20due%20date.md),
   unchanged a twelfth night** — and this call is the first time **the client
   himself** reconstructed that chain aloud and agreed it: scadenzario → invoice
   → order line.
8. ⚠ **[OI-274](../items/OI-274%20The%20historical%20ticket%20balance%20has%20no%20migration%20path.md)
   was not mentioned once**, the day after the client's project lead escalated it
   to ROMI and asked for a solution.
9. 🟢 **`DTT_SHR_Mappatura_form_handler_campi_v3.xlsx` is another client's**
   (Pardot form handlers; brands `EL`/`SHR`/`WL`/`LBT`/`DTT`; _Laborability_).
   Three nights unclassified, now closed by one metadata call.
10. ⚠ **Zoho was not named**, a sixth consecutive run — against a plan that
    invoices on Zoho to 12 November and tickets Pienissimo Live from it three
    weeks past the 31 October expiry
    ([the risk](../risks/Risk%20-%20go-live%20now%20falls%20after%20the%20Zoho%20contract%20expires.md)).

## The register

⚠ **Nothing found tonight calls for a register change, and nothing was changed.**
OI-283 and OI-284 are a defect and an unmapped integration, not amendments. No
requirement's text, priority or status changed; the version stays **1.6**;
`go_live: 2026-11-16` and `zoho_expiry: 2026-10-31` are as the 21/10 run left
them.

🔴 **`SAL-12` was not amended and is now uncited for a fifth session.** It reads
_"Tutors on fixed price list, no discretionary discounts"_, `status: agreed`,
while tonight adds **two** rows built on the contrary assumption — OI-283, which
asks for the discount to be *editable*, and OI-284, a client-led call booked to
define how discounts travel to the ERP. **Recording either as settled would write
one side of a contract conflict into the register**; reported for a human
instead, as on 19/10, 20/10 and 21/10.

⚠ **`DM-07`'s competitor-list conflict is unchanged.**

🔑 **Two absences remain findings in themselves**: no register row covers the
**order-to-Mexal price breakdown** (OI-284), and none covers **ticket migration**
(OI-274).

## Corrections to the record

- 🔑 **OI-275's 21/10 closure was premature, and is corrected rather than
  reversed.** The key design is right; what was missing is that `sigla + serie +
  numero + data` is only unique over rows that *have* those values. The note now
  records that the guarantee is an extract-side filter. **Status left
  `resolved`**, because the build it describes shipped and works — the new
  condition is recorded in the body, not by reopening the row.
- 🟢 **The 21/10 report that Fabrizio Paganelli's 17:01 mail was unanswered is
  superseded.** Elena Spini answered at 08:42:29Z the next morning and the call
  took place at 15:00.
- 🟢 **The three-sweep "unclassified" status of `OLD_DTT SHR Mappatura form
  handler campi.xlsx` is resolved against its v3**: another client. Earlier
  traces' caution is left as written.
- ⚠ **Dictation repairs are flagged, not silently applied.** Gemini renders Mexal
  as _"Maxal"_/_"Max[i]le"_, Salesforce as _"Sales Force"_/_"Salesfall"_/_"SESF"_,
  WooCommerce as _"Wcommerce"_/_"WCommerce"_, `tranche` as _"trunch"_/_"trance"_,
  `SW` once as _"SV"_, Rexhina as _"Regina"_, and emits stray tokens
  (_"Ра"_, _"Да"_, _"Ja"_, _"อ"_). Repairs inside quotations are bracketed.
- ⚠ **Names appearing again without resolution**: **Giuliano** (greeted
  mid-call, _"Ciao, ciao Giuliano"_), **Mirko Merendi** (Kreosoft, has a person
  note), **Luca** and **Gianpaolo** (other projects). **No person note was
  created**; recorded as spoken, with no role asserted beyond what the source
  states.
- ⚠ **A large block of the Elena Spini DM is another project and was not
  ingested.** It opens _"ciao . Life"_ and runs through LIFE365, Luca's
  integration review and a lead-lifecycle redraw. 🔑 **One line in it would be
  material if it were Pienissimo** — _"la si parla di opp ma abbiamo deciso che
  noon servono le opp"_, answered _"poi le hanno boicottate del tutto"_ — but
  **OI-265, raised the same morning, is about Opportunity picklist values on this
  project**, so Pienissimo plainly still uses Opportunity and the exchange is
  read as belonging to the other project. **Recorded as an explicit uncertainty,
  not resolved, and no note was changed on the strength of it.**
- 🔴 **The pre-existing tracker defect is unchanged.** Rows **163–174 remain
  duplicated** in `meetings/open-items.md` **and** `.it.md`, both copies inside
  the same `## Open` section, and the two copies still differ. **None of
  tonight's rows falls in that range.** A human still has to say which copy is
  current.
- ⚠ **Row `| 83  |` is still padded to three characters** in both trackers.
- ⚠ **`MAP.md` still carries two `## Where the project stands` headings.**
  Tonight's entry went into the **first**, which is the live block. Not repaired.
- ⚠ **`MAP.md` is ~305 KB against a header that still promises "under 5 KB".**
  Unchanged, twenty runs on.
- 🆕 ⚠ **Both `DEVELOPMENT-RECAP` files carry a stale precedence line.** The
  header still reads _"Precedence, newest first: §45 → §44 → …"_ while the file
  now ends at **§68**. It has been stale since §46 and **was not repaired here**:
  which sections supersede which is an editorial ruling, not a mechanical one.

## Not done in this run

- The org was **not** opened. `STATUS.md` was not regenerated and the Notion
  mirror stays stale. Every build claim is repository arithmetic against
  `origin/DevMain` `653f8e2`.
- **No Apex test was written, proposed or scaffolded**, per the standing
  instruction. [OI-64](../items/OI-64%20The%20bundle%20Apex%20test%20suite%20is%20broken.md),
  [OI-66](../items/OI-66%20No%20test%20classes%20for%20the%20Biglietto%20stack.md) and
  [the deploy risk](../risks/Risk%20-%20production%20deploy%20is%20blocked%20by%20Apex%20coverage.md)
  were not touched; nothing tonight changed their state. ⚠ Today's commits add
  Apex (`MexalInvoiceLineImportBatch`, `MexalArticleSyncService`,
  `MexalOrderSendService`, `MexalOrderMappingService`) **and no Apex test**, so
  the untested-Apex surface grew again. Recorded as an absence, not acted on.
- **OI-212 was not fixed**, a twelfth night. The correction is a code change and
  belongs to Aurel Mrruku.
- **The picklist workbook was not opened** — no tool here fetches a Gmail
  attachment. Its filename, sender, recipients and timestamp are recorded; its
  values are not.
- **`Referenti Salesforce.xlsx` was not opened** — 10 MB of real customer contact
  records, recorded by id, size and modified time only.
- **The eight inline images and `~WRD0003.jpg`** on the `Opportunity` thread, and
  the older Mexal screenshots, are all still unopened.
- **The `DEVELOPMENT-RECAP` precedence headers were not repaired** — see above.
- **`prettier:verify` was not run** (no `node_modules`); `vault:check` is
  dependency-free and was.

## Still unreachable

🆕 what Mirko Merendi actually told Fabrizio Paganelli about the listino/sconto/
netto fields (the mail reports the conversation, not its content) · 🆕 the hour of
the 26 October call · 🆕 what the right edit behaviour for an order discount is
(the client declined to say) · 🆕 whether the dummy editions or the `old` flag is
the mechanism · 🆕 who reverses the product activation, and when · 🆕 how many
credit notes leave the 2024 history and whether anyone reading it will know ·
🆕 the contents of the picklist workbook, and what the client actually wants
changed · whether the ~80 live Performance Plus contracts are migrated,
hand-entered or abandoned · whether the client's lawyer permits the
legal-representative fields · who removes the other migration-only code
conditions · what `Pienissimo 360` is · the client's ticket field/value
structure · ROMI's own written reply to the go-live mail (sent from Elena
Spini's mailbox, not swept) · whether the Pienissimo Live tickets have been sent
(answered both ways in one call) · whether Pienissimo hold a Zoho contract past
31 October (**sixth run**) · which four `Dettaglio Motivazione Uscita` values
OI-259 means · what `differenziare le comunicazioni` contains (OI-269) ·
whether a contract-expiry alert rule exists in the org (OI-272) · the Fase 2
draft by `Claudio` · whether the 23/10 marketing support was confirmed · which
production user is to be copied for the marketing tests · what _"utente metà
bloccato"_ means for WhatsApp · whether a test order created in production
reaches live Mexal · whether Sabatino Rinaldi's user exists · whether Elisa
Migliano can log in on her own account · what Fabrizio Mastracci's _"nuova change
request"_ referred to · the 30/07 marketing notes
`1uJCE4NW9nbdI38ADmt66svUT1MRmkyYd24uI0hegAD0` · Zoom tier · training hours ·
who owns tutor training now · the Woo instance · DocuSign prod config ·
`Get Campaign` and the campaign-ID gap · Jira `PIEN` · `Flows & Objects.drawio` ·
the _diretta_ form · who `Andrea` is.
