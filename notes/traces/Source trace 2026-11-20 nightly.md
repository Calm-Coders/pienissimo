---
id: trace-2026-11-20-nightly
type: reference
status: active
updated: 2026-11-20
watermark_used: 2026-11-19T22:00Z
external_watermark: 2026-11-20T22:00Z
account: a.mrruku@romicompany.com
---

# Source trace 2026-11-20 nightly

**Watermark for the next `requirements-check` run: 2026-11-20T22:00Z, single
value.**

**Watermark used: 2026-11-19T22:00Z**, the `external_watermark` stated by
[the 19/11 nightly trace](Source%20trace%202026-11-19%20nightly.md), selected by
`updated:` frontmatter. Scheduled nightly run, executed 2026-11-20 ~21:50Z.
**One day.**

🔑 **The headline: ROMI answered the PEC on 19 November and contested it in full,
and the client meeting of 20 November at 14:30 settled nothing and produced a
demand — lo scadenziario e le note di credito, ASAP. The reports and dashboards
exist, built by hand in a day, unmerged on `DevAnita19`, with a production release
planned for a public holiday and explicitly no explanation to the users.**

🟢 **Three names that six traces listed as unreachable are settled**, all by ROMI's
own reply: **Angelo Pastorelli**, **Gianpaolo Motta** (the 19/11 _"Giancarlo"_ was
a mis-hearing) and **Sig. Giuliano Lanzetti** — whose first name had carried
`uncertain:` since August.

🔴 **The PEC itself is still in no source this account can reach**, and its
art. 1454 term is still unknown — **a second day**.

🟢 **Environment note.** The clone opened on **`main`** (two commits, config only)
with none of the knowledge layer in the working tree; `DevMain` did not exist
locally and `git checkout DevMain` failed until `git fetch` had run. **Thirty-eighth
run, same opening pattern.** Working tree **clean** at start, `DevMain` at
**`9d7868d`**.

## Sources searched

| Source | Query / scope | Result |
| ------ | ------------- | ------ |
| **Gmail** | `pienissimo after:2026/11/19 -in:draft`, 50 requested | **6 threads**, **2 past the watermark**, both **auto-generated**: the Gemini notes for `[PIENISSIMO] - Interna Check Report` (08:48:54Z) and for a Vision call. 🔴 **Not one message from anyone at Pienissimo** |
| **Gmail** | `after:2026/11/19 (pienissimo.com OR pienissimo.pro OR "ROMI-PIENISSIMO" OR kreosoft OR anticipay OR mexal OR docusign OR biglietto OR referenti OR salesforce)`, 50 requested | **20 threads**, **0 new and Pienissimo-relevant** beyond the Gemini notes. 🔴 **Nothing from Kreosoft, DocuSign or Anticipay** — a fifth window. Excluded: 247.it (brand reports, reception, seasons, PINTO/ORLOVA), Life365, Zucchet/3CX/DF Solutions, VISION, VFL1, Daze, Wi Legal / SHR Italia, Salesforce partner and newsletter mail, a ROMI internal invoicing thread |
| **Gmail** | `after:2026/11/19 (sabatino OR elisa OR montesi OR paganelli OR parmeggiani OR morgese OR merendi OR mastracci OR spini OR preventivo OR fattura OR woocommerce OR biglietti OR evento OR contratto OR ordine)`, 50 requested | **11 threads**, 🔴 **again nothing from the client**. Only ROMI-internal and other-project mail |
| **Gmail** | `after:2026/11/18 (PEC OR contestazione OR diffida OR "messa in mora" OR 1454 OR 1662 OR legale OR avvocato OR golive OR "go-live" OR dashboard OR report OR formazione OR training)`, 30 requested, summary view | **27 threads, none of them the PEC and none ROMI's reply.** 🔴 **Neither document is in this mailbox**, in any form — **a second day, eight formulations in total** |
| **Gmail** | `get_thread` on the Gemini notes for `[PIENISSIMO] - Interna Check Report`, full body | 🔑 **Read in full.** Dashboards presented, tranche and insoluti reports verified, **deployment approved for Monday** _"senza però fornire spiegazioni agli utenti"_ → OI-381 |
| **Slack** | `slack_read_channel C0C38JJ9D1T` (marketing group DM), `oldest` 1795125600 | 🔑 **33 messages, 09:10:35 → 17:37:33 CET.** **Where ROMI's PEC reply surfaced**, pasted verbatim at **09:11:03** → OI-379; the domain argument 09:12-09:16 → OI-383; **the 14:30 meeting outcome 16:49-16:53** → OI-380. ⚠ Two audio messages at 09:20 and 09:22 **not transcribable** by this account |
| **Slack** | `slack_read_channel C0B5T3RB4FM` (`#tproj-pienissimo`), same bound | 🔑 **1 message — Elena Spini's weekly status post, 19:00:03 CET**, after **eight silent days**. The single richest source in the window: go-live suspension chronology, the 20/11 call, **the verified 16/11 production circuit**, the 18/11 release contents, **six reports in UAT**, the marketing training dates, **WhatsApp blocked by Meta**, next steps, red flags → OI-373, OI-374, OI-377, OI-378, OI-380, OI-382 |
| **Slack** | `slack_read_channel C0BQD34LLF4` (ROMI dev group), same bound | 🔴 **0 new messages.** Only this session's own report of 19/11; **no human has ever replied to a nightly report** |
| **Slack** | `slack_read_channel D0B5QHS2T7H` (Elena Spini DM), same bound | **1 message**, 10:31:53 CET — _"ci sei per zucchet?"_, another project. **Nothing on Pienissimo** |
| **Slack** | `slack_read_canvas F0BD2H5A9HT` (`Link utili Pienissimo`) | **Unchanged.** Newest entry still 20.08.2026 — **92 days**. Re-read per the skill |
| **Drive** | `modifiedTime > '2026-11-19T22:00:00Z' and trashed = false`, 40 files, `modifiedTime desc` | **23 files**, 🔑 **four Pienissimo**: the 20/11 meeting document with its shortcut and folder, and 🆕 **`Pienissimo_Offerta_Fase_2_V_4.1.pptx`** at 12:36:20Z **by Angelo Pastorelli**, alongside V.4 at 12:35:07Z by Andrea Galotto. The rest excluded — Daze, VFL1, Vision/Mulesoft, Zucchet/3CX, 247.it, ROMI Slide Team |
| **Drive** | `(title contains 'Pienissimo' or 'PEC' or 'Fase 2' or 'contestazione' or 'scadenziario' or 'nota credito') and modifiedTime > watermark` | **5 hits**, the meeting document and the two offer files. 🔴 **No copy of the PEC and no copy of ROMI's reply in Drive**, under any of those titles — a second day |
| **Drive** | `read_file_content 1r82xuJWwSqyj69tDhrFzx3MUGezgY8hnn_52m-Y4Nn4` | 🔑 **`[PIENISSIMO] - Interna Check Report`, 00:13:05, Gemini notes + full transcript, read in full** → [the meeting note](../meetings/2026-11-20%20INTERNA%20Check%20Report.md). ~6k tokens |
| **Fathom** | `list_meetings created_after 2026-11-19T22:00Z`, 3 pages, summaries on | 🔴 **0 meetings. Nothing at all, a forty-first consecutive run** — on a day with a recorded Pienissimo Google Meet call |
| **Git** | `fetch --all`, `log --all --since`, `diff --stat DevMain...origin/DevAnita19` | **2 commits in the window**, both **Anita Aga** on **`DevAnita19`**, both **unmerged**: `47a2a42` _"Modifications on report and added visibility to agents"_ (11:29:54+01:00) and `a25d4b3` _"removed the sync icon from the mexal sync component"_ (11:46:22+01:00). With `026cc33` of 19/11 the branch is **27 files, +1,132 / -71**. `DevMain` unchanged at **`9d7868d`**. Tree **clean** at start |
| **Repo** | `JOURNAL.md` head, `MAP.md` head, `ls notes/items` max-id scan | Watermark and state confirmed. Max existing id **383** after this run; **next free is 384** |

## Found

1. 🆕🟢🔑 **[ROMI replied to the PEC and contested it in full](../items/OI-379%20ROMI%20replied%20to%20the%20PEC%20and%20contested%20it%20in%20full.md)**
   — **OI-379**. Sent **19 November**, signed **Angelo Pastorelli**, _il Legale
   Rappresentante_ of ROMI, to Pienissimo S.r.l. for the attention of **Sig.
   Giuliano Lanzetti**. ROMI does not share _"né la ricostruzione dei fatti né le
   qualificazioni giuridiche"_, reserves a detailed rebuttal, confirms the 20/11
   14:30 meeting and a calendar of next activities, and states that neither the
   reply nor continued work is **acquiescenza né riconoscimento**, reserving every
   right _"anche in relazione ai corrispettivi contrattuali"_. 🔑 **Contest-and-
   perform, not suspend.** ⚠ Read as text pasted into Slack; the sent document was
   not seen.

2. 🆕🔴🔑 **[The client wants the scadenziario and the credit notes ASAP](../items/OI-380%20The%20client%20wants%20the%20scadenziario%20and%20the%20credit%20notes%20as%20soon%20as%20possible.md)**
   — **OI-380**. The 14:30 meeting happened, **with Salesforce in the room**, and
   _"call iniziata malissimo (Daniela NERA per aver ricevuto la pec di risposta)
   alla fine andata un po meglio"_. The outcome is a demand for two **Fase 2**
   items under a **Fase 1** claim — the scadenziario, whose reverse gear was R1 on
   14 December, and the credit notes, for which no requirement exists. 🔴 Nothing
   decided; Angelo Pastorelli then called the client's direction privately; the
   freeze holds; next week has no plan. 🔴 **The meeting was not recorded in any
   form.**

3. 🆕🔴 **[The remediation is unmerged and due in production on a holiday](../items/OI-381%20The%20report%20and%20dashboard%20remediation%20is%20unmerged%20and%20due%20in%20production%20on%20a%20holiday.md)**
   — **OI-381**. **5 dashboards, 6 reports** (+3 more and a report type), the Home
   surface and `Agente.permissionset`, on `origin/DevAnita19`, **unmerged**.
   Release planned **Monday 23 November, a public holiday**, by one developer
   working unannounced, _"senza però fornire spiegazioni agli utenti"_, past an
   un-withdrawn UAT-only instruction, gated on Angelo Pastorelli and Gianpaolo
   Motta. 🔑 **Closes the 19/11 question: `026cc33` is the OI-377 work.**

4. 🆕🔴 **[WhatsApp is blocked because Meta blocked the client number](../items/OI-382%20WhatsApp%20is%20blocked%20because%20Meta%20blocked%20the%20client%20number.md)**
   — **OI-382**. _"WhatsApp resta fermo: il numero è bloccato da Meta, lato
   cliente."_ Counted by ROMI as one of **three Fase 1 closure items** and one of
   the two outside its control. ⚠ One line is the whole evidence; no requirement
   for it exists in the register.

5. 🆕⚠ **[The landing page domain must be re-raised with marketing](../items/OI-383%20The%20landing%20page%20domain%20must%20be%20re-raised%20with%20the%20marketing%20team.md)**
   — **OI-383**. The client declined to customise the domain, but only its
   administration knows; the domain shows on the **public landing pages and the
   community**. 🟢 The **email sending domain is separate, mandatory and was done
   in July** on the client's own instruction. Training on landing pages is 26/11.

6. 🟢🔑 **[The production circuit was verified end to end on 16 November](../items/OI-373%20DocuSign%20is%20not%20configured%20in%20production%20for%20the%20order%20PDF%20attachment.md)**
   — _"preventivo >> DocuSign >> ordine >> Mexal >> fattura >> incasso e
   **funziona**"_, walked with Fabrizio Paganelli and Elisa Migliano. **This
   answers four windows of asking whether DocuSign works in Prod.** ⚠ The circuit
   tested was quote → DocuSign, not the order PDF of 18/11. 🔑 **And a new
   question**: _"dai dati migrati non è partito nessun biglietto"_ — correct
   behaviour or defect, no source says, and nobody is investigating.

7. 🟢 **[The reports and dashboards are built and accepted](../items/OI-377%20Reports%20and%20dashboards%20were%20never%20built%20and%20have%20no%20requirements.md)**
   — six reports behind five dashboards, scope well past the one sentence they
   were authorised on. 🟢 One line traces to a client ask, Fabrizio Paganelli on
   outstanding invoices. 🔴 **The rest is invention and both of them said so** —
   _"we have invented six of them"_. 🟡 The tranche report must be **scheduled to
   administration before month end** and is not.

8. 🟡 **[Marketing training has dates](../items/OI-378%20Marketing%20training%20is%20undelivered%20and%20the%20client%20did%20not%20attend%20the%20final%20test.md)**
   — **24/11** segments and newsletter, **26/11** forms and landing pages. ⚠ Both
   unconfirmed with the client, both **inside Pienissimo Live 24-26/11**, and
   **nobody is named as the sender**. The scaletta is still not recorded and the
   19/11 test pack is still unsent.

9. 🟡 **[The 18/11 release contents are independently confirmed](../items/OI-374%20The%2018%20November%20release%20mail%20tells%20the%20client%20the%20order%20contract%20flow%20is%20live.md)**
   and the release was **client-requested, brought forward at Fabrizio
   Paganelli's ask**. 🟢 The Italian date format is confirmed shipped in it, by a
   second person. ⚠ The testing objection is only partly answered — the circuit
   test **predates** the release.

10. 🆕🔑 **[A V.4.1 of the contested Fase 2 offer](../items/OI-342%20The%20Fase%202%20offer%20V2%20reorders%20the%20releases%20and%20contradicts%20itself.md)**
    — created 08:13:19Z, last modified **12:36:20Z by Angelo Pastorelli**, two
    hours before the client meeting. ⚠ Not read, no figure transcribed.

11. 🔑 **ROMI's position on Fase 1, in writing for the first time**: _"Per noi
    tutto quello concordato per la Fase 1 è in PROD dal 16/11"_ — ⚠ against her own
    red flag, _"Fase 1 senza data di chiusura"_, with two of the three closure
    items dependent on the client.

## Not done, and why

- 🔴 **The PEC was still not read, and nor was ROMI's own reply as sent.** Eight
  mail formulations across two days and four Drive searches have found neither.
  **Everything recorded about the PEC's contents remains one person's spoken
  account**, and the reply is known only as pasted text. **Its art. 1454 deadline
  is still the single most important unknown on the project.**
- 🔴 **The 14:30 meeting has no record of any kind.** No Fathom, no Meet
  transcript, no Gemini notes, no minute. Elena Spini's Slack account is the only
  source and she flagged it as unconfirmed herself. ⚠ On a project whose defence
  is the meeting record, this is the gap that matters most.
- ⚠ **Two Slack audio messages of 20/11 09:20 and 09:22 were not transcribed** —
  this account cannot read `audio/mp4` attachments. Their content is unknown and
  they sit in the middle of the domain discussion.
- **The org was not opened.** `STATUS.md` and its Notion mirror are **stale**; the
  sweep moved the live position and step 6 of `org-status-check` was **not** run.
  ⚠ This matters for the date-format claim, for the UAT reports, and for whether
  anything of `DevAnita19` has reached an org.
- **No Apex test class was written or proposed.** Standing instruction. OI-64,
  OI-66 and [the deploy risk](../risks/Risk%20-%20production%20deploy%20is%20blocked%20by%20Apex%20coverage.md)
  are unchanged and were not acted on. ⚠ Note `mexalSyncPanel.test.js` changed on
  `DevAnita19` — that is an existing LWC jest test edited by Anita Aga, not Apex,
  and it was not touched here.
- ⚠ **`Pienissimo_Offerta_Fase_2_V_4.1.pptx` was not read** and no euro figure was
  transcribed, per the standing rule and the precedent set for the Fase 2 offer.
  **What V.4.1 changes from V.4 is unknown.**
- ⚠ **`Business_Blueprint_Pienissimo.docx` was not read**, a fifth window. It did
  not change today.
- ⚠ **Elena Spini's change workbook of Friday 13/11 was again not found** — a
  **fifth** window, and it was **due today**. The freeze has overtaken it.
- **The client change sheet was not re-read** — no Drive edit in the window, so
  OI-344 stands at 7 `SI` / 4 `IN LAVORAZIONE` / 2 `NON SI FA` / 6 blank.
- **No customer-data workbook or attachment was opened.** None was offered.
- **OI-336, OI-343, OI-345, OI-347 to OI-369, OI-371, OI-372 were not updated** —
  **no new evidence in this window**. ⚠ Many are frozen rather than open.
- **The requirement register was not touched** — stays **v1.6**. ⚠ Three things
  ROMI now treats as owed have no requirement in it: **reports and dashboards**,
  **credit notes** and **WhatsApp**. The OI-344 mandatory picklists, the OI-329
  tranche obligation, the OI-359 interruption case and the OI-358 locale change
  remain **v1.7 candidates**; none is agreed.
- **247.it, Life365, Zucchet / 3CX / DF Solutions, VISION / VapeItalia, VFL1,
  Daze, Permo and Wi Legal / SHR Italia were excluded** — other projects, per the
  skill. ⚠ Aurel Mrruku spent most of 20/11 on 247.it brand reports and the
  Zucchet 3CX test, which is itself consistent with the Pienissimo freeze.
- **`prettier:verify` was not run** (not executable in this environment, as on
  previous runs).

## Still unreachable

Named precisely enough to ask someone for them:

- 🔴 **The PEC of 17 November itself** — its full text, its heads of claim and above
  all **the term it fixes under art. 1454 c.c.** — **and ROMI's own reply as
  sent**, with its despatch and delivery receipts. Ask Angelo Pastorelli, Elena
  Spini or Gianpaolo Motta.
- 🆕🔴 **The detailed rebuttal ROMI reserved** — _"ci riserviamo di replicare nel
  dettaglio con separata comunicazione"_ — and the Fase 2 chronology behind it.
- 🆕🔴 **Any record of the 20/11 14:30 meeting**, and of the private call Angelo
  Pastorelli made to the client's direction afterwards.
- 🆕🔴 **Angelo Pastorelli's and Gianpaolo Motta's decision** on how to proceed next
  week, which the project manager is explicitly waiting on — and **whether the
  Monday reports release is approved**.
- 🆕 **A ruling on whether the scadenziario and the credit notes are Fase 1 or
  Fase 2**, before either is estimated.
- 🆕 **Whether the calendar of next activities ROMI promised in its reply was
  actually handed over** at the meeting.
- 🆕 **Daniela's surname from a primary source** — _"la famosa direzione"_ fits
  Daniela Morgese and nothing read today says it outright.
- 🆕 **The WhatsApp number, its block date and Meta's stated reason**, and who at
  Pienissimo is dealing with it (OI-382).
- 🆕 **Whether no Biglietto from migrated data is correct or a defect**, with an
  owner (OI-373) — six days before Pienissimo Live.
- 🆕 **What the two Slack audio messages of 20/11 morning say.**
- **The contract clause that makes reports and dashboards a deliverable**, quoted,
  and the contractual training provision behind the 20-hour figure (OI-377,
  OI-378) — second day.
- **ROMI's training record** — dates, hours, attendees, recordings — which the
  PEC's second ground turns on and which does not exist here (OI-378).
- **Who may write to the client at all**, by name: the training calendar, the test
  pack and the domain question all need a sender (OI-375, OI-378, OI-383).
- **Why nobody from Pienissimo joined the 19/11 marketing test**, and Matteo
  Distaso's answer to Fabrizio Mastracci on the landing pages (OI-378).
- **Whether `DevAnita19` will be merged before any production release** (OI-381).
- **Whether the order PDF DocuSign configuration exists in production**, with a
  date and a name (OI-373, OI-374) — third day, now narrowed to the order path
  since the quote path is verified.
- **Whether any real WooCommerce order has ever been taken end to end in
  production** — third day, four days before Pienissimo Live.
- **Whether a production quote PDF now prints an Italian date** — twice accounted
  for, never verified (OI-358).
- **Whether the three Mexal schedulers in production run as `amministratore
  pienissimo`** (OI-301, OI-334), and **the written run instructions and the
  job-times mail to Sabatino Rinaldi** — fourth day, now with no sender (OI-370).
- **Elena Spini's change workbook of 13/11**, which was due today — a fifth window.
- **Whether ROMI accepts or contests the Blueprint claim** — **no reply in
  fifteen days** (OI-343) — and `OP-1`, `OP-2`, `OP-4` of the R0 analysis, a
  seventeenth day.
- **Which articles the live WooCommerce shop sells**, set against those
  deactivated on 15/11, and whether the deferred retest ever passed (OI-366) — no
  report in five windows.
- **What changed in `Business_Blueprint_Pienissimo.docx` on 16/11**, and who
  changed it.
- **Leaving dates and successors for Marco Montesi and Sabatino Rinaldi**, and who
  inherits the WooCommerce plugin configuration and the shop credentials ROMI does
  not hold (OI-357) — ⚠ Marco Montesi is also the only source of the one reports
  requirement that exists (OI-377).
- **Fabrizio Mastracci's go-ahead on the Pienissimo Live forms**, and **which
  field they write for the marketing consent** (OI-371, OI-340 — **eighth
  window**).
- **The restore date for the event end dates**, with an owner, before 309 ready
  invitations either stay silent through Pienissimo Live or all send at once
  (OI-353) — ⚠ now also bearing on the missing Biglietto of 16/11.
- **The id-extraction date and format for Pienissimo Live attendance**, and the
  written specification Elisa Migliano asked for by mail (OI-361); **which event
  Andrea Parmeggiani's QR scanner will be ready for** (OI-323).
- **A list of the Aziende with more than one flagged principal contact** (OI-372).
- **Which cleanup option, A or B, for the 50,000 referenti leads**, the handling
  rule for rows whose Mexal code matches no Azienda, and a written basis for the
  marketing consent set on all of them (OI-351).
- **A corrected mail to the client** replacing the 11/11 approval that describes
  fake values which will never exist (OI-352).
- **Whether `numero tranche` and `tipo biglietto` are now defined per article**,
  and the reply owed to Fabrizio Paganelli on the registry (OI-329).
- **The contract with the missing third signature**, circled, which the client
  agreed to send (OI-336).
- **Whether the ticket flow's `Recipient_Contact__r` query was ever fixed** —
  unmentioned for a seventh window (OI-230).
- **The written production user list by role**, the marketing and Performance Plus
  profiles, and the marketing mailbox confirmed against DNS (OI-356, OI-363).
- **Whether the six tutors completed MFA/passkey enrolment**, and whether any
  tutor now has a production user (OI-300).
- **The exact boundaries of Mexal's nightly maintenance window**, from Kreosoft
  rather than from guesswork (OI-334).
- **The picklist workbook** (OI-265, **twenty-seventh day**) — ⚠ the rows it
  answers have been marked `SI` without it.
- **Whether Pienissimo holds a Zoho contract past 31 October** — **twenty-fifth
  run**, twenty days after the expiry date.
- **The twelve `PLUS_B` values** (nineteenth day) · **what
  `lead-web-to-lead (2).html` is** (eighteenth day, Rexhina Hysi, never
  answered) · **whether the standing 30/07 marketing follow-up notes exist at
  all**.
- **Who created fields and changed a layout in Prod without telling anyone** —
  raised by Aurel Mrruku in the ROMI DM on 13/11; nothing records what else
  changed.

## Written back

- **5 new item notes**: **OI-379, OI-380, OI-381, OI-382, OI-383**. **Next free id
  384.**
- **1 new meeting note**: [INTERNA Check Report](../meetings/2026-11-20%20INTERNA%20Check%20Report.md),
  drilled from the full transcript (~6k).
- **1 new person note**: [Angelo Pastorelli](../people/Angelo%20Pastorelli%20-%20ROMI%20legal%20representative.md).
- 🔑 **1 person note renamed**: `G Lanzetti` → **[Giuliano Lanzetti](../people/Giuliano%20Lanzetti%20-%20CEO%20of%20both%20Pienissimo%20companies.md)**,
  `uncertain: first name` **lifted**, and **7 link sources updated** — `MAP.md`,
  three traces, the 30/10 meeting note, `notes/sessions/2026-Q3.md`, the June
  requirements note and the Daniela Morgese note. ⚠ The 30/10 attendance question
  is **not** settled by the name and is explicitly left open.
- **8 notes updated** (`updated:` bumped): OI-342, OI-370, OI-373, OI-374, OI-375,
  OI-376, OI-377, OI-378, plus [the Fase 2 offer](../The%20Fase%202%20offer.md) and
  [Daniela Morgese](../people/Daniela%20Morgese%20-%20Pienissimo%20direction.md).
  **No status changes** — OI-377 stays `in-progress` because the build cures
  neither the missing clause nor the missing requirement, and OI-376 stays `open`
  because the freeze has no lift date.
- **MAP.md** — new nightly entry at the top, `Last updated` chain extended.
- **INDEX.md** — 5 item rows in the gating section, 1 meeting row, 1 trace row,
  2 person rows, note count 628 → 647 (the figure was stale by more than this run added).
- **`meetings/open-items.md` and `.it.md`** — **5 new rows each** (#379-#383) and
  **8 regenerated rows** each (#342, #370, #373, #374, #375, #376, #377, #378).
- **`meetings/DEVELOPMENT-RECAP.md` and `.it.md`** — new **§86** in both.
- **This trace**, and a `JOURNAL.md` entry.
- **Register untouched — v1.6.** ⚠ Three things ROMI now treats as owed have no
  requirement in it.
- **No credentials, prices, article codes or personal data were copied.** No euro
  figure from the PEC or from either Fase 2 offer version was transcribed.
