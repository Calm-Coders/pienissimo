---
id: ref-articoli-salesforce
type: reference
status: active
owner: Fabrizio Paganelli
org: Pienissimo
raised: 2026-09-21
updated: 2026-10-05
depends_on: [OI-46, OI-48, OI-87, OI-96, OI-98, OI-167, OI-188, OI-210]
source: Drive 17pyx0xRtRY7vWXjN5oddAs52XWvkbM7p, modified 2026-10-05T09:24:17Z
---

# The Articoli Salesforce article registry

**The client's own Mexal article registry, extracted for Salesforce. It sat
unmoved on the unreachable list for four consecutive nightly runs and was
modified on 2026-10-05 at 09:24:17Z, hours before the Performance Plus UAT that
needed it.** Owned by Fabrizio Paganelli on a personal Google account, not his Pienissimo address. Read in full on 05/10.

🔴 **It holds real catalogue prices. No price value is recorded here, in any
note, in the recaps or in `site/`** — see
[docs/publishing.md](../docs/publishing.md). What follows is structure and
counts only.

## Shape

One `ANAGRAFICA` sheet of **1,010 articles**, followed by pivot blocks that
count them. Columns:

| Column | Note |
| --- | --- |
| `Codice Articolo` | the Mexal `_ARCOD`, an opaque string — [the risk](risks/Risk%20-%20normalising%20an%20article%20code%20merges%20two%20products.md) |
| `Descrizione Articolo` | free text, and **the only place a tranche number appears** |
| `Flag_Annullato` | `S`/`N` |
| `Unità di Misura` | the field the 05/10 UAT asked to be put on the Plus products — **the source already carries it** |
| `Natura Articolo` | 🔑 decoded by the Campi Oggetti workbook as **"genera biglietto SI/NO (mexal)"** — whether the article produces a ticket |
| `_ARSTA` / `_ARSTN` | the letter and number that compose `Categoria Articolo` |
| `Categoria Articolo` | `C10`, `E07`, `S10` … |
| `Descrizione Categoria` | the human name of the category |
| `Tipo Biglietto` | `Executive`, `Gold`, `Diamond` (+ blank) |
| `Gruppo Articolo` | mostly empty |
| `Prezzi Listino` | **not recorded** |
| `LIVELLO_0` … `LIVELLO_6` | `LIVELLO_0` is the top grouping; `_1`–`_6` are `ND` throughout |
| `NR_Tranche` | 🔴 **present in the header and empty on every row** — [OI-210](items/OI-210%20The%20delivered%20article%20registry%20carries%20no%20tranche%20count.md) |

## 🔑 The authoritative category table

From the registry's own pivot. `annullato` / `active` are counts of
`Flag_Annullato` = `S` / `N`.

| `LIVELLO_0` | Cat. | Description | annullato | **active** |
| --- | --- | --- | --- | --- |
| A) Consulenze | `C10` | Performance Plus | — | **23** |
| A) Consulenze | `C11` | Performance Plus - Rinnovo | — | **4** |
| A) Consulenze | `C20` | 🔑 **Servizi Google** | — | **3** |
| A) Consulenze | `C21` | 🔑 **Servizi Google - Rinnovo** | — | **1** |
| A) Consulenze | `C30` | Servizi aggiuntivi | — | **14** |
| A) Consulenze | `C40` | 🔑 **Manuale Operativo** | — | **7** |
| A) Consulenze | `C41` | 🔑 **Menù Engineering** | 1 | **2** |
| B) Eventi | `E01` | Tour | 26 | — |
| B) Eventi | `E02` | Food Marketing Festival | 9 | **9** |
| B) Eventi | `E03` | Pienissimo Live | 16 | **4** |
| B) Eventi | `E04` | Academy | 11 | **4** |
| B) Eventi | `E05` | Sold Out | 6 | **3** |
| B) Eventi | `E06` | ODB Live | 5 | **3** |
| B) Eventi | `E07` | Camerieri Venditori | 26 | **4** |
| B) Eventi | `E08` | 🔑 **Happy Team** | — | **3** |
| B) Eventi | `E09` | Mastery | 10 | **4** |
| B) Eventi | `E10` | 🔴 **Golden Numbers** | 5 | — |
| B) Eventi | `E10` | 🔴 **Pienissimo Intensive** | 14 | **8** |
| B) Eventi | `E99` | Z2) Blocchi | **469** | 🔴 **0** |
| C) Prodotti | `P10` | My Pienissimo | 4 | **71** |
| C) Prodotti | `P20` | Libro | 5 | **1** |
| C) Prodotti | `P30` | Altri prodotti | 5 | **23** |
| D) Software | `S10` | Software | 136 | — |
| E) Addebiti | `Z10` | Addebiti vari | — | **6** |
| Z) Obsoleti | `00` | Z) Obsoleti | 65 | — |
| **Total** | | | **813** | **197** |

## What it settles, and what it breaks

- 🔴 **`E10` names two different events** — `Golden Numbers` and `Pienissimo
  Intensive`. A category code is the key any article→edition mapping would use,
  so `E10` cannot classify an article on its own
  ([OI-96](items/OI-96%20Edition%20mapping%20table%20on%20Salesforce.md)).
- 🔴 **Not one active `blocco`.** All 469 `E99` articles are `annullato`. The
  bundle-only article codes
  ([OI-48](items/OI-48%20Bundle-only%20article%20codes.md)) do not exist as live
  articles, consistent with
  [OI-98](items/OI-98%20The%20Mexal%20article%20registry%20is%20being%20re-created.md)
  re-creating the registry.
- 🟢 **`Happy Team` is a first-class event category with three active
  articles** — independent registry confirmation of the correction in
  [OI-46](items/OI-46%20Bundle%20classification%20picklists.md). `Happy Team` is
  now present in `Product2.Evento__c` (added in `dd4e95c`).
- 🟢 **`Golden Numbers` has no active article**, which matches the Prodotti e
  Bundle workbook classing it `Evento annullato`; its absence from `Evento__c`
  is therefore not a gap.
- 🔑 **`C20` is specifically `Servizi Google`, with a renewal twin `C21`.**
  [OI-188](items/OI-188%20Performance%20Plus%20products%20are%20identified%20by%20the%20Mexal%20article%20category.md)
  records `C20` as "additional / spot services, incl. Google"; the registry is
  narrower, and adds `C21`, `C40` and `C41`, none of which that note mentions.
- 🔑 **Only 197 of 1,010 articles are live**, 42 of them event articles across
  nine categories. Any migration or mapping scope should be measured against
  197, not 1,010.
- 🔑 Performance Plus articles encode the tranche **in the description** —
  `PERFORMANCE PLUS TRANCHE 1/5` … `5/5`, `TRANCHE MENSILE 2 (RINNOVO)`,
  `CONSULENZA STRATEGICA SUL WEB TRANCHE 1` … `4`, plus omaggio variants. One
  article per tranche, which is **not** the one-article-plus-count model the
  05/10 UAT agreed.
