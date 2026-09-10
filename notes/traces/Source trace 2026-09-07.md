---
id: trace-2026-09-07-nightly
type: reference
status: active
updated: 2026-09-07
watermark_used: 2026-09-04T22:00Z
external_watermark: 2026-09-07T22:00Z
account: a.mrruku@romicompany.com
---

# Source trace 2026-09-07

**Watermark for the next `requirements-check` run: 2026-09-07T22:00Z.**

**Watermark used for this run: 2026-09-04T22:00Z** — the `external_watermark` of
[the 04/09 trace](Source%20trace%202026-09-04.md), which is also the newest note in
this folder by `updated:`. Frontmatter and text agree; no disambiguation was
needed.

The window covers **5, 6 and 7 September**. The weekend is empty on every source;
everything below is 7 September.

⚠ **The clone again arrived single-branch on `main`**, which holds two commits and
no vault. `git fetch origin` then `git checkout -B DevMain origin/DevMain`
recovers it — **the same failure the 04/09 trace recorded, so it is the norm for
this environment, not an incident.** A run that finds `AGENTS.md` missing is on
the wrong branch.

⚠ **The `JOURNAL.md` entry for the 04/09 nightly is present but was read wrongly at
first.** Entries are **prepended, newest first**; a `tail` of the file shows the
03/09 entry and looks like a gap. Recorded because the same mistake would make a
future run think a sweep never wrote its handoff.

## Sources searched

All read-only. **Nothing was sent, replied to, drafted, shared, modified or marked
read**, with the single carve-out of the nightly report to `C0BQD34LLF4`.

| Source     | Query / scope                                                                           | Result                                                                                                                                                                       |
| ---------- | --------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Gmail**  | `pienissimo after:2026/09/04 -in:draft`, 50-thread page                                 | 12 threads, **7 new**                                                                                                                                                        |
| **Gmail**  | all mail `after:2026/09/04 -in:draft`, 50-thread page                                   | 37 threads. The rest are Permo (×3), Daze, Interstudio Viaggi, 247, LIFE365, a Workspace 2FA notice, a Salesforce health-check alert for Twentyfourseven, and marketing spam |
| **Gmail**  | `from:/to:/cc:pienissimo.pro newer_than:5d`                                             | **1 thread, newest message still 02/09 10:18Z** — Andrea Parmeggiani has not written since                                                                                   |
| **Gmail**  | thread `1a07b6486788f4d0` — Data Model Parte 3 Gemini notes                             | **read in full**                                                                                                                                                             |
| **Gmail**  | thread `1a07b1f8586c6a02` — Interna Flussi MKT Gemini notes                             | **read in full**                                                                                                                                                             |
| **Gmail**  | thread `1a07cbdedf25b22f` — Follow-up Interno Gemini notes                              | **read in full**                                                                                                                                                             |
| **Gmail**  | thread `1a07b0dc6352abb5` — _"Fwd: Recap: Flussi MKT Biglietti"_                        | **read in full** — the 20/08 recap, new to the record                                                                                                                        |
| **Gmail**  | thread `1a07b310d8c6ca90` — _"ultima iscrizione"_                                       | **read in full**; body is a signature only, six PNG attachments **not opened**                                                                                               |
| **Drive**  | `modifiedTime > 2026-09-04T22:00:00Z`, paged twice                                      | 27 items, **9 Pienissimo**                                                                                                                                                   |
| **Drive**  | `title contains 'Appunti di Gemini' and modifiedTime > watermark`                       | 5 docs, **3 Pienissimo** — one per session                                                                                                                                   |
| **Drive**  | Gemini doc `1_9dgnxNCu_RhCAt1cu6sKvdw0DYr5pVItdAzZNhfA4g` (Parte 3)                     | **read in full — summary, Decisioni, 9 detail bullets and the complete 1h12m02s transcript**                                                                                 |
| **Drive**  | Gemini doc `1pZVnudmZHZFVAyh13vBWASH4XOV3kxvoJSt0P68lDDY` (Flussi MKT)                  | **read in full — summary, Decisioni, 8 detail bullets**; transcript present and not needed                                                                                   |
| **Drive**  | Gemini doc `1-r2hUv-NG9_QSwL2ijHsHaTjKwRHTXU7lLyiRpWckkY` (Follow-up)                   | **read in full — 7 `Concordato` decisions, 12 next steps, 15 detail bullets. No transcript section exists**                                                                  |
| **Slack**  | workspace-wide incl. private channels, DMs and group DMs, `pienissimo after:2026-09-04` | 4 hits, **all new**                                                                                                                                                          |
| **Slack**  | group DM `C0BQD34LLF4` — the org-status-check post of 10:04 CEST                        | **read in full** from the search result                                                                                                                                      |
| **Git**    | `git log`, `git show --stat` on `DevMain`                                               | one new commit, **`d562af0`**, 43 files                                                                                                                                      |
| **Repo**   | `MAP.md`, `INDEX.md`, `AGENTS.md`, the write protocol, the 04/09 trace, OI-81/99/121    | read directly                                                                                                                                                                |
| **Fathom** | `list_meetings` from 04/09, 3 pages                                                     | **0 meetings.** Consistent with 03/09 and 04/09 — an absence, not a gap                                                                                                      |

## Found

### 1. 🔴 The go-live date moved, in a room with no client in it

`[PIENISSIMO] - Follow-up Interno`, 17:01 CEST, ROMI-internal: **go-live 21
September 2026, approval by 13 September**
([the minute](../meetings/2026-09-07%20Follow-up%20Interno.md)). Every governing
document says **6 October** — `CTX-02` in both prose texts, both milestone tables,
the `M` priority definition, the Fase 2 escalation rule, `MAP.md` and §10.1 of both
recaps.

**Fifteen days earlier**, yet described as a _slittamento_ that **adds**
development and test weeks — which only fits a plan whose go-live was before 21
September and which **is not in this repository**.

🔴 **Nothing was changed in the register.** `REQUISITI.it.md` is the text
presented for signature; a date in it does not move on an internal meeting
summary, and no source shows Pienissimo being asked. The conflict is
[OI-124](../items/OI-124%20Go-live%20moved%20from%206%20to%2021%20October.md).

### 2. 🔴 Fase 2 is parked, and work was deferred into it in the same hour

**Fase 2 is held until the client confirms payment** — the first movement on
[the dispute](../risks/Risk%20-%20the%20phase%202%20scope%20dispute%20is%20unresolved.md)
since 24 July, and a ROMI posture rather than a client answer. In the same session
the **Mexal scadenzario correction path** — Fabrizio Paganelli's ask — was
**deferred to Fase 2**. Client-facing scope moved into a phase with no quote, no
date and no payment, and the notes do not connect the two decisions.

### 3. 🟢 Six Mexal decisions, and one hardcoded year nobody noticed

Static header coordinates `azienda = PE` / `anno = 2025` with basic auth; a field
filter on the modified-customers POST; **PUT or PATCH required** because POST on
an existing account fails on a duplicate partita IVA while the customer is pushed
on **every** order creation
([OI-125](../items/OI-125%20Mexal%20customer%20update%20needs%20a%20PUT%20method.md));
manual invoice generation; manual agent lookup; and the shipping address never
read back from Mexal
([the flow](../flows/The%20Mexal%20integration.md)).

🔴 **`anno = 2025` is hardcoded against a 2026 go-live and nobody raised it.**

🟢 **The edition mapping finally has a _when_** — products loaded from Excel
first, mapping entered by hand in the days immediately before go-live. Still **not
by whom** ([OI-121](../items/OI-121%20The%20edition%20mapping%20table%20has%20no%20rows%20and%20no%20owner.md)),
and those days just moved two weeks earlier.

### 4. 🟢 Data Model Parte 3 ran on Monday, which settles the 04/09 ambiguity

Client-facing, 11:06 CEST, **1h12m02s**
([the minute](../meetings/2026-09-07%20Data%20Model%20Parte%203.md)). Of the two
readings the 04/09 trace left open, **the first is what happened**: not cancelled,
held without Andrea Di Cicco, who said so in the group DM at 09:12:53 CEST. Elena
Spini also sent an **updated invitation** at 09:05:50Z, so the slot was actively
reconfirmed.

**Consents stay on the Contact; edition participation moves to CampaignMember**
([the decision](../decisions/Decision%20-%20consents%20live%20on%20the%20contact%20and%20editions%20on%20the%20campaign.md)),
Rebecca Marmo confirming the Zoho overwrite behaviour it fixes. **The Zoho tag
scheme is decoded** — `<EVENT>_I` iscritto, `<EVENT>CP` contatto principale — and
retired. **The primary-contact rule is sharpened**: mandatory, freely selectable,
pre-filled where a principale exists, editable.

🔴 New: [OI-123](../items/OI-123%20The%20Zoho%20questionnaire%20fields%20have%20no%20home.md) —
a dozen Contact fields are a verbal tutor questionnaire whose natural owner is a
**locale**, an object that does not exist.

🔴 **The four gaps survive a fourth session.** Four sessions, two objects.

### 5. 🟢🔴 The marketing session closed `30 vs 60` and moved rinuncia

`[PIENISSIMO]- Interna Flussi MKT`, 10:00 CEST
([the minute](../meetings/2026-09-07%20Interna%20Flussi%20MKT.md)). **`30 vs 60` is
a window** — 30–60 days, data-collection mail ~60 days — ⚠ **still ROMI choosing
for the client**, exactly as OI-81 warned. **Rinuncia moves onto the community
page** ([the decision](../decisions/Decision%20-%20rinuncia%20moves%20from%20the%20marketing%20email%20to%20the%20community.md)),
which is unbuilt work on a page merged 03/09.

New: [OI-126](../items/OI-126%20An%20asset%20flag%20for%20incomplete%20participant%20data.md)
and [OI-127](../items/OI-127%20What%20a%20total%20rinuncia%20does%20to%20orders%20and%20assets.md).

### 6. 🔴 The 20 August recap arrived by forward, three weeks late

Elena Spini forwarded Fabrizio Mastracci's own 20/08 recap at 08:48Z with the body
_"FYI"_. **Its text was not in this record.** It answers half of OI-127 in writing
— rinuncia _"annulla tutti i biglietti, non è parziale"_ — and itemises client
deliverables under [OI-14](../items/OI-14%20Marketing%20forms%20and%20subdomain.md)
now **two to three weeks overdue**.

⚠ **The question it answers was treated as open the same morning, in a room
containing its author.** The document had been circulated hours earlier.

### 7. ⚠ An org check ran, published nothing, and corrects two records

Posted by Aurel Mrruku to `C0BQD34LLF4` at 10:04 CEST, read-only against UAT at
repo `012d49d`, explicitly **report mode**. It corrects
[OI-121](../items/OI-121%20The%20edition%20mapping%20table%20has%20no%20rows%20and%20no%20owner.md)
— **4 rows, 3 active, 3 products against 226 of 229 unmapped and 17 of 22 orders
on `Incassato`** — and measures Apex coverage at **0 of 2,741 lines**, last run
**4 August**
([the deploy risk](../risks/Risk%20-%20production%20deploy%20is%20blocked%20by%20Apex%20coverage.md)).

⚠ **Its own findings are unrecorded in the repository beyond what this run folded
in.** `STATUS.md`, the Notion mirror and the register's `build_state` carry none
of it, and eight further findings — the `Partita_IVA__c` edit grant, tranche
propagation at 0 of 24, zero declarative flows, six org-only components, permission
sets reaching one user in nine, `Product2` 281 → 229, `Integration_Log__c` at 32
errors in 57 rows — are recorded in §30.7 of the recap and nowhere else.

### 8. ⚠ The repository moved, and it was not this sweep's work

Commit **`d562af0` "Event invitation"**, 7 September 15:05:29 +0200, **43 files,
+1,240 / −120**: `Event_Invitation__c` with layout, tab, two validation rules and
nine fields; `EventInvitationService`, `EventInvitationUrlJob`,
`ParticipantCommunityUrl` and a trigger; the rename of `OrderBigliettoTrigger` to
`OrderTrigger` with a destructive-changes manifest; and `Full_Permission`
absorbing the drafted invitation permission set.

🟢 **It is already documented.** Six `JOURNAL.md` entries — three `claude`, three
`codex` — plus two decision notes and a flow proposal landed in the same commit.
**Nothing about it needed reconstructing**, which is the first time in this
record's history that a build arrived with its own minutes.

⚠ **The commit is authored `Aurel Mrruku <slazzaretti@deloitte.it>`.** The name is
right and the address belongs to a different organisation entirely. It reads like
a misconfigured local git identity rather than anything else, and it is **not
interpreted here** — but it is the address that will appear on this commit
permanently. Worth one message.

### 9. ⚠ Mail and Drive in the window that is not this project's

- **Permo** — three items: a `Riunione chiusura UAT` Gemini doc, an
  `Allineamento SF | Zucchetti` session at 14:59 CEST with notes and recording, and
  two invitations for 8 and 14 September including Zucchetti staff. **Not
  ingested.**
- **Daze** (`Campi chiave sf per oggetto`, modified 10:43Z), **Interstudio
  Viaggi**, **LIFE365**, **247**, a **Google Workspace 2FA enforcement notice** for
  `romicompany.com` effective 7 September, a **Salesforce security health-check
  alert for Twentyfourseven Srl**, and marketing spam. **None ingested.**
- ⚠ **`Stima Task` and `Jira.csv`**, both owned by `d.losco@romicompany.com`,
  created 10:21–10:22Z and modified 12:28Z in a folder this run did not identify.
  The follow-up session discusses producing **approximate estimates**, which makes
  them a plausible Pienissimo artifact. **Not opened, not attributed.**

## What it changed

**Eleven notes created, twelve updated.**

| Written                                                                | Because                                                    |
| ---------------------------------------------------------------------- | ---------------------------------------------------------- |
| `Source trace 2026-09-07`                                              | **new** — this note                                        |
| `2026-09-07 Data Model Parte 3`                                        | **new** — the minute, from the full transcript             |
| `2026-09-07 Interna Flussi MKT`                                        | **new** — the minute                                       |
| `2026-09-07 Follow-up Interno`                                         | **new** — a decision list; no transcript exists            |
| `Decision - consents live on the contact and editions on the campaign` | **new**                                                    |
| `Decision - rinuncia moves from the marketing email to the community`  | **new**                                                    |
| `OI-123` … `OI-127`                                                    | **new** — five rows                                        |
| `OI-81`                                                                | `30 vs 60` closed; the style constraint still not restated |
| `OI-99`                                                                | Parte 3 ran; the calendar ambiguity resolved               |
| `OI-121`                                                               | **corrected** — the table has rows, and a _when_           |
| `OI-24`                                                                | a fourth session, the same four gaps                       |
| `OI-78`                                                                | rinuncia joins the page; the recipient rule settled        |
| `OI-14`                                                                | the owed list itemised and overdue                         |
| `OI-102`                                                               | the WooCommerce mail has an owner, and is unsent           |
| `OI-110`                                                               | agent lookup deliberately manual                           |
| `OI-113`                                                               | the shipping mirror is one-directional by decision         |
| `The Mexal integration`                                                | six decisions                                              |
| `Risk - the phase 2 scope dispute is unresolved`                       | parked pending payment                                     |
| `Risk - production deploy is blocked by Apex coverage`                 | 0 of 2,741, and the window narrowed                        |
| `MAP.md`, `INDEX.md`                                                   | the live position and the new notes                        |

Also: rows **123**–**127** plus a sweep blockquote in `open-items.md` **and**
`.it.md`; a new **§30** in `DEVELOPMENT-RECAP.md` **and** `.it.md`.

**No requirement changed**, and one arguably should have. **`CTX-02`** carries the
go-live date, and the 07/09 session moved it. It was left alone deliberately: the
Italian is the contractually operative text, the decision was taken with no client
in the room, and the direction of the change contradicts its own justification.
That is [OI-124](../items/OI-124%20Go-live%20moved%20from%206%20to%2021%20October.md)'s
question for a human, not a sweep's to answer.

## Deliberately not done

- **No mail was sent.** The WooCommerce integration mail to Sabatino Rinaldi is
  now an assigned action on Aurel Mrruku and **remains unsent**; the queue for
  Andrea Parmeggiani is still three questions.
- **No credential, token, price, VAT number, codice fiscale, IBAN, PEC or personal
  name from a customer record was written into the repository.** The six
  `ultima iscrizione` screenshots were **not opened**; their existence is recorded
  and nothing from them copied.
- **No Apex test class was written or proposed.** The coverage records carry the
  org's 0-of-2,741 figure and the ~290 further lines from `d562af0`, and nothing
  more.
- **The org was not opened.** `STATUS.md`, its Notion mirror and the Flows page are
  owed for an eighth run and remain `org-status-check`'s to produce — sharpened by
  the fact that a check **ran today and published nothing**.
- **The `.drawio` was not decoded.** It moved a **sixth** time, at 10:34:37Z,
  between Parte 3 ending and the workbook being saved. The reader still cannot
  render the format
  ([the master](../The%20newest%20design%20diagram.md)).
- **Nothing in `d562af0` was changed**, and the Notion access request
  ([OI-122](../items/OI-122%20An%20external%20address%20requested%20access%20to%20the%20internal%20status%20page.md))
  is still unanswered after three days.

## Gaps in this run

- 🔴 **Nobody has said which go-live date governs.** Everything downstream —
  the test suite window, the mapping window, the approval gate — hangs on it.
- ⚠ **The `Follow-up Interno` has no transcript**, so the most consequential
  session of the run is read from Gemini's paraphrase. **No quotation from it is
  verbatim speech.** A recording exists (553 MB) and was not opened. If the date
  matters — and it does — **somebody should check the recording** before acting on
  the 21 September figure.
- ⚠ **The `[PIENISSIMO] - Follow-up Interno` Gemini document's `Allegati` block
  points at a 13 July recording**, an artifact of the recurring event. A future run
  following that link gets the wrong session.
- ⚠ **The landing-page and hidden-field spreadsheet was not opened**
  (`1KPZ8pwEg3FFyXDdKu-gkXPtI13Yb5fGi`). Its link is corrupted in the mail body and
  it is the specification for a page that is already built.
- ⚠ **The Parte 3 recording and the workbook's 10:08Z save were not opened.** The
  transcript covers the same ground; a workbook change made outside the session
  would not have been seen.
- ⚠ **`Stima Task` and `Jira.csv` were not attributed.** If they are this project's
  estimates, they are the first estimate artifacts in the record.
- ⚠ **Nothing was verified against the org.** Every build claim here is the
  repository or ROMI's own posted check.

## Method notes

**A forwarded mail can answer a question being asked in the next room.** The 20
August recap reached this mailbox at 08:48Z; at 10:00 the same morning a session
raised as open a question that document answers in a parenthesis, with the author
of the document present. Nobody in either place connected them. **A sweep that
reads the mail before the minutes catches this; one that reads only the minutes
does not.** Read the window's mail first, then the sessions.

**Gemini's `Concordato` block is where the expensive things hide.** The go-live
change is one line in a seven-line decision list, in a document with no transcript,
in a recurring internal meeting. It is not in the summary, not in the next steps
and not flagged. **Read the `Decisioni` block of every internal session in full,
even when the summary sounds routine** — this one's summary was
_"Riunione tecnica con pianificazione e organizzazione eventi"_.

**`JOURNAL.md` entries are prepended, not appended.** A `tail` shows the oldest of
the recent entries and looks like a missing handoff. Read the head.
