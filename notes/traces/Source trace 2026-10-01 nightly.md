---
id: trace-2026-10-01-nightly
type: reference
status: active
updated: 2026-10-01
watermark_used: 2026-09-30T22:00Z
external_watermark: 2026-10-01T22:00Z
account: a.mrruku@romicompany.com
---

# Source trace 2026-10-01 nightly

**Watermark for the next `requirements-check` run: 2026-10-01T22:00Z, single value.**

**Watermark used: 2026-09-30T22:00Z**, the `external_watermark` stated by
[the 30/09 nightly trace](Source%20trace%202026-09-30%20nightly.md). Scheduled
nightly run, executed 2026-10-01 ~22:00Z. One day, no gap.

🔴 **No client meeting today.** Three ROMI-internal sessions and a single
outbound mail. The client's entire participation was receiving it.

⚠ **Environment note, fifth run in a row.** The clone opened on **`main` only** —
the 17-file scaffold at `279783d`, no `AGENTS.md`, no `notes/`, and `DevMain` not
even present as a remote ref. `git fetch origin DevMain` then
`git checkout -B DevMain FETCH_HEAD` recovered the project in under a minute.
**Fifth consecutive prediction paid off. Fetch before concluding anything about
an empty-looking repository.**

## Sources searched

| Source | Query / scope | Result |
| ------ | ------------- | ------ |
| **Fathom** | `list_meetings created_after 2026-09-30T22:00Z`, summaries + action items, 3 pages | **0 meetings** — **eighth** consecutive run with nothing. All three of today's sessions exist only as Google Meet artifacts |
| **Gmail** | `pienissimo after:2026/09/30 -in:draft`, 40 requested, 8 estimated | 🔑 **Elena Spini's 18:25Z mail to the client** · a 17:41Z updated invitation moving the PROD check to 05/10 10:00 · an 08:46Z Meet-records mail for `PIENISSIMO - Interna` · an 08:00Z invitation for it · a sandbox matching-rule notice · the rest pre-watermark and already held |
| **Gmail** | `(from/to/cc:pienissimo.com OR ROMI-PIENISSIMO OR kreosoft OR pienissimo.pro) after:2026/09/30 -in:draft` | **2 threads**, one of them the 18:25Z mail, read in full. 🔴 **No inbound client mail** — the thread is outbound only and **no reply had arrived by the sweep** |
| **Drive** | `modifiedTime > '2026-09-30T22:00:00Z'`, **2 pages, 30 files** | 🔑 **both versions of the logic document** · 🔑 the `PIENISSIMO - Interna` transcript · 🔑 the `PINEISSIMO - Pre UAT` Gemini notes · ⚠ `Campi Oggetti, Flussi e Utenti Salesforce - Pienissimo.xlsx` **moved 14:31:17Z** · ⚠ `Business_Blueprint_Pienissimo.docx` **moved 16:05:16Z**, first movement since 24/09 · ⚠ `Integrazioni pienissimo.xlsx` moved 08:14:58Z · rest are other clients (Daze, BE.MA, 247, Piemontese, CAROL, Vision, TFP) — ignored per the skill |
| **Drive** | `read_file_content` on `1p4W9ekBWZbVMh0ts6ui_xSIwOHZLMG4z` | 🔑 **the client version of the logic document, read in full** |
| **Drive** | `read_file_content` on `1IR2YtSzZfyfqOZalzQVpNkKSFiNuRa7f` | 🔑 **the internal version, read in full** — carries two sections the client's copy does not |
| **Drive** | `read_file_content` on `1q4xRQP3A1o4X-jR3XoD1XzpeWu3dV3EMEXWJ3-4u0O4` | 🔑 **the 01/10 Interna transcript, read in full** |
| **Drive** | `read_file_content` on `1jof6luS1L0nM0jbv_CHPsuwU9vZahsEsVrl525AjoJo` | 🔑 **the Pre UAT Gemini notes, 82,189 characters** — summary, decisions, next steps and the full `Dettagli` section read; the verbatim transcript below them was not needed |
| **Slack** | `slack_read_channel C0BQD34LLF4` (dev group), from 30/09 22:00Z | **1 message — this procedure's own 30/09 report.** 🔴 **No human reply to any nightly report: fifteen nights** |
| **Slack** | `slack_read_channel C0B5T3RB4FM` (`#tproj-pienissimo`), from 30/09 22:00Z | **0 messages** — third consecutive silent day |
| **Slack** | `slack_read_channel C0C38JJ9D1T` (the marketing group DM), from 30/09 22:00Z | 🔑 **7 messages, 09:03–12:23 CEST** — Elena Spini's _"il giro NON mi torna"_, the request for the call, the internal document link, and the decision to strip two sections from the client's copy |
| **Git** | `fetch origin --prune`, `log --all --since 2026-09-30T22:00:00Z` | 🔑 **7 commits**; `DevMain` advanced `39924f5` → **`618e646`** via PRs **#72**, **#73** and **#74** |
| **Repo** | `Product_Category_Rule__mdt` definition, fields and both records; `Asset`/`Order` field listings; `AssetStatus.standardValueSet`; `git log --diff-filter=A` on four fields; grep for the send flags; `QuoteManageProductsController.cls` lines 690–800; `ParticipantRegistrationController.cls` | 🟢 **OI-188 is built** · 🔴 **the send fields are split across `Asset` and `Order`** · 🔴 `Inviato` absent, consistent with its withdrawal · 🔴 still no tranche field on `Asset` |

## Found

1. 🔑 **[The agreed Asset and ticket send logic document](../The%20agreed%20Asset%20and%20ticket%20send%20logic%20document.md)** —
   the specification [OI-197](../items/OI-197%20The%20ticket%20send%20flag%20and%20the%20Inviato%20asset%20state%20are%20agreed%20and%20unbuilt.md)
   was deferred on. **It exists, and it went to the client at 18:25Z** with a
   request for written confirmation of the logics. **Both versions read in full.**
2. 🔑 **[2026-10-01 Interna](../meetings/2026-10-01%20Interna.md)** (10:01 CEST,
   40m29s, Aurel Mrruku · Elena Spini), drilled from the full transcript. The
   line-by-line review that produced the document.
3. 🔑 **[2026-10-01 Pre UAT](../meetings/2026-10-01%20Pre%20UAT.md)** (17:10 CEST,
   ~1h33m, Aurel Mrruku · Elena Spini · Anita Aga · Rexhina Hysi), drilled from
   the Gemini notes. A bundle driven end to end in the sandbox.
4. 🔴 **New: [OI-199](../items/OI-199%20The%20ticket%20send%20flag%20fields%20are%20split%20across%20Asset%20and%20Order.md)**
   (gating) — the three send fields built across two objects, six hours after the
   document named them and left the object question open. **The agreed Marketing
   Cloud query cannot be run, and an order-level boolean cannot record a
   per-participant send.** The internal review predicted it in writing the same
   morning.
5. 🔴 **New: [OI-200](../items/OI-200%20The%20client%20was%20asked%20to%20confirm%20logics%20whose%20open%20points%20were%20removed.md)**
   — the client's copy drops the seven points headed `Open point da confermare con
   il cliente` along with the internal problems table. 🟢 Removing the problems
   table is correct; removing the client's own questions is not.
6. 🔴 **[OI-74](../items/OI-74%20Asset%20state%20machine.md): `Inviato` is
   withdrawn**, one day after the Post UAT agreed it, between the same two people,
   and **neither named it as a reversal**. `AssetStatus` stays at seven values.
7. 🔑 **[OI-75](../items/OI-75%20Ticket%20availability%20rule.md): `Rinuncia` is
   per edition** — third granularity in three days — and **chronological tranche
   sequencing** is new in writing. ⚠ The sequencing is attributed to Pienissimo
   with **no meeting or date cited**, and this sweep found no source for it.
8. 🟢 **[OI-188](../items/OI-188%20Performance%20Plus%20products%20are%20identified%20by%20the%20Mexal%20article%20category.md)
   is built and merged** — `Product_Category_Rule__mdt` driving the product picker
   from configuration rather than code, PR #72. ⬛ **This is the `4f672a2` diff
   flagged last night, and it serves OI-188, not
   [OI-96](../items/OI-96%20Edition%20mapping%20table%20on%20Salesforce.md).**
9. 🔴 **[OI-96](../items/OI-96%20Edition%20mapping%20table%20on%20Salesforce.md):
   competenza ranges may not overlap between sibling editions**, established by a
   live sandbox error. ⚠ The year-boundary mitigation — widening the ranges —
   collides with that constraint and is enforced by nothing.
10. 🟢 **[OI-177](../items/OI-177%20The%20marketing%20flow%20UAT%20needs%20production.md):
    two dated commitments** — production over the weekend 03–04/10, and a
    four-hour end-to-end check **Thu 08/10 10:00–13:00**. ⚠ Two days after
    go-live. Aurel Mrruku's spec for Fabrizio Mastracci is now **due 02/10**.
11. 🔴 **A third asset silently failed to generate** on a clean test bundle at the
    Pre UAT. No cause established and no item raised in the room; recorded in the
    meeting note.
12. ⚠ **The negative-discount restriction was removed.** A control taken out, with
    no compensating check discussed and nothing in the record saying the client
    asked for it.
13. ⚠ **[OI-194](../items/OI-194%20The%20ticket%20is%20a%20signed%20participation%20document%20not%20just%20a%20QR%20code.md)
    and [OI-195](../items/OI-195%20WhatsApp%20sends%20imply%20a%20mobile%20community%20that%20was%20never%20designed.md)
    went undiscussed for a third consecutive day.** Both gating. ⚠ And the new
    filename-prefix contract for the ticket PDF compounds OI-194: the send picks a
    document off the asset **by name**.

## The register

**Amended? No. Version stays 1.6.**

Nothing today came from the client. The logic document is ROMI's statement of what
it believes was agreed, **sent out for confirmation that had not arrived by the
time of this sweep**. Writing it into `REQUISITI.it.md` — the text the client signs
— before that reply exists would be recording ROMI's own account as the client's
agreement.

[OI-184](../items/OI-184%20Register%20v1.6%20goes%20to%20the%20client%20as%20one%20change%20set%20at%20UAT%20close.md)
remains the mechanism, and the document is now the natural carrier for the v1.6
change set. 🔴 `DIV-07` remains open.

⚠ **`Inviato`'s withdrawal confirms the 30/09 decision not to amend on it.** Last
night's trace excluded it from the change set because an eighth state from an
internal session is weaker evidence, not stronger. It was gone within a day.

## Not done in this run

- The org was **not** opened. `STATUS.md` was not regenerated and the Notion mirror
  stays stale. Every build claim is repository arithmetic against `DevMain`
  `618e646`.
- **No Apex test was written, proposed or scaffolded**, per the standing
  instruction. [OI-64](../items/OI-64%20The%20bundle%20Apex%20test%20suite%20is%20broken.md)
  and [OI-66](../items/OI-66%20No%20test%20classes%20for%20the%20Biglietto%20stack.md)
  were not touched; nothing this sweep saw changed their state.
- No transcript was copied into `meetings/`; no per-meeting recap in
  `meetings/results/`.
- `npm run prettier:verify` was not run (no `node_modules`), so tonight's markdown
  is unformatted.
- **The verbatim transcript inside the Pre UAT notes was not read** — the summary,
  decisions, next steps and full `Dettagli` section were sufficient and are
  timestamp-linked.
- **`eee1788` (Anita Aga, _"Mexal and Woocommerce automations"_, PR #74, 18:52
  CEST) was not diffed.** It merged four minutes before `DevMain`'s head and
  touches the Mexal and WooCommerce paths. ⚠ **Worth a diff next run.**

## Still unreachable

- **`Flows & Objects.drawio`** — ⚠ **it did not move today**, after five
  consecutive days of movement. Still an `mxfile` the Drive reader cannot parse,
  and still the only picture of the flows. Ask Elena Spini for a PNG or PDF export.
- **`Campi Oggetti, Flussi e Utenti Salesforce - Pienissimo.xlsx`** — **moved
  14:31:17Z**, the first movement this sweep has recorded for it. **Not opened.**
  It is named in the skill as a standing target and it is the field-level
  companion to the blueprint; given OI-199 turns on which object carries three
  fields, ⚠ **this file may hold the answer and nobody has read it.**
- **`Business_Blueprint_Pienissimo.docx`** — **moved 16:05:16Z**, first movement
  since 24/09, on the day Aurel Mrruku took the blueprint's edition-mapping
  section as an action item. **Not opened.** Drive id
  `1oa5iIHxu86wx6v7qZaBjM7g5Sk7bmuK9`.
- **`Articoli Salesforce.xlsx`** — **did not move** since 30/09 12:45:55Z. Still
  not opened, and still the one-minute answer to whether the Plus tranche-count
  codes exist. **Performance Plus UAT is 05/10.**
- **`Campagne Salesforce.xlsx`** — did not move. Still not opened.
- **`Testbook_UAT_Lead_Opportunita_2026-09-24_v2_1.xlsx`** — **did not move**, a
  second consecutive run. Still the one artifact that would show whether the
  client has responded; approval due ~13/10.
- **The full text of `Pienissimo_Scheda di Partecipazione ai corsi_da firmare.pdf`**
  — not opened; its seven enrolment pages may carry personal data. ⚠ **Nobody has
  read it properly, OI-194 is gating, and it is now implicated in the filename
  contract.**
- **The client's reply to the 18:25Z mail** — **does not exist yet**. The whole of
  [OI-200](../items/OI-200%20The%20client%20was%20asked%20to%20confirm%20logics%20whose%20open%20points%20were%20removed.md)
  waits on it.
- **The 30/07 marketing notes**, standing.
- **The 12:30 CEST internal call of 25/09** — still no artifact, sixth run.
- ⚠ **The Pienissimo lead documentation** Elena Spini said she owed on 28/09.
  Unresolved; not raised today.

**Nothing 404'd.**

## Absence of evidence, stated as absence

- **Fathom has returned nothing for eight consecutive runs.** All three of today's
  sessions exist only as Google Meet artifacts. A pattern about the tooling, not
  about the project.
- **No sandbox exception mail arrived in this window**, a second consecutive day.
  That is still not evidence the edition mapping is fixed — but ⚠ the Pre UAT
  **did** reproduce a mapping failure live, on a 2027-dated campaign, so the
  mechanism is confirmed still broken by observation rather than by mail.
- **No client reply.** Absence of a reply four hours after a mail sent at 18:25Z
  is not a finding about the client; it is recorded so the next run knows the
  confirmation was outstanding at this watermark.
- ⚠ **"Claudio" is unresolved.** Elena Spini twice credits work to that name and
  no person note, attendee list or mail address in the swept sources matches it.
  **No person note was created and nothing was attributed.**
