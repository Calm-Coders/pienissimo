# ROMI-PIENISSIMO — Recap di Sviluppo Salesforce

> Consolidato dalle 8 riunioni tracciate (27/05/2026 → 23/07/2026), **vince la decisione più recente**. Ogni voce cita la riunione di origine. Legenda stato: ✅ DECISO · 🟡 CONDIZIONATO (deciso, in attesa di una verifica) · 🔴 APERTO (blocca la build — vedi §9).
> ⚠ **Precedenza, dal più recente: §45 → §44 → §43 → §42 → §41 → §40 → §39 → §38 → §37 → §36 → §35 → §34 → §33 → §32 → §31 → §30 → §29 → §28 → §27 → §26 → §25 → §24 → §23 → §22 → §21 → §20 → §19 → §18 → §17 → §16 → §15 → §14 → §13 → §12 → [§11](#11-aggiornamento-06082026--sessione-di-chiusura-dei-punti-aperti) → [§10](#10-aggiornamento-03082026--sweep-multi-sorgente) → §1–§9.** §45 è la sezione di STATO DELLA BUILD più recente (23/09, Pienissimo UAT); §17, §19, §22, §25, §31, §36 e §45 sono tutte verifiche di stato della build e la più recente prevale su ciò che **esiste**, mai su ciò che è stato **concordato**.
> I §1–§9 sono aggiornati al 23/07/2026; il §10 porta il delta 24/07 → 03/08; il §11 la sessione del 06/08; il §12 lo sweep del 14/08; il §13 il file prodotti del 24/08; il §15 la scelta dell'Asset standard; il §16 le quattro riunioni recuperate il 24/08. **Il §14 è la decisione diretta di Aurel Mrruku sulle tranche e supera ogni formulazione precedente che le faceva nascere dalle righe d'Ordine o dai codici `BLO-`.** **Il §17, il §19, il §22 e il §25 sono verifiche dello stato del build sull'org UAT, del 25/08, 26/08, 31/08 e 02/09: dove contraddicono una sezione precedente su ciò che _esiste_, vince la più recente; dove una sezione precedente registra ciò che è stato _concordato_, quella sezione resta valida. Il §19 corregge integralmente una constatazione del §17; il §25 ritira l'affermazione del §19 secondo cui l'org non aveva template email — lo strumento non era in grado di vederli.** Il §18 è la call tecnica Anticipay del 25/08; il §20 la review Mexal del 26/08; il §21 l'integrazione WooCommerce del 27/08; il §23 e il §24 il contratto API Anticipay e la call di follow-up del 01/09. **Il §36 (14/09) è la verifica dello stato del build più recente: dove contraddice una sezione precedente su ciò che _esiste_, vince il §36; ritira ogni affermazione “zero righe” su `Integration_Configuration2__c` dal §25 al §35.** Il §26 e il §27 sono l'endpoint Anticipay e la sessione Anagrafica Articoli del 02/09; il §28 e il §29 il Data Model Parte 1 e 2; il §30 le tre sessioni del 07/09; il §31 la verifica org dell'08/09; il §32 e il §33 il 09/09; il §34 e il §35 il primo Apex Mexal del 10/09 e la scrittura Mexal dell'11/09.
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

## 27. Aggiornamento 02/09/2026 (sera) — la sessione Anagrafica Articoli, analizzata dalla trascrizione

La sessione cliente del 2 settembre era stata annotata la mattina stessa dalle
sole note Gemini, e quella nota dichiarava già nella prima riga che l'analisi
completa restava da fare. **Il documento Gemini, con la trascrizione integrale di
1h16m37s, è diventato leggibile su Drive alle 10:36Z** ed è stato letto per
intero dallo sweep notturno. Questa sezione è ciò che la trascrizione aggiunge.

Presenti: **Elisa Migliano e Fabrizio Paganelli insieme nella stessa stanza** —
lui partecipa e non parla nella registrazione — con Andrea Di Cicco, Aurel
Mrruku ed Elena Spini, collegatasi qualche minuto dopo.

### 27.1 Le due domande con cui il cliente si è presentato

La mail del 1 settembre annunciava _"un paio di domande"_ che non erano né nella
mail né nel file, e il registro le portava come ignote. **Sono state poste a voce
all'inizio della call ed entrambe hanno avuto risposta.**

1. **_"vale la pena di impegnare un campo di mexal per solo 15 codici
   articolo?"_** — **No.** `Tipo biglietto` diventa un campo solo Salesforce,
   modificabile dai soli amministratori di sistema, e il menù dell'anagrafica
   prodotti deve essere visibile _"esclusivamente all'account
   amministrazione@pienissimo.com"_. Cade così anche la doppia codifica
   concordata il 26 agosto, che avrebbe compresso due classificazioni in un solo
   campo Mexal.
2. **_"prezzo di listino sui ci metto zero, dico bene?"_** — **No.** I codici
   solo-bundle mantengono il prezzo di listino reale; il prezzo specifico si
   definisce quando l'articolo viene agganciato al bundle. È lo stesso meccanismo
   chiesto dalla richiesta di modifica aperta `OI-93`, che risulta così allineata
   per la prima volta — anche se nessuno in riunione sembrava sapere che quella
   richiesta esistesse.

⚠ **Correzione di paternità.** Il file è arrivato dall'indirizzo di Fabrizio
Paganelli e il registro lo attribuiva a lui. Nella registrazione **Elisa Migliano
dice di averlo fatto lei**: _"questo qui è un file che ho fatto io a mano."_ È a
lei che vanno rivolte le domande sul contenuto.

🔴 **`Tipo biglietto` non ha alcun controllo e lo sanno entrambe le parti.** Aurel
Mrruku lo ha detto chiaramente — _"se metti su un prodotto una tipologia di
biglietto che non c'entra niente con quel prodotto, lì non ti posso aiutare"_ — e
la mitigazione concordata è il controllo degli accessi, non la logica. Circa 15
codici hanno un valore su un'anagrafica corsi di 40-50 righe, quindi una
ventina di aggiornamenti manuali l'anno.

### 27.2 Anticipay viene chiamato per ogni anagrafica, estere comprese

**È il ribaltamento della sezione.** La call del 1 settembre aveva stabilito che
Anticipay serve solo aziende italiane e che una partita IVA estera ritorna sempre
`404`; il §24 lo aveva letto come risposta negativa alla metà estera di `INT-18`.

Andrea Di Cicco aveva proposto l'economia — _"secondo me non la facciamo proprio
la chiamata se estera"_ — e Aurel Mrruku si era offerto di condizionare la
chiamata a un campo nazione. **Elisa Migliano ha argomentato per chiamare
sempre**, su un terreno che non riguarda affatto Anticipay:

> _"nelle partite IVA estere soprattutto ci sono dei caratteri speciali… a
> prescindere secondo me è bene che ci arrivi comunque una sorta di errore per
> controllare che non abbiano scritto cose inusuali."_

Le partite IVA le digitano i tutor a mano e alcune arrivano da form pubblici.
Quindi la chiamata è **anche un controllo di input**, e l'errore è il prodotto,
non un guasto. Concordato: _"quindi io lo farei sempre la chiamata verso
anticipay."_

**Il percorso d'errore è stato progettato in riunione**, e colma una lacuna
aperta dal 6 agosto — l'indirizzo di amministrazione che nessuno aveva fornito.
In caso di lookup fallito parte una mail ad `amministrazione@pienissimo.com`, con
il dettaglio che la rende utilizzabile, aggiunto da Aurel Mrruku: _"nella mail
mettiamo proprio il link del dato su salesforce, così se cliccate entrate e
controllate."_ L'anagrafica viene creata su Salesforce in ogni caso: Anticipay è
un controllo, mai un blocco.

🔴 **Due cose su cui questo si regge, e nessuna delle due esiste.**

Primo, **il corpo d'errore per un'azienda estera non è documentato.** Elena Spini
lo ha cercato durante la call e non lo ha trovato: _"la cosa estera in effetti
non c'è negli errori. Non so cosa può rispondere."_ Per Aurel Mrruku ricade nel
`404` generico, il che ne farebbe il **quarto** significato dello stesso codice
di stato, dopo _partita IVA sconosciuta_, _non in cache con `env=test`_ e
_hostname sbagliato_. È una deduzione, non un contratto.

Secondo, **la notifica non può scattare con il codice attuale.** `Is_Error__c`
non viene mai valorizzato su errore HTTP, quindi la mail concordata resterebbe
muta proprio sul `404` su cui è costruita: il difetto che il §23 registrava come
generico ha ora sopra di sé una funzionalità concordata con il cliente.

**La richiesta pendente ad Andrea Parmeggiani cambia quindi forma.** Non è più
"un esempio di ogni corpo d'errore": è _che cosa ritorna il middleware per una
partita IVA non italiana, e come si distingue da una partita IVA semplicemente
sconosciuta?_ Senza quella distinzione la mail non può dire quale dei due casi
sia successo e l'amministrazione deve aprirli tutti.

### 27.3 Il tracciato ordini Mexal, per iscritto per la prima volta

La seconda metà della call è Elisa Migliano che legge ad alta voce le proprie
schermate Mexal mentre Andrea Di Cicco mappa. Tutto ciò che era stato scritto
finora presupponeva un solo tipo di ordine; i tipi sono due.

| Regola                  | Servizi               | Libri                 |
| ----------------------- | --------------------- | --------------------- |
| **sigla**               | `OC`                  | **`BC`**              |
| **causale**             | 1 IT · 2 SM · 3 altro | 4 IT · 5 SM · 6 altro |
| **magazzino di uscita** | 1                     | 2                     |
| **costi ricavi**        | 3 (servizi)           | 1 (materie prime)     |
| **IVA**                 | esente, `E01`         | esente, `E10`         |

I libri non stanno mai nello stesso ordine dei servizi. `BC` è emerso tardi —
_"questa c'era sfuggita effettivamente"_ — e i valori del centro di costo sono
stati richiamati a memoria (_"se non ricordo male"_): entrambi vanno verificati
su un documento reale.

🔴 **Ogni riga ordine deve portare una `data di scadenza`, che è la scadenza della
tranche.** Andrea Di Cicco: _"è per le tranche."_ Elisa Migliano: _"oggi noi non
la gestiamo, però un domani andrà messa."_ La tranche smette così di essere un
concetto solo Salesforce ed entra nel tracciato ERP — comportamento nuovo su
**entrambi** i lati, concordato otto giorni prima della fine dello sviluppo di
Fase 1, e non stimato. Si noti che `OrderItem.Tranche__c` esiste, è deployato, e
**nessun Apex in repository lo scrive**.

🔴 **Nuovo: `OI-110`.** Elisa Migliano ha bisogno di `codice agente`, `zona` e
`classificatore rete` in testata ordine, e Andrea Di Cicco non li ha trovati nel
set di campi che la sua integrazione legge. I tre campi servono al calcolo delle
provvigioni: i tutor sono la rete vendita, tutti hanno accesso al CRM, alcuni
sono dipendenti e **due hanno un contratto di agenzia e vengono pagati a
provvigione**.

Sul lato cliente: la residenza fiscale è **derivata automaticamente dal codice
paese** su cinque valori, il che chiude `OI-97`; `tipo fattura elettronica` è il
valore B2B per le aziende italiane e vuoto per tutte le altre — **il vuoto è
stato verificato su un record reale, il codice B2B è stato ipotizzato**
(_"potrebbe essere S"_); la PEC guida la fatturazione elettronica; la valuta è
**solo Euro**, il che chiude l'incognita del 26 agosto su `valuta = 1`; e si usa
solo il listino 1.

`OI-109` si chiude per ritiro: Elisa Migliano ha lasciato cadere il codice
destinatario SDI — _"comunque non ci serve"_ — il giorno dopo averlo chiesto.

### 27.4 L'anagrafica clienti ottiene una serie di sessioni, chieste dal cliente

Lo ha sollevato Elisa Migliano, con il numero che ne fa un problema: l'anagrafica
clienti Zoho ha **150 campi**, e _"sono andata in confusione io da sola con me
stessa, su un'anagrafica che conosco."_ La sua proposta — call di mezz'ora, una
tabella alla volta, decidendo per ogni campo Zoho se serve su Salesforce — è
stata accettata.

**Tre sessioni con il cliente sono state fissate la mattina stessa**: `Data
Model` Parte 1 il **3 settembre alle 11:00**, Parte 2 il **4 settembre alle
16:00**, Parte 3 il **7 settembre alle 11:00**.

🟢 **E il materiale per prepararle è arrivato lo stesso pomeriggio.** Elisa
Migliano ha compilato il file condiviso di ROMI subito dopo la call — modifica su
Drive alle 14:05:38Z, mail di Fabrizio Paganelli _"Abbiamo aggiornata la tabella
condivisa. A domani"_ alle 14:06:38Z. `OI-24`, aperto dal 2 luglio e bloccante, è
in larga parte arrivato: elenchi dei campi Zoho per Lead, Account, Referente,
Opportunità, Offerta e Articoli, con il **foglio Account suddiviso in sezioni** —
`Dati Anagrafici`, `Dati Tecnici`, `LEGALE RAPPRESENTANTE`, `MEXAL`, `MEXAL -
DATI PER PROVVIGIONI`, `UTILIZZATO PER PERFORMANCE` e un ampio **`NON UTILIZZATO
O OBSOLETO`**, che è il cliente che dichiara campo per campo che cosa non
migrare.

🔴 **Restano vuoti: l'elenco campi Ordine, Utenti, Profili e il piano dei
caricamenti iniziali.** Il foglio `Flussi` porta solo F-1 (upsert anagrafiche
Salesforce → ERP, realtime, _"scatta alla prima opty won"_) e F-2 (ERP →
Salesforce, batch notturno); da F-3 a F-7 è vuoto, quindi ogni altra integrazione
ha una casella e nessun contenuto.

🔴 **Un foglio contraddice una decisione presa il giorno prima.** La sezione
`LEGALE RAPPRESENTANTE` mostra che la residenza del rappresentante è già
**suddivisa in via, città, provincia, CAP e paese** su Zoho, mentre la riunione
del 1 settembre ha deciso di modellarla su Account come **un unico campo di testo
libero**. Migrare un dato strutturato in uno non strutturato è una perdita
irreversibile. **Da sollevare alla Parte 1.**

⚠ **Il file è popolato con record reali** — un'azienda vera con partita IVA, PEC
e IBAN, un legale rappresentante con nome, codice fiscale, data e luogo di
nascita, un lead e un contatto con nome e cognome. Qui si registra che esiste;
nulla di quel contenuto è riprodotto, e nulla può esserlo.

### 27.5 Il calendario che nessuno ha sovrapposto al piano

Elena Spini, mentre si fissavano le date: _"noi dal 9 all'11 siamo a un evento
aziendale, quindi 9 10 11 anche noi non ci saremo."_

🔴 **Lo sviluppo di Fase 1 dovrebbe finire il 10 settembre, dentro quell'evento.**
Nessuno in riunione ha collegato le due cose, la data non è stata rinegoziata e
il piano di progetto non è stato nominato. Da stasera restano **quattro giorni
lavorativi**, tre dei quali con una sessione cliente — a fronte degli undici
campi Anticipay (non costruiti), della build Asset da zero (non iniziata), di
tutto il lato Salesforce di WooCommerce (non iniziato), del modello campagne
padre/figlio (non costruito), del resto delle tranche e ora del tracciato ordini
concordato oggi.

Elisa Migliano è inoltre indisponibile il **17 settembre dalle 09:00 alle 13:00**.

### 27.6 Una cosa fuori dalla riunione

🔴 **Nessuno ha confermato che Pienissimo abbia DocuSign.** Aurel Mrruku lo ha
chiesto direttamente a Elena Spini lo stesso pomeriggio: _"hanno già un contratto
con loro?"_ La risposta separa la volontà dal contratto, e solo la volontà è
acquisita — _"si DocuSign per la firma del preventivo lo vogliono"_ … _"richiedo
conferma, ma mi aspetto di sì."_ La sandbox per sviluppatori è gratuita; il
tenant di produzione richiede un accordo commerciale firmato, il go-live è il
6 ottobre, e un acquisto di licenze era stato dichiarato per telefono a luglio e
mai più confermato. `BIG-13` è ancora `open` nel registro, e in org esiste già
una named credential `DocuSign` presente **solo in org**: qualcosa è collegato a
un account che nessuno sa nominare. Nuova riga `OI-111`.

## 28. Aggiornamento 03/09/2026 — Data Model Parte 1, e una community arrivata da sé

Il 3 settembre sono successe due cose scollegate. La prima era pianificata; la
seconda non era in nessun tracker.

### 28.1 La sessione

**`[ROMI-PIENISSIMO] - Data Model: Parte 1`, con il cliente, 10:59 CEST, fissata
per un'ora e durata 2h08m.** Presenti: Elena Spini, Aurel Mrruku, Andrea Di
Cicco, Elisa Migliano, Fabrizio Paganelli. Sabatino Rinaldi era invitato come
opzionale e non ha partecipato. Analizzata dalla trascrizione integrale: quindici
decisioni registrate come concordate, una formalmente rinviata, sedici azioni in
uscita.

È la prima delle tre sessioni chieste da Elisa Migliano dopo aver detto di
essersi confusa su un'anagrafica che conosce — _"sono andata in confusione io da
sola con me stessa"_ — e ha coperto **l'oggetto Account e nient'altro**.

### 28.2 Chi possiede l'anagrafica clienti, e da quando

La cosa più grande decisa dalla sessione, e non era nel record:

1. **Salesforce crea l'anagrafica** e la porta su Mexal **immediatamente prima
   della creazione dell'ordine**.
2. **Da quel momento è Mexal a possederla.** Le modifiche successive si fanno
   solo su Mexal.
3. **Un batch notturno le restituisce a Salesforce** — l'`F-2` del cliente, il
   _"get notturno"_ di Aurel Mrruku. **Non esiste**: nuova riga `OI-116`.
4. **Salesforce blocca i propri campi amministrativi e contabili** quando
   `Codice Cliente Mexal` è valorizzato, modificabili solo dall'amministrazione,
   con una regola di validazione. **Nemmeno questo esiste**: nuova riga `OI-117`.

I campi commerciali restano fuori dal blocco. L'ora spesa dalla sessione a
smistare 150 campi in **Dati Commerciali / Dati Tecnici / MEXAL / MEXAL - DATI
PER PROVVIGIONI** non era riordino: quelle sezioni **sono** il confine del blocco.

### 28.3 I campi provvigionali, risolti dalla direzione opposta

`OI-110` chiedeva perché `codice agente`, `zona` e `classificatore rete` non si
trovassero nella chiamata ordini di Mexal. Non devono arrivare da lì.

**Sono ereditati dall'utente Salesforce — il tutor — assegnato all'anagrafica.**
Fabrizio Paganelli ha mostrato dal vivo il comportamento attuale: cambiando il
proprietario dell'account, tutti e tre seguono. **Sull'ordine si congelano**,
perché la provvigione spetta a chi teneva il cliente quando l'ordine è stato
accettato — _"tu puoi cambiare l'agente a livello di account, ma a livello di
ordine deve rimanere quello precedente,"_ confermato in riunione.

**Il resto lo riconcilia Mexal da sé.** Ricevendo un ordine con agente diverso
dalla propria anagrafica, riscrive l'anagrafica e restituisce l'abbinamento sul
flusso notturno. Aurel Mrruku ha chiesto se Salesforce dovesse notificare
qualcosa; la risposta è stata no.

🔴 Di `OI-110` resta una domanda sola, non due: **se la chiamata di creazione
ordine di Mexal possa portare i tre campi sul filo.** L'aggiornamento JSON e
l'invio di prova di Andrea Di Cicco, dovuti dal 2 settembre, non sono comparsi su
alcuna fonte.

### 28.4 Continuità della ragione sociale

Tre meccanismi, concordati, nessuno costruito (`OI-118`): un **inner lookup** su
Account etichettato **`Azienda Precedente`** che risale **cinque** predecessori;
**History Tracking** sui campi critici entro il limite Salesforce di **10 campi**;
e il codice del predecessore passato al **`codice alternativo`** di Mexal.

🔴 **Percorrere non è aggregare.** Un lookup profondo cinque permette a una
persona di risalire; non fa sommare a un report gli ordini dei predecessori, e i
roll-up non attraversano questo tipo di lookup. Fabrizio Paganelli ha chiesto
statistiche.

### 28.5 La passata campo per campo

**Rinominati** — `codice cliente esterno` → **`Codice Cliente Mexal`**;
`Ultima Verifica Credit Safe` → **`Ultima Verifica Anticipay`** (⚠ **Credit Safe
era il fornitore di verifica P.IVA precedente**, mai nominato prima nel record).

**Aggiunti** — `Azienda obsoleta`; **`Azienda Test`**, perché le prove di vendita
interne siano escluse dalle statistiche commerciali; i tre campi ATECO, la cui
fonte è `OI-112`.

**Eliminati** — email marketing e telefono commerciale a livello azienda
(entrambi gestiti sul contatto; il telefono amministrativo resta e diventa
obbligatorio); `Livello`; `Stato cliente`; i campi RID e quelli legacy della
firma contratti; e **l'intero blocco del legale rappresentante**, che è la cosa
migliore capitata a `OI-95`: Fabrizio Paganelli _"per me li potete eliminare
tutti"_, Aurel Mrruku _"Li toglierei tutte in base a quello che ci restituisce.
Faccio io il mapping."_ La lista campi Salesforce diventa una conseguenza della
risposta reale di Anticipay invece di una lista concordata da un PDF.

**Spostati** — `Tipologia Attività` lascia l'anagrafica per il **Preventivo**
come picklist non restrittiva; Elisa Migliano deve i valori (`OI-115`).

**Mantenuti deliberatamente** — l'**SDI**, che Fabrizio Paganelli vuole
alimentato in previsione di un cambio normativo anche se tra San Marino e Italia
si usa la PEC. ⚠ **`OI-109` registrava l'SDI come ritirato il 2 settembre**,
perché Elisa Migliano non ne aveva bisogno _da Anticipay_. Qui lo stesso campo è
mantenuto e alimentato _da Mexal_. Due persone, ragioni opposte, 24 ore di
distanza, nessuna delle due al corrente dell'altra.

**Rinviati** — se Mexal richieda sia l'indirizzo di fatturazione sia quello di
spedizione (`OI-113`), unico rinvio formale della sessione; e se lo
`Stato Azienda` RFM vada migrato (`OI-114`).

### 28.6 Una decisione di sistema presa di passaggio

🔴 **Tutte le label e tutti gli stati su Salesforce saranno tradotti in
italiano** — offerte e ordini inclusi. Registrata come concordata da tutti i
partecipanti. Tocca ogni layout, picklist e state machine già costruita, e
**nella sessione nessuno l'ha stimata.**

### 28.7 Ciò che la sessione non ha raggiunto

🔴 La **tabella Lead è stata saltata deliberatamente** perché Sabatino Rinaldi
possa esserci, e **Utenti, Profili, la lista campi Ordine e il piano di
caricamento iniziale non sono stati aperti affatto** — le stesse quattro lacune
che `OI-24` registrava il 2 settembre. **Due ore hanno prodotto un oggetto.**
Parte 2 (4 settembre, 16:00) e Parte 3 (7 settembre, 11:00) hanno un'ora ciascuna
per tutto il resto, più una sessione Lead che richiede un partecipante che non
sta partecipando.

🟢 Elena Spini ha eseguito le proprie azioni sul template entro quattro minuti: il
workbook condiviso è stato modificato alle 11:11:04Z. Il blocco `NON UTILIZZATO O
OBSOLETO` non c'è più e il foglio Account porta ora le sezioni, le rinomine e le
aggiunte concordate in riunione.

### 28.8 Un'intera community Experience Cloud mergiata lo stesso pomeriggio

**PR #31, branch `DevMain_RexhinaPien`, aperta da Rexhina Hysi alle 14:21Z e
mergiata su `DevMain` da Aurel Mrruku alle 15:02:59Z — 41 minuti dopo. 82 file,
+4.402 righe.** Contiene un sito Experience `Landing Page`, la sua network e il
suo profilo, un experience bundle da 67 file e due LWC con i relativi controller
Apex: **`participantRegistrationPage`** / `ParticipantRegistrationController`
(576 righe) e **`quoteAcceptancePage`** / `QuoteAcceptanceController` (268
righe). È stata pubblicata sulla sandbox UAT Pienissimo alle 13:48Z e di nuovo
alle 14:10Z — **prima del merge**.

🟢 **Costruisce `OI-78` e `OI-68` su un'unica superficie condivisa**, il che
risponde alla domanda che entrambe le righe lasciavano aperta: sì, la pagina
partecipanti e la pagina preventivi sono lo stesso sito.

🟢 **La pagina preventivi usa il ciclo di vita concordato** — `In Trattativa` e
`In Attesa Accettazione` azionabili, `Accettato` / `Rifiutato` come esiti. È la
prima volta che il codice costruito rispecchia ciò per cui `OI-59` ha insistito.
⚠ È codice, non configurazione: se la picklist in org non ha ancora quei valori,
il controller fallisce a runtime.

🔴 **`OI-86` ha una risposta nella build e resta aperta nel record.** La domanda
era community Salesforce o landing page della piattaforma di marketing; la call
decisiva con Rebecca Marmo non è mai stata fissata oltre _"dopo il 17 agosto"_;
nessuna sessione l'ha verbalizzato e la PR non ha descrizione. A una
sviluppatrice è stato detto di lavorare sulla _"community di Pienissimo"_ in un
DM Slack il 2 settembre e la community è stata mergiata il giorno dopo. **Una
build è prova di cosa è successo, non registrazione di una decisione** — e
Rebecca Marmo non è stata informata.

🔴 **La pagina preventivi salta del tutto DocuSign.** Il flusso concordato è
accetto → DocuSign → alla firma il preventivo cambia stato e l'ordine viene
generato. Il `submitAction` costruito imposta `Quote.Status` al click; non c'è
envelope e non c'è generazione ordine. È arrivata il giorno dopo che `OI-111`
registrava che nessuno ha confermato che il cliente possieda DocuSign, e **nulla
da nessuna parte collega le due cose** — è altrettanto compatibile con un primo
passaggio che non è arrivato alla firma. **Chiedere, invece di inferire.**

🔴 **Nessuna delle due pagine ha autenticazione applicativa.** Entrambi i
controller sono `without sharing`; il `submitAction` della pagina preventivi
accetta un **id preventivo** nudo e scrive, e `loadPage` e `findContact` della
pagina partecipanti accettano **id account e id campagna** nudi. Tutto il
controllo di accesso è che gli id siano parsabili e i record esistano. Gli id
Salesforce non sono segreti — questo progetto li spedisce deliberatamente, nel
link di marketing e nel link di checkout WooCommerce. **Terza occorrenza dello
stesso pattern**, dopo l'endpoint WooCommerce non autenticato di `INT-16` e il
link di checkout che porta l'id opportunità in chiaro. Conviene risolverlo una
volta sola con un token firmato e con scadenza, invece che tre.

⚠ **+844 righe Apex non coperte in un giorno**, su un deficit misurato l'ultima
volta a 1.571 righe e zero coperte. Registrato perché i dati di copertura sono il
brief per la suite di test; **non si agisce**, secondo l'istruzione permanente per
cui la suite si scrive una volta sola, come attività a sé, prima del deploy in
produzione.

### 28.9 Due fatti di calendario

⚠ **L'evento aziendale ROMI del 9–11 settembre è ora confermato per iscritto.**
Gianpaolo Motta, scrivendo a un contatto esterno su tutt'altro tema: _"(da
mercoledì a venerdì saremo out)"_. **Lo sviluppo di Fase 1 finisce il 10
settembre**, dentro quella finestra.

⚠ **Elena Spini è assente il 14 e il 15 settembre.** Ha spostato il follow-up
interno del 14 a **giovedì 17 settembre, 14:15–15:15 CEST**, allungando lo slot
ricorrente a un'ora perché _"andiamo sempre lunghi"_. Tra il 9 e il 17 settembre
c'è **un solo giorno lavorativo** con il team al completo.

### 28.10 Altre annotazioni

⚠ **Il My Domain di produzione `pienissimo.my.salesforce.com` è predisposto e
"pronto per il deploy"** (notifica Salesforce, 08:06Z). Non è stato deployato. È
il primo movimento sull'org di produzione nel record.

⚠ **`Flows & Objects.drawio` si è mosso per la quinta volta** alle 09:20:01Z,
circa 100 minuti prima della sessione — quindi probabilmente in preparazione.
**Non è stato decodificato**: il lettore testuale di Drive non rende quel
formato, e ogni decodifica precedente è stata fatta a mano dall'XML. Conviene
farla prima di Parte 2.

⚠ **Il canvas Slack è ormai indietro di otto sessioni cliente** — riletto
direttamente in questo giro, la voce più recente è ancora quella del 20 agosto.

## 29. Aggiornamento 04/09/2026 — Data Model Parte 2, una tabella edizioni che nasce vuota, e due record sbagliati

Il 4 settembre sono successe quattro cose e solo una è arrivata tramite un
messaggio. La sessione è stata analizzata dalla trascrizione integrale; tutto il
resto viene dal repository, da un file Postman e da una notifica Notion.

### 29.1 Data Model Parte 2 — l'anagrafica contatti, chiusa dentro la sua ora

Sessione cliente, **16:04 CEST, 1h01m33s**. Presenti: Elena Spini, Aurel Mrruku,
Andrea Di Cicco, Elisa Migliano. A differenza della Parte 1, che aveva sforato
del 108%, è rimasta nello slot e ha completato quanto aperto —
[il verbale](../notes/meetings/2026-09-04%20Data%20Model%20Parte%202.md).

**L'indirizzo di spedizione diventa uno specchio nascosto della fatturazione.**
Entrambi i set esistono nel data model, quello di spedizione è popolato
automaticamente con i valori di fatturazione, nascosto nelle schermate
Salesforce, ed entrambi sono passati a Mexal. La motivazione dichiarata è
impedire che Mexal rifiuti un ordine per un indirizzo mancante.

È una soluzione adottata **prima che `#113` avesse risposta**, e vale la pena
essere precisi su cosa compra e cosa costa. Toglie otto campi dal percorso
critico, il che è un sollievo reale a quattro giorni lavorativi dalla scadenza di
Fase 1. Ma se Mexal richiede davvero un indirizzo di spedizione _distinto_ per
qualche cliente, un indirizzo di fatturazione specchiato è un **valore sbagliato
anziché mancante** — e un indirizzo sbagliato che supera la validazione è peggio
di un rifiuto, perché nulla lo segnala. Il guasto si sposta dalla creazione
dell'ordine alla consegna.

**I contatti hanno una picklist di ruolo invece di record duplicati** —
`commerciale`, `amministrativo`, `amministrativo e commerciale` — e la
distinzione pesa, perché **i contatti commerciali sono i destinatari dei
biglietti**. 🔴 Il workbook del cliente, salvato alle 15:03:03Z **durante la
stessa call**, indica come terzo valore `Piattaforma`. Due su tre coincidono;
quello che differisce è proprio il valore combinato che fa funzionare l'intero
disegno (`#120`).

**Il referente diventa modificabile dentro il preventivo**, con un flag
`contatto principale` che si disattiva da solo — il caso di Aurel Mrruku erano
catene e franchising in cui ogni sede fa capo a un referente diverso.

**Cinque campi escono dal Contatto**: `Origine lead`, `Telefono abitazione`,
`Segreteria`, `Tipologia attività` e `Contatto obsoleto`. ⚠ L'eliminazione di
`Tipologia attività` riguarda il campo sul **Contatto** e **non** annulla `#115`,
che sposta il campo di Account sul preventivo. Il nome compare ora su tre oggetti
ed è stato deciso in modo diverso su ciascuno.

**`#112` è risolto, e la risposta è sì.** Elisa Migliano si è rivolta
direttamente ad Andrea Parmeggiani invece di attendere la mail in coda: Anticipay
restituirà il **codice ATECO, la sua descrizione e il codice fiscale**, nella
stessa chiamata. La risposta documentata a undici campi è quindi incompleta — la
seconda volta che la documentazione è incompleta anziché sbagliata. ⚠ **Le due
mail che lo confermano non sono nella casella analizzata**, quindi il punto
poggia sul verbale e chi mapperà la risposta dovrà ritrovarle.

**DocuSign si è mosso, verbalmente.** Elena Spini: _"comunque tutto confermato…
ha detto che Massimo settimana prossima ci fa sapere."_ Il ritardo è attribuito
al team commerciale DocuSign in ferie e non al silenzio del cliente, e per la
prima volta c'è un contatto con un nome. Nulla è messo per iscritto, e la
finestra si stringe: il tour del cliente inizia martedì 8 settembre e Sabatino
Rinaldi non risponde più al telefono.

🔴 **Il calendario non coincide con quanto deciso in riunione.** Il gruppo ha
concordato di spostare a martedì. Ciò che è stato prenotato è una **nuova
`Parte 4`** (mar 8 set 12:00–13:00) mentre la **`Parte 3` resta lunedì 7 set
11:00, con Andrea Di Cicco invitato a uno slot in cui ha detto di non poter
esserci.** Nessuna cancellazione su alcuna fonte. Entrambe le letture sono
coerenti — un'ora il lunedì con partecipanti ridotti è esattamente ciò che Elena
Spini aveva proposto per prima — e un messaggio risolve. Contro la scadenza del
10 settembre, la differenza è uno dei quattro giorni lavorativi rimasti.

🔴 **Le stesse quattro lacune sopravvivono alla terza sessione**: Utenti,
Profili, il piano di caricamento iniziale e la mappatura campi dell'Ordine. Il
foglio Ordine ha guadagnato un requisito — _"Codice Agente, Classificatore Rete,
Codice Zona"_ (`#110`) — ma nessuna mappatura. Nemmeno la tabella Lead è stata
aperta, e Sabatino Rinaldi, per il quale era stata rinviata, non è disponibile da
martedì.

### 29.2 La tabella di mappatura edizione è stata rilasciata, ed è vuota

**La PR #34 costruisce `Mappatura_Edizione__c`** —
[`#96`](../notes/objects/The%20Mappatura%20Edizione%20object.md), e fedelmente.
Tutte e tre le proprietà che il record segnalava come facili da sbagliare sono
rispettate: la risoluzione è **per riga d'ordine e per componente di bundle**
(il caso che il 26 agosto ha fatto cadere la regola della singola campagna figlia
attiva), le finestre si confrontano con `Order.EffectiveDate`, e la _colonna G_
esiste come `Data_Evento__c`, con la sua funzione scritta nella descrizione del
campo.

🟢 **Sono state costruite due cose che nessuno aveva specificato, ed entrambe
sono migliorie.** La chiave prodotto è una **lookup a `Product2`** anziché un
codice articolo testuale, quindi non può divergere dall'anagrafica né essere
rotta dal rischio di normalizzazione dei codici. E le **finestre attive
sovrapposte sono rifiutate** da un trigger before-save, con una sola query
limitata — senza il quale l'edizione di una riga d'ordine sarebbe ambigua.
Nessuna delle due era stata chiesta.

🟢 **Con essa sono arrivati i record type Campagna `Campagna_Padre` e
`Campagna_Figlio`**, con regole di validazione — la prima volta che il modello
padre/figlio esiste come metadato e non come nota di design.

🔴 **Ma `assignCampaigns` solleva un'eccezione invece di degradare**, e gira
quando un Ordine passa a **`Incassato`** — stato in cui al check del 2 settembre
si trovavano già 12 ordini su 15. Quindi un prodotto non mappato che genera
biglietti non blocca la creazione dell'ordine; **blocca il passaggio a
`Incassato`, annullando l'aggiornamento**. La tabella si mantiene a mano, non ha
righe in source control, e **nessuno è stato incaricato di popolarla** (`#121`).
Va inoltre sequenziata con `#98`, perché ricreare i ~1000 articoli Mexal
orfanerebbe le righe inserite prima.

### 29.3 Un `git diff` ha trovato due record sbagliati da due sweep

Entrambi corretti il **2 settembre** nel commit `9b38d1a`, ed entrambi già
presenti in `DevMain` al commit della trace del 3 settembre.

✅ **I tre difetti di codice di `#107` sono tutti corretti.** `Is_Error__c` è ora
impostato dallo stato HTTP sul percorso di successo; `Response_State__c` è
impostato **prima** della deserializzazione e il `catch` riusa la stessa riga di
log, quindi lo stato sopravvive a un errore di parsing; e un corpo non-JSON — il
`404` HTML da un hostname sbagliato — esce con un log pulito invece di sollevare
un'eccezione. Resta solo la metà lato cliente: i corpi di errore sono ancora
dovuti e nessuna lookup è mai stata eseguita.

✅ **Il rischio sul mancato build dei campi Anticipay è risolto.** `Account` ha
**dieci** campi custom, tra cui `PEC__c` e tutti e cinque i campi del legale
rappresentante — esattamente il disegno di `#95`. L'org check che ha aperto il
rischio è girato alle 08:05–08:14Z del 2 settembre, **ore prima del commit**: era
corretto quando è stato preso e vecchio entro sera.

⚠ **La lezione di metodo è quella del 3 settembre vista dall'altro lato.** Quel
giro aveva concluso che una pull request è una fonte. Questo aggiunge: **un org
check è la fotografia di un ramo in movimento**, e un `git diff` rispetto al
watermark precedente avrebbe trovato entrambi i casi con un solo comando.

### 29.4 L'endpoint WooCommerce esiste, e con lui due credenziali in giro

Anita Aga ha inviato ad Aurel Mrruku una collection Postman via mail (16:23,
16:37 CEST) e via DM Slack (17:08), con una chiamata funzionante verso la rotta
Apex REST in ingresso.

🟢 **L'autenticazione è più solida di quanto il record temesse** — **OAuth 2.0
JWT bearer**, un'assertion firmata scambiata all'endpoint token di Salesforce per
una sessione usata come bearer, non il segreto statico condiviso contro cui
`INT-16` mette in guardia.

🔴 **A Sabatino Rinaldi non sono stati consegnati né l'endpoint né la
credenziale.** Il suo lato è pronto dal 27 agosto e i test di integrazione erano
fissati per la settimana del 31 agosto (`#102`).

🔴 **Entrambe le credenziali sono circolate in chiaro su due sistemi, e la
scadenza dell'assertion JWT è a circa sessant'anni** — di fatto una credenziale
permanente per un utente di integrazione su UAT
([il rischio](../notes/risks/Risk%20-%20Salesforce%20integration%20credentials%20were%20circulated%20in%20plaintext.md)).
Vanno ruotate, e il pattern non va portato in produzione — che è più vicina di
prima, dato che `pienissimo.my.salesforce.com` è stato predisposto il 3
settembre.

⚠ `INT-16` **non** è chiuso da questo. L'autenticazione di piattaforma è una
garanzia diversa dalla classe che verifica il proprio chiamante, e in questo giro
l'org non è stata aperta.

### 29.5 Tre cose minori

⚠ **La mail di errore Anticipay è costruita ed è indirizzata allo sviluppatore.**
`AnticipayErrorNotificationService` fa esattamente quanto concordato — filtra le
righe di log su `Is_Error__c` e invia — ma a un **indirizzo ROMI cablato nel
codice**, mentre il destinatario concordato è `amministrazione@pienissimo.com`
con un link al record (`#119`). Sembra un segnaposto ed è in merge senza alcuna
marcatura.

⚠ **Un indirizzo Gmail esterno ha chiesto accesso alla pagina Notion di stato
interna**, e la richiesta è senza risposta (`#122`). Quella pagina nomina persone
e contiene linguaggio interno sui rischi; `site/` è la superficie sanificata.
L'identità è sconosciuta al record e non va dedotta dal nome.

⚠ **`#tproj-pienissimo` ha rotto una settimana di silenzio, ripetendosi quasi
del tutto.** Elena Spini ha pubblicato uno status alle 19:48 CEST — ma il suo
**blocco red flag è copiato alla lettera dal 28 agosto e da cinque post
precedenti**, quindi la disputa sul perimetro di fase 2 che descrive **non** è un
movimento nuovo. L'unica novità è che le sessioni data model sono l'attività
corrente e che **Sabatino Rinaldi non risponde più al telefono** perché il
cliente è impegnato con un evento. Il canvas è invariato e ora è indietro di
**nove sessioni cliente**.

---

## 30. Aggiornamento 07/09/2026 — tre sessioni, un go-live contestato e la Fase 2 accantonata

Il 7 settembre si sono tenute tre sessioni Pienissimo: `[PIENISSIMO]- Interna
Flussi MKT` (interna ROMI, 10:00 CEST), `[ROMI-PIENISSIMO] - Data Model: Parte 3`
(con il cliente, 11:06 CEST) e `[PIENISSIMO] - Follow-up Interno` (interna ROMI,
17:01 CEST). Le prime due sono state analizzate sulle trascrizioni complete; la
terza non ha trascrizione ed è letta dagli appunti Gemini.

### 30.1 Il go-live si sposta al 21 settembre, in una stanza senza il cliente

Il follow-up interno ha concordato, sotto `Concordato`, **go-live 21 settembre
2026 con approvazione entro il 13 settembre**, con il rilascio in produzione
precedente al go-live.

🔴 **Tutti i documenti che governano questo progetto dicono 6 ottobre 2026** —
`CTX-02` in entrambi i testi, entrambe le tabelle delle milestone, la definizione
di priorità `M`, la regola di escalation alla Fase 2 e il §10.1 qui sopra. Il 21
settembre è **quindici giorni prima**, eppure la sessione lo descrive come uno
_slittamento_ che **aggiunge** settimane di sviluppo e test, cosa che ha senso
solo rispetto a un piano il cui go-live era anteriore al 21 settembre e che **non
è in questo repository**.

O il piano interno ROMI è divergente dai requisiti firmati, o la data è stata
davvero anticipata. Le due letture hanno conseguenze opposte e le note non le
distinguono. **Nulla è stato modificato nel registro**: `REQUISITI.it.md` è il
testo presentato per la firma, e nessuna fonte mostra che a Pienissimo sia stato
chiesto. La voce **#124** porta il conflitto.

Collide con la scadenza di sviluppo Fase 1 del 10 settembre che cade dentro un
offsite **9-12 settembre** (quattro giorni, da mercoledì a sabato mattina, come
descritto in questa sessione), con l'assenza di Elena Spini il 14-15 settembre,
con la finestra di mappatura edizioni collocata "immediatamente prima del
go-live" (#121), con la suite di test Apex non pianificata, e con le sessioni
dimostrative al cliente organizzate **dal 24 settembre** — dopo il go-live
proposto.

### 30.2 La Fase 2 è accantonata, e ci si sta rimandando dentro del lavoro

**La Fase 2 è trattenuta fino a conferma di pagamento da parte del cliente.**
Elena Spini ha ribadito l'obiettivo di farla quotare per coprire il fuori
perimetro accumulato. È il primo movimento sulla disputa Fase 2 dal 24 luglio, ed
è una **posizione ROMI, non una risposta del cliente** — Daniela Morgese non è
ancora stata contattata (#83).

🔴 **Nella stessa sessione la correzione dello scadenzario Mexal è stata rimandata
alla Fase 2.** Fabrizio Paganelli aveva chiesto che lo stato degli asset seguisse
le fatture non pagate e che incassi ed errori sulle tranche fossero correggibili;
Andrea Di Cicco l'ha valutata come richiedente una sequenza di chiamate che
cancellano e ricreano ordini e fatture. Quindi perimetro rivolto al cliente si è
spostato in una fase senza quotazione, senza data e senza pagamento, e le note non
collegano le due decisioni.

La sessione si è anche aperta sul **ritardo accumulato**, attribuito al carico di
lavoro e a requisiti di marketing imprevisti — il pulsante di rinuncia è citato
come esempio — con Aurel Mrruku che ha sollevato il fatto che i requisiti
continuano a cambiare e Andrea Di Cicco che ha proposto di **preallertare
Gianpaolo Motta**.

### 30.3 Sei decisioni Mexal che rendono realizzabile l'integrazione

- **Le coordinate in header sono statiche**: `azienda = PE`, `anno = 2025`,
  impostate nel codice. L'autorizzazione è basic — una coppia utente e password in
  base64. 🔴 **`anno = 2025` è cablato contro un go-live 2026 e nessuno l'ha
  rilevato.**
- **La POST dei clienti modificati riceve un filtro sui campi**, perché la
  risposta non filtrata rischia di sforare i limiti di dimensione del JSON; la
  paginazione è da valutare.
- 🔴 **Serve PUT o PATCH per l'aggiornamento cliente** — la POST su un account
  esistente fallisce per partita IVA duplicata. E **il cliente viene inviato a
  ogni creazione ordine**, come aggiornamento vuoto quando nulla è cambiato,
  quindi ogni ordine successivo al primo di un cliente colpisce il percorso rotto
  (**#125**).
- **Le fatture sono generate manualmente** su Mexal da Fabrizio Paganelli.
  Salesforce recupera l'avanzamento delle fatture non definitive con una GET sui
  documenti modificati nelle ultime 24 ore.
- **La ricerca agente è manuale**, scelta per aggirare i problemi di licenze e
  permessi utente su Salesforce (#110).
- **L'indirizzo di spedizione non viene mai riletto da Mexal** — lo invia
  Salesforce, che ne possiede le modifiche. Quindi il mirror nascosto della Parte
  2 è **unidirezionale per scelta**, e un indirizzo sbagliato è sbagliato su
  entrambi i sistemi senza percorso di ritorno (#113).

🟢 **La mappatura prodotto-campagna ha finalmente un _quando_**: prima il
caricamento prodotti da Excel, poi la mappatura inserita a mano nei giorni
immediatamente precedenti il go-live — la prima indicazione di quando
`Mappatura_Edizione__c` verrà popolata, anche se ancora **non da chi** (#121).
**Gli ordini in corso vanno chiusi direttamente da Salesforce**; la migrazione più
ampia di clienti storici, account e ordini ha sollevato preoccupazioni e non ha
prodotto un piano.

### 30.4 Data Model Parte 3 ha chiuso l'anagrafica contatti

Con il cliente, 11:06 CEST, **1h12m02s**. Presenti: Elena Spini, Aurel Mrruku,
Elisa Migliano, con **Rebecca Marmo al telefono per due minuti**. **Andrea Di
Cicco non ha partecipato** — l'ha detto nella group DM ROMI alle 09:12:53 CEST —
il che risolve l'ambiguità di calendario del 4 settembre nel primo modo: la Parte
3 **non è stata annullata**, si è tenuta con una formazione ridotta, ed Elena
Spini ha inviato un invito aggiornato quella mattina.

🟢 **I consensi restano sul Contatto; la partecipazione alle edizioni passa a
Campagna e CampaignMember.** `Consenso finalità commerciali` e `Consenso
profilazione` diventano picklist con `Autorizzo` / `Non autorizzo` e **default
vuoto**. Rebecca Marmo ha confermato il comportamento Zoho che questo risolve: il
consenso si riporta automaticamente sui biglietti successivi e **viene
sovrascritta solo l'edizione**, perché Zoho tiene un unico blocco `ultima
iscrizione` per contatto.

⚠ **Una conseguenza sulla migrazione che nessuno in riunione ha sollevato**:
Salesforce vuole un CampaignMember per ogni edizione a cui si è partecipato, e
Zoho conserva solo l'ultima, perché ogni iscrizione ha sovrascritto la precedente.
**Lo storico delle edizioni non è migrabile da quel campo.**

🟢 **Il vocabolario dei tag Zoho è decodificato e dismesso.** `<EVENTO>_I`
significa _iscritto_ e `<EVENTO>CP` _contatto principale_ — `FMF_I`, `FMFCP` per
il Food Marketing Festival. Diventano valori di stato del CampaignMember, e
l'intero blocco dei tag è stato cancellato dal Contatto in sessione.

🟢 **La regola del contatto principale è precisata.** Il link per i dati
partecipanti va a chi è intestato il **preventivo** — possibilmente un assistente,
non il titolare — e il flag `contatto principale` è messo a mano dai tutor e **a
volte manca**. Concordato: il campo contatto sul form è **obbligatorio,
liberamente selezionabile tra i contatti dell'account, precompilato con il
contatto principale dove esiste, e modificabile**.

**Cancellati dal Contatto**: l'intero blocco del secondo indirizzo, il blocco
Google Ads, `Nome campagna di annunci`, i campi `Invio email contatto principale`,
`Contatto con telefono duplicato`, `Spesa marketing`, `Tipologia contatto`,
`Tipologia locale`, `Ufficio di competenza`, `Punteggio visitatore di campagna` e
tutti i campi di merge `CF*` delle mail biglietti. **Mantenuti**: le tre caselle
di ruolo del contatto (necessarie per i solleciti), `Auto marketer` — un **flag
bloccante**, perché Pienissimo non si interfaccia con i marketer per privacy
aziendale — `Ruolo iscrizione` (`titolare` / `collaboratore`, compilato dal
cliente e non modificabile da Pienissimo) e `Tutor`.

⏸ **I campi UTM sono rimossi in attesa di una decisione sulla reportistica**: un
Contatto o un Account creati da conversione lead mantengono il legame con il Lead,
quindi i valori si possono leggere da lì invece di duplicarli. Da definire durante
il test dei flussi.

🔴 **Una dozzina di campi del Contatto si sono rivelati un questionario verbale dei
tutor** — `Coperto medio`, `Apertura locale`, posizione TripAdvisor, numero di
collaboratori e coperti, e il resto. Il loro proprietario naturale è il singolo
**locale**, un oggetto che non esiste da nessuna parte in questo progetto, e sono
stati cancellati senza destinazione e senza una data per la conversazione che la
deciderà (**#123**).

🔴 **Le quattro lacune sopravvivono a una quarta sessione** — Utenti, Profili,
l'elenco campi Ordine e il piano di caricamento iniziale, più la tabella Lead
(#24). **Quattro sessioni hanno prodotto due oggetti.** La Parte 4, martedì 8
settembre alle 12:00, è l'ultima in calendario, e nemmeno lì c'è Andrea Di Cicco.

### 30.5 La sessione marketing, e la rinuncia che esce dall'email

Interna ROMI, 10:00 CEST: Elena Spini, Aurel Mrruku, Fabrizio Mastracci — la prima
sessione sui flussi marketing dal 19 agosto.

🟢 **`30 vs 60` è definito come finestra**: le comunicazioni girano **da 30 a 60
giorni prima dell'evento**, e la mail di raccolta dati parte **circa 60 giorni**
prima. È corroborato dal recap del **20 agosto** scritto da Fabrizio Mastracci al
cliente, che dice che il flusso di nurturing è _"avviato 30-60 giorni prima
dell'evento"_ e arriva fino a **10-11 comunicazioni** finché non viene inserito un
nominativo o cliccata Rinuncia. ⚠ **Il numero singolo resta ROMI che sceglie per
il cliente**, esattamente come #81 aveva avvertito: la conferma spettava a Elisa
Migliano e Rebecca Marmo con Matteo Distaso, e nessuna fonte la registra.

🔴 **La rinuncia esce dalla mail marketing e passa sulla pagina community.**
Gestirla a livello di intero ordine o bundle dentro Marketing Cloud è troppo
complesso e rischia di invalidare la struttura delle campagne figlie; sulla pagina
community il sistema sa esattamente quali asset sono in gioco e il problema delle
compilazioni parziali sparisce. È **lavoro non realizzato su una pagina rilasciata
il 3 settembre** (#78).

Nuovi: **#126**, un flag Salesforce per i biglietti i cui dati partecipante non
sono compilati, così che Marketing Cloud possa interrogarlo semplicemente — ⚠
verificare prima `Event_Invitation__c`, committato lo stesso giorno, prima di
aggiungere un secondo campo di stato sovrapposto. E **#127**, cosa comporta una
rinuncia totale per l'ordine e per il credito citato da Elena Spini. ⚠ **La metà
relativa ai biglietti di #127 era già risposta per iscritto** il 20 agosto — la
rinuncia _"annulla tutti i biglietti, non è parziale"_ — ed è stata trattata come
aperta in una stanza che conteneva l'autore di quella frase.

⚠ **Il vincolo di stile a solo testo non è stato ribadito.** La regola di Matteo
Distaso — niente header, niente immagini, niente pulsanti, scritta come se venisse
da Giuliano personalmente — non compare da nessuna parte nella sessione, mentre
Fabrizio Mastracci sta iniziando a configurare la prima email. È almeno presente
nel suo stesso testo del 20 agosto.

### 30.6 Il recap del 20 agosto, e ciò che il cliente deve ancora

Elena Spini l'ha inoltrato nella casella ROMI alle 08:48Z con il corpo _"FYI"_.
**Il suo testo non era in questo record.** Elenca consegne con date ormai in
ritardo di due-tre settimane: **record DNS** da Matteo Distaso e **logiche dei
segmenti, criteri e dettaglio delle mail** da Rebecca Marmo, entrambi attesi per
il 21 agosto; un **documento landing page e campi nascosti** atteso per il 26
agosto su un Google Sheet indicato. Ancora aperti oltre a questi: screenshot dei
segmenti e dei flussi, i testi delle altre comunicazioni email e WhatsApp, loghi e
immagini (#14).

⚠ Il link al foglio è **corrotto in transito** e il file **non è stato aperto in
questo giro**. È la specifica dei campi nascosti su una pagina già realizzata.

### 30.7 Un org check che non ha pubblicato nulla, e che corregge due record

Riportato da Aurel Mrruku nella group DM Salesforce ROMI alle 10:04 CEST, in sola
lettura contro Pienissimo UAT al commit `012d49d`, esplicitamente in **modalità
report — nessuna riconciliazione, nessuna pubblicazione**.

🔴 **`Mappatura_Edizione__c` non è vuota**: **4 righe, 3 attive, che coprono 3
prodotti distinti** — contro **226 prodotti su 229 non mappati** e **17 ordini su
22 già su `Incassato`**, in crescita da 12 su 15. La lettura "nessuna riga" in
#121 è corretta e **la sostanza è peggiore, non migliore**.

🔴 **La copertura Apex misura 0 su 2.741 righe**, con l'ultima esecuzione dei test
ancora al **4 agosto**; le righe sono cresciute di 1.095 dal 2 settembre. ⚠ Il
conteggio **precede `d562af0`**, che ne ha aggiunte circa 290 lo stesso giorno.
**Registrato, non agito.**

Riportati e non ancora riversati nel registro: `Account.Partita_IVA__c` non ha
alcun permesso di modifica per nessun principal, System Administrator incluso; la
propagazione tranche-ordine è a 0 su 24 OrderItem; non esiste alcun flow
dichiarativo; sei componenti vivono solo nell'org; ogni permission set di progetto
raggiunge esattamente 1 utente su 9 attivi; `Product2` è sceso da 281 a 229; e
`Integration_Log__c` ha 32 errori su 57 righe.

⚠ **Questo sweep non ha aperto l'org.** Ogni cifra qui sopra viene dal check di
ROMI così come pubblicato su Slack, e `STATUS.md`, il mirror Notion e il
`build_state` del registro non ne portano nulla.

---

## 31. Aggiornamento 08/09/2026 — go-live 21 ottobre, il locale trova casa, e una password finisce in una trascrizione

`requirements-check` notturno dal watermark **2026-09-07T22:00Z**. Due sessioni
analizzate dalle trascrizioni integrali, una mail al cliente che ridefinisce il
piano, una PR in merge e un check org pubblicato su Slack.

### 31.1 🔴 Il go-live è il 21 ottobre, e il record del 07/09 era sbagliato

Alle **14:15Z** Elena Spini ha inviato `[ROMI-PIENISSIMO] - Stato Avanzamento
Progetto` a Sabatino Rinaldi, Fabrizio Paganelli, amministrazione@ e Marco
Montesi, cc Aurel Mrruku e Andrea Di Cicco:

| Milestone                  | Data                      |
| -------------------------- | ------------------------- |
| **UAT ready, Fase 1**      | 23 settembre              |
| **UAT e test**             | 23 settembre – 13 ottobre |
| **Approvazione soluzione** | 13 ottobre                |
| **Go-live Fase 1**         | **21 ottobre 2026**       |

La causa dichiarata è _"diversi temi ancora pending e i lavori stanno procedendo
a rilento"_ — il data model ancora aperto e le ripetute revisioni ai flussi di
analisi. Il piano è `Pienissimo_Project Plan 2.pptx`, salvato alle 14:08:27Z.

✅ **Questo corregge il §30.** Il _"21 settembre … entro il 13 dello stesso mese"_
della sessione interna del 07/09 erano **21 e 13 ottobre**, con il mese caduto
dalla parafrasi di Gemini. Il §30 registrava una data quindici giorni _prima_ del
registro eppure descritta come uno _slittamento_ che aggiunge settimane di
sviluppo, definiva la combinazione irriconciliabile e si rifiutava di agire. Quel
rifiuto era corretto: un elenco di decisioni di Gemini ha perso il mese da due
date producendo una lettura in apparenza coerente ma sbagliata nella direzione
oltre che nel valore.

🔴 **Il registro è invariato, deliberatamente.** `CTX-02`, la definizione di
priorità `M`, entrambe le tabelle delle milestone, la regola di escalation alla
Fase 2 e `go_live: 2026-10-06` dicono ancora 6 ottobre. `REQUISITI.it.md` è il
testo presentato per la firma, e al cliente è stata chiesta la presa visione ma
non ha risposto (**#128**). ⚠ La regola di escalation recita _"salvo diverso
accordo esplicito sulla data di go-live"_ — ora l'accordo esplicito c'è stato, e
la regola non è stata riesaminata.

🔴 **La Fase 2 è dichiarata fuori perimetro per iscritto.** La Slide 4 indica
**GLS**, **Teachable** e **Ordini Pienissimo Pro → Zoho Pienissimo Software SRL**
come `FUORI PERIMETRO DA QUOTARE`. L'ultimo è esattamente ciò che Pienissimo ha
contestato ed escalato a Daniela Morgese — **che non è tra i destinatari di questa
mail**. Un perimetro dichiarato non è un perimetro concordato, e la _"presa
visione"_ non è un'accettazione.

🟢 Il deck conferma inoltre, in un artefatto rivolto al cliente, che Anticipay è
**"ex CreditSafe"**, finora nominato solo in un inciso di trascrizione.

🔴 **Il margine su Zoho si dimezza.** Zoho scade il 31 ottobre: la sovrapposizione
passa da venticinque giorni a **dieci**.

🔴 **L'UAT parte fra quindici giorni su una build mai sottoposta a UAT.** Due ore
prima della mail Aurel Mrruku ha detto _"non abbiamo ancora fatto dei UAT noi"_ e
che un primo rilascio in produzione richiede _"almeno un paio di settimane"_
(**#134**). I nove flussi elencati per l'UAT includono diversi elementi che il
record dà per non realizzati o non provati.

Elena Spini ha verificato i quattro blocchi con il team in DM 32 minuti prima di
inviare e ha ricevuto da Aurel Mrruku **"OK da parte mia"** alle 16:03:59 CEST.
⚠ **Andrea Di Cicco era in quella DM e non ha risposto**; l'integrazione Mexal è
sua ed è uno dei nove flussi UAT.

### 31.2 🟢 Data Model Parte 4 — il locale diventa un record type dell'Account

Con il cliente, **12:01 CEST**, **1h25m58s**, analizzata dalla trascrizione
integrale. Elena Spini, Elisa Migliano, Aurel Mrruku. **Andrea Di Cicco assente
per la seconda sessione consecutiva**; Fabrizio Paganelli invitato e silente.

**Concordato:** _"I locali vengono configurati come account figli dell'azienda di
fatturazione su Salesforce, mentre a Mexal vengono inviate unicamente le aziende
padri."_ I preventivi portano un lookup allo specifico locale.

✅ **Questo risolve #123.** Elisa Migliano ha portato la risposta di Marco
Montesi — il questionario contiene **dati operativi del 2022** e una sola azienda
può possedere più locali con condizioni diverse. La risposta è un **record type
su un oggetto che esiste già**, non il nuovo oggetto che #123 temeva con
relazioni, layout e migrazione.

🟢 **Realizzato la stessa sera.** PR **#35** / commit `c877631` (Anita Aga, merge
di Aurel Mrruku alle 18:21 CEST): record type `Azienda` e `Locale`, le regole di
validazione `locale_requires_parent_azienda` e `parent_must_be_azienda`,
`AccountTriggerHandler` con protezione dalla cancellazione,
`CommercialAccountResolver`, dieci campi Account, e `WoocommerceOrderService` e
`LeadConversionQueueable` aggiornati per risolvere sul padre.

Concordato anche:

- **Contratti, preventivi e biglietti vanno solo al `contatto principale`
  dell'azienda di fatturazione** — per ragioni legali, mai al singolo locale. Gli
  invii DocuSign consentiranno indirizzi aggiuntivi in CC. I tutor vanno istruiti.
- **L'invio dei biglietti è una decisione di calendario marketing, non un trigger
  di pagamento.** Non esiste una regola fissa che leghi l'invio al pagamento delle
  tranche.
- **Il controllo duplicati si sposta sul Lead, su email E telefono in combo** —
  scelto rispetto all'"o l'uno o l'altro" perché un cliente può avere più
  indirizzi email. I campi di controllo telefonico ereditati da Zoho sono
  cancellati dall'opportunità.
- **La lista campi dell'opportunità è ripulita**: custom che duplicano lo
  standard, dettaglio indirizzo, durata del ciclo di vendita e tempo di
  conversione rimossi; motivazione di chiusura persa mantenuta; importo guidato
  dal preventivo principale; le checkbox di passaggio a Pienissimo Software/Zoho
  rimosse finché quel flusso di Fase 2 non sarà analizzato.
- **La denominazione delle opportunità da QR code e moduli web** è standardizzata
  da Marketing Cloud più un trigger di backend, in base alla provenienza.

🟢 **Parte 5 (mer 16/09) e Parte 6 (ven 18/09), due ore ciascuna** — prodotti,
preventivi e ordini, poi campagne e lead **con Rebecca Marmo**. Prima i prodotti,
su richiesta di Aurel Mrruku, in quanto propedeutici.

🔴 **La tabella Lead è rinviata per la quinta volta**, e **Utenti, Profili e il
piano di caricamento iniziale non sono in nessuna sessione in calendario**
(**#24**). Cinque sessioni, tre oggetti. Dalla sessione escono quattro nuove
consegne cliente — **#129, #130, #131** — più il controllo tecnico di Aurel
Mrruku **#132**.

### 31.3 🔴 Flussi MKT Parte 2 — una password letta a voce, e flussi non testabili

Interna ROMI, **14:32 CEST**, **42m21s**. Elena Spini, Aurel Mrruku, Fabrizio
Mastracci; Aurel Mrruku è uscito verso 00:26.

🟢 **Il record di invito porta le date.** Concordato: mettere **`data evento`** e
**`data invio`** direttamente su `Event_Invitation__c`, insieme alla mail
dell'account, così il flusso Marketing Cloud parte su `data invio = oggi` e **non
interroga mai la Campagna**. Questo supera sia il controllo notturno a 60 giorni
sulle campagne sia la controproposta di Fabrizio Mastracci con campo formula e
checkbox. 🔴 Il costo, nominato da Aurel Mrruku stesso — **trigger per propagare
una data modificata su tutti i record di invito già generati** — non è realizzato
né stimato, e restano due design aperti.

🔴 **Una password della sandbox UAT Salesforce è stata letta a voce** per aggirare
un problema di One Password, e **Fabrizio Mastracci è entrato come Aurel Mrruku**
invece che con un'utenza propria. Gemini l'ha trascritta alla lettera in un
documento Drive condiviso e collegato all'evento di calendario. **Il valore non è
riportato in questo repository.** Il rilievo che dura è l'utenza condivisa: tutto
ciò che Fabrizio Mastracci fa in UAT è attribuito ad Aurel Mrruku, il che corrompe
`LastModifiedBy` come evidenza — e **Utenti e Profili è la sezione del workbook
che nessuno ha aperto in cinque sessioni**. Seconda divulgazione di credenziali in
cinque giorni, quarto rilievo su autenticazione in sei.

🔴 **I flussi marketing non sono testabili end to end** (**#134**): nessun dominio
autenticato in sandbox, nessuna community in produzione, e un primo rilascio in
produzione a due settimane.

🟢 **Il vocabolario dei tag è completo.** `SEGMENTI FUNNEL BIGLIETTI.docx`
aggiunge due membri ai due decodificati alla Parte 3: `<EVENT>` per il contatto
principale che possiede almeno un biglietto, e **`<EVENT>_R` per la rinuncia**.
⚠ Solo `_R` è un vero valore in Tag Associati; gli altri tre sono proprietà di
contatto scritte dal CRM.

🔴 **La regola di uscita dal funnel è un aggregato a livello di contatto, non un
flag sull'asset** — _"un contatto avente 3 biglietti può decidere di partecipare
anche solo con 1 biglietto e … esce dal funnel"_. Un booleano per Asset non può
esprimerla (**#126**).

🔴 **I template WhatsApp non ci sono** tra i quattro allegati di Rebecca Marmo,
verificato dal vivo; Elena Spini ha confermato che esistono lato cliente
(**#133**). ⚠ Due dei tre documenti di funnel sono di fatto vuoti come testo, con
la logica dentro screenshot che **non** sono stati letti in questo record.

### 31.4 ✅ L'endpoint WooCommerce è arrivato al cliente

Aurel Mrruku ha inviato a Sabatino Rinaldi la **collection Postman** alle 14:17Z,
dopo un sollecito su Slack di Elena Spini quella mattina — dodici giorni dopo che
il lato cliente era pronto (**#102**).

🔴 **Le credenziali non sono state ruotate prima**, come questo record ha chiesto
due volte: l'assertion JWT il cui `exp` è a circa sessant'anni è andata al cliente
invariata. **Quel pattern ha ora lasciato ROMI.**

⚠ **Esiste una collection più recente e non è questa.** Quaranta minuti _dopo_
l'invio, Aurel Mrruku ha chiesto ad Andrea Di Cicco in DM la collection
aggiornata; Andrea Di Cicco ha risposto _"Devo mettere i filtri ancora"_. Sabatino
Rinaldi ha la versione senza filtri, e a fine giornata non aveva risposto.

### 31.5 ⚠ Un check org è girato, non ha pubblicato nulla, ed è stato superato da un merge

Scope completo, modalità report, **16:31–16:39 CEST**, UAT live contro `c81578f`,
pubblicato solo nel gruppo di sviluppo.

⚠ **I suoi rilievi di drift org-only si sono chiusi da soli.**
`AccountTriggerHandler`, `CommercialAccountResolver`, `AccountTrigger`, i record
type Account e dieci campi Account risultavano presenti in UAT e assenti dal
checkout — e sono stati **committati alle 17:53 e mergiati alle 18:21**, novanta
minuti dopo. _Un check org è una fotografia di un ramo in movimento: fare il diff
di `DevMain` prima di credere a qualunque affermazione di drift._ È la seconda
volta che la lezione arriva, dopo il 04/09.

Ciò che resta:

| Rilievo                  | Dettaglio                                                                                                                                                                                                       |
| ------------------------ | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Mappatura edizioni**   | **40 su 43** prodotti che generano biglietti non hanno mappatura attiva; 3 righe attive coprono 3 prodotti; **22 su 27** ordini su `Incassato`. Corregge il denominatore 226/229 su tutti i prodotti (**#121**) |
| **Propagazione tranche** | 34 righe di preventivo collegate, **0 su 32 righe d'ordine**; nessuno scrittore nell'Apex ispezionato, nessun Flow attivo (**#50**)                                                                             |
| **Inviti**               | 3 record con URL Ready e raccolta Pending, nessuno con destinatario o `Send_After`                                                                                                                              |
| **Biglietti**            | **0 Asset con valore QR**; 15 Asset, 14 Ordinato, 1 Assegnato; nessuno dei due controller invoca la firma (**#68/#78**)                                                                                         |
| **Notifica Anticipay**   | ancora compilata verso una casella di uno sviluppatore ROMI; 36 log su 65 marcati come errore (**#119**)                                                                                                        |
| **Auth community**       | i controller accettano ancora identificatori di record senza stabilire l'identità del chiamante                                                                                                                 |
| **Flow**                 | zero, confermato per tre vie — listing Metadata, `FlowDefinition` via Tooling, query sui Flow attivi                                                                                                            |
| **Coverage**             | **0 su 2.957 righe**, 42 voci, ultima esecuzione dei test ancora 4 agosto (**NFR-06**)                                                                                                                          |
| **Accesso tranche**      | i campi esistono con permessi di modifica; un assegnatario attivo, un System Administrator — **non** un rilievo del tipo "nessuno può accedervi"                                                                |

⚠ **Questo sweep non ha aperto l'org.** Ogni cifra qui sopra viene dal check di
ROMI così come pubblicato su Slack. `STATUS.md`, il mirror Notion e il
`build_state` del registro non ne portano nulla, per la nona esecuzione.

---

## 32. Aggiornamento 09/09/2026 — il cliente ha preso visione, e il registro si è mosso per la prima volta da v1.4

`requirements-check` interattivo dal watermark **2026-09-08T22:00Z**. Giornata
magra: **un solo** messaggio Pienissimo in tutta la finestra, nessuna riunione,
nessun commit, nessuna attività su Drive per questo progetto. Quell'unico
messaggio fa tre cose.

### 32.1 ✅ "Presa visione" — e la data di go-live è ora il 21 ottobre nel registro

Alle **07:08:22Z** **Fabrizio Paganelli** ha risposto nel thread
`[ROMI-PIENISSIMO] - Stato Avanzamento Progetto`, a Elena Spini e agli altri tre
destinatari lato cliente, cc Aurel Mrruku, Andrea Di Cicco e — novità —
`daniela@pienissimo.com`:

> _"Ciao Elena, presa visione e aggiungo Daniela in cc, per sua conoscenza.
> Fabrizio"_

_"Presa visione"_ è testualmente la formula richiesta da Elena Spini l'08/09:
_"conferma di avvenuta lettura e di **presa visione delle nuove tempistiche** e
del perimetro di progetto."_ Per la **data**, è la conferma che il §31 attendeva.

**Il registro è stato aggiornato lo stesso giorno**, in entrambe le lingue nella
stessa sessione — la prima modifica ai requisiti da `version: "1.4"` del
2026-08-24:

| File                                        | Modifiche                                                                                                      |
| ------------------------------------------- | -------------------------------------------------------------------------------------------------------------- |
| `requirements/pienissimo-requirements.yaml` | `go_live: 2026-10-21`, testo di `CTX-02`, `version: "1.5"`, `date: 2026-09-09`, più un commento di provenienza |
| `REQUIREMENTS.md`                           | `CTX-02`, la definizione di priorità `M`, la tabella milestone del §1.1, la regola Fase 2 del §14              |
| `REQUISITI.it.md`                           | `CTX-02`, la definizione di priorità `M`, la tabella milestone del §1.1, la regola Fase 2 del §14              |

⚠ **Un riferimento al 6 ottobre è stato lasciato di proposito**, al §2.2 di
entrambi i testi — _"non concorrono alla data del 6 ottobre"_. Quel paragrafo è
introdotto da _"Punto da dirimere in questa sessione"_ e registra la **sessione di
sign-off del 06/08**. Modificarne la data significherebbe citare la sessione in
modo errato: è una citazione, non una regola viva.

⚠ **La regola di escalation del §14 è stata ri-datata, non riesaminata.** Ora
recita _"le richieste che mettono a rischio la data del 21 ottobre 2026 sono
automaticamente candidate alla Fase 2, salvo diverso accordo esplicito sulla data
di go-live"_ — e la data è appena stata rinegoziata una volta, che è esattamente
il precedente che la regola esiste per contenere.

### 32.2 🟢 Daniela Morgese è nel thread, e ce l'ha messa il cliente

La cosa più significativa della risposta è la metà che nessuno aveva chiesto.
Fabrizio Paganelli ha aggiunto la decisore di Pienissimo al thread
**spontaneamente, nella prima frase**.

**È il primo movimento sulla controversia di perimetro Fase 2 da sessantuno
giorni.** Dal 10 luglio la diagnosi costante del progetto è che la controversia
non si chiude perché non è mai arrivata a lei — nelle parole di Sabatino Rinaldi
il 06/08, _"Daniela non sapeva questa informazione qui."_ Ora è su un thread che
contiene il perimetro scritto, il link al piano e l'invito a leggere la **Slide
4**, dove gli `Ordini Pienissimo Pro (SFDC → Zoho Pienissimo Software SRL)` sono
elencati `FUORI PERIMETRO DA QUOTARE`.

⚠ **Da non sopravvalutare.** È **in cc, non fra i destinatari**; _"per sua
conoscenza"_ è informativo; non le viene chiesto nulla; non ha risposto; e **non
esiste ancora una quotazione Fase 2** che possa accettare o rifiutare — il `#83`
non si muove, ed è ormai a cinque settimane dal _"dopo le ferie"_. Quello che le è
stato inviato presenta il perimetro come acquisito e non menziona che la sua
stessa azienda ne contesta una parte da luglio.

⚠ `daniela@pienissimo.com` **non era mai comparso nel record prima di oggi**.

### 32.3 🔴 Il perimetro non è stato accettato, e tre destinatari su quattro non hanno risposto

Il record dell'08/09 aveva previsto per iscritto questo esito: _"se la risposta è
una presa visione secca, la controversia di perimetro non è chiusa da essa e non
va registrata come chiusa."_

È una presa visione secca. Quattro parole di sostanza. Non nomina la Slide 4, la
Fase 2, GLS, Teachable, gli `Ordini Pienissimo Pro` o la quotazione. **La
controversia resta aperta, immutata nella sostanza dal 6 agosto.**

| Destinatario                                    | Ha risposto     |
| ----------------------------------------------- | --------------- |
| **Fabrizio Paganelli** — prodotto e anagrafiche | ✅ 09/09 07:08Z |
| **Sabatino Rinaldi** — project lead             | 🔴 no           |
| **Elisa Migliano** — `amministrazione@`         | 🔴 no           |
| **Marco Montesi** — vendite                     | 🔴 no           |

⚠ **Il silenzio di Sabatino Rinaldi è quello che pesa.** È il project lead del
cliente, ha portato la controversia a Daniela Morgese, e il 06/08 ha ammesso di
non aver letto la minuta che la segnalava — _"Io non l'ho nemmeno letto quello, ho
preso direttamente il link."_ Un perimetro che non ha preso in carico è un
perimetro di cui può dire di non aver avuto notizia.

⚠ **Il tema scadenzario Mexal resta invisibile a chi l'ha chiesto.** La sessione
del 07/09 ha rinviato alla Fase 2 il percorso di correzione dello scadenzario. Era
**una richiesta di Fabrizio Paganelli stesso**. Ha ora scritto _"presa visione"_ su
un perimetro che la contiene tacitamente, e né la mail né la Slide 4 la nominano.

### 32.4 🔴 Le quattro decisioni bloccanti non hanno avuto alcuna risposta

Nulla nella risposta le affronta:

| Tema                              | Stato dopo il 09/09                                                  |
| --------------------------------- | -------------------------------------------------------------------- |
| **Licenze DocuSign** (`#111`)     | 🔴 senza risposta — indicata come bloccante per il flusso preventivi |
| **Review form marketing** (`#14`) | 🔴 senza risposta                                                    |
| **Data model** (`#24`)            | 🔴 WIP; Parte 5 il 16/09, Parte 6 il 18/09                           |
| **Data migration** (`#79`)        | 🔴 formalmente in stand-by                                           |

**L'UAT inizia il 23 settembre — fra quattordici giorni — e `Preventivi, Contratti
e Firme Digitali (DocuSign)` è nella sua lista.** La dichiarazione di Aurel Mrruku
dell'08/09 resta non riconciliata e di un giorno più vecchia: _"non abbiamo ancora
fatto dei UAT noi"_, rilascio in produzione _"almeno un paio di settimane"_.

⚠ **Questo sweep non ha aperto l'org.** `STATUS.md`, il mirror Notion e la pagina
Flows sono dovuti da `org-status-check` per la **decima** volta.

## 33. Aggiornamento 09/09/2026 (sera) — le automazioni dei processi commerciali sono state rilasciate

**PR #37 / `a53345a`** (Anita Aga, _"Added automations for opportunity, order and
relating commercial processes to Azienda record type"_), merged su `DevMain` da
Aurel Mrruku alle **18:41 CEST** come `0fe07f6`. **30 file, +1.499 / −74 righe,
+729 righe Apex nette.** È arrivata dopo lo sweep interattivo della mattina,
quindi nessuna sezione precedente di questo documento la contiene. Nota di build
completa:
[le automazioni dei processi commerciali](../notes/objects/The%20commercial%20process%20automation.md).

⚠ **Letto dal repository a `0fe07f6`, non dall'org.** L'ultimo controllo org è
dell'**08/09 16:31–16:39 CEST** e precede sia questo merge sia `c877631`.

### 33.1 🟢 Un preventivo accettato genera il suo ordine — il primo codice che lo abbia mai fatto

`QuoteTriggerHandler.createOrdersForAcceptedQuotes` scatta sulla transizione di un
preventivo verso `Accettato` e crea un `Order` per preventivo (`Status =
'Ordinato'`, `EffectiveDate = OGGI`, `Origine__c = 'Salesforce'`, con account,
opportunità, listino e locale), poi copia ogni `QuoteLineItem` in un `OrderItem`.
Una query di guardia su `Order.Quote__c` impedisce la doppia generazione.

🟢 **Le righe ordine portano `Tranche__c` e `Data_Scadenza__c`.** Questo chiude la
lacuna che il [#50](open-items.it.md) porta dal 25 agosto — `OrderItem.Tranche__c`
ha finalmente uno scrittore — e fornisce la `data di scadenza` che il tracciato
ordini Mexal richiede su ogni riga.

🔴 **Solo gli ordini nati da preventivo la ricevono.** Gli ordini WooCommerce e
quelli creati a mano restano senza tranche e senza data di scadenza, e il
tracciato la vuole su **ogni** riga. 🔴 **L'aggregazione dei pagamenti della
tranche è ora l'unica lacuna davvero non costruita** delle tre registrate il
25 agosto: `Completamente_Pagata__c` resta una casella che nessuno calcola.

### 33.2 🔴 DocuSign è assente dall'intero diff

Il disegno concordato prevede che un preventivo accettato produca una busta
firmata e **poi** l'ordine. Qui è costruita la metà ordine e nessuna busta. Arriva
sette giorni dopo che il [#111](open-items.it.md) ha registrato che **nessuno ha
confermato che il cliente possieda DocuSign**, e nulla nel commit, nella PR o in
alcun messaggio collega le due cose.

**Se l'ordine delle due fasi sia una decisione o una dimenticanza non è registrato
da nessuna parte. Chiedere, non dedurre.** `Preventivi, Contratti e Firme Digitali
(DocuSign)` è nella lista UAT del 23 settembre.

### 33.3 🟢 Il ciclo di vita dell'Opportunità esiste, e coincide esattamente con il registro

`standardValueSets/OpportunityStage` è ora in source control con cinque valori —
`Qualificato` (default, 10%), `In trattativa (Prev inviato)` (75%),
`Da ricontattare - Prev. inviato` (35%), `Chiusa/Vinta` (100%, vinta),
`Chiusa/Persa` (0%) — resi da una nuova LWC `opportunityCustomPath`. Due
transizioni sono automatiche: la creazione di un preventivo porta in trattativa
un'opportunità `Qualificato`, e un ordine che raggiunge `Incassato` la chiude
vinta.

🟢 **I cinque valori coincidono con il registro carattere per carattere** in
`state_machines.opportunity.states`, e la regola di chiusura vinta è implementata
come scritta — il _"Chiusa/Vinta requires at least one quote sent; payment confirms
the win"_ del registro **è** `closeWonOpportunitiesForConfirmedOrders`. È una
build fedele, non uno scostamento.

🔴 **Sono gli stati del Preventivo a divergere, e questo commit approfondisce la
divergenza.** Gli `state_machines.quote.states` del registro (`In trattativa (Prev
inviato)`, `In attesa di accettazione`, `Accettato - Copia Contabile Ricevuta`,
`Rifiutata`, senza `Nuovo Preventivo`) non hanno mai coinciso con il codice
costruito (`In Trattativa`, `In Attesa Accettazione`, `Accettato`, `Rifiutato`,
`Nuovo Preventivo`). ⚠ Il registro **è in disaccordo con se stesso** — il suo
blocco `build_state` riporta la grafia del codice. `a53345a` aggiunge una **terza**
classe che cabla quella grafia. Riconciliare è una modifica di requisito che tocca
lo YAML e entrambi i documenti in prosa, e qualcuno deve prima decidere quale
grafia sia canonica ([#59](open-items.it.md)).

🔴 Nulla automatizza `Chiusa/Persa` né `Da ricontattare - Prev. inviato`, e
restano non costruiti la validità di 5 giorni, la scadenza obbligatoria all'invio,
gli alert al giorno 2 e alla scadenza, la mail al titolare dopo 3 giorni, il
pulsante di creazione manuale e il ripristino dei preventivi scaduti
([#59](open-items.it.md)).

### 33.4 🟢 La separazione Azienda/Locale è ora costruita da capo a fondo

`c877631` ha costruito i record type; questo commit li porta attraverso il
processo commerciale, che è esattamente quanto
[la decisione](../notes/decisions/Decision%20-%20Account%20record%20types%20split%20Azienda%20and%20Locale.md)
elencava sotto **Process Ownership** e lasciava da fare:

- lookup `Locale__c` verso Account su **Opportunità, Ordine e Preventivo**;
- `OpportunityTriggerHandler.normalizeCommercialAccounts` riscrive
  un'opportunità aperta su un `Locale`: il locale passa in `Locale__c`,
  `AccountId` diventa l'Azienda padre tramite `CommercialAccountResolver`;
- `QuoteTriggerHandler.copyLocaleFromOpportunity` eredita il locale e solleva un
  errore di campo quando preventivo e opportunità divergono;
- regola di validazione `Opportunity.Locale_must_belong_to_azienda`;
- `WoocommerceOrderService` imposta `RecordTypeId = Azienda` sugli account che crea.

🔴 **Una nuova modalità di errore su una rotta inbound attiva.**
`WoocommerceOrderService` ora **solleva un'eccezione quando il record type
`Azienda` non viene trovato**. L'UAT ce l'ha; **la produzione non ha mai ricevuto
un deploy e non ce l'ha**. Il primo rilascio in produzione ha quindi un vincolo di
sequenza che nessuno ha messo per iscritto.

⚠ **L'Ordine è normalizzato solo per ereditarietà** — un ordine creato
direttamente su un account `Locale` non viene riscritto, e `Order` non ha una
regola di validazione corrispondente a quella sull'Opportunità.

### 33.5 🔴 La pagina community non autenticata ora crea record commerciali

`QuoteAcceptanceController.act()` non è stato modificato. È cambiato ciò che
**provoca**.

La pagina imposta ancora `Status = 'Accettato'` su un preventivo identificato da
un **id nudo, senza autenticazione applicativa**. Il nuovo trigger scatta
esattamente su quella transizione. Quindi lo stesso click anonimo che prima
cambiava un picklist ora **inserisce un Ordine, inserisce un OrderItem per ogni
riga del preventivo e fa avanzare l'Opportunità**.

Poiché l'ordine nasce in `Ordinato` e non in `Incassato`, **non** fa scattare
l'eccezione del [#121](open-items.it.md) che lo avrebbe annullato: resta,
silenziosamente. **Nulla mostra che la cosa sia stata considerata.** Vedi
[il rischio](../notes/risks/Risk%20-%20the%20community%20pages%20have%20no%20application-level%20authentication.md).

### 33.6 🔴 +729 righe Apex non coperte, e un test esistente rimasto indietro

| Classe                         | Righe nette | Nuova?           |
| ------------------------------ | ----------- | ---------------- |
| `LeadConversionTriggerHandler` | +248        | nuova (estratta) |
| `QuoteTriggerHandler`          | +219        | **nuova**        |
| `LeadConversionQueueable`      | +134        | rifattorizzata   |
| `OpportunityTriggerHandler`    | +62         | **nuova**        |
| `OrderTriggerHandler`          | +47         | esistente        |
| `WoocommerceOrderService`      | +19         | esistente        |

L'ultimo dato **misurato** è **0 su 2.957** (controllo org ROMI dell'08/09), che
precede questo merge. Letti insieme: **almeno 3.686 righe, ancora zero coperte**, e
l'ultima esecuzione reale dei test Apex è **ancora il 4 agosto**.

🔴 `OrderTriggerHandlerTest` **non è stato aggiornato** per il comportamento di
chiusura opportunità aggiunto alla classe che copre. Se compili ancora non è stato
verificato.

⏸ **Registrato, non agito.** La suite di test è un'attività separata che Aurel
Mrruku richiede in un'unica passata prima del rilascio in produzione.

### 33.7 ⚠ La collection WooCommerce con i filtri è stata sollecitata di nuovo e non è arrivata

Andrea Di Cicco l'aveva promessa tra le 17:00 e le 18:00 dell'08/09. Aurel Mrruku
ha sollecitato in DM alle **12:26 CEST** — _"alla fine non mhai passato la
collectioon"_ — **senza risposta undici ore dopo**. Sabatino Rinaldi ha ancora la
collection **pre-filtri**, **il JWT a sessant'anni non è stato ruotato**, e non è
tornato alcun esito di test ([#102](open-items.it.md)). ⚠ Il 9–11 settembre è
l'offsite ROMI, spiegazione sufficiente per un giorno di silenzio.

## 34. Aggiornamento 10/09/2026 — il primo Apex Mexal, su una pull request che nessuno ha aperto

**Lo sviluppo della Fase 1 doveva chiudersi oggi.** Si chiude con il primo codice
dell'integrazione Mexal fermo su una pull request non revisionata, una credenziale
incollata su Slack e cinque record mossi da un file Postman.

### 34.1 🟢🔴 PR #39 — il primo trasporto Mexal, **aperta e non mergiata**

**`bc2ed5d`** (Anita Aga, _"Edited Create Tranch Lwc, and opportunity custom path,
added logic for Mexal Integration"_), spinto alle **17:58 CEST**, aperto come PR
**#39** due minuti dopo verso `DevMain`. **17 file, +682 / −94 righe, +496 righe
Apex nuove.** 🔴 **Non è mergiata**: `DevMain` finisce ancora a `9113453`.

⚠ **Letto dal repository, non dall'org.** Nessun test è stato eseguito.

**`MexalSearchCalloutService` (260 righe)** — un wrapper di callout guidato dalla
configurazione, che legge `Integration_Configuration__c`.

- 🟢 **Autenticato tramite Named Credential** (`callout:Mexal<path>`, righe
  separate per sandbox e produzione), e la riga `Integration_Log__c` scrive
  deliberatamente `Authorization=<managed by Named Credential>`. **Il segreto non
  arriva mai al log.** Dopo il JWT a sessant'anni, è la prima integrazione del
  progetto costruita come il record chiedeva da tempo.
- 🟢 **Vincolato in sola lettura** da tre controlli indipendenti: una allow-list
  di due azioni, il rifiuto di qualsiasi path che non finisca in `/ricerca` e il
  rifiuto di qualsiasi metodo diverso da `POST`. **Per costruzione non può
  scrivere su Mexal.**
- 🔴 **La named credential e la sua external credential esistono solo nell'org.**
  Il repository **non ha alcuna cartella `namedCredentials/`**, eppure
  `Full_Permission` concede ora `Mexal_External_Credential-Mexal_Principal`. Un
  permission set che nomina un principal assente **fallisce il deploy**: lo schema
  delle credenziali solo-org ha smesso di essere un'assenza e ha iniziato a
  bloccare i rilasci.
- 🔴 **`Integration_Configuration__c` ha ancora zero righe**, e ora ne servono due
  con nome esatto — `Mexal_Clienti_Ricerca` e `Mexal_Articoli_Ricerca`. Seconda
  tabella a manutenzione manuale in una settimana da cui dipende del codice, senza
  nessun titolare assegnato.

**`MexalCustomerSearchService` (236 righe)** — la lettura dell'anagrafica.

- 🟢 Costruisce il filtro delta `data_ult_mod >=` concordato e mappa
  **quattordici** campi cliente Mexal su `Account`, inclusi `codice_sdi`, `pec` e
  un IBAN ricostruito.
- 🔴 **Nulla viene salvato.** I record `Account` mappati tornano in memoria.
  **Nessuna DML, nessuna upsert, nessun match su `Codice_Cliente_Mexal__c`.**
  Il [#116](open-items.it.md) ottiene una lettura, non una sincronizzazione.
- 🔴 **Il job notturno è commentato per scelta**, e il codice dichiara il proprio
  blocco: _"Automatic daily search is intentionally paused while the Mexal sync
  schedule and date window are finalized."_ Quella finestra è senza specifica dal
  03/09.
- 🔴 Il payload di riassegnazione agente non è mappato; il blocco del
  [#117](open-items.it.md) è intatto.
- ⚠ **Una mappatura da verificare prima del merge:** `IBAN__c` preferisce
  `banca_appoggio` all'IBAN ricostruito, quindi nel campo IBAN potrebbe finire il
  _nome_ di una banca. Letto dal codice, non confermato su una risposta reale.

**Il resto del commit.** 🟢 **La decisione non prezzata del 03/09 sulla
traduzione in italiano** viene eseguita: tutte le stringhe visibili di
`opportunityCustomPath`, `quoteCreateTranche`, la quick action `Crea Tranche` e
due eccezioni Apex. 🟢 Due correzioni funzionali sull'editor delle tranche: le
tranche in cancellazione non fanno più scattare il controllo "già assegnata", e
una tranche vuota è cancellabile anche in modifica. 🔴 **Nessun valore di stato
di Opportunity o Quote è cambiato** — solo le etichette intorno: il disaccordo
sugli stati Quote del [#59](open-items.it.md) resta intatto.

### 34.2 🔑🔴 La credenziale WEBAPI Mexal è finita in una DM Slack

Aurel Mrruku ha inviato ad Anita Aga **`Mexal Dev v.2.postman_collection`** alle
**14:45:51 CEST**. **Tutte e quattordici le richieste portano l'header
`Authorization` Passepartout attivo.** **Terza credenziale circolata in chiaro in
sette giorni**, dopo il JWT WooCommerce (04/09) e la password di sandbox
pronunciata in una trascrizione Gemini (08/09) — tre segreti, tre canali, tre
persone. Il fattore comune è che il progetto **non ha un posto concordato dove
metterne uno**.

⚠ **Il valore non è in questo repository e non deve mai esserci.** È registrato:
che esiste, di che tipo è, dove è finito e quando.

🟢 Il codice scritto da essa tre ore dopo fa la cosa giusta — vedi 34.1. Quindi la
credenziale non avrebbe avuto bisogno di viaggiare.

### 34.3 Che cosa risolve la collection

È la prima formulazione leggibile del contratto Mexal, e muove cinque righe.

- ✅ **`azienda` è `PIE`, non `PE`.** Il verbale del 07/09 conteneva una svista di
  trascrizione; la voce del 15 luglio delle note diceva `PIE` da sempre. Ora i due
  artefatti concordano.
- 🔴 **`anno` è sbagliato in due direzioni.** La collection fissa `Anno=2025`; il
  codice invia `Date.today().year()`, quindi `2026`. Sono usciti a tre ore di
  distanza e **nessuno ha deciso**. La domanda originaria — è un selettore di anno
  fiscale, e che succede al confine — resta non posta.
- 🟢 **Il [#125](open-items.it.md) ha risposta**: `Modifica Cliente` è
  **`PUT /clienti/{codice}`** con il corpo completo, chiavato sul codice cliente
  Mexal. 🔴 Resta aperto: il codice costruito è vincolato a POST su `/ricerca` e
  **non può emettere una PUT**.
- 🔴 **Il [#110](open-items.it.md) ha risposta negativa**: il corpo di creazione
  `ordini-clienti` porta `sigla`, `serie`, `numero`, `cod_conto`,
  `data_documento` e cinque array di riga — **nessun `cod_agente`, nessuna `zona`,
  nessun `classificatore rete`**. Il codice agente lo porta solo il _cliente_.
  **Questo contraddice la regola di congelamento delle provvigioni sull'ordine
  concordata il 03/09**: una riassegnazione successiva riattribuirebbe
  retroattivamente ogni ordine passato. ⚠ È la lettura di una collection, non una
  dichiarazione di Mexal — **chiedere a Mirko Merendi di Kreosoft.**
- 🟢🔴 **[#50](open-items.it.md) — la tranche ha finalmente un meccanismo Mexal.**
  Una rata è un'**evasione `FT`** di righe d'ordine indicate a una data, con dieci
  riferimenti all'`OC` di origine. 🔴 **Ma il corpo dell'ordine non porta alcuna
  `data di scadenza` di riga** — proprio il campo che la PR #37 aveva propagato su
  `OrderItem` il giorno prima. Non riconciliato.
- 🟢 **L'ambiguità di 24 ore del [#109](open-items.it.md) è sciolta dalla build** —
  `Account.Codice_Destinatario_SDI__c`, Testo(7), _"restituito da Mexal"_. Mexal,
  non Anticipay.
- 🟢 Corroborati anche: gli agenti sono `POST /risorse/fornitori/ricerca`; la
  lettura fatture è il doppio passo N+1; `scadenzario/ricerca` esiste ed è
  filtrabile per codice cliente. ⚠ `serie: 10` ovunque — la serie di **test**.

### 34.4 🔴 Copertura: +496, e la prima classe di callout nel brief

| Classe                       | Righe nuove | Test    |
| ---------------------------- | ----------- | ------- |
| `MexalSearchCalloutService`  | 260         | nessuno |
| `MexalCustomerSearchService` | 236         | nessuno |

Stima oltre le **4.182 righe, ancora zero coperte**, ultima esecuzione reale dei
test Apex **ancora il 4 agosto**. 🔴 `MexalSearchCalloutService` è una classe di
**callout HTTP** — la categoria che richiede `HttpCalloutMock`, o il percorso
`Use_Mock__c` dello scaffolding di casa. ⏸ **Registrato, non agito. Nessuna classe
di test scritta né proposta.**

### 34.5 ⚠ Secondo giorno di silenzio sulla collection WooCommerce

Il sollecito del 09/09 è **ancora senza risposta**, e la trasferta aziendale non
lo spiega più da sola: **il 10/09 Andrea Di Cicco è stato attivo nella stessa DM
alle 14:44–14:47 CEST**, su altri clienti. Sabatino Rinaldi ha ancora la
collection **pre-filtro**, **il JWT a sessant'anni non è stato ruotato**, non è
tornato alcun esito di test ([#102](open-items.it.md)), e **gli UAT iniziano fra
tredici giorni**. ⚠ Quel pomeriggio si è mossa una collection _Mexal_: non è
questa.

### 34.6 Tutto il resto nella finestra

**Niente.** Nessun messaggio Pienissimo su Gmail; l'elemento Pienissimo più
recente su Drive è ancora dell'08/09 e né il `.drawio` né il workbook si sono
mossi; Fathom non ha registrato riunioni; `#tproj-pienissimo` tace dal 04/09 e il
suo blocco di stato riporta ancora **go-live 6 ottobre**, tre giorni dopo lo
spostamento del registro al 21 ottobre.

## 35. Aggiornamento 11/09/2026 — l'integrazione Mexal inizia a scrivere

Fonte: `DevMain` a `c9a0b7e`, letto direttamente. **Tutte le fonti esterne non
hanno restituito nulla**: nessuna mail Pienissimo, nessun movimento su Drive,
nessuna registrazione Fathom, nessun messaggio Slack su questo progetto. L'intera
sezione proviene dal repository e da GitHub.

### 35.1 Due merge, e il secondo supera una soglia

**La PR #39 è stata unita alle 10:27 CEST** (`b9cfc1b`), portando sul branch di
lavoro l'Apex di lettura Mexal del giorno precedente. Poi la **PR #41** /
**`80420cf`** (Anita Aga, _"Added logic for API calls (Ricerca,Creazione,Modifica)
rebuilt the Integration Configuration object."_) è stata pushata alle **17:57**,
aperta alle **17:58** e **unita alle 18:05 CEST** — **sette minuti, nessuna
descrizione, nessuna revisione**. **32 file, +1.326 / −193 righe.**

**È il primo codice del progetto che scrive su Mexal.**

### 35.2 🟢 Il blocco di sola lettura è stato esteso, non rimosso

`MexalSearchCalloutService` ha ora due allow-list anziché una: `READ_ONLY_ACTIONS`
(`Mexal_Clienti_Ricerca`, `Mexal_Articoli_Ricerca`), che continua a rifiutare ogni
path non terminante in `/ricerca` e ogni metodo diverso da `POST`; e la nuova
`WRITE_ACTIONS` (`Mexal_Clienti_Creazione`, `Mexal_Clienti_Modifica`) con una
propria validazione. Un'azione di lettura non può raggiungere un endpoint di
scrittura, e la superficie di scrittura è esattamente due azioni nominate.
L'autenticazione tramite Named Credential è invariata e il segreto continua a non
finire in `Integration_Log__c`.

### 35.3 🟢 `MexalCustomerCreateService` — il percorso di creazione

`createForAccount` è raggiungibile da una nuova azione rapida
**`Crea_Cliente_Mexal`** sull'Account. Invia `codice = '501.AUTO'`, quindi **è
Mexal ad assegnare il numero cliente**; il codice generato viene poi recuperato
dagli header della risposta (qualsiasi header che contenga `codice`, `cliente` o
`customer`, altrimenti l'ultimo segmento di path di `Location`), con fallback sul
body, e **scritto su `Account.Codice_Cliente_Mexal__c`**.

🟢 **L'errore di `partita IVA` duplicata registrato il 7 settembre è gestito**: il
dettaglio dell'errore viene interpretato e viene restituito **il codice Mexal del
cliente in conflitto**, con un messaggio in italiano, anziché un'eccezione opaca.

### 35.4 🟢🔴 OI-116 ottiene la DML e mantiene il suo blocco

La lettura anagrafica ora **persiste**: `Database.update` e `Database.insert` su
`Account` a successo parziale, errori raccolti riga per riga, record type
**`Azienda`** sugli insert, **corrispondenze ambigue saltate anziché indovinate** e
`Name` vuoto rifiutato.

🔴 **Il job notturno resta commentato**, con lo stesso identico blocco nel codice:
_"paused while the Mexal sync schedule and date window are finalized."_ La riga
passa quindi da _una lettura, non una sincronizzazione_ a **una sincronizzazione
senza schedulazione**: ciò che manca non è più codice ma la **finestra di
sincronizzazione e il watermark**, non specificati dal 3 settembre.

### 35.5 🔴 OI-125 costruita, OI-117 esposta

**OI-125: `PUT /clienti/{codice}` esiste e nessuno la chiama.** Un Account già
collegato solleva un'eccezione, e la chiamata di aggiornamento resta subito sopra
come blocco commentato intitolato _"Future Modifica Cliente path"_.

**OI-117 è l'esposizione reale della giornata.** Due scrittori popolano ora il
codice Mexal, e **il blocco che questa riga esiste per specificare non è ancora
stato costruito** — nessuna regola di validazione, nessun controllo a livello di
campo. Una modifica utente effettuata dopo l'arrivo del codice Mexal può essere
sovrascritta dalla sincronizzazione senza lasciare traccia.

### 35.6 🔴 L'oggetto di configurazione è stato rinominato e cambiato di tipo

`Integration_Configuration__c` è diventato **`Integration_Configuration2__c`**, e
una custom setting di tipo **Hierarchy** è diventata di tipo **List**; la
risoluzione `SetupOwnerId` per utente/profilo/organizzazione è stata eliminata a
favore di `ORDER BY Name LIMIT 1`. La rinomina è con ogni probabilità obbligata —
Salesforce non consente la conversione tra i due tipi — ma il **suffisso `2` è
ormai permanente** in ogni classe, nel permission set e nei layout.

🔴 **Ancora zero righe, ancora nessun referente, e ora ne servono quattro con nome
esatto.** Che fine abbia fatto l'oggetto originale nell'org non è registrato da
nessuna parte.

### 35.7 🔴 Il riferimento alla credenziale non distribuibile è arrivato su `DevMain`

`Full_Permission` concede `Mexal_External_Credential-Mexal_Principal` e il
repository continua a non avere **alcuna directory `namedCredentials/` o
`externalCredentials/`**. Ieri la cosa era su un branch non unito; **ora è sul
branch di lavoro**, quindi un deploy pulito di `DevMain` su un'org nuova fallisce
su quel permission set. **A dodici giorni dallo UAT, è il difetto aperto meno
costoso del progetto.**

### 35.8 ⚠ Una decisione arrivata fuori dalla sweep

`80420cf` ha anche committato direttamente una nota di decisione: il **primo
Ordine di un Account esegue una chiamata Anticipay in coda, poi l'aggiornamento
dell'Account, poi la creazione del cliente su Mexal, poi l'Ordine**; gli Ordini
successivi saltano Anticipay e prendono il percorso `Modifica`. La fonte
dichiarata è un'istruzione diretta a una sessione agent, e **nessuna fonte
analizzata la corrobora**.

🔴 **Ciò che è stato rilasciato non la segue**: un pulsante sincrono sull'Account,
senza passaggio Anticipay, senza coda e senza trigger sull'Ordine. La nota stessa
dichiara di non attivare il flusso. **La regola è registrata; non è costruita.**

### 35.9 🔴 Copertura

**30 classi Apex, 8.193 righe**, misurate dal repository. **L'ultima esecuzione
dei test Apex resta il 4 agosto**, trentotto giorni e quattro merge fa — e il
perimetro include ora una classe che **crea record in un ERP esterno**. Registrato
come perimetro; nessuna azione intrapresa.

## 36. Aggiornamento 14/09/2026 — verifica org: la catena ordine-Mexal esiste, ma solo nell'org

> ⚠ **Questa sezione registra solo lo STATO DEL BUILD.** Supera le affermazioni
> delle sezioni precedenti su ciò che **esiste** nell'org. Non supera il
> resoconto di ciò che è stato **concordato**: una decisione resta presa anche
> dove l'implementazione la contraddice.

Verifica in sola lettura di **Pienissimo UAT** (`00DMA000004nMMr2AM`, sandbox
parziale, API 68.0) del **14/09/2026, 10:51Z**, contro `force-app/` su `DevMain`
a `cc3c571`, worktree pulito. **335** chiavi di componente del repository
confrontate con **1.218** componenti dell'org. Metodo: listing Metadata API,
Tooling `FieldDefinition` / `FieldPermissions` / `ObjectPermissions` /
`ApexCodeCoverageAggregate` / `ApexClass.Body`, `CronTrigger`, `AsyncApexJob`,
`FlowDefinitionView` e aggregati SOQL mirati. Nessun test eseguito, nessun
deploy, nessun dato dell'org modificato.

### 36.1 🔴 Il punto principale: nove classi Apex esistono nell'org e in nessun branch

Tra le **09:12 e le 10:33 UTC** di quella mattina sono state create nell'org da
Aurel Mrruku **nove classi Apex** per circa **28.000 caratteri**, insieme a due
campi su `Order`. **Nulla di tutto ciò è in questo repository.**

| Classe                           | Creata (UTC) | Ruolo                                       |
| -------------------------------- | ------------ | ------------------------------------------- |
| `OrderMexalIntegrationService`   | 09:12        | Orchestra la catena                         |
| `OrderMexalIntegrationQueueable` | 09:12        | Un queueable per passo                      |
| `MexalOrderSendService`          | 09:12        | Invia l'ordine a Mexal                      |
| `MexalHttpClient`                | 09:44        | Il trasporto                                |
| `MexalIntegrationLogger`         | 09:44        | Scrive `Integration_Log__c`                 |
| `MexalCustomerSyncBatch`         | 09:44        | Il batch notturno anagrafiche               |
| `MexalCustomerSyncScheduler`     | 09:44        | Il suo `Schedulable`                        |
| `MexalSyncCursorService`         | 09:44        | Il watermark di sincronizzazione            |
| `MexalCustomerUpdateQueueable`   | 10:33        | Rimanda a Mexal una modifica amministrativa |

Con esse sono solo-org anche `Order.Mexal_Integration_Status__c` e
`Order.Mexal_Order_Number__c`. È la **quarta** occorrenza del modello solo-org e
di gran lunga la più estesa.

### 36.2 🟢 Ciò che è stato costruito è corretto, e risponde a tre righe aperte

`OrderTriggerHandler.afterInsert` nell'org accoda la catena, che esegue un passo
per job:

```
Mark Running → [Anticipay, solo primo ordine] → Cliente Mexal → Ordine Mexal
```

- **La decisione di sequenziamento dell'11/09 è costruita.** Il "primo ordine" è
  determinato interrogando gli Ordini precedenti dell'Account, non assunto. Il
  passo Anticipay viene saltato se l'Account è già consolidato e **il suo
  fallimento non blocca**: viene loggato e Mexal prosegue.
- **Il #125 ha il suo chiamante.** Un Account già collegato passa ora da
  `updateForAccount` — **la PUT**. Il commento a blocco dell'11/09 è sparito. Un
  ordine non primo senza codice Mexal solleva eccezione invece di duplicare.
- **Il #116 ha ottenuto batch, scheduler e watermark.** `MexalSyncCursorService`
  è il cursore delta su cui quella riga era bloccata dal 03/09.
- I fallimenti sono intercettati per passo, loggati con il nome del passo, e
  **gli ordini rimanenti proseguono**.

### 36.3 🟢 Lo scaffolding di integrazione è configurato — ogni affermazione "zero righe" è ritirata

`Integration_Configuration2__c` contiene **sei righe**: `Anticipay_Account_Check`,
`Mexal_Clienti_Ricerca`, `Mexal_Clienti_Creazione`, `Mexal_Clienti_Modifica`,
`Mexal_Articoli_Ricerca`, `Mexal_Ordini_Creazione`. **Tutte e quattro quelle che
il #116 indicava come necessarie per nome esatto sono presenti.**
`Integration_Log__c` contiene **85** righe (45 marcate errore, 40 no). L'org ha
**tre** named credential.

**Ogni affermazione "zero righe" dal §25 al §35 è superata.** I valori delle
righe non sono stati letti deliberatamente: contengono endpoint e principal.

### 36.4 🔴 Nulla è schedulato, e nulla è mai stato eseguito

- L'org ha **sette righe `CronTrigger` e sono tutte job di piattaforma
  Salesforce**. `MexalCustomerSyncScheduler` non è mai stato schedulato. **Il
  #116 mantiene la sua diagnosi — una sincronizzazione senza schedulazione — ma
  ora è una sola chiamata `System.schedule`, non una decisione.**
- **Tutti i 30 Ordini hanno `Mexal_Integration_Status__c` vuoto** e nessun
  `OrderMexalIntegrationQueueable` compare in sette giorni di `AsyncApexJob`. Solo
  `MexalCustomerUpdateQueueable` è stato eseguito, **una volta**. **Due** Account
  hanno un codice Mexal.

### 36.5 🔴 Un deploy da `DevMain` annullerebbe silenziosamente la catena

L'`OrderTriggerHandler.afterInsert` del repository chiama
`AnticipayOrderAutomation.enqueueForFirstOrders`; quello dell'org chiama
`OrderMexalIntegrationService.enqueueForCreatedOrders`. **Un deploy di `DevMain`
in questo org oggi riporta la catena al comportamento precedente e lascia nove
classi orfane.** Tre classi del repository sono state inoltre modificate
nell'org: `MexalCustomerCreateService` è stata ripuntata su `MexalHttpClient`,
una classe che in git non esiste.

### 36.6 🔴 Al #117 si è risposto costruendo l'opposto

`AccountTriggerHandler.afterUpdate` nell'org osserva `Email__c`, `Phone`,
`Partita_IVA__c` e `Name` su un Account che porta un codice Mexal e **spinge la
modifica su Mexal**. Il #117 era stato registrato come _Concordato_ il 03/09 come
**blocco in sola lettura**. La condizione scatenante coincide; la risposta è
l'opposta. **Nessun verbale, nessuna nota di decisione.** L'esposizione alla
sovrascrittura silenziosa è **raddoppiata, non chiusa**: il batch notturno in
entrata e questa spinta in uscita scrivono gli stessi campi senza alcuna regola
di conflitto.

### 36.7 🔴 Il disallineamento del sorgente è più che raddoppiato

Confrontati i corpi di tutte le **76** classi e trigger non gestiti: **27 uguali,
12 divergenti** — contro 4 divergenze dell'08/09. **Otto differiscono a livello
di token**: `ParticipantRegistrationController`, `EventInvitationService`,
`OrderTriggerHandler`, `AccountTriggerHandler`, `MexalCustomerSearchService`,
`MexalSearchCalloutService`, `MexalCustomerCreateService`, `AccountTrigger`.
Quattro differiscono solo nella formattazione. **Nessun componente è solo nel
repository** nei dodici tipi confrontati in entrambe le direzioni: tutto ciò che
sta in `force-app/` è deployato.

### 36.8 🔴 Due permission set rompono ora un deploy pulito

`Full_Permission` concede `Mexal_External_Credential-Mexal_Principal` e
`Integration_Management` concede `Anticipay_External_Credential-Anticipay
Principal`. `force-app/` **non ha alcuna cartella `namedCredentials/` né
`externalCredentials/`**. Un deploy pulito fallisce **due volte**.

### 36.9 🔴 Copertura

`ApexCodeCoverageAggregate`: **0 coperte, 4.737 non coperte, 0%, 60 voci** —
contro **2.957 su 42** dell'08/09. **+1.780 righe non coperte in sei giorni**, il
salto più ripido registrato, e i nuovi arrivati sono classi di callout che
scrivono su un ERP esterno. Ultima esecuzione dei test ancora **4 agosto**.
Registrato come brief; nessuna azione intrapresa.

### 36.10 ⚠ Invariato dall'08/09

**43** prodotti che generano biglietti, **3** con una mappatura edizione attiva —
**40 non mappati** (#121). **3** inviti, tutti Pending/Ready, **tutti senza
destinatario**. **15** Asset, **0** con QR id. `AnticipayErrorNotificationService`
indirizza ancora una casella di sviluppo ROMI hardcoded (#119). **Nessun Flow
scritto dal progetto**: tutti i 66 flow attivi sono standard Salesforce o
template gestiti.

## 37. Aggiornamento 14/09/2026 (sera) — la catena che esisteva solo nell'org arriva in source control, insieme al blocco

Sette ore dopo che la verifica org del mattino aveva segnalato l'intera
integrazione ordine-Mexal presente nell'org e in nessun branch, **`e06a1b4`**
(Anita Aga, push alle 18:05 CEST su `DevAnita`) l'ha portata in source control.
**La PR #43 è stata aperta alle 16:06Z ed è aperta e non mergiata** alla data di
questa verifica. **40 file, +2.057 / −143.**

Letto solo dal commit. **L'org non è stata aperta questa sera**: ogni affermazione
qui sotto è evidenza di repository, salvo dove cita la verifica del mattino.

### 37.1 🟢 Otto delle nove classi presenti solo nell'org sono ora committate

`OrderMexalIntegrationService` · `OrderMexalIntegrationQueueable` ·
`MexalOrderSendService` · `MexalCustomerSyncBatch` · `MexalCustomerSyncScheduler` ·
`MexalSyncCursorService` · `MexalCustomerUpdateQueueable` ·
`MexalIntegrationLogger` — più `Order.Mexal_Integration_Status__c` e
`Order.Mexal_Order_Number__c`.

### 37.2 🟢 Il repository non contraddice più l'org

`OrderTriggerHandler.afterInsert` chiama ora
`OrderMexalIntegrationService.enqueueForCreatedOrders` e
`AnticipayOrderAutomation.cls` è **eliminata**. Il rischio «un deploy da `DevMain`
riporta indietro la catena e lascia orfane nove classi» finisce quando la PR #43
viene mergiata — e **non prima**.

### 37.3 🟢 Il blocco di OI-117 esiste, e con esso una regola di conflitto

Una regola di validazione **attiva** su Account, `Lock_Mexal_Synced_Admin_Fields`,
rifiuta tredici campi amministrativi agli utenti non amministratori una volta
valorizzato `Codice_Cliente_Mexal__c`, con un messaggio in italiano che rimanda
all'amministrazione. I campi commerciali restano fuori, come richiesto dalla
sessione del 3 settembre.

Separatamente, `AccountTriggerHandler.setBypassMexalCustomerUpdate` è un flag di
soppressione impostato da `MexalCustomerSearchService` attorno alla DML della
sincronizzazione in entrata: la lettura notturna **non può** rimbalzare in uscita
attraverso la push. Il ciclo di eco è chiuso.

🔴 **Restano due lacune.** Il principal è `$Profile.Name <> "System
Administrator"` — un nome di profilo letterale, non il raggruppamento
amministrazione richiesto dalla sessione. E **il blocco copre tredici campi
mentre la push ne copre quattro**: un amministratore che modifica
`Codice_Fiscale__c`, `PEC__c`, `Codice_Destinatario_SDI__c` o l'indirizzo di
fatturazione cambia Salesforce e non Mexal, in silenzio.

### 37.4 🟢 Il watermark di OI-116 ha una memoria, e un gemello per gli articoli

Quattro campi su `Integration_Configuration2__c` — `Last_Successful_Sync__c`,
`Last_Sync_Status__c`, `Last_Sync_Error__c`, `Initial_Sync_Lookback_Hours__c`.
`MexalSyncCursorService` legge il primo e ripiega sulle ore di lookback a freddo.
**La finestra di sincronizzazione non specificata dal 3 settembre è ora una riga
di configurazione.**

Con esso sono arrivati `MexalArticleSyncBatch` e `MexalArticleSyncService` (534
righe), azione `Mexal_Articoli_Ricerca`, che fanno upsert degli articoli Mexal su
`Product2` per `External_Product_Code__c` e **scartano — senza fondere** — un
codice che collide con un prodotto non Item. 🔴 **Non è la mappatura edizioni**:
40 dei 43 prodotti che generano biglietti restano non mappati (#121).

🔴 **Nulla è schedulato.** Committare uno `Schedulable` non lo schedula.

### 37.5 🟢 Le named credential arrivano in source, senza i loro segreti

`namedCredentials/Mexal` e `Anticipay`, e le due external credential. Gli header
di autenticazione sono **riferimenti a merge field**
(`$Credential.<nome>.<parametro>`): il token resta nell'org — esattamente la forma
che il rischio chiedeva. 🔴 **`DocuSign` è ancora solo nell'org**, e nulla di
tutto questo è su `DevMain`.

### 37.6 🟢 La PUT è stata eseguita contro Mexal, e la PATCH non esiste

DM Slack, 14/09: Aurel Mrruku ha eseguito un aggiornamento cliente **da
Salesforce** ed è andato a buon fine (12:07:44); `PUT /clienti/{codice}`
restituisce **204 No Content** con i dati utili negli header; e Andrea Di Cicco ha
confermato alle 15:18:38 che **la PATCH non esiste**. 🔴 L'obiezione dello stesso
Aurel — una PUT a corpo pieno può sovrascrivere i campi che Mexal compila da sé —
**resta senza risposta**.

🔴 **Il test è stato eseguito su Mexal in produzione.** _"ricordati che è sempre
produzione"_ (Andrea Di Cicco, 12:07:03), dopo che Aurel aveva già creato lì un
record cliente da Salesforce. In tutto questo record non esiste alcun ambiente di
test Mexal.

### 37.7 🔴 Ciò che il commit non risolve

`MexalHttpClient` **non è committata né referenziata** in nessun punto del diff,
mentre la verifica del mattino l'aveva trovata nell'org con
`MexalCustomerCreateService` ripuntata su di essa. Quello che è arrivato è una
versione **riconciliata**, non un retrieve grezzo — ⚠ dedotto da due registrazioni,
non verificato contro l'org. La PR #43 non ha **né descrizione né review**, terza
PR Mexal consecutiva. E la **copertura**: +2.057 righe sopra lo 0 coperte / 4.737
non coperte / 0% del mattino, ora comprensive di due batchable, due queueable e un
percorso asincrono guidato da trigger. Solo registrazione.

## 38. Aggiornamento 15/09/2026 — tre pull request in un giorno, e l'integrazione viene spenta in UAT

La giornata di rilascio più consistente del progetto, e il giorno in cui la sua
integrazione centrale ha smesso di essere eseguibile nell'ambiente che dovrebbe
accettarla.

### 38.1 🟢 PR #43 mergiata — il rischio di custodia è chiuso

`23f1375`, **08:07:04Z**. L'intera catena ordine → Mexal, la regola di validazione
dell'OI-117, la sincronizzazione articoli ed entrambe le named credential sono su
`DevMain`. L'`org-status-check` del 15/09 lo conferma dall'altro lato: **tutte le
48 classi e trigger Apex del repository sono deployate, 44 equivalenti a livello
di token rispetto a UAT**, e `MexalHttpClient` è assente da entrambi i lati —
quindi la questione della classe orfana del 14/09 si risolve con **nessun orfano**.
Il rischio «un deploy da `DevMain` annulla silenziosamente la catena» è finito.

Finisce anche il **fallimento di deploy sul permission set**: `Full_Permission` e
`Integration_Management` referenziano la external credential Mexal, e ora
`namedCredentials/` esiste nel sorgente con i segreti lasciati nell'org come
riferimenti a merge field. 🔴 **DocuSign resta solo nell'org.**

### 38.2 🔴 `1830fce` — e la catena non gira in UAT

Cinque minuti prima di quel merge sono entrate otto righe, con il messaggio
_"Added an check to not do the callout on order creation"_:

```apex
public static void enqueueForCreatedOrders(List<Order> newOrders) {
  if (isSandbox()) { return; }
```

**La UAT è una sandbox.** Il trigger scatta e a valle non succede nulla: nessun
passaggio Anticipay, nessuna creazione cliente, nessuna creazione ordine, nessun
campo di stato, nessuna riga di log. Spiega esattamente il _«tutti i 31 Order
hanno lo stato integrazione Mexal vuoto»_ del controllo org: è comportamento
voluto.

🟢 Letto come risposta al **rischio dell'ERP di produzione** registrato la sera
prima, è la cosa responsabile da rilasciare: un ordine in UAT non può più creare
un ordine vero nel sistema di fatturazione di Pienissimo. ⚠ **Questa lettura è
dedotta** — il messaggio di commit non lo dice, la PR #43 non ha descrizione, e
nessun messaggio su alcun canale ne parla.

🔴 **La UAT va dal 23 settembre al 13 ottobre; il go-live è il 21 ottobre.** La
prima esecuzione end-to-end della catena a partire da un ordine avverrebbe quindi
**in produzione, dopo l'accettazione**. Un meccanismo più fine esisteva già e non
è stato usato — `buildEndpoint` sceglie tra una named credential di sandbox e una
di produzione dal 10 settembre, e lo stesso custom setting porta `Use_Mock__c`. E
il guard è asimmetrico: una sandbox può ancora scrivere **clienti** su Mexal in
produzione, che è proprio ciò che è già successo il 14 settembre.

### 38.3 🟢🔴 PR #44 mergiata — la pagina partecipanti passa ai token, e acquisisce una scrittura pubblica

`f51365b`, **13:43:52Z**, Rexhina Hysi. **+2.487 righe.** Il lavoro su inviti e
partecipanti che il controllo org del 15/09 segnalava come divergente dal sorgente
è ora **nel** sorgente: `ContactTriggerHandler`, un
`ParticipantRegistrationController` riscritto, `Event_Invitation__c.Token__c`, le
date evento su Campaign, una record page Campaign e una Contact, e `Rinuncia` come
stato Asset reale. Il commit porta con sé anche la propria nota di recap in
`notes/objects/` — la **terza** volta che una decisione arriva in questo
repository attraverso un commit di codice.

🟢 **Il link di invito è ora un token opaco per invito** — 64 caratteri
esadecimali da `Crypto.generateAesKey(256)` — al posto degli id Account e Campaign
in chiaro. Questo **supera di fatto BIG-18**, e ora lo dicono sia i due documenti
in prosa sia il registro.

🔴 **La stessa pagina può portare un ordine a `Incassato`.**
`ParticipantRegistrationController` è `public without sharing` ed espone
`markOrderIncassato(String token)`, reso come pulsante **«Segna ordine
incassato»** sulla landing pubblica. Il token è robusto; il problema è che cosa
autorizza — uno stato di pagamento, impostato da un utente guest, senza scadenza,
senza revoca se non invalidando il link già inviato, e senza traccia di chi sia
stato. **Nessun requisito lo autorizza e nessuno ne ha parlato.** Nuova riga
**#136**.

### 38.4 🟢 PR #45 aperta — finalmente il roll-up delle tranche

`400c195`, **16:07:59Z**, Anita Aga, **aperta**. **+2.290 righe, sette classi Apex
nuove.** `OrderItemTriggerHandler` ricalcola una tranche ogni volta che cambia la
tranche o lo stato di pagamento Mexal di una riga e la porta a `Pagata` **solo
quando tutte le righe sono `Paid`** — `ORD-03` e `AC-06` alla lettera, ed è
proprio lo scrittore che quella mattina il controllo org dava per mancante. Lo
stato per riga arriva da Mexal tramite `MexalScadenzarioSearchService` e
`MexalInvoiceOrderLineMappingService`; `MexalOrderMappingService` riscrive sulle
coordinate del documento Mexal sull'Order e sulle sue righe.

🟢 **Il principal dell'OI-117 è corretto** — la regola di validazione passa da un
nome di profilo letterale a `NOT($Permission.Edit_Mexal_Synced_Admin_Fields)`
contro un nuovo custom permission, che è ciò di cui «modificabili solo
dall'amministrazione» ha bisogno. 🔴 **Nessun permission set lo concede ancora**,
il che blocca i campi per tutti, amministrazione compresa.

🔴 **Un terzo batch non schedulato.** `MexalMaggazinoSyncBatch` si aggiunge ai
batch clienti e articoli su uno scheduler che **ancora nessuno invoca**. Esistono
sei righe `Integration_Configuration2__c`; **nessuno dei 7 job schedulati
nell'org è Mexal.** La finestra di sincronizzazione è non specificata da dodici
giorni.

### 38.5 🔴 Copertura, e la prima esecuzione dei test in quarantadue giorni

Il controllo org del 15/09 registra un'esecuzione su UAT: **37 passati, 4
falliti** — tutti e quattro metodi di `OrderTriggerHandlerTest`, **bloccati dalle
mappature edizione mancanti del #121**, dove 40 prodotti su 43 che generano
biglietti sono ancora non mappati. Copertura **0 coperte / 5.095 non coperte /
0%**, e quello snapshot **precede entrambe le pull request della giornata**. Il
repository contiene ora **40 classi Apex, tre delle quali di test**, e la
superficie non testata comprende ora una scrittura sullo stato Ordine
raggiungibile da utente guest. **Solo brief — nessun test scritto, proposto o
abbozzato.**

## 39. Aggiornamento 16/09/2026 — il cliente ha aperto anagrafica prodotti e preventivi, e un pulsante è sparito senza una decisione

La quinta sessione di data model è durata **2h21m30s** contro una prenotazione
di due ore e ha coperto più terreno di ogni precedente. Sul fronte delivery: PR
#45 mergiata, una pull request aperta, e l'evidenza più grave del 15 settembre
rimossa dal codice da qualcuno che non ha lasciato traccia del perché.

### 39.1 🟢 Data Model Parte 5 — dieci decisioni su prodotti, preventivi e testate ordine

**16 settembre, 11:00 CEST, con il cliente.** Elena Spini, Elisa Migliano e
Aurel Mrruku per tutta la durata; **Fabrizio Paganelli è entrato, ha salutato ed
è uscito verso 00:06**; **Sabatino Rinaldi non ha partecipato**. Verbale
completo: [la nota di sessione](../notes/meetings/2026-09-16%20Data%20Model%20Parte%205.md).

**Anagrafica prodotti.** Eliminati i campi superflui (`tassabile`, costo
commissione, quantità, date di vendita) — secondo la normativa di **San Marino**
l'IVA non si applica e l'anagrafica articoli Mexal usa codici di esenzione
fissi. Unità di misura **`NR`, numeri interi**. **Lo stato attivo del prodotto è
di Salesforce**: i prodotti nascono sempre attivi, la disattivazione è manuale e
Mexal non la sovrascrive mai; un prodotto disattivato sparisce da nuovi
preventivi e bundle ma resta sugli ordini storici. **La `natura` di Mexal si
mappa su due checkbox Salesforce** — `genera biglietto` e `is bundle` — tramite
una trasformazione custom. `tipo biglietto` assume `Executive` / `Gold` /
`Diamond`, **non obbligatorio**; `Academy` ricade in `categoria statistica`.
`gruppo merceologico` resta come picklist vuota. I **`livelli 0–6`** di
riclassificazione diventano picklist.

**Preventivo e ordine.** 🔑 **Un'offerta vinta e il suo ordine accettato sono
congelati** — nessuna riga aggiunta o rimossa, nessun prezzo o codice articolo
modificato, si modifica solo in fase di opportunità e preventivo
([OI-138](../notes/items/OI-138%20Quotes%20and%20orders%20freeze%20once%20the%20order%20is%20accepted.md),
non costruito). **`Tipologia attività` viene creata sull'Account di tipo Locale**
come picklist globale non restrittiva e pre-popola il preventivo, il che rende
obbligatoria lì la selezione del locale. Nome preventivo = numero preventivo +
partita IVA; il numero preventivo è lo stesso codice con cui Mexal fattura.
**Scadenza preventivo a cinque giorni** dall'ingresso in _trattativa_,
modificabile dal tutor. Un preventivo principale perso chiude l'opportunità come
persa con la stessa motivazione. 🔑 **`Codice agente`, `classificatore rete` e
`codice zona` sono storicizzati su preventivo e ordine** — una riassegnazione
successiva sull'Account non raggiunge i record esistenti. La testata ordine
adotta la struttura campi del preventivo; **le righe ordine sono state
rinviate**.

**Rimasto aperto.** Le vendite post-evento dei tutor potrebbero essere **solo
bundle**, in attesa di Sabatino Rinaldi. **I preventivi complessi dei tutor non
hanno un meccanismo per le tranche** — i tutor costruiscono preventivi a più
righe le cui scadenze non coincidono con le fatture mensili Mexal e spiegano le
rate a mano nel campo note del PDF; Elisa Migliano ha chiesto una tabella di
sintesi, Aurel Mrruku ha indicato il limite strutturale, Elena Spini ha portato
il caso di un contratto da ~20.000 € suddiviso in tranche, e si è rinviato a
venerdì. **I link WooCommerce per offerte multiprodotto non in bundle** non sono
testati; i link effettivamente inviati ai partecipanti portano id di bundle
predefiniti.

🔴 **Utenti, Profili, il piano di caricamento iniziale e la tabella Lead non
sono stati aperti — sesta sessione consecutiva**
([OI-24](../notes/items/OI-24%20Data%20model%20workbook.md)).
🔴 **Va sciolto un conflitto di calendario**: la Parte 4 aveva fissato la Parte 6
il 18/09 su Campagne/Lead con Rebecca Marmo; la Parte 5 ha fissato venerdì 18/09
per le righe ordine.

### 39.2 🟢 PR #45 mergiata — il roll-up delle tranche arriva su `DevMain`

`0d2b779`, **08:21:19Z**. `OrderItemTriggerHandler` — `Tranche__c.Pagata__c` vero
solo quando ogni riga è `Paid`, che è `ORD-03` e `AC-06` alla lettera — è sulla
linea principale. Non è mai stato eseguito.

✅ **E una correzione al record del 15 settembre.** La lettura di quella notte
diceva che il nuovo permesso personalizzato `Edit_Mexal_Synced_Admin_Fields` non
era concesso da nulla. Era concesso nello stesso commit che lo creava, in
`Full_Permission.permissionset-meta.xml` righe 43–46; l'affermazione derivava
dagli **hunk di diff** di quel file, che non includono il blocco
`customPermissions`.

🔴 **Il difetto reale è più stretto ed è concreto.** `Full_Permission` è l'unico
permission set in `force-app/` che lo concede, ed è il set sviluppatore ad
accesso totale. Onorare ciò che il 3 settembre è stato promesso
all'amministrazione significa o concedere il permesso da un permission set
**amministrazione** — che in questo repository non esiste — o assegnare
`Full_Permission` all'amministrazione, che sarebbe una regressione di sicurezza
travestita da correzione
([OI-117](../notes/items/OI-117%20Administrative%20fields%20lock%20once%20the%20Mexal%20customer%20code%20is%20set.md)).

### 39.3 🟢🔴 Il pulsante `Incassato` è stato rimosso, su un branch, senza alcuna decisione alle spalle

`4132dab` (Rexhina Hysi, **09:24:55 CEST**, `DEV_ComponentBundle`) — **3
inserimenti, 122 cancellazioni**. `markOrderIncassato`,
`collectLinkedOrderIds`, il flag `canMarkOrderIncassato` e il ciclo che lo
impostava, e il pulsante nella LWC: tutto eliminato. **Nel
`ParticipantRegistrationController` non resta alcuna DML su `Order`.**

🔴 **Non è su `DevMain` e nessuna pull request lo propone.** Il branch ha nel
frattempo accolto altri quattro commit di lavoro non correlato, quindi la
correzione viaggia con loro. La scrittura su `Order.Status` raggiungibile da
guest è ancora su `DevMain` e ancora in UAT.

⚠ **Il perché non è registrato da nessuna parte.** Il report del 15 settembre è
arrivato al gruppo dev alle 23:51 CEST e il commit è delle 09:24 del mattino
dopo; quell'ordine temporale è tutta l'evidenza disponibile. Nessuno ha risposto
al report, nessun canale nomina il pulsante, il commit non ha descrizione. **Una
persona ha agito; nessuna ha deciso** — e **a Elisa Migliano, autorità operativa
sulla fatturazione, non è ancora stato chiesto** se un attore lato cliente debba
mai poter dichiarare incassato un ordine
([OI-136](../notes/items/OI-136%20Public%20participant%20link%20can%20mark%20an%20order%20Incassato.md)).

🔴 **`QuoteAcceptanceController` è invariato** — ancora `public without sharing`
su un `quoteId` nudo, e lo stesso giorno alle 14:21 CEST è stato incollato in
Slack un URL `/gestione-preventivo?quoteId=…` funzionante.

### 39.4 🔴 Entrambi gli interlocutori dell'integrazione sono usciti di scena lo stesso giorno

**Andrea Di Cicco è stato sollevato dal progetto alle 18:04 CEST** — Elena
Spini, _"per ora ti puoi lentamente staccare"_ — con quattro domande alle
spalle: l'aggiornamento JSON e il test send di OI-110 (**14 giorni**), la
collection WooCommerce filtrata di OI-102 (**8 giorni**), l'obiezione senza
risposta sulla PUT di OI-125 e il "chi devo avvisare" senza risposta di OI-135.
Tre delle quattro non sono rispondibili da nessun altro in ROMI
([OI-139](../notes/items/OI-139%20Andrea%20Di%20Cicco%20is%20winding%20down%20with%20four%20integration%20questions%20unanswered.md)).

**Anche Sabatino Rinaldi è irraggiungibile** — in tour con la direzione del
cliente, nessuna risposta su WhatsApp la settimana precedente, secondo Elisa
Migliano alla Parte 5. Deve le due nuove risposte su WooCommerce ed è in attesa
della collection filtrata.

**La UAT apre il 23 settembre, fra sette giorni.**

### 39.5 ⚠ Lavoro in corso, non mergiato

**PR #47** (`7cabe51`, Anita Aga, aperta 16:03:27Z, **aperta**, senza
descrizione) — un endpoint `Indirizzo Spedizione` su
`MexalCustomerCreateService`, un `OpportunityQuoteDefaultsController` con
un'azione a schermo **Nuovo Preventivo**, `Order.Tipo_Ordine__c` e modifiche di
layout: **+883 righe su 13 file.**

**`DEV_ComponentBundle`** (Rexhina Hysi) — oltre alla rimozione del pulsante,
generazione del PDF preventivo per i preventivi in `Bozza` con un campo di
istruzioni di pagamento `Modalita_Pagamento_PDF__c`, un'azione email **Invia per
accettazione**, lavoro sui bundle nei prodotti e il livellamento di `Rinuncia`.
🔴 **Altre due classi fissano a codice le grafie di stato del preventivo**
(`Bozza`, `In Attesa Accettazione`), quattro dal 09/09, mentre la grafia
canonica di [OI-59](../notes/items/OI-59%20Quote%20workflow%20configuration.md)
resta senza decisione da sette giorni.

⚠ **Dentro quei commit sono arrivate altre due note scritte da sviluppatori** —
`How the Quote acceptance email action works.md` e
`Quote PDF generation for Bozza quotes.md`. Entrambe sono oneste sui propri
limiti ("non deployato né verificato", "nessuna classe di test Apex"). Sono la
quarta e la quinta nota ad arrivare in questo repository tramite un commit di
codice anziché tramite una riunione. Indicizzate come sono, non riscritte.

## 40. Aggiornamento 17/09/2026 — la lacuna sulla posta si chiude senza nulla dentro, e due fonti mai lette vengono finalmente aperte

**Gmail è stato riconnesso** all'inizio di questa sessione, dopo tre run
consecutivi in cui rispondeva _"needs you to sign in again"_ e nessuna query di
posta veniva eseguita. Il watermark della posta era fermo a
**2026-09-11T22:00Z** da cinque giorni: ora è stato spazzato e **il watermark
doppio è chiuso**.

### 🟢 I cinque giorni non controllati non contengono posta del cliente

Una ricerca esplicita per mittente/destinatario sul dominio del cliente
nell'intervallo **11/09 → 17/09** restituisce **zero thread**. L'ultimo messaggio
da chiunque su `@pienissimo.com` è di **Fabrizio Paganelli, 09/09 alle 07:08Z**,
che dava riscontro alla mail di stato di Elena Spini dell'08/09 aggiungendo
Daniela Morgese in copia.

Quindi il rischio che i tre run falliti si portavano dietro — una risposta del
cliente alle quattro decisioni bloccanti dell'08/09 rimasta non letta — **non si
è materializzato**. Il dato è più semplice e peggiore: **il cliente tace via mail
da otto giorni**, e nessuno dei quattro artefatti dovuti per posta è arrivato —
le credenziali WEBAPI Mexal, la lista eventi, i codici articolo solo-bundle, i
prezzi di listino. 🔴 **Nella casella non esiste alcuna mail da Kreosoft**: il
consiglio ricorrente di "chiedere a Mirko Merendi" significa aprire un contatto a
freddo, non rispondere a un thread.

### 🟢 Il workbook del data model è stato letto nella versione di Parte 5

`Campi Oggetti, Flussi e Utenti Salesforce - Pienissimo.xlsx`, salvato alle
**11:20:06Z durante Parte 5** e lasciato non letto dal run precedente, è stato
aperto.

**Le decisioni sui prodotti ci sono** — `NR` come unità di misura a numeri
interi, `Categoria statistica` e `Gruppo Merceologico` come picklist di
provenienza Mexal, `Natura` annotata _"genera biglietto SI/NO"_, `Tipo Biglietto`
come `Executive / Gold / Diamond`. 🔑 **`LIVELLO_0` ha finalmente dei valori** —
Eventi, Consulenze, Prodotti, Software, Addebiti — mentre il 03/09 i sette campi
livello risultavano assenti da ogni nota e da ogni sessione verbalizzata. Il
foglio **Preventivo** ha acquisito `Codice_agente`, `Classificatore_rete` e
`Zona`, i campi provvigionali storicizzati.

🔴 **Ma `Tipologia Attività` è diventata obbligatoria e il suo promemoria è stato
cancellato.** La cella è ora marcata `TRUE` obbligatoria e tipizzata `Global
picklist`; il 03/09 riportava _"Picklist non restrittiva >> PIENISSIMO TO DO:
Inserire i valori esistenti"_. Il testo TO-DO non c'è più e **nessun valore lo ha
sostituito**. Il cliente ha rimosso il segnalibro che tracciava il proprio debito
senza saldarlo, e il costo è salito: una picklist globale obbligatoria senza
valori non è nemmeno distribuibile. Quattordicesimo giorno.

🔴 **Le quattro lacune sopravvivono a una sesta sessione.** Il foglio Ordine
contiene ancora solo i campi standard Salesforce più la nota di tre righe secondo
cui l'ordine deve portare `Codice Agente`, `Classificatore Rete` e `Codice Zona`;
`Utenti` e `Profili` non contengono altro che la riga di intestazione, e sono
metà del titolo del file; gli slot di flusso `F-3`–`F-7` e tutte le righe di
caricamento iniziale `C-1`–`C-6` sono ancora vuoti.

### 🔴 Il diagramma di design è stato decodificato dopo cinque run saltati — e non ha assorbito nulla

`Flows & Objects.drawio` risultava non decodificabile da cinque run consecutivi,
sulla base corretta che il lettore Drive restituisce ~178 KB di base64 in
contesto. **Quel vincolo non vale più** — i risultati troppo grandi vengono ora
scritti su file — e il file si è decodificato in tre comandi.

Decodificato nella versione **`2026-09-16T08:42:38Z`**, diciotto minuti prima
dell'inizio di Parte 5: 133.644 byte, tre pagine, tutte le celle di testo
confrontate con il rilievo del 26 agosto.

🔴 **Non una sola decisione da Parte 1 a Parte 5 è presente.** Ricerca condotta
sull'XML grezzo e non su un riassunto: `natura`, `categoria statistica`, `gruppo
merceologico`, `LIVELLO_0`–`LIVELLO_6`, `Executive`, `Diamond`, `Codice_agente`,
`classificatore`, `Tipologia Attività` e ogni termine di congelamento
restituiscono **zero occorrenze**. La modifica del 16/09 era preparazione alla
sessione, non un suo verbale, e nessuna modifica successiva ne ha riportato
dentro l'esito.

🔴 **Il link partecipanti riporta ancora _"Link (con Account ID nel link)"_** e
`token` non compare da nessuna parte nel file. La PR #44 ha sostituito quel
meccanismo il 15/09 con un token a 64 caratteri esadecimali per invito, e la riga
di registro **`BIG-18`** è stata superata esattamente su quella base. **`DGM-2` è
la `source:` citata di diverse righe del registro e ora documenta il design
ritirato**: chi verifica il registro rispetto alla sua stessa fonte troverà la
fonte concorde con il testo ritirato.

Entrambe le celle obsolete dal 26 agosto sono **ancora obsolete**: lo scarto fra
`middleware Pienissimo` e `Anticipay` sulle due pagine, e la regola abbandonata
_"solo una campagna attiva"_. ⚠ Il file inoltre **si contraddice sullo stato
dell'ordine**: `Incasato` (una `s`) è il box di stato su entrambe le pagine,
`Incassato` compare una volta nel blocco delle regole, e l'Apex distribuito usa
`Incassato`. È la stessa classe di difetto di
[OI-59](../notes/items/OI-59%20Quote%20workflow%20configuration.md), un oggetto
più in là.

🟢 **Resta la formulazione più completa del design dei Lead che esista** — la
macchina a stati, i criteri di qualifica e squalifica, il task automatico a 48 ore
dopo `Non Risponde`, la coda di assegnazione `CODE` e il ramo di
autoqualificazione `LEAD SOURCE: Diretta`. **Chi conduce Parte 6 venerdì dovrebbe
leggere quella pagina per prima.**

### 🟢 Venerdì non è sovrapposto, e il trigger era invertito

Il run precedente segnalava venerdì 18/09 come conteso fra Parte 6
(Campagne/Lead) e le righe d'ordine, chiedendo a Elena Spini di dirimere. Il
calendario lo risolve senza che nessuno debba essere interpellato: **venerdì
ospita un solo evento Pienissimo**, ` [ROMI-PIENISSIMO] - Data Model: Parte 6`,
11:00–13:00 CEST, focus Campagne e Lead, con Rebecca Marmo invitata.

🔴 **Il rinvio cade quindi dal lato opposto a quello temuto.** La tabella Lead non
viene rinviata una sesta volta: ottiene finalmente la sua sessione. **Le righe
d'ordine, rinviate da Parte 5, non hanno alcuna prenotazione**, e il foglio Ordine
non ha alcuna strada per essere completato con lo UAT a sei giorni.

### ⚠ Un allineamento interno del 16/09 che nessun run aveva visto

`Sync flussi Pienissimo`, 16/09 15:00–16:00 CEST, organizzato da Aurel Mrruku con
Rexhina Hysi e Anita Aga. Non ha prodotto note né registrazione, e la sua unica
traccia è la mail di accettazione del calendario — motivo per cui era invisibile
mentre Gmail era fuori uso.

⚠ Corregge una frase del recap precedente. Sulla rimozione del pulsante
`Incassato`, il §39 concludeva _"la sequenza è il report del 15/09 alle 23:51 e il
commit alle 09:24 del mattino dopo — questa è tutta l'evidenza"_. Non lo era: fra
il commit e la sera c'è stata una riunione dei tre sviluppatori. **Questo non
dimostra che il pulsante sia stato discusso**, non esistendo alcun artefatto della
riunione, ma l'affermazione che il record contenesse tutta l'evidenza era
sbagliata.

### ⚠ La ricostruzione su WooCommerce è stata prodotta per dirimere una discussione

Il §39 riportava il testo NotebookLM incollato da Elena Spini il 16/09 fra le
18:51 e le 19:04, ma non ciò che lo precedeva. **Tre messaggi di Aurel Mrruku
alle 15:55–15:56 CEST** contestano direttamente il meccanismo — _"non mi pare di
aver parlato di menu a tendina"_, _"sta cosa che è uscito oggi dei boundle noon
boundle noon mi torna"_, _"mai sentito e disegnato un caso del genere"_.

La sequenza è dunque: **un partecipante contesta il design → viene interrogato
NotebookLM → il riassunto viene incollato → Elena Spini conclude _"a quanto pare
Sabatino aveva ragione"_**. L'output è stato prodotto per dirimere un disaccordo,
e **il partecipante che lo ha contestato non lo ha accettato**. Resta un riassunto
AI di riunioni già presenti in questo record.

### Il build è fermo, e due cose restano in attesa

Un solo commit dal run precedente, quello della procedura notturna. **La PR #47 è
ancora aperta e intatta** dal 16/09 16:03Z, ancora priva di descrizione. 🔴
**`4132dab`, la rimozione di `Incassato`, non ha ancora alcuna pull request**:
la scrittura sullo stato di pagamento dell'ordine raggiungibile da ospite resta
su `DevMain` e in UAT.

🔴 **Dietro Andrea Di Cicco ci sono ora cinque domande**, non quattro. La quinta è
disegnata sul file di design dal 20 agosto — il post-it `Scadenziario MEXAL -
Check con Andrea` che chiede se una fattura non pagata possa riportare un Asset
allo stato precedente, il che determina se il pulsante `Aggiornamento Incasso`
riservato all'amministrazione possa funzionare. Ha declinato la riunione interna
di oggi ed era attivo su Slack stamattina per un altro cliente: non è
indisponibile, è non assegnato.

## 41. Aggiornamento 17/09/2026 (nightly) — una seconda fonte citata documenta un disegno ormai superato

La run notturna ha spazzato una finestra di **novanta minuti**: la run
interattiva dello stesso giorno si è chiusa alle 11:00Z e ha committato alle
12:17Z, questa è partita alle 12:27Z. Un risultato scarno era il risultato
atteso. Ha prodotto un solo rilievo, e quel rilievo ha la stessa forma di quello
del mattino.

### 🔑 La specifica WooCommerce del 31/07 è stata modificata, e nulla al suo interno ha ricevuto risposta

`Integrazione_Salesforce_WooCommerce.docx` — la specifica di Sabatino Rinaldi del
31 luglio, il documento da cui è stato disegnato il flusso del link di checkout
di questo progetto — riporta `modifiedTime` **2026-09-17T07:40:42Z**.

⚠ **Nessuna nota di trace precedente a stanotte registra quella modifica**,
benché il timestamp cada dentro la finestra spazzata dalla run delle 11:00Z: la
query Drive di quella run partiva da 2026-09-16T21:00:00Z e riportava cinque
elementi, _"tutti modificati prima del watermark"_. Il file è stato mancato o
classificato male in quella sede. Viene registrato qui come difetto di quella
run, non come una modifica avvenuta stanotte.

**Il documento è stato letto integralmente. Nulla al suo interno si è mosso.**

- La sezione finale elenca ancora gli **stessi cinque punti da concordare tra i
  due team** — il nome del parametro URL, il formato dell'ID, la gestione dei
  prezzi, la direzione dell'integrazione e se l'id opportunità viaggi in chiaro o
  come token firmato. Il record segue quei cinque punti dallo sweep esterno del
  14 agosto. **Nessuno è risolto.**
- Specifica ancora il **mu-plugin `sf-opportunity-tracker.php` v1.0.0**, superato
  dalla sessione del 27 agosto: il componente lato cliente è il plugin di
  Sabatino Rinaldi, v1.3, che lui stesso ha scritto e mantiene.
- Specifica ancora l'**URL lungo** — id prodotto concatenati da virgole con
  quantità per singolo id — superato dalla stessa sessione, quando il link si è
  ridotto al **solo id opportunità**, perché i carrelli Funnel Kit contengono già
  il prodotto.
- **Nessuna delle due risposte dovute da Sabatino Rinaldi dal 16 settembre è
  presente:** se l'id prodotto nel link generato da Salesforce sia sempre un id
  di bundle, e che cosa avvenga delle offerte multiprodotto non racchiuse in un
  unico bundle.

⚠ **Il documento non è una risposta a quelle due domande.** Il suo _Esempio 2_ è
proprio un'offerta multiprodotto: tre id prodotto concatenati da virgole più una
quantità per id — il meccanismo che il 27 agosto ha sostituito. Ciò che il file
documenta è il disegno da cui la build si è allontanata.

⚠ **Una corruzione visibile.** La risposta REST di esempio riporta ora
`"line_items": [ciao`, una parola spuria dentro un blocco di codice JSON. **Non è
databile da questo repository** — nessuna nota cita quel blocco alla lettera — e
Drive restituisce il proprietario del file ma **nessun ultimo autore della
modifica**. **Chi ha effettuato la modifica di stamattina è ignoto e qui non
viene inferito.**

### 🔴 Due fonti citate descrivono ora meccanismi superati

È il difetto rilevato nel
[diagramma di design](../notes/The%20newest%20design%20diagram.md) quella stessa
mattina, che si ripresenta una seconda volta in un secondo documento di
proprietà del cliente. Sia `Integrazione_Salesforce_WooCommerce.docx` sia il
`Flows & Objects.drawio` noto come `DGM-2` sono citati come `source:` — il primo
in `REQUIREMENTS.md`, in `REQUISITI.it.md` e nella riga 49 del tracker, il
secondo in diverse righe del register — ed entrambi documentano meccanismi che la
build ha abbandonato.

La differenza conta: **il diagramma non ha assorbito nulla in tre settimane,
mentre questo documento viene ancora toccato.** È vivo, non abbandonato, e chi
segue la citazione si trova in mano il disegno superato.

**Riconciliare un documento del cliente non spetta a uno sweep**, ma la pratica
di citazione è ormai una questione da sign-off, non un dettaglio di archiviazione.

### ⚠ Tutto il resto era fermo, e una riunione era ancora in corso

Nella finestra, Slack a livello di workspace ha restituito venti risultati e
**nessuno era Pienissimo**; Gmail non ha restituito posta del cliente; l'unica
riunione su Fathom appartiene a un altro cliente; e la build ha prodotto **un
solo commit, quello della run interattiva**. **La #47 è ancora aperta e
intoccata**, e 🔴 **`4132dab` — la rimozione di `Incassato` — non ha ancora una
pull request**, quindi la scrittura raggiungibile da ospite sullo stato di
pagamento dell'ordine resta su `DevMain` e in UAT per il secondo giorno.

⚠ **`[PIENISSIMO] - Follow-up Interno`, 17/09 14:15–15:15 CEST, è iniziata dodici
minuti prima dell'avvio di questo sweep.** Drive non contiene note, registrazioni
né documenti per essa e Fathom non contiene la riunione — **che è lo stato atteso
per una sessione in corso, non la prova che non abbia prodotto nulla.** È la sede
dei due punti WooCommerce, e la prossima run è la prima in grado di vederne un
artefatto.

Negativi ricorrenti, ciascuno peggiore di un giorno: il cliente tace via posta da
un **ottavo** giorno con quattro artefatti dovuti; `#tproj-pienissimo` non ha uno
status da **quattordici** giorni e indica ancora un go-live del 6 ottobre; e le
righe d'ordine non hanno **ancora alcuna prenotazione**, con la Parte 6 domani e
l'UAT il 23 settembre.

## 42. Aggiornamento 17/09/2026 (sera) — sei decisioni da una sessione interna, e cinque merge in un pomeriggio

Il maggiore movimento di build in una sola giornata di progetto, e la sessione
che ne ha guidato la maggior parte era **interna a ROMI, senza cliente in
sala.**

### La sessione

[`[PIENISSIMO] - Follow-up Interno`](../notes/meetings/2026-09-17%20Follow-up%20Interno.md),
17 settembre ore 14:15 CEST, prenotata per un'ora e durata almeno 1h22m.
**Aurel Mrruku** (388 turni), **Elena Spini** (381) e **Fabrizio Mastracci**
(83); **Andrea Di Cicco è stato invitato e ha declinato.** Nessun partecipante
Pienissimo.

Sei decisioni, dal blocco `Concordato` delle note stesse:

1. **Data Cloud viene bypassato** per i flussi biglietti — i flussi si alimentano
   direttamente dall'oggetto `event invitation`, perché Data Cloud duplica i
   record per le persone unificate e rallenta il percorso (`00:12:10`).
2. **La rinuncia è bloccata una volta compilato un asset.** Altrimenti
   selezionare la rinuncia annulla tutti gli eventi associati (`00:14:41`).
3. **Tre record type per l'Opportunità**, scelti alla creazione (`00:25:26`) —
   §42.1.
4. **Un prodotto bundle blocca il resto dell'ordine** (`00:28:26`, `00:33:19`);
   gli ordini WooCommerce devono trasmettere la propria tipologia via API
   (`00:29:31`). ⚠ Esplicitamente in attesa di validazione con il cliente nella
   call di venerdì (`00:31:21`).
5. **Anagrafiche prodotto frazionate** per rateizzare i corsi ad alto costo
   (`00:34:58`, approvato `00:38:21`) — OI-142.
6. **Un record Contract creato automaticamente** per gli ordini Performance Plus
   e attivazione/rinnovo, nel momento in cui l'ordine arriva a Mexal
   (`00:40:30`, `00:47:16`) — OI-141.

⚠ **Tutte e sei sono posizioni ROMI.** Nessuna è stata portata a Pienissimo.

### 42.1 Che cosa è stato realizzato e mergiato

Cinque commit sono arrivati su `DevMain` tra le 14:29Z e le 15:01Z.

| PR  | Mergiata  | Che cosa porta                                                          |
| --- | --------- | ----------------------------------------------------------------------- |
| #48 | 14:29:39Z | `4132dab` — **la rimozione di `Incassato`**, con cinque commit estranei |
| #47 | 15:01:32Z | `af8a42b` — **il generatore di link WooCommerce e i tre record type**   |

🟢 **OI-136 è chiuso sul lato build.** `4132dab` è un antenato di `DevMain`;
`markOrderIncassato`, `canMarkOrderIncassato` e il pulsante «Segna ordine
incassato» sono del tutto assenti da `force-app/`. 🔴 **La domanda non è
chiusa** — nessuno ha deciso, e a Elisa Migliano non è ancora stato chiesto.
🔴 `QuoteAcceptanceController` resta `public without sharing` su un `quoteId`
nudo.

🟢 **I tre record type esistono**: `Recall_Tutor`, `Standart` (_Vendita
Standart_) e `Plus_Attivazione_Rinnovo`, su un nuovo business process
`Sales_Process`. 🔴 **`Standart` è scritto male sia nel nome API sia
nell'etichetta**, e il nome API è di fatto permanente una volta che dei record
lo portano. Lo stesso commit aggiunge `QuoteLineItemTriggerHandler`, che impone
un solo Bundle **oppure** prodotti Item su un preventivo — ⚠ la riunione lo
aveva deciso per l'_ordine_.

### 42.2 🔴 Il generatore di link contraddice il disegno a registro

`wooGenerateLink` emette
`https://www.pienissimo.it/checkout?add-to-cart=<id woo>&sf_opportunity_id=<id Opportunità>`,
e l'ID prodotto WooCommerce si **digita a mano** in un campo di testo libero.

Il record dice l'opposto su entrambi i punti. La sessione di disegno del 27
agosto ha ridotto il link al **solo ID opportunità** — i carrelli si costruiscono
con Funnel Kit, quindi niente `add-to-cart` e niente `quantity` — traendone la
conclusione esplicita che il pulsante non avrebbe avuto bisogno di alcun
selettore prodotto. La spiegazione dello stesso Sabatino Rinaldi, come ribadita
il 16/09, è che il tutor non deve mai conoscere né digitare un ID WooCommerce, e
si appoggia a un cron di sincronizzazione del catalogo che **non esiste**.

🔑 **E chiude per via implementativa le due domande aperte di Sabatino
Rinaldi.** Un solo ID prodotto, nessuna concatenazione: si comporta come se ogni
link portasse un bundle senza imporlo, e non ha risposta per un'offerta
multiprodotto. **È la seconda volta che questo filone vede una decisione presa
dal codice invece che da chi la possiede** — esattamente il fallimento che la
tabella dei cinque punti in OI-49 esiste per prevenire.

### 42.3 Il calendario

🟢 **Lunedì 21/09 16:00–18:00 — `[ROMI-PIENISSIMO] - Test Interni Pre-UAT`**,
con Aurel Mrruku, Rexhina Hysi e Anita Aga. La prima sessione interna di test
pre-UAT a registro, **due giorni prima dell'apertura dell'UAT**. Ha soppiantato
il `Follow-up Interno` ricorrente, annullato con la nota _«Annullo per altro
meeting»_.

🟢 **Venerdì 18/09 non è sovrapposto.** `[PIENISSIMO] - Temi Mexal` 10:00–11:00
con **Andrea Di Cicco** — la sessione sulle API Mexal che serve a OI-141 e la
prima prenotazione che rimette in sala il referente di OI-139 — e poi **Parte 6**
11:00–13:00 su Campagne/Lead. 🔴 **Le righe d'ordine restano senza
prenotazione.**

### 42.4 Che cosa non si è mosso

🔴 Il cliente è ora **in silenzio via mail da otto giorni**; credenziali Mexal,
elenco eventi, codici articolo e prezzi di listino sono tutti ancora dovuti.
🔴 `#tproj-pienissimo` non ha uno status dal 4 settembre e continua a indicare il
go-live al 6 ottobre. ⚠ `Flows & Objects.drawio` è stato modificato una decima
volta alle 17:20:06Z e **non è stato riletto**. Il registro non è stato
modificato: nulla al suo interno è diventato falso.

## 43. Aggiornamento 21/09/2026 — il cliente è tornato, l'UAT è in calendario, e il legame tranche-Mexal si rivela impossibile

Quattro giorni spazzolati (18–21/09) e **sei riunioni drillate** — la finestra più densa
del progetto. Fonti: [Data Model Parte 6](../notes/meetings/2026-09-18%20Data%20Model%20Parte%206.md),
[Flusso Recall Tutor SFDC-WooCommerce](../notes/meetings/2026-09-18%20Flusso%20Recall%20Tutor%20SFDC-WooCommerce.md),
[l'interna del 18/09](../notes/meetings/2026-09-18%20Interna%20Temi%20Mexal.md),
[l'interna Mexal del 21/09](../notes/meetings/2026-09-21%20Interna%20Temi%20Mexal.md),
[Test WooCommerce e Temi Mexal](../notes/meetings/2026-09-21%20Test%20WooCommerce%20e%20Temi%20Mexal.md),
[Test Interni Pre-UAT](../notes/meetings/2026-09-21%20Test%20Interni%20Pre-UAT.md).

### 🔑🔴 Mexal non può ricevere una data di scadenza fattura, e il cliente non lo sa

**Il rilievo della finestra.** Mexal **non espone alcun campo attraverso cui Salesforce
possa impostare una data di scadenza fattura.** `data scadenza riga` (riga d'ordine,
inviata da Salesforce) e **`Data scadenza PG`** (scadenziario/fattura) **non sono in
relazione uno a uno**: `Scad PG` è calcolata da Mexal in base alla modalità di
pagamento. Aurel Mrruku ha dimostrato che il campo indicato nell'Excel condiviso su
`scoperto clienti` non esiste; Andrea Di Cicco ha confermato.

**Esistono solo due API in uscita** — cliente e ordine. Un'API `evasione riga`
creerebbe le fatture per riga, ma **Fabrizio Paganelli ha stabilito che le fatture si
creano a mano su Mexal**, quindi non viene usata. Di conseguenza **la data di scadenza
della fattura non esiste finché una persona non la digita**, e un utente
dell'amministrazione deve **leggere le date delle tranche su Salesforce e reinserirle in
ogni fattura Mexal**, per ogni ordine bundle e Performance Plus. **Quella data è
l'unica chiave che lega fattura e tranche.**

🔴 **È stato posto a Fabrizio Paganelli alle 16:00 del 21/09 e interrotto dopo due
minuti**, quando Daniela Morgese lo ha chiamato in un'altra riunione. Il cliente ha
confermato la fatturazione manuale e **non è stato informato di quanto gli costa.** →
[OI-143](../notes/items/OI-143%20The%20tranche%20invoice%20date%20must%20be%20re-keyed%20by%20hand%20into%20Mexal.md)

🔴 E **un bundle non può portare n date di tranche come riga unica**, quindi i bundle
vanno spacchettati in n righe d'ordine — cambiando il calcolo del totale e
contraddicendo la regola vigente dell'elemento unico. →
[OI-144](../notes/items/OI-144%20Bundles%20must%20be%20split%20into%20order%20lines%20for%20Mexal.md)

⚠ **Entrambi i meccanismi prima sul tavolo sono ora esclusi da qualcuno**: Elisa
Migliano ha obiettato ai prodotti frazionati il 18/09, e la sua stessa controproposta è
sconfitta da questo rilievo il 21/09. La sessione `Logiche Spacchettamento Righe` del
22/09 si apre senza alcuna proposta in piedi.

### 🟢🔑 Il link di checkout è risolto, e il rilievo del 17/09 è superato

Il **18/09** Sabatino Rinaldi ha respinto il link `add-to-cart` mergiato — lo shop
costruisce i carrelli con **Funnel Kit** — e ha dato l'anatomia reale: **il nome del
funnel, non un id prodotto**. Ha inoltre **risposto a entrambe le domande che doveva dal
16/09 eliminandone il presupposto**: un prodotto o bundle per link, multiprodotto
rinviato.

Ricostruito due ore dopo (`479d076`, mergiato nella PR #50) come
`https://shop.pienissimo.com/checkouts/<funnel>/?sf_opp_id=<id>`, e **provato
end-to-end con il cliente il 21/09**: ordine trasmesso, id ordine restituito,
Opportunità collegata. 🔴 I fallimenti lungo il percorso sono il rilievo — **prodotti
senza SKU e SKU inesistenti su Salesforce** — e il percorso verde è passato su un
**articolo omaggio a prezzo zero**. 🔴 La lista di recall non ha titolare, e la
tipologia d'ordine non viaggia ancora. →
[OI-49](../notes/items/OI-49%20WooCommerce%20checkout-link%20flow.md)

### 🔑 L'UAT è fissato e confermato — con un tema mancante

Proposta 18/09, conferma del cliente 21/09, **sei inviti inviati**: 24/09 Lead e
Opportunità · 25/09 Preventivi · 30/09 Biglietti, Campagne ed Eventi · 02/10 Flussi MKT
· 05/10 Performance Plus + date pagamento · 06/10 Integrazione Mexal. **Approvazione
entro il 13/10, go-live 21/10.** Il 1 ottobre è stato escluso come festività
sammarinese e il 3–4 ottobre perché fine settimana; ⚠ il cliente ha chiesto per
iscritto il 3 o il 4 ottobre e **non ha ricevuto risposta scritta**.

🔴 **Il settimo tema proposto — WooCommerce e il link di checkout — non è mai stato
fissato.** →
[OI-158](../notes/items/OI-158%20No%20UAT%20session%20is%20booked%20for%20the%20checkout-link%20flow.md)

🔴 **Non esiste un ambiente UAT full.** Aurel Mrruku, 18/09: _«non abbiamo una full»_ —
tutto ciò che si chiama UAT è una **Partial Copy**, e la catena ordine→Mexal è spenta in
ogni sandbox. →
[OI-153](../notes/items/OI-153%20There%20is%20no%20full%20UAT%20sandbox.md)

### 🟢🔴 Il cliente ha consegnato i dati di migrazione, senza classificazione

Otto tabelle il 21/09, tra cui **Lead** e **Locali**, le lacune aperte da sei sessioni —
e **`ARTICOLI` non ha né il flag biglietto né il flag bundle**. Aurel Mrruku:
_«Non ha fatto niente, praticamente.»_ 40 dei 43 prodotti biglietto restano non mappati,
con l'UAT biglietti il 30/09. →
[OI-154](../notes/items/OI-154%20The%20client%20import%20extraction%20is%20missing%20the%20article%20classification.md)

### Data Model Parte 6 — l'ultima sessione

Sconti **solo sulle righe articolo**, sconto di testata eliminato
([OI-145](../notes/items/OI-145%20Order%20header%20discounts%20are%20removed.md)) ·
**campagne padre/figlio** con date di competenza e controllo di sovrapposizione · una
nuova entità **`ingressi`** per gli eventi plurigiornalieri, **sospesa da Elena Spini la
sera stessa** ([OI-146](../notes/items/OI-146%20Ingressi%20structure%20for%20multi-day%20events.md)) ·
**i biglietti non scansionati si chiudono tre giorni dopo l'evento**
([OI-147](../notes/items/OI-147%20Unused%20tickets%20close%20three%20days%20after%20the%20event.md)) ·
**`tipologia evento` obbligatoria alla creazione**
([OI-148](../notes/items/OI-148%20Tipologia%20evento%20is%20mandatory%20at%20event%20creation.md)) ·
la **suddivisione dei ricavi San Marino**
([OI-155](../notes/items/OI-155%20San%20Marino%20revenue%20split%20and%20warehouse%20causale.md)).

### La sessione interna pre-UAT

**Due record type per il Lead** ([OI-149](../notes/items/OI-149%20Two%20Lead%20record%20types.md)) ·
**tipologia Opportunità da una picklist sul Lead**, il meccanismo che mancava a OI-140
([OI-150](../notes/items/OI-150%20Opportunity%20type%20comes%20from%20a%20Lead%20picklist.md)) ·
**uno step di firma sul preventivo** prima della generazione dell'ordine, con il set
documentale finalmente noto
([OI-151](../notes/items/OI-151%20Quote%20signature%20step%20before%20the%20order%20is%20generated.md)).
🔴 Una lacuna di permessi è stata aggirata **condividendo l'utenza di Aurel Mrruku**,
cosa impraticabile in UAT. Le due mail di eccezione su `QuoteTrigger` dalla sandbox
partial sono spiegate da questa sessione: un **trigger rilasciato senza il metodo del
proprio handler**, corretto in sessione.

### 🔴 Sicurezza e governance

- **`QuoteTriggerHandler` è ora `public without sharing` su `DevMain`** — una riga
  dentro un commit di 1.068 righe intitolato ad altro, senza requisito, senza
  descrizione, e adiacente a un errore di permessi guest che nessuno ha collegato.
  → [OI-156](../notes/items/OI-156%20QuoteTriggerHandler%20runs%20without%20sharing.md)
- 🟢 **I metadati DocuSign sono arrivati in source** (PR #54, aperta) **senza alcun
  segreto** — verso l'ambiente demo, quindi è dovuto uno switch di produzione. Il
  contratto DocuSign del cliente è arrivato il 21/09; le credenziali sono ancora dovute.
- 🔑 **Il referente di progetto è passato da Sabatino Rinaldi a Fabrizio Paganelli**,
  dallo status di Elena Spini del 21/09 — il primo in diciassette giorni, e il primo che
  riporta `21.10`.
- 🟢 **Il cliente ha confermato l'interesse per una quotazione di Fase 2**, primo
  movimento su [OI-83](../notes/items/OI-83%20No%20phase%202%20estimate.md) da settimane.
- 🔴 **`Standart` è ancora scritto male** in sei punti su `DevMain`. **L'UAT apre fra tre
  giorni.**
- 🔴 **Un modulo RID rivolto al cliente finale è promesso nel copy delle email
  contrattuali e non esiste.**
  → [OI-152](../notes/items/OI-152%20The%20RID%20mandate%20form%20promised%20to%20customers%20does%20not%20exist.md)
- 🔴 **Note di credito e storni sono usciti dal piano senza una decisione.**
  → [OI-157](../notes/items/OI-157%20Credit%20notes%20and%20storni%20are%20unbuilt%20and%20undefined.md)

## 44. Aggiornamento 22/09/2026 — cinque sessioni in un giorno, e il titolo del §43 era sbagliato

Un giorno analizzato e **cinque riunioni approfondite**. Fonti:
[Temi QR Code Biglietti](../notes/meetings/2026-09-22%20Temi%20QR%20Code%20Biglietti.md),
[Logiche Spacchettamento Righe](../notes/meetings/2026-09-22%20Logiche%20Spacchettamento%20Righe.md),
[Update Interno Aurel Elena](../notes/meetings/2026-09-22%20Update%20Interno%20Aurel%20Elena.md),
[Test Mexal](../notes/meetings/2026-09-22%20Test%20Mexal.md),
[Test Interni Pre-UAT Parte 2](../notes/meetings/2026-09-22%20Test%20Interni%20Pre-UAT%20Parte%202.md).

### 🟢🔑 La correzione: nessuna data di tranche va reinserita a mano

**Il §43 affermava che un utente dell'amministrazione deve leggere le date delle tranche
su Salesforce e reinserirle in ogni fattura Mexal, e che quella data è l'unica chiave di
collegamento. Entrambe le affermazioni sono sbagliate.** Due sessioni cliente del 22/09
hanno stabilito il perché.

1. 🟢 **Le date viaggiano già.** Una vendita Performance Plus è **n righe d'ordine con
   lo stesso codice articolo**, ciascuna con la propria `data scadenza`, e l'ordine
   _«passa paro paro su Mexal»_ — Fabrizio Paganelli l'ha dimostrato dal vivo su Mexal,
   ed è così che il cliente lavora da anni.
2. 🟢 **Data fattura e data scadenza non devono coincidere.** La lettura del 21/09 che lo
   pretendeva era l'errore. La data di riga è **commerciale** — quando il cliente deve
   pagare — e l'amministrazione la **traduce**: una riga in scadenza il 30/06 si fattura
   il **01/06**. _«ai tutor non li possiamo far ragionare con la testa amministrativa.»_
3. 🟢 **La chiave di collegamento è strutturale.** Fabrizio Paganelli: _«lavorare sulla
   data di scadenza ci creerà dei casini in futuro. Noi dobbiamo lavorare su elementi
   strutturali delle tabelle.»_ Mirko Merendi ha nominato i campi: la fattura porta
   **sigla + numero ordine** dell'ordine, e lo scadenziario porta **codice cliente, serie
   documento, numero documento, data documento**.
4. 🔴 **Agganciarsi alla data sarebbe stato attivamente sbagliato.** Le date di scadenza
   dello scadenziario si spostano: una Ri.Ba. insoluta **rigenera** la data, e i piani di
   rientro si concordano caso per caso. _«sulle date di scadenza è bene non fare nessun
   tipo di automatismo di programma perché è un casino.»_

Aurel Mrruku, tre ore dopo: _«tutte le complicazioni che avevo previsto non succedono
più… Non so perché l'hanno complicato all'inizio.»_ →
[OI-143](../notes/items/OI-143%20The%20tranche%20invoice%20date%20must%20be%20re-keyed%20by%20hand%20into%20Mexal.md)
(superata, conservata come registrazione del 21/09)

🟢 **`ORD-02` non è più contraddetta dall'argomento della data.** _«tutto l'ordine passa
poi a Mexal con entrambi i valori a livello di riga»_ è esattamente ciò che il cliente
fa. Il testo del registro non viene riscritto qui, perché resta aperto un passaggio
meccanico:

🔴 **Ciò che sopravvive è l'identificativo.** L'id Salesforce da 18 caratteri non può
viaggiare; Fabrizio Paganelli ha chiesto un campo **`numero riga ordine`** sull'ordine, e
la sessione del pomeriggio ha scelto invece **il numero d'ordine di Mexal**. La fattura
Mexal referenzia l'_ordine_, lo scadenziario referenzia la _fattura_ — quindi **quale
_riga_ d'ordine Salesforce venga saldata non è ancora stabilito da nessuno dei due
capi**, ed è esattamente il caso che conta per n righe di un solo codice articolo. →
[OI-166](../notes/items/OI-166%20The%20order%20line%20needs%20a%20shared%20identifier%20for%20Mexal.md)

### 🟢 Il meccanismo delle tranche concordato, costruito lo stesso giorno

Un **campo numerico sul prodotto** porta il numero di tranche; il prodotto inserito una
volta genera **n righe d'ordine** con una griglia di date, nominate `1 di n`, `2 di n`.
Le cadenze in uso sono **5, 10 e 12**, e il meccanismo è dinamico. Concordato alle 11:22,
confermato col fornitore alle 15:00, **dimostrato funzionante alle 17:00**. →
[OI-167](../notes/items/OI-167%20Plus%20orders%20explode%20from%20a%20tranche%20count%20on%20the%20product.md)

⚠ Supera la _forma_ della
[OI-142](../notes/items/OI-142%20Fractional%20product%20records%20for%20tranche%20payment.md):
i record frazionari esistono, ma come un codice ripetuto n volte. **L'obiezione di Elisa
Migliano del 18/09 è superata e lei non ne è stata informata.**

### 🟢 I bundle non sono mai stati un problema

Fabrizio Paganelli ha mostrato un ordine bundle che arriva a Mexal come **articoli
componenti**, ciascuno con la propria data di scadenza. Il totale viene spalmato sui
componenti **in modo ponderato sul valore di listino e sulle quantità**, con **modifica
manuale riga per riga** — il suo caso è azzerare un evento gratuito dentro il bundle. Ha
rifiutato qualcosa di più sofisticato; i bundle si costruiscono _«8-10 volte all'anno»_.
→ [OI-144](../notes/items/OI-144%20Bundles%20must%20be%20split%20into%20order%20lines%20for%20Mexal.md)
(risolta)

🔴 **Residuo di sviluppo**: non viene creato alcun `PricebookEntry` per il prodotto
bundle (_«I have missed this one»_), la testata richiede `totale bundle` e `totale
listino prodotti`, e selezionare un secondo bundle sostituisce silenziosamente il primo.

### 🔴 Le condizioni di pagamento per riga sono impossibili, e cambierà il comportamento commerciale

Mirko Merendi: la condizione di pagamento esiste **solo nella testata dell'ordine**,
**l'unico campo disponibile sulla riga è la data di scadenza**, e Mexal **non ha campi
nascosti**. Il gruppo ha deciso **all'unanimità** di non forzare il sistema e di
**adattare i comportamenti commerciali**; Fabrizio Paganelli ripulirà i codici di
pagamento obsoleti e ne creerà di nuovi strutturati per Salesforce. 🔴 **Nessuno ha
definito quale sia il cambiamento di comportamento**, e nessun tutor era presente in
nessuna delle due sessioni. 🔴 **La Mastery non ha alcun meccanismo**: un biglietto di
valore alto, nessuna suddivisione in righe, nessuna condizione per riga. →
[OI-160](../notes/items/OI-160%20Payment%20conditions%20cannot%20vary%20by%20order%20line.md)

### 🔑 È emersa un'intera integrazione: l'app di check-in eventi

Tutto ciò che è registrato sui QR code riguarda la loro _generazione_. Nulla stabiliva
che cosa li _legge_. Andrea Parmeggiani gestisce un'**applicazione Android custom** su
REST verso Zoho, distribuita con TestFlight e pacchetti APK, aggiornata circa ogni
novanta giorni.

🟢 Concordato per la Fase 1: l'app chiama Salesforce, l'asset passa a **`utilizzato`**,
**la validità si verifica sulle date della campagna figlia**, **un check-in per evento**
e non per giornata, e lo stato del campaign member deriva dall'asset via formula. →
[OI-161](../notes/items/OI-161%20The%20event%20check-in%20app%20must%20integrate%20with%20Salesforce.md)

🟢 **Infopoint è rinviato alla Fase 2** da Elena Spini ed Elisa Migliano — crea biglietti
senza ordine, cosa che Aurel Mrruku ha mostrato falsare le statistiche, e richiederebbe
quattro endpoint. ⚠ **Il rinvio toglie l'integrazione, non la situazione**: gli ingressi
last-minute e i pagamenti in loco avvengono anche in Fase 1. →
[OI-162](../notes/items/OI-162%20Infopoint%20and%20orphan%20tickets%20are%20deferred%20to%20Fase%202.md)

⚠ Elena Spini ha nominato come è sfuggito: _«di questa app non ne hanno mai parlato»_, e
aveva letto _«QR code fatto»_ come comprensivo di scansione e aggiornamento asset.

🔴 È il **secondo deliverable di Fase 1 in capo a Pienissimo Software Srl**, accanto al
middleware Anticipay — l'entità che ROMI sostiene non essere il cliente di questo
progetto.

### 🟢 La classificazione degli articoli c'era da sempre

`natura articolo` porta l'intera classificazione come **codice a quattro valori** —
genera biglietto / solo bundle e le loro negazioni — e non come due flag popolati
separatamente. Fabrizio Paganelli l'ha dichiarato in sessione, e Aurel Mrruku l'ha
confermato sullo stesso file. 🔴 **La legenda è arrivata come due mail di soli
screenshot** (14:21Z e 14:23Z) che nessuno strumento a disposizione di questo job può
leggere, e `Articoli Salesforce.xlsx` è stato aggiornato alle 14:36Z. →
[OI-154](../notes/items/OI-154%20The%20client%20import%20extraction%20is%20missing%20the%20article%20classification.md)

Deciso anche sull'anagrafica: `categoria statistica` **memorizzata e mostrata combinata**
(stile `C10 Performance Plus`), `tipo articolo` eliminato perché solo-Mexal, `livelli`
articolo come picklist sul testo esatto dei valori di livello zero, prefissi di
ordinamento `A`/`B`/`C`/`D` compresi.

### 🔴 A due giorni dagli UAT Lead, il percorso Lead ha tre problemi aperti

- **I Lead arrivano senza record type.** Il test Web-to-Lead di Elena Spini alle 18:18
  CEST: il parametro viene inviato e non applicato. →
  [OI-164](../notes/items/OI-164%20Web%20to%20Lead%20leads%20arrive%20without%20a%20record%20type.md)
- **La conversione non ha una regola sui duplicati.** Sollevata dagli sviluppatori; la
  direzione è deduplicare sulla sola P.IVA, non decisa, mai posta al cliente. →
  [OI-163](../notes/items/OI-163%20Lead%20conversion%20has%20no%20agreed%20duplicate%20rule.md)
- **Una regola `agente` che blocca la conversione è in costruzione mentre il cliente ci
  sta pensando** — _«he said he's going to think about it, but I'm putting it right
  now»_. L'accordo diceva soltanto che l'agente appartiene al cliente. →
  [OI-169](../notes/items/OI-169%20Agent%20code%20and%20commissions%20come%20from%20the%20customer%20record.md)

E l'ortografia è ora incoerente con se stessa: il nuovo record type del Lead è
**`Standard`**, quello dell'Opportunità è ancora **`Standart`**, in sei punti su
`DevMain`. → [OI-140](../notes/items/OI-140%20Three%20Opportunity%20record%20types.md)

### 🟢 La catena preventivo-ordine ha girato end to end

Preventivo → PDF → DocuSign → documento firmato → preventivo `Accettato` → **ordine
creato automaticamente**, verificato nel log di integrazione. ⚠ La mail arriva
dall'utenza della sviluppatrice sull'account DocuSign demo, sopravvivono sia il
preventivo firmato sia quello non firmato (il non firmato va eliminato), e **il corpo del
contratto non è stato toccato**. 🔴 **Anticipay è costruito e disattivato**, con il
controllo P.IVA ancora da rendere obbligatorio alla creazione dell'account.

### 🔴 La logica del contratto non è iniziata, ed è negli UAT del 5 ottobre

Aurel Mrruku: _«we haven't even started with it… I haven't even started thinking about
it.»_ `Contratto` è nell'agenda validata dal cliente per il **5 ottobre**, l'approvazione
è attesa entro il 13 ottobre, e le domande a cui ha bisogno di risposta non sono scritte
da nessuna parte. →
[OI-168](../notes/items/OI-168%20Contract%20logic%20is%20not%20started%20and%20is%20on%20the%205%20October%20UAT.md)

### 🔴 La migrazione dati non è mai stata pianificata né stimata

_«non avevo calcolato il tempo per la migrazione dei dati. Non sarà una cosa che si farà
in un giorno.»_ Il go-live è il 21 ottobre, Zoho scade il 31 ottobre, i dati del cliente
non sono puliti, e la produzione significa portare le strutture, migrare i dati e poi
dare gli accessi, in quest'ordine, senza uno slot dedicato. 🟢 `Check Data Import` è
fissato per il 23/09 10:00–12:00. →
[OI-165](../notes/items/OI-165%20Data%20migration%20was%20never%20planned%20or%20estimated.md)

### Lo sviluppo

- 🟢 **PR #54 mergiata alle 07:38Z** — i metadati DocuSign sono su `DevMain`
  (`cf9b6b6`).
- 🔴 **`ab47b42` porta altre tre classi a `without sharing`** e ne crea una quarta già
  così, in un commit il cui oggetto lo dichiara. Cinque nello stack preventivi ora;
  **undici già su `DevMain`.** Aperta nella PR #55. →
  [OI-156](../notes/items/OI-156%20QuoteTriggerHandler%20runs%20without%20sharing.md)
- 🟢 **Lo stesso commit automatizza l'invecchiamento a 5 giorni del preventivo**
  (`QuoteNegotiationAgingBatch`, cron `0 0 3 * * ?`, nuovo `In_Trattativa_Dal__c`),
  realizzando la regola concordata _«Validità 5 giorni»_ del registro — il primo
  movimento su quella macchina a stati in quindici giorni. ⚠ Gli alert del registro al
  secondo giorno e alla scadenza non sono ancora realizzati.
- 🟢 **Entrambe le PR aperte puntano a `DevMain`**, quindi lo schema del target `main`
  non si è ripetuto.
- ⚠ **`54e0be1` modifica anche due note** (OI-149, OI-150) su `DEV_leadDiagnose`. Le
  modifiche sono pulite, con frontmatter corretto e `updated:` aggiornato — **la seconda
  volta che gli sviluppatori mantengono `notes/` da sé.** Questo passaggio ha
  deliberatamente lasciato intatte entrambe le note su `DevMain`, perché la PR #55 non
  trovi un conflitto.

### 🔴 La sospensione degli `ingressi` ha cinque giorni e il cliente l'ha estesa

Fabrizio Paganelli ha chiesto per mail alle 15:05Z **un fattore di conversione sul
prodotto per determinare il numero di ingressi**. Aurel Mrruku ha rinviato al giorno dopo
senza menzionare che la struttura è sospesa. 🔴 E il perimetro concordato dell'app di
check-in è **un check-in per evento**, dove gli `ingressi` erano pensati per registrare
ogni ingresso — una collisione diretta di cui nessuno ha parlato. Gli UAT biglietti sono
il 30 settembre. →
[OI-146](../notes/items/OI-146%20Ingressi%20structure%20for%20multi-day%20events.md)

### 🟢 Gli UAT sono ri-validati, e la sessione mancante era una dimenticanza

Il tema WooCommerce era stato **perso nella riscrittura delle date**, non eliminato. Ora
è incluso in **ven 25/09 `UAT: Recall Tutor + Bundle`** con Marco Montesi, inviti
aggiornati alle 16:34–16:35Z, ed Elena Spini ha pubblicato il **calendario validato dal
cliente** alle 18:37 CEST. **Il 1 ottobre è sparito** (festivo a San Marino), il 6
ottobre copre ora anche **Anticipay** e va dalle 10:00 alle 13:00. ⚠ La richiesta scritta
di Fabrizio Paganelli per il 3 o 4 ottobre è ancora senza risposta scritta. →
[OI-158](../notes/items/OI-158%20No%20UAT%20session%20is%20booked%20for%20the%20checkout-link%20flow.md)
(risolta)

## 45. Aggiornamento 23/09/2026 — verifica org alla vigilia dell'UAT: ciò che il cliente testerà non è ciò che contiene `DevMain`

> ⚠ **Questa sezione registra SOLO lo STATO DELLA BUILD.** Sostituisce le
> affermazioni delle sezioni precedenti su ciò che **esiste** nell'org. **Non**
> sostituisce quanto le sezioni precedenti registrano come **concordato**: una
> decisione resta presa anche dove l'implementazione la contraddice.

Verifica in sola lettura di **Pienissimo UAT** (`00DMA000004nMMr2AM`, sandbox
parziale, API 68.0) il **23/09/2026, 08:01–08:40Z**, rispetto a `force-app/` su
`DevMain` al commit `61f2a53`, worktree pulito. **442** chiavi di componente del
repository confrontate con **1.382** componenti dell'org, nessun tipo non disponibile.
Ogni classe Apex, trigger e LWC non gestito è stato confrontato token per token, e
ogni corpo diverso è stato confrontato con ogni commit di ogni branch remoto. Nessun
test eseguito, nessun deploy, nessun dato dell'org modificato.

### 45.1 🔑 Perché i Lead da Web-to-Lead non hanno record type (OI-164)

Tutti e **quattro** i Lead arrivati dal form web il 22/09 sono senza record type.
Vengono creati dal creatore predefinito dei Lead, **`Amministratore Pienissimo`**, con
profilo **System Administrator**. Un retrieve di riferimento mostra quel profilo con
**`Lead.Diretta` e `Lead.Standard` entrambi `visible=false` e nessun default**. L'unica
concessione di questi record type è il permission set `Full_Permission`, e **quell'utente
non ce l'ha**. Il form invia un record type che l'utente creatore non può usare, e il
Lead finisce su Master.

**La correzione è di configurazione, non di codice**, e va fatta prima della sessione
del 24/09. Non è stata applicata: il controllo è in sola lettura.

### 45.2 🔴 Lavoro in merge mai arrivato in UAT (OI-170)

| Componente                                             | In UAT                                | Su `DevMain`       | Effetto in UAT                                                                       |
| ------------------------------------------------------ | ------------------------------------- | ------------------ | ------------------------------------------------------------------------------------ |
| `LeadConversionQueueable`                              | `08b97cc` (21/09)                     | `54e0be1` (PR #55) | **Ogni Opportunità convertita diventa `Standart`**; la tipologia del Lead è ignorata |
| `QuoteLineItemTrigger` + `QuoteLineItemTriggerHandler` | `2d31ebe` (18/09)                     | `ab47b42`          | Nessun ritorno in `Bozza` quando si aggiunge una riga                                |
| `QuoteLineItemsController`                             | `e992e6a` (17/09)                     | `ab47b42`          | Ancora `with sharing`                                                                |
| `QuoteNegotiationAgingBatch`                           | una versione del 21/09, stessa logica | `ab47b42`          | Ancora `with sharing`; la pianificazione giornaliera è attiva                        |

[OI-150](../notes/items/OI-150%20Opportunity%20type%20comes%20from%20a%20Lead%20picklist.md)
registra un _«deploy check-only»_ della mappatura il 22/09. **Un deploy check-only
non cambia nulla nell'org.** Campo e record type sono deployati, quindi in UAT la
picklist sembra funzionare ma alla conversione non fa nulla.

### 45.3 🔴 Lavoro deployato che nessun commit contiene (OI-171)

Alle **07:59–08:00 UTC di oggi** l'utente amministratore condiviso `ROMI COMPANY` ha
modificato in UAT `QuoteManageProductsController` e l'LWC `quoteManageProducts`. La
modifica aggiunge a Gestisci Prodotti uno **sconto percentuale o un prezzo manuale solo
per i bundle**. **Il contenuto non corrisponde ad alcun commit su alcun branch.** È la
quinta volta che si trova lavoro nell'org e non nel controllo sorgente.

**L'ordine conta:** un deploy di `DevMain` per risolvere il §45.2 lo sovrascriverebbe,
quindi va prima fatto il commit. Quel deploy porterebbe in UAT anche le quattro
modifiche `without sharing` di
[OI-156](../notes/items/OI-156%20QuoteTriggerHandler%20runs%20without%20sharing.md):
19 classi di questo tipo su `DevMain`, 15 nell'org.

### 45.4 Cosa è cambiato dal §36

| Al 14/09                                                    | 23/09                                                                                          |
| ----------------------------------------------------------- | ---------------------------------------------------------------------------------------------- |
| Catena Mexal solo nell'org (9 classi)                       | 🟢 **Nel controllo sorgente e deployata**; l'org coincide con `DevMain` salvo la formattazione |
| Credenziali solo nell'org, deploy pulito fallisce due volte | 🟢 3 named credential e 3 external credential in `force-app/`                                  |
| Mappatura edizione 3 su 43                                  | 🟢 **13 su 51**, 38 ancora senza mappatura                                                     |
| `Happy Team` assente da `Evento__c`                         | 🟢 Presente                                                                                    |
| Invecchiamento preventivi non costruito                     | 🟢 Pianificato ogni giorno alle 01:00 UTC, tre esecuzioni completate                           |
| DocuSign                                                    | 🟢 15 job di busta in sette giorni; il log mostra 11 riusciti e 4 errori                       |
| Tranche sulle righe ordine 3 su 36                          | 🟢 **15 su 60**; 58 su 76 righe preventivo                                                     |
| Sincronizzazione notturna Mexal non pianificata             | 🔴 Ancora non pianificata                                                                      |
| La catena Mexal non è mai partita                           | 🔴 **0 su 45** ordini con stato Mexal; la guardia `isSandbox()` è ancora presente (OI-137)     |
| Copertura 0 su 4.737                                        | 🔴 **0 su 7.756**, 79 voci; ultima esecuzione di test il 04/08                                 |

### 45.5 Non costruito, con una data di UAT

- **Contratto** — `Contract` ha zero campi custom e nulla lo scrive. **UAT 5/10.**
  [OI-168](../notes/items/OI-168%20Contract%20logic%20is%20not%20started%20and%20is%20on%20the%205%20October%20UAT.md)
- **Check-in** — 0 su 31 Asset hanno un id QR e non esiste un endpoint di check-in.
  **UAT biglietti 30/09.**
  [OI-161](../notes/items/OI-161%20The%20event%20check-in%20app%20must%20integrate%20with%20Salesforce.md)
- **Agente dall'anagrafica cliente** — nessun campo su nessuno dei quattro oggetti.
  **Correzione:** la validazione che blocca la conversione, registrata il 22/09 come
  costruita, è stata annunciata, non costruita.
  [OI-169](../notes/items/OI-169%20Agent%20code%20and%20commissions%20come%20from%20the%20customer%20record.md)
- **Regola duplicati Lead** — solo le cinque regole standard.
  [OI-163](../notes/items/OI-163%20Lead%20conversion%20has%20no%20agreed%20duplicate%20rule.md)
- **Automazione dichiarativa** — zero Flow di progetto, invariato.

⚠ L'org ha **tre utenti umani attivi, tutti System Administrator**, uno dei quali è il
login condiviso `ROMI COMPANY`. Non esiste ancora alcun account di test del cliente
(promessi per il 6–13 ottobre).

## 46. Aggiornamento 23/09/2026 — la migrazione ottiene un perimetro, la sospensione ingressi si scioglie, e il record type del Lead è ancora vuoto

Passaggio esterno, watermark **2026-09-22T22:00Z**. Due riunioni drillate:
[Check Data Import](../notes/meetings/2026-09-23%20Check%20Data%20Import.md) (cliente,
2h29m — la sessione più lunga del progetto) e
[Test Pre Demo](../notes/meetings/2026-09-23%20Test%20Pre%20Demo.md) (interna, 1h33m,
⚠ trascrizione deformata dalla macchina e non utilizzabile come evidenza).

### 🟢 La sospensione degli ingressi si scioglie — perché il cliente è stato informato

[OI-146](../notes/items/OI-146%20Ingressi%20structure%20for%20multi-day%20events.md) è
**risolta**. Fabrizio Paganelli ha posto al gruppo, di persona, la sua stessa richiesta
scritta del 22/09: un fattore di conversione sull'anagrafica prodotto. Aurel Mrruku ha
risposto _«di anagrafica articolo, no. Di anagrafica campagna»_: i record di ingresso
stanno sull'**edizione di campagna**, come blocchi di date copiati sul biglietto alla
generazione. Elena Spini ha stabilito che l'intero meccanismo è **Fase 2**. Fabrizio
Paganelli ha ripetuto il meccanismo due volte e l'ha accettato.

🟢 **Il comportamento di Fase 1, enunciato dal cliente stesso:** _«Oggi facciamo che un
biglietto è un ingresso, anche se viene 6 giorni diversi.»_ **Un biglietto, un ingresso —
Mastery di sei giorni compresa.** Vedi
[la decisione](../notes/decisions/Decision%20-%20ingressi%20live%20on%20the%20campaign%20edition%20and%20are%20Fase%202.md).

🔑 **E l'integrazione del check-in trova il suo scopo.** La scansione è una **chiamata API
in ingresso verso Salesforce**, che deve restituire un _errore parlante_ quando gli
ingressi del blocco precedente non sono completi — non l'aggiornamento unidirezionale
dell'asset che questo record porta dal 22/09. Anche questo è Fase 2, **benché il riepilogo
automatico della sessione lo elenchi tra i passaggi successivi**; la trascrizione non
sostiene quella lettura
([OI-161](../notes/items/OI-161%20The%20event%20check-in%20app%20must%20integrate%20with%20Salesforce.md)).

### 🟢 La migrazione ha un perimetro, per la prima volta

> **Elena Spini** (`02:04:53`): _«Una cosa super importante. Tutto ciò che è preventivi non
> verrà \[portato\] su Salesforce […] Verrà portato su Salesforce tutto ciò che deve finire
> su Mexal, che è già su Mexal per storico.»_

**Si migrano solo gli ordini storici.** Preventivi, offerte e opportunità nascono **ex
novo** →
[OI-172](../notes/items/OI-172%20Historical%20quotes%20and%20offers%20are%20not%20migrated.md).
🔴 **I tutor dovranno quindi reinserire a mano ogni preventivo pendente, e Marco Montesi
non era presente.**

Deciso nella stessa sessione e confluito in
[OI-165](../notes/items/OI-165%20Data%20migration%20was%20never%20planned%20or%20estimated.md):
la chiave di aggancio dell'account è il `codice cliente esterno`; si importano solo i
contatti con un nome azienda, gli altri in attesa delle indicazioni della direzione **dal
1° ottobre**; i dati di test sono filtrati a mano sui record con P.IVA. 🟢 **Lo stesso
giorno 1.010 articoli sono stati caricati via Bulk API senza errori**, con voci di Listino
Standard per tutti — registrato dagli sviluppatori stessi su `DEV_LeadAgenteBundle`.
🔴 **Restano assenti stima, sequenza di produzione e responsabile del cut-over.**

### Modifiche al modello dati concordate col cliente

L'`IBAN` è **rimosso** dal modello dei locali e sostituito da un testo libero
**`Categoria statistica Mexal`**; `tipologia attività` diventa **multi-selezione** e vive
sul locale, non sull'account; i campi di stato cliente complessi sono **eliminati**
anziché nascosti per una fase futura; lo stato attività ATECO diventa una **picklist
ristretta**; `codice fiscale`, `codice SDI` e ATECO arrivano tutti dalla **chiamata
Anticipay**, con il codice fiscale posto uguale alla P.IVA **solo** quando Anticipay non
restituisce nulla. `classificatore rete` è rinominato **`categoria provvigioni cliente`** e
la **`zona` passa dall'utente tutor all'account**.

### 🟢 OI-159 risposta in venti ore

Fabrizio Paganelli ha annotato riga per riga l'elenco di campi di Mirko Merendi il **23/09
alle 12:16:50Z**. **Salesforce deve `Tipologia pagamento` e `Agente`**; cinque campi
appartengono alla procedura Mexal; **`Gestione ratei di riga`** — l'unica voce che questo
record non copriva — è **spazio di progetto senza casistiche attuali**. Una riga è stata
trattenuta di proposito, il ramo italiano della fatturazione elettronica, ed è diventata
[OI-173](../notes/items/OI-173%20San%20Marino%20fiscal%20transcoding%20table.md), in scadenza
alla **call del 24/09 alle 10:00 con Mirko Merendi** — lo slot liberato dal rinvio della
sessione ordini/migrazione.

### 🔴 Il percorso Lead, la sera prima del test

- **[OI-164](../notes/items/OI-164%20Web%20to%20Lead%20leads%20arrive%20without%20a%20record%20type.md)
  è ancora aperta.** La causa è stata pubblicata nel gruppo dev alle 10:26 CEST; Elena Spini
  ha sollecitato alle 12:51; alle **18:28:13** ha scritto **_«il rt è sempre blank»_**. La
  correzione è ora prevista per **la mattina del giorno dell'UAT**. Nello stesso messaggio
  ha aggiunto una seconda aspettativa: dal record type `Diretta` si attende **solo `New` e
  `Qualificato`**.
- 🔴 **NUOVA —
  [OI-174](../notes/items/OI-174%20ROMI%20mail%20blocks%20DocuSign%20envelopes%20to%20the%20dev%20team.md):
  il gateway di posta ROMI blocca le buste DocuSign** verso Aurel Mrruku e Rexhina Hysi.
  DocuSign è la **seconda metà della sessione del 24/09**, e **nessuno ha verificato se un
  destinatario del dominio cliente sia coinvolto.**
- 🟢 **[OI-169](../notes/items/OI-169%20Agent%20code%20and%20commissions%20come%20from%20the%20customer%20record.md)
  è costruita dopotutto**, superando la correzione della mattina: `7eab757` alle 18:47 CEST
  crea `Agente__c` su Account, Lead, Quote e User più la validation rule che blocca la
  conversione. ⚠ **Su un branch senza pull request**, senza `zona` né `categoria provvigioni
cliente`, **e la regola blocca ancora la conversione mentre il cliente sta valutando.**

### La build

Due merge su `DevMain` alle 09:41 CEST (PR #55 `DEV_leadDiagnose`, PR #56
`DevAnitaDocuSign`), poi due push serali che **non** sono su `DevMain`: `7d0f990` di Anita
Aga (**PR #57, aperta** — branding set e tema Pienissimo, automazione delle voci di
listino, `Quote.Is_Primary__c`, `Opportunity.Preventivo_Primario__c`, `ProductCodeTrigger`,
+212 righe su `QuoteTriggerHandler`) e `7eab757` di Rexhina Hysi (**nessuna PR**).
🔴 **`Standart` è invariato**, al quinto passaggio;
[OI-156](../notes/items/OI-156%20QuoteTriggerHandler%20runs%20without%20sharing.md) è
invariata; la copertura è **0 su 7.756**.

## 48. Aggiornamento 25/09/2026 — il flusso di recall funziona, ma il bundle da palco poggia su un presupposto che nessuno ha costruito

Sweep su richiesta, watermark **2026-09-24T22:00Z**. Una riunione analizzata:
[UAT: Recall Tutor + Bundle](../notes/meetings/2026-09-25%20UAT%20Recall%20Tutor%20e%20Bundle.md) (cliente, 2h13m50s — la seconda sessione di collaudo).

### 🟢 Cosa ha funzionato

Sono stati mostrati l'opportunità Recall Tutor, il link di checkout, l'email di checkout e
un ordine WooCommerce agganciato all'opportunità. Concordato seduta stante: un **pulsante**
al posto del link in chiaro; l'**email del contatto principale** precompilata; il **nome
del cliente** e il **nome del tutor** al posto di _"gentile cliente"_ / _"team
Pienissimo"_. 🟢 **Configura Bundle** blocca il salvataggio se le righe non tornano con il
prezzo del bundle, il controllo che Fabrizio Paganelli aveva chiesto. 🟢 **I prodotti
singoli arrivano solo da Mexal; solo Fabrizio Paganelli crea i bundle in Salesforce**
([decisione](../notes/decisions/Decision%20-%20single%20products%20come%20only%20from%20Mexal%20and%20only%20bundles%20are%20built%20in%20Salesforce.md), conferma di `BUN-06`).

### 🔴 La scoperta: le tranche devono esistere sul bundle, non solo sul preventivo

Una vendita da palco funziona così: Fabrizio Paganelli crea il bundle **con una data di
scadenza su ogni riga**, e Sabatino Rinaldi mette su WooCommerce il codice del bundle e
l'importo della prima tranche. **Salesforce deve poi ricevere l'intero ordine del bundle.**
ROMI ha costruito le tranche solo sul Preventivo, e **una vendita da palco non ha
preventivo**. Aurel Mrruku: _"questo peso proprio mi mancava"_. Concordato: le tranche si
potranno definire anche alla creazione del bundle, ereditate e modificabili dai preventivi.
**Circa una settimana di lavoro, re-test dal vivo il 2 ottobre** ([OI-181](../notes/items/OI-181%20Stage-sale%20bundles%20need%20their%20tranches%20defined%20at%20bundle%20creation.md)).
⚠ `ORD-02` del registro dice ancora solo Preventivo; non modificato.

### Altre decisioni

- **Quattro tipi di vendita**: palco diretta (nessuna opportunità), Recall Tutor, Pack
  Tutor (entrambe via WooCommerce), e preventivi personalizzati, che **non** passano mai da
  WooCommerce.
- **Il tipo `Recall Tutor` diventa `WooCommerce`**, con origine obbligatoria Recall Tutor /
  Pack Tutor ([OI-182](../notes/items/OI-182%20A%20WooCommerce%20opportunity%20record%20type%20replaces%20Recall%20Tutor.md)).
- 🔑 **L'anno del bundle è l'`Anno accademico`**, ribaltando la regola dell'anno solare del
  23/07; `Evento` → `Evento di origine`; nuovo flag `Presenza piattaforma` ([OI-46](../notes/items/OI-46%20Bundle%20classification%20picklists.md)).
- Il template email (codice oppure modificabile da admin) è **una scelta del cliente**,
  dopo revisione con la direzione ([OI-183](../notes/items/OI-183%20The%20checkout%20email%20template%20choice%20is%20with%20the%20client.md)).

### 🔴 Calendario

**Il 02/10 diventa il re-test WooCommerce; il marketing slitta al 07/10**, un giorno dopo
la chiusura della finestra UAT, perché il marketing si può collaudare solo in produzione. Il
deploy parziale in produzione del 28–29/09 proposto da Elena Spini è rimasto aperto
([OI-177](../notes/items/OI-177%20The%20marketing%20flow%20UAT%20needs%20production.md)). Marco Montesi: _"una parte di questa riunione… la dobbiamo rifare"_.
Il cliente non considera accettato il flusso di recall.

### La build

Le PR **#59, #60 e #61 sono in merge** il 25/09. 🔴 **La #59 ha portato `Account.Agente__c`
su `DevMain` accanto a `Codice_Agente_Esterno__c`**, quindi il conflitto tra i due campi è
ora sulla linea principale ([OI-178](../notes/items/OI-178%20Two%20agent%20field%20implementations%20exist%20on%20two%20branches.md)). 🔴 `Firmato` non è ancora in `force-app`, e
`Standart` è invariato (settimo passaggio).

### ✅ Deciso via sessione drill-me (25/09/2026)

- **La settimana del 28/09 va alle tranche a livello di bundle**; il deploy parziale in
  produzione slitta alla settimana del 5/10 (da chiedere a Elena Spini) (drill-me 25/09/2026).
- **Il registro viene aggiornato subito, come v1.6**, nello YAML e in entrambi i documenti
  (`Firmato`; `ORD-01/02`, `DM-17`; `BUN-08`; `SAL-21`), e **inviato al cliente come unico
  insieme di modifiche alla chiusura dell'UAT** ([OI-184](../notes/items/OI-184%20Register%20v1.6%20goes%20to%20the%20client%20as%20one%20change%20set%20at%20UAT%20close.md)).
- **Restano entrambi i campi agente**, con una sincronizzazione: il lookup per persone e
  validazione, il codice per Mexal (drill-me 25/09/2026).
- **Nuovi record type puliti `Standard` e `WooCommerce`**; `Standart` e `Recall_Tutor`
  vengono ritirati dopo la rimappatura dei record UAT (drill-me 25/09/2026).

⚠ Il §47 (24/09) non è mai stato scritto in italiano; va recuperato.

## 49. Aggiornamento 25/09/2026 (sera) — la lacuna bloccante è stata costruita lo stesso giorno, e il Contratto si è ristretto a una sola famiglia di prodotti

Sweep notturno, watermark **25/09/2026 13:00Z**. Due sessioni interne e una PR unita.

### 🟢🔑 La build: `Bundle_Tranch__c` esiste, otto ore dopo la scoperta della lacuna

**La PR [#62](https://github.com/Calm-Coders/pienissimo/pull/62) è stata unita su
`DevMain` alle 18:07 CEST** (`a5f9370`), dal branch `DevAnita25/09` di Anita Aga. Commit
`04696bd` alle 17:03 CEST: _"Created an object for Bundle Tranch, created a new component
for tranch creation, edited the existing logic for quotes that contain an bundle."_

Il nuovo oggetto è un **template di tranche sul prodotto bundle**, cioè la forma che il
cliente ha chiesto quella mattina:

| Campo              | Tipo   | Descrizione nei metadati                                                        |
| ------------------ | ------ | ------------------------------------------------------------------------------- |
| `Bundle__c`        | Lookup | A `Product2`, **filtrato sul record type `Bundle`**                             |
| `Data_Scadenza__c` | Data   | _"Due date copied to the quote tranche created from this bundle template."_      |
| `Sequenza__c`      | Numero | _"Order of this tranche in the bundle payment plan."_                            |

Con **`Tranche__c.Bundle_Tranch__c`** — _"The bundle tranche template that generated this
quote tranche"_ — così una tranche ereditata è distinguibile da una creata a mano, e
**`BundleComponent__c.Bundle_Tranch__c`** per la riga. Inoltre
`BundleTranchController.cls`, l'LWC `bundleCreateTranch` (532 righe di JS), un layout, una
record page, un permission set `Full_Permission` e un ampio rifacimento di
`bundleProductAssignment` — il componente che il cliente ha visto fallire in mattinata.

🔴 **Resta bloccante.** Il **lato ordine WooCommerce non è nel diff**: un ordine che prende
le tranche dal bundle ignorando il prezzo WooCommerce non ha alcun file a supporto, e il
02/10 è il ri-test WooCommerce. `Data_Scadenza__c`, `Sequenza__c` e `Bundle__c` sono tutti
opzionali, quindi nulla impone un piano coerente. Una sera ha prodotto l'oggetto e il lato
preventivo — **la stima di "almeno una settimana" non va letta come battuta**
([OI-181](../notes/items/OI-181%20Stage-sale%20bundles%20need%20their%20tranches%20defined%20at%20bundle%20creation.md)).

🟢 La stessa PR ha portato su `DevMain` i **campi Campaign** — `Anno_Accademico__c`,
`Data_Inizio_Evento__c`, `Data_Fine_Evento__c`, `Data_Avvio_Bruciatura__c`,
`Tipologia_Evento__c`, `Luogo__c`, `Indirizzo__c`, `Parcheggio__c`, `Orario_Inizio__c`,
`Zoom_Meeting_Id__c`, `Link_Iscrizione_Infopoint__c`, `Prodotto__c` — e il record type
**`Campagna_Figlio`**, per la sessione del 30/09.

### 🔑 Contratto: solo `Performance Plus`, creato a `Firmato`, e il suo sviluppatore obietta

[Interna post UAT Contratto e Fase Due](../notes/meetings/2026-09-25%20Interna%20post%20UAT%20Contratto%20e%20Fase%20Due.md)
(17:00 CEST, 1h05m05s, Aurel Mrruku ed Elena Spini) ha ripercorso il Business Blueprint
sezione per sezione.

- 🔑 **L'oggetto `Contract` di Salesforce è per `Performance Plus` e nient'altro.** Elena
  Spini, due volte: _"Oggetto contratto su salesforce è solo performance plus."_
  L'ampiezza `attivazione/rinnovo` si restringe alla famiglia Plus.
- 🔑 **Viene creato al passaggio a `Firmato`**, superando la collocazione del 17/09 alla
  trasmissione a Mexal — il trigger è quindi
  [OI-151](../notes/items/OI-151%20Quote%20signature%20step%20before%20the%20order%20is%20generated.md),
  **che è ancora assente da `force-app`.**
- 🟢 `stato` è **`nuovo` / `rinnovo`**; il terzo valore `in corso` è stato eliminato perché
  non rintracciabile, e il valore si legge dal **record type dell'opportunità**, dato che
  esistono sia `Plus` sia `Rinnovo Plus`. `valore totale` è il valore dell'ordine.
- 🔴 **Il suo sviluppatore sostiene che non debba esistere.** I ritorni notturni di Mexal
  aggiornano le tranche, che già contengono lo stato finanziario: _"contratto non vedo
  nessun legame… che senso ha."_ Azione concordata: **portarlo a Fabrizio Paganelli lunedì
  28/09 alle 10:00 e chiedere la struttura Zoho da replicare**
  ([OI-141](../notes/items/OI-141%20Contract%20object%20for%20Performance%20Plus%20orders.md),
  [OI-168](../notes/items/OI-168%20Contract%20logic%20is%20not%20started%20and%20is%20on%20the%205%20October%20UAT.md)).

### 🔑 Gli stati della tranche, letti dall'org in diretta

Il Blueprint diceva `creato` / `chiuso` / `acquisito`. Aurel Mrruku ha aperto l'org durante
la call e ha letto **`aperto` · `parzialmente pagato` · `pagato`** — errati tutti e tre.
`parzialmente pagato` significa che solo alcuni item di quella tranche sono pagati. E
l'ordine arriva a **`Incassato` solo quando ogni tranche è `pagato`**, non all'ultima:
_"perché l'ultima trance non è corretta."_ Una tranche **può** coincidere con una singola
riga d'ordine ([OI-50](../notes/items/OI-50%20Tranche%20object.md)).

### 🟢 Il Business Blueprint non è stato consegnato al cliente

Elena Spini: _"non glielo darò mai oggi perché non se lo merita"_; Aurel Mrruku concorda nel
merito — la mattinata aveva cambiato la macchina a stati del preventivo e la logica dei
bundle. Un documento che ometteva `Firmato` sarebbe uscito sbagliato; **non è uscito**
([OI-179](../notes/items/OI-179%20The%20Business%20Blueprint%20goes%20to%20the%20client%20with%20unchecked%20points.md)).
Al cliente è andato invece il **testbook UAT**
([OI-187](../notes/items/OI-187%20The%20UAT%20testbook%20is%20with%20the%20client%20for%20comment.md)).

### 🔴 Calendario: il marketing scavalca la data di approvazione

`UAT: Flussi MKT Biglietti` è stata riprogrammata **due volte in diciannove minuti** — alle
16:34Z a giovedì 15 ottobre, alle 16:52Z a **venerdì 16 ottobre**. La nota al cliente ne dà
la ragione e risolve la questione: _"la nostra priorità attuale è stabilizzare e validare la
piattaforma in ambiente di test, così da arrivare nelle migliori condizioni al passaggio in
produzione, dove verranno poi condotti i test per i flussi Marketing."_ 🔴 **Il 16 ottobre è
oltre la data di approvazione del 13 ottobre**: il marketing diventa l'unico modulo il cui
test di accettazione cade fuori dal periodo di accettazione, dopo essere passato da 02/10 a
07/10 a 16/10 in due giorni
([OI-177](../notes/items/OI-177%20The%20marketing%20flow%20UAT%20needs%20production.md)).
In calendario anche: **Test WooCommerce** venerdì 02/10 12:00–13:00, e il follow-up interno
settimanale spostato dal lunedì al **martedì alle 17:00**.

### Punti nuovi

- 🔴 **[OI-185](../notes/items/OI-185%20The%20participant%20name%20change%20regenerates%20the%20ticket%20as%20a%20new%20asset.md)**
  (bloccante) — il cambio nominativo **rigenera il biglietto come nuovo Asset con un nuovo
  QR code**, deliberatamente, perché sopravviva il dato storico. Un bottone sull'Account
  elenca tutti i biglietti di quell'account. 🔴 Aurel Mrruku: _"Io non ce l'ho pronta questa
  roba"_ — e l'UAT biglietti è il **30/09**. Il rinvio deve coprire **tutti i biglietti
  dell'account**, perché il marketing non può sapere quale sia il nuovo.
- 🔴 **[OI-186](../notes/items/OI-186%20The%20Salesforce%20user%20list%20and%20profiles%20were%20never%20agreed%20with%20the%20client.md)**
  — ruoli, profili e permessi **non sono mai stati discussi con il cliente**. Quattro profili
  sono dedotti dall'organigramma, e **non esiste un elenco utenti** — solo ~18 codici agente.
  Il go-live è il 21 ottobre.
- **[OI-187](../notes/items/OI-187%20The%20UAT%20testbook%20is%20with%20the%20client%20for%20comment.md)**
  — `Testbook_UAT_Lead_Opportunita` è andato al cliente alle 17:27Z con una richiesta di
  commenti e **senza data**, mentre il cliente ancora non può accedere.

### Altre decisioni

- **Fase 2, per decisione ROMI e non ancora confermata dal cliente:** note di credito,
  storni e correzione dei pagamenti
  ([OI-157](../notes/items/OI-157%20Credit%20notes%20and%20storni%20are%20unbuilt%20and%20undefined.md)).
  🔑 È ora a verbale il motivo per cui il bottone sull'asset è stato abbandonato: **le
  tranche stanno a livello di prodotto e possono non contenere alcun biglietto.** Anche
  l'app di check-in è Fase 2.
- **La generazione del QR code alla creazione del biglietto ha per la prima volta un
  responsabile** — Rexhina Hysi, assegnataria
  [nella call di allineamento delle 15:31](../notes/meetings/2026-09-25%20Alignment%20Interno%20Prodotti%20e%20Bundle.md),
  con il QR collegato al documento standard.
- **Pulizia dei campi prodotto e bundle:** da rimuovere `product family`, `bundle selling
  price` e `product price`, da mantenere `is active`. 🔴 Il prezzo impostato su un bundle non
  coincide con quello calcolato dalle sue righe, e gli sconti vanno impostati riga per riga.

### Non fatto

- L'org **non** è stata aperta, quindi `STATUS.md` non è stato rigenerato; la picklist delle
  tranche qui sopra è una persona che legge in condivisione schermo, non una query.
- Nessuna trascrizione è stata copiata in `meetings/` e nessun recap per riunione è stato
  scritto in `meetings/results/`, come in ogni run dal 27/08.
- ⚠ **Il §47 (24/09) manca ancora nel recap italiano.** Terzo run che lo segnala.
