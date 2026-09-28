---
id: aurel-requested-participant-invitation-batch
type: reference
status: active
org: ROMI
raised: 2026-09-15
updated: 2026-09-15
depends_on: [OI-78, OI-81, OI-126]
source: User instruction to Codex on 2026-09-15
---

# Aurel requested the participant invitation batch

The user stated on 15 September 2026 that the participant invitation and
participant registration items created in this local source batch were requested
by Aurel Mrruku.

This is the single markdown recap for the work done in this conversation. It
records implementation state and UAT deploys; it does not by itself prove client
acceptance or production readiness.

## What was created

- A single Contact-level principal marker,
  `Contact.Contatto_Principale__c`, with `ContactTrigger` and
  `ContactTriggerHandler` keeping only one principal contact per Account and
  syncing the principal email onto `Account.Email_Contatto_Principale__c`.
  Its default is now `true`.
- The Contact after-update path now narrows Account email sync to changes that
  can alter the principal email result: `Email`, `AccountId`, or
  `Contatto_Principale__c`. Ordinary edits to a principal Contact no longer
  re-evaluate or update the Account email field. Updates with a null new Contact
  email are also skipped, so they do not clear the Account email.
- Campaign-level event dates, `Campaign.Data_Evento__c` and
  `Campaign.Data_Invio_Biglietto__c`, with the same date values copied onto
  `Event_Invitation__c`.
- Token-based participant invitation links using
  `Event_Invitation__c.Token__c` instead of exposing raw Account and Campaign
  IDs in the public page URL.
- Invitation defaults that derive send timing and recipient contact from the
  Campaign and the Account's unique principal Contact when available.
- The participant registration page updated to load, search Contacts and save
  participants by invitation token.
- A single page-level `Rinuncia` button on the participant registration page,
  shown only when the invitation has exactly one ticket in total and that ticket
  is still `Ordinato`; the Apex method enforces the same condition before
  setting the ticket to `Rinuncia`. Completed/hidden tickets block the action
  because they still count as existing tickets.
- Layout and permission updates for Account, Campaign, Contact,
  `Event_Invitation__c`, Order, `Campaign_Management` and `Full_Permission`.

## Token Links

The public registration page now uses the invitation token:

```text
<published-siteUrl>/participant-registration?c__token=<INVITATION_TOKEN>
```

`ParticipantCommunityUrl.registrationUrl(String token)` builds that link, and
`EventInvitationUrlJob` reads `Event_Invitation__c.Token__c` when refreshing
`Registration_Url__c`.

The old Account/Campaign query parameters are superseded:

```text
c__accountId=<ACCOUNT_ID>&c__campaignId=<CAMPAIGN_ID>
```

A token link is valid only when the token is the 64-character value stored in
`Event_Invitation__c.Token__c`. The old `AccountId:CampaignId` key is not a
valid token and returns "Questo collegamento non e valido."

Existing stale UAT invitation URLs were refreshed with
`scripts/apex/refresh-event-invitation-token-urls.apex`.

## One Link, One Event

An `Event_Invitation__c` represents exactly one Account and one Campaign. A
link for `Test Account Rexjina` and `Pienissimo Live October` showed one Asset
because the second Asset on the same Account belonged to `Pienissimo Live
September`. That second Asset has a different invitation token.

This is intended:

```text
1 Event Invitation = 1 Account + 1 Campaign
```

## Ticket Visibility

The participant page now loads visible Assets in these statuses:

```text
Ordinato, Disponibile, Assegnato, Rinuncia
```

Tickets are editable for participant entry when they have no Contact and are in
one of these statuses:

```text
Ordinato, Disponibile, Assegnato
```

This fixes the case where a Contact was deleted after a ticket had already been
assigned. The Asset could remain `Assegnato` with an empty Contact lookup; the
page must show the form again instead of empty read-only participant details.

## Rinuncia

`Rinuncia` is a real Asset ticket status. It was added to:

- `force-app/main/default/standardValueSets/AssetStatus.standardValueSet-meta.xml`
- `force-app/main/default/objects/Asset/recordTypes/Ticket.recordType-meta.xml`

The participant registration LWC now shows one page-level **Rinuncia** button
only when there is exactly one ticket in total on the invitation and that ticket
is still `Ordinato`. Completed or otherwise hidden tickets block the action
because they still count as tickets. The button calls
`ParticipantRegistrationController.markTicketRinuncia(token, assetId)`, which
verifies the invitation token, confirms the same single-ticket-in-total and
`Ordinato` condition server-side, and then sets:

```apex
Asset.Status = 'Rinuncia';
```

Tickets in `Rinuncia` remain visible with a `Rinuncia` badge and no longer
require participant data.

## Duplicate Invitations

Automatic invitation creation must not create another invitation when one
already exists for the same Account and Campaign. `EventInvitationService`
already does this in `ensureForAssets`: it checks existing
`Account_Campaign_Key__c` values and inserts only missing Account-Campaign
pairs.

No custom Apex duplicate error is thrown for the automatic path.

Salesforce may still block direct manual duplicate inserts because
`Account_Campaign_Key__c` is unique. Apex triggers cannot silently cancel a
manual insert; they can only save it or fail it.

## Full Permission

`Full_Permission` was updated with field-level access for the new fields,
including:

- `Account.Email_Contatto_Principale__c`
- `Campaign.Data_Evento__c`
- `Campaign.Data_Invio_Biglietto__c`
- `Contact.Contatto_Principale__c`
- `Event_Invitation__c.Data_Evento__c`
- `Event_Invitation__c.Data_Invio_Biglietto__c`
- `Event_Invitation__c.Email_Contatto_Principale__c`
- `Event_Invitation__c.Token__c`

Formula/generated fields are readable, not editable.

`Contatto_Principale__c` was not visible to the user because the Contact layout
did not contain the field, and the org did not show `Full_Permission` carrying
that Contact field permission before the final deploy. `Contact-Contact Layout`
now includes `Contatto_Principale__c`, and UAT confirms
`Full_Permission` has read/edit access for `Contact.Contatto_Principale__c`.
