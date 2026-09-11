---
id: OBJ-mexal-write-path
type: object
status: active
owner: Anita Aga
org: ROMI
raised: 2026-09-11
updated: 2026-09-11
depends_on: [OI-116, OI-125]
blocks: [OI-117, OI-121]
requirement: INT-01
source: git DevMain 80420cf (PR #41, merged 2026-09-11 16:05Z), Apex and metadata read directly
---

# The Mexal customer create and update path

**Commit `80420cf`** (Anita Aga, _"Added logic for API calls
(Ricerca,Creazione,Modifica) rebuilt the Integration Configuration object."_),
pushed **2026-09-11 17:57 CEST**, opened as **PR #41 `Dev anita`** at 17:58 and
**merged by Aurel Mrruku at 18:05 CEST** (`c9a0b7e`). **32 files, +1,326 / −193
lines.**

**This is the first code in the project that writes to Mexal.** Every Mexal
artifact before it — the 10 September Apex included — could only read.

⚠ **Read from the repository, not from the org.** Nothing here has been verified
against UAT, no test was run, and PR #41 carries **no description and no
review**: opened and merged seven minutes apart.

## 1. 🟢 The read-only guard was extended, not removed

The natural fear on seeing "Creazione, Modifica" in a commit message is that the
three read-only guards of 10 September were deleted to make room. **They were
not.** `MexalSearchCalloutService` now carries **two** allow-lists:

| Set                 | Members                                                | Entry point                      |
| ------------------- | ------------------------------------------------------ | -------------------------------- |
| `READ_ONLY_ACTIONS` | `Mexal_Clienti_Ricerca`, `Mexal_Articoli_Ricerca`      | `sendReadOnly` → `/ricerca`, POST |
| `WRITE_ACTIONS`     | `Mexal_Clienti_Creazione`, `Mexal_Clienti_Modifica`    | `sendWrite` / `updateCustomer`   |

`validateReadOnlyAction` and `validateWriteAction` are separate, and a read
action still cannot reach a write endpoint. 🟢 **The write surface is exactly two
named actions, and it is closed** — the service cannot be pointed at an arbitrary
Mexal verb from configuration alone.

🟢 **Authentication is unchanged and still correct**: Named Credential, with the
`Integration_Log__c` row still recording
`Authorization=<managed by Named Credential>`. The secret still never reaches the
log.

🟢 **`updateCustomer` substitutes the path parameter** — `PUT /clienti/{codice}`
with `codice` replaced from `Account.Codice_Cliente_Mexal__c`, and a blank code
throws before any callout.

## 2. 🟢🔴 `MexalCustomerCreateService` — 363 lines, and it writes both ways

`createForAccount(Id accountId)` is `@AuraEnabled`, reachable from a new
**`Crea_Cliente_Mexal` quick action** on Account and its
`mexalCustomerCreateAction` LWC, which are on the Account layout and the
three-column flexipage.

It: loads sixteen Account fields → builds the create payload → calls Mexal →
**writes `Account.Codice_Cliente_Mexal__c` back with `update`**.

🟢 **The customer code is assigned by Mexal, not by Salesforce.** The payload
sends `codice = '501.AUTO'` and the service then hunts the generated code in the
response headers (any header whose name contains `codice`, `cliente` or
`customer`, else the last path segment of `Location`) and falls back to the body.
That is the right shape for a numbering scheme the ERP owns.

🟢 **The duplicate `partita IVA` failure is handled at last.** `07/09` recorded
that POST on an existing account fails on a duplicate VAT, and
[OI-125](../items/OI-125%20Mexal%20customer%20update%20needs%20a%20PUT%20method.md)
has carried it since. `findDuplicatePartitaIvaCustomerCode` now parses
_"partita iva esiste gia"_ out of the error detail and returns **the existing
Mexal code** in `duplicateCustomerCode`, with a user-facing Italian message. The
failure stops being opaque.

🔴 **The `Modifica` path exists in the transport and has no caller.** On an
Account that already carries a Mexal code, `createForAccount` **throws**
_"Account gia collegato a Mexal"_ — and the update call that would handle it sits
directly above, **written out as a block comment** headed
_"Future Modifica Cliente path"_. So the PUT is built, reachable and never
invoked. **[OI-125](../items/OI-125%20Mexal%20customer%20update%20needs%20a%20PUT%20method.md)
stays open**, for the second day in a row for the same reason in a different
place.

🔴 **This is a manual button, not the agreed flow.** The decision taken the same
day — [Anticipay before Mexal customer creation](../decisions/Decision%20-%20first%20order%20runs%20Anticipay%20before%20Mexal%20customer%20creation.md) —
requires the chain to run **queued, off the first Order of an Account**, with
Anticipay first. What shipped is a **synchronous click on the Account**, with no
queueing, no Order trigger and no Anticipay step. The decision note says itself
that it does not activate the button; the gap is recorded, not a contradiction.
**Nobody has built the sequencing rule yet.**

## 3. 🟢🔴 OI-116 gets its DML, and keeps its blocker

`MexalCustomerSearchService` grew from 236 to **513 lines** and now **persists**:

```
applySaveResults(Database.update(accountsToUpdate, false), true, result);
applySaveResults(Database.insert(accountsToInsert, false), false, result);
```

🟢 Partial-success DML (`allOrNone = false`), per-row errors collected into
`saveErrors`, inserts stamped with the **`Azienda` record type** — consistent with
[the Azienda/Locale decision](../decisions/Decision%20-%20Account%20record%20types%20split%20Azienda%20and%20Locale.md) —
and a match-resolution step that **skips ambiguous matches** rather than guessing
which Account a Mexal customer is. An Account with no `Name` is refused, not
inserted blank.

🔴 **The nightly job is still commented out, with the identical blocker.** The
code still reads _"Automatic daily search is intentionally paused while the Mexal
sync schedule and date window are finalized"_, and
`MexalCustomerSearchScheduler` is still only a comment with its cron.

So **[OI-116](../items/OI-116%20Nightly%20Mexal%20to%20Salesforce%20anagrafica%20sync.md)
moves from "a read, not a sync" to "a sync with no schedule."** The missing half
is no longer code — it is the **sync window and watermark**, unspecified since
3 September and now the only thing between this and a running nightly job.

## 4. 🔴 `Integration_Configuration__c` became `Integration_Configuration2__c`

The object was **renamed and its type changed**: a **Hierarchy** custom setting
became a **List** custom setting. The whole `SetupOwnerId` resolution — per-user,
then per-profile, then per-org — was **deleted** and replaced by
`ORDER BY Name LIMIT 1`. All seventeen fields moved across; the old directory is
gone from the repository and no reference to the old API name remains in
`force-app/`.

🔴 **The `2` suffix is permanent.** Salesforce cannot convert a custom setting
between Hierarchy and List in place, which is very likely why a second object
exists at all — but the API name `Integration_Configuration2__c` is now what every
class, permission set and layout refers to, and cleaning it up later means a
second migration. **It should be renamed now or accepted deliberately, not by
default.**

⚠ **Whether the old object still holds rows or a deployment in the org is
unknown** — a repository reading cannot see it. Nobody has recorded a destructive
change or a data move.

🔴 **The table still has no rows and no owner, and now needs four.** Yesterday two
action names were required by exact spelling; it is now
`Mexal_Clienti_Ricerca`, `Mexal_Articoli_Ricerca`, `Mexal_Clienti_Creazione` and
`Mexal_Clienti_Modifica`
([the scaffolding note](The%20integration%20scaffolding%20has%20never%20been%20configured.md)).
Without them every call throws _"Configurazione Mexal non trovata per azione"_.
**Third OI-121-shaped table: hand-maintained, empty, unowned.**

## 5. 🔴 The deploy-breaking credential reference is now on `DevMain`

`Full_Permission` still grants `Mexal_External_Credential-Mexal_Principal`, and
`force-app/main/default/` still has **no `namedCredentials/` or
`externalCredentials/` directory at all**.

Yesterday this sat on an unmerged branch. **It is now in the working branch**, so
the org-only credential pattern has stopped being a risk about a proposal and
become a defect in the mainline
([the risk](../risks/Risk%20-%20integration%20credentials%20exist%20only%20in%20the%20org.md)).
**A clean deploy of `DevMain` to a fresh org fails on this permission set.** With
UAT twelve days away, this is the cheapest thing on this page to fix.

## 6. The rest of the commit

- 🟢 **`Integration_Log__c` gets a page layout** — the integration log becomes
  readable in the UI for the first time, which matters now that a write path
  logs to it.
- 🟢 **`Account.Email__c`** is added and mapped into the Mexal payload.
- ⚠ `Full_Permission` was substantially rewritten (95 lines changed) around the
  renamed object.
- 🔴 **The Apex estimate grows again.** `MexalCustomerCreateService` is 363 new
  lines and `MexalCustomerSearchService` gained 277; the repository now holds
  **30 Apex classes, 8,193 lines**. Last Apex test run still **4 August**, and the
  brief now includes a class that **creates records in an external ERP**
  ([OI-64](../items/OI-64%20The%20bundle%20Apex%20test%20suite%20is%20broken.md),
  [the deploy risk](../risks/Risk%20-%20production%20deploy%20is%20blocked%20by%20Apex%20coverage.md)).
  **Brief only — nothing acted on, no test written or proposed.**
