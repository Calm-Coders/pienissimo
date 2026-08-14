---
id: OI-79
type: open-item
status: open
owner: Elisa Migliano
with: Fabrizio Paganelli
org: both
raised: 2026-08-06
updated: 2026-08-15
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
