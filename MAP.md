# MAP - Pienissimo

Entry point. Keep under 5 KB; if it grows, move detail into a note and link it.

Last updated: 2026-08-27 (nightly requirements-check — the WooCommerce sessions) · Source of record: [notes/](notes/)

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
- **2026-08-26 org check vs Pienissimo UAT** — supersedes the 25 Aug run; gap
  table in [the tracker's org-verification block](meetings/open-items.md).
  🟢 **The tranche stack is in source control** (PR #12, one day after deploy —
  [OI-50](notes/items/OI-50%20Tranche%20object.md)); only the Tranche layout is
  still org-only. 🟢 **`Quote.Status` carries the agreed lifecycle at last** —
  the first state machine to reach the org, though 3 of 4 quotes were left on
  deactivated stock values ([OI-59](notes/items/OI-59%20Quote%20workflow%20configuration.md)).
  🔴 **Correction: `OrderItem.Tranche__c` is deployed, not missing** — the
  25 Aug finding was a false negative, because `sf sobject describe` hides
  fields the running user cannot see and this one is granted to **nobody**
  ([risk](notes/risks/Risk%20-%20OrderItem%20Tranche%20is%20invisible%20to%20every%20user.md),
  [method](notes/How%20to%20read%20the%20org%20schema%20without%20a%20false%20negative.md)).
  Propagation still cannot run. 🔴 **Still not one Flow** — nor workflow rule,
  approval process, email template, notification or scheduled job
  ([the flow](notes/flows/The%20quote%20to%20order%20flow.md)). 🔴 **The
  integration scaffolding holds zero configuration rows**, so no outbound
  integration has an endpoint
  ([note](notes/objects/The%20integration%20scaffolding%20has%20never%20been%20configured.md)).
  🔴 **37 tickets still parked in states deleted on 6 August**
  ([OI-74](notes/items/OI-74%20Asset%20state%20machine.md)); **Asset** still has
  zero custom fields; coverage **0%**, 1069 uncovered lines.
- 🔴 **2026-08-25 — the Anticipay integration changed counterparty.** The
  technical call ran and agreed that **Salesforce will not call Anticipay**: it
  calls a **middleware built and hosted by Pienissimo Software Srl**, which
  caches lookups and returns a standard payload
  ([OI-94](notes/items/OI-94%20Anticipay%20is%20called%20through%20the%20Pienissimo%20middleware.md),
  [the session](notes/meetings/2026-08-25%20Integrazione%20Anticipay.md)). Token
  in the header, `404`/`500` error codes stored in Salesforce for three months
  and used for internal notifications, returned values overwrite Salesforce, and
  the payload is trimmed to fields **nobody has chosen yet**
  ([OI-95](notes/items/OI-95%20Which%20Anticipay%20fields%20land%20in%20Salesforce.md)).
  Nothing is buildable until Andrea Parmeggiani sends the payload example, owed
  by **4 September**; follow-up **1 September 10:00**.
  ⚠ **A Fase 1 integration now depends on the entity at the centre of
  [the phase 2 dispute](notes/risks/Risk%20-%20the%20phase%202%20scope%20dispute%20is%20unresolved.md)**
  — nobody in the session said so.

- 🔴 **2026-08-26 — the Mexal review ran, and the edition mechanism changed
  again.** First Mexal session since 14 July; full transcript, Gemini notes and
  recording all recovered
  ([the session](notes/meetings/2026-08-26%20Review%20Temi%20Integrazione%20Mexal.md)).
  **The event edition now comes from a hand-maintained Salesforce table** — one
  row per `article code × order-date window → edizione`, matched **per order
  line**, with a separate hand-entered event date for the no-show logic
  ([OI-96](notes/items/OI-96%20Edition%20mapping%20table%20on%20Salesforce.md)).
  🔴 **This kills the one-active-child-campaign rule** agreed 24 August — Elena
  Spini killed her own rule in session, because a bundle spanning two events
  cannot resolve to one active edition
  ([the campaign model](notes/objects/The%20campaign%20parent%20and%20child%20model.md)).
  🟢 **Mexal's three classification fields are assigned and tested on the wire** —
  `natura` → genera biglietto, `categoria statistica` → the event,
  `gruppo merceologico` → candidate for ticket type, plus `Gest. annullato` →
  product disabled ([the integration](notes/flows/The%20Mexal%20integration.md)).
  Values chosen at Pienissimo's direction on **31 August**.
  🔴 **Fabrizio Paganelli intends to close all ~1000 article codes and re-create
  them**, listini included
  ([OI-98](notes/items/OI-98%20The%20Mexal%20article%20registry%20is%20being%20re-created.md))
  — which makes `Prodotti e Bundle.xlsx`, the event list, the tier evidence and
  the 280 UAT products provisional, eleven days before Fase 1 development ends.
  🔴 **[OI-92](notes/items/OI-92%20Mexal%20Scadenziario%20as%20the%20trigger%20to%20reverse%20an%20asset.md)
  was the question this meeting existed to answer and was never asked** — the
  word *scadenziario* is not in the transcript. It now has no forum.
  Also: a **bundle twin needs its own article code**, not just a flag
  ([OI-48](notes/items/OI-48%20Bundle-only%20article%20codes.md)); **only listino 1
  is used**; **invoicing stays Mexal-driven for ~6 months**; and
  `tipo nazionalità` is a **mandatory, undocumented** five-way fiscal residence
  ([OI-97](notes/items/OI-97%20Fiscal%20residence%20on%20the%20customer%20registry.md)).
  🔴 **Mexal's coded-value dictionaries are unknown to ROMI** — Andrea Di Cicco on
  Slack the same evening: _"loro hanno dei valori che sono tipo per valuta:
  1,2,3,4 — che lato nostro non sappiamo"_, asked for by email and unanswered
  ([OI-99](notes/items/OI-99%20Customer%20registry%20deep%20mapping%20session.md),
  booked for **2 Sept** but titled for the article registry).

- 🟢 **2026-08-27 — the WooCommerce integration is settled and half of it is built.**
  Two client sessions the same day, both fully minuted
  ([design, 10:00](notes/meetings/2026-08-27%20Integrazione%20WooCommerce.md) ·
  [test, 16:00](notes/meetings/2026-08-27%20Test%20Integrazione%20WooCommerce.md)).
  **WooCommerce writes into Salesforce** — stock webhooks were evaluated live and
  **rejected**, and the mechanism is a **custom WooCommerce plugin on a PHP
  order-status action hook**
  ([the flow](notes/flows/The%20WooCommerce%20order%20integration.md), `INT-14`
  open → agreed). 🟢 **Sabatino Rinaldi built it between the two meetings** —
  v1.3, always active, HTTP 200 on the wire against the production shop, with a
  manual re-send button. 🔴 **`ORD-12` is corrected**: an order reaches Salesforce
  at **`in lavorazione` OR `completato`**, any payment method — not only
  COMPLETATO — so every line arrives paid. 🔴 **Carts are Funnel Kit funnels**, so
  the checkout link carries the **opportunity id alone** and the link generator
  needs no product pickers; the mu-plugin in the 31 July spec is superseded
  ([OI-49](notes/items/OI-49%20WooCommerce%20checkout-link%20flow.md)).
  🔴 **The owed credential reversed direction — ROMI now owes Pienissimo the
  Salesforce endpoint and token**
  ([OI-102](notes/items/OI-102%20Salesforce%20endpoint%20and%20token%20for%20the%20WooCommerce%20plugin.md)),
  and it blocks the integration tests set for the **week of 31 August**. Nothing
  of the Salesforce side exists.
  🔴 **Fabrizio Paganelli: the €8,900+ "vendita da palco" is untested**, and it
  triggers contract generation downstream
  ([OI-101](notes/items/OI-101%20Stage%20sales%20must%20be%20in%20the%20WooCommerce%20test%20set.md)).
  🔴 **Andrea Di Cicco's WooCommerce/Mexal field merge has no owner**
  ([OI-103](notes/items/OI-103%20WooCommerce%20and%20Mexal%20field%20overlap.md)).
  ⚠ The afternoon session had **two participants and no minute but Gemini's**, and
  it moved a **client-agreed VAT rule**: no P.IVA check on an inbound Woo order,
  validation stays on the Salesforce → Mexal leg
  ([OI-73](notes/items/OI-73%20VAT%20validation%20moves%20into%20Salesforce.md)).
  Restate it with Elisa Migliano.

- 🔴 **2026-08-27 — Lead conversion is failing in the Pienissimo partial
  sandbox.** Not from a meeting: a Salesforce error mail at 15:08Z reports
  `LeadConversionQueueable` throwing _"No such column 'Servizio_Interesse__c' on
  entity 'Lead'"_. **The repo's copy of that class does not select that field**,
  and the field's metadata **is** in `force-app/` — so the org runs a different
  version and the sandbox lacks a field the repository has
  ([the risk](notes/risks/Risk%20-%20LeadConversionQueueable%20is%20broken%20in%20the%20Pienissimo%20sandbox.md)).
  It blocks testing
  [OI-100](notes/items/OI-100%20Same%20lead%20email%20with%20different%20VAT%20during%20conversion.md).

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
  🟢 **26 Aug supplied the mechanism and makes this decidable:** the edition comes
  from [an order-date mapping table](notes/items/OI-96%20Edition%20mapping%20table%20on%20Salesforce.md),
  per order line — so `Anno_Solare__c`'s job now belongs elsewhere and dropping it
  costs one record. The container is still
  [the campaign parent and child model](notes/objects/The%20campaign%20parent%20and%20child%20model.md)
  — Campagna Padre → Campagna Figlio → Campaign Member, agreed 20 Aug, **entirely
  unbuilt** — but its one-active-child rule is dead.

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

- **Calendar: 25 Aug** Anticipay ✅ ran · **26 Aug** Review Temi
  Integrazione Mexal ✅ ran, 1h25m, fully minuted · **27 Aug** WooCommerce ✅ **two sessions ran**, both fully
  minuted · **w/c 31 Aug** WooCommerce integration tests on Salesforce, blocked on
  [OI-102](notes/items/OI-102%20Salesforce%20endpoint%20and%20token%20for%20the%20WooCommerce%20plugin.md)
  · **1 Sept 10:00** [ROMI-PIENISSIMO] Follow-up Integrazione Anticipay,
  client-facing · **2 Sept 10:00–11:30** [ROMI-PIENISSIMO] Follow-up Anagrafica
  Articoli, client-facing, **new — invited 26 Aug 16:40Z** ·
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
   a client change request nobody knew existed. ⚠ **And its shelf life is now short** —
   [OI-98](notes/items/OI-98%20The%20Mexal%20article%20registry%20is%20being%20re-created.md)
   re-creates the whole registry the workbook extracts. Still owed: the Zoho
   workbook
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
   (🟢 client side built 27 Aug; **the whole Salesforce side is unstarted** and
   waits on [OI-102](notes/items/OI-102%20Salesforce%20endpoint%20and%20token%20for%20the%20WooCommerce%20plugin.md)),
   [VAT](notes/items/OI-73%20VAT%20validation%20moves%20into%20Salesforce.md)
   (**architecture settled 25 Aug — via the Pienissimo middleware, not Anticipay
   directly**; no endpoint, schema, token or test environment yet), and now
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
