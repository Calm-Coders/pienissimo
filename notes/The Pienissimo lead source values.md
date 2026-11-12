---
id: ref-fonte-lead-values
type: reference
status: active
owner: Marco Montesi
org: Pienissimo
raised: 2026-11-11
updated: 2026-11-12
depends_on: [OI-265, OI-340]
blocks: []
source: Drive 1PHX-sgHAfOHdy8RF8W3iowhXBDar8Pf8
---

# The Pienissimo lead source values

**`Fonte_lead_Salesforce.xlsx` — the eleven lead-source values the client wants,
each with a written rule for when to use it. It is the first picklist list this
project has received with usage guidance attached, and it arrived from Marco
Montesi four days before go-live and days before he resigned.**

| | |
| --- | --- |
| File | Drive `1PHX-sgHAfOHdy8RF8W3iowhXBDar8Pf8`, created **2026-11-11 15:32:27Z**, modified **2026-11-12 18:19:34Z** |
| Arrived as | attachment on Marco Montesi's `Visualizzazione Pagina Principale` mail, Gmail `1a1cb3d36d4df47d` |
| Covers | row 7 of [`Modifiche flussi Sales`](items/OI-344%20The%20client%20sent%20sixteen%20Sales%20flow%20changes%20and%20none%20is%20triaged.md) and row 5 of [the recap](The%20Pienissimo%20recap%20of%20open%20changes.md) |

Marco Montesi's covering line: _"In merito alla nomenclatura dei filtri della
**Fonte del Lead** (riga 7 drive) in allegato trovate le voci corrette, poi in
futuro vedremo se vanno bene o aggiustarle."_

## The values

| # | Value | When to use it |
| --- | --- | --- |
| 1 | **Marketing** | any marketing action — campaigns, social, site, chat. A single value until the activities are distinguished |
| 2 | **Partner** | referred by a commercial partner |
| 3 | **Fiera** | met at a trade fair (e.g. Sigep) |
| 4 | **Diretta** | signed up for a livestream or webinar, **even if they then no-showed** |
| 5 | **Libro** | bought the book independently and then made contact |
| 6 | **Tutor** | brought in by a tutor |
| 7 | **Segnalazione cliente (referral)** | a customer referred them **and we know who** |
| 8 | **Passaparola** | heard of us from someone, with no specific referrer |
| 9 | **Ci conosce gia** | has heard of Pienissimo or seen it in other restaurants but recalls no channel — _"non insistere"_ |
| 10 | **Segnalazione interna** | referred by a Pienissimo collaborator, tutors excluded |
| 11 | **Segnalazione Direzione** | referred by the Direzione |

## The two rules attached to the list

1. 🔑 **No value may carry a year or a date.** _"Nessun valore con anno o data:
   l'edizione specifica va nel campo campagna/UTM."_ The marketing channel detail
   stays in the **UTM fields**, which become useful when `Marketing` is later split.
2. 🔑 **Events do not generate leads.** _"Gli eventi non generano lead: chi partecipa
   e gia qualificato."_
3. **No-shows** return to the normal cycle as `New` with source `Diretta`.

## What this does and does not settle

🟢 It gives the Italian values for the picklist, which is the half of row 5 that
**is** feasible — the field label `Fonte lead` is standard and cannot be
retranslated ([the recap](The%20Pienissimo%20recap%20of%20open%20changes.md)).

🔴 **It is not aligned to what the website forms actually send.** The recap records
the open question as _"vanno allineati ai valori inviati dai forms (resta da
confermare se usare **`Sito`** o **`Website`**)"_ — and `Sito` is not in this list
at all. Fabrizio Mastracci had already set the incoming value to `Website` as a
stopgap, on 5 November: _"Il form\[e\] del cliente era **sito**, ma in S\[alesforce\]
questo valore non esiste. Per ora impostato su **website**. Se preferite sito va
aggiunto all'elenco dei valori."_

🔴 It is also **not** the picklist workbook owed since 27 October
([OI-265](items/OI-265%20Opportunity%20Categoria%20and%20Sottocategoria%20values%20do%20not%20match%20the%20client%20registry.md)),
which covers categoria, sottocategoria and the rest. This is the lead-source sheet
only.

⚠ A marketing cross-check is still owed: _"Check anche lato Marketing se i campi
forniti da Marco sono ok."_
