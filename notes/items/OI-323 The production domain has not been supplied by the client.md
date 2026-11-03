---
id: OI-323
type: open-item
status: open
owner: Elena Spini
with: Fabrizio Paganelli
org: both
raised: 2026-11-03
updated: 2026-11-03
depends_on: []
blocks: []
source: notes/meetings/2026-11-03 Test e2e PROD.md
---

# OI-323 - The production domain has not been supplied by the client

**Something in the production setup needs a domain the client has never provided.
Nobody on the call could say what it was for, and ROMI has not asked for it.**

## What was said

In [the 3 November e2e session](../meetings/2026-11-03%20Test%20e2e%20PROD.md), while
getting Fabrizio Paganelli into production:

> **Aurel Mrruku:** _"Ma il dominio poi lo dobbiamo aggiustare. Elena, sai qualcosa?"_
> **Elena Spini:** _"esatto, era una domanda a te, **non ce l'hanno dato, quindi mi sa
> che glielo dobbiamo chiedere**. Adesso facciamogli mettere la password, poi
> chiediamo."_

They did not come back to it. Gemini's next-steps record it as _"[Il gruppo]
Richiedere dominio: Richiedere la configurazione del dominio necessario per il
corretto funzionamento dell'ambiente di produzione. Verificare i parametri
mancanti."_

## ⚠ What is not known

⚠ **Which domain.** Nothing in the session says what it is for. The plausible
candidates are an email sending domain for the marketing sends, or a DNS record for
the community site — **neither is stated and neither is assumed here.**

🔑 **It is not the Salesforce login URL.** That came up separately in the same session
and was **decided to stay unchanged** — see
[the decision](../decisions/Decision%20-%20the%20Salesforce%20My%20Domain%20stays%20unchanged.md).
⚠ **Do not merge the two.**

## Why it is open

1. 🔴 **ROMI has not asked.** Elena Spini identified that it must be requested and no
   request was sent on 3 November.
2. ⚠ **Its consequence is unknown**, because its purpose is. _"Il corretto
   funzionamento dell'ambiente di produzione"_ is the only description, and that came
   from the auto-notes, not from a person.
3. 🔑 **It should be one question on the 4 or 5 November calls.** Both are scheduled
   with Fabrizio Paganelli.
