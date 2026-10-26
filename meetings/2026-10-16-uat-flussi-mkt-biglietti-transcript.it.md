# **ð Note**  

 ott 16, 2026

## **\[ROMI-PIENISSIMO\] - UAT: Flussi MKT Biglietti**

invitato <fabrizio.p@pienissimo.com> <amministrazione@pienissimo.com> [Elena Spini](mailto:e.spini@romicompany.com) <sabatino.r@pienissimo.com> [Fabrizio Mastracci](mailto:f.mastracci@romicompany.com) [Aurel mrruku](mailto:a.mrruku@romicompany.com) <rebecca.m@pienissimo.com> <marco.m@pienissimo.com> <matteo.d@pienissimo.com>

Allegati [\[ROMI-PIENISSIMO\] - UAT: Flussi MKT Biglietti](https://calendar.google.com/calendar/event?eid=NTZ0aGVuOWUxdmY4c2FvN24xMW50bGtwcmYgZS5zcGluaUByb21pY29tcGFueS5jb20)

Record delle riunioni [Trascrizione](https://docs.google.com/document/d/1dsJn_rErSHqP6XaiZeHTR60sOCQ5Emy-656-wMRbMBU/edit?usp=drive_web&tab=t.tqtke3bupb8u) [Registrazione](https://drive.google.com/file/d/1U4us6Cf2kls0flyEYcbIEIInbVmT7ZKb/view?usp=drive_web) 

  
  

### **Riepilogo**

Verifica di Marketing Cloud con flussi biglietti e integrazioni CRM.  
  
**Test flussi Marketing Cloud**  
Testati invii email e flussi di generazione biglietti con codici QR. Valutate criticità sui pulsanti di rinuncia.  
  
**Configurazione invii e CRM**  
Definita la gestione dinamica degli intervalli di attesa per le campagne. Esclusi gli eventi streaming dalla generazione dei biglietti.  
  
**Pianificazione e scadenze**  
Aggiornato il piano di progetto con revisioni subordinate agli esiti delle riunioni operative interne.

  
  

### **Decisioni**

## **Da approfondire**

  - **Configurazione degli intervalli di attesa dinamici** La definizione di un sistema basato su campi multipli di attesa nell'edizione della campagna per gestire i flussi è stata rinviata in attesa di una decisione definitiva del team interno nel pomeriggio.
  - **Gestione di template separati per eventi particolari** L'adozione di template e flussi dedicati per eventi speciali con logiche di comunicazione personalizzate è subordinata alla valutazione interna del team programmata per il pomeriggio.

  

## **Concordato**

  - **Inserimento dei pulsanti di accettazione e rifiuto nell'email** È stato concordato di includere sia il pulsante di accettazione che quello di rifiuto nell'email di invito, rimandando entrambi alla medesima pagina di atterraggio.
  - **Implementazione di un pop-up di conferma per la rinuncia** È stato deciso di aggiungere un pop-up di doppia verifica per la rinuncia all'evento sulla pagina dedicata per evitare clic accidentali da parte degli utenti.
  - **Esclusione della generazione biglietti per eventi streaming** Gli eventi in streaming come ODB Live saranno configurati nel CRM come codici articolo che non generano biglietti, abilitando una gestione tramite journey di marketing flessibile.
  - **Configurazione ODB streaming senza generazione biglietti** L'ODB streaming viene configurato come codice articolo senza generare il biglietto.
  - **Utilizzo di Zoom per il tracciamento** Viene utilizzata la piattaforma Zoom per tracciare gli utenti aventi diritto e le effettive partecipazioni.

  
  

### **Passaggi successivi**

  - \[Matteo Distaso, Fabrizio Mastracci\] Configura WhatsApp: Configurare l'integrazione del canale WhatsApp nei flussi di automazione degli eventi.
  - \[Matteo Distaso, Rebecca Marmo\] Revisiona mail invito: Revisionare la mail di invito per includere i tasti di accettazione e rifiuto della partecipazione.
  - \[Fabrizio Mastracci\] Verifica contatto: Verificare la causa della mancata sincronizzazione del numero di telefono nel CRM per il contatto segnalato.
  - \[Aurel mrruku\] Aggiornare pagina rinuncia: Aggiungere un pop-up di conferma double check per la rinuncia all'evento e ingrandire il relativo tasto.
  - \[Aurel mrruku, Fabrizio Mastracci\] Configurare attesa invii: Implementare 11 campi di configurazione per i giorni di attesa nella campagna, con la logica che campi vuoti interrompano l'invio delle mail successive.
  - \[Elisa Migliano, Rebecca Marmo\] Comunicare configurazione pesi: Definire e comunicare le decisioni prese durante la riunione interna riguardo ai tempi di attesa tra i reminder per le edizioni.
  - \[Fabrizio Mastracci\] Creare template evento: Configurare un template flessibile puntato alla campagna specifica dell'evento Food Marketing Festival. Consentire la modifica manuale dei tempi di attesa e delle email per gestire le esigenze particolari.
  - \[Fabrizio Mastracci\] Aggiornare anagrafica articoli: Modificare il codice articolo relativo a ODB Live Streaming nel sistema per impostarlo come non generatore di biglietti. Assicurare che il flusso non preveda la creazione di QR code o scarico di ticket.

  
  

### **Dettagli**

**Introduzione ai test sul giro dei biglietti e Marketing Cloud**: Elena Spini apre l'incontro focalizzandosi sullo stato di implementazione del giro dei biglietti e di Marketing Cloud, spiegando che attualmente le funzionalità sono testabili solo in produzione e che vengono effettuati test iniziali con dati fittizi prima di passare a simulazioni con dati reali ([00:06:47](https://docs.google.com/document/d/1dsJn_rErSHqP6XaiZeHTR60sOCQ5Emy-656-wMRbMBU/edit?ouid=100243958128504204165#heading=h.87xs9ltiwzm5)).

-----

**Risoluzione dei problemi di connessione tecnica**: Durante la condivisione dello schermo di Fabrizio Mastracci, Rebecca Marmo e Sabatino Rinaldi riscontrano problemi di connessione audio e video. Aurel mrruku suggerisce di effettuare un aggiornamento della pagina o di uscire e rientrare dalla chiamata, operazione che consente a Rebecca Marmo e Sabatino Rinaldi di ripristinare la comunicazione con il gruppo ([00:08:56](https://docs.google.com/document/d/1dsJn_rErSHqP6XaiZeHTR60sOCQ5Emy-656-wMRbMBU/edit?ouid=100243958128504204165#heading=h.ff2ws721zs4x)).

-----

**Configurazione delle campagne e dei flussi su Marketing Cloud**: Fabrizio Mastracci illustra la struttura basata su due campagne in Marketing Cloud per gestire gli inviti agli eventi e la conferma dei biglietti da parte dei clienti. Il sistema gestisce l'invio automatizzato di comunicazioni e la generazione dei biglietti confermati ([00:10:48](https://docs.google.com/document/d/1dsJn_rErSHqP6XaiZeHTR60sOCQ5Emy-656-wMRbMBU/edit?ouid=100243958128504204165#heading=h.2ppop6w3zzl)).

-----

**Dettagli del flusso di richiesta e intervalli di invio**: Fabrizio Mastracci descrive il flusso di richiesta, il quale invia newsletter per un massimo di 11 volte, con l'aggiunta prevista di messaggi WhatsApp configurati insieme a Matteo Distaso. I partecipanti escono dal flusso in caso di rinuncia, compilazione del biglietto o superamento delle date dell'evento. Tramite il campo "weight interval", impostato da Fabrizio Mastracci, viene definito l'intervallo temporale tra un invio e il successivo ([00:12:23](https://docs.google.com/document/d/1dsJn_rErSHqP6XaiZeHTR60sOCQ5Emy-656-wMRbMBU/edit?ouid=100243958128504204165#heading=h.kxyf5o51zt5j)).

-----

**Flusso di generazione e invio del biglietto assegnato**: Fabrizio Mastracci spiega il secondo flusso, attivato quando un cliente compila i dati anagrafici del biglietto. Il sistema crea una riga d'ordine, genera un documento PDF con codice QR e liberatoria, e invia un'email contenente il link per scaricare il biglietto dell'evento ([00:15:58](https://docs.google.com/document/d/1dsJn_rErSHqP6XaiZeHTR60sOCQ5Emy-656-wMRbMBU/edit?ouid=100243958128504204165#heading=h.hc6jz7pbojy7)).

-----

**Esecuzione del test di invio email a Sabatino Rinaldi**: Fabrizio Mastracci avvia un test inviando un'email di prova a Sabatino Rinaldi, impostando un intervallo ridotto in minuti per accelerare la verifica. Sabatino Rinaldi riceve l'email contrassegnata come "Test mark in edizione accad 26" e condivide lo schermo per mostrarne i contenuti ai partecipanti ([00:18:10](https://docs.google.com/document/d/1dsJn_rErSHqP6XaiZeHTR60sOCQ5Emy-656-wMRbMBU/edit?ouid=100243958128504204165#heading=h.y97t08uotfz4)).

-----

**Discussione sull'usabilità del pulsante di accettazione nell'email**: Elena Spini solleva criticità sul design dell'email di invito, evidenziando che l'utilizzo di un pulsante di accettazione diretto è fuorviante poiché gli utenti finiscono comunque su una pagina della community di Salesforce che richiede ulteriori passaggi. Sabatino Rinaldi discute con Elena Spini sull'opportunità di rivedere i testi per chiarire se accettare o rifiutare l'evento ([00:22:38](https://docs.google.com/document/d/1dsJn_rErSHqP6XaiZeHTR60sOCQ5Emy-656-wMRbMBU/edit?ouid=100243958128504204165#heading=h.nvqwhbl9qv3s)).

-----

**Logiche di gestione delle edizioni e dei biglietti**: Elena Spini spiega le logiche di visualizzazione basate sull'edizione di riferimento (Academy edizione 2026), dove la pagina di atterraggio mostra esclusivamente i biglietti acquistati per quell'edizione. Viene specificato che, una volta inserito il primo nominativo, non è più possibile effettuare la rinuncia per quel blocco, poiché il primo biglietto viene emesso immediatamente ([00:25:11](https://docs.google.com/document/d/1dsJn_rErSHqP6XaiZeHTR60sOCQ5Emy-656-wMRbMBU/edit?ouid=100243958128504204165#heading=h.m1yazxhaawfl)).

-----

**Compilazione del test e ricezione del biglietto con codice QR**: Sabatino Rinaldi compila i dati di test inserendo i nominativi di Matteo Distaso e Rebecca Marmo. Dopo circa un minuto, l'email di conferma viene recapitata, includendo il biglietto in formato PDF con codice QR collegato al membro dell'evento in Salesforce, la cui compatibilità con l'applicazione di check-in è stata verificata da Andrea Parmegiani come confermato da Elisa Migliano e Elena Spini ([00:27:55](https://docs.google.com/document/d/1dsJn_rErSHqP6XaiZeHTR60sOCQ5Emy-656-wMRbMBU/edit?ouid=100243958128504204165#heading=h.1p39cujhetho)).

-----

**Dibattito sulla visibilità del pulsante di rinuncia nelle email**: Matteo Distaso esprime forte preoccupazione riguardo alla posizione del pulsante di rinuncia, sostenendo che se il comando viene nascosto in una pagina successiva, la clientela risulterà pigra e non comunicherà le rinunce, provocando sale vuote e dati di vendita falsati. Matteo Distaso insiste sulla necessità di inserire un pulsante di rinuncia diretto ed evidente nell'email per evitare cali nelle disdette tracciate ([00:31:18](https://docs.google.com/document/d/1dsJn_rErSHqP6XaiZeHTR60sOCQ5Emy-656-wMRbMBU/edit?ouid=100243958128504204165#heading=h.8ev71vlae4g)).

-----

**Valutazione dei rischi operativi e di usabilità dei pulsanti diretti**: Elena Spini, Elisa Migliano e Aurel mrruku evidenziano i rischi legati all'inserimento di pulsanti di rinuncia diretti nelle email, tra cui la possibilità che i clienti clicchino accidentalmente per errore (ad esempio da dispositivi mobili durante gli spostamenti) invalidando irreversibilmente i biglietti o confondendo più eventi. Nonostante le perplessità tecniche ed anagrafiche sollevate, Matteo Distaso ribadisce la propria preferenza per avere i bottoni direttamente nell'email ([00:35:39](https://docs.google.com/document/d/1dsJn_rErSHqP6XaiZeHTR60sOCQ5Emy-656-wMRbMBU/edit?ouid=100243958128504204165#heading=h.f8023nna1b5l)).

-----

**Gestione dei casi limite e delle modifiche successive**: Rebecca Marmo chiede se sia possibile ripristinare i biglietti resi disponibili nel caso in cui un utente prema accidentalmente il tasto di rinuncia. Elena Spini e Aurel mrruku concordano sul fatto che la gestione di tali casistiche limite e il tracciamento avanzato degli errori vengano rimandati a una successiva fase due, focalizzandosi al momento sul percorso standard ([00:43:08](https://docs.google.com/document/d/1dsJn_rErSHqP6XaiZeHTR60sOCQ5Emy-656-wMRbMBU/edit?ouid=100243958128504204165#heading=h.yp18rrujqyi1)).

-----

**Verifica dei dati di contatto mancanti nel CRM**: Sabatino Rinaldi rileva l'assenza del numero di telefono in uno dei tre contatti compilati durante il test. Aurel mrruku e Fabrizio Mastracci analizzano il caso, deducendo che il numero potrebbe non essere stato salvato correttamente o che il contatto esisteva già ed era stato riutilizzato da cicli di test precedenti ([00:45:39](https://docs.google.com/document/d/1dsJn_rErSHqP6XaiZeHTR60sOCQ5Emy-656-wMRbMBU/edit?ouid=100243958128504204165#heading=h.bs1bqwyzh8g)).

-----

**Discussione sul tracciamento dei clic e dei tag in Marketing Cloud**: Matteo Distaso chiede se il clic sui pulsanti all'interno di email generiche possa generare tag automatici per smistare i lead in flussi di lavoro dedicati. Fabrizio Mastracci e Elena Spini chiariscono che Salesforce non utilizza i "tag" nella modalità richiesta, ma confermano che è possibile tracciare i clic sulle chiamate all'azione e configurare appositi flussi di smistamento basati su condizioni di scelta (\*decision splits\*) ([00:47:33](https://docs.google.com/document/d/1dsJn_rErSHqP6XaiZeHTR60sOCQ5Emy-656-wMRbMBU/edit?ouid=100243958128504204165#heading=h.dpj7wwtj58m7)).

-----

**Secondo test di invio e proposta di miglioramento della pagina di rinuncia**: Fabrizio Mastracci invia un ulteriore test di invito all'indirizzo email di Matteo Distaso. Durante la visualizzazione della pagina di atterraggio, Matteo Distaso e Elena Spini esaminano la funzione di rinuncia. Matteo Distaso propone di inserire un controllo preventivo (\*double check\*) con un pop-up di conferma che avvisi l'utente della definitività della rinuncia per prevenire clic accidentali. Aurel mrruku conferma che la pagina personalizzata consente l'implementazione di questa modifica ([01:00:34](https://docs.google.com/document/d/1dsJn_rErSHqP6XaiZeHTR60sOCQ5Emy-656-wMRbMBU/edit?ouid=100243958128504204165#heading=h.qy20yixpg7fk)).

-----

**Visualizzazione mobile e struttura delle campagne in Sales Force**: Viene affrontata la visualizzazione della pagina da mobile e viene ricordata la distinzione in Sales Force tra campagna evento e campagna edizione, dove la prima funge da contenitore per le edizioni specifiche come camerieri venditori 2026, come discusso da Aurel mrruku, Fabrizio Mastracci, Matteo Distaso ed Elena Spini ([01:05:15](https://docs.google.com/document/d/1dsJn_rErSHqP6XaiZeHTR60sOCQ5Emy-656-wMRbMBU/edit?ouid=100243958128504204165#heading=h.r8em26hqwho8)).

-----

**Gestione degli intervalli di attesa tra gli invii**: Rebecca Marmo fa notare che gli intervalli di attesa tra un invio e l'altro variano (ad esempio due giorni tra il primo e il secondo, cinque tra il secondo e il terzo) all'interno di una sequenza di undici invii. Fabrizio Mastracci spiega che impostare intervalli dinamici direttamente nel funnel di Marketing Cloud risulta complesso e richiede modifiche manuali costanti, suggerendo invece di gestire i dati tramite la campagna ([01:08:27](https://docs.google.com/document/d/1dsJn_rErSHqP6XaiZeHTR60sOCQ5Emy-656-wMRbMBU/edit?ouid=100243958128504204165#heading=h.yrlj6mhtqv4y)).

-----

**Limiti di flessibilità e proposte di configurazione dei pesi di attesa**: Sabatino Rinaldi interviene richiedendo la massima flessibilità operativa per il team di marketing senza blocchi da parte del sistema. Fabrizio Mastracci propone di preimpostare i periodi di attesa prima dell'attivazione della campagna, mentre Rebecca Marmo ribadisce la necessità di calcolare manualmente i giorni in base al calendario e alle preferenze operative, come l'esclusione del sabato ([01:10:50](https://docs.google.com/document/d/1dsJn_rErSHqP6XaiZeHTR60sOCQ5Emy-656-wMRbMBU/edit?ouid=100243958128504204165#heading=h.yd6g7e9yb6uh)) ([01:14:53](https://docs.google.com/document/d/1dsJn_rErSHqP6XaiZeHTR60sOCQ5Emy-656-wMRbMBU/edit?ouid=100243958128504204165#heading=h.5id1dk5yj42s)).

-----

**Soluzione tecnica per la gestione dinamica delle date**: Aurel mrruku propone una soluzione tecnica che prevede la creazione automatica di undici record associati alla campagna (denominati weight da 1 a 11) in cui la persona che gestisce le campagne può inserire o modificare manualmente le date o i giorni di attesa. Fabrizio Mastracci e Rebecca Marmo valutano positivamente l'approccio, sebbene Fabrizio Mastracci segnali la necessità di implementare formule specifiche nel sistema ([01:19:56](https://docs.google.com/document/d/1dsJn_rErSHqP6XaiZeHTR60sOCQ5Emy-656-wMRbMBU/edit?ouid=100243958128504204165#heading=h.9bt3ykgwqqw2)).

-----

**Approccio ibrido per eventi con un numero ridotto di invii**: In merito alla gestione di eventi con meno di undici invii (ad esempio quattro o cinque), Elena Spini propone di utilizzare un massimo di undici campi precompilati in cui i campi lasciati vuoti interrompono il flusso. Fabrizio Mastracci conferma la fattibilità tecnica di questa logica ibrida, pur evidenziando l'onere delle modifiche da coordinare con Aurel mrruku ([01:28:19](https://docs.google.com/document/d/1dsJn_rErSHqP6XaiZeHTR60sOCQ5Emy-656-wMRbMBU/edit?ouid=100243958128504204165#heading=h.yzy8xxida9ol)).

-----

**Integrazione tra marketing e CRM**: Sabatino Rinaldi solleva dubbi sull'opportunità di vincolare i funnel direttamente alle campagne del CRM anziché utilizzare liste e funnel di marketing indipendenti per maggiore dinamicità. Elena Spini spiega che gli oggetti CRM integrano logiche complesse legate a ordini, pagamenti, tranche e biglietti, rendendo necessaria questa struttura ([01:34:14](https://docs.google.com/document/d/1dsJn_rErSHqP6XaiZeHTR60sOCQ5Emy-656-wMRbMBU/edit?ouid=100243958128504204165#heading=h.3nooqoi5cmfj)).

-----

**Valutazione della scalabilità e della prudenza operativa**: Sabatino Rinaldi sottolinea l'importanza di mantenere la cautela per evitare di replicare errori passati e ritrovarsi con un CRM non gestibile nel medio-lungo termine. Elena Spini risponde che la piattaforma è stata strutturata per essere scalabile e che la documentazione tecnica verrà fornita, precisando tuttavia che il flusso principale dei biglietti richiede particolare attenzione nelle modifiche ([01:41:08](https://docs.google.com/document/d/1dsJn_rErSHqP6XaiZeHTR60sOCQ5Emy-656-wMRbMBU/edit?ouid=100243958128504204165#heading=h.um89jma41zlv)).

-----

**Gestione degli eventi particolari come il Food Marketing Festival**: Rebecca Marmo e Sabatino Rinaldi spiegano che eventi complessi come il Food Marketing Festival presentano dinamiche particolari, tra cui biglietti gratuiti e a pagamento, e funnel avviati in base all'andamento delle registrazioni. Fabrizio Mastracci propone di predisporre un template dedicato e duplicabile per gestire questi casi specifici senza alterare il flusso standard dei biglietti ([01:47:48](https://docs.google.com/document/d/1dsJn_rErSHqP6XaiZeHTR60sOCQ5Emy-656-wMRbMBU/edit?ouid=100243958128504204165#heading=h.eiu740fxqd3h)).

-----

**Adozione del nuovo processo e adattamento operativo**: Elena Spini invita il team a considerare l'adozione del flusso unico non come una limitazione ma come un miglioramento dei processi, sottolineando la necessità di uno sforzo di adattamento alla nuova piattaforma. Elisa Migliano ricorda che nel pomeriggio è prevista una riunione interna per definire i dettagli operativi ([01:56:52](https://docs.google.com/document/d/1dsJn_rErSHqP6XaiZeHTR60sOCQ5Emy-656-wMRbMBU/edit?ouid=100243958128504204165#heading=h.cv31ermicrp9)).

-----

**Gestione degli eventi online e dei corsi senza emissione di biglietti**: Sabatino Rinaldi, Rebecca Marmo, Elena Spini e Fabrizio Paganelli discutono la gestione di eventi online come ODB Live, i quali non prevedono l'emissione di biglietti fisici o il check-in in presenza, bensì la partecipazione tramite Zoom e l'acquisto di prodotti digitali tramite WooCommerce e Mexal. Viene stabilito che tali eventi non genereranno biglietti nel CRM e utilizzeranno un percorso di comunicazione di marketing standard anziché il funnel dei biglietti ([01:59:11](https://docs.google.com/document/d/1dsJn_rErSHqP6XaiZeHTR60sOCQ5Emy-656-wMRbMBU/edit?ouid=100243958128504204165#heading=h.cix7h4xomru1)).

-----

**Tracciamento delle Partecipazioni per gli Eventi in Streaming ODB**: Fabrizio Paganelli ha sollevato un problema riguardo alla gestione dei partecipanti per gli eventi in streaming ODB, evidenziando che, a differenza dei biglietti fisici dotati di codice QR per il check-in, un codice articolo senza generazione di biglietto non traccerebbe le presenze, rischiando di accumulare dati errati tra il 2027 e il 2028. Sabatino Rinaldi ha risposto che la piattaforma Zoom fornisce dati dettagliati sugli utenti iscritti e partecipanti, permettendo di incrociare i dati con il customer relationship management. Il consenso finale stabilisce che Fabrizio Paganelli modificherà l'anagrafica degli articoli impostando l'articolo ODB streaming senza generazione del biglietto, mentre Sabatino Rinaldi utilizzerà Zoom e Marketing Cloud per tracciare i pagamenti e le presenze effettive ([02:04:16](https://docs.google.com/document/d/1dsJn_rErSHqP6XaiZeHTR60sOCQ5Emy-656-wMRbMBU/edit?ouid=100243958128504204165#heading=h.ogeayrm5uehd)).

-----

**Integrazione tra il Customer Relationship Management e la Piattaforma Zoom**: Sabatino Rinaldi ha sollevato il tema relativo alla presenza di un collegamento diretto tra il customer relationship management (Salesforce) e Zoom, ricordando di averne discusso con Andrea Galotto prima della firma del contratto. Fabrizio Mastracci ha precisato che si faceva riferimento al customer relationship management, mentre Elena Spini e Aurel Mrruku hanno evidenziato la disponibilità di connettori standard, la cui fattibilità dipenderà anche dall'abbonamento Zoom sottoscritto. Sabatino Rinaldi ha concluso che l'aspetto tecnico non desta preoccupazione, poiché Zoom può prelevare le informazioni dei contatti direttamente dal customer relationship management ([02:07:18](https://docs.google.com/document/d/1dsJn_rErSHqP6XaiZeHTR60sOCQ5Emy-656-wMRbMBU/edit?ouid=100243958128504204165#heading=h.j5lyvdwtnw50)).

-----

**Revisione del Piano di Progetto e Gestione delle Scadenze**: Elena Spini ha interrotto la riunione per impegni urgenti, ricordando ai partecipanti di aver inviato la sera precedente lo stato avanzamento progetto e il link al nuovo piano. Elena Spini ha evidenziato che qualsiasi decisione presa durante il meeting interno avrebbe potuto rimettere in discussione il piano inviato, richiedendo quindi che le parti comunicassero tempestivamente gli esiti della loro discussione. La riunione si è conclusa con i saluti di tutti i partecipanti, tra cui Elisa Migliano, Aurel Mrruku, Fabrizio Mastracci, Elena Spini, Sabatino Rinaldi e Rebecca Marmo ([02:09:12](https://docs.google.com/document/d/1dsJn_rErSHqP6XaiZeHTR60sOCQ5Emy-656-wMRbMBU/edit?ouid=100243958128504204165#heading=h.c2bxazjjblc3)).

  
  

*Dovresti rivedere le note di Gemini per assicurarti che siano accurate.* [*Ricevi suggerimenti e scopri come Gemini prende appunti*](https://support.google.com/meet/answer/14754931)

*Qual è la qualità di* ***queste note specifiche?*** [*Rispondi a un breve sondaggio*](https://google.qualtrics.com/jfe/form/SV_5bXzKQfylMIhSXc?confid=HpN2KSELPspxj6NYUvhmDxIROBEQAjIGCIoCIAAYAwg&detailLevel=standard&hasImages=False&entryPoint=footerMain&isGoogler=False&lang=it-IT)*? Facci sapere cosa ne pensi e quanto le note siano state utili per le tue esigenze.****  
***

# **ð Trascrizione***  
*

 ott 16, 2026

## **\[ROMI-PIENISSIMO\] - UAT: Flussi MKT Biglietti - Trascrizione**

### **00:01:37**

  

**Fabrizio Mastracci:** Ciao Fabrizio, buongiorno.

**Fabrizio Paganelli:** Buongiorno a tutti.

**Fabrizio Mastracci:** Per ora siamo in due. Due Fabrizi, piacere di conoscerti intanto.

**Fabrizio Paganelli:** Ciao, piacere, non ci siamo mai sentiti, credo.

**Fabrizio Mastracci:** No,

**Elena Spini:** Ciao,

**Fabrizio Mastracci:** una volta. Ciao ragazzi, buongiorno. No.

**Elena Spini:** buongiorno.

**Fabrizio Paganelli:** Ciao a tutti.

**Elena Spini:** Vi siete già autopresentati? Sì, mi sa che Fabrizio, tu Fabrizio Paganelli, mi sa che tu non hai mai conosciuto la parte marketing,

**Fabrizio Paganelli:** No, no,

**Elena Spini:** Romi.

**Fabrizio Paganelli:** ce l' Eh, lo so, arrivo. Ho finito ora.

**Elena Spini:** Allora, allora, allora,

**Fabrizio Paganelli:** Adesso arrivano anche Sabatinoe Matteo,

**Elena Spini:** mettiamo perfetto.

**Fabrizio Paganelli:** eh.

**Fabrizio Mastracci:** Ja.

**Fabrizio Paganelli:** I love you.

**Fabrizio Mastracci:** Eh

**Fabrizio Paganelli:** per te No, lunedì. Facciamo una foto. Arrivo.

**Elena Spini:** Ah, ho visto adesso che ci ha risposto Andrea Par

**Fabrizio Paganelli:** Sì,

**Elena Spini:** Giani Aurel,

**Fabrizio Paganelli:** sì.

**Elena Spini:** non so se hai visto, è andato bene il test del QR code.

**Aurel mrruku:** Aspetta, controllo che avrò i log sicuro.

  
  

### **00:04:05**

  

**Aurel mrruku:** Bro.

**Elena Spini:** Esatto. Quindi ha funzionato il tuo pressing ieri, Fabrizio. Bravo\!

**Fabrizio Paganelli:** Eh È mondo difficile. Eh, aspettiamo Matteo e Sabattino.

**Elena Spini:** Так.

**Aurel mrruku:** E lo vedo, l'ha fatto ieri alle 10:54.

**Elena Spini:** Lo vedi o non lo vedi?

**Fabrizio Paganelli:** alle 22:54 vuol dire,

**Aurel mrruku:** Eh

**Fabrizio Paganelli:** eh, immaginavo,

**Elena Spini:** si diverte anche lui la sera,

**Fabrizio Paganelli:** Eh,

**Elena Spini:** quindi lo vedi? Era la risposta Aurel, vero?

**Aurel mrruku:** Sì, sì, lo vedo. Eh, ma c'è anche l'ID del Poi ci ha provato alle 6 di pomeriggio, poi ci ha provato alle 10:54 di sera.

**Fabrizio Paganelli:** si vede che quando glielho detto io non ha funzionato, ma quando ci ha provato la prima alle 6:00 di pomeriggio

**Aurel mrruku:** Ah, no, cioè è andato bene anche le 6 di pomeriggio,

**Fabrizio Paganelli:** Ah,

**Aurel mrruku:** quindi ha fatto due pro Quindi moltamente ha fatto un test

**Fabrizio Paganelli:** allora ho fatto due prove, dai. M.

**Aurel mrruku:** da Postman, poi ha fatto un test reale dall'applicazione. Quindi all'inizio gli abbiamo detto il check del biglietto è già stato effettuo.

  
  

### **00:06:47**

  

**Aurel mrruku:** L'ha già anche fatto prima, quindi è divertito ieri.

**Elena Spini:** Ciao,

**Rebecca Marmo:** Co?

**Aurel mrruku:** Ciao.

**Sabatino Rinaldi:** Ciao. Ciao.

**Elena Spini:** ciao a tutti. Aspettiamo qualcun altro. Eccolo Matteo. Perfetto. Allora, registro

**Fabrizio Paganelli:** Sì.

**Elena Spini:** Ottimo. Allora, focus di oggi è vedere quanto è stato implementato per quanto riguarda il giro dei biglietti, l'atomarketing. Ora, attualmente non abbiamo tutte le funzionalità in produzione. Come sapete Marketing Cloud è testabile solo in produzione. abbiamo portato parte delle configurazioni fatte per fare questo questo test. Ciò vuol dire che faremo dei test comunque con dei dati fake oggi, giusto per farvi vedere le funzionalità, diciamo, alla base del tutto. Ehm, poi successivamente verrà fatto invece un altro test con i dati

**Fabrizio Mastracci:** f\*\*\*.

**Elena Spini:** reali, andando a simulare il tutto per bene. Quindi se eh vuoi condividere ehm Fabrizio, facciamo la prima parte di test.

**Fabrizio Paganelli:** Fabrizio, intendevi me? No.

**Elena Spini:** No, no, no. Fabrizio Romi. Fabrizio Romi.

**Fabrizio Mastracci:** Mazio M.

  
  

### **00:08:56**

  

**Elena Spini:** Esatto.

**Fabrizio Mastracci:** Allora, grazie Elena. Vado spiego un pochettino quello che sostanzialmente ho fatto su marketing. Intanto vi zoomo, mi rendo conto che lo schermo è un po' grande. Ditemi se vedete bene.

**Elena Spini:** Sì, sì.

**Fabrizio Mastracci:** Perfetto. Allora, diciamo che la richiesta era quella di fare una flusso che sostanzialmente gestisse l'esspetta

**Rebecca Marmo:** Io non vedo, mi sa che non abbiamo v la connessione.

**Elena Spini:** M sc

**Aurel mrruku:** No, è visibile.

**Fabrizio Mastracci:** va

**Aurel mrruku:** Forse fai un refresh della pagina oppure entra,

**Elena Spini:** eh sì,

**Aurel mrruku:** esci dalla chiamata.

**Elena Spini:** infatti.

**Fabrizio Mastracci:** dimmi se riesci, altrimenti provo a condividere proprio tutto lo schermo.

**Aurel mrruku:** No, è è uscita,

**Elena Spini:** No, no.

**Aurel mrruku:** è uscita,

**Elena Spini:** Sì,

**Aurel mrruku:** sta rientrando.

**Elena Spini:** ma vedo anche Fabrizio bloccato. Poi io non so se è un problema mio.

**Fabrizio Mastracci:** Aspettiamo un attimo. Ma voi mi vede? Mi sentite?

**Elena Spini:** Sì, sì, si vede,

**Fabrizio Mastracci:** Io adesso io adesso sto il mouse,

**Elena Spini:** si vede bene.

  
  

### **00:09:56**

  

**Fabrizio Paganelli:** Ma io Sì,

**Fabrizio Mastracci:** vedete? Insomma, no?

**Fabrizio Paganelli:** sì.

**Aurel mrruku:** Sì, sì.

**Fabrizio Mastracci:** Ok. Ok. Bello della diretta.

**Elena Spini:** Rebecca,

**Fabrizio Mastracci:** da dirmi quando

**Elena Spini:** ora vedi

**Rebecca Marmo:** Sì, ora

**Fabrizio Mastracci:** Rebecca,

**Elena Spini:** Rebecca,

**Fabrizio Mastracci:** ci senti?

**Rebecca Marmo:** sì, mi sentite?

**Fabrizio Mastracci:** Sì,

**Elena Spini:** ora sì.

**Rebecca Marmo:** Vedo io.

**Fabrizio Mastracci:** adesso.

**Elena Spini:** Ok, vedi?

**Fabrizio Mastracci:** Ottimo.

**Rebecca Marmo:** Ah, ok.

**Elena Spini:** Perfetto.

**Rebecca Marmo:** Yeah.

**Fabrizio Mastracci:** Grazie. Allora,

**Sabatino Rinaldi:** Mi mi scusate,

**Fabrizio Mastracci:** dicevo che Sì,

**Sabatino Rinaldi:** mi mi sentite?

**Elena Spini:** Sì,

**Fabrizio Mastracci:** sì.

**Elena Spini:** ti sentiamo.

**Sabatino Rinaldi:** Ah, ok. No, perché noi, io,

**Fabrizio Paganelli:** Io spo Un attimo.

**Sabatino Rinaldi:** Matteo e Rebecca,

**Fabrizio Paganelli:** Sì.

**Sabatino Rinaldi:** fino ad ora non abbiamo sentito assolutamente nulla. Era la connessione è andata via, quindi non riuscivamo proprio a sentire nulla e a parlare.

**Fabrizio Mastracci:** Ah,

**Sabatino Rinaldi:** È stato un attimo di caos.

**Elena Spini:** Dobbiamo ancora iniziare,

**Fabrizio Mastracci:** ok.

**Elena Spini:** quindi non vi siete persi ancora nulla.

  
  

### **00:10:48**

  

**Sabatino Rinaldi:** Ok,

**Fabrizio Mastracci:** Ok,

**Elena Spini:** Tranquillo.

**Sabatino Rinaldi:** perfetto. Va bene.

**Fabrizio Mastracci:** fatto. Fatemi un fischio, insomma, se c'è qualche problema che mi interrompo. Dunque, quello che sostanzialmente è stato fatto su Marketing Cloud, quindi era un flusso che gestisse ha il la richiesta di invito agli eventi dove poi i vostri clienti andavano tramite quello che abbiamo visto anche volte scorse con Aurer, tramite quella pagina, a segnarsi i loro biglietti. Una volta che questo cliente ha successivamente poi confirato il proprio biglietto e quindi lo ha confermato, eh il flusso va a mandare una seconda mail alla persona, quindi al contatto al quale del quale ha inserito la mail il vostro, diciamo, ipotetico cliente con inallegato il biglietto dell'evento. Eh, questo, diciamo, sistema si basa andrà un pochettino sul tecnico, ma poi andiamo Andiamo subito sui test, almeno vi do pure dettaglio di quello effettivamente che vi lasciamo in piattaforma. si basa su due campagne. Eh, le campagne Marketing Cloud sostanzialmente sono dei contenitori che possono contenere a loro volta dei flow, dei flussi, quindi delle degli schemi di invio che noi poi possiamo utilizzare per fare determinate azioni.

  
  

### **00:12:23**

  

**Fabrizio Mastracci:** Nello specifico, quelli che io ho creato che sono contestuali a questa richiesta, sono automazione, richiesta, conferma biglietto e invio biglietto assegnato. Dunque, rivediamo un attimo rapidamente, giusto per ripassare le regole. Andiamo su low, mettiamo open flow. Quindi dentro questa campagna, al di sotto del, diciamo, del cofano di questa campagna c'è un flow. Vediamo che carichi. Ok, eccolo qui. Ve lo descrivo rapidamente anche perché è molto grande. Sostanzialmente che fa questo flow? va praticamente a mandare delle newsletter al quale poi non appena con Matteo configureremo anche il il WhatsApp manderà newsletter più WhatsApp per 11 volte al eh però diciamo così per 11 volte. Eh, però nel caso in cui si verificano alcuni condizioni che adesso vi riporto, il cliente esce dall'invio. Le condizioni sono la rinuncia al biglietto, la compilazione al biglietto e il superamento delle date. Quindi vi faccio un esempio. Se io cliente entro dentro questo flusso e compilo il biglietto alla terza mail, non riceverò le successive. Altro caso, se io cliente ehm entro dentro questo flusso e eh diciamo così vado a eh rinunciare a quelli che erano i miei biglietti, esco dal flusso.

  
  

### **00:14:30**

  

**Fabrizio Mastracci:** Stessa cosa, se io entro dentro questo flusso, ma l'evento poi è superato, io esco dal flusso. Queste queste casistiche sono quelle, diciamo, che abbiamo concordato e che gestiscono la parte di di diciamo di di uscita dal flusso. altra caratteristica importante, voi poi quando dovrete andare a fare, ma questo lo vedremo sicuramente poi più nel dettaglio, Quando voi andrete a compilare una campagna che di fatto non è che è un vostro evento, c'è un valore, un campo, vediamo, che si chiama weight interval, ok? In questo caso non è compilato perché non ci serve, ma il campo interval praticamente vi va a dire quanto eh quanto è lo step di attesa tra un invio di una richiesta di compilazione biglietto e l'altra. Quindi, ad esempio, facciamo un'ipotesi. Se io ho 11 email che vado a mandare e metto il weight interval qui che sarà due, mi manda la prima mail oggi, la prossima mail fra 2 giorni, la prossima fra 4, la prossima fra 6 e così via, affinché chiaramente io non vada a compilare nulla. Questo è il primo eh, diciamo flusso, quindi quello della richiesta.

  
  

### **00:15:58**

  

**Fabrizio Mastracci:** Quando poi il cliente eh va a per così dire compilare il proprio biglietto, quindi va a inserire i propri dati anagrafici, scatta un secondo flusso che invece qui è automazione invio biglietto assegnato, che vi faccio vedere anche questo rapidamente. Tanto vi anticipo quello che fa, giusto per non lasciare tempi muti. Sostanzialmente questo vede che si va a creare una riga di diciamo di ordine della di un biglietto assegnato, prende quei valori, genera il PDF con l'allegato, genera quindi il link di questo PDF, voi praticamente poi andrete a trovarvi una mail che ha clicca qui per scaricare il vostro, diciamo, biglietto e quindi voi scaricherete un biglietto formato PDF dove c'è un un codice QR e poi tutta la liberatoria. che il cliente deve andare a compilare. Eh, se non se è chiaro, passerei subito a dei test così poi lascio pure lo spazio alle vostre considerazioni.

**Matteo Distaso:** Andiamo avanti. O

**Fabrizio Mastracci:** Grazie Matteo. Allora, voglio giusto controllare una cosa qui, qui la scheda. Vabbè, mi stoendo sotto io. Ja. Riuscite a sentirmi?

  
  

### **00:18:10**

  

**Fabrizio Mastracci:** La mia linea va ancora bene perché vedo che carica.

**Elisa Migliano:** Sì, sì.

**Elena Spini:** Sì,

**Fabrizio Mastracci:** Ok,

**Elena Spini:** sì.

**Fabrizio Mastracci:** grazie. Vediamo così. Ok, allora andiamo a fare subito un test. Se volete, se mi girate una vostra mail in chat, vi faccio arrivare direttamente a voi il test se per voi va bene.

**Matteo Distaso:** Va bene, ti do la mia.

**Fabrizio Mastracci:** Ottimo. Verifichiamo che questo sia compilato.

**Elena Spini:** Ok.

**Matteo Distaso:** No, vabbè, t' ha dato quella di Sabatino.

**Fabrizio Mastracci:** Ok. Ok.

**Elena Spini:** Yeah.

**Sabatino Rinaldi:** Sperando che la connessione ti permette di mandarci in test.

**Fabrizio Mastracci:** Eh, è un po' lento, vero? Si percepisce. Iamo nome. Quello che vedete lo sto facendo io per far ripartire il test, ma poi, come diceva Elena, quando sarà tutto, diciamo, completato il giro non non dovete fare questa cosa per mandare la mail. Allora, io intanto mi tengo il flow sotto e Salvatino, poi fammi sapere quando ti arriva.

**Sabatino Rinaldi:** Sì, ancora non mi è arrivato. Vedo se c'è in spam.

  
  

### **00:20:57**

  

**Sabatino Rinaldi:** No. Nome spammeno in promozioni. È arrivato. Ah, ma condivido lo schermo, eh, se lo vedono tutti.

**Fabrizio Mastracci:** Eh, allora Zafatino, vi arriveranno 11 mail, una ogni 2 minuti, perché adesso io ho messo lo il wait in minuti, altrimenti saremo qui dei giorni a testare, quindi Quindi se poi non puoi continuare a ricevere mail, basta che combini il biglietto e butta fuori.

**Sabatino Rinaldi:** Sì, sì, faccio il giro ora. Lo vedete lo schermo?

**Fabrizio Mastracci:** Sì, sì.

**Elisa Migliano:** Sì.

**Sabatino Rinaldi:** Ok. Test mark in edizione accad 26. Completa i dati. Oteni tu obetti. Ciao Sabatino. Gen anticipi obietti per l'evento. Dettagli. Dove? Data. Checkin. Fine evento. Indirizzo. Come procedere? Bastano 2 minuti, clicca su accetta compri moduli per tutti i partecipanti. Ti chiediamo solitati partecipanti per generarlo per ogni biglietto. Il tuo biglietto è già confermato. Sono postan assistenza. Va bene.

**Elena Spini:** Allora, qua faccio un attimo un io un'aggiunta, cioè questo era la famosa email che m diciamo che da un attimo secondo me da rivedere perché eh come diceva Rebecca qua non c'è il tasto rifiuta e noi avevamo chiesto perché non rivedete in questo senso la mail, cioè del tipo la dico brutta, poi voi che siete più marchettari di me e troverete sicuramente il modo.

  
  

### **00:22:38**

  

**Elena Spini:** L'idea dovrebbe essere quella di vai su questo link per accettare o rifiutare la partecipazione all'evento.

**Matteo Distaso:** Ed è un'idea sbagliata.

**Elena Spini:** Perché, aspetta, fammi finire, per favore, Matteo, perché non possiamo avere il tasto accetta o rifiuta nella mail? Perché quando tu adesso clicchi su accetta tu finisci in una pagina della community che si chiama, che è una landing page che in salesource eh si attacca a la community. Vabbè, questi sono tecnicismi, per l'amor di Dio. Però in ogni caso, anche se qua noi facciamo il tasto rifiuta, tu dovresti comunque finire su un'altra pagina e in una in un secondo momento dovresti comunque ricliccare un altro tasso. Quindi non è un'azione automatica, quindi non so se ehm ho avete percepito il concetto, però in ogni caso cliccare su accetta o si rifiuta non implica una

**Fabrizio Mastracci:** No.

**Elena Spini:** azione di accettare o rifiutare l'evento, ma perché comunque l'utente deve finire su un'altra pagina e fare un'altra azione. E questo era quello che vi ho sempre detto fin dall'inizio.

**Sabatino Rinaldi:** Так.

**Elena Spini:** Quindi se Adesso fai accetta,

**Sabatino Rinaldi:** Sì.

**Elena Spini:** che poi non sarà accetta perché secondo me è misleading.

  
  

### **00:24:00**

  

**Sabatino Rinaldi:** No, di base ho capito cosa dici. Facciamo così.

**Elena Spini:** È misleading

**Sabatino Rinaldi:** Facciamo così. Eh, mettiamo intanto alla fine se non si può fare accetta rifiuta in automatico che clicco esegue l'azione e siamo obbligati a mandarli comunque su un'altra pagina.

**Elena Spini:** e comunque deve rifare un'altra cosa,

**Sabatino Rinaldi:** Ha senso ha senso lasciare qui questa

**Elena Spini:** capito?

**Sabatino Rinaldi:** schermata dove comunichiamo che inserisci i dati per confermare i nominativi oppure rinuncia e quindi c'è il tasto rinuncia.

**Elena Spini:** Esatto. Quindi forse, cioè, quella accetta magari è m non si capisce perché effettivamente se io voglio rinunciare perché devo cliccare su accetta?

**Sabatino Rinaldi:** Ok. Eh,

**Elena Spini:** Quindi servirebbe trovare forse un miglior modo di

**Sabatino Rinaldi:** se

**Elena Spini:** dire in questa mail eh segui questo link per accettare o rifiutare la tua prevedenza.

**Sabatino Rinaldi:** ok. Secondo me ha senso, perché, cioè, non avrebbe senso fare altre cose, dato che non c'è la possibilità di farlo, ma decidono Matteo e Rebecca, sono loro che se ne occupano.

**Elena Spini:** Ora, scusa un secondo, altra considerazione di questa pagina.

  
  

### **00:25:11**

  

**Elena Spini:** Eh, qua quello che abbiamo modificato rispetto all'altra volta è la logica per edizione. Quindi in questa pagina tu vedrai sempre e solo,

**Fabrizio Mastracci:** อ

**Elena Spini:** intanto ti arrivano tutti i reminder, tu vedrai sempre e solo i biglietti dell'edizione di riferimento. Quindi adesso non mi ricordo cos'era.

**Sabatino Rinaldi:** Ok.

**Elena Spini:** Academy eh 2026. Se torni sulla landing di partecipazione, perfetto. Qua hai per Academy edizione 2026 i tre biglietti che io ho acquistato in questo

**Sabatino Rinaldi:** E deve essere così.

**Elena Spini:** momento. In questo momento le logiche sono se clicchi su rinuncia, ti chiederei di non farlo adesso, però lo facciamo dopo, eh. rinuncia ai biglietti. Poi comunque lo facciamo il test perché vi voglio far vedere un'altra cosa di rinuncia. Se qua inizi a mettere i biglietti, altra cosa che abbiamo modificato, dal primo momento che tu inizi a metterne almeno uno, non puoi più rinunciare perché perché nel momento in cui tu vai a inserire il primo nominativo del primo biglietto, tu già ricevi il primo biglietto.

**Sabatino Rinaldi:** Vabbè, è chiaro.

**Elena Spini:** Poi in un secondo momento facciamo tutto il il processo,

  
  

### **00:26:32**

  

**Sabatino Rinaldi:** Questo deve essere obbligatorio.

**Fabrizio Mastracci:** Esatto.

**Elena Spini:** mettine solo uno e poi ritorniamo sul

**Fabrizio Mastracci:** Elena, abbiamo due test però adesso, eh,

**Elena Spini:** eh

**Fabrizio Mastracci:** quindi non io farei compilare tutti.

**Elena Spini:** io vorrei ritornare sul Perché io vorrei farglielo ritornare sul link.

**Sabatino Rinaldi:** Quindi

**Fabrizio Mastracci:** Yeah.

**Elena Spini:** Ah.

**Fabrizio Mastracci:** Ok.

**Elena Spini:** e fagli vedere come se vedesse il tizio che arriva dopo,

**Fabrizio Mastracci:** Ah, ok. Ok. Scusami, non avevo capito.

**Elena Spini:** solo per quello, perché l'altra volta gli avevamo detto che avevamo fatto devi compilare tutto per ricevere il biglietto,

**Sabatino Rinaldi:** Che faccio?

**Elena Spini:** invece adesso anche far No,

**Sabatino Rinaldi:** Ne li compilo tutti o ne compilo uno?

**Elena Spini:** no, lasciane uno, per favore. Perfetto. Quindi adesso quello che ti volevo far vedere è proprio questo. hai il biglietto compilato, mi immagino poi sarebbe il referente principale che compila almeno i dati suoi e poi fintanto che non sa chi porterà all'evento, lui ha vedrà quando riaccede per completare i dati rivede esatto il suo compilato e i due vuoti.

  
  

### **00:27:55**

  

**Elena Spini:** Ritorna, ritorna.

**Sabatino Rinaldi:** Sì, sì, sì.

**Elena Spini:** Ok, vediamo il biglietto. Dovrebbe essere arrivato adesso, no?

**Fabrizio Mastracci:** ci mette un minutino perché deve generare il link,

**Elena Spini:** Il biglietto cosa?

**Fabrizio Mastracci:** quindi ci mette un un minutino.

**Elena Spini:** Ah, giusto. È vero, è vero. Perché deve fare il PDF.

**Fabrizio Mastracci:** Se se vuoi Sabatino, comunque se vuoi far arrivare il test anche qui a qualcun altro puoi mettere anche poi M.

**Elena Spini:** Esatto. Mettiamo anche a qualcun altro. Bran eh

**Sabatino Rinaldi:** Vabbè, il numero metto uno a caso. Bene, ho messo Matteo e Rebecca e le loro mail, quindi dovrebbe arrivare via mail.

**Elena Spini:** Questo i partecipanti confermati partecipanti sono stati salvati, lo possiamo modificare con qualcosa di più parlante, se volete. Chettaro,

**Fabrizio Mastracci:** che sia arrivata l'ultima mail.

**Elena Spini:** guarda il primo.

**Sabatino Rinaldi:** Cosa?

**Elena Spini:** No.

**Sabatino Rinaldi:** Ah,

**Fabrizio Mastracci:** Esatto.

**Sabatino Rinaldi:** ok. Benvenuto al corso SK. Ciao, sei stato registrato partecipare al test. Per accedere all'evento ti servirà il biglietto cartaceo.

  
  

### **00:29:50**

  

**Sabatino Rinaldi:** Il tuo arrivo mostra biglietto da dove. data inizio, fine, indirizzo, Tipo, ti ricordo che evento se ok, scarica il biglietto downloads.

**Fabrizio Mastracci:** E poi un pochettino.

**Sabatino Rinaldi:** Quindi

**Fabrizio Mastracci:** Esatto. dati in quelli che hai compilato. Oh.

**Elena Spini:** Zooma poco poco, per favore. Questo per vedere a tutti che se c'è tutto.

**Sabatino Rinaldi:** test data partecipante ticket edizione edizione Academy. Vabbè, poi tutto il resto è uguale per tutti.

**Elena Spini:** Esatto.

**Sabatino Rinaldi:** Va bene. Se scansiono questo QR code c'hai il riferimento del del contatto creato in sales force, giusto? C'ha l'ID?

**Elena Spini:** un member che sarebbe il il partecipante all'evento.

**Sabatino Rinaldi:** Ok. che poi bisogna fare il collegamento con la nostra app di checkin.

**Elena Spini:** Esatto. Che è quello che dicevamo prima, forse quando ti stavamo aspettando, abbiamo avuto conferma che Aurelnon mi ricordo come si chiama,

**Elisa Migliano:** Parmigiani.

**Elena Spini:** pa Parmegiani,

**Sabatino Rinaldi:** Andrea Parmegiani

**Elena Spini:** grazie. Ha fatto il test e funziona. Ha confermato anche Laura.

**Sabatino Rinaldi:** alla regola.

  
  

### **00:31:18**

  

**Sabatino Rinaldi:** Ok, va bene. Allora, il giro va, cioè il biglietto arriva. L'unica cosa è per me ha senso fare come dite voi, dato che questa mail, dove c\*\*\*\* è mo la mail?

**Fabrizio Mastracci:** Кад пати.

**Elena Spini:** La prima, forse è la prima in alto. Ah, vabbè, ok, vai.

**Sabatino Rinaldi:** Dato che questo pulsante non determina un'azione, deve dobbiamo dire clicca qui per accettare o rifiutare e cliccando va nella sezione e può decidere se compilare o rifiutare. Se Matteo e Rebecca confermano va bene, dato che è una roba di cui se ne occupano loro in prima persona. Per me ha senso, però m devono rispondere Matteo Rebecca.

**Elena Spini:** Vi vorrei far vedere prima che mi fanno paura che nessuno parla,

**Sabatino Rinaldi:** E infatti sì, se non rispondo non andiamo avanti.

**Elena Spini:** ma va bene.

**Matteo Distaso:** Se vi silenziate.

**Elena Spini:** Vorrei fare il giro con cosa?

**Matteo Distaso:** Parlo. Eh, parlo parlo. Qual è il problema del rifiuta messo in un secondo step? Perché il cliente se non vuole venire, è una sua decisione e conoscendo i nostri clienti faranno così,

  
  

### **00:32:28**

  

**Fabrizio Mastracci:** Eh

**Matteo Distaso:** lui rifiuta nascosto in questa maniera, non ce lo farà mai sapere. Perché? Perché noi necessitiamo di farglielo vedere subito. Questo è un fatto del quale ci siamo accorti avendo a che fare con questi che si devono compilare i biglietti, già farli compilare a chi viene in impresa. Yeah. Quindi noi con questo sistema di rifiuta messo nella pagina biglietti, noi se uno decide di non venire non lo sapremo mai finché non siamo in sala fino all'ultimo. Noi mettiamo il rifiuta subito perché ci serve che sia evidente fin da subito nella mail, senò avremo parecchi eh clienti, soprattutto in determinate tipologie di corsi che necessitiamo avere pieni e quindi calcolare bene i numeri, che decidono di non venire, ma non ce lo comunicheranno mai perché semplicemente andranno nella mail, non vedono il rifiuta o non vogliono andare in un'altra pagina, sono pigri eccetera eccetera, non lo fanno. Mettere il rifiuta come tasto nella mail serve far sì che loro siano più propensi a schiacciarlo qualora non volessero venire. Quindi per noi è un è fondamentale fare sta cosa qua perché sennò ti dico che i tassi di rifiuta noi dalla mail crolleranno o dal WhatsApp quello che è crolleranno vertiginosamente e noi attribuiremo sta cosa al fatto che la gente vuol venire ma poi ci troviamo le sale vuote, scoppiamo le vendite perché, insomma, pensiamo di avere più biglietti di quelli in realtà sono perché il rifiuta è fra virgolette nascosto e questi non c'hanno sbatta di andare

  
  

### **00:34:34**

  

**Matteo Distaso:** nella pagina, compilarselo, vedere se io decido di non Eh,

**Elena Spini:** Ma non ha niente da compilare, cioè semplicemente deve dire se vuoi andare Ma bisognerebbe trovare il modo

**Matteo Distaso:** ma lui non lo sa, eh. No, no, no, no. Te te senti senti quello che ti dico io.

**Elena Spini:** lato commerciale Elena

**Matteo Distaso:** Senti che ti dico io, perché questa è la questione, questa è la situazione. Son così i nostri clienti. Ha voglia a dire "Ah, ma non devi compilare niente, ti prego, vammi a schiacciare il bottone lì". Non lo fanno. Se uno perde interesse, non non va a cercare il modo di fartelo capire a te che non ci vuol più venire. Quindi noi noi abbiamo i dati falsati così. E questa è la problematica.

**Fabrizio Mastracci:** All

**Elena Spini:** Non so, però io penso che in un qualsiasi tipologia di evento tu devi dire sì ci sono o

**Matteo Distaso:** E pensi male perché non conosci i nostri clienti.

**Elena Spini:** non ci sono,

**Matteo Distaso:** Poi peggio scappati di casa.

**Elena Spini:** però penso che se se posso se posso e poi magari sbaglio tutto,

  
  

### **00:35:39**

  

**Matteo Distaso:** Dimmi.

**Elena Spini:** non lo so. Eh, però cioè il discorso che facevamo con Fabrizio era Ok. state acquistando una piattaforma per permettervi di eh fare in modo di avere il mh meglio del tracciamento di qualsiasi Gzie dei flussi che abbiamo immaginato, ma anche lato vostro servirà fare una sorta di ehm training dal key user che usano la piattaforma che a loro volta devono m allenare, non mi viene in italiano, i clienti a essere a dare delle risposte in questo

**Fabrizio Mastracci:** M.

**Elena Spini:** senso. Non so se mi sono spiegata, cioè è sarà compito del tutor di riferimento capire se effettivamente questo cliente effettivamente sarà presente o meno e se non è presente

**Matteo Distaso:** Quindi facciamo a mano alla fine non fanno tutor. Non ho capito.

**Elena Spini:** cosa?

**Matteo Distaso:** Lo vanno a fare i tutor, quindi non ho capito.

**Elena Spini:** No,

**Matteo Distaso:** Facciamo il sistema per far chiamare tutto.

**Elena Spini:** no, no,

**Elisa Migliano:** Elena,

**Elena Spini:** no.

**Elisa Migliano:** scusa un attimo se intervengo, ma il limite anche del cioè il motivo per il quale nel caso non riuscissimo a cioè non riusciamo a fare il bottone rinunza sulla mail che mi sono mi sto un po' perdendo, quale sarebbe?

  
  

### **00:37:09**

  

**Elisa Migliano:** Pronto?

**Elena Spini:** Comunque ci sarebbe,

**Elisa Migliano:** Ok.

**Elena Spini:** cioè, allora, comunque non puoi che ha detto

**Aurel mrruku:** Posso?

**Matteo Distaso:** Comunque Elena, te la risolvo io. Noi mettiamo un bottone rinuncia nella mail che in realtà c'ha lo stesso link della pagina d'atterraggio dove atterrano quelli. Vedi?

**Elena Spini:** Eh, ma ok,

**Aurel mrruku:** Posso? Posso?

**Elena Spini:** ma ma scusa Aurel un secondo, ma secondo me così è peggio, è più misleading.

**Matteo Distaso:** Eh,

**Elena Spini:** Perché prima l'avevamo già fatta questa cosa, però secondo me non ha senso avere accetta e rifiuta due bottoni che poi alla fine ti portano nello stesso spazio.

**Matteo Distaso:** eh, ti dico io che c'ha senso perché a noi a noi serve

**Elena Spini:** Vai Aurel.

**Matteo Distaso:** così,

**Elena Spini:** Ma perché se così fosse lo facciamo,

**Matteo Distaso:** serve che qui

**Elena Spini:** va bene? Cioè non è un problema. però era perché non aveva senso per noi questa

**Matteo Distaso:** no te mettiti, te mettiti nell'ottica del cliente, perché noi dobbiamo ragionare non per quello che c'è comodo a noi, ma per quello che è comodo a loro ai clienti.

  
  

### **00:38:08**

  

**Matteo Distaso:** Quelli sono dei ristoratori che ce l'hanno fin sopra i capelli le robe da fare. gli dobbiamo dare più nuovi viaggi di scoperta di cose è fatto.

**Aurel mrruku:** Posso posso no?

**Elena Spini:** Dai, Aurel.

**Aurel mrruku:** Perché no? Vi vi vi spiego perché forse tecnicamente non è chiaro per tutti. Tu apri la mail in un cellulare, hai attiva rinuncia, per sbaglio hai fatto rinuncia, hai già spaccato tutto e hai perso tutti i biglietti. Vi va bene?

**Elena Spini:** No, lui di questo l'avevamo già escluso.

**Aurel mrruku:** No, aspetta, aspetta. No, do tutti gli argomenti, poi ne valutiamo.

**Elena Spini:** Ok.

**Aurel mrruku:** Si può fare tutto, non è che non si può fare tutto, ma cerchiamo di fare le cose non solo i happy path,

**Matteo Distaso:** microfono. Matteo

**Aurel mrruku:** quindi non solo quando è il caso corretto, pensiamo a tutti altri casi che non sono corretti. Aurel.Quindi per rinunciare, se tu lo fai dalla mail e fai atterrare una pagina che rinuncia in automatico, rischi che la persona, il cliente che apre la mail per sbaglio facendo scrolling premuncia e ha già invalidato i biglieti.

  
  

### **00:39:17**

  

**Aurel mrruku:** Prima cosa. Seconda cosa, se tu vuoi fare attiva rinuncia, devi togliere la l'opzione di fare rinuncia quando hai fatto attiva, quindi accetta, come come si chiama il bottone. Quindi vuol dire che noi quando tu scrivi accetta non dobbiamo far vedere più il rinuncia su accetta che qualcuno vuole accettare, non vuole rinunciare, quindi è sicuro che vuole accettare. Quindi non deve essere il secondo step ricordate la schermata. Terza cosa, tu hai già mandato una mail, lui forse fa parte eh a a due eventi, eh vede la prima mail, dopo 6 mesi vede la seconda mail, ma per sbaglio entra nella prima mail e clicca rinuncia. Quindi aveva già accettato, clicca rinuncia. Cosa si fa in quel caso? Mi state seguendo?

**Rebecca Marmo:** No, aspetta, non ho capito, ma se io ehm inserisco i nominativi nella seconda mail, poi se torno nella prima il link è sempre lo stesso.

**Aurel mrruku:** Non hai inserito tutti Non hai inserito tutti i nomi nominativi.

**Rebecca Marmo:** Eh, però io rinuncia non lo vedo più.

**Aurel mrruku:** E come non lo vede? È nella mail.

  
  

### **00:40:33**

  

**Rebecca Marmo:** Ma ma scusami se io avevan detto che noi nel momento in cui io inserisco i dati

**Aurel mrruku:** C'è la mail l'hai già inviata.

**Rebecca Marmo:** del primo partecipante non vedo più il tasto rinuncia.

**Aurel mrruku:** Eh, ma non la vedi nella piattaforma, nella mail la vedi perché la mail non la puoi modificare. una mail che è stata inviata, non si può modificare più,

**Rebecca Marmo:** Ah, vabbè,

**Aurel mrruku:** è sul tuo

**Rebecca Marmo:** sì, il tasto rinuncia lo vede, ma nel momento in cui preme poi dopo non ha il tasto vero di rinuncia.

**Aurel mrruku:** eh, però non è quella la schermata, questo stiamo cercando di dirvi.

**Elena Spini:** Aurel,

**Aurel mrruku:** Sì.

**Elena Spini:** sto cercando di farvi tutte le casistiche con il tasto rinuncia. Comunque,

**Fabrizio Mastracci:** Giusto,

**Elena Spini:** scusate un secondo.

**Fabrizio Mastracci:** chiarire, scusate, chiudo la cosa, giusto per chiarire, Aurel si riferiva alla mail, non al link che abbiamo visto in precedenza, quindi quello dove scompariva il bottone, sennò poi sembra che si può fare un pochettino di confusione.

**Elena Spini:** No, infatti, infatti. Allora, scusa, però se a Matteo va bene avere due bottoni che ti riportano a Matteo e Rebecca o a tutti voi, se a voi va bene avere nella mail accetta e rifiuta che comunque vi portano nella stessa landing con le stesse logiche che adesso vi vorrei far vedere il giro di rinuncia, noi lo facciamo.

  
  

### **00:41:43**

  

**Elena Spini:** è semplicemente che secondo noi per la nostra esperienza avere due bottoni che ti portano nella stessa landing page m diciamo non è consigliato e non è corretto, ma se per i vostri clienti pensate che va bene così alziamo le mani e ci veniamo incontro in questo modo. Fare questo Fabrizio e Aurel non penso sia un problema. Mettiamo la stessa logica.

**Aurel mrruku:** Non ha non ha nessun eh è banale,

**Elena Spini:** Se per voi va bene,

**Aurel mrruku:** però e infatti

**Elena Spini:** esatto, se per voi va bene, ok,

**Fabrizio Mastracci:** E guarda, giusto per per Rebecca

**Elena Spini:** però sappiate che, come diceva Aurel, se clicchi rinuncia in un secondo momento e però io ho già nominato il mio biglietto, per esempio, referente, poi finisco nella stessa landing, ho già messo un nome, non vedrò mai più rinuncia per quello Anche noi ci siamo abbiamo pensato, forse sarebbe meglio togliere questo bottone perché se poi la logica è così posso rinunciare solo la prima volta. Eh, però se voi lo volete e volete questa logica noi la implementiamo. Possiamo vedere il flusso rinuncia, Fabrizio?

  
  

### **00:43:08**

  

**Fabrizio Mastracci:** Sì. E Sabatino, posso mandare sempre a te?

**Sabatino Rinaldi:** Eh, mandalo a Matteo.

**Fabrizio Mastracci:** Ok. Eh,

**Rebecca Marmo:** Ma poi io ho anche ho anche una domanda.

**Fabrizio Mastracci:** Fabrizio.

**Rebecca Marmo:** Se io premo tasto rinuncia e poi cambio idea, noi possiamo rendere di nuovo disponibili per la nomina i biglietti?

**Aurel mrruku:** Eh, questo è il problema, no? Perché abbiamo detto quando si rinuncia si rinuncia a tutto.

**Sabatino Rinaldi:** Eh, allora Ora

**Rebecca Marmo:** E se qualcuno ci preme per sbaglio?

**Elisa Migliano:** Eh,

**Elena Spini:** Per questo serve in meno.

**Elisa Migliano:** ma è quello che stanno dicendo loro, infatti.

**Elena Spini:** Per questo mettere un bottone così, diciamo, forte, passami il termine, in una mail che veramente poi magari per sbaglio sono sul pullman, sto guidando, ho cliccato semplicemente sbagliando nella mail. E è importante.

**Rebecca Marmo:** Ma scusami,

**Elena Spini:** Quantomeno devo atterrare da un'altra parte in un'altra pagina,

**Rebecca Marmo:** ma se

**Elena Spini:** vedere che cosa mi stanno chiedendo e poi c'è un altro bottone.

**Aurel mrruku:** e poi nella pagina all'inizio e in un altro punto.

**Rebecca Marmo:** Ma infatti noi abbiamo detto che il tasto riporta alla stessa landing.

  
  

### **00:44:20**

  

**Rebecca Marmo:** Stiamo dicendo. Matteo ha detto, facciamo lo stesso tasto, scriviamo solo rinuncia,

**Elena Spini:** Sì.

**Rebecca Marmo:** ma porta comunque nella stessa landing.

**Fabrizio Mastracci:** Grazie.

**Rebecca Marmo:** Il problema è che se poi io atterro in quella landing e per sbaglio premo rinuncia perché sto scrollando, io devo avere la possibilità io eh qui in backoffice che se mi scrive il cliente mi dice sbagliato, posso rimetterglielo disponibile. Rebecca.M.

**Elena Spini:** Allora, m lo possiamo includere in Allora,

**Aurel mrruku:** M.

**Elena Spini:** stiamo facendo così, Rebecca, stiamo facendo per ora i primi processi flusso, diciamo, Happy Puff, come l'ha chiamato Aurel,

**Fabrizio Mastracci:** Elena.

**Elena Spini:** tutti i casi limiti che mi auguro non siano così tanti perché cioè veramente se hai aperto la pagina, hai sbagliato a cliccare, hai risbagliato a cliccare, vabbè non penso ce ne siano così tanti, ma ci sta che uno poi ci ripensa, lo tracciamo come caso limite della fase due, ma adesso dobbiamo andare avanti e non pensare a tutte queste casistiche perché verranno gestite in un secondo momento. ci sta, può essere il caso, dobbiamo pensarle tutte, come dici te, ma ed è un lavoro che stiamo facendo, però non in questa fase.

  
  

### **00:45:39**

  

**Sabatino Rinaldi:** Ma come mai io nei nei biglietti che ho compilato prima

**Elena Spini:** Non so se ti Cioè,

**Sabatino Rinaldi:** non vedo il numero di telefono di uno dei tre contatti? Solo uno dei tre è saltato.

**Elena Spini:** vuoi condividere?

**Sabatino Rinaldi:** Sì, vi condivido perché forse vi torna utile.

**Fabrizio Mastracci:** Mi dici qual è? Che lo verifico?

**Sabatino Rinaldi:** Ah, è qui, guarda. Forse è solo in visualizzazione. Eh, di questo contatto non vedo il numero.

**Aurel mrruku:** Non l'hai messa, eh?

**Elena Spini:** Ma l'avevi messo?

**Sabatino Rinaldi:** Certo che l'ho messo.

**Aurel mrruku:** Non l'hai messa?

**Sabatino Rinaldi:** Sì, sì, sì, l'ho messo. L'ho messo.

**Fabrizio Mastracci:** Aspetta, vediamo subito

**Elena Spini:** Eh, rifacciamolo con questo.

**Sabatino Rinaldi:** È l'unico numero vero dei tre che ho messo.

**Fabrizio Mastracci:** con Io non vedo sul tuo contatto in CRM non vedo il numero di telefono.

**Aurel mrruku:** Ah, non l'ha messo.

**Sabatino Rinaldi:** L'ho messo. Sì, l'ho messo. L'ho messo.

**Aurel mrruku:** Sal,

**Sabatino Rinaldi:** È l'unico numero di telefono che ho messo, vero? Mi ricordo perché era il mio.

  
  

### **00:46:32**

  

**Aurel mrruku:** eh. Poi sei anche in ambiente di produzione, può essere che c'è qualcosa di di sbagliato dietro,

**Sabatino Rinaldi:** Sì. No,

**Aurel mrruku:** no?

**Sabatino Rinaldi:** infatti può essere che sia saltato semplicemente in questo caso, però era giusto per farvelo vedere. Di sicuro l'ho messo, è giusto per riferirvelo.

**Aurel mrruku:** Ma eh l'hai usato lo stesso numero, la stessa mail anche di prima, perché se ce l'avevi già un contatto, però lo devi vedere in teoria qua

**Sabatino Rinaldi:** Sì. No, perché mi ricordo anche che quando nominavo questo biglietto, mentre lo nominavo e ho messo il numero, quando ho finito, sotto è comparsa una frase in verde, se non sbaglio, che diceva numero trovato.

**Aurel mrruku:** esiste già. Ah,

**Sabatino Rinaldi:** Esatto,

**Aurel mrruku:** ok, ok. Per quello,

**Sabatino Rinaldi:** esiste già.

**Aurel mrruku:** per quello, molto probmente l'ai già associato a un contatto che hai fatto, forse hai fatto il primo giro con lo stesso numero, con la stessa mail, per quello,

**Sabatino Rinaldi:** Sì, sì,

**Aurel mrruku:** eh.

**Sabatino Rinaldi:** di sicuro c'era già.

**Aurel mrruku:** Ok.

**Sabatino Rinaldi:** E Matteo mi sa che voleva spiegarvi un, non so, mi diceva nell'altro orecchio che voleva dirvi un processo.

  
  

### **00:47:33**

  

**Sabatino Rinaldi:** Vai, Matte.

**Matteo Distaso:** Allora, per quanto riguarda sti messaggi dei biglietti, no, noi abbiamo la landing dove tu puoi compilare o rinunciare, corretto?

**Fabrizio Mastracci:** Sì.

**Elena Spini:** corretto. Volevo far rifare un altro giro. Non so se No,

**Matteo Distaso:** Aspetta.

**Elena Spini:** volevo riarrivare dove stai dicendo te per quello.

**Matteo Distaso:** nel Ok, allora noi c'abbiamo la landing che tu puoi compilare i biglietti o rifiutare.

**Elena Spini:** Ok.

**Matteo Distaso:** Nel messaggio a me serve subito che c'è il testo che dice scarica, nomine, biglietti, quello che è con un bottone verde e dice nomina i biglietti. Sotto ci sarà scritto non puoi più partecipare, allora clicca su rifiuta e mettiamo il tasto rosso con scritto rifiuta. Questi due tasti conducono sempre a questa landing e magari sul primo bottone verde assegneremo un tag che vuol dire accetta su secondo segneremo un tag rifiuta. Ma poi quello lo vediamo noi in questo modo.

**Elena Spini:** Il il tag, scusa, ti correggo, è un'azione nel CRM.

**Matteo Distaso:** Io non posso,

**Elena Spini:** Adesso non ci sono più i tag,

**Fabrizio Mastracci:** อ

  
  

### **00:49:17**

  

**Elena Spini:** cioè la tua azione di accetta

**Matteo Distaso:** quindi io non posso assegnare il un taglico un bottone in una mail.

**Elena Spini:** no, non è è cambiata la funzionalità con salesource, non si chiamano più tag,

**Matteo Distaso:** Ah\!

**Elena Spini:** ma un'azione di questo tipo determina un'azione nel CRM. nello specifico, scusa Fabrizio, puoi condividere te se hai, non so, un asset sottomano

**Matteo Distaso:** Aspetta. Eh, comunque io ho il bottone che mi traccia, cioè il bottone che mi schiaccia lo riesco a tracciare?

**Elena Spini:** è un'azione di asset, quindi se tu fai accetta, il tuo biglietto, quindi asset diventa disponibile. Se tu fai rinuncia,

**Matteo Distaso:** No, non sto dicendo questo io.

**Elena Spini:** il tuo è

**Matteo Distaso:** Se io schiaccio un bottone in una mail, posso tenere traccia da qualche parte che questo m'ha schiacciato un bottone?

**Fabrizio Mastracci:** E posso intervenire io?

**Matteo Distaso:** Vai.

**Elena Spini:** vai.

**Fabrizio Mastracci:** Allora, per quanto riguarda il bottone, quello nella landing, quindi se accetta o rifiuta tu poi vuoi sapere Sì,

**Matteo Distaso:** No, nella mail. Nella mail. nella mail.

**Fabrizio Mastracci:** puoi

  
  

### **00:50:28**

  

**Matteo Distaso:** Se io mando delle mail a caso con dei bottoni, bottone 1, bottone 2, bottone 3, io posso tracciare che te mi schiacci il bottone uno, quello mi schiacci il bottone du, quello mi schiacci il bottone 3?

**Fabrizio Mastracci:** sì, però ti chiedo a a quale finalità In questo caso ti

**Matteo Distaso:** Ah,

**Fabrizio Mastracci:** chiedo

**Matteo Distaso:** in generale.

**Elena Spini:** Ora

**Matteo Distaso:** In generale, perché mi posso inventare qualcosa per cui mi serve che mi tracci i bottoni che schiaccia una persona.

**Fabrizio Mastracci:** sì, quello si può fare.

**Matteo Distaso:** Ok.

**Fabrizio Mastracci:** Posso condividere lo schermo?

**Matteo Distaso:** Beh,

**Fabrizio Mastracci:** Forse la cosa dei biglietti, riesco a rispondervi io. Se se vuoi sapere se una persona dalla rending rinunciato oppure ha scelto di comprare

**Elena Spini:** Vai,

**Fabrizio Mastracci:** il biglietto.

**Elena Spini:** vai.

**Fabrizio Mastracci:** Secondo me voi potete trovare questo dato e ti un

**Elena Spini:** Ok.

**Fabrizio Mastracci:** attimo vado a condividere lo schermo finestra. Sì. Ok. Allora, questo qui è l'invito dell'evento, quindi quello che noi che che diciamo fa partire la mail della Vuoi Matteo venire alla al nostro evento di pienissimo dove

  
  

### **00:51:41**

  

**Matteo Distaso:** No, c'è un impegno.

**Fabrizio Mastracci:** poi Esatto tu hai un impegno,

**Matteo Distaso:** Matteo.

**Fabrizio Mastracci:** ok? Tu collegato poi a questo, diciamo, evento, hai questo order che è praticamente i biglietti che voi avete. Ok? Se tu adesso in questo caso sono disponibili, quindi tu hai la landing che ti dice ok ha due biglietti disponibili, Matteo può compilarli. Se tu però poi vai a cliccare su rinuncia,

**Elena Spini:** Super.

**Fabrizio Mastracci:** questo stato cambia e diventa rinunciato. Quindi tu a quel punto, da questa scheda, sai che il referente destinatario, quindi la persona Matteo a questo invito ha rinunciato a quel biglietto e tu quindi hai il dato tracciato da lì. Ok?

**Matteo Distaso:** Eh,

**Fabrizio Mastracci:** M ok.

**Matteo Distaso:** quindi Ah.

**Fabrizio Mastracci:** No, dicevo che volevate sapere se come se so una persona se ha cliccato o meno su rinuncia che casomai cambia. Qui lo potete vedere in fatto quella cosa

**Rebecca Marmo:** No, no, Matteo intendeva qualsiasi altra mail,

**Fabrizio Mastracci:** assolutamente sì. Caved il tracking delle aperture,

**Rebecca Marmo:** non sui biglietti.

**Fabrizio Mastracci:** dei link e dei click, scusate, delle aperture e degli inv.

  
  

### **00:53:01**

  

**Matteo Distaso:** Ok,

**Rebecca Marmo:** Ok.

**Matteo Distaso:** bene.

**Rebecca Marmo:** Eh,

**Sabatino Rinaldi:** Cioè,

**Fabrizio Mastracci:** una funzionalità Ма

**Sabatino Rinaldi:** quindi Fabrizio,

**Matteo Distaso:** Ja.

**Rebecca Marmo:** io qui posso

**Sabatino Rinaldi:** Fabrizio stai dicendo che se noi mandiamo la mail come vuole Matteo che dove c'è il tasto verde accetta e il tasto verde rifiuta che in realtà quei due bottoni hanno lo stesso link. Ora, nell esempio pratico dei biglietti, se clicca su rinuncia, noi tracciamo quel click e ci cambia

**Rebecca Marmo:** perché vai rifiutato lo stato

**Sabatino Rinaldi:** anche lo stato dell'ordine.

**Fabrizio Mastracci:** quello No,

**Sabatino Rinaldi:** Possiamo fare questa cosa?

**Rebecca Marmo:** dell'asset,

**Fabrizio Mastracci:** no, quello no.

**Rebecca Marmo:** forse.

**Fabrizio Mastracci:** Questa cosa che vi vedere,

**Sabatino Rinaldi:** lo stato dell'asset,

**Rebecca Marmo:** Cześć.

**Sabatino Rinaldi:** scusa.

**Fabrizio Mastracci:** no, questa cosa che vi ho fatto vedere cambia dalla landing questa qui, dal link di registrazione che è una pagina community che

**Matteo Distaso:** Allora, questo è chiaro. Io dico fuori da dai

**Sabatino Rinaldi:** Va bene, ho capito, dai.

**Fabrizio Mastracci:** però Non.

**Sabatino Rinaldi:** Ehm,

**Matteo Distaso:** biglietti. Volevo solo sapere se il click sui bottoni nelle mail o sui link delle mail potevano generare dei tag.

  
  

### **00:54:06**

  

**Matteo Distaso:** Quindi associare dei tag.

**Fabrizio Mastracci:** M no, non funziona tag force.

**Aurel mrruku:** Ma non sto capendo cosa intendi con tag, perché dietro c'è un link,

**Elisa Migliano:** Ja.

**Aurel mrruku:** quindi vuoi mettere un'altra informazione nel link quando il link arriva nella landing page della community dove vede i dati del biglietto.

**Matteo Distaso:** Ma lascia stare i biglietti,

**Sabatino Rinaldi:** Sì.

**Elena Spini:** No, no, esatto,

**Matteo Distaso:** non sto parlando di quello.

**Elena Spini:** infatti. Aspetta, aspetta,

**Matteo Distaso:** Io volevo.

**Elena Spini:** provo a riformulare. Allora, Matteo, togliamo il tema biglietti. Non stiamo parlando di landing della community, niente biglietti. Matteo sta chiedendo a Fabrizio, Fabrizio, su Marketing Cloud, se io un giorno X mi sveglierò e faccio una mail da marketing, bottone 1 2 3, poi ci sarà un modo di capire se effettivamente il cliente ha cliccato su 1 2 o 3 una volta che ha aperto la mail.

**Fabrizio Mastracci:** Certo, ho detto prima.

**Elena Spini:** Esatto.

**Fabrizio Mastracci:** Sì.

**Elena Spini:** Esatto. Quindi sì,

**Matteo Distaso:** Ecco,

**Elena Spini:** è la risposta.

**Matteo Distaso:** questi click e questi click mi

  
  

### **00:55:11**

  

**Elena Spini:** Non lo facciamo adesso su questa mail. Perché ci sono regole diverse.

**Matteo Distaso:** consentono mi consentono di aggiungere dei tag in automatico.

**Elena Spini:** Cosa vuol dire tag? Cosa sono tag?

**Fabrizio Mastracci:** Mi fai un c\*\*\*\*

**Elena Spini:** Certo che siamo in sensors adesso. No.

**Fabrizio Mastracci:** che facevi prima? Cioè, almeno capiamo un attimo. Tu mandi una mail?

**Matteo Distaso:** Aspe che non ho capito niente.

**Sabatino Rinaldi:** Ec.

**Fabrizio Mastracci:** Mi senti?

**Matteo Distaso:** Qual è la domanda?

**Fabrizio Mastracci:** No, chiedevo,

**Matteo Distaso:** Sì.

**Fabrizio Mastracci:** allora, immaginiamo, mettiamo un attimo da parte questa parte dei biglietti, ok? Tu mandi una mail con una newsletter con tre CTA,

**Sabatino Rinaldi:** Sì.

**Matteo Distaso:** Ecco,

**Fabrizio Mastracci:** quindi bottone 1, bottone 2, bottone 3.

**Matteo Distaso:** esatto.

**Fabrizio Mastracci:** Tu vedi che che Mario ha cliccato il bottone uno,

**Matteo Distaso:** No, ti faccio ti faccio l'esempio proprio così.

**Fabrizio Mastracci:** Sabatino ha cliccato il bottone Esatto.

**Matteo Distaso:** Mi entrano dei lead, no?

**Fabrizio Mastracci:** Ok.

**Matteo Distaso:** E io gli dico a cosa sei interessato?

**Fabrizio Mastracci:** Ok.

**Matteo Distaso:** E uno dice, "Io sono interessato ai corsi e quindi c'è il bottone corsi.

  
  

### **00:56:09**

  

**Sabatino Rinaldi:** così il fino

**Matteo Distaso:** Io sono interessato alla piattaforma. C'è il bottone piattaforma.

**Elena Spini:** Och

**Matteo Distaso:** Io sono interessato alle consulenze, quindi c'è il coso consulenza. Ok? Se io schiaccio sui bottoni corsi è possibile apporre in

**Fabrizio Mastracci:** Mhm.

**Matteo Distaso:** automatico un tagato corsi e me lo

**Fabrizio Mastracci:** Ok,

**Matteo Distaso:** smista in un funnel dei corsi.

**Fabrizio Mastracci:** adesso ho capito che che dici. Quindi tu vuoi praticamente fai ti entra un lead, gli mandi una prima mail, dici a cosa sei interessato, uno, due o tre, il cliente è interessato a due e tu lo devi mandare praticamente sopra il, diciamo, il ramo del due. Ad esempio,

**Matteo Distaso:** Esatto.

**Fabrizio Mastracci:** se l'altro viente invece ti clicca su uno, ok, diciamo che mi è chiaro adesso non La cosa che non ci capiamo è che Marketing Cloud non funziona a tag, però sì, si può fare questa cosa, cioè devi costruire un flow che ti gestisce questa cosa. Giusto per chiudere un attimo, perché almeno vi faccio vedere che cattura questa informazione.

**Matteo Distaso:** อ

**Fabrizio Mastracci:** Comunque ci si può lavorare.

  
  

### **00:57:26**

  

**Fabrizio Mastracci:** Eh, qui questa è praticamente la dashboard dei dati eh dell'email invio che stiamo vedendo oggi, ok? Quello del biglietto. Vedete, qui ci sono dei dati aggregati, quindi il click, le aperture, eccetera eccetera. Chiaramente questi riassunti, queste sintesi si fanno su dei dati delle singole righe di record. Quindi vedi, ad esempio, qui vede che Sabatino ha cliccato, Sabatino ha aperto, quindi sì, in teoria, cioè si può fare quella cosa che dici tu, non funziona con i tagent

**Matteo Distaso:** Ok. E quindi queste informazioni come le faccio a richiamare nel funnel?

**Fabrizio Mastracci:** nel funnel dovresti, cioè qua poi stiamo Esatto.

**Matteo Distaso:** Ci sono tipo condizioni, com'è che si chiama?

**Fabrizio Mastracci:** Devi devi costruire dei decision split si chiamano, dove praticamente vai a vedere,

**Matteo Distaso:** M.

**Fabrizio Mastracci:** ti prendi il tizio che ha fatto sulla prima mail e aggiungi il decision split e gli dici tipo "Mandamelo lì se ha cliccato là, piuttosto che mandamelo qua se ha cliccato in un'altra in un altro link.

**Matteo Distaso:** Ho capito, ho capito. E all'interno del funnel io posso assegnare dei tag che poi ritrovo nel CRM?

  
  

### **00:58:54**

  

**Fabrizio Mastracci:** Allora, sì, diciamo sì, lo puoi fare sicuramente qua poi dovremmo farci una proprio una sessione a parte per vedere questa cosa.

**Matteo Distaso:** Mhm.

**Fabrizio Mastracci:** Eh sì, cioè tu poi, che ne so, dici "Ok, facciamo un esempio rispetto a quello che ci siamo detti prima".

**Matteo Distaso:** Ah.

**Fabrizio Mastracci:** Tu hai visto che eh usiamo Sabatino sempre come esempio ha cliccato corsi, quindi tu dopo che hai cliccato corsi e che gli hai mandato la mail sui corsi vuoi aggiungere sul CRM un'informazione in cui tipo interessi sabatino, aggiungi corsi. Facciamo un caso tutto è così, no?

**Matteo Distaso:** Sì,

**Fabrizio Mastracci:** Ok. Sì, si può fare. Si può fermo.

**Matteo Distaso:** perfetto. Andiamo avanti. Ok.

**Fabrizio Mastracci:** Ok, allora io procedo a mandarti il test, dato che sono un attimo in condivisione, ti chiedo giusto conferma sulla mail. Allora, andiamo su sempre il giro di invita evento. La mail che ho messo è questa qui. Matteo gmail.com, quindi procedo.

**Matteo Distaso:** Eh sì, sì, stavo il microfono chiuso. Ok.

**Fabrizio Mastracci:** Ah, tranquillo. qui e poi di nuovo.

  
  

### **01:00:34**

  

**Fabrizio Mastracci:** Adesso fra qualche istante ti arriverà la mail con quella mail che ha visto.

**Matteo Distaso:** Vediamo. È arrivato edizione Cameria

**Fabrizio Mastracci:** Arrivata.

**Matteo Distaso:** Venditori 2006. Completa i dati. Ottieni biglietti. Vado.

**Fabrizio Mastracci:** Sì, sì,

**Elena Spini:** Sì,

**Fabrizio Mastracci:** io non vedo che stai facendo,

**Elena Spini:** per favore,

**Fabrizio Mastracci:** però qualsiasi cosa vai, senò ti arrivano mail.

**Elena Spini:** non compilare niente, per favore. Inizia solo a condividere se

**Fabrizio Mastracci:** Угуm.

**Elena Spini:** puoi.

**Matteo Distaso:** Devo condividere lo schermo.

**Elena Spini:** Sì. A chi ha ricevuto la mail?

**Matteo Distaso:** Allora, allora facciamo così, si vede Eh,

**Elena Spini:** Perfetto, accetta. Ora per questo test io vorrei farvi vedere la cosa del rinuncia se a meno che non volete fare altri test perché una volta che facciamo rinuncia poi rinunciamo tutto. Va bene?

**Matteo Distaso:** no, non abbiamo fatto quello prima.

**Elena Spini:** Ok. Perfetto. Ora a questo tasto rinuncia una volta che cliente arriva sulla pagina

**Matteo Distaso:** Ok.

**Elena Spini:** fa tasto rinuncia. Perfetto. Qua i biglietti sotto, quindi ha acquistato due biglietti, due biglietti sono rinunciati.

  
  

### **01:02:30**

  

**Elena Spini:** Quello che possiamo fare è anziché farvi vedere rinuncia registrata, ci mettiamo quel testo che avete voi per la rinuncia. E aspetta, com'era?

**Matteo Distaso:** Allora,

**Elena Spini:** Vediamo se questo,

**Matteo Distaso:** chiedo due cose.

**Elena Spini:** aspetta, scusa, te lo mando. Questo qua lo possiamo mettere. Mettiamo il testo. Aspetta, rinuncio all'evento.

**Matteo Distaso:** Mamma mia\!

**Elena Spini:** Poi se ci fate sapere se effettivamente è così, lo aggiungiamo per il prossimo test.

**Matteo Distaso:** Allora, chiedo due robe. Roba numero uno.

**Elena Spini:** L'ho messo in chat, scusa. Eh, rinuncia all'evento. Ti confermiamo di aver ricevuto la tua richiesta di rinuncia alla partecipazione dell'evento. Va ba va.

**Matteo Distaso:** può mettere su questo tasto un po' che dice "Stai rinunciando in maniera irreversibile. Sei veramente sicuro?

**Elena Spini:** Aurel, se vuoi ti faccio il recup.

**Aurel mrruku:** Sì, sì, stavo seguendo. Sì, si può fare come tipo anche facciamo un double check. Sì, sì,

**Matteo Distaso:** Esatto.

**Aurel mrruku:** si può fare.

**Matteo Distaso:** Siccome te prima avanza l'ipotesi che questi cliccano su rinuncia per sbaglio, io lo metterei la rinuncia irreversibilit

  
  

### **01:03:57**

  

**Elena Spini:** Va bene,

**Aurel mrruku:** Non intendevo qua.

**Elena Spini:** Rebecca.

**Aurel mrruku:** Non intendevo qua le rinuncia per sbaglio. E qua possiamo giusto.

**Matteo Distaso:** mail uno, anche se schiaccia non ce ne frega niente,

**Elena Spini:** Sì.

**Matteo Distaso:** tanto finisce lì.

**Elena Spini:** No, diceva sempre nell'ipotesi tua iniziale di rinunciare a tutto da una

**Matteo Distaso:** Ok,

**Elena Spini:** mail.

**Aurel mrruku:** Qua si può fare tutto praticamente perché qua abbiamo un un gestione real time sui dati

**Elena Spini:** Ok.

**Aurel mrruku:** che sono su CRM perché questa è una pagina di CRM.

**Matteo Distaso:** allora qua andiamo a mettere il double check,

**Aurel mrruku:** M.

**Matteo Distaso:** mettiamo un bel pop-up che dice "La rinuncia è definitiva". Sei veramente sicuro? Perché ho schiacciato e avviene troppo in fretta sta rinuncia. Magari uno schiaccia per sbaglio e via. Poi il tasto si può fare un po' più grande o eh lo

**Elena Spini:** Certo,

**Matteo Distaso:** allarghiamo,

**Elena Spini:** f grande quanto volete.

**Matteo Distaso:** lo allarghiamo un attimo perché è un po' piccolo.

**Elena Spini:** Rispondo Aurel. Ma sì.

**Aurel mrruku:** Si può è completamente è tutta custom questa pagina, quindi possiamo fare tutto quello che serve.

  
  

### **01:05:15**

  

**Aurel mrruku:** Ovviamente deve avere anche un una forma,

**Fabrizio Mastracci:** Outro.

**Aurel mrruku:** un contenuto,

**Matteo Distaso:** C

**Aurel mrruku:** un deve essere anche piacevole a vederlo. Troppo grande. Non so, possiamo anche fare un degli esempi agli automobile.

**Elena Spini:** E pensate anche a livello di di mobile.

**Aurel mrruku:** E

**Elena Spini:** Esatto.

**Matteo Distaso:** Sì, vediamo se me lo fa No, non me lo fa vedere perché abbiamo schiacciato.

**Elena Spini:** No, però c'è Oddio, stai usando è un match,

**Aurel mrruku:** no, ha già ha già rinunciato, non lo può vedere il

**Elena Spini:** no? Sì, volevo vedere la pagina come si vedeva comunque da visualizzazione mobile.

**Matteo Distaso:** Non c'avete un template per da far vedere?

**Aurel mrruku:** Ah, tasto destro, tasto destro, inspezione.

**Elena Spini:** M.

**Matteo Distaso:** No, faccio così. così e rinuncia sta qua dove c'è

**Elena Spini:** Esatto.

**Aurel mrruku:** Sì,

**Matteo Distaso:** il verde,

**Aurel mrruku:** sì, sì,

**Matteo Distaso:** giusto?

**Aurel mrruku:** sì, sì. Un po' sì, forse c'ho qualcosa in in ambiente di ti faccio vedere.

**Matteo Distaso:** Ok, andiamo avanti. Chiudo.

**Elena Spini:** Ok, quindi in realtà i due flussi sono questi.

  
  

### **01:06:58**

  

**Elena Spini:** Se vogliamo spendere un attimo del tempo per, dato che abbiamo ancora tempo per vedere le logiche del flusso, Fabrizio o avevi già detto tutto prima?

**Fabrizio Mastracci:** Avevo già dette all'inizio.

**Elena Spini:** Cosa?

**Fabrizio Mastracci:** Le avevo già dette all'inizio. Ja.

**Elena Spini:** La la cosa anche di da dove vengono presi i dati i famosi CF che

**Rebecca Marmo:** Ma

**Elena Spini:** diceva Rebecca. Li avete già visti tutti?

**Matteo Distaso:** Bello.

**Rebecca Marmo:** e io non li ho visti,

**Matteo Distaso:** Ja.

**Rebecca Marmo:** cioè si possono vedere anche tutti quei campi che andava a compilare. c'è stato un passaggio tutto.

**Elena Spini:** Esatto. Ok, guardiamo questa cosa qua. Quindi dove sono i tuoi CF adesso? Ok, quindi ricordiamoci sempre che in Sales Force adesso esistono due tipologie di campagne: campagna evento e campagna edizione. Campagna evento è il contenitore di tutte le edizioni. Edizione è l'edizione specifica

**Rebecca Marmo:** Sì,

**Elena Spini:** tipo cameriere venditore 2026.

**Rebecca Marmo:** sì.

**Elena Spini:** Ok.

**Rebecca Marmo:** Let.

**Fabrizio Mastracci:** Allora,

**Elena Spini:** Vai.

**Fabrizio Mastracci:** qui sicuramente qualche campo, secondo me, si dovrà mettere a schermo, su che almeno abbiamo già qualcosa.

  
  

### **01:08:27**

  

**Elena Spini:** No, sì, infatti. Vai direttamente dall'app e oddio, che poi non abbiamo già portato tutto. Penso di sì. Sì, perché sennò non potevi fare i test. Vai.

**Fabrizio Mastracci:** Allora, fondamentalmente i campi che devi inserire sono, vabbè, la campagna parent, queste cose di, diciamo, di di data model, però obbligatorio, qui lo metteremo obbligatorio, c'è il weight interval innanzitutto che è praticamente il campo

**Rebecca Marmo:** Ma ti posso fermare un attimo? questo interval e quindi è uguale tra un invio e l'altro, è sempre due.

**Fabrizio Mastracci:** No, no, adesso abbiamo creato una campagna di testa,

**Rebecca Marmo:** Ah, ok.

**Fabrizio Mastracci:** abbiamo messo due, però poi tu questo te lo metterò obbligatorio, così non ti sbagli. Anzi, ti direi proprio che i campi sulla campagna che poi vanno sulla mail li andiamo a mettere obbligatori in modo tale che poi quando li vai a compilare non non ci sono,

**Rebecca Marmo:** Ah, ok.

**Fabrizio Mastracci:** diciamo così.

**Rebecca Marmo:** Perché? Perché, ad esempio, io dalla prima alla seconda mail passano due giorni, dalla terza alla quarta cinque,

**Fabrizio Mastracci:** Esatto, esatto.

  
  

### **01:09:37**

  

**Rebecca Marmo:** cioè variano.

**Fabrizio Mastracci:** Se io Esatto.

**Rebecca Marmo:** Ok.

**Fabrizio Mastracci:** Se io poi se tu domani ti vuoi creare una nuova campagna che è edizione Camerieri 2027, eh l'anno scorso, quest'anno, scusami avevate fatto due, tu la crei col tre e quindi a quel punto quando questo campo sarà su tre la manda ogni tre giorni.

**Rebecca Marmo:** No, no, io voglio m per l'edizione camerieri venditori 2026. Ok, questa edizione io ho 11 invii, ok?

**Fabrizio Mastracci:** E

**Rebecca Marmo:** Oggi c'è il primo invio, metto un'attesa di due, dopodomani c'è il secondo e dal secondo al terzo sono altri 5 giorni, cioè varia il weight tra un invio e l'altro.

**Fabrizio Mastracci:** quello e allora devi, cioè quello lì se è una cosa che cambi poi a seconda degli eventi, devi modificarlo ogni tot.

**Rebecca Marmo:** Quindi io ogni tot giorno vado a modificare il weight qui nell'edizione,

**Fabrizio Mastracci:** Esatto, esatto. Cioè,

**Rebecca Marmo:** cioè devo farlo manuale.

**Fabrizio Mastracci:** se ti Eh,

**Rebecca Marmo:** Alo.

**Fabrizio Mastracci:** sì, eh, cioè la macchina recepisce le informazioni che tu gli metti dentro, per cui se se tu vuoi mettere 3 giorni lasci 3 giorni, poi se un giorno vuoi cambiarlo a 5 se cioè se non metti questa informazione il flusso non lo capisce.

  
  

### **01:10:50**

  

**Rebecca Marmo:** Quindi io mi devo ricordare ogni tot giorni di andarlo a modificare. Posso metterlo nel funnel, un weight tra un via e l'altro perché così diventa macchinoso.

**Fabrizio Mastracci:** Eh no, non puoi farlo.

**Matteo Distaso:** i denti.

**Sabatino Rinaldi:** Cè, però aspettate un attimo. Sì. E noi non possiamo fare un funnel dove decidiamo il weight che diamo a degli invii.

**Fabrizio Mastracci:** Se volete, cioè potete potete fare quello,

**Rebecca Marmo:** Eh,

**Fabrizio Mastracci:** ma poi quel flusso questo qui che vi ho fatto vedere voi dovete modificarlo ogni volta.

**Rebecca Marmo:** Saba, io non posso fare più inviverso, cioè non posso inviare la prima mail, aspettare due giorni, arriva la seconda e dalla seconda alla terza 5 e sempre due. Eh,

**Fabrizio Mastracci:** No,

**Matteo Distaso:** Quello è quello che imposti automatico,

**Fabrizio Mastracci:** se lo canto

**Matteo Distaso:** forse.

**Rebecca Marmo:** eh.

**Matteo Distaso:** Ma c'ha una funzionalità nel funnel?

**Rebecca Marmo:** É.

**Matteo Distaso:** Un weight interno ci sarà. Sì.

**Fabrizio Mastracci:** wet interno c'è, però il problema è questo che poi se tu se così G in questo modo lo puoi cambiare Perché in quel in quel modo è dinamico.

  
  

### **01:12:09**

  

**Fabrizio Mastracci:** Se tu vai a mettere il weight interno, tipo parliamo un attimo su marketing cloud. Ah, vabbè, prendiamo Ecco qua questo qui tipo aggiungiamo weight. Se tu metti per esempio amount of time, che adesso non me lo fa mettere perché è un temp, ma scegliamo tipo questo qui che volete fare voi e mettere 5 C. A parte il fatto che ogni volta devi duplicarti una versione di quel journey e ehm per così dire rimettere sempre mano dentro a quel flusso di 11 mail con un loop che aggiorna ogni video o più uno. Quindi è una cosa anche molto complessa, devi andare a aggiungere 11 weight diversi e poi se scegli weight amount of time, che è quello che vi serve, poi cioè capite che rimane fisso, cioè dovete andare a modificarlo ogni volta, non è una cosa così semplice, cioè è molto più gestibile da un campo della campagna. Ok,

**Sabatino Rinaldi:** Sì, però questo poi diventa, cioè, per come ci hai fatto vedere tu,

**Fabrizio Mastracci:** allora facciamo un esempio.

**Sabatino Rinaldi:** diventa No, no, no, aspetta,

**Fabrizio Mastracci:** Poi

  
  

### **01:14:53**

  

**Sabatino Rinaldi:** sto ragionando con te, eh, non ti sto dicendo che è sbagliato, è capire insieme, perché voi avete la vostra soluzione, noi abbiamo i nostri processi. Poi, essendo noi un'azienda che fa marketing, noi abbiamo bisogno di tutta la flessibilità di sto mondo, perché io, se mi voglio inventare una roba all'improvviso,

**Fabrizio Mastracci:** Ok,

**Sabatino Rinaldi:** non posso avere blocchi dal sistema, io devo essere libero di fare quello che voglio. Questa è la nostra necessità,

**Fabrizio Mastracci:** ok,

**Sabatino Rinaldi:** soprattutto in marketing cloud,

**Fabrizio Mastracci:** facci.

**Sabatino Rinaldi:** che è la cosa che deve essere più custom possibile.

**Fabrizio Mastracci:** Ok, facciamo un esempio. Allora, se io un vostro invio specifico, ok, voi dalla vostra vecchia, diciamo, piattaforma, quella che avete dismesso, immagino quindi che mandavate un flusso con 11 mail, partiva, cioè, cioè sceglievate 3 5 6 7 8 e così via il wait e poi lo facevate partire, giusto?

**Sabatino Rinaldi:** Esatto. Tu parti da un trigger, mandi una mail a quella mail, poi metti un weight di boh, 3 giorni, mandi un'altra mail a quell'altra mail, poi metti un weight di altri cinque, eccetera.

  
  

### **01:16:00**

  

**Sabatino Rinaldi:** Ogni nodo, ogni mail, ad ogni mail seguiva poi un weight, poi arrivava un'altra mail con un altro weight, un altro weight, eccetera. C in generale

**Fabrizio Mastracci:** Va bene. Allora, se io vi facessi un campo dove voi mettete tutti e 11 di weight, ok? li selezionate subito e poi quelli però una volta attivata la campagna non parte, cioè non sono più modificabili. Vi va bene?

**Sabatino Rinaldi:** Cioè, cioè tu dici creare una campagna già con dei weight prestabiliti e qualora

**Fabrizio Mastracci:** Esatto.

**Sabatino Rinaldi:** quei weight li vogliamo modificare, qualora volessimo modificare quei weight una volta stabiliti, dobbiamo duplicare la campagna e crearne un'altra per modificarli. Non possiamo modificare quella esistente.

**Aurel mrruku:** Ti dico già Sabatinoche duplicare la campagna è proprio sbagliato.

**Sabatino Rinaldi:** No, no, scusa, perché voi usate altri nomi. Duplicare il journey.

**Aurel mrruku:** Ok.

**Fabrizio Mastracci:** Cioè tu fa un altro invio.

**Aurel mrruku:** M.

**Fabrizio Mastracci:** Ok. chiamiamoli invi un altro flusso di di marketing

**Sabatino Rinaldi:** Ok, un altro flusso. Dobbiamo creare un altro flusso.

**Fabrizio Mastracci:** e no perché cioè qui è pure da capire che voi state facendo una cosa che in teoria deve essere il quanto più automatica possibile, quindi cioè io vi modifico questa cosa così,

  
  

### **01:17:18**

  

**Sabatino Rinaldi:** C.

**Fabrizio Mastracci:** però poi voi poi una volta settati i campi su una campagna e andate a modificare ilight su quella specifica campagna, poi questa cosa avrà impatto anche su un'altra campagna. Capito che voglio dirti?

**Sabatino Rinaldi:** Sì.

**Rebecca Marmo:** Ah.

**Sabatino Rinaldi:** E vabbè.

**Rebecca Marmo:** M.

**Sabatino Rinaldi:** Eh, allora la soluzione che ci hai dato ora di poter decidere noi tutti i weight per ogni singolo invio eh prima di lanciare la campagna potrebbe essere valida. Non so cosa ne pensa Rebecca poi, dato che lo fa lei, però

**Rebecca Marmo:** Ma io non ho capito se io nel mh mi trovo in una situazione in cui ho attivi due ehm funnel. Yeah. Dimmi perché ho paura di aver capito male.

**Fabrizio Mastracci:** Sì,

**Rebecca Marmo:** I devono essere gli stessi,

**Fabrizio Mastracci:** no, devono essere possono essere diversi,

**Rebecca Marmo:** eh? No.

**Fabrizio Mastracci:** però poi, cioè occhio a modificare i vari i vari weight. Io ripeto, vi aggiungo questa cosa, però poi qui mi fermo, cioè oltre questo non credo che posso fare altro.

**Rebecca Marmo:** Perché io ti spiego, io quando programmo l'invio dei biglietti, weight me li calcolo io, guardo la il calendario e me li calcolo io a mano, cioè una cosa che faccio io manualmente quando imposto il funnel.

  
  

### **01:18:46**

  

**Rebecca Marmo:** I weight li cambio ogni volta, poi attivo la campagna e la lascio andare, cioè la campagna, il funnel e lo lascio andare per i weight che io mi sono impostata

**Fabrizio Mastracci:** Dobbiamo trovare

**Rebecca Marmo:** e cambiano ogni volta da evento perché magari non so il sabato preferisco non inviare comunicazioni, preferisco il venerdì, cioè lì è a preferenza nostra.

**Elena Spini:** E scusa Fabrizio,

**Rebecca Marmo:** M.

**Elena Spini:** ma non so se è quello che hai detto prima, ma non possiamo fare, cioè tu hai fatto si chiamava quel campo? Wait,

**Fabrizio Mastracci:** Allora,

**Elena Spini:** scusa, questo aspetta,

**Fabrizio Mastracci:** lo dico a livello tecnico questo è un campo formula,

**Elena Spini:** aspetta, aspetta, aspetta.

**Fabrizio Mastracci:** cioè è un campo formula che aspetta che converte un numero in data. Ok. E poi la la la stessa formula io devo praticamente sommarla alla data di ingresso del record. Quindi di fatto io devo creare una formula che si basa su n campi dove dico al primo invio 2 giorni,

**Rebecca Marmo:** Sì.

**Fabrizio Mastracci:** al secondo invio ci sarà un altro weight interval che cambia di 5 giorni, quindi modifica la formula lì.

  
  

### **01:19:56**

  

**Fabrizio Mastracci:** Cioè, capisci che è una cosa molto complessa. Io ripeto, posso lavorarci, però mi rendo conto, cioè spero vi rendi conto che è una cosa che è una bel cambio questa cosa sotto.

**Aurel mrruku:** Posso?

**Sabatino Rinaldi:** Io purtroppo non riesco a capire la,

**Aurel mrruku:** No,

**Sabatino Rinaldi:** cioè non lo so,

**Aurel mrruku:** ma penso

**Sabatino Rinaldi:** non riesco a capire la difficoltà nel di creare un funnel del genere.

**Elena Spini:** Dai, Aurel.

**Sabatino Rinaldi:** M m vai.

**Aurel mrruku:** posso allora e se invece quando creiamo la campagna di Sales Force vi creo un oggetto, quindi dei record, in automatico vi creo 11 record che come inizio vi va vi faccio una divisione automatica da 2 giorni,

**Sabatino Rinaldi:** Ка.

**Aurel mrruku:** 5 giorni, decidiamo. E poi chi gestisce la campagna viene su questi 11 record che sarebbero praticamente le 11 date e li compila a mano, quindi li aggiorna a mano e poi te Fabrizio prendi D.

**Fabrizio Mastracci:** Ok.

**Aurel mrruku:** Ovviamente questi record saranno weight 1, weight 2, weight fino a weight 11 e ciascuna avrà una data che molto probalmente Rebeccafarà a mano e tu ti prendi direttamente il dato dal oggetto che è legato a quella campagna.

  
  

### **01:21:27**

  

**Aurel mrruku:** Ti andrebbe bene?

**Fabrizio Mastracci:** Sì, meglio.

**Aurel mrruku:** Così diamo la possibilità di cambiare queste date in modo dinamico, decidere queste date nel momento in cui decidono la campagna, quindi nel momento in cui creano la campagna. Ovviamente poi sarà compito di Rebecca o chi gestirà le campagne di popolare queste date in modo corretto. Eh, Rebecca, ti torna perché

**Rebecca Marmo:** Sì.

**Aurel mrruku:** facendo così diamo sia la possibilità di avere queste date in modo dinamico nel momento in si crea la campagna, ma anche di non dover cambiare il journey ogni volta che voi cambiare una data. Ti weight intendo.

**Rebecca Marmo:** Perché come funzionerebbe senò?

**Aurel mrruku:** E ovviamente eh

**Rebecca Marmo:** Cioè cambiare il giorno ogni volta che vuoi,

**Aurel mrruku:** se che vuoi cambiare wait e manca Fabrizio

**Rebecca Marmo:** però io creo io creo un journey per ogni edizione.

**Fabrizio Mastracci:** No,

**Rebecca Marmo:** Nie.

**Fabrizio Mastracci:** la finestra quello che ti vuole dire dove devi inserire le date e quelli sono gli weight che vado a leggere io. Il giorno rimane identico. Ti va bene?

**Rebecca Marmo:** Me lo potete far vedere perché io così non riesco a capire.

  
  

### **01:22:49**

  

**Rebecca Marmo:** M.

**Fabrizio Mastracci:** Allora, immagina, sono ancora a schermo. Immagina, ok, che qui tu hai la campagna, scusate, preso quella sbagliata. Tu qua avrai eh qui in questo caso è fisso, cioè nel senso è fisso, è uno solo che devi cambiarlo,

**Aurel mrruku:** Eh,

**Fabrizio Mastracci:** ne hai 11 dove metti

**Aurel mrruku:** fai così, eh, Fabrizio, ti chiedo forse più facile. Vai sulla vai sulla sales, vai sulla campagna e crei 11 task o cinque task e nei task metti solo la data. Usiamo il tas giusto per farti vedere, ma sarà un oggetto custom, quindi vai sulla tua campagna e deve essere suftivity per il momento dei task a destra o no? Ce li hai a destra.

**Fabrizio Mastracci:** Dove vado?

**Aurel mrruku:** A destra c'hai la possibilità di fare de dei task

**Sabatino Rinaldi:** Ok.

**Aurel mrruku:** e a destra dove ci sono le activity qui a

**Fabrizio Mastracci:** Sì,

**Aurel mrruku:** destra c'è ci sono i task.

**Fabrizio Mastracci:** questa.

**Aurel mrruku:** Sì, crea crea crea dei task. Ovviamente qua questo oggetto è standard, non usiamo questo. Non usare call, scrivi weight 1.

  
  

### **01:24:30**

  

**Fabrizio Mastracci:** Ok. Ok.

**Aurel mrruku:** Ovviamente questi nomi saranno tutti standard e la data c'è sotto. Poi assign non servirà neanche la relazione già e fai save. Adesso crei task 2 e metto un'altra data. Chiamalo way 2 e metto un'altra data. Quindi io nel momento in cui tu apri la campag tu generi la campagna, in automatico ti creo 11 weight e poi devi arrivare su questi record qua. Vai su weight 1, vai su weight 1, clicca e qua devi praticamente met cambiare la data. Quindi dove c'è la data due date, ma non sarà due date,

**Rebecca Marmo:** Ah,

**Aurel mrruku:** sarà in italiano data journey non giornata come l'hai chiamato?

**Rebecca Marmo:** invio uno.

**Aurel mrruku:** invio uno,

**Elena Spini:** Remander.

**Rebecca Marmo:** Ma quindi io qui inserisco la data,

**Elena Spini:** Vai

**Rebecca Marmo:** non i giorni di stop,

**Aurel mrruku:** infatti inserisci la data, quindi inserisci le date precise e lui per ogni flusso andrà a leggere il nome del weight, quindi weight 1, e va a prendere la data che tu hai configurato nel weight 1 di quella campagna.

  
  

### **01:25:58**

  

**Rebecca Marmo:** Però qui se io seleziono la data 16 ottobre, ok, per l'invio della seconda mail, quindi invio la prima, poi il 16 invio la seconda,

**Aurel mrruku:** Sì.

**Rebecca Marmo:** metti conto che è partito.

**Aurel mrruku:** A I

**Rebecca Marmo:** Ok. Ok. E se una persona entra nel funnel il 20 ottobre e il 1 vede il Sic.

**Fabrizio Mastracci:** Lei Aurelare numero. Lei vuole il numero. Per capirci vuole anziché du date 1 mette 2, weight 2 mette 5, weight 3 mette 8. Capito? Tu mi puoi fare comunque.

**Aurel mrruku:** Anche quello. Sì, sì, sì,

**Rebecca Marmo:** Io voglio giorni di attesa perché la data così ho paura che vada

**Aurel mrruku:** sì, sì, sì. Ho capito, ho capito, ho capito. Ok,

**Rebecca Marmo:** Да,

**Aurel mrruku:** quindi dalla Ok. Sì, sì, si può fare, si può fare.

**Elena Spini:** dall'entrata del giorni giorni di attesa.

**Aurel mrruku:** E è la Non metti you date,

**Elena Spini:** M.

**Aurel mrruku:** metti il numero all'inizio tutto due, poi tu puoi entrare qua e mettere 3 C. Per me non è nessun non ha problema.

  
  

### **01:27:05**

  

**Aurel mrruku:** Eh, invece per te Fabrizio, hai modo di Sì, penso di sì.

**Fabrizio Mastracci:** E devo fare 11 volte una formula in cui il primo il

**Rebecca Marmo:** Mh. Ma io

**Fabrizio Mastracci:** primo weight Un eh calcola numero più data. Però sì, va bene, dai. fammi con il numero e poi

**Elena Spini:** Ma eh io chiedo,

**Rebecca Marmo:** Ma io ho una domanda.

**Elena Spini:** scusa.

**Rebecca Marmo:** Questi task poi li devo creare io ogni volta queste cose

**Aurel mrruku:** In automatico vanno creati tutti,

**Rebecca Marmo:** qui?

**Aurel mrruku:** per esempio, con weight di due e poi li puoi modificare.

**Rebecca Marmo:** E se e se io ho un journey con non 11 in B, ma quattro, perché può capitare, io posso andare

**Fabrizio Mastracci:** no. quello. Cioè, tu dici vuoi costruire un altro invio che non che es

**Rebecca Marmo:** Esatto,

**Fabrizio Mastracci:** dal No,

**Rebecca Marmo:** perché magari ci sono Sì.

**Fabrizio Mastracci:** in quel caso allora non cioè no, questo è solo per l'invio dei biglietti perché segue delle regole specifiche, poi in quel caso ti conviene costruire

**Rebecca Marmo:** No, no, ma io ho alcuni eventi per cui non ho 11 invi ma ho soltanto quattro invi, magari cinque e sono eventi più piccolini, esempio.

  
  

### **01:28:19**

  

**Rebecca Marmo:** E non ne faccio 11,

**Fabrizio Mastracci:** Ma noi Eh,

**Rebecca Marmo:** ne faccio meno.

**Fabrizio Mastracci:** ma noi abbiamo costruito il flusso su quello che ci hai indicato tu, cioè 11 in

**Rebecca Marmo:** Sì, però siccome potrebbe essere che per alcuni eventi ne faccio da meno, non è possibile avere flessibilità di invio, devo comunque farne 11, deve essere uguale per tutti.

**Fabrizio Mastracci:** quello il problema lì

**Elena Spini:** Posso provare a dire una cosa?

**Rebecca Marmo:** Ok.

**Elena Spini:** Allora, anziché creare questi record, ma non si possono creare 11 campi che Rebecca deve compilare per forza quando compila quando crea la campagna con i dati. 11, aspetta, 11 campi di cui, ad esempio, se non c'è il valore perché non è presente, ne compila solo quattro, allora i reminder si bloccano. Si può fare anziché andare su un oggetto custom per un numero?

**Fabrizio Mastracci:** Pera diceva che ci deve essere tipo il due di default,

**Aurel mrruku:** Так.

**Fabrizio Mastracci:** se può farlo. Devo aggiungere un'altra logica, però va bene.

**Elena Spini:** Cioè di default sono vuoti, ok? Perché poi Rebecca, cioè che poi in realtà, cioè Rebecca quando compila la campagna compilerà questi valori perché sa che campagna sta creando, quindi sa quali reminder sta mettendo.

  
  

### **01:29:51**

  

**Elena Spini:** No.

**Rebecca Marmo:** Ma non si può togliere questa attesa all'interno della campagna e metterla semplicemente nel nel journey?

**Fabrizio Mastracci:** Mh. No, perché è dinamica. Perché sennò devi fare ogni volta una versione di un journey e poi camerieri, eventi e venditori eh avranno lo stesso weight che può avere un un altro invio di un'altra campagna se mettere lo step quello di statico.

**Rebecca Marmo:** Cioè io come sto facendo adesso, io creo un journey per ogni edizione, quindi ho un giorno nei cameri venditori, un giorno nei Academy, eccetera eccetera.

**Fabrizio Mastracci:** Devi creare,

**Rebecca Marmo:** Ok?

**Fabrizio Mastracci:** se tu in questo caso creerai semplicemente la campagna e poi il

**Rebecca Marmo:** Ok,

**Fabrizio Mastracci:** journey manda in automatico, non devi creare volta un journey M.

**Rebecca Marmo:** quindi l'attesa è uguale per tutti, ovviamente è così, cioè nel senso il numero di di stop è uguale per tutti se la il giorn è solo uno per tutti gli edizioni.

**Elena Spini:** Però scusa,

**Rebecca Marmo:** Sì.

**Elena Spini:** eh, ma Fabrizio, cioè lei ti sta dicendo, eh, va bene, noi l'abbiamo fatto per 11, ma se un giorno lei vuole fare quattro reminder, lei disattiva quel giorno,

  
  

### **01:31:13**

  

**Fabrizio Mastracci:** e fare secondo.

**Elena Spini:** aspetta, aspetta, disattiva quel giorni da 11, si fa una copia di un altro giorni con quattro reminder.

**Fabrizio Mastracci:** Ma Elena,

**Rebecca Marmo:** Sì. M.

**Fabrizio Mastracci:** quel giorney non è che legge la campagna X, poi lei deve andare a modificare ogni volta i criteri di accesso della campagna, ok? In questo caso quel jour Journey come puntamento utilizza la creazione o la modifica degli inviti evento, che è un'altra cosa. Quindi si deve fare praticamente un altro journey ancora con un'altra logica. Ok? Secondo me vogliamo fare questa cosa. Ok, avevamo capito, avevamo c'era stato scritto che era da 11. Facciamo esattamente un misto, un ibrido da quello che stava dicendo Aurel e quello che stavi dicendo tu. Schermata iniziale dove hai un massimo di 11 campi che devi compilare tu, quindi 1 2 3 4 eccetera. Dove non li compili vuol dire che il valore è assente e quindi l'invio della mail non parte. Quindi, chiaramente quando crei una campagna, se hai 11 invii tu compili tutti e 11 campi con i valori deway.

  
  

### **01:32:32**

  

**Fabrizio Mastracci:** Se ne hai cinque, ne compili cinque e dopo al sesto invo, siccome è vuoto il sesto campo, va fuori.

**Rebecca Marmo:** Oke.

**Elena Spini:** E tu riesci a fare queste logiche all'interno di quel flusso?

**Fabrizio Mastracci:** Eh sì, però è, cioè capisci che non è una cosa, cioè io prima di tutto sicuramente dipendo da Aurel che deve fare e deve portare in produzione una cosa che è, non so quanto possa essere oneroso per lui e poi io devo ristravolgere.

**Elena Spini:** Scusa, cosa deve portare i campi, giusto?

**Aurel mrruku:** Non solo Elena.

**Fabrizio Mastracci:** Eh sì,

**Aurel mrruku:** Dobbiamo anche capire questi campi quando possono essere modifi.

**Fabrizio Mastracci:** c'è

**Aurel mrruku:** abili permessi da capire chi lo deve fare questa cosa,

**Elena Spini:** Eh,

**Aurel mrruku:** perché le campagne in teoria rebecca oggi Sì,

**Elena Spini:** parliamo di Sì, lo so, però parliamo dei campi adesso.

**Aurel mrruku:** sì, quello lo faccio,

**Elena Spini:** Ok,

**Aurel mrruku:** lo facciamo nel quando sarà il il rilascio in produzione, non è un problema.

**Elena Spini:** capiamo se effettivamente soprattutto ha senso questa cosa. per voi così vi va bene? Perché veramente, cioè, non è una modifica semplice, come potete capire, e soprattutto avevamo provato a scrivervi in tutti i modi qual erano le logiche e m ci troviamo sempre a ridosso di tutto a fare delle modifiche, quindi se vi va bene lo facciamo così, però cioè pensate a tutte le casistiche Perché questa cosa dei weight eh è uscita al 16 di ottobre,

  
  

### **01:34:14**

  

**Elena Spini:** quindi provo a riformulare il concetto. Stiamo dicendo

**Sabatino Rinaldi:** No, aspetta Elena, facciamo così. Io ho capito tutto questa cosa qui che avete detto, non è che non ho capito. La domanda che mi sto ponendo è un'altra. Questa modalità eh che di cui abbiamo parlato fino ad ora con questa soluzione che abbiamo trovato fino ad ora è collegata al fatto che noi generiamo questo funnel collegato in realtà alla campagna, quindi alla campagna evento edizione, ok? Ok?

**Elena Spini:** Sì.

**Sabatino Rinaldi:** Ma e questa è una strada, una seconda strada non potrebbe semplicemente essere che noi non ragioniamo secondo questa logica collegata alla campagna, ma secondo te la faccio come la facciamo ora, no? Noi ora come facciamo?

**Fabrizio Mastracci:** Oh.

**Sabatino Rinaldi:** un funnel che quindi ci permette di decidere noi un come se fosse un semplicissimo funnel di marketing dove decidiamo noi i tempi, le robe, cosa fare, cosa non fare, che abbiamo questa lista di tutti eh tutte le persone che hanno diritto ad avere l'asset che ce la portiamo in marketing cloud e in marketing cloud creiamo un fanel a partire da questa lista piuttosto che collegarci a quest alla campagna.

  
  

### **01:35:41**

  

**Sabatino Rinaldi:** e quindi abbiamo più dinamicità, più flessibilità. Chiedo se è così come dico o no, perché così non dipendiamo da la campagna creata all'interno del CRM da portare poi con Marketing Cloud.

**Elena Spini:** Ma Sabatino, cioè la parte dell'asset e di tutte le logiche, legate ai biglietti. E non è semplicemente una campagna, ci sono tutte logiche dietro che vanno a seguire gli ordini, i pagamenti, le tranche, eh questi reminder che abbiamo visto adesso, cioè non è così semplice, ci sono tutte logiche dietro questi oggetti. Mh,

**Sabatino Rinaldi:** Madonna.

**Elena Spini:** quindi no, purtroppo non è così semplice perché cioè abbiamo costruito tutto il processo dietro.

**Sabatino Rinaldi:** Sì. Eh,

**Rebecca Marmo:** Io pensavo di essere stata abbastanza chiara nella mail degli

**Sabatino Rinaldi:** è Ok.

**Rebecca Marmo:** 11 invi in cui il tempo non è fisso, però a quanto pare non è stato chiaro. Cioè che dire?

**Fabrizio Mastracci:** Rebecca,io ti ho mandato una mail dove ti ho chiesto conferma delle logiche

**Sabatino Rinaldi:** Es.

**Rebecca Marmo:** E io che sono 11 comunicazione e tra uno step e il successivo il tempo di attesa non è fisso, ma varia 2 3 4 5 6 7 8 giorni.

  
  

### **01:37:13**

  

**Rebecca Marmo:** Yeah.

**Fabrizio Mastracci:** e te ne ho mandato un'ulteriore mail dove ti ho riassunto le logiche

**Elena Spini:** Indipendentemente da tutte le scambio di mail, direi ehm cerchiamo di

**Sabatino Rinaldi:** No, a me che è l'unica io purtroppo

**Elena Spini:** portare a casa il il punto di oggi, quindi come possiamo trovare la quadra di tutto questo? Vi andrebbe bene se in fase di creazione della dell'evento, scusa, dell'edizione bisogna mettere questi weight. Ha senso? Wait,

**Elisa Migliano:** Ma Elena,

**Elena Spini:** che abbiamo detto che possono essere 12 o no,

**Elisa Migliano:** scusami, eh, dobbiamo decidere adesso oppure eventualmente,

**Elena Spini:** scusa. 12.

**Elisa Migliano:** visto che, come ti abbiamo anticipato, oggi pomeriggio abbiamo una riunione interna per decidere queste cose,

**Elena Spini:** No, no,

**Elisa Migliano:** eventualmente ti possiamo far sapere anche oggi pomeriggio?

**Elena Spini:** eh chiaro, chiaro. Non dovete dire decidere assolutamente niente. Adesso vorrei solo capire se effettivamente questa soluzione eh può avere più o meno senso e può essere in una quadra.

**Elisa Migliano:** Ok, ok, ok.

**Elena Spini:** Quindi provo a ripeterla. Allora, non mi è chiaro.

  
  

### **01:38:24**

  

**Elena Spini:** Mh, punto uno in cui bisogna eh sicuramente mh capire meglio in quale momento m della se in fase di creazione dell'edizione o in un secondo momento la Rebecca di turno o non so chi per lei va a mettere questi weight. Ma al netto di questo facciamo che in un determinato momento da definire c'è ci sarà la possibilità di indicare a livello di edizione 11 reminder, 12 reminder, capiamo, ne possiamo mettere anche 15, in cui viene detto quanti giorni devi aspettare tra un weight e l'altro di reminder che andiamo a mandare, quelli tutti che si cambiano che ha detto Rebecca che poi in base al calendario decide quando mandare. Una volta che vengono compilati questi weight, se se questi weight vengono compilati tutti, li rispettiamo tutti nel flusso e Fabrizio farà le logiche. Se ne invece vengono compilati quattro perché è un evento piccolino, allora il flusso ragionerà per weight, quattro weight. Ora, la differenza rispetto a quello che fate adesso praticamente è il flusso è uno e uno solo, che è quello che ha fatto Fabrizio con tutte le logiche. Invece quello che cambia di volta in volta per edizione è la configurazione dell'oggetto edizione a livello di CRM.

  
  

### **01:39:58**

  

**Elena Spini:** Chiedo adesso ai ragazzi di Romi, ho detto giusto? Mi son persa qualcosa? Ok,

**Fabrizio Mastracci:** Pretto.

**Elena Spini:** pensate se questo può avere senso come soluzione, perché purtroppo eh fare quello che chiedeva Sabatino non è così per tutto quello che abbiamo fatto con Elisae Fabrizio rispetto alle logiche

**Sabatino Rinaldi:** No, no,

**Elena Spini:** di cosa succede Sì.

**Sabatino Rinaldi:** chiaro, ma io quelle logiche quelle logiche ce le ho chiarissime e sono stato in tutte le gole su quello, quindi lo so ed è giusto che sia così. A me quello che non riesco a a collegare è che mi sembra di essere in una scatola troppo chiusa in termini di collegamento tra il marketing e il CRM. Io ho bisogno di estrema flessibilità, cioè se devo fare una roba, voglio in qualche modo riuscire a farla, se voglio prendermi dal CRM tutti quelli che hanno gli asset disponibili, che quindi hanno fatto tutte le logiche che ci siam dette, io li voglio prendere e farci quello che mi pare. E non è che mi lo sto dicendo in modo nervoso,

  
  

### **01:41:08**

  

**Elena Spini:** Ma ma no,

**Fabrizio Mastracci:** Ora Grazie.

**Sabatino Rinaldi:** eh, è proprio un ragionamento.

**Elena Spini:** Ma questo lo puoi fare. Attenzione, ma lo puoi fare, però il il cioè tutto quello che hai nel CRM a livello di di record, tipo voglio prendermi tutti quelli che hanno partecipato a un evento, voglio prendermi tutti quelli che hanno pagato, lo puoi fare e potrai fare tutti gli invii che vuoi. Ma quello che diceva Fabrizio è che quel flusso per gli invii, quindi flusso uno e flusso due per gli invii dei biglietti sono

**Sabatino Rinaldi:** Sì.

**Elena Spini:** mh diciamo come se fossero configurati una

**Fabrizio Mastracci:** Так.

**Elena Spini:** volta per perché sotto ci sono tante logiche. Quindi, se poi tu invece vuoi fare mandare un'altra mail completamente diversa perché vuoi fare un'altra mail per non lo so, pienissimo live, ti prendi tutti i tuoi i tuoi i tuoi record che vuoi con delle logiche ci farai unra un'altra nuova mail, ma nello specifico quel flusso con quella landing page, con quelle logiche di assegnazione biglietto e quant'altro è un po' più delicato per il resto, cioè anzi Non sei in una scatola chiusa, hai puoi fare tutto quello che vuoi, ma non su questi due flussi che invece sono un po' più da prendere con la non che non sono scanditi sulla pietra, attenzione, però fate attenzione a fare modifiche qua perché in realtà non è solo marketing,

  
  

### **01:42:40**

  

**Elena Spini:** ma ci sono tante logiche sotto.

**Matteo Distaso:** Quindi il flusso biglietti è quello e non si cambia per tutti.

**Elena Spini:** Non ho detto così, ho detto che non è scandito sulla pietra, ma eventuali modifiche a questo flusso toccano tutto quello che abbiamo fatto sul CRM, quindi da prendere con le pinze. Perché ci sono tante logiche dietro, ma potete modificare e poi dipende da che cosa, cioè nel senso, fino a oggi era così ed è quello che abbiamo cercato, è quello che ci avete chiesto, quindi non so che cosa vorreste cambiare di altro.

**Sabatino Rinaldi:** No, è che semplicemente eh è così.

**Elena Spini:** Угу.

**Sabatino Rinaldi:** Eh, il problema è che oggi è così. Se tra due mesi ci passa nella testa che deve cambiare qualcosa per x motivi, bisogna capire che tipo di flessibilità abbiamo a cambiare determinate condizioni. Questo, cioè noi non ci mettiamo solo nell'ipotesi di ora, ok, troviamo la quadra adesso e la faccio semplice. Ad esempio, abbiamo deciso che sono 11 weight, ovviamente è un esempio, tra due mesi ci teniamo gli 11 weight, non sappiamo cosa può succedere.

  
  

### **01:44:09**

  

**Sabatino Rinaldi:** Ecco perché dobbiamo capire quanto siamo flessibili in questo tipo di modifiche. che io capisco quello che dici tu, eh, nel senso, non sto dicendo che che è sbagliato, ci sono delle logiche dietro, lo so benissimo, vanno rispettate per una serie di motivi, è chiaro. Ovvio è che nelle nostre condizioni ci dobbiamo anche mettere nei panni che ok, adesso siamo in test, ci siete voi, ce lo state configurando, lo stiamo testando, andremo in produzione, bene e se tra 9 mesi vogliamo svoltare il mondo del dell'invio biglietti e quindi noi dobbiamo fare in modo che tutto quello che stiamo facendo adesso con Sales Force tra 6 mesi non iniziamo a smantellarlo tutto e ritornare agli errori che abbiamo fatto fino ad ora ad avere un CRM che è un macello. Non, dato che non vogliamo fare questi errori, dobbiamo essere prudenti nelle scelte e capire tutte le condizioni che abbiamo, perché altrimenti ritorniamo che ora è tutto bello, tra 9 mesi abbiamo un CRM come ce l'abbiamo ora, che è un mondezzaio di roba dove per risolvere i problemi del momento abbiamo dovuto smantellare tutto e fare le cose a c\*\*\*\*.

  
  

### **01:45:18**

  

**Sabatino Rinaldi:** Dato che non vogliamo più fare quel tipo di errori, siamo più prudenti e abbiamo bisogno di capire bene fin dove con voi possiamo spingerci. Questo vale per i biglietti, come lo sai benissimo Elena, vale per tutti le altre call che abbiamo fatto, dove ci siamo fermati per eh tanti motivi, quindi ecco perché è giusto per questo per questo aspetto qui che poi non diciamo che quello che ci avete ci state proponendo è sbagliato. Noi quando ce lo fate vedere pensiamo a mille altre robe. Quindi è giusto che poi Rebecca anche essendo una cosa nuova, noi non l'abbiamo mai, cioè nel senso son per noi questo mondo è nuovo, lo vediamo man mano, eh, è giusto che poi loro si pongano dei si pongano delle domande.

**Elena Spini:** No, no, ma siamo d'accordissimo,

**Sabatino Rinaldi:** Non so se sono stato chiaro.

**Elena Spini:** cioè considera, cioè comunque, cioè noi abbiamo cercato di rendere in questo senso la piattaforma più scalabile mh il possibile più scalabile, per l'amor di Dio. Lato nostro, vi forniremo tutta le la documentazione del caso, tutte le specifiche tecniche che se un giorno tra 2 anni vorreste mettere mano a questo flusso voi m potenzialmente lo potreste fare.

  
  

### **01:46:37**

  

**Elena Spini:** Sto solo dicendo che questo flusso è molto eh tra

**Sabatino Rinaldi:** Ok.

**Elena Spini:** virgolette particolare perché tocca diversi aspetti. Semplicemente questo.

**Sabatino Rinaldi:** Allora, noi abbiamo una riunione, vabbè, te l'abbiamo detto 1le volte, abbiamo una riunione oggi alle 3:00. Sappiamo che abbiamo la possibilità ora, ok, che proprio è più complicato, ma sembra la strada migliore, poter decidere e quantomeno il numero di weight che possiamo dare e differenziarlo se deve essere

**Elena Spini:** E differenziarlo. Attto.

**Sabatino Rinaldi:** 11, se essere 12, se essere 5, se essere 3. Ok? Noi abbiamo eventi delicati come possono essere il tour, come può essere il food marketing più il tour magari che sono eventi più flessibili per noi, cioè non abbiamo idea di che cosa sono cose che decidiamo in base alle esigenze che abbiamo di cui ci rendiamo conto un mese prima, due settimane prima, non lo sappiamo. Rebecca, correggimi se sbaglio. Quindi quello potrebbe essere un po' più delicato.

**Rebecca Marmo:** Esatto,

**Sabatino Rinaldi:** A differenza di un camerier venditori e anche il food insieme al tour,

**Rebecca Marmo:** anche il food, eh?

  
  

### **01:47:48**

  

**Rebecca Marmo:** Il food è molto particolare,

**Sabatino Rinaldi:** a differenza di,

**Rebecca Marmo:** sì.

**Sabatino Rinaldi:** ok? a differenza di un camerier venditori, di una master pianissimo Live Academy, che sono eventi differenti collegati esclusivamente a a criteri specifici che quindi noi lì ecco quel sistema di weight sappiamo Rebecca sa che per uno è 11, per l'altro è 5, per l'altro è tre di remind e quindi è più va benissimo quella soluzione.

**Rebecca Marmo:** Sì, esatto.

**Sabatino Rinaldi:** Ovvio è che se quel sistema vale per tutti gli eventi e di conseguenza vale anche per il tour e per il food marketing, dobbiamo un attimo capire questa cosa qui, quindi capire come venire incontro alla soluzione che ci avete dato voi e come voi potenzialmente potete venire incontro a quella che è l'esigenza di quei due eventi. E quindi questa riunione di oggi si spera che ci dia queste risposte che compaano dal cielo.

**Elena Spini:** Scusa, ma le l'esigenza di questi due eventi particolari rispetto a eh la soluzione che abbiamo dato, cos'è che non va? Non ho capito.

**Sabatino Rinaldi:** Te lo spiegare Becca.

**Rebecca Marmo:** Allora, per quanto riguarda il Food Marketing Festival, vi faccio un riassunto qui con Matteo che magari interviene, essendo un evento che è particolare, gratuito, a pagamento, ci sono tre tipologie di di biglietti, facciamo invii particolari, tipo quest'anno abbiamo inviato prima solo ai gratuiti o prima solo quelli a pagamento.

  
  

### **01:49:18**

  

**Rebecca Marmo:** Guardavamo gli scarichi, quindi eh funnel partivano, anche più di più funnel partivano in base a come si stavano andando gli scarichi e le nomine. Quindi mh sono funnel che sì sono studiati, ma molti vengono studiati qualche giorno, cioè oggi per domani, capito? Eh, è un evento un po' particolare. Il tour invece in realtà non è che è così tanto, come diceva Sabatino, problematico, perché lì semplicemente magari sono meno in B, sono comunque di per sé potrebbe andare bene anche la logica come per gli altri eventi, per il tourel food che ci crea un po' più di problema. Ecco, tutto qui. Matteo, se vuoi aggiungere qualcosa. Ok, perfetto.

**Sabatino Rinaldi:** Sì, esatto. Infatti il food marketing non ci stavo non stavo ragionando il fatto che abbiamo tre tipologie di biglietto che in realtà vabbè questo lo sapete che abbiamo biglietti gratuiti e biglietti a pagamento. È ovvio che lì le logiche sono un attimino differenti perché su chi ha pagato hai un diverso approccio comunicativo di remind perché ha pagato, quindi è diverso. Su chi non ha pagato dobbiamo un attimo capire l'andamento che è collegato anche all'andamento di quanto scaricano quelli che hanno pagato, perché poi la tale è quella,

  
  

### **01:50:35**

  

**Elena Spini:** Ah, su questo,

**Sabatino Rinaldi:** quindi

**Elena Spini:** da quello che ho capito, il Food Marketing Festival è una volta all'anno.

**Sabatino Rinaldi:** te

**Elena Spini:** Ok, è stato fatto recentemente, giusto?

**Sabatino Rinaldi:** Ah, sì,

**Elena Spini:** Ok,

**Sabatino Rinaldi:** ora sì, a settembre.

**Elena Spini:** possiamo considerarlo come un caso limite da gestire in un secondo momento, ma da gestire. capisco l'esigenza perché qua è proprio un altro flusso e in caso bisogna capire come o includerlo in questo flusso di biglietti, chiamiamolo standard, o capire come fare un nuovo flusso. So

**Rebecca Marmo:** Ma non si potrebbe fare un flusso per ogni evento collegato semplicemente a quei codici, a quegli asset che sarebbe, lo so, sarebbe duplicato per tot, però sarebbe sempre quello. So che il flusso camerier venditori si collega solo alle campagne camerieri venditori. Mi è venuta adesso così e io chiedo

**Elena Spini:** Chi è Fabrizio, non so se hai capito.

**Fabrizio Mastracci:** Sì, ma la risposta è no, perché si dovrebbero andare a modificare ogni volta le entry di ingresso del giorno che adesso è quando è il link è presente e se è su status front, ok?

  
  

### **01:52:04**

  

**Fabrizio Mastracci:** sull'oggetto invito evento. Questa cosa comporterebbe che si deve ribaltare l'ingresso dentro il flow sulla campagna andando a prendere qualcosa, diciamo, che che è relativo a quella campagna. Quindi, di fatto vuol dire stravolgere tutto il flusso. Io piuttosto dico, se la questione è e il caso vuole che l'unica variabile che avete in considerazione è il numero di invioo e l'altro, io farei un po' come dice Elena, cioè su questo lo teniamo per ora così sul caso particolare vediamo un attimo di fare un journey a

**Elena Spini:** E se un giorno X vi dovreste inventare un'altra casistica ancora, andrebbe fatta la stessa logica di questo Food Marketing Festival, logica di, diciamo, m specifica, no, non so come dirlo. Allora, diciamo che chiamiamolo come flusso standard, il flusso che abbiamo fatto adesso. eventuali modifiche dovranno essere gestite con il flusso 2, 3 4 e così via per quante logiche vi inventate.

**Rebecca Marmo:** Mh.

**Elena Spini:** M.

**Rebecca Marmo:** Perché sennò non potresti mettere, non so, duplicare il flusso quanti sono gli eventi e all'inizio fare subito un controllo se il biglietto contiene il codice 20 edizione, allora continua il funnel oppure no.

  
  

### **01:53:47**

  

**Rebecca Marmo:** Non è possibile neanche così. Io ho mi vengono in mente cose, ma non so

**Fabrizio Mastracci:** Ma io una domanda ti faccio. Qual è la, diciamo, la variabile, ok? L'evento particolare, che cosa cambia esattamente rispetto alle mail che avete ricevuto prima?

**Rebecca Marmo:** non lo so, magari ad alcuni vogliamo cambiare un attimo la comunicazione. Ce ne sono attivi. esempio, no, è già attivo camerieri venditori che sta mandando comunicazioni e per l'evento successivo,

**Sabatino Rinaldi:** Sì.

**Rebecca Marmo:** siccome parto giorni prima, partono tot e parte anche non so pianissimo live, ok? E ma voglio cambiare comunicazione. Io in quel caso dopo cambio comunicazione sia camerieri venditori che è pienissimo live, capito? Sono limitata in quello, poi magari non succede, però penso a tutti questi casi, ecco,

**Fabrizio Mastracci:** Io farei così a questo punto.

**Rebecca Marmo:** non lo so.

**Fabrizio Mastracci:** Quello che abbiamo fatto stante alle richieste vostre del weight e del numero di invciamo così. Per questo caso particolare io poi ti lascio un template, ok? Che è praticamente puntato a questo questa campagna che diciamo questo evento particolare e poi tu da lì ogni volta fai l'invio, duplichi e modifichi.

  
  

### **01:55:09**

  

**Fabrizio Mastracci:** Ok? ti cambi là te lo lascio con gli weight che te li puoi proprio cambiare come ti pare. Puoi mettere le mail come ti pare. Però giusto una cosa voglio dire, nel caso in cui eh perché mi mi riaggancio a quello che diceva Sabatino prima, nel caso in cui tutto questo rientra sempre nel giro dei biglietti è importante che tu come ingresso della eh diciamo di questa di questo flusso mantieni sempre lo stesso o comunque la stessa struttura di quello che ti ho dato io. Cioè, tu non puoi prendere un giorno, ti crei una lista CSV, la importi e dici voglio mandare le mail a tutte a tutte quelle persone perché questo comporta un errore dal momento che ci sono nila logiche dietro questo flusso degli biglietti. Quindi io ti posso duplicare, ti metto il puntamento per quello specifico flusso su una sola campagna, così tu poi puoi modificare quello lì come ti pare, senza impattare però su quell'altro e poi cambiare leemail ogni volta come le vuoi o non so aggiungere altre cose.

**Sabatino Rinaldi:** Non so se Rebecca ha sentito.

  
  

### **01:56:52**

  

**Elena Spini:** Si torna

**Matteo Distaso:** Sì, abbiamo sentito.

**Elena Spini:** Rebecca e vi torna più o meno.

**Rebecca Marmo:** più o meno adesso, oggi comunque ne parliamo anche per capire bene che cosa però

**Elena Spini:** Sicuramente parlatene, capite meglio, però cioè vi chiederei anche, cioè poi non so se in questo momento ci sarà anche Fabrizio, io capisco che voi avete un modus operanti di lavorare e ci sta, però mettetevi anche nella eh situazione in cui, cioè vi stiamo proponendo una soluzione che possa ovviamente m rispecchiare sempre di più le vostre esigenze, ma anche servirà lato vostro un minimo di cambiamento rispetto a m quello che facevo tutto prima, perché state andando a fare un cambiamento importante e quindi ci sarà anche eh dovrà essere anche adottato lro vostro uno sforzo di adattamento in questo senso nella piattaforma. che deve essere, e questo è la base, un adattamento in meglio. Questo è la base. Quindi non vedete il fatto di avere un flusso unico per ogni edizione come una limitazione, ma anzi deve essere vista come una miglioria perché stiamo andando a standardizzare sempre di più un processo che poi non vuol dire che attenzione è blindato sulla pietra, ma andremo poi in un secondo momento a capire come e istruirvi su come effettivamente questo può essere mh adattato in particolari casi o adattato se il giorno X ci dovranno essere delle nuove esigenze.

  
  

### **01:59:11**

  

**Sabatino Rinaldi:** Eh, Reby,

**Elena Spini:** Così mi taccio.

**Sabatino Rinaldi:** te sulla soluzione dei weight che abbiamo stabilito ora sulla flessibilità dei weight, te sugli eventi, ad esempio, pienissimo live, Academy, Mastery, eccetera eccetera, sold out e quant'altro. Sei tranquilla, va bene così?

**Rebecca Marmo:** Sì, sì, su quello sì, su quello sono abbastanza tranquilla.

**Sabatino Rinaldi:** Ok.

**Rebecca Marmo:** Poi, ehm, lì bisogna anche capire, adesso mi hai parlato di soldout, Saba, per gli eventi online, come facciamo le comunicazioni, perché l'anno scorso le avete fatte voi, non io.

**Sabatino Rinaldi:** Ah. Vbè per le comunicazioni degli eventi,

**Rebecca Marmo:** E dopo lì bisogna eh eh

**Sabatino Rinaldi:** quello degli eventi online è identico a una diretta, quindi lì il CRM non deve dirci nulla, siamo noi da marketing a gestire tutto.

**Rebecca Marmo:** sì, ma sono biglietti, Saba è sempre viene visto come un evento con biglietti. È sempre lo stesso funnel. Sì,

**Sabatino Rinaldi:** In che senso viene visto come lì? Sono si iscrivono a una diretta su Zoom.

**Rebecca Marmo:** cioè,

**Sabatino Rinaldi:** ha gestito da Zoom e Marketing.

**Rebecca Marmo:** eh, ma noi abbiamo dei biglietti, esempio di Bive, abbiamo dei biglietti nel CRM,

  
  

### **02:00:27**

  

**Sabatino Rinaldi:** Sì, ma lì la comunicazione è differente, perché te non devi fargli dire accetto rifiuto.

**Rebecca Marmo:** eh, non devono proprio partire comunicaz Allora, per il funnel biglietti, perché da come ho capito tutti i biglietti seguono questo funnel qui che è unico.

**Sabatino Rinaldi:** Ho capito, ma ODB Live non ha biglietti. L'anno scorso che abbiamo fatto DB Live, mica gli hai dato il biglietto a Cetta rifiuta.

**Rebecca Marmo:** Ah, noi del CRM poi ce l'avevamo il biglietto.

**Elena Spini:** con Fabrizio su questo,

**Elisa Migliano:** Ma f

**Elena Spini:** cioè eh scusa Elisa se volevi dire qualcosa, volevo solo dire quella cosa di genera biglietto, sì o no? Ok. Cioè, eh con Fabrizio e Lisa abbiamo adottato una logica per cui un prodotto viene definito con genera biglietto, sì o no? Quindi se Sabatino dice che questo, non mi ricordo come l'avete chiamato, evento non deve generare un biglietto, allora sul CRM non si genererà un biglietto perché ci viene detto da

**Sabatino Rinaldi:** Ah,

**Elena Spini:** Mexal.

**Sabatino Rinaldi:** esatto.

**Fabrizio Paganelli:** Lo dibsob DB sarà totalmente in streaming, giusto?

**Sabatino Rinaldi:** Sì, sì, sì. Non bisogna generare un biglietto.

  
  

### **02:01:41**

  

**Fabrizio Paganelli:** Non ci saranno persone.

**Sabatino Rinaldi:** No, no,

**Fabrizio Paganelli:** Non ci saranno persone.

**Sabatino Rinaldi:** no,

**Fabrizio Paganelli:** Ok.

**Sabatino Rinaldi:** assolutamente no. È un evento su Zoom.

**Fabrizio Paganelli:** E dopo però il fatto che poi dopo il cliente partecipi e che diciamo sia lo tenete sotto controllo voi con altri strumenti come

**Rebecca Marmo:** Eh

**Sabatino Rinaldi:** il fatto che chi partecipa noi lo lo tracciamo da da Zoom perché ha partecipato

**Fabrizio Paganelli:** non ho capito. Ok.

**Sabatino Rinaldi:** all'evento, quindi avremo una lista dei partecipanti, ossia di tutti quelli iscritti che hanno partecipato, di tutti quelli iscritti che non hanno partecipato.

**Fabrizio Paganelli:** Yeah. E quindi diciamo che rispetto a un camerier venditori non ci sarà al cinema che si genera il biglietto, il cliente quando accede.

**Sabatino Rinaldi:** No, no, no, no.

**Fabrizio Paganelli:** С.

**Sabatino Rinaldi:** Esatto. Tu a Camere Venditori hai paghi disponibilità biglietto, ti comunico che hai il biglietto, lo devi nominare, scaricare, venire all'evento e ti cecchiniamo e quello è un evento classico. ODB Live tu acquisti su eventualmente su Wocommerce quel biglietto, quel prodotto che è un prodotto digitale, lo paghi €200,

  
  

### **02:02:47**

  

**Fabrizio Paganelli:** Sì.

**Sabatino Rinaldi:** arriva su Mexal. Ok, questo ha pagato. Una volta che ha pagato può entrare nelle nostre comunicazioni di remind di Zoom. Ma è differente rispetto a un evento in presenza. Non c'è da scaricare un biglietto, non c'è da far nulla.

**Fabrizio Paganelli:** Ok.

**Sabatino Rinaldi:** Noi avremo la lista di tutti quelli che hanno pagato e lo gestiamo noi tramite marketing, ma non è che deve mandare i biglietti, capito? È proprio un'altra comunicazione.

**Fabrizio Paganelli:** Ok, quindi se se noi abbiamo un codice articolo che adesso si chiama ODB Live streaming

**Sabatino Rinaldi:** Esatto,

**Fabrizio Paganelli:** e lo battezziamo come codice articolo che non genera un biglietto,

**Sabatino Rinaldi:** chiaro.

**Fabrizio Paganelli:** come mi pare che giusto che sia,

**Sabatino Rinaldi:** Sì.

**Fabrizio Paganelli:** il cliente lo acquista a prescindere dal canale, se da Wcommerce o se da tutor, noi lo fatturiamo. il cliente paga, tu hai modo di andare a recuperare questo tipo di informazioni per capire poi chi accede allo stream e se effettivamente ha pagato,

**Sabatino Rinaldi:** Eh, mi è Esatto.

**Fabrizio Paganelli:** sia o cioè

**Sabatino Rinaldi:** Mi auguro Mi auguro che noi da Marketing Cloud, dato che non è un funnel biglietti, ma è un funnel tra virgolette libero, lo chiamo così, una un journey normale di marketing, mi auguro che io posso andare a chiamare il CRM a dire quanti quante persone hanno pagato DB Live che hanno quindi la hanno hanno comprato quel corso che può essere come quante persone hanno comprato un libro, un'informazione come un'altra.

  
  

### **02:04:16**

  

**Fabrizio Paganelli:** No, ok, però Però io quello che intendo dire è questo, mentre con i biglietti fisici tu acquisti il biglietto, si rende disponibile e quando vieni quella hai lo scarico perché il cliente quando arriva all'evento che fa il checkin si scansiona il QR code.

**Sabatino Rinaldi:** Mh.

**Fabrizio Paganelli:** Nel l'ODB streaming se lo impostiamo come codice articolo che non genera un biglietto non ti si genera il biglietto e non ci sarà il QR code, non ci sarà lo scarico.

**Sabatino Rinaldi:** Ah, tu dici nella presenza se è venuto o non è venuto?

**Fabrizio Paganelli:** questa cosa qua è eh tu come fai a tenerla monitorata?

**Sabatino Rinaldi:** Ah, non ho

**Fabrizio Paganelli:** Perché poi dopo ti dico nel l'ODB che ci sarà nel 2028 se non lo tieni monitorato ti trovi anche quelli del 2027. Capito cosa voglio dire?

**Sabatino Rinaldi:** chiaro. Noi su Zoom, essendo una diretta gestita da Zoom, che Zoom è uno strumento che ti traccia anche quanti peli nel naso ha chi ha partecipato,

**Fabrizio Paganelli:** Ok.

**Sabatino Rinaldi:** io ho so per certo quante persone hanno partecipato che erano iscritti. Quindi mi dice quanti iscritti avevi?

  
  

### **02:05:17**

  

**Sabatino Rinaldi:** 1000 e ti dice tutti i nomi, cognomi, dati. Quanti hanno partecipato? 500. Quanti non hanno partecipato? Altri 500. E sappiamo chi sono. Quindi poi il tracciamento di chi ha partecipato o non ha partecipato, in quel caso ce lo dà Zoom, poi è ovvio che andiamo a a intrecciare i dati nel CRM.

**Fabrizio Paganelli:** Ok. Quindi diciamo che tu utilizzerai come piattaforma di base Zoom per tenere traccia di chi ha diritto e di chi è venuto e chi non è venuto.

**Sabatino Rinaldi:** Esatto, perché noi sappiamo chi è iscritto perché il flusso sarà quello, tu paghi. In quel caso ehm il CRM non decide nulla perché se tu paghi se tu paghi che sei sappiamo che hai pagato e quindi hai diritto che andiamo a prendere noi dal da marketing, eh quindi da marketing cloud, tutte le persone che hanno pagato, ce le andiamo a prendere noi e poi ci colleghiamo a Zoom per dire questo ha diritto a ricevere il link di Zoom, però è Zoom che c'è un collegamento API con Zoom.

**Fabrizio Paganelli:** Cioè l'importante è che tu da qualche altra parte hai il monitoraggio di chi ha effettivamente poi partecipato, perché se non ce l'hai da nessuna parte,

  
  

### **02:06:29**

  

**Sabatino Rinaldi:** Sì, sì, sì, sì, sì. No, quello ce l'hai su Zoom, non è un problema.

**Fabrizio Paganelli:** te l'anno dopo ti trovi quelli che hanno comprato i biglietti nel 27 e anche quelli che hanno comprato i biglietti nel 28. Capito cosa voglio dire?

**Sabatino Rinaldi:** Assolutamente sì. Sappiamo chi ha diritto di partecipare e sappiamo chi ha partecipato.

**Fabrizio Paganelli:** Allora, mi segno che l'ODB lo sarà un codice articolo senza generazione del biglietto e siamo a posto.

**Sabatino Rinaldi:** Eh sì, perché poi che se ne fa del B non se ne fa nulla perché è stringamo.

**Fabrizio Paganelli:** No, no, è chiaro. No, no,

**Sabatino Rinaldi:** Sì, sì. No, era per far capire anche a loro come funziona.

**Fabrizio Paganelli:** perché siccome mi ricordavo che l'anno scorso, ma magari mi ricordo male io, era stata ibrida la cosa, un po' erano in presenza e un po' in streaming.

**Sabatino Rinaldi:** No, quella era soldout.

**Fabrizio Paganelli:** Ah, ok,

**Sabatino Rinaldi:** Era quella è soldout.

**Fabrizio Paganelli:** perfetto.

**Sabatino Rinaldi:** Ancora un'altra roba.

**Fabrizio Paganelli:** Ok,

**Sabatino Rinaldi:** Soldout.

**Fabrizio Paganelli:** ok. Ok,

**Sabatino Rinaldi:** Soldout ha l'evento anche in sala e quindi va gestito come qualsiasi altro evento.

  
  

### **02:07:18**

  

**Fabrizio Paganelli:** va bene. Adesso me lo sono segnato,

**Sabatino Rinaldi:** Sì,

**Fabrizio Paganelli:** così modifico l'anagrafica degli articoli.

**Sabatino Rinaldi:** che tra l'altro mi ricordo che Andrea di Romi i primi tempi, questa fu una domanda che gli fece all'inizio, voi in marketing cloud avete il collegamento diretto con Zoom, giusto? Chiedo a Fabrizio, forse è lui che mi risponde.

**Fabrizio Mastracci:** Forse a sales force ti ha detto,

**Sabatino Rinaldi:** Cosa

**Fabrizio Mastracci:** forse sales force si riferiva al CRM.

**Sabatino Rinaldi:** ST force ha il collegamento con Zoom?

**Elena Spini:** Forse tramite connettore,

**Aurel mrruku:** Ah,

**Sabatino Rinaldi:** Eh sì,

**Aurel mrruku:** ma in che

**Elena Spini:** non lo so.

**Sabatino Rinaldi:** aveva una roba del genere. Sì, sì. Io chiesi sta roba, dissi, chi si eh chi entra nel CRM, cioè possiamo gestire il i funnel con Zoom direttamente da voi

**Aurel mrruku:** a chi leiha chiesto sta cosa?

**Elena Spini:** ad Andrea.

**Sabatino Rinaldi:** ad Andrea di ROMIancor prima di firmare il contratto.

**Aurel mrruku:** Ah,

**Elena Spini:** diciчи.

**Sabatino Rinaldi:** M.

**Aurel mrruku:** che controllo che non Sì,

**Elena Spini:** Ah, Andrea Galotto.

**Aurel mrruku:** sì,

  
  

### **02:08:21**

  

**Sabatino Rinaldi:** Eh, non lo so.

**Elena Spini:** Ah,

**Sabatino Rinaldi:** Penso di sì.

**Aurel mrruku:** sì,

**Sabatino Rinaldi:** Lui si chiamava aveva sempre scritto Andrea Romi,

**Elena Spini:** sì, sì, sì,

**Aurel mrruku:** sì.

**Elena Spini:** sì, sì.

**Sabatino Rinaldi:** quindi per me era il suo cognome.

**Elena Spini:** ancora prima di fermare il contratto dobbiamo vedere, cioè ci sono tanti connettori disponibili,

**Sabatino Rinaldi:** Va bene,

**Elena Spini:** però

**Sabatino Rinaldi:** va bene. No, ma questo non mi preoccupa. Va bene, si si fa. Anche se non ce lo fa stesso, se lo faccio da solo non è un problema.

**Aurel mrruku:** Sì, sì,

**Sabatino Rinaldi:** Ok,

**Aurel mrruku:** c'è un connettore standard.

**Sabatino Rinaldi:** perfetto. Quindi puoi fare questa. Anzi, dovrebbe essere ancora più semplice se ce la direttamente il connettore con Zoom.

**Elena Spini:** se se è meglio è sempre meglio scegliere i connettori. Eh,

**Aurel mrruku:** Ar. Sì.

**Elena Spini:** standard.

**Aurel mrruku:** Poi dobbiamo anche capire documentazione cosa si può, cosa non si può fare, quindi dobbiamo

**Sabatino Rinaldi:** Sì, sì. No, ma quello dipende dipende dall'abbonamento che hai di Zoom, quindi non di sicuro si può fare perché poi è Zoom che fa di base, cioè Zoom va solo a pescare le informazioni del contatto dal CRM,

  
  

### **02:09:12**

  

**Aurel mrruku:** Ah,

**Sabatino Rinaldi:** poi fa tutto lui.

**Aurel mrruku:** ok, ok, ok.

**Elena Spini:** Comunque,

**Sabatino Rinaldi:** Vabbè, no,

**Elena Spini:** allora,

**Sabatino Rinaldi:** questo non mi preoccupa questo Zoom. Quando non siamo in sala è tutto facile e il problema è sempre in sala.

**Elena Spini:** io ho una riunione, quindi rimaniamo tra poco, anzi sono già in ritardo, eh, rimaniamo che ci fate sapere voi. post vostro meeting. Cosa succede?

**Sabatino Rinaldi:** Sì, noi ci ci registriamo,

**Elena Spini:** Considerate che io ieri ho rimandato ho mandato il piano,

**Sabatino Rinaldi:** eccetera.

**Elena Spini:** quindi qualsiasi vostra decisione poi mette in discussione il piano.

**Sabatino Rinaldi:** Va bene.

**Elena Spini:** Ok,

**Fabrizio Mastracci:** Ok.

**Elena Spini:** prendete rivedete la la mail,

**Sabatino Rinaldi:** Ok.

**Elena Spini:** l'ho mandate ieri sera,

**Sabatino Rinaldi:** Sì. Sì, ok.

**Elena Spini:** vi devo rimandare il Allora,

**Sabatino Rinaldi:** L'hai mandata ieri sera.

**Elena Spini:** questo stato avanzamento progetto.

**Sabatino Rinaldi:** Ah, sì, sì, sì, sì, l'ho vista prima di entrare in call.

**Elena Spini:** Perfetto.

**Aurel mrruku:** Ok,

**Elena Spini:** E poi qua c'è il link al nuovo piano. Va bene?

**Elisa Migliano:** Va bene, grazie intanto.

**Aurel mrruku:** grazie.

**Elisa Migliano:** Buon lavoro.

**Aurel mrruku:** Ciao.

**Fabrizio Mastracci:** Ja.

**Elisa Migliano:** Ciao a tutti.

**Fabrizio Mastracci:** M.

**Elisa Migliano:** Ciao C c

**Elena Spini:** Buon lavoro a tutti.

**Sabatino Rinaldi:** Ciao ciao ciao ciao ciao ciao ciao. No.

**Elena Spini:** Ciao ciao ciao.

**Rebecca Marmo:** Tam. M.

  
  

### **Trascrizione terminata dopo 02:26:15**

  

*Questa trascrizione modificabile è stata generata dal computer e potrebbe contenere errori. È possibile anche modificare manualmente il testo dopo la creaz