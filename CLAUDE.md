# CLAUDE.md

The canonical, tool-neutral instructions for this repository live in
`AGENTS.md`. They are imported below — read them as if written here.

@AGENTS.md

## Claude-specific notes

- Project skills live in `.claude/skills/` (mirrored in `.agents/skills/` for
  other agent runtimes): `drill-meeting`, `drill-me`, `org-status-check`,
  `requirements-check`, `requirement-trace`, `start-sf-projects`.
- Claude's own persistent memory directory is **not** the project memory. It
  holds only pointers into this repository, because Codex and other tools
  cannot see it. Durable project facts belong in [notes/](notes/).
- Prefer `Grep`/`Glob` over `Bash` for search, and never `Read` a file listed
  under "Never read these whole" in `AGENTS.md` — `meetings/open-items.md`
  alone is ~50k tokens.
- When the answer is "what is actually built", check `force-app/` **and** the
  org. They disagree — see [MAP.md](MAP.md).
