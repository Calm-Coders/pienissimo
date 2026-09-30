---
id: flow-participant-document-pdfs
type: flow
status: in-progress
owner: Aurel Mrruku
org: ROMI
raised: 2026-09-29
updated: 2026-09-29
depends_on: [ticket-qr-code-generation]
source: Claude session 2026-09-29, UAT inspection, deploy 0AfMA00000CoORd0AN and live test
uncertain: Not yet deployed to Prod; the Prod run-as user is not chosen.
---

# Participant document PDFs are rendered by an internal user

When a participant registers on the landing page, each ticket Asset gets a
10-page "Documenti partecipazione" PDF, rendered from the Visualforce page
`ParticipantTicketPdf` and filed on the Asset. The registration runs as the
**site guest user**, and the guest user cannot render that page, so the
rendering is handed to an internal user through a platform event.

## Why not the guest user

Verified in UAT on 2026-09-29:

- A job queued from the registration runs as the guest user. From that job,
  `getContentAsPDF()` never ran the page's controller; it returned a
  789-byte PDF of an access page. That was true both through the public site
  address and with `Page.ParticipantTicketPdf` inside the org.
- The same Assets rendered correctly when an internal user ran the job.
- Guest access to the page also exposed participant name, email, phone and
  company to anyone with an Asset Id on the public site. It is now removed
  (see Permissions).

## The flow

1. `CampaignMemberQrTrigger` → `AssetQrService` sets the QR, files the QR
   image, then publishes one `Participant_Document_Request__e` per Asset
   (publish after commit) via `ParticipantTicketDocumentRequests`.
2. `ParticipantDocumentRequestTrigger` runs as the user named in
   `ParticipantDocumentRequestTriggerConfig` and queues
   `ParticipantTicketDocumentJob`.
3. The job renders **one Asset per job**. A Transaction Finalizer queues the
   next job with the rest, whether the job succeeded or failed.

One document is about 1.3-1.4 MB (ten full-page background images). Ten in
one transaction would exceed the 12 MB asynchronous heap, which is why each
job renders a single Asset.

The job skips an Asset that already has a document. It checks through
`ContentDocumentLink`, because a `ContentVersion` query only returns files the
running user owns.

## Limits to know

- Salesforce lets a finalizer re-queue after a failed job only **5 times in a
  row**. A systemic failure, such as the run-as user losing access, stops
  after 6 jobs. Isolated failures between successes do not stop the chain.
- A changed run-as user in the subscriber config only takes effect when the
  subscription restarts: suspend and resume it in Setup, or redeploy the
  trigger Inactive then Active.

## Run-as user

- **UAT:** Aurel Mrruku (Aurel's choice, 2026-09-29).
- **The Integration User cannot do it.** Its Salesforce Integration license
  does not allow Visualforce page access. Tested: the permission set could not
  be assigned, and the job failed with "insufficient privileges to access
  controller ParticipantTicketPdfController".
- **Automated Process**, the default for event triggers, fails the same way.
- **Prod:** not chosen. The config file carries a username, so it must be
  changed for Prod before deploying.

## Permissions

- Permission set `Participant_Document_Generation`: page
  `ParticipantTicketPdf` and the three classes. Assign it to the run-as user.
  A System Administrator does not strictly need it.
- `Landing Page Profile` (guest): access to `ParticipantTicketPdf`,
  `ParticipantTicketPdfController` and `ParticipantTicketDocumentJob` removed.
  The controller also refuses guest users itself.

## Evidence

- UAT deploy `0AfMA00000CoORd0AN`, 2026-09-29: 12/12 components,
  `ParticipantTicketDocumentTest` 12/12. Coverage 84-100% on every changed
  class.
- Live test, 2026-09-29 14:06Z: requests for 10 test Assets produced 10
  chained jobs, all Completed, run as Aurel Mrruku. They filed 10 PDFs of
  1.31 MB each in about 13 seconds; one opened as 10 A4 pages.

Related: [Ticket QR code generation](../Ticket%20QR%20code%20generation.md).
