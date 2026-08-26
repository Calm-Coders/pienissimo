#!/bin/sh
# Verify the Graphify-SFDX refresh mechanism end to end.
#
# Non-destructive: it only rewinds mtimes and regenerates graphify-out/, which
# is generated and gitignored. It never touches tracked file content. Takes
# roughly 20 seconds, most of it waiting on the watcher.
#
# Run it with: npm run intelligence:verify

GRAPH=graphify-out/graph.json
TMP="${TMPDIR:-/tmp}/graph-verify.$$"
mkdir -p "$TMP"
pass=0
fail=0

ok() {
  echo "  PASS  $1"
  pass=$((pass + 1))
}
bad() {
  echo "  FAIL  $1"
  fail=$((fail + 1))
}
fresh() { # mtime within the last two minutes
  [ -f "$GRAPH" ] || return 1
  [ $(($(date +%s) - $(stat -c %Y "$GRAPH"))) -lt 120 ]
}

echo
echo "1. git hooks rebuild the snapshot"
touch -t 202001010000 "$GRAPH"
git checkout "$(git rev-parse --abbrev-ref HEAD)" >/dev/null 2>&1
if fresh; then ok "post-checkout rebuilt graph.json"; else bad "graph.json was not rebuilt"; fi

echo
echo "2. hooks degrade when the Python toolchain is absent"
# Resolve sh by absolute path first: with PATH emptied, the interpreter
# itself would not be findable either.
SH=$(command -v sh)
out=$(PATH=/nonexistent "$SH" scripts/refresh-sf-graph.sh 2>&1)
rc=$?
if [ $rc -eq 0 ] && [ -z "$out" ]; then
  ok "silent no-op, exit 0 - a teammate without graphify is unaffected"
else
  bad "expected silent exit 0, got rc=$rc output='$out'"
fi

echo
echo "3. wrapper rebuilds at startup and speaks MCP"
touch -t 202001010000 "$GRAPH"
req='{"jsonrpc":"2.0","id":1,"method":"initialize","params":{"protocolVersion":"2024-11-05","capabilities":{},"clientInfo":{"name":"verify","version":"1"}}}'
printf '%s\n' "$req" |
  python -X utf8 scripts/graphify_serve_fresh.py "$GRAPH" >"$TMP/hs.out" 2>"$TMP/hs.err"
if grep -q '"serverInfo"' "$TMP/hs.out"; then ok "MCP handshake answered"; else bad "no handshake on stdout"; fi
if fresh; then ok "graph rebuilt at session start"; else bad "no startup rebuild"; fi
if grep -q "graph rebuilt at startup" "$TMP/hs.err"; then ok "diagnostics on stderr"; else bad "startup log missing"; fi

echo
echo "4. watcher rebuilds while a session is running"
target=$(find force-app -name '*.cls' | head -1)
if [ -z "$target" ]; then
  bad "no Apex class found to touch"
else
  sleep 25 | python -X utf8 scripts/graphify_serve_fresh.py "$GRAPH" >"$TMP/w.out" 2>"$TMP/w.err" &
  srv=$!
  sleep 5
  before=$(stat -c %Y "$GRAPH")
  touch "$target"
  sleep 9
  after=$(stat -c %Y "$GRAPH")
  kill "$srv" 2>/dev/null
  if [ "$after" -gt "$before" ]; then
    ok "edit to $target triggered a rebuild"
  else
    bad "watcher did not rebuild after touching $target"
  fi
  if [ ! -s "$TMP/w.out" ]; then
    ok "stdout stayed empty - JSON-RPC channel uncorrupted"
  else
    bad "wrapper wrote $(wc -c <"$TMP/w.out") bytes to stdout"
  fi
fi

echo
echo "5. the served graph is intact"
nodes=$(python -X utf8 -c "import json;print(len(json.load(open('$GRAPH',encoding='utf-8'))['nodes']))" 2>/dev/null)
if [ -n "$nodes" ] && [ "$nodes" -gt 0 ]; then ok "graph.json parses, $nodes nodes"; else bad "graph.json is unreadable"; fi

rm -rf "$TMP"
echo
echo "-----------------------------------------"
echo "  $pass passed, $fail failed"
echo "-----------------------------------------"
echo
[ $fail -eq 0 ] || exit 1
