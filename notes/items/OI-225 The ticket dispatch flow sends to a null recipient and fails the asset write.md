---
id: OI-225
type: open-item
status: open
owner: Aurel Mrruku
with: Fabrizio Mastracci
org: ROMI
raised: 2026-10-09
updated: 2026-10-09
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
