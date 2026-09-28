#!/usr/bin/env node

import { relative, resolve } from "node:path";
import {
  cacheOutputPath,
  parseArgs,
  snapshotRepository,
  writeJson
} from "./lib.mjs";

const args = parseArgs(process.argv.slice(2));
if (args.help) {
  console.log(
    "Usage: repo-snapshot.mjs [--root force-app/main/default] [--out .org-status-cache/repository.json]"
  );
  process.exit(0);
}

const projectRoot = process.cwd();
const sourceRoot = args.root || "force-app/main/default";
const output = cacheOutputPath(projectRoot, args.out, "repository.json");
const snapshot = await snapshotRepository({ projectRoot, sourceRoot });
await writeJson(output, snapshot);

console.log(
  JSON.stringify({
    output: relative(projectRoot, output).replaceAll("\\", "/"),
    repo_commit: snapshot.repo_commit,
    components: snapshot.component_count
  })
);
