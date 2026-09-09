---
id: trace-2026-09-08-nightly
type: reference
status: active
updated: 2026-09-08
watermark_used: 2026-09-07T22:00Z
external_watermark: 2026-09-08T22:00Z
account: a.mrruku@romicompany.com
---

# Source trace 2026-09-08

**Watermark for the next `requirements-check` run: 2026-09-08T22:00Z.**

**Watermark used for this run: 2026-09-07T22:00Z** — the `external_watermark` of
[the 07/09 trace](Source%20trace%202026-09-07.md), which is also the newest note in
this folder by `updated:`. Frontmatter and text agree; no disambiguation was
needed.

The window is **8 September**. Everything below is that day.

⚠ **The clone again arrived single-branch on `main`**, which holds two commits and
no vault — the third consecutive run. `git fetch origin` then
`git checkout DevMain` recovers it. **This is the norm for this environment, not
an incident.** A run that finds `AGENTS.md` missing is on the wrong branch.

## Sources searched

All read-only. **Nothing was sent, replied to, drafted, shared, modified or marked
read**, with the single carve-out of the nightly report to `C0BQD34LLF4`.

| Source     | Query / scope                                                                                                                    | Result                                                                                                                                                                              |
| ---------- | -------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Gmail**  | `pienissimo after:2026/09/07 -in:draft`, 50-thread page                                                                          | 16 threads, **9 new**                                                                                                                                                               |
| **Gmail**  | all mail `after:2026/09/07 -in:draft`, 50-thread page                                                                            | 36 threads. The rest are Permo/Zucchetti, Interstudio Viaggi, BIT MOBILITY, a Workspace 2FA notice, a Salesforce certificate-expiry alert, Teatro Franco Parenti and marketing spam |
| **Gmail**  | thread `1a0815f9a43d3b87` — `Stato Avanzamento Progetto`                                                                         | **read in full — the run's headline**                                                                                                                                               |
| **Gmail**  | thread `1a043980228178d5` — `Integrazione woo commerce - salesforce`                                                             | **read in full**; the 08/09 sent message and its Postman attachment                                                                                                                 |
| **Gmail**  | threads `1a080cb4676a4dc5`, `1a0812d2ace0e7df` — Gemini notes for Parte 4 and Flussi MKT Parte 2                                 | identified; content read from the Drive documents instead                                                                                                                           |
| **Gmail**  | `1a080c204a545af7`, `1a080c61ffc65778`, `1a080c6dd7758f9b` — Parte 5 and Parte 6 invitations                                     | read from search metadata: dates, times, focus, invitee lists                                                                                                                       |
| **Gmail**  | `1a0811c06b71004b`, `1a0811b35555a77a` — the two `[TEST]` email forwards                                                         | identified; **the PDFs were not opened**                                                                                                                                            |
| **Drive**  | `modifiedTime > 2026-09-07T22:00:00Z`, paged twice                                                                               | 33 items, **13 Pienissimo**                                                                                                                                                         |
| **Drive**  | `Pienissimo_Project Plan 2.pptx` `1tIjf-PQNgqIxnzJxsb5cTcDcPdfFuISE`                                                             | **read in full — the timeline and Slide 4's Fase 1/Fase 2 split**                                                                                                                   |
| **Drive**  | Gemini doc `1yH35OnOYKOCN7I6Z4o4GjDeIwcAkOaLPVgS9XHZkRao` (Parte 4)                                                              | **read in full — summary, 6 `Concordato` + 1 `Da approfondire`, 13 next steps, 13 detail bullets and the complete 1h25m58s transcript**                                             |
| **Drive**  | Gemini doc `1_1hR-qPfRbLk8Bgx7bKvcoP5linsOa0R36D8RK4sMVk` (Flussi MKT Parte 2)                                                   | **read in full — notes and the complete 42m21s transcript**                                                                                                                         |
| **Drive**  | `SEGMENTI FUNNEL BIGLIETTI.docx`, `FUNNEL RICHIESTA ISCRIZIONE TITOLARE.docx`, `FUNNEL INVIO BIGLIETTO COMPILATO.docx`           | **all three read**; two are effectively empty as text                                                                                                                               |
| **Slack**  | workspace-wide incl. private channels, DMs and group DMs, `pienissimo after:2026-09-07`                                          | 6 hits, **all new**                                                                                                                                                                 |
| **Slack**  | `#tproj-pienissimo`, `after:2026-09-06`                                                                                          | **0 results** — silent for a second week                                                                                                                                            |
| **Slack**  | group DM `C0BQD34LLF4` — the org-status-check post of 16:31–16:39 CEST and its thread continuation                               | **read in full** from the search result                                                                                                                                             |
| **Slack**  | group DM `C0BFDNXQKAS` (Aurel Mrruku, Andrea Di Cicco, Elena Spini)                                                              | **read in full** — the pre-send check of the client mail                                                                                                                            |
| **Slack**  | DMs `D0B5QHS2T7H` (Elena Spini) and `D0AQ0FMHFM1` (Andrea Di Cicco)                                                              | **read in full** — the WooCommerce reminder and the collection request                                                                                                              |
| **Git**    | `git log`, `git show --stat` on `DevMain`                                                                                        | one new commit + merge, **`c877631`** / PR **#35**, 34 files                                                                                                                        |
| **Repo**   | `AGENTS.md`, `MAP.md`, `INDEX.md`, the write protocol, the 07/09 trace, the skill, OI-123/124, the register's go-live references | read directly                                                                                                                                                                       |
| **Fathom** | `list_meetings` from 07/09, 3 pages                                                                                              | **0 meetings.** Consistent with 03/09, 04/09 and 07/09 — an absence, not a gap                                                                                                      |

## Found

### 1. 🔴 Go-live is 21 October, and it corrects the 07/09 record

`[ROMI-PIENISSIMO] - Stato Avanzamento Progetto`, 14:15Z, Elena Spini to four
client addresses. **Go-live 21 October**, UAT ready 23/09, UAT 23/09–13/10,
approval 13/10, **Fase 2 out of perimeter**, four blocking decisions, and a
request for written acknowledgement
([the decision](../decisions/Decision%20-%20go-live%20moves%20to%2021%20October%20and%20Fase%202%20is%20declared%20out%20of%20perimeter.md)).

✅ **The 07/09 "21 September / 13 September" were 21 and 13 October** with the
month dropped from Gemini's `Concordato` paraphrase.
[OI-124](../items/OI-124%20Go-live%20moved%20from%206%20to%2021%20October.md)
is rewritten and renamed; the 07/09 note's refusal to act on an unreconcilable
reading was correct.

🔴 **The register was left at 6 October deliberately** — the date is proposed, not
accepted. That is
[OI-128](../items/OI-128%20Client%20confirmation%20of%20the%2021%20October%20plan%20and%20the%20Fase%202%20perimeter.md).

### 2. 🟢 Data Model Parte 4 gave the locale a home, and it was built the same day

Client-facing, 12:01 CEST, **1h25m58s**
([the minute](../meetings/2026-09-08%20Data%20Model%20Parte%204.md)). **Locali are
Account children of the billing company; only parents go to Mexal.** That
**resolves [OI-123](../items/OI-123%20The%20Zoho%20questionnaire%20fields%20have%20no%20home.md)**
— and cheaply, with a record type rather than the new object it feared.

Also: contracts and tickets to the billing company's principal only; duplicate
control moves to the Lead on **email AND phone in combo**; the Opportunity field
list cleaned; **Parte 5 (16/09) and Parte 6 (18/09)** booked at two hours each.

New: [OI-129](../items/OI-129%20The%20locale%20questionnaire%20field%20list%20and%20the%20locale%20API.md) ·
[OI-130](../items/OI-130%20The%20opportunity%20category%20and%20subcategory%20dependency%20matrix.md) ·
[OI-131](../items/OI-131%20The%20lead%20origin%20picklist%20values.md) ·
[OI-132](../items/OI-132%20Whether%20the%20quote%20contact%20search%20can%20include%20child%20locale%20contacts.md).

### 3. 🔴 A sandbox password was read aloud into a Gemini transcript

In [Flussi MKT Parte 2](../meetings/2026-09-08%20Flussi%20MKT%20Parte%202.md),
Elena Spini spoke Aurel Mrruku's UAT sandbox password to unblock One Password and
Fabrizio Mastracci signed in **as Aurel Mrruku**
([the risk](../risks/Risk%20-%20a%20sandbox%20password%20was%20spoken%20aloud%20and%20preserved%20in%20a%20meeting%20transcript.md)).
**The value is not in this repository.**

The same session put **`data evento` and `data invio` on the invitation record**,
completed the **four-member tag vocabulary** including `<EVENT>_R` for rinuncia,
and established that **the marketing flows cannot be tested end to end**
([OI-134](../items/OI-134%20The%20marketing%20flows%20cannot%20be%20tested%20before%20a%20production%20release.md)).
New: [OI-133](../items/OI-133%20The%20WhatsApp%20templates%20are%20missing%20from%20the%20marketing%20material.md).

### 4. ✅ The WooCommerce collection reached Sabatino Rinaldi

14:17Z, twelve days after his side was ready, after a Slack reminder from Elena
Spini ([OI-102](../items/OI-102%20Salesforce%20endpoint%20and%20token%20for%20the%20WooCommerce%20plugin.md)).
🔴 **The credentials were not rotated first.** ⚠ A newer collection exists and
this is not it.

### 5. ⚠ An org check ran, published nothing, and was overtaken by a merge

16:31–16:39 CEST, full scope, report mode, live UAT versus `c81578f`. Its
**org-only drift findings were committed at 17:53 and merged at 18:21** — `c877631`
/ PR #35. _An org check is a photograph of a moving branch._ Second time this
lesson has landed, after 04/09.

Standing findings folded in: **40 of 43** products without an active edition
mapping (correcting 226/229), **0 of 32** order lines with a tranche, **0 Assets
with a QR value**, the Anticipay notification still hardcoded, **zero Flows**, and
coverage at **0 of 2,957 lines**.

### 6. ⚠ Mail and Drive in the window that is not this project's

- **Permo / Zucchetti** — a long thread on search-key columns, two Gemini docs,
  and two sessions. **Not ingested.**
- **Interstudio Viaggi**, **BIT MOBILITY**, **Teatro Franco Parenti** (`[TFP] Data
Model CRM`, 10:01 CEST), **Daze**, **ROMI BE.MA onboarding**, a **Workspace 2FA
  notice** effective 8 September, a **Salesforce certificate-expiry alert** for a
  BIT MOBILITY sandbox, and marketing spam. **None ingested.**
- ⚠ **`Stima Task`** (`d.losco@romicompany.com`, modified 12:40Z) — **not opened,
  not attributed**, for the second run.

## What it changed

**Eleven notes created, thirteen updated, one renamed.**

| Written                                                                            | Because                                                  |
| ---------------------------------------------------------------------------------- | -------------------------------------------------------- |
| `Source trace 2026-09-08`                                                          | **new** — this note                                      |
| `2026-09-08 Data Model Parte 4`                                                    | **new** — the minute, from the full transcript           |
| `2026-09-08 Flussi MKT Parte 2`                                                    | **new** — the minute, from the full transcript           |
| `Decision - go-live moves to 21 October and Fase 2 is declared out of perimeter`   | **new**                                                  |
| `Risk - a sandbox password was spoken aloud and preserved in a meeting transcript` | **new**                                                  |
| `OI-128` … `OI-134`                                                                | **new** — seven rows                                     |
| `OI-124`                                                                           | **renamed and rewritten** — 21 October, not 21 September |
| `OI-123`                                                                           | **resolved** — the locale is an Account record type      |
| `OI-102`                                                                           | the mail was sent, unrotated                             |
| `OI-111`, `OI-14`                                                                  | escalated to the client as blocking                      |
| `OI-24`, `OI-99`                                                                   | Parte 4 ran; Parte 5 and 6 booked; migration in stand-by |
| `OI-81`, `OI-126`                                                                  | the tag vocabulary and the funnel exit rule              |
| `OI-83`                                                                            | the perimeter is stated; the estimate still is not       |
| `Decision - Account record types split Azienda and Locale`                         | client corroboration, and built                          |
| `Proposed event invitations for participant registration`                          | two date fields agreed                                   |
| `Risk - the phase 2 scope dispute is unresolved`                                   | stated to the client in writing                          |
| `Risk - the whole remaining build lands after Ferragosto`                          | the calendar was re-cut                                  |
| `Risk - production deploy is blocked by Apex coverage`                             | 0 of 2,957                                               |
| `MAP.md`, `INDEX.md`                                                               | the live position and the new notes                      |

Also: rows **128**–**134** plus corrected rows **123** and **124** in
`open-items.md` **and** `.it.md`; a new **§31** in `DEVELOPMENT-RECAP.md` **and**
`.it.md`.

**No requirement changed.** `CTX-02` and the eight other 6 October references were
left alone deliberately — see OI-124 and OI-128. This is the second consecutive
run to leave them, and the reason has changed: on 07/09 it was that the decision
was internal; now it is that the client has been asked and has not answered.

## Deliberately not done

- **No mail was sent, no message replied to, nothing marked read**, with the
  single carve-out of the nightly report to `C0BQD34LLF4`.
- **No credential, token, price, VAT number, codice fiscale, IBAN, PEC or personal
  name from a customer record was written into the repository.** In particular
  **the sandbox password spoken in the 08/09 session is not recorded anywhere
  here** — only that it happened, where it now lives, and what to do about it.
- **No Apex test class was written or proposed.** The coverage record carries the
  org's 0-of-2,957 figure and nothing more.
- **The org was not opened.** `STATUS.md`, its Notion mirror and the Flows page are
  owed for a **ninth** run and remain `org-status-check`'s to produce — sharpened
  again by a check that ran today and published nothing.
- **The `.drawio` was not decoded.** It moved a **seventh** time, at 10:56:52Z. The
  reader still cannot render the format
  ([the master](../The%20newest%20design%20diagram.md)).
- **The workbook's 11:18:29Z save was not opened.** The Parte 4 transcript covers
  the same ground; a change made outside the session would not have been seen.
- **The two `[TEST]` email PDFs and the funnel screenshots were not opened.** The
  funnel logic in those images is **not** in this record.
- **Nothing in `c877631` was changed**, and the Notion access request
  ([OI-122](../items/OI-122%20An%20external%20address%20requested%20access%20to%20the%20internal%20status%20page.md))
  is still unanswered after four days.

## Gaps in this run

- 🔴 **The client has not answered.** The date, the perimeter and four blocking
  decisions all hang on one unreplied mail.
- 🔴 **UAT is fifteen days away and no UAT has ever been run.** Two statements made
  two hours apart on the same afternoon contradict each other and nobody
  reconciled them.
- ⚠ **`MAP.md` is 93 KB against its own stated 5 KB budget.** The file says "keep
  under 5 KB; if it grows, move detail into a note and link it." It has been over
  budget for weeks and no run has addressed it. **It is now the most expensive
  "cheap" file in the repository** and `INDEX.md` still prices it at ~1.1k.
- ⚠ **The funnel specification is in screenshots nobody has read**, including this
  run. Two of the three funnel documents are titles.
- ⚠ **The landing-page and hidden-field sheet was not opened again**
  (`1KPZ8pwEg3FFyXDdKu-gkXPtI13Yb5fGi`), for the second run. Eighteen days overdue.
- ⚠ **`Stima Task` still unattributed**, second run.
- ⚠ **Nothing was verified against the org.** Every build claim here is the
  repository or ROMI's own posted check.

## Method notes

**Diff `DevMain` before believing a drift finding.** For the second time in five
days an org check's "org-only" list was closed by a commit that landed hours
later — 04/09 from the other direction, today by ninety minutes. The check is
honest; the branch moves under it. **Check `git log` for the window before
reporting drift.**

**A machine paraphrase can drop a unit and stay plausible.** Gemini's `Concordato`
list rendered "21 ottobre" and "13 ottobre" as "21 settembre" and "13 dello stesso
mese", producing a reading that was internally consistent, contradicted the
register, and pointed the wrong way. The 07/09 run caught the contradiction
without being able to resolve it, and wrote _ask, do not infer_. **That is the
behaviour to repeat: a paraphrase that cannot be reconciled is a flag, not a
fact.**

**Read the client-facing artifact, not only the meeting note.** The plan deck
settled in one line what two sessions of internal notes could not, and it also
volunteered a fact nobody had written down — that Anticipay is "ex CreditSafe".
