---
id: OI-318
type: open-item
status: open
owner: Aurel Mrruku
with: Fabrizio Paganelli
org: both
raised: 2026-11-03
updated: 2026-11-03
depends_on: []
blocks: []
source: notes/meetings/2026-11-03 Test e2e PROD.md
---

# OI-318 - The data competenza labels must be renamed to data ordine

**The client has asked for this rename repeatedly — by his own count seventy-four
times — and it was agreed once before and then reversed. `data competenza` is
accounting language that misleads tutors. The labels should read `da data ordine` and
`a data ordine`.**

## The request

On the edition record in
[the 3 November e2e session](../meetings/2026-11-03%20Test%20e2e%20PROD.md), Fabrizio
Paganelli:

> _"Qui quel da data competenza, data competenza, avevamo detto di chiamarle da data
> ordine a data ordine. Eh, vi ricordate?"_

Aurel Mrruku recalled it being agreed and then undone: _"Mi sa che l'avevamo chiamato
così, poi abbiamo detto lasciamo da data competenza."_ Fabrizio Paganelli pushed back:

> _"No, ve l'ho detto 74 volte che lì vorrei vedere da data ordine a data ordine
> perché **data competenza trae in inganno**, cioè è una terminologia che usiamo
> all'interno dell'amministrazione, ma dopo ai tutor li traiamo in inganno."_

> _"Se me lo potete richiamare quei due lì da data ordine a data ordine."_

Elena Spini: _"segnato."_

## Why it is open

1. 🔴 **Nothing is renamed.** The labels stand as `data competenza`.
2. 🔑 **It has been agreed and reversed at least once** — which is why it is worth a
   row rather than a quiet fix. ⚠ **No note records the reversal or its reason.**
3. ⚠ **Label change only.** Nothing suggests the field API names or the Mexal mapping
   change, and nothing says they do not.
4. 🔑 **Two fields**, the start and the end of the range, on the **edition** (child
   campaign).

⚠ **Scope caution**: `data competenza` may appear on more than the edition. The call
only covered the two edition fields.
