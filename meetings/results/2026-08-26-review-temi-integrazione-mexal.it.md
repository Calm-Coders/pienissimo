# [ROMI-PIENISSIMO] Review Temi Integrazione Mexal — 2026-08-26

**Fonti:** [meetings/2026-08-26-review-temi-integrazione-mexal-transcript.it.md](../2026-08-26-review-temi-integrazione-mexal-transcript.it.md) (trascrizione originale italiana, Google Meet + note Gemini, **1h25m45s**) · [registrazione](https://drive.google.com/file/d/1UUpEzSVzPVlXBXrN7HPGvXYp-2NBEfUG/view) · [note e trascrizione](https://docs.google.com/document/d/1f_8YVWSssMOcmk9XRmI2en0aqUGFRG2Bk1vnLItt3zU/edit) · individuata dallo sweep notturno `requirements-check` del 2026-08-26

**Partecipanti:** ROMI — Elena Spini (conduce, **esce a ~01:02**), Aurel Mrruku, Andrea Di Cicco. Pienissimo — Fabrizio Paganelli (anagrafica prodotti / Mexal), Elisa Migliano (`amministrazione@`).
**Assente:** Sabatino Rinaldi era invitato e **non interviene mai** nella trascrizione.

> **Cautela sull'attribuzione.** Le etichette dei relatori in questo progetto sono cronicamente inaffidabili; in questa trascrizione sono insolitamente pulite e gli scambi tecnici sono ben separati. Questo verbale segue la trascrizione, usando il riassunto Gemini solo come riscontro. Dove i due divergono, vale la trascrizione. Il riassunto automatico è corretto ma più povero: omette la regola dei due codici, lo schema combinatorio abbandonato e il fatto che la regola "una sola campagna figlia attiva" è stata superata.

> **Contesto:** prima sessione Mexal dal **14 luglio**, quella che [OI-58](../../notes/items/OI-58%20Mexal%20integration%20mechanics.md) attendeva. Riunione con il cliente. Fabrizio Paganelli è **fuori ufficio nei giorni successivi** e porta la proposta di revisione dell'anagrafica articoli alla direzione Pienissimo **lunedì 31 agosto**.

---

## Il punto principale

🔴 **L'edizione dell'evento viene assegnata da una nuova tabella su Salesforce, gestita a mano e basata sulla data dell'ordine — e questo sostituisce la regola "una sola campagna figlia attiva" concordata il 24 agosto.**

Una riga per ogni combinazione `codice articolo × data inizio × data fine → edizione`, più una **data evento** inserita a mano nella colonna G. Alla generazione dell'ordine ogni **riga d'ordine** viene confrontata sulla **data dell'ordine** con l'intervallo del proprio codice articolo e prende l'edizione dalla riga corrispondente.

Tracciata come [OI-96](../../notes/items/OI-96%20Edition%20mapping%20table%20on%20Salesforce.md). Gemini la classifica sotto **"Da approfondire"** — unico punto in quella sezione — perché Aurel Mrruku ha chiesto un'ora dedicata con esempi concreti prima di implementare. **Quella sessione non è stata fissata.**

---

## Decisioni

### 1. I tre campi di classificazione Mexal sono assegnati e verificati sul campo

Fabrizio Paganelli apre con il vincolo: **l'anagrafica articoli di Mexal ha al massimo tre campi per classificare un prodotto**, nessuno dei quali oggi gestito — _"siamo liberissimi di fare come è più comodo per noi."_ Ogni assegnazione qui sotto è stata verificata durante la call, con Fabrizio Paganelli che modificava su Mexal e Andrea Di Cicco che osservava cambiare la risposta API.

| Campo Mexal | Nome API | Porta | Verificato |
| --- | --- | --- | --- |
| `natura` | `COD_Natura` | **genera biglietto sì/no** | ✅ valore impostato su `CS_00154` (Happy Team), visto via API |
| `categoria statistica` | `Sigla cat sta` + `Numero cat sta` | **l'evento** (Campagna Padre) | ✅ `C01` poi `P02` osservati. **Si spezza in due campi API** |
| `gruppo merceologico` | `GRP merch` | candidato per **tipo biglietto** | ⚠ gerarchico su Mexal; **è arrivato solo il codice, non il livello** |
| `Gest. annullato` (tecnico, 4º) | `Gest. annullato` — `n`/`S` | **prodotto disattivato su Salesforce** | ✅ `CS58` annullato e ripristinato in diretta |

`natura` è collegato a una tabella di base gestita, **non è un campo libero** — Fabrizio Paganelli: _"non posso metterci dentro Pippo."_ Questo risponde alla prima obiezione di Andrea Di Cicco, cioè che chiunque potesse scriverci qualsiasi cosa.

⚠ **I valori non sono stati scelti.** Fabrizio Paganelli porta l'intero schema alla direzione il 31 agosto.

### 2. I prodotti obsoleti si disabilitano tramite `Gest. annullato`, con un costo manuale noto

Esistono circa **1000 codici articolo storici** e i tutor li selezionano. Il pulsante `annulla/ripristina` di Mexal imposta il flag; l'integrazione lo mappa su un flag di inattività su `Product2`; il prodotto smette di essere selezionabile.

**Verificato su una fattura reale**: `CS58` (Food Marketing Festival Gold) è stato annullato mentre una fattura emessa lo referenziava, la fattura è stata riaperta e la riga era ancora visibile. Entrambi gli articoli di test sono stati ripristinati prima della fine della sessione.

⚠ **Elisa Migliano ha portato il caso di errore dall'esperienza reale** — è successo che i tutor facessero preventivi mentre l'amministrazione annullava il codice, il preventivo non passava a Mexal e veniva corretto a mano. Andrea Di Cicco conferma che Salesforce si comporta allo stesso modo: un prodotto disabilitato **non è riselezionabile da nessuno, utenti master e amministrazione compresi**, ma una riga d'ordine esistente può essere modificata inserendo il codice nuovo. Entrambi hanno accettato.

Lo storico resta consultabile — _"tu puoi rivedere tutto lo storico… però non lo puoi selezionare per la vendita."_

### 3. Un articolo che genera biglietto e il suo gemello da bundle sono due codici distinti

Aurel Mrruku: _"devi per forza avere due prodotti, non lo puoi fare un unico prodotto."_ Fabrizio Paganelli ha indicato la convenzione: _"se un codice articolo è visibile, se non è il bundle, avrà il codice A. L'altro codice che è visibile a tutor avrà il codice B."_

⚠ **Questo ribalta la lettura del 24 agosto in [OI-48](../../notes/items/OI-48%20Bundle-only%20article%20codes.md)**, secondo cui `Product2.Solo_Bundle__c` rendeva superflui i codici gemelli. Il flag dice quale sia quale; non elimina il gemello.

### 4. I bundle multi-edizione dello stesso articolo sono fuori perimetro

Andrea Di Cicco solleva il limite imposto dal disegno a intervalli di date: un bundle che venda lo **stesso** evento su 2026, 2027 e 2028 in un unico ordine non è risolvibile, perché tutte le righe condividono la stessa data ordine. Fabrizio Paganelli: _"questa qui è una cosa che non facciamo. Non facciamo."_

⚠ Da leggere in senso stretto. Articoli **diversi** con intervalli **diversi** si dividono su edizioni diverse nello stesso ordine — è proprio il disegno.

### 5. Il biglietto omaggio del no-show va collegato alla campagna figlia successiva

Un buon cliente che non si presenta viene riassegnato manualmente a un biglietto omaggio per l'edizione successiva. Aurel Mrruku aggiunge la conseguenza: l'Asset riassegnato deve **essere collegato a mano anche alla Campagna Figlia successiva**, _"altrimenti… il reminder se non si presenta non scatta più."_ Elena Spini concorda — _"altra casistica aggiunta"_ — subito prima di uscire. **Non esiste alcun controllo che intercetti una riassegnazione non collegata.**

### 6. La fatturazione resta pilotata da Mexal per circa sei mesi

Andrea Di Cicco aveva trovato il JSON per creare la fattura da Salesforce. Fabrizio Paganelli declina: _"per il momento preferisco che venga pilotata solo da Mexal la fatturazione"_, con revisione _"tra 6 mesi quando entreremo a regime."_ Salesforce legge le fatture, non le crea.

### 7. Si usa solo il listino 1

_"usiamo solo l'uno."_ I prodotti hanno due listini; è in uso solo il primo. **Chiude una domanda aperta da luglio**, rinviata da Mirko Merendi a Fabrizio Paganelli.

---

## Action Item

| # | Azione | Responsabile | Quando |
| - | ------ | ------------ | ------ |
| 1 | Portare lo schema di classificazione alla direzione; revisionare e inviare l'anagrafica articoli completa | Fabrizio Paganelli | Direzione **lun 31 ago**; anagrafica "settimana prossima" |
| 2 | Configurare due articoli di test con i nuovi flag (visibilità bundle, generazione biglietto) | Fabrizio Paganelli | Settimana prossima |
| 3 | Mappare `Gest. annullato` di Mexal sul flag inattivo/disattivato di Salesforce | Andrea Di Cicco | — |
| 4 | Sessione dedicata sulla logica riga d'ordine → campagna/edizione, con esempi concreti | il gruppo | ⚠ **non fissata** |
| 5 | Mappatura di dettaglio dell'anagrafica clienti — categoria provvigioni, condizioni documenti di magazzino, campi prealimentati dell'ordine e **i dizionari di valori codificati di Mexal** | Fabrizio Paganelli, Andrea Di Cicco, Aurel Mrruku, Elisa Migliano | 🟢 **2 set 10:00–11:30 CEST**, fissata da Elena Spini la sera stessa — [OI-99](../../notes/items/OI-99%20Customer%20registry%20deep%20mapping%20session.md) |
| 6 | Inviare gli ID dei clienti di test creati a Fabrizio Paganelli **e** ad `amministrazione@` per verifica | Andrea Di Cicco | Subito dopo la call |

---

## Domande aperte / Rischi

- 🔴 **[OI-92](../../notes/items/OI-92%20Mexal%20Scadenziario%20as%20the%20trigger%20to%20reverse%20an%20asset.md) non è mai stato sollevato.** La domanda sullo scadenziario — una fattura *non* pagata può riportare un Asset allo stato precedente? — era verbalizzata il 20 agosto come azione per questa sede, con il proponente (Fabrizio Paganelli) e il responsabile (Andrea Di Cicco) entrambi presenti. **La parola non compare nemmeno una volta nella trascrizione.** Ora non ha più una sede fissata.
- 🔴 **[OI-98](../../notes/items/OI-98%20The%20Mexal%20article%20registry%20is%20being%20re-created.md) — Fabrizio Paganelli intende chiudere tutti i codici articolo attuali e crearne di nuovi**, probabilmente insieme a una revisione dei listini. Rende provvisori `Prodotti e Bundle.xlsx`, la lista eventi, l'evidenza sulle tipologie di biglietto e le 280 righe `Product2` in UAT. **Nessuno ha collegato la cosa alla fine dello sviluppo Fase 1 del 10 settembre.**
- 🔴 **Non esiste ancora un ambiente di test Mexal.** Il cliente `501.08721` e l'ordine `OC11` sono stati creati **in produzione**, sulla serie 10 — _"purtroppo solamente in produzione posso fare i test."_ La richiesta di un'azienda di test non ha ancora un responsabile.
- 🔴 **`tipo nazionalità` è obbligatorio e non documentato.** È la *residenza fiscale*: Italia / San Marino / Città del Vaticano / UE / extra-UE, e determina le regole di trasmissione delle fatture all'ufficio tributario sammarinese. Se Salesforce lo porti o lo derivi non è deciso — [OI-97](../../notes/items/OI-97%20Fiscal%20residence%20on%20the%20customer%20registry.md).
- ⚠ **La documentazione delle API Mexal è incompleta** — _"tutti sti campi non c'erano sulla documentazione."_ `valuta` è stato impostato a `1` per tentativi e **nessuno sa se 1 sia l'euro**.
- ⚠ **Il tipo biglietto ha due risposte in campo.** Il verbale cliente del 20 agosto dice campo gestito solo su Salesforce; questa sessione rimette in gioco il `gruppo merceologico` senza ritrattarlo, e si chiude con _"facciamo una prova"_ anziché con una decisione. Le tipologie invece sono definite: **Executive, Gold, Diamond** — pronunciate da Fabrizio Paganelli e coincidenti con l'anagrafica. `Silver` e `Dinamond` sono entrambi da scartare.
- ⚠ **Lo schema combinatorio a quattro valori è stato proposto e abbandonato in corsa.** Aurel Mrruku ha ipotizzato di comprimere due booleani dentro `natura`, ha fatto marcia indietro quando le tipologie di biglietto sono risultate tre, e Andrea Di Cicco l'ha definito _"un po' complicato"_. **Non implementare su quella base.**
- ⚠ **Rimasto senza risposta nella call:** la relazione uno-a-molti tra tranche e identificativi di riga dell'ordine Mexal. Aurel Mrruku — _"mi devi spiegare sta roba"_ — non ha ottenuto risposta prima della chiusura. Impatta [OI-50](../../notes/items/OI-50%20Tranche%20object.md).
- ⚠ **Il file di disegno principale è ora superato sulle campagne.** `Flows & Objects.drawio` riporta ancora _"Sulle campagne figlie deve esserci logica solo una campagna attiva"_ e il lookup manuale prodotto→campagna padre, entrambi superati qui — vedi [the newest design diagram](../../notes/The%20newest%20design%20diagram.md).

---

## Note

- La sessione è stata **interamente pratica**: Fabrizio Paganelli modificava Mexal in diretta, Andrea Di Cicco confrontava le risposte JSON delle API in tempo reale, Aurel Mrruku seguiva sulla collection Postman. Ogni assegnazione di campo qui sopra è stata dimostrata, non assunta.
- **L'accesso alle WEBAPI Mexal funziona in modo dimostrato.** Andrea Di Cicco ha letto l'anagrafica e creato sia un cliente sia un ordine in produzione durante la call. Qualunque cosa dica il record sulle credenziali ancora dovute, nessuno le ha menzionate e l'accesso è reale.
- L'ordine `OC11` risulta in stato Mexal `S` (*sospeso*); Fabrizio Paganelli conferma che è normale e cambia alla trasformazione in fattura.
- Andrea Di Cicco ha costruito la mappatura del payload cliente partendo dai **campi che Pienissimo condivide oggi con Zoho**, e si aspetta che su entrambi i lati esistano campi utili all'altro. È esattamente il vuoto che [OI-99](../../notes/items/OI-99%20Customer%20registry%20deep%20mapping%20session.md) deve colmare.
- **Lo strascico su Slack della stessa sera**, nel group DM ROMI, è più netto della call. Verdetto di Andrea Di Cicco alle 18:02 CEST: _"le integrazioni per ordini e clienti funzionicchiano"_. Alle 18:16 generalizza il problema della documentazione: 🔴 _"loro hanno dei valori che sono tipo per valuta: 1,2,3,4 — che lato nostro non sappiamo"_ e _"dobbiamo vedere che poi tutti i dati anagrafici arrivano per la fattura"_. **I dizionari di valori codificati di Mexal sono ignoti a ROMI come classe**, non solo per `valuta`, e li aveva già chiesti per email senza risposta. Elena Spini ha fissato il follow-up alle 18:30 e l'invito è partito alle 16:40 UTC.
