---
id: MTG-2026-08-26-mexal
type: meeting
status: resolved
owner: Elena Spini
org: both
raised: 2026-08-26
updated: 2026-08-26
source: meetings/2026-08-26-review-temi-integrazione-mexal-transcript.it.md
---

# 2026-08-26 Review Temi Integrazione Mexal

**Client-facing session, 26 August 2026, 16:00 CEST, 1h25m.** Gemini notes,
full transcript and a recording all exist and were read — see
[the recap](../../meetings/results/2026-08-26-review-temi-integrazione-mexal.md).
**The first Mexal session since 14 July**, and the one
[OI-58](../items/OI-58%20Mexal%20integration%20mechanics.md) had been waiting for.

**Present:** Elena Spini (left at ~01:02), Aurel Mrruku, Andrea Di Cicco (ROMI);
Fabrizio Paganelli, Elisa Migliano (`amministrazione@`) (Pienissimo).
Sabatino Rinaldi was invited and **did not speak** — treat him as absent.

⚠ Speaker labels in this transcript are unusually clean; attribution below is
taken from the transcript, not from the Gemini summary, which is accurate here
but thinner.

## 🔴 The decision that changes the design: the edition comes from a date table

The mechanism that assigns an order line to an **event edition (Campagna
Figlio)** was settled, and it is **not** the one the record carried.

**A manually maintained table in Salesforce**, one row per
`article code × date-from × date-to`, mapping to an **edizione**. At order time
each **order line** is matched on the **order date** against the range for its
article code, and takes the edition from the matching row.

Fabrizio Paganelli, working it through with Aurel Mrruku on Andrea Di Cicco's
shared Excel:

> _"Noi dovremmo avere una tabella, ok? dove diciamo bene per tutti gli ordini
> che vanno dal primo di ottobre 25 al 30 settembre 26, dove dentro c'è il codice
> articolo CS00158 che è il Food Marketing Festival, se l'ordine cade in questo
> range di date devi assegnare quel biglietto all'edizione Food Marketing
> Festival 27."_

Three properties matter and none of them were obvious beforehand:

1. **It resolves at order-line level, not order level.** Elena Spini asked
   directly — _"a livello di riga, quindi non di ordine"_ — Fabrizio Paganelli:
   _"a livello di riga ordine."_ One order can therefore split across editions,
   because each article carries its own range.
2. **The ranges are arbitrary and hand-configured.** Aurel Mrruku established it
   explicitly: _"non vuol dire che EPTeam 2026 abbia le date del 2026. Tu puoi
   mettere data a piacere e quando viene staccato l'ordine va a controllare le
   date."_ Fabrizio Paganelli: _"Esattamente. Noi dobbiamo essere svizzeri nella
   gestione di questa tabella."_
3. **The order date governs, not the tranche date.** Aurel Mrruku probed whether
   tranches carry their own date; Fabrizio Paganelli: _"è la data dell'ordine,
   perché io le tranche ci servono a noi solo per definire i pagamenti."_

🔴 **This kills the "one active child campaign" rule.** Elena Spini said so in
the session: _"In effetti quello che avevamo pensato Aurel, cioè non può
esistere perché… se prendi il bundle, cioè come fai?"_ — a bundle containing two
events cannot resolve to a single active edition. Aurel Mrruku accepted the
replacement: _"non mettono il flag campagna attiva… mettono solo le date, faccio
io il check nel momento in cui si genera l'ordine a quale campagna figlia si deve
collegare."_

Recorded as [OI-96](../items/OI-96%20Edition%20mapping%20table%20on%20Salesforce.md);
[the campaign parent and child model](../objects/The%20campaign%20parent%20and%20child%20model.md)
is updated accordingly.

⚠ **It is agreed in principle and explicitly not finished.** Aurel Mrruku asked
for a dedicated hour with concrete worked examples before it is built —
_"forse ci meglio se ci prendiamo un'ora e facciamo proprio degli esempi
concreti"_ — and the Gemini decisions list files the order-line-to-campaign
mapping under **"Da approfondire"**, the only item there.

## Column G — the event date is a separate column

Aurel Mrruku asked for a **second date** on the same table, distinct from the
order-date range. Fabrizio Paganelli agreed and named the position:
_"tipo qui nella colonna G si può inserire data dell'evento"_, filled in by hand
(_"il full marketing dal 27 ci sarà il 30 di settembre, lì gli mettiamo 30
settembre"_).

Elena Spini's reason for wanting it: it is what drives the **post-event no-show
deactivation** — three days after the campaign ends, un-consumed tickets go to
not-consumed. The order-date range cannot serve that purpose because it is
deliberately unrelated to when the event happens.

## The three Mexal classification fields, tested live on the wire

Fabrizio Paganelli opened with a hard constraint: **the Mexal article registry
has at most three fields available to classify a product**, and none of them is
currently in use — _"questi campi ad oggi non sono per niente gestiti… siamo
liberissimi di fare come è più comodo per noi."_ Each was tested during the call,
Fabrizio Paganelli editing in Mexal while Andrea Di Cicco watched the API
response change.

| Mexal field                             | API name                             | Assigned to                       | Verified                                                                      |
| --------------------------------------- | ------------------------------------ | --------------------------------- | ----------------------------------------------------------------------------- |
| **natura**                              | `COD_Natura`                         | **genera biglietto sì/no**        | ✅ value created on article `CS_00154` (Happy Team), seen over the API         |
| **categoria statistica**                | `Sigla cat sta` + `Numero cat sta`   | **the event** (Campagna Padre)    | ✅ `C01` set, then changed to `P02`; both observed. **Splits into two fields** |
| **gruppo merceologico**                 | `GRP merch`                          | candidate for **tipo biglietto**  | ⚠ hierarchical in Mexal, but only the code came over the API, not the level   |
| **Gest. annullato** (technical, 4th)    | `Gest. annullato` — `n` = active, `S` = cancelled | **product disabled in Salesforce** | ✅ `CS58` cancelled and restored live                            |

`natura` is **not free text** — it resolves against a base table of managed
values in Mexal, so an operator cannot invent one. Fabrizio Paganelli:
_"non posso metterci dentro Pippo."_

**The value convention is not chosen.** Fabrizio Paganelli takes the whole scheme
to Pienissimo's direction on **Monday 31 August** and will send the revised
registry afterwards.

## Product disabling — agreed, with a known operational cost

The problem: ~**1000 legacy article codes**, and tutors picking obsolete ones.
The answer: Mexal's `annulla/ripristina` button sets `Gest. annullato`, the
integration maps it to an inactive flag on `Product2`, and the product stops
being selectable in Salesforce.

Tested during the call against a **real invoice** — Fabrizio Paganelli cancelled
`CS58` (Food Marketing Festival Gold) while an issued invoice for a customer
referenced it, reopened the invoice, and the line was still visible. Both test
articles were restored before the end of the session.

⚠ **Elisa Migliano raised the failure mode from live experience:** tutors have
made quotes while administration cancelled the code underneath them; the quote
then failed to pass to Mexal and was corrected by hand. Andrea Di Cicco confirmed
the Salesforce behaviour is the same — a disabled product **cannot be
re-selected by anyone, master and administration users included** — but an
existing order line can be edited to swap in the replacement code. Both
Fabrizio Paganelli and Elisa Migliano accepted that manual correction.

History stays reportable: _"tu puoi rivedere tutto lo storico… però non lo puoi
selezionare per la vendita."_

## A ticket-generating article and its bundle twin need two separate codes

Aurel Mrruku, unambiguously: _"se vuoi due prodotti… uno per generare il
biglietto e l'altro per non generare il biglietto, devi per forza avere due
prodotti, non lo puoi fare un unico prodotto."_ Fabrizio Paganelli accepted and
described the convention: _"se un codice articolo è visibile, se non è il bundle,
avrà il codice A. L'altro codice che è visibile a tutor avrà il codice B."_

He will **configure two test articles** carrying the new flags next week.

This reverses the reading in
[OI-48](../items/OI-48%20Bundle-only%20article%20codes.md) that the `Solo_Bundle__c`
flag makes twin codes unnecessary. The flag still exists; the client's model
needs both.

## Encoding two booleans in one field — proposed, then abandoned mid-discussion

Because Mexal's classifiers are exhausted, Aurel Mrruku proposed packing
`genera biglietto` and `visibile solo in bundle` into four `natura` values
(1 = ticket/no bundle, 2 = no/no, 3 = no/bundle, 4 = ticket + bundle), extending
to eight for three booleans. He then reconsidered aloud once ticket type turned
out to have three values — _"se sono tre meglio se lasciamo un campo a sé"_ — and
Andrea Di Cicco pushed back: _"secondo me poi diventa un po' complicato."_

**No conclusion was reached.** Fabrizio Paganelli closed it with _"facciamo una
prova"_ — he will mint new article codes against the rules as discussed and the
group will test. Do not treat the combination scheme as agreed.

## Ticket tiers reconfirmed verbally

Fabrizio Paganelli, from memory: _"c'è Executive… Gold e Diamond."_ That matches
[`Prodotti e Bundle.xlsx`](../The%20Prodotti%20e%20Bundle%20workbook.md) exactly
and closes the `Silver`/`Dinamond` question in
[OI-76](../items/OI-76%20Ticket%20type%20picklist%20on%20the%20product.md) — neither
value exists. Whether the tier is carried by `gruppo merceologico` or by a
Salesforce-only field remains open.

## The no-show goodwill ticket must be linked to the next child campaign

Fabrizio Paganelli described a real practice: a good customer who misses an event
is not burned, they are manually reassigned a complimentary ticket for the next
edition.

Aurel Mrruku added the requirement this creates: _"se si fa un cambiamento
manuale del biglietto, quindi dell'asset, noi l'asset lo dobbiamo collegare
anche alla campagna figlia, quindi anche all'evento successivo, altrimenti… il
reminder se non si presenta non scatta più."_ Elena Spini agreed —
_"altra casistica aggiunta"_ — immediately before leaving.

## Out of scope: one order spanning multiple editions of the same article

Andrea Di Cicco raised the limitation the date-range design imposes: a bundle
selling the **same** event across 2026, 2027 and 2028 in one order cannot be
resolved, because every line shares one order date. Fabrizio Paganelli closed it:
_"questa qui è una cosa che non facciamo. Non facciamo."_

⚠ Note the narrow reading. Different articles with different ranges **do** split
across editions in one order — that is the design. What is excluded is the same
article across several of its own editions.

## Invoicing stays in Mexal for roughly six months

Andrea Di Cicco had found the JSON to create an invoice and asked whether
Salesforce should drive it. Fabrizio Paganelli declined: _"per il momento
preferisco che venga pilotata solo da Mexal la fatturazione"_, revisiting
_"tra 6 mesi quando entreremo a regime"_. Andrea Di Cicco was relieved —
_"è abbastanza complesso"_.

## Customer registry — first successful live creation, and a new mandatory field

Andrea Di Cicco created a customer over the API on air: **`501.08721`, "Test
Roni"**, then order **`OC11` on serie 10**. Both landed and Fabrizio Paganelli
confirmed them on his screen. The order shows Mexal status `S` (sospeso), which
Fabrizio Paganelli explained is normal — it flips when the order is transformed
into an invoice.

Two things came out of the attempt:

- 🔴 **`tipo nazionalità` is mandatory and is `residenza fiscale` in the Mexal
  UI.** It must distinguish **Italia, San Marino, Città del Vaticano, Unione
  Europea, extra-Unione Europea**, because it drives the rules for transmitting
  invoices to the San Marino *ufficio tributario*. New requirement —
  [OI-97](../items/OI-97%20Fiscal%20residence%20on%20the%20customer%20registry.md).
- ⚠ **The Mexal API documentation is incomplete.** Andrea Di Cicco hit several
  mandatory fields not in it: _"tutti sti campi non c'erano sulla
  documentazione."_ `valuta` had to be guessed as `1`, and he still does not know
  whether `1` means euro.

## Answers to standing questions

- 🟢 **Listino 1 vs listino 2 — answered.** _"usiamo solo l'uno."_ Products carry
  two listini; only listino 1 is used. This had been deferred by Mirko Merendi to
  Fabrizio Paganelli and open since July —
  [OI-58](../items/OI-58%20Mexal%20integration%20mechanics.md).
- 🟢 **Mexal WEBAPI access demonstrably works.** Andrea Di Cicco queried, created
  a customer and created an order against production live in the session, and
  Aurel Mrruku followed along in the Postman collection. Whatever the record says
  about credentials being owed, the access is real.
- 🔴 **There is still no Mexal test environment.** _"purtroppo solamente in
  produzione posso fare i test."_ Serie 10 remains a test lane inside production
  data. Andrea Di Cicco will send the created customer IDs to Fabrizio Paganelli
  **and** to `amministrazione@` for checking, because Fabrizio Paganelli is out
  of office in the following days.

## 🔴 Not discussed: OI-92

[OI-92](../items/OI-92%20Mexal%20Scadenziario%20as%20the%20trigger%20to%20reverse%20an%20asset.md)
— whether an unpaid invoice in the Mexal *scadenziario* can drive an Asset back
to its previous state — was the question this meeting was expected to answer.
The record named this session as its forum, on both the 20 August decision and
the sticky note that raised it. **The word *scadenziario* is not spoken once in
the transcript.** It is still open and still needs a forum.

The **Mexal WEBAPI credentials** were likewise never mentioned.

## Fabrizio Paganelli intends to re-create the entire article registry

Opening statement of the meeting, and the largest thing in it by consequence:

> _"vorrei chiudere tutti i codici prodotto che abbiamo adesso e crearne di nuovi
> in base alle regole che ci siamo dati fino ad oggi… è probabile che ci sia
> l'intenzione di rivedere un attimo i listini, quindi cambiare i prezzi di
> listino."_

He takes it to direction on **Monday 31 August** and will pass ROMI the revised
registry. Tracked as
[OI-98](../items/OI-98%20The%20Mexal%20article%20registry%20is%20being%20re-created.md).

## The Slack aftermath, same evening

The ROMI group DM with Elena Spini, Aurel Mrruku and Andrea Di Cicco carries the
follow-through, and it is sharper than anything said on the call.

- **17:27** Andrea Di Cicco: _"Elena sarai contenta di sapere che dobbiamo fare
  un altro meeting con il buon Fabri."_ Elena Spini: _"mamma miaaaaa -.-"_
- **18:02** Andrea Di Cicco's verdict on the day:
  **_"le integrazioni per ordini e clienti funzionicchiano"_** — they sort of
  work.
- **18:15** _"dice settimana prossima perché questa in ferie"_ · _"deve rivedere
  anche per i codici dei prodotti e aveva conferma lunedì"_.
- 🔴 **18:16** the generalised version of the documentation problem:
  _"il fatto è che loro hanno dei valori che sono tipo per valuta: 1,2,3,4 — che
  lato nostro non sappiamo"_, and _"dobbiamo vedere che poi tutti i dati
  anagrafici arrivano per la fattura"_. **Mexal's coded-value dictionaries are
  unknown to ROMI as a class**, not just for `valuta`. He had already asked by
  email and is unanswered.
- **18:30** Elena Spini: _"rimetto un follow-up per settimana prossima… metterò
  la mattina."_

🟢 **The invitation followed ten minutes later.**
`[ROMI-PIENISSIMO] - Follow-up Anagrafica Articoli`, **Wednesday 2 September
10:00–11:30 CEST**, to Aurel Mrruku, `amministrazione@pienissimo.com`, Andrea Di
Cicco and Fabrizio Paganelli. ⚠ **Its title names the article registry, but the
thread that produced it is about both registries** — put the customer-registry
agenda in writing before it. See
[OI-99](../items/OI-99%20Customer%20registry%20deep%20mapping%20session.md).

## Actions from this session

| # | Action | Owner | When |
| - | ------ | ----- | ---- |
| 1 | Take the classification scheme to direction; revise and send the full article registry | Fabrizio Paganelli | Direction Monday 31 Aug; registry "next week" |
| 2 | Configure two test articles carrying the new flags (bundle visibility, ticket generation) | Fabrizio Paganelli | Next week |
| 3 | Map Mexal `Gest. annullato` to the inactive flag on Salesforce | Andrea Di Cicco | — |
| 4 | Hold a dedicated working session on order-line → campaign/edition mapping with concrete examples | the group | Not scheduled |
| 5 | Deep-map the customer registry — categoria provvigioni, condizioni documenti di magazzino, and Mexal's coded-value dictionaries | Fabrizio Paganelli, Andrea Di Cicco, Aurel Mrruku, Elisa Migliano | 🟢 **2 Sept 10:00–11:30**, booked the same evening — [OI-99](../items/OI-99%20Customer%20registry%20deep%20mapping%20session.md) |
| 6 | Send the created test customer IDs to Fabrizio Paganelli and `amministrazione@` for verification | Andrea Di Cicco | Immediately after the call |
