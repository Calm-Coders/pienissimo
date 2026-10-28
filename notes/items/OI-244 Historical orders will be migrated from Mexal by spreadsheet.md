---
id: OI-244
type: open-item
status: open
owner: Aurel Mrruku
with: Fabrizio Paganelli
org: both
raised: 2026-10-15
updated: 2026-10-28
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

| Period          | Article lines                                                                                          |
| --------------- | ------------------------------------------------------------------------------------------------------ |
| From 1 Jan 2024 | ~30,000                                                                                                |
| After 2024      | ~9,000                                                                                                 |
| **2024 alone**  | **~21,000**, reducible to _"una quindicina di migliaia"_ once the software-platform lines are stripped |

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

## 🟢 2026-10-22 — the client walked his populated file, and the exclusion rules were agreed

**The draft promised on 21/10 was reviewed line by line in a 40-minute call**
([Check Excel Migrazione](../meetings/2026-10-22%20Check%20Excel%20Migrazione.md),
15:00 CEST). This is the first time the migration has moved from design to data.
Everything below is the client proposing and Aurel Mrruku accepting.

### 🟢 The scope question this row has carried since 15/10 is answered

**The extract starts 1 January 2024.** Fabrizio Paganelli: _"ho fatto una prova
dal primo di gennaio del 2024"_ — so three commercial years, with 2024 included
despite its data quality. The volumes he read off are consistent with 21/10:
**~30,000 order lines from 2024, ~9,000 from 2025**, less ~1,000 `SW` lines.

### The agreed rules

| Rule                                                         | Why                                                                                                                                                                                              |
| ------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| **Rows with empty order key fields are excluded**            | They are invoices issued with no order; their key is empty and collides across customers. See [OI-275](OI-275%20The%20Mexal%20order%20key%20is%20not%20unique%20without%20the%20order%20date.md) |
| **All invoices and scadenzario entries import anyway**       | _"io le fatture li prenderò a prescindere … solo che quelle fatture non sono collegate ai ordini"_                                                                                               |
| **Tranche date = invoice date**                              | Confirmed as coherent; different line dates create different tranches                                                                                                                            |
| **Payment condition forced to `12`** (bonifico data fattura) | Aurel Mrruku: _"Non ci dà problemi, basta che ci sia un valore"_                                                                                                                                 |
| **Missing agent code → existing code `610`**                 | Never invent one: _"non inventi codici agenti nuovi perché poi mi causa problemi a trovare l'utente che è un agente"_. `610` is the generic secretariat agent                                    |
| **Credit notes excluded**, kept in a separate Excel          | Deferred with the credit-note feature itself to Fase 2/3 — _"li importiamo quando implementiamo note di credito"_                                                                                |
| **~1,000 `SW` platform-sale lines deleted**                  | Mostly 2024; accepted on the condition nothing references a missing code                                                                                                                         |
| **Orders are loaded before lines**                           | _"mi deve passare prima l'ordine, poi il riferimento"_                                                                                                                                           |

🟡 **Open orders are a much smaller problem than assumed.** Orders entered and
not yet invoiced today number **five** — he then counted seven on screen, and
the transcript does not reconcile the two. He expects more at the real
migration.

### ⚠ What the rules cost, and nobody priced

- 🔴 **Credit notes leave the migration entirely.** 2024 has _"parecchie"_ of
  them by his own account, against Elena Spini's recollection that they were few
  per year. **The migrated history will overstate net sales for 2024 by the
  value of every credit note**, and no source says whether anyone reading the
  history will know that.
- ⚠ **Payment condition `12` on every historical row** is a fabricated value by
  agreement. It is harmless only for as long as nothing reports on it.
- ⚠ **Agent `610` on every row that lacked one** attributes those sales to the
  secretariat. Commission reporting over history will reflect that.
- 🔴 **The exclusion filter is the only thing keeping the import key unique**,
  and it lives in the client's spreadsheet, not in the system — see OI-275.

### 🔴 Still unbuilt, still running through OI-212

The call restated the collection chain end to end, with Fabrizio Paganelli
working it out aloud and agreeing it:

> _"tu leggi prima lo scadenziario, vedi quali sono le fatture che sono state
> pagate o no e … nelle fatture recuperi il numero dell'ordine e quindi aggiorni
> se è pagato o no"_

🔴 **That is the chain
[OI-212](OI-212%20A%20Ri.Ba.%20rate%20reads%20as%20paid%20before%20its%20due%20date.md)
records as wrong, unchanged a twelfth night**, and it is now how ~30,000
historical lines will acquire their collection state.

### Next steps as recorded

1. **[Fabrizio Paganelli]** send the finished list to Aurel Mrruku — _"appena
   finisci mandami l'el[enco]"_. ⚠ No date.
2. **[Both]** activate all products before the load — see
   [OI-276](OI-276%20Dummy%20import%20editions%20are%20needed%20to%20load%20historical%20orders.md).
3. **[Fabrizio Paganelli]** settle the price/discount mapping with Kreosoft —
   now [OI-284](OI-284%20The%20listino%20sconto%20and%20netto%20mapping%20for%20Mexal%20orders%20is%20undefined.md),
   with a call requested for 26 October.

## 2026-10-23 - the data arrived, and it is explicitly provisional

🟢🔑 **The spreadsheet this row has been about since 15 October exists and has
been delivered.** Fabrizio Paganelli, Gmail `1a168166785585be`,
**2026-10-23T09:27:39Z**, to Aurel Mrruku and Elena Spini:

> _"vi inoltro i dati per fare i test di importazione ordini._
>
> _Come abbiamo detto si tratta di dati provvisori in quanto poi l'importazione
> dovremo ripeterla quando passeremo in produzione_
>
> _Vi chiedo se mi potere chiamare, perché dovrei configurare i prodotti e le
> edizioni"_

|                   |                                                                                                                                                         |
| ----------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Attachment**    | `Import Ordini (versione del 23.10.26).xlsx`, **1,103,461 bytes**                                                                                       |
| **Also in Drive** | `1ls-nh7tz5SzW6ALhBW0lWlOn15kfEKMo`, owner `a.mrruku@romicompany.com`, created and modified 2026-10-23T09:27:39Z — the same file, saved out of the mail |
| **Status**        | 🟢 Elena Spini 13:09:30Z: _"ok analizzeremo il file e torneremo da te"_                                                                                 |

⚠ **Not opened by this sweep.** It is the live historical order and invoice
extract — real customers, real amounts, article codes. Recorded by filename,
size, ids and timestamps only, per the standing constraint. 🔑 **So nothing in
this record states whether the eight exclusion rules agreed on 22/10 were
actually applied to it**, including the one the key's uniqueness now depends on
([OI-275](OI-275%20The%20Mexal%20order%20key%20is%20not%20unique%20without%20the%20order%20date.md)).
**A human has to check that.**

🔑 **"dati provvisori … l'importazione dovremo ripeterla quando passeremo in
produzione"** is the client confirming the two-phase import in their own
writing. It matches the agreed calendar: this file is the 9 November rehearsal,
and the real one is due **13 November at 09:00**
([OI-268](OI-268%20The%20client%20proposed%20a%20go-live%20calendar%20of%2016%20November.md)).

### 🟢 The edizione mapping is unblocked and has a sequence

Elena Spini, 13:09:30Z: _"Ti confermo che puoi procedere con la configurazione
di edizione e mappatura-edizione."_ 🟢 **So the precondition
[OI-276](OI-276%20Dummy%20import%20editions%20are%20needed%20to%20load%20historical%20orders.md)
records — all products active before the mapping — is satisfied**, confirmed
again at 13:15:52Z: _"I prodotti sono già tutti attivi in ambiente di UAT,
quindi puoi procedere."_

🔴 **But that was not the client's blocker**, and four mails in forty minutes
failed to establish what was. Fabrizio Paganelli, 13:21:14Z:

> _"Non mi sono spiegato. Per i prodotti che sono già attivi su Salesforce devo
> modificare alcuni attributi (categoria, natura, ecc), altrimenti non posso
> fare la mappatura. Questo lavoro lo faccio su Mexal e poi, in notte, viene
> aggiornato Salesforce?"_

Resolved in [the 16:00 call](../meetings/2026-10-23%20Import%20Ordini%20Migrazione.md).
The agreed handoff chain — **Fabrizio Paganelli extracts and edits the Mexal
registry (expects to finish Monday) → Mirko Merendi mass-updates Mexal →
Fabrizio Paganelli mails Aurel Mrruku → Aurel Mrruku re-imports into
Salesforce** — and only then can the edizione mapping be built on correct
`categoria statistica` values.

### 🔴 The chain has a single point of failure, and it is a mail

🔑 **The product synchronisation flows are switched off in UAT.** Aurel Mrruku:
_"li ho disabilit[ati] ci sto lavorando per quello."_ The client's written
assumption was the opposite — _"poi, in notte, viene aggiornato Salesforce?"_ —
and **the answer is no.**

🔴 **So step 4 of the chain, a mail from the client, is the only thing that
tells Salesforce the ERP has changed.** If it is missed or delayed, the edizione
mapping is built against stale categories and
[OI-276](OI-276%20Dummy%20import%20editions%20are%20needed%20to%20load%20historical%20orders.md)'s
single point of failure — _"se non trovi l'edizione esplode e devo rifare da
capo"_ — fires on the real import. ⚠ **Nobody said when the flows go back on.**

⚠ **The window is tight**: the registry edit lands Monday 26 October at the
earliest, Kreosoft's mass update after that, and the first import is ~9
November.

## 2026-10-28 - the 23/10 file was checked, and it can be loaded into UAT once the bypasses exist

Checked by Claude Code at Aurel Mrruku's request, against the file and against
**Pienissimo UAT** (read-only; nothing loaded). Aggregates only; no customer,
article or amount values are recorded.

🟢 **The order key is clean.** 7,721 orders, all `OC`, series 1 (7,685), 2 (33,
all 2023) and 3 (3). No empty key part, no invalid date, **no duplicate**
`sigla+serie+numero+data`, no triple repeating across dates. The 22/10 exclusion
rules were applied: no cancelled orders, no `SW` lines, payment code `12`
everywhere. 17,300 lines, every line has its order and every order has lines.
None of the keys already exists on a UAT order (35 keyed orders there).

🟢 **The UAT registry covers it almost entirely.** All 397 article codes match
exactly one active product with a standard price book entry; none is a bundle
with components, so no double ticket generation. 2,845 of 2,917 customer codes
exist on an Account.

🔴 / ⚠ **What has to be decided or built first:**

| #   | Finding                                                                                                                                      | Effect                                                                                                                                                                              |
| --- | -------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| 1   | `AUTOMATIC_MEXAL_CREATION_ENABLED` is still `true` and nothing reads `Origine__c = Mexal`                                                    | Inserting today queues every order to Mexal. [OI-267](OI-267%20Loading%20historical%20orders%20would%20push%20them%20to%20Mexal%20and%20generate%20tickets.md) bypass still unbuilt |
| 2   | Ticket edizione is chosen from `Order.EffectiveDate`; the agreed reversal to the invoice date is not built, and dummy editions are undecided | [OI-276](OI-276%20Dummy%20import%20editions%20are%20needed%20to%20load%20historical%20orders.md); assets also call `EventInvitationService`                                         |
| 3   | ~~72 customer codes (140 orders, 112 of them 2026) have no Account in UAT~~                                                                  | 🟢 Resolved the same day, see below                                                                                                                                                 |
| 4   | `CODICE_AGENTE` is one generic code on every order, and `OrderTriggerHandler.beforeInsert` overwrites the agent from the Account anyway      | History gets each customer's current agent, not the historical one                                                                                                                  |
| 5   | 10,485 lines (61%) have net amount 0; 1,855 orders are entirely zero                                                                         | 🟢 Aurel Mrruku, 28/10: they are **omaggi and will be loaded**                                                                                                                      |
| 6   | Net amount behaves as a **line total** (qty 2 ≈ 2× qty 1 on 12 of 24 comparable articles)                                                    | 🟢 Aurel Mrruku, 28/10: confirmed line total; `UnitPrice` = amount / quantity. All 6,815 non-zero lines divide exactly to two decimals, so no rounding difference                   |
| 7   | 6 duplicate Mexal line ids within one order (1 identical row, 5 different articles)                                                          | Ambiguous invoice-line matching on `Mexal_Line_Number__c`                                                                                                                           |
| 8   | 1,351 lines carry a tranche date before the order date (mostly within 30 days); 447 orders are dated before 2024                             | Plausible, to confirm with the client                                                                                                                                               |

🟢 **Tranches**: 7,683 orders have one tranche date, 37 have two, one has four.
Per Aurel Mrruku: one `Tranche__c` per order and date, holding that date's lines.
`PerformancePlusContractService.createForOrders` runs only from
`QuoteTriggerHandler`, so a direct order insert does not generate Performance
Plus contracts ([OI-280](OI-280%20Performance%20Plus%20contract%20generation%20must%20be%20bypassed%20for%20migrated%20orders.md)).

### 🟢 2026-10-28 - UAT customers re-pulled from Mexal; every order customer now exists

At Aurel Mrruku's request, Claude Code read the whole Mexal customer registry
(read-only search, `MexalSearchCalloutService.sendReadOnly`, no log rows) from
UAT in nine code ranges and wrote it into **Pienissimo UAT** by anonymous Apex,
after a full dry run with rollback. Window 11:38-11:39Z.

|                      |                                                                                                                                                                                                                                                                          |
| -------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| Mexal customers read | 8,726 (UAT had 8,146 coded Accounts)                                                                                                                                                                                                                                     |
| **Inserted**         | **129** Accounts with a Partita IVA, `Azienda`, owner `Amministratore Pienissimo`, agent user from `cod_agente` (`610.00019` → the user already used for 1,810 Accounts; 13 with no matching user → Segreteria `610.00001`) - **all 72 order-file customers among them** |
| **Updated**          | 6,530 existing Accounts, only Mexal-mastered fields that differ, never blanking a value: mostly `Phone`/`Fax` that were empty in UAT; also ~40 names, ~90 SDI codes, ~80 billing streets                                                                                 |
| Skipped              | 453 Mexal customers without Partita IVA (the `Azienda` validation rule requires it; same outcome as the 24/09 import); 54 multi-address emails not written; 1 code duplicated in UAT left alone                                                                          |
| Failed               | 2 updates: one email Salesforce rejects, one Account whose agent user fails the lookup filter                                                                                                                                                                            |
| Mexal side           | 🟢 `AccountTriggerHandler.setBypassMexalCustomerUpdate(true)` around every update; no `MexalCustomerUpdateQueueable` job and **no integration log after 11:00Z**                                                                                                         |

16 of the inserts matched the standard Account duplicate rule (fuzzy name or
address) and were saved with `AllowSave`, because the Mexal code is the
customer's identity. ⚠ Agent codes on existing Accounts were **not** touched:
Mexal's `cod_agente` is blank or different on most of them, and the 24/09
import took the agent from the Zoho-side file.

🟢 **Re-check of the order file**: 2,917 of 2,917 customers present, 0 orders
blocked by a missing Account. Two order customers have no agent code on the
Account, so `OrderTriggerHandler.beforeInsert` will leave those orders' agent
empty.

### 🔴 2026-10-28 - edizione check by order date: one order in four would fail

Aurel Mrruku's rule: **the edizione is chosen by `DATA_DOC`**, the Mexal order
date. That is what the code already does - `OrderTriggerHandler.assignCampaigns`
matches `Order.EffectiveDate` against an active `Mappatura_Edizione__c`
(`Data_Inizio__c` ≤ date ≤ `Data_Fine__c`) for every line whose product has
`Genera_Biglietto__c` - so it needs `EffectiveDate = DATA_DOC` and no code
change. ⚠ This replaces the invoice-date reversal agreed on 21/10.

Checked against the 604 active UAT mappings (read-only). 53 ticket products
appear in the file, all with at least one mapping; no file article is a bundle
with components.

| Order year | Exactly one edizione | None      | More than one |
| ---------- | -------------------- | --------- | ------------- |
| 2022       | 0                    | 7         | 0             |
| 2023       | 0                    | 733       | 0             |
| 2024       | 4,711                | 549       | 0             |
| 2025       | 2,202                | 459       | 0             |
| 2026       | 1,464                | 597       | 532           |
| **Total**  | **8,377**            | **2,345** | **532**       |

🔴 **2,105 of 7,721 orders have at least one failing ticket line**, and the
trigger throws on the first one, so the insert of that line fails.

- **No edizione for the date**: nothing covers 2022-2023, and the Food
  Marketing Festival products are mapped only from 30/09/2026 (FMF 2027), so
  every earlier FMF sale has no edizione. Same pattern on the 2025 `CS0001xx`
  products.
- **Overlaps, all in 2026**: test editions (`Test Edizione Accademy 2026` over
  Academy/Mastery/Sold Out/Live, `test figlio rexhina` over Live 2026), Lab
  2026 over Intensive 2026/2027, and one product with Lab 2026 mapped twice.
- ⚠ 1,076 matching lines land on an edizione whose event date is in the
  future, which is the ticket-send condition [OI-276](OI-276%20Dummy%20import%20editions%20are%20needed%20to%20load%20historical%20orders.md)
  warns about.

### 🟡 2026-10-28 - edizione re-check after the cleanup: overlaps gone, FMF and pre-2024 still uncovered

The first check above read the mappings with `sf data query --all-rows`, which
**includes deleted records**: 281 of its 604 mappings had already been deleted
(280 on 27/10, 1 on 13/10). The 532 overlaps came from those deleted rows. The
customer, product and existing-order-key checks used the same flag but those
objects have no deleted rows, so their results stand (re-run on live data:
2,917/2,917 customers, 397/397 articles, 0 key collisions).

Re-run against the **323 live mappings**, after Aurel Mrruku's edizione
cleanup in UAT:

| Order year | Exactly one edizione | None      | More than one |
| ---------- | -------------------- | --------- | ------------- |
| 2022       | 0                    | 7         | 0             |
| 2023       | 0                    | 733       | 0             |
| 2024       | 4,711                | 549       | 0             |
| 2025       | 2,202                | 459       | 0             |
| 2026       | 1,996                | 597       | 0             |
| **Total**  | **8,909**            | **2,345** | **0**         |

**1,769 of 7,721 orders** still have at least one line with no edizione. The
causes are two, and both are mapping windows, not code:

- **Pre-2024 (740 lines, 419 orders)**: every `OLD` edizione starts on
  01/01/2024, and the earliest `DATA_DOC` is 01/12/2022.
- **Food Marketing Festival, 2024-2026 (1,605 lines)**: the nine FMF ticket
  products are mapped only to FMF 2027, from 30/09/2026. There is no FMF `OLD`
  edizione, so every earlier FMF sale has nowhere to land.
- ⚠ 1,448 matching lines land on an edizione whose event date is in the
  future (the 2027 editions, Live/Intensive/Lab 2026), the ticket-send case
  [OI-276](OI-276%20Dummy%20import%20editions%20are%20needed%20to%20load%20historical%20orders.md)
  warns about.

**Second re-check, same day**, after Aurel Mrruku added `Food Marketing
Festival OLD` (category E02, 01/01/2024-30/09/2026; FMF 2027 now starts
01/10/2026): 346 live mappings, 0 overlaps, **10,514 lines OK and 740 without
an edizione, all dated before 2024 (419 orders)**. 2024-2026 is fully covered.
What remains is moving the start of the seven `OLD` category mappings (E02-E07,
E09) from 01/01/2024 to 01/12/2022. 1,446 matching lines still land on a
future event.

🟢 **Closed the same day, on Aurel Mrruku's request**: in Pienissimo UAT,
`Da_Data_Competenza__c` of the seven `OLD` editions (Sold Out, Mastery,
Academy, ODB Live, Camerieri Venditori, Pienissimo Live, Food Marketing
Festival) was moved from 01/01/2024 to 01/12/2022, and their 132 mappings were
re-saved so the trigger copied the new start. This ran as one anonymous Apex
transaction with assertions and rollback; no integration log was written. Re-check: **11,254 of 11,254
ticket lines find exactly one edizione, 0 orders fail**. Still open: 1,446
lines land on a future event.

**Agents on Mexal-coded Accounts, same day (UAT write, on Aurel Mrruku's
request).** Every coded UAT Account already points to an existing agent user,
except 8. Five were moved to Segreteria (`610.00001`): four linked to a test
administrator and one linked to an agent user with no code. Three linked to a
real agent (`610.00017`) only lacked `Codice_Agente_Esterno__c`, which was
filled from that agent. The Mexal-update bypass was on, and there were no
callouts or queueables.

Not done, by choice: on the Mexal side, 5,177 customers carry an agent code
with no Salesforce user (`610.00006/08/11/13` and a few others, or blank), and
3,886 of them are assigned to a real agent in Salesforce. Those assignments
were left as they are.

### 🟢 2026-10-28 - full dry run of the UAT load: all 7,721 orders insert cleanly

Aurel Mrruku's decisions for the load: ticket lines **do** generate tickets, and
the duplicate `ID_RIGA_MEXAL` values are not a blocker. A re-check found 6
duplicates in 4 orders, so for those lines the invoice match falls back to
article and quantity.

The loader is anonymous Apex in UAT. It runs in chunks of at most 250 orders,
kept under the ~32k-character script limit, and each chunk is all-or-nothing.
It writes:

- **Orders**: `Status = Ordinato`, `Origine__c = Mexal`, `EffectiveDate` =
  `DATA_DOC` and the four key fields. Orders whose key already exists are
  skipped.
- **Tranches**: one `Tranche__c` per order and `DATA_TRANCHE`, numbered by
  date, with `Importo_Previsto__c` = the sum of its lines.
- **Lines**: `OrderItem` with `UnitPrice` = amount / quantity,
  `Mexal_Line_Number__c` = `ID_RIGA_MEXAL`, `Tranche__c` and `Data_Scadenza__c`.

The one Mexal code with two Accounts (`501.08293`) is resolved to the Account
whose P.IVA matches Mexal.

The dry run executed every chunk and then threw, so the whole transaction
rolled back, async jobs included. Nothing remained afterwards: 0 `Mexal`-origin
orders, 0 tranches, no integration log.

| Created                 | Count  |
| ----------------------- | ------ |
| Orders                  | 7,721  |
| Tranches                | 7,761  |
| Order lines             | 17,300 |
| Ticket assets           | 19,873 |
| Event invitations       | 9,715  |
| Orders queued for Mexal | **0**  |

Peak per chunk: CPU 2.5 s, 59 SOQL, 1,495 DML rows. Remaining caveats:

- The invitations are only created; sending is the Marketing Cloud Growth path,
  which is not active in UAT. In Prod, invitations on past events would be due
  at once.
- The existing UAT invoices will not relink by themselves (see
  [OI-267](OI-267%20Loading%20historical%20orders%20would%20push%20them%20to%20Mexal%20and%20generate%20tickets.md)).

### 🟢 2026-10-28 - loaded into UAT, and the invoices already there are linked

**The load ran** on Aurel Mrruku's go-ahead, between 15:05 and 15:11 UTC, in 53
chunks with no failures. The duplicate riga 5 of OC 1/50020 was dropped and
the most recent row kept. Result:

- **Orders**: 7,721, one per key, all with a blank Mexal status. Their
  `TotalAmount` matches the file's line sum to the cent.
- **Rest of the load**: 7,761 tranches, 17,299 lines, 19,871 tickets and 9,715
  invitations.

**Then the invoices already in UAT were linked**, from stored data only and with
no Mexal call. The rules are those of `MexalInvoiceLineImportBatch`: the order
by `Riferimento_Ordine_Mexal__c`, then the line by article and quantity, since
every origin is the invoice itself. Each line then takes its rate and the
payment state of that rate.

|                                            | Linked / total |
| ------------------------------------------ | -------------- |
| Invoices                                   | 445 / 548      |
| Invoice lines                              | 1,210 / 1,360  |
| Rates                                      | 489 / 593      |
| Order lines `Paid` / `Unpaid` / `Invoiced` | 837 / 301 / 72 |
| Orders now `Incassato` (tranches `Pagata`) | 319            |
| Tickets now `Disponibile`                  | 635            |

Unlinked, as expected: 48 lines reference 17 orders dated 12-26/10/2026, which
are not in the 23/10 file, and 12 are description rows. UAT holds only 548
invoices, so about 460 of the 7,721 orders have one. The rest stay `Ordinato`
until the invoice sync imports their invoices, and that sync is now blocked
(see [OI-267](OI-267%20Loading%20historical%20orders%20would%20push%20them%20to%20Mexal%20and%20generate%20tickets.md)).

### 🟢 2026-10-28 - invoices 2024-2026 pulled from Mexal: every loaded order links by itself

On Aurel Mrruku's request the Mexal calls were reopened, with the named
credential back to `Enabled`. The three nightly jobs are still off. The full
invoice history was then pulled into UAT.

🔑 **Finding: before this change the integration could never fetch a
prior-year invoice.** Mexal keeps warehouse documents, invoices included, in
one archive per accounting year, and `MexalSearchCalloutService` always sent
`Coordinate-Gestionale: Azienda=PIE Anno=<current year>`. The invoice search
returned 0 rows for 2024 and 2025, and 543 for January 2024 with `Anno=2024`.
The scadenzario is not split by year.

The fix is deployed to UAT, in the repository and **not committed**:

- `MexalSearchCalloutService.accountingYear`, an optional override of the
  year in the header;
- `MexalInvoiceLineImportBatch`, which asks for each invoice detail in the
  invoice's own year;
- `MexalInvoiceImportService.importByDocumentDate(from, to)`, a bounded window
  searched in the year of its start date.

**Run** (all reads from Mexal): headers and scadenzario in 149 weekly windows,
01/01/2024-29/10/2026, then the existing line batch over the 10,258 invoices
without lines (206/206 chunks, 0 errors).

|                                                               | Result                                                                |
| ------------------------------------------------------------- | --------------------------------------------------------------------- |
| Invoices imported                                             | 10,806 (2024: 6,161 · 2025: 2,292 · 2026: 2,353), all with an Account |
| Due dates                                                     | 15,492                                                                |
| Invoice lines                                                 | 32,294 (30,362 with an order reference)                               |
| **Loaded order lines linked to an invoice line**              | **17,299 / 17,299**                                                   |
| **Loaded orders with an invoice**                             | **7,721 / 7,721**                                                     |
| Invoices linked to an order                                   | 7,764 / 10,806                                                        |
| Order lines `Paid` / `Unpaid` / `Invoiced` (no matching rate) | 15,487 / 350 / 1,462                                                  |
| Orders `Incassato` / `Ordinato`                               | 6,407 / 1,314                                                         |
| Tickets `Disponibile` / `Ordinato`                            | 16,970 / 2,901                                                        |

The 3,042 invoices without an order split two ways:

- **1,618 carry no order reference.** They were issued without an order, so
  this is expected.
- 🔴 **1,424 reference an order the 23/10 file does not contain**: 1,363 from
  2024, 22 from 2025, 21 from 2026 and 16 from 2023. This fits the file being
  provisional: about 17,300 lines against the roughly 39,000 announced on
  22/10. Those orders are missing from the extract, which is for Fabrizio
  Paganelli to explain.

### 🟢 2026-10-28 - what was said to the client, and the three things the mail settles

The load above was reported to the client as it ran, in the **Import Ordini**
thread (Gmail `1a168166785585be`). Four facts in that correspondence are not
derivable from the org work:

🟢🔑 **The 2024 cut-off is on the invoice, not on the order.** Aurel Mrruku asked
why the file holds orders dated 2022 and 2023 (**12:00:30Z**, _"ci sono ordini
con DATA_DOC nel 2022 e 2023. Come mai? Mi aspettavo solo ordini dal 2024 in
poi"_). Fabrizio Paganelli, **12:13:25Z**:

> _"Per fare l'import dello storico sono partito **dalle fatture emesse a partire
> dal 01.01.2024**. Queste possono fare riferimento a ordini antecedenti il
> 01.01.2024 (questo il motivo per cui nella data ordine trovi anche gli anni
> 2022 e 2023)"_

🔑 **This corrects the scope rule as this record has carried it since 20/10** —
_"scoped to invoiced orders since 01/01/2023"_ and the 22/10 rules' order-date
framing. The extract is an **invoice**-driven set; order dates run back further
by construction, and the pre-2024 orders are not stragglers to be excluded.

🔴 **The `ID riga Mexal` column was challenged and the challenge was not
resolved in writing.** Aurel Mrruku, **11:52:31Z**: _"nel file Excel 'Import
Ordini' abbiamo riscontrato che il campo 'ID riga Mexal' non risulta valorizzato
correttamente … questo dato è fondamentale per poter procedere con
l'aggiornamento delle righe di fattura."_ Fabrizio Paganelli, **12:11:26Z**: _"In
che senso non è valorizzato correttamente? Non vedo righe nulle. Magari chiamami
nel pomeriggio."_ The call followed at 14:07 CET
([Import Ordini](../meetings/2026-10-28%20Import%20Ordini.md)) and ⚠ **its
transcript is unusable**, so what was agreed about the column is not in the
record. The load ran to completion afterwards.

🟢🔑 **The missing-agent default is resolved, and it is `610.00001`.** Aurel
Mrruku sent the live distribution (**11:46:54Z**, 16 codes of the form
`610.000NN` with their customer counts); Fabrizio Paganelli answered at
**12:06:40Z**:

> _"i codici agenti che trovi negli ordini ma che non sono presenti nella lista
> degli agenti che ti ho passato ieri, **li puoi forzare tutti su 610.00001**. Me
> lo segno così quanto ti invierò **i movimenti definitivi da portare in
> produzione** farò già questa trasformazione."_

So the 22/10 rule recorded as _"missing agent → existing code 610"_ now has its
full value, and 🔑 **the client has undertaken to apply the transformation in the
production file himself** — which means the rule must *not* be applied twice.
See [OI-293](OI-293%20The%20agent%20registry%20for%20the%20production%20load%20may%20be%20incomplete.md).

⚠ **The integrations were blocked for the duration, and the client was told so.**
Aurel Mrruku, **11:27:59Z**: _"Per evitare la creazione duplicata di 7.721 ordini
su Mexal, è necessario **bloccare temporaneamente le integrazioni**."_ 🔑 **In
the repository the guard is not temporary**: `OrderMexalIntegrationService` gained
a permanent skip on `Origine__c == 'Mexal'` the same day, commented _"Orders
migrated from Mexal already exist there: sending them would duplicate them."_
Both can be true — a standing origin filter plus a session switch — but **only
the standing filter is in source**, and the Mexal order API was reported reopened
at **16:19:55Z** (_"Ho anche apperto le api verso mexal se vuooi proseguire con i
test"_). Account sending is a separate switch and is covered by
[OI-296](OI-296%20Account%20creation%20to%20Mexal%20failed%20in%20UAT%20and%20account%20send%20was%20switched%20off.md).

🟢 **The client acknowledged the result**: Fabrizio Paganelli, **16:21:38Z**,
_"Bene! Ottimo lavoro."_ ⚠ Sabatino Rinaldi and `amministrazione@` were cc'd from
15:32Z onward, so the load figures are now in front of the client's data owner.

⚠ **This was UAT.** Aurel Mrruku's own wording at 15:24:37Z — _"concludo tutto il
ciclo **in UAT**"_ — against his 11:27:59Z framing of the day as _"il deploy in
produzione e il caricamento degli ordini"_. 🔑 **The `Prod` and `UAT` git branches
have not moved since 26 October**, and the production target was restated the
same afternoon as **Friday** (Slack `C0C38JJ9D1T`, 15:24:14 CET: _"spero entro
venerdì finiamo tutto così hai la produzione up & running"_), where 27/10 had it
as _"entro domani sera"_. **The answer to "is the 28–29/10 import the migration
or a rehearsal" is: a rehearsal, in UAT.**
