# ROMI - PIENISSIMO - Project Status

> **ROMI internal.** Candid about delivery and the client relationship. **Do not
> grant Pienissimo access to this page** — the client-facing view is the public
> page in [site/](site/), which is sanitized to different rules
> ([docs/publishing.md](docs/publishing.md)).

**Last regenerated: 2026-09-14 (org-status-check, full scope, reconciled and published)** ·
**Basis: a live, read-only check of the Pienissimo UAT org**
(`a.mrruku@pienissimo.uat`, `00DMA000004nMMr2AM`, API 68.0) run on
**2026-09-14, 10:51Z**, comparing **335** repository component keys on `DevMain`
at `cc3c571` against **1,218** org components, plus the notes and the
requirements register. This supersedes the 2026-09-02 published check and the
2026-09-08 report-only run. Everything below marked as built or not built was
**observed in the org on 14 September**, unless the row says otherwise.

🔴 **The finding that matters most: the entire order-to-Mexal integration
exists in the org and in no branch of this repository.** Nine Apex classes,
roughly 28,000 characters, created that morning between 09:12 and 10:33 UTC,
plus two `Order` fields. It is good work — it implements the agreed Anticipay
→ Mexal sequence exactly — and **a deploy from `DevMain` today would silently
revert it**. See
[the build](notes/objects/The%20order%20to%20Mexal%20integration%20chain.md) and
[the risk](notes/risks/Risk%20-%20the%20Mexal%20order%20integration%20exists%20only%20in%20the%20org.md).

⚠ **Instruments that report silence as absence.** `sf sobject describe` filters
by the running user's field-level security; Metadata API `listMetadata` cannot
enumerate folder-scoped types. Both have produced false absences on this project.
Use Tooling `FieldDefinition` for fields, SOQL for templates, and two agreeing
instruments before recording any absence — see
[the method note](notes/How%20to%20read%20the%20org%20schema%20without%20a%20false%20negative.md).
This run adds a third: **the org inventory does not enumerate ListView,
FlexiPage, StandardValueSet, PathAssistant, DigitalExperience, Site or Network**,
so the 88 keys it reports as repository-only are **unverifiable, not absent**.

Generated from [notes/](notes/), which is the source of record. If this page and
a note disagree, the note wins — regenerate this page rather than editing facts
into it. Agent-facing equivalent: [MAP.md](MAP.md).

---

## At a glance

|                                                          |                                                                                                                                                                                        |
| -------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| 🔴 **The Mexal integration is not in source control**    | **Nine Apex classes and two `Order` fields**, built in the org on 14/09. Fourth org-only instance and by far the largest. **A `DevMain` deploy reverts it and orphans nine classes**   |
| 🟢 **The order-to-Mexal chain is built and correct**     | Mark Running → Anticipay (first order only) → Mexal Customer → Mexal Order. The 11/09 sequencing decision, implemented — first-order resolved by query, Anticipay failure non-blocking |
| 🔴 **It has never run**                                  | All **30** Orders carry an empty `Mexal_Integration_Status__c`; **2** Accounts have a Mexal code. Nothing proves a second order for an existing customer reaches Mexal                 |
| 🟢 **The integration scaffolding is configured at last** | `Integration_Configuration2__c` holds **six rows** — all four needed by exact name plus two. **Every "zero rows" claim on this page before today is withdrawn**                        |
| 🔴 **Nothing is scheduled**                              | The batch, scheduler and watermark all exist; all **7** `CronTrigger` rows are Salesforce platform jobs. #116 is now **one `System.schedule` call**, not a decision                    |
| 🔴 **Nothing can deploy today**                          | Apex coverage reads **0%** against a 75% floor — **4,737** uncovered lines, up from 2,957 six days ago. Still unmeasured: no test has run since **4 August**                           |
| 🔴 **#117 was answered by building the opposite**        | Agreed 03/09 as a read-only **lock**; the org **pushes** admin edits to Mexal instead. Defensible, **unminuted**, and it leaves two writers on the same fields                         |
| 🔴 **A clean deploy fails twice**                        | `Full_Permission` and `Integration_Management` both grant an external credential principal with **no metadata in the repository**                                                      |
| 🔴 **Source drift has more than doubled**                | **12 of 76** unmanaged classes/triggers differ from source, **8 at token level** — against 4 on 08/09                                                                                  |
| ⚠ **40 of 43 ticket products still unmapped**            | Unchanged since 08/09. An order for an unmapped product rolls back ([#121](notes/items/OI-121%20The%20edition%20mapping%20table%20has%20no%20rows%20and%20no%20owner.md))              |
| ✅ **Everything in `force-app/` is deployed**            | **Zero** repository-only components in the twelve kinds compared both ways                                                                                                             |
| ✅ **Tranche propagation has started**                   | **3 of 36** order lines now carry a tranche, against **0 of 32** on 08/09                                                                                                              |
| **Zoho expires 31 October 2026**                         | **Go-live Fase 1 is 21 October** (moved 08/09, acknowledged by the client 09/09). **UAT 23 September – 13 October**, approval by 13 October                                            |

---

## Where the project stands

ROMI is migrating Pienissimo from **Zoho CRM to Salesforce**. The contract-bound
constraint is the Zoho expiry on **31 October 2026**. **Go-live Fase 1 is
21 October**, moved by ROMI in writing on 8 September and acknowledged by
Fabrizio Paganelli on 9 September; the register says 21 October in both
languages at `v1.5`
([OI-124](notes/items/OI-124%20Go-live%20moved%20from%206%20to%2021%20October.md)).
**UAT runs 23 September – 13 October**, with approval due by 13 October.
Requirements went to sign-off on 2026-08-06.

**Fase 1 development was due to end on 10 September.** It did not: substantial
integration work landed on 10, 11 and 14 September, and the largest piece of it
is not in source control. The build is ahead of the written record and behind
its own custody.

---

## What is built

**Verified against the Pienissimo UAT org on 2026-09-14**, read-only, and
cross-checked against `force-app/` on `DevMain` at `cc3c571`. Where the two
differ the row says so. 🟢 **Repository-only drift is zero** — everything in
`force-app/` is deployed. 🔴 **Org-only drift is the problem**, and it grew
sharply today.

| Area                             | State                                                                                                                                                                                                                                                                                                                                                                                |
| -------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| **Order → Mexal chain**          | 🔴 **ORG ONLY.** `OrderMexalIntegrationService` + `OrderMexalIntegrationQueueable` run Mark Running → Anticipay (first order only) → Mexal Customer → Mexal Order, one queueable per step, per-step logging, remaining orders continue on failure. **Never executed**                                                                                                                |
| **Mexal transport**              | 🔴 **ORG ONLY.** `MexalHttpClient`, `MexalOrderSendService`, `MexalIntegrationLogger`. Named Credential auth; the secret stays out of the log                                                                                                                                                                                                                                        |
| **Mexal customer create/update** | `MexalCustomerCreateService`, `MexalCustomerSearchService`, `MexalSearchCalloutService` are **in the repository but edited in the org** — the create service was repointed to `MexalHttpClient`, which is not in git. **The PUT now has a caller** ([#125](notes/items/OI-125%20Mexal%20customer%20update%20needs%20a%20PUT%20method.md))                                            |
| **Nightly anagrafica sync**      | 🔴 **ORG ONLY** — `MexalCustomerSyncBatch`, `MexalCustomerSyncScheduler`, **`MexalSyncCursorService`** (the watermark #116 was blocked on). 🔴 **Not scheduled**                                                                                                                                                                                                                     |
| **Integration framework**        | ✅ **Configured.** `Integration_Configuration2__c` holds **6 rows**: `Anticipay_Account_Check`, `Mexal_Clienti_Ricerca`, `Mexal_Clienti_Creazione`, `Mexal_Clienti_Modifica`, `Mexal_Articoli_Ricerca`, `Mexal_Ordini_Creazione`. `Integration_Log__c` holds **85** rows (45 error-flagged). **3** named credentials — all org-only                                                  |
| **Anticipay**                    | ✅ Deployed and committed; `AnticipayAccountService` now matches source. Called as the first step of the order chain for a first order, **non-blocking on failure**. 🔴 `AnticipayErrorNotificationService` still addresses a hardcoded ROMI developer mailbox ([#119](notes/items/OI-119%20The%20Anticipay%20error%20notification%20goes%20to%20a%20hardcoded%20ROMI%20address.md)) |
| **Account model**                | ✅ `Azienda` / `Locale` record types, parent validation, company-delete protection, `CommercialAccountResolver`. 🔴 `AccountTriggerHandler` is **org-only in its current form** — it now pushes admin edits to Mexal                                                                                                                                                                 |
| **Custom objects**               | `BundleComponent__c`, `Tranche__c`, `Mappatura_Edizione__c`, `Event_Invitation__c`, `Integration_Configuration2__c`, `Integration_Log__c`, plus extensions to Account, Lead, Opportunity, Order, OrderItem, Product2, Quote, Asset                                                                                                                                                   |
| **Tranche**                      | ✅ Object, Quote-side creation UI and controller in source control and deployed. ✅ **Propagation has started — 3 of 36 order lines carry a tranche**, against 0 of 32 on 08/09. **40** quote lines linked. 🔴 Payment aggregation still unproven; `Sequenza__c` still has no integrity control                                                                                      |
| **Edition mapping**              | `Mappatura_Edizione__c` deployed with `MappaturaEdizioneTriggerHandler`. 🔴 **3 active rows against 43 ticket-generating products — 40 unmapped**                                                                                                                                                                                                                                    |
| **Invitations**                  | ✅ `Event_Invitation__c` with 14 fields, `EventInvitationService`, `EventInvitationUrlJob`, `ParticipantCommunityUrl`. 🔴 **3 records, all Pending/Ready, all without a recipient.** `EventInvitationService` is **org-only in its current form**                                                                                                                                    |
| **Ticket / Asset**               | Asset carries 8 custom fields and a Ticket record type. **15 records** — 14 `Ordinato`, 1 `Assegnato`. 🔴 **0 carry a QR id**; the lifecycle has never run end to end                                                                                                                                                                                                                |
| **Order lifecycle**              | ✅ Live and in use — **24 of 30** orders `Incassato`. `Order` carries `Origine__c`, `Quote__c`, `Locale__c`, `WooCommerce_Order_Key__c`, and now `Mexal_Integration_Status__c` + `Mexal_Order_Number__c` (**org-only**)                                                                                                                                                              |
| **Quote lifecycle**              | ✅ `Quote.Status` carries the agreed values. ⚠ The picklist only — nothing enforces it                                                                                                                                                                                                                                                                                               |
| **WooCommerce inbound**          | ✅ `WoocommerceOrderService` deployed **and now byte-identical to source** — the 08/09 drift is closed. 🔴 `INT-16` still unauthenticated                                                                                                                                                                                                                                            |
| **Community**                    | Quote-management and participant-registration pages, `Landing_Page1`. 🔴 No application-level authentication ([the risk](notes/risks/Risk%20-%20the%20community%20pages%20have%20no%20application-level%20authentication.md))                                                                                                                                                        |
| **UI**                           | `bundleProductAssignment`, `quoteCreateTranche`, `anticipayAccountRefresh` (**org-only**) LWCs                                                                                                                                                                                                                                                                                       |
| **Automation**                   | **10** Apex triggers, **66** classes in the org against 30 in the repository. 🔴 **Zero project-authored Flows** — all 66 active flows are Salesforce stock or managed templates                                                                                                                                                                                                     |

Written by the
[Calm-Coders developers working for ROMI](notes/Calm-Coders%20on%20GitHub%20means%20ROMI.md)
— Anita Aga, Sara Aga and Rexhina Hysi — plus Aurel Mrruku, whose work lands
**directly in the org**, which is why the written record repeatedly understates
what exists and the repository understates it too.

---

## What is not built

| Gap                                                                                                                                                                                                                   | Item                                                                                                                                                                                                        |
| --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| 🔴 **A schedule for the nightly Mexal sync.** The batch, the scheduler and the watermark all exist; all 7 `CronTrigger` rows are Salesforce platform jobs. **One `System.schedule` call is the whole remaining task** | [OI-116](notes/items/OI-116%20Nightly%20Mexal%20to%20Salesforce%20anagrafica%20sync.md)                                                                                                                     |
| 🔴 **The #117 administrative-field lock.** No validation rule, no field-level enforcement. The org instead **pushes** admin edits to Mexal — the opposite of the 03/09 agreement, with no minute                      | [OI-117](notes/items/OI-117%20Administrative%20fields%20lock%20once%20the%20Mexal%20customer%20code%20is%20set.md)                                                                                          |
| 🔴 **A conflict rule between the inbound nightly batch and the outbound admin push.** Two writers, same fields, opposite directions, nothing decided                                                                  | [OI-116](notes/items/OI-116%20Nightly%20Mexal%20to%20Salesforce%20anagrafica%20sync.md), [OI-117](notes/items/OI-117%20Administrative%20fields%20lock%20once%20the%20Mexal%20customer%20code%20is%20set.md) |
| 🔴 **Edition mappings** — 43 ticket-generating products, 3 mapped. An order for an unmapped product rolls back                                                                                                        | [OI-121](notes/items/OI-121%20The%20edition%20mapping%20table%20has%20no%20rows%20and%20no%20owner.md)                                                                                                      |
| 🔴 **Agent reassignment** (payload 2 of the nightly sync) — `cod_agente` is still unmapped, and the order header carries no agent or network field                                                                    | [OI-110](notes/items/OI-110%20Agent%20and%20network%20fields%20are%20missing%20from%20the%20Mexal%20order%20call.md)                                                                                        |
| 🔴 **Invitation dispatch** — 3 invitations, none with a recipient; no scheduler, no send tracking, no completion signal                                                                                               | [OI-78](notes/items/OI-78%20Participant%20data%20collection.md), [OI-126](notes/items/OI-126%20An%20asset%20flag%20for%20incomplete%20participant%20data.md)                                                |
| 🔴 **Signature → QR release** — 0 of 15 Assets carry a QR id; no signature process is invoked from any inspected controller                                                                                           | [OI-68](notes/items/OI-68%20Signature%20and%20QR%20release.md)                                                                                                                                              |
| 🔴 **Apex coverage** — **0 covered, 4,737 uncovered, 0%**, 60 entries. Unmeasured since 4 August, and the brief now includes classes that write to an external ERP                                                    | [OI-64](notes/items/OI-64%20The%20bundle%20Apex%20test%20suite%20is%20broken.md), [OI-66](notes/items/OI-66%20No%20test%20classes%20for%20the%20Biglietto%20stack.md)                                       |
| 🔴 **Credential metadata** — three named credentials exist only in the org, and **two** permission sets reference principals the repository never creates                                                             | [the risk](notes/risks/Risk%20-%20integration%20credentials%20exist%20only%20in%20the%20org.md)                                                                                                             |
| 🔴 **Declarative automation** — zero project-authored Flows, no workflow rule, no approval process, no notification type, no scheduled job                                                                            | [the flow](notes/flows/The%20quote%20to%20order%20flow.md)                                                                                                                                                  |
| Lead and Opportunity state machines are still stock Salesforce                                                                                                                                                        | [OI-69](notes/items/OI-69%20Order%20state%20model.md), [OI-59](notes/items/OI-59%20Quote%20workflow%20configuration.md)                                                                                     |
| The tranche remainder — payment aggregation unproven, `Sequenza__c` uncontrolled                                                                                                                                      | [OI-50](notes/items/OI-50%20Tranche%20object.md)                                                                                                                                                            |
| The whole phase 2 scope — no estimate exists                                                                                                                                                                          | [OI-83](notes/items/OI-83%20No%20phase%202%20estimate.md)                                                                                                                                                   |

---

## Blocking now, in order

1. **Retrieve the Mexal integration into source control. Today.**
   _Aurel Mrruku._ Nine Apex classes, two `Order` fields and three edited
   classes exist in the org and in no branch. **This is the cheapest item on this
   list and the most expensive to lose**: the work is written, it implements the
   agreed sequence, and only its custody is at risk. ⚠ **Do not deploy `DevMain`
   to this org before the retrieve** — that is the specific action that destroys
   it, because the repository's `OrderTriggerHandler` still calls
   `AnticipayOrderAutomation` and would orphan all nine classes
   ([the risk](notes/risks/Risk%20-%20the%20Mexal%20order%20integration%20exists%20only%20in%20the%20org.md)).
2. **Schedule the nightly sync, or record why not.** _Aurel Mrruku._ The batch,
   the scheduler and the watermark all exist. This has been "blocked on the sync
   window" since 3 September; **it is no longer blocked on a decision, it is one
   `System.schedule` call**. Choose the hour
   ([OI-116](notes/items/OI-116%20Nightly%20Mexal%20to%20Salesforce%20anagrafica%20sync.md)).
3. **Settle #117: lock, or two-way sync?** _Aurel Mrruku with Elisa Migliano._
   The client agreed to a read-only lock on 3 September. The system now does the
   opposite. Either is defensible; **the divergence is not, because Elisa agreed
   to the other one.** Whichever wins, the inbound batch and the outbound push
   need a **conflict rule** before the schedule is switched on
   ([OI-117](notes/items/OI-117%20Administrative%20fields%20lock%20once%20the%20Mexal%20customer%20code%20is%20set.md)).
4. **Run one order end to end and record the result.** _ROMI._ The chain has
   never executed: 30 orders, every `Mexal_Integration_Status__c` empty. Nothing
   yet proves that a second order for an existing customer reaches Mexal — which
   is the exact failure #125 was raised for. **UAT starts 23 September.**
5. **Populate the edition mappings.** _Fabrizio Paganelli, unowned on the ROMI
   side._ 43 ticket-generating products, 3 mapped. An order transition requiring
   tickets for an unmapped product **rolls back**. Unchanged since 8 September
   ([OI-121](notes/items/OI-121%20The%20edition%20mapping%20table%20has%20no%20rows%20and%20no%20owner.md)).
6. **Retrieve the credential metadata.** _Aurel Mrruku._ Three named credentials
   are org-only and **two** permission sets now reference principals the
   repository never creates — a clean deploy fails twice. Secrets stay in the
   org; the metadata belongs in git
   ([the risk](notes/risks/Risk%20-%20integration%20credentials%20exist%20only%20in%20the%20org.md)).
7. **Apex coverage — nothing ships to production until it clears 75%, and it
   reads 0%.** _Aurel Mrruku._ **4,737** uncovered lines, up from 2,957 on
   8 September — the steepest rise recorded. ⚠ **Read the number correctly:**
   the last test run in this org is **4 August**, so the stored 0% measures
   nothing about current code; the uncovered **count** is real, the percentage is
   unmeasured. ⚠ **This is one deliberate task, requested separately before the
   production deploy — it is not to be picked up mid-flight.** The records stay
   current so that task has a brief when it comes.

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

Twenty-two recorded. Severity is the note's own.

| Risk                                                                                                                              | Severity             |
| --------------------------------------------------------------------------------------------------------------------------------- | -------------------- |
| **The Mexal order integration exists only in the org** — 9 classes, ~28k characters; a `DevMain` deploy reverts it                | **new 14/09 · high** |
| Integration credentials exist only in the org — now **three** credentials and **two** permission sets; a clean deploy fails twice | **high**             |
| Salesforce integration credentials were circulated in plaintext — three secrets, three channels, three people                     | **gating**           |
| The community pages have no application-level authentication — a bare record id accepts or rejects a quote                        | **gating**           |
| Production deploy is blocked by Apex coverage — **4,737** uncovered lines, 0%, unmeasured since 4 August                          | high                 |
| A sandbox password was spoken aloud and preserved in a meeting transcript                                                         | high                 |
| The Biglietto Apex stack is not in source control                                                                                 | **critical**         |
| The Biglietto UAT ticket dataset was deleted — 37 records                                                                         | **critical**         |
| The ticket lifecycle has never run end to end — 0 of 15 Assets carry a QR id                                                      | high                 |
| The phase 2 scope dispute is unresolved, and the decision-maker was never told                                                    | high                 |
| Placeholder prices could reach the client — every UAT price is a ROMI invention                                                   | high                 |
| Normalising an article code merges two products                                                                                   | high                 |
| The whole remaining build lands after Ferragosto                                                                                  | high                 |
| The team lost access to the Pienissimo orgs on 1 September                                                                        | high                 |
| Real WooCommerce orders reached a third-party test server                                                                         | high                 |
| The Biglietto object diverged from the approved proposal                                                                          | medium               |
| A second Flow was deleted with no source copy                                                                                     | medium               |
| The tranche sequence has no integrity control                                                                                     | medium               |
| No coherence control on bundle composition                                                                                        | medium               |
| LeadConversionQueueable is broken in the Pienissimo sandbox                                                                       | medium               |
| ~~`OrderItem.Tranche__c` granted to no user~~ — **resolved**; propagation has now started, 3 of 36                                | resolved             |
| ~~A clean deploy would orphan the live WooCommerce endpoint~~ — **resolved**; the class is byte-identical to source               | resolved             |
| ~~The Anticipay field build has not started~~ — **resolved 04/09**                                                                | resolved             |

---

## Register coverage

|                                     |                                                                                                                                      |
| ----------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------ |
| Atomic notes                        | **226**                                                                                                                              |
| Item notes in `notes/items/`        | **95** — highest id `OI-134`                                                                                                         |
| Numbered rows in the client tracker | ~86                                                                                                                                  |
| Requirements reachable from a note  | **25 of 180**                                                                                                                        |
| Org components verified 2026-09-14  | **1,218** org vs **335** repository keys; **0** repository-only in the twelve kinds compared both ways; **0** project-authored Flows |
| Apex bodies compared                | **76** unmanaged classes and triggers — 27 equal, **12 mismatched** (8 at token level), **10** project classes org-only              |
| Stored Apex coverage                | **0 covered / 4,737 uncovered / 0%**, 60 entries — unmeasured since 4 August                                                         |

⚠ **Three honest gaps in the record itself.** The tracker carries roughly 86
numbered rows and **95** now have atomic notes, so the note set has overtaken the
tracker rather than trailing it — the two no longer correspond one to one. The
requirement trace is **25 of 180**: most signed requirements still cannot be
walked back to the meeting that produced them
([the trace](notes/The%20requirement%20mappings%20were%20fabricated.md)). And
**`MAP.md` is now 110 KB against a 5 KB budget** — it has become a running log
and needs its history moved into notes.

⚠ **The org inventory does not enumerate every metadata type.** ListView,
FlexiPage, StandardValueSet, PathAssistant, DigitalExperience, EmailTemplate
files, Site and Network are outside it, so the 88 keys reported repository-only
are **unverifiable, not absent**. In the twelve kinds compared both ways
repository-only is **zero**.

⚠ **`sf project retrieve preview` cannot be used on this org.** Pienissimo UAT
is a partial sandbox with no source tracking, so repository-vs-org divergence has
to be established component by component. Any check that skips that step will
silently miss org-only work — which is how nine Mexal classes went unrecorded
until today.

⚠ **And do not use `sf sobject describe` for that comparison.** It is filtered
by the running user's field-level security, so a deployed field granted to nobody
reads as never deployed. Use Tooling `FieldDefinition` for existence and
`FieldPermissions` for visibility —
[the method note](notes/How%20to%20read%20the%20org%20schema%20without%20a%20false%20negative.md).
The same shape recurred in Metadata API `listMetadata`, which cannot enumerate
folder-scoped types and reported zero email templates against an org holding 88.
**An empty result from an instrument that cannot enumerate the thing is silence,
not absence.**

✅ `npm run org-status:validate:strict` passes: 154 requirement ids, 200 registry
ids, 9 structural assertions, no unknown `build_state` references.

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
