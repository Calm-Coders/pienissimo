---
id: OI-170
type: open-item
status: open
owner: unassigned
org: ROMI
raised: 2026-09-23
updated: 2026-09-23
depends_on: [OI-150, OI-156]
blocks: [go-live]
severity: gating
source: org-status-check against Pienissimo UAT, 2026-09-23 08:01-08:40Z
evidence: Tooling ApexClass.Body and ApexTrigger.Body compared token by token against force-app at 61f2a53, each org body matched to a git commit
---

# OI-170 - DevMain is ahead of UAT on the Lead conversion and quote-line paths

**Found by the 23/09 org-status check, the morning before Lead and Opportunity UAT
(24/09).** Merged work on `DevMain` never reached the Pienissimo UAT org. For every
file below, the org body matches an **older commit** that is on `DevMain`. So this
is committed work that nobody deployed. It is not a set of changes made in the org.

| Component                                              | Org runs                    | `DevMain` has             | What is missing in UAT                                                                                                                                            |
| ------------------------------------------------------ | --------------------------- | ------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `LeadConversionQueueable`                              | `08b97cc` (21/09)           | `54e0be1` (22/09, PR #55) | 🔴 **The Lead-type → Opportunity-record-type mapping.** The org still forces **every** converted Opportunity to `Standart` and ignores `Lead.Tipo_Opportunita__c` |
| `QuoteLineItemTrigger` + `QuoteLineItemTriggerHandler` | `2d31ebe` (18/09)           | `ab47b42` (22/09, PR #55) | The new `after insert` rule that **moves a quote back to `Bozza` when a line is added**                                                                           |
| `QuoteLineItemsController`                             | `e992e6a` (17/09)           | `ab47b42`                 | The switch to `without sharing`                                                                                                                                   |
| `QuoteNegotiationAgingBatch`                           | a 21/09 version, same logic | `ab47b42`                 | The switch to `without sharing`. The schedule itself is live: `Quote Negotiation Aging - Daily` runs at 01:00 UTC and has completed three times                   |
| `BundleProductAssignmentControllerTest`                | `dd4e95c` (02/09)           | `98414d2` (17/09)         | Test class only                                                                                                                                                   |

## Why it matters

- 🔴 **[OI-150](OI-150%20Opportunity%20type%20comes%20from%20a%20Lead%20picklist.md)
  cannot be shown tomorrow.** Its note says the mapping "passed a check-only
  Salesforce deploy on 2026-09-22". **A check-only deploy changes nothing in the
  org**, and the org confirms it: of the 15 Opportunities created in the last
  seven days on `Standart`, one carries `Tipo_Opportunita__c = Vendita da tutor`,
  and nothing in UAT reads the Lead's value.
- 🔴 **The rest of PR #55 is deployed.** The Lead record types, `Lead.Tipo_Opportunita__c`
  and `LeadConversionTriggerHandler` are all in the org. So UAT shows a picklist that
  appears to work and does nothing at conversion.
- ⚠ **The quote reopen rule matters for the 25/09 Preventivi UAT.** Without it, a
  line added to an `In Trattativa` or `Accettato` quote leaves the status unchanged.
- ⚠ **This goes the opposite way to the usual drift on this project.** Earlier
  checks found work in the org that was missing from git (see
  [OI-171](OI-171%20A%20bundle%20discount%20was%20deployed%20to%20UAT%20from%20no%20commit.md)
  for today's case). Here git has work the org is missing. The cause is the same:
  **nobody owns the step that deploys a merge to UAT.**

## Consequence for a deploy

⚠ **A deploy of `DevMain` to UAT, needed to close this item, would also overwrite
[OI-171](OI-171%20A%20bundle%20discount%20was%20deployed%20to%20UAT%20from%20no%20commit.md)**,
the bundle-discount change in `QuoteManageProductsController` and
`quoteManageProducts` that exists only in the org. That work has to be committed
first. It also brings the four `without sharing` changes of
[OI-156](OI-156%20QuoteTriggerHandler%20runs%20without%20sharing.md) into UAT,
which is a decision still open, not a formality.

## Open

- 🔴 **Deploy `LeadConversionQueueable` to UAT before the 24/09 session**, or tell
  the session that conversion always produces `Standart`.
- 🔴 **Name who deploys a merged PR to UAT**, and how that is checked.
- ⚠ The org was read and nothing was deployed. Nothing about this item has been
  **fixed**.
