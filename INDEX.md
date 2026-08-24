# INDEX - Pienissimo

The router. One line per readable artifact, with its approximate read cost, so
any agent can budget before opening anything. Start at [MAP.md](MAP.md).

Costs are approximate tokens (~4 characters per token). **Cheap** = load freely.
**Costly** = justify it. **Never** = do not load whole; grep instead.

91 notes, per `npm run vault:check`. Item ids are the tracker's own row numbers —
`#75` is `OI-75`.

## Cheap — load freely

| Cost  | File                                                                                 | What it answers                          |
| ----- | ------------------------------------------------------------------------------------ | ---------------------------------------- |
| ~1.1k | [MAP.md](MAP.md)                                                                     | Current state, what is blocked, who owns |
| ~1.3k | [INDEX.md](INDEX.md)                                                                 | This router                              |
| ~1.2k | [notes/Retrieval and write protocol.md](notes/Retrieval%20and%20write%20protocol.md) | How to read and write knowledge here     |
| ~1.6k | [AGENTS.md](AGENTS.md)                                                               | Rules for every agent                    |
| ~0.4k | any single note in [notes/](notes/)                                                  | One fact each — listed below             |

### What is actually built

| Note                                                                                      | Status                               |
| ----------------------------------------------------------------------------------------- | ------------------------------------ |
| [The build ahead of the record](notes/objects/The%20build%20ahead%20of%20the%20record.md) | **read this before any build claim** |
| [The BundleComponent junction](notes/objects/The%20BundleComponent%20junction.md)         | built, approved, in source control   |
| [The Biglietto build](notes/objects/The%20Biglietto%20build.md)                           | built, partly outside source control |

### Flows

| Note                                                                      | Status                        |
| ------------------------------------------------------------------------- | ----------------------------- |
| [The ticket lifecycle](notes/flows/The%20ticket%20lifecycle.md)           | designed 06/08, never run     |
| [The quote to order flow](notes/flows/The%20quote%20to%20order%20flow.md) | designed 06/08, build pending |
| [The Mexal integration](notes/flows/The%20Mexal%20integration.md)         | unblocked, in build           |

### Risks

| Note                                                                                                                                                         | Severity          |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------ | ----------------- |
| [Production deploy is blocked by Apex coverage](notes/risks/Risk%20-%20production%20deploy%20is%20blocked%20by%20Apex%20coverage.md)                         | high              |
| [The Biglietto Apex stack is not in source control](notes/risks/Risk%20-%20the%20Biglietto%20Apex%20stack%20is%20not%20in%20source%20control.md)             | high              |
| [The whole remaining build lands after Ferragosto](notes/risks/Risk%20-%20the%20whole%20remaining%20build%20lands%20after%20Ferragosto.md)                   | high              |
| [The ticket lifecycle has never run end to end](notes/risks/Risk%20-%20the%20ticket%20lifecycle%20has%20never%20run%20end%20to%20end.md)                     | high              |
| [The phase 2 scope dispute is unresolved](notes/risks/Risk%20-%20the%20phase%202%20scope%20dispute%20is%20unresolved.md)                                     | high              |
| [Placeholder prices could reach the client](notes/risks/Risk%20-%20placeholder%20prices%20could%20reach%20the%20client.md)                                   | high              |
| [The Biglietto object diverged from the approved proposal](notes/risks/Risk%20-%20the%20Biglietto%20object%20diverged%20from%20the%20approved%20proposal.md) | medium            |
| [No coherence control on bundle composition](notes/risks/Risk%20-%20no%20coherence%20control%20on%20bundle%20composition.md)                                 | medium (accepted) |

### Open items — gating first

| Note                                                                                                                                                        | Status                                             | Owner            |
| ----------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------- | ---------------- |
| [OI-64 bundle Apex suite broken](notes/items/OI-64%20The%20bundle%20Apex%20test%20suite%20is%20broken.md)                                                   | open · gating                                      | Aurel Mrruku     |
| [OI-66 no tests on the Biglietto stack](notes/items/OI-66%20No%20test%20classes%20for%20the%20Biglietto%20stack.md)                                         | open · gating                                      | ROMI             |
| [OI-50 tranche object](notes/items/OI-50%20Tranche%20object.md)                                                                                             | open · gating                                      | ROMI             |
| [OI-24 data model workbook](notes/items/OI-24%20Data%20model%20workbook.md)                                                                                 | open · gating                                      | Sabatino Rinaldi |
| [OI-79 migration volumes and mapping](notes/items/OI-79%20Migration%20volumes%20and%20mapping%20method.md)                                                  | open · gating                                      | Elisa Migliano   |
| [OI-88 Zoho import template](notes/items/OI-88%20Zoho%20import%20template%20owed%20to%20Pienissimo.md)                                                      | open · gating                                      | **ROMI**         |
| [OI-89 BigliettoPdfQueueable callout error](notes/items/OI-89%20BigliettoPdfQueueable%20callout%20error.md)                                                 | open                                               | ROMI             |
| [OI-90 whether to introduce a Prospect state](notes/items/OI-90%20Whether%20to%20introduce%20a%20Prospect%20state.md)                                       | open · 2 months silent                             | Sabatino Rinaldi |
| [OI-91 Aggiornamento Incasso button](notes/items/OI-91%20Aggiornamento%20Incasso%20button.md)                                                               | open · new 19 Aug · reverses the state machine     | ROMI             |
| [OI-92 Mexal Scadenziario as the trigger to reverse an asset](notes/items/OI-92%20Mexal%20Scadenziario%20as%20the%20trigger%20to%20reverse%20an%20asset.md) | open · new 20 Aug · due at the 26 Aug Mexal review | Andrea Di Cicco  |
| [OI-04 scope against the go-live date](notes/items/OI-04%20Scope%20against%20the%20go-live%20date.md)                                                       | open · gating                                      | Elena Spini      |

### Open items — client inputs owed

| Note                                                                                                      | Owner              |
| --------------------------------------------------------------------------------------------------------- | ------------------ |
| [OI-87 real catalogue prices](notes/items/OI-87%20Real%20catalogue%20prices%20still%20outstanding.md)     | Fabrizio Paganelli |
| [OI-42 UAT prices are placeholders](notes/items/OI-42%20List%20prices%20in%20UAT%20are%20placeholders.md) | Fabrizio Paganelli |
| [OI-46 bundle classification picklists](notes/items/OI-46%20Bundle%20classification%20picklists.md)       | Fabrizio Paganelli |
| [OI-48 bundle-only article codes](notes/items/OI-48%20Bundle-only%20article%20codes.md)                   | Fabrizio Paganelli |
| [OI-76 ticket type picklist](notes/items/OI-76%20Ticket%20type%20picklist%20on%20the%20product.md)        | Fabrizio Paganelli |
| [OI-59 quote workflow configuration](notes/items/OI-59%20Quote%20workflow%20configuration.md)             | Marco Montesi      |
| [OI-80 lead routing queues](notes/items/OI-80%20Lead%20routing%20queues.md)                               | Marco Montesi      |
| [OI-14 marketing forms and subdomain](notes/items/OI-14%20Marketing%20forms%20and%20subdomain.md)         | Fabrizio Mastracci |

### Open items — designed on 2026-08-06, build pending

| Note                                                                                                          |
| ------------------------------------------------------------------------------------------------------------- |
| [OI-68 quote acceptance landing page](notes/items/OI-68%20Quote%20acceptance%20landing%20page.md)             |
| [OI-69 order state model](notes/items/OI-69%20Order%20state%20model.md)                                       |
| [OI-74 asset state machine](notes/items/OI-74%20Asset%20state%20machine.md)                                   |
| [OI-75 ticket availability rule](notes/items/OI-75%20Ticket%20availability%20rule.md)                         |
| [OI-78 participant data collection](notes/items/OI-78%20Participant%20data%20collection.md)                   |
| [OI-73 VAT validation into Salesforce](notes/items/OI-73%20VAT%20validation%20moves%20into%20Salesforce.md)   |
| [OI-71 service start date](notes/items/OI-71%20Service%20start%20date%20owned%20by%20the%20Strategist.md)     |
| [OI-70 Performance Plus opportunity typing](notes/items/OI-70%20Performance%20Plus%20opportunity%20typing.md) |
| [OI-72 Partita IVA on lead forms](notes/items/OI-72%20Partita%20IVA%20mandatory%20on%20lead%20forms.md)       |

### Open items — everything else

| Note                                                                                                                                       |
| ------------------------------------------------------------------------------------------------------------------------------------------ |
| [OI-13 bundle estimate and client demo](notes/items/OI-13%20Bundle%20effort%20estimate%20and%20client%20demo.md)                           |
| [OI-29 accounts for free tour tickets](notes/items/OI-29%20Account%20creation%20policy%20for%20free%20tour%20tickets.md)                   |
| [OI-37 e-commerce parallel flow](notes/items/OI-37%20E-commerce%20parallel%20flow%20build.md) · **disputed scope**                         |
| [OI-38 Salesforce to Zoho for Pienissimo Pro](notes/items/OI-38%20Salesforce%20to%20Zoho%20for%20Pienissimo%20Pro.md) · **disputed scope** |
| [OI-41 asset and ticket data model](notes/items/OI-41%20Asset%20and%20ticket%20data%20model.md) · resolved 24 Aug — standard Asset         |
| [OI-43 spread variance does not block saving](notes/items/OI-43%20Spread%20variance%20does%20not%20block%20saving.md)                      |
| [OI-44 delete the deprecated bundle fields](notes/items/OI-44%20Delete%20the%20deprecated%20bundle%20fields.md)                            |
| [OI-47 product flags at import](notes/items/OI-47%20Product%20flags%20at%20import.md)                                                      |
| [OI-49 WooCommerce checkout-link flow](notes/items/OI-49%20WooCommerce%20checkout-link%20flow.md)                                          |
| [OI-51 contract auto-generation](notes/items/OI-51%20Contract%20auto-generation%20keyed%20to%20product%20code.md)                          |
| [OI-52 two scheduled reports](notes/items/OI-52%20Two%20scheduled%20reports.md)                                                            |
| [OI-53 asset generation rule](notes/items/OI-53%20Asset%20generation%20rule.md)                                                            |
| [OI-54 credit note flow](notes/items/OI-54%20Credit%20note%20flow.md)                                                                      |
| [OI-55 bundle composition control](notes/items/OI-55%20No%20coherence%20control%20on%20bundle%20composition.md) · resolved by decision     |
| [OI-57 zero-euro orders](notes/items/OI-57%20Zero-euro%20orders%20stay%20in%20the%20CRM.md)                                                |
| [OI-58 Mexal integration mechanics](notes/items/OI-58%20Mexal%20integration%20mechanics.md)                                                |
| [OI-65 ACADEMY 2026 does not reconcile](notes/items/OI-65%20ACADEMY%202026%20no%20longer%20reconciles.md)                                  |
| [OI-67 products with no code](notes/items/OI-67%20Products%20with%20no%20code.md)                                                          |
| [OI-77 Mexal event product creates the Campaign](notes/items/OI-77%20Mexal%20event%20product%20creates%20the%20Campaign.md)                |
| [OI-81 event communication funnel](notes/items/OI-81%20Event%20communication%20funnel.md)                                                  |
| [OI-82 asset flow needs a review](notes/items/OI-82%20Asset%20flow%20needs%20a%20dedicated%20review.md)                                    |
| [OI-83 no phase 2 estimate](notes/items/OI-83%20No%20phase%202%20estimate.md)                                                              |
| [OI-84 Campaign Member on manual check-in](notes/items/OI-84%20Campaign%20Member%20handling%20for%20manual%20check-in.md)                  |
| [OI-85 order state set may be incomplete](notes/items/OI-85%20Order%20state%20set%20may%20be%20incomplete.md)                              |
| [OI-86 who hosts the participant landing page](notes/items/OI-86%20Who%20hosts%20the%20participant%20landing%20page.md)                    |

### People

| Note                                                                                                                          | Org        |
| ----------------------------------------------------------------------------------------------------------------------------- | ---------- |
| [Daniela Morgese — direction, decides](notes/people/Daniela%20Morgese%20-%20Pienissimo%20direction.md)                        | Pienissimo |
| [Sabatino Rinaldi — project lead](notes/people/Sabatino%20Rinaldi%20-%20Pienissimo%20project%20lead.md)                       | Pienissimo |
| [Elisa Migliano — administration](notes/people/Elisa%20Migliano%20-%20Pienissimo%20administration.md)                         | Pienissimo |
| [Fabrizio Paganelli — product and registry](notes/people/Fabrizio%20Paganelli%20-%20Pienissimo%20product%20and%20registry.md) | Pienissimo |
| [Marco Montesi — sales](notes/people/Marco%20Montesi%20-%20Pienissimo%20sales.md)                                             | Pienissimo |
| [Rebecca Marmo — marketing](notes/people/Rebecca%20Marmo%20-%20Pienissimo%20marketing.md)                                     | Pienissimo |
| [Elena Spini — project manager](notes/people/Elena%20Spini%20-%20project%20manager%20ROMI.md)                                 | ROMI       |
| [Aurel Mrruku — technical lead](notes/people/Aurel%20Mrruku%20-%20technical%20lead%20ROMI.md)                                 | ROMI       |
| [Andrea Di Cicco — solution architect](notes/people/Andrea%20Di%20Cicco%20-%20solution%20architect%20ROMI.md)                 | ROMI       |
| [Anita Aga — developer](notes/people/Anita%20Aga%20-%20Salesforce%20developer%20ROMI.md)                                      | ROMI       |
| [Sara Aga — developer](notes/people/Sara%20Aga%20-%20Salesforce%20developer%20ROMI.md)                                        | ROMI       |
| [Rexhina Hysi — developer](notes/people/Rexhina%20Hysi%20-%20Salesforce%20developer%20ROMI.md)                                | ROMI       |

### Reference

| Note                                                                                                                                            | What it holds                                                                                                                                                    |
| ----------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [Source trace 2026-08-20](notes/traces/Source%20trace%202026-08-20.md)                                                                          | **Watermark for the next `requirements-check` run** — 2026-08-20 · both design diagrams moved, master re-decoded                                                 |
| [Source trace 2026-08-19](notes/traces/Source%20trace%202026-08-19.md)                                                                          | Previous watermark — 2026-08-19 · the 19 Aug ticket flow diagram                                                                                                 |
| [Source trace 2026-08-18](notes/traces/Source%20trace%202026-08-18.md)                                                                          | Previous watermark — 2026-08-18 · the 07 Aug attachment surfaced                                                                                                 |
| [Source trace 2026-08-14 external sweep](notes/traces/Source%20trace%202026-08-14%20external%20sweep.md)                                        | The previous external watermark — 2026-08-14                                                                                                                     |
| [Source trace 2026-08-14](notes/traces/Source%20trace%202026-08-14.md)                                                                          | Superseded — repository read only, moved no external watermark                                                                                                   |
| [The Prodotti e Bundle workbook](notes/The%20Prodotti%20e%20Bundle%20workbook.md)                                                               | Fabrizio Paganelli's 07 Aug attachment — **read 24 Aug**; the decode. Prices stay in the file                                                                    |
| [The Notion mirror of the project status](notes/The%20Notion%20mirror%20of%20the%20project%20status.md)                                         | Page ids and sharing rules for the invite-only mirror of STATUS.md                                                                                               |
| [The article code namespace](notes/objects/The%20article%20code%20namespace.md)                                                                 | `CS` / `BLO-` / `PACK-`, three code shapes, meaning buried in the name string                                                                                    |
| [A bundle is two levels deep](notes/objects/A%20bundle%20is%20two%20levels%20deep.md)                                                           | PACK -> BLOCCO -> article; the blocco is the client's tranche                                                                                                    |
| [Risk - normalising an article code merges two products](notes/risks/Risk%20-%20normalising%20an%20article%20code%20merges%20two%20products.md) | `_ARCOD` is opaque; two pairs differ by one zero or one dash                                                                                                     |
| [OI-93 Bundle components should be priced articles](notes/items/OI-93%20Bundle%20components%20should%20be%20priced%20articles.md)               | Client change request found in the workbook, 17 days unread                                                                                                      |
| [The requirement mappings were fabricated](notes/The%20requirement%20mappings%20were%20fabricated.md)                                           | **Read before trusting any note-to-requirement link** — the 23 discarded claims, and what to re-derive                                                           |
| [The newest design diagram](notes/The%20newest%20design%20diagram.md)                                                                           | **Authority for state machines** · re-decoded 20 Aug at its 20/08 15:36Z version — `Rinuncia` folded into the master, order states drawn but old ones not struck |
| [The ticket flow diagram of 19 August](notes/The%20ticket%20flow%20diagram%20of%2019%20August.md)                                               | New standalone `Flusso Biglietti.drawio` — `Rinuncia` as a 7th state, OI-91, unminuted                                                                           |
| [The client Lead-Opty diagram moved on 20 August](notes/The%20client%20Lead-Opty%20diagram%20moved%20on%2020%20August.md)                       | `DGM-1`, Marco Montesi's own copy — moved 68 min before the master, both unminuted                                                                               |
| [The client June requirements document](notes/The%20client%20June%20requirements%20document.md)                                                 | Pienissimo's own 11 June requirements — earliest structured statement of scope                                                                                   |
| [Calm-Coders means ROMI](notes/Calm-Coders%20on%20GitHub%20means%20ROMI.md)                                                                     | Attributing git authors to the right org                                                                                                                         |
| [Integration Configuration is standard scaffolding](notes/Integration%20Configuration%20is%20standard%20ROMI%20scaffolding.md)                  | House pattern, not a project requirement — do not re-flag                                                                                                        |
| [Retrieval and write protocol](notes/Retrieval%20and%20write%20protocol.md)                                                                     | How to read and write knowledge here                                                                                                                             |
| [JOURNAL.md](JOURNAL.md)                                                                                                                        | Cross-tool session handoffs, newest first                                                                                                                        |
| [docs/task-status.md](docs/task-status.md)                                                                                                      | **ROMI-internal action board** — not the client tracker, no `OI-NN`                                                                                              |
| [docs/publishing.md](docs/publishing.md)                                                                                                        | What may be published, and the leak check                                                                                                                        |

## Querying without reading

Frontmatter is grep-able. Use this instead of loading notes to find candidates:

```bash
rg -l "^status: open"      notes/items/   # every open item
rg -l "^severity: gating"  notes/         # what blocks go-live
rg -l "^owner: Aurel"      notes/         # everything Aurel owns
rg "^blocks:|^depends_on:" notes/items/   # the dependency graph
rg -l "^uncertain:"        notes/         # what is explicitly unverified
```

## Costly — justify before loading

| Cost  | File                                                                                                         | When it is worth it                                        |
| ----- | ------------------------------------------------------------------------------------------------------------ | ---------------------------------------------------------- |
| ~14k  | [requirements/pienissimo-requirements.yaml](requirements/pienissimo-requirements.yaml)                       | **Authority for requirement ids** — grep it, don't load it |
| ~8k   | [meetings/results/2026-08-06-chiusura-punti-aperti.md](meetings/results/2026-08-06-chiusura-punti-aperti.md) | The decisive session, in full                              |
| ~4-5k | [meetings/proposals/](meetings/proposals/)                                                                   | The asset data model or the bundle demo                    |
| ~2k   | [README.md](README.md)                                                                                       | Published artifacts and the design diagrams                |
| ~1-3k | other files in [meetings/results/](meetings/results/)                                                        | A specific earlier meeting                                 |

## Never — grep, do not load

| Cost      | Pattern                               | Instead                                           |
| --------- | ------------------------------------- | ------------------------------------------------- |
| ~207k     | `meetings/*-transcript.it.md`         | `rg "term" meetings/`, then read that line range  |
| ~56k/~50k | `meetings/open-items.it.md` / `.md`   | Read `notes/items/`                               |
| ~21k/~20k | `REQUISITI.it.md` / `REQUIREMENTS.md` | `rg` for the requirement id                       |
| ~20k/~18k | `meetings/DEVELOPMENT-RECAP*.md`      | Read the relevant notes                           |
| binary    | `anar_PIE_ricla.xlsx`                 | The decode is in the notes                        |
| binary    | `Prodotti e Bundle.xlsx`              | ⚠ carries real prices; the decode is in the notes |
| huge      | `node_modules/**`, `.sf/`, `.sfdx/`   | Generated                                         |

`force-app/**` is **not** on this list — the org-vs-repository gap matters here.
Glob or grep for the specific file; do not walk the tree.

Italian `.it.md` twins exist for the trackers and the recap. They are
client-facing deliverables — read the English for facts. But
[REQUISITI.it.md](REQUISITI.it.md) is the text presented for **signature**, so
for agreed wording the Italian governs.
