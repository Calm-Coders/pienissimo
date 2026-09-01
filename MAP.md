# MAP - Pienissimo

Entry point. Keep under 5 KB; if it grows, move detail into a note and link it.

Last updated: 2026-09-01 (the Anticipay API doc was downloaded and drilled) · Source of record: [notes/](notes/)

## Where the project stands

ROMI is migrating Pienissimo from **Zoho CRM to Salesforce**. Zoho expires
**31 October 2026**; go-live Fase 1 is **6 October**, Fase 2 **9 November**;
data import ~1 Sept. Requirements went to sign-off on 2026-08-06.

- 🔴 **Development on Fase 1 must end 10 September**, per ROMI's own project
  plan — not 6 October, which is go-live. With the team back ~24–26 August that
  is **two weeks of build** for everything below.

- 🔴🔴 **2026-08-31 — `Biglietto__c` was deleted from the org with all 37 records,
  and seven Apex components went with it that were never in source control.**
  Found by an org check at 09:36–09:52Z that, for the **second run in a row**,
  **published nothing**. The deletion was deliberate — commit `5d8cdb3`
  (Anita Aga, 28 Aug 18:10 CEST) carries a destructive-changes manifest — but
  **nothing anywhere says an export was taken first**.
  🔴 **The records were not migrated**: Asset went 4 → 5, not 4 → 41
  ([the dataset risk](notes/risks/Risk%20-%20the%20Biglietto%20UAT%20ticket%20dataset%20was%20deleted.md)).
  Recycle-bin recovery is ~15 days, so the window closes about **12 September** —
  **the only finding in this file that decays if nobody acts.**
  🔴 **The code is worse and is not recoverable the same way.** `git log --all`
  proves not one of `BigliettoTriggerHandler`, `BigliettoDocuSignService`,
  `BigliettoDocuSignQueueable`, `BigliettoPdfService`, `BigliettoPdfQueueable`,
  `BigliettoPdfBatch`, `BigliettoTrigger` or `BigliettoPdf` **ever existed in
  this repository on any branch** — ~270 lines of the DocuSign and PDF stack,
  which had demonstrably run (19 of the 37 records carried an envelope id), gone
  from its only copy. The org check called this "drift resolved by deletion from
  both sides"; **there were never two sides**
  ([the code risk](notes/risks/Risk%20-%20the%20Biglietto%20Apex%20stack%20is%20not%20in%20source%20control.md)).
  ⚠ The project now has **neither** ticket implementation — the old one removed,
  standard Asset unbuilt — eleven days before Fase 1 development ends.
  🔴 **The same pattern is live again**: the deployed WooCommerce class
  `WoocommerceOrderService` (23,087 chars, modified 31 Aug, taking real traffic)
  **is not in source control**, while the repo's unshipped
  `WooCommerceOrderEndpoint` claims the same `urlMapping` — so a clean deploy
  would publish a second class on a live route and orphan the working one
  ([the deploy risk](notes/risks/Risk%20-%20a%20clean%20deploy%20would%20orphan%20the%20live%20WooCommerce%20endpoint.md)).
  Also 31 Aug: the **duplicate-order contract changed silently** from `409` to
  `200 + duplicate: true`, and Sabatino Rinaldi has not been told
  ([OI-104](notes/items/OI-104%20The%20WooCommerce%20payload%20has%20no%20idempotency%20key.md));
  `INT-16` **survived a full rewrite still unauthenticated**
  ([OI-102](notes/items/OI-102%20Salesforce%20endpoint%20and%20token%20for%20the%20WooCommerce%20plugin.md));
  coverage **0% of 1,571 lines across 21 classes** — the fall from 1,769 is
  **only** the deleted code, no test was written; a **half-deployed bundle-price
  feature silently shows the spread total** instead of the calculated price; and
  the register's `build_state` cites **`QUO-01` and `QUO-06`, which are not among
  the 154 requirement ids**.

- 🟢 **2026-08-31 → 09-01 — the Anticipay API contract arrived early, and has now
  been read.** Andrea Parmeggiani sent `Documentazione API - Salesforce.pdf` at
  31 Aug 16:15Z — owed by **4 September**, the first client commitment on this
  project met ahead of its date — then **a second version at 1 Sep 10:46Z**
  adding a `:env` path parameter (`test` | `prod`). Downloaded by hand and
  drilled the same morning:
  [the contract](notes/The%20Anticipay%20middleware%20API%20contract.md).
  `GET https://integration.pienissimo.com/salesforce/account/:env/:piva`, bearer
  token in the header, **eleven response fields**, four error codes.
  🟢 **The eleven fields exactly match the as-is Mexal lookup** Elisa Migliano
  described on 6 August, so accuracy is a known quantity — and the **reliability
  score Fabrizio Paganelli asked for is not among them.**
  🔴 **The real blocker is in ROMI's own code, not in the document.** The house
  `API_Callout_Engine` **cannot pass a path parameter at all** — for a `GET` it
  discards the caller's argument, and `Endpoint_Path__c` is a static custom-setting
  field — so `:piva`, which changes on every call, has nowhere to go. Either the
  shared engine gets extended or Anticipay needs its own client
  ([the contract](notes/The%20Anticipay%20middleware%20API%20contract.md)).
  🟢 **The error store is NOT a problem** — it is `Integration_Log__c`, already
  committed, already logging status code and raw body. But
  **[OI-107](notes/items/OI-107%20The%20Anticipay%20error%20path%20does%20not%20reach%20the%20integration%20log%20intact.md)**
  finds two defects in that engine: `Is_Error__c` is **never set for an HTTP
  error**, so the agreed internal notification would be silent for every `404`;
  and an error body that does not match the `200` wrapper throws, landing in a
  `catch` that **drops `Response_State__c`** — losing the HTTP code the whole
  agreement was about. Both are generic and affect Mexal too.
  [OI-108](notes/items/OI-108%20The%20Anticipay%20payload%20carries%20personal%20data%20of%20the%20legale%20rappresentante.md)
  — **six of the eleven fields identify a private individual** (name, codice
  fiscale, date and place of birth, home address), which is not what "trimmed to
  the needed fields" was understood to mean.
  [OI-106](notes/items/OI-106%20One%20static%20bearer%20token%20serves%20both%20Anticipay%20environments.md)
  — **one static token for both environments**, mailed twice to six addresses.
  [OI-105](notes/items/OI-105%20The%20Anticipay%20date%20of%20birth%20field%20name%20is%20misspelled.md)
  — `data_di_dascita` is a typo **in the wire format**; fix or freeze it before
  anyone codes against it.
  🟢 The **cache-only test mode** inferred from the 31 Aug mail body is confirmed
  in writing, and the **test environment Pienissimo Software owed since 25 August
  turns out to be `:env=test` on the same host, same token** — close that action
  explicitly or restate what is wanted.
  ⚠ Also undiscussed: **`400` and `401` are new error codes** meaning _our call
  is broken_, bucketed with _company unknown_; and there is **no rate limit,
  timeout, retry policy or cache TTL**, so the agreed manual re-check button has
  no documented way to escape a stale answer
  ([OI-94](notes/items/OI-94%20Anticipay%20is%20called%20through%20the%20Pienissimo%20middleware.md),
  [OI-95](notes/items/OI-95%20Which%20Anticipay%20fields%20land%20in%20Salesforce.md),
  [OI-73](notes/items/OI-73%20VAT%20validation%20moves%20into%20Salesforce.md)).

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
  ~~Propagation still cannot run.~~ ~~🔴 **Still not one Flow**~~ 🔴 **The
  integration scaffolding holds zero configuration rows**, so no outbound
  integration has an endpoint
  ([note](notes/objects/The%20integration%20scaffolding%20has%20never%20been%20configured.md)).
  🔴 **37 tickets still parked in states deleted on 6 August**
  ([OI-74](notes/items/OI-74%20Asset%20state%20machine.md)); ~~**Asset** still has
  zero custom fields~~; coverage **0%**.
  ⚠ **The struck-through claims above were true on 26 August and are false on
  28 August** — see the 28 August org check below. The rest of this block still
  holds.
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
  word _scadenziario_ is not in the transcript. It now has no forum.
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
  and it blocks the integration tests set for the **week of 31 August**.
  ~~Nothing of the Salesforce side exists.~~ ⚠ **False as of 28 August** — the
  endpoint is deployed and taking live traffic; see below.
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

- 🟢 **2026-08-28 — the WooCommerce payload was finally read.** Aurel Mrruku
  downloaded Sabatino Rinaldi's 27 Aug attachment, which the record had been
  carrying as unreadable. Preserved as `Payload woo-salesforce.json`; decoded in
  [the payload contract](notes/The%20WooCommerce%20payload%20contract.md).
  ⚠ **It is one example order** — authoritative on the payload's structure and on
  nothing else, so nothing here rests on which fields it happened to fill in.
  🟢 **Two of OI-49's five open points close** — the parameter is
  `sf_opportunity_id`, the id is the **15-character** form. 🔴 **A third is
  answered against the register**: the id travels **in clear** and the envelope has
  no signature field at all, so the header token ROMI owes is the **entire**
  authentication, while `INT-16` still recommends a signed token.
  🔴 **The envelope also has no idempotency key**, beside a plugin with a manual
  re-send button and a trigger that fires on two states
  ([OI-104](notes/items/OI-104%20The%20WooCommerce%20payload%20has%20no%20idempotency%20key.md)).
  Still to ask Sabatino Rinaldi: the full `event` value set, whether `sku` carries
  the article code on the real catalogue, how a bundle line arrives and how a
  taxable order looks.

- ✅ **2026-08-27 — the Lead-conversion failure is closed, and the 27 Aug
  reading of it was wrong.** A Salesforce error mail at 15:08Z reported
  `LeadConversionQueueable` throwing _"No such column 'Servizio_Interesse__c' on
  entity 'Lead'"_, and the note written from it — **without org access** —
  inferred a two-way org/repo divergence. The 28 August org check found the
  field **present** and **neither** class selecting it
  ([the risk, now resolved](notes/risks/Risk%20-%20LeadConversionQueueable%20is%20broken%20in%20the%20Pienissimo%20sandbox.md)).
  🟢 It no longer blocks
  [OI-100](notes/items/OI-100%20Same%20lead%20email%20with%20different%20VAT%20during%20conversion.md),
  which still needs Aurel Mrruku on its own merits.

- 🟢 **2026-08-28 — an org check found the record materially out of date, and
  the build well ahead of it.** Run 14:45–14:56Z against `00DMA000004nMMr2AM`
  (partial sandbox, API 67.0) at repo `89e9bac`; 541 org components vs 169 in
  the repo. **Five claims in this file were verified false** and are struck
  through above: there are **2 Flows** (`Lead_Non_Risponde_Follow_Up` active),
  **Asset has 8 custom fields** and a Ticket record type, the **WooCommerce
  endpoint is deployed and taking live traffic**, `OrderItem.Tranche__c` is
  **granted to `Tranche_Management`**, and the Lead-conversion break is
  **resolved**. 🟢 **All four state machines** (Order, Quote, Asset, Lead) are
  active and byte-aligned with the repo, and **everything in the repo is
  deployed** — no repository-only drift for the first time in the record.
  🔴 Still gating: **coverage 0% of 1,769 lines across 28 classes** — the
  deficit is _growing_ as code lands (1,028 on 25 Aug), and the register's
  `current: "1%"` is stale. 🔴 **`Integration_Configuration__c` has 0 rows _and_
  0 object permissions** — nobody at all can read it, so Anticipay
  ([OI-94](notes/items/OI-94%20Anticipay%20is%20called%20through%20the%20Pienissimo%20middleware.md))
  and Mexal have neither endpoint nor principal. 🔴 **`INT-16`: the WooCommerce
  endpoint has no application-level auth** — `global without sharing`, no token
  or signature check anywhere in the class — so the token owed under
  [OI-102](notes/items/OI-102%20Salesforce%20endpoint%20and%20token%20for%20the%20WooCommerce%20plugin.md)
  is the **entire** authentication. 🟢 **[OI-104](notes/items/OI-104%20The%20WooCommerce%20payload%20has%20no%20idempotency%20key.md)
  is better than recorded** — the payload has no key but the code derives one
  (`Order.WooCommerce_Order_Key__c`, unique + external id, 409 on duplicate,
  exercised in 5 logged calls); the residual is a SOQL-then-insert race.
  🔴 **Permission sets reach one user each** against 8 active users, so business
  users cannot exercise UAT before the 31 Aug tests. ⚠ **That run published
  nothing** — no note or requirement was mutated by it. The corrections above
  were folded in by the 28 Aug requirements-check, which **did not itself open
  the org**; `STATUS.md`, its Notion mirror and the Flows page remain
  `org-status-check`'s to regenerate.

- The repo still runs ahead of the trackers and the org still holds Apex the
  repo does not — [build ahead of the record](notes/objects/The%20build%20ahead%20of%20the%20record.md),
  [missing stack](notes/risks/Risk%20-%20the%20Biglietto%20Apex%20stack%20is%20not%20in%20source%20control.md).
- **Nothing can deploy today.** Apex coverage is **0%** against a 75% floor —
  measured 2026-08-31, **21 classes, 1,571 uncovered lines, zero covered**
  ([OI-64](notes/items/OI-64%20The%20bundle%20Apex%20test%20suite%20is%20broken.md),
  [the deploy risk](notes/risks/Risk%20-%20production%20deploy%20is%20blocked%20by%20Apex%20coverage.md)).
  ⚠ The fall from 1,769 is **entirely the deleted Biglietto classes** — no test
  was written, so it is not progress.
  [OI-66](notes/items/OI-66%20No%20test%20classes%20for%20the%20Biglietto%20stack.md)
  is **superseded**: its subject was deleted, not covered. The suite is written
  as one task, requested separately before the deploy.
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
  minuted · **w/c 31 Aug** WooCommerce integration tests on Salesforce, **now
  live and still blocked** on
  [OI-102](notes/items/OI-102%20Salesforce%20endpoint%20and%20token%20for%20the%20WooCommerce%20plugin.md)
  · **1 Sept 10:00** [ROMI-PIENISSIMO] Follow-up Integrazione Anticipay,
  client-facing — ✅ **ran** (recording `10:02 CEST` + Gemini notes on the event).
  🔴 **Not drilled** — the API PDF was read the same day but **this session did
  not open the minute**. The `:env` v2 mail arrived **12:46 CEST, after the call
  ended**, so it is plausibly an outcome of it. Six questions were derived from
  the document and are listed in
  [OI-94](notes/items/OI-94%20Anticipay%20is%20called%20through%20the%20Pienissimo%20middleware.md);
  **check them against the minute before chasing any of them.** Top two: **the
  error response body**, and **a date from Fabrizio Paganelli and Elisa Migliano**
  on the field selection they have held undated since 25 Aug · **2 Sept 10:00–11:30** [ROMI-PIENISSIMO] Follow-up
  Anagrafica Articoli, client-facing · **7 Sept 10:00–11:00** [PIENISSIMO] Interna
  Flussi MKT, ROMI-internal (Elena Spini, Aurel Mrruku, Fabrizio Mastracci),
  **new — invited 31 Aug 16:07Z**, first marketing session since 19 Aug and the
  forum for [OI-81](notes/items/OI-81%20Event%20communication%20funnel.md)'s
  undecided `30 vs 60` · [PIENISSIMO] Follow-up Interno is a **weekly Monday
  17:00 slot**.
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
   [standard Asset migration](notes/risks/Risk%20-%20the%20Biglietto%20object%20diverged%20from%20the%20approved%20proposal.md)
   (🔴 **and now there is nothing to migrate from** — the source object was
   deleted on 28 Aug with its 37 records, so this is a build from scratch, not a
   mapping exercise),
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
   decision-maker was never told. 🔴 **2026-08-28: still nothing.** Elena Spini's
   status post carries the same red-flag paragraph **verbatim for the fifth
   week** — _"ci riaggiorneranno settimana prossima"_ unchanged since 24 July —
   prefixed with _"Non ho ancora avuto aggiornamenti su questo vedo di smarcare
   settimana prossima"_. **Thirty-five days** since the escalation to Daniela
   Morgese was promised, while a **Fase 1** integration now depends on the
   disputed entity.
5. **Marketing** — 🟢 **the two MKT flows are confirmed and Fabrizio Mastracci
   is building them** (Elena Spini, 28 Aug), the first movement on this stream
   since 19 August. 🔴 But the **100+ form review is confirmed still outstanding
   after nine weeks**, and the DNS records, funnel screenshots and graphics owed
   on 20–26 August remain unconfirmed on every source
   ([OI-14](notes/items/OI-14%20Marketing%20forms%20and%20subdomain.md)). The
   `30 vs 60` day trigger for the first flow is **still undecided while it is
   being built** ([OI-81](notes/items/OI-81%20Event%20communication%20funnel.md)).

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
