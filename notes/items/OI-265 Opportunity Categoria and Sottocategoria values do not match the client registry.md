---
id: OI-265
type: open-item
status: open
owner: Elena Spini
with: Fabrizio Paganelli
org: both
raised: 2026-10-19
updated: 2026-10-23
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


## 2026-10-21 — the client's commercial lead says the file went astray

🟡 **First movement in two days, and it points at the workbook, not the values.**
Marco Montesi replied on the `Opportunity` thread at **15:39:56Z** (Gmail
`1a15f1e833a5d293`), two days after Elena Spini's screenshot of the picklist
values went unanswered:

> _"Ciao Elena, chiedo a @Elisa se ti può rimandare il file, qui deve essere
> saltato qualcosa."_

So the client's reading is that **the file they sent is not the file ROMI holds**
— _"qui deve essere saltato qualcosa"_ — and Elisa Migliano is asked to resend it.
That is consistent with the standing finding here: the picklist workbook has only
ever existed as a mail attachment, so neither side can point at a shared copy and
check.

⚠ **Nothing is resolved.** No file has arrived, no values are reconciled, and
🔴 **the workbook is now unshared for a twelfth consecutive sweep.** The message
also does not say which values are wrong — it assumes a transmission problem
rather than naming a discrepancy.

⚠ **Marco Montesi's reply does not go to Aurel Mrruku's address as a recipient**;
he is cc'd. The ask lands on Elena Spini and Elisa Migliano.

🟡 **This is the cheapest open item on the project to close** — one shared Drive
link in place of an attachment — and it has survived twelve sweeps.

## 🟢 2026-10-22 — the workbook arrived, and ROMI cannot use it

**After thirteen consecutive sweeps asking for it, the picklist workbook was
sent.** Elisa Migliano, from `amministrazione@pienissimo.com`, **07:42:18Z** on
the same `Opportunity` thread (Gmail `1a1628f97114b701`), to Elena Spini, cc
Aurel Mrruku, Fabrizio Paganelli and Marco Montesi:

> _"Allego nuovamente il file, all'interno di esso sono presenti tutte le
> specifiche"_

The attachment is
**`Mappatura_Categorie_Sottocategorie_Origine Lead_Tipologiattività.xlsx`** —
the same filename this row has been naming since 19/10. It answers Marco
Montesi's 21/10 _"qui deve essere saltato qualcosa"_: the file was resent, not
corrected.

🟢 **So the twelve-sweep "unshared" finding is closed.** ⚠ **But it is still a
mail attachment, not a Drive document** — nothing shared, nothing linkable,
nothing diffable, which is the condition this row has been asking to change.

### 🔴 And ROMI's reading of it is that it is unusable

Elena Spini to Aurel Mrruku in DM the same morning, **10:40:26 and 10:41:06
CEST**:

> _"poi ti chiederei anche di chiedergli info sul file che ci ha girato Elisa -
> thread >> **Opportunity**"_

> _"vogliono cambiare i valori di un campo picklist su lead e opty ma quel file
> fa cagare quindi capire che vogliono"_

Aurel Mrruku, 11:26:54: _"appena ho del tempo do un'occhiata"_. ⚠ **Unanswered
at the time of this sweep, and nobody has replied to Elisa Migliano.**

🔑 **This is a different problem from the one this row opened with.** The dispute
was whose list is current. The answer now on the record is that the client's own
source file does not state it clearly enough for ROMI to act — so neither list
can be called current, and the reconciliation this row waits on cannot be done
from the artifact that was supposed to settle it.

⚠ **The workbook's contents are not recorded here.** This sweep has no tool that
reads a Gmail attachment; its existence, filename, sender and date are recorded,
its values are not. The mail also carries eight inline images and a
`~WRD0003.jpg`, all unopened.

### Where that leaves it

- 🟢 The file exists and is identified, with a message id anyone can open.
- 🔴 **Nobody has gone back to the client to ask what they actually want**, which
  is now the single blocking step and sits with Aurel Mrruku by Elena Spini's
  own request.
- 🔴 The values are still unreconciled, **fourteen days after the complaint**.
- ⚠ Still not in Drive.

## 2026-10-23 - nothing moved, second day

🔴 **No reply to Elisa Migliano**, whose workbook arrived 22/10 at 07:42:18Z.
🔴 **The question to the client Elena Spini assigned to Aurel Mrruku on 22/10 —
_"capire che vogliono"_ — is still unasked.** Nothing on the `Opportunity`
thread (`1a154a97e004a741`) since 22/10, no Slack message about it, and the
23/10 client call did not raise it.

⚠ **The workbook is still unopened** —
`Mappatura_Categorie_Sottocategorie_Origine Lead_Tipologiattività.xlsx`, a Gmail
attachment, and this procedure has no tool that fetches one. 🔑 **It is still an
attachment and not a Drive file**, so nobody can read it without going through
the mailbox.

🔑 **A near miss worth recording.**
[The 16:00 call](../meetings/2026-10-23%20Import%20Ordini%20Migrazione.md) spent
six minutes on `categoria` values with Fabrizio Paganelli — and **on the other
registry.** The Mexal `categoria statistica` that identifies an event and the
Opportunity `Categoria`/`Sottocategoria` picklists are different things;
**nobody connected them, and nothing says whether the client's workbook bears
on both.** Recorded as an open question, not as a link.
