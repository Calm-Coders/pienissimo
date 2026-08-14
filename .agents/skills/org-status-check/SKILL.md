---
name: org-status-check
description: Compare what is actually implemented in the Pienissimo Salesforce org against the requirements recorded in the repository, and report the gap in both directions - requirements with no implementation, implementation with no requirement, and implementation that contradicts what was agreed. Use when asked for an org status check, what is actually implemented, whether the org matches the requirements or the spec, what is left to build, or before a go-live, sign-off, UAT, or client update.
user-invocable: true
---

# Org Status Check (ROMI-PIENISSIMO edition)

One comparison, **three** sides — this project's distinguishing problem:

- **Requirements** — what the repository says should exist.
- **The repository** — `force-app/`, which is the repository's *claim* about the
  org.
- **The org** — Pienissimo UAT, which is what actually runs.

All three disagree, in both directions. See
[the build ahead of the record](../../../notes/objects/The%20build%20ahead%20of%20the%20record.md)
and
[the Biglietto stack that is not in source control](../../../notes/risks/Risk%20-%20the%20Biglietto%20Apex%20stack%20is%20not%20in%20source%20control.md).
A run that compares only two of the three has failed.

The output is a gap table, not a narrative.

## 1. Extract the requirements as a checklist

Route through [MAP.md](../../../MAP.md) → [INDEX.md](../../../INDEX.md) → the
specific notes. For requirement ids, priorities, state machines and picklist
values, the authority is
[requirements/pienissimo-requirements.yaml](../../../requirements/pienissimo-requirements.yaml) —
grep it for the id rather than loading the prose documents.

Convert what you read into **concrete, checkable items**:

- custom objects and their fields, with types and relationships
- automation: flows, triggers, scheduled jobs, and what fires them
- validation rules, permission sets, record types, layouts
- state machines — the picklist values must match the agreed set exactly
- integration endpoints, named credentials, callout configuration

Note the source of each so a mismatch can be traced back. Where a requirement is
vague, record it as **unverifiable** rather than guessing. Never load a raw
transcript.

## 2. Inventory all three sides

**The org**, read-only:

```bash
sf org display --target-org <alias>
sf org list metadata --metadata-type CustomObject --target-org <alias>
sf org list metadata --metadata-type ApexClass    --target-org <alias>
sf org list metadata --metadata-type Flow         --target-org <alias>
sf data query --use-tooling-api --target-org <alias> \
  --query "SELECT ApexClassOrTrigger.Name, NumLinesCovered, NumLinesUncovered FROM ApexCodeCoverageAggregate"
```

**The repository:**

```bash
find force-app -type f | sed 's|.*/main/default/||' | cut -d/ -f1 | sort | uniq -c | sort -rn
```

**The divergence between them** — a first-class finding, not a preliminary:

```bash
sf project retrieve preview -o <alias>
```

Also read `git log --format="%h %ad %an %s" --date=short -30`. In this project
the repository moves **faster than the trackers**, and commits by developers who
appear in no meeting are the main way to discover unrecorded work.

If no org is reachable, say so plainly and mark the report **repository-only**.

## 3. Match, element by element

Walk the checklist for missing implementation, then walk the inventory in the
other direction for implementation nobody asked for.

| Verdict          | Meaning                                                    |
| ---------------- | ---------------------------------------------------------- |
| **Implemented**  | Present and matches                                        |
| **Partial**      | Present but incomplete — missing fields, cases, coverage   |
| **Divergent**    | Present but behaves differently from what was agreed       |
| **Missing**      | Required, absent                                           |
| **Unrequested**  | Present, required by nothing in the repository             |
| **Untracked**    | In `force-app/` but not in the org, or the reverse         |
| **Unverifiable** | The requirement is too vague to test                       |

**Divergent, Unrequested and Untracked matter most.** Missing work is usually
known; a silent behavioural difference is what gets discovered in UAT.

Look specifically for: fields that exist but are populated on zero records (the
project has several), automation that never fires, picklists whose values
predate a redesign, required fields that break existing data, and Apex with no
coverage.

## 4. Report

Lead with the counts, then the gap table, most severe first. For every
non-implemented row give the requirement, its source, what each side actually
has, and the concrete consequence.

Cite `file:line` for implementation and the note or `OI-NN` id for the
requirement. State whether the report is against the live org, and name the
alias. Distinguish what you verified from what you inferred.

## 5. Write the findings back

The updated records are the deliverable, not the chat report:

1. Set each affected note's `status:` to what the comparison proved; bump
   `updated:`.
2. Add notes for **Unrequested** and **Divergent** implementation — by
   definition these have no note yet.
3. Update [MAP.md](../../../MAP.md) and [INDEX.md](../../../INDEX.md), then
   regenerate the affected rows of `meetings/open-items.md` **and** `.it.md`, so
   the client-facing view stops contradicting the org.
4. Append a [JOURNAL.md](../../../JOURNAL.md) entry.
5. Run `npm run vault:check`.

## Guardrails

- **Read-only against the org.** Never run `sf project deploy start`,
  `sf project retrieve start`, or any `sf data` write — `retrieve start`
  overwrites local metadata and destroys the evidence.
- Do not treat `force-app/` as proof of what is deployed unless you verified it.
- Never fabricate a requirement, an owner, or a deployment state.
- Do not soften a divergence to match what the requirement expected.
