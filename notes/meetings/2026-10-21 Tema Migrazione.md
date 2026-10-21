---
id: meeting-2026-10-21-tema-migrazione
type: meeting
status: resolved
owner: Aurel Mrruku
org: both
raised: 2026-10-21
updated: 2026-10-21
source: meetings/2026-10-21-tema-migrazione-transcript.it.md
---

# 2026-10-21 Tema Migrazione

**Client call, 14:31 CEST, 01:57:34.** Fabrizio Paganelli and Elisa Migliano for
Pienissimo; Elena Spini and Aurel Mrruku for ROMI. Booked at the end of
[the morning session](2026-10-21%20Check%20Dati%20Migrazione%20e%20OP.md) to design
a way through the ticket-migration blocker it had surfaced. **It produced the
first end-to-end migration design this project has had**, including the import
key, the dummy-edition mechanism, the order and order-line field list, and the
decision to keep Pienissimo Live 2026 off Salesforce entirely.

Full raw transcript preserved at
[meetings/2026-10-21-tema-migrazione-transcript.it.md](../../meetings/2026-10-21-tema-migrazione-transcript.it.md)
(read once, in full). Same Gemini dictation caveats as the morning note; the
transcript governs over the document's own notes section.

Elena Spini opened by naming three migration themes — _"tema biglietti e
campagne, edizioni, tema ordini e tranche, il tema ordini e di performance
plus"_ — and Fabrizio Paganelli collapsed them into one: _"secondo me è … un
argomento unico … quando noi … andremo a tirar su i dati degli ordini storici, in
mezzo ci sarà tutto."_

## 🟢 The design, in the order it was built

### 1. Closed orders and open orders are separated

Aurel Mrruku: _"prima dobbiamo dividere gli ordini chiusi dai ordini aperti …
io non mi aspetto che gli ordini chiusi, dobbiamo ricalcolare tutto, contratti,
tranche, eccetera."_ Definition agreed: a **closed** order has an invoice and is
fully collected; an **open** order is not collected or only partly so.

🔑 **The client has no partly-invoiced orders at all** — Fabrizio Paganelli: _"per
come siamo strutturati non abbiamo ordini parzialmente fatturati, abbiamo solo
ordini ancora da fatturare"_ — and the current open set is **about ten orders**,
mostly 2026 with one from 2025. Aurel Mrruku: _"ancora meglio."_

### 2. The order key must carry the order date

See [OI-275](../items/OI-275%20The%20Mexal%20order%20key%20is%20not%20unique%20without%20the%20order%20date.md).
`sigla` + `serie` + `numero documento` is not unique in Mexal because numbering
restarts every year. Resolved with a fourth element and confirmed against the
Mexal API mid-call.

### 3. Automatic order transmission to Mexal is blocked during the import

🔑 **This is the bypass [OI-267](../items/OI-267%20Loading%20historical%20orders%20would%20push%20them%20to%20Mexal%20and%20generate%20tickets.md)
was waiting for.** Aurel Mrruku: _"devo bloccare l'invio dell'ordine su
[M]ex[a]l, devo salvare in questa chiave le informazioni che ci sono già su
Mexal, quindi l'ID dell'ordine e ogni volta che ci arriverà una fattura poi da
Mexal dobbiamo fare un check … nella chiave."_ Agreed; not yet built.

### 4. Editions are matched on the invoice date, not the order date

Normally a ticket is bound to its edizione by the **order creation date** through
the mapping table. For the one-off import that is reversed, at Fabrizio
Paganelli's request: _"per fare questa importazione massiva che la faremo una
tantum anziché data ordine considera data fattura."_ Aurel Mrruku: _"basta che mi
dai una data."_ Elena Spini stated the rule precisely: _"che la data di fattura
sia compresa nella data di competenza dell'edizione."_

⚠ **It needs a code condition that must be removed afterwards.** _"devo ribaltare
un po' la logica solo per l'inserimento … devo fare qualche condizione io"_, and
after go-live _"devo ricambiare queste logiche perché deve stare il flusso quello
normale."_

### 5. Dummy "Pippo" editions carry the history

See [OI-276](../items/OI-276%20Dummy%20import%20editions%20are%20needed%20to%20load%20historical%20orders.md).
Fabrizio Paganelli's design, which Aurel Mrruku accepted and called better than
the alternative (_"Ha anche più senso così"_). Every product in the load needs an
edizione whose date range contains its invoice date, or the import fails —
Aurel Mrruku: _"mi esplode tutto, perché non trova la campagna."_

### 6. Order and order-line fields were cut down line by line

See [OI-244](../items/OI-244%20Historical%20orders%20will%20be%20migrated%20from%20Mexal%20by%20spreadsheet.md)
for the resulting spec. Decisions worth keeping:

- Order date in compact form, as the Mexal API returns it: _"quindi 20 25 03 15 …
  Tutto unito."_
- Drop: `codice cliente` (already on the order), `codice destinazione`, `tipo
  ordine`, `totale imponibile` (recomputed from the lines), `tipo riga`,
  `descrizione articolo`, `unità di misura`, `prezzo di listino` (taken from the
  product), `totale riga`, `codice IVA`.
- Keep: `codice agente` (_"mi serve per forza"_), the four payment codes
  Salesforce knows, the cancellation flag with value `N` (_"La stessa N vuol dire
  non annullato"_), `codice articolo`, the Mexal line id, **net price only**
  (_"se tu mi passi il prezzo net[t]o … verrà calcolato lo sconto in modo
  automatico"_), and the line **due date**, from which the tranches are built.
- 🔑 **The line payment status need not be supplied.** Aurel Mrruku: _"non mi deve
  manche passare lo stato, perché lo stato io ce l'ho nello scadenziario e lo
  prenderai in automatico."_ He will run the scadenzario from the start of 2025
  rather than the usual rolling window. 🔴 **That derivation runs through the
  file [OI-212](../items/OI-212%20A%20Ri.Ba.%20rate%20reads%20as%20paid%20before%20its%20due%20date.md)
  reports as defective** — and the `P` convention was restated here unchanged:
  _"P[E] era pagato … anche quello l'ho trattato come pagato … se lo stato è nullo
  vuol dire che non è stato pagato."_
- All migrated orders come in as **standard**, bundles included: _"I bundle
  saranno standard."_ Fabrizio Paganelli accepted losing the categorisation on
  history — _"sui dati storici non me ne frega niente … l'importante è che
  carichiamo lo storico affinché ogni tutor veda qual è il fatturato di quel
  cliente."_

### 7. Performance Plus orders load without contracts

See [OI-280](../items/OI-280%20Performance%20Plus%20contract%20generation%20must%20be%20bypassed%20for%20migrated%20orders.md).
Hand-entry of the historical contracts was tried on screen and abandoned: the
Salesforce model is one contract to one order, the client's history is one
contract to many orders, and the scadenzario logic updates through the link.
Fabrizio Paganelli: _"In questo qui faremo in un altro modo, dai."_

## 🟢 Pienissimo Live 2026 stays off Salesforce

🔑 **A decision with no prior record.** The edizione will not be created in
Salesforce at all and the 23–26 November event runs entirely on Zoho.
Fabrizio Paganelli: _"è pienissimo live 2026 e io non la creerò l'edizione su
Sales Force … Per il pienissimo live del 24 25 26 di novembre lavoriamo tutto su
Zo[ho] … anche perché abbiamo tutto là."_ Elena Spini: _"questo non l'avevo
ancora capito io."_ From the Academy in January, tickets go out from Salesforce:
_"quando saremo a gennaio che ci sarà l'Academy, i biglietti li manderemo via
direttamente da Salesforce."_ Elena Spini: _"Speriamo."_

⚠ **Whether those tickets have been sent was answered both ways in one call.** At
`00:48:15` Fabrizio Paganelli said they had — _"Li stanno mandando adesso i
biglietti del pianissimo live"_ — and at `01:15:32`, asked again, _"I biglietti
non li abbiamo inviati."_ Elena Spini agreed with the second. **Recorded as
contradictory; not resolved.**

## 🟡 How far back the history goes is still open

Fabrizio Paganelli moved from 2025 to considering 2024 during the call —
_"sarebbe anche corretto che loro vedano 24 25 26 … almeno hanno gli ultimi 3
anni di vendita"_ — with a caveat: in 2024 the company also sold the software
platform and _"avevamo un sacco di porcheria"_, so those lines must be filtered
out. Volumes read off his warehouse: **~30,000 article lines from Jan 2024**, of
which **~9,000** after 2024, so **~21,000 in 2024 alone**, reducible to
_"una quindicina di migliaia"_. Aurel Mrruku's answer was to send everything:
_"passaci tutto, ti dico dove c'ho i più grandi, se ho errori."_ He estimates
**3–4 hours** for the full invoice/scadenzario run over three years and
**2–3 days, optimistically 4**, to build the whole mechanism in UAT.

## Corrections to assumptions held before this call

- 🔑 **Mexal does keep the order after invoicing.** Aurel Mrruku had been told
  otherwise: _"Mirko da quello che m'ha detto che quando viene creata una fattura
  quell'ordine non esiste più. tu mi hai detto che esiste."_ Fabrizio Paganelli
  demonstrated the link live from his Zoho Analytics warehouse, where the invoice
  row carries `sigla ordine`, `serie ordine`, `numero ordine`, `data ordine` and
  the common customer code.
- 🟢 **The contact data needs no change.** Aurel Mrruku checked the `referenti`
  workbook on screen for a main-contact flag, found `contatto principale`, and
  closed the question: _"quindi in automatico noi mandiamo al contatto
  principale."_ Fabrizio Paganelli: _"Quindi non abbiamo problemi di tracciato
  dati. Cioè io non ti devo aggiungere niente nel tracciato."_
- ⚠ **Contacts were deliberately not all loaded into UAT.** _"ho fatto dei test,
  però erano tanti, li ho lasciati … perché non volevo sovraccaricare l'ambiente
  di test."_

## Next steps as stated in the room

| Owner | Action |
| ----- | ------ |
| Fabrizio Paganelli | Produce the full order and order-line extract with the agreed columns. Started the same evening — the first draft went out at 17:01Z asking for 15–30 minutes on 22/10. |
| Fabrizio Paganelli | Create the future and dummy editions with date ranges, and map every product to its edizione **before** the import. |
| Aurel Mrruku | Block automatic Mexal transmission for the import; store the Mexal order key; reverse the edizione match onto the invoice date; generate tranches from the line due dates; bypass Performance Plus contract creation. |
| Aurel Mrruku | Mass-delete the tickets generated against the dummy editions once the load is verified. |
| Fabrizio Paganelli | Decide whether 2024 is included, after inspecting data quality. |
