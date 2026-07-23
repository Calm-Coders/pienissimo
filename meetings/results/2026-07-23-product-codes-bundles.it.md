# [ROMI-PIENISSIMO] Check Codici Prodotto — Codici prodotto, bundle e livelli di classificazione — 2026-07-23

**Fonti:** meetings/2026-07-23-product-codes-bundles-transcript.it.md (trascrizione originale italiana, Fathom, 45 min) · file di riferimento `anar_PIE_ricla.xlsx` (estratto anagrafica articoli) condiviso da Fabrizio

**Partecipanti:** Aurel Mrruku (ROMI), Fabrizio Paganelli (Pienissimo — admin/Mexal), Elena Spini (ROMI — presente ~1:00→13:40, poi disconnessa). Nota: le etichette Fathom sono affidabili qui (solo tre voci); Aurel guida le domande, Fabrizio le risposte.

> **Contesto:** sessione di lavoro per decodificare `anar_PIE_ricla.xlsx` — l'estratto anagrafica articoli inviato da Fabrizio — prima che ROMI inizi a costruire bundle d'esempio su Salesforce. Nessuna nuova architettura che ribalti decisioni precedenti; qui si **spiegano i dati sorgente** e si **specificano le picklist di classificazione dei bundle**. Conferma e àncora al file reale le decisioni sui bundle del 02/07 e 07/07.

## Come l'Excel si mappa su quanto deciso (il cuore di questo recap)

**I 7 livelli `LIVELLO_` sono legacy.** Fabrizio: sono "il retaggio di una serie di epoche storiche" — diversi non si usano più. Nella mail di ieri ha detto di **guardare principalmente LIVELLO_0 e LIVELLO_6**, gli unici due che mantiene davvero. MA due livelli intermedi portano l'informazione che diventa le nuove picklist Salesforce:

- **LIVELLO_3 = l'evento/edizione** in cui il pacchetto è stato venduto (Academy 26, Food Marketing Festival 25, …). Ha **42 valori distinti**, ma la maggior parte sono promo una tantum / roba vecchia; contano solo i ~7 eventi reali (sotto).
- **LIVELLO_4 = il tipo di pacchetto** ("Anno con Pienissimo", "Anno con Pienissimo Ripetente", + un "con Performance Plus" mai codificato). Esattamente **3 valori distinti** — coincide col file.

**Prima colonna `_ARTIP` — il tipo di record — ha tre valori, ora decodificati:**

| `_ARTIP` | Significato                                   | Prefisso codice | Ruolo                                                                                    |
| -------- | --------------------------------------------- | --------------- | ---------------------------------------------------------------------------------------- |
| **A**    | Prodotto ordinario / tutti gli altri articoli | (vari)          | Gli item reali vendibili                                                                 |
| **Z**    | **Rata (blocco)** — una "prestazione"         | `BLO-`          | Una rata di pagamento di un bundle, porta il prezzo rata nella colonna prezzo di listino |
| **C**    | **Bundle / pacchetto** ("campionario")        | `PACK-`         | Il contenitore; associa i blocchi BLO + gli articoli componenti a €0                     |

⚠ **Non** confondere `_ARTIP = Z` (rata/blocco) con `LIVELLO_0 = "Z) Obsoleti"` (ramo obsoleti dell'albero) — cose diverse che usano entrambe la lettera Z.

**Il meccanismo bundle su Mexal, confermato esattamente come ROMI l'aveva ricostruito** (è il pattern legacy che viene dismesso):

1. Prima si creano i codici `BLO-` (`_ARTIP = Z`), ognuno con **prezzo di listino = importo di quella rata**. Sono le rate.
2. Poi si crea il bundle `PACK-` (`_ARTIP = C`). Su Mexal si associano **sia** i blocchi BLO **sia** ogni articolo componente reale — ma i componenti sono tutti a **prezzo €0 (omaggio)**, perché Mexal permette di valorizzare solo il codice `BLO`. Le righe a €0 servono solo a far vedere al cliente cosa c'è dentro ogni rata.
3. Lettura di Aurel, confermata da Fabrizio: es. `PACK-78` (Performance Plus Pack Tour 2025) = valore bundle diviso in 12 rate; ogni `BLO` = una rata; il blocco raggruppa gli item che cadono in quel mese. **Il blocco è una data di pagamento, non un prodotto.**

## Decisioni

- **L'infrastruttura C / Z / BLO / PACK NON sarà migrata su Salesforce.** Riconfermato (riconferma 02/07 + 07/07). Su Salesforce non c'è il bundle-di-rate-di-blocchi: il bundle esplode in **righe d'ordine che sono i prodotti reali, ognuna con una data**, e ROMI **raggruppa per data in rate**. Elena l'ha ribadito e Fabrizio ha confermato: "i blocchi non ci saranno più … righe direttamente dai prodotti con indicazione di data e poi raggruppiamo noi in base alla data per rata." I codici BLO e le righe omaggio a €0 spariscono del tutto.
- **Va evidenziato nel documento di progetto/blueprint in "giallo fosforescente".** Fabrizio ha chiesto esplicitamente che la decisione "niente più blocchi in fattura — il cliente vede solo codici prodotto reali, valorizzati, con date" sia evidenziata, in grassetto, bordata, col timbro — perché _lui_ ha richiesto la rimozione dei blocchi e vuole che sia inequivocabile quando le fatture in futuro appariranno diverse. → action item di documentazione.
- **Opzioni prezzo del bundle — entrambe consegnate, la scelta è del business per ogni bundle.** La build di ROMI supporta (a) un **prezzo bundle fisso** che scrivi tu, e (b) un **prezzo auto-calcolato dai componenti**. Fabrizio conferma di volerle entrambe disponibili (non conosceva il default desiderato da Pienissimo). Se imposti il prezzo bundle fisso, la suddivisione in rate si fa **a mano**. (Coerente col modello spread, #43.)
- **Classificazione del bundle = tre campi picklist, con una dipendenza.** Struttura concordata per il record bundle:
  1. **Anno (anno solare) — il campo master.** ⚠ Usare **"anno solare", NON "anno accademico".** Fabrizio ha segnalato che "anno accademico" è un concetto Pienissimo _diverso_ (va maggio→settembre, usato per la **generazione dei biglietti**) e creerebbe confusione se riusato sui bundle.
  2. **Evento — dipendente dall'anno.** Picklist dipendente Salesforce: scegli l'anno → compaiono solo gli eventi di quell'anno. Il business crea l'anno e il suo sottoinsieme di eventi **a mano ogni anno** (admin, nessun rilascio dev).
  3. **Tipologia di bundle (tipo pacchetto)** — es. Anno con Pienissimo / Anno con Pienissimo Ripetente / altro. **Indipendente** sia dall'evento sia dall'anno (Fabrizio: "completamente slegati" — qualsiasi tipo pacchetto può essere venduto in qualsiasi evento in qualsiasi anno).
- **I 7 eventi reali (seed della picklist Evento).** Lista canonica di Fabrizio, in ordine di anno accademico: **Tour · Food Marketing Festival · Pienissimo Live · Academy · Sold Out · O.D.B. Live · Camerieri Venditori · (Happy Team — non vende nulla) · Mastery.** Invierà la lista definitiva via mail; Aurel ha aperto il thread live per scriverla insieme. Alla direzione interessa soprattutto il pacchetto **"Anno con Pienissimo"** (cliente iscritto per un intero anno accademico).
- **"Genera biglietto" come flag a livello di prodotto, non logica di codice.** Ogni evento ha diversi articoli-biglietto (a pagamento, omaggio, aggiuntivo). Il _set_ di codici articolo che generano un biglietto sarà mantenuto da un **flag sì/no sul record prodotto** nell'anagrafica importata — attivabile dall'admin, senza intervento sviluppatore — invece che codificato/letto dalla stringa del codice. (Riconferma un'idea precedente; Aurel ha insistito per un flag invece di leggere una lettera nel codice.) I codici articolo sono **unici e stabili** — Fabrizio conferma che non li cambiano, il che è importante per mantenere integro il set che genera i biglietti.
- **Codici articolo "solo bundle" con flag, non lettera nel codice.** Fabrizio creerà ~**10 nuovi codici articolo** (uno per evento, es. "Academy (B)") da usare **esclusivamente nei bundle** — i tutor non devono usarli in vendita diretta, perché **gli agenti non prendono provvigioni sulle vendite dei bundle**. Invece di codificare una "B" nel codice (difficile da leggere), ROMI li marcherà con un **flag a livello di prodotto "usare solo nei bundle"**. Aurel aggiunge il flag su Salesforce; Fabrizio replica la stessa struttura dalla sua parte.

## Action Items

| Task                                                                                                                                                                                                              | Owner                         | Stato                                                                                       |
| ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------- | ------------------------------------------------------------------------------------------- |
| Inviare ad Aurel la **lista definitiva dei 7 eventi** per la picklist Evento (Tour, Food Marketing Festival, Pienissimo Live, Academy, Sold Out, O.D.B. Live, Camerieri Venditori, Mastery; Happy Team non vende) | Fabrizio                      | Aperto — iniziato live nel thread mail                                                      |
| Inviare ad Aurel la **spec dei campi anno-solare + evento + tipologia-bundle** scritta nel thread mail (confermare struttura master/dipendente)                                                                   | Aurel → Fabrizio (co-scritta) | Aperto                                                                                      |
| Creare ~**10 codici articolo solo-bundle** (uno per evento, convenzione "(B)") + inviare 3–5 esempi a ROMI **prima di settembre**; flaggarli "usare solo nei bundle"                                              | Fabrizio                      | Aperto — promesso "per domani"; a ROMI servono i sample per iniziare la logica di selezione |
| Costruire **bundle d'esempio su Salesforce** dai ~200 item significativi (solo struttura bundle, senza prezzi/date); mostrare al **prossimo incontro (~1 settimana)**                                             | Aurel / ROMI                  | Aperto                                                                                      |
| Mostrare il **bundle completo con rate + prezzi spread sui componenti** — target **fine agosto** (Aurel in ferie ~2 settimane a metà agosto)                                                                      | Aurel / ROMI                  | Aperto                                                                                      |
| Configurare le **picklist anno-solare (master) → evento (dipendente)** + campo **tipologia-bundle** sull'oggetto bundle                                                                                           | ROMI                          | Aperto                                                                                      |
| Aggiungere i flag **"genera biglietto" (sì/no)** e **"solo bundle" (sì/no)** sull'oggetto prodotto/articolo in import                                                                                             | ROMI                          | Aperto                                                                                      |
| **Blueprint:** evidenziare (il "giallo fosforescente" di Fabrizio) che i blocchi BLO + righe omaggio a €0 spariscono — le fatture mostrano solo codici prodotto reali, valorizzati, con date                      | ROMI (blueprint)              | Aperto                                                                                      |

## Domande aperte / Rischi

- **Di quali livelli di `anar_PIE_ricla.xlsx` fidarsi:** ufficialmente solo **L0 + L6** sono mantenuti, eppure la riunione si appoggia su **L3 (evento)** e **L4 (tipo pacchetto)** per le picklist. L3 è popolato solo ~55% e 42-valori (per lo più rumore); L4 è 3-valori ma popolato ~20%. I valori picklist vengono **ricreati puliti dalle liste canoniche di Fabrizio**, non migrati da queste colonne — trattare i livelli Excel come riferimento, non come fonte di verità.
- **Suddivisione in rate del bundle a prezzo fisso** è manuale oggi — nessuna regola forza ancora le rate (o gli spread dei componenti) a riconciliare col prezzo bundle fisso (lega a #43, enforcement varianza).
- **~10 codici solo-bundle non ancora creati**; ad Aurel servono almeno 3–5 sample prima di settembre per costruire la logica di selezione. Fabrizio non può renderli invisibili sul sito, quindi crearli davvero presto rischia l'uso improprio — esempi placeholder/fasulli ok per iniziare.
- **Regola provvigioni** (gli agenti non prendono provvigioni sulle vendite bundle) è il _motivo_ dei codici solo-bundle — da catturare dove verrà modellata la logica provvigioni.

## Note

- Questa sessione valida la ricostruzione indipendente di ROMI di `anar_PIE_ricla.xlsx`: `_ARTIP` A/Z/C, la separazione `PACK-`/`BLO-`, e la lettura dei 108 bundle = offerte-pagate-a-rate sono state tutte confermate da Fabrizio sullo schermo Mexal live (ha aperto `PACK-78` e un ordine "Anno con Pienissimo" e li ha esplosi).
- Fabrizio ha mostrato l'esplosione live di un ordine Mexal: blocco 1 = prima rata (acconto, es. €900) + i suoi item componenti, blocco 2 = seconda rata + i suoi item, e così via fino al valore completo del bundle.
- Il tab "Significativi" (~200 item) è il set di lavoro che Aurel userà per i primi bundle d'esempio su Salesforce.
- Nota terminologica catturata: **anno solare (bundle) vs anno accademico (mag→set, generazione biglietti)** devono restare campi distinti per evitare confusione.
