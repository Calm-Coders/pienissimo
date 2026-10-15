---
id: OI-186
type: open-item
status: open
owner: Elena Spini
with: Fabrizio Paganelli
org: both
raised: 2026-09-25
updated: 2026-10-15
blocks: [go-live]
source: notes/meetings/2026-09-25 Interna post UAT Contratto e Fase Due.md
---

# OI-186 - The Salesforce user list and profiles were never agreed with the client

**Elena Spini, at
[the 25/09 internal session](../meetings/2026-09-25%20Interna%20post%20UAT%20Contratto%20e%20Fase%20Due.md)
(`00:30:00`), reading her own Business Blueprint section aloud:
_"cosa mai sentita, mai parlato? Ruoli, permessi, profili."_**

Go-live is **21 October** ([OI-124](OI-124%20Go-live%20moved%20from%206%20to%2021%20October.md)).
Nobody can be given a login without a profile, and the client has never been asked.

## What exists

- **Four profiles, inferred from the org chart**, not from a conversation. Elena
  Spini derived them from the organigramma ROMI asked for at project start and
  named them as **direzione/amministrazione, front office, delivery and marketing**.
  She said so explicitly — _"questo è il loro organigramma che gli avevamo chiesto
  all'inizio… e dandogli questo organigramma ho cavato fuori"_ — and asked whether
  four is too many.
- 🔴 **No user list.** Aurel Mrruku: _"No, io non ce l'ho… Abbiamo la lista degli
  agenti, però non vuol dire che tutti quelli sono [utenti]."_ He has **about 18
  agent codes**; Elena Spini confirmed those are not all agents and are not the
  user list. ⚠ The licence count is not known to either of them.

## Aurel Mrruku's position

Not a blocker technically, and not worth design effort: _"se tutti vedono tutto,
sinceramente non perderei tanto tempo sui profili"_. He can build groups once the
structures and data exist, and understands the client has **no requirement to hide
records from each other**, so the four profiles could be merged. Elena Spini's
caveat: everyone seeing everything is not the same as everyone being able to
**change** everything.

## Open

- 🔴 **Get the user list from Fabrizio Paganelli.** It was booked for the
  **28/09 10:00** session alongside the Contratto — _"ne dobbiamo parlare anche
  questo con il buon Fabrizio"_. Nothing records it on the invitation's agenda.
- 🔴 **Confirm the four profiles with the client, or collapse them**, before any
  login is issued.
- 🔴 **Establish the licence count.** Aurel Mrruku recalled _"sei user"_ from an
  early conversation; Elena Spini said it is now more and neither could say.
- ⚠ This is upstream of
  [OI-180](OI-180%20Client%20UAT%20users%20are%20withheld%20until%20a%20director%20review.md).
  That row waits on Daniela Morgese's review; **this one waits on a list that does
  not exist**, which is the harder of the two.
- ⚠ No register row covers profiles, roles or permission sets.

## 🔑 2026-09-28 - the client ruled on visibility, and the user list is still missing

Half of this note is answered. At
[the 28/09 session](../meetings/2026-09-28%20Tema%20Contratti%20e%20Open%20Point.md)
(`00:33:00`-`00:38:00`) Fabrizio Paganelli gave **the first client statement on
permissions**.

He reached for segregation first — _"i commerciali dovranno vedere delle cose che …
noi in amministrazione vediamo cose che i commerciali non possono vedere"_ — and
reversed once Aurel Mrruku spelled out what *everyone sees everything* meant at
record level (a commerciale seeing another commerciale's orders and accounts):

> _"adesso è così, eh, e tutti i commerciali vedono tutto … è una modalità che non
> mi sento di disapplicare, nel senso che poi dopo corriamo il rischio che
> stravolgiamo troppo il modo di lavorare."_

🔑 **The rule, in his words:** _"facciamo che al momento tutti vedono tutto e poi
l'importante è che non tutti possano modificare tutto."_ **Read access is open
across records; edit access is what gets restricted**, with field-level exceptions.

### 🔑 His reason is itself a requirement

He wants configuration structures locked to named people, because at Zoho someone
changed configuration without telling anyone and **his invoicing stopped for days**:

> _"uno per risolvere una cosa del suo reparto faceva i danni agli altri … mi si è
> bloccata la fatturazione perché Tizio era andato dentro, aveva toccato
> determinate cose."_

His ask: _"sarei più favorevole a blindare determinati profili, a fare determinate
cose, solo le cose del loro reparto"_, with a request route for exceptions. **This
is a stated client requirement about configuration change control, not a
preference.** Nothing in `requirements/` covers it.

### 🟢 The shape, agreed

Elena Spini proposed _"forse uno o due profili, ma … forse già solo uno e poi
andiamo di permessi"_. Aurel Mrruku ruled **role hierarchy out entirely** —
_"ruoli poco, siccome tutti vedono tutto, non vedo utilità."_

**So: one profile plus permission sets, and no role hierarchy.** 🟢 This
**supersedes the four profiles inferred from the org chart** recorded above — the
inference is no longer load-bearing.

🔴 **Which functions get an ad-hoc permission is deliberately deferred to after
UAT**, once the record life cycles are visible. Aurel Mrruku: _"alla fine dei test
dobbiamo definire … ci dovete dire questa roba si deve fare solo da questa
persona."_ Fabrizio Paganelli agreed. **That is a decision dated after 13 October
approval**, on a go-live of 21 October.

### 🔴 The user list was not asked for

Getting it was the **second purpose of this session**. Elena Spini had named it a
red flag in `#tproj-pienissimo` ninety minutes earlier — _"Il cliente deve ancora
fornire i template dei Web Form (Sabatino) e la lista degli utenti"_ — and **it did
not come up in the call at all.** Fabrizio Paganelli was the right person and was
on the line for an hour.

🔴 **Still: no user list, no named people, ~18 agent codes.** Go-live 21/10.
Pienissimo is unreachable 29/09; the next contact is 30/09, a UAT session.

## 2026-10-05 - two rulings on users, and the source sheets are still empty

🔑 **From [the Performance Plus UAT](../meetings/2026-10-05%20UAT%20Performance%20Plus%20e%20Gestione%20date%20pagamento.md):**

- **Strategists share one user account.** Agreed as a `Concordato`:
  _"Gli strategist utilizzeranno un account utente condiviso per
  l'aggiornamento dei campi contrattuali al fine di ottimizzare i costi delle
  licenze."_ The strategist is also the role that fills the contract's
  `data di attivazione`. ⚠ A shared login makes `LastModifiedBy` useless on
  exactly the field the contract's twelve months run from, and the 28/09 ruling
  was `tutti vedono tutto` at record level with **edit** access as the thing
  restricted — a shared account restricts nothing and audits nothing. Nobody
  raised either point.
- **The `digital` field is hidden** in the contract interface, kept in the
  database, because task management belongs to the strategist. `strategist` and
  `digital` were the two text fields added on 28/09 for ~15 people with no
  licences; one of them is now invisible.

🔴 **The client's own source for this is still blank.**
[The Campi Oggetti workbook](../The%20Campi%20Oggetti%20Flussi%20e%20Utenti%20workbook.md)
was modified 05/10 at 16:40Z and its `Utenti` sheet still holds only the header
`Nome, Cognome, Email, Ruolo, Visibilità`, its `Profili` sheet only
`Profilo, Visibilità`. **Nothing underneath either.** Three sessions with the
client on 05/10, two of them about data and fields, and the user list was not
asked for again — the same omission this item recorded on 28/09.

## 🔴 2026-10-15 - deferred again, explicitly, and now three requirements wait on it

At [the 15/10 session](../meetings/2026-10-15%20Migrazione%20e%20Go-Live.md)
(`00:10`–`00:15`) the profile question was put directly and postponed with a
stated reason. Aurel Mrruku:

> _"tutti i flussi fino adesso … abbiamo usato solo il permesso di sistem admin
> perché avevamo detto confermiamo prima tutto e poi decidiamo chi deve vedere
> cosa. … se io adesso devo fare i permessi, ma ci sono campi che non servono, ci
> sono layout che devono cambiare, io li devo rifare ogni volta che cambia un
> campo perché i permessi sono legati con l'entità."_

🟢 **The engineering reason is sound** and it is the first time the deferral has
been justified rather than simply observed: permission sets bound to fields and
layouts have to be rebuilt every time those change, and the build is still
changing.

🔴 **The consequence is that eighteen days before go-live every person who
touches the system is a System Admin**, including, from this week, the client's
commercial lead
([OI-240](OI-240%20Marco%20Montesi%20needs%20a%20Salesforce%20user%20before%20go-live.md)).

**Three requirements now depend on profiles that do not exist:**

| Requirement                                                                                               | Needs                                              |
| --------------------------------------------------------------------------------------------------------- | -------------------------------------------------- |
| [OI-247](OI-247%20Only%20the%20responsabile%20commerciale%20may%20edit%20the%20provvigioni%20fields.md)    | a _responsabile commerciale_ profile, uniquely privileged |
| [OI-233](OI-233%20Bundle%20access%20for%20tutor%20profiles%20is%20undefined.md)                            | a _tutor_ profile that cannot quote or order bundles |
| [OI-246](OI-246%20Key%20User%20training%20cannot%20be%20completed%20before%20the%20new%20go-live.md)       | something to train eight commercial users **on**    |

🔴 **And the deferral collides with the training plan.** Testing and training
happen under System Admin, against access the users will not have in production.
Aurel Mrruku named that himself as what he expects to be hardest to explain:
_"le cose che io mi aspetto che siano difficili da spiegare [sono] i campi che
non vedono, oppure se abbiamo dato qualche permesso in più, qualche permesso in
meno quando facciamo i permessi per questi utenti."_ Elena Spini made the same
point about Marco Montesi specifically.

⚠ **The window for the permissions build is now the same two weeks** as the test
completion, the training, the production deployment and the migration rehearsal.
