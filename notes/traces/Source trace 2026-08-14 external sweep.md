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
| **Gmail**  | ROMI mailbox, `pienissimo after:2026/08/06`, 30 threads | **9 threads**, 6 of them new material         |
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

## Still unreachable / still owed

- The **30 July marketing follow-up** notes — never circulated, still absent.
- **Listino 1 vs listino 2** — Mirko deferred to Fabrizio Paganelli; unanswered.
- The four client inputs of
  [OI-87](../items/OI-87%20Real%20catalogue%20prices%20still%20outstanding.md),
  [OI-46](../items/OI-46%20Bundle%20classification%20picklists.md) and
  [OI-48](../items/OI-48%20Bundle-only%20article%20codes.md) — restated as open
  point 10 in the Project Status document, still not delivered.
- **Rexhina's surname** — still recorded nowhere.
- The **Pienissimo UAT org** is not reachable from here; run `org-status-check`.
