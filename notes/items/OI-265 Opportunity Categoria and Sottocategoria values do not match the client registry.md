---
id: OI-265
type: open-item
status: open
owner: Elena Spini
with: Fabrizio Paganelli
org: both
raised: 2026-10-19
updated: 2026-11-12
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

## ⚠ 2026-11-02 - the fields were made read-only for the people who would fix them

🔴 **Unmoved an eleventh day.** The picklist workbook is still unopened and no value
change has been made.

⚠ **And the direction of travel reversed.** Commit `b0e69c5` on `DevAnita30`
(Anita Aga, 2 November 14:21 CET) sets `Opportunity.Categoria__c` and
`Opportunity.Sottocategoria__c` to **read-only for the `Agente` permission set and
the `Agente` profile** — see
[the permission change](../objects/The%20Agente%20permission%20set%20gained%20Mexal%20and%20Anticipay%20access.md).

🔑 **Nobody has connected the two.** The commit message calls it _"edits of agente
permission"_ and no source this sweep mentions these picklists at all. Making them
uneditable is not wrong on its own — the values are supposed to come from the
client's registry — but **the registry values have not been loaded**, so the result
is a mismatched picklist that the sales team can no longer correct.

## 🔑 2026-11-06 — the client finally answered, in a spreadsheet nobody asked for

**Elena Spini's 19 October question — _"ci sono i valori che ci avete condiviso
ultimamente, non vi torna?"_ — has an answer eighteen days later.** It is rows 1 and
2 of `Modifiche flussi Sales`, the change list Marco Montesi shared on 6 November at
10:03Z →
[OI-344](OI-344%20The%20client%20sent%20sixteen%20Sales%20flow%20changes%20and%20none%20is%20triaged.md):

| Macro | Activity |
| --- | --- |
| Categorie | _"Lista voci incompleta → **lista completa gia inviata** + compilazione da rendere obbligatoria"_ |
| Sottocategorie | _"Lista voci incompleta → **lista completa gia inviata** + compilazione da rendere obbligatoria"_ |

🔑 **So the client's position is stated: the values in the org are incomplete, and
the complete list has already been sent.** ⚠ **He does not say when or to whom**, and
the picklist workbook this record has been waiting for is now **fifteen days** owed.
The disagreement is therefore still a disagreement about whose transmission is
current — but for the first time it is in writing from the client's side, and it is
Marco Montesi's claim, the same person Fabrizio Paganelli was quoting on 19 October
(_"Sentito Marco, i campi Categoria e Sottocategoria non sono aggiornati"_).

🆕 **And a new requirement rides on it: both fields must become mandatory.** That is
a register change if accepted, and it collides directly with the 2 November
permission change: `b0e69c5` made both fields **read-only** for the `Agente`
permission set and profile. 🔴 **A mandatory field the sales team cannot edit cannot
be filled**, so the two requests cannot both stand as they are.

**Still owed:** the complete value list as a file, identified; a ruling on the
mandatory request; and reconciliation with the read-only grant.

## 🟡 2026-11-12 - the values exist, ROMI had lost them, and a deletion list arrived

**The client's own file always carried the values. They were at the bottom of a
sheet and ROMI did not see them.** Elena Spini, on the
[12/11 internal call](../meetings/2026-11-12%20INTERNA%20Modifiche%20Marco.md):

> _"questi valori **ce li avevano gia dati**, questi qua che non ci sono … ma
> stavano in fondo qua sotto e boh, **ce li siam persi perche stava qua sotto**,
> pero li ho riordinati tutti sul primo s\[heet\], quindi tu basta che guardi qua e
> c'e tutto."_

She has rebuilt a readable sheet from the client's file, and the workbook is linked
from [the recap](../The%20Pienissimo%20recap%20of%20open%20changes.md) row 2
(`1eX-oOPwFW2M7emK7t2q7MgRF7z_Czptl`). ⚠ **Not opened by this run.**

### What was decided about the values

| Value | Action |
| --- | --- |
| `Altri servizi` | 🔴 **remove** — _"vogliono solo cassa zucchetti"_ |
| `Generica` | 🔴 remove — _"Mi sa che generica pure l'abbiamo tolto"_, to be verified |
| `Cassa Zucchetti` | 🟢 keep |
| `Libro` | 🆕 **missing, to add** — _"Libro manca sicuro"_ |
| `Pacchetti` | 🆕 to add — _"Pacchetti non c'era"_ |
| `Corso` | 🟢 already correct |

🔑 And the dependency question was settled: there is **no filtering between
categoria and sottocategoria** — _"Fammi vedere tutti i valori possibili senza
nessun filtro"_ — which Aurel Mrruku noted still means every value must be enrolled
in the dependency.

Committed to the client as row 2 of the recap, **Da implementare, inizio settimana
prossima**.

### What is still owed

🔴 **The mandatory-versus-read-only collision is unresolved.** Rows 1 and 2 of
`Modifiche flussi Sales` still read _"lista completa gia inviata + **compilazione da
rendere obbligatoria**"_, both `IN LAVORAZIONE`, and nothing addresses making a
field mandatory that the integration also writes.

🟢 **A separate list did arrive complete**: the eleven lead-source values, with
usage rules → [the lead source values](../The%20Pienissimo%20lead%20source%20values.md).
That is a different picklist and does not close this item.
