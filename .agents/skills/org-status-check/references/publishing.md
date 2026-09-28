# Publish the rendered status surfaces

Use only after reconciliation and only when the selected output is `publish`.
There are two audiences whose text must never be copied between surfaces:

- `STATUS.md` and its Notion mirror — ROMI internal, invite-only and candid;
- `site/` — public and sanitized.

Read `docs/publishing.md` and
`notes/The Notion mirror of the project status.md` before any publication step.

## Notion identity and ids

1. Fetch Notion identity with id `self` and confirm the exact workspace recorded
   in the mirror note.
2. Take page/database ids from that note. Never search by title: the same
   workspace contains similarly named project mirrors.
3. If identity fails or differs, do not write. `STATUS.md` remains the
   deliverable; report the mirror's last successful refresh date.

## Status page

- Fetch the existing page first.
- Update it in place with the smallest `update_content` replacements.
- Use whole-page replacement only after confirming no child page or database
  would be deleted.
- Never create a replacement status page without the user's decision; changing
  the URL strands existing invitations.
- Keep the internal-only warning, price warning and source-of-truth warning.
- Convert Markdown tables to Notion table blocks/syntax.
- Never wrap inline code in bold; Notion round-trips it as visible stray
  asterisks.
- Re-fetch after every write and verify what was actually stored.

## Tracker

Reconcile rows on `Ref`, never title. One row mirrors one `notes/items/` note.

- update changed status, owner, severity and dependencies;
- add a row only when an atomic note exists;
- never delete a row for a note that still exists;
- set `Note` to the percent-encoded GitHub URL on `DevMain` only after the branch
  has been pushed, otherwise it returns 404;
- leave database views alone unless the user asked to repair them.

If the connector is unavailable, stale or consistently refuses writes, stop the
Notion stage after one retry and report the mirror as stale. Never turn on
“Publish to web.”

## Flows page

Refresh it only when flow notes or the register's state machines changed. Keep
the legend and all diagram conventions. Do not draw a flow without an atomic
note; label it undrawn instead of inventing transitions.

## Public `site/`

Re-derive it from notes and the current run. Never copy a sentence from
`STATUS.md` or Notion.

- refresh “Status as of” and the remaining-weeks figure;
- use the existing anonymized vocabulary;
- include only permitted milestones, phase, counts, workstream state and role
  names without people;
- never include names, org aliases, endpoints, credentials, exact coverage,
  security weaknesses, prices or article codes;
- run the leak-check command from `docs/publishing.md`; it must return nothing.

Refreshing `site/` does not deploy it. State plainly whether the file changed
and that the public URL did not move unless a separate deployment was requested.
