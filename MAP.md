# MAP - Pienissimo

Entry point. Keep under 5 KB; if it grows, move detail into a note and link it.

Last updated: 2026-08-25 (org-status-check vs Pienissimo UAT) · Source of record: [notes/](notes/)

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
- **2026-08-25 org check vs Pienissimo UAT** — full gap table in
  [the tracker's org-verification block](meetings/open-items.md). Four findings
  change the plan: 🟢 the **tranche is built** (object + Quote-side UI, though
  the controller and LWC are org-only and untested —
  [OI-50](notes/items/OI-50%20Tranche%20object.md)); 🔴 **there is not one Flow
  in the org**, so every declarative automation designed since June is absent
  ([the flow](notes/flows/The%20quote%20to%20order%20flow.md)); 🔴
  `OrderItem.Tranche__c` is **committed but never deployed**, so propagation
  cannot run while `force-app/` reads as done
  ([risk](notes/risks/Risk%20-%20OrderItem%20Tranche%20is%20in%20the%20repository%20but%20not%20in%20the%20org.md));
  🔴 **37 tickets sit in states deleted on 6 August**, none ever reaching
  `Disponibile` ([OI-74](notes/items/OI-74%20Asset%20state%20machine.md)), while
  standard **Asset** carries zero custom fields.
- The repo still runs ahead of the trackers and the org still holds Apex the
  repo does not — [build ahead of the record](notes/objects/The%20build%20ahead%20of%20the%20record.md),
  [missing stack](notes/risks/Risk%20-%20the%20Biglietto%20Apex%20stack%20is%20not%20in%20source%20control.md).
- **Nothing can deploy today.** Apex coverage is **0%** against a 75% floor —
  measured 2026-08-25, 24 classes and triggers, 1028 uncovered lines, zero
  covered ([OI-64](notes/items/OI-64%20The%20bundle%20Apex%20test%20suite%20is%20broken.md),
  [OI-66](notes/items/OI-66%20No%20test%20classes%20for%20the%20Biglietto%20stack.md)).
  The suite is written as one task, requested separately before the deploy.
- 🟢 **2026-08-24: four meetings came out of the dark at once.** The 19 and
  20 Aug sessions **did run and are fully minuted** — recovered on 24 Aug from a
  canvas update and a forwarded mail, after three sweeps reported them missing.
  Two further ROMI-internal sessions ran on 24 Aug itself.
  [19 Aug MKT funnel](notes/meetings/2026-08-19%20Flussi%20MKT%20Biglietti.md) ·
  [20 Aug asset flow](notes/meetings/2026-08-20%20Flusso%20Asset%20Biglietti.md)
  (Elena's own minute, sent **to the client**, so it is the strongest evidence in
  the record) ·
  [24 Aug Lead/Opty](notes/meetings/2026-08-24%20Interna%20per%20update%20flusso%20Lead-Opty.md) ·
  [24 Aug Follow-up Interno](notes/meetings/2026-08-24%20Follow-up%20Interno.md).

- 🔴 **The biggest thing they carry is a design conflict, not a decision.** The
  client states that **Mexal article codes are transversal across years** and the
  **edition is determined by the order date, not by the product**. The built
  `Product2.Anno_Solare__c` picklist and its dependency matrix assume the
  opposite — so the question is no longer what values it needs but whether the
  field should exist ([OI-46](notes/items/OI-46%20Bundle%20classification%20picklists.md)).
  What carries the edition instead is
  [the campaign parent and child model](notes/objects/The%20campaign%20parent%20and%20child%20model.md)
  — Campagna Padre → Campagna Figlio → Campaign Member, agreed 20 Aug, configured
  24 Aug, **entirely unbuilt**.

- ✅ **Settled by these minutes:** ticket type is a **manually maintained
  Salesforce field owned by amministrazione**, because Mexal cannot carry a
  fourth classification ([OI-76](notes/items/OI-76%20Ticket%20type%20picklist%20on%20the%20product.md));
  the **tranche is created by hand on the Quote before the order**
  ([OI-50](notes/items/OI-50%20Tranche%20object.md)); ticket availability follows
  the tranche **and every tranche before it**
  ([OI-75](notes/items/OI-75%20Ticket%20availability%20rule.md)); the quote
  lifecycle is fully specified, picklist values included
  ([OI-59](notes/items/OI-59%20Quote%20workflow%20configuration.md)); the VAT
  provider is **Anticipay** ([OI-73](notes/items/OI-73%20VAT%20validation%20moves%20into%20Salesforce.md));
  the asset-flow review is done ([OI-82](notes/items/OI-82%20Asset%20flow%20needs%20a%20dedicated%20review.md)).

- 🔴 **Two contradictions a human must settle.** The 20 Aug minute told the
  **client** that "Da ricontattare" generates **no automatic task** (a banner
  instead); the 24 Aug internal session specified a validation rule, a trigger and
  reminder notifications on the same state
  ([OI-59](notes/items/OI-59%20Quote%20workflow%20configuration.md)). And the
  19 Aug minute states the asset-creation rule **two incompatible ways in the same
  document** ([OI-53](notes/items/OI-53%20Asset%20generation%20rule.md)).

- **Calendar: 25 Aug** Anticipay · **26 Aug** [ROMI-PIENISSIMO] Review Temi
  Integrazione Mexal (16:00–17:00 CEST, **client-facing** — Elena, Aurel, Andrea
  Di Cicco, amministrazione and Fabrizio Paganelli; first Mexal session since
  14 Jul) · **27 Aug** WooCommerce ·
  [PIENISSIMO] Follow-up Interno is now a **weekly Monday 17:00 slot**.
  [The compressed calendar](notes/risks/Risk%20-%20the%20whole%20remaining%20build%20lands%20after%20Ferragosto.md)
  still governs.

- **The design file moved a fourth time, on 24 Aug — and for the first time the
  edit is minuted.** [The master](notes/The%20newest%20design%20diagram.md)
  re-decoded at its 2026-08-24T16:34:34Z version now carries the campaign lookup
  rule, the full Lead/Opty validation spec **with the picklist values**, and
  `Anticipay`. Earlier unminuted edits stand: `Rinuncia` in the master
  ([OI-74](notes/items/OI-74%20Asset%20state%20machine.md) — the 19 Aug minute
  calls it a marketing tag, so diagram and minute now disagree); both order
  vocabularies side by side
  ([OI-69](notes/items/OI-69%20Order%20state%20model.md)); the client's own
  [DGM-1](notes/The%20client%20Lead-Opty%20diagram%20moved%20on%2020%20August.md)
  unmoved since 20 Aug.

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
   the [tranche](notes/items/OI-50%20Tranche%20object.md) **remainder**
   (object and Quote-side creation now built; propagation to Order Item,
   payment aggregation and tests are not),
   [participants](notes/items/OI-78%20Participant%20data%20collection.md),
   [WooCommerce](notes/items/OI-49%20WooCommerce%20checkout-link%20flow.md)
   (credentials 26 Aug),
   [VAT](notes/items/OI-73%20VAT%20validation%20moves%20into%20Salesforce.md)
   (**provider named 24 Aug: Anticipay**; contract and cost unknown), and now
   the whole
   [campaign parent/child model](notes/objects/The%20campaign%20parent%20and%20child%20model.md)
   — Record Types, the product lookup and the one-active-child rule, none of it
   built.
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
