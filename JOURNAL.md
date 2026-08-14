# Journal - Pienissimo

Append-only session handoffs. Newest first. Any agent, any model, writes here
at the end of a session that changed project state, so the next one can resume
cold. Format and intent:
[notes/Retrieval and write protocol.md](notes/Retrieval%20and%20write%20protocol.md).

Keep the ten most recent entries here; archive older ones to
`notes/sessions/YYYY-QN.md`.

---

## 2026-08-15 — claude — transcripts linked to their recaps

- **Did:** turned the transcript path in the `Sources:` / `Fonti:` line of all
  **18** files in `meetings/results/` into a relative Markdown link
  (`[meetings/<name>-transcript.it.md](../<name>-transcript.it.md)`). The
  rendered text is unchanged — the path was already written there as plain text
  in 16 files and inside backticks in the 2026-08-06 pair; only the link markup
  is new, so the preserved record still reads exactly as before. The transcripts
  themselves were **not** touched. Added the rule to step 4 of
  `drill-meeting/SKILL.md` in both `.agents/` and `.claude/` so new meetings get
  the link by default.
- **Why:** Aurel noticed the Obsidian graph was full of floating nodes. The
  cause: the vault root is the repo root, and the transcript↔recap relationship
  was recorded as text, not as a link. Isolated files went **23 → 2**; the two
  left are the `meetings/proposals/`. `vault:check` passes (87 notes).
- **State — the graph is still 10 components, not 1.** The nine meeting
  clusters (transcript + EN recap + IT recap) are now internally connected but
  **eight of them still hang off the main graph**, because nothing links their
  recap. Only 2026-08-06 is attached, via a single link in
  [INDEX.md](INDEX.md). The reason is systemic: **70 notes cite their meeting
  through the frontmatter field `source: meetings/results/…`, which is a bare
  YAML string and produces no graph edge.** The same applies to `depends_on:`
  and `blocks:` — the dependency structure is invisible in the graph. Wikilinks
  would fix it but are banned for portability, so the fix has to be body-level
  Markdown links.
- **Next:** either list all nine recaps in `INDEX.md` (one edit, attaches every
  cluster) or add a body-level `**Source:**` link to the ~70 notes that carry
  the frontmatter field (heavier, but makes the citation trail real). Neither
  is done. `meetings/proposals/` (2 files) is linked from nowhere at all.

---

## 2026-08-15 — claude — requirement trace, tickets batch

- **Did:** re-derived the `tickets` area. **10 notes mapped to 8 `BIG`
  requirements**, written in both directions (`requirement:` on the note,
  `tracked_by:` on the requirement) and verified by `vault:check`, which now
  reports `8/137 reachable` with **zero** disagreements. Mappings:
  `BIG-01←flow-ticket-lifecycle` · `BIG-02←OI-53,OI-77` · `BIG-03←obj-biglietto`
  · `BIG-04←OI-76` · `BIG-06←OI-81` · `BIG-09←OI-57` · `BIG-17←OI-74` ·
  `BIG-18←OI-78,OI-86`.
- **🔴 Found `RC-06`: four requirements still encode signature in the ticket
  flow** — `BIG-01`, `BIG-12`, `BIG-19`, `BIG-21` — after 2026-08-06 struck it
  outright ("Participants sign on paper at check-in; DocuSign applies only to
  quotes and contracts"). `BIG-01` is the four-stage lifecycle naming the phases
  of the whole flow, so the stale wording is load-bearing: anyone building from
  the signed document builds a cancelled signature step. Recorded as a
  reconciliation entry on Aurel's instruction; **no requirement text changed**,
  because that edits `REQUISITI.it.md`. **The correction is still owed.**
- **Two register gaps, both deliberate non-mappings.**
  [OI-75](notes/items/OI-75%20Ticket%20availability%20rule.md) — the rule
  releasing a ticket when the tranche invoice is paid in full, which the entire
  flow keys on — **has no requirement id at all**. And
  [OI-84](notes/items/OI-84%20Campaign%20Member%20handling%20for%20manual%20check-in.md),
  manual check-in issuing no QR, is covered by nothing; what breaks is `DAT-03`.
  Full Tier C list in
  [the fabricated-mappings note](notes/The%20requirement%20mappings%20were%20fabricated.md).
- **Method, and why:** batch by the register's own `area:` field — ~20
  requirements per batch instead of 132. Text-similarity scoring was built and
  **rejected**: it produced 28 confident matches, most wrong, because a
  four-word requirement whose words all appear in a long note scores 1.00. That
  is almost certainly how the original 23 were fabricated. The rule is now **a
  mapping needs a quotable sentence**. Written up as a fifth skill,
  `requirement-trace`, in `.agents/` and `.claude/`, registered in `AGENTS.md`
  and `CLAUDE.md`.
- **Next:** five batches left — `SAL` 23, `INT` 22, `BUN` 20, `ORD` 15, and
  data/marketing/nfr/context 28. Run `/requirement-trace` per area. Also note
  **16 of 24 `BIG` requirements have no note**; worth a pre-sign-off pass to
  check none is unbuilt and untracked.

---

## 2026-08-15 — claude — 🔴 the note-to-requirement mappings are fabricated

- **Finding, and it is serious.** Trying to make requirements traceable back to
  the meetings that produced them, the existing `requirement:` frontmatter
  fields turned out to be **generated by arithmetic, not by matching content**.
  In the 2026-08-06 cluster the id is literally `BIG-(OI number minus 69)`:
  - `OI-74` *Asset state machine* → cites **BIG-05** *"Participants are not
    account contacts"*. The note is entirely the six-value Asset status
    picklist, i.e. **BIG-17**.
  - `OI-75` *Ticket availability rule* → cites **BIG-06** *"Reminder funnel
    cadence"*. Unrelated; the note is tranche-paid-in-full release.
  - `OI-78` *Participant data collection* → cites **BIG-09** *"Zero-euro orders
    stay in the CRM"*. Unrelated; the note is the participant landing page,
    i.e. **BIG-18/BIG-19**.
  - `OI-50` *Tranche object* → cites **ORD-06** *"Order types"*. Its body is
    verbatim **ORD-01** *"Tranches auto-created from order-line due dates"*.
  - `OI-43` *Spread variance does not block saving* → cites **BUN-04**. Its
    body is verbatim **BUN-17** *"A non-zero spread variance must block
    saving"*.
  - `OI-47` cites **PRD-04**, and there is no PRD prefix in the register at
    all. Probably **BUN-12/BUN-13**, the two product flags.
  **Five of five spot-checks were wrong.** Treat all 23 `requirement:` fields as
  unverified until re-derived from the note bodies.
- **Did NOT write them into the register.** A `tracked_by:` reverse index was
  built and then **reverted** — mirroring fabricated mappings into the
  contract-bound YAML would have laundered them into the document Pienissimo
  signs. `requirements/pienissimo-requirements.yaml` is untouched at HEAD.
- **Did:** taught `scripts/vault-check.mjs` to trace notes against the register
  in both directions — unknown requirement ids are reported per-note, and
  un-backfilled ones as a single count. **Warnings, never errors**, so the
  nightly routine (which commits only on exit 0) stays green. It currently
  reports `0/137 reachable`, the PRD-04 break, and 22 one-way citations. Added
  the both-directions rule to step 4 of `drill-meeting` and step 4.3 of
  `drill-me`, in both `.agents/` and `.claude/`.
- **Aurel chose the safe path, and it is done:** all **23** `requirement:`
  fields were **stripped** from the notes rather than left wrong, and every
  discarded claim is preserved in
  [the fabricated-mappings note](notes/The%20requirement%20mappings%20were%20fabricated.md)
  with a first-impression assessment per row, so re-derivation starts warm
  instead of from nothing. `updated:` bumped on all 23. Nothing else in those
  files changed — the diffs are two lines each.
- **The register was never written to.** It is untouched at HEAD. `tracked_by:`
  belongs there only after the 56 mappings are re-derived and checked.
- **Also unverified:** `AGENTS.md` states the item numbers are cited in
  `REQUIREMENTS.md`. Measured: **zero** `OI-nn` or `#nn` references in either
  `REQUIREMENTS.md` or `REQUISITI.it.md`, and zero links into `notes/` or
  `meetings/` from either. The claim may hold for the published artifacts and
  the client's correspondence, which were not checked.

---

## 2026-08-14 — claude — nightly requirements-check scheduled

- **Did:** created cloud routine `trig_01VCdUXmqy8PngWPJHA2dSYC` —
  **Mon–Fri 23:30 Europe/Budapest** (`30 21 * * 1-5` UTC), reporting to Slack
  group DM `C0BQD34LLF4` (Aurel, Anita Aga, Sara Aga). Full configuration in
  [docs/task-status.md](docs/task-status.md). First run **Mon 17 August**.
- **State:** it **commits directly to DevMain**, Aurel's explicit choice over a
  PR-based flow. Guarded: it commits only if `npm run vault:check` passes, and
  on failure commits nothing and leads its report with the failure. No-change
  runs write nothing and keep the existing watermark.
- **The skill had to change.** `requirements-check` guardrails said "never send a
  chat message", which would have made the routine refuse to post. Added **one
  explicit carve-out** naming that single group DM, mirrored to `.agents/`.
  **Do not widen it** — everything else stays read-only.
- **Watch:** ⚠ **the cron is fixed UTC and DST will break it.** Budapest leaves
  CEST on **25 October 2026**; after that it fires at 22:30 local. Change the
  cron to `30 22 * * 1-5` then.
- **Corrections, same day.** I reported that **Rexhina was unreachable on
  Slack** — wrong. I had searched four names in one query and got nothing;
  searching her name alone returns her immediately
  (`U0B36MRLJUV`, `r.hysi@romicompany.com`). Aurel then added her to the
  conversation by hand; **the channel id did not change**, so the routine still
  points at `C0BQD34LLF4` and now reaches all four developers.
- **Her surname is now known: Hysi**, supplied by Aurel on 2026-08-14 and
  matching the sister project's records. The person note was **renamed**
  accordingly — filename, H1 and all four inbound links — since the filename is
  the note's title.
- **Model set to `claude-opus-5`**, on Aurel's instruction, matching the sister
  project. The `schedule` skill defaults to Sonnet, so a future edit that resends
  `job_config` without the model will silently downgrade it — the model lives
  inside `session_context` and a partial update replaces the whole block.

- **Did:** R1 and R2. Added **§12 to `DEVELOPMENT-RECAP.md` and `.it.md`** — nine
  subsections, both twins in the same session, precedence headers updated so §12
  wins. Corrected the diagram provenance dates in the register, `README.md`,
  `REQUIREMENTS.md` and `REQUISITI.it.md`.
- **Correction, and it matters.** I had claimed the register and the prose
  carried stale state names, and recommended R2 on that basis. **They did not.**
  The register already held `In attesa di accettazione`, `Annullato`, six asset
  states, the tranche states, and `preventivo scaduto` documented as a retired
  label. Notes that over-claimed — OI-50, OI-59, OI-74, OI-69 and
  [the diagram note](notes/The%20newest%20design%20diagram.md) — have been
  corrected. **Verify before asserting a document is stale.**
- **State:** two genuine gaps were found. `order.states` still reads
  `[CREATO, CHIUSO/ACQUISITO]` against the 06/08 decision of
  `Ordinato → Fatturato → Incassato` — now marked `status: conflict` in the
  register with Elena Spini as owner. And `opportunity_types` was missing
  `Plus + Attivazione o Rinnovo`, now added.
- **Next:** **R2b** — get Elena to say whether `Incassato` is `CHIUSO/ACQUISITO`
  renamed. It is the same question as A2 on the board and it blocks configuring
  both `Order` and `Tranche__c`.
- **Watch:** §12 is now the top of the precedence chain in both recaps. Anything
  written after this must either fold into §12 or open §13.

---

## 2026-08-14 — claude — action board opened

- **Did:** created [docs/task-status.md](docs/task-status.md), a **ROMI-internal
  action board** modelled on the sister project's. It holds chores,
  confirmations and repo work that must **not** consume an `OI-NN`, because that
  numbering is client-facing and cited in `REQUIREMENTS.md`. Linked from
  [MAP.md](MAP.md) and [INDEX.md](INDEX.md).
- **State:** six actions for Aurel (A1–A6), four repo tasks (R1–R4). **A6 is
  already sent** — he replied on the *"Lista Eventi, Codici prodotto, esempio
  Bundle"* thread on 14/08 to establish what Fabrizio delivered on 07/08;
  [OI-46](notes/items/OI-46%20Bundle%20classification%20picklists.md) and
  [OI-48](notes/items/OI-48%20Bundle-only%20article%20codes.md) now record that
  and are **waiting on Elena**, who returns 17 August.
- **Next:** **R2 first** when work resumes — re-merging the diagrams into the
  register and correcting the "31 July" claim. It is the only queued task with
  contractual consequence: `REQUISITI.it.md` goes to Pienissimo for signature
  and currently carries state names the design has moved past. Then R1.
- **Watch:** A4 (retrieving the six Biglietto classes into `force-app/`) is
  **source control, not test work** — it is deliberately outside the test-suite
  deferral and should not be swept up in it.

---

## 2026-08-14 — claude — newest diagram and the Mexal workbook drilled

- **Did:** decoded `Flows & Objects.drawio` (all three pages) and parsed
  `Integrazioni pienissimo.xlsx`, which Aurel downloaded manually after no
  connected tool could reach it.
- **State:** 🔴 **`Get Fatture` maps `numero_ordine` but no order-*line*
  number** — the key
  [OI-75](notes/items/OI-75%20Ticket%20availability%20rule.md) was agreed to match
  on. Mapping gap, not a Mexal limit; the line data is in the per-document call.
  **Raise at the 27 August call.** The diagram also settles three disputes with
  the prose: asset states are six with the sixth named **`Annullato`** (not
  "rinuncia al servizio"), `CHIUSO/ACQUISITO` **still appears** on the Ordini
  page after the session deleted it, and the quote state _Scaduto_ was renamed
  **`In Attesa Accettazione`**. Tranche states appear for the first time.
- **Next:** confirm `CHIUSO/ACQUISITO` with Elena — the tranche rule depends on
  it. Re-merge the diagrams into the register.
- **Watch:** ⚠ **the register is reading stale copies.** It records both diagrams
  as modified 31 July; Drive says **6 August** and **4 August**. `README.md` and
  `REQUIREMENTS.md` repeat the 31 July date. Anything "extracted verbatim from
  the diagrams" needs re-checking — see
  [the newest design diagram](notes/The%20newest%20design%20diagram.md).
- **Note:** both the diagram and the Mexal workbook use **real customer data** as
  worked examples — a named company with VAT, address, phone, email and PEC.
  Recorded as a hazard; the values are not reproduced in `notes/`.

---

## 2026-08-14 — claude — client documents drilled

- **Did:** drilled `01 Documenti forniti dal cliente/`, located the untracked
  16/07 internal meeting, and chased the two artifacts that could not be read.
- **State:** the find is
  [the client's own 11 June requirements document](notes/The%20client%20June%20requirements%20document.md) —
  seven pages, 13 numbered questions to ROMI, an internal owners table, and in
  no tracker. It is the **origin of `rinuncia al servizio`** (a Fabrizio-owned
  requirement, not an August addition), it yielded
  [OI-90](notes/items/OI-90%20Whether%20to%20introduce%20a%20Prospect%20state.md),
  and it puts **GLS, Teachable and Pienissimo Pro in writing on 11 June**.
- **Next:** open `Integrazioni pienissimo.xlsx` manually before 27 August — the
  per-field mapping is in the workbook, not in Mirko's mail body.
- **Watch:** the June document is **not** pre-sale evidence — 11 June is after
  the 27 May kickoff. It shows the topics were raised early and formally, which
  is why the client is confident, but the question that decides
  [the dispute](notes/risks/Risk%20-%20the%20phase%202%20scope%20dispute%20is%20unresolved.md)
  is whether they were **in the contract**. Do not present it as settling
  anything.
- **Tool limits, recorded so nobody repeats the attempt:** Gmail exposes
  attachment metadata but has **no download tool**; Drive cannot render
  `.drawio` as text. Both are noted in the trace with the fallback.

---

## 2026-08-14 — claude — full history sweep from April, all attachments read

- **Did:** swept Gmail from 2026-04-01 (67 threads, two pages, four query
  angles) and the entire `[Pienissimo] Fase Progettuale` Drive folder including
  both subfolders. Read every reachable attachment.
- **State:** 🔴 **The binding deadline is 10 September, not 6 October.**
  `Pienissimo_Project Plan.pptx` (Elena, 10 July, never read until today) sets
  _Fine sviluppi Fase 1 entro 10/09_, with UAT, training and the data import
  between that and go-live — and a **second go-live on 9 November** for Fase 2
  that appears in no meeting record. Full dates now in
  [OI-04](notes/items/OI-04%20Scope%20against%20the%20go-live%20date.md) and
  [the calendar risk](notes/risks/Risk%20-%20the%20whole%20remaining%20build%20lands%20after%20Ferragosto.md).
  The same deck lists GLS, Teachable and Zoho-for-Pienissimo-Pro as **Fase 2**,
  which is genuinely two-edged evidence in
  [the dispute](notes/risks/Risk%20-%20the%20phase%202%20scope%20dispute%20is%20unresolved.md).
- **Next:** ingest what this sweep found but did not drill — a **NotebookLM
  notebook** and a **LastPass folder** (both shared 25 June, referenced
  nowhere), a **third design diagram**, and **four ROMI-internal meetings** with
  Gemini notes never processed (13/07, 16/07, 03/08, 05/08).
- **Watch:** three things. **(1)** The **pre-sales record is not in this
  mailbox** — earliest Pienissimo mail is 24 June; Aurel was onboarded 25 June,
  a month after kickoff. The prevendita evidence the dispute turns on sits with
  Elena Spini or Andrea Galotto. **(2)** `01 Documenti forniti dal cliente/`
  holds a **real customer order PDF with company name and VAT number** — keep it
  out of `notes/`, the recaps and `site/`. **(3)** New people from the April org
  chart: [G Lanzetti](notes/people/G%20Lanzetti%20-%20CEO%20of%20both%20Pienissimo%20companies.md)
  is CEO of **both** companies and appears nowhere in the project record;
  [Andrea Parmeggiani](notes/people/Andrea%20Parmeggiani%20-%20Pienissimo%20Software%20maintenance%20manager.md)
  belongs to **Pienissimo Software Srl**, the disputed entity, while being the
  Fase 1 Anticipay contact.

---

## 2026-08-14 — claude — requirements check, watermark 2026-08-07

- **Did:** swept Gmail, Slack, Drive and Fathom from the 2026-08-07 watermark.
  Six material findings, all folded into notes and both tracker languages.
- **State:** **Mexal field mapping answered** by Mirko Merendi on 11/08 —
  agent filter `610`, computed availability, causale FE, a **two-step N+1
  invoice retrieval** that is also the only source of the `numero riga d'ordine`
  [OI-75](notes/items/OI-75%20Ticket%20availability%20rule.md) needs, `501.AUTO`
  client creation, order serie 1 prod / 10 test. **Anticipay = ex CreditSafe**,
  one company — [OI-73](notes/items/OI-73%20VAT%20validation%20moves%20into%20Salesforce.md)
  is no longer uncertain. **Coupons excluded from phase 1**, closing one of
  [OI-49](notes/items/OI-49%20WooCommerce%20checkout-link%20flow.md)'s two open
  decisions. Four meetings dated: **19, 20, 25, 27 August**.
- **Next:** the 20/08 asset meeting is scope discovery, not review — Elisa says
  there are things never discussed. Read the two attachments before the 27/08
  build call: `Integrazioni pienissimo.xlsx` and the Mexal mapping workbook.
  Chase Fabrizio on **listino 1 vs listino 2**.
- **Watch:** three things. **(1)** A **sixth asset state, `rinuncia al
  servizio`**, exists in Elena's client-facing doc and in no version of
  [OI-74](notes/items/OI-74%20Asset%20state%20machine.md) — do not configure the
  picklist without it. **(2)** `PIENISSIMO - Project Status.docx` numbers its
  open points **1–15 under its own scheme**; never conflate with the tracker's
  `#NN`. **(3)** [OI-88](notes/items/OI-88%20Zoho%20import%20template%20owed%20to%20Pienissimo.md)
  is new and is the **only migration item ROMI owns** — it had no row anywhere.
- **Note:** the trace note now carries `external_watermark:`, and the earlier
  same-day repository trace is marked `superseded` and links forward, so the
  next run cannot mistake a repo read for a sweep.
- **Correction, same session.** The first pass ran only **one** Gmail query and
  read eight of nine threads from snippets, then reported the client inputs as
  outstanding. Re-running the prescribed search angles showed no new threads —
  but a subject search surfaced that **Fabrizio Paganelli wrote to a thread
  titled "Lista Eventi, Codici prodotto, esempio Bundle" on 07/08 12:17** and
  Elena thanked him 21 minutes later. His message is **not retrievable from the
  mailbox** — an empty quoted stub only, consistent with an attachment. So
  [OI-46](notes/items/OI-46%20Bundle%20classification%20picklists.md) and
  [OI-48](notes/items/OI-48%20Bundle-only%20article%20codes.md) are now marked
  **unverified in both directions**; open that thread in a mail client before
  chasing the client again. Read full bodies next run, not snippets.

---

## 2026-08-14 — claude — knowledge structure installed

- **Did:** replicated the Life365 knowledge architecture onto this repository.
  Added the routing layer ([MAP.md](MAP.md), [INDEX.md](INDEX.md),
  [AGENTS.md](AGENTS.md) with `CLAUDE.md` / `GEMINI.md` /
  `.github/copilot-instructions.md` as pointers, this journal), the
  [notes/](notes/) vault with its
  [protocol](notes/Retrieval%20and%20write%20protocol.md),
  `npm run vault:check`, committed Obsidian config, the four project skills in
  both `.agents/skills/` and `.claude/skills/`, and
  [docs/publishing.md](docs/publishing.md) + [site/](site/).
- **State:** the first wave of notes is written — every live open item, the
  people, the risks, what is actually built, and the three core flows.
  **Resolved tracker rows were deliberately not split**; they stay in
  `meetings/open-items.md` under `## Resolved`, which remains the archive.
- **Two findings came out of the migration, neither of them in any tracker.**
  **(1)** The repository is roughly a week ahead of the 2026-08-03 org check:
  `OrderBigliettoTrigger`, `Solo_Bundle__c`, both WooCommerce fields,
  `OrderItem.Data_Scadenza__c`, `Opportunity.Tipo_Opportunita__c` and an
  standard integration scaffolding were all committed 04–07 August by the
  Calm-Coders developers working for ROMI — Anita Aga, Sara Aga and Rexhina —
  and the trackers were never updated to match. (The scaffolding itself is
  house pattern and correctly has no requirement; everything else on that list
  does.) **(2)** The Biglietto DocuSign/PDF
  Apex stack that the org check found Active in UAT is **not in `force-app/`
  at all** — six classes live only in the org.
- **Next:** re-run the org check against UAT to date the divergence properly
  (the 2026-08-03 snapshot is now stale in both directions), and decide whether
  `Tranche__c` or the participant flow goes first when the team returns ~24–26
  August.
- **Watch:** item ids in `notes/items/` are the tracker's own numbers
  (`#64` → `OI-64`) because those numbers are cited in `REQUIREMENTS.md` and in
  the published artifacts. Never renumber them. Note filenames are ASCII with
  spaces — Italian domain words are fine, accents are transliterated.
