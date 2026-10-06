---
id: trace-2026-10-05-nightly
type: reference
status: active
updated: 2026-10-05
watermark_used: 2026-10-02T22:00Z
external_watermark: 2026-10-05T22:00Z
account: a.mrruku@romicompany.com
---

# Source trace 2026-10-05 nightly

**Watermark for the next `requirements-check` run: 2026-10-05T22:00Z, single
value.**

**Watermark used: 2026-10-02T22:00Z**, the `external_watermark` stated by
[the 02/10 nightly trace](Source%20trace%202026-10-02%20nightly.md), selected
by `updated:` frontmatter. Scheduled nightly run, executed 2026-10-05 ~21:45Z.
**Three days** — 03/10, 04/10 and 05/10 — because the 03–04/10 production
deploy weekend produced no `requirements-check` trace; the two org sessions of
those days are held in `JOURNAL.md`, not here.

🔑 **Three sessions on 05/10, two of them with the client**, and the file this
procedure has chased for four runs.

🟢 **Environment note: the pattern broke.** The clone opened on `main` detached
as on the previous six runs, but `DevMain` was recovered with
`git checkout DevMain` directly — the remote ref resolved without needing
`-B`. Seven runs, same opening state.

## Sources searched

| Source | Query / scope | Result |
| ------ | ------------- | ------ |
| **Fathom** | `list_meetings created_after 2026-10-02T22:00Z`, summaries + action items, 3 pages | **0 meetings** — **tenth** consecutive run with nothing. All three of today's sessions exist only as Google Meet artifacts |
| **Gmail** | `pienissimo after:2026/10/02 -in:draft`, 40 requested, 26 estimated | 🔑 **Marco Montesi's Blueprint reply (read in full)** · 🟢 **the DocuSign production round trip** (quote 00000002 ×6 sends/×4 Completed, quote 00000003) · two Gemini-notes notices · three new calendar invitations · a Salesforce security-token notice · a sandbox quote notice |
| **Gmail** | `(from/to/cc:pienissimo.com OR ROMI-PIENISSIMO OR kreosoft OR pienissimo.pro) after:2026/10/02 -in:draft` | **12 threads, nothing new beyond the above.** 🔴 **The Kreosoft `Ordine cliente` thread has had no message since 02/10 15:11Z** — no follow-up on `P`/`E` in either direction |
| **Gmail** | `get_message` on `1a10c389ef78eee7` | 🔑 **Marco Montesi's three precisazioni, full text** |
| **Drive** | `modifiedTime > '2026-10-02T22:00:00Z'`, **2 pages, 35 files** | 🟢🔑 **`Articoli Salesforce.xlsx` modified 05/10 09:24:17Z** — off the unreachable list · ⚠ `Campi Oggetti, Flussi e Utenti Salesforce - Pienissimo.xlsx` **modified 16:40:32Z**, third consecutive working day · ⚠ `PIENISSIMO – INTERNA Asset e invio biglietti.docx` **modified 08:37:23Z** · three meeting artifact sets · `Integrazioni pienissimo.xlsx` modified 09:11:27Z · rest are other clients (Vision, Sapimed, Daze, 247, Permo, NetSuite, IUAD, Portale-casa) — ignored per the skill |
| **Drive** | `read_file_content` on `17pyx0xRtRY7vWXjN5oddAs52XWvkbM7p` | 🟢🔑 **the article registry, read in full — first time ever.** 1,010 articles, the category pivot, `NR_Tranche`. 🔴 Holds real prices; **no value copied** |
| **Drive** | `read_file_content` on `1YPxjosDtZag60yd8GrNIYq68uaLbzRcwBPTyl3oF450` | 🔑 **the Performance Plus UAT Gemini notes** — summary, decisions, `Concordato`, `Da approfondire`, 17 next steps and the full `Dettagli` read, plus the opening ~15 min of transcript |
| **Drive** | `read_file_content` on `14nkqoZ1vgEb21jq0jeRRG8Z50zRbH7_7Whdt94ALlz4` | 🔑 **the Lead/Contact session Gemini notes, structured sections read in full** |
| **Drive** | `read_file_content` on `1xkAPFYBqdZr_s35FUCxg2MCpPL9NUPh1MPK6SRAUzAc` | 🔑 **the 10:01 Interna transcript** — opening read, then grepped for `Data invio`, `edizione`, `per ordine`, `Marketing Cloud`, `campagna figlia` |
| **Drive** | `read_file_content` on `1IR2YtSzZfyfqOZalzQVpNkKSFiNuRa7f` | the internal logic document, **re-read in full** after its 08:37Z modification |
| **Drive** | `read_file_content` on `121CTGF0mCkL_hiQIZWL1aYEirqwdSVZs` | 🔑 **the Campi Oggetti workbook, re-read in full** — the Lead and Campagne sheets are now filled |
| **Slack** | `slack_read_channel C0BQD34LLF4` (dev group), from 02/10 22:00Z | **1 message — this procedure's own 02/10 report.** 🔴 **No human reply to any nightly report: seventeen nights** |
| **Slack** | `slack_read_channel C0B5T3RB4FM` (`#tproj-pienissimo`), from 02/10 22:00Z | **0 messages.** Three days of silence on the project channel, across a production deploy weekend |
| **Slack** | `slack_read_channel C0C38JJ9D1T` (the marketing group DM), from 02/10 22:00Z | 🔑 **4 messages — Fabrizio Mastracci's two send logics (10:44:57, 10:56:50) and Elena Spini stopping the mail (18:28:50)**, plus an image |
| **Git** | `fetch origin --prune`, `log --all --since 2026-10-02T22:00:00Z` | 🔑 **14 commits**; `DevMain` advanced `486af03` → **`d526189`** via PRs **#76–#80** |
| **Repo** | `MexalScadenzarioSearchService.cls:205`, `Product2/fields/Evento__c`, `git branch --contains 73fe1bc 49b5401 eee1788`, `git show --stat 4a6fe3f`, `git log -S'Happy Team'`, the three new decision notes, `ParticipantRegistrationController` presence | 🔴 **only `'P'` still counts** · 🟢 `Happy Team` is in `Evento__c` via `dd4e95c` · 🟢 **all three Anita Aga commits are in `DevMain`** · 🟢 `4a6fe3f` is the per-campaign Event Link rebuild · ⚠ branch `DevmainRevertParticipationPage` **reverts nothing** — it carries `4a6fe3f` and `c5a4a84`, and the participation page is intact |

## Found

1. 🟢🔑 **[The article registry](../The%20Articoli%20Salesforce%20article%20registry.md)**
   — `Articoli Salesforce.xlsx`, modified 09:24:17Z, read in full after four
   runs on the unreachable list. 1,010 articles, **197 active**; the
   authoritative category table; `C20` = **Servizi Google** with a renewal twin
   `C21`, plus `C40` and `C41`. 🔴 Holds real prices; **none recorded**.
2. 🔴🔑 **New: [OI-210](../items/OI-210%20The%20delivered%20article%20registry%20carries%20no%20tranche%20count.md)**
   (gating) — `NR_Tranche` present and **empty on every row**, contradicting the
   same day's `Concordato` that Plus is one article with a tranche-count field.
   Three incompatible statements of one model.
3. 🔴🔑 **New: [OI-207](../items/OI-207%20The%20quote%20and%20order%20layouts%20omit%20the%20commercial%20fields%20the%20client%20requires.md)**
   (gating) — list price, quantity, unit of measure, line discount and net price
   absent from the quote screen and the quote; required on seven surfaces.
   ⚠ All specified in the client's own workbook.
4. 🔴 **New: [OI-208](../items/OI-208%20Overdue%20and%20upcoming%20payments%20are%20not%20distinguished%20on%20the%20contract.md)**
   (`scaduto` / `a scadere`, which OI-201 would report backwards) and
   **[OI-209](../items/OI-209%20Mexal%20anagrafica%20updates%20only%20propagate%20when%20an%20order%20is%20sent.md)**
   — whose fix is `F-2` in the client's workbook since July.
5. 🔴🔑 **[OI-201](../items/OI-201%20Ri.Ba.%20payments%20are%20read%20as%20unpaid%20because%20only%20P%20counts.md)
   did not move** at `d526189`. ⚠ And Fabrizio Paganelli has now been asked for
   the state list Mirko Merendi already gave, on a thread he is on.
6. 🟢🔑 **[The Performance Plus UAT](../meetings/2026-10-05%20UAT%20Performance%20Plus%20e%20Gestione%20date%20pagamento.md)**
   (15:01 CEST, ~2h01m, four client-side) — nine rulings, two deferrals,
   17 next steps. **DocuSign signed live in production.**
7. 🟢🔑 **DocuSign: two accounts, and a 2,500-envelope-a-year contract**
   (Sabatino Rinaldi). **Corrects the 05/10 free-plan finding** —
   [OI-111](../items/OI-111%20DocuSign%20licences%20are%20not%20confirmed%20with%20the%20client.md).
8. 🔑 **[The Lead/Contact session](../meetings/2026-10-05%20Check%20Data%20Import%20Lead%20e%20Contact.md)**
   (17:15 CEST, ~1h10m, with Matteo Distaso) — six rulings, the 21-value
   `Tipologia di attività` list, P.IVA mandatory at conversion, and the
   per-order → per-edition link proposal **deferred to 06/10**.
9. 🔴🔑 **The deferred link change was committed at 17:39 the same evening**
   (`4a6fe3f`), before the consultation it was deferred to — and the client's
   objection in OI-203 was **correct on the merits**, as Aurel Mrruku conceded
   at 10:01.
10. 🟢🔑 **Marco Montesi accepted the Business Blueprint in writing** at
    13:20:02Z — the first written client acceptance this project has had.
    ⚠ **Three questions, no reply.**
11. 🟢🔑 **[The marketing send contract](../The%20marketing%20ticket%20send%20logics%20as%20written%20by%20Marketing.md)**
    — Fabrizio Mastracci wrote both logics himself, and added
    `Status = 'Assegnato'` unasked. **Four of the logic document's ten problems
    are now closed.**
12. ⏸ **Elena Spini stopped the first marketing mail** at 18:28:50 CEST pending
    the 06/10 call.
13. 🟢 **`Happy Team` is in `Product2.Evento__c`** (`dd4e95c`) and `E08` has
    three active articles — OI-46's standing defect is closed. ⚠ But
    **`Intensive at Home`** and **`Cassa Zucchetti`** appear in the workbook and
    nowhere else.
14. 🟢 **Anita Aga's `73fe1bc`, `49b5401` and `eee1788` are all in `DevMain`** —
    last night's 🔴 is closed.
15. ⚠ **07/10 double-books the client**: the WooCommerce/Mexal UAT 10:00–13:00
    and the Kreosoft call 12:15–13:00.

## The register

**Amended? No. Version stays 1.6.**

The day's client agreements are **operational and layout rulings** — where
commercial fields appear, who fills the activation date, whether renewals use
DocuSign, how a Lead deduplicates. None restates a requirement's acceptance
criteria, state machine or picklist in the contractual sense.

🟢 The one item of substantive client input is **Marco Montesi's acceptance**,
and it covers the **Business Blueprint**, not `REQUISITI.it.md`. His three
questions are open; answering them is not a register change.

⚠ **Candidates for v1.6 once confirmed**: the renewal-without-DocuSign path
(now client-confirmed in the room, so the strongest candidate), the two-flag
Lead consent model, the 21-value `Tipologia di attività` as a global value set,
and `Partita IVA` mandatory at lead conversion.

🔴 [OI-184](../items/OI-184%20Register%20v1.6%20goes%20to%20the%20client%20as%20one%20change%20set%20at%20UAT%20close.md)
remains the mechanism, and it still cannot use the 01/10 logic document as its
carrier: `DIV-07` is open and the contested paragraph **no longer describes the
build** after `4a6fe3f`.

## Not done in this run

- The org was **not** opened. `STATUS.md` was not regenerated and the Notion
  mirror stays stale. Every build claim is repository arithmetic against
  `DevMain` `d526189`.
- **No Apex test was written, proposed or scaffolded**, per the standing
  instruction. [OI-64](../items/OI-64%20The%20bundle%20Apex%20test%20suite%20is%20broken.md)
  and [OI-66](../items/OI-66%20No%20test%20classes%20for%20the%20Biglietto%20stack.md)
  were not touched; nothing this sweep saw changed their state.
- **No Apex was changed.** OI-201 is still a one-predicate fix and was again
  left to Aurel Mrruku — this procedure writes to the knowledge layer, not to
  `force-app`.
- `4a6fe3f`'s 391 lines of `EventInvitationService` were **not read**; the three
  decision notes committed with it were taken as the record of its design.
- `Integrazioni pienissimo.xlsx` (modified 09:11:27Z) was **not opened**. It is
  a known source held in
  [the Mexal mapping workbook note](../The%20Mexal%20integration%20mapping%20workbook.md)
  and nothing pointed at today's change.
- The verbatim transcripts inside the two Gemini notes documents were **not
  read** beyond the Performance Plus opening; the structured sections are
  timestamp-linked. The two ~800 MB recordings were not opened.
- No transcript was copied into `meetings/`; no per-meeting recap in
  `meetings/results/`.
- `npm run prettier:verify` was not run (no `node_modules`), so tonight's
  markdown is unformatted.

## Still unreachable

- 🟢 **`Articoli Salesforce.xlsx` came off this list** after four runs.
- **`Flows & Objects.drawio`** — did not move, a third consecutive run. Still an
  `mxfile` the Drive reader cannot parse. 🔴 **Confirmed again as the only
  picture of the flows**: the Campi Oggetti workbook's `Flussi - elenco` is
  still **2 of 7 rows** on a fourth reading. Ask Elena Spini for a PNG or PDF
  export.
- **`Campagne Salesforce.xlsx`** — did not move. Still not opened.
- **`Testbook_UAT_Lead_Opportunita_2026-09-24_v2_1.xlsx`** — **did not move**, a
  fourth consecutive run. Approval due ~13/10.
- **The full text of `Pienissimo_Scheda di Partecipazione ai corsi_da firmare.pdf`**
  — not opened; its seven enrolment pages may carry personal data. ⚠ OI-194 is
  still gating and went undiscussed for a sixth day.
- ⚠ **The document Rebecca Marmo shared** with Fabrizio Mastracci, of what
  marketing did before and _"che secondo me si aspettano di ricreare su
  marketing cloud"_. Named in the 10:01 session, Elena Spini asked for it to be
  opened in the call, **not identified in Drive by this sweep.** Worth asking.
- **The WooCommerce logic document** for Daniela Morgese — second run, still
  not identified. ⚠ Monday has passed; nothing in this sweep says whether that
  presentation happened.
- **The 30/07 marketing notes**, standing.
- **The 12:30 CEST internal call of 25/09** — still no artifact, eighth run.
- ⚠ **The Pienissimo lead documentation** Elena Spini said she owed on 28/09.
  Not raised again.
- ⚠ **Sabatino Rinaldi's WhatsApp confirmation** of the card and PayPal test
  orders of 02/10. WhatsApp is not a source this procedure can read; those two
  outcomes remain unknown. ⚠ And Elena Spini used WhatsApp again on 05/10 to
  reach Fabrizio Paganelli, so decision traffic continues on a channel this
  sweep cannot see.
- **No DocuSign plan document, order confirmation or plan name** behind
  Sabatino Rinaldi's 2,500-envelope figure.

**Nothing 404'd.**

## Absence of evidence, stated as absence

- **Fathom has returned nothing for ten consecutive runs.** A pattern about the
  tooling, not about the project.
- **`#tproj-pienissimo` was silent for three days**, across a production deploy
  weekend. No status post from Elena Spini since 02/10. Absence at this
  watermark, not evidence that nothing was decided.
- **Seventeen consecutive nightly reports with no human reply** in the dev
  group.
- **Nothing was found on OI-201 in any source** — not a mail, a message or a
  commit. The absence is itself the finding, for a fourth night.
- **No decision was found on the `NR_Tranche` / one-article question.** The UAT
  ruling and the delivered file simply disagree; nobody noticed in the room.
- **Nobody has replied to Marco Montesi.** Checked the thread directly: his
  13:20:02Z message is the last on it.
- **No artifact was found for the 03/10 or 04/10 deploy weekend** beyond git and
  the two `JOURNAL.md` entries — no meeting, no mail, no Slack message.
- ⚠ **"Claudio" is still unresolved**, credited by Elena Spini for the problems
  table whose findings four of ten are now closed. **No person note was created
  and nothing was attributed.**
- ⚠ **The logic document's 08:37:23Z modification produced no detectable
  textual change** against the record. The 01/10 version was not retained, so
  this is recorded as **uncertain, not as unchanged**.
