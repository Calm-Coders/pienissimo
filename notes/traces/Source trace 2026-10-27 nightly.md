---
id: trace-2026-10-27-nightly
type: reference
status: active
updated: 2026-10-27
watermark_used: 2026-10-26T22:00Z
external_watermark: 2026-10-27T22:00Z
account: a.mrruku@romicompany.com
---

# Source trace 2026-10-27 nightly

**Watermark for the next `requirements-check` run: 2026-10-27T22:00Z, single
value.**

**Watermark used: 2026-10-26T22:00Z**, the `external_watermark` stated by
[the 26/10 nightly trace](Source%20trace%202026-10-26%20nightly.md), selected by
`updated:` frontmatter. Scheduled nightly run, executed 2026-10-27 ~21:45Z.
**One day.**

🟢🔑 **The client answered three of the open ticketing questions — through a mail
this mailbox does not hold — ROMI priced Fase 2 and quietly moved open Fase 1
rows into it, and the production load was given a date of tomorrow.**

🟢 **Environment note.** The clone opened on `main` (two commits, config only)
with none of the knowledge layer in the working tree; `DevMain` did not exist
locally and was created with `git checkout DevMain` against the fetched remote
branch. **Twenty-three runs, same opening pattern.**

## Sources searched

| Source | Query / scope | Result |
| ------ | ------------- | ------ |
| **Gmail** | `pienissimo after:2026/10/26 -in:draft`, 50 requested, 16 estimated | 🔑 **Nine new items**, the densest mail day in weeks. New threads **`Inserimento Campagne`** · **`Mappature`** · **`Mappatura Edizioni`** (2) · **`Trasferimento dati`** (2) · **`Account Area Commerciale`** · the **Anagrafica Articoli** invitation · two **Gemini notes** notifications (Anagrafica Articoli, Follow-up Interno) · 2 new messages on **`Aggiornamento Anagrafica Articoli`** |
| **Gmail** | `get_thread 1a17cb07449cb0af` (PLAIN_TEXT, read in full) | 🔑 **Four client requests in one mail**, Fabrizio Paganelli 09:28:19Z: campaigns parent and child inserted · **anno accademico needed** · _"Nella Campagna controllante … si dovrebbero vedere solo le campagne padre (qui oltre alle padre vedo anche tutte le campagne figlie)"_ · dates unknown at child-campaign creation, _"Queste date si possono modificare anche dopo? e anche se nel frattempo si sono generati dei biglietti?"_ · _"Non riusciamo a modificare le colonne (le voci sono disabilitate)"_. **All four answered in the 12:00 call** → [the meeting note](../meetings/2026-10-27%20Anagrafica%20Articoli.md) |
| **Gmail** | `get_thread 1a17d77a1132e4da` (PLAIN_TEXT, both messages in full) | 🟢🔑 **Two scope answers to the client.** Marco Montesi 13:05:53Z asked about importing the tutors' Zoho calendar and where to put notes; Elena Spini 17:27:02Z answered point by point — **no calendar import or sync** → [the decision](../decisions/The%20Zoho%20tutor%20calendar%20is%20not%20migrated%20to%20Salesforce.md) — and **the standard Notes object on Lead, Account and Opportunità**, with the deliberate caveat _"non attiva automatismi, flussi o notifiche di sistema"_ → [OI-292](../items/OI-292%20The%20Notes%20related%20lists%20on%20Lead%20Account%20and%20Opportunity%20are%20not%20built.md) |
| **Gmail** | `get_message 1a17c5932e0d4ea0` (PLAIN_TEXT) | 🔑 **The UAT cleanup request, and Kreosoft's own round trip.** Fabrizio Paganelli 07:53:01Z: _"ci sono alcune cose dell'anagrafica prodotti che non mi tornano … guardando la mappatura edizioni vedo che ci sono all'interno le prove che avevamo fatto. Per testare l'import degli ordini storici non è forse meglio pulire tutto?"_ The quoted chain holds Mirko Merendi's 26/10 confirmation _"Ho completato l'importazione dei prodotti richiesti dal file"_ and Fabrizio Paganelli's _"in Salesforce sono attivi i codici prodotto che su Mexal hanno Gruppo Merceologico = S, giusto?"_ — the premise the 12:00 call corrected |
| **Gmail** | `get_thread 1a17e0bb99bbea46` (PLAIN_TEXT) | 🟢 **The mappature are done.** Fabrizio Paganelli 15:47:38Z: _"dovremmo aver completato le mappature. Ti segnalo alcune incongruenze con le descrizione delle Categorie Prodotto. Ti mando la lista che abbiamo su Mexal"_, attachment `Categorie Prodotto.xlsx`. ⚠ **Not opened**; the inconsistencies themselves are not described in the mail |
| **Gmail** | thread `1a17d81184363beb` (subjects, senders, snippets) | 🟢 **A support exchange, closed same hour.** Fabrizio Paganelli 13:16:12Z _"Tra le campagne non ne trovo alcune, ad esempio per Academy non trovo 'Academy OLD'"_ → Aurel Mrruku 13:47:01Z _"dovevi attivare la campagna. ho fatto io e adesso li trovi."_ No new requirement |
| **Gmail** | `1a17d328d1758cb0` (PLAIN_TEXT) | 🔑 **The agent list arrived 22 minutes after the call** — 11:50:25Z, _"ti invio l'elenco degli utente dell'area commerciale. Abbiamo un utente generico (vedi record evidenziato in rosso). Aggiungo anche Marco"_, attachment `Utenti Area Commerciale.xlsx` (10,398 bytes) → [OI-293](../items/OI-293%20The%20agent%20registry%20for%20the%20production%20load%20may%20be%20incomplete.md). ⚠ **Attachment not opened; it names individuals. No values copied** |
| **Gmail** | `from:sabatino.r@pienissimo.com OR to:... newer_than:14d` | 🔴🔑 **The answer is not here.** Four threads, all previously held: the 26/10 Lead/Referenti request **to** him, the 16/10 go-live thread (last client message 23/10), the Stato Avanzamento thread, the Blueprint thread. **No reply from Sabatino Rinaldi in the window**, although one demonstrably exists — see **Found 1**. Run deliberately to test the inference |
| **Gmail** | the two `gemini-notes@google.com` / `meetings-noreply` notifications | Used only to locate the Drive artifacts for the day's two meetings |
| **Drive** | `modifiedTime > '2026-10-26T22:00:00Z'`, **2 pages, 32 files** | 🔑 **Seven Pienissimo items.** The **Follow-up Interno** notes (`1_npAY1ezf8Fk1TzIpalZyX1PUdyoa1UBLCE_bloAhAw`, 31,484 B) **and a 559 MB MP4 recording** (`1ajTcv9ebj6thCkK4MB_EbogRO-goGca2`) — **the first Pienissimo recording since 23/10** · the **Anagrafica Articoli** notes (`1x9PiTol4OV3Sp7SeQc8Ve00QGC2IF8Mc-2JPL5oToYY`, 22,723 B, no recording) · 🆕 **`Pienissimo_Project_Plan_Fase2`** (`1b329SMXkcG3kivDfvoziCFuk2I19DlQQqS_UTQtKFeA`, 2,688,592 B, created 09:12:59Z, modified 17:08:43Z) · 🆕 **`Contatti_Zoho_CRM_`** (`18Jif9_B4yEhybsS6bQLzilNu4kykvYTwqA56seugyaU`, **10,767,377 B**, created and modified 16:48Z, owner `a.mrruku@`) · **`Tracciato migrazione ordini Mexal - Salesforce.xlsx`** modified 16:23:42Z · **`Utenti Area Commerciale.xlsx`** created 11:50:25Z · **`Account Salesforce_V2.xlsx`** modified 11:05:24Z, owner `fabrizio.pienissimo@gmail.com` |
| **Drive** | `title contains 'Anagrafica Articoli' or title contains 'Follow-up Interno'` | Resolved both meetings' folders, shortcuts and documents, and confirmed the recurring-meeting folders. 🔑 The Anagrafica call got a combined **notes + transcript** document and **no** recording; the Follow-up got notes + transcript **and** a recording |
| **Drive** | `read_file_content` on the Anagrafica Articoli document | 🔑 **Read in full, once, ~22 KB.** Preserved verbatim at `meetings/2026-10-27-anagrafica-articoli-transcript.it.md`. Completeness checked: ends on _"Trascrizione terminata dopo 00:28:08"_. Drilled into [the meeting note](../meetings/2026-10-27%20Anagrafica%20Articoli.md) |
| **Drive** | `read_file_content` on the Follow-up Interno document | 🔑 **Read in full, once, ~49 KB — the day's single most valuable source.** Exceeded the tool's inline limit and was read from the saved result in slices. Preserved verbatim at `meetings/2026-10-27-follow-up-interno-transcript.it.md`. Ends on _"Trascrizione terminata dopo 00:43:26"_. Drilled into [the meeting note](../meetings/2026-10-27%20Follow-up%20Interno.md) |
| **Drive** | the rest of both pages — `[ROMI/IUAD] - Meet integrazione Eduarth-Salesforce` (folder, notes, `a.cerutti@`), `romi per AI` (folder, notes, 719 MB MP4, `g.motta@`), `Business Blueprint - Vision` 1–4, **`Registro CR - Vision`**, `Vision_Stima_Provvigioni`, `Open Point`, `immagini.zip`, the two IUAD flow images, `DTT_SHR_…_v3.xlsx`, `Piano ferie/assenze Natale 2026` | **Other clients or ROMI-internal.** Ignored, and **not counted as missing sources.** 🔑 **`Registro CR - Vision` was checked deliberately** (`1D3ouI6z8aRscRF2Ltj4NcQYEAcLLq21-GSGD-pNVrfs`, modified 17:00:06Z, `d.losco@`): ROMI **does** keep a Change Request register — for the Vision engagement. ⚠ **Pienissimo has none**, four days after [OI-285](../items/OI-285%20ROMI%20asked%20the%20client%20to%20route%20future%20out%20of%20scope%20requirements%20through%20change%20requests.md) proposed the mechanism. **Not opened**; recorded as the existence of a comparable artifact elsewhere |
| **Slack** | `slack_read_channel C0BQD34LLF4` (dev group), `oldest` 1793052000 = 2026-10-26T22:00Z | 🟢🔑 **4 messages — the dev group spoke for the first time in thirty-seven nights.** 17:27:38 CET Aurel Mrruku posted the **agent table** (7 rows: Cognome · Nome · mail · Codice Agente · Categoria Provvigioni Cliente · Zona) and at 17:27:50 tagged Rexhina Hysi; 17:29:44 _"i am proceeding"_; **18:03:28 _"done added also the permission set Agente to these users"_** → [OI-293](../items/OI-293%20The%20agent%20registry%20for%20the%20production%20load%20may%20be%20incomplete.md). ⚠ Real names, work addresses and agent codes — **no values copied.** 🔴 **Still no reply to any nightly report — thirty-seven nights** |
| **Slack** | `slack_read_channel C0B5T3RB4FM` (`#tproj-pienissimo`), same bound | **0 messages.** Silent again after the 24–26/10 exchange |
| **Slack** | `slack_read_channel C0C38JJ9D1T` (marketing group DM), same bound | 🟢🔑 **12 messages, and they carry the client's answers** — the single richest Slack read of this project. 09:18:10 CET **Elena Spini quotes Sabatino Rinaldi's mail verbatim**, section _"3. BIGLIETTI E COMUNICAZIONI EVENTI"_ → [OI-250](../items/OI-250%20The%20reminder%20wait%20intervals%20must%20be%20configurable%20per%20edizione.md), [OI-242](../items/OI-242%20The%20community%20Rinuncia%20button%20must%20show%20the%20public%20refusal%20text.md), [OI-269](../items/OI-269%20Event%20communications%20must%20be%20differentiated%20by%20ticket%20type.md); 09:19:09 her own ruling _"sarà per forza fase 2 … ma come deve essere gestita?"_; **09:23:33 Fabrizio Mastracci _"No infatti la 2 bloccala, la 1 e la 3 ok"_**; and 09:10–09:14 his absence from the 17:00 alignment plus _"i pomeriggi sono impegnato su altri fronti"_ → [the risk](../risks/Risk%20-%20the%20delivery%20team%20shrinks%20before%20Fase%202.md) |
| **Slack** | `slack_read_channel D0B5QHS2T7H` (Elena Spini DM), same bound | 🟢 **15 messages.** 09:29–09:34 the reaction to the UAT cleanup request — Aurel Mrruku _"adesso vuole uat pulito … non si rende conto di quello che chiede … chiede tanto effort e non serve a nulla"_, which explains his mail reply; **18:05:57 Elena Spini _"poi mi mette le related list NOTE su lead/account e oprty???"_ → 18:13:41 _"e nelle ultime cose da fare per me"_ / 18:13:51 _"però Si lo farò"_** → OI-292; 18:16:59 _"almeno sta tranquillo Marco"_. ⚠ Internal, ROMI-only; the invective is not reproduced in the records |
| **Slack** | `slack_read_canvas F0BD2H5A9HT` (`Link utili Pienissimo`) | **Unchanged.** Newest entry still 20.08.2026 — **68 days**. Re-read per the skill; still the only source of the 30/07 marketing notes link |
| **Fathom** | `list_meetings created_after 2026-10-26T22:00Z`, 3 pages | **0 meetings.** 🔴 **Twenty-sixth consecutive run with no Pienissimo meeting** — on a day Google captured two, one of them recorded to MP4 |
| **Git** | `fetch origin`, `log --all --since 2026-10-26T22:00:00Z`, `for-each-ref` | 🟢 **`DevMain` moved `428f42b` → `c3002a3`**: `5faac77` (Anita Aga, **12:00 CET**) and `c3002a3` (**PR #115** from `DevAnita27`, merged by Aurel Mrruku 12:44 CET). **4 further commits unmerged on `DevAnita27`** 17:01–17:42 CET: an Account field, flexipages and compact layouts, a Contact list view, a Product list view. `UAT` and `Prod` unchanged since 26/10 |
| **Repo** | `git show --stat 5faac77`; `git diff --stat c3002a3 origin/DevAnita27` | 🟢 `5faac77` is **one file**, `Campaign/fields/ParentId.field-meta.xml`, +16 — exactly the filter Aurel Mrruku described in the call. The unmerged `DevAnita27` work is 30 files / +799 and touches `Fattura__c`, `Scadenza_Fattura__c`, Product2 record types and list views, `Agente` and `Full_Permission` permission sets |
| **Repo** | `grep -n -A6 resolveLineDiscount MexalOrderSendService.cls` | 🔴 **[OI-287](../items/OI-287%20The%20Mexal%20line%20discount%20is%20sent%20as%20a%20line%20total%20instead%20of%20per%20unit.md) unchanged** — the multiplication and the comment asserting that Mexal divides are both still there. **Second night in production** |
| **Repo** | register greps (`version`, `go_live`, `zoho_expiry`, `SAL-12`) | **None changed.** Version stays **1.6**; `go_live: 2026-11-16`; `zoho_expiry: 2026-10-31`; `SAL-12` still reads _"Tutors on fixed price list, no discretionary discounts"_, `status: agreed` |
| **Repo** | `ls notes/items` max-id scan | Max existing id **290**, so this run allocated **291**, **292** and **293**; next free is **294** |

## Found

1. 🟢🔑 **The client answered — and the mail is not in this mailbox.** Sabatino
   Rinaldi replied on the ticketing and communications points, and the reply is
   known **only** through Elena Spini's verbatim quotation in the ROMI marketing
   group DM at 09:18:10 CET. ⚠ **Its date is unknown.** It reads as a
   point-by-point answer to ROMI's 16/10 internal-meeting mail — the thread
   Elena Spini noted on 23/10 that Aurel Mrruku and Fabrizio Mastracci
   _"non eravate in copia"_ on — which is the likely reason it is absent.
   **Inferred, and recorded as inference.** A deliberate 14-day Gmail sweep on
   his address confirmed the absence rather than assuming it.
2. 🟢🔑 **[OI-250](../items/OI-250%20The%20reminder%20wait%20intervals%20must%20be%20configurable%20per%20edizione.md)
   is answered**: _"un set di 11–15 comunicazioni con ritardi orari impostati a
   livello di edizione"_, accepted for the paid events, which are named for the
   first time. ROMI is asked to proceed with configuration and templates. 🆕 **A
   new requirement rides in — templates _"completamente personalizzabili"_** —
   which appears in no row, no register entry and no recap, and has no owner.
3. 🟢🔑 **[OI-242](../items/OI-242%20The%20community%20Rinuncia%20button%20must%20show%20the%20public%20refusal%20text.md)
   is confirmed by the client**: the button tracks the renunciation, the ticket
   is not deleted, and the client reconciles after the event. The `rinunciato`
   write is therefore a state change, ⚠ still unlocated in the build.
4. 🔴🔑 **[OI-269](../items/OI-269%20Event%20communications%20must%20be%20differentiated%20by%20ticket%20type.md)
   was restated as a requirement, not specified — and ROMI decided the same
   morning to block it.** _"la 2 bloccala, la 1 e la 3 ok."_ 🔴 **The client has
   not been told**, a third day of internal rulings, and **ROMI still does not
   know what the requirement is** while a Fase 2 estimate carries a number for it.
5. 🟢🔑 **Fase 2 has a man-day estimate for the first time** —
   [the estimate](../The%20Fase%202%20estimate.md), reviewed line by line, with
   Aurel Mrruku's dissent recorded on one figure. 🔴🔑 **The finding is that it
   absorbs open Fase 1 rows** (OI-269, OI-272, the OI-212 territory, the credit
   notes excluded on 22/10) — Gianpaolo Motta's 26/10 ruling being executed
   internally, ⚠ **with nothing said to the client about what moved.** 🟢
   Authorship resolved: Elena Spini with **Claudio**.
6. 🔑 **The production load finishes tomorrow**, stated to the client unprompted
   and again internally, with the order import to follow. **15 fields in Prod**,
   an `Agente` permission set narrowed, seven commercial users created and
   granted it the same evening. 🔴 **WooCommerce production endpoints needed and
   not yet requested.** ⚠ **Whether that import is the migration or a rehearsal
   is unstated**, against an agreed 13/11 extract and 16/11 go-live.
7. 🔴 **New: [OI-291](../items/OI-291%20Changing%20an%20edizione%20date%20does%20not%20update%20its%20product%20mappings.md)
   — changing an edizione date leaves its ~20 product mappings behind.**
   Conceded in the room as _"è un casino"_ and handed to the client. 🔑 **The
   far-future-date workaround agreed in the same conversation guarantees the
   work**, and the compounding was raised by neither side.
8. 🔴 **New: [OI-293](../items/OI-293%20The%20agent%20registry%20for%20the%20production%20load%20may%20be%20incomplete.md)
   — one agent code carries two agent names**, which is why a complete list
   including retired agents was asked for twice; seven rows of current staff
   arrived. 🔑 **The codes are `610.000NN`, so the 22/10 import default "code
   610" names a prefix**, and which code it resolves to is unstated.
9. 🟢 **New: [OI-292](../items/OI-292%20The%20Notes%20related%20lists%20on%20Lead%20Account%20and%20Opportunity%20are%20not%20built.md)
   and two decisions** — [notes in a related list](../decisions/Notes%20live%20in%20a%20related%20list%20and%20not%20a%20field%20on%20orders.md),
   [no Zoho calendar migration](../decisions/The%20Zoho%20tutor%20calendar%20is%20not%20migrated%20to%20Salesforce.md).
   🟢 The second is the **first new client request declined outright** since the
   scope ruling; ⚠ declined, not routed as a Change Request.
10. 🔴🔑 **The delivery team shrinks** — Rexhina Hysi moves to another project,
    Fabrizio Mastracci's afternoons are elsewhere, and
    [the Fase 2 estimate states no staffing assumption](../risks/Risk%20-%20the%20delivery%20team%20shrinks%20before%20Fase%202.md).
11. 🟢 **[OI-290](../items/OI-290%20Lead%20and%20Referenti%20migration%20data%20is%20owed%20by%20the%20client.md)
    has a deadline — Monday 2 November — and the Account join is the `codice
    cliente esterno`.** ⚠ The follow-up mail was not sent. 🔑 Sabatino Rinaldi
    answered the ticketing thread and not this one: **the silence is selective.**

## The register

⚠ **Nothing found tonight calls for a register change, and nothing was changed.**
OI-291 and OI-293 are build and data defects; OI-292 is a configuration
commitment. Version stays **1.6**; `go_live: 2026-11-16` and
`zoho_expiry: 2026-10-31` as earlier runs left them.

🔴 **`SAL-12` was not amended and is now uncited for an eighth session.** It
reads _"Tutors on fixed price list, no discretionary discounts"_, `status:
agreed`, while a defined discount mechanism runs in production and is the
subject of a vendor specification. **Recording any of it as settled would write
one side of a contract conflict into the register**; reported for a human
instead, as on every run since 19/10.

⚠ **`DM-07`'s competitor-list conflict is unchanged.**

🔑 **Five absences remain findings in themselves.** No register row covers the
**order-to-Mexal price breakdown** (OI-284/OI-287), **ticket migration**
(OI-274), **Lead or Contact migration** (OI-290), and 🆕 none covers **note
capture** (OI-292) or **template editability** — the latter a requirement the
client stated in writing today. **Two new gaps in one day**, and both are the
kind OI-285's unanswered Change Request request would have caught.

⚠ **The Italian wording in `REQUISITI.it.md` still needs a human's eye** —
unchanged, seven runs on.

## Corrections to the record

- 🔴🔑 **The nightly Mexal alignment is now claimed and denied in the same
  record.** Aurel Mrruku told the client _"corretto, corretto"_ that Mexal
  changes are picked up overnight (`00:25:48`), while on 23/10 he said the
  product sync flows were **switched off** and the 26/10 sweep recorded that
  nothing had said they were back on. **Later evidence wins, but a verbal
  assurance to a client is not evidence of org state**, and which environment he
  meant is unstated. **Recorded as an unresolved contradiction, not as a
  correction.** The org was not opened.
- 🔑 **`Gruppo Merceologico = S` does not mean what the record implied.** Fabrizio
  Paganelli: _"la S l'ho messa solo sui prodotti che sono stati movimentati dal
  primo gennaio 24"_ — Aurel Mrruku: _"Non lo sapevo."_ So the flag is an
  activity window matching the order extract's cut-off, not a sellability
  marker. His judgement that it is harmless rests on Fabrizio Paganelli's word
  that no sales movement references an `N` product; ⚠ **unverified against data.**
- 🔑 **The migration's "agent code 610" default is a prefix, not a code.** The
  22/10 exclusion rule has been recorded as _"missing agent → existing code
  610"_ for five runs; today's agent list shows codes of the form `610.000NN`.
  **Which specific code the default resolves to is unstated**, and the generic
  shared row is the obvious candidate without anyone saying so.
- ⚠ **OI-290's Account join was recorded as the Mexal code and is now the
  `codice cliente esterno`.** Both may be the same identifier under two names;
  **nothing in the call establishes that**, so the earlier reading is not
  retracted, only superseded with its date.
- ⚠ **The 26/10 trace's "missing fields in the import tracciato" would have been
  a false finding.** The columns looked empty because the file is sorted and its
  leading rows are zero-value omaggio lines. Caught by ROMI, not by this sweep;
  recorded because the same artefact could mislead a future run.
- ⚠ **`Contatti_Zoho_CRM_` is not evidence that the client delivered.** A 10.7 MB
  contacts sheet appeared at 16:48Z under Aurel Mrruku's ownership, fifteen
  minutes before the call in which the two of them examined a contacts file.
  **Whether it is a client delivery, an earlier export, or ROMI's own conversion
  is unestablished**, and OI-290 records it as such. **Not opened** — real
  contact records.
- ⚠ **Attribution in the Follow-up transcript was read by content, not by
  label.** Gemini interleaves speaker labels mid-sentence throughout, and
  Fabrizio Paganelli's eleven minutes arrive **through a speakerphone** with no
  separate label at all, so his lines appear under Elena Spini's. Every quotation
  attributed to him in the notes was placed by content; **flagged as a standing
  caveat on that file.**
- ⚠ **Dictation repairs are flagged, not silently applied.** The transcripts
  render Rexhina as _"Regina"_, Anita as _"Ana"/"Anna"/"Ana Sapilo"_, Mexal as
  _"Mexaldo"/"maxile"_, WooCommerce as _"Wocommerce"/"Wcommerce"_, Food Marketing
  Festival as _"The Four Marketing Festival"_, `importo netto` as _"in porto
  netto"_, and the Salesforce certification as _"clamo"_. Repairs inside
  quotations are bracketed.
- ⚠ **Personal data was recorded without values.** The agent list (seven named
  individuals, work addresses, agent codes, posted to Slack and attached to
  mail) is recorded by **shape only** — row count, column names, the presence of
  one generic shared account. `Contatti_Zoho_CRM_`, `Account Salesforce_V2.xlsx`
  and `Categorie Prodotto.xlsx` were **not opened**.
- ⚠ **Names appearing without resolution**: **Claudio** (co-author of the Fase 2
  estimate, no surname, no person note), **Andrea** (the Fase 2 estimate's
  recipient — ambiguous between
  [Andrea Di Cicco](../people/Andrea%20Di%20Cicco%20-%20solution%20architect%20ROMI.md)
  and the _"Andrea G."_ of the 24/10 status; **not guessed**).
  🟢 **Gianpaolo Motta now has a person note**, flagged missing on two runs —
  ⚠ with his role explicitly marked as this record's inference.
- 🔴 **A new pre-existing defect: the Risks table in `INDEX.md` is malformed.**
  Its header is followed by a data row, a blank line, a second data row, and only
  then the `| --- |` separator, so the table does not render as one. **Found
  while inserting tonight's risk row**; the new row was placed in a well-formed
  position and **the malformation was left for a human**, like the duplicated
  tracker rows.
- 🔴 **The pre-existing tracker defect is unchanged.** Rows **163–174 remain
  duplicated** in `meetings/open-items.md` **and** `.it.md`, both copies inside
  the same `## Open` section, and the two copies still differ. **None of
  tonight's rows falls in that range.**
- ⚠ **Row `| 83  |` is still padded to three characters** in both trackers.
- ⚠ **`JOURNAL.md` holds ~140 entries against the protocol's "keep the twenty
  most recent"**, and is ~400 KB. **Third run to flag it; still not performed** —
  it is a restructuring of the handoff record, not a mechanical edit.
- ⚠ **`MAP.md` still carries two `## Where the project stands` headings.**
  Tonight's entry went into the **first**, which is the live block. Not repaired.
- ⚠ **`MAP.md` is ~330 KB against a header that still promises "under 5 KB"**,
  and `INDEX.md`'s own note count was stale (486 → **513**, corrected tonight).
- ⚠ **Both `DEVELOPMENT-RECAP` files still carry a stale precedence line** —
  _"Precedence, newest first: §45 → §44 → …"_ while the files now end at **§71**.
  **Fourth run flagged, not repaired**: which sections supersede which is an
  editorial ruling.

## Not done in this run

- The org was **not** opened. `STATUS.md` was not regenerated and the Notion
  mirror stays stale. 🔑 **It matters again tonight**: whether the product sync
  flows are on, whether `Asset.QR_Id__c` exists in Prod, how many Azienda
  accounts carry a blank `Agente__c`, and whether the seven new agent users and
  the `Agente` permission set are really there — all are minutes of inspection.
- **No Apex test was written, proposed or scaffolded**, per the standing
  instruction. [OI-64](../items/OI-64%20The%20bundle%20Apex%20test%20suite%20is%20broken.md),
  [OI-66](../items/OI-66%20No%20test%20classes%20for%20the%20Biglietto%20stack.md) and
  [the deploy risk](../risks/Risk%20-%20production%20deploy%20is%20blocked%20by%20Apex%20coverage.md)
  are unchanged; the risk stays `resolved`. ⚠ Recorded as an absence: **nothing
  tests an edizione date change against existing mappings** (OI-291), and
  OI-287's test still asserts the payload rather than the arithmetic.
- **OI-212 was not fixed**, a fifteenth night, and it is in production.
- **`Pienissimo_Project_Plan_Fase2` was not opened** — recorded by id, owner,
  size and timestamps, with its figures taken from the review call and marked
  approximate. It is Fase 2 material and out of the Fase 1 perimeter.
- **The 559 MB Follow-up recording was not opened** — the transcript covers it.
- **`Categorie Prodotto.xlsx`, `Utenti Area Commerciale.xlsx`,
  `Contatti_Zoho_CRM_`, `Account Salesforce_V2.xlsx`, `Esempio SCONTI.pdf`,
  `Import Ordini (versione del 23.10.26).xlsx` and the OI-265 picklist workbook
  were not opened** — real customer, contact or staff records, or no tool here
  fetches them. **Sixth day for the picklist workbook; OI-265 unmoved.**
- **`Registro CR - Vision` was not opened** — another client; its existence alone
  is the finding.
- **The `DEVELOPMENT-RECAP` precedence headers and the `INDEX.md` Risks table
  were not repaired.**
- **`prettier:verify` was not run** (no `node_modules`); `vault:check` is
  dependency-free and was.

## Still unreachable

🆕 **Sabatino Rinaldi's own mail**, which carries the answers to OI-242, OI-250
and OI-269 — **quoted in Slack, absent from this mailbox, date unknown** · 🆕
**whether the product synchronisation flows are actually on**, now that the
client has been told they are · 🆕 **what _"template completamente
personalizzabili"_ means** — who edits, in what tool, with what guardrails · 🆕
**whether the retired agent codes are in the delivered list**, and which code the
migration's `610` default resolves to · 🆕 **whether the 28–29/10 production order
import is the migration or a rehearsal** · 🆕 **the WooCommerce production
endpoints** · 🆕 **Rexhina Hysi's leaving date, her replacement, and who inherits
`Devmain_LeadChecks` and `Devmain_QuoteTriggerChanges`** · 🆕 **who Claudio is**,
and **which Andrea** the Fase 2 estimate went to · 🆕 **what the Categoria
Prodotto description inconsistencies are** · 🆕 **how many commitments sit in the
Zoho tutor calendars, and who re-enters them** · what Mexal actually does with a
`sconto` on a quantity-above-one line — the one measurement that settles OI-287 ·
the Mexal discount field name, pasted into a meeting chat and captured nowhere ·
whether `Asset.QR_Id__c` exists in Prod, and whether the ticket flow was failing
before 26/10 · how many Azienda accounts have a blank `Agente__c`, and whether
the `610` agent default applies to accounts as well as orders · whether Sabatino
Rinaldi will supply Lead and Referenti data by Monday 2 November · what happens
to the data-model fields Zoho cannot fill · whether Lead consent fields survive
the migration · whether Gianpaolo Motta's Fase 2 ruling will be said to the
client, and whether already-absorbed scope is re-opened, billed or waived ·
whether the eight 22/10 exclusion rules were applied to the import file · whether
the client accepts the Change Request regime (**fourth day of silence**) · which
profile the UAT user `005MA00000Gh60y` holds · where the `rinunciato` asset write
lives · which of the three dummy-edizione mechanisms is the one · who reverses
the whole-catalogue activation, and when · how many credit notes leave the 2024
history · the contents of the picklist workbook, and what the client wants
changed · whether the ~80 live Performance Plus contracts are migrated,
hand-entered or abandoned · whether the client's lawyer permits the
legal-representative fields · the client's ticket field/value structure
(undertaken 21/10, **six days**) · what `Pienissimo 360` is · whether Pienissimo
hold a Zoho contract past 31 October (**ninth run, four days out**) · which four
`Dettaglio Motivazione Uscita` values OI-259 means · whether a contract-expiry
alert rule exists in the org (OI-272) · which production user is to be copied for
the marketing tests · what _"utente metà bloccato"_ means for WhatsApp · whether
a test order created in production reaches live Mexal · whether Sabatino
Rinaldi's user exists · what Fabrizio Mastracci's _"nuova change request"_
referred to · the 30/07 marketing notes
`1uJCE4NW9nbdI38ADmt66svUT1MRmkyYd24uI0hegAD0` · Zoom tier · training hours · who
owns tutor training now · the Woo instance · DocuSign prod config ·
`Get Campaign` and the campaign-ID gap · Jira `PIEN` · `Flows & Objects.drawio` ·
the _diretta_ form.
