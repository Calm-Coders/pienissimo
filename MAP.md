# MAP - Pienissimo

Entry point. Keep under 5 KB; if it grows, move detail into a note and link it.

Last updated: 2026-08-24 · Source of record: [notes/](notes/)

## Where the project stands

ROMI is migrating Pienissimo from **Zoho CRM to Salesforce**. Zoho expires
**31 October 2026**; go-live Fase 1 is **6 October**, Fase 2 **9 November**;
data import ~1 Sept. Requirements went to sign-off on 2026-08-06.

- 🔴 **Development on Fase 1 must end 10 September**, per ROMI's own project
  plan — not 6 October, which is go-live. With the team back ~24–26 August that
  is **two weeks of build** for everything below.

- **2026-08-06 settled the last open designs** — DocuSign in for
  quotes/contracts, out for tickets; order states
  `Ordinato → Fatturato → Incassato`; the
  [ticket lifecycle](notes/flows/The%20ticket%20lifecycle.md).
- **2026-08-24 settled the ticket object:** the target is the standard
  Salesforce **Asset**. [OI-41](notes/items/OI-41%20Asset%20and%20ticket%20data%20model.md)
  is resolved, but UAT still runs on custom `Biglietto__c`; mapping and migration
  are unbuilt and unestimated.
- **The repo is a week ahead of every tracker**, and the org holds Apex the repo
  does not — [build ahead of the record](notes/objects/The%20build%20ahead%20of%20the%20record.md),
  [missing stack](notes/risks/Risk%20-%20the%20Biglietto%20Apex%20stack%20is%20not%20in%20source%20control.md).
- **Nothing can deploy today.** Apex coverage is **1%** against a 75% floor —
  [OI-64](notes/items/OI-64%20The%20bundle%20Apex%20test%20suite%20is%20broken.md),
  [OI-66](notes/items/OI-66%20No%20test%20classes%20for%20the%20Biglietto%20stack.md).
  The suite is written as one task, requested separately before the deploy.
- **Restart: 19 Aug** marketing · **20 Aug** asset flow (Elisa) · **24 Aug**
  internal Lead/Opty update (Elena + Aurel, 16:00 CEST) · **25 Aug** Anticipay ·
  **26 Aug** [ROMI-PIENISSIMO] Review Temi Integrazione Mexal (16:00–17:00 CEST,
  **client-facing** — Elena, Aurel, Andrea Di Cicco, amministrazione and
  Fabrizio Paganelli; first Mexal session since 14 Jul) · **27 Aug**
  WooCommerce. Several are design discovery, not build —
  [the compressed calendar](notes/risks/Risk%20-%20the%20whole%20remaining%20build%20lands%20after%20Ferragosto.md).
  ⚠ **The 19 and 20 Aug sessions left no minute of any kind** — only diagram
  edits. If they ran, nothing records what was agreed.

- 🔴 **The design moved three times in two days; none of it is minuted.** On
  20 Aug **both register source diagrams moved 68 minutes apart** — the client's
  ([Marco Montesi](notes/The%20client%20Lead-Opty%20diagram%20moved%20on%2020%20August.md))
  and ROMI's [master](notes/The%20newest%20design%20diagram.md), now re-decoded,
  after [the 19 Aug ticket flow](notes/The%20ticket%20flow%20diagram%20of%2019%20August.md).
  `Rinuncia` is now **in the master**, so the seventh asset state sits in the
  file the register is validated against ([OI-74](notes/items/OI-74%20Asset%20state%20machine.md));
  the 06 Aug order states are drawn **alongside** the old ones rather than
  replacing them ([OI-69](notes/items/OI-69%20Order%20state%20model.md)); a tier
  became `Dinamond` where the minute says `Silver` — **both settled 24 Aug: the
  registry's tiers are `EXECUTIVE`/`GOLD`/`DIAMOND` and neither contested value
  exists** ([OI-76](notes/items/OI-76%20Ticket%20type%20picklist%20on%20the%20product.md),
  still open because the field does not exist);
  and a new question asks whether an **unpaid** Mexal invoice can reverse an
  asset ([OI-92](notes/items/OI-92%20Mexal%20Scadenziario%20as%20the%20trigger%20to%20reverse%20an%20asset.md),
  due at the 26 Aug client Mexal review). **Nothing was reconfigured.**

## The live chain

1. **Deployability** — the two coverage items above gate every other, and are
   handled as one late task on Aurel's request.
2. **Client inputs owed** — 🟢 **the biggest one landed and was read on 24 Aug.**
   [`Prodotti e Bundle.xlsx`](notes/The%20Prodotti%20e%20Bundle%20workbook.md),
   sent 7 Aug and unopened for seventeen days, delivered **real catalogue
   prices** ([OI-87](notes/items/OI-87%20Real%20catalogue%20prices%20still%20outstanding.md)
   resolved), the **event list**
   ([OI-46](notes/items/OI-46%20Bundle%20classification%20picklists.md)) and a
   **worked bundle** ([OI-48](notes/items/OI-48%20Bundle-only%20article%20codes.md)).
   A copy is now in the repository root. 🔴 **It broke more than it closed** —
   the built `Product2.Evento__c` picklist is wrong against the client's own
   list (**no `Happy Team` value**, though Happy Team is priced and sits in the
   Academy bundle at quantity 2), and the `Anno_Solare__c` dependency matrix has
   **no client source at all**. New:
   [OI-93](notes/items/OI-93%20Bundle%20components%20should%20be%20priced%20articles.md),
   a client change request nobody knew existed. Still owed: the Zoho workbook
   ([OI-24](notes/items/OI-24%20Data%20model%20workbook.md)), and ROMI owes the
   [import template](notes/items/OI-88%20Zoho%20import%20template%20owed%20to%20Pienissimo.md)
   — both must carry the rule that
   [`_ARCOD` is an opaque string](notes/risks/Risk%20-%20normalising%20an%20article%20code%20merges%20two%20products.md).
3. **Dated but unbuilt** — the
   [standard Asset migration](notes/risks/Risk%20-%20the%20Biglietto%20object%20diverged%20from%20the%20approved%20proposal.md),
   [tranche](notes/items/OI-50%20Tranche%20object.md)
   (creation in the Quote decided by Aurel 24 Aug; nothing exists),
   [participants](notes/items/OI-78%20Participant%20data%20collection.md),
   [WooCommerce](notes/items/OI-49%20WooCommerce%20checkout-link%20flow.md)
   (credentials 26 Aug),
   [VAT](notes/items/OI-73%20VAT%20validation%20moves%20into%20Salesforce.md)
   (provider unconfirmed).
4. **Commercial** — the
   [phase 2 dispute](notes/risks/Risk%20-%20the%20phase%202%20scope%20dispute%20is%20unresolved.md)
   has run four meetings, and
   [OI-83](notes/items/OI-83%20No%20phase%202%20estimate.md) records that the
   decision-maker was never told.

## Map of the territory

| Area                           | Start here                                                                                                                               |
| ------------------------------ | ---------------------------------------------------------------------------------------------------------------------------------------- |
| Everything, indexed            | [INDEX.md](INDEX.md)                                                                                                                     |
| How to read/write              | [notes/Retrieval and write protocol.md](notes/Retrieval%20and%20write%20protocol.md)                                                     |
| Requirement ids                | [requirements/pienissimo-requirements.yaml](requirements/pienissimo-requirements.yaml)                                                   |
| Items · built · people · risks | [items](notes/items/) · [objects](notes/objects/) · [people](notes/people/) · [risks](notes/risks/)                                      |
| **What to do next**            | **[docs/task-status.md](docs/task-status.md)** — ROMI action board                                                                       |
| Status for humans              | **[STATUS.md](STATUS.md)** — ROMI internal · [Notion mirror](notes/The%20Notion%20mirror%20of%20the%20project%20status.md) (invite-only) |
| Session handoffs               | [JOURNAL.md](JOURNAL.md)                                                                                                                 |
| Publishing rules               | [docs/publishing.md](docs/publishing.md)                                                                                                 |

## Standing constraints

- **Daniela Morgese** decides and signs commercially; **Sabatino Rinaldi** leads
  day-to-day; **Elisa Migliano** is the operational authority on administration,
  invoicing and the infopoint; **Fabrizio Paganelli** owns the product registry;
  **Marco Montesi** sales. **Elena Spini** chairs for ROMI, **Aurel Mrruku** is
  technical lead. Full list: [notes/people/](notes/people/).
- **The build is written by the Calm-Coders team working for ROMI.** Their work
  lands in the repository ahead of the trackers — check `git log` and
  `force-app/` before calling something unbuilt.
- **Never show placeholder prices to Pienissimo** — every catalogue price in UAT
  is a ROMI invention tagged `[PLACEHOLDER …]`.
- Requirements have two governing texts: `REQUISITI.it.md` is presented for
  signature, `REQUIREMENTS.md` mirrors it. Facts in English, agreed wording in
  Italian.
- The repository is private. [site/](site/) is public and must stay sanitized.
