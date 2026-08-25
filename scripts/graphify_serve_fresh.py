#!/usr/bin/env python
"""Serve the Graphify-SFDX graph, keeping it fresh for the whole session.

A drop-in wrapper around ``python -m graphify.serve``. It adds two things:

1. A rebuild at startup, so a session never opens on a snapshot that went
   stale while no agent was running.
2. A daemon thread watching ``force-app/``, which rebuilds on change. This
   covers the two cases the git hooks cannot see - metadata edited in place,
   and ``sf project retrieve start`` invoked directly rather than through
   ``npm run retrieve``.

``graphify.serve`` stats ``graph.json`` on every tool call and reloads it on a
mtime/size change, so a rebuild reaches the live session without a restart.
That is why this wrapper only has to rewrite the file; it never talks to the
server.

This is an MCP stdio server: **stdout is the JSON-RPC channel**. Every
diagnostic here goes to stderr. Nothing in the refresh path may raise into the
serve loop - a broken watcher degrades to a plain server, it never takes one
down.
"""

from __future__ import annotations

import hashlib
import os
import runpy
import subprocess
import sys
import threading
import time
from pathlib import Path

POLL_SECONDS = 2.0
PROJECT_ROOT = Path(__file__).resolve().parent.parent
SOURCE_DIR = PROJECT_ROOT / "force-app"
OUTPUT_DIR = PROJECT_ROOT / "graphify-out"


def log(message: str) -> None:
    print(f"graphify-fresh: {message}", file=sys.stderr, flush=True)


def fingerprint() -> str:
    """Cheap content-independent stamp of force-app/: path, size, mtime."""
    digest = hashlib.sha256()
    if not SOURCE_DIR.is_dir():
        return ""
    for root, dirnames, filenames in os.walk(SOURCE_DIR):
        dirnames.sort()
        for name in sorted(filenames):
            path = Path(root) / name
            try:
                stat = path.stat()
            except OSError:
                continue
            digest.update(str(path.relative_to(SOURCE_DIR)).encode("utf-8", "replace"))
            digest.update(f"{stat.st_size}:{stat.st_mtime_ns}".encode("ascii"))
    return digest.hexdigest()


def rebuild() -> bool:
    """Re-extract the graph. Returns True on success. Never raises."""
    try:
        result = subprocess.run(
            [
                sys.executable,
                "-X",
                "utf8",
                "-m",
                "graphify.salesforce",
                "extract",
                str(SOURCE_DIR),
                "--output-dir",
                str(OUTPUT_DIR),
            ],
            cwd=str(PROJECT_ROOT),
            # fd 0 must NOT be inherited. graphify.serve replaces stdin with an
            # OS pipe (_filter_blank_stdin), and a child that inherits it hangs
            # instead of exiting - measured: 20s timeout inherited, 0.25s with
            # DEVNULL. It would also let the child steal JSON-RPC bytes.
            stdin=subprocess.DEVNULL,
            stdout=subprocess.DEVNULL,
            stderr=subprocess.PIPE,
            timeout=120,
        )
    except Exception as exc:  # noqa: BLE001 - must never reach the serve loop
        log(f"rebuild failed to launch ({exc}); serving the existing graph")
        return False
    if result.returncode != 0:
        detail = (result.stderr or b"").decode("utf-8", "replace").strip()
        log(f"rebuild exited {result.returncode}; serving the existing graph. {detail}")
        return False
    return True


def watch(initial: str) -> None:
    """Rebuild whenever force-app/ settles on a new state."""
    last_built = initial
    pending = None
    while True:
        time.sleep(POLL_SECONDS)
        try:
            current = fingerprint()
        except Exception as exc:  # noqa: BLE001
            log(f"watch poll failed ({exc}); continuing")
            continue
        if current == last_built:
            pending = None
            continue
        # Wait for one quiet cycle so a multi-file retrieve rebuilds once.
        if current != pending:
            pending = current
            continue
        if rebuild():
            log("force-app changed; graph rebuilt")
        last_built = current
        pending = None


def main() -> None:
    try:
        if rebuild():
            log("graph rebuilt at startup")
        stamp = fingerprint()
        threading.Thread(target=watch, args=(stamp,), daemon=True).start()
        log(f"watching {SOURCE_DIR} every {POLL_SECONDS:g}s")
    except Exception as exc:  # noqa: BLE001
        log(f"refresh disabled ({exc}); serving without it")

    graph_path = sys.argv[1] if len(sys.argv) > 1 else str(OUTPUT_DIR / "graph.json")
    sys.argv = ["graphify.serve", graph_path]
    runpy.run_module("graphify.serve", run_name="__main__")


if __name__ == "__main__":
    main()
