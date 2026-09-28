---
id: decision-invitation-full-permission
type: decision
status: resolved
owner: Aurel Mrruku
org: ROMI
raised: 2026-09-07
updated: 2026-09-07
depends_on: [proposal-event-invitations]
blocks: []
source: Aurel Mrruku, direct instruction to the agent session, 2026-09-07
---

# Decision - invitation access uses Full Permission

**Event invitation access is granted through the existing `Full_Permission`
set. No new permission set is created for it.** The
`Event_Invitation_Management` set drafted on 2026-09-07 is deleted from source.

Stated by Aurel Mrruku on 2026-09-07: if it is a new permission set, get rid of
it and assign the entitlements to the existing set named "full".

## What moved into Full Permission

| Entitlement                                                        | Kept as drafted |
| ------------------------------------------------------------------ | --------------- |
| `Event_Invitation__c` object: create, read, edit, view all records | yes             |
| Delete and Modify All                                              | withheld        |
| 8 field permissions                                                | yes             |
| Apex `EventInvitationUrlJob`, `ParticipantCommunityUrl`            | yes             |
| `Event_Invitation__c` tab, Visible                                 | yes             |

The entitlements were relocated, not widened. The posture is the one drafted
with the object: the calculated fields - `Registration_Url__c`,
`URL_Status__c`, `URL_Refreshed_At__c`, `Last_URL_Error__c` and
`Account_Campaign_Key__c` - stay read-only, matching the rule the set already
applies to other calculated fields.

## Two things that look like omissions and are not

- **`Account__c` and `Campaign__c` have no field entry.** Both are
  `required: true` on the object. Salesforce rejects `fieldPermissions` for a
  required field, so the object permission alone governs them.
- **`EventInvitationService` has no Apex class entry.** It runs only from
  triggers, which do not check class access. `EventInvitationUrlJob` needs one
  because it exposes the `@InvocableMethod` a Flow calls, and
  `ParticipantCommunityUrl` is granted alongside it.

## Org state

Neither `Event_Invitation_Management` nor `Event_Invitation__c` was ever
deployed - both confirmed absent from Pienissimo UAT on 2026-09-07. Nothing had
to be deleted or unassigned in the org, and no user lost access. This is a
source-only change.

`Full_Permission` description had to be shortened to fit the Salesforce 255
character limit, which the merged text first exceeded. Check-only validation
job `0AfMA00000Ce9Qh0AJ` then passed with 22 of 22 components and zero errors.

Nobody is assigned the set as part of this change. Assignment remains an open
step in
[the invitation proposal](../flows/Proposed%20event%20invitations%20for%20participant%20registration.md).
The set is internal; it must never be granted to a guest user.
