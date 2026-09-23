---
id: OI-149
type: open-item
status: in-progress
owner: Anita Aga
org: ROMI
raised: 2026-09-21
updated: 2026-09-22
blocks: [OI-150]
source: notes/meetings/2026-09-21 Test Interni Pre-UAT.md
---

# OI-149 - Two Lead record types

Agreed at
[the 21/09 pre-UAT session](../meetings/2026-09-21%20Test%20Interni%20Pre-UAT.md)
(`00:06:24`): **two Lead record types, `diretta` and `standard`**, to simplify the
working path.

`diretta` exists because of leads arriving from live events (_diretta_) and from
HTML forms handled through Marketing Cloud — the problem Elena Spini raised at
`00:03:48`, with Fabrizio Mastracci supporting the form side.

## Build status

⚠ **Partially present.** `08b97cc` (Anita Aga, 21/09 18:24 CEST,
`DevAnitaRecheckAutomations`) adds a `Lead_Record_Page_Three_Column` flexipage
(+200 lines) and a `LeadConversionQueueable` class. **It is in PR #54, open,
against `DevMain`.**

2026-09-22: `force-app/` now adds the two Lead record types `Diretta` and
`Standard`. `Diretta` uses a dedicated Lead business process whose user-facing
open statuses are `New` and `Qualificato`; the process also includes the
converted status `Convertito`, because Salesforce `Database.convertLead` rejects
conversion when the target converted status is absent from the record type's
business process. `Standard` keeps the full current Lead status set. The change
passed a check-only Salesforce deploy (`0AfMA00000Cl1rN0AR`).

## Open

- 🔴 **Lead conversion breaks when an existing P.IVA is reused on the same
  account** (`01:19:19`) — discussed at the same session, unresolved. Conversion
  uses **custom trigger logic with deduplication**, not the standard component, so
  this is ROMI's own code path.
- ⚠ **`diretta` depends on the marketing forms**, and those are still owed:
  Sabatino Rinaldi committed on 18/09 to mail the indispensable Zoho form links and
  has not ([OI-14](OI-14%20Marketing%20forms%20and%20subdomain.md)).
- ⚠ **Lead UAT is 24 September**, the first session.
- ⚠ No register row covers the record types.
