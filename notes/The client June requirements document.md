---
id: ref-client-june-requirements
type: reference
status: active
org: Pienissimo
updated: 2026-08-14
source: Drive - 01 Documenti forniti dal cliente/Salesforce - Requisiti e Domande per Elena (16-06-2026).pdf
---

# The client June requirements document

`Salesforce - Requisiti e Domande per Elena (16-06-2026).pdf` — Pienissimo's own
requirements paper, written after their internal meeting of **11 June 2026** and
sent to Elena Spini before the 16 June call. Seven pages: what they want, 13
numbered questions for ROMI, and a table of internal open points with owners.

**It was read for the first time on 2026-08-14** and is referenced in no note,
tracker, recap or requirement id. It is the earliest structured statement of
requirements in the project and it predates most of what the trackers contain.

## Why it matters now

**It is the origin of "rinuncia al servizio".** The internal open-points table
carries, owned by Fabrizio Paganelli: _"Note di credito / rinuncia al servizio —
strutturare il flusso inverso: cliente che rinuncia a servizio già parzialmente
fatturato (nota di credito + chiusura ordine, oggi 'chiuso perso' su Zoho)."_
So the asset state missing from
[OI-74](items/OI-74%20Asset%20state%20machine.md) is not a late addition — it is a
client requirement from 11 June that never entered the tracker.

**It bears directly on the scope dispute.** GLS, Teachable (written
_"Teachball"_) and routing Pienissimo Pro to the software company appear here as
**requirements and as questions put to ROMI**:

- §2.7 lists the parallel flows for book, video courses and Pienissimo Pro
- §2.9 lists GLS, Teachball, WooCommerce, Mexal and Facebook/Google under
  _"Integrazioni richieste"_
- **Question 10** asks about GLS delivery notification and Teachball completion
- **Question 11** asks how to route Pienissimo Pro renewals _"direttamente al
  team Software"_

This does not settle
[the dispute](risks/Risk%20-%20the%20phase%202%20scope%20dispute%20is%20unresolved.md) —
11 June is **after** the 27 May kickoff, so it is not pre-sale evidence, and
ROMI's argument is about what was agreed before the contract. But it does show
the client raised all three formally and in writing in June, which makes
"mai discussi" harder to sustain as a flat statement and explains why Sabatino
and Fabrizio are so sure they were discussed.

## Other content not tracked anywhere

- **A "Prospect" state** — whether to add it alongside Lead and Cliente, as in
  Pienissimo 360. Owned by Sabatino Rinaldi and Marco Montesi. See
  [OI-90](items/OI-90%20Whether%20to%20introduce%20a%20Prospect%20state.md).
- **End-to-end traceability** as the guiding principle: one identifier linking
  lead → opportunity → quote → order → invoice, so the campaign of origin
  survives to the invoice without appearing on it.
- **"Giuliano"** sells services live and those stay commercially with Pienissimo
  Srl rather than routing to the software company — probably
  [G Lanzetti](people/G%20Lanzetti%20-%20CEO%20of%20both%20Pienissimo%20companies.md).
- The internal owners table assigns the **Tipo Ordine value list** and the
  **credit-note flow** to Fabrizio, the **loss-reason taxonomy** and
  **assignment rules** to Marco, and the **tranche calendar** and **GLS check**
  to Elisa.
