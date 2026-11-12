---
id: OI-358
type: open-item
status: open
owner: Aurel Mrruku
with: Elena Spini, Marco Montesi
org: both
raised: 2026-11-12
updated: 2026-11-12
depends_on: []
blocks: []
severity: high
source: notes/meetings/2026-11-12 INTERNA Modifiche Marco.md
---

# OI-358 - The org is not set to Italian date and number formats

**The tutors found at training that dates render in American order, the decimal and
thousands separators are the wrong way round, and the Community prints the euro
symbol with no space. The org locale was never set, in a project whose users work
in Italian throughout. It is the first row of the client-facing recap sheet and is
due at the start of next week.**

## What is wrong

From the [12/11 internal call](../meetings/2026-11-12%20INTERNA%20Modifiche%20Marco.md),
Elena Spini reading her training notes:

> _"tutte le date … anche qua novembre 11 e anche le date, il formato data a livello
> di **tranche** e in formato americano. invece lo vogliono italiano perche se non
> capiscono."_

| Surface | Defect |
| --- | --- |
| Dates, everywhere including the tranche screens and the Community | American order |
| Numbers | decimal and thousands separators inverted — _"cambiare la virgola con il punto, cioe opposite"_ |
| Community, currency | no space between the number and `€` — _"aumentare lo spazio con euro e il numero ovunque"_ |
| Quote expiry | ⚠ a note reading _"data scadenza transformato EU"_ that Elena Spini could not interpret |

## The fix and its one risk

🟢 Aurel Mrruku: _"devo **abilitare il formato italiano nella ORG**. … non e una
cosa molto difficile. In teoria non dobbiamo avere problemi."_

🔴 **The risk is the custom code**: _"I problemi li abbiamo poi se abbiamo fatto
delle cose custom, quindi abbiamo messo … su qualche componente LWC un riferimento
custom della data."_ Elena Spini named the place at once — _"Mi viene in mente la
cosa dei prodotti. **Aggiungi prodotti**"_ — and they agreed the sweep must cover
every surface, not just the one complained about: _"non lo facciamo solo qua, ma lo
facciamo dappertutto."_

The candidates to check are the quote product LWCs rebuilt for
[OI-330](OI-330%20The%20product%20selection%20screen%20is%20unusable%20for%20multiple%20products.md)
(`quoteManageProducts`, the `QuoteManageProductsModal` resource) and the tranche
screens.

## Why nobody caught it

⚠ Asked and unanswered on the call. Aurel Mrruku: _"**Come mai ci e sfuggito sta
cosa?**"_ Elena Spini: _"non so manco, cioe, boh, io manco me ne so accorta …
pero si, considerando che usano un sal\[es\]force in italiano potevamo
ar\[rivarci\]."_ Aurel Mrruku: _"**Hanno anche ragione.**"_

🔑 It was raised by the **users**, at training, five days before they start — not
by any test, review or acceptance step.

## Committed to the client

Row 1 of `Pienissimo_Recap_Modifiche_2026-11-12.xlsx`, sent 12/11 18:43Z:

> _"Formato italiano ovunque: date (anche nelle tranche e nella Community),
> separatore delle migliaia e dei decimali, spazio tra numero e simbolo € nella
> Community"_ — **Da implementare**, _"Abilitiamo il formato italiano a livello di
> org e verifichiamo tutti i componenti con riferimenti custom alla data (es.
> Aggiungi prodotti)"_, **Inizio settimana prossima**.

## What is owed

- The org-level locale change, plus a pass over every custom component that formats
  a date or an amount.
- A decision on whether this lands before or after the 16/11 start: the commitment
  says _"inizio settimana prossima"_, which is **after** the users begin.
