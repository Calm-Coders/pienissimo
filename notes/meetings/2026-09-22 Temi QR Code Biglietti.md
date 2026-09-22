---
id: meeting-2026-09-22-temi-qr-code-biglietti
type: meeting
status: resolved
owner: Aurel Mrruku
org: both
raised: 2026-09-22
updated: 2026-09-22
source: Drive Gemini notes + transcript doc 1hs6yAKq9kZYBkZuRKDEwLedjqY3uvJpHILYIWvMs9kI (notes read in full)
---

# 2026-09-22 Temi QR Code Biglietti

**Client session, ~49m, 22/09 10:32 CEST.** Aurel Mrruku, Elena Spini,
**Andrea Parmeggiani** (`andrea.p@pienissimo.pro`), Elisa Migliano, Fabrizio
Paganelli. Booked the previous afternoon at short notice.

🔑 **A whole integration surfaced that the record did not contain: the event
check-in application.** Everything in this record about QR codes concerns
*generating* them. Nobody had established what *reads* them.

## What exists on the client side

- A **custom Android application**, not a Zoho product, that talks to Zoho over
  **REST**. Distributed through TestFlight and APK packages on Google Drive, with
  **refreshes roughly every ninety days**.
- It holds a dropdown of **events, editions and ticket types** (free or paid) so
  attendance draws down the correct company allocation.
- It has an **Infopoint** section, used by Andrea Parmeggiani and Elisa Migliano to
  search or hand-enter contacts and their companies, recording a presence as a
  manual movement equivalent to a scan.

## Agreed

1. 🟢 **The app calls a Salesforce REST endpoint to set the asset to `utilizzato`**
   on a successful scan, and receives a customisable error code and message
   otherwise. Aurel Mrruku will supply the endpoint; Andrea Parmeggiani owes
   credentials and the payload definition from the app side.
2. 🟢 **Validity is checked against the child campaign's start and end dates**
   (the *edizioni*), before the asset is updated — Andrea Parmeggiani's problem was
   attendees arriving with a QR code for a different event or edition. Pre- and
   post-event testing is handled by moving the campaign dates or by filter-free
   test codes.
3. 🟢 **One check-in for the whole event**, not one per day, for multi-day events.
   The next event, **Pienissimo Live, 24–26 November**, is the reference case.
4. 🟢 **Infopoint integration is deferred to Fase 2** — Elena Spini and Elisa
   Migliano both, because UAT and the Fase 1 release come first.
   → [OI-162](../items/OI-162%20Infopoint%20and%20orphan%20tickets%20are%20deferred%20to%20Fase%202.md)

## Why Infopoint is not a small ask

🔴 Aurel Mrruku's objection is structural: Salesforce ties **contact → order →
asset → campaign member**, and **a ticket created with no order is an orphan record
that corrupts the statistics.** Infopoint does exactly that — it registers
walk-ins, wrong-data attendees and people not in the database at all (restaurant
staff who change constantly), which means using Salesforce as a bare registry.

Four endpoints would be needed: **contact search and insert, company search,
campaign search, ticket search and create**. Contact search must be **generic, not
scoped to the event id**, precisely because the person may have no registration.
The cases to handle: existing ticket, existing contact without a ticket, and a new
contact with an orphan (or negative) ticket.

⚠ **Elena Spini and Elisa Migliano both said the Infopoint screen was new relative
to the flows previously agreed.**

## Adjacent facts

- **Last-minute and on-site payments** (cash, a copy of the transfer) produce
  orders whose ticket does not exist yet, or attendance with no order at all.
  Andrea Parmeggiani's priority is recording presence in real time and leaving the
  administrative fix to the next day.
- **Name changes happen before the event** — a new mail is sent and the old QR code
  is voided; walk-ins are handled at the desk.
- Elisa Migliano asked for a **post-event report** listing tickets created without
  an order or contract, for manual clean-up. Aurel Mrruku confirmed it is feasible
  provided the app sends the data.
- Aurel Mrruku committed to send **payload examples and a Postman collection to
  Andrea Parmeggiani by the end of the week**.
  → [OI-161](../items/OI-161%20The%20event%20check-in%20app%20must%20integrate%20with%20Salesforce.md)

## ⚠ How this got missed

Named by Elena Spini in
[the internal update three hours later](2026-09-22%20Update%20Interno%20Aurel%20Elena.md):

> _"sul tema QR Code non mi spiego neanch'io come abbiamo fatto ad arrivare così,
> perché c'è stata un'incomprensione totale nostra… quando tu mi hai detto 'QR code
> fatto', per me era fatto"_ — she had taken code generation to include scanning
> and asset update — **_"non toglie il fatto che di questa app non ne hanno mai
> parlato."_**

Scope was cut the same day: Aurel Mrruku will implement **the asset update only**,
with the campaign member state following from the asset, and not the four or five
flows Infopoint implies.
