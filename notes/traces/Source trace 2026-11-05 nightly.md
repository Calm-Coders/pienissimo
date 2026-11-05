---
id: trace-2026-11-05-nightly
type: reference
status: active
updated: 2026-11-05
watermark_used: 2026-11-04T22:00Z
external_watermark: 2026-11-05T22:00Z
account: a.mrruku@romicompany.com
---

# Source trace 2026-11-05 nightly

**Watermark for the next `requirements-check` run: 2026-11-05T22:00Z, single
value.**

**Watermark used: 2026-11-04T22:00Z**, the `external_watermark` stated by
[the 04/11 nightly trace](Source%20trace%202026-11-04%20nightly.md), selected by
`updated:` frontmatter. Scheduled nightly run, executed 2026-11-05 ~22:00Z. **One
day.**

🔑 **The headline: the migration answered the client in numbers and then shut him out
of the org — and the client's own claim about the Referenti file turns out to be the
Zoho id, which nobody has told him.**

🟢 **Environment note.** The clone opened on `main` (two commits, config only) with
none of the knowledge layer in the working tree; `DevMain` did not exist locally and
was created from the fetched remote branch. **Thirty runs, same opening pattern.**
The working tree was **clean** at start, so the day's three development sessions in
`JOURNAL.md` were already committed, `DevMain` at `16bf017`.

## Sources searched

| Source | Query / scope | Result |
| ------ | ------------- | ------ |
| **Gmail** | `pienissimo after:2026/11/04 -in:draft`, 50 requested, 11 estimated | **Nine threads moved in the window.** All bodies read in full |
| **Gmail** | `after:2026/11/04 (from/to/cc:pienissimo.com OR "ROMI-PIENISSIMO" OR from:kreosoft.it OR anticipay OR mexal OR docusign)`, 40 requested | **9 threads, all already in the first result set.** No additional source. 🔴 **Nothing from Kreosoft, Anticipay or DocuSign** |
| **Gmail** | `get_message 1a1aadbab1e35bdc` (PLAIN_TEXT) | 🆕🔴 **Salesforce Apex exception, 08:38:04Z, organisation `00Dbl000005BSMH` — Prod.** `LeadConversionTrigger` `AfterUpdate`, `System.DmlException … inaccessible on Sobject Opportunity`, `copyConvertedFields: line 95` → [OI-337](../items/OI-337%20Lead%20conversion%20throws%20in%20production%20when%20the%20Opportunity%20fields%20are%20inaccessible.md) |
| **Gmail** | `get_thread 1a1aa9c8b2f14291` (PLAIN_TEXT) | 🆕 **`Anagrafica Prodotti - Tipo Biglietto`**, Fabrizio Paganelli 07:29:07Z — _"in produzione, quel campo non lo posso modificare. Potete verificare?"_ → [OI-338](../items/OI-338%20The%20product%20Tipo%20Biglietto%20field%20cannot%20be%20edited%20in%20production.md) |
| **Gmail** | `get_message 1a1acc23b1b6e80b` (`Re: Referenti`, thread now 5 messages) | 🔑 **Elena Spini 17:29:21Z to Sabatino Rinaldi and Matteo Distaso**, quoting Aurel Mrruku's 18:18 CET breakdown: **17.652 / 49.788 / 107** → [OI-290](../items/OI-290%20Lead%20and%20Referenti%20migration%20data%20is%20owed%20by%20the%20client.md) |
| **Gmail** | `get_message 1a1ac9aaf31e501d` (`Re: Lista Locali`, SENT) | 🟢 **`Locali non inseriti in Salesforce.xlsx`** mailed 16:46:20Z _"con la loro mottivazione nella prima colona"_ → [OI-333](../items/OI-333%20Locali%20without%20a%20Mexal%20customer%20code%20will%20not%20be%20loaded.md). ⚠ Not opened |
| **Gmail** | `get_message 1a1acea8a4ffcff0` (`Re: Trasferimento dati`, thread now 13) | 🟢🔑 **Six UAT tutor users active**, Elena Spini 18:13:22Z, 24-hour password link, **mandatory MFA/passkey**, `Guida Gestione Passkey` shared; Marco Montesi had chosen at 09:04 CET, _"direi di attivare adesso le utenze"_ → [OI-300](../items/OI-300%20Tutor%20training%20and%20tutor%20test%20access%20are%20unplanned.md) |
| **Gmail** | `get_message 1a1abcbbb0e2bd66` (`Re: Tema Contratti Post-Vendita Da Palco`) | 🔴 **Elena Spini chasing, 13:00:05Z**: _"nel documento ci sono OP con scadenza oggi ancora da chiarire"_ → [the R0 analysis](../The%20stage%20sale%20contract%20functional%20analysis.md) |
| **Gmail** | threads `1a1acbb192f4f8ba`, `1a1acbab3267bdb0` (summary view) | 🆕 **Two Monday 9/11 Fase 2 review invitations**, 17:21Z: internal `[PIENISSIMO] - INTERNA` 10:00-10:30 and `[ROMI-PIENISSIMO]` with the client 10:30-11:30 |
| **Gmail** | `1a1a736daaf9d282` (`Re: Anagrafica Account`, SENT 16:07:48Z) | 🟢 Aurel Mrruku acknowledges the account file: _"Procedo con le verifiche del file excel relativo a Salesforce"_ |
| **Gmail** | threads `1a1a7657bebf46a5`, `1a1a727f15cda188` | **Already held** — the 04/11 orders attachment and the Gemini notes notification, both drilled by the 04/11 run. Not re-ingested |
| **Slack** | `slack_read_channel C0B5T3RB4FM` (`#tproj-pienissimo`), `oldest` 1793829600 | **0 messages.** 🔴 **Silent a fourth consecutive sweep** |
| **Slack** | `slack_read_channel C0BQD34LLF4` (dev group), same bound | **7 messages.** 🟢 Aurel Mrruku 16:25 CET — what the metadata check left out of Prod and why (app page assignments, the Product Edit button, two list views, the Locale layout lookup, hidden list buttons, the Agente profile) · 14:05-14:24 the Albanian-language Prod permission exchange with Rexhina Hysi and Anita Aga, _"done"_ at 14:24 → [OI-338](../items/OI-338%20The%20product%20Tipo%20Biglietto%20field%20cannot%20be%20edited%20in%20production.md) · plus this session's own 04/11 report, 🔴 **unanswered** |
| **Slack** | `slack_read_thread C0BQD34LLF4 1793883945.923009` | 3 replies: _"Agente? Profile"_ → _"ishte te produkti nje type"_ → Anita Aga tagged |
| **Slack** | `slack_read_channel D0B5QHS2T7H` (Elena Spini DM), same bound, **2 pages** | **~60 messages, two threads read.** 🔴🔑 The Prod lockout 15:54-16:33 → [OI-339](../items/OI-339%20The%20client%20was%20locked%20out%20of%20production%20during%20the%20migration%20load.md) · 🔴 `LICENSE_LIMIT_EXCEEDED` 18:57 → [OI-341](../items/OI-341%20The%20UAT%20org%20ran%20out%20of%20Salesforce%20licences.md) · 🔑 _"no quello e id zohe"_ 14:07 → OI-290 · 🆕 _"da creare su lead il campo 'interessato a'"_ 18:01 · 🟡 _"t ah risposto per il deploy del 18?"_ → _"domani mattina manda l OK"_ · `Referenti Salesforce_V2` re-surfaced 16:32 with _"vanno importati solo quelli con codice mexal popolato"_ · ⚠ a `[ROMI-LIFE365]` Giro Lead meeting link — **different client, ignored** |
| **Slack** | `slack_read_channel C0C38JJ9D1T` (marketing group DM), same bound | **~30 messages, two threads read.** 🟡🔑 The OI-313 retest and the third diagnosis 09:15-11:59 · 🆕🔴 the two website forms and the missing consent field 17:26 → [OI-340](../items/OI-340%20The%20website%20lead%20forms%20have%20no%20field%20for%20the%20marketing%20consent.md) · 🔑 the consent flow deactivated for the load 17:55-17:59 → [the flow note](../flows/The%20Update%20Contact%20Consent%20flow%20in%20production.md) |
| **Slack** | `slack_read_canvas F0BD2H5A9HT` (`Link utili Pienissimo`) | **Unchanged.** Newest entry still 20.08.2026 — **77 days**. Re-read per the skill |
| **Drive** | `modifiedTime > '2026-11-04T22:00:00Z' and trashed = false`, 22 files | 🆕 **`Pienissimo Offerta Fase 2_V.2`** (11:52Z, Elena Spini) and **V1 touched 11:51Z** → [OI-342](../items/OI-342%20The%20Fase%202%20offer%20V2%20reorders%20the%20releases%20and%20contradicts%20itself.md) · 🔑 **`Referenti Salesforce_V2.xlsx` modified 15:28:44Z** · the rest are **other clients or ROMI-internal** — two `[ROMI-LIFE365]` meeting folders with recording and transcript, `SALESFORCE recap points to fix` (`tiziana.petruzzi@247.it`), `d.losco@` Vision CSV/SQL files, `VFL1_Salesforce_Data_Dictionary_v5`, a shared-drive price list — **ignored per the skill, not counted as missing sources** |
| **Drive** | `title contains 'PIENISSIMO' and createdTime > '2026-11-04T22:00:00Z'` | **1 file: the offer V.2.** 🟢🔴 **No meeting folder, no recording and no transcript was created for the 12:00-12:30 Fase 2 recap call** |
| **Drive** | `read_file_content 1_ilgbQZf…` (offer V.2) | 🔴 **Three release orderings in one deck** plus two superseded `RILASCIO X` slides; no figures transcribed beyond the terms already held |
| **Drive** | `get_file_metadata 1tHPebvZvnPh0DwDSbmxtEpgOkfY_XDs-` | `Referenti Salesforce_V2.xlsx`, owner `fabrizio.pienissimo@gmail.com`, created 28/10 15:30Z, **modified 05/11 15:28Z**, viewed by the account holder 15:42Z. ⚠ **Not opened** — real customer records |
| **Drive** | `get_file_metadata 121CTGF0mCkL…` | `Campi Oggetti, Flussi e Utenti Salesforce - Pienissimo.xlsx` **unchanged since 26/10 13:27Z**, viewed today 10:19Z — confirms OI-340's reading of it is current |
| **Drive** | `get_file_metadata 1A-sYQEZvbp2ShVbVL1XQPkPottBQKCuI` | The R0 functional analysis **unchanged since 03/11 17:58Z** — nothing was edited into it. ⚠ Drive comments would not move that timestamp and none is reported in mail or chat |
| **Fathom** | `list_meetings created_after 2026-11-04T22:00Z`, 3 pages | **0 meetings.** 🔴 **Nothing, a thirty-third consecutive run** |
| **Git** | `fetch origin`, `checkout DevMain`, `pull`, `status` | `DevMain` at **`16bf017`** (_"deploy in prod"_); working tree **clean**. 🔴 No branch carries OI-329 or OI-330 work; `Devmain_LeadChecks` still unmerged |
| **Repo** | `ls notes/items` max-id scan | Max existing id **336**, so this run allocated **337**–**342**; next free is **343** |
| **Repo** | `LeadConversionTriggerHandler.cls` lines 55-100, `objects/{Lead,Account}/fields` | 🔑 Line 95 is `update opportunitiesToUpdate.values()`, writing seven fields; `Consenso_Profilazione__c` and `Informativa_Privacy__c` **exist on both objects** |

## Found

1. 🟢🔑 **Both migration exception lists went back to the client with a reason per
   row** — Locali 16:46Z, Referenti 18:18 CET — and the Referenti breakdown is exact
   for the first time: **17,652 inserted, 49,788 with no Mexal code, 🆕 107 whose
   code matches no Azienda in Prod**. ⚠ Neither attachment was opened.

2. 🔑 **The client's `"Potete verificare?"` has an answer and he has not been given
   it.** The identifier in `Referenti Salesforce_V2.xlsx` is the **Zoho id**, not the
   Mexal code — _"no quello e id zohe"_. 🆕 Elena Spini turned the remainder into a
   stated blocker on the final import and put it to **Sabatino Rinaldi and Matteo
   Distaso**.

3. 🔴🔑 **[OI-339](../items/OI-339%20The%20client%20was%20locked%20out%20of%20production%20during%20the%20migration%20load.md)
   — Fabrizio Paganelli is blocked out of Prod until Monday 9 November**, told by
   telephone, in no mail, while the data ROMI needs from him is due 6 November.

4. 🔴 **[OI-337](../items/OI-337%20Lead%20conversion%20throws%20in%20production%20when%20the%20Opportunity%20fields%20are%20inaccessible.md)
   — lead conversion threw in production at 08:38Z**, the same unguarded-DML pattern
   as OI-286, whose fix has been unmerged for thirteen days.

5. 🟡🔑 **[OI-313](../items/OI-313%20The%20ticket%20nomination%20email%20fired%20for%20assets%20still%20in%20ordinato.md)
   reversed direction.** A Prod entry rule was changed from a status URL field to
   `status__c`, the retest passes, and a third diagnosis appeared — _"non hanno fatto
   i test"_ — **unreconciled with the 04/11 reproduction**. 🔴 The client has been
   told nothing for three days.

6. 🆕🔴 **[OI-340](../items/OI-340%20The%20website%20lead%20forms%20have%20no%20field%20for%20the%20marketing%20consent.md)
   — two live public forms discard the marketing consent.** 🟢 The fields exist in
   source; the **mapping** is undecided, and two contradictory ROMI answers on
   `Interessato a` were given in the same hour.

7. 🟢🔑 **[OI-300](../items/OI-300%20Tutor%20training%20and%20tutor%20test%20access%20are%20unplanned.md)
   is answered: the six tutor users exist, before the training, in UAT**, with a
   24-hour link and mandatory MFA. 🔴 No production users, and
   **[OI-341](../items/OI-341%20The%20UAT%20org%20ran%20out%20of%20Salesforce%20licences.md)**:
   the org was out of licences and others were deactivated to fit them in, with no
   list kept.

8. 🔴 **[OI-342](../items/OI-342%20The%20Fase%202%20offer%20V2%20reorders%20the%20releases%20and%20contradicts%20itself.md)
   — a V.2 of the Fase 2 offer, created five minutes before the recap call, states
   three release orderings.** The Ri.Ba. and insoluti work is the content that moved,
   and OI-331 is in neither document. Approval due 13/11.

9. 🔴 **R0's four open points fell due today and none was answered** — Elena Spini
   had to chase. ⚠ **The recap call left no record of any kind.** 🟡 A verbal OK on
   _"il deploy del 18"_ is promised for the morning of 6 November.

10. 🆕 **[OI-338](../items/OI-338%20The%20product%20Tipo%20Biglietto%20field%20cannot%20be%20edited%20in%20production.md)
    — the client cannot edit `Tipo Biglietto` in Prod**, and the record contradicts
    itself on whether the fix landed: _"done"_ at 14:24, still being asked for at
    15:44.

11. 🔑 **[The consent flow was deactivated for the bulk load with its owner's
    agreement](../flows/The%20Update%20Contact%20Consent%20flow%20in%20production.md)** and
    restored as v2 with both configuration concerns unchanged. It is now the only
    thing creating marketing consent for a new contact, which is what makes OI-340
    sharper.

## Not done, and why

- **The org was not opened.** Every production statement here comes from a mail, a
  Slack message, the source tree or an earlier journal entry, not from an inspection
  in this session. `STATUS.md` and its Notion mirror are **stale**; the sweep moved
  the live position and step 6 of `org-status-check` was **not** run.
- **No Apex test class was written or proposed.** Standing instruction.
  [OI-64](../items/OI-64%20The%20bundle%20Apex%20test%20suite%20is%20broken.md),
  [OI-66](../items/OI-66%20No%20test%20classes%20for%20the%20Biglietto%20stack.md) and
  [the deploy risk](../risks/Risk%20-%20production%20deploy%20is%20blocked%20by%20Apex%20coverage.md)
  are unchanged and were not acted on.
- **No workbook holding customer data was opened** — `Referenti Salesforce_V2.xlsx`,
  `Locali non inseriti in Salesforce.xlsx`, `Import Ordini (versione del
  2026.11.04).xlsx`, `Account Salesforce (rev Agente).xlsx`,
  `Import_Utenti_Salesforce_UAT.xlsx`, the Lead files and the picklist workbook.
  Existence and modification times recorded, no values copied.
- **No figures were transcribed from the offer V.2** beyond the commercial terms the
  record already held.
- **The requirement register was not touched** — stays **v1.6**. Nothing in this
  window changed an agreed requirement; the OI-329 tranche obligation remains the
  **v1.7 candidate**.
- **`lead-web-to-lead (2).html`** is **still unopened and still unexplained**; the
  03/11 and 04/11 reports both asked Rexhina Hysi and she has not replied. ⚠ OI-340
  may be its subject; **not established**.
- **Order `00016059` is still not resent** — the only end-to-end proof of
  [OI-287](../items/OI-287%20The%20Mexal%20line%20discount%20is%20sent%20as%20a%20line%20total%20instead%20of%20per%20unit.md).
- **`prettier:verify` was not run** (not executable in this environment, as on
  previous runs).

## Still unreachable

Named precisely enough to ask someone for them:

- **How Pienissimo wants the 49,788 uncoded and 107 unmatched Referenti handled** —
  now a stated blocker on the final import
  ([OI-290](../items/OI-290%20Lead%20and%20Referenti%20migration%20data%20is%20owed%20by%20the%20client.md)).
- **What changed in `Referenti Salesforce_V2.xlsx` on 5 November**, and when the
  promised refresh _"la settimana prossima con Sabatino"_ actually lands.
- **Whether `profilazione` is the marketing consent**, and which field the website
  forms should write ([OI-340](../items/OI-340%20The%20website%20lead%20forms%20have%20no%20field%20for%20the%20marketing%20consent.md)).
- **Which field and which profile broke lead conversion in Prod**, and who owns the
  fix ([OI-337](../items/OI-337%20Lead%20conversion%20throws%20in%20production%20when%20the%20Opportunity%20fields%20are%20inaccessible.md)).
- **Whether Fabrizio Paganelli can now edit `Tipo Biglietto`**, and what was changed
  in Prod to allow it ([OI-338](../items/OI-338%20The%20product%20Tipo%20Biglietto%20field%20cannot%20be%20edited%20in%20production.md)).
- **How many Salesforce licences production has**, and which UAT users were
  deactivated ([OI-341](../items/OI-341%20The%20UAT%20org%20ran%20out%20of%20Salesforce%20licences.md)).
- **Which ordering of Fase 2's releases is real**, and whether OI-331 is inside the
  priced scope ([OI-342](../items/OI-342%20The%20Fase%202%20offer%20V2%20reorders%20the%20releases%20and%20contradicts%20itself.md)).
- **What was agreed on the 12:00-12:30 Fase 2 recap call** — it left no artifact —
  and **which release _"il deploy del 18"_ is**.
- **Whether the Mexal API calls switched off for the load were switched back on**
  ([OI-339](../items/OI-339%20The%20client%20was%20locked%20out%20of%20production%20during%20the%20migration%20load.md)).
- **The chosen Mexal sync frequency**, and who schedules the jobs in Prod
  ([OI-334](../items/OI-334%20The%20Mexal%20sync%20frequency%20is%20undecided%20and%20no%20job%20is%20scheduled%20in%20production.md),
  [OI-301](../items/OI-301%20Three%20production%20manual%20setup%20steps%20are%20outstanding.md)).
- **When Andrea fixes the production Anticipay endpoint**, and which domain the
  client owes ([OI-312](../items/OI-312%20Anticipay%20times%20out%20in%20production.md),
  [OI-323](../items/OI-323%20The%20production%20domain%20has%20not%20been%20supplied%20by%20the%20client.md))
  — **unmentioned by any source today**.
- **The seven-agent code list**
  ([OI-332](../items/OI-332%20The%20account%20import%20keys%20on%20the%20Salesforce%20agent%20code%20and%20the%20client%20file%20is%20mis-coded.md)).
- **How many signature fields the quote PDF should carry, and what `allegato B` is**
  ([OI-336](../items/OI-336%20The%20quote%20PDF%20allegato%20B%20has%20no%20signature%20field.md)).
- **Who owns the invoice numerator change**, and by when.
- **Where the Pienissimo 360 insoluti figure comes from**
  ([OI-335](../items/OI-335%20A%20Pienissimo%20360%20test%20page%20showed%20management%20280000%20euro%20of%20insoluti.md)).
- **How the production test orders can be deleted**
  ([OI-315](../items/OI-315%20Production%20test%20records%20cannot%20be%20deleted.md)), and
  when the full order sync will run
  ([OI-321](../items/OI-321%20The%20full%20order%20synchronisation%20to%20Mexal%20has%20not%20been%20run.md)).
- **Whether Pienissimo holds a Zoho contract past 31 October** — **fifteenth run**,
  five days after the expiry date, and no source has mentioned it.
- **The twelve `PLUS_B` values** (fourth day) and the picklist workbook
  (fourteenth day,
  [OI-265](../items/OI-265%20Opportunity%20Categoria%20and%20Sottocategoria%20values%20do%20not%20match%20the%20client%20registry.md)
  unmoved).
- **What `lead-web-to-lead (2).html` is**, and the standing 30/07 marketing
  follow-up notes.

## Written back

- **6 new item notes**: OI-337 → OI-342.
- **8 notes updated** (`updated:` bumped): OI-290, OI-300, OI-310, OI-313, OI-333,
  [The Fase 2 offer](../The%20Fase%202%20offer.md),
  [The stage sale contract functional analysis](../The%20stage%20sale%20contract%20functional%20analysis.md),
  [The Update Contact Consent flow in production](../flows/The%20Update%20Contact%20Consent%20flow%20in%20production.md).
- **MAP.md** — new nightly entry at the top, `Last updated` chain extended.
- **INDEX.md** — six item rows.
- **`meetings/open-items.md` and `.it.md`** — 6 new rows each (#337-#342) and
  **5 regenerated rows** each (#290, #300, #310, #313, #333).
- **`meetings/DEVELOPMENT-RECAP.md` and `.it.md`** — new **§78** in both.
- **This trace**, and a `JOURNAL.md` entry.
- **Register untouched — v1.6.**
- **No person note was needed**: Matteo Distaso is already in `notes/people/`.
