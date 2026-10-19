---
id: OI-254
type: open-item
status: open
owner: Aurel Mrruku
with: Fabrizio Paganelli
org: both
raised: 2026-10-16
updated: 2026-10-16
blocks: [go-live]
source: Gmail 1a1454177ff30250, 2026-10-16T15:07:59Z
---

# OI-254 - Creating a Referente and an Account failed for the client

**Fabrizio Paganelli mailed ROMI on 16 October to say that creating a Referente
and an Account had gone wrong, attached four screenshots, and deferred the
detail to a call. What the problem is, is not in the mail — and the client's own
key-user test window opens on 19 October.**

## The mail

**2026-10-16 15:07:59Z**, subject _"Referente e Account"_, from
`fabrizio.p@pienissimo.com` to Aurel Mrruku and Elena Spini,
cc `amministrazione@pienissimo.com`. The body is four lines:

> _"Abbiamo provato a creare Referente e Account._
>
> _Abbiamo avuto qualche problema_
>
> _Vi lascio sotto gli screen, poi magari vi dico in call i dettagli_
>
> _Ciao, Fabrizio"_

Four PNG attachments (`image001.png`–`image004.png`), inline, the first captioned
_"Referente"_ in the body text.

⚠ **The screenshots were not opened by this sweep.** They are inline images in a
client mail about record creation and may carry customer data; the mail is
recorded, the contents are not. **Reading them is the first step for whoever
picks this up**, and it is the only place the actual error text exists.

## What makes it a row rather than a note

- 🔴 **It is the client attempting the build unaided, and failing.** Every prior
  demonstration of Account and contact creation was driven by ROMI, in session.
  This is the first recorded attempt by the client on its own, and it did not
  work.
- 🔴 **The timing.** The key-user test week runs **19–23 October**, the
  _"Test UAT Commerciali"_ session with Marco Montesi is **Monday 19/10 15:00**
  ([OI-240](OI-240%20Marco%20Montesi%20needs%20a%20Salesforce%20user%20before%20go-live.md)),
  and Go/No-Go is **27/10**. An unexplained failure in creating the two records
  the commercial flow starts from blocks that test.
- ⚠ **`Referente` is the client's word, and it maps to more than one thing in
  this build.** It is used in the ticket flow for the person who nominates
  participants, and in the commercial flow for an Account's contact person.
  **Which is meant is not established** — the mail's own caption says
  _"Referente"_ above the first screenshot and nothing more.

## 🔑 A possible connection, recorded as a lead and not as a finding

Two things touching contact creation moved on the same day:

1. **`05cdd3b`** (Rexhina Hysi, 16/10 14:50 CEST, branch `Devmain_LeadFix`) —
   _"Lead_Email__c and chage duplicate rule"_ — rewrites Lead/Contact
   duplicate-rule metadata and the conversion Apex, and its own notes record a
   reproduced failure in which **duplicate alerts block Contact creation**.
2. **[OI-256](OI-256%20A%20test%20contact%20phone%20number%20did%20not%20reach%20the%20CRM.md)**
   — a contact's phone number silently absent in the 16/10 UAT, explained in the
   room as an existing contact being reused.

⚠ **Whether any of this is the same problem is unknown.** The mail gives no
error text, the commit is not on `DevMain`, and the environments may differ —
the client works in UAT, the commit deployed to a partial sandbox. **Stated as a
lead for the person who opens the screenshots**, not as a diagnosis.

## Open

- 🔴 **Nobody has replied.** No answer in Gmail or Slack by the close of
  16 October, and the mail proposes a call that is not booked.
- 🔴 **The error is unidentified**, and therefore so is the environment, the
  object and whether it reproduces.

## What closing it looks like

The screenshots are read, the failure is reproduced or explained, and the client
is told — before 19 October — whether it can create these records in the
key-user test.
