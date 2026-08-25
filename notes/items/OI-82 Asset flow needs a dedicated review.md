---
id: OI-82
type: open-item
status: resolved
owner: Elena Spini
with: Elisa Migliano
org: both
raised: 2026-08-06
updated: 2026-08-24
source: meetings/results/2026-08-06-chiusura-punti-aperti.md
---

# OI-82 - Asset flow needs a dedicated review

Elisa Migliano and Elena Spini both acknowledged in the closing session that
the asset/ticket flow **is not fully specified**, with
[Rebecca Marmo](../people/Rebecca%20Marmo%20-%20Pienissimo%20marketing.md) to be
included.

📅 **Now scheduled: 20 August 2026** — and Elena's 7 August status records why it
exists, in Elisa's own framing: a meeting _"voluto da Elisa dell'amministrazione
perché ha detto che ci sono delle cose di cui non abbiamo mai parlato"_. Elena's
reaction, verbatim: _"(ho paura.)"_ Treat this as a **scope-discovery** meeting,
not a review of an agreed design.

This is the honest counterweight to the rest of the 2026-08-06 record. That
session settled the [state machine](OI-74%20Asset%20state%20machine.md), the
[availability rule](OI-75%20Ticket%20availability%20rule.md) and
[participant handling](OI-78%20Participant%20data%20collection.md) — enough to
read as finished. The two people who run the process say it is not.

The meeting is **not scheduled**. It competes for the same last week of August
as every other restart
([the compressed calendar](../risks/Risk%20-%20the%20whole%20remaining%20build%20lands%20after%20Ferragosto.md)),
and it should logically precede building
[OI-78](OI-78%20Participant%20data%20collection.md) rather than follow it.

Worth bringing to it: the
[divergence from the approved data model](../risks/Risk%20-%20the%20Biglietto%20object%20diverged%20from%20the%20approved%20proposal.md),
the [undesigned manual check-in path](OI-84%20Campaign%20Member%20handling%20for%20manual%20check-in.md),
and the fact that
[the lifecycle has never run end to end](../risks/Risk%20-%20the%20ticket%20lifecycle%20has%20never%20run%20end%20to%20end.md).

## ✅ 2026-08-24 - the review happened, on 20 August

This item asked for a dedicated session on the asset flow. **It ran on 20 August
2026** — [Flusso Asset/Biglietti](../meetings/2026-08-20%20Flusso%20Asset%20Biglietti.md) — called by Elisa Migliano, with Fabrizio
Paganelli, Marco Montesi and Rebecca Marmo for Pienissimo and Elena Spini for
ROMI. A [marketing session on the ticket funnel](../meetings/2026-08-19%20Flussi%20MKT%20Biglietti.md) ran the day before.

Elena Spini minuted it to the client the same evening. It produced rulings on
event/ticket classification, the campaign model, ticket-type ownership, the
incasso correction route, and the quote lifecycle — recorded on
[OI-46](OI-46%20Bundle%20classification%20picklists.md),
[OI-76](OI-76%20Ticket%20type%20picklist%20on%20the%20product.md),
[OI-92](OI-92%20Mexal%20Scadenziario%20as%20the%20trigger%20to%20reverse%20an%20asset.md),
[OI-59](OI-59%20Quote%20workflow%20configuration.md) and
[the campaign parent and child model](../objects/The%20campaign%20parent%20and%20child%20model.md).

**Resolved as an ask.** ⚠ But note what the review cost: Aurel Mrruku was not in
it, so the technical decisions were taken without ROMI's technical lead present,
and the minute reached him only on **24 August**, four days later.
