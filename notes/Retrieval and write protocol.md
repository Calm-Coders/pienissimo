---
id: protocol
type: reference
status: active
updated: 2026-08-14
---

# Retrieval and write protocol

Tool-neutral. Applies to Claude Code, Codex, Cursor, Gemini, Copilot, and any
future agent. Referenced from [AGENTS.md](../AGENTS.md).

## Retrieval

Answer from the smallest set of files that can actually support the answer.

1. **[MAP.md](../MAP.md)** — always. State, blockers, ownership.
2. **[INDEX.md](../INDEX.md)** — pick targets by cost.
3. **Atomic notes** — open only what the task names.
4. **Costly documents** — only when the notes cannot answer. State in your
   reply that you escalated and why.

Escalate on purpose, not by habit. "Why can't we deploy to production?" is
answerable from two notes (~0.5k tokens). Reading `meetings/open-items.md` to
answer it costs **~50k** and produces the same two sentences.

For transcripts and the big trackers, search — never load:

```bash
rg -n "tranche" meetings/*-transcript.it.md    # find the line
rg -n "^\| 75 " meetings/open-items.md          # one tracker row
```

Then read only the surrounding range, and cite `file:line`.

## Writing

**Notes are the source of truth for the volatile layer. The documents in
`meetings/` are views.** The requirement register
[requirements/pienissimo-requirements.yaml](../requirements/pienissimo-requirements.yaml)
is a separate authority and is **not** generated from notes — see the
precedence table in [AGENTS.md](../AGENTS.md).

When new information arrives:

1. Create or update the atomic note(s) in `notes/`. Bump `updated:`.
2. Regenerate the affected sections of the view documents
   (`meetings/open-items.md`, `meetings/DEVELOPMENT-RECAP.md`) from the notes,
   **and their `.it.md` twins in the same session**.
3. If a requirement changed, update the YAML register **and** both prose
   documents. Italian is the text the client signs.
4. Append an entry to [JOURNAL.md](../JOURNAL.md).
5. Run `npm run vault:check`.

Rules that do not bend:

- **Item ids are the tracker's own numbers.** Row `#75` is `OI-75` forever.
  They are cited in `REQUIREMENTS.md`, in the published artifacts and in client
  correspondence. Never renumber, never reuse.
- The filename is the note's H1, in ASCII with spaces — `OI-75 Ticket
  availability rule.md`. Reword a title and you rename the file and fix the
  links; the `id:` stays. No `/ \ : * ? " < > | ( )` or apostrophes. Italian
  domain words are welcome; accents are transliterated (`Perche`, not
  `Perché`).
- One fact per note. If a note needs two `status:` values, it is two notes.
- Never edit a preserved raw transcript or anything in `meetings/results/`.
- Never fabricate owners, dates, decisions, or speaker attribution. Write
  `uncertain:` in frontmatter and say so in the body instead of guessing.
- Later evidence wins, but record the reversal and cite both meeting dates.
- **The org, the repository and the trackers disagree.** When you state what is
  built, say which of the three you checked and when.
- No secrets, credentials, catalogue prices or unnecessary personal data — see
  [docs/publishing.md](../docs/publishing.md).

## Handoff between tools

You may be a different model than the one that wrote the last entry. The
[JOURNAL.md](../JOURNAL.md) entry is the handoff contract. Write it so a cold
agent can resume without re-reading the corpus:

```markdown
## 2026-08-14 — codex

- **Did:** split the 06/08 session's rulings into notes.
- **State:** OI-68/69/74/75 written; the recap still carries the old wording.
- **Next:** regenerate DEVELOPMENT-RECAP §11 from those four notes.
- **Watch:** #75 supersedes the §10 availability rule — do not reinstate it.
```

Keep the ten most recent entries in `JOURNAL.md`. Move older ones to
`notes/sessions/YYYY-QN.md`.

## Why the format is what it is

- **Relative Markdown links, not wikilinks** — so links resolve in Obsidian,
  VS Code, GitHub, and every agent CLI. Obsidian's graph view and backlinks
  work with Markdown links; set `Settings → Files & Links → Use [[Wikilinks]]`
  to **off**.
- **Filenames are the titles** — the graph labels a node with its filename and
  nothing else, so a slug like `OI-75-availability` forces you to open the node
  to learn what it is. Spaces cost one thing only: `%20` in link targets, which
  `vault:check` decodes.
- **Plain YAML frontmatter** — parseable by anything, no plugin required.
- **No Dataview/Bases in agent-read files** — those render only inside
  Obsidian. An agent reads the query source, not the result table. Human
  dashboards using them belong in `notes/dashboards/`.
- **English in `notes/`** — one working surface. The Italian deliverables are
  generated from it, with the standing exception that agreed client wording is
  governed by the Italian.
