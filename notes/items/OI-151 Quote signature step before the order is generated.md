---
id: OI-151
type: open-item
status: in-progress
owner: Anita Aga
with: Rexhina Hysi
org: ROMI
raised: 2026-09-21
updated: 2026-09-24
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

| Order type                        | Documents                                             |
| --------------------------------- | ----------------------------------------------------- |
| **Performance Plus**              | Contratto + Preventivo **+ scheda Performance Plus**  |
| **All other orders**              | Contratto + Preventivo                                |
| **Preventivi per Pienissimo Pro** | **Fase 2** — informational mail only, **no DocuSign** |

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

## 🟢 2026-09-24 — the client agreed a `Firmato` state, and the order hangs off it

**Settled at [UAT: Lead e Opportunità](../meetings/2026-09-24%20UAT%20Lead%20e%20Opportunita.md)
`01:36:37`–`01:37:45`.** Elena Spini put the discrepancy: the flow the room had designed
sends the quote to `Accettato` _after_ signature, but the running build sets `Accettato`
on the Community confirmation, before DocuSign has returned anything.

Aurel Mrruku's resolution, accepted by Elena Spini, Marco Montesi and Fabrizio Paganelli:

> _"secondo me la cosa migliore da fare è avere lo stato accettato, ma avere anche lo
> stato firmato alla fine."_

The agreed chain:

| Step                                            | State                                                  |
| ----------------------------------------------- | ------------------------------------------------------ |
| Client clicks **Accetta** on the Community page | Quote → **`Accettato`**; the DocuSign envelope is sent |
| Signed document returns from DocuSign           | Quote → 🔑 **`Firmato`** (new)                         |
| Quote reaches `Firmato`                         | **the Order is generated automatically**               |
| Order reaches `Incassato`                       | Opportunity → Chiusa Vinta                             |

🟢 **Proved end to end in the session.** Aurel Mrruku sent a quote for the configured
product `Lead Funnel Advanced Academy`; Fabrizio Paganelli signed on DocuSign at
`01:41:45` and received the completed PDF; the order was generated with the same
structure (`01:46:57`).

### What this means for the register

🔴 **`Firmato` is a sixth quote state agreed with the client, and the register does not
have it.** `state_machines.quote.states` in
[requirements/pienissimo-requirements.yaml](../../requirements/pienissimo-requirements.yaml)
carries the older DGM-derived labels and **already bears a flag saying it disagrees with
the org's five values, "flagged for a human"**. This sweep did **not** amend it: adding a
sixth value to a list known to be wrong in five places makes the register less accurate,
not more, and the block is contract-bound. **A human owes that reconciliation, and it is
now six values behind, not five.**

### Related decisions from the same session

- A **synchronisation flag on the order** to surface Mexal communication errors, and
  record locking after the order is generated (`01:46:57`). Unbuilt.
- **A CC field on the quote send**, so a collaborator or director receives the proposal.
  Aurel Mrruku distinguished the Salesforce side (any number of addresses, concatenated)
  from DocuSign's own format, which he must check in the documentation. Unbuilt.
- **The sender name becomes the agent's**, replacing _"team Pienissimo"_; Fabrizio
  Paganelli asked that the Pienissimo Srl reference and phone details stay in the body.
- 🔴 **DocuSign signature boxes are misaligned** — the session's action items carry
  _"Rivedere il punto di firma e allineare correttamente le caselle di firma"_. The PDF
  template's signature tags need the client's own markup: Aurel Mrruku asked them to
  download the generated PDF and mark where signatures go and how much space to leave.
- ⚠ **Quote UAT is tomorrow, 25/09**, and `Firmato` does not exist yet.
