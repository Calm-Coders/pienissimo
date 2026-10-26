---
id: trace-2026-10-26-nightly
type: reference
status: active
updated: 2026-10-26
watermark_used: 2026-10-23T22:00Z
external_watermark: 2026-10-26T22:00Z
account: a.mrruku@romicompany.com
---

# Source trace 2026-10-26 nightly

**Watermark for the next `requirements-check` run: 2026-10-26T22:00Z, single
value.**

**Watermark used: 2026-10-23T22:00Z**, the `external_watermark` stated by
[the 23/10 nightly trace](Source%20trace%202026-10-23%20nightly.md), selected by
`updated:` frontmatter. Scheduled nightly run, executed 2026-10-26 ~21:50Z.
**Three days** — 24 and 25 October were the weekend and **no sweep ran on
either**, so this window is wider than usual.

🔴🔑 **All of DevMain went to production, and the release left three live faults
behind it — one of which mis-invoices in silence.**

🟢 **Environment note.** The clone opened on `main` (two commits, config only)
with none of the knowledge layer in the working tree; `DevMain` did not exist
locally and was created with `git checkout DevMain` against the fetched remote
branch. **Twenty-two runs, same opening pattern.**

## Sources searched

| Source | Query / scope | Result |
| ------ | ------------- | ------ |
| **Gmail** | `pienissimo after:2026/10/23 -in:draft`, 50 requested, 14 estimated | 🔑 **Seven new items.** The **`Richiesta Call`** thread (4 new messages — 🟢 **Kreosoft answered OI-284 in writing**) · the new **`Aggiornamento Anagrafica Articoli`** thread (2) · the new **`Tracciato dati Lead/Referenti`** mail · the **`Test UAT Commerciali`** recording thread (2) · 🔴 **one production `ContactTrigger` exception** 16:28:17Z · 🔴 **two production flow errors** 17:01:19Z and 17:25:19Z · two Google meeting-record notifications |
| **Gmail** | `get_thread 1a16424bb89d3e8a` (PLAIN_TEXT, 9 messages, read in full) | 🟢🔑 **OI-284 is answered in writing, twice.** 11:56:24Z Mirko Merendi: _"Nel prezzo unitario su Mexal devi inserire il prezzo di listino e poi applicare lo sconto. In questo modo, Mexal calcolerà automaticamente il prezzo totale della riga del prodotto."_ → 🔑 the unit-price field now carries **listino** where it carried netto · 14:27:33Z, answering Aurel Mrruku's 13:39:55Z question: **_"Formato decimale per gli sconti: virgola · Numero massimo di cifre decimali gestite: 2"_** → [OI-284](../items/OI-284%20The%20listino%20sconto%20and%20netto%20mapping%20for%20Mexal%20orders%20is%20undefined.md), [OI-287](../items/OI-287%20The%20Mexal%20line%20discount%20is%20sent%20as%20a%20line%20total%20instead%20of%20per%20unit.md) |
| **Gmail** | `get_message 1a1790a907c70ed4` (PLAIN_TEXT) | 🔴🔑 **Production defect.** 16:28:17Z, org `00Dbl000005BSMH`, host `ability-customization-52152.my.salesforce.com` — ⚠ **no `--partial.sandbox` suffix, so this is Prod** — user `005SW00000PV5Ja`: _"ContactTrigger: execution of AfterUpdate caused by: System.DmlException: Update failed … FIELD_CUSTOM_VALIDATION_EXCEPTION, Agente è obbligatorio.: [Agente__c]"_, `ContactTriggerHandler.syncAccountPrincipalEmails: line 203`. 🟢 Forwarded by Aurel Mrruku to Rexhina Hysi and Anita Aga 16:40:42Z → new [OI-288](../items/OI-288%20Editing%20a%20Contact%20fails%20in%20production%20when%20the%20Account%20has%20no%20Agente.md) |
| **Gmail** | `get_message 1a17928d0e292e07` (PLAIN_TEXT) + the thread's second message | 🔴🔑 **Second production defect, twice.** 17:01:19Z and 17:25:19Z: flow _"Automazione: Invio Biglietto assegnato Flow"_, API name `flow_701SW00000fsgPXYAY_1791487932100`, id `301SW00000gDd57`, **AutoLaunched, Version 5, Attivo**, org `00Dbl000005BSMH`, running as **Tech Romi**: element `Get_Ticket_PDF` → _"**Schema field not found. Entity: Asset, Field: QR_Id__c**"_. The `ContentVersion` lookup returned _"Impossibile trovare i record"_ first → new [OI-289](../items/OI-289%20The%20production%20ticket%20dispatch%20flow%20references%20a%20field%20that%20does%20not%20exist.md) |
| **Gmail** | `get_message 1a1786a9c1a23757` (PLAIN_TEXT) | 🔴🔑 **New migration scope.** 13:33:24Z Elena Spini → Sabatino Rinaldi, cc Fabrizio Paganelli, `amministrazione@`, Aurel Mrruku: _"avremmo bisogno dei dati da importare per: Lead; Referenti (ti ricordo … l'importanza di verificare la corretta associazione tra l'Azienda/Account e il rispettivo Referente)"_, citing the data-model workbook → new [OI-290](../items/OI-290%20Lead%20and%20Referenti%20migration%20data%20is%20owed%20by%20the%20client.md) |
| **Gmail** | thread `1a178cf11b90a413` (subjects, senders, snippets) | 🟢 **The product round trip closed.** 15:23:18Z Fabrizio Paganelli: _"l'aggiornamento prodotti è stato fatto su Mexal, quando vuoi si può procedere con l'importazione in Salesforce"_; 15:54:22Z Aurel Mrruku: _"Ho riportato in UAT tutti gli articoli aggiornati e li ho messi attivi"_ → [OI-276](../items/OI-276%20Dummy%20import%20editions%20are%20needed%20to%20load%20historical%20orders.md). ⚠ **Nothing says the sync flows are back on** |
| **Gmail** | thread `1a17771416219801` (2 messages) | ⚠ **Not new scope.** Marco Montesi 09:01:12Z asked for the recording of the 19/10 UAT session; Elena Spini 09:10:31Z: _"ti ho condiviso il transcript, **non abbiamo registrato il video**"_ and pointed him at an older UAT video. Explains the 19/10 notes doc being touched at 09:05:54Z |
| **Gmail** | messages `1a177c9b6f4bba4d`, `1a177ac74fdfdb3c` | Google meeting-record notifications for the two 26/10 meetings — used only to locate the Drive artifacts |
| **Drive** | `modifiedTime > '2026-10-23T22:00:00Z'`, **2 pages, 28 files** | 🔑 **Four Pienissimo items.** The **Tema Ordini Mexal transcript** (`1Z-LX9HID2bDmjZvad-FmS0bZByuaB1ZTx_yA-cZzB98`, 28,048 bytes, owner Elena Spini, shared 10:36:50Z) · the **Test UAT Commerciali Gemini notes** (`1oEdJeHF8E669yA3_-Y97TrfJhvptVd9tNUV5DqGOCyk`, 4,635 bytes) · 🔑 **`Campi Oggetti, Flussi e Utenti Salesforce - Pienissimo.xlsx` modified 13:27:45Z** — one of the skill's named documents, and the tracciato OI-290 now hangs on · **`Manual Steps Pienissimo`** modified 16:20:26Z (matches Rexhina Hysi's `ed1e1e6` _"update file manual steps"_). ⚠ **No MP4**, as on 19–23/10 |
| **Drive** | `title contains 'Tema Ordini Mexal' or title contains 'Test UAT Commerciali'` | Resolved both meetings' folders, shortcuts and documents. 🔑 Note the Mexal call got a **`- Transcript`** doc and the UAT session **`- Appunti di Gemini`**; as on 23/10 the naming is cosmetic |
| **Drive** | `read_file_content` on the Tema Ordini Mexal transcript | 🔑 **Read in full, once, ~28 KB — the day's single most valuable source.** Preserved verbatim at `meetings/2026-10-26-tema-ordini-mexal-transcript.it.md` (35 KB with the header). Completeness checked: it ends on _"La riunione è terminata dopo 00:32:14"_. Drilled into [the meeting note](../meetings/2026-10-26%20Tema%20Ordini%20Mexal.md) |
| **Drive** | `read_file_content` on the Test UAT Commerciali notes | ⚠ **Empty artifact, not a finding.** _"Non è stato prodotto un riepilogo per questa riunione perché non c'era abbastanza conversazione in una lingua supportata"_ and _"Trascrizione terminata dopo 00:00:20"_. The meeting produced nothing; **no note was created for it** |
| **Drive** | the rest of both pages — `Business Blueprint - Vision` 1–4, `Accessibilità_ Checklist_accessibilita_wcag22.xlsx`, `LISTINI.xlsx`, `Open Point`, `esempio buyergroup / listini` (all `d.losco@`), `SALESFORCE recap points to fix`, `SALESFORCE GUIDES`, `Reception_Portal_Guide`, `Salesforce_List_View_Guide` (247.it), `QSAL UnitàServiziManutenzione`, `anagrafica cliente.jpg`, `anagrafica appalto.jpg`, `FDL COMMESSA.jpg` (`r.singh@`), `[ROMI] Slide Team`, `Piano ferie/assenze Natale 2026`, `DTT_SHR_…_v3.xlsx` | **Other clients or ROMI-internal.** Ignored, and **not counted as missing sources.** ⚠ **`LISTINI.xlsx` and `esempio buyergroup / listini` were checked deliberately** because catalogue prices are an open item here (OI-87): both are owned by `d.losco@romicompany.com` and sit in the same folders as the `Business Blueprint - Vision` documents, so they are **read as the Vision engagement**, not Pienissimo. Recorded as a classification with residual uncertainty; **neither was opened** |
| **Slack** | `slack_read_channel C0BQD34LLF4` (dev group), `oldest` 1792792800 = 2026-10-23T22:00Z | **1 message — this procedure's own 23/10 report**, posted 00:08:42 CEST. 🔴 **No human message, and still no reply to any nightly report — thirty-six nights** |
| **Slack** | `slack_read_channel C0B5T3RB4FM` (`#tproj-pienissimo`), same bound | 🟢🔑 **2 messages — the channel spoke for the first time in weeks.** 24/10 11:00:01 CEST **Elena Spini's weekly status** (go-live confirmed 23/10 · migration solution · UAT requests _"sconti modificabili a riga … Aurel ci sta lavorando"_ · 🔑 **Gold/Executive communications restated with _"abbiamo chiesto ulteriori dettagli"_** → OI-269 · red flag _"ogni settimana cambia qualcosa che era già deciso"_, +3 gg absorbed · **26 gg to finish**) · 🔑 26/10 13:13:44 CET **Gianpaolo Motta**: _"su questo progetto non abbiamo più margine per assorbire cose in più, spostagliele alla fase 2"_ (one 👍, no reply) → new [decision note](../decisions/ROMI%20will%20absorb%20no%20further%20scope%20in%20Fase%201.md), [OI-285](../items/OI-285%20ROMI%20asked%20the%20client%20to%20route%20future%20out%20of%20scope%20requirements%20through%20change%20requests.md) |
| **Slack** | `slack_read_channel C0C38JJ9D1T` (marketing group DM), same bound | **0 messages.** Silent — third day |
| **Slack** | `slack_read_channel D0B5QHS2T7H` (Elena Spini DM), same bound | **0 messages.** Silent — ⚠ a change from 23/10, when it carried the day's whole explanation |
| **Slack** | `slack_read_canvas F0BD2H5A9HT` (`Link utili Pienissimo`) | **Unchanged.** Newest entry still 20.08.2026 — **67 days**. Re-read per the skill; still the only source of the 30/07 marketing notes link |
| **Fathom** | `list_meetings created_after 2026-10-23T22:00Z`, summaries, 3 pages | **0 meetings.** 🔴 **Twenty-fifth consecutive run with no Pienissimo meeting** — on a window in which Google captured a client call with the ERP vendor in it |
| **Git** | `fetch origin`, `log --all --since 2026-10-23T22:00:00Z`, `for-each-ref` | 🟢🔑 **`DevMain` moved `ebc2c5b` → `428f42b`: 14 commits, 4 PRs merged** (#108 `DevAnita22`, #109 `Devmain_LeadChecks`, #111 `Devmain_QuoteTriggerChanges`, #112 → `DevMain`), then **#113 `DevMain` → `UAT`** (`dac0dc6`) and **#114 `UAT` → `Prod`** (`f5322dc`, 17:04 CET). All 26/10; 24–25/10 silent |
| **Repo** | `git show --stat` on `e9919fb`, `428f42b` | `e9919fb` _"added sconto"_ 14:30 CET — `MexalOrderSendService` +35, `QuoteTriggerHandler` +46, new `OrderItem.Prezzo_Listino__c`, `Full_Permission` · `428f42b` _"Aurel deploy in prod"_ 16:55 — 9 test classes, `TestDataFactory`, `orderMexalErrorBanner` LWC, `MexalOrderSendService` ±12, AGENTS.md +25, the coverage risk note +83 |
| **Repo** | `grep -n -B4 -A12 sconto MexalOrderSendService.cls` | 🔴🔑 **The headline.** `resolveLineDiscount` returns `((Prezzo_Listino__c - UnitPrice) * Quantity)` and its comment claims _"Mexal … **divides it by the line quantity** (format given by Mexal, 26/10)"_ — **the opposite of what the call it cites established** → new [OI-287](../items/OI-287%20The%20Mexal%20line%20discount%20is%20sent%20as%20a%20line%20total%20instead%20of%20per%20unit.md) |
| **Repo** | `cat OrderItem/fields/Prezzo_Listino__c.field-meta.xml`, `grep Prezzo_Listino__c QuoteTriggerHandler.cls` | 🔴 **Both operands are per-unit**, which is what makes the multiplication wrong: the field's own description is _"Prezzo **unitario** prima dello sconto"_, and `netUnitPrice` computes `UnitPrice` as `TotalPrice / Quantity` |
| **Repo** | `grep -n 'update accountsToUpdate' ContactTriggerHandler.cls`; `cat Account/validationRules/Agente_required_for_Azienda_and_Locale...xml` | 🔴 **OI-288 root-caused in source.** Line **203** is exactly `update accountsToUpdate;`, unguarded; the rule is `active`, fires on `AND($RecordType.DeveloperName = "Azienda", ISBLANK(Agente__c))`, and its `errorMessage` is **`Agente è obbligatorio.`** — the exact string in the mail. ⚠ Its `description` says _"both Azienda and Locale"_ while the formula tests Azienda only |
| **Repo** | `grep -rl QR_Id` (excl. `node_modules`, `.git`); `ls Asset/fields/`; `ls flows/` | 🔴 **OI-289 confirmed as a gap.** `QR_Id__c` appears **only in prose** (register, 4 notes, 3 items, both trackers, one proposal) and in **no** metadata file; the twelve Asset fields in source do not include it; **there is no `flows/` content for the failing flow** — it is org-only |
| **Repo** | `grep -c Task Agente.permissionset-meta.xml`, `grep CreateTask` | 🟢 **OI-286's fix is on `DevMain`** via PR #109 — and 🔑 it is in the **permission set**, not the `Agente` profile the Prod deploy excluded |
| **Repo** | `git log -1 origin/DevMain -- MexalScadenzarioSearchService.cls` (via the 23/10 baseline) | 🔴 **OI-212 unchanged a fourteenth night — and now in production** inside the 751-component release |
| **Repo** | `ls notes/items` max-id scan | Max existing id **286**, so this run allocated **287**, **288**, **289** and **290**; next free is **291** |
| **Repo** | `sed -n '86,130p' JOURNAL.md` | Read the five 26/10 entries written before this run, to avoid re-ingesting: the test-suite repair and Prod deploy, the UAT article re-sync, the Prod deploy attempt, the OI-284 line discount, the OI-250 Wait Interval fields |
| **Repo** | register greps (`go_live`, `zoho_expiry`, `version`, `SAL-12`) | **None changed.** No requirement's text, priority or status changed; version stays **1.6**; `go_live: 2026-11-16` and `zoho_expiry: 2026-10-31` as earlier runs left them |

## Found

1. 🟢🔑 **`DevMain` is in production** — 751 components, 168/168 tests, 77.9%,
   promoted through UAT to Prod by PRs #113 and #114. **The Apex coverage risk
   that gated this since August is resolved.** Written by the sessions that did
   it, not by this sweep; recorded here because it is the frame for everything
   below.
2. 🔴🔑 **New: [OI-287](../items/OI-287%20The%20Mexal%20line%20discount%20is%20sent%20as%20a%20line%20total%20instead%20of%20per%20unit.md)
   — the Mexal line discount is sent as a line total where Kreosoft said it is
   per unit.** The ERP vendor said it twice and the client restated it with the
   consequence (_"sbagliamo veramente a fatturare"_); the code multiplies by
   quantity and its comment asserts the opposite without a source. Quantity 1
   agrees, so a casual test passes; the client says quantity 2 is common. **It
   is in production and no discounted order has gone to Mexal end to end.**
3. 🔴 **New: [OI-288](../items/OI-288%20Editing%20a%20Contact%20fails%20in%20production%20when%20the%20Account%20has%20no%20Agente.md)
   — a Contact edit is rolled back in production** when the Account is an
   Azienda with no `Agente__c`. Root-caused in source, both halves. 🔑 **The
   exact defect shape OI-286 predicted**, and permissions cannot fix it.
4. 🔴 **New: [OI-289](../items/OI-289%20The%20production%20ticket%20dispatch%20flow%20references%20a%20field%20that%20does%20not%20exist.md)
   — the active production ticket-dispatch flow throws on `Asset.QR_Id__c`**,
   twice. The field is in no source file; **the flow is org-only**, so the
   repository cannot see why.
5. 🟢🔑 **[OI-284](../items/OI-284%20The%20listino%20sconto%20and%20netto%20mapping%20for%20Mexal%20orders%20is%20undefined.md)
   is answered** — in the call and by mail. `prezzo` = listino, `sconto` with a
   leading minus for an amount, bare for a percentage, comma separator, two
   decimals. 🟢 **The 22/10 percentage-vs-amount disagreement resolved itself.**
   ⚠ Mexal rounding is not configurable and **both sides waived the cent
   aloud** — a decision, recorded as one.
6. 🔴🔑 **New: [OI-290](../items/OI-290%20Lead%20and%20Referenti%20migration%20data%20is%20owed%20by%20the%20client.md)
   — Lead and Referenti migration is scope nobody had written down**, the
   client's PM refused to own it, and the person it was pushed to was absent and
   has not replied. 🔴 Zoho cannot fill the agreed field set; 🔑 consents ride on
   the Lead.
7. 🟢🔑 **ROMI set its own scope boundary** —
   [no further absorption in Fase 1](../decisions/ROMI%20will%20absorb%20no%20further%20scope%20in%20Fase%201.md),
   from the person who signs off the staffing. 🔴 **And twenty minutes later
   OI-290 went to the client as a plain request, not a CR.**
8. 🟡 **[OI-276](../items/OI-276%20Dummy%20import%20editions%20are%20needed%20to%20load%20historical%20orders.md)
   drifted to a third mechanism** — but 🟢🔑 **the underlying rule is finally on
   the record**: _"la data non sia nel futuro, perché altrimenti marketing
   prenderà il link."_ 🟢 Its precondition cleared: all products active.
9. 🟢 **[OI-286](../items/OI-286%20Lead%20conversion%20throws%20in%20UAT%20when%20the%20user%20cannot%20create%20a%20Task.md)'s
   fix merged** via PR #109, in a permission set rather than the excluded
   profile. ⚠ Not verified in the org.
10. 🟢 **`#tproj-pienissimo` spoke after weeks of silence** — the weekly status
    (**26 gg to finish**) and the Fase 2 ruling. 🟢 **Elisa Migliano can log
    in**, open since 19/10 — ⚠ **on Fabrizio Paganelli's own user.**

## The register

⚠ **Nothing found tonight calls for a register change, and nothing was changed.**
OI-287, OI-288 and OI-289 are defects; OI-290 is scope with no stated
requirement. No requirement's text, priority or status changed; the version stays
**1.6**; `go_live: 2026-11-16` and `zoho_expiry: 2026-10-31` are unchanged.

🔴 **`SAL-12` was not amended and is now uncited for a seventh session.** It
reads _"Tutors on fixed price list, no discretionary discounts"_, `status:
agreed` — and as of today a **defined** discount mechanism is built, deployed to
production and the subject of a vendor specification. **Recording any of it as
settled would write one side of a contract conflict into the register**;
reported for a human instead, as on 19/10 through 23/10.

⚠ **`DM-07`'s competitor-list conflict is unchanged.**

🔑 **Three absences remain findings in themselves**: no register row covers the
**order-to-Mexal price breakdown** (OI-284/OI-287), none covers **ticket
migration** (OI-274), and 🆕 none covers **Lead or Contact migration** (OI-290)
— the third such gap in six days, and the second that OI-285's unanswered CR
request would have caught.

⚠ **The Italian wording in `REQUISITI.it.md` still needs a human's eye** —
unchanged, six runs on.

## Corrections to the record

- 🔴🔑 **[OI-284](../items/OI-284%20The%20listino%20sconto%20and%20netto%20mapping%20for%20Mexal%20orders%20is%20undefined.md)
  carried an unsourced claim and it is now flagged.** Its 26/10 build section,
  written by an earlier session the same day, states that _"Mexal **divides** it
  by the line quantity — a `-1000` discount on a quantity-2 line is 500 per
  item."_ **The call it cites says the opposite**, twice, and the client restated
  it. The note was **corrected by appending the contradiction and linking
  OI-287**, not by rewriting the earlier passage — later evidence wins, and both
  readings stay visible with their dates.
- ⚠ **OI-287 rests on testimony, not on a measurement.** Nobody has observed
  Mexal's behaviour on a quantity-above-one discounted line. The call is the
  better evidence — first-hand from the vendor, restated and confirmed by the
  client — but **this is stated as an unresolved contradiction, not as a proven
  miscalculation.** One discounted order at quantity 2 settles it.
- ⚠ **The origin of the inversion is recorded as probable, not certain.** Aurel
  Mrruku said at `00:10` that he holds listino and netto _"moltiplicato per
  quantità"_ and would do the same for the discount, unchallenged. The field he
  then built is per-unit by its own description, so the premise does not hold
  for the code that exists — but **nothing establishes that this sentence caused
  the comment.**
- ⚠ **Both production error mails prove events, never standing states** — the
  lesson that overturned
  [the 27/08 LeadConversionQueueable note](../risks/Risk%20-%20LeadConversionQueueable%20is%20broken%20in%20the%20Pienissimo%20sandbox.md).
  **The org was not opened tonight.** OI-288's cause is nonetheless confirmed in
  source, both halves; OI-289's is confirmed only as an absence.
- 🔑 **OI-289's relation to today's release is explicitly left open.** The flow
  is org-only and was not in the deploy, so the release is unlikely to be the
  cause — but the first failure is ~2 hours after it and **nobody has checked
  whether the flow was already failing.** Recorded as a question, not a
  correlation.
- ⚠ **The Prod/sandbox distinction was checked on the host string, not assumed.**
  OI-288 and OI-289 both name `ability-customization-52152.my.salesforce.com`
  with **no `--partial.sandbox`**, unlike OI-286's 23/10 mail.
- 🔑 **OI-286's fix is in a permission set, not the `Agente` profile.** The
  distinction matters because the Prod deploy excluded that profile by name and
  did not exclude permission sets. ⚠ Stated as deploy-record arithmetic; the org
  was not opened.
- ⚠ **The 26/10 `Test UAT Commerciali` meeting produced nothing** — 20 seconds of
  transcript, no summary. **No meeting note was created**, and its absence is not
  a missing source.
- ⚠ **`LISTINI.xlsx` and `esempio buyergroup / listini` were classified as
  another client with residual uncertainty.** Both are owned by `d.losco@` and
  foldered with the `Business Blueprint - Vision` set. Flagged because catalogue
  prices are a live Pienissimo item (OI-87) and a misclassification here would
  hide one. **Neither was opened.**
- ⚠ **Credential handling was recorded without values.** ~10 minutes of the call
  were Elisa Migliano gaining Salesforce access through Proton Pass. Recorded:
  that she can now log in, that she uses **Fabrizio Paganelli's own
  `amministrazione@` user** so their UAT actions are indistinguishable, and that
  a shared vault and a passkey are in use. **No credential, vault name or
  passkey detail was copied.**
- ⚠ **Dictation repairs are flagged, not silently applied.** The Gemini
  transcript renders Mexal as _"Maxal"/"Maxile"/"Mixal"/"Maxan"_, Salesforce as
  _"sales force"/"sal"/"ses force"_, Mirko as _"Mirco"_, Zoho as _"Zoo"/"Zo"_,
  and emits stray tokens (_"Ja"_, _"Что"_, _"Да"_). Repairs inside quotations are
  bracketed. ⚠ Speaker labels interleave mid-sentence throughout and were read by
  content, per the standing caveat.
- ⚠ **Names appearing without resolution**: **Gianpaolo Motta** (ROMI staffing
  authority, now the author of a decision note — ⚠ **no person note exists** and
  none was created), **Andrea G.** (Fase 2 planning, 24/10 status),
  **Matteo Distaso** and **Rebecca Marmo** (cc on the go-live thread).
- 🔴 **The pre-existing tracker defect is unchanged.** Rows **163–174 remain
  duplicated** in `meetings/open-items.md` **and** `.it.md`, both copies inside
  the same `## Open` section, and the two copies still differ. **None of
  tonight's rows falls in that range.** A human still has to say which copy is
  current.
- ⚠ **`JOURNAL.md` holds ~137 entries against the protocol's "keep the twenty
  most recent"**, and is ~400 KB. **Second run to flag it; still not performed** —
  it is a restructuring of the handoff record, not a mechanical edit.
- ⚠ **Row `| 83  |` is still padded to three characters** in both trackers.
- ⚠ **`MAP.md` still carries two `## Where the project stands` headings.**
  Tonight's entry went into the **first**, which is the live block. Not repaired.
- ⚠ **`MAP.md` is ~320 KB against a header that still promises "under 5 KB".**
  Unchanged, twenty-two runs on.
- ⚠ **Both `DEVELOPMENT-RECAP` files still carry a stale precedence line** —
  _"Precedence, newest first: §45 → §44 → …"_ while the files now end at **§70**.
  **Third run flagged, not repaired**: which sections supersede which is an
  editorial ruling.

## Not done in this run

- The org was **not** opened. `STATUS.md` was not regenerated and the Notion
  mirror stays stale. 🔑 **This matters more than usual tonight**, because three
  of the four new rows are production behaviour and two of them could be settled
  or dismissed in minutes with an org inspection: whether `Asset.QR_Id__c` exists
  in Prod, and how many Azienda accounts carry a blank `Agente__c`.
- **No Apex test was written, proposed or scaffolded**, per the standing
  instruction. 🟢 [OI-64](../items/OI-64%20The%20bundle%20Apex%20test%20suite%20is%20broken.md),
  [OI-66](../items/OI-66%20No%20test%20classes%20for%20the%20Biglietto%20stack.md) and
  [the deploy risk](../risks/Risk%20-%20production%20deploy%20is%20blocked%20by%20Apex%20coverage.md)
  were moved by the sessions that did the deploy, not by this sweep; the risk is
  `resolved` and nothing tonight changed their state. ⚠ Recorded as an absence:
  the test that ships with OI-287's code **asserts the payload, not the
  arithmetic**, so it would pass unchanged if the quantity factor were corrected
  or not.
- **OI-212 was not fixed**, a fourteenth night, and it is now in production.
- **`Esempio SCONTI.pdf` was not opened** — a real customer invoice. ⚠ Its
  purpose is now partly moot: the call it was sent for took place and answered
  the question. **Still worth a human's eye** for the two discount forms it
  shows.
- **`Import Ordini (versione del 23.10.26).xlsx` was not opened** — live customer
  orders and amounts. Unchanged since 23/10.
- **The picklist workbook was not opened** — no tool here fetches a Gmail
  attachment. Fifth day; OI-265 unmoved.
- **`Campi Oggetti, Flussi e Utenti Salesforce - Pienissimo.xlsx` was not
  opened** — recorded by id, owner, size and timestamp only, with its new role
  as OI-290's tracciato.
- **The `DEVELOPMENT-RECAP` precedence headers were not repaired.**
- **`prettier:verify` was not run** (no `node_modules`); `vault:check` is
  dependency-free and was.

## Still unreachable

🆕 **what Mexal actually does with a `sconto` on a quantity-above-one line** —
the one measurement that settles OI-287 · 🆕 **the Mexal discount field name**,
pasted into the Google Meet chat and captured nowhere (**a fourth source now
refers to it and none contains it**) · 🆕 **whether `Asset.QR_Id__c` exists in
Prod**, and whether the ticket flow was failing before today · 🆕 **how many
Azienda accounts have a blank `Agente__c`**, and whether the migration's
_"codice 610"_ agent default applies to accounts as well as orders · 🆕 **whether
Sabatino Rinaldi will supply Lead and Referenti data, and by when** · 🆕 **what
happens to the data-model fields Zoho cannot fill** · 🆕 **whether Lead consent
fields survive the migration** · 🆕 **whether Gianpaolo Motta's Fase 2 ruling has
been or will be said to the client**, and whether the already-absorbed scope is
re-opened, billed or waived · whether the eight 22/10 exclusion rules were
applied to the import file · when the product synchronisation flows go back on,
and who checks · whether the client accepts the Change Request regime (**third
day of silence**) · which profile the UAT user `005MA00000Gh60y` holds · whether
the 11–15 reminder count is 11, 15 or variable · where the `rinunciato` asset
write lives if `RINUNCIA` now lands on the community · what _"differenziare le
comunicazioni"_ per ticket type actually contains (OI-269, ROMI asked, no answer)
· which of the three dummy-edizione mechanisms is the one · who reverses the
whole-catalogue activation, and when · how many credit notes leave the 2024
history · the contents of the picklist workbook, and what the client wants
changed · whether the ~80 live Performance Plus contracts are migrated,
hand-entered or abandoned · whether the client's lawyer permits the
legal-representative fields · the client's ticket field/value structure
(undertaken 21/10, **five days**) · what `Pienissimo 360` is · whether Pienissimo
hold a Zoho contract past 31 October (**eighth run**) · which four `Dettaglio
Motivazione Uscita` values OI-259 means · whether a contract-expiry alert rule
exists in the org (OI-272) · the Fase 2 draft by `Claudio` · which production
user is to be copied for the marketing tests · what _"utente metà bloccato"_
means for WhatsApp · whether a test order created in production reaches live
Mexal · whether Sabatino Rinaldi's user exists · what Fabrizio Mastracci's
_"nuova change request"_ referred to · the 30/07 marketing notes
`1uJCE4NW9nbdI38ADmt66svUT1MRmkyYd24uI0hegAD0` · Zoom tier · training hours ·
who owns tutor training now · the Woo instance · DocuSign prod config ·
`Get Campaign` and the campaign-ID gap · Jira `PIEN` · `Flows & Objects.drawio` ·
the _diretta_ form · who `Andrea` is.
