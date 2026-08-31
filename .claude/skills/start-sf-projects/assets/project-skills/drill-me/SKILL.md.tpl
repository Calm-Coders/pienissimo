---
name: drill-me
description: Run an interactive decision session for the {{PROJECT_NAME}} Salesforce project by loading MAP.md and querying the notes/ graph by frontmatter, ranking the decisions that actually need the user, asking concrete adaptive questions, and writing answers back to the atomic notes before regenerating the bilingual trackers. Use when the user says drill me, asks what to decide, wants to clear blockers, or wants an interactive project review.
---

# Drill Me

Interactive decision session. Load as little as possible, ask about what only
the user can answer, write the answers back into the graph.

Read [notes/agent-protocol.md](../../../notes/agent-protocol.md) if you have not
already this session.

## 1. Load — cheap by default

1. Read [MAP.md](../../../MAP.md). This alone usually identifies the live chain
   and what is blocking it.
2. **Collect the open ambiguities first.** `requirements-check` records anything
   it could not resolve on its own as `uncertain:` frontmatter, and lists them
   under "Ambiguities needing drill-me" in the newest
   `notes/traces/*-trace.md`. Those are this session's primary agenda:

   ```bash
   ls notes/traces/ | sort | tail -1        # newest trace note
   rg -n "^uncertain:" notes/               # every unresolved ambiguity
   ```

3. Then select the rest by querying frontmatter, **not** by reading files:

   ```bash
   rg -l "^status: (open|in-progress)" notes/items/
   rg -l "^status: stale" notes/items/
   rg -n "^owner:|^blocks:|^depends_on:|^severity:" notes/items/ notes/risks/
   ```

4. Read **only** the notes those queries return, and only the ones plausibly
   decidable by the user.

Do **not** open `meetings/DEVELOPMENT-RECAP.md`, `meetings/open-items.md`, or
the meeting recaps to start a session. Escalate to them only when a specific
question cannot be answered from the notes, and say in your reply that you did
and why. Never open a transcript; `rg` it.

## 2. Rank

Order by what unblocks the most work, not by age. Weight:

- **notes carrying `uncertain:` — these come first.** An automated sweep hit
  something it could not decide and deliberately handed it to you. Every one
  must be either resolved or explicitly deferred before the session ends;
- items whose frontmatter has `blocks:` entries, deepest chain first;
- `severity: gating` and open risks;
- items the user personally owns (`org: ROMI`, owner Aurel Mrruku);
- stale items only if they still matter.

Drop anything the user cannot decide — client-owned items belong in a
follow-up list, not in the questioning.

## 3. Ask

Ask concrete, adaptive questions, a few at a time, with enough context that the
user need not open a file to answer. Offer the realistic options and say what
each one costs or unblocks. Adapt to the previous answer instead of running a
fixed list.

Never ask about something the notes already settle.

## 4. Write back

Answers land in the **notes**, which are the source of truth:

0. **Clear each ambiguity you resolved.** Delete the `uncertain:` line from that
   note's frontmatter and replace the ambiguous passage in the body with the
   settled fact, citing who decided it and when. An ambiguity is only closed
   when the marker is gone — leaving it means the next sweep raises it again.
   If the user could not settle one, keep `uncertain:` and record _why_ it is
   still open and who can answer it, so the next session does not re-ask blind.
1. Update the relevant note(s) in `notes/`: change `status:`, append the
   decision with its date, bump `updated:`. Create new notes for new facts,
   with a stable `id` that is never reused.
2. Record a reversal explicitly when an answer overturns an earlier decision —
   cite both dates. Later evidence wins, but the history stays.
3. Regenerate the affected view documents from the notes, all four together so
   they cannot drift: `meetings/open-items.md`, `meetings/open-items.it.md`,
   `meetings/DEVELOPMENT-RECAP.md`, `meetings/DEVELOPMENT-RECAP.it.md`.
   Numbering, dates and statuses come from frontmatter, so the Italian and
   English versions are two renderings of one source, never two sources.
4. Update [MAP.md](../../../MAP.md) if the live chain or the blocker changed.
5. **A drill-me session almost always moves an item's `status:`**, which is
   what the Notion tracker mirrors. Refresh [STATUS.md](../../../STATUS.md) and
   its mirror using the reconciliation and publishing references under
   `org-status-check`. Reconcile tracker rows on `Ref`, never on the title. A missing connector is not a failure:
   regenerate the file and report the mirror as stale. Nothing from it ever
   reaches `site/`.
6. Append an entry to [JOURNAL.md](../../../JOURNAL.md) in the
   `Did / State / Next / Watch` shape, so the next session — possibly Codex or
   another model — resumes cold.
7. Run `npm run vault:check` and fix anything it reports.

## Guardrails

- Do not reopen settled decisions unless the user explicitly changes them.
- Never fabricate owners, dates, or decisions. If the user is unsure, record
  `uncertain:` in frontmatter rather than inventing a resolution.
- Tracker coverage is incomplete — seven meeting sources are unreachable. Do
  not present the graph as exhaustive.
- No secrets or unnecessary personal data in notes or trackers.

## Report

Close with: **every ambiguity you cleared and every one still open**, what was
decided, which notes changed, what is now unblocked, what still needs the
client, and anything you escalated to a costly document.

If ambiguities remain, say plainly that a further `drill-me` is needed and name
them — the nightly sweep will keep flagging them until the markers are gone.
