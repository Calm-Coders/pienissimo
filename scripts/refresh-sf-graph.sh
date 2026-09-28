#!/bin/sh
# Rebuild the Graphify-SFDX snapshot so graphify-out/graph.json never lags
# force-app/.
#
# The MCP server stats graph.json on every tool call and reloads it when the
# mtime or size changes, so a rebuild reaches a running agent session without
# restarting it. The extract is deterministic and takes well under a second,
# which is why this rebuilds unconditionally instead of trying to detect
# staleness.
#
# The code-intelligence toolchain is an optional, per-machine install
# (requirements-code-intelligence.txt). This script therefore no-ops silently
# when it is absent, and never fails the git operation that invoked it.

[ -d force-app ] || exit 0

PY=""
for candidate in python python3; do
  if command -v "$candidate" >/dev/null 2>&1 &&
    "$candidate" -c "import graphify" >/dev/null 2>&1 </dev/null; then
    PY="$candidate"
    break
  fi
done
[ -n "$PY" ] || exit 0

# git feeds post-rewrite hooks rewritten-commit data on stdin, and a child
# that inherits it can block instead of exiting - so detach stdin.
if ! "$PY" -X utf8 -m graphify.salesforce extract force-app \
  --output-dir graphify-out >/dev/null 2>&1 </dev/null; then
  echo "graphify: snapshot rebuild failed - run 'npm run intelligence:graph'" >&2
fi

exit 0
