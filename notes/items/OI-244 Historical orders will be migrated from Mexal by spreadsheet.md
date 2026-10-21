---
id: OI-244
type: open-item
status: open
owner: Aurel Mrruku
with: Fabrizio Paganelli
org: both
raised: 2026-10-15
updated: 2026-10-21
depends_on: [OI-245, OI-165, OI-267, OI-274, OI-275, OI-276, OI-280]
blocks: [go-live]
severity: gating
source: notes/meetings/2026-10-15 Migrazione e Go-Live.md
---

# OI-244 - Historical orders will be migrated from Mexal by spreadsheet

**The migration source changed. Historical orders no longer come from the Zoho
quote extractions — they come out of Mexal as a spreadsheet, mapped by the
client onto a field list Aurel Mrruku owes him by the evening of 16 October.
This is the first migration method the project has ever agreed.**

Agreed at [the 15/10 session](../meetings/2026-10-15%20Migrazione%20e%20Go-Live.md)
(`00:25`–`00:40`).

## Why the source changed

Elena Spini reported the previous day's exchange with Fabrizio Paganelli: the
Zoho extractions are the critical problem — _"delle estrazioni di Zo[h]o di
preventivi, preventivi testate, preventivi righe"_ — and _"lì c'è da mettere
mani perché … ci sono delle cose da rivedere"_. His own proposal was to bring
the orders up from Mexal instead, and the session adopted it.

Aurel Mrruku's constraint makes it a spreadsheet rather than an integration:
_"su Mexal io non c'ho un[']API che prende gli ordini da Mexal"_. The order→Mexal
direction exists; the reverse does not.

## The method, as agreed

1. **Aurel Mrruku produces the field specification by the evening of 16 October**
   — _"entro domani sera ti creo un Excel con tutti i campi che servono a me a
   livello di ordine, a livello di orderline"_ — with expected example values,
   because the mapping is the client's to do: _"devi essere te a fare il match
   dei campi"_.
2. **Fabrizio Paganelli populates it from Mexal.** His own archives are
   _"giganteschi"_ at about a hundred fields each, which is exactly why he asked
   for a short list: _"se invece tu mi dai esattamente i i 10 15 campi che ti
   servono, io dove li trovo te li popolo"_.
3. **Two sheets, joined by a key**: order, and order line carrying a reference to
   its order — _"ogni riga d'ordine deve avere una reference, quindi una chiave
   che lo collega con l'ordine"_.
4. **The customer reference comes with it**, as the external id, and the agent
   with the customer — _"se c'è il cliente in automatico c'avrà anche l'agente"_.
5. **Invoices and scadenzari are explicitly not wanted** — _"le fatture non mi
   interessa perché le fatture ce le ho già. Fatture scadenziari le ho già prese
   tutte."_
6. **State is derived, not imported.** The orders load as placed and the existing
   nightly procedure reconciles them against the Mexal id, so they become
   invoiced and partly collected by running the integration rather than by being
   declared so. Fabrizio Paganelli: _"facciamo girare la procedura quella di
   interfaccia e in linea teorica tutti quegli ordini lì dovrebbero essere
   fatturati … ed anche incassati parzialmente perché magari non tutte quelle
   fatture sono state pagate."_
7. **It runs twice**: a mapping-and-test load into UAT now, then the real
   migration **on the day production goes live** — _"nel giorno in cui si va in
   produzione, facciamo la migrazione da quel momento in poi"_, because anything
   loaded earlier goes stale as the client keeps trading.
8. **First pass is deliberately small** — _"magari ti posso inizialmente passare
   degli ordini … solo pochi parzialmente [fatturati]"_.

Aurel Mrruku's caution is of record and nobody disputed it: _"non sarà un lavoro
facile, non andrà tutto lì, ti assicuro"_, and when it breaks _"ti dico
esattamente cosa non è andato bene e cerchiamo di farlo a mano a sto punto"_.

## Volumes

Two figures were given a minute apart and the transcript does not reconcile them:

| Figure               | Scope as stated                                        |
| -------------------- | ------------------------------------------------------ |
| _"20.000 record"_    | Fabrizio Paganelli's first guess, _"un numero a caso"_ |
| **~51,000**          | order **lines**, _"dal primo gennaio 23 ad oggi"_      |
| **~10,000 per year** | his own reading of the recent years                    |

He attributes the difference to volume history — 2023 and 2024 carry many more
lines because the platform sale no longer runs. ⚠ **Orders and order lines are
different counts and the session mixed them**; the field spec will have to state
which number applies to which sheet. These figures sit alongside, and do not
replace, the Zoho-side volumes in
[OI-79](OI-79%20Migration%20volumes%20and%20mapping%20method.md).

## 🔴 What this does not settle

1. **It rests on a disputed fact.** Whether Mexal still holds an order after that
   order has been invoiced is contradicted between Aurel Mrruku (citing Mirko
   Merendi) and Fabrizio Paganelli — see
   [OI-245](OI-245%20Whether%20a%20Mexal%20order%20survives%20invoicing%20is%20disputed.md).
   If Aurel Mrruku is right, the archive Fabrizio Paganelli proposes to extract
   does not exist in the form he describes, and step 2 fails.
2. **No date for the client's half.** Aurel Mrruku's deliverable has a deadline
   (16/10 evening); the population, the test load and the verification do not.
   The real load is pinned to go-live day, which is **2 November**
   ([OI-243](OI-243%20Go-live%20moved%20from%2021%20October%20to%202%20November.md)) —
   two days **after** the Zoho contract expires, so there is no fallback behind
   it ([the risk](../risks/Risk%20-%20go-live%20now%20falls%20after%20the%20Zoho%20contract%20expires.md)).
3. **Order line states are unmapped.** Aurel Mrruku raised it directly — the
   Salesforce row states (`pagato`, `non pagato` and the rest) are unlikely to
   exist in Mexal: _"Non penso che hai lo stesso valore anche in Mexal."_ The
   exchange moved on without answering it.
4. **The derived-state plan has never been tested on imported data.** It depends
   on the scadenzario sync, which
   [OI-239](OI-239%20The%20Mexal%20scadenzario%20sync%20must%20run%20every%20half%20hour%20and%20nothing%20schedules%20it.md)
   records as scheduled by nothing and run by pasting Apex into a console, and on
   the payment predicate
   [OI-212](OI-212%20A%20Ri.Ba.%20rate%20reads%20as%20paid%20before%20its%20due%20date.md)
   records as wrong. **Deriving `incassato` for ~10,000 historical orders through
   a predicate known to read unpaid rates as paid would produce wrong figures at
   volume**, and no source connects these.
5. **Accounts are already done; orders are not.** Accounts and contacts are
   imported in UAT from Mexal and refresh nightly — _"tutti gli account li prendo
   da Mexal"_. That is the precedent being extended, and it is the only part of
   migration with any evidence behind it.

Closing it means: the field spec delivered, the client's file populated, one test
load into UAT with the state reconciliation verified against known orders, and a
dated plan for the production run.

## 🟡 2026-10-19 — the field spec is four days late, and now promised to the client in writing

**The Excel this row waits on was due on the evening of 16 October. It does not
exist. Tonight it was re-promised — to the client, in writing, for 20 October —
and the author confirmed internally that he had forgotten it.**

The sequence, all on 19/10:

1. **In session**, Fabrizio Paganelli asked for the migration meeting
   ([19/10 walkthrough](../meetings/2026-10-19%20Test%20UAT%20Commerciali.md),
   `01:26:48`): _"ci dovevamo sentire con Aurel per capire … il tema del
   dell'importazione massiva degli ordini"_. Elena Spini sized it — _"un'oretta
   per quello lo fisserei"_ — and took the scheduling. Wednesday was agreed in
   the room over Thursday.
2. **Elena Spini to the client, 15:10:55Z** (Gmail `1a154a97e004a741`), making it
   a commitment ROMI now owns in front of Pienissimo:

   > _"domani Aurel ti manderà il file Excel indicando tutti i campi necessari
   > (sia per l'ordine che per la riga d'ordine) per effettuare i test di
   > migrazione dei dati storici da Mexal. Fisso comunque lo slot per
   > mercoledì?"_

3. 🟢 **Fabrizio Paganelli confirmed the slot, 16:10:07Z**: _"si, lo slot per
   mercoledì lo fisserei in ogni caso"_. **So the migration meeting is agreed by
   both sides for Wednesday 21 October.**
4. **Elena Spini to Aurel Mrruku in DM, 16:55:45 CEST**, quoting the original
   undertaking back at him verbatim — _"eravamo rimasti che dovevi fare l'excel
   no? >> Creare un file Excel di tracciato …"_ — and adding _"ha chiesto news
   anche di questo Fabrizio"_. His answer, 17:01:08: **_"ciao, si me lo sono
   dimenticato"_**. Hers, 17:02:59: _"gli dico che glielo mandi domani 😉"_.
5. 🟢 **And he carried it to the dev group the same evening**, 18:05:55 CEST:
   _"neser mos te harrojm duhet mi dergu ne nje eksel te gjitha fushat qe do na
   duhen me migru order e order item"_ — tomorrow, let us not forget, we have to
   send in an Excel all the fields we will need to migrate order and order item.
   **First time this row's deliverable has been assigned to more than one
   person.**

## 🔴 What has not changed

- 🔴 **Nothing has been migrated, and nothing has been rehearsed.** The spec is
  the first of four steps in this row's closing condition and it is not written.
- 🔴 **The predicate the rehearsal would run on is still wrong.**
  [OI-212](OI-212%20A%20Ri.Ba.%20rate%20reads%20as%20paid%20before%20its%20due%20date.md)
  is byte-for-byte unchanged a **ninth** night. Deriving `incassato` for the
  historical orders through it would produce wrong figures at volume, and
  **Wednesday's meeting is three days before the training week.**
- ⚠ **Fabrizio Paganelli owes the archive file in the right format**, which he
  restated on the open line: _"ti passo sto archivio, qui è il campo, quello è il
  campo, qui è una questione formati"_. Recorded as his undertaking in the Gemini
  notes — _"Condividere il file dell'archivio storico con il formato corretto"_ —
  with no date.
- ⚠ **He also scoped the ask down, usefully**: invoiced orders only, as sales
  history — _"almeno gli ordini che sono stati anche fatturati ce li portiamo
  dentro come storico … le opportunità, tutte quelle pugnette lì non le possiamo
  caricare, ma almeno le vendite"_. **That is narrower than this row assumed**
  and is the client's own framing, so it should shape the field list rather than
  be discovered on Wednesday.

## 🟢 2026-10-20 — the field spec exists

**The Excel this row waited on was written on 20/10**, the day promised to the
client, at `output/migrazione-ordini-mexal/` in Italian
(`Tracciato migrazione ordini Mexal - Salesforce.xlsx`) and English. It is a
draft for the 21/10 meeting, **not yet sent** at the time of writing.

- **Two sheets joined by a computed key** — `SIGLA-SERIE-ANNO-NUMERO` — as agreed
  on 15/10, plus a field spec, allowed values, the cases the first batch must
  cover and eleven questions for the meeting.
- **Scoped to invoiced orders since 01/01/2023** (start date to confirm), per
  Fabrizio Paganelli's 19/10 framing. Invoices and scadenzari are excluded.
- **The line carries Mexal's internal `id_riga`**, because that is what
  `MexalInvoiceLineImportBatch` matches the invoice's origin line against
  (`Mexal_Line_Number__c`); without it the batch falls back to article plus
  quantity.
- **The net unit price loads**; list price and the discount as written in Mexal
  are control columns, because `OrderItem` has no discount field.
- **Order state is not asked for** — it stays derived, per step 6 above. Invoice
  references ride on the lines for verification only.
- **All example values are invented.**

🔴 **Nothing can be loaded yet**: inserting an order today pushes it to Mexal
from any org and creates tickets from its lines —
[OI-267](OI-267%20Loading%20historical%20orders%20would%20push%20them%20to%20Mexal%20and%20generate%20tickets.md).

## 🟢 2026-10-20 — the spec was sent, on the day promised

**The field specification was delivered to the client at 16:28:41Z**, closing the
first of this row's four steps four days late against the original 16 October
undertaking and **on time** against the 20 October re-promise Elena Spini made in
writing on 19/10.

- **By mail**, into the calendar thread for Wednesday's meeting (Gmail
  `1a15817bd8832c8e`), to Elena Spini, cc `amministrazione@pienissimo.com` and
  `fabrizio.p@pienissimo.com`: _"Ciao Fabrizio, Allego qui il file exel con i
  campi che ci servono per la migrazione del ordine e le righe d'ordine."_
- **The attachment is `Tracciato migrazione ordini Mexal - Salesforce.xlsx`**,
  164.6 KB, also posted to Elena Spini in Slack at 18:06:33 CEST (file
  `F0CAJ40LM99`) when he could not find the thread: _"pardon riesci per cortesia
  ad indicarmi il thread per mandare l exel con i campi"_ … _"oppure manda te
  direttamente"_. He then found it himself — 18:32:51 _"ho fatto sulla mail della
  call"_ — and she acknowledged at 18:33:04: _"visto perfetto thanks 😉"_.
- 🟢 **Elena Spini chased it at 09:16:24 CEST** — _"reminder Excel ordini per
  Fabrizio Pienissimo"_ — and it went out the same day.
- 🟢 **A separate field list exists in Drive**: `Order/OrderItem Salesforce
  Fields` (`1XCD2STp3HW3ryn8k4m9VH72QlPFtFDlQl5Xhb9HpbBg`), created by Anita Aga
  at 08:00:40Z and shared with Aurel Mrruku at 08:49:52Z — **16 Order columns and
  14 OrderItem columns, headers only, no data.** ⚠ Two artefacts now describe the
  same mapping; **the workbook sent to the client is the authority**, and the
  Drive sheet is the morning's draft.
- ⚠ **The Drive sheet's OrderItem columns include `ListPrice`, `UnitPrice` and
  `TotalPrice`** — which is the three-price shape
  [OI-207](OI-207%20The%20quote%20and%20order%20layouts%20omit%20the%20commercial%20fields%20the%20client%20requires.md)
  has been asking for on the quote side — and `Stato_Scadenza__c` plus
  `Mexal_Payment_Status__c`, the two fields the derived-state plan writes through.

## 🔴 What the delivery does not change

- 🔴 **Nothing can still be loaded.** [OI-267](OI-267%20Loading%20historical%20orders%20would%20push%20them%20to%20Mexal%20and%20generate%20tickets.md)
  is unchanged and gating: an inserted order is queued to Mexal from any org and
  its lines generate tickets.
- 🔴 **[OI-212](OI-212%20A%20Ri.Ba.%20rate%20reads%20as%20paid%20before%20its%20due%20date.md)
  is unchanged a tenth night.** `MexalScadenzarioSearchService.cls` was last
  touched by `f292b72` on 08/10 and is in none of the 20/10 commits. **The
  rehearsal is tomorrow.**
- 🔑 **And the client has now put the derived-state plan in writing**, in
  [their 20/10 mail](OI-268%20The%20client%20proposed%20a%20go-live%20calendar%20of%2016%20November.md)
  §7: _"Lo storico ORDINI viene caricato tramite il tracciato concordato con
  Aurel. Poi in base al numero ordine saranno aggiornati anche i dati di
  Fatturazione e Scadenzario."_ **So both parties are now committed on the record
  to deriving scadenzario data through a predicate the records say is wrong.**
- 🟡 **The open opportunities and quotes move by hand**, same section: _"Le
  opportunità aperte e i preventivi in corso li trasferiremo manualmente:
  concordiamo insieme le date precise, perché nel frattempo la fatturazione
  continua."_ ⚠ A `Opportunità_Zoho_CRM_` spreadsheet appeared in Drive the same
  morning (created by Anita Aga 08:17:19Z, ~4.4 MB, Drive
  `15EItrzNDIyCj7-ivmiif2-S7IxvKJJFrtidPau16tMg`). **Recorded as existing and not
  opened** — it is a Zoho export and will contain real customer records.
- ⚠ **The real load date is no longer 2 November.** It is pinned to go-live day,
  and the client has proposed **16 November** with migration across 13–15
  November — which ROMI has internally refused
  ([OI-268](OI-268%20The%20client%20proposed%20a%20go-live%20calendar%20of%2016%20November.md)).
  **The migration date is therefore unagreed again.**
- ⚠ **Tomorrow's meeting is wider than this row.** Elena Spini, 17:01 CEST:
  _"domani 10-11 ci vuole parlare del tema migrazione e ci vuole parlare di
  diversi open point che ha e problemi."_


## 2026-10-21 — the field spec was worked through line by line, and the client started filling it

🟢 **Two client sessions totalling 4h43 turned the workbook into an agreed
spec.** [The morning rehearsal](../meetings/2026-10-21%20Check%20Dati%20Migrazione%20e%20OP.md)
established the plan and surfaced the blockers;
[the afternoon design session](../meetings/2026-10-21%20Tema%20Migrazione.md) cut
the columns down field by field with the workbook open on screen.

### The agreed order key

`sigla` + `serie` + `numero documento` + **`data ordine`**, the date in Mexal's
compact eight-digit form. The fourth element is new and necessary —
[OI-275](OI-275%20The%20Mexal%20order%20key%20is%20not%20unique%20without%20the%20order%20date.md).
Confirmed against the Mexal API mid-call by Mirko Merendi at Kreosoft. The
customer code is **not** part of the key.

### Order header

**Dropped:** `codice cliente` (already on the order), `codice destinazione`,
`tipo ordine`, `totale imponibile` (recomputed from the lines).
**Kept:** `codice agente` — _"mi serve per forza"_ — the four payment codes
Salesforce already knows, and the cancellation flag carrying `N`
(_"La stessa N vuol dire non annullato"_); cancelled orders are excluded,
_"A cosa ti servono gli ordini annullati?"_

### Order lines

**Dropped:** `tipo riga`, `descrizione articolo`, `unità di misura`, `prezzo di
listino` (read from the product), `totale riga`, `codice IVA`.
**Kept:** `codice articolo` — the whole product link runs through it — the Mexal
line id, and the line **due date**, from which Aurel Mrruku generates the
tranches.
🔑 **Net price only, no list price and no discount.** _"se tu mi passi il prezzo
net[t]o … verrà calcolato lo sconto in modo automatico. Passami sul prezzo netto,
siamo a posto."_
🔑 **The payment status need not be supplied at all**: _"non mi deve manche
passare lo stato, perché lo stato io ce l'ho nello scadenziario e lo prenderai in
automatico."_

### How the import will run

1. Editions and product mappings created **first**, including the dummy ones —
   [OI-276](OI-276%20Dummy%20import%20editions%20are%20needed%20to%20load%20historical%20orders.md).
2. Orders inserted in bulk with **automatic Mexal transmission blocked** — the
   bypass [OI-267](OI-267%20Loading%20historical%20orders%20would%20push%20them%20to%20Mexal%20and%20generate%20tickets.md)
   was waiting for — and the Mexal key stored for later invoice matching.
3. Edizione binding reversed onto the **invoice date** for the import only:
   _"anziché data ordine considera data fattura."_
4. Tranches generated from the line due dates; Assets generated per line.
5. Performance Plus contract automation bypassed —
   [OI-280](OI-280%20Performance%20Plus%20contract%20generation%20must%20be%20bypassed%20for%20migrated%20orders.md).
6. A full scadenzario run from the start of 2025, not the usual rolling window,
   to settle invoices and collections. **Estimated 3–4 hours.**
7. Tickets against the dummy editions mass-deleted.

🟢 **Everything comes in as a standard order**, bundles included — _"I bundle
saranno standard"_ — losing the type distinction on history by explicit client
acceptance.

### Volumes, read off the client's warehouse live

| Period | Article lines |
| ------ | ------------- |
| From 1 Jan 2024 | ~30,000 |
| After 2024 | ~9,000 |
| **2024 alone** | **~21,000**, reducible to _"una quindicina di migliaia"_ once the software-platform lines are stripped |

🟡 **How far back is still open.** Fabrizio Paganelli moved from 2025 to
considering 2024 during the call, for a three-year commercial history —
_"sarebbe anche corretto che loro vedano 24 25 26 … almeno hanno gli ultimi 3
anni di vendita"_ — caveated by 2024 data quality: _"nel 24 avevamo un sacco di
porcheria, avevamo la vendita dei prodotti della software."_ He will decide after
inspecting it. Aurel Mrruku's answer was to send everything: _"passaci tutto."_

🟢 **The client has started.** Mail at **17:01:16Z**, subject _Importazione dati
Storici_, to Aurel Mrruku and Elena Spini: _"io ho fatto una prima bozza. Avete
15-30 minuti domani? Avrei piacere di capire se siamo sulla strada giusta."_
⚠ **No attachment on that mail** and ⚠ **nobody has answered it** as of this
sweep. A 22/10 slot is requested and unconfirmed.

### 🔑 A premise that was wrong

Aurel Mrruku had been working on the belief that Mexal discards the order once
it is invoiced — _"Mirko da quello che m'ha detto che quando viene creata una
fattura quell'ordine non esiste più"_ — and Fabrizio Paganelli disproved it on
screen from the Zoho Analytics warehouse, where each invoice line carries
`sigla ordine`, `serie ordine`, `numero ordine`, `data ordine` and the shared
customer code. **The whole key design depends on this correction.**

### Timing

Aurel Mrruku: _"spero che due tre massimo 4 giorni riesco a fare tutta sta cosa
in ambiente di UAT"_ — so UAT only, and the production run is separate. Against
a first import on ~9 November that leaves roughly two weeks, with
[OI-274](OI-274%20The%20historical%20ticket%20balance%20has%20no%20migration%20path.md)
unbuilt inside it.
