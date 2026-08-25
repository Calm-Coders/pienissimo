---
id: OBJ-campaign-model
type: object
status: in-progress
owner: Elena Spini
org: both
raised: 2026-08-20
updated: 2026-08-25
source: notes/meetings/2026-08-20 Flusso Asset Biglietti.md
depends_on: [OI-77, OI-84, OI-46]
---

# The campaign parent and child model

**How an event becomes a Salesforce Campaign, agreed with the client on
2026-08-20 and configured internally on 2026-08-24.** This supersedes the flat
"one campaign per event product" reading the record carried until now.

## The three levels

| Level               | What it is                                                                                               | How it is created                                      |
| ------------------- | -------------------------------------------------------------------------------------------------------- | ------------------------------------------------------ |
| **Campagna Padre**  | The grouping container — the event as a franchise, for statistics and roll-up                            | Manually                                               |
| **Campagna Figlio** | The **annual edition**, e.g. _"Food Marketing Festival Aprile 2026"_, carrying dates, venue and check-in | Manually, cloned from the previous edition             |
| **Campaign Member** | The participants                                                                                         | Automatically, on confirmation of the participant list |

Volume is roughly **10 campaigns a year**, created manually once a year.
Fabrizio Paganelli confirmed on 20 August that this is manageable by hand, so
**no import or generation tooling is owed** for campaign creation itself.

## The configuration agreed 24 August

- **Two Record Types on Campaign**, one for parent and one for child.
- **A lookup field on Product holding the parent campaign code**, populated **by
  hand after the campaign is created**.
- **Automation enforcing one active child campaign per parent**, so that the
  asset can resolve "the current edition" without ambiguity.
- The asset is attached to the correct active child campaign by **checking the
  campaign code as the order descends** from Mexal.
- **Membership is created at enrolment only.** Buying tickets does not make the
  purchaser a campaign member — see
  [OI-84](../items/OI-84%20Campaign%20Member%20handling%20for%20manual%20check-in.md).

All four appear as cells in the master design file, added the same afternoon —
[the newest design diagram](../The%20newest%20design%20diagram.md).

## Why this matters beyond campaigns

**It is the mechanism that carries the event edition**, and it does so _without_
a year field on the product. That is the direct consequence of Fabrizio
Paganelli's 20 August constraint: Mexal article codes are transversal across
years, and the edition is determined by the **order date**, not the product.

The built `Product2.Anno_Solare__c` picklist assumes the opposite. The active
child campaign, resolved at order time, is what the design now uses instead —
which is why [OI-46](../items/OI-46%20Bundle%20classification%20picklists.md) is
now a design conflict rather than a missing-values problem.

Note also that the child campaign's period is an **event edition**, not
necessarily a calendar year: Elisa Migliano's 19 August example was the academic
year **2026-2027**.

## What is unbuilt

Everything above. Nothing in `force-app/` implements a parent/child campaign
split, the Record Types, the product lookup or the single-active-child rule as of
this note. [OI-77](../items/OI-77%20Mexal%20event%20product%20creates%20the%20Campaign.md)
still describes the older single-campaign automation, which the
`Product2.Genera_Biglietto__c` flag was built for.

⚠ **The manual lookup is a fragile link.** The whole automatic asset-to-edition
attachment depends on a field an administrator has to remember to fill in after
creating each campaign, once a year, for ten campaigns. There is no minuted
control that catches an empty lookup.

## 2026-08-25 - org check: confirmed entirely unbuilt

Verified read-only against **Pienissimo UAT**. The word "unbuilt" in this note
is now measured rather than assumed.

- **`Campaign` carries zero custom fields.** No parent/child marker, no product
  lookup, no edition field.
- **No Campaign record types.** The only record types in the org are
  `Product2.Bundle` and `Product2.Item`. Campagna Padre and Campagna Figlio have
  no way to be distinguished.
- **No validation rule anywhere on Campaign** — so the one-active-child rule has
  no enforcement point. The org's only two validation rules are
  `BundleComponent__c.Bundle_Required` and `BundleComponent__c.Product_Required`.
- **No Flow of any kind exists in the org**, so nothing creates a Campagna
  Figlio from a Mexal event product
  ([OI-77](../items/OI-77%20Mexal%20event%20product%20creates%20the%20Campaign.md))
  and nothing manages Campaign Members
  ([OI-84](../items/OI-84%20Campaign%20Member%20handling%20for%20manual%20check-in.md)).
- Three Campaign records exist, and `CampaignMember` uses the stock layout.

⚠ **Do not mistake `Campaign.Child_Campaign` for this model.** That quick action
exists in the org, but it was created on **2026-05-13 by "Amministratore
Pienissimo"** — three months before the 20 August design — and its twin
`Account.Child_Account` carries the same timestamp. It is stock sandbox
scaffolding, not an implementation of this note.

This matters more than its own row suggests: the campaign parent/child model is
what carries the event edition **instead of** `Product2.Anno_Solare__c`
([OI-46](../items/OI-46%20Bundle%20classification%20picklists.md)). The
replacement is unbuilt while the thing it replaces is still configured.
