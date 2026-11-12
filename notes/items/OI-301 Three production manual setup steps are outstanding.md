---
id: OI-301
type: open-item
status: open
owner: Aurel Mrruku
with: Rexhina Hysi
org: ROMI
raised: 2026-10-29
updated: 2026-11-12
depends_on: [OI-267]
blocks: [go-live]
source: Google Drive 1u-LgUKVlGK9ePyjMzZ_uJjXniHluo5_449siHgAIBHo
---

# OI-301 - Three production manual setup steps are outstanding

**ROMI keeps a checklist of the Salesforce setup steps that no deployment can
carry, with a column for UAT and one for production. It was touched on the same
day the release reached production, and three of its five steps are unticked for
production — one of them unticked for both.**

## The artifact

`Manual Steps Pienissimo`, Google Sheet
`1u-LgUKVlGK9ePyjMzZ_uJjXniHluo5_449siHgAIBHo`, owner `r.hysi@romicompany.com`,
**1,024 bytes**, last modified **2026-10-29 15:06:07Z**. Sheet `Foglio1`, range
`A1:C6`: one `Manual Step` column, then `Status Uat` and `Status Prod`.

🔑 **It is new to these records.** No earlier note or trace mentions it, and it was
shared with this mailbox on 2026-10-09.

## The five steps as the sheet records them

| # | Step | UAT | Prod |
| - | ---- | --- | ---- |
| 1 | Setup → Feature Settings → Marketing → Lead Settings → Record Type Settings → keep the existing record type | Done | done |
| 2 | Event Studio: open the platform event used by `ParticipantDocumentRequestTrigger`, set the correct active Production user on the subscriber, keep Batch Size 200, then Suspend and Resume the subscription so it takes effect | Done | 🔴 **blank** |
| 3 | Run all scheduled jobs as _amministratore pienissimo_ — abort and reschedule `MexalArticleSyncScheduler`, `MexalCustomerSyncScheduler`, `MexalInvoiceSyncScheduler` and `QuoteNegotiationAgingBatch` | 🔴 **blank** | 🔴 **blank** |
| 4 | Remove unnecessary buttons from object list views | Done | Done |
| 5 | Add the default agent for Accounts and Orders created from WooCommerce | Done | 🔴 **blank** |

## What each gap means

- **Step 3 is corroborated from outside the sheet.** A production inspection the
  same day found **no Mexal nightly job scheduled in Prod**, and
  [OI-267](OI-267%20Loading%20historical%20orders%20would%20push%20them%20to%20Mexal%20and%20generate%20tickets.md)
  carries _"scheduling the Prod nightly jobs"_ as explicitly still open. 🔑 So two
  independent sources agree the nightly jobs are not running in production — on an
  org that now reaches Mexal for real.
- **Step 2 sits on the ticket-document path.** `ParticipantDocumentRequestTrigger`
  is what produces the participant document; the subscriber runs as a named user,
  and in production that user has not been set. ⚠ **Whether this is the same fault
  as [OI-289](OI-289%20The%20production%20ticket%20dispatch%20flow%20references%20a%20field%20that%20does%20not%20exist.md)
  is not established** — OI-289's flow fails on a missing `Asset.QR_Id__c` field,
  but the same interview's `Get Ticket PDF` lookup over `ContentVersion` also
  returned no records, which is what an unconfigured document subscriber would
  produce. **Two faults on one path, possibly one cause; nothing here proves it.**
- **Step 5 is the WooCommerce default agent**, done in UAT and not in production.
  [OI-298](OI-298%20WooCommerce%20bundle%20orders%20from%20a%20new%20customer%20do%20not%20reach%20Salesforce.md)
  is a WooCommerce order failing in the **UAT** sandbox, so this gap is **not its
  cause** — but it is the same path left unfinished in the org that goes live.

## What this note does not claim

⚠ **A blank cell means the step is not marked done, not that it is proven undone.**
The sheet is ROMI's own checklist, maintained by hand; the org was **not opened in
this run**. Steps could have been performed and not ticked, and the sheet's
15:06:07Z edit is not attributed to any particular row.

⚠ **Step 3 includes `QuoteNegotiationAgingBatch`**, the job the standing deployment
authorization asks to be cancelled before validation and restored afterwards.
**Nothing in this sheet establishes whether it was restored** — a blank cell is
not evidence either way, and this note makes no claim about it.

## 🔑 2026-11-12 - the tracker moved, and two more steps surfaced

[The Manual Steps tracker](../Manual%20Steps%20Pienissimo%20tracker.md)
(`1u-LgUKVlGK9ePyjMzZ_uJjXniHluo5_449siHgAIBHo`) was modified **2026-11-12
16:50:30Z**. It now holds five rows, all `Done` in UAT.

| Step | Prod |
| --- | --- |
| Lead Settings → keep the existing record type | 🟢 done |
| Event Studio → the `ParticipantDocumentRequestTrigger` subscriber run-as user, batch 200, suspend and resume | 🟢 done |
| **Run all scheduled jobs as amministratore pienissimo** | 🔴 _"**QuoteNegotiationAgingBatch -> only this is done the others should be done by Aurel**"_ |
| Remove unnecessary buttons from object list views | 🟢 done |
| Add the default agent for Accounts and Orders created from WooCommerce | 🟢 marked done |

### 🔴 The scheduled jobs are still not scheduled

Three of the four jobs in the tracker's own script are **not** running in
production: `MexalArticleSyncScheduler`, `MexalCustomerSyncScheduler` and
`MexalInvoiceSyncScheduler`. Only `QuoteNegotiationAgingBatch` is. This is the same
gap [OI-334](OI-334%20The%20Mexal%20sync%20frequency%20is%20undecided%20and%20no%20job%20is%20scheduled%20in%20production.md)
carries, now confirmed in ROMI's own tracker and **named as Aurel Mrruku's**, four
days before the users start.

### 🔴 The WooCommerce default agent was marked done and was not

The row reads `done`, yet the client's first production WooCommerce order on 11/11
was rejected with _"**Configure Default Agent Username on the WooCommerce
Integration Notification Config record** with an active user who has an agent code
and customer commission category"_. Aurel Mrruku fixed it in eight minutes →
[OI-354](OI-354%20WooCommerce%20is%20connected%20to%20production%20by%20the%20client.md).
⚠ **The tracker's `done` was not reliable.**

### 🆕🔴 There is no logo in production

Found on the [12/11 internal call](../meetings/2026-11-12%20INTERNA%20Modifiche%20Marco.md).
Elena Spini: _"non c'e logo sulla produzione"_. Aurel Mrruku: _"ovviamente non c'e …
l'avevamo gia, **era nei manual step da fare**"_. ⚠ **It is not a row in the tracker
at all**, and it is the first thing the client's users will see on Monday.

### 🆕 Also surfaced, not in the tracker

- 🔴 **Four Edizione date fields existed in production but were not on the layout** —
  `Data fine evento`, `Data inizio evento`, `Data invio biglietto`, `Data evento`.
  Aurel Mrruku added them **directly in production** during the 12/11 client call.
- 🟢 The old `Romi Company` system admin can be deactivated once its record
  ownership is cleared (guest-user default owner) —
  [OI-356](OI-356%20The%20definitive%20list%20of%20production%20users%20is%20still%20incomplete.md).
