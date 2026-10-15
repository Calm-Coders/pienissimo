---
id: OI-240
type: open-item
status: open
owner: Elena Spini
with: Marco Montesi
org: both
raised: 2026-10-14
updated: 2026-10-15
depends_on: [OI-186, OI-180]
source: Gmail thread 1a13b044107768b4
---

# OI-240 - Marco Montesi needs a Salesforce user before go-live

**Fabrizio Paganelli asked on 14/10 whether the commercial lead can be given
access now, to start looking at the environment. Elena Spini did not answer the
question; she put it on the agenda of the 15/10 meeting.**

## The exchange

Fabrizio Paganelli, **2026-10-14 15:24:54Z**, to Elena Spini and Aurel Mrruku,
cc `amministrazione@pienissimo.com` and Marco Montesi, subject _"Account per
Responsabile Commerciale"_:

> _"Ciao, come memo per domani mattina. Marco, responsabile commerciale, ha
> chiesto se gli possiamo dare una accesso, per iniziare a vedere un po'
> l'ambiente. È possibile in questa fase?"_

Elena Spini, **16:47:09Z**:

> _"Ok Fabrizio, ho aggiornato la descrizione del meeting di domani (sarà
> pomeriggio 14.30-15.30) con i vari temi di cui dobbiamo discutere."_

The updated invitation carries **_"Utenza per Marco"_** among its four themes.

## Why it is a row and not an administrative detail

- 🔑 **It is the same question OI-180 already answered once, in the negative.**
  [OI-180](OI-180%20Client%20UAT%20users%20are%20withheld%20until%20a%20director%20review.md)
  records client UAT users being withheld pending a director review. Whether that
  constraint still stands seven days before go-live is exactly what Fabrizio
  Paganelli is asking, and **nobody has said**.
- 🔴 **Which profile he would get is undefined.**
  [OI-186](OI-186%20The%20Salesforce%20user%20list%20and%20profiles%20were%20never%20agreed%20with%20the%20client.md)
  records that the user list and profiles were never agreed with the client. A
  _responsabile commerciale_ is not in any profile list in these records — and
  neither is a **tutor**, which is
  [OI-233](OI-233%20Bundle%20access%20for%20tutor%20profiles%20is%20undefined.md).
  **Two access requests in two days, neither mapping onto a defined profile.**
- ⚠ **He is the person with the most unanswered questions and the least
  exposure to the build.** His Business Blueprint precisazioni produced
  [OI-222](OI-222%20The%20commercial%20mail%20and%20WhatsApp%20notification%20flows%20are%20unspecified.md)
  and [OI-224](OI-224%20Mass%20Opportunity%20creation%20is%20contested%20as%20a%20Fase%202%20deferral.md),
  and [OI-238](OI-238%20The%20tacit%20renewal%20path%20skips%20client%20acceptance%20and%20its%20approval%20workflow%20is%20undecided.md)
  now waits on his ruling. Elena Spini's own answer to him on 07/10 was
  _"consiglio di provare ad utilizzare la piattaforma"_ — advice he cannot take
  without a login.
- ⚠ **Elena Spini's internal view of his requests is unflattering and on the
  record.** In a DM the same evening (18:54:46 CEST) she describes _"parte delle
  assurdità mai sentite che gli boccerò"_. Noted because it bears on how his
  asks are likely to be handled, not as a finding about the requests themselves.

## What closing it looks like

A decision at the 15/10 meeting: a user for Marco Montesi with a named profile
and environment, or a stated reason to wait, communicated to the client.

## 🟢 2026-10-15 - answered: System Admin now, the profile later

Decided at [the 15/10 session](../meetings/2026-10-15%20Migrazione%20e%20Go-Live.md)
(`00:10`–`00:15`), the meeting this row was deferred to.

**The answer is yes, with the profile question explicitly postponed.** Aurel
Mrruku explained why it cannot be answered first:

> _"tutti i flussi fino adesso … per tutti i flussi abbiamo usato solo il
> permesso di sistem admin perché avevamo detto confermiamo prima tutto e poi
> decidiamo chi deve vedere cosa."_

> _"se io adesso devo fare i permessi, ma ci sono campi che non servono, ci sono
> layout che devono cambiare, io li devo rifare ogni volta che cambia un campo
> perché i permessi sono legati con l'entità."_

Elena Spini's decision: _"gli diamo comunque il system admin, con l'accortezza
che poi non sarà così nel futuro, così almeno inizia a mettere mano."_ Aurel
Mrruku: _"Quello sì, lo faccio senza problemi."_

She also undertook to walk him through it herself, from **Monday 19 October**,
starting with the lead flow — _"mi concentro su Marco … gli do l'accesso e
vediamo il giro dei lead che deve fare"_. Fabrizio Paganelli mailed Marco Montesi
during the call to tell him so, cc Elena Spini.

🟢 **So the immediate ask is closed** and
[OI-180](OI-180%20Client%20UAT%20users%20are%20withheld%20until%20a%20director%20review.md)'s
withholding no longer applies to him.

🔴 **The profile question is not closed, it is deferred to after test sign-off** —
[OI-186](OI-186%20The%20Salesforce%20user%20list%20and%20profiles%20were%20never%20agreed%20with%20the%20client.md).
Eighteen days before the new go-live, **everyone who touches the system is a
System Admin**, and two requirements now depend on profiles that do not exist:
[OI-247](OI-247%20Only%20the%20responsabile%20commerciale%20may%20edit%20the%20provvigioni%20fields.md)
(the commission fields must be editable by the commercial lead alone) and
[OI-233](OI-233%20Bundle%20access%20for%20tutor%20profiles%20is%20undefined.md)
(tutors must not quote or order bundles).

⚠ **Elena Spini flagged the interim's own risk** in the room: under System Admin
he will see and be able to edit the Mexal section, which the final model forbids
— _"lui adesso pure nei test la vedrà questa cosa, ma vi spiegherò che lui in
realtà i dati di Mexal con i permessi giusti non li potrà editare"_. So his
training and testing happen against access he will not have in production, which
is exactly what Aurel Mrruku expects to be hard to explain later: _"le cose che
io mi aspetto che siano difficili da spiegare [sono] i campi che non vedono."_

⚠ **And it bears on the Go/No-Go.** He is one of the three client-side users with
no exposure to the build and a week to acquire it before the 27 October decision
— see [OI-246](OI-246%20Key%20User%20training%20cannot%20be%20completed%20before%20the%20new%20go-live.md).

**Row kept open** for the profile, which is the half that blocks go-live.
