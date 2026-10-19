---
id: trace-2026-10-19-nightly
type: reference
status: active
updated: 2026-10-19
watermark_used: 2026-10-16T22:00Z
external_watermark: 2026-10-19T22:00Z
account: a.mrruku@romicompany.com
---

# Source trace 2026-10-19 nightly

**Watermark for the next `requirements-check` run: 2026-10-19T22:00Z, single
value.**

**Watermark used: 2026-10-16T22:00Z**, the `external_watermark` stated by
[the 16/10 nightly trace](Source%20trace%202026-10-16%20nightly.md), selected by
`updated:` frontmatter. Scheduled nightly run, executed 2026-10-19 ~21:45Z.
**Three days, covering the weekend** — 17 and 18 October were a Saturday and a
Sunday and produced nothing in any source.

🟡 **The commercial lead finally got into Salesforce, found ten defects in 01:45
with no developer in the room, and the client sent ROMI away for the rest of the
key-user test week.**

🟢 **Environment note.** The clone opened on `main` (two commits, config only)
with none of the knowledge layer in the working tree; `DevMain` did not exist
locally and was created with `git checkout DevMain` against the fetched remote
branch. **Seventeen runs, same opening pattern.**

🟢 **Stale read-cost figures were corrected tonight, and the drift was large.**
`INDEX.md` advertised `meetings/open-items.md` at **~50k** when it is **~416k**,
and the recaps at **~18k/20k** when they are **~134k/144k** — an agent budgeting
from the router would have loaded an eight-times-larger file than promised. Both
tables in `INDEX.md` and `AGENTS.md` now carry measured figures, and
`AGENTS.md`'s read protocol no longer calls `MAP.md` _"under 5 KB"_ (it is
~285 KB); **six consecutive traces had flagged that one line.**

⚠ **Pre-existing structural defect, newly identified: `MAP.md` carries two
`## Where the project stands` headings** (lines 7 and ~1312 before tonight's
insert). Tonight's entry went into the **first**, which is the live block. Not
repaired — which of the two blocks is intended is a human's call, and merging
them would rewrite project history.

## Sources searched

| Source | Query / scope | Result |
| ------ | ------------- | ------ |
| **Gmail** | `pienissimo after:2026/10/16 -in:draft`, 50 requested, 7 estimated | 🔑 **Two new items.** The **`Opportunity` thread** (3 messages, 19/10) — Fabrizio Paganelli 14:55:54Z _"i campi Categoria e Sottocategoria non sono aggiornati"_, Elena Spini's 15:10:55Z reply with the picklist values as a screenshot and the written promise of the migration Excel, Fabrizio Paganelli 16:10:07Z confirming the Wednesday slot · the **Gemini notes for the 19/10 Test UAT Commerciali** (15:06:57Z). Everything else in the window is already held |
| **Gmail** | `after:2026/10/16 -in:draft (to:/from:/cc: pienissimo.com OR pienissimo.pro OR kreosoft OR from:gemini-notes@google.com OR subject:ROMI-PIENISSIMO)`, 9 estimated | **Nothing further on this project.** Three further Gemini notes mails are other clients — `[ROMI/IUAD] Meet con Team Marketing`, `[Daze - Romi] SAL`, `Daze: allineamento interno pre SAL` — ignored per the skill. 🔴 **No Kreosoft mail; nothing from Mirko Merendi** — a **seventh** consecutive run |
| **Gmail** | `get_thread 1a154a97e004a741` (PLAIN_TEXT, all three bodies in full) | 🔑 Read in full. Elena Spini's reply carries **two commitments and one unanswered question**: the Excel tracciato for 20/10, the Wednesday slot, and _"ci sono i valori che ci avete condiviso ultimamente, non vi torna?"_ — **which Fabrizio Paganelli did not answer**. ⚠ Her picklist values and the Kanban instructions for Elisa Migliano are **embedded as images** (`image001.png` ×3), deliberately not opened — client screenshots, possible customer data |
| **Slack** | `slack_read_channel C0BQD34LLF4` (dev group), `oldest` 1792188000 = 2026-10-16T22:00Z | 🟡 **2 messages, 1 human.** Aurel Mrruku, 19/10 18:05:55 CEST: _"neser mos te harrojm duhet mi dergu ne nje eksel te gjitha fushat qe do na duhen me migru order e order item"_ — tomorrow, let us not forget, we have to send in an Excel all the fields we will need to migrate order and order item. **First time OI-244's deliverable has been put to the group.** The other message is this procedure's own 16/10 report. ⚠ **Still no reply to any nightly report — twenty-nine nights** |
| **Slack** | `slack_read_channel C0B5T3RB4FM` (`#tproj-pienissimo`), same bound | **0 messages.** Silent again after breaking six days on 16/10 |
| **Slack** | `slack_read_channel C0C38JJ9D1T` (marketing group DM), same bound | **2 messages, neither a decision.** Elena Spini posts an image at 15:25:23 CEST (**during** the session); Fabrizio Mastracci at 16:10:45: _"dietro questa cosa c'è una nuova change request che non stiamo capendo? 😅"_ ⚠ **What _"questa cosa"_ is cannot be established** — it refers to an unopened image. Recorded as an open question, not as a finding |
| **Slack** | `slack_read_channel D0B5QHS2T7H` (Elena Spini DM), same bound | 🔑 **7 messages, and they settle OI-244.** 16:12:56 _"qui Fabrizio dice che vorrebbe la parte degli sconti"_ + image · 16:20:11 _"comunque è appena andato in errore qualcosa"_ + image (the `Genera PDF` failure) · 16:55:45 quoting the Excel undertaking back verbatim · 16:56:11 _"ha chiesto news anche di questo Fabrizio"_ · **Aurel Mrruku 17:01:08 _"ciao , si me lo sono dimenticato"_** · Elena Spini 17:02:59 _"gli dico che glielo mandi domani 😉"_ ✅. 🔴 **`SAL-20` is in none of them** |
| **Slack** | `slack_search_public_and_private` `keywords:[pienissimo] after:2026-10-16`, sorted by timestamp | 3 results, all accounted for: the Elena Spini DM thread above, a calendar-bot line, and this procedure's own 16/10 report. Nothing new |
| **Slack** | `slack_read_canvas F0BD2H5A9HT` (`Link utili Pienissimo`) | **Unchanged.** Newest entry still 20.08.2026 — static **ten weeks**. Re-read per the skill; still the only source of the 30/07 marketing notes link |
| **Drive** | `modifiedTime > '2026-10-16T22:00:00Z'`, **2 pages, 25 files** | 🔑 **`[ROMI-PIENISSIMO] - Test UAT Commerciali - 2026/10/19 15:01 CEST - Appunti di Gemini`** (Doc `1w71EaST25pV2oxq64QQ7THZDD9KoXSJ1hur2oh_rB0g`, 61,233 bytes, created 15:04:45Z, shared 15:05:57Z) with its folder and shortcut. ⚠ **No MP4 recording appeared for this session**, unlike 16/10 — so the transcript is the only record. The rest are other projects or clients (WILEGAL, Daze, 247.it, permo, Vision, Aircall, a ROMI holiday sheet) — ignored. ⚠ **`Manual Steps Pienissimo` did not move** (still 16/10 09:29:19Z), nor did `Campi Oggetti…xlsx`, `Flows & Objects.drawio`, `Locali Salesforce.xlsx`, `Campagne Salesforce.xlsx` or `Testbook…v2_1.xlsx` |
| **Drive** | `read_file_content 1w71EaST25pV2oxq64QQ7THZDD9KoXSJ1hur2oh_rB0g` | 🔑 **The 19/10 session, 107,044 characters, 01:45:49** — Gemini notes header **plus the full verbatim transcript**, read in full in one pass per `drill-meeting` step 2 (seven sequential slices). Completeness checked: it ends on _"Trascrizione terminata dopo 01:45:49"_, not mid-sentence. **Preserved verbatim** at `meetings/2026-10-19-test-uat-commerciali-transcript.it.md` (108,177 bytes) |
| **Fathom** | `list_meetings created_after 2026-10-16T22:00Z`, summaries, 3 pages | **0 meetings.** A widened probe (`created_after 2026-10-14`) returns only the 15/10 `SALESFORCE check tasks to fix` (247.it), **so the tool responds and the window is genuinely empty of every meeting**, not only Pienissimo's. 🔴 **Twentieth consecutive run with no Pienissimo meeting**, on a day a 01:45:49 Pienissimo session took place and was captured by Google, not Fathom |
| **Git** | `fetch origin`, `log --all --since 2026-10-16T22:00:00Z` | 🟢 **6 commits and `DevMain` moved for the first time since 15/10**, `73a9d59` → **`926195c`**. Four PRs merged 12:34–12:52 CEST: `#101` (`DevAnita14`), `#102` (`DevMainOpportunityWork`), `#103` (`DevAnita15`), `#104` (`Devmain_LeadFix`). Two new unmerged commits on `DevAnita19` at **17:43–17:45 CEST** — `10fa31e` _"Logic to populate the agent related fields on account"_ and `fc8a86d` _"new costum component for New Account"_ — **57 minutes after the session ended** |
| **Repo** | `git diff --stat` on each merge; `git ls-tree -r origin/DevMain` for the quote fields | 🟢 **OI-207's build is in the integration branch**: `Totale_Listino__c` and `Sconto_Totale__c` present on `origin/DevMain`, with `QuoteLineItemTriggerHandler.cls` (+79), `QuoteLineItemTrigger.trigger`, `QuotePdfController.cls`, `QuotePdf.page` and the Quote layout (+8). 🟡 **OI-214's slot** likewise (`#103`). `QuoteLineItem` carries `Discount_Pct__c`, `Data_Scadenza__c` and `Tranche__c` — **no unit-of-measure or net-price field** |
| **Repo** | `git show origin/DevMain:<duplicateRule>` ×3; tails of OI-100 and OI-163 as merged | 🟢🔑 **The 16/10 contradiction is withdrawn.** All three Lead/Contact rules are `actionOnInsert: Allow`, `operationsOnInsert: Report`, `isActive: true` — report-only. And **both notes carry a `2026-10-19` section that explicitly supersedes the 16/10 alert-state paragraphs** ("this supersedes the 16 October alert-state description above"). `64a51b2` removes **154 lines** from `LeadConversionTriggerHandler.cls`; sandbox deploy `0AfMA00000Cx0pt0AB` |
| **Repo** | `git log -1 origin/DevMain -- MexalScadenzarioSearchService.cls`; register grep for `SAL-`, `DM-`, `lead_motivazione_uscita` | 🔴 **OI-212 byte-for-byte unchanged, ninth night** — last touched by `f292b72` on 08/10 for an unrelated reason, and in none of tonight's four merges. 🔑 **Register greps found the two conflicts below** |

## Found

1. 🟢🔑 **[OI-240](../items/OI-240%20Marco%20Montesi%20needs%20a%20Salesforce%20user%20before%20go-live.md)
   is answered.** The user existed before the call, Marco Montesi logged in by
   `00:23:10` after **two password resets that never arrived**, and he was walked
   through the full commercial path in 01:45. 🔴 **On System Administrator, in an
   org wired to Mexal production** — the interim profile is still undecided and
   now blocks from four directions.
2. 🔴🔑 **New: [the admin-rights risk](../risks/Risk%20-%20client%20key%20users%20test%20with%20admin%20rights%20against%20Mexal%20production.md).**
   Two client users on administrator profiles, Mexal **production** behind the
   Account fields, **one verbal warning given once** — to someone who was
   simultaneously on another call — and **ROMI absent 20–23/10 by the client's
   own choice.**
3. 🔑 **Aurel Mrruku was invited to the session and did not attend.** All ten
   findings reached the build through Elena Spini's screenshots, and the one
   diagnostic that mattered was unreadable to her: _"purtroppo arrivano tutte le
   mail ad Aurel."_ **This is the structural finding of the night**, not an
   attendance detail.
4. 🔴 **New: [OI-260](../items/OI-260%20Generating%20the%20quote%20PDF%20failed%20with%20an%20internal%20server%20error.md)**
   — `Genera PDF` returned _"si è verificato un errore di server interno"_ live.
   🟢 It worked hours earlier. 🔑 `#102` redeployed `QuotePdfController` at 12:35
   and the session opened at 15:01. **The exception has still not been read.**
   Second client-facing failure in four days.
5. 🔴 **New: [OI-261](../items/OI-261%20Test%20article%20codes%20pollute%20the%20product%20registry.md)**
   — the test articles survived the Mexal import, and bundle-only codes are
   selectable on a normal order. 🟢 **Fabrizio Paganelli reading the article
   flags off the screen corroborates OI-251's design exactly** —
   `genera biglietto / altri ordini`, `genera biglietto solo bundle`,
   `incluso import`, `gruppo merceologico escluso da import`. 🔴 The filter is
   not working in UAT.
6. 🔴 **New: [OI-265](../items/OI-265%20Opportunity%20Categoria%20and%20Sottocategoria%20values%20do%20not%20match%20the%20client%20registry.md)**
   — _"i campi Categoria e Sottocategoria non sono aggiornati"_, answered with a
   screenshot and **not replied to**. 🔑 The durable point is Fabrizio
   Paganelli's own correction: reporting runs on those two fields, **not the
   opportunity name** — _"ma infatti sbagliamo come facciamo oggi."_ 🔴 **This is
   what ten sweeps without the picklist workbook in Drive costs**: neither party
   can point at a shared copy.
7. 🟢 **Three lead-qualification changes agreed in the room**:
   [OI-257](../items/OI-257%20Standard%20sector%20picklist%20values%20must%20be%20removed.md),
   [OI-258](../items/OI-258%20Leads%20from%20a%20communication%20agency%20must%20be%20blacklisted%20automatically.md)
   (the `Agenzia di comunicazione` trap), and
   [OI-259](../items/OI-259%20A%20lost%20lead%20marked%20non%20interessato%20must%20carry%20a%20mandatory%20free%20text%20reason.md)
   (mandatory `Motivazione`, **scope undecided**).
8. 🔴 **Also new**:
   [OI-262](../items/OI-262%20Sabatino%20Rinaldi%20needs%20a%20Salesforce%20user.md) ·
   [OI-263](../items/OI-263%20Salesforce%20system%20labels%20are%20still%20in%20English.md) ·
   [OI-264](../items/OI-264%20The%20quote%20expiry%20reminder%20email%20copy%20is%20a%20placeholder.md) ·
   [OI-266](../items/OI-266%20The%20quote%20product%20grid%20does%20not%20refresh%20after%20adding%20a%20line.md).
9. 🟢🔑 **`DevMain` moved and it moved the right things** — `#102` ended OI-207's
   four nights outside the branch, `#103` landed OI-214's slot, `#104` brought
   OI-163's **gating** duplicate-rule work into the integration branch for the
   first time.
10. 🟢🔑 **The OI-100/OI-163 contradiction reported on 16/10 is withdrawn**, by
    its own author, before the merge. 🔴 But **four conversion rulings in four
    days by one person** are in no register row and in neither prose document,
    and the merge-or-create behaviour the client accepted on 24/09 was reversed,
    restored and reversed again **without the client being told.**
11. 🟡 **[OI-244](../items/OI-244%20Historical%20orders%20will%20be%20migrated%20from%20Mexal%20by%20spreadsheet.md):
    the Wednesday 21/10 migration meeting is agreed by both sides in writing**, and
    🔴 **the field spec is four days late** — re-promised to the client for 20/10,
    with _"me lo sono dimenticato"_ on the record. 🟢 Now assigned to the dev
    group as well. ⚠ Fabrizio Paganelli **scoped the ask down**: invoiced orders
    only, as sales history.
12. 🔴 **[OI-246](../items/OI-246%20Key%20User%20training%20cannot%20be%20completed%20before%20the%20new%20go-live.md):
    the client declined a ROMI session for the rest of the week.** 20–23/10 is
    client-internal, their review is **Friday 23/10**, three days before training
    opens. 🔑 **Train-the-trainer changed hands without being assigned** —
    Fabrizio Paganelli takes it himself, ⚠ **having not tested the
    bundle-and-tranche path he will teach.**
13. 🟡 **[OI-254](../items/OI-254%20Creating%20a%20Referente%20and%20an%20Account%20failed%20for%20the%20client.md)
    explained in session, without the error ever being read.** A Referente with no
    Account is expected behaviour and the room chose to keep it; the blank agent
    fields inherit from the creating user, whose data was unset. 🟢 `10fa31e`
    builds that inheritance 57 minutes later — 🔴 unmerged, no PR, no tests.
    🔴 **The screenshots were still never opened and no error text exists.**
14. 🔴 **[OI-212](../items/OI-212%20A%20Ri.Ba.%20rate%20reads%20as%20paid%20before%20its%20due%20date.md)
    unchanged a ninth night**, two days from a migration rehearsal that would
    derive `incassato` for ~10,000 historical orders through it.
15. 🔴 **[OI-227](../items/OI-227%20SAL-20%20was%20rewritten%20in%20the%20signable%20requirements%20with%20no%20client%20ruling.md):
    sixth night, five messages in four days, none answered** — and `SAL-20` was
    not mentioned once in a 01:45 commercial-flow session.

## The register

**Not amended. Version stays 1.6, `go_live:` stays `2026-10-21`, `SAL-20` stays
`to_confirm`.** The only edits are **traceability pointers**, which
`drill-meeting` step 4 requires and `vault:check` reports on: `tracked_by: [OI-259]`
on `DM-07`, `OI-264` added to `SAL-09`, `OI-261` added to `BUN-06`. **No text,
priority, status or date changed.**

🔑 **Two findings tonight touch signable text, and both are conflicts rather than
decisions.**

1. **`SAL-12` against the tutor discount ask.** The register reads _"Tutors on
   fixed price list, no discretionary discounts"_, `status: agreed`. What
   Fabrizio Paganelli asked for on 19/10 is a **discount control on the quote
   line, operated by the tutor** — _"sicuramente gli verranno fatti degli
   sconti"_ — with Marco Montesi backing him. **Neither party cited `SAL-12`**,
   and Elena Spini treated the ask as a build gap rather than a scope change.
2. **`DM-07`'s competitor list against ROMI's own advice.** The register
   specifies `Sceglie concorrenza (lista competitor da selezionare)`. Marco
   Montesi asked for exactly that dropdown; **Elena Spini advised free text
   instead** — _"forse è meglio se lo mettete a ma[no] libero"_.

⚠ **Recording either as settled would write one side of an argument into a
contract-bound document.** Both are reported for a human instead.

⚠ **Nothing else found tonight calls for a register change.** OI-257, OI-258 and
OI-259's mandatory-field rule are picklist and validation behaviour below the
register's grain (its `picklists` block models values, not requiredness).
OI-260, OI-263, OI-264 and OI-266 are defects. OI-261 uses an existing modelled
property. OI-265 is a data disagreement, not a requirement change.

## The go-live date

🔴 **Deliberately not moved a fourth night.** OI-124's rule is a written
acknowledgement in the mail thread, and the thread is still unanswered. 🔑 **And
tonight's negative is the strongest yet**: Fabrizio Paganelli, Sabatino Rinaldi,
Elisa Migliano and Marco Montesi sat through 01:45:49 and **neither 2 November
nor 21 October was mentioned by anyone**, including the objector, who discussed
timetables twice.

⚠ **But the reasoning expires in two days.** The signed date is 21 October.
**From 22 October the register will state a go-live that demonstrably has not
happened** — a worse kind of wrong than stating a date the client has not yet
acknowledged. **The next run should treat 22 October as the trigger**, and change
the nine places listed in the 15/10 trace plus
`requirements/pienissimo-requirements.yaml:469`'s dual-run assumption in one
session.

## Corrections to the record

- 🟢🔑 **The 16/10 report that a human must choose between two duplicate-rule
  states is withdrawn.** It was correct when written and is now obsolete:
  Rexhina Hysi added a `2026-10-19` section to both OI-100 and OI-163 stating a
  fresh metadata retrieve and **naming the paragraph it supersedes**, and the
  merged metadata agrees. **Report-only, in the notes, the source and the
  retrieve.** The two notes' authored text was left untouched again — this time
  because it is correct, not because the branch was unmerged.
- ⚠ **OI-254's title overstates what the record supports.** No error text exists
  in any source; the mail said _"abbiamo avuto qualche problema"_ and the session
  explained both halves as expected behaviour plus an unset user field. **The
  title is kept** because the id and wording are cited in the client-facing
  numbering; the correction is in the note body and the tracker row.
- ⚠ **OI-100's _"Alert failure reproduced with synthetic data"_ section is history,
  not current behaviour**, and **it was the standing lead for OI-254**. That lead
  is dead.
- ⚠ **The Gemini auto-summary understates one finding and is right about the
  rest.** It records the untranslated-label action in the **singular** where
  Elena Spini's own words are _"questi sono tutti rimasti in inglese"_ (OI-263),
  and it assigns the reminder copy to _"il gruppo"_, which is not an owner
  (OI-264). Its `Concordato` / `Da approfondire` split matches the transcript.
- ⚠ **Dictation repairs are flagged, not silently applied.** Salesforce renders
  as _"Sales SOS"_, _"Sales Force"_, _"salesource"_, _"saleswors"_, _"sees
  forse"_; Mexal as _"Maxal"_, _"Mixal"_, _"Mexale"_, _"sensor"_; Anticipay as
  _"Antipay"_; `passkey` as _"pasy"_, _"paski"_; `bundle` as _"bando"_, _"band"_;
  `preventivo` as _"quot"_, _"quotivo"_. Each repair inside a quotation is marked
  with square brackets.
- ⚠ **`marco.m@apissimo.com` in the transcript is dictation for
  `marco.m@pienissimo.com`**, per the calendar invitation. Not recorded as an
  address.
- ⚠ **The login tool Fabrizio Paganelli installed is rendered _"Proton"_ and is
  identified nowhere.** Recorded as his word, not as a named product.
- ⚠ **Sabatino Rinaldi's _"può andare anche in fase 5"_ (OI-258) is recorded
  verbatim.** This project has two phases; what he meant is not determinable, so
  the item is **not** ruled into Fase 1.
- 🔴 **The pre-existing tracker defect is unchanged, and tonight it mattered.**
  Rows **163–174 remain duplicated** in `meetings/open-items.md` **and** `.it.md`,
  both copies inside the same `## Open` section, and the two copies still differ.
  **Row 163 is one of tonight's refreshes**, so unlike 16/10 this run did touch a
  duplicated row: **both copies were given the same update**, so neither is
  silently preferred and neither is left stale. A human still has to say which is
  current.
- ⚠ **Row `| 83  |` is still padded to three characters** in both trackers. Not
  in tonight's set; noted so a naive row-matching script is not trusted.

## Not done in this run

- The org was **not** opened. `STATUS.md` was not regenerated and the Notion
  mirror stays stale. Every build claim is repository arithmetic against
  `origin/DevMain` `926195c`.
- **No Apex test was written, proposed or scaffolded**, per the standing
  instruction. [OI-64](../items/OI-64%20The%20bundle%20Apex%20test%20suite%20is%20broken.md),
  [OI-66](../items/OI-66%20No%20test%20classes%20for%20the%20Biglietto%20stack.md) and
  [the deploy risk](../risks/Risk%20-%20production%20deploy%20is%20blocked%20by%20Apex%20coverage.md)
  were not touched; nothing tonight changed their state. ⚠ **All four merged PRs
  and both `DevAnita19` commits ship untested Apex** — recorded as an absence,
  not acted on.
- **The register's substance was not edited** — see above; only `tracked_by`.
- **OI-212 was not fixed**, a ninth night. The correction is a code change and
  belongs to Aurel Mrruku.
- **The `Opportunity` thread's three inline images were not opened** — Elena
  Spini's picklist screenshot is the one artefact that would settle OI-265, and
  it is a client screenshot that may carry customer data. **First step for a
  human.**
- **The 16/10 `Referente e Account` screenshots were still not opened** (OI-254),
  a second run.
- **The two images in the Slack DMs were not opened** — the discount screenshot
  and the `Genera PDF` error screenshot (16:12:56 and 16:20:11 CEST). The error
  one is the **second** place that exception exists.
- **What `questa cosa` refers to in Fabrizio Mastracci's _"nuova change
  request"_ message was not established** — it points at an unopened image.
- **Neither failing flow was opened** (OI-225, OI-230). Org-only, read-only here.
- **No MP4 recording existed for the 19/10 session**, so nothing was skipped
  there; the transcript is the whole record.
- **OI-223's blast radius was not assessed** — a tenth run.
- **OI-207 was not verified in the org** — an eleventh run, and tonight it is the
  question that would separate the three readings of the client's complaint.
- ⚠ `JOURNAL.md` is at **124 entries** against a documented limit of 20.
  Archiving to `notes/sessions/` is overdue and **was left alone again**.
- `npm run prettier:verify` was not run (no `node_modules`), so tonight's
  markdown is unformatted.

## Still unreachable

- 🆕 🔴 **Which picklist values are current for Opportunity `Categoria` and
  `Sottocategoria`** (OI-265). The client says stale, ROMI says they match the
  workbook, **and the workbook has never been in Drive**. **Open Elena Spini's
  15:10:55Z screenshot, then ask Elisa Migliano for the file.**
- 🆕 🔴 **The `Genera PDF` exception text** (OI-260). It exists in Aurel Mrruku's
  mailbox and in Elena Spini's 16:20:11 CEST screenshot. **Neither was opened.**
- 🆕 **Which fields OI-257 means.** The transcript says _"queste due picklist"_
  and names no API field. **One question to Elena Spini settles it.**
- 🆕 **Whether Sabatino Rinaldi's user was created** (OI-262), promised for
  immediately after the call.
- 🆕 **What Fabrizio Mastracci's _"nuova change request"_ message refers to**
  (marketing DM, 19/10 16:10:45 CEST).
- 🆕 **Whether Elisa Migliano can log in on her own account** — she is working
  through Fabrizio Paganelli's login and Elena Spini asked for a real test.
- 🔴 **What the client's 15:00 internal meeting of 16/10 decided** about reminder
  intervals and special-event templates. **OI-250 and OI-252 both wait on it**,
  and it did not come up in the 19/10 session. **Ask Elena Spini or Elisa
  Migliano.** Second run.
- 🔴 **The error behind `Referente e Account`** — four inline screenshots in Gmail
  `1a1454177ff30250`, unopened. ⚠ Now **largely explained** in session, so this is
  a confirmation rather than a diagnosis.
- **The two mails Fabrizio Mastracci and Rebecca Marmo exchanged about the 11
  send logics.** Second run; neither surfaced tonight. **Ask Fabrizio Mastracci.**
- **Pienissimo's Zoom subscription tier** and whether a standard connector exists
  on it (OI-255). Second run. **Ask Sabatino Rinaldi** — he was in the room for
  01:45 today and it was not raised.
- 🔴 **What happens to Zoho CRM after 31 October** — read-only, grace period or
  data loss, and whether the contract can be extended. **Third run**, and the
  session spent fifteen minutes on extracting history from Mexal without
  mentioning it. **Ask Fabrizio Paganelli or Sabatino Rinaldi.**
- **How many contracted training hours exist and whether they cover eight users**
  (OI-246). Third run; the window is 26–30/10 and the hours still are not known.
- 🔴 **Which profile a _responsabile commerciale_ holds, and which a tutor** —
  OI-233, OI-240, OI-247 and OI-250 all wait on it, and **tonight it became the
  reason the key-user test is not a test of real permissions.** Promoted: this is
  now the single most-blocking unknown a person can clear in one decision.
- 🔴 **Whether Marco Montesi accepts the train-the-trainer role.** Third run —
  and tonight **Fabrizio Paganelli took it himself** without anyone assigning it,
  so the question has changed shape: **who owns tutor training?**
- 🔴 **`Mappatura_Categorie_Sottocategorie_Origine Lead_Tipologiattività.xlsx`** —
  the four Lead picklists, still a **mail attachment only, tenth run**, and
  tonight it is what OI-265 cannot be settled without. **Ask Elisa Migliano or
  Elena Spini to put it in Drive.**
- 🔴 **The 30/07 marketing notes** — Drive id
  **`1uJCE4NW9nbdI38ADmt66svUT1MRmkyYd24uI0hegAD0`**, from the canvas, 404 for
  `a.mrruku@romicompany.com`. **Ask Elena Spini to share it.** Sixth run.
- **What the three ROMI-side huddles settled** — 14/10 15:35:52 and 16/10
  12:12:14. Voice is not a source this procedure can read. The `RINUNCIA`
  published-text ask of 14/10 is **still not settled in text**.
- **Whether `DTT SHR Mappatura form handler campi.xlsx` is a Pienissimo
  artefact.** One question to Elena Spini. Fourth run.
- **Which bug Elisa Migliano was asked to report** on 14/10. She spoke throughout
  today's session on other matters.
- **The identity of the DocuSign production configuration** — templates, sending
  identity, envelope allowance. ⚠ The signature-request mails were **shown
  working** in today's session, and **who wrote their copy is also unknown**
  (OI-264). ⚠ Nothing on
  [OI-231](../items/OI-231%20DocuSign%20closed%20the%20Pienissimo%20onboarding%20for%20non-response.md)
  in any source: the client is unanswered a **seventh** day.
- **`Flows & Objects.drawio`** — did not move; still an unparseable `mxfile`.
  **Ask Elena Spini for a PNG or PDF export.**
- **Which WooCommerce instance is correct for books and videocorsi, and when the
  orders move** (OI-241). Third run. **Ask Sabatino Rinaldi** — in the room again
  today, not raised again.
- **What `Get Campaign` is looking for** in both failing flows. Needs the org.
- **What is in Jira project `PIEN`** — no connector. **Ask Elena Spini.**
- **The contents of `Regole Codifica Codici Articolo.xlsx` beyond its structure**
  — read, code values deliberately not recorded.
- **The full text of `Pienissimo_Scheda di Partecipazione ai corsi_da firmare.pdf`**
  — not opened; its enrolment pages may carry personal data. ⚠ OI-194 is still
  gating and went undiscussed a **twentieth** day.
- ⚠ **The document Rebecca Marmo shared** with Fabrizio Mastracci. Eleventh run.
- **The WooCommerce logic document** for Daniela Morgese — twelfth run.
- **The 12:30 CEST internal call of 25/09** — still no artifact, eighteenth run.
- ⚠ **The Pienissimo lead documentation** Elena Spini said she owed on 28/09, and
  the **technical documentation for the ticket flow** she committed to on 16/10
  with no date, owner or format. Neither advanced.
- ⚠ **Sabatino Rinaldi's card and PayPal test orders** — WhatsApp is not readable
  here.
- ⚠ **The `ai-visibility-fmf` form check** Elena Spini posted on 08/10 — eighth
  run, screenshot never opened, **still no owner**.
- **The WhatsApp number Matteo Distaso owes Fabrizio Mastracci** — seventh run.
- **Fabrizio Mastracci's `testlist degli invii`** — sixth run, in no source.
- **The _diretta_ form Elena Spini asked Sabatino Rinaldi for**, for the hidden
  fields. ⚠ Asked again today (`00:33:01`) and deferred again: _"lo farete poi,
  non è un problema."_ Second recorded ask.

## Absence of evidence, stated as absence

- 🔴 **Fathom returned nothing in tonight's window, and this time it is a
  demonstrated negative.** A widened probe returns the 15/10 247.it meeting, so
  the tool responds, and **the window is empty of every meeting, not only
  Pienissimo's** — so Fathom recorded nothing at all over three days. **Twentieth
  consecutive run with no Pienissimo meeting**, on a day a 01:45:49 Pienissimo
  session was captured by Google.
- 🟢 **A Gemini notes mail and a full transcript both arrived** for the 19/10
  session, within six minutes of each other. ⚠ **No MP4 recording appeared**,
  unlike 16/10.
- 🔴 **`#tproj-pienissimo` is silent again** after breaking six days on 16/10.
  🟡 **The dev group carried one human message**, and it is the right one —
  OI-244's Excel put to the group. ⚠ **Still no reply to any nightly report:
  twenty-nine nights.**
- **Nothing was found on [OI-212](../items/OI-212%20A%20Ri.Ba.%20rate%20reads%20as%20paid%20before%20its%20due%20date.md)**
  in any source — not the 01:45 session, not a mail, not a message, not a commit.
  Ninth night; the confirmation date is eight days past.
- 🔴 **Nothing from Mirko Merendi, and no Kreosoft mail at all** — a **seventh**
  consecutive run, with OI-245's disputed fact still pointed at him and OI-244
  depending on it.
- 🔴 **`SAL-20` appeared in no source**, in a session that walked the entire
  quote-to-tranche path it describes. Sixth night.
- 🔴 **The go-live date appeared in no source** — not the session, not the mail
  thread, not Slack. Four client people and 01:45:49.
- **Nothing on the Business Blueprint signature** — the 09/10 _"confermato e
  firmato"_ claim is unsupported a **seventh** run.
- **Nothing on OI-194**, OI-202, OI-204's documentation half, OI-205, OI-206's
  missing reports, OI-216, OI-218, OI-224, OI-225, OI-230, OI-232, OI-235,
  OI-236, OI-237, OI-238, OI-239, OI-241, OI-245, OI-248, OI-249, OI-250, OI-251,
  OI-252, OI-253, OI-255 or OI-256.
- **Nothing on OI-96's thirteen remaining empty categories or the `E10`
  collision** — and no tracker row for them still, a fourth run.
- **Which agent code an agentless WooCommerce order uses is still unanswered by a
  person** (OI-214) — twelve days, and 🔑 **Marco Montesi sat through 01:45 today
  and nobody asked him.**
- **The QR credential rotation has still not happened** — thirteenth day, and the
  client approved a production move three days ago.
- **Rebecca Marmo's two funnel questions remain unanswered**; she was not in
  today's session.
- ⚠ **"Claudio" is still unresolved**, credited by Elena Spini on 06/10.
  ⚠ **"Giuliano Lanzetti"** and **"Tech Romi" (`005SW00000PV5Ja`)** still match
  nobody. ⚠ **"Davide Stefani"**, **"Carmine"** and **"Carmen Troiano"** did not
  recur — though a resource rendered _"Carla, Caca, Carmen"_ was used as the lead
  owner in today's conversion test, which is **plausibly the same unresolved
  person** and is recorded as uncertain.
- ⚠ **Andrea Galotto still has no person note** and is still named in OI-255's
  load-bearing pre-contract claim and in OI-83's Fase 2 estimate.
- **Elena Spini's post-launch support estimate** is not in any source.
