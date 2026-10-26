---
id: ref-manual-steps-tracker
type: reference
status: active
owner: Rexhina Hysi
org: ROMI
raised: 2026-10-09
updated: 2026-10-26
source: Google Drive 1u-LgUKVlGK9ePyjMzZ_uJjXniHluo5_449siHgAIBHo
---

# Manual Steps Pienissimo tracker

**A new Google Sheet that collects the org configuration which no metadata
deploy carries — the post-deploy steps someone must click by hand. It carried two
rows on 09/10 and three from 12/10; `Status Prod` is blank on every one of
them.**

Created by **Rexhina Hysi** on **2026-10-09T09:21:27Z**, last modified
**09:37:30Z**, shared with Aurel Mrruku at 09:29:58Z (Drive notification mail,
same timestamp). Drive id `1u-LgUKVlGK9ePyjMzZ_uJjXniHluo5_449siHgAIBHo`.
One sheet, `Foglio1`, range `A1:C3` — a header and **two rows**.

## The shape

| Column        | Meaning                                     |
| ------------- | ------------------------------------------- |
| `Manual Step` | the click-path, written as Setup navigation |
| `Status Uat`  | `Done` on both rows                         |
| `Status Prod` | **empty on both rows**                      |

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

## 🆕 2026-10-12 - a third row, blank in both columns

The sheet moved to **`A1:C4`** at **2026-10-12T10:20:03Z**. The new row is the
first one **blank in `Status Uat` as well as `Status Prod`**:

3. **Run the scheduled jobs as the Pienissimo administrator.**
   Headed _"run all scheduled jobs as amministratore pienissimo"_, with Apex that
   aborts any existing `CronTrigger` for four job names and re-creates them —
   `MexalArticleSyncScheduler`, `MexalCustomerSyncScheduler`,
   `MexalInvoiceSyncScheduler` and `QuoteNegotiationAgingBatch`.

🔑 **Same class as row 2.** Scheduled Apex runs as **whoever scheduled it**; that
is not metadata and no deploy carries it. Row 2 pins the platform-event
subscriber's running user, row 3 pins the schedulers'. Between them they cover
every piece of asynchronous execution on this project.

🔴 **The urgency is now, not at deploy.** One of those four jobs was scheduled
today from a working session —
[OI-59](items/OI-59%20Quote%20workflow%20configuration.md) records
`QuoteNegotiationAgingBatch.scheduleDaily()` creating job `08eMA00000YU7OfYAL`,
`WAITING` on `0 0 3 * * ?`, **first run 2026-10-13 at 03:00 CEST**. Whose
identity it carries is not established here; the row exists because it is
usually the wrong one. Tracked as
[OI-228](items/OI-228%20The%20nightly%20schedulers%20have%20no%20run-as%20user%20and%20the%20first%20run%20is%20imminent.md).

⚠ **The 09/10 reading that two rows is not the full inventory holds**, and the
sheet is now growing in the right direction. `Status Prod` is **blank on all
three rows**, still with no owner and no date, **nine days from go-live**.
**No credentials, prices or personal data appear in the new row** — it carries
Apex and job names only.

## 2026-10-13 — a fourth row, and `Status Prod` is still empty on all of them

Modified **2026-10-13T09:29:13Z**. Range is now **`A1:C5`** — a header and
**four** rows.

| #   | Row                                                                       | `Status Uat` | `Status Prod` |
| --- | ------------------------------------------------------------------------- | ------------ | ------------- |
| 1   | Lead record-type settings                                                 | `Done`       | **empty**     |
| 2   | `ParticipantDocumentRequestTrigger` subscriber run-as user and batch size | `Done`       | **empty**     |
| 3   | **run all scheduled jobs as `amministratore pienissimo`**                 | **empty**    | **empty**     |
| 4   | 🆕 **remove unnecessary buttons from object list view**                   | `Done`       | **empty**     |

**Row 4** is the list-view button work: Change Owner, Import, Printable View and
Assign Label excluded through `searchLayouts.excludedStandardButtons` across the
15 objects in the LightningSales nav. 🟢 Unlike the other three it **is** partly
metadata — it was committed the same day as `9e97f46` — but it stays on this
sheet because Salesforce refuses several of the exclusions and because the repo
has no file for Campaign or Lead, so those exist only in UAT. See the developer's
`JOURNAL.md` entry of 13/10.

🔴 **Row 3 is unchanged and still the only row blank in `Status Uat` too** — and
the job it governs had its **first run at 03:00 CEST this morning**. See
[OI-228](items/OI-228%20The%20nightly%20schedulers%20have%20no%20run-as%20user%20and%20the%20first%20run%20is%20imminent.md).

⚠ **The pattern this sheet is establishing matters more than any single row.**
It has grown from two rows to four in four days, every new row arrives `Done` in
UAT, and **`Status Prod` has never been filled on any row since the sheet was
created on 09/10**. Nothing on it names an owner for the production column, and
go-live is **21/10**.

## 2026-10-16 — a fifth row, and `Status Prod` is still empty on every one

Modified **2026-10-16T09:29:19Z**. Range is now **`A1:C6`** — a header and
**five** rows.

| #   | Row                                                                           | `Status Uat` | `Status Prod` |
| --- | ----------------------------------------------------------------------------- | ------------ | ------------- |
| 1   | Lead record-type settings                                                     | `Done`       | **empty**     |
| 2   | `ParticipantDocumentRequestTrigger` subscriber run-as user and batch size     | `Done`       | **empty**     |
| 3   | run all scheduled jobs as `amministratore pienissimo`                         | **empty**    | **empty**     |
| 4   | remove unnecessary buttons from object list view                              | `Done`       | **empty**     |
| 5   | 🆕 **Add the default agent for Accounts and Orders created from WooCommerce** | `Done`       | **empty**     |

### Why the statuses look like this

This table is a transcription of the Google Sheet at
**2026-10-16T09:29:19Z**, not an independent assessment of either org:

- `Done` means the corresponding sheet cell literally contained `Done`.
- **empty** means the sheet cell was blank. It means **no completion was
  recorded in the tracker**; it does not by itself prove that nobody performed
  the step in the org.
- Rows 1 and 2 already had UAT `Done` on 09/10. Row 3 was added on 12/10 with
  both cells blank. Row 4 was added on 13/10 with UAT `Done`. Row 5 was added on
  16/10 with UAT `Done` and Prod blank.
- Therefore, a version showing both cells blank for row 5 is not the recorded
  16/10 snapshot. The preserved source trace states UAT `Done` and Prod empty.
  A different value would need a newer dated reading of the source sheet.
- All five Prod cells were blank in that snapshot, so none could be marked
  complete from the tracker alone.

**Row 5 is the configuration half of a build that landed the same morning.**
`4eadae8` (Anita Aga, 16/10 11:32 CEST, branch `DevAnita15`) adds
`Integration_Notification_Config__c.Default_Agent_Username__c`, and the value
that goes in it is a record of a custom setting — **data, not metadata**, so no
deploy carries it. Exactly the class of step this sheet exists for. See
[OI-214](items/OI-214%20The%20Mexal%20order%20send%20requires%20an%20agent%20code%20WooCommerce%20orders%20lack.md).

🔴 **This row is the first one on the sheet whose blank Prod cell is a hard
failure rather than a degraded one.** `WoocommerceOrderService.createAccount`
**throws** when the configuration is missing or incomplete, so once `4eadae8`
reaches production a WooCommerce order for a **new** customer fails outright
until someone fills this in. The order-side path falls back to Quote/Account
inheritance; the account-side path does not.

⚠ **The pattern is now eight days old and unbroken.** Two rows on 09/10, three
on 12/10, four on 13/10, five on 16/10; every new row arrives `Done` in UAT; and
**`Status Prod` has never been filled on any row since the sheet was created.**
Still no owner for the production column, still no date, and go-live is
**02/11** with Go/No-Go on **27/10**.

**No credentials, prices or personal data appear in the new row.**

## 2026-10-26

| Manual Step                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 | Status Uat | Status Prod |
| --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------- | ----------- |
| Setup → Feature Settings → Marketing → Lead Settings → Record Type Settings → Keep the existing record type                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 | Done       |             |
| Go to Setup → Event Studio.<br>Open the platform event used by ParticipantDocumentRequestTrigger.<br>Open Apex Trigger Details for the subscriber.<br>Click Edit.<br>Select the correct active Production user.<br>Keep Batch Size = 200 and save.<br>Go to Setup → Platform Events → [event] → Subscriptions.<br>Click Manage beside ParticipantDocumentRequestTrigger, then Suspend and Resume so the new configuration takes effect immediately.                                                                                                                                                                                                                                                                         | Done       |             |
| run all scheduled jobs as amministratore pienissimo <br>Set\<String> pienissimoJobNames = new Set\<String>{<br> MexalArticleSyncScheduler.JOB_NAME,<br> MexalCustomerSyncScheduler.JOB_NAME,<br> MexalInvoiceSyncScheduler.JOB_NAME,<br> QuoteNegotiationAgingBatch.JOB_NAME<br>};<br>for (CronTrigger existingJob : [<br> SELECT Id<br> FROM CronTrigger<br> WHERE CronJobDetail.Name IN :pienissimoJobNames<br>]) {<br> System.abortJob(existingJob.Id);<br>}<br>System.debug(MexalArticleSyncScheduler.scheduleNightly());<br>System.debug(MexalCustomerSyncScheduler.scheduleNightly());<br>System.debug(QuoteNegotiationAgingBatch.scheduleDaily());<br>System.debug(MexalInvoiceSyncScheduler.scheduleNightly());<br> |            |             |
| remove unecessary buttons from object list view                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             | Done       |             |
| Add the default agent for Accounts and Orders created from WooCommerce                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      | Done       |             |

&#x20;all this are nmanual steps to be done in prod should consider also that might need to add the page layouts to the agente profile i do not know if is retrieved this manual step write in a file under notes
