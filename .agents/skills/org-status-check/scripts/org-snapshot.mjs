#!/usr/bin/env node

import { relative } from "node:path";
import {
  METADATA_TYPES,
  cacheOutputPath,
  inferObjects,
  metadataKey,
  parseArgs,
  readJson,
  runSfJson,
  writeJson
} from "./lib.mjs";

const args = parseArgs(process.argv.slice(2));
if (args.help) {
  console.log(
    "Usage: org-snapshot.mjs --target-org <alias> [--repo-snapshot .org-status-cache/repository.json] [--verification requirements/org-verification.json] [--out .org-status-cache/org.json]"
  );
  process.exit(0);
}
if (!args["target-org"]) throw new Error("--target-org is required");
if (!/^[A-Za-z0-9._@+-]+$/.test(args["target-org"])) {
  throw new Error("--target-org must be a Salesforce alias or username");
}

const projectRoot = process.cwd();
const output = cacheOutputPath(projectRoot, args.out, "org.json");
const repository = readJson(
  args["repo-snapshot"] || ".org-status-cache/repository.json"
);
const verification = readJson(
  args.verification || "requirements/org-verification.json"
);
const targetOrg = args["target-org"];
const observedAt = new Date().toISOString();

const display = runSfJson(["org", "display", "--target-org", targetOrg], {
  projectRoot
});
const identity = {
  alias: targetOrg,
  id: display.result.id || display.result.orgId || null,
  connected_status:
    display.result.connectedStatus || display.result.status || null
};

const components = new Map();
const unavailableTypes = [];
for (const type of Object.keys(METADATA_TYPES)) {
  const response = runSfJson(
    [
      "org",
      "list",
      "metadata",
      "--metadata-type",
      type,
      "--target-org",
      targetOrg
    ],
    { projectRoot, allowFailure: true }
  );
  if (!response.ok) {
    unavailableTypes.push({ type, error: response.error });
    continue;
  }
  const records = Array.isArray(response.result) ? response.result : [];
  for (const record of records) {
    const key = metadataKey(type, record.fullName);
    if (!key) continue;
    components.set(key, {
      key,
      kind: METADATA_TYPES[type],
      name: record.fullName,
      evidence: `Metadata API list ${type}`,
      last_modified_date: record.lastModifiedDate || null
    });
  }
}

const objects = inferObjects(repository, verification);
const unavailableFieldObjects = [];
const checkedFieldObjects = [];
for (const object of objects) {
  const query =
    "SELECT EntityDefinition.QualifiedApiName, QualifiedApiName, DataType, IsNillable, IsUnique, IsExternalId " +
    `FROM FieldDefinition WHERE EntityDefinition.QualifiedApiName = '${object}' ORDER BY QualifiedApiName`;
  const response = runSfJson(
    [
      "data",
      "query",
      "--use-tooling-api",
      "--target-org",
      targetOrg,
      "--query",
      query
    ],
    { projectRoot, allowFailure: true }
  );
  if (!response.ok) {
    unavailableFieldObjects.push({ object, error: response.error });
    continue;
  }
  checkedFieldObjects.push(object);
  const records = response.result.records || [];
  if (records.length === 0) continue;
  components.set(`object:${object}`, {
    key: `object:${object}`,
    kind: "object",
    name: object,
    evidence: "Tooling FieldDefinition parent"
  });
  for (const record of records) {
    const apiName = record.QualifiedApiName;
    if (!apiName) continue;
    const key = `field:${object}.${apiName}`;
    components.set(key, {
      key,
      kind: "field",
      name: `${object}.${apiName}`,
      object,
      evidence: "Tooling FieldDefinition",
      facts: {
        type: record.DataType || null,
        nillable: record.IsNillable ?? null,
        unique: record.IsUnique ?? null,
        external_id: record.IsExternalId ?? null
      }
    });
  }
}

const customFields = [...components.values()]
  .filter(
    (component) =>
      component.kind === "field" &&
      component.name.endsWith("__c") &&
      /^[A-Za-z][A-Za-z0-9_]*\.[A-Za-z][A-Za-z0-9_]*$/.test(component.name)
  )
  .map((component) => component.name)
  .sort();
const fieldPermissions = {};
const unavailableFieldPermissions = [];
for (let index = 0; index < customFields.length; index += 40) {
  const batch = customFields.slice(index, index + 40);
  const quoted = batch.map((field) => `'${field}'`).join(",");
  const query =
    "SELECT Field, ParentId, Parent.Name, Parent.Profile.Name, PermissionsRead, PermissionsEdit " +
    `FROM FieldPermissions WHERE Field IN (${quoted})`;
  const response = runSfJson(
    [
      "data",
      "query",
      "--use-tooling-api",
      "--target-org",
      targetOrg,
      "--query",
      query
    ],
    { projectRoot, allowFailure: true }
  );
  if (!response.ok) {
    unavailableFieldPermissions.push({ fields: batch, error: response.error });
    continue;
  }
  for (const record of response.result.records || []) {
    const key = `field:${record.Field}`;
    const grant = {
      parent_id: record.ParentId || null,
      permission_set: record.Parent?.Name || null,
      profile_name: record.Parent?.Profile?.Name || null,
      readable: Boolean(record.PermissionsRead),
      editable: Boolean(record.PermissionsEdit)
    };
    (fieldPermissions[key] ||= []).push(grant);
  }
}
for (const grants of Object.values(fieldPermissions)) {
  grants.sort((a, b) =>
    `${a.profile_name || ""}:${a.permission_set || ""}`.localeCompare(
      `${b.profile_name || ""}:${b.permission_set || ""}`
    )
  );
}

const objectPermissions = {};
const unavailableObjectPermissions = [];
for (let index = 0; index < objects.length; index += 40) {
  const batch = objects.slice(index, index + 40);
  const quoted = batch.map((object) => `'${object}'`).join(",");
  const query =
    "SELECT SobjectType, ParentId, Parent.Name, Parent.Profile.Name, PermissionsRead, PermissionsCreate, PermissionsEdit, PermissionsDelete " +
    `FROM ObjectPermissions WHERE SobjectType IN (${quoted})`;
  const response = runSfJson(
    [
      "data",
      "query",
      "--use-tooling-api",
      "--target-org",
      targetOrg,
      "--query",
      query
    ],
    { projectRoot, allowFailure: true }
  );
  if (!response.ok) {
    unavailableObjectPermissions.push({
      objects: batch,
      error: response.error
    });
    continue;
  }
  for (const record of response.result.records || []) {
    const key = `object:${record.SobjectType}`;
    const grant = {
      parent_id: record.ParentId || null,
      permission_set: record.Parent?.Name || null,
      profile_name: record.Parent?.Profile?.Name || null,
      readable: Boolean(record.PermissionsRead),
      creatable: Boolean(record.PermissionsCreate),
      editable: Boolean(record.PermissionsEdit),
      deletable: Boolean(record.PermissionsDelete)
    };
    (objectPermissions[key] ||= []).push(grant);
  }
}
for (const grants of Object.values(objectPermissions)) {
  grants.sort((a, b) =>
    `${a.profile_name || ""}:${a.permission_set || ""}`.localeCompare(
      `${b.profile_name || ""}:${b.permission_set || ""}`
    )
  );
}

const coverageResponse = runSfJson(
  [
    "data",
    "query",
    "--use-tooling-api",
    "--target-org",
    targetOrg,
    "--query",
    "SELECT ApexClassOrTrigger.Name, NumLinesCovered, NumLinesUncovered FROM ApexCodeCoverageAggregate"
  ],
  { projectRoot, allowFailure: true }
);
let coverage = null;
if (coverageResponse.ok) {
  let covered = 0;
  let uncovered = 0;
  const entries = [];
  for (const record of coverageResponse.result.records || []) {
    covered += Number(record.NumLinesCovered || 0);
    uncovered += Number(record.NumLinesUncovered || 0);
    entries.push({
      name: record.ApexClassOrTrigger?.Name || null,
      covered: Number(record.NumLinesCovered || 0),
      uncovered: Number(record.NumLinesUncovered || 0)
    });
  }
  entries.sort((a, b) => (a.name || "").localeCompare(b.name || ""));
  coverage = {
    covered,
    uncovered,
    percent:
      covered + uncovered === 0
        ? 0
        : Number(((covered / (covered + uncovered)) * 100).toFixed(2)),
    entries
  };
}

const snapshot = {
  schema_version: 1,
  snapshot_kind: "org",
  observed_at: observedAt,
  org: identity,
  repository_commit_basis: repository.repo_commit,
  methods: [
    "Metadata API list",
    "Tooling FieldDefinition",
    "Tooling FieldPermissions",
    "Tooling ObjectPermissions",
    "Tooling ApexCodeCoverageAggregate"
  ],
  unavailable_metadata_types: unavailableTypes,
  unavailable_component_kinds: [
    ...new Set(
      unavailableTypes
        .map((entry) => METADATA_TYPES[entry.type])
        .filter(Boolean)
    )
  ].sort(),
  unavailable_field_objects: unavailableFieldObjects,
  field_definition_objects_checked: checkedFieldObjects,
  unavailable_field_permissions: unavailableFieldPermissions,
  unavailable_object_permissions: unavailableObjectPermissions,
  component_count: components.size,
  components: [...components.values()].sort((a, b) =>
    a.key.localeCompare(b.key)
  ),
  field_permissions: fieldPermissions,
  object_permissions: objectPermissions,
  coverage,
  coverage_unavailable: coverageResponse.ok ? null : coverageResponse.error
};
await writeJson(output, snapshot);

console.log(
  JSON.stringify({
    output: relative(projectRoot, output).replaceAll("\\", "/"),
    org: identity,
    components: snapshot.component_count,
    unavailable_metadata_types: unavailableTypes.map((entry) => entry.type),
    unavailable_field_objects: unavailableFieldObjects.map(
      (entry) => entry.object
    ),
    coverage_percent: coverage?.percent ?? null
  })
);
