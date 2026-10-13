---
id: trace-2026-10-13-nightly
type: reference
status: active
updated: 2026-10-13
watermark_used: 2026-10-12T22:00Z
external_watermark: 2026-10-13T22:00Z
account: a.mrruku@romicompany.com
---

# Source trace 2026-10-13 nightly

**Watermark for the next `requirements-check` run: 2026-10-13T22:00Z, single
value.**

**Watermark used: 2026-10-12T22:00Z**, the `external_watermark` stated by
[the 12/10 nightly trace](Source%20trace%202026-10-12%20nightly.md), selected by
`updated:` frontmatter. Scheduled nightly run, executed 2026-10-13 ~21:50Z. **One
day.**

🔑 **The client sat down and drove a sale from a bundle he built to an order Mexal
accepted — and in the same session reversed the population rule he had agreed four
days earlier, which was rebuilt the same afternoon and now makes 15 of 23
categories un-saveable the morning of the end-to-end test.**

🟢 **Environment note.** The clone opened **detached at `refs/heads/main`** (two
commits, config only) with none of the knowledge layer in the working tree;
`DevMain` did not exist locally and was created with
`git fetch origin DevMain && git checkout DevMain`. **Thirteen runs, same opening
pattern.** ⚠ `AGENTS.md` still describes `MAP.md` as _"under 5 KB"_; it is now
**234 KB**. The read protocol's first instruction has been wrong for some time.

## Sources searched

| Source | Query / scope | Result |
| ------ | ------------- | ------ |
| **Gmail** | `pienissimo after:2026/10/12 -in:draft`, 50 requested, 8 estimated | 🔑 **the 13/10 `Feedback Test UAT` Gemini notes**, 11:55:29Z, **unread** · 🔴 **a new flow error mail** 12:39:42Z and **Aurel Mrruku's forward of it** to Fabrizio Mastracci and Elena Spini 13:38:31Z · 🔴 **the DocuSign onboarding closure**, forwarded by `amministrazione@pienissimo.com` 14:34:16Z cc Sabatino Rinaldi. Everything else at or before the watermark and already held |
| **Gmail** | `after:2026/10/12 -in:draft (from:/to:/cc:pienissimo.com OR pienissimo.pro OR kreosoft OR gemini-notes@google.com OR info@salesforce.com OR subject:ROMI-PIENISSIMO)`, 10 estimated | Nothing further on this project. The other hits are **other clients** — `Daniele / Aurel per Daze`, `[TFP] Data Model` (4 messages), a `Teatro Franco Parenti` Apex CPU exception, `[TFP] Data Cleaning` — ignored per the skill. **No Kreosoft mail; nothing from Mirko Merendi** |
| **Gmail** | `after:2026/10/12 -in:draft (mexal OR biglietto OR bundle OR tranche OR anticipay OR woocommerce OR docusign OR preventivo OR "Ri.Ba" OR scadenzario OR blueprint OR jira OR listino)`, 7 estimated | Nothing beyond the above. 🔴 **Nothing on `Ri.Ba.`, the scadenzario, OI-212 or the Blueprint signature** |
| **Gmail** | `from:info@salesforce.com subject:flusso after:2026/10/01`, 3 threads | 🔑 **the decisive one.** Three flow error mails exist in total: 08/10 06:45:34Z and 13/10 12:39:42Z are **the same flow** (`flow_701SW00000fouUCYAY_1791380294345`), at **version 1** and **version 7**; 09/10 05:53:21Z is OI-225's different flow |
| **Gmail** | `get_message` ×4 (PLAIN_TEXT, full bodies): the Gemini notes, both flow errors, the DocuSign thread | the 13/10 summary and all thirteen next steps · 🔑 **`Organizzazione: Pienissimo srl (00Dbl000005BSMH)`**, `Utente corrente: Tech Romi (005SW00000PV5Ja)` in **both** flow mails · the full DocuSign text and the production account's existence. **The DocuSign account number was read and deliberately not recorded** |
| **Slack** | `slack_read_channel C0BQD34LLF4` (dev group), `oldest` 2026-10-12T22:00Z | **1 message — this procedure's own 12/10 report.** 🔴 **No human reply: twenty-three nights** |
| **Slack** | `slack_read_channel C0B5T3RB4FM` (`#tproj-pienissimo`), same bound | **0 messages.** 🔴 Silent a fourth day |
| **Slack** | `slack_read_channel C0C38JJ9D1T` (marketing group DM), same bound | 🔑 **3 messages.** Aurel Mrruku's **second TEST MKT batch in Prod** at 16:07:51 CEST — 6 orders, 12 tickets, 6 Event Links, `Integration_Log__c` unchanged at 9 because Mexal order creation is off in Prod — **and his own warning that both test editions' ticket send date is still 05/10 and already past**. Elena Spini posted `00vSW00001MqCj3YAF` at 16:20:46 and an image at 16:23:15 |
| **Slack** | `slack_read_channel D0B5QHS2T7H` (Elena Spini DM), same bound | 7 messages, **all LIFE365** — access for Sara Aga, and _"non chiedermi perché ma LIFE sarebbe questo"_. ⚠ Another client; not counted as a Pienissimo source |
| **Slack** | `slack_search_public_and_private` `keywords:[pienissimo] after:2026-10-12`, sorted by timestamp | 4 results, all accounted for: this procedure's own two reports (Pienissimo and the sibling LIFE365 run), a silent Jira bot DM, a Google Calendar bot line. **Nothing in any other channel** |
| **Slack** | `slack_read_canvas F0BD2H5A9HT` (`Link utili Pienissimo`) | **Unchanged.** Newest entry still 20.08.2026 — static for **seven weeks**. Re-read per the skill; still the source of the 30/07 marketing notes link |
| **Drive** | `modifiedTime > '2026-10-12T22:00:00Z'`, **2 pages, 13 files** | 🔑 **the 13/10 session folder, its Gemini notes doc and a shortcut** (11:53:14Z–11:54:31Z) · 🔑 **`Manual Steps Pienissimo` modified again** 09:29:13Z · the rest are **other clients** (247.it, Daze, Vision/`d.losco@`, `[ROMI-WILEGAL]`) or ROMI-internal capacity — ignored. ⚠ **`Campi Oggetti…xlsx` and `Flows & Objects.drawio` did not move** |
| **Drive** | `read_file_content 1Lbc5Ypm-ktbSW2Sqp4ilZymvC4T-68sKoJ5FwgPScEI` | 🔑 **the 13/10 session read in full — 108,930 characters**, `Riepilogo` + `Decisioni` + thirteen `Passaggi successivi` + `Dettagli` with timestamps. **Drilled; the `Dettagli` block is the substance and the raw transcript below it was not loaded.** No article code or price values copied |
| **Drive** | `read_file_content 1u-LgUKVlGK9ePyjMzZ_uJjXniHluo5_449siHgAIBHo` | 🔑 **the manual-steps sheet re-read** — now `A1:C5`; a **fourth** row, and **row 3 still blank in both status columns** |
| **Fathom** | `list_meetings created_after 2026-10-12T22:00Z`, summaries + action items, 3 pages | **1 meeting, and it is another client** — `Filemaker _ last migration support` (247.it). 🔴 **Sixteenth consecutive run with no Pienissimo meeting** |
| **Git** | `fetch origin`, `log --all --since 2026-10-12T22:00:00Z` | **13 commits**, all human, plus this procedure's own 12/10 commit. `DevMain` advanced `a061f55` → **`21d6686`** through **PRs #95, #96, #98, #99, #100**. 🟢 **Everything merged**: `7f8ead3`, `f89d68e`, `700133a`, `435b6db` all now ancestors of `DevMain`. Only `DevSara` (`b79a7e2`) is outside, unchanged from before |
| **Repo** | `MexalScadenzarioSearchService.cls:185-215`; `Scadenza_Fattura__c/fields/Pagata__c`; `git log` on both; `git show --stat 0816bf7` and `49b49e5`; `Event_Invitation__c/fields/`; `grep -rn Recipient_Contact force-app/`; `Product2/fields/`; `Quote/fields/`; `JOURNAL.md` tail | 🔴🔑 **both payment predicates byte-for-byte unchanged — OI-212 did not move, fifth night** · 🔑 **`Recipient_Contact__c` exists in source** and is used by the layout, two validation rules, `Full_Permission` and `EventInvitationService` · `Evento__c` and `Codice_Agente_Esterno__c` both present · the developer's **four `JOURNAL.md` entries for 13/10** |

## Found

1. 🟢🔑 **New: [the 13/10 Feedback Test UAT](../meetings/2026-10-13%20Feedback%20Test%20UAT.md)
   — the mirror image of 12/10.** ~1h34m, full record, three `Concordato`, thirteen
   next steps. **Fabrizio Paganelli built a bundle, priced it, set four tranches,
   created an Opportunity and Quote, signed on DocuSign, and got an Order that
   reached Mexal with status `inviato`.** 🔑 **The first order recorded reaching
   Mexal from a quote** — the chain note has read _"0 of 45"_ since 14/09.
2. 🔴🔑 **[OI-96](../items/OI-96%20Edition%20mapping%20table%20on%20Salesforce.md)'s
   population rule was reversed by the client who agreed it four days earlier.**
   Active products only. Built the same afternoon (`0816bf7`). 🔴 **15 of UAT's 23
   categories have no active product, so a category save on them now fails** — the
   morning before the e2e, with **no owner and no tracker row**.
3. 🔴🔑 **New: [OI-230](../items/OI-230%20The%20ticket%20confirmation%20request%20flow%20queries%20a%20relationship%20name%20as%20a%20field.md)
   — gating.** `Invio Richiesta conferma biglietto Flow` queries
   `Recipient_Contact__r`, a relationship name, so it **can never succeed**. ⚠ **It
   failed on 08/10 at version 1 and again today at version 7**, with `Get Campaign`
   returning nothing in both — the unchased root cause. The 08/10 mail was logged
   as a footnote to OI-225 and **no row was raised**.
4. 🟢🔑 **[OI-225](../items/OI-225%20The%20ticket%20dispatch%20flow%20sends%20to%20a%20null%20recipient%20and%20fails%20the%20asset%20write.md)'s
   org is identified: `00Dbl000005BSMH` is Pienissimo production.** By instance key
   — UAT artefacts carry **MA**, the flow errors carry **SW**, and so does the
   record id Elena Spini posted inside Aurel Mrruku's own report of the **Prod**
   TEST MKT batch. 🔴 A customer-facing send has been failing in **production**
   since 09/10.
5. 🔴 **New: [OI-231](../items/OI-231%20DocuSign%20closed%20the%20Pienissimo%20onboarding%20for%20non-response.md)
   — gating.** DocuSign closed the onboarding for non-response and passed the
   account on. 🟢 It confirms a **production DocuSign account exists** — the
   licences were bought, open since June. 🔴 The client asked ROMI whether it
   mattered and nobody has answered.
6. 🔴 **New: [OI-232](../items/OI-232%20A%20DocuSign%20envelope%20was%20signed%20under%20the%20wrong%20signer%20name.md)**
   — the client signed with Aurel Mrruku's name and the Order went to Mexal on it.
   ⚠ Recorded unresolved; may be test-account confusion, may be the running user.
7. 🔴 **New: [OI-233](../items/OI-233%20Bundle%20access%20for%20tutor%20profiles%20is%20undefined.md)**
   — tutors must not quote bundles; deferred to _"the group"_. ⚠ **"Tutor" is not a
   profile in any project record.**
8. 🔴🔑 **[OI-212](../items/OI-212%20A%20Ri.Ba.%20rate%20reads%20as%20paid%20before%20its%20due%20date.md)
   did not move, fifth night**, re-verified byte-for-byte at `21d6686`. ⚠ **The
   session set it up without triggering it** — four future-dated tranches on
   Ri.Ba.-family terms, and the return leg never ran. **The 13/10 confirmation date
   has passed.**
9. 🔴 **[OI-228](../items/OI-228%20The%20nightly%20schedulers%20have%20no%20run-as%20user%20and%20the%20first%20run%20is%20imminent.md):
   the 03:00 run happened and the row is still blank.** Sheet edited 09:29:13Z,
   grew a fourth row, run-as-user row not ticked. 🔴 `Status Prod` blank on all
   four.
10. 🔴 **[OI-145](../items/OI-145%20Order%20header%20discounts%20are%20removed.md)
    reopened, owner moved to the client.** Fabrizio Paganelli will contact Mirko
    Merendi himself. 🔑 Partly answers the carried _"Mirko's call is unbooked"_
    item; 🔴 still no date, and his rounding objection went unmentioned.
11. 🟢 **Both of last night's "not in `DevMain`" flags closed** — `Evento__c`
    (PR #95) and `Codice_Agente_Esterno__c` (PR #96).
12. 🔑 **Rulings of record:** `Price_1__c` is the Mexal invoicing reference · the
    description is a concatenation of two Mexal fields · 2 decimals · **articles
    are not duplicated per year and the campaign must exist before the mapping**.
13. 🆕 **Category `E11`** mapped to a new `Pienissimo lab 2026` campaign — a
    category key new to these records.

## The register

**Not amended, and nothing this sweep found calls for amending it.**
Version stays **1.6**, `SAL-20` stays as `96d77de` left it.

🔴 **[OI-227](../items/OI-227%20SAL-20%20was%20rewritten%20in%20the%20signable%20requirements%20with%20no%20client%20ruling.md)
is unanswered a second day.** Nothing in any source this run says whether the
rewritten `SAL-20` was agreed with the client, so the discrepancy stands exactly
as recorded and **the YAML was again deliberately not touched**.

⚠ **One of today's rulings is a candidate and one is a reversal.** The three
`Concordato` items — the description concatenation, `Price_1__c` as the invoicing
reference, and active-products-only mapping — are **client rulings taken in the
room**, which is the authority OI-227 says the `SAL-20` rewrite lacked. **They are
not in the register and were not added**: no existing requirement id covers them,
allocating one is a register change, and
[OI-184](../items/OI-184%20Register%20v1.6%20goes%20to%20the%20client%20as%20one%20change%20set%20at%20UAT%20close.md)
exists so v1.6 reaches the client as one reviewable change set. **They join the
v1.6 candidate list** with the renewal-without-DocuSign path, the two-flag Lead
consent model, the 21-value `Tipologia di attività`, `Partita IVA` mandatory at
lead conversion, the per-edizione link scope, `Rinuncia` per edition, `E` counting
as paid only after the due date, and the commercial notification flows.

🔴 **And the edition-mapping population rule is now a candidate that has been
built twice in opposite directions in four days.** Whatever reaches the client as
v1.6 must state the active-products rule, not the 09/10 one.

## Corrections to the record

- 🔑 **One correction to this run's own working, made before it was written.**
  OI-230 was first drafted as a brand-new flow failure. OI-225's own text names an
  08/10 mail with **the same flow API name**, and a targeted Gmail search confirmed
  it: version 1 then, version 7 now. **The note and every rendered row were
  rewritten to say "recurrence since 08/10", not "new today"** — the two mails are
  tabulated side by side in OI-230.
- ⚠ **The 12/10 trace's "second mail of the same shape" was correct** and is now
  the hinge of the org identification. It said somebody with org access should
  settle which org it was; nobody did, and the identification came from an
  instance-key argument instead.
- ⚠ **No correction to the developer's 13/10 records.** The four `JOURNAL.md`
  entries and the object-note updates are his own, detailed, and include two
  self-corrections. Pointers were added to OI-96 and the Mappatura note; **nothing
  in them was rewritten.**
- ⚠ **The order-record access problem is recorded twice, differently, in the same
  source.** The `Dettagli` block reads it as a browser difficulty solved by opening
  a new tab; the next-step list calls it _"il problema di accesso"_ and asks for an
  investigation. **Both readings are preserved; no claim is made.**
- ⚠ **The Gemini record writes the ERP as _"Bexal"_** throughout. Read as Mexal,
  and said so.

## Not done in this run

- The org was **not** opened. `STATUS.md` was not regenerated and the Notion
  mirror stays stale. Every build claim is repository arithmetic against `DevMain`
  `21d6686`.
- **No Apex test was written, proposed or scaffolded**, per the standing
  instruction. ⚠ Noted only as a fact of the record: 13 commits and 5 merged PRs
  today carry Apex and LWC changes. That is inside the gap
  [OI-64](../items/OI-64%20The%20bundle%20Apex%20test%20suite%20is%20broken.md) and
  [OI-66](../items/OI-66%20No%20test%20classes%20for%20the%20Biglietto%20stack.md)
  describe; **this sweep did not touch either row.**
- **The YAML register was not edited** — see above. ⚠ The `vault:check` trace
  warnings are unchanged in kind: OI-227 still cites `SAL-20` without `SAL-20`
  naming it back, and the new rows cite no requirement id except OI-230's `BIG-06`.
- **Neither flow was opened.** OI-230's fix is a one-token change to a `Get`
  element, and this procedure cannot make it: the flow is org-only and read-only
  here.
- **OI-212 was not fixed**, a fifth night. The defect is recorded with the file,
  the lines and the formula; the correction is a code change and belongs to Aurel
  Mrruku.
- **The 15-of-23 category failure was not given a tracker row.** It is recorded in
  [the Mappatura note](../objects/The%20Mappatura%20Edizione%20object.md) by its
  author and cross-referenced from OI-96; raising a duplicate row for a defect the
  developer documented the same hour would be noise. **It is in tonight's
  "needs a human" list instead.**
- **OI-223's blast radius was not assessed** — a sixth run.
- **OI-207 was not verified in the org** — a seventh run.
- **The raw transcript below the `Dettagli` block was not loaded.** The drill used
  the structured sections; ~87 KB of verbatim transcript remains unread and is
  available if a quote is ever needed.
- **The images Elena Spini posted** (marketing DM 16:23:15, Elena DM 18:58:03)
  were not opened. The second is LIFE365.
- `npm run prettier:verify` was not run (no `node_modules`), so tonight's markdown
  is unformatted.
- ⚠ `JOURNAL.md` is at **118 entries** against a documented limit of 20. Archiving
  to `notes/sessions/` is overdue and **was left alone again**.

## Still unreachable

- 🔴 **`Mappatura_Categorie_Sottocategorie_Origine Lead_Tipologiattività.xlsx`**
  — the four Lead picklists, still a **mail attachment only, sixth run**. It blocks
  a commissioned deliverable with a Web-to-Lead file already waiting on it.
  **Ask Elisa Migliano or Elena Spini to put it in Drive.**
- 🔴 **The 30/07 marketing notes** — Drive id
  **`1uJCE4NW9nbdI38ADmt66svUT1MRmkyYd24uI0hegAD0`**, from the canvas, 404 for
  `a.mrruku@romicompany.com`. **Ask Elena Spini to share that document.** Second
  run with a precise id.
- 🔴 **What was said at the 12/10 client call.** 🟢 **Partly recovered** — the
  13/10 session shows the mismatched screens were the product anagrafica ones — but
  anything said on 12/10 and not re-raised the next day is still lost.
- **The identity of the DocuSign production configuration** — templates, sending
  identity, envelope allowance. **Ask Elena Spini or Sabatino Rinaldi**, and it is
  now urgent because the onboarding that would have covered it is closed.
- **`Flows & Objects.drawio`** — did not move; still an unparseable `mxfile`.
  **Ask Elena Spini for a PNG or PDF export.**
- 🆕 **What `Get Campaign` is looking for** in both failing flows. Needs the org;
  the flows are not in source control.
- **What is in Jira project `PIEN`** — no connector. **Ask Elena Spini what it is
  for.**
- **Which profile a "tutor" holds** in UAT and Prod — OI-233 cannot be built
  without it.
- **The contents of `Regole Codifica Codici Articolo.xlsx` beyond its structure** —
  read, code values deliberately not recorded. **Ask Fabrizio Paganelli whether
  this is the scheme going to direction.**
- **`Campagne Salesforce.xlsx`** — did not move. Still not opened.
- **`Testbook_UAT_Lead_Opportunita_2026-09-24_v2_1.xlsx`** — **did not move**, a
  tenth consecutive run. Approval was due ~13/10, which was today.
- **The full text of `Pienissimo_Scheda di Partecipazione ai corsi_da firmare.pdf`**
  — not opened; its seven enrolment pages may carry personal data. ⚠ OI-194 is
  still gating and went undiscussed for a fourteenth day.
- ⚠ **The document Rebecca Marmo shared** with Fabrizio Mastracci. Seventh run.
- **The WooCommerce logic document** for Daniela Morgese — eighth run.
- **The 12:30 CEST internal call of 25/09** — still no artifact, fourteenth run.
- ⚠ **The Pienissimo lead documentation** Elena Spini said she owed on 28/09.
- ⚠ **Sabatino Rinaldi's card and PayPal test orders** — WhatsApp is not a source
  this procedure can read.
- ⚠ **The `ai-visibility-fmf` form check** Elena Spini posted on 08/10 — fourth
  run, screenshot never opened, **still no owner**.
- **The WhatsApp number Matteo Distaso owes Fabrizio Mastracci** — third run; it
  gates the pre-UAT dry run of the two commissioned forms.
- **Fabrizio Mastracci's `testlist degli invii`** — second run, named in the
  marketing DM on 12/10, in no source. ⚠ He said _"domani facciamo un giro"_ —
  that was today, and nothing records it happening.

## Absence of evidence, stated as absence

- **Fathom returned no Pienissimo meeting** — sixteenth consecutive run. It did
  return one call, for another client, so the tool is working.
- **`#tproj-pienissimo` was silent a fourth day.** 🔴 **The dev group too:
  twenty-three consecutive nightly reports with no human reply.**
- **Nothing was found on [OI-212](../items/OI-212%20A%20Ri.Ba.%20rate%20reads%20as%20paid%20before%20its%20due%20date.md)**
  in any source — not a mail, a message, a meeting, a commit or a ruling. **Fifth
  night, and its confirmation date has now passed.**
- **Nothing on OI-210** — the `NR_Tranche` / one-article contradiction — in any
  source. **Seventh night.**
- **Nothing on the Business Blueprint** at all: no signature, no artifact, no
  mention. The 09/10 _"confermato e firmato"_ claim is unsupported a **third** run.
- **Nothing on OI-227.** Whether the rewritten `SAL-20` was agreed is unanswered a
  second day, by anyone.
- **Nothing on OI-194**, OI-202, OI-204's documentation half, OI-205, OI-206's
  missing reports, OI-216 or OI-218.
- **Nothing on OI-222 or OI-224.** Marco Montesi's original templates question is
  **unanswered a ninth day**, and Sabatino Rinaldi has not answered the
  mass-Opportunity escalation. 🔴 **Neither man appears in any source this run** —
  Sabatino Rinaldi only as a cc on the DocuSign forward.
- **Nothing on OI-226** — no business call booked, no owner, no date for the
  gruppo-merceologico reversal. The Zoho dismissal is **31/10**, and the 13/10
  session confirmed the gruppo merceologico is now on the product layout, which
  entrenches the provisional mapping further.
- **Nothing on OI-96's `E10` collision** — ⚠ and today's change makes it moot
  without fixing it, because E10 has no active product left to map.
- **No reply to Elena Spini's 12:47:00Z request for written confirmation** of the
  amended logic document, now **twelve days** old.
- **Which agent code to use for an agentless WooCommerce order is still
  unanswered** — OI-214's gating half, and nothing in the 14/10 e2e scope
  exercises it.
- **The QR credential rotation has still not happened** — seventh day since it
  left ROMI, and nothing in any source mentioned it.
- **Rebecca Marmo's two funnel questions remain unanswered** — WhatsApp parallel
  or backup, and which event date stops the send.
- ⚠ **"Claudio" is still unresolved**, credited by Elena Spini on 06/10. **No
  person note was created and nothing was attributed.**
- ⚠ **"Giuliano Lanzetti"**, the sender identity on OI-225's failing email, still
  matches nobody in the records. ⚠ **"Tech Romi" (`005SW00000PV5Ja`) is new
  tonight** and is likewise in no person note — nothing establishes whether it is a
  person or an integration user.
- **Elena Spini's post-launch support estimate** is not in any source.
