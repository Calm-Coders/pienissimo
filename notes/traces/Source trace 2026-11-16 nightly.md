---
id: trace-2026-11-16-nightly
type: reference
status: active
updated: 2026-11-16
watermark_used: 2026-11-12T22:00Z
external_watermark: 2026-11-16T22:00Z
account: a.mrruku@romicompany.com
---

# Source trace 2026-11-16 nightly

**Watermark for the next `requirements-check` run: 2026-11-16T22:00Z, single
value.**

**Watermark used: 2026-11-12T22:00Z**, the `external_watermark` stated by
[the 12/11 nightly trace](Source%20trace%202026-11-12%20nightly.md), selected by
`updated:` frontmatter. Scheduled nightly run, executed 2026-11-16 ~22:00Z.
**Four days** — 13, 14, 15 and 16 November, the go-live window.

🔑 **The headline: the users went live on 16 November, the Opportunity rule was
rewritten and released mid-flight on the client's urgent request, it cannot go
back, and on the first morning three things broke — the nightly Mexal syncs, lead
conversion, and the first real WooCommerce order.**

🟢 **Environment note.** The clone opened in **detached HEAD at
`refs/heads/main`** (two commits, config only) with none of the knowledge layer in
the working tree; `DevMain` did not exist locally and `git checkout DevMain` failed
until the fetch inside `git pull` had run. **Thirty-fourth run, same opening
pattern.** Working tree **clean** at start, `DevMain` at **`4478915`**
(_"changes"_, 16/11 14:22 CET).

## Sources searched

| Source | Query / scope | Result |
| ------ | ------------- | ------ |
| **Gmail** | `pienissimo after:2026/11/12 -in:draft`, 50 requested, 22 estimated | **22 threads**, **9 with movement inside the window**. All material ones read in full |
| **Gmail** | `after:2026/11/12 (from/to/cc:pienissimo.com OR pienissimo.pro OR "ROMI-PIENISSIMO" OR kreosoft OR anticipay OR mexal OR docusign OR biglietto OR referenti)`, 50 requested | **19 threads**, nothing new against the first set. 🔴 **Nothing from Kreosoft, DocuSign or Anticipay** — not one sandbox alert this window |
| **Gmail** | `after:2026/11/13 (sabatino OR elisa OR montesi OR paganelli OR parmeggiani OR morgese OR merendi OR pienissimo OR salesforce OR zoho OR woocommerce OR lead OR preventivo OR fattura)`, 50 requested | **38 threads**, **2 new and both Pienissimo** (the Apex exception and `API MEXAL`); the rest are 247.it, Wi Legal/SHR Italia, Permo, IUAD, VFL1, Vision, Daze and GitHub notices for `Vision-VapeItalia` — **excluded, other clients** |
| **Gmail** | `1a1d06456c06e4f8` (`File Import Ordini`, 7 messages) | 🔑 **The whole order delta and the migration recap**: Aurel Mrruku 13/11 15:15Z and **16:56Z**, Fabrizio Paganelli's answers in red at 16:12Z (_"lasciamo stare cosi. Non li carichiamo"_, _"si, confermato il 22/10/2026"_) and 🔑 **`PUNTO 5` at 16/11 09:01:12Z** — the client's written approval of the sync schedule → OI-334, OI-360, OI-370 |
| **Gmail** | `1a1e5110ba2a0e58` (`API MEXAL`) | 🆕🔴 **Sabatino Rinaldi, 16/11 15:54:10Z, asks for the Mexal integration APIs** _"per dei collegamenti interni"_ → OI-368. One message, no reply |
| **Gmail** | `1a1d55fdf926a7b5` (`Aggiornamento urgente per logiche Opportunity`) | 🔑 **The written derogation**, Elena Spini 13/11 14:46:20Z → [the decision](../decisions/Decision%20-%20the%20Opportunity%20is%20won%20at%20the%20first%20collected%20invoice.md), OI-365 |
| **Gmail** | `1a1e3a51e6483f23` (Salesforce alert) | 🆕🔴 **`LeadConversionTrigger` unhandled exception in Prod, 16/11 09:16:51Z**, `INSUFFICIENT_ACCESS_ON_CROSS_REFERENCE_ENTITY`, user `005SW00000R9lD3` → OI-337 |
| **Gmail** | `1a1d0abac99f5ad4` (`Anagrafica Articoli`, 6 messages) | 🔑 The registry frozen then released; Fabrizio Paganelli 13/11 07:47Z: _"ci sono da definire bene numero tranche e tipo biglietto"_ → OI-329. ⚠ `image001.png` not opened |
| **Gmail** | `1a1cf4f445a4aaf0` (`Referenti`, 5 messages) | The lead load reported to the client, incl. _"Consensi a vero 49.811"_ at 14:09Z → OI-351, OI-352. ⚠ **`Lead non importati.xlsx` not opened** — real customer records |
| **Gmail** | `1a1cf252e25e8584` (`Account`), `1a1d00c85ebdda02` (`LISTA LOCALI CON CODICE MEXAL`) | Aurel Mrruku's Aziende and Locali reports of 13/11, counts only. Already held from the 13/11 journal entries |
| **Gmail** | `1a1d61427cfcf505`, `1a1d50141e483d7f`, `1a1e3f00be213cc4`, `1a1d51ec7a6eb4cf` | Calendar invitations and Google Meet records for the two meetings of this window. 🆕 **`Ultimi Check PROD`, Mon 16/11 09:15-10:15**, created by Elena Spini 13/11 18:03Z |
| **Slack** | `slack_read_channel C0B5T3RB4FM` (`#tproj-pienissimo`), `oldest` 1794520800 | 🔑 **1 message, and it is dense**: Elena Spini's status post of 13/11 19:22:51 CET — go-live confirmed, the Opportunity logic, the Pienissimo Live ticket handling, the stage sale approval, Fase 2 unanswered, 12 gg to finish → OI-342, OI-343, OI-348, OI-361 |
| **Slack** | `slack_read_channel C0BQD34LLF4` (dev group), same bound | **1 message — this session's own report of 12/11.** 🔴 **No human has ever answered a nightly report** |
| **Slack** | `slack_read_channel D0B5QHS2T7H` (Elena Spini DM), same bound | **~40 messages, all 13/11.** 🔑 The WhatsApp paste that produced the urgent call · 🔴 _"Fabrizio nostro ha creato dei campi in prod e non mi sembra di aver avvisato"_ / _"ha cambiato layout e non ha avvisato"_ · 🔴 **_"ci vediamo il 19"_ — she is on leave** → OI-348 |
| **Slack** | `slack_read_channel C0C38JJ9D1T` (marketing group DM), same bound | **0 messages** |
| **Slack** | `slack_read_canvas F0BD2H5A9HT` (`Link utili Pienissimo`) | **Unchanged.** Newest entry still 20.08.2026 — **88 days**. Re-read per the skill |
| **Drive** | `modifiedTime > '2026-11-12T22:00:00Z' and trashed = false`, 40 files, `modifiedTime desc` | 🆕 **the two meeting folders and transcripts**, **`Modifiche flussi Sales`** (16/11 15:50:21Z), and ⚠ **`Business_Blueprint_Pienissimo.docx` touched 16/11 11:42:37Z**. The rest are other clients or ROMI-internal — BE.MA, VFL1, Vision, Permo, IUAD, 247.it, `[ROMI] Slide Team`, a shared-drive price list, the capacity sheet |
| **Drive** | `(title contains 'PIENISSIMO' or 'Pienissimo') and createdTime > watermark` | **6 hits**, all two meeting folders and their transcripts and shortcuts. No other new Pienissimo artifact |
| **Drive** | `read_file_content 1pm6CUX3MdQEIlw2q0WomDzw-kgblbtCTPTTItoNNmcA` | 🟢🔑 **The 13/11 Richiesta call urgente transcript, 23,318 bytes, read in full** → [the note](../meetings/2026-11-13%20Richiesta%20call%20urgente.md) |
| **Drive** | `read_file_content 1g9NO_P9ju0l-kGfgz_E3ZCJzqACuOapccmul-732FPQ` | 🟢🔑 **The 16/11 Ultimi Check PROD transcript, 93,900 chars (97,840 as fetched), read in full in five passes** → [the note](../meetings/2026-11-16%20Ultimi%20Check%20PROD.md) |
| **Drive** | `read_file_content 1y4DeVJEjd3g5vPo-LqYyczQbc0BRp9jVfVw9RJA7Yh8` with comments | 🟡 **`A1:E21`, 19 request rows; the `Lavorato` verdicts unchanged** (5 `SI`, 6 `IN LAVORAZIONE`, 2 `NON SI FA`, 6 blank). 🔑 **Column E now carries ROMI's disposition on six rows**, incl. _"grossa modifica strutturale"_. No anchored comments → OI-344 |
| **Drive** | `read_file_content 17EyzTOns9mB64-AjezgMnA8r4pM6flcxglGC032mhy0` | The ROMI weekly tech-planning of 16/11 — **a Salesforce Partner Ecosystem Management pitch, nothing about Pienissimo.** Read and excluded |
| **Fathom** | `list_meetings created_after 2026-11-12T22:00Z`, 3 pages, summaries on | 🔴 **0 meetings. Nothing at all, a thirty-seventh consecutive run** |
| **Git** | `fetch --all`, `checkout DevMain`, `pull`, `status`, `log --all --since`, `branch -r --contains` | `DevMain` at **`4478915`**, tree **clean**. **Eight commits in the window**, six on `DevMain`: `93f8468` (13/11, `Invio_Oggi__c` + `Richiesta_inviata__c` into source), `b4cbd8e`/`32a8b97` (_"Rilascio in prod"_), `bb3babc` (_"fields created in prod da fabrizio"_), `79f3b0c` (16/11, _"rischedulazione job in prod"_), `4478915`. 🔑 **Two on `DevAnita16` only**: `f2a3294` (home page + Mexal sync panel + `MexalSyncController.cls`) and `13b16da` (Italian `LeadSource` labels) |
| **Repo** | `ls notes/items` max-id scan | Max existing id **364**. This run allocated **365**-**372**; **next free is 373** |
| **Repo** | `JOURNAL.md` head | **Four entries in the window**: 13/11 ×3 (Vinta at first payment and WooCommerce not Incassato; all production Lead consent checkboxes true, codex; the Aziende/Locali/Referenti/Lead delta into Prod) and 16/11 ×1 (the Mexal resync and reschedule). **No nightly sweep since 12/11** |

## Found

1. 🔑 **[The Opportunity is won at the first collected invoice](../decisions/Decision%20-%20the%20Opportunity%20is%20won%20at%20the%20first%20collected%20invoice.md)**
   — asked by the client at 13:05 on 13/11 as urgent, agreed in a 27-minute call,
   built the same evening, put to the client in writing as _"in deroga a quanto
   previsto nel Blueprint"_, and **proved end to end in production on 16/11**.
   The client opened with _"nostra culpa … tra di noi non ci siamo capiti."_

2. 🆕🔴 **[It cannot go back](../items/OI-365%20The%20Opportunity%20cannot%20return%20from%20Vinta%20once%20a%20payment%20is%20reversed.md)**
   — the reverse-payment case is the client's own, quoted second-hand while its
   author was absent; a manual rollback is unrecoverable because later payments do
   not re-fire the rule; and **the editing lock on a won Opportunity's chain was
   relaxed to allow the change at all.** No admin runbook.

3. 🆕🔴 **[Most products are inactive, so WooCommerce orders fail the product code
   match](../items/OI-366%20Most%20Salesforce%20products%20are%20inactive%20so%20WooCommerce%20orders%20fail%20the%20product%20code%20match.md)**
   — the plugin flag had **never been switched on**, was switched on live, and the
   first real order died. Cause: the client's own Sunday article cleanup. **The
   shop is live** and the retest never happened.

4. 🔴 **[Lead conversion threw again at 09:16:51Z](../items/OI-337%20Lead%20conversion%20throws%20in%20production%20when%20the%20Opportunity%20fields%20are%20inaccessible.md)**,
   a broader error than on 5/11, because a named user was converting leads before
   anyone had told the team how to work — _"non sappiamo come muoverci."_

5. 🔑 **[Mexal is unreachable in the small hours by its own
   design](../The%20Mexal%20sync%20window%20and%20the%20year%20boundary.md)** — the cause
   of the first night's 500s, supplied by the client, never confirmed with
   Kreosoft. The reschedule was then agreed in the room and **approved by the
   client in writing** (OI-334) — ⚠ except the 14:00 round he asked for, which
   does not exist.

6. 🟢 **The migration is done** and every open end of the order load closed
   ([OI-360](../items/OI-360%20Cancelled%20Mexal%20orders%20must%20be%20deleted%20from%20production.md)
   **resolved**): 63 orders in, 32 deleted, 10,969 invoices, 19,574 tickets and
   **no ticket mail sent**. 🔑 **[The Mexal order numerator is
   settled](../items/OI-310%20The%20production%20load%20needs%20a%20pre-load%20and%20a%20delta%20run.md)**
   — Salesforce orders start at **80,000**, set by Mirko Merendi on 13/11.

7. 🔑 **[The fake company and VAT values were never
   used](../items/OI-352%20Referenti%20leads%20were%20loaded%20with%20a%20placeholder%20company%20and%20no%20VAT%20value.md)**
   — `Partita IVA` is not mandatory on Lead. The note is **retitled**, because its
   old title asserted something false. 🔴 **The marketing consent on 49,811 leads
   was settled in two lines of a call** and reported as a figure, with no written
   basis (OI-351).

8. 🆕🔴 **[Four Product2 picklists were typed into Production
   Setup](../items/OI-367%20Picklist%20values%20and%20a%20dependency%20were%20created%20directly%20in%20production.md)**
   during the call, one of which had **no values at all**, with a dependency
   rebuilt by hand and the slash in `2026/27` suspected and never ruled out.

9. 🆕🔴 **[New business is still being keyed into
   Zoho](../items/OI-371%20Opportunities%20are%20re-keyed%20from%20Zoho%20while%20the%20web%20forms%20wait%20for%20ROMI.md)**
   — the commercial team was told to re-enter its Zoho opportunities by hand, and
   the Pienissimo Live registration forms are built, tested and waiting on one
   word from Fabrizio Mastracci, eight days before the event.

10. 🟢 **[The stage sale contract analysis is
    approved](../items/OI-343%20The%20client%20disputes%20that%20the%20stage%20sale%20contract%20was%20outside%20the%20Fase%201%20Blueprint.md)**
    and is the first Fase 2 release, due in production **before Pienissimo Live
    (24-26/11)** — 🔴 **while Fase 2 itself was not approved on 13/11**, now
    resting with [Daniela Morgese](../people/Daniela%20Morgese%20-%20Pienissimo%20direction.md)
    and promised _"entro martedi"_ 17/11 (OI-342).

11. 🔴 **[The project manager is on leave 16-18
    November](../items/OI-348%20Fase%201%20post%20go-live%20support%20is%20unassigned%20and%20unpriced.md)**
    — _"ci vediamo il 19"_ — and was absent from the go-live call. For the first
    three days of real use the only ROMI presence is the developer.

12. 🆕 **Three smaller things the go-live call surfaced**:
    [the Mexal integration APIs asked for by mail](../items/OI-368%20The%20client%20asked%20for%20the%20Mexal%20integration%20APIs%20by%20mail.md)
    by the departing counterpart ·
    [DocuSign's registration prompt, accepted with no mitigation](../items/OI-369%20DocuSign%20asks%20signers%20to%20register%20and%20the%20client%20expects%20to%20lose%20them.md)
    · [the client has no way to run a sync by hand](../items/OI-370%20The%20client%20cannot%20run%20the%20Mexal%20syncs%20by%20hand.md),
    promised as buttons by 18/11 ·
    [several principal contacts per Azienda collapsed to the last](../items/OI-372%20Several%20principal%20contacts%20per%20Azienda%20were%20collapsed%20to%20the%20last%20one.md).
    🔑 **[The missing third contract signature](../items/OI-336%20The%20quote%20PDF%20allegato%20B%20has%20no%20signature%20field.md)**
    was raised again and ROMI has no record of it.

## Not done, and why

- **The org was not opened.** Every production statement here comes from a mail, a
  Slack message, a transcript, a Drive document, the source tree or an earlier
  journal entry, **not from an inspection in this session**. `STATUS.md` and its
  Notion mirror are **stale**; the sweep moved the live position and step 6 of
  `org-status-check` was **not** run. ⚠ This matters this week: the users are
  live, the WooCommerce catalogue is mismatched and nothing here verifies either.
- **No Apex test class was written or proposed.** Standing instruction.
  [OI-64](../items/OI-64%20The%20bundle%20Apex%20test%20suite%20is%20broken.md),
  [OI-66](../items/OI-66%20No%20test%20classes%20for%20the%20Biglietto%20stack.md) and
  [the deploy risk](../risks/Risk%20-%20production%20deploy%20is%20blocked%20by%20Apex%20coverage.md)
  are unchanged and were not acted on. ⚠ Noted as state only: `MexalSyncController.cls`
  on `DevAnita16` is ~400 lines of new Apex **with no Apex test**; the LWC there
  ships two Jest specs.
- ⚠ **`Business_Blueprint_Pienissimo.docx` was touched on 16/11 at 11:42:37Z by
  Elena Spini and was not read** (≈830 KB docx). It is the contractually relevant
  document, the Opportunity change is described as a derogation from it, and
  [OI-343](../items/OI-343%20The%20client%20disputes%20that%20the%20stage%20sale%20contract%20was%20outside%20the%20Fase%201%20Blueprint.md)
  disputes what it covers. **What changed in it is unexamined.**
- ⚠ **Elena Spini's change workbook of Friday 13/11 was not found.** Named on the
  16/11 call as _"un bel Excel"_ with items from the tutor tests, due Friday 20/11.
  Not in Drive under a Pienissimo title and not in mail in this window.
- **No customer-data workbook or attachment was opened**: `Lead non importati.xlsx`,
  `Ordini non caricati.xlsx`, `Import Ordini (versione del 2026.11.12).xlsx`. Their
  existence and counts are recorded; **no values are copied.**
- **No screenshot or image attachment was opened**, including `image001.png` on the
  `Anagrafica Articoli` thread.
- **No euro figures transcribed.** The 16/11 call read quote and invoice totals
  aloud repeatedly and the 13/11 call named a monthly Performance Plus figure;
  none is reproduced.
- **Personal data in the test order not copied.** Sabatino Rinaldi placed the
  WooCommerce test order under Fabrizio Paganelli's name with his own home address
  and mobile; recorded as existing only.
- **No `[ROMI-PIENISSIMO]` afternoon follow-up was found** for the WooCommerce
  retest deferred to _"dopo le 3"_ on 16/11.
- **OI-363, OI-345, OI-346, OI-347, OI-349, OI-350, OI-359, OI-362 were not
  updated** — **no new evidence in this window**. The only movement near them is
  that the 19/11 marketing walkthrough and the 24-26/11 event are closer.
- **The requirement register was not touched** — stays **v1.6**. 🔑 The 13/11
  Opportunity change was already carried into the YAML, `REQUIREMENTS.md` and
  `REQUISITI.it.md` by the 13/11 session (DM-06 and the state table); this run adds
  the written derogation, the lock relaxation and the one-way consequence as notes,
  not as register changes. The OI-344 mandatory picklists, the OI-329 tranche
  obligation, the OI-359 interruption case and the OI-358 locale change remain
  **v1.7 candidates**; none is agreed.
- **LIFE365, VISION, VFL1, Permo, IUAD, 247.it, Wi Legal / SHR Italia, Daze and
  BE.MA were excluded** — other projects, per the skill.
- **`prettier:verify` was not run** (not executable in this environment, as on
  previous runs).

## Still unreachable

Named precisely enough to ask someone for them:

- **Which articles the live WooCommerce shop sells**, set against the articles
  Fabrizio Paganelli deactivated on 15/11, and whether the deferred afternoon
  retest passed (OI-366).
- **What changed in `Business_Blueprint_Pienissimo.docx` on 16/11**, and who
  changed it.
- **Elena Spini's change workbook of 13/11**, due Friday 20/11.
- **Whether ROMI accepts or contests the Blueprint claim** — **no reply in eleven
  days** (OI-343) — and `OP-1`, `OP-2`, `OP-4` of the R0 analysis, a thirteenth day.
- **Daniela Morgese's answer on Fase 2**, promised for 17/11 (OI-342); **who builds
  R1 by 14 December** (OI-349); **who covers Fase 1 support** while the project
  manager is away (OI-348).
- **Who the client's System Admin is** for correcting a wrongly won Opportunity,
  and the runbook for doing it (OI-365).
- **Whether ROMI will send the Mexal integration material to a departing
  counterpart**, and whether Fabrizio Paganelli endorses the request (OI-368).
- **Leaving dates and successors for Marco Montesi and Sabatino Rinaldi**, and who
  inherits the WooCommerce plugin configuration and the shop credentials ROMI does
  not hold (OI-357).
- **Fabrizio Mastracci's go-ahead on the Pienissimo Live forms**, and **which field
  they write for the marketing consent** (OI-371, OI-340 — fourth window).
- **The restore date for the event end dates**, with an owner, before 309 ready
  invitations either stay silent through Pienissimo Live or all send at once
  (OI-353).
- **The id-extraction date and format for Pienissimo Live attendance**, and the
  written specification Elisa Migliano asked for by mail (OI-361); **which event
  Andrea Parmeggiani's QR scanner will be ready for** (OI-323).
- **A list of the Aziende with more than one flagged principal contact** (OI-372).
- **Which cleanup option, A or B, for the 50,000 referenti leads**, the handling
  rule for the rows whose Mexal code matches no Azienda — **100 on 16/11 against
  107 in the earlier record, unexplained** — and a written basis for the marketing
  consent set on all of them (OI-351).
- **A corrected mail to the client** replacing the 11/11 approval that describes
  fake values which will never exist (OI-352).
- **Whether `numero tranche` and `tipo biglietto` are now defined per article**,
  and the reply owed to Fabrizio Paganelli on the registry (OI-329).
- **The contract with the missing third signature**, circled, which the client
  agreed to send (OI-336).
- **Whether the ticket flow's `Recipient_Contact__r` query was ever fixed** —
  unmentioned for a third window (OI-230).
- **The written production user list by role**, the marketing and Performance Plus
  profiles, and the marketing mailbox confirmed against DNS (OI-356, OI-363) —
  with the marketing walkthrough on **19/11 09:30**.
- **Whether the six tutors completed MFA/passkey enrolment**, and whether any tutor
  now has a production user (OI-300).
- **The exact boundaries of Mexal's nightly maintenance window**, from Kreosoft
  rather than from guesswork, and whether the client's own nightly procedures now
  collide with the 05:00 round (OI-334).
- **The picklist workbook** (OI-265, **twenty-third day**), which would have
  prevented OI-367.
- **Whether Pienissimo holds a Zoho contract past 31 October** — **twenty-first
  run**, sixteen days after the expiry date, while new business is still being
  entered in Zoho.
- **The twelve `PLUS_B` values** (fifteenth day) · **what
  `lead-web-to-lead (2).html` is** (fourteenth day, Rexhina Hysi, never answered) ·
  **whether the standing 30/07 marketing follow-up notes exist at all**.
- 🆕 **Who created fields and changed a layout in Prod without telling anyone** —
  Aurel Mrruku in the ROMI DM, 13/11: _"Fabrizio nostro ha creato dei campi in prod
  e non mi sembra di aver avvisato da nessuna parte"_ · _"ha cambiato layout e non
  ha avvisato"_. Commit `bb3babc` brings some of it into source; nothing records
  what else changed.

## Written back

- **2 meeting notes**: the 13/11 Richiesta call urgente, the 16/11 Ultimi Check
  PROD.
- **8 new item notes**: OI-365 → OI-372. **Next free id 373.**
- **1 new decision note**
  ([the Opportunity is won at the first collected invoice](../decisions/Decision%20-%20the%20Opportunity%20is%20won%20at%20the%20first%20collected%20invoice.md))
  and **1 new reference note**
  ([the Mexal sync window and the year boundary](../The%20Mexal%20sync%20window%20and%20the%20year%20boundary.md)).
- **27 notes updated** (`updated:` bumped): OI-69, OI-310, OI-315, OI-327, OI-329,
  OI-334, OI-336, OI-337, OI-338, OI-340, OI-342, OI-343, OI-344, OI-348, OI-351,
  OI-352, OI-353, OI-354, OI-355, OI-357, OI-358, OI-360, OI-361, OI-364, plus
  [the recap of open changes](../The%20Pienissimo%20recap%20of%20open%20changes.md),
  [the lead source values](../The%20Pienissimo%20lead%20source%20values.md),
  [the build ahead of the record](../objects/The%20build%20ahead%20of%20the%20record.md),
  [the stage sale functional analysis](../The%20stage%20sale%20contract%20functional%20analysis.md)
  and [the R0 decision](../decisions/Decision%20-%20stage%20sale%20contracts%20are%20release%20R0%20of%20Fase%202.md).
  **Status changes: OI-338, OI-355 and OI-360 → `resolved`.**
- 🔑 **OI-352 was renamed** from _"The fifty thousand referenti leads are loaded
  with fake company and VAT values"_ to _"Referenti leads were loaded with a
  placeholder company and no VAT value"_, because the old title asserted something
  that never happened. The `id` is unchanged, six inbound links were repointed, and
  both tracker rows were retitled.
- **MAP.md** — new nightly entry at the top, `Last updated` chain extended.
- **INDEX.md** — 8 item rows, 2 meeting rows, 1 decision row, 1 reference row,
  1 trace row, and the OI-352 row relabelled.
- **`meetings/open-items.md` and `.it.md`** — **8 new rows each** (#365-#372) and
  **24 regenerated rows** each (#69, #310, #315, #327, #329, #334, #336, #337,
  #338, #340, #342, #343, #344, #348, #351, #352, #353, #354, #355, #357, #358,
  #360, #361, #364).
- **`meetings/DEVELOPMENT-RECAP.md` and `.it.md`** — new **§82** in both.
- **This trace**, and a `JOURNAL.md` entry.
- **Register untouched — v1.6.**
- **No person note was needed**: Marco Montesi, Sabatino Rinaldi, Elisa Migliano,
  Fabrizio Paganelli, Fabrizio Mastracci, Daniela Morgese, Matteo Distaso, Anita
  Aga and Mirko Merendi are all already in `notes/people/`. ⚠ Marco Montesi's and
  Sabatino Rinaldi's notes should be revisited when their leaving dates are known.
