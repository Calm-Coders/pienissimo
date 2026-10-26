---
id: trace-2026-10-21-nightly
type: reference
status: active
updated: 2026-10-21
watermark_used: 2026-10-20T22:00Z
external_watermark: 2026-10-21T22:00Z
account: a.mrruku@romicompany.com
---

# Source trace 2026-10-21 nightly

**Watermark for the next `requirements-check` run: 2026-10-21T22:00Z, single
value.**

**Watermark used: 2026-10-20T22:00Z**, the `external_watermark` stated by
[the 20/10 nightly trace](Source%20trace%202026-10-20%20nightly.md), selected by
`updated:` frontmatter. Scheduled nightly run, executed 2026-10-21 ~21:50Z. One
day.

🟢🔑 **The go-live was agreed at 16 November in a recorded client call, the whole
migration was designed end to end, and the blocker nobody had raised surfaced in
the same room.**

🟢 **Environment note.** The clone opened on `main` (two commits, config only)
with none of the knowledge layer in the working tree; `DevMain` did not exist
locally and was created with `git checkout DevMain` against the fetched remote
branch. **Nineteen runs, same opening pattern.**

🔑 **The biggest day of client contact in the project record: 4 hours 43 minutes
across two sessions, both captured with full raw transcripts.** Both were drilled
in one pass each, per `drill-meeting` step 2.

## Sources searched

| Source | Query / scope | Result |
| ------ | ------------- | ------ |
| **Gmail** | `pienissimo after:2026/10/20 -in:draft`, 50 requested, 13 estimated | 🔑 **Seven new items.** Two **Gemini meeting-notes mails** (10:56:28Z and 14:38:56Z) announcing the day's two sessions · the **14:30 calendar invitation** (10:48:02Z) · the **`Mandato RID`** thread with Kreosoft (7 messages) · **Marco Montesi's reply** on the `Opportunity` thread (15:39:56Z) · **Fabrizio Paganelli's first migration draft** (17:01:16Z) · **two more sandbox Anticipay 404 mails** (09:43:16Z and 09:43:38Z) |
| **Gmail** | `get_thread 1a15de7ff92cb0d2` (PLAIN_TEXT, all 7 messages) | 🔑 **An API contract, in two halves.** Fabrizio Paganelli → Mirko Merendi 10:00:45Z asking for the RID mandate field name; answer **12:41:57Z** naming the SEPA block (`nr_mandato_sepa`, `dt_mandato_sepa`, `dt_mandato_cli`, `stato_sepa_cli`, `stato_seq_sepa`, `tp_incasso_sepa`, `tp_mandato_sepa`) → [OI-277](../items/OI-277%20A%20read-only%20Mandato%20RID%20field%20is%20required%20on%20the%20account.md). Second question 13:05:04Z, answer **13:14:43Z** naming the order fields on the invoice (`sigla_ordine`, `serie_ordine`, `numero_ordine`, `data_ordine`) → [OI-275](../items/OI-275%20The%20Mexal%20order%20key%20is%20not%20unique%20without%20the%20order%20date.md). ⚠ **Field names recorded; the sample values are a real customer's mandate, bank and order data and were deliberately not copied.** Four `image001.png` attachments (the Mexal screens) not opened |
| **Gmail** | `get_thread 1a15f68fbc913929` (PLAIN_TEXT) | 🟢 **The client started filling the migration spec the same evening.** 17:01:16Z, subject _Importazione dati Storici_, to Aurel Mrruku and Elena Spini, cc `amministrazione@`: _"io ho fatto una prima bozza. Avete 15-30 minuti domani? Avrei piacere di capire se siamo sulla strada giusta."_ ⚠ **No attachment** and ⚠ **unanswered** at sweep time |
| **Gmail** | `get_message 1a15f1e833a5d293` (PLAIN_TEXT) | 🟡 **OI-265 moves for the first time in two days.** Marco Montesi, 15:39:56Z: _"chiedo a @Elisa se ti può rimandare il file, qui deve essere saltato qualcosa."_ So the client reads it as a transmission problem, not a value discrepancy. 🔴 **The picklist workbook is unshared a twelfth sweep.** Three inline images still unopened |
| **Gmail** | the two 09:43Z sandbox mails (subjects read; `TEST - Azienda non trovata`, accounts `001MA000013uSdlYAE` and `001MA000013xbcWYAQ`) | 🟢 **Explained by the morning transcript and not a defect.** The UAT Anticipay call is redirected at the client's own database to avoid burning credits, so any VAT number not already held returns 404 — Aurel Mrruku at `01:41:03`. **Four such mails over two days**; bodies not re-read, since the 20/10 pair established the format |
| **Drive** | `modifiedTime > '2026-10-20T22:00:00Z'`, **2 pages, 16 files** | 🔑 **Both of the day's sessions, with Gemini notes and transcripts in one document each.** `[ROMI-PIENISSIMO] - Check Dati Migrazione e OP - 2026/10/21 10:01 CEST - Appunti di Gemini` (Doc `1aC68ss6lrHUXNry470cX72KVDzmQ_bR2Kllr-Eeb0ns`, 87,119 bytes, owner Elena Spini, shared 10:55:28Z) and `[ROMI-PIENISSIMO] - Tema Migrazione - 2026/10/21 14:31 CEST - Appunti di Gemini` (Doc `1si77wuD-1kDzOh0b8cSdcRtN8Og8tkSfAEMtrE4v2Cw`, 65,119 bytes, shared 14:37:55Z), each with its folder and shortcut. ⚠ **No MP4 for either call**, as on 19/10 and 20/10 |
| **Drive** | `read_file_content` ×2, then both split into notes and transcript | 🔑 **Read in full, once each.** 180,455 and 124,481 characters returned; the notes sections (0–32,976 and 0–22,774) read directly, the transcripts (147,479 and 101,707 chars) **preserved verbatim** at `meetings/2026-10-21-check-dati-migrazione-e-op-transcript.it.md` and `meetings/2026-10-21-tema-migrazione-transcript.it.md`. Completeness checked: they end on _"Trascrizione terminata dopo 02:46:16"_ and _"… 01:57:34"_ |
| **Drive** | `Referenti Salesforce.xlsx` (`1TTtHAc0Rmh7NV2b5_K0FIbVQrYoWtsC2`, 10.25 MB, owner `fabrizio.pienissimo@gmail.com`, modified 13:59:19Z) | ⚠ **Deliberately not opened.** This is the contacts workbook Aurel Mrruku and Elena Spini checked on screen during the afternoon call for the `contatto principale` flag; at 10 MB it holds **real customer contact records**. **Recorded as existing, with its id, size and modified time, per the standing constraint.** 🟢 Its substance is already known from the transcript: the flag exists and the data model needs no change |
| **Drive** | `OLD_DTT SHR Mappatura form handler campi.xlsx` (`1gpBvxwmpcbEl2LlD_18tITWuw3UtX8d3`) | **Unchanged since 20/10 16:43:18Z.** Still unclassified rather than ignored: the title does not name this project and no source links it to Pienissimo |
| **Drive** | `Open Point` (`1mz_nxZW9RVI7Tl7kfVpITx38Iteyn5qqL0-8hJOCQT8`, d.losco@, 15:45:36Z) and `Business Blueprint - Vision` Parte 1–4 + appendici | **Another client.** `get_file_metadata` on their shared parent `1Z5J223ol95I5wmBAPcpn77gNgMo34bcY` returns **`[Vision] - Fase Progettuale`**. Ignored, and **not counted as a missing source** — the title `Open Point` is close enough to this project's vocabulary to be worth the one metadata call |
| **Drive** | `[ROMI] Slide Team` (`184axYP-…`, a.pastorelli@, 17:05:19Z) | ROMI-internal, not Pienissimo. Ignored |
| **Slack** | `slack_read_channel C0BQD34LLF4` (dev group), `oldest` 1792533600 = 2026-10-20T22:00Z | 🟡 **4 messages, 3 human.** Aurel Mrruku, 11:09:11–11:11:02 CEST, in Albanian: _"i prodotti BB duhet te jen vetem kur krijohet boundle"_ ✅ · _"dhe NB gjothashtu"_ · _"mnjf po ka boundle true nuk duhet te mund te zgjidhet"_ ✅ — the OI-261 `natura` rule relayed ~2 hours after it was agreed, and **the only internal relay of anything from either call**. The fourth message is this procedure's own 20/10 report. 🔴 **Still no reply to any nightly report — thirty-one nights** |
| **Slack** | `slack_read_channel C0B5T3RB4FM` (`#tproj-pienissimo`), same bound | **0 messages.** Silent |
| **Slack** | `slack_read_channel C0C38JJ9D1T` (marketing group DM), same bound | **0 messages.** Silent — the first silent day there since the go-live mail landed |
| **Slack** | `slack_read_channel D0B5QHS2T7H` (Elena Spini DM), same bound | 🔑 **20 messages, and they carry the morning's temper and the afternoon's list.** 10:28:24 _"questa cosa dei biglietti già fatti è una merda"_ · 10:51:36 _"te ti stai alternando?????"_ · 10:54:31 🔑 _"ma che è sto Pienissimo 360 -.-"_ — **confirming ROMI had never heard of it** · 12:31:10 _"ma che problemi hanno ?"_ / _"avevvano confermato tutto qui"_ · 12:39:22 _"una mattinata persa......"_ · 12:49:05–12:49:54 🔑 **her nine numbered points from Fabrizio Paganelli's requests** → [OI-279](../items/OI-279%20The%20tutor%20account%20creation%20screen%20must%20be%20simplified.md), plus _"per il punto 9 >> serve la risposta di Mirko thread >> Mandato RID"_ · 12:52:11 🔴 _"per il tema migrazione non so Aurel.........di certo non possiamo fare sviluppi ad hoc per gestire cose che loro non si sono ricordati di dirci"_ · 15:27:14–15:33:12 the estimate: _"quanto è difficile la cosa … per gestire gli ordini aperti + Riga ordine + tranche + asset ?"_ → _"2/3 gg di sicuro se tutto va bene"_ → _"ok facciamo 3 e lo aggiungo ai 15 gg che ho detto a Gianpa … ma aspettiamo di finire sto cinema"_ |
| **Slack** | `slack_read_canvas F0BD2H5A9HT` (`Link utili Pienissimo`) | **Unchanged.** Newest entry still 20.08.2026 — static **eleven weeks**. Re-read per the skill; still the only source of the 30/07 marketing notes link |
| **Fathom** | `list_meetings created_after 2026-10-20T22:00Z`, summaries, 3 pages | **1 meeting, and it is another client** — `SALESFORCE check`, 247.it, invitees Tiziana Petruzzi and vittoria.zoli@247.it. 🔴 **Twenty-second consecutive run with no Pienissimo meeting**, on a day with **4h43 of recorded Pienissimo client call**, both captured by Google and neither by Fathom |
| **Git** | `fetch origin`, `log --all --since 2026-10-20T22:00:00Z` | 🟢 **4 commits, 3 PRs merged.** `DevMain` moved `25629af` → **`228be1d`**: `b204661` (Rexhina Hysi, 12:35:07, _"fix bundle"_) · `4a5a4a0` (Anita Aga, 16:26:36, _"Added the sconto on the Gestici Prodotti"_) · merges of **#105** (`DevAnita19`), **#106** (`DevAnita20`) and **#107** (`Devmain_BBAndNbProducts`). 🟢 **Anita Aga's seven unmerged commits from 20/10 are now merged.** No new branches |
| **Repo** | `git show --stat 4a5a4a0 b204661` | 🟢 `4a5a4a0`: the discount on `quoteManageProducts` + `quoteLineItemsWithBundles`, with **370 lines of new LWC jest** across two test files · `b204661`: `BundleProductAssignmentController`, `QuoteManageProductsController`, `Product__c.field-meta.xml` — **and OI-261's own note**, edited by Rexhina Hysi in the same commit |
| **Repo** | `git log -1 origin/DevMain -- MexalScadenzarioSearchService.cls` | 🔴 **OI-212 unchanged an eleventh night** — still `f292b72`, 08/10, in none of today's four commits |
| **Repo** | `OrderMexalIntegrationService.cls` on `228be1d` | 🔴 **OI-267 unbuilt** — `AUTOMATIC_MEXAL_CREATION_ENABLED` still `true`, `Origine__c` still unchecked, file untouched today |
| **Repo** | `ls notes/items` max-id scan; register greps `go_live`, `zoho_expiry`, `CTX-02`, `SAL-12` | Max existing id **273**, so this run allocated from **274**; next free is **283**. `go_live: 2026-10-21` → **moved**; `zoho_expiry: 2026-10-31` unchanged; version stays 1.6 |

## Found

1. 🟢🔑 **[OI-268](../items/OI-268%20The%20client%20proposed%20a%20go-live%20calendar%20of%2016%20November.md)
   is settled: 16 November, agreed by both sides in the room.** And **both** of
   ROMI's internal objections were resolved in ROMI's favour — the weekend
   migration is gone, undefended, and the operational freeze the client had
   refused outright is gone too, replaced by a two-phase import. _"Dividiamo le
   tematiche … e così siamo tranquilli e non ci fermiamo manco un giorno, manco un
   secondo."_ Fabrizio Paganelli: _"Se è così va bene. Per me va bene."_
2. 🔴🔑 **[OI-274](../items/OI-274%20The%20historical%20ticket%20balance%20has%20no%20migration%20path.md)
   — ~1,000 paid, unused tickets have no path into Salesforce**, and the client's
   project lead escalated it to ROMI mid-call. **It was never in scope and both
   sides said so on the record.** ⚠ No ruling on whose omission it was, and
   **nobody called it a change request** — which is notable, because OI-259 was
   called one for far less, four days ago.
3. 🟢🔑 **The afternoon session produced the first end-to-end migration design
   this project has had** — key, bypass, edition matching, dummy editions, field
   list, contract bypass. **None of it is built**, 2–4 days in UAT alone, against
   a first import on ~9 November.
4. 🟢 **[OI-267](../items/OI-267%20Loading%20historical%20orders%20would%20push%20them%20to%20Mexal%20and%20generate%20tickets.md)'s
   bypass was agreed, exactly as the note asked** — suppress Mexal transmission,
   store the Mexal key instead, match later invoices on it. 🔴 Still unbuilt.
   ⚠ **And it, the edizione reversal and the contract bypass are all
   migration-only conditions that have to come back out, with nothing recording
   who removes them or when**, days before a live go-live.
5. 🔴 **The design runs the whole historical collection state through
   [OI-212](../items/OI-212%20A%20Ri.Ba.%20rate%20reads%20as%20paid%20before%20its%20due%20date.md).**
   The payment status was deliberately removed from the client's extract because
   the scadenzario supplies it, so Salesforce will derive the state of
   **~15,000–30,000 historical article lines** through the predicate this record
   calls wrong — ⚠ **and the `P` convention was restated unchanged, to the client,
   uncontradicted.**
6. 🔴 **The Zoho gap is now a joint plan, not a proposal**, and larger in shape:
   invoicing on Zoho to 12 November (12 days past expiry) **plus Pienissimo Live
   ticketed from Zoho three weeks past expiry** plus the migration extract pulled
   from Zoho on 12–13 November. ⚠ **Zoho was not named once in 4h43 of client
   call.** Fifth run the question is unasked.
7. 🟢 **[OI-261](../items/OI-261%20Test%20article%20codes%20pollute%20the%20product%20registry.md)'s
   rule is on the record in the client's own words** and 🔑 **Aurel Mrruku had it
   backwards in the room and was corrected** — which independently confirms the
   already-deployed `Solo_Bundle__c` filter is the right rule. Merged in PR #107.
8. 🟢 **[OI-207](../items/OI-207%20The%20quote%20and%20order%20layouts%20omit%20the%20commercial%20fields%20the%20client%20requires.md)'s
   editability is settled** — nothing editable inside a bundle, **list price
   locked** on a standard sale — and `4a5a4a0` shipped the discount with 370
   lines of jest. ⚠ The other four columns and the PDF are not visibly in it.
9. 🟢 **[OI-260](../items/OI-260%20Generating%20the%20quote%20PDF%20failed%20with%20an%20internal%20server%20error.md)
   is resolved: missing field-level permissions.** 🔑 **Two earlier suspicions
   were both wrong** — not the `QuotePdfController` redeploy (19/10) and not the
   bad products (OI-261). ⚠ Nobody told the client, which is why he re-raised it.
10. 🟢 **The Anticipay 404 mails are expected UAT behaviour, not a defect** — the
    call is redirected at the client's own database to save credits. **Four such
    mails in two days**, and anyone reading only the subject lines would log a
    live integration outage on the eve of a migration.
11. 🔴 **New scope**:
    [OI-277](../items/OI-277%20A%20read-only%20Mandato%20RID%20field%20is%20required%20on%20the%20account.md) ·
    [OI-278](../items/OI-278%20The%20account%20layout%20omits%20the%20legal%20representative%20data.md)
    (fields exist, not on the page, **client suspended it pending their lawyer**) ·
    [OI-279](../items/OI-279%20The%20tutor%20account%20creation%20screen%20must%20be%20simplified.md) ·
    [OI-280](../items/OI-280%20Performance%20Plus%20contract%20generation%20must%20be%20bypassed%20for%20migrated%20orders.md)
    (⚠ **and the ~80 live Performance Plus contracts have no agreed home**) ·
    [OI-281](../items/OI-281%20Tutors%20must%20use%20Aggiorna%20Anticipay%20when%20creating%20an%20account.md)
    (🔴 **three technical controls considered, all three dropped, control delivered
    by training alone**) ·
    [OI-282](../items/OI-282%20The%20client%20is%20owed%20a%20technical%20integration%20document.md).
12. 🟢 **Pienissimo Live 2026 leaves Salesforce entirely** — its edizione will not
    be created and the 23–26 November event runs on Zoho. ⚠ Whether its tickets
    have already been sent was answered **both ways inside one call**, at
    `00:48:15` and `01:15:32`; recorded as contradictory.
13. 🔑 **`Pienissimo 360` exists and ROMI had never heard of it.** Offered by
    Sabatino Rinaldi as an API route into Salesforce; Elena Spini in DM the same
    morning: _"ma che è sto Pienissimo 360 -.-"_ **It appears in no project
    record** and nobody has evaluated it.
14. 🔑 **A load-bearing premise was wrong and got corrected on screen**: Mexal
    *does* keep the order after invoicing, against what Mirko Merendi had told
    Aurel Mrruku. The whole key design depends on the correction.

## The register

🟢 **Amended in substance for the first time since v1.6.**
**`go_live` moved from `2026-10-21` to `2026-11-16`**, in
`requirements/pienissimo-requirements.yaml` (the header date and comment, and
`CTX-02`'s text) and in **both** prose documents — the `M` priority definition,
the `CTX-02` row, the milestone table and the change-control rule. The milestone
table now carries the full agreed calendar, with the superseded 21 October line
kept visible rather than deleted.
**Version stays 1.6; `zoho_expiry` stays `2026-10-31`; no other requirement's
text, priority or status changed, and no `tracked_by` pointer was added** —
`OI-274` was tried on `CTX-02` and reverted, because the note is about ticket
migration, not the go-live date, and `vault:check` correctly refused the
one-sided pair.

🔑 **Why this run moved it when eight previous runs held it.** The OI-124 rule is
that signable text does not follow **a proposal awaiting a reply**. That
condition is now met, from both directions: the client proposed 16 November in
writing on 20 October, and ROMI accepted it in a recorded client session on
21 October, with the delivery plan designed around it in the same call and the
following one. The register's own value, 21 October, is **today** and from
tomorrow states a go-live that demonstrably did not happen.

⚠ **What a human should check.** `REQUISITI.it.md` is the text presented for
signature, so the Italian wording is a human's call, not this procedure's. And
**ROMI's written reply to the client's calendar is not in evidence in this
mailbox** — Elena Spini refers to it repeatedly in the call but sent it from
`e.spini@romicompany.com`, which this sweep does not read. So the acceptance
recorded here is **verbal, from a recorded call**, not a quoted written
acceptance.

🔴 **`SAL-12` was not amended and is uncited for a fourth session.** It reads
_"Tutors on fixed price list, no discretionary discounts"_, `status: agreed`,
while `4a5a4a0` shipped a tutor-editable line discount today. **Neither party
mentioned it in either of the two client calls.** Recording the discount as
settled would write one side of a contract conflict into the register; reported
for a human instead, as on 19/10 and 20/10.

⚠ **`DM-07`'s competitor-list conflict is unchanged.**

⚠ **Nothing else found tonight calls for a register change.** OI-274 through
OI-282 are new asks, defects and open questions, not amendments. 🔑 **Two
absences are findings in themselves**: no register row covers the **RID mandate
precondition** (OI-277), and none covers **ticket migration** at all — which is
the whole of OI-274 and is why neither party could point at scope.

## Corrections to the record

- 🟢 **The OI-260 diagnosis is settled and two earlier readings were wrong.** The
  19/10 record suspected `#102`'s redeploy of `QuotePdfController`; OI-261
  suspected the polluted products. **It was neither** — missing field-level
  permissions on the client users. Both speculations are marked superseded in
  place rather than deleted.
- 🟢 **The 20/10 report that ROMI had not replied to the go-live mail is
  superseded.** Elena Spini had replied, in writing, before the 21/10 call — it
  is simply not in this mailbox. The 20/10 text stands as written and is
  corrected in OI-268's new section.
- ⚠ **Row #267 was missing from both trackers entirely.** OI-267 was written by
  Aurel Mrruku's own commit `25629af` on 20/10, outside this procedure, and **no
  tracker row was ever created for it** — while rows #268–#273 cite it.
  **Backfilled this run** in both languages. 🔑 **This is the second consequence
  of the same cause**: a human writing to the knowledge layer does not run the
  rendered-view regeneration, so notes and trackers drift. The 20/10 trace caught
  the id-sequence half; this is the tracker half.
- ⚠ **Dictation repairs are flagged, not silently applied.** Gemini renders Zoho
  as _"Zoo"_/_"Zo"_/_"Zoho"_ and once _"Zost"_; Mexal as _"Maxal"_/_"Maxile"_/
  _"Max"_; Anticipay as _"Antipay"_/_"Anticip"_/_"Antispay"_/_"ATC pay"_;
  Salesforce as _"Sales Force"_/_"Ses Force"_/_"S[ale]sF[orce]"_/_"salesource"_;
  WooCommerce as _"Wcommerce"_/_"VCmerce"_; Pienissimo as _"pianissimo"_;
  `RID` as _"read"_/_"r[i]d"_/_"readid"_; `tranche` as _"trunch"_/_"trans"_.
  Repairs inside quotations are bracketed.
- ⚠ **Names appearing again without resolution**: **Andrea** (holds the Anticipay
  credentials and must open the production call — _"basta che Andrea mi abilita"_),
  **Giuliano** (runs stage-sale recalls), **Carmen Traiano** (the agent user the
  commission autofill reads from), **Gianpa**/**Gianpaolo** (Elena Spini's
  _"15 gg che ho detto a Gianpa"_), **Claudio**. No person note was created for
  any of them; recorded as spoken, with no role or organisation asserted beyond
  what the transcript states.
- 🔴 **The pre-existing tracker defect is unchanged.** Rows **163–174 remain
  duplicated** in `meetings/open-items.md` **and** `.it.md`, both copies inside
  the same `## Open` section, and the two copies still differ. **None of
  tonight's rows falls in that range.** A human still has to say which copy is
  current.
- ⚠ **Row `| 83  |` is still padded to three characters** in both trackers.
  🔑 **And it cost something tonight**: the row-refresh pass keys on `| NNN |`,
  which is exactly why row 267's absence was detected rather than silently
  skipped. Noted so a naive row-matching script is not trusted.
- ⚠ **`MAP.md` still carries two `## Where the project stands` headings.**
  Tonight's entry went into the **first**, which is the live block. Not repaired
  — which of the two is intended is a human's call.
- ⚠ **`MAP.md` is ~300 KB against a header that still promises "under 5 KB".**
  Unchanged and unrepaired, nineteen runs on.

## Not done in this run

- The org was **not** opened. `STATUS.md` was not regenerated and the Notion
  mirror stays stale. Every build claim is repository arithmetic against
  `origin/DevMain` `228be1d`.
- **No Apex test was written, proposed or scaffolded**, per the standing
  instruction. [OI-64](../items/OI-64%20The%20bundle%20Apex%20test%20suite%20is%20broken.md),
  [OI-66](../items/OI-66%20No%20test%20classes%20for%20the%20Biglietto%20stack.md) and
  [the deploy risk](../risks/Risk%20-%20production%20deploy%20is%20blocked%20by%20Apex%20coverage.md)
  were not touched; nothing tonight changed their state. ⚠ Today's commits add
  **Apex** (`QuoteLineItemsController`, `QuoteManageProductsController`,
  `BundleProductAssignmentController`) **and 370 lines of LWC jest, but no Apex
  test** — so the untested-Apex surface grew. Recorded as an absence, not acted
  on. 🔑 **And the migration design adds a large amount of new, unbuilt,
  migration-only integration code to that surface.**
- **OI-212 was not fixed**, an eleventh night. The correction is a code change
  and belongs to Aurel Mrruku.
- **`Referenti Salesforce.xlsx` was not opened** — a 10 MB contacts workbook
  holding real customer records. Its id, size and modified time are recorded; its
  contents are not. Its substance was obtainable from the transcript instead.
- **The four `image001.png` Mexal screenshots** in the Kreosoft thread, **the
  three inline images** on the 19/10 `Opportunity` thread and **Elena Spini's
  19:33:53 `@channel` image** (`F0CAT349FCH`) are all still unopened.
- **No person note was created** for Andrea, Giuliano, Carmen Traiano, Gianpaolo
  or Claudio.
- **`prettier:verify` was not run** (no `node_modules`); `vault:check` is
  dependency-free and was.
- **`Opportunità_Zoho_CRM_`** was not re-checked; unchanged since 20/10.

## Still unreachable

🆕 what `Pienissimo 360` is and whether it is in scope for anything · 🆕 the
client's ticket field/value structure, requested in the morning call and not sent
· 🆕 ROMI's own written reply to the go-live mail (sent from Elena Spini's
mailbox, not swept) · 🆕 whether the ~80 live Performance Plus contracts are
migrated, hand-entered or abandoned · 🆕 the naming convention for the dummy
import editions · 🆕 whether the client's lawyer permits the legal-representative
fields · 🆕 whether 2024 is included in the historical load · 🆕 who removes the
migration-only code conditions, and when · 🆕 whether the Pienissimo Live tickets
have been sent (answered both ways in one call) · whether Pienissimo hold a Zoho
contract past 31 October (**fifth run**) · which four `Dettaglio Motivazione
Uscita` values OI-259 means · what `differenziare le comunicazioni` contains
(OI-269) · whether a contract-expiry alert rule exists in the org (OI-272) · the
Fase 2 draft by `Claudio` · whether the 23/10 marketing support was confirmed ·
which production user is to be copied for the marketing tests · what
_"utente metà bloccato"_ means for WhatsApp · whether a test order created in
production reaches live Mexal · which picklist values are current for
Categoria/Sottocategoria · whether Sabatino Rinaldi's user exists · whether
Elisa Migliano can log in on her own account · what Fabrizio Mastracci's
_"nuova change request"_ referred to · the picklist workbook (**12th run**) · the
30/07 marketing notes `1uJCE4NW9nbdI38ADmt66svUT1MRmkyYd24uI0hegAD0` · Zoom tier
· training hours · who owns tutor training now · the Woo instance · DocuSign prod
config · `Get Campaign` and the campaign-ID gap · Jira `PIEN` ·
`Flows & Objects.drawio` · the _diretta_ form · who `Andrea` is.
