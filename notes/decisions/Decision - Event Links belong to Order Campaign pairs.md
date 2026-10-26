---
id: DEC-2026-10-05-event-link-order-campaign
type: decision
status: active
owner: null
org: ROMI
raised: 2026-10-05
updated: 2026-10-05
depends_on: [OI-78, OI-127, OI-203]
source: User instruction to Codex on 2026-10-05
---

# Decision - Event Links belong to Order Campaign pairs

An Event Link (`Event_Invitation__c`) belongs to exactly one Order-Campaign
pair. If one Order has ticket Assets linked to three distinct Campaigns, the
system creates three Event Links with three distinct tokens and URLs.

The uniqueness key is `Order Id + Campaign Id`. Reprocessing the same Assets
must preserve the existing link for that pair rather than create a duplicate.
The Order is still locked during invitation generation so concurrent Asset
creation cannot race the existence check.

Each token exposes and permits changes only to Assets from its own Order and
Campaign. It must not show or accept an Asset from another Campaign on the same
Order. Participant submission, Campaign Member creation, and `Rinuncia` remain
scoped to the Campaign represented by that link.

Its collection lifecycle is defined separately in
[Decision - Event Link collection status follows campaign tickets](Decision%20-%20Event%20Link%20collection%20status%20follows%20campaign%20tickets.md).

This supersedes
[Decision - Event Links belong to Orders](Decision%20-%20Event%20Links%20belong%20to%20Orders.md),
which incorrectly limited an Order to one Event Link and treated Campaign as
presentation data only.

Implemented locally on 5 October 2026 in `EventInvitationService`,
`ParticipantRegistrationController`, and the `Event_Invitation__c.Order_Key__c`
metadata. UAT check-only deploy `0AfMA00000CqlFG0AZ` compiled all 21 selected
components and passed all 11 existing `TicketingTest` methods. Nothing was
deployed by that validation.
