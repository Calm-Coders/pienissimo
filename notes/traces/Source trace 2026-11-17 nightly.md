---
id: trace-2026-11-17-nightly
type: reference
status: active
updated: 2026-11-17
watermark_used: 2026-11-16T22:00Z
external_watermark: 2026-11-17T22:00Z
account: a.mrruku@romicompany.com
---

# Source trace 2026-11-17 nightly

**Watermark for the next `requirements-check` run: 2026-11-17T22:00Z, single
value.**

**Watermark used: 2026-11-16T22:00Z**, the `external_watermark` stated by
[the 16/11 nightly trace](Source%20trace%202026-11-16%20nightly.md), selected by
`updated:` frontmatter. Scheduled nightly run, executed 2026-11-17 ~22:00Z.
**One day** — 17 November, the first full working day after go-live.

🔑 **The headline: the 18 November release was assembled on `DevMain` in a single
day — three merged pull requests, 52 files, six rows of the client change recap —
and the one change the client escalated, the quote PDF date format, is not in it.
The client itself said nothing at all, and a Fase 2 answer promised for today
lapsed.**

🟢 **Environment note.** The clone opened on **`main`** (two commits, config only)
with none of the knowledge layer in the working tree; `DevMain` did not exist
locally and `git checkout DevMain` failed until `git fetch --all` had run.
**Thirty-fifth run, same opening pattern.** Working tree **clean** at start,
`DevMain` at **`92899c3`**.

## Sources searched

| Source | Query / scope | Result |
| ------ | ------------- | ------ |
| **Gmail** | `pienissimo after:2026/11/16 -in:draft`, 50 requested | **5 threads**, **only 1 past the watermark**: the sandbox quote-acceptance mail of 17/11 15:29:41Z. The other four are the 16/11 material already held |
| **Gmail** | `after:2026/11/16 (pienissimo.com OR pienissimo.pro OR "ROMI-PIENISSIMO" OR kreosoft OR anticipay OR mexal OR docusign OR biglietto OR referenti OR salesforce)`, 50 requested | **31 threads**, **5 new and Pienissimo-relevant**, all Salesforce system mail: the sandbox site publishes, the production site publish, the sharing-defaults confirmation and the org-wide address verification. 🔴 **Nothing from Kreosoft, DocuSign or Anticipay** — not one alert, a second window |
| **Gmail** | `after:2026/11/16 (sabatino OR elisa OR montesi OR paganelli OR parmeggiani OR morgese OR merendi OR spini OR mastracci OR preventivo OR fattura OR woocommerce OR biglietti OR evento)`, 50 requested | **7 threads**, 🔴 **not one message from anyone at Pienissimo inside the window**. The rest are 247.it, Wi Legal, Life365, Permo, IUAD and a Salesforce PEM pitch — **excluded, other clients** |
| **Gmail** | `1a1e956d25cc2edd` (`Site Published Successfully`, 3 messages) | 🔑 **`Landing Page` published to PRODUCTION at 17/11 14:40:33Z**, _"Dear Tech Romi"_, `https://ability-customization-52152.my.site.com/`. The other two messages are 247.it `twentyfourseven` — excluded |
| **Gmail** | `1a1e9c6b9f0a5fdb` (`Sandbox: Site Published Successfully`, 7 messages) | 🔑 **Seven publishes of `Landing Page` to the partial sandbox between 13:51:16Z and 14:24:26Z**, all _"Dear Aurel Mrruku"_ |
| **Gmail** | `1a1ea20d1b0ce95e` (`Sandbox: Preventivo 00000322`) | 🆕 **Quote-acceptance request, 17/11 15:29:41Z**, quote `00000322` _"Preventivo - test 11/17 2"_, link to `…--partial.sandbox.my.site.com/gestione-preventivo`. **Second test of the day** by its own label |
| **Gmail** | `1a1e9c2642294521`, `1a1ea6283ba1b8f3` | ⚠ **Org-wide sharing defaults change completed 13:46:32Z** and **an organization-wide email address verification request 16:41:26Z**. **Neither names the org.** Read in full; not attributed to Pienissimo |
| **Gmail** | `1a1e5110ba2a0e58` (`API MEXAL`) | 🔴 **Still one message, still no reply** — Sabatino Rinaldi's request of 16/11 15:54:10Z → OI-368 |
| **Slack** | `slack_read_channel C0B5T3RB4FM` (`#tproj-pienissimo`), `oldest` 1794866400 | 🔴 **0 messages.** Nothing since Elena Spini's status post of 13/11 |
| **Slack** | `slack_read_channel C0BQD34LLF4` (ROMI dev group), same bound | **1 message — this session's own report of 16/11.** 🔴 **No human has ever answered a nightly report** |
| **Slack** | `slack_read_channel D0B5QHS2T7H` (Elena Spini DM), same bound | **0 messages.** She is on leave until 19/11 → OI-348 |
| **Slack** | `slack_read_channel C0C38JJ9D1T` (marketing group DM), same bound | **0 messages** |
| **Slack** | `slack_read_canvas F0BD2H5A9HT` (`Link utili Pienissimo`) | **Unchanged.** Newest entry still 20.08.2026 — **89 days**. Re-read per the skill |
| **Drive** | `modifiedTime > '2026-11-16T22:00:00Z' and trashed = false`, 40 files, `modifiedTime desc` | **10 files**, 🔑 **one Pienissimo**: `Manual Steps Pienissimo`, modified **17/11 10:46:26Z by Anita Aga**. The rest excluded — Salesforce PEM material, 247.it, a shared-drive price list, ROMI capacity and holiday sheets, and a VapeItalia folder |
| **Drive** | `(title contains 'Pienissimo') and createdTime > watermark` | **0 hits.** No new Pienissimo artifact created in the window |
| **Drive** | `read_file_content 1u-LgUKVlGK9ePyjMzZ_uJjXniHluo5_449siHgAIBHo` with comments | 🔑 **The manual-steps tracker, read in full: `A1:C8`, now seven rows.** Two new, both blank for production. No anchored comments → OI-373, OI-301 |
| **Drive** | `parentId = '1kjuqttnvEX688rAubYLdHhSjnyftTZff'`, 20 files | ⚠ Identified the `ZONE AGENTI` / `Organigramma e ruoli` folder as **VapeItalia / VISION** (`vapeit_magliv.sql`, `Vape r2.xlsx`, `catalog_product`, Davide Losco) — **excluded, other client.** Checked because the titles looked like Pienissimo agent zones |
| **Drive** | `read_file_content 1Ft6bWikOOt9WuZctxE_BddXdiKWCmQpuXfHVQ7nXyyA` | ROMI's `Piano ferie/assenze Natale 2026`, modified 17/11 13:33:34Z. **A 33-row grid covering 21/12 → 24/01, entirely empty.** ROMI-internal, no Pienissimo content, and it **does not cover 14 December**, so it does not answer OI-349. **No personal data copied** |
| **Fathom** | `list_meetings created_after 2026-11-16T22:00Z`, 3 pages, summaries on | 🔴 **0 meetings. Nothing at all, a thirty-eighth consecutive run** |
| **Git** | `fetch --all`, `checkout DevMain`, `pull`, `status`, `log --all --since`, `merge-base --is-ancestor`, `diff --stat`, `branch -r --contains` | 🔑 **Eleven commits in the window, three PRs merged into `DevMain`.** `DevMain` `18a106a` → `92899c3`, **52 files, +4,250 / -198**. Tree **clean** at start. Two commits unmerged on `DevAnita17` |
| **Repo** | `ls notes/items` max-id scan | Max existing id **372**. This run allocated **373**; **next free is 374** |
| **Repo** | `JOURNAL.md` head | Newest entry **16/11** (this session's own). **No developer journal entry for 17/11** despite eleven commits |

## Found

1. 🔑 **[The 18 November release was assembled in a day](../The%20Pienissimo%20recap%20of%20open%20changes.md)**
   — eleven commits, **PR #128** (`DevAnita16`, 10:15 CET), **PR #129**
   (`DevAnita_Modifications`, 15:37) and **PR #130** (`DevMain_ExperienceCloud`,
   15:58). **Six rows** of the client-facing change recap moved into source: rows
   2, 3, 5 and 6 done as asked and merged, row 7 built but unmerged on
   `DevAnita17`, row 8 merged.

2. 🟢 **Row 2 is correct, and it was verified rather than assumed.** `Altri
   Servizi` and `Generica` are still in the Lead and Opportunity `Categoria__c`
   value set but carry **`isActive: false`** — the right way to retire a value
   without orphaning records. `Cassa Zucchetti` kept, `Libro` added, plus `Corso`,
   `Pacchetti`, `Servizi Mktg`, `Piattaforma`, `Servizi Revenue`.

3. 🔴 **[The quote PDF date format is nowhere in the release](../items/OI-358%20The%20org%20is%20not%20set%20to%20Italian%20date%20and%20number%20formats.md)**
   — the 52-file delta carries **no Visualforce page, no PDF or email template, and
   no date-format change at all**. What landed is `Intl.NumberFormat("it-IT", EUR,
   2 decimals, grouping always)` in `quoteAcceptancePage` and `quoteManageProducts`,
   plus the Community site locale `en_US` → `it`. The client asked for the **date**
   by priority on 16/11 because it reaches Pienissimo's own customers, accepted
   _"facciamolo domani mattina"_ — today — and the release is **tomorrow**.

4. 🟢 **[The Mexal sync buttons are merged, a day before the promise](../items/OI-370%20The%20client%20cannot%20run%20the%20Mexal%20syncs%20by%20hand.md)**
   — `mexalSyncPanel` (169-line JS, 164-line CSS, **two Jest specs including an
   unauthorized-path test**) and `MexalSyncController.cls`. 🔑 The permission
   question appears answered in code rather than assumed, which is how the call left
   it. 🔴 Not deployed; the documentation and the mail of exact job times owed to
   Sabatino Rinaldi are both still missing. ⚠ 400 lines of new Apex, **no Apex
   test** — state only.

5. 🟢 **[Both halves of OI-364 are built](../items/OI-364%20Agents%20cannot%20see%20the%20home%20page%20or%20the%20calendar%20in%20production.md)**
   — the `Getting_Started_Home` flexipage (288 lines), `salesHomeTemplate`, three
   donut reports, and `standard-Event` set `DefaultOn` on the `Agente` profile with
   `standard-Event` and `standard-home` tab settings on the permission set. ⚠ Nobody
   specified the home page; ROMI chose its content, and the man who asked for it is
   leaving.

6. 🆕🔴 **[DocuSign is not configured in production for the order PDF](../items/OI-373%20DocuSign%20is%20not%20configured%20in%20production%20for%20the%20order%20PDF%20attachment.md)**
   — **OI-373**, a new row on the manual-steps tracker, `Done` in UAT and blank for
   Prod. 🔑 The **order** path, not the quote path: `DocuSignOrderEnvelopeService`
   and `DocuSignOrderEnvelopeQueueable` have been on `DevMain` since `54adb2e`
   (09/11), so **the send is written, the production configuration is unticked, and
   the return trigger is still unbuilt** (OI-322). The stage sale contract is due in
   production before Pienissimo Live, 24-26/11.

7. 🆕 **[The manual-steps tracker grew to seven rows](../Manual%20Steps%20Pienissimo%20tracker.md)**
   (Anita Aga, 10:46:26Z — the first edit not by its owner). The second new row is
   the **Lead Source Italian translation**, blank for Prod, whose metadata had
   merged **31 minutes earlier**; what remains to be clicked by hand is undefined.
   ⚠ **Row 3's scheduled-jobs cell is unchanged since 12/11** and was **not
   re-verified** after the 16/11 reschedule, leaving genuinely open whether the
   Mexal jobs run **as `amministratore pienissimo`**.

8. 🔴 **[Daniela Morgese's Fase 2 answer, expected today, did not come](../items/OI-342%20The%20Fase%202%20offer%20V2%20reorders%20the%20releases%20and%20contradicts%20itself.md)**
   — and nobody is chasing it. Elena Spini declined a written chaser on 13/11 and
   has been on leave since 16/11. 🔑 The date was **her own guess** (_"sparo
   martedi"_); Daniela Morgese never committed to it. Seven days after Andrea
   Galotto's mail of 10/11, ROMI is still building against an unapproved document.

9. 🔴 **The client was silent for the whole window** — no mail from anyone at
   Pienissimo, no `#tproj-pienissimo` message, no Drive change, no meeting, and
   nothing from Kreosoft, DocuSign or Anticipay. Still unanswered: the API MEXAL
   request (OI-368), Fabrizio Mastracci's go-ahead on the Pienissimo Live forms
   (OI-371), and any report of the deferred WooCommerce retest (OI-366).

10. 🟡 **Quote acceptance was retested in the partial sandbox** — seven site
    publishes 13:51:16Z→14:24:26Z and a quote-acceptance mail for `00000322`
    labelled _"test 11/17 2"_ at 15:29:41Z. ⚠ **And the same site was published to
    production at 14:40:33Z**, ten minutes before the Italian-locale commit
    (14:50:33Z) and eighteen before PR #130 merged (14:58:03Z). **What that publish
    contained is not established**; recorded as a timestamp, not a deployment.

## Not done, and why

- **The org was not opened.** Every production statement here comes from a mail, a
  Drive document, the source tree or the git history, **not from an inspection in
  this session**. `STATUS.md` and its Notion mirror are **stale**; the sweep moved
  the live position and step 6 of `org-status-check` was **not** run. ⚠ This matters
  for three findings in particular: whether the Mexal jobs run as the right user,
  what the production site publish contained, and whether the org locale has been
  changed.
- **No Apex test class was written or proposed.** Standing instruction.
  [OI-64](../items/OI-64%20The%20bundle%20Apex%20test%20suite%20is%20broken.md),
  [OI-66](../items/OI-66%20No%20test%20classes%20for%20the%20Biglietto%20stack.md) and
  [the deploy risk](../risks/Risk%20-%20production%20deploy%20is%20blocked%20by%20Apex%20coverage.md)
  are unchanged and were not acted on. ⚠ Noted as state only: `MexalSyncController.cls`
  (400 lines) is now **on `DevMain`** with no Apex test, and **none of the four
  DocuSign envelope classes has a test class** either.
- ⚠ **`Business_Blueprint_Pienissimo.docx` was not read**, a second window. It was
  touched on 16/11 at 11:42:37Z and did not change again today, so there is no new
  reason to open it — but what changed in it on the 16th remains unexamined, and the
  Opportunity derogation is written against it.
- ⚠ **Elena Spini's change workbook of Friday 13/11 was still not found** — not in
  Drive under a Pienissimo title, not in mail. It is due **Friday 20/11** and she
  returns on the 19th. Its items therefore cannot be counted against today's
  progress at all.
- **No customer-data workbook or attachment was opened.** None was offered in this
  window.
- **No euro figures transcribed.** The quote-acceptance test mail names a quote
  number only; no total is reproduced.
- **The two unattributed Salesforce confirmations were not chased.** The sharing-
  defaults change and the org-wide address verification name no org, and guessing
  which one they belong to would be fabrication.
- **OI-366, OI-368, OI-371, OI-336, OI-343, OI-344, OI-345, OI-346, OI-347,
  OI-349, OI-350, OI-351, OI-352, OI-353, OI-354, OI-355, OI-356, OI-357, OI-359,
  OI-361, OI-362, OI-363, OI-365, OI-367, OI-369, OI-372 were not updated** —
  **no new evidence in this window**. The only movement near them is that the 19/11
  marketing walkthrough and the 24-26/11 event are one day closer.
- **The requirement register was not touched** — stays **v1.6**. 🔑 Today's work is
  implementation of changes already recorded, not a change of requirement: the
  OI-344 mandatory picklists, the OI-329 tranche obligation, the OI-359 interruption
  case and the OI-358 locale change remain **v1.7 candidates**; none is agreed.
- **LIFE365, VISION / VapeItalia, VFL1, Permo, IUAD, 247.it, Wi Legal / SHR Italia,
  Daze and BE.MA were excluded** — other projects, per the skill.
- **`prettier:verify` was not run** (not executable in this environment, as on
  previous runs).

## Still unreachable

Named precisely enough to ask someone for them:

- 🆕 **Whether the quote PDF date format will be in tomorrow's release**, and who is
  doing it — nothing is staged in source and the client was promised it for today
  (OI-358).
- 🆕 **What the production `Landing Page` publish of 17/11 14:40:33Z contained**, and
  who ran it as `Tech Romi` ten minutes before the Italian-locale commit.
- 🆕 **Whether the three Mexal schedulers in production run as `amministratore
  pienissimo`** — the tracker row that asks for it has not been re-verified since
  12/11 (OI-301, OI-334).
- 🆕 **What "Configure DocuSign in Prod for the attachment of the pdf in orders"
  actually requires**, and who owns it (OI-373).
- 🆕 **Which org the sharing-defaults change of 13:46:32Z and the org-wide email
  address verification of 16:41:26Z belong to.**
- **Daniela Morgese's answer on Fase 2** — now overdue against ROMI's own expected
  date (OI-342); **who builds R1 by 14 December** (OI-349); **who covers Fase 1
  support** until the project manager returns on 19/11 (OI-348).
- **Elena Spini's change workbook of 13/11**, due Friday 20/11 — a second window.
- **Which articles the live WooCommerce shop sells**, set against those deactivated
  on 15/11, and whether the deferred retest ever passed (OI-366) — **no report in
  two windows**.
- **What changed in `Business_Blueprint_Pienissimo.docx` on 16/11**, and who changed
  it.
- **Whether ROMI accepts or contests the Blueprint claim** — **no reply in twelve
  days** (OI-343) — and `OP-1`, `OP-2`, `OP-4` of the R0 analysis, a fourteenth day.
- **Whether ROMI will send the Mexal integration material to a departing
  counterpart**, and whether Fabrizio Paganelli endorses the request (OI-368) —
  **second day, no reply**.
- **Who the client's System Admin is** for correcting a wrongly won Opportunity, and
  the runbook for doing it (OI-365).
- **Leaving dates and successors for Marco Montesi and Sabatino Rinaldi**, and who
  inherits the WooCommerce plugin configuration and the shop credentials ROMI does
  not hold (OI-357).
- **Fabrizio Mastracci's go-ahead on the Pienissimo Live forms**, and **which field
  they write for the marketing consent** (OI-371, OI-340 — **fifth window**).
- **The restore date for the event end dates**, with an owner, before 309 ready
  invitations either stay silent through Pienissimo Live or all send at once
  (OI-353).
- **The id-extraction date and format for Pienissimo Live attendance**, and the
  written specification Elisa Migliano asked for by mail (OI-361); **which event
  Andrea Parmeggiani's QR scanner will be ready for** (OI-323).
- **A list of the Aziende with more than one flagged principal contact** (OI-372).
- **Which cleanup option, A or B, for the 50,000 referenti leads**, the handling rule
  for rows whose Mexal code matches no Azienda — **100 against 107, unexplained** —
  and a written basis for the marketing consent set on all of them (OI-351).
- **A corrected mail to the client** replacing the 11/11 approval that describes fake
  values which will never exist (OI-352).
- **Whether `numero tranche` and `tipo biglietto` are now defined per article**, and
  the reply owed to Fabrizio Paganelli on the registry (OI-329).
- **The contract with the missing third signature**, circled, which the client agreed
  to send (OI-336).
- **Whether the ticket flow's `Recipient_Contact__r` query was ever fixed** —
  unmentioned for a fourth window (OI-230).
- **The written production user list by role**, the marketing and Performance Plus
  profiles, and the marketing mailbox confirmed against DNS (OI-356, OI-363) — the
  marketing walkthrough is **19/11 09:30**, in two days.
- **Whether the six tutors completed MFA/passkey enrolment**, and whether any tutor
  now has a production user (OI-300).
- **The exact boundaries of Mexal's nightly maintenance window**, from Kreosoft rather
  than from guesswork, and whether the client's own nightly procedures now collide
  with the 05:00 round (OI-334) — the mail of exact times is still unsent.
- **The picklist workbook** (OI-265, **twenty-fourth day**).
- **Whether Pienissimo holds a Zoho contract past 31 October** — **twenty-second
  run**, seventeen days after the expiry date.
- **The twelve `PLUS_B` values** (sixteenth day) · **what `lead-web-to-lead (2).html`
  is** (fifteenth day, Rexhina Hysi, never answered) · **whether the standing 30/07
  marketing follow-up notes exist at all**.
- **Who created fields and changed a layout in Prod without telling anyone** — raised
  by Aurel Mrruku in the ROMI DM on 13/11; nothing records what else changed.

## Written back

- **1 new item note**: **OI-373**. **Next free id 374.**
- **7 notes updated** (`updated:` bumped): OI-301, OI-342, OI-358, OI-364, OI-370,
  plus [the manual-steps tracker](../Manual%20Steps%20Pienissimo%20tracker.md),
  [the recap of open changes](../The%20Pienissimo%20recap%20of%20open%20changes.md)
  and [the lead source values](../The%20Pienissimo%20lead%20source%20values.md).
  **No status changes**; OI-370 stays `in-progress` because the work is merged, not
  deployed.
- **MAP.md** — new nightly entry at the top, `Last updated` chain extended.
- **INDEX.md** — 1 item row, 1 trace row, and the tracker and recap rows refreshed.
- **`meetings/open-items.md` and `.it.md`** — **1 new row each** (#373) and **5
  regenerated rows** each (#301, #342, #358, #364, #370).
- **`meetings/DEVELOPMENT-RECAP.md` and `.it.md`** — new **§83** in both.
- **This trace**, and a `JOURNAL.md` entry.
- **Register untouched — v1.6.**
- **No person note was needed.** No new person appeared; Anita Aga, Rexhina Hysi,
  Daniela Morgese, Sabatino Rinaldi and Fabrizio Paganelli are all already in
  `notes/people/`.
- **No credentials, prices, article codes or personal data were copied.** The ROMI
  holiday plan was read and **no name or absence was transcribed**; the DocuSign row
  was recorded without reading any connected-app or credential value.
