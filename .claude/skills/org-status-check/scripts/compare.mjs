#!/usr/bin/env node

import { relative } from "node:path";
import {
  cacheOutputPath,
  compareSnapshots,
  comparisonMarkdown,
  parseArgs,
  readJson,
  writeJson
} from "./lib.mjs";
import { mkdir, writeFile } from "node:fs/promises";
import { dirname } from "node:path";

const args = parseArgs(process.argv.slice(2));
if (args.help) {
  console.log(
    "Usage: compare.mjs [--repo .org-status-cache/repository.json] [--org .org-status-cache/org.json] [--verification requirements/org-verification.json] [--out .org-status-cache/comparison.json] [--markdown .org-status-cache/comparison.md]"
  );
  process.exit(0);
}

const projectRoot = process.cwd();
const repository = readJson(args.repo || ".org-status-cache/repository.json");
const org = readJson(args.org || ".org-status-cache/org.json");
const verification = readJson(
  args.verification || "requirements/org-verification.json"
);
const output = cacheOutputPath(projectRoot, args.out, "comparison.json");
const markdownOutput = cacheOutputPath(
  projectRoot,
  args.markdown,
  "comparison.md"
);
const comparison = compareSnapshots(repository, org, verification);

await writeJson(output, comparison);
await mkdir(dirname(markdownOutput), { recursive: true });
await writeFile(markdownOutput, `${comparisonMarkdown(comparison)}\n`, "utf8");

console.log(
  JSON.stringify({
    output: relative(projectRoot, output).replaceAll("\\", "/"),
    markdown: relative(projectRoot, markdownOutput).replaceAll("\\", "/"),
    assertions: comparison.assertion_count,
    counts: comparison.counts
  })
);
