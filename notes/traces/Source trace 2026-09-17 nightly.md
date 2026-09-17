---
id: trace-2026-09-17-nightly
type: reference
status: active
updated: 2026-09-17
watermark_used: 2026-09-17T11:00Z
external_watermark: 2026-09-17T12:30Z
account: a.mrruku@romicompany.com
---

# Source trace 2026-09-17 nightly

**Watermark for the next `requirements-check` run: 2026-09-17T12:30Z, single
value.**

**Watermark used: 2026-09-17T11:00Z** — the `external_watermark` of
[the 17/09 interactive trace](Source%20trace%202026-09-17.md), the newest note in
this folder by `updated:` when this run started. JOURNAL's newest entry was also
17/09, so the two agreed. **The split mail watermark stays closed**; this run
used one value for every source.

⚠ **A short window by design.** The interactive run swept to 11:00Z and committed
`a1a4584` at **12:17Z**; this nightly fired at **12:27Z**. The window is roughly
**ninety minutes**, so a thin result is the expected result, not a failed sweep.

## Sources searched

| Source       | Query / scope                                                                                                                                       | Result                                                                                       |
| ------------ | --------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------- |
| **Gmail**    | `pienissimo after:2026/09/17 -in:draft`                                                                                                             | **empty**                                                                                    |
| **Gmail**    | `{from/to/cc/bcc:pienissimo.com, from/to/cc:pienissimo.pro} after:2026/09/17 in:anywhere` — **both domains, per the 17/09 defect**                   | 🔴 **empty — no client mail today at all**                                                   |
| **Gmail**    | `{rinaldi migliano montesi paganelli parmeggiani morgese merendi spini "di cicco" kreosoft mexal anticipay biglietto preventivo} after:2026/09/17`   | **1 thread — Teatro Franco Parenti**, and dated 08:32Z/09:31Z, before the watermark (§4)      |
| **Slack**    | workspace-wide incl. private + DMs, `after:2026-09-16`, by timestamp, 20 results                                                                     | newest result **12:26Z**, one minute before this run — **0 Pienissimo** (§2)                  |
| **Slack**    | `#tproj-pienissimo` (`C0B5T3RB4FM`), 6 back                                                                                                         | last status post still **04/09 19:48 CEST — fourteen days**, still says go-live 6 October     |
| **Slack**    | `C0BQD34LLF4` (dev group), 6 back                                                                                                                   | newest is the **16/09 report**; no 17/09 post, **no human reply — third night** (§2)          |
| **Slack**    | DM `D0B5QHS2T7H` (Elena Spini), 10 back                                                                                                              | nothing after 16/09 19:04 CEST                                                               |
| **Slack**    | DM `D0B33NLB7NF` (Rexhina Hysi), 10 back                                                                                                             | nothing after 16/09 15:18 CEST                                                               |
| **Slack**    | DM `D0AQ0FMHFM1` (Andrea Di Cicco), 8 back                                                                                                           | last 17/09 **09:08Z** — the vault request, **before the watermark**, already held             |
| **Slack**    | DM `D0BKK1D5GF9` (Anita Aga), 6 back                                                                                                                 | nothing after 10/09 — **seven days**                                                          |
| **Slack**    | canvas `F0BD2H5A9HT` re-read in full                                                                                                                 | **unchanged since 20.08**, twelve sessions behind                                             |
| **Drive**    | `modifiedTime > '2026-09-17T10:00:00Z'`, paged                                                                                                       | 3 items — 2 are 247; **1 is the WooCommerce spec** (§1)                                       |
| **Drive**    | `Integrazione_Salesforce_WooCommerce.docx` `1LYXxqKldoJeLRdjbZdfurZaRFxf2hsIC` **read in full**                                                       | 🔑 **§1 — the finding of this run**                                                           |
| **Drive**    | `title contains 'Follow-up' / 'Pienissimo' / 'Notes by Gemini'` and `modifiedTime > '2026-09-17T00:00:00Z'`                                           | **empty — today's internal has produced no artifact yet** (§3)                                |
| **Fathom**   | `list_meetings created_after 2026-09-16`, 3 pages                                                                                                     | **1 meeting, and it is 247** — 0 Pienissimo                                                   |
| **Git**      | `fetch --all --prune`, `log --all --since='2026-09-17 10:00'`, all 8 branch heads                                                                     | **1 commit — the interactive run's own `a1a4584`** (§5)                                       |
| **GitHub**   | `pull_requests state=all`, 6 newest by `updated`                                                                                                     | **no new PR; #47 open and untouched since 16/09 16:03Z** (§5)                                 |
| **Repo**     | `AGENTS.md`, the requirements-check skill, `MAP.md` head, the 17/09 trace, `OI-49`, `JOURNAL.md` head/tail                                            | read directly                                                                                 |

## Found

### 1. 🔑 The 31/07 WooCommerce spec was edited this morning, and no run had recorded it

`Integrazione_Salesforce_WooCommerce.docx`
(`1LYXxqKldoJeLRdjbZdfurZaRFxf2hsIC`, owner `sabatinopienissimo@gmail.com`)
carries `modifiedTime` **2026-09-17T07:40:42Z**.

⚠ **That timestamp sits inside the window the 11:00Z run swept.** Its Drive query
was `modifiedTime > '2026-09-16T21:00:00Z'` and its trace records _"5 items, all
modified before the watermark — nothing new"_. **07:40Z on 17/09 is after
2026-09-16T22:00Z**, so the file was either missed in paging or mis-triaged
there. Recorded as a defect in that run, not as a new edit tonight.

**Read in full. Nothing in the document was answered:**

- The closing section still lists the **same five points to agree**, none
  resolved — parameter name, ID format, price handling, integration direction,
  ID in clear versus signed token. The record has tracked those five since the
  14/08 external sweep.
- It still specifies the **mu-plugin `sf-opportunity-tracker.php` v1.0.0**,
  superseded on 27/08 by Sabatino Rinaldi's own plugin (v1.3).
- It still specifies the **long URL** with comma-concatenated product ids and a
  per-id quantity, superseded on 27/08 when the link shrank to the **opportunity
  id alone**.
- **Neither answer owed by Sabatino Rinaldi since 16/09 is in it** — whether the
  product id in the generated link is always a bundle id, and what becomes of
  multi-product offers not wrapped in one bundle.

⚠ **It is not an answer to those two questions.** Its _Esempio 2_ is exactly a
multi-product offer built from three concatenated ids — the mechanism 27/08
replaced. The document records the design the build moved away from.

⚠ **One visible corruption**: the sample REST response reads
`"line_items": [ciao`, a stray word inside a JSON code sample. **It cannot be
dated from this repository** — no note quotes that block verbatim — and Drive
returns `owner` but **no last-modifying user**, so **the author of this
morning's edit is unknown and is not inferred.**

🔑 **This is the `DGM-2` defect a second time**: a document cited as a `source:`
in `REQUIREMENTS.md`, `REQUISITI.it.md` and `OI-49` that documents a superseded
mechanism. The difference is that **this one is still being touched**, so it is
live rather than abandoned, and a reader following the citation gets the retired
design. Folded into
[OI-49](../items/OI-49%20WooCommerce%20checkout-link%20flow.md).

### 2. 🔴 Every message channel is silent on this project

Across the ninety-minute window, workspace-wide Slack returns **twenty results
and none is Pienissimo** — bit-mobility, Permo, Buoninfante and a Teatro Franco
Parenti case. The newest result is timestamped **12:26Z**, one minute before this
run, so the search reached the present.

Standing negatives, all re-confirmed and all now a day worse:

- **The client has been silent by mail for eight days** — last `@pienissimo.com`
  message 09/09 07:08Z. **The trigger armed on 17/09 asked for a ninth day
  before calling it a delivery risk; today is still the eighth.** It fires
  tomorrow if nothing arrives.
- **`#tproj-pienissimo` has had no status post for fourteen days** and still
  says **go-live 6 October**, sixteen days after the register moved to 21
  October.
- **No human has replied to a nightly report for three nights** (15/09, 16/09,
  and nothing yet on this one).
- The Slack canvas is **unchanged since 20.08**, twelve sessions behind.

### 3. ⚠ Today's internal meeting was still running as this sweep executed

`[PIENISSIMO] - Follow-up Interno`, **17/09 14:15–15:15 CEST** — the venue Elena
Spini meant by _"capiamo meglio domani"_, and the first movement on the two
WooCommerce points — **began twelve minutes before this run started**.

Drive holds **no Gemini notes, no recording and no document** for it, and Fathom
holds no meeting. That is the expected state for a session in progress, **not
evidence that it produced nothing.**

🔑 **The trigger does not fire tonight; it carries to the next run**, which is the
first one able to see an artifact from it. Andrea Di Cicco had declined the
invitation.

### 4. ⚠ The only mail in the window is another client

A Salesforce support case, **Case #474599135**, 08:32Z inbound and forwarded by
Aurel Mrruku at 09:31Z, cc `ariannagianotti@teatrofrancoparenti.com`. **Teatro
Franco Parenti, not Pienissimo**, and before the watermark in any case. **Not
ingested.**

### 5. ⚠ The build did not move

**One commit since the watermark: `a1a4584`** — the interactive run's own, at
12:17:42Z. Eight branch heads, unchanged otherwise. **No new pull request.**
**#47 is still open and untouched since 16/09 16:03Z**, still with no
description.

🔴 **`4132dab` — the `Incassato` removal — still has no pull request**, so the
guest-reachable write to order payment state remains on `DevMain` and in UAT.
**Unchanged for a second day.**

## What it changed

**No note created. One updated. No requirement changed in the register.**

| Written                           | Because                                                                             |
| --------------------------------- | ------------------------------------------------------------------------------------- |
| `OI-49`                           | the 31/07 spec was edited this morning and still carries the superseded mechanism   |
| `MAP.md`, `INDEX.md`              | the live position and this trace row                                                |
| `open-items.md` / `.it.md`        | row 49 regenerated, both languages                                                  |
| `DEVELOPMENT-RECAP.md` / `.it.md` | §41, both languages                                                                 |

### Why the register was not touched

**Nothing in it became false.** `INT-12`, `INT-13`, `INT-14` and `ORD-12` already
describe the checkout-link flow, and the 27/08 supersession of the mu-plugin is
already recorded against them. What this run found is that **a cited source
document disagrees with rows already recorded as superseded** — which is the
state those rows already describe.

🔴 **Worth a human's decision before sign-off, and now the second instance:**
`REQUIREMENTS.md` and `REQUISITI.it.md` both cite this document by name, and it
documents a retired mechanism. `DGM-2` has the identical problem. **Two cited
sources now describe designs the build has left behind.** Reconciling a client's
own document is not this sweep's to do.

## Triggers

**The `DGM-2` trigger widened.** It was armed on 17/09 against the design
diagram; the same failure now has a second instance in a second client-owned
document. ⚠ **Re-armed and generalised:** _if a third cited `source:` is found
documenting a superseded mechanism, the citation practice itself is the defect,
not the individual file — say so and name every affected register row._

**The internal-meeting trigger did not fire and is unchanged** (§3). ⚠ _The
17/09 14:15 CEST session was in progress during this sweep. The next run is the
first that can see notes or a recording. Drill it._

**The mail-silence trigger is one day short.** ⚠ _Eight days tonight. If the next
sweep finds a ninth with the Mexal credentials, event list, article codes and
prices still owed, raise it as a delivery risk rather than a gap in the record._

**The `Incassato` trigger did not fire**, second day. ⚠ **Re-armed unchanged.**

**The quote-state trigger did not fire**, ninth day. ⚠ **Re-armed.**

**The Friday order-lines trigger is unchanged and due tomorrow** — Parte 6 holds
the slot alone and **order lines still have no booking**.

**The `Edit_Mexal_Synced_Admin_Fields` trigger did not fire.**

## Deliberately not done

- **Nothing was sent, replied to, drafted, shared, modified or marked read on any
  external source.** The single Slack report to `C0BQD34LLF4` is the one message
  this run posted, under the nightly carve-out in
  [the skill](../../.agents/skills/requirements-check/SKILL.md).
- **No Apex test class was written, proposed or scaffolded.**
- **[STATUS.md](../../STATUS.md) was not regenerated.** Its basis is a live org
  check (2026-09-14 10:51Z) and this run has **no org evidence**. Nothing found
  tonight changes what is built. The Notion mirror stays stale by the same
  margin.
- **The org was not opened.** The org record is now **~3 days old** and predates
  PR #45, PR #47 and every `DEV_ComponentBundle` commit.
- **PR #47 was not reviewed or merged**; `4132dab` was not merged or
  cherry-picked.
- **No price, article code, credential, token, VAT number or personal datum
  entered the repository.** The spec read tonight contains a product/price
  mapping table and a billing block with a name, email and telephone number in
  its sample JSON; **none of it was copied** — the table is described, never
  quoted.
- **The two `[TEST]` email PDFs and the funnel screenshots were not opened**,
  tenth run. **`Stima Task` still unattributed, eleventh run.**

## Gaps in this run

- 🔴 **A cited requirement source documents a superseded mechanism** — and it is
  the second such file in one day.
- 🔴 **The client is silent by mail for an eighth day**, four artifacts owed.
- 🔴 **Five questions still sit behind Andrea Di Cicco**, who is winding down.
- 🔴 **The guest-reachable `Incassato` write is still on `DevMain`**, its fix
  still without a pull request.
- 🔴 **Order lines have no booking** with Parte 6 tomorrow and UAT on 23/09.
- 🔴 **40 of 43 ticket-generating products unmapped** (OI-121) — unchanged.
- ⚠ **`#tproj-pienissimo` is fourteen days stale** and still states the
  superseded go-live date.
- ⚠ **No human has answered a nightly report in three nights.**
- ⚠ **`MAP.md` is ~125 KB against a stated 5 KB budget** — raised on 08/09,
  09/09, 10/09, 11/09, 14/09, 15/09, 16/09, 17/09 and here. **Ninth consecutive
  request; no run has been authorised to act on it.**

## Method

**The useful move tonight was re-running a source the previous run had declared
empty.** The 11:00Z run reported its Drive query as five items with nothing new;
the same query re-run ninety minutes later returned a file whose `modifiedTime`
had been inside that run's window all along. **A source reported as empty is a
claim about a query, not about the world** — and the cheapest way to test it is
to run the query again with a wider clock and compare the timestamps rather than
the conclusions.

**The corollary, from the 17/09 method note, held here too:** the claim that
nothing in the document was answered is made by reading the whole file and
checking its closing section against the five points the record already tracks —
not by trusting that an edited file contains an edit worth having.
