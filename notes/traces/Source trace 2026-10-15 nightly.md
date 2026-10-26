---
id: trace-2026-10-15-nightly
type: reference
status: active
updated: 2026-10-15
watermark_used: 2026-10-14T22:00Z
external_watermark: 2026-10-15T22:00Z
account: a.mrruku@romicompany.com
---

# Source trace 2026-10-15 nightly

**Watermark for the next `requirements-check` run: 2026-10-15T22:00Z, single
value.**

**Watermark used: 2026-10-14T22:00Z**, the `external_watermark` stated by
[the 14/10 nightly trace](Source%20trace%202026-10-14%20nightly.md), selected by
`updated:` frontmatter. Scheduled nightly run, executed 2026-10-15 ~21:50Z.
**One day.**

🔴 **ROMI moved the go-live to 2 November — two days after the Zoho contract
expires — and the client's own product lead had already said on the record, two
hours before the mail went out, that the date cannot be met.**

🟢 **Environment note.** The clone opened on `main` (two commits, config only)
with none of the knowledge layer in the working tree; `DevMain` did not exist
locally and was created with `git fetch origin && git checkout -B DevMain
origin/DevMain`. **Fifteen runs, same opening pattern.** ⚠ `AGENTS.md` still
describes `MAP.md` as _"under 5 KB"_; it is now **~250 KB**. 🟢 The transcript
corpus figures in `AGENTS.md` and `INDEX.md` were corrected tonight (~955 KB →
~1.03 MB, ~239k → ~258k) because this run added a preserved transcript.

## Sources searched

| Source | Query / scope | Result |
| ------ | ------------- | ------ |
| **Gmail** | `pienissimo after:2026/10/14 -in:draft`, 50 requested, 8 estimated | 🔑 **Elena Spini's project-plan mail, 2026-10-15 17:35:47Z, UNREAD** — the go-live move to 02/11, the 27/10 Go/No-Go and the scope freeze. Everything else at or before the watermark and already held |
| **Gmail** | `after:2026/10/14 -in:draft (to:/from:/cc:pienissimo.com OR pienissimo.pro OR kreosoft OR from:gemini-notes@google.com OR subject:ROMI-PIENISSIMO)`, 8 estimated | **Nothing further.** 🔴 **No Gemini notes for the 15/10 session** — unlike 13/10 and 14/10, this meeting produced a transcript but no notes mail. 🔴 **No Kreosoft mail; nothing from Mirko Merendi** — a fifth consecutive run, on the day a fourth ask was pointed at him |
| **Gmail** | `after:2026/10/14 -in:draft (mexal OR biglietto OR bundle OR tranche OR anticipay OR woocommerce OR docusign OR preventivo OR scadenzario OR blueprint OR listino OR e2e OR migrazione OR "go-live" OR formazione OR "key user")`, 14 estimated | Nothing new on this project. Other hits are **other clients** — `[TFP] Data Model` (Teatro Franco Parenti, field-visibility exchanges 15/10), `migrazione dati Brand portfolio` (247.it), `[ROMI-LIFE365]` threads, a Fathom recap for 247 — ignored per the skill |
| **Gmail** | `get_message` (PLAIN_TEXT, full body): Elena Spini's 17:35:47Z mail | 🔑 Read in full, including the quoted 08/09 original beneath it. The three milestones, the freeze wording and the Fase 2 offer commitment are quoted verbatim in [OI-243](../items/OI-243%20Go-live%20moved%20from%2021%20October%20to%202%20November.md) |
| **Slack** | `slack_read_channel C0BQD34LLF4` (dev group), `oldest` 1792015200 = 2026-10-14T22:00Z | **1 message — this procedure's own 14/10 report.** 🔴 **No human reply: twenty-five nights** |
| **Slack** | `slack_read_channel C0B5T3RB4FM` (`#tproj-pienissimo`), same bound | **0 messages.** 🔴 Silent a sixth day |
| **Slack** | `slack_read_channel C0C38JJ9D1T` (marketing group DM), same bound | **0 messages.** ⚠ After 38 yesterday — the `RINUNCIA` thread produced no follow-up and [OI-242](../items/OI-242%20The%20community%20Rinuncia%20button%20must%20show%20the%20public%20refusal%20text.md) is unmoved |
| **Slack** | `slack_read_channel D0B5QHS2T7H` (Elena Spini DM), same bound | 🔑 **7 messages.** The decisive one is **18:33:14 CEST**: _"poi domani mi fai sapere se questa cosa c'è in UAT please? e se non c'è se la possiamo mettere domani dato che me la sono venuta come fatta 🙂"_ — **OI-227, and no reply**. Also 14:31–14:38, before the call: _"ci sei per Pienissimo?"_ and _"il giorno dei morti GO-LIVE … mi serbra azzecato per questo progetto 💀"_ |
| **Slack** | `slack_search_public_and_private` `keywords:[pienissimo] after:2026-10-14`, sorted by timestamp | 4 results, all accounted for: the Elena DM above, this procedure's own 14/10 report, a calendar-bot line, and the sibling LIFE365 report — which independently records _"Elena (PIENISSIMO go-live 02/11)"_, corroborating the date from a second surface |
| **Slack** | `slack_read_canvas F0BD2H5A9HT` (`Link utili Pienissimo`) | **Unchanged.** Newest entry still 20.08.2026 — static **nine weeks**. Re-read per the skill; still the only source of the 30/07 marketing notes link |
| **Drive** | `modifiedTime > '2026-10-14T22:00:00Z'`, **2 pages, 24 files** | 🔑 **`[ROMI-PIENISSIMO] - Migrazione e Go-Live - 2026/10/15 14:31 CEST - Transcript`** (Doc `1XKJ2X4E9ZoD9l_YmbpN3rzHfgOLz_ktXRFbQscTgHVc`, created 13:51:13Z, shared 13:51:26Z) and its folder + shortcut · 🔑 **`Pienissimo_Project Plan v3.pptx`** (`1Gtkfsj9HHKjdI9ySPwQItpzW3XqOmTBu`, created 13:30:01Z, saved 17:14:30Z) · v2 and v1 of the deck **re-saved the same afternoon** (13:38, 13:31) · ⚠ **`Locali Salesforce.xlsx` modified 08:11:07Z** (owner `fabrizio.pienissimo@gmail.com`) — a client migration workbook carrying **real customer data**; recorded as moved and **deliberately not opened** · the rest are **other clients** (permo, 247.it, Vision/`d.losco@`, Daze) — ignored. ⚠ **`Campi Oggetti…xlsx`, `Flows & Objects.drawio`, `Manual Steps Pienissimo` and `Testbook…v2_1.xlsx` did not move** |
| **Drive** | `read_file_content 1XKJ2X4E9ZoD9l_YmbpN3rzHfgOLz_ktXRFbQscTgHVc` | 🔑 **the 15/10 session, 73,596 characters, 01:17:40, read in full in one pass** per `drill-meeting` step 2 (four sequential slices). Completeness checked: it ends on the call sign-off, not mid-sentence. **Preserved verbatim** at `meetings/2026-10-15-migrazione-e-go-live-transcript.it.md` (74,341 bytes) |
| **Drive** | `read_file_content 1Gtkfsj9HHKjdI9ySPwQItpzW3XqOmTBu` | 🔑 **Project Plan v3**: **"GO-LIVE FASE 1 (02/11)"**, **"Approvazione Fase 1 (entro 27/10) Go/No-Go"**, _"UAT Ready Fase 1 (entro 23/09)"_ unchanged. Fase 1 integrations unchanged (WooCommerce, Mexal, Anticipay, App Info Point _"solo update QR code in questa fase"_); ⚠ **the Fase 2 exclusion list did not grow** (GLS, Teachable, Ordini Pienissimo Pro) |
| **Fathom** | `list_meetings created_after 2026-10-14T22:00Z`, summaries, 3 pages | **1 meeting, and it is another client** — `SALESFORCE check tasks to fix`, 247.it. 🟢 **So the tool's health is demonstrated tonight**, unlike 14/10. 🔴 **Eighteenth consecutive run with no Pienissimo meeting**, on a day a Pienissimo meeting took place and was recorded by Google rather than Fathom |
| **Git** | `fetch origin`, `log --all --since 2026-10-14T22:00:00Z` | **2 commits, both human, both outside `DevMain`.** 🔴 **`DevMain` did not move**: it stands at **`544cbfd`**, this procedure's own 14/10 commit. `583efb4` (Anita Aga, `DevAnita15`, 17:16, _"Changed the status of Contract on creation and put 12 as default per contract term field"_) · `102c098` (Rexhina Hysi, `DevMainOpportunityWork`, 10:18) is a **merge of `DevMain` into** her branch — traffic the wrong way. **No PR merged** |
| **Repo** | `MexalScadenzarioSearchService.cls:200-212`; `git log` on it and on `Pagata__c`; `git ls-tree -r origin/DevMain | grep Totale_Listino` | 🔴🔑 **OI-212 byte-for-byte unchanged, seventh night** — `paid = P \|\| E`, no date condition; the class was last touched by `f292b72` on **08/10** for an unrelated reason (_"without sharing class"_), `Pagata__c` by `731c7ac` on 06/10 · 🔴 **`Totale_Listino__c` and `Sconto_Totale__c` are absent from `origin/DevMain`** — OI-207's build is outside the branch a third night |

## Found

1. 🔴🔑 **New: [OI-243](../items/OI-243%20Go-live%20moved%20from%2021%20October%20to%202%20November.md)
   — go-live is 02/11, Go/No-Go 27/10, and the perimeter is frozen.** Sent
   17:35:47Z into the same thread as the 6 → 21 October move, with Project Plan
   v3 matching. 🟢 ROMI committed in writing to send a **Fase 2 offer and plan**
   — a first. 🔴 **The register was deliberately not moved** (see below).
2. 🔴🔑 **New: [the Zoho gap](../risks/Risk%20-%20go-live%20now%20falls%20after%20the%20Zoho%20contract%20expires.md)
   — gating.** Zoho expires **31/10**; go-live is **02/11**. The dual-run overlap
   went 25 days → 10 → **minus two**. ⚠ **Zoho is named nowhere in the session or
   the mail**, and the register still assumes _"~3 weeks"_.
3. 🔴🔑 **New: [OI-246](../items/OI-246%20Key%20User%20training%20cannot%20be%20completed%20before%20the%20new%20go-live.md)
   — gating.** Fabrizio Paganelli said twice that 02/11 cannot be met, on
   training grounds, **before the mail was sent**, and that he can sign off only
   orders and invoicing. **The 27/10 Go/No-Go would cover a third of the system.**
4. 🟢🔑 **New: [OI-244](../items/OI-244%20Historical%20orders%20will%20be%20migrated%20from%20Mexal%20by%20spreadsheet.md)
   — the first migration method the project has agreed**, and the source moved
   from **Zoho to Mexal**. Field spec owed by Aurel Mrruku **16/10 evening**;
   state **derived**, not imported; loads twice, the real one on go-live day.
5. 🔴 **New: [OI-245](../items/OI-245%20Whether%20a%20Mexal%20order%20survives%20invoicing%20is%20disputed.md)
   — gating, blocks OI-244.** Aurel Mrruku (citing Mirko Merendi **and an
   observed API symptom**) against Fabrizio Paganelli on whether an invoiced
   order survives in Mexal. ⚠ Both may be true — API surface vs database archive
   — recorded as a hypothesis, not a finding.
6. 🔴 **New: [OI-247](../items/OI-247%20Only%20the%20responsabile%20commerciale%20may%20edit%20the%20provvigioni%20fields.md)**
   (the commission section editable by Marco Montesi alone; the control is
   **customer ownership**) · **[OI-248](../items/OI-248%20The%20Account%20agent%20and%20provvigioni%20fields%20are%20stale%20against%20the%20User%20record.md)**
   (the client found stale agent/provvigioni fields on screen; orders unaffected)
   · **[OI-249](../items/OI-249%20An%20agent%20reassignment%20reaches%20Mexal%20only%20at%20the%20next%20order.md)**
   (no update action; bulk reassignment leaves Mexal stale indefinitely).
7. 🔴🔑 **[OI-227](../items/OI-227%20SAL-20%20was%20rewritten%20in%20the%20signable%20requirements%20with%20no%20client%20ruling.md)
   escalated: she has told the client it is built.** _"me la sono venuta come
   fatta"_ — read as _venduta_ — plus a request to build it tomorrow if absent.
   **Three messages in two days, no reply**, and `SAL-20` was never raised in a
   77-minute session with both of them present.
8. 🟢 **[OI-222](../items/OI-222%20The%20commercial%20mail%20and%20WhatsApp%20notification%20flows%20are%20unspecified.md)
   has a client-side ruling at last** — Sabatino Rinaldi, for Marco Montesi:
   _"questa non è una priorità"_. ⚠ Marco Montesi had not read the mail and was
   not in the room.
9. 🟢 **[OI-240](../items/OI-240%20Marco%20Montesi%20needs%20a%20Salesforce%20user%20before%20go-live.md)
   answered** — System Admin now, profile later, Elena Spini guiding him from
   Mon 19/10. 🔴 **Three requirements now wait on profiles that do not exist**
   ([OI-186](../items/OI-186%20The%20Salesforce%20user%20list%20and%20profiles%20were%20never%20agreed%20with%20the%20client.md)).
10. 🟢 **[OI-234](../items/OI-234%20Tranche%20invoicing%20when%20the%20customer%20changes%20legal%20entity%20mid-order.md)
    accepted into Fase 2 by the client** — _"Va bene, va bene"_. ⚠ Undercut by
    Elena Spini herself seconds later.
11. ⚠ **The duplicate-agent-code problem resurfaced and dissolved without a
    decision** ([OI-169](../items/OI-169%20Agent%20code%20and%20commissions%20come%20from%20the%20customer%20record.md)) —
    no owner, no row of its own, and ~10,000 orders a year about to load carrying
    agent references.
12. 🔴 **[OI-212](../items/OI-212%20A%20Ri.Ba.%20rate%20reads%20as%20paid%20before%20its%20due%20date.md)
    did not move, seventh night** — and OI-244 would apply the broken predicate
    at migration scale on go-live day.
13. 🔴 **[OI-207](../items/OI-207%20The%20quote%20and%20order%20layouts%20omit%20the%20commercial%20fields%20the%20client%20requires.md)
    still outside `DevMain`, third night**, and tonight's merge went the wrong way.

## The register

**Not amended. Version stays 1.6, `go_live:` stays `2026-10-21`.**

🔑 **The go-live date is the one thing in this sweep that plainly belongs in the
register — and the rule for when it moves was written by
[OI-124](../items/OI-124%20Go-live%20moved%20from%206%20to%2021%20October.md) and
then validated by events.** That row's instruction: _"The date has been proposed
to the client in writing but not yet accepted. This sweep left the register at 6
October for that reason — the Italian is the operative text and it is not moved
by a mail that is still awaiting reply."_ The register moved on 9 September, the
same day Fabrizio Paganelli replied _"presa visione"_.

Tonight the mail is **four hours old and unanswered**, so the same rule applies.
⚠ **And there is a second reason this time that did not exist in September**: the
client's product lead disputed the proposed date on the record **before the mail
was sent**. A register change made tonight would record as contractual a date one
party has already rejected verbally.

**When the acknowledgement lands**, nine places change in one session across
three files — `CTX-02`, the `M` priority key, both milestone tables, the §14 Fase
2 rule, `go_live:` — **and `requirements/pienissimo-requirements.yaml:469`'s
dual-run assumption must change with them**, because _"Zoho expires 31 October
2026; dual-run window is ~3 weeks"_ is no longer true in direction, not merely in
degree.

⚠ **`SAL-20` was left alone a fourth night** — and for the first time that is a
decision with a deadline. The correct edit now depends on an answer Elena Spini
asked for by tomorrow. **This is the last night that reasoning holds.**

⚠ **Nothing else found tonight calls for a register change.** The three new
permission and agent items (OI-247, OI-248, OI-249) are build detail below the
register's grain; the migration method (OI-244) is a plan, not a requirement; and
the scope freeze is a project-governance statement the client has not accepted.

## Corrections to the record

- ⚠ **The transcript's dictation is bad and was read through, not quoted
  literally.** It renders the ERP as _"Maxal"_, _"Maxile"_, _"Mexale"_, _"Exale"_
  and once _"Zomexal"_; `l'agente` as _"la gente"_ throughout; Zoho as _"Zoo"_;
  API as _"EPI"_/_"PI"_; copy as _"COPI"_; and `go-live` as _"goive"_/_"gole"_.
  Each is flagged in the meeting note rather than silently normalised, and
  square-bracket insertions mark every repair inside a quotation.
- ⚠ **_"me la sono venuta come fatta"_ is read as _venduta_** — _I have sold it
  as done_. The reading is this sweep's; it is stated as such in
  [OI-227](../items/OI-227%20SAL-20%20was%20rewritten%20in%20the%20signable%20requirements%20with%20no%20client%20ruling.md),
  and no other reading of the sentence is available.
- ⚠ **Two volume figures a minute apart were both recorded, not reconciled.**
  _"20.000 record"_ was given as _"un numero a caso"_; **~51,000** is order
  **lines** since 01/01/2023; **~10,000/yr** is his own reading. **Orders and
  order lines are different counts and the session mixed them** — said so rather
  than picking one.
- ⚠ **The attendee list is not the list of participants.** Elisa Migliano is in
  the transcript header and **never speaks**; Sabatino Rinaldi leaves at ~`00:20`.
  Recorded, because a reader would otherwise attribute the last hour's decisions
  to five people.
- ⚠ **The OI-245 reconciliation is labelled a hypothesis.** The reading that both
  men are right — absent from the API, present in the archive — is this sweep's
  and **nobody said it in the room**. It is not recorded as the answer.
- 🔴 **A pre-existing tracker defect was found and deliberately not "fixed".**
  Rows **163–174 are duplicated** in `meetings/open-items.md` **and** `.it.md`,
  both copies inside the same `## Open` section, and **the two copies are not
  identical** (163, 165, 166, 167, 168, 169, 173, 174 differ; 170–172 match). It
  predates this run — `git show HEAD:meetings/open-items.md` carries the same
  duplication. **Deleting either copy would lose content**, so tonight's
  last-touched refresh was applied to **both** copies of 165, 169 and 172 and the
  defect is reported instead. It needs a human to say which copy is current.

## Not done in this run

- The org was **not** opened. `STATUS.md` was not regenerated and the Notion
  mirror stays stale. Every build claim is repository arithmetic against `DevMain`
  `544cbfd`.
- **No Apex test was written, proposed or scaffolded**, per the standing
  instruction. [OI-64](../items/OI-64%20The%20bundle%20Apex%20test%20suite%20is%20broken.md),
  [OI-66](../items/OI-66%20No%20test%20classes%20for%20the%20Biglietto%20stack.md) and
  [the deploy risk](../risks/Risk%20-%20production%20deploy%20is%20blocked%20by%20Apex%20coverage.md)
  were not touched; nothing tonight changed their state.
- **The YAML register was not edited** — see above.
- **OI-212 was not fixed**, a seventh night. The correction is a code change and
  belongs to Aurel Mrruku.
- **Neither failing flow was opened** (OI-225, OI-230). They are org-only and
  read-only here; `Get Campaign` is still unchased.
- **`Locali Salesforce.xlsx` was not opened** — a client migration workbook with
  real customer data, correctly excluded by the 23/09 sweep on the same grounds.
  Its modification is recorded; its contents are not.
- **The 13-of-23 empty-category failure still has no tracker row**, as on 14/10.
- **`DTT SHR Mappatura form handler campi.xlsx` was not opened** — unchanged
  since 14/10, so no new evidence either way. ⚠ The question of whether `DTT` is a
  Pienissimo artefact is **still unanswered and still in tonight's list**.
- **The three images from 14/10 were not opened.**
- **OI-223's blast radius was not assessed** — an eighth run.
- **OI-207 was not verified in the org** — a ninth run.
- ⚠ `JOURNAL.md` is at **122 entries** against a documented limit of 20.
  Archiving to `notes/sessions/` is overdue and **was left alone again**.
- `npm run prettier:verify` was not run (no `node_modules`), so tonight's
  markdown is unformatted.

## Still unreachable

- 🆕 🔴 **What happens to Zoho CRM after 31 October** — read-only, a grace period,
  or data loss, and whether the contract can be extended. **No source in this
  repository says**, and the go-live is now after it.
  **Ask Fabrizio Paganelli or Sabatino Rinaldi.** One question settles the
  severity of the whole Zoho risk.
- 🆕 **How many contracted training hours exist and whether they cover eight
  users.** Elena Spini said _"abbiamo comunque ore di formazione a disposizione"_;
  nothing records the number (OI-246).
- 🆕 **Whether Marco Montesi accepts the train-the-trainer role.** Fabrizio
  Paganelli explicitly deferred it to him — _"anche qui ti dovrebbe rispondere
  Marco e non io"_.
- 🔴 **`Mappatura_Categorie_Sottocategorie_Origine Lead_Tipologiattività.xlsx`**
  — the four Lead picklists, still a **mail attachment only, eighth run**.
  **Ask Elisa Migliano or Elena Spini to put it in Drive.**
- 🔴 **The 30/07 marketing notes** — Drive id
  **`1uJCE4NW9nbdI38ADmt66svUT1MRmkyYd24uI0hegAD0`**, from the canvas, 404 for
  `a.mrruku@romicompany.com`. **Ask Elena Spini to share it.** Fourth run with a
  precise id.
- **What was agreed in the 14/10 15:35:52 marketing huddle** about the `RINUNCIA`
  text. Voice is not a source this procedure can read, and the marketing DM was
  silent today. **Ask Aurel Mrruku or Elena Spini.**
- **Whether `DTT SHR Mappatura form handler campi.xlsx` is a Pienissimo
  artefact.** One question to Elena Spini settles it. Second run.
- **Which bug Elisa Migliano was asked to report** on 14/10. She did not speak in
  today's session.
- **The identity of the DocuSign production configuration** — templates, sending
  identity, envelope allowance. **Ask Elena Spini or Sabatino Rinaldi.** ⚠ Nothing
  on [OI-231](../items/OI-231%20DocuSign%20closed%20the%20Pienissimo%20onboarding%20for%20non-response.md)
  in any source today: the client is unanswered a **third** day.
- **`Flows & Objects.drawio`** — did not move; still an unparseable `mxfile`, and
  still cited as the authority for the as-is. **Ask Elena Spini for a PNG or PDF
  export.**
- **Which WooCommerce instance is correct for books and videocorsi, and when the
  orders move.** **Ask Sabatino Rinaldi** (OI-241). He was in the room today and
  it was not raised.
- **What `Get Campaign` is looking for** in both failing flows. Needs the org.
- **What is in Jira project `PIEN`** — no connector. **Ask Elena Spini.**
- **Which profile a _responsabile commerciale_ holds, and which a tutor** —
  OI-247, OI-240 and OI-233 cannot be built without them.
- **The contents of `Regole Codifica Codici Articolo.xlsx` beyond its structure**
  — read, code values deliberately not recorded.
- **`Campagne Salesforce.xlsx`** and **`Locali Salesforce.xlsx`** — client
  migration workbooks with real customer data; the latter **moved today** and was
  not opened.
- **`Testbook_UAT_Lead_Opportunita_2026-09-24_v2_1.xlsx`** — **did not move**, a
  twelfth consecutive run. Approval was due ~13/10.
- **The full text of `Pienissimo_Scheda di Partecipazione ai corsi_da firmare.pdf`**
  — not opened; its enrolment pages may carry personal data. ⚠ OI-194 is still
  gating and went undiscussed a **sixteenth** day.
- ⚠ **The document Rebecca Marmo shared** with Fabrizio Mastracci. Ninth run.
- **The WooCommerce logic document** for Daniela Morgese — tenth run.
- **The 12:30 CEST internal call of 25/09** — still no artifact, sixteenth run.
- ⚠ **The Pienissimo lead documentation** Elena Spini said she owed on 28/09.
- ⚠ **Sabatino Rinaldi's card and PayPal test orders** — WhatsApp is not readable
  here.
- ⚠ **The `ai-visibility-fmf` form check** Elena Spini posted on 08/10 — sixth
  run, screenshot never opened, **still no owner**.
- **The WhatsApp number Matteo Distaso owes Fabrizio Mastracci** — fifth run.
- **Fabrizio Mastracci's `testlist degli invii`** — fourth run, in no source.

## Absence of evidence, stated as absence

- 🟢 **Fathom is healthy** — it returned a meeting tonight (another client), so
  unlike 14/10 the empty Pienissimo result is a demonstrated negative. 🔴 **But
  eighteen consecutive runs with no Pienissimo meeting**, and today a Pienissimo
  meeting happened and was captured by Google, not Fathom.
- 🔴 **No Gemini notes mail for the 15/10 session**, unlike 13/10 and 14/10 — only
  a transcript. Whether notes were disabled or merely not sent is unestablished.
- **`#tproj-pienissimo` silent a sixth day.** The marketing group DM silent too,
  after 38 messages yesterday. 🔴 **The dev group: twenty-five consecutive nightly
  reports with no human reply.**
- **Nothing was found on [OI-212](../items/OI-212%20A%20Ri.Ba.%20rate%20reads%20as%20paid%20before%20its%20due%20date.md)**
  in any source — not a mail, a message, a meeting, a commit or a ruling. Seventh
  night; the confirmation date is three days past.
- 🔴 **Nothing from Mirko Merendi, and no Kreosoft mail at all** — a fifth
  consecutive run, on the day a **fourth** ask was pointed at him. Fabrizio
  Paganelli's 13/10 undertaking to contact him remains unrecorded.
- **Nothing on the Business Blueprint signature** — the 09/10 _"confermato e
  firmato"_ claim is unsupported a **fifth** run.
- **Nothing on OI-231** (DocuSign onboarding closure) — the client is unanswered a
  third day, and Sabatino Rinaldi was in the room.
- **Nothing on OI-194**, OI-202, OI-204's documentation half, OI-205, OI-206's
  missing reports, OI-216, OI-218, OI-225, OI-230, OI-232, OI-235, OI-236,
  OI-237, OI-238, OI-239, OI-241 or OI-242.
- **Nothing on OI-224.** Sabatino Rinaldi was present for twenty minutes and the
  mass-Opportunity escalation was not raised.
- **Nothing on OI-233** — no profile named for a tutor, six days on, while OI-247
  adds a second undefined role to the same gap.
- **Nothing on OI-96's thirteen remaining empty categories or the `E10`
  collision** — and no row for them still.
- **Which agent code an agentless WooCommerce order uses is still unanswered**
  (OI-214).
- **The QR credential rotation has still not happened** — ninth day.
- **Rebecca Marmo's two funnel questions remain unanswered**, and she was named in
  today's session as someone who will react to a flow she has not seen.
- ⚠ **"Claudio" is still unresolved**, credited by Elena Spini on 06/10.
- ⚠ **"Giuliano Lanzetti"** and **"Tech Romi" (`005SW00000PV5Ja`)** still match
  nobody. ⚠ **"Davide Stefani" recurs a second session**, now with **"Carmine"**
  and **"Carmen Troiano"**, all three used as on-screen agent examples; none has a
  person note and nothing establishes whether they are agents, contacts or test
  records.
- **Elena Spini's post-launch support estimate** is not in any source — and the
  plan deck still carries only _"Supporto post go-live"_ with no content.
