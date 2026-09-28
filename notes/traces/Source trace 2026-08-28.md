---
id: trace-2026-08-28
type: reference
status: active
updated: 2026-08-28
watermark_used: 2026-08-27T22:00Z
external_watermark: 2026-08-28T22:00Z
account: a.mrruku@romicompany.com
---

# Source trace 2026-08-28

**Watermark for the next `requirements-check` run: 2026-08-28T22:00Z.**

**Watermark used for this run: 2026-08-27T22:00Z** — from
[the 27 August trace](Source%20trace%202026-08-27.md), selected by its `updated:`
frontmatter field, not by filename order. The 28 August JOURNAL entry that
precedes this one records the WooCommerce payload ingest, which was a single
artifact and **not a sweep**, so it moved no watermark.

**No client sent anything, and no meeting ran.** Both findings are ROMI-side and
both came from Slack: a weekly status post that broke a seven-week channel
silence, and an org check whose results were never written back to the
repository.

## Sources searched

All read-only. **Nothing was sent, replied to, shared, modified or marked read**,
with the single carve-out of the nightly report to `C0BQD34LLF4`.

| Source     | Query / scope                                                          | Result                                                                                          |
| ---------- | ---------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------- |
| **Gmail**  | `pienissimo after:2026/08/27`                                          | 5 threads, **0 new** — all five pre-date the watermark and were ingested on 27/08                |
| **Gmail**  | all mail `after:2026/08/27 -in:draft`                                  | 35 threads. **Not one Pienissimo item after the watermark**                                     |
| **Gmail**  | all mail `after:2026/08/28 -in:draft`                                  | 18 threads, **0 Pienissimo** — the 28/08 window is empty of this project entirely               |
| **Gmail**  | counterpart domains + `woocommerce\|anticipay\|mexal\|kreosoft\|biglietto`, after 26/08 | 7 threads, all already held — the control returned the expected known history  |
| **Slack**  | workspace-wide incl. private channels, DMs and group DMs, `pienissimo` | 7 hits, **2 new** — Elena Spini's status post and the org-status report                         |
| **Slack**  | workspace-wide, `woocommerce\|mexal\|anticipay\|biglietto\|salesforce` | 20 hits, no further project content — the remainder is other clients and ROMI-internal          |
| **Slack**  | `#tproj-pienissimo` (`C0B5T3RB4FM`), read directly, 6 messages back    | **Silence broken.** First post since 07/08; the four prior status posts read for comparison     |
| **Slack**  | Canvas *Link utili Pienissimo* (`F0BD2H5A9HT`), re-read in full        | **Unchanged.** Newest entry still **20.08** — now **four** client sessions behind               |
| **Drive**  | `modifiedTime > 2026-08-27T20:00:00Z`, fully paged (2 pages)           | 11 items, **0 Pienissimo** — all Daze, CAROL, BE.MA, LIFE365 or ROMI-internal                   |
| **Drive**  | `title contains 'Pienissimo' and modifiedTime > 2026-08-20`            | 5 items, all known. `Workflow Pienissimo 23-7-26.drawio` still 20/08 — **DGM-1 unmoved**        |
| **Fathom** | all meetings created after 2026-08-20                                  | **0 recordings.** Unchanged since 06 Aug — recordings still land in Drive, not Fathom            |

## Found

### 1. Elena Spini's weekly status, and the paragraph that has not changed since July

`#tproj-pienissimo`, **28 August 12:13:32Z** — the **first post in that channel
since 07 August**, ending a seven-week silence three consecutive traces had
recorded.

Read against the 24/07, 31/07 and 07/08 posts, most of it is **copied verbatim**.
That comparison is the finding, so it is worth stating plainly what is new and
what is not:

| | New on 28/08? |
| --- | --- |
| WooCommerce: a first integration test ran and **went OK** | 🟢 new — and consistent with the 27/08 test session already held |
| Mexal: points still open on products → **02/09 meeting** | already held |
| MKT: **still waiting** on the 100+ form review | the same sentence as 07/08 — but see below |
| MKT: **the 2 flows are confirmed, Fabrizio is building them** | 🟢 **new** |
| Red flags: the whole GLS / Teachable / Zoho paragraph | ❌ **verbatim from 24/07, 31/07 and 07/08** |
| _"Non ho ancora avuto aggiornamenti su questo vedo di smarcare settimana prossima"_ | 🔴 **new, and prefixed to that paragraph** |
| Go-live 6 October, focus WooCommerce + Mexal | unchanged |
| **Notizie positive** | empty this week; carried a wry line on 31/07 and 07/08 |

Two things folded in:

🔴 **The phase 2 dispute has not moved in five weeks.** _"Ci riaggiorneranno
settimana prossima"_ was first written on **24 July** and has been carried
forward word for word ever since. Elena Spini now states she still has no update
and will try to clear it in the week of 31 August — **thirty-five days** after
the escalation to Daniela Morgese was promised. Folded into
[the risk](../risks/Risk%20-%20the%20phase%202%20scope%20dispute%20is%20unresolved.md)
with an explicit warning **not to cite the post for the dispute's merits** — it
adds no argument and no evidence, only a date for the silence.

🟢🔴 **Marketing moved, in both directions at once.** The two MKT flows are
**confirmed and being built by Fabrizio Mastracci** — the first movement on that
stream since 19 August. But the same sentence confirms the **100+ form review is
still outstanding after nine weeks**, which upgrades
[OI-14](../items/OI-14%20Marketing%20forms%20and%20subdomain.md) from *unconfirmed*
to *confirmed outstanding by ROMI's own PM in writing*. The flows are therefore
being built while the form inventory they consume is unreviewed and the funnel
screenshots owed on 20 August have never been confirmed as delivered.
[OI-81](../items/OI-81%20Event%20communication%20funnel.md)'s `30 vs 60` day
trigger is **still undecided while the flow is under construction**.

⚠ **"Fabrizio" is Fabrizio Mastracci (ROMI), not Fabrizio Paganelli
(Pienissimo).** Both are active on this project. The reading rests on Elena
Spini's own 24 July handover note and on the clause being about the ROMI-side
build; it is recorded in OI-14 so the next reader does not have to re-derive it.

### 2. 🔴 An org check ran, contradicted the record in five places, and published nothing

`org-status-check` ran **28 August 14:45–14:56Z** against `00DMA000004nMMr2AM`
(partial sandbox, API 67.0) at repo `89e9bac`, and reported to `C0BQD34LLF4` and
to Aurel Mrruku's self-DM. Its own closing line: _"no note or requirement
mutated, nothing published."_ So its findings existed **only in Slack** until
this sweep.

**Five claims in `MAP.md` were verified false**, all now struck through and dated
there:

| `MAP.md` said | The org, 28/08 |
| --- | --- |
| "Still not one Flow" | **2 Flows**, `Lead_Non_Risponde_Follow_Up` active |
| "Asset still has zero custom fields" | **8 custom fields** + Ticket record type |
| WooCommerce "nothing of the Salesforce side exists" | **endpoint deployed, taking live traffic** |
| `OrderItem.Tranche__c` "granted to nobody" | granted to **`Tranche_Management`** |
| Lead conversion broken in the sandbox | **field present, neither class selects it** |

Also: all four state machines active and byte-aligned with the repo, and
**everything in the repo is deployed** — no repository-only drift, a first.

Three notes were corrected from it:

- [The LeadConversionQueueable risk](../risks/Risk%20-%20LeadConversionQueueable%20is%20broken%20in%20the%20Pienissimo%20sandbox.md)
  → **resolved**. That note was written on 27 August **without org access** and
  said so; the confirmation it asked for overturned it. The 27 August account is
  kept intact rather than rewritten, because a wrong inference that flagged its
  own uncertainty is worth keeping. 🟢 It no longer blocks
  [OI-100](../items/OI-100%20Same%20lead%20email%20with%20different%20VAT%20during%20conversion.md).
- [OI-104](../items/OI-104%20The%20WooCommerce%20payload%20has%20no%20idempotency%20key.md)
  → **in-progress**. The payload still carries no key — that statement was
  correct — but the endpoint **derives one**:
  `Order.WooCommerce_Order_Key__c`, unique + external id, 409 on duplicate,
  exercised across 5 logged calls. The fix this note proposed on 28 August
  already existed. Residual: a **SOQL-then-insert race**. And `INT-16` is now
  verified from the code rather than inferred from the envelope — **no token, no
  signature check anywhere** in a `global without sharing` endpoint.
- `MAP.md` → the corrections above, plus the gating items that **did** hold:
  coverage **0% of 1,769 lines** and growing, `Integration_Configuration__c`
  with 0 rows *and* 0 object permissions, permission sets reaching one user each
  against 8 active users.

⚠ **This sweep did not open the org.** Every build-state assertion written
tonight is attributed to that run and dated, per the protocol's rule that you
name which of the three sources you checked. `STATUS.md`, its Notion mirror and
the Flows page stay `org-status-check`'s to regenerate — flagged, not done, for
the second trace running.

## What it changed

**Five notes updated, none created.** No requirement changed, so the register
and both prose documents are untouched — nothing the client has signed moved
tonight.

| Updated | Because |
| --- | --- |
| `Risk - the phase 2 scope dispute is unresolved` | Five weeks, same paragraph; the silence now has a date |
| `Risk - LeadConversionQueueable is broken in the Pienissimo sandbox` | **Resolved** against the org; the 27/08 inference was wrong |
| `OI-104` | The dedupe is built; the race and `INT-16` are what remain |
| `OI-14` | Form review confirmed still owed; the 2 MKT flows are in build |
| `OI-81` | The two flows are confirmed; `30 vs 60` still undecided |
| `MAP.md` | Five false claims struck through; new 28/08 block; phase 2 and a new marketing line in the live chain |

Also: `open-items.md` **and** `.it.md` rows **14, 81, 104**; `DEVELOPMENT-RECAP.md`
**and** `.it.md` — the Lead-conversion paragraph marked resolved in both, with
the 27 August text preserved as the record of what was believed then.

## Deliberately not ingested

- **The LIFE365 thread** _"Payload per le api legate ai 2 flussi"_ (Aurel Mrruku
  → Giancarlo Spadini, 28/08 09:42Z) and the LIFE365 requirements-check report.
  Different client.
- **Daze** — the SAL and pre-SAL Gemini notes, the `admin.daze@` ↔ Sara Aga case
  exercise, `[Daze] Aggiornamenti Settimanali`. A different ROMI org; Service
  Cloud training, not a requirement.
- **`CAROL - Project Steps.docx`**, the **BE.MA** folder share, **Permo**,
  **Interstudio Viaggi**, **TFP**, **Piemontese Leasing**, the ROMI WEEK START
  and Confronto AI invitations, the new-joiner welcome thread. Other projects or
  ROMI-internal.
- **Fathom vendor marketing** (`julia.warner@fathom.video`, 28/08 20:30Z) — the
  fifth in a sales sequence. Recorded so the next run does not re-open it.

## Still unreachable / still owed

Carried forward, with tonight's movement marked.

- 🟢 **Closed: the `Payload woo-salesforce` attachment.** Aurel Mrruku downloaded
  it manually on 28 August; preserved in the repository root and decoded in
  [the payload contract](../The%20WooCommerce%20payload%20contract.md). It was
  the cheapest outstanding ask in the record and it is gone.
- 🔴 **The Salesforce endpoint and token** ROMI owes Pienissimo
  ([OI-102](../items/OI-102%20Salesforce%20endpoint%20and%20token%20for%20the%20WooCommerce%20plugin.md)).
  **Now sharper**: the 28/08 check confirms the endpoint has *no* application-level
  auth, so this token is the whole of it, and the tests are **this coming week**.
- 🔴 **The marketing package** — DNS records, funnel screenshots, newsletter and
  header graphics (Matteo Distaso, Rebecca Marmo). Seven to eight days overdue,
  and the flows are being built without them.
- 🔴 **The 100+ form review** — now confirmed outstanding by ROMI's PM, nine weeks.
- 🟡 **WooCommerce CK/CS credentials** — still genuinely ambiguous. With the
  integration pushing they may not be needed. **Undecided, not owed and not closed.**
- 🔴 **A Mexal test company** — serie 10 is still a test lane inside production
  data. No owner. WooCommerce has the same gap, unnamed.
- 🔴 **Mexal's coded-value dictionaries** — asked for by email, unanswered.
- **The Anticipay middleware API example**, Andrea Parmeggiani, due **4 Sept**;
  follow-up **1 Sept 10:00**.
- **Marco Montesi's preset quote-expiry timings** per product category.
- **The Pienissimo 30 July marketing follow-up** notes — never circulated.
- **The Zoho data-model workbook** ([OI-24](../items/OI-24%20Data%20model%20workbook.md))
  and ROMI's **import template** ([OI-88](../items/OI-88%20Zoho%20import%20template%20owed%20to%20Pienissimo.md)).
- ⚠ **The Slack canvas is still four client sessions behind** — newest entry
  20.08, missing 25 Aug Anticipay, 26 Aug Mexal and both 27 Aug WooCommerce
  sessions, plus the two 24 Aug internals. Unchanged for a second week.

## Method notes worth keeping

- **A quiet night for the client can still be a loud one for the record.** No
  mail arrived, no meeting ran, no Drive file moved — and the sweep still
  corrected five claims in `MAP.md`. Do not treat "no inbound client traffic" as
  a dry run; the ROMI-side channels are where this one lived.
- **Read a recurring status post against its predecessors, not on its own.**
  Elena Spini's red-flag paragraph looks like a live escalation and is in fact
  the same text for the fifth week. The finding was in the diff, not the
  content: one prefixed sentence, saying nothing has moved. A summariser reading
  the post alone would have reported a fresh escalation that is not there.
- 🔴 **A sibling procedure can leave findings stranded in Slack.** The 28 August
  org check was thorough, verified, and published **nothing** — its own
  guardrails forbid it. Its results sat in a group DM while `MAP.md`, the file
  every agent reads first, carried five claims it had disproved. **Check for a
  recent `org-status-check` report on Slack as part of this sweep**; the two
  procedures do not otherwise talk to each other.
- **Keep a note that was wrong, and keep its hedge.** The 27 August
  LeadConversionQueueable note said *confirm against the org, this was written
  without org access* — and that hedge is exactly what let the 28 August check
  overturn it cleanly. Marking it resolved beats deleting it: the next agent
  learns that an error mail proves an **event**, never a standing **state**.
