---
id: OI-79
type: open-item
status: open
owner: Elisa Migliano
with: Fabrizio Paganelli
org: both
raised: 2026-08-06
updated: 2026-10-15
blocks: [go-live]
severity: gating
source: meetings/results/2026-08-06-chiusura-punti-aperti.md
---

# OI-79 - Migration volumes and mapping method

The real numbers, which **supersede** the ~6,000 / ~7,500 figures still printed
in the recap:

- ~**17,000** records in the Zoho client registry
- only ~**8,500** real clients with a registered ragione sociale
- the operative filter is the **Mexal client code** — _"andremo a caricare solo
  i clienti che hanno il codice cliente Mexal"_
- the client module holds ~**150 fields, about a quarter in use**

**Method:** Pienissimo lists only what is worth moving, writing the **Zoho
label** in column A so they need not know API names, and Aurel Mrruku maps at
insert time after a **joint field-by-field call**.

Roughly 95% was done in session and promised for the next day.

⚠ **The Lead and Referente/Contatti sheets are excepted.** Elisa Migliano
declined to do them alone — _"non sono sufficientemente competente"_ — and they
need Sabatino Rinaldi and Marco Montesi as well.

Completion is post-Ferragosto, against a data import planned for **~1
September**. The workbook this feeds is
[OI-24](OI-24%20Data%20model%20workbook.md).

## 2026-10-15 - Mexal-side volumes, and the mapping method is finally named

[The 15/10 session](../meetings/2026-10-15%20Migrazione%20e%20Go-Live.md) adds the
**Mexal** side of the volumes. These sit alongside the Zoho figures above; they
do not replace them, because the migration source changed and the two systems are
being counted differently.

| Figure               | What Fabrizio Paganelli said it is                        |
| -------------------- | --------------------------------------------------------- |
| **~51,000**          | order **lines**, _"dal primo gennaio 23 ad oggi"_          |
| **~10,000 per year** | his reading of the recent years, the platform sale ended   |
| ~20,000              | ⚠ an explicit guess a minute earlier, _"un numero a caso"_ |

⚠ **Orders and order lines are different counts and the session mixed them.** The
field specification due 16/10 will have to state which figure belongs to which
sheet.

🟢 **The mapping method is named for the first time**, which is the half of this
row that was missing: Aurel Mrruku supplies the target field list with expected
example values, the client maps his columns onto it and populates it, and the two
sheets join on an order key. See
[OI-244](OI-244%20Historical%20orders%20will%20be%20migrated%20from%20Mexal%20by%20spreadsheet.md).
