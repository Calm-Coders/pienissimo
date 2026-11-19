---
id: trace-2026-11-19-nightly
type: reference
status: active
updated: 2026-11-19
watermark_used: 2026-11-18T22:00Z
external_watermark: 2026-11-19T22:00Z
account: a.mrruku@romicompany.com
---

# Source trace 2026-11-19 nightly

**Watermark for the next `requirements-check` run: 2026-11-19T22:00Z, single
value.**

**Watermark used: 2026-11-18T22:00Z**, the `external_watermark` stated by
[the 18/11 nightly trace](Source%20trace%202026-11-18%20nightly.md), selected by
`updated:` frontmatter. Scheduled nightly run, executed 2026-11-19 ~21:45Z.
**One day.**

🔑 **The headline: Pienissimo has sent ROMI a PEC dated 17 November contesting the
whole Salesforce implementation, suspending the 16 November go-live, placing ROMI
in default under artt. 1454 and 1662 c.c. and contesting «fase 2» in full. Fase 2
is stopped, every other thread is frozen, the project manager is barred from
client contact, and nobody from Pienissimo came to the final marketing test the
same morning.**

🔴 **It was found in Slack, not in mail.** The PEC itself is in no source this
account can reach.

🟢 **Environment note.** The clone opened on **`main`** (two commits, config only)
with none of the knowledge layer in the working tree; `DevMain` did not exist
locally and `git checkout DevMain` failed until `git fetch` had run. **Thirty-seventh
run, same opening pattern.** Working tree **clean** at start, `DevMain` at
**`1a46bf2`**.

## Sources searched

| Source | Query / scope | Result |
| ------ | ------------- | ------ |
| **Gmail** | `pienissimo after:2026/11/18 -in:draft`, 50 requested | **5 threads**, **4 past the watermark** — all **calendar or auto-generated**: two `PIENISSIMO - Check temi PEC` invitations (07:14:59Z, then moved to 10:00), the `[PIENISSIMO] - Interna Check Report` invitation for **20/11 09:30** (09:31:46Z), and the Gemini notes mail for the marketing test (08:50:34Z). 🔴 **Not one message from anyone at Pienissimo** |
| **Gmail** | `after:2026/11/18 (pienissimo.com OR pienissimo.pro OR "ROMI-PIENISSIMO" OR kreosoft OR anticipay OR mexal OR docusign OR biglietto OR referenti OR salesforce)`, 50 requested | **21 threads**, **0 new and Pienissimo-relevant** beyond the calendar items above. 🔴 **Nothing from Kreosoft, DocuSign or Anticipay** — a fourth window. Excluded: 247.it (`RECEPTION: Checked In`, Assistant profile, org-wide address), Life365, Zucchet/3CX, VISION, VFL1, Wi Legal / SHR Italia, Daze, Permo, Salesforce newsletters and partner mail, a ROMI internal invoicing thread |
| **Gmail** | `after:2026/11/18 (sabatino OR elisa OR montesi OR paganelli OR parmeggiani OR morgese OR merendi OR mastracci OR spini OR preventivo OR fattura OR woocommerce OR biglietti OR evento OR contratto OR ordine)`, 50 requested | **14 threads**, 🔴 **again nothing from the client**. Only ROMI-internal and other-project mail |
| **Gmail** | `after:2026/11/17 (PEC OR contestazione OR diffida OR "messa in mora" OR 1454 OR 1662 OR legale OR avvocato OR golive OR "go-live")`, 30 requested | 🔴 **6 threads, none of them the PEC.** **The PEC is not in this mailbox**, in any form — not as a forward, not as an attachment. It went to a ROMI PEC address or to legal, and reached this project only by voice and Slack |
| **Slack** | `slack_read_channel C0B5T3RB4FM` (`#tproj-pienissimo`), `oldest` 1795039200 | 🔴 **0 messages.** Nothing since Elena Spini's status post of 13/11 — **seven days** |
| **Slack** | `slack_read_channel C0BQD34LLF4` (ROMI dev group), same bound | 🔴 **0 messages.** Not even this session's own report of 18/11 is answered; **no human has ever replied to a nightly report** |
| **Slack** | `slack_read_channel C0C38JJ9D1T` (marketing group DM), same bound | 🔑 **14 messages, 07:59:31 → 10:08:26 CET.** **This is where the PEC was disclosed**, at **08:00:26** and **08:01:05**, with the subject line pasted verbatim → OI-375 |
| **Slack** | `slack_read_thread C0C38JJ9D1T 1795075540.855779` | 🔑 **9 replies, 09:09 → 09:25 CET.** Aurel Mrruku asks _"devo fermarmi su questo progetto?"_; Elena Spini on the release, _"non avrei fatto un rilascio cosi … hanno l'ennesima cosa in piu"_ and _"e contestano pure"_ → OI-374, OI-376 |
| **Slack** | `slack_read_thread C0C38JJ9D1T 1795079086.945359` | **1 reply.** Logistics only |
| **Slack** | `slack_read_channel D0B5QHS2T7H` (Elena Spini DM), same bound | 🔑 **18 messages, 10:46:08 → 11:52:32 CET.** The freeze instruction in three lines — _"niente PROD per i report/dashboard"_, _"facciamo solo UAT"_, _"per R0 pure confermato da lasciare, il resto fermi tutti"_ → OI-376. The rest is Zucchet and Life365, other projects |
| **Slack** | `slack_read_canvas F0BD2H5A9HT` (`Link utili Pienissimo`) | **Unchanged.** Newest entry still 20.08.2026 — **91 days**. Re-read per the skill |
| **Drive** | `modifiedTime > '2026-11-18T22:00:00Z' and trashed = false`, 40 files, `modifiedTime desc` | **14 files**, 🔑 **five Pienissimo**: the two 19/11 meeting documents with their shortcut folders, and **`Modifiche flussi Sales`** at 07:30:07Z. The rest excluded — Permo, 247.it, VISION/Mulesoft, ADM, Business Blueprint Vision |
| **Drive** | `(title contains 'Pienissimo' or 'PEC' or 'Fase 2' or 'contestazione') and modifiedTime > watermark` | **6 hits**, the two meeting documents and their folders and shortcuts. 🔴 **No copy of the PEC in Drive**, under any of those titles |
| **Drive** | `read_file_content 1JYjYFQo3gF8_gKOZu85NgX6fCvlPhq-BmEqGbc2FO_A` | 🔑 **`PIENISSIMO - Check temi PEC`, 00:25:09, read in full.** The meeting that stopped the project → [the note](../meetings/2026-11-19%20INTERNA%20Check%20temi%20PEC.md) |
| **Drive** | `read_file_content 1RTKSJo0ie-x6yddcTxRSq6Tift7aiWvOD-hHih1OZ7A` | 🔑 **`[ROMI-PIENISSIMO] - Test Finale Flusso MKT`, Gemini notes + transcript, 00:14:29, read in full.** Client no-show → [the note](../meetings/2026-11-19%20Test%20Finale%20Flusso%20MKT.md) |
| **Drive** | `read_file_content 1y4DeVJEjd3g5vPo-LqYyczQbc0BRp9jVfVw9RJA7Yh8` with comments | 🟢 **The client change sheet, read in full: `A1:E21`, 19 rows.** `Lavorato` now **7 `SI` / 4 `IN LAVORAZIONE` / 2 `NON SI FA` / 6 blank**; modified **by Elena Spini**. No anchored comments → OI-344 |
| **Fathom** | `list_meetings created_after 2026-11-18T22:00Z`, 3 pages, summaries on | 🔴 **0 meetings. Nothing at all, a fortieth consecutive run** — on a day with two recorded Google Meet calls |
| **Git** | `fetch`, `checkout DevMain`, `pull`, `log --all --since` | **1 commit in the window:** `026cc33`, _"Reports, Dashboards and Home Page Layout edits"_, **Anita Aga**, 17:52:37+01:00, on **`DevAnita19`** — **unmerged**. `DevMain` unchanged at **`1a46bf2`**. Tree **clean** at start |
| **Repo** | `JOURNAL.md` head, `MAP.md` head, `ls notes/items` max-id scan | Watermark and state confirmed. Max existing id **378** after this run; **next free is 379** |

## Found

1. 🆕🔴🔑 **[The client sent a PEC contesting the implementation and suspending the
   go-live](../items/OI-375%20Pienissimo%20sent%20a%20PEC%20contesting%20the%20implementation%20and%20suspending%20the%20go-live.md)**
   — **OI-375**. Dated **17 November**, subject _"Formale contestazione delle
   attivita di implementazione Salesforce – Sospensione del golive del 16 novembre
   2026 – Messa in mora e diffida ad adempiere ai sensi degli artt. 1454 e 1662
   c.c. – Contestazione della cosiddetta «fase 2»"_. Grounds as ROMI recounts
   them: reports/dashboards (conceded contractual), marketing training, and all of
   Fase 2 claimed to sit inside the Fase 1 contract; the 16/11 go-live is itself
   contested. ⚠ **The document was not read** — not in mail, not in Drive — and
   🔴 **its deadline is unknown**, though art. 1454 operates by one.

2. 🆕🔴 **[Everything is frozen except a reports remediation](../items/OI-376%20All%20Pienissimo%20work%20is%20frozen%20except%20reports%20and%20dashboards.md)**
   — **OI-376**. _"Il resto fermi tutti."_ Anita Aga told _"di non toccare piu
   niente su pianissimo"_; Fase 2 stopped; **R0 left in production _"per ora"_**;
   one carve-out, **UAT only, explicitly not Prod**, for internal review 20/11
   09:30. ⚠ A process disagreement about configuration-in-production is on the
   record and unresolved.

3. 🆕🔴 **[Reports and dashboards were never built and have no requirements](../items/OI-377%20Reports%20and%20dashboards%20were%20never%20built%20and%20have%20no%20requirements.md)**
   — **OI-377**. _"Le dashboard che mancano, che sono nel contratto e mancano"_ and
   _"non c'hanno dato nessun requisito"_. The only requirement is one sentence from
   Marco Montesi, who has resigned. ⚠ **The contract clause has never been
   recorded in this repository** and the register holds no reporting requirement.

4. 🆕🔴 **[Marketing training is undelivered and the client did not attend the final test](../items/OI-378%20Marketing%20training%20is%20undelivered%20and%20the%20client%20did%20not%20attend%20the%20final%20test.md)**
   — **OI-378**. The marketing half is conceded and gets a calendar; the commercial
   half is asserted as five-plus days of eight hours against a contractual 20, and
   ⚠ **no training record exists here at all**. Same morning, five Pienissimo
   addresses invited to `Test Finale Flusso MKT` and **none attended**; both flows
   were finished and a self-service test pack was ready and unseen, with the offer
   to mail it **unassigned**.

5. 🔴 **The project manager is barred from client contact** — _"ormai non posso piu
   parlare con il cliente"_, approvals via **Giancarlo** and **Angelo** → OI-348.
   ⚠ Neither surname is established and no replacement counterpart is named.

6. 🟢 **[Two rows closed on the client's change sheet](../items/OI-344%20The%20client%20sent%20sixteen%20Sales%20flow%20changes%20and%20none%20is%20triaged.md)**
   — `Categorie` and `Sottocategorie`, `IN LAVORAZIONE` → `SI`, **seven of
   nineteen done**, edited at 07:30:07Z **by Elena Spini — the first ROMI-hand
   edit of that file**. ⚠ Unconfirmed by the client; the mandatory-field half is
   still an unruled v1.7 candidate. 🆕 Column A is `Priorita` with `1` on four
   rows and row 5 now adds _"+ rinominare fonte in origine"_ — ⚠ neither dated.
   🔴 The four `IN LAVORAZIONE` rows are halted mid-work by the freeze.

7. 🟡 **[The date format has an account at last](../items/OI-358%20The%20org%20is%20not%20set%20to%20Italian%20date%20and%20number%20formats.md)**
   — announced to the client on Monday 16/11, shipped deliberately with the 18/11
   release, contract due before the 24th. An **org-level Locale change is not
   metadata**, which is exactly why the 60-file delta could never show it. ⚠ Still
   an account, not a verification.

8. 🟢 **[The Mexal panel's provenance is established](../items/OI-370%20The%20client%20cannot%20run%20the%20Mexal%20syncs%20by%20hand.md)**
   against a direct challenge: a **button panel, not a dashboard**, **requested by
   Fabrizio Paganelli** verbally and in writing on 16/11, built **UAT → Prod**.
   🔴 Its two commitments are unmet a third day and now have nobody to send them.

9. ⚠ **[ROMI's own project manager would not have made the 18/11 release](../items/OI-374%20The%2018%20November%20release%20mail%20tells%20the%20client%20the%20order%20contract%20flow%20is%20live.md)**
   — _"ma avevate fatto i test di questa parte? non mi aspettavo un rilascio"_;
   _"non avrei fatto un rilascio cosi … hanno l'ennesima cosa in piu"_. 🟡 The date
   objection resolved on Aurel Mrruku's Monday confirmation; 🔴 the testing
   objection was never answered.

10. 🔑 **ROMI's defence is the meeting record.** _"Abbiamo tutto registrato"_, twice
    from Aurel Mrruku, and the same advice relayed from Angelo. That is what the
    preserved transcripts and the per-meeting notes in this repository are for, and
    it is the first time their evidential purpose has been stated out loud.

## Not done, and why

- 🔴 **The PEC was not read.** Four search formulations across the mailbox and two
  across Drive returned nothing. **Everything recorded about its contents is one
  person's spoken account**, and this is flagged on every artifact that carries it.
  **Its deadline is the single most important unknown on the project.**
- **The org was not opened.** `STATUS.md` and its Notion mirror are **stale**; the
  sweep moved the live position and step 6 of `org-status-check` was **not** run.
  ⚠ This matters for the date-format claim, for DocuSign in Prod, and for whether
  the UAT reports work exists.
- **No Apex test class was written or proposed.** Standing instruction. OI-64,
  OI-66 and [the deploy risk](../risks/Risk%20-%20production%20deploy%20is%20blocked%20by%20Apex%20coverage.md)
  are unchanged and were not acted on.
- ⚠ **`026cc33` was not inspected beyond its subject line.** It is unmerged on
  `DevAnita19` and its title — _"Reports, Dashboards and Home Page Layout edits"_ —
  matches the OI-377 remediation, but **nothing in any source connects the commit
  to that work** and the branch was not read.
- ⚠ **`Business_Blueprint_Pienissimo.docx` was not read**, a fourth window. It did
  not change today.
- ⚠ **Elena Spini's change workbook of Friday 13/11 was again not found** — a
  **fourth** window. It was due **Friday 20/11**, tomorrow, and the freeze now
  overtakes it.
- **The Fase 2 offer V.4 was not re-read.** No Drive edit in the window.
- **No customer-data workbook or attachment was opened.** None was offered.
- **No euro figures transcribed.** The PEC's claimed additional amount for Fase 2
  was spoken on the call and is **not reproduced**, per the standing rule and the
  precedent set for the Fase 2 offer.
- **OI-336, OI-345, OI-347, OI-350 to OI-357, OI-359 to OI-369, OI-371, OI-372
  were not updated** — **no new evidence in this window**. ⚠ Many are now frozen
  rather than open.
- **The requirement register was not touched** — stays **v1.6**. ⚠ If reports and
  dashboards are contractual they belong in it; nothing is agreed. The OI-344
  mandatory picklists, the OI-329 tranche obligation, the OI-359 interruption case
  and the OI-358 locale change remain **v1.7 candidates**; none is agreed.
- **247.it, Life365, Zucchet / 3CX / DF Solutions, VISION / VapeItalia, VFL1,
  Permo, Wi Legal / SHR Italia and Daze were excluded** — other projects, per the
  skill. ⚠ Note that Elena Spini spent much of 19/11 on Zucchet and Life365, which
  is itself consistent with the Pienissimo freeze.
- **`prettier:verify` was not run** (not executable in this environment, as on
  previous runs).

## Still unreachable

Named precisely enough to ask someone for them:

- 🆕🔴 **The PEC of 17 November itself** — its full text, its heads of claim and
  above all **the term it fixes under art. 1454 c.c.** Ask Elena Spini, Gianpaolo
  Motta, or whoever holds ROMI's PEC mailbox.
- 🆕 **The contract clause that makes reports and dashboards a deliverable**,
  quoted, and the contractual training provision behind the 20-hour figure
  (OI-377, OI-378).
- 🆕 **The surnames and roles of "Angelo" and "Giancarlo"**, who now approve
  anything that reaches the client, and **who may write to the client at all**
  (OI-375, OI-348).
- 🆕 **ROMI's training record** — dates, hours, attendees, recordings — which the
  PEC's second ground turns on and which does not exist here (OI-378).
- 🆕 **Why nobody from Pienissimo joined the 19/11 marketing test**, and Matteo D's
  answer to Fabrizio Mastracci on the landing pages (OI-378).
- 🆕 **Whether `026cc33` on `DevAnita19` is the OI-377 remediation**, and whether
  the UAT reports exist (OI-377).
- **Whether DocuSign is actually configured in production for the order PDF
  attachment**, with a date and a name (OI-374, OI-373) — second day.
- **Whether any real WooCommerce order has ever been taken end to end in
  production** — second day, six days before Pienissimo Live.
- **Whether a production quote PDF now prints an Italian date** — now explained
  but not verified (OI-358).
- **Whether the three Mexal schedulers in production run as `amministratore
  pienissimo`** (OI-301, OI-334), and **the written run instructions and the
  job-times mail to Sabatino Rinaldi** — third day, now with no sender (OI-370).
- **Elena Spini's change workbook of 13/11**, due Friday 20/11 — a fourth window.
- **Whether ROMI accepts or contests the Blueprint claim** — **no reply in
  fourteen days** (OI-343) — and `OP-1`, `OP-2`, `OP-4` of the R0 analysis, a
  sixteenth day.
- **Which articles the live WooCommerce shop sells**, set against those
  deactivated on 15/11, and whether the deferred retest ever passed (OI-366) — no
  report in four windows.
- **What changed in `Business_Blueprint_Pienissimo.docx` on 16/11**, and who
  changed it.
- **Leaving dates and successors for Marco Montesi and Sabatino Rinaldi**, and who
  inherits the WooCommerce plugin configuration and the shop credentials ROMI does
  not hold (OI-357) — ⚠ Marco Montesi is also the only source of the one reports
  requirement that exists (OI-377).
- **Fabrizio Mastracci's go-ahead on the Pienissimo Live forms**, and **which
  field they write for the marketing consent** (OI-371, OI-340 — **seventh
  window**).
- **The restore date for the event end dates**, with an owner, before 309 ready
  invitations either stay silent through Pienissimo Live or all send at once
  (OI-353).
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
  unmentioned for a sixth window (OI-230).
- **The written production user list by role**, the marketing and Performance Plus
  profiles, and the marketing mailbox confirmed against DNS (OI-356, OI-363).
- **Whether the six tutors completed MFA/passkey enrolment**, and whether any
  tutor now has a production user (OI-300).
- **The exact boundaries of Mexal's nightly maintenance window**, from Kreosoft
  rather than from guesswork (OI-334).
- **The picklist workbook** (OI-265, **twenty-sixth day**) — ⚠ the rows it answers
  have just been marked `SI` without it.
- **Whether Pienissimo holds a Zoho contract past 31 October** — **twenty-fourth
  run**, nineteen days after the expiry date.
- **The twelve `PLUS_B` values** (eighteenth day) · **what
  `lead-web-to-lead (2).html` is** (seventeenth day, Rexhina Hysi, never
  answered) · **whether the standing 30/07 marketing follow-up notes exist at
  all**.
- **Who created fields and changed a layout in Prod without telling anyone** —
  raised by Aurel Mrruku in the ROMI DM on 13/11; nothing records what else
  changed.

## Written back

- **4 new item notes**: **OI-375, OI-376, OI-377, OI-378**. **Next free id 379.**
- **2 new meeting notes**: [INTERNA Check temi PEC](../meetings/2026-11-19%20INTERNA%20Check%20temi%20PEC.md)
  and [Test Finale Flusso MKT](../meetings/2026-11-19%20Test%20Finale%20Flusso%20MKT.md),
  both drilled from their full transcripts.
- **9 notes updated** (`updated:` bumped): OI-246, OI-342, OI-343, OI-344, OI-348,
  OI-349, OI-358, OI-370, OI-374. **No status changes** — OI-349 stays `gating`
  because the client's own claim would make the same work due under Fase 1, and
  OI-370 stays `in-progress` because its two commitments are still unmet.
- **MAP.md** — new nightly entry at the top, `Last updated` chain extended.
- **INDEX.md** — 4 item rows in the gating section, 2 meeting rows, 1 trace row.
- **`meetings/open-items.md` and `.it.md`** — **4 new rows each** (#375-#378) and
  **9 regenerated rows** each (#246, #342, #343, #344, #348, #349, #358, #370,
  #374).
- **`meetings/DEVELOPMENT-RECAP.md` and `.it.md`** — new **§85** in both.
- **This trace**, and a `JOURNAL.md` entry.
- **Register untouched — v1.6.**
- **No person note was written.** ⚠ Four people appear whose identity is not
  established — **Angelo**, **Giancarlo**, **Matteo D** and **Rebecca M** — and
  the rule against fabricating an attribution means none gets a note until a
  surname and a role exist. They are named as unreachable instead.
- **No credentials, prices, article codes or personal data were copied.** The
  PEC's claimed additional amount for Fase 2 was **not transcribed**.
