---
id: proposal-event-invitations
type: reference
status: open
org: ROMI
raised: 2026-09-07
updated: 2026-09-07
depends_on: [OI-78, OI-81, OI-121]
source: User conversation with Codex on 2026-09-07
uncertain: Invitation foundation implemented in local source only; Growth provisioning and flow configuration were not inspected; email timing remains open.
---

# Proposed event invitations for participant registration

**Create one invitation per Account and event-edition Campaign with the tickets.
Resolve the published community URL at runtime, store the plain link on the
invitation, and use Marketing Cloud Growth to send it when collection is due.**

The user requested this note and selected plain links and runtime URL discovery
on 7 September 2026. The confirmed stack is **Sales Cloud, Digital Engagement
for Facebook and WhatsApp, and Marketing Cloud Growth**; see
[the product record](../The%20confirmed%20Salesforce%20and%20marketing%20products.md).

This replaces the earlier Marketing Cloud Engagement assumption. Journey
Builder, its entry API, data extensions and Marketing Cloud Connect are not the
proposed sending path. Tokens and expiry are outside the current scope by user
direction. The invitation and URL foundation is implemented in local source;
the Growth sending workflow and open business rules remain to be configured.

## Existing behaviour

Source inspected on 7 September 2026:

- [OrderTriggerHandler](../../force-app/main/default/classes/OrderTriggerHandler.cls)
  maps each ticket-generating bundle component to an event edition using its
  product and order effective date, then sets Asset.Campaign__c.
- [The existing participant LWC](../../force-app/main/default/lwc/participantRegistrationPage/participantRegistrationPage.js)
  reads c__accountId and c__campaignId.
- [ParticipantRegistrationController](../../force-app/main/default/classes/ParticipantRegistrationController.cls)
  filters by AccountId and Campaign__c, limited to Disponibile and Assegnato.
  Saving repeats the filter; contact lookup is Account-scoped. It also creates
  missing Campaign Members, contrary to the older absence claim in
  [OI-78](../items/OI-78%20Participant%20data%20collection.md).
- At the start of this session no invitation object or dispatch mechanism was
  present. The source implementation below adds storage and URL preparation.
  Marketing Cloud configuration was not inspected.

The plain-link choice preserves this page behaviour and does not resolve
[the existing community access finding](../risks/Risk%20-%20the%20community%20pages%20have%20no%20application-level%20authentication.md).

## What to create and where to store it

The new Salesforce custom object is `Event_Invitation__c`. Its implemented
fields are listed below; dispatch tracking remains proposed future work.

| Field                                                 | Purpose                                                                                                                          |
| ----------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------- |
| Account__c                                            | Company owning the tickets.                                                                                                      |
| Campaign__c                                           | Exact event-edition Campaign on the Assets.                                                                                      |
| Recipient_Contact__c                                  | Commercial referent; direct Contact relationship for the Growth flow.                                                            |
| Account_Campaign_Key__c                               | Unique external ID composed from the two IDs, for repeatable bulk upserts.                                                       |
| Send_After__c                                         | Earliest request time, derived from the event and configurable offset.                                                           |
| Status__c                                             | Collection states: Pending, Ready, Completed, Cancelled.                                                                         |
| Registration_Url__c                                   | Ordinary URL field populated by Apex from runtime discovery; no formula or hardcoded host.                                       |
| URL_Status__c, URL_Refreshed_At__c, Last_URL_Error__c | Implemented URL preparation status, last attempt time and sanitised failure reason.                                              |
| Dispatch tracking                                     | Communication key/cycle, processing state, attempt time, send outcome and sanitised error. Keep separate from collection status. |

Group tickets dynamically by Account and Campaign. Further purchases for the
same event reuse the invitation. A bundle with two tickets for Campaign A and
three for Campaign B creates two invitations. Do not put one current invitation
URL on Contact: the same referent can have several concurrent events.

## Resolve the URL across orgs

Implement a reusable Apex resolver for invitation preparation and dispatch:

1. Find the intended **Landing Page** community by a consistent identity across
   deployments. The verified selector today is its exact name. Require one live
   match; this org has two communities, so never select the first arbitrarily.
2. Read its published **siteUrl** with
   `ConnectApi.Communities.getCommunity(networkId).siteUrl` in Apex. This exact
   call was successfully executed read-only in UAT and returns the same
   domain-root address as Connect REST. No separate REST credential or domain
   configuration is required by the resolver.
3. Preserve any path returned in siteUrl, normalize its trailing slash and append
   the existing route and query parameters. Encode query values.
4. Store the result in Registration_Url__c. Resolve once per execution/batch,
   not per Asset; refresh before each dispatch so domain changes or sandbox
   refreshes do not leave stale URLs.
5. If discovery fails or is ambiguous, leave the invitation unsent and record
   the error. Do not guess the community domain or reuse an old sandbox URL.

```text
<published-siteUrl>/participant-registration?c__accountId=<ACCOUNT_ID>&c__campaignId=<CAMPAIGN_ID>
```

The metadata carries the stable page route and community selector; each org
supplies its own host and site base path. No URL metadata edits are needed.
The destination community must already be deployed and published. If its name
changes, configure its selector rather than a domain value.

**Verified UAT example, not a configuration value:**

```text
https://ability-customization-52152--partial.sandbox.my.site.com/participant-registration?c__accountId=<ACCOUNT_ID>&c__campaignId=<CAMPAIGN_ID>
```

On 7 September, authenticated Connect REST identified Landing Page as Live at
the domain root. An unauthenticated GET of /participant-registration returned
HTTP 200 and the LWR page shell. SiteDetail.SecureUrl exposed /vforcesite;
the participant path under it returned 404 and its /s variant returned HTTP 401
with a login redirect. /lp belongs to the separate Landing page marketing site.
Use the published community siteUrl, not the underlying SiteDetail path.

No browser-rendered submission was verified.
[Salesforce site API documentation](https://developer.salesforce.com/docs/platform/connect-rest-api/guide/features_communities.html).

## When to create and send

1. **With successful ticket generation:** bulk-upsert distinct Account-Campaign
   invitations after campaign assignment, in the Asset transaction. The current
   order entry point is transition to Incassato. Do not make an external API
   call from that transaction.
2. **After commit:** resolve the URL and populate the field asynchronously.
   Keep the invitation Pending until preparation succeeds. Reconcile imports
   and campaign reassignments as well as new orders.
3. **Calculate the due date:** use the event edition and configurable collection
   offset. [OI-81](../items/OI-81%20Event%20communication%20funnel.md) leaves its
   number open; do not hardcode 30 or 60 days or substitute the separate
   no-show-reduction flow's timing.
4. **When due:** a scheduled Salesforce process selects invitations with a
   recipient and eligible tickets missing participant data, refreshes the URL,
   assigns a communication key and marks Ready. Time passing alone does not
   fire a record-change event; the scheduler must make the qualifying update.
5. **After submission:** recompute completion from eligible Assets. Reopen when
   new eligible tickets are added. Recalculate unsent dates when an event moves.
   Confirm the cutoff and late-purchase/new-request rules.

## Use the invitation from Marketing Cloud Growth

Recommended entry: an **automation event-triggered marketing flow**, using
**Prospect, Lead, Contact, or Related Record Change**. Select Event_Invitation__c
and its Recipient_Contact__c relationship, and enter when the invitation becomes
Ready for a communication cycle that has not been dispatched.

Salesforce documents this related-record trigger for Growth. Verify that the
object and relationship appear in the actual org and grant the required access.
An ordinary record-triggered Flow is not interchangeable with this marketing
flow type.
[Related-record automation event](https://help.salesforce.com/s/articleView?id=platform.automate_flow_ref_event_individual_related_record_event.htm&language=en_US&type=5).

Inside the marketing flow:

1. Keep the **triggering InvitationId** throughout execution. Fetch that exact
   invitation, its recipient and event; never select an arbitrary invitation
   by Contact alone.
2. Recheck eligibility and the communication key before sending. Capture that
   invitation's URL and event as this execution's values.
3. Use **Send Email Message** with a published Growth workspace template.
   Define content variables and map them under **Personalize Message**.
4. Track the exposed send result and faults. Starting a flow or queuing a
   message is not proof of delivery. Prevent repeated record updates from
   duplicating the same invitation's communication.

| Template variable | Flow value                                        |
| ----------------- | ------------------------------------------------- |
| RegistrationUrl   | Exact invitation's refreshed Registration_Url__c. |
| EventName         | Invitation's event-edition Campaign name.         |
| EventDate         | Relevant event date from that Campaign.           |
| RecipientName     | Selected commercial referent.                     |

A template record variable can also be used if available in its data-source
selector; map its record ID. Scalar variables keep URL and event selection
explicit. Preserve the agreed plain-text email style with a normal link.
[Email personalization from Flow](https://help.salesforce.com/s/articleView?id=platform.automate_flow_build_personalize_marketing_emails_flow_resources.htm&language=en_US&type=5),
[Send Email Message element](https://help.salesforce.com/s/articleView?id=platform.flow_ref_elements_mktg_send_email_message.htm&language=en_US&type=5).

This record-driven path does not require an Engagement data extension or
Marketing Cloud Connect synchronization. Verify Growth provisioning, sender
setup, recipient identity and applicable communication consent before activation;
a Contact record alone does not prove the recipient is sendable.

If the provisioned org lacks the related-record entry, evaluate a Growth
**On-Demand Flow** with explicit InvitationId and personalization inputs.
Salesforce documents its REST trigger as
`/services/data/v65.0/actions/custom/flow/FLOW_NAME_HERE`; use the implementation's
supported version and configured permissions. This is a fallback, not the
Journey Builder API.
[On-demand flows](https://help.salesforce.com/s/articleView?id=platform.flow_concepts_trigger_on_demand.htm&language=en_US&type=5),
[trigger endpoint](https://help.salesforce.com/s/articleView?id=release-notes.rn_automate_flow_marketing_cloud_on_demand_flow.htm&language=en_US&release=258&type=5).

## Multiple events, reminders and Digital Engagement

Two invitations for the same Contact need independent executions with different
event and URL values. Verify Growth concurrency/entry behaviour for this case;
do not copy Journey Builder re-entry settings. Deduplicate by InvitationId plus
communication cycle/channel, not Contact alone.

Before each reminder, fetch current invitation status and eligible Assets.
Suppress only that invitation's completed collection, leaving other events open.
Refresh its runtime URL before sending. Cancelling an invitation suppresses
communications but does not itself disable the existing raw-ID community page.

**Digital Engagement for Facebook and WhatsApp is confirmed separately.** The
same plain URL can be reused there, but this note designs the email path only.
Channel-specific workflows need the recipient's messaging identity, configured
channel and applicable template/consent rules. Do not infer Growth WhatsApp
campaign entitlements or automatic sends from Digital Engagement's presence.

The Asset effect of **rinuncia** remains open in
[OI-74](../items/OI-74%20Asset%20state%20machine.md); this proposal does not create
a seventh Asset status or equate withdrawal with cancellation.

## Implementation order and remaining decisions

Build invitation storage and bulk creation; runtime URL preparation; scheduled
eligibility updates; Growth flow and email mappings; completion/reminder tracking.

Confirm recipient selection, offset/cutoff, communication cycles/retries and
actual Growth trigger availability. Verify two-org URL generation without
editing a domain, a two-event bundle sent to one Contact, completion of only
one event, repeatable creation, late purchases and missing/ambiguous site discovery.
No Apex test classes were written and no deployment was performed.

## Implemented in source on 7 September 2026

The user explicitly requested the Salesforce source in addition to this note.

- [EventInvitationService](../../force-app/main/default/classes/EventInvitationService.cls)
  creates missing invitations after new ticket Assets are inserted by the order
  handler. It locks the affected Accounts before checking existing unique
  Account-Campaign keys, preserving existing invitations. Its trigger derives
  keys on manual creation too and invalidates URLs when either lookup changes.
- [ParticipantCommunityUrl](../../force-app/main/default/classes/ParticipantCommunityUrl.cls)
  selects the unique live Landing Page network and reads its published URL
  through Connect-in-Apex. It appends the existing route and plain ID parameters.
- [EventInvitationUrlJob](../../force-app/main/default/classes/EventInvitationUrlJob.cls)
  prepares URLs after commit. If the transaction has exhausted its queueable
  allowance, the invitation retains URL_Status__c = Pending; run the refresh
  action before sending to prepare it. This prevents a competing asynchronous
  automation from blocking the order solely because the queue is full.
- The same class exposes the Flow action **Aggiorna link inviti evento**.
  Supply invitation IDs, check each returned `success`, and use the returned
  `registrationUrl`. Follow the fault/error path without sending on failure.
  The action refreshes stored URLs and does not mark the collection Ready or
  send anything. It locks records after URL discovery to prevent stale lookup
  values from producing a mismatched link.
- Added a tab, layout, and validation rules for recipient Account membership and
  Ready-state prerequisites. Access is granted through the existing
  **Full Permission** set, not a new one - see
  [the decision](../decisions/Decision%20-%20invitation%20access%20uses%20Full%20Permission.md).
  `Account__c` and `Campaign__c` are required lookups and therefore carry no
  field entry. The set is internal; never grant it to guests.

**URL Ready is not collection Ready.** Initial collection status stays Pending;
recipient and send time are not guessed. No scheduler, Growth marketing flow,
message content, send tracking, completion/reopen automation or historical Asset
backfill has been implemented in this source step. Use the exact invitation's
URL refresh action in the preparation flow before marking it Ready, and refresh
again before dispatch. Existing Assets are not automatically backfilled; new
invitations are created on the order path when it inserts new ticket Assets.

Verification: Salesforce check-only deployment with NoTestRun succeeded for
the selected new components and order-handler change (job
`0AfMA00000CeBPF0A3`, re-validated as 22 of 22 components with zero errors in
job `0AfMA00000Ce9Qh0AJ` after the permission-set merge and the Order trigger
rename). The read-only Connect-in-Apex probe compiled and returned
the correct UAT siteUrl. This validates metadata/Apex compilation, not the full
runtime ticket-to-email workflow or measured Apex coverage. No org metadata was
persisted by the check-only validation.
