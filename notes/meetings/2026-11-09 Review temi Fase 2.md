---
id: meeting-2026-11-09-review-temi-fase-2
type: meeting
status: resolved
owner: Elena Spini
with: Fabrizio Paganelli
org: both
raised: 2026-11-09
updated: 2026-11-09
depends_on: []
blocks: []
source: Drive 100aUbWa-XJNeEQrelorBT0FJ_mvF6Ad1u5CQMXr7VGU
---

# 2026-11-09 - Review temi Fase 2

**The client review of the Fase 2 roadmap, 00:56:14, on the morning of the
technical go-live. Elena Spini presented a roadmap that has grown from five
releases to seven; the client accepted it and the whole plan now runs to
12 April 2027. The scadenziario release is dated 14 December and its scope is,
explicitly, making the asset go backwards. Two new things came out of it: the
contract must be signed by the account's legal representative, pending a lawyer,
and the detailed technical analysis of the scadenziario is to be brought forward
to before Thursday.**

## Attendees

- **Elena Spini** (ROMI) — presented the roadmap
- **Aurel Mrruku** (ROMI)
- **Fabrizio Paganelli** (Pienissimo)
- **`amministrazione@pienissimo.com`** (Elisa Migliano) — on the invitation;
  ⚠ **whether she spoke is not established** from the material available, and
  Fabrizio Paganelli addresses an _"Elisa"_ once
- 🔴 **Sabatino Rinaldi** — not on the invitation

## Sources, and what is missing

- Gemini notes document `100aUbWa-XJNeEQrelorBT0FJ_mvF6Ad1u5CQMXr7VGU`
  (18,254 chars), owner `e.spini@romicompany.com`, created 2026-11-09 10:29:39Z.
- 🔴 **No full transcript exists.** The Drive meeting folder
  `1zoyHRByosf9weo7M8ZH67a_G_-89szlG` holds **one shortcut only**, to this notes
  document, and the document's own transcript tab **starts at `00:30:41`** of a
  56-minute call. **The first half hour survives only as Gemini's summary.**
- ⚠ **So this note mixes two grades of evidence.** Everything from `00:30:41`
  onward is quoted from the transcript. Everything before it is attributed to
  **the auto-summary**, which this project's records have caught contradicting
  transcripts before, and is marked as such.
- ⚠ **Gemini garbles two names**: _"Andrea Palmarigi"_ is **Andrea Parmeggiani**,
  and _"codici Maxal"_ is Mexal.

## 🔑 The roadmap is now seven releases ending 12 April 2027

Per the summary, Elena Spini presented _"la roadmap aggiornata a sette rilasci,
iniziando dal rilascio zero per i contratti da palco su cui Aurel mrruku sta già
lavorando, e il rilascio uno dedicato allo scadenziario ipotizzato per il
14 dicembre"_.

The ordering, as the client saw it and as the offer deck now states it:

| Release | Content | Go-live |
| --- | --- | --- |
| R0 | Contratti post-vendita da palco | **Nov 2026**, before Pienissimo Live |
| **R1** | **Aggiornamento scadenziario** | **14/12/2026** |
| R2 | Annullamento e cambio nome, plus the provisional contact import | **14/01/2027**, before the Academy |
| R3 | Info Point | **15/02/2027** |
| R4 | Eventi multi-edizione e multi-giorno | **08/03/2027** |
| R5 | Integrazioni e notifiche | **22/03/2027** |
| R6 | Note di credito | **12/04/2027** |

Elena Spini on the last move, from the transcript: _"siamo arrivati anziché a fine
a marzo, **siamo arrivati a metà aprile** per un finale che è questo. Ora date
fatte così un po' alla buona … perché comunque è una stima ad alto livello, ma
**idealmente sono questi sette rilasci**."_

See [the Fase 2 offer](../The%20Fase%202%20offer.md) for the deck and
[OI-342](../items/OI-342%20The%20Fase%202%20offer%20V2%20reorders%20the%20releases%20and%20contradicts%20itself.md)
for what is still inconsistent.

## 🔑 R1 is the reverse gear, and the client confirmed it

Per the summary, Fabrizio Paganelli and Aurel Mrruku agreed _"che la modifica del
pagamento non attiva direttamente asset o ordini, ma **richiede un aggiornamento
dello stato dell'asset richiesto da Fabrizio Paganelli**"_, and Aurel Mrruku
_"ha sottolineato la necessità di un'analisi tecnica e funzionale dettagliata che
includa anche la parte di marketing"_.

And the design consequence, in the summary's words: the order states _"avanzavano
linearmente (ordine, asset, fattura, scadenziario, invio biglietto/link), mentre
**ora occorre gestire passaggi all'indietro e la cancellazione o modifica dei
record**"_.

🟢 **The detailed analysis was pulled forward.** Fabrizio Paganelli _"ha proposto
di anticipare l'analisi tecnica di dettaglio nei giorni precedenti a giovedì"_ —
so **before Thursday 12 November** — _"trovando il pieno accordo di Aurel Mrruku,
il quale ha chiesto di procedere al più presto"_.

→ [OI-331](../items/OI-331%20A%20reversed%20collection%20cannot%20move%20the%20order%20and%20asset%20states%20back.md)

## 🆕🔑 The contract must be signed by the legal representative

From the transcript, `00:38:20`, Fabrizio Paganelli:

> _"il contratto lo deve firmare **il legale rappresentante dell'account**, quindi
> è lì si tratta di aggiungere questi campi e adesso **mi informo anche meglio con
> l'avvocato**, però si tratterebbe di aggiungere questi campi e se non li abbiamo
> già previsti nel tracciato dati e poi dopo fare in modo che quando parte il
> contratto sia firmato dal legale rappresentante."_

The fields are _"nome, cognome, indirizzo, eccetera"_, discussed when the mappings
were done. 🟢 **Aurel Mrruku offered the existing mechanism**: _"se metti quello
come contatto principale, perché noi abbiamo il meccanismo di contatto
principale, possiamo usare quello"_ — accepted in principle, _"poi ne facciamo un
check insieme"_. Fabrizio Paganelli: _"magari è superfluo per noi tecnicamente, ma
**è importante giuridicamente**."_

🟢 **The ragione-sociale half of this is already solved** — the Account carries a
previous-company code: _"nei vari campi c'è il codice account precedente … per
tener traccia di dei clienti che cambiano la ragione sociale, quindi quello
dovrebbe essere a posto"_, confirmed on screen under `dati commerciali`.

→ [OI-346](../items/OI-346%20The%20contract%20must%20be%20signed%20by%20the%20account%20legal%20representative.md)

## 🔑 Anticipay, and what the QR timeout actually was

From the transcript, `00:31:43` - `00:33:58`. Elena Spini raised the production
timeouts she remembered against Info Point and the QR scanner. Aurel Mrruku
corrected both:

> _"Quello di q\[uel\] \[QR\] cod\[e\] è il contrario. Loro scanarizzano il
> biglietto, ci chiamano per \[ag\]giornare il biglietto"_ — and the timeout
> _"era Anticipay"_.

> **Aurel Mrruku:** _"quello che si deve capire \[è se\] Anticipay in produzione e
> aggiornamento del biglietto in produzione **hanno già sistemato lato loro**."_
>
> **Fabrizio Paganelli:** _"Non lo so. … adesso gli ho scritto ad Andrea. …
> magari se non vi dovesse rispondere in giornata, vi ho messo in conoscenza
> tutti e due. … Io comunque adesso quando finiamo la call **vado di là di persona
> e glielo chiedo**."_ And to Aurel Mrruku: _"chiamalo anche tu. Scrivigli anche
> tu."_

🔑 **Both the Anticipay call and the ticket-update app are Andrea Parmeggiani's.**
_"quello che gestisce app, quindi il sistema che gestisce l'applicazione per
scanarizzazione dei biglietti"_ — _"Ah, è sempre Andrea."_

→ [OI-312](../items/OI-312%20Anticipay%20times%20out%20in%20production.md)

## 🔑 The order load, as reported to the client

Per the summary, Aurel Mrruku said he had loaded _"tramite SS file importer
18.000 ordini con altrettante righe"_, with _"31 ordini … privi di account"_ and
payment codes forced to `12`; no anomalies.

🔴 **The 18,000 figure is the auto-summary conflating orders with lines.** This
record holds, from the load itself and the 06/11 mail to the client,
**8,162 orders and 18,006 lines**. The `31` and the payment-code adjustment match.
See [OI-244](../items/OI-244%20Historical%20orders%20will%20be%20migrated%20from%20Mexal%20by%20spreadsheet.md).

🆕🔑 **The definitive import's mechanics were stated**: _"l'import definitivo
utilizzerà un **aggiornamento di tipo upsert per i dati mancanti e insert per i
nuovi record**"_, and 🔴 **a differing Mexal code produces a new order rather than
overwriting one** — _"i codici Ma\[Me\]xal differenti vengono trattati come nuovi
ordini anziché sovrascritti"_. Aurel Mrruku offered analysis and update scripts
where needed. Fabrizio Paganelli proposed **exporting from Salesforce to check the
test orders are aligned**.

## Dates and operational facts stated

- 🔑 **Platform usage peaks from 16 November** (tutors and invoicing) and **full
  sales on 26 November**, per Elena Spini in the summary.
- ⚠ **Aurel Mrruku flagged the timing against the 24 November event** and said
  **priority goes to production maintenance**, not Fase 2 development.
- **Fabrizio Paganelli owes the commercial data by Thursday morning** (12/11).
- **Academy 19/01/2027**; Elena Spini refused to move R2 past it even though
  Aurel Mrruku asked for _"almeno … una settimana in più, perché … noi torniamo
  dopo le vacanze"_, leaving _"5 giorni di lavoro"_.

## Decisions and deferrals, as the summary records them

| | |
| --- | --- |
| 🟢 **Agreed** | A provisional Excel template for check-in contact capture, until the Info Point integration → [the decision](../decisions/Decision%20-%20the%20Info%20Point%20check-in%20is%20bridged%20by%20a%20manual%20contact%20import.md) |
| ⚠ **Deferred to Pienissimo direction** | The custom object for multiple check-ins in R4 — _"c'è caso che sia anche un elemento che viene soppresso, perché se la direzione dice 'No, no, a me non me ne frega niente del multiingresso'"_ |
| ⚠ **Deferred to a lawyer** | The legal-representative fields and how the contract is signed (OI-346) |
| ⚠ **Deferred to Rebecca Marmo** | The R2 timing, and the timing conditions between the participant/ticket email and the event date → [OI-350](../items/OI-350%20The%20R2%20date%20and%20the%20ticket%20email%20timing%20conditions%20need%20Rebecca.md) |

## Next steps, as the summary assigns them

| Owner | Action |
| --- | --- |
| Aurel Mrruku | Analysis and scripts for the order differences on Salesforce |
| Aurel Mrruku | Write or call Andrea Parmeggiani if no answer the same day |
| ⚠ Unassigned | Export data from Salesforce to verify alignment between systems |
| Fabrizio Paganelli | **Transmit the commercial data to the team by Thursday morning** |
| Fabrizio Paganelli | Consult the lawyer on the contract fields |
| Elena Spini | Consult Andrea Galotto on the estimate and the extended timeline |

## 🔑 The commercial consequence, stated to the client

Per the summary, Elena Spini said that going **from five releases to seven**, plus
the scadenziario work, _"richiederanno tempo aggiuntivo e un potenziale incremento
delle stime"_, that she must settle the contractual and commercial handling with
**Andrea Galotto under Daniela Morgese's supervision**, and 🔑 **that maintenance
must be formally included in the release documentation**. On the transcript she put
it plainly: _"la stima la devo rivedere … **aumenterà, non può diminuire**."_

🔴 **The offer deck created that evening still reads `150 giornate`**, unchanged
from the six-release version — see
[OI-342](../items/OI-342%20The%20Fase%202%20offer%20V2%20reorders%20the%20releases%20and%20contradicts%20itself.md)
and [OI-308](../items/OI-308%20Fase%202%20maintenance%20was%20left%20out%20of%20the%20estimate.md).

⚠ **The client has not yet been sent the deck.** Elena Spini on the call: _"se tu
mi dai l'ok … faccio un'ultima chiacchiera con Andrea e poi noi mandiamo il tutto
e vi mettiamo in copia e … Andrea manda \[a\] Daniela"_. **Approval is due
13 November.**

⚠ **The last minute of the recording is after the goodbyes** and is Pienissimo
internal talk, including a remark about the training starting minutes later. It is
not used here.
