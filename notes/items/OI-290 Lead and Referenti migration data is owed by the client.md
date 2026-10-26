---
id: OI-290
type: open-item
status: open
owner: Sabatino Rinaldi
with: Elena Spini
org: both
raised: 2026-10-26
updated: 2026-10-26
depends_on: [OI-244]
blocks: [go-live]
source: notes/meetings/2026-10-26 Tema Ordini Mexal.md
---

# OI-290 - Lead and Referenti migration data is owed by the client

**Lead and Referenti (Contact) data has to be migrated too, and until 26 October
the record only covered orders, invoices and tickets. The client's project
manager declined to own the extract and pointed at Sabatino Rinaldi, who was
absent from the call. The join from a Referente to its Account has no mechanism
yet beyond a promise to add the Mexal code.**

## How it surfaced

[The 26/10 call](../meetings/2026-10-26%20Tema%20Ordini%20Mexal.md). Aurel Mrruku
opened by asking whether the Contacts he will be given carry the Mexal customer
code, because without it he cannot attach a Referente to an Account. They do
not: Fabrizio Paganelli's earlier extract has a Zoho identifier in column O —
_"c'è un campo dove c'è nella colonna O il nome azienda che in realtà adesso
come adesso è un codice di X cifre."_

🟢 **Agreed mechanically in the room:**

- Fabrizio Paganelli supplies **the company list from Zoho carrying the Mexal
  code** — _"io ti passerei prese da ZO la lista delle aziende con il codice
  Mexal."_
- And **the Referenti list carrying the Mexal code** — _"facciamo in modo che
  nei referenti c'è il codice di Mexal."_
- Aurel Mrruku's fallback if that is not possible: the Zoho identifier plus a
  spreadsheet, and he joins them himself.

## Why it is open

🔴 **Fabrizio Paganelli refused to own the data**, three times:

> _"io su questi aspetti qua non so nulla. Bisogna che parliate con Sabatino."_
>
> _"i dati fatevi dare da Sabatino … ci penserà Sabatino a estrapolarli."_
>
> _"se rispondo io mi mancano delle informazioni, per cui corriamo il rischio
> che facciamo casino."_

He offered to help Sabatino Rinaldi extract from Zoho if asked, and to be cc'd
with Elisa Migliano — but the request must go directly to Sabatino Rinaldi.
⚠ **Sabatino Rinaldi did not attend**: _"C'è Sabatino stamattina che non ho
visto."_

🟢 **Elena Spini raised it the same day**: Gmail `1a1786a9c1a23757`,
**13:33:24Z**, to `sabatino.r@pienissimo.com`, cc Fabrizio Paganelli,
`amministrazione@pienissimo.com` and Aurel Mrruku:

> _"durante la call di questa mattina con Fabrizio abbiamo affrontato il tema dei
> dati relativi a **Lead** e **Referenti** … per procedere con la migrazione,
> avremmo bisogno dei dati da importare per: Lead; Referenti (ti ricordo, a
> questo proposito, l'importanza di verificare la corretta associazione tra
> l'Azienda/Account e il rispettivo Referente). Fabrizio è già allineato sul
> punto: puoi fare riferimento direttamente a lui come primo contatto per il
> passaggio dei dati."_

referencing
[the data model workbook](../The%20Campi%20Oggetti%20Flussi%20e%20Utenti%20workbook.md)
as the field structure. ⚠ **Unanswered as at this sweep.**

## The open problems

1. 🔴 **No date and no owner confirmation.** The mail asks; Sabatino Rinaldi has
   not replied, and he is the person who on 21/10 told ROMI _"mi aspetto da
   parte vostra dovete portarci una soluzione"_ about the ticket balance. The
   extract is needed before the **13 November 09:00** file deadline.
2. 🔴 **Zoho cannot fill the agreed field set.** Fabrizio Paganelli: _"questi qui
   sono campi che sono stati aggiunti e io su Zoo [Zoho] non ce li ho e io non ve
   li do vuoti dopo."_ So the data model ROMI reviewed with Sabatino Rinaldi
   asks for fields the source system does not hold, and nobody decided what
   happens to them.
3. ⚠ **The Account join is the stated risk, not the fields.** Elena Spini: _"la
   difficoltà dei referenti sarà poi quella di associare il referente all'ID di
   account corretto."_ The Mexal code is the proposed key; whether Zoho holds it
   on every Referente is unverified.
4. ⚠ **The field sets were reviewed but never exercised.** Elena Spini: _"abbiamo
   rivisto i campi con lui, non abbiamo mai visto un'estrazione di dati."_
5. 🔑 **Consents ride on the Lead.** _"tutta la storia dei consensi se li
   riprende dal lead"_ — so a Lead migration that drops consent fields has a
   compliance consequence, and nothing addresses it.
6. ⚠ **No register row covers Lead or Contact migration.** As with ticket
   migration
   ([OI-274](OI-274%20The%20historical%20ticket%20balance%20has%20no%20migration%20path.md)),
   the absence is itself the finding — and it lands four days after ROMI asked
   the client to route out-of-scope requirements through Change Requests
   ([OI-285](OI-285%20ROMI%20asked%20the%20client%20to%20route%20future%20out%20of%20scope%20requirements%20through%20change%20requests.md)).
   🔑 **Nobody called this a CR either.**

## Terminology

_"Referenti uguale contatti"_ — confirmed in the call. The client's **Referente**
is the Salesforce **Contact**.
