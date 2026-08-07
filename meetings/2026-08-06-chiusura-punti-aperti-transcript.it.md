# **ð Note**

ago 6, 2026

## **\[ROMI-PIENISSIMO\] - Chiusura ultimi punti aperti**

invitato [Elena Spini](mailto:e.spini@romicompany.com) [Aurel mrruku](mailto:a.mrruku@romicompany.com) [Andrea Di Cicco](mailto:a.dicicco@romicompany.com) <amministrazione@pienissimo.com> [Fabrizio Mastracci](mailto:f.mastracci@romicompany.com) <marco.m@pienissimo.com> <sabatino.r@pienissimo.com>

Allegati [\[ROMI-PIENISSIMO\] - Chiusura ultimi punti aperti](https://calendar.google.com/calendar/event?eid=N2hsOHA2Y2RjZTRiYXRnZXU3azRpM2JkZ3EgZS5zcGluaUByb21pY29tcGFueS5jb20)

Record delle riunioni [Trascrizione](https://docs.google.com/document/d/1roHKiiF8qSlvqCnStsvY9ldpQxdi0SSFNS4a0xiObxk/edit?usp=drive_web&tab=t.7wnzrfk5z01u) [Registrazione](https://drive.google.com/file/d/1i0M2dURQYHLB92v8SeI1uJaz7xCcTg1X/view?usp=drive_web)

### **Riepilogo**

La riunione ha definito le integrazioni tra Salesforce e WooCommerce insieme ai flussi per gestione eventi e dati.

**Ottimizzazione flussi vendita Salesforce**  
Si è deciso che l'opportunità passi allo stato vinto solo quando l'ordine risulta incassato. La gestione dei bundle avviene ora esclusivamente su Salesforce per semplificare l'integrazione.

**Gestione eventi e ticket**  
I biglietti diventano disponibili solo dopo il saldo integrale della fattura. Il processo di check-in prevede la scansione di codici QR e la gestione manuale di eventuali sostituzioni nominative.

**Migrazione dati e integrazioni**  
L'integrazione con il sistema di commercio elettronico utilizzerà i webhooks per sincronizzare le operazioni. È prevista l'automazione della verifica delle partite IVA tramite chiamate API esterne per garantire la qualità.

### **Decisioni**

## **Concordato**

- **Obbligatorietà partita IVA nei form** L'inserimento della partita IVA è aggiunto come campo obbligatorio nei form di registrazione utilizzati durante le dirette per consentire la corretta identificazione delle aziende.
- **Workflow accettazione preventivo e ordine** Il flusso di accettazione del preventivo prevede l'invio di un link a una landing page dedicato, la cui accettazione innesca l'invio automatico della firma Docusign e la successiva generazione dell'ordine.
- **Condizione chiusura opportunità vinta** L'opportunità passa allo stato "Vinta" esclusivamente quando l'ordine associato raggiunge lo stato di "Incassato", eliminando la fase manuale di "Chiuso acquisito".
- **Tipizzazione opportunità Performance Plus** È obbligatorio per il tutor tipizzare l'opportunità come "Performance Plus" (specificando attivazione o rinnovo) in fase di creazione su Salesforce.
- **Gestione data inizio servizio contrattuale** La gestione della data di inizio e fine del servizio è affidata allo strategist, che provvederà all'inserimento del dato al momento dell'avvio effettivo dell'attività, anziché in fase di contratto.
- **Generazione link checkout WooCommerce** Viene implementato un pulsante "Crea link" per le opportunità di tipo "Recall tutor", permettendo di generare un link di checkout WooCommerce contenente l'ID dell'opportunità Salesforce.
- **Unificazione gestione bundle prodotti** La gestione dei bundle è unificata in un unico sistema in carico all'amministrazione, eliminando la duplicazione precedentemente prevista per vendite da palco o recall tutor.
- **Automazione creazione nota di credito** Viene introdotta la funzionalità di generazione della nota di credito tramite pulsante a livello di ordine, permettendo la selezione specifica delle righe d'ordine o dell'asset da stornare.
- **Sincronizzazione campagne Salesforce e Mexal** La creazione di un prodotto evento su Mexal comporta la generazione automatica della relativa campagna su Salesforce per garantire il tracciamento della partecipazione.
- **Aggiunta tipologia biglietto in anagrafica** Viene introdotto un campo a tendina nell'anagrafica prodotto per definire la tipologia di biglietto (es. Gold, Silver), permettendo di gestire asset distinti per il medesimo evento.
- **Automazione funnel comunicazione eventi** Il funnel di comunicazione marketing verrà automatizzato attivandosi 60 giorni prima della data dell'evento per tutti gli account aventi diritto.
- **Strategia mappatura campi dati** La mappatura dei campi avverrà direttamente da Zo a SalesForce, mantenendo le etichette originali di Zo per semplificare l'integrazione dei dati.
- **Definizione stato disponibilità asset** Lo stato degli asset rimarrà 'disponibile' fino all'effettivo utilizzo all'evento, poiché la compilazione della documentazione non garantisce la presenza.
- **Criteri disponibilità biglietti** L'asset del biglietto diventerà disponibile solo dopo l'integrale pagamento della fattura o della rata (tranche) associata alle relative righe d'ordine.
- **Funzionalità gestione casi limite** Sarà implementata una funzionalità di sistema per gestire i cambi nominativo dei partecipanti, utilizzabile sia prima dell'evento che in fase di check-in in loco.
- **Aggiornamento biglietti per cambi nominativi** Il sistema di gestione biglietti aggiornerà automaticamente il QR code e l'invio dell'email al nuovo contatto in caso di cambio nominativo effettuato prima dell'evento.
- **Integrazione WooCommerce tramite Webhook** L'integrazione tra il sistema e WooCommerce sarà implementata tramite Webhook, come indicato dall'analisi tecnica.
- **Tempistica validazione Partita IVA** La verifica della Partita IVA sarà eseguita esclusivamente al momento della generazione dell'ordine, anziché durante la creazione dell'account cliente.
- **Gestione errori validazione Partita IVA** Un eventuale fallimento nella validazione della Partita IVA innescherà l'invio automatico di un'email di notifica all'amministrazione per gestire l'eccezione.

Abbiamo **aggiornato la sezione Decisioni** in base al tuo feedback.

Facci sapere cosa ne pensi: [Utili](https://google.qualtrics.com/jfe/form/SV_5bXzKQfylMIhSXc?isHelpful=True&entryPoint=decisions&confid=TgzXtTaHwEygDF1Uniw2DxIUOAIIigIgABgDCA&isGoogler=False) o [Non utile](https://google.qualtrics.com/jfe/form/SV_5bXzKQfylMIhSXc?isHelpful=False&entryPoint=decisions&confid=TgzXtTaHwEygDF1Uniw2DxIUOAIIigIgABgDCA&isGoogler=False)

### **Passaggi successivi**

- \[Elena Spini\] Inviare registrazione: Inviare la registrazione della riunione precedente a Elisa Migliano.
- \[Sabatino Rinaldi\] Aggiornare modulo: Aggiungere il campo partita IVA nel modulo utilizzato durante la diretta.
- \[Elena Spini\] Aggiornare schema: Aggiornare lo schema del processo con le modifiche concordate sugli stati dell'ordine e inviarlo al gruppo.
- \[Lo strategist\] Impostare data inizio: Inserire la data effettiva di inizio servizio all'interno del contratto su Salesforce.
- \[Elena Spini\] Configurare alert: Configurare un avviso automatico o una notifica email per lo strategist quando il campo della data di inizio è vuoto nel contratto.
- \[Fabrizio Paganelli\] Aggiungere info prodotto: Inserire i campi informativi relativi ai biglietti e il flag per gli eventi all'interno dell'anagrafica prodotto.
- \[Elena Spini\] Organizzare meeting marketing: Organizzare una riunione con Rebecca Marmo, Marco e Matteo per pianificare i funnel di marketing legati ai biglietti degli eventi.
- \[Elisa Migliano, Fabrizio Paganelli\] Mappare campi Zoho: Completare la mappatura dei campi necessari per la migrazione dei dati da Zoho a Salesforce nel file condiviso.
- \[Elisa Migliano, Fabrizio Paganelli\] Bonificare dati clienti: Effettuare la bonifica dei dati esistenti su Zoho per isolare i clienti effettivi prima dell'importazione su Salesforce.
- \[Elisa Migliano, Sabatino Rinaldi, Elena Spini\] Mappare Lead e Contatti: Collaborare per completare la mappatura delle tabelle lead e contatti. Coinvolgere Marco nel processo per suddividere le attività.
- \[Elena Spini\] Pianificare Meeting: Inviare una proposta per pianificare i meeting sui flussi di marketing e sui campi degli asset. Inserire Rebecca in tutte le chiamate di discussione su flussi, campi e ticket.
- \[Andrea\] Inviare Mapping: Inviare un file contenente le domande relative al mapping dei campi per risolvere le problematiche tecniche riscontrate.
- \[Aurel mrruku, Elena Spini\] Gestire Casi Limite: Implementare il bottone per la gestione dei casi limite come il cambio nome dei partecipanti. Sviluppare la funzionalità per inviare la mail aggiornata con i dati corretti.
- \[Elisa Migliano\] Mappatura campi: Integrare la mappatura dei campi nel file modello dati entro domani.
- \[Sabatino Rinaldi, Aurel mrruku\] Scambio credenziali: Scambiare le credenziali necessarie per avviare il test di integrazione web hook al rientro dalle ferie.
- \[Sabatino Rinaldi, Aurel mrruku\] Test integrazione: Eseguire i test di integrazione web hook utilizzando payload di esempio dopo il ritorno dalle vacanze.
- \[Elisa Migliano\] Inviare liste dati: Fornire la lista degli articoli significativi e degli eventi entro domani.
- \[Elisa Migliano\] Fornire bundle esempio: Inviare gli esempi di bundle con i relativi codici identificativi.
- \[Elena Spini\] Pianificare riunioni: Inviare gli inviti per i prossimi incontri di progetto previsti per il mese di agosto.
- \[Marco\] Informare Rebecca: Comunicare a Rebecca il piano degli appuntamenti e gli impegni per la prossima settimana.
- \[Elena Spini, Sabatino Rinaldi\] Organizzare incontro tecnico: Coordinare una riunione con Andrea Parmeggiani al rientro dalle ferie per definire l'integrazione del servizio.
- \[Marco\] Definire logica lead: Elaborare e fornire le specifiche desiderate per la distribuzione automatica dei lead nelle code.

### **Dettagli**

- **Benvenuto e gestione partecipanti**: Fabrizio Mastracci, Sabatino Rinaldi, Elena Spini, Marco, Aurel mrruku, Andrea Di Cicco e Elisa Migliano partecipano alla riunione ([00:00:11](https://docs.google.com/document/d/1roHKiiF8qSlvqCnStsvY9ldpQxdi0SSFNS4a0xiObxk/edit?ouid=100243958128504204165#heading=h.ajp30yjac87p)) ([00:08:06](https://docs.google.com/document/d/1roHKiiF8qSlvqCnStsvY9ldpQxdi0SSFNS4a0xiObxk/edit?ouid=100243958128504204165#heading=h.v92kdwqya4d4)). Il gruppo chiarisce un errore iniziale nella convocazione, dove era stato invitato Fabrizio Mastracci al posto di Fabrizio Paganelli, necessario per discutere le attività di marketing ([00:00:11](https://docs.google.com/document/d/1roHKiiF8qSlvqCnStsvY9ldpQxdi0SSFNS4a0xiObxk/edit?ouid=100243958128504204165#heading=h.ajp30yjac87p)) ([00:03:08](https://docs.google.com/document/d/1roHKiiF8qSlvqCnStsvY9ldpQxdi0SSFNS4a0xiObxk/edit?ouid=100243958128504204165#heading=h.dpk95ajw6vyy)).
- **Approvazione Timeline Fase 2**: Sabatino Rinaldi conferma che Daniela ha approvato la timeline proposta per la Fase 1 e la Fase 2, non sollevando ulteriori questioni in merito ([00:04:11](https://docs.google.com/document/d/1roHKiiF8qSlvqCnStsvY9ldpQxdi0SSFNS4a0xiObxk/edit?ouid=100243958128504204165#heading=h.b1jf9uw7l5ah)).
- **Chiarimento perimetro contrattuale**: Elena Spini solleva la necessità di una valutazione economica contrattuale in accordo con Daniela per determinare se il lavoro rientra in una fase aggiuntiva quotata o se può essere gestito internamente dal team, come indicato nei documenti condivisi ([00:06:08](https://docs.google.com/document/d/1roHKiiF8qSlvqCnStsvY9ldpQxdi0SSFNS4a0xiObxk/edit?ouid=100243958128504204165#heading=h.uhzmbdz74cs0)).
- **Gestione Lead durante le dirette**: Elena Spini e Sabatino Rinaldi discutono il flusso dei lead generati durante le dirette. Viene deciso di aggiungere il campo "Partita IVA" nei form compilati durante l'evento per facilitare la conversione in account. Sebbene i dati inseriti possano talvolta essere placeholder (es. "000"), il dato verrà aggiornato correttamente al momento del pagamento ([00:09:40](https://docs.google.com/document/d/1roHKiiF8qSlvqCnStsvY9ldpQxdi0SSFNS4a0xiObxk/edit?ouid=100243958128504204165#heading=h.7dl6jh7rp6ov)).
- **Stato dell'Opportunity e generazione ordini**: Fabrizio Paganelli e il team definiscono che, una volta che il cliente firma il contratto, il preventivo passa allo stato "Accettato", generando automaticamente l'ordine e portando l'Opportunity allo stato di "Opportunity vinta" ([00:15:17](https://docs.google.com/document/d/1roHKiiF8qSlvqCnStsvY9ldpQxdi0SSFNS4a0xiObxk/edit?ouid=100243958128504204165#heading=h.ro4m60owazoe)).
- **Processo di accettazione preventivo**: Elena Spini propone di eliminare il bottone di accettazione diretto nell'email, sostituendolo con un link che reindirizza il cliente a una landing page. Qui il cliente potrà visualizzare il contratto e cliccare su "Accetto" o "Rifiuto". In caso di accettazione, il sistema avvierà la procedura di firma tramite Docusign ([00:19:21](https://docs.google.com/document/d/1roHKiiF8qSlvqCnStsvY9ldpQxdi0SSFNS4a0xiObxk/edit?ouid=100243958128504204165#heading=h.c5ix8jkpsw2b)).
- **Mappatura degli stati ordine e chiusura Opportunity**: Fabrizio Paganelli e Elena Spini concordano che l'Opportunity passi allo stato "Chiusa vinta" solo quando l'ordine raggiunge lo stato "Incassato". Vengono stabiliti gli stati per l'ordine: "Ordinato", "Fatturato" e "Incassato". Viene eliminato lo stato precedente "Chiuso acquisito" ([00:22:19](https://docs.google.com/document/d/1roHKiiF8qSlvqCnStsvY9ldpQxdi0SSFNS4a0xiObxk/edit?ouid=100243958128504204165#heading=h.kvgpozbek8rm)).
- **Vendita Servizio Performance Plus**: Elena Spini chiarisce che, per le vendite di tipo "Performance Plus", il tutor deve obbligatoriamente tipizzare l'Opportunity in Salesforce durante la creazione (indicando se si tratta di attivazione o rinnovo). Questa operazione manuale è necessaria poiché l'informazione è fondamentale per la generazione del contratto ([00:27:39](https://docs.google.com/document/d/1roHKiiF8qSlvqCnStsvY9ldpQxdi0SSFNS4a0xiObxk/edit?ouid=100243958128504204165#heading=h.icimejdpb9z3)).
- **Gestione date di inizio contratto**: Marco, Elisa Migliano e Fabrizio Paganelli discutono la gestione della data di inizio servizio, poiché la firma del contratto non coincide sempre con l'effettiva operatività. Viene deciso che lo "Strategist" (responsabile del reparto) inserirà la data di inizio reale nel sistema. Elena Spini propone l'implementazione di banner di avviso o alert per ricordare ai responsabili di completare questo campo ([00:33:36](https://docs.google.com/document/d/1roHKiiF8qSlvqCnStsvY9ldpQxdi0SSFNS4a0xiObxk/edit?ouid=100243958128504204165#heading=h.ww7z1udz557e)).
- **Generazione link di pagamento WooCommerce**: Per le vendite recall effettuate dal tutor, viene stabilito che il tutor utilizzerà un bottone specifico in Salesforce per generare un link di checkout di WooCommerce. Tale link, contenente l'ID dell'opportunity, sarà inviato al cliente via email per finalizzare l'acquisto ([00:38:03](https://docs.google.com/document/d/1roHKiiF8qSlvqCnStsvY9ldpQxdi0SSFNS4a0xiObxk/edit?ouid=100243958128504204165#heading=h.f06lzni61b76)).
- **Gestione Bundle e Prodotti**: Elena Spini annuncia una semplificazione: i bundle saranno creati esclusivamente su Salesforce, mentre i singoli prodotti proverranno da Mexal. La distinzione tra vendite "da palco" e "recall tutor" avverrà tramite la tipizzazione dell'Opportunity effettuata dal tutor ([00:39:50](https://docs.google.com/document/d/1roHKiiF8qSlvqCnStsvY9ldpQxdi0SSFNS4a0xiObxk/edit?ouid=100243958128504204165#heading=h.b425nsa2hn6x)).
- **Controllo logiche Bundle**: Il team conferma che non saranno previsti controlli automatici rigidi sulla composizione dei bundle in Salesforce, delegando all'amministrazione la corretta associazione dei prodotti eleggibili, precedentemente definiti tramite flag specifici ([00:41:26](https://docs.google.com/document/d/1roHKiiF8qSlvqCnStsvY9ldpQxdi0SSFNS4a0xiObxk/edit?ouid=100243958128504204165#heading=h.3y73ndw34xq6)).
- **Gestione Note di Credito (Storni)**: Elena Spini illustra la procedura per le note di credito: tramite un pulsante a livello di ordine, sarà possibile selezionare la riga d'ordine da stornare (parziale o totale). Per i prodotti di tipo evento, il sistema permetterà anche l'annullamento dell'asset (biglietto) associato ([00:44:23](https://docs.google.com/document/d/1roHKiiF8qSlvqCnStsvY9ldpQxdi0SSFNS4a0xiObxk/edit?ouid=100243958128504204165#heading=h.qksvtsgzc4od)).
- **Flusso Biglietti Eventi**: Viene stabilito che, alla creazione di un prodotto evento su Mexal, si creerà automaticamente la relativa campagna su Salesforce. Gli ordini provenienti da WooCommerce genereranno asset di tipo "Biglietto" che passeranno dallo stato "Ordinato" a "Disponibile" (a fattura pagata) e infine a "Utilizzato" o "Non utilizzato" dopo la scansione del QR code ([00:46:02](https://docs.google.com/document/d/1roHKiiF8qSlvqCnStsvY9ldpQxdi0SSFNS4a0xiObxk/edit?ouid=100243958128504204165#heading=h.an34i1euclp)).
- **Tipologia Biglietti e anagrafica prodotto**: Per gestire diverse tipologie di biglietti (es. Gold, Silver) nello stesso evento, il team concorda di aggiungere un menu a tendina nell'anagrafica prodotto in Salesforce, evitando di basarsi esclusivamente sulla denominazione del codice prodotto ([00:51:36](https://docs.google.com/document/d/1roHKiiF8qSlvqCnStsvY9ldpQxdi0SSFNS4a0xiObxk/edit?ouid=100243958128504204165#heading=h.3axim453gax4)).
- **Marketing Funnel anti "No-Show"**: Sabatino Rinaldi conferma la necessità di un'attività di marketing automatizzato dai 30 ai 60 giorni prima dell'evento per ridurre il tasso di mancata partecipazione. Il team coordinerà queste attività con il coinvolgimento futuro di Matteo e Rebecca ([00:56:16](https://docs.google.com/document/d/1roHKiiF8qSlvqCnStsvY9ldpQxdi0SSFNS4a0xiObxk/edit?ouid=100243958128504204165#heading=h.tqh1su235y7i)).
- **Pianificazione Meeting Post-Ferragosto**: Elena Spini e il team concordano di organizzare un incontro la settimana successiva a Ferragosto per procedere con le attività di marketing. Sabatino Rinaldi conferma la disponibilità di Rebecca Marmo, che sarà coinvolta insieme a Matteo nel meeting ([00:58:50](https://docs.google.com/document/d/1roHKiiF8qSlvqCnStsvY9ldpQxdi0SSFNS4a0xiObxk/edit?ouid=100243958128504204165#heading=h.1yl9eo47ntj2)).
- **Raccolta Dati Partecipanti**: Elena Spini discute con Sabatino Rinaldi la procedura per ottenere i dati dei partecipanti per i possessori di biglietti. Sabatino Rinaldi spiega che i clienti ricevono un link a una landing page specifica per l'evento, dove il titolare dell'azienda può inserire nome, cognome ed email di ogni partecipante, associando i dati ai biglietti acquistati ([01:01:03](https://docs.google.com/document/d/1roHKiiF8qSlvqCnStsvY9ldpQxdi0SSFNS4a0xiObxk/edit?ouid=100243958128504204165#heading=h.wf3xkksuhnau)).
- **Gestione Account con Eventi Multipli**: Viene affrontata la gestione degli account che hanno acquistato bundle contenenti più eventi. Sabatino Rinaldi chiarisce che le comunicazioni non vengono inviate per tutti gli eventi simultaneamente, ma sono specifiche per ogni singolo evento e inviate automaticamente 30-60 giorni prima della data prevista ([01:03:27](https://docs.google.com/document/d/1roHKiiF8qSlvqCnStsvY9ldpQxdi0SSFNS4a0xiObxk/edit?ouid=100243958128504204165#heading=h.lfdddpr1x0nq)).
- **Automazione dei Funnel di Comunicazione**: Aurel mrruku, Elena Spini e Sabatino Rinaldi discutono dell'automazione dei processi di marketing ([01:06:18](https://docs.google.com/document/d/1roHKiiF8qSlvqCnStsvY9ldpQxdi0SSFNS4a0xiObxk/edit?ouid=100243958128504204165#heading=h.crynjya70fv1)) ([01:08:17](https://docs.google.com/document/d/1roHKiiF8qSlvqCnStsvY9ldpQxdi0SSFNS4a0xiObxk/edit?ouid=100243958128504204165#heading=h.7yan3sfe6va5)). L'obiettivo è attivare un funnel che, basandosi sui tag degli account e sulla data dell'evento, invii automaticamente la comunicazione con il link per la compilazione dei dati 60 giorni prima dell'inizio, ottimizzando il processo di generazione dei biglietti ([01:07:16](https://docs.google.com/document/d/1roHKiiF8qSlvqCnStsvY9ldpQxdi0SSFNS4a0xiObxk/edit?ouid=100243958128504204165#heading=h.s2fv6rluf1e3)).
- **Mappatura Campi e Integrazione Sistemi**: Elisa Migliano ed Elena Spini esaminano la mappatura dei campi tra Zoho e Salesforce ([01:11:59](https://docs.google.com/document/d/1roHKiiF8qSlvqCnStsvY9ldpQxdi0SSFNS4a0xiObxk/edit?ouid=100243958128504204165#heading=h.as0vqm97mms4)). Concordano di inserire nel documento condiviso le etichette originali dei campi di Zoho per facilitare la migrazione, semplificando il lavoro identificando solo i dati necessari da trasferire su Salesforce senza la necessità di conoscere le specifiche tecniche API ([01:16:05](https://docs.google.com/document/d/1roHKiiF8qSlvqCnStsvY9ldpQxdi0SSFNS4a0xiObxk/edit?ouid=100243958128504204165#heading=h.kjh8irpbwfy2)).
- **Bonifica Dati e Preparazione alla Migrazione**: Elisa Migliano e Sabatino Rinaldi discutono della pulizia del database, notando che su 17.000 record totali in Zoho, solo circa 8.500 sono clienti validi da migrare ([01:20:41](https://docs.google.com/document/d/1roHKiiF8qSlvqCnStsvY9ldpQxdi0SSFNS4a0xiObxk/edit?ouid=100243958128504204165#heading=h.iyr8uw3t8htm)). Il team pianifica di completare la preparazione dei dati e la mappatura al rientro dalle ferie di Ferragosto, con Fabrizio Paganelli, Elisa Migliano e gli altri membri pronti a fornire i file necessari ([01:22:16](https://docs.google.com/document/d/1roHKiiF8qSlvqCnStsvY9ldpQxdi0SSFNS4a0xiObxk/edit?ouid=100243958128504204165#heading=h.h91cot332l9o)).
- **Assegnazione Responsabilità per la Mappatura**: Elisa Migliano segnala la necessità di supporto da parte di Sabatino Rinaldi e Marco per la mappatura dei fogli relativi a "Lead" e "Referente" (Contatti), data la complessità e l'importanza di questi dati ([01:24:45](https://docs.google.com/document/d/1roHKiiF8qSlvqCnStsvY9ldpQxdi0SSFNS4a0xiObxk/edit?ouid=100243958128504204165#heading=h.h2ldv8hu2ywm)). Il gruppo concorda di collaborare per definire quali informazioni siano essenziali ([01:26:00](https://docs.google.com/document/d/1roHKiiF8qSlvqCnStsvY9ldpQxdi0SSFNS4a0xiObxk/edit?ouid=100243958128504204165#heading=h.awyxht6v3xp0)).
- **Revisione del Flusso degli Asset**: Elisa Migliano ed Elena Spini riconoscono che il flusso di gestione degli asset (biglietti) richiede una revisione più approfondita ([01:26:58](https://docs.google.com/document/d/1roHKiiF8qSlvqCnStsvY9ldpQxdi0SSFNS4a0xiObxk/edit?ouid=100243958128504204165#heading=h.druz6a77lel)). Decidono di fissare un meeting dedicato dopo il 17 agosto, includendo anche Rebecca Marmo per allinearsi sui flussi e sui campi necessari ([01:27:44](https://docs.google.com/document/d/1roHKiiF8qSlvqCnStsvY9ldpQxdi0SSFNS4a0xiObxk/edit?ouid=100243958128504204165#heading=h.arfvqt9an62i)).
- **Processo di Check-in e Documentazione**: Sabatino Rinaldi e Elena Spini definiscono il processo di emissione della documentazione: una volta inseriti i dati, ogni partecipante riceve un documento con il proprio QR code ([01:30:29](https://docs.google.com/document/d/1roHKiiF8qSlvqCnStsvY9ldpQxdi0SSFNS4a0xiObxk/edit?ouid=100243958128504204165#heading=h.z38es1p4tv4z)). Viene stabilito che lo stato del biglietto rimane "Disponibile" fino all'invio della documentazione, diventando poi "Assegnato" e infine "Utilizzato" al momento dell'evento ([01:32:57](https://docs.google.com/document/d/1roHKiiF8qSlvqCnStsvY9ldpQxdi0SSFNS4a0xiObxk/edit?ouid=100243958128504204165#heading=h.vcgp2tc7tmfx)).
- **Logica di Disponibilità dei Biglietti**: Elisa Migliano ed Elena Spini chiariscono che un biglietto diventa "Disponibile" solo quando la fattura relativa alla specifica riga d'ordine (o tranche di pagamento) è integralmente saldata ([01:33:49](https://docs.google.com/document/d/1roHKiiF8qSlvqCnStsvY9ldpQxdi0SSFNS4a0xiObxk/edit?ouid=100243958128504204165#heading=h.ct5bc71x0m2l)) ([01:41:19](https://docs.google.com/document/d/1roHKiiF8qSlvqCnStsvY9ldpQxdi0SSFNS4a0xiObxk/edit?ouid=100243958128504204165#heading=h.5urvyx9fw5ax)). Se un bundle comprende più eventi, la disponibilità segue il pagamento della rata/tranche specifica di competenza ([01:38:31](https://docs.google.com/document/d/1roHKiiF8qSlvqCnStsvY9ldpQxdi0SSFNS4a0xiObxk/edit?ouid=100243958128504204165#heading=h.z9gtjnamikl8)) ([01:42:32](https://docs.google.com/document/d/1roHKiiF8qSlvqCnStsvY9ldpQxdi0SSFNS4a0xiObxk/edit?ouid=100243958128504204165#heading=h.3jcqzknok41v)).
- **Implementazione Tecnica del Match Pagamenti**: Aurel mrruku, Elisa Migliano ed Elena Spini concordano sulla necessità di far arrivare la fattura su Salesforce per confermare il pagamento delle righe d'ordine ([01:47:07](https://docs.google.com/document/d/1roHKiiF8qSlvqCnStsvY9ldpQxdi0SSFNS4a0xiObxk/edit?ouid=100243958128504204165#heading=h.w9t2x3vxvywf)). Utilizzeranno il numero di riga d'ordine come elemento chiave per collegare la fattura ai prodotti e verificare la disponibilità dei biglietti, superando potenziali complicazioni tecniche legate ai nomi dei prodotti ([01:48:20](https://docs.google.com/document/d/1roHKiiF8qSlvqCnStsvY9ldpQxdi0SSFNS4a0xiObxk/edit?ouid=100243958128504204165#heading=h.7hy9sfyvgdx9)).
- **Gestione Casi Limite e Cambio Nominativo**: Elena Spini, Elisa Migliano e Sabatino Rinaldi discutono come gestire cambi di nome o l'assenza di QR code al momento del check-in ([01:50:41](https://docs.google.com/document/d/1roHKiiF8qSlvqCnStsvY9ldpQxdi0SSFNS4a0xiObxk/edit?ouid=100243958128504204165#heading=h.tk4vyyi55y4o)). Viene proposta la creazione di una funzionalità "caso limite" che permetta al personale di gestire manualmente la sostituzione di un partecipante, inserendo i nuovi dati e permettendo, se necessario, il rinvio della documentazione aggiornata ([01:54:10](https://docs.google.com/document/d/1roHKiiF8qSlvqCnStsvY9ldpQxdi0SSFNS4a0xiObxk/edit?ouid=100243958128504204165#heading=h.fkt06lwrp5jy)).
- **Gestione cambio nominativo sui biglietti**: Quando si verifica un cambio di nominativo tra l'emissione del biglietto e l'evento, il sistema consentirà di annullare il vecchio nominativo e inserirne uno nuovo tramite un pulsante dedicato ([01:56:42](https://docs.google.com/document/d/1roHKiiF8qSlvqCnStsvY9ldpQxdi0SSFNS4a0xiObxk/edit?ouid=100243958128504204165#heading=h.1l2esqryamjg)). A seguito di questa operazione, verrà inviata un'email informativa contenente i dati corretti e un nuovo codice QR aggiornato, garantendo che il check-in all'evento avvenga con le informazioni corrette ([01:58:00](https://docs.google.com/document/d/1roHKiiF8qSlvqCnStsvY9ldpQxdi0SSFNS4a0xiObxk/edit?ouid=100243958128504204165#heading=h.neuowh4azu10)).
- **Gestione partecipanti senza documentazione**: Per i partecipanti che arrivano senza documenti stampati o che dichiarano di non aver ricevuto l'email, il personale verifica l'esistenza del biglietto, dell'ordine e del pagamento all'interno del sistema. Una volta verificata la validità, il partecipante compila un contratto cartaceo e il personale inserisce manualmente i dati nel sistema per completare la procedura di check-in ([01:59:32](https://docs.google.com/document/d/1roHKiiF8qSlvqCnStsvY9ldpQxdi0SSFNS4a0xiObxk/edit?ouid=100243958128504204165#heading=h.olq4tds9ghii)) ([02:02:13](https://docs.google.com/document/d/1roHKiiF8qSlvqCnStsvY9ldpQxdi0SSFNS4a0xiObxk/edit?ouid=100243958128504204165#heading=h.wxrwcdrm5xjl)).
- **Integrazione Maxal e mappatura campi**: Per risolvere le difficoltà di mappatura dei campi nell'integrazione con Maxal, Andrea invierà un file contenente le domande aperte ([02:02:13](https://docs.google.com/document/d/1roHKiiF8qSlvqCnStsvY9ldpQxdi0SSFNS4a0xiObxk/edit?ouid=100243958128504204165#heading=h.wxrwcdrm5xjl)). Elisa Migliano si occuperà di rispondere a tali quesiti, coinvolgendo, se necessario, il personale di Creosoft, mentre il lavoro di mappatura dei campi nel modello dati è attualmente in corso con completamento previsto per il giorno successivo ([02:04:04](https://docs.google.com/document/d/1roHKiiF8qSlvqCnStsvY9ldpQxdi0SSFNS4a0xiObxk/edit?ouid=100243958128504204165#heading=h.cujh5429smy)).
- **Integrazione con WooCommerce**: Dopo un'analisi delle opzioni disponibili, è stato deciso di procedere con l'utilizzo dei webhooks per l'integrazione con WooCommerce, basandosi sul documento di analisi precedentemente condiviso ([02:06:22](https://docs.google.com/document/d/1roHKiiF8qSlvqCnStsvY9ldpQxdi0SSFNS4a0xiObxk/edit?ouid=100243958128504204165#heading=h.4s2vmetvhi2s)). Sabatino Rinaldi inizierà a lavorare sulla configurazione, includendo lo scambio di credenziali e prove di payload, al rientro dalle ferie, a partire dal 26 agosto ([02:07:18](https://docs.google.com/document/d/1roHKiiF8qSlvqCnStsvY9ldpQxdi0SSFNS4a0xiObxk/edit?ouid=100243958128504204165#heading=h.na8scf8a7cya)).
- **Verifica Partita IVA e qualità dei dati**: Per prevenire problemi di fatturazione derivanti da partite IVA errate, è stato stabilito di automatizzare una chiamata API a un servizio di informazioni aziendali al momento della creazione del primo ordine di un account ([02:10:02](https://docs.google.com/document/d/1roHKiiF8qSlvqCnStsvY9ldpQxdi0SSFNS4a0xiObxk/edit?ouid=100243958128504204165#heading=h.ky9zkshov6e1)) ([02:15:46](https://docs.google.com/document/d/1roHKiiF8qSlvqCnStsvY9ldpQxdi0SSFNS4a0xiObxk/edit?ouid=100243958128504204165#heading=h.7cvodgp5vf2j)). Questa procedura consentirà di recuperare i dati ufficiali e aggiornare direttamente il sistema di gestione; in caso di errore o partita IVA non valida, verrà inviata una notifica via email all'amministrazione per la correzione manuale, con il supporto di Andrea Carmeggiani al rientro dalle vacanze ([02:13:09](https://docs.google.com/document/d/1roHKiiF8qSlvqCnStsvY9ldpQxdi0SSFNS4a0xiObxk/edit?ouid=100243958128504204165#heading=h.nxue6let7ra1)) ([02:18:03](https://docs.google.com/document/d/1roHKiiF8qSlvqCnStsvY9ldpQxdi0SSFNS4a0xiObxk/edit?ouid=100243958128504204165#heading=h.ok2rvkikuf)).
- **Gestione e assegnazione dei lead**: Attualmente i lead vengono gestiti in una coda unica, ma è stato discusso di implementare logiche di distribuzione più avanzate basate sulla regione o sulla tipologia di servizio richiesto ([02:20:12](https://docs.google.com/document/d/1roHKiiF8qSlvqCnStsvY9ldpQxdi0SSFNS4a0xiObxk/edit?ouid=100243958128504204165#heading=h.n32ahbgk1zh4)). È stato stabilito che verrà garantita la possibilità di trasferire massivamente i lead tra gli utenti, e Marco fornirà i requisiti specifici una volta visionata la piattaforma reale ([02:23:03](https://docs.google.com/document/d/1roHKiiF8qSlvqCnStsvY9ldpQxdi0SSFNS4a0xiObxk/edit?ouid=100243958128504204165#heading=h.ianf11tmok2x)).
- **Input richiesti per i cataloghi e pianificazione**: Per procedere con le dimostrazioni e le configurazioni, Elisa Migliano fornirà una lista definita di articoli, eventi e bundle di esempio entro il giorno successivo ([02:25:57](https://docs.google.com/document/d/1roHKiiF8qSlvqCnStsvY9ldpQxdi0SSFNS4a0xiObxk/edit?ouid=100243958128504204165#heading=h.8r4h51o8p58a)). Per quanto riguarda la pianificazione della fase due, i dettagli verranno definiti e stimati al rientro dalle ferie, mentre la comunicazione relativa agli appuntamenti sarà gestita da Elena Spini e Marco ([02:24:17](https://docs.google.com/document/d/1roHKiiF8qSlvqCnStsvY9ldpQxdi0SSFNS4a0xiObxk/edit?ouid=100243958128504204165#heading=h.yixeaxfkrzav)) ([02:28:18](https://docs.google.com/document/d/1roHKiiF8qSlvqCnStsvY9ldpQxdi0SSFNS4a0xiObxk/edit?ouid=100243958128504204165#heading=h.cmarudfz72pu)).

_Dovresti rivedere le note di Gemini per assicurarti che siano accurate._ [_Ricevi suggerimenti e scopri come Gemini prende appunti_](https://support.google.com/meet/answer/14754931)

_Qual è la qualità di_ _**queste note specifiche?**_ [_Rispondi a un breve sondaggio_](https://google.qualtrics.com/jfe/form/SV_5bXzKQfylMIhSXc?confid=TgzXtTaHwEygDF1Uniw2DxIUOAIIigIgABgDCA&detailLevel=standard&hasImages=False&entryPoint=footerMain&isGoogler=False)_? Facci sapere cosa ne pensi e quanto le note siano state utili per le tue esigenze._***

---

# **ð Trascrizione***

-

ago 6, 2026

## **\[ROMI-PIENISSIMO\] - Chiusura ultimi punti aperti - Trascrizione**

### **00:00:11**

**Fabrizio Mastracci:** Ciao Sabatino, mi senti?

**Sabatino Rinaldi:** Ciao. Sì,

**Fabrizio Mastracci:** Ah,

**Sabatino Rinaldi:** ti sento,

**Fabrizio Mastracci:** ok, ok,

**Sabatino Rinaldi:** ti sento.

**Fabrizio Mastracci:** tutto bene. Come stai?

**Sabatino Rinaldi:** Bene, bene. Quasi pronto per le fere

**Fabrizio Mastracci:** Bene,

**Sabatino Rinaldi:** tu.

**Fabrizio Mastracci:** anche se per me le ferie so poche, però diciamo si stacco pure io sta settimana. Ehm, oggi sei da solo?

**Sabatino Rinaldi:** No, no, no, siamo siamo altre quattro persone. Siamo in quattro in teore.

**Fabrizio Mastracci:** M bene, bene. E vabbè, allora rimaniamo in attesa. Probabilmente questa più sarà più incentrata sul CRM, quindi mettiamo pure Elena. Ciao Elena.

**Elena Spini:** Ciao.

**Sabatino Rinaldi:** Ciao Elena. Yeah.

**Elena Spini:** Non sto vedendo Fabrizio. Ma quindi ho messo Fabrizio sbagliato.

**Fabrizio Mastracci:** Non ero io.

**Elena Spini:** Volevo mettere Fabrizio pienissimo.

**Sabatino Rinaldi:** E infatti a me mi sembrava

**Fabrizio Mastracci:** Bene, quindi posso staccarmi io?

### **00:01:23**

**Sabatino Rinaldi:** strano.

**Elena Spini:** Ma e e scusa Sab, arrivo anche un attimo. Scusa Fabrizio, ma Fabrizio invece pianissimo c'è.

**Sabatino Rinaldi:** Eh, dovrebbe esserci in questa colpa.

**Elena Spini:** Eh, lo so, infatti dico, ma c'è eh è in ufficio, si può collegare.

**Sabatino Rinaldi:** Sì, sì, sì, certo.

**Elena Spini:** Ok.

**Sabatino Rinaldi:** Io ho mandato il link sul

**Elena Spini:** Madonna mia, scusate. Cioè, vedi perché ho bisogno di staccare di ferri? Fabri,

**Sabatino Rinaldi:** gruppo

**Elena Spini:** scusami veramente.

**Fabrizio Mastracci:** Ness problema,

**Elena Spini:** Sì,

**Fabrizio Mastracci:** nessun problema.

**Elena Spini:** in realtà ci sono tanti appunti aperti, ma lato lato sales poi verrai aggiornato su quello, quindi ti puoi

**Fabrizio Mastracci:** Va bene. Ciao.

**Elena Spini:** staccare.

**Fabrizio Mastracci:** Buone vacanze Sabatino.

**Sabatino Rinaldi:** a te.

**Fabrizio Mastracci:** Approfitto.

**Sabatino Rinaldi:** Ciao.

**Aurel mrruku:** Ciao.

**Sabatino Rinaldi:** Ciao.

**Aurel mrruku:** Ciao.

**Fabrizio Mastracci:** Senso.

**Elena Spini:** Mannaggia.

**Aurel mrruku:** Ci serve staccare là.

### **00:02:13**

**Aurel mrruku:** Ci sei

**Sabatino Rinaldi:** Stiamo perdendo tutti i colpi, dai. È uguale per tutti.

**Elena Spini:** Ahi ahi ahi, che errore, eh.

**Sabatino Rinaldi:** Oh, vedete Marco come si vede bene così per la prima

**Elena Spini:** Ma però i casi di omonimia,

**Aurel mrruku:** una

**Elena Spini:** cioè, sono difficili da gestire.

**Sabatino Rinaldi:** volta.

**Elena Spini:** Eh,

**Marco:** Eccoci. Ciao Sabatino,

**Elena Spini:** ciao Marco.

**Marco:** vi ha già anticipato?

**Elena Spini:** No, stavamo parlando delle mie GF che ho fatto.

**Marco:** Ah, ok,

**Elena Spini:** Ho coinvolto il Fabrizio

**Marco:** Saba.

**Elena Spini:** sbagliato.

**Marco:** Ah, ok. Saba, non gli hai detto niente ancora

**Elena Spini:** Niente di niente.

**Sabatino Rinaldi:** No, non volevo farla spaventare

**Marco:** dei cambi di direzione che abbiam preso nel

**Sabatino Rinaldi:** subito.

**Marco:** frattempo?

**Sabatino Rinaldi:** No, no,

**Elena Spini:** Non è vero,

**Sabatino Rinaldi:** no, no. Davvero, è vero.

**Elena Spini:** stai scherzando.

**Sabatino Rinaldi:** Yeah.

**Marco:** Era

**Elena Spini:** Ormai mi per Vulano così.

**Marco:** un un gioco

**Elena Spini:** Mannaggia.

**Marco:** gioco,

**Elena Spini:** Nel mentre Aurel stava già

### **00:03:08**

**Aurel mrruku:** No, ti giuro, ho detto

**Elena Spini:** sventolandosi. Ti sei sentito male?

**Marco:** eh.

**Elena Spini:** Eh?

**Aurel mrruku:** Avevo già iniziato a sviluppare.

**Elena Spini:** Oddio,

**Marco:** Va bene, dai,

**Elena Spini:** no.

**Marco:** un gioco

**Elena Spini:** Stavamo ridendo del fatto, questa me la merito perché in effetti ho coinvolto Fabrizio,

**Marco:** gioco.

**Elena Spini:** che però è Fabrizio dipendente Romi che lavora sul marketing di pienissimo, ma non Fabrizio, non mi ricordo come si chiama di cognome vostro, diciamo.

**Marco:** Il boss Fabrizio

**Elena Spini:** Paganelli, esatto. Il che è grave perché avevamo bisogno anche di lui oggi.

**Marco:** Paganelli.

**Elena Spini:** Ma Sabatino gli giro io il meeting o hai girato tu il link?

**Sabatino Rinaldi:** Allora, in realtà il link ce l'hanno loro, quindi si potrebbero

**Marco:** Li vedo là,

**Elena Spini:** Se in realtà c'era Elisa.

**Marco:** eh.

**Elena Spini:** Comunque dai,

**Sabatino Rinaldi:** collegare.

**Elena Spini:** a mia discolpa,

**Marco:** Sono vivi,

**Elena Spini:** posso

**Marco:** sono vivi,

**Elena Spini:** dire

**Marco:** sono arrivano,

**Sabatino Rinaldi:** Sì, sì. No, ma l'hanno visto il link, quindi voglio capire perché non si

**Marco:** arrivano.

### **00:04:11**

**Marco:** Ho visto che Fabrizio si è messo in posizione. Arriva, eh, vedrai.

**Sabatino Rinaldi:** collegano.

**Marco:** È una è un istante.

**Elena Spini:** bene.

**Marco:** Sì.

**Sabatino Rinaldi:** E ne approfitto della pausa per dirti che Daniela ha approvato il

**Elena Spini:** Allora,

**Sabatino Rinaldi:** la timeline che mi

**Elena Spini:** ok. E per quella che è fase due vale

**Sabatino Rinaldi:** hai l'ha vista

**Elena Spini:** anche Ok,

**Sabatino Rinaldi:** tutta, mi ha dato l'ok, quindi non non mi ha chiesto niente,

**Elena Spini:** va bene.

**Sabatino Rinaldi:** nel senso l'ha vista e mi ha detto "Ok".

**Elena Spini:** E con fase due è quotata.

**Sabatino Rinaldi:** Scusa, tu nel documento che mi hai mandato c'era fase uno e fase du.

**Elena Spini:** Allora, fase due. Eh, ma poi era fase due. Sì, lo so. Fase due. Allora, aspetta, documento, documento. Benissimo.

**Sabatino Rinaldi:** a timeline con le date eccetera. Sì.

**Elena Spini:** Νา parte due. Aspetta, vabbè, adesso ormai l'ho trovata. Sto aprendo.

**Sabatino Rinaldi:** GLS Tachball ordini. Pienissimo,

### **00:06:08**

**Elena Spini:** Esatto.

**Sabatino Rinaldi:** bro.

**Elena Spini:** E vabbè.

**Sabatino Rinaldi:** No.

**Elena Spini:** Aspetta, sto riprendendo il punto perché sì, non era nel piano. Eh, pa pa. necessaria valutazione economica contrattuale con Daniele per definire se il lavoro rientra in una fase aggiuntiva quotata o potrà essere gestita internamente da pianissimo. Era la parte perimetro contrattuale fase 1 fase fase 2.

**Sabatino Rinaldi:** Dov'è scritta questa

**Elena Spini:** Confermato fase è sempre in quella minuta dove hai trovato la timeline.

**Sabatino Rinaldi:** roba?

**Elena Spini:** perimetro contrattuale. Punto critico.

**Sabatino Rinaldi:** Io non l'ho nemmeno letto quello. Ho preso direttamente il

**Elena Spini:** Fa piacere come vengono lette le mie

**Sabatino Rinaldi:** link.

**Elena Spini:** venute, però comunque era uno di quei punti che abbiamo da discutere anche oggi, però nel mentre apro il file che vi ho mandato. Dimmi se l'hai trovato.

**Sabatino Rinaldi:** Sì, sì, ho trovato la minuto.

**Andrea Di Cicco:** Ma li ammetto,

**Elena Spini:** Perfetto.

**Andrea Di Cicco:** Elisa

**Elena Spini:** Oddio, scusate.

**Andrea Di Cicco:** Fabrizio,

**Elena Spini:** Sì, bravo Andre, non sai che ho fatto.

### **00:08:06**

**Elena Spini:** Mo la senti la mia gaffa. Fabrizio,

**Andrea Di Cicco:** voglio sapere.

**Elena Spini:** scusa,

**Elisa Migliano:** Ciao. Ciao a tutti.

**Elena Spini:** ti avevo Sì,

**Elisa Migliano:** Sentite?

**Elena Spini:** ti sentiamo. Ma Fabrizio, ti avevo dimenticato e messo con un altro Fabrizio,

**Elisa Migliano:** Ah, non niente, non è un problema.

**Elena Spini:** però ho messo amministrazione per fortuna che so che la buona

**Elisa Migliano:** L'importante è che ci sia l'Elisa.

**Elena Spini:** Elisa Esatto,

**Elisa Migliano:** Io non conto niente.

**Sabatino Rinaldi:** Оп.

**Elena Spini:** infatti comunque ti avevo pensato, però ho messo Fabrizio che sta gestendo la parte di marketing, non Fabrizio te, mannaggia. Vabbè, allora GF di Elena parte. Partiamo con la registrazione. 네. Avete per caso visto la mia mail? Aperto il il documento?

**Elisa Migliano:** Sì, penso tutti in realtà.

**Elena Spini:** Ecco. Wow\! Iniziano le moticon. Allora, condivido. Allora, ho fatto una sorta di recap di quello che ci siamo detti. Leggo, confermatemi se effettivamente tutto sarà così e poi eh andiamo agli open point.

### **00:09:40**

**Elena Spini:** Qua c'è la parte di gestione lead opportunità, tutto il flusso che abbiamo visto con eh Marco, in realtà vabbè questi sono un po' tutti i vari passaggi, cioè la conversione del lead, eh flusso il tema del flusso delle dirette in realtà è una cosa che è stata è che è emersa l'altra volta che non era emersa e però ci siamo detti che eh semplicemente ci saranno dei lead che eh nasceranno dalle dirette. Questi lead eh nascono come compilano un formad con una sorta di tipizzazione diretta su Sales Force nuovo. Una volta che durante la diretta questi lead compilano un altro formedere informazioni, allora questi lead dovranno essere ehm dirett dovranno essere convertiti in opportunity. Facendo un passaggio anche con Aurel, ci vorreamo un attimo eh sincerare del fatto che questo form, che non so se è uno di quei 100 form che sono stati condivisi all'altro Fabrizio eh sali dentro. Questo chiedo a a Sabatino, eh, se possiamo magari verificare questa cosa, se se è tra quelli e se effettivamente in questi form si chiedono a al referente, quindi che compila il form, i dati quindi dei contatti e soprattutto, cosa più importante, i dati degli account, perché se vogliamo fare creare le opportunità a questi eh e farli convertire

### **00:11:11**

**Sabatino Rinaldi:** อ

**Elena Spini:** in account, contatti e opportunità, è importante avere la partita IVA perché Perché abbiamo detto che ogni azienda avrà la partita IVA come riferimento

**Sabatino Rinaldi:** dici form quelli che dovrebbero scansionare durante la

**Elena Spini:** durante la diretta. Sì,

**Sabatino Rinaldi:** diretta.

**Elena Spini:** esatto. Tipo chiedi info durante la diretta mi deve dire, cioè sì, ok, chi sei e cioè qual è il tuo ristorante?

**Sabatino Rinaldi:** Quindi il dato importante è la partita IPA, mi sta dicendo.

**Elena Spini:** Sì.

**Sabatino Rinaldi:** Ok, va bene. È un dato che ora non abbiamo nel form, ma lo possiamo aggiungere.

**Elena Spini:** Perché il il dato del contatto lo facciamo, basta che ci dà la mail e nome Ne.

**Sabatino Rinaldi:** Sì. Sì, sì, sì, sì,

**Elena Spini:** nome e il

**Sabatino Rinaldi:** sì. Noi di solito mettiamo nome, azienda e tipologia locale.

**Elena Spini:** l'account,

**Sabatino Rinaldi:** Aggiungiamo partita IVA che tanto il più delle volte mettono una partita IVA finta, ma tanto quella è una roba che si sistema quando devono pagare poi e quindi si aggiornerà il contatto. Va bene?

**Elena Spini:** non aggiungono una partita finta.

**Sabatino Rinaldi:** Sì, di solito quando gli chiedi una partita IVA in un form che non devono pagare, loro mettono partite IVE inventate, c'è chi mette 00,

### **00:12:24**

**Elena Spini:** Ok.

**Sabatino Rinaldi:** chi mette 111 1. Eh, poi ovviamente sono dati che vanno sistemati nel momento in cui loro acquistano, però lì non hai controllo perché giustamente puoi solo, cioè non puoi far niente, però va bene, nel senso non è un problema.

**Elena Spini:** E questo momento in cui si sistema questo

**Sabatino Rinaldi:** Il dato si sistema se quell'azienda paga e che quando paga gli vien chiesto

**Elena Spini:** dato?

**Sabatino Rinaldi:** di fornire partita IVA e quant'altro. Mi auguro che quel dato poi si aggiorna nell'anagrafica. Tanto succede, non dipende da noi. Molto

**Elena Spini:** Va bene. Ehm, ok. Poi vabbè, lì senza risposta i contatti. Vabbè, qua c'era la gestione dei task, gestione primo contatto e anche qua era un uno stato con un task, ma che abbiamo sempre visto in quel in quel flusso. Tracciamento dei non qualificati e con tutte le diverse tipologie che ci ha dato Marco e invece qualificato, appunto, è quando eh passiamo a account, contatto, opportunità e un'opportunità può prevedere eh più preventivi. Perfetto. flussi preventivi, ordine firme. Generazione del preventivo.

### **00:13:49**

**Elena Spini:** Il preventivo viene generato manualmente dal tutor tramite apposito comando a livello di opportunità, validità di 5 giorni per i preventivi. Ehm, qua in realtà si apre il tema sul quale ci siamo incagliati l'ultima volta del flusso. Qua sto ancora io aggiornando la parte di integrando alcuni punti rispetto al grafico di che aveva modificato Marco, ma lo sto facendo mano. E qua ci siamo fermati a questo punto. Abbiamo detto eliminazione dello Stato, accettato, copia contabile ricevuta. I documenti si fermeranno, documenti di preventivi si fermeranno con Docusin. Perfetto. Ma uno degli open point è appunto capire dove si genera l'ordine. E qui lascio la parola a voi. Avete pensato barra deciso?

**Sabatino Rinaldi:** Sì, so che si sono sentiti con Daniela su questa cosa.

**Elena Spini:** Anch'io, ma non so la risposta.

**Fabrizio Paganelli:** Mi sentite?

**Sabatino Rinaldi:** Non sei l'esito.

**Fabrizio Paganelli:** Mi sentite?

**Sabatino Rinaldi:** Sì.

**Fabrizio Paganelli:** Sì. Allora, con Daniela ci siamo chiariti.

**Elena Spini:** Sì.

**Fabrizio Paganelli:** Quindi una volta che ha detto l'Elis ha detto così che ha paura perché allora il cliente riceve

### **00:15:17**

**Elena Spini:** E già anch'io ho paura.

**Fabrizio Paganelli:** eh il cliente riceve tutto quanto, documenti, contratto, eccetera eccetera. Se decide di proseguì, se rifiuta l'offerta, il preventivo va in stato di rifiutato. Ok? Se invece procede con la firma,

**Elena Spini:** Sì.

**Fabrizio Paganelli:** quindi accetta il preventivo, firma le condizioni generali, firma il contratto, a quel punto il preventivo va in stato di accettato e nel momento in cui il preventivo va in stato di accettato si genera l'ordine e l'opportunità collegata a quel preventivo va in stato di opportunity vinta. Ho detto bene Lisa?

**Elena Spini:** Non sento Elisa se

**Sabatino Rinaldi:** Ah, come aveva detto come aveva detto Lisa l'altra volta.

**Elena Spini:** parla.

**Sabatino Rinaldi:** Yeah.

**Fabrizio Paganelli:** Sì, sì. Mi mi mandate la registrazione per cortesia della della cosa dell'altra volta che l'Elis la deve

**Elena Spini:** Dice

**Fabrizio Paganelli:** ascoltare?

**Elena Spini:** la registrazione dell'altra volta in quale? Dove ci

**Fabrizio Paganelli:** La registrazione della call dell'ultima call dove io e Elisa non eravamo d'accordo.

**Elena Spini:** siamo?

**Fabrizio Paganelli:** Quella lì se me la mandate, anzi mandatela l'Elisa che la devo

### **00:16:50**

**Elena Spini:** Certo.

**Fabrizio Paganelli:** ascoltare.

**Elena Spini:** Ok. Aspetta. Ma posso farlo anche dopo?

**Fabrizio Paganelli:** No,

**Elena Spini:** Lo vuoi adesso?

**Fabrizio Paganelli:** no, va bene anche se ce lo mandi dopo le ferie.

**Elena Spini:** Va bene. Ok. Ehm, me lo segno io. Quindi, quindi in realtà, come l'avevamo detto già all'inizio, accettato. Accettato. Si crea

**Fabrizio Paganelli:** Esattamente.

**Elena Spini:** l'ordine.

**Sabatino Rinaldi:** Ma vogliamo far finta che questa cor l'abbiamo già fatta? Chiudiamo e ci facciamo gli auguri di buone ferie, per favore.

**Elena Spini:** No, Elisa ha detto che vuole vedere cosa ha sbagliato. Ma per me non è un problema. Ti mando la registrazione. Solo capire dove l'ultima registrazione di settimana scorsa. Va bene.

**Fabrizio Paganelli:** Io qui non so se quel chiuso quel chiuso acquisito che c'è dopo quell accettato,

**Elena Spini:** Allora, quindi esatto,

**Fabrizio Paganelli:** rifiutato non ha più senso.

**Elena Spini:** adesso, aspetta, infatti arrivavo qua, quindi accettato. Oddio,

**Fabrizio Paganelli:** M.

### **00:17:56**

**Elena Spini:** accettato. si creerà l'ordine, poi sistemo Ehm, prendiamo per vero che il cliente pagherà perché in realtà, cioè, poi aspetta, in realtà quest'ordine si creerà dopo qua sotto perché prima c'è invio email con preventivo con condizioni accettato o rifiutato che poi adesso vi spiego la la nostra idea su questo e poi a questo punto si crea l'ordine se accetta. Ok.

**Fabrizio Paganelli:** Quindi diciamo che la il cambiamento di stato inaccettato è un automatismo che deriva dalla dalla fase di firma dei documenti. Dico

**Elena Spini:** Adesso vi dico questo. Esatto.

**Fabrizio Paganelli:** bene?

**Elena Spini:** Cioè noi ci siamo immaginati così questo questo giro, capiamo se ha senso anche per voi. Noi abbiamo pensato, ok, arriviamo qua, siamo in attesa, anzi siamo in attesa accettazione o in trattativa. Vabbè, a un certo punto, anzi no, scusa, in trattativa gli mandiamo il preventivo. È in trattativa che mandiamo il preventivo, non è qua.

**Fabrizio Paganelli:** E è prima dell'accettazione

**Elena Spini:** Eh,

**Marco:** Corretto in trattativa.

**Elena Spini:** infatti è in

**Marco:** In trattativa da dove partono i 5 giorni.

### **00:19:21**

**Elena Spini:** trattativa. Esatto.

**Fabrizio Paganelli:** Allora,

**Marco:** Qualcun

**Elena Spini:** Quindi questo va spostato qua sotto, poi si creerà l'ordine, se accetta. Vabbè, poi sistemo. Quindi allora siamo in trattativa e inviamo il preventivo e e qua c'era Elisa che diceva "Sarebbe carino mandare un bottone accetto rifiuto". Ora, dal sarebbe carino a effettivamente farlo con con salesource è ehm è un po' più difficile. Quindi quello che abbiamo pensato è e vi vorremmo

**Fabrizio Paganelli:** Aspetta.

**Elena Spini:** proporre oggi è quando mandiamo il la mail con il preventivo diciamo perfetto, se vogliamo lo possiamo già allegare il preventivo, però gli diciamo al cliente per accettare o rifiutare, anziché mettere su un bottone, vai segui questo link, lui clicca questo link, finisce su una landing page a cui portrà vedere di nuovo il contratto se lo vuole oppure pigiare accetto rifiuto. Quindi l'accetto rifiuto non sarà nella mail, ma sarà in questo link che verrà rimandato a una landing page. Perché va fatto così? Perché in realtà, cioè noi non abbiamo mh eh controllo su quello che mandiamo a livello di email. noi dobbiamo per forza, cioè, rimanere sul CRM e il staccare una landing page lo possiamo fare come lo facciamo nella gestione della lista dei partecipanti agli

### **00:21:05**

**Fabrizio Paganelli:** Ma quindi però è questo e questo è fond voglio capire lo

**Elena Spini:** eventi.

**Fabrizio Paganelli:** stato del preventivo che va lo stato del preventivo che va inaccettato e dopo che il cliente ha non solo accettato il preventivo in quella ma deve avere anche firmato il contratto.

**Elena Spini:** Allora, lui ha quello che succederà. Esatto. Aspetta, mi son persa un pezzo. È vero. Eh,

**Fabrizio Paganelli:** Ok.

**Elena Spini:** lui ha ha pigiato su accettato e poi eh una volta che pigia su accettato gli mandiamo il preventivo via mail tramite Docusign. Quindi lui riceverà una mail di Docusign, firma e una volta che firma sarà inaccettato. Quindi qua ci vuole una altra freccia. Aurel, correggimi se dico cose sbagliate.

**Aurel mrruku:** No.

**Elena Spini:** Ok. Bene. Quindi qua ci va la la il giro così. Ovviamente eh sarebbe la stessa cosa se siamo in attesa accettazione perché sono finiti i 5 giorni. Lui clicca, magari dopo, non so,

**Fabrizio Paganelli:** Ecco.

**Elena Spini:** due settimane di ferie, finirebbe sempre sulla stessa landing page, finirebbe in accettato e allora quando accetta c'è l'ordine.

### **00:22:19**

**Elena Spini:** Brutta piacere,

**Fabrizio Paganelli:** Ok.

**Elena Spini:** poi la devo sistemare e ve la mando ovviamente.

**Fabrizio Paganelli:** C'è l'ordine e l'opportunity che va in

**Elena Spini:** Esatto,

**Fabrizio Paganelli:** vinta.

**Elena Spini:** questo è accettato. Si crea l'ordine. Se seguiamo qua l'opportunity va in chiusa vinta.

**Fabrizio Paganelli:** Sì. E quando vai invento l'opportunity incassato anche la mailera.

**Elena Spini:** La cosa che ci aveva fatto un po' discutere l'altra volta era questo chiuso acquisito con effettivamente il check dell'amministrazione manuale. Posso cancellarlo?

**Fabrizio Paganelli:** che e però ti faccio una rettifica, scusami Elena, perché l'opportunity deve questo qui confesso,

**Elena Spini:** Sì.

**Fabrizio Paganelli:** mi era sfuggito a me in questo momento, l'opportunity deve andare invinto quando l'ordine, perché poi dopo l'ordine avrà le sue fasi, no? avrà ordine in stato di ordinato, ordine in stato di fatturato, ordine in stato di incassato. Lo la l'opportunity deve andare in vinto quando l'ordine assume lo stato di incassato

**Elena Spini:** Allora, mettiamolo subito qua. Ordine.

### **00:23:50**

**Elena Spini:** Stati.

**Fabrizio Paganelli:** ordinato. fatturato

**Elena Spini:** Sì. Ok,

**Fabrizio Paganelli:** incassato.

**Elena Spini:** perfetto. In realtà poi

**Fabrizio Paganelli:** Dopo potrà avere uno stato di perso se ci faccio una nota di credito.

**Elena Spini:** quindi

**Fabrizio Paganelli:** Non lo so come funzionerà, insomma. Però quelli lì sono i quelli

**Elena Spini:** chiusa,

**Fabrizio Paganelli:** fondamentali.

**Elena Spini:** vinta c'è più qua. Questo chiuso acquisito. Posso cancellarlo?

**Fabrizio Paganelli:** Sì,

**Elena Spini:** Non c'è più questo aggiornamento manuale.

**Fabrizio Paganelli:** sì, non serve più.

**Elena Spini:** Perfetto, vi siete coordinati. Ma eh quindi allora in attesa accettato, il preventivo va in accettato, ma chiuso, vinto ci va solo quando l'ordine è in

**Fabrizio Paganelli:** Incassato.

**Elena Spini:** fatturato. Ah, no, inato.

**Fabrizio Paganelli:** Cassato.

**Elena Spini:** Non so f così. Ok, poi lo sistemo io e E questi sono gli stati per ora degli ordini, poi capiamo perché in realtà mi sembrano troppo pochi. Perfetto, siamo tutti d'accordo? E e il giro del link vi va bene?

### **00:25:54**

**Elena Spini:** Elisa, brava.

**Elisa Migliano:** Sì, sì,

**Fabrizio Paganelli:** Sì,

**Elisa Migliano:** tanto ci cambia poco comunque che caderà su sul link

**Elena Spini:** E no, infatti, infatti, però così è più gestibile.

**Fabrizio Paganelli:** che sia nella mail come ci viene più comodo,

**Elisa Migliano:** o viene più comodo,

**Fabrizio Paganelli:** cioè come

**Elena Spini:** Perfetto.

**Elisa Migliano:** quindi va bene. No.

**Elena Spini:** Invio invio mail con preventivo più contratto condizioni generali con LINP per direct. Perché vomiti?

**Sabatino Rinaldi:** Ah, volevo provarne uno nuovo. M.

**Elena Spini:** No, l'avevo già scritto. Aspetta, invio mail con link con link per directending page con preventivo più contratto con condizioni generali e Okay. rifiuto per il preventivo. Perfetto. Sceglie, accetta. Mandiamo i documenti e si crea l'ordine, tanti cari saluti e abbiamo finito questo giro. Dio, non mi sembra vero. Ok. Poi eh firma documenti di Docusign invece

**Marco:** Zione.

**Elena Spini:** per la parte dei biglietti, la vediamo dopo, rimarrà cartacea. Per quanto riguarda invece le opportunità per il servizio di Performance Plus, eh questo l'avevamo detto l'altra volta e volevo un attimo ribadirlo con voi.

### **00:27:39**

**Elena Spini:** Quindi qua siamo nel giro ordini. nel giro ordini tutti eh poi vediamo tutti i punti sul su Wcommerce, lo vediamo tra poco. Eh le ehm diciamo azioni

**Fabrizio Paganelli:** Sì.

**Elena Spini:** in carico al tutor che è questo omino, eh saranno di creare opportunity che sono m qualsiasi tipologia di vendita che vuole tramite preventivi, se ne avrà bisogno o che ne so io. link li vediamo dopo, ripeto, oppure vendita di servizio di performance plus. In questi entrambi in questi casi è il tutor che quando andrà a creare un'opportunità su Sales Force dovrà tipizzare l'opportunity,

**Fabrizio Paganelli:** Eco.

**Elena Spini:** cioè ci sarà un campo a tendina che dice sto facendo una vendita da tutor quindi semplice, sto facendo un servizio di di performance Plus con indicazione se è attivazione o rinnovo. Perché ci serve questo? Perché poi noi questo dato lo portiamo su a livello di ordine. Ci serve perché a livello di ordine una volta che ci scende l'ordine che è un order type di tipo plus allora noi sappiamo che dobbiamo andare a fare il contratto. Vi torna. No.

**Fabrizio Paganelli:** Chi deve rispondere qui?

**Sabatino Rinaldi:** Tu? M.

**Elena Spini:** E allora c'è Marco che è quello che è il tutor e se torna anche a te Fabrizio che era era il punto importante di avere i contratti e insomma avere tutti questi tipizzazione tipizzazione di ordini, ma più che a te in effetti è più per noi per capire come fare a creare il

### **00:29:37**

**Fabrizio Paganelli:** Sì.

**Elena Spini:** contratto.

**Marco:** Cioè nella parte qui della vendita da tutlo ci sta, cioè questo è quello che già comunque facciamo il commerciale Qual è?

**Elena Spini:** Cioè, quando tu venderai,

**Marco:** Sì.

**Elena Spini:** cioè farai un'offerta, un preventivo di servizio performance Plus in opportunity dovrei mettermi

**Marco:** Sì, aggiornati.

**Elena Spini:** obbligatoriamente che è opportunity type è di tipo performance plus perché poi a me serve a livello di ordine e se non me lo metti a livello di

**Fabrizio Paganelli:** Да.

**Elena Spini:** offerta che è un tipo un tipo di performance plus io non lo posso sapere perché l'altra volta avevamo pensato di farlo tramite eh product code, però avevate detto che avevate troppa fantasia sui product code e quindi è un'azione manuale. manuale in fase di creazione dell'opportunity, ovviamente.

**Fabrizio Paganelli:** Ci sta.

**Elena Spini:** Perfetto, ho sentito un ci sta e vado avanti.

**Fabrizio Paganelli:** Sì, lo diceva lo diceva l'Elis. Non niente,

**Elena Spini:** Marco.

**Fabrizio Paganelli:** ma penso che non ci siano problemi.

**Marco:** Is ragazzi, ma cioè è cioè secondo me sì,

**Fabrizio Paganelli:** Esatto.

**Marco:** adesso non lo so, la titubanza di tutti crea una titubanza anche mia, poi chi ha più esperienza di quelli che sono i

### **00:30:56**

**Fabrizio Paganelli:** No,

**Elena Spini:** Vabbè,

**Elisa Migliano:** Non dicevo nulla perché non erano

**Elena Spini:** poi una in realtà è più semplice di quanto sembra.

**Marco:** processi,

**Elena Spini:** In realtà una volta che vedete la piattaforma che è un un semplicemente un campo in più da

**Fabrizio Paganelli:** io

**Elena Spini:** completare capirete che è niente.

**Marco:** però concettualmente concettualmente è corretto,

**Elena Spini:** Però io intanto l'ho dovuto scrivere.

**Marco:** cioè di di fare questa distinzione ed è giusto che la faccia che la che la che la gestisca

**Elena Spini:** Perfetto,

**Marco:** il tutor che poi deve andare a generare il contratto. Что?

**Elena Spini:** perfetto. Ottimo. Bundle. Bundle e tracciamento vendite da Wcommerce.

**Fabrizio Paganelli:** Scusami, scusami. Eh, sul discorso dei contratti funziona come il principio vale quello che abbiam detto

**Elena Spini:** Vai.

**Fabrizio Paganelli:** prima,

**Elena Spini:** Che senso? Non abbiamo mai parlato di

**Fabrizio Paganelli:** perché diciamo che nell'ambito della performance plus poi dopo che anche lì c'è tutto il cinema del

**Elena Spini:** prima.

**Fabrizio Paganelli:** contratto, quindi è preventivo, accettato a firma del contratto quando vale lo stesso.

**Elena Spini:** Segue sempre il giro.

### **00:31:52**

**Elena Spini:** Esatto, segue sempre il giro del mando tutto,

**Fabrizio Paganelli:** Ok.

**Elena Spini:** mando la mail. Il cliente deve andare sul su questo link, fare accettato e sembra mi sembra che c'era anche il contratto. Sì, esatto. Mandiamo preventivo, contratto, condizioni generali e sarà tutto nell'unico PDF,

**Fabrizio Paganelli:** Ok.

**Elena Spini:** accetta rifiuto, giro normale.

**Fabrizio Paganelli:** Ok.

**Elena Spini:** Perfetto. E poi questo contratto in realtà è proprio contratto e oggetto su Sales

**Fabrizio Paganelli:** Posso?

**Elena Spini:** Force che ci permette a noi di andare ah ecco un'altra cosa che adesso mi è venuto in mente da dire. Ehm, nei casi di ehm eh per eh opportunity performance di servizio di performance plus, eh la data di inizio fine voi la mettete a livello di contratto, sarà un campo che ci sia dato inizio fine perché poi a noi serve qua dato inizio

**Fabrizio Paganelli:** No,

**Elena Spini:** fine.

**Fabrizio Paganelli:** nel contratto non c'è,

**Elena Spini:** il contratto non c'è,

**Fabrizio Paganelli:** anche perché in realtà No.

**Elena Spini:** cioè potenzialmente ci potrebbe essere nell'opportunity in riferimento a questo

**Elisa Migliano:** Ora SNI,

**Elena Spini:** contratto?

**Elisa Migliano:** nel senso che una volta veniva messa, ma non è la data di fine data d'inizio effettiva, perché poi sicuramente ci possiamo anche strutturare diversamente per cioè per venirci incontro, però quando il tutor fa il l'ordine, Marco, correggimi se sbaglio non sa ancora effettivamente quando partirà al servizio perché magari il reparto in quel mese pieno o il cliente magari decide di partire, quella fine non parte, parte più avanti, cioè ci sono mh più più casistiche,

### **00:33:36**

**Elisa Migliano:** insomma. M.

**Marco:** Sì, sì, è corretto. nel senso che la data di firma del contratto in questo caso non è la data di inizio del servizio, quindi in realtà la può essere che il servizio, proprio anche perché noi abbiamo magari siamo siamo pieni di scadenze da da gestire, il cliente va in coda e magari mi firma il contratto oggi, ma io in realtà parto tra una settimana, tra 20 giorni, tra un mese per assurdo. Quindi è da lì che poi la, diciamo, parte realmente la data di inizio del servizio. Quella di sopra è la data di scadenza del

**Elena Spini:** อ Vi faccio questa proposta. Vi faccio questa proposta. Eh, Aurel, sentimi se dico cavolate.

**Marco:** contratto.

**Elena Spini:** Allora, idealmente mi mi immagino,

**Aurel mrruku:** Sì.

**Elena Spini:** noi creiamo un contratto vuoto, ci sarà un banner che indica a il che il tutor vedrà che non ha messo tipo ad esempio banner a livello di pagina che dice attenzione per questo contratto non ha ancora messo data inizio fine. Quando effettivamente il il tutor aprirà quella pagina e vedrà il banner, mette e il banner sparisce.

**Marco:** Eh, Elena, intervengo subito qua. Il tutor direi di no, ma è una cosa nostra interna. L'importante è che si possa mettere,

### **00:34:49**

**Elena Spini:** Vai\!

**Marco:** eh, riferendomi adesso invece a Elisa e Fabrizio, direi che qui potrebbe essere lo strategist che è quello che dà effettivamente inizio al

**Elisa Migliano:** Sì, assolutamente.

**Marco:** servizio ad andare lì dentro e mettere per la data di quando

**Elena Spini:** Possiamo anche inviare una mail,

**Aurel mrruku:** Ma io lo farei lo farei.

**Marco:** saizio

**Elena Spini:** eh, potenzialmente.

**Aurel mrruku:** Mi sentite?

**Elena Spini:** Sì, sì.

**Aurel mrruku:** Ma perché non lo mettiamo nel momento in cui cercate di inserire le righe

**Marco:** da dire che io gli ho

**Aurel mrruku:** d'ordine?

**Elena Spini:** Ma no,

**Fabrizio Paganelli:** Eh, lo dicevo adesso,

**Elena Spini:** ma perché non

**Fabrizio Paganelli:** perché noi

**Elisa Migliano:** Cioè, non abbiamo una data certa di quando finalmente parte il servizio.

**Elena Spini:** non

**Marco:** detto

**Elisa Migliano:** S.

**Aurel mrruku:** Ok. Ok. Perché l'ha già spiegato Elena ieri, ma ci ho

**Elena Spini:** eh ma poi,

**Aurel mrruku:** provato.

**Marco:** che

**Elena Spini:** cioè in realtà io glielo volevo far mettere all'opportunity e poi adesso mi hanno detto che in realtà non potevano metterlo lì. Siamo tu sei sceso alle lighe d'ordine,

### **00:35:42**

**Aurel mrruku:** Ok.

**Elena Spini:** ma siamo arrivati al contratto.

**Marco:** no, ma non lo posso non lo possono mettere perché non lo sanno perché non ce l'hanno quel dato.

**Elena Spini:** No, ma infatti, ma senso potenzialmente,

**Marco:** Quindi là laggiù dove c'è scritto dove tutto toglilo.

**Elena Spini:** cioè eh mi viene in mente,

**Marco:** Toglilo,

**Elena Spini:** scusa. Ah, sì. Yeah. Chi devo

**Marco:** metti direttamente metti strategist,

**Elena Spini:** mettere?

**Marco:** poi sappiamo noi che vuol dire che è lo strategist della PL, che è quello che poi fa partire il servizio in fase alle disponibilità che

**Elena Spini:** Trate.

**Marco:** ha.

**Elena Spini:** Ehm, aspetta, mi mettere anche un'altra idea. Potenzialmente possiamo fare sia banner così che vede subito parlante e se vuole possiamo anche mandargli una mail a questo user strategies.

**Marco:** Non lo so. Vabbè, male male non fa. Amen. E niente, ti volevo avvisare che a lui anche l'altro abbiamo

**Elena Spini:** Ma proprio banale,

**Marco:** fatto

**Elena Spini:** eh. C'è attenzione, c'è un contratto che cui devi mettere la Sì,

**Marco:** è un alert, no? Un reminder che quella cosa va fatta.

**Elena Spini:** esatto,

**Marco:** Quindi in questa fase iniziale,

### **00:36:45**

**Elena Spini:** esatto.

**Marco:** siccome una nuova procedura che noi oggi non abbiamo, eh secondo me ci sta. Poi una volta che ci si prende la mano sanno che lì devono andarci a mettere quella che è la data di inizio reale dell'attività. No, non è che li vedi su Twitch. Giù li porti

**Elena Spini:** più email

**Marco:** sotto

**Elena Spini:** e sarà sempre uno user, tra l'altro.

**Marco:** sono sono due gli strategisti. Sì, sì, l'ho già preso.

**Elena Spini:** Ok,

**Marco:** Ma dove sei? Poi non so se loro hanno probabilmente una mail unica, eh diciamo di reparto e ci dicono di di mandarla lì, magari mandiamo una mail unica,

**Elena Spini:** noi lo mandero.

**Marco:** poi se la smazzano loro.

**Elena Spini:** Ok, per ora scrivo così.

**Marco:** Sì, sì, va bene.

**Elena Spini:** Ok.

**Elisa Migliano:** Prima delle 5. Sono

**Elena Spini:** Poi

**Elisa Migliano:** emozionata.

**Elena Spini:** cosa?

**Fabrizio Paganelli:** Ho detto dai che oggi finiamo il primo

**Elisa Migliano:** Cinque.

**Elena Spini:** Sì.

**Elisa Migliano:** Sono emozionata.

**Elena Spini:** No, aspetta perché c'è tutta la parte di open point.

**Marco:** Ma non si dicono ste cose, Eli, non si dicono ste cose.

**Elena Spini:** Non siamo appena all'inizio.

**Marco:** Sì.

**Elena Spini:** Ehm, ok.

### **00:38:03**

**Elena Spini:** Eh, no, aspetta, questo era Performance Plus. Ok, siamo passati adesso un attimo alla generazione link di pagamento eh per il giro invece eh del ehm Wcommerce, quindi in realtà qua siamo un attimo qua sopra, abbiamo detto che ci sono delle casistiche in cui a volte parliam inizialmente si era la discussione era nata per quell'opportunità che dovevano essere create al tutor come recall perché magari eh non era andata la

**Fabrizio Paganelli:** Così

**Elena Spini:** vendita da palco a fronte di un particolare evento, allora c'è la la situazione di recall del tutor. Questo poi abbiamo parlato anche di tante altre altre casistiche, però abbiamo detto che non è un problema perché basta che il tutor arriverà su É. force si crea l'opportunity e ehm nel eh in fase di creazione dell'opportunity queste recall tutor tipizzate in questo modo vedrà il bottone crea link. Questo bottone crea link verrà ehm verrà praticamente eh creerà il carrello di Wcommerce con l'ID dell'opportunity e quello che succederà è che eh verrà inviata una mail. Aspetta, eh, prendela qua. Eh, ho detto tutto. Il link di checkout di Wcommerce tramite bottone, anzi verrà anche selezionata la tipologia di prodotto e la quantità e appunto ci sarà questo link che si formerà conterrà l'ID dell'opportunity salesce.

### **00:39:50**

**Elena Spini:** Questo ci permette di eh inviare questo link al cliente tramite mail. Quindi, una volta che si viene generato il il link, invio alla mail al cliente, proponiamo noi un template, intanto che non ce ne date uno. Eh, non lo so. Grazie. Per finire il l'acquisto, clicca qui, clicca qui il cliente, finisce sul carrello di Wcommerce, paga e cenderà un ordine normalissimo di Wcommerce. Torniamo qua e basta. Perfetto, ne avevamo già parlato l'altra volta di fondo. Ottimo. Poi, eh giusto per essere tutti più allineati e e sicuri di quello che ci state detto in queste ultime riunioni, un po' di caos, ho messo anche qua i bandol doppio a sistema non servono più perché all'inizio avevamo detto che servivano due bandi il doppio, uno da palco e una recall tutor. Invece abbiam detto che bassa, cioè il bundle sarà sempre solo uno incarico all'amministrazione, i bundle verranno creati sempre e solo su Sales Force, mentre tutti gli altri prodotti singoli verranno creati su Mexal e poi mandati a Sales Force. Ehm, non ci serve più perché eh di fondo eh, aspetta, cosa ho scritto?

### **00:41:26**

**Elena Spini:** Il tutor può vendere lo stesso perché l'origine della vendita da palco o da tutto viene distingua come segue. Ah, sì, vabbè. Da palco. Ehm, per le vendite da palco abbiamo detto che ci sarà un codice prodotto che viene ehm definito su Sales Force e poi detto eh che deve eh essere usato a Wcommerce in modo manuale e a voce. non c'è mh nessun nessun tipo di passaggio. E invece il recall da tutor è un'azione che viene

**Aurel mrruku:** M.

**Elena Spini:** inserita come tipizzazione direttamente dal tutor, come prima che doveva dire che quello era un ordine di performance plus, ci sarà la voce recall tutor e fine. In questo modo possiamo differenziare le opportunity, le due tipologie di opportunity. Perfetto. Altra cosa da chiarire, non per quanto riguarda i bundle non sono previsti controlli e logiche per l'associazione di prodotti vari dei bundle. Sarà onere dell'amministrazione capire che cosa mettere in un bundle piuttosto che in un altro senza controlli.

**Fabrizio Paganelli:** Puoi ripetere, scusa.

**Elena Spini:** Sì.

**Fabrizio Paganelli:** Eh, in riferimento ai bundle, puoi ripetere questo primo passaggio per cortesia?

**Elena Spini:** Eh, quello del recall tutto

**Fabrizio Paganelli:** Non ho della banda hai detto non c non sono previsti i controlli.

### **00:42:58**

**Elena Spini:** ah i controlli, ad esempio, eh se su cioè crei il bundle su Sales Force e metto il prodotto A e il prodotto B. Il prodotto Cete che non deve essere messo in quel bundle, ma non c'è un controllo che mi dica attenzione, stai mettendo il prodotto C.

**Fabrizio Paganelli:** Però questa cosa qui mi pare che non l'avevamo detto con Aurel l'altra volta chegavamo i prodotti in modo tale che potessero essere usati sì o no nei Bundle.

**Aurel mrruku:** Sì, sì, abbiamo detto, anzi abbiamo previsto due campi.

**Fabrizio Paganelli:** Ok,

**Elena Spini:** Sì, che è diverso da quello che sto dicendo.

**Fabrizio Paganelli:** a posto.

**Aurel mrruku:** Sì.

**Elena Spini:** Ok. Cioè che che un prodotto sia eleggibile da bundle. Ok, mi torna. Ma è l'inclusione di un del bundle eh stesso, cioè ad esempio se tre prodotti devono stare nei bundle, ma tu sai che magari nel bundle uno ci possono stare solo i primi due e non il il prodotto tre perché può stare solo nel bundle Z.

**Fabrizio Paganelli:** Ho capito.

**Elena Spini:** Ok, perfetto. Quello sapete voi e insomma è a carico dell'attenzione eh vostra. Perfetto. Eh, nota di credito e sorni gestita tramite pulsante a livello di ordine.

### **00:44:23**

**Elena Spini:** Avevamo detto si apre il nostro pop-up, avevamo visto l'altra volta, giusto? rapid recup, siamo a livello di ordine, eh avrò un pulsante crea nota di credito e ehm tramite questo pulsante io potrò eh scegliere qual è la riga d'ordine di riferimento a cui io voglio fare

**Fabrizio Paganelli:** Sì.

**Elena Spini:** la nota di credito e ehm non so se se voglio fare storno parziale oppure tutto il storno totale di quello che dell'ordine che stiamo guardando, se è bandolo, qualsiasi esso sia Ehm. Se invece però stiamo stornando quello che è un prodotto di tipo evento, allora andiamo anche a ehm canc ad annullare l'asset. Aspetta, l'asset però qua mi sta un attimo deve essere Ah, ok. Sì. No, sea se stiamo andando a stornare ehm il prodotto di tipo evento, devo indicare eh qual è il contatto, qual è l'asset del contatto che sto annullando, perché potenzialmente io avrò ehm diversi magari

**Fabrizio Paganelli:** No.

**Elena Spini:** biglietti per quell'account che è riferito a quell'ordine e quindi io devo andare a indicare qual è il biglietto che voglio annullare. Una volta che indico qual è il biglietto, si annulla e ciao ciao.

### **00:46:02**

**Elena Spini:** Vi torna e poi passiamo agli open

**Elisa Migliano:** Sì, sì, torno, torno.

**Elena Spini:** point. Ok. Stato preventive generazione ordini post accettazione firma preventivo. Attenzione, siamo ok. Perfetto. Fluss. Alt livelli. Alto livello. Biglietti da rivedere. Torniamo qua. Biglietti. Entriamo nella modalità biglietti. Quindi qua avevamo quindi allora eh vabbè scende un ordine di tipo prodotto evento e qua in realtà su Sales Force dobbiamo fare logiche anche sulle sull'oggetto campagne perché in base a la persona che poi scannerizzerà il suo Qare code dobbiamo eh indicizzare in un in qualche modo la presenza o meno dell'evento. Quindi cosa abbiamo pensato? In realtà il momento ancora prima, quando su Mexal si creerà il prodotto evento per qualsiasi tipo di evento che che voi farete, si creerà anche in automatico su Sales Force la campagna. la campagna, ad esempio, voi farete, non lo so, camerieri venditori 2026, ottobre 2026, arriva la notte, arriva il prodotto su Salesce, si creerà in automatico ovviamente una volta e camerieri venditori 2026. Perfetto.

### **00:47:43**

**Elena Spini:** Scende l'ordine da eh Wocommerce. ordine. Ogni volta che scende l'ordine da Wcommerce si creerà eh il riferimento dell'account. Sì, dell'asset che sarebbe il ticket alle vende. E qua ci spostiamo un attimo sul ticket evento che è l'asset. Quando l'ordine scende, quindi arriva su sales force, l'asset, il biglietto sarà stato ordinato. Poi abbiamo detto che passa in stato disponibile a fattura pagata. Fattura pagata a livello di tranche o righe d'ordine. Ok, perfetto. In realtà questo è livello di righe d'ordine. Vabbè. Qua avevamo pensato di fare assegnato per la firma dei documenti, ma un attimo, lasciamolo un attimo standby che vado un attimo, torno di là. utilizzato e non utilizzato invece sono poi effettivamente i la scansione del QR code. Quindi torniamo un attimo di qua e qua avevamo delle domande, quindi siamo semplicemente al primo passaggio. È sceso un ordine, ho creato il biglietto, quello che dite che sta in magazzino. Biglietto in magazzino perché sta in ordinato disponibile. Ok. Su questo ehm avevamo delle domande che sono il c'è un codice diverso per ogni evento.

### **00:49:15**

**Elena Spini:** Ogni prodotto ha un codice diverso per ogni evento.

**Elisa Migliano:** Sì, sì, perché ogni evento ha il suo codice prodotto,

**Elena Spini:** Perfetto.

**Elisa Migliano:** quindi Cameritori avrà un prodotto un codice prodotto diverso da penissimo live, per esempio. Ja.

**Elena Spini:** Capire se Casim.

**Sabatino Rinaldi:** E faccio una domanda che se è una cosa già risolta

**Elena Spini:** Sì. Ah.

**Sabatino Rinaldi:** fermatemi subito. Un dubbio che mi è venuto adesso, magari me lo son perso io sempre su questo argomento. Ma noi quindi siamo, cioè abbiamo valutato anche l'ipotesi che succede che se ad esempio noi vendiamo tramite bundle di Sales Force un pacchetto che questo pacchetto contiene X eventi, di conseguenza X biglietti, noi poi da quel bundle di Sales Force, quando una persona acquista il bundle di conseguenza toccherà dare la disponibilità di quei biglietti a quel cliente. È predisposta questa cosa qui? L'abbiamo ragionata già.

**Elena Spini:** si creeranno tanti eh asset

**Sabatino Rinaldi:** Ok. In automatico.

**Elena Spini:** per Sì,

**Sabatino Rinaldi:** Ok.

**Elena Spini:** si perché è il caso la casistica del bundle,

**Sabatino Rinaldi:** Ok.

**Elena Spini:** quindi io sono qua.

**Aurel mrruku:** Qua arrivi nella seconda domanda, Elena.

### **00:50:33**

**Elena Spini:** Arrivo, aspetta,

**Sabatino Rinaldi:** Perfetto.

**Elena Spini:** io sono qua. Si scende il mio ordine totale e eh aspetta la seconda domanda. Questa di Silver Gold. Qual era la seconda domanda? Aurel.

**Aurel mrruku:** Sto parlando.

**Sabatino Rinaldi:** F.

**Aurel mrruku:** Ne. Vero?

**Elena Spini:** Sì,

**Aurel mrruku:** Chiedo scusa.

**Elena Spini:** ti sei mutato.

**Aurel mrruku:** Quello che ha detto Sabattino prima è vero,

**Sabatino Rinaldi:** Quattro.

**Aurel mrruku:** ma il problema è quando tu hai praticamente due biglietti

**Elena Spini:** No.

**Sabatino Rinaldi:** tipo giocando e a me sembra che

**Aurel mrruku:** diversi per lo stesso evento.

**Sabatino Rinaldi:** questa sia una casistica che ce l'abbiamo,

**Elisa Migliano:** Ce li abbiamo. Sì,

**Sabatino Rinaldi:** cioè che noi vendiamo lo stesso evento con biglietti

**Elisa Migliano:** cioè tipo,

**Sabatino Rinaldi:** diversi,

**Elisa Migliano:** allora capiamo cosa intendete e cosa intendiamo noi,

**Sabatino Rinaldi:** tipo Food Marketing Festival,

**Elisa Migliano:** nel senso io posso intend oppure un biglietto

**Sabatino Rinaldi:** vendi un biglietto gold e un biglietto Diamond.

**Elisa Migliano:** omaggio.

### **00:51:36**

**Elisa Migliano:** Allora, per tutti il codice prodotto è diverso perché, appunto, abbiamo un codice prodotto per tipologia di vento o tipologia proprio di biglietto, però esiste la casistica in cui in un singolo evento ci possono essere

**Sabatino Rinaldi:** Ah.

**Elisa Migliano:** più di una tipologia di biglietto. Mi sono

**Aurel mrruku:** Quindi in qualche modo Sì, sì. In qualche modo, nel momento in cui te generi il prodotto,

**Elisa Migliano:** spiegata.

**Aurel mrruku:** che è praticamente l'evento, il l'asset che viene collegato a quell'evento deve essere censito che è un asset silver, un asset gold.

**Elisa Migliano:** Allora, in realtà sni perché comunque quel No. Sì, sì, sì. Quell'asset comunque fa sempre capo a

**Aurel mrruku:** In qualche modo sul prodotto te mi devi dare l'informazione se è un evento Gold è un

**Elisa Migliano:** quell'evento.

**Aurel mrruku:** evento un biglietto, scusa, per un evento Gold o un biglietto

**Elisa Migliano:** Ma quello c'è già scritto nella denominazione del codice prodotto, cioè nel

**Elena Spini:** Cioè, allora, aspetta, scusa per capire. Allora,

**Elisa Migliano:** codice

**Elena Spini:** camerieri venditori Silver è ha un codice diverso da camerieri venditori gold.

**Aurel mrruku:** per lo stesso evento.

### **00:52:59**

**Elisa Migliano:** esatto,

**Elena Spini:** Eh,

**Elisa Migliano:** esatto.

**Elena Spini:** esatta.

**Aurel mrruku:** metti anche lo stesso evento perché è quello

**Elena Spini:** Eh, sì. Allora, a livello di prodotto se con

**Sabatino Rinaldi:** Comunque quelle poche volte che faccio una domanda succede sempre un casino,

**Aurel mrruku:** Cheale

**Sabatino Rinaldi:** poi dopo.

**Elisa Migliano:** Ma in realtà era la domanda dopo.

**Sabatino Rinaldi:** Ah,

**Elena Spini:** 26 gold. Faccio proprio l'esempio perché sennò poi ce lo dimentichiamo. camerieri e venditori.

**Aurel mrruku:** sarebbe di passare l'informazione a un campo Doc, perché vabbè, facciamo è che sul nome puoi fare una, diciamo, un filtro sul nome diventa difficile per dividere le tipologie dei biglietti.

**Elena Spini:** Ma noi abbiamo il codice. S'è

**Aurel mrruku:** ce l'abbiamo il codice, ma quel codice lo devi in qualche modo lo devi mappare su qualcosa per dirti se è un codice di un biglietto gold oppure un biglietto e sarebbe

**Elisa Migliano:** Gli mettiamo noi un campo in anagrafica.

**Aurel mrruku:** ottimo se è possibile.

**Fabrizio Paganelli:** M.

**Elisa Migliano:** Mi sentite?

**Elena Spini:** Sì, sarebbe bellissimo la risposta,

**Elisa Migliano:** Ok.

### **00:54:15**

**Aurel mrruku:** Sì.

**Elena Spini:** eh.

**Elisa Migliano:** No, no, mettiamo un un campo noi un campo in anagrafica dove gli un menù a tendina tipo biglietto, gold, executive, eccetera eccetera eccetera.

**Aurel mrruku:** Perfetto, perfetto. Так.

**Elena Spini:** Perfetto. Questo poi lo aggiungo come cosa per te. Allora, Fabrizio, aggiungere info a livello di prodotto, eh info biglietto, capisci?

**Fabrizio Paganelli:** Tipo biglietto, tipo più che tipo biglietto, tipo

**Elisa Migliano:** Tipo bigliet

**Fabrizio Paganelli:** biglietto

**Elena Spini:** anficaotto tipo

**Fabrizio Paganelli:** e poi sempre in anagrafica prodotto.

**Elena Spini:** biglietto.

**Fabrizio Paganelli:** Possiamo mettere un flag che mi dice

**Elena Spini:** Sì, tipo evento va fatto.

**Fabrizio Paganelli:** l'evento

**Elena Spini:** L'avevamo già detto, mi sa. In effetti non c'è, però No, mica l'avevate già detto. V Eh, sì, V. Aurel.

**Fabrizio Paganelli:** sembra che quello che avevamo detto era utilizzabile nei bundle, sì o

**Aurel mrruku:** Sì, sì,

**Elena Spini:** Ah, ok,

**Aurel mrruku:** sì.

**Fabrizio Paganelli:** no?

**Elena Spini:** perfetto. Più flag vento.

### **00:56:16**

**Elena Spini:** Perfetto. Ok, quindi torniamo un attimo qua. aizio capire se da Mexal riescono a passare a generare biglietto, bando lolli, nome prodotto, questo è quello che stavamo dicendo prima. Sì, qua questo capire se tutor possono creare,

**Fabrizio Paganelli:** Ча.

**Elena Spini:** poi non ho finito. Mh, non lo so. possono creare. Vabbè, non ci interessa. Bene così. Forse era si possono creare i prodotti. Oh, vabbè, sembra un problema successivo. Ok, quindi invece siamo qua, siamo a il nostro asset barra biglietto creato, sarà pagato, sarà fatturato, sarà quello che è, è disponibile. Avevate detto che voi attualmente fate a 60 giorni dall'evento un funnel marketing per ridurre il tasso di no show per insomma i i clienti che hanno acquistato il biglietto e magari si sono dimenticati di tutto. Questo è ancora vero? Ci sarà l'auto marketing 60 giorni dall'evento? Lo prendiamo per mano.

**Fabrizio Paganelli:** Secondo me sì.

**Sabatino Rinaldi:** Eh sì, eh, nel senso non è una regola scritta al 100% che è sempre 60 giorni prima dell'evento,

### **00:57:45**

**Elena Spini:** Perfetto.

**Sabatino Rinaldi:** possono essere 30 può, però di basta sì. Io metterei un 30/60 giorni.

**Elena Spini:** Da capire poi come inviare questa comunicazione,

**Sabatino Rinaldi:** Sì, sì, sono questa qui,

**Elena Spini:** ma non vabbè.

**Sabatino Rinaldi:** ad esempio, Elena, noi abbiamo presente quei due flussi eh marketing che dovremmo fare insieme a voi. Ti

**Elena Spini:** Uno sarà di uno sarà di questi,

**Sabatino Rinaldi:** ricordo

**Elena Spini:** però poi dobbiamo parlarne. Si torna che uno sarà questo tra i

**Sabatino Rinaldi:** dei biglietti.

**Elena Spini:** due.

**Sabatino Rinaldi:** Sì, sì,

**Elena Spini:** Ci può stare.

**Sabatino Rinaldi:** per me possono essere pure tutti e due sui biglietti. Sono gli unici funnel che ci interessano già pronti,

**Elena Spini:** Ok. Ok. Perfetto.

**Sabatino Rinaldi:** tanto quelli marketing ce li creiamo

**Elena Spini:** Quando Quando torna suesta Matteo passeremo a questo

**Sabatino Rinaldi:** noi. Sì, sì, sì, sì.

**Elena Spini:** punto.

**Sabatino Rinaldi:** No, ma in realtà quello ci sarà Matteo, ma lì ti sbloccheremo un nuovo personaggio che è Rebecca che è lei che si occupa di

**Elena Spini:** Attenzione.

### **00:58:50**

**Elena Spini:** Va bene.

**Sabatino Rinaldi:** questa cosa, però di base sì, noi preferiamo che tutti e due i funnel che abbiamo li facciamo sui biglietti perché sul marketing noi

**Elena Spini:** Ehm per ottimizzare, dato che noi non ci siamo dal 10 al 14,

**Sabatino Rinaldi:** siamo

**Elena Spini:** dalla settimana, diciamo così, dal 18 questa Rebecca è già disponibile?

**Sabatino Rinaldi:** credo di Marco me lo sa dire.

**Elena Spini:** Vedi Marco? No, è in ferie.

**Marco:** No, scusami. Cos'è che Ah,

**Elena Spini:** Ah, no, Marco, no, Matteo pensavo.

**Marco:** ma ma la Rebecca Marmo,

**Elena Spini:** Ok.

**Sabatino Rinaldi:** Rebecca Rebecca Marmo.

**Elena Spini:** Scusa, scusa,

**Marco:** Fab?

**Sabatino Rinaldi:** C'è la settimana dopo di

**Elena Spini:** scusa.

**Marco:** Ah,

**Sabatino Rinaldi:** Ferragosto?

**Marco:** assolutamente, aspetta, eh. Assolutamente sì, al momento non ha preso

**Elena Spini:** Ottimo.

**Sabatino Rinaldi:** Ok. Io però non ci

**Elena Spini:** Passami.

**Marco:** niente.

**Fabrizio Paganelli:** อ

**Sabatino Rinaldi:** sono,

**Elena Spini:** Posso coinvolgere questa Rebecca e Marco o no?

**Sabatino Rinaldi:** eh. Marco, diciamo, c'entra un po' poco più Matteo,

### **00:59:47**

**Marco:** Sì.

**Sabatino Rinaldi:** in realtà.

**Elena Spini:** E Matteo però non c'è, mi sa.

**Sabatino Rinaldi:** Matteo quella settimana c'è.

**Elena Spini:** c'è perfetto.

**Sabatino Rinaldi:** Sì, sì, sì, sì. Lui non c'è ora e quella dopo, però Però la quella dopo Fer agosto

**Elena Spini:** Va bene, se mi dai il contatto in chat o su WhatsApp dove ti è più comodo direcca,

**Sabatino Rinaldi:** c'è

**Fabrizio Paganelli:** Sì.

**Elena Spini:** io faccio questo meeting, così anticipiamo almeno una cosa di marketing.

**Sabatino Rinaldi:** Sì. Eh, io non ce l'ho. Penso che sia rebecca.mm@gmail.com@panissimo.com.

**Marco:** Sì, esatto, esatto. F.

**Fabrizio Paganelli:** Sì.

**Sabatino Rinaldi:** Scusa,

**Elena Spini:** Me me la scrivi comunque, per favore, perché seò me la dimentichi.

**Sabatino Rinaldi:** la sto scrivendo adesso.

**Elena Spini:** Grazie mille.

**Sabatino Rinaldi:** Rebecca.m@panissimo.com. Metti lei,

**Elena Spini:** Poi

**Sabatino Rinaldi:** Marco e Matteo.

**Elena Spini:** poi qua invece eh noi avevamo fatto due

**Sabatino Rinaldi:** perent

**Elena Spini:** giorni dall'evento eh chiedere alla lista dei partecipanti. Ora qui alzo un po' le mani e nel senso come fate voi invece ad oggi?

### **01:01:03**

**Elena Spini:** Cioè in quale momento voi chiedete a chi ha comprato i biglietti?

**Sabatino Rinaldi:** per

**Elena Spini:** Attenzione m mi metti nome, cognome, mail di chi stiamo parlando e a cui poi possiamo mandare il

**Sabatino Rinaldi:** essere

**Elena Spini:** tutto?

**Sabatino Rinaldi:** allora noi in pratica tutte le persone che si iscrivono, che hanno la disponibilità biica e quindi hanno pagato, ricevono una sorta di di tag all'interno del CRM. Questo tag ce lo dobbiamo riportare poi nella lato marketing e quindi avremo questa lista di eh iscritti certi all'evento perché han pagato e perché hanno i biglietti e queste persone ricevono il link con il quantitativo, diciamo, di biglietti che hanno e gli chiediamo di compilare quei campi, nome, cognome, mail di tutti i partecipanti.

**Elena Spini:** e compilare nome, cognome,

**Sabatino Rinaldi:** Lo facciamo.

**Elena Spini:** mail dove

**Sabatino Rinaldi:** Ah, in questo link, in pratica, questo link è un file, tra virgolette, lo chiamo, non so come chiamarlo, eh, è una pagina, è una landing più o

**Elena Spini:** no.

**Sabatino Rinaldi:** meno al

**Elena Spini:** Ok, quindi inviate questa mail a chi ha comprato il biglietto.

**Sabatino Rinaldi:** titolare dell'azienda.

### **01:02:22**

**Elena Spini:** Sì. Perfetto.

**Sabatino Rinaldi:** Chi ha ha effettuato l'acquisto?

**Elena Spini:** Ok. e gli dite dovete mettermi la lista dei partecipanti.

**Sabatino Rinaldi:** Esatto. La questo link comprende già eh il quantitativo dei biglietti

**Elena Spini:** Scusa,

**Sabatino Rinaldi:** che ha. Quindi, ad esempio, si vedrà già cinque campi perché ha preso cinque biglietti e lui lì deve andare ad inserire i dati dei partecipanti che vuole portare all'evento. qua non neche

**Elena Spini:** stavo leggendo qua sopra cosa Tam. messo da marketing via comunicazione con link. In realtà non è da marketing, ma vabbè.

**Sabatino Rinaldi:** Vabbè, dalla piattaforma marketing di base,

**Elena Spini:** E m sì,

**Sabatino Rinaldi:** quindi puoi anche lasciarla

**Elena Spini:** no,

**Sabatino Rinaldi:** così.

**Elena Spini:** ma poi effettivamente questo sarà se source, mi sa, però vabbè, capiamo. Invio comunicazione col link con account ID nel link. Redirect. Ah no, forse questa detto marketing.

**Sabatino Rinaldi:** C

**Elena Spini:** Vabbè,

**Sabatino Rinaldi:** c

**Elena Spini:** le Direct su landing page dove il referente ha acquistato i biglietti dovrà comunicare la lista dei partecipanti dell'evento.

### **01:03:27**

**Sabatino Rinaldi:** io sono come

**Elena Spini:** Se quell'account ha acquistato più eventi,

**Sabatino Rinaldi:** di

**Elena Spini:** la scelta dell'evento torna. Quindi se io in realtà

**Sabatino Rinaldi:** la scelta dell'evento, no?

**Elena Spini:** Ah.

**Sabatino Rinaldi:** Perché noi quando mandiamo la comunicazione di generazione biglietti è specifica per quell'evento, un caffè, cioè non è che mandiamo quella mail per farli scrivere a 5 eventi insieme con un'unica comunicazione. Noi abbiamo il fan del food marketing, il fan del pienissimo live, camerier venditori, sono tutti i funnel singoli. Ok, l'azienda può in un in un bandol acquistare 10 eventi diversi, però poi a ridosso a 30-60 giorni prima dall'evento da uno degli eventi che ha acquistato, gli arriva la comunicazione esclusivamente per quell'evento. Non so se mi sono

**Elena Spini:** Sì, sto pensando poi effettivamente come farlo.

**Sabatino Rinaldi:** spiegato.

**Elena Spini:** Quindi io avrò il riferimento di quell'account. dall'account, vado ai contatti e posso sapere quali sono i biglietti perché vedo

**Sabatino Rinaldi:** Asset che ha.

**Elena Spini:** i nomi, le informazioni dell'asset che ha qui. Aurel ritorna. In realtà non è la il tizio che deve dire a quale evento vuole

### **01:05:08**

**Sabatino Rinaldi:** No, mai, ma mai già è tanto che ci dicono chi viene.

**Elena Spini:** iscriversi.

**Aurel mrruku:** Ah, quindi stiamo pensando semplicemente come un sì, no? E

**Elena Spini:** No, aspetta. Eh,

**Aurel mrruku:** basta.

**Elena Spini:** dobbiamo praticamente eh dalla dall'invio di questa mail con link noi abbiamo un riferimento dell'account

**Aurel mrruku:** Sì,

**Elena Spini:** ID.

**Aurel mrruku:** sì.

**Elena Spini:** dall'account noi eh dobbiamo arrivare all'asset agli asset

**Aurel mrruku:** Ma non dall'account l'asset è collegato al al contatto praticamente

**Elena Spini:** che

**Aurel mrruku:** quell'account

**Elena Spini:** va bene? Sia ancora meglio l'asset collegato.

**Aurel mrruku:** dovrebbe essere praticamente Pzie M il problema ce li abbiamo i contatti in questo

**Elena Spini:** Sì, ce li esatto. No, aspetta, è vero,

**Aurel mrruku:** punto.

**Elena Spini:** non abbiamo non è detto che abbiamo tutte perché noi gli stiamo chiedendo appunto di indicare quali sono i un contatto sicuro ce l'abbiamo.

**Sabatino Rinaldi:** Noi c'abbiamo il contatto che ci interessa che è quello che ha pagato,

**Elena Spini:** Esatto. quello che ha

**Sabatino Rinaldi:** titolare dell'azienda che ha pagato e che quindi i biglietti,

### **01:06:18**

**Aurel mrruku:** Ok.

**Sabatino Rinaldi:** i cinque i cinque i tre biglietti che ha acquistato sono tutti intestati a lui.

**Elena Spini:** pagato.

**Sabatino Rinaldi:** Noi nel funnel semplicemente gli diciamo bene, hai comprato questi cinque tre biglietti,

**Aurel mrruku:** Ok,

**Sabatino Rinaldi:** sappiamo chi sei, sappiamo che li hai comprati te. Ora beccati sto link. in questo link è già predisposto con cinque campi perché in quei cinque campi deve andare a mettere i dati delle persone che vuole portare,

**Aurel mrruku:** perfetto,

**Sabatino Rinaldi:** nome, cognome,

**Aurel mrruku:** perfetto,

**Sabatino Rinaldi:** mail,

**Aurel mrruku:** perfetto.

**Sabatino Rinaldi:** che poi tutte queste persone riceveranno eh il proprio QR code con la propria

**Elena Spini:** Aspetta,

**Sabatino Rinaldi:** modulistica che in questa fase porteranno all'evento.

**Elena Spini:** aspetta, fermati, fermati,

**Sabatino Rinaldi:** Vabbè, mi

**Elena Spini:** fermati, fermati. L'unico dubbio mio che avevo era Aurel, che qua avevamo detto scelta dell'evento nella landing perché avevamo detto eh

**Sabatino Rinaldi:** fermo.

**Aurel mrruku:** Sì.

**Elena Spini:** che appunto magari m l'account aveva comprato da che ne so da un bundle due eventi, però ha detto che non sarà così.

### **01:07:16**

**Sabatino Rinaldi:** No, non scelgono mai loro. noi che gli diciamo cosa devono fare.

**Aurel mrruku:** Non posso mai avere due eventi. Un account non può mai avere due eventi attivi.

**Sabatino Rinaldi:** Cioè, un account ne può avere anche 30 di eventi attivi,

**Elena Spini:** Sì.

**Sabatino Rinaldi:** ma noi le comunicazioni le mandiamo a ridosso dell'evento di riferimento.

**Aurel mrruku:** Sì,

**Sabatino Rinaldi:** Ecco perché noi mandiamo una comunicazione 30 o 60 giorni prima,

**Aurel mrruku:** ecco.

**Sabatino Rinaldi:** perché quei 30 o 60 giorni prima la comunicazione è su un evento specifico, non è che gli diciamo a quale evento vuoi

**Aurel mrruku:** Ecco. Eh,

**Sabatino Rinaldi:** partecipare.

**Aurel mrruku:** quindi tu in qualche modo prima di mandare questa comunicazione devi filtrare tutti account che fanno parte di

**Sabatino Rinaldi:** Esatto.

**Aurel mrruku:** quell'evento.

**Sabatino Rinaldi:** tutti gli account che hanno acquistato almeno un biglietto per quel determinato

**Aurel mrruku:** Ok?

**Elena Spini:** E

**Sabatino Rinaldi:** evento.

**Aurel mrruku:** E la comunicazione verrà inviata in modo automatico dal sistema oppure ci sarà un'azione manuale?

**Sabatino Rinaldi:** Noi creiamo un panel che parte da Esatto.

### **01:08:17**

**Elena Spini:** era una cosa di

**Sabatino Rinaldi:** È un panel un funnel che parte da un tag,

**Elena Spini:** marketing.

**Sabatino Rinaldi:** quindi le persone che hanno quel biglietto, che hanno diritto a partecipare a quell'evento avranno un tag. e parte la comunicazione a tutti poi in automatico.

**Elena Spini:** Forse sarà magari un filtro lato marketing, semplicemente sto pensando che si crea il segmento e lui sa già a chi è inviato e

**Aurel mrruku:** In qualche modo marketing deve proprio avere il codice dice dell'evento per fare il filtro.

**Elena Spini:** magari Esatto.

**Aurel mrruku:** Questo

**Elena Spini:** Ma noi ce l'avremo il codice dell'evento. Sarà Alidi

**Aurel mrruku:** sì,

**Elena Spini:** del

**Aurel mrruku:** ma come lo farei? praticamente della data dell'evento. Spero se un automatismo deve essere un meccanismo che gira ogni notte e ogni notte controlla tra 60 giorni quale sarà l'evento tra fin quando arriva il giorno giusto. Almeno così lo sto pensando

**Elena Spini:** E anche ci sarà l'errata dell'evento.

**Sabatino Rinaldi:** Se riesci a fare una cosa così sarebbe molto f\*\*\*,

**Aurel mrruku:** io.

**Sabatino Rinaldi:** perché così noi possiamo addirittura rendere il tutto automatico e in automatico partono i fan nel momento giusto al tempo giusto per l'evento giusto.

### **01:09:29**

**Aurel mrruku:** Quindi quell'evento praticamente la campagna nel nostro caso, vero Elena?

**Elena Spini:** Sì, sì.

**Aurel mrruku:** Quindi la campagna avrà un start date e quindi 60 giorni prima delle started della campagna. Tutti account che hanno un collegamento con quella campagna devono ricevere questa

**Sabatino Rinaldi:** Esatto.

**Aurel mrruku:** mail.

**Sabatino Rinaldi:** Questa mail che poi in realtà segue una serie poi di cose dopo, però parte tutto da quella mail.

**Aurel mrruku:** Io stavo pensando questa mail può essere anche generata direttamente da Selsus, poi ne parliamo con con Giuseppe Elena o con Fabio,

**Elena Spini:** Fabrizio,

**Aurel mrruku:** non so chi.

**Elena Spini:** Fabrizio, vabbè, questa poi capiamo un attimo.

**Aurel mrruku:** Sì.

**Elena Spini:** Esatto. Vabbè,

**Sabatino Rinaldi:** Poi Elena,

**Elena Spini:** facciamo finta che riusciamo a dire che

**Sabatino Rinaldi:** Elena ti ripeto poi questa tutti questi dubbi magari, cioè di sicuro bisogna trovare il trigger giusto di partenza di questo funnel,

**Elena Spini:** Sì.

**Sabatino Rinaldi:** ma poi tutto quello che concerne eh il funnel proprio del biglietto del di come arriva il cliente, la generazione, il link da mandare, eccetera eccetera. su quello la call che farai con Rebecca ti ti dirà tutto perché è lei che fa questo.

### **01:10:32**

**Elena Spini:** Va bene, va bene.

**Sabatino Rinaldi:** Io arrivo fino a un certo punto.

**Elena Spini:** Sai perché? Perché ti dico Aurel che secondo me questa sarà marketing, ma perché secondo me loro hanno delle logiche particolari. A questo punto hanno marketing,

**Aurel mrruku:** Ok,

**Elena Spini:** glielho faccio mandare da marketing.

**Aurel mrruku:** ok, chiaro, chiaro.

**Elena Spini:** E stavo pensando tipo una volta che eh sono

**Aurel mrruku:** Ma marketing punterà sulla nostra community per

**Elena Spini:** entrati

**Aurel mrruku:** fare l'inserimento dei dei dati del contatto

**Elena Spini:** c'avranno il loro landing page.

**Aurel mrruku:** oppure Ok.

**Elena Spini:** C'avranno il loro landing page e sì.

**Aurel mrruku:** Ok, va bene.

**Elena Spini:** Comunque è con tutto connesso. Ehm,

**Aurel mrruku:** Chiaro?

**Elena Spini:** tolgo solo questa qua che ha acquistato più eventi, scelta dell'evento. Perché questa questa questo in realtà lo dobbiamo il funnel parte da

**Elisa Migliano:** Poi Elena, noi hai lato biglietti,

**Elena Spini:** Ка.

**Elisa Migliano:** abbiamo anche eh dei campi all'interno appunto del prossimo asset praticamente eh che sono nominati da noi come evento edizioni eh o anno e anno accademico, ovvero che noi Yeah.

### **01:11:59**

**Elisa Migliano:** ogni ogni nuovo evento che c'è andiamo a inserire la tipologia di evento con l'anno e poi andiamo a inserire anche l'anno accademico di quell'evento e l'anno di competenza perché ci serve in quanto quando viene creato il movimento del biglietto, quindi il famoso magazzino, l'asset, quel biglietto sappiamo che avrà data di competenza per un determinato

**Elena Spini:** Per me va benissimo. Ok,

**Elisa Migliano:** evento.

**Elena Spini:** siamo arrivati a mappatura campi con Zoo e il data model condiviso. Qua io vedo ancora tutto vuoto, quindi tutto quello che mi hai detto lo dovete mettere su questo file che è sempre vuoto. Quindi io vi chiedo di lavorare su questo o se ne avete usato un altro di

**Elisa Migliano:** Allora,

**Elena Spini:** condivider l'altro,

**Elisa Migliano:** eh,

**Elena Spini:** però cioè questi cose di che hai detto di biglietti.

**Elisa Migliano:** Elena Elena,

**Elena Spini:** Sì,

**Elisa Migliano:** allora, noi ieri abbiamo guardato ai questa cosa qua

**Elena Spini:** ottimo.

**Elisa Migliano:** e però mentre lavoravamo ehm c'è venuto siamo siamo arrivati anche alla fine, no? Però mentre lavoravamo ciè venuto un dubbio.

**Elena Spini:** Perfetto. Sì.

**Elisa Migliano:** Noi qui vi dobbiamo indicare i campi che vorremmo oppure vi dobbiamo indicare qual è il campo di Zo e qual il campo di Sales Force in modo tale da fare la mappatura o della serie.

### **01:13:37**

**Elena Spini:** No, no, no, non dobbiamo integrare i due sistemi,

**Elisa Migliano:** Mh.

**Elena Spini:** cioè i campi che vorreste avere su Sales Force e che dobbiamo poi

**Elisa Migliano:** Ok,

**Elena Spini:** portare su Sales Force. dico portare perché questa quello che poi vedrete mh

**Elisa Migliano:** perfetto.

**Elena Spini:** in questa colonna sarà nome, cognome, titolo e bla bla bla bla bla bla sarà la riga che identifica poi tutti m i dettagli che voi avete a livello di oggi EIS che

**Elisa Migliano:** Ok.

**Elena Spini:** vogliamo portare con la migrazione su Sales Force.

**Elisa Migliano:** Ecco, però per la migrazione però c'è bisogno che io ti dica qual è il mio campo e qual è il tuo per fare la migrazione. Dico bene?

**Elena Spini:** Mh, basta che mi metti che noi dobbiamo creare, che ne so, facciamo un esempio, noi dobbiamo creare il campo, boh, settore, ok? Io lo creo su sales force settore, lo metto qua sopra in riga settore. Tu quando dovrai fare l'estrazione da zo metti tutto sotto settore.

**Elisa Migliano:** No,

**Elena Spini:** Poi non ho bisogno di sapere come l'hai salvato su

**Elisa Migliano:** Fabri Fabri ti sta dicendo proprio la mappatura del campo in sé per sé, non il macro la macroarea. Perché noi dovremmo fare due cose.

### **01:14:55**

**Elisa Migliano:** dovremmo fare uno capire i campi che vogliamo vedere. revisibili su sales force e poi dovremmo anche questo database alimentarlo in qualche modo, no? Quindi eh eh quindi

**Elena Spini:** Ma voi non avrete più zooperò. In che senso daabese alimentarlo?

**Elisa Migliano:** noi non ci portiamo su SESP un minimo di storico, l'anagrafica clienti,

**Elena Spini:** Sì. Sì, no,

**Elisa Migliano:** l'anagrafica

**Elena Spini:** assolutamente che ce la portiamo, però poi dopo saranno negli stessi

**Elisa Migliano:** eh e la la domanda di Fabria è:

**Elena Spini:** campi.

**Elisa Migliano:** "Come faccio a far sì che siano negli stessi campi se non ti do la mattura e da campo

**Elena Spini:** Allora, allora facciamo un

**Elisa Migliano:** a campo?

**Elena Spini:** esempio.

**Elisa Migliano:** Andiamo nei prodotti che è il campo più piccolina. Capiamo

**Elena Spini:** Allora, cioè, aspetta, vi faccio vedere così.

**Elisa Migliano:** bene.

**Elena Spini:** Questi nome e cognome sono i campi che voi mi avete messo nel nello sheet lead che noi facciamo finta che non esistono su sales force, ok? li dobbiamo creare. Quindi io ho creato nome e cognome perché su Zo avete anche nome,

**Elisa Migliano:** Mm.

**Elena Spini:** cognome.

### **01:16:05**

**Elena Spini:** Quando dobbiamo fare l'importà intestata nome cognome e poi Elena cognome, poi Aurel, insomma tutti i dati che voi avete.

**Elisa Migliano:** Quindi se se ritorna ad esempio nell'account è uguale è uguale

**Elena Spini:** Sì, ero nel lead. Vabbè,

**Elisa Migliano:** questi nella prima nella colonna l'etichetta campo non è una lista di campi che noi

**Elena Spini:** uguale,

**Elisa Migliano:** dobbiamo obbligare obligatoriamente rispettare. Cioè noi qui ci scriviamo semplicemente quali sono i nostri nomi dei campi che abbiamo su Zo. Dico

**Aurel mrruku:** Corretto,

**Elena Spini:** non mi interessa avere le PI,

**Aurel mrruku:** corretto.

**Elisa Migliano:** bene?

**Elena Spini:** cioè perché

**Aurel mrruku:** Poi poi ti vi spiego.

**Elena Spini:** M.

**Aurel mrruku:** E la mappatura lo posso fare anch'io nel momento in cui faccio l'inserimento. Basta che ovviamente l'informazione su quel campo vada nel campo che voi pensate che sia il campo corretto.

**Elisa Migliano:** No, perché io, cioè, voglio dire,

**Elena Spini:** Cioè,

**Elisa Migliano:** ehm la la il dubbio il dubbio a noi c'è venuto ieri,

**Elena Spini:** sarà una cosa che comunque facciamo

**Elisa Migliano:** il dubbio ieri a no a me e Lisa c'è venuto perché abbiamo un'anagrafica clienti che ha

### **01:17:08**

**Elena Spini:** manualmente.

**Elisa Migliano:** 150 campi dove molti dei quali i ragionando tra me e lei sono da eliminare, però siccome è un lavoro è veramente grosso che ripeto

**Elena Spini:** Perfetti.

**Elisa Migliano:** l'abbiamo già al 95% fatto, però volevamo capire qui che cosa vi dobbiamo compilare noi, nel senso, se io vado nel lead, se io vado nel lead dove tu qui mi scrive nome,

**Elena Spini:** No.

**Elisa Migliano:** io gli devo mettere il nome del campo, nome che ho io su Zoo. Ok.

**Aurel mrruku:** Sì, basta che Ma anche se tu non lo scrivi il nome, ma lo scrivi name in inglese, F. Niente, perché poi la mappatura lo faccio io nel momento in cui faccio l'inserimento.

**Elisa Migliano:** Eh,

**Aurel mrruku:** Ovviamente dobbiamo fare un passaggio insieme, vedere i campi che sono su Zoo, i campi che sono su Sales Force e se il la mappatura è

**Elisa Migliano:** eh,

**Aurel mrruku:** corretta.

**Elisa Migliano:** allora tanto vale che io lì ti scrivo già il nome di Sales Force perché sennò dobbiamo fare lavoro due volte. C di Zo. Eh, esatto, di Zo. Qui nella colonna A io vi scrivo il nome del campo di Zo perché senò dobbiamo rifare la roba e poi dopo

### **01:18:25**

**Elena Spini:** Eh,

**Elisa Migliano:** dobbiamo fare anche la

**Elena Spini:** ma sì.

**Aurel mrruku:** Sì, sì,

**Elena Spini:** Va bene. Poi dopo quello sarà il nome anche di Sales Force,

**Aurel mrruku:** ma sì,

**Elisa Migliano:** matatura.

**Elena Spini:** quindi del

**Aurel mrruku:** sì. il valore, non stiamo parlando del valore, stiamo parlando dell'etichetta praticamente.

**Elena Spini:** nome. Esatto.

**Aurel mrruku:** Se l'etichetta lo chiami nome su Zo,

**Elena Spini:** perde del nome del

**Aurel mrruku:** ma lo chiami name su sales force,

**Elisa Migliano:** Ah.

**Elena Spini:** campo.

**Aurel mrruku:** non fa nessuna differenza a livello di valore di quel campo. Basta che quando riceviamo l'elenco dei dati da Zoo, prima di fare l'inserimento su Sage Force, facciamo insieme 10 minuti di call. E andiamo campo per campo. Su Zo è così, su SWS è così. La maggior parte dei casi sarà proprio lo stesso le la stessa nomenclatura, lo stesso key, praticamente la stessa chiave. Ma quando non c'è, diciamo, questo qua forse non serve. Questo campo è c su Zo, su Sforce non ci serve più, lo eliminiamo.

### **01:19:23**

**Elena Spini:** Togliamo.

**Aurel mrruku:** Questo campo su Zo si chiamava A, su Sushi B. Allora, va bene. Io prima di fare l'inserimento su saleswo.

**Elena Spini:** No.

**Aurel mrruku:** Quando è A, gli dico mappalo su B. Non so se sono stato chiaro.

**Elisa Migliano:** Sì, sì, abbiamo capito, abbiam capito, ma è quello che dicevamo prima io e Fabrizio,

**Aurel mrruku:** Ok.

**Elisa Migliano:** motivo per il quale abbiamo detto a sto punto vi vi mettiamo direttamente eh i campi di origine di ZO, così è più semplice per voi, più semplice per noi, perché appunto abbiamo, come vi dicevamo prima,

**Aurel mrruku:** Sì.

**Elisa Migliano:** su sui sul modulo cliente abbiamo 150 campi di Quindi utilizziamo un quarto, quindi non ve ne stiamo a mettere tutti, vi mettiamo solo quelli che eh pensiamo chei trasportare,

**Elena Spini:** che volete?

**Elisa Migliano:** cioè spostare su Ses Force è già con la nomina del campo di Zo,

**Elena Spini:** Esatto,

**Elisa Migliano:** così poi la mappatura è ancora più semplice.

**Elena Spini:** perfetto.

**Elisa Migliano:** Ok.

**Elena Spini:** E già che siamo arrivati a questo punto, eh un'altra cosa che avevamo detto che era che dovevate fare prima di fare poi tutta questa estrazione dei dati che avete ESIS era una bonifica di questi dati.

### **01:20:41**

**Elena Spini:** Quindi stiamo parlando di dati, non di campi, perché eh avevamo detto faccio un attimo jump su su questo punto da che siamo qua. Eh pa migrazione importati in sales. Forse serve un checklato. pienissimo per la bonifica dei dati perché avevate parlato di boh tanti clienti che erano forse duplicati che non si capiva chi

**Sabatino Rinaldi:** E su questo secondo me noi la risolviamo facile, Fabri con il tuo file.

**Elisa Migliano:** Quale

**Sabatino Rinaldi:** Quello lì dove tu hai tutte lo storico di tutti i clienti degli a quello che mi passi ogni

**Elisa Migliano:** file?

**Sabatino Rinaldi:** mattina, quello che metti su

**Elisa Migliano:** Eh sì. No,

**Sabatino Rinaldi:** Analytics.

**Elisa Migliano:** lo possiamo fare anche collegandoci direttamente a quello di Zoo, tanto dopo noi andremo a caricare solo i clienti che hanno il codice il codice cliente maxal.

**Sabatino Rinaldi:** Ok.

**Elisa Migliano:** Noi abbiamo quindi abbiamo diciamo la ci sono perché in anagrafica clienti su Zoo ci ad oggi ci sono tipo 17.000 record. Di questi 17.000 record, solo 8500 hanno sono clienti veri che hanno, diciamo, una ragione sociale che è già censita. Gli altri li andiamo li andiamo già a eliminare a priori, insomma.

### **01:22:16**

**Elisa Migliano:** Però non è necessario passare dal mio file, lo possiamo fare direttamente o zoro, così siamo più sicuri.

**Sabatino Rinaldi:** Vabbè, era per dire che è un dato che abbiamo facilmente reperibile e pulito. Что?

**Elena Spini:** facilmente se quando è facilmente noi siamo pronti a ricevere i dati perché vi ricordo che prima riusciamo a portare su i

**Sabatino Rinaldi:** Ok,

**Elena Spini:** dati. prima riusciamo a fare anche tutte le logiche, l'automarketing perché attualmente

**Sabatino Rinaldi:** allora allora direi che al rientro dalla settimana di Fragosto per chi c'è, presumo quindi Fabrizio sia in ufficio e non lo so con chi può farlo, con Elisa, con Marco, questa cosa qui. Se sappiamo che già dove abbiamo questi dati che vogliamo importare facciamo in modo di darli il prima possibile.

**Elena Spini:** Esatto.

**Sabatino Rinaldi:** Datatemi conferma se si può, se è complicato. Tu tu tu. Oh, vedo un pollice del grande mitico Marco. Mi preoccupa la non risposta di Fabrizio,

**Elena Spini:** Il problema è che Fabrizio Infatti stava dicendo uguale.

**Elisa Migliano:** Perché accendo e spengo il microfono.

**Sabatino Rinaldi:** però.

**Elisa Migliano:** Io rispondo, però l'Elisa fa in modo che io voi non sentiate.

### **01:23:43**

**Sabatino Rinaldi:** E quindi cos'è che hai risposto?

**Elisa Migliano:** Non c'è ha risposto. Non c'è problema.

**Sabatino Rinaldi:** Perfetto. Allora Elena,

**Elena Spini:** Grazie.

**Sabatino Rinaldi:** fai anche un un appunto, un meet, qualsiasi cosa come ti pare a te al rientro dalla settimana di ferragosto.

**Aurel mrruku:** M.

**Sabatino Rinaldi:** che così ti mandano

**Elena Spini:** Quindi Fabrizio Delisa, voi ci siete al rientro?

**Sabatino Rinaldi:** tutto.

**Elisa Migliano:** fino a fine di agosto rientrato il 31,

**Elena Spini:** Cioè,

**Elisa Migliano:** però dopo nelle call partecipo, non c'è problema.

**Elena Spini:** eh, ma più che partecipare alla call dovete lavorare sul sul

**Sabatino Rinaldi:** Eh, serve il file,

**Elisa Migliano:** Non vi preoccupate,

**Elena Spini:** file.

**Sabatino Rinaldi:** serve il file.

**Elisa Migliano:** non vi preoccupate.

**Sabatino Rinaldi:** Va bene, va bene. Allora, Elena, fai

**Elisa Migliano:** Mi fai dalla fai della

**Elena Spini:** Beh, datemi una data. Cosa metto qua? Import dati.

**Elisa Migliano:** mappatura lo mettiamo domani. Domani te lo mettiamo. Magari non tutto tutto tutto. Anche perché Ah, ecco una cosa che mi è venuta in mente, la mappatura dei lead e cos'è che era l'altra tabella, Elisa?

### **01:24:45**

**Elisa Migliano:** Ah, opportunity. Tutto opportunity non l'abbiamo fatto, però perché No, no, no, più che altro era la ah la mappatura dei lead e dei contatti, se non ricordo male. Io lì e Sabatino, lì è meglio che intervieni te perché nella mappatura del lead e dei contatti è come se io ti chiedo di a te di venire qui a fare la fattura, capito? Non ci capisco una mazza.

**Sabatino Rinaldi:** In che senso la mappatura dell'ID e dei

**Elisa Migliano:** Mi senti? Tra le tabelle di cui hanno bisogno i ragazzi,

**Sabatino Rinaldi:** contatti?

**Elisa Migliano:** fagliela vedere, Elisa, scusami. Elena. Elena, lì vedi,

**Elena Spini:** Così.

**Elisa Migliano:** c'è il foglio lead, ok?

**Sabatino Rinaldi:** Ok.

**Elisa Migliano:** Poi c'è il foglio referente che sarebbero i contatti, quelli che noi in Zo chiamiamo contatti.

**Sabatino Rinaldi:** Sì.

**Elisa Migliano:** Su queste due tabelle io lo posso anche fare, ma però corro il rischio di fare un lavoro molto sbagliato perché non sono sufficientemente competente a fare sto tipo di a capire qual è necessario, quale non è necessario. Quindi, secondo me, Sabatino, bisognerebbe che su questi due tabelle fossi tu magari a dare una mano all'Elisa.

### **01:26:00**

**Elisa Migliano:** Dopo ti voglio

**Sabatino Rinaldi:** Boh,

**Elisa Migliano:** anche

**Sabatino Rinaldi:** io non ci ho mai messo mani, ma va bene. Il fatto è che non ci sono, però va bene.

**Elisa Migliano:** eh in realtà lo dovremmo fare, secondo me, anche con Marco,

**Sabatino Rinaldi:** Eh, esatto. Cioè,

**Elisa Migliano:** perché comunque

**Sabatino Rinaldi:** a me mi sembrano più cose lato che poi devono arrivare al lato sales più che

**Elisa Migliano:** tra

**Sabatino Rinaldi:** mio. Io prendo quel che mi trovo

**Elisa Migliano:** il il lead lato tuo, cioè il lato forse un po' più tuo,

**Sabatino Rinaldi:** davanti.

**Elisa Migliano:** Saba, però è quello forse è il dove dobbiamo metterci giù. Comunque magari lo facciamo in tre, cerchiamo di dividero.

**Sabatino Rinaldi:** Va bene,

**Elisa Migliano:** È buona.

**Sabatino Rinaldi:** va bene.

**Elisa Migliano:** L'unica cosa e l'unica cosa,

**Sabatino Rinaldi:** E ok.

**Elisa Migliano:** Elena, riguardo all'asset che tu mi hai detto, io m'aspettavo che voi compilavo, eccetera eccetera. Eh, SN,

**Sabatino Rinaldi:** Sì. S.

**Elisa Migliano:** nel senso che secondo me prima di passarti ehm

**Elena Spini:** А

**Elisa Migliano:** le informazioni comunque i campi che noi abbiamo sull'asset attualmente è mh Mm.

### **01:26:58**

**Elisa Migliano:** diciamo un flusso che dobbiamo ancora vedere bene, cioè non non io non so se vi abbiamo mai fatto vedere quello che ehm cioè come lo stiamo gestendo noi sia la tua campi che la tua flusso. Quindi metterti dei campi e rifarlo uguale su se forse non so

**Elena Spini:** Scusa che qual è il flusso che dobbiamo ancora vedere?

**Elisa Migliano:** quanto.

**Elena Spini:** Bene. Aiuto\! Cioè, il flusso dei biglietti è questo,

**Elisa Migliano:** Allora io biglietti questo è la prima volta che lo eh No,

**Elena Spini:** quello che stiamo vedendo adesso.

**Elisa Migliano:** esatto. Ed è la prima volta che lo vedo. Non so se magari ero in fere l'altra volta, non so se è la prima volta che lo fai vedere in generale lo vedo in fere.

**Elena Spini:** No, no, ha già discusso.

**Elisa Migliano:** No, ok,

**Elena Spini:** In realtà è già discusso e il problema è stato che,

**Elisa Migliano:** allora.

**Elena Spini:** appunto, noi l'avevamo pensato con la firma digitale, invece adesso lo stiamo rivedendo perché la firma digitale c'è solo per i preventivi. Siamo arrivati a

**Elisa Migliano:** Ok. M ci sono poi dei campi eh appunto nel nei biglietti che non so

### **01:27:44**

**Elena Spini:** qua.

**Elisa Migliano:** se a sto punto abbiamo mai visto, mi viene da dire. Sì, dopo sui biglietti secondo me quando si arriverà il biglietto dobbiamo fare un un approfondimento, eh, e quindi non so se metterti, cioè se quei campi ha senso metterli ora sul file, perché magari può essere fase di discussione che se si potrebbe cambiare il modo in cui lo

**Elena Spini:** Eh,

**Elisa Migliano:** facciamo.

**Elena Spini:** ok. Eh, quando possiamo fare questa discussione su questi campi?

**Elisa Migliano:** Io rientro il 17, per me è uguale.

**Elena Spini:** Cosa possiamo

**Elisa Migliano:** Io rientro il 17.

**Elena Spini:** farlo io e te?

**Sabatino Rinaldi:** Eh sì,

**Elena Spini:** Racconti che cosa fai?

**Elisa Migliano:** Magari inserisco anche Rebecca,

**Sabatino Rinaldi:** esatto.

**Elisa Migliano:** visto

**Sabatino Rinaldi:** Facciamo che in questa fase qui mettiamo Rebecca anche dentro le call

**Elisa Migliano:** che

**Sabatino Rinaldi:** perché il mondo biglietti, flussi, campi, CF, tanto se credo di aver capito bene intendi anche quella parte lì dei CF che abbiamo noi.

**Elisa Migliano:** in realtà nof.

**Sabatino Rinaldi:** Vabbè, vanno inseriti anche quelli perché ci pensavo adesso. Ehm,

**Elisa Migliano:** Dipende come vogliamo fare gli invi in realtà.

### **01:28:57**

**Sabatino Rinaldi:** aggiungiamo anche Rebecca.

**Elisa Migliano:** Vabbè, comunque va

**Sabatino Rinaldi:** Vabboh. Sì, sì, vanno van visti e teniamo Rebecca dentro, quindi sì.

**Elisa Migliano:** bene.

**Sabatino Rinaldi:** Spcegliete una data quella settimana più date che vi servono.

**Elena Spini:** Va bene. Poi in caso ti mando una proposta, Elisa, a te,

**Elisa Migliano:** Sì.

**Elena Spini:** anche perché ci sarò solo io, quindi capiamo come incastrare. In realtà per ora abbiamo detto due meeting, uno diciamo meeting flussi marketing, uno boh, asset campi che non abbiamo visto. Va bene. Eh, torniamo noi, quindi siamo arrivati a questo punto, eh qua anche x giorni dall'evento da capire poi magari effettivamente con Matteo Barrec partire questa comunicazione. arriverà un link. Il link dovrà essere compilato dal referente, diciamo, che ha acquistato questi biglietti. Vedrà tante righe, quanti sono i biglietti acquistati, mette una lista di partecipanti. Cosa succede? Eh, sotto a livello di salesource verrà associato al biglietto il contatto che inserisce il il tizio, si creerà il contatto se non c'è e verrà aggiunto il campaign member. Qua invio mail per firma documenti.

### **01:30:29**

**Elena Spini:** Non c'è più, quindi lo tolgo. Qua tutto sto giro non c'è più, quindi lo tolgo. Ok, allora passiamo direttamente. Quindi conferma, mette la mail, semplicemente noi mandiamo ad ogni indirizzo email che mette immagino email diverse perché ci sono quel code con associati a a contatti diversi. Corretto?

**Sabatino Rinaldi:** Eh sì, sì, sì, sì. Ogni persona, ogni partecipante riceverà il proprio la propria documentazione col QR code integrato alla vecchia.

**Elena Spini:** Perfetto. E poi sarà lui che dovrà stamparsi il tutto e tanti cari

**Sabatino Rinaldi:** Esatto. E questo spiega il perché. In una prima fase del funnel noi chiediamo al titolare che ha acquistato i biglietti di indicare mail,

**Elena Spini:** saluti.

**Sabatino Rinaldi:** nome, cognome, numero di telefono di tutti i partecipanti, perché poi arriverà questo documento del Qare Code a tutti i partecipanti.

**Elena Spini:** Come in una prima fase,

**Sabatino Rinaldi:** Hai presente quando ti ho spiegato l'inizio del fun che mandiamo la mail

**Elena Spini:** eh? Non è proprio l'inizio,

**Sabatino Rinaldi:** al No,

**Elena Spini:** non era a ridosso dell'evento o qua a

### **01:31:54**

**Sabatino Rinaldi:** no, nel senso Eh, sì, sì,

**Elena Spini:** 3060?

**Sabatino Rinaldi:** sì, sì. No, sei andata in ansia. Aspetta, calmati.

**Elena Spini:** No, no,

**Sabatino Rinaldi:** Eh,

**Elena Spini:** sto cercando di capire.

**Sabatino Rinaldi:** ecco, quando mandiamo la prima comunicazione alla al titolare che gli chiediamo tramite quel link di inserire i dati dei partecipanti e quelle informazioni poi ci serviranno proprio per mandare eh il QR code ai partecipanti,

**Elena Spini:** No.

**Sabatino Rinaldi:** quello che mi hai appena fatto vedere.

**Elena Spini:** Sì, sì, sì, assolutamente. Quindi,

**Sabatino Rinaldi:** Eh no,

**Elena Spini:** cioè,

**Sabatino Rinaldi:** era un recup,

**Elena Spini:** io mi aspetto che è subito verrà subito,

**Sabatino Rinaldi:** era un recup.

**Elena Spini:** cioè subito che lui conferma. Questi sono i i partecipanti. Io mando già direttamente tutte queste mail. È una cosa Ok,

**Sabatino Rinaldi:** Sì, sì, sì, sì,

**Elena Spini:** perfetto. Quindi tornando invece agli stati dell'asset,

**Sabatino Rinaldi:** sì.

**Elena Spini:** quindi disponibile assegnato sarebbe quindi quando gli mandiamo la mail. Eh, in questo caso quand'è diventa assegnato perché prima per me era assegnato con la firma, adesso Co?

### **01:32:57**

**Sabatino Rinaldi:** No, adesso Ah. No.

**Elena Spini:** è solo disponibile,

**Sabatino Rinaldi:** Sì, sì,

**Elena Spini:** cioè non cambia,

**Sabatino Rinaldi:** resta disponibile,

**Elena Spini:** rimane disponibile e basta.

**Sabatino Rinaldi:** resta disponibile.

**Elena Spini:** passerà poi da disponibile a utilizzato se va

**Sabatino Rinaldi:** Esatto. Eh sì,

**Elena Spini:** all'evento

**Sabatino Rinaldi:** perché non gli diamo più il QR code

**Elena Spini:** ovviamente

**Sabatino Rinaldi:** code. Eh,

**Elena Spini:** camente come fat

**Sabatino Rinaldi:** cioè adesso in pratica per noi per noi l'assegnato, se proprio gli vogliamo dare un significato, l'assegnato è nel momento in cui mandiamo i il i quel la documentazione da firmare ai partecipanti col QR code, quello è il nostro assegnato, però non c'è ancora firmato i campi, non è detto che venga,

**Elena Spini:** Esatto.

**Sabatino Rinaldi:** eccetera ecceta,

**Elena Spini:** Ma ha senso mettere assegnato?

**Sabatino Rinaldi:** così come non è detto che venga.

**Elena Spini:** Vi interessa? Oh,

**Sabatino Rinaldi:** Eh, in realtà Sì, sì,

**Elena Spini:** cioè non è che possiamo togliere.

**Sabatino Rinaldi:** sì, sì, sì. No, no, ci interessa comunque perché ci fa statistica per capire quante persone hanno il biglietto nelle mani.

### **01:33:49**

**Sabatino Rinaldi:** Quindi sì,

**Elena Spini:** Ok,

**Sabatino Rinaldi:** perché questo qui per noi è comunque quella persona il biglietto.

**Elena Spini:** quindientazione più Qare code. Perfetto. Quindi questo non è più rosso.

**Elisa Migliano:** Scusate un secondo. prima che di andare avanti sulle altre fasi disponibile,

**Elena Spini:** Ottimo.

**Elisa Migliano:** il biglietto diventa disponibile sotto vedo fattura pagato a livello di trash o riga d'ordine. Allora, il biglietto è disponib La regola che abbiamo oggi è che il biglietto si rende disponibile se tutta la fattura dove è contenuto quella riga d'ordine è pagata. Non so se mi sono

**Elena Spini:** No. Sì. Sai perché aveva messo così con l'indicazione di riga d'ordine trancia?

**Elisa Migliano:** spiegato.

**Elena Spini:** Perché avevo immaginato eh ha il bundle con più eventi.

**Elisa Migliano:** Sì, a è a prescindere, diciamo, bisog è necessario che eh quel biglietto assuma lo stato disponibile nel momento in cui la fattura dove è contenuto il biglietto, chiaramente fattura all'ordine collegato eccetera eccetera, no? in quell'ordine c'è quel quel codice prodotto fatturato. Se la fattura è totalmente incassata, il biglietto diventa disponibile.

**Elena Spini:** Non si capisce da quello che ho scritto.

### **01:35:28**

**Elena Spini:** Cioè per me è così. È così.

**Elisa Migliano:** Eh, perché c'è c lì c'è riga d'ordine.

**Elena Spini:** Fattura.

**Elisa Migliano:** Non vorrei che mi tre se inganno, diciamo, ad

**Elena Spini:** Allora, fattura pagata a livello,

**Elisa Migliano:** una

**Elena Spini:** boh, come lo voglio mettere? Di riga d'ordine, secondo me. No, fattura pagata.

**Elisa Migliano:** fattura pagata. Punto. Sì, fattura pagata. Yeah.

**Elena Spini:** Cioè, era per dire che se eh aspetta eh che se eh qua invece l'account ha acquistato Cioè, se questo ordine di questo account e contatto di questo referente è magari un bundle con cinque eventi disponibile non diventa

**Elisa Migliano:** Ok.

**Elena Spini:** quando tutto l'ordine, la fattura di tutto l'ordine è pagato, ma quando a livello di riga riga d'ordine quella fattura è pagata. Era per spiegarlo così, cioè perché se abbiamo acquistato cinque cinque eventi nel corso dell'anno, ma questo è la l'asset di del primo evento, non devo aspettare la fattura di tutto l'ordine. Quindi era per questo era l'indicazione della riga d'ordine.

### **01:37:20**

**Elisa Migliano:** Vabbè, adesso lasciamolo così.

**Elena Spini:** Va

**Elisa Migliano:** dopo lascialo pure come dopo ci ci ragioniamo meglio un pochino più

**Elena Spini:** bene,

**Elisa Migliano:** nel dettaglio quando sarà arriveremo al nel al

**Elena Spini:** siamo al punto. Non dirmi così perché noi stiamo dobbiamo sviluppare e stiamo alla

**Elisa Migliano:** L'importante

**Elena Spini:** fine,

**Sabatino Rinaldi:** Ah,

**Elena Spini:** quindi per No,

**Sabatino Rinaldi:** ma tanto vedrai che anche dopo lo sviluppo esce qualcosa che tocca

**Elena Spini:** va benissimo per me,

**Sabatino Rinaldi:** cambiare.

**Elena Spini:** però eh cioè a voi scade il contratto di di Zo, quindi

**Sabatino Rinaldi:** Fabrizio è ben è felice di rinnovarlo.

**Elena Spini:** Quindi

**Elisa Migliano:** è che L'importante è che si capisca un principio. L'importante è che si capisca un principio fondamentale che più che è più facile a dirlo che esprimerlo in linguaggio tecnico.

**Elena Spini:** esatto. Va

**Elisa Migliano:** quel biglietto è disponibile quando la fattura con la quale io l'ho

**Elena Spini:** bene.

**Elisa Migliano:** fatturato quel biglietto deve essere integralmente pagata, tutta pagata, deve essere

**Elena Spini:** tutta

**Elisa Migliano:** tutta la fattura deve essere tutta pagata perché se un

**Elena Spini:** e la fattura di questo ordine, se ma torniamo all'esempio,

### **01:38:31**

**Elisa Migliano:** cliente Allora io io

**Elena Spini:** se la fattura dell è di un ordine di 520 diventa disponibile quando ho pagato tutto?

**Elisa Migliano:** Sì.

**Elena Spini:** Ma se io compro un mh ad esempio eh non so, facciamo finta che camerieri e venditori è a settembre, ad esempio. Poi c'è nel corso dell'anno ci sono altri 5 eventi.

**Elisa Migliano:** Qui.

**Elena Spini:** Io devo pagare prima tutti gli eventi, tutto l'ordine di tutti gli eventi che ho comprato per avere il mio biglietto disponibile.

**Elisa Migliano:** Esatto.

**Elena Spini:** Va bene, se è così.

**Elisa Migliano:** Sì,

**Elena Spini:** Io avevo capito

**Elisa Migliano:** facciamo l'ipotesi che io facciamo eh ma facciamo l'ipotesi.

**Elena Spini:** diverso.

**Elisa Migliano:** Allora, per fortuna che ho sollevato la questione, facciamo l'ipotesi che compro un bundle, no? quel bandola ha 10 ha 10 corsi diversi.

**Elena Spini:** Esatto.

**Elisa Migliano:** Poi cosa succede? Che ok,

**Elena Spini:** Ok.

**Elisa Migliano:** eh fatturerò la prima tranche del bundle. La prima tranche del bundle ha due eventi dentro di sé. Ipotizziamo che la fattura sia di €1000. Ok? Se il cliente mi paga €500, quella fattura non è integralmente pagata, quindi quei due eventi non devono essere disponibili.

### **01:39:58**

**Elena Spini:** Va bene, perfetto.

**Elisa Migliano:** Quando il cliente mi pagherà gli altri cinque, tutta la fattura sarà pagata, quindi i due eventi contenuti in quella fattura devono essere disponibili. Seconda tranche vale lo stesso principio, terza tranche v lo stesso principio e così via.

**Elena Spini:** No,

**Aurel mrruku:** Ma quindi non stiamo dicendo perché io la posso

**Elena Spini:** aspetta, adesso hai detto delle crunch, mi sono persa. Vai, vai.

**Aurel mrruku:** posso io avevo capito che nel momento in cui ogni fattura si collega a una tranch, ma stiamo dicendo che la fattura non viene collegata alla tranch, ma è una cosa più generale, perché io avevo capito il tranche per questo motivo qua, per raggruppare un insieme di prodotti che possono essere fatturabili in un certo momento.

**Elisa Migliano:** Perfetto. E in quel famoso bundle io ho i primi due prodotti che sono segnati alla tranche del 31 di agosto.

**Aurel mrruku:** Sì.

**Elisa Migliano:** Ok. Io prendo e fatturo il 31 di agosto quei due

**Elena Spini:** Ah,

**Aurel mrruku:** E infatti perché ne avevamo parlato che la data della transave coincidere con la data della

**Elisa Migliano:** prodotti.

**Elena Spini:** ok.

**Aurel mrruku:** fattura perché era l'unico modo per collegare la fattura con la tranche perché noi le trunche non li passiamo su, passiamo sulla riga d'ordine che avrà una data di fatturazione, diciamo.

### **01:41:19**

**Elena Spini:** Ecco,

**Aurel mrruku:** Ritorna.

**Elisa Migliano:** Quando quella fattura che io ho fatto sarà pagata, quei due biglietti saranno

**Aurel mrruku:** Corretto, corretto.

**Elisa Migliano:** disponibili.

**Elena Spini:** però cioè

**Aurel mrruku:** Ma se tu non hai pagato tutti e due i biglietti, hai pagato solo uno, solo uno dei biglietti sarà in un certo stato, quindi la tranche non sarà chiusa, quindi non sarà fatturata. ne avevamo già parlato.

**Elisa Migliano:** Ho paura Ho paura che ci stiamo incartando.

**Elena Spini:** Sì. No, ma io io ho capito forse,

**Elisa Migliano:** Sì.

**Elena Spini:** cioè, cosa perché c cioè io Allora, facciamo che c'è un ordine che ha tre tranche. Ok. In queste tre tranche ci sono diversi eventi.

**Elisa Migliano:** Ma con tranche te intendi tranche di pagamento dello stesso ordine,

**Elena Spini:** Sì.

**Elisa Migliano:** quindi Ok.

**Elena Spini:** Rate di pagamento.

**Elisa Migliano:** Ok. Sì, sì, va

**Elena Spini:** Ok. rate di pagamento.

**Elisa Migliano:** bene.

**Elena Spini:** La prima rata è il primo evento, poi ci sono gli altri eventi.

**Elisa Migliano:** No,

**Elena Spini:** A

**Elisa Migliano:** no, no.

**Elena Spini:** me

**Elisa Migliano:** La prima rata può contenere più di un evento perché l'ordine è unico.

### **01:42:32**

**Elisa Migliano:** Questo qui però l'avevamo detto, eh,

**Aurel mrruku:** Ma non Ma non non ho un

**Elena Spini:** No, sì, va bene, ma ok, va bene, facciamo finta che non è un problema, infatti.

**Aurel mrruku:** problema.

**Elena Spini:** Cioè, va bene, può avere più eventi.

**Elisa Migliano:** era

**Elena Spini:** Perfetto. Contiene più righe, ok, questa tranche che sono più eventi. Io mi riferisco a fattura pagata, quindi ticket disponibile per N20, quando la rata è pagata. Non tutte le rate sono

**Elisa Migliano:** No, perché tu praticamente, esempio,

**Elena Spini:** pagate.

**Elisa Migliano:** in un ordine ci sono due eh eventi o tre eventi, quelli che siano. Questi eventi possono essere spartiti per n rate, ok? Ma fintanto che le rate non sono saldate,

**Elena Spini:** Ok.

**Elisa Migliano:** l'ordine non risulta saldato, perché non è che c'è una rata che sblocca un un corso all'interno dell'ordine, non c'è questo collegamento. Ci sono tot rate che vengono suddivise sulla base poi in realtà della gestione del cliente, non sulla base dell'evento.

**Aurel mrruku:** Ma state dicendo cose diverse

**Elisa Migliano:** No, no, ma aspetta, scusa, scusa Aurel, scusa, scusa.

### **01:43:45**

**Elisa Migliano:** Ritorniamo all'esempio dei blocchi. Io ho un blocco, faccio un ordine, ok? un ordine, un e un pack, un ordine. Bene, quando vado a inserire le righe ordine metterò evento 1, evento 2, prima tranche,

**Aurel mrruku:** Correto.

**Elisa Migliano:** quella del supponiamo 31 gennaio.

**Aurel mrruku:** Sì.

**Elisa Migliano:** Poi poi andrò a mettere dentro evento 3, evento 4,

**Aurel mrruku:** Corretto.

**Elisa Migliano:** tranche 2 28 di febbraio. Poi metto metto dentro gli ultimi due gli ultimi due articoli, quindi Tranche 3 31 di marzo. A me quel 31 la data di scadenza della tranche mi dice quando io devo fatturare quella tranche, quindi io avrò farò una fattura sui primi sulle prime due righe d'ordine di questo

**Aurel mrruku:** e verranno sbloccate,

**Elisa Migliano:** ordine.

**Aurel mrruku:** verrà generato il biglietto per

**Elena Spini:** Etto.

**Aurel mrruku:** questi.

**Elisa Migliano:** Il biglietto si genera nel momento in cui si fa l'ordine, però quel bigliet quel biglietto diventa disponibile quando la fattura collegata alla prima trash è integralmente pagata.

**Aurel mrruku:** Sì, questo stiamo dicendo.

### **01:44:56**

**Elena Spini:** Certo, stiamo dicendo la stessa cosa.

**Elisa Migliano:** Ok? M.

**Elena Spini:** Per quello c'era scritto tranche a livello righe d'ordine.

**Aurel mrruku:** Però Però l'esempio che ha dato Elisa non era lo stesso perché lei ha detto quando verrà pagato

**Elena Spini:** Nie.

**Aurel mrruku:** tutto, quindi tutti tutte le tranche che contengono un

**Elisa Migliano:** No, no, no, no. Io mi No,

**Aurel mrruku:** evento.

**Elisa Migliano:** no, io mi riferivo a un ordine, non mi riferivo alle più tranche, cioè un conto è dire più tranche di preventivi e un conto è più tranche di pagamento,

**Aurel mrruku:** Ma l'ordine ha più tranch. Ok,

**Elisa Migliano:** ma comunque ci siamo capiti,

**Aurel mrruku:** ok.

**Elena Spini:** Sì.

**Aurel mrruku:** Quindi è è vero quello che ha appena descritto adesso Fabrizio,

**Elisa Migliano:** cioè

**Aurel mrruku:** vero? Oddio,

**Elena Spini:** Fabrizio,

**Aurel mrruku:** Fabrizio. Ok.

**Elena Spini:** fattura pagata a livello dirata barra tranche punto.

**Elisa Migliano:** Ok,

**Aurel mrruku:** Ok.

**Elisa Migliano:** ok, va bene.

**Aurel mrruku:** Beh,

**Elena Spini:** Ok.

### **01:45:43**

**Aurel mrruku:** e confermiamo che il match tra la fattura e la tranche è la data. Eh, allora, per capire se quella tranche è pagata, la fattura che arriva su Sales Force deve avere la la stessa data della tranch, quindi ordine la fattura

**Elisa Migliano:** Allora, qui dopo ci vediamo di capire perché per come siamo abituati oggi, cosa succede? Che il tutor mette dentro nella nella prima tranche mette dentro ad esempio 31 gennaio ipotesi, no? Questo perché la la data della tranche la decide il tutor, quindi il tutor mette dentro 31 gennaio. Per come è la menclat per come abbiamo oggi la nomenclatura, quel 31 gennaio significa la data di incasso. Quindi noi che cosa facciamo?

**Aurel mrruku:** Abbiamo

**Elisa Migliano:** A inizio di gennaio facciamo le fatture di tutte le trust che scadono il 31

**Aurel mrruku:** perso.

**Elisa Migliano:** gennaio. Ok?

**Aurel mrruku:** Ok.

**Elisa Migliano:** Quindi in realtà la data che è indicata sulla tranche e oggi noi la intendiamo come la data di incasso di di presumibile incasso.

**Aurel mrruku:** Ok. E mi arriva nel momento in cui mi arriva la fattura su

**Elisa Migliano:** Poi se no, la è la data di presumibile incasso,

### **01:47:07**

**Aurel mrruku:** quell'ordine.

**Elisa Migliano:** però noi non aspettiamo che di ricevere i soldi dal cliente per fatturare. Noi in questi casi qui fatturiamo subito al primo di gennaio, se la data di scadenza

**Aurel mrruku:** Non so se sono io,

**Elena Spini:** No, salti.

**Aurel mrruku:** ma abbiamo proprio perso.

**Elena Spini:** No, salta.

**Aurel mrruku:** E a sto punto faccio direttamente sullo stato della riga. Quando tutte le righe sono state pagate gli mettiamo la transpagata. Però quando arriva la fattura, come farò in a collegarla? Forse la fattura conterrà gli item, i prodotti.

**Elena Spini:** La fattura contiene le righe perché avevano detto Sì,

**Aurel mrruku:** Se contiene le righe, allora ci siamo.

**Elena Spini:** avevan detto che Aspetta Tam.

**Aurel mrruku:** No.

**Elena Spini:** Trunch contenitore €7 la scadenza va a livello di riga sottoinsieme delle righe con scadenza quando il cliente paga l'acconto. Vbè, vabbè. Sì, ma poi dopo è quello che mandiamo praticamente a a Mexale che poi loro ci mandano,

**Aurel mrruku:** Sì, sì,

**Elena Spini:** quindi Sì.

**Aurel mrruku:** però la fattura in qualche modo deve arrivare su sales force.

### **01:48:20**

**Elena Spini:** Poi in realtà qua è mandiamo mexal la

**Aurel mrruku:** Ma neanche ci serve in teoria la fattura,

**Elena Spini:** fattura.

**Aurel mrruku:** basta che ci dicono che le righe sono state pagate.

**Elena Spini:** No, la vogliono.

**Aurel mrruku:** Ah, la vogliono.

**Elena Spini:** Non dire che non ci serve.

**Aurel mrruku:** Ok, ok, la vogliono.

**Elena Spini:** La vogliono perché poi ci sono le regole di logiche di di report che avevamo detto.

**Aurel mrruku:** Ok, ok.

**Elena Spini:** Dov'era? Eccolo qua. Azzurrino.

**Aurel mrruku:** Eh sì,

**Elena Spini:** Eh, si è ricollegato. Mo.

**Aurel mrruku:** vedo Elisa che allora stavamo

**Elisa Migliano:** Sì, vi sentiamo. Sì.

**Aurel mrruku:** dicendo quando ci arriva la fattura, come leghiamo la fattura con i prodotti di quella fattura. Nella fattura ci arriva ci viene censito anche il prodotto, vero?

**Elisa Migliano:** Nella fattura c'è il numero d'ordine,

**Aurel mrruku:** Sì.

**Elisa Migliano:** il codice articolo e e anche la riga d'ordine,

**Aurel mrruku:** E gli articoli. Perfetto. Ok.

### **01:49:17**

**Aurel mrruku:** Eh, allora, siamo a posto.

**Elena Spini:** Esatto.

**Elisa Migliano:** immagino.

**Aurel mrruku:** Quindi io in base alle righe d'ordine collego la fattura con le

**Elena Spini:** Esatto.

**Aurel mrruku:** trans.

**Elisa Migliano:** Quindi il discorso della data va bene che continuiamo la Ok,

**Aurel mrruku:** Non serve,

**Elena Spini:** No.

**Aurel mrruku:** non serve perché se se poi tu mi fai arrivare una fattura su

**Elisa Migliano:** perfetto.

**Aurel mrruku:** quell'ordine, io vado a fare il match dei prodotti dell'ordine coi prodotti della fattura e decido quali su quale trans sono questi ordini, scusa, questi prodotti.

**Elisa Migliano:** Sì, diciamo che forse adesso, ma vabbè, questi sono tecnicismi, non voglio, però avendo noi su Mexal e cliente, numero documento, riferimento del numero d'ordine e le e il numero di riga d'ordine, forse il match è più sicuro facendolo in base al numero di riga d'ordine, perché poi dopo, come dicevamo l'altro giorno, coi prodotti noi siamo abbastanza eh ballerini, nel senso che un tutor può mettere anche lo stesso codice due volte nello stesso ordine, capito? dopo potrebbe potrebbero venir fuori delle difficoltà tecniche,

**Elena Spini:** Ok,

**Elisa Migliano:** quindi è bene, secondo me, lavorare più dal punto di vista eh tecnico su elementi che sono nascosti ai tutor.

### **01:50:41**

**Aurel mrruku:** Chiaro, chiaro.

**Elena Spini:** abbiamo partorito il giro dei flusso dei biglietti, secondo me. Sì. Ah, qua c'era una cosa in più, eh. Eh, bottone per gestione dei casi limiti limite casi limite che erano allora gestione dei casi limite cambio nome dei partecipanti, mancata firma digitale non c'è più quindi mancata firma va tolto e cambio nome dei partecipanti, però in realtà pure è questo, cioè va gestito, lo gestirete live, quindi forse non c'è più niente, però il QR code, come lo gestite, che

**Aurel mrruku:** Ma da quello che ho capito io,

**Sabatino Rinaldi:** Ah,

**Aurel mrruku:** il Qod

**Elena Spini:** fate?

**Sabatino Rinaldi:** in quel caso viene il partecipante all'evento,

**Aurel mrruku:** Sì.

**Sabatino Rinaldi:** fa tutta la compilazione lì.

**Elena Spini:** Il QR code non glielo diamo più.

**Sabatino Rinaldi:** lo facciamo,

**Elisa Migliano:** No, quel

**Sabatino Rinaldi:** facciamo entrare manualmente.

**Elena Spini:** E come scrivete questa cosa su Salesource?

**Sabatino Rinaldi:** Cioè, se viene qualcuno se viene qualcuno che non era tra i i nominati,

**Elena Spini:** Non la scriverete mai.

**Sabatino Rinaldi:** diciamo,

**Elena Spini:** Ah\!

**Sabatino Rinaldi:** dal dal titolare,

### **01:51:54**

**Elena Spini:** Ah\!

**Sabatino Rinaldi:** quindi si presenta magari la moglie del titolare e deve compilare lì eh al checkin tutta la documentazione e lo inseriamo noi nel sistema manualmente. Ora io non sono mai stato i checkin, credo che sia più o meno così. Elisa di sicuro mi può dare

**Elisa Migliano:** Allora, in realtà quando viene una persona al posto di un'altra facciamo rifirmare al cliente

**Sabatino Rinaldi:** conferma.

**Elisa Migliano:** tutto perché abbiamo anche delle stampe in evento e successivamente andiamo ad inserire a mano noi il cliente che è venuto al posto di un altro.

**Sabatino Rinaldi:** E non ti piaceva come l'avevo detto io?

**Elena Spini:** Fattia,

**Elisa Migliano:** Non in realtà non ti avevo ascoltato.

**Elena Spini:** stessa cosa.

**Elisa Migliano:** Ho

**Sabatino Rinaldi:** Vabbè,

**Elena Spini:** A posto.

**Sabatino Rinaldi:** mi ha fatto passare per un emerito c\*\*\*\*\*\*\*,

**Elisa Migliano:** sentito

**Sabatino Rinaldi:** ma è così.

**Elena Spini:** E va bene che inserite questa cosa, però quindi lui non avrà un QR

**Elisa Migliano:** lì per lì.

**Sabatino Rinaldi:** No,

**Elena Spini:** C.

**Sabatino Rinaldi:** ma perché di base a noi il QR code serve semplicemente per facilitare il checkin giustamente che che arriva

**Elisa Migliano:** No.

**Sabatino Rinaldi:** col QR code lo scannerizziamo.

### **01:53:03**

**Sabatino Rinaldi:** Qualora non dovesse averlo per X motivi, il caso che ti abbiamo spiegato io ora può essere uno di questi casi. è un inserimento che noi facciamo manualmente.

**Elisa Migliano:** Il caso classico è che il cliente o non ha stampato e oppure non gli è arrivata la mail, perché abbiamo avuto tantissimi problemi legati a questo, che al cliente non arrivi la mail con i biglietti.

**Elena Spini:** Aspetta, aspetta, passiamo da un attimo. Finiamo questa cosa del cambio nome. Cioè, sai che cosa mi preoccupa? Cioè, non so quanti casi di cambio nome avete.

**Elisa Migliano:** Ne.

**Elena Spini:** Iniziamo da Ok.

**Sabatino Rinaldi:** Abbiamo di sicuro più casi di persone che non stampano il biglietto e quindi vengono senza documentazione.

**Elisa Migliano:** M.

**Elena Spini:** Ok.

**Sabatino Rinaldi:** No.

**Elena Spini:** Perché ci sta che poi voi magari questa persona poi con la santa pazienza la mettete a mano. Ok. Ma sai che cosa mi stava preoccupando? è il fatto che poi voi inserite questo contatto, ma poi non mi segnate che effettivamente questo tizio faceva parte della campagna e ha il il biglietto utilizzato,

**Elisa Migliano:** No, vabbè,

**Elena Spini:** però

**Elisa Migliano:** diciamo che all'infopoint ci sono delle persone valide che capiranno cosa devono fare.

### **01:54:10**

**Elisa Migliano:** una volta capito cosa devono fare.

**Elena Spini:** mh

**Elisa Migliano:** No, no,

**Sabatino Rinaldi:** Ecco.

**Elisa Migliano:** su quello siamo abbastanza allineati, non non mi non mi fa paura troppo, anche perché lo faccio io, cioè sono io di solito l'infopo

**Elena Spini:** No, sì, è che capire, cioè,

**Elisa Migliano:** quindi

**Elena Spini:** nel senso, a parte la persona che ti dà il nuovo foglio cosa fare dopo? Come mettere questa persona?

**Elisa Migliano:** Ma non possiamo fare un effettivo cambio nominativo su quello che è già stato compilato?

**Elena Spini:** Sì. Ed era quello che volevamo fare con questo bottone caso limite cambio nome, però tu mi hai detto che in realtà ti arriva semplicemente il foglio e poi lo metti in un secondo

**Elisa Migliano:** No, no, lo metto nello stesso. Allora, lo mettiamo anche nello stesso. Dipende,

**Elena Spini:** momento.

**Elisa Migliano:** dipende da quanta mole c'è, però se so che lo devo cambiare subito, perché nel sistema che abbiamo adesso non cambia nulla se lo inserisco dopo, ma nell'ipotesi in cui lo devo inserire nel mentre, lo inserisco nel mentre,

**Elena Spini:** Perché idealmente qua avevamo pensato,

**Elisa Migliano:** cioè non è un

**Elena Spini:** vai sull'account, quindi sul ristorante di riferimento,

**Elisa Migliano:** attendo, no?

### **01:55:12**

**Elena Spini:** clicco un bottone caso limite e questo bottone che cosa fa?

**Elisa Migliano:** Perché?

**Elena Spini:** Eh, aspetta, batto, mi inserisco meglio che devo questo non c'è più perché qua era l'invio della mail. Invio link landing dov essere scelta opzione 1 2. No, docus nuovo contatto non c'è più. Questo bottone, allora, sto facendo live con te, in realtà mi farà vedere quelli che sono i biglietti disponibili. C'era un po' pappino con i biglietti, gli asset disponibili su sotto quell'account e potrò fare

**Elisa Migliano:** Oh.

**Elena Spini:** annullato, cambio nome, annullato e mettere l'informativa nuova.

**Elisa Migliano:** Va bene,

**Elena Spini:** Aurel, come la vedi?

**Elisa Migliano:** anche perché questa cosa ci potrà succedere sia in fase di evento, quindi il giorno stesso, che nei giorni tra quando i clienti lo compilano e e il giorno dell'evento, perché esempio un un cliente non può venire, viene qualcun altro, gli dobbiamo fare il cambio nominativo, spingiamo il pulsante, facciamo cambi cambia nome e piuttosto sarebbe bello anche se si potesse rinviare la mail aggiornata.

**Elena Spini:** Aspetta solo un secondo, attivo.

**Elisa Migliano:** Se me giorni magari chiamo chi Sì, domani giornata.

### **01:56:42**

**Elisa Migliano:** Sì, sì,

**Elena Spini:** Ehm, allora, quindi dicevi la mail, quale mail che volevi essere rimandata?

**Elisa Migliano:** no. Eh, nel caso in cui il cliente facesse un cambio nominativo tra quando noi lo mandiamo a quando c'è l'evento perché succede

**Aurel mrruku:** Ok,

**Elisa Migliano:** e noi nell'eventualità clicchiamo questo bottone casi limiti casi limite e cambiamo il nominativo e poi gli dovremmo rinviare la mail aggiornata o

**Aurel mrruku:** ma la mail arriverà alla mail,

**Elisa Migliano:** no?

**Aurel mrruku:** scusa il gioco delle parole. Quindi l'email deve arrivare alla mail che hai messo nel momento in cui hai cambiato il nome nativo, che il nominativo sarebbe proprio anche un'altra mail.

**Elisa Migliano:** Esatto, esatto.

**Aurel mrruku:** Di nuovo, scusa il gioco di parole,

**Elisa Migliano:** Sì,

**Aurel mrruku:** stiamo parlando proprio di di dell'email del la posta elettronica.

**Elisa Migliano:** sì,

**Elena Spini:** del

**Aurel mrruku:** Sì.

**Elena Spini:** vecchio.

**Elisa Migliano:** esatto.

**Aurel mrruku:** Ok.

**Elisa Migliano:** Так.

**Elena Spini:** Gli asset. Allora, quindi sarà un bottone e vedo tutti i biglietti eh per quel account.

### **01:58:00**

**Elena Spini:** Eh, scelgo chi annullare e chi inserire. Ok, perfetto. Poi invio mail del cambio nominativo.

**Elisa Migliano:** Esatto.

**Elena Spini:** Nominativo. Perfetto. Ma sono email

**Elisa Migliano:** No, no, io infatti no,

**Elena Spini:** informativa.

**Elisa Migliano:** io dicevo dove all'interno c'erano i dati eh corretti del biglietto.

**Elena Spini:** i dati corretti, quindi si tiene quel quel quel quer

**Elisa Migliano:** con i dati del cliente che verrà veramente, non quello vecchio,

**Elena Spini:** eh

**Elisa Migliano:** perché adesso noi nel QR code, sopra il QR code ci sono il nominativo tipo Elisa Migliano e l'evento. Se io faccio il cambio illuminativo, ci sarà scritto Fabrizio Paganelli e l'evento, quindi deve essere aggiornato anche il il modulo all'interno.

**Elena Spini:** il QR code sarà diverso perché appunto è riferito al contatto. Ok, quindi scelgo che che inserire più invio mail.

**Elisa Migliano:** Esatto.

**Elena Spini:** Allora, così se riusciamo a fare questo, diciamo, in fase di eh checkin dell'evento, siamo a posto con la gestione del QR code utilizzato o non utilizzato per dovrai scannerizzare il nuovo QR code. Perfetto. Più invia del cambio e cos'è che mandate?

### **01:59:32**

**Elisa Migliano:** Esatto.

**Elena Spini:** Un contratto, no? Vabbè, informativa. Informativa più metto solo così più per quel sistemo. Ottimo. Poi invece dicevate ci sono persone che arrivano senza i documenti.

**Elisa Migliano:** Esatto.

**Elena Spini:** Ok. Eh, che fate in quei

**Elisa Migliano:** Le inseriamo a mano all'interno di Zo perché il biglietto ce

**Elena Spini:** casi?

**Elisa Migliano:** l'hanno, è disponibile, ma cioè le casistiche sono o non hanno proprio stampato la documentazione, ma comunque ci risulta che il cliente eh l'abbia fatto da

**Elena Spini:** M.

**Elisa Migliano:** sistema, quindi l'invio dei mail gli è arrivato, ha compilato tutto.

**Elena Spini:** Solo non ha

**Elisa Migliano:** ma non stampato. Oppure che succede tante volte il cliente dice di non aver ricevuto la

**Elena Spini:** stampato.

**Elisa Migliano:** mail e effettivamente però ce l'ha il biglietto.

**Elena Spini:** E come ha fatto ad avere il biglietto se non ha la mail?

**Elisa Migliano:** Eh perché dicono che non gli arriva, anche se da noi perché magari non so sbagliano a mandarci mail e non hanno più quella mail.

**Elena Spini:** Ma e scusa, il biglietto non glielo mandate per

**Elisa Migliano:** Sì,

**Elena Spini:** mail?

### **02:00:54**

**Elisa Migliano:** ma appunto come ho detto può succedere che o mettono una mail sbagliata, perché noi lo, cioè adesso io non ho capito bene qua come vogliamo fare, ma lo inviavamo per contatto il biglietto, quindi oppure loro si eh si eliminavano dalla dalla parte marketing di voler ricevere delle email volutamente perché magari ne mandavamo troppe. E E quindi era un cane che si mordeva la coda.

**Elena Spini:** Vabbè, però la

**Aurel mrruku:** Ma le mail in questo caso li stiamo mandando da sales non da marketing, vero Elena?

**Elena Spini:** Sì, la media dei biglietti. Sì,

**Aurel mrruku:** Ja.

**Elena Spini:** comunque, cioè voi quando arriva una persona senza documenti, ma che però o o senza documenti perché non li ha stampati o per assurdo ha un biglietto e dice di non ha ricevuto la mail, cioè basta che vedete se esiste questa persona, se esiste l'asset.

**Elisa Migliano:** Noi esatto.

**Elena Spini:** Ciao.

**Elisa Migliano:** Controlliamo su vanno di solito all'infopoint, controlliamo che ci sia il biglietto, ci sia il pagamento, ci sia l'ordine,

**Elena Spini:** Ciao.

**Elisa Migliano:** eccetera eccetera eccetera. Gli facciamo compilare comunque questo modulo a mano perché comunque dobbiamo avere una firma di un contratto stipulato eccetera e e poi lo inseriamo a mano.

### **02:02:13**

**Elisa Migliano:** Quindi andiamo a seguire sul cliente che è venuto quel giorno alla talora per quell'evento eccetera eccetera.

**Elena Spini:** Eh, su questo vi dobbiamo far vedere poi cosa dovete fare a

**Elisa Migliano:** Fe.

**Elena Spini:** livello di camper. Sarebbe, però comunque un'azione manuale lo segno. Controllo checkin più aggiornament aggiornamento manuale. Member. Perfetto. Questo invece era il caso uno. Altri casi strani. Perfetto. Prenderò per un no. Fine del giro biglietti. Veramente ottimo. Torniamo al nostro documento. Plus biglietti da rivedere. Io lo metto. Ok, questo sarà. Poi integrazione Maxal. Eh, questa cosa qua la doveva vedere smarcare eh Andrea. Non mi sono accorta che nel mentre avevamo fatto le 5, seò l'avrei fatto prima. Eh ehm Fabrizio, senti?

**Elisa Migliano:** Eccoci. Ho aperto il microfono.

**Elena Spini:** Ehm, manderà una mail Andrea,

**Elisa Migliano:** Dimmi.

**Elena Spini:** un file con tutte le domande di mapping che ha, perché ci sono dei dei problemi, cioè non sa come mappare dei campi principalmente.

### **02:04:04**

**Elisa Migliano:** Ok. Ehm,

**Elena Spini:** manda una mail a lui con

**Elisa Migliano:** ok,

**Elena Spini:** tutto.

**Elisa Migliano:** non è detto che io riesca a rispondere perché dipende che tipo di domanda è, ma eventualmente coinvolgo la persona della Creosoft nel momento eh

**Elena Spini:** Perfetto. Eh beh,

**Elisa Migliano:** se se so

**Elena Spini:** noi Esatto. Noi te la giriamo in caso tu la inolri.

**Elisa Migliano:** bene. Andrea non c'è adesso,

**Elena Spini:** Perfetto.

**Elisa Migliano:** vero? Non mi può anticipare nulla.

**Elena Spini:** No,

**Elisa Migliano:** Ok,

**Elena Spini:** mannaggia a me.

**Elisa Migliano:** niente,

**Elena Spini:** Eh,

**Elisa Migliano:** è lo stesso.

**Elena Spini:** ma non ho proprio visto che stava uscito così tardi.

**Elisa Migliano:** No, no, è lo stesso, è lo stesso. Non è un problema.

**Elena Spini:** Ha detto che che manderà lui.

**Elisa Migliano:** Va bene, va

**Elena Spini:** Ok. Eh,

**Elisa Migliano:** bene.

**Elena Spini:** mappatura campizo integrata al file. Ah, questo è quello che abbiamo detto prima. Mappatura campizo da integrare nel file data model. la cosa che abbiamo visto prima che diciamo che siamo in corso, diciamola così.

### **02:05:02**

**Elena Spini:** Aperatura Campo.

**Elisa Migliano:** Sì, lo facciamo domani sto lavoro qui, eh.

**Elena Spini:** Ciao.

**Elisa Migliano:** Domani lo finiamo. Non è una cosa così. Tanto facciamo.

**Elena Spini:** Metto veramente un reminder per

**Elisa Migliano:** No, non c'è bisogno che ci fai il reminder.

**Elena Spini:** domani.

**Elisa Migliano:** Ti prego. No, perché già ho lui come reminder. Elisa, basta.

**Elena Spini:** Va bene,

**Elisa Migliano:** El

**Elena Spini:** non voglio Elisa agitata. Va bene,

**Elisa Migliano:** nonist.

**Elena Spini:** scrivo solo in corso. Va benetato pienissimo. Vabbè, già che siamo in corso mi rincuo. Direzione integrazione VCmerce. Ah, anche questo in realtà era un tema che eh doveva anticipare.

**Elisa Migliano:** Qua sabatino.

**Elena Spini:** Eh sì,

**Elisa Migliano:** Poi il sabatino.

**Elena Spini:** dico era un tema che doveva anticipare e Andrea qua. Provo io e dovevamo fare noi un check su effettivamente cosa era la Ci sei Sabatino?

**Sabatino Rinaldi:** Sì, sì, ti sento.

**Elena Spini:** Perfetto. Cos'era la direzione consigliata di questa integrazione e confermo che abbiamo fatto delle analisi e la parte di web è quella raccomandata e consigliata?

### **02:06:22**

**Sabatino Rinaldi:** Faremo Webbook,

**Elena Spini:** Ritorna.

**Sabatino Rinaldi:** va bene?

**Elena Spini:** Va benissimo così.

**Sabatino Rinaldi:** Se per voi è meglio Webbook,

**Elena Spini:** Ok.

**Sabatino Rinaldi:** a me non mi cambia niente,

**Elena Spini:** Sì.

**Sabatino Rinaldi:** io vi do quello che vi serve. L'importante è che riusciamo a far leggere poi tutta quella struttura che vogliamo creare che di quel documento che avevamo visto, però credo che questa analisi l'han fatta in virtù di quel documento che ho condiviso.

**Aurel mrruku:** Corretto, corretto.

**Sabatino Rinaldi:** Allora, perfetto, va bene.

**Elena Spini:** E il documento condiviso è quello che vi hai fatto vedere l'ultima volta.

**Sabatino Rinaldi:** Sì, sì, sì, sì,

**Elena Spini:** parlate di quello.

**Sabatino Rinaldi:** sì, sì, sì,

**Elena Spini:** Ok, perfetto.

**Sabatino Rinaldi:** sì.

**Elena Spini:** E su questo poi Aurel, cioè ci manca comunque che mh Salvatino ci deve dare qualcosa o siamo autonomi perché da quel documento riusciamo a avere tutto e possiamo

**Aurel mrruku:** Allora, ideale è si devono scambiare le credenziali e si deve iniziare a mettere un

**Elena Spini:** partire.

**Sabatino Rinaldi:** Так.

**Aurel mrruku:** payload, quindi a fare degli esempi con dei payload anche non molto reali, ma giusto per iniziare a mettere le strutture in

### **02:07:18**

**Sabatino Rinaldi:** Sì, quando vuole, ovviamente,

**Aurel mrruku:** piedi.

**Sabatino Rinaldi:** sempre al rientro delle mie ferie, ci mettiamo lì, gli do un ID prodotto, mettiamo il PHP dove devo metterlo e creiamo il web, facciamo delle prove.

**Aurel mrruku:** Sì, sì, infatti.

**Sabatino Rinaldi:** Secondo me è una cosa che se ci mettiamo in cola anche un'oretta la facciamo veloce,

**Aurel mrruku:** Perfetto. In teoria sì,

**Sabatino Rinaldi:** non vedo troppi problemi.

**Aurel mrruku:** ormai è abbastanza.

**Sabatino Rinaldi:** Di base. Poi il collegamento con WCommerce e tutte le cose che dobbiamo comunicare le

**Aurel mrruku:** Sì,

**Sabatino Rinaldi:** riusciamo a reperire in modo rapido, quindi poi magari ci potrebbero essere dei piccoli problemi tecnici, ma Sì,

**Aurel mrruku:** ma sulle mappature poi aggiungiamo, facciamo un arricchiamento del del payload mano che si va avanti.

**Sabatino Rinaldi:** esatto,

**Aurel mrruku:** Sì.

**Sabatino Rinaldi:** chiaro.

**Elena Spini:** Quand'è che torni dalle ferie, Sabatino?

**Sabatino Rinaldi:** Perché vuoi venire con me?

**Elena Spini:** No, torni, sennò ti avrei chiesto quando

**Sabatino Rinaldi:** E allora,

**Elena Spini:** vai.

**Sabatino Rinaldi:** torno operativo il 25, ma non mettermela il 25, mettim almeno il 26,

### **02:08:19**

**Elena Spini:** No,

**Sabatino Rinaldi:** per favore.

**Elena Spini:** certo. Dal 25 che cos'è?

**Sabatino Rinaldi:** 26 è

**Aurel mrruku:** 5 alle 8:00.

**Elena Spini:** 25 martì dal 26 al 29.

**Sabatino Rinaldi:** mercoledì.

**Elena Spini:** Vabbè, forse lo metto.

**Sabatino Rinaldi:** 25. fammi respidare.

**Elena Spini:** Il Sabatino. Aurel, questo è da fissare poi. Right. Antisipei, questo carissimo Anticipi di cui abbiamo parlato e poi dimenticato. Tiscay ec credit safe. Avan detto che ci volevano dei controlli lato eh partita IVA, quando la partita IVA scende da un ordine che arriva da VCmerce. Perché abbiamo detto che tante volte, tipo alle vendite da palco, avete casi in cui scendono questi ordini con le partite IVA farlocche e poi c'è Elisa e Fabrizio che impazziscono.

**Elisa Migliano:** Allora, il tema di anticipi non è legato esclusivamente a Wcommerce,

**Elena Spini:** No.

**Elisa Migliano:** è un discorso generale. E quando il tutor crea un account, ci mette la partita IVA, eccetera eccetera, è un nuovo cliente, nel momento in cui noi dobbiamo noi dobbiamo andare a fatturare,

### **02:10:02**

**Elena Spini:** Ok.

**Elisa Migliano:** quindi ci sarà a quel punto un ordine che è confermato eh o scusate un preventivo che è accettato e si si genererà l'ordine. Noi andiamo a fatturare l'ordine. Prima di fatturare quell'ordine, che cosa succede? Ti vi dico com'è oggi eh prima di fatturare l'ordine c'è un sistema che sostanzialmente va a leggere la partita IVA del cliente di quell'ordine e verifica se ce l'abbiamo già nell'anagrafica su Mexal. Se non ce l'abbiamo, viene fatta una chiamata a questo servizio che è un servizio di business information e vengono recuperati i dati ufficiali del soggetto collegato con la partita IVA, quindi ragione sociale, via, numero, PEC, legale rappresentante, eccetera eccetera eccetera. Questo ci dà la possibilità di avere un'anagrafica clienti corretta al 99,5% diciamo, però è un diciamo un flusso è un tipo di m diciamo di di verifica che viene fatta appunto nel momento in cui eh arriva l'ordine, o meglio, l'ordine deve essere fatturato. Se non ricordo male, Elisa, adesso i tecnicismi non li ricordo tutti. Se non ricordo male, noi cosa facciamo? Mettiamo un ordine attualmente in da fatturare, diciamo, no?

### **02:11:39**

**Elisa Migliano:** Ehm, poi che cosa facciamo? andiamo a fare l'importando facciamo l'import degli ordini su Maxal che gira quella roba perché in realtà oggi Sì. Eh no, adesso ci mettiamo 2 ore. si è visto dire ste robe.

**Elena Spini:** No,

**Elisa Migliano:** Non

**Elena Spini:** eh, lo so, ma però idealmente dove lo mettiamo questo flusso in quello che ci siamo raccontati fino adesso?

**Elisa Migliano:** possiamo

**Elena Spini:** È quello che mi manca da capire, cioè in che momento va chiamato questa

**Elisa Migliano:** è un flusso che deve deve stare nel momento in cui eh ehm io devo

**Elena Spini:** integrazione?

**Elisa Migliano:** fatturare un ordine. Lo possiamo fare anche, cioè ecco ecco qui potrebbe essere una novità rispetto come faccio adesso. Possiamo fare?

**Elena Spini:** Non vedevo l'ora della novità al 6 agosto.

**Elisa Migliano:** No, no, ma perché perché la la possiamo risolvere tutta, diciamo, l'atto sales force, nel senso che nel momento in cui il cliente accetta quel preventivo e si genera l'ordine, io quell'ordine lì sono sicuro che lo devo fatturare. Quindi, nel momento in cui si genera l'ordine, è lì che si può fare la chiamata verso verso questo servizio e al fine di poter recuperare le informazioni su quella ragione sociale le scriviamo direttamente dentro Sales Force, per cui quando Sales for passa i dati a Max siamo sicuri che i dati sono già puliti,

### **02:13:09**

**Elena Spini:** Questo mi piace molto.

**Elisa Migliano:** capito?

**Elena Spini:** Va bene. Mi turba solo tutto quello che arriva da un e-commerce.

**Elisa Migliano:** Ma vale la stessa cosa. Quello che arriva Wcommerce ci sarà un ordine. Nel momento in cui entra l'ordine si fa la chiamata bla bla uguale.

**Elena Spini:** E se fallisce perché magari dici che non è vera.

**Elisa Migliano:** Ecco, questo capita, nel senso che i clienti, molti alcuni clienti sbagliano digitare la partita IVA. A noi ci arriva una segnalazione attualmente. Attenzione, l'ordine numero non è non è stato non non si è generato perché è sbagliata la partita IVA. Dopo noi in quei casi lì andiamo a coraggiare a mano, cioè lo chiamiamo e gli diciamo bla bla bla bla bla bla e lo correggiamo a mano.

**Elena Spini:** Oddio, che brutto\! Aspetta, fammelo scrivere così oppure sistemo. Allora, Aurel, hai sentito?

**Aurel mrruku:** Ho sentito. Non sono molto felice, ma ho

**Elena Spini:** Allaagerazione di un ordine?

**Aurel mrruku:** sentito.

**Elena Spini:** Ehm, chiamata. Eh, ma voi avete, cioè, sapete, non so, dobremo fare una chiamata PI a questo servizio e cioè abbiamo questi

### **02:14:34**

**Elisa Migliano:** Abbiamo tutto.

**Elena Spini:** dati,

**Aurel mrruku:** Praticamente penso che è un servizio a pagamento che ti dispone un

**Elisa Migliano:** Abbiamo tutto.

**Elena Spini:** avete già tutto questo?

**Aurel mrruku:** endp.

**Elena Spini:** Perché lo avete già?

**Elisa Migliano:** Abbi Sì, sì, è già è funzionante,

**Elena Spini:** Perfetto.

**Elisa Migliano:** per fortuna.

**Elena Spini:** Questi riferimenti già ce li potresti già

**Aurel mrruku:** Ah, domanda domanda.

**Elena Spini:** dare?

**Aurel mrruku:** Perché lo volete fare quando si crea l'ordine, non quando si mette la partita IVA sull'account? Yeah.

**Elisa Migliano:** Perché possiamo avere delle situazioni dove e parlo in particolare, e qui Sabatino mi potrà correggere o smentire, parlo in particolare del tour e del food che sono eventi gratuiti, si iscrivono 3000 persone. Se noi eh facciamo le chiamate eh su 3000 partite IVA e magari di quei 3000 comprano in 250 e e spendiamo un sacco di soldi, diciamo, non dico inutilmente, però quindi avevamo scelto questa opzione per per ridurre, diciamo, un minimo i costi legati a questo servizio, almeno così ehm eh tipo l'anno scorso Avevamo

**Aurel mrruku:** Chiarissimo, chiarissimo.

### **02:15:46**

**Elisa Migliano:** 6000 iscritti al food marketing, capito?

**Elena Spini:** อ

**Aurel mrruku:** Ok, ha senso.

**Elisa Migliano:** Quindi

**Aurel mrruku:** Ovviamente poi Elena, dobbiamo anche prevedere un unhappy path di quello che deve succedere. Deve arrivare una mail a un indirizzo che poi devono metterci a disposizione per informare che devono rifare e dobbiamo anche prevedere poi

**Elena Spini:** Eh, esatto.

**Aurel mrruku:** nell'ordine un pulsante in cui si rifà il check o nell'ordine o nell'account. praticamente su un account collegato a un ordine. Ma un'altra cosa, un account si deve anche dire se un account ha fatto una volta un check, non c'è bisogno che lo faccia di nuovo. Quindi non si deve fare ogni volta che si genera l'ordine, si deve fare ogni volta che un account genera la prima volta

**Elisa Migliano:** Sì, noi facciamo così adesso,

**Aurel mrruku:** l'ordine.

**Elisa Migliano:** però Però eh eh facciamo così.

**Elena Spini:** alla prima alla generazione del primo ordine di un account

**Aurel mrruku:** Sì, sì, sì, sì.

**Elena Spini:** sarebbe Esatto.

**Elisa Migliano:** Esatto.

**Aurel mrruku:** E poi si mette un flag sull'account e dice che è stato

### **02:17:00**

**Elisa Migliano:** Sì.

**Aurel mrruku:** consolidato.

**Elisa Migliano:** Poi dopo magari se fosse possibile mettere un bottone dove a richiesta io chiedo un aggiornamento dei dati su quell'account. Va benissimo comunque.

**Aurel mrruku:** Sì, sì, lo mettiamo anche sull'account,

**Elisa Migliano:** Eh sì,

**Aurel mrruku:** però sull'account si deve fare un'azione manuale,

**Elisa Migliano:** sì,

**Aurel mrruku:** diciamo.

**Elisa Migliano:** va bene. Sì,

**Aurel mrruku:** Usiamo la stessa API.

**Elisa Migliano:** sì.

**Aurel mrruku:** Ok, così anche l'anneappy flow praticamente è più facile perché ok, mandiamo una notifica oppure una mail, un indirizzo che ci fornite voi e lui entra sull'account, preme su questo pulsante qua e ha già tutto fatto.

**Elisa Migliano:** Dopo noi su Mexala a livello di anagrafica clienti che cosa facciamo? Normalmente nulla. Andiamo ad aggiungere le condizioni di pagamento, i read, queste cose qua. Magari mettiamo dei classificatori statistici, però eh non facciamo nulla. Quindi diciamo che in questo caso Elisa ribalteremmo la logica. che che però magari può avere più senso fatto

**Elena Spini:** No, non vi ho seguito,

**Elisa Migliano:** così.

### **02:18:03**

**Elena Spini:** ho capito, però penso forse è per voi.

**Elisa Migliano:** Sì, parlavamo, ragionavamo tra di noi.

**Elena Spini:** Ok. Ehm,

**Elisa Migliano:** Sì.

**Elena Spini:** il caso di chiamata che va in errore, insomma, è partita.

**Aurel mrruku:** Mandiamo una mel.

**Elena Spini:** Vi torna la cosa?

**Aurel mrruku:** Mandiamo. Sì,

**Elena Spini:** Mail mail all'amministrazione.

**Aurel mrruku:** mandiamo una med.

**Elisa Migliano:** Sì.

**Elena Spini:** Perfetto.

**Aurel mrruku:** Sì,

**Elena Spini:** Qua in un qualche modo lo devo mettere. Ci pensiamo.

**Aurel mrruku:** poi ci dobbiamo pensare un po' anche il template.

**Elena Spini:** Va bene.

**Aurel mrruku:** Ok,

**Elena Spini:** Oddio.

**Elisa Migliano:** Dopo magari quando arriverete qui, adesso ve lo dico così magari ve lo ci ricordiamo tutti,

**Elena Spini:** Eh

**Elisa Migliano:** quando arriveremo a questo punto abbiamo un ragazzo, Andrea Parmegiani che dopo qui ci può dare una mano lui nel caso in cui abbiamo

**Aurel mrruku:** perfetto.

**Elisa Migliano:** bisogno.

**Aurel mrruku:** Ah, possiamo già iniziare a fare un incontro con lui, così mi metto a mettere in

**Elena Spini:** esatto. Sarà sarebbe il quarto meeting che devo mandarvi.

### **02:19:07**

**Aurel mrruku:** piedi,

**Elena Spini:** Chi è lui?

**Elisa Migliano:** Che lui è via per due settimane comunque. Eh, ci dobbiamo aggiornare la terza settimana di agosto.

**Aurel mrruku:** ma anch'io.

**Elisa Migliano:** Perfetto.

**Aurel mrruku:** Quindi rientro il

**Elisa Migliano:** Lui

**Aurel mrruku:** 24.

**Elisa Migliano:** anche

**Elena Spini:** E questo è Aurel. E come si chiama?

**Elisa Migliano:** Andrea Carmeggiani

**Elena Spini:** Mi mandi il la

**Aurel mrruku:** Ho.

**Elisa Migliano:** te lo facciamo mandare da Sabatino,

**Elena Spini:** mail?

**Elisa Migliano:** tanto ti devi mandare anche quello di Decca. Mettete anche Elisa in questa call. Mettete anche Elisa e me dopo io se c se ce la se posso vengo sennò niente,

**Sabatino Rinaldi:** E il problema,

**Elisa Migliano:** senò me la Ah,

**Sabatino Rinaldi:** qual è la mail di Andrea? Che lui è la software, non la so.

**Elisa Migliano:** è uguale a punto

**Sabatino Rinaldi:** Andrea.

**Elisa Migliano:** pro

**Sabatino Rinaldi:** P@penissimo. Pro, giusto?

**Elisa Migliano:** Sì,

**Elena Spini:** Anche questo dal 26 al 29, giusto?

**Elisa Migliano:** esatto.

**Elena Spini:** Aspetto.

### **02:20:12**

**Elisa Migliano:** Так.

**Elena Spini:** Questo invece è no Satispay. Anticipay anticipi. Perfetto. Ok. confermato alla

**Sabatino Rinaldi:** Guardo. Yes.

**Elena Spini:** creazione ordine.

**Sabatino Rinaldi:** Tanto mi fac.

**Elena Spini:** Poi Marco ce l'abbiamo? Esiste, ci sente?

**Marco:** Son qui, son qui. Mi son fatto un termos di caffè. Mi son fatto nel

**Elena Spini:** Grandissimo.

**Marco:** frattempo.

**Elena Spini:** Allora, una cosa veloce, tema, eh torniamo a lead. Sì, code. Ok, perfetto. Eh, siamo qua, quindi siamo nei nostri lead. Abbiamo detto che verranno assegnati a delle code. Ma c'è una particolare specifica su queste code?

**Marco:** Eh no, perché in questo momento noi tecnic eh cioè noi dobbiamo tenerli parcheggiati e

**Elena Spini:** È solo una coda.

**Marco:** poi decidere come andare a gestire questa cosa qua, Come avevi detto tu, è uno,

**Elena Spini:** Sì.

**Marco:** diciamo, ehm è un contenitore, no, dove possono essere

**Elena Spini:** Esatto. No, ma sì, aspetta, scusami, spiego meglio.

**Marco:** parcheggiati.

**Elena Spini:** Cioè, non lo so, magari eh code per che si differenziano per, non lo so, regione, sparo, code che si differenziano per boh,

### **02:21:44**

**Marco:** richiesta servizio,

**Elena Spini:** richiesta servizio.

**Marco:** tipologia servizio.

**Elena Spini:** Esatto. Dipende da che cosa da cosa da quali informazioni ho a livello di

**Marco:** Certo.

**Elena Spini:** lead.

**Marco:** Sì, esatto. Cioè, nel senso che queste valutazioni qua abbiamo incominciato comunque a farle, ma ad oggi,

**Elena Spini:** Non ci sono.

**Marco:** visto che il sistema non ce lo permette, in realtà noi oggi tutti i lead che entrano vengono ripartiti secondo una logica di ZO che ne dà uno per ogni per ogni tutto. In realtà questa cosa qui non va più bene, quindi dovremmo capire secondo quale logica andarli a distribuire e non so se è possibile in determinati periodi dove magari anche il flusso di lavoro dei tutor è diverso, eh magari in determinato periodo poter dare più cose a qualcuno piuttosto che a qualcun altro, eh non so, in automatico non ho idea di come funziona, di come può funzionare.

**Elena Spini:** No, allora eh ti dico eh cioè sicuramente si possono differenziare in base alle informazioni che noi abbiamo.

**Marco:** Ok.

**Elena Spini:** Quindi se io ho in base a servizi, come hai detto tu prima, se io ho questa informazione a livello di servizi, io posso avere il servizio 1, la coda 1 e oppure coda 2, servizio 2. Perfetto. Una volta che scende questo record io assegno.

### **02:23:03**

**Elena Spini:** Poi,

**Marco:** Ok.

**Elena Spini:** siccome non c'è una una logica così a più è carico meno scarico, ma non perché se il source non lo fa, sale il source lo farebbe anche e si potrebbero fare anche delle cose, è più una cosa a livello di case in realtà che non di lead, però vabbè da capire. Ma comunque non voi non avete queste queste licenze per questa gestione tipo di assegnazione automatica in base ai cari.

**Marco:** No, no, ma io non volevo No,

**Elena Spini:** Quindi ti

**Marco:** quello lì era comunque sempre figlio di di una considerazione mia di reparto

**Elena Spini:** dico,

**Marco:** Perché comunque ho il polso della situazione e capisco se in un certo momento

**Elena Spini:** no, esatto,

**Marco:** un Esatto.

**Elena Spini:** dipende magari dal dal momento, da da tante cose. quello che potresti fare è prendere tutti magari i

**Marco:** Ok,

**Elena Spini:** lead, le le cose che sono state assegnate a una coda o a un un utente e trasferirle massivamente. con due click, cioè seleziono tutti i link che voglio e trasferisco tutto a, non so, l'utente che è scarico.

**Marco:** perfetto.

**Elena Spini:** Questo sì,

**Marco:** Oppure posso decidere che tutto quello che arriva da determinate zone in termini di provincia e quant'altro vanno in automatico ad un tutor,

### **02:24:17**

**Elena Spini:** anche.

**Marco:** ipotizzo.

**Elena Spini:** Sì,

**Marco:** Ok.

**Elena Spini:** quelle sono regole.

**Marco:** Ok, va bene, va bene. Direi che ci siamo, insomma. Paola.

**Elena Spini:** Te lo lascio in corso lato pienissimo. Quando tu hai in corso lato facciamo Marco,

**Marco:** Oh.

**Elena Spini:** così sappiamo. Eh, quando hai l'idea di cosa effettivamente, magari anche quando inizieremo a vedere la piattaforma reale,

**Marco:** Ok,

**Elena Spini:** eh ci dai l'effettivamente il desiderata.

**Marco:** va benissimo, perfetto.

**Elena Spini:** Perfetto. Poi template email,

**Marco:** Что?

**Elena Spini:** invio link, l'abbiamo detto prima, finché non ne abbiamo un template, dato che è una cosa nuova anche per voi, mandiamo un link, faremo un esempio di email normale e e quando sarà pronta la la sistemiamo. Pianificazione fase due era quella che ti dicevo. Sabatino, hai detto che non ci sono problemi. Se vi aspettate una m eh stima lato nostro di cosa effettivamente voglia dire fase due, noi al ritorno dalle ferie ci muoviamo con questa stima, però non è incluso nel piano, nel progetto perché appunto erano cose esterne.

**Sabatino Rinaldi:** Ehm,

**Elena Spini:** Ne.

**Sabatino Rinaldi:** la cosa che mi interessa di più in realtà Tutto questo è pienissimo pro, però che Daniela non sapeva questa informazione qui, quindi tocca rifare un altro giro, ma questo giro me lo faccio dopo le ferie.

### **02:25:57**

**Elena Spini:** Sabatino. Per ora io faccio finta che non esistono ancora questa parte. Poi eh input attesi dal cliente e qua sono punti per Fabrizio. Magari Fabrizio eh se puoi quando vuoi. Queste sono input che ci aspettavamo, che abbiamo detto nel corso degli 800 meeting che abbiamo fatti. fatto. Sono i prezzi reali del catalogo, se senti. Perfetto. Almeno anche una parte,

**Elisa Migliano:** Sì.

**Elena Spini:** cioè non lo so. Mh. Perché per ora stiamo usando prezzi inventati o no? Prezzi, boh, forse che avevamo preso dalla tipologia di vendita Aurel, mi sto ricordando. Boh, vabbè.

**Elisa Migliano:** Quindi Sì.

**Elena Spini:** Eh, eh, no,

**Aurel mrruku:** Anch'io.

**Elena Spini:** infatti. Vabbè, non mi ricordo da dove li avevan presi, ma vabbè, poco importante. Abbiamo messo qualcosa. lista definitiva di

**Elisa Migliano:** Ok,

**Elena Spini:** 720.

**Aurel mrruku:** ci avevi detto che ci facevi vedere eh praticamente tutte le tipologie di eventi.

**Elisa Migliano:** ma lista definitiva cosa vuol dire? Che domani non ne possiamo aggiungere uno nuovo o no?

### **02:27:15**

**Aurel mrruku:** No, no, no, no.

**Elisa Migliano:** Ok.

**Elena Spini:** No,

**Aurel mrruku:** Era giusto per fare noi degli esempi per capire un po' quando facciamo le demo eccetera,

**Elisa Migliano:** Sì, sì.

**Aurel mrruku:** di capire cosa cosa selezionare.

**Elisa Migliano:** Ok.

**Elena Spini:** lista di esempio dei 720, perché boh, a quanto pare ne hai citati sette per quello.

**Elisa Migliano:** Allora, io quindi lista articoli significativi

**Elena Spini:** Arriv.

**Elisa Migliano:** e lista eventi. A posto. Domani vi faccio questo assieme alla

**Elena Spini:** Wow,

**Elisa Migliano:** mappatura.

**Elena Spini:** perfetto. Codice articolo solo bundle di esempio anche c'era. Era quello che hai detto dopo.

**Elisa Migliano:** Sì.

**Elena Spini:** Perfetto. Ottimo. Review dell'elenco dei 100 form di marketing.

**Elisa Migliano:** Ah.

**Elena Spini:** Vi interessa poco? migrazione ne abbiamo parlato perché abbiam detto che dovevate fare la bonifica. Noi faremo effettivamente la migrazione quando abbiamo campi, mapping e tutto. E questo è dipendente anche da 11 in realtà, da 12,

**Elisa Migliano:** Sì.

**Elena Spini:** scusa. Perfetto.

### **02:28:18**

**Elena Spini:** Ehm, e questi sono quelli che abbiamo aggiunto adesso. Wow\! Fine.

**Sabatino Rinaldi:** Quindi bene. Yeah.

**Marco:** Nessuno risponde.

**Elena Spini:** Ti ho traumatizzato abbastanza.

**Marco:** Elisa, Alisa, ti ho detto che alle 5:00 non avevamo

**Elisa Migliano:** Ma guarda Да.

**Marco:** finito.

**Elena Spini:** Cioè io non voglio mettere i meeting che sono di 3 ore perché sennò si spaventano le

**Sabatino Rinaldi:** Eh, Marco,

**Elena Spini:** persone, però di fondo so quello che ci

**Sabatino Rinaldi:** Marco, riesci ad avvisare tu,

**Elena Spini:** serve.

**Sabatino Rinaldi:** Rebecca, sugli appuntamenti che avrà la la Giorni. Ok, grazie. Yeah.

**Marco:** ci ci mandi tu un recup del anche degli appuntamenti,

**Elena Spini:** Consig Sì.

**Marco:** Elena,

**Elena Spini:** Preferite che li metto io o volete delle proposte?

**Sabatino Rinaldi:** No,

**Marco:** ma per me puoi anche fissarli.

**Sabatino Rinaldi:** a questo punto mettili te, ci organizziamo.

**Elena Spini:** Perfetto,

**Marco:** Sì,

**Sabatino Rinaldi:** Qu?

**Marco:** tanto la Rebecca sarà in ufficio, quindi poi così intanto glielo comunico,

**Elena Spini:** perfetto.

**Marco:** ha tutto il tempo di organizzarsi perché lei non c'è neanche domani, quindi già glielo

**Elisa Migliano:** Чи M.

**Marco:** comunico.

**Elena Spini:** Considera che io tra oggi barra domani mando i meeting che

**Marco:** Perfetto. Io intanto le anticipo che sarà impegnata in questa cosa la prossima settimana e poi che gli manderò appena

**Elena Spini:** sennò

**Marco:** arrivano le date.

**Elena Spini:** Esatto. Ottimo.

**Marco:** In che senso?

**Elena Spini:** l' traumatizzato anche lui.

**Aurel mrruku:** Ah, Нетте.

**Marco:** Non aggiungere niente a questo punto.

**Aurel mrruku:** E

**Elena Spini:** Va bene così.

**Marco:** Non si sa mai cosa può cosa può succedere

**Elena Spini:** Salutiamoci e sorridenti quei preferi e è stato bello così.

**Aurel mrruku:** infatti.

**Marco:** dopo.

**Elena Spini:** Sarà un problema al ritorno. Aurel,

**Marco:** Bene,

**Elena Spini:** dai.

**Marco:** grande energia.

**Aurel mrruku:** Va bene. Ciao.

**Marco:** Ok.

**Aurel mrruku:** Ciao a tutti.

**Elena Spini:** Ciao a tutti e buon riposo a chi fermarsi.

**Marco:** Ciao a tutti, buone ferie.

**Aurel mrruku:** Ciao.

**Sabatino Rinaldi:** Ciao ciao a tutti.

**Marco:** Grazie.

**Elisa Migliano:** Ciao. Ciao.

**Elena Spini:** Ciao.

**Elisa Migliano:** Bye bye.

**Sabatino Rinaldi:** E

**Marco:** เอ

### **Trascrizione terminata dopo 02:30:30**

*Questa trascrizione modificabile è stata generata dal computer e potrebbe contenere errori. È possibile anche modificare manualmente il testo dopo la creaz
