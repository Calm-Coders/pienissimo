# Documento di Requisiti — Progetto Salesforce Pienissimo

**Cliente:** Pienissimo · **Fornitore:** ROMI S.r.l. · **Progetto:** migrazione Zoho CRM → Salesforce
**Versione:** 1.4 — bozza per approvazione · **Data:** 24 agosto 2026

> **Cosa cambia nella 1.4.** È stato deciso l'oggetto target del biglietto: si usa l'oggetto standard Salesforce **Asset**. L'istruzione diretta non indica chi ha preso la decisione. L'implementazione custom `Biglietto__c` presente in UAT deve essere sostituita o migrata; l'effort non è ancora stimato. La versione 1.3 registrava la decisione di Aurel Mrruku sulle tranche create nel Preventivo.
>
> **Cosa è cambiato dalla 1.0.** Sono stati letti e integrati i due file di design draw.io — `Flows & Objects.drawio` di Elena Spini e `Workflow Pienissimo 23-7-26.drawio` annotato da Marco Montesi — entrambi ri-decodificati integralmente il **20 agosto 2026**, giorno in cui risultavano modificati nello stesso pomeriggio, rispettivamente alle 15:36 UTC e alle 14:28 UTC (questo documento riportava il 6 agosto e il 4 agosto). ⚠ **Nessuna di queste due modifiche è verbalizzata, quindi nulla di quanto segue è stato cambiato sulla loro base**; i tre punti in cui i disegni si sono spostati rispetto a questo testo sono elencati nel §17. Ne derivano il nuovo **§16** (macchine a stati, valori delle picklist, 17 requisiti che esistevano solo nei disegni) e il **§17**, che elenca i punti in cui le fonti non concordano. Due correzioni riguardano errori nostri: la lista dei tipi ordine in DM-15 era inventata, e un punto che avevamo presentato come contraddizione (la cadenza dei promemoria) non lo era. Entrambe sono descritte nel §17.
> **Sessione di approvazione:** giovedì 6 agosto 2026, 15:00–17:00 — "Chiusura ultimi punti aperti"

---

## 0. Come si legge e come si approva questo documento

Questo documento raccoglie **tutti i requisiti concordati** nelle riunioni di analisi dal 27 maggio al 31 luglio 2026 e li porta in una forma unica, numerata e verificabile. È il documento che, una volta firmato, **congela il perimetro** del progetto.

Ogni requisito ha un identificativo stabile (es. `SAL-04`), una priorità e uno stato.

| Stato | Significato                                                                                              |
| :---: | -------------------------------------------------------------------------------------------------------- |
|  ✅   | **Concordato** in riunione. Con la firma diventa vincolante e non più modificabile senza change request. |
|  🟡   | **Da confermare** in questa sessione. Il contenuto è proposto da ROMI o discusso ma non chiuso.          |
|  🔴   | **Aperto**: manca una decisione o un input del cliente. Elencati tutti nel §12.                          |

| Priorità | Significato                                                    |
| :------: | -------------------------------------------------------------- |
|  **M**   | _Must_ — indispensabile al go-live del 6 ottobre 2026.         |
|  **S**   | _Should_ — importante, ma il go-live può avvenire senza.       |
|  **C**   | _Could_ — desiderabile, realizzabile se i tempi lo consentono. |
|  **F2**  | Rinviato esplicitamente alla **Fase 2**, post go-live.         |

> **Regola di ingaggio.** Dalla firma di questo documento, ogni nuovo requisito o modifica sostanziale a un requisito ✅ segue la procedura di change request del §14: valutazione di impatto su tempi e costi, e approvazione scritta prima dell'esecuzione. Questa regola è stata comunicata verbalmente da ROMI il 31 luglio 2026 e qui viene formalizzata.

---

## 1. Contesto e obiettivi

| ID     | Requisito                                                                                                                                                                                   | Pri. | Stato |
| ------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :--: | :---: |
| CTX-01 | Sostituire Zoho CRM con Salesforce come unico CRM operativo di Pienissimo.                                                                                                                  |  M   |  ✅   |
| CTX-02 | **Data di go-live: 6 ottobre 2026**, con focus sulle integrazioni WooCommerce e Mexal. Le integrazioni minori sono rinviate alla Fase 2.                                                    |  M   |  ✅   |
| CTX-03 | Il contratto Zoho scade il **31 ottobre 2026**. La finestra di funzionamento in parallelo (dual-run) è quindi di circa tre settimane e non è prorogabile.                                   |  M   |  ✅   |
| CTX-04 | Durante il dual-run i biglietti sono inseriti in doppio (Zoho + Salesforce) e la fatturazione delle vendite da palco resta su Zoho fino al Food Marketing Festival del 29 settembre.        |  M   |  ✅   |
| CTX-05 | Principio guida: **nessun "accrocchio"**. I processi vengono ridisegnati per Salesforce, non replicati da Zoho. Si parte semplici e manuali, si automatizza ciò che si dimostra ripetitivo. |  M   |  ✅   |
| CTX-06 | Ogni scelta di design deve servire la **statistica e la reportistica finale**: se un dato non è tracciabile o aggregabile, la soluzione va rivista.                                         |  M   |  ✅   |
| CTX-07 | Lingua dell'org: **italiano**, con traduzione delle etichette custom tramite Translation Workbench.                                                                                         |  M   |  ✅   |
| CTX-08 | Terminologia di riferimento = Salesforce: Lead → Opportunità → Preventivo → Ordine. L'"ordine" pre-accettazione di Zoho corrisponde al **Preventivo** di Salesforce.                        |  M   |  ✅   |

### 1.1 Calendario vincolante

| Data                | Evento                                   | Impatto sul progetto                                                        |
| ------------------- | ---------------------------------------- | --------------------------------------------------------------------------- |
| ~1 settembre 2026   | Import dati in Salesforce                | Preceduto dalla bonifica: ~6.000 lead/account contro ~7.500 clienti paganti |
| 7–19 settembre 2026 | Tour (eventi gratuiti)                   | ~90% pubblico nuovo, dati digitati dal cliente                              |
| 29 settembre 2026   | Food Marketing Festival                  | Picchi di 100–150 fatture al giorno                                         |
| **6 ottobre 2026**  | **Go-live**                              | WooCommerce + Mexal operativi                                               |
| 29 ottobre 2026     | Evento di lancio, 1.500+ partecipanti    | Primo evento a pieno regime su Salesforce                                   |
| 31 ottobre 2026     | Scadenza contratto Zoho                  | Fine del dual-run                                                           |
| 3 novembre 2026 🔴  | Camerieri Venditori — o rinvio ad aprile | Data da confermare                                                          |
| 24–26 novembre 2026 | Pienissimo Live                          | Consegna biglietti a 60 giorni nell'as-is 🔴                                |

---

## 2. Perimetro

### 2.1 Incluso nel perimetro contrattuale

Tutto ciò che è descritto nei capitoli §3–§11 con priorità **M**, **S** o **C**.

### 2.2 Escluso dal perimetro contrattuale

| ID     | Elemento                                                                                              | Motivazione                                                                                                          | Stato |
| ------ | ----------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------- | :---: |
| OUT-01 | Integrazione **GLS** (conferma di consegna per il flusso libri)                                       | Non discussa in fase di prevendita, non presente a contratto                                                         |  🔴   |
| OUT-02 | Integrazione **Teachable** (API di completamento corso)                                               | Non discussa in fase di prevendita, non presente a contratto                                                         |  🔴   |
| OUT-03 | Integrazione **Salesforce ↔ Zoho** per gli ordini Pienissimo Pro della **Pienissimo Software S.r.l.** | Società giuridicamente distinta dal cliente di questo progetto; non discussa in prevendita, non presente a contratto |  🔴   |

> ⚠ **Punto da dirimere in questa sessione.** ROMI ha segnalato questi tre elementi come fuori contratto in tre status settimanali consecutivi (10, 24 e 31 luglio). Pienissimo (Sabatino, Fabrizio) ritiene che almeno il tema Zoho fosse stato discusso, e ha portato la questione a Daniela. **Finché non è chiuso, questi tre elementi non sono pianificabili e non concorrono alla data del 6 ottobre.** ROMI si è impegnata a fornire una quotazione separata qualora rientrino nel perimetro come evolutiva.

### 2.3 Rinviato alla Fase 2 (post go-live, dentro il perimetro)

| ID    | Elemento                                                                              |
| ----- | ------------------------------------------------------------------------------------- |
| F2-01 | Vendita prodotti via WooCommerce/GLS (libri, videocorsi) — flusso e-commerce completo |
| F2-02 | Flussi Pienissimo Pro                                                                 |
| F2-03 | Analytics su Data Cloud / Data 360                                                    |
| F2-04 | Automazioni residue e integrazioni minori                                             |
| F2-05 | Integrazione Meta/Google Ads per costo di acquisizione e campagna di origine          |

---

## 3. Modello dati

| ID    | Requisito                                                                                                                                                                                                                                                                                                                                                                                                                                                 | Pri. | Stato |
| ----- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :--: | :---: |
| DM-01 | **Lead** — accoglie esclusivamente azioni self-serve senza intento d'acquisto (iscrizione a dirette, download video gratuito, quiz). Gli stati iniziali del workflow (in lavorazione, non risponde, primo contatto, da ricontattare, prequalifica) vivono qui. Titolarità: marketing.                                                                                                                                                                     |  M   |  ✅   |
| DM-02 | **Account** = azienda, con campo dedicato **nome locale** accanto alla ragione sociale.                                                                                                                                                                                                                                                                                                                                                                   |  M   |  ✅   |
| DM-03 | Ogni Opportunità richiede sempre un Account. I form creano automaticamente account e contatto "primordiali"; il commerciale completa l'anagrafica dopo il primo contatto.                                                                                                                                                                                                                                                                                 |  M   |  ✅   |
| DM-04 | Regole di deduplica: **email OR telefono** per i form; **email + P.IVA** per gli ordini WooCommerce; corrispondenza P.IVA/ragione sociale in conversione lead → account.                                                                                                                                                                                                                                                                                  |  M   |  ✅   |
| DM-05 | **Opportunità** — creata direttamente, saltando il Lead, per: form di richiesta contatto esplicita (landing sponsorizzate, QR delle dirette) e per tutte le richieste da clienti già acquisiti.                                                                                                                                                                                                                                                           |  M   |  ✅   |
| DM-06 | Quattro fasi di Opportunità (negoziazione con sotto-livelli → rinviata / persa / vinta). La chiusura _vinta_ è guidata dal **pagamento**, confermato manualmente dall'amministrazione.                                                                                                                                                                                                                                                                    |  M   |  ✅   |
| DM-07 | Motivo di perdita **obbligatorio**, con **due set di picklist distinti**: uno per gli stati di Opportunità, uno per quelli di Preventivo. Il valore "errato" non deve esistere per i preventivi.                                                                                                                                                                                                                                                          |  M   |  ✅   |
| DM-08 | **Record Type** separati per il flusso commerciale e per il flusso e-commerce, a garanzia di statistiche pulite.                                                                                                                                                                                                                                                                                                                                          |  M   |  ✅   |
| DM-09 | Tracciare per ogni Opportunità l'origine **cliente esistente vs new business**.                                                                                                                                                                                                                                                                                                                                                                           |  M   |  ✅   |
| DM-10 | **Preventivo** — sempre sotto un'Opportunità; più preventivi per Opportunità ammessi. Validità 5 giorni; lo stato "scaduto" è fisiologico. Il rilancio avviene per **clonazione** del preventivo scaduto, così da conservare lo storico.                                                                                                                                                                                                                  |  M   |  ✅   |
| DM-11 | Il Preventivo è un unico PDF contenente condizioni generali e riepilogo economico.                                                                                                                                                                                                                                                                                                                                                                        |  M   |  ✅   |
| DM-12 | **Ordine** — un solo oggetto ordine. Le righe prodotto ereditano dal Preventivo il riferimento alla tranche e la data prevista di pagamento. Il pattern Zoho degli ordini figli / "blocchi" è abolito.                                                                                                                                                                                                                                                    |  M   |  ✅   |
| DM-13 | Massimo **un bundle per ordine**; mai bundle + prodotto sciolto nello stesso ordine (in tal caso si generano due ordini distinti).                                                                                                                                                                                                                                                                                                                        |  M   |  ✅   |
| DM-14 | L'ordine è **immutabile dopo la fatturazione**, con permission set ristretto (1–2 utenti amministrativi) per le correzioni.                                                                                                                                                                                                                                                                                                                               |  M   |  ✅   |
| DM-15 | Due campi distinti, non uno. **Tipo ordine** = `STANDARD` · `BUNDLE` · `PLUS`, i tre valori del disegno che guidano le automazioni. **Tipologia di vendita** = le sette voci del vostro Excel: stage sales, tutor packages, tutor combo, tutor one-shot, Performance Plus, product sales, Pienissimo Pro. ⚠ La lista di sei valori presente nella v1.0 di questo documento era un nostro errore: non compare in nessuna fonte ed è ritirata (§17, RC-04). |  M   |  🟡   |
| DM-16 | Ordini e prodotti provenienti da Mexal sono in **sola lettura** su Salesforce.                                                                                                                                                                                                                                                                                                                                                                            |  M   |  ✅   |
| DM-17 | **Tranche** (rinominazione di "rate") — oggetto custom creato nel **Preventivo**, dopo la selezione dei prodotti, tramite un'azione guidata che richiede quali righe includere e la data prevista di pagamento. Ogni riga selezionata conserva riferimento e data della tranche, poi propagati alla corrispondente riga d'Ordine.                                                                                                                         |  M   |  ✅   |
| DM-18 | **Campagna = evento**: una campagna per edizione. I membri campagna sono i partecipanti, con stato di check-in (partecipato / no-show), a supporto delle analisi di no-show e composizione aula.                                                                                                                                                                                                                                                          |  M   |  ✅   |
| DM-19 | **Contratto** (Performance Plus) — oggetto Contract standard con logica custom: date di inizio/fine/rinnovo, importo, preventivo e fatture collegate, pannello rinnovi, fatturato vs incassato, blocco servizio in caso di morosità grave.                                                                                                                                                                                                                |  S   |  ✅   |
| DM-20 | **Nota di credito** — collegata sia all'ordine sia alla **riga d'ordine**, per gestire storni parziali su bundle multi-evento.                                                                                                                                                                                                                                                                                                                            |  S   |  ✅   |
| DM-21 | **Fattura** — creata su Salesforce come contenitore di riferimento alla chiusura dell'ordine; Mexal fattura e restituisce numero e stato in campi dedicati e ricercabili.                                                                                                                                                                                                                                                                                 |  M   |  ✅   |
| DM-22 | **Biglietto** — un record dell'oggetto standard Salesforce **Asset** per ogni biglietto, con il ciclo di vita del §6. L'oggetto custom `Biglietto__c` oggi presente in UAT deve essere sostituito o migrato ad Asset senza perdere campi, relazioni o automazioni necessarie.                                                                                                                                                                             |  M   |  ✅   |

---

## 4. Flusso commerciale — dal Lead all'Ordine

| ID     | Requisito                                                                                                                                                                                                                                         | Pri. | Stato |
| ------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :--: | :---: |
| SAL-01 | Il routing dei form è deciso dalla **sorgente, non dal contenuto**: campi nascosti precompilati (fonte, categoria, sottocategoria, UTM) discriminano. Sorgente A → Lead; sorgente B → Opportunità con creazione automatica di account e contatto. |  M   |  ✅   |
| SAL-02 | I form cambiano circa ogni 15 giorni: serve un processo ripetibile di mappatura campi, gestibile autonomamente da Pienissimo. I nuovi campi devono preesistere su Salesforce.                                                                     |  M   |  ✅   |
| SAL-03 | L'interesse multi-servizio deve arrivare sull'Opportunità in forma leggibile e **rendicontabile**, con ogni valore conteggiabile singolarmente.                                                                                                   |  M   |  ✅   |
| SAL-04 | Il marketing converte i Lead in Opportunità; i tutor gestiscono il richiamo tramite task automatici e stati dedicati. I contatti qualificati bypassano le fasi iniziali.                                                                          |  M   |  ✅   |
| SAL-05 | **SLA**: una nuova Opportunità deve passare "in lavorazione" entro **48 ore lavorative**, con escalation al sales manager in caso contrario.                                                                                                      |  M   |  ✅   |
| SAL-06 | Stato **"qualificato da ricontattare"** con task/alert di parcheggio a 48 ore.                                                                                                                                                                    |  M   |  ✅   |
| SAL-07 | **Pulsante di creazione manuale** di un nuovo preventivo.                                                                                                                                                                                         |  M   |  ✅   |
| SAL-08 | La **data di scadenza del preventivo è obbligatoria** al momento dell'invio da parte del tutor.                                                                                                                                                   |  M   |  ✅   |
| SAL-09 | Alert automatici a tutor e cliente il **secondo giorno** dopo l'invio del preventivo e alla **data di scadenza**.                                                                                                                                 |  M   |  ✅   |
| SAL-10 | Lista dei tempi di validità preimpostati per categoria prodotto e linea di business. 🔴 _Input atteso da Marco Montesi._                                                                                                                          |  M   |  🔴   |
| SAL-11 | Le transizioni di stato sono **manuali al go-live**; l'automazione sarà valutata dopo.                                                                                                                                                            |  M   |  ✅   |
| SAL-12 | I tutor operano su **listino fisso**, senza sconti discrezionali salvo autorizzazione.                                                                                                                                                            |  M   |  ✅   |
| SAL-13 | Le date delle rate devono sempre garantire che il cliente risulti **completamente pagato prima di partecipare** all'evento.                                                                                                                       |  M   |  ✅   |
| SAL-14 | Dashboard attività giornaliere per tutor + dashboard trasversale per il manager. Le dashboard sono filtrate per default sull'utente.                                                                                                              |  M   |  ✅   |
| SAL-15 | Canale di notifica (campanella Salesforce vs email). 🔴 _Decisione Pienissimo._                                                                                                                                                                   |  S   |  🔴   |
| SAL-16 | Pulsanti **accetta/rifiuta dentro l'email del preventivo** che aggiornano direttamente lo stato di Preventivo/Opportunità. 🟡 _ROMI deve verificare fattibilità e rischio di modifica dati da parte di soggetti esterni._                         |  C   |  🟡   |
| SAL-17 | Procedura di accettazione ordine e gestione contratti. 🔴 _Da definire con Daniela e comunicare a ROMI entro il 6 agosto._                                                                                                                        |  M   |  🔴   |

---

## 5. Bundle e anagrafica prodotti

| ID     | Requisito                                                                                                                                                                                                                                                                                                                            | Pri. | Stato |
| ------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | :--: | :---: |
| BUN-01 | Il bundle è un **contenitore custom**, non Revenue Cloud/CPQ (non licenziato e sovradimensionato).                                                                                                                                                                                                                                   |  M   |  ✅   |
| BUN-02 | Il bundle ha un **prezzo fisso** definito in configurazione; i componenti portano **prezzi spalmati** affinché la statistica di fatturato per prodotto resti valida. **Questo è il criterio di accettazione della soluzione bundle.**                                                                                                |  M   |  ✅   |
| BUN-03 | Lo spalmato vive sul **legame bundle↔prodotto** (oggetto ponte `BundleComponent__c`), non sul prodotto: lo stesso prodotto può quindi appartenere a più bundle con spalmati diversi.                                                                                                                                                 |  M   |  ✅   |
| BUN-04 | Sono disponibili **entrambe** le modalità: prezzo bundle fisso, oppure calcolo automatico dai componenti. La scelta è per singolo bundle. Con prezzo fisso, le rate si impostano manualmente.                                                                                                                                        |  M   |  ✅   |
| BUN-05 | Si fattura **il singolo prodotto elementare** che compone il bundle, mai una cifra generica. Il nome del bundle diventa la descrizione trasmessa a Mexal; codice e data di scadenza restano a livello di riga.                                                                                                                       |  M   |  ✅   |
| BUN-06 | I bundle sono **creati solo dall'amministrazione** su Salesforce; i singoli prodotti restano configurati su Mexal.                                                                                                                                                                                                                   |  M   |  ✅   |
| BUN-07 | Un bundle non viene mai modificato dopo la vendita, né riutilizzato: si attiva e si disattiva. Sono previsti 3–5 bundle per evento, identici per tutti gli acquirenti.                                                                                                                                                               |  M   |  ✅   |
| BUN-08 | Classificazione: **anno solare** (master) → **evento** (picklist dipendente) + **tipologia bundle** (indipendente). ⚠ "Anno solare" è concetto distinto da "anno accademico" (maggio→settembre), usato per la generazione biglietti.                                                                                                 |  M   |  ✅   |
| BUN-09 | I valori delle picklist sono **ricreati puliti**, non migrati dalle colonne legacy LIVELLO_3/4. Seed eventi: Tour, Food Marketing Festival, Pienissimo Live, Academy, Sold Out, O.D.B. Live, Camerieri Venditori, Mastery. 🔴 _Lista definitiva attesa da Fabrizio._                                                                 |  M   |  🔴   |
| BUN-10 | UI: il bundle appare come **una riga d'ordine**, espandibile per mostrare i componenti.                                                                                                                                                                                                                                              |  M   |  ✅   |
| BUN-11 | Anagrafica articoli importata da Mexal. L'apparato legacy **C/Z/BLO/PACK non viene migrato**: esisteva solo per costruire bundle di rate su Mexal.                                                                                                                                                                                   |  M   |  ✅   |
| BUN-12 | Flag **"Genera biglietto" (sì/no)** sull'articolo: definisce l'insieme dei codici che generano un biglietto, modificabile dall'amministrazione senza intervento di sviluppo.                                                                                                                                                         |  M   |  ✅   |
| BUN-13 | Flag **"Solo bundle" (sì/no)** sull'articolo: marca i codici utilizzabili esclusivamente nei bundle, non selezionabili dai tutor in vendita diretta (sui bundle non maturano provvigioni agente).                                                                                                                                    |  M   |  ✅   |
| BUN-14 | I codici articolo sono **univoci e stabili** nel tempo.                                                                                                                                                                                                                                                                              |  M   |  ✅   |
| BUN-15 | Circa **10 nuovi codici articolo solo-bundle**, uno per evento, con convenzione "(B)". 🔴 _3–5 esempi attesi da Fabrizio prima di settembre._                                                                                                                                                                                        |  M   |  🔴   |
| BUN-16 | I codici "omaggio" a €0 e i blocchi BLO sono **aboliti**: si usano codici prodotto reali con sconto al 100%. ⚠ Da evidenziare in fatturazione.                                                                                                                                                                                       |  M   |  ✅   |
| BUN-17 | Una **varianza di spalmato diversa da zero deve impedire il salvataggio** del bundle. 🟡 _Oggi la varianza è solo visualizzata. Il caso si è già verificato in UAT: il bundle ACADEMY 2026 presenta una varianza di −1.422, con statistica per prodotto conseguentemente errata. ROMI raccomanda di rendere il controllo bloccante._ |  M   |  🟡   |
| BUN-18 | Controllo di coerenza sulla composizione del bundle: impedire l'associazione di articoli non coerenti con la categoria del bundle. 🟡 _Oggi il rischio è mitigato solo dall'attenzione manuale dell'amministrazione._                                                                                                                |  S   |  🟡   |
| BUN-19 | Il codice bundle viene comunicato a WooCommerce **manualmente, a voce**, per scelta, così da mantenere flessibilità a ridosso degli eventi. 🟡 _Da confermare come sostenibile ai volumi di go-live._                                                                                                                                |  S   |  🟡   |
| BUN-20 | **Prezzi di catalogo reali** per tutti i codici a listino. 🔴 _I prezzi e gli spalmati oggi presenti in UAT sono placeholder inseriti da ROMI e non hanno valore commerciale. Input atteso da Marco/Fabrizio._                                                                                                                       |  M   |  🔴   |

---

## 6. Biglietti, firma e accessi — priorità di Fase 1

### 6.1 Ciclo di vita

| Fase | Evento scatenante                                                       | Effetto                                                                                                                    |
| :--: | ----------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------- |
|  1   | **Ordine** inserito                                                     | Movimento **caricato** (parcheggiato, non utilizzabile)                                                                    |
|  2   | **Pagamento** della fattura collegata completato                        | Movimento **disponibile**                                                                                                  |
|  3   | **Firma** dei documenti (privacy, non concorrenza, consenso foto/video) | **QR generato** — il biglietto diventa utilizzabile                                                                        |
|  4   | **Check-in**: QR scansionato                                            | Movimento **scaricato**; somma algebrica per cliente = 0. I biglietti non utilizzati restano visibili come dato di no-show |

| ID     | Requisito                                                                                                                                                                                                                                                        | Pri. | Stato |
| ------ | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :--: | :---: |
| BIG-01 | Il ciclo di vita a quattro fasi sopra descritto è vincolante e va implementato così com'è.                                                                                                                                                                       |  M   |  ✅   |
| BIG-02 | Ogni ordine contenente un prodotto di tipo "evento" genera automaticamente una **Campagna** (se non esistente) e **un Biglietto per ciascun codice articolo evento** presente nell'ordine — anche in caso di bundle multi-evento o di ordini inseriti dai tutor. |  M   |  ✅   |
| BIG-03 | Distinzione terminologica vincolante: il **Biglietto è il record**; il **QR è un valore contenuto** nel record, non il record stesso.                                                                                                                            |  M   |  ✅   |
| BIG-04 | L'insieme dei codici che generano biglietto è determinato dal flag di prodotto (BUN-12), **non** dalla lettura di una lettera nel codice articolo. Lo stesso codice genera biglietto sia venduto in bundle, sia dal tutor, sia sul sito.                         |  M   |  ✅   |
| BIG-05 | I partecipanti non coincidono con i contatti dell'account: dopo il pagamento parte una mail al referente, che compila la **lista partecipanti**; i contatti vengono creati automaticamente; ciascun partecipante firma e riceve il proprio QR.                   |  M   |  ✅   |
| BIG-06 | Funnel di reminder a **60 / 30 / 15 / 1 giorni** dall'evento.                                                                                                                                                                                                    |  S   |  ✅   |
| BIG-07 | **Pulsante di fallback il giorno dell'evento**: invio immediato della mail o verifica identità allo sportello, con emissione del QR in loco. Sono accettati acquisti fino al giorno precedente.                                                                  |  M   |  ✅   |
| BIG-08 | Pagamento con carta: completamento automatico. Bonifico: conferma manuale dell'amministrazione (resta manuale al go-live).                                                                                                                                       |  M   |  ✅   |
| BIG-09 | Gli **ordini a zero euro** (biglietti gratuiti) restano nel CRM per attivare la generazione biglietti e **non** vengono trasferiti a Mexal.                                                                                                                      |  M   |  ✅   |
| BIG-10 | Le **note di credito** su ordini con prodotto di tipo "evento" portano automaticamente il Biglietto corrispondente allo stato **Annullato**. Il rimborso è di norma un credito per acquisti futuri, non un bonifico, gestito operativamente dal tutor.           |  S   |  ✅   |
| BIG-11 | Il check-in avviene per scansione del QR (oggi tramite app su telefono interno).                                                                                                                                                                                 |  M   |  ✅   |

### 6.2 Firma digitale — decisione richiesta

| ID     | Requisito                                                                                                                            | Pri. | Stato |
| ------ | ------------------------------------------------------------------------------------------------------------------------------------ | :--: | :---: |
| BIG-12 | Il rilascio del QR è **subordinato alla firma** dei documenti. Questo principio è confermato dalla direzione e non è in discussione. |  M   |  ✅   |
| BIG-13 | **Modalità di raccolta della firma.** 🔴 _Decisione attesa entro il 6 agosto._ Tre opzioni sul tavolo:                               |  M   |  🔴   |

> **Opzione A — DocuSign.** Pacchetto AppExchange, un solo utente mittente (casella del funnel owner), invii asincroni N giorni prima dell'evento, tracciamento stato envelope. Costo indicativo €1,80–2 a documento. Richiede l'acquisto delle licenze, negoziazione tuttora aperta.
>
> **Opzione B — Firma cartacea con caricamento su pagina Community** (proposta ROMI). Il cliente stampa, firma e carica scansione o fotografia su una pagina Community personalizzata. Azzera il costo per documento ma richiede **verifica umana** del contenuto caricato: non è possibile alcun controllo automatico sul PDF.
>
> **Opzione C — Processo cartaceo as-is.** PDF stampato, firmato e consegnato al check-in. Nessuno sviluppo, nessun costo, nessuna tracciabilità digitale.
>
> **Scartata:** firma "in link" con semplice click di accettazione — priva di valenza legale e non conforme al GDPR.
>
> ⚠ **Impatto tecnico:** l'incertezza riguarda **esclusivamente la fase di raccolta firma**. Le fasi a monte (creazione ordine e biglietto) e a valle (scansione QR, controllo accessi) non cambiano in nessuno dei tre scenari. In assenza di decisione entro il 6 agosto, ROMI procede con l'**Opzione C** e la firma digitale diventa un'evolutiva successiva.

| ID     | Requisito                                                                                                                                                                                             | Pri. | Stato |
| ------ | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :--: | :---: |
| BIG-14 | Deve esistere un **percorso di firma manuale** per i clienti non digitalizzati, in affiancamento alla soluzione scelta.                                                                               |  M   |  ✅   |
| BIG-15 | Firma separata di preventivo e condizioni generali/contratto: in un unico invio o in sequenza. 🔴 _Decisione interna Pienissimo._                                                                     |  S   |  🔴   |
| BIG-16 | Date evento e tempi di consegna biglietti: conferma di "Camerieri Venditori" (3 novembre o aprile) e verifica se i 60 giorni di anticipo per Pienissimo Live (24–26 novembre) siano posticipabili. 🔴 |  S   |  🔴   |

---

## 7. Ordini, tranche e ciclo amministrativo

| ID     | Requisito                                                                                                                                                                                                                                   | Pri. | Stato |
| ------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :--: | :---: |
| ORD-01 | Dopo la selezione dei prodotti nel Preventivo, l'utente crea ogni tranche tramite un'azione guidata, scegliendo le righe da includere e inserendo la data prevista di pagamento.                                                            |  M   |  ✅   |
| ORD-02 | Riferimento e data della tranche si propagano dalla riga di Preventivo alla riga d'Ordine. L'ordine passa **integralmente** a Mexal portando entrambi i valori **a livello di riga**, non come oggetto tranche.                             |  M   |  ✅   |
| ORD-03 | Mexal aggiorna lo stato di pagamento **a livello di riga d'Ordine/fattura**; Salesforce ricalcola la tranche, che risulta integralmente pagata soltanto quando tutte le righe incluse sono pagate. Mexal non crea né scrive mai la tranche. |  M   |  ✅   |
| ORD-04 | Alla fatturazione, ogni fattura generata da Mexal è riportata su Salesforce: **n fatture Mexal → n fatture Salesforce**.                                                                                                                    |  M   |  ✅   |
| ORD-05 | La **generazione automatica del contratto** è legata alla **tipologia di prodotto** presente in ordine (es. codice Performance Plus), **non** allo stato dell'ordine — stesso criterio adottato per i bundle.                               |  S   |  ✅   |
| ORD-06 | Introduzione dei **tipi ordine** (es. bundle da palco, palco/performance) per differenziare flussi di lavoro e reportistica.                                                                                                                |  S   |  ✅   |
| ORD-07 | **Report insoluti**, schedulato settimanalmente (es. lunedì) a commerciale e amministrazione — fatture emesse e non pagate con scadenza antecedente alla data di controllo. La produzione è esclusa dalla distribuzione.                    |  S   |  ✅   |
| ORD-08 | **Report tranche in scadenza**, inviato all'amministrazione prima di fine mese con le tranche in scadenza nel mese successivo.                                                                                                              |  S   |  ✅   |
| ORD-09 | Entrambi i report sono sempre disponibili e aggiornati, senza necessità di lancio manuale.                                                                                                                                                  |  S   |  ✅   |
| ORD-10 | Politica di esposizione in fattura: righe componenti vs righe rata, e mascheramento dei prezzi interni dei componenti al cliente. 🔴 _Decisione Daniela/Fabrizio con Marco._                                                                |  M   |  🔴   |
| ORD-11 | **Performance Plus** può originare sia da bundle "da palco" sia da inserimento diretto dei tutor. Entrambe le casistiche vanno supportate.                                                                                                  |  S   |  ✅   |

---

## 8. Integrazioni

| ID     | Integrazione                  | Requisito                                                                                                                                                                                                                                                                                                                                                          | Pri. | Stato |
| ------ | ----------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | :--: | :---: |
| INT-01 | **Mexal (Passepartout)**      | Integrazione via **API REST** (scelta confermata il 7 luglio in luogo dello scambio file). Otto oggetti: agenti, clienti, condizioni di pagamento, destinazioni, fatture, prodotti, ordini, scoperto clienti.                                                                                                                                                      |  M   |  ✅   |
| INT-02 | Mexal                         | **Fonte di verità**: Salesforce per le nuove creazioni, Mexal per le modifiche amministrative, con riallineamenti periodici.                                                                                                                                                                                                                                       |  M   |  ✅   |
| INT-03 | Mexal                         | I permessi di modifica sull'anagrafica cliente sincronizzata sono ristretti agli utenti amministrativi: i commerciali non devono poterla alterare dopo la sincronizzazione.                                                                                                                                                                                        |  M   |  ✅   |
| INT-04 | Mexal                         | **GET notturne schedulate**, solo delta, basate sul campo "data ultima modifica".                                                                                                                                                                                                                                                                                  |  M   |  ✅   |
| INT-05 | Mexal                         | Le fatture richiedono filtri temporali e paginazione (~2.300 fatture nel 2025), nel rispetto dei limiti Salesforce di 6 MB per chiamate sincrone e 12 MB per asincrone.                                                                                                                                                                                            |  M   |  ✅   |
| INT-06 | Mexal                         | Nessuna GET ripetuta sugli ordini (l'id è restituito in creazione); previsto invece un **pulsante "rinvio ordine"** per gestire errori o modifiche.                                                                                                                                                                                                                |  M   |  ✅   |
| INT-07 | Mexal                         | **Pulsante di importazione anagrafica prodotti su richiesta**, oltre alla sincronizzazione notturna, per garantire disponibilità immediata alla vendita.                                                                                                                                                                                                           |  M   |  ✅   |
| INT-08 | Mexal                         | Gli agenti sono gestiti come **fornitori**, filtrati per mastro; i codici iniziano con **610** per l'azienda "P". L'API agenti non è disponibile: alla nuova assunzione il codice va copiato manualmente.                                                                                                                                                          |  M   |  ✅   |
| INT-09 | Mexal                         | Campo in anagrafica che referenzi codice e P.IVA del cliente precedente, per non perdere lo storico in caso di **cambio ragione sociale**.                                                                                                                                                                                                                         |  S   |  ✅   |
| INT-10 | Mexal                         | **Non esiste un ambiente di test Mexal**: va creata un'azienda di test per validare le chiamate POST e gli ordini di prova senza impattare la contabilità reale. 🔴 _Azione Pienissimo/Kreosoft._                                                                                                                                                                  |  M   |  🔴   |
| INT-11 | **WooCommerce**               | Integrazione via **API**, non plugin. Due istanze da mappare: eventi/vendite da palco e libri/marketing. 🔴 _Consumer Key e Secret attesi da Sabatino._                                                                                                                                                                                                            |  M   |  🔴   |
| INT-12 | WooCommerce                   | **Link di checkout con tracciamento Opportunity**: Salesforce genera un URL di checkout contenente l'id dell'Opportunity; WooCommerce lo salva come metadato dell'ordine e lo espone via REST; Salesforce legge l'ordine, aggiorna i campi e porta l'Opportunity a Closed Won.                                                                                     |  M   |  ✅   |
| INT-13 | WooCommerce                   | Sviluppi necessari — lato Salesforce: campo `WooCommerce_Product_Id__c` su Prodotto, campo `WooCommerce_Order_Id__c` su Opportunità, pulsante generatore del link con selezione prodotto e quantità, logica di lettura ordini. Lato Pienissimo: installazione dello snippet PHP come _must-use plugin_, generazione credenziali REST, template email precompilato. |  M   |  ✅   |
| INT-14 | WooCommerce                   | **Direzione dell'integrazione**: job pull schedulato da Salesforce oppure webhook da WooCommerce. 🔴 _ROMI raccomanda il webhook in produzione._                                                                                                                                                                                                                   |  M   |  🔴   |
| INT-15 | WooCommerce                   | **Fonte di verità dei prezzi**: listino WooCommerce oppure prezzo negoziato Salesforce, quest'ultimo tramite coupon dinamici monouso. 🔴                                                                                                                                                                                                                           |  M   |  🔴   |
| INT-16 | WooCommerce                   | **Sicurezza dell'identificativo nel link**: id in chiaro (semplice ma indovinabile) oppure token firmato. 🔴 _ROMI raccomanda il token firmato._                                                                                                                                                                                                                   |  S   |  🔴   |
| INT-17 | WooCommerce                   | Promozioni 2×1 gestite come quantità 2 al 50%, mantenendo coerenza tra prezzo di listino, quantità e prezzo pagato.                                                                                                                                                                                                                                                |  S   |  ✅   |
| INT-18 | **Anticipay** (ex CreditSafe) | Verifica P.IVA con precompilazione di anagrafica e legale rappresentante; alert su P.IVA non valida. Deve scattare per **tutti i nuovi account**, non solo in fase di ordine. 🔴 _Timing da decidere: contestuale a Mexal (richiesta Pienissimo) o Fase 2 (proposta ROMI). Da verificare la gestione delle P.IVA estere._                                          |  M   |  🔴   |
| INT-19 | **Firma digitale**            | Vedi BIG-13.                                                                                                                                                                                                                                                                                                                                                       |  M   |  🔴   |
| INT-20 | **Gmail / Outlook**           | Connettori nativi per sincronizzazione mail e calendario. Urgente: i tutor lavorano oggi con agende cartacee.                                                                                                                                                                                                                                                      |  M   |  ✅   |
| INT-21 | **3CX**                       | Registrazione chiamate → CRM → insight di coaching tramite AI interna. 🔴 _Lo stato del setup commerciale 3CX non è mai stato comunicato dal kickoff del 27 maggio._                                                                                                                                                                                               |  C   |  🔴   |

---

## 9. Dati, analytics e reportistica

| ID     | Requisito                                                                                                                                                                                                                                                                                                                | Pri. | Stato |
| ------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | :--: | :---: |
| DAT-01 | **Catena di tracciabilità bidirezionale**: fattura ↔ ordine ↔ preventivo ↔ opportunità ↔ campagna ↔ lead, con id a cascata. **Criterio di accettazione del progetto.**                                                                                                                                                   |  M   |  ✅   |
| DAT-02 | **Matrice RFM** ricostruita nativamente su Salesforce: base **data ordine** (non data fattura, che l'annualità falserebbe), segmentata per linea di prodotto (corsi / piattaforma / Performance Plus), esposta sulla pagina account con costo di acquisizione e campagna di origine. Sostituisce l'attuale SQL su Mexal. |  S   |  ✅   |
| DAT-03 | **Analisi no-show**: tag della fonte di acquisizione per cliente, propensione al no-show per fonte, dashboard di composizione aula, alimentate dagli stati di check-in delle campagne.                                                                                                                                   |  S   |  ✅   |
| DAT-04 | Report esportabili in Excel e schedulabili via email.                                                                                                                                                                                                                                                                    |  M   |  ✅   |
| DAT-05 | Report mensile "cosa fatturare" e proiezione di fatturato di fine anno per la direzione (target €4–5M).                                                                                                                                                                                                                  |  S   |  ✅   |
| DAT-06 | **Bonifica dati** prima dell'import di ~1 settembre: deduplica di ~6.000 lead/account contro ~7.500 clienti paganti. 🔴 _Azione Fabrizio ed Elisa._                                                                                                                                                                      |  M   |  🔴   |
| DAT-07 | **Workbook del data model**: ROMI fornisce la struttura, Pienissimo compila i campi presenti oggi su Zoho per Account, Referente, Opportunity, Offerta, Ordine, Articoli, eliminando i campi inutilizzati. 🔴 _Consegna attesa da Sabatino._                                                                             |  M   |  🔴   |
| DAT-08 | Percorso di ingestion **Data 360**: Mexal → Google Cloud Storage → ingestion → trasformazione → report e dashboard standard su oggetti Data 360, in sostituzione della catena Zoho (FTP → Data Prep → data warehouse → Zoho Analytics).                                                                                  |  F2  |  🟡   |
| DAT-09 | Fino all'import di settembre, l'analitica interinale resta su strumenti esterni (Power BI o equivalenti).                                                                                                                                                                                                                |  S   |  ✅   |

---

## 10. Marketing

| ID     | Requisito                                                                                                                                                                                                                                                                     | Pri. | Stato |
| ------ | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :--: | :---: |
| MKT-01 | **Inventario dei form** con separazione lead vs opportunità e campi nascosti di sorgente (fonte, categoria, UTM) che governano il routing. 🔴 _Pienissimo ha condiviso un elenco di oltre 100 form: si attende la review interna che stabilisca quali portare su Salesforce._ |  M   |  🔴   |
| MKT-02 | **Doppio opt-in** sui form: conferma dei campi chiave prima della thank-you page, per ridurre alla fonte P.IVA e anagrafiche non valide.                                                                                                                                      |  S   |  ✅   |
| MKT-03 | Sottodominio dedicato e informazioni di configurazione.                                                                                                                                                                                                                       |  M   |  ✅   |

---

## 11. Requisiti non funzionali

| ID     | Requisito                                                                                                                                                                                                                                                                                                                                                                | Pri. | Stato |
| ------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | :--: | :---: |
| NFR-01 | **Modello di visibilità** derivato dall'organigramma, con criterio **restringi-poi-allarga**, mai il contrario. Circa 6 commerciali.                                                                                                                                                                                                                                     |  M   |  ✅   |
| NFR-02 | Riassegnazione dei clienti dormienti: manuale al go-live; le regole automatiche richiedono che Pienissimo definisca soglie e politica. 🔴                                                                                                                                                                                                                                |  S   |  🔴   |
| NFR-03 | **Storage documentale**: l'org dispone di 35,2 GB. PDF firmati e QR si accumulano: è necessaria una strategia di purge (es. 30 giorni dopo l'evento, previo backup sul cloud del cliente) oppure il collegamento a SharePoint/Drive. 🔴 _Decisione rinviata._                                                                                                            |  M   |  🔴   |
| NFR-04 | **Generazione PDF**: lato front-end completamente personalizzabile nello stile; lato server con limitazioni. Pattern adottato: generazione su azione utente o flag di stato, invio successivo del PDF memorizzato.                                                                                                                                                       |  M   |  ✅   |
| NFR-05 | Almeno **quattro template documentali**: ordine/contratto con condizioni generali (inviato solo per pacchetti rilevanti, indicativamente ≥ €10k), accettazione condizioni di partecipazione all'evento, **mandato RID** (circa il 50% dei pagamenti; template dinamico con dati bancari compilati dal cliente, richiede il codice cliente Mexal), stampa del preventivo. |  M   |  ✅   |
| NFR-06 | **Copertura del codice Apex ≥ 75%** come precondizione al rilascio in produzione. ⚠ _Verifica del 3 agosto 2026: la copertura org-wide è all'1% e la suite di test dei bundle fallisce 9 test su 10 per una modifica di schema. È una precondizione tecnica al go-live, in carico a ROMI._                                                                               |  M   |  🔴   |
| NFR-07 | Le etichette, gli stati e i testi di supporto sono tradotti in italiano.                                                                                                                                                                                                                                                                                                 |  M   |  ✅   |
| NFR-08 | Deve esistere un **ambiente di test** utilizzabile dai key user per la validazione prima del rilascio.                                                                                                                                                                                                                                                                   |  M   |  ✅   |

---

## 12. Punti da chiudere per il congelamento dei requisiti

Questi punti impediscono la firma. Sono ordinati per urgenza.

### 12.1 Da chiudere entro il 6 agosto 2026

|  #  | Punto                                                              | Rif.         | Owner                                      |
| :-: | ------------------------------------------------------------------ | ------------ | ------------------------------------------ |
|  1  | **Modalità di raccolta della firma** — Opzione A, B o C            | BIG-13       | Sabatino, con Daniela                      |
|  2  | **Procedura di accettazione ordine e contratti**                   | SAL-17       | Marco Montesi, Elisa Migliano, con Daniela |
|  3  | **Perimetro fuori contratto**: GLS, Teachable, Zoho Pienissimo Pro | OUT-01/02/03 | Daniela                                    |

### 12.2 Input attesi da Pienissimo

|  #  | Input                                                                                                | Rif.   | Owner                 |
| :-: | ---------------------------------------------------------------------------------------------------- | ------ | --------------------- |
|  4  | **Prezzi di catalogo reali** per i codici a listino                                                  | BUN-20 | Marco, Fabrizio       |
|  5  | **Lista definitiva dei 7 eventi** per le picklist di classificazione                                 | BUN-09 | Fabrizio              |
|  6  | **3–5 codici articolo solo-bundle** di esempio, entro fine agosto                                    | BUN-15 | Fabrizio              |
|  7  | **Workbook del data model** con i campi Zoho                                                         | DAT-07 | Sabatino              |
|  8  | **Review dell'elenco dei 100+ form**                                                                 | MKT-01 | Pienissimo marketing  |
|  9  | **Consumer Key e Secret WooCommerce** per entrambe le istanze                                        | INT-11 | Sabatino              |
| 10  | **Tempi di validità dei preventivi** per categoria e linea di business                               | SAL-10 | Marco Montesi         |
| 11  | **Azienda di test su Mexal**                                                                         | INT-10 | Pienissimo / Kreosoft |
| 12  | **Lista key user** business e tecnici per area — richiesta dal kickoff del 27 maggio, mai consegnata | —      | Sabatino              |
| 13  | **Stato del setup 3CX** — mai comunicato dal kickoff                                                 | INT-21 | Sabatino              |
| 14  | **Template preventivo e mail cliente reali** per tipologia                                           | NFR-05 | Marco                 |

### 12.3 Decisioni tecniche da concordare

|  #  | Decisione                                         | Rif.   | Raccomandazione ROMI                             |
| :-: | ------------------------------------------------- | ------ | ------------------------------------------------ |
| 15  | Direzione integrazione WooCommerce                | INT-14 | Webhook                                          |
| 16  | Fonte di verità dei prezzi WooCommerce            | INT-15 | Prezzo negoziato Salesforce con coupon dinamici  |
| 17  | Sicurezza dell'id nel link di checkout            | INT-16 | Token firmato                                    |
| 18  | Varianza spalmato bloccante                       | BUN-17 | Sì, bloccante                                    |
| 19  | Timing di Anticipay                               | INT-18 | Fase 2                                           |
| 20  | Strategia di storage documentale                  | NFR-03 | Purge a 30 giorni post-evento con backup cliente |
| 21  | Esposizione dei prezzi componenti in fattura      | ORD-10 | Righe rata, componenti mascherati                |
| 22  | Oggetto biglietto: custom vs Asset standard       | DM-22  | ✅ Asset standard deciso il 24 agosto            |
| 23  | Canale di notifica                                | SAL-15 | Campanella Salesforce                            |
| 24  | Firma preventivo e contratto: unica o sequenziale | BIG-15 | Unico invio                                      |

---

## 13. Criteri di accettazione

Il progetto si considera conforme ai requisiti quando tutte le condizioni seguenti sono verificate in ambiente di test dai key user di Pienissimo.

|   #   | Criterio                                                                                                                                                                                                                                                                     | Rif.           |
| :---: | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------- |
| AC-01 | Da un lead generato da form si arriva a un ordine fatturato senza interventi manuali non previsti, con la catena di tracciabilità integra in entrambe le direzioni.                                                                                                          | DAT-01         |
| AC-02 | Un bundle venduto produce righe d'ordine per **prodotto elementare**, con la somma degli spalmati esattamente pari al prezzo di vendita del bundle.                                                                                                                          | BUN-02, BUN-05 |
| AC-03 | Lo stesso prodotto inserito in due bundle diversi con spalmati diversi produce statistiche di fatturato corrette per entrambi.                                                                                                                                               | BUN-03         |
| AC-04 | Un ordine con prodotto evento genera automaticamente campagna e biglietti, uno per codice articolo evento, anche in presenza di bundle multi-evento.                                                                                                                         | BIG-02         |
| AC-05 | Il QR viene emesso **solo** dopo la firma, e la scansione al check-in scarica il movimento portando la somma algebrica del cliente a zero.                                                                                                                                   | BIG-01, BIG-12 |
| AC-06 | Su un Preventivo con più prodotti, l'utente crea le tranche selezionando righe e scadenze; l'accettazione conserva le assegnazioni sulle righe d'Ordine; Mexal restituisce il pagamento per riga e la tranche risulta pagata soltanto quando tutte le sue righe sono pagate. | ORD-01, ORD-03 |
| AC-07 | Una nota di credito su ordine evento porta il biglietto ad Annullato.                                                                                                                                                                                                        | BIG-10         |
| AC-08 | Un link di checkout generato da un'Opportunità produce, ad acquisto completato, l'aggiornamento automatico della stessa Opportunità a Closed Won.                                                                                                                            | INT-12         |
| AC-09 | I due report schedulati (insoluti, tranche in scadenza) arrivano ai destinatari previsti senza lancio manuale.                                                                                                                                                               | ORD-07, ORD-08 |
| AC-10 | La copertura del codice Apex è pari o superiore al 75% e la suite di test è interamente verde.                                                                                                                                                                               | NFR-06         |

---

## 14. Gestione delle modifiche

1. Ogni richiesta di modifica successiva alla firma è formalizzata per iscritto a ROMI.
2. ROMI risponde con una valutazione di impatto su **perimetro, tempi e costi** entro cinque giorni lavorativi.
3. La modifica entra in lavorazione **solo dopo approvazione scritta** di Pienissimo.
4. Le richieste che mettono a rischio la data del 6 ottobre 2026 sono automaticamente candidate alla Fase 2, salvo diverso accordo esplicito sulla data di go-live.
5. Gli elementi elencati al §2.2 restano fuori perimetro fino a quotazione e accettazione separata.

---

## 15. Approvazione

Con la sottoscrizione, le parti confermano che i requisiti contrassegnati come ✅ sono completi, corretti e vincolanti, e che i punti del §12 sono stati chiusi o esplicitamente rinviati con owner e data.

| Ruolo                             | Nome               | Data | Firma |
| --------------------------------- | ------------------ | ---- | ----- |
| Direzione Pienissimo              | Daniela            |      |       |
| Referente di progetto Pienissimo  | Sabatino Rinaldi   |      |       |
| Amministrazione Pienissimo        | Elisa Migliano     |      |       |
| Area commerciale Pienissimo       | Marco Montesi      |      |       |
| Anagrafiche e prodotti Pienissimo | Fabrizio Paganelli |      |       |
| Project Manager ROMI              | Elena Spini        |      |       |
| Referente tecnico ROMI            | Aurel Mrruku       |      |       |

---

## 16. Quello che era scritto solo nei disegni

I due file draw.io contengono decisioni che non sono mai state messe a verbale. Da qui in poi fanno parte del perimetro come tutto il resto.

### 16.1 Come si muove un record

Un record entra come **Lead**, diventa **Opportunità**, porta un **Preventivo**, si trasforma in **Ordine** con le sue tranche ed emette un **Biglietto**.

| Oggetto     | Stati, nell'ordine in cui si attraversano                                                                                                                                  |
| ----------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Lead        | New → In Lavorazione → Primo contatto → Qualificato · oppure Non Risponde (task automatico con promemoria a 48h, poi si torna in lavorazione) · oppure Non qualificato     |
| Opportunità | Qualificato → In trattativa (preventivo inviato) → Chiusa/Vinta · con Da ricontattare come parcheggio e Chiusa/Persa come uscita                                           |
| Preventivo  | Bozza → In trattativa (validità 5 giorni) → **In attesa di accettazione** → Accettato (copia contabile ricevuta) · oppure Rifiutata                                        |
| Ordine      | CREATO → CHIUSO/ACQUISITO                                                                                                                                                  |
| Tranche     | Creata nel Preventivo → integralmente pagata quando tutte le righe incluse sono pagate. ⚠ Valore API finale aperto: `Pagata`/`Incassata` oppure legacy `CHIUSO/ACQUISITO`. |
| Biglietto   | Ordinato → Disponibile → Assegnato → Utilizzato · oppure Non utilizzato · oppure Annullato                                                                                 |

⚠ **«In attesa di accettazione» è il nuovo nome di «preventivo scaduto».** In stanza si continuerà a dire "scaduto" per mesi: è la stessa cosa.

⚠ **L'ordine dei valori nella picklist del biglietto su Salesforce non è l'ordine del flusso.** Nella picklist compaiono come Ordinato, Assegnato, Disponibile, Non utilizzato, Utilizzato, Annullato; il flusso reale è quello della tabella sopra.

**Passaggi che fa una persona, non il sistema.** Vanno letti come carico di lavoro ricorrente, perché firmandoli si accettano: l'amministrazione conferma l'incasso del bonifico su WooCommerce; l'amministrazione porta l'ordine a CHIUSO/ACQUISITO entro massimo 5 giorni; il tutor imposta Accettato o Rifiutata sul preventivo; il tutor riporta in trattativa un preventivo scaduto; lo staff scansiona il QR all'evento.

### 16.2 Parole che significano cose diverse su oggetti diversi

| Parola                 | Vive su                       | Attenzione                                                                                                                                                                                  |
| ---------------------- | ----------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **In trattativa**      | Opportunità, Preventivo       | Sull'opportunità è la trattativa in corso; sul preventivo è quel preventivo dentro i suoi 5 giorni                                                                                          |
| **Da ricontattare**    | Lead, Opportunità, Preventivo | Sul Lead è un task; sugli altri due è uno stato, ognuno con la sua picklist di motivazioni                                                                                                  |
| **CHIUSO / ACQUISITO** | Ordine, Tranche               | Valore legacy del diagramma. La decisione del 24 agosto sostituisce il trigger della tranche con l'aggregazione di tutte le righe pagate; resta aperto se questo sarà il valore API finale. |

Quando una di queste parole viene detta a voce, va detto anche di quale oggetto si sta parlando.

### 16.3 Valori delle picklist

**Lead · Motivazione uscita — PERSO** (il lead era giusto ma non si è chiuso): Non interessato · Prezzo alto · Sceglie concorrenza · Servizio non adatto

**Lead · Motivazione uscita — ERRATO** (non doveva proprio entrare; sotto-categoria dedicata, esportabile per analizzare la qualità delle sorgenti): Ha già P.Pro · Già in contatto · Dati inesatti · Duplicato da CRM · Non in target · Richiesta per errore · SW House, Ag. Marketing, Web Agency · Test

**Opportunità · Chiusa persa:** Prezzo alto · Sceglie concorrenza · Tempistiche di erogazione · Non allineato alle aspettative

**Opportunità · Da ricontattare:** Data corso incompatibile · Locale ancora da aprire · Non risponde · Rimanda per prezzo · Rimanda per motivi personali · Rimanda per problemi con attività · Richiamare dopo la stagione

**Preventivo · Da ricontattare:** Richiamare dopo la stagione · Ha da fare · Deve pensarci

**Tipo ordine:** STANDARD · BUNDLE · PLUS · **Tipo opportunità:** Vendita da tutor · Recall tutor

### 16.4 I diciassette requisiti da ratificare

Esistono solo nei disegni e non sono mai stati discussi in riunione. Con la firma diventano vincolanti.

| ID     | Requisito                                                                                                                                                                                                                              | Pri. |
| ------ | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :--: |
| SAL-19 | Un preventivo scaduto deve poter tornare in trattativa in autonomia dal tutor.                                                                                                                                                         |  S   |
| SAL-20 | Due task «da ricontattare» da aggiungere: dopo il primo contatto e dopo l'appuntamento, con data impostabile.                                                                                                                          |  S   |
| SAL-21 | Campo tipo opportunità con i valori «Vendita da tutor» e «Recall tutor».                                                                                                                                                               |  S   |
| SAL-22 | Un campo INFO che spiega come usare le motivazioni di uscita.                                                                                                                                                                          |  C   |
| SAL-23 | Attivare la funzione standard che porta l'opportunità in «preventivo inviato» automaticamente.                                                                                                                                         |  S   |
| ORD-06 | Tipi ordine STANDARD, BUNDLE, PLUS.                                                                                                                                                                                                    |  S   |
| ORD-07 | Report insoluti ogni lunedì a Marco e all'amministrazione.                                                                                                                                                                             |  S   |
| ORD-12 | Un ordine WooCommerce resta invisibile su Salesforce finché non è COMPLETATO; per i bonifici lo cambia a mano l'amministrazione.                                                                                                       |  M   |
| ORD-13 | ⚠ Regola legacy del diagramma: all'acconto la prima tranche va a `CHIUSO/ACQUISITO`. La decisione di Aurel del 24 agosto sostituisce il trigger con l'aggregazione di tutte le righe incluse; resta aperto il nome dello stato finale. |  M   |
| ORD-14 | CHIUSO/ACQUISITO lo imposta l'amministrazione a mano entro massimo 5 giorni dalla conferma di pagamento.                                                                                                                               |  M   |
| ORD-15 | Bottone «Crea Nota di Credito» sull'ordine, con pop-up per scegliere le righe.                                                                                                                                                         |  S   |
| INT-22 | Gli insoluti arrivano dall'API Mexal «scoperto clienti».                                                                                                                                                                               |  S   |
| BIG-17 | Picklist stato biglietto a sei valori.                                                                                                                                                                                                 |  M   |
| BIG-18 | Landing partecipanti raggiunta da un link che porta l'Account ID; con più eventi si sceglie prima l'evento.                                                                                                                            |  M   |
| BIG-19 | Alla conferma della lista un flow crea o abbina i contatti, aggiunge i campaign member e invia la richiesta di firma.                                                                                                                  |  M   |
| BIG-20 | Il QR contiene l'ID del campaign member.                                                                                                                                                                                               |  M   |
| BIG-21 | Bottone «Casi Limite» sul biglietto, visibile solo da Assegnato, per cambio nome e mancata firma.                                                                                                                                      |  S   |

---

## 17. Dove le fonti non concordano

Otto punti, e non sono dello stesso tipo. L'etichetta lo dice, perché trattarli tutti allo stesso modo sarebbe fuorviante al momento della firma.

⚠ **RC-06, RC-07 e RC-08 sono nuovi in questa revisione e hanno un'unica causa.** Entrambi i file di design sono stati modificati il **20 agosto 2026**, a 68 minuti di distanza, e **nessuna delle due modifiche è verbalizzata** — nessuna riunione, nessun appunto, nessun messaggio. In ciascun caso il disegno dice ora qualcosa che questo documento non dice. **Nulla di quanto segue è stato modificato sulla base di un disegno**: sono elencati perché possiate deciderli.

### RC-01 · Risolto il 24 agosto — l'oggetto biglietto

L'org UAT contiene già un oggetto custom `Biglietto__c` con sei classi Apex per DocuSign e la generazione dei PDF. Il disegno prevede invece l'oggetto Asset standard di Salesforce.

**Decisione:** usare l'oggetto standard Salesforce Asset. L'istruzione diretta non indica chi ha preso la decisione. `Biglietto__c` è ora un gap di implementazione, non una scelta da ratificare: campi, relazioni e sei classi Apex devono essere mappati e poi migrati, riscritti o dismessi. **L'effort non è ancora stimato.**

### RC-02 · Da chiarire — cosa fa nascere campagna e biglietti

Il disegno dice che la campagna nasce quando su Mexal viene creato il prodotto EVENTO; il verbale del 22/07 dice che nasce all'arrivo di un ordine con prodotto evento. Separate, le due cose non sono in conflitto: **campagna alla creazione del prodotto, biglietti all'ordine**. Oggi i documenti descrivono automazioni diverse solo perché nessuno dei due dice di quale oggetto parla.
**Se non si decide:** resta ambiguo, chi costruisce ne sceglie una e l'altro documento resta sbagliato.

### RC-03 · Mai deciso — quanti promemoria, e su quale canale

⚠ **Errore nostro, ritirato.** Avevamo presentato questo punto come una contraddizione fra «60 e 2 giorni» e «60, 30, 15 e 1». Non lo è.

Il verbale dell'08/06, riga 17, dice testualmente: _«Reminder funnel for uncompiled tickets (they already run a WhatsApp/60-30-15-1-day funnel)»_. È la descrizione di una **vostra pratica WhatsApp già esistente**, fra parentesi — non un requisito per Salesforce. Una cadenza per Salesforce non è mai stata concordata, quindi non c'è nulla che si contraddica.

La domanda vera non è mai stata posta: Salesforce replica via email la vostra cadenza a quattro tocchi, oppure ne fa due (60 e 2) come disegnato? Quattro invii costano più build e rischiano lo spam; due rischiano più no-show.
**Proposta:** nessuna finché non ci dite il canale. **Se non si decide:** 60 e 2, perché è quello che è disegnato.

### RC-04 · Correzione nostra — i tipi di ordine

Il verbale del 30/06, riga 7, riporta dal vostro Excel e PDF **sette** tipologie: _stage sales, tutor packages, tutor combo, tutor one-shot, Performance Plus, product sales, Pienissimo Pro_. Il disegno prevede **tre** tipi ordine: STANDARD, BUNDLE, PLUS.

⚠ Le sei voci elencate nella v1.0 di questo documento (vendita da palco, tutor, libro, videocorso, attivazione PP, rinnovo PP) **non compaiono in nessuna fonte**: le avevamo scritte noi e sono ritirate.

Si stanno confondendo due campi: i tre valori guidano le automazioni, i vostri sette descrivono cosa si vende. Possono esistere entrambi.
**Proposta:** tipo ordine = i tre; tipologia di vendita = i vostri sette, invariati. **Se non si decide:** restano solo i tre e Marco perde la ripartizione che ci ha fornito.

### RC-05 · Passo indietro nostro — la nota di credito

Il 22/07 era stato **concordato** che una nota di credito su prodotto evento portasse automaticamente il biglietto ad Annullato. Risulta come decisione presa, non come punto aperto.

ROMI chiede ora di tornare indietro e selezionare i biglietti **a mano** in un pop-up, perché su un bundle multi-evento uno storno parziale non è deducibile: il sistema non sa a quale biglietto si riferisce la nota.

Questo è il fornitore che chiede di disfare una cosa già approvata, per un motivo tecnico. Non è un pareggio fra due fonti e non va registrato come tale.
**Se non si decide:** vale la decisione del 22/07 — annullamento automatico, e il caso del bundle multi-evento resta irrisolto.

### RC-06 · Da decidere — `Rinuncia` è un settimo stato del biglietto?

Questo documento e il registro dei requisiti prevedono **sei** stati dell'asset: `Ordinato`, `Disponibile`, `Assegnato`, `Utilizzato`, `Non utilizzato`, `Annullato`. Dal 19 agosto i file di design disegnano un **settimo** riquadro, **`Rinuncia`**, con l'annotazione _"avviene nella comunicazione dei partecipanti o accetta o rinuncia"_ — il referente che rinuncia nel momento in cui gli viene chiesta la lista partecipanti. I trigger registrati di `Annullato` sono invece il cambio nome o la nota di credito, entrambi momenti successivi.

Letti alla lettera sono due eventi diversi. Ma il verbale del 6 agosto tratta _rinuncia_ come dicitura generica per `Annullato`, e da allora non è stato verbalizzato nulla.
**Proposta:** una frase di Elena Spini o Sabatino Rinaldi chiude il punto. **Se non si decide:** si realizzano i sei stati previsti qui e `Rinuncia` non viene configurato.

### RC-07 · Da chiarire — `Incassato` e `CHIUSO/ACQUISITO`

La sessione del 6 agosto ha sostituito gli stati dell'ordine con **`Ordinato → Fatturato → Incassato`**, eliminando _Chiuso acquisito_. Il file di design si è ora allineato e disegna questi tre — **ma non ha rimosso i valori precedenti**: `CHIUSO/ACQUISITO` e `CREATO` sono ancora nella pagina degli ordini, e la regola delle tranche manda tuttora la prima tranche in `CHIUSO/ACQUISITO`.

La fonte porta quindi entrambi i vocabolari insieme. **Nessuno ha detto se `Incassato` sia `CHIUSO/ACQUISITO` rinominato oppure una milestone diversa.** La decisione di Aurel del 24 agosto definisce la creazione della tranche e l'aggregazione dei pagamenti, quindi questi meccanismi possono procedere; soltanto il nome dello stato finale della tranche dipende ancora dalla risposta.
**Proposta:** confermare che sono la stessa milestone con un nuovo nome, oppure indicare quale sia la seconda. **Se non si decide:** si possono costruire creazione e roll-up, ma non configurare in sicurezza i valori finali di stato di Ordine e Tranche.

### RC-08 · Segnalazione nostra — una tipologia di biglietto ha cambiato nome in un disegno

Il verbale del 6 agosto riporta come codici prodotto di esempio **_Camerieri Venditori Gold_** e **_Camerieri Venditori Silver_**. Il 20 agosto il file di design ha cambiato `Silver` in **`Dinamond`** — con ogni probabilità _Diamond_, scritto male.

È la modifica di una parola in un disegno contro un termine messo a verbale in riunione, e tocca l'elenco delle tipologie biglietto che è ancora atteso insieme all'anagrafica prodotto.
**Proposta:** inviare l'elenco delle tipologie insieme ai campi dell'anagrafica prodotto; lo prenderemo da lì e non dal disegno. **Se non si decide:** non realizziamo nulla, perché un elenco dedotto da stringhe di esempio sarebbe una supposizione.

### Nota sulle fonti

Le citazioni non hanno tutte lo stesso peso e va detto: i verbali di 08/06, 30/06 e 23/07 sono agli atti in `meetings/results/`; il **22/07 è una minuta circolata via mail e non presente nel repository**, e su di essa poggiano RC-02 e RC-05; le riunioni del 29/07 e 31/07 hanno **solo note automatiche**, nessun verbale scritto da una persona.

---

### Appendice A — Fonti

Riunioni tracciate: 27/05 (kickoff), 03/06 (demo sales), 04/06 (demo marketing), 08/06 (ticketing e compliance), 16/06 (tech sales), 23/06 (marketing), 30/06 (tipologie vendita e preventivi), 02/07 (fatturazione Mexal), 07/07 (lead/opty e integrazioni), 14/07 (integrazione Mexal), 16/07 (demo bundle e flusso ordini), 22/07 (bundle e flusso biglietti), 23/07 (codici prodotto e bundle), 29/07 (follow-up temi aperti), 31/07 (business review).

Documenti: `Integrazione_Salesforce_WooCommerce.docx` (31/07), `anar_PIE_ricla.xlsx` (anagrafica articoli, 22/07), `Campi Oggetti, Flussi e Utenti Salesforce - Pienissimo.xlsx`, credenziali WEBAPI Passepartout (15/07).

Decisione diretta: Aurel Mrruku, 24/08, creazione tranche nel Preventivo, propagazione alle righe d'Ordine e aggregazione dei pagamenti.

Verifica tecnica sull'org Pienissimo UAT eseguita il 3 agosto 2026.

Tracciabilità completa in `meetings/DEVELOPMENT-RECAP.it.md` e `meetings/open-items.it.md`.
