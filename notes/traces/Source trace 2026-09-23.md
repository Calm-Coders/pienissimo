---
id: trace-2026-09-23
type: reference
status: active
updated: 2026-09-23
watermark_used: 2026-09-22T22:00Z
external_watermark: 2026-09-23T22:00Z
account: a.mrruku@romicompany.com
---

# Source trace 2026-09-23

**Watermark for the next `requirements-check` run: 2026-09-23T22:00Z, single value.**

**Watermark used: 2026-09-22T22:00Z** — the `external_watermark` of
[the 22/09 trace](Source%20trace%202026-09-22.md), the newest note in this folder by
`updated:`.

**The last working day before UAT opens.** One client session of 2h29m did more to the
record than the whole four-day window of 21/09 — and the defect that opens tomorrow's
session was still live at 18:28 CEST.

## Sources searched

| Source     | Query / scope                                                                                     | Result                                                                                        |
| ---------- | ------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------- |
| **Gmail**  | `pienissimo after:2026/09/22 -in:draft`, 40 requested, 20 returned                                | 🔑 **9 in-window threads** — 1 client reply, 1 client data-file mail, 2 invitations, 1 cancellation, 2 meeting-record mails, 3 sandbox quote notifications |
| **Gmail**  | both client domains + Kreosoft in `from/to/cc`, `after:2026/09/22 in:anywhere`                    | 10 threads, all already surfaced by the keyword query                                          |
| **Gmail**  | threads `1a0c9d4a7c6c7850` and `1a0b5987f81db72c` **read in full**                                  | 🔑 §1 (OI-159 answered) and §5 (the V2 account file)                                          |
| **Slack**  | workspace-wide incl. private + DMs, `after:2026-09-22`, by timestamp, 20 results                    | 🔑 §4 (the record type still blank), §3 (DocuSign mail blocked)                                |
| **Slack**  | DM `D0B5QHS2T7H` (Elena Spini), 12 messages from 22/09 20:00Z, read in full                        | 🔑 _"il rt è sempre blank"_ 18:28:13 CEST, the 12:51 chase, and the hand-off at 18:47          |
| **Slack**  | `C0BQD34LLF4` (dev group), full window                                                             | the 10:26 org-check report, `pr done` 09:42, and **the first human posts in the channel in seven nights** — but still **no reply to a nightly report** |
| **Slack**  | `#tproj-pienissimo` (`C0B5T3RB4FM`), from 22/09 20:00Z                                             | **empty** — no post in the window                                                              |
| **Drive**  | `modifiedTime > '2026-09-22T22:00:00Z'`, 2 pages, 24 files                                         | 🔑 **two meeting artifact sets**, the V2 account file, six client migration workbooks re-saved, the data-model workbook, and a Pienissimo org chart |
| **Drive**  | **two documents read** — Check Data Import notes+transcript (165,114 chars, the largest single read of this project), Test Pre Demo transcript (16,373), plus the org chart (2,300) | 🔑 §2, §6, §7 |
| **Fathom** | `list_meetings created_after 2026-09-22T22:00Z`, 3 pages                                           | **1 meeting, and it is another client** — `SALESFORCE - aggiornamenti post prod.` with 247. Excluded |
| **Git**    | `fetch --all --prune`, `log --all --since`, 3 commits inspected                                    | 🔑 §8                                                                                          |
| **GitHub** | `list_pull_requests state=all`, 8 newest by `updated`                                               | **#55 and #56 merged 07:41Z; #57 opened 16:41Z, open; `DEV_LeadAgenteBundle` has no PR**       |
| **Repo**   | `AGENTS.md`, the skill, `drill-meeting`, the write protocol, `MAP.md`, `INDEX.md`, the 22/09 trace, OI-97, OI-146, OI-154, OI-159, OI-161, OI-162, OI-164, OI-165, OI-169 | read directly |

## Found

### 1. 🟢🔑 OI-159 was answered in twenty hours

**Fabrizio Paganelli, 23/09 12:16:50Z**, replying to Mirko Merendi's 22/09 field list by
annotating each line in place — to Mirko Merendi and `amministrazione@`, cc Aurel Mrruku,
Elena Spini, Andrea Di Cicco. _"rispondo alla mail di Mirko con alcune note. Ci aggiorniamo
domani."_

- 🟢 **Salesforce owes two order fields**: `Tipologia pagamento`, `Agente`.
- 🟢 **Five belong to the Mexal procedure**, marked _"non previsto"_: `Causale`,
  `Riferimento amministrazione PA`, `Contropartita di riga`, `Tipologia merce di riga`,
  `Valore provvigione agente di riga`.
- 🟢 **`Gestione ratei di riga` is answered** — the one item the 22/09 record said nothing
  accounted for. _"da prevedere negli ordini che passeranno verso mexal (non abbiamo ad
  oggi casistiche…)"_ — **headroom, not build work.**
- 🔴 **One line was held back on purpose**: the Italian e-invoicing branch →
  [OI-173](../items/OI-173%20San%20Marino%20fiscal%20transcoding%20table.md), due at the
  24/09 10:00 call.

The 22/09 gap _"nobody has answered Mirko Merendi's field-split question"_ is **closed**.

### 2. 🟢🔑 The ingressi suspension is discharged, by the client being told

[Check Data Import](../meetings/2026-09-23%20Check%20Data%20Import.md), `01:54:56`–`02:01:26`.
Fabrizio Paganelli put his own 22/09 written request to the group in person. Aurel Mrruku:
_"Di anagrafica articolo, no. Di anagrafica campagna."_ Elena Spini: _"questa cosa qua è
appunto la fase due."_ Fabrizio Paganelli restated it twice and closed with _"Ok, perfetto."_

🟢 **Fase 1 is one ticket, one entry** — his own words: _"Oggi facciamo che un biglietto è
un ingresso, anche se viene 6 giorni diversi."_
→ [OI-146](../items/OI-146%20Ingressi%20structure%20for%20multi-day%20events.md) **resolved**,
[the decision](../decisions/Decision%20-%20ingressi%20live%20on%20the%20campaign%20edition%20and%20are%20Fase%202.md).

🔑 **The same passage gives the check-in app its purpose**: an **inbound API call** on scan,
with Salesforce returning a speaking error when a previous block's entries are incomplete.
⚠ **The Gemini summary lists this as an action item; the transcript puts it in Fase 2.**
The 22/09 lesson said to check summaries against the middle of transcripts, and this is the
one place the two disagree.

### 3. 🔴 NEW — ROMI's mail gateway blocks DocuSign envelopes

`#team-romi-tech`, **23/09 18:12:11 CEST**, three minutes after the internal dress rehearsal
ended. Aurel Mrruku: _"La posta di romi mi sta bloccando le mail di docusign. a me e anche a
@Rexhina Hysi."_ Angelo Pastorelli, 18:50:40: _"Chiedi a Danilo"_. ⚠ Nothing says the
question reached anyone. **DocuSign is the second half of tomorrow's session**, and
**nobody has tested a client-domain recipient.** →
[OI-174](../items/OI-174%20ROMI%20mail%20blocks%20DocuSign%20envelopes%20to%20the%20dev%20team.md)

### 4. 🔴 The Lead record type was still blank at 18:28 CEST

| Time (CEST) | |
| ----------- | - |
| 10:26:46 | The cause published to the dev group as step 1 of three, _"before tomorrow's Lead UAT"_ |
| 12:51:05 | Elena Spini chases: _"questo per caso avete fatto il check? domani vorrei far vedere il lead diretta"_ |
| **18:28:13** | 🔴 **_"il rt è sempre blank"_** |
| 18:47:45 | Aurel Mrruku: _"domani in mattinata fanno le ragazze che mi stavo occupando di docusign."_ |

🔑 **A second expectation arrived in the same message**: from the `Diretta` record type
Elena Spini expects **only `New` and `Qualificato`**, and would drop the path assistant
there. **Nothing records it being accepted.** →
[OI-164](../items/OI-164%20Web%20to%20Lead%20leads%20arrive%20without%20a%20record%20type.md)

### 5. 🟢🔑 Migration has a perimeter

Elena Spini at `02:04:53`, prefaced _"Una cosa super importante"_: **only historic orders
migrate**; quotes, offers and opportunities are created ex novo. →
[OI-172](../items/OI-172%20Historical%20quotes%20and%20offers%20are%20not%20migrated.md)

🔴 **The consequence: tutors re-key every pending quote by hand. Marco Montesi was not in
the room**, and the group's own action is to tell him at the next meeting. No volume is
known.

Also from the same session, folded into
[OI-165](../items/OI-165%20Data%20migration%20was%20never%20planned%20or%20estimated.md): the
join key is `codice cliente esterno`; only contacts with a company name import (the rest
awaiting the direzione **from 1 October**); test data hand-filtered to records with P.IVA;
🔴 the locali extraction carries **one id on every row but row 20**; 🔴 the account key
field overran 40 characters and was patched with a spreadsheet `RIGHT()`; 🔴 the
orders/migration session was **postponed with no new date**.

📋 A long list of data-model rulings — IBAN removed, `Categoria statistica Mexal` added,
`tipologia attività` multi-select on the locale, complex state fields deleted, ATECO as a
restricted picklist, `codice fiscale` / `codice SDI` / ATECO from Anticipay, `zona` onto the
account, `classificatore rete` → `categoria provvigioni cliente` — is in the meeting note.

**Client mail, 23/09 10:55:02Z:** Fabrizio Paganelli fixed the company code in the shared
Drive folder and created **`Account Salesforce_V2.xlsx`**, sheet `Account NEW` (2.44 MB,
created 10:48:59Z). 🟢 **Not opened** — real customer data.

### 6. 🟢 The article import actually ran, and it is recorded on a branch

`7eab757` carries a **33-line addition to `notes/items/OI-154`** written by the developers:
**1,010 articles upserted by Bulk API with zero failures**, Standard Price Book entries for
all of them (197 active, 813 inactive), row-by-row verification with no differences. The
four-way `natura` classification was loaded from a **`BB` / `BO` / `NO` code mapping
supplied inside ROMI**, not transcribed from the client's screenshots.

🟢 **Third time the developers have maintained `notes/` themselves, and the edit is clean**
— frontmatter intact, `updated:` bumped, counts rather than prices, no personal datum.

⚠ **So the unreadable legend was worked around, not read.** The two screenshot mails of
22/09 remain unreadable by any tool here, and the ROMI-side convention that `S` means
cancelled is **unconfirmed by Mexal** → [OI-175](../items/OI-175%20The%20Mexal%20flag%20annullato%20values%20are%20not%20boolean.md).

### 7. The calendar moved three times

- 🔴 **The orders/migration session planned for 24/09 10:00 was postponed** at Aurel
  Mrruku's request — _"m'hanno fatto già 10 domande sulle cose che ho dato da fare ieri"_ —
  and **no new date was set**.
- 🟢 Its slot went to **`Temi Mexal Anagrafiche/Indirizzi`, Thu 24/09 10:00–11:00 CEST**
  with Mirko Merendi (invitation 08:44:28Z) → OI-173.
- 🟢 **`Check Data Import: Lead/Contact` booked for Mon 5 Oct 17:15–18:00** (invitation
  11:22:10Z), replacing a **cancelled** `[PIENISSIMO] - Follow-up Interno` in the same slot.
  ⚠ Its recipients include **`matteo.d@pienissimo.com`, an address new to this record and
  not attributed to anyone** — the second such address in two days, after `direzione@pienissimo.pro`.

⚠ **Fabrizio Paganelli's request for 3 or 4 October still has no written answer** — three days.

### 8. The build: 2 merges, 2 evening pushes, 1 open PR

| Commit | Author | CEST | Where |
| ------ | ------ | ---- | ----- |
| `e08f060` | aureliii | 23/09 09:41 | 🟢 **PR #55 merged** (`DEV_leadDiagnose`) |
| `61f2a53` | aureliii | 23/09 09:41 | 🟢 **PR #56 merged** (`DevAnitaDocuSign`) |
| `301b22a` | Aurel Mrruku | 23/09 17:43 | the morning org-status check's own commit |
| `7d0f990` | Anita Aga | 23/09 18:40 | **PR #57, open** — `DevAnita` |
| `7eab757` | Rexhina Hysi | 23/09 18:47 | 🔴 **no PR** — `DEV_LeadAgenteBundle` |

🔑 **`7eab757` supersedes the morning's own correction.** At 08:40Z no agent field existed
anywhere; at 18:47 CEST the commit creates **`Agente__c` on Account, Lead, Quote and User**,
the **conversion-blocking validation rule** (`..._Agente_When_Qualificato`), +129 lines on
`LeadConversionQueueable`, and the fields on four layouts. 🔴 **It is on neither `DevMain`
nor UAT, it omits `zona` and `categoria provvigioni cliente`** — both of which the same day's
client session redefined — **and the conversion block still exists while the client is still
considering it, the day before Lead UAT.** → [OI-169](../items/OI-169%20Agent%20code%20and%20commissions%20come%20from%20the%20customer%20record.md)

`7d0f990` / PR #57 carries the Pienissimo branding set, Lightning theme and logo (what Elena
Spini thanked Aurel Mrruku for at 18:28), **pricebook-entry automation**, `Quote.Is_Primary__c`
and `Opportunity.Preventivo_Primario__c` — both matching decisions taken in the morning
session — `ProductCodeTrigger`, and **+212 lines on `QuoteTriggerHandler`**.

🟢 **Both new branches target `DevMain`** where a PR exists. 🔴 **`Standart` unchanged**,
**`without sharing` unchanged**, **coverage 0 of 7,756**.

### 9. The dev group spoke, but not to the report

Aurel Mrruku posted three times in `C0BQD34LLF4`: `pr done` (09:42:05), the org-check report
(10:26:46), and at **16:34:06** _"@here bejm 1 mbledhje per recap per neser ?"_ with the
Pre Demo meeting link. ⚠ **The channel is active and no human has answered a nightly report
in seven nights.**

### 10. Excluded as other clients

**247** (a Fathom recording `SALESFORCE - aggiornamenti post prod.`, a To-Do sheet, an
organigramma) · **Vision** (`DOMANDE Vision`, `Personalizzazioni B2B Vision`, the
B2B Commerce ↔ Zenkraft document, `Agentforce_Domande_Analisi_Cliente`, all `d.losco@`) ·
**Daze** · **BEMA** · **Buoninfante** · **ETES** · **LIFE365** (its own nightly job posted
at 23:25 CEST in a different group DM). Not ingested, by the convention the 18/08, 31/08,
01/09, 21/09 and 22/09 traces applied.

## What it changed

**Two meeting notes, one decision note, four items created, seven items updated.**

| Written | Because |
| ------- | ------- |
| 2 × `notes/meetings/` | the two sessions drilled |
| `notes/decisions/…ingressi live on the campaign edition…` | the ruling is bigger than any one item |
| `OI-172`–`OI-175` | four findings with no existing row |
| `OI-146` | **RESOLVED** — the suspension is discharged by the client being told |
| `OI-159` | **answered**, line by line |
| `OI-161`, `OI-162`, `OI-164`, `OI-165`, `OI-169` | moved by this window |
| `MAP.md`, `INDEX.md` | the live position, 8 new rows, this trace |
| `open-items.md` / `.it.md` | **rows 172–175 new; rows 146, 154, 159, 161, 162, 164, 165, 169 updated — both languages** |
| `DEVELOPMENT-RECAP.md` / `.it.md` | §46, both languages |

**The register was not touched.** Nothing in this window changes a requirement's text. The
migration perimeter, the fiscal transcoding table and the Fase 2 boundary are **new scope
with no id**, and allocating a requirement id is a human's call — the same judgement the
22/09 run made. `ORD-02` and `BIG-11` read the same today as yesterday.

## Triggers

**Discharged this run:**

- 🟢 **The `ingressi` suspension trigger — discharged, and on its own terms.** It was armed
  to fire _"if the next run finds no decision, say that ROMI is taking written requirements
  for a structure it has told its own developer not to build."_ **The client raised it
  himself, was answered, and accepted.** The gap between ROMI's stop and the client's
  expectation is closed.
- 🟢 **The Mirko-Merendi-field-split gap — discharged.** Answered in twenty hours.

**Still armed:**

- 🔴 **The Lead UAT trigger fires, and this is its due date.** It said: _"if 24/09 arrives
  with leads still landing untyped, the first client acceptance session tests a path with
  two known defects."_ **It arrives that way.** `OI-164` was live at 18:28 CEST with the fix
  scheduled for the UAT morning; `OI-163` has no duplicate rule; `OI-169`'s conversion block
  now **exists in metadata** on an unmerged branch. _Report the state of all three before
  anything else on the next run._
- 🔴 **NEW — the DocuSign delivery trigger.** _`OI-174` blocks the second half of the same
  session. If the next run finds no gateway change and no test to a client-domain address,
  say that the signature step was demonstrated on faith._
- 🔴 **The `Standart` trigger fires for the sixth run.** Unchanged, and **records are being
  created in UAT from today**. _Say so as a data-permanence problem every run until it is
  fixed or the records exist._
- 🔴 **The `without sharing` trigger is unchanged**, five in the quote stack, nothing
  records why.
- 🔴 **The migration trigger fires, softer but not discharged.** A perimeter is not a plan:
  still no estimate, no production sequence, no cut-over owner, go-live 21/10, Zoho off
  31/10. _Report it every run until a plan exists._
- 🔴 **NEW — the tutor re-keying trigger.** _`OI-172` puts manual work on people who were
  not in the room. If the next runs show Marco Montesi has not been told, say that a
  workload was assigned to a team in absentia._
- 🔴 **The contract trigger is unchanged** — `Contratto` is on the 5/10 agenda and nothing
  in this window touches it.
- 🔴 **The unreadable-legend trigger is half-discharged and worth keeping.** The import ran
  on a ROMI-supplied mapping instead. _If nobody transcribes the client's own legend before
  30/09, ticket UAT runs on a classification that was never checked against the source._
- 🔴 **The `OI-136` decision trigger is unchanged** — **Elisa Migliano still has not been
  asked**, although she attended a 2h29m session today.
- ⚠ **The `DGM-2` trigger owes a read**, eighth run — `Flows & Objects.drawio` did not move.
- ⚠ **`MAP.md` is ~144 KB against a stated 5 KB budget** — **thirteenth consecutive flag;
  no run has been authorised to act on it.**

## Deliberately not done

- **Nothing was sent, replied to, drafted, shared, modified or marked read on any external
  source.** The single Slack report to `C0BQD34LLF4` is the one message this run posted,
  under the nightly carve-out in
  [the skill](../../.agents/skills/requirements-check/SKILL.md).
- **No Apex test class was written, proposed or scaffolded.**
- **`notes/items/OI-154` was deliberately not edited.** `7eab757` carries a clean
  developer-authored 33-line addition to exactly that file on `DEV_LeadAgenteBundle`, and
  editing it on `DevMain` would hand Rexhina Hysi a merge conflict — the same call the
  22/09 run made for `OI-149` and `OI-150`. **The facts are in the tracker row and here
  instead.** Say so, rather than letting the next run think they were missed.
- **[STATUS.md](../../STATUS.md) was not regenerated.** It was regenerated ten hours ago by
  the 23/09 org-status check against a live org read, and **this run has no org evidence** —
  every build claim below is repository arithmetic. Regenerating it from a sweep would
  replace live evidence with inference.
- **The org was not opened.**
- **Two recordings were not opened** — 1.13 GB for `Check Data Import`; the notes document
  carried both the summary and the full transcript.
- **The two screenshot mails of 22/09 were not re-attempted** — still unreadable, and now
  worked around rather than read.
- **No client migration workbook was opened**: `Account Salesforce_V2.xlsx`,
  `Account Salesforce.xlsx`, `Articoli Salesforce.xlsx`, `Lead Salesforce.xlsx`,
  `Locali Salesforce.xlsx`, `Campagne Salesforce.xlsx`, `Referenti Salesforce.xlsx`. All
  carry real customer data.
- **The 23/09 Pienissimo org chart was read and deliberately not transcribed.** It names
  roughly sixty individuals across Pienissimo Srl and Pienissimo Software Srl. Only one
  fact was taken from it — **Andrea Parmeggiani is Maintenance Manager at Pienissimo
  Software Srl**, which the record already needed — and nothing else was copied.
- **No price, article code, account code, credential, token, VAT number or personal datum
  entered the repository.** Specifically withheld: the roster in the org chart, the
  `matteo.d@` person's identity (unattributed, not guessed), the three sandbox quote numbers'
  contents, the record ids in the developers' sandbox links, and a password-shaped string a
  developer posted in a Slack DM (recorded in **Needs a human**, never copied).

## Gaps in this run

- 🔴 **The Lead record type is blank the night before Lead UAT**, fix scheduled for the
  UAT morning.
- 🔴 **DocuSign envelopes do not reach the dev team**, and DocuSign is tomorrow's second half.
- 🔴 **A conversion-blocking validation rule now exists in metadata while the client is
  still considering it.**
- 🔴 **Marco Montesi has not been told the tutors must re-key every pending quote.**
- 🔴 **The migration has a perimeter and still no estimate, sequence or owner.**
- 🔴 **The orders/migration session was postponed with no new date.**
- 🔴 **Contract logic is still not started**, 5/10 agenda.
- 🔴 **`Standart` is inconsistent with itself and UAT records start tomorrow.**
- ⚠ **Two client addresses are now unattributed** — `direzione@pienissimo.pro` and
  `matteo.d@pienissimo.com`.
- ⚠ **Fabrizio Paganelli's 3-or-4 October request still has no written answer**, three days.
- ⚠ **A credential-shaped string was posted in a Slack DM.** Not copied; flagged.
- ⚠ **No human has answered a nightly report in seven nights**, though the channel is active.

## Method

**The 22/09 lesson paid off once, precisely.** That run concluded that this project's
auto-summaries _"list the agreements and miss the correction"_. Today the Gemini summary
for `Check Data Import` lists **_"Implementare errori QR"_ as a next step**, which would
have put a Fase 2 mechanism into Fase 1 scope eight days before ticket UAT. The transcript
at `01:57:41`–`01:58:52` shows Elena Spini closing the topic as Fase 2 and Aurel Mrruku
saying its data model does not exist. **Reading the middle of the transcript, not the
summary, is what caught it.**

⚠ **The opposite caution applies to the second meeting.** The `Test Pre Demo` transcript is
machine-garbled beyond use — an Albanian and Italian session rendered as English
word-salad. **Nothing was attributed from it.** The two things recorded from that session
are recorded because **Slack and the commit log corroborate them independently**, and the
note says so in place of pretending the transcript is evidence. A source that exists is not
the same as a source that can be read.
