---
id: trace-2026-10-28-nightly
type: reference
status: active
updated: 2026-10-28
watermark_used: 2026-10-27T22:00Z
external_watermark: 2026-10-28T22:00Z
account: a.mrruku@romicompany.com
---

# Source trace 2026-10-28 nightly

**Watermark for the next `requirements-check` run: 2026-10-28T22:00Z, single
value.**

**Watermark used: 2026-10-27T22:00Z**, the `external_watermark` stated by
[the 27/10 nightly trace](Source%20trace%202026-10-27%20nightly.md), selected by
`updated:` frontmatter. Scheduled nightly run, executed 2026-10-28 ~21:45Z.
**One day.**

🟢🔑 **The historical load ran end to end — in UAT and not in production — the
client delivered the Referenti file and committed to the Lead list by tomorrow,
and the day's one client call was lost to a broken transcript.**

🟢 **Environment note.** The clone opened on `main` (two commits, config only)
with none of the knowledge layer in the working tree; `DevMain` did not exist
locally and was created with `git checkout DevMain` against the fetched remote
branch. **Twenty-four runs, same opening pattern.**

## Sources searched

| Source | Query / scope | Result |
| ------ | ------------- | ------ |
| **Gmail** | `pienissimo after:2026/10/27 -in:draft`, 50 requested, 15 estimated | 🔑 **Twelve new messages across six threads.** New: **`Test`** (3) · the **Connessione WooCommerce** invitation · two **Import Ordini** acceptances. New messages on **`Import Ordini`** (10 since the watermark) · **`Tracciato dati Lead/Referenti`** (3) · **`Trasferimento dati`** (1) · **`Account Area Commerciale`** (2) |
| **Gmail** | second pass, `(from/to/cc:pienissimo.com OR kreosoft OR merendi OR mexal OR woocommerce) after:2026/10/27` | 🆕 **One item the project-name query missed**: the Salesforce error notification `1a18311817f3381e` → [OI-296](../items/OI-296%20Account%20creation%20to%20Mexal%20failed%20in%20UAT%20and%20account%20send%20was%20switched%20off.md). ⚠ **Worth keeping**: org-generated mail does not carry the project name |
| **Gmail** | `get_thread 1a168166785585be` (METADATA_ONLY, 16 messages) then 6 bodies in full | 🔑 **The day's spine.** 11:52Z `ID riga Mexal` challenged · 12:00Z the 2022/2023 order-date question · 12:11Z _"Non vedo righe nulle. Magari chiamami nel pomeriggio"_ · 12:13Z 🔑 **the cut-off is on the invoice, not the order** · 13:08Z the call invitation · 15:24Z **the order import figures** · 15:32Z **Referenti V2 announced** · 16:17Z **the full invoice/scadenze result** · 16:19Z _"Ho anche apperto le api verso mexal"_ · 16:21Z _"Bene! Ottimo lavoro."_ → [OI-244](../items/OI-244%20Historical%20orders%20will%20be%20migrated%20from%20Mexal%20by%20spreadsheet.md) |
| **Gmail** | `get_message 1a182445d8971094` + thread `1a181e993625de7c` (PLAIN_TEXT) | 🆕 **Two findings in one short thread.** 09:48:49Z the client asks to run the invoice/incassi elaborations himself → [OI-294](../items/OI-294%20The%20client%20asks%20to%20run%20the%20invoice%20and%20payment%20update%20jobs%20itself.md); 11:27:59Z the reply blocks the Mexal integrations for the day — _"per evitare la creazione duplicata di 7.721 ordini su Mexal"_ — and **does not answer the question asked** |
| **Gmail** | thread `1a1786a9c1a23757` (list + snippets, 4 messages) | 🟢🔑 **The follow-up mail was sent and answered in ninety seconds.** Elena Spini 09:18:11Z; `amministrazione@pienissimo.com` (Elisa Migliano) 09:19:28Z — _"ci stiamo lavorando io e Sabatino, **entro domani** provvederemo a passarvi la lista"_; Elena Spini 10:37:13Z. → [OI-290](../items/OI-290%20Lead%20and%20Referenti%20migration%20data%20is%20owed%20by%20the%20client.md) |
| **Gmail** | `get_message 1a181f71b664c0a6` (PLAIN_TEXT) | ⚠ **Marco Montesi answered inline.** Notes: _"l'ho trovata, poi vedremo se lasciarla o no"_ → [OI-292](../items/OI-292%20The%20Notes%20related%20lists%20on%20Lead%20Account%20and%20Opportunity%20are%20not%20built.md). Calendar: _"Ok, qui faranno il trasferimento a mano"_ → [the decision](../decisions/The%20Zoho%20tutor%20calendar%20is%20not%20migrated%20to%20Salesforce.md) |
| **Gmail** | `get_message 1a18255affbf1465` and `1a18267cb2ced69d` (PLAIN_TEXT) | 🟢🔑 **The `610` default resolves to `610.00001`.** Aurel Mrruku 11:46:54Z sent the 16-code distribution with customer counts; Fabrizio Paganelli 12:06:40Z: _"li puoi forzare tutti su 610.00001 … quando ti invierò i movimenti definitivi da portare in produzione farò già questa trasformazione."_ → [OI-293](../items/OI-293%20The%20agent%20registry%20for%20the%20production%20load%20may%20be%20incomplete.md) |
| **Gmail** | the WooCommerce invitation `1a182dd5f59d7d43` (14:15:07Z) | 🆕 **`[ROMI-PIENISSIMO] - Connessione WooCommerce`, Friday 30 October 15:00–16:00 CET**, Elena Spini to Aurel Mrruku **and `sabatino.r@pienissimo.com`**. 🔑 **The standing "Woo production endpoints not yet requested" item now has a meeting**, with the right person invited. Not yet held |
| **Drive** | `modifiedTime > '2026-10-27T22:00:00Z'`, **2 pages, 17 files** | 🔑 **Five Pienissimo items.** The **Import Ordini** notes+transcript (`1KDR2dI1APQxOZeYfxvEBHkD2MHpeD1X5FMaOe_gFuwo`, 15,695 B) · its **380 MB MP4** (`1BX1z4KJ3XmYQUtZsMSY7YTz-IMfcm2RK`) · its **271-byte chat log** (`1YzoV9av0iZQJM9QnGY-PlLjW539lL71R`) · 🆕 **`Referenti Salesforce_V2.xlsx`** (`1tHPebvZvnPh0DwDSbmxtEpgOkfY_XDs-`, **14,239,851 B**, owner `fabrizio.pienissimo@gmail.com`, created 15:30:32Z) · the client's **SALESFORCE** folder touched 13:54Z |
| **Drive** | `read_file_content` on the Import Ordini document | 🔴 **Read in full, ~15 KB, and it is empty of content.** An Italian call transcribed as English filler; the auto-summary asserts unsupported content. **Not drilled, nothing written into any item** → [the meeting note](../meetings/2026-10-28%20Import%20Ordini.md). ⚠ **Not preserved to `meetings/`**: there is no transcript to preserve |
| **Drive** | `read_file_content` on the meeting chat log | 🟢 **Intact, and the only usable product of the call.** Two links from Elena Spini: `00:23:57` the client's SALESFORCE migration folder; `00:32:51` **the data-model workbook at `gid=571873204`**. 🔑 So the half-hour mark was spent in the Lead/Referenti field mapping |
| **Drive** | `parentId` listing of the client's `SALESFORCE` folder and its `LEAD`/`ACCOUNT`/`REFERENTI` children | Five subfolders: `ACCOUNT`, `REFERENTI`, `LEAD`, `PREVENTIVI`, `OPPORTUNITA`. 🔴 **`LEAD` holds nothing new** — consistent with the Lead half still being owed. `REFERENTI` holds the V2 beside the 21/10 original and `Contatti_Zoho_CRM_` |
| **Drive** | `get_file_metadata` on `121CTGF0mCkL_hiQIZWL1aYEirqwdSVZs` (the chat's second link) | Resolved to **`Campi Oggetti, Flussi e Utenti Salesforce - Pienissimo.xlsx`**, already held as [a note](../The%20Campi%20Oggetti%20Flussi%20e%20Utenti%20workbook.md), modified 26/10. ⚠ Its metadata snippet carries Lead/Account/Referente field tables **and one real customer row**; no values copied |
| **Drive** | the rest of both pages — `[ROMI-ZUCCHET] - Integrazione SFDC-3CX` folder and notes, `Business Blueprint - Vision` 1 and 3, **`Registro CR - Vision`** (touched again 19:16Z), `SALESFORCE recap points to fix` (`tiziana.petruzzi@247.it`), `Persone ruoli figure capacity competenze` (`g.motta@`) | **Other clients or ROMI-internal.** Ignored, **not counted as missing sources**. ⚠ The capacity sheet was touched 08:11Z, the day after [the shrinking-team risk](../risks/Risk%20-%20the%20delivery%20team%20shrinks%20before%20Fase%202.md) was raised; **not opened** — ROMI staffing data |
| **Slack** | `slack_read_channel C0BQD34LLF4` (dev group), `oldest` 1793138400 | **1 message — this sweep's own 27/10 report** (23:14:34 CET, just past the watermark). 🔴 **No human reply: thirty-eight nights.** Yesterday's four messages were the only break |
| **Slack** | `slack_read_channel C0B5T3RB4FM` (`#tproj-pienissimo`), same bound | **0 messages.** Silent |
| **Slack** | `slack_read_channel C0C38JJ9D1T` (marketing group DM), same bound | 🟡 **4 messages.** 15:00:03 Fabrizio Mastracci asks for _"una decina di record di test per inviti evento"_; 15:06:24 refused for now (_"sto facendo il deploy in prod e sto facendo delle migrazioni"_); 🔑 **15:24:14 _"spero entro venerdì finiamo tutto così hai la produzione up & running"_** — the production target slips to 30/10; 15:55:09 _"Va bene, aggiornami tu, intanto mi arrangio con i record che ho"_ |
| **Slack** | `slack_read_channel D0B5QHS2T7H` (Elena Spini DM), same bound + one thread | 🟢🔑 **27 messages, the richest source of the day.** 16:38:29 the **Referenti V2 link**, _"file referenti che hanno dato Fabrizio e Sabatino"_ · 17:03:12 🆕 **Sabatino Rinaldi's private Lead request** and 17:07:07 the checkbox decision → [OI-295](../items/OI-295%20Leads%20imported%20from%20Zoho%20must%20be%20distinguishable%20from%20new%20leads.md) · 17:05–17:10 🔑 **the migration has cost _"una 10 di gg"_**, _"tutti"_ on it, and _"poi Gianpaolo chiede a me"_ · 17:18 **_"importazione fatta"_** and the OLD-links question → [OI-297](../items/OI-297%20The%20OLD%20edizione%20links%20are%20unresolved%20before%20the%20production%20load.md). ⚠ 08:56 and 17:45 are ROMI-ZUCCHET, ignored |
| **Slack** | `slack_read_canvas F0BD2H5A9HT` (`Link utili Pienissimo`) | **Unchanged.** Newest entry still 20.08.2026 — **69 days**. Re-read per the skill |
| **Fathom** | `list_meetings created_after 2026-10-27T22:00Z`, 3 pages | **0 meetings.** 🔴 **Twenty-seventh consecutive run with no Pienissimo meeting** — on a day Google recorded 380 MB of one |
| **Git** | `fetch origin`, `log --all --since 2026-10-27T22:00:00Z`, `for-each-ref` | 🟢 **`DevMain` moved `c3002a3` → `d9d18e3`**: `bfa08db` (Anita Aga, 10:51 CET), `cb1a073` (**PR #116** merged 10:54), `243572b` _"allineamento dev main uat"_ (11:48), `e359655` _"updates"_ (12:12), `d9d18e3` _"ordini caricato con successo"_ (17:24). 🔴 **`UAT` and `Prod` unchanged since 26/10**, against a day described to the client as a production deploy |
| **Repo** | `git diff --stat 4c1b36b d9d18e3`, then the Apex diffs | 🆕 **Two code facts no meeting or mail carries.** `MexalSearchCalloutService` gained `public static Integer accountingYear` overriding the `Anno=` header → [the note](../objects/Mexal%20archives%20documents%20by%20accounting%20year.md); `OrderMexalIntegrationService` gained a **permanent** skip on `Origine__c == 'Mexal'`, _"sending them would duplicate them"_ — ⚠ against the client being told the block was **temporary** |
| **Repo** | `git diff` on metadata | 🟢 **The client's 27/10 campaign asks are being built**: `Campaign.Anno_Accademico__c`, a **`Campagna_Figlio`** record type, Campaign and Campign_Edizione compact layouts, the `Edizione` list view. 🟢 PR #116 renames the `Plus Attivazione Rinnovo` record type to **Performance Plus**. ⚠ `Account_Import_UAT` repoints to `Tipologia_Attivita_Globale__c` |
| **Repo** | `grep -n -A6 resolveLineDiscount MexalOrderSendService.cls` | 🔴 **[OI-287](../items/OI-287%20The%20Mexal%20line%20discount%20is%20sent%20as%20a%20line%20total%20instead%20of%20per%20unit.md) unchanged** — the multiplication and the comment asserting Mexal divides are both still there. **Third night in production** |
| **Repo** | register greps (`version`, `go_live`, `zoho_expiry`, `SAL-12`) | **None changed.** Version **1.6**; `go_live: 2026-11-16`; `zoho_expiry: 2026-10-31`; `SAL-12` still _"Tutors on fixed price list, no discretionary discounts"_, `status: agreed` |
| **Repo** | `ls notes/items` max-id scan | Max existing id **293**, so this run allocated **294**, **295**, **296** and **297**; next free is **298** |

## Found

1. 🟢🔑 **The historical load ran end to end, and it was a rehearsal in UAT.**
   7,721 orders and 10,806 invoices linked without a gap — **17,299/17,299**
   order lines and **7,721/7,721** orders invoiced — reported to the client live
   and acknowledged. 🔑 **This settles the 27/10 question** _"is the 28–29/10
   import the migration or a rehearsal"_: Aurel Mrruku's own _"concludo tutto il
   ciclo in UAT"_, with `Prod` and `UAT` unmoved in git. 🔴 **The production
   target slipped from "entro domani sera" to "spero entro venerdì".**
2. 🔴🔑 **A 57-minute client call is effectively unrecorded**, and 🔑 **Sabatino
   Rinaldi is labelled as speaking in it** — the first call in this record he
   takes part in. Gemini transcribed Italian as English and produced filler;
   **nothing from the call or its auto-summary has been written into any item.**
   🟢 The meeting chat survived and places the data-model workbook at the
   half-hour mark.
3. 🟢🔑 **[OI-290](../items/OI-290%20Lead%20and%20Referenti%20migration%20data%20is%20owed%20by%20the%20client.md)
   moved twice.** The follow-up mail went at 09:18:11Z; the client answered in
   ninety seconds with **a written commitment for 29 October** — three days ahead
   of ROMI's own internal Monday — and **`Referenti Salesforce_V2.xlsx` arrived
   at 15:30Z**, co-authored by Sabatino Rinaldi per Elena Spini. ⚠ Not opened,
   not yet checked.
4. 🆕🔴 **New: [OI-295](../items/OI-295%20Leads%20imported%20from%20Zoho%20must%20be%20distinguishable%20from%20new%20leads.md)
   — migrated Leads must be distinguishable from post-16/11 ones.** Asked
   **privately** by Sabatino Rinaldi, relayed by Elena Spini, answered inside a
   ROMI DM with a `Lead from Zoho` checkbox. 🔴 Nothing built; the field must
   exist before the Lead load; **the client has not been told what was decided**,
   including that cleanup is handed back to him.
5. 🟢🔑 **The missing-agent default is `610.00001`**, and 🔑 **the client will
   apply the transformation in the production file himself** — so the ROMI
   fallback must not fire twice, and which is authoritative on 13/11 is unstated.
   🔴 It collapses every unmatched code onto one agent rather than disambiguating
   any: **16 codes in use, 7 rows delivered.**
6. 🔑 **A premise correction: the 2024 cut-off is on the invoice, not the order.**
   _"sono partito dalle fatture emesse a partire dal 01.01.2024 … questo il
   motivo per cui nella data ordine trovi anche gli anni 2022 e 2023."_ The
   pre-2024 orders are the shape of an invoice-driven extract, not stragglers.
7. 🆕 **New: [OI-294](../items/OI-294%20The%20client%20asks%20to%20run%20the%20invoice%20and%20payment%20update%20jobs%20itself.md)**
   — the client asked to launch the invoice and incassi elaborations himself;
   **the reply answered a different question** and the thread closed on him
   waiting.
8. 🆕🔴 **New: [OI-296](../items/OI-296%20Account%20creation%20to%20Mexal%20failed%20in%20UAT%20and%20account%20send%20was%20switched%20off.md)**
   — a Mexal customer create failed **HTTP 400** at 15:12Z while the client
   tested; account send was switched off twelve minutes later rather than
   diagnosed, the integration log was not read, and **only the order API is
   recorded as reopened.**
9. 🆕🔴 **New: [OI-297](../items/OI-297%20The%20OLD%20edizione%20links%20are%20unresolved%20before%20the%20production%20load.md)**
   — the OLD edizione links are left live, with delete and deactivate both on the
   table and the decision deferred to "domani". 🔑 "Link" is never defined in the
   exchange; not guessed.
10. 🆕🔑 **New domain knowledge from code, not from a person:
    [Mexal archives documents by accounting year](../objects/Mexal%20archives%20documents%20by%20accounting%20year.md).**
    Every Mexal read before 28/10 was silently scoped to the current year. ⚠
    **Never confirmed with Kreosoft**, and it applies again at the 13/11 extract.
11. 🔑 **The migration has cost more than ten man-days and no line covers it** —
    _"solo di migrazione abbiamo speso una 10 di gg"_, _"tutti"_ on it, and
    _"poi Gianpaolo chiede a me"_. Outside the Fase 2 estimate and outside Fase 1.
12. 🟢 **The WooCommerce gap has a meeting at last** — Friday 30 October
    15:00 CET, with `sabatino.r@pienissimo.com` invited. **Not yet held**, and
    the production endpoints are still not in hand.

## The register

⚠ **Nothing found tonight calls for a register change, and nothing was changed.**
OI-294 through OI-297 are a request, a data requirement, an integration fault and
an unmade decision. Version stays **1.6**; `go_live: 2026-11-16` and
`zoho_expiry: 2026-10-31` as earlier runs left them.

🔴 **`SAL-12` was not amended and is now uncited for a ninth session.** Reported
for a human, as on every run since 19/10. ⚠ **`DM-07`'s competitor-list conflict
is unchanged.**

🔑 **The absences remain findings.** No register row covers the **order-to-Mexal
price breakdown** (OI-284/OI-287), **ticket migration** (OI-274), **Lead or
Contact migration** (OI-290, and now OI-295 inside it), **note capture**
(OI-292), **template editability**, or 🆕 **a client-side run of the invoice and
incassi jobs** (OI-294).

⚠ **The Italian wording in `REQUISITI.it.md` still needs a human's eye** —
unchanged, eight runs on.

## Corrections to the record

- 🔑 **The 2024 scope rule was recorded on the wrong side of the document.**
  Five runs have carried _"invoiced orders since 01/01/2023"_ and the 22/10 rules
  in order-date terms. The client's 12:13:25Z mail puts the cut-off on the
  **invoice** date, which is why orders dated 2022 and 2023 are in the file by
  design. **Corrected on OI-244 with both dates cited.**
- 🔑 **"Blocking the integrations" is temporary in the mail and permanent in the
  code.** The client was told _"è necessario bloccare temporaneamente le
  integrazioni"_; the same day `OrderMexalIntegrationService` gained a standing
  skip on `Origine__c == 'Mexal'`. **Both can be true** — a permanent origin
  filter plus a session switch — **and only the filter is in source.** Recorded
  as a distinction, not as a contradiction.
- ⚠ **The 27/10 "selective silence" reading of Sabatino Rinaldi is superseded.**
  He is named as co-author of the Referenti file, labelled as speaking in the
  14:07 call, and wrote privately to Elena Spini about the Lead import — all on
  28/10. The earlier reading is not retracted, only overtaken with its date.
- ⚠ **"Entro lunedì 2 novembre" was ROMI's intention; "entro domani" is the
  client's commitment.** The two are not the same kind of fact and the record now
  carries both, with their sources.
- ⚠ **The Import Ordini auto-summary is recorded as an artefact, not as
  content.** It names a September Food Marketing Festival campaign, an October
  layout campaign, lead sources and an action _"Record contact details into
  Pandra"_. **None of it is corroborated by the transcript it came from**, and
  none of it has been written into an item note.
- ⚠ **Speaker attribution in that transcript cannot be trusted either**, so
  Sabatino Rinaldi's participation is recorded as *labelled*, with the
  independent support of a `cdg@pienissimo.com` acceptance at 13:24:13Z — ⚠ **an
  address that appears nowhere else in these records and is not resolved to a
  person.**
- ⚠ **Personal data was recorded without values.** `Referenti Salesforce_V2.xlsx`
  (14.2 MB), `Contatti_Zoho_CRM_`, `Account Salesforce_V2.xlsx`, `Categorie
  Prodotto.xlsx` and `Utenti Area Commerciale.xlsx` were **not opened**. The
  agent-code distribution is recorded as **counts against codes**, which are
  business identifiers, not personal data; no name was copied. ⚠ The Drive
  metadata snippet of the data-model workbook surfaced **one real customer row**
  unbidden; nothing from it is reproduced.
- 🔴 **The pre-existing defects are unchanged**: rows **163–174 remain duplicated**
  in `meetings/open-items.md` **and** `.it.md` with the copies still differing;
  the **Risks table in `INDEX.md` is still malformed**; row `| 83  |` is still
  padded; **both `DEVELOPMENT-RECAP` files still carry a precedence line ending
  at §45** while they now end at **§72** — fifth run flagged, still an editorial
  ruling rather than a mechanical edit.
- ⚠ **`JOURNAL.md` holds ~140 entries against the protocol's "keep the twenty
  most recent"**, and is ~420 KB. **Fourth run to flag it.**
- ⚠ **`MAP.md` still carries two `## Where the project stands` headings**;
  tonight's entry went into the **first**, which is the live block.

## Not done in this run

- The org was **not** opened. `STATUS.md` was not regenerated and the Notion
  mirror stays stale. 🔑 **It matters again**: whether account send is still off
  in UAT (OI-296), what integration log `a05MA00000GqqcPYAR` says, whether the
  product sync flows are on, whether `Asset.QR_Id__c` exists in Prod, and
  whether the 28/10 load is visible where the client will look.
- **No Apex test was written, proposed or scaffolded**, per the standing
  instruction. [OI-64](../items/OI-64%20The%20bundle%20Apex%20test%20suite%20is%20broken.md),
  [OI-66](../items/OI-66%20No%20test%20classes%20for%20the%20Biglietto%20stack.md) and
  [the deploy risk](../risks/Risk%20-%20production%20deploy%20is%20blocked%20by%20Apex%20coverage.md)
  are unchanged; the risk stays `resolved`. ⚠ Recorded as an absence: **nothing
  tests `accountingYear`**, and OI-287's test still asserts the payload rather
  than the arithmetic.
- **OI-212 was not fixed**, a sixteenth night, in production.
- **The 380 MB Import Ordini recording was not opened** — no tool here reads an
  MP4, and the transcript that should have covered it is empty.
- **`Referenti Salesforce_V2.xlsx`, `Contatti_Zoho_CRM_`, `Account
  Salesforce_V2.xlsx`, `Categorie Prodotto.xlsx`, `Utenti Area Commerciale.xlsx`
  and the OI-265 picklist workbook were not opened** — real customer, contact or
  staff records, or no tool here fetches them. **Seventh day for the picklist
  workbook; OI-265 unmoved.**
- **`Persone ruoli figure capacity competenze` and `Registro CR - Vision` were
  not opened** — ROMI staffing data and another client.
- **The `DEVELOPMENT-RECAP` precedence headers, the `INDEX.md` Risks table and
  the duplicated tracker rows were not repaired.**
- **`prettier:verify` was not run** (no `node_modules`); `vault:check` is
  dependency-free and was.

## Still unreachable

🆕 **What was actually said in the 14:07 Import Ordini call** — 57 minutes, the
client's data owner in the room, 380 MB of video and no transcript · 🆕 **what
`ID riga Mexal` was agreed to mean**, lost in that call · 🆕 **who
`cdg@pienissimo.com` is** · 🆕 **whether account sending to Mexal is still off in
UAT**, and what integration log `a05MA00000GqqcPYAR` says · 🆕 **whether
`Referenti Salesforce_V2.xlsx` carries the `codice cliente esterno` join** · 🆕
**whether the Lead list arrives on 29 October as committed** · 🆕 **what shape
the `Lead from Zoho` marker takes, and whether the client is told** · 🆕
**whether the OLD edizione links get deleted or deactivated, and what "link"
means** · 🆕 **who absorbs the ten-plus man-days the migration has cost** · 🆕
**whether Mexal's accounting-year archive behaves as the code assumes** — never
put to Kreosoft · **whether the production file will arrive with the `610.00001`
transformation already applied**, and whether ROMI's fallback is disabled if so ·
**the WooCommerce production endpoints** — a meeting now exists for 30/10 ·
**whether the retired agent codes are in the delivered list** · **what the
Categoria Prodotto description inconsistencies are** · **whether the product
synchronisation flows are actually on** · **what _"template completamente
personalizzabili"_ means** · **Rexhina Hysi's leaving date, her replacement, and
who inherits `Devmain_LeadChecks` and `Devmain_QuoteTriggerChanges`** · **who
Claudio is**, and **which Andrea** the Fase 2 estimate went to · **how many
commitments sit in the Zoho tutor calendars, and who re-enters them** · what
Mexal actually does with a `sconto` on a quantity-above-one line — the one
measurement that settles OI-287 · the Mexal discount field name, pasted into a
meeting chat and captured nowhere · whether `Asset.QR_Id__c` exists in Prod ·
how many Azienda accounts have a blank `Agente__c` · whether Sabatino Rinaldi's
own mail of 27/10 will ever reach this mailbox · what happens to the data-model
fields Zoho cannot fill · whether Lead consent fields survive the migration ·
whether Gianpaolo Motta's Fase 2 ruling will be said to the client · whether the
client accepts the Change Request regime (**fifth day of silence**) · which
profile the UAT user `005MA00000Gh60y` holds · where the `rinunciato` asset write
lives · which of the three dummy-edizione mechanisms is the one · who reverses
the whole-catalogue activation, and when · how many credit notes leave the 2024
history · the contents of the picklist workbook · whether the ~80 live
Performance Plus contracts are migrated, hand-entered or abandoned · whether the
client's lawyer permits the legal-representative fields · the client's ticket
field/value structure (undertaken 21/10, **seven days**) · what `Pienissimo 360`
is · whether Pienissimo hold a Zoho contract past 31 October (**tenth run, three
days out**) · which four `Dettaglio Motivazione Uscita` values OI-259 means ·
whether a contract-expiry alert rule exists in the org (OI-272) · which
production user is to be copied for the marketing tests · what _"utente metà
bloccato"_ means for WhatsApp · whether a test order created in production
reaches live Mexal · whether Sabatino Rinaldi's user exists · what Fabrizio
Mastracci's _"nuova change request"_ referred to · the 30/07 marketing notes
`1uJCE4NW9nbdI38ADmt66svUT1MRmkyYd24uI0hegAD0` · Zoom tier · training hours · who
owns tutor training now · the Woo instance · DocuSign prod config ·
`Get Campaign` and the campaign-ID gap · Jira `PIEN` · `Flows & Objects.drawio` ·
the _diretta_ form.
