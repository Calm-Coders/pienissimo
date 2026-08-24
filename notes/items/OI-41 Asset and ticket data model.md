---
id: OI-41
type: open-item
status: resolved
owner: Aurel Mrruku
org: ROMI
raised: 2026-07-13
updated: 2026-08-24
requirement: DM-22
source: direct instruction 2026-08-24; meetings/proposals/2026-07-13-asset-ticket-data-model.md
---

# OI-41 - Asset and ticket data model

ROMI's draft proposal of 2026-07-13 was to use the **standard Salesforce
Asset** object, one record per ticket, with the ticket lifecycle and a
flow-synced CampaignMember.

**Decision recorded on 2026-08-24: the target ticket object is the standard
Salesforce Asset object.** The direct instruction did not identify the
decision-maker, so no personal attribution is recorded here.

The current UAT implementation is not the target model. `Biglietto__c` is a
custom object that must be replaced or migrated — see
[the Biglietto build](../objects/The%20Biglietto%20build.md) and
[the divergence risk](../risks/Risk%20-%20the%20Biglietto%20object%20diverged%20from%20the%20approved%20proposal.md).

OI-41 is resolved because the object-choice decision has now been made. The
implementation work remains open: inventory the fields and behaviour built on
`Biglietto__c`, map them to Asset, and rebuild or migrate the automations without
losing the agreed lifecycle, QR/PDF behaviour, participant links or reporting.

The detailed lifecycle and creation rules remain tracked by
[OI-74](OI-74%20Asset%20state%20machine.md) for the lifecycle and
[OI-53](OI-53%20Asset%20generation%20rule.md) for creation.
