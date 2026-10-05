---
id: ref-marketing-send-logics
type: reference
status: active
owner: Fabrizio Mastracci
org: ROMI
raised: 2026-10-05
updated: 2026-10-05
depends_on: [OI-134, OI-177, OI-196, OI-197, OI-199]
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
