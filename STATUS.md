# ROMI - PIENISSIMO - Project Status

> **ROMI internal.** Candid about delivery and the client relationship. **Do not
> grant Pienissimo access to this page** — the client-facing view is the public
> page in [site/](site/), which is sanitized to different rules
> ([docs/publishing.md](docs/publishing.md)).

**Last regenerated: 2026-08-24** · **Basis: the repository, the notes, the git
history and the client documents — _not_ a live org check.** The newest
verification against the Pienissimo UAT org is still the one of **2026-08-03**,
and it is known stale in both directions. Say so plainly rather than implying
the org was read today.

Generated from [notes/](notes/), which is the source of record. If this page and
a note disagree, the note wins — regenerate this page rather than editing facts
into it. Agent-facing equivalent: [MAP.md](MAP.md). ROMI action board:
[docs/task-status.md](docs/task-status.md).

⚠ **No catalogue prices, no article-code values, no credentials on this page or
its mirror.** Every price in UAT is a ROMI placeholder, and the real ones now
live in a private workbook — describe a field, never a value. See
[docs/publishing.md](docs/publishing.md).

---

## At a glance

|                                                                               |                                                                                            |
| ----------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------ |
| 🔴 **Nothing can deploy today**                                               | Apex coverage was **1%** against a 75% floor on 2026-08-03. Not one line has changed since |
| 🔴 **Fase 1 development ends 10 September, not 6 October**                    | ROMI's own project plan. With the team back ~24–26 August that is **two weeks of build**   |
| 🔴 **The design moved three times in two days and none of it is minuted**     | Both register source diagrams edited 20 August, 68 minutes apart. Nothing was reconfigured |
| 🔴 **The most consequential object does not exist**                           | `Tranche__c` — the whole instalment and ticket-release design rests on it                  |
| **The repository is roughly a week ahead of every tracker**                   | Six things the 08-03 check called "not built" were committed 4–7 August                    |
| ✅ **The client's product registry finally arrived — and was read 24 August** | Sent 7 August, unopened for seventeen days. It broke more of the record than it closed     |
| **Zoho expires 31 October 2026**                                              | Go-live Fase 1 **6 October**, Fase 2 **9 November**, data import ~1 September              |

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

**Read from `force-app/` on the `DevMain` branch, not verified against the org
today.** The last org verification is 2026-08-03 and predates most of this.
Detail: [the build ahead of the record](notes/objects/The%20build%20ahead%20of%20the%20record.md).

| Area                      | State                                                                                                                                                                                                             |
| ------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Custom objects**        | `Biglietto__c`, `BundleComponent__c`, plus extensions to Account, Lead, Opportunity, OrderItem, Product2, Quote                                                                                                   |
| **Bundle composition**    | `BundleComponent__c` — a Product2↔Product2 junction carrying a per-bundle `Spread_Price__c`. Replaced `Product2.Parent__c` on 2026-07-16                                                                          |
| **Bundle reconciliation** | `Bundle_Selling_Price__c`, `Spread_Total__c`, `Spread_Variance__c` — maintained by `BundleComponentTriggerHandler`, since Product2 takes no roll-ups                                                              |
| **Ticket generation**     | `OrderBigliettoTriggerHandler` — creates a Biglietto from an Order. The 08-03 check said nothing did this                                                                                                         |
| **Product flags**         | `Genera_Biglietto__c` and `Solo_Bundle__c` both exist. **Nothing upstream populates them** — the client's registry carries neither column                                                                         |
| **Classification fields** | `Anno_Solare__c`, `Evento__c`, `Bundle_Type__c` on Product2 — all three **populated on zero bundles**                                                                                                             |
| **Instalment input**      | `OrderItem.Data_Scadenza__c`, the line-level due date the tranche design is built on. Committed 4 August, in no tracker                                                                                           |
| **WooCommerce keys**      | `Product2.WooCommerce_Product_Id__c`, `Opportunity.WooCommerce_Order_Id__c`                                                                                                                                       |
| **Integration framework** | `Integration_Configuration__c`, `Integration_Log__c`, `API_Callout_Engine` — [standard ROMI scaffolding](notes/Integration%20Configuration%20is%20standard%20ROMI%20scaffolding.md), not a Pienissimo requirement |
| **UI**                    | `bundleProductAssignment` LWC + controller                                                                                                                                                                        |

135 files under `force-app/`. Written by the
[Calm-Coders developers working for ROMI](notes/Calm-Coders%20on%20GitHub%20means%20ROMI.md)
— Anita Aga, Sara Aga and Rexhina Hysi — whose commits land **ahead of every
tracker**, which is why the written record repeatedly understates what exists.

---

## What is not built

| Gap                                                                                                                           | Item                                                                                                                                                                  |
| ----------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **`Tranche__c` — does not exist in the org or the repository.** The input (`Data_Scadenza__c`) is there; the mechanism is not | [OI-50](notes/items/OI-50%20Tranche%20object.md)                                                                                                                      |
| **Any Apex coverage worth the name** — 1% org-wide against a 75% deploy floor                                                 | [OI-64](notes/items/OI-64%20The%20bundle%20Apex%20test%20suite%20is%20broken.md), [OI-66](notes/items/OI-66%20No%20test%20classes%20for%20the%20Biglietto%20stack.md) |
| **The six Biglietto Apex classes are not in source control** — they exist only in the UAT org                                 | [risk](notes/risks/Risk%20-%20the%20Biglietto%20Apex%20stack%20is%20not%20in%20source%20control.md)                                                                   |
| Participant data collection, and who hosts the landing page                                                                   | [OI-78](notes/items/OI-78%20Participant%20data%20collection.md), [OI-86](notes/items/OI-86%20Who%20hosts%20the%20participant%20landing%20page.md)                     |
| The WooCommerce checkout-link flow — credentials expected 26 August                                                           | [OI-49](notes/items/OI-49%20WooCommerce%20checkout-link%20flow.md)                                                                                                    |
| VAT validation moving into Salesforce — provider unconfirmed                                                                  | [OI-73](notes/items/OI-73%20VAT%20validation%20moves%20into%20Salesforce.md)                                                                                          |
| The Zoho import template ROMI owes the client, ahead of the ~1 September import                                               | [OI-88](notes/items/OI-88%20Zoho%20import%20template%20owed%20to%20Pienissimo.md)                                                                                     |
| The whole phase 2 scope — no estimate exists and the decision-maker was never told                                            | [OI-83](notes/items/OI-83%20No%20phase%202%20estimate.md)                                                                                                             |

---

## Blocking now, in order

1. **Apex coverage — nothing ships until it clears 75%.** _Aurel Mrruku._ Two
   causes: making `Product2.Code__c` required broke nine of ten bundle tests
   ([OI-64](notes/items/OI-64%20The%20bundle%20Apex%20test%20suite%20is%20broken.md)),
   and the Biglietto stack has no tests at all, ~270 uncovered lines
   ([OI-66](notes/items/OI-66%20No%20test%20classes%20for%20the%20Biglietto%20stack.md)).
   ⚠ **This is handled as one deliberate task, requested separately before the
   production deploy — it is not to be picked up mid-flight.** The records stay
   current so that task has a brief when it comes.
2. **Build `Tranche__c`.** _ROMI._ The most consequential unbuilt object in the
   project: [ticket availability](notes/items/OI-75%20Ticket%20availability%20rule.md)
   depends on tranche-level invoicing, so the whole ticket lifecycle sits
   downstream of something nobody has started
   ([OI-50](notes/items/OI-50%20Tranche%20object.md)).
   **Newly complicated:** the client also has a _product-side_ tranche — see §
   the workbook below.
3. **Fix `Product2.Evento__c` before any product import.** _ROMI._ The built
   restricted picklist is wrong against the client's own event list: **no
   `Happy Team` value**, although Happy Team is priced and sits in the Academy
   bundle at quantity 2. Also `Camerieri` truncated, `Odb Live`, and an invented
   `ND`. And the `Anno_Solare__c` dependency matrix has **no client source at
   all** ([OI-46](notes/items/OI-46%20Bundle%20classification%20picklists.md)).
4. **Get the 19 and 20 August sessions minuted, or re-run them.** _Elena Spini._
   Three design moves in two days, none recorded — `Rinuncia` entering the
   master diagram ([OI-74](notes/items/OI-74%20Asset%20state%20machine.md)), the
   06-08 order states drawn _alongside_ the old ones rather than replacing them
   ([OI-69](notes/items/OI-69%20Order%20state%20model.md)), and a new question
   about Mexal reversing an asset
   ([OI-92](notes/items/OI-92%20Mexal%20Scadenziario%20as%20the%20trigger%20to%20reverse%20an%20asset.md)).
   **Nothing was reconfigured against any of it.**
5. **Close the `CHIUSO/ACQUISITO` question.** _Elena Spini._ The 06-08 session
   struck it from the Order; the tranche design still uses the name. Blocks
   configuring **both** objects
   ([OI-69](notes/items/OI-69%20Order%20state%20model.md)).
6. **Send Pienissimo the Zoho import template.** _ROMI._ Owed before the
   ~1 September import
   ([OI-88](notes/items/OI-88%20Zoho%20import%20template%20owed%20to%20Pienissimo.md)),
   and it must carry the opaque-code rule below.
7. **Take the phase 2 dispute to Daniela Morgese.** Four meetings, and
   [OI-83](notes/items/OI-83%20No%20phase%202%20estimate.md) records that the only
   person who can decide it was never told.
8. **Confirm the 10 September development deadline still stands.** _Elena
   Spini._ Every conversation anchors on 6 October, which is go-live, not
   code-complete ([OI-04](notes/items/OI-04%20Scope%20against%20the%20go-live%20date.md)).

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

Nine recorded. Severity is the note's own.

| Risk                                                                               | Severity |
| ---------------------------------------------------------------------------------- | -------- |
| Production deploy is blocked by Apex coverage — 1% against a 75% floor             | high     |
| The Biglietto Apex stack is not in source control — six classes exist only in UAT  | high     |
| The whole remaining build lands after Ferragosto — two weeks for everything        | high     |
| The phase 2 scope dispute is unresolved, and the decision-maker was never told     | high     |
| Placeholder prices could reach the client — every UAT price is a ROMI invention    | high     |
| Normalising an article code merges two products — bites at the ~1 September import | high     |
| The Biglietto object diverged from the approved proposal                           | medium   |
| The ticket lifecycle has never run end to end                                      | medium   |
| No coherence control on bundle composition                                         | medium   |

---

## Register coverage

|                                     |                                                    |
| ----------------------------------- | -------------------------------------------------- |
| Atomic notes                        | 92                                                 |
| Item notes in `notes/items/`        | 54 — of which **7 gating**, 42 open, 8 in progress |
| Numbered rows in the client tracker | ~86                                                |
| Requirements reachable from a note  | **8 of 137**                                       |

⚠ **Two honest gaps in the record itself.** The tracker carries roughly 86
numbered rows and only 54 have atomic notes behind them, so this page's item
view is the _notes_ view, not the whole tracker. And the requirement trace is
**8 of 137** — most signed requirements cannot yet be walked back to the meeting
that produced them
([the trace](notes/The%20requirement%20mappings%20were%20fabricated.md)).

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
