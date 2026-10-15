---
id: trace-2026-10-12-nightly
type: reference
status: active
updated: 2026-10-12
watermark_used: 2026-10-09T22:00Z
external_watermark: 2026-10-12T22:00Z
account: a.mrruku@romicompany.com
---

# Source trace 2026-10-12 nightly

**Watermark for the next `requirements-check` run: 2026-10-12T22:00Z, single
value.**

**Watermark used: 2026-10-09T22:00Z**, the `external_watermark` stated by
[the 09/10 nightly trace](Source%20trace%202026-10-09%20nightly.md), selected by
`updated:` frontmatter. Scheduled nightly run, executed 2026-10-12 ~21:45Z.
**Three days — Friday night to Monday night, with a weekend inside them.** No
trace exists for 10/10 or 11/10; the weekend is the natural reading and no claim
is made.

🔑 **The contract-bound register and the Italian text the client signs were both
rewritten by a developer commit, in the direction of what was built, with no
client ruling behind the new words — and the client's own end-to-end UAT ran and
left fifty-nine seconds of greeting.**

🟢 **Environment note.** The clone opened **detached at `refs/heads/main`** (two
commits, config only) with none of the knowledge layer in the working tree;
`DevMain` did not exist locally and was created with
`git fetch origin && git checkout -B DevMain origin/DevMain`. **Twelve runs, same
opening pattern.** ⚠ `AGENTS.md` still describes `MAP.md` as _"under 5 KB"_; it
is now **225 KB**. The read protocol's first instruction has been wrong for some
time.

## Sources searched

| Source | Query / scope | Result |
| ------ | ------------- | ------ |
| **Gmail** | `pienissimo after:2026/10/09 -in:draft`, 50 requested, 11 estimated | 🔑 **the e2e UAT moved to 14/10** 16:10:35Z · 🔑 **a new `Feedback Test UAT` for 13/10** 16:11:43Z · 🔑 **Fabrizio Paganelli's _"non ci ritroviamo su alcune schermate"_** 06:27:47Z · 🆕 **a Jira invitation to project `PIENISSIMO`** 10/10 08:22:54Z, **unread** · the `[PIENISSIMO] - Follow-up Interno` made a recurring Tue slot, 07:23:40Z · _"TARDO 10 MINUTI"_ 13:55:01Z. Everything else at or before the watermark and already held |
| **Gmail** | `after:2026/10/09 -in:draft (from:/to:/cc:pienissimo.com OR pienissimo.pro OR kreosoft OR gemini-notes@google.com OR info@salesforce.com OR subject:ROMI-PIENISSIMO)`, 12 estimated | **No Pienissimo Gemini-notes mail for 12/10** — the only notes mails in the window are `[TFP] Data Cleaning`, `[ROMI-LIFE365]` and two Daze sessions, all other clients. **No new flow error mail**; no Kreosoft mail |
| **Gmail** | `after:2026/10/09 -in:draft (mexal OR biglietto OR bundle OR tranche OR anticipay OR woocommerce OR docusign OR preventivo OR "Ri.Ba" OR scadenzario OR blueprint OR jira)`, 8 estimated | Nothing on this project beyond the above. 🔴 **Nothing on `Ri.Ba.`, scadenzario or the Blueprint signature.** The `[TFP] Data Model` thread Aurel Mrruku forwarded to Sara Aga at 12:52:27Z is another client |
| **Gmail** | `get_thread 1a130e15581d532e` (e2e invitation, PLAIN_TEXT, full body) | 🔑 the note **_"Posticipo come richiesto"_**, `Changed: Time`, **Wed 14 Oct 09:00–11:00**, and the **scope list in writing** — _"prodotti standard · bundle · recall tutor/pack tutor · Performance Plus · libro/videocorsi"_ |
| **Gmail** | `get_message 1a12ecbc22d15f73`, `1a130e25e78976b4`, `1a124e86eff3fc5a` (PLAIN_TEXT, full bodies) | the client's test report in full; the Feedback Test UAT invitation (13/10 12:00–13:00, same four guests); the Jira invite — **project key `PIEN`**, `romiagency.atlassian.net/browse/PIEN` |
| **Slack** | `slack_read_channel C0BQD34LLF4` (dev group), `oldest` 2026-10-09T22:00Z | **1 message — this procedure's own 09/10 report.** 🔴 **No human reply: twenty-two nights** |
| **Slack** | `slack_read_channel C0B5T3RB4FM` (`#tproj-pienissimo`), same bound | **0 messages.** 🔴 Silent for three days, after a single post on 09/10 broke a seven-day silence |
| **Slack** | `slack_read_channel C0C38JJ9D1T` (marketing group DM), same bound | 🔑 **9 messages, all 12/10** — Fabrizio Mastracci's **written specification of both ticket-send flows** at 09:15:18 CEST, _"Sto finendo la testlist degli invii, domani facciamo un giro"_ at 09:15:59, and the slot negotiation that produced the 13/10 15:30 internal review |
| **Slack** | `slack_read_channel D0B5QHS2T7H` (Elena Spini DM), same bound | 🔑 Aurel Mrruku's **`lead-web-to-lead (1).html`** at 17:59:37 CEST. ⚠ **Two voice huddles** (17:33:33, 17:51:59) after _"mi ha chiamato Fabrizio"_ and _"ho anche una notizia bella però"_ — **the content is unreadable** |
| **Slack** | `slack_search_public_and_private` `keywords:[pienissimo] after:2026-10-09`, sorted by timestamp | 5 results, all accounted for: this procedure's own reports (Pienissimo and the sibling LIFE365 run), the Elena Spini DM, the Jira bot, a Google Calendar bot line. **Nothing in any other channel** |
| **Slack** | `slack_read_canvas F0BD2H5A9HT` (`Link utili Pienissimo`) | **Unchanged.** Newest entry still 20.08.2026 — static for seven weeks. Re-read per the skill; it is the source of the 30/07 marketing notes link |
| **Drive** | `modifiedTime > '2026-10-09T22:00:00Z'`, **2 pages, 18 files** | 🔑 **the 12/10 e2e session folder and its Gemini notes** (14:25:19Z) · 🆕 **`Regole Codifica Codici Articolo.xlsx`** 09:11:19Z · 🆕 **`Manual Steps Pienissimo` moved** 10:20:03Z · ⚠ **`Flows & Objects.drawio` moved again** 07:43:42Z · the rest are other clients (TFP, Daze, Vision/`d.losco@`, `247.it`) or ROMI-internal — ignored per the skill. ⚠ `Campi Oggetti…xlsx` did **not** move |
| **Drive** | `read_file_content 1vGJP1feyYBQWqgnRtSJahN1gNbuzYHhWZlZK5RdTj4g` | 🔴🔑 **the 12/10 session read in full, and it is empty** — no `Riepilogo` (_"non c'era abbastanza conversazione"_), no `Dettagli`, transcript **_"terminata dopo 00:00:59"_** |
| **Drive** | `read_file_content 1L6RTAi-DF3plieM6oKQbj7KyktX2sAFR` | 🔑 **the article-coding rule read in full** — a four-position fixed-width scheme plus a ten-event prefix table. Decoded in [the note](../The%20Regole%20Codifica%20Codici%20Articolo%20workbook.md). **No code values copied** |
| **Drive** | `read_file_content 1u-LgUKVlGK9ePyjMzZ_uJjXniHluo5_449siHgAIBHo` | 🆕 **the manual-steps sheet re-read** — now `A1:C4`; the **third row is blank in both status columns** |
| **Drive** | `search_files parentId = '13dFuyvuX7SUKLqIoz9Nf3ZC20XEnpXoQ'` | the client's article folder enumerated: `Articoli Salesforce.xlsx`, `anar_PIE.csv`, `anar_PIE_ricla.xlsx` and the coding-rules workbook — all owner `fabrizio.pienissimo@gmail.com`. **The workbook had been sitting there since 21/09 and no sweep had opened it** |
| **Drive** | `read_file_content 11ly3iGQc1smlY8IybSnUMQBGXbZ-ddbx` | ⚠ **refused** — _"unsupported mime type"_. Still an unparseable `mxfile`, second consecutive run with movement and no readable delta |
| **Drive** | `get_file_metadata 1uJCE4NW9nbdI38ADmt66svUT1MRmkyYd24uI0hegAD0` (the 30/07 marketing notes, from the canvas) | 🔴 **404 — _"Requested entity was not found."_** The standing unreachable now has a precise id to request |
| **Fathom** | `list_meetings created_after 2026-10-09T22:00Z`, summaries + action items, 3 pages | **0 meetings. Fifteenth consecutive run with no Pienissimo meeting**, and none at all tonight |
| **Git** | `fetch origin`, `log --all --since 2026-10-09T22:00:00Z` | **5 commits**, four human plus this procedure's own 09/10 commit. `DevMain` advanced `edc063b` → **`a061f55`** through **PR #94**. ⚠ **Two of the four are on branches not in `DevMain`** |
| **Git** | `merge-base --is-ancestor` on `96d77de`, `7f8ead3`, `27304d7` | `96d77de` **in** `DevMain`; `7f8ead3` (`DenAnita12`) and `27304d7` (`DevAnita_CodiceAgenteEsterno`) **not in**, no PR open for either |
| **Repo** | `git show 96d77de` on the register and both prose documents; `MexalScadenzarioSearchService.cls:190-215`; `Scadenza_Fattura__c/fields/Pagata__c`; `git log` on both; `Evento__c`, `Codice_Agente_Esterno__c`, the Quote/Order trigger diffs; OI-59's own new section | 🔴🔑 **the `SAL-20` rewrite in all three documents, `version` unchanged at 1.6** · 🔴🔑 **both payment predicates byte-for-byte unchanged — OI-212 did not move, fourth night** · 🔑 the Evento picklist's eleven values · ⚠ the order trigger's `continue` past the Account fallback |

## Found

1. 🔴🔑 **New: [OI-227](../items/OI-227%20SAL-20%20was%20rewritten%20in%20the%20signable%20requirements%20with%20no%20client%20ruling.md)
   — gating.** `96d77de` / PR #94 rewrote `SAL-20` in the register and in **both**
   prose documents, `REQUISITI.it.md` included: tasks became stages, the second
   trigger moved from first contact to a quote, and a settable date became an
   automatic one. Three new state-machine rules came with it, one — the
   Chiusa/Persa quote cascade — **not in `SAL-20` at all**. `status` is still
   `to_confirm`, `version` is still 1.6, **no client ruling exists in any
   source**. 🟢 The build is fully recorded by its author in OI-59 and is not in
   question.
2. 🔴🔑 **[The 12/10 e2e UAT](../meetings/2026-10-12%20UAT%20Test%20e2e.md) left no
   record and the test was postponed.** Transcript stopped at `00:00:59`, no
   summary, no details. Called because the client tested alone and the screens did
   not match; two hours later the e2e moved to **14/10** and a **Feedback Test
   UAT** was inserted for **13/10**. ⚠ Its scope line names `libro/videocorsi`,
   contradicting Elena Spini's own 09/10 status post.
3. 🔴🔑 **[OI-212](../items/OI-212%20A%20Ri.Ba.%20rate%20reads%20as%20paid%20before%20its%20due%20date.md)
   did not move, fourth night**, re-verified byte-for-byte at `a061f55` with no
   commit on either file. **The 13/10 confirmation is tomorrow and the test is now
   on the 14th.**
4. 🆕🔴 **New: [OI-228](../items/OI-228%20The%20nightly%20schedulers%20have%20no%20run-as%20user%20and%20the%20first%20run%20is%20imminent.md)
   — gating, hours not days.** A third manual-step row requires the four nightly
   jobs to run as the Pienissimo administrator and is **blank in UAT as well as
   Prod**, while OI-59 records `QuoteNegotiationAgingBatch` scheduled today with
   its **first run at 03:00 CEST on 13/10**.
5. 🔑 **The ticket-send flows are described as built for the first time** —
   [the specification note](../The%20marketing%20ticket%20send%20logics%20as%20written%20by%20Marketing.md).
   🔑 **It gives OI-225 a candidate mechanism**: a fixed one-minute wait before
   fetching an asynchronously rendered PDF. 🔴 Three unremarked changes from the
   06/10 contract: minutes instead of days, a public link instead of the Asset
   attachment, and WhatsApp absent from the description.
6. 🔑 **New: [the Regole Codifica Codici Articolo workbook](../The%20Regole%20Codifica%20Codici%20Articolo%20workbook.md)**
   — the client's article-code rule, in the registry folder since 21/09 and never
   opened by a sweep. 🟢 Confirms the `Natura` decode, 🔑 delivers the **event
   list** owed since the first sweeps, 🔑 makes OI-48's twin code positional, and
   is the convention OI-98 anticipated. 🔴 Codes for two of ten events.
7. 🔑 **New: [the Evento field on the product](../objects/The%20Evento%20field%20on%20the%20product.md)**
   — `Product2.Evento__c`, the ten events as a restricted picklist. OI-47/OI-76's
   field at last. 🔴 Not in `DevMain`, nothing populates it.
8. 🟡 **[OI-214](../items/OI-214%20The%20Mexal%20order%20send%20requires%20an%20agent%20code%20WooCommerce%20orders%20lack.md)
   gains `Quote.Codice_Agente_Esterno__c` and keeps its gap.** ⚠ One path flagged
   for a human: an order with a Quote `continue`s past the Account fallback.
   🔴 Not in `DevMain`.
9. 🟢 **[OI-14](../items/OI-14%20Marketing%20forms%20and%20subdomain.md) has its first
   artifact** — a `lead-web-to-lead (1).html` sent to Elena Spini. 🔴 The Lead
   fields are still not in Prod.
10. 🆕 **New: [OI-229](../items/OI-229%20A%20Jira%20project%20now%20runs%20alongside%20the%20open%20item%20register.md)**
    — Jira project `PIEN`, created 10/10, invitation **unread**, no stated
    relationship to the `OI-NN` numbering the client-facing tracker uses.

## The register

**Amended? Yes — and that is the finding, not the amendment.** Version stays
**1.6**.

`SAL-20` and three `state_machines.opportunity` rules were changed by
`96d77de`, in the YAML **and** in both prose documents. The skill's own rule —
_"If a requirement changed, update the YAML register **and both** prose
documents"_ — was satisfied mechanically: all three moved in one commit, in the
same session, which is more than most changes on this project manage.

🔴 **What was not satisfied is the authority behind it.** The register is
_"contract-bound and versioned"_ and `notes/` must never restructure it; a
developer commit is not a client ruling, `status` stayed `to_confirm`, and the
version was not bumped.

**This sweep did not touch the YAML.** Reverting it from a note is exactly what
the precedence table forbids, and the new text may well be correct. The
discrepancy is recorded in
[OI-227](../items/OI-227%20SAL-20%20was%20rewritten%20in%20the%20signable%20requirements%20with%20no%20client%20ruling.md)
and left for a human.

⚠ **Candidates for v1.6 once confirmed**, carried forward unchanged: the
renewal-without-DocuSign path, the two-flag Lead consent model, the 21-value
`Tipologia di attività`, `Partita IVA` mandatory at lead conversion, the
per-edizione link scope, `Rinuncia` per edition, `E` counts as paid only once the
due date has passed, and the commercial notification flows. 🔴 **`SAL-20` now
joins them from the wrong direction** — already in the signable text, waiting for
the confirmation that should have preceded it. The carrier is still blocked:
[OI-184](../items/OI-184%20Register%20v1.6%20goes%20to%20the%20client%20as%20one%20change%20set%20at%20UAT%20close.md)
cannot use an unconfirmed text, and the amended logic document's written
confirmation is now **eleven days** unanswered.

## Corrections to the record

- 🟢 **One correction to this run's own working, made before it was written.** A
  first reading of the new manual-steps Apex looked as though
  `MexalCustomerSyncScheduler` was aborted but not re-scheduled. It is
  re-scheduled; all four jobs appear in both halves of the snippet. **No defect
  there**, and none was reported.
- ⚠ **The 09/10 reading of the `Natura` decode is upheld, by a new source.** MAP
  flagged _"first letter biglietto, second bundle"_ as worth a code check because
  it followed a false start in the call. The client's own coding document puts the
  tier at position 3 and the bundle flag at position 4. **The restated reading was
  right.**
- ⚠ **No correction to OI-59.** Its 12/10 section is the developer's own and is
  detailed and candid, including the UAT deployment ids and two self-corrections.
  A pointer to OI-227 was added; nothing in it was rewritten.
- ⚠ **One discrepancy carried forward, not resolved.** The Blueprint signature:
  `#tproj-pienissimo` called it _"confermato e firmato"_ on 09/10 and the record
  holds only _"lo stanno mandando in firma"_ (08/10). **Nothing in this sweep's
  window mentions the Blueprint at all**, so no signed artifact has been seen on a
  second run. No claim either way.

## Not done in this run

- The org was **not** opened. `STATUS.md` was not regenerated and the Notion
  mirror stays stale. Every build claim is repository arithmetic against `DevMain`
  `a061f55`.
- **No Apex test was written, proposed or scaffolded**, per the standing
  instruction. ⚠ Noted only as a fact of the record: PR #94 and both unmerged
  branches carry substantial Apex with every UAT deployment run as `NoTestRun`.
  That is inside the gap
  [OI-64](../items/OI-64%20The%20bundle%20Apex%20test%20suite%20is%20broken.md) and
  [OI-66](../items/OI-66%20No%20test%20classes%20for%20the%20Biglietto%20stack.md)
  describe; **this sweep did not touch either row.**
- **The YAML register was not edited** — see above. OI-227 is the deliverable.
  ⚠ One consequence: `vault:check` now reports **13** non-blocking trace warnings
  rather than 12, because OI-227 cites `SAL-20` and `SAL-20` does not name it
  back. **That backfill was deliberately not run** — it would mean editing the
  register in the same run that reports an unsanctioned register edit. It joins
  the 44 notes already in that state.
- **OI-225 was not fixed and the flow was not opened.** A candidate root cause is
  recorded; confirming it needs org access and a measurement of the render time.
- **OI-212 was not fixed**, a fourth night. The defect is recorded with the file,
  the lines and the formula; the correction is a code change and belongs to Aurel
  Mrruku.
- **OI-223's blast radius was not assessed** — a fifth run.
- **OI-207 was not verified in the org** — a sixth run.
- **The `lead-web-to-lead (1).html` was not opened.** It carries org and field
  ids; nothing tonight needed its contents.
- **The order trigger's `continue` path was not tested.** It is recorded as a path
  with the code quoted, not as a confirmed regression.
- `Campi Oggetti…xlsx` did **not** move and was not re-read.
- `npm run prettier:verify` was not run (no `node_modules`), so tonight's markdown
  is unformatted.
- ⚠ `JOURNAL.md` is at **113 entries** against a documented limit of 20. Archiving
  to `notes/sessions/` is overdue and **was left alone again**.

## Still unreachable

- 🔴 **`Mappatura_Categorie_Sottocategorie_Origine Lead_Tipologiattività.xlsx`**
  — the four Lead picklists, still a **mail attachment only, fifth run**. It
  blocks a commissioned deliverable that now has a Web-to-Lead file waiting for
  it. **Ask Elisa Migliano or Elena Spini to put it in Drive.**
- 🔴 **The 30/07 marketing notes — now with an id.** The `Appunti e Transcrizione`
  link in the `Link utili Pienissimo` canvas resolves to Drive document
  **`1uJCE4NW9nbdI38ADmt66svUT1MRmkyYd24uI0hegAD0`**, which returns _"Requested
  entity was not found"_ for `a.mrruku@romicompany.com`. **Ask Elena Spini to
  share that document.** 🆕 **The only 404 of this run.**
- 🔴 **What was said at the 12/10 client call.** 🆕 The most consequential gap on
  this list: there is no artifact at all, and the client's screen complaints are
  in it. **Ask Elena Spini or Aurel Mrruku what the 16:00 call concluded.**
- ⚠ **Elena Spini's _"notizia bella"_ of 17:46 CEST** — it went into a voice
  huddle. 🆕 Second instance of this trap in a week.
- **`Flows & Objects.drawio`** — moved again 07:43:42Z, still an unparseable
  `mxfile`. **Ask Elena Spini for a PNG or PDF export**, now to see *what
  changed*.
- **The identity of org `00Dbl000005BSMH`** — unchanged, and still the most
  answerable thing here. **Ask Aurel Mrruku or Rexhina Hysi whether OI-225's flow
  error came from production.**
- 🆕 **What is in Jira project `PIEN`** — no connector. **Ask Elena Spini what it
  is for.**
- **The contents of `Regole Codifica Codici Articolo.xlsx` beyond its structure** —
  read, but its code values are deliberately not recorded. **Ask Fabrizio
  Paganelli whether this is the scheme going to direction.**
- **`Campagne Salesforce.xlsx`** — did not move. Still not opened.
- **`Testbook_UAT_Lead_Opportunita_2026-09-24_v2_1.xlsx`** — **did not move**, a
  ninth consecutive run. Approval was due ~13/10, which is tomorrow.
- **The full text of `Pienissimo_Scheda di Partecipazione ai corsi_da firmare.pdf`**
  — not opened; its seven enrolment pages may carry personal data. ⚠ OI-194 is
  still gating and went undiscussed for a thirteenth day.
- ⚠ **The document Rebecca Marmo shared** with Fabrizio Mastracci. Sixth run.
- **The WooCommerce logic document** for Daniela Morgese — seventh run.
- **The 12:30 CEST internal call of 25/09** — still no artifact, thirteenth run.
- ⚠ **The Pienissimo lead documentation** Elena Spini said she owed on 28/09.
- ⚠ **Sabatino Rinaldi's card and PayPal test orders** — WhatsApp is not a source
  this procedure can read.
- **No DocuSign plan document** behind the 2,500-envelope figure.
- ⚠ **The `ai-visibility-fmf` form check** Elena Spini posted on 08/10 — third
  run, screenshot never opened, **still no owner**.
- **The WhatsApp number Matteo Distaso owes Fabrizio Mastracci** — second run; it
  gates the pre-UAT dry run of the two commissioned forms.
- 🆕 **Fabrizio Mastracci's `testlist degli invii`** — named in the marketing DM,
  in no source.

## Absence of evidence, stated as absence

- **Fathom returned no meetings at all** — fifteenth consecutive run with no
  Pienissimo meeting. A pattern about the tooling, not the project.
- **`#tproj-pienissimo` was silent for three days**, after one post on 09/10.
  🔴 **The dev group too: twenty-two consecutive nightly reports with no human
  reply.**
- **Nothing was found on [OI-212](../items/OI-212%20A%20Ri.Ba.%20rate%20reads%20as%20paid%20before%20its%20due%20date.md)**
  in any source — not a mail, a message, a meeting, a commit or a ruling. **Fourth
  night.**
- **Nothing on OI-210** — the `NR_Tranche` / one-article contradiction — in any
  source. **Sixth night.** The new coding scheme has no position for a tranche
  count, so it does not help.
- **Nothing on the Business Blueprint** at all: no signature, no artifact, no
  mention. The 09/10 _"confermato e firmato"_ claim is still unsupported.
- **Nothing on OI-194**, OI-202, OI-204's documentation half, OI-205, OI-206's
  missing reports, OI-216 or OI-218.
- **Nothing on OI-222 or OI-224.** Marco Montesi's original templates question is
  **unanswered an eighth day**, and Sabatino Rinaldi has not answered the
  mass-Opportunity escalation. 🔴 Neither man appears in any source this run.
- **Nothing on OI-226** — no business call booked, no owner, no date for the
  gruppo-merceologico reversal. The Zoho dismissal is **31/10**.
- **Nothing on OI-96's `E10` collision.**
- **No reply to Elena Spini's 12:47:00Z request for written confirmation** of the
  amended logic document, now **eleven days** old.
- **Which agent code to use for an agentless WooCommerce order is still
  unanswered** — OI-214's gating half, and the new Quote field does not supply a
  default.
- **The QR credential rotation has still not happened** — sixth day since it left
  ROMI, and nothing in any source mentioned it.
- **Mirko Merendi's discount call is still unbooked.** It was _"next week"_ as of
  09/10; this week has started and nothing books it.
- **Rebecca Marmo's two funnel questions remain unanswered** — WhatsApp parallel
  or backup, and which event date stops the send. ⚠ Today's flow description
  **omits WhatsApp entirely**, which is not an answer.
- ⚠ **"Claudio" is still unresolved**, credited by Elena Spini on 06/10. **No
  person note was created and nothing was attributed.**
- ⚠ **"Giuliano Lanzetti"**, the sender identity on OI-225's failing email, still
  matches nobody in the records, and no person note was created — nothing
  establishes it is a person rather than a configured org-wide sender.
- **Elena Spini's post-launch support estimate** is not in any source.
