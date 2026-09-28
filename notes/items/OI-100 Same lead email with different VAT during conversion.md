---
id: OI-100
type: open-item
status: open
owner: Aurel Mrruku
org: ROMI
raised: 2026-08-27
updated: 2026-08-27
depends_on: [OI-72, OI-80]
blocks: [lead-conversion]
source: user question, 2026-08-27 Codex session
---

# OI-100 - Same lead email with different VAT during conversion

Question for Aurel: **when two Leads have the same email but different
`Partita_IVA__c` / VAT numbers, should Lead conversion treat them as the same
person under one Account, or as two different company contexts?**

The current record decides two adjacent rules, but not this conflict:

- [OI-80](OI-80%20Lead%20routing%20queues.md) records the 24 August Lead/Opty
  decision that Form 2 auto-qualifies, reuses an existing Account when the email
  matches, and creates no duplicate Lead when the email matches an existing
  Account or Contact.
- [OI-72](OI-72%20Partita%20IVA%20mandatory%20on%20lead%20forms.md) records
  that Partita IVA is collected on lead forms because it identifies the company
  for Lead-to-Account conversion.
- `DM-04` in
  [pienissimo-requirements.yaml](../../requirements/pienissimo-requirements.yaml)
  says dedupe is by email or phone for forms, and by email + VAT for
  WooCommerce.

The built manual conversion behavior currently matches by Contact email and
prefers a Contact already linked to an Account. It does **not** evaluate VAT.
So a new qualified Lead with an email already present on a Contact can create
only a new Opportunity on that existing Account/Contact, even if the Lead's VAT
points to a different company.

Decision needed before changing the automation:

1. **Email wins:** the same email always reuses the existing Contact/Account,
   even when VAT differs.
2. **VAT wins:** a different VAT creates or reuses a different Account, even if
   the email already exists on another Contact.
3. **Conflict blocks conversion:** if email matches but VAT differs, Salesforce
   should stop or flag conversion and ask the user to choose the correct
   Account/Contact.

Status: waiting for Aurel before adding VAT-based matching, changing duplicate
rules, or changing the Lead conversion Apex.
