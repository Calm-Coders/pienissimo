---
id: trace-2026-11-12-nightly
type: reference
status: active
updated: 2026-11-12
watermark_used: 2026-11-09T22:00Z
external_watermark: 2026-11-12T22:00Z
account: a.mrruku@romicompany.com
---

# Source trace 2026-11-12 nightly

**Watermark for the next `requirements-check` run: 2026-11-12T22:00Z, single
value.**

**Watermark used: 2026-11-09T22:00Z**, the `external_watermark` stated by
[the 09/11 nightly trace](Source%20trace%202026-11-09%20nightly.md), selected by
`updated:` frontmatter. Scheduled nightly run, executed 2026-11-12 ~22:00Z.
**Three days.**

🔑 **The headline: the migration goes into production tomorrow, thirteen real
orders have to be deleted from the org first, the fifty thousand referenti load
with invented company names and VAT numbers by the client's own approval, Anticipay
works in production at last — and the client's commercial lead has resigned.**

## ⚠ The 10 November run exists and its work was lost

**A `requirements-check` did run on 2026-11-10 and posted its report to the dev
group at 23:07 CET. Its commit was never pushed.** The report says so itself:

> _"🔴 **Il commit non è stato pushato.** `17b3bc1` esiste **solo in locale**:
> `git push` è stato **bloccato due volte dal classifier dell'ambiente**
> (_Out-of-Place Publication_), non da rete né da conflitti."_

Verified in this run: **no `17b3bc1` in any ref, no stash, and `notes/items/` stops
at OI-350.** So items **OI-351 → OI-356 were announced on Slack and never existed
in the repository**, along with two meeting notes, a decision note, seven note
updates, MAP/INDEX edits, both trackers, both recaps, a trace and a journal entry.

🔑 **Consequence for the watermark.** The repository's watermark is what a committed
trace says, so **2026-11-09T22:00Z was the correct starting point** and this run's
window legitimately covers 10, 11 and 12 November. The six lost ids have been
**rebuilt here from the original sources** — the 10/11 transcripts, the Gmail
threads and the Slack DMs, all re-read — **not** from the Slack report, which is
used only to establish that the ids were already published to the team. **The
numbers are kept**, because the dev group has seen them.

🟢 **Environment note.** The clone opened in **detached HEAD at `refs/heads/main`**
(two commits, config only) with none of the knowledge layer in the working tree;
`DevMain` did not exist locally and `git checkout DevMain` failed until the fetch
inside `git pull` had run. **Thirty-third run, same opening pattern.** The working
tree was **clean** at start, `DevMain` at **`6d70836`** (_"deploy in prod"_,
12/11 18:31 CET).

## Sources searched

| Source | Query / scope | Result |
| ------ | ------------- | ------ |
| **Gmail** | `pienissimo after:2026/11/09 -in:draft`, 50 requested, 24 estimated | **21 threads**, 19 moved inside the window. All material ones read in full |
| **Gmail** | `after:2026/11/09 (from/to/cc:pienissimo.com OR pienissimo.pro OR "ROMI-PIENISSIMO" OR kreosoft OR anticipay OR mexal OR docusign OR biglietto OR referenti)`, 50 requested | **22 threads**, 2 new against the first set (the third sandbox Anticipay alert, and a `[ROMI-ZUCCHET]` thread excluded as another client). 🔴 **Nothing from Kreosoft or DocuSign** |
| **Gmail** | `1a1d112a02556458` (`[ROMI-PIENISSIMO] - Recap delle modifiche aperte`) | 🔑 **The client-facing recap of twelve open changes**, 12/11 18:43:27Z → [the recap](../The%20Pienissimo%20recap%20of%20open%20changes.md) |
| **Gmail** | `1a1a746c8e63d5ac` (`Referenti`, 12 messages) | 🔑 **The whole referenti decision**: Sabatino Rinaldi 10/11 08:07Z, Elena Spini's mapping recap 18:41Z, the **fake-values mail 11/11 12:32Z** and the client's approval 14:32Z → OI-351, OI-352 |
| **Gmail** | `1a1c50aa4e66d4e8` (`Collegamento Woo - Salesforce`, 17 messages) | 🔑 **WooCommerce taken into production by the client**, with the Default Agent block and the province failure → OI-354. 🔴 **And Fabrizio Paganelli's production-test question, still unanswered** → OI-355 |
| **Gmail** | `1a1d06456c06e4f8` (`File Import Ordini`) | 🔴🔑 **41 new, 13 to delete, 19 to update**, with the Mexal numbers listed → OI-360. ⚠ Attachment not opened |
| **Gmail** | `1a1d004371522160` (`Edizioni Eventi passate`, 3 messages) | 🟢 The client backdated the old editions and Aurel Mrruku approved — _"Più condizioni non sodisfatti sono meglio è"_ → OI-353. ⚠ The screenshot was not opened |
| **Gmail** | `1a1d0abac99f5ad4` (`Anagrafica Articoli`, 2 messages) | 🔑 The client hit the mandatory-tranche rule on his product registry → OI-329 |
| **Gmail** | `1a1cb3d36d4df47d` (`Visualizzazione Pagina Principale`) | 🔑 Marco Montesi's four requests, incl. the **home-page work queue** and the lead-source list → OI-364, [the values](../The%20Pienissimo%20lead%20source%20values.md) |
| **Gmail** | `1a1bfc2c0e27f7d3` (`Anticipay`, 4 messages) | 🟢🔑 **Elena Spini, 12/11 11:45:25Z: _"il test in produzione per Anticipay … è andato tutto ok"_** → OI-312 **resolved** |
| **Gmail** | `1a1d00c85ebdda02`, `1a1cf4f445a4aaf0`, `1a1cf252e25e8584`, `1a1ceb2993b92a19` | The Locali, Referenti, Account and `Importazione Dati` mails. ⚠ **Bodies read, attachments not opened** — real customer records |
| **Gmail** | `1a1c9ec132c8f251` (Salesforce alert) | 🆕 **A third _"Sandbox: Errore Anticipay"_, HTTP 404**, 11/11 09:24:13Z → OI-312 |
| **Gmail** | calendar invitations `1a1cfab6d0764d0e`, `1a1cee32c71c8a7f`, `1a1ced49d8b70ac8`, `1a1cba86211c7260`, `1a1d0a61f8a03034`, `1a1d0a599fe7527c`, `1a1c5abc6fddd7ed` | The four meetings of this window plus 🆕 **`Test Finale Flusso MKT`, Thu 19/11 09:30**, to Fabrizio Paganelli, Sabatino Rinaldi, Matteo Distaso, Rebecca Marmo |
| **Gmail** | `1a1cfaddf7c5c67b`, `1a1c633e2f711cb5`, `1a1bfa75347845e0`, `1a1bfdc987948f67` | Meet/Gemini notifications — the trigger for the four drills |
| **Slack** | `slack_read_channel C0B5T3RB4FM` (`#tproj-pienissimo`), `oldest` 1794261600 | 🔴 **0 messages. The silence resumed** after the single 09/11 status post |
| **Slack** | `slack_read_channel C0BQD34LLF4` (dev group), same bound | **2 messages** — 🔴 **this session's own reports of 09/11 and 10/11, and one human line** (Aurel Mrruku, 12/11 12:58 CET, an Albanian request to create `pplus@pienissimo.com` in Prod, 2 thread replies). 🔴 **No nightly report has ever been answered** |
| **Slack** | `slack_read_channel D0B5QHS2T7H` (Elena Spini DM), same bound | **~46 messages.** 🔴🔑 **The 10/11 19:14-19:35Z exchange on the mandatory Company/P.IVA** — _"nop"_, _"tanto stiamo portando comunque merda"_ → OI-352 · 🔴 _"no i lead non li ho importati"_ · 🔴 the missing production user list → OI-356 · the WooCommerce/UAT trade-off → OI-354 · 12/11 _"le famose modifiche richieste da Marco"_ and the recap link. ⚠ **LIFE365 items excluded** — another project |
| **Slack** | `slack_read_channel C0C38JJ9D1T` (marketing group DM), same bound | **8 messages.** 🆕 Fabrizio Mastracci asks for and creates **`Invio_Oggi__c` on Event Invitation** (17:48-17:56 CET) → OI-230, [the flow](../flows/The%20ticket%20confirmation%20request%20flow.md) |
| **Slack** | `slack_read_canvas F0BD2H5A9HT` (`Link utili Pienissimo`) | **Unchanged.** Newest entry still 20.08.2026 — **84 days**. Re-read per the skill |
| **Drive** | `modifiedTime > '2026-11-09T22:00:00Z' and trashed = false`, 30 files, then a bounded second page | 🆕🔑 **`Pienissimo_Recap_Modifiche_2026-11-12.xlsx`** (18:37Z), the **two 12/11 meeting folders and transcripts**, **`Modifiche flussi Sales`** (17:21:50Z), **`Manual Steps Pienissimo`** (16:50:30Z), **`Fonte_lead_Salesforce.xlsx`**, `Referenti Salesforce.xlsx` (10:32Z), and `Pienissimo Offerta Fase 2_V.4` **touched 11/11 16:32:28Z**. The rest are **other clients or ROMI-internal** — VFL1, VISION, Permo, IUAD, LIFE365, 247.it, `[ROMI] Slide Team`, a shared-drive price list, the Christmas leave plan |
| **Drive** | `(title contains 'PIENISSIMO' or 'Pienissimo') and createdTime > watermark` | **14 hits**, all four meeting folders/transcripts plus the recap workbook. No other new Pienissimo artifact |
| **Drive** | `read_file_content 1SMdjCnigDx54EgFoH_HPuY9VnpbPjK7yRVo3I1h9TDc` | 🟢 **The 10/11 14:35 Referenti transcript, 11,726 chars, read in full** → [the note](../meetings/2026-11-10%20INTERNA%20Referenti%20come%20lead.md) |
| **Drive** | `read_file_content 1m5nSMyFT_9VpZlK9mbK_NpKl14FZ1zwllfmFpL0GbfA` | 🟢🔑 **The 10/11 16:02 follow-up, notes + full transcript, 30,314 chars, read in full** → [the note](../meetings/2026-11-10%20Follow-up%20Interno.md). ⚠ **No separate transcript document exists**; the 467 MB recording was not opened |
| **Drive** | `read_file_content 1ADtiuhZtdm4so1DDnBorhrosazV2dybPZNMTjvjGrSY` | 🟢🔑 **The 12/11 Check Pre-Import transcript, 85,416 chars (124,282 as fetched), read in full in four passes** → [the note](../meetings/2026-11-12%20Check%20Pre-Import.md) |
| **Drive** | `read_file_content 1wP_soQRlhOFTjRWB5rcz0mUGNe00vWRdmJ5q_U8b9_s` | 🟢🔑 **The 12/11 Modifiche Marco transcript, 33,944 chars, read in full** → [the note](../meetings/2026-11-12%20INTERNA%20Modifiche%20Marco.md) |
| **Drive** | `read_file_content 1D2hnr7PAysXpPR-37P6pw44dcgF7sbiV` | 🔑 **The recap of twelve open changes, read in full** → [the note](../The%20Pienissimo%20recap%20of%20open%20changes.md). ⚠ No euro figures present or transcribed |
| **Drive** | `read_file_content 1y4DeVJEjd3g5vPo-LqYyczQbc0BRp9jVfVw9RJA7Yh8` with comments | 🟡 **Now `A1:E21` — twenty request rows, the `CR` column replaced by `Lavorato`**: 5 `SI`, 6 `IN LAVORAZIONE`, 2 `NON SI FA`, 7 blank. No anchored comments → OI-344 |
| **Drive** | `read_file_content 1u-LgUKVlGK9ePyjMzZ_uJjXniHluo5_449siHgAIBHo` | 🔴🔑 **The Manual Steps production column**: three of four scheduled jobs **not** scheduled, _"the others should be done by Aurel"_ → OI-334, OI-301 |
| **Drive** | `read_file_content 1PHX-sgHAfOHdy8RF8W3iowhXBDar8Pf8` | 🟢 **The eleven lead-source values with usage rules**, read in full → [the note](../The%20Pienissimo%20lead%20source%20values.md) |
| **Drive** | `search_files parentId` checks on the two 12/11 folders | ⚠ **Neither holds a recording** — transcript shortcut only |
| **Fathom** | `list_meetings created_after 2026-11-09T22:00Z`, 3 pages, summaries on | **1 meeting, and it is not Pienissimo** — `SALESFORCE REPORTING`, 11/11, with Mehak Luthra, Tiziana Petruzzi and `vittoria.zoli@247.it`. 🔴 **Nothing for Pienissimo, a thirty-sixth consecutive run** |
| **Git** | `fetch`, `checkout DevMain`, `pull`, `status`, `log --all` | `DevMain` at **`6d70836`**; working tree **clean**. 🔑 **Five human commits in the window**: `888c91e` and `33ac872` (10/11, DocuSign error component, WooCommerce flux), `216988b`/`99011b0` (11/11, flexipage, PR #126), `4aeab90`/`76173ad` (11/11, Integration Logs flexipage actions removed), `2cf77af` (PR #127), `0fa4107` and `6d70836` (12/11, _"deploy in prod"_). 🔴 **No `17b3bc1`** |
| **Repo** | `ls notes/items` max-id scan | Max existing id **350** — **OI-351 to OI-356 absent, confirming the lost commit.** This run allocated **351**-**364**; next free is **365** |
| **Repo** | `JOURNAL.md` head | Two entries of 12/11, both `claude-sonnet-5-5`: the DevMain delta deployed to Prod (`0AfSW000001Lxnh0AC`, 176/176 tests, 75.8%) and the full branch-vs-Prod check with the guest-profile Apex grants (`0AfSW000001LyVF0A0`). **No entry for 10/11 or 11/11** |

## Found

1. 🔴🔑 **[Marco Montesi has resigned and Sabatino Rinaldi is leaving](../items/OI-357%20The%20client%20commercial%20lead%20and%20the%20web%20counterpart%20are%20both%20leaving.md)**
   — _"Marco è di\[missio\]nario. **Marco Montesi**"_ and _"**Sabatino va via**"_, both
   from Fabrizio Paganelli on 12/11, four days before the client's users start.
   ROMI learned it in the room. Between them they own the twenty Sales change
   requests, the undefined home page, the WooCommerce plugin and credentials, the
   two public lead forms and the Lead migration file. **No date, successor or
   handover for either.**

2. 🟢🔑 **The migration is final and loads 13/11**, ready for **16/11 09:00**, with
   the client out of Zoho on 12-13/11 and re-keying by hand on Monday. Four files
   arrived 12/11, ⚠ **none opened**. 🔴 **[Thirteen real orders must be deleted from
   production first](../items/OI-360%20Cancelled%20Mexal%20orders%20must%20be%20deleted%20from%20production.md)**,
   each taking its assets, event links and tickets with it by script — and 🔴 **the
   delta is no longer insert-only**: _"**Ok, vado in modifica**"_.

3. 🟢🔑 **[The referenti decision is in writing and confirmed](../items/OI-351%20Referenti%20without%20a%20Mexal%20code%20are%20imported%20as%20marketing%20leads.md)**,
   so [OI-290](../items/OI-290%20Lead%20and%20Referenti%20migration%20data%20is%20owed%20by%20the%20client.md)
   **closes** — but 🔴 **[the 49,800 rows load with invented Company and Partita IVA
   values](../items/OI-352%20The%20fifty%20thousand%20referenti%20leads%20are%20loaded%20with%20fake%20company%20and%20VAT%20values.md)**,
   `az10000, az10001 …`. Aurel Mrruku said _"**nop**"_; the client approved it.
   ⚠ Neither cleanup option chosen, no visibility design, **and the 107 mis-coded
   rows went unmentioned.**

4. 🟢🔑 **[Anticipay works in production and the item closes](../items/OI-312%20Anticipay%20times%20out%20in%20production.md)**
   — the first complete **shop → Salesforce → Anticipay → Mexal** run, on the client
   call, confirmed to the supplier at 11:45Z. ⚠ **No diagnosis**, and a third
   sandbox `HTTP 404` fired on 11/11. 🟢 **[WooCommerce is live in
   production](../items/OI-354%20WooCommerce%20is%20connected%20to%20production%20by%20the%20client.md)**,
   connected by the client — blocked first by a configuration the manual-steps
   tracker already marked `done`, then twice by an unvalidated province.

5. 🆕🔴 **[An interrupted contract cannot unwind its tranches, assets and
   tickets](../items/OI-359%20An%20interrupted%20contract%20cannot%20unwind%20its%20tranches%20assets%20and%20tickets.md)**
   — _"**Per il momento non l'abbiamo previsto**"_, the same missing reverse gear as
   OI-331 but wider, with the credit-note annulment case on top, parked on a Fase 2
   list **it appears in no Fase 2 document of**.

6. 🆕🔴 **[Pienissimo Live attendance cannot reach
   Salesforce](../items/OI-361%20Pienissimo%20Live%20attendance%20cannot%20be%20recorded%20in%20Salesforce.md)**
   — QR codes stay in Zoho, the supplier _"non ha ancora fatto niente"_, ~450
   attendances to be hand-matched by record id with **Campaign Member abandoned**:
   _"io ho il dubbio che succederanno dei casini."_

7. 🆕🔴 **[The org was never set to
   Italian](../items/OI-358%20The%20org%20is%20not%20set%20to%20Italian%20date%20and%20number%20formats.md)**
   — found by the tutors at training, not by any test: _"**Come mai ci è sfuggito sta
   cosa?**"_ It is row 1 of
   **[the twelve-row recap sent to the client at 18:43Z](../The%20Pienissimo%20recap%20of%20open%20changes.md)**,
   ROMI's first formal answer to
   [OI-344](../items/OI-344%20The%20client%20sent%20sixteen%20Sales%20flow%20changes%20and%20none%20is%20triaged.md),
   whose sheet now carries a verdict on most of twenty rows. 🔴 **Everything slipped
   to next week**, after the users start.

8. 🔴 **Production is not ready for 16/11**: no
   [marketing or Performance Plus profile](../items/OI-363%20The%20marketing%20and%20Performance%20Plus%20profiles%20do%20not%20exist.md)
   · [three of four scheduled jobs unscheduled](../items/OI-334%20The%20Mexal%20sync%20frequency%20is%20undecided%20and%20no%20job%20is%20scheduled%20in%20production.md),
   named as Aurel Mrruku's · **no logo** ·
   [no calendar and no home page for the agents](../items/OI-364%20Agents%20cannot%20see%20the%20home%20page%20or%20the%20calendar%20in%20production.md)
   · [the written user list never delivered](../items/OI-356%20The%20definitive%20list%20of%20production%20users%20is%20still%20incomplete.md).
   🟢 **Licences are fine** — 12, 9 used, 3 free, two more recoverable
   ([OI-341](../items/OI-341%20The%20UAT%20org%20ran%20out%20of%20Salesforce%20licences.md)).

9. 🔑 **[The ticket flow got its two missing rules](../flows/The%20ticket%20confirmation%20request%20flow.md)**
   — a future send date never fired, and the exit on event end date had been written
   and forgotten (_"**Mi ero dimenticato**"_) — plus a new `Invio_Oggi__c` field and
   **15 reminders confirmed, not 11**. 🔴 **And
   [OI-230](../items/OI-230%20The%20ticket%20confirmation%20request%20flow%20queries%20a%20relationship%20name%20as%20a%20field.md)
   went unnamed for a second consecutive hour of work on that flow**, with the test
   recipient filter and minute-long intervals still live.

10. 🔴 **[Event end dates are backdated in
    production](../items/OI-353%20Production%20event%20end%20dates%20are%20backdated%20to%20stop%20ticket%20mails%20during%20the%20load.md)**
    to suppress the mails during the load, applied by the client on 12/11 — with the
    **restore date named inside a sentence beginning "I don't know"** and no owner.
    ⚠ Four Edizione date fields were added **directly in production** mid-call.

11. 🆕⚠ **[Reassigning an agent code does not update existing
    accounts](../items/OI-362%20Reassigning%20an%20agent%20code%20does%20not%20update%20existing%20accounts.md)**
    — checked live in Prod; orders are safe, accounts are not, and two of the
    client's people are about to be replaced.

12. 🔴 **[Nobody answered whether the client may test quotes in
    production](../items/OI-355%20Nobody%20answered%20whether%20quote%20tests%20can%20be%20run%20in%20production.md)**,
    a third day, in a thread that ran fourteen more messages past the question.
    🔴 **[The Blueprint reply is a seventh day
    overdue](../items/OI-343%20The%20client%20disputes%20that%20the%20stage%20sale%20contract%20was%20outside%20the%20Fase%201%20Blueprint.md)**,
    with Fase 2 approval expected **13/11** and R0 already being built.

## Not done, and why

- **The org was not opened.** Every production statement here comes from a mail, a
  Slack message, a transcript, a Drive document, the source tree or an earlier
  journal entry, **not from an inspection in this session**. `STATUS.md` and its
  Notion mirror are **stale**; the sweep moved the live position and step 6 of
  `org-status-check` was **not** run. 🔴 **This matters tonight: the production
  migration runs tomorrow** and nothing here verifies the org it will run against.
- **No Apex test class was written or proposed.** Standing instruction.
  [OI-64](../items/OI-64%20The%20bundle%20Apex%20test%20suite%20is%20broken.md),
  [OI-66](../items/OI-66%20No%20test%20classes%20for%20the%20Biglietto%20stack.md) and
  [the deploy risk](../risks/Risk%20-%20production%20deploy%20is%20blocked%20by%20Apex%20coverage.md)
  are unchanged and were not acted on. ⚠ Note that the 12/11 journal entries record
  a new `OrderPdfServiceTest` written by another session at **75.8%** coverage, 113
  lines above the floor — reported, not acted on.
- **No customer-data workbook was opened**: `Referenti Salesforce.xlsx` (12.4 MB),
  the `Account` and `Locali_CON_codice_Mexal.xlsx` attachments, and `Import Ordini
  (versione del 2026.11.12).xlsx`. Their existence, counts and column lists are
  recorded; **no values are copied**.
- **No screenshot or image attachment was opened**, including the `Edizioni Eventi
  passate` screenshot that shows the exact dates the client wrote.
- **The 467 MB recording of the 10/11 follow-up was not opened** — the notes
  document carries the full transcript.
- **No euro figures were transcribed.** The recap workbook carries none; the Fase 2
  offer was not re-read in this window beyond noting it was touched on 11/11.
- **`Pienissimo Offerta Fase 2_V.4` was not re-read.** It was modified 11/11
  16:32:28Z and the change is unexamined; the 13/11 approval question
  ([OI-342](../items/OI-342%20The%20Fase%202%20offer%20V2%20reorders%20the%20releases%20and%20contradicts%20itself.md))
  is unchanged in this record.
- **The Fase 2 items were not individually updated** — OI-342, OI-346, OI-347,
  OI-348, OI-349, OI-350 have **no new evidence in this window**. The only movement
  is that their approval date, 13/11, is now tomorrow.
- **LIFE365, VISION, VFL1, Permo, IUAD, 247.it and the `[ROMI-ZUCCHET]` Blueprint
  thread were excluded** — other projects, per the skill.
- **The requirement register was not touched** — stays **v1.6**. The OI-344
  mandatory picklists and the OI-329 tranche obligation remain **v1.7 candidates**;
  🆕 the OI-359 interruption case and the OI-358 locale change join them only if the
  client agrees scope. None is agreed.
- **`prettier:verify` was not run** (not executable in this environment, as on
  previous runs).

## Still unreachable

Named precisely enough to ask someone for them:

- **Leaving dates and successors for Marco Montesi and Sabatino Rinaldi**, and who
  inherits the WooCommerce plugin configuration and shop credentials ROMI does not
  hold (OI-357).
- **Which cleanup option, A or B, Pienissimo chooses for the 50,000 referenti
  leads**, with an owner and a date — and **the handling rule for the 107 rows whose
  Mexal code matches no Azienda** (OI-351, OI-290).
- **The list of Mexal order codes to delete**, before the delta runs (OI-360).
- **The restore date for the event end dates**, and an owner for it (OI-353).
- **Whether the client may run quote tests in production** (OI-355) and **how the
  existing production test orders come out** (OI-315).
- **The written production user list by role**, and the marketing mailbox confirmed
  against DNS (OI-356, OI-363).
- **Which event Andrea Parmeggiani's production QR scanner will be ready for**, with
  a date — the 12/11 exchange contradicts itself (OI-361, OI-323).
- **The written specification of the Pienissimo Live id exchange**, which Elisa
  Migliano asked for by mail and nothing records sent (OI-361).
- **The chosen Mexal sync frequency, and who schedules the three missing jobs**
  (OI-334, OI-301).
- **Whether the ticket flow's `Recipient_Contact__r` query was ever fixed** — two
  sessions of flow work have now passed over it (OI-230).
- **Whether `profilazione` is the marketing consent**, and which field the website
  forms should write (OI-340) — **third window with no mention**, and the owner is
  leaving.
- **The landing pages**, promised _"entro fine gg"_ on 09/11 and again on 10/11 and
  still not evidenced delivered.
- **Whether ROMI accepts or contests the Blueprint claim** — **no reply in seven
  days** (OI-343) — and `OP-1`, `OP-2`, `OP-4` of the R0 analysis, a ninth day.
- **Which document the client approves on 13 November**, and whether `150 giornate`
  still holds (OI-342); **who builds R1 by 14 December** (OI-349); **who covers Fase
  1 support from 16 November** (OI-348).
- **The email timing rule from Rebecca Marmo**, now needed by two items rather than
  one (OI-350, OI-331, OI-359), and **whether R2's 14 January holds**.
- **The lawyer's answer on the legal-representative fields** (OI-346).
- **The SFDC SOAP API notice itself, with its deadline** (OI-347).
- **Whether the six tutors completed MFA/passkey enrolment** — only Fabrizio
  Paganelli's is confirmed — and **no production user exists for any tutor** (OI-300).
- **A row-by-row Fase 1 / Fase 2 label** on the twenty Sales rows, and **who
  specifies the home page** now (OI-344, OI-364).
- **Whether every existing `plus` product has `Numero tranche` set** (OI-329), and
  the reply owed to Fabrizio Paganelli on the article registry.
- **A runbook for reassigning an agent code**, and the API name of the account-side
  field (OI-362).
- **Whether the Mexal API calls switched off for the load were switched back on**,
  and when the marketing flows reactivate (OI-244).
- **The picklist workbook itself** (OI-265, **nineteenth day**), plus the unresolved
  mandatory-versus-read-only collision.
- **Whether Pienissimo holds a Zoho contract past 31 October** — **twentieth run**,
  twelve days after the expiry date, while offer R5 commits to integrating with Zoho
  in March 2027.
- **How many invoice numerators must change, and by when** — the Mexal production
  order numerator starts at **62** and the client's own question about it went back
  to his side.
- **The twelve `PLUS_B` values** (eleventh day) · **what `lead-web-to-lead (2).html`
  is** (tenth day, Rexhina Hysi, never answered) · **whether the WooCommerce link
  bug of 12/11 was real** — argued down live, not reproduced, not recorded · the
  standing **30/07 marketing follow-up notes**.

## Written back

- **4 meeting notes**: the 10/11 Referenti call, the 10/11 follow-up, the 12/11
  Check Pre-Import, the 12/11 Modifiche Marco call.
- **14 new item notes**: OI-351 → OI-364. **OI-351 to OI-356 recover the lost
  10/11 run**, rebuilt from source and keeping the ids already published to the
  dev group.
- **1 new decision note** ([WooCommerce plus orders are acceptances](../decisions/Decision%20-%20WooCommerce%20plus%20orders%20are%20acceptances.md))
  and **2 new reference notes** ([the recap of open changes](../The%20Pienissimo%20recap%20of%20open%20changes.md),
  [the lead source values](../The%20Pienissimo%20lead%20source%20values.md)).
- **18 notes updated** (`updated:` bumped): OI-212, OI-230, OI-265, OI-290, OI-300,
  OI-301, OI-310, OI-312, OI-315, OI-329, OI-331, OI-334, OI-340, OI-341, OI-343,
  OI-344, plus [the ticket confirmation request flow](../flows/The%20ticket%20confirmation%20request%20flow.md)
  and [the Manual Steps tracker](../Manual%20Steps%20Pienissimo%20tracker.md).
  **Status changes: OI-290 and OI-312 → `resolved`**, OI-352 written as `resolved`.
- **MAP.md** — new nightly entry at the top, `Last updated` chain extended.
- **INDEX.md** — 14 item rows, 4 meeting rows, 1 decision row, 2 reference rows,
  1 trace row.
- **`meetings/open-items.md` and `.it.md`** — **14 new rows each** (#351-#364) and
  **16 regenerated rows** each (#212, #230, #265, #290, #300, #301, #310, #312,
  #315, #329, #331, #334, #340, #341, #343, #344).
- **`meetings/DEVELOPMENT-RECAP.md` and `.it.md`** — new **§81** in both.
- **This trace**, and a `JOURNAL.md` entry.
- **Register untouched — v1.6.**
- **No person note was needed**: Marco Montesi, Sabatino Rinaldi, Elisa Migliano,
  Rebecca Marmo, Andrea Parmeggiani, Matteo Distaso and Fabrizio Mastracci are all
  already in `notes/people/`. ⚠ Marco Montesi's and Sabatino Rinaldi's notes should
  be revisited when their leaving dates are known.
