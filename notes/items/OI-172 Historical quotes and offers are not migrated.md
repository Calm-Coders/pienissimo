---
id: OI-172
type: open-item
status: open
owner: Elena Spini
with: Marco Montesi
org: both
raised: 2026-09-23
updated: 2026-10-15
depends_on: [OI-165]
blocks: [go-live]
severity: gating
source: notes/meetings/2026-09-23 Check Data Import.md
---

# OI-172 - Historical quotes and offers are not migrated

**Ruled at [Check Data Import](../meetings/2026-09-23%20Check%20Data%20Import.md)
(`02:04:53`), by Elena Spini, with Fabrizio Paganelli accepting in the same exchange.**

## The rule

**Only orders migrate.** Anything that is not a confirmed, paid order — opportunities,
offers, quotes, anything left pending — **does not come across to Salesforce**. The
migration set is defined as _"tutto ciò che deve finire su Mexal, che è già su Mexal per
storico"_: the historic orders already in Mexal.

> **Fabrizio Paganelli:** _"Quindi offerte e preventivi nasceranno ex novo solo su
> Salesforce."_ **Elena Spini:** _"Ex novo, corretto."_

Aurel Mrruku's reason: importing quotes is structurally hard because of the ties between
opportunity and primary offer.

## The consequence nobody has been told about

🔴 **The tutors must re-key every pending quote into Salesforce by hand.** That was
agreed in session and framed as useful practice for them. **Marco Montesi was not in the
room**, and the group's own action item is to tell him at the next meeting.

- 🔴 **No volume is known.** Nothing in this record says how many quotes are open at
  cut-over, how long re-keying one takes, or who absorbs the time.
- 🔴 **It lands on the tutors, in the weeks before go-live 21/10**, while they are also
  learning the system. The 25/09 UAT session is Marco Montesi's.
- ⚠ The 22/09 lesson applies in reverse here: this is a **client-facing ruling made with
  the affected party absent**. It is a decision, not a deduction — but the party who
  carries the work has not agreed to it.

## Open

- 🔴 **Tell Marco Montesi**, as the session's own action item requires, and get an
  answer rather than an acknowledgement.
- 🔴 **Count the pending quotes** so the manual work has a size.
- ⚠ Decide what happens to a pending Zoho quote that is accepted **after** cut-over but
  was never migrated — nothing covers this.
- ⚠ No register row covers the migration perimeter. **Allocating a requirement id is a
  human's call.**

## 🔴 2026-10-15 - the operational cost is named: the users re-key them by hand

The rule held at [the 15/10 session](../meetings/2026-10-15%20Migrazione%20e%20Go-Live.md)
(`00:40`), and for the first time somebody said out loud what it costs. Fabrizio
Paganelli, on the offers the client has not yet confirmed:

> _"in quel caso lì in linea teorica, loro tutti gli utenti una volta imparato a
> usare il sistema dovrebbero prendere e andare a vedere tutte le offerte che
> hanno pending su Zo[h]o e inserirle anche su Sales Force."_

Elena Spini: _"sì, chiaro, è chiaro."_ He raised it as one of his reasons for
saying the go-live date will not be met.

🔴 **So the rule's consequence is manual re-entry of the open pipeline by the
commercial team, and it has no owner, no volume and no window.** Nobody said how
many pending offers there are — [OI-79](OI-79%20Migration%20volumes%20and%20mapping%20method.md)
carries no figure for them — nor who checks that the pipeline arrived complete.

🔴 **The window is now impossible as scheduled.** The work requires a readable
Zoho and trained users. Zoho expires **31 October**; the users are trained in the
two weeks before **2 November** and are not expected to be ready
([OI-246](OI-246%20Key%20User%20training%20cannot%20be%20completed%20before%20the%20new%20go-live.md));
and go-live is now after the expiry
([the risk](../risks/Risk%20-%20go-live%20now%20falls%20after%20the%20Zoho%20contract%20expires.md)).
**Either this is done before 31 October by people still learning the system, or
the open pipeline is read out of a dead CRM.** No source has noticed.
