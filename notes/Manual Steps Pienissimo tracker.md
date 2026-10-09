---
id: ref-manual-steps-tracker
type: reference
status: active
owner: Rexhina Hysi
org: ROMI
raised: 2026-10-09
updated: 2026-10-09
source: Google Drive 1u-LgUKVlGK9ePyjMzZ_uJjXniHluo5_449siHgAIBHo
---

# Manual Steps Pienissimo tracker

**A new Google Sheet that collects the org configuration which no metadata
deploy carries — the post-deploy steps someone must click by hand. Both rows are
done in UAT and neither is done in Prod.**

Created by **Rexhina Hysi** on **2026-10-09T09:21:27Z**, last modified
**09:37:30Z**, shared with Aurel Mrruku at 09:29:58Z (Drive notification mail,
same timestamp). Drive id `1u-LgUKVlGK9ePyjMzZ_uJjXniHluo5_449siHgAIBHo`.
One sheet, `Foglio1`, range `A1:C3` — a header and **two rows**.

## The shape

| Column | Meaning |
| ------ | ------- |
| `Manual Step` | the click-path, written as Setup navigation |
| `Status Uat` | `Done` on both rows |
| `Status Prod` | **empty on both rows** |

## The two steps

1. **Lead record-type settings.**
   `Setup → Feature Settings → Marketing → Lead Settings → Record Type Settings`
   → _"Keep the existing record type"_. This is the lead-conversion record-type
   behaviour; it is an org preference, not metadata.
2. **The platform-event subscriber's running user and batch size.**
   `Setup → Event Studio` → the platform event used by
   `ParticipantDocumentRequestTrigger` → Apex Trigger Details for the subscriber
   → Edit → **select the correct active Production user**, keep
   `Batch Size = 200`, save. Then
   `Setup → Platform Events → [event] → Subscriptions` → Manage beside
   `ParticipantDocumentRequestTrigger` → **Suspend and Resume** so the new
   configuration takes effect immediately.

🔑 **Step 2 is the run-as user for participant document generation** — the PDF
run-as user whose permission sets the 04/10 standing authorization enumerates
(`Campaign_Management`, `Ticket_Asset_Management`, `Product_Registry_Admin`,
`Participant_Document_Generation`). A platform-event subscriber's running user is
**not** in metadata: it is set per org, by hand, and a sandbox refresh or a new
org resets it.

## 🔴 Why this matters now

**`Status Prod` is blank on both rows and the production confirmation is due
13/10, with go-live on 21/10.** These are exactly the steps a green metadata
deploy leaves undone, and the second one decides whether participant documents
generate at all in production.

⚠ **Nothing assigns them.** The sheet records state; it names no owner for the
Prod column and carries no date.

⚠ **It is a two-row sheet created mid-morning.** It is almost certainly
incomplete as an inventory of this project's manual steps — the records already
carry others that are not in it, among them
[the Integration Notification Config record](items/OI-119%20The%20Anticipay%20error%20notification%20goes%20to%20a%20hardcoded%20ROMI%20address.md)
(a custom setting's record is data, not metadata, so it must be set by hand in
UAT and Prod), the
[edition mapping rows](items/OI-121%20The%20edition%20mapping%20table%20has%20no%20rows%20and%20no%20owner.md),
and the ticket-dispatch flow of
[OI-225](items/OI-225%20The%20ticket%20dispatch%20flow%20sends%20to%20a%20null%20recipient%20and%20fails%20the%20asset%20write.md),
which is org-side only and in no deploy.

🟢 **That it exists at all is the finding.** This is the first artifact on the
project that collects deploy-time manual configuration, nine days from the
production deploy. It is worth keeping and worth completing.

**No credentials, prices or personal data appear in the sheet.**
