---
id: OI-29
type: open-item
status: stale
owner: Joint
org: both
raised: 2026-06-30
updated: 2026-08-14
source: meetings/open-items.md row 29
---

# OI-29 - Account creation policy for free tour tickets

The September tour is roughly **90% new audience**, with data typed by the
attendees themselves. A quote implies an account in Salesforce — so does every
free-ticket attendee get an account?

Untouched since 30 June and formally stale, but two later decisions have made
it live again without anyone reopening it:

- [VAT validation now fires at the first order of an account](OI-73%20VAT%20validation%20moves%20into%20Salesforce.md),
  explicitly **not** at account creation, and explicitly because free events
  draw 3,000–6,000 registrants of whom ~250 buy. That answers the cost half of
  this question.
- [Partita IVA is now mandatory on the live-stream lead forms](OI-72%20Partita%20IVA%20mandatory%20on%20lead%20forms.md),
  accepted in the knowledge that free registrants will type junk.

So the shape of the answer exists — mass low-quality registrations, corrected at
payment — but nobody has stated whether those registrations become **Accounts**,
**Leads**, or Campaign Members against a contact.

It needs deciding before the tour on **7–19 September**, which is before
go-live, and it determines what the 
[free zero-euro orders](OI-57%20Zero-euro%20orders%20stay%20in%20the%20CRM.md) attach
to.
