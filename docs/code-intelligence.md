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
npm ci
python -m pip install --user -r requirements-code-intelligence.txt
ollama pull nomic-embed-text
npm run intelligence:refresh
```

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
npm run retrieve                      # sf retrieve, then rebuild the graph
npm run intelligence:verify           # prove the refresh mechanism works
```

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
