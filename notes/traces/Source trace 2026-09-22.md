---
id: trace-2026-09-22
type: reference
status: active
updated: 2026-09-22
watermark_used: 2026-09-21T22:00Z
external_watermark: 2026-09-22T22:00Z
account: a.mrruku@romicompany.com
---

# Source trace 2026-09-22

**Watermark for the next `requirements-check` run: 2026-09-22T22:00Z, single value.**

**Watermark used: 2026-09-21T22:00Z** — the `external_watermark` of
[the 21/09 trace](Source%20trace%202026-09-21.md), the newest note in this folder by
`updated:`.

**A single working day, and five meetings.** The window is 24 hours wide and it holds
more decided material than the four-day window before it — **and its most important
finding is that the previous run's headline was wrong.**

## Sources searched

| Source     | Query / scope                                                                                            | Result                                                                                  |
| ---------- | -------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------- |
| **Gmail**  | `pienissimo after:2026/09/21 -in:draft`, 40 results                                                      | 🔑 **11 in-window threads** — three Gemini notes mails, three client mails, five invitations |
| **Gmail**  | both client domains + `fabrizio.pienissimo@gmail.com` in `from/to/cc/bcc`, `after:2026/09/21 in:anywhere` | 2 threads, both already surfaced by the keyword query                                   |
| **Gmail**  | threads `1a0c9d4a7c6c7850`, `1a0c9802e6cd0d6a`, `1a0c97e26bb9ed85`, `1a0c94b3e53d6ad5` **read in full**   | 🔑 Mirko Merendi's field list (§4), the two screenshot mails (§5), the ingressi conversion factor (§6) |
| **Slack**  | workspace-wide incl. private + DMs, `after:2026-09-21`, by timestamp, 20 results                          | 🔑 the client-validated UAT calendar (§3) and the lead record-type failure (§7)           |
| **Slack**  | DM `D0B5QHS2T7H` (Elena Spini), 24 messages from 22/09 00:00 CEST, read in full                           | 🔑 _"i lead scendono senza record type"_ + the QR-code focus at 10:27 CEST               |
| **Slack**  | `C0BQD34LLF4` (dev group), 6 back                                                                        | 3 build instructions from Aurel Mrruku in Albanian (§8); **no human reply to the report, sixth night** |
| **Slack**  | `#tproj-pienissimo` (`C0B5T3RB4FM`) via the workspace search                                             | 🟢 Elena Spini 22/09 18:37:25 CEST — the **client-validated** UAT calendar               |
| **Drive**  | `modifiedTime > '2026-09-21T22:00:00Z'`, 2 pages                                                          | 🔑 **five meeting artifact sets** + `Articoli Salesforce.xlsx` re-saved at 14:36:37Z     |
| **Drive**  | **five documents read** — Spacchettamento notes+transcript (67,808 chars), QR Code notes (70,303, summary read in full), Test Mexal notes (131,096, summary read in full), Update Interno transcript (15,361), Pre-UAT Parte 2 transcript (36,771) | 🔑 §1, §2, §6, §7 |
| **Fathom** | `list_meetings created_after 2026-09-21T22:00Z`, 3 pages                                                  | **0 meetings** — everything recorded to Drive, as on 17/09 and 21/09                     |
| **Git**    | `fetch --all --prune`, `log --all --since`, 11 branch heads, 3 commits inspected                          | 🔑 §8                                                                                    |
| **GitHub** | `list_pull_requests state=all`, 8 newest by `updated`                                                     | **#54 merged 07:38:02Z; #55 and #56 open, both against `DevMain`**                       |
| **Repo**   | `AGENTS.md`, the skill, `drill-meeting`, the write protocol, `MAP.md`, `INDEX.md`, the 21/09 trace, OI-143, OI-144, OI-146, OI-154, OI-156, OI-158, the register's `state_machines` and `ORD-02`/`ORD-03` | read directly |

## Found

### 1. 🟢🔑 The 21/09 headline was wrong, and two client sessions say why

[OI-143](../items/OI-143%20The%20tranche%20invoice%20date%20must%20be%20re-keyed%20by%20hand%20into%20Mexal.md)
recorded that an administration user must read tranche dates in Salesforce and **re-key
them by hand into every Mexal invoice**, and that the date is the only join key. **Neither
is true.**

- 🟢 **The dates already travel.** Fabrizio Paganelli demonstrated a Plus order on Mexal
  at [11:22](../meetings/2026-09-22%20Logiche%20Spacchettamento%20Righe.md): **12 lines,
  one article code, a `data scadenza` typed on each**, and _"passerà paro paro su
  Mexal"_. This is current practice, not a proposal.
- 🟢 **Invoice date and due date are not meant to coincide.** The line date is
  commercial; administration invoices on the 1st for a line due at month end.
- 🟢 **The join key is structural.** Mirko Merendi named the fields at
  [15:00](../meetings/2026-09-22%20Test%20Mexal.md): invoice ← **sigla + numero ordine**;
  scadenziario ← **codice cliente, serie documento, numero documento, data documento**.
  Order creation was **proved live on the API** in the same session, returning a document
  number Mexal assigned itself.
- 🔴 **Matching on the date would have been actively wrong.** A Ri.Ba. returned unpaid
  regenerates the due date; recovery plans are agreed case by case. _"sulle date di
  scadenza è bene non fare nessun tipo di automatismo di programma."_

🔴 **What survives is the identifier**, and the two sessions do not close on the same
object: the morning agreed an order **line** number, the afternoon settled on Mexal's
**order** number. →
[OI-166](../items/OI-166%20The%20order%20line%20needs%20a%20shared%20identifier%20for%20Mexal.md)

### 2. 🟢 The agreed mechanisms, and one built the same day

- 🟢 **A tranche count on the product** explodes a Plus order into n lines with a date
  grid. Agreed 11:22, vendor-confirmed 15:00, **demonstrated working 17:00**. Cadences
  5, 10, 12. →
  [OI-167](../items/OI-167%20Plus%20orders%20explode%20from%20a%20tranche%20count%20on%20the%20product.md)
- 🟢 **Bundles already reach Mexal as component lines**, with the total spread weighted by
  listino and quantity plus a manual per-line override. →
  [OI-144](../items/OI-144%20Bundles%20must%20be%20split%20into%20order%20lines%20for%20Mexal.md)
  **resolved**
- 🔴 **Line-level payment conditions are impossible** — header only, no hidden fields, the
  only line field is the due date — and the group chose **unanimously to change commercial
  behaviour instead**, without defining what that means. The Mastery keeps no mechanism at
  all. →
  [OI-160](../items/OI-160%20Payment%20conditions%20cannot%20vary%20by%20order%20line.md)
- 🟢 **Salesforce sends a simple order; a scheduled Mexal job** by Mirko Merendi fills
  provvigioni, tipo merce and contropartita di riga. **`codice agente` comes from the
  customer, not the operator.** →
  [OI-169](../items/OI-169%20Agent%20code%20and%20commissions%20come%20from%20the%20customer%20record.md)

### 3. 🟢 UAT is re-validated by the client, and the missing session was an oversight

Elena Spini, `#tproj-pienissimo` **22/09 18:37:25 CEST** — _"Calendario aggiornato e
validato dal cliente per gli UAT"_:

| Date | Topics |
| ---- | ------ |
| 24/09 | Lead diretta/standard · Opportunità vendita standard + preventivo DocuSign |
| **25/09** | 🟢 **Opportunità recall tutor >> WooCommerce e Link di Checkout + Ordine su SFDC** · vendita standard con Bundle + preventivo DocuSign |
| 30/09 | Biglietti (Asset), Campagne ed Eventi |
| 02/10 | Flussi Marketing Cloud Biglietti |
| 05/10 | Opty Performance Plus + Gestione date pagamento + **Contratto** |
| 06/10 | Integrazione Mexal ↔ Salesforce + **Anticipay (per check P.Iva)** |

The seventh topic was **lost when the dates were rewritten** — Elena Spini:
_"mi sono persa quello di WooCommerce"_ — not dropped. Two updated invitations went out
16:34–16:35Z. **1 October is gone** (San Marino holiday); Fabrizio Paganelli's written
request for 3 or 4 October **still has no written answer**. →
[OI-158](../items/OI-158%20No%20UAT%20session%20is%20booked%20for%20the%20checkout-link%20flow.md)
**resolved**

### 4. 🔴 Mirko Merendi's field list, sent to the client after the call

**22/09 15:54:41Z**, to Fabrizio Paganelli and Elisa Migliano, cc ROMI. Eight order
fields and four customer fields the old import filled and Salesforce does not, with the
question of who fills what put **to the client**. `Gestione ratei di riga (data inizio e
data fine)` is the one item nothing in this record accounts for. →
[OI-159](../items/OI-159%20Mexal%20order%20fields%20Salesforce%20does%20not%20populate.md)

### 5. 🟢🔴 The article classification was there, and its legend is unreadable

🟢 **`natura articolo` carries the whole four-way classification** — Fabrizio Paganelli,
verbatim: _"Natura è genera biglietto, solo bundle / non genera biglietto, solo bundle /
genera biglietto, altri ordini / non genera biglietto, altri ordini."_ **The 21/09
reading was wrong about the substance.** Aurel Mrruku confirmed it on the same file in
the same session.

🔴 **The transcodifica arrived as two screenshot-only mails** — 14:21:22Z `Natura
Articoli` from **`direzione@pienissimo.pro`** and 14:23:34Z `Categoria Statistica
Articoli` from `fabrizio.p@pienissimo.com`. Each body is a single embedded `image001.png`
with **no text**, so **no tool available to this job can read the legend**. ⚠ The
`direzione@` mailbox is new to this record and **has not been attributed to anyone**.

🟢 `Articoli Salesforce.xlsx` was re-saved at **14:36:37Z**. **Not opened** — real
customer and catalogue data. →
[OI-154](../items/OI-154%20The%20client%20import%20extraction%20is%20missing%20the%20article%20classification.md)

### 6. 🔴 A scanner app nobody had recorded, and an ingressi request on a suspended build

🔑 **The event check-in application.** Andrea Parmeggiani runs a **custom Android app**
over REST to Zoho, TestFlight + APK, refreshed ~90 days, with an **Infopoint** desk mode.
Everything this record holds about QR codes is about *generating* them. Elena Spini named
it: _"di questa app non ne hanno mai parlato"_, and she had read _"QR code fatto"_ as
including the scan. Fase 1 scope cut to **the asset update only**; Infopoint deferred to
Fase 2. →
[OI-161](../items/OI-161%20The%20event%20check-in%20app%20must%20integrate%20with%20Salesforce.md),
[OI-162](../items/OI-162%20Infopoint%20and%20orphan%20tickets%20are%20deferred%20to%20Fase%202.md)

🔴 **And the client extended `ingressi` in writing** at **15:05:00Z**: a **conversion
factor on the product** to determine the number of entries. Aurel Mrruku deferred it two
minutes later without mentioning that the build is suspended. 🔴 The app's agreed scope is
**one check-in per event**, where `ingressi` records each entry — a direct collision
nobody discussed. →
[OI-146](../items/OI-146%20Ingressi%20structure%20for%20multi-day%20events.md)

### 7. 🔴 Two days before Lead UAT, the Lead path has three open problems

- 🔴 **Leads land with no record type** — Elena Spini's Web-to-Lead test, **18:18 CEST**,
  with the submitted `recordType` present and the created Lead untyped. →
  [OI-164](../items/OI-164%20Web%20to%20Lead%20leads%20arrive%20without%20a%20record%20type.md)
- 🔴 **Conversion has no duplicate rule** — raised by the developers; the direction is
  dedupe on P.IVA alone, undecided, never put to the client. →
  [OI-163](../items/OI-163%20Lead%20conversion%20has%20no%20agreed%20duplicate%20rule.md)
- 🔴 **A conversion-blocking `agente` rule was built mid-session** while the client
  _"is going to think about it"_. →
  [OI-169](../items/OI-169%20Agent%20code%20and%20commissions%20come%20from%20the%20customer%20record.md)

🟢 Also from the pre-UAT session: **quote → DocuSign → signed → order ran end to end**.
🔴 **Contract logic has not been started** and `Contratto` is on the 5 October agenda. →
[OI-168](../items/OI-168%20Contract%20logic%20is%20not%20started%20and%20is%20on%20the%205%20October%20UAT.md)
🔴 **Data migration was never planned or estimated.** →
[OI-165](../items/OI-165%20Data%20migration%20was%20never%20planned%20or%20estimated.md)

### 8. The build: 3 commits, 1 merge to `DevMain`, 2 open PRs

| Commit    | Author       | CEST        | Where                                                         |
| --------- | ------------ | ----------- | ------------------------------------------------------------- |
| `cf9b6b6` | aureliii     | 22/09 09:38 | 🟢 **PR #54 merged — DocuSign metadata on `DevMain`**          |
| `ab47b42` | Rexhina Hysi | 22/09 09:52 | 🔴 **three classes → `without sharing`, one created that way** |
| `2ed301b` | Anita Aga    | 22/09 09:59 | `Gestisci Prodotti` component                                  |
| `54e0be1` | Rexhina Hysi | 22/09 17:57 | **two Lead record types `Diretta` / `Standard`**, `Tipo_Opportunita__c`, DocuSign tag |
| `7b7d8a5` | Anita Aga    | 22/09 18:12 | DocuSign logic + Opportunity product adding                    |

🔴 **`ab47b42` says what it did**: _"batch to updated state and added some without
sharing"_ — `QuoteAcceptanceEmailController`, `QuoteLineItemTriggerHandler`,
`QuoteLineItemsController` flipped, and `QuoteNegotiationAgingBatch` created
`without sharing`. **Five in the quote stack; eleven already on `DevMain`.** →
[OI-156](../items/OI-156%20QuoteTriggerHandler%20runs%20without%20sharing.md)

🔑 **The same commit automates the quote state machine**: a quote in `In Trattativa` for
5 days moves to `In Attesa Accettazione`, daily at 03:00, on a new `In_Trattativa_Dal__c`
field. 🟢 That **implements the register's agreed _"Validity 5 days"_ rule** — the first
movement on that state machine in fifteen days. ⚠ The code's labels confirm the
register's are the stale ones, and the register's day-2 and expiry alerts are not built.

🔴 **`Standart` is now inconsistent with itself**: six places on `DevMain`, while the new
Lead record type is spelt **`Standard`**. →
[OI-140](../items/OI-140%20Three%20Opportunity%20record%20types.md)

🟢 **Both open PRs (#55, #56) target `DevMain`** — the `main`-as-target pattern did not
recur.

⚠ **`54e0be1` also edits `notes/items/OI-149` and `OI-150`** on `DEV_leadDiagnose`, and
the edits are **clean**: proper frontmatter, `updated:` bumped, no price or personal
datum, and they record a **check-only Salesforce deploy** (`0AfMA00000Cl1rN0AR`). Second
time developers have maintained `notes/` themselves.

### 9. Aurel Mrruku's three build instructions in the dev group

`C0BQD34LLF4`, in Albanian, during the Test Mexal call:

- **15:51:09 CEST** — the User gets an `agente` field, the Account links to that user, and
  on order creation the value is read from the Account into `codice_agente`.
- **16:04:19 CEST** — a screenshot (577.8 KB).
- **16:32:18 CEST** — the product's **Descrizione Categoria** will be the key linking it
  to the **parent campaign**.

⚠ **No human has replied to a nightly report in six nights**, though the channel itself
is active.

### 10. Excluded as other clients

**Teatro Franco Parenti** (a Salesforce POS thread in `#team-romi-tech`) · **Vision**
(five B2B Commerce integration documents by `d.losco@romicompany.com`, and a credentials
thread) · **247** (FileMaker report PDFs) · **Piemontese** · **Interstudio Viaggi** ·
**Pulingross** · **Permo** · **LIFE365** (its own nightly job posted at 23:22 CEST in a
different group DM). Not ingested, by the convention the 18/08, 31/08, 01/09 and 21/09
traces applied.

## What it changed

**Five meeting notes created. Eleven items created. Eight items, one person note and one
register field updated. The register's prose was not rewritten, and `ORD-02` is no longer
contradicted by the date argument.**

| Written                                       | Because                                                       |
| --------------------------------------------- | ------------------------------------------------------------- |
| 5 × `notes/meetings/`                         | the five sessions drilled                                      |
| `OI-159`–`OI-169`                             | eleven findings with no existing row                           |
| `OI-143`                                      | **superseded** — the premise dissolved; the 21/09 body kept verbatim |
| `OI-144`, `OI-158`                            | **resolved**                                                   |
| `OI-142`                                      | **superseded** on its shape                                    |
| `OI-154`                                      | **corrected** — the classification is there, encoded           |
| `OI-24`, `OI-50`, `OI-140`, `OI-146`, `OI-156` | moved by this window                                          |
| `notes/people/Andrea Parmeggiani…`            | he owns a second Fase 1 integration                            |
| `requirements/…yaml`                          | `ORD-02.tracked_by` gained `OI-167` — the only register change  |
| `MAP.md`, `INDEX.md`                          | the live position, 16 new rows, this trace                     |
| `open-items.md` / `.it.md`                    | **rows 159–169 new; rows 24, 50, 140, 142, 143, 144, 146, 154, 156, 158 updated — both languages** |
| `DEVELOPMENT-RECAP.md` / `.it.md`             | §44, both languages                                            |

### Why the register's prose was not rewritten

🟢 **`ORD-02` reads better today than yesterday.** _"the whole order then goes to Mexal
with both values at line level"_ is exactly the client's practice, and the bundle clause
is answered by `OI-144`. The 21/09 trace recorded it as contradicted; that judgement is
withdrawn on the date argument.

⚠ **One mechanical hop is still open** — which order *line* a payment settles
(`OI-166`) — and `REQUISITI.it.md` is the text the client signs. Editing it now would
mean writing a mechanism that the next Mirko Merendi call may change again. `tracked_by`
was extended so the new mechanism is walkable from the register instead.

⚠ **The rest is new scope nobody has allocated an id to**: the check-in app, the ingressi
conversion factor, the per-line accrual dates, the Lead duplicate rule. **Allocating a
requirement id is a human's call, not a sweep's.**

## Triggers

**Discharged this run:**

- 🟢 **The manual re-keying trigger** — armed 21/09 as _"the single most important unsaid
  thing on the project"_. **Discharged because the premise dissolved.** Nobody needed to
  be told, because it was never true. **This is the trigger's own failure mode worth
  remembering: it was armed on a finding, not on a fact.**
- 🟢 **The missing-UAT-session trigger** — the session is booked for 25/09 and the client
  re-validated the calendar. Discharged.
- 🟢 **The `main`-as-PR-target trigger** — both new PRs target `DevMain`. Quiet.
- 🟢 **The order-lines trigger** — the session ran and settled the design. Discharged.

**Still armed, and sharper:**

- 🔴 **The `Standart` trigger fires for the fifth run, and it got worse.** UAT opens
  **24/09**, in two days, and the org is heading for `Lead.Standard` beside
  `Opportunity.Standart`. _Say so as a data-permanence problem every run until it is
  fixed or records exist._
- 🔴 **The `without sharing` trigger fires.** It is still `without sharing`, nothing
  records why, and **four more were added the day before UAT opens**. _Escalate it as a
  house style on guest-reachable paths, not as an isolated line._
- 🔴 **The `ingressi` suspension trigger fires harder.** Five days unlifted, and the
  client has now built on top of it in writing. _If the next run finds no decision, say
  that ROMI is taking written requirements for a structure it has told its own developer
  not to build._
- 🔴 **NEW — the Lead UAT trigger.** _If 24/09 arrives with leads still landing untyped,
  or with no duplicate rule, the first client acceptance session tests a path with two
  known defects. Report the state of `OI-163`, `OI-164` and `OI-169` on the next run
  before anything else._
- 🔴 **NEW — the contract trigger.** _`Contratto` is on the 5 October agenda and nothing
  exists. If the next runs show no start, say that a client acceptance session is booked
  against unbuilt scope, and that the questions Aurel Mrruku needs are still unwritten._
- 🔴 **NEW — the unreadable-legend trigger.** _If the `natura articolo` and `categoria
  statistica` legends are still only screenshots by 30/09, ticket UAT runs on a
  classification no one has transcribed._
- 🔴 **NEW — the migration trigger.** _Go-live 21/10, Zoho off 31/10, and the migration
  has no estimate and no production sequence. Report it every run until a plan exists._
- 🔴 **The `OI-136` decision trigger is unchanged** — the code is gone, nobody ruled,
  **Elisa Migliano still has not been asked.**
- ⚠ **The `DGM-2` trigger owes a read**, seventh run — `Flows & Objects.drawio` did not
  move in this window.
- 🟢 **The quote-state trigger finally moved**, after fifteen days — by an implementation,
  not a decision.

## Deliberately not done

- **Nothing was sent, replied to, drafted, shared, modified or marked read on any external
  source.** The single Slack report to `C0BQD34LLF4` is the one message this run posted,
  under the nightly carve-out in
  [the skill](../../.agents/skills/requirements-check/SKILL.md).
- **No Apex test class was written, proposed or scaffolded.**
- **`notes/items/OI-149` and `OI-150` were deliberately not edited**, although this window
  moved both. PR #55 carries note edits to exactly those two files, and editing them on
  `DevMain` would land a merge conflict on a developer. The facts are recorded in the new
  items and here instead. **Say so, rather than letting the next run think they were
  missed.**
- **[STATUS.md](../../STATUS.md) was not regenerated.** Its basis is a live org check
  (2026-09-14 10:51Z) and this run has **no org evidence**. The org record is now **~8
  days old** and predates every commit in §8. The Notion mirror stays stale by the same
  margin.
- **The org was not opened.** Every build claim here is repository arithmetic against
  `origin/DevMain` at `cf9b6b6`, plus the deploy id the developers recorded themselves.
- **Three recordings were not opened** — 750 MB, 525 MB and 416 MB; the notes and
  transcript documents carried the content.
- **The two screenshot mails could not be read** (§5) — not a choice, a tool limit.
- **`Articoli Salesforce.xlsx` was not opened**, nor any client migration file.
- **No price, article code, account code, credential, token, VAT number or personal datum
  entered the repository.** Specifically withheld: the test customer code mailed at
  13:25Z, the Mexal account code used in the live API test, the order number it created,
  the `FM`-prefixed test article codes, the org and record-type ids in Elena Spini's
  web-to-lead dump, the test email address, and the personal matter captured on the
  11:22 recording after the call ended.

## Gaps in this run

- 🔴 **Leads land with no record type, two days before Lead UAT.**
- 🔴 **Lead conversion has no duplicate rule**, and a conversion-blocking `agente` rule is
  being built while the client considers it.
- 🔴 **Contract logic has not been started** and is on the 5 October agenda.
- 🔴 **Data migration was never planned or estimated**, with go-live 21/10.
- 🔴 **The check-in app integration has nothing built**, with ticket UAT 30/09.
- 🔴 **Four more classes run `without sharing`**, in a commit that says so.
- 🔴 **`Standart` is two days from becoming permanent, and now inconsistent.**
- 🔴 **The `ingressi` suspension is five days old and the client extended it.**
- 🔴 **Nobody has answered Mirko Merendi's field-split question.**
- 🔴 **The article legend is unreadable**, and ticket UAT depends on it.
- ⚠ **The Mastery instalment case has no mechanism at all.**
- ⚠ **Fabrizio Paganelli's request for 3 or 4 October still has no written answer** — two
  days.
- ⚠ **No human has answered a nightly report in six nights.**
- ⚠ **`MAP.md` is ~140 KB against a stated 5 KB budget** — **twelfth consecutive
  request; no run has been authorised to act on it.**

## Method

**The lesson is about yesterday, not today.** The 21/09 run reached a hard, specific,
well-evidenced conclusion — Mexal cannot receive an invoice due date, therefore a human
must re-key it — and armed a trigger calling it _"the single most important unsaid thing
on the project"_. **Twelve hours later the client demonstrated that the process it
described has never existed.** Nothing in the 21/09 evidence was false: the fields are as
described, `Scad PG` is derived, invoices are made by hand. **What was wrong was the
inference**, built entirely from a ROMI-internal call between two developers reasoning
about a client's accounting process **without the client in the room.**

The cheapest available check would have been to ask what the client does **today** — the
question Fabrizio Paganelli answered in his first five minutes by sharing his screen.
**A process finding derived only from internal sources deserves the hedge that no
technical finding needs**, and the 21/09 note did not carry one: it stated the manual
re-keying as the agreed process, when it was a deduction nobody had put to the party who
would have to do it.

**What held up well** was the drilling discipline. Both corrections — the tranche
mechanism and `natura articolo` — sit in the *middle* of transcripts, in passages a
summary reduces to _"discussed the tranche handling"_ and _"reviewed the data
extraction"_. The Gemini decisions block for the 11:22 session lists the agreements but
**not the correction**, because nobody in the room thought they were correcting anything.
They were just describing their job.
