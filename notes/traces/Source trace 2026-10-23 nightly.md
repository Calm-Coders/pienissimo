---
id: trace-2026-10-23-nightly
type: reference
status: active
updated: 2026-10-23
watermark_used: 2026-10-22T22:00Z
external_watermark: 2026-10-23T22:00Z
account: a.mrruku@romicompany.com
---

# Source trace 2026-10-23 nightly

**Watermark for the next `requirements-check` run: 2026-10-23T22:00Z, single
value.**

**Watermark used: 2026-10-22T22:00Z**, the `external_watermark` stated by
[the 22/10 nightly trace](Source%20trace%202026-10-22%20nightly.md), selected by
`updated:` frontmatter. Scheduled nightly run, executed 2026-10-23 ~21:45Z. One
day.

🟢🔑 **The go-live calendar is agreed in writing by both sides, the migration data
arrived and was not opened, and ROMI put the scope question to the client for the
first time.**

🟢 **Environment note.** The clone opened on `main` (two commits, config only)
with none of the knowledge layer in the working tree; `DevMain` did not exist
locally and was created with `git checkout -B DevMain origin/DevMain` against the
fetched remote branch. **Twenty-one runs, same opening pattern.**

## Sources searched

| Source | Query / scope | Result |
| ------ | ------------- | ------ |
| **Gmail** | `pienissimo after:2026/10/22 -in:draft`, 50 requested, 13 estimated | 🔑 **Six new items.** The **go-live thread** (4 new messages) · the new **`Import Ordini`** thread (6 messages, all today) · the **`Richiesta Call`** thread (3 new, one with an attachment) · the **26/10 calendar invitation** · the **23/10 invitation + Gemini notes** for the 16:00 call · 🔴 **one Salesforce `LeadConversionTrigger` exception** 14:43:05Z |
| **Gmail** | `get_thread 1a158b6e3e4cee81` (PLAIN_TEXT; 62,844 chars, read from the saved tool result, quoted history stripped) | 🟢🔑 **The calendar is agreed in writing.** 10:06:07Z Elena Spini forwards her own 21/10 09:53 reply — 🟢 **the mail the 21/10 trace recorded as not in this mailbox** — with _"comunque NON hanno risposto e ora sto sollecitando"_ · 10:09:04Z the chase, carrying **ROMI's written acceptance** (_"il 16/11 rimanga per noi un target del tutto raggiungibile"_), **the BBP scope position** and **the Change Request ask** · 10:41:34Z 🟢🔑 **the client writes the plan back and accepts it**, signed _"Sabatino/Fabrizio"_ · 13:14:42Z ROMI's point-by-point, adding **9/11 production deploy** and **the file by 13/11 09:00** → [OI-268](../items/OI-268%20The%20client%20proposed%20a%20go-live%20calendar%20of%2016%20November.md), [OI-274](../items/OI-274%20The%20historical%20ticket%20balance%20has%20no%20migration%20path.md), new [OI-285](../items/OI-285%20ROMI%20asked%20the%20client%20to%20route%20future%20out%20of%20scope%20requirements%20through%20change%20requests.md) |
| **Gmail** | `get_thread 1a168166785585be` (MINIMAL) + `get_message 1a168166785585be` (PLAIN_TEXT, attachments listed) | 🟢🔑 **The migration data arrived.** 09:27:39Z Fabrizio Paganelli: _"vi inoltro i dati per fare i test di importazione ordini … si tratta di dati provvisori in quanto poi l'importazione dovremo ripeterla quando passeremo in produzione · Vi chiedo se mi potere chiamare, perché dovrei configurare i prodotti e le edizioni"_. Attachment **`Import Ordini (versione del 23.10.26).xlsx`, 1,103,461 bytes** — ⚠ **not opened** (live customer orders, amounts, article codes). Then four rounds in forty minutes that fail to establish the client's actual blocker → [OI-244](../items/OI-244%20Historical%20orders%20will%20be%20migrated%20from%20Mexal%20by%20spreadsheet.md), [OI-276](../items/OI-276%20Dummy%20import%20editions%20are%20needed%20to%20load%20historical%20orders.md) |
| **Gmail** | `get_message 1a168e75b51387b6` (PLAIN_TEXT, attachments listed) | 🟢🔑 **The 22/10 disagreement has a worked example.** 13:15:53Z, to Elena Spini and Aurel Mrruku, cc `amministrazione@` and `mirko@kreosoft.com`: _"Per l'incontro di lunedì, vi inoltro un esempio di Fattura, dove nelle due righe potete vedere le 2 modalità di gestione degli sconti."_ Attachment **`Esempio SCONTI.pdf`, ~880 KB** — ⚠ **not opened, a real customer invoice** (customer, catalogue prices, article codes). 🔴 A human must read it before Monday → [OI-284](../items/OI-284%20The%20listino%20sconto%20and%20netto%20mapping%20for%20Mexal%20orders%20is%20undefined.md) |
| **Gmail** | thread `1a16424bb89d3e8a` + invitation `1a167b3fe401b85f` (subjects and recipients) | 🟢 **The 26/10 call has an hour.** Fabrizio Paganelli 06:23:24Z _"meglio la mattina dalle 11.00 in poi"_; Elena Spini 07:40:44Z _"Ho mandato il meeting"_. Invite: `[ROMI-PIENISSIMO] - Tema Ordini Mexal`, **Mon 26 Oct 11:00–12:00 (GMT+1)**, agenda _"Tema prezzo di listino, sconti, e importo netto da passare sugli ordini"_, to Aurel Mrruku, `amministrazione@`, **`mirko@kreosoft.com`**, Fabrizio Paganelli. 🔑 **First meeting in the record that invites Kreosoft.** ⚠ GMT+1 — summer time ends 25/10 |
| **Gmail** | `get_message 1a169372a34e3a64` (PLAIN_TEXT) | 🔴 **New defect.** 14:43:05Z, org `00DMA000004nMMr` partial sandbox, user `005MA00000Gh60y`: _"LeadConversionTrigger: execution of AfterUpdate caused by: System.DmlException: Operation failed due to fields being inaccessible on Sobject Task"_, `LeadConversionTriggerHandler.afterUpdate: line 33` → new [OI-286](../items/OI-286%20Lead%20conversion%20throws%20in%20UAT%20when%20the%20user%20cannot%20create%20a%20Task.md). 🟢 **No Anticipay 404 mail tonight** — first clear night in four days |
| **Drive** | `modifiedTime > '2026-10-22T22:00:00Z'`, **2 pages, 28 files** | 🔑 **Two Pienissimo items.** `Import Ordini (versione del 23.10.26).xlsx` (`1ls-nh7tz5SzW6ALhBW0lWlOn15kfEKMo`, owner `a.mrruku@`, created and modified 09:27:39Z — the mail attachment saved out) and the Gemini doc for the 16:00 call (`1UMjx0vHYEyknv_7cj9ntmX43P6Sej0tpG5d5t-mbIsU`, 12,346 bytes, owner Elena Spini, shared 14:11:22Z). ⚠ **No MP4**, as on 19/10, 20/10, 21/10 and 22/10 |
| **Drive** | `read_file_content` on the Gemini doc | 🔑 **Read in full, once, ~12 KB.** It carries the notes **and** the whole transcript, so no second fetch was needed. Transcript preserved verbatim at `meetings/2026-10-23-import-ordini-migrazione-transcript.it.md` (7.8 KB). Completeness checked: it ends on _"Trascrizione terminata dopo 00:06:29"_ |
| **Drive** | the rest of both pages — `[ROMI-LIFE365] DataModel e Migrazione`, `[Daze - Romi] SAL`, `Daze: allineamento interno pre SAL`, `Vision – Vape Italia`, `Business Blueprint - Vision` 1/3/4, `Vision_Data_Dictionary_Salesforce`, `[IUAD] Materiali Cliente`, 247 calendars and EOS reports, `[ROMI] Slide Team`, `Persone ruoli figure capacity competenze`, `DTT_SHR_…_v3.xlsx` | **Other clients or ROMI-internal.** Ignored, and **not counted as missing sources**. 🔑 Note the LIFE365 call got a **`- Transcript`** doc while Pienissimo got **`- Appunti di Gemini`**; both contained the transcript here, so the naming is cosmetic |
| **Slack** | `slack_read_channel C0BQD34LLF4` (dev group), `oldest` 1792706400 = 2026-10-22T22:00Z | **1 message — this procedure's own 22/10 report**, posted 00:02:20 CEST. 🔴 **No human message at all, and still no reply to any nightly report — thirty-three nights** |
| **Slack** | `slack_read_channel C0B5T3RB4FM` (`#tproj-pienissimo`), same bound | **0 messages.** Silent |
| **Slack** | `slack_read_channel C0C38JJ9D1T` (marketing group DM), same bound, + `slack_read_thread 1792758087.684039` | 🔑 **1 message and a 3-reply thread, and they reverse a requirement.** 14:21:27 Elena Spini to Fabrizio Mastracci: _"Marketing: confermati gli 11-15 reminder per edizione e il tasto rinuncia. @Aurel mrruku farà i campi su Campaign"_ · 14:35:26 _"Rinuncia deve rimandare al link generico e io da li li devo buttare fuori dal journey … appena so queste cose e ho i campi mi attivo"_ · 15:06:49 🔴 _"RINUNCIA bottone che rimanda alla community (come il bottone di ACCETTA) - se rinuncia deve uscire dal journey fine"_ · 15:07:21 🔑 _"ok quindi un bottone rosso e un bottone verde che fanno esattamente la stessa cosa. TOP"_ (✅ reaction, unanswered) → [OI-242](../items/OI-242%20The%20community%20Rinuncia%20button%20must%20show%20the%20public%20refusal%20text.md), [OI-250](../items/OI-250%20The%20reminder%20wait%20intervals%20must%20be%20configurable%20per%20edizione.md) |
| **Slack** | `slack_read_channel D0B5QHS2T7H` (Elena Spini DM), same bound | **22 messages, and the Pienissimo half explains the day.** 11:37:28 she pastes Fabrizio Paganelli's 09:27Z mail (which is where its last line, _"Vi chiedo se mi potere chiamare"_, was read) then _"che vuole? -.-"_ · 15:27:06 _"sempre Pienissimo -.-"_ with his 13:21Z mail · 15:35:14–15:36:11 🔑 _"ma che sta a dire"_ · _"cosa centra"_ · **_"facci fare una call che con questo non se ne esce"_** — the call's origin · 15:45:36 ⚠ _"io non ci sono ahaha lo vuoi ascoltare te?"_ → 15:45:45 _"quando? 16?"_ → _"ok"_ · 16:07:04 _"risolto"_ (❤) · 16:08:16 _"facile?"_ · 17:01:33 _"niente è facile con lui"_ · 17:01:50 _"sta aggiornando tutti i prodotti su mexal e li prendo da la"_. ⚠ **A block at 13:02–13:08 is read as another project** — _"per i lead mi sono messa slot settimana prossima"_, _"devo rivedere il doc, post tutte le call dove hanno tolto tutto"_, _"sui lead mancano dei pezzi"_ — see the note below |
| **Slack** | `slack_read_canvas F0BD2H5A9HT` (`Link utili Pienissimo`) | **Unchanged.** Newest entry still 20.08.2026 — **64 days**. Re-read per the skill; still the only source of the 30/07 marketing notes link |
| **Fathom** | `list_meetings created_after 2026-10-22T22:00Z`, summaries, 3 pages | **1 meeting, and it is another client** — `SALESFORCE REPORTS CREATION`, 247.it attendees. 🔴 **Twenty-fourth consecutive run with no Pienissimo meeting**, on a day Google captured a Pienissimo client call |
| **Git** | `fetch origin`, `log --all --since 2026-10-22T22:00:00Z`, `for-each-ref` | 🔴 **6 commits, 0 merges, no PRs, and `DevMain` did not move** — still **`ebc2c5b`**, last night's own nightly commit. Anita Aga on `DevAnita22`: `9512ee0` (10:03), `6e7dacb` (15:48), `3c66b27` (16:26). Rexhina Hysi on `Devmain_LeadChecks`: `f2d454e` (15:05), `579e87a` (16:15), `42602a8` (18:04) |
| **Repo** | `git show --stat` + diffs on all six | `9512ee0` 🔴🔑 **+57 lines in `OrderItemTriggerHandler.cls`** — an Order with no tranches goes to `Incassato` when every line is `Mexal_Payment_Status__c = PAID` · `6e7dacb` −171 in `QuoteManageProductsController`/`QuoteTrancheController` · `3c66b27` 🔑 `quoteManageProducts` html/js/css + controller, **+76/−7, 25 min after the call** · `f2d454e`/`579e87a`/`42602a8` the `Agente` profile and permission set, the last adding 🔑 **`Task.ActivityDate`, `Task.Description`, `Task.WhoId` and `CreateTask`** |
| **Repo** | `sed -n '20,45p' LeadConversionTriggerHandler.cls` | 🔑 **Line 33 is `insert followUpTasks;`** — the unguarded DML for the `Non Risponde` follow-up Task, exactly where the 14:43:05Z mail says it threw. 🟢 Org and repository agree here, unlike the 27/08 case |
| **Repo** | `git log -1 origin/DevMain -- MexalScadenzarioSearchService.cls` | 🔴 **OI-212 unchanged a thirteenth night** — still `f292b72`, 08/10 |
| **Repo** | `ls notes/items` max-id scan | Max existing id **284**, so this run allocated **285** and **286**; next free is **287** |
| **Repo** | register greps (`go_live`, `zoho_expiry`, `version`, `SAL-12`) | **None changed.** No requirement's text, priority or status changed; version stays **1.6**; `go_live: 2026-11-16` and `zoho_expiry: 2026-10-31` as the 21/10 run left them |

## Found

1. 🟢🔑 **The go-live calendar is agreed in writing by both sides.** Nothing about
   the dates changed — **the agreement stopped being verbal**, which is the gap
   [the 21/10 entry](Source%20trace%202026-10-21%20nightly.md) and
   [OI-268](../items/OI-268%20The%20client%20proposed%20a%20go-live%20calendar%20of%2016%20November.md)
   both flagged. ROMI's reply is now in this mailbox, ROMI accepted 16/11 in
   writing, the client wrote the plan back and accepted it signed by their
   project lead, and ROMI added a **9/11 production deploy** and a **13/11 09:00
   file deadline**. ⚠ One day drifted from the 21/10 minute; the written version
   governs.
2. 🔴🔑 **New: [OI-285](../items/OI-285%20ROMI%20asked%20the%20client%20to%20route%20future%20out%20of%20scope%20requirements%20through%20change%20requests.md)
   — ROMI asked for a change-request regime and recorded the ticket migration as
   outside the approved BBP.** First time the CR mechanism is put to the client
   at all. 🔴 **The client answered the calendar paragraph of the same mail and
   said nothing about this one** — selective agreement is the finding.
3. 🟢🔑 **The migration has data.** `Import Ordini (versione del 23.10.26).xlsx`,
   1.1 MB, explicitly provisional, _"l'importazione dovremo ripeterla"_.
   ⚠ **Unopened**, so 🔑 **nothing here states whether the 22/10 exclusion rules
   were applied to it** — including the one
   [OI-275](../items/OI-275%20The%20Mexal%20order%20key%20is%20not%20unique%20without%20the%20order%20date.md)'s
   uniqueness now rests on.
4. 🔴🔑 **The product synchronisation flows are switched off in UAT**, so the
   client's written assumption that his Mexal edits arrive overnight is false,
   and **a mail from the client is the only link** between Kreosoft's mass
   update and ROMI's re-import. Fifth migration-only condition; 🟢 the first
   with an owner by his own statement.
5. 🟢🔑 **[OI-284](../items/OI-284%20The%20listino%20sconto%20and%20netto%20mapping%20for%20Mexal%20orders%20is%20undefined.md)
   is narrower than it read**: `netto` already reaches Mexal, the missing field
   is **listino on the order line**, and ROMI waits on Kreosoft and nothing else.
   🟢 The call has an hour (**Mon 26/10 11:00 CET**) and 🔑 **Kreosoft is
   invited for the first time**; plus a worked-example invoice, ⚠ unopened.
6. 🟢 **[OI-283](../items/OI-283%20Discounts%20cannot%20be%20edited%20on%20an%20existing%20order.md)'s
   open question is answered** — the quote shares the gap; 🟢 an edit path was
   demonstrated and accepted, 🔴 on the quote, as work in progress, and the
   build is unmerged.
7. 🔑 **[OI-242](../items/OI-242%20The%20community%20Rinuncia%20button%20must%20show%20the%20public%20refusal%20text.md)
   was reversed without being called a reversal** — the published
   `rifiuta-evento` text is gone from the ask, and the four technical
   consequences are unaddressed rather than withdrawn. 🔴 Marketing is blocked
   on Campaign fields with no date (also
   [OI-250](../items/OI-250%20The%20reminder%20wait%20intervals%20must%20be%20configurable%20per%20edizione.md)).
8. 🔴 **New: [OI-286](../items/OI-286%20Lead%20conversion%20throws%20in%20UAT%20when%20the%20user%20cannot%20create%20a%20Task.md)
   — lead conversion dies on a Task it cannot create**, rolling back the user's
   Lead edit. 🟢 A matching permission fix landed 1 h 21 min later, ⚠ as a
   correlation and ⚠ unmerged.
9. 🔴🔑 **[OI-212](../items/OI-212%20A%20Ri.Ba.%20rate%20reads%20as%20paid%20before%20its%20due%20date.md)
   is unchanged a thirteenth night and the suspect predicate spread** to an
   order-level `Incassato` state, which ~15,000–30,000 historical lines will
   inherit on load. Nothing in the commit cites the row.
10. 🔴 **`DevMain` did not move.** Six commits, all on personal branches, no
    pull requests — including both of the fixes this run identified.

## The register

⚠ **Nothing found tonight calls for a register change, and nothing was changed.**
OI-285 is a governance request and OI-286 a defect; neither is an amendment. No
requirement's text, priority or status changed; the version stays **1.6**;
`go_live: 2026-11-16` and `zoho_expiry: 2026-10-31` are as the 21/10 run left
them.

🟢🔑 **But the evidence under `go_live: 2026-11-16` improved.** The 21/10 run
moved the register on an agreement minuted from a call, with
⚠ _"ROMI's written reply … not in evidence here."_ **That reply is now in
evidence, and so is the client's written acceptance.** The register value is
unchanged; what changed is that it is now backed by a mutual exchange in writing
rather than a verbal one. ⚠ **The Italian wording in `REQUISITI.it.md` still
needs a human's eye** — unchanged, three runs on.

🔴 **`SAL-12` was not amended and is now uncited for a sixth session.** It reads
_"Tutors on fixed price list, no discretionary discounts"_, `status: agreed`,
while a call with the ERP vendor is booked for Monday to define how discounts
travel to Mexal and the client is actively testing discounts in UAT.
**Recording any of it as settled would write one side of a contract conflict
into the register**; reported for a human instead, as on 19/10, 20/10, 21/10 and
22/10.

⚠ **`DM-07`'s competitor-list conflict is unchanged.**

🔑 **Two absences remain findings in themselves**: no register row covers the
**order-to-Mexal price breakdown** (OI-284), and none covers **ticket
migration** (OI-274) — and OI-285 now makes the second one a governance question
as well as a technical one.

## Corrections to the record

- 🟢 **The 21/10 and 22/10 note that ROMI's written reply was unreachable is
  closed.** It was forwarded into this mailbox at 10:06:07Z today. ⚠ **And its
  content turned out to matter less than its fate**: the client had not answered
  it for two days, which is why a chase was needed.
- 🔑 **OI-284's "Salesforce is ready" reading was too coarse.** The 22/10 note
  recorded _"io ce li ho i campi"_ as meaning the whole breakdown was ready to
  send. Today's call narrows it: **`netto` is already transmitted**, `listino`
  is not, and the field in question is on the **order line**. Corrected in the
  note rather than reversed — the 22/10 account was right about ROMI not being
  the blocker.
- 🔑 **OI-242's title now describes something nobody is asking for.** The ask of
  14 October was the published `rifiuta-evento` text; the specification of
  23 October is the community, like `ACCETTA`. **Later evidence wins and the
  reversal is recorded**, both dates cited. ⚠ The id and filename are unchanged,
  per the standing rule.
- ⚠ **OI-283 is not closed by today's demonstration**, and the reasons are
  recorded in the note rather than left to inference: wrong object, work in
  progress by the speaker's own statement, and the build unmerged.
- ⚠ **OI-286 is an error mail, which proves an event and never a standing
  state.** That is the lesson that overturned
  [the 27/08 LeadConversionQueueable note](../risks/Risk%20-%20LeadConversionQueueable%20is%20broken%20in%20the%20Pienissimo%20sandbox.md),
  and it is written into the new note. **The org was not opened tonight.**
- ⚠ **The `42602a8` → OI-286 link is a correlation, stated as one.** The mail
  names a user id, not a profile, and nothing establishes that
  `005MA00000Gh60y` is an `Agente`.
- ⚠ **Dictation repairs are flagged, not silently applied.** Gemini renders
  Mexal as _"Maxal"_/_"Maxale"_/_"Maxile"_/_"Maxali"_, Salesforce as
  _"sales force"_/_"salce"_/_"sal"_, Mirko as _"Mirco"_, and emits stray tokens
  (_"Ja"_, _"Что"_). Repairs inside quotations are bracketed. ⚠ The speaker
  labels in the discount exchange interleave mid-sentence and were read by
  content, per the standing caveat.
- ⚠ **A block of the Elena Spini DM at 13:02–13:08 is read as another project
  and was not ingested.** It runs _"che fatica con questi diooooooo … per i lead
  mi sono messa slot settimana prossima"_ · _"devo rivedere il doc, post tutte
  le call dove hanno tolto tutto"_ · _"sui lead mancano dei pezzi"_. 🔑 **It is
  genuinely ambiguous**: a LIFE365 `DataModel e Migrazione` call ran at 12:00
  CEST the same day, which fits _"abbiamo definito qualcosa oggi"_ — but
  Pienissimo also has live lead work (`Devmain_LeadChecks`, OI-259's exit
  reasons). **Recorded as an explicit uncertainty, not resolved, and no note was
  changed on the strength of it.** Elena Spini's own _"sempre Pienissimo -.-"_ at
  15:27:06, marking the later block, is weak evidence that the earlier one was
  not.
- ⚠ **Names appearing without resolution**: **Mirko Merendi** (Kreosoft, has a
  person note, now a named dependency on OI-284), **Luca** and **Gianpaolo**
  (other projects). **No person note was created.**
- 🔴 **The pre-existing tracker defect is unchanged.** Rows **163–174 remain
  duplicated** in `meetings/open-items.md` **and** `.it.md`, both copies inside
  the same `## Open` section, and the two copies still differ. **None of
  tonight's rows falls in that range.** A human still has to say which copy is
  current.
- 🆕 ⚠ **`JOURNAL.md` holds 132 entries against the protocol's "keep the
  twenty most recent"**, and is ~390 KB. The rule says archive the rest to
  `notes/sessions/YYYY-QN.md`. **No sweep has done it and this one did not
  either** — it is a restructuring of the handoff record, not a mechanical
  edit, so it is flagged rather than performed. First run to flag it.
- ⚠ **Row `| 83  |` is still padded to three characters** in both trackers.
- ⚠ **`MAP.md` still carries two `## Where the project stands` headings.**
  Tonight's entry went into the **first**, which is the live block. Not repaired.
- ⚠ **`MAP.md` is ~313 KB against a header that still promises "under 5 KB".**
  Unchanged, twenty-one runs on.
- ⚠ **Both `DEVELOPMENT-RECAP` files still carry a stale precedence line** —
  _"Precedence, newest first: §45 → §44 → …"_ while the files now end at **§69**.
  Stale since §46 and **not repaired here**: which sections supersede which is
  an editorial ruling, not a mechanical one. Second run flagged.

## Not done in this run

- The org was **not** opened. `STATUS.md` was not regenerated and the Notion
  mirror stays stale. Every build claim is repository arithmetic against
  `origin/DevMain` `ebc2c5b` and the two unmerged branches.
- **No Apex test was written, proposed or scaffolded**, per the standing
  instruction. [OI-64](../items/OI-64%20The%20bundle%20Apex%20test%20suite%20is%20broken.md),
  [OI-66](../items/OI-66%20No%20test%20classes%20for%20the%20Biglietto%20stack.md) and
  [the deploy risk](../risks/Risk%20-%20production%20deploy%20is%20blocked%20by%20Apex%20coverage.md)
  were not touched; nothing tonight changed their state. ⚠ Today's commits add
  57 lines of Apex (`OrderItemTriggerHandler`) and 4 to
  `QuoteManageProductsController` **with no Apex test**, so the untested surface
  grew again. Recorded as an absence, not acted on.
- **OI-212 was not fixed**, a thirteenth night. The correction is a code change
  and belongs to Aurel Mrruku.
- **`Import Ordini (versione del 23.10.26).xlsx` was not opened** — live customer
  orders and amounts. Recorded by name, size, ids and timestamps only.
- **`Esempio SCONTI.pdf` was not opened** — a real customer invoice carrying
  catalogue prices and article-code values. Recorded by name, sender,
  recipients, timestamp and stated purpose only.
- **The picklist workbook was not opened** — no tool here fetches a Gmail
  attachment. Second day.
- **`Referenti Salesforce.xlsx`** was not touched; it did not appear in tonight's
  Drive window.
- **The `DEVELOPMENT-RECAP` precedence headers were not repaired** — see above.
- **`prettier:verify` was not run** (no `node_modules`); `vault:check` is
  dependency-free and was.

## Still unreachable

🆕 whether the eight 22/10 exclusion rules were actually applied to
`Import Ordini (versione del 23.10.26).xlsx` · 🆕 what the two discount forms in
`Esempio SCONTI.pdf` actually are · 🆕 when the product synchronisation flows go
back on, and who checks · 🆕 whether the client accepts the Change Request
regime, and what process would implement it · 🆕 which profile the UAT user
`005MA00000Gh60y` holds, and whether any other profile reaching
`LeadConversionTrigger` lacks Task access · 🆕 whether the 11–15 reminder count
is 11, 15 or variable · 🆕 where the `rinunciato` asset write lives if `RINUNCIA`
now lands on the community like `ACCETTA` · what Mirko Merendi actually told
Fabrizio Paganelli about the listino/sconto/netto fields (**three sources now
refer to it and none contains it**) · what the right edit behaviour for an order
discount is (the client declined to say) · whether the dummy editions or the
`old` flag is the mechanism · who reverses the whole-catalogue activation, and
when · how many credit notes leave the 2024 history · the contents of the
picklist workbook, and what the client actually wants changed · whether the ~80
live Performance Plus contracts are migrated, hand-entered or abandoned ·
whether the client's lawyer permits the legal-representative fields · the
client's ticket field/value structure (undertaken 21/10, **three days**) · what
`Pienissimo 360` is · whether Pienissimo hold a Zoho contract past 31 October
(**seventh run**) · which four `Dettaglio Motivazione Uscita` values OI-259
means · what `differenziare le comunicazioni` contains (OI-269) · whether a
contract-expiry alert rule exists in the org (OI-272) · the Fase 2 draft by
`Claudio` · whether the 23/10 marketing support was confirmed · which production
user is to be copied for the marketing tests · what _"utente metà bloccato"_
means for WhatsApp · whether a test order created in production reaches live
Mexal · whether Sabatino Rinaldi's user exists · whether Elisa Migliano can log
in on her own account · what Fabrizio Mastracci's _"nuova change request"_
referred to · the 30/07 marketing notes
`1uJCE4NW9nbdI38ADmt66svUT1MRmkyYd24uI0hegAD0` · Zoom tier · training hours ·
who owns tutor training now · the Woo instance · DocuSign prod config ·
`Get Campaign` and the campaign-ID gap · Jira `PIEN` · `Flows & Objects.drawio` ·
the _diretta_ form · who `Andrea` is.
