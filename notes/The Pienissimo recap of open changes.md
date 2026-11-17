---
id: ref-recap-modifiche-2026-11-12
type: reference
status: active
owner: Elena Spini
org: ROMI
raised: 2026-11-12
updated: 2026-11-17
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

## 2026-11-16 - what has moved, and the one row that reached the client's customers

- **Row 1, the Italian locale**, is now the most visible of the twelve: the
  American date format appears on the **client-facing quote PDF**, found on the
  go-live call. Fabrizio Paganelli asked for priority because _"questi documenti
  hanno una rilevanza verso i nostri clienti"_. It goes into the **18 November**
  release, not sooner. See
  [OI-358](items/OI-358%20The%20org%20is%20not%20set%20to%20Italian%20date%20and%20number%20formats.md).
- **The lead source list in Italian** was committed on 16/11 at 18:01 CET by Anita
  Aga (`13b16da`, `DevAnita16`), not merged and not deployed.
- **Everything else slipped a second week.** Elena Spini's status post of 13/11:
  the open changes _"dovevamo chiuderle questa settimana, ma sono arrivate altre
  richieste di supporto, quindi **slittano alla prossima**"_, with the triage rule
  _"le piccole entrano in questa fase, le evolutive vanno in un secondo momento o
  come CR."_
- ⚠ **A second change list exists and is not in the repository.** Elena Spini sent
  Aurel Mrruku a workbook on Friday 13 November with further items raised during the
  tutor tests, due **Friday 20 November** — _"c'e un elenco di modifiche da fare
  entro venerdi."_ Not found in Drive or mail in the 16/11 sweep.

## 2026-11-13 - the mail this note did not yet cover

A second client-facing mail of the same kind went out on **13/11 at 14:46:20Z**
(Gmail `1a1d55fdf926a7b5`), subject
`[ROMI-PIENISSIMO] - Aggiornamento urgente per logiche Opportunity`, from Elena
Spini to Sabatino Rinaldi, amministrazione and Fabrizio Paganelli, cc Aurel Mrruku.
It is the written trace of the Opportunity derogation and is quoted in full in
[the decision](decisions/Decision%20-%20the%20Opportunity%20is%20won%20at%20the%20first%20collected%20invoice.md).

## 🔑 2026-11-17 - six of the twelve rows moved into source in one day

**The day after the users went live, and the day before the 18 November release,
six rows of this recap were built and four of them merged onto `DevMain`. It is the
largest single movement on this list since it was written — and the one row the
client asked to have prioritised is not among them.**

Eleven commits landed between 10:04 and 17:29 CET, and **three pull requests were
merged into `DevMain`**: **#128** from `DevAnita16` (10:15), **#129** from
`DevAnita_Modifications` (15:37) and **#130** from `DevMain_ExperienceCloud`
(15:58). `DevMain` moved from `18a106a` to `92899c3`: **52 files, +4,250 / -198
lines.**

| Row | Request | What landed today | State |
| --- | ------- | ----------------- | ----- |
| **1** | Italian formats everywhere | `9a23553` Community site locale `en_US` -> `it`; `eb71235` + `0e05682` `Intl.NumberFormat("it-IT", EUR, 2 decimals, grouping always)` in `quoteAcceptancePage` and `quoteManageProducts`; `654618c` further price-format fixes | 🟡 **currency and Community language only — see below** |
| **2** | Categoria/sottocategoria: drop `Altri servizi`, keep `Cassa Zucchetti`, add `Libro`, check `Generica` | `ca4e2ad` on Lead and Opportunity `Categoria__c` / `Sottocategoria__c` and five record types | 🟢 **done as asked** |
| **3** | Primary quote in the quote list view and the opportunity compact layout | `e66bdbb` — `Is_Primary__c` into four Quote list views, a new `mine` list view, and `Opportunity_Awesome_Companct_Layout` | 🟢 **done as asked** |
| **5** | `Fonte lead` picklist values in Italian | `13b16da` `LeadSource.standardValueSet`, 59 lines of Italian labels, merged in PR #128 | 🟢 **in source on `DevMain`** |
| **6** | Note object linked to Account | `0e05682` — `RelatedContentNoteList` on the Account and Locale layouts, `AttachedContentNotes` related list on the Azienda and Locale record pages | 🟢 **done as asked** |
| **7** | Show the reference order in the Account's Asset view | `86682d0` — a new Order formula field on Asset _"so we can use it on the Asset related list on Account"_ | 🟡 **built but on `DevAnita17` only** — not merged |
| **8** | Home page and calendar not visible to agents | `f2a3294` — `Getting_Started_Home` flexipage, `salesHomeTemplate` Aura component, three home reports, `Agente` profile and permission-set changes, merged in PR #128 | 🟡 **the home page now exists in source** -> [OI-364](items/OI-364%20Agents%20cannot%20see%20the%20home%20page%20or%20the%20calendar%20in%20production.md) |

### Row 2, verified rather than assumed

`Altri Servizi` and `Generica` are **still present** in the value set but carry
`isActive: false`. 🔑 That is the correct way to retire a picklist value without
orphaning the records that already hold it, so the commitment _"drop `Altri
servizi`"_ **is** met, and the open question _"check `Generica`"_ is answered the
same way. `Cassa Zucchetti` is kept; `Libro` is added, together with `Corso`,
`Pacchetti`, `Servizi Mktg`, `Piattaforma` and `Servizi Revenue`.

### 🔴 Row 1 is the one that reached the client's customers, and the date format is still not in source

The client asked for **the date format** by priority on 16/11, because the American
order appears on the quote PDF that goes to Pienissimo's own customers — _"visto che
questi documenti hanno una rilevanza verso i nostri clienti, dagli la priorita, se
riesci a sistemarlo anche in giornata."_ It was deferred to the 18 November release.

⚠ **As of this sweep the `DevMain` delta contains no date-format change at all** —
no Visualforce page, no PDF or email template, and no `DateTimeFormat`, `dd/MM` or
locale-date edit anywhere in the 52 changed files. What landed is **currency and
number** formatting and the **Community site language**. The release is tomorrow.

See [OI-358](items/OI-358%20The%20org%20is%20not%20set%20to%20Italian%20date%20and%20number%20formats.md)
for the org-level locale, which is also still open.

### What this means for the Friday commitment

Aurel Mrruku's own target was _"entro venerdi riesco a finire tutto quello che m'ha
detto, e c'ho il 18"_ — everything on Elena Spini's list by **Friday 20 November**.
🟢 On the evidence of one day, four rows are done and two more are built. 🔴 Against
that: **rows 10, 11, 12 and 13 were never in scope for this week** (maintenance or
dedicated development), the **second change workbook of 13/11 is still not in the
repository** so its items cannot be counted at all, and Elena Spini has been on
leave since 16/11 and returns on the 19th — so nobody on the ROMI side has checked
any of this against what she promised.

⚠ **Nothing here was verified in the org.** Every statement above is from the source
tree and the git history. `MexalSyncController.cls` — 400 lines of new Apex merged
in PR #128 — **has no Apex test class**; recorded as state per the standing
instruction and **not acted on**.
