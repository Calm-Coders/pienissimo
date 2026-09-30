---
id: trace-2026-09-30-nightly
type: reference
status: active
updated: 2026-09-30
watermark_used: 2026-09-29T22:00Z
external_watermark: 2026-09-30T22:00Z
account: a.mrruku@romicompany.com
---

# Source trace 2026-09-30 nightly

**Watermark for the next `requirements-check` run: 2026-09-30T22:00Z, single value.**

**Watermark used: 2026-09-29T22:00Z**, the `external_watermark` stated by
[the 29/09 nightly trace](Source%20trace%202026-09-29%20nightly.md). Scheduled nightly
run, executed 2026-09-30 ~22:00Z. One day, no gap.

🟢 **Client contact resumed.** The 29/09 blackout (their biggest company event) ended
and the **ticket UAT ran as scheduled** with five Pienissimo people in the room. That
makes tonight's findings client-agreed rather than ROMI-internal, which is why two of
them are reversals of ROMI's own decisions.

⚠ **Environment note, fourth run in a row.** The clone opened on **`main` only** —
the 17-file scaffold at `279783d`, no `AGENTS.md`, no `notes/`, no `DevMain` even as a
remote ref. `git fetch origin` then `git checkout -b DevMain origin/DevMain` recovered
the project in under a minute. **Fourth consecutive prediction paid off. Fetch before
concluding anything about an empty-looking repository.**

## Sources searched

| Source | Query / scope | Result |
| ------ | ------------- | ------ |
| **Fathom** | `list_meetings created_after 2026-09-29T22:00Z`, summaries + action items, 3 pages | **0 meetings** — **seventh** consecutive run with nothing. The two real sessions of the day were recorded by Google Meet, not Fathom |
| **Gmail** | `pienissimo after:2026/09/29 -in:draft`, 40 requested, 9 estimated | 🔑 **two Gemini meeting-notes mails** (14:35Z UAT, 15:41Z Post UAT) · a 13:58Z invitation for `PIENISSIMO - Post UAT` · the rest pre-watermark (29/09 sandbox exceptions, 29/09 invitations), already held |
| **Gmail** | `(from/to/cc:pienissimo.com OR ROMI-PIENISSIMO OR kreosoft OR pienissimo.pro) after:2026/09/29 -in:draft` | **1 thread, the UAT Gemini notes.** 🔴 **No client mail at all** — the client's contribution today was verbal, in the session |
| **Drive** | `modifiedTime > '2026-09-29T22:00:00Z'`, **2 pages, 22 files** | 🔑 **both 30/09 meeting folders, notes docs and the UAT recording** · 🔑 **`Articoli Salesforce.xlsx` modified 12:45:55Z** · **`Flows & Objects.drawio` modified 14:11:53Z** · rest are other clients (Vape Italia, BE.MA, 247, Daze, Agentforce) — ignored per the skill |
| **Drive** | `read_file_content` on `1yWV3m_ex8lhiPImgt0TwW5nPoGyctAra1gg_1XV9cEY` | 🔑 **the UAT notes + full transcript, 127,631 characters, read in full** |
| **Drive** | `read_file_content` on `13DdI4p2X79kzC2SIGIQyAwtVkjV5S2xMUkHe8sOoMhM` | 🔑 **the Post UAT notes + full transcript, 89,015 characters, read in full** |
| **Slack** | `slack_read_channel C0BQD34LLF4` (dev group), from 29/09 22:00Z | **1 message**, Aurel Mrruku 18:10 CEST, in Albanian, asking the team to push up their work because he had to make changes. **No human reply to any nightly report — fourteen nights** |
| **Slack** | `slack_read_channel C0B5T3RB4FM` (`#tproj-pienissimo`), from 29/09 22:00Z | **0 messages** — second consecutive silent day |
| **Slack** | `slack_read_channel C0C38JJ9D1T` (the marketing group DM), from 29/09 22:00Z | 🔑 **11 messages** — the asset-filter argument at 15:25–15:26 and Elena Spini convening the Post UAT at 15:57 |
| **Slack** | workspace-wide `keywords:["pienissimo"] after:2026-09-29`, by timestamp | 2 results — last night's LIFE365 sibling report and Rexhina Hysi's DM asking Aurel Mrruku to approve PR #71 |
| **Git** | `fetch origin`, `log --all --since 2026-09-29T22:00:00Z` | 🔑 **10 commits**; `DevMain` advanced `4c9b121` → **`0b6b828`** via PRs **#69**, **#70** and **#71**; `4f672a2` on `DevAnita30` is **unmerged** |
| **Repo** | `merge-base --is-ancestor` on `e2bdb1f`, `1e1ab6d`, `963e582`, `c397bee`; `ls force-app/main/default/objects/Asset/fields/`; `AssetStatus.standardValueSet`; `Fattura_Pagata__c` read; grep for `tranch` on Asset | 🟢 **the document stack is confirmed on `DevMain`** · 🔴 **`Inviato` absent from `AssetStatus`** (7 values) · 🔴 **no tranche field and no send flag on `Asset`** |

## Found

1. 🔑 **[UAT Biglietti Asset Campagne ed Eventi](../meetings/2026-09-30%20UAT%20Biglietti%20Asset%20Campagne%20ed%20Eventi.md)**
   (30/09 14:00 CEST, ~1h55m, **8 speakers** — Aurel Mrruku · Elena Spini · Fabrizio
   Mastracci · **Fabrizio Paganelli · Rebecca Marmo · Sabatino Rinaldi · Elisa
   Migliano** · a speaker labelled only "Marco"), drilled from the full transcript.
   Five client rulings, two of which reverse ROMI's own decisions.
2. 🔑 **[Post UAT](../meetings/2026-09-30%20Post%20UAT.md)** (30/09 16:09 CEST,
   ~1h23m, ROMI-internal), drilled from the full transcript. The whole
   Salesforce→Marketing Cloud send contract, specified and unbuilt.
3. 🟢 **[OI-196](../items/OI-196%20Whether%20tickets%20are%20sent%20when%20the%20buyer%20names%20only%20some%20participants.md)
   resolved against the 29/09 design.** The client sends the named tickets and burns
   the unnamed. **The premise of the all-or-nothing rule was factually false** — the
   indiscriminate daily reminder it was built against does not exist. The rinuncia
   button question resolves with it.
4. 🔴 **New: [OI-197](../items/OI-197%20The%20ticket%20send%20flag%20and%20the%20Inviato%20asset%20state%20are%20agreed%20and%20unbuilt.md)**
   (gating) — the send flag, the Marketing Cloud query, the per-participant
   transactional send, the post-send write-back and the `Inviato` state. **None of
   the five exists.** Production committed for **Mon 05/10**; marketing UAT 16/10;
   no action item carries a date.
5. 🔴 **New: [OI-198](../items/OI-198%20The%20asset%20does%20not%20say%20which%20tranche%20paid%20for%20it.md)**
   (gating) — the client's gate is per tranche and `Asset` has no field naming its
   tranche. `Fattura_Pagata__c` is a bare checkbox.
6. 🔴 **[OI-96](../items/OI-96%20Edition%20mapping%20table%20on%20Salesforce.md): the
   mapping window becomes the competenza dates**, and one order can no longer span
   editions — **reversing the per-order-line property Fabrizio Paganelli himself
   confirmed on 26 August**. Costed at half a day by Aurel Mrruku; unbuilt; the
   mapping is still at 13 of 51 and the 29/09 exception was never mentioned.
7. 🟢 **[OI-185](../items/OI-185%20The%20participant%20name%20change%20regenerates%20the%20ticket%20as%20a%20new%20asset.md):
   the document stack reached `DevMain`** via PRs #69 and #71, verified by ancestry.
   🔴 The cambio nominativo remains unbuilt and was not discussed.
8. 🟢 **[OI-81](../items/OI-81%20Event%20communication%20funnel.md): the ~60-day figure
   is Sabatino Rinaldi's, from the 27 May kickoff** — read back from Aurel Mrruku's
   own notes. The standing warning that ROMI chose it for the client is withdrawn.
9. 🔴 **[OI-146](../items/OI-146%20Ingressi%20structure%20for%20multi-day%20events.md)
   now has dates**: Pienissimo Live **24–26 November** on one check-in; Mastery
   split across April and May needing multiple entries. Still deferred, no date.
10. 🟢 **[OI-157](../items/OI-157%20Credit%20notes%20and%20storni%20are%20unbuilt%20and%20undefined.md):**
    the invoice is issued on signature regardless of collection; on agreed withdrawal,
    a credit note plus a dedicated cancelled asset state. Still Fase 2.
11. ⚠ **`Articoli Salesforce.xlsx` moved at 12:45:55Z**, 75 minutes before the UAT,
    having been static since 28/09. **Not opened** (article codes, probably prices).
    Whether it carries the Plus codes with a tranche count that
    [OI-188](../items/OI-188%20Performance%20Plus%20products%20are%20identified%20by%20the%20Mexal%20article%20category.md)
    is waiting for is **unknown**, and Performance Plus UAT is 05/10.
12. ⚠🔑 **[OI-194](../items/OI-194%20The%20ticket%20is%20a%20signed%20participation%20document%20not%20just%20a%20QR%20code.md)
    and [OI-195](../items/OI-195%20WhatsApp%20sends%20imply%20a%20mobile%20community%20that%20was%20never%20designed.md)
    — both gating, both raised last night — were not discussed at either session.**
    The participation document was the reason the 29/09 sweep called this UAT at risk.
    The UAT came and went without it. **This is an absence, verified by reading both
    transcripts in full, not an inference.**

## The register

**Amended? No. Version stays 1.6.**

Four client-agreed changes came out of the UAT and **all four are flagged into
[OI-184](../items/OI-184%20Register%20v1.6%20goes%20to%20the%20client%20as%20one%20change%20set%20at%20UAT%20close.md)**,
whose own open flag named "Biglietti 30/09" as a session whose changes must join the
change set. Two reasons for not amending tonight:

1. **OI-184 is the mechanism** — v1.6 goes to the client as one reviewed change set at
   UAT close. A nightly sweep writing contract-bound text into `REQUISITI.it.md`, the
   document the client signs, is not that review.
2. **A reversal needs a human to confirm it is one.** Neither the mapping change nor
   the send-rule change was acknowledged in the room as overturning an earlier
   agreement, and the 26/08 ruling was confirmed by the same person who overturned it.

⚠ **`Inviato` is deliberately excluded from that set** — it came from the
ROMI-internal Post UAT, and `BIG-17` already carries a worked precedent refusing the
unminuted seventh `Rinuncia` box. An eighth state from an internal session is weaker
evidence, not stronger. 🔴 `DIV-07` remains open.

## Not done in this run

- The org was **not** opened. `STATUS.md` was not regenerated and the Notion mirror
  stays stale. Every build claim is repository arithmetic against `DevMain` `0b6b828`.
- **No Apex test was written, proposed or scaffolded**, per the standing instruction.
- No transcript was copied into `meetings/`; no per-meeting recap in `meetings/results/`.
- `npm run prettier:verify` was not run (no `node_modules`), so tonight's markdown is
  unformatted.
- `4f672a2` (Anita Aga, `DevAnita30`, 17:56 CEST, _"Added Custom metatadata type,
  changed the Gestici Prodotti Component"_) was **read by message only, not by diff** —
  unmerged, and a custom metadata type is the shape
  [OI-96](../items/OI-96%20Edition%20mapping%20table%20on%20Salesforce.md) has an open
  question about. ⚠ **Worth a diff next run.**
- The **UAT recording** (823 MB mp4) was not opened; the transcripts were sufficient.

## Still unreachable

- **`Flows & Objects.drawio`** — modified **again at 14:11:53Z on 30/09**, the **fifth
  day running**, still an `mxfile` the Drive reader cannot parse. ⚠ It moved **during
  the UAT**, so it may already carry today's campaign and asset changes. Ask Elena
  Spini for a PNG or PDF export.
- **`Articoli Salesforce.xlsx`** — moved 30/09 12:45:55Z, **not opened** (see above).
- **`Campagne Salesforce.xlsx`** — **did not move** in this window, on the day of the
  campaigns UAT. Still not opened.
- **`Testbook_UAT_Lead_Opportunita_2026-09-24_v2_1.xlsx`** — **did not move.** Still
  the one artifact that would show whether the client has responded, and approval is
  due ~13/10.
- **`Business_Blueprint_Pienissimo.docx`** — did not move. Drive id known.
- **The full text of `Pienissimo_Scheda di Partecipazione ai corsi_da firmare.pdf`** —
  not opened; its seven enrolment pages may carry personal data. ⚠ **Nobody has read
  it properly yet and OI-194 is gating.**
- **Elena Spini's written flow document** — owed as of tonight, does not exist yet, and
  [OI-197](../items/OI-197%20The%20ticket%20send%20flag%20and%20the%20Inviato%20asset%20state%20are%20agreed%20and%20unbuilt.md)'s
  read side is deferred until it does.
- **The 30/07 marketing notes**, standing.
- **The 12:30 CEST internal call of 25/09** — still no artifact, fifth run.
- ⚠ **The Pienissimo lead documentation** Elena Spini said she owed on 28/09.
  Unresolved; not raised today.

**Nothing 404'd.**

## Absence of evidence, stated as absence

- **Fathom has returned nothing for seven consecutive runs.** Both of today's real
  sessions exist only as Google Meet artifacts. That is a pattern about the tooling,
  not about the project, and a future sweep should not read Fathom silence as quiet.
- **No sandbox exception mail arrived in this window** — the first such day in three.
  That is not evidence the edition mapping is fixed: the mapping table was not
  touched, and no order may have been created.
