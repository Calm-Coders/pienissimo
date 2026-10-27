---
id: OI-293
type: open-item
status: open
owner: Fabrizio Paganelli
with: Aurel Mrruku
org: both
raised: 2026-10-27
updated: 2026-10-27
depends_on: [OI-244]
blocks: [go-live]
source: notes/meetings/2026-10-27 Anagrafica Articoli.md
---

# OI-293 - The agent registry for the production load may be incomplete

**Production users and the account-to-agent join both depend on a clean agent
registry, because the client's own data has one agent code carrying two
different agent names. The list asked for was every agent ever used, retired
ones included. The list delivered is seven rows of current commercial staff.
Nothing in the record says whether the retired codes are in it, and the
duplicate-code problem is therefore unresolved.**

## The ask

[The 27/10 call](../meetings/2026-10-27%20Anagrafica%20Articoli.md), `00:04:40`–
`00:07:26`. Aurel Mrruku needs **nome, cognome, email, codice agente, categoria
provvigione cliente**, for two purposes:

> _"così io creo in produzione le utenze pulite e poi quando vado a caricare gli
> account in base al codice agente che mi passi te riesco a fare la mappatura."_

And explicitly **all of them**:

> _"ma di tutti gli agenti, **anche quelli che non ci sono più**, perché gli
> account sono collegati a un codice agente."_
>
> _"Ma mi servono anche agenti, tutti i codici agenti praticamente che hai te,
> **anche quelli che non sono in uso**."_

Zona is **not** wanted on the agent — _"la zona l'abbiamo spostato sull'account,
non sulla gente"_ — and the client does not maintain it anyway.

## The reason: one code, two names

🔴 The defect is in the client's historical data, not in Salesforce:

> **Aurel Mrruku:** _"Però là ho notato che con lo stesso codice avete due
> agenti."_ … _"molto probabilmente avete usato il codice per un agente A e poi
> l'avete usato poi per l'agente B."_
>
> **Fabrizio Paganelli:** _"con lo stesso codice abbiamo due agenti nei movimenti
> storici."_

Fabrizio Paganelli's first instinct was that it did not matter — _"questo non ce
ne frega mica niente a noi"_ — and Aurel Mrruku's answer is the whole item:
**_"A me sì … perché quando carico io quei account non so a quali dei due."_**
The account load reads the agent code from the client's spreadsheet; an ambiguous
code means an account attached to the wrong person, or to nobody.

## What arrived

Gmail `1a17d328d1758cb0`, **2026-10-27 11:50:25Z** — 22 minutes after the call
ended — Fabrizio Paganelli to Aurel Mrruku, cc Elena Spini, Marco Montesi,
`amministrazione@pienissimo.com`, subject **Account Area Commerciale**:

> _"come richiesto ti invio l'elenco degli utente dell'area commerciale. Abbiamo
> un utente generico (vedi record evidenziato in rosso). Aggiungo anche Marco"_

Attachment **`Utenti Area Commerciale.xlsx`**, 10,398 bytes, saved to Drive as
`1H-OQK31dhUl6g-ZgiMVOm4ilDi5iaoSa` (owner `a.mrruku@romicompany.com`). It was
re-posted by Aurel Mrruku into the ROMI dev group DM `C0BQD34LLF4` at **17:27:38
CET** as a seven-row table with the columns **Cognome · Nome · mail · Codice
Agente · Categoria Provvigioni Cliente · Zona**.

⚠ **It carries named individuals and their work addresses. No values are copied
into this repository** — see [docs/publishing.md](../../docs/publishing.md). What
is recorded here is the shape: seven rows, one of them a generic shared account,
`Zona` empty throughout.

🟢 **It was acted on immediately.** Slack `C0BQD34LLF4`:

> **Rexhina Hysi, 17:29:44 CET:** _"i am proceeding"_
>
> **Rexhina Hysi, 18:03:28 CET:** _"done added also the permission set Agente to
> these users"_

## Why it is still open

1. 🔴 **"Area commerciale" is not "all agents, including retired".** The subject
   line, the covering sentence and the row count all describe current staff.
   Nothing states that the retired codes Aurel Mrruku asked for twice are
   present, and **without them the duplicate-code ambiguity he raised is not
   resolved** — it is precisely the historical codes that carry it.
2. ⚠ **Fabrizio Paganelli's own extraction method would not have produced them.**
   In the call he proposed `distinct` over the company registry — _"se vado
   nell'anagrafica delle aziende prendo il distinct dei tutor e poi ti passo
   quella lista"_ — which is the very source Aurel Mrruku rejected as ambiguous:
   _"Sì, sì, quello l'ho fatto io. Infatti così ho fatto io."_
3. 🔑 **The agent codes are `610.000NN`, not `610`.** The 22/10 import exclusion
   rule recorded as _"missing agent → existing code 610"_
   ([OI-275](OI-275%20The%20Mexal%20order%20key%20is%20not%20unique%20without%20the%20order%20date.md),
   [OI-244](OI-244%20Historical%20orders%20will%20be%20migrated%20from%20Mexal%20by%20spreadsheet.md))
   therefore names a **prefix**, and which specific code the default resolves to
   is unstated. The generic shared row is the obvious candidate and **nothing
   says so.**
4. ⚠ **A generic shared user is being created as an agent.** Flagged by the client
   itself. No note covers what a shared sales user means for ownership,
   provvigioni or the `Agente__c` validation rule behind
   [OI-288](OI-288%20Editing%20a%20Contact%20fails%20in%20production%20when%20the%20Account%20has%20no%20Agente.md).
5. ⚠ **Not verified in the org.** That the users and the permission set exist is
   taken from the Slack exchange above, not from an inspection.
