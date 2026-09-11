---
id: OBJ-mexal-apex
type: object
status: active
owner: Anita Aga
org: ROMI
raised: 2026-09-10
updated: 2026-09-11
depends_on: [OI-58, OI-116]
blocks: [OI-109, OI-110, OI-117, OI-125]
source: git DevMain b9cfc1b (PR #39, merged 2026-09-11), Apex and metadata read directly 2026-09-10 and 2026-09-11
---

# The first Mexal integration Apex

> ## 2026-09-11 — merged, and then superseded the same day
>
> ✅ **PR #39 merged at 08:27Z (10:27 CEST)** as `b9cfc1b`. Everything below,
> written while it was an open branch, is now the state of `DevMain`.
>
> 🔴 **But two of its central claims no longer hold.** Nine and a half hours
> later `80420cf` (PR #41) added a Mexal **write** path and gave the search
> service **DML**, so:
>
> - _"This code cannot create or modify a Mexal record, by construction"_ —
>   **superseded.** The read-only guard still stands for the read actions, but a
>   second, separately allow-listed write path now exists beside it.
> - _"Nothing is written to Salesforce … OI-116 is a read, not yet a sync"_ —
>   **superseded.** `MexalCustomerSearchService` now inserts and updates
>   `Account`.
>
> Both are recorded in
> [the Mexal customer create and update path](The%20Mexal%20customer%20create%20and%20update%20path.md),
> which is the current build note. **This note describes `bc2ed5d` as it was on
> 10 September and is kept for the record.** Read it as history, not as state.

**Commit `bc2ed5d`** (Anita Aga, _"Edited Create Tranch Lwc, and opportunity
custom path, added logic for Mexal Integration"_), pushed **2026-09-10 17:58
CEST**, opened as **PR #39 `Dev anita`** against `DevMain` two minutes later.
**17 files, +682 / -94 lines; +496 new Apex lines.**

🔴 **It is NOT merged.** PR #39 is open at the time of this note, with no review
and no description. `DevMain` still ends at `9113453`. Everything below is
proposed code, not the state of the working branch.

⚠ **Read from the repository, not from the org.** Nothing here has been verified
against UAT, and no test was run.

**This is the first Mexal Apex that has ever existed in this repository.** Every
Mexal decision since 2026-07-07 has been design; this is the first transport.

## What it builds

### `MexalSearchCalloutService` — 260 lines, the transport

A generic Mexal callout wrapper reading its endpoint from
`Integration_Configuration__c`, ROMI's standard scaffolding.

🟢 **Authentication is a Named Credential, and the credential never reaches the
log.** The endpoint is built as `callout:<named credential><path>`, chosen
sandbox-vs-production from `Named_Credential_Sandbox__c` /
`Named_Credential_Prod__c` with a `Mexal` default, and the `Integration_Log__c`
row records the Authorization header literally as
`Authorization=<managed by Named Credential>`. After the sixty-year JWT
([the plaintext-credential risk](../risks/Risk%20-%20Salesforce%20integration%20credentials%20were%20circulated%20in%20plaintext.md))
this is the first integration in the project built the right way round.

🟢 **It is hard-guarded read-only.** Three independent checks refuse anything
else: an allow-list of exactly two actions (`Mexal_Clienti_Ricerca`,
`Mexal_Articoli_Ricerca`), a refusal of any `Endpoint_Path__c` not ending
`/ricerca`, and a refusal of any method but `POST`. **This code cannot create or
modify a Mexal record**, by construction.

🔴 **The named credential and its external credential are org-only.** The repo
has **no `namedCredentials/` directory at all**, yet `Full_Permission` now grants
`Mexal_External_Credential-Mexal_Principal`. A permission set that names a
principal the org does not hold **fails to deploy** — so this is no longer only
the standing
[org-only credential risk](../risks/Risk%20-%20integration%20credentials%20exist%20only%20in%20the%20org.md),
it is a deployability defect in a file that ships.

🔴 **It has no rows to run against.** `Integration_Configuration__c` held **zero
records** at the last org check
([the scaffolding note](The%20integration%20scaffolding%20has%20never%20been%20configured.md)).
Without a row for each action name the service throws
_"Configurazione Mexal non trovata per azione"_ on the first call. Same shape as
[OI-121](../items/OI-121%20The%20edition%20mapping%20table%20has%20no%20rows%20and%20no%20owner.md):
a hand-maintained table with no rows and no named owner.

⚠ `IS_SANDBOX` is a **static SOQL on `Organization`** evaluated at class
initialisation — one query per transaction that touches the class.

### `MexalCustomerSearchService` — 236 lines, the anagrafica read

Builds the agreed `data_ult_mod >= <yyyyMMdd HHmmss>` filter, calls the transport,
and maps the response onto `Account`. Fourteen fields:

`codice → Codice_Cliente_Mexal__c` · `partita_iva` · `codice_fiscale` ·
`ragione_sociale`/`denominazione`/`cognome → Name` (first populated) ·
`indirizzo`/`cap`/`localita`/`provincia`/`cod_paese → Billing*` · `telefono` ·
`url → Website` · `pec → PEC__c` · IBAN · `codice_sdi → Codice_Destinatario_SDI__c`.

⚠ **The mapping handles personal and banking data** — codice fiscale, PEC, IBAN.
Recorded as existing. **No value is copied into this repository.**

## What it does not build, and says so itself

🔴 **The nightly schedule is deliberately absent.** `searchModifiedToday()` and a
`MexalCustomerSearchScheduler` are written out **as comments**, with the reason
in the code: _"Automatic daily search is intentionally paused while the Mexal
sync schedule and date window are finalized."_ The comment then lists the three
steps to switch it on, including the cron `0 0 2 * * ?`.

That is an honest open item that names its own blocker, and the blocker is one
[OI-116](../items/OI-116%20Nightly%20Mexal%20to%20Salesforce%20anagrafica%20sync.md)
has carried since 3 September: **"nightly" is still the whole specification.**

🔴 **Nothing is written to Salesforce.** `mappedAccounts` is a `List<Account>` of
in-memory objects handed back to the caller. There is **no DML, no upsert, and no
matching on `Codice_Cliente_Mexal__c`** anywhere in either class. The flow reads
and maps; it does not persist. **OI-116 is a read, not yet a sync.**

🔴 **The agent-reassignment payload is not handled.** OI-116 carries two agreed
payloads; only the general registry edit is mapped. `cod_agente` is not among the
fourteen fields.

🔴 **[OI-117](../items/OI-117%20Administrative%20fields%20lock%20once%20the%20Mexal%20customer%20code%20is%20set.md)
is untouched** — no validation rule, no lock. The two are one design, and
building the inbound read without the lock is the divergence that note warns of.

## ⚠ A mapping to check before this merges

`IBAN__c` is assigned `chooseFirstPopulated(banca_appoggio, buildIban(...))` —
so **the bank-name field wins over the assembled IBAN** whenever it is populated.
`buildIban` correctly concatenates `pae_iban` + `cin_iban` (left-padded to 2) +
`iban_libero`, and then only runs if `banca_appoggio` is blank.

**Read from the code, not confirmed against a live Mexal response.** If
`banca_appoggio` is what its name suggests, `IBAN__c` will fill with a bank name
for every customer that has one. Worth one look before merge.

## The rest of the commit

🟢 **The Italian translation decision is being executed.** Every user-facing
string in `opportunityCustomPath`, `quoteCreateTranche`, the `Crea Tranche` quick
action and label, two `QuoteTrancheController` exceptions and the lead follow-up
task description is now Italian. That is the
**whole-system decision taken unpriced at
[Data Model Parte 1](../meetings/2026-09-03%20Data%20Model%20Parte%201.md)** on
3 September, and this is the first evidence of anyone building it.

🟢 **Two functional fixes on the tranche editor.** `QuoteTrancheController` now
excludes tranches being deleted in the same save from its "already assigned to a
tranche" guard — previously reassigning a line off a doomed tranche threw. And
`showDeleteCurrentPage` now allows deleting an empty tranche in **edit** mode,
not only in create mode.

🟢 The lead follow-up task gets `IsReminderSet` with a reminder at +48h.

🔴 **No Opportunity or Quote state value changed** — only the labels around them.
The Quote-state disagreement in
[OI-59](../items/OI-59%20Quote%20workflow%20configuration.md) survives untouched.

🔴 **+496 uncovered Apex lines**, taking the estimate past **4,182**, with the
last Apex test run still **4 August**. Recorded as brief in
[OI-64](../items/OI-64%20The%20bundle%20Apex%20test%20suite%20is%20broken.md) and
[the deploy risk](../risks/Risk%20-%20production%20deploy%20is%20blocked%20by%20Apex%20coverage.md).
**Nothing acted on; no test written or proposed.**

## Where it came from

Aurel Mrruku sent Anita Aga a file named **`Mexal Dev v.2.postman_collection`**
in their Slack DM at **14:45:51 CEST on 10 September**. The commit landed
**three hours and thirteen minutes later** and implements the collection's
customer-search call. The collection is the source of the wire facts now recorded
in [the Mexal integration](../flows/The%20Mexal%20integration.md).

🔴 **That file carries the Mexal WEBAPI credential in plaintext**, in the
`Authorization` header of all fourteen requests
([the risk](../risks/Risk%20-%20Salesforce%20integration%20credentials%20were%20circulated%20in%20plaintext.md)).
**The value is not in this repository and must never be.**
