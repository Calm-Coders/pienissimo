---
id: OI-117
type: open-item
status: open
owner: Aurel Mrruku
with: Elisa Migliano
org: both
raised: 2026-09-03
updated: 2026-09-16
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

## 2026-09-14 — the org answered this row by building the opposite, and nobody minuted it

The org-status-check against Pienissimo UAT found `AccountTriggerHandler`
rewritten in the org that morning (**10:33 UTC**, org-only — it differs from the
committed source) with a new `afterUpdate`:

```apex
if (!String.isBlank(accountRecord.Codice_Cliente_Mexal__c) &&
    hasMexalUpdateTriggerFieldChanged(accountRecord, oldAccount)) {
  accountIdsToSync.add(accountRecord.Id);
}
// ... System.enqueueJob(new MexalCustomerUpdateQueueable(accountIdsToSync));
```

The watched fields are `Email__c`, `Phone`, `Partita_IVA__c` and `Name`.

⚠ **This row asked for a lock. What was built is a sync.** Once the Mexal code
is set, an administrative edit on Salesforce is not refused — it is **pushed to
Mexal**. The trigger condition is exactly the one this row specified;
the response is the opposite of the one agreed.

**It is a defensible design.** Keeping both systems in step is arguably better
than freezing one, and it avoids needing an amministrazione principal that
[does not exist in the org](#what-is-not-specified). But:

- 🔴 **It was agreed as _Concordato_ on 3 September and changed in code on
  14 September with no minute, no decision note and no client conversation.**
  Elisa Migliano agreed to a read-only field set. That is not what the system
  now does.
- 🔴 **The silent-overwrite exposure is not closed, it is doubled.** The nightly
  inbound batch
  ([OI-116](OI-116%20Nightly%20Mexal%20to%20Salesforce%20anagrafica%20sync.md))
  writes these fields **in**; this queueable writes them **out**. Two writers,
  opposite directions, no conflict rule. A user edit and a Mexal edit in the same
  night have no defined winner.
- 🔴 **Commercial fields were the whole point of the boundary.** The session sorted
  150 fields into four sections precisely so the lock would have an edge. The
  four watched fields are not that boundary — `tipologia attivita` and its class
  are untouched, which is correct, but nothing else was considered either.
- 🔴 **None of it is in source control**
  ([the risk](../risks/Risk%20-%20the%20Mexal%20order%20integration%20exists%20only%20in%20the%20org.md)).
  A deploy from `DevMain` reverts `AccountTriggerHandler` to a version with no
  `afterUpdate` at all, silently removing the sync.

**The row stays open and its question has changed.** It is no longer "when will
the lock be built". It is: **is the lock still the agreed design, or has it been
replaced by a two-way sync?** That is a client-facing question — Elisa Migliano
agreed to the lock — and it needs a decision note either way.

**Still unowned**, unchanged since 3 September.

## 2026-09-14 evening — the lock exists after all, and so does a conflict rule

The section above was written from the morning org inspection and read the
outbound push as _instead of_ the lock. **Seven hours later the answer turned out
to be both.** `e06a1b4` (Anita Aga, pushed 18:05 CEST, **PR #43, open and
unmerged**) adds an **active Account validation rule**,
`Lock_Mexal_Synced_Admin_Fields`:

```
AND($Profile.Name <> "System Administrator",
    NOT(ISBLANK(Codice_Cliente_Mexal__c)),
    OR(ISCHANGED(Name), ISCHANGED(Partita_IVA__c), ...))
```

🟢 **The lock agreed on 3 September is built.** Thirteen administrative fields —
`Name`, `Partita_IVA__c`, `Codice_Fiscale__c`, `Phone`, `Fax`, `Email__c`,
`PEC__c`, `Codice_Destinatario_SDI__c` and the five `Billing*` fields — are
refused to non-admin users once `Codice_Cliente_Mexal__c` is populated, with an
Italian error message pointing the user at amministrazione. The trigger condition
is exactly the one this row specified.

🟢 **Commercial fields are outside it**, as the 3 September session required.
`tipologia attivita` and its class are untouched.

🟢 **The two-writer exposure now has a conflict rule.**
`AccountTriggerHandler.setBypassMexalCustomerUpdate` is a static suppression flag,
and `MexalCustomerSearchService` sets it around the inbound sync's DML. The
nightly read therefore **cannot** re-trigger the outbound push. The infinite-echo
half of the divergence this row and
[OI-116](OI-116%20Nightly%20Mexal%20to%20Salesforce%20anagrafica%20sync.md) have
warned about since 3 September is closed in code.

### What is still not right

- 🔴 **The principal is a profile name, not amministrazione.** The row asked for
  "editable only by amministrazione"; what shipped is _editable only by System
  Administrator_. `$Profile.Name <> "System Administrator"` is a literal string
  comparison — it breaks if the profile is renamed or cloned, and it grants
  nothing to an amministrazione permission set. **The missing principal this note
  has flagged since 3 September is narrowed, not resolved.**
- 🔴 **The lock covers thirteen fields; the outbound push covers four.** An admin
  may still edit `Codice_Fiscale__c`, `PEC__c`, `Codice_Destinatario_SDI__c` and
  the whole billing address, and **none of those changes reaches Mexal** — only
  `Email__c`, `Phone`, `Partita_IVA__c` and `Name` enqueue
  `MexalCustomerUpdateQueueable`. So for nine of the thirteen locked fields the
  two systems can still silently diverge, now by the admin path rather than the
  user path.
- 🔴 **Still no minute and no client conversation.** The lock is built and so is
  the push; Elisa Migliano agreed only to the first. The two-way behaviour is
  recorded in a decision note committed on `DevAnita` (below), **not agreed with
  the client**.
- 🔴 **It is on an open PR.** Nothing above is on `DevMain`. PR #43 was opened
  2026-09-14 16:06Z and is unmerged as at this sweep.

### The decision that narrowed the trigger list

`e06a1b4` also edits
[the Anticipay-before-Mexal decision note](../decisions/Decision%20-%20first%20order%20runs%20Anticipay%20before%20Mexal%20customer%20creation.md)
to record that **Aurel Mrruku decided on 2026-09-14** that edits to exactly
`Email__c`, `Phone`, `Partita_IVA__c` and `Name` on an Account already carrying a
Mexal code must trigger the `Modifica Cliente` PUT. ⚠ **That decision arrived
inside a code commit, not through any swept source**, and its attribution is
recorded as given by the commit, not independently corroborated. The text lives on
`DevAnita` and reaches `DevMain` only when PR #43 merges.

**The row stays open.** The build question is now answered; what remains is the
principal, the nine unpushed fields, and whether the client is told that the
agreed lock is also a push.

## 2026-09-15 — the principal is fixed, on an open PR

`400c195` (Anita Aga, PR #45, **open**) replaces the validation rule's principal:

```diff
-  $Profile.Name <> "System Administrator",
+  NOT($Permission.Edit_Mexal_Synced_Admin_Fields),
```

against a new custom permission `Edit_Mexal_Synced_Admin_Fields`, described as
_"Allows editing administrative Account fields after the Account is linked to
Mexal."_

🟢 **This answers the red flag of 14 September.** The 3 September session agreed
the fields stay editable **by amministrazione**; a literal profile name could not
express a business grouping, a custom permission can. Assign it to Elisa
Migliano's people and the rule says what the meeting said.

🔴 **Three things still stand:**

1. **Nobody has assigned it.** A custom permission with no assignment locks the
   thirteen fields for everyone including amministrazione — the opposite failure.
   The permission is in `force-app/`; no permission set in this commit grants it.
2. **The lock and the outbound push still cover different field sets** —
   thirteen locked, **four** pushed (`Email__c`, `Phone`, `Partita_IVA__c`,
   `Name`). A holder of the new permission editing `Codice_Fiscale__c`,
   `PEC__c`, `Codice_Destinatario_SDI__c` or the billing address changes
   Salesforce and not Mexal. **Nine fields can still diverge silently**, now by
   the amministrazione path specifically — which is the path the meeting
   intended to keep open.
3. **It is unmerged.** `DevMain` at `f51365b` still carries the profile-name
   formula.

## ✅ 2026-09-16 - PR #45 merged, and point 1 above was wrong when written

**`0d2b779`, merged 08:21:19Z (10:21 CEST).** The custom permission principal is
on `DevMain`. Point 3 is closed.

✅ **Point 1 is a correction, not a change.** `400c195` **did** grant the
permission — in the same commit that created it:

```xml
<customPermissions>
    <enabled>true</enabled>
    <name>Edit_Mexal_Synced_Admin_Fields</name>
</customPermissions>
```

in `Full_Permission.permissionset-meta.xml`, lines 43–46. The 15 September
reading — _"no permission set in this commit grants it"_ — was drawn from the
commit's **diff of that file**, which shows only the `MexalArticleSync*` class
removals and the `OrderItem.Mexal_Payment_Status__c` field grant; the
`customPermissions` block sits outside the diff hunks. `git log -S` on the
permission-set directory returns `400c195` itself. **The claim should have been
checked against the file, not the hunk.**

### 🔴 What is genuinely wrong is narrower, and it is a real problem

`Full_Permission` is the **only** permission set in `force-app/` that grants it —
verified across all nine. And `Full_Permission` is the all-access developer set:
the 7 September org check found it reaching **two** of nine active users.

So the grant exists, but it is attached to the wrong principal. To satisfy what
the **3 September session** promised — that amministrazione keeps editing these
fields — somebody must either:

- grant `Edit_Mexal_Synced_Admin_Fields` from an **amministrazione** permission
  set, which does not exist in this repository; or
- assign amministrazione users `Full_Permission`, which grants them everything
  else in the org as well.

⚠ **Neither has happened, and the second would be a security regression dressed
as a fix.** This is now a permission-design question, not a missing line.

🔴 **Point 2 is unchanged.** Thirteen fields locked, four pushed, nine able to
diverge silently by the amministrazione path.
