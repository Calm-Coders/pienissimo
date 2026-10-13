---
id: OI-225
type: open-item
status: open
owner: Aurel Mrruku
with: Fabrizio Mastracci
org: ROMI
raised: 2026-10-09
updated: 2026-10-12
depends_on: [OI-197, OI-199]
blocks: [OI-81]
requirement: BIG-06
source: Salesforce flow error mail, 2026-10-09T05:53:21Z
---

# OI-225 - The ticket dispatch flow sends to a null recipient and fails the asset write

**A flow called `Automazione: Invio Biglietto assegnato Flow` ran, found no
ticket PDF, took the "PDF found" branch anyway, emailed the ticket to `null`,
and then failed updating the asset. It is the ticket send that the 16 October
Marketing UAT exists to test, and it is not in the repository.**

Source: a Salesforce flow error mail to Aurel Mrruku at **2026-10-09T05:53:21Z**,
unread at this watermark.

## The failure, step by step as the mail reports it

| Element | Result in the mail |
| ------- | ------------------ |
| `OTTIENI RECORD: Get Ticket PDF` (ContentVersion, newest first) | **`Impossibile trovare i record.`** |
| `DECISIONE: PDF Trovato` | **`Esito eseguito: Si_PDF`** |
| `CREA RECORD: Crea Public Link Biglietto` (ContentDistribution) | queued for creation |
| `OTTIENI RECORD: Get Public Link Biglietto` | **`Impossibile trovare i record.`** |
| `INVIA MESSAGGIO EMAIL: Invio Biglietto` | **`Invio Biglietto inviato/a a null`** |
| `AGGIORNA RECORD: Aggiorna Asset Ticket Sent` | **failed** — the reported error |

The interview also records **`$Record = null`** among the variables set at
start, and `Etichetta intervista: null`.

## 🔴 Three distinct defects, not one

1. **The decision does not test what the Get returned.** `Get Ticket PDF` found
   nothing and `PDF Trovato` still routed to `Si_PDF`. A decision whose
   no-records branch is unreachable is the root cause: everything downstream runs
   on an empty collection.
2. **The email went out to a null recipient.** The mail's own summary line is
   _"Invio Biglietto inviato/a a null da Giuliano Lanzetti in fase di
   esecuzione"_, with click and open tracking on and the `Marketing Emails`
   subscription. ⚠ **Whether a message actually left the org is not established
   from this mail** — Salesforce reports the element as executed. If it did, a
   ticket email with no ticket attached was sent; if it did not, the send is
   silently dropping. Either way it is the customer-facing send.
3. **The asset write-back failed**, so `ticket_sent` and its date were not set.
   That is the re-send guard
   ([OI-199](OI-199%20The%20ticket%20send%20flag%20fields%20are%20split%20across%20Asset%20and%20Order.md)):
   with it unset, the record stays eligible for the next run.

## 🔴 It is not in the repository

`force-app/main/default/flows/` is **empty** — the project has no flow metadata
under source control at all. This flow exists only in the org, so:

- It cannot be reviewed in a diff, and nothing in `force-app` explains the
  `Si_PDF` branch.
- It will not travel with a metadata deploy to Prod. Whatever carries it there
  is a manual step nobody has recorded — compare
  [the Manual Steps tracker](../Manual%20Steps%20Pienissimo%20tracker.md), which
  is the only artifact collecting work of that kind.

⚠ **This also qualifies
[OI-197](OI-197%20The%20ticket%20send%20flag%20and%20the%20Inviato%20asset%20state%20are%20agreed%20and%20unbuilt.md),
which records all five pieces of the send contract as unbuilt.** At least the
Salesforce-side send and the asset write-back **do exist**, org-side, and are
failing. OI-197's table was written from `force-app`, where they are genuinely
absent; the org disagrees with the repository, and on this row the org is ahead.

## ⚠ Which org this is, and why it matters

The mail says `Organizzazione: Pienissimo srl (00Dbl000005BSMH)` and links to
`ability-customization-52152.my.salesforce.com` — the **base My Domain host,
without the `--partial` sandbox suffix** — and, unlike the 08/10 Apex exception
mails, its subject is **not** prefixed `Sandbox:`.

🔴 **`00Dbl000005BSMH` appears nowhere else in the project records.** The partial
sandbox is `00DMA000004nMMr`. On this evidence the error is **not** from the
partial sandbox, and production is the natural reading — **but no project record
establishes the production org id, so the identification is `uncertain` and no
claim is made here.** A second mail of the same shape and the same org id
arrived **08/10 at 06:45:34Z** for a different flow
(`flow_701SW00000fouUCYAY_1791380294345`); the 08/10 sweep logged it without
identifying the org. **Somebody with org access should settle which org this is**
— if it is Prod, a customer-facing send is failing there twelve days before
go-live.

Run as **`Tech Romi` (`005SW00000PV5Ja`)**, start time reported as
`10/8/2026, 10:52 PM`, duration 8 seconds. Sender name and address on the email
element: **Giuliano Lanzetti**, `giulianolanzetti@mail.pienissimo.com` — an
org-wide or marketing sending identity; ⚠ that name is in no project record and
**no person note has been created for it**, because nothing establishes it is a
person rather than a configured sender.

## Why it is a go-live item

The **16 October Marketing UAT** is the session that tests the ticket flows, and
Elena Spini's 09/10 status post lists it as a next step. The 11-email plus
11-WhatsApp funnel
([OI-81](OI-81%20Event%20communication%20funnel.md)) is built on this send
working and on the flag it fails to write. The dispatch path is also the one
Fabrizio Mastracci specified on 05/10 in the marketing DM — assets `Assegnato`
with `Ready for Ticket Dispatch` true and `ticket_sent` false, the PDF taken from
the asset's attachments, then both flag fields moved.

**Nothing in this sweep fixed it; this procedure writes to the knowledge layer.**

## 🔑 2026-10-12 - the flow has a written description, and it supplies a candidate mechanism

Fabrizio Mastracci described both ticket-send flows as built in the marketing
group DM at **09:15:18 CEST** —
[the full text and what changed](../The%20marketing%20ticket%20send%20logics%20as%20written%20by%20Marketing.md).
His description of this one is four lines long and the second line is the
interesting one:

> _"Si attiva quando il biglietto passa ad 'Assegnato', è pronto per l'invio e non
> è ancora stato inviato. **Dopo 1 minuto** recupera il PDF del biglietto, crea un
> link pubblico e invia al partecipante l'email con il link per scaricarlo. Al
> termine marca il biglietto come inviato (con data e ora)."_

### 🔑 A fixed one-minute wait against an asynchronous render

The PDF this flow fetches is produced by the **platform-event subscriber behind
`ParticipantDocumentRequestTrigger`** — row 2 of
[the manual steps tracker](../Manual%20Steps%20Pienissimo%20tracker.md), which
exists because that subscriber's running user and batch size have to be set by
hand. A flow that waits a **fixed** minute and then queries for the output of an
asynchronous job is a race, and `Get Ticket PDF` reporting _"Impossibile trovare
i record"_ is what losing that race looks like.

⚠ **This is a candidate root cause, and it is not established.**

- Nobody has opened the flow. The one-minute wait is one person's description,
  not a read of the metadata — and there is no metadata to read, because
  `force-app/main/default/flows/` is still empty.
- A one-minute wait is only a race if the render can exceed a minute. **Nothing
  in this sweep measures how long it takes**, and if the subscriber is suspended
  or running as a user who cannot write the document, the wait is irrelevant and
  the document never arrives at all.
- It explains the **first** defect only. The decision still reporting `Si_PDF` on
  an empty collection, and the asset write-back failing, are separate faults in
  the same flow and are untouched by it.

🔑 Worth noting what it does explain: **why the failure is intermittent enough to
have gone unnoticed.** A race fails some of the time, which is consistent with
one error mail rather than a dead feature.

### Two things the description changes

1. **The ticket is sent as a public link, not as the Asset attachment.** The
   05/10 specification said the file comes from the Asset's attachments. ⚠ The
   same Asset carries
   [OI-194](OI-194%20The%20ticket%20is%20a%20signed%20participation%20document%20not%20just%20a%20QR%20code.md)'s
   seven-page signed participation document. A public link is a different
   exposure and nobody has assessed it.
2. **The `Inviato` stamp is described as working** — _"Al termine marca il
   biglietto come inviato (con data e ora)"_ — which is the write-back the error
   mail reports as **failed**. The description and the evidence disagree, and the
   evidence is one run.

### Still not established, third sweep

- 🔴 **Which org `00Dbl000005BSMH` is.** Unchanged: that id is in no record, the
  partial sandbox is `00DMA000004nMMr`, production is the natural reading and no
  claim is made. **It remains the most answerable thing on the unreachable list.**
- 🔴 **Whether a real participant received a ticketless email.** Needs the org.
- The error mail of 2026-10-09T05:53:21Z was **still unread** at this watermark,
  three days on.

⚠ The **16/10 Marketing UAT** that exists to test this send is four days away, and
the e2e UAT that would have exercised the order side of it
[was postponed on 12/10](../meetings/2026-10-12%20UAT%20Test%20e2e.md) to 14/10.
