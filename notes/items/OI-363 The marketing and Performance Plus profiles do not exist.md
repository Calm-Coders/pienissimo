---
id: OI-363
type: open-item
status: open
owner: Aurel Mrruku
with: Elena Spini, Fabrizio Paganelli, Rebecca Marmo
org: both
raised: 2026-11-12
updated: 2026-11-12
depends_on: [OI-356]
blocks: [go-live]
severity: gating
source: notes/meetings/2026-11-12 Check Pre-Import.md
---

# OI-363 - The marketing and Performance Plus profiles do not exist

**Two of the client's three business functions have no Salesforce profile. Both
were specified on 12 November and both are scheduled to be built the week after
the client's users start work on 16 November.**

## The two profiles

### Marketing — Rebecca Marmo, `marketing@pienissimo.com`

What it must do, from Fabrizio Paganelli: _"La Rebecca deve gestire le campagne, le
edizioni, **l'invio dei biglietti**"_, and _"marketing deve vedere **tutto**"_, but
_"Non e una venditrice, **non deve creare ordini**"_ — read access to Sales, edit on
Campaign and the editions.

🟢 Aurel Mrruku's route: the Marketing app is already separate — _"Rebecca entrera
sull'app di marketing … Aggiustiamo l'app di marketing"_ — plus profile visibility
on the Sales app so she can see what happens there. Sabatino Rinaldi confirmed the
requirement: _"ha accesso anche al CRM … tutto quello che succede in sales."_

⚠ The mailbox is not finally settled: Elena Spini raised a possible clash with a
third-level marketing domain and checked DNS on the call without concluding —
_"non vorrei che va in conflitto questa cosa"_, _"Non sto vedendo i DNS"_.

### Performance Plus — a shared mailbox

What it must do, from Sabatino Rinaldi: _"deve poter **vedere la parte sales** e
l'unica modifica che puo fare e **sui contratti** … deve essere collegato
esclusivamente a tutto cio che e il mondo Performance Plus."_ Fabrizio Paganelli
added the specific field: _"devono anche avere la possibilita di modificare quella
famosa **data attivazione**."_ Explicitly **not** an admin: _"Deve fare no admin."_

🔑 **The scoping was argued and settled the pragmatic way.** Aurel Mrruku pointed
out that orders carry no type distinction — _"noi non abbiamo una distinzione di
tipologia di ordine"_, only quotes do (`offerta plus` against `offerta standard`) —
so restricting the view to Performance Plus orders is not possible. Elena Spini
closed it: _"Gli facciamo vedere tutto con diritto di non … modifica, e basta,
perche sennò vedono le cose a pezzi e non ha senso."_ Agreed.

## The timing problem

🔴 Aurel Mrruku: _"**Non ce l'ho ancora un profilo, pero lo posso fare tra settimana
prossima.** Lo posso fare senza problemi."_

Elena Spini's summary of the outcome: _"settimana prossima facciamo questi **due
nuovi profili**, capiamo permessi, capiamo noi come farlo per marketing e plus. Il
resto tutte le utenze sono a posto."_

| | |
| --- | --- |
| Client users start | **Monday 16 November** |
| Profiles available | 🔴 **the week after, at the earliest** |
| Marketing walkthrough with Rebecca Marmo and Matteo Distaso | **Thursday 19 November 09:30** — ⚠ **before the profile she needs exists** |

🔑 And the marketing function is the one with live work waiting: the ticket send
flow comes back on at the delta
([OI-230](OI-230%20The%20ticket%20confirmation%20request%20flow%20queries%20a%20relationship%20name%20as%20a%20field.md),
[the flow](../flows/The%20ticket%20confirmation%20request%20flow.md)), and Rebecca
Marmo also owes the email timing rule that R1 depends on
([OI-350](OI-350%20The%20R2%20date%20and%20the%20ticket%20email%20timing%20conditions%20need%20Rebecca.md)).

🟢 Licences are not the constraint: three are free of twelve, and two more can be
recovered ([OI-356](OI-356%20The%20definitive%20list%20of%20production%20users%20is%20still%20incomplete.md)).

## What is owed

- Both profiles built, assigned and tested — ideally before 16/11, and certainly
  before the 19/11 marketing session.
- The marketing mailbox confirmed against the DNS, so the user is not created twice.
- ⚠ Fabrizio Paganelli also expected to show the field population to Rebecca Marmo
  and was unsure it had ever been done: _"penso che Fabrizio nostro gli ha gia
  spiegato come popolare questi campi, o non ha ancora fatto"_ → Elena Spini:
  _"l'ha visto all'inizio, ma lo dovremmo rifare."_
