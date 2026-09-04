---
id: OI-117
type: open-item
status: open
owner: Aurel Mrruku
with: Elisa Migliano
org: both
raised: 2026-09-03
updated: 2026-09-03
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
