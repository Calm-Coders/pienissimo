#!/usr/bin/env node

import { spawnSync } from "node:child_process";
import { existsSync, readFileSync } from "node:fs";
import { dirname, resolve } from "node:path";

const root = process.cwd();
const checkOnly = process.argv.includes("--check");
const help = process.argv.includes("--help") || process.argv.includes("-h");
const npmCli = process.env.npm_execpath;

if (help) {
  console.log(`Usage:
  npm run intelligence:setup         Install, build, and verify both indexes
  npm run intelligence:setup:check   Inspect the local setup without changing it`);
  process.exit(0);
}

const requiredProjectFiles = [
  "package.json",
  "requirements-code-intelligence.txt",
  ".codebase-index/config.json",
  "scripts/graphify_serve_fresh.py"
];

for (const file of requiredProjectFiles) {
  if (!existsSync(resolve(root, file))) {
    fail(
      `Run this command from the Pienissimo repository root; missing ${file}.`
    );
  }
}

const nodeMajor = Number(process.versions.node.split(".")[0]);
if (!Number.isInteger(nodeMajor) || nodeMajor < 20) {
  fail(`Node.js 20+ is required; found ${process.versions.node}.`);
}

if (!npmCli) {
  fail("Run this installer through npm: npm run intelligence:setup");
}

const prerequisites = [
  {
    name: "Git",
    command: "git",
    args: ["--version"],
    install:
      "Install Git for Windows (or Git on macOS/Linux) and reopen the terminal."
  },
  {
    name: "Python 3.10+",
    command: "python",
    args: [
      "-c",
      "import sys; raise SystemExit(0 if sys.version_info >= (3, 10) else 1)"
    ],
    install: "Install Python 3.10+ with the `python` command on PATH."
  },
  {
    name: "Ollama",
    command: "ollama",
    args: ["--version"],
    install: "Install Ollama, start its service, and reopen the terminal."
  }
];

let prerequisiteFailures = 0;
console.log("Checking prerequisites...");
console.log(`  OK  Node.js ${process.versions.node}`);
for (const prerequisite of prerequisites) {
  const result = capture(prerequisite.command, prerequisite.args);
  if (result.status === 0) {
    const version = firstLine(result.stdout || result.stderr);
    console.log(`  OK  ${prerequisite.name}${version ? ` - ${version}` : ""}`);
  } else {
    prerequisiteFailures += 1;
    console.error(`  MISSING  ${prerequisite.name}. ${prerequisite.install}`);
  }
}

const shell = findShell();
if (shell) {
  console.log(`  OK  POSIX shell - ${shell}`);
} else {
  prerequisiteFailures += 1;
  console.error(
    "  MISSING  POSIX shell. Install Git for Windows (Git Bash supplies `sh`) or a POSIX shell."
  );
}

if (prerequisiteFailures > 0) {
  fail(
    `${prerequisiteFailures} prerequisite${prerequisiteFailures === 1 ? " is" : "s are"} missing. Install them, then rerun this command.`
  );
}

if (checkOnly) {
  process.exit(runHealthCheck() ? 0 : 1);
}

if (nodeDependenciesMatchLock()) {
  step(
    "Node dependencies already match package-lock.json; activate Husky hooks",
    () => npm("run", "prepare")
  );
} else {
  step("Install locked Node dependencies and activate Husky hooks", () =>
    run(
      process.execPath,
      [npmCli, "ci"],
      process.platform === "win32"
        ? "If npm reports EPERM for an Open Codebase Index native file, close Codex and Claude Code, run this command once from a terminal, then reopen the clients."
        : undefined
    )
  );
}
step("Install the pinned Graphify-SFDX Python toolchain", () =>
  run("python", [
    "-m",
    "pip",
    "install",
    "--user",
    "-r",
    "requirements-code-intelligence.txt"
  ])
);
step("Install or update the nomic-embed-text Ollama model", () =>
  run("ollama", ["pull", "nomic-embed-text"])
);
step("Build the Salesforce graph and semantic code index", () =>
  npm("run", "intelligence:refresh")
);
step("Verify hooks, the MCP wrapper, and live graph refresh", () =>
  npm("run", "intelligence:verify")
);

if (!runHealthCheck()) {
  fail("Installation finished, but the final health check failed.");
}

console.log(
  "\nCode intelligence is ready. Restart Codex or Claude Code before using the MCP tools."
);

function runHealthCheck() {
  console.log("\nChecking the installed environment...");
  let healthy = true;

  healthy =
    report("Locked Node dependency tree", nodeDependenciesMatchLock()) &&
    healthy;
  healthy =
    report(
      "Open Codebase Index package",
      existsSync(resolve(root, "node_modules/open-codebase-index/package.json"))
    ) && healthy;
  healthy =
    checkCommand("Graphify-SFDX and MCP Python packages", "python", [
      "-c",
      "import graphify; import mcp"
    ]) && healthy;

  const models = capture("ollama", ["list"]);
  const hasModel =
    models.status === 0 && /^nomic-embed-text(?::\S+)?\s/im.test(models.stdout);
  healthy = report("Ollama nomic-embed-text model", hasModel) && healthy;

  const hooksPath = capture("git", [
    "config",
    "--local",
    "--get",
    "core.hooksPath"
  ]);
  const hooksInstalled =
    hooksPath.status === 0 &&
    hooksPath.stdout.trim().replaceAll("\\", "/") === ".husky/_" &&
    existsSync(resolve(root, ".husky/_/post-merge"));
  healthy = report("Husky post-merge hooks", hooksInstalled) && healthy;

  healthy =
    report(
      "Graphify snapshot",
      existsSync(resolve(root, "graphify-out/graph.json"))
    ) && healthy;
  healthy =
    report(
      "Open Codebase Index data",
      existsSync(resolve(root, ".codebase-index/index"))
    ) && healthy;

  if (healthy) {
    const status = capture(process.execPath, [
      npmCli,
      "run",
      "intelligence:status"
    ]);
    healthy =
      report("Open Codebase Index readiness", status.status === 0) && healthy;
    if (status.status !== 0 && status.stderr.trim()) {
      console.error(indent(status.stderr.trim()));
    }
  }

  console.log(
    healthy
      ? "Environment check passed."
      : "Environment check failed. Run npm run intelligence:setup to repair it."
  );
  return healthy;
}

function npm(...args) {
  run(process.execPath, [npmCli, ...args]);
}

function nodeDependenciesMatchLock() {
  const projectLock = resolve(root, "package-lock.json");
  const installedLock = resolve(root, "node_modules/.package-lock.json");
  if (!existsSync(projectLock) || !existsSync(installedLock)) {
    return false;
  }

  try {
    const wanted = JSON.parse(readFileSync(projectLock, "utf8")).packages ?? {};
    const installed =
      JSON.parse(readFileSync(installedLock, "utf8")).packages ?? {};
    for (const [path, expected] of Object.entries(wanted)) {
      if (!path.startsWith("node_modules/")) {
        continue;
      }
      const actual = installed[path];
      if (!actual && expected.optional) {
        continue;
      }
      if (
        !actual ||
        !existsSync(resolve(root, path)) ||
        actual.version !== expected.version ||
        actual.integrity !== expected.integrity ||
        actual.resolved !== expected.resolved
      ) {
        return false;
      }
    }
    return true;
  } catch {
    return false;
  }
}

function step(label, action) {
  console.log(`\n==> ${label}`);
  action();
}

function checkCommand(label, command, args) {
  return report(label, capture(command, args).status === 0);
}

function report(label, ok) {
  console.log(`  ${ok ? "OK" : "MISSING"}  ${label}`);
  return ok;
}

function capture(command, args) {
  const result = spawnSync(command, args, {
    cwd: root,
    encoding: "utf8",
    windowsHide: true
  });
  return {
    status: result.error ? 1 : (result.status ?? 1),
    stdout: result.stdout ?? "",
    stderr: result.stderr ?? result.error?.message ?? ""
  };
}

function findShell() {
  if (capture("sh", ["--version"]).status === 0) {
    return "sh";
  }
  if (process.platform !== "win32") {
    return undefined;
  }

  const candidates = [];
  const gitPaths = capture("where.exe", ["git"]);
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
    (candidate) =>
      existsSync(candidate) && capture(candidate, ["--version"]).status === 0
  );
}

function run(command, args, failureHint) {
  const result = spawnSync(command, args, {
    cwd: root,
    stdio: "inherit",
    windowsHide: true
  });
  if (result.error || result.status !== 0) {
    const reason = result.error
      ? `Could not run ${command}: ${result.error.message}`
      : `${command} exited with status ${result.status}.`;
    fail(failureHint ? `${reason} ${failureHint}` : reason);
  }
}

function firstLine(value) {
  return value.trim().split(/\r?\n/, 1)[0] ?? "";
}

function indent(value) {
  return value
    .split(/\r?\n/)
    .map((line) => `    ${line}`)
    .join("\n");
}

function fail(message) {
  console.error(`\nERROR: ${message}`);
  process.exit(1);
}
