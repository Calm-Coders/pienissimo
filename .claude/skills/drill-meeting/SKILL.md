---
name: drill-meeting
description: Processes a raw meeting transcript (pasted or given as a file path) for the ROMI-PIENISSIMO Salesforce project — stores the original Italian transcript in meetings/, writes structured recaps in English AND Italian to meetings/results/, updates the cross-meeting open-items trackers (EN+IT), and updates DEVELOPMENT-RECAP.md + DEVELOPMENT-RECAP.it.md. Runs the FULL pipeline automatically whenever the user provides a transcript — no need for them to ask for each step.
---

# Drill Meeting (ROMI-PIENISSIMO edition)

Whenever the user provides a meeting transcript — pasted in chat or as a file path (e.g. `C:\Users\Admin\Desktop\Meeting N.txt`) — run the ENTIRE pipeline below automatically. Do not ask which steps to perform: transcript storage, bilingual recaps, tracker update, and development-recap update are all mandatory every time.

## Pipeline

1. **Ingest the source.**
   - File path given → check size/completeness first (`wc -c`, head/tail: must end with call sign-off, not mid-sentence), then copy verbatim into `meetings/` as `YYYY-MM-DD-<slug>-transcript.it.md` (date and title are in the transcript header; year from context — project runs in 2026).
   - Pasted in chat → beware the ~50,000-character paste truncation: if the text ends mid-sentence or covers far less than the stated recording length, STOP, save nothing final, and ask for the rest (recommend the file method). Stitch multi-part pastes before processing.
   - Never modify an original transcript; `meetings/` files are the raw source of truth.

2. **Read the whole transcript** and extract: date, attendees, decisions, action items (task/owner/status), open questions/risks, and anywhere this meeting **changes or reverses** an earlier decision — mark those with a `> **Cross-meeting update:**` callout linking the earlier result file.
   - ⚠ Fathom speaker labels are chronically unreliable in this project (Aurel's technical explanations get attributed to others; "Marco" is often Fabrizio). Reconstruct attribution from content and note the caveat in the recap header.
   - Key people: ROMI = Elena Spini, Andrea Di Cicco, Aurel Mrruku (the user), Andrea Galotto. Pienissimo = Sabatino Rinaldi, Fabrizio Paganelli (admin/Mexal), Daniela Morgese (direction), Marco Montesi (sales mgr), Elisa Migliano (admin), Matteo (marketing), Giuliano Aranzetti (frontman).

3. **Write TWO recaps** to `meetings/results/`, same basename as the transcript minus `-transcript.it`:
   - `<name>.md` — English
   - `<name>.it.md` — Italian
     Structure: title+date, Sources, Attendees (with label-garbling note), Decisions, Action Items table (Task/Owner/Status), Open Questions / Risks, Notes. The user acts from these recaps — decisions and owners must be complete and unambiguous; mark genuinely unclear points as TBD instead of guessing, and collect TBDs for the final report.

4. **Update BOTH trackers** — `meetings/open-items.md` (EN) and `meetings/open-items.it.md` (IT):
   - Apply meetings in **chronological order**. If this transcript backfills an earlier date, set its "Raised" dates accordingly and never move "Last touched" backwards on rows later meetings already touched.
   - Add rows for new open items; move answered rows to Resolved (keep history, cite dates); update "Last touched" on discussed-but-open rows; leave untouched rows alone.
   - Keep row numbers stable; append new numbers. Flag rows untouched for 2+ tracked meetings with ⚠ stale.
   - Maintain the header note listing tracked meetings and known gaps.

5. **Update the development recap** — `meetings/DEVELOPMENT-RECAP.md` AND `meetings/DEVELOPMENT-RECAP.it.md` — with **latest-decision-wins**:
   - Fold new/changed decisions into the right section (§1 project frame, §2 data model, §3 flows, §4 integrations, §5 analytics, §6 security, §7 config, §8 resolved, §9 blocking items), citing the meeting date.
   - If a decision reverses an earlier one, update the section to the new state and record the reversal in §8.
   - Promote newly-blocking items into §9; remove §9 entries the meeting resolved.
   - Keep both language versions in lockstep — same content, same statuses (✅/🟡/🔴).

6. **Report back** in chat: file paths created/updated, the headline decisions (the user executes actions from this), TBDs needing their confirmation, cross-meeting reversals, and any ⚠ stale tracker rows (2+ meetings untouched) — surfacing stale items is the tracker's whole purpose.

## Notes

- **`meetings/proposals/` holds ROMI-side design proposals** (e.g. the Asset/ticket data model). When a transcript discusses a topic covered by a proposal, RECONCILE it: append the outcome (accepted / modified / rejected, with date and what changed) to the proposal's "Reconciliation log" section, update its status line, and reflect the outcome in the trackers + DEVELOPMENT-RECAP.
- Everything is bilingual by convention: transcript stays Italian-only (original); recaps, trackers, and DEVELOPMENT-RECAP exist in EN + IT.
- Multiple raw files (summary + transcript) can exist for one meeting; result filename pairs with the primary source.
- If several transcripts arrive at once, process each fully but apply steps 4–5 once, in date order, at the end.
- Known archive gaps (as of 2026-07-13): 06/04 marketing demo, ~06/19 marketing meeting, 06/23 marketing meeting, 06/25 sales follow-up. If one of these arrives, it backfills — handle per step 4.
