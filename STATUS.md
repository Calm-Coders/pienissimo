# ROMI - PIENISSIMO - Project Status

> **ROMI internal.** Candid about delivery and the client relationship. **Do not
> grant Pienissimo access to this page** — the client-facing view is the public
> page in [site/](site/), which is sanitized to different rules
> ([docs/publishing.md](docs/publishing.md)).

**Last regenerated: 2026-08-26 (org-status-check)** ·
**Basis: a live, read-only check of the Pienissimo UAT org**
(`a.mrruku@pienissimo.uat`, `00DMA000004nMMr2AM`) run on **2026-08-26**,
compared against `force-app/` on `DevMain` at `dc513c6`, the notes and the
requirements register. This supersedes the 2026-08-25 check. Everything below
marked as built or not built was **observed in the org on 26 August**, unless
the row says otherwise.

⚠ **One finding of the 25 August check did not survive re-checking.**
`sf sobject describe` filters its field list by the running user's field-level
security, so a deployed field granted to nobody reads as missing. Every field
comparison was re-run against Tooling `FieldDefinition`, which is not filtered —
see [the method note](notes/How%20to%20read%20the%20org%20schema%20without%20a%20false%20negative.md).

Generated from [notes/](notes/), which is the source of record. If this page and
a note disagree, the note wins — regenerate this page rather than editing facts
into it. Agent-facing equivalent: [MAP.md](MAP.md). ROMI action board:
[docs/task-status.md](docs/task-status.md).

Shared with colleagues as a Notion mirror, invite-only and refreshed by step 6
of `org-status-check`:
[status page](https://app.notion.com/p/3c6a6b77a25c818e9b51dc873a2f489c) ·
[open-items tracker](https://app.notion.com/p/04cc8a62d28a40419d7916271f6cae11) ·
[flows](https://app.notion.com/p/3c6a6b77a25c81f891e7ffba884cd150).
See [the mirror note](notes/The%20Notion%20mirror%20of%20the%20project%20status.md).

⚠ **No catalogue prices, no article-code values, no credentials on this page or
its mirror.** Every price in UAT is a ROMI placeholder, and the real ones now
live in a private workbook — describe a field, never a value. See
[docs/publishing.md](docs/publishing.md).

---

## At a glance

|                                                                               |                                                                                                           |
| ----------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------- |
| 🔴 **Nothing can deploy today**                                               | Apex coverage is **0%** against a 75% floor — 24 classes and triggers, 1069 uncovered lines, zero covered |
| 🔴 **Fase 1 development ends 10 September, not 6 October**                    | ROMI's own project plan. With the team back ~24–26 August that is **two weeks of build**                  |
| 🔴 **There is not one Flow in the org**                                       | Every declarative automation designed since June is absent. All automation is three Apex triggers         |
| 🔴 **37 tickets are parked in a state deleted on 6 August**                   | 30 await a signature step the design removed. **None has ever reached `Disponibile`**                     |
| ✅ **The tranche is built, and now in source control** — retrieved in PR #12  | Object, Quote-side creation UI and controller are live and tracked. Propagation and tests are not         |
| ✅ **The first agreed state machine reached the org**                         | `Quote.Status` now carries `Bozza → Nuovo Preventivo → In Trattativa → In Attesa Accettazione → …`        |
| 🔴 **`OrderItem.Tranche__c` is deployed and invisible to everyone**           | Granted to no profile and no permission set — admin included. Propagation still cannot run                |
| 🔴 **No outbound integration has an endpoint**                                | `Integration_Configuration__c` holds **zero rows**. Mexal, WooCommerce and the VAT middleware are unwired |
| ✅ **The client's product registry finally arrived — and was read 24 August** | Sent 7 August, unopened for seventeen days. It broke more of the record than it closed                    |
| 🔴 **A Fase 1 integration now depends on the disputed entity**                | Anticipay is called through a **Pienissimo Software** middleware, agreed 25 August. Nobody said so        |
| **Zoho expires 31 October 2026**                                              | Go-live Fase 1 **6 October**, Fase 2 **9 November**, data import ~1 September                             |

---

## Where the project stands

ROMI is migrating Pienissimo from **Zoho CRM to Salesforce**. The contract-bound
constraint is the Zoho expiry on **31 October 2026**; requirements went to
sign-off on 2026-08-06.

The delivery is not short of design — it is short of **build time and
deployability**. Every open design question below has a forum and an owner. The
two that have neither are the Apex coverage floor, which is handled as one
deliberately deferred task, and the phase 2 commercial dispute, which has run
four meetings without reaching the person who decides.

---

## What is built

**Verified against the Pienissimo UAT org on 2026-08-26**, read-only, and
cross-checked against `force-app/` on `DevMain` at `dc513c6`. Where the two differ the row
says so. Detail:
[the build ahead of the record](notes/objects/The%20build%20ahead%20of%20the%20record.md).

| Area                      | State                                                                                                                                                                                                                                                                  |
| ------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Custom objects**        | `Biglietto__c` (legacy UAT ticket implementation; standard Asset is the decided target), `BundleComponent__c`, plus extensions to Account, Lead, Opportunity, OrderItem, Product2, Quote                                                                               |
| **Bundle composition**    | `BundleComponent__c` — a Product2↔Product2 junction carrying a per-bundle `Spread_Price__c`. Replaced `Product2.Parent__c` on 2026-07-16                                                                                                                               |
| **Bundle reconciliation** | `Bundle_Selling_Price__c`, `Spread_Total__c`, `Spread_Variance__c` — maintained by `BundleComponentTriggerHandler`, since Product2 takes no roll-ups                                                                                                                   |
| **Ticket generation**     | `OrderBigliettoTriggerHandler` creates a `Biglietto__c` from an Order. No equivalent standard Asset generation or migration is built                                                                                                                                   |
| **Product flags**         | `Genera_Biglietto__c` — true on **4 of 280** products. `Solo_Bundle__c` — true on **0 of 280**, and no automation reads it                                                                                                                                             |
| **Classification fields** | `Anno_Solare__c`, `Evento__c`, `Bundle_Type__c` on Product2 — all three **populated on 1 of 280 products**                                                                                                                                                             |
| **Tranche**               | ✅ `Tranche__c` with state, due date, planned amount, sequence and Quote lookup; `QuoteLineItem.Tranche__c`. Six records. ✅ The creation UI — quick action, LWC and controller — is now **in source control** (PR #12)                                                |
| **WooCommerce keys**      | `Product2.WooCommerce_Product_Id__c` (**populated on 0 records**), `Opportunity.WooCommerce_Order_Id__c`. Nothing else on the build list exists                                                                                                                        |
| **Integration framework** | `Integration_Configuration__c`, `Integration_Log__c`, `API_Callout_Engine` — [standard ROMI scaffolding](notes/Integration%20Configuration%20is%20standard%20ROMI%20scaffolding.md). 🔴 **Zero configuration rows and zero log rows — the engine has never run**       |
| **Quote lifecycle**       | ✅ `Quote.Status` = `Bozza · Nuovo Preventivo · In Trattativa · In Attesa Accettazione · Accettato · Rifiutato`, stock English values deactivated. ⚠ The picklist only — **no rule, alert or template enforces it**, and 3 of 4 quotes were left on deactivated values |
| **UI**                    | `bundleProductAssignment` LWC + controller; `quoteCreateTranche` LWC — both now in source control                                                                                                                                                                      |
| **Automation**            | Three Apex triggers: `BigliettoTrigger`, `BundleComponentTrigger`, `OrderBigliettoTrigger`. 🔴 **No Flow, workflow rule, approval process, email template, notification type or scheduled job exists in the org**                                                      |

154 files under `force-app/`. Written by the
[Calm-Coders developers working for ROMI](notes/Calm-Coders%20on%20GitHub%20means%20ROMI.md)
— Anita Aga, Sara Aga and Rexhina Hysi — whose commits land **ahead of every
tracker**, which is why the written record repeatedly understates what exists.

---

## What is not built

| Gap                                                                                                                                                                                                                                             | Item                                                                                                                                                                          |
| ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Standard Asset migration** — target decided 24 Aug, but fields, relationships and six Apex classes still sit on custom `Biglietto__c`; effort unestimated                                                                                     | [OI-41](notes/items/OI-41%20Asset%20and%20ticket%20data%20model.md), [risk](notes/risks/Risk%20-%20the%20Biglietto%20object%20diverged%20from%20the%20approved%20proposal.md) |
| 🔴 **No declarative automation at all** — zero Flows, and also zero workflow rules, approval processes, email templates, notification types and scheduled jobs. So the reminder copy delivered 25 Aug has nothing to sit on                     | [the flow](notes/flows/The%20quote%20to%20order%20flow.md)                                                                                                                    |
| 🔴 **No outbound integration is configured** — `Integration_Configuration__c` and `Integration_Log__c` hold zero rows and the org has one named credential. Mexal, WooCommerce and the VAT middleware have no endpoint                          | [the scaffolding](notes/objects/The%20integration%20scaffolding%20has%20never%20been%20configured.md)                                                                         |
| 🔴 **Order, Lead and Opportunity state machines are still stock Salesforce** — not one agreed value configured. **Quote is now the exception**: its picklist landed 26 Aug                                                                      | [OI-69](notes/items/OI-69%20Order%20state%20model.md), [OI-59](notes/items/OI-59%20Quote%20workflow%20configuration.md)                                                       |
| 🔴 **`OrderItem.Tranche__c` is deployed and granted to nobody** — no profile, no permission set, admin included. Nothing in `force-app/` writes it either, so propagation cannot run                                                            | [risk](notes/risks/Risk%20-%20OrderItem%20Tranche%20is%20invisible%20to%20every%20user.md)                                                                                    |
| **The tranche remainder** — payment aggregation is unverified and untested, and `Sequenza__c` has no uniqueness or contiguity control though ticket release reads it as an order                                                                | [OI-50](notes/items/OI-50%20Tranche%20object.md), [risk](notes/risks/Risk%20-%20the%20tranche%20sequence%20has%20no%20integrity%20control.md)                                 |
| **The campaign parent/child model** — `Campaign` **and `CampaignMember`** both have zero custom fields, no record types and no validation rules. It is what carries the event edition                                                           | [the model](notes/objects/The%20campaign%20parent%20and%20child%20model.md)                                                                                                   |
| **Any Apex coverage at all** — **0%** org-wide against a 75% deploy floor                                                                                                                                                                       | [OI-64](notes/items/OI-64%20The%20bundle%20Apex%20test%20suite%20is%20broken.md), [OI-66](notes/items/OI-66%20No%20test%20classes%20for%20the%20Biglietto%20stack.md)         |
| **The Biglietto stack is still not in source control** — unmoved since 22 July, and three components larger than recorded: the `BigliettoPdf` page, the `DocuSign` named credential and a custom tab. ✅ The tranche stack was retrieved 26 Aug | [risk](notes/risks/Risk%20-%20the%20Biglietto%20Apex%20stack%20is%20not%20in%20source%20control.md)                                                                           |
| Participant data collection, and who hosts the landing page                                                                                                                                                                                     | [OI-78](notes/items/OI-78%20Participant%20data%20collection.md), [OI-86](notes/items/OI-86%20Who%20hosts%20the%20participant%20landing%20page.md)                             |
| The WooCommerce checkout-link flow — credentials expected 26 August                                                                                                                                                                             | [OI-49](notes/items/OI-49%20WooCommerce%20checkout-link%20flow.md)                                                                                                            |
| VAT validation moving into Salesforce — provider unconfirmed                                                                                                                                                                                    | [OI-73](notes/items/OI-73%20VAT%20validation%20moves%20into%20Salesforce.md)                                                                                                  |
| The Zoho import template ROMI owes the client, ahead of the ~1 September import                                                                                                                                                                 | [OI-88](notes/items/OI-88%20Zoho%20import%20template%20owed%20to%20Pienissimo.md)                                                                                             |
| The whole phase 2 scope — no estimate exists and the decision-maker was never told                                                                                                                                                              | [OI-83](notes/items/OI-83%20No%20phase%202%20estimate.md)                                                                                                                     |

---

## Blocking now, in order

1. **Apex coverage — nothing ships until it clears 75%, and it now reads 0%.**
   _Aurel Mrruku._ Measured 2026-08-26: 24 classes and triggers, **1069**
   uncovered lines, **zero covered**. Three causes: making `Product2.Code__c` required
   broke nine of ten bundle tests
   ([OI-64](notes/items/OI-64%20The%20bundle%20Apex%20test%20suite%20is%20broken.md)),
   the Biglietto stack has no tests
   ([OI-66](notes/items/OI-66%20No%20test%20classes%20for%20the%20Biglietto%20stack.md)),
   and `QuoteTrancheController` shipped on 25 Aug with none — **185 lines**, the
   largest uncovered class in the org. (It read 144 on 25 Aug; the class has not
   changed, the coverage snapshot caught up with the deploy.)
   ⚠ **This is handled as one deliberate task, requested separately before the
   production deploy — it is not to be picked up mid-flight.** The records stay
   current so that task has a brief when it comes.
2. **Build the automation layer — there is none.** _ROMI._ The org contains
   **zero Flows**. Asset generation, the quote validity and alert rules, the
   participant funnel, campaign member handling and the Lead/Opty validation
   specified on 24 August are all designed and none is implemented. There is also
   **no email template, no notification type and no scheduled job**, so the
   reminder copy delivered on 25 August has nothing to sit on. Order, Lead and
   Opportunity are still stock Salesforce; **Quote is the one exception** and its
   picklist landed without any rule to enforce it. This is the single largest gap
   against the **10 September** development end date
   ([the flow](notes/flows/The%20quote%20to%20order%20flow.md)).
3. **Finish the tranche.** _ROMI._ The object and the Quote-side creation UI
   exist and, since 26 August, are **in source control** — that gap is closed.
   Three remain: **`OrderItem.Tranche__c` is deployed but granted to no profile
   and no permission set**, so no user or FLS-respecting code can touch it, and
   nothing in `force-app/` writes it either — propagation cannot run
   ([risk](notes/risks/Risk%20-%20OrderItem%20Tranche%20is%20invisible%20to%20every%20user.md));
   the payment aggregation from Mexal lines is still unverified; and
   **`Sequenza__c` has no integrity control** — 1, 4, 3 on one quote and null on
   three records, while ticket release reads it as a total order
   ([OI-50](notes/items/OI-50%20Tranche%20object.md),
   [risk](notes/risks/Risk%20-%20the%20tranche%20sequence%20has%20no%20integrity%20control.md)).
4. **Plan and build the move from `Biglietto__c` to standard Asset.** _ROMI._
   The object decision is closed; implementation has not started — **`Asset`
   carries zero custom fields** and holds one record, against 37 on
   `Biglietto__c`. Worse, those 37 are unusable as they stand: **30 sit in
   `In attesa firma` and 7 in `Caricato`**, and `Biglietto__c.Status__c` still
   carries the pre-06-August signature vocabulary that the closing session
   struck. **No ticket has ever reached `Disponibile`.** Map every field,
   relationship and automation, including the seven UAT-only Apex classes, then
   decide what is migrated, rewritten or retired. Effort is not estimated
   ([OI-41](notes/items/OI-41%20Asset%20and%20ticket%20data%20model.md),
   [OI-74](notes/items/OI-74%20Asset%20state%20machine.md)).
5. **Fix `Product2.Evento__c` before any product import.** _ROMI._ The built
   restricted picklist is wrong against the client's own event list: **no
   `Happy Team` value**, although Happy Team is priced and sits in the Academy
   bundle at quantity 2. Also `Camerieri` truncated, `Odb Live`, and an invented
   `ND`. And the `Anno_Solare__c` dependency matrix has **no client source at
   at all**. ✅ The org check makes this cheap: both fields are populated on
   **1 of 280 products**, so correcting or dropping them breaks essentially no
   data ([OI-46](notes/items/OI-46%20Bundle%20classification%20picklists.md)).
6. **Get the 19 and 20 August sessions minuted, or re-run them.** _Elena Spini._
   Three design moves in two days, none recorded — `Rinuncia` entering the
   master diagram ([OI-74](notes/items/OI-74%20Asset%20state%20machine.md)), the
   06-08 order states drawn _alongside_ the old ones rather than replacing them
   ([OI-69](notes/items/OI-69%20Order%20state%20model.md)), and a new question
   about Mexal reversing an asset
   ([OI-92](notes/items/OI-92%20Mexal%20Scadenziario%20as%20the%20trigger%20to%20reverse%20an%20asset.md)).
   **Nothing was reconfigured against any of it.**
7. **Close the `CHIUSO/ACQUISITO` question.** _Elena Spini._ The 06-08 session
   struck it from the Order; the legacy tranche design still uses the name.
   ✅ The tranche half is settled in the build: `Tranche__c.Stato__c` uses
   `Aperta / Parzialmente Pagata / Pagata`, not `CHIUSO/ACQUISITO`. What remains
   blocked is the **Order** state machine, still stock `Draft` / `Activated`
   with zero custom fields — so nothing has been configured twice
   ([OI-69](notes/items/OI-69%20Order%20state%20model.md)).
8. **Send Pienissimo the Zoho import template.** _ROMI._ Owed before the
   ~1 September import
   ([OI-88](notes/items/OI-88%20Zoho%20import%20template%20owed%20to%20Pienissimo.md)),
   and it must carry the opaque-code rule below.
9. **Take the phase 2 dispute to Daniela Morgese.** Four meetings, and
   [OI-83](notes/items/OI-83%20No%20phase%202%20estimate.md) records that the only
   person who can decide it was never told.
10. **Confirm the 10 September development deadline still stands.** _Elena
    Spini._ Every conversation anchors on 6 October, which is go-live, not
    code-complete ([OI-04](notes/items/OI-04%20Scope%20against%20the%20go-live%20date.md)).
11. **Decide who owns the Anticipay middleware before anyone builds against it.**
    _Elena Spini._ The 25 August client call moved the VAT check off a direct
    Anticipay call and onto **an API that Pienissimo Software Srl must build,
    host and keep running**
    ([OI-94](notes/items/OI-94%20Anticipay%20is%20called%20through%20the%20Pienissimo%20middleware.md)).
    Anticipay → SFDC is **Fase 1**. So Fase 1 now cannot go live without work
    from the separate legal entity ROMI argues is not this project's client, and
    the entity at the centre of
    [the phase 2 dispute](notes/risks/Risk%20-%20the%20phase%202%20scope%20dispute%20is%20unresolved.md).
    Who pays, and who owns uptime after go-live, was not raised in the session.
    The technical decision is sound on its own terms — this is a commercial line,
    and it moved inside an architecture diagram.
12. **Chase Andrea Parmeggiani's API payload example.** _Aurel Mrruku._ Due
    **Friday 4 September**; nothing about the VAT integration is buildable until
    it arrives — no endpoint, no schema, no token, no test environment. Follow-up
    call **Tuesday 1 September 10:00**. Set against the **10 September**
    development end, that is roughly four working days. The trimmed field list is
    a second, client-owned dependency
    ([OI-95](notes/items/OI-95%20Which%20Anticipay%20fields%20land%20in%20Salesforce.md)).
13. **Re-send the 1 September invitation, or correct it in the call.** _Elena
    Spini._ The client-facing invitation of 25 August states that ROMI will
    create the integration test environment. That is wrong — ROMI's exists, and
    what is needed is **Pienissimo's, for ROMI to point at**. Aurel Mrruku
    corrected it internally the same afternoon; the client has not been told.
14. **Fix the master design file — it contradicts itself.** _Elena Spini._
    `Flows & Objects.drawio` was edited during the 25 August call and only the
    **LEAD-OPTY** page was updated. The **Ordini** page still instructs a direct
    Anticipay call. A developer reading that page will build the superseded
    architecture
    ([the diagram](notes/The%20newest%20design%20diagram.md)).

---

## The client's product registry, read 2026-08-24

`Prodotti e Bundle.xlsx` — Fabrizio Paganelli's attachment of **7 August**,
forwarded 18 August, **opened 24 August**. Seventeen days unread. It answered
four questions and **broke more of the record than it closed**. Decode:
[the workbook](notes/The%20Prodotti%20e%20Bundle%20workbook.md).

| It settled                                                                                                                     | It broke                                                                                                                             |
| ------------------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------ |
| **Real catalogue prices delivered** — [OI-87](notes/items/OI-87%20Real%20catalogue%20prices%20still%20outstanding.md) resolved | The built event picklist is wrong, and **`Happy Team` is missing outright**                                                          |
| The event list: **11 events in 4 types**, not the 7 on record                                                                  | The `Anno_Solare__c` → `Evento__c` matrix has **no client source**                                                                   |
| Tier vocabulary: `EXECUTIVE` / `GOLD` / `DIAMOND` — **`Silver` and `Dinamond` both die**                                       | The tier **field still does not exist**, so [OI-76](notes/items/OI-76%20Ticket%20type%20picklist%20on%20the%20product.md) stays open |
| A bundle is **two levels deep**: `PACK` → `BLO` (blocco) → article                                                             | `BundleComponent__c` is **flat** and cannot express the middle level                                                                 |
| The `(B)` bundle-code convention looks **obsolete, not forgotten**                                                             | [OI-93](notes/items/OI-93%20Bundle%20components%20should%20be%20priced%20articles.md) — a client change request nobody knew existed  |

⚠ **One rule from it binds the September import.** `_ARCOD` is an **opaque
string**: two pairs of codes differ only by a separator or a leading zero and
name **different events at different prices**. `Product2.Code__c` is a unique,
case-insensitive external id, so a normalising import does not fail cleanly — it
overwrites a product or throws an opaque duplicate error at load time. **No
trim, pad, separator-strip or case-fold, anywhere.**
[The risk](notes/risks/Risk%20-%20normalising%20an%20article%20code%20merges%20two%20products.md).

**Still owed:** the 22 July session paired this file with a **review meeting on
the anagrafica prodotti**. The file arrived; the meeting has not happened.

---

## Open risks

Eleven recorded. Severity is the note's own.

| Risk                                                                                       | Severity |
| ------------------------------------------------------------------------------------------ | -------- |
| Production deploy is blocked by Apex coverage — **0%** against a 75% floor                 | high     |
| The Biglietto Apex stack is not in source control — and the tranche stack repeated it      | high     |
| `OrderItem.Tranche__c` is deployed and granted to no user — propagation cannot run in UAT  | high     |
| The whole remaining build lands after Ferragosto — two weeks for everything                | high     |
| The phase 2 scope dispute is unresolved, and the decision-maker was never told             | high     |
| Placeholder prices could reach the client — every UAT price is a ROMI invention            | high     |
| Normalising an article code merges two products — bites at the ~1 September import         | high     |
| Standard Asset is decided, but UAT still runs on custom Biglietto — migration unestimated  | medium   |
| The ticket lifecycle has never run end to end — 0 of 37 tickets have reached `Disponibile` | high     |
| The tranche sequence has no integrity control — release reads it as a total order          | medium   |
| No coherence control on bundle composition                                                 | medium   |

---

## Register coverage

|                                     |                                                                   |
| ----------------------------------- | ----------------------------------------------------------------- |
| Atomic notes                        | 119                                                               |
| Item notes in `notes/items/`        | 54 — of which **7 gating**, 42 open, 8 in progress                |
| Numbered rows in the client tracker | ~86                                                               |
| Requirements reachable from a note  | **9 of 167**                                                      |
| Org components verified 2026-08-26  | 6 custom objects, 34 Apex classes, 3 triggers, 2 LWC, **0 Flows** |

⚠ **Two honest gaps in the record itself.** The tracker carries roughly 86
numbered rows and only 54 have atomic notes behind them, so this page's item
view is the _notes_ view, not the whole tracker. And the requirement trace is
**9 of 163** — most signed requirements cannot yet be walked back to the meeting
that produced them
([the trace](notes/The%20requirement%20mappings%20were%20fabricated.md)).

⚠ **`sf project retrieve preview` cannot be used on this org.** Pienissimo UAT is
a partial sandbox with no source tracking, so repository-vs-org divergence has to
be established component by component. Any future check that skips that step will
silently miss org-only work — which is how the tranche controller went unrecorded.

⚠ **And do not use `sf sobject describe` for that comparison.** It is filtered by
the running user's field-level security, so a deployed field granted to nobody
reads as never deployed. That produced a false finding on 25 August. Use Tooling
`FieldDefinition` for existence and `FieldPermissions` for visibility —
[the method note](notes/How%20to%20read%20the%20org%20schema%20without%20a%20false%20negative.md).

---

## Who is who

**ROMI** — **Elena Spini** chairs and owns the client relationship. **Aurel
Mrruku** is technical lead. **Andrea Di Cicco** owns the Mexal integration.
**Anita Aga**, **Sara Aga** and **Rexhina Hysi** write the build and appear in
almost no meeting record.

**Pienissimo** — **Daniela Morgese** decides and signs commercially. **Sabatino
Rinaldi** leads day to day. **Elisa Migliano** is the operational authority on
administration, invoicing and the infopoint. **Fabrizio Paganelli** owns the
product registry. **Marco Montesi** sales.

---

## Maintaining this page

- Facts live in [notes/](notes/). Change the note, regenerate this page, then
  push the mirror.
- Refreshed by **step 6 of
  [org-status-check](.agents/skills/org-status-check/SKILL.md)**, and worth
  refreshing after any `requirements-check`, `drill-meeting` or `drill-me` run.
- Not every agent can reach Notion — Codex, Cursor and an expired grant cannot.
  That is not a failure: **this file is the deliverable**, and the mirror simply
  goes stale until a session with the connector catches it up.
- **This is not the public page.** [site/](site/) is public, unauthenticated and
  sanitized; this one is internal, invite-only, and deliberately names people.
  Never copy text from here into it.
- Contains **no catalogue prices, no article-code values, no credentials** and
  must not acquire any — describe a field, never a value.
