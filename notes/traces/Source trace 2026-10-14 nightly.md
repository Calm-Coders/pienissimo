---
id: trace-2026-10-14-nightly
type: reference
status: active
updated: 2026-10-14
watermark_used: 2026-10-13T22:00Z
external_watermark: 2026-10-14T22:00Z
account: a.mrruku@romicompany.com
---

# Source trace 2026-10-14 nightly

**Watermark for the next `requirements-check` run: 2026-10-14T22:00Z, single
value.**

**Watermark used: 2026-10-13T22:00Z**, the `external_watermark` stated by
[the 13/10 nightly trace](Source%20trace%202026-10-13%20nightly.md), selected by
`updated:` frontmatter. Scheduled nightly run, executed 2026-10-14 ~21:50Z. **One
day.**

🔑 **The administration drove the entire commercial chain for the first time —
one order into four Mexal invoices and back as a scadenzario — while ROMI's own
project manager asked, in a DM nobody answered, whether a requirement rewritten
into the signable text nine days ago was ever built.**

🟢 **Environment note.** The clone opened on `main` (two commits, config only)
with none of the knowledge layer in the working tree; `DevMain` did not exist
locally and was created with `git fetch origin && git checkout DevMain`.
**Fourteen runs, same opening pattern.** ⚠ `AGENTS.md` still describes `MAP.md`
as _"under 5 KB"_; it is now **~242 KB**. The read protocol's first instruction
has been wrong for some time.

## Sources searched

| Source | Query / scope | Result |
| ------ | ------------- | ------ |
| **Gmail** | `pienissimo after:2026/10/13 -in:draft`, 50 requested, 10 estimated | 🔑 **the 14/10 `UAT: Test e2e` Gemini notes**, 09:10:37Z, **unread** · 🔑 **Elena Spini's long Business Blueprint reply to Marco Montesi**, 17:14:01Z, **unread** · 🔑 `Cambi di Ragione Sociale` (client 10:08:12Z, reply 13:48:59Z) · 🔑 `Account per Responsabile Commerciale` (client 15:24:54Z, reply 16:47:09Z) · the **`Migrazione e Go-Live` invitation** 14:22:04Z and its update 16:45:43Z · Elena Spini's **chase to Andrea Parmeggiani** 12:35:25Z. Everything else at or before the watermark and already held |
| **Gmail** | `after:2026/10/13 -in:draft (from:/to:/cc:pienissimo.com OR pienissimo.pro OR kreosoft OR gemini-notes@google.com OR info@salesforce.com OR subject:ROMI-PIENISSIMO)`, 12 estimated | Nothing further on this project. 🔴 **No Kreosoft mail; nothing from Mirko Merendi** — on the day three separate asks were pointed at him. Other hits are **other clients** — `[TFP] Data Model` (Teatro Franco Parenti, 5 messages incl. a field-visibility question), a TFP Apex CPU exception, `Daniele / Aurel per Daze` — ignored per the skill |
| **Gmail** | `after:2026/10/13 -in:draft (mexal OR biglietto OR bundle OR tranche OR anticipay OR woocommerce OR docusign OR preventivo OR "Ri.Ba" OR scadenzario OR blueprint OR jira OR listino OR e2e)`, 11 estimated | 🆕 **an Anticipay error mail**, 08:11:09Z, partial sandbox, HTTP 404 · a **Jira weekly digest** 00:51:18Z naming `PER-12`/`PER-20` — the **Permo** space, another project, **no `PIEN` item visible**. 🔴 **Nothing on `Ri.Ba.`, OI-212, the scadenzario defect or the Blueprint signature** |
| **Gmail** | `get_message` ×4 (PLAIN_TEXT, full bodies): the e2e Gemini notes, Elena Spini's 17:14Z reply, the `Cambi di Ragione Sociale` thread, the Anticipay error, the calendar update | all twelve next steps and three `Concordato` · 🔑 **the full as-is description to Marco Montesi** and the WhatsApp/extra-email scope ruling · the client's tranche/ragione-sociale case verbatim · account `001MA000012gCXsYAM`, log `a05MA00000GWyvtYAD`, _"TEST - Azienda non trovata"_ · the four meeting themes |
| **Slack** | `slack_read_channel C0BQD34LLF4` (dev group), `oldest` 2026-10-13T22:00Z | **1 message — this procedure's own 13/10 report.** 🔴 **No human reply: twenty-four nights** |
| **Slack** | `slack_read_channel C0B5T3RB4FM` (`#tproj-pienissimo`), same bound | **0 messages.** 🔴 Silent a fifth day |
| **Slack** | `slack_read_channel C0C38JJ9D1T` (marketing group DM), same bound, 2 pages | 🔑 **38 messages** — the `RINUNCIA` static-text exchange in full (15:13:54–15:35:25), Aurel Mrruku's four technical consequences, Elena Spini's _"non si cambia nulla"_, Fabrizio Mastracci's _"stravolgimento del nostro lavoro"_, and **a huddle at 15:35:52 whose content is unreadable** |
| **Slack** | `slack_read_channel D0B5QHS2T7H` (Elena Spini DM), same bound | 🔑 **26 messages.** The decisive ones: **18:52:58 _"PIENISSIMO - questa parte ce l'abbiamo?"_** with the `SAL-20` spec verbatim, **18:53:33** _"non ne abbiamo mai parlato…"_, **18:54:46** on Marco Montesi · **08:31:17/08:31:32** on the DocuSign closure, **unanswered** · 16:39 _"nuova web to leed"_ + an image · the rest LIFE365, WILEGAL and a date-format fix |
| **Slack** | `slack_search_public_and_private` `keywords:[pienissimo] after:2026-10-13`, sorted by timestamp | 6 results, all accounted for: the two DM findings above, the RINUNCIA ask, a calendar bot line, this procedure's own 13/10 report, and a ROMI capacity grid (another-client staffing) |
| **Slack** | `slack_read_canvas F0BD2H5A9HT` (`Link utili Pienissimo`) | **Unchanged.** Newest entry still 20.08.2026 — static for **eight weeks**. Re-read per the skill; still the source of the 30/07 marketing notes link |
| **Drive** | `modifiedTime > '2026-10-13T22:00:00Z'`, **2 pages, 31 files** | 🔑 **the 14/10 e2e Gemini notes doc and its shortcut** (09:08:38Z / 09:09:39Z) · ⚠ `DTT SHR Mappatura form handler campi.xlsx` from Elena Spini 09:36:18Z, shared 09:41Z — **a `DTT SHR` prefix matching no Pienissimo artefact; treated as another client and not opened** · the rest are **other clients** (WILEGAL, Vision/`d.losco@`, Daze, `[permo]`, 247.it) — ignored. ⚠ **`Campi Oggetti…xlsx`, `Flows & Objects.drawio` and `Manual Steps Pienissimo` did not move** (the sheet still reads 2026-10-13T09:29:13Z) |
| **Drive** | `read_file_content 180oumnzjVhWIqm7MrKAHzcrcA0P7jsHauHX2vGke-Qs` | 🔑 **the 14/10 session, 123,598 characters.** `Riepilogo` + `Decisioni` + twelve `Passaggi successivi` + `Dettagli` with timestamps, read in full to offset 23,013. **Drilled; the raw transcript below it (~100 KB) was not loaded.** No article-code or price values copied |
| **Fathom** | `list_meetings created_after 2026-10-13T22:00Z`, summaries, 3 pages | **0 meetings.** 🔴 **Seventeenth consecutive run with no Pienissimo meeting** — ⚠ and the first run where it returned nothing at all, so the tool's health is **not** demonstrated tonight as it was on 13/10 |
| **Git** | `fetch origin`, `log --all --since 2026-10-13T22:00:00Z` | **4 commits**, all human. `DevMain` advanced `21d6686` → **`29d1002`** (Aurel Mrruku, 10:07, _"changed get articoli"_, which also carries his own `JOURNAL.md` and object-note entries). 🔴 **Three are outside `DevMain` and no PR was merged**: `8186816` and `dbef4f4` (Rexhina Hysi, `DevMainOpportunityWork`), `168e143` (Anita Aga, `DevAnita14`) |
| **Repo** | `MexalScadenzarioSearchService.cls:185-215`; `Scadenza_Fattura__c/fields/Pagata__c`; `git log` on both; `git show --stat` on all four commits; `git show 29d1002 -- "notes/objects/The Mexal article sync to Product2.md"`; `JOURNAL.md` head | 🔴🔑 **both payment predicates byte-for-byte unchanged — OI-212 did not move, sixth night** · 🔑 `8186816` adds `Quote.Totale_Listino__c` + `Quote.Sconto_Totale__c` across 13 files **including OI-207's own note** · `dbef4f4` strips WooCommerce from the lead logic · the developer's **14/10 `JOURNAL.md` entry** on the article category |

## Found

1. 🟢🔑 **New: [the 14/10 UAT Test e2e](../meetings/2026-10-14%20UAT%20Test%20e2e.md)
   — the money leg ran end to end.** ~2h, full record, **Elisa Migliano at the
   keyboard**. One €20,000 order → four deferred Mexal invoices → invoice 10
   (€5,000, customer 50171, bonifico) → **scadenzario back into Salesforce** →
   collection registered → roll-up reconciling 20,000/5,000/0/15,000. Then the
   same chain for a renewal.
2. 🔴🔑 **[OI-227](../items/OI-227%20SAL-20%20was%20rewritten%20in%20the%20signable%20requirements%20with%20no%20client%20ruling.md)
   is answered, and the answer is no.** At 17:14Z Elena Spini described the
   **as-is** to Marco Montesi as the **TASK** model — the wording `96d77de`
   deleted. At 18:52Z she asked Aurel Mrruku whether it exists at all. 🔑 **The PM
   does not know the build state of a requirement rewritten into the signable text
   nine days ago, and is telling the client the pre-rewrite version.** ⚠ **Neither
   version has a client ruling** — worse than first recorded.
3. 🟢 **[OI-222](../items/OI-222%20The%20commercial%20mail%20and%20WhatsApp%20notification%20flows%20are%20unspecified.md)
   answered after nine days, in the negative.** Only invio/accettazione/firma
   preventivo mails are in scope; other mails and **WhatsApp in the Sales flow**
   are _"extra-perimetro"_. 🔴 ROMI's ruling, not the client's; his governance
   question is unanswered a tenth day; the surviving reminder mail **waits on copy
   from Marco Montesi**.
4. 🟢🔑 **Three `Concordato`**: the quote must show **totale listino / sconto /
   netto** (PDF *and* portal, all quote types) · a **renewal quote cannot be
   edited** · **renewals carry no system contract**, only the quote PDF. 🟢 The
   first was **built the same evening** (`8186816`); ⚠ **not in `DevMain`**.
5. 🔴 **New: [OI-238](../items/OI-238%20The%20tacit%20renewal%20path%20skips%20client%20acceptance%20and%20its%20approval%20workflow%20is%20undecided.md)
   — gating.** A tacit renewal needs no DocuSign and no customer approval; the
   tutor confirms internally and it becomes a billable order. **Driven live.** The
   approval workflow was deferred to **Marco Montesi**, who now owes three
   answers.
6. 🔴 **New: [OI-239](../items/OI-239%20The%20Mexal%20scadenzario%20sync%20must%20run%20every%20half%20hour%20and%20nothing%20schedules%20it.md)
   — gating.** Agreed to run every half hour to an hour; API limits read in Prod
   (3,360,000/month, 112,000/day, two calls a cycle). Owner `[Il gruppo]`, nothing
   schedules it, and **the procedure in force is pasting Apex into a console**.
7. 🔴 **New: [OI-241](../items/OI-241%20Books%20and%20video%20courses%20wait%20on%20a%20WooCommerce%20instance%20move.md)
   — and it reconciles a three-way contradiction.** Books and videocorsi excluded
   _"temporaneamente poiché Sabatino non ha ancora trasferito tali ordini
   nell'istanza corretta di WooCommerce"_. 🔑 The 09/10, 12/10 and 13/10
   statements were never in conflict.
8. 🔴 **New: [OI-234](../items/OI-234%20Tranche%20invoicing%20when%20the%20customer%20changes%20legal%20entity%20mid-order.md)**
   (tranche billing across a change of legal entity — Fase 2 proposed, **client
   has not accepted**) · **[OI-235](../items/OI-235%20A%20contract%20is%20linked%20to%20the%20account%20but%20hidden%20in%20the%20tab.md)**
   (contract linked and invisible; ⚠ cause is a hypothesis) ·
   **[OI-236](../items/OI-236%20The%20Mexal%20order%20carries%20no%20tipo%20merce%20and%20no%20provvigioni%20percentage.md)**
   · **[OI-237](../items/OI-237%20Mexal%20invoices%20cite%20the%20preventivo%20instead%20of%20the%20order%20number.md)**
   · **[OI-240](../items/OI-240%20Marco%20Montesi%20needs%20a%20Salesforce%20user%20before%20go-live.md)**
   · **[OI-242](../items/OI-242%20The%20community%20Rinuncia%20button%20must%20show%20the%20public%20refusal%20text.md)**.
9. 🔑 **[OI-210](../items/OI-210%20The%20delivered%20article%20registry%20carries%20no%20tranche%20count.md)
   moved after seven silent nights** — the session used the **tranche-count-field**
   model, so the 05/10 `Concordato` is operative. 🔴 But the count was **typed in
   by hand, per product, live**; `NR_Tranche` is still blank on 1,010 rows.
10. 🔑 **The `C10` category mismatch surfaced in the room and its real cause was
    bigger**: the article sync had **never written `Categoria_Articolo__c`**. Aurel
    Mrruku found it, mapped `sigla_cat_sta`+`nr_cat_sta`, re-synced twice, and
    recorded it himself. 🟢 **Two of OI-96's fifteen empty categories recovered**
    (`C10`, `C11`); 🔴 **thirteen did not**, and the rule was not revisited.
11. 🔑 **[OI-215](../items/OI-215%20Anticipay%20does%20not%20cover%20San%20Marino%20addresses.md):
    the San Marino gap was shown to the client**, and the trigger is of record —
    **once per account, at the first order**. ⚠ A 404 fired in UAT at 08:11Z and
    went only to the hardcoded ROMI address.
12. 🔴 **[OI-212](../items/OI-212%20A%20Ri.Ba.%20rate%20reads%20as%20paid%20before%20its%20due%20date.md)
    did not move, sixth night.** ⚠ **Two consecutive sessions have now set it up
    and not triggered it**: 13/10 built the Ri.Ba.-term tranches with no return
    leg, 14/10 ran the return leg on a **bonifico**.
13. 🔴 **[OI-231](../items/OI-231%20DocuSign%20closed%20the%20Pienissimo%20onboarding%20for%20non-response.md):
    Elena Spini asked internally and nobody answered her**; the client is
    unanswered a second day. 🔴 **[OI-161](../items/OI-161%20The%20event%20check-in%20app%20must%20integrate%20with%20Salesforce.md):
    ROMI chased Andrea Parmeggiani after six days** and the Prod move waits on him.
14. 🆕 **A `Migrazione e Go-Live` meeting is booked for Thu 15/10 14:30–15:30.** ⚠
    The room had said **Friday**; whether the Friday session also stands is not
    established.

## The register

**Not amended, and nothing this sweep found calls for amending it.**
Version stays **1.6**, `SAL-20` stays as `96d77de` left it.

🔑 **OI-227 is now answered, and that is precisely why the YAML was not
touched.** The answer is that **neither** wording has a client ruling: the PM
describes the old one to the client while not knowing whether it was built, and
nothing says the task model was agreed either. Reverting contract-bound text on
the strength of two internal messages is not this procedure's call, and
[OI-184](../items/OI-184%20Register%20v1.6%20goes%20to%20the%20client%20as%20one%20change%20set%20at%20UAT%20close.md)
exists so v1.6 reaches the client as one reviewable change set. **A human now has
what they need to decide.** ⚠ Third night the YAML was deliberately left alone.

⚠ **Today's three `Concordato` are client rulings taken in the room** — the
quote's three totals, the immutability of renewal quotes, and no system contract
for renewals — which is the authority OI-227 says the `SAL-20` rewrite lacked.
**They are not in the register and were not added**: no existing requirement id
covers them and allocating one is a register change. **They join the v1.6
candidate list** with the renewal-without-DocuSign path (which this session
confirmed end to end), the two-flag Lead consent model, the 21-value
`Tipologia di attività`, `Partita IVA` mandatory at lead conversion, the
per-edizione link scope, `Rinuncia` per edition, `E` counting as paid only after
the due date, the commercial notification flows, and the active-products-only
mapping rule.

🔴 **And one v1.6 candidate has now been scoped *out* by mail rather than ruled
on**: OI-222's notification flows. Whatever reaches the client as v1.6 must say
that extra mails and WhatsApp in the Sales flow are extra-perimetro — **a
statement the client has not accepted.**

## Corrections to the record

- ⚠ **One correction to the Slack sweep's own working.** The dev-group read was
  first issued with `oldest` **1760393000**, which is 2025, and returned the whole
  channel (106,825 characters, truncated by the tool). The bound was recomputed
  from a Gmail `internalDate` in the window and the read reissued at
  **1791928800**. **No finding rests on the oversized read**, which was not
  parsed.
- ⚠ **The Gemini record writes the ERP as _"Maxal"_** throughout, as the 13/10
  record wrote _"Bexal"_. Read as Mexal, and said so.
- ⚠ **One figure in the source is not reliable and was not used.** The deferred
  invoicing block gives due dates _"dall'1/02/2026 al 31/03/2026"_ — **before the
  session date and inconsistent with four tranches**. Read as a transcription
  artefact; **no claim is made about the tranche dates**, and the four-invoice
  split is supported independently by the roll-up figures.
- ⚠ **The `C10` finding was deliberately not written as "the predicted failure
  occurred".** The record says _"disallineamento nei codici"_, not that a category
  save failed, and nobody in the room named the active-only rule. The note, OI-96
  and the Mappatura note all say *same category, not established as the same
  fault*.
- ⚠ **No correction to the developer's 14/10 records.** His `JOURNAL.md` entry and
  the article-sync note are his own, detailed, and include his own cautions (the
  near-limit CPU, the unverified delta behaviour). **Nothing in them was
  rewritten**; pointers were added from OI-96, OI-210 and the Mappatura note.
- ⚠ **OI-207's note is edited on two branches at once.** `8186816` contains
  Rexhina Hysi's own fuller account of the same build; this sweep appended a
  dated section to the `DevMain` copy because the client ruling had to be recorded
  on the night it was given. **The section says explicitly not to duplicate or
  overwrite hers when the branch merges.** ⚠ A merge conflict on that file is
  expected and is the cheapest available outcome.

## Not done in this run

- The org was **not** opened. `STATUS.md` was not regenerated and the Notion
  mirror stays stale. Every build claim is repository arithmetic against `DevMain`
  `29d1002`.
- **No Apex test was written, proposed or scaffolded**, per the standing
  instruction. ⚠ Noted only as a fact of the record: `8186816` adds ~90 lines of
  trigger-handler logic and two roll-up fields with no test, inside the gap
  [OI-64](../items/OI-64%20The%20bundle%20Apex%20test%20suite%20is%20broken.md) and
  [OI-66](../items/OI-66%20No%20test%20classes%20for%20the%20Biglietto%20stack.md)
  describe. **This sweep did not touch either row.**
- **The YAML register was not edited** — see above.
- **OI-212 was not fixed**, a sixth night. The correction is a code change and
  belongs to Aurel Mrruku.
- **Neither failing flow was opened** (OI-225, OI-230). They are org-only and
  read-only here; `Get Campaign` is still unchased.
- **The 13-of-23 category failure still has no tracker row.** It remains recorded
  in the Mappatura note by its author and cross-referenced from OI-96; it is in
  tonight's "needs a human" list instead.
- **The raw transcript below the `Dettagli` block was not loaded** — ~100 KB of
  verbatim transcript remains unread and is available if a quote is needed.
- **The images were not opened**: Aurel Mrruku's web-to-lead screenshot (Elena DM,
  16:39:12) and Elena Spini's two in the marketing DM.
- **`DTT SHR Mappatura form handler campi.xlsx` was not opened.** The `DTT SHR`
  prefix matches no Pienissimo artefact in these records, so it was treated as
  another client per the skill. ⚠ **If `DTT` is a Pienissimo form handler, this is
  a miss** — it was shared with Aurel Mrruku at 09:41Z and is a field mapping for
  a form handler, which is OI-14's subject matter. **Flagged rather than assumed.**
- **OI-223's blast radius was not assessed** — a seventh run.
- **OI-207 was not verified in the org** — an eighth run.
- ⚠ `JOURNAL.md` is at **120 entries** against a documented limit of 20. Archiving
  to `notes/sessions/` is overdue and **was left alone again**.
- `npm run prettier:verify` was not run (no `node_modules`), so tonight's markdown
  is unformatted.

## Still unreachable

- 🔴 **`Mappatura_Categorie_Sottocategorie_Origine Lead_Tipologiattività.xlsx`**
  — the four Lead picklists, still a **mail attachment only, seventh run**. It
  blocks a commissioned deliverable, and a **second** web-to-lead file now waits
  on it. **Ask Elisa Migliano or Elena Spini to put it in Drive.**
- 🔴 **The 30/07 marketing notes** — Drive id
  **`1uJCE4NW9nbdI38ADmt66svUT1MRmkyYd24uI0hegAD0`**, from the canvas, 404 for
  `a.mrruku@romicompany.com`. **Ask Elena Spini to share it.** Third run with a
  precise id.
- 🆕 **What was agreed in the 15:35:52 marketing huddle** about the `RINUNCIA`
  text. **Voice is not a source this procedure can read** — third Pienissimo
  decision to go into a huddle. **Ask Aurel Mrruku or Elena Spini.**
- 🆕 **Whether `DTT SHR Mappatura form handler campi.xlsx` is a Pienissimo
  artefact.** One question to Elena Spini settles it.
- 🆕 **Which bug Elisa Migliano was asked to report.** The e2e next step names
  none, and she is the owner.
- **The identity of the DocuSign production configuration** — templates, sending
  identity, envelope allowance. **Ask Elena Spini or Sabatino Rinaldi**, urgent
  since the onboarding closed.
- **`Flows & Objects.drawio`** — did not move; still an unparseable `mxfile`. ⚠
  **It is now cited as the authority twice** — Elena Spini's 17:14Z mail calls it
  the record of the as-is, and her 18:53Z DM says the task flow _"è presente sul
  grafico di Drawio"_. **A requirement is being sourced from a file no agent here
  can read. Ask Elena Spini for a PNG or PDF export.**
- 🆕 **Which WooCommerce instance is the correct one for books and videocorsi, and
  when the orders move.** **Ask Sabatino Rinaldi** (OI-241).
- **What `Get Campaign` is looking for** in both failing flows. Needs the org.
- **What is in Jira project `PIEN`** — no connector; the 14/10 weekly digest names
  only `PER-*` items. **Ask Elena Spini what it is for.**
- **Which profile a "tutor" holds**, and now **which profile a _responsabile
  commerciale_ holds** — OI-233 and OI-240 cannot be built without them.
- **The contents of `Regole Codifica Codici Articolo.xlsx` beyond its structure** —
  read, code values deliberately not recorded. **Ask Fabrizio Paganelli whether
  this is the scheme going to direction.**
- **`Campagne Salesforce.xlsx`** — did not move. Still not opened.
- **`Testbook_UAT_Lead_Opportunita_2026-09-24_v2_1.xlsx`** — **did not move**, an
  eleventh consecutive run. Approval was due ~13/10.
- **The full text of `Pienissimo_Scheda di Partecipazione ai corsi_da firmare.pdf`**
  — not opened; its seven enrolment pages may carry personal data. ⚠ OI-194 is
  still gating and went undiscussed for a fifteenth day.
- ⚠ **The document Rebecca Marmo shared** with Fabrizio Mastracci. Eighth run.
- **The WooCommerce logic document** for Daniela Morgese — ninth run.
- **The 12:30 CEST internal call of 25/09** — still no artifact, fifteenth run.
- ⚠ **The Pienissimo lead documentation** Elena Spini said she owed on 28/09.
- ⚠ **Sabatino Rinaldi's card and PayPal test orders** — WhatsApp is not a source
  this procedure can read.
- ⚠ **The `ai-visibility-fmf` form check** Elena Spini posted on 08/10 — fifth
  run, screenshot never opened, **still no owner**.
- **The WhatsApp number Matteo Distaso owes Fabrizio Mastracci** — fourth run.
- **Fabrizio Mastracci's `testlist degli invii`** — third run, in no source. He
  said _"domani facciamo un giro"_ on 12/10; **two days have passed and nothing
  records it.**

## Absence of evidence, stated as absence

- **Fathom returned zero meetings** — seventeenth consecutive run with no
  Pienissimo meeting. ⚠ **And nothing at all tonight**, so unlike 13/10 the tool's
  health is not demonstrated by this run.
- **`#tproj-pienissimo` was silent a fifth day.** 🔴 **The dev group too:
  twenty-four consecutive nightly reports with no human reply.**
- **Nothing was found on [OI-212](../items/OI-212%20A%20Ri.Ba.%20rate%20reads%20as%20paid%20before%20its%20due%20date.md)**
  in any source — not a mail, a message, a meeting, a commit or a ruling. **Sixth
  night**, and the 13/10 confirmation date is two days past.
- 🔴 **Nothing from Mirko Merendi, and no Kreosoft mail at all** — on the day a
  third ask was pointed at him. **Fabrizio Paganelli's 13/10 undertaking to
  contact him is unrecorded.**
- **Nothing on the Business Blueprint signature** — the 09/10 _"confermato e
  firmato"_ claim is unsupported a **fourth** run. ⚠ The thread is active and the
  signature is not mentioned in it.
- **Nothing on OI-194**, OI-202, OI-204's documentation half, OI-205, OI-206's
  missing reports, OI-216, OI-218, OI-226 or OI-232.
- **Nothing on OI-224.** Sabatino Rinaldi has not answered the mass-Opportunity
  escalation, and ⚠ **he appears in no source this run except as a cc and as the
  owner of OI-241.**
- **Nothing on OI-233** — no profile named for a tutor, five days on, while
  `recall tutor/pack tutor` remained untested in the session that was meant to
  cover it.
- **Nothing on OI-96's `E10` collision** — and E10 is **not** among the two
  categories recovered today.
- **No reply to Elena Spini's 12:47:00Z request** for written confirmation of the
  amended logic document, now **fourteen days** old.
- **Which agent code an agentless WooCommerce order uses is still unanswered** —
  and all three paths that would exercise it were excluded or deferred.
- **The QR credential rotation has still not happened** — eighth day.
- **Rebecca Marmo's two funnel questions remain unanswered.** ⚠ Elena Spini wrote
  _"e tra poco rispondo anche a sta Rebecca"_ at 14:51:06 CEST; **no reply to her
  is in any source this sweep can read.**
- ⚠ **"Claudio" is still unresolved**, credited by Elena Spini on 06/10. **No
  person note was created and nothing was attributed.**
- ⚠ **"Giuliano Lanzetti"** and **"Tech Romi" (`005SW00000PV5Ja`)** still match
  nobody in the records. ⚠ **"Davide Stefani" is new tonight**, named in the e2e as
  the example of an inherited agent, and is likewise in no person note — nothing
  establishes whether he is an agent, a customer contact or a test record.
- **Elena Spini's post-launch support estimate** is not in any source.
