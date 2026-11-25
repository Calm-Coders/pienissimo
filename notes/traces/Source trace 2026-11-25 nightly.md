---
id: trace-2026-11-25-nightly
type: reference
status: active
updated: 2026-11-25
watermark_used: 2026-11-24T22:00Z
external_watermark: 2026-11-25T22:00Z
account: a.mrruku@romicompany.com
---

# Source trace 2026-11-25 nightly

**Watermark for the next `requirements-check` run: 2026-11-25T22:00Z, single
value.**

**Watermark used: 2026-11-24T22:00Z**, the `external_watermark` stated by
[the 24/11 nightly trace](Source%20trace%202026-11-24%20nightly.md), selected by
`updated:` frontmatter. Scheduled nightly run, executed 2026-11-25 ~21:45Z.
**One day** — 🟢 **but Gmail was restored after four blind nights, so the mail
window was swept retroactively from 2026-11-18/20 to now** and the four-day gap
is closed.

🔑 **The headline: the written consent for the production release exists and was
hiding in a Slack thread; the marketing training finally has dates after the
client's first cooperative written reply since the PEC; and ROMI has told the
client it will plan "la nuova migrazione" at a 30 November meeting its own
calendar calls `PH: Pienissimo PERIMETRO` — undefined, unauthorised, and without
the technical lead.**

🟢 **Gmail came back.** Four nights of _"unverifiable"_ convert into verified
facts and verified negatives: the training mail **was** sent, the client **did**
reply, and the PEC **is not in this mailbox**.

🟢 **Environment note.** The clone opened on **`main`** (two commits, config only)
with none of the knowledge layer in the working tree; `DevMain` did not exist
locally and `git checkout DevMain` needed a `git fetch` first. **Forty-first run,
same opening pattern.** Working tree **clean** at start, `DevMain` at
**`006e830`**.

## Sources searched

| Source | Query / scope | Result |
| ------ | ------------- | ------ |
| **Gmail** | `pienissimo after:2026/11/24 -in:draft`, 50 requested | 🟢 **CONNECTOR RESTORED — 4 threads.** The training calendar mail, two calendar invitations, the PR #132 merge notification |
| **Gmail** | `get_thread 1a213f12a0542f0a`, full plaintext | 🔑 **The whole training exchange**, three messages quoted in one: Elena Spini 24/11 19:27, Sabatino Rinaldi 25/11 11:14, Elena Spini 25/11 19:21 → **OI-378**, **OI-385**, OI-375 |
| **Gmail** | `after:2026/11/20 (pienissimo.com OR pienissimo.pro OR "ROMI-PIENISSIMO" OR kreosoft OR mexal OR scadenziario OR biglietto OR PEC OR contestazione OR "nota di credito")`, 50 | **7 threads, 1 Pienissimo** — the training thread. The rest IUAD, Zucchet/3CX, Zucchet fatturazione, Life365, 247.it. ⚠ **No PEC, no Kreosoft, no Mexal** |
| **Gmail** | `after:2026/11/20 (from:/to:/cc: pienissimo.com)` | **1 thread** — the training one. 🔴 **No other client mail in six days** |
| **Gmail** | `after:2026/11/20 (pienissimo OR "1454" OR diffida OR inadempimento OR risoluzione OR "fase 2" OR formazione OR dashboard OR docusign OR anticipay OR woocommerce)`, 50 | **8 threads.** 🔑 One new find: **Gemini notes for `[PIENISSIMO] - Interna Check Report`, 20/11** → the 20/11 meeting note, OI-377 |
| **Gmail** | `after:2026/11/18 (romiagency@pec.it OR pec.it OR raccomandata OR legale OR avvocato OR "art. 1454" OR messa in mora)` | 🔴 **0 results.** The PEC and ROMI's reply are **not in this mailbox** → OI-375 |
| **Gmail** | `after:2026/11/20` by participant address — Sabatino Rinaldi, Fabrizio Paganelli, Daniela, amministrazione, Rebecca M, Matteo D, Elisa Migliano, plus `mirko`/`merendi`/`parmeggiani`/`montesi` | 🔴 **0 results.** Sabatino Rinaldi's reply exists only as quoted text inside Elena Spini's mail — he did not copy this account |
| **Gmail** | `after:2026/11/18 (webapi OR credenziali OR "codici articolo" OR listino OR "lista eventi" OR tranche OR insoluti OR fattura) has:attachment` | **2 threads, both IUAD.** 🔴 **The four mail-borne artifacts are still owed**: Mexal WEBAPI credentials, event list, bundle-only article codes, catalogue prices |
| **Gmail** | `after:2026/11/20 from:gemini-notes@google.com`, 30 | **8 threads, 1 Pienissimo** (the 20/11 one). The others VFL1 ×3, VISION, IUAD, Daze — excluded |
| **Slack** | `slack_read_channel C0B5T3RB4FM` (`#tproj-pienissimo`), `oldest` 1795557600 | 🔴 **0 messages.** No new top-level traffic since 24/11 |
| **Slack** | `slack_read_thread C0B5T3RB4FM 1795533272.952249` | 🔑🟢 **THE FINDING. 3 replies, two of them new.** Angelo Pastorelli **25/11 10:47:28** and **10:47:33 CET**: _"per me puoi procedere"_, one ✅ → **OI-381**, OI-375, OI-380. ⚠ **A channel read could never have found this** |
| **Slack** | `slack_read_thread C0B5T3RB4FM 1795532756.179679` | **2 replies, both already held.** No answer to the acceptance-test or visibility questions → OI-377 |
| **Slack** | `slack_read_channel C0C38JJ9D1T` (marketing group DM) | 🔑 **5 messages, 19:26-19:40 CET.** The calendar reposted, _"il perimetro delle cose che mancano"_, _"se poi si sveglia il giorno X"_, _"io non ci sono il 30 e l 1"_, _"oggi ho rilasciato in prod dashboard e report"_ → **OI-385**, OI-381 |
| **Slack** | `slack_read_channel C0BQD34LLF4` (ROMI dev group) | 🔴 **0 messages.** **No human has ever replied to a nightly report** |
| **Slack** | `slack_read_channel D0B5QHS2T7H` (Elena Spini DM) | **0 messages** |
| **Slack** | `slack_read_channel D0CEWML860G` (the DM where Anita Aga was offered elsewhere) | 🔴 **0 messages** → OI-384 unmoved |
| **Slack** | `slack_search_public_and_private` `pienissimo`, `after:2026-11-24` | **1 result**, the group-DM calendar post already read |
| **Slack** | `slack_search_public_and_private` `after:2026-11-24 is:dm`, 2 pages, 40 messages | **Confirms the sweep is complete.** The Pienissimo messages are the five in `C0C38JJ9D1T`. The rest is VISION/Vape (agent map, `Vape_Maps_Agents`, punti vendita), VFL1, Life365, a ROMI resourcing and invoicing DM, and Clockify — all other projects |
| **Slack** | `slack_search_public_and_private` `migrazione`, `after:2026-11-24` | **1 result** — the calendar post. 🔴 **No other source anywhere discusses the new migration** → OI-385 |
| **Slack** | `slack_search_public_and_private` `perimetro`, `after:2026-11-24` | **2 results** — Elena Spini's line, and a Jira bot post |
| **Slack** | `slack_search_public_and_private` `consenso`, `after:2026-11-23` | **4 results** — the consent question, two nightly reports (PIENISSIMO, IUAD) and `#tproj-franco-parenti`. Excluded |
| **Slack** | `slack_search_public_and_private` `dashboard`, `after:2026-11-24` | **1 result** — _"oggi ho rilasciato in prod dashboard e report"_ |
| **Slack** | `slack_search_public_and_private` `scadenziario`, `after:2026-11-24` | 🔴 **0 results** — a **fifth** day |
| **Slack** | `slack_search_public_and_private` `PEC`, `after:2026-11-24` | 🔴 **0 results** |
| **Slack** | `slack_search_public_and_private` `anita`, `after:2026-11-24` | 🔴 **0 results** → OI-384 |
| **Slack** | `slack_read_canvas F0BD2H5A9HT` (`Link utili Pienissimo`) | **Unchanged.** Newest entry still 20.08.2026 — **97 days**. Re-read per the skill |
| **Drive** | `modifiedTime > '2026-11-24T22:00:00Z' and trashed = false`, 40 requested, `modifiedTime desc` | **19 files, 🔴 not one of them Pienissimo.** Vision Business Blueprint parts 1-4 V1.8 v2 and the Vision Gantt v2 (Davide Losco), `Vision_Data_Dictionary_Salesforce`, `SF - Tabella campi articoli.xlsx`, an NTS minute, VFL1 Gemini notes, 247.it, `[ROMI] Slide Team`, the ROMI IT regulation and a shared-drive price list. ⚠ **A fifth day with no Pienissimo document activity at all** |
| **Drive** | `(title contains 'Pienissimo'/'PEC'/'scadenziario'/'nota di credito'/'contestazione'/'formazione'/'perimetro'/'migrazione') and modifiedTime > watermark` | **1 hit, and it is Vision** — the Gantt, matched on _formazione_. 🔴 **No copy of the PEC, none of ROMI's reply, and nothing on the new migration** |
| **Fathom** | `list_meetings created_after 2026-11-24T22:00Z`, 3 pages, summaries on | 🔴 **0 meetings. Nothing at all, a forty-fourth consecutive run** |
| **Git** | `fetch --all`, `log --all --since`, `show --stat 006e830` | 🔑 **2 commits in the window.** `56a7020` merge of PR #132 (`aureliii`, 18:10:26 CET) and **`006e830` "Deploy Production"** (**Anita Aga**, 18:26 CET) — 5 dashboards, 2 report types, 1 report, 1 report folder, plus INDEX/JOURNAL/MAP, both recaps, both trackers and the OI-381 note. Tree **clean** at start |
| **GitHub** | `list_pull_requests` state all, sorted by update | 🟢 **PR #132 merged 2026-11-25T17:10:26Z**; **0 open pull requests** for the first time in this item's life → OI-381, OI-384 |
| **Repo** | `JOURNAL.md` head, `MAP.md` head, `ls notes/items` max-id scan | Watermark and state confirmed. **Two codex sessions ran today** and wrote back the deployment. Max existing id **384**; **385 allocated this run, next free is 386** |

## Found

1. 🔑🟢 **[The written consent for the production release exists](../items/OI-381%20The%20report%20and%20dashboard%20remediation%20is%20unmerged%20and%20due%20in%20production%20on%20a%20holiday.md)**
   — **OI-381 updated.** Angelo Pastorelli answered Elena Spini's 24/11 17:18
   question on **25/11 at 10:47:33 CET**: _"**per me puoi procedere**"_, one ✅,
   preceded at 10:47:28 by _"Scusa ho letto adesso, si eravamo rimasti cosi con
   Daniele e le ho inviato un vocale ieri"_. 🔑 **It is a thread reply** — the
   channel itself has had no new top-level message since 24/11, so only a
   deliberate thread re-read found it. 🟢 The _"abbiamo toccato PROD senza
   consenso"_ exposure is answered; 🔴 **Gianpaolo Motta's ok has never been
   recorded at any point**. 🔴 **The release then missed its own _"entro le 12"_
   by about six hours**: merge 18:10:26, deploy `0AfSW000001NQPR0A4` complete
   **18:19:59 CET**, commit `006e830` 18:26, told to the marketing DM 19:40:25
   (_"oggi ho rilasciato in prod dashboard e report"_). 🟢 **No open PR remains.**
   🔴 The acceptance test, the visibility decision and **the tranche report
   schedule — five days to month end** — are all still owed.

2. 🟢🔑 **[The marketing training is scheduled, and the client answered in writing](../items/OI-378%20Marketing%20training%20is%20undelivered%20and%20the%20client%20did%20not%20attend%20the%20final%20test.md)**
   — **OI-378 updated.** Elena Spini mailed the proposals **24/11 19:27 CET**,
   ~4 hours after being told to; **Sabatino Rinaldi answered 25/11 11:14** —
   🔑 **the client's first written, cooperative reply since the PEC of 17
   November** — asking to move off 2 December (_"siamo impegnati all'intensive
   con tutto lo staff marketing"_); ROMI accepted and fixed the calendar at
   19:21: **30/11** clarifications, **1/12** final marketing check **in
   production**, **3/12** Modulo 1 segments and newsletters, **4/12** Modulo 2
   forms and landing pages. ⚠ The 1/12 session carries an **unowned client-side
   prerequisite** — configure a test campaign with correct dates and
   edition/product mapping first, _"cosi da non alterare i dati reali"_. 🔴 24/11
   and 26/11 both lapsed undelivered; the scaletta (eighth window), the 19/11
   test pack, the no-show explanation and **the training record** are still
   missing.

3. 🆕🔴 **[OI-385 — a scope perimeter call, and an undefined new migration](../items/OI-385%20A%20scope%20perimeter%20call%20and%20a%20new%20migration%20are%20planned%20for%2030%20November.md)**
   — **new note, the only id allocated this run.** The client is told the 30/11
   10:00 call covers _"verifica di cosa manca rispetto a quanto gia consegnato"_
   **and _"pianificazione della nuova migrazione"_**. 🔴 **"La nuova migrazione"
   has the definite article and no antecedent** — no scope, no data, no
   requester, no Fase 1/2 ruling, and nothing in the 24/11 instruction
   authorises it. 🔑 **The calendar invitation is titled `PH: Pienissimo
   PERIMETRO`** (sent 25/11 12:12 CET) while the client has it as _"chiarimenti e
   next step"_, and the internal purpose is scope closure: _"dobbiamo capire
   tutto il perimetro delle cose che mancano per FABRIZIO"_ + _"se poi si sveglia
   il giorno X a dire aaaa ma c'era anche questo ora e veramente NO"_ (19:27
   CET). 🔴 **Aurel Mrruku will not attend 30/11 or 1/12** — _"io non ci sono il
   30 e l 1"_ — the two sessions Elena Spini says concern him, no substitute
   named. ⚠ Which Fabrizio she means is **not stated** and is recorded as
   uncertain.

4. 🔴 **[Gmail works, and the PEC is not in it](../items/OI-375%20Pienissimo%20sent%20a%20PEC%20contesting%20the%20implementation%20and%20suspending%20the%20go-live.md)**
   — **OI-375 updated.** Seven PEC/legal formulations across 18-25 November
   return **nothing**, and no `@pienissimo.com` mail exists in the window beyond
   the training thread. ⚠ **So the PEC was not addressed to this mailbox and
   ROMI's reply of 19 November was not sent from it** — four days of
   _"unverifiable"_ become a verified negative. **The art. 1454 c.c. term is
   still unknown, a fifth day.** ⚠ Client contact has also **widened past the
   24/11 authorisation**, which covered the training proposals only.

5. 🔴 **[A fifth day of silence on the scadenziario and the credit notes](../items/OI-380%20The%20client%20wants%20the%20scadenziario%20and%20the%20credit%20notes%20as%20soon%20as%20possible.md)**
   — **OI-380 updated.** 0 Slack hits, 0 Drive activity, 0 Fathom, and a restored
   Gmail with no client mail but the training thread — a **verified** negative
   now. 🔑 **The 24/11 briefing was a voice message, not a call**: _"le ho
   inviato un vocale ieri"_, content unrecorded. ⚠ _"eravamo rimasti cosi con
   **Daniele**"_ is a masculine name matching nobody in the records against a
   feminine pronoun — **recorded as uncertain, not resolved**. 🟡 The **30/11
   perimeter call is the first venue these could reach**, and its internal
   purpose is to **close** the missing-items list — so **if they are not raised
   in it they may be excluded by it**.

6. 🟡 **[The reports and dashboards are production metadata and all three gaps survived](../items/OI-377%20Reports%20and%20dashboards%20were%20never%20built%20and%20have%20no%20requirements.md)**
   — **OI-377 updated.** No client requirement, register still **v1.6**, contract
   clause unquoted a **seventh** day, no acceptance test, no visibility decision,
   tranche report unscheduled. 🟡 The 20/11 meeting's **Gemini notes**, found in
   Gmail, independently attest the single recommended next step: _"Eseguire il
   deployment delle dashboard e dei report: in produzione lunedi se richiesto
   dagli stakeholder, **senza pero fornire spiegazioni agli utenti**"_ —
   recorded on
   [the meeting note](../meetings/2026-11-20%20INTERNA%20Check%20Report.md) as a
   second, independent record.

7. 🟡 **[The authorised exception is delivered and spent, and the freeze is being overtaken](../items/OI-376%20All%20Pienissimo%20work%20is%20frozen%20except%20reports%20and%20dashboards.md)**
   — **OI-376 updated.** The one thing the freeze allowed is live and merged; the
   freeze itself has **never been formally lifted**; and a **new migration** is
   now on the client's calendar. ⚠ Overtaken in practice rather than decided.

8. 🟢 **[Anita Aga was not moved before the release closed](../items/OI-384%20Anita%20Aga%20is%20being%20reallocated%20off%20Pienissimo%20while%20Fase%202%20is%20stopped.md)**
   — **OI-384 updated.** PR #132 merged and `006e830` is authored by her. 🔴
   Everything else unmoved: 0 new messages in the offering DM, 0 search hits on
   her name. ⚠ The premise _"se non parte pienissimo fase 2 e libera"_ is weaker
   now that ROMI has promised the client a migration.

9. 🟢 **[Daniela Morgese's surname is attested from a primary source](../people/Daniela%20Morgese%20-%20Pienissimo%20direction.md)**
   — person note updated. `daniela@pienissimo.com` renders as **"Daniela
   Morgese"** in the client mail directory on the live training thread, after
   four days on the unreachable list. The same thread attests **Matteo Distaso**.
   🔴 Rebecca's entry reads only _"rebecca m"_, so OI-378's `uncertain:` was
   narrowed to her alone.

## Not done, and why

- **The org was not opened.** `STATUS.md` and its Notion mirror are **stale** and
  step 6 of `org-status-check` was **not** run. ⚠ Note, though, that today's two
  codex sessions did inspect production and verified the reporting deployment, so
  the org-vs-record gap on **that** package is covered by
  [OI-381](../items/OI-381%20The%20report%20and%20dashboard%20remediation%20is%20unmerged%20and%20due%20in%20production%20on%20a%20holiday.md)
  and `JOURNAL.md`. What remains unanswered is whether anything **else** was
  deployed outside source control.
- **No meeting was drilled.** Fathom returned 0 and no new transcript exists. The
  only new meeting record in the window is the 20/11 Gemini notes, which
  corroborate an already-drilled meeting rather than adding a session — recorded
  as a second source, not re-drilled.
- **No Apex test class was written or proposed.** Standing instruction. OI-64,
  OI-66 and [the deploy risk](../risks/Risk%20-%20production%20deploy%20is%20blocked%20by%20Apex%20coverage.md)
  are unchanged and were not acted on. ⚠ The release of 25/11 was reports,
  dashboards, report types, folders and navigation — **no Apex** — so Salesforce
  ran no tests and coverage did not gate it.
- ⚠ **`Pienissimo_Offerta_Fase_2_V_4.1.pptx` was again not read** and no euro
  figure transcribed, per the standing rule. It did not change in this window.
- ⚠ **Elena Spini's change workbook of 13/11 was again not found** — an **eighth**
  window.
- **The client change sheet was not re-read** — no Drive edit in the window, so
  OI-344 stands at 7 `SI` / 4 `IN LAVORAZIONE` / 2 `NON SI FA` / 6 blank.
- **No customer-data workbook or attachment was opened.** None was offered.
- **The two calendar invitations were read as metadata only** — subject, sender,
  date, time. Their bodies are Google Meet boilerplate.
- **OI-336, OI-343, OI-345, OI-347 to OI-374, OI-379, OI-382, OI-383 were not
  updated** — **no new evidence in this window.** ⚠ Most are frozen rather than
  open.
- **The requirement register was not touched** — stays **v1.6**. ⚠ The reports and
  dashboards are now production metadata and still have no requirement, and a
  **migration** is being planned with no requirement either.
- **247.it, Life365, Zucchet / 3CX, VISION / VapeItalia, VFL1, Magento / NTS,
  `[ROMI/IUAD]`, Daze, `#tproj-franco-parenti`, the Vision Business Blueprint and
  the ROMI IT regulation were excluded** — other projects, per the skill.
- **The name of the person who resigned on another project was again left out**,
  as on 24/11 — another project's staffing matter, personal to them.
- **`prettier:verify` was not run** (not executable in this environment, as on
  previous runs).

## Still unreachable

Named precisely enough to ask someone for them:

- 🆕🔴 **What "la nuova migrazione" is** — scope, data, trigger, requester, and
  whether it is Fase 1 or Fase 2 — **before 30 November 10:00**, when ROMI plans
  it with the client (OI-385).
- 🆕🔴 **Who represents the build on 30 November and 1 December**, given that
  Aurel Mrruku has said he is out on both — and the 1/12 session runs in
  **production** (OI-385, OI-378).
- 🆕🔴 **Whether the 30 November perimeter, once agreed, is put to the client in
  writing as the closed scope** — otherwise the exercise does not achieve what it
  is being held for.
- 🆕🔴 **Whether the scadenziario and the credit notes are on the 30 November
  agenda** (OI-380) — **fifth day** with no word, and this is the first venue.
- 🆕⚠ **Who configures the client-side test campaign for 1 December**, with the
  correct dates and the edition/product mapping (OI-378).
- 🆕⚠ **Who "Daniele" is** in Angelo Pastorelli's _"eravamo rimasti cosi con
  Daniele"_ of 25/11 10:47 CET, and **what the 24 November voice message to the
  client's direction said** (OI-380).
- 🆕⚠ **Whether client contact on the clarifications call and the migration is
  authorised**, by name, by Angelo Pastorelli or Gianpaolo Motta — the 24/11
  instruction covered the training proposals only (OI-375, OI-385).
- 🔴 **Gianpaolo Motta's ok or refusal on the production release** — never
  recorded at any point, even now that the release has happened (OI-381).
- 🔴 **Who may see the reports and dashboards**, and **whether the client tests
  them now that they are live** — asked 24/11, unanswered (OI-377, OI-381).
- 🔴 **The tranche report schedule**, due before month end — **five days**
  (OI-377, OI-381).
- ⚠ **Whether anything was deployed to Pienissimo Prod outside source control**
  on 23 or 24 November, which only an org inspection can answer.
- 🔴 **The PEC of 17 November itself** — its full text, its heads of claim and
  above all **the term it fixes under art. 1454 c.c.** — **and ROMI's own reply as
  sent**, with its despatch and delivery receipts. 🔑 **Now known not to be in
  this mailbox**, so ask Angelo Pastorelli, Elena Spini or Gianpaolo Motta for the
  PEC mailbox copy. **Fifth day.**
- 🔴 **The detailed rebuttal ROMI reserved**, and the Fase 2 chronology behind it.
- 🔴 **Any record of the 20/11 14:30 meeting**, and of the four private contacts
  with the client's direction (20/11, 23/11, 24/11 — a voice message — and
  Angelo Pastorelli's _"oggi la sento"_ outcome).
- 🔴 **A ruling on whether the scadenziario and the credit notes are Fase 1 or
  Fase 2**, before either is estimated. **Unmoved in five days.**
- 🔴 **Whether Anita Aga stays assigned to Pienissimo**, and **whether anyone
  above Aurel Mrruku knows** she is being offered elsewhere (OI-384).
- **Whether the calendar of next activities ROMI promised in its reply was
  actually handed over.**
- 🟢 ~~Daniela's surname from a primary source~~ — **attested 25/11** from the
  client mail directory. **Rebecca M's surname is still not** (OI-378).
- **Fabrizio Mastracci's scaletta** for the two training modules — an **eighth**
  window — **ROMI's training record** (dates, hours, attendees, recordings), and
  **whether the 19/11 test pack of mini-campaigns was ever sent** (OI-378).
- **The WhatsApp number, its block date and Meta's stated reason**, and who at
  Pienissimo is dealing with it (OI-382).
- **Whether no Biglietto from migrated data is correct or a defect**, with an
  owner (OI-373).
- ⚠ **What the two Slack audio messages of 20/11 morning say** — still not
  transcribable by this account.
- **The contract clause that makes reports and dashboards a deliverable**, quoted,
  and the contractual training provision behind the 20-hour figure (OI-377,
  OI-378) — **seventh day**, and now after the release.
- **Who may write to the client about anything other than training**, by name
  (OI-375, OI-381, OI-383, OI-385).
- **Whether the order PDF DocuSign configuration exists in production**, with a
  date and a name (OI-373, OI-374) — sixth day.
- **Whether any real WooCommerce order has ever been taken end to end in
  production** — sixth day, and Pienissimo Live has now run.
- **Whether a production quote PDF now prints an Italian date** (OI-358).
- **Whether the three Mexal schedulers in production run as `amministratore
  pienissimo`** (OI-301, OI-334), and **the written run instructions and the
  job-times mail to Sabatino Rinaldi** — seventh day (OI-370).
- **The restore date for the event end dates**, with an owner, after 309 ready
  invitations stayed silent through Pienissimo Live (OI-353).
- **Elena Spini's change workbook of 13/11** — an **eighth** window.
- **Whether ROMI accepts or contests the Blueprint claim** — **no reply in
  twenty days** (OI-343) — and `OP-1`, `OP-2`, `OP-4` of the R0 analysis, a
  twenty-second day.
- **Which articles the live WooCommerce shop sells**, set against those
  deactivated on 15/11, and whether the deferred retest ever passed (OI-366).
- **Leaving dates and successors for Marco Montesi and Sabatino Rinaldi** (OI-357).
- **Fabrizio Mastracci's go-ahead on the Pienissimo Live forms**, and **which
  field they write for the marketing consent** (OI-371, OI-340 — **eleventh
  window**), which the 4 December Modulo 2 session will train on.
- **The id-extraction date and format for Pienissimo Live attendance**, and the
  written specification Elisa Migliano asked for by mail (OI-361); **which event
  Andrea Parmeggiani's QR scanner will be ready for** (OI-323).
- **A list of the Aziende with more than one flagged principal contact** (OI-372).
- **Which cleanup option, A or B, for the 50,000 referenti leads** (OI-351), and
  **a corrected mail to the client** replacing the 11/11 approval (OI-352).
- **Whether `numero tranche` and `tipo biglietto` are now defined per article**
  (OI-329).
- **The contract with the missing third signature** (OI-336).
- **Whether the ticket flow's `Recipient_Contact__r` query was ever fixed** —
  unmentioned for a tenth window (OI-230).
- **The written production user list by role**, the marketing and Performance Plus
  profiles (OI-356, OI-363).
- **Whether the six tutors completed MFA/passkey enrolment** (OI-300).
- **The exact boundaries of Mexal's nightly maintenance window** (OI-334).
- **The picklist workbook** (OI-265, **thirty-second day**).
- **The Mexal WEBAPI credentials, the event list, the bundle-only article codes
  and the catalogue prices** — all four owed by mail; 🔑 **now searched against a
  working Gmail and confirmed absent.**
- **Whether Pienissimo holds a Zoho contract past 31 October** — **twenty-fifth
  run**, twenty-five days after the expiry date.
- **The twelve `PLUS_B` values** · **what `lead-web-to-lead (2).html` is** ·
  **whether the standing 30/07 marketing follow-up notes exist at all**.
- **Who created fields and changed a layout in Prod without telling anyone**
  (raised 13/11, never answered).

## Written back

- **1 new note, 1 new item id — [OI-385](../items/OI-385%20A%20scope%20perimeter%20call%20and%20a%20new%20migration%20are%20planned%20for%2030%20November.md).
  Next free is 386.**
- **8 notes updated** (`updated:` bumped to 2026-11-25): **OI-375**, **OI-376**,
  **OI-377**, **OI-378**, **OI-380**, **OI-381**, **OI-384**,
  [the Daniela Morgese person note](../people/Daniela%20Morgese%20-%20Pienissimo%20direction.md)
  and [the 20/11 meeting note](../meetings/2026-11-20%20INTERNA%20Check%20Report.md).
  **No status changes** — every item stays as it was. 🔑 **OI-381's `uncertain:`
  was rewritten**: the consent question is answered, and what remains unverified
  is client acceptance, the visibility decision and the tranche-report schedule.
  **OI-378's `uncertain:` was narrowed** to Rebecca M's surname alone.
- **MAP.md** — new nightly entry at the top, `Last updated` chain extended.
- **INDEX.md** — 7 item rows amended with the 25/11 state, 1 item row added
  (OI-385), 1 meeting row amended, 1 trace row added. Note count **650 → 652**.
- **`meetings/open-items.md` and `.it.md`** — **7 regenerated rows each** (#375,
  #376, #377, #378, #380, #381, #384) and **1 new row each** (#385), `Last
  touched` bumped in both.
- **`meetings/DEVELOPMENT-RECAP.md` and `.it.md`** — new **§89** in both.
- **This trace**, and a `JOURNAL.md` entry.
- **Register untouched — v1.6.**
- **No credentials, prices, article codes or personal data were copied.** ⚠ Two
  deliberate omissions: the name of the person who resigned on another project,
  and the Google Meet join links on the two calendar invitations.
