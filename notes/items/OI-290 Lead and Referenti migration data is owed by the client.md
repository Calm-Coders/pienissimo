---
id: OI-290
type: open-item
status: open
owner: Sabatino Rinaldi
with: Elena Spini
org: both
raised: 2026-10-26
updated: 2026-10-27
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

## 2026-10-27 - a deadline exists, the join is identified, and a contacts export appeared

🟢🔑 **A hard date was set: Monday 2 November.**
[The internal follow-up](../meetings/2026-10-27%20Follow-up%20Interno.md),
`00:22:45`–`00:24:36`:

> **Aurel Mrruku:** _"Elena, là io me ne frego. **Non gli possiamo mandare 10
> mail** per avere un po' di attenzione. Andiamo in live, abbiamo finito. Amen.
> Non ci avete risposto. C'era una data entro queste. **Dobbiamo essere rigidi su
> ste cose.**"_
>
> **Elena Spini:** _"La data però manca, **quindi è colpa mia** … faccio io il
> follow up e gli dico se non mi date questa risposta entro tot."_
>
> **Aurel Mrruku:** _"lunedì prossimo o venerdì, **entro lunedì**."_
>
> **Elena Spini:** _"**Entro lunedì prossimo** dobbiamo avere questi dati."_

🔑 **This closes the "no date" half of problem 1 above** — internally. ⚠ **The
follow-up mail had not been sent as at this sweep**: nothing to
`sabatino.r@pienissimo.com` exists after the 26/10 request, and Elena Spini
acknowledged her original mail carried no deadline. **The deadline is a ROMI
intention, not yet a client commitment.**

⚠ **Sabatino Rinaldi has still not answered the 26/10 request** — second day. He
*has* replied on the ticketing and communications thread (quoted in Slack on
27/10; see
[OI-242](OI-242%20The%20community%20Rinuncia%20button%20must%20show%20the%20public%20refusal%20text.md)
for the source caveat), so he is reachable and responsive on other subjects. 🔑
**That makes the silence on this one selective, as with the Change Request
paragraph.**

🟢🔑 **The Account join is identified — and it is not the Mexal code.**
`00:25:42`–`00:28:46`. The client's file carries `nome azienda` and a **`codice
cliente esterno`** that matches the Salesforce account:

> **Aurel Mrruku:** _"vedi che c'è qua a destra … c'è nome azienda e questo nome
> azienda qua stava su [aziende e account] … Praticamente c'è il **codice cliente
> esterno** e io gli ho chiesto di mettermi su una mia azienda il codice cliente
> esterno."_
>
> **Elena Spini:** _"basta che ci confermano sta cosa la portiamo."_

So the proposed key is the **external customer code** already present in the
client's export, proven on one test account, and **awaiting client confirmation**.
This supersedes problem 3 above, where the Mexal code was the candidate — though
⚠ both may be the same identifier under two names; nothing in the call
establishes that.

⚠ **Both admitted the referenti structure is still unclear to them.** Aurel
Mrruku: _"Io non ci ho capito un tubo sui referenti perché ha fatto quel casino
Fabrizio … Bastava prendere quell'elenco e amen."_

🆕 **A Zoho contacts export now exists in Drive.** `Contatti_Zoho_CRM_`, Google
Sheet `18Jif9_B4yEhybsS6bQLzilNu4kykvYTwqA56seugyaU`, **10,767,377 bytes**, owner
`a.mrruku@romicompany.com`, **created and last modified 2026-10-27 16:48Z** —
roughly fifteen minutes before the follow-up call, and consistent with the file
the two of them opened during it.

⚠ **Not opened. It holds real contact records** —
[docs/publishing.md](../../docs/publishing.md). Recorded by id, size, owner and
timestamp only. 🔑 **Its provenance is not established**: nothing states whether
it is the client's delivery against this request, an earlier export Fabrizio
Paganelli had already shared, or ROMI's own conversion of one. **It is not
evidence that the client has delivered.**

🔴 **Unchanged:** the Zoho source still cannot fill the agreed field set, nobody
has decided what happens to the fields it cannot fill, consent migration is
unaddressed, and no register row covers Lead or Contact migration.
