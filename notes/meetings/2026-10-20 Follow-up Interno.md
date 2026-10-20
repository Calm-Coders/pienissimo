---
id: meeting-2026-10-20-follow-up-interno
type: meeting
status: resolved
owner: Elena Spini
org: ROMI
raised: 2026-10-20
updated: 2026-10-20
source: meetings/2026-10-20-follow-up-interno-transcript.it.md
---

# 2026-10-20 Follow-up Interno

**ROMI-internal call, 17:01 CEST, 00:29:47, Aurel Mrruku and Elena Spini only.
No client present.** Called to work through
[the client's 16 November go-live proposal](../items/OI-268%20The%20client%20proposed%20a%20go-live%20calendar%20of%2016%20November.md)
point by point and to clear the defects from
[the 19/10 walkthrough](2026-10-19%20Test%20UAT%20Commerciali.md). It settled six
build items in half an hour and produced ROMI's unsent counter-position on the
date.

Full raw transcript preserved at
[meetings/2026-10-20-follow-up-interno-transcript.it.md](../../meetings/2026-10-20-follow-up-interno-transcript.it.md)
(27,767 bytes, read in one pass). Google Meet auto-transcript; it is not a
Gemini summary, so there is no action-item list to compare against.

## What was decided

| Item | Decision |
| ---- | -------- |
| [OI-207](../items/OI-207%20The%20quote%20and%20order%20layouts%20omit%20the%20commercial%20fields%20the%20client%20requires.md) — line discount on a standard quote | 🟢 **Build it the same way as bundle and Performance Plus.** Elena Spini: _"Prezzo unitario è praticamente il prezzo dello sconto come abbiamo fatto per la parte bundle e performance plus. Stessa logica."_ |
| [OI-263](../items/OI-263%20Salesforce%20system%20labels%20are%20still%20in%20English.md) — `Mark Current Stage` | 🟢 **Replace the standard label with a custom one reading `Cambia stato`**, on both the lead and the opportunity path. Aurel Mrruku: _"lo mettiamo custom, chi se ne frega, faccio io qualcosa … come lo facciamo in italiano? Cambia stato."_ |
| [OI-259](../items/OI-259%20A%20lost%20lead%20marked%20non%20interessato%20must%20carry%20a%20mandatory%20free%20text%20reason.md) — scope of the mandatory reason | 🟢 **Mandatory on four values, not one** — and 🔑 Aurel Mrruku classified it as a change request: _"digli che è una CR. Sì, sì, lo mettiamo, non è un problema … obbligatorio."_ ⚠ **Which four is not stated.** |
| [OI-266](../items/OI-266%20The%20quote%20product%20grid%20does%20not%20refresh%20after%20adding%20a%20line.md) — grid refresh | 🟢 Accepted and explained: the auto-refresh only ever existed on PDF generation — _"Refresh automatico l'avevo fatto solo sulla generazione del PDF"_ — so nothing regressed. Elena Spini conceded the expectation was hers: _"l'ho pensato io."_ 🟢 _"Sì che lo posso mettere."_ |
| [OI-250](../items/OI-250%20The%20reminder%20wait%20intervals%20must%20be%20configurable%20per%20edizione.md) — interval fields | 🔴 **11 became 15.** Aurel Mrruku: _"15 campi."_ Elena Spini: _"15 campi. Esatto."_ He builds them and takes them to production himself, with the permissions set by hand there and then overwritten. |
| [OI-242](../items/OI-242%20The%20community%20Rinuncia%20button%20must%20show%20the%20public%20refusal%20text.md) — Rinuncia | Client confirmation read out: _"Hanno confermato sto cavolo di bottone."_ |

## 🔴 ROMI's position on the date, which the client has not been told

Elena Spini read the proposal out and the two agreed a counter-position:

- **Release on 9 November, not 16.** Elena Spini: _"io gli vorrei dire di fare la
  settimana prima … che facciamo il 9 rilascio, il 16 se vogliono possono avere
  la produzione pronta, ma noi il rilascio lo facciamo prima."_
- **Because it has to be.** Aurel Mrruku: _"siamo costretti a farlo prima …
  perché si deve fare anche la migrazione dei dati"_, plus the manual steps —
  connected apps, the WooCommerce integration.
- 🟢 **The release itself is not the constraint.** _"il rilascio in produzione si
  può fare molto prima. Basta che loro ci diano la conferma che le cose stanno
  bene, io lo faccio anche domani."_
- 🔴 **No to the migration weekend**, on the advice of a ROMI colleague the
  transcript renders as **Giampaolo**: accept the postponement as the client's
  own request, refuse the weekend. _"ovviamente no al weekend."_
- 🔴 **And no to 16 November.** Elena Spini is unavailable 16–18 November —
  _"i 16 17 18 non ci sono"_ — because 17 November is her birthday.

⚠ She closed with _"Entro sera manderò una risposta a sta schifezza."_ **The
reply was not sent**; at 19:33 CEST she asked the internal group for feedback
first and said she wanted to answer _"asap domani mattina"_.

## 🔴 The new requirement neither of them could interpret

The client's §3 asks for communications differentiated by ticket type. It is
recorded as [OI-269](../items/OI-269%20Event%20communications%20must%20be%20differentiated%20by%20ticket%20type.md).
Aurel Mrruku located the gap precisely:

> _"il template dell'email deve essere diverso in base alla tipologia del
> biglietto, ma noi non ce l'abbiamo una tipologia del biglietto, in teoria
> dipende dal prodotto … quando generiamo l'asset dobbiamo tenere sull'asset
> anche la tipologia del biglietto **che nessuno l'ha detto** e lui deve
> filtrare."_

Elena Spini could not establish what the requirement even asks for — _"nella sua
testa quali comunicazioni diverse? … cioè che requisito è?"_ — and recorded
being blindsided: _"io sono proprio sconvolta del fatto che nessuno mi abbia
parlato prima di sta mail, cioè che è arrivata così senza preavviso."_

## 🟢 The Mexal and Anticipay error mails work, and the 404s are deliberate

🔑 **This defuses the two sandbox error mails that landed at 10:20Z.** Aurel
Mrruku, unprompted: _"stiamo facendo dei test … perché sto ricevendo 404. Testa
azienda non trovata."_ Elena Spini did not know the notification path worked —
_"non sapevo se effettivamente funzionava"_ — and he confirmed it does:
_"Sì che funziona tutto."_

So `Stato HTTP: 404 — TEST - Azienda non trovata` and the companion
`400 — Creazione cliente Mexal fallita` are **his own test traffic in the
partial sandbox, not a live integration failure.** See
[the Anticipay risk](../risks/Risk%20-%20the%20Anticipay%20field%20build%20has%20not%20started.md)
for what the check is for.

⚠ He is refusing the error-mail layout work without mockups: _"non il layout
della mail che sono già stanco. Ci devono arrivare con dei mo[c]kup se vogliono
ste cose."_ No source says who asked for it.

## 🔑 A Fase 2 scoping draft exists and nobody outside ROMI has seen it

Elena Spini showed a document she called a _"super mega bozza"_ authored by a
**Claudio** — sections for themes already shared, points raised, go-live, and
**four releases with day estimates**. Her own assessment: _"tutto da rivedere e
poi non c'è neanche tutto, quindi praticamente gli costerà come lo stesso
progetto che non vorranno mai."_ She had shown the shape to an **Andrea** for
quoting and been told _"Sì, va bene"_.

🔴 **It still carries 21 October as the go-live** — _"c'era ancora sì la conferma
il 21"_ — so the only internal Fase 2 artefact is anchored to a date two moves
out of date. It is **not in Drive and not shared**; see
[the scope dispute](../risks/Risk%20-%20the%20phase%202%20scope%20dispute%20is%20unresolved.md)
and [OI-83](../items/OI-83%20No%20phase%202%20estimate.md).

⚠ Aurel Mrruku raised two things about it that were not answered: that **45 days
is far too little** for a four-or-five-person team including marketing, and that
**a maintenance phase for what is already built is unscoped** — _"si deve parlare
anche di una fase di maintenance di quello che abbiamo sviluppato, vero? Oppure
viene tutta qua fase 1."_

## 🔑 The campaign-ID gap, and who has to close it

A separate payload workbook carries a column **L** of items _"da verificare"_ on
the single-payload API, which Elena Spini relabelled _"Esito verifica"_ dated the
20th. The named example is the one that has been open for weeks: _"il campagna ID
non esiste solo con loro."_ Aurel Mrruku's point is that it is not only the
website vendor's to answer — _"anche con chi gestisce Sales Force, perché se ci
sono degli automatismi fatti su Sales force, sulla conversione del lead … la
parte del campaign si deve gestire da loro."_

⚠ **Four names appear here and none can be resolved from the record**, so none is
written into a person note: **Beliven** (_"quelli di Beliven … i ragazzi del
sito"_), **Morris** or **Moris** (the Salesforce side — _"a Morris quei valori
hanno un senso che li deve usare su Sales Force"_), **Giuseppe**, and the
**Andrea** above. A fifth, **Giampaolo**, advised on the go-live reply. Recorded
as spoken, with no role or organisation asserted. The `Regina` and `Ana` of
_"io, te, Ana, regina"_ are most likely Rexhina Hysi and Anita Aga, but that is
an inference from the dev group's membership and is **not** treated as fact.

## 🔑 An internal flow review was proposed and not scheduled

Aurel Mrruku offered an hour to ninety minutes with Elena Spini, Anita Aga and
Rexhina Hysi to walk every flow and hear what the client had told her:
_"ci mettiamo un'ora, un'ora e mezza io, te, Ana, regina e facciamo un check e
ci dici tutti i tuoi punti di vista, praticamente su tutti i flussi."_ She
accepted — _"Va bene"_ — and discounted her own standing while doing so:
_"il mio punto di vista vale zero."_ ⚠ **No date was set.**

## 🔴 The marketing half was mishandled, on the record

Aurel Mrruku said so plainly and extended it to the API work:

> _"L'abbiamo gestito malissimo la parte di marketing … non capivamo bene quello
> che era stato detto con loro … non te lo sto dicendo come critica … abbiamo
> fatto lo stesso errore sull'API. È iniziato con Andrea che aveva fatto quello
> che ha fatto. C'erano dei pezzi che mancavano a me. Lui aveva pensato le cose
> in modo, io le ho stravolte perché non avevo capito come le aveva pensate.
> Abbiamo buttato via del tempo prezioso."_

Recorded because it is the first internal account of **why** the marketing and
API work arrived late, and it is first-hand.

## Also stated

- 🟢 **Food Marketing Festival and Tour go to Fase 2**, and he gave the reason
  the client's mail does not: _"l'hanno rimandato perché non avevano pronto
  l'integrazione dal lato loro."_
- 🟡 **The multi-day date question has an internal answer** — _"data evento
  sarebbe la data inizio evento, perché lo volevano loro la data evento, perché
  la data inizio non gli andava bene"_, with the Edizione carrying effective
  event days and a start date. ⚠ Not yet given to the client:
  [OI-273](../items/OI-273%20How%20the%20event%20date%20fields%20must%20be%20filled%20for%20multi-day%20events%20is%20unanswered.md).
- The product carries a restricted `tipo biglietto` picklist, blank allowed, not
  on the layout — which is the field OI-269 would have to propagate to the Asset.
- 🟢 **The migration workbook was being finished during the call** — _"nel
  frattempo stavo preparando quel file Excel e lo mando io a Fabrizio"_ — and it
  went out 88 minutes later ([OI-244](../items/OI-244%20Historical%20orders%20will%20be%20migrated%20from%20Mexal%20by%20spreadsheet.md)).
- ⚠ **Tomorrow's 10:00–11:00 meeting is broader than migration.** Elena Spini:
  _"domani 10-11 ci vuole parlare del tema migrazione e ci vuole parlare di
  diversi open point che ha e problemi."_

## Caveats

- ⚠ **Speaker turns interleave heavily.** Google's transcriber splits sentences
  across the other speaker's lines throughout, so a quotation reassembled from
  consecutive lines can read as one utterance when it was two. Every quotation
  above was reassembled from a single speaker's consecutive lines only.
- ⚠ **Dictation repairs**: `Mark Curent Stage` / `Marquez Current Stage` for
  `Mark Current Stage`; `quot` for `preventivo`/quote; `Wcommerce` for
  WooCommerce; `manuel step` for manual steps; `mocup` for mockup; `piccl` for
  picklist; `Sales Force`/`Salesource` for Salesforce; `Willigal` for the WILEGAL
  project; `Romywick` unresolved. Repairs inside quotations are bracketed.
- ⚠ The transcript carries personal chat (a birthday, a trip) and coarse
  language. Preserved in the raw record, not summarised here beyond the
  availability constraint, which is a scheduling fact.
