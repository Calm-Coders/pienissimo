---
name: org-status-check
description: Compare Pienissimo requirements, Salesforce DX source, and a live Salesforce org; classify compliance, deployment drift, and operability with cited evidence, then send the completed result to Aurel and the Pienissimo devs group on Slack. Use for implementation-status questions, org/spec gap checks, UAT or sign-off readiness, and explicit org-status runs. Do not use to deploy, fix findings, write Apex tests, or retrieve metadata into force-app.
---

# Org Status Check — Pienissimo

Compare three independent realities:

- **Expected:** the requirements register and atomic notes.
- **Repository:** `force-app/`, which is only the repository's claim.
- **Deployed:** the named live org, which is what actually runs.

A run that silently collapses any two has failed. The primary output is an
evidence-backed gap table, not a narrative.

## Choose scope and output before collecting evidence

Use two independent controls.

**Scope**

- `targeted` — default for a natural-language question about one area.
- `full` — an explicit skill run, whole-org check, or readiness review before
  UAT, sign-off, deployment, or go-live.

**Output**

- `report` — default. Read-only against the org and repository; write only
  generated cache files and the configured Slack destinations.
- `reconcile` — use when the user asks to run the project procedure or update
  the repository record. Read [references/reconciliation.md](references/reconciliation.md).
- `publish` — use only when the user also asks to refresh shared surfaces.
  Reconcile first, then read [references/publishing.md](references/publishing.md).

Do not infer permission to reconcile or publish from an ordinary question such
as “what is built?”

## Evidence model

Read [references/evidence-model.md](references/evidence-model.md) before every
run. Keep three verdict axes instead of one overloaded label:

1. **Compliance:** matches, partial, divergent, missing, unverifiable.
2. **Deployment drift:** aligned, repository-only, org-only, content-mismatch,
   absent-both, unverifiable.
3. **Operability:** usable, permission-blocked, unconfigured, uncovered,
   unproven, not-assessed.

“Present” proves structure, not working behaviour. Distinguish verified facts
from inference in every row.

## Workflow

### 1. Route the expected state

Read `MAP.md` → `INDEX.md` → only the relevant notes. Grep
`requirements/pienissimo-requirements.yaml` for ids, state machines, picklist
values and acceptance criteria. Never load a raw transcript.

Use `requirements/org-verification.json` when it maps the requirement. It is an
executable verification plan, not a fourth source of truth. An unmapped or
behavioural requirement still needs targeted inspection; mark vague requirements
`unverifiable` rather than inventing a test.

### 2. Preflight the evidence sources

- Resolve the org alias and confirm `sf org display --json` returns the intended
  **Pienissimo UAT** org. Record alias, org id, time and repository commit.
- Check Graphify with `graph_stats`. If missing or stale, run
  `npm run intelligence:graph` and retry.
- Check Open Codebase Index with `index_status`. If unavailable, record the
  degradation and use `rg`; do not let Ollama or an embedding failure block the
  audit.
- Read `git log --format="%h %ad %an %s" --date=short -30`. Repository work
  routinely lands ahead of the project record.

### 3. Collect normalized snapshots

Read [references/live-org-inventory.md](references/live-org-inventory.md), then:

```powershell
npm run org-status:snapshot:repo
npm run org-status:snapshot:org -- --target-org <alias>
npm run org-status:compare
```

The scripts emit sanitized JSON under `.org-status-cache/`, which is generated
and gitignored. They never store access tokens, credentials, catalogue values,
article-code values, or personal record data.

Use `FieldDefinition` for field existence and `FieldPermissions` for visibility.
Never use `sf sobject describe` or ordinary SOQL to prove that a field is absent:
both are filtered by the running user's field-level security.

### 4. Investigate only exceptions and behaviour

The deterministic comparison handles structural presence, drift, permissions
and coverage. For non-matching or behavioural rows:

- use Graphify `sf_impact`, `sf_ooe`, `sf_cpq_chain` or `sf_violations` for
  Salesforce dependency leads;
- use Open Codebase Index `codebase_context`, `implementation_lookup`,
  `call_graph` or `call_graph_path` for Apex/LWC implementation paths;
- use `rg` for exact or exhaustive negatives;
- inspect the cited metadata or source before promoting an index result to a
  finding;
- use only targeted aggregate SOQL for runtime/data-state claims.

Graphify and Open Codebase Index are navigation aids. Neither proves what is
deployed, and an incomplete index cannot prove absence.

### 5. Report

Lead with counts and org identity, then the gap table, most severe first. Each
non-matching row must include:

- requirement id and source;
- expected state;
- repository evidence (`file:line` or normalized snapshot key);
- live-org evidence, observation time and method;
- all three verdict axes;
- concrete consequence;
- `verified` or `inferred`.

If no org is reachable, label the result **repository-only** and do not mutate a
note's implementation status from that run.

### 6. Reconcile or publish only in the selected mode

For `reconcile`, follow the complete write sequence in
[references/reconciliation.md](references/reconciliation.md). For `publish`,
complete reconciliation first and then follow
[references/publishing.md](references/publishing.md).

### 7. Deliver the completed result to Slack

After the selected mode and its validations finish, read and follow
[references/slack-delivery.md](references/slack-delivery.md). This is a standing
instruction explicitly authorized by Aurel: send every completed org-status
result separately to his configured personal DM and the Pienissimo devs group
DM unless he opts out for that particular run.

Slack delivery is separate from `publish` mode. Send the final result, never an
interim finding. If delivery is unavailable or fails, keep the org-status run
successful but tell the user plainly that the DM was not delivered.

## Guardrails

- The org is read-only: no deploy, data write, anonymous Apex, test execution,
  or source-format retrieve into `force-app/`.
- A targeted metadata retrieve is allowed only into a validated
  `.org-status-cache/<run>/` directory as described in the inventory reference.
- Never fix a finding as part of the check.
- Never write or offer Apex tests; coverage is measured, not acted on.
- Never fabricate requirements, owners, decisions, deployment state or
  attribution.
- Requirements do not move because implementation differs. Record the
  divergence instead.
- Send only to the verified Slack destinations in the delivery reference; never
  substitute a channel, similarly named user or newly discovered workspace.
- Run `npm run org-status:validate` before reporting and
  `npm run org-status:validate:strict` after reconciliation. Run
  `npm run vault:check` after knowledge changes.
