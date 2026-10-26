---
id: trace-2026-10-07-nightly
type: reference
status: active
updated: 2026-10-07
watermark_used: 2026-10-06T22:00Z
external_watermark: 2026-10-07T22:00Z
account: a.mrruku@romicompany.com
---

# Source trace 2026-10-07 nightly

**Watermark for the next `requirements-check` run: 2026-10-07T22:00Z, single
value.**

**Watermark used: 2026-10-06T22:00Z**, the `external_watermark` stated by
[the 06/10 nightly trace](Source%20trace%202026-10-06%20nightly.md), selected by
`updated:` frontmatter. Scheduled nightly run, executed 2026-10-07 ~21:50Z.
**One day.**

🔑 **Two client sessions — the order path completed end to end for the first
time, and the second session made the payment code wrong as committed.**

🟢 **Environment note.** The clone opened on `main` (two commits, config only);
`DevMain` did not exist locally and was created with
`git fetch origin && git checkout -B DevMain origin/DevMain`. **Nine runs, same
opening pattern.**

## Sources searched

| Source | Query / scope | Result |
| ------ | ------------- | ------ |
| **Fathom** | `list_meetings created_after 2026-10-06T22:00Z`, summaries + action items, 3 pages | **1 meeting, and it is another client** — `SALESFORCE production status` for **247** (Luca Savi, Mehak Luthra, Tiziana Petruzzi, `vittoria.zoli@247.it`). Ignored per the skill. **0 Pienissimo meetings — twelfth consecutive run.** Both of today's sessions exist only as Google Meet artifacts |
| **Gmail** | `pienissimo after:2026/10/06 -in:draft`, 40 requested, 17 estimated | 🔑 **two Gemini-notes mails** (WooCommerce/Mexal 10:28:31Z, Temi Mexal 11:27:39Z) · 🔑 **Rexhina Hysi's UAT QR API mail** 12:35:28Z · 🔑 **Elena Spini's reply to Marco Montesi** 14:57:40Z · 🟢 Elena Spini to Elisa Migliano on the UAT user 12:34:50Z · 🟢 **the 12/10 e2e invitation** 12:27:17Z · the recurring internal follow-up moved to Tue 13/10 |
| **Gmail** | `get_thread` on `1a115e85dc78b560`, `1a1161e8261fbb4e`, `1a1165cc5db2fe00` (PLAIN_TEXT, full bodies) | 🔑 both sessions' summaries and next steps in full · 🔑 **the whole QR check-in contract**, including ⚠ **a live signed JWT assertion and the integration username — recorded, not copied** |
| **Gmail** | `get_thread` on `1a0fce6a8bb04fdb` (Blueprint, 5 messages, full bodies) | 🔑 **Elena Spini answered Marco Montesi's three precisazioni** — 1 declined to a later phase, 2 answered (admin-editable), 🔴 **3 bounced back** _"Non ho capito cosa intendi"_ |
| **Drive** | `modifiedTime > '2026-10-06T22:00:00Z'`, **2 pages, 16 files** | 🔑 both session folders, Gemini-notes docs and the 1.18 GB recording · ⚠ the rest are **other clients** (247's recap sheet, IUAD/Eduarth, ROMI-internal) and ROMI-internal sheets — ignored per the skill |
| **Drive** | `search_files title contains 'Temi Integrazione Mexal' or 'Integrazione WooCommerce e Mexal'` | both 07/10 docs located, plus the 26/08 Mexal review folder |
| **Drive** | `read_file_content` on `1ud8rHoyY9D-5YvHDw3BCiHtGNoakbhwFjOZU643x0vY` | 🔑 **the Mexal call read in full** — `Riepilogo`, **four `Concordato`**, eight `Passaggi successivi`, all `Dettagli`, **and the verbatim transcript searched** for the e-invoicing code, the country code and the sync direction. 67,393 characters |
| **Drive** | `read_file_content` on `1qsWO7dkpFEcOW8-k4R2WvMY4bYSeorCioqYnYQCGtZo` | 🔑 **the WooCommerce UAT's structured sections read in full** — `Riepilogo`, **five `Concordato`** + one `Da approfondire`, nineteen `Passaggi successivi`, all `Dettagli` and six numbered topics. 149,711 characters; the verbatim transcript after `Dettagli` was **not** read |
| **Slack** | `slack_read_channel C0BQD34LLF4` (dev group), from 06/10 22:00Z | **1 message — this procedure's own 06/10 report.** 🔴 **No human reply to any nightly report: nineteen nights** |
| **Slack** | `slack_read_channel C0B5T3RB4FM` (`#tproj-pienissimo`), from 06/10 22:00Z | **0 messages.** A fifth consecutive day of silence on the project channel |
| **Slack** | `slack_read_channel C0C38JJ9D1T` (the marketing group DM), from 06/10 22:00Z | **0 messages.** Silent for the first time since it was found — the funnel questions put to Rebecca Marmo are unanswered there |
| **Git** | `fetch origin --prune`, `log --all --since 2026-10-06T22:00:00Z` | **3 commits** plus this procedure's own `5ef67a5`; `DevMain` advanced `59d4264` → **`391b401`** (Aurel Mrruku, _"Preparazione UAT invio ordine"_) |
| **Git** | `merge-base --is-ancestor` and `branch -r --contains` on all three | 🟢 `391b401` **in `DevMain`** · 🔴 `b08c9a8` (Rexhina Hysi, QR endpoint) only on `Devmain_EndpointWorktoUpdateAsset` · 🔴 `577fc5c` (Anita Aga, anticipay country) only on `DevAnita07` |
| **Repo** | `MexalScadenzarioSearchService.cls:185-230`; `Scadenza_Fattura__c/fields/Pagata__c`, `Stato_Scadenza__c`; `Tranche__c/fields/Stato_Scadenza__c`; `git show --stat` on all three commits; the `AnticipayAccountService.cls` diff; `notes/Ticket QR lookup endpoint usage.md` on `DevMain` | 🔴🔑 **both payment paths test `P \|\| E` with no date condition** — the defect of OI-212 · 🟢 `Stato_Scadenza__c` does test `TODAY()`, but `Pagata__c` wins first · 🔴 the QR note on `DevMain` still describes the **CampaignMember** contract the mail supersedes · ⚠ `577fc5c` hardcodes `BillingCountry = 'IT'` |

## Found

1. 🟢🔑 **[The 07/10 WooCommerce/Mexal UAT](../meetings/2026-10-07%20UAT%20Integrazione%20WooCommerce%20e%20Mexal.md)**
   (10:00 CEST, ~2h18m, three client-side) — **five `Concordato`**, one
   `Da approfondire`, nineteen next steps. **The whole order chain completed**,
   and a **real collection registered in Mexal moved the Salesforce order to
   paid on its own** — the first live verification of OI-206 / OI-208.
2. 🟢🔑 **[The 07/10 Kreosoft call](../meetings/2026-10-07%20Temi%20Integrazione%20Mexal.md)**
   (12:16 CEST, ~48m, with Mirko Merendi) — **four `Concordato`**, eight next
   steps. The call OI-211 was due at.
3. 🔴🔑 **New: [OI-212](../items/OI-212%20A%20Ri.Ba.%20rate%20reads%20as%20paid%20before%20its%20due%20date.md),
   gating.** `E` counts as paid **only if the due date has passed**;
   `MexalScadenzarioSearchService.cls:205-207` and `Scadenza_Fattura__c.Pagata__c`
   test `P || E` unconditionally, so a Ri.Ba. presented on the 20th reads
   `Pagata` before the money lands — the premature ticket release Fabrizio
   Paganelli named. **Qualifies OI-201, does not reopen it.**
4. 🔴 **New: [OI-213](../items/OI-213%20Mexal%20order%20lines%20arrive%20suspended%20and%20cannot%20be%20invoiced.md),
   gating** — lines arrive `S` and block invoicing; Mirko Merendi named
   `Tipo_B_Stato_Bigga` (⚠ from speech) and owes the wider customisation.
5. 🔴 **New: [OI-214](../items/OI-214%20The%20Mexal%20order%20send%20requires%20an%20agent%20code%20WooCommerce%20orders%20lack.md),
   gating** — the agent code is mandatory, ~20% of shop orders have none, no
   default, and the error is invisible on the order screen.
6. 🔴 **New: [OI-215](../items/OI-215%20Anticipay%20does%20not%20cover%20San%20Marino%20addresses.md)**
   — Anticipay is Italy-only; the room preferred Italy while the Mexal call had
   corrections going the other way.
7. 🔴 **New: [OI-216](../items/OI-216%20The%20WooCommerce%20plugin%20flushed%20its%20unsent%20order%20backlog%20into%20Salesforce.md)**
   — the plugin flushed every unsent order, real customers included. 🟢 **Answers
   Aurel Mrruku's 06/10 10:34:40Z question: not client tests.**
8. 🔴 **New: [OI-217](../items/OI-217%20The%20article%20code%20revision%20needs%20direction%20approval.md)**
   — a bundle code the shop sells is absent from Mexal; ~20–30 codes to revise,
   blocked on direction.
9. 🔴 **New: [OI-218](../items/OI-218%20Direction%20has%20not%20seen%20the%20Business%20Blueprint%20before%20the%2013%20October%20confirmation.md),
   gating** — direction has not read the Blueprint, against a **13/10**
   production confirmation. Fabrizio Paganelli doubted the timeline on that
   ground.
10. 🔴 **New: [OI-219](../items/OI-219%20Default%20payment%20method%20and%20agent%20for%20WooCommerce%20and%20Palco%20orders.md)**
    — payment codes mapped (`2`, `12`, also `20` and `64`), but the bundle
    default is deferred and Palco has none.
11. 🟢🔑 **[OI-209](../items/OI-209%20Mexal%20anagrafica%20updates%20only%20propagate%20when%20an%20order%20is%20sent.md)
    has vendor assent and four named fields** — billing address, partita IVA,
    fiscal residence, agents — with Fabrizio Paganelli and Elena Spini owning the
    field list. ⚠ The Gemini summary reads as a sync reversal; **the transcript
    shows it is not.** 🔴 Nothing built.
12. 🟡 **[OI-211](../items/OI-211%20Mexal%20rejects%20N%20for%20the%20electronic%20invoicing%20code.md)
    moved, not closed** — `N` confirmed rejected, `P` adopted, ⚠ **four values in
    one conversation** (`N`, `P`, `S`, `M`) and no transcoding table.
13. 🟢 **Marco Montesi was answered**, 14:57:40Z, two days on. ⚠ Mass Opportunity
    creation declined to _"una fase successiva"_ — **a Fase 2 candidate created in
    mail with no Fase 2 row**. 🔴 **Question 3 bounced back** though the record
    held the answer from 05/10.
14. 🔑 **The release calendar is explicit**: 12/10 16:00–18:00 e2e · 13/10
    production confirmation · 16/10 marketing in Prod · 21/10 go-live. ⚠ **The
    Gemini notes date all of it in August**; October is confirmed by Elena Spini's
    own calendar invitation.
15. 🔑 **The QR check-in contract arrived by mail** — **the payload is the Asset
    id, not the `CampaignMember.Id`** the merged note describes;
    `CAMPAIGN_MEMBER_NOT_FOUND` is gone; repeated scans keep the original
    timestamp; the dedicated integration user's access is enumerated. ⚠ **A live
    JWT and the integration username were circulated by mail** — recorded, never
    copied. ⚠ The 5-day check-in window of 06/10 is **not** in the contract.
16. ⚠ **Of record:** San Marino e-invoicing is optional until year end and
    **mandatory from the new year**; UAT credentials go to **two people only**;
    commission categories sit on the customer registry, not the Mexal order;
    showcase events admit unknown registry data and fictitious partite IVA;
    Elena Spini owes a **training calendar**; a **dedicated notification mailbox**
    is owed to Aurel Mrruku.

## The register

**Amended? No. Version stays 1.6.**

The day's nine rulings are **integration and operational rulings** — which ERP
code a payment method maps to, when a line state is set, which system owns a
registry field, when a rate counts as paid.

🟢 **The date-qualified payment rule is the one with contractual reach**, because
it governs when a ticket becomes available — which `REQUISITI.it.md` does speak
to through the availability chain. It joins the v1.6 candidates rather than
forcing an amendment tonight, because the carrier is still blocked: ⚠ **the
amended logic document's written confirmation has been requested and not
received**, and
[OI-184](../items/OI-184%20Register%20v1.6%20goes%20to%20the%20client%20as%20one%20change%20set%20at%20UAT%20close.md)
cannot use an unconfirmed text.

⚠ **Candidates for v1.6 once confirmed**, carried forward and now joined by one:
the renewal-without-DocuSign path, the two-flag Lead consent model, the 21-value
`Tipologia di attività`, `Partita IVA` mandatory at lead conversion, the
per-edizione link scope, `Rinuncia` per edition — and, new, **`E` counts as paid
only once the due date has passed**.

## Corrections to the record

- **No stale claim was found in the record tonight.** The 06/10 entry's build
  statements still hold at `391b401`.
- ⚠ **One correction to a source, not to the record:** the Gemini notes of both
  sessions date the release milestones in **August**. The October readings are
  used throughout, on the strength of Elena Spini's calendar invitation and
  OI-124. Recorded in the meeting notes, both trackers and both recaps.
- ⚠ **A second source distortion:** the Mexal call's Gemini _next steps_ line
  states the payment rule **without the `E` qualifier**, which would mark an
  unpaid past-due rate as paid. The `Concordato` text governs and is quoted in
  OI-212.
- ⚠ **A third:** the same notes' `Dettagli` compress the registry sync into
  _"l'anagrafica cliente debba originare da Salesforce"_, which reads as a
  reversal of the 06/10 OI-209 design. The verbatim transcript shows it is not;
  both notes say so explicitly.

## Not done in this run

- The org was **not** opened. `STATUS.md` was not regenerated and the Notion
  mirror stays stale. Every build claim is repository arithmetic against
  `DevMain` `391b401`.
- **No Apex test was written, proposed or scaffolded**, per the standing
  instruction. ⚠ Noted only as a fact of the diff: `b08c9a8` edits
  `ParticipantTicketDocumentTest.cls` and `TicketingTest.cls`.
  [OI-64](../items/OI-64%20The%20bundle%20Apex%20test%20suite%20is%20broken.md) and
  [OI-66](../items/OI-66%20No%20test%20classes%20for%20the%20Biglietto%20stack.md)
  were not touched; nothing this sweep saw changed their state.
- **No Apex was changed and no deployment was made.** This procedure writes to
  the knowledge layer.
- **OI-212 was not fixed.** The defect is recorded, with the file, the lines and
  the formula; the correction is a code change and belongs to Aurel Mrruku.
- **OI-207 was not verified in the org** — a third run. The five commercial
  fields against the seven surfaces needs an org inspection.
- The **1.18 GB recording** and the WooCommerce session's **verbatim
  transcript** were not opened; the `Dettagli` are timestamp-linked. The Mexal
  call's transcript **was** searched, not read whole.
- `Integrazioni pienissimo.xlsx`, `Campi Oggetti…xlsx` and the article registry
  **did not move** today and were not re-opened.
- No transcript was copied into `meetings/`; no per-meeting recap in
  `meetings/results/`.
- `npm run prettier:verify` was not run (no `node_modules`), so tonight's
  markdown is unformatted.

## Still unreachable

- 🔴 **`Mappatura_Categorie_Sottocategorie_Origine Lead_Tipologiattività.xlsx`**
  — the four Lead picklists, still a **mail attachment only**, second run. Not in
  Drive; this sweep has no tool that downloads one. **Ask Elisa Migliano or Elena
  Spini to put it in Drive.** Still the shortest path to closing OI-115.
- 🔴 **The `pienissimolive.it` form** — _"non risulta raggiungibile"_, second
  run, nothing new today. **Ask Matteo Distaso.**
- **`Flows & Objects.drawio`** — did not move, a fifth consecutive run. Still an
  `mxfile` the Drive reader cannot parse, and still the only picture of the
  flows. **Ask Elena Spini for a PNG or PDF export.**
- **`Campagne Salesforce.xlsx`** — did not move. Still not opened.
- **`Testbook_UAT_Lead_Opportunita_2026-09-24_v2_1.xlsx`** — **did not move**, a
  sixth consecutive run. Approval due ~13/10, which is now also the production
  confirmation date.
- **The full text of `Pienissimo_Scheda di Partecipazione ai corsi_da firmare.pdf`**
  — not opened; its seven enrolment pages may carry personal data. ⚠ OI-194 is
  still gating and went undiscussed for an eighth day.
- ⚠ **The document Rebecca Marmo shared** with Fabrizio Mastracci. Third run,
  still not identified in Drive, and she was in neither of today's sessions.
- **The WooCommerce logic document** for Daniela Morgese — fourth run, still not
  identified. ⚠ She now receives the **Business Blueprint** instead (OI-218).
- **The 30/07 marketing notes**, standing.
- **The 12:30 CEST internal call of 25/09** — still no artifact, tenth run.
- ⚠ **The Pienissimo lead documentation** Elena Spini said she owed on 28/09.
  Not raised again.
- ⚠ **Sabatino Rinaldi's WhatsApp confirmation** of the card and PayPal test
  orders of 02/10. WhatsApp is not a source this procedure can read — and he now
  owes **fresh** card and PayPal tests from today's session.
- **No DocuSign plan document** behind Sabatino Rinaldi's 2,500-envelope figure.
- **The API field names Mirko Merendi sent Aurel Mrruku in chat** — for the
  article registry, the order lines and the line-state field. Sent over a chat
  this procedure cannot read, and OI-213's exact field spelling depends on them.

**Nothing 404'd this run.** The Gmail id that failed on 06/10
(`1a11140ee386bdd0`) was not re-queried; its thread `1a0f8b6c0021fe9c` resolved
normally.

## Absence of evidence, stated as absence

- **Fathom has returned no Pienissimo meeting for twelve consecutive runs.** It
  returned one meeting tonight, for another client. A pattern about the tooling,
  not about the project.
- **`#tproj-pienissimo` was silent for a fifth day.** No status post from Elena
  Spini since 02/10.
- **The marketing group DM was silent for the first time** since it was found.
  **Rebecca Marmo has still not answered the two funnel questions** — WhatsApp
  parallel or backup, and which event date stops the send.
- **Nineteen consecutive nightly reports with no human reply** in the dev group.
- **No reply to Elena Spini's 12:47:00Z request for written confirmation** of the
  amended logic document, now six days old. OI-200's seven open points are
  unchanged and nothing was found on them in any source.
- **Nothing was found on OI-210** — the `NR_Tranche` / one-article
  contradiction — in any source: not a mail, a message, a commit or a ruling.
  **Third night.** It was not raised in either session, though OI-217's article
  clean-up is adjacent to it.
- **Nothing was found on OI-194**, OI-202, OI-204 or OI-205 in any source.
- **No `RINUNCIA ()` source** was named for Fabrizio Mastracci's dynamic-field
  list, flagged on 06/10.
- ⚠ **"Claudio" is still unresolved**, credited by Elena Spini for the problems
  table. **No person note was created and nothing was attributed.**
- **Which agent code to use for an agentless WooCommerce order is unanswered** —
  Elisa Migliano must ask Marco Montesi, and had not at this watermark.
