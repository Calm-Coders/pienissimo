---
id: OI-149
type: open-item
status: in-progress
owner: Anita Aga
org: ROMI
raised: 2026-09-21
updated: 2026-09-21
blocks: [OI-150]
source: notes/meetings/2026-09-21 Test Interni Pre-UAT.md
---

# OI-149 - Two Lead record types

Agreed at
[the 21/09 pre-UAT session](../meetings/2026-09-21%20Test%20Interni%20Pre-UAT.md)
(`00:06:24`): **two Lead record types, `diretta` and `standard`**, to simplify the
working path.

`diretta` exists because of leads arriving from live events (*diretta*) and from
HTML forms handled through Marketing Cloud — the problem Elena Spini raised at
`00:03:48`, with Fabrizio Mastracci supporting the form side.

## Build status

⚠ **Partially present.** `08b97cc` (Anita Aga, 21/09 18:24 CEST,
`DevAnitaRecheckAutomations`) adds a `Lead_Record_Page_Three_Column` flexipage
(+200 lines) and a `LeadConversionQueueable` class. **It is in PR #54, open,
against `DevMain`.** No Lead record-type metadata is in `force-app/` yet.

## Open

- 🔴 **The record types themselves are not in source.**
- 🔴 **Lead conversion breaks when an existing P.IVA is reused on the same
  account** (`01:19:19`) — discussed at the same session, unresolved. Conversion
  uses **custom trigger logic with deduplication**, not the standard component, so
  this is ROMI's own code path.
- ⚠ **`diretta` depends on the marketing forms**, and those are still owed:
  Sabatino Rinaldi committed on 18/09 to mail the indispensable Zoho form links and
  has not ([OI-14](OI-14%20Marketing%20forms%20and%20subdomain.md)).
- ⚠ **Lead UAT is 24 September**, the first session.
- ⚠ No register row covers the record types.
