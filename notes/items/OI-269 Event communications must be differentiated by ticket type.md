---
id: OI-269
type: open-item
status: open
owner: Aurel Mrruku
with: Fabrizio Paganelli
org: both
raised: 2026-10-20
updated: 2026-10-27
depends_on: [OI-250, OI-186]
blocks: [go-live]
source: Gmail 1a158b6e3e4cee81
---

# OI-269 - Event communications must be differentiated by ticket type

**The client has declared differentiated communications per ticket type a
requirement rather than a Fase 2 wish. The Asset that represents a ticket does
not carry a ticket type, so the requirement cannot be built as asked; and
neither ROMI person could establish from the mail what "differentiated" means.**

## What was asked

In [the client's 20/10 mail](OI-268%20The%20client%20proposed%20a%20go-live%20calendar%20of%2016%20November.md),
§3, Sabatino Rinaldi:

> _"Vi ricordiamo la necessità di differenziare le comunicazioni in base al tipo
> di biglietto (es. Gold ed Executive): sappiamo che è previsto più avanti, ma
> per noi è un requisito."_

🔑 **The sentence does two things at once**: it concedes ROMI scheduled it later,
and overrides that with _"per noi è un requisito"_. Arriving the day after the
client proposed a new go-live calendar and four days after the Fase 1 scope
freeze in [OI-243](OI-243%20Go-live%20moved%20from%2021%20October%20to%202%20November.md),
it is the second piece of new build scope to land after that freeze — the first
being [OI-250](OI-250%20The%20reminder%20wait%20intervals%20must%20be%20configurable%20per%20edizione.md).

## 🔴 Why it cannot be built as asked

At [the 17:01 internal call](../meetings/2026-10-20%20Follow-up%20Interno.md),
Aurel Mrruku traced the data path and found it broken at the Asset:

> _"il template dell'email deve essere diverso in base alla tipologia del
> biglietto, ma noi non ce l'abbiamo una tipologia del biglietto, in teoria
> dipende dal prodotto … quando generiamo l'asset dobbiamo tenere sull'asset
> anche la tipologia del biglietto **che nessuno l'ha detto** e lui deve
> filtrare."_

- **The product does carry one.** He located a `tipo biglietto` field on the
  article, a restricted picklist that allows blank, **not on the layout** —
  _"c'è blank, però è restrict, vedi che è una picklist."_ He recalled it as
  having three values; the record does not confirm the count, so it is not
  asserted here.
- **The Asset does not.** Ticket generation does not copy the type onto the
  Asset, so a journey selecting a template per ticket type has nothing to read.
- **So the work is**: carry the type onto the Asset at generation, then branch
  the sends on it — which touches the same journey OI-250 would rebuild.

⚠ `Gold` and `Executive` are given by the client as examples (_"es."_). **Whether
they are values of the product's existing picklist is unverified** — the
picklist's values were not read in this sweep, and the product field is not on a
layout anyone has screenshotted.

## 🔴 Nobody at ROMI knows what the requirement contains

Elena Spini could not interpret it, repeatedly, in the call:

> _"nella sua testa quali comunicazioni diverse? … Che comunicazioni? Ma poi
> cosa? Quali comunicazioni? Cioè che che requisito è?"_

Her best guess was that it may be trivial — _"forse vuole il rifiuta uno blu e
uno rosso"_ — and she recorded being blindsided by the mail as a whole:
_"io sono proprio sconvolta del fatto che nessuno mi abbia parlato prima di sta
mail, cioè che è arrivata così senza preavviso."_

Aurel Mrruku's reading is that it implies the client building separate campaigns
per type — _"Fabrizio si dovrebbe fare delle campagne diverse"_ — which is an
operational consequence nobody has put to the client.

⚠ **So the scope is undetermined in both directions**: how many templates, which
ticket types, and whether the branching is ROMI's build or the client's campaign
configuration. **None of it can be estimated until asked.**

## What closing it looks like

The client states which ticket types need which communications; ROMI confirms
whether the product picklist already models them; the type is carried onto the
Asset at generation; and the sends branch on it — or the item is put to the
client as Fase 2 with the freeze cited, which is the one thing ROMI has not yet
done with it.

## 2026-10-26 - restated internally, still unspecified

⚠ **No movement, and it is now a tracked ROMI red flag.** Elena Spini's weekly
status in `#tproj-pienissimo` (24/10 11:00:01 CEST) records it among the
requests that arrived late:

> _"nella stessa mail della richiesta di posticipare il go-live, Sabatino dice:
> 'le comunicazioni diverse per tipo di biglietto (Gold/Executive) diventano un
> requisito', la richiesta non è mai emersa prima: **abbiamo chiesto ulteriori
> dettagli e capiremo se è possibile gestirlo in questa fase**."_

🟢 So ROMI did ask the client for detail — which this row recorded as missing on
20/10. ⚠ **No answer is in evidence**, and the status itself leaves the phase
open (_"capiremo se è possibile"_).

🔑 **It is now caught by a ruling made two days later**:
[ROMI will absorb no further scope in Fase 1](../decisions/ROMI%20will%20absorb%20no%20further%20scope%20in%20Fase%201.md)
— Gianpaolo Motta, 26/10, _"spostagliele alla fase 2"_. ⚠ Nothing records this
row being moved, and the client has not been told.

## 2026-10-27 - the client made it a requirement again, and ROMI decided to block it

🔴🔑 **The client did not supply the detail ROMI asked for. It restated the
requirement.** Sabatino Rinaldi's reply, quoted verbatim by Elena Spini in the
ROMI marketing group DM `C0C38JJ9D1T` at **09:18:10 CET**:

> _"Vi ricordiamo la necessità di differenziare le comunicazioni in base al tipo
> di biglietto (es. Gold ed Executive): **sappiamo che è previsto più avanti, ma
> per noi è un requisito**."_

🔑 **Note what the client concedes and what it does not.** It accepts that the
work sits later in the plan, and refuses to drop it. That is a position, not the
specification this row has needed since 20 October.

🔴 **ROMI's internal answer, the same morning, was to block it.** Elena Spini,
09:19:09 CET:

> _"tipo questa cosa mai sentita prima **sarà per forza fase 2** >> la necessità
> di differenziare le comunicazioni in base al tipo di biglietto (es. Gold ed
> Executive) - **ma come deve essere gestita?**"_

Fabrizio Mastracci, 09:23:33 CET, on the three points she had relayed:

> _"No infatti **la 2 bloccala**, la 1 e la 3 ok"_

Point 2 is this one. So: **points 1 (the 11–15 communications set,
[OI-250](OI-250%20The%20reminder%20wait%20intervals%20must%20be%20configurable%20per%20edizione.md))
and 3 (rinuncia,
[OI-242](OI-242%20The%20community%20Rinuncia%20button%20must%20show%20the%20public%20refusal%20text.md))
were accepted; this one was refused for Fase 1.**

🟢 **And it is now priced into Fase 2.** _"Differenziare la comunicazione"_ appears
in the scope list of [the Fase 2 estimate](../The%20Fase%202%20estimate.md),
reviewed at 17:03 CET the same day. So the ruling is being executed
([no further absorption in Fase 1](../decisions/ROMI%20will%20absorb%20no%20further%20scope%20in%20Fase%201.md)).

## 🔴 What is still wrong with this row

1. **Nobody has told the client.** Three days of internal rulings — Gianpaolo
   Motta's on 26/10, Elena Spini's and Fabrizio Mastracci's on 27/10 — and the
   client's last word on the record is _"per noi è un requisito"_. **No reply, no
   Fase 2 statement, no Change Request.**
2. **ROMI still does not know what the requirement is.** _"ma come deve essere
   gestita?"_ — asked internally, four days after asking the client, and
   unanswered. **A Fase 2 estimate now carries a number for work nobody has
   specified.**
3. ⚠ **The deferral has no mechanism.** OI-285's Change Request route exists on
   paper and has never been applied; the client has been silent on it for four
   days.

⚠ **Source caveat.** Sabatino Rinaldi's mail **is not in this mailbox** and **its
date is unknown**; see the caveat on
[OI-242](OI-242%20The%20community%20Rinuncia%20button%20must%20show%20the%20public%20refusal%20text.md).
