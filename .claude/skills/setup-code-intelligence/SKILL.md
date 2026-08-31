---
name: setup-code-intelligence
description: Set up or repair the local Open Codebase Index and Graphify-SFDX environment after cloning or pulling the Pienissimo repository. Use when a developer asks to install, bootstrap, verify, or troubleshoot code intelligence or automatic Salesforce graph refresh. Do not use for an ordinary index refresh when the installed toolchain is already healthy.
---

# Setup Code Intelligence

Bootstrap both local MCP indexes and prove that the Git hooks and Graphify
watcher can keep the Salesforce graph current.

## Workflow

1. Work from the repository root. Explain that Git supplies this skill, the MCP
   configs, and the hooks, but deliberately does not install machine-level
   prerequisites during `git pull`.
2. Run `npm run intelligence:setup:check` first. If it passes, report that the
   environment is already ready and do not reinstall it unless the user asks.
3. If the check reports missing Node.js 20+, Python 3.10+, Ollama, Git, or `sh`,
   stop and give the developer the exact missing prerequisite. Do not choose or
   run an operating-system package manager without the user's authorization.
4. Otherwise run `npm run intelligence:setup`. Use this maintained installer
   instead of reproducing its individual commands. It installs locked Node
   dependencies when needed, activates Husky, installs the pinned Python
   requirements, pulls the Ollama embedding model, builds both indexes, and runs
   the end-to-end refresh verification.
5. Run `npm run intelligence:setup:check` once more if the install did not reach
   its own final health check. Inspect the failing command before changing any
   configuration.
6. On success, tell the developer to restart Codex or Claude Code so the two
   project MCP servers load. Codex must trust the repository; Claude Code may
   request one-time approval for `.mcp.json`.

## Boundaries

- Do not add installation work to a Git hook. Pulls and branch switches must
  stay fast and must not download packages or models.
- On Windows, a running Open Codebase Index server can lock its native module
  when a changed `package-lock.json` requires `npm ci`. Follow the installer's
  instruction to close the agent clients and run the command from a terminal;
  do not terminate unrelated processes.
- Do not edit or delete `force-app/` while setting up the indexes.
- `.codebase-index/index/` and `graphify-out/` are generated and per machine;
  never commit them.
- After setup, `.husky/post-checkout`, `post-merge`, and `post-rewrite` rebuild
  the Graphify snapshot. `scripts/graphify_serve_fresh.py` also rebuilds at MCP
  startup and watches `force-app/` during the session.
- For implementation details or manual recovery commands, read
  [`docs/code-intelligence.md`](../../../docs/code-intelligence.md).
