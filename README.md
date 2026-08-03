# ROMI — Pienissimo (Salesforce)

Salesforce DX project for the Pienissimo CRM migration (Zoho → Salesforce, contract expiry **31 October 2026**).

- **Requirements for client sign-off: [REQUISITI.it.md](REQUISITI.it.md) (the version to present) · [REQUIREMENTS.md](REQUIREMENTS.md) (EN mirror)**
- Consolidated design state: [meetings/DEVELOPMENT-RECAP.md](meetings/DEVELOPMENT-RECAP.md) · [IT](meetings/DEVELOPMENT-RECAP.it.md)
- Open decisions tracker: [meetings/open-items.md](meetings/open-items.md) · [IT](meetings/open-items.it.md)
- Per-meeting recaps: [meetings/results/](meetings/results/) — original transcripts in [meetings/](meetings/)
- Proposals: [meetings/proposals/](meetings/proposals/)

## Artifacts

Interactive artifacts published on claude.ai (private unless shared).

**▶ Project Status — live dashboard: [EN](https://claude.ai/code/artifact/89ff4377-f47e-4239-8b5c-222401e985f1) · [IT](https://claude.ai/code/artifact/9b229522-9799-49bf-adca-70bc24e45521)** — 48 tasks across seven workstreams with per-task status, the seven live blockers, and the calendar to the 6 October go-live. Compiled 2026-08-03 from Slack, Gmail, Drive and Fathom.

| Artifact                                                                                                               | What it covers                                                                                                                  | Updated    |
| ---------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------- | ---------- |
| [Project Status](https://claude.ai/code/artifact/89ff4377-f47e-4239-8b5c-222401e985f1) (EN)                            | Workstream/task status board, blockers, timeline, provenance                                                                    | 2026-08-03 |
| [Stato Progetto](https://claude.ai/code/artifact/9b229522-9799-49bf-adca-70bc24e45521) (IT)                            | Italian version of the status board — the one to share with Pienissimo                                                          | 2026-08-03 |
| [Pienissimo — Analisi Catalogo Prodotti](https://claude.ai/code/artifact/3d9acb50-961d-485f-8092-3eb0090b59a0)         | Analysis of the Mexal article master (`anar_PIE_ricla.xlsx`): `_ARTIP` A/Z/C decoding, `BLO-`/`PACK-` codes, LIVELLO_ hierarchy | 2026-07-23 |
| [Bundle Schema — Pienissimo](https://claude.ai/code/artifact/970c98df-7b58-4c4c-b9f8-5cda981966eb)                     | Bundle data model: `BundleComponent__c` junction, spread pricing, `Spread_Total__c` / `Spread_Variance__c` reconciliation       | 2026-07-16 |
| [Bundle ⇄ Product — the many-to-many](https://claude.ai/code/artifact/b064715d-4efb-4d5c-a7fb-d593193e8198)            | Explainer of the bundle↔product junction — why the spread price lives on the link, not the product (EN)                         | 2026-07-16 |
| [Bundle ⇄ Prodotto — la relazione molti-a-molti](https://claude.ai/code/artifact/9b8f038f-bf80-4d0a-943d-98b91617d9d1) | Italian version of the above, for sharing with Pienissimo                                                                       | 2026-07-16 |

Standing after the client's bundle approval (22–24 Jul): the three bundle artifacts remain accurate — the junction model and spread-on-the-link design were approved as built. The catalogue analysis is accurate on structure, but every price it shows is a ROMI placeholder (tracker [#42](meetings/open-items.md)); real catalogue prices are still owed before it goes in front of Pienissimo.

Local (non-published) diagrams in the repo root:

- [bundle-relationship-map.html](bundle-relationship-map.html) — Pienissimo Bundle Relationships
- [biglietto-structure-map.html](biglietto-structure-map.html) — Pienissimo Biglietto Data Relations

## Salesforce DX

Metadata lives in [force-app/main/default/](force-app/main/default/); scratch-org definitions in [config/](config/); project manifest in [sfdx-project.json](sfdx-project.json).

```
sf org login web            # authorize an org
sf project deploy start     # deploy metadata
sf project retrieve start   # retrieve metadata
sf apex run test            # run Apex tests
```
