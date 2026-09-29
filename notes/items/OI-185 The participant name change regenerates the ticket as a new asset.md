---
id: OI-185
type: open-item
status: open
owner: Aurel Mrruku
with: Elena Spini
org: both
raised: 2026-09-25
updated: 2026-09-29
depends_on: [OI-74, OI-53]
blocks: [go-live]
severity: gating
source: notes/meetings/2026-09-25 Interna post UAT Contratto e Fase Due.md
---

# OI-185 - The participant name change regenerates the ticket as a new asset

**Specified in full at
[the 25/09 internal session](../meetings/2026-09-25%20Interna%20post%20UAT%20Contratto%20e%20Fase%20Due.md)
(`00:45:00`–`00:55:00`). Aurel Mrruku: _"Io non ce l'ho pronta questa roba."_
The ticket UAT is Wednesday 30 September.**

[OI-74](OI-74%20Asset%20state%20machine.md) already records the register's transition
`Assegnato → Annullato` on _"name change (option 1) or credit note"_. **This row is
option 1 made concrete** — and it turns out to be more than a status change.

## The agreed mechanism

1. A **dedicated button on the Account**, not on the Asset. Elena Spini:
   _"Dal button vedo tutti i biglietti per quell'account. Scelgo chi deve essere
   annullato e chi inserire di nuovo."_ Aurel Mrruku confirmed the placement —
   the Account page is where the Assets are — and warned of the cost: **an account
   carries every ticket it has ever held, past events included.**
2. 🔑 **The existing Asset is never updated.** For historical traceability the
   original is set to **`Annullato`** and a **new Asset with a new QR code** is
   generated. Elena Spini, verbatim: _"Per preservare la tracciabilità storica non
   viene aggiornato l'asset esistente, viene generato un nuovo asset con un nuovo
   QR code, mentre l'asset originale viene annullato."_
3. A **new Contact is created if the person is not in the CRM**, and the
   **Campaign Member** records are updated.
4. On confirmation, a **mail goes out with the new QR code**.

## 🔴 The send is the unsolved half

The QR mail is sent by **marketing**, off the campaign, at participant
confirmation — not by Salesforce. That produces two problems neither person solved:

- 🔴 **Marketing cannot tell which ticket is the new one**, so the re-send has to go
  out for **every ticket on that account**. Aurel Mrruku: _"si deve rimandare tutto,
  quindi farà di invio di nuovo a tutti i biglietti per quell'account perché lui non
  avrà modo di distinguere qual è il nuovo."_ Asked whether he liked it, Elena Spini
  said no; Aurel Mrruku: _"Eh, ma anche a me però il processo funziona così."_
- 🔴 **The "already processed" flag has to be reset to `false`** so the account
  re-enters the campaign filter, otherwise the reminder logic skips it. Both agreed
  it is feasible; **nothing records who builds it or against which campaign filter.**

⚠ Elena Spini asked whether the mail could simply be sent from Salesforce instead.
Aurel Mrruku said it could — _"non è un problema"_ — but that it would diverge from
the 60/30-day sends which already go through the marketing club. **Left open.**

## What was cut out of it

The blueprint text extended the mechanism to the **day of the event**. Aurel Mrruku
refused that scope and Elena Spini confirmed the client had already said no: on the
day they **let the person in regardless** and the desk handles it by hand. The
check-in app that would have covered it is **Fase 2**.

## Open

- 🔴 **It is not built and the ticket UAT is 30/09.** Aurel Mrruku will attempt it
  on Sunday 27/09 and expects to demonstrate something partial: _"anche se forse non
  funziona al 100%"_. He cannot work Saturday.
- 🔴 **Decide the send.** Salesforce or marketing, and if marketing, accept that
  every ticket on the account is re-sent.
- 🔴 **Name the flag and the campaign filter** that the reset has to touch.
- ⚠ **The Account-level list has no filter.** Every past event's tickets appear;
  nothing records a date or status filter being agreed.
- ⚠ No register row covers the regeneration. `BIG-17` carries the Asset state
  machine, not this procedure — **not for a sweep to allocate.**

## 2026-09-28 - QR generation was built; the name-change regeneration was not

Aurel Mrruku's _"Io non ce l'ho pronta questa roba"_ of 25/09 stands, with one part
of the stack now in place. Ticket UAT is **Wednesday 30/09**, two days out.

🟢 **QR generation exists on `DevMain`.** Rexhina Hysi — the owner this gained on
25/09 — committed it on 28/09 morning:

- **`e887b15`** (09:41 CEST) and **`b40db42`** (10:12 CEST): **`AssetQrService.cls`**,
  **`BarcodeGenerator.cls`** (796 lines, with a vendored `Portwood-DocGen` licence
  added under `docs/third-party/`), **`TicketQrImage.cls`**, a QR section on the
  Asset layout, and edits to `ParticipantRegistrationController.cls` and
  `QuoteAcceptanceEmailController.cls`.
- Reached `DevMain` at `55101d2` through PR
  [#63](https://github.com/Calm-Coders/pienissimo/pull/63) (`DEV_fixController`,
  merged 16:30 CEST, one conflict resolved in `fb3ae13`).

🔴 **None of that is this item.** What this note records is the **cambio nominativo
flow**: an Account-level button that cancels the existing ticket, creates a **new
Asset with a new QR code**, and re-sends **every ticket on the account** because
marketing cannot tell which one is new. **Nothing in this window implements a name
change, a cancellation, or a re-send.** Verified against the 28/09 commits.

🟢 **What the QR work does change:** the regeneration now has something to
regenerate. `AssetQrService` and `TicketQrImage` are the pieces a new-asset flow
would call, so the remaining work is the trigger, the cancellation of the
predecessor, and the bulk re-send — not the barcode.

⚠ **Nothing was run.** This is a reading of the source at `DevMain` `55101d2`; no
QR was generated in an org during this sweep, and no test was written, proposed or
scaffolded.

## 🟢🔑 2026-09-29 — the document stack was built, the guest-user bug was found and fixed, and none of it is on `DevMain`

**The failure came first.** A sandbox error mail at **11:20:13Z**:
`ParticipantTicketDocumentJob for job ID 707MA00000lAnQi: No participant documents
were generated. 02iMA000009ynrtYAA rendered 789 bytes; 02iMA000009ynruYAA rendered
789 bytes` — two Assets producing 789-byte renders, i.e. an error page rather than a
PDF.

🟢 **Diagnosed and rebuilt the same afternoon.** From the `JOURNAL.md` entry in
`1e1ab6d` (Aurel Mrruku, 17:00 CEST): the job ran **as the site guest user, which
cannot render `ParticipantTicketPdf`**. The fix rebuilds it as a platform event
`Participant_Document_Request__e` handled by an **internal** run-as user, one
document per job chained by a finalizer, with public guest access to the page
closed. Evidence claimed in that entry: UAT deploy `0AfMA00000CoORd0AN` (12/12
components), `ParticipantTicketDocumentTest` 12/12, and a live run of **10 test
Assets → 10 Completed jobs → 10 PDFs of 1.31 MB each in ~13 s**.

New metadata across `e2bdb1f`, `1e1ab6d` and `963e582`:
`ParticipantTicketPdfController.cls`, `ParticipantTicketPdf.page`,
`ParticipantTicketDocumentJob.cls`, `ParticipantTicketDocumentRequests.cls`,
`Participant_Document_Request__e` with `Asset_Id__c`,
`ParticipantDocumentRequestTrigger`, a `platformEventSubscriberConfig`, the
`Participant_Document_Generation` permission set, `Asset_Ticket_Record_Page` and an
`Asset` pathAssistant.

🔴 **`e2bdb1f`, `1e1ab6d` and `963e582` are all on `DevMain_exposeEndpoint`, which
still has no PR.** `DevMain` at `4c9b121` carries none of it, the night before the
30/09 ticket UAT. `TicketQrLookupService.cls` has been stranded on the same branch
since 28/09.

🔴 **What this work did *not* touch is this row's subject.** The cambio nominativo —
cancel the old asset, mint a new one with a new QR, re-send — is still unbuilt.
Nothing in any 29/09 commit addresses it.

⚠ **Two blockers named by the author and unresolved:**
- **No production run-as user has been chosen**, and the subscriber config file must
  carry a Prod username before this can ship.
- **`TicketingTest`'s four WooCommerce tests fail in UAT** on the Opportunity record
  type in `TestDataFactory.opportunity` — that is `TestDataFactory.cls:257`,
  `opportunity(accountId, 'Standart')`, flagged on 28/09 as a risk and now **confirmed
  failing**. Recorded for whoever takes the test-suite task; **no test was written or
  proposed here.**

⚠ Six failed jobs from a rejected attempt (Integration User as run-as user — its
licence cannot have Visualforce page access) remain in Apex Jobs at 14:02Z.

🔑 The document these PDFs render is larger than this row assumed — see
[OI-194](OI-194%20The%20ticket%20is%20a%20signed%20participation%20document%20not%20just%20a%20QR%20code.md).
