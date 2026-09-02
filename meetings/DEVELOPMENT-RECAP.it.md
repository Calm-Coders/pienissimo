# ROMI-PIENISSIMO — Recap di Sviluppo Salesforce

> Consolidato dalle 8 riunioni tracciate (27/05/2026 → 23/07/2026), **vince la decisione più recente**. Ogni voce cita la riunione di origine. Legenda stato: ✅ DECISO · 🟡 CONDIZIONATO (deciso, in attesa di una verifica) · 🔴 APERTO (blocca la build — vedi §9).
> ⚠ **Precedenza, dal più recente: §19 → §18 → §17 → §16 → §15 → §14 → §13 → §12 → [§11](#11-aggiornamento-06082026--sessione-di-chiusura-dei-punti-aperti) → [§10](#10-aggiornamento-03082026--sweep-multi-sorgente) → §1–§9.**
> I §1–§9 sono aggiornati al 23/07/2026; il §10 porta il delta 24/07 → 03/08; il §11 la sessione del 06/08; il §12 lo sweep del 14/08; il §13 il file prodotti del 24/08; il §15 la scelta dell'Asset standard; il §16 le quattro riunioni recuperate il 24/08. **Il §14 è la decisione diretta di Aurel Mrruku sulle tranche e supera ogni formulazione precedente che le faceva nascere dalle righe d'Ordine o dai codici `BLO-`.** **Il §17, il §19, il §22 e il §25 sono verifiche dello stato del build sull'org UAT, del 25/08, 26/08, 31/08 e 02/09: dove contraddicono una sezione precedente su ciò che _esiste_, vince la più recente; dove una sezione precedente registra ciò che è stato _concordato_, quella sezione resta valida. Il §19 corregge integralmente una constatazione del §17; il §25 ritira l'affermazione del §19 secondo cui l'org non aveva template email — lo strumento non era in grado di vederli.** Il §18 è la call tecnica Anticipay del 25/08; il §20 la review Mexal del 26/08; il §21 l'integrazione WooCommerce del 27/08; il §23 e il §24 il contratto API Anticipay e la call di follow-up del 01/09.
> File collegati: recap per riunione in `results/`, tracker in `open-items.md`.

---

## 1. Cornice di progetto

| Fatto                                       | Valore                                                                                                                                                                                | Fonte               |
| ------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------- |
| Scadenza contratto Zoho CRM                 | **31 ottobre 2026** (corregge il "fine settembre" del kickoff)                                                                                                                        | 08/06               |
| Finestra dual-run                           | Zoho + Salesforce in parallelo fino a fine ottobre; fatturazione vendite da palco resta su Zoho fino al Food Marketing; dati biglietti in doppio inserimento                          | 08/06               |
| Calendario vincolante                       | Tour (eventi gratuiti): 7–19/09 · Food Marketing Festival: 29/09 · Evento kickoff grande (1.500+): 29/10                                                                              | 27/05, 08/06        |
| Import dati in Salesforce                   | ~1 settembre, dopo dedup (~6.000 lead/account vs ~7.500 clienti paganti)                                                                                                              | 30/06, 07/07        |
| Fase 1 (entro fine settembre, utilizzabile) | Tutto ciò che fa oggi lo Zoho CRM: flusso lead/opty, preventivi/ordini, **magazzino biglietti + presenze** (priorità massima), integrazioni Mexal + WooCommerce                       | 27/05, 08/06        |
| Fase 2 (entro fine ottobre)                 | Vendita prodotti via WooCommerce/GLS (libri, videocorsi), flussi Pienissimo Pro, analytics Data Cloud, automazioni restanti                                                           | 30/06               |
| Metodo                                      | ROMI scrive il **blueprint** → Pienissimo approva → configurazione (in parte in parallelo) → review con i key user in ambiente di test                                                | 27/05               |
| Principi guida                              | Niente "accrocchi" — ridisegnare, non replicare; partire semplici/manuali, automatizzare ciò che si ripete; ogni decisione di design deve servire le **statistiche/dashboard finali** | 27/05, 16/06, 07/07 |
| Lingua org                                  | Italiano (tradurre le label custom nel translation workbench)                                                                                                                         | 03/06               |

## 2. Data model

| Oggetto                                  | Uso / decisioni                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      | Stato                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| ---------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Lead**                                 | Solo azioni self-service senza intento d'acquisto (iscrizione diretta, video gratuito, quiz). Le fasi iniziali del workflow (in lavorazione, non risponde, primo contatto, da ricontattare, prequalifica) vivono qui. Proprietà del marketing.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       | ✅ 30/06                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| **Account / Contatto**                   | Account = azienda (aggiungere campo **nome locale** accanto alla ragione sociale). L'opportunità richiede sempre un account: i form creano account+contatto "primordiali" in automatico; il commerciale completa l'anagrafica dopo la prima chiamata. Chiavi dedup: **email O telefono** (form), **email + P.IVA** (ordini WooCommerce). L'origine lead-convertito resta visibile.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   | ✅ 16/06                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| **Opportunità**                          | Creata direttamente (saltando il Lead) per: form con richiesta esplicita di contatto (landing sponsorizzate, QR in diretta) e tutte le richieste dei clienti esistenti. 4 fasi (negoziazione con sottolivelli → rinviata / persa / vinta). Chiuso-vinto guidato dal **pagamento** (manuale amministrazione). Motivazione di perdita obbligatoria, **due set di picklist** (fase opportunità vs fase preventivo; "errato" non deve esistere sui preventivi). SLA: nuova → in lavorazione entro **48 ore lavorative**, altrimenti escalation al responsabile. Passaggi di stato manuali al go-live. I **Record Type** separano flusso commerciale vs e-commerce per statistiche pulite (deciso via drill-me 13/07; i form dinamici potranno integrare la visibilità dei campi dentro ogni tipo). Tracciare origine **cliente esistente vs new business** per opportunità (attribuzione spesa ads di Daniela).                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          | ✅ 16/06–30/06                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| **Preventivo (Quote)**                   | Sempre sotto un'opportunità; più preventivi per opportunità; validità 5 giorni → sottostato "scaduto" è routine; nuovo tentativo = **clonazione** del preventivo scaduto (mantiene lo storico). Gli stati seguono l'opportunità. Preventivo = "condizioni generali + riepilogo economico" in un unico PDF. Terminologia: l'"ordine" pre-accettazione di Zoho = **Quote** in Salesforce.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              | ✅ 30/06                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| **Ordine**                               | UN solo oggetto ordine; **una riga per rata** con data scadenza (elimina il pattern ordini figli/"blocchi" di Zoho). Max **un bundle per ordine**, mai bundle + prodotto sfuso (due ordini). Immodificabile dopo la fatturazione (set ristretto di permessi admin per correzioni). Serve campo **tipologia ordine** (palco / tutor / libro / videocorso / attivazione PP / rinnovo PP…) che guida i processi amministrativi. Ordini/prodotti da Mexal in **sola lettura** su Salesforce.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             | ✅ 30/06–07/07                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| **Bundle (custom)**                      | Record contenitore custom (NON Revenue Cloud/CPQ — non licenziato, sovradimensionato). Prezzo fisso definito in configurazione (solo sconto manuale extra); i componenti portano **prezzi spalmati/scontati** così la statistica per prodotto sopravvive (criterio di accettazione). Configurato per evento (3–5 a evento), identico per tutti, mai modificato dopo la vendita, mai riusato (attiva/disattiva). Codici BLO e righe omaggio a 0 € morti: codici reali scontati al 100%; i BLO non migrano. UI: bundle come una riga ordine, espandibile sui componenti. **Modello dati (16/07): oggetto ponte `BundleComponent__c` — il prezzo spalmato vive sul _collegamento_ bundle↔prodotto, non sul prodotto**, quindi lo stesso prodotto sta in più bundle con uno spalmato diverso in ciascuno (`Spread_Total__c` / `Spread_Variance__c` sul bundle devono riconciliare col prezzo fisso). Il precedente self-lookup `Parent__c` è ritirato: consentiva un solo bundle per prodotto, nessuno spalmato per bundle, e calcolava il prezzo _dal basso_ sommando i componenti. **Prezzo (23/07): consegnate sia un prezzo bundle fisso _sia_ un'opzione auto-calcolo dai componenti; il business sceglie per bundle (fisso → rate impostate a mano).** **Classificazione (23/07): tre campi — `Anno solare` (master) → `Evento` (picklist dipendente) + `Tipologia bundle` (indipendente). Seed eventi = 7 eventi canonici (Tour, Food Marketing Festival, Pienissimo Live, Academy, Sold Out, O.D.B. Live, Camerieri Venditori, Mastery). Valori ricreati puliti, NON migrati dalle colonne legacy LIVELLO_3/4.** | 🟢 16/07 — costruita e verde in UAT (`proposals/2026-07-16-bundle-spread-demo.md`), junction accettata internamente; file sorgente `anar_PIE_ricla.xlsx` decodificato e meccanismo bundle confermato con Fabrizio il 23/07; 🟡 resta da **mostrarla a Pienissimo** + stima effort di Andrea (#13, #46). La questione Revenue Cloud si riapre solo se la demo delude. 🟡 18/08 — la lista eventi e i codici bundle (#46, #48) risultano **consegnati il 07/08 come `Prodotti e Bundle.xlsx`**, emerso quando Elena ha inoltrato il thread il 18/08; **il file non è ancora stato aperto**, quindi i dati seed delle picklist non sono ancora configurabili |
| **Anagrafica prodotto / articolo**       | Importata da Mexal (`anar_PIE_ricla.xlsx` = l'estratto). Struttura legacy decodificata il 23/07: `_ARTIP` **A** = prodotto ordinario · **Z** = rata/blocco (codici `BLO-`, portano il prezzo rata) · **C** = bundle (codici `PACK-`). Tutto l'apparato C/Z/BLO/PACK **NON migra** — esisteva solo per costruire i bundle-di-rate su Mexal. I 7 livelli `LIVELLO_` sono legacy (solo L0 + L6 mantenuti; L3 ≈ evento, L4 ≈ tipo pacchetto, ma le picklist si ricostruiscono pulite, non migrate). Due flag gestiti da admin aggiunti in import: **`Genera biglietto` (sì/no)** — il set di codici che generano biglietto, attivabile senza dev; **`Solo bundle` (sì/no)** — codici solo-bundle che i tutor non possono vendere diretti (nessuna provvigione agente sui bundle). I codici articolo sono **unici e stabili** (non cambiano).                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             | ✅ 23/07                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| **Asset standard — movimento biglietto** | Riproduce il "magazzino biglietti" di Zoho: unisce ordine + contatti; gli stati tracciano il ciclo di vita (§3.4). **Decisione 24/08/2026: oggetto standard Salesforce Asset, un record Asset per biglietto.** L'istruzione diretta non indica chi ha preso la decisione. In UAT è ancora presente il custom `Biglietto__c`; campi, relazioni e automazioni devono essere mappati e poi migrati, riscritti o dismessi.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               | ✅ Scelta oggetto chiusa 24/08 · ⚠ migrazione ad Asset non costruita e non stimata                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| **Campagna = evento**                    | Una campagna per edizione evento; membri campagna = partecipanti con stato check-in (partecipato / no-show) → alimenta analisi no-show e composizione sala. Codici prodotto trasversali agli anni; l'anno si gestisce con date campagna + campo anno di competenza sui movimenti.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    | ✅ 08/06                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| **Contratto (Performance Plus)**         | Oggetto Contract standard + logica custom: contratti-come-database (date inizio/fine/rinnovo, importo, preventivo/fatture/incassi collegati), pannello rinnovi, fatturato-vs-incassato per contratto, flag blocco servizio su scaduto grave. Annuale, fatturato in N tranche (12× mensili = stesso codice prodotto; trimestrale = codice diverso). Contratto inviato manualmente (bottone) alla conferma d'intenzione del cliente. ~100/anno in crescita. Elena proporrà nome/tipo distinto per gli ordini rinnovabili (non "bundle").                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               | ✅ 08/06–07/07 (sessione di analisi dedicata ancora da tenere)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| **Fattura (Invoice)**                    | Creata in Salesforce come guscio di riferimento alla chiusura dell'ordine → Mexal fattura → restituisce numero/stato in campi dedicati ricercabili. Stesso pattern per ogni origine ordine.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          | ✅ 16/06                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| **Nota di credito**                      | ~30/anno, alcune consistenti. Verificare oggetto standard in licenza, altrimenti custom.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             | 🔴 30/06 — verifica licenza pendente (Andrea)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |

## 3. Flussi core da costruire

### 3.1 Ingresso Lead/Opportunità (routing dei form)

- Routing deciso dalla **fonte, non dal contenuto del form**: campi nascosti precompilati (fonte, categoria, sottocategoria, UTM). Fonte A → Lead; fonte B → Opportunità (+account/contatto automatici). I form cambiano ~ogni 15 giorni → processo ripetibile di mappatura campi; i campi nuovi devono preesistere; Pienissimo può autogestire le mappature; valutare form/landing Marketing Cloud. (16/06)
- L'interesse multi-selezione deve arrivare leggibile + reportizzabile sull'opportunità (multi-picklist o testo con `;` + report "contiene"; ogni valore conteggiabile singolarmente). (16/06)
- ⚠ Il flusso riscritto da Elena in ottica Salesforce (stati, azioni) è 🔴 **ancora non rivisto** — rimandato il 07/07; la direzione NON l'ha pre-accettato.

### 3.2 Flusso vendita (tutor)

- Preventivo inviato → stati come da §2; "da ricontattare" = task/alert (parcheggio 48h). SLA nuova opportunità 48h. Dashboard attività quotidiane del tutor + dashboard trasversale del responsabile (componenti standard individuati). Canale di notifica (campanella vs email) 🔴 da decidere da Pienissimo. (16/06, 30/06)
- Tutor su listino fisso, niente sconti discrezionali non autorizzati; le scadenze rate devono garantire che il cliente sia sempre saldato **prima** di partecipare. (30/06)

### 3.3 Flusso parallelo e-commerce (build in fase 2, design ora)

- Libro: ordine WooCommerce arriva chiuso → conferma consegna GLS (integrazione da zero) → **+15 giorni** → job notturno crea opportunità non commerciale. Videocorso: API completamento Teachable → opportunità immediata → SLA task **48 ore lavorative**. Scelta l'opportunità invece del solo task (reporting di funnel). (16/06) Architettura: **Record Type** (deciso via drill-me 13/07).

### 3.4 Ciclo di vita del biglietto — LA priorità (fase 1)

Tre stadi (riconcilia tutte le riunioni — esplicitarlo così nel blueprint):

1. **ORDINE** inserito → movimento _caricato_ (parcheggiato, non utilizzabile);
2. **PAGAMENTO** integrale della fattura collegata → movimento _disponibile_ (oggi: procedura notturna Mexal→Zoho; replicare via integrazione Mexal; verifica manuale fino ad allora — dolorosa a volumi Food Marketing, 100–150 fatture/giorno);
3. **FIRMA** dei documenti (privacy, non concorrenza, consenso foto/video) via DocuSign → **si genera il QR code (biglietto utilizzabile)**;
4. **CHECK-IN**: scansione QR (app interna su telefono oggi) → movimento di scarico → somma algebrica per cliente = 0; i biglietti non usati restano visibili (dato no-show).

- **Il set che genera i biglietti = un flag a livello prodotto `Genera biglietto`** (23/07), attivabile da admin, non una lettera letta dal codice; gli stessi quattro+ codici articolo generano un biglietto a prescindere che siano venduti in un bundle, da un tutor o sul sito. I codici sono unici e stabili. ⚠ L'**"anno accademico" (mag→set)** usato qui per la generazione biglietti è un **campo diverso** dall'**"anno solare"** del bundle — tenerli separati (23/07).
- Partecipanti ≠ contatti dell'account: mail post-pagamento al referente → compila la **lista partecipanti** → contatti auto-creati → firma per partecipante → QR. Funnel di reminder (60/30/15/1 giorni); **bottone fallback il giorno dell'evento** (mail istantanea / verifica identità → QR all'ingresso); acquisti last-minute accettati fino al giorno prima. (08/06)
- Pagamenti: carta = auto-completato; bonifico = conferma manuale amministrazione (resta manuale al go-live). (30/06)

### 3.5 Documenti e firme

- **DocuSign** (pacchetto AppExchange; mail utenti Salesforce = mail utenti DocuSign; UN solo utente mittente = casella padrona del funnel; invii asincroni N giorni prima dell'evento). Acquisto in trattativa (Sabatino). (07/07)
- 4+ template: ordine/contratto (con condizioni generali — inviato solo per pacchetti grossi ≥ ~10k€; mai per piccoli ordini), accettazione T&C partecipazione evento, **modulo RID** (~50% degli incassi; template dinamico, campi bancari compilati dal cliente, richiede codice cliente Mexal → flusso prospect→customer), stampa preventivo. Revisione riga per riga con ROMI; i documenti attuali non sono normalizzati. (07/07)
- Generazione PDF: front-end (bottone) pienamente stilizzabile; server-side limitata → pattern: genera il PDF su azione utente/flag di stato, invia il PDF archiviato via DocuSign in seguito. (07/07)
- Storage: l'org ha **35,2 GB**; prevedere batch di pulizia (es. 30 giorni post-evento previo backup cloud del cliente) o link SharePoint/Drive. (08/06, 07/07)
- 🔴 Doppia firma preventivo+contratto vs sequenziale — decisione interna Pienissimo pendente. Serve percorso fallback con firma manuale. (30/06)

### 3.6 Contratti Performance Plus → §2 Contract. Report mensile "cosa fatturare", esportabile + schedulabile via mail; proiezione fatturato a fine anno per la direzione (obiettivo 4–5 M€). (27/05, 07/07)

## 4. Mappa integrazioni

| #   | Integrazione                                        | Direzione / note                                                                                                                                                                                                                                                                                                                                                                                         | Stato                      |
| --- | --------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------- |
| 1   | **Mexal (Passepartout)**                            | **REST API** (ribaltata da CSV/FTP il 07/07). Inbound: clienti, agenti, condizioni di pagamento, destinazioni, fatture, ordini, prodotti, scoperto. Outbound: ordini (+ creazione account per i prospect, insieme all'ordine). API agenti mancante → copia manuale del codice a ogni assunzione. Contatto: Mirko (Creosoft) — Fabrizio lo mette in contatto con ROMI. Da progettare la sync in dual-run. | 🟡 in analisi              |
| 2   | **WooCommerce ×2** (eventi/palco + libri/marketing) | API (non plugin). Verificare se bastano le API standard Salesforce; chiavi CK/CS da Sabatino; dedup email+P.IVA; promo 2×1 = qtà 2 @50%.                                                                                                                                                                                                                                                                 | 🟡                         |
| 3   | **DocuSign**                                        | AppExchange; tracking stato envelope; tre tipologie di documenti firmati + template preventivo.                                                                                                                                                                                                                                                                                                          | 🟡 in attesa dell'acquisto |
| 4   | **Anticipay (ex CreditSafe)**                       | Lookup P.IVA che auto-compila anagrafica + legale rappresentante; deve scattare per TUTTI i nuovi account (non solo all'ordine); alert su P.IVA invalida; probabilmente solo P.IVA italiane (verificare skip estero). Decisione tempi (con Mexal per Pienissimo vs fase 2 per ROMI) 🔴 pendente.                                                                                                         | 🔴                         |
| 5   | **GLS**                                             | Eventi di conferma consegna (trigger flusso libro). Da zero.                                                                                                                                                                                                                                                                                                                                             | fase 2                     |
| 6   | **Teachable**                                       | API completamento corso (confermata facile).                                                                                                                                                                                                                                                                                                                                                             | fase 2                     |
| 7   | **Pienissimo Software SRL (Zoho)**                  | Ordini con prodotto P-Pro passano automaticamente alla software company (entità separata, mantiene Zoho). Discriminante = prodotto.                                                                                                                                                                                                                                                                      | 🟡 design                  |
| 8   | **Gmail/Outlook**                                   | Connettori nativi, sync email + calendario — urgente (agende cartacee).                                                                                                                                                                                                                                                                                                                                  | ✅ deciso, da configurare  |
| 9   | **3CX + AI interna**                                | Registrazione chiamate → CRM → insight di coaching. Stato del setup commerciale 3CX MAI riferito (aperto dal kickoff).                                                                                                                                                                                                                                                                                   | 🔴 fermo                   |
| 10  | **Meta/Google Ads**                                 | Costo di acquisizione + campagna di origine sul contatto (alimenta il pannello RFM).                                                                                                                                                                                                                                                                                                                     | dopo                       |

## 5. Requisiti analytics e reporting

- **Catena di tracciabilità in entrambe le direzioni**: fattura ↔ ordine ↔ preventivo ↔ opportunità ↔ campagna ↔ lead — ID a cascata; criterio di accettazione del blueprint. (16/06)
- **Matrice RFM ricostruita in Salesforce**: base data-ordine (non data-fattura — la fatturazione annuale falsifica), segmentata per linea di prodotto (corsi / piattaforma / PP), sulla pagina account con costo di acquisizione + campagna di origine. Sostituisce l'SQL-su-Mexal di Fabrizio. Workshop dedicato. (16/06)
- **Analisi no-show**: tag fonte di acquisto per cliente + propensione no-show per fonte + dashboard composizione sala (alimentate dagli stati check-in campagna). (27/05, 08/06)
- Dashboard: filtrate per commerciale di default; vista trasversale del responsabile; conteggi opportunità per fonte incl. split cliente esistente vs new business. (03/06)
- Report esportabili in Excel + schedulabili via mail. (27/05)

## 6. Sicurezza e visibilità

- ~6 commerciali; modello di sharing speculare all'organigramma (nella survey). Default **restringi-poi-amplia**, mai il contrario. Riassegnazione (clienti dormienti) manuale ora; regole automatiche quando Pienissimo definirà le soglie di dormienza (🔴 aperto dal kickoff). Blocco modifica ordini post-fatturazione con 1–2 eccezioni admin. (03/06, 30/06)

## 7. Decisioni di configurazione trasversali

- Traduzioni italiane per label/stati/guide custom. (03/06)
- Riferimento terminologico = Salesforce: lead → opportunità → preventivo → ordine. (30/06)
- Partire semplici: transizioni di stato manuali, automatizzare dopo. (16/06)
- Regole duplicati: form email O telefono; WooCommerce email + P.IVA; matching lead↔account per P.IVA/società in conversione. (16/06, 02/07)

## 8. Già risolto (non rimettere in discussione)

Morris AI scartata (AI interna) · fase demo conclusa · scadenza Zoho = 31/10 · NBA/Einstein parcheggiato (non licenziato) · QR vincolato alla firma approvato dalla direzione · fatturazione multi-tranche Mexal confermata possibile (scadenze per riga) · file-vs-API ribaltato su API · codici BLO pensionati · WooCommerce = API · un-bundle-per-ordine confermato · la "contraddizione" sul trigger biglietti era terminologia (ciclo a 3 stadi) · separazione flussi opportunità = **Record Type** (drill-me 13/07) · modello dati bundle = **oggetto ponte, spalmato sul collegamento**, quindi un prodotto può stare in più bundle (16/07) — self-lookup `Parent__c` ritirato · anagrafica prodotto `anar_PIE_ricla.xlsx` decodificata (23/07): `_ARTIP` A=prodotto / Z=rata BLO / C=bundle PACK; l'apparato C/Z/BLO/PACK **non migra**; classificazione bundle = anno-solare→evento (dipendente) + tipologia-bundle, ricostruita pulita; **"anno solare" (bundle) ≠ "anno accademico" (biglietti)**.

## 9. 🔴 Decisioni/input bloccanti — da chiudere prima del congelamento del blueprint

1. ~~**Review del flusso lead/opty** con Daniela (riscrittura di Elena + segmento registrato) — l'ultimo grande design non approvato; rimandato DI NUOVO oltre il 9/7, nessuna novità al 13/07 → sollecitare con forza. (#19)~~ → ✅ **CONFERMATO nella business review del 31/07**; restano solo voci di configurazione (#59). Vedi §10.
2. **Demo del bundle custom** — ✅ costruita e verde in UAT il 16/07 sull'oggetto ponte `BundleComponent__c`; il criterio di accettazione (statistica per prodotto via prezzi spalmati) è soddisfatto, incluso uno stesso prodotto in due bundle con spalmati diversi. Ora serve **mostrarla a Pienissimo** + la stima effort di Andrea. (#13)
3. **Risposte marketing su form + sottodominio** da Matteo — blocca l'intero filone marketing dal 23/06. (#14)
4. **Chiusura acquisto DocuSign**. (#16)
5. **Tempi Anticipay** (con integrazione Mexal vs fase 2) + documentazione + regola P.IVA estere. (#21)
6. **Decisione flusso firma preventivo+contratto** (interna Pienissimo). (#27)
7. **Lista key user** (mai consegnata dal kickoff) e **stato 3CX** (mai riferito). (#1, #3)
8. **Avvio workbook data model**: struttura ROMI + liste campi Pienissimo da Zoho. (#24) ⚠ **Deve riportare la regola del 24/08 per cui `_ARCOD` è una stringa opaca** — codici che differiscono per uno zero iniziale sono prodotti diversi, e `Product2.Code__c` è un external id unico. Vedi §13.6.
   8b. 🔴 **`Product2.Evento__c` è sbagliata rispetto all'elenco eventi del cliente** — manca il valore `Happy Team` benché Happy Team abbia un prezzo e stia nel bundle Academy in qtà 2; `Camerieri` troncato; un `ND` inventato; e la matrice di dipendenza `Anno_Solare__c` **non ha alcuna fonte lato cliente**. Correggere prima di qualsiasi import prodotti. (#46, §13.2)
9. Input Pienissimo ancora dovuti: template preventivi + mail reali (#26), Google Sheet dei form con campi fonte nascosti (#33), chiavi CK/CS WooCommerce (#22), regole di dormienza (#8), scelta canale di notifica.
10. Conferma di fattibilità: scope raggiungibile entro 29/09 / 31/10 con l'attuale lista integrazioni — ROMI ripianifica e si impegna. (#4)

---

## 10. Aggiornamento 03/08/2026 — sweep multi-sorgente

Compilato il 03/08/2026 da Slack `#tproj-pienissimo`, Gmail, Google Drive e Fathom, su cinque sessioni mai confluite nei §1–§9: **14/07** integrazione Mexal, **16/07** demo bundle + flusso ordini, **22/07** bundle + flusso biglietti, **29/07** follow-up temi aperti (nessuna minuta circolata), **31/07** business review. Dove questa sezione contraddice i §1–§9, prevale questa.

### 10.1 Tempistiche — la data è il 6 ottobre 2026

Elena pubblica la stessa riga in ogni status settimanale dal 26/06: **go-live 6 ottobre 2026, focus sulle integrazioni WooCommerce + Mexal**, con le integrazioni minori rimandate a una seconda fase. L'impostazione "Fase 1 entro fine settembre / Fase 2 entro fine ottobre" del §1 è precedente ed è superata — ma il contratto Zoho scade comunque il **31 ottobre**, quindi la finestra di dual-run si riduce a ~3 settimane. Nota di Elena del 31/07: la data di go-live "sta iniziando a non essere più una notizia positiva dati i tempi". È fissata una **sessione di chiusura giovedì 6 agosto, 15:00–17:00** ("Chiusura ultimi punti aperti") e diverse risposte lato cliente sono attese _prima_.

### 10.2 Cosa è stato approvato

- **Flusso Lead/Opportunity — CONFERMATO (31/07).** Il marketing converte i lead in opportunità; i tutor gestiscono il richiamo con task automatici e stati dedicati; i contatti qualificati bypassano le fasi iniziali per accelerare la trattativa. Il più grande design non approvato del progetto è chiuso. Resta la configurazione: stato "qualificato da ricontattare", pulsante di creazione manuale preventivo, scadenza come campo obbligatorio all'invio, alert automatici al secondo giorno e alla scadenza. Marco Montesi deve i tempi di validità preimpostati per categoria prodotto e linea di business.
- **Bundle — APPROVATO (22–24/07).** Confermato con Daniela: **si fattura il singolo prodotto elementare**, mai una cifra generica. Il nome del bundle diventa la descrizione portata su Mexal; codice e date di scadenza restano a livello di riga. **Solo l'amministrazione** crea i bundle su Salesforce; i singoli prodotti continuano a essere configurati su Mexal. Residui: la stima di effort di Andrea e un buco reale — nulla impedisce all'amministrazione di associare un articolo non coerente con la categoria del bundle (oggi solo attenzione manuale).

### 10.3 Flusso ordini — tranche, contratti, report

- **Le "rate" diventano "tranche"** (oggetto custom), costruite automaticamente dalle **date di scadenza delle righe d'ordine**: righe con la stessa scadenza formano una tranche. L'ordine intero passa da Salesforce a Mexal con il riferimento tranche **a livello di riga**, non come oggetto. Mexal aggiorna lo stato pagamento per riga; Salesforce aggrega verso la tranche — Mexal non scrive mai direttamente la tranche. In fatturazione: **n fatture Mexal → n fatture Salesforce**.
- **La generazione automatica del contratto è legata al codice prodotto, non allo stato ordine** — il contratto Performance Plus e le sue logiche (date, stato, totale, fatturato, incassato, insoluto) partono dal codice prodotto, esattamente come per i bundle. Ipotizzati i "tipi ordine" (bundle da palco, palco/performance) per separare flussi e reportistica.
- **Due report permanenti**: _insoluti_ settimanale (es. lunedì) a commerciale + amministrazione — fatture emesse e non pagate con scadenza antecedente alla data di controllo, produzione rimossa dalla distribuzione; e _tranche in scadenza_ all'amministrazione prima di fine mese per il mese successivo. Entrambi sempre disponibili e aggiornati, senza lancio manuale.
- **Performance Plus** può nascere da bundle da palco o da inserimento diretto dei tutor. La valutazione di Marco — un'opinione, non una certezza — è che la vendita da palco di questo servizio sia ormai remota, vista l'evoluzione verso un modello consulenziale via tutor; va comunque tenuta come casistica.

### 10.4 Biglietti e firma — dietrofront su DocuSign

- **Regola di generazione asset**: ogni ordine con un prodotto di tipo "evento" crea automaticamente una **Campagna** (se assente) e **un Asset per ciascun codice articolo evento** — anche con bundle multi-evento e ordini inseriti dai tutor. Terminologia fissata: l'**Asset è il record**, il **QR è un valore contenuto** in esso.
- 🔴 **DocuSign non è più certo.** Il 22/07 Sabatino ha comunicato che, in base all'ultimo confronto con Daniela, DocuSign potrebbe essere abbandonato mantenendo temporaneamente il **processo cartaceo** (PDF stampato, firmato e consegnato al check-in). Aurel ha proposto una via intermedia: firma cartacea con caricamento del documento scansionato/fotografato su una **pagina Community personalizzata**, evitando i ~**€1,80–2 a documento** ma con verifica umana necessaria (nessun controllo automatico possibile su un PDF). Scartata la firma "in link" — nessuna valenza legale/GDPR. Andrea ha segnalato che alcuni clienti non gestiranno scarico → firma → ricarico e si presenteranno comunque col cartaceo. **31/07: Sabatino deve trovare una soluzione valida entro il 6 agosto, altrimenti prepara la procedura per i contratti stampati.** L'ultimatum di Elena resta: senza news si tiene il cartaceo as-is. ⚠ L'incertezza tocca **solo la fase di raccolta firma** — creazione ordine/asset a monte e scansione QR/controllo accessi a valle non cambiano.
- **Note di credito** (il tema del §2 passa da questione di licenze a flusso vero): l'amministrazione crea la nota di credito e la collega **sia all'ordine sia alla riga d'ordine** — il livello riga serve per gli storni parziali su bundle multi-evento. Le note di credito su prodotti "evento" portano **automaticamente l'Asset corrispondente ad Annullato**. Il rimborso di norma è un credito per acquisti futuri anziché un bonifico, gestito dal tutor. Non urgente, ma Elena deve un diagramma dedicato.

### 10.5 Nuovo workstream — link di checkout WooCommerce (Salesforce → WooCommerce)

Deciso il 31/07, specificato in `Integrazione_Salesforce_WooCommerce.docx` (Sabatino, 31/07). Il tutor genera dall'Opportunity un URL di checkout che porta con sé l'id dell'Opportunity, così l'ordine risultante è attribuibile:

1. **Salesforce** costruisce `https://<sito>/checkout/?add-to-cart=<woo_product_id>&sf_opp_id=<opportunity_id>` (opzionali `quantity[...]` e `coupon`).
2. **WooCommerce** — un must-use plugin (`wp-content/mu-plugins/sf-opportunity-tracker.php`, deliberatamente _non_ `functions.php`) cattura `sf_opp_id` in sessione + cookie a 30 giorni, lo scrive alla creazione dell'ordine come meta `_sf_opportunity_id` e lo riespone via REST API come `sf_opportunity_id`.
3. **Salesforce** legge `/wp-json/wc/v3/orders/{id}` con Consumer Key/Secret, trova l'Opportunity per id, scrive `WooCommerce_Order_Id__c`, Amount e CloseDate e porta lo stage a **Closed Won**, innescando le automazioni a valle.

Da costruire — Salesforce: `WooCommerce_Product_Id__c` su Prodotto (popolato per ogni articolo a catalogo), `WooCommerce_Order_Id__c` su Opportunity, il pulsante generatore link con tendine prodotto/quantità (Aurel), la logica di lettura ordini. Pienissimo: installare il mu-plugin, generare le credenziali REST e consegnarle, creare il template email precompilato (Sabatino), fissare la call tecnica congiunta (Sabatino), poi test end-to-end (Aurel + Sabatino).

🔴 **Tre decisioni aperte**: job pull vs webhook WooCommerce (in produzione è consigliato il webhook); fonte di verità dei prezzi — listino WooCommerce vs prezzi negoziati Salesforce tramite **coupon dinamici monouso**; id in chiaro (indovinabile) o token firmato.

### 10.6 Mexal — sbloccato

**Le credenziali WEBAPI sono state consegnate il 15/07** da Mirko Merendi (Kreosoft): `https://services.passepartout.cloud/`, dominio **PIENISSIMO**, azienda **PIE**, utente dedicato, password inviata separatamente a Fabrizio. Meccanica concordata il 14/07:

| Tema              | Decisione                                                                                                                    |
| ----------------- | ---------------------------------------------------------------------------------------------------------------------------- |
| Fonte di verità   | **Salesforce** per le nuove creazioni; **Mexal** per le modifiche amministrative; riallineamenti periodici                   |
| Permessi          | Modifica dell'anagrafica cliente sincronizzata ristretta agli utenti admin — i commerciali non devono alterarla dopo la sync |
| Strategia di sync | **GET notturne** schedulate, solo delta, su "data ultima modifica"                                                           |
| Fatture           | ~**2.300 fatture nel 2025** → filtri temporali + paginazione, contro i limiti 6 MB sync / 12 MB async                        |
| Ordini            | Niente GET ripetute (l'id torna in creazione); invece un **pulsante "rinvio ordine"** per errori/modifiche                   |
| Prodotti          | Configurati su Mexal; **pulsante di importazione on-demand** (non solo notturna) per la disponibilità immediata alla vendita |
| Agenti            | Su Mexal sono **fornitori**, filtrati per mastro — codici che iniziano per **610** per l'azienda "P"                         |
| Ambiente di test  | **Non esiste** → va creata un'azienda di test per validare POST e ordini di prova senza toccare la contabilità reale         |
| Anagrafica        | Campo che referenzia codice/P.IVA precedente, così i **cambi di ragione sociale** non spezzano lo storico                    |

Sempre il 14/07: gli **ordini a zero euro** (biglietti gratuiti) restano nel CRM per attivare la generazione biglietti e **non** vanno a Mexal; la P.IVA è la chiave primaria del cliente e Anticipay oggi verifica solo in fase di importazione ordine, bloccando i trasferimenti Zoho→Mexal sui dati errati.

### 10.7 Analytics — percorso di ingestion Data 360

Risposta interna di Davide Bocchieri (29/06), non ancora progettata né mostrata al cliente: la catena as-is (CSV notturni Mexal → FTP su Work Drive Zoho → ETL Zoho Data Prep → data warehouse → Zoho Analytics) si traduce su Salesforce in **Mexal → Google Cloud Storage → ingestion Data 360 → trasformazione → report/dashboard standard su oggetti Data 360** — dati esterni utilizzabili per la reportistica senza caricarli tutti come record CRM. Le licenze sono coperte via MC Growth. Le capacità di trasformazione dentro Data 360 hanno però dei limiti: da testare prima di impegnarsi.

### 10.8 🔴 Contenzioso commerciale — perimetro fuori contratto

Elena segnala lo stesso punto rosso in tre status settimanali consecutivi: **GLS, Teachable e l'integrazione Salesforce↔Zoho** (ordini Pienissimo Pro della **Pienissimo Software Srl — società diversa dal cliente di questo progetto**) non sono stati discussi in prevendita, **non risultano a contratto** e andrebbero valutati e quotati come evolutiva separata, come concordato con Andrea G. Sabatino e Fabrizio non erano d'accordo, sostengono che di Zoho si fosse parlato, e hanno portato il tema a Daniela. ROMI deve una quotazione per lo sviluppo Salesforce↔Zoho se resta nel perimetro. **Non risolto al 03/08** — e contraddice direttamente la mappa integrazioni del §4, che elenca GLS e Teachable come normali deliverable di fase 2.

### 10.9 Altri fili aperti dallo sweep

- **Marketing parzialmente sbloccato**: sottodominio creato e informazioni consegnate; la titolarità lato ROMI passa a **Fabrizio Mastracci**. Resta l'attesa della review Pienissimo sull'Excel con **oltre 100 form**.
- **Data model workbook**: Sabatino si è impegnato il 22/07 a completarlo entro la settimana successiva — `Campi Oggetti, Flussi e Utenti Salesforce - Pienissimo.xlsx` nella cartella Drive `[Pienissimo] Fase Progettuale`. Pienissimo deve i campi Zoho per Account, Referente, Opportunity, Offerta, Ordine, Articoli.
- **Procedura accettazione ordine e contratti**: Marco Montesi + Elisa Migliano devono chiuderla con Daniela e comunicarla a Elena **entro giovedì 6 agosto**.
- **Pulsanti accetta/rifiuta nell'email del preventivo** che pilotano lo stato Preventivo/Opportunity: ROMI valuta fattibilità e rischio di modifica dati CRM da parte di clienti esterni.
- **Date evento**: "Camerieri Venditori" 3 novembre o rinvio ad aprile; **Pienissimo Live 24–26 novembre**, tempi di consegna biglietti (60 giorni as-is — si può posticipare?).
- **Il codice bundle viene comunicato a WooCommerce manualmente, a voce**, per scelta, così da mantenere flessibilità a ridosso degli eventi.

---

## 11. Aggiornamento 06/08/2026 — sessione di chiusura dei punti aperti

Compilato dalla sessione **06/08 "Chiusura ultimi punti aperti"** (2h30m, Google Meet + note Gemini), emersa il 07/08 dal canvas Slack `#tproj-pienissimo`. È la sessione che il §10.1 anticipava senza poterne riportare gli esiti. **Dove questa sezione contraddice i §1–§10, vince questa sezione.** È la riunione più densa di decisioni dal 22/07 e l'ultima sessione operativa sostanziale prima della pausa di agosto — tutti rientrano intorno al **24–26 agosto**.

⚠ Note sulla fonte: l'auto-summary di Gemini contiene almeno un errore netto (sostiene che gli asset restino _Disponibile_ fino all'utilizzo — Sabatino si è corretto 40 secondi dopo mantenendo _Assegnato_), e attribuisce in modo approssimativo gli interventi amministrativi e tecnici — l'autorità operativa è sempre **Elisa Migliano**, che gestisce lei stessa l'infopoint agli eventi e ha fatto le correzioni decisive su fatturazione e match. Da notare inoltre che **Fabrizio Mastracci, pur nell'invito, si è scollegato alle 00:01:30** senza contribuire. Questa sezione segue la trascrizione. **Date di rientro concordate in sessione:** Elisa 17/08 · Aurel 24/08 · Sabatino 25/08 (chiede di essere convocato dal 26) · Fabrizio Paganelli ~31/08 · Andrea Parmeggiani terza settimana di agosto. Finestra operativa: **26–29 agosto**. Dettaglio completo: [`results/2026-08-06-chiusura-punti-aperti.it.md`](results/2026-08-06-chiusura-punti-aperti.it.md).

### 11.1 Firma — DocuSign è risolto, separato in due

Il 🔴 "DocuSign potrebbe essere abbandonato" del §10.4 è **risolto**, separando la questione:

- ✅ **Preventivi / contratti → DocuSign C'È.** Flusso: mail con un **link, non bottoni** → landing page con preventivo + contratto + condizioni generali (**un unico PDF**) → il cliente clicca **Accetto / Rifiuto** → il rifiuto porta il preventivo in _Rifiutato_; l'accettazione invia i documenti **via DocuSign** → la firma porta il preventivo in _Accettato_ → **l'ordine si genera automaticamente**. Il preventivo parte mentre l'opportunità è _in trattativa_, ed **è da lì che partono i 5 giorni** di validità; scaduti, l'opportunità sta _in attesa accettazione_ e **la stessa landing page continua a funzionare** — il cliente può accettare settimane dopo e il flusso procede identico. La ragione per cui ROMI ha scartato i bottoni in mail proposti da Elisa: _"noi non abbiamo controllo su quello che mandiamo a livello di email, dobbiamo per forza rimanere sul CRM."_
- ✅ **Documentazione biglietti / partecipanti → DocuSign NON C'È.** Elena: _"la firma digitale c'è solo per i preventivi."_ I partecipanti firmano **su carta** al check-in. Il caso limite "mancata firma digitale" è stato eliminato dal disegno.

Questo **elimina anche l'idea dei pulsanti accetta/rifiuta in mail del §10.9** — la landing page la sostituisce, e con essa il rischio che clienti esterni modifichino direttamente dati CRM.

### 11.2 Modelli di stato ordine e opportunità

- ✅ **Stati ordine: Ordinato → Fatturato → Incassato.** Il vecchio **"Chiuso acquisito" è eliminato** (Fabrizio Paganelli: _"non serve più"_). 🟡 Un quarto stato **_Perso_**, legato alle note di credito, è stato ipotizzato e lasciato indeciso (_"Non lo so come funzionerà"_), ed Elena ha segnalato che l'insieme è scarno: _"mi sembrano troppo pochi"_.
- ✅ **L'Opportunity passa a Chiusa Vinta solo quando l'ordine raggiunge _Incassato_** — è il pagamento a chiudere l'opportunità, non la firma. Lega la regola "closed-won guidato dal pagamento" del §2 a uno stato esplicito.
- ✅ **Le opportunità Performance Plus vanno tipizzate dal tutor in creazione** — **attivazione** vs **rinnovo**, obbligatorio e manuale, perché la generazione del contratto ne dipende.
- ✅ **La data di inizio/fine servizio è dello Strategist, non del contratto.** Firma ≠ inizio servizio; i clienti vanno in coda giorni o settimane (Marco Montesi). Il responsabile di reparto inserisce la data reale all'avvio. ROMI svilupperà un **banner/alert o email quando il campo data inizio è vuoto**.

### 11.3 Biglietti e asset — la macchina a stati, definitiva al 06/08 e rimessa in discussione il 19/08 e il 20/08

| Stato                           | Trigger                                                                    |
| ------------------------------- | -------------------------------------------------------------------------- |
| **Ordinato**                    | Scende l'ordine (es. da WooCommerce); l'asset viene creato                 |
| **Disponibile**                 | La fattura che contiene quella riga d'ordine è **incassata integralmente** |
| **Assegnato**                   | Documentazione + QR code inviati via mail al partecipante nominativo       |
| **Utilizzato / Non utilizzato** | Impostati dalla scansione del QR all'evento                                |

_Assegnato_ stava per essere eliminato quando la firma è uscita dal flusso biglietti; **Sabatino l'ha mantenuto per il reporting** — _"ci fa statistica per capire quante persone hanno il biglietto nelle mani."_

🔴 **Rimessa in discussione il 19/08, e non ancora risolta.** Un nuovo `Flusso Biglietti.drawio` è comparso in `[Pienissimo] Fase Progettuale` il 19 agosto, disegnato da Elena Spini. La riga degli stati vi compare con **sette caselle**, con l'aggiunta di **`Rinuncia`** — annotata _"avviene nella comunicazione dei partecipanti o accetta o rinuncia"_ — come casella distinta da `Annullato`. Fino al 19/08 il record trattava _rinuncia_ come formulazione discorsiva per `Annullato`; in questo disegno sono due momenti diversi, il primo quando il referente rinuncia alla richiesta della lista partecipanti, il secondo su cambio nome o nota di credito. Lo stesso file aggiunge un pulsante **`Aggiornamento Incasso`**, riservato all'amministrazione, che riporta l'asset **all'indietro**, da `Disponibile` a `Ordinato`, quando un importo è stato imputato alla tranche sbagliata (#91). ⚠ **Nessun verbale, registrazione o messaggio accompagna il disegno**, quindi nulla di tutto ciò è concordato — la picklist non va riconfigurata su questa base. Vedi #74, #91.

🔴 **Aggravato il 20/08 — ora è nel master.** `Flows & Objects.drawio` è stato ri-decodificato il 20 agosto nella versione delle 15:36 UTC e la riga a sette caselle **è stata recepita nel file master**, nella pagina `Flusso Biglietti`, con la stessa annotazione — così come il pulsante `Aggiornamento Incasso`. `Rinuncia` non è quindi più confinato a un disegno separato: è ora nel **file su cui il registro dei requisiti viene validato**. Il registro non è stato comunque modificato, perché la modifica resta non verbalizzata, ma lo scarto fra il registro e la sua stessa fonte è ora reale. Lo stesso giorno, accanto al pulsante, è stata disegnata una **nuova domanda**: _"Scadenziario MEXAL - Check con Andrea. Capire se da fattura NON pagata (Scadenziario) è possibile aggiornare ASSET allo stato prima"_ — cioè se una fattura **non pagata** su Mexal possa pilotare automaticamente lo stesso ritorno indietro, il che ne farebbe un comportamento di integrazione e non un pulsante (#92). La sede c'è: la **review Mexal con il cliente di mer 26/08**. ⚠ Il meeting asset convocato da Elisa Migliano per il 20/08 non ha lasciato **registrazione, voce in canvas né messaggi**; se si sia tenuto non è a verbale. Vedi #74, #91, #92.

⚠ **La regola di disponibilità del §10 era ambigua; la formulazione concordata è "fattura pagata a livello di rata/tranche".** Elisa: _"quel biglietto è disponibile quando la fattura con la quale l'ho fatturato deve essere integralmente pagata, tutta pagata."_ Il pagamento parziale non libera **nulla**. Le righe d'ordine si raggruppano in tranche per **data di scadenza** (evento 1+2 → tranche 1 al 31 gen, evento 3+4 → tranche 2 al 28 feb, …); ogni tranche è fatturata separatamente, e quando _quella_ fattura è integralmente incassata _quei_ biglietti passano a Disponibile. ⚠ Punto critico: **la composizione delle tranche segue la gestione del pagamento del cliente, non gli eventi** — _"ci sono tot rate che vengono suddivise sulla base della gestione del cliente, non sulla base dell'evento"_ — quindi il biglietto di un evento può stare dietro voci non correlate nella stessa fattura.

**La fattura deve arrivare su Salesforce, e il match è sul numero di riga d'ordine — non sulla data, non sul prodotto.** Due chiavi candidate sono state testate e scartate in sessione, entrambe da Elisa:

- **Per data** — non funziona perché la data della tranche è la _data di presumibile incasso_ e Pienissimo fattura **in anticipo** (le tranche in scadenza il 31 gennaio si fatturano a inizio gennaio).
- **Per prodotto** — non funziona perché _"un tutor può mettere anche lo stesso codice due volte nello stesso ordine"_.

La fattura Mexal porta **cliente, numero documento, riferimento numero d'ordine, codice articolo e numero di riga d'ordine**; il match è sul **numero di riga d'ordine**, secondo il principio di Elisa: _"è bene lavorare su elementi che sono nascosti ai tutor."_ Aurel osservava che sarebbe bastato un segnale "righe pagate" senza la fattura; **Elena ha imposto il contrario** — la fattura serve per le logiche di reporting concordate.

Deciso inoltre:

- ✅ **Un prodotto evento creato su Mexal genera automaticamente la Campagna Salesforce corrispondente** con il sync notturno, così la presenza si indicizza sulla campagna alla scansione.
- ✅ **La tipologia biglietto diventa un menù a tendina nell'anagrafica prodotto** (Gold / Silver / Executive …). Posizione precisa: ogni tipologia **ha già un proprio codice prodotto** (Camerieri Venditori Silver ≠ Gold), ma un codice non è filtrabile in modo affidabile, quindi Elisa ha accettato di aggiungere il campo — _"mettiamo un campo in anagrafica, un menù a tendina tipo biglietto"_. Fabrizio Paganelli aggiunge inoltre un **flag evento** (distinto dai flag di eleggibilità bundle già esistenti).
- ✅ **Un bundle multi-evento crea automaticamente un asset per ogni evento.**
- ✅ **Raccolta dati partecipanti**: l'acquirente — sempre il titolare dell'azienda che ha pagato, e intestatario iniziale di **tutti** i biglietti — riceve una landing page con una riga per biglietto acquistato e inserisce **nome, cognome, email e telefono** di ogni partecipante → Salesforce collega il contatto all'asset, **crea il contatto se assente**, aggiunge il **Campaign Member**. Ogni partecipante riceve poi il proprio documento con QR e lo stampa. ⚠ Lo step "scegli l'evento" ipotizzato da ROMI è **eliminato** — Sabatino: _"No, non scelgono mai loro. Noi gli diciamo cosa devono fare."_
- ✅ **Due percorsi distinti per i casi limite — da non confondere.** _Cambio nominativo **prima** dell'evento_: un pulsante sull'account elenca gli asset di quell'account; annulla il vecchio nominativo, inserisce il nuovo, **si genera un nuovo QR** (il documento riporta nome partecipante ed evento sopra il codice) e la documentazione aggiornata viene inviata **all'indirizzo della nuova persona**. _Sostituzione o mancanza di documenti **al** check-in_: il personale verifica biglietto + ordine + pagamento all'infopoint, il partecipante **rifirma il modulo cartaceo**, il personale inserisce i dati a mano — **in questo percorso non si emette alcun QR**. Il caso più frequente non è la sostituzione ma chi non ha stampato o non ha ricevuto la mail; Elisa ha indicato una causa reale — clienti **disiscritti dalle mail marketing** smettevano di ricevere i biglietti, _"un cane che si mordeva la coda"_.
- 🔴 **Il percorso manuale ha un buco di tracciamento non chiuso**: un sostituto inserito a mano rischia di non risultare Campaign Member con il biglietto marcato utilizzato. Elena ha sollevato il punto; Elisa l'ha ridimensionato contando sulla competenza del personale. **La gestione del Campaign Member per gli inserimenti manuali resta non disegnata** — e l'analisi presenze/no-show è un obiettivo dichiarato del progetto.
- ✅ **Note di credito**: un pulsante a **livello di ordine** seleziona le righe d'ordine da stornare, parzialmente o totalmente; per i prodotti _evento_ annulla anche l'**asset** collegato.

### 11.4 Bundle — eliminata la duplicazione

✅ **I bundle si creano solo su Salesforce, solo dall'amministrazione**; i singoli prodotti continuano ad arrivare da Mexal. La duplicazione prevista per vendite da palco vs recall tutor sparisce — quella distinzione viaggia ora sulla **tipizzazione dell'Opportunity**. ✅ Confermato di nuovo: **nessuna validazione della composizione del singolo bundle**. Perimetro preciso — due flag a livello prodotto **esistono** (eleggibile da bundle, solo bundle, confermato da Aurel quando Fabrizio Paganelli ha contestato il punto); ciò che **non** esiste è la validazione che un prodotto eleggibile appartenga a _quello specifico_ bundle. Il gap del §10.2 è quindi **accettato, non risolto**.

### 11.5 WooCommerce — webhook, e una data di partenza

- ✅ **L'integrazione avviene via Webhook**, scelta contro il polling. Chiude la prima delle tre decisioni aperte del §10.5.
- ✅ **Pulsante "Crea link" sull'Opportunity per il tipo "Recall tutor"**, che genera il link di checkout contenente l'ID Opportunity Salesforce, inviato al cliente via mail.
- 📅 Scambio credenziali e test dei payload dal **26 agosto** (Sabatino + Aurel).
- 🔴 Le altre due decisioni del §10.5 — **fonte di verità dei prezzi** (listino WooCommerce vs prezzi negoziati Salesforce via coupon one-shot) e **id opportunità in chiaro vs token firmato** — **non** sono state discusse e restano aperte.

### 11.6 Qualità del dato e migrazione

- ✅ **La verifica P.IVA si sposta dentro Salesforce e gira alla generazione del PRIMO ordine di un account**, non alla creazione dell'account. L'as-is gira prima della fatturazione su Mexal: legge la P.IVA dell'ordine, controlla l'anagrafica Mexal e, se assente, chiama un **servizio di business information** che restituisce ragione sociale, indirizzo, PEC e legale rappresentante — un'anagrafica _"corretta al 99,5%"_. **Elisa ha proposto di spostare la chiamata su Salesforce alla generazione dell'ordine**, scrivendo i dati ufficiali direttamente su Salesforce _"per cui quando Salesforce passa i dati a Mexal siamo sicuri che i dati sono già puliti"_; Elena: _"Questo mi piace molto."_ Stessa regola per gli ordini WooCommerce. Argomento costi di Elisa: gli eventi gratuiti raccolgono 3.000–6.000 iscritti (6.000 al Food Marketing l'anno scorso) di cui forse 250 acquistano. Un account già verificato porta un **flag "consolidato"** e non viene riverificato; i fallimenti generano una **email di notifica a un indirizzo amministrazione che Pienissimo fornirà**; un **pulsante di ri-verifica manuale** sta sia sull'ordine sia sull'account (lato account manuale, stessa API). Oggi una P.IVA errata blocca la generazione dell'ordine su Mexal e l'amministrazione telefona al cliente per correggerla a mano. ⚠ Il fornitore **non è nominato in modo univoco** — l'audio lo storpia; i meeting precedenti citano **Anticipay**, compare anche **CreditSafe**. Elisa ha confermato che il servizio è **già attivo in Pienissimo** e può passare i riferimenti. Call tecnica con **Andrea Parmeggiani** (`a.parmeggiani@pienissimo.pro`), terza settimana di agosto.
- ✅ **La Partita IVA diventa obbligatoria nei form lead usati in diretta** — accettato sapendo che gli iscritti agli eventi gratuiti inseriranno dati spazzatura ("00"), corretti al pagamento. È la validazione all'ordine qui sopra a intercettarli davvero.
- ✅ **Volumi di migrazione corretti**: ~**17.000** record nell'anagrafica clienti Zoho, di cui solo ~**8.500** sono clienti veri con ragione sociale censita; il resto viene eliminato prima dell'import. Il filtro operativo di bonifica è il **codice cliente Mexal** — _"andremo a caricare solo i clienti che hanno il codice cliente Mexal."_ _(Supera il "~6.000 lead/account vs ~7.500 clienti paganti" del §1.)_
- ✅ **La mappatura campi mantiene le etichette originali Zoho** nel file condiviso. Il modulo cliente porta ~**150 campi di cui se ne usa circa un quarto**; Pienissimo elenca solo ciò che vale la pena spostare, e Aurel mappa in fase di inserimento dopo una **call congiunta campo per campo**. La mappatura era al ~95% in sessione, promessa per il giorno dopo. 🟡 **Lead e Referente/Contatti sono l'eccezione** — Elisa ha rifiutato di farli da sola (_"non sono sufficientemente competente"_); da fare a sei mani con Sabatino e Marco. 🟡 **Campi asset deliberatamente rimandati** alla revisione del flusso: oggi Pienissimo ha **evento/edizione, anno accademico, anno di competenza** (l'ultimo guida il movimento di "magazzino" del biglietto).
- 📅 Andrea Di Cicco invia un file con le **domande aperte sulla mappatura campi Mexal**; risponde Elisa, con escalation a Kreosoft se serve.

### 11.7 Marketing e lead

- ✅ **Il funnel di comunicazione evento si automatizza a 60 giorni dall'evento** (finestra 30–60 giorni, per ridurre i no-show), guidato dai tag account + data evento, con invio automatico del link per i dati partecipanti. I bundle multi-evento ricevono comunicazioni **per singolo evento**, ciascuna sul proprio conto alla rovescia — non tutte insieme.
- ✅ **Disegno del trigger**: un **job notturno** che legge la data di inizio della Campagna e seleziona gli account con ≥1 biglietto per quell'evento a data-inizio − 60 giorni. Il funnel parte da un **tag** applicato nel CRM agli account che hanno pagato e possiedono biglietti.
- ✅ **La mail con il QR per singolo partecipante parte da Salesforce, non da marketing**; solo la comunicazione iniziale del funnel è lato marketing. 🟡 **Non è deciso chi ospita la landing page dei dati partecipanti** (community Salesforce vs piattaforma marketing).
- 📅 Meeting dedicato ai funnel marketing dopo il **17 agosto** con **Rebecca Marmo** (`rebecca.m@pienissimo.com`, responsabile dei funnel biglietti), Marco e Matteo. Rebecca entra in **tutte** le call su flussi/campi/biglietti. Sabatino vuole **entrambi** i funnel già pronti puntati sui biglietti. ➖ La review dei 100+ form marketing è stata **depriorizzata dal cliente** in sessione.
- 🟡 **Assegnazione lead**: oggi Zoho distribuisce a rotazione un lead per tutor e Marco dice che non funziona più. La direzione concordata è **code per tipologia di servizio e/o geografia** con assegnazione automatica. ⚠ **L'assegnazione automatica basata sul carico non è disponibile con le loro licenze** (funzionalità orientata ai Case), quindi la risposta pratica è **regole + trasferimento massivo** — selezionare molti lead e riassegnarli in due click. **Marco deve fornire i desiderata concreti** una volta vista la piattaforma reale.

### 11.8 🔴 Programma e contestazione commerciale

- ✅ **Daniela ha approvato la timeline Fase 1 / Fase 2** così com'era — Sabatino: _"l'ha vista tutta, mi ha dato l'ok, non mi ha chiesto niente."_
- 🔴 **Ma non le è mai stato detto che esiste la contestazione di perimetro.** Sabatino, 02:24:17: _"Tutto questo è pienissimo pro, però **Daniela non sapeva questa informazione qui**, quindi tocca rifare un altro giro, ma questo giro me lo faccio dopo le ferie."_ La sua approvazione non può quindi essere letta come accettazione di perimetro o budget, e la conversazione correttiva è rimandata a dopo le ferie. La contestazione del §10.8 — **GLS, Teachable e l'integrazione Zoho per gli ordini Pienissimo Pro (Pienissimo Software Srl)** — richiede ancora _"valutazione economica contrattuale con Daniela per definire se il lavoro rientra in una fase aggiuntiva quotata o potrà essere gestita internamente da Pienissimo."_ Elena ha sollevato il punto; **Sabatino ha ammesso di non aver letto la minuta** che lo segnalava (_"Io non l'ho nemmeno letto quello, ho preso direttamente il link"_). Quarto meeting/status consecutivo che porta questa voce. **Rischio: l'approvazione della timeline venga citata più avanti come accettazione di perimetro.** Non esiste alcuna stima di costo/effort per la Fase 2 — esplicitamente rimandata "al rientro dalle ferie".
- 🔴 **Il rischio di planning è ora concentrato in una settimana.** Sabatino, Aurel e Andrea Parmeggiani sono fuori fino al ~24–26 agosto. Build dei webhook WooCommerce, integrazione servizio P.IVA, mappatura Zoho, revisione flusso asset e funnel marketing partono **tutti** nell'ultima settimana di agosto — contro un **go-live 6 ottobre** e una **scadenza Zoho al 31 ottobre**. Elena in sessione: _"a voi scade il contratto di Zoho."_
- 🟡 **Il flusso asset/biglietti richiede ancora una revisione dedicata** — sia Elisa sia Elena hanno detto che non è completamente specificato. Meeting dopo il 17 agosto, con Rebecca inclusa. Previsione di Sabatino stesso: _"vedrai che anche dopo lo sviluppo esce qualcosa che tocca cambiare."_

---

## 12. Aggiornamento 14/08/2026 — sweep documentale, nessuna riunione

Compilato da uno sweep completo di Gmail (67 thread fino ad aprile), dell'intera cartella Drive `[Pienissimo] Fase Progettuale`, di Slack e di Fathom. **Non si è tenuta alcuna riunione** — tutto ciò che segue proviene da documenti già esistenti e mai letti. **Dove questa sezione contraddice i §1–§11, prevale questa sezione.**

### 12.1 🔴 Gli sviluppi di Fase 1 finiscono il 10 settembre, non il 6 ottobre

`Pienissimo_Project Plan.pptx` (Elena Spini, 10 luglio, nella cartella Drive di progetto) fissa l'intera catena di milestone, e non era mai stato aperto:

| Data             | Milestone                                     |
| ---------------- | --------------------------------------------- |
| **10 settembre** | **Fine sviluppi Fase 1**                      |
| 25 settembre     | Approvazione Soluzione 1                      |
| 6 ottobre        | **GO-LIVE Fase 1**                            |
| 24 ottobre       | Fine sviluppi Fase 2                          |
| 31 ottobre       | Approvazione Soluzione 2 · scadenza Zoho      |
| **9 novembre**   | **GO-LIVE Fase 2**, poi supporto post go-live |

Il 6 ottobre che tutti citano è il **go-live**; UAT, fine tuning, bug fixing, formazione e l'import dati del ~1 settembre stanno tutti prima. Con il team di rientro il 24–26 agosto restano **circa due settimane di sviluppo**. **Il go-live di Fase 2 del 9 novembre non compare in alcun verbale, tracker o recap.** ⚠ Il piano è datato 10 luglio e potrebbe essere stato rivisto — confermare con Elena prima di pianificarci sopra.

### 12.2 La divisione in fasi è nel piano ROMI, e taglia da entrambe le parti

Lo stesso deck elenca **Fase 1**: WooCommerce → SFDC · Mexal ⇆ SFDC · Anticipay (ex CreditSafe) → SFDC. **Fase 2**: GLS → SFDC · Teachable → SFDC · Ordini Pienissimo Pro → Zoho Pienissimo Software SRL.

Sostiene la posizione ROMI della "fase separata". **Non** sostiene "fuori dal progetto": i tre elementi compaiono nel piano ROMI come perimetro, ed è quel piano che Sabatino dice sia stato approvato da Daniela. Vedi §12.3.

### 12.3 Il cliente ha messo per iscritto i tre punti contesi l'11 giugno

`Salesforce - Requisiti e Domande per Elena (16-06-2026).pdf` — documento di requisiti di Pienissimo, sette pagine, assente da ogni tracker fino ad oggi. Il §2.9 elenca **GLS** e **Teachball** sotto _"Integrazioni richieste"_; il §2.7 descrive **Pienissimo Pro** con _"instradamento diretto alla Software"_; la **domanda 10** riguarda GLS e Teachable, la **domanda 11** l'instradamento di Pienissimo Pro al team Software.

⚠ **Questo non decide la contestazione e non va presentato come se lo facesse.** L'11 giugno è _dopo_ il kickoff del 27 maggio, quindi non dice nulla sulla conversazione di prevendita su cui poggia la posizione ROMI. Spiega però perché Sabatino e Fabrizio sono sicuri, e significa che la discussione non si vince affermando che dei temi non si è mai parlato. La domanda che decide è più stretta: **erano a contratto.** Il record di prevendita non è nella casella di Aurel — la sua prima mail Pienissimo è del 24 giugno, un mese dopo il kickoff.

Lo stesso documento è all'origine di **"rinuncia al servizio"** (punto aperto interno con owner Fabrizio Paganelli) e di una domanda mai risposta sull'introduzione di uno stato **Prospect** (#90).

### 12.4 🔴 La chiave per il rilascio dei biglietti manca dalla mappatura Mexal

`Integrazioni pienissimo.xlsx` — la mappatura campi completata da Kreosoft, risposta da Mirko Merendi l'11 agosto — definisce **Get Fatture** come `numero_fattura`, `data_fattura`, `codice_cliente`, `codice_agente`, `note_testata`, `codice_prodotto`, `quantita`, `prezzo_unitario`, `sconto`, `totale_riga`, `aliquota_iva`, `codice_pagamento`, **`numero_ordine`**.

**Non c'è il numero di _riga_ d'ordine.** Il §11 ha fissato la disponibilità del biglietto sul _numero di riga d'ordine_ perché Elisa aveva escluso per data e per prodotto — quest'ultima proprio perché un tutor può mettere lo stesso codice due volte nello stesso ordine. Il solo numero d'ordine non distingue quelle righe.

Il dato esiste alla fonte (la chiamata per singolo documento restituisce le righe): è quindi una **lacuna di mappatura, non un limite di Mexal**. **Sollevarlo alla call del 27 agosto.** Fino ad allora il rilascio dei biglietti non è implementabile come specificato (#75).

Altri fatti ora noti dalla mappatura: tre chiamate mai registrate — **Condizioni pagamento** (p.122, giornaliera), **destinazioni / Indirizzi-spedizione** (p.180–188, _"da verificare"_), **ordini** (p.146); `totale_riga` **non è restituito** e va calcolato come (qta × prezzo) − sconto; `Get Scoperto` porta `stato_pagamento` (`P` = pagato, vuoto = non pagato) ed è la fonte migliore per lo stato di pagamento; gli agenti si filtrano dal prefisso codice **610**; ordini **serie 1 in produzione, serie 10 per i test** — una corsia di test dentro l'azienda di produzione, non l'azienda di test richiesta.

### 12.5 Macchine a stati — il registro era corretto; restano due lacune

`Flows & Objects.drawio` è stato decodificato integralmente. **Le macchine a stati estratte nel registro dei requisiti corrispondono al diagramma corrente** — sei stati asset incluso `Annullato`, gli stati tranche, la rinomina `preventivo scaduto → In attesa di accettazione` segnalata come etichetta ritirata, e `CHIUSO/ACQUISITO` documentato come **collisione di nome** deliberata tra Ordine e Tranche. Nessuna ri-estrazione necessaria.

Due lacune reali:

- 🔴 **`order.states` riporta ancora `[CREATO, CHIUSO/ACQUISITO]`** — i valori del diagramma, non `Ordinato → Fatturato → Incassato` del §11.2. **Nessuno ha detto se `Incassato` sia `CHIUSO/ACQUISITO` rinominato o una milestone diversa**, e la regola delle tranche dipende ancora dal vecchio nome. Ora marcato `status: conflict` nel registro, owner Elena Spini. **Da chiudere prima di configurare Ordine o Tranche** (#69, #50). **⚠ Aggiornato il 20/08 — il diagramma si è mosso, la domanda non si è chiusa.** `Flows & Objects.drawio` ora **disegna** `Ordinato · Fatturato · Incasato` (con una sola `s`, così come tracciato) nella pagina LEAD-OPTY come nuovo blocco `ORDINE` e di nuovo nella pagina Ordini, con la regola _"Status Order == Incassato >> Aggiornamento dell'Opty in **Chiusa Vinta**"_ — confermando che l'Opportunity si chiude sull'incasso e non sulla firma. **Ma non ha eliminato i valori precedenti**: `Order Status SF == CHIUSO/ACQUISITO` e `== CREATO` restano nella pagina Ordini e la regola tranche manda tuttora la prima tranche in `CHIUSO/ACQUISITO`. La fonte porta ora **entrambi i vocabolari insieme**, il che toglie l'attenuante che il disegno fosse semplicemente anteriore alla decisione — e continua a non dire se le due siano la stessa milestone. Sono disegnati solo tre stati; **nessun `Perso`** (#85). Il registro è stato deliberatamente lasciato invariato: la modifica non è verbalizzata.
- ✅ **`opportunity_types` non aveva `Plus + Attivazione o Rinnovo`** — aggiunto.

⚠ **Nomenclatura:** lo stato di annullamento dell'asset è **`Annullato`** sia nel diagramma sia nel registro. Il `PIENISSIMO - Project Status.docx` di Elena e il documento di giugno del cliente lo chiamano _"rinuncia al servizio"_. **Costruire `Annullato`**; è la prosa a essere l'eccezione.

📌 Il registro riportava entrambi i diagrammi come modificati il **31 luglio**; Drive dice **6 agosto** (DGM-2) e **4 agosto** (DGM-1). Date di provenienza corrette nel registro, in `README.md`, in `REQUIREMENTS.md` e in questo documento. Il contenuto estratto è stato verificato sulle versioni correnti e non è cambiato.

### 12.6 Il calendario di ripresa è fissato

**19 ago** funnel marketing, entrambi ora con focus biglietti · **20 ago** flusso asset, voluto da Elisa perché _"ci sono delle cose di cui non abbiamo mai parlato"_ · **25 ago** Anticipay con Andrea Parmeggiani · **27 ago** webhook WooCommerce e scambio credenziali.

⚠ **Due dei quattro sono scoperta di ambito, non sviluppo.** Entrambi i follow-up interni ROMI (10 e 17 agosto) sono stati cancellati il 7 agosto: non c'è alcun checkpoint prima del 19.

### 12.7 Persone — l'organigramma di aprile chiude quattro lacune e ne apre una

`Organigrammi Pienissimo (EV - SW) (APRILE 26).pdf`: **Matteo = Matteo Distaso, Responsabile Marketing** — detentore del blocco #14, cognome finora ignoto · **Sabatino Rinaldi = Growth Manager** · **Fabrizio Paganelli = Responsabile Amministrazione**, con Elisa Migliano in Accounting sotto di lui · **Rebecca Marmo = Content Creator**, non decisore benché due design siano in attesa della sua call.

Novità: **G. Lanzetti è CEO di entrambe, Pienissimo Srl e Pienissimo Software Srl**, con Daniela Morgese General Executive di entrambe — e non compare in alcun verbale. ⚠ **Andrea Parmeggiani lavora per Pienissimo Software Srl**, l'entità al centro della contestazione di perimetro, pur essendo il contatto tecnico designato per un'integrazione di Fase 1.

### 12.8 Altri punti emersi

- **#88 NUOVO** — il **template di import Zoho è un deliverable ROMI** senza riga in tracker, ed è l'unica voce di migrazione in carico a ROMI. Blocca l'import del ~1 settembre.
- **#89 NUOVO** — `BigliettoPdfQueueable` va in errore a runtime: _"Callout not allowed from this future method"_ (mail sandbox, 17 luglio). È il meccanismo dietro "17 envelope inviati, 0 QR generati" della verifica org del 03/08. La classe è in org ma non in `force-app/`.
- **#90 NUOVO** — se introdurre uno stato **Prospect**, aperto dall'11 giugno.
- **#49** — la specifica WooCommerce è stata letta integralmente. Si chiude con **cinque** punti da concordare; i tracker ne seguivano due. Ora registrati anche: il **nome del parametro URL** e il **formato dell'ID**. I coupon sono **esclusi dalla prima fase**, il che risolve la questione della fonte prezzi a favore del listino WooCommerce.

### 12.9 ⚠ Igiene del dato

Tre artefatti di progetto usano **dati di clienti reali** come esempi: il diagramma di design (`SO_Ordine Nr. SO-72216 … DUOMO 2.0 SRL`), il workbook di mappatura Mexal (un'anagrafica cliente completa con P.IVA, indirizzo, telefono, email e PEC) e il contenuto di `01 Documenti forniti dal cliente/Documenti inviati ai clienti/`. Nessuno di quei valori può entrare in `notes/`, in questi recap o in `site/`.

---

## 13. Aggiornamento 24/08/2026 — il file `Prodotti e Bundle`, finalmente letto

**Fonte:** `Prodotti e Bundle.xlsx`, Fabrizio Paganelli → Elena Spini, 07/08/2026 12:17 CEST, inoltrato il 18/08/2026, **aperto il 24/08/2026**. Una copia è ora nella radice del repository, accanto ad `anar_PIE_ricla.xlsx`. Decodifica: [notes/The Prodotti e Bundle workbook.md](../notes/The%20Prodotti%20e%20Bundle%20workbook.md). ⚠ **Contiene prezzi di listino reali — solo repository privato. Mai in `notes/`, in questi recap o in `site/`.**

Nessuna riunione ha prodotto questa sezione. È un documento del cliente che ha risposto a quattro domande ed è rimasto non letto per diciassette giorni.

### 13.1 I prezzi sono arrivati — #87 risolta, #42 no

`Lista Prodotti` contiene **29 articoli su 9 eventi, con `Prezzo Listino` valorizzato su ogni riga** — l'export dell'anagrafica del cliente. Questo chiude la **#87**.

**Non** chiude la **#42**: in UAT ci sono ancora i numeri `[PLACEHOLDER …]`. L'input è arrivato, il caricamento no, e finché non avviene ogni output che contiene prezzi resta interno.

⚠ **La copertura è parziale e questo pesa sulla demo.** **Non esiste alcun prezzo di bundle**: `Esempio di Bundle` mostra solo la composizione e `PACK-93` non ha prezzo. Un bundle non si può quindi ancora mostrare a un numero che Pienissimo riconosca, e la **#13 resta scoperta**.

### 13.2 🔴 L'elenco eventi è di undici eventi, e la picklist costruita è sbagliata

`Lista Eventi` è di **11 eventi in 4 tipologie**, contro i 7 del seed che il registro porta dal 23/07. Include anche una colonna `tipologia evento` che nessuno aveva chiesto e per cui non esiste alcun campo: `a pagamento` (7), `a pagamento/gratuito` (Food Marketing Festival — fruibile in entrambi i modi), `gratuito` (Sold Out, Tour), `annullato` (**Golden Numbers**), `in fase di ridefinizione` (**Pienissimo Intensive**).

**Golden Numbers e Pienissimo Intensive non compaiono da nessun'altra parte in tutto il registro del progetto.** Nessuno dei due ha articoli, coerentemente con il proprio stato. Se debbano entrare nella picklist non è deciso.

🔴 **"Happy Team non vende nulla" è una lettura errata, e ha lasciato un buco nel build.** La trascrizione del 23/07 dice _"c'è Happy Team, ma durante l'Happy Team non vendiamo niente"_ — **non vendiamo _durante_ l'Happy Team**. È stato registrato come "Happy Team non ha nulla da vendere". L'anagrafica dice il contrario: `CS-00154 HAPPY TEAM` ha un prezzo, ha il gemello omaggio ed è **componente del bundle Academy in quantità 2**.

`Product2.Evento__c` è una picklist **ristretta** e **non ha il valore `Happy Team`**. Un articolo Happy Team non è quindi classificabile e l'asset che genera resta senza evento. Altri due valori costruiti non corrispondono ai nomi del cliente — `Camerieri` (troncato da _Camerieri Venditori_) e `Odb Live` — più un `ND` inventato senza corrispondenza nell'elenco del cliente. I valori dovevano essere ricreati puliti dagli elenchi di Fabrizio, quindi vale la sua grafia.

⚠ **La matrice di dipendenza `Anno_Solare__c` → `Evento__c` non ha alcuna fonte lato cliente.** È già costruita con una mappatura precisa — FMF su 2026+2028, Mastery su 2026+2027, Pienissimo Live solo 2026. **Nel file non esiste alcuna colonna anno**; l'unico anno presente è il `2026` letterale dentro i sei nomi degli articoli Tour. La metà "master" del meccanismo che la #46 specifica è un'invenzione ROMI. Chiedere a Fabrizio quali eventi si tengono in quali anni solari.

### 13.3 Vocabolario delle tipologie chiarito — `Silver` e `Dinamond` cadono entrambi

Le tipologie reali dell'anagrafica sono **`EXECUTIVE`, `GOLD`, `DIAMOND`**. Il Food Marketing Festival le ha tutte e tre; Camerieri Venditori ha solo `EXECUTIVE`; gli altri sette eventi a catalogo nessuna.

Entrambi i valori contesi sono quindi sbagliati. **`Dinamond` è `Diamond` scritto male**: la modifica non verbalizzata al diagramma del 20/08 era un refuso, non una nuova tipologia. **`Silver` non esiste da nessuna parte nell'anagrafica**, e la frase verbalizzata il 06/08 _"camerieri venditori Silver ha un codice diverso da camerieri venditori gold"_ nomina due tipologie per un evento che non ne ha nessuna delle due. L'esempio era illustrativo ed è stato preso alla lettera.

⚠ **La tipologia non è un attributo uniforme.** Sette eventi a catalogo su nove non ne hanno, e uno solo ne ha più di una. Una picklist ristretta di tre valori su ogni prodotto resterebbe quasi sempre vuota e inviterebbe un amministratore a inventarne una.

**La #76 resta aperta, perché il campo non esiste.** `Lista Prodotti` ha quattro colonne — `LIVELLO_6`, `_ARCOD`, `Articolo`, `Prezzo Listino`. Nessuna tipologia biglietto, nessun flag evento. La tipologia si legge ancora solo interpretando il nome dell'articolo, esattamente la pratica che la #76 e la #47 vogliono eliminare.

**Di nuovo il build è avanti rispetto al registro:** `Product2.Genera_Biglietto__c` e `Solo_Bundle__c` esistono già in `force-app`, senza nulla a monte che li popoli.

### 13.4 Un bundle ha due livelli, e la junction è piatta

`Esempio di Bundle` è il primo bundle completo che il cliente abbia mai mostrato:

```
PACK-93   ACADEMY 2026 - UN ANNO CON PIENISSIMO (NUOVI)
  BLO-0299  BLOCCO I    → 2 articoli, qtà 1 ciascuno
  BLO-0300  BLOCCO II   → 2 articoli, qtà 2 ciascuno
  BLO-0301  BLOCCO III  → 1 articolo, qtà 2
  BLO-0302  BLOCCO IV   → 1 articolo, qtà 2
  BLO-0303  BLOCCO V    → 1 articolo, qtà 2
```

Le cinque righe `BLO-` sono **evidenziate in verde nel file originale**: il cliente le ha formattate deliberatamente come livello di raggruppamento. È la prima conferma da un documento indipendente della decodifica di `anar_PIE_ricla.xlsx` del 23/07 (`_ARTIP` **A** = prodotto, **Z** = `BLO-`, **C** = `PACK-`).

⚠ **Il 23/07 ROMI ha deciso di non migrare l'apparato C/Z/BLO/PACK.** Il deliverable del cliente del 07/08 descrive il proprio modello di bundle **con quello stesso apparato**, due settimane dopo.

**Il livello intermedio è la tranche — lo dicono le intestazioni stesse del foglio, _"i componenti delle tranche"_.** Questo dà alla **#50** un problema che il registro oggi non vede: quel raggruppamento esiste **a catalogo, prima di qualsiasi ordine**, con un proprio codice articolo, mentre la #50 deriva la tranche dalle **scadenze di riga dopo la vendita**. Due cose, un solo nome. **Decidere quale prima di costruire `Tranche__c`**: determina se l'oggetto nasce all'import dai codici `BLO-` o al momento dell'ordine dalle scadenze.

**`BundleComponent__c` è una junction piatta** (bundle → articolo, con uno `Spread_Price__c` per bundle). Oggi non può esprimere affatto `PACK-93 → BLO-0300 → CS-00003`. O il blocco si riduce a un campo sulla junction, o diventa un record. Non deciso.

**La quantità è per blocco, non per bundle.** Questo singolo bundle produce **dodici biglietti su sette articoli**. Qualsiasi regola di generazione asset che assuma un asset per riga componente è sbagliata (#53).

### 13.5 🆕 #93 — il cliente vuole che i componenti del bundle portino il loro prezzo

Il foglio disegna `PACK-93` **due volte**, e le due intestazioni sono l'intera richiesta: `BUNDLE COME SONO ADESSO` _(i componenti delle tranche sono articoli omaggio)_ contro `BUNDLE COME LO VORREMMO` _(… articoli non omaggio)_. Stesso bundle, stessi cinque blocchi, stesse quantità — cambiano solo i codici dei componenti, ogni `OMAGGIO` sostituito dal gemello a prezzo.

**Uno non cambia:** `CS-00002 SOLD OUT OMAGGIO` resta omaggio in entrambe le versioni, coerentemente con Sold Out che è un `Evento gratuito` senza alcun articolo a prezzo. La regola non è quindi "niente è gratuito", ma "un componente che _ha_ un prezzo deve portarlo".

**Nessuna motivazione dichiarata.** La mail non ha corpo e il file non ha commenti. La lettura in chiave di attribuzione del ricavo è plausibile ma è **un'inferenza ROMI: non va restituita a Pienissimo come se fosse la loro motivazione.**

⚠ **Potrebbe essere già costruito. Ma non darlo per scontato.** `BundleComponent__c.Spread_Price__c`, `Bundle_Selling_Price__c`, `Spread_Total__c` e `Spread_Variance__c` esistono esattamente per questo. **Ma non sono lo stesso meccanismo:** il cliente chiede di cambiare _quale codice articolo_ sta nel bundle; ROMI mantiene il codice e attacca uno spread alla junction. Stesso risultato a ricavo, **dati diversi** — e quale codice arrivi a Mexal, e da quale si generi l'asset, è un'altra domanda.

Restano aperti anche: il totale di listino dei componenti non è il prezzo del bundle (che non è stato fornito) e la sostituzione usa gli articoli **base**, mai gli `AGGIUNTIVO`, anche dove un blocco prende quantità 2 — quindi a cosa serva `AGGIUNTIVO` resta inspiegato.

### 13.6 ⚠ `_ARCOD` è una stringa opaca — una regola per l'import di settembre

In un solo foglio da 29 righe coesistono tre formati di codice: `CS` + 6 cifre (`CS000114`, 9 casi), `CS-` + 5 cifre (`CS-00001`, 18), `CS-` + 4 cifre (`CS-0118`, 2). Non c'è alcuna regola dietro l'attribuzione.

**Due coppie differiscono solo per un separatore o per uno zero iniziale:**

- `CS-00061` e `CS-0061` — **eventi diversi, prezzi diversi**, a uno zero iniziale di distanza.
- `CS000058` e `CS-00058` — i gemelli a prezzo e omaggio dello stesso prodotto, a un separatore di distanza. Fonderli distrugge esattamente la distinzione su cui verte la **#93**.

`Product2.Code__c` è `unique`, `externalId` **e `caseSensitive=false`**: un import che normalizza non fallisce in modo pulito. O **sovrascrive** silenziosamente un prodotto, o solleva un errore opaco di valore duplicato **in fase di caricamento** — intorno all'import del ~1° settembre, lontano dalla trasformazione che l'ha causato.

**La regola: confrontare `_ARCOD` byte per byte. Nessun trim, padding, rimozione del separatore o normalizzazione del case, in nessuna mappatura di import, regola di match, deduplica o riconciliazione Mexal.** Se serve una forma leggibile, va tenuta in un campo separato e non usata mai come chiave. Questo vincola il **template di import (#88)** e il **workbook del data model (#24)**, entrambi ancora in scrittura ed entrambi correggibili ora a costo nullo.

### 13.7 Il Tour è sei articoli, uno per città

Padova, Brescia, Milano, Pescara, Roma, Catania — sei codici, tutti gratuiti, ciascuno chiamato `TOUR PIENISSIMO 2026 <CITTA>`. Un evento, sei istanze vendibili, con **anno e città leggibili solo dalla stringa del nome**. Impatta la creazione automatica della Campaign (#77) — sei prodotti per un evento — e il fatto che `Evento__c` porti un unico valore `Tour`.

### 13.8 Ancora dovuto

La sessione del 22/07 abbinava al file un'azione su Aurel Mrruku: **partecipare a una riunione di approfondimento sull'anagrafica prodotti dopo aver ricevuto il file**. Il file è arrivato il 07/08. **La riunione non si è tenuta.** #46, #48, #76 e #93 vogliono tutte la stessa sede: la **review Mexal con il cliente del 26/08**, dove Fabrizio Paganelli è invitato e che è la prima sessione client-facing da quando il file è arrivato.

## 14. Aggiornamento 24/08/2026 — creazione tranche decisa da Aurel Mrruku

È una decisione architetturale diretta di Aurel Mrruku, non una frase
ricostruita da una riunione.

- La tranche operativa di pagamento viene creata **nel Preventivo, dopo la
  selezione dei prodotti**.
- Un'azione guidata richiede quali righe di Preventivo appartengono alla tranche
  e la data prevista di pagamento. Ogni riga selezionata conserva riferimento e
  data della tranche; una riga appartiene a una sola tranche.
- Quando il Preventivo accettato genera l'Ordine, entrambi i valori si propagano
  alle corrispondenti righe d'Ordine. L'Ordine eredita il piano; non ricrea le
  tranche limitandosi a raggruppare date uguali.
- Mexal aggiorna il pagamento per riga d'Ordine/fattura. Salesforce aggrega gli
  stati e la tranche raggiunge lo stato finale di pagamento soltanto quando
  **tutte le righe incluse sono integralmente pagate**. Il pagamento parziale
  non chiude nulla; Mexal non crea né scrive mai la tranche.
- Il livello intermedio `BLO-` del catalogo è un blocco bundle distinto. Non
  crea `Tranche__c` durante l'import. Questo chiude l'ambiguità del §13.4.
- Il valore API dello stato finale resta **aperto**. Concettualmente è
  `Pagata`/`Incassata`; non va assunto il valore legacy
  `CHIUSO/ACQUISITO` finché non viene chiusa la #69.

`Tranche__c`, l'azione e i campi lato Preventivo, la propagazione alle righe
d'Ordine e l'automazione di roll-up sono ancora tutti da costruire.

## 15. Aggiornamento 24/08/2026 — Asset standard scelto per i biglietti

La decisione sull'oggetto biglietto della #41 è chiusa: il target è l'oggetto
standard Salesforce **Asset**, con un record Asset per ogni biglietto.
L'istruzione diretta non indica chi ha preso la decisione, quindi questo recap
non attribuisce la scelta a una persona.

La decisione non descrive la build UAT attuale. In UAT è ancora presente
l'oggetto custom `Biglietto__c`, con campi, relazioni, logica di generazione
dall'Ordine e sei classi Apex attive per il comportamento DocuSign/PDF. Questi
elementi devono essere mappati su Asset e poi migrati, riscritti o dismessi.
L'effort non è stimato e non esiste ancora un'implementazione sostitutiva su
Asset standard.

La #41 è risolta come decisione di design; la divergenza di implementazione
resta un rischio di delivery aperto.

## 16. Aggiornamento 24/08/2026 — quattro riunioni recuperate in un solo sweep notturno

Il `requirements-check` notturno ha integrato **quattro sessioni non tracciate**.
Due di esse — 19 e 20 agosto — erano state segnalate come mancanti da tre sweep
consecutivi e ora sono interamente verbalizzate. Fonti: voci di canvas aggiunte
tra il 21 e il 24 agosto e la minuta di Elena Spini inoltrata il 24 agosto.

| Data  | Sessione                            | Natura                                                           | Peso                                                         |
| ----- | ----------------------------------- | ---------------------------------------------------------------- | ------------------------------------------------------------ |
| 19/08 | Flussi MKT Biglietti                | Cliente + marketing ROMI                                         | Appunti Gemini + trascrizione                                |
| 20/08 | Flusso Asset/Biglietti              | Cliente, voluta da Elisa Migliano                                | **Minuta di Elena Spini, inviata al cliente la sera stessa** |
| 24/08 | Interna per update flusso Lead/Opty | Interna ROMI (Elena + Aurel)                                     | Appunti Gemini + trascrizione                                |
| 24/08 | Follow-up Interno                   | Interna ROMI (Elena, Aurel, Andrea Di Cicco, Fabrizio Mastracci) | Appunti Gemini + trascrizione                                |

⚠ **Aurel Mrruku non era in nessuna delle due sessioni con il cliente.** Le
decisioni tecniche del 20/08 sono state prese senza il referente tecnico ROMI, e
la minuta gli è arrivata quattro giorni dopo.

### 16.1 🔴 L'edizione dell'evento non è un attributo del prodotto

Fabrizio Paganelli, verbalizzato al cliente il 20/08:

- **I codici articolo Mexal sono trasversali agli anni** — non esiste un codice
  per edizione.
- La classificazione è **Evento → Tipo Biglietto → Edizione**, e l'**edizione è
  determinata dalla data dell'ordine, non dal prodotto**.
- **Mexal supporta al massimo tre classificazioni di articolo**, insufficienti
  per evento + tipo biglietto + varianti.

La picklist `Product2.Anno_Solare__c` costruita e la sua matrice di dipendenza su
`Evento__c` presuppongono che l'anno stia sul prodotto. **La domanda non è più
quali valori servano alla picklist, ma se il campo debba esistere.** Il rilievo
del §13 — che la matrice fosse un'invenzione ROMI — ha ora la sua risposta: non
esiste una fonte cliente perché non esiste il concetto lato cliente. Blocca la
#46; serve la decisione di Aurel Mrruku.

Ad aggravarlo: l'esempio di Elisa Migliano del 19/08 era l'**anno accademico
2026-2027**, e Rebecca Marmo ha descritto la gerarchia Zoho su **quattro**
livelli (Evento → Edizione Evento → Evento Biglietto → Evento Biglietto Prodotto)
contro i due del build.

### 16.2 🆕 Ciò che porta l'edizione: un modello di campagne a tre livelli

Concordato con il cliente il 20/08, configurato internamente il 24/08:

**Campagna Padre** (contenitore di raggruppamento, fini statistici) → **Campagna
Figlio** (l'edizione annuale — date, luogo, check-in) → **Campaign Member** (i
partecipanti).

- Create **manualmente, una volta l'anno, ~10 all'anno**, per clonazione.
  Fabrizio Paganelli ha confermato che il volume è gestibile a mano, quindi **non
  è dovuto alcuno strumento di generazione**.
- **Due Record Type** su Campagna, padre e figlio.
- **Un lookup sul Prodotto con il codice della campagna padre**, compilato **a
  mano dopo la creazione della campagna**.
- **Automatismo che impone una sola campagna figlia attiva per padre**, così che
  l'asset possa risolvere "l'edizione corrente".
- **L'iscrizione a campagna nasce solo al momento dell'iscrizione** — l'acquisto
  non rende l'acquirente un membro.

**Interamente da costruire.** Supera il modello piatto del §11 e riscrive la
portata delle #77 e #84. ⚠ L'intero meccanismo di risoluzione dell'edizione
dipende da un lookup che un amministratore deve ricordarsi di compilare, dieci
volte l'anno, senza alcun controllo verbalizzato che intercetti un campo vuoto.

### 16.3 ✅ Deciso

- **#76 — la tipologia biglietto è un campo Salesforce mantenuto manualmente**,
  di titolarità dell'**amministrazione (Fabrizio Paganelli + Elisa Migliano)**
  con reminder periodici di verifica; l'**aggiornamento massivo una tantum
  all'avvio è di ROMI**. Non può arrivare da Mexal — vedi il limite delle tre
  classificazioni al §16.1. Questo ribalta l'indicazione corrente di chiedere una
  _colonna_ tipologia: chiedere invece la **lista dei valori** concordata.
- **#50 — la tranche si crea e si gestisce manualmente sul Preventivo**, prima
  dell'ordine; **prodotti e tranche sono modificabili solo in `Bozza`**.
- **#75 — la disponibilità del biglietto segue la tranche in ordine
  cronologico**: una rata precedente non pagata blocca gli eventi successivi,
  quindi la disponibilità è funzione dell'intera storia dei pagamenti
  dell'ordine.
- **#73 — il fornitore per la verifica P.IVA è `Anticipay`**, chiamato al
  **primo ordine di un Account**; l'unhappy path è una mail all'amministrazione.
- **#82 — risolta.** La revisione dedicata al flusso asset è la sessione del
  20/08.
- **#59 — il ciclo di vita del preventivo è specificato integralmente**, e i
  **valori delle picklist ora esistono** (nel diagramma, non nel registro):
  `Motivazione da Ricontattare` e `Motivazione da Ricontattare - Preventivo
Inviato`.
- **#58 — esiste per la prima volta una mappatura Mexal a livello di campo**
  (`Integrazioni pienissimo.xlsx`, Andrea Di Cicco, 24/08): entità, metodi,
  cadenza, payload cliente campo per campo. Pattern di sandbox fissato —
  **codice 501 per i nuovi clienti, serie 10 per i nuovi ordini**.

### 16.4 🔴 Due contraddizioni che bloccano il build

1. **#59 — "Da ricontattare".** La minuta del 20/08 ha detto **al cliente** che
   non genera **alcun task automatico**, ma un banner informativo. La sessione
   interna del 24/08 specifica validation rule, trigger e notifiche di reminder
   sullo stesso stato. Banner e validation rule possono convivere, ma il
   "nessun task automatico" è un impegno preso col cliente che la sessione
   interna non ha mai richiamato. **Nessuna delle due è costruibile finché non si
   riconcilia.**
2. **#53 — generazione dell'asset.** La minuta del 19/08 lo dice in due modi
   nello stesso documento: i **Dettagli** dicono che l'asset si crea quando viene
   generato un **ordine** con prodotto di tipo evento (con la motivazione: evitare
   asset creati in fase di preventivo); la riga **Decisioni** generata
   automaticamente dice "ordine **o** preventivo". Preferire i Dettagli, ma farlo
   decidere.

Ancora senza decisione e ora più netta: **#74 — `Rinuncia`.** La minuta del 19/08
descrive la _rinuncia_ come tag di marketing e uscita dal funnel valida per
l'**intera partecipazione**, e non la elenca fra gli stati dell'asset; il
diagramma master continua a disegnarla come box di stato. Diagramma e minuta ora
si contraddicono.

### 16.5 Il file di design si è mosso una quarta volta — e questa modifica è verbalizzata

`Flows & Objects.drawio` ri-decodificato alla versione **24/08/2026 16:34:34Z**.
Per la prima volta la modifica è a valle di una riunione: cade nello stesso
pomeriggio dell'azione di Elena Spini di inviare i verbali e il link al flusso
aggiornato, e il contenuto nuovo riprende le decisioni di quella sessione — la
regola del lookup campagna, i due blocchi di specifica `RULES + FLOW` con i
valori delle picklist, una terza lista di motivazioni (`Motivazioni CHIUSA
PERSA`) e `Anticipay`.

⚠ Le ultime due **non sono databili** al 24/08: sono presenti ora e assenti dal
resoconto in prosa del 20/08, ma la prosa non è un record byte a byte.
Registrate come _presenti, non precedentemente censite_.

### 16.6 Non fatto, deliberatamente

**Nessun requisito è stato modificato.**
`requirements/pienissimo-requirements.yaml`, `REQUIREMENTS.md` e
`REQUISITI.it.md` non sono stati toccati. Diverse di queste decisioni toccano il
testo dei requisiti firmati — le #46 e #76 in modo diretto — ma uno sweep
notturno non è lo strumento adatto per riscrivere un documento contrattuale.
**Segnalato ad Aurel Mrruku ed Elena Spini.**

⚠ `Integrazioni pienissimo.xlsx` **contiene dati reali di clienti** — ragione
sociale, indirizzo, partita IVA, email personale, telefono. Ne sono registrate
esistenza e copertura; **in questo repository non è finito alcun valore**. È il
terzo artefatto con questo problema, dopo il diagramma master e
`anar_PIE_ricla.xlsx`.

## 17. Aggiornamento 25/08/2026 — verifica sull'org UAT Pienissimo

Una **verifica in sola lettura sull'org UAT Pienissimo** (`a.mrruku@pienissimo.uat`),
confrontata con `force-app/` sul ramo `DevMain`. Sostituisce la verifica del
03/08/2026, che era disallineata in entrambe le direzioni.

⚠ **Questa sezione registra solo lo stato del build.** Nessun requisito si è
mosso, nessuna decisione di design si è mossa e nulla qui riapre un punto già
chiuso. Dove contraddice una sezione precedente su **ciò che esiste**, vince il
§17; dove una sezione precedente registra **ciò che è stato concordato**, quella
sezione resta valida. Tabella completa degli scostamenti: il blocco di verifica
org in `open-items.it.md`.

### 17.1 ✅ La tranche è costruita — il record la dava inesistente

`Tranche__c` è attivo, con stato, data di scadenza, importo previsto, sequenza e
lookup al Preventivo, insieme a `QuoteLineItem.Tranche__c`. Sei record, tutti
aperti. Il percorso di creazione manuale concordato al §14 — quick action, LWC e
controller — **esiste e funziona**.

⚠ Due precisazioni, entrambe sostanziali:

- L'interfaccia di creazione (`quoteCreateTranche` e il suo controller) è **solo
  in org**: non è in controllo di versione e non ha test.
- **La propagazione alle righe d'Ordine e l'aggregazione dei pagamenti non sono
  costruite.**

Quindi la #50 passa da "non iniziata" a **parzialmente costruita**, e ciò che
resta è più circoscritto e più chiaro di quanto il tracker riportasse.

### 17.2 🔴 Nell'org non esiste un solo Flow

**Tutta l'automazione dichiarativa progettata da giugno in poi è assente.**
L'unica automazione presente nell'org sono tre trigger Apex —
`BigliettoTrigger`, `BundleComponentTrigger`, `OrderBigliettoTrigger`.

Non c'è nulla dietro: la generazione dell'asset (#53), gli alert e i solleciti
sul preventivo (#59), il funnel partecipanti (#78), i membri di campagna (§16.2 —
`Campaign` non ha alcun campo custom, né record type, né regole di validazione),
né la validazione Lead/Opty specificata il 24/08.

I flussi dei §3 e §11 sono quindi **progetti senza implementazione**, non build
parziali.

### 17.3 🔴 Tutte le macchine a stati sono ancora quelle standard

Ordine, Preventivo, Lead e Opportunità portano le **picklist predefinite di
Salesforce**. Non è configurato un solo valore concordato. Il vocabolario degli
ordini deciso il 06/08 (#69) e il ciclo di vita del preventivo specificato il
24/08 (#59) — valori di picklist inclusi — esistono solo sulla carta.

### 17.4 🔴 Il repository è insieme avanti e indietro rispetto all'org

Entrambe le direzioni contemporaneamente: per questo un'affermazione su "cosa è
costruito" deve dire da quale lato è stata letta.

- **`OrderItem.Tranche__c` è committato in `force-app/` e assente dall'org.** La
  propagazione tranche → ordine non può funzionare, mentre il repository risulta
  completo.
- **Sette componenti `Biglietto` e l'intero stack di creazione tranche esistono
  solo nell'org** e non sono in controllo di versione: una scratch org o un
  refresh li perde.

### 17.5 🔴 Trentasette biglietti sono fermi in uno stato eliminato il 6 agosto

Nessuno ha mai raggiunto `Disponibile`; trenta attendono un passaggio di firma
che il design ha rimosso. Il ciclo di vita del biglietto **non è mai stato
percorso da capo a fondo**.

Nel frattempo l'oggetto di destinazione deciso — l'**Asset** standard — non ha
**alcun campo custom**: l'oggetto target della #41 è vuoto e la mappatura non è
stimata. Questo rende la #74 più netta, non la chiude.

### 17.6 🔴 Oggi non è possibile alcun deploy

La copertura Apex è allo **0%** contro la soglia di piattaforma del 75% — 24
classi e trigger, 1028 righe non coperte, zero coperte, misurate il 25/08/2026.
Le #64 e #66 bloccano ogni altra voce di questo elenco. La suite di test è
trattata come **un unico task, richiesto separatamente prima del deploy in
produzione**, e non va avviata come effetto collaterale di altro lavoro.

### 17.7 L'apparato di classificazione non è solo controverso: è vuoto

Misurato sui 280 prodotti presenti nell'org:

| Campo                                             | Valorizzato                                          |
| ------------------------------------------------- | ---------------------------------------------------- |
| `Genera_Biglietto__c`                             | vero su **4 di 280**                                 |
| `Solo_Bundle__c`                                  | vero su **0 di 280**, e nessuna automazione lo legge |
| `Anno_Solare__c` · `Evento__c` · `Bundle_Type__c` | **1 di 280**                                         |
| `WooCommerce_Product_Id__c`                       | **0 record**                                         |

Quindi la domanda su `Anno_Solare__c` sollevata al §16.1 — se il campo debba
esistere — costa quasi nulla in entrambe le direzioni: non c'è alcun dato
valorizzato da migrare altrove.

### 17.8 Non fatto, deliberatamente

**Nessun requisito è stato modificato.** Una verifica sull'org registra ciò che è
costruito; non riscrive un documento contrattuale. Le decisioni ancora dovute dal
§16 — #46 (`Anno_Solare__c`), #53 (generazione asset enunciata in due modi) e #59
("Da ricontattare") — **non sono toccate da questa verifica e restano dovute**.

---

## 18. Aggiornamento 25/08/2026 — la call tecnica Anticipay

Fonte:
[2026-08-25 Integrazione Anticipay](../notes/meetings/2026-08-25%20Integrazione%20Anticipay.md).
Sessione con il cliente, ore 10:00 CEST. Per ROMI Elena Spini, Aurel Mrruku,
Andrea Di Cicco; per Pienissimo Andrea Parmeggiani (Pienissimo Software),
Fabrizio Paganelli ed Elisa Migliano. Esistono appunti Gemini, trascrizione e
registrazione. È la call che il #73 attendeva dal 6 agosto.

### 18.1 🔴 Salesforce non chiamerà Anticipay

**È cambiata la controparte.** Salesforce chiamerà un'API **realizzata e ospitata
da Pienissimo Software Srl**, che si mette davanti ad Anticipay, memorizza i dati
e restituisce un payload standardizzato. Nuovo punto **#94**.

Due motivazioni, entrambe accolte in riunione:

- **Costi** — argomento di Andrea Parmeggiani. Anticipay fattura a chiamata e
  Pienissimo ha già gran parte del dato, quindi il middleware evita di pagare due
  volte la stessa partita IVA.
- **Isolamento** — aggiunta di Aurel Mrruku. Se Anticipay cambia i propri
  endpoint, si muove solo il middleware.

### 18.2 Il contratto, per quanto concordato

| Elemento             | Concordato                                                                            |
| -------------------- | ------------------------------------------------------------------------------------- |
| Chiamante → chiamato | Salesforce → **middleware Pienissimo**, non Anticipay                                 |
| Innesco              | il **primo Ordine inserito per un Account** — confermato, invariato                   |
| Autenticazione       | un **token nell'header della richiesta HTTP**                                         |
| Errori               | `404` P.IVA non trovata · `500` generico — **codice e messaggio entrambi restituiti** |
| Conservazione errori | **salvati su Salesforce per tre mesi**, usati per generare notifiche interne          |
| Discrepanze          | il valore restituito **sovrascrive** Salesforce                                       |
| Payload              | **ridotto** ai soli campi necessari — vedi §18.3                                      |

### 18.3 Quali campi è ora un punto aperto a sé

Il payload viene ridotto di proposito, e **nessuno ha detto cosa tenere**. Nuovo
punto **#95**, in carico a Fabrizio Paganelli ed Elisa Migliano. Candidati
emersi e nessuno deciso: ragione sociale, rappresentante fiscale, legale
rappresentante, lo **scoring di affidabilità Anticipay** e la **gestione della
fattura elettronica via PEC**. Fabrizio Paganelli lo ha impostato come occasione
per rivedere anche i campi dell'anagrafica Mexal.

⚠ Due di questi non sono dati anagrafici. Uno scoring di affidabilità è un
giudizio commerciale sul cliente; la PEC è configurazione di fatturazione. La
conservazione a tre mesi concordata per i **codici di errore** **non** è stata
dichiarata valida anche per i **dati** restituiti, e nessuno ha chiesto per
quanto tempo si conservano i dati aziendali.

### 18.4 Non è ancora costruibile nulla, e le date sono strette

Nessun endpoint, nessuno schema, nessun token, nessun ambiente di test. **Andrea
Parmeggiani deve l'esempio della struttura della chiamata entro venerdì 4
settembre** — impegno preso come «entro la fine della settimana prossima» — più
un esempio di tutti i campi restituiti da Anticipay. È fissata una call di
follow-up per **martedì 1 settembre, ore 10:00 CEST**, annullabile se il
materiale arriva prima.

Rispetto al **10 settembre** come fine dello sviluppo di Fase 1, restano circa
quattro giorni lavorativi fra l'arrivo della specifica e la chiusura dello
sviluppo.

### 18.5 ⚠ Un'azione è assegnata in modo errato nell'invito inviato al cliente

Il verbale Gemini assegna _«creare un ambiente di test dedicato»_ ad **Aurel
Mrruku**. Non è quanto concordato. Elena Spini gli ha sottoposto la lista su
Slack alle 15:03 CEST e lui ha corretto: l'ambiente di test di ROMI esiste già —
è UAT — e quello che serve è **il loro, su cui ROMI deve puntare**. Elena Spini
ha accettato la correzione.

**L'invito di calendario inviato al cliente alle 13:17 UTC riporta ancora la
formulazione non corretta e non è stato reinviato.**

### 18.6 🔴 Un'integrazione di Fase 1 dipende ora dall'entità contesa

Anticipay → SFDC è in **Fase 1** nel project plan di ROMI. Da questa sessione, la
Fase 1 non può andare in go-live se **Pienissimo Software Srl** — l'entità legale
distinta che ROMI sostiene non essere il cliente di questo progetto, e che sta al
centro della disputa sulla fase 2 — non realizza un servizio, non predispone un
ambiente di test e non ne garantisce l'esercizio.

Chi paga quel lavoro, e chi ne garantisce la continuità dopo il go-live, non è
stato sollevato. La decisione è stata presa nel merito tecnico e le due
motivazioni sono buone; il punto è che **un confine commerciale si è spostato
dentro una decisione tecnica**, e nessuno in riunione lo ha detto.

### 18.7 Il diagramma master ora si contraddice

`Flows & Objects.drawio` è stato modificato **durante la call**, alle 08:23 UTC.
La pagina **LEAD-OPTY** riporta ora _«chiamata API **al middleware Pienissimo**
per check P.IVA Account»_. La pagina **Ordini** riporta ancora _«chiamata API
**Anticipay**»_. La formulazione corretta e più recente è quella della pagina
LEAD-OPTY.

### 18.8 Arrivato sempre il 25/08, ma da Slack e non da una riunione

- 🟢 **La collection Postman** — `Mexal Dev.postman_collection.json`, inviata da
  Andrea Di Cicco alle 11:52 CEST, che chiude un'azione del 24/08. **Incompleta,
  e lo dice lui stesso.** (#58)
- 🟢 **Il collegamento fattura → riga d'ordine ha una risposta.** La singola
  fattura Mexal porta la lista dei suoi item, quindi lo stato di pagamento per
  riga è raggiungibile — _«quindi per le trance sappiamo come capire quando sono
  state pagate»_. È l'input di cui ha bisogno l'aggregazione delle tranche. È una
  lettura del dato, non una chiamata costruita, e **come si creano le tranche
  lato Mexal resta ignoto**. (#50, #58)
- 🟢 **È arrivato il copy della mail di reminder di Marco Montesi**, atteso dal
  20/08. È un promemoria di scadenza preventivo costruito su campi di unione. Le
  **tempistiche di scadenza preimpostate** che deve ancora restano aperte. (#59)

### 18.9 Non fatto, deliberatamente

**Nessun documento di requisiti è stato toccato.**
`pienissimo-requirements.yaml`, `REQUIREMENTS.md` e `REQUISITI.it.md` sono
invariati. Il §18.1 incide direttamente sul testo firmato dell'integrazione — la
controparte di un'integrazione di Fase 1 non è un dettaglio — ma riscrivere un
documento contrattuale sulla base di uno sweep notturno è una decisione umana.
Segnalato, non fatto.

---

## 19. Aggiornamento 26/08/2026 — verifica sull'org UAT Pienissimo

Seconda **verifica in sola lettura dell'org UAT Pienissimo**
(`a.mrruku@pienissimo.uat`), a un giorno dal §17, confrontata con `force-app/`
su `DevMain` al commit `dc513c6`. Prevale sul §17 quanto allo stato del build.

⚠ **Questa sezione registra soltanto lo stato del build.** Nessun requisito si
sposta, nessuna decisione di design si sposta, e nulla qui riapre un punto già
chiuso. Dove contraddice una sezione precedente su ciò che **esiste**, vince il
§19; dove una sezione precedente registra ciò che è stato **concordato**, quella
sezione resta valida. Tabella completa: il blocco di verifica in org del
26/08/2026 in `open-items.md`.

### 19.1 ❌ Il §17.4 era errato, e la colpa è dello strumento

Il §17.4 riportava `OrderItem.Tranche__c` come _«presente in `force-app/` e
assente dall'org»_. **Il campo è in org.** È stato creato il 24/08 alle 15:18Z,
un minuto dopo il gemello lato Preventivo.

`sf sobject describe` — lo strumento usato nel §17 — **filtra l'elenco dei campi
in base alla field-level security dell'utente corrente**. Questo campo non è
concesso a nessun profilo né a nessun permission set di progetto: è quindi
invisibile a ogni utente, Amministratore di Sistema compreso, e `describe` lo
ha omesso esattamente come avrebbe omesso un campo mai creato. Tutti i confronti
sui campi del §17 sono stati rifatti con `FieldDefinition` (Tooling API), che
non è filtrato. **È cambiata solo questa constatazione.**

La conseguenza tratta dal §17.4 resta valida, per motivi diversi: **la
propagazione non può funzionare.** Nessun utente può leggere il campo, e nulla
in `force-app/` lo scrive — né le classi, né i trigger, né la LWC. Il permission
set `Tranche_Management` concede lettura e scrittura sul gemello
`QuoteLineItem` e omette del tutto il lato `OrderItem`.

### 19.2 🟢 La prima macchina a stati concordata è arrivata in org

`Quote.Status` contiene ora **`Bozza · Nuovo Preventivo · In Trattativa · In
Attesa Accettazione · Accettato · Rifiutato`**, con gli otto valori standard
inglesi disattivati. È il ciclo di vita specificato il 24/08 (#59),
`In Attesa Accettazione` compreso — la rinomina che quel punto indica come la
più rilevante.

Il §17.3 diceva che ogni macchina a stati era ancora quella standard. **Resta
vero per Ordine, Lead e Opportunità, e non è più vero per il Preventivo.**

🔴 Una precisazione: **i record sono rimasti sui vecchi valori.** Tre dei
quattro preventivi in UAT sono ancora su valori standard disattivati. Quattro
record di sviluppo non sono nulla — ma sono la prova generale della stessa
operazione sui **37 biglietti** fermi al punto #74, ed è andata nel modo
sbagliato.

### 19.3 🟢 Il recupero in source control è avvenuto in un giorno

Il §17.4 registrava lo stack di creazione tranche come presente solo in org. La
PR #12 (`dc513c6`, integrata il 26/08) ha portato in `force-app/`
`QuoteTrancheController`, la LWC `quoteCreateTranche`, `Quote.Crea_Tranche`, due
campi di `Tranche__c` e il permission set `Tranche_Management`. Il controller
committato è **identico byte per byte alla copia in org**.

**Un componente resta solo in org: il layout `Tranche__c-Tranche Layout`.** E lo
stack Biglietto non si muove dal 22/07 — anzi è **più ampio di tre componenti**
rispetto a quanto registrato, perché la pagina Visualforce `BigliettoPdf`, la
named credential `DocuSign` e il tab `BundleComponent__c` non erano nell'elenco.
Senza la pagina e la credential lo stack non funzionerebbe in un'org nuova
nemmeno recuperando le sei classi.

### 19.4 🔴 Il §17.2 sottostimava l'assenza

Non esiste ancora un solo Flow. La verifica è stata estesa, e anche il resto è
vuoto: **zero** `WorkflowRule`, `ApprovalProcess`, `EmailTemplate`,
`CustomNotificationType`, e **nessun Apex schedulato**. In tutta l'org esistono
due validation rule, entrambe su `BundleComponent__c`.

Non c'è quindi alcuna automazione dichiarativa, **nessun canale di notifica,
nessun template email e nessun temporizzatore**. Tre comportamenti già progettati
non hanno su cosa poggiare: il copy del reminder di Marco Montesi (#59,
consegnato il 25/08), le notifiche reminder specificate il 24/08, e
l'automatismo che porta a «non utilizzato» i biglietti non scansionati tre
giorni dopo l'evento.

### 19.5 🔴 Lo scaffolding di integrazione non è mai stato configurato

Constatazione nuova, assente dal §17. `Integration_Configuration__c` e
`Integration_Log__c` contengono **zero record**, l'org ha **una** sola named
credential (`DocuSign`) e nessun remote site setting.

Nessuna integrazione in uscita — Mexal (#58), WooCommerce (#49), IVA tramite il
middleware (#73, #94) — ha quindi un endpoint definito in org.
`API_Callout_Engine` è in repository, funzionante, e collegato a nulla. Il
motore non è l'integrazione; lo è la riga di configurazione.

DocuSign è l'eccezione e la prova: è l'unica integrazione con una credential ed
è dimostrabilmente in esercizio — `DocuSign_Envelope_Id__c` è valorizzato su
**19 biglietti su 37** — e non usa questo scaffolding. Gira sulle classi
presenti solo in org citate sopra.

### 19.6 🔴 La chiave di ordinamento delle tranche non è affidabile

`Tranche__c.Sequenza__c` è ciò che il rilascio del biglietto (#75) legge per
dire «tutte le tranche che precedono questa». Vale **1, 4, 3** su un preventivo
— con un salto e fuori ordine di creazione — ed è **vuoto** sui tre record più
vecchi. Nessuna validation rule, nessun Flow, nulla che imponga presenza,
unicità o continuità.

Una tranche è inoltre passata a `Parzialmente Pagata` **a mano**: non esiste
automazione che possa averlo fatto. L'aggregazione dei pagamenti resta non
dimostrata, come già diceva il §17.1.

### 19.7 Invariato rispetto al §17

Lo stallo dei biglietti (§17.5): sempre **37 biglietti**, 30 in `In attesa
firma`, **0** mai arrivati a `Disponibile`, **0** QR generati. L'**Asset**
standard ha sempre zero campi personalizzati — confermato con `FieldDefinition`,
quindi non è un effetto della field-level security — e contiene un record
chiamato `Test`. `Campaign` e `CampaignMember` hanno entrambi ancora zero campi
personalizzati: il modello padre/figlio del §16.2 resta interamente da
realizzare.

Rilasciabilità (§17.6): copertura **0%**, ora **1069** righe non coperte sulle
stesse 24 classi. L'aumento da 1028 è tutto di `QuoteTrancheController`, il cui
corpo non cambia dal 25/08 alle 12:50Z: è lo snapshot ad aver recepito il
rilascio, non il codice a essere cresciuto.

L'apparato di classificazione (§17.7) è invariato, con un dato da aggiungere:
`Tipologia__c` risulta valorizzato su **249 prodotti su 280**, cosa che nessuna
verifica precedente aveva registrato.

### 19.8 Non fatto, deliberatamente

**Nessun requisito è stato modificato.** `pienissimo-requirements.yaml`,
`REQUIREMENTS.md` e `REQUISITI.it.md` non ricevono da questa verifica alcuna
modifica oltre al blocco `build_state` del registro, che esiste proprio per
registrare questo.

Due cose sono **segnalate a un umano, non corrette**: il registro, in
`state_machines.quote.states`, porta ancora le etichette più vecchie derivate da
DGM e ora è in disaccordo sia con l'org sia con il #59; e le decisioni dovute dal
§16 — #46, #53 e la contraddizione del #59 su «Da ricontattare» — non sono
toccate da una verifica in org e **restano dovute**.

---

## 20. Aggiornamento 26/08/2026 — la review Mexal, e il meccanismo dell'edizione cambia di nuovo

La sessione cliente **`[ROMI-PIENISSIMO] - Review Temi Integrazione Mexal` del
26 agosto**, 16:00–17:26 CEST, 1h25m45s, recuperata la stessa sera dallo sweep
notturno `requirements-check`. Appunti Gemini, trascrizione completa e
registrazione esistono tutti e sono stati letti; la trascrizione è conservata in
`meetings/2026-08-26-review-temi-integrazione-mexal-transcript.it.md` e il
verbale bilingue in
`meetings/results/2026-08-26-review-temi-integrazione-mexal.it.md`.

**Prima sessione Mexal dal 14 luglio.** Presenti: Elena Spini (esce a ~01:02),
Aurel Mrruku, Andrea Di Cicco (ROMI); Fabrizio Paganelli, Elisa Migliano
(Pienissimo). Sabatino Rinaldi era invitato e non è mai intervenuto.

⚠ **Questa sezione registra decisioni, non stato di build.** Dove incontra il
§19, sul cosa esiste in org comanda il §19.

### 20.1 🔴 La regola della campagna figlia attiva del §16.2 è superata

Il §16.2 registra l'edizione come portata da **un codice di campagna padre in un
lookup sul Prodotto, più una regola che impone una sola campagna figlia attiva
per padre**. Entrambe le metà sono state abbandonate il 26 agosto.

**L'edizione ora deriva da una tabella su Salesforce gestita a mano**, una riga
per `codice articolo × data inizio × data fine → edizione`. Alla generazione
dell'ordine ogni **riga d'ordine** viene confrontata sulla **data dell'ordine**
con l'intervallo del proprio codice articolo.

È stata Elena Spini a superare la propria regola in riunione: un bundle che copre
due eventi non può risolversi su un'unica edizione attiva — _"quello che avevamo
pensato Aurel, cioè non può esistere perché… se prendi il bundle, cioè come
fai?"_ Aurel Mrruku ha accettato la sostituzione: _"non mettono il flag campagna
attiva… mettono solo le date, faccio io il check nel momento in cui si genera
l'ordine."_

Tre proprietà sono facili da fraintendere e tutte e tre sono portanti:

- **Si risolve per riga d'ordine, non per ordine.** Elena Spini ha chiesto;
  Fabrizio Paganelli ha confermato — _"a livello di riga ordine."_ Un ordine si
  divide legittimamente su più edizioni.
- **Gli intervalli sono arbitrari.** Sono il periodo in cui si raccolgono gli
  ordini di un'edizione, impostati a mano, e **non** sono l'anno solare
  dell'edizione né le date dell'evento. Aurel Mrruku l'ha ripetuto e confermato:
  _"puoi mettere data a piacere… io mi baso solo su quelle date."_
- **Comanda la data dell'ordine, non quella della tranche.** Fabrizio Paganelli:
  _"le tranche ci servono a noi solo per definire i pagamenti."_

Una **data evento separata, inserita a mano** — la colonna G della stessa tabella
— porta la data reale dell'evento ed è ciò su cui si aggancia la disattivazione
post-evento dei no-show.

Registrato come **#96**. ⚠ **Concordato nel principio ed esplicitamente non
concluso.** Le decisioni Gemini classificano la mappatura riga d'ordine → campagna
sotto _"Da approfondire"_, unico punto in quella sezione, e Aurel Mrruku ha
chiesto prima un'ora dedicata di esempi concreti. **Quella sessione non è
fissata.**

### 20.2 Il §16.1 è confermato, e ora ha un meccanismo

Il §16.1 registra la decisione del cliente per cui l'edizione non è un attributo
del prodotto. Fabrizio Paganelli l'ha ribadita spontaneamente nei primi due
minuti — _"l'anno accademico avevamo detto di no perché deve essere derivato in
base alla data dell'ordine"_ — e il §20.1 è il meccanismo che era sempre mancato.

**Questo scioglie il nodo del #46.** A `Product2.Anno_Solare__c` non manca
soltanto una fonte cliente per la matrice di dipendenza: il suo compito ora
appartiene al #96. È valorizzato su 1 prodotto su 280, quindi rimuoverlo costa un
solo record.

Anche l'**evento** trova il suo vettore, e non è una picklist Salesforce:
discende dalla `categoria statistica` di Mexal.

### 20.3 🟢 I tre campi di classificazione Mexal sono assegnati e verificati sul campo

Il vincolo posto da Fabrizio Paganelli in apertura: **l'anagrafica articoli di
Mexal ha al massimo tre campi disponibili per classificare un prodotto**, e
nessuno di essi è oggi gestito — _"siamo liberissimi di fare come è più comodo
per noi."_

Ogni assegnazione qui sotto è stata dimostrata durante la sessione, con Fabrizio
Paganelli che modificava su Mexal e Andrea Di Cicco che confrontava la risposta
API in tempo reale.

| Campo Mexal            | Nome API                           | Porta                              | Verificato                                                  |
| ---------------------- | ---------------------------------- | ---------------------------------- | ----------------------------------------------------------- |
| `natura`               | `COD_Natura`                       | genera biglietto sì/no             | ✅ impostato su `CS_00154`, visto via API                   |
| `categoria statistica` | `Sigla cat sta` + `Numero cat sta` | l'evento (Campagna Padre)          | ✅ `C01` poi `P02`. **Due campi API**                       |
| `gruppo merceologico`  | `GRP merch`                        | candidato per il tipo biglietto    | ⚠ gerarchico; **è arrivato solo il codice, non il livello** |
| `Gest. annullato`      | `Gest. annullato` — `n`/`S`        | prodotto disattivato su Salesforce | ✅ `CS58` annullato e ripristinato in diretta               |

`natura` è collegato a una tabella di base gestita, **non è campo libero** — il
che risponde all'obiezione di Andrea Di Cicco che un operatore potesse scriverci
qualsiasi cosa.

⚠ **I valori non sono stati scelti.** Fabrizio Paganelli porta lo schema alla
direzione Pienissimo **lunedì 31 agosto**.

Questo risponde alla domanda lasciata aperta dal §16 al #47: **il flag evento sta
sul lato Mexal.**

### 20.4 🔴 Il gemello da bundle ha bisogno di un codice articolo proprio — il #48 si ribalta

Il 24 agosto il record leggeva `Product2.Solo_Bundle__c` come sostituto della
convenzione `(B)`. Aurel Mrruku ha stabilito il contrario: _"devi per forza avere
due prodotti, non lo puoi fare un unico prodotto."_ Fabrizio Paganelli ha
concordato e l'ha nominata — codice A fuori dal bundle, codice B per i tutor.

Il flag dice quale sia quale; non elimina il gemello. I codici nasceranno dentro
la ricreazione dell'anagrafica del §20.7, e la sigla `(B)` non è mai stata
nominata — **chiedere la convenzione quando arriva la nuova anagrafica.** Due
articoli di questo tipo sono promessi come test la settimana prossima.

### 20.5 Prodotti obsoleti disattivati via `Gest. annullato`, con un costo manuale noto

Esistono circa 1000 codici articolo storici e i tutor li selezionano. Il pulsante
`annulla/ripristina` di Mexal imposta il flag, l'integrazione lo mappa su un flag
di inattività su `Product2`, il prodotto smette di essere selezionabile. Testato
su una fattura reale: la riga dell'articolo annullato è rimasta visibile sulla
fattura emessa.

⚠ **Elisa Migliano ha portato il caso di errore dall'esperienza reale**: è
successo che i tutor quotassero un codice mentre l'amministrazione lo annullava,
il preventivo non arrivasse a Mexal e venisse corretto a mano. Andrea Di Cicco ha
confermato che Salesforce si comporta allo stesso modo: **nessuno può
riselezionare un prodotto disabilitato, utenti master e amministrazione
compresi**, ma una riga d'ordine esistente può essere modificata inserendo il
codice sostitutivo. Entrambi hanno accettato il costo.

### 20.6 Nuovo: la residenza fiscale è obbligatoria, e la documentazione API è incompleta

La chiamata di creazione cliente di Andrea Di Cicco è fallita su **`tipo
nazionalità`**, che nella schermata Mexal è la `residenza fiscale`. Deve
distinguere **Italia, San Marino, Città del Vaticano, Unione Europea,
extra-Unione Europea**, perché determina la trasmissione delle fatture
all'ufficio tributario sammarinese. Se Salesforce debba portare o derivare il
valore **non è stato discusso** — **#97**.

⚠ Non era l'unico campo obbligatorio non documentato: _"tutti sti campi non
c'erano sulla documentazione."_ `valuta` è stato impostato a `1` per tentativi e
**nessuno sa se 1 sia l'euro**. Trattare la documentazione Mexal come una
descrizione parziale del contratto.

Una volta impostato, entrambe le chiamate in scrittura hanno funzionato: cliente
`501.08721` e ordine `OC11`, sulla serie 10 — **in produzione**. 🔴 **Non esiste
ancora un ambiente di test Mexal.**

### 20.7 🔴 L'intera anagrafica articoli Mexal è destinata a essere ricreata

Dichiarazione di apertura della riunione, e la cosa più gravida di conseguenze
che contenga:

> _"vorrei chiudere tutti i codici prodotto che abbiamo adesso e crearne di nuovi
> in base alle regole che ci siamo dati fino ad oggi… è probabile che ci sia
> l'intenzione di rivedere un attimo i listini."_

Va alla direzione Pienissimo il **31 agosto**; l'anagrafica revisionata è
promessa "settimana prossima". Registrato come **#98**.

Rende provvisorio quasi tutto ciò che è stato derivato da
`Prodotti e Bundle.xlsx` — la lista eventi (§13, #46), l'evidenza sulle tipologie
(#76), i codici solo-bundle (#48), la richiesta sui componenti a pagamento (#93)
— e le 280 righe `Product2` in UAT. ⚠ I listini rientrano nella revisione, quindi
i prezzi consegnati il 07/08 hanno una scadenza; registrare che cambiano, mai i
valori. **Nessuno ha collegato la cosa alla fine dello sviluppo Fase 1 del
10 settembre.**

### 20.8 ✅ Definito, e una cosa esce dal perimetro

- **Si usa solo il listino 1.** _"usiamo solo l'uno."_ Aperto da luglio, rinviato
  da Mirko Merendi a Fabrizio Paganelli — ora risposto (#58).
- **Le tipologie di biglietto sono Executive, Gold e Diamond**, pronunciate da
  Fabrizio Paganelli e coincidenti con l'anagrafica. `Silver` e `Dinamond` sono
  entrambi da scartare (#76). ⚠ _Dove_ risieda la tipologia si è riaperto e non
  si è chiuso — vedi §20.10.
- 🟢 **La fatturazione resta pilotata da Mexal per circa sei mesi.** Andrea Di
  Cicco aveva il JSON; Fabrizio Paganelli ha declinato — _"per il momento
  preferisco che venga pilotata solo da Mexal la fatturazione."_ Salesforce legge
  le fatture, non le crea. Toglie una voce di sviluppo mai stimata.
- **I bundle multi-edizione dello stesso articolo sono fuori perimetro** —
  _"questa qui è una cosa che non facciamo."_ Da leggere in senso stretto:
  articoli diversi con intervalli diversi continuano a dividersi su edizioni
  diverse nello stesso ordine.
- **Nuovo requisito:** quando a un no-show viene dato manualmente un biglietto
  omaggio per l'edizione successiva, **l'Asset va collegato a mano alla Campagna
  Figlia successiva**, altrimenti l'automatismo dei reminder non scatta più.
  Nessun controllo lo intercetta.

### 20.9 🔴 Il #92 era la domanda per cui questa riunione esisteva, e non è stata posta

La domanda sullo scadenziario — una fattura Mexal _non_ pagata può riportare un
Asset allo stato precedente? — era verbalizzata il 20 agosto come azione per
questa sede. Il proponente (Fabrizio Paganelli) e il responsabile (Andrea Di
Cicco) sono stati entrambi in riunione per 1h25m. **La parola _scadenziario_ non
compare nemmeno una volta** nella trascrizione, negli appunti, nelle decisioni o
nei passaggi successivi.

Ora non ha **alcuna sede fissata**: il 27 agosto è WooCommerce e il
`Follow-up Anagrafica Articoli` del 2 settembre è centrato sull'anagrafica
articoli. Metterlo esplicitamente a ordine del giorno.

### 20.10 Domande aperte che questa sessione lascia

- ⚠ **Il tipo biglietto ha due risposte in campo.** Il verbale cliente del
  20 agosto dice campo solo-Salesforce; questa sessione ha rimesso in gioco il
  `gruppo merceologico` di Mexal senza ritrattarlo e si è chiusa con _"facciamo
  una prova"_. **Qui l'evidenza più recente non prevale** — la discussione non ha
  concluso. Considerare il 20 agosto come vigente e Mexal come alternativa
  aperta.
- ⚠ **Lo schema combinatorio a quattro valori è stato proposto e abbandonato in
  corsa.** Aurel Mrruku ha ipotizzato di comprimere due booleani dentro `natura`,
  ha fatto marcia indietro quando le tipologie sono risultate tre, e Andrea Di
  Cicco l'ha definito _"un po' complicato"_. **Non implementare su quella base.**
- ⚠ **La relazione tranche ↔ righe d'ordine resta inspiegata.** Aurel Mrruku l'ha
  chiesto direttamente ad Andrea Di Cicco — _"mi devi spiegare sta roba"_ — e la
  call si è chiusa prima. Impatta il #50.
- 🟢 **La sessione sull'anagrafica clienti è stata prenotata la sera stessa** —
  2 settembre 10:00–11:30 CEST — benché l'invito sia intitolato
  `Follow-up Anagrafica Articoli` e il thread che l'ha generato copra entrambe le
  anagrafiche. **Mettere per iscritto l'agenda dell'anagrafica clienti prima
  della riunione** (**#99**).
- 🔴 **I dizionari di valori codificati di Mexal sono ignoti a ROMI come classe.**
  Andrea Di Cicco su Slack alle 18:16 CEST: _"loro hanno dei valori che sono tipo
  per valuta: 1,2,3,4 — che lato nostro non sappiamo"_. Li aveva già chiesti per
  email e non ha avuto risposta. Il suo verdetto sulla giornata:
  _"le integrazioni per ordini e clienti funzionicchiano"_.
- ⚠ **Il file di disegno principale è ora superato sulle campagne.**
  `Flows & Objects.drawio` si è mosso una **sesta** volta il 26 agosto alle
  14:06Z — sei minuti dopo l'inizio di questa riunione — e **nessuna cella di
  testo tracciata è cambiata**. Riporta ancora _"Sulle campagne figlie deve
  esserci logica solo una campagna attiva"_ e il lookup manuale prodotto→padre,
  entrambi superati qui, e la pagina Ordini legge ancora _Anticipay_ contro il
  _middleware Pienissimo_ di LEAD-OPTY (§18.7), non riconciliato dopo altre due
  modifiche.

### 20.11 Non fatto, deliberatamente

**Nessun requisito è stato modificato.** `pienissimo-requirements.yaml`,
`REQUIREMENTS.md` e `REQUISITI.it.md` non ricevono da questa sessione alcuna
modifica. Due delle sue decisioni — la sostituzione del meccanismo dell'edizione
al §20.1 e la regola dei due codici al §20.4 — toccano evidentemente `BIG-02`,
`BUN-12`, `BUN-13` e i requisiti sulle campagne, ma la sessione ha definito un
**meccanismo** più che una clausola contrattuale, e il #96 è esplicitamente
incompiuto. **Sollevare la modifica al registro con Aurel Mrruku una volta svolta
la sessione di esempi concreti**, così che il testo italiano che il cliente firma
sia scritto su un disegno concluso.

Le decisioni dovute dal §16 — #46, #53 e la contraddizione del #59 su
«Da ricontattare» — non sono cambiate con questa sessione. Il #46 è ora
decidibile; le altre due no.
---

## 21. Aggiornamento 27/08/2026 — l'integrazione WooCommerce è costruita, lato cliente

Fonte: due sessioni con il cliente nello stesso giorno, entrambe con appunti Gemini, **trascrizione completa** e registrazione — [Integrazione WooCommerce](results/2026-08-27-integrazione-woocommerce.it.md) (10:00–10:48 CEST, 48m20s, conduce Elena Spini, sei presenti) e [Test Integrazione WooCommerce](results/2026-08-27-test-integrazione-woocommerce.it.md) (15:59–16:16 CEST, 17m13s, **due persone**). Individuate dallo sweep notturno `requirements-check` del 27/08/2026.

### 21.1 🟢 La direzione dell'integrazione è decisa, e in modo più preciso di "webhook"

**È WooCommerce a scrivere su Salesforce.** I webhook standard di WooCommerce sono stati valutati a schermo e **scartati** — un solo argomento per webhook, nessuna selezione multipla, nessun controllo sul body; invierebbero ogni ordine in ogni stato e non potrebbero portare la struttura del cliente. Il meccanismo concordato è un **plugin WooCommerce personalizzato con action hook PHP sul cambio di stato dell'ordine**, che compone un unico JSON.

`INT-14` passa da **aperto ad accordato**. Il disegno preesistente aveva la forma opposta: la piattaforma di Sabatino Rinaldi che **interroga** WooCommerce con un cron, cosa che Aurel Mrruku ha identificato come asincrona e orientata nel verso sbagliato per Salesforce. Contratto completo: [l'integrazione ordini WooCommerce](../notes/flows/The%20WooCommerce%20order%20integration.md).

### 21.2 🟢 Il lato cliente è costruito e dimostrato funzionante

Sabatino Rinaldi ha scritto il plugin **fra le due sessioni** e l'ha guidato in diretta sullo shop di produzione: **versione 1.3, sempre attivo, HTTP 200 sul filo**, con un pulsante di reinvio manuale sull'ordine. Trigger verificato in diretta: stato ordine `in lavorazione` **oppure** `completato`, **con qualsiasi metodo di pagamento** — bonifico, carta, PayPal.

Payload osservato: order key, totali, sorgente di tracciamento · cliente con nome, ragione sociale e partita IVA · righe con il **codice prodotto `SC`**, nome, quantità, subtotale, totale. La copia autorevole è un file di testo inviato per mail alle 14:20Z che **nessuno strumento collegato è in grado di aprire**.

### 21.3 🔴 `ORD-12` viene corretto

Il registro e il diagramma di disegno dicevano che un ordine WooCommerce è **invisibile su Salesforce finché non è COMPLETATO**. Il plugin consegnato scatta **anche su in lavorazione**, verificato in diretta. Vince l'evidenza più recente: la regola è **IN LAVORAZIONE oppure COMPLETATO**, con entrambe le date citate nel registro. La parte sui bonifici resta valida — l'amministrazione cambia ancora lo stato a mano alla ricezione.

Conseguenza: **ogni riga che arriva da WooCommerce è già pagata**, e il payload non porta stato a livello di riga.

### 21.4 🔴 Si accorciano sia il mu-plugin sia l'anatomia del link

I carrelli sono costruiti con **Funnel Kit**, cosa che ROMI non sapeva. L'URL del funnel contiene già il prodotto, quindi il link di checkout generato da Salesforce porta **solo l'ID opportunità** — niente `add-to-cart`, niente `quantity`. Il pulsante generatore del link non ha quindi bisogno di **selezione prodotto o quantità**, il che toglie lavoro dalla build list di `INT-13`. E il componente lato cliente è il **plugin di Sabatino Rinaldi, di proprietà Pienissimo**, non il mu-plugin specificato da ROMI.

⚠ I tre punti di specifica ancora aperti — ID in chiaro o token firmato, nome del parametro URL, formato dell'ID — vengono ora **decisi dall'implementazione** anziché concordati. `INT-16` raccomanda ancora un token firmato; l'URL della demo sembrava portare l'ID in chiaro.

### 21.5 🔴 La credenziale attesa ha invertito direzione

`INT-11` registra dal 14 luglio le **CK/CS WooCommerce attese da Sabatino Rinaldi**, ripromesse nell'invito di questa sessione — _"comprensiva dello scambio di credenziali"_ — e mai nominate. Poiché è WooCommerce a scrivere, la credenziale bloccante è **di ROMI: un endpoint Salesforce e un token di header**, cosa a cui Aurel Mrruku si è impegnato e che blocca i test di integrazione fissati per la **settimana del 31 agosto** ([OI-102](../notes/items/OI-102%20Salesforce%20endpoint%20and%20token%20for%20the%20WooCommerce%20plugin.md)).

Se Salesforce continui a rileggere gli ordini via API REST di WooCommerce — e quindi se le CK/CS servano ancora — **non è stato deciso**. Non riportarle né come attese né come chiuse.

### 21.6 🔴 Una regola IVA si è spostata in una stanza da due persone

**Nessun check P.IVA scatta su un ordine WooCommerce in ingresso**; la validazione resta sulla tratta Salesforce → Mexal. Aurel Mrruku si è corretto in questo senso a metà scambio e Sabatino Rinaldi ha concordato.

⚠ [OI-73](../notes/items/OI-73%20VAT%20validation%20moves%20into%20Salesforce.md) è una **decisione cliente del 6 agosto** — proposta da Elisa Migliano, approvata da Elena Spini — secondo cui il check scatta **al primo ordine di un Account**. Quella è per Account e una tantum; questa è per ordine, e un ordine WooCommerce che non arrivasse mai a Mexal non verrebbe mai verificato. **Né Elisa Migliano né Elena Spini erano presenti.** Farla riconfermare.

### 21.7 🔴 Le vendite da palco sono il fatturato, e non sono testate

Fabrizio Paganelli, spontaneamente in chiusura della sessione di design: WooCommerce è usato _pesantemente_ per le **vendite da palco** — cliente in sala, QR code, **€8.900–9.000 e oltre** contro i ~€97 di un libro o di uno stream — e una vendita da palco **innesca meccanismi a valle, tra cui l'invio del contratto**. Ha chiesto entrambe le casistiche nei test. La sessione pomeridiana ha portato **un solo prodotto da €50 sul percorso felice**; le vendite da palco sono state rimandate al giro collegato a Salesforce. [OI-101](../notes/items/OI-101%20Stage%20sales%20must%20be%20in%20the%20WooCommerce%20test%20set.md).

### 21.8 🔴 Due cose senza proprietario

- **I set di campi WooCommerce e Mexal si scontreranno.** Andrea Di Cicco l'ha sollevato all'inizio — _"onde evitare di creare 12.000 campi"_ — e nessuno l'ha ripreso. Non compare nei next step di nessuna delle due sessioni. [OI-103](../notes/items/OI-103%20WooCommerce%20and%20Mexal%20field%20overlap.md).
- **Non esiste un ambiente di test WooCommerce.** Si prova sullo shop di produzione; durante i test **ordini di clienti reali sono finiti su un endpoint di terzi usa-e-getta** prima che Sabatino Rinaldi disattivasse il plugin. Stessa forma della serie 10 di Mexal. [Il rischio](../notes/risks/Risk%20-%20real%20WooCommerce%20orders%20reached%20a%20third-party%20test%20server.md).

### 21.9 🔴 Fuori dalle riunioni: la conversione dei Lead è rotta in sandbox

Non viene da nessuna delle due sessioni. Una mail di errore Salesforce delle **15:08:13Z** segnala `LeadConversionQueueable` in errore nella **partial sandbox** Pienissimo: _"No such column 'Servizio_Interesse__c' on entity 'Lead'"_ alla riga 22. **La copia della classe nel repository non seleziona quel campo**, e i metadati del campo **sono** in `force-app/`. Quindi l'org esegue una versione diversa della classe, e alla sandbox manca un campo che il repository ha. **Lì la conversione dei Lead non si completa.** [Il rischio](../notes/risks/Risk%20-%20LeadConversionQueueable%20is%20broken%20in%20the%20Pienissimo%20sandbox.md).

✅ **Risolto il 2026-08-28, e la lettura qui sopra era errata.** Il paragrafo resta come registrazione di ciò che si riteneva il 27 agosto, scritto **senza accesso all'org**. Una verifica sull'org del **28 agosto (14:45–14:56Z)** ha trovato `Lead.Servizio_Interesse__c` **presente** nell'org e **né** la classe distribuita **né** la copia nel repository che lo selezionano: l'unica differenza org-repo su quella classe è l'andata a capo di Prettier. L'errore delle 15:08:13Z è reale, ma registra uno **stato transitorio del 27 agosto**, non una divergenza stabile; nulla agli atti mostra cosa sia cambiato fra le due osservazioni, quindi non viene attribuito. 🟢 Non blocca più il test di [OI-100](../notes/items/OI-100%20Same%20lead%20email%20with%20different%20VAT%20during%20conversion.md).

### 21.10 Stato della build WooCommerce

| Lato                                                                                                 | Stato                                                                                                                                                                                                                        |
| ---------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Pienissimo — plugin, trigger, payload, reinvio**                                                   | 🟢 **costruito e dimostrato**                                                                                                                                                                                                |
| **ROMI — endpoint, token**                                                                           | ⚠ **corretto il 31/08** — l'endpoint **è distribuito e riceve traffico reale** (`WoocommerceOrderService`, non versionato); il **token non è ancora stato creato**, e l'endpoint non ha alcuna autenticazione (§22.3, §22.5) |
| **ROMI — pulsante generatore link, template email, tipologia ordine, match `SC`, creazione cliente** | 🔴 non esiste nulla                                                                                                                                                                                                          |
| Configurazione org                                                                                   | 🔴 nessun Flow, nessuna named credential, nessuna riga di configurazione integrazione (verifica org 26/08; `Integration_Configuration__c` ancora 0 righe e 0 permessi oggetto al 31/08)                                      |

Il lato cliente è reale e in attesa di ROMI, a undici giorni lavorativi dalla fine dello sviluppo di Fase 1 del **10 settembre**.

## 22. Aggiornamento 31/08/2026 — un deploy distruttivo, e il primo impegno del cliente rispettato in anticipo

Nessuno dei due punti nasce da una riunione. Entrambi derivano da un
`org-status-check` delle **09:36–09:52Z** che, per la **seconda esecuzione
consecutiva**, non ha pubblicato nulla agli atti, e da una mail del cliente in
serata.

### 22.1 🔴🔴 `Biglietto__c` è stato eliminato dall'org, con tutti i 37 record

`EntityDefinition` via Tooling restituisce zero righe e le query SOQL
sull'oggetto non vengono più interpretate. **I record non sono stati migrati**:
Asset ne conteneva 4 il 28 agosto e ne contiene 5 oggi — uno aggiunto, non
trentasette.

L'eliminazione è stata **deliberata ed è nel repository**. Il commit `5d8cdb3`
(28 agosto 18:10 CEST) rimuove l'oggetto da `force-app/` e aggiunge
`manifest/biglietto-cleanup-destructiveChangesPost.xml`, un manifest di modifiche
distruttive che nomina l'oggetto, la sua tab, il layout, la list view, sei classi
Apex, un trigger e una pagina Visualforce. Segue la decisione del 24 agosto di
adottare Asset standard, quindi è una pulizia pianificata — **ma da nessuna parte
risulta che sia stato fatto prima un export**, ed è questo il nodo dell'intera
decisione di recupero.

Salesforce conserva un oggetto personalizzato eliminato e le sue righe per circa
**15 giorni**, quindi la finestra si chiude intorno al **12 settembre** — un
giorno dopo la fine prevista dello sviluppo di Fase 1. È l'unico punto di questo
documento che **decade se nessuno interviene**.
[Il rischio](../notes/risks/Risk%20-%20the%20Biglietto%20UAT%20ticket%20dataset%20was%20deleted.md).

### 22.2 🔴🔴 Sette componenti Apex sono spariti con esso, e nessuno era sotto controllo di versione

`BigliettoTriggerHandler`, `BigliettoDocuSignService`,
`BigliettoDocuSignQueueable`, `BigliettoPdfService`, `BigliettoPdfQueueable`,
`BigliettoPdfBatch`, `BigliettoTrigger` e la pagina `BigliettoPdf` non sono più
nell'org — 31 classi Apex oggi contro 37 il 28 agosto.

**Verificato sull'intera storia git: nessuno di essi è mai esistito in questo
repository, su alcun branch.** Circa **270 righe del percorso di invio DocuSign e
dello stack di generazione PDF** sono quindi perse dall'unica copia esistente. Quel
codice aveva dimostrabilmente funzionato: **19 dei 37 record eliminati avevano
`DocuSign_Envelope_Id__c` valorizzato**, l'unica prova su questo progetto che la
tratta DocuSign abbia mai funzionato.

⚠ La verifica sull'org lo ha riportato come _"drift del controllo di versione
Biglietto risolto, seppure per eliminazione da entrambi i lati"_. **I lati non
sono mai stati due.** Il drift non è risolto: la metà non versionata è stata
distrutta. Un oggetto eliminato può essere ripristinato dal cestino; **il codice
Apex eliminato non ha un ripristino equivalente per l'utente**, quindi il codice è
la metà più difficile, non lo stesso problema.
[Il rischio](../notes/risks/Risk%20-%20the%20Biglietto%20Apex%20stack%20is%20not%20in%20source%20control.md).

⚠ **Il progetto ora non ha nessuna delle due implementazioni del biglietto** — la
vecchia rimossa, e Asset standard con 8 campi personalizzati, 5 record e nessuno
dei cicli di vita concordati. Il §3.4 e la riga Asset del §1 vanno letti tenendone
conto.

### 22.3 🔴 Lo stesso schema è di nuovo in atto, su WooCommerce

|              | In `force-app/`                          | Nell'org                                |
| ------------ | ---------------------------------------- | --------------------------------------- |
| Classe       | `WooCommerceOrderEndpoint` (16.789 car.) | `WoocommerceOrderService` (23.087 car.) |
| `urlMapping` | `/woocommerce/orders/*`                  | `/woocommerce/orders/*`                 |
| Distribuita  | no                                       | **sì, modificata il 31 agosto**         |
| Versionata   | sì                                       | **no**                                  |

Un deploy pulito da questo repository **pubblicherebbe una seconda classe su una
rotta che ne ha già una** e lascerebbe orfana quella che serve attualmente il
plugin. La copia nell'org è attiva e trafficata — 16 log di integrazione in
ingresso e 7 ordini con chiave Woo — ed è la singola classe più scoperta, con 396
righe. **Recuperarla è un comando e nessuno lo ha eseguito.**
[Il rischio](../notes/risks/Risk%20-%20a%20clean%20deploy%20would%20orphan%20the%20live%20WooCommerce%20endpoint.md).

### 22.4 🔴 Il contratto sugli ordini duplicati è cambiato senza avvisare la controparte

Una consegna duplicata ora restituisce **HTTP 200 con `duplicate: true`** e
aggiorna l'Opportunity, dove il 28 agosto restituiva **409**. Il successo
idempotente è una scelta difendibile; cambiarlo in silenzio su un'integrazione
attiva no. Il plugin di Sabatino Rinaldi non può più distinguere "creato" da "già
esistente" dal codice di stato, e i test di integrazione si svolgono **questa
settimana**. Il §21.10 e
[OI-104](../notes/items/OI-104%20The%20WooCommerce%20payload%20has%20no%20idempotency%20key.md)
riportano ancora 409: l'org ha ragione.

### 22.5 🔴 `INT-16` è sopravvissuto a una riscrittura completa, ancora senza autenticazione

Il servizio riscritto è ancora `global without sharing` **senza alcun controllo di
token né di firma**. L'unica gestione di `Authorization` oscura l'header per il
logging (righe 418–427) — prova che viene ricevuto e conservato in sicurezza, e
nessuna che venga verificato. L'endpoint riceve **traffico reale di produzione
senza alcuna autenticazione applicativa da quattro giorni**, e il token dovuto ai
sensi di
[OI-102](../notes/items/OI-102%20Salesforce%20endpoint%20and%20token%20for%20the%20WooCommerce%20plugin.md)
resta l'intera autenticazione.

### 22.6 Copertura: il numero è sceso, e non è un progresso

**0% di 1.571 righe su 21 classi**, da 1.769 su 28. ⚠ **L'intera diminuzione è il
codice Biglietto eliminato. Nessun test è stato scritto.** Le più scoperte:
`WoocommerceOrderService` 396, `QuoteTrancheController` 386,
`LeadConversionQueueable` 148 — e la maggiore delle tre non è leggibile dal
repository. Il register riporta ancora `current: "1%"`; è 0% in ogni misurazione
dal 25 agosto.

### 22.7 Verificato anche questo, invariato dal 28 agosto

`Integration_Configuration__c` ha ancora **0 righe e 0 permessi oggetto**, quindi
Anticipay e Mexal non hanno né endpoint né un principal in grado di leggerne uno.
I permission set raggiungono ancora **un utente ciascuno contro 8 utenti attivi**,
quindi gli utenti di business non possono ancora esercitare la UAT.
`OrderItem.Tranche__c` è nullo su **15 righe d'ordine su 15**, da 10 su 10 —
cinque nuove righe sono arrivate senza tranche. Una **funzionalità di prezzo
bundle distribuita a metà** mostra silenziosamente il totale spread invece del
prezzo calcolato, senza errore. E il `build_state` del register cita **`QUO-01` e
`QUO-06`, che non figurano fra i 154 id di requisito**.

### 22.8 🟢 La documentazione API Anticipay è arrivata, con quattro giorni di anticipo

Andrea Parmeggiani ha inviato `Documentazione API – Salesforce.pdf` alle
**16:15Z** ad Aurel Mrruku, in cc Elena Spini, amministrazione, Fabrizio
Paganelli e Sabatino Rinaldi. Era dovuta entro il **4 settembre**: è il primo
impegno del cliente su questo progetto consegnato in anticipo, e trasforma il
follow-up del 1° settembre in una revisione anziché in un sollecito.

⚠ **Il PDF non è stato letto.** Lo sweep notturno non può aprire un allegato
Gmail, quindi il contratto API non è ancora agli atti.

🔴 **Il solo corpo della mail cambia qualcosa.** Per il periodo di test il
middleware **risponde solo dalla cache Pienissimo e non chiama Anticipay**:
_"l'API ritorna i dati solamente se già presenti sul nostro database … alla fine
del test invece inoltreremo le chiamate ad Anticipay e per voi sarà
trasparente."_ Una P.IVA non in cache non restituisce quindi nulla, e un **`404`
in fase di test non è distinguibile da un vero non trovato**: la semantica
d'errore concordata attribuisce al `404` un solo significato e durante i test ne
porta due. Non leggere i tassi di 404 del periodo di test come misura della
copertura Anticipay. Il passaggio al pass-through spetta a Pienissimo Software,
**senza data indicata** e senza alcun segnale a ROMI quando avverrà.
[OI-94](../notes/items/OI-94%20Anticipay%20is%20called%20through%20the%20Pienissimo%20middleware.md) ·
[OI-95](../notes/items/OI-95%20Which%20Anticipay%20fields%20land%20in%20Salesforce.md).

### 22.9 🟢 Finalmente è fissata una sessione marketing

`[PIENISSIMO]- Interna Flussi MKT`, **lunedì 7 settembre 10:00–11:00 CEST**
(invito 31 agosto 16:07Z): Elena Spini, Aurel Mrruku, Fabrizio Mastracci —
interna ROMI, senza cliente. Prima sessione marketing dal 19 agosto, e sede
naturale per `30 vs 60` e per il vincolo di stile testo semplice. ⚠ Entrambi i
punti hanno una dipendenza lato cliente che una riunione interna non può
sciogliere; decidere `30 vs 60` internamente significa che ROMI sceglie al posto
del cliente e va messo a verbale come tale. Non è stata pubblicata alcuna agenda.

## 23. Aggiornamento 01/09/2026 — il contratto API Anticipay, finalmente letto

Nessuna riunione. Aurel Mrruku ha scaricato a mano
`Documentazione API - Salesforce.pdf` alle **12:51 CEST** ed è stato analizzato la
mattina stessa — la richiesta che il §22 indicava come _"la più economica del
registro e la più preziosa"_. Decodifica completa in
[il contratto](../notes/The%20Anticipay%20middleware%20API%20contract.md).

### 23.1 🟢 Ci sono state due versioni, a diciassette ore di distanza

| Versione | Inviata              | Differenza                                                                          |
| -------- | -------------------- | ----------------------------------------------------------------------------------- |
| v1       | **31 ago 16:15:00Z** | il contratto nella prima stesura                                                    |
| v2       | **1 set 10:46:38Z**  | _"Ho aggiunto un parametro `:env` nel path, prevede un valore tra 'test' e 'prod'"_ |

Entrambe da Andrea Parmeggiani, stessi destinatari. **ROMI ha la v2.** Non è
stato costruito nulla, quindi non c'è rilavorazione — ma una specifica che si
muove due volte in diciassette ore, la seconda la mattina stessa della call per
cui era stata scritta, **non è congelata**. Chiedere se sono attese altre
modifiche prima che uno sviluppatore inizi.

### 23.2 Il contratto

`GET https://romi.pienissimo.com/salesforce/account/:env/:piva`, con un
**bearer token nell'header `Authorization`** e nessun corpo nella richiesta.
`:env` accetta `test` o `prod` e precede la partita IVA. Un `200` restituisce
`{ success, status, info }`, dove `info` porta **undici campi stringa**.

🟢 **Gli undici campi coincidono esattamente con il lookup Mexal di
pre-fatturazione as-is** descritto da Elisa Migliano il 6 agosto — ragione
sociale, il blocco indirizzo della sede legale, PEC e il legale rappresentante.
Il middleware **non** è una vista ridotta di una risposta Anticipay più ampia: è
**il servizio che Pienissimo già usa, ri-esposto**. La sua valutazione di quella
banca dati, _"corretta al 99,5%"_, vale quindi sugli stessi dati che Salesforce
leggerà.

### 23.3 🟢 Due cose che il 31 agosto erano deduzioni ora sono specifica

- **La modalità test solo-cache è scritta nel contratto.** Con `env=test` il
  middleware **non effettua alcuna chiamata ad Anticipay** e restituisce `404`
  per ogni azienda non già presente nel database Pienissimo. La lettura tratta
  dal corpo della mail il 31 agosto era corretta, e `404` porta dimostrabilmente
  due significati durante i test — _azienda sconosciuta_ e _non ancora in cache_
  — senza nulla nella risposta che permetta di distinguerli.
- **L'ambiente di test che Pienissimo Software deve dal 25 agosto sembra essere
  `:env`.** Non un deployment separato: un parametro di percorso sullo stesso
  host, dietro lo stesso token, sullo stesso database. Può bastare per una
  lettura da cache. Non è ciò che quella formula significa di norma, e **nessuno
  ha detto che l'azione è chiusa** — chiuderla esplicitamente o ridichiarare cosa
  serve.

### 23.4 🟢 Lo storico errori funziona già — ma due difetti del motore rompono la notifica

La sessione del 25 agosto aveva concordato che il middleware restituisce i codici
di errore **insieme ai loro messaggi descrittivi**, che codice e messaggio vengono
**entrambi conservati in Salesforce per tre mesi** e che il record memorizzato
genera notifiche interne — Aurel Mrruku aveva chiesto esattamente questo perché
esistesse uno storico verificabile.

🟢 **Quello storico esiste e non richiede alcuna progettazione.** È
`Integration_Log__c`, la traccia di audit standard ROMI per le callout, già a
repository: `API_Callout_Engine` scrive lo stato HTTP in `Response_State__c` e il
**corpo grezzo della risposta** in `Response_Body__c` (`LongTextArea(131072)`).
Qualunque forma abbia il corpo di errore, codice e messaggio arrivano entrambi.
⚠ **Una stesura precedente di questa sezione diceva che lo storico non era
costruibile. Era sbagliato** — leggeva l'assenza della specifica del corpo di
errore come un problema di archiviazione, mentre l'archiviazione era già risolta
dallo scaffolding.

🔴 **I difetti veri sono in quel motore, e sono di ROMI.**

1. **`Is_Error__c` non viene mai impostato per un errore HTTP.** Il flag si imposta
   solo se manca il record di configurazione o se viene lanciata un'eccezione
   Apex. Un `404`, `401` o `500` dal middleware è un invio HTTP **riuscito**,
   quindi la riga viene scritta con `Is_Error__c = false` — **la notifica interna
   concordata, costruita nel modo ovvio, resta muta proprio nel caso per cui
   questa integrazione esiste**, e le righe di errore non sono filtrabili.
2. **Un corpo di errore non conforme fa perdere il codice di stato.** Il motore
   deserializza nel wrapper del `200` **prima di controllare lo stato**; se il
   corpo di errore ha una forma diversa la deserializzazione lancia, e il `catch`
   ricostruisce la riga di log **senza `Response_State__c`**. Così un `404` può
   essere registrato come eccezione Apex senza codice HTTP — esattamente l'esito
   che l'accordo del 25 agosto voleva evitare.

Entrambi sono comportamenti generici dello scaffolding, quindi riguardano **anche
Mexal e ogni altra callout in uscita**. Correggerli una volta li corregge ovunque.

⚠ **È per questo che il corpo di errore mancante conta ancora** — per un motivo
molto più circoscritto di "manca lo storico". Un esempio di ciascuna risposta di
errore permette di scrivere il wrapper in modo che tolleri la forma d'errore senza
lanciare. Richiesta piccola, che vale ancora la pena fare ad Andrea Parmeggiani.

⚠ **E i tre mesi di conservazione non hanno alcuna implementazione.** Lo
scaffolding non prevede alcun job di purge. Qualcuno deve scrivere una
cancellazione schedulata, altrimenti "tre mesi" diventa "per sempre" — il che si
intreccia con il §23.5: una lookup **riuscita** registra l'intero corpo della
risposta, quindi i dati personali del legale rappresentante restano in
`Response_Body__c` a prescindere da quali campi vengano mappati sull'Account.

⚠ **Due dei quattro codici sono anche nuovi.** `400` (partita IVA malformata) e
`401` (token non valido) non facevano parte del protocollo del 25 agosto. Sono un
genere diverso di errore — `404` e `500` descrivono l'azienda cercata, `400` e
`401` descrivono **un difetto della chiamata di ROMI**. Il disegno concordato li
mette tutti e quattro in un unico secchio dietro un'unica notifica, quindi **un
deploy rotto o un token ruotato si presenterebbero come una serie di partite IVA
sconosciute**.
[OI-107](../notes/items/OI-107%20The%20Anticipay%20error%20path%20does%20not%20reach%20the%20integration%20log%20intact.md).

### 23.5 🔴 Sei degli undici campi identificano una persona fisica

Del legale rappresentante: **nome e cognome, codice fiscale, data di nascita,
luogo di nascita e indirizzo di residenza**, più una PEC che in una ditta
individuale è spesso l'indirizzo della persona stessa.

Nessuno ha nascosto nulla. La sessione del 25 agosto aveva concordato un payload
_"ridotto ai campi necessari"_ perché Anticipay ne restituisce molti più del
voluto, e tutti i presenti immaginavano ragionevolmente **dati camerali
d'impresa**. L'insieme ridotto risulta essere **in prevalenza dati personali di
qualcuno che non è il contatto cliente e non ha mai interagito con ROMI o
Salesforce**.

Lo scopo dichiarato dell'intera integrazione è _dati puliti spinti verso Mexal_.
`ragione_sociale`, il blocco indirizzo e `pec` lo servono; la data di nascita e
l'indirizzo di casa di un amministratore no. I tre mesi di conservazione
concordati il 25 agosto coprono i **codici di errore**, e per i dati restituiti
non è mai stata dichiarata alcuna conservazione. **Raccomandazione: conservare il
blocco azienda e lasciare non mappati i cinque campi del legale rappresentante** —
offerta perché la scelta dei campi sia fatta con questo in vista, non imposta.
[OI-108](../notes/items/OI-108%20The%20Anticipay%20payload%20carries%20personal%20data%20of%20the%20legale%20rappresentante.md).

### 23.6 🔴 Un unico token statico serve entrambi gli ambienti, ed è stato inviato due volte

Non esiste un secondo token per `test`. Un host, una credenziale, nessuna
rotazione, scadenza o scope descritti da nessuna parte — ed è stato inviato a
**sei indirizzi in due occasioni**, inclusa la casella condivisa
`amministrazione@` e Sabatino Rinaldi, che in questa integrazione non ha alcun
ruolo.

Inviare un token per mail è prassi ordinaria e l'autenticazione volutamente
semplice era stata accettata il 25 agosto; nessuno ha sbagliato. L'unica
conseguenza è che **il token va considerato già divulgato** nel decidere se
ruotarlo prima del go-live — e che con una sola credenziale non esiste
compartimentazione: un token trafugato da una sandbox chiama `env=prod`, che dopo
lo switch al pass-through **spende denaro da Anticipay a ogni lookup**, proprio
il controllo dei costi che era l'argomento fondativo di Andrea Parmeggiani per il
middleware.
[OI-106](../notes/items/OI-106%20One%20static%20bearer%20token%20serves%20both%20Anticipay%20environments.md).

⚠ ROMI deve a Pienissimo un token nella direzione opposta per l'endpoint
WooCommerce ([OI-102](../notes/items/OI-102%20Salesforce%20endpoint%20and%20token%20for%20the%20WooCommerce%20plugin.md)),
dove il §22 ha trovato che la classe ricevente non ha alcuna autenticazione
applicativa. Due integrazioni, due segreti statici condivisi, entrambi
distribuiti per mail — merita **una** decisione su come questo progetto gestisce
le credenziali.

### 23.7 ⚠ Un refuso nel formato del filo, e due risposte che il #95 non si aspettava

La data di nascita viene restituita come
**`data_di_dascita_legale_rappresentante`** — `dascita`, non `nascita` — identica
sia nell'esempio sia nella tabella dei campi, quindi è il formato del filo e non
un refuso del documento. Se Pienissimo lo corregge senza dirlo dopo che ROMI ci
ha scritto codice contro, **la data di nascita diventa silenziosamente null su un
`200 OK`**, senza errore e senza notifica, e con la regola di sovrascrittura
concordata un null può sovrascrivere un valore buono. Correggerlo subito o
congelarlo per iscritto.
[OI-105](../notes/items/OI-105%20The%20Anticipay%20date%20of%20birth%20field%20name%20is%20misspelled.md).

Due candidati nominati il 25 agosto **non sono affatto disponibili**:

- lo **score di affidabilità Anticipay** su cui aveva chiesto Fabrizio Paganelli
  **non viene restituito** — volerlo è ora una change request a Pienissimo
  Software, e farebbe di questo un flusso di rischio di credito e non una visura;
- nemmeno **`rappresentante fiscale`** viene restituito. Il documento restituisce
  `legale rappresentante`, che è un ruolo diverso. Verificare se quel giorno i
  termini fossero stati usati in modo approssimativo.

**`pec` invece c'è**, come il §22 aveva previsto.

### 23.8 ⚠ Non è costruito nulla, e nove degli undici campi non hanno dove atterrare

`force-app/` non contiene **alcun client Anticipay, alcuna callout e alcun flusso
di verifica P.IVA** — solo `Account.Partita_IVA__c` e `Lead.Partita_IVA__c`,
entrambi `Text(32)`, **né univoci né external id**.
`Integration_Configuration__c` ha la forma giusta (`Endpoint_Host__c`,
`Endpoint_Path__c`, `Token__c`, `Timeout__c`) ma **zero record e zero permessi di
oggetto**; e la sua separazione `Named_Credential_Prod__c` / `_Sandbox__c`
presuppone due host, mentre questa API ha un host e un segmento di percorso.
`:env` va in `Endpoint_Path__c`.

Account ha **tre campi custom in tutto**. `ragione_sociale` si mappa su `Name` e
il blocco indirizzo sull'indirizzo di fatturazione standard, quindi quelli sono
gratis — ma **la PEC e tutti e cinque i campi del legale rappresentante non hanno
casa nell'org**, e crearli, esporli e proteggerli è lavoro non stimato che segue
la decisione del #95 anziché precederla.

Non documentati e mai chiesti da nessuno: **rate limit, timeout, politica di
retry e TTL della cache**. Il pulsante di riverifica manuale concordato in
[OI-73](../notes/items/OI-73%20VAT%20validation%20moves%20into%20Salesforce.md)
**non ha alcun bypass documentato della cache**, quindi potrebbe restituire la
stessa risposta obsoleta da cui lo si premeva per uscire.

### 23.9 ⚠ La call del 1 settembre si è tenuta, e questo recap non ne ha letto il verbale

Il follow-up **si è svolto**: l'evento a calendario porta una **registrazione
delle 10:02 CEST** e un documento di appunti Gemini. Era stato fissato come
annullabile se il materiale non avesse sollevato domande.

⚠ Si noti l'ordine: **la v2 della documentazione è arrivata alle 12:46 CEST, dopo
la fine della call alle 11:00.** Il parametro `:env` è quindi plausibilmente un
esito della sessione, non qualcosa che la sessione aveva davanti.

**Tutto il §23 deriva dal documento, non da quella riunione.** Le sei domande qui
sotto sono ciò che la specifica solleva; **diverse potrebbero già aver avuto
risposta in riunione.** Sono registrate perché il verbale possa essere verificato
rispetto ad esse — non come agenda, e non come elenco da inviare a qualcuno:

1. **Il corpo della risposta di errore** — un esempio per codice, esattamente
   come emesso. ⚠ Non è più un blocco (§23.4): serve a far tollerare al wrapper
   la forma d'errore, non a sbloccare lo storico.
2. **Una data da Fabrizio Paganelli ed Elisa Migliano** su quali campi Salesforce
   conserva. Il punto è loro dal 25 agosto senza una data; hanno l'elenco dal 31
   agosto e sono entrambi sul thread.
3. **Il token** — uno o due, ruota, si può ruotare prima del go-live.
4. **La data in cui `env=test` diventa pass-through**, e come ROMI ne viene
   informata.
5. **Il refuso `dascita`** — correggere o congelare.
6. **Rate limit, timeout e TTL della cache**, incluso come il pulsante di
   riverifica forza un aggiornamento.

⚠ **La questione societaria non è toccata da nulla di tutto ciò.** Un'integrazione
di Fase 1 dipende ancora dal fatto che Pienissimo Software Srl costruisca, ospiti
e mantenga un servizio, e il documento — che è loro — non dice chi ne possiede
l'uptime dopo la chiusura del progetto. **Leggere una specifica non equivale ad
avere un impegno.**

🔴 **Lo sviluppo della Fase 1 deve chiudersi il 10 settembre** — sette giorni
lavorativi da adesso, e i punti 1 e 2 sono ciò che la build aspetta.

🔴 **Il passo successivo è analizzare il verbale del 1 settembre**, non inviare
domande. Finché la registrazione e gli appunti Gemini non sono letti, nessuno sa
quali dei sei punti siano ancora aperti.

## 24. Aggiornamento 01/09/2026 (sera) — la call di follow-up, analizzata la sera stessa

L'indicazione con cui si chiudeva il §23 era di analizzare il verbale del
1 settembre prima di sollecitare qualsiasi cosa. **È stato fatto.** Appunti
Gemini, trascrizione integrale e registrazione sono stati letti tutti la sera del
1 settembre. La call è durata ~20 minuti dalle 10:02 CEST con Elena Spini, Aurel
Mrruku (ROMI), Andrea Parmeggiani (Pienissimo Software) ed Elisa Migliano.
Fabrizio Paganelli era invitato e viene interpellato due volte in riunione ma non
interviene mai; la sua presenza resta incerta.

### 24.1 🟢 La selezione dei campi è decisa, e la risposta è "tutti"

**Il #95 è risolto.** L'azione che Fabrizio Paganelli ed Elisa Migliano
detenevano **senza data dal 25 agosto** — per la quale tre sweep consecutivi
raccomandavano di sollecitare una data — è stata assolta in riunione. Aurel
Mrruku ha percorso il punto 6 della documentazione campo per campo e **tutti e
undici i campi sono stati presi**.

| Campo                                    | Destinazione                                                 |
| ---------------------------------------- | ------------------------------------------------------------ |
| `ragione_sociale`                        | `Account.Name`                                               |
| `indirizzo`, `citta`, `provincia`, `cap` | il blocco indirizzo di fatturazione standard                 |
| `pec`                                    | **un nuovo campo dedicato sull'Account**                     |
| `nome_legale_rappresentante`             | **un nuovo campo di testo sull'Account**                     |
| `codice_fiscale_legale_rappresentante`   | **un nuovo campo sull'Account**                              |
| `data_di_dascita_legale_rappresentante`  | **un nuovo campo sull'Account**, refuso della chiave incluso |
| `luogo_nascita_legale_rappresentante`    | **un nuovo campo sull'Account**                              |
| `indirizzo_legale_rappresentante`        | **un unico campo di testo**, non un indirizzo strutturato    |

Dentro quella decisione stanno due scelte di struttura:

- **Il legale rappresentante va sull'Account, non su un Contact.** Aurel Mrruku
  aveva proposto un record Contact tipizzato; Elisa Migliano ha deciso
  diversamente, perché il dato è _"fondamentale per la firma dei contratti"_. Lui
  ha accettato mettendo però a verbale una riserva: campi piatti sull'Account non
  conservano storico, e il cambio di un amministratore è un evento ordinario.
- **L'indirizzo della persona è un unico campo di testo.** Andrea Parmeggiani:
  _"non è importante che salviamo il CAP del legale rappresentante"_. Si noti
  l'asimmetria: l'indirizzo **aziendale** è strutturato, quello **personale** no.

🔴 **Questo sblocca la build della verifica P.IVA (#73) e insieme impegna sei
campi di lavoro non stimato** — creazione, layout e field-level security — a nove
giorni dalla fine dello sviluppo Fase 1 del 10 settembre.

### 24.2 🟢 La suddivisione degli ambienti è nata in questa call, e il token unico è deliberato

Aurel Mrruku ha proposto **due path distinti**, così che il test continuativo non
tocchi mai la produzione. Andrea Parmeggiani ha acconsentito seduta stante —
_"facciamo due path diversi"_ — e ha inviato i path definitivi **2,5 ore dopo**.
Quella è la v2 della documentazione, e chiude la domanda aperta nel §23: il
parametro `:env` è un **esito** di questa sessione, confermato e non più dedotto.

Sul token, la domanda del **#106** è stata posta esplicitamente e ha avuto
risposta:

> **Aurel Mrruku:** _"si può usare anche lo stesso token perché praticamente
> l'ambiente è lo stesso?"_ — **Andrea Parmeggiani:** _"sì, sì."_

**Due path, un token, per scelta.** La motivazione è coerente — i due ambienti
condividono il database — e trasforma il #106 da lacuna non notata in una
decisione presa consapevolmente da entrambe le parti. Assolve inoltre l'azione
sull'ambiente di test del 25 agosto nel modo più esplicito che questo progetto
otterrà. 🔴 Resta aperto, in forma più circoscritta: **la rotazione prima del
go-live**, nel presupposto che un valore inviato a sei indirizzi sia già
divulgato. Rotazione e scadenza non sono state discusse affatto.

Definiti anche: l'**ambiente di test è gratuito e senza limiti** (_"non ci sono
costi, possiamo fare chiamate a piacere"_), la **produzione ha configurazione
identica** salvo l'inoltro ad Anticipay, e l'**happy path è `200`**, confermato a
voce.

### 24.3 🔴 Anticipay copre solo aziende italiane — e questo risponde a un requisito

Andrea Parmeggiani, spontaneamente e di sfuggita:

> _"Diamo per scontato che la richiesta facciamo solo per aziende italiane perché
> Anticipay dà i dati solo per aziende italiane. Quindi la nazione non l'ho
> inserita perché è scontato che sia Italia, altrimenti torna sempre non
> trovato."_

Dunque `nazione` è **deliberatamente assente** dal payload, e **una P.IVA non
italiana restituisce sempre `404`** — lo stesso codice di un'azienda italiana
sconosciuta e, durante il periodo di test, lo stesso codice di una cache fredda.
**Tre significati distinti su un solo status code**, contro un protocollo
concordato che al `404` assegna un significato e una notifica.

⚠ `INT-18` recita _"Anticipay VAT check timing and **foreign-VAT handling**"_. La
parte sulle P.IVA estere non è rinviata alla fase 2 — **non è realizzabile
attraverso questa integrazione in nessuna fase**. Nessuno in riunione ha collegato
l'osservazione al requisito. Questo acuisce la contraddizione già registrata nel
§23: `INT-18` necessita ora di una correzione di **ambito** oltre che di **fase**,
ed entrambe sono modifiche a un documento firmato. Resta a Elena Spini sollevarla.

### 24.4 Ciò che la call non ha toccato

Quattro delle sei domande derivate nel §23 **non sono mai state poste**:

| Domanda                              | Dopo la call                                                     |
| ------------------------------------ | ---------------------------------------------------------------- |
| Il **body delle risposte di errore** | 🔴 ancora aperto — l'ultimo blocco tecnico alla build            |
| Quali campi, e con che data          | 🟢 chiusa — tutti e undici, sopra                                |
| Il token — uno o due                 | 🟢 chiusa — uno, deliberatamente                                 |
| La data in cui `env=test` inoltra    | 🔴 ancora aperta, mai menzionata                                 |
| Il refuso `dascita` (#105)           | 🔴 ancora aperto — e la sua via d'uscita si è chiusa             |
| Limiti di chiamata, timeout, TTL     | ⚠ a metà — il test è gratuito e illimitato; **la produzione no** |

**Sollecitare tre cose, non sei.** Riproporre le due chiuse costerebbe
credibilità.

Sul **#105**: la nota sosteneva che il refuso potesse chiudersi da sé se la data
di nascita fosse stata scartata. Viene memorizzata, e nessuno ha guardato i nomi
delle chiavi — quindi il punto resta, più urgente di quando è stato scritto.
Indicazione pratica nel frattempo: **sviluppare sulla chiave errata come
documentata, mantenendo corretto il nome del campo Salesforce**, così che una
correzione futura costi una riga di mappatura e non una rinomina in org.

### 24.5 🔴 La questione dei dati personali non è stata sollevata, e la decisione è andata in senso opposto

Il **#108** raccomandava di conservare il blocco aziendale e scartare quello
personale. La riunione ha portato tutti e cinque i campi del legale
rappresentante sull'Account.

⚠ **Non è un rifiuto.** La domanda non è mai stata posta nei venti minuti;
registrarla come "valutata e respinta" sarebbe falso.

🟢 **Un campo ha ora una finalità a verbale** — la prima che il record possieda.
Elisa Migliano: il legale rappresentante è _"fondamentale per la firma dei
contratti"_. Questo giustifica chiaramente **il nome**.

🔴 **Non giustifica gli altri quattro.** Firmare un contratto richiede di
identificare il firmatario; non è evidente perché richieda **data di nascita,
luogo di nascita, codice fiscale e indirizzo di residenza** del firmatario, e
nessuno di questi ha avuto una motivazione puntuale. Conservazione, base
giuridica, **field-level security** — i campi vanno sull'Account, letto
abitualmente dall'amministrazione Pienissimo, esattamente l'esposizione segnalata
dal #108 — e cancellazione non sono stati menzionati.

La richiesta rivista è piccola: **cinque minuti alla call sul data model**, una
frase di finalità per ogni campo personale, e un tempo di conservazione.

### 24.6 Novità emerse dalla call

- **#109 — il codice destinatario SDI.** Elisa Migliano ha chiesto se il
  middleware possa restituirlo: un **dodicesimo** campo, non presente nel
  contratto documentato. Ha detto lei stessa che non è critico (le fatture vanno
  via PEC), ma su Mexal c'è _"una valanga di clienti dove lo SDI non è
  valorizzato"_, il che ne fa un guadagno di qualità del dato sull'anagrafica
  as-is. ⚠ La prima impressione di Andrea Parmeggiani è che **non sia
  disponibile**. Non deve ritardare gli undici.
- **Una call sul data model, dovuta da Elena Spini, senza data.** L'ha chiesta
  esplicitamente — _"ancora non abbiamo ricevuto niente"_ — ed Elisa Migliano vi
  ha subito rinviato altro materiale, nominando il **tipo fatturazione
  elettronica**. È la sede naturale per il workbook dovuto da luglio e per il
  §24.5.
- 🔴 **Un'azione senza collocazione: spegnere la chiamata di test al go-live.**
  L'ha sollevata Aurel Mrruku stesso, poiché due configurazioni identiche
  rischiano di far partire lookup di produzione a pagamento dalla corsia di test.
  _"Lo mettiamo nei punti da tracciare."_ È tracciata nella nota di riunione e in
  nessun altro luogo.

### 24.7 L'anagrafica articoli si è mossa, e il materiale non è stato letto

Indipendentemente dalla call, **Fabrizio Paganelli ha inviato `Anagrafica
Articoli.xlsx` il 01/09 alle 14:04Z** a Elena Spini, Aurel Mrruku e Andrea Di
Cicco, per la sessione **2 settembre** _Follow-up Anagrafica Articoli_: un
estratto dell'anagrafica articoli **con i soli corsi**, più _"una ipotesi di
nuovi codici da gestire solo nei bundle"_ e _"un paio di domande"_ rivolte a ROMI
per un parere.

🟢 È il primo materiale lato cliente sul **#48** dal 26 agosto e il primo esito
tangibile della ricreazione dell'anagrafica (**#98**).

🔴 **Non è stato letto** — una scansione automatica non può aprire un allegato
Gmail — quindi non si conosce nulla oltre il corpo della mail: né il numero di
codici, né la convenzione, né se corrisponda allo schema gemello A/B che
Fabrizio Paganelli stesso aveva nominato, né quali siano le sue domande. ⚠ È un
**estratto**, e la formulazione non dice se si tratti dei codici **nuovi** o di
quelli **attuali** in revisione.

**È la terza volta che questa stessa lacuna costa una giornata**, dopo il payload
WooCommerce del 27 agosto e il PDF delle API del 31 agosto — entrambi i quali,
una volta aperti a mano, hanno prodotto scoperte che nessuna inferenza aveva
generato. **Serve prima della riunione del 2 settembre, non dopo.**

## 25. Aggiornamento 02/09/2026 — verifica sull'org UAT Pienissimo

> ⚠ **Questa sezione registra soltanto lo STATO DEL BUILD.** Supera le
> affermazioni delle sezioni precedenti su ciò che **esiste** nell'org. Non
> supera il record di ciò che è stato **concordato**: una decisione resta presa
> anche dove l'implementazione la contraddice.

Verifica in sola lettura sull'org **Pienissimo UAT** (`00DMA000004nMMr2AM`,
sandbox parziale, API 68.0) del **02/09/2026, 08:05–08:14Z**, confrontata con
`force-app/` su `DevMain` al commit `4a49376`. 165 componenti del repository
contro 1.072 componenti dell'org. Metodo: listing Metadata API su 20 tipi di
componente, Tooling `FieldDefinition`, `FieldPermissions`, `ObjectPermissions`,
`ApexCodeCoverageAggregate`, `ApexTestRunResult`, `FlowDefinitionView`,
`PermissionSetAssignment` e query aggregate mirate.

Supera il §22 e il §19 sullo stato del build.

### 25.1 🟢 Tutto ciò che è nel repository è deployato, e la collisione WooCommerce è risolta

**Tutti e 30 i componenti di progetto presenti in `force-app/` esistono
nell'org.** Nessuna divergenza "solo repository" sui metadati di progetto.

La collisione di rotta segnalata al §22 è **risolta su entrambi i lati**:

|                            | 31 agosto                                   | 2 settembre                    |
| -------------------------- | ------------------------------------------- | ------------------------------ |
| `WooCommerceOrderEndpoint` | nel repository, non deployata               | **rimossa da entrambi i lati** |
| `WoocommerceOrderService`  | deployata, **non** in controllo di versione | **deployata e committata**     |
| Rotte REST dichiarate      | 2 classi, 1 rotta                           | **1 classe, 1 rotta**          |

Il corpo della classe deployata è stato riletto e confrontato con il file
committato: normalizzando i fine riga, i due sono **identici**. La differenza di
848 caratteri corrisponde esattamente allo scarto CRLF/LF sulle ~848 righe del
file. Un deploy pulito ora pubblica la classe che è già in esecuzione.

⚠ È al sicuro dal _deploy_, non per il resto completa: **`INT-16` è ancora priva
di autenticazione**, quindi il token di header che ROMI deve fornire resta
l'unica autenticazione.

### 25.2 🔴 Gli undici campi Anticipay non sono costruiti

`OI-95` è stato chiuso il 1º settembre proprio perché questo lavoro potesse
partire. `Account` porta **tre** campi personalizzati — `Lead_Email__c`,
`Nome_Locale__c`, `Partita_IVA__c`. **Nessuna PEC, nessuno dei cinque campi del
legale rappresentante, nessun indirizzo del rappresentante.** Assenza dimostrata
con Tooling `FieldDefinition`, che non è filtrata dalla field-level security.

**Lo sviluppo di Fase 1 termina il 10 settembre.** I campi sono costruibili
oggi: non richiedono endpoint, token né altre risposte dal cliente. Ciò che è
bloccato è la chiamata e la gestione degli errori, non lo schema.

### 25.3 🔴 L'org non ha alcun Flow di progetto, e uno di essi non è mai stato versionato

Verificato in due modi indipendenti, perché un elenco vuoto non è una prova: la
lista `Flow` della Metadata API è vuota, e `FlowDefinitionView` restituisce
**79** flow, **nessuno dei quali privo di namespace**.

`Lead_Non_Risponde_Follow_Up` è stato aggiunto il 27 agosto ed eliminato il
31 agosto, con un messaggio di commit che lo dichiara: scelta deliberata e
**recuperabile da git**. Ma la verifica del 28 agosto registrava **due** Flow, e
`git log --all` dimostra che in questo repository è esistito **un solo** file di
flow. Il secondo era presente solo nell'org, ora non c'è più, e **nessun
documento superstite ne riporta il nome**.

Non risulta che sia andato perso nulla di valore. Il punto è che il progetto non
può saperlo: è la terza perdita "solo org" in sei giorni.

### 25.4 🔴 Due named credential esistono solo nell'org

`Anticipay` e `DocuSign` sono configurate nell'org e non esistono in **nessun
branch** di questo repository, così come i permission set `DocuSign`,
`Full_Permission` e `Sales_User`.

Una named credential è il luogo in cui risiedono l'endpoint e l'autenticazione.
Perderne una non produce errori di compilazione né segnalazioni di componente
mancante: la chiamata semplicemente fallisce a runtime. Un refresh della sandbox
porta via sia la credenziale sia l'unica traccia di come era configurata.

### 25.5 L'impianto di integrazione è invariato, e ora blocca un lavoro con una data

|                                         | 26 agosto | 2 settembre |
| --------------------------------------- | --------- | ----------- |
| Righe di `Integration_Configuration__c` | 0         | **0**       |
| Suoi permessi di oggetto                | 0         | **0**       |
| Righe di `Integration_Log__c`           | 0         | **21**      |
| Remote site setting                     | 0         | **0**       |

Le righe di log sono traffico reale, ma provengono dall'endpoint WooCommerce
**in ingresso**, che non usa questo impianto. **Nulla in uscita è mai stato
eseguito.** `Integration_Configuration__c` ha ancora zero permessi di oggetto:
nessun utente potrà leggerlo nemmeno quando esisterà una riga.

### 25.6 Copertura: il dato non è misurato, non è misurato a zero

`ApexCodeCoverageAggregate` riporta **0 coperte, 1.646 non coperte, 0%**, in
crescita dalle 1.571 del 31 agosto man mano che il codice arriva. Contro la
soglia del 75%, **nulla può andare in produzione: invariato e ancora
bloccante.**

Ma il dato è stato letto troppo alla lettera. **L'ultima esecuzione dei test
Apex in questo org è del 04/08/2026** — 10 metodi, **0 falliti** — mentre le
classi sono cambiate di continuo fino al 31 agosto. L'aggregato viene popolato
solo da un'esecuzione dei test e viene invalidato quando le classi vengono
ricompilate: lo 0% memorizzato non misura nulla del codice attuale.

**Tre classi di test di progetto sono deployate** e all'ultima esecuzione
registrata passavano. Questo non significa che la copertura sia adeguata — tre
classi di test contro 1.646 righe non raggiungono il 75%. Significa che **oggi
nessuno conosce il valore reale**. Nessun test è stato eseguito, scritto o
proposto.

### 25.7 🟢 L'accesso all'org è ripristinato, e 🔴 l'UAT resta inutilizzabile

Il blocco del 1º settembre non si ripresenta: la verifica si è autenticata e ha
completato l'inventario senza alcun errore di autenticazione, e Aurel Mrruku lo
ha confermato direttamente.

Ma **ogni permission set di progetto raggiunge esattamente un utente attivo** su
**8** utenti attivi, invariato dal 28 agosto. Gli utenti di business non possono
eseguire l'UAT.

### 25.8 Verificato inoltre

- **`Biglietto__c` è confermato assente.** Asset contiene **5** record, non 41:
  il set di 37 record **non è stato migrato**. Asset porta 8 campi
  personalizzati e un record type Ticket; la ricostruzione non è iniziata.
- 🟢 **`OrderItem.Tranche__c` è ora concesso** in lettura e scrittura a
  `Tranche_Management`, chiudendo il blocco del 26 agosto. **La propagazione
  resta non costruita**: 0 righe d'ordine su 18 portano una tranche.
- 🟢 **Il ciclo di vita dell'ordine è attivo e in uso** — `Incassato` su 12
  ordini su 15, e `Order` porta 3 campi personalizzati. Questo corregge il §19,
  che registrava lo stato ordine come standard e l'oggetto senza campi
  personalizzati.
- ⚠ **Record fermi su valori disattivati, ora su due oggetti**: 3 preventivi su
  10 (`Accepted` ×2, `Needs Review` ×1) e 3 ordini su 15 (`Activated` ×2,
  `Draft` ×1). Un record su un valore disattivato non può essere risalvato senza
  essere prima spostato.

### 25.9 Due difetti nel record stesso, entrambi corretti

**Il registro citava id di requisito inesistenti.** Il blocco dello stato del
build faceva riferimento a `QUO-01` (quattro volte) e `QUO-06`: fra i 154 id di
requisito non esiste alcun prefisso `QUO-`, l'area commerciale usa `SAL-`. Dove
il testo della voce nomina direttamente un requisito ora si cita `SAL-08` e
`SAL-09`; le voci che osservano la **macchina a stati** del preventivo portano
`state_machine: quote` e nessun riferimento, perché il registro non ha un id per
essa. La validazione stretta ora passa.

**L'inventario della verifica stessa riportava zero template email, e
sbagliava.** `listMetadata` della Metadata API non può enumerare i tipi
organizzati in cartelle senza che se ne indichi una: ha quindi restituito una
lista `EmailTemplate` vuota senza segnalare alcuna indisponibilità. Una query
SOQL dimostra che esistono **88** template, incluso `WooCommerce_Checkout_Link`
del progetto, attivo. L'affermazione del §19 secondo cui l'org aveva "zero …
EmailTemplate" si fondava su questo artefatto ed è **ritirata**.

> Un risultato vuoto restituito da uno strumento che non è in grado di enumerare
> ciò che si cerca non è un'assenza. È un silenzio.

## 26. Aggiornamento 02/09/2026 — l'endpoint Anticipay è cambiato, e ora funziona

La terza revisione della documentazione API in tre giorni, e la prima volta che
qualcosa su questa integrazione viene **dimostrato anziché letto**.

### 26.1 🟢 Cosa è successo, in due ore

| Ora (UTC)    | Evento                                                                                                                      |
| ------------ | --------------------------------------------------------------------------------------------------------------------------- |
| **08:21:59** | Aurel Mrruku segnala che l'host **non si risolve**: `HTTP/1.1 404 Not Found`, `Content-Type: text/html; charset=iso-8859-1` |
| **10:18:26** | Andrea Parmeggiani: _"Ho impostato un nuovo terzo livello: romi.pienissimo.com"_ — **v3** in allegato                       |
| **10:40:45** | Aurel Mrruku: _"Confermo che adesso funziona."_                                                                             |

Quindi **`integration.pienissimo.com`, l'host della v1 e della v2, non ha mai
funzionato.** Tutto ciò che è stato scritto su questa API prima di oggi si
basava su un documento che descriveva un endpoint inesistente. Il nuovo host è
**`romi.pienissimo.com`** ed è stato provato da ROMI.

Due ore dalla segnalazione alla correzione confermata. È la seconda volta che
questa controparte chiude qualcosa in una mattinata, e va registrato accanto ai
fallimenti.

### 26.2 La v3 cambia l'host e nient'altro

Verificato confrontando con un diff il testo estratto della v2 e della v3 — non
dedotto dal corpo della mail. **Differiscono due righe**, entrambe con
l'hostname. Tutto il resto è identico byte per byte, il che significa che quanto
segue **è sopravvissuto a una terza revisione senza modifiche**:

- il **refuso `data_di_dascita_legale_rappresentante`** (§23.7, OI-105) — tre
  revisioni, ancora lì, perché **nessuno l'ha chiesto**
- il **corpo della risposta di errore, del tutto assente** (§23.4, OI-107)
- la descrizione del `404` che nomina ancora **Salesforce** come sistema cercato
- **il bearer token** — la stessa stringa dal 31 agosto, ora inviata quattro volte

### 26.3 🔴 La raggiungibilità non è il contratto

Una chiamata confermata non è un'integrazione funzionante. **Nessuna lookup è
mai stata eseguita**: nessuno ha mai osservato un `200`, un `404` o un corpo di
errore. Ciò che è dimostrato è che l'hostname si risolve e il TLS termina. Tutto
ciò che riguarda il payload resta una lettura di un PDF.

### 26.4 🔴 L'host morto ha prodotto un rilievo che vale più della correzione

Il guasto che Aurel Mrruku ha incontrato a mano è esattamente quello che il
motore di callout di casa gestisce peggio.

Un `404` in HTML da un hostname sbagliato dà al `404` un **terzo significato**,
oltre a _P.IVA sconosciuta_ e _non in cache con `env=test`_:

| `404` perché                              | Corpo                                        | Distinguibile da           |
| ----------------------------------------- | -------------------------------------------- | -------------------------- |
| la P.IVA è davvero sconosciuta            | la forma d'errore dell'API (non documentata) | —                          |
| `env=test` e l'azienda non è in cache     | come sopra                                   | **nulla**                  |
| **l'endpoint è sbagliato o l'host è giù** | `text/html`                                  | **solo il `Content-Type`** |

Seguendolo dentro `API_Callout_Engine`: l'invio riesce, `Is_Error__c` non viene
mai impostato (§23.4 difetto 1), `deserializeResponse` prova a interpretare
**HTML come JSON**, lancia, e il `catch` ricostruisce la riga di log **senza
`Response_State__c`** (difetto 2). **Un endpoint completamente morto verrebbe
registrato come un errore di parsing Apex senza stato HTTP e senza flag di
errore** — qualcosa che somiglia a un bug di codice Salesforce, non a
un'interruzione.

Aurel Mrruku l'ha diagnosticato in pochi secondi perché era in un client di
posta. Attraverso il motore così com'è, sarebbe stato invisibile. **Questo alza
la priorità della correzione "controllare lo stato prima di deserializzare"**,
che finora era codice difensivo contro una forma che nessuno aveva visto.

### 26.5 ⚠ Il named credential `Anticipay` nell'org precede lo spostamento

La verifica org del 2 settembre (§25) ha trovato un named credential `Anticipay`
configurato nell'org e in **nessun branch di questo repository** — alle
**08:05–08:14Z**, cioè _prima_ che il nuovo host esistesse e _prima_ che Aurel
Mrruku avesse persino segnalato morto il vecchio.

È stato quindi creato contro l'unico hostname disponibile: quello che non ha mai
funzionato. **Con ogni probabilità contiene `integration.pienissimo.com`.**
Essendo solo nell'org non esiste diff, revisione o deploy che lo farebbe
emergere; fallisce semplicemente a runtime, con il `404` in HTML descritto sopra.

**Verificarlo in Setup prima di collegarci qualsiasi cosa**, e correggere l'host
nell'ambito del retrieve che il §25 già richiede. ⚠ Leggere solo l'endpoint — il
token non va copiato da nessuna parte.

### 26.6 Dove lascia la build

🔴 **Restano otto giorni al 10 settembre, e gli undici campi concordati il
1 settembre non sono ancora costruiti.** Il funzionamento dell'endpoint toglie
una scusa, non un blocco — la costruzione dei campi non ha mai avuto bisogno di
un endpoint o di un token. Resta il lavoro sbloccato più economico del progetto.

Due piccole richieste sono ormai in ritardo e vanno in **una sola** mail ad
Andrea Parmeggiani: **un esempio di ciascuna risposta di errore** e **il refuso
`dascita`** — correggere o congelare. Ha revisionato la documentazione tre volte
in tre giorni; non c'è motivo di pensare che una quarta sia difficile.
