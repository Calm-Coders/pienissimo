#!/usr/bin/env node

import { readFileSync } from "node:fs";
import {
  collectRequirementIds,
  collectRegistryIds,
  compareSkillMirrors,
  parseArgs,
  readJson,
  unknownBuildStateRefs,
  validateVerification
} from "./lib.mjs";

const args = parseArgs(process.argv.slice(2));
if (args.help) {
  console.log(
    "Usage: validate.mjs [--verification requirements/org-verification.json] [--registry requirements/pienissimo-requirements.yaml] [--strict-build-state] [--skip-mirrors]"
  );
  process.exit(0);
}

const projectRoot = process.cwd();
const registryPath =
  args.registry || "requirements/pienissimo-requirements.yaml";
const verificationPath =
  args.verification || "requirements/org-verification.json";
const yaml = readFileSync(registryPath, "utf8");
const verification = readJson(verificationPath);
const registryIds = collectRegistryIds(yaml);
const requirementIds = collectRequirementIds(yaml);
const result = validateVerification(verification, requirementIds);
const unknownRefs = unknownBuildStateRefs(yaml, registryIds);

for (const warning of result.warnings) console.warn(`warning: ${warning}`);
if (unknownRefs.length) {
  const message = `build_state contains unknown requirement refs: ${unknownRefs.join(", ")}`;
  if (args["strict-build-state"]) result.errors.push(message);
  else console.warn(`warning: ${message}`);
}

if (!args["skip-mirrors"]) {
  const mirrors = compareSkillMirrors(projectRoot);
  if (mirrors.checked && mirrors.differences.length) {
    result.errors.push(
      ...mirrors.differences.map((difference) => `skill mirror: ${difference}`)
    );
  }
}

if (result.errors.length) {
  for (const error of result.errors) console.error(`error: ${error}`);
  process.exit(1);
}

console.log(
  JSON.stringify({
    registry_ids: registryIds.size,
    requirement_ids: requirementIds.size,
    assertions: verification.assertions.length,
    unknown_build_state_refs: unknownRefs,
    mirrors_checked: !args["skip-mirrors"]
  })
);
