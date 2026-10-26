---
id: trace-2026-10-09-nightly
type: reference
status: active
updated: 2026-10-09
watermark_used: 2026-10-08T22:00Z
external_watermark: 2026-10-09T22:00Z
account: a.mrruku@romicompany.com
---

# Source trace 2026-10-09 nightly

**Watermark for the next `requirements-check` run: 2026-10-09T22:00Z, single
value.**

**Watermark used: 2026-10-08T22:00Z**, the `external_watermark` stated by
[the 08/10 nightly trace](Source%20trace%202026-10-08%20nightly.md), selected by
`updated:` frontmatter. Scheduled nightly run, executed 2026-10-09 ~21:50Z.
**One day.**

🔑 **One client session, 13 commits, the first project-channel status post in
seven days — and an unread flow error showing a customer-facing ticket send
delivering to a null recipient in an org this project has never identified.**

🟢 **Environment note.** The clone opened **detached at `refs/heads/main`**
(two commits, config only) and the working tree held none of the knowledge
layer; `DevMain` did not exist locally and was created with
`git fetch origin && git checkout DevMain`. **Eleven runs, same opening
pattern.** ⚠ `AGENTS.md` still describes `MAP.md` as _"under 5 KB"_; it is
**217 KB**. The read protocol's first instruction has been wrong for some time.

## Sources searched

| Source | Query / scope | Result |
| ------ | ------------- | ------ |
| **Gmail** | `pienissimo after:2026/10/08 -in:draft`, 40 requested, 14 estimated | 🔑 **`Anagrafica Prodotti`** — Fabrizio Paganelli 10:41:49Z and Aurel Mrruku's reply 14:24:35Z · 🔑 **Gemini notes for a new 09/10 session** 09:16:08Z · 🔴 **a Salesforce flow error mail** 05:53:21Z, **unread** · a Drive share notification for `Manual Steps Pienissimo` 09:29:58Z · two calendar mails for the same meeting, 07:24:18Z and 07:31:59Z (moved 09:30 → 10:30 CEST). Everything else in the result set is at or before the watermark and already held |
| **Gmail** | `get_thread 1a1204146546f5a1` (Anagrafica Prodotti, 2 messages, PLAIN_TEXT, full bodies) | 🔑 the client's own framing of the workaround — _"Ho valorizzato a S il campo Gruppo Articolo (in sostituzione provvisoria del flag annullato) Così facendo i prodotti attivi (per fare i test) sono poco più di 30 codici"_ — and Aurel Mrruku's _"ho fatto le necessarie modifiche e ho aggiornato i prodotti per gli UAT"_ (**OI-226**) |
| **Gmail** | `get_message 1a11f3927d70449e` (flow error, PLAIN_TEXT, full body) | 🔴🔑 **the whole interview trace of `Automazione: Invio Biglietto assegnato Flow`** — `Get Ticket PDF` _"Impossibile trovare i record"_, decision reporting `Esito eseguito: Si_PDF` anyway, `Invio Biglietto inviato/a a null`, `Aggiorna Asset Ticket Sent` failed, `$Record = null` (**OI-225**) |
| **Gmail** | `get_message 1a11ff2d0b1fe565` (Gemini notes mail, PLAIN_TEXT) | 🔑 the 09/10 session's summary and five next steps, read before the Drive document |
| **Drive** | `modifiedTime > '2026-10-08T22:00:00Z'`, **2 pages, 24 files** | 🔑 **the 09/10 session folder and its Gemini notes** · 🆕 **`Manual Steps Pienissimo`** 09:21:27Z, modified 09:37:30Z · ⚠ **`Flows & Objects.drawio` moved 13:37:28Z** after six static runs · `Campi Oggetti…xlsx` 10:33:35Z · ⚠ the rest are **other clients** (Daze, LIFE365, IUAD/Eduarth, and five `Business Blueprint - Vision` parts owned by `d.losco@`) or ROMI-internal — ignored per the skill |
| **Drive** | `read_file_content 1LqFNd0ZNQNyOAj1x6jUx3Yc0X4skdRdsS_eZekawFw0` | 🔑 **the 09/10 session read in full** — `Riepilogo`, **three `Concordato`**, one `Da approfondire`, five `Passaggi successivi`, all `Dettagli`, **and the entire verbatim transcript** (31m28s, clean sign-off). Small enough to read whole; no sampling |
| **Drive** | `read_file_content 1u-LgUKVlGK9ePyjMzZ_uJjXniHluo5_449siHgAIBHo` | 🆕 **`Manual Steps Pienissimo` read in full** — `A1:C3`, two manual steps, **`Status Uat` = Done on both, `Status Prod` blank on both**. Decoded in [the note](../Manual%20Steps%20Pienissimo%20tracker.md) |
| **Slack** | `slack_read_channel C0BQD34LLF4` (dev group), `oldest` 2026-10-08T22:00Z | **1 message — this procedure's own 08/10 report.** 🔴 **No human reply: twenty-one nights.** ⚠ The unbounded read of this channel exceeded the tool's output limit and was re-run time-bounded |
| **Slack** | `slack_read_channel C0B5T3RB4FM` (`#tproj-pienissimo`) | 🟢🔑 **1 message, breaking a seven-day silence** — Elena Spini's status post, 18:45 CEST: estimate **25 → 20 days**, Woo payment mapping, agent at order creation, **books move to the new Woo shop and leave Salesforce for now**, next steps 12/10 e2e · 13/10 Prod confirmation · Mirko discount call · Lead fields in Prod · 16/10 Marketing UAT. ⚠ Reports the Blueprint _"confermato e firmato"_ |
| **Slack** | `slack_read_channel C0C38JJ9D1T` (marketing group DM) | 🔑 **9 messages on 09/10** — Fabrizio Mastracci **commissioned two forms** (`camerierivenditori.com`, `pienissimo.live`) with their field list and hidden UTMs plus the four OI-115 picklists; Aurel Mrruku: _"non ci sono in prod sti campi, li stiamo creando in uat"_ (**OI-14**, **OI-115**) |
| **Slack** | `slack_read_thread C0C38JJ9D1T 1791541949.336539` (8 replies) | 🔴 the forms' schedule, unsettled — _"i form sono post live giusto?"_ · _"speravo di farli vedere agli UAT"_ · _"priorità al giro dei flussi"_ · a dry run asked for Tue/Wed · **_"Non appena matteo mi da il numero per whatsapp"_** · **_"Inizio prossima settimana"_** |
| **Fathom** | `list_meetings created_after 2026-10-08T22:00Z`, summaries + action items, 3 pages | **0 meetings. Fourteenth consecutive run with no Pienissimo meeting**, and tonight none at all. The 09/10 session exists only as a Google Meet artifact |
| **Git** | `fetch origin --prune`, `log --all --since 2026-10-08T22:00:00Z` | **13 commits** (12 human plus this procedure's own 08/10 commit); `DevMain` advanced `8879f08` → **`edc063b`**, through **PRs #90–#93** |
| **Git** | `merge-base --is-ancestor` on `c147aa0`, `c5e4a1e`, `53257f2`, `795f13d` | 🟢 **all four are in `DevMain`** — which **corrects two notes written today** (below) |
| **Repo** | `Scadenza_Fattura__c/fields/Pagata__c`; `MexalScadenzarioSearchService.cls:190-215`; `git show --stat` on `c5e4a1e` and `c147aa0`; `ls force-app/main/default/flows/`; Aurel Mrruku's two JOURNAL entries; OI-96, OI-145, OI-197, the article sync note | 🔴🔑 **both payment predicates byte-for-byte unchanged — OI-212 did not move, third night** · 🔴🔑 **`flows/` is empty: no flow metadata in source control at all** · 🟢 the category mapping and the `cod_grp_merc` change are both committed |

## Found

1. 🟢🔑 **[OI-96](../items/OI-96%20Edition%20mapping%20table%20on%20Salesforce.md)'s
   population rule was agreed with the client and built the same afternoon** —
   by categoria merceologica, not article code; `c5e4a1e`, PR #92. 🔑 **One of
   the few rulings on this project taken with a client in the room and
   implemented the same day.**
2. 🆕🔴 **New: [OI-225](../items/OI-225%20The%20ticket%20dispatch%20flow%20sends%20to%20a%20null%20recipient%20and%20fails%20the%20asset%20write.md)**
   — the ticket dispatch flow found no PDF, took the `Si_PDF` branch, emailed
   `null` and failed the asset write-back. 🔴 **The project keeps no flow
   metadata in source control**, so it is org-only. ⚠ **The org is not
   identified.**
3. 🆕 **New: [OI-226](../items/OI-226%20The%20gruppo%20merceologico%20stands%20in%20for%20the%20flag%20annullato%20only%20for%20the%20tests.md)**
   — the gruppo merceologico stand-in, explicitly provisional on both sides,
   built and committed, with a production code change implied and **no decision,
   owner or date** behind it.
4. 🔴 **[OI-145](../items/OI-145%20Order%20header%20discounts%20are%20removed.md)'s
   open check is answered in the negative, by the client** — the Mexal order
   tracciato carries the net price only, so the invoice cannot show list price or
   discount. ⚠ Mirko Merendi's alternative interface was advised against over
   rounding. Call **next week**, unbooked.
5. 🔑 **[OI-14](../items/OI-14%20Marketing%20forms%20and%20subdomain.md) has its
   first scoped work in fifteen weeks** — two commissioned forms, their Lead
   fields **not in Prod**, Prod creation with no owner or date, and the dry run
   gated on a WhatsApp number from Matteo Distaso.
6. 🔑 **[OI-115](../items/OI-115%20Tipologia%20Attivita%20values%20and%20its%20move%20to%20the%20quote.md)'s
   unreachable workbook now blocks a committed deliverable** — a Web-to-Lead post
   cannot write a picklist value the org does not have.
7. 🔴🔑 **[OI-212](../items/OI-212%20A%20Ri.Ba.%20rate%20reads%20as%20paid%20before%20its%20due%20date.md)
   did not move, third night**, re-verified byte-for-byte at `edc063b`.
8. 🟢 **[The 09/10 client call](../meetings/2026-10-09%20Accesso%20e%20Tema%20Prodotti.md)**
   — three `Concordato`, one `Da approfondire`, five next steps, read in full
   including the verbatim transcript.
9. 🆕 **New: [the Manual Steps tracker](../Manual%20Steps%20Pienissimo%20tracker.md)**
   — the first artifact collecting deploy-time manual configuration. 🔴 **Both
   rows blank for Prod.**
10. ⚠ **[OI-197](../items/OI-197%20The%20ticket%20send%20flag%20and%20the%20Inviato%20asset%20state%20are%20agreed%20and%20unbuilt.md)
    is qualified, not resolved** — two of its five "unbuilt" rows exist org-side
    and are failing, so the contract's build state is **unknown rather than
    "none"**.
11. 🟢 **The project channel broke a seven-day silence** — estimate **25 → 20
    days**, the Woo payment mapping confirmed, and **books leave Salesforce for
    now**. ⚠ It reports the Blueprint _"confermato e firmato"_.
12. ⚠ **Of record:** UAT now writes to the client's live ERP (order creation left
    open on Mexal); `Flows & Objects.drawio` **moved** but is still unparseable;
    the `Natura` decode restated as first-letter-biglietto / second-letter-bundle
    after a false start; ~10 minutes of a client call spent on Proton Pass access
    recovery, during which the `amministrazione@` user hit _"privilegi
    sufficienti"_ and Aurel Mrruku did not know what access it had been granted.

## The register

**Amended? No. Version stays 1.6.**

The three `Concordato` are **internal and operational** — which Mexal field
stands in for another during a test window, how many Plus products stay active,
and whether a mapping table is keyed by article code or by category. None changes
a contractual obligation.

🟡 **[OI-145](../items/OI-145%20Order%20header%20discounts%20are%20removed.md) is
the one with contractual reach, and it is not an amendment yet.** The 18/09 text
already carries the client-facing requirement that an invoice show quantity, list
price, total, discount and net. Today's finding does not change the requirement —
it establishes that **the integration cannot currently satisfy it**. That is a
build gap against existing signed wording, not new wording, so it belongs in the
tracker and not in the register. ⚠ **If the Mirko Merendi call concludes that
Mexal cannot carry the breakdown at all, `ORD`-side wording will have to change**
and the client's own invoice expectation renegotiated. Flagged now so nobody is
surprised by it next week.

⚠ **Candidates for v1.6 once confirmed**, carried forward unchanged: the
renewal-without-DocuSign path, the two-flag Lead consent model, the 21-value
`Tipologia di attività`, `Partita IVA` mandatory at lead conversion, the
per-edizione link scope, `Rinuncia` per edition, `E` counts as paid only once the
due date has passed, and the commercial notification flows. ⚠ The carrier is
still blocked —
[OI-184](../items/OI-184%20Register%20v1.6%20goes%20to%20the%20client%20as%20one%20change%20set%20at%20UAT%20close.md)
cannot use an unconfirmed text, and the amended logic document's written
confirmation is now **eight days** unanswered.

## Corrections to the record

- ⚠ **Two notes written today say "not committed" and are wrong.** Aurel Mrruku's
  own entries on
  [OI-96](../items/OI-96%20Edition%20mapping%20table%20on%20Salesforce.md) and
  [the article sync](../objects/The%20Mexal%20article%20sync%20to%20Product2.md)
  both read _"Deployed to Pienissimo UAT only, not committed, not in Prod."_ Each
  was **written inside the commit that built the thing it describes**, so the
  middle clause was stale on arrival: `c5e4a1e` and `c147aa0` are both in
  `DevMain` (PRs #92 and #91). **"Not in Prod" still holds in both.** Corrected in
  both notes rather than rewritten, with the mechanism named so the pattern is
  recognisable — a note committed alongside its own code cannot describe its own
  commit state.
- ⚠ **One correction to a claim in a client-facing status post, not to a source.**
  `#tproj-pienissimo` reports _"Business Blueprint confermato e firmato"_. The
  only evidence on the record is Elena Spini's 08/10 _"lo stanno mandando in
  firma"_ — being *sent* for signature. **No signed artifact has been seen by any
  sweep**, and the 08/10 trace named the signature as the thing to look for next.
  Recorded as a discrepancy; **no claim is made either way**, and the status post
  may simply be ahead of what this sweep can see.
- ⚠ **One qualification to a note's scope, not a reversal.**
  [OI-197](../items/OI-197%20The%20ticket%20send%20flag%20and%20the%20Inviato%20asset%20state%20are%20agreed%20and%20unbuilt.md)
  listed five pieces of the send contract as unbuilt. It was accurate about
  `force-app` and wrong as a statement about the system, because the project keeps
  **no flow metadata under source control**. Not rewritten: what the org actually
  contains has not been inventoried, and a single flow error mail is not an
  inventory.
- 🟢 **No distortion found in tonight's Gemini source.** The 09/10 notes agree with
  the verbatim transcript on every point checked, including the one place it
  matters — the `Concordato` on the category mapping is what the two men actually
  said. ⚠ The transcription garbles system names throughout (`Zoo`, `Maxal`,
  `Ses Force`), quoted as transcribed.

## Not done in this run

- The org was **not** opened. `STATUS.md` was not regenerated and the Notion
  mirror stays stale. Every build claim is repository arithmetic against `DevMain`
  `edc063b`.
- **No Apex test was written, proposed or scaffolded**, per the standing
  instruction. ⚠ Noted only as a fact of the record: Aurel Mrruku's own JOURNAL
  entry reports **three Account validation rules added to UAT by "ROMI COMPANY"
  and not in the repo**, the Agente one failing all of `QuoteCommercialTest` and
  ten `TicketingTest` methods. That is inside the gap
  [OI-64](../items/OI-64%20The%20bundle%20Apex%20test%20suite%20is%20broken.md) and
  [OI-66](../items/OI-66%20No%20test%20classes%20for%20the%20Biglietto%20stack.md)
  describe; he recorded it in OI-64 himself and **this sweep did not touch either
  row**.
- **OI-225 was not fixed and the flow was not opened.** Identifying the org,
  reading the flow and deciding whether a customer received a ticketless email all
  need org access this procedure does not use.
- **OI-212 was not fixed**, a third night. The defect is recorded with the file,
  the lines and the formula; the correction is a code change and belongs to Aurel
  Mrruku.
- **OI-223's blast radius was not assessed** — a fourth run. Which
  community-reachable controllers now bypass record access still needs an org
  inspection and a security read.
- **OI-207 was not verified in the org** — a fifth run.
- `Campi Oggetti…xlsx` **moved** at 10:33:35Z and was **not re-read** — it holds
  live customer records and nothing tonight needed its values, so **what changed
  is not established**.
- `Flows & Objects.drawio` **moved** and could not be read: still an `mxfile` the
  Drive reader cannot parse.
- The **09/10 session transcript was read whole** — it is 31 minutes, so this is
  not an escalation. No transcript was copied into `meetings/`; no per-meeting
  recap in `meetings/results/`.
- `npm run prettier:verify` was not run (no `node_modules`), so tonight's markdown
  is unformatted.
- ⚠ `JOURNAL.md` is at **111 entries** against a documented limit of 20. Archiving
  to `notes/sessions/` is overdue and **was left alone again** — a knowledge-layer
  change this procedure keeps deferring.

## Still unreachable

- 🔴 **`Mappatura_Categorie_Sottocategorie_Origine Lead_Tipologiattività.xlsx`**
  — the four Lead picklists, still a **mail attachment only**, fourth run. 🔴 **It
  now blocks a commissioned deliverable**, not just a field definition: the two
  forms post into `Categoria`, `Sottocategoria`, `Origine Lead` and
  `Interessato a`. **Ask Elisa Migliano or Elena Spini to put it in Drive.**
- **`Flows & Objects.drawio`** — 🟡 **it moved at last**, at 13:37:28Z after six
  static runs, and is still an unparseable `mxfile`. **Ask Elena Spini for a PNG
  or PDF export** — now to see *what changed*, not only to read it.
- **The identity of org `00Dbl000005BSMH`** — 🆕 and the most answerable thing on
  this list. It is not the partial sandbox. **Ask Aurel Mrruku or Rexhina Hysi to
  confirm whether OI-225's flow error came from production.**
- **`Campagne Salesforce.xlsx`** — did not move. Still not opened.
- **`Testbook_UAT_Lead_Opportunita_2026-09-24_v2_1.xlsx`** — **did not move**, an
  eighth consecutive run. Approval due ~13/10.
- **The full text of `Pienissimo_Scheda di Partecipazione ai corsi_da firmare.pdf`**
  — not opened; its seven enrolment pages may carry personal data. ⚠ OI-194 is
  still gating and went undiscussed for a tenth day.
- ⚠ **The document Rebecca Marmo shared** with Fabrizio Mastracci. Fifth run.
- **The WooCommerce logic document** for Daniela Morgese — sixth run.
- **The 30/07 marketing notes**, standing.
- **The 12:30 CEST internal call of 25/09** — still no artifact, twelfth run.
- ⚠ **The Pienissimo lead documentation** Elena Spini said she owed on 28/09.
- ⚠ **Sabatino Rinaldi's card and PayPal test orders** — WhatsApp is not a source
  this procedure can read. 🟢 The Woo payment mapping is now confirmed in the
  status post (card/PayPal → 2, bonifico → 12), which overtakes part of it.
- **No DocuSign plan document** behind the 2,500-envelope figure.
- ⚠ **The `ai-visibility-fmf` form check** Elena Spini posted on 08/10 — second
  run, screenshot never opened, **still no owner**.
- 🆕 **The WhatsApp number Matteo Distaso owes Fabrizio Mastracci** — it gates the
  internal pre-UAT run of the two commissioned forms, and appears in no other
  record.

**Nothing 404'd this run.**

## Absence of evidence, stated as absence

- **Fathom returned no meetings at all tonight** — fourteenth consecutive run with
  no Pienissimo meeting. A pattern about the tooling, not the project.
- 🟢 **`#tproj-pienissimo` spoke after seven days.** 🔴 **The dev group did not:
  twenty-one consecutive nightly reports with no human reply.**
- **Nothing was found on [OI-212](../items/OI-212%20A%20Ri.Ba.%20rate%20reads%20as%20paid%20before%20its%20due%20date.md)**
  in any source — not a mail, a message, a meeting, a commit or a ruling. **Third
  night.**
- **Nothing on OI-210** — the `NR_Tranche` / one-article contradiction — in any
  source. **Fifth night.**
- **Nothing on OI-194**, OI-202, OI-204's documentation half, OI-205, OI-206's
  missing reports, OI-216 or OI-217.
- **Nothing on OI-222 or OI-224**, both raised yesterday: Marco Montesi's original
  templates question is **unanswered a fourth day**, and Sabatino Rinaldi has not
  answered the mass-Opportunity escalation.
- **No reply to Elena Spini's 12:47:00Z request for written confirmation** of the
  amended logic document, now **eight days** old. OI-200's seven open points are
  unchanged.
- **Which agent code to use for an agentless WooCommerce order is still
  unanswered** — OI-214's gating half.
- **The QR credential rotation has still not happened** — third day since it left
  ROMI, and nothing in any source tonight mentioned it.
- **Rebecca Marmo's two funnel questions remain unanswered** — WhatsApp parallel or
  backup, and which event date stops the send. She appears nowhere in today's
  sources; the status post reports Fabrizio Mastracci is _"facendo confermare a
  Rebecca il journey"_, which is a chase, not an answer.
- ⚠ **"Claudio" is still unresolved**, credited by Elena Spini on 06/10. **No
  person note was created and nothing was attributed.**
- ⚠ **"Giuliano Lanzetti"**, the sender identity on OI-225's failing email, matches
  nobody in the records. 🆕 **No person note was created**, because nothing
  establishes it is a person rather than a configured org-wide sender.
- **Elena Spini's post-launch support estimate** is not in any source tonight.
