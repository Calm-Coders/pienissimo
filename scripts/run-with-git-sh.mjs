#!/usr/bin/env node

import { spawnSync } from "node:child_process";
import { existsSync } from "node:fs";
import { dirname, resolve } from "node:path";

const [script, ...args] = process.argv.slice(2);
if (!script) {
  console.error("Usage: node scripts/run-with-git-sh.mjs <script> [args...]");
  process.exit(1);
}

const shell = findShell();
if (!shell) {
  console.error(
    "A POSIX shell is required. Install Git for Windows (which includes Git Bash) or add `sh` to PATH."
  );
  process.exit(1);
}

const result = spawnSync(shell, [script, ...args], {
  cwd: process.cwd(),
  stdio: "inherit",
  windowsHide: true
});

if (result.error) {
  console.error(`Could not start ${shell}: ${result.error.message}`);
  process.exit(1);
}
process.exit(result.status ?? 1);

function findShell() {
  if (works("sh")) {
    return "sh";
  }
  if (process.platform !== "win32") {
    return undefined;
  }

  const candidates = [];
  const gitPaths = spawnSync("where.exe", ["git"], {
    encoding: "utf8",
    windowsHide: true
  });
  if (gitPaths.status === 0) {
    for (const gitPath of gitPaths.stdout.trim().split(/\r?\n/)) {
      if (gitPath) {
        candidates.push(resolve(dirname(gitPath), "..", "bin", "sh.exe"));
        candidates.push(
          resolve(dirname(gitPath), "..", "usr", "bin", "sh.exe")
        );
      }
    }
  }

  for (const base of [
    process.env.ProgramFiles,
    process.env["ProgramFiles(x86)"]
  ]) {
    if (base) {
      candidates.push(resolve(base, "Git", "bin", "sh.exe"));
    }
  }
  if (process.env.LOCALAPPDATA) {
    candidates.push(
      resolve(process.env.LOCALAPPDATA, "Programs", "Git", "bin", "sh.exe")
    );
  }

  return candidates.find(
    (candidate) => existsSync(candidate) && works(candidate)
  );
}

function works(command) {
  const result = spawnSync(command, ["--version"], {
    encoding: "utf8",
    windowsHide: true
  });
  return !result.error && result.status === 0;
}
