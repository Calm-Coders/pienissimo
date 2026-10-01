---
id: DEC-2026-10-01-event-link-order
type: decision
status: active
owner: null
org: ROMI
raised: 2026-10-01
updated: 2026-10-01
depends_on: [OI-78, OI-127]
source: User instruction to Codex on 2026-10-01
---

# Decision - Event Links belong to Orders

An Event Link (`Event_Invitation__c`) belongs to exactly one Order, and an Order
cannot have more than one Event Link. Campaign is not part of the relationship or
uniqueness rule.

`Event_Invitation__c.Campaign__c` is still populated and preserved as descriptive
event context. Automatic creation takes it from the first ticket generated for the
Order; if an existing Order invitation has no Campaign, later ticket generation
fills the blank value. It is never cleared merely because identity is Order-based.

The participant community page resolves the Order from the invitation token and
loads the Assets commercially originating from that Order. It groups those Assets
by their event edition for presentation only. Each displayed participation group
has one `Rinuncia` action, which applies to every Asset in that group.

Only Assets whose current status is exactly `Disponibile` appear in the editable
Campaign groups or accept participant data. Assets already in `Assegnato` remain
visible as a read-only summary at the bottom of the participant page. A group's
`Rinuncia` action is hidden when any Asset in that Campaign group is `Assegnato`;
the server also blocks the action under record locks. Otherwise one click moves
every Asset in that Campaign group to `Rinuncia`, including siblings hidden from
the page because they were in another state. A paid tranche may promote an Asset
from `Ordinato` to `Disponibile`, but it must not reset an Asset already in
`Assegnato`, `Rinuncia`, or another later state.

When the participant submits valid Contact data, the same atomic Asset update
that sets `ContactId` and moves the ticket to `Assegnato` also sets
`Ready_for_Ticket_Dispatch__c = true`. The checkbox defaults to false and is the
explicit hand-off signal for the downstream ticket-dispatch process.

Implemented locally on 1 October 2026. The selected 25-component check-only deploy
to UAT compiled successfully as `0AfMA00000CpNoT0AV`; it did not persist changes.
