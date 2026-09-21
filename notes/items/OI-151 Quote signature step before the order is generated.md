---
id: OI-151
type: open-item
status: in-progress
owner: Anita Aga
with: Rexhina Hysi
org: ROMI
raised: 2026-09-21
updated: 2026-09-21
depends_on: [OI-59]
requirement: [INT-19]
source: notes/meetings/2026-09-21 Test Interni Pre-UAT.md
---

# OI-151 - Quote signature step before the order is generated

Agreed at
[the 21/09 pre-UAT session](../meetings/2026-09-21%20Test%20Interni%20Pre-UAT.md)
(`00:45:34`). Aurel Mrruku identified that acceptance in the community is **not
enough** to treat the contract as concluded: **a further signature step and flag is
needed before the order is generated.**

Anita Aga and Rexhina Hysi own the fields: a boolean **`firmato`** and a
**`signed by`**.

🔴 **This changes the quote state machine.** The flow becomes
`Bozza → In Attesa Accettazione → Accettato → firmato → order`, where the record
and `QuoteTriggerHandler`'s constants stop at `Accettato`.
→ [OI-59](OI-59%20Quote%20workflow%20configuration.md) is unruled for an eleventh
day and this adds a state to it.

## The document set it signs

Elena Spini delivered the breakdown Aurel Mrruku asked for on 18/09 — _"mi serve
capire che cavolo è, quando viene generato, chi lo deve generare, cosa il
contenuto"_ — by DM on **21/09 19:34–19:47 CEST**, from the
`CONTRATTI PIENISSIMO PER TIPOLOGIE DI ORDINI` material she forwarded on 18/09
08:14Z:

| Order type                      | Documents                                                    |
| ------------------------------- | ------------------------------------------------------------ |
| **Performance Plus**            | Contratto + Preventivo **+ scheda Performance Plus**         |
| **All other orders**            | Contratto + Preventivo                                       |
| **Preventivi per Pienissimo Pro** | **Fase 2** — informational mail only, **no DocuSign**      |

- ⚠ The **scheda Performance Plus** is the one piece Elena Spini believes is
  missing: _"hanno detto che vanno assieme — questa forse è l'unica cosa che manca
  ma possiamo anche chiedere"_. **Not confirmed with the client.**
- The **email copy** is to be taken from the first and last mail in
  `Esempi Email - CONTRATTI PIENISSIMO PER TIPOLOGIE DI ORDINI.pdf`.
- Her reading of where the signature lands, 18/09: _"la firma andrà sempre sul doc
  finale di conferma del tutto"_ — i.e. on the combined document, not per part.

✅ **The two templates exist in source** and the record-type condition matches:
`Plus_Attivazione_Rinnovo` selects the Performance Plus PDF, anything else the
standard one — documented in
[the PDF field mappings](../Quote%20PDF%20field%20mappings.md), a note a developer
wrote directly into `notes/` on 21/09.

## Open

- 🔴 **The fields are not in source.** No `firmato` or `signed by` in `force-app/`
  as of `0317348`.
- 🔴 **DocuSign credentials are still owed by the client**, and Aurel Mrruku is to
  chase them on 22/09. Procurement has moved: Elisa Migliano wrote on 21/09 that
  **the DocuSign contract had arrived** and asked for the Salesforce account id,
  which Elena Spini supplied. The credentials are the remaining step.
- ⚠ **If the contract and the quote are two separate documents, the signature flow
  must be reworked** — Aurel Mrruku's own caveat on 18/09. The three-document
  Performance Plus case is exactly that.
- ⚠ **`scheda Performance Plus` needs a yes or no from the client.** Elena Spini
  suggested simply asking.
- ⚠ **Quote UAT is 25 September**, titled `Preventivi`, and the original proposal
  named _"Preventivi e Firme Digitali (DocuSign)"_.
