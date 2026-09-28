---
id: trace-2026-09-16-nightly
type: reference
status: active
updated: 2026-09-16
watermark_used: 2026-09-15T22:00Z
external_watermark: 2026-09-16T22:00Z
mail_watermark: 2026-09-11T22:00Z
account: a.mrruku@romicompany.com
---

# Source trace 2026-09-16

**Watermark for the next `requirements-check` run: 2026-09-16T22:00Z — except
Gmail, which stays at 2026-09-11T22:00Z.**

🔴 **The split watermark is now five days wide and has survived three
consecutive runs.** Gmail answered _"needs you to sign in again"_ and the
connector then disconnected, in a non-interactive session, so **zero mail
queries ran**. **Do not collapse the two values.** Mail was **not searched**; it
did not return nothing. The `[LIFE365]` sibling job reports the same failure on
its own run tonight, so this is the connector, not this project.

**Watermark used for this run: 2026-09-15T22:00Z**, the `external_watermark` of
[the 15/09 trace](Source%20trace%202026-09-15.md), which is the newest note in
this folder by `updated:`. JOURNAL's newest entry was 15/09, so the two agreed.

## Sources searched

All read-only. **Nothing was sent, replied to, drafted, shared, modified or
marked read.** This is the **scheduled nightly run**, so the single Slack
carve-out applied: one report to `C0BQD34LLF4`, the ROMI Salesforce dev group.
No other message was sent anywhere.

| Source     | Query / scope                                                                                       | Result                                                                                              |
| ---------- | --------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------- |
| **Gmail**  | `pienissimo after:2026/09/11 -in:draft`                                                             | 🔴 **NOT SEARCHED** — sign-in required, connector then disconnected                                 |
| **Slack**  | workspace-wide incl. private, DMs and group DMs, keyword `pienissimo`, `after:2026-09-15`, by timestamp | 2 results — the `[LIFE365]` sibling report and the Andrea Di Cicco group DM (§4)                 |
| **Slack**  | workspace-wide `after:2026-09-15`, **no keyword**, sorted by timestamp, 20 results                  | 20 live results back to 16/09 17:43 — surfaced the Elena Spini DM (§3); the rest BE-MA, 247, time-tracking, `#gen-idee` |
| **Slack**  | DM `D0B5QHS2T7H` (Aurel Mrruku ↔ Elena Spini)                                                       | **6 new on 16/09, 18:51–19:04 CEST** — §3                                                           |
| **Slack**  | DM `D0B33NLB7NF` (Aurel Mrruku ↔ Rexhina Hysi), 25 messages                                         | **4 new on 16/09** — §5                                                                             |
| **Slack**  | group DM `C0BFDNXQKAS` (Aurel Mrruku, Andrea Di Cicco, Elena Spini)                                 | **4 new on 16/09, 18:01–18:04 CEST** — §4                                                           |
| **Slack**  | DM `D0AQ0FMHFM1` (Aurel Mrruku ↔ Andrea Di Cicco), 8 messages                                       | **unchanged since 14/09 17:28:57 CEST** — two days silent                                           |
| **Slack**  | DM `D0BKK1D5GF9` (Aurel Mrruku ↔ Anita Aga), 5 messages                                             | **unchanged since 10/09 14:45:51**                                                                  |
| **Slack**  | `#tproj-pienissimo` (`C0B5T3RB4FM`), 6 messages back                                                | Last status post still **04/09 19:48**, **twelve days**; still says **go-live 6 October**            |
| **Slack**  | `C0BQD34LLF4` (the dev group), 5 messages back                                                      | **No human reply to the 15/09 report** — the newest message is that report itself                   |
| **Slack**  | canvas `F0BD2H5A9HT` (`Link utili Pienissimo`) re-read in full                                      | **unchanged**; newest entry still **20.08.26**, now eleven client sessions behind. It carries the **NotebookLM** link that §3 came out of |
| **Drive**  | `modifiedTime > '2026-09-15T21:00:00Z'`, paged                                                      | 5 items — **the Parte 5 folder, the workbook and the `.drawio`** (§1, §6, §7); the rest Permo and 247 |
| **Drive**  | `title contains 'Data Model Parte 5' or (title contains 'Pienissimo' and modifiedTime > watermark)`  | 7 items — the meeting folder, the Gemini notes doc, the recording, the workbook                     |
| **Drive**  | Gemini notes `19DNxe_bQKgiZI7u7y__jaiG4X-n8N0FcsTmTbz1ris0` read in full (158,783 chars)            | **the bulk of this run** — §1                                                                       |
| **Fathom** | `list_meetings` from 2026-09-15, 3 pages                                                            | **1 meeting, and it is another client** — _Stato avanzamento rilascio in prod._, 247. Parte 5 was recorded by Gemini on Meet, not Fathom |
| **Git**    | `git fetch origin --prune`, `git log --all --since='2026-09-15 21:00'`, all eight branch heads      | **8 commits** — §2, §5, §8                                                                          |
| **Git**    | `4132dab` read in full; `0d2b779` diffstat; `Full_Permission` diff and file; `git log -S Edit_Mexal_Synced_Admin_Fields`; `7cabe51` and `46d22c5` diffstats; both branch notes read | §2, §5, §8 |
| **GitHub** | `list_pull_requests` state `all`, 6 newest, sorted by update                                        | **#45 merged 08:21:19Z · #46 merged 08:23:33Z (back-merge) · #47 OPEN**; **no PR from `DEV_ComponentBundle`** |
| **Repo**   | `AGENTS.md`, `MAP.md` (head), `INDEX.md` (targeted), the write protocol, the skill, the 15/09 trace, OI-24/49/50/59/102/110/115/117/121/136, the register at SAL-15→SAL-23 | read directly |

## Found

### 1. 🟢 Data Model Parte 5 — the largest single set of rulings this project has had

**16 September, 11:00 CEST, client-facing, 2h21m30s against a two-hour
booking.** Drilled from the Gemini notes in full
([the minute](../meetings/2026-09-16%20Data%20Model%20Parte%205.md)).

Speaker turns from the transcript: **Elena Spini 573, Elisa Migliano 557, Aurel
Mrruku 542, Fabrizio Paganelli 4** — he greeted the room, announced Elisa
Migliano was arriving and dropped off at ~00:06 (_"mi distac[co]"_). **Sabatino
Rinaldi was invited and did not attend.**

**Ten rulings**, covering the product registry, the quote and the **order header
only** — lines were deferred. The two with the widest blast radius:

- 🔑 **A won quote and its accepted order freeze.** Aurel Mrruku: _"Se l'offerta
  è stata vinta viene creato l'ordine e poi viene sigillato sia l'offerta che
  l'ordine… non puoi fare nessuna modifica."_ Two independent justifications were
  stated, one per side — contractual (Elisa Migliano: the contract sits under the
  order) and technical (Aurel Mrruku: _"se cambia il codice articolo cambiano i
  prezzi"_). **New:
  [OI-138](../items/OI-138%20Quotes%20and%20orders%20freeze%20once%20the%20order%20is%20accepted.md).**
- 🔑 **`Codice agente`, `classificatore rete` and `codice zona` are historicised
  on the quote and the order.** Elisa Migliano, with a worked example: a later
  reassignment on the Account reaches only the **next** order. **Third
  independent statement of the freeze rule**, and it now binds the preventivo
  too — while the Mexal `Creazione Ordine cliente` body still carries none of the
  three ([OI-110](../items/OI-110%20Agent%20and%20network%20fields%20are%20missing%20from%20the%20Mexal%20order%20call.md)).

Also settled: product fields pruned (**San Marino has no VAT**; Mexal uses fixed
exemption codes), `NR` whole-number unit of measure, **product active state owned
by Salesforce and never overwritten by Mexal**, **`natura` → `genera biglietto` +
`is bundle`** via a custom transformation, `tipo biglietto` =
`Executive`/`Gold`/`Diamond` and **not mandatory**, `livelli 0–6` as picklists,
`Tipologia attività` on the **Locale** Account pre-filling the quote
([OI-115](../items/OI-115%20Tipologia%20Attivita%20values%20and%20its%20move%20to%20the%20quote.md)),
quote name = number + partita IVA, **five-day** quote expiry, and a lost primary
quote closing its opportunity as lost.

🔴 **Three things were left open**, and all three need someone who was not in the
room: post-event tutor sales possibly **bundles only** (Sabatino Rinaldi);
**complex tutor quotes with no tranche mechanism**, deferred to Friday
([OI-50](../items/OI-50%20Tranche%20object.md)); and **multi-product,
non-bundle checkout links** ([OI-49](../items/OI-49%20WooCommerce%20checkout-link%20flow.md)).

⚠ **A Salesforce platform incident ran through the morning** — Aurel Mrruku
opened the call with _"Oggi proprio disastro… giù tutto il mondo"_, describing UI
failures from ~09:00 CEST, corroborated in `#team-romi-tech` and in the 247
meeting summary the same day. It changed no decision; it cost a working morning
seven days before UAT.

### 2. 🟢 PR #45 merged — and a correction to last night's own record

**`0d2b779`, 08:21:19Z (10:21 CEST).** The `ORD-03`/`AC-06` tranche roll-up is on
`DevMain`. PR **#46** at 08:23:33Z is a back-merge of `DevMain` into `DevAnita`,
not new content.

✅ **The 15/09 statement _"no permission set in this commit grants it"_ was
wrong.** `400c195` granted `Edit_Mexal_Synced_Admin_Fields` in the same commit
that created it, in `Full_Permission.permissionset-meta.xml` lines 43–46.
`git log -S` on the permission-set directory returns `400c195` itself. **The
claim was read off that file's diff hunks, which show only the `MexalArticleSync*`
class removals and the new `OrderItem` field grant — the `customPermissions`
block sits outside them.**

🔴 **The real defect is narrower and worse than a missing line.**
`Full_Permission` is the **only** one of nine permission sets in `force-app/`
that grants it, and it is the all-access developer set (the 07/09 org check found
it on two of nine active users). Honouring what 03/09 promised amministrazione
means either an **amministrazione permission set that does not exist here**, or
giving amministrazione `Full_Permission` — a security regression dressed as a fix
([OI-117](../items/OI-117%20Administrative%20fields%20lock%20once%20the%20Mexal%20customer%20code%20is%20set.md)).

### 3. ⚠ A NotebookLM restatement of the WooCommerce id mechanism

DM Aurel Mrruku ↔ Elena Spini, **18:51:52–19:04:46 CEST**. Elena Spini prefaced
it _"from Notebook"_ and pasted three long blocks attributing their content to
the **Business Review of 31/07** and the **bundle demo of 16/07**. The canvas
carries the project **NotebookLM** link, which is where it came from.

⚠ **It is an AI summary of meetings this record already holds — not a new
statement by anyone**, and no participant confirmed it. Treated as such. Three
points are worth keeping because this record never named them:

1. The **WooCommerce numeric product id** and the **Mexal SKU** are different
   keys by design; the summary attributes the reassurance to Sabatino Rinaldi
   answering Fabrizio Paganelli's fear of realigning codes across three systems.
2. A **cron syncing the WooCommerce catalogue into Salesforce** was proposed, so
   every Salesforce product knows its WooCommerce id and the tutor searches by
   product name instead. 🔴 **It does not exist, has no owner and no date.**
3. The opportunity id is used rather than VAT or email because a customer with
   two open deals would be ambiguous.

Elena Spini's own closing line, 18:58:47 — _"a quanto pare Sabatino aveva
ragione..........però capiamo meglio domani quando ci sentiamo"_ — points at the
**internal meeting of 17/09**. Folded into
[OI-49](../items/OI-49%20WooCommerce%20checkout-link%20flow.md).

### 4. 🔴 Andrea Di Cicco was released from the project, owing four answers

Group DM `C0BFDNXQKAS`, 18:01:39–18:04:54 CEST. He asked whether he was needed at
tomorrow's internal Pienissimo meeting; Aurel Mrruku said no, _"forse più in
avanti per fare un check sulle api mexal ma non domani"_; Elena Spini agreed —
_"per ora ti puoi lentamente staccare 😥"_.

⚠ **A wind-down, not a departure.** The finding is that the door was left open
**in general terms** while four **specific** questions were already behind it:
OI-110 (14 days), OI-102 (8 days), OI-125 and OI-135. **New:
[OI-139](../items/OI-139%20Andrea%20Di%20Cicco%20is%20winding%20down%20with%20four%20integration%20questions%20unanswered.md).**

And **Sabatino Rinaldi is unreachable at the same time** — Elisa Migliano
reported him on tour with the client's direction, and Elena Spini and Aurel
Mrruku confirmed no WhatsApp reply the previous week either. **Both integration
counterparts are off the board with UAT seven days out.**

### 5. 🟢🔴 The `Incassato` button was removed, on a branch, with no PR and no decision

**`4132dab` (Rexhina Hysi, 09:24:55 CEST, `DEV_ComponentBundle`,
_"remove incasato button"_): 3 insertions, 122 deletions.** Read in full. It
deletes `markOrderIncassato`, `collectLinkedOrderIds`, the
`canMarkOrderIncassato` flag and the loop in `buildPage` that set it, and the
LWC button and its handler. **No `Order` DML of any kind remains in the
controller.**

🔴 **It is on `DEV_ComponentBundle` only. GitHub lists no pull request from that
branch** — the open one is #47, from `DevAnita`. The branch has since taken four
more commits on bundles, quote PDFs and the acceptance email, so the fix now
travels with unrelated work. **The guest-reachable write is still on `DevMain`
and still in UAT.**

⚠ **The sequence is: the 15/09 report at 23:51 CEST, the commit at 09:24 the
next morning. That is the entire evidence.** Nobody replied to the report, no
swept channel mentions the button, and the commit has no description. **Recorded
as a sequence, not as a cause.**

So the **second 15/09 trigger half fired**: it asked for a human *discussing* the
button; what arrived is a human **acting** on it, silently. The engineering
problem is answered and **the question the row asked is not** — nobody ruled on
whether a customer-facing actor may assert an order is collected, and **Elisa
Migliano still has not been asked**
([OI-136](../items/OI-136%20Public%20participant%20link%20can%20mark%20an%20order%20Incassato.md)).

🔑 Also in that DM, at **14:21:32 CEST**, Rexhina Hysi sent Aurel Mrruku two
partial-sandbox community URLs for review: `/participant-registration` **carrying
a live 64-hex token value**, and `/gestione-preventivo?quoteId=` **carrying a raw
18-character Quote id**. **Neither value is recorded here and neither must be.**
Two things follow: the token pattern was applied to the participant page and
**not** to the quote page, so `QuoteAcceptanceController`'s bare-id exposure is
now demonstrable from a link; and a working invitation token has been circulated
in chat, which is the fourth credential-shaped value to travel that way.

### 6. ⚠ The workbook moved during the session and was not opened

`Campi Oggetti, Flussi e Utenti Salesforce - Pienissimo.xlsx`
(`121CTGF0mCkL_hiQIZWL1aYEirqwdSVZs`), **modified 2026-09-16T11:20:06Z** — the
first movement since before the 15/09 watermark, and during Parte 5, as in
Parte 2.

**Deliberately not opened.** It is 68 KB of `.xlsx` and the session's own notes
are the cheaper and more precise source for what was decided in the same hour.
**Recorded as unread, not as unchanged** — what changed inside it is not known.

### 7. ⚠ `Flows & Objects.drawio` moved a ninth time, and was not decoded

`11ly3iGQc1smlY8IybSnUMQBGXbZ-ddbx`, owned by Elena Spini, modified
**2026-09-16T08:42:38Z** — eighteen minutes before Parte 5 began, consistent with
preparing the diagram for the session.

🔴 **Not decoded, fifth consecutive run**, for the same reason: 133 KB of mxfile
XML delivered as base64 through the Drive tool, with no way to pipe it to a shell
without first materialising ~178 KB of base64 in context. **The question it owes
is now two questions**: the 15/09 one (did the 15/09 edit touch the participant
landing flow?) and a new one — **did Elena Spini redraw the product, quote or
order model before Parte 5, and does the diagram now agree with the ten rulings?**
`DGM-2` is the `source:` of several register rows.

### 8. ⚠ Work in flight

**PR #47** — `7cabe51` (Anita Aga, opened 16:03:27Z, **open, no description**):
`MexalCustomerCreateService` gains an **Indirizzo Spedizione** endpoint (+103),
a new `OpportunityQuoteDefaultsController` (+260) with an
`opportunityNewQuoteScreen` LWC (+432) behind a **Nuovo Preventivo Standard**
quick action, `Order.Tipo_Ordine__c`, and layout/flexipage changes.
**+883 / −11 across 13 files.** Read by diffstat, not line by line.

**`DEV_ComponentBundle`** — `b834c51` (Rinuncia levelling), `4132dab` (§5),
`65818d0` (bundles in products), `01c40e6` (quote acceptance email), `46d22c5`
(quote PDF). 🔴 **Two more classes hard-code quote status spellings** — `Bozza`
and `In Attesa Accettazione`, each enforced twice — making **four since 09/09**
while [OI-59](../items/OI-59%20Quote%20workflow%20configuration.md)'s canonical
spelling is unruled for a seventh day.

⚠ **Two further developer-authored notes arrived inside those commits** —
`notes/How the Quote acceptance email action works.md` and `notes/Quote PDF
generation for Bozza quotes.md`. Both state their own limits plainly ("not
deployed or verified in an org", "no Apex test classes were created"). They are
the **fourth and fifth** notes to reach this repository through a code commit
rather than a meeting. **Left as committed; cited here, not rewritten**, and not
copied into `notes/` by this run — they arrive when the branch merges.

⚠ `DEV_ComponentBundle` is **behind `DevMain`** — it carries neither PR #45 nor
the 15/09 knowledge commit. That is an ordinary base merge, not a loss: a
pull-request merge is three-way and will not delete files the branch lacks.

### 9. ⚠ Everything else in the window belongs to another client

- **Slack** — `#team-romi-tech` on Asset migration (Riccardo Singh) and the
  Salesforce outage; `#gen-time-tracking`; `#gen-idee-e-suggerimenti-geniali` on
  passkeys after a domain change; a Sara Aga DM on 3CX; the `[LIFE365]` sibling
  report. **Not ingested.**
- ⚠ **One correction to that sibling report.** It classified the 16/09 Aurel
  Mrruku ↔ Rexhina Hysi DM as _"teatro"_ — another client. It is **Pienissimo**:
  `gestione-preventivo` and `participant-registration` are this project's
  community pages, on a partial sandbox. §5 above ingests it.
- **Drive** — Permo ×2 and a 247 folder. **Fathom** — one meeting, 247.
- **`#tproj-pienissimo`** — no status post for **twelve days**, still says go-live
  6 October, nine days after the register moved to 21 October.

## What it changed

**Three notes created, ten updated. No requirement changed in the register.**

| Written                                                             | Because                                                                    |
| ------------------------------------------------------------------- | -------------------------------------------------------------------------- |
| `2026-09-16 Data Model Parte 5`                                     | **new** — the session minute, drilled from the Gemini notes in full        |
| `OI-138 Quotes and orders freeze once the order is accepted`        | **new** — a client-agreed rule with no register row and no build           |
| `OI-139 Andrea Di Cicco is winding down…`                           | **new** — four unanswered questions behind a general release               |
| `OI-136`                                                            | removed on a branch, no PR, no decision; the live URLs in Slack            |
| `OI-117`                                                            | **a correction** — the grant existed; the defect is which set holds it     |
| `OI-110`                                                            | the freeze rule restated a third time; the wire question untouched         |
| `OI-115`                                                            | it gets a source — the locale                                              |
| `OI-49`                                                             | two new open points; the NotebookLM restatement                            |
| `OI-50`                                                             | the roll-up merged; complex non-bundle quotes have no mechanism            |
| `OI-24`                                                             | sixth session, same four gaps; the Friday double-booking                   |
| `OI-59`                                                             | two more hard-coded spellings, four since 09/09                            |
| `OI-102`                                                            | eighth day; both counterparts off the board                                |
| `OI-121`                                                            | `natura` gives the ticket flag a provenance; the table still has no rows   |
| `MAP.md`, `INDEX.md`                                                | the live position, three new notes, the trace row                          |
| `open-items.md` / `.it.md` rows 24, 49, 50, 59, 102, 110, 115, 117, 121, 136 + **new rows 138, 139** | regenerated from the notes, both languages |
| `DEVELOPMENT-RECAP.md` / `.it.md` §39                               | the session, the merge, the removal, the two counterparts, both languages  |

### Why the register was not touched

**Nothing in it became false.** That is the test the 15/09 run applied to
`BIG-18` and it is the test applied here.

- **The ten rulings specify fields and behaviour inside requirements that already
  exist.** `ORD-01`, `SAL-16`, `SAL-17`, `BIG-04` and `INT-01` all still say what
  they said this morning.
- 🔴 **The freeze is the one genuinely new rule, and it was deliberately not
  given a requirement id.** It is minuted, agreed by both sides and justified
  twice. But the register is contract-bound, and **this sweep does not invent
  requirement ids** any more than it invents decisions. It is recorded as
  `OI-138`, with the gap stated in the note and in the report: **a person should
  decide whether it becomes a numbered requirement before the client signs.**
- **PR #45 merging is custody, not scope** — `ORD-03`/`AC-06` already require
  what merged.
- **The button removal is delivery, not scope.** No requirement authorised the
  button, so no requirement loses anything by its going.

### Triggers

**The 15/09 trigger on `Edit_Mexal_Synced_Admin_Fields` fired and its premise was
false.** It said: if PR #45 merges without a permission set granting the custom
permission, amministrazione is locked out. **#45 merged with the grant in it.**
⚠ **Re-armed, narrowed:** the grant is on `Full_Permission` only. *If an
amministrazione permission set appears, or if amministrazione users are assigned
`Full_Permission`, record which — the second is a security regression and should
be raised, not filed.*

**The `MexalMaggazinoSyncBatch` trigger fired on the merge half and not on the
other.** PR #45 merged, so the warehouse batch is on `DevMain`. **It has acquired
no requirement id and no minuted request** — Parte 5 covered products and quotes
and never mentioned warehouse movements. ⚠ **Re-armed:** *a nightly warehouse
sync against the client's production ERP that nobody asked for is still scope
nobody agreed. Raise it at the first `System.schedule` call.*

**The `Incassato` trigger half fired** — §5. ⚠ **Re-armed and changed:** *the
capability is being removed on a branch; the decision is still owed. Record the
first time any human states a position — and record the merge of `4132dab`,
because until then `DevMain` is still exposed.*

**The 10/09 Kreosoft trigger did not fire. Nobody has asked him**, seventh day,
and it is now sharper: the client restated the freeze rule today, so the
requirement is three-sourced and the transport is still missing.

**The 09/09 quote-state trigger did not fire** and got two more violations.

**A new trigger:** *Friday 18/09 is double-booked — Parte 6 (Campagne/Lead,
Rebecca Marmo) and order lines. Whichever runs, drill it; if order lines take the
slot, the Lead table is deferred a sixth time and OI-24 should say so.*

**A second new trigger:** *the 17/09 internal meeting is where Elena Spini said
the WooCommerce id question would be picked up. If it produces a recording or
notes, drill it — it is the first movement on OI-49's two new points.*

## Deliberately not done

- **No mail sent, no message replied to, nothing marked read, no Drive file
  modified or shared.** One Slack message to `C0BQD34LLF4` under the nightly
  carve-out.
- 🔴 **Gmail was not searched at all**, third consecutive run.
- **No Apex test class was written, proposed or scaffolded.** Coverage is
  unchanged from the 15/09 figures; the org was not opened, so no new count
  exists.
- **The org was not opened.** Every build claim here is repository arithmetic
  against commits. The org record is now **~38 hours old** and predates PR #45,
  PR #47 and every `DEV_ComponentBundle` commit.
- **The workbook was not opened** (§6) and **the `.drawio` was not decoded**
  (§7) — both recorded as absences with the questions they owe.
- **PR #47 was not reviewed, commented on or merged**, and `4132dab` was not
  merged, cherry-picked or proposed. Not this procedure's to touch. Neither were
  the two developer-authored notes on that branch rewritten.
- **The Parte 5 recording (577 MB video) was not opened** — the Gemini notes and
  transcript are the cheaper and sufficient source.
- **No credential, token value, price, article code, VAT number, IBAN or personal
  datum** was written into the repository. §5 records that a **live invitation
  token and a raw Quote id** were circulated in Slack; **neither value appears
  here.**
- **The two `[TEST]` email PDFs and the funnel screenshots were not opened**,
  eighth run. **`Stima Task` still unattributed, ninth run.**

## Gaps in this run

- 🔴 **Gmail unreachable, three runs running.** **Five days** of the project's
  primary client channel are unread, across a window containing UAT preparation
  and the four blocking decisions put to the client on 08/09. **Still the
  highest-value action available to a person tonight.**
- 🔴 **Both integration counterparts are unavailable at once**, seven days before
  UAT, with six questions between them.
- 🔴 **A guest-reachable write to order payment state is still on `DevMain`**, and
  the fix sits on a branch with no pull request.
- 🔴 **`Tipologia attività` values owed for thirteen days**, and five more
  picklist lists were added to Elisa Migliano's queue today, only one with a date.
- 🔴 **Still nothing scheduled, and three batches wait on it.**
- 🔴 **40 of 43 ticket-generating products unmapped** (#121) — unchanged.
- ⚠ **`#tproj-pienissimo` has had no status post for twelve days** and still says
  go-live 6 October. The canvas is eleven client sessions behind.
- ⚠ **`MAP.md` is far over its own stated 5 KB budget and this run added to it
  again.** Raised 08/09, 09/09, 10/09, 11/09, 14/09, 15/09 and here — **seventh
  consecutive request; no run has been authorised to act on it.**

## Method

**The lesson of this run is that a diff hunk is not a file.** The 15/09 claim
that nothing granted `Edit_Mexal_Synced_Admin_Fields` was read off the changed
hunks of `Full_Permission.permissionset-meta.xml`, and the grant was sitting
forty lines above them, added by the very commit being examined. One `grep` of
the file would have caught it; `git log -S` confirmed it in seconds tonight.

**The corollary is narrower than "read the file":** when a claim is *absence* —
nothing grants this, nobody calls that, no requirement covers it — a diff can
never support it. **An absence claim needs a search over the whole surface, and
the surface must be named in the note.** That is now true of three corrections in
three nights: the sandbox named credential (10/09, caught 15/09), the blank Mexal
status (caught 15/09), and this one.

⚠ It is worth noticing that **both corrections this week went the same
direction** — the record understated what had been built. A sweep that reads
commits rather than code will keep finding the project more broken than it is.
