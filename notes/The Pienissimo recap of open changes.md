---
id: ref-recap-modifiche-2026-11-12
type: reference
status: active
owner: Elena Spini
org: ROMI
raised: 2026-11-12
updated: 2026-11-12
depends_on: [OI-344]
blocks: []
source: Drive 1D2hnr7PAysXpPR-37P6pw44dcgF7sbiV
---

# The Pienissimo recap of open changes

**`Pienissimo_Recap_Modifiche_2026-11-12.xlsx`, the first client-facing document to
give every outstanding change request a status, a feasibility note and a date. It
was produced from the [12/11 internal call](meetings/2026-11-12%20INTERNA%20Modifiche%20Marco.md)
and sent to Pienissimo two hours later. It is the authority for what ROMI has
promised about the post-training change list.**

| | |
| --- | --- |
| File | Drive `1D2hnr7PAysXpPR-37P6pw44dcgF7sbiV`, created **2026-11-12 18:37:22Z**, modified 18:38:31Z |
| Owner | Elena Spini |
| Sent | Gmail `1a1d112a02556458`, **18:43:27Z**, to Fabrizio Paganelli and Marco Montesi, cc Sabatino Rinaldi, amministrazione, Aurel Mrruku |
| Rows | **12**, numbered 1-13 with 4 and 9 absent |

## The covering mail

> _"vi scrivo per fare un recap di tutti i punti che abbiamo aperto dopo la
> formazione e i test di questa settimana … Oggi avevamo in programma di chiudere
> con Aurel gran parte di queste modifiche, ma nel corso della giornata sono emerse
> altre questioni legate alle attivita di migrazione e, come richiesto da voi,
> abbiamo dato priorita a quelle. **Le modifiche richieste slittano quindi
> all'inizio della settimana prossima.**"_
>
> _"le modifiche semplici le realizziamo a inizio settimana prossima; alcune
> richieste (ad esempio CC e piu destinatari nell'invio del preventivo) le gestiamo
> **dopo il go-live, in manutenzione**; per un paio di punti serve uno sviluppo
> dedicato e li pianifichiamo insieme"_

## The rows

| # | Area | Request | State | When |
| --- | --- | --- | --- | --- |
| 1 | Formati | Italian formats everywhere — dates (tranche and Community), thousands/decimal separators, space before `€` | Da implementare | start of next week → [OI-358](items/OI-358%20The%20org%20is%20not%20set%20to%20Italian%20date%20and%20number%20formats.md) |
| 2 | Prodotti | Categoria/sottocategoria: drop `Altri servizi`, keep `Cassa Zucchetti`, add the missing values (e.g. `Libro`), check `Generica` | Da implementare | start of next week |
| 3 | Preventivo | Primary quote visible in the quote list view and the opportunity compact layout | Da implementare | start of next week |
| 5 | Lead | `Fonte lead` → `Origine del lead` | **Parzialmente fattibile** — the label is a standard field and cannot be translated; **the picklist values can** be Italian, aligned to the form values. ⚠ `Sito` or `Website` still to confirm | start of next week → [the lead source values](The%20Pienissimo%20lead%20source%20values.md) |
| 6 | Account | Note object linked to Account | Da implementare | start of next week |
| 7 | Asset | Show the reference order in the Account's Asset view | Da implementare | start of next week |
| 8 | Utenti | Home page and calendar not visible to agents | Da implementare | **calendar** next week, **home undefined** → [OI-364](items/OI-364%20Agents%20cannot%20see%20the%20home%20page%20or%20the%20calendar%20in%20production.md) |
| 10 | Preventivo | CC and multiple recipients on the quote send | **Da pianificare** — _"Funzione gia sviluppata e poi tolta su vostra richiesta"_ | **after go-live, in maintenance** |
| 11 | Preventivo | Running economic total while inserting products, net of discounts and tranches | Da pianificare — dedicated development; Grand Total exists in the header | — |
| 12 | Tranche | Tranche amount live while assigning products, updating in real time | Da pianificare — needs recalculation on delete and move | — |
| 13 | Preventivo | Totals of all columns in the related products table | **Non fattibile** — standard component; Grand Total already covers it | - |

## How it relates to the client's own sheet

🔑 This is **ROMI's answer to** [`Modifiche flussi Sales`](items/OI-344%20The%20client%20sent%20sixteen%20Sales%20flow%20changes%20and%20none%20is%20triaged.md),
Marco Montesi's sheet, which now carries its own `Lavorato` column. The two
disagree in one place: the client's sheet marks **`Aggiunta campo cc` as `NON SI
FA`**, while this recap schedules it for maintenance after go-live. ⚠ Not
reconciled.

🔴 And the requester is leaving —
[OI-357](items/OI-357%20The%20client%20commercial%20lead%20and%20the%20web%20counterpart%20are%20both%20leaving.md).
