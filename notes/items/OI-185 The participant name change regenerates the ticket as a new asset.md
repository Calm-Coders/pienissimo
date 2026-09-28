---
id: OI-185
type: open-item
status: open
owner: Aurel Mrruku
with: Elena Spini
org: both
raised: 2026-09-25
updated: 2026-09-25
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
