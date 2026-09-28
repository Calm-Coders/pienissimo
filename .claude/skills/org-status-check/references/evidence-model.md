# Evidence model

Use this model for every org-status row. It prevents a component's existence,
deployment location and usability from being compressed into one misleading
label.

## Authority by question

| Question                          | Primary authority                                                              | Useful aid                             | Not proof                            |
| --------------------------------- | ------------------------------------------------------------------------------ | -------------------------------------- | ------------------------------------ |
| What is required?                 | `requirements/pienissimo-requirements.yaml`; atomic notes for volatile facts   | `MAP.md`, `INDEX.md`                   | Notion, trackers, recaps             |
| What is in source control?        | Exact files under `force-app/` and their hashes                                | Graphify, Open Codebase Index          | A live-org inventory                 |
| What is deployed?                 | Metadata API, Tooling API and targeted read-only queries against the named org | Repository comparison                  | `force-app/`                         |
| Does a field exist?               | Tooling `FieldDefinition`                                                      | isolated metadata retrieve             | `sf sobject describe`, ordinary SOQL |
| Can a user access a field?        | Tooling `FieldPermissions` plus object permissions                             | Graphify permission edges              | field existence                      |
| What calls or writes a component? | cited Apex/LWC/Flow/XML source                                                 | code index and Graphify paths          | semantic similarity alone            |
| Is behaviour working?             | exact configuration plus targeted runtime/aggregate evidence                   | order-of-execution and impact analysis | component presence                   |

Later evidence wins only within the same authority. A newer org observation can
supersede an older build-state observation; it cannot rewrite an agreed
requirement.

## Canonical component keys

The deterministic snapshots use object-qualified keys. Never key a field by its
API name alone.

```text
object:Tranche__c
field:OrderItem.Tranche__c
field:QuoteLineItem.Tranche__c
apex-class:QuoteTrancheController
apex-trigger:BundleComponentTrigger
flow:Quote_Reminder
permission-set:Tranche_Management
layout:Tranche__c-Tranche Layout
quick-action:Quote.Crea_Tranche
```

This is deliberately stricter than a navigation graph: two objects may legally
carry fields with the same API name.

## The three verdict axes

### Compliance

| Value          | Meaning                                                                                          |
| -------------- | ------------------------------------------------------------------------------------------------ |
| `matches`      | The tested assertion matches the requirement. For structural checks this means structure only.   |
| `partial`      | Some required pieces or evidence are missing.                                                    |
| `divergent`    | The implementation exists but contradicts the expected configuration or behaviour.               |
| `missing`      | An authoritative live-org inventory proves a required component absent.                          |
| `unverifiable` | The requirement is too vague, unmapped, inaccessible or behavioural without sufficient evidence. |

### Deployment drift

| Value              | Meaning                                                                                                                    |
| ------------------ | -------------------------------------------------------------------------------------------------------------------------- |
| `aligned`          | The component exists in repository and org. This does not prove identical content unless hashes or metadata were compared. |
| `repository-only`  | Present in `force-app/`, absent from the authoritative org inventory.                                                      |
| `org-only`         | Present in the org, absent from source control.                                                                            |
| `content-mismatch` | Both exist but exact comparable content differs.                                                                           |
| `absent-both`      | Neither side contains it.                                                                                                  |
| `unverifiable`     | The org-side inventory needed for this component failed or was unavailable.                                                |

### Operability

| Value                | Meaning                                                                                 |
| -------------------- | --------------------------------------------------------------------------------------- |
| `usable`             | Required access/configuration and relevant runtime evidence are present. Use sparingly. |
| `permission-blocked` | Structure exists but no applicable human profile or permission set can use it.          |
| `unconfigured`       | Framework exists without the configuration rows or endpoints needed to run.             |
| `uncovered`          | Apex coverage is below the required floor.                                              |
| `unproven`           | Structure and configuration exist but end-to-end behaviour was not observed.            |
| `not-assessed`       | The current assertion did not test operability.                                         |

Example: `OrderItem.Tranche__c` may be `partial` compliance, `aligned` drift,
and `permission-blocked` operability. Calling it simply “missing” or
“implemented” loses the important fact.

Field access and object access are judged together. `permission-blocked` is
reserved for a real denial: nothing outside the platform internals grants the
field. When a permission set grants the field but only a profile grants the
object, the verdict is `unproven`, not `permission-blocked` — a user carries one
profile plus their permission sets, so the combination is usually usable, and
proving it needs `PermissionSetAssignment`. Failing to prove usability is not
proving a blockage.

## Negative-evidence rule

An absence finding must name the exhaustive authority that was searched.

- field absence → `FieldDefinition` for the parent object;
- metadata-component absence → Metadata API list or an isolated scoped retrieve;
- repository absence → exact `rg`/file enumeration, not semantic search;
- no writer/caller → exact source search plus inspected dependency paths;
- no runtime data → a targeted aggregate query whose filter and object are cited.

If the chosen instrument is visibility-filtered, incomplete, stale or failed,
the verdict is `unverifiable`, not `missing`.

## Confidence and consequence

Every row says `verified` or `inferred`. A verified structural presence does not
make inferred behaviour verified. State the concrete consequence separately so
severity is tied to impact rather than colour or tone.
