---
id: OI-361
type: open-item
status: open
owner: Elisa Migliano
with: Aurel Mrruku, Elena Spini, Andrea Parmeggiani
org: both
raised: 2026-11-12
updated: 2026-11-12
depends_on: [OI-312, OI-323]
blocks: []
severity: high
source: notes/meetings/2026-11-12 Check Pre-Import.md
---

# OI-361 - Pienissimo Live attendance cannot be recorded in Salesforce

**Pienissimo Live runs on 24-26 November, eight days after the client starts using
Salesforce. Its tickets were all issued from Zoho, its QR codes are not connected
to Salesforce, and the supplier has not built the production scanner. Attendance
will therefore be collected in Zoho and pushed back into Salesforce by a manual
ID-matching exercise designed on the call, with Campaign Member abandoned for that
edition. The developer said on the record that he expects it to go wrong.**

## Why it cannot work the built way

Sabatino Rinaldi, on the
[Check Pre-Import call](../meetings/2026-11-12%20Check%20Pre-Import.md):

> _"noi tutti i biglietti sono mandati da Zo\[ho\] e di conseguenza il **Q\[R\] code
> non e collegato a Sales Force**, quindi per forza"_

🔴 **And the supplier has done nothing.** Sabatino Rinaldi messaged Andrea
Parmeggiani during the call and read the reply out: _"mi ha detto che **non ha
ancora fatto niente**"_ — followed by a confused exchange over which event is
covered, _"non ce la facciamo per il primo corso dell'anno"_ against _"per
pienissimo live non ce la fanno"_. ⚠ **Which of the two is covered was never
settled on the call.** Same supplier as Anticipay
([OI-312](OI-312%20Anticipay%20times%20out%20in%20production.md)).

## Why an import is not simple

Aurel Mrruku set out the data model against Elisa Migliano's proposal:

> _"non c'e l'anagrafica dei contatti dei partecipanti … **abbiamo una struttura
> completamente nuova** su S\[ales\]F\[orce\]"_

> _"un referente puo partecipare a n edizioni. Dietro le \[quinte\] viene creato un
> record dell'oggetto tipo **campaign member** che fa la possibilita di fare il
> collegamento n a n … **Poi non ce l'hai lo storico di chi ha partecipato.** Non
> l'avrai mai."_

The Account alone is not a key — _"un'azienda ha piu referenti"_ — and the same
Account appears many times on one edition with different referenti.

## The plan that was agreed

🟡 A two-way export-and-match, each side supplying ids:

1. Aurel Mrruku exports from Salesforce a table of **Account id + Contact id** for
   the referenti (after they are imported), and separately **Asset id + Account id**
   for the edition's tickets.
2. Elisa Migliano matches her Zoho attendance list to it **by email, name and
   surname**, writing the Salesforce contact id against each row — _"faccio
   \[match\] tramite email del tuo ID dei referenti e metto il tuo ID"_.
3. ROMI then runs a **double mass update**: the referente onto the Asset and the
   Asset status to `utilizzato`.

🔴 **Campaign Member is dropped for this edition.** Elena Spini: _"Il campaign
member **lo lasciamo**"_, on the grounds that it only serves marketing. Aurel
Mrruku agreed — it was built _"per tracciare, per inviare il biglietto, vedere i
partecipanti"_ — so for Pienissimo Live none of that history will exist in
Salesforce.

## The recorded doubts

🔴 Aurel Mrruku: _"Se lo fa lei va bene, pero **io ho il dubbio che succederanno dei
casini. Se prendete voi la responsabilita** per me \[va bene\]."_

🔴 And internally the same evening, on the
[Modifiche Marco call](../meetings/2026-11-12%20INTERNA%20Modifiche%20Marco.md):
_"anche la discussione della migrazione dei biglietti sara un mal di testa, Elena.
**Faranno dei casini.**"_

🔴 He also objected to ROMI owning the extraction at all: _"**non so perche ti sei
preso il carico.** Per quello non volevo. Perche lo devono fare loro … Che ti
occuperai te poi se qualcosa non va bene perche hai dato te \[gli\] ID a loro.
Invece il contrario, tu gli devi dare loro la struttura. **ID li devono trovare
loro.**"_ Elena Spini's reason was the temperature in the room: _"si stava
accendendo troppo la situazione."_

## Volume

**~450 participants** expected at Pienissimo Live — Elisa Migliano: _"450"_.

## What is owed

- A written spec of the exchange: which columns, which direction, who runs the
  update, and when — ⚠ Elisa Migliano asked for it by mail and nothing records it
  being sent: _"Dopo mi mandate una mail, per favore, Aurel."_
- A straight answer from Andrea Parmeggiani on which event the production scanner
  will be ready for, with a date ([OI-323](OI-323%20The%20production%20domain%20has%20not%20been%20supplied%20by%20the%20client.md)).
- Whether the missing Campaign Member history for Pienissimo Live is acceptable, or
  must be back-filled later.
