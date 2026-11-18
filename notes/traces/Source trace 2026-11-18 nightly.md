---
id: trace-2026-11-18-nightly
type: reference
status: active
updated: 2026-11-18
watermark_used: 2026-11-17T22:00Z
external_watermark: 2026-11-18T22:00Z
account: a.mrruku@romicompany.com
---

# Source trace 2026-11-18 nightly

**Watermark for the next `requirements-check` run: 2026-11-18T22:00Z, single
value.**

**Watermark used: 2026-11-17T22:00Z**, the `external_watermark` stated by
[the 17/11 nightly trace](Source%20trace%202026-11-17%20nightly.md), selected by
`updated:` frontmatter. Scheduled nightly run, executed 2026-11-18 ~22:00Z.
**One day** — 18 November, the release day.

🔑 **The headline: the release went to production and Pienissimo got the first
written release note of this project — and that note tells the client two things
the delta cannot show. The order DocuSign configuration row is still blank
fourteen minutes after the mail went out, and nothing in sixty deployed files
changes a date format.**

🟢 **Environment note.** The clone opened on **`main`** (two commits, config only)
with none of the knowledge layer in the working tree; `DevMain` did not exist
locally and `git checkout DevMain` failed until `git fetch` had run. **Thirty-sixth
run, same opening pattern.** Working tree **clean** at start, `DevMain` at
**`1a46bf2`**.

## Sources searched

| Source | Query / scope | Result |
| ------ | ------------- | ------ |
| **Gmail** | `pienissimo after:2026/11/17 -in:draft`, 50 requested | **2 threads**, **1 past the watermark**: 🔑 the **`Rilascio 18/11/2026`** release mail of 14:40:26Z. The other is the 17/11 sandbox quote-acceptance mail already held |
| **Gmail** | `after:2026/11/17 (pienissimo.com OR pienissimo.pro OR "ROMI-PIENISSIMO" OR kreosoft OR anticipay OR mexal OR docusign OR biglietto OR referenti OR salesforce)`, 50 requested | **26 threads**, **1 new and Pienissimo-relevant** — the same release mail. 🔴 **Nothing from Kreosoft, DocuSign or Anticipay** — a third window. The rest excluded: VFL1, 247.it (sharing-rule recalculations, a `Reception Calendar` site publish, a Brand Report guide), Wi Legal / SHR Italia, Daze, Jira VISION/VapeItalia, Life365, Salesforce newsletters and partner mail |
| **Gmail** | `after:2026/11/17 (sabatino OR elisa OR montesi OR paganelli OR parmeggiani OR morgese OR merendi OR mastracci OR spini OR preventivo OR fattura OR woocommerce OR biglietti OR evento OR contratto OR ordine)`, 50 requested | **9 threads**, 🔴 **not one message from anyone at Pienissimo**. The only new Pienissimo-side item is **Elena Spini's out-of-office auto-reply** to the release mail |
| **Gmail** | `1a1ef1149876f603` (`Rilascio 18/11/2026`) | 🔑 **Read in full.** 14:40:26Z, Aurel Mrruku → `amministrazione@pienissimo.com`, Fabrizio Paganelli, Sabatino Rinaldi, with Elena Spini. One inline `image.png`, **not opened**. Headline: the WooCommerce order contract CR with the DocuSign send, plus six listed improvements → **OI-374** |
| **Gmail** | `1a1ef1a4e3631d44` (auto-reply) | ⚠ Elena Spini, 14:40:40Z — _"Sarò in ferie fino al 18/11 compreso … a partire dal 19/11"_. Confirms OI-348's dates; the client-facing claim was not reviewed by her |
| **Slack** | `slack_read_channel C0B5T3RB4FM` (`#tproj-pienissimo`), `oldest` 1794952800 | 🔴 **0 messages.** Nothing since Elena Spini's status post of 13/11 — **six days** |
| **Slack** | `slack_read_channel C0BQD34LLF4` (ROMI dev group), same bound | **1 message — this session's own report of 17/11.** 🔴 **No human has ever answered a nightly report** |
| **Slack** | `slack_read_channel D0B5QHS2T7H` (Elena Spini DM), same bound | 🔑 **4 messages, 10:07:05 → 10:38:22 CET.** She is flying home; Aurel Mrruku gives the only account of the client's silence there is |
| **Slack** | `slack_read_channel C0C38JJ9D1T` (marketing group DM), same bound | **0 messages** |
| **Slack** | `slack_read_canvas F0BD2H5A9HT` (`Link utili Pienissimo`) | **Unchanged.** Newest entry still 20.08.2026 — **90 days**. Re-read per the skill |
| **Drive** | `modifiedTime > '2026-11-17T22:00:00Z' and trashed = false`, 40 files, `modifiedTime desc` | **14 files**, 🔑 **three Pienissimo**: the manual-steps tracker (14:54:08Z, Anita Aga), the change-recap workbook (10:37:52Z, Anita Aga) and the **Fase 2 offer V.4** (11:42:03Z, Andrea Galotto). The rest excluded — VFL1, Daze, VISION/Mulesoft, 247.it, ROMI slides, a shared-drive price list |
| **Drive** | `(title contains 'Pienissimo' or 'Fase 2' or 'Blueprint') and modifiedTime > watermark` | **3 hits**, the same three files. **No new Pienissimo artifact created in the window** |
| **Drive** | `read_file_content 1u-LgUKVlGK9ePyjMzZ_uJjXniHluo5_449siHgAIBHo` with comments | 🔑 **The manual-steps tracker, read in full: `A1:C8`, still seven rows.** Row 7 moved to `done`; **row 6, DocuSign for orders, still blank**. No anchored comments → OI-301, OI-373, OI-374 |
| **Drive** | `read_file_content 1D2hnr7PAysXpPR-37P6pw44dcgF7sbiV` | 🔑 **The change recap, read in full: seven rows now `Già fatto`**, only the status column changed → the recap note, OI-358 |
| **Drive** | `read_file_content 1nE19jesbBpP2JXdnDOZfAnB--fhaEKMCMrgf9RxkWbY` | 🟡 **Fase 2 offer V.4, read in full.** Unchanged on every element the record holds. **No figures transcribed** → OI-342 |
| **Drive** | `list_file_revisions` on V.4 | ⚠ **One head revision only**, etag matching the 18/11 save. **What changed cannot be established** |
| **Fathom** | `list_meetings created_after 2026-11-17T22:00Z`, 3 pages, summaries on | 🔴 **0 meetings. Nothing at all, a thirty-ninth consecutive run** |
| **Git** | `fetch --all`, `checkout DevMain`, `pull`, `log --all --since`, `show --stat`, `diff --name-only`, `merge-base --is-ancestor` | 🔑 **Three commits in the window, one PR merged.** `DevMain` `92899c3` → **`1a46bf2`**. Tree **clean** at start |
| **Repo** | `JOURNAL.md` head | 🔑 **A developer entry for 18/11 exists** (`claude-opus-5-5`, written with Aurel Mrruku), 77 lines, and is the source for the deployment facts below |
| **Repo** | `ls notes/items` max-id scan | Max existing id **374** after this run; **next free is 375** |

## Found

1. 🔑🟢 **[The whole `DevMain` delta is in production](../The%20Pienissimo%20recap%20of%20open%20changes.md)**
   — `4478915..4d18d57`, 60 `force-app` files, in three quick deploys:
   **`0AfSW000001Malp0AC`** (13:43:49Z, 33 non-Apex components),
   **`0AfSW000001Map30AC`** (13:45:39Z, a permission-set restore) and
   **`0AfSW000001MbQ90AK`** (14:23:28Z, the Mexal home-page bundle). The only
   exclusions are the standing two: the `Agente` profile and the community locale,
   which Prod already carries as `it`. Each deploy was verified by re-retrieval.

2. 🟢 **PR #131 merged `DevAnita17`** at 14:25:29 CET — `654618c`, `86682d0`,
   `a9f92f3` — so the Asset `Ordine__c` field and the Italian price formats that
   were stranded yesterday are on `DevMain`. `92899c3` → `1a46bf2`.

3. 🆕🔴 **[The client was told the order contract flow is live](../items/OI-374%20The%2018%20November%20release%20mail%20tells%20the%20client%20the%20order%20contract%20flow%20is%20live.md)**
   — **OI-374**. The release mail's headline is the WooCommerce order contract with
   the DocuSign send. 🔴 The manual-steps row for that configuration was edited
   **fourteen minutes later** and is **still blank**; 🔴 the order **return** path
   has never been built (OI-322); 🔑 the code went to Prod on **12/11 at 16:19Z**
   and **no smoke test on a real order has ever been recorded**. ⚠ A blank cell is
   not proof, and the mail's author is the person who would have done the work.

4. 🔴 **[The date format is declared done with nothing in the delta to show for it](../items/OI-358%20The%20org%20is%20not%20set%20to%20Italian%20date%20and%20number%20formats.md)**
   — recap row 1 moved to `Già fatto` at 10:37:52Z and the mail lists _"Formato
   date: aggiornato al formato italiano"_. The 60-file delta has **no Visualforce
   page, no PDF or email template and no date-format edit of any kind**. 🔑 Only the
   **org-level Locale** can make the claim true; it is not metadata and ⚠ **the org
   was not opened**.

5. 🟢 **[The Mexal sync panel is live, a day's promise kept](../items/OI-370%20The%20client%20cannot%20run%20the%20Mexal%20syncs%20by%20hand.md)**
   — held back first by coverage (74.55%, **65 lines short**, `MexalSyncController`
   211 lines at 0%), then released after a test class was written **on Aurel
   Mrruku's explicit request**: 11 tests, 11/11 in UAT, controller at 92%, org to
   **76.36%**. ⚠ Recorded as state; the developer updated
   [the deploy risk](../risks/Risk%20-%20production%20deploy%20is%20blocked%20by%20Apex%20coverage.md)
   himself in `1a46bf2`. 🔴 The documentation and the job-times mail to Sabatino
   Rinaldi are **still owed, a second day**.

6. 🔴🟢 **[A two-minute production regression, caused and fixed](../items/OI-364%20Agents%20cannot%20see%20the%20home%20page%20or%20the%20calendar%20in%20production.md)**
   — the branch's `Agente` permission set revoked **15 Event/Task field grants and
   the Event tab** because omitted permission-set entries do not survive a deploy.
   Restored at 13:45:39Z and verified by SOQL; source has since been aligned to
   Prod. Both halves of OI-364 are now live.

7. 🟢 **[Seven of the twelve change-recap rows read `Già fatto`](../The%20Pienissimo%20recap%20of%20open%20changes.md)**
   (Anita Aga, 10:37:52Z) and
   **[the Lead Source row closes on the manual-steps tracker](../Manual%20Steps%20Pienissimo%20tracker.md)**
   (14:54:08Z) — **five of seven production cells filled**, the most that sheet has
   ever shown. ⚠ Only the status column moved in the recap; every note and date is
   as it was on 12/11.

8. 🟡 **Row 3 of the tracker is narrowed, not answered** — the cell is unchanged a
   third reading, but the deployment session verified in Prod that the six Mexal
   jobs and `Quote Negotiation Aging - Daily` are `WAITING` and unchanged. So the
   jobs exist; **whose identity they run as** is still unestablished → OI-301.

9. 🟡 **[The Fase 2 deck was reopened and the client still has not answered](../items/OI-342%20The%20Fase%202%20offer%20V2%20reorders%20the%20releases%20and%20contradicts%20itself.md)**
   — V.4 saved by Andrea Galotto at 11:42:03Z, nine days after its last edit. Drive
   keeps **one revision**, so what changed cannot be established; the deck read in
   full today is unchanged on every recorded element. **Day eight** since Andrea
   Galotto's mail of 10/11.

10. 🔑 **The only account of the client's silence is ROMI's own.** Aurel Mrruku to
    Elena Spini in the ROMI DM, 10:38:22 CET: _"si Lunedì abbiamo fatto dei test in
    prod ed è andato tutto bene. poi e arrivato **la loro direzione in ufficio** e
    non si sono più fatti sentire."_ ⚠ _"la loro direzione"_ is not named and
    nothing connects it to Daniela Morgese. Recorded as said, not as evidence.

## Not done, and why

- **The org was not opened.** Every production statement here comes from the
  developer's own journal entry of 18/11, from mail, from Drive or from the git
  history — **not from an inspection in this session**. `STATUS.md` and its Notion
  mirror are **stale**; the sweep moved the live position and step 6 of
  `org-status-check` was **not** run. ⚠ This matters for three findings: whether the
  org locale was changed, whether DocuSign is configured in Prod for orders, and
  which user the Mexal schedulers run as.
- **No Apex test class was written or proposed in this session.** Standing
  instruction. 🔑 ⚠ **`MexalSyncControllerTest` (398 lines) was written by the
  developer's own session, on Aurel Mrruku's explicit request**, and is recorded
  here as state only; it is not this run's work and was not acted on.
  [OI-64](../items/OI-64%20The%20bundle%20Apex%20test%20suite%20is%20broken.md) and
  [OI-66](../items/OI-66%20No%20test%20classes%20for%20the%20Biglietto%20stack.md) are
  unchanged; the four DocuSign envelope classes still have no test class.
  [The deploy risk](../risks/Risk%20-%20production%20deploy%20is%20blocked%20by%20Apex%20coverage.md)
  was updated by the developer in `1a46bf2` and needed no change here.
- ⚠ **`Business_Blueprint_Pienissimo.docx` was not read**, a third window. It did
  not change today, so there is no new reason to open it — but what changed in it on
  16/11 remains unexamined.
- ⚠ **Elena Spini's change workbook of Friday 13/11 was still not found** — not in
  Drive under any Pienissimo title, not in mail, a **third** window. It is due
  **Friday 20/11** and she returns on the 19th.
- **The release mail's inline `image.png` was not opened.** It is a screenshot of
  the sync component by position in the text; nothing rests on it.
- **No customer-data workbook or attachment was opened.** None was offered.
- **No euro figures transcribed.** The Fase 2 deck carries per-release amounts, a
  total and payment terms; **none is reproduced**, per the standing rule and the
  precedent in the record.
- **OI-336, OI-343 to OI-357, OI-359 to OI-363, OI-365 to OI-369, OI-371, OI-372
  were not updated** — **no new evidence in this window**. The 19/11 marketing
  walkthrough is tomorrow and Pienissimo Live is six days away.
- **The requirement register was not touched** — stays **v1.6**. Today's work is
  deployment of changes already recorded, not a change of requirement. The OI-344
  mandatory picklists, the OI-329 tranche obligation, the OI-359 interruption case
  and the OI-358 locale change remain **v1.7 candidates**; none is agreed.
- **LIFE365, VISION / VapeItalia, VFL1, Permo, IUAD, 247.it, Wi Legal / SHR Italia,
  Daze and BE.MA were excluded** — other projects, per the skill.
- **`prettier:verify` was not run** (not executable in this environment, as on
  previous runs).

## Still unreachable

Named precisely enough to ask someone for them:

- 🆕 **Whether DocuSign is actually configured in production for the order PDF
  attachment**, with a date and a name — the client has been told it is (OI-374,
  OI-373).
- 🆕 **Whether any real WooCommerce order has ever been taken end to end in
  production** — order confirmed in Mexal, contract generated, envelope sent,
  document signed. No record of one exists, six days before Pienissimo Live.
- 🆕 **Whether a production quote PDF now prints an Italian date** — declared done to
  the client, with nothing in the deployed delta that could do it (OI-358).
- 🆕 **What changed in the Fase 2 offer V.4 on 18/11 11:42:03Z**, and why it was
  reopened nine days later (OI-342).
- **Whether the three Mexal schedulers in production run as `amministratore
  pienissimo`** — the jobs are `WAITING`, the identity is unestablished (OI-301,
  OI-334).
- **Daniela Morgese's answer on Fase 2** — **day eight** (OI-342); **who builds R1 by
  14 December** (OI-349); **who covers Fase 1 support** — Elena Spini returns 19/11
  (OI-348).
- **Elena Spini's change workbook of 13/11**, due Friday 20/11 — a third window.
- **Which articles the live WooCommerce shop sells**, set against those deactivated
  on 15/11, and whether the deferred retest ever passed (OI-366) — **no report in
  three windows**.
- **What changed in `Business_Blueprint_Pienissimo.docx` on 16/11**, and who changed
  it.
- **Whether ROMI accepts or contests the Blueprint claim** — **no reply in thirteen
  days** (OI-343) — and `OP-1`, `OP-2`, `OP-4` of the R0 analysis, a fifteenth day.
- **Whether ROMI will send the Mexal integration material to a departing
  counterpart**, and whether Fabrizio Paganelli endorses the request (OI-368) —
  **third day, no reply**.
- **Who the client's System Admin is** for correcting a wrongly won Opportunity, and
  the runbook for doing it (OI-365).
- **Leaving dates and successors for Marco Montesi and Sabatino Rinaldi**, and who
  inherits the WooCommerce plugin configuration and the shop credentials ROMI does
  not hold (OI-357).
- **Fabrizio Mastracci's go-ahead on the Pienissimo Live forms**, and **which field
  they write for the marketing consent** (OI-371, OI-340 — **sixth window**).
- **The restore date for the event end dates**, with an owner, before 309 ready
  invitations either stay silent through Pienissimo Live or all send at once
  (OI-353).
- **The id-extraction date and format for Pienissimo Live attendance**, and the
  written specification Elisa Migliano asked for by mail (OI-361); **which event
  Andrea Parmeggiani's QR scanner will be ready for** (OI-323).
- **A list of the Aziende with more than one flagged principal contact** (OI-372).
- **Which cleanup option, A or B, for the 50,000 referenti leads**, the handling rule
  for rows whose Mexal code matches no Azienda, and a written basis for the marketing
  consent set on all of them (OI-351).
- **A corrected mail to the client** replacing the 11/11 approval that describes fake
  values which will never exist (OI-352).
- **Whether `numero tranche` and `tipo biglietto` are now defined per article**, and
  the reply owed to Fabrizio Paganelli on the registry (OI-329).
- **The contract with the missing third signature**, circled, which the client agreed
  to send (OI-336).
- **Whether the ticket flow's `Recipient_Contact__r` query was ever fixed** —
  unmentioned for a fifth window (OI-230).
- **The written production user list by role**, the marketing and Performance Plus
  profiles, and the marketing mailbox confirmed against DNS (OI-356, OI-363) — the
  marketing walkthrough is **19/11 09:30**, tomorrow.
- **Whether the six tutors completed MFA/passkey enrolment**, and whether any tutor
  now has a production user (OI-300).
- **The exact boundaries of Mexal's nightly maintenance window**, from Kreosoft
  rather than from guesswork (OI-334) — the mail of exact times is still unsent.
- **The picklist workbook** (OI-265, **twenty-fifth day**).
- **Whether Pienissimo holds a Zoho contract past 31 October** — **twenty-third
  run**, eighteen days after the expiry date.
- **The twelve `PLUS_B` values** (seventeenth day) · **what `lead-web-to-lead (2).html`
  is** (sixteenth day, Rexhina Hysi, never answered) · **whether the standing 30/07
  marketing follow-up notes exist at all**.
- **Who created fields and changed a layout in Prod without telling anyone** — raised
  by Aurel Mrruku in the ROMI DM on 13/11; nothing records what else changed.

## Written back

- **1 new item note**: **OI-374**. **Next free id 375.**
- **9 notes updated** (`updated:` bumped): OI-301, OI-322, OI-342, OI-358, OI-364,
  OI-370, OI-373, plus [the manual-steps tracker](../Manual%20Steps%20Pienissimo%20tracker.md)
  and [the recap of open changes](../The%20Pienissimo%20recap%20of%20open%20changes.md).
  **No status changes**; OI-370 stays `in-progress` because two commitments around
  the build are unmet, and OI-364 stays open because nobody has confirmed an agent
  can see either half.
- **MAP.md** — new nightly entry at the top, `Last updated` chain extended.
- **INDEX.md** — 1 item row, 1 trace row, and the tracker and recap rows refreshed.
- **`meetings/open-items.md` and `.it.md`** — **1 new row each** (#374) and **6
  regenerated rows** each (#301, #322, #342, #358, #364, #370, #373).
- **`meetings/DEVELOPMENT-RECAP.md` and `.it.md`** — new **§84** in both.
- **This trace**, and a `JOURNAL.md` entry.
- **Register untouched — v1.6.**
- **No person note was needed.** No new person appeared.
- **No credentials, prices, article codes or personal data were copied.** The Fase 2
  offer was read in full and **no amount was transcribed**; the DocuSign rows were
  recorded without reading any connected-app or credential value.
