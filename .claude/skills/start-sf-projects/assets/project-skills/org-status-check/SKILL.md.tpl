---
name: org-status-check
description: Compare recorded requirements, Salesforce DX source, and a named live Salesforce org; classify compliance, deployment drift, and operability with cited evidence. Use for implementation-status questions, org/spec gap checks, UAT or sign-off readiness, and explicit org-status runs. Do not use to deploy, fix findings, write tests, or retrieve metadata into force-app.
---

# Org Status Check - {{PROJECT_NAME}}

Compare three independent realities:

- **Expected:** the project's requirements and atomic notes.
- **Repository:** `force-app/`, which is only the repository's claim.
- **Deployed:** the named live org, which is what actually runs.

A run that silently collapses any two has failed. The primary output is an
evidence-backed gap table, not a narrative.

## Choose scope and output first

**Scope**

- `targeted` - default for a question about one area.
- `full` - an explicit whole-org or readiness review.

**Output**

- `report` - default; read-only apart from generated cache evidence and any
  explicitly configured result delivery.
- `reconcile` - only when asked to update the repository record. Read
  [references/reconciliation.md](references/reconciliation.md).
- `publish` - only when also asked to refresh shared surfaces. Reconcile first,
  then read [references/publishing.md](references/publishing.md).

Do not infer permission to reconcile or publish from an ordinary question such
as "what is built?"

## Evidence model

Read [references/evidence-model.md](references/evidence-model.md) before every
run. Keep three verdict axes:

1. **Compliance:** matches, partial, divergent, missing, unverifiable.
2. **Deployment drift:** aligned, repository-only, org-only, content-mismatch,
   absent-both, unverifiable.
3. **Operability:** usable, permission-blocked, unconfigured, uncovered,
   unproven, not-assessed.

"Present" proves structure, not working behaviour.

## Workflow

1. Follow the repository's read protocol. Route through `MAP.md` and `INDEX.md`,
   then open only the requirements and atomic notes needed for the chosen scope.
   Turn them into concrete assertions. Mark vague requirements `unverifiable`.
2. Resolve the org alias, confirm `sf org display --json` identifies the intended
   org, and record alias, org id, observation time and repository commit.
3. If the repository provides deterministic org-status snapshot commands, run
   them. Otherwise follow
   [references/live-org-inventory.md](references/live-org-inventory.md) and keep
   normalized, object-qualified component keys in a gitignored cache.
4. Use Graphify first for Salesforce dependencies, permissions and
   order-of-execution. Use Open Codebase Index first for code paths and callers.
   Treat both as navigation aids; inspect cited metadata and use exact search for
   exhaustive negatives. Degrade to `rg` if a semantic index is unavailable.
5. Investigate only structural exceptions and behavioural assertions after the
   inventory. Use targeted aggregate queries for runtime or configuration-state
   claims; never cache record data or secrets.
6. Report counts, org identity and the gap table, most severe first. Every
   non-matching row names the requirement source, expected state, repository
   evidence, live-org method and time, all three verdict axes, consequence, and
   whether the conclusion is verified or inferred.
7. Reconcile or publish only in the selected output mode.
8. If [references/slack-delivery.md](references/slack-delivery.md) is enabled,
   send the completed result only after the selected mode and validation finish.

If no org is reachable, label the result **repository-only**. Do not change a
note's implementation status from that run.

## Guardrails

- The org is read-only: no deploy, data write, anonymous Apex or test execution.
- Never retrieve into `force-app/`. A targeted reference retrieve is allowed
  only into a resolved cache directory outside source, as described in the live
  inventory reference.
- Never fix a finding as part of the check.
- Never fabricate requirements, owners, decisions, deployment state or
  attribution.
- Requirements do not move because implementation differs; record the
  divergence.
- Never send externally unless the delivery reference records the user's
  explicit authorization and a verified recipient id.
- Run the repository's integrity and formatting checks after reconciliation.
- Never commit or push unless the user asks.
