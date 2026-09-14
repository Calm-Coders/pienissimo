---
id: OI-117
type: open-item
status: open
owner: Aurel Mrruku
with: Elisa Migliano
org: both
raised: 2026-09-03
updated: 2026-09-11
depends_on: [OI-116]
requirement: INT-01
source: notes/meetings/2026-09-03 Data Model Parte 1.md
---

# OI-117 - Administrative fields lock once the Mexal customer code is set

**Once an account exists on Mexal, its administrative and accounting fields
become read-only on Salesforce — editable only by amministrazione.**

Agreed at
[Data Model Parte 1](../meetings/2026-09-03%20Data%20Model%20Parte%201.md), and
recorded there as _Concordato_, not as a proposal.

The mechanics as stated in the room:

- **The trigger is the `Codice Cliente Mexal` field being populated.** That field
  was renamed in the same session, from `codice cliente esterno`, precisely
  because it now carries this meaning.
- **The mechanism is a validation rule** on Salesforce inhibiting direct edits
  unless specific conditions hold.
- **Commercial fields are explicitly outside the lock** — `tipologia attività`
  and its class stay editable by the tutors after creation. This is why the
  session spent an hour sorting 150 fields into **Dati Commerciali / Dati Tecnici
  / MEXAL / MEXAL - DATI PER PROVVIGIONI**: the sections _are_ the lock's
  boundary.

## What is not specified

- 🔴 **"Editable only by amministrazione" has no principal.** No profile,
  permission set or role was named. The org's permission sets currently reach
  **one user each** against 8 active users, so there is no amministrazione
  grouping to point a validation rule at today.
- 🔴 **"Specific conditions" was left as those words.** A validation rule needs
  the exception list written down, and the session did not write it.
- ⚠ **It is half of one design with
  [OI-116](OI-116%20Nightly%20Mexal%20to%20Salesforce%20anagrafica%20sync.md).**
  The lock is what makes Mexal's ownership safe; the nightly batch is what makes
  it useful. Building either alone leaves the registry able to diverge — a user
  edit that the batch then overwrites without trace.
- ⚠ **Nothing says what happens to a record whose Mexal code is later cleared**,
  nor whether the lock applies to the migrated records or only to ones created
  after go-live.

Unbuilt. Assigned to Aurel Mrruku by implication rather than by name — the
session's action list gives him the surrounding registry work but does not
itemise the validation rule. **Confirm the owner before scheduling it.**

## 2026-09-11 — the trigger condition now has a writer, and the lock still does not

This row locks the administrative fields **once `Codice_Cliente_Mexal__c` is
populated**. Until today nothing in the repository populated it.

🔴 **Two things now do.** `80420cf` (PR #41, merged 18:05 CEST) both
**writes the code back after a Mexal create** — `update new Account(Id = ...,
Codice_Cliente_Mexal__c = result.generatedCustomerCode)` — and **inserts and
updates Accounts from the nightly anagrafica read**
([OI-116](OI-116%20Nightly%20Mexal%20to%20Salesforce%20anagrafica%20sync.md)).

🔴 **No validation rule, no lock, no field-level enforcement was added.** The
condition that this row's whole design keys off is now reachable in the running
system, and the protection is still nowhere.

⚠ **This is the divergence the row predicted, arrived.** The two are one design:
Mexal's ownership of the anagrafica is only safe because the lock stops a
Salesforce user editing underneath it. The ownership half shipped; the safety
half did not. A user edit made after the Mexal code lands can now be overwritten
by the sync without trace — and the sync is one configuration decision away from
running nightly.

**Still unowned.** The owner was inferred, never named, and this note has asked
for that to be confirmed since 3 September. **Confirm it and schedule the rule
before the nightly job is switched on, not after.**
