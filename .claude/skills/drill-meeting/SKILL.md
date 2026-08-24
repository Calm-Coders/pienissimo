---
name: drill-meeting
description: Processes a raw meeting transcript (pasted or given as a file path) for the ROMI-PIENISSIMO Salesforce project — preserves the original Italian transcript in meetings/, extracts every fact into atomic notes under notes/, then regenerates the bilingual meeting recaps, the open-items trackers (EN+IT) and DEVELOPMENT-RECAP (EN+IT) from those notes. Runs the FULL pipeline automatically whenever the user provides a transcript — no need for them to ask for each step.
user-invocable: true
---

# Drill Meeting (ROMI-PIENISSIMO edition)

Whenever the user provides a meeting transcript — pasted in chat or as a file
path — run the ENTIRE pipeline below automatically. Do not ask which steps to
perform.

Read [notes/Retrieval and write protocol.md](../../../notes/Retrieval%20and%20write%20protocol.md)
if you have not already this session. **Notes are the source of truth; the
documents in `meetings/` are views regenerated from them.**

## 1. Ingest and preserve

- **File path** → check size and completeness first (`wc -c`, head/tail: it must
  end with a call sign-off, not mid-sentence), then copy verbatim into
  `meetings/` as `YYYY-MM-DD-<slug>-transcript.it.md`. The date and title are in
  the transcript header; the year is 2026.
- **Pasted in chat** → beware the ~50,000-character paste truncation. If the
  text ends mid-sentence or covers far less than the stated recording length,
  STOP, save nothing final, and ask for the rest.
- **Never modify a stored transcript.** `meetings/*-transcript.it.md` and
  `meetings/results/*.md` are preserved records.

## 2. Read the transcript exactly once

This is the only step permitted to load a transcript, and the most expensive
thing this skill does. Read it in order, in chunks if large, and extract
everything in one pass — attendees, decisions, requirements, action items with
owners, open questions, risks, deadlines, and changes to earlier decisions.

Do not re-read it later to check a detail. Capture it now, or `rg` for the
specific line afterwards.

⚠ **Speaker labels in this project are chronically unreliable.** Aurel's
technical explanations get attributed to others; "Marco" is often Fabrizio;
Gemini auto-summaries have contradicted the transcript outright. Reconstruct
attribution from content, prefer the transcript over any auto-summary, and note
the caveat in the recap header. Mark uncertain attribution as uncertain rather
than guessing.

## 3. Write the atomic notes — the source of truth

Everything extracted becomes notes in `notes/`, with plain YAML frontmatter per
the schema in [AGENTS.md](../../../AGENTS.md). **The filename is the note's H1
title** — spaces, ASCII only, accents transliterated, never
`/ \ : * ? " < > | ( )` or apostrophes:

- `notes/meetings/YYYY-MM-DD <Meeting title>.md` — the meeting itself:
  attendees, what was decided, what it changed.
- `notes/items/OI-NN <What the item asks for>.md` — one per action item.
  **The number is the tracker row number.** Reuse the existing number when the
  item already exists; allocate the next free number otherwise. Ids are stable
  forever — reword the title after the number, never the number, because those
  numbers are cited in `REQUIREMENTS.md`, in the published artifacts and in the
  client's own correspondence.
- `notes/decisions/`, `notes/risks/`, `notes/flows/`, `notes/objects/`,
  `notes/people/` as the content requires. Risks read
  `Risk - <what goes wrong>.md`; people read `<Full name> - <role> <org>.md`.
- Link with `%20` for the spaces:
  `[OI-75](../../../notes/items/OI-75%20Ticket%20availability%20rule.md)`.

Rules: update `status:` and bump `updated:` on every note you touch. Later
evidence wins, but record the reversal and cite both meeting dates. One fact per
note.

## 4. Regenerate the views — all four files, both languages

From the notes, not from memory of the transcript:

- `meetings/results/<name>.md` and `<name>.it.md` — the per-meeting recap.
  Structure: title + date, Sources, Attendees (with the label-garbling note),
  Decisions, Action Items table, Open Questions / Risks, Notes.
  **The Sources / Fonti line must link the transcript, not just name it** —
  `**Sources:** [meetings/<name>-transcript.it.md](../<name>-transcript.it.md) (…)`.
  A bare path or one wrapped in backticks renders as text, so the recap and its
  transcript end up as disconnected nodes in the Obsidian graph. The recap is
  the only side that links: the transcript itself is never edited.
- `meetings/open-items.md` and `.it.md` — apply meetings in **chronological
  order**. Add rows for new items, move answered rows to Resolved citing dates,
  update "Last touched" on discussed-but-open rows, leave untouched rows alone.
  Keep row numbers stable. Flag rows untouched across 2+ tracked meetings as
  ⚠ stale. Maintain the header note listing tracked meetings and known gaps.
- `meetings/DEVELOPMENT-RECAP.md` and `.it.md` — latest-decision-wins. Fold
  changes into the right section citing the meeting date; record reversals;
  promote newly-blocking items and remove ones the meeting resolved. Keep both
  languages in lockstep, same ✅/🟡/🔴 statuses.

**If a requirement changed**, update
[requirements/pienissimo-requirements.yaml](../../../requirements/pienissimo-requirements.yaml)
**and** both `REQUIREMENTS.md` / `REQUISITI.it.md`, in the same session. The
Italian is the text the client signs.

**Wire every requirement you touch to its note, in both directions** — the note
carries `requirement: BIG-06`, the requirement entry carries
`tracked_by: [OI-75]`. That pair is what lets anyone walk a signed requirement
back to the meeting that produced it: requirement → note → the note's
`source:` → the recap → the transcript. Adding only one side leaves a dead end.
`npm run vault:check` reports every mismatch, and a requirement id that does not
exist in the registry.

## 5. Close out

- Update [MAP.md](../../../MAP.md) if the live position moved, and
  [INDEX.md](../../../INDEX.md) if notes were added.
- If the session moved the live position, refresh
  [STATUS.md](../../../STATUS.md) and its Notion mirror — **step 6 of
  [org-status-check](../org-status-check/SKILL.md)** is the procedure and the
  rules there apply unchanged. A missing Notion connector is not a failure:
  regenerate `STATUS.md`, report the mirror as stale. **Never** put anything
  from `STATUS.md` into `site/`, which is public and sanitized to different
  rules, and never a price or an article-code value into either.
- Append a [JOURNAL.md](../../../JOURNAL.md) entry.
- Run `npm run vault:check`.

## 6. Report back

File paths created and updated, the headline decisions, TBDs needing the user's
confirmation, cross-meeting reversals, and any ⚠ stale rows — surfacing stale
items is the tracker's whole purpose.

## Notes

- **`meetings/proposals/` holds ROMI-side design proposals.** When a transcript
  touches a topic a proposal covers, RECONCILE it: append the outcome
  (accepted / modified / rejected, with date and what changed) to the proposal's
  reconciliation log, and reflect it in the notes and views.
- The transcript stays Italian-only; recaps, trackers and the recap document
  exist in EN + IT.
- If several transcripts arrive at once, drill each fully but regenerate the
  views once, in date order, at the end.
- Known archive gaps: 06/04 marketing demo, ~06/19, 06/23 marketing,
  06/25 sales follow-up, 30/07 marketing follow-up. If one arrives, it
  backfills — never move "Last touched" backwards on rows later meetings
  already touched.
