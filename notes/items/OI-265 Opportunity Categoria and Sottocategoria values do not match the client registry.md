---
id: OI-265
type: open-item
status: open
owner: Elena Spini
with: Fabrizio Paganelli
org: both
raised: 2026-10-19
updated: 2026-10-19
depends_on: [OI-96]
source: Gmail thread 1a154a97e004a741, 2026-10-19T14:55:54Z
---

# OI-265 - Opportunity Categoria and Sottocategoria values do not match the client registry

**Fabrizio Paganelli mailed within ten minutes of the walkthrough ending to say
the Opportunity `Categoria` and `Sottocategoria` picklists are out of date. Elena
Spini replied that they are the values Pienissimo itself supplied. Both are on
the record, neither has moved, and these two fields are the axis the client says
all its reporting runs on.**

## The exchange

**Fabrizio Paganelli, 19/10 14:55:54Z** (Gmail `1a154a97e004a741`), to Elena
Spini and Aurel Mrruku, cc Marco Montesi and `amministrazione@`:

> _"Sentito Marco, i campi Categoria e Sottocategoria non sono aggiornati"_

**Elena Spini, 15:10:55Z**, replying with a screenshot of the values in the org:

> _"ci sono i valori che ci avete condiviso ultimamente, non vi torna? I valori
> dell'excel per le picklist sono questi"_

🔴 **He did not answer that question.** His 16:10:07Z reply addresses only the
Wednesday meeting slot. **So the disagreement is open**, and it is a
disagreement about whose list is current, not about a build.

## What he had seen

The mail is the written form of a complaint he had been working through on the
open line after Elena Spini and Marco Montesi said goodbye
([the session](../meetings/2026-10-19%20Test%20UAT%20Commerciali.md),
`01:40:33`–`01:44:20`). He walked the values on screen and found them
inconsistent:

> _"altri servizi … cassa zucchetti[,] generica e corso. Questa che cos'è? …
> Vedi anche qui è sminchiata, non va bene. … Pacchetti non c'è dentro categoria,
> li abbiamo tolti."_

and described what the client's own convention is:

> _"oggi da noi è corso e c'è il nome del corso. Pacchetto e c'è il nome del
> pacchetto. La categoria è pacchetto, la categoria è corso e poi c'è il nome del
> corso."_

He closed with the expectation that it is a same-day fix: _"adesso sono tutte
sminchiate, domani saranno precise"_ — which is **not an undertaking anyone on
ROMI's side gave**, and is recorded as his words only.

## The second half: the opportunity name must not be the key

🔑 **This is the durable point in the exchange and it is a correction of the
client's own habit, made by the client.** The opportunity name is generated and
then editable, and Fabrizio Paganelli objected to anyone treating it as an
identifier:

> _"noi oggi stiamo andando a identificare le opportunità dal nome in questo
> momento. Ma infatti sbagliamo come facciamo oggi, perché noi abbiamo il vizio
> che lavoriamo sulle descrizioni come se fossero dei codici."_

> _"per fare le statistiche comanda la categoria e la sottocategoria, non il nome
> dell'opportunità … a livello di reportistica dopo si usa categoria sotto
> categoria."_

🟢 **So the requirement is clear even while the values are disputed:** reporting
is built on `Categoria`/`Sottocategoria`, the name is free text and
non-authoritative. That constrains every opportunity report and should be
written into the reporting design rather than left in a transcript.

## Why this has been coming

🔴 **The source list has never been in the repository.** The picklist workbook
`Mappatura_Categorie_Sottocategorie_Origine Lead_Tipologiattività.xlsx` has been
a mail attachment only for ten consecutive sweeps, and every nightly trace has
asked for it to be put in Drive. **Tonight the cost of that gap arrived**: the
client says the values are stale, ROMI says they match the workbook, and **no
party can point at a shared copy to settle it.**

⚠ **Elena Spini's reply embeds the values as an image**, so even the answer is
not in a form anything can diff.

## Open

- 🔴 **Nobody has reconciled the two lists.** One screenshot and one assertion.
- 🔴 **The workbook is still not in Drive** — ask Elisa Migliano or Elena Spini.
- ⚠ **Related but distinct**: Fabrizio Paganelli also said these fields are on the
  Opportunity and **not** on the article — _"sull'articolo non c'è la categoria
  sotto categoria, sono sulle opportunity"_ — and wondered whether they should be
  on the product too. Unresolved, and it bears on
  [OI-96](OI-96%20Edition%20mapping%20table%20on%20Salesforce.md).

## What closing it looks like

The workbook lands in Drive, the org values are diffed against it, the delta is
deployed, and the reporting design records that `Categoria`/`Sottocategoria` —
not the opportunity name — is the reporting key.
