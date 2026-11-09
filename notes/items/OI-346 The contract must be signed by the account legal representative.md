---
id: OI-346
type: open-item
status: open
owner: Fabrizio Paganelli
with: Aurel Mrruku
org: both
raised: 2026-11-09
updated: 2026-11-09
depends_on: [OI-304]
blocks: []
source: notes/meetings/2026-11-09 Review temi Fase 2.md
---

# OI-346 - The contract must be signed by the account legal representative

**On the 9 November Fase 2 review the client stated that the stage-sale contract
has to be signed by the account's legal representative, and that the fields
identifying that person may never have been built. He is taking it to his lawyer.
This lands on R0, which is already in development.**

## What he said

[The 09/11 client review](../meetings/2026-11-09%20Review%20temi%20Fase%202.md),
transcript `00:38:20`, Fabrizio Paganelli:

> _"il contratto lo deve firmare **il legale rappresentante dell'account**, quindi
> è lì si tratta di aggiungere questi campi e **adesso mi informo anche meglio con
> l'avvocato**, però si tratterebbe di aggiungere questi campi e **se non li
> abbiamo già previsti nel tracciato dati** e poi dopo fare in modo che quando
> parte il contratto sia firmato dal legale rappresentante."_

The fields are _"intestati al legale rappresentante, nome, cognome, indirizzo,
eccetera eccetera"_, and he says they were discussed _"quando abbiamo fatto le
mappature"_. ⚠ **Whether they exist in the Account or Contact tracciato is not
established here** — no org inspection was made in this session.

## 🟢 The proposed answer, not yet checked

Aurel Mrruku, immediately: _"in teoria se metti quello come **contatto
principale**, perché noi abbiamo il meccanismo di contatto principale, possiamo
usare quello."_ Fabrizio Paganelli agreed in principle — _"direttamente quello.
Esatto"_ — and both left it at _"poi ne facciamo un check insieme"_.

🔑 **So there are two candidate designs and no ruling**: reuse the existing primary
contact, or add dedicated legal-representative fields.

## Why it matters now

1. 🔴 **R0 is in development already.** The stage-sale contract flow was authorised
   on 6 November ([OI-343](OI-343%20The%20client%20disputes%20that%20the%20stage%20sale%20contract%20was%20outside%20the%20Fase%201%20Blueprint.md))
   and must be in production before Pienissimo Live, 24-26 November. **Who signs
   is not a detail of that flow; it is the flow.**
2. 🔑 **It touches the open `OP-2`** of
   [the functional analysis](../The%20stage%20sale%20contract%20functional%20analysis.md) —
   where the signature status and the signed PDF live — which is still unanswered.
3. ⚠ **It is gated on an external opinion.** Fabrizio Paganelli's own framing:
   _"magari è superfluo per noi tecnicamente, **ma è importante giuridicamente**."_
   No date was given for the lawyer's answer.
4. ⚠ **It may be a requirement change.** If dedicated fields are added, the
   Account/Contact tracciato and the register move; if the primary contact is
   reused, nothing does. **The register is untouched at v1.6** and this is a
   candidate, not a change.

## 🟢 The adjacent question that closed

The same exchange settled the **ragione sociale** half. The Account already carries
a previous-company code under `dati commerciali` — _"c'è il codice account
precedente … per tener traccia di dei clienti che cambiano la ragione sociale,
quindi quello dovrebbe essere a posto"_ — confirmed by Elena Spini opening the
record on screen.

## What is owed

- The lawyer's answer, from Fabrizio Paganelli, with a date.
- The ROMI check of whether the primary-contact mechanism is sufficient, from
  Aurel Mrruku and Fabrizio Paganelli together.
- A statement of whether this is inside R0's agreed scope or an addition to it.
