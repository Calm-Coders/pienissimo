---
id: OI-336
type: open-item
status: open
owner: Aurel Mrruku
with: Fabrizio Paganelli
org: both
raised: 2026-11-04
updated: 2026-11-04
depends_on: []
blocks: []
source: notes/meetings/2026-11-04 Continuazione Test e2e PROD.md
---

# OI-336 - The quote PDF allegato B has no signature field

**Signing a production quote through DocuSign on 4 November, Fabrizio Paganelli
found no signature field on `allegato B`. Aurel Mrruku said one was never
specified there, then said every previous test had carried two signatures. Neither
could reconcile it on the call, and no owner or date was set.**

## What happened

Mid-signature in
[the 04/11 session](../meetings/2026-11-04%20Continuazione%20Test%20e2e%20PROD.md):

> **Fabrizio Paganelli:** _"Qui perché non c'è la firma?"_
>
> **Aurel Mrruku:** _"Cos'è? Quello allegato B. Non è stato previsto una firma là.
> Dalle indicazioni la firma era là sopra."_
>
> **Fabrizio Paganelli:** _"Solo sopra."_
>
> **Aurel Mrruku:** _"Sì, almeno da tutti i test che abbiamo fatto **abbiamo avuto
> sempre due firme**."_

🔑 **The two statements contradict each other** — the specification is said to
place one signature, the test history to show two — and the contradiction was left
standing. Fabrizio Paganelli also said he remembered two: _"infatti mi ricordo
anch'io."_

## 🟢 What was agreed instead: a document review

Aurel Mrruku turned it into a written review, with the client's own template as the
yardstick:

> _"Potete dare un'occhiata già che ci siete? Mi date un feedback del documento
> proprio. Quindi spendete mezz'ora, un'ora e vedete tutte le righe del documento,
> e se non vi torna qualcosa anche a livello di data firma oppure qualche
> misspelling."_

Fabrizio Paganelli confirmed the provenance: _"quelli voi li avete rifatti voi
praticamente sulla base del modello che avevamo dato noi."_ Owners: **Fabrizio
Paganelli and Elisa Migliano**. ⚠ **No date.**

🟢 **One defect was found live**: the quote line reads `prezzo neto` with one `t`.
Aurel Mrruku: _"Se vedi che non sono italiano."_ ⚠ **Not fixed in this sweep** and
it reaches the customer, since the quote PDF is the client-facing document.

## Why it is open

1. 🔴 **Nobody established how many signatures the document should carry**, and
   the quote PDF is signed in production today.
2. 🔴 **The review has no deadline** and the client is in the 12-13 November load
   plus training the week after.
3. ⚠ **It compounds [OI-326](OI-326%20A%20second%20PDF%20template%20is%20needed%20for%20corsi%20and%20for%20Plus.md)**
   — R0 needs a second template, built from this one. A signature-placement defect
   fixed now is fixed once; found after the second template exists, twice.
4. ⚠ **`allegato B` is not described anywhere in the repository.** What it contains
   and why it would need a signature is not recorded; the
   [quote PDF field mappings](../Quote%20PDF%20field%20mappings.md) do not cover it.

**Closing it:** a stated answer on how many signature fields the quote carries and
where, the misspelling fixed, and the client's line-by-line review returned.
