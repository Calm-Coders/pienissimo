---
id: trace-2026-10-06-nightly
type: reference
status: active
updated: 2026-10-06
watermark_used: 2026-10-05T22:00Z
external_watermark: 2026-10-06T22:00Z
account: a.mrruku@romicompany.com
---

# Source trace 2026-10-06 nightly

**Watermark for the next `requirements-check` run: 2026-10-06T22:00Z, single
value.**

**Watermark used: 2026-10-05T22:00Z**, the `external_watermark` stated by
[the 05/10 nightly trace](Source%20trace%202026-10-05%20nightly.md), selected by
`updated:` frontmatter. Scheduled nightly run, executed 2026-10-06 ~21:45Z.
**One day.**

🔑 **One client session — the consultation the link change was deferred to —
and the day three gating items closed in code.**

🟢 **Environment note.** The clone opened on `main` (two commits, config only);
`DevMain` did not exist locally and was created with
`git fetch origin && git checkout DevMain`. **Eight runs, same opening
pattern.**

## Sources searched

| Source | Query / scope | Result |
| ------ | ------------- | ------ |
| **Fathom** | `list_meetings created_after 2026-10-05T22:00Z`, summaries + action items, 3 pages | **0 meetings** — **eleventh** consecutive run with nothing. Today's session exists only as Google Meet artifacts |
| **Gmail** | `pienissimo after:2026/10/05 -in:draft`, 40 requested, 24 estimated | 🔑 **the 06/10 Gemini-notes mail** · 🔑 **Elisa Migliano's two picklist mails** · 🔑 **Aurel Mrruku's `Codice Fatturazione Elettronica` message** · 🟢 **Elena Spini's logic-document re-send** · 🟢 **Elena Spini to Matteo Distaso on the forms** · Aurel Mrruku to Sabatino Rinaldi on WooCommerce orders · three sandbox quote notices (00000134–00000136) |
| **Gmail** | `(from/to/cc:pienissimo.com OR ROMI-PIENISSIMO OR kreosoft OR pienissimo.pro) after:2026/10/05 -in:draft` | **12 threads, nothing new beyond the above.** 🟢 **The Kreosoft `Ordine cliente` thread moved** for the first time since 02/10 15:11Z — Aurel Mrruku's 13:49:38Z message. ⚠ Still **no reply from Mirko Merendi** |
| **Gmail** | `get_thread` on `1a11098014e0f7b6`, `1a10ffdcc543c242`, `1a1117ac154f6c42` (PLAIN_TEXT, full bodies) | 🔑 the 06/10 action items · 🔑 the picklist mail and its attachment metadata · 🔑 **the whole marketing follow-up thread, including Matteo Distaso's two UTM methods** |
| **Gmail** | `get_thread` on `1a11140ee386bdd0` | 🔴 **"Requested entity was not found"** — a message id from the search result that does not resolve as a thread id. Its content was recovered from the search snippet and from the Drive document it links |
| **Drive** | `modifiedTime > '2026-10-05T22:00:00Z'`, **2 pages, 21 files** | 🔑 **the 06/10 Gemini notes** (`111bChR…`, modified 11:12:10Z) · 🔑 **`PIENISSIMO – Logiche Asset e Invio Biglietti.docx` modified 12:46:10Z** · the 524 MB recording · ⚠ the rest are **other clients** (Vision's four-part Business Blueprint and CR register, BE.MA, IUAD, 247) — ignored per the skill |
| **Drive** | `read_file_content` on `111bChRGKcZDEShys3gjPHTFcvhzShkTjqb8InanRUns` | 🔑 **the 06/10 session, structured sections read in full** — `Riepilogo`, `Decisioni` (`Da approfondire` + **six `Concordato`**), eleven `Passaggi successivi`, and **all 16 `Dettagli`**. 100,938 characters; the verbatim transcript after `Dettagli` was **not** read |
| **Drive** | `read_file_content` on `1p4W9ekBWZbVMh0ts6ui_xSIwOHZLMG4z` | 🔑 **the client-facing logic document, read in full** — the amended `per edizione` heading, and 🔴 **two blanks**: an empty query condition and the stale _"Oggetto per il Flag: Asset ?"_ question |
| **Drive** | `title contains 'Mappatura'` | 🔴 **The picklist workbook is not in Drive.** One unrelated hit (`Franco Parenti Mappatura Secutix`, another client) |
| **Slack** | `slack_read_channel C0BQD34LLF4` (dev group), from 05/10 22:00Z | **1 message — this procedure's own 05/10 report.** 🔴 **No human reply to any nightly report: eighteen nights** |
| **Slack** | `slack_read_channel C0B5T3RB4FM` (`#tproj-pienissimo`), from 05/10 22:00Z | **0 messages.** A fourth consecutive day of silence on the project channel |
| **Slack** | `slack_read_channel C0C38JJ9D1T` (the marketing group DM), from 05/10 22:00Z | 🔑 **13 messages** — the full funnel spec, the confirmed `Regole di Business Aggiuntive` text, Rebecca Marmo's button request, the dynamic-field list |
| **Slack** | `slack_read_thread` ×3 on `1791290075`, `1791289697`, `1791289846` | 🔑 **Elena Spini's 37-second reversal** on the partial-nomination exit rule · 🟢 the bigger button is the **community page** (Aurel Mrruku) · ⚠ **ROMI has no solution-design template** |
| **Git** | `fetch origin --prune`, `log --all --since 2026-10-05T22:00:00Z` | 🔑 **11 commits** plus this procedure's own `7e5ed93`; `DevMain` advanced `d526189` → **`59d4264`** via PRs **#81** and **#82** |
| **Repo** | the scadenzario predicate; `git log -S"paymentStatus == 'E'"`; `merge-base --is-ancestor b74c8c4 d526189`; `branch -r --contains b74c8c4`; `git show --stat` on all seven new commits; `Discount_Pct__c`, `Stato_Scadenza__c`, `Giorni_Ritardo__c`, `Insoluto__c`; `Fattura__c` / `Scadenza_Fattura__c` field lists and `--diff-filter=A`; the `AGENTS.md` and `MAP.md` diffs of `731c7ac` | 🟢 **`'P' || 'E'` is in `DevMain`** · 🟢 **`b74c8c4` was NOT in `d526189`** — the 05/10 report was right about the branch and blind to the commit · 🟢 both invoice objects are **new in `731c7ac`** · 🟡 OI-207 partly landed |

## Found

1. 🟢🔑 **[The 06/10 client session](../meetings/2026-10-06%20Form%20Link%20per%20partecipanti.md)**
   (10:02 CEST, ~1h30m, four client-side) — **six `Concordato` rulings**, one
   `Da approfondire`, eleven next steps. The consultation the link change was
   deferred to.
2. 🟢🔑 **[OI-203](../items/OI-203%20The%20client%20contested%20the%20agreed%20ticket%20logics%20before%20confirming%20them.md)
   resolved.** One nomination link **per edizione**, `Rinuncia` per edition —
   **both contested points closed, the client's way**. So `4a6fe3f`'s
   pre-emptive rebuild is not sunk work; the direction is vindicated, the
   sequence is not.
3. 🟢🔑 **[OI-201](../items/OI-201%20Ri.Ba.%20payments%20are%20read%20as%20unpaid%20because%20only%20P%20counts.md)
   is fixed on both paths.** `MexalScadenzarioSearchService` tests `'P' || 'E'`
   via **Anita Aga's `b74c8c4`, committed 05/10 18:46 on an unmerged branch**,
   merged today through PR #81. **Four nights of "did not move" were correct
   about `DevMain` and blind to the branch** — recorded as a limit of
   repository arithmetic, not as an error in the reports.
4. 🟢🔑 **[OI-206](../items/OI-206%20The%20Insoluto%20concept%20has%20no%20invoice%20due%20date%20and%20no%20invoice%20record.md)
   and [OI-208](../items/OI-208%20Overdue%20and%20upcoming%20payments%20are%20not%20distinguished%20on%20the%20contract.md)
   are built** by `731c7ac` — new `Fattura__c` (`Insoluto__c`) and
   `Scadenza_Fattura__c` (`Stato_Scadenza__c`, `Giorni_Ritardo__c`, two list
   views). Both formulas cite their item number in the metadata. 🔴 **OI-206's
   reports are still absent.**
5. 🟢🔑 **[OI-209](../items/OI-209%20Mexal%20anagrafica%20updates%20only%20propagate%20when%20an%20order%20is%20sent.md)
   has its design** — UI lock, corrections in Mexal, nightly sync through a
   dedicated user that bypasses the lock. `F-2` of the client's workbook, three
   months on. 🔴 Nothing built.
6. 🟢 **[OI-115](../items/OI-115%20Tipologia%20Attivita%20values%20and%20its%20move%20to%20the%20quote.md):
   all four picklists delivered** by Elisa Migliano at 06:54:07Z, twice. 🔴 **The
   attachment is unreadable by this sweep.**
7. 🟢 **[OI-14](../items/OI-14%20Marketing%20forms%20and%20subdomain.md) moved for
   the first time in nine weeks** — the hidden-field mapping arrived on time,
   with **two UTM mechanisms** documented. 🔴 **`pienissimolive.it`'s form is
   unreachable.** 🔑 Forms must now require Partita IVA.
8. 🔑 **[The marketing funnel](../The%20marketing%20ticket%20send%20logics%20as%20written%20by%20Marketing.md)**
   — 11 email + 11 WhatsApp, 2–8 day waits, exit check at every step. 🔴 Two
   questions to Rebecca Marmo unanswered.
9. 🔴 **[OI-196](../items/OI-196%20Whether%20tickets%20are%20sent%20when%20the%20buyer%20names%20only%20some%20participants.md):
   follow-ups for partial nominations are dropped for go-live.** One nomination
   of five ends the funnel. ⚠ Elena Spini accepted, rejected on the merits 37
   seconds later, and accepted anyway. **No Fase 2 row carries it back.**
10. 🔴 **New: [OI-211](../items/OI-211%20Mexal%20rejects%20N%20for%20the%20electronic%20invoicing%20code.md)**
    — Mexal refuses `N` for `Codice Fatturazione Elettronica`; `P` or `S`
    hedged, unconfirmed, no transcoding table. Due 07/10 12:15.
11. 🔴 **[OI-200](../items/OI-200%20The%20client%20was%20asked%20to%20confirm%20logics%20whose%20open%20points%20were%20removed.md)
    did not move, on a second version** — seven open points still absent, the
    query condition **blank**, and a question answered on 05/10 still printed as
    open to the client.
12. 🟡 **[OI-207](../items/OI-207%20The%20quote%20and%20order%20layouts%20omit%20the%20commercial%20fields%20the%20client%20requires.md)
    partly landed** via PR #82 — the line discount has a field; unit of measure
    and the logo untouched.
13. 🔑 **Go-live stated in the room as "2 settimane"** and used to refuse every
    structural change: cambio nominativo, dynamic follow-ups, per-ticket
    rinuncia and the full-renunciation mail all to Fase 2.
14. ⚠ **New of record:** QR check-in writes `utilizzato` **within 5 days** of the
    event date; the **Rinuncia button leaves the email** and must be bigger on
    the **community page**; the **edition-move exception** (2026→2027) is handled
    by changing the academic year or a zero-value offer, with no build and no
    owner; **ROMI has no solution-design template**.
15. ⚠ **`731c7ac` also edited the knowledge layer** — `AGENTS.md` (+8, the Mexal
    read authorization), `MAP.md`, `INDEX.md`, `JOURNAL.md`, both trackers, the
    Mexal flow note and four item notes. Part of tonight's write-back was
    already done by Aurel Mrruku; **two stale claims in it were corrected** (see
    below).

## The register

**Amended? No. Version stays 1.6.**

The day's six rulings are **operational and interface rulings** — where a link
is scoped, when a button hides, which system owns a registry field, what moves
to Fase 2. None restates a requirement's acceptance criteria, state machine or
picklist in the contractual sense.

🟢 The closure of **OI-203** is the strongest candidate yet for v1.6, because it
settles a rule the client had rejected in writing. ⚠ But the carrier is still
blocked: the amended document's **written confirmation has been requested and not
received**, and
[OI-184](../items/OI-184%20Register%20v1.6%20goes%20to%20the%20client%20as%20one%20change%20set%20at%20UAT%20close.md)
cannot use an unconfirmed text — nor one that still has a blank query condition
and a stale open question in it.

⚠ **Candidates for v1.6 once confirmed**, carried forward and now joined by two:
the renewal-without-DocuSign path, the two-flag Lead consent model, the 21-value
`Tipologia di attività`, `Partita IVA` mandatory at lead conversion, and — new —
**the per-edizione link scope** and **`Rinuncia` per edition, hidden after the
first confirmed participant**.

## Corrections to the record

- **`MAP.md`'s 05/10 entry** said the invoice sync was _"Working tree only, not
  committed or deployed"_. It was committed in `731c7ac` the same morning that
  wrote the line. Marked superseded, not deleted.
- **[OI-201](../items/OI-201%20Ri.Ba.%20payments%20are%20read%20as%20unpaid%20because%20only%20P%20counts.md)**
  said `MexalScadenzarioSearchService.cls:205` _"still reads `== 'P'`"_. It does
  not: `b74c8c4` fixed it. Both claims are corrected in the note with their
  evidence.

## Not done in this run

- The org was **not** opened. `STATUS.md` was not regenerated and the Notion
  mirror stays stale. Every build claim is repository arithmetic against
  `DevMain` `59d4264`.
- **No Apex test was written, proposed or scaffolded**, per the standing
  instruction. ⚠ Noted only as a fact of the diff: `QuoteCommercialTest.cls` was
  **edited** (−6 lines) in `f84d356` by Rexhina Hysi, and `Product2.Is_Plus__c`
  was deleted. [OI-64](../items/OI-64%20The%20bundle%20Apex%20test%20suite%20is%20broken.md)
  and [OI-66](../items/OI-66%20No%20test%20classes%20for%20the%20Biglietto%20stack.md)
  were not touched; nothing this sweep saw changed their state.
- **No Apex was changed and no deployment was made.** This procedure writes to
  the knowledge layer.
- **OI-207 was not verified in the org.** The five commercial fields against the
  seven surfaces needs an org inspection; only the diff was read.
- The **524 MB recording** and the **verbatim transcript** inside the 06/10
  notes were not opened; the `Dettagli` are timestamp-linked.
- `Integrazioni pienissimo.xlsx`, `Campi Oggetti…xlsx` and the article registry
  **did not move** today and were not re-opened.
- No transcript was copied into `meetings/`; no per-meeting recap in
  `meetings/results/`.
- `npm run prettier:verify` was not run (no `node_modules`), so tonight's
  markdown is unformatted.

## Still unreachable

- 🔴 **New: `Mappatura_Categorie_Sottocategorie_Origine Lead_Tipologiattività.xlsx`**
  — the four Lead picklists, delivered 06/10 06:54:07Z as a **mail attachment
  only**. Not in Drive; this sweep has no tool that downloads one. **Ask Elisa
  Migliano or Elena Spini to put it in Drive.** It is the shortest path to
  closing OI-115.
- 🔴 **New: the `pienissimolive.it` form** — _"non risulta raggiungibile"_
  (Elena Spini, 13:50:09Z). Not a sharing problem; the form itself. **Ask Matteo
  Distaso.**
- **`Flows & Objects.drawio`** — did not move, a fourth consecutive run. Still an
  `mxfile` the Drive reader cannot parse, and still the only picture of the
  flows. **Ask Elena Spini for a PNG or PDF export.**
- **`Campagne Salesforce.xlsx`** — did not move. Still not opened.
- **`Testbook_UAT_Lead_Opportunita_2026-09-24_v2_1.xlsx`** — **did not move**, a
  fifth consecutive run. Approval due ~13/10.
- **The full text of `Pienissimo_Scheda di Partecipazione ai corsi_da firmare.pdf`**
  — not opened; its seven enrolment pages may carry personal data. ⚠ OI-194 is
  still gating and went undiscussed for a seventh day.
- ⚠ **The document Rebecca Marmo shared** with Fabrizio Mastracci, of what
  marketing did before. Second run, **still not identified in Drive.** She was in
  today's session and it was not raised. Worth asking.
- **The WooCommerce logic document** for Daniela Morgese — third run, still not
  identified.
- **The 30/07 marketing notes**, standing.
- **The 12:30 CEST internal call of 25/09** — still no artifact, ninth run.
- ⚠ **The Pienissimo lead documentation** Elena Spini said she owed on 28/09.
  Not raised again.
- ⚠ **Sabatino Rinaldi's WhatsApp confirmation** of the card and PayPal test
  orders of 02/10. WhatsApp is not a source this procedure can read.
- **No DocuSign plan document** behind Sabatino Rinaldi's 2,500-envelope figure.
- 🔴 **One Gmail id did not resolve**: `get_thread` on `1a11140ee386bdd0`
  (Elena Spini's 12:47:00Z re-send) returned _"Requested entity was not found"_.
  Its content was recovered from the search snippet and the Drive document, so
  nothing is lost, but **the message body itself was not read in full.**

**Nothing else 404'd.**

## Absence of evidence, stated as absence

- **Fathom has returned nothing for eleven consecutive runs.** A pattern about
  the tooling, not about the project.
- **`#tproj-pienissimo` was silent for a fourth day.** No status post from Elena
  Spini since 02/10. Absence at this watermark, not evidence that nothing was
  decided.
- **Eighteen consecutive nightly reports with no human reply** in the dev group.
- **No reply to Elena Spini's 12:47:00Z request for written confirmation** of the
  amended logic document, checked on the thread directly.
- **Nobody has replied to Marco Montesi** — his 05/10 13:20:02Z message with
  three precisazioni is still the last on the Blueprint thread, a second day.
- **Mirko Merendi has not answered** Aurel Mrruku's `Codice Fatturazione
  Elettronica` question, four hours old at the watermark.
- **Rebecca Marmo has not answered** the two funnel questions put to her through
  Fabrizio Mastracci.
- **No artifact was found for any 06/10 internal ROMI session** — the only
  meeting of the day in the records is the client one.
- **Nothing was found on OI-210** (the `NR_Tranche` / one-article contradiction)
  in any source: not a mail, a message, a commit or a ruling. **Second night.**
  It was not raised in the client session.
- **Nothing was found on OI-194**, OI-202, OI-204 or OI-205 in any source.
- ⚠ **"Claudio" is still unresolved**, credited by Elena Spini for the problems
  table. **No person note was created and nothing was attributed.**
- ⚠ **Whether the WooCommerce orders Aurel Mrruku saw are client tests is
  unknown.** He asked Sabatino Rinaldi at 10:34:40Z; no reply at this watermark.
