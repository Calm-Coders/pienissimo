---
id: ref-marketing-send-logics
type: reference
status: active
owner: Fabrizio Mastracci
org: ROMI
raised: 2026-10-05
updated: 2026-10-12
depends_on: [OI-134, OI-177, OI-196, OI-197, OI-199, OI-225]
source: Slack marketing group DM C0C38JJ9D1T, 2026-10-05 10:44:57 and 10:56:50 CEST
---

# The marketing ticket send logics as written by Marketing

**The Salesforce→Marketing Cloud send contract, written down by the person who
has to build it.** Fabrizio Mastracci posted both flows into the marketing
group DM on 2026-10-05, straight after
[the production check session](meetings/2026-10-05%20Interna%20Check%20PROD%20per%20MKT.md)
— _"Ho messo le logiche sulla nostra chat."_

🔑 **This is the field specification Aurel Mrruku has owed since 30/09, arriving
from the other direction**: the recipient wrote back what he understood, rather
than the sender issuing it. The spec was due 02/10 and no artifact from him was
ever found ([OI-197](items/OI-197%20The%20ticket%20send%20flag%20and%20the%20Inviato%20asset%20state%20are%20agreed%20and%20unbuilt.md)).

## Logica ingresso 1 — the participant link

> _"inviare email contenente link (**Registration_Url__c**) alla creazione di
> un record dell'oggetto 'Event_Invitation__c' che ha: **Registration_Url__c
> NOT NULL AND URL_Status__c = 'Ready' AND Data_Invio_Biglietto__c =
> Data_Invio_Biglietto__c.Campagna (trovo popolato solo su campagne figlie)**"_

⏸ **On hold.** His own words: _"per ora rimaniamo in attesa di follow up"_, and
Elena Spini stopped the send outright at 18:28:50 CEST:
_"**non mandare la mail** perchè dobbiamo ancora sentirli per il tema link
invio partecipanti ecc"_ — pending the client call on **06/10 10:00**.

🟢 The condition carries the Campaign's `Data_Invio_Biglietto__c`, which is
problem #1 of the logic document's own risk table and is now built. ⚠ He notes
the field is **populated only on campagne figlie**.

## Logica ingresso 2 — the filled tickets

> _"Prendere dall'oggetto Order, gli Asset che hanno **Statuse = 'Assegnato'
> AND Ready for Ticket Dispatch = true AND ticket_sent__c = 'false'**. Il
> biglietto da Mandare si trova sull'Asset in allegati e devo mandarlo alle
> persone quando incontrano le logiche sopraccitate… Il biglietto va inviato
> alla mail del contatto in riferimento. Successivamente ci sono due campi
> sull'asset che sono ticket sent e ticket sent date. Li devo spostare: il
> primo a 'true' e il secondo lo devo popolare con la data di invio della mail
> contenente il biglietto."_

🟢🔑 **Two things this settles.**

1. **All three fields are on `Asset`**, as he states, so the query he writes can
   actually run. That is
   [OI-199](items/OI-199%20The%20ticket%20send%20flag%20fields%20are%20split%20across%20Asset%20and%20Order.md)
   discharged from the consumer's side, the day after the fields moved.
2. **He added `Status = 'Assegnato'` himself.** That is precisely problem #4 of
   the logic document's risk table — the query ignoring `Status`, so a
   corrected collection after nomination would still send. The person building
   it closed the hole without being told.

⚠ The ticket is taken from the Asset's **attachments**, by implication the
document whose filename prefix contract was set at the 01/10 Pre UAT. The same
Asset will also carry
[OI-194](items/OI-194%20The%20ticket%20is%20a%20signed%20participation%20document%20not%20just%20a%20QR%20code.md)'s
seven-page participation document, and nothing in this specification
distinguishes the two.

⚠ The write-back is **Marketing Cloud writing to Salesforce per participant**,
which is problem #10 of the same table: at volume it risks delays or double
sends. Unaddressed here.

## 🔑 2026-10-06 - the full funnel, written out

Fabrizio Mastracci posted the whole of flow 1 into the same DM at **14:47:15
CEST**, headed `FUNNEL INVIO RICHIESTA ISCRIZIONE - NO LOGICHE BUSINESS SOLO
INVIO NEWSLETTER CON RICHIESTA ISCRIZIONE DA MARKETING CLOUD`. This is the first
time the shape of the funnel appears anywhere in the records.

### Structure

- **11 communications: 11 email + 11 WhatsApp**
- **Wait between steps is variable** — 2/3/4/5/6/7/8 days, _"da setting evento"_
- The exit check is **repeated at every step**, eleven times

### Entry — unchanged from 05/10, and already agreed

First email fires on creation of an `Event_Invitation__c` with
`Registration_Url__c` NOT NULL, `URL_Status__c = 'Ready'`, and
`Data_Invio_Biglietto__c` matching the Campaign's — _"popolato solo su campagne
figlie."_

### Exit — the contact leaves the funnel on any one of

- Click on **Rinuncia**
- **All** pre-ordered / blocked tickets nominated or completed
- **Event date passed**

### 🔴 Two questions put to Rebecca Marmo, both unanswered at this watermark

- **WhatsApp: parallel or backup?** _"Invio sempre in parallelo alla email, o
  solo come backup su: bounce email / email non aperta / email non cliccata"_.
  ⚠ This doubles or halves the message volume of the whole funnel and nobody has
  decided it.
- **Which date stops the sending** — _"Data inizio evento, oppure Data fine
  evento"_.

### 🔴 The partial-nomination exit rule, and a reversal inside 37 seconds

At 14:34:35 CEST he stated the continue-condition, including a fourth clause:

> _"Il contatto segue nel percorso dell'invio successivo se: ha ancora dei
> biglietti da nominare · l'evento non è ancora passato · non ha cliccato su
> Rinuncia · **se non ha completato almeno 1 iscrizione (Iscr effettuate è
> minore di 1)**"_

Elena Spini answered twice, in the same thread, a **37-second** apart:

| Time | Elena Spini |
| --- | --- |
| 14:42:17 | _"a me torna, dice praticamente che hai almeno un biglietto nominato esci dal flusso 1"_ |
| 14:42:54 | _"**NON mi torna** perchè per me è no sense e rischiano di aver i biglietti nominati a metà ma se va bene a loro................."_ |

So the project manager **read it, accepted it, then rejected it on the merits and
accepted it anyway** — under protest, deferring to the client. ⚠ Her objection is
the correct one and it is not recorded anywhere a client can see it: one
nomination of five ends the follow-ups, and the remaining four tickets are never
chased.

🔑 **This is not a drafting slip — it is what the client agreed.**
[The 06/10 session](meetings/2026-10-06%20Form%20Link%20per%20partecipanti.md)
ruled _"Esclusione dei flussi di follow-up per nomine parziali… rinunciando
temporaneamente ai flussi di follow-up per le nomine parziali in vista del
go-live."_ Sabatino Rinaldi had proposed dynamic follow-ups and was declined on
time grounds. So the rule stands, Elena Spini's _"ma se va bene a loro"_ is the
whole of ROMI's dissent, and
[OI-196](items/OI-196%20Whether%20tickets%20are%20sent%20when%20the%20buyer%20names%20only%20some%20participants.md)
— which exists for exactly this case — carries the consequence.

### Dynamic fields of the first mail

Posted 14:26:47 CEST:
`Luogo__c`, `Data__Evento__c`, `Data_Inizio_Evento__c`, `Data_Fine_Evento_c`,
`Indirizzo__c`, `Parcheggio__c`, **ACCETTA (`Registration_Url__c`)**,
**RINUNCIA ()**.

🔴 **`RINUNCIA` has nothing behind it** — empty parentheses where `ACCETTA`
names its field. ⚠ **Recorded as uncertain, not as a defect**: the same day's
session agreed to _remove or redefine_ the direct Rinuncia button in the email
and send the participant to the web page instead, so the empty slot may be a
leftover rather than a gap. **Nobody has said which**, and the field list was
posted three hours after the ruling. Someone must strike it or name its source
before the first mail goes.

### The Rinuncia button is on the community page, and must be bigger

Rebecca Marmo, relayed by Fabrizio Mastracci at 14:27:17 CEST to `@channel`:

> _"Come indicato da Aurel, il tasto RINUNCIA non potrà essere presente sia nella
> mail che nella landing page. Pertanto, vi chiederei, se possibile, di rendere
> il tasto più grande e maggiormente visibile."_

🟢 **Which surface is settled.** Fabrizio Mastracci asked whether "bigger button"
meant the landing page; Aurel Mrruku answered at 14:33:36 — _"si si tratta della
pagina di community"_. So the enlargement is a change to the Salesforce community
page, not to a marketing asset. ⚠ No owner and no commit for it this sweep.

### ⚠ There is no ROMI solution-design template

Fabrizio Mastracci asked for one so he could write the marketing solution up for
client approval — _"se abbiamo un template romi… ti chiedo di girarmelo cosi
metto li la soluzione e gliela faccio approvare"_. Elena Spini, 14:41:22:
**_"non c'è un modello/template"_**. Recorded because the approval artifact for
the marketing flow will therefore be ad hoc, like the logic document before it.

## 🔑 2026-10-12 - the same two flows, described as built

Fabrizio Mastracci posted both flows again into the same DM at **09:15:18 CEST**,
this time in the present tense of something that exists and runs. 🔑 **It is the
first written description of these flows as built**, which matters because the
project keeps **no flow metadata in source control** —
`force-app/main/default/flows/` is empty — so until now their behaviour was
knowable only by opening the org.

### `Invio Richiesta conferma biglietto`

- **Trigger** — on `Invito Evento` when the registration link is populated, the
  link state is `Pronto` and the ticket send date is filled.
- **Volume** — _"Invia fino a 11 email al Referente Destinatario: la prima
  subito, le successive a distanza dei minuti indicati nel campo **Wait
  Interval** (creato da me) dell'Edizione Evento."_
- **Exit, re-checked before every send** — it stops if _"esiste almeno un
  biglietto dello stesso ordine ed edizione con esito (Assegnato, Rinuncia,
  Utilizzato, Non utilizzato)"_ or _"la data dell'evento è passata"_.
- **Content** — event name, place, dates, address, and the **ACCETTA** button to
  the registration link.

### `Invio Biglietto assegnato`

> _"Si attiva quando il biglietto passa ad 'Assegnato', è pronto per l'invio e
> non è ancora stato inviato. **Dopo 1 minuto** recupera il PDF del biglietto,
> crea un link pubblico e invia al partecipante l'email con il link per
> scaricarlo. Al termine marca il biglietto come inviato (con data e ora)."_

## 🔴 What changed since 06/10, and what it costs

### 1. The wait is minutes, not days

The 06/10 version put the gap between the eleven steps at **2/3/4/5/6/7/8 days**,
_"da setting evento"_. Today it is _"i minuti indicati nel campo Wait Interval"_.
⚠ **A `Wait Interval` in minutes sends eleven emails inside an hour.** The
natural reading is that the field is set short for testing and the unit is
minutes by design; the equally available reading is that the unit is wrong.
**Nothing establishes which**, and it is one question to the field's author, who
says he created it.

### 2. 🔑 The 1-minute PDF wait is a candidate root cause for OI-225

[OI-225](items/OI-225%20The%20ticket%20dispatch%20flow%20sends%20to%20a%20null%20recipient%20and%20fails%20the%20asset%20write.md)
is this second flow failing: `Get Ticket PDF` reported _"Impossibile trovare i
record"_ and the send went to `null`. This description supplies the mechanism
that would produce exactly that — the PDF is fetched on a **fixed one-minute
delay** after the ticket reaches `Assegnato`, and the participant document is
rendered asynchronously by a platform-event subscriber
([the manual steps tracker](Manual%20Steps%20Pienissimo%20tracker.md), row 2).
A fixed wait against an asynchronous render is a race, and a race lost is an
empty collection.
⚠ **Candidate, not established.** Nobody has opened the flow, the org behind the
error mail is still unidentified, and a one-minute wait is only a race if the
render can take longer than a minute — which this sweep cannot measure.

### 3. The ticket is now a link, not an attachment

The 05/10 version said the ticket _"si trova sull'Asset in allegati"_ and is sent
from there. Today the flow _"crea un link pubblico"_ and sends the **link**.
⚠ A public link to a participant document is a different exposure from an
attachment to a known address, and
[OI-194](items/OI-194%20The%20ticket%20is%20a%20signed%20participation%20document%20not%20just%20a%20QR%20code.md)
— the seven-page signed participation document on the same Asset, still gating —
is on the other end of it. **Nobody has assessed that.**

### 4. WhatsApp has gone quiet

The 06/10 funnel was **11 email + 11 WhatsApp**. Today's description mentions
only email. 🔴 **Rebecca Marmo's unanswered question — parallel or backup — has
not been answered; it has been dropped from the description.** Recorded as an
omission, not as a decision.

### 5. 🟢 The exit rule is now an esito test

The 06/10 continue-condition carried a fourth clause, `Iscr effettuate < 1`.
Today's is a single test for any ticket of the same order and edition carrying an
esito, with `Rinuncia` as **one of the esito values** rather than a button click.
That is cleaner and still implements the partial-nomination rule the 06/10 session
agreed — so Elena Spini's recorded objection, and
[OI-196](items/OI-196%20Whether%20tickets%20are%20sent%20when%20the%20buyer%20names%20only%20some%20participants.md),
stand unchanged.

## What this does to OI-197

[OI-197](items/OI-197%20The%20ticket%20send%20flag%20and%20the%20Inviato%20asset%20state%20are%20agreed%20and%20unbuilt.md)
listed five pieces of the send contract as unbuilt. The 09/10 sweep qualified
that to _unknown_ once `flows/` was found empty. **This narrows it further**: the
two flows exist and their author describes their working behaviour, including the
`Inviato` stamp — _"Al termine marca il biglietto come inviato (con data e
ora)"_. ⚠ Still a description, not an inspection: an org-only flow that one
person describes from memory is not an inventory, and one of the two is **known
to be failing**.

⚠ Of record, same thread: _"Sto finendo la **testlist degli invii**, domani
facciamo un giro"_ (09:15:59 CEST). The review slot became the recurring
**[PIENISSIMO] - Follow-up Interno**, moved to **Tue 13/10 15:30–17:00 CEST** so
it would fit before Elena Spini stops at 17:00. **The testlist itself is not in
any source.**
