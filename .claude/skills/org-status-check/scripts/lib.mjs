import { createHash } from "node:crypto";
import { spawnSync } from "node:child_process";
import { mkdir, readFile, readdir, writeFile } from "node:fs/promises";
import { existsSync, readFileSync, readdirSync } from "node:fs";
import { dirname, relative, resolve, sep } from "node:path";

export const CACHE_DIR = ".org-status-cache";

export const METADATA_TYPES = Object.freeze({
  CustomObject: "object",
  ApexClass: "apex-class",
  ApexTrigger: "apex-trigger",
  ApexPage: "visualforce-page",
  LightningComponentBundle: "lwc",
  AuraDefinitionBundle: "aura",
  Flow: "flow",
  PermissionSet: "permission-set",
  Profile: "profile",
  Layout: "layout",
  QuickAction: "quick-action",
  NamedCredential: "named-credential",
  RemoteSiteSetting: "remote-site",
  CustomNotificationType: "custom-notification-type",
  ApprovalProcess: "approval-process",
  Workflow: "workflow",
  RecordType: "record-type",
  ValidationRule: "validation-rule",
  EmailTemplate: "email-template",
  CustomTab: "custom-tab"
});

export function sha256(value) {
  return createHash("sha256").update(value).digest("hex");
}

export function parseArgs(argv) {
  const parsed = { _: [] };
  for (let index = 0; index < argv.length; index += 1) {
    const token = argv[index];
    if (!token.startsWith("--")) {
      parsed._.push(token);
      continue;
    }
    const [rawKey, inline] = token.slice(2).split("=", 2);
    if (inline !== undefined) {
      parsed[rawKey] = inline;
      continue;
    }
    const next = argv[index + 1];
    if (next !== undefined && !next.startsWith("--")) {
      parsed[rawKey] = next;
      index += 1;
    } else {
      parsed[rawKey] = true;
    }
  }
  return parsed;
}

export function cacheOutputPath(projectRoot, requested, fallbackName) {
  const root = resolve(projectRoot);
  const cache = resolve(root, CACHE_DIR);
  const target = resolve(root, requested || `${CACHE_DIR}/${fallbackName}`);
  if (target !== cache && !target.startsWith(`${cache}${sep}`)) {
    throw new Error(`Output must stay inside ${cache}: ${target}`);
  }
  return target;
}

export async function writeJson(target, value) {
  await mkdir(dirname(target), { recursive: true });
  await writeFile(target, `${JSON.stringify(value, null, 2)}\n`, "utf8");
}

export function readJson(path) {
  return JSON.parse(readFileSync(path, "utf8"));
}

async function walk(directory) {
  const entries = await readdir(directory, { withFileTypes: true });
  const files = [];
  for (const entry of entries.sort((a, b) => a.name.localeCompare(b.name))) {
    const path = resolve(directory, entry.name);
    if (entry.isDirectory()) files.push(...(await walk(path)));
    else if (entry.isFile()) files.push(path);
  }
  return files;
}

function xmlValues(text, tag) {
  const expression = new RegExp(`<${tag}>([\\s\\S]*?)</${tag}>`, "g");
  return [...text.matchAll(expression)].map((match) =>
    decodeXml(match[1].trim())
  );
}

function xmlValue(text, tag) {
  return xmlValues(text, tag)[0] ?? null;
}

function xmlBoolean(text, tag) {
  const value = xmlValue(text, tag);
  return value === null ? null : value.toLowerCase() === "true";
}

function decodeXml(value) {
  return value
    .replaceAll("&lt;", "<")
    .replaceAll("&gt;", ">")
    .replaceAll("&quot;", '"')
    .replaceAll("&apos;", "'")
    .replaceAll("&amp;", "&");
}

export function componentForPath(relativePath) {
  const path = relativePath.replaceAll("\\", "/");
  let match;

  if ((match = /^classes\/(.+?)\.cls(?:-meta\.xml)?$/i.exec(path))) {
    return {
      key: `apex-class:${match[1]}`,
      kind: "apex-class",
      name: match[1]
    };
  }
  if ((match = /^triggers\/(.+?)\.trigger(?:-meta\.xml)?$/i.exec(path))) {
    return {
      key: `apex-trigger:${match[1]}`,
      kind: "apex-trigger",
      name: match[1]
    };
  }
  if ((match = /^lwc\/([^/]+)\//i.exec(path))) {
    return { key: `lwc:${match[1]}`, kind: "lwc", name: match[1] };
  }
  if ((match = /^aura\/([^/]+)\//i.exec(path))) {
    return { key: `aura:${match[1]}`, kind: "aura", name: match[1] };
  }
  if (
    (match = /^objects\/([^/]+)\/fields\/([^/]+)\.field-meta\.xml$/i.exec(path))
  ) {
    return {
      key: `field:${match[1]}.${match[2]}`,
      kind: "field",
      name: `${match[1]}.${match[2]}`,
      object: match[1]
    };
  }
  if (
    (match =
      /^objects\/([^/]+)\/validationRules\/([^/]+)\.validationRule-meta\.xml$/i.exec(
        path
      ))
  ) {
    return {
      key: `validation-rule:${match[1]}.${match[2]}`,
      kind: "validation-rule",
      name: `${match[1]}.${match[2]}`,
      object: match[1]
    };
  }
  if (
    (match =
      /^objects\/([^/]+)\/recordTypes\/([^/]+)\.recordType-meta\.xml$/i.exec(
        path
      ))
  ) {
    return {
      key: `record-type:${match[1]}.${match[2]}`,
      kind: "record-type",
      name: `${match[1]}.${match[2]}`,
      object: match[1]
    };
  }
  if (
    (match = /^objects\/([^/]+)\/listViews\/([^/]+)\.listView-meta\.xml$/i.exec(
      path
    ))
  ) {
    return {
      key: `list-view:${match[1]}.${match[2]}`,
      kind: "list-view",
      name: `${match[1]}.${match[2]}`,
      object: match[1]
    };
  }
  if ((match = /^objects\/([^/]+)\/\1\.object-meta\.xml$/i.exec(path))) {
    return { key: `object:${match[1]}`, kind: "object", name: match[1] };
  }

  const folders = [
    [
      "permissionsets",
      "permission-set",
      /^(?:permissionSets|permissionsets)\/([^/]+)\.permissionset-meta\.xml$/i
    ],
    ["profiles", "profile", /^profiles\/([^/]+)\.profile-meta\.xml$/i],
    ["layouts", "layout", /^layouts\/([^/]+)\.layout-meta\.xml$/i],
    [
      "quickActions",
      "quick-action",
      /^quickActions\/([^/]+)\.quickAction-meta\.xml$/i
    ],
    ["flows", "flow", /^flows\/([^/]+)\.flow-meta\.xml$/i],
    [
      "namedCredentials",
      "named-credential",
      /^namedCredentials\/([^/]+)\.namedCredential-meta\.xml$/i
    ],
    [
      "remoteSiteSettings",
      "remote-site",
      /^remoteSiteSettings\/([^/]+)\.remoteSite-meta\.xml$/i
    ],
    [
      "notificationtypes",
      "custom-notification-type",
      /^notificationtypes\/([^/]+)\.notiftype-meta\.xml$/i
    ],
    ["tabs", "custom-tab", /^tabs\/([^/]+)\.tab-meta\.xml$/i],
    ["pages", "visualforce-page", /^pages\/([^/]+)\.page(?:-meta\.xml)?$/i]
  ];
  for (const [, kind, expression] of folders) {
    match = expression.exec(path);
    if (match) return { key: `${kind}:${match[1]}`, kind, name: match[1] };
  }

  return { key: `metadata-file:${path}`, kind: "metadata-file", name: path };
}

function parseFacts(component, path, text) {
  if (component.kind === "field" && path.endsWith(".field-meta.xml")) {
    const values = [];
    for (const block of text.matchAll(/<value>([\s\S]*?)<\/value>/g)) {
      const fullName = xmlValue(block[1], "fullName");
      if (fullName)
        values.push({
          value: fullName,
          default: xmlBoolean(block[1], "default")
        });
    }
    return {
      api_name: xmlValue(text, "fullName"),
      type: xmlValue(text, "type"),
      reference_to: xmlValue(text, "referenceTo"),
      relationship_name: xmlValue(text, "relationshipName"),
      required: xmlBoolean(text, "required"),
      unique: xmlBoolean(text, "unique"),
      external_id: xmlBoolean(text, "externalId"),
      restricted: xmlBoolean(text, "restricted"),
      values
    };
  }
  if (component.kind === "permission-set" || component.kind === "profile") {
    const fieldPermissions = [];
    for (const block of text.matchAll(
      /<fieldPermissions>([\s\S]*?)<\/fieldPermissions>/g
    )) {
      fieldPermissions.push({
        field: xmlValue(block[1], "field"),
        readable: xmlBoolean(block[1], "readable"),
        editable: xmlBoolean(block[1], "editable")
      });
    }
    const objectPermissions = [];
    for (const block of text.matchAll(
      /<objectPermissions>([\s\S]*?)<\/objectPermissions>/g
    )) {
      objectPermissions.push({
        object: xmlValue(block[1], "object"),
        allow_read: xmlBoolean(block[1], "allowRead"),
        allow_create: xmlBoolean(block[1], "allowCreate"),
        allow_edit: xmlBoolean(block[1], "allowEdit"),
        allow_delete: xmlBoolean(block[1], "allowDelete")
      });
    }
    return {
      field_permissions: fieldPermissions,
      object_permissions: objectPermissions
    };
  }
  return {};
}

function gitCommit(projectRoot) {
  const executable = process.platform === "win32" ? "git.exe" : "git";
  const result = spawnSync(executable, ["rev-parse", "HEAD"], {
    cwd: projectRoot,
    encoding: "utf8",
    windowsHide: true
  });
  return result.status === 0 ? result.stdout.trim() : null;
}

export async function snapshotRepository({ projectRoot, sourceRoot }) {
  const root = resolve(projectRoot);
  const source = resolve(root, sourceRoot);
  const files = await walk(source);
  const components = new Map();

  for (const file of files) {
    const rel = relative(source, file).replaceAll("\\", "/");
    const content = await readFile(file);
    const text = content.toString("utf8");
    const component = componentForPath(rel);
    const entry = components.get(component.key) || {
      key: component.key,
      kind: component.kind,
      name: component.name,
      object: component.object ?? null,
      files: [],
      facts: {}
    };
    entry.files.push({
      path: rel,
      sha256: sha256(content),
      bytes: content.length
    });
    entry.facts = { ...entry.facts, ...parseFacts(component, rel, text) };
    components.set(component.key, entry);
  }

  const sorted = [...components.values()]
    .map((entry) => {
      entry.files.sort((a, b) => a.path.localeCompare(b.path));
      return {
        ...entry,
        sha256: sha256(
          entry.files.map((file) => `${file.path}:${file.sha256}`).join("\n")
        )
      };
    })
    .sort((a, b) => a.key.localeCompare(b.key));

  return {
    schema_version: 1,
    snapshot_kind: "repository",
    observed_at: new Date().toISOString(),
    repo_commit: gitCommit(root),
    source_root: relative(root, source).replaceAll("\\", "/"),
    component_count: sorted.length,
    components: sorted
  };
}

function sfExecutable() {
  return process.platform === "win32" ? "sf.cmd" : "sf";
}

function sanitizeMessage(message) {
  return String(message || "unknown Salesforce CLI error")
    .replace(/https?:\/\/\S+/gi, "[url]")
    .replace(/(?:access[_ -]?token|authorization)\s*[:=]\s*\S+/gi, "[redacted]")
    .slice(0, 600);
}

export function runSfJson(
  args,
  { projectRoot, allowFailure = false, timeout = 180000 } = {}
) {
  const result = spawnSync(sfExecutable(), [...args, "--json"], {
    cwd: projectRoot,
    encoding: "utf8",
    windowsHide: true,
    shell: process.platform === "win32",
    timeout,
    maxBuffer: 20 * 1024 * 1024
  });
  let payload;
  try {
    payload = JSON.parse((result.stdout || "").replace(/^\uFEFF/, "").trim());
  } catch {
    const error = new Error(
      sanitizeMessage(result.stderr || result.stdout || result.error?.message)
    );
    if (allowFailure) return { ok: false, error: error.message };
    throw error;
  }
  if (result.status !== 0 || payload.status !== 0) {
    const message = sanitizeMessage(
      payload.message || result.stderr || result.error?.message
    );
    if (allowFailure) return { ok: false, error: message };
    throw new Error(message);
  }
  return { ok: true, result: payload.result };
}

export function metadataKey(type, fullName) {
  const kind = METADATA_TYPES[type];
  return kind && fullName ? `${kind}:${fullName}` : null;
}

export function inferObjects(repositorySnapshot, verification) {
  const objects = new Set();
  for (const component of repositorySnapshot?.components || []) {
    if (component.kind === "object") objects.add(component.name);
    if (component.kind === "field" && component.object)
      objects.add(component.object);
  }
  for (const assertion of verification?.assertions || []) {
    const match = /^field:([^.]+)\./.exec(assertion.component || "");
    if (match) objects.add(match[1]);
    const object = /^object:(.+)$/.exec(assertion.component || "");
    if (object) objects.add(object[1]);
  }
  return [...objects]
    .filter((name) => /^[A-Za-z][A-Za-z0-9_]*$/.test(name))
    .sort();
}

export function isHumanPermissionGrant(row) {
  const profileName = row.profile_name || "";
  const permissionSet = row.permission_set || "";
  if (profileName) return true;
  return (
    permissionSet !== "" && !/^(?:sfdc_|sfdcInternalInt__)/i.test(permissionSet)
  );
}

function samePermissionPrincipal(left, right) {
  if (left.parent_id && right.parent_id)
    return left.parent_id === right.parent_id;
  return (
    (left.profile_name || "") === (right.profile_name || "") &&
    (left.permission_set || "") === (right.permission_set || "")
  );
}

function orgEvidenceUnavailable(assertion, orgSnapshot) {
  const field = /^field:([^.]+)\./.exec(assertion.component || "");
  if (field) {
    return (orgSnapshot.unavailable_field_objects || []).some(
      (entry) => entry.object === field[1]
    );
  }
  const object = /^object:(.+)$/.exec(assertion.component || "");
  if (object) {
    const checked = new Set(orgSnapshot.field_definition_objects_checked || []);
    return (
      !checked.has(object[1]) &&
      (orgSnapshot.unavailable_component_kinds || []).includes("object")
    );
  }
  const kind = String(assertion.component || "").split(":", 1)[0];
  return (orgSnapshot.unavailable_component_kinds || []).includes(kind);
}

function permissionEvidenceUnavailable(component, orgSnapshot) {
  const match = /^field:([^.]+)\.(.+)$/.exec(component || "");
  if (!match) return false;
  const fieldName = `${match[1]}.${match[2]}`;
  const fieldUnavailable = (
    orgSnapshot.unavailable_field_permissions || []
  ).some((entry) => (entry.fields || []).includes(fieldName));
  const objectUnavailable = (
    orgSnapshot.unavailable_object_permissions || []
  ).some((entry) => (entry.objects || []).includes(match[1]));
  return fieldUnavailable || objectUnavailable;
}

function componentMap(snapshot) {
  return new Map(
    (snapshot?.components || []).map((component) => [component.key, component])
  );
}

export function compareSnapshots(
  repositorySnapshot,
  orgSnapshot,
  verification
) {
  const repository = componentMap(repositorySnapshot);
  const org = componentMap(orgSnapshot);
  const rows = [];

  for (const assertion of verification.assertions || []) {
    if (assertion.kind === "coverage") {
      const actual = orgSnapshot.coverage?.percent ?? null;
      const minimum = assertion.minimum_percent;
      rows.push({
        id: assertion.id,
        requirements: assertion.requirements,
        component: "coverage:apex",
        compliance:
          actual === null
            ? "unverifiable"
            : actual >= minimum
              ? "matches"
              : "partial",
        drift: "aligned",
        operability:
          actual === null
            ? "not-assessed"
            : actual >= minimum
              ? "usable"
              : "uncovered",
        confidence: actual === null ? "inferred" : "verified",
        expected: `>= ${minimum}%`,
        actual: actual === null ? null : `${actual}%`,
        structural_only: false,
        notes: assertion.notes || []
      });
      continue;
    }

    const repoComponent = repository.get(assertion.component);
    const orgComponent = org.get(assertion.component);
    const repoPresent = Boolean(repoComponent);
    const orgPresent = Boolean(orgComponent);
    const orgUnavailable =
      !orgPresent && orgEvidenceUnavailable(assertion, orgSnapshot);
    let drift = "absent-both";
    if (repoPresent && orgPresent) drift = "aligned";
    else if (orgUnavailable) drift = "unverifiable";
    else if (repoPresent) drift = "repository-only";
    else if (orgPresent) drift = "org-only";

    let compliance = "matches";
    if (assertion.expect_org === "present" && !orgPresent) {
      compliance = orgUnavailable ? "unverifiable" : "missing";
    }
    if (assertion.expect_repo === "present" && !repoPresent && orgPresent)
      compliance = "partial";
    if (!repoPresent && !orgPresent)
      compliance = orgUnavailable ? "unverifiable" : "missing";

    let operability = "not-assessed";
    let permissionEvidence = null;
    let confidence = orgUnavailable ? "inferred" : "verified";
    if (assertion.permission) {
      const grants = orgSnapshot.field_permissions?.[assertion.component] || [];
      const objectName = /^field:([^.]+)\./.exec(assertion.component)?.[1];
      const objectGrants =
        orgSnapshot.object_permissions?.[`object:${objectName}`] || [];
      const unavailable = permissionEvidenceUnavailable(
        assertion.component,
        orgSnapshot
      );
      const human = grants.filter(isHumanPermissionGrant);
      const humanObject = objectGrants.filter(isHumanPermissionGrant);
      const fieldAllows = (grant) =>
        assertion.permission === "edit" ? grant.editable : grant.readable;
      const objectAllows = (grant) =>
        assertion.permission === "edit" ? grant.editable : grant.readable;
      const usable = human.some(
        (fieldGrant) =>
          fieldAllows(fieldGrant) &&
          humanObject.some(
            (objectGrant) =>
              objectAllows(objectGrant) &&
              samePermissionPrincipal(fieldGrant, objectGrant)
          )
      );
      permissionEvidence = {
        field_grant_count: grants.length,
        human_field_grant_count: human.length,
        object_grant_count: objectGrants.length,
        human_object_grant_count: humanObject.length,
        usable_principal_found: unavailable ? null : usable,
        unavailable
      };
      if (unavailable) {
        operability = "not-assessed";
        confidence = "inferred";
      } else {
        operability = usable ? "usable" : "permission-blocked";
        if (!usable && orgPresent && compliance === "matches")
          compliance = "partial";
      }
    }

    rows.push({
      id: assertion.id,
      requirements: assertion.requirements,
      component: assertion.component,
      compliance,
      drift,
      operability,
      confidence,
      structural_only: true,
      repository: repoPresent
        ? { present: true, sha256: repoComponent.sha256 }
        : { present: false },
      org: orgPresent
        ? { present: true, evidence: orgComponent.evidence || null }
        : { present: false },
      permission_evidence: permissionEvidence,
      notes: assertion.notes || []
    });
  }

  const counts = {};
  for (const axis of ["compliance", "drift", "operability"]) {
    counts[axis] = {};
    for (const row of rows)
      counts[axis][row[axis]] = (counts[axis][row[axis]] || 0) + 1;
  }

  return {
    schema_version: 1,
    snapshot_kind: "comparison",
    observed_at: new Date().toISOString(),
    org: orgSnapshot.org,
    repo_commit: repositorySnapshot.repo_commit,
    assertion_count: rows.length,
    counts,
    rows
  };
}

export function comparisonMarkdown(comparison) {
  const lines = [
    "# Org status structural comparison",
    "",
    `Observed: ${comparison.observed_at}`,
    `Org: ${comparison.org?.alias || comparison.org?.username || "unknown"} (${comparison.org?.id || "unknown id"})`,
    `Repository commit: ${comparison.repo_commit || "unknown"}`,
    "",
    "> Structural assertions only. Behavioural requirements still require targeted inspection.",
    "",
    "| Requirement | Component | Compliance | Drift | Operability | Confidence |",
    "| --- | --- | --- | --- | --- | --- |"
  ];
  for (const row of comparison.rows) {
    lines.push(
      `| ${(row.requirements || []).join(", ")} | \`${row.component}\` | ${row.compliance} | ${row.drift} | ${row.operability} | ${row.confidence} |`
    );
  }
  lines.push("");
  return lines.join("\n");
}

export function collectRegistryIds(yaml) {
  return new Set(
    [...yaml.matchAll(/^\s*-?\s*id:\s*((?:DM|[A-Z]{2,4})-\d+)/gm)].map(
      (match) => match[1]
    )
  );
}

export function collectRequirementIds(yaml) {
  const start = yaml.search(/^requirements:\s*$/m);
  if (start < 0) return new Set();
  const remainder = yaml.slice(start + "requirements:".length);
  const nextSection = remainder.search(/^\S[^:\n]*:\s*$/m);
  const section = nextSection < 0 ? remainder : remainder.slice(0, nextSection);
  return new Set(
    [...section.matchAll(/^\s*-?\s*id:\s*((?:DM|[A-Z]{2,4})-\d+)/gm)].map(
      (match) => match[1]
    )
  );
}

export function validateVerification(verification, registryIds) {
  const errors = [];
  const warnings = [];
  if (verification.schema_version !== 1)
    errors.push("verification schema_version must be 1");
  if (!Array.isArray(verification.assertions))
    errors.push("verification assertions must be an array");
  const ids = new Set();
  for (const assertion of verification.assertions || []) {
    if (!assertion.id || ids.has(assertion.id))
      errors.push(`duplicate or missing assertion id: ${assertion.id}`);
    ids.add(assertion.id);
    if (
      !Array.isArray(assertion.requirements) ||
      assertion.requirements.length === 0
    ) {
      errors.push(`${assertion.id}: requirements must be a non-empty array`);
    }
    for (const requirement of assertion.requirements || []) {
      if (!registryIds.has(requirement))
        errors.push(`${assertion.id}: unknown requirement ${requirement}`);
    }
    if (assertion.kind === "coverage") {
      if (!Number.isFinite(assertion.minimum_percent))
        errors.push(`${assertion.id}: minimum_percent is required`);
    } else if (!/^[a-z-]+:.+/.test(assertion.component || "")) {
      errors.push(
        `${assertion.id}: invalid component key ${assertion.component}`
      );
    }
  }
  if ((verification.assertions || []).length === 0)
    warnings.push("verification plan has no assertions");
  return { errors, warnings };
}

export function unknownBuildStateRefs(yaml, registryIds) {
  const start = yaml.search(/^build_state:/m);
  if (start < 0) return [];
  const buildState = yaml.slice(start);
  const unknown = new Set();
  for (const match of buildState.matchAll(/refs:\s*\[([^\]]*)\]/g)) {
    for (const ref of match[1]
      .split(",")
      .map((value) => value.trim())
      .filter(Boolean)) {
      if (!registryIds.has(ref)) unknown.add(ref);
    }
  }
  return [...unknown].sort();
}

export function compareSkillMirrors(projectRoot) {
  const left = resolve(projectRoot, ".agents/skills/org-status-check");
  const right = resolve(projectRoot, ".claude/skills/org-status-check");
  if (!existsSync(left) || !existsSync(right))
    return { checked: false, differences: [] };

  function filesUnder(root) {
    const pending = [root];
    const files = [];
    while (pending.length) {
      const current = pending.pop();
      for (const entry of readdirSync(current, { withFileTypes: true }).sort(
        (a, b) => a.name.localeCompare(b.name)
      )) {
        const path = resolve(current, entry.name);
        if (entry.isDirectory()) pending.push(path);
        else if (entry.isFile())
          files.push(relative(root, path).replaceAll("\\", "/"));
      }
    }
    return files.sort();
  }

  const leftFiles = filesUnder(left);
  const rightFiles = filesUnder(right);
  const names = new Set([...leftFiles, ...rightFiles]);
  const differences = [];
  for (const name of [...names].sort()) {
    const leftPath = resolve(left, name);
    const rightPath = resolve(right, name);
    if (!existsSync(leftPath) || !existsSync(rightPath))
      differences.push(`${name}: missing from one mirror`);
    else if (
      sha256(readFileSync(leftPath)) !== sha256(readFileSync(rightPath))
    ) {
      differences.push(`${name}: content differs`);
    }
  }
  return { checked: true, differences };
}
