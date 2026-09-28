---
id: OI-53
type: open-item
status: open
owner: ROMI
org: ROMI
raised: 2026-07-22
updated: 2026-08-24
source: meetings/open-items.md row 53
requirement: BIG-02
---

# OI-53 - Asset generation rule

Every order containing an "evento" product auto-creates a **Campaign** if one
does not exist, plus **one Asset per event article code** — including
multi-event bundles and tutor-entered orders.

Terminology fixed in the same session: **the Asset is the record, the QR is a
value inside it.**

**Partly built, and the tracker does not know.** The 2026-08-03 org check
concluded "nothing creates a Biglietto from an Order". On 4 August
[Anita Aga](../people/Anita%20Aga%20-%20Salesforce%20developer%20ROMI.md)
committed `OrderBigliettoTrigger`, its handler and a test class — _"Added logic
for biglietto creation after order confirmed"_. See
[the build ahead of the record](../objects/The%20build%20ahead%20of%20the%20record.md).

What has **not** been verified is whether that trigger implements this rule or
a simpler one: campaign auto-creation, the per-event-code fan-out on bundles,
and the tutor-entered path all need checking against the code before this item
is closed. The companion rule that
[a Mexal event product creates the Campaign](OI-77%20Mexal%20event%20product%20creates%20the%20Campaign.md)
on nightly sync is separate and untouched.

## 2026-08-24 - decided on 19 August, but the record of it disagrees with itself

The [19 August MKT session](../meetings/2026-08-19%20Flussi%20MKT%20Biglietti.md) settled when a ticket asset is created — and its
own minute states it two different ways.

- The **Dettagli** section, narrating the discussion between Elisa Migliano and
  Elena Spini, says the asset is created **when an order carrying an event-type
  product is generated**, explicitly to avoid creating assets at quote stage that
  then have to be deleted by hand. It gives the motivation, so it is the more
  load-bearing of the two.
- The auto-generated **Decisioni** line says generation happens _"al momento
  dell'accettazione dell'ordine o del preventivo"_ — order **or quote**, which is
  the thing the Dettagli says they were avoiding.

⚠ **Build to neither until this is confirmed.** Per `drill-meeting`, Gemini
auto-summaries in this project have contradicted the transcript outright, and
this is a clean instance: prefer the Dettagli, but get it ruled on. The
transcript exists and can be searched for the exact exchange.

The 24 August internal sessions did not revisit it.

This rule keys on the event flag on the product —
[OI-76](OI-76%20Ticket%20type%20picklist%20on%20the%20product.md) — which on the
Salesforce side is built (`Product2.Genera_Biglietto__c`) with nothing upstream
to populate it.
