---
id: OI-100
type: open-item
status: resolved
owner: Aurel Mrruku
org: ROMI
raised: 2026-08-27
updated: 2026-10-19
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

## 2026-10-16 - Aurel decides that every conversion creates a new Contact

Aurel Mrruku explicitly ruled that Lead conversion must **always create a new
Contact, even when a matching Contact already exists**. The Account continues
to be resolved by VAT; Contact identity is not reused during conversion.

This supersedes both the three undecided options above and the merge behaviour
demonstrated on 24 September. Source was changed in the same session to stop
setting `LeadConvert.ContactId` and to remove the qualification-time
Contact/Account conflict guard. The stock cross-object duplicate rule also
needs to report, but not alert/block, when the new Contact matches an existing
one. The current change was deployed to the partial sandbox on 16 October 2026
(`0AfMA00000CwEwX0AV`).

The Lead after-update trigger now owns all Account email propagation when the
Lead becomes converted: it copies `Lead.Email` into both `Account.Email__c` and
`Account.Lead_Email__c` when each target field is blank. This covers both the
custom queueable and a conversion started manually from CRM, while preserving
existing values. The queueable contains no Account email-population logic.

A post-deployment retry still failed because two active **Contact** duplicate
rules retained an insert alert. The earlier change had covered only the Lead
rule, but `Database.convertLead` creates a Contact and does not expose the
documented internal contact-dedupe bypass. Both Contact rules are therefore
source-controlled as active and report-only on insert: duplicate matches remain
recorded, but they no longer abort Contact creation. Deployed to the partial
sandbox on 16 October 2026 (`0AfMA00000CwE6w0AF`).

## 2026-10-16 - Only Account email propagation remains in Apex

Aurel Mrruku then instructed that the Lead trigger and conversion queueable
return to their prior behaviour except for Account email propagation. The
queueable again reuses an existing Contact when email and phone match inside
the VAT-resolved Account; the qualification-time cross-Account conflict guard
is restored. Only the trigger-based copy from `Lead.Email` into blank
`Account.Email__c` and `Account.Lead_Email__c` remains as new Apex behaviour.

The duplicate-rule correction remains separate: matching records are reported,
but the standard alerts no longer abort record creation. The restored Apex plus
trigger-only email propagation deployed to the partial sandbox under
`0AfMA00000CwGa90AF`.

## 2026-10-16 - Duplicate alerts restored in the sandbox

Aurel Mrruku re-enabled `Alert` alongside `Report` for insert and update on all
three Lead/Contact duplicate rules, then requested a source retrieve. The local
metadata now matches that org state. The restored queueable can still convert
when it finds and reuses the exact Account-scoped Contact; a conversion that
must insert a Contact can still be blocked if a broader platform match fires.

## 2026-10-16 - Alert failure reproduced with synthetic data

A synthetic Account, Contact and Lead were created in the partial sandbox. The
Lead shared its person fields with the Contact but carried a different, unused
VAT, so the queueable could not reuse that Contact inside the resolved Account.
Qualification enqueued conversion; the queueable completed its handled-failure
path and restored the Lead to `New`, unconverted. This confirms that the
restored alerts can still block the new-Contact path.

## 2026-10-19 - VAT-selected Azienda wins across Accounts

Aurel Mrruku ruled the concrete cross-Account case: when the Lead VAT resolves
to Azienda A but the same email and phone identify a Contact under Azienda B,
conversion must continue against Azienda A. It creates a new Contact there and
creates the Opportunity there; the Contact under Azienda B does not block the
conversion.

The qualification-time Contact/Account conflict guard was removed from
`LeadConversionTriggerHandler` and deployed to the Pienissimo partial sandbox
as `0AfMA00000Cx0pt0AB`. `LeadConversionQueueable` remains VAT-first and still
reuses a matching Contact only when that Contact is already under the
VAT-selected Account.

The two active Contact duplicate rules were retrieved from the sandbox before
deployment and are `Allow` + `Report` on insert and update, so they record but
do not block the new Contact. This later org inspection supersedes the final
16 October paragraph above that described those rules as alerting.
