# ROMI — Pienissimo (Salesforce)

Salesforce DX project for the Pienissimo CRM migration (Zoho → Salesforce, contract expiry **31 October 2026**).

- **Requirements for client sign-off: [REQUISITI.it.md](REQUISITI.it.md) (the version to present) · [REQUIREMENTS.md](REQUIREMENTS.md) (EN mirror)**
- **Machine-readable register: [requirements/pienissimo-requirements.yaml](requirements/pienissimo-requirements.yaml)** — the single source of truth. Merges the meeting record, both design diagrams and the UAT org check into one file: requirement IDs with priority and status, the state machines, every picklist value, the five source contradictions, acceptance criteria and build state.
- Consolidated design state: [meetings/DEVELOPMENT-RECAP.md](meetings/DEVELOPMENT-RECAP.md) · [IT](meetings/DEVELOPMENT-RECAP.it.md)
- Open decisions tracker: [meetings/open-items.md](meetings/open-items.md) · [IT](meetings/open-items.it.md)
- Per-meeting recaps: [meetings/results/](meetings/results/) — original transcripts in [meetings/](meetings/)
- Proposals: [meetings/proposals/](meetings/proposals/)

## Artifacts

Interactive artifacts published on claude.ai (private unless shared).

**▶ Requirements Blueprint: [EN](https://claude.ai/code/artifact/a781b70f-dd3e-42b2-af71-efe3e8909ee3) · [IT](https://claude.ai/code/artifact/5627a81d-fccb-4002-b93d-c2fcf4948d61)** — renders the YAML register: state machines drawn from the two design diagrams, all picklist values, the sixteen requirements that existed only in the drawings, and the five contradictions to settle on 6 August.

**▶ Project Status — live dashboard: [EN](https://claude.ai/code/artifact/89ff4377-f47e-4239-8b5c-222401e985f1) · [IT](https://claude.ai/code/artifact/9b229522-9799-49bf-adca-70bc24e45521)** — 52 tasks across eight workstreams with per-task status, the nine live blockers, and the calendar to the 6 October go-live.

| Artifact                                                                                                               | What it covers                                                                                                                  | Updated    |
| ---------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------- | ---------- |
| [Requirements Blueprint](https://claude.ai/code/artifact/a781b70f-dd3e-42b2-af71-efe3e8909ee3) (EN)                    | State machines, picklists, diagram-only requirements, source contradictions, requirements vs build                              | 2026-08-03 |
| [Blueprint dei Requisiti](https://claude.ai/code/artifact/5627a81d-fccb-4002-b93d-c2fcf4948d61) (IT)                   | Italian version of the blueprint — the one to walk through with Pienissimo                                                      | 2026-08-03 |
| [Project Status](https://claude.ai/code/artifact/89ff4377-f47e-4239-8b5c-222401e985f1) (EN)                            | Workstream/task status board, blockers, timeline, org verification                                                              | 2026-08-03 |
| [Stato Progetto](https://claude.ai/code/artifact/9b229522-9799-49bf-adca-70bc24e45521) (IT)                            | Italian version of the status board — the one to share with Pienissimo                                                          | 2026-08-03 |
| [Pienissimo — Analisi Catalogo Prodotti](https://claude.ai/code/artifact/3d9acb50-961d-485f-8092-3eb0090b59a0)         | Analysis of the Mexal article master (`anar_PIE_ricla.xlsx`): `_ARTIP` A/Z/C decoding, `BLO-`/`PACK-` codes, LIVELLO_ hierarchy | 2026-07-23 |
| [Bundle Schema — Pienissimo](https://claude.ai/code/artifact/970c98df-7b58-4c4c-b9f8-5cda981966eb)                     | Bundle data model: `BundleComponent__c` junction, spread pricing, `Spread_Total__c` / `Spread_Variance__c` reconciliation       | 2026-07-16 |
| [Bundle ⇄ Product — the many-to-many](https://claude.ai/code/artifact/b064715d-4efb-4d5c-a7fb-d593193e8198)            | Explainer of the bundle↔product junction — why the spread price lives on the link, not the product (EN)                         | 2026-07-16 |
| [Bundle ⇄ Prodotto — la relazione molti-a-molti](https://claude.ai/code/artifact/9b8f038f-bf80-4d0a-943d-98b91617d9d1) | Italian version of the above, for sharing with Pienissimo                                                                       | 2026-07-16 |

Standing after the client's bundle approval (22–24 Jul): the three bundle artifacts remain accurate — the junction model and spread-on-the-link design were approved as built. The catalogue analysis is accurate on structure, but every price it shows is a ROMI placeholder (tracker [#42](meetings/open-items.md)); real catalogue prices are still owed before it goes in front of Pienissimo.

Local (non-published) diagrams in the repo root:

- [bundle-relationship-map.html](bundle-relationship-map.html) — Pienissimo Bundle Relationships
- [biglietto-structure-map.html](biglietto-structure-map.html) — Pienissimo Biglietto Data Relations

## Source design diagrams

Both live in Google Drive, both last modified 31 July 2026, both merged into the YAML register. They are the normative definition of every status field in the build.

| Diagram                              | Owner                      | Pages                                 | Drive                                                                              |
| ------------------------------------ | -------------------------- | ------------------------------------- | ---------------------------------------------------------------------------------- |
| `Flows & Objects.drawio`             | Elena Spini (ROMI)         | LEAD-OPTY · Ordini · Flusso Biglietti | [1ly3iGQ…](https://drive.google.com/file/d/11ly3iGQc1smlY8IybSnUMQBGXbZ-ddbx/view) |
| `Workflow Pienissimo 23-7-26.drawio` | Marco Montesi (Pienissimo) | LEAD-OPTY, client-annotated           | [1rfmySN…](https://drive.google.com/file/d/1rfmySNKyhhNJnaV-2ULkGl0vUIf50Q7t/view) |

Elena's file is the more detailed and is treated as authoritative where the two disagree. Marco's carries the client's own annotations — the complete loss-reason picklists, the request to revive expired quotes, and the open questions on lead queue assignment.

## Salesforce DX

Metadata lives in [force-app/main/default/](force-app/main/default/); scratch-org definitions in [config/](config/); project manifest in [sfdx-project.json](sfdx-project.json).

```
sf org login web            # authorize an org
sf project deploy start     # deploy metadata
sf project retrieve start   # retrieve metadata
sf apex run test            # run Apex tests
```
