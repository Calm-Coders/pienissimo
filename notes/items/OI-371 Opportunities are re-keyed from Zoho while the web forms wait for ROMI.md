---
id: OI-371
type: open-item
status: open
owner: Fabrizio Mastracci
with: Sabatino Rinaldi, Marco Montesi, Matteo Distaso
org: both
raised: 2026-11-16
updated: 2026-11-16
depends_on: [OI-340]
blocks: []
severity: high
source: notes/meetings/2026-11-16 Ultimi Check PROD.md
---

# OI-371 - Opportunities are re-keyed from Zoho while the web forms wait for ROMI

**On the first day of use the client's commercial team was told to type its Zoho
opportunities into Salesforce by hand, because nothing yet flows. New enquiries
from the website still land in Zoho in real time. The Pienissimo Live registration
forms are built, tested and ready, and the client is waiting on one word from ROMI
before putting them on the sites — with the event eight days away.**

## What the client is doing

Marco Montesi asked whether the commercial team could start:

> _"volevo capire se in questa fase i commerciali possono spostare un po' di
> opportunita"_

Aurel Mrruku: _"in teoria e tutto attivo in produzione"_ … _"noi stiamo facendo
questi test per capire se ci sono delle anomalie. Fino adesso non abbiamo visto
nessuna anomalia."_

Marco Montesi, concluding: _"tecnicamente saremo operativi su tutto, anche se noi
stiamo testando"_ → _"allora, intanto gli faccio creare le nuove opportunity"_ →
🔴 _"**io intanto gli faccio caricare le opportunity che avevano su Zoho**, cosi
intanto procediamo."_

This is the manual re-keying the 12/11 session anticipated for the 12-13 November
freeze — but it is now the standing arrangement for new business too, not a
two-day catch-up.

## What is not connected

Marco Montesi: _"le nuove opportunita entrano in Salesforce in questo momento?"_

Sabatino Rinaldi: _"in questo momento siamo, Matteo, in contatto con **Fabrizio di
ROMI** per capire se il collegamento e gia effettivo … **ora in tempo reale no,
sono ancora su Zoho**."_

🔑 So the website → Salesforce path is pending a ROMI confirmation, and the
counterpart is **Fabrizio Mastracci**, not Aurel Mrruku, who said plainly of the
forms _"non ci ho lavorato io su quello."_

## The forms exist and are waiting

Earlier in the same call, Sabatino Rinaldi:

> _"in questo momento stiamo raccogliendo richieste di iscrizione per il prossimo
> evento di pienissimo live con il marketing. **Abbiamo gia i form**, cioe Fabrizio
> ce li ha fatti lui per quell'evento li in particolare. Noi volendo **lo possiamo
> gia inserire sul sito ora** … i form sono funzionanti, li abbiamo testati."_

And later, naming the trigger:

> _"**appena Fabrizio ci da l'ok**, mettiamo pienissimo live come nuovi moduli,
> procediamo a crearli tutti e aggiornarli su tutti i siti."_

Aurel Mrruku's only answer was to send him to Fabrizio Mastracci by mail.

## Why this is urgent and not routine

- **Pienissimo Live runs 24-26 November.** Registrations are being collected now,
  and if they arrive in Zoho they are outside the system the client just went live
  on.
- 🔴 **No owner, no date and no written request.** The go-ahead sits with one ROMI
  person who was not on the call, reached through a client-side chain of two.
- ⚠ **The consent question is still unanswered underneath it.** Which field the
  public forms write for the marketing consent has been open for three sweep
  windows ([OI-340](OI-340%20The%20website%20lead%20forms%20have%20no%20field%20for%20the%20marketing%20consent.md)),
  and the owner of that question is leaving. Publishing the forms before it is
  settled means collecting consent into nothing.
- **The landing pages promised _"entro fine gg"_ on 9 and 10 November** have never
  been evidenced delivered; these forms may or may not be the same artifact —
  nothing in this window says.

## Needs a human

Fabrizio Mastracci has to say yes or no to connecting the Pienissimo Live forms,
in writing, and the consent field has to be named before he does.
