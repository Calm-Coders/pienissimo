---
id: OI-277
type: open-item
status: open
owner: Aurel Mrruku
with: Fabrizio Paganelli
org: both
raised: 2026-10-21
updated: 2026-10-21
depends_on: []
blocks: []
severity: normal
source: notes/meetings/2026-10-21 Check Dati Migrazione e OP.md
---

# OI-277 - A read-only Mandato RID field is required on the account

**A tutor can pick RID as the payment method on a quote even when the customer
has never signed a direct-debit mandate, and the collection then fails. The fix
agreed on 21 October is a read-only `Mandato RID` field on the account, fed from
Mexal, so the tutor can see whether a mandate exists before choosing RID. The
Mexal field names arrived from Kreosoft the same afternoon; the field is not
built.**

Agreed at `01:53:15`–`02:01:04` of
[the 21/10 morning session](../meetings/2026-10-21%20Check%20Dati%20Migrazione%20e%20OP.md).

## The problem as the client stated it

Fabrizio Paganelli:

> _"se il tutor[e] sceglie r[i]d mese data fattura, ma il cliente non c'ha …
> preventivamente spedito il mandato r[i]d[,] ossia l'autorizzazione all['addebito]
> ricorrente sul conto, io non posso mettere su un preventivo r[i]d … dopo
> quell'incasso a me mi va in insoluto."_

The mandate number lives in the Mexal customer record's payment conditions and
is entered there when the signed mandate comes back from the bank; only then can
an invoice carry RID.

## What was agreed

- A new field on the Account, **read-only for tutors**. Elena Spini:
  _"Ovviamente non modificabile, solo in lettura non modificabile."_
  Fabrizio Paganelli: _"solo in lettura."_
- 🔑 **Placement is deliberately inconsistent with its data lineage.** It belongs
  under the Mexal data block — _"in linea teorica dovrebbe rientrare nei dati
  Mexal perché sono quelli poi che dopo in notte devono essere sincronizzati"_ —
  but goes in **Informazioni principali** for tutor convenience. Elena Spini:
  _"corretto, però solo per questioni di praticità per il tutor glielo mettiamo lì
  sopra."_
- **No logic behind it.** Elena Spini: _"ma è una sua logica, è una sua
  attenzione"_ — i.e. nothing blocks a tutor who picks RID anyway. Fabrizio
  Paganelli accepted enforcement by reprimand: _"se il tutor mette modalità di
  pagamento r[i]d e poi io vado a fare la fattura e vedo che il cliente non ha
  r[i]d, vado dal tutor e gli do quattro schiaffoni."_
- Fed by the existing nightly Mexal sync: _"io prendo ogni 24 ore praticamente
  prendo il [dato] che c'è su M[ex]al."_

## 🟢 The Mexal field names

Aurel Mrruku asked Mirko Merendi for the technical field name
(_"Mirco mi deve dire su anagrafica clienti come si chiama il campo tecnico"_);
the request went out at 10:00:45Z and the answer at **12:41:57Z** (Gmail thread
`1a15de7ff92cb0d2`). The SEPA mandate block on the Mexal customer record exposes:

| API field | Holds |
| --------- | ----- |
| `nr_mandato_sepa` | the mandate number — **this is the field the Salesforce one mirrors** |
| `dt_mandato_sepa` | mandate date |
| `dt_mandato_cli` | customer-side mandate date; empty in the sample |
| `stato_sepa_cli` | customer SEPA state; empty in the sample |
| `stato_seq_sepa` | sequence state |
| `tp_incasso_sepa` | collection type; empty in the sample |
| `tp_mandato_sepa` | mandate type |

Field names only. The sample values are a real customer's mandate and bank
details and are deliberately not reproduced here.

## Still open

- 🔴 The Salesforce field does not exist. Its API name was not chosen in the
  call; the transcript records the intent as `mandato_rid`.
- ⚠ **A customer can hold more than one mandate and the design ignores it.**
  Aurel Mrruku raised it — _"Un cliente può avere più di un r[i]d[.]id"_ — and
  Fabrizio Paganelli confirmed Mexal only stores one: _"il cliente può avere più
  di un r[i]d, però noi abbiamo solo un campo dove andiamo ad inserire questo
  mandato."_ So the Salesforce field inherits a known truncation.
- ⚠ No register row covers the RID mandate. The payment methods are specified;
  the mandate precondition is not.
