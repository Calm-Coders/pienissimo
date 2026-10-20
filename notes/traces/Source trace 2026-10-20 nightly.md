---
id: trace-2026-10-20-nightly
type: reference
status: active
updated: 2026-10-20
watermark_used: 2026-10-19T22:00Z
external_watermark: 2026-10-20T22:00Z
account: a.mrruku@romicompany.com
---

# Source trace 2026-10-20 nightly

**Watermark for the next `requirements-check` run: 2026-10-20T22:00Z, single
value.**

**Watermark used: 2026-10-19T22:00Z**, the `external_watermark` stated by
[the 19/10 nightly trace](Source%20trace%202026-10-19%20nightly.md), selected by
`updated:` frontmatter. Scheduled nightly run, executed 2026-10-20 ~21:45Z. One
day.

🔴 **The client sent their own go-live calendar, proposing 16 November, and it
keeps invoicing on Zoho for thirteen days after the contract expires.**

🟢 **Environment note.** The clone opened on `main` (two commits, config only)
with none of the knowledge layer in the working tree; `DevMain` did not exist
locally and was created with `git checkout DevMain` against the fetched remote
branch. **Eighteen runs, same opening pattern.**

🔑 **A human wrote to the knowledge layer today, for the first time in this
procedure's record.** `25629af`, authored by Aurel Mrruku at 18:29 CEST, is
`DevMain`'s head and contains **only** notes: `JOURNAL.md`, OI-244, and a new
**OI-267**. So the id this run allocated from is **268**, not 267, and the
journal shows a second Claude session ran earlier today on the migration spec.

## Sources searched

| Source | Query / scope | Result |
| ------ | ------------- | ------ |
| **Gmail** | `pienissimo after:2026/10/19 -in:draft`, 50 requested, 7 estimated | 🔑 **Five new items.** The **go-live proposal** (Elena Spini's forward, 09:48:52Z) · **two sandbox error mails** (10:20:19Z and 10:20:20Z) · the **21/10 calendar invitation** (06:55:12Z) · **Aurel Mrruku's sent mail with the migration workbook** (16:28:41Z). The `Opportunity` thread and the 19/10 Gemini notes are already held |
| **Gmail** | `get_thread 1a158b6e3e4cee81` (PLAIN_TEXT, full body) | 🔑 **The finding of the night.** Sabatino Rinaldi to Elena Spini, 20/10 11:31 CEST, cc Fabrizio Paganelli, Marco Montesi, Elisa Migliano, `amministrazione@`, Matteo Distaso, Rebecca Marmo; forwarded to Aurel Mrruku and Fabrizio Mastracci with the single word _"FYI"_. **Eight numbered sections.** Read in full — [OI-268](../items/OI-268%20The%20client%20proposed%20a%20go-live%20calendar%20of%2016%20November.md) |
| **Gmail** | `get_thread 1a15817bd8832c8e` (PLAIN_TEXT, both messages) | 🟢 **The 21/10 meeting is a calendar invitation**, `[ROMI-PIENISSIMO] - Check Dati Migrazione e OP`, **Wed 21 Oct 10:00–11:00 (GMT+2)**, organiser Elena Spini, to Aurel Mrruku, `amministrazione@pienissimo.com`, `fabrizio.p@pienissimo.com`. 🟢 **And his reply at 16:28:41Z carries the workbook**: _"Allego qui il file exel con i campi che ci servono per la migrazione del ordine e le righe d'ordine"_ (`sizeEstimate` 252,939 — consistent with the 164.6 KB attachment) |
| **Gmail** | `get_message` ×2 on the two sandbox mails (PLAIN_TEXT) | 🔑 **Real error text, and it is a test.** `Errore controllo Anticipay` — `Stato HTTP: 404`, `Messaggio: TEST - Azienda non trovata`, log `a05MA00000GdIbuYAF` · `Errore creazione cliente Mexal` — `Stato HTTP: 400`, `Creazione cliente Mexal fallita`, log `a05MA00000GdK7bYAF`. Both on Account `001MA000013uCyrYAE` in `--partial.sandbox`. 🟢 **The 17:01 call confirms they are Aurel Mrruku's own test traffic**, so **not a live failure** |
| **Slack** | `slack_read_channel C0BQD34LLF4` (dev group), `oldest` 1792447200 = 2026-10-19T22:00Z | 🟡 **4 messages, 3 human.** Aurel Mrruku, 20/10 17:24 CEST, three in twelve seconds: _"duan dhe skonton kur vendos produktet"_ · _"te quota"_ · _"e kemi pass po sesht me"_ — the OI-207 discount design relayed 23 minutes after it was agreed. ⚠ The third is not reliably translatable; recorded verbatim, not treated as a finding. The fourth message is this procedure's own 19/10 report. 🔴 **Still no reply to any nightly report — thirty nights** |
| **Slack** | `slack_read_channel C0B5T3RB4FM` (`#tproj-pienissimo`), same bound | **0 messages.** Silent |
| **Slack** | `slack_read_channel C0C38JJ9D1T` (marketing group DM), same bound | 🔑 **21 messages, and they carry ROMI's whole reaction.** 11:49–11:59 the go-live mail lands: _"io boh, sono sconvolta da questi di PIENISSIMO"_ · _"non mi è mai capitato MAI che fosse il cliente a mandarmi il calendario"_ · _"questi si fanno i conti senza l'oste"_ · **all three refuse the weekend in nine minutes** · 🔴 _"io non ci sono il 16"_ / _"NON ho intenzione di esserci"_. 🔑 **New blocker at 11:51:49** — WhatsApp will not connect ([OI-271](../items/OI-271%20WhatsApp%20cannot%20be%20connected%20to%20Salesforce.md)). 🔑 **19:33:53 `@channel` with four explicit asks for tomorrow** and _"vorrei mandare una risposta asap domani mattina quindi datemi un feedback please"_ — **so the client's proposal is unanswered** |
| **Slack** | `slack_read_channel D0B5QHS2T7H` (Elena Spini DM), same bound | 🟢 **10 messages, and they document the delivery.** 09:16:24 _"reminder Excel ordini per Fabrizio Pienissimo"_ · 18:06:23 _"pardon riesci per cortesia ad indicarmi il thread per mandare l exel con i campi"_ · 18:06:33 **the file** `Tracciato migrazione ordini Mexal - Salesforce.xlsx` (`F0CAJ40LM99`, 164.6 KB) + _"oppure manda te direttamente"_ · 18:32:51 _"ho fatto sulla mail della call"_ · 18:33:04 _"visto perfetto thanks 😉"_ ✅. The 15:07 LIFE365 line is another project |
| **Slack** | `slack_read_canvas F0BD2H5A9HT` (`Link utili Pienissimo`) | **Unchanged.** Newest entry still 20.08.2026 — static **ten weeks**. Re-read per the skill; still the only source of the 30/07 marketing notes link |
| **Drive** | `modifiedTime > '2026-10-19T22:00:00Z'`, **2 pages, 30 files** | 🔑 **Three Pienissimo artefacts.** `[PIENISSIMO] - Follow-up Interno - 2026/10/20 17:01 CEST - Transcript` (Doc `1eb6vvUzuGDpG9DURm6Rx408x1B59ftvMAINyqv-_obw`, 23,181 bytes, owner Elena Spini, shared 16:17:14Z) with its folder and shortcut · `Order/OrderItem Salesforce Fields` (`1XCD2STp3HW3ryn8k4m9VH72QlPFtFDlQl5Xhb9HpbBg`, Anita Aga, created 08:00:40Z, shared 08:49:52Z) · `Opportunità_Zoho_CRM_` (`15EItrzNDIyCj7-ivmiif2-S7IxvKJJFrtidPau16tMg`, Anita Aga, created 08:17:19Z, **~4.4 MB**). ⚠ **No MP4 for the 17:01 call**, as on 19/10. The rest are other clients (ZUCCHET, IUAD, Daze, 247.it, Vision, permo, LIFE365, a ROMI holiday sheet) — ignored |
| **Drive** | `read_file_content 1eb6vvUzuGDpG9DURm6Rx408x1B59ftvMAINyqv-_obw` | 🔑 **The 20/10 internal call, 00:29:47**, read in full in one pass. Completeness checked: it ends on _"La riunione è terminata dopo 00:29:47"_. **Preserved verbatim** at `meetings/2026-10-20-follow-up-interno-transcript.it.md` (27,767 bytes) |
| **Drive** | `read_file_content 1XCD2STp3HW3ryn8k4m9VH72QlPFtFDlQl5Xhb9HpbBg` | 🟢 **Headers only, no data** — 16 Order columns, 14 OrderItem columns, two sheets. 🔑 The OrderItem sheet carries `ListPrice`, `UnitPrice`, `TotalPrice`, plus `Stato_Scadenza__c` and `Mexal_Payment_Status__c`. **Field names only; no values, no prices** |
| **Drive** | `Opportunità_Zoho_CRM_` | ⚠ **Deliberately not opened.** A ~4.4 MB Zoho opportunity export will hold real customer records. **Recorded as existing, with its id and size, per the standing constraint** |
| **Fathom** | `list_meetings created_after 2026-10-19T22:00Z`, summaries, 3 pages | **0 meetings.** 🔴 **Twenty-first consecutive run with no Pienissimo meeting**, on a day a 00:29:47 Pienissimo call took place and was captured by Google, not Fathom |
| **Git** | `fetch origin`, `log --all --since 2026-10-19T22:00:00Z` | 🟢 **9 commits.** `DevMain` moved `9fe42fb` → **`25629af`** — 🔑 **knowledge only**, authored by Aurel Mrruku. **Anita Aga's seven**, all unmerged: `504ba37` flexipages · `baa8597` **12:27:43 the Motivazione field** · `bac9f6f` **15:05:02 the grid refresh** · `4e4d6a8` lead flexipage + full permission · `5c844ae` flexipage · `81a075b` full permission (`DevAnita19`) · `750978a` **18:03:16 `Cambia stato`** (`DevAnita20`). **0 PRs merged** |
| **Repo** | `git show` on `baa8597`; `Motivazione__c.field-meta.xml`; `leadCustomPath.js` | 🔴 **The build covers one of four values.** `requiresMotivazione` gates on `exitReason === "Perso" && exitReasonDetail === "Non interessato"`. Field is `TextArea`, `<required>false</required>` — enforcement is in the LWC only, label `Dettaglio non interesse` |
| **Repo** | `Dettaglio_Motivazione_Uscita__c.field-meta.xml` | 🔑 **Ten values, not four**, so the 17:01 decision names a subset nobody wrote down. The four debated on 19/10 are the likeliest reading and are **marked uncertain** in [OI-259](../items/OI-259%20A%20lost%20lead%20marked%20non%20interessato%20must%20carry%20a%20mandatory%20free%20text%20reason.md) |
| **Repo** | `git show` on `750978a` and `bac9f6f` | 🟢 `label="Cambia stato"` in **both** `leadCustomPath.html` and `opportunityCustomPath.html` · 🟢 the refresh is a new `QuoteProductsChanged` Lightning message channel across three LWCs **with a 143-line jest suite** |
| **Repo** | `git log -1 origin/DevMain -- MexalScadenzarioSearchService.cls` | 🔴 **OI-212 unchanged a tenth night** — still `f292b72`, 08/10, in none of today's nine commits. **The migration rehearsal is tomorrow at 10:00** |
| **Repo** | register greps: `go_live`, `zoho_expiry`, `SAL-12`, `DM-07`, `DM-19`, `CTX-02`, `PP-` | `go_live: 2026-10-21`, `zoho_expiry: 2026-10-31`, version 1.6. 🔑 **No `PP-` prefix exists** — the Performance Plus contract requirement is `DM-19`, which is what OI-272 cites |

## Found

1. 🔴🔑 **[OI-268](../items/OI-268%20The%20client%20proposed%20a%20go-live%20calendar%20of%2016%20November.md):
   the client proposed 16 November, with migration across the 13–15 November
   weekend.** The third date on this project and **the first one the client
   proposed.** ROMI has not replied; internally the weekend and the 16th are both
   refused and the counter is a **9 November release**.
2. 🔴🔑 **It puts invoicing on Zoho thirteen days past the contract.**
   _"fino al 13 novembre … la fatturazione resta su Zoho e Mexal"_ against
   `zoho_expiry: 2026-10-31`. The gap goes **−2 → −16 days**, and this is the
   **first time Zoho appears in a go-live plan from either side** —
   [the risk](../risks/Risk%20-%20go-live%20now%20falls%20after%20the%20Zoho%20contract%20expires.md).
   🔑 The shape changed, not just the size: the client has **planned work inside
   the gap**, which means either they hold a contract ROMI does not know about, or
   their calendar invoices on an expired system for a fortnight. **Nothing in any
   source distinguishes these, four runs after the question was first asked.**
3. 🟢🔑 **[The 20/10 internal call](../meetings/2026-10-20%20Follow-up%20Interno.md)
   settled six build items in 29 minutes** — OI-207 (a design at last), OI-263,
   OI-266, OI-259, OI-250, OI-242. **This is the most productive half hour in the
   recent record**, and it happened with no client present.
4. 🟢 **[OI-207](../items/OI-207%20The%20quote%20and%20order%20layouts%20omit%20the%20commercial%20fields%20the%20client%20requires.md)
   has a discount design**: _"come abbiamo fatto per la parte bundle e performance
   plus. Stessa logica"_ — the unit price carries the discounted price. 🔴 **But
   `SAL-12` still reads _"no discretionary discounts"_, `status: agreed`, and
   nobody has cited it in any of the three sessions where the discount was asked
   for.** Unit of measure and net price remain unaddressed, and **nothing was
   built for it today.**
5. 🟢🔑 **[OI-244](../items/OI-244%20Historical%20orders%20will%20be%20migrated%20from%20Mexal%20by%20spreadsheet.md)'s
   field spec was sent**, 16:28:41Z, on the day re-promised. 🔴 But
   [OI-267](../items/OI-267%20Loading%20historical%20orders%20would%20push%20them%20to%20Mexal%20and%20generate%20tickets.md)
   is gating and unchanged, OI-212 is unchanged, and 🔑 **the client has now
   committed in writing to deriving Fatturazione and Scadenzario through it.**
6. 🔴🔑 **Two pieces of scope grew and neither was called a change request to the
   client.** [OI-250](../items/OI-250%20The%20reminder%20wait%20intervals%20must%20be%20configurable%20per%20edizione.md)
   went **11 → 15 interval fields** with templates _"completamente
   personalizzabili"_, and the permission question is answered by **a manual edit
   in production that is then overwritten**. New
   [OI-269](../items/OI-269%20Event%20communications%20must%20be%20differentiated%20by%20ticket%20type.md)
   is _"per noi è un requisito"_ — 🔴 **and the Asset carries no ticket type.**
7. 🟡 **[OI-259](../items/OI-259%20A%20lost%20lead%20marked%20non%20interessato%20must%20carry%20a%20mandatory%20free%20text%20reason.md)'s
   scope settled at four values**, and 🔑 Aurel Mrruku called it a CR — _"digli che
   è una CR"_. 🔴 **The build covers one**, and ⚠ **which four is never stated**;
   the picklist has ten.
8. 🟢 **[OI-263](../items/OI-263%20Salesforce%20system%20labels%20are%20still%20in%20English.md)
   decided and built in 62 minutes** (`Cambia stato`, both paths) and
   🟢 **[OI-266](../items/OI-266%20The%20quote%20product%20grid%20does%20not%20refresh%20after%20adding%20a%20line.md)
   was never a regression** — the refresh only ever covered PDF generation,
   _"l'ho pensato io"_ — **fixed with 143 lines of jest.** Both unmerged.
9. 🟢 **The 10:20Z error mails are test traffic and the notification path works.**
   Aurel Mrruku, unprompted: _"sto ricevendo 404. Testa azienda non trovata"_ …
   _"Sì che funziona tutto"_, against Elena Spini's _"non sapevo se effettivamente
   funzionava"_. 🔑 **Worth recording because the mails would otherwise read as a
   live integration failure on the day before a migration rehearsal.**
10. 🔴 **Also new**:
    [OI-270](../items/OI-270%20The%20client%20wants%20a%20test%20company%20created%20in%20production.md)
    (a test company **in production**; ⚠ **nobody has asked whether its fake
    orders would reach live Mexal**, which is OI-267's exact behaviour) ·
    [OI-271](../items/OI-271%20WhatsApp%20cannot%20be%20connected%20to%20Salesforce.md)
    (**WhatsApp will not connect**, on the day the client took ownership of
    configuring WhatsApp messages; ⚠ **no register row covers WhatsApp**) ·
    [OI-272](../items/OI-272%20A%20standard%20contract%20expiry%20alert%20rule%20is%20requested.md)
    (🟢 with a clean client pass on Performance Plus) ·
    [OI-273](../items/OI-273%20How%20the%20event%20date%20fields%20must%20be%20filled%20for%20multi-day%20events%20is%20unanswered.md).
11. 🟡 **[OI-246](../items/OI-246%20Key%20User%20training%20cannot%20be%20completed%20before%20the%20new%20go-live.md):
    the client asked ROMI back in for Friday 23/10**, thirty hours after sending
    them away, and 🟢 **undertook to send a written summary of their review** —
    the first time they have promised to report test results back. ⚠ Unanswered,
    and no hour was given.
12. 🔑 **A Fase 2 scoping draft exists, authored by a `Claudio`, unshared, still
    carrying 21 October as the go-live.** Elena Spini: _"praticamente gli costerà
    come lo stesso progetto che non vorranno mai."_ ⚠ Aurel Mrruku's two
    unanswered points: **45 days is far too little**, and **maintenance is
    unscoped**.
13. 🔴 **He put the marketing failure on the record**: _"L'abbiamo gestito
    malissimo la parte di marketing … abbiamo fatto lo stesso errore sull'API …
    abbiamo buttato via del tempo prezioso."_ **First first-hand internal account
    of why that work arrived late.**
14. ⚠ **An internal flow review with Elena Spini, Anita Aga and Rexhina Hysi was
    proposed and not scheduled.** She accepted while discounting herself:
    _"il mio punto di vista vale zero."_

## The register

**Not amended in substance. Version stays 1.6, `go_live:` stays `2026-10-21`,
`SAL-12` stays `agreed`, `SAL-20` stays `to_confirm`.** The only edits are
**traceability pointers**, which `drill-meeting` step 4 requires and
`vault:check` reports on: `tracked_by: [OI-124, OI-128, OI-243, OI-268]` on
`CTX-02`, `tracked_by: [OI-272]` on `DM-19`. **No text, priority, status or date
changed.**

🔑 **One finding tonight touches signable text and it is a conflict, not a
decision.** `SAL-12` reads _"Tutors on fixed price list, no discretionary
discounts"_, `status: agreed`, and the 20/10 call **designed the build for a
tutor-operated line discount** without anyone citing it. That is now the third
session in which the discount was discussed and `SAL-12` was not mentioned.
⚠ **Recording the design as settled would write one side of a contract conflict
into the register.** Reported for a human instead.

⚠ **`DM-07`'s competitor-list conflict is unchanged** and becomes sharper: if
`Sceglie concorrenza` is one of OI-259's four values, the build now puts free
text over a signable dropdown. Still a human's ruling.

⚠ **Nothing else found tonight calls for a register change.** OI-269, OI-270,
OI-272 and OI-273 are new asks and open questions, not amendments; OI-271 has no
register row to amend, **which is itself the finding**; OI-250's field count is
build detail below the register's grain.

## The go-live date

🔴 **Not moved, and the reasoning has changed.** The OI-124 rule is that the
register does not move on a proposal awaiting a reply, because `REQUISITI.it.md`
is the signable text. **Tonight that rule holds with the proposer reversed**:
16 November is the *client's* proposal, ROMI has not accepted it, and internally
refuses two of its three load-bearing elements. Writing it in would record as
contractual a date ROMI has not agreed to.

**Three dates, agreement on none:**

| Date | Proposed by | Status |
| ---- | ----------- | ------ |
| **21 October** | signed | 🔴 in the register; **it is tomorrow** |
| 2 November | ROMI, 15/10 | never acknowledged; superseded ([OI-243](../items/OI-243%20Go-live%20moved%20from%2021%20October%20to%202%20November.md) → `superseded`) |
| 16 November | **the client**, 20/10 | unanswered; weekend and date internally refused |

🔑 **The 22 October trigger named by the 19/10 trace now has client-side written
proof behind it.** The client's own mail schedules internal training _"fino al 13
novembre"_, which is documentary evidence they are not going live on the 21st.
**From 22 October the register states a go-live that demonstrably did not
happen.** This run did not move it because the decision is a human's and the
replacement date is contested; **it is due now, and it is nine places plus
`requirements/pienissimo-requirements.yaml:469` in both languages in one
session.**

🔴 **And the 27 October Go/No-Go has lapsed unmentioned.** OI-243 set it _"entro e
non oltre il 27/10"_; the client's new calendar does not mention a Go/No-Go at
all and no source replaces it.

## Corrections to the record

- 🔑 **The next free id is 274, not 268 as the 19/10 trace implied.** `25629af`
  allocated **OI-267** earlier today, outside this procedure. **A nightly run can
  no longer assume it owns the id sequence**; the max id must be read from
  `notes/items/` at the start of every run, which this one did.
- 🟢 **The 19/10 report that the field spec was four days late is superseded, not
  wrong.** It was delivered on 20/10, the day re-promised. OI-244's own
  `2026-10-20` section said _"not yet sent at the time of writing"_ — written by
  the earlier session at ~18:29 CEST; **this sweep establishes it was sent at
  16:28:41Z**, before that commit. The note now records the delivery.
- ⚠ **OI-266 was mis-framed when raised.** It was recorded on 19/10 against the
  day `#102` redeployed `QuoteLineItemTriggerHandler.cls`, with a trigger-side
  recalculation as the ordinary suspect. **It was not that**: the auto-refresh was
  never built for product insertion, and Elena Spini's expectation was her own.
  The 19/10 text is left as written and corrected in the new section.
- ⚠ **The 404 mails must not be read as a defect.** Anyone sweeping Gmail and
  stopping at the subject line would record a live Anticipay and Mexal failure the
  day before a migration rehearsal. **The transcript is the only source that
  disambiguates them**, and it was published to Drive 107 minutes after they
  arrived.
- ⚠ **`SAL-20` was not mentioned anywhere today** — seventh night. Nor was the
  Zoho expiry, by either party, in a day that produced a go-live calendar.
- ⚠ **Dictation repairs are flagged, not silently applied.** `Mark Current Stage`
  renders as _"Mark Curent Stage"_ and _"Marquez Current Stage"_; Salesforce as
  _"Sales Force"_, _"salesource"_; WooCommerce as _"Wcommerce"_; mockup as
  _"mocup"_; picklist as _"piccl"_; manual steps as _"manuel step"_; `preventivo`
  as _"quot"_. Repairs inside quotations are bracketed.
- ⚠ **Five names in the 20/10 transcript cannot be resolved and no person note was
  created for any of them**: **Giampaolo** (advised on the go-live reply),
  **Claudio** (the Fase 2 draft), **Andrea** (approved its shape for quoting; a
  different `Andrea` is blamed for the API start), **Beliven** (the website
  vendor), **Morris**/**Moris** (the Salesforce side of the campaign-ID gap) and
  **Giuseppe**. Recorded as spoken, with no role or organisation asserted. The
  _"Ana"_ and _"regina"_ of the proposed flow review are most likely Anita Aga and
  Rexhina Hysi, but that is inference from the dev group's membership and is **not
  treated as fact**.
- 🔴 **The pre-existing tracker defect is unchanged.** Rows **163–174 remain
  duplicated** in `meetings/open-items.md` **and** `.it.md`, both copies inside the
  same `## Open` section, and the two copies still differ. **None of tonight's
  refreshed rows falls in that range**, so unlike 19/10 no duplicated row was
  touched. A human still has to say which copy is current.
- ⚠ **Row `| 83  |` is still padded to three characters** in both trackers. Not in
  tonight's set; noted so a naive row-matching script is not trusted.
- ⚠ **`MAP.md` still carries two `## Where the project stands` headings.** Tonight's
  entry went into the **first**, which is the live block. Not repaired — which of
  the two is intended is a human's call.

## Not done in this run

- The org was **not** opened. `STATUS.md` was not regenerated and the Notion
  mirror stays stale. Every build claim is repository arithmetic against
  `origin/DevMain` `25629af` and the named unmerged commits.
- **No Apex test was written, proposed or scaffolded**, per the standing
  instruction. [OI-64](../items/OI-64%20The%20bundle%20Apex%20test%20suite%20is%20broken.md),
  [OI-66](../items/OI-66%20No%20test%20classes%20for%20the%20Biglietto%20stack.md) and
  [the deploy risk](../risks/Risk%20-%20production%20deploy%20is%20blocked%20by%20Apex%20coverage.md)
  were not touched; nothing tonight changed their state. ⚠ Anita Aga's seven
  commits are LWC, flexipage, layout and field metadata — **no Apex at all today**,
  so no new untested Apex was added. Recorded as an absence, not acted on.
- **The register's substance was not edited** — only `tracked_by`.
- **OI-212 was not fixed**, a tenth night. The correction is a code change and
  belongs to Aurel Mrruku.
- **`Opportunità_Zoho_CRM_` was not opened** — a Zoho export holding real customer
  records. Its id and size are recorded; its contents are not.
- **The 19/10 `Opportunity` thread's three inline images are still unopened** —
  second run. Elena Spini's picklist screenshot remains the one artefact that
  would settle [OI-265](../items/OI-265%20Opportunity%20Categoria%20and%20Sottocategoria%20values%20do%20not%20match%20the%20client%20registry.md).
  ⚠ **And a new one joins them**: the `image.png` on Elena Spini's 19:33:53
  `@channel` message (`F0CAT349FCH`, 51.0 KB).
- **`prettier:verify` was not run** (no `node_modules`); `vault:check` is
  dependency-free and was.
- **`OLD_DTT SHR Mappatura form handler campi.xlsx`** (`1gpBvxwmpcbEl2LlD_18tITWuw3UtX8d3`)
  was modified by Elena Spini at 16:43:18Z and **not opened**. ⚠ Its title does not
  name this project and no source links it to Pienissimo; **recorded as
  unclassified rather than ignored**, because the name is ambiguous.

## Still unreachable

🆕 whether Pienissimo hold a Zoho contract past 31 October · 🆕 ROMI's reply to the
go-live proposal (deferred to 21/10 morning) · 🆕 which four `Dettaglio Motivazione
Uscita` values OI-259 means · 🆕 what `differenziare le comunicazioni` contains
(OI-269) · 🆕 whether a contract-expiry alert rule exists in the org (OI-272) · 🆕
the Fase 2 draft by `Claudio` · 🆕 whether the 23/10 marketing support was confirmed
· 🆕 which production user is to be copied for the marketing tests · 🆕 what
_"utente metà bloccato"_ means for WhatsApp · 🆕 whether a test order created in
production reaches live Mexal · which picklist values are current for
Categoria/Sottocategoria · the `Genera PDF` exception text · whether Sabatino
Rinaldi's user exists · whether Elisa Migliano can log in on her own account · what
Fabrizio Mastracci's _"nuova change request"_ referred to · what the client's 15:00
meeting of 16/10 decided · the picklist workbook (11th run) · the 30/07 marketing
notes `1uJCE4NW9nbdI38ADmt66svUT1MRmkyYd24uI0hegAD0` · Zoom tier · training hours ·
who owns tutor training now · the Woo instance · DocuSign prod config ·
`Get Campaign` and the campaign-ID gap · Jira `PIEN` · `Flows & Objects.drawio` ·
the _diretta_ form.
