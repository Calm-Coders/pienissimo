# ROMI - PIENISSIMO - Project Status

> **ROMI internal.** Candid about delivery and the client relationship. **Do not
> grant Pienissimo access to this page** — the client-facing view is the public
> page in [site/](site/), which is sanitized to different rules
> ([docs/publishing.md](docs/publishing.md)).

**Last regenerated: 2026-09-23 (org-status-check, full scope, reconciled and published)** ·
**Basis: a live, read-only check of the Pienissimo UAT org**
(`a.mrruku@pienissimo.uat`, `00DMA000004nMMr2AM`, API 68.0) run on
**2026-09-23, 08:01–08:40Z**, comparing **442** repository component keys on
`DevMain` at `61f2a53` against **1,382** org components, plus a token-by-token
comparison of every unmanaged Apex class, trigger and LWC body, each mismatch
matched against the git history of every branch. This supersedes the 2026-09-14
published check. Everything below marked as built or not built was **observed in
the org on 23 September**, unless the row says otherwise.

🔴 **The finding that matters most, the day before UAT opens: what the client
will test is not what `DevMain` holds — in both directions.** UAT runs the
**21/09 Lead conversion**, so every converted Opportunity becomes `Standart` and
the Lead-type picklist does nothing
([OI-170](notes/items/OI-170%20DevMain%20is%20ahead%20of%20UAT%20on%20the%20Lead%20conversion%20and%20quote-line%20paths.md)).
And UAT carries a **bundle discount deployed at 08:00Z today that is in no commit**
([OI-171](notes/items/OI-171%20A%20bundle%20discount%20was%20deployed%20to%20UAT%20from%20no%20commit.md)),
which the deploy needed to fix the first problem would overwrite. **Commit, then
deploy — in that order, today.**

🔑 **And the Web-to-Lead defect has a cause.** The user that creates form leads
cannot see either Lead record type
([OI-164](notes/items/OI-164%20Web%20to%20Lead%20leads%20arrive%20without%20a%20record%20type.md)).
It is a configuration fix measured in minutes.

⚠ **Instruments that report silence as absence — and presence that proves
nothing.** `sf sobject describe` filters by field-level security, and
`listMetadata` cannot enumerate folder-scoped types; both have produced false
absences here
([the method note](notes/How%20to%20read%20the%20org%20schema%20without%20a%20false%20negative.md)).
This run adds the opposite trap: **every repository component is present in the
org, and eight files still differ.** A structural comparison alone would have
called this org aligned.

Generated from [notes/](notes/), which is the source of record. If this page and
a note disagree, the note wins — regenerate this page rather than editing facts
into it. Agent-facing equivalent: [MAP.md](MAP.md).

---

## At a glance

|                                                   |                                                                                                                                                                                                 |
| ------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| 🔴 **UAT runs older Lead code than `DevMain`**    | `LeadConversionQueueable` is the 21/09 version: **every converted Opportunity becomes `Standart`**. OI-150's _"check-only deploy"_ changed nothing. Quote reopen-to-Bozza also missing (OI-170) |
| 🔴 **Uncommitted code in UAT since 08:00Z today** | Bundle discount / manual price in Manage Products, via the shared `ROMI COMPANY` login; in no commit on any branch. **A `DevMain` deploy overwrites it** (OI-171)                               |
| 🔑 **Web-to-Lead cause found**                    | Creator `Amministratore Pienissimo` (System Administrator) sees **neither Lead record type** and lacks `Full_Permission`. All 4 web leads of 22/09 untyped. Configuration fix (OI-164)          |
| 🟢 **The Mexal chain is in source control**       | The 14/09 org-only finding is **closed** — the nine classes and two `Order` fields are on `DevMain`, and the org equals source except for formatting                                            |
| 🔴 **…and has never run in UAT**                  | **0 of 45** orders carry a Mexal status; the `isSandbox()` guard is still in place. **Mexal UAT is 6/10** (OI-137)                                                                              |
| 🟢 **Credential metadata is in source control**   | 3 named + 3 external credentials in `force-app/`; the "clean deploy fails twice" finding is gone. Production swap still owed                                                                    |
| 🔴 **Contract: zero fields**                      | Standard `Contract`, no custom field, nothing writes it. **UAT 5/10** (OI-168)                                                                                                                  |
| 🔴 **Check-in: 0 of 31 tickets have a QR**        | No check-in endpoint. **Ticket UAT 30/09** (OI-161); 38 of 51 ticket products still unmapped (OI-121)                                                                                           |
| 🔴 **Coverage 0 of 7,756 lines**                  | Up from 4,737 nine days ago; 3 test classes of 57. Unmeasured since 4 August. **Production deploy has no calendar slot for it**                                                                 |
| 🟢 **Movement that is real**                      | Quote ageing scheduled daily · DocuSign 15 envelope jobs in 7 days · tranche on 15 of 60 order lines · edition mapping 13 of 51 · `Happy Team` present                                          |
| **Zoho expires 31 October 2026**                  | **Go-live Fase 1 is 21 October.** UAT sessions 24/09 → 06/10, approval by 13/10                                                                                                                 |

---

## Where the project stands

ROMI is migrating Pienissimo from **Zoho CRM to Salesforce**. The contract-bound
constraint is the Zoho expiry on **31 October 2026**. **Go-live Fase 1 is
21 October**, moved by ROMI in writing on 8 September and acknowledged by
Fabrizio Paganelli on 9 September
([OI-124](notes/items/OI-124%20Go-live%20moved%20from%206%20to%2021%20October.md)).
**UAT is booked and client-confirmed:** 24/09 Lead e Opportunità · 25/09
Preventivi and WooCommerce · 30/09 Biglietti, Campagne ed Eventi · 02/10 Flussi
MKT · 05/10 Performance Plus, date pagamento and `Contratto` · 06/10 Integrazione
Mexal and Anticipay. Approval by 13 October.

**The build is moving fast and deploying informally.** Fourteen merges since
14 September. None of them has a named step that deploys to UAT, and the shared
admin login deploys work that has no commit. **UAT is a Partial Copy sandbox**
([OI-153](notes/items/OI-153%20There%20is%20no%20full%20UAT%20sandbox.md)) with
**three active human users, all System Administrators**. The client tester
accounts are promised for 6–13 October.

**Data migration was never planned or estimated**
([OI-165](notes/items/OI-165%20Data%20migration%20was%20never%20planned%20or%20estimated.md)),
with go-live 21/10 and Zoho expiring 31/10.

---

## What is built

**Verified against the Pienissimo UAT org on 2026-09-23**, read-only, and
cross-checked against `force-app/` on `DevMain` at `61f2a53`. 🟢
**Repository-only drift is zero** in the twelve kinds compared both ways. 🔴
**Version drift is the problem**: 7 Apex files and 1 LWC bundle differ at token
level, in both directions.

| Area                        | State                                                                                                                                                                                                                                                                                                           |
| --------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Order → Mexal chain**     | ✅ **In source control and deployed** — Mark Running → Anticipay (first order only) → Mexal Customer → Mexal Order. 🔴 **Never executed in UAT**: `isSandbox()` guard, 0 of 45 orders with a status ([OI-137](notes/items/OI-137%20The%20order%20to%20Mexal%20chain%20is%20disabled%20in%20every%20sandbox.md)) |
| **Nightly anagrafica sync** | Batch, scheduler and watermark deployed and in source. 🔴 **Not scheduled** ([OI-116](notes/items/OI-116%20Nightly%20Mexal%20to%20Salesforce%20anagrafica%20sync.md))                                                                                                                                           |
| **Admin-field lock (#117)** | ✅ `Lock_Mexal_Synced_Admin_Fields` active since 15/09 (13 fields). ⚠ The outbound push of four fields also still exists; the client has not been told ([OI-117](notes/items/OI-117%20Administrative%20fields%20lock%20once%20the%20Mexal%20customer%20code%20is%20set.md))                                     |
| **Integration framework**   | ✅ `Integration_Configuration2__c` **11 rows** (up from 6). `Integration_Log__c` 113 rows; last 7 days: DocuSign 11 ok / 4 error, WooCommerce 4 ok / 5 error, Anticipay 1 / 1                                                                                                                                   |
| **Credentials**             | ✅ Anticipay, DocuSign, Mexal — named and external credential metadata **in source**. 🔴 DocuSign is on the demo environment; the production swap has no owner or date                                                                                                                                          |
| **DocuSign**                | ✅ Quote → envelope → signed → order ran end to end on 22/09; `DocuSignQuoteEnvelopeQueueable` completed 15 times in 7 days                                                                                                                                                                                     |
| **Lead**                    | ✅ Record types `Standard` / `Diretta`, `Tipo_Opportunita__c`, conversion trigger. 🔴 **Conversion code is the 21/09 version** (OI-170). 🔴 Web-to-Lead leads untyped (OI-164). Stock duplicate rules only (OI-163)                                                                                             |
| **Opportunity**             | ✅ Record types `Standart` (🔴 still misspelt), `Plus_Attivazione_Rinnovo`, `Recall_Tutor`; 15 / 5 / 3 created in the last 7 days. Only `Full_Permission` grants them                                                                                                                                           |
| **Quote**                   | ✅ Five Italian statuses. ✅ **5-day ageing scheduled** (daily 01:00 UTC, 3 runs). 🔴 Reopen-to-Bozza on a new line **not deployed** (OI-170). 🔴 Manage Products bundle discount **uncommitted** (OI-171)                                                                                                      |
| **Tranche**                 | ✅ 50 tranches; **58 of 76** quote lines and **15 of 60** order lines carry one (3 of 36 on 14/09). ✅ `Product2.Numero_Tranche__c` deployed 22/09 for the Plus explosion. 🔴 Payment roll-up waits on the order-line identifier (OI-166)                                                                       |
| **Edition mapping**         | 🟢 **13 of 51** ticket-generating products mapped (3 of 43 on 14/09). 🔴 38 unmapped — an order for one rolls back its ticket step                                                                                                                                                                              |
| **Ticket / Asset**          | Asset with Ticket record type, `QR_Id__c`, `Data_CheckIn__c`; 31 records. 🔴 **0 carry a QR**; nothing writes check-in                                                                                                                                                                                          |
| **Order lifecycle**         | ✅ In use — 32 `Incassato`, 9 `Ordinato`, 1 `Fatturato` of 45. 3 legacy records on stock English values                                                                                                                                                                                                         |
| **WooCommerce**             | ✅ Inbound endpoint, Funnel Kit checkout link, email template — proved end to end with the client on 21/09. ⚠ 5 errors in 7 days in the log                                                                                                                                                                     |
| **Community**               | Quote-acceptance and participant pages. 🔴 No application-level authentication ([the risk](notes/risks/Risk%20-%20the%20community%20pages%20have%20no%20application-level%20authentication.md))                                                                                                                 |
| **Sharing**                 | 🔴 **19** classes `without sharing` on `DevMain`, **15** in UAT — four of 22/09 undeployed and undecided ([OI-156](notes/items/OI-156%20QuoteTriggerHandler%20runs%20without%20sharing.md))                                                                                                                     |
| **Automation**              | 12 triggers, 57 project classes. 🔴 **Zero project-authored Flows**                                                                                                                                                                                                                                             |

Written by the
[Calm-Coders developers working for ROMI](notes/Calm-Coders%20on%20GitHub%20means%20ROMI.md)
— Anita Aga, Sara Aga and Rexhina Hysi — plus Aurel Mrruku.

---

## What is not built

| Gap                                                                                                                           | Item                                                                                                              |
| ----------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------- |
| 🔴 **Contract logic** — zero fields on `Contract`, nothing writes it. **UAT 5/10**                                            | [OI-168](notes/items/OI-168%20Contract%20logic%20is%20not%20started%20and%20is%20on%20the%205%20October%20UAT.md) |
| 🔴 **Event check-in** — no QR on any ticket, no inbound endpoint; a custom Android scanner talks to Zoho today. **UAT 30/09** | [OI-161](notes/items/OI-161%20The%20event%20check-in%20app%20must%20integrate%20with%20Salesforce.md)             |
| 🔴 **Data migration** — never planned or estimated                                                                            | [OI-165](notes/items/OI-165%20Data%20migration%20was%20never%20planned%20or%20estimated.md)                       |
| 🔴 **Mexal chain runnable in a sandbox** — code guard, not configuration. **UAT 6/10**                                        | [OI-137](notes/items/OI-137%20The%20order%20to%20Mexal%20chain%20is%20disabled%20in%20every%20sandbox.md)         |
| 🔴 **The order-line identifier for Mexal** — the last hop of payment → tranche                                                | [OI-166](notes/items/OI-166%20The%20order%20line%20needs%20a%20shared%20identifier%20for%20Mexal.md)              |
| 🔴 **Agent from the customer record** — no field anywhere. The conversion block recorded as built on 22/09 was announced only | [OI-169](notes/items/OI-169%20Agent%20code%20and%20commissions%20come%20from%20the%20customer%20record.md)        |
| 🔴 **Lead duplicate rule** — five undecided cases, stock rules only                                                           | [OI-163](notes/items/OI-163%20Lead%20conversion%20has%20no%20agreed%20duplicate%20rule.md)                        |
| 🔴 **Nightly sync schedule**                                                                                                  | [OI-116](notes/items/OI-116%20Nightly%20Mexal%20to%20Salesforce%20anagrafica%20sync.md)                           |
| 🔴 **Apex coverage** — **0 of 7,756, 0%**, 79 entries                                                                         | [OI-64](notes/items/OI-64%20The%20bundle%20Apex%20test%20suite%20is%20broken.md)                                  |
| 🔴 **Credit notes and storni** — unbuilt and undefined                                                                        | [OI-157](notes/items/OI-157%20Credit%20notes%20and%20storni%20are%20unbuilt%20and%20undefined.md)                 |
| 🔴 **The RID mandate form** promised to customers                                                                             | [OI-152](notes/items/OI-152%20The%20RID%20mandate%20form%20promised%20to%20customers%20does%20not%20exist.md)     |
| Declarative automation — zero project Flows, no approval process, no scheduled report                                         | [the flow](notes/flows/The%20quote%20to%20order%20flow.md)                                                        |
| The whole phase 2 scope — no estimate                                                                                         | [OI-83](notes/items/OI-83%20No%20phase%202%20estimate.md)                                                         |

---

## Blocking now, in order

The order is by the UAT calendar: the item that can still spoil the nearest
session comes first.

1. **Fix the Web-to-Lead record type — today, before the 24/09 session.**
   _Rexhina Hysi, with Aurel Mrruku._ Either make `Standard` / `Diretta` visible with a
   default on the System Administrator profile, or assign `Full_Permission` (or a
   narrower set) to `Amministratore Pienissimo`. Configuration, not code. Then re-run
   Elena Spini's form test
   ([OI-164](notes/items/OI-164%20Web%20to%20Lead%20leads%20arrive%20without%20a%20record%20type.md)).
2. **Commit the bundle discount, then deploy the Lead conversion — today, in that
   order.** _The author of the 08:00Z change, then whoever deploys._ The uncommitted
   Manage Products change
   ([OI-171](notes/items/OI-171%20A%20bundle%20discount%20was%20deployed%20to%20UAT%20from%20no%20commit.md))
   must reach a branch before any `DevMain` deploy. Then `LeadConversionQueueable` must
   reach UAT, or the 24/09 session must be told that conversion always yields
   `Standart`
   ([OI-170](notes/items/OI-170%20DevMain%20is%20ahead%20of%20UAT%20on%20the%20Lead%20conversion%20and%20quote-line%20paths.md)).
   ⚠ A full `DevMain` deploy also brings the four undecided `without sharing` changes
   into UAT ([OI-156](notes/items/OI-156%20QuoteTriggerHandler%20runs%20without%20sharing.md)).
   A targeted deploy of the Lead class avoids making that decision by accident.
3. **Settle the Lead conversion rules, or name them as UAT questions.** _Aurel
   Mrruku with Elena Spini._ Five duplicate cases are undecided
   ([OI-163](notes/items/OI-163%20Lead%20conversion%20has%20no%20agreed%20duplicate%20rule.md)).
   The agent-required block is not built
   ([OI-169](notes/items/OI-169%20Agent%20code%20and%20commissions%20come%20from%20the%20customer%20record.md))
   — keep it that way until the client answers.
4. **Name who deploys a merged PR to UAT.** _Aurel Mrruku._ Both of today's
   findings come from the same gap. It will recur before every remaining UAT session.
5. **Ticket UAT 30/09: check-in and mappings.** _Aurel Mrruku; Fabrizio Paganelli for
   the mappings._ No ticket has a QR, nothing reads one, and 38 of 51 ticket products are
   unmapped
   ([OI-161](notes/items/OI-161%20The%20event%20check-in%20app%20must%20integrate%20with%20Salesforce.md),
   [OI-121](notes/items/OI-121%20The%20edition%20mapping%20table%20has%20no%20rows%20and%20no%20owner.md)).
6. **Contract UAT 5/10: start it.** _Aurel Mrruku._ Zero fields, zero code, twelve
   days
   ([OI-168](notes/items/OI-168%20Contract%20logic%20is%20not%20started%20and%20is%20on%20the%205%20October%20UAT.md)).
7. **Mexal UAT 6/10: make the chain runnable in a sandbox.** _Aurel Mrruku._ Replace
   the `isSandbox()` guard with configuration (`Use_Mock__c`, the sandbox named
   credential), or agree with the client how Mexal is accepted. Schedule the nightly
   sync. Get the order-line identifier agreed
   ([OI-137](notes/items/OI-137%20The%20order%20to%20Mexal%20chain%20is%20disabled%20in%20every%20sandbox.md),
   [OI-116](notes/items/OI-116%20Nightly%20Mexal%20to%20Salesforce%20anagrafica%20sync.md),
   [OI-166](notes/items/OI-166%20The%20order%20line%20needs%20a%20shared%20identifier%20for%20Mexal.md)).
8. **Plan and estimate the data migration.** _Aurel Mrruku._ Go-live is 21/10 and
   Zoho expires 31/10; there is no slot on the calendar
   ([OI-165](notes/items/OI-165%20Data%20migration%20was%20never%20planned%20or%20estimated.md)).
9. **Apex coverage before the production deploy.** _Aurel Mrruku._ **0 of 7,756**
   lines. ⚠ **This is one deliberate task, requested separately before the production
   deploy — it is not to be picked up mid-flight.** It also has no calendar slot
   between approval on 13/10 and go-live on 21/10. The records stay current so the
   task has a brief when it comes.

---

## The client's product registry, read 2026-08-24

`Prodotti e Bundle.xlsx` — Fabrizio Paganelli's attachment of **7 August**,
forwarded 18 August, **opened 24 August**. Decode:
[the workbook](notes/The%20Prodotti%20e%20Bundle%20workbook.md).

| It settled                                                                                                                     | It broke                                                                                                                             |
| ------------------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------ |
| **Real catalogue prices delivered** — [OI-87](notes/items/OI-87%20Real%20catalogue%20prices%20still%20outstanding.md) resolved | The built event picklist was wrong — ✅ **`Happy Team` is now present** (verified 23/09)                                             |
| The event list: **11 events in 4 types**, not the 7 on record                                                                  | The `Anno_Solare__c` → `Evento__c` matrix has **no client source**                                                                   |
| Tier vocabulary: `EXECUTIVE` / `GOLD` / `DIAMOND` — **`Silver` and `Dinamond` both die**                                       | The tier **field still does not exist**, so [OI-76](notes/items/OI-76%20Ticket%20type%20picklist%20on%20the%20product.md) stays open |
| A bundle is **two levels deep**: `PACK` → `BLO` (blocco) → article                                                             | `BundleComponent__c` is **flat** and cannot express the middle level                                                                 |
| The `(B)` bundle-code convention looks **obsolete, not forgotten**                                                             | [OI-93](notes/items/OI-93%20Bundle%20components%20should%20be%20priced%20articles.md) — a client change request nobody knew existed  |

⚠ **One rule from it binds the import.** `_ARCOD` is an **opaque string**: two
pairs of codes differ only by a separator or a leading zero and name **different
events**. **No trim, pad, separator-strip or case-fold, anywhere.**
[The risk](notes/risks/Risk%20-%20normalising%20an%20article%20code%20merges%20two%20products.md).

---

## Open risks

Sixteen open. Severity is the note's own.

| Risk                                                                                                          | Severity     |
| ------------------------------------------------------------------------------------------------------------- | ------------ |
| Salesforce integration credentials were circulated in plaintext                                               | **gating**   |
| The community pages have no application-level authentication — a bare record id accepts or rejects a quote    | **gating**   |
| The Biglietto Apex stack is not in source control                                                             | **critical** |
| Integration credentials exist only in the org — 🟢 **metadata part closed 23/09**; production swap still owed | high         |
| Production deploy is blocked by Apex coverage — **0 of 7,756**, unmeasured since 4 August, no calendar slot   | high         |
| The Mexal integration is developed against the production ERP                                                 | high         |
| The ticket lifecycle has never run end to end — 0 of 31 Assets carry a QR                                     | high         |
| The phase 2 scope dispute is unresolved                                                                       | high         |
| Placeholder prices could reach the client                                                                     | high         |
| A sandbox password was spoken aloud and preserved in a meeting transcript                                     | high         |
| The whole remaining build lands after Ferragosto                                                              | high         |
| Normalising an article code merges two products                                                               | high         |
| The Biglietto object diverged from the approved proposal                                                      | medium       |
| A second Flow was deleted with no source copy                                                                 | medium       |
| The tranche sequence has no integrity control                                                                 | medium       |
| No coherence control on bundle composition                                                                    | medium       |
| ~~The Mexal order integration exists only in the org~~ — **resolved 15/09**, verified in source 23/09         | resolved     |

⚠ Today's two version-drift findings are recorded as **items**, not risks,
because each has a concrete action:
[OI-170](notes/items/OI-170%20DevMain%20is%20ahead%20of%20UAT%20on%20the%20Lead%20conversion%20and%20quote-line%20paths.md)
and
[OI-171](notes/items/OI-171%20A%20bundle%20discount%20was%20deployed%20to%20UAT%20from%20no%20commit.md).

---

## Register coverage

|                                     |                                                                                                                                                                          |
| ----------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| Atomic notes                        | **292**                                                                                                                                                                  |
| Item notes in `notes/items/`        | **132** — highest id `OI-171`; **112 active** (87 open, 25 in progress), **13 gating**                                                                                   |
| Numbered rows in the client tracker | **160**                                                                                                                                                                  |
| Requirements traced to a note       | **27 of 154** carry `tracked_by`                                                                                                                                         |
| Org components verified 2026-09-23  | **1,382** org vs **442** repository keys; **0** repository-only in the twelve kinds compared both ways; **0** project-authored Flows                                     |
| Apex and LWC bodies compared        | **69** project classes and triggers — 50 identical, 12 formatting-only, **7 at token level** (6 repository-ahead, 1 org-ahead); **1** LWC bundle differs, **1** org-only |
| Stored Apex coverage                | **0 covered / 7,756 uncovered / 0%**, 79 entries — unmeasured since 4 August                                                                                             |

⚠ **Honest gaps in the record itself.** The requirement trace is **27 of 154**:
most signed requirements still cannot be walked back to the meeting that produced
them ([the trace](notes/The%20requirement%20mappings%20were%20fabricated.md)). And
**`MAP.md` is now about 145 KB against a 5 KB budget** — it is a running log and
needs its history moved into notes.

⚠ **Presence is not version.** On 23/09 every repository key existed in the org
and eight files still differed. Only a body comparison matched to git history
tells _merged but never deployed_ from _deployed but never committed_ — and today
both happened.

⚠ **`sf project retrieve preview` cannot be used on this org** (partial sandbox,
no source tracking), and **`sf sobject describe` must not be used for field
existence** — [the method note](notes/How%20to%20read%20the%20org%20schema%20without%20a%20false%20negative.md).

✅ `npm run org-status:validate:strict` passes: 154 requirement ids, 200 registry
ids, 9 structural assertions, no unknown `build_state` references.

---

## Who is who

**ROMI** — **Elena Spini** chairs and owns the client relationship. **Aurel
Mrruku** is technical lead. **Anita Aga**, **Sara Aga** and **Rexhina Hysi** write
the build. **Andrea Di Cicco** owned the Mexal integration and is winding down
([OI-139](notes/items/OI-139%20Andrea%20Di%20Cicco%20is%20winding%20down%20with%20four%20integration%20questions%20unanswered.md)).

**Pienissimo** — **Daniela Morgese** decides and signs commercially. **Fabrizio
Paganelli** is the day-to-day referent **since 21 September** and owns the product
registry. **Sabatino Rinaldi** keeps WooCommerce and the marketing forms. **Elisa
Migliano** is the operational authority on administration, invoicing and the
infopoint. **Marco Montesi** sales. **Andrea Parmeggiani** runs the event check-in
app.

**Vendors** — **Mirko Merendi** (Kreosoft) for Mexal.

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
