---
id: trace-2026-08-27
type: reference
status: active
updated: 2026-08-27
watermark_used: 2026-08-26T21:40Z
external_watermark: 2026-08-27T22:00Z
account: a.mrruku@romicompany.com
---

# Source trace 2026-08-27

**Watermark for the next `requirements-check` run: 2026-08-27T22:00Z.**

**Watermark used for this run: 2026-08-26T21:40Z** — from
[the 26 August nightly trace](Source%20trace%202026-08-26%20nightly.md), selected
by its `updated:` frontmatter field, not by filename order. Note that two traces
carry `updated: 2026-08-26`; the nightly one is the later and is the one that
governs.

**The sweep was not dry.** Both WooCommerce sessions ran, both are fully
recorded, and one of them settled the integration direction that has been open
since July. A third finding came from outside the meetings entirely.

## Sources searched

All read-only. **Nothing was sent, replied to, shared, modified or marked read**,
with the single carve-out of the nightly report to `C0BQD34LLF4`.

| Source      | Query / scope                                                              | Result                                                                                                                                    |
| ----------- | -------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------ |
| **Gmail**   | `pienissimo after:2026/08/26`                                              | **7 threads, 5 new** — 2 Gemini note sets, the Test WooCommerce invitation, Sabatino Rinaldi's payload mail, the Salesforce exception       |
| **Gmail**   | all mail `after:2026/08/26 -in:draft`                                      | 23 threads. The five above plus non-project traffic — see *Deliberately not ingested*                                                       |
| **Gmail**   | counterpart domains + `woocommerce\|anticipay\|mexal\|kreosoft`, after 25/08 | 8 threads, all already seen — the query is a control and it returned the expected known history                                            |
| **Drive**   | `modifiedTime > 2026-08-26T18:00:00Z`, fully paged (2 pages)               | **13 items.** Both meeting folders, both Gemini/transcript docs, both recordings, 4 shortcuts, `Integrazione_Salesforce_WooCommerce.docx`, plus 2 non-project files |
| **Drive**   | both Gemini docs read **in full**, notes + transcript tabs                 | Both transcripts complete — they end at *"Trascrizione terminata dopo 00:48:20"* and *"00:17:13"*, not mid-sentence                        |
| **Slack**   | workspace-wide incl. private channels, DMs and group DMs, `pienissimo`     | 20 hits, **1 new after the watermark** — Aurel Mrruku's 11:20 CEST post in `#gen-idee-e-suggerimenti-geniali`                              |
| **Slack**   | workspace-wide, `woocommerce`                                             | 15 hits, **1 new** — the ROMI group DM `C0BFDNXQKAS` at 10:08–10:45 CEST, read in full                                                     |
| **Slack**   | `#tproj-pienissimo` (`C0B5T3RB4FM`), 8 messages back                       | Last post still **07 Aug 17:12** — unchanged for a **seventh** week                                                                       |
| **Slack**   | Canvas *Link utili Pienissimo* (`F0BD2H5A9HT`), re-read in full            | **Unchanged.** Newest entry still **20.08** — now **four** client sessions behind                                                          |
| **Fathom**  | all meetings created after 2026-08-20                                      | **0 recordings.** Unchanged since 06 Aug — recordings still land in Drive, not Fathom                                                      |

## Found

### 1. 🟢 Two WooCommerce sessions ran, and the integration direction is settled

`[ROMI-PIENISSIMO] - Integrazione WooCommerce`, **27 August 10:00–10:48 CEST,
48m20s** — Elena Spini chairing, six present. And
`[ROMI-PIENISSIMO] - Test Integrazione WooCommerce`, **15:59–16:16 CEST,
17m13s** — Aurel Mrruku and Sabatino Rinaldi only, booked at 08:46Z out of the
first.

Both drilled per `drill-meeting`. Transcripts preserved verbatim at
`meetings/2026-08-27-integrazione-woocommerce-transcript.it.md` (~22 KB) and
`meetings/2026-08-27-test-integrazione-woocommerce-transcript.it.md` (~15 KB),
each read **once, in full**, both complete.

The headline: **WooCommerce writes into Salesforce via a custom plugin on a PHP
order-status action hook.** Stock WooCommerce webhooks were evaluated on screen
and rejected — one topic per webhook, no multi-select, no control of the body.
`INT-14` moves open → agreed. Everything else is in
[the flow note](../flows/The%20WooCommerce%20order%20integration.md) and the two
bilingual recaps.

🟢 **And the client side is already built.** Sabatino Rinaldi wrote the plugin
between the two meetings and demonstrated it live: v1.3, always active, HTTP 200,
manual re-send button, firing on `in lavorazione` **or** `completato` for any
payment method.

### 2. 🔴 A requirement is corrected by that demonstration

`ORD-12` said a WooCommerce order is **invisible in Salesforce until
COMPLETATO** — sourced from the design diagram, status `to_confirm`, never
verified. The plugin fires on **processing as well**, verified live. Corrected in
the register, in the `orders.rules` block, and in both prose documents, with both
dates cited.

### 3. 🔴 Lead conversion is failing in the Pienissimo partial sandbox

Not from either meeting. A Salesforce unhandled-exception mail at **15:08:13Z**:
`LeadConversionQueueable` threw `System.QueryException: No such column
'Servizio_Interesse__c' on entity 'Lead'` at line 22, job `707MA00000jTvGJ`, org
`ability-customization-52152--partial`.

**The repository's copy of that class does not select that field**, and the
field's metadata **is** in `force-app/`. So the org runs a different version of
the class and the sandbox lacks a field the repository has. Written up at
[the risk note](../risks/Risk%20-%20LeadConversionQueueable%20is%20broken%20in%20the%20Pienissimo%20sandbox.md);
folded into
[the build ahead of the record](../objects/The%20build%20ahead%20of%20the%20record.md)
as a third divergence, and the first one that breaks a running feature.

⚠ **Written without org access.** The reading above rests on the error text and
the repository. Confirm against the org before acting.

### 4. The payload arrived, and cannot be read

Sabatino Rinaldi mailed it at **14:20Z** — subject _"Integrazione woo commerce -
salesforce"_, body _"Ecco il payload:"_, cc Andrea Di Cicco and Elena Spini,
attachment `Payload woo-salesforce`. It is the authoritative field list for the
integration. **No connected tool can read a Gmail attachment**, so the record
holds only what was visible on screen during the demo. Same limitation that
delayed `Prodotti e Bundle.xlsx` for seventeen days.

### 5. The Slack thread is again sharper than the meeting

ROMI group DM `C0BFDNXQKAS`, 10:08–10:45 CEST, read in full. Elena Spini posted
`Integrazione_Salesforce_WooCommerce.docx`; Andrea Di Cicco: _"ma io non l ho mai
visto sto documento XD"_, then _"io sto andando a braccio"_. Elena Spini: _"queste
sono le casistiche io non so manco cosa sia sto webhook."_ The document has been
in the Slack canvas since 31 July. Not a decision — but it is the second time in
four days that a document already in the record was missing from the people using
it, and it explains why the session re-derived an architecture the spec proposed.

## What it changed

**Six notes updated, eight created, both trackers, both recaps, the register,
both prose documents, MAP and INDEX.**

| Created | |
| --- | --- |
| `notes/meetings/2026-08-27 Integrazione WooCommerce.md` | The design session |
| `notes/meetings/2026-08-27 Test Integrazione WooCommerce.md` | The test session |
| `notes/flows/The WooCommerce order integration.md` | The integration contract |
| `notes/items/OI-101 Stage sales must be in the WooCommerce test set.md` | Fabrizio Paganelli's escalation |
| `notes/items/OI-102 Salesforce endpoint and token for the WooCommerce plugin.md` | What ROMI owes |
| `notes/items/OI-103 WooCommerce and Mexal field overlap.md` | Raised and unowned |
| `notes/risks/Risk - LeadConversionQueueable is broken in the Pienissimo sandbox.md` | The runtime failure |
| `notes/risks/Risk - real WooCommerce orders reached a third-party test server.md` | The data exposure |

| Updated | Because |
| --- | --- |
| OI-49 | The workstream's central session finally ran; the mu-plugin and the URL anatomy both superseded |
| OI-73 | 🔴 The VAT check's firing point moved, in a two-person room |
| `The build ahead of the record` | A third divergence, and it breaks a running feature |
| `Sabatino Rinaldi - Pienissimo project lead` | He writes the integration himself |
| `AGENTS.md` · `INDEX.md` | Transcript corpus ~918 KB → ~955 KB |
| `MAP.md` | Two new blocks; calendar and the live chain |

Also: `meetings/2026-08-27-integrazione-woocommerce-transcript.it.md` and
`meetings/2026-08-27-test-integrazione-woocommerce-transcript.it.md`;
`meetings/results/` × 4 (both meetings, both languages); `open-items.md` **and**
`.it.md` (rows 49 and 73 touched, **100–103 added** — 100 backfills a note the
27 August Codex session created without a tracker row); `DEVELOPMENT-RECAP.md`
**and** `.it.md` §21.

**Requirements changed, for the first time in three sweeps.** `INT-14` open →
agreed · `INT-13` mu-plugin superseded, product/quantity pickers dropped ·
`INT-11` credential direction reversed, second client-input row added ·
`ORD-12` corrected, plus the matching `orders.rules` line · the `technical_decisions`
entry for INT-14 resolved. All four landed in
`requirements/pienissimo-requirements.yaml`, `REQUIREMENTS.md` **and**
`REQUISITI.it.md` in the same session, with `tracked_by` wired back to the notes.

⚠ **`STATUS.md`, the Notion mirror and `site/` were not regenerated.** They carry
**build state**, refreshed by the 26 August `org-status-check`; this sweep moved
**decisions and a client-side build**, not the org. The Flows page is the closer
call — a new note landed in `notes/flows/` — so **step 6a-bis applies on the next
org-status run**. Flagged, not done, since regenerating it now would restate the
26 August org figures unchanged.

## Deliberately not ingested

- **`CAROL - Project Steps.docx`**, modified 13:36Z — a different client.
- The **`Sandbox: charger small` case thread** (admin.daze@ ↔ Sara Aga, 10:47–13:32Z)
  — Service Cloud case-handling exercise on a **different ROMI org**
  (`00DMA000004lqb32ae`, not the Pienissimo `00DMA000004nMMr`). Training, not a
  requirement.
- **`Sandbox: Processing complete`** at 10:41Z — an org-wide sharing-defaults
  change completed. The mail does not name the org. Even if it is the Pienissimo
  sandbox it is **org configuration**, which `org-status-check` owns, not this
  sweep. Recorded here so the next run does not treat it as new.
- The **Permo/Zucchetti** and **Teatro Franco Parenti / Secutix** threads, the
  **ROMI WEEK START** invitation, the Jira digest, and the holiday planner —
  other projects or ROMI-internal.
- **Aurel Mrruku's 11:20 CEST Slack post** in `#gen-idee-e-suggerimenti-geniali`
  sharing his Pienissimo documentation and tooling approach ROMI-wide. It is
  about **method**, not about the project's requirements. Worth knowing it
  exists: Daniele Macchia asked him to present it at the Monday call.

## Still unreachable / still owed

Carried from earlier traces, with today's movement marked.

- 🔴 **New: the `Payload woo-salesforce` attachment** on Sabatino Rinaldi's 14:20Z
  mail. The authoritative field list for the WooCommerce integration; **no
  connected tool can open a Gmail attachment.** Needs a manual download. Cheapest
  outstanding ask in the record.
- 🔴 **New: the Salesforce endpoint and token** ROMI owes Pienissimo — blocks the
  31 August tests ([OI-102](../items/OI-102%20Salesforce%20endpoint%20and%20token%20for%20the%20WooCommerce%20plugin.md)).
- 🟡 **WooCommerce CK/CS credentials — status genuinely ambiguous now.** Owed by
  Sabatino Rinaldi since 14 July, promised for yesterday's session and never
  raised there. With the integration pushing, they may not be needed at all.
  **Report as undecided, not as owed and not as closed.**
- 🔴 **A Mexal test company** — serie 10 is still a test lane inside production
  data. No owner. And WooCommerce now has the same problem with no name at all.
- 🔴 **Mexal's coded-value dictionaries** — asked for by email, unanswered.
- 🔴 **The marketing package** — DNS records, forms, funnel screenshots,
  newsletter and header graphics. Matteo Distaso and Rebecca Marmo. **Still
  overdue, nothing new.**
- **The Anticipay middleware API example**, Andrea Parmeggiani, due **4 Sept**.
- **Marco Montesi's preset quote-expiry timings** per product category.
- **The Pienissimo 30 July marketing follow-up** notes — never circulated.
- **The Zoho data-model workbook** ([OI-24](../items/OI-24%20Data%20model%20workbook.md))
  and ROMI's **import template** ([OI-88](../items/OI-88%20Zoho%20import%20template%20owed%20to%20Pienissimo.md)).
- ⚠ **The Slack canvas is now four client sessions behind** — newest entry still
  20.08, missing 25 Aug Anticipay, 26 Aug Mexal and both 27 Aug WooCommerce
  sessions, plus the two 24 Aug internals.

## Method notes worth keeping

- **A meeting can be booked and run inside the sweep window.** The Test session
  was invited at 08:46Z and had finished, been transcribed and been folded in
  before this sweep started. A date-bounded query is not enough; the window has
  to be re-swept for artifacts created *by* what the window contains.
- **The most consequential finding tonight came from a robot.** The
  `LeadConversionQueueable` failure is a Salesforce system mail, not a meeting, a
  message or a document — a source class this procedure has never had a finding
  from. **Do not filter automated senders out of the mail sweep**; check
  `info@salesforce.com` deliberately.
- **A two-person meeting can move a client-agreed rule.** The afternoon session
  relocated the P.IVA check with neither the person who proposed the original
  rule nor the one who approved it in the room, and Gemini minuted it as
  "Concordato". Weight a decision by **who was present**, not by whether the
  auto-summary calls it agreed.
- **Read both tabs of a Gemini doc.** The transcript lives in a second tab of the
  same document as the notes; the file id is identical and only the `tab=`
  parameter differs. Reading the doc in full returns both — the Gemini summary
  alone would have lost the Funnel Kit finding, the re-send button, the
  paid-lines rule and the real orders on the test server.
