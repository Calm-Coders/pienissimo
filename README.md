# ROMI — Pienissimo (Salesforce)

Salesforce DX project for the Pienissimo CRM migration (Zoho → Salesforce, contract expiry **31 October 2026**).

## Start here

- **[MAP.md](MAP.md)** — where the project stands right now, under 5 KB. Read this first, always.
- **[INDEX.md](INDEX.md)** — the router: one line per artifact with its read cost, so you can budget before opening anything.
- **[notes/](notes/)** — the knowledge vault. One fact per note, stable ids (`OI-NN` matches the tracker row number). This is the source of truth for open items, risks, people and what is actually built; the big documents in `meetings/` are rendered views.
- **[AGENTS.md](AGENTS.md)** — instructions for any AI agent working here (`CLAUDE.md`, `GEMINI.md` and `.github/copilot-instructions.md` are pointers to it).
- **[JOURNAL.md](JOURNAL.md)** — session handoffs, newest first.
- **[STATUS.md](STATUS.md)** — the shareable status view for humans, regenerated from `notes/`. **ROMI internal** — it names people and states the slippage plainly, which is the point of it.

[STATUS.md](STATUS.md) is mirrored to Notion for colleagues who do not read the repository: [status page](https://app.notion.com/p/3c6a6b77a25c818e9b51dc873a2f489c) and [open-items tracker](https://app.notion.com/p/04cc8a62d28a40419d7916271f6cae11) (54 rows, one per note in `notes/items/`, joined on `Ref`) and [flows](https://app.notion.com/p/3c6a6b77a25c81f891e7ffba884cd150) (a Mermaid schema per flow, generated from [notes/flows/](notes/flows/) and the register). Both are **invite-only and not for Pienissimo**, and both are **mirrors, never sources**: refreshed by step 6 of `org-status-check`, and an edit typed into Notion is lost at the next regeneration. Ids, shape and sharing rules: [the Notion mirror note](notes/The%20Notion%20mirror%20of%20the%20project%20status.md).

⚠ **Two rules, both easy to breach by accident.** [site/](site/) is **public** and sanitized to [docs/publishing.md](docs/publishing.md) — never copy text from `STATUS.md` or the mirror into it. And **no catalogue prices or article-code values on any published surface, internal included** — describe a field, never a value.

Run `npm run vault:check` before committing knowledge changes. ⚠ `meetings/open-items.md` is ~50k tokens and `meetings/*-transcript.it.md` ~207k — never load them whole; see the read costs in [INDEX.md](INDEX.md).

## Requirements

- **Requirements for client sign-off: [REQUISITI.it.md](REQUISITI.it.md) (the version to present) · [REQUIREMENTS.md](REQUIREMENTS.md) (EN mirror)**
- **Machine-readable register: [requirements/pienissimo-requirements.yaml](requirements/pienissimo-requirements.yaml)** — the single source of truth. Merges the meeting record, both design diagrams and the UAT org check into one file: requirement IDs with priority and status, the state machines, every picklist value, the five source contradictions, acceptance criteria and build state.
- Consolidated design state: [meetings/DEVELOPMENT-RECAP.md](meetings/DEVELOPMENT-RECAP.md) · [IT](meetings/DEVELOPMENT-RECAP.it.md)
- Open decisions tracker: [meetings/open-items.md](meetings/open-items.md) · [IT](meetings/open-items.it.md)
- Per-meeting recaps: [meetings/results/](meetings/results/) — original transcripts in [meetings/](meetings/)
- Proposals: [meetings/proposals/](meetings/proposals/)

## Artifacts

Interactive artifacts published on claude.ai (private unless shared).

**▶ The Docket — what to run the 6 August session from: [IT](https://claude.ai/code/artifact/db01e756-d2af-4c22-9ff6-9b14a0ef2cbe) · [EN](https://claude.ai/code/artifact/851d51c1-689c-48f1-9400-b23cd91303ce)** — the twelve rulings due that day, each with its sources, who decides, and what happens if nobody does. Records rulings as Adopted / Decided otherwise / Deferred, and prints a signature sheet with the ratified items enumerated, the owed inputs, and an attendee list. Both languages are generated from one source file, so they are provably the same document.

**▶ Requirements Blueprint: [EN](https://claude.ai/code/artifact/a781b70f-dd3e-42b2-af71-efe3e8909ee3) · [IT](https://claude.ai/code/artifact/5627a81d-fccb-4002-b93d-c2fcf4948d61)** — the reference version: state machines, all picklist values, the requirements that existed only in the drawings.

**▶ Project Status — live dashboard: [EN](https://claude.ai/code/artifact/89ff4377-f47e-4239-8b5c-222401e985f1) · [IT](https://claude.ai/code/artifact/9b229522-9799-49bf-adca-70bc24e45521)** — 52 tasks across eight workstreams with per-task status, the nine live blockers, and the calendar to the 6 October go-live.

| Artifact                                                                                                               | What it covers                                                                                                                  | Updated    |
| ---------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------- | ---------- |
| [Il Registro delle Decisioni](https://claude.ai/code/artifact/db01e756-d2af-4c22-9ff6-9b14a0ef2cbe) (IT)               | The twelve rulings, with consequences of inaction, ruling controls and a printable signature sheet — the one to present         | 2026-08-03 |
| [The Docket](https://claude.ai/code/artifact/851d51c1-689c-48f1-9400-b23cd91303ce) (EN)                                | English mirror, generated from the same source                                                                                  | 2026-08-03 |
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

Both live in Google Drive and both are merged into the YAML register. They are the normative definition of every status field in the build. **Current versions: `Flows & Objects.drawio` last modified 20 August 2026 15:36 UTC, `Workflow Pienissimo 23-7-26.drawio` 20 August 2026 14:28 UTC** — both re-decoded in full on 20 August.

🔴 **Both files moved on the same afternoon, 68 minutes apart, and neither edit is minuted.** The register's state machines were deliberately **not** re-extracted from them: nothing in either drawing is minuted, so no agreed requirement has moved. Three divergences are open — `Rinuncia` drawn as a seventh asset state ([OI-74](notes/items/OI-74%20Asset%20state%20machine.md)), the 06 August order states drawn _alongside_ the old ones rather than replacing them ([OI-69](notes/items/OI-69%20Order%20state%20model.md)), and a ticket tier renamed `Silver` → `Dinamond` against the 06 August minute ([OI-76](notes/items/OI-76%20Ticket%20type%20picklist%20on%20the%20product.md)). See [the newest design diagram](notes/The%20newest%20design%20diagram.md) and [the client's file](notes/The%20client%20Lead-Opty%20diagram%20moved%20on%2020%20August.md).

| Diagram                              | Owner                      | Pages                                 | Drive                                                                              |
| ------------------------------------ | -------------------------- | ------------------------------------- | ---------------------------------------------------------------------------------- |
| `Flows & Objects.drawio`             | Elena Spini (ROMI)         | LEAD-OPTY · Ordini · Flusso Biglietti | [1ly3iGQ…](https://drive.google.com/file/d/11ly3iGQc1smlY8IybSnUMQBGXbZ-ddbx/view) |
| `Workflow Pienissimo 23-7-26.drawio` | Marco Montesi (Pienissimo) | LEAD-OPTY, client-annotated           | [1rfmySN…](https://drive.google.com/file/d/1rfmySNKyhhNJnaV-2ULkGl0vUIf50Q7t/view) |

Elena's file is the more detailed and is treated as authoritative where the two disagree. Marco's carries the client's own annotations — the complete loss-reason picklists, the request to revive expired quotes, and the open questions on lead queue assignment.

## Scheduled checks

A cloud agent runs [`requirements-check`](.agents/skills/requirements-check/SKILL.md) automatically.

| Setting    | Value                                                                                                                             |
| ---------- | --------------------------------------------------------------------------------------------------------------------------------- |
| Routine    | **Nightly requirements-check**, `trig_01VCdUXmqy8PngWPJHA2dSYC`, created 2026-08-14                                               |
| Schedule   | **Monday–Friday at 23:30** Europe/Budapest — cron `30 21 * * 1-5` (UTC)                                                           |
| Model      | **Claude Opus 5** — set deliberately, matching the sister project. Do not let a later edit silently drop it to the Sonnet default |
| Branch     | `Calm-Coders/pienissimo`, **`DevMain`** — it **commits directly**, Aurel's explicit choice over a PR flow                         |
| Connectors | Slack · Gmail · Google Drive · Fathom                                                                                             |
| Manage     | <https://claude.ai/code/routines/trig_01VCdUXmqy8PngWPJHA2dSYC>                                                                   |

Full configuration, including the Slack-destination caveats: [docs/task-status.md](docs/task-status.md).

What it does each run:

- Reads the newest file in [`notes/traces/`](notes/traces/) as its watermark and sweeps only for material newer than that.
- **Finds nothing** → writes nothing and commits nothing. Quiet nights leave no commit, and the watermark is left where it was.
- **Finds something** → updates the affected notes, writes the next trace note, appends to [`JOURNAL.md`](JOURNAL.md), runs `npm run vault:check`, then commits to `DevMain`. **It commits only if that check passes**; on failure it commits nothing and leads its report with the failure.
- **Always, either way** → posts the report as a single Slack message to the **"pienissimo devs" group DM** (`C0BQD34LLF4` — Aurel Mrruku, Anita Aga, Sara Aga, Rexhina Hysi).

Apart from that one group-DM message it is **read-only everywhere**: the `requirements-check` skill carries exactly one carve-out for this post, in its Guardrails section. Do not widen it.

Two things to remember:

- 🔴 **DST — a one-line fix is due in late October.** The cron is fixed in UTC. Europe/Budapest leaves CEST on **25 October 2026**, after which `30 21` fires at **22:30 local, not 23:30**. That lands inside the go-live window. Change it to `30 22 * * 1-5` on or after that date.
- **Weekends are not covered.** Anything arriving Friday evening is picked up Monday night.

## Salesforce DX

Metadata lives in [force-app/main/default/](force-app/main/default/); scratch-org definitions in [config/](config/); project manifest in [sfdx-project.json](sfdx-project.json).

```
sf org login web            # authorize an org
sf project deploy start     # deploy metadata
sf project retrieve start   # retrieve metadata
sf apex run test            # run Apex tests
```
