---
id: OI-286
type: open-item
status: open
owner: Rexhina Hysi
with: Aurel Mrruku
org: ROMI
raised: 2026-10-23
updated: 2026-10-26
depends_on: [OI-163]
source: Salesforce error mail, 2026-10-23T14:43:05Z, Gmail 1a169372a34e3a64
---

# OI-286 - Lead conversion throws in UAT when the user cannot create a Task

**A Lead update in the Pienissimo partial sandbox threw an unhandled exception
on 23 October at 14:43:05Z. The trigger tries to insert a follow-up Task and
the running user has no access to Task fields, so the whole `AfterUpdate` dies
and the Lead edit is rolled back. A fix for exactly this exists on an unmerged
branch, pushed an hour and twenty minutes after the failure.**

## The error

Salesforce → `a.mrruku@romicompany.com`, **2026-10-23T14:43:05Z** (Gmail
`1a169372a34e3a64`), org `00DMA000004nMMr`
(`ability-customization-52152--partial.sandbox.my.salesforce.com`), user
`005MA00000Gh60y`:

```
LeadConversionTrigger: execution of AfterUpdate
caused by: System.DmlException: Operation failed due to fields being
inaccessible on Sobject Task, check errors on Exception or Result!
Class.LeadConversionTriggerHandler.afterUpdate: line 33, column 1
Trigger.LeadConversionTrigger: line 11, column 1
```

## The line, in this repository

`force-app/main/default/classes/LeadConversionTriggerHandler.cls:33` is the
insert itself:

```apex
List<Task> followUpTasks = buildNonRispondeFollowUpTasks(
  newLeads,
  oldLeadMap
);
if (!followUpTasks.isEmpty()) {
  insert followUpTasks;        // ← line 33
}
```

🟢 **So the org and the repository agree here**, unlike the 27 August case
([the LeadConversionQueueable risk](../risks/Risk%20-%20LeadConversionQueueable%20is%20broken%20in%20the%20Pienissimo%20sandbox.md)).
The line number matches the deployed behaviour and no divergence is implied.

🔑 **The failing path is the `Non Risponde` follow-up task**, i.e. the
automation that creates an activity when a Lead is parked as unreachable — part
of the lead-lifecycle work currently being built on `Devmain_LeadChecks`.

## Why the Lead edit fails and not just the Task

`afterUpdate` inserts the Tasks **before** `enqueueLeadConversions`, with no
`Database.insert(..., false)` and no try/catch. An unhandled `DmlException` in
an after-trigger rolls the whole transaction back, so:

- 🔴 **the user's Lead edit is rejected**, not silently degraded;
- 🔴 the conversion queueable never runs;
- the user sees a raw platform error, and the only diagnostic goes to Aurel
  Mrruku's mailbox.

⚠ Unlike the August case this is **not** silent — but the audience is wrong: the
person who hit it is `005MA00000Gh60y`, and the mail went to the developer.

## 🟢 A fix for exactly this is on an unmerged branch

Rexhina Hysi, `42602a8` _"added task on ps"_, **2026-10-23 18:04:46 CEST** on
`Devmain_LeadChecks`, adds to `Agente.permissionset-meta.xml`:

| Added | |
| ----- | - |
| `Task.ActivityDate` | read + edit |
| `Task.Description` | read + edit |
| `Task.WhoId` | read + edit |
| `CreateTask` | user permission enabled |

🔑 **Those are the fields `buildNonRispondeFollowUpTasks` would set**, and the
commit lands **1 h 21 min after the error mail**. Two earlier commits the same
afternoon on the same branch — `f2d454e` _"work with agente"_ (15:05) and
`579e87a` _"profile update and permission set"_ (16:15) — are the same body of
work.

⚠ **This is a correlation, not a confirmed cause.** The error mail names a user
id, not a profile or permission set, and nothing in the record says
`005MA00000Gh60y` is an `Agente`. The reading is consistent with every fact in
hand and is **not verified against the org** — this sweep did not open it.

## 🔴 Why it is still open

- 🔴 **`DevMain` does not have the fix.** `origin/DevMain` is still `ebc2c5b`,
  last night's own nightly commit; all three `Agente` commits are unmerged and
  **no pull request exists**.
- ⚠ **Only the `Agente` permission set is touched.** If any other profile or
  permission set reaching this trigger lacks Task access — the tutor profiles,
  the community guest user, the PDF run-as user — it fails the same way. Nobody
  has checked.
- 🔴 **The code is still brittle regardless of permissions.** A permission grant
  fixes this instance; an unguarded `insert` in an after-trigger will fail the
  same way for the next cause (a validation rule, a required field, a Task
  trigger). The record contains no decision to make it tolerant.
- ⚠ **Whether this reproduces in Prod is unknown.** Prod has no invoice stack
  and a different permission state; the Lead flow there has not been inspected.

## What closing it looks like

The `Agente` work merges to `DevMain`; the other profiles that can update a Lead
are checked for Task create and field access; and someone decides whether a
failed follow-up Task should be allowed to reject a Lead edit at all. **An org
inspection confirms it, because an error mail proves an event and never a
standing state** — the lesson the August note was overturned by.

**Do not write an Apex test for this.** Coverage is a separate task Aurel Mrruku
requests in one pass before the production deploy —
[the deploy risk](../risks/Risk%20-%20production%20deploy%20is%20blocked%20by%20Apex%20coverage.md).

## 2026-10-26 - the permission fix reached DevMain, and a sibling defect reached production

🟢 **The fix is merged.** `Devmain_LeadChecks` came into `DevMain` through **PR
#109** (`a40da94`, 11:31 CET), so `Agente.permissionset-meta.xml` on
`origin/DevMain` `428f42b` now carries `CreateTask` and the Task fields.
🔑 **It is a permission set, not the `Agente` profile** — which matters, because
the production deploy of the same afternoon explicitly **excluded the Agente
profile** and did not exclude permission sets. ⚠ **Not verified in the org**;
this is repository and deploy-record arithmetic only.

⚠ **The three reservations in this row all stand**: the user-to-profile link is
still a correlation, only `Agente` was touched, and the unguarded `insert` in an
after-trigger is still unguarded.

🔴🔑 **And the third reservation just came true in production.**
[OI-288](OI-288%20Editing%20a%20Contact%20fails%20in%20production%20when%20the%20Account%20has%20no%20Agente.md):
`ContactTriggerHandler.cls:203` is a bare `update` on the Account, and at
16:28:17Z on 26/10 an active validation rule — not a permission — rolled a
user's Contact edit back in `Pienissimo Prod`. **Same defect shape, different
trigger, and permissions cannot fix it.** This row predicted _"an unguarded
`insert` in an after-trigger will fail the same way for the next cause (a
validation rule, a required field, a Task trigger)"_; the next cause was a
validation rule, four days later.
