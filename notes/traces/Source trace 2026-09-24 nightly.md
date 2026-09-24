---
id: trace-2026-09-24-nightly
type: reference
status: active
updated: 2026-09-24
watermark_used: 2026-09-23T22:00Z
external_watermark: 2026-09-24T22:00Z
account: a.mrruku@romicompany.com
---

# Source trace 2026-09-24 nightly

**Watermark for the next `requirements-check` run: 2026-09-24T22:00Z, single value.**

**Watermark used: 2026-09-23T22:00Z** — the `external_watermark` of
[the 23/09 trace](Source%20trace%202026-09-23.md), the newest note in this folder by
`updated:`.

**The first day of client acceptance.** The session the last three runs pointed at
happened, and the chain ran end to end. Three armed triggers came due at once and **all
three are discharged**. A tenth artifact appeared at 18:10Z that no source in this record
had ever mentioned.

## Sources searched

| Source | Query / scope | Result |
| ------ | ------------- | ------ |
| **Gmail** | `pienissimo after:2026/09/23 -in:draft`, 40 requested, 15 estimated | 🔑 **6 in-window threads** — 2 Gemini meeting-note mails, 1 sandbox Apex exception, 1 new natura thread, 1 invitation, plus 3 new messages on `Ordine cliente` |
| **Gmail** | threads `1a0d2a5b5a12fe61` and `1a0c9d4a7c6c7850` **read in full**, plus messages `1a0d299b77136f03` and `1a0d2e3b2856b15f` | 🔑 §3 (the natura confirmation), §4 (the Mexal API names and the two attachments) |
| **Slack** | workspace-wide incl. private + DMs, `after:2026-09-23`, by timestamp, 20 results | 🔑 §5 (the BBP announcement), §6 (the MKT/PROD blocker) |
| **Slack** | DM `D0B5QHS2T7H` (Elena Spini), full window from 23/09 22:00Z, 37 messages | 🔑 **_"nulla mette solo rt diretta"_ at 15:43:58**, the stalled MKT hand-off at 08:38, the agent-code anomalies at 14:34 |
| **Slack** | `C0BQD34LLF4` (dev group), full window | **one message: this job's own 23/09 report at 00:03:04.** No human post in the window, and **no human has answered a nightly report in eight nights** |
| **Slack** | `#tproj-pienissimo` (`C0B5T3RB4FM`), from 23/09 22:00Z | **empty** — no post in the window, second run running |
| **Drive** | `modifiedTime > '2026-09-23T22:00:00Z'`, 2 pages, 27 files | 🔑 **two meeting artifact sets**, 🔑 **`Business_Blueprint_Pienissimo.docx` (new)**, the data-model workbook, **`Flows & Objects.drawio` moved**, four client migration workbooks re-saved |
| **Drive** | **three documents read in full** — UAT notes+transcript (155,961 chars), Temi Mexal notes+transcript (22,253), `Business_Blueprint_Pienissimo.docx` (49,165) | 🔑 §1, §2, §5 |
| **Fathom** | `list_meetings created_after 2026-09-23T22:00Z`, 3 pages | **0 meetings.** Nothing to exclude and nothing to drill |
| **Git** | `fetch --all --prune`, `log --all --since`, 6 commits inspected, 3 branches compared for agent fields | 🔑 §7 |
| **GitHub** | `list_pull_requests state=all`, 8 newest by `updated` | **#57 merged 07:12Z, #58 merged 07:15Z; #59 open (08:06Z), #60 open (13:49Z)** |
| **Repo** | `AGENTS.md`, the skill, the write protocol, `MAP.md`, `INDEX.md`, the 23/09 trace, `JOURNAL.md`, the register's quote state machine, OI-96, OI-151, OI-163, OI-164, OI-168, OI-173, OI-174 | read directly |

## Found

### 1. 🟢🔑 The first acceptance session, and nothing in it was rejected

[UAT: Lead e Opportunità](../meetings/2026-09-24%20UAT%20Lead%20e%20Opportunita.md),
15:00 CEST, ~2h08m. Lead in by form → conversion → opportunity → quote → tranche → PDF →
Community acceptance → DocuSign signature → order, **demonstrated end to end** with
Marco Montesi, Fabrizio Paganelli and Sabatino Rinaldi in the room.

**Twelve rulings agreed**, among them the agent mandatory to reach `Qualificato`,
one named person receiving leads rather than a queue, the primary quote, close date as
the last day of the following year, tranche totals on screen, unit of measure in the PDF,
the agent's name as sender plus a CC field, 🔑 **the new `Firmato` quote state** with the
order generated at it, and Closed Won only at incasso.

⚠ **One thing was reopened: the word `rifiutato`.** The mechanism is agreed; Fabrizio
Paganelli and Marco Montesi both objected to the label, and no alternative was chosen.
The Gemini notes file it under _"Da approfondire"_.

### 2. 🟢🔑 OI-173 resolved in 22 minutes, and the tables arrived the same morning

[Temi Mexal Anagrafiche/Indirizzi](../meetings/2026-09-24%20Temi%20Mexal%20Anagrafiche%20Indirizzi.md).
The rule keys on **`residenza fiscale` derived from the two-letter ISO code on the
`ragione sociale`, not the billing address** — Fabrizio Paganelli: _"se il cliente è
estero ma c'ha un punto vendita in Italia vale il cliente estero."_ Three Mexal fields
for Italian customers (and, in future, San Marino): `gest_fatt_el`, `serie_fatt_el` = 3,
`cod_modu_allega` = `FT`. Extra-EU left blank. It lives as a Salesforce table the
administration maintains, with a trigger populating the rest.

🔑 New scope, explicitly **not** Fase 1 build work: `data inizio/fine competenza
contabile` on the order line (`dt_inizio_rateo`, `dt_fine_rateo`), headroom for future
subscription products. 🔴 And a **synchronisation constraint with no owner**: a payment
type added in Mexal must be added in Salesforce by hand with the same nomenclature.

### 3. 🟢 The client confirmed the natura codes in writing — and sent a screenshot again

Aurel Mrruku → Fabrizio Paganelli, 24/09 09:08:17Z, stating the ROMI reading back for
confirmation. Fabrizio Paganelli, 10:16:44Z: the three codes confirmed, **no code carries
the fourth combination today but it will be handled**.

⚠ **The two named the fourth code differently** — Aurel Mrruku asked about `OB`, Fabrizio
Paganelli answered about `NB`. 🔴 The list itself arrived as `image001.png`, **the third
screenshot-only delivery, unreadable by any tool here.** →
[OI-154](../items/OI-154%20The%20client%20import%20extraction%20is%20missing%20the%20article%20classification.md)

### 4. 🟢🔑 The Mexal API field names, and two transcoding attachments

Mirko Merendi, 08:46:51Z — order `id_pagamento`, `codice_agente`,
`dt_inizio_rateo`/`dt_fine_rateo`; customer `cod_agente`, `cod_zona`, `cod_cat_pr`,
`cod_paese`, `tp_nazionalita`, `gest_fatt_el`, `serie_fatt_el`, `cod_modu_allega`, and
🔑 **`valuta` and `cod_listino`, both mandatory on create and fixed to `1`** — a
constraint new to this record. Aurel Mrruku acknowledged at 09:16:35Z.

Fabrizio Paganelli, 10:08:51Z, attaching **`Nazioni e Residenza Fiscale.xlsx`** and
**`Codici Pagamento.xlsx`** (_"sono solo 4"_; he said five in the call). 🟢 **Neither was
opened** — their existence, sender, time and stated contents are recorded, not their
values.

### 5. 🔑 NEW — a Business Blueprint nobody had mentioned

`Business_Blueprint_Pienissimo.docx`, created **24/09 18:10:03Z** by Elena Spini, read in
full. Ten chapters, ROMI letterhead, **a signature block for ROMI Srl and Pienissimo Srl**.
Announced in the group DM at 20:12:48 CEST — _"sto per vomitare BUT Habemus BPP signori"_ —
with delivery to the client intended for **25/09**.

🔴 Seven `● Check con Aurel` markers, three `[Open Points]`, and content new to the
record: two WooCommerce instances, legacy QR codes dying with Zoho at the client's cost,
signed PDFs on external storage for the 10 GB limit, a credit-note button, 20 hours of
training, one month of post-go-live support, a credentials-retention clause, four
profiles with a role hierarchy. 🔴 **It omits `Firmato` from its own quote-state table**
and states as settled both the OI-166 join and the whole OI-168 Contratto.
→ [OI-179](../items/OI-179%20The%20Business%20Blueprint%20goes%20to%20the%20client%20with%20unchecked%20points.md)

### 6. 🔴 Three new structural findings from Slack and the session

- **The client has no UAT logins**, gated on Daniela Morgese's review, indicatively 6
  October — the day the UAT window closes →
  [OI-180](../items/OI-180%20Client%20UAT%20users%20are%20withheld%20until%20a%20director%20review.md).
- **The marketing UAT needs production** (Elena Spini, 20:18 CEST), and the Aurel Mrruku ↔
  Fabrizio Mastracci hand-off is stalled with each waiting on the other →
  [OI-177](../items/OI-177%20The%20marketing%20flow%20UAT%20needs%20production.md).
- **Every form lead is typed `Diretta`** (Elena Spini, 15:43:58 CEST, mid-session) →
  [OI-176](../items/OI-176%20Web%20to%20Lead%20assigns%20every%20lead%20the%20Diretta%20record%20type.md).

### 7. The build: 2 merges, 2 new PRs, 6 commits

| Commit | Author | CEST | Where |
| ------ | ------ | ---- | ----- |
| `3647463` / `1302fb5` | Anita Aga / aureliii | 09:11–09:12 | 🟢 **PR #57 merged** |
| `74be406` | anitaaga | 09:15 | PR #58, `DevMain` → `DevAnita` sync |
| `ec2dcfe` | Rexhina | 10:02 | `DEV_LeadAgenteBundle` — **the Lead path assistants and `Require_Tipo_Opp_When_Qualificato`** |
| `0977713` | Rexhina | 10:57 | `DEV_LeadAgenteBundle` — quote controllers, `QuotePdfController` |
| `64b2843` | Aurel Mrruku | 13:03 | 🟢 **`DevMain` head — "Inserted accounts"** |
| `bfd0fd3` | Anita Aga | 15:47 | `DevAnita` — **`MappaturaEdizioneTriggerHandler` rewritten** |
| `ed6ec24` | Anita Aga | 15:51 | `DevAnita` — flexipages and layouts |
| `c99f2e6` | Anita Aga | 18:20 | `DevAnita` — bundle logic across the quote stack, +453 lines on `Full_Permission` |

🟢 **`DEV_LeadAgenteBundle` has a pull request — #59, opened 08:06Z.** The 23/09 "no PR"
flag is discharged; it is still unmerged. **PR #60** (`DevAnita` → `DevMain`) opened
13:49Z.

⚠ **`64b2843` contradicts its own JOURNAL entry.** The 24/09 codex entry it carries ends
_"No commit or push was made"_ — and the commit exists, on `DevMain`, containing that
sentence. Recorded, not corrected: the entry is another agent's handoff and the facts
around it are in this trace.

🔴 **`Standart` is unchanged** — 7 occurrences across 6 files on `DevMain`, including the
Opportunity record-type API name. **UAT records are being created now.**
`without sharing` is unchanged at **19 classes** (verified against `301b22a`, `61f2a53`
and `64b2843` — identical sets, no new ones this window).

### 8. Excluded as other clients

**247** (`SALESFORCE_247` folder, `BRAND LIST gender.xlsx`) · **Vision**
(`Personalizzazioni B2B Vision`, `Azioni Backoffice`, `Agentforce_Domande_Analisi_Cliente`,
all `d.losco@`) · **BE.MA** (`BE.MA - Role Hierarchy`, `r.singh@`) · **permo**
(`Flussi di Integrazione [permo][shared]`, `m.lecca@`) · `Domande incontri.xlsx`
(`p.dicaprio@`, same folder as the Vision material) · **LIFE365** (its own nightly job
posted at 23:38 CEST in a different group DM). Not ingested, by the convention the
18/08, 31/08, 01/09, 21/09, 22/09 and 23/09 traces applied.

## What it changed

**Two meeting notes, five items created, fourteen items updated.**

| Written | Because |
| ------- | ------- |
| 2 × `notes/meetings/` | the two sessions drilled |
| `OI-176`–`OI-180` | five findings with no existing row |
| `OI-164`, `OI-173` | **RESOLVED** |
| `OI-96`, `OI-151`, `OI-154`, `OI-157`, `OI-158`, `OI-159`, `OI-163`, `OI-165`, `OI-166`, `OI-168`, `OI-169`, `OI-174` | moved by this window |
| `MAP.md`, `INDEX.md` | the live position, 7 new rows, this trace |
| `open-items.md` / `.it.md` | **rows 176–180 new; rows 96, 151, 154, 157, 158, 159, 163, 164, 165, 166, 168, 169, 173, 174 updated — both languages** |
| `DEVELOPMENT-RECAP.md` / `.it.md` | §47, both languages |

**The register was not touched, and this time that is a judgement call worth stating.**
The client agreed a **sixth quote state, `Firmato`**, which is exactly the kind of change
`state_machines.quote` exists to hold. But that block **already carries a flag saying it
disagrees with the org's five values and is "flagged for a human"** — adding a sixth value
to a list wrong in five places makes the register less accurate, not more, and it is
contract-bound. **The reconciliation is owed to a human and is now six values behind, not
five.** The Business Blueprint, the migration perimeter and the Fase 2 boundary remain new
scope with no id, by the same judgement the 22/09 and 23/09 runs made.

## Triggers

**Discharged this run — all three that came due today:**

- 🟢 **The Lead UAT trigger — discharged, and better than expected.** It said the first
  client acceptance session would test a path with two known defects. It did not:
  `OI-164` was fixed that morning, and `OI-163`'s duplicate rule not only exists but
  fired in front of the client and was validated by their own referent.
- 🟢 **The DocuSign delivery trigger — discharged by evidence.** It said that without a
  test to a client-domain address, the signature step was demonstrated on faith. **The
  test happened**: Fabrizio Paganelli received the envelope, signed, and received the
  completed PDF. The block is ROMI-side only.
- 🟢 **The `OI-169` conversion-block trigger — discharged.** The rule was put to the
  client, demonstrated, and **accepted under "Concordato"**. It also turns out to be
  narrower than the record said: the block is on `Qualificato`, not on conversion.

**Still armed:**

- 🔴 **NEW — the Business Blueprint trigger.** _`OI-179` goes to the client on 25/09 with
  seven of its own unchecked points and a quote-state table missing the state agreed the
  same afternoon. If the next run finds it delivered unchanged, say that ROMI put a
  signature-bearing document in front of the client while disagreeing with itself._
- 🔴 **NEW — the UAT-access trigger.** _`OI-180`: if the next runs show no date for
  Daniela Morgese's review, say that a four-session acceptance window is being run with
  nobody client-side able to log in._
- 🔴 **NEW — the agent-field trigger.** _`OI-178`: if PR #59 merges before the two fields
  are reconciled, Account gains two agent fields, one holding 8,140 values and one empty._
- 🔴 **The `Standart` trigger fires for the seventh run.** Unchanged, and **UAT records
  are being created now** — this is a data-permanence problem, not a cosmetic one.
- 🔴 **The edition-mapping trigger, sharper.** It is no longer a prediction: the empty
  table broke order creation twice on 24/09, once in front of the client. **13 of 51, with
  ticket UAT on 30/09.** A rewritten handler does not add rows.
- 🔴 **The migration trigger fires.** A perimeter and an entity list are not a plan: still
  no estimate, no production sequence, no cut-over owner, no new date for the postponed
  orders/migration session. Go-live 21/10, Zoho off 31/10.
- 🔴 **The tutor re-keying trigger is unchanged.** Marco Montesi attended a 2h08m session
  today and **nothing records him being told** that the tutors re-key every pending quote.
- 🔴 **The contract trigger is unchanged and worse.** `Contratto` is on the 5/10 agenda,
  nothing was built, and the BBP has now specified a trigger freeze, a scheduled insoluto
  report set and a page banner that were not in the record this morning.
- 🔴 **The `without sharing` trigger is unchanged** — 19 classes, nothing records why.
- 🔴 **NEW — the marketing trigger.** _`OI-177`: two people are waiting on each other with
  the session on 02/10 and the environment question unanswered._
- ⚠ **The unreadable-legend trigger is half-discharged and stays.** The client confirmed
  the semantics in plain text; the authoritative list is still a picture, and the `OB`/`NB`
  discrepancy is unresolved.
- 🟢⚠ **The `DGM-2` trigger owes a read, ninth run — but `Flows & Objects.drawio` moved
  today**, `2026-09-24T17:43:57Z`, after eight runs of no movement. **Still unreadable
  here** (`application/vnd.jgraph.mxfile`). _First movement in the whole record; say so
  and ask for an export._
- ⚠ **`MAP.md` is ~150 KB against a stated 5 KB budget** — **fourteenth consecutive flag;
  no run has been authorised to act on it.**

## Deliberately not done

- **Nothing was sent, replied to, drafted, shared, modified or marked read on any external
  source.** The single Slack report to `C0BQD34LLF4` is the one message this run posted,
  under the nightly carve-out in
  [the skill](../../.agents/skills/requirements-check/SKILL.md).
- **No Apex test class was written, proposed or scaffolded.** ⚠ Noted in passing only:
  `bfd0fd3` removes two lines from `OrderTriggerHandlerTest.cls` and `c99f2e6` adds 48.
  Not acted on.
- **The register was not amended** — see **What it changed** for why, and for what a human
  now owes.
- **[STATUS.md](../../STATUS.md) was not regenerated.** This run has **no org evidence**:
  every build claim here is repository arithmetic against `DevMain` at `64b2843`, plus one
  sandbox exception mail. The last live org read was the 23/09 morning check.
- **The org was not opened.**
- **Three recordings were not opened** — 1.3 GB for the UAT session, 102 MB for the Mexal
  call; the notes documents carried both summary and full transcript in each case.
- **No client migration workbook was opened**: `Account Salesforce_V2.xlsx`,
  `Articoli Salesforce.xlsx`, `Campagne Salesforce.xlsx`, `Referenti Salesforce.xlsx` — all
  re-saved in this window, all carrying real customer data.
- **The two `.xlsx` transcoding attachments were not opened.** Recorded by name, sender and
  time.
- **`Flows & Objects.drawio` was not read** — no tool here renders `mxfile`.
- **`Campi Oggetti, Flussi e Utenti Salesforce - Pienissimo.xlsx` was not opened**, though
  it moved at 16:18:45Z.
- ⚠ **`notes/items/OI-154` was edited this time, and this is a deliberate reversal of the
  23/09 call.** That run left the file alone to avoid handing Rexhina Hysi a conflict.
  `7eab757` is **still unmerged** (PR #59, open) and still carries a developer-authored
  33-line addition to exactly that file, so **this edit will conflict when #59 merges**.
  It was made anyway because the client's written confirmation of the natura codes is the
  answer to the question that note exists to ask, and burying it in the tracker row a
  second time would leave the note wrong on its central fact. **Both additions append at
  the end of the file and do not overlap. If the merge conflicts, keep both — the
  developers' block first.**
- **No price, article code, account code, credential, token, VAT number or personal datum
  entered the repository.** Specifically withheld: the two agent codes and the two tutors'
  names from the account-import anomaly, the quote numbers in the sandbox notifications,
  and the record ids in the session's sandbox links.

## Gaps in this run

- 🔴 **A signature-bearing Business Blueprint goes to the client tomorrow with seven of its
  own points unchecked and an internal contradiction on `Firmato`.**
- 🔴 **Every form lead is typed `Diretta`**, and the client saw it.
- 🔴 **`Firmato` does not exist, and Quote UAT is tomorrow.**
- 🔴 **The edition mapping broke the chain twice today; 13 of 51 with ticket UAT on 30/09.**
- 🔴 **The client cannot log in to the environment they are accepting.**
- 🔴 **Two agent fields, and the one the client accepted is unmerged.**
- 🔴 **The marketing UAT needs production and its hand-off is stalled.**
- 🔴 **Contract logic still not started**, now with a richer specification.
- 🔴 **DocuSign credentials still owed** — now with a named reason and a named person.
- ⚠ **`Standart` unchanged, seventh run, with UAT records being created.**
- ⚠ **No human has answered a nightly report in eight nights.** The dev-group channel had
  **no human post at all** in this window.

## Method

**The 22/09 lesson was applied and this time the summary held.** The Gemini notes for the
UAT session were checked against the transcript on four points — the record type, the
agent obligation, the duplicate rule and the DocuSign delivery — and the transcript
**corroborated the summary in all four**, while adding detail the summary had flattened
(that the agent block is on `Qualificato` and not on conversion; that Aurel Mrruku's fix
for the record type is a request for form markup, not a config change).

🔑 **What the summary did miss was outside it entirely.** The single most consequential
fact of the window — that every form lead is typed `Diretta` — is in a **Slack DM sent at
15:43:58 while the session was running**, and appears in the transcript only as an aside.
**The channel read, not the meeting artifact, caught it.** The same applies to the
Business Blueprint: it exists on Drive and was announced only in a group DM. *A meeting
record is not a day.*
