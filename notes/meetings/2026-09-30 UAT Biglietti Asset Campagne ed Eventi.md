---
id: meeting-2026-09-30-uat-biglietti
type: meeting
status: active
owner: Elena Spini
org: both
raised: 2026-09-30
updated: 2026-09-30
uncertain: the speaker labelled only "Marco" (3 turns) is probably Marco Montesi but is not on the invitation by address
source: Drive, Appunti di Gemini + Trascrizione, 2026-09-30 14:00 CEST (doc 1yWV3m_ex8lhiPImgt0TwW5nPoGyctAra1gg_1XV9cEY, 127,631 characters, read in full)
---

# 2026-09-30 UAT Biglietti Asset Campagne ed Eventi

**The ticket UAT ran, the client attended, and the room produced five rulings —
one of which reverses a design ROMI agreed internally the day before, and one of
which changes the mapping table that has thrown three sandbox exceptions in a
week.** 30/09, 14:00 CEST, **~1h55m**.

**ROMI:** Aurel Mrruku · Elena Spini · Fabrizio Mastracci.
**Pienissimo:** Fabrizio Paganelli · Rebecca Marmo · Sabatino Rinaldi ·
Elisa Migliano · "Marco" (see `uncertain:`).

The session was scoped to the **backend upstream of the marketing flow** —
campaign structure, ticket handling, asset logic. Elena Spini opened by
confirming the **marketing flow proper was postponed to a later appointment**.

## 🔑 The payment gate is now a client directive, at tranche granularity

The session's hardest ruling, and Fabrizio Paganelli stated it as an
inderogable administrative directive: **no ticket, no QR code and no nomination
request may be sent unless the invoice for the relevant tranche has been
paid and collected in full.**

> _"Quella lì va impostato solo ed esclusivamente quando la fattura collegata
> quella tranche è stata integralmente pagata."_ (`01:29:09`)

🔑 **It resolves per tranche, not per order.** He drew the consequence himself
for multi-year and instalment bundles:

> _"i biglietti contenuti dentro un ordine bundle non è che si rendono
> disponibili quando tutto l'ordine bundle è stato incassato, perché sennò agli
> eventi non viene nessuno. All'interno di un ordine bundle i biglietti si
> rendono disponibili se i biglietti contenuti in quella tranche hanno una
> fattura e hanno un incasso."_ (`01:30:33`)

Elena Spini placed the burden of getting the dates right on the people who build
the bundles, not on the system: _"i tutor sanno che non possono vendere un
biglietto che sta con una tranche che è in mezzo… non deve essere un problema
nostro."_ Aurel Mrruku accepted the gate but flagged that **naming tickets and
sending tickets are two different processes** — _"stiamo parlando di nominare i
biglietti, non di inviare i biglietti perché sono due processi diversi"_.

The mechanism: marketing processes **only assets in `Disponibile`**, which is
_"la fattura saldata a livello di tranche"_, kept distinct from `Ordinato` and
`Assegnato` (`00:59:52`).
→ [OI-74](../items/OI-74%20Asset%20state%20machine.md),
[OI-75](../items/OI-75%20Ticket%20availability%20rule.md),
[OI-198](../items/OI-198%20The%20asset%20does%20not%20say%20which%20tranche%20paid%20for%20it.md)

## 🔑 The all-or-nothing send rule is dead — the client ruled the opposite

[OI-196](../items/OI-196%20Whether%20tickets%20are%20sent%20when%20the%20buyer%20names%20only%20some%20participants.md)
went onto the agenda asking whether a buyer who names three of five gets
anything. **The client's answer is that the three named tickets are sent and the
two unnamed ones are burned.**

Fabrizio Paganelli (`01:03:48`):

> _"il cliente ha comprato cinque biglietti, li ha già pagati tutti, però non ha
> le persone per venire. È chiaro che lo nomina, i biglietti vengono nominati
> solo per i tre che parteciperanno, gli altri due glieli bruceremo."_

Rebecca Marmo added that the unnamed two **stay `Disponibile`** so a buyer who
changes their mind can still use them.

🔑 **The reminder premise was also wrong.** The 29/09 design assumed an
indiscriminate daily reminder. Rebecca Marmo runs the sends with configured
delays and a completeness check:

> _"in realtà non continuo a ricevere comunicazioni di nominare anche gli altri
> due, perché io controllo anche se ha già effettuato delle iscrizioni"_ ·
> _"metto un ritardo orario che decido io di 2 5 7 8 10 giorni"_ (`01:02:22`)

Fabrizio Paganelli: the send is _"tra virgolette manuale"_ — automated, but
launched on a chosen day, stepped up near the event, **not fired daily by date**.

**This reverses the ROMI-internal all-or-nothing ruling of 29/09 and vindicates
the client's own written funnel exit rule**, which the 29/09 room never raised.
→ [OI-196](../items/OI-196%20Whether%20tickets%20are%20sent%20when%20the%20buyer%20names%20only%20some%20participants.md)
(resolved), [OI-126](../items/OI-126%20An%20asset%20flag%20for%20incomplete%20participant%20data.md)

## 🔑 The mapping table's windows become the competenza dates

Fabrizio Paganelli objected to associating article codes that run across years to
single editions, and proposed sourcing the mapping window from the **campaign's
data inizio / fine competenza** rather than the event's own dates:

> _"potresti riprenderle anziché da data inizio evento a data fine evento, da
> data inizio competenza a data fine competenza… sarebbero l'intervallo iniziale
> finale che se un ordine è compreso in quell'intervallo di date, l'ordine con
> quel codice prodotto deve confluire nella campagna"_ (`00:29:10`, restated
> `00:34:10`)

Aurel Mrruku accepted it and costed it at **half a day**: _"per me è in metà
giornata ti cambia la logica perché c'ho già tutti gli elementi."_ He also said
he would search on the **parent** campaign rather than the child (`00:30:31`).

🔴 **He named the cost, and the client accepted it:** under this model
_"non possiamo avere diversi biglietti su diverse edizioni sullo stesso ordine"_.
Fabrizio Paganelli: _"Ma infatti deve essere così."_ **That reverses the
per-order-line multi-edition property he himself confirmed on 26 August.**
→ [OI-96](../items/OI-96%20Edition%20mapping%20table%20on%20Salesforce.md)

## 🟢 Campaign hierarchy confirmed as built

Event-type campaign is the **parent**, edition-type the **child** — agreed by
Elena Spini, Fabrizio Paganelli, Elisa Migliano and Rebecca Marmo (`00:05:31`).
Child campaign fields exercised live: competenza dates, event dates, anno
accademico, luogo, indirizzo, and the **marketing communication start date**
(`00:07:59`).
→ [the campaign parent and child model](../objects/The%20campaign%20parent%20and%20child%20model.md)

## 🔴 Multi-day events are still unresolved, and one is seven weeks out

Rebecca Marmo asked what `data evento` holds for a three-day event. Elena Spini
deferred: _"quella parte la dobbiamo ancora un po' sviscerare bene."_

The facts the room established (`00:17:09`–`00:18:31`):

- **Pienissimo Live starts 24 November and runs three days** (24/25/26).
  Today there is **one check-in**: the ticket is scanned on day one and
  _"gli vale per tutti e tre i giorni"_.
- **Mastery is split across two months**, April and May, three consecutive days
  in each — and its ticket must give **multiple entries**.
- The _ingressi_ option exists so direction **could** require a check-in on every
  day. Not decided.
→ [OI-146](../items/OI-146%20Ingressi%20structure%20for%20multi-day%20events.md)

## 🟢 The rinuncia button rule is settled

Sabatino Rinaldi closed it (`01:44:11`): _"lasciamolo lì e nel momento in cui lui
nomina almeno un biglietto, quel tasto sparisce e abbiam finito."_ Rebecca Marmo
had explained its purpose — to stop the reminder ladder for a buyer who does not
intend to name anyone. Fabrizio Paganelli's fallback for the rest: _"tanto quelli
lo vediamo alla fine dell'evento, non ha partecipato."_

⚠ **This settles the button, not the picklist.** Whether `Rinuncia` is an Asset
state remains the open question
[OI-74](../items/OI-74%20Asset%20state%20machine.md) has carried since 19 August;
nobody put it in those terms.

## 🟢 Signed-but-unpaid quotes get a procedure

Rebecca Marmo raised quotes tutors sign and never pay, leaving assets in
`Ordinato` from October to May. Fabrizio Paganelli: the order is generated on
acceptance and signature and **the invoice is issued immediately, regardless of
collection** (`01:51:15`). On agreed withdrawal, a **credit note** is issued and
the asset moved to a dedicated cancelled state for traceability (`01:52:25`).
→ [OI-157](../items/OI-157%20Credit%20notes%20and%20storni%20are%20unbuilt%20and%20undefined.md)

## 🟢 Last-minute payments get a mechanism

Elisa Migliano reported the common case of clients paying the day before an
event. Sabatino Rinaldi proposed **tags on Salesforce maintained by nightly
asynchronous jobs** to detect payment and admit the customer to the marketing
flow, with a **manual override** of the tag for purchases right against the event
(`01:23:50`, `01:27:02`). Aurel Mrruku confirmed it is feasible while flagging
the complexity of tranches, invoices and Marketing Cloud tracking.

## Commitments taken

| Who | What |
| --- | --- |
| Fabrizio Paganelli · Elena Spini | Map products to campaigns/editions by hand in Salesforce |
| Elena Spini | Send Aurel Mrruku the updated product list for database cleanup, plus the missing new articles |
| Aurel Mrruku | Create a **flag field tracking sent tickets** so marketing can filter |
| Aurel Mrruku | Supply Fabrizio Mastracci the technical spec of that ticket field |
| Fabrizio Mastracci | Update the marketing flow to intercept the **single ticket row** on the new filter |
| Elena Spini | Configure the rinuncia button to disappear after the first nomination |
| The group | Update the ticket operating flow and present the final version next session |

🔴 **No date is attached to any of them.**

## Next

**Friday 02/10, WooCommerce live**, with Sabatino Rinaldi, Elisa Migliano and
"Marco" — consistent with the 02/10 re-test already on the record
([OI-181](../items/OI-181%20Stage-sale%20bundles%20need%20their%20tranches%20defined%20at%20bundle%20creation.md)).

## Not established here

- ⚠ **The participation document of [OI-194](../items/OI-194%20The%20ticket%20is%20a%20signed%20participation%20document%20not%20just%20a%20QR%20code.md)
  was not discussed.** The demo showed _"il documento contenente i dati del
  partecipante e un codice QR"_ (`01:46:15`); nothing in the session addresses the
  seven-page enrolment pack or the 26 June artifact. **Gating, and untouched.**
- ⚠ **Mobile was not raised**, so [OI-195](../items/OI-195%20WhatsApp%20sends%20imply%20a%20mobile%20community%20that%20was%20never%20designed.md)
  is unmoved.
- ⚠ No sandbox exception was reported in the session; the 29/09 `PIENISSIMO LIVE
  LIVE` mapping failure was not mentioned.
