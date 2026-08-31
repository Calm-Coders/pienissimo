import assert from "node:assert/strict";
import { mkdtemp, mkdir, rm, writeFile } from "node:fs/promises";
import { tmpdir } from "node:os";
import { resolve } from "node:path";
import test from "node:test";

import {
  collectRequirementIds,
  collectRegistryIds,
  compareSnapshots,
  snapshotRepository,
  unknownBuildStateRefs,
  validateVerification
} from "./lib.mjs";

test("repository snapshot keeps same-named fields on different objects separate", async () => {
  const root = await mkdtemp(resolve(tmpdir(), "org-status-"));
  try {
    const source = resolve(root, "force-app/main/default");
    for (const object of ["OrderItem", "QuoteLineItem"]) {
      const directory = resolve(source, `objects/${object}/fields`);
      await mkdir(directory, { recursive: true });
      await writeFile(
        resolve(directory, "Tranche__c.field-meta.xml"),
        '<CustomField xmlns="http://soap.sforce.com/2006/04/metadata"><fullName>Tranche__c</fullName><type>Lookup</type><referenceTo>Tranche__c</referenceTo></CustomField>',
        "utf8"
      );
    }
    const snapshot = await snapshotRepository({
      projectRoot: root,
      sourceRoot: "force-app/main/default"
    });
    const keys = new Set(snapshot.components.map((component) => component.key));
    assert(keys.has("field:OrderItem.Tranche__c"));
    assert(keys.has("field:QuoteLineItem.Tranche__c"));
  } finally {
    await rm(root, { recursive: true, force: true });
  }
});

test("deployed field with no human FLS grant is permission-blocked, not missing", () => {
  const repository = {
    repo_commit: "abc",
    components: [{ key: "field:OrderItem.Tranche__c", sha256: "one" }]
  };
  const org = {
    org: { alias: "uat", id: "00D" },
    components: [
      { key: "field:OrderItem.Tranche__c", evidence: "FieldDefinition" }
    ],
    field_permissions: {
      "field:OrderItem.Tranche__c": [
        {
          permission_set: "sfdc_a360_sfcrm_data_extract",
          profile_name: null,
          readable: true,
          editable: false
        }
      ]
    }
  };
  const verification = {
    assertions: [
      {
        id: "ORD-01-field",
        kind: "component",
        requirements: ["ORD-01"],
        component: "field:OrderItem.Tranche__c",
        expect_repo: "present",
        expect_org: "present",
        permission: "read"
      }
    ]
  };
  const row = compareSnapshots(repository, org, verification).rows[0];
  assert.equal(row.compliance, "partial");
  assert.equal(row.drift, "aligned");
  assert.equal(row.operability, "permission-blocked");
});

test("field operability requires matching field and object access", () => {
  const component = "field:QuoteLineItem.Tranche__c";
  const repository = {
    repo_commit: "abc",
    components: [{ key: component, sha256: "one" }]
  };
  const org = {
    org: { alias: "uat", id: "00D" },
    components: [{ key: component, evidence: "FieldDefinition" }],
    field_permissions: {
      [component]: [
        {
          parent_id: "0PS-one",
          permission_set: "Tranche_Management",
          profile_name: null,
          readable: true,
          editable: true
        }
      ]
    },
    object_permissions: {
      "object:QuoteLineItem": [
        {
          parent_id: "0PS-one",
          permission_set: "Tranche_Management",
          profile_name: null,
          readable: true,
          editable: true
        }
      ]
    }
  };
  const verification = {
    assertions: [
      {
        id: "ORD-01-field",
        kind: "component",
        requirements: ["ORD-01"],
        component,
        expect_repo: "present",
        expect_org: "present",
        permission: "edit"
      }
    ]
  };
  const row = compareSnapshots(repository, org, verification).rows[0];
  assert.equal(row.compliance, "matches");
  assert.equal(row.operability, "usable");
});

test("failed field inventory produces unverifiable rather than missing", () => {
  const component = "field:OrderItem.Tranche__c";
  const repository = { repo_commit: "abc", components: [] };
  const org = {
    org: { alias: "uat", id: "00D" },
    components: [],
    unavailable_field_objects: [{ object: "OrderItem", error: "query failed" }]
  };
  const verification = {
    assertions: [
      {
        id: "ORD-01-field",
        kind: "component",
        requirements: ["ORD-01"],
        component,
        expect_repo: "present",
        expect_org: "present"
      }
    ]
  };
  const row = compareSnapshots(repository, org, verification).rows[0];
  assert.equal(row.compliance, "unverifiable");
  assert.equal(row.drift, "unverifiable");
  assert.equal(row.confidence, "inferred");
});

test("verification and build-state validation detect unknown requirement refs", () => {
  const yaml =
    "sources:\n diagrams:\n - id: DGM-1\nrequirements:\n area:\n - id: ORD-01\n text: example\nbuild_state:\n built:\n - { component: x, refs: [DGM-1, QUO-01] }\n";
  const registryIds = collectRegistryIds(yaml);
  const requirementIds = collectRequirementIds(yaml);
  const result = validateVerification(
    {
      schema_version: 1,
      assertions: [
        {
          id: "bad",
          kind: "component",
          requirements: ["BAD-01"],
          component: "field:X.Y"
        }
      ]
    },
    requirementIds
  );
  assert(result.errors.some((error) => error.includes("BAD-01")));
  assert.deepEqual(unknownBuildStateRefs(yaml, registryIds), ["QUO-01"]);
});
