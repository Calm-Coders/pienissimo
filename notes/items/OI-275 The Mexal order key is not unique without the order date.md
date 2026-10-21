---
id: OI-275
type: open-item
status: resolved
owner: Aurel Mrruku
with: Mirko Merendi
org: both
raised: 2026-10-21
updated: 2026-10-21
depends_on: []
blocks: [OI-244]
severity: normal
source: notes/meetings/2026-10-21 Tema Migrazione.md
---

# OI-275 - The Mexal order key is not unique without the order date

**Mexal identifies an order by `sigla` + `serie` + `numero documento`, and
restarts the numbering every year, so the triple repeats across years. Binding
an incoming invoice to the wrong historical order was a real risk for the bulk
import. Resolved in the same call by adding the order date to the key, after
Kreosoft confirmed the field exists on the invoice side of the API.**

Raised by Aurel Mrruku at `00:12:25` of
[the 21/10 afternoon session](../meetings/2026-10-21%20Tema%20Migrazione.md):

> _"voi ogni per ogni anno iniziate da zero … quindi quella chiave non va bene e
> ho chiesto di mettere anche l'an[n]o del documento e … devo fare una chiave
> sigla serie numero documento e anno documento."_

> _"se per caso due ordini con la stessa sigla, numero, documento e serie
> documento, ho il dubbio, la paura che prenderò l'ordine sbagliato. Quindi leggo
> la fattura con l'ordine sbagliato."_

The exposure is real because order and invoice dates diverge across a year end.
Fabrizio Paganelli demonstrated it live: order `44.203` dated 25 July 2023,
invoiced 4 August 2023 — _"Sono due cose diverse, data ordine e data fattura"_ —
and confirmed the general case: _"può capitare che io ho un ordine del 2026 che
fattura nel 2027 … soprattutto a cavallo di anno."_

Mexal compounds it because the API is queried per year: _"Io devo fare una
chiamata per ano"_, against separate archives.

## Why the customer code was not enough

Fabrizio Paganelli proposed adding the customer to the key. Aurel Mrruku refused
it on both correctness and plumbing grounds: _"un cliente può avere due ordini
con la stessa sigl[i]a in due anni diversi"_, and the invoice feed as built does
not carry the customer — _"non ce l'ho nelle regole che ho adesso il cliente."_

## 🟢 How it was resolved

Mid-call the two mailed Mirko Merendi at Kreosoft (Gmail thread
`1a15de7ff92cb0d2`, 13:05:04Z) and he answered at **13:14:43Z**, naming the
order fields present on the invoice: `sigla_ordine`, `serie_ordine`,
`numero_ordine`, `data_ordine`. Elena Spini read it out and Aurel Mrruku closed
the question:

> _"sigla ordine, serie ordine, numero ordine, data ordine." … "Perfetto, abbiamo
> tutto. Quindi uso quella data ordine come chiave e siamo a posto."_

**Agreed key: `sigla` + `serie` + `numero documento` + `data ordine`**, with the
date in Mexal's compact form (eight digits, no separators) so the spreadsheet and
the API agree. The customer code is **not** part of the key.

Only field names are recorded here. The sample values in the mail belong to a
real customer record and are deliberately not reproduced.

## Still open

- ⚠ The key must be stored on the Salesforce order so the invoice feed can match
  it; that storage is part of the unbuilt import work in
  [OI-244](OI-244%20Historical%20orders%20will%20be%20migrated%20from%20Mexal%20by%20spreadsheet.md).
- ⚠ The same thread also produced the SEPA mandate field names, which are a
  different item —
  [OI-277](OI-277%20A%20read-only%20Mandato%20RID%20field%20is%20required%20on%20the%20account.md).
