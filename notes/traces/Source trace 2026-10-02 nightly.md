---
id: trace-2026-10-02-nightly
type: reference
status: active
updated: 2026-10-02
watermark_used: 2026-10-01T22:00Z
external_watermark: 2026-10-02T22:00Z
account: a.mrruku@romicompany.com
---

# Source trace 2026-10-02 nightly

**Watermark for the next `requirements-check` run: 2026-10-02T22:00Z, single value.**

**Watermark used: 2026-10-01T22:00Z**, the `external_watermark` stated by
[the 01/10 nightly trace](Source%20trace%202026-10-01%20nightly.md). Scheduled
nightly run, executed 2026-10-02 ~22:00Z. One day, no gap.

🔑 **A client session, two internal sessions and four client mails.** The busiest
day of client contact in a week, and the day the client first pushed back in
writing.

⚠ **Environment note, sixth run in a row.** The clone opened on **`main` only** —
the 17-file scaffold at `279783d`, detached HEAD, no `AGENTS.md`, no `notes/`, and
`DevMain` present only as a remote ref. `git checkout -B DevMain origin/DevMain`
recovered the project in seconds. **Sixth consecutive prediction paid off.**

## Sources searched

| Source | Query / scope | Result |
| ------ | ------------- | ------ |
| **Fathom** | `list_meetings created_after 2026-10-01T22:00Z`, summaries + action items, 3 pages | **0 meetings** — **ninth** consecutive run with nothing. All three of today's sessions exist only as Google Meet artifacts |
| **Gmail** | `pienissimo after:2026/10/01 -in:draft`, 40 requested, 17 estimated | 🔑 **the Blueprint delivery thread (3 messages, read in full)** · 🔑 **the Kreosoft `Ordine cliente` thread (read in full)** · the `Form Pienissimo` thread · six calendar mails · Gemini notes for the client UAT · a sandbox quote-acceptance notice |
| **Gmail** | `(from/to/cc:pienissimo.com OR ROMI-PIENISSIMO OR kreosoft OR pienissimo.pro) after:2026/10/01 -in:draft` | **9 threads, nothing new beyond the above.** 🔑 **The 18:25Z logic-document thread still holds exactly one message** — the client never replied on it |
| **Gmail** | `get_thread` on `1a0fce6a8bb04fdb`, `1a0c9d4a7c6c7850`, `1a0fbfeb6e5e2a38`; `get_message` on the 07/10 invitation | 🔑 **the client's objection, Elena Spini's reply, Mirko Merendi's `P`/`E` answer, Matteo Distaso's form priorities, and the full 07/10 UAT agenda** |
| **Drive** | `modifiedTime > '2026-10-01T22:00:00Z'`, **2 pages, 30 files** | 🔑 three meeting artifact sets · 🔑 `Business_Blueprint_Pienissimo.docx` **modified 13:52:42Z**, three minutes before the mail · ⚠ `Campi Oggetti, Flussi e Utenti Salesforce - Pienissimo.xlsx` **modified 15:04:11Z**, second consecutive day · rest are other clients (Daze, Vision, 247, Axis, Casette, Permo) — ignored per the skill |
| **Drive** | `read_file_content` on `1-t2XHtTO9ePWyO4mdqpDBId1KA89u4enpF8y2EWaM00` | 🔑 **the 02/10 client UAT Gemini notes** — summary, decisions, `Concordato`, `Da approfondire`, next steps and the full `Dettagli` section read; the verbatim transcript below them was not needed |
| **Drive** | `read_file_content` on `1xPgFSeF2PNBCxAp6CJJ_L0BWRgSdGY5yKgqDXSzRvxM` | 🔑 **the 12:22 Interna transcript, read in full** |
| **Drive** | `read_file_content` on `1fM5afhfHo6C-L1zEIjHGVSiQQh4BCgjuP-v8_LR2V7c` | 🔑 **the 17:01 Interna Pre-UAT Plus transcript, read in full** |
| **Drive** | `read_file_content` on `1oa5iIHxu86wx6v7qZaBjM7g5Sk7bmuK9` | 🔑 **the Business Blueprint, read in full — first time ever.** Off the unreachable list after eight days |
| **Drive** | `read_file_content` on `121CTGF0mCkL_hiQIZWL1aYEirqwdSVZs` | 🔑 **the Campi Oggetti workbook, read in full — first time ever.** The skill's standing target |
| **Slack** | `slack_read_channel C0BQD34LLF4` (dev group), from 01/10 22:00Z | **1 message — this procedure's own 01/10 report.** 🔴 **No human reply to any nightly report: sixteen nights** |
| **Slack** | `slack_read_channel C0B5T3RB4FM` (`#tproj-pienissimo`), from 01/10 22:00Z | 🔑 **1 message — Elena Spini's status post, 19:30 CEST.** Breaks a three-day silence and carries the revised estimate, seven forward dates and three red flags |
| **Slack** | `slack_read_channel C0C38JJ9D1T` (the marketing group DM), from 01/10 22:00Z | **0 messages** |
| **Git** | `fetch origin --prune`, `log --all --since 2026-10-01T22:00:00Z` | 🔑 **11 commits**; `DevMain` advanced `618e646` → **`6778b58`** via PR **#75**, plus **2 commits on `origin/DevAnita02/10` that are not in `DevMain`** |
| **Repo** | `MexalScadenzarioSearchService.cls`, `MexalInvoiceOrderLineMappingService.cls`, `OrderItemTriggerHandler.cls`, `OrderTriggerHandler.cls` diff, `Mexal_Payment_Status__c`, the three send fields, `git branch --contains`, register `go_live` and `ORD` rules | 🔴 **only `'P'` counts as paid** · 🔴 **the send fields are unmoved** · 🟢 the tranche-less release path is sound · ⬛ **the register says go-live 21/10** |

## Found

1. 🔴🔑 **New: [OI-201](../items/OI-201%20Ri.Ba.%20payments%20are%20read%20as%20unpaid%20because%20only%20P%20counts.md)**
   (gating) — Kreosoft defined `stato_pagamento` as empty/`P`/`E` and said **`E`
   counts as paid**. `MexalScadenzarioSearchService.cls:205` matches only `P`, and
   the flag runs the length of the project: tranche → asset availability → order
   `Incassato` → opportunity → contract `incassato`. **Every Ri.Ba. payer stalls,
   permanently.** The full chain is traced in the note.
2. 🔴🔑 **New: [OI-203](../items/OI-203%20The%20client%20contested%20the%20agreed%20ticket%20logics%20before%20confirming%20them.md)**
   (gating) — the confirmation OI-200 waited for **arrived as a rejection** at
   14:19:31Z. 🟢 **Which document they meant is proved, not guessed**: the
   Blueprint has no `Regole di Business Aggiuntive` paragraph, so it is the 01/10
   logic document, replied to on the wrong thread. The contested rules are the
   multi-event aggregation per order, plus `Rinuncia`. 🔴 ROMI's answer is to
   persuade at Monday's meeting, not to revisit.
3. 🔑 **[The Business Blueprint](../The%20Business%20Blueprint%20delivered%20to%20the%20client.md)**
   — delivered 13:55:56Z, **dated 02/10 and carrying signature lines for ROMI Srl
   and Pienissimo Srl**. A second signature-bearing document the repository does
   not hold. Six internal divergences, and **no go-live date**.
4. 🟢🔑 **[2026-10-02 UAT WooCommerce e Bundle](../meetings/2026-10-02%20UAT%20WooCommerce%20e%20Bundle.md)**
   (~1h17m, five named attendees) — checkouts drove through, four assets
   generated, **six agreements**. New from it:
   [OI-204](../items/OI-204%20WooCommerce%20payment%20codes%20need%20a%20mapping%20table%20to%20Mexal.md)
   and [OI-202](../items/OI-202%20Anticipay%20does%20not%20recognise%20sole%20traders%20absent%20from%20the%20registro%20imprese.md).
   Approval of the integration logics waits on **Daniela, Monday**.
5. 🔑 **[2026-10-02 Interna](../meetings/2026-10-02%20Interna.md)** (19m38s) — the
   Mexal document chain stated plainly, the permission model for client testing,
   and why the integration UAT moved to Wednesday. 🔴 Also: _"ho semplicemente
   **bypassato dei valori sui campi** per creare l'ordine su Mexal."_
6. 🔑 **[2026-10-02 Interna Pre-UAT Plus](../meetings/2026-10-02%20Interna%20Pre-UAT%20Plus.md)**
   (54m07s) — a five-tranche Plus quote driven to contract. New:
   [OI-205](../items/OI-205%20The%20tranche%20carries%20no%20value%20so%20the%20client%20cannot%20see%20what%20each%20one%20is%20worth.md)
   and [OI-206](../items/OI-206%20The%20Insoluto%20concept%20has%20no%20invoice%20due%20date%20and%20no%20invoice%20record.md).
   🟢 Resolves _"Anna"_ / _"Regina"_ as **Anita Aga and Rexhina Hysi**.
7. 🔑 **[The Campi Oggetti workbook](../The%20Campi%20Oggetti%20Flussi%20e%20Utenti%20workbook.md)**
   read in full — the skill's standing target. 🟢 **Closes the OI-199 hypothesis
   negatively** and 🔑 names `Data invio automatico biglietti` on `Campagna Figlia`.
   🔴 Holds live customer records; **no value copied**.
8. 🔴 **[OI-199](../items/OI-199%20The%20ticket%20send%20flag%20fields%20are%20split%20across%20Asset%20and%20Order.md)
   did not move**, and Fabrizio Mastracci's field spec was due today.
9. ⬛ **Correction: go-live is 21/10.** The register has said so since OI-124;
   `AGENTS.md` and last night's MAP entry said 06/10. **Both corrected.** 6 October
   is the UAT window close. Elena Spini's status post independently says 21/10.
10. ⚠ **Anita Aga's `73fe1bc` and `49b5401` are not in `DevMain`.** The first
    carries the sync-error mail and `Account.Creato_su_Mexal__c` agreed with the
    client that morning. A weekend deploy from `DevMain` ships neither.
11. 🟢 **The tranche-less release path, `b382fe2`, is sound.** Its commit message
    says _"pass asset to disponibile when order fatturata"_ but the code tests
    `CONFIRMED_STATUS = 'Incassato'`, which is what the Blueprint and the record
    require. The message is wrong, not the code.
12. 🔑 **Matteo Distaso set the form migration order in writing** — start with
    `Pienissimo Live` and `Camerieri Venditori`, _"tutti i form hanno importanza"_.
13. ⚠ **Elena Spini's estimate is revised to 25 days to finish**, with 12/10 for
    everything in PROD and 16/10 for the Marketing ticket UAT.
14. 🔴 **The Plus products still have no real codes** — _"Put whatever you want"_ —
    with the Performance Plus UAT on **Monday 05/10**.
15. ⚠ **The Blueprint and the 12:22 Interna disagree with the client UAT on
    addresses.** The client session agreed billing **and** shipping are both
    carried; three hours later Aurel Mrruku said the story _"non è manche
    iniziata"_ and that billing would equal shipping.

## The register

**Amended? No. Version stays 1.6.**

🔴 **The one thing today that was a client decision is a rejection.** The client's
only substantive written input was to say two of the agreed rules do not add up.
Writing anything from the disputed document into `REQUISITI.it.md` now would record
as agreed exactly what the client has just contested.

[OI-184](../items/OI-184%20Register%20v1.6%20goes%20to%20the%20client%20as%20one%20change%20set%20at%20UAT%20close.md)
remains the mechanism. 🔴 It can no longer use the 01/10 logic document as its
carrier until OI-203 resolves. `DIV-07` remains open.

⚠ **Three facts settled today are candidates for v1.6 once they are confirmed**:
the `P`/`E` payment semantics, the Performance Plus one-product-N-tranche model,
and the WooCommerce → Mexal payment-code mapping. All three came from ROMI or the
vendor, none from a client sign-off, so none is amended today.

⬛ **Two register rules are now contradicted by recorded sources and were left as
they are**: _"WooCommerce orders are created already Incassato (paid online)"_,
which Aurel Mrruku corrected at the Pre-UAT (only the first tranche is paid), and
`ORD-12`'s IN LAVORAZIONE/COMPLETATO trigger, which the delivered Blueprint reverts
to COMPLETATO-only. Both are recorded in the Blueprint note; neither is a client
decision, so neither moves the register tonight.

## Not done in this run

- The org was **not** opened. `STATUS.md` was not regenerated and the Notion mirror
  stays stale. Every build claim is repository arithmetic against `DevMain`
  `6778b58`.
- **No Apex test was written, proposed or scaffolded**, per the standing
  instruction. [OI-64](../items/OI-64%20The%20bundle%20Apex%20test%20suite%20is%20broken.md)
  and [OI-66](../items/OI-66%20No%20test%20classes%20for%20the%20Biglietto%20stack.md)
  were not touched; nothing this sweep saw changed their state.
- **No Apex was changed.** OI-201 is a one-predicate fix and it was deliberately
  left to Aurel Mrruku — this procedure writes to the knowledge layer, not to
  `force-app`.
- No transcript was copied into `meetings/`; no per-meeting recap in
  `meetings/results/`.
- `npm run prettier:verify` was not run (no `node_modules`), so tonight's markdown
  is unformatted.
- **The verbatim transcript inside the client UAT Gemini notes was not read** — the
  structured sections were sufficient and are timestamp-linked. The 792 MB
  recording was not opened.
- **`eee1788`** (Anita Aga, PR #74, flagged last night as undiffed) was **still not
  diffed**; her two newer commits were diffed by file list only.

## Still unreachable

- **`Articoli Salesforce.xlsx`** — **did not move** since 30/09 12:45:55Z, a third
  consecutive run. 🔴 **Performance Plus UAT is Monday 05/10 and Aurel Mrruku was
  told to invent the product names.** This file is still the one-minute answer.
- **`Flows & Objects.drawio`** — did not move, a second consecutive run. Still an
  `mxfile` the Drive reader cannot parse. 🔴 **And now the only picture of the
  flows for certain**: the Campi Oggetti workbook's flow register turned out to be
  a stub with 2 of 7 rows filled. Ask Elena Spini for a PNG or PDF export.
- **`Campagne Salesforce.xlsx`** — did not move. Still not opened.
- **`Testbook_UAT_Lead_Opportunita_2026-09-24_v2_1.xlsx`** — **did not move**, a
  third consecutive run. Approval due ~13/10.
- **The full text of `Pienissimo_Scheda di Partecipazione ai corsi_da firmare.pdf`**
  — not opened; its seven enrolment pages may carry personal data. ⚠ OI-194 is
  still gating and still undiscussed.
- **The WooCommerce logic document** that Fabrizio Paganelli, Elisa Migliano and
  Sabatino Rinaldi are to review and present to Daniela on Monday. ⚠ **Named as an
  action item at the client UAT and not identified in Drive by this sweep** — it may
  be the Blueprint, or a separate document. Worth asking.
- **The 30/07 marketing notes**, standing.
- **The 12:30 CEST internal call of 25/09** — still no artifact, seventh run.
- ⚠ **The Pienissimo lead documentation** Elena Spini said she owed on 28/09. Not
  raised again.
- ⚠ **Aurel Mrruku's field spec for Fabrizio Mastracci**, due 02/10. No artifact.
- ⚠ **Sabatino Rinaldi's WhatsApp confirmation** of the card and PayPal test orders
  taken straight after the UAT. WhatsApp is not a source this procedure can read;
  the outcome of those two tests is unknown.

🟢 **Two long-standing unreachables came off the list tonight** — the Business
Blueprint and the Campi Oggetti workbook, both read in full.

**Nothing 404'd.**

## Absence of evidence, stated as absence

- **Fathom has returned nothing for nine consecutive runs.** All three of today's
  sessions exist only as Google Meet artifacts. A pattern about the tooling, not
  about the project.
- **No sandbox exception mail arrived in this window**, a third consecutive day.
  That is not evidence the edition mapping is fixed; the 02/10 client UAT did hit
  an unmapped-code failure live, so the class of problem is confirmed still present
  by observation.
- **Nothing written was found for the `P`/`E` rule.** Aurel Mrruku said _"I'm going
  to type it today"_ at ~15:35Z. No document, mail or commit in this sweep contains
  it. Absence at this watermark, not proof he did not.
- **No decision on OI-199 exists in any source.** Not a mail, not a message, not a
  commit. The absence is the finding.
- ⚠ **"Claudio" is still unresolved** — credited twice by Elena Spini on 01/10 for
  the problems table. 🟢 The adjacent puzzle **is** resolved: _"Anna"_ and
  _"Regina"_ are Anita Aga and Rexhina Hysi, confirmed by the Pre-UAT attendee
  list. "Claudio" matches nobody. **No person note was created and nothing was
  attributed.**
