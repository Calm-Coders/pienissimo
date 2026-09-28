---
id: flow-ticket-lifecycle
type: flow
status: in-progress
owner: ROMI
org: ROMI
updated: 2026-09-03
source: meetings/results/2026-08-06-chiusura-punti-aperti.md
requirement: BIG-01
---

# The ticket lifecycle

The state machine agreed on 2026-08-06 and final as of that session
([OI-74](../items/OI-74%20Asset%20state%20machine.md)):

| State                           | Trigger                                                       |
| ------------------------------- | ------------------------------------------------------------- |
| **Ordinato**                    | The order lands — the ticket record is created                |
| **Disponibile**                 | The invoice carrying that order line is **collected in full** |
| **Assegnato**                   | Documentation + QR emailed to the **named** participant       |
| **Utilizzato / Non utilizzato** | Set by the QR scan at the event                               |

_Assegnato_ was nearly dropped when digital signature left the ticket flow;
Sabatino Rinaldi kept it for reporting — _"ci fa statistica per capire quante
persone hanno il biglietto nelle mani."_

**Release is keyed to a fully paid tranche invoice**, not to the order and not
to a date — see
[OI-75](../items/OI-75%20Ticket%20availability%20rule.md), which supersedes every
earlier wording. Partial payment releases nothing, and because tranches follow
the customer's payment convenience rather than events, one event's ticket can
sit behind unrelated items in the same invoice. The match is on **numero di
riga d'ordine** returned on the Mexal invoice.

**Signature is out of this flow.** Participants sign on **paper** at check-in;
DocuSign applies only to quotes and contracts. The "mancata firma digitale"
edge case was struck outright on 2026-08-06.

Participant data, name changes and check-in fallbacks are in
[OI-78](../items/OI-78%20Participant%20data%20collection.md); the 60-day
communication funnel that drives it is
[OI-81](../items/OI-81%20Event%20communication%20funnel.md).

## 2026-08-19 - the table above is no longer known to be complete

[The 19 August ticket flow diagram](../The%20ticket%20flow%20diagram%20of%2019%20August.md)
disturbs this flow in two ways, and neither is settled:

- **A state that may be missing.** `Rinuncia` is drawn as its own box, at the
  participant-communication step — the referent declines when asked for the
  list. See [OI-74](../items/OI-74%20Asset%20state%20machine.md).
- **A transition that runs backwards.** The new
  [`Aggiornamento Incasso` button](../items/OI-91%20Aggiornamento%20Incasso%20button.md)
  puts an asset from `Disponibile` back to `Ordinato` when a payment was booked
  against the wrong tranche. Every transition in the table above moves forward;
  this one does not, and it means **release is reversible** — which
  [OI-75](../items/OI-75%20Ticket%20availability%20rule.md) does not currently
  allow for.

**Target object decided on 2026-08-24: standard Salesforce Asset.** The direct
instruction did not identify the decision-maker. The current UAT automation is
built against [`Biglietto__c`](../objects/The%20Biglietto%20build.md), which must
be migrated or rebuilt on Asset. The states above are not yet configured, and
[none of it has ever run end to end](../risks/Risk%20-%20the%20ticket%20lifecycle%20has%20never%20run%20end%20to%20end.md).

## 2026-09-03 - the participant entry point exists, the downstream does not

`participantRegistrationPage` was built and merged —
[the Landing Page community](../objects/The%20Landing%20Page%20community.md),
[OI-78](../items/OI-78%20Participant%20data%20collection.md).

🟢 The buyer-facing surface is real: account + campaign in, one row per visible
Asset, contact lookup by email, name / surname / email / phone captured per
participant.

🔴 **Nothing downstream of it is built.** No Campaign Member creation, no QR
document, no mail. And the lifecycle's own object problem is unchanged — the
target is standard **Asset**, `Biglietto__c` was deleted with its 37 records on
28 August, and the Asset build is still from scratch.

So the lifecycle now has a data-entry page and no ticket.
