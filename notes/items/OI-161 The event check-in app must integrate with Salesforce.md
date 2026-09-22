---
id: OI-161
type: open-item
status: open
owner: Aurel Mrruku
with: Andrea Parmeggiani
org: both
raised: 2026-09-22
updated: 2026-09-22
depends_on: [OI-74]
blocks: [go-live]
severity: gating
source: notes/meetings/2026-09-22 Temi QR Code Biglietti.md
---

# OI-161 - The event check-in app must integrate with Salesforce

**Established at
[Temi QR Code Biglietti](../meetings/2026-09-22%20Temi%20QR%20Code%20Biglietti.md),
22/09 10:32 CEST. An integration the record did not contain.**

Everything held about QR codes concerns **generating** them. Nothing established
what **reads** them. Pienissimo runs a **custom Android application** — not a Zoho
product, built against Zoho over REST, distributed via TestFlight and APK packages
on Drive, refreshed about every ninety days — and it is the thing that scans a
ticket at the door.

⚠ Elena Spini, the same afternoon: **_"di questa app non ne hanno mai parlato"_**,
and she had read "QR code done" as including the scan and the asset update. See
[the internal update](../meetings/2026-09-22%20Update%20Interno%20Aurel%20Elena.md).

## Agreed scope for Fase 1

1. The app makes a **REST call to Salesforce** and the asset moves to
   **`utilizzato`**; a failure returns a customisable error code and message.
2. **Validity is checked against the child campaign's start and end dates** before
   the asset is updated, so a code for another event or edition is rejected.
3. **One check-in for the whole event**, not per day. Reference case:
   **Pienissimo Live, 24–26 November**.
4. The **campaign member state follows from the asset**, by formula — Aurel Mrruku
   explicitly refused to build a second write path for it.

## Open

- 🔴 **Andrea Parmeggiani owes credentials, an endpoint and the payload definition**
  for the app side.
- 🔴 **Aurel Mrruku owes payload examples and a Postman collection**, committed for
  the end of week 22–26/09.
- 🔴 **Nothing is built.** The asset state machine
  ([OI-74](OI-74%20Asset%20state%20machine.md)) has the `utilizzato` state; no inbound
  endpoint exists.
- 🔴 **Pre- and post-event testing breaks the date filter.** The agreed workaround is
  to move the campaign dates or issue filter-free test codes — neither is specified.
- ⚠ **No requirement covers this integration.** It is new scope surfaced three days
  before ticket UAT on 30 September, and **allocating a requirement id is a human's
  call.**
- ⚠ The app also draws ticket allocation down from a **company giacenza** by event,
  edition and ticket type. Whether Salesforce owns that allocation is unestablished.
