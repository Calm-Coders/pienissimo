---
id: OI-308
type: open-item
status: open
owner: Elena Spini
with: Aurel Mrruku
org: ROMI
raised: 2026-10-30
updated: 2026-11-09
depends_on: []
blocks: []
source: notes/meetings/2026-10-30 Rapido Allineamento Aurel Elena.md
---

# OI-308 - Fase 2 maintenance was left out of the estimate

**The Fase 2 estimate has gone to the person preparing the commercial offer, and
it carries no maintenance line. The technical lead expects at least three to four
days a month and warns that a day-a-week retainer is not priced like scattered
hours. The omission was noticed after the estimate was sent.**

## The omission

[The 30 October internal alignment](../meetings/2026-10-30%20Rapido%20Allineamento%20Aurel%20Elena.md),
around `00:17:00`. Aurel Mrruku raises maintenance — _"ci io non la vedo bene
perché sto avendo delle brutte esperienze con un altro progetto"_ — and Elena
Spini answers:

> _"In realtà **questa me la sono dimenticata di mettere**, però gliela dico
> subito a **Andrea Galotto** che gli avevo mandato la stima."_

🔑 **This names the Andrea.** The Fase 2 estimate went to **Andrea Galotto**, who
per Elena Spini's `#tproj-pienissimo` recap of the same day _"sta preparando
l'offerta"_. These records have carried _"which Andrea"_ as an open question since
the estimate was first mentioned.

## The sizing Aurel Mrruku gives

> _"io mi aspetto almeno … 3-4 giorni al mese di manten[enza] con loro. Quando dico
> almeno, quindi un un giorno a settimana."_

And the pricing warning, which is the substance of it:

> _"nel momento in cui te metti un giorno a settimana **non ha lo stesso costo se
> fai un'ora al giorno o fai 4 ore al giorno** … **fai un passaggio anche con chi
> decide i prezzi** perché forse cambia qualcosa a livello di prezzo."_
>
> _"fare un giorno a settimana, ma mi chiami 30 volte durante il giorno è più di un
> giorno a settimana."_

He would price **four days a month, one a week**, at least for the first period.
Elena Spini: _"da quello che sto capendo non penso [cambi], però mi informo con
Giampaolo."_

## Why it is open

1. 🔴 **The estimate was already sent without it.** Correcting it means going back
   to Andrea Galotto while the offer is being written.
2. ⚠ **Nothing records that Elena Spini did go back to him.** She said _"gliela
   dico subito"_ at about 10:18 CET; no later message, mail or recap in this
   sweep's sources mentions maintenance.
3. 🔑 **It lands on an exhausted margin.** Gianpaolo Motta ruled on 26/10 that the
   project has no margin left to absorb anything — see
   [the decision](../decisions/Decision%20-%20new%20scope%20after%2026%20October%20goes%20to%20Fase%202.md).
   A maintenance line omitted from Fase 2 has nowhere to fall back to.
4. ⚠ **The billing model is undecided, not just the number** — days against hours,
   and whether a retained day carries a minimum.

## Related

- [The Fase 2 estimate](../The%20Fase%202%20estimate.md)
- [Gianpaolo Motta](../people/Gianpaolo%20Motta%20-%20ROMI%20staffing%20authority.md)

## 🔴🔑 2026-11-02 - the offer now exists, still has no maintenance line, and the client was told it does

Three facts from one day, and they do not fit together.

1. 🟢 **The offer exists.** `Pienissimo Offerta Fase 2` was created by **Andrea
   Galotto** at 09:21Z on 2 November and last touched 14:45Z — see
   [the Fase 2 offer](../The%20Fase%202%20offer.md). Elena Spini's
   `Pienissimo_Project_Plan_Fase2` was updated the same morning at 09:40Z.
2. 🔴 **Neither document prices maintenance.** The offer's only recurring
   commitment is _"un mese di supporto post go-live"_ per release; the plan's only
   recurring line is per-release UAT, bug fixing, deploy and training at 7-9 days.
   **There is no retainer, no monthly allowance, no hourly rate.**
3. 🔴 **Elena Spini told the client, on the record, that there is.** On
   [the 09:32 call](../meetings/2026-11-02%20Tema%20Contratti%20WooCommerce.md):
   _"C'è anche la parte di maintenance nella proposta, però è sempre tutta una
   proposta che va confermata. Sto facendo la proposta Andrea."_

🔑 **And the size moved by a factor of six in three days, from the same person.**
Aurel Mrruku told the client on 2 November it would be _"quei **8 ora al mese** in
cui potete chiedere qualsiasi cosa, possiamo fare tutti [gli] interventi che
volete"_. On 30 October he put it at **three to four days a month** and warned
that a retained day is not priced like scattered hours. **Eight hours a month is
roughly one day.** ⚠ **Nobody reconciled the two, and the lower figure is the one
the client has heard.**

🔑 **The offer's own value-add may be what Elena Spini meant** — one free month of
support after each release. ⚠ **If so, it is support, not maintenance, it is
time-boxed per release, and it ends.** The arrangement Aurel Mrruku described —
_"anche dopo, anche se non ci sono sviluppi"_ — is ongoing and is in no document.

🔴 **The deadline is now hard.** The project plan sets _"Approvazione Fase 2 entro
il 13/11"_, so whatever the client approves on 13 November is what the maintenance
arrangement is. ⚠ **Nothing records Elena Spini going back to Andrea Galotto** — a
third day.


## 🟢🔑 2026-11-09 - maintenance is now in both documents, at ten days

**The omission is closed as an omission.** Both Fase 2 documents, as modified on
9 November, carry a maintenance line:

| Document | The line |
| --- | --- |
| `Pienissimo Offerta Fase 2_V.4` (Andrea Galotto, created 20:34Z) | A whole slide, **`Maintenance di rilascio`**, _"COPERTURA **10 giornate, da R0 a R6**"_, priced as its own item beside the seven releases |
| `Pienissimo_Project_Plan_Fase2` (modified 14:15:44Z) | A new estimate row, **`Maintenance`** — _"2 giorni al mese (fino ad aprile)"_ — at **`10`** gg, and the per-release transversal line raised from `7 - 9` to **`9 - 11`** gg |

🔑 **The ten days were agreed in the internal half-hour that morning.** Elena
Spini, in [the 09/11 internal review](../meetings/2026-11-09%20INTERNA%20Review%20temi%20Fase%202.md):
_"due giorni al mese da dicembre … per ora facciamo fino ad aprile"_ → _"forse
facciamo 10"_. **December to April at two days a month is ten days**, so the
figure and its derivation are both on the record for the first time.

🟢 **And the client was told it belongs in the documentation.** Per
[the client review](../meetings/2026-11-09%20Review%20temi%20Fase%202.md), Elena
Spini said _"occorre includere formalmente la gestione della manutenzione
all'interno della documentazione dei rilasci"_ — which is what the two documents
now do. The 2 November contradiction, where she told the client maintenance was in
a proposal that did not price it, is resolved by the proposal catching up.

### What the offer says about how it is consumed

> _"La maintenance di rilascio è **rendicontata a ogni SAL**; le attività **oltre
> le 10 giornate sono quotate a parte**."_

And the pre-existing value-add is unchanged and distinct: _"al termine dell'ultimo
rilascio è incluso senza costi aggiuntivi **un mese di supporto post go-live**."_

### 🔴 What is still wrong with it

1. 🔴 **It is below the figure Aurel Mrruku gave twice.** On 30 October he put it
   at **three to four days a month**; on 9 November he repeated the floor —
   _"Mant\[enenza\] deve prevedere **come minimo due giorni al mese, come minimo
   ogni mese**"_. Ten days to April is the minimum of his minimum, and it **stops
   in April** while he described an arrangement that continues _"anche dopo, anche
   se non ci sono sviluppi"_.
2. ⚠ **It is still not what the client heard.** On 2 November Aurel Mrruku sized
   it to Fabrizio Paganelli as _"quei 8 ora al mese"_ — about one day. **Nobody
   has corrected that to his face**, and the gap is now in a document he is asked
   to approve by **13 November**.
3. ⚠ **Whether the ten days sit inside or outside the offer's `150 giornate` is
   not stated.** The pricing slide lists maintenance as a separate line beside the
   seven releases, which reads as additional; the plan writes its total as
   `60 - 80 + 10`, which reads as additional too. **The offer never says.**
4. 🔴 **It is Fase 2 maintenance only.** Fase 1 support after the 16 November user
   start is in neither document with a figure against it →
   [OI-348](OI-348%20Fase%201%20post%20go-live%20support%20is%20unassigned%20and%20unpriced.md).

⚠ **Elena Spini going back to Andrea Galotto is finally evidenced** — the client
review assigns her _"Consultare Andrea per gestione stima"_ and the V.4 deck he
owns appeared that evening. **Whether the day total moved is a separate question,
and it did not: `150 giornate` is unchanged.**
