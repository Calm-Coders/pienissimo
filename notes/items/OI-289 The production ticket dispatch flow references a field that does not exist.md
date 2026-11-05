---
id: OI-289
type: open-item
status: open
owner: Aurel Mrruku
org: ROMI
raised: 2026-10-26
updated: 2026-10-29
blocks: [go-live]
severity: gating
source: Gmail 1a17928d0e292e07
---

# OI-289 - The production ticket dispatch flow references a field that does not exist

**An active production flow that sends an assigned ticket failed twice on 26
October looking up `Asset.QR_Id__c`. That field is in no source file and no
Asset field directory in this repository, and the error says Salesforce cannot
find it in the org either. Ticket dispatch is the delivery the whole Biglietto
build exists for.**

## The evidence

Two Salesforce flow-error mails to `a.mrruku@romicompany.com`, **2026-10-26 at
17:01:19Z and 17:25:19Z** (Gmail thread `1a17928d0e292e07`):

> _"Si è verificato un errore nel flusso "Automazione: Invio Biglietto assegnato
> Flow" … Errore nell'elemento Get_Ticket_PDF (FlowRecordLookup). **Schema field
> not found. Entity: Asset, Field: QR_Id__c**"_

Flow details as the mail reports them:

- API name `flow_701SW00000fsgPXYAY_1791487932100`, flow id `301SW00000gDd57`
- Type **AutoLaunched**, **Version 5**, activation state **Attivo**
- Organisation **Pienissimo srl (`00Dbl000005BSMH`)** — 🔴 **production**
- Running user **Tech Romi (`005SW00000PV5Ja`)**
- The interview paused at _"Attesa Generazione PDF"_, resumed, and the
  `Get Ticket PDF` lookup over `ContentVersion` returned
  _"Impossibile trovare i record"_ — **then** the schema error fired.

🔑 **Two failures 24 minutes apart**, so it is not a one-off.

## What the repository says

Checked at `origin/DevMain` `428f42b`:

- 🔴 **`QR_Id__c` appears in no metadata file.** `grep` finds it only in prose —
  the requirement register, [the Biglietto build](../objects/The%20Biglietto%20build.md),
  [Ticket QR code generation](../Ticket%20QR%20code%20generation.md),
  [Ticket QR lookup endpoint usage](../Ticket%20QR%20lookup%20endpoint%20usage.md),
  OI-197, OI-198, OI-161 and the trackers.
- 🔴 **`force-app/main/default/objects/Asset/fields/` does not contain it.** The
  twelve Asset fields in source are `Anno_Competenza__c`, `Campaign__c`,
  `Data_CheckIn__c`, `Fattura_Pagata__c`, `Fattura_Rif__c`, `Fonte_Acquisto__c`,
  `Order_Product__c`, `Participant_Document_Token__c`,
  `Participant_Document_Token_Expires__c`, `Ready_for_Ticket_Dispatch__c`,
  `Ticket_Sent__c`, `Ticket_Sent_Date__c`.
- 🔴 **The flow itself is not in source either** — there is no
  `force-app/main/default/flows/` content for it. It is **org-only metadata**,
  so it was never in a deploy's scope and nothing in the repository describes
  it.

So the record names a QR identity concept, source implements ticket identity
through `Participant_Document_Token__c`, and an active production flow asks for
a third name that exists nowhere.

## Readings, and which is likelier

1. **The field was never created in production.** The flow was built in the org
   against a field somebody intended to add. Consistent with the error text and
   with the field's total absence from source.
2. **The field existed and was removed.** Nothing in the repository records such
   a deletion, and the Asset field set in source has no gap suggesting one.
3. ⚠ **Not established**: whether today's release changed anything here. The
   flow is org-only and was not in the deploy, so the release is unlikely to be
   the cause — but the first failure is ~2 hours after it, and 🔑 **nobody has
   checked whether this flow was failing before today.** Recorded as an open
   question, not as a correlation.

⚠ **The org was not opened in this run.** Everything above is the mail plus
repository arithmetic.

## Why it is gating

The flow's name is its consequence: _Invio Biglietto assegnato_ — sending an
assigned ticket. Ticket delivery is the outcome
[OI-197](OI-197%20The%20ticket%20send%20flag%20and%20the%20Inviato%20asset%20state%20are%20agreed%20and%20unbuilt.md)
and the whole Asset/Biglietto chain exist to produce, and the client's Academy
tickets start from Salesforce in January. An active autolaunched flow that
throws on every run delivers nothing, silently, to everyone but the mailbox
receiving the errors.

⚠ Note the **second** failure in the same interview: the `ContentVersion` lookup
found no PDF before the schema error. Whether the PDF generation it waited on
also failed is unknown, and would be a separate fault on the same path.

## 🔴 2026-10-29 - it failed again, after the release, and the field is still absent

**A third failure, and the first since the production release of the same day.**
Salesforce flow-error mail to `a.mrruku@romicompany.com`, Gmail
`1a188112eb9acee3`, sent **2026-10-29 14:29:49Z**, reporting an interview that
started **07:28** and errored **07:29** org time:

> _"Errore nell'elemento Get_Ticket_PDF (FlowRecordLookup). **Schema field not
> found. Entity: Asset, Field: QR_Id\_\_c**"_

Everything identifying the flow is unchanged from the 26/10 pair: API name
`flow_701SW00000fsgPXYAY_1791487932100`, flow id `301SW00000gDd57`, **AutoLaunched**,
**Version 5**, **Attivo**, organisation **Pienissimo srl (`00Dbl000005BSMH`)** —
production — running as **Tech Romi (`005SW00000PV5Ja`)**. The interview again
paused at _"Attesa Generazione PDF"_, resumed, and the `Get Ticket PDF` lookup over
`ContentVersion` again returned _"Impossibile trovare i record"_ **before** the
schema error.

🔑 **This answers a question these records have carried as unreachable since
26 October: `Asset.QR_Id__c` does not exist in production.** Not "is not in
source" — Salesforce itself cannot resolve it in the org, three days later and
after a full release.

🔑 **And it closes reading 3 of the section above.** The 26/10 note left open
whether that day's release caused this, noting the flow is org-only and was not in
the deploy's scope. Another release landed on 29 October — the `UAT` and `Prod`
branches both moved (PR #118 and PR #119) and a quick deploy went to production —
and **the flow still fails identically**. 🔑 **So it is not release-induced.** It is
a standing fault that no deployment has touched because the flow lives only in the
org.

⚠ **Unchanged and still unknown:** whether the `ContentVersion` miss is a second
fault or the same one, and **whether anyone has seen these mails.** Three
notifications across three days have produced no recorded action.

⚠ **Possibly connected, not established:** step 2 of
[OI-301](OI-301%20Three%20production%20manual%20setup%20steps%20are%20outstanding.md) —
the `ParticipantDocumentRequestTrigger` platform-event subscriber has no
production user set. An unconfigured document subscriber would produce exactly the
missing `ContentVersion` seen here. It would **not** explain the missing field.

⚠ **The org was not opened in this run either.** This is the mail plus the branch
and deploy record.
