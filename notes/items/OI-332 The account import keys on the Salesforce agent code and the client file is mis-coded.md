---
id: OI-332
type: open-item
status: open
owner: Fabrizio Paganelli
with: Aurel Mrruku
org: both
raised: 2026-11-04
updated: 2026-11-05
depends_on: [OI-244]
blocks: [go-live]
source: notes/meetings/2026-11-04 Continuazione Test e2e PROD.md
---

# OI-332 - The account import keys on the Salesforce agent code and the client file is mis-coded

**The import script assigns every migrated Account to an owner by reading one
column — `codice agente` — and resolving it against the agent code already held in
Salesforce. It ignores the owner-name column in the client's file entirely. The
client's Zoho export has wrong and duplicated agent codes, so accounts will be
assigned to the wrong tutor unless he corrects the file first. He took that work.**

## The rule, stated for the first time

Aurel Mrruku, in
[the 04/11 session](../meetings/2026-11-04%20Continuazione%20Test%20e2e%20PROD.md),
pressed three times by Fabrizio Paganelli before it landed:

> _"Io non mi baso sul nome che hai tu sul file Excel, ma mi baso sul codice
> agente che ho io su Salesforce."_
>
> _"Se mi arriva un account con codice agente 04, quel codice agente andrà sempre
> a Barbara \[Giordani\]."_
>
> _"Io non vado a leggere l'azienda proprietario nome, ma vado a leggere solo il
> codice agente. Non me ne frego del valore che c'è su azienda proprietario nome."_

Two further behaviours, both from the same passage:

- **Duplicate codes resolve to the most recent user** — _"ogni volta prendi
  l'ultimo codice agente, se per qualche motivo sono due agenti con lo stesso
  codice … prendo l'ultimo, quello il più recente."_
- **An unmatched code falls back to `01`** — _"se per qualche motivo io non ce
  l'ho un codice agente su Salesforce, lo collego con 01."_

🔑 The commission category follows the user, not the file: _"l'user di Salesforce
ha la categoria provvigione 4 a prescindere di quello che mi passi te."_

## 🔴 The data defect

Fabrizio Paganelli went through it on screen, sorting by owner name, then agent
code, then commission category:

- **Barbara Giordani appears against five agent codes** and only the first is
  right — _"Barbara Giordani ha dei clienti a 1 2 3 4 5 codici agenti, ma sono
  sbagliati, va bene solo il primo."_ The same for Carmine.
- **One of her accounts carries `610`** — _"il codice cliente, vedi, è 610, che è
  sbagliato."_ Aurel Mrruku confirmed the script will honour it regardless: _"ma
  se a me arriva 610 si collegherà a Barbara Giordani … a prescindere di quello
  che mi passi te."_
- 🔑 **Agent codes are shared between different agents in the client's system** —
  Aurel Mrruku: _"guarda che avete lo stesso codice agente condiviso con diversi
  agenti."_

The cause is the source system's hygiene, in Fabrizio Paganelli's words: _"siccome
su Zoho non siamo delle spade a gestire le anagrafiche"_.

## Who does what

🟢 **Fabrizio Paganelli owns the correction**, stated twice: _"questi qui te li
devo mettere a posto io"_ and _"Io me lo sono segnato, ho capito il criterio e le
prossime volte che te lo manderò farò la stessa cosa."_ He accepted repeating it:
_"anche se te lo faccio altre due tre volte da qui a quando andiamo in produzione
per me non è un problema."_

⚠ **Aurel Mrruku initially said no correction was needed** — _"Non serve che li
metti a posto … basta che mi dai l'elenco con quei sette agenti e il loro
codice"_ — and only conceded the file mattered when Fabrizio Paganelli showed him
the mis-coded row: _"Ah no, hai ragione. Cavolo."_ **The exchange is the reason
this item exists**, because for several minutes both parties believed the rule was
safe against a dirty file.

⚠ He needs only three columns of the sheet: _"mi servono solo le prime tre
colonne, praticamente."_

## Where it stands

🟢 **The corrected file arrived the same afternoon** — `Account Salesforce (rev
Agente).xlsx`, mailed 2026-11-04 15:39Z, the `rev Agente` in its name consistent
with the correction. ⚠ **It was not opened** — it holds real customer records —
so **nothing here verifies that the codes are now right.**

🔴 **The silent failure mode is the problem.** A wrong-but-resolvable code does not
error; it assigns the account to the wrong tutor, who then sees a book of business
that is not his. Nothing in the load reports which rows fell back to `01` or which
resolved to a shared code.

## Why it is open

1. 🔴 **No verification step exists.** No count of fallbacks to `01`, no list of
   codes that matched more than one user, no post-load reconciliation against the
   client's seven-agent list.
2. ⚠ **The seven-agent list is the authority and it is not in the repository.**
   Aurel Mrruku relies on _"quei sette agenti e il loro codice"_; seven agent users
   were provisioned on 03/11 and four verified.
3. ⚠ **One agent user leaves on 31 December** ([OI-324](OI-324%20An%20agent%20user%20leaves%20on%2031%20December%20and%20the%20licence%20must%20be%20reassigned.md))
   and nothing says what happens to accounts carrying that code.
4. 🔴 **The load is on 12-13 November** ([OI-310](OI-310%20The%20production%20load%20needs%20a%20pre-load%20and%20a%20delta%20run.md)),
   so the window to catch a mis-assignment before go-live is three working days.

**Closing it:** a production load whose owner assignments reconcile against the
client's own agent list, with the `01` fallbacks counted and reviewed.

## 🟢 2026-11-05 - the `rev Agente` file resolved cleanly in Prod

The corrected file carries exactly 7 agent codes, each with one owner name and one
commission category, and each matching exactly one active Prod agent user. **No
row fell back to `01` and no code matched two users** in the 8,262-row Aziende
load ([OI-310](OI-310%20The%20production%20load%20needs%20a%20pre-load%20and%20a%20delta%20run.md)).
⚠ This proves the codes resolve, not that each customer belongs to the right
tutor - that is still the client's own correction to vouch for.
