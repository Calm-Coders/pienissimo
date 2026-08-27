---
id: OI-77
type: open-item
status: in-progress
owner: ROMI
org: ROMI
raised: 2026-08-06
updated: 2026-08-26
depends_on: [OI-76]
source: meetings/results/2026-08-06-chiusura-punti-aperti.md
requirement: BIG-02
---

# OI-77 - Mexal event product creates the Campaign

**A Mexal event product auto-creates the matching Salesforce Campaign** on the
nightly product sync, so attendance indexes against the campaign when the QR is
scanned.

One campaign per event edition; campaign members are participants carrying a
check-in status of participated or no-show. That is the data source for the
no-show and room-composition analytics the project was justified by.

Depends on the **event flag** on the product master, which
[OI-76](OI-76%20Ticket%20type%20picklist%20on%20the%20product.md) asks Fabrizio
Paganelli to create and which does not exist.

Note the overlap with
[OI-53](OI-53%20Asset%20generation%20rule.md), where an **order** containing an
event product creates the Campaign if absent. Two different triggers can create
the same record — the nightly product sync and the order — so whichever is
built second has to be idempotent. Nobody has written down which is
authoritative, and `OrderBigliettoTrigger` was already committed on 4 August
without this rule being decided.

Nightly product sync mechanics:
[the Mexal integration](../flows/The%20Mexal%20integration.md).

## 2026-08-24 - superseded in scope: it is now a three-level campaign model

This item describes a single automation — a product arriving from Mexal with the
`genera biglietto` flag causes Salesforce to create a campaign named after the
product. The [19 August MKT session](../meetings/2026-08-19%20Flussi%20MKT%20Biglietti.md) **confirms that mechanism**, and Elena
Spini is minuted clarifying that a Salesforce Campaign here is a **container for
members**, not a marketing campaign.

But the [20 August](../meetings/2026-08-20%20Flusso%20Asset%20Biglietti.md) and [24 August](../meetings/2026-08-24%20Follow-up%20Interno.md) sessions replaced the flat model
with **Campagna Padre → Campagna Figlio → Campaign Member** — see
[the campaign parent and child model](../objects/The%20campaign%20parent%20and%20child%20model.md).

What that changes for this item:

- **Campaigns are created manually, once a year, roughly ten of them**, with
  cloning. So the auto-creation this item specifies is **not what the client
  agreed to** for the campaign records themselves.
- What remains automatic is the **attachment of the asset to the correct active
  child campaign**, keyed on a **parent campaign code held in a lookup field on
  the Product** and checked as the order descends.
- That lookup is **populated by hand after the campaign is created**.

`Product2.Genera_Biglietto__c` is built and still has nothing upstream to
populate it. The parent/child Record Types, the product lookup and the
one-active-child rule are all unbuilt.

**Reword this item's scope when the tracker is next regenerated** — the number
stays, but "creates the Campaign" is no longer accurate.

## 🔴 2026-08-26 - the mechanism is replaced again

This item's 24 August section records the campaign-attachment mechanism as
**a parent campaign code in a lookup on Product, plus a one-active-child rule**.
The [26 August Mexal review](../meetings/2026-08-26%20Review%20Temi%20Integrazione%20Mexal.md)
**abandoned both halves**.

- The **event (Campagna Padre)** comes from Mexal's `categoria statistica`, not
  from a hand-populated Salesforce lookup.
- The **edition (Campagna Figlio)** comes from
  [a date-range mapping table](OI-96%20Edition%20mapping%20table%20on%20Salesforce.md),
  resolved per **order line** against the order date.
- The **one-active-child rule is dead.** Elena Spini said so in the session: it
  cannot survive a bundle spanning two events. Aurel Mrruku accepted the
  replacement — _"non mettono il flag campagna attiva… mettono solo le date."_

What survives from this item unchanged: campaigns are **created manually**, about
ten a year, and `Product2.Genera_Biglietto__c` remains the flag that decides an
order line generates a ticket — now fed from Mexal's `natura`
([OI-47](OI-47%20Product%20flags%20at%20import.md)).

**New requirement from the same session:** when administration manually reassigns
a no-show's ticket to the next edition as a goodwill ticket, **the Asset must be
linked to the next Campagna Figlio by hand**, or the no-show reminder automation
never fires again for that ticket. Aurel Mrruku raised it, Elena Spini agreed
before leaving. There is no control that catches an unlinked reassignment.

The item's title is now wrong twice over — a Mexal event product creates neither
the campaign nor, any longer, the link to it. **Reword when the tracker is next
regenerated; the number stays.**
