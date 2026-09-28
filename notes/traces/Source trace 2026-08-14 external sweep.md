---
id: trace-2026-08-14-external
type: reference
status: active
updated: 2026-08-14
watermark_used: 2026-08-07
external_watermark: 2026-08-14
supersedes: trace-2026-08-14
---

# Source trace 2026-08-14 external sweep

**Watermark for the next `requirements-check` run: 2026-08-14.** This note
supersedes [the repository trace](Source%20trace%202026-08-14.md) of the same
day, which recorded a repo read only and moved no external watermark.

**Watermark used for this run: 2026-08-07** — the last Slack sweep. Not the
14 August repository trace, which states plainly that email, Slack and Drive
were not swept.

## Sources searched

| Source     | Account / scope                                       | Result                                        |
| ---------- | ------------------------------------------------------- | --------------------------------------------- |
| **Gmail**  | ROMI mailbox, `pienissimo after:2026/08/06`              | **9 threads**, 6 of them new material         |
| **Gmail**  | `pienissimo.com` / `pienissimo.pro` / `kreosoft.com` in from/to/cc, after 2026-08-06 | 6 threads, all a subset of the above |
| **Gmail**  | `from:fabrizio.p@pienissimo.com` after 2026-07-20        | 2 threads, both already held                  |
| **Gmail**  | `subject:("Lista Eventi" OR "Codici prodotto" OR "esempio Bundle")` | 3 threads — **surfaced the possible 07/08 delivery below** |
| **Slack**  | `#tproj-pienissimo` after 2026-08-06, sorted by time    | 1 message — Elena's 7 Aug status, 17:12       |
| **Slack**  | Workspace-wide incl. DMs and group DMs, after 2026-08-07 | 1 hit, **self-noise** — this job's own LIFE365 run report. No project material |
| **Drive**  | `fullText contains 'Pienissimo'`, modified after 2026-08-06 | **4 files**, 1 of them new                 |
| **Fathom** | All meetings created after 2026-08-06                   | 1 recording, **not this project** — see below |

All read-only. Nothing sent, shared, or marked read.

## Found and ingested

- **Mexal field mapping answered** — Andrea Di Cicco's workbook + 8 questions
  (07 Aug), forwarded by Fabrizio Paganelli to Kreosoft (10 Aug), **answered in
  full by Mirko Merendi with `Integrazioni pienissimo.xlsx` on 11 Aug**. Folded
  into [the Mexal integration](../flows/The%20Mexal%20integration.md) and
  [OI-58](../items/OI-58%20Mexal%20integration%20mechanics.md).
- **Four meetings scheduled** — 19 Aug marketing funnels, 20 Aug asset flow,
  25 Aug Anticipay, 27 Aug WooCommerce. Folded into OI-81, OI-82, OI-73, OI-49
  and [the calendar risk](../risks/Risk%20-%20the%20whole%20remaining%20build%20lands%20after%20Ferragosto.md).
- **`PIENISSIMO - Project Status.docx`** (Elena Spini, 06 Aug, emailed to
  Sabatino, Fabrizio, amministrazione and Marco the same morning). A
  **client-facing** consolidated decisions + open-points document with **its own
  numbering 1–15**, unrelated to the tracker's `#NN`. Do not conflate the two.
  Yielded [OI-88](../items/OI-88%20Zoho%20import%20template%20owed%20to%20Pienissimo.md),
  the `rinuncia al servizio` asset state, the coupon exclusion, and the
  Anticipay naming.
- **Two internal follow-ups cancelled** (10 and 17 Aug), cancelled on 07 Aug.

## Deliberately not ingested

- **Fathom, "Salesforce Practice Session" 06 Aug** — recorded by Aurel Mrruku
  with attendees at `@247.it` and others unconnected to this delivery. **A
  different client.** Not a missing project source.
- The **08-06 Gemini notes doc** and the **08-06 recording** — already held and
  drilled on 2026-08-07.
- Attachments were **not** opened: `Integrazioni pienissimo.xlsx` and the
  Mexal mapping workbook. Mirko's answers were taken from the mail body, which
  restates each one. Reading the workbooks is worthwhile before the build.

## Second pass, same day — full history from April

The first pass swept only from the 2026-08-07 watermark. A follow-up run
covered **everything from 2026-04-01**: Gmail (67 threads, two pages) and Drive
(the whole `[Pienissimo] Fase Progettuale` folder and both subfolders).

**There is no Pienissimo mail before 2026-06-24 in this mailbox.** Aurel Mrruku
was onboarded on 25 June — a Fathom recap that day is titled _"Onboard di Aurel
al progetto"_ — a month after the 27 May kickoff. **The pre-sales record is not
reachable from here**, which matters because
[the scope dispute](../risks/Risk%20-%20the%20phase%202%20scope%20dispute%20is%20unresolved.md)
turns on what was discussed _in fase di prevendita_. That evidence sits with
Elena Spini or Andrea Galotto.

### Documents read for the first time

| Document                                       | Yield                                                                    |
| ---------------------------------------------- | -------------------------------------------------------------------------- |
| `Pienissimo_Project Plan.pptx` (10 Jul)        | **Fine sviluppi Fase 1 = 10/09** and **go-live Fase 2 = 09/11**, neither recorded anywhere. Phase split of the integrations. |
| `Integrazione_Salesforce_WooCommerce.docx` (31 Jul) | Full mu-plugin source, URL anatomy, REST contract, and **five** points to agree — the records tracked two. |
| `Organigrammi Pienissimo (EV - SW) (APRILE 26).pdf` | The only April artifact. Yielded [G Lanzetti](../people/G%20Lanzetti%20-%20CEO%20of%20both%20Pienissimo%20companies.md), [Matteo Distaso](../people/Matteo%20Distaso%20-%20Pienissimo%20marketing%20lead.md), [Andrea Parmeggiani's employer](../people/Andrea%20Parmeggiani%20-%20Pienissimo%20Software%20maintenance%20manager.md), and corrected four titles. |
| `[Romi Tech] Questionario Startup` (25 May)    | **Blank template** — never filled in. Not a source of facts.               |

### Third pass — the client documents, the diagram, the attachment

- ✅ **`Salesforce - Requisiti e Domande per Elena (16-06-2026).pdf` drilled** —
  the richest single find of the sweep. Written up as
  [the client June requirements document](../The%20client%20June%20requirements%20document.md).
  It is the origin of _rinuncia al servizio_, it puts GLS/Teachable/Pienissimo
  Pro in writing on 11 June, and it yielded
  [OI-90](../items/OI-90%20Whether%20to%20introduce%20a%20Prospect%20state.md).
- ✅ **`[PIENISSIMO] - Interna Review Flussi` (16/07) located and opened** — doc
  `1o2nXG5mPbRm3UBWbYhyHqzk41TF03Sz3NGUrQOd0tAU`, 61k characters, ~95% verbatim
  transcript. Summary: bundle many-to-many, price calculation imported from
  Mexal, contract and payment tracking, and a candid internal discussion of
  workload sustainability. **Nothing in the summary contradicts the record**, so
  it was not drilled in full — if it is drilled later, treat it as a ROMI
  internal meeting, not a client session.
- ❌ **`PIENISSIMO - Flusso Lead-Opportunita.drawio` could not be opened.** Drive
  cannot render `application/vnd.jgraph.mxfile` as text. **Assessment: probably
  superseded, not missing.** It was created 10 July as a standalone lead-opty
  flow; `Flows & Objects.drawio` — last modified 6 August, pages LEAD-OPTY /
  Ordini / Flusso Biglietti — is the newer multi-page file, and the requirement
  register already carries the LEAD-OPTY state machine _"extracted verbatim from
  the diagrams"_. Worth one minute in draw.io to confirm; do not treat it as an
  open source in the meantime.
- ✅ **`Integrazioni pienissimo.xlsx` — resolved by the user.** No connected tool
  can reach it: Gmail exposes attachment **metadata** only and has no download
  tool; the file is in neither Drive nor Slack. **Aurel downloaded it manually**
  and it was parsed from `~/Downloads` on 2026-08-14. Contents folded into
  [the Mexal integration](../flows/The%20Mexal%20integration.md) and
  [OI-58](../items/OI-58%20Mexal%20integration%20mechanics.md); it produced the
  order-line gap in [OI-75](../items/OI-75%20Ticket%20availability%20rule.md).
  ⚠ It carries a **real customer registry record** as its worked example.
- ✅ **`Flows & Objects.drawio` — drilled.** Downloaded and inflated locally
  (drawio stores each page as deflate+base64 inside the mxfile, which is why
  Drive cannot render it as text). All three pages read; written up as
  [the newest design diagram](../The%20newest%20design%20diagram.md). **It is
  newer than the register believes** and contradicts the prose record in three
  places.

### Untraced sources found, not yet ingested

- **NotebookLM notebook "PIENISSIMO"**, shared by Elena Spini 25 June. An
  entire knowledge surface nobody has mentioned.
- **LastPass shared folder "PIENISSIMO"**, shared 25 June — where project
  credentials presumably live. Referenced in no note. Do not copy anything out
  of it; record only that it exists.
- `PIENISSIMO - Flusso Lead-Opportunita.drawio` (10 Jul, Elena) — **a third
  design diagram.** `README.md` and the requirement register name only two.
- `Salesforce - Requisiti e Domande per Elena (16-06-2026).pdf`
- `CRM_Workflow_Opty_Pienissimo_.pdf` (3 Jun) — the client's own opportunity flow
- `Pienissimo_Scheda di Partecipazione ai corsi_da firmare.pdf` — the paper
  participation form, directly relevant to
  [OI-78](../items/OI-78%20Participant%20data%20collection.md)
- `Tipologie Vendita.xlsx` / `.pdf` — the sales typology list
- ⚠ `SO_Ordine Nr. SO-72216 IT04451990982 - DUOMO 2.0 SRL.pdf` — **a real
  customer order with company name and VAT number**, in
  `01 Documenti forniti dal cliente/Documenti inviati ai clienti/`. Personal and
  commercial data: it must never reach `notes/` or [site/](../../site/).
- **Four ROMI-internal meetings with Gemini notes, never drilled**: 13/07 and
  03/08 Follow-up Interno, 16/07 Interna Review Flussi, 05/08 BBP Aurel/Elena.
- **A Salesforce sandbox exception of 17/07** →
  [OI-89](../items/OI-89%20BigliettoPdfQueueable%20callout%20error.md).

## Still unreachable / still owed

- The **30 July marketing follow-up** notes — never circulated, still absent.
- **Listino 1 vs listino 2** — Mirko deferred to Fabrizio Paganelli; unanswered.
- ⚠ **A message that may contain two of the owed client inputs is not
  retrievable from this mailbox.** On 2026-08-07 12:17 CEST Fabrizio Paganelli
  wrote to a thread titled **"Lista Eventi, Codici prodotto, esempio Bundle"**;
  Elena Spini replied 21 minutes later — _"Grazie Fabrizio, aggiungo anche Aurel
  al thread."_ His message survives only as an **empty quoted stub** inside her
  reply, consistent with content carried as an attachment, and does not appear
  under a `from:` search. **Do not record
  [OI-46](../items/OI-46%20Bundle%20classification%20picklists.md) or
  [OI-48](../items/OI-48%20Bundle-only%20article%20codes.md) as delivered or as
  outstanding until someone opens that thread in the mail client.**
- [Real catalogue prices](../items/OI-87%20Real%20catalogue%20prices%20still%20outstanding.md)
  are **not** named in that thread's subject and remain outstanding — restated
  as open point 10 in the Project Status document.
- **Rexhina's surname** — still recorded nowhere.
- The **Pienissimo UAT org** is not reachable from here; run `org-status-check`.
