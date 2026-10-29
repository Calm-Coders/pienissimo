---
id: OI-299
type: open-item
status: open
owner: Elena Spini
with: Fabrizio Paganelli
org: both
raised: 2026-10-29
updated: 2026-10-29
depends_on: []
blocks: []
source: Gmail 1a18754d1f496ff6
---

# OI-299 - Bundle creation offers the wrong Anno Accademico values and too few Bundle Type values

**Testing bundle creation on the morning of 29 October, the client found that the
`Anno Accademico` field still offers calendar years, and that `Bundle Type` holds
only two values where the business needs more. He also asked for a wider creation
screen. ROMI split the three: the field work was accepted, the layout change was
pushed into a batched release.**

## The report

Fabrizio Paganelli, Gmail `1a18754d1f496ff6`, **2026-10-29 11:04:03Z**, to Aurel
Mrruku and Elena Spini, cc `amministrazione@pienissimo.com`:

> _"questa mattina sto facendo test di creazione bundle, vi segnalo di segui in
> paio di cose:_
>
> _Nella creazione del Bundle **è rimasta la selezione dell'anno solare nel campo
> Anno Accademico**. Bisognerebbe sostituire_
>
> _Inoltre **nel Bundle Type dovremmo aggiungere una o più voci** oltre a "Anno
> con Pienissimo" e "Anno con Pienissimo ripetente"_
>
> _Per visualizzare meglio tutti i campi, le schermate di creazione dei bundle si
> possono impostare con **una forma a rettangolo, tipo 16:9**?"_

⚠ Three PNG attachments (`image001.png`, `image002.png`, `image003.png`) ride with
the mail and **were not opened**; they are screenshots of the screens he is
describing.

## The three asks, and what is missing from each

1. 🔴 **`Anno Accademico` still offers the calendar year.** An academic year is not
   a calendar year, which is why the field exists. ⚠ **He does not say what should
   replace the values**, only _"bisognerebbe sostituire"_. Nobody has proposed the
   replacement set.
2. 🔴 **`Bundle Type` needs values beyond the two in place.** The two he names —
   `Anno con Pienissimo` and `Anno con Pienissimo ripetente` — are the only ones
   he sees. ⚠ **He does not say which to add**, and _"una o più voci"_ does not
   bound the work.
3. 🟡 **A 16:9 bundle-creation screen**, so all fields are visible at once. This is
   a layout request, not a data one.

🔑 **The first two are picklist content, the third is layout** — and ROMI treated
them differently, which is the whole of the handling below.

## How ROMI handled it

Elena Spini, Slack DM `D0B5QHS2T7H`, **2026-10-29 12:17:33 CET**:

> _"richieste di Fabrizio thread: Bundle --- **per la parte del campi np no?** -
> la cosa della vist "forma a rettangolo, tipo 16:9" - **se è veloce ok se no
> rimandiamo**"_

Aurel Mrruku, **12:18:48 CET**:

> _"no elena **non prendiamo altri requisiti sulla UI** che diventa un casino.
> chiedi tutte le modifiche che vogliono e **facciamo in un unico rilascio**"_

Elena Spini in thread, **13:03:07 CET**: _"lo aggiungiamo al file che ho chiesto di
fare a Marco allora"_.

So the field changes were waved through as unproblematic (_"np"_) and the layout
request went into the batched UI release —
[the decision](../decisions/Decision%20-%20UI%20changes%20are%20batched%20into%20one%20ad%20hoc%20release.md).

## Why it is open

1. 🔴 **Nothing is built and no values are agreed.** Both picklist asks are
   underspecified by the person asking, and the record contains no proposal back
   to him.
2. ⚠ **Whether the fault is the value set or the screen is not established.** A
   `Campaign.Anno_Accademico__c` field was built on 28/10; this report is about the
   **bundle** creation screen. Whether that screen points at the wrong field, or
   the right field carries calendar-year values, needs the org — **which was not
   opened in this run.**
3. ⚠ **The layout ask now has no date**, because the release it was assigned to has
   none.
