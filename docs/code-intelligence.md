# Code intelligence

Codex and Claude Code share two local, generated views of the Salesforce DX
repository:

```text
Pienissimo SFDX repo
        |
        +-- Open Codebase Index -- semantic search, definitions, callers, impact
        |
        +-- Graphify-SFDX ------- objects, permissions, flows, SF impact
                                  |
                                  +-- Codex / Claude Code
```

These views accelerate source discovery. They do not replace the project's
sources of truth: requirements remain in
`requirements/pienissimo-requirements.yaml`, volatile facts remain in `notes/`,
and the org must still be inspected before making an org-state claim.

## One-time setup

Prerequisites are Node.js 20+, Python 3.10+, and Ollama. From the repository
root:

```powershell
npm run intelligence:setup
```

The repository-local `setup-code-intelligence` skill runs this command when a
developer asks Codex or Claude Code to set up or repair code intelligence. The
skill, installer, MCP configs and Git-hook definitions all arrive with
`git pull`; machine-level prerequisites and generated indexes deliberately do
not. Start or restart the agent after the pull so it discovers the new skill.
Use `npm run intelligence:setup:check` to inspect a machine without changing
it.

The installer runs `npm ci` when the installed packages do not match
`package-lock.json`, otherwise it reuses them; installs
`requirements-code-intelligence.txt`; pulls `nomic-embed-text`; builds both
indexes; and runs the complete hook/watcher verification. If a system
prerequisite is missing, it stops before installing anything and reports what
the developer needs. On Windows, an active Open Codebase Index process may lock
its native module when a changed lockfile genuinely requires `npm ci`; close
Codex and Claude Code, run the setup command once from a terminal, then reopen
the clients.

Ollama must be running while Open Codebase Index builds or searches the semantic
index. On Windows, start it with `ollama serve` if the desktop service is not
already running.

Codex reads `.codex/config.toml`. Claude Code reads `.mcp.json` and asks for a
one-time approval for project MCP servers. Both launch the same backends and use
the same generated data. Restart the client or open a new session after initial
setup or an MCP configuration change.

## Refresh and inspect

```powershell
npm run intelligence:refresh          # rebuild both views
npm run intelligence:index            # refresh semantic/code graph only
npm run intelligence:index:dry-run    # parse and count without embeddings
npm run intelligence:graph            # rebuild Salesforce graph only
npm run intelligence:status           # Open Codebase Index readiness
npm run intelligence:setup:check      # read-only local environment check
npm run intelligence:view             # render the SF graph as a browsable page
npm run retrieve                      # sf retrieve, then rebuild the graph
npm run intelligence:verify           # prove the refresh mechanism works
```

### Seeing the graph

Both indexes answer in text. `npm run intelligence:view` is the exception: it
renders `graphify-out/graph.json` into **`graphify-out/graph.html`**, a
self-contained page you open in a browser — objects, fields, Apex, LWC,
validation rules and order-of-execution steps as a force-directed map, filterable
by node kind and by relation, searchable, with a detail panel per node listing its
connections and the `file:line` each one was extracted from.

It is a **reading aid, not evidence**: inferred edges are dashed and governor
violations are red precisely so you go and check the cited metadata, per the
routing rules below.

Two properties worth knowing. The page **strips the Apex `source` text** that the
graph carries on every node, keeping the file path instead — so it stays small
and is not a way to forward source code. And it is written into `graphify-out/`,
which is **gitignored**: the page is generated data, like the graph, and is
rebuilt rather than committed. Re-run the command after a graph rebuild; nothing
refreshes it automatically.

Open Codebase Index watches included source files and updates incrementally.
Graphify-SFDX is a snapshot and has to be re-extracted. That is now automated on
every path that can invalidate it:

| Trigger                          | What rebuilds the snapshot                    |
| -------------------------------- | --------------------------------------------- |
| Opening a Codex / Claude session | `scripts/graphify_serve_fresh.py`, at startup |
| Editing `force-app/` mid-session | the same wrapper's watcher, 2 s poll          |
| `sf project retrieve start`      | the same wrapper's watcher                    |
| `git checkout`, branch switch    | `.husky/post-checkout`                        |
| `git merge`, `git pull`          | `.husky/post-merge`                           |
| `git rebase`, commit amend       | `.husky/post-rewrite`                         |
| `npm run retrieve`               | the `postretrieve` script                     |

Everything rebuilds unconditionally rather than trying to detect staleness: the
extract is deterministic - byte-identical output on unchanged input - and takes
about a quarter of a second in-process.

### The session wrapper

Both clients launch Graphify through `scripts/graphify_serve_fresh.py` instead
of `graphify.serve` directly. It rebuilds once at startup, then watches
`force-app/` on a background thread and rebuilds when the tree settles. Since
`graphify.serve` stats `graph.json` on every tool call and reloads it on a
mtime/size change, a rebuild reaches the live session with no restart.

This closes the two cases a git hook cannot see - metadata edited in place, and
`sf project retrieve start` run directly - because both land as writes inside
`force-app/`. The graph only has to be correct while a session is running, and
the startup rebuild covers anything that changed while none was.

Two constraints on anyone editing that wrapper:

- **stdout is the JSON-RPC channel.** Every diagnostic goes to stderr. A stray
  `print()` corrupts the protocol.
- **Child processes must not inherit fd 0.** `graphify.serve` replaces stdin
  with an OS pipe (`_filter_blank_stdin`), and a child that inherits it blocks
  instead of exiting - measured at a 20 s timeout inherited against 0.25 s with
  `stdin=DEVNULL`. `scripts/refresh-sf-graph.sh` detaches stdin for the same
  reason: git feeds `post-rewrite` hooks commit data on stdin.

The refresh degrades rather than breaking. A failed rebuild logs to stderr and
serves the previous graph; a missing Python toolchain makes the git hooks
no-op silently, so contributors who never installed it are unaffected and no git
operation ever fails because of them. The combined refresh is safe to repeat.

The semantic index intentionally includes code and machine-readable metadata,
not the meeting archive or atomic notes. This keeps code search separate from
the repository's human knowledge protocol and avoids indexing preserved
transcripts. The SFDX graph reads `force-app/` as Salesforce metadata, excluding
local `.sf` and `.sfdx` caches so generated standard libraries cannot pollute
impact results.

Generated data lives in `.codebase-index/index/` and `graphify-out/`; both are
ignored by Git. Their committed configuration is `.codebase-index/config.json`.

## Routing questions

Use Open Codebase Index for broad discovery, definitions, callers, dependency
paths, similar implementations, and branch/PR impact. Start with
`codebase_context`, then use `implementation_lookup`, `call_graph`, or
`call_graph_path` when a symbol is known.

Use Graphify-SFDX for Salesforce-specific structure and behavior: object/field
relationships, permission reach, Flow and Apex interactions, order of execution,
Governor Limit findings, and downstream Salesforce impact. Its focused tools
include `sf_impact`, `sf_violations`, `sf_cpq_chain`, and `sf_ooe`.

Graph confidence and violation output are evidence leads, not findings by
themselves. Inspect the cited metadata before reporting or changing code. In
particular, a static loop heuristic can confuse an Apex SOQL-for loop with a
query executed inside an ordinary record loop.

For exact exhaustive text, continue to use `rg`. For requirements, decisions,
open items, and org reality, follow `MAP.md`, `INDEX.md`, and the repository read
protocol before consulting generated graphs.
