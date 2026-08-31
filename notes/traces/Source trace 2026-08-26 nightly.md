---
id: trace-2026-08-26-nightly
type: reference
status: active
updated: 2026-08-26
watermark_used: 2026-08-26
external_watermark: 2026-08-26T21:40Z
account: a.mrruku@romicompany.com
---

# Source trace 2026-08-26 nightly

**Watermark for the next `requirements-check` run: 2026-08-26T21:40Z.**

**Watermark used for this run: 2026-08-26** — the
[trace taken earlier the same day](Source%20trace%202026-08-26.md), selected by
its `updated:` frontmatter field, not by filename order.

⚠ **This is the second trace dated 2026-08-26 and it does not supersede the
first.** The earlier one ran at **~13:15 CEST** and was dry. This one ran at
**~23:35 CEST** and is the largest single-session haul since 24 August. The
window between them contains one client meeting, its full record, and the Slack
thread that followed it. Select by `updated:` **and** `external_watermark:`; a
filename sort would put these two in an arbitrary order.

**The sweep was not dry.** The 16:00 Mexal review ran, was fully minuted, and
**changed the design**.

## Sources searched

All read-only. **Nothing was sent, replied to, shared, modified or marked read**,
with the single carve-out of the nightly report to `C0BQD34LLF4`.

| Source       | Query / scope                                                                | Result                                                                                                                                            |
| ------------ | ---------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Gmail**    | `pienissimo after:2026/08/26`                                                | **2 threads, both new** — the Gemini notes for the Mexal review (15:32Z) and the **2 September Follow-up Anagrafica Articoli** invitation (16:40Z) |
| **Gmail**    | all mail `after:2026/08/26 -in:draft`                                        | 5 threads. The two above, plus the Jira weekly digest and the `Salesforce Login` / 247.it licence thread — **neither is Pienissimo**              |
| **Drive**    | `modifiedTime > 2026-08-26T10:00:00Z`, fully paged                           | **7 files.** The Gemini notes doc, the recording, the meeting folder and its two shortcuts, `Flows & Objects.drawio`, the holiday planner         |
| **Drive**    | `title contains 'Pienissimo' and modifiedTime > 2026-08-20`                  | 5 files, all already held except the 26/08 notes doc and folder                                                                                   |
| **Slack**    | workspace-wide incl. private channels, DMs and group DMs, `pienissimo`       | 7 hits. **One is new and substantive** — the ROMI group DM `C0BFDNXQKAS`; the rest are the day's two org-status posts and the LIFE365/IUAD runs   |
| **Slack**    | workspace-wide, `mexal`, after 2026-08-25                                    | 1 hit — the same group DM thread, read in full (8 replies)                                                                                        |
| **Slack**    | `#tproj-pienissimo` (`C0B5T3RB4FM`), 10 messages back                        | Last post still **07 Aug 17:12** — unchanged for a **sixth** week                                                                                 |
| **Slack**    | Canvas _Link utili Pienissimo_ (`F0BD2H5A9HT`), re-read in full              | **Unchanged.** Newest entry still **20.08** — now **three** client sessions behind                                                                |
| **Fathom**   | all meetings created after 2026-08-07                                        | **0 recordings.** Unchanged since 06 Aug — recordings still land in Drive, not Fathom                                                             |

## Found

### 1. 🔴 The Mexal review ran, and the edition mechanism changed

`[ROMI-PIENISSIMO] - Review Temi Integrazione Mexal`, **26 August 16:00–17:26
CEST, 1h25m45s**. Gemini notes, **full transcript** and recording all present.
First Mexal session since 14 July.

Drilled per `drill-meeting`. The transcript was preserved verbatim at
`meetings/2026-08-26-review-temi-integrazione-mexal-transcript.it.md` (88 KB) and
read **once, in full** — it ends properly at _"Trascrizione terminata dopo
01:25:45"_, so it is complete, not truncated.

The headline: **the event edition now comes from a hand-maintained Salesforce
table** keyed on `article code × order-date window`, matched per **order line** —
[OI-96](../items/OI-96%20Edition%20mapping%20table%20on%20Salesforce.md). It
**replaces the one-active-child-campaign rule** agreed 24 August, which Elena
Spini killed in session. Everything else is in
[the meeting note](../meetings/2026-08-26%20Review%20Temi%20Integrazione%20Mexal.md)
and the bilingual recap.

### 2. 🟢 A new client-facing meeting was booked

`[ROMI-PIENISSIMO] - Follow-up Anagrafica Articoli`, **Wednesday 2 September
10:00–11:30 CEST**, invitation sent 16:40Z by Elena Spini to Aurel Mrruku,
`amministrazione@pienissimo.com`, Andrea Di Cicco and Fabrizio Paganelli.

Its provenance is in the Slack thread below: it is the follow-up Andrea Di Cicco
asked for during the call, and it covers **both** registries despite its title.

### 3. The ROMI group DM carries the sharper version of the day

`C0BFDNXQKAS` (Elena Spini, Aurel Mrruku, Andrea Di Cicco), 17:27–18:30 CEST,
read in full. Three things it says that the meeting did not:

- **_"le integrazioni per ordini e clienti funzionicchiano"_** — Andrea Di
  Cicco's own verdict, 18:02.
- 🔴 **_"loro hanno dei valori che sono tipo per valuta: 1,2,3,4 — che lato
  nostro non sappiamo"_** — Mexal's coded-value dictionaries are unknown to ROMI
  **as a class**, not just for `valuta`. Asked for by email; unanswered.
- Elena Spini booking the follow-up at 18:30, ten minutes before the invitation.

### 4. `Flows & Objects.drawio` moved a sixth time — and nothing tracked changed

New timestamp **2026-08-26T14:06:48Z**, which is **16:06 CEST, six minutes into
the meeting Elena Spini was chairing**. Re-decoded in full at that version.

**Every text cell the record tracks is unchanged, word for word.** Geometry and
style were **not** compared — only text. The likeliest explanation is an autosave
from opening the file during the call. Report it as "no tracked wording moved",
not as "no change".

🔴 **It leaves two cells stale rather than one.** The LEAD-OPTY/Ordini Anticipay
split is unfixed after two further edits, and the `IMPORTANTE` cell still carries
_"Sulle campagne figlie deve esserci logica solo una campagna attiva"_ — the rule
superseded that afternoon.

### 5. 🔴 OI-92 was never raised

The scadenziario question was minuted on 20 August as an action for **this**
forum. Its proposer and its owner were both in the room for 1h25m. **The word
does not appear once** in the transcript, the notes, the decisions or the next
steps. It now has no scheduled forum.

## What it changed

**Nine notes updated, five created, both trackers, both recaps, MAP and INDEX.**

| Created | |
| --- | --- |
| `notes/meetings/2026-08-26 Review Temi Integrazione Mexal.md` | The session |
| `notes/items/OI-96 Edition mapping table on Salesforce.md` | The new mechanism |
| `notes/items/OI-97 Fiscal residence on the customer registry.md` | Mandatory, undocumented |
| `notes/items/OI-98 The Mexal article registry is being re-created.md` | ~1000 codes to be replaced |
| `notes/items/OI-99 Customer registry deep mapping session.md` | Booked for 2 Sept |

| Updated | Because |
| --- | --- |
| OI-46 | The replacement mechanism is now specified; `Anno_Solare__c` is decidable |
| OI-47 | Both flags get a Mexal carrier — `natura` |
| OI-48 | 🔴 Reversed — the twin codes are needed after all |
| OI-58 | Listino answered · no test env · credentials closed by behaviour |
| OI-76 | Tiers confirmed, carrier reopened |
| OI-77 | 🔴 Mechanism replaced again |
| OI-92 | 🔴 The forum came and went |
| `The campaign parent and child model` | Two of four agreed items superseded |
| `The Mexal integration` | The classification contract; first write calls succeed |
| `The article code namespace` | Scheduled to be replaced |
| `The newest design diagram` | Sixth edit; re-decoded; now stale on campaigns |

Also: `meetings/results/2026-08-26-review-temi-integrazione-mexal.md` **and**
`.it.md`; `open-items.md` **and** `.it.md` (rows 46, 47, 48, 58, 76, 77, 92
touched, 96–99 added); `DEVELOPMENT-RECAP.md` **and** `.it.md` §20; `MAP.md`;
`INDEX.md`; the transcript-size line in `AGENTS.md` and `INDEX.md` (~830 KB →
~918 KB).

**No requirement document was opened or changed.** `pienissimo-requirements.yaml`,
`REQUIREMENTS.md` and `REQUISITI.it.md` are untouched — see §20.11 of the recap
for why, and for the register change that will be owed once
[OI-96](../items/OI-96%20Edition%20mapping%20table%20on%20Salesforce.md)'s
worked-examples session has run.

⚠ **`STATUS.md`, the Notion mirror and `site/` were not regenerated.** They were
refreshed by the `org-status-check` run earlier the same day and carry **build
state**, which this sweep did not move — this sweep moved **decisions**. The
Flows page is a closer call: `notes/flows/The Mexal integration.md` changed, so
step 6a-bis would apply on the next org-status run. **Flagged, not done**, since
regenerating it would restate the same org figures.

## Deliberately not ingested

- The `Salesforce Login` thread with Mehak Luthra (247.it), 24–26 August. It is
  **ROMI's own Salesforce licence access**, not Pienissimo's org — Luca Savi
  raised a licence-payment access limit and Aurel Mrruku confirmed on 26/08 at
  15:18Z that access was restored _"da ieri"_. Vendor administration, not a
  project requirement.
- The Jira weekly digest, the holiday planner, and the day's two `org-status`
  Slack posts — the latter are the **26 August org check's** output, already
  folded into `MAP.md` by that run, and not a `requirements-check` source.
- The LIFE365 and IUAD nightly reports visible in the same Slack search: **other
  projects**.

## Still unreachable / still owed

Carried from earlier traces, with today's movement marked.

- 🟢 **Listino 1 vs listino 2 — CLOSED.** _"usiamo solo l'uno."_ Whether a third
  listino could ever be needed was not asked and stays open.
- 🟢 **The Mexal WEBAPI credentials — closed by behaviour.** Andrea Di Cicco read
  the registry and created a customer and an order against production live in the
  session. Nobody mentioned credentials. Stop reporting them as owed unless
  someone names a specific missing one.
- 🔴 **A Mexal test company.** Serie 10 is still a test lane inside production
  data, and today it was used for real: customer `501.08721` and order `OC11` are
  **live production records**. No owner.
- 🔴 **Mexal's coded-value dictionaries** — new tonight. `valuta`, and the class
  of integer-coded fields generally. Andrea Di Cicco asked by email; unanswered.
- 🔴 **The marketing package** — DNS records, forms, funnel screenshots,
  newsletter and header graphics. Matteo Distaso and Rebecca Marmo. **All still
  overdue, nothing new.**
- **The Anticipay middleware API example**, Andrea Parmeggiani, due **4 Sept**.
- **WooCommerce credentials** — due at the **27 August 10:00** session, tomorrow.
- **Marco Montesi's preset quote-expiry timings** per product category.
- **The Pienissimo 30 July marketing follow-up** notes — never circulated.
- **The Zoho data-model workbook** ([OI-24](../items/OI-24%20Data%20model%20workbook.md))
  and ROMI's **import template** ([OI-88](../items/OI-88%20Zoho%20import%20template%20owed%20to%20Pienissimo.md)).
- ⚠ **The Slack canvas is now three client sessions behind** — newest entry
  20.08, missing 25 Aug Anticipay, 26 Aug Mexal and the two 24 Aug internals.

## Method notes worth keeping

- **A second run on the same day is not redundant.** The 13:15 sweep was
  correctly dry and correctly said so; the 23:35 sweep found a meeting that
  changed the design. The earlier trace even predicted it —
  _"the next `requirements-check` should expect a recording"_. **Trust the
  timestamp, not the date.**
- **The Gemini summary was accurate but thin.** It omits the two-code rule, the
  abandoned four-value encoding scheme, and — most consequentially — that the
  one-active-child-campaign rule was killed. All three are in the transcript.
  **Drilling the transcript found what the auto-summary would have lost.**
- **The Slack thread after a meeting is worth as much as the meeting.** The
  sharpest statement of the integration's problem (_"valuta: 1,2,3,4 — che lato
  nostro non sappiamo"_) and the booking of the next session both happened in a
  group DM, not in the call. A meeting-only sweep would have missed both.
- **A changed `modifiedTime` is not a changed document.** The design file moved
  and no tracked wording did. Say which comparison was actually run.
