---
id: trace-2026-10-08-nightly
type: reference
status: active
updated: 2026-10-08
watermark_used: 2026-10-07T22:00Z
external_watermark: 2026-10-08T22:00Z
account: a.mrruku@romicompany.com
---

# Source trace 2026-10-08 nightly

**Watermark for the next `requirements-check` run: 2026-10-08T22:00Z, single
value.**

**Watermark used: 2026-10-07T22:00Z**, the `external_watermark` stated by
[the 07/10 nightly trace](Source%20trace%202026-10-07%20nightly.md), selected by
`updated:` frontmatter. Scheduled nightly run, executed 2026-10-08 ~21:50Z.
**One day.**

🔑 **No client session, one ROMI-internal session, and 22 commits — the heaviest
build day of the project. The Business Blueprint went to signature and the
client reopened two of its precisazioni twenty-nine minutes earlier.**

🟢 **Environment note.** The clone opened **detached at `refs/heads/main`**
(two commits, config only) and the working tree held none of the knowledge
layer; `DevMain` did not exist locally and was created with
`git fetch origin && git checkout DevMain`. **Ten runs, same opening pattern.**

## Sources searched

| Source | Query / scope | Result |
| ------ | ------------- | ------ |
| **Gmail** | `pienissimo after:2026/10/07 -in:draft`, 40 requested, 14 estimated | 🔑 **Marco Montesi's reply on the Blueprint** 15:55:11Z · 🔑 **Mirko Merendi** 07:26:51Z, order fields updated · 🔑 **Rexhina Hysi's Italian QR API mail** 15:55:45Z and 🔴 **Elena Spini's forward of it to the client** 16:31:15Z · 🔴 **two sandbox Apex exception mails** 09:33:59Z and 09:44:48Z · one Flow error 06:45:34Z · a Salesforce security-token reset 07:26:46Z (⚠ credential mail, not opened for values) |
| **Gmail** | `get_thread 1a0fce6a8bb04fdb` (Blueprint, 6 messages, PLAIN_TEXT, full bodies) | 🔑 **Marco Montesi's answer to question 3 in full** — five named automated mail/WhatsApp triggers with 48-hour and 5-day windows (**OI-222**) · 🔑 **question 1 escalated to Sabatino Rinaldi**, the Fase 2 deferral refused (**OI-224**) · 🟢 question 2 accepted, _"Bene"_ |
| **Gmail** | `get_thread 1a11c3a80efe4189` (QR API, PLAIN_TEXT, full body) | 🔑 the whole UAT check-in contract, confirming the 07/10 reading · 🔴 **a live signed JWT assertion and the integration username in clear — recorded, never copied** |
| **Gmail** | `get_thread 1a0c9d4a7c6c7850` (Ordine cliente, 9 messages, MINIMAL) | 🔑 **Mirko Merendi: _"Ho completato la procedura per l'aggiornamento dei campi degli ordini come richiesto"_**, inviting Fabrizio Paganelli to check yesterday's order — the OI-213 customisation, vendor-side |
| **Drive** | `modifiedTime > '2026-10-07T22:00:00Z'`, **2 pages, 14 files** | 🔑 **the 08/10 internal session folder and its Gemini notes** · 🔑 **`Mappatura_Zoho_Forms_Pienissimo.xlsx`** 08:05:35Z · 🔑 **`Campi Oggetti…xlsx`** 08:29:42Z · 🔑 **`Business_Blueprint_Pienissimo.docx`** 15:50:44Z · ⚠ the rest are **other clients** (247, IUAD/Eduarth) or ROMI-internal (`Persone ruoli…`, `ERP - Salesforce`, two `LISTA…PER SITO.docx`, a partner-portal procedure, a `daze.eu` field sheet) — ignored per the skill |
| **Drive** | `read_file_content 1mahvMnO5mauF4VOgwfbv99DJUeNL1ZN2i6KPYo5dSpI` | 🔑 **the internal session read in full** — `Riepilogo`, **six `Concordato`**, ten `Passaggi successivi`, all `Dettagli`; the verbatim transcript read for the opening and the field-mapping discussion only. 81,034 characters; last transcript section `01:59:24` |
| **Drive** | `get_file_metadata 1KPZ8pwEg3FFyXDdKu-gkXPtI13Yb5fGi` | 🔑 **the form inventory OI-14 has been blocked on since June, identified** — 106 active forms, 1,588 fields, `segreteria5` on `forms.zoho.eu`, extracted 16/07; the destination-CRM columns are ROMI's to fill. Instructions sheet and the start of `Indice Form` only |
| **Slack** | `slack_read_channel C0BQD34LLF4` (dev group), from 07/10 22:00Z | **5 messages** — this procedure's own 07/10 report plus **four human messages, the first in twenty nights**: Anita Aga changed the Pienissimo UAT password and ⚠ **posted it in the channel** (09:26:56 CEST) · 🔴 **still no reply to any nightly report: twenty nights** |
| **Slack** | `slack_read_channel C0B5T3RB4FM` (`#tproj-pienissimo`), from 07/10 22:00Z | **0 messages.** A sixth consecutive day of silence on the project channel |
| **Slack** | `slack_read_channel C0C38JJ9D1T` (the marketing group DM), from 07/10 22:00Z | 🔑 **15 messages** — 🟢 **_"BBP confermato, lo stanno mandando in firma"_** (Elena Spini, 17:26:28 CEST) and _"a 10 gg del go-live ma va bene ahahaa"_ · 🔑 the **forms workbook** and the **data model** posted for Fabrizio Mastracci, 10:09 CEST · the `ai-visibility-fmf` form and a screenshot, with a per-form check to evaluate |
| **Fathom** | `list_meetings created_after 2026-10-07T22:00Z`, summaries + action items, 3 pages | **1 meeting, and it is another client** — `Salesforce - production check` for **247** (Luca Savi, Mehak Luthra, Tiziana Petruzzi, `vittoria.zoli@247.it`). Ignored per the skill. **0 Pienissimo meetings — thirteenth consecutive run.** The internal session exists only as a Google Meet artifact |
| **Git** | `fetch origin --prune`, `log --all --since 2026-10-07T22:00:00Z` | **22 commits**; `DevMain` advanced `391b401` → **`8879f08`**, through **PRs #83–#89** |
| **Git** | `merge-base --is-ancestor` on the carried-forward and new commits | 🟢 **`b08c9a8` (QR endpoint) is now in `DevMain`** (PR #83) · 🟢 **`577fc5c` (Anticipay country) is now in `DevMain`** (PR #84) · 🔴 `35b0606` (Anita Aga, Condizione Pagamento required) and `4336226` (Rexhina Hysi, lead/account/opportunity fields) are **not** merged |
| **Repo** | `MexalScadenzarioSearchService.cls:195-215`; `Scadenza_Fattura__c/fields/Pagata__c`; `isSaveDisabled` in both tranche LWCs before and after `1468961`; `quoteGeneratePdf.js` diff; `IntegrationNotificationConfigService.cls` and the `AnticipayErrorNotificationService` diff; `Order/fields/Mexal_Integration_Error__c`; `git show --stat` on all of today's commits; Aurel Mrruku's two JOURNAL entries | 🔴🔑 **both payment predicates unchanged — OI-212 did not move** · ⚠ **the empty-tranche save block pre-dated today's commit** · 🔴 **the PDF commit is not the PDF ruling** · 🟢 the notification recipient is a custom setting now · 🟢 the Mexal error field is on the order page with a conditional highlight |

## Found

1. 🟢🔑 **[OI-218](../items/OI-218%20Direction%20has%20not%20seen%20the%20Business%20Blueprint%20before%20the%2013%20October%20confirmation.md)
   is resolved** — _"BBP confermato, lo stanno mandando in firma"_, the first
   project document to reach a signature process. ⚠ Second-hand, in an internal
   chat; nothing establishes Daniela Morgese read it.
2. 🔴🔑 **New: [OI-222](../items/OI-222%20The%20commercial%20mail%20and%20WhatsApp%20notification%20flows%20are%20unspecified.md),
   gating** — Marco Montesi's five automated mail/WhatsApp triggers on the
   commercial funnel, with **48-hour** and **5-day** commitments, none of it in
   the Blueprint, the register or the build. ⚠ **He says the list is
   incomplete.**
3. 🔴 **New: [OI-224](../items/OI-224%20Mass%20Opportunity%20creation%20is%20contested%20as%20a%20Fase%202%20deferral.md)**
   — the mass-Opportunity deferral is refused and escalated to Sabatino Rinaldi,
   _"visto che ne abbiamo fatte alcune di recente"_.
4. 🔴🔑 **[OI-212](../items/OI-212%20A%20Ri.Ba.%20rate%20reads%20as%20paid%20before%20its%20due%20date.md)
   did not move, second night**, re-verified at `8879f08`. ⚠ Aurel Mrruku was in
   these files today and the internal session discussed the due-date logic
   without qualifying the paid test.
5. 🟢🔑 **[The 08/10 internal session](../meetings/2026-10-08%20Internal%20Test.md)**
   (10:00 CEST, ~2h, four ROMI people) — **six `Concordato`**, ten next steps.
6. 🟢🔑 **New: [OI-223](../items/OI-223%20The%20Mexal%20order%20send%20failed%20because%20the%20integration%20classes%20ran%20with%20sharing.md),
   resolved same day** — the order send failed on **access**, not mapping; the
   integration classes ran `with sharing`. ⚠ A **~40-class sharing-model change
   in one morning with no test run**, five days before the Prod deploy.
7. 🟢 **[OI-214](../items/OI-214%20The%20Mexal%20order%20send%20requires%20an%20agent%20code%20WooCommerce%20orders%20lack.md)'s
   invisible error is built** — `Order.Mexal_Integration_Error__c`, on the order
   page, with the agreed background highlight. 🔴 The agent code is still
   unanswered.
8. 🟢 **[OI-119](../items/OI-119%20The%20Anticipay%20error%20notification%20goes%20to%20a%20hardcoded%20ROMI%20address.md)
   is resolved** by a new `Integration_Notification_Config__c` custom setting —
   also 🟢 **the dedicated notification mailbox** owed on 07/10. ⚠ An
   unconfigured org now sends nothing.
9. 🟡 **[OI-215](../items/OI-215%20Anticipay%20does%20not%20cover%20San%20Marino%20addresses.md)
   moved both ways** — Italy as the Anticipay default is `Concordato` and
   `577fc5c` merged, so the hardcode implements a ruling. 🔴 Taken with no client
   present; OI-209's return flow is still unbuilt.
10. 🔴 **New: [OI-220](../items/OI-220%20A%20tranche%20with%20no%20products%20was%20reported%20saveable.md)**
    — ⚠ **the repository contradicts the report**: Save was already disabled for
    an empty tranche before today's commit, so the path is unidentified.
11. 🔴 **New: [OI-221](../items/OI-221%20The%20quote%20PDF%20does%20not%20regenerate%20when%20the%20quote%20changes.md)**
    — the `Concordato` is not built; the commit that looks like it fixes the page
    reload after a manual generation instead.
12. 🟢 **[OI-14](../items/OI-14%20Marketing%20forms%20and%20subdomain.md) has its
    inventory named after fifteen weeks** —
    [the Zoho Forms workbook](../The%20Zoho%20Forms%20mapping%20workbook.md), 106
    forms, **1,588 fields**, ROMI's columns to fill. 🟢 `Concordato`: the fields
    map at Opportunity level.
13. 🟡 **[OI-207](../items/OI-207%20The%20quote%20and%20order%20layouts%20omit%20the%20commercial%20fields%20the%20client%20requires.md)
    reviewed internally**, unit of measure included — but not with the client,
    and the logo went unmentioned.
14. 🔴 **The QR credential left ROMI** — forwarded to a mailbox on the client's
    own domain at 16:31:15Z, cc a shared administration mailbox. Recorded, never
    copied; the 07/10 rotation has not happened.
15. 🔑 **Mirko Merendi completed the Mexal order-field procedure** (07:26:51Z)
    and asked Fabrizio Paganelli to verify yesterday's order — OI-213's
    vendor-side work, ⚠ **unverified from Salesforce by this sweep**.
16. ⚠ **Of record:** Elena Spini owes a **post-launch support estimate**; the
    **community acceptance test still fails**, cause unsettled; Aurel Mrruku
    states **95% of core flows complete**; **80% open the mail on mobile**;
    Proton Mail adopted for credentials; a **UAT password was posted in the dev
    group**; old un-updated Mexal products need a clean-up.

## The register

**Amended? No. Version stays 1.6.**

Five of the day's six `Concordato` are **internal and operational** — where a
field sits on a page, which country Anticipay defaults to, how many products a
test uses, which permissions a test user gets, where an IVA code travels.

🟢 **The one finding with contractual reach is [OI-222](../items/OI-222%20The%20commercial%20mail%20and%20WhatsApp%20notification%20flows%20are%20unspecified.md)**,
because the **48-hour** tutor commitment and the **5-day** quote-validity
messages are promises made to a customer, and because the client states they are
running today. It joins the v1.6 candidates rather than forcing an amendment
tonight, on the same ground as the 07/10 run: ⚠ the carrier is blocked —
[OI-184](../items/OI-184%20Register%20v1.6%20goes%20to%20the%20client%20as%20one%20change%20set%20at%20UAT%20close.md)
cannot use an unconfirmed text, and the amended logic document's written
confirmation is now **seven days** unanswered.

⚠ **Candidates for v1.6 once confirmed**, carried forward and now joined by one:
the renewal-without-DocuSign path, the two-flag Lead consent model, the 21-value
`Tipologia di attività`, `Partita IVA` mandatory at lead conversion, the
per-edizione link scope, `Rinuncia` per edition, `E` counts as paid only once the
due date has passed — and, new, **the commercial notification flows**.

## Corrections to the record

- 🔴 **One correction to a build claim, found tonight.** The 07/10 trace listed
  `b08c9a8` and `577fc5c` as **not in `DevMain`**. Both **merged this morning**,
  via PRs #83 and #84. The QR note's contract and the Anticipay country hardcode
  are now on the working branch, and the notes say so.
- ⚠ **One correction to a report, not to a source.** Rexhina Hysi's `090d9e2`
  commit message — _"community page edit and refresh on pdf generation"_ — reads
  as though it implements the day's PDF-refresh ruling. **It does not**; it
  fixes the page reload after a manual generation. Recorded in OI-221 so the
  commit message is not mistaken for the ruling later.
- ⚠ **One discrepancy recorded rather than resolved.** OI-220's empty-tranche
  report does not match the repository, where `isSaveDisabled` already tested the
  line list on both components before today's commit. **The path is not
  identified**, and no owner has been fabricated for it.
- **No distortion was found in tonight's Gemini source.** Unlike the two 07/10
  documents, the internal session's notes agree with the transcript on every
  point this sweep checked. ⚠ Its title misspells the project as `PIENSSIMO`.

## Not done in this run

- The org was **not** opened. `STATUS.md` was not regenerated and the Notion
  mirror stays stale. Every build claim is repository arithmetic against
  `DevMain` `8879f08`.
- **No Apex test was written, proposed or scaffolded**, per the standing
  instruction. ⚠ Noted only as a fact of the diff: today's `without sharing`
  change crosses ~40 classes with no test run, inside the coverage gap
  [OI-64](../items/OI-64%20The%20bundle%20Apex%20test%20suite%20is%20broken.md) and
  [OI-66](../items/OI-66%20No%20test%20classes%20for%20the%20Biglietto%20stack.md)
  describe. Neither row was touched and nothing this sweep saw changed their
  state.
- **No Apex was changed and no deployment was made.** This procedure writes to
  the knowledge layer.
- **OI-212 was not fixed.** The defect is recorded with the file, the lines and
  the formula for a second night; the correction is a code change and belongs to
  Aurel Mrruku.
- **OI-223's blast radius was not assessed.** Which community-reachable
  controllers now bypass record access, and whether that matters, needs an org
  inspection and a security read this sweep did not do.
- **OI-207 was not verified in the org** — a fourth run. Tonight's movement is an
  internal review, not the client verification the row asks for.
- `Mappatura_Zoho_Forms_Pienissimo.xlsx` was read **only** at its instructions
  sheet and the start of `Indice Form`. The 1,588 field rows and the current
  state of the mapping columns were **not** read.
- `Campi Oggetti…xlsx` **moved** and was **not re-read** — it holds live customer
  records and nothing tonight needed its values, so **what changed is not
  established**.
- `Business_Blueprint_Pienissimo.docx` moved at 15:50:44Z and was **not
  re-opened**; the confirmation rests on Elena Spini's message, not on a diff of
  the document.
- The internal session's **verbatim transcript was not read whole** — the opening
  and the field-mapping discussion only; the `Dettagli` are timestamp-linked.
- No transcript was copied into `meetings/`; no per-meeting recap in
  `meetings/results/`.
- `npm run prettier:verify` was not run (no `node_modules`), so tonight's
  markdown is unformatted.

## Still unreachable

- 🔴 **`Mappatura_Categorie_Sottocategorie_Origine Lead_Tipologiattività.xlsx`**
  — the four Lead picklists, still a **mail attachment only**, third run. Not in
  Drive; this sweep has no tool that downloads one. **Ask Elisa Migliano or Elena
  Spini to put it in Drive.** Still the shortest path to closing OI-115, and now
  also the field list the 08/10 Opportunity mapping needs.
- 🔴 **The `pienissimolive.it` form** — _"non risulta raggiungibile"_, third run.
  ⚠ Now one of 106 in a workbook whose mapping is ROMI's to complete.
  **Ask Matteo Distaso.**
- **`Flows & Objects.drawio`** — did not move, a sixth consecutive run. Still an
  `mxfile` the Drive reader cannot parse, and still the only picture of the
  flows. **Ask Elena Spini for a PNG or PDF export.**
- **`Campagne Salesforce.xlsx`** — did not move. Still not opened.
- **`Testbook_UAT_Lead_Opportunita_2026-09-24_v2_1.xlsx`** — **did not move**, a
  seventh consecutive run. Approval due ~13/10, the production confirmation date.
- **The full text of `Pienissimo_Scheda di Partecipazione ai corsi_da firmare.pdf`**
  — not opened; its seven enrolment pages may carry personal data. ⚠ OI-194 is
  still gating and went undiscussed for a ninth day.
- ⚠ **The document Rebecca Marmo shared** with Fabrizio Mastracci. Fourth run,
  still not identified in Drive.
- **The WooCommerce logic document** for Daniela Morgese — fifth run, still not
  identified. ⚠ She has now confirmed the Business Blueprint instead.
- **The 30/07 marketing notes**, standing.
- **The 12:30 CEST internal call of 25/09** — still no artifact, eleventh run.
- ⚠ **The Pienissimo lead documentation** Elena Spini said she owed on 28/09.
  Not raised again.
- ⚠ **Sabatino Rinaldi's card and PayPal test orders** — owed fresh from the
  07/10 session, and WhatsApp is not a source this procedure can read. 🟢 Partly
  overtaken: Aurel Mrruku's own session found **four live gateway codes** in the
  UAT logs, two of them card gateways.
- **No DocuSign plan document** behind Sabatino Rinaldi's 2,500-envelope figure.
- **The API field names Mirko Merendi sent Aurel Mrruku in chat** — second run.
  He reports the order-field procedure **complete** as of 07:26:51Z, so the
  spelling may no longer be needed; OI-213's verification now needs an org read,
  not the chat.
- 🆕 **The `ai-visibility-fmf` form check.** Elena Spini posted the live URL and
  a screenshot at 09:51 CEST asking whether the pop-up e-mail check can be put on
  every form. The screenshot was not opened and the request has no owner.

**Nothing 404'd this run.**

## Absence of evidence, stated as absence

- **Fathom has returned no Pienissimo meeting for thirteen consecutive runs.** It
  returned one meeting tonight, for another client. A pattern about the tooling,
  not about the project.
- **`#tproj-pienissimo` was silent for a sixth day.** No status post from Elena
  Spini since 02/10.
- 🟢 **The dev group had human traffic for the first time in twenty nights** —
  and it was about a password, not about any report. 🔴 **Twenty consecutive
  nightly reports with no human reply.**
- **Rebecca Marmo has still not answered the two funnel questions** — WhatsApp
  parallel or backup, and which event date stops the send. She appears nowhere in
  today's sources.
- **No reply to Elena Spini's 12:47:00Z request for written confirmation** of the
  amended logic document, now **seven days** old. OI-200's seven open points are
  unchanged and nothing was found on them in any source.
- **Nothing was found on OI-210** — the `NR_Tranche` / one-article contradiction
  — in any source: not a mail, a message, a commit or a ruling. **Fourth night.**
  ⚠ The internal session discussed deactivating and re-mapping products without
  reaching it.
- **Nothing was found on OI-194**, OI-202, OI-204's documentation half, OI-205,
  OI-206's missing reports, OI-216 or OI-217.
- **Which agent code to use for an agentless WooCommerce order is unanswered** —
  Elisa Migliano must ask Marco Montesi, and he wrote twice today without it
  appearing.
- ⚠ **"Claudio" is still unresolved**, credited by Elena Spini for the problems
  table on 06/10. **No person note was created and nothing was attributed.**
- **No client confirmed any of today's six `Concordato`.** Every one was taken in
  a ROMI-internal room, including the Anticipay country default that OI-215 turns
  on.
