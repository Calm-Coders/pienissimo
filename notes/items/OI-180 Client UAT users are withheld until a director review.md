---
id: OI-180
type: open-item
status: open
owner: Elena Spini
with: Daniela Morgese
org: both
raised: 2026-09-24
updated: 2026-09-24
depends_on: [OI-153]
blocks: [go-live]
severity: gating
source: notes/meetings/2026-09-24 UAT Lead e Opportunita.md
---

# OI-180 - Client UAT users are withheld until a director review

**UAT opened on 24 September and the client cannot log in.**

At `01:01:13` Elena Spini said the logins would be distributed once the test environment
was stable enough, after the main development finished. At `02:04:26` Sabatino Rinaldi
asked to go in and look around on his own; Elena Spini and Aurel Mrruku asked him to
wait until the data fixes and tests were done — **indicatively 6 October**.

The session's own action item is explicit:

> _"\[Gromi\] Rilasciare credenziali accesso: Fornire le utenze blindate per operare
> nell ambiente di test una volta completata la revisione da parte di Daniela."_

and, from Fabrizio Paganelli's proposal:

> _"Mostrare il prodotto completato a Daniela dopo la fase di rifinitura. Attendere la
> conferma di Daniela prima di procedere con ulteriori accessi."_

## Why it matters

- 🔴 **The UAT window is 24 September – 6 October, with approval due 13 October.** If
  logins arrive when the window closes, the client has tested nothing themselves: they
  have watched ROMI drive a screen share.
- The remaining sessions — Preventivi 25/09, Biglietti/Campagne/Eventi 30/09, Flussi MKT
  02/10, Performance Plus 05/10, Mexal 06/10 — all fall inside the period when nobody
  client-side can log in.
- **Daniela Morgese is a gate that the calendar does not contain.** Her review is
  scheduled only as "after the refinement phase", and she has appeared in this record
  before as the person who pulled Fabrizio Paganelli out of the 21/09 call. Nothing
  records her being asked, or a date being proposed to her.
- Aurel Mrruku's reasons are real: the account load took about six hours, fields still
  need correcting, and bad input breaks order generation. **The caution is sound; the
  consequence is still that acceptance has no user.**

🔑 This is the other half of
[OI-153](OI-153%20There%20is%20no%20full%20UAT%20sandbox.md). That note says the
environment is a Partial Copy; this one says nobody outside ROMI is in it.

## Open

- 🔴 **Put a date to Daniela Morgese's review**, since everything else waits on it.
- 🔴 **Decide whether approval by 13 October is still credible** if hands-on access
  starts on 6 October. Go-live is 21 October and Zoho expires 31 October.
- ⚠ Nothing records what "utenze blindate" restricts, or how many there are.
