# ROMI-PIENISSIMO — Recap di Sviluppo Salesforce

> Consolidato dalle 7 riunioni tracciate (27/05/2026 → 07/07/2026), **vince la decisione più recente**. Ogni voce cita la riunione di origine. Legenda stato: ✅ DECISO · 🟡 CONDIZIONATO (deciso, in attesa di una verifica) · 🔴 APERTO (blocca la build — vedi §9).
> File collegati: recap per riunione in `results/`, tracker in `open-items.md`.

---

## 1. Cornice di progetto

| Fatto | Valore | Fonte |
|---|---|---|
| Scadenza contratto Zoho CRM | **31 ottobre 2026** (corregge il "fine settembre" del kickoff) | 08/06 |
| Finestra dual-run | Zoho + Salesforce in parallelo fino a fine ottobre; fatturazione vendite da palco resta su Zoho fino al Food Marketing; dati biglietti in doppio inserimento | 08/06 |
| Calendario vincolante | Tour (eventi gratuiti): 7–19/09 · Food Marketing Festival: 29/09 · Evento kickoff grande (1.500+): 29/10 | 27/05, 08/06 |
| Import dati in Salesforce | ~1 settembre, dopo dedup (~6.000 lead/account vs ~7.500 clienti paganti) | 30/06, 07/07 |
| Fase 1 (entro fine settembre, utilizzabile) | Tutto ciò che fa oggi lo Zoho CRM: flusso lead/opty, preventivi/ordini, **magazzino biglietti + presenze** (priorità massima), integrazioni Mexal + WooCommerce | 27/05, 08/06 |
| Fase 2 (entro fine ottobre) | Vendita prodotti via WooCommerce/GLS (libri, videocorsi), flussi Pienissimo Pro, analytics Data Cloud, automazioni restanti | 30/06 |
| Metodo | ROMI scrive il **blueprint** → Pienissimo approva → configurazione (in parte in parallelo) → review con i key user in ambiente di test | 27/05 |
| Principi guida | Niente "accrocchi" — ridisegnare, non replicare; partire semplici/manuali, automatizzare ciò che si ripete; ogni decisione di design deve servire le **statistiche/dashboard finali** | 27/05, 16/06, 07/07 |
| Lingua org | Italiano (tradurre le label custom nel translation workbench) | 03/06 |

## 2. Data model

| Oggetto | Uso / decisioni | Stato |
|---|---|---|
| **Lead** | Solo azioni self-service senza intento d'acquisto (iscrizione diretta, video gratuito, quiz). Le fasi iniziali del workflow (in lavorazione, non risponde, primo contatto, da ricontattare, prequalifica) vivono qui. Proprietà del marketing. | ✅ 30/06 |
| **Account / Contatto** | Account = azienda (aggiungere campo **nome locale** accanto alla ragione sociale). L'opportunità richiede sempre un account: i form creano account+contatto "primordiali" in automatico; il commerciale completa l'anagrafica dopo la prima chiamata. Chiavi dedup: **email O telefono** (form), **email + P.IVA** (ordini WooCommerce). L'origine lead-convertito resta visibile. | ✅ 16/06 |
| **Opportunità** | Creata direttamente (saltando il Lead) per: form con richiesta esplicita di contatto (landing sponsorizzate, QR in diretta) e tutte le richieste dei clienti esistenti. 4 fasi (negoziazione con sottolivelli → rinviata / persa / vinta). Chiuso-vinto guidato dal **pagamento** (manuale amministrazione). Motivazione di perdita obbligatoria, **due set di picklist** (fase opportunità vs fase preventivo; "errato" non deve esistere sui preventivi). SLA: nuova → in lavorazione entro **48 ore lavorative**, altrimenti escalation al responsabile. Passaggi di stato manuali al go-live. I **Record Type** separano flusso commerciale vs e-commerce per statistiche pulite (deciso via drill-me 13/07; i form dinamici potranno integrare la visibilità dei campi dentro ogni tipo). Tracciare origine **cliente esistente vs new business** per opportunità (attribuzione spesa ads di Daniela). | ✅ 16/06–30/06 |
| **Preventivo (Quote)** | Sempre sotto un'opportunità; più preventivi per opportunità; validità 5 giorni → sottostato "scaduto" è routine; nuovo tentativo = **clonazione** del preventivo scaduto (mantiene lo storico). Gli stati seguono l'opportunità. Preventivo = "condizioni generali + riepilogo economico" in un unico PDF. Terminologia: l'"ordine" pre-accettazione di Zoho = **Quote** in Salesforce. | ✅ 30/06 |
| **Ordine** | UN solo oggetto ordine; **una riga per rata** con data scadenza (elimina il pattern ordini figli/"blocchi" di Zoho). Max **un bundle per ordine**, mai bundle + prodotto sfuso (due ordini). Immodificabile dopo la fatturazione (set ristretto di permessi admin per correzioni). Serve campo **tipologia ordine** (palco / tutor / libro / videocorso / attivazione PP / rinnovo PP…) che guida i processi amministrativi. Ordini/prodotti da Mexal in **sola lettura** su Salesforce. | ✅ 30/06–07/07 |
| **Bundle (custom)** | Record contenitore custom (NON Revenue Cloud/CPQ — non licenziato, sovradimensionato). Prezzo fisso definito in configurazione (solo sconto manuale extra); i componenti portano **prezzi spalmati/scontati** così la statistica per prodotto sopravvive (criterio di accettazione). Configurato per evento (3–5 a evento), identico per tutti, mai modificato dopo la vendita, mai riusato (attiva/disattiva). Codici BLO e righe omaggio a 0 € morti: codici reali scontati al 100%; i BLO non migrano. UI: bundle come una riga ordine, espandibile sui componenti. | 🟡 07/07 — condizionato alla demo ROMI in test (entro la settimana dal 07/07); la questione Revenue Cloud si riapre se la demo delude |
| **Asset (o custom) — movimento biglietto** | Riproduce il "magazzino biglietti" di Zoho: unisce ordine + contatti; gli stati tracciano il ciclo a 3 stadi (§3.4). File (PDF firmati, QR) agganciati qui. | ✅ 08/06 (scelta oggetto da fissare nel blueprint) |
| **Campagna = evento** | Una campagna per edizione evento; membri campagna = partecipanti con stato check-in (partecipato / no-show) → alimenta analisi no-show e composizione sala. Codici prodotto trasversali agli anni; l'anno si gestisce con date campagna + campo anno di competenza sui movimenti. | ✅ 08/06 |
| **Contratto (Performance Plus)** | Oggetto Contract standard + logica custom: contratti-come-database (date inizio/fine/rinnovo, importo, preventivo/fatture/incassi collegati), pannello rinnovi, fatturato-vs-incassato per contratto, flag blocco servizio su scaduto grave. Annuale, fatturato in N tranche (12× mensili = stesso codice prodotto; trimestrale = codice diverso). Contratto inviato manualmente (bottone) alla conferma d'intenzione del cliente. ~100/anno in crescita. Elena proporrà nome/tipo distinto per gli ordini rinnovabili (non "bundle"). | ✅ 08/06–07/07 (sessione di analisi dedicata ancora da tenere) |
| **Fattura (Invoice)** | Creata in Salesforce come guscio di riferimento alla chiusura dell'ordine → Mexal fattura → restituisce numero/stato in campi dedicati ricercabili. Stesso pattern per ogni origine ordine. | ✅ 16/06 |
| **Nota di credito** | ~30/anno, alcune consistenti. Verificare oggetto standard in licenza, altrimenti custom. | 🔴 30/06 — verifica licenza pendente (Andrea) |

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
1. **ORDINE** inserito → movimento *caricato* (parcheggiato, non utilizzabile);
2. **PAGAMENTO** integrale della fattura collegata → movimento *disponibile* (oggi: procedura notturna Mexal→Zoho; replicare via integrazione Mexal; verifica manuale fino ad allora — dolorosa a volumi Food Marketing, 100–150 fatture/giorno);
3. **FIRMA** dei documenti (privacy, non concorrenza, consenso foto/video) via DocuSign → **si genera il QR code (biglietto utilizzabile)**;
4. **CHECK-IN**: scansione QR (app interna su telefono oggi) → movimento di scarico → somma algebrica per cliente = 0; i biglietti non usati restano visibili (dato no-show).
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

| # | Integrazione | Direzione / note | Stato |
|---|---|---|---|
| 1 | **Mexal (Passepartout)** | **REST API** (ribaltata da CSV/FTP il 07/07). Inbound: clienti, agenti, condizioni di pagamento, destinazioni, fatture, ordini, prodotti, scoperto. Outbound: ordini (+ creazione account per i prospect, insieme all'ordine). API agenti mancante → copia manuale del codice a ogni assunzione. Contatto: Mirko (Creosoft) — Fabrizio lo mette in contatto con ROMI. Da progettare la sync in dual-run. | 🟡 in analisi |
| 2 | **WooCommerce ×2** (eventi/palco + libri/marketing) | API (non plugin). Verificare se bastano le API standard Salesforce; chiavi CK/CS da Sabatino; dedup email+P.IVA; promo 2×1 = qtà 2 @50%. | 🟡 |
| 3 | **DocuSign** | AppExchange; tracking stato envelope; tre tipologie di documenti firmati + template preventivo. | 🟡 in attesa dell'acquisto |
| 4 | **Anticipay (ex CreditSafe)** | Lookup P.IVA che auto-compila anagrafica + legale rappresentante; deve scattare per TUTTI i nuovi account (non solo all'ordine); alert su P.IVA invalida; probabilmente solo P.IVA italiane (verificare skip estero). Decisione tempi (con Mexal per Pienissimo vs fase 2 per ROMI) 🔴 pendente. | 🔴 |
| 5 | **GLS** | Eventi di conferma consegna (trigger flusso libro). Da zero. | fase 2 |
| 6 | **Teachable** | API completamento corso (confermata facile). | fase 2 |
| 7 | **Pienissimo Software SRL (Zoho)** | Ordini con prodotto P-Pro passano automaticamente alla software company (entità separata, mantiene Zoho). Discriminante = prodotto. | 🟡 design |
| 8 | **Gmail/Outlook** | Connettori nativi, sync email + calendario — urgente (agende cartacee). | ✅ deciso, da configurare |
| 9 | **3CX + AI interna** | Registrazione chiamate → CRM → insight di coaching. Stato del setup commerciale 3CX MAI riferito (aperto dal kickoff). | 🔴 fermo |
| 10 | **Meta/Google Ads** | Costo di acquisizione + campagna di origine sul contatto (alimenta il pannello RFM). | dopo |

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
Morris AI scartata (AI interna) · fase demo conclusa · scadenza Zoho = 31/10 · NBA/Einstein parcheggiato (non licenziato) · QR vincolato alla firma approvato dalla direzione · fatturazione multi-tranche Mexal confermata possibile (scadenze per riga) · file-vs-API ribaltato su API · codici BLO pensionati · WooCommerce = API · un-bundle-per-ordine confermato · la "contraddizione" sul trigger biglietti era terminologia (ciclo a 3 stadi) · separazione flussi opportunità = **Record Type** (drill-me 13/07).

## 9. 🔴 Decisioni/input bloccanti — da chiudere prima del congelamento del blueprint
1. **Review del flusso lead/opty** con Daniela (riscrittura di Elena + segmento registrato) — l'ultimo grande design non approvato; rimandato DI NUOVO oltre il 9/7, nessuna novità al 13/07 → sollecitare con forza. (#19)
2. **Demo del bundle custom** in ambiente di test — criterio: statistica per prodotto via prezzi spalmati. In sviluppo, in linea per la settimana del 13/07 (drill-me 13/07). (#13)
3. **Risposte marketing su form + sottodominio** da Matteo — blocca l'intero filone marketing dal 23/06. (#14)
4. **Chiusura acquisto DocuSign**. (#16)
5. **Tempi Anticipay** (con integrazione Mexal vs fase 2) + documentazione + regola P.IVA estere. (#21)
6. **Decisione flusso firma preventivo+contratto** (interna Pienissimo). (#27)
7. **Lista key user** (mai consegnata dal kickoff) e **stato 3CX** (mai riferito). (#1, #3)
8. **Avvio workbook data model**: struttura ROMI + liste campi Pienissimo da Zoho. (#24)
9. Input Pienissimo ancora dovuti: template preventivi + mail reali (#26), Google Sheet dei form con campi fonte nascosti (#33), chiavi CK/CS WooCommerce (#22), regole di dormienza (#8), scelta canale di notifica.
10. Conferma di fattibilità: scope raggiungibile entro 29/09 / 31/10 con l'attuale lista integrazioni — ROMI ripianifica e si impegna. (#4)
