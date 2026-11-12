---
id: OI-344
type: open-item
status: in-progress
owner: Marco Montesi
with: Elena Spini
org: both
raised: 2026-11-06
updated: 2026-11-12
depends_on: [OI-265]
blocks: [go-live]
source: Drive 1y4DeVJEjd3g5vPo-LqYyczQbc0BRp9jVfVw9RJA7Yh8, read 2026-11-06
---

# OI-344 - The client sent sixteen Sales flow changes and none is triaged

**Marco Montesi shared a spreadsheet called `Modifiche flussi Sales` with ROMI on
6 November at 10:03Z. It is a sheet named `Romi` holding sixteen requested changes
to the Sales flow, with a `Lavorato` column that is entirely empty. It is the
first consolidated change list the client has produced, it arrived ten days before
the 16 November user start, and nothing in any source acknowledges it.**

## The artifact

| | |
| --- | --- |
| Title | `Modifiche flussi Sales` — native Google Sheet, sheet `Romi`, range `A1:C18` |
| Drive id | `1y4DeVJEjd3g5vPo-LqYyczQbc0BRp9jVfVw9RJA7Yh8` |
| Owner | **`marco.m@pienissimo.com`** (Marco Montesi) |
| Created | 2026-10-28 16:27:54Z — **nine days before it was shared** |
| Shared with ROMI | **2026-11-06 10:03:45Z** |
| Last modified | **2026-11-06 16:55:11Z** — he was still editing it today |
| Notification | Gmail `1a1b050856e30cd3`, 10:03:48Z, _"Marco has invited you to edit the following spreadsheet: Modifiche flussi Sales"_, cc Elena Spini, `elisa.pienissimo@`, `fabrizio.pienissimo@`, `sabatinopienissimo@` |

🔑 **It was written on 28 October — during the UAT commercial testing — and held
for nine days.** ⚠ Whether it was shared late or only finished today is not
established; it was modified again six hours after sharing.

## The sixteen rows, as written

Columns are `Macro` / `Attivita` / `Lavorato`. One row (`Task`) carries a macro
with no activity text.

| # | Macro | Activity |
| --- | --- | --- |
| 1 | Categorie | _"Lista voci incompleta → lista completa gia inviata + compilazione da rendere obbligatoria"_ |
| 2 | Sottocategorie | _"Lista voci incompleta → lista completa gia inviata + compilazione da rendere obbligatoria"_ |
| 3 | Correlati | _"Dentro area Tranche dei correlati come si torna indietro? Si deve usare la freccia del browser?"_ |
| 4 | Task | — **empty** |
| 5 | Informazioni Lead | _"Fonte dal Lead → rivedere lista e metterla in italiano"_ |
| 6 | Preventivi | _"Dentro area Opportunities dei correlati come si identifica il primario?"_ |
| 7 | Preventivo | _"Possibilita di avere anteprima senza dover creare il pdf"_ |
| 8 | Preventivo | _"Dentro la tabella preventivo dei correlati sarebbe utile avere i totali di tutte le colonne e quello generale"_ |
| 9 | Preventivo | _"Nella fase di inserimento prodotti visualizzare il valore economico totale che si genera anche in funzione degli sconti"_ |
| 10 | Tranche | _"Dentro la tabella tranche dei correlati sarebbe utile avere il valore di ogni tranche e il totale generale"_ |
| 11 | Tranche | _"Dentro area Tranche dei correlati (dove c'e la lista) manca il valore di ogni singola tranche"_ |
| 12 | Tranche | _"Nella fase di creazione Tranche visualizzare il valore economico che si va a generare"_ |
| 13 | Nota | _"Possibile indicare dentro al record collegato (es: Account, Opportunita, ecc...) che e stata creata una nota?"_ |
| 14 | Mail a cliente per accettazione | _"Rivedere testo e oggetto mail + aggiunta campo cc"_ |
| 15 | Preventivo anteprima via mail | _"Rivedere contenuti"_ |
| 16 | Preventivo anteprima via mail | _"Rivedere contenuti Popup"_ |

## What is in it that the record did not already hold

1. 🔑 **Rows 1 and 2 are the client's answer to
   [OI-265](OI-265%20Opportunity%20Categoria%20and%20Sottocategoria%20values%20do%20not%20match%20the%20client%20registry.md),
   in writing, for the first time.** OI-265 is the open disagreement about whose
   `Categoria`/`Sottocategoria` list is current — Elena Spini asked _"ci sono i
   valori che ci avete condiviso ultimamente, non vi torna?"_ on 19 October and
   never got a reply. **The client's position is now stated: the list is
   incomplete and the complete one has already been sent.** ⚠ **Which transmission
   he means is not identified**, and the picklist workbook has been owed for
   fifteen days. 🆕 **And he adds a new requirement: both fields must become
   mandatory.**
2. 🆕 **Row 5 asks for the Lead `Fonte` list to be revised and translated into
   Italian.** That list is the one `Website` was used on two days ago, because
   `Sito` does not exist in it
   ([OI-340](OI-340%20The%20website%20lead%20forms%20have%20no%20field%20for%20the%20marketing%20consent.md)).
3. 🆕 **Rows 8 to 12 are one request five times: money must be visible where
   quote lines and tranches are entered and listed.** Per-tranche value, column
   totals, grand totals, and the discounted total while products are being added.
   ⚠ **No catalogue figures appear in the sheet** and none is recorded here.
4. 🆕 **Row 7 asks for a quote preview that does not generate the PDF** — the PDF
   path is the one with the tranche-before-PDF guard shipped on 5 November and
   the unresolved `allegato B` signature question
   ([OI-336](OI-336%20The%20quote%20PDF%20allegato%20B%20has%20no%20signature%20field.md)).
5. 🆕 **Rows 14 to 16 reopen the client-facing acceptance mail**: text, subject,
   a cc field, and the content of the preview mail and its popup.
6. 🆕 **Rows 3, 6 and 13 are usability questions, not defects** — how to navigate
   back out of the Tranche related area, how the primary quote is identified among
   related Opportunities, and whether a linked record can show that a Note exists.
   🔑 **Row 13 is the Note object Elena Spini described to him on 27 October as a
   plain internal memo that _"non attiva automatismi, flussi o notifiche"_** — he
   is asking for exactly the indicator she said it would not give.

## Why it matters now

- 🔴 **The `Lavorato` column is empty on all sixteen rows**, in a sheet ROMI can
  edit, six hours after it was last touched by the client.
- 🔴 **No mail, Slack message or meeting in this window mentions it.** It arrived
  as a Drive share notification and that is all.
- ⚠ **At least three rows are requirement changes, not bugs** — mandatory
  `Categoria`/`Sottocategoria`, the revised `Fonte` list, the acceptance-mail
  content — so they belong in the register and in both prose documents if they are
  accepted. **The register is untouched at v1.6**; these are **v1.7 candidates**
  and nothing more until someone rules on them.
- ⚠ Whether this list is Fase 1 remediation or Fase 2 scope is **not stated
  anywhere**, which is the same unanswered question as
  [OI-343](OI-343%20The%20client%20disputes%20that%20the%20stage%20sale%20contract%20was%20outside%20the%20Fase%201%20Blueprint.md).

## What is owed

- A triage of the sixteen rows: defect, usability, or requirement change.
- A ruling on the two mandatory-field requests and the complete picklist list the
  client says he already sent (OI-265).
- A statement of which rows are in scope before the 16 November user start.


## 🟡🔑 2026-11-09 - the sheet grew to seventeen rows, triage started, and ROMI has a rule

**Three days on, the file has moved and so has ROMI's position — but the two have
not met.**

### What changed in the sheet

Re-read 2026-11-09, **last modified 2026-11-09 15:30:13Z**. The range is now
**`A1:D19`**, not `A1:C18`:

1. 🆕 **A fourth column exists.** Unlabelled, carrying one value: **`CR`** against
   the quote-preview-without-PDF row.
2. 🆕 **One row was added** — `Preventivo` · _"Dentro la tabella preventivo dei
   correlati sarebbe utile avere **il valore di ogni riga**"_ — and row 10's text
   was split, so the per-row and grand-total requests are now separate asks.
   **Seventeen activity rows.**
3. 🆕 **The empty `Task` row is now filled**: _"**Lasciare solo funzioni
   necessarie**"_. It was a macro with no activity text on 6 November.
4. 🟡 **`Lavorato` is no longer empty.** Four rows are marked:

| Row | Marked |
| --- | --- |
| `Task` — leave only the necessary functions | **SI** |
| `Preventivo` — per-line value in the related list | **SI** |
| `Tranche` — per-tranche value in the related list | **SI** |
| `Preventivo` — preview without generating the PDF | **TBD**, and **`CR`** in column D |

🔴 **Thirteen of seventeen rows are still blank.**

⚠ **Who marked them is not established.** The sheet is client-owned and
ROMI-editable, and Drive metadata does not attribute a cell. **`CR` is read here as
_change request_** — ⚠ an inference, not a stated key — which would make it the
first row anyone has classified as scope rather than remedy.

### 🔑 ROMI's triage rule, stated for the first time

Elena Spini, `#tproj-pienissimo`, **2026-11-09 09:00:06 CET**:

> _"Dal foglio che Marco ha mandato il 6/11 (**una quindicina di punti**) **le
> modifiche di layout e di campi le facciamo in Fase 1, il resto va in una Fase 2
> successiva.**"_

🟢 **That is the ruling this item asked for**, and it answers the Fase 1 / Fase 2
question in principle. 🔴 **But it is a rule, not a triage**: no row has been
assigned to a side of it, and the rule does not obviously decide most of the
seventeen rows — a grand total inside a related list is neither a layout change nor
a field, and the five money-visibility asks are the bulk of the sheet.

🟢 **And she owns the next step**, from her own Next step list: _"Elena – **sentire
Marco sul foglio delle modifiche**: chiarire i punti poco chiari e confermare cosa
entra in Fase 1."_ ⚠ **Nothing in this window shows that conversation happening**,
and she told the marketing group at 17:19:43 CET only _"poi vi chiedo domani"_.

### Where it stands

- 🔴 **Seven days before the 16 November user start**, four of seventeen rows are
  marked and none is scheduled.
- 🔴 **Rows 1 and 2 are unmarked** — the `Categoria`/`Sottocategoria` lists and the
  mandatory-field request, which still collides head-on with `b0e69c5` making both
  read-only for `Agente`
  ([OI-265](OI-265%20Opportunity%20Categoria%20and%20Sottocategoria%20values%20do%20not%20match%20the%20client%20registry.md)).
  **Sixteenth day** without the picklist workbook.
- ⚠ **The register stays v1.6.** The mandatory picklists and the revised `Fonte`
  list remain **v1.7 candidates**; the `CR` marking is the first sign anyone agrees
  one of these is a change, and it is on a different row.

## 🟡🔑 2026-11-12 - the sheet is triaged at last, and ROMI answered it formally

**`Modifiche flussi Sales` (`1y4DeVJEjd3g5vPo-LqYyczQbc0BRp9jVfVw9RJA7Yh8`),
modified 2026-11-12 17:21:50Z, now reads `A1:E21` — twenty request rows — and the
`CR` column of 09/11 has been replaced by a `Lavorato` column with a verdict on
most rows.**

| Verdict | Count | Rows |
| --- | --- | --- |
| `SI` | 5 | Correlati back-navigation · Task cleanup · per-row value in the quote table · column + general totals in the quote table · per-tranche value in the tranche list |
| `IN LAVORAZIONE` | 6 | Categorie · Sottocategorie (both still _"lista completa gia inviata + compilazione da rendere obbligatoria"_) · identifying the primary quote · running total while inserting products · general total in the tranche table · the Note-created indicator |
| `NON SI FA` | 2 | quote **preview without generating the PDF** — _"grossa modifica strutturale, rimane cosi"_ · **`Aggiunta campo cc`** |
| blank | 7 | lead source list · both _"Rivedere testo e oggetto mail"_ rows · both preview-mail rows · tranche creation values · the OPPORTUNITY work queue — five of these annotated _"inviato indicazione via mail"_ |

🟢🔑 **And ROMI answered it formally**, in
[the recap sent to the client at 18:43Z](../The%20Pienissimo%20recap%20of%20open%20changes.md):
twelve rows with a state, a feasibility note and a date — simple changes at the
start of next week, CC and multiple recipients **after go-live in maintenance**, two
items needing dedicated development, one declared impossible.

### 🔴 The one contradiction

The client's sheet marks **`Aggiunta campo cc` as `NON SI FA`**; ROMI's recap
schedules the same request for maintenance after go-live. On the internal call it
was confirmed that the feature **was built and then removed at the client's own
request** — Aurel Mrruku: _"Han detto no non lo vogliamo cosi"_ → _"Se lo vuoi lo
faremo appena abbiamo del tempo dopo Go Live."_ ⚠ Not reconciled with the sheet.

### What the triage rule did and did not do

ROMI's own rule of 09/11 — _"le modifiche di layout e di campi le facciamo in Fase
1, il resto va in una Fase 2 successiva"_ — is now **effectively applied** in the
recap, but by a different vocabulary (next week / maintenance / to be planned /
not feasible) and 🔴 **no row is labelled Fase 1 or Fase 2 anywhere**. The home-page
work queue, the largest request, is simply _"da definire"_
([OI-364](OI-364%20Agents%20cannot%20see%20the%20home%20page%20or%20the%20calendar%20in%20production.md)).

### 🔴 The requester is leaving

Marco Montesi, whose sheet and whose mail of 11/11 15:32Z this is, has resigned →
[OI-357](OI-357%20The%20client%20commercial%20lead%20and%20the%20web%20counterpart%20are%20both%20leaving.md).
Internally the question of whether the list survives him was raised and left open:
_"Secondo me se te li dimentichi non nessuno si ricorda"_ → _"purtroppo c'era anche
Fabrizio ahime, quindi siam fregati."_ The recap went to the client regardless.

🟢 **Two of the blanks were filled by his 11/11 mail**: the lead-source values →
[the list](../The%20Pienissimo%20lead%20source%20values.md), and the tranche-creation
values — _"È necessario che mentre si creano le tranche, si veda il valore della
singola tranche ma anche il totale che si va a creare"_. 🔴 He also reported the
quote and pop-up wording **still wrong**: _"le diciture sia del preventivo generato
che del pop up erano tutti sballati, forse ci stavate lavorando."_
