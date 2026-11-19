---
id: OI-348
type: open-item
status: open
owner: Elena Spini
with: Gianpaolo Motta
org: ROMI
raised: 2026-11-09
updated: 2026-11-19
depends_on: [OI-308]
blocks: []
source: notes/meetings/2026-11-09 INTERNA Review temi Fase 2.md
---

# OI-348 - Fase 1 post go-live support is unassigned and unpriced

**Users start on Salesforce on 16 November. The technical lead asked on
9 November who will support them, expecting to be on calls with the client most of
the day. The project manager's answer was that the line had been dropped from the
slides, that it has to go back in, and that she never told the client it was
there.**

## The exchange

[The 09/11 internal review](../meetings/2026-11-09%20INTERNA%20Review%20temi%20Fase%202.md):

> **Aurel Mrruku:** _"23 secondo te **non ci sarà supporto post go live**? Ne
> avete parlato di supporto post go live? Chi farà il supporto post\[\]… vedrai
> saranno almeno 23 ore di colla\[call\] al giorno con loro."_
>
> **Elena Spini:** _"Tra l'altro qua dentro non… **qua non l'aveva più messo.** …
> Sì, sì. E lo dobbiamo mettere. **Non gliel'ho detto, alla fine non l'ha
> promesso.**"_

⚠ **The numbers in that quote are unreliable.** _"23"_ reads as a date in context
and _"23 ore"_ cannot be literal; the transcript is auto-generated. **The
substance — that nobody is assigned and nothing is priced — is not ambiguous.**

## Why this is not OI-308

[OI-308](OI-308%20Fase%202%20maintenance%20was%20left%20out%20of%20the%20estimate.md) is
about **Fase 2 maintenance**, and as of 9 November both Fase 2 documents carry a
maintenance line. **This is Fase 1**, after the 16 November operational start, and
it sits in neither document:

- The **offer** gives _"un mese di supporto post go-live"_ **after the last Fase 2
  release**, i.e. from April 2027, and `10 giornate` of release maintenance
  spanning **R0 to R6** — Fase 2 releases, not Fase 1 operation.
- The **project plan** timeline carries a band labelled _"Supporto post go-live
  Fase 1"_. ⚠ **No days are attached to it on the estimate slides**, where every
  other line has a figure.

🔴 **So the only Fase 1 support that is costed anywhere is a band on a timeline.**

## Why it matters now

1. 🔴 **The date is seven days away** and the support need is at its maximum: six
   tutors trained on 9 and 11 November, invoicing from 16 November, full stage
   sales on 26 November, and the marketing flows still switched off until the
   12-13 November delta ([OI-244](OI-244%20Historical%20orders%20will%20be%20migrated%20from%20Mexal%20by%20spreadsheet.md)).
2. 🔴 **It collides with the resourcing statement made in the same half hour** —
   Aurel Mrruku is committed to another large project and absent 17-22 December
   ([OI-349](OI-349%20Fase%202%20has%20no%20developer%20committed%20for%20December.md)).
   **The person expecting to do the support is the person who says he has no
   capacity.**
3. 🔑 **Aurel Mrruku told the client on the same day that production maintenance
   takes priority over Fase 2 development** — reported in
   [the client review](../meetings/2026-11-09%20Review%20temi%20Fase%202.md). That is
   a commitment about sequencing made without a costed line behind it.
4. 🔑 **It lands on an exhausted margin**, like OI-308 — see
   [the decision](../decisions/Decision%20-%20new%20scope%20after%2026%20October%20goes%20to%20Fase%202.md).

## What is owed

- A named person on Fase 1 support from 16 November, and their availability.
- A costed line, in whichever document the client signs, or an explicit decision
  that it is absorbed.
- Whether Gianpaolo Motta has been asked. Elena Spini said _"dovrò capire con
  Giampaolo"_ about capacity generally; ⚠ **nothing records her doing so.**

## 2026-11-16 - the project manager is on leave for the go-live week

🔴 **Elena Spini is away from the first day of real use.** In the ROMI DM on
13/11 at 18:15-18:18 CET, closing the week:

> **Elena Spini:** _"ciao Aurel, **ci vediamo il 19**"_ · _"in bocca al lupo con
> quei pazzi"_ · _"buon weekend"_
>
> **Aurel Mrruku:** _"buon divertimento"_

Earlier the same day she named the pressure herself: _"**ansia pre-ferie** di
chiudere tutto."_ The 19th is the
`[ROMI-PIENISSIMO] - Test Finale Flusso MKT` call at 09:30.

🔴 **She was absent from the 16/11 go-live call**, which ran two hours and
eighteen minutes with six people, settled a reschedule, changed four production
picklists and left a WooCommerce failure open. The written trace of that morning is
the transcript and this vault; nothing was minuted to her.

So for 16, 17 and 18 November the only ROMI presence on this project is the
developer, who is also carrying the 18 November release and the Friday change list.
**Fase 1 post go-live support remains unassigned and unpriced**, and the week it
was meant to cover has begun.

Her own closing estimate, from the 13/11 status post: _"go-live per gli utenti il
16/11/2026. Per la chiusura totale puntiamo a **fine mese**"_ ·
_"**stima giornate a finire: 12 gg**, invariata causa nuove richieste lato
cliente."_

## 🔴 2026-11-19 - the project manager is back, and barred from the client

**Elena Spini returned from leave on 19 November, as her out-of-office said she
would. On her first day back she learned of the PEC and was stood down from
client contact.**

Her own words on [the 19/11 internal call](../meetings/2026-11-19%20INTERNA%20Check%20temi%20PEC.md):
_"**ormai non posso piu parlare con il cliente**"_ — confirmations now go through
**Giancarlo** and **Angelo**. ⚠ Neither surname is established from a primary
source. See [OI-375](OI-375%20Pienissimo%20sent%20a%20PEC%20contesting%20the%20implementation%20and%20suspending%20the%20go-live.md).

🔴 **So the support question this item asks is now worse, not better.** The
person who owns the client relationship cannot use it, and no replacement
counterpart is named anywhere. The unpriced, unassigned Fase 1 support continues
against a client that has placed ROMI in default.

🟡 She describes her first day back as spent on the rebuttal document rather than
on the project: _"adesso mi sto facendo sta rottura di … sto documento."_ The
chain of events she gives: Gianpaolo Motta called her on **18/11**, during her
last day of leave, for an urgent call with Angelo and Andrea G.; she held that
call on the afternoon of 18/11.
