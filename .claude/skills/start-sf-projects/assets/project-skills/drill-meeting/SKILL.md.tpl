---
name: drill-meeting
description: Process raw meeting transcripts for the {{PROJECT_NAME}} Salesforce project by preserving the source transcript, extracting facts into atomic notes under notes/, then regenerating the bilingual meeting recaps, open-item trackers and development recaps from those notes, and reporting decisions, actions, risks, reversals and TBDs. Use whenever the user supplies or references a meeting transcript, meeting notes, or a meeting recording transcript for the project.
---

# Drill Meeting

Full meeting-intelligence pipeline. The user supplies a transcript once and
gets storage, atomic notes, recaps, and refreshed trackers without asking
separately.

Read [notes/agent-protocol.md](../../../notes/agent-protocol.md) if you have not
already this session.

## 1. Ingest and preserve

- For a file path, check size plus the beginning and end before processing;
  require a complete ending rather than a mid-sentence truncation.
- For pasted text, detect likely truncation and collect every part before
  writing any final artifact.
- Infer the meeting date and a short slug from evidence. Ask only when the
  ambiguity would change filenames or chronology.
- Preserve the transcript verbatim at
  `meetings/YYYY-MM-DD-<slug>-transcript.<language>.md`.

## 2. Read the transcript exactly once

This is the only step permitted to load a transcript, and the most expensive
thing this skill does. Read it in order, in chunks if large, and extract
everything in one pass — attendees, decisions, requirements, action items with
owners, open questions, risks, deadlines, and changes to earlier decisions.

Do not re-read it later to check a detail. Capture it now, or `rg` for the
specific line afterwards.

Mark uncertain speaker attribution or facts as uncertain instead of guessing.

## 3. Write the atomic notes — the source of truth

Everything extracted becomes notes in `notes/`, with descriptive filenames and
plain YAML frontmatter per the schema in [AGENTS.md](../../../AGENTS.md):

- `notes/meetings/YYYY-MM-DD-<slug>.md` — one note for the meeting itself:
  attendees, what was decided, what it changed.
- `notes/items/OI-NN-<short-description>.md` — one per action item. **Reuse the
  existing number** when the item already exists; allocate the next free number
  otherwise. Ids are stable forever and never renumbered.
- `notes/decisions/`, `notes/risks/`, `notes/flows/`, `notes/people/` as the
  content requires.

Rules:

- Update `status:` and bump `updated:` on every note you touch.
- Maintain `depends_on:` and `blocks:` so the dependency chain stays queryable
  by `rg` without reading files.
- Flag items untouched across two or more tracked meetings as `status: stale`.
- When new evidence overturns an earlier decision, later evidence wins — but
  record the reversal in the note body and cite both meeting dates.
- Backfilling an older meeting must never overwrite facts established by later
  evidence. Add the history; do not rewrite the present.
- Set `uncertain:` rather than resolving a contradiction you cannot evidence.

## 4. Regenerate the views

The documents below are **rendered from the notes**, never hand-authored as
sources. Regenerate all of a pair together so the two languages cannot drift —
they are two renderings of one source:

- `meetings/results/<name>.md` and `<name>.it.md` — the meeting recap: title,
  date, sources, attendees, decisions, action-item table, open questions and
  risks, notes. Link cross-meeting reversals to the earlier recap.
- `meetings/open-items.md` and `meetings/open-items.it.md` — chronological,
  numbering and statuses taken from frontmatter.
- `meetings/DEVELOPMENT-RECAP.md` and `.it.md` — sections for project frame,
  data model, automation, integrations, analytics, security, configuration,
  resolved decisions, blocking decisions.
- [MAP.md](../../../MAP.md) — only if the live chain or the blocker changed.
- [INDEX.md](../../../INDEX.md) — add rows for the new notes.

Then reconcile any affected file in `meetings/proposals/`: update its status and
append a dated reconciliation entry for accepted, modified, or rejected items.

## 5. Close out

1. If the meeting moved the live position, refresh
   [STATUS.md](../../../STATUS.md) and its Notion mirror using the reconciliation
   and publishing references under `org-status-check`. A missing
   Notion connector is not a failure: regenerate `STATUS.md` and report the
   mirror as stale. **Never** put anything from `STATUS.md` into `site/`, which
   is public and sanitized to different rules.
2. Append a [JOURNAL.md](../../../JOURNAL.md) entry in the
   `Did / State / Next / Watch` shape.
3. Run `npm run vault:check` and fix anything it reports.

## Guardrails

- Never modify a preserved raw transcript after ingestion.
- Never fabricate transcript text, attribution, attendees, owners, dates, or
  decisions.
- Do not copy secrets or unnecessary personal data into notes or recaps. The
  repository is private; `site/` is public — see
  [docs/publishing.md](../../../docs/publishing.md).

## Report

Close with: files created or updated, headline decisions, action owners, TBDs,
reversals, newly stale items, and anything marked uncertain.
