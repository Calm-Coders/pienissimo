---
id: OI-278
type: open-item
status: open
owner: Fabrizio Paganelli
org: Pienissimo
raised: 2026-10-21
updated: 2026-10-21
depends_on: []
blocks: []
severity: normal
source: notes/meetings/2026-10-21 Check Dati Migrazione e OP.md
---

# OI-278 - The account layout omits the legal representative data

**Zoho holds a block of legal-representative details on every company and
Salesforce does not show it, because the client left those fields out of the
data tracciato and nobody can now remember why. The five fields already exist in
Salesforce and are already mapped from Anticipay — they are simply not on the
page. The client suspended the question pending advice from their lawyer.**

Raised by Fabrizio Paganelli at `01:45:37` of
[the 21/10 morning session](../meetings/2026-10-21%20Check%20Dati%20Migrazione%20e%20OP.md)
and left suspended at `02:10:19`.

## 🟢 The fields exist already

Aurel Mrruku, after checking, at `02:09:08`:

> _"c'è già in sales force col campo perché l'avevo già mappato, solo che non c'è
> su UI, quindi non serve creare … i cinque campi che abbiamo. Nome legale
> rappresentante, codice fiscale legale rappresentante, data di nascita [legale
> rappresentante], luogo di nascita e indirizzo … E li abbiamo già questi campi in
> sales force e questi sono i campi che vengono aggiornati da Anti[ci]pay."_

So this is a layout omission, not missing development. ⚠ But it is a **section**,
not one field — Fabrizio Paganelli corrected Elena Spini on exactly that: _"non è
solo un nuovo campo, Elena, il problema è quello. È proprio una sezione."_

## Why it matters to the client

The contract should be signed by someone with signing authority, and today the
flow uses the **main contact**, who may be an employee:

> _"per legal[e] rappresentante intendo dire che ha i poteri di firma e dei
> contratti perché io che sono un tutor … inserisco il contratto principale,
> magari metto il direttore del locale che è semplicemente un dipendente e dopo
> mando a firmare i contratti al direttore del locale, non a chi ha i poteri di
> firma nella società."_

Aurel Mrruku confirmed the main contact is load-bearing for two things, not one:
_"chi firma in sales for[se] adesso è il contatto principale e non solo chi firma,
anche a chi mandiamo l'elenco dei biglietti da mettere i dati dei partecipanti."_

🟢 **And he confirmed the contract itself carries the company, not the
representative**: _"al contrat[t]o … ci va l'azienda."_ So the gap is about who
is asked to sign, not about what the document says.

## Why it was left out — unresolved

Fabrizio Paganelli could not reconstruct the decision and said so plainly, twice,
and brought Elisa Migliano in to try:

> _"nel tracciato dell'azienda noi quei campi lì non li avevamo previsti, ma
> meglio li avevamo tolti. Ma come mai li avevamo tolti? Perché immaginavamo che
> li sarebbero andati a prendere direttamente da Anticipay … È questo che io non
> riesco a ricordare."_

⚠ **Neither Elisa Migliano nor Elena Spini could answer either.** He attributed
it to a joint omission — _"Tanto li abbiamo fatti insieme con loro"_ — which no
record confirms or contradicts.

## 🔑 Why it is suspended rather than built

There is a prior legal opinion against pulling the data automatically. Fabrizio
Paganelli, `02:10:19`:

> _"Una volta questi dati li andavamo a prendere da Anticipay, come secondo me è
> giusto che sia, però era venuta fuori una questione da parte del nostro
> precedente avvocato dove diceva 'No, non va bene che voi li prendiate in
> automatico, ve li dovete far dare da lui e li deve digitare e scrivere.'"_

The historical workaround was a form sent by post, returned with an identity
document attached. He will re-check with the current lawyer before anything is
added: _"Me lo tengo in sospeso io."_ Elena Spini: _"sono cose che devi devi
prima verificare."_ Fabrizio Paganelli floated Phase 2 as the landing place:
_"poi dopo nel caso li possiamo inserire anche nella seconda fase, no?"_

## Still open

- 🔴 The lawyer's answer. No date given.
- ⚠ Whether automatic population from Anticipay is permissible at all, which
  decides whether this is a layout change or a data-collection flow.
- ⚠ Whether it lands in Fase 1 or Fase 2.
- **Nothing was built and nothing should be** until the client answers.
