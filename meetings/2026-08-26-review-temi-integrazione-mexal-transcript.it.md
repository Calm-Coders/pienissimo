# **ð Note**  

 ago 26, 2026

## **\[ROMI-PIENISSIMO\] - Review Temi Integrazione Mexal**

invitato <fabrizio.p@pienissimo.com> <amministrazione@pienissimo.com> [Elena Spini](mailto:e.spini@romicompany.com) [Aurel mrruku](mailto:a.mrruku@romicompany.com) [Andrea Di Cicco](mailto:a.dicicco@romicompany.com) <sabatino.r@pienissimo.com>

Allegati [\[ROMI-PIENISSIMO\] - Review Temi Integrazione Mexal](https://calendar.google.com/calendar/event?eid=MjBsbzZtN24xZmZkNGlxaGVjNmZwbmRrMmogZS5zcGluaUByb21pY29tcGFueS5jb20)

Record delle riunioni [Trascrizione](https://docs.google.com/document/d/1f_8YVWSssMOcmk9XRmI2en0aqUGFRG2Bk1vnLItt3zU/edit?usp=drive_web&tab=t.bgko058roasn) [Registrazione](https://drive.google.com/file/d/1UUpEzSVzPVlXBXrN7HPGvXYp-2NBEfUG/view?usp=drive_web) 

  
  

### **Riepilogo**

La riunione ha riguardato l'integrazione di Mexal con Sales Force per la gestione di prodotti, campagne e ordini.  
  
**Ottimizzazione anagrafica prodotti**  
L'uso di campi tecnici permette di disabilitare prodotti obsoleti e gestire la generazione dei biglietti tramite integrazione. La disattivazione mantiene comunque accessibile lo storico delle fatture passate.  
  
**Configurazione campagne ed eventi**  
Viene implementata una tabella aggiuntiva su Sales Force per associare i prodotti alle edizioni tramite intervalli di date. Questa struttura risolve la gestione dei bundle e l'assegnazione automatica dei biglietti.  
  
**Test integrazione ordini fiscali**  
I test di creazione ordini confermano la necessità di gestire la residenza fiscale per le normative di San Marino. La trasformazione in fattura rimane pilotata esternamente dal sistema principale durante la fase iniziale.

  
  

### **Decisioni**

## **Da approfondire**

  - **Logica associazione ordini e campagne** La strategia di mappatura automatica delle righe d'ordine alle campagne figlie basata sui range di date richiede un ulteriore approfondimento con casi d'uso concreti prima di essere implementata.

  

## **Concordato**

  - **Utilizzo campo annullamento su Mexal** Il campo 'Gest. annullato' di Mexal verrà utilizzato per disabilitare automaticamente i prodotti in Salesforce, rendendoli non selezionabili durante le nuove vendite pur mantenendo la visibilità dello storico.
  - **Utilizzo categoria statistica per eventi** Il campo 'categoria statistica' di Mexal verrà utilizzato per raggruppare i prodotti associati ai vari eventi in modo coerente.
  - **Data ordine basata su evento** La data dell'ordine sarà gestita manualmente in base alla data dell'evento specifico per supportare la logica di disattivazione post-evento.
  - **Gestione bundle edizioni multiple esclusa** La gestione di un unico ordine per bundle che coprono edizioni multiple non sarà implementata nel sistema.
  - **Collegamento biglietti a campagne future** I biglietti riassegnati manualmente devono essere collegati alla campagna figlia dell'evento successivo per mantenere attiva l'automazione dei reminder.
  - **Codici prodotto distinti per bundle** La distinzione tra biglietti standard e biglietti validi per i bundle verrà gestita tramite la creazione di codici prodotto separati.
  - **Fatturazione gestita tramite Mexal** Il processo di fatturazione sarà pilotato esclusivamente da Mexal, escludendo automatismi da SalesForce per la fase corrente.

  

Abbiamo **aggiornato la sezione Decisioni** in base al tuo feedback.

Facci sapere cosa ne pensi: [Utili](https://google.qualtrics.com/jfe/form/SV_5bXzKQfylMIhSXc?isHelpful=True&entryPoint=decisions&confid=fKExfEJXtkgAXE_r5tMVDxIUOBEBMgUIigIgABgDCA&isGoogler=False) o [Non utile](https://google.qualtrics.com/jfe/form/SV_5bXzKQfylMIhSXc?isHelpful=False&entryPoint=decisions&confid=fKExfEJXtkgAXE_r5tMVDxIUOBEBMgUIigIgABgDCA&isGoogler=False)

  
  

### **Passaggi successivi**

  - \[Fabrizio Paganelli\] Revisione anagrafica articoli: Revisionare l'anagrafica articoli in base alle nuove regole definite e condividere l'elenco completo revisionato con il team.
  - \[Andrea Di Cicco\] Mappatura flag annullato: Mappare il campo annullato presente in Mexal con il flag disattivo o inattivo su Salesforce per gestire la visibilità dei prodotti.
  - \[Il gruppo\] Pianificazione incontro logiche: Organizzare un incontro per definire con esempi concreti la logica di associazione delle righe ordine alle campagne e alle edizioni.
  - \[Fabrizio Paganelli\] Configurare prodotti: Configurare due prodotti distinti su Mexal e Salesforce per gestire le casistiche di visibilità nei bundle e generazione biglietti, inserendo i flag necessari come visibile in bundle e generazione biglietto.
  - \[Fabrizio Paganelli, Andrea Di Cicco, Elena Spini, Aurel mrruku, Elisa Migliano\] Mappare anagrafica clienti: Programmare una riunione con il team per analizzare e mappare nel dettaglio i campi necessari dell'anagrafica clienti, inclusi i dati per provvigioni e condizioni dei documenti.
  - \[Fabrizio Paganelli\] Finalizzare anagrafica articoli: Finalizzare il lavoro di configurazione sull'anagrafica articoli entro la prossima settimana.

  
  

### **Dettagli**

  - **Revisione dell'anagrafica articoli su Mexal**: Fabrizio Paganelli comunica l'intenzione di discutere con la direzione per revisionare l'anagrafica articoli di Mexal, prevedendo la chiusura di tutti i codici prodotto attuali e la creazione di nuovi codici basati su regole condivise, anche in previsione di una revisione dei listini prezzi. Vengono esaminati i campi disponibili per la classificazione dei prodotti ([00:02:22](https://docs.google.com/document/d/1f_8YVWSssMOcmk9XRmI2en0aqUGFRG2Bk1vnLItt3zU/edit?ouid=100243958128504204165#heading=h.lclfo0ldx4ju)).
  - **Utilizzo del campo natura per la gestione dei biglietti**: Andrea Di Cicco verifica tramite API il campo \`COD\_Natura\` in Mexal. Fabrizio Paganelli propone di utilizzare tale campo per indicare se un prodotto genera o meno un biglietto ([00:06:07](https://docs.google.com/document/d/1f_8YVWSssMOcmk9XRmI2en0aqUGFRG2Bk1vnLItt3zU/edit?ouid=100243958128504204165#heading=h.a8stis1ym7rm)). Tramite un test effettuato con il codice articolo \`CS\_00154\`, viene confermato che il campo è utilizzabile e collegato a una tabella di base gestita in Mexal ([00:09:23](https://docs.google.com/document/d/1f_8YVWSssMOcmk9XRmI2en0aqUGFRG2Bk1vnLItt3zU/edit?ouid=100243958128504204165#heading=h.yajtgv51zetp)). I valori definiti saranno trasmessi a Sales Force tramite integrazione ([00:12:58](https://docs.google.com/document/d/1f_8YVWSssMOcmk9XRmI2en0aqUGFRG2Bk1vnLItt3zU/edit?ouid=100243958128504204165#heading=h.g0jnx8ux3g8t)).
  - **Disattivazione dei prodotti tramite il flag annullato**: Per evitare che i tutor utilizzino codici articolo obsoleti tra i circa 1000 presenti, viene esaminata la gestione dello stato dei prodotti in Mexal ([00:14:30](https://docs.google.com/document/d/1f_8YVWSssMOcmk9XRmI2en0aqUGFRG2Bk1vnLItt3zU/edit?ouid=100243958128504204165#heading=h.h9rfe04pkfve)). Fabrizio Paganelli individua il campo tecnico \`Gest. annullato\` (valore \`n\` per attivo, \`S\` per inattivo) ([00:19:09](https://docs.google.com/document/d/1f_8YVWSssMOcmk9XRmI2en0aqUGFRG2Bk1vnLItt3zU/edit?ouid=100243958128504204165#heading=h.jufk57730qvi)). Dopo aver effettuato verifiche su fatture esistenti (come quella emessa per il cliente "la terrazza" con codice articolo \`CS58\`), si stabilisce che l'annullamento non compromette la visualizzazione delle fatture passate e permette di disabilitare il prodotto su Sales Force impedendone la selezione per nuove vendite, pur mantenendo la possibilità di consultare lo storico per la reportistica ([00:21:39](https://docs.google.com/document/d/1f_8YVWSssMOcmk9XRmI2en0aqUGFRG2Bk1vnLItt3zU/edit?ouid=100243958128504204165#heading=h.m73w8p2eix8p)).
  - **Classificazione degli eventi tramite la categoria statistica**: Fabrizio Paganelli propone di sfruttare il campo della "categoria statistica" (suddiviso nei campi tecnici relativi a sigla e numero della categoria) per identificare l'evento di appartenenza dei prodotti, come per esempio per i camerieri, il Food Marketing Festival o l'EP Team ([00:29:46](https://docs.google.com/document/d/1f_8YVWSssMOcmk9XRmI2en0aqUGFRG2Bk1vnLItt3zU/edit?ouid=100243958128504204165#heading=h.yca7qrq0ffhe)). Andrea Di Cicco verifica la struttura dei dati tramite API, evidenziando che tale informazione collega il prodotto allo specifico evento di riferimento ([00:31:43](https://docs.google.com/document/d/1f_8YVWSssMOcmk9XRmI2en0aqUGFRG2Bk1vnLItt3zU/edit?ouid=100243958128504204165#heading=h.n1opmxu0otaz)).
  - **Gestione delle campagne e associazione delle edizioni tramite intervalli di date**: Aurel mrruku, Elena Spini, Fabrizio Paganelli e Andrea Di Cicco affrontano la complessità di collegare i prodotti alle campagne padre e figlia (edizioni) su Sales Force, specialmente in presenza di bundle con articoli appartenenti a edizioni differenti ([00:33:19](https://docs.google.com/document/d/1f_8YVWSssMOcmk9XRmI2en0aqUGFRG2Bk1vnLItt3zU/edit?ouid=100243958128504204165#heading=h.5qc7hq9xqcli)) ([00:43:06](https://docs.google.com/document/d/1f_8YVWSssMOcmk9XRmI2en0aqUGFRG2Bk1vnLItt3zU/edit?ouid=100243958128504204165#heading=h.fl3kp5i9xy82)). Viene concordato di implementare una tabella aggiuntiva su Sales Force, gestita manualmente, che associ a ciascun codice articolo e intervallo di date (data inizio e data fine) l'edizione specifica di riferimento, consentendo al sistema di assegnare correttamente ogni riga d'ordine all'edizione corrispondente in base alla data dell'ordine ([00:40:00](https://docs.google.com/document/d/1f_8YVWSssMOcmk9XRmI2en0aqUGFRG2Bk1vnLItt3zU/edit?ouid=100243958128504204165#heading=h.6uq7qtobyj4z)) ([00:44:30](https://docs.google.com/document/d/1f_8YVWSssMOcmk9XRmI2en0aqUGFRG2Bk1vnLItt3zU/edit?ouid=100243958128504204165#heading=h.j1xj922j1lvv)).
  - **Configurazione delle date di campagna e gestione dei biglietti**: Durante la configurazione delle campagne, Aurel mrruku ed Elena Spini discutono sul significato delle date "da - a", chiarendo che la data finale rappresenta la fine della campagna figlia, mentre la data dell'evento (inserita manualmente nella colonna G) serve a gestire la logica di disattivazione per i partecipanti non presentati ([00:59:35](https://docs.google.com/document/d/1f_8YVWSssMOcmk9XRmI2en0aqUGFRG2Bk1vnLItt3zU/edit?ouid=100243958128504204165#heading=h.7kmmo53n1pkn)). Andrea Di Cicco solleva una problematica riguardo alla gestione futura dei bundle pluriennali, ma Fabrizio Paganelli precisa che tale modalità non viene utilizzata ([01:00:31](https://docs.google.com/document/d/1f_8YVWSssMOcmk9XRmI2en0aqUGFRG2Bk1vnLItt3zU/edit?ouid=100243958128504204165#heading=h.ppznd8zpey2)). Per i clienti che non si presentano all'evento, Fabrizio Paganelli spiega che viene effettuata una gestione manuale per riassegnare un biglietto omaggio per l'edizione successiva. Aurel mrruku sottolinea la necessità di collegare manualmente questo asset alla campagna figlia successiva per attivare correttamente l'automatismo dei promemoria, trovando l'accordo di Elena Spini prima che quest'ultima lasci la riunione ([01:01:37](https://docs.google.com/document/d/1f_8YVWSssMOcmk9XRmI2en0aqUGFRG2Bk1vnLItt3zU/edit?ouid=100243958128504204165#heading=h.1hzqv7lce0ov)).
  - **Esecuzione di test in produzione e invio degli ID cliente**: Andrea Di Cicco comunica l'intenzione di effettuare dei test direttamente nell'ambiente di produzione inviando gli ID dei clienti creati per verificare la correttezza dei campi senza compromettere il sistema ([01:02:49](https://docs.google.com/document/d/1f_8YVWSssMOcmk9XRmI2en0aqUGFRG2Bk1vnLItt3zU/edit?ouid=100243958128504204165#heading=h.ve6lj85p687l)). Poiché Fabrizio Paganelli si trova fuori ufficio nei giorni seguenti, viene concordato di inviare le segnalazioni sia a Fabrizio Paganelli sia all'indirizzo di amministrazione monitorato da Elisa Migliano, oppure di effettuare i controlli immediatamente dopo la riunione ([01:04:01](https://docs.google.com/document/d/1f_8YVWSssMOcmk9XRmI2en0aqUGFRG2Bk1vnLItt3zU/edit?ouid=100243958128504204165#heading=h.53aj3walwweo)).
  - **Gestione dell'anagrafica articoli e codici prodotto per i bundle**: Fabrizio Paganelli evidenzia la necessità di gestire nell'anagrafica articoli di Salesforce alcuni campi aggiuntivi non presenti in Mexal, nello specifico il flag di visibilità esclusiva nei bundle e la tipologia di biglietto ([01:05:06](https://docs.google.com/document/d/1f_8YVWSssMOcmk9XRmI2en0aqUGFRG2Bk1vnLItt3zU/edit?ouid=100243958128504204165#heading=h.qlmzu81bll61)) ([01:07:38](https://docs.google.com/document/d/1f_8YVWSssMOcmk9XRmI2en0aqUGFRG2Bk1vnLItt3zU/edit?ouid=100243958128504204165#heading=h.grafuhamy7nz)). Aurel mrruku spiega che per gestire correttamente i prodotti che generano o meno un biglietto e la visibilità nei bundle, è necessario creare codici prodotto distinti da sincronizzare da Mexal a Salesforce, ipotizzando inizialmente una combinazione numerica di quattro valori ([01:06:23](https://docs.google.com/document/d/1f_8YVWSssMOcmk9XRmI2en0aqUGFRG2Bk1vnLItt3zU/edit?ouid=100243958128504204165#heading=h.k70612v8qaz3)) ([01:09:16](https://docs.google.com/document/d/1f_8YVWSssMOcmk9XRmI2en0aqUGFRG2Bk1vnLItt3zU/edit?ouid=100243958128504204165#heading=h.aic6rt3ayr1u)). Dopo vari confronti sulle possibili combinazioni e sull'uso del gruppo merceologico per le tipologie di biglietto (Executive, Gold e Diamond), Fabrizio Paganelli decide di effettuare dei test con nuovi codici articolo e di completare il lavoro la settimana successiva ([01:11:05](https://docs.google.com/document/d/1f_8YVWSssMOcmk9XRmI2en0aqUGFRG2Bk1vnLItt3zU/edit?ouid=100243958128504204165#heading=h.3v759cw7fbe5)).
  - **Test di creazione dell'anagrafica clienti e residenza fiscale**: Andrea Di Cicco condivide lo schermo per testare la creazione di un'anagrafica cliente, riscontrando inizialmente un errore sul campo del tipo di nazionalità. Fabrizio Paganelli spiega che tale campo corrisponde alla residenza fiscale in Mexal ed è fondamentale per la normativa di San Marino, dovendo distinguere tra Italia, San Marino, Città del Vaticano, Unione Europea ed extra Unione Europea ai fini della trasmissione delle fatture all'ufficio tributario ([01:14:56](https://docs.google.com/document/d/1f_8YVWSssMOcmk9XRmI2en0aqUGFRG2Bk1vnLItt3zU/edit?ouid=100243958128504204165#heading=h.jb4rccbkie5)). Dopo aver impostato il codice listino su uno e risolto i campi obbligatori della valuta, Andrea Di Cicco crea con successo il codice cliente \`501.08721\` intestato a Test Roni ([01:17:06](https://docs.google.com/document/d/1f_8YVWSssMOcmk9XRmI2en0aqUGFRG2Bk1vnLItt3zU/edit?ouid=100243958128504204165#heading=h.op9d6bjj065i)).
  - **Creazione degli ordini di test e gestione della fatturazione**: Andrea Di Cicco procede con la creazione di un ordine di test (\`OC11\`) sulla serie 10 per verificare la struttura dei dati e la gestione delle righe per i bundle ([01:20:22](https://docs.google.com/document/d/1f_8YVWSssMOcmk9XRmI2en0aqUGFRG2Bk1vnLItt3zU/edit?ouid=100243958128504204165#heading=h.4yxzrmhg6afz)). Notando che l'ordine appare in stato "sospeso" sullo schermo di Fabrizio Paganelli, quest'ultimo spiega che la trasformazione in fattura verrà pilotata direttamente da Mexal per i primi sei mesi, escludendo per il momento automatismi complessi via codice JSON ([01:21:40](https://docs.google.com/document/d/1f_8YVWSssMOcmk9XRmI2en0aqUGFRG2Bk1vnLItt3zU/edit?ouid=100243958128504204165#heading=h.osqm0tb9pvz)). Infine, Fabrizio Paganelli richiede una riunione dedicata con Andrea Di Cicco, Aurel mrruku ed Elisa Migliano per analizzare nel dettaglio ulteriori campi dell'anagrafica, come la categoria provvigioni e le condizioni documenti di magazzino, indispensabili per evitare blocchi fiscali prima dell'operatività a regime ([01:18:36](https://docs.google.com/document/d/1f_8YVWSssMOcmk9XRmI2en0aqUGFRG2Bk1vnLItt3zU/edit?ouid=100243958128504204165#heading=h.6r8mr373pysg)) ([01:22:42](https://docs.google.com/document/d/1f_8YVWSssMOcmk9XRmI2en0aqUGFRG2Bk1vnLItt3zU/edit?ouid=100243958128504204165#heading=h.baav1nx3phaf)).

  
  

*Dovresti rivedere le note di Gemini per assicurarti che siano accurate.* [*Ricevi suggerimenti e scopri come Gemini prende appunti*](https://support.google.com/meet/answer/14754931)

*Qual è la qualità di* ***queste note specifiche?*** [*Rispondi a un breve sondaggio*](https://google.qualtrics.com/jfe/form/SV_5bXzKQfylMIhSXc?confid=fKExfEJXtkgAXE_r5tMVDxIUOBEBMgUIigIgABgDCA&detailLevel=standard&hasImages=False&entryPoint=footerMain&isGoogler=False)*? Facci sapere cosa ne pensi e quanto le note siano state utili per le tue esigenze.****  
***

# **ð Trascrizione***  
*

 ago 26, 2026

## **\[ROMI-PIENISSIMO\] - Review Temi Integrazione Mexal - Trascrizione**

### **00:01:03**

  

**Elisa Migliano:** Ciao Andrea,

**Andrea Di Cicco:** Ciao, come va?

**Elisa Migliano:** tutto bene a te?

**Andrea Di Cicco:** Bene, bene.

**Elisa Migliano:** Ferie fatte finita?

**Andrea Di Cicco:** Purtroppo sì. Tu

**Elisa Migliano:** Sì, sì, fatte, fatte. Siamo resettati.

**Andrea Di Cicco:** eh non sono mai abbastanza.

**Elisa Migliano:** Non so, eh, hai ragione.

**Andrea Di Cicco:** Ciao

**Elisa Migliano:** Ciao Fabri.

**Andrea Di Cicco:** Fabrizio.

**Elisa Migliano:** Ciao Elena.

**Elena Spini:** Ciao a tutti, scusate il

**Fabrizio Paganelli:** Ciao a

**Elena Spini:** ritardo.

**Andrea Di Cicco:** Ciao.

**Elisa Migliano:** Ciao.

**Fabrizio Paganelli:** tutti.

**Elena Spini:** Mi sentite? Scusate.

**Elisa Migliano:** Sì, sì.

**Aurel mrruku:** Buongiorno.

**Andrea Di Cicco:** Yes.

**Elisa Migliano:** Buongiorno.

**Fabrizio Paganelli:** Ciao. Ciao a tutti.

**Elena Spini:** Ciao a tutti, come

**Fabrizio Paganelli:** Bene.

**Elena Spini:** va? Ben ritrovati.

**Fabrizio Paganelli:** Eh,

**Andrea Di Cicco:** นะ

**Elena Spini:** Allora, focus di oggi è il nostro caro amico Mexal. Faccio la partire la registrazione come al solito. E so che Fabrizio aveva alcuni dubbi eccetera di cui voleva parlare con con il buon Andrea.

  
  

### **00:02:22**

  

**Andrea Di Cicco:** Угуm.

**Elena Spini:** Ja.

**Fabrizio Paganelli:** Sì, io allora avevo questa intenzione qua. Lunedì volevo parlare con la direzione perché vorrei sottoporg eh revisione dell'anagrafica articoli che abbiamo attualmente. Diciamo che a loro avevo già anticipato la cosa che io praticamente vorrei chiudere tutti i codici prodotto che abbiamo adesso e crearni e crearne di nuovi in in base alle, diciamo, alle regole che in qualche modo ci siamo dati fino ad oggi tra di noi. Però, appunto, volevo condividerla questa cosa, anche perché ehm è probabile che ci sia l'intenzione di rivedere un attimo i listini, quindi cambiare, diciamo, i i prezzi i prezzi di listino. Ehm, allora io mi ero segnato nelle volte scorse che ehm che praticamente, se non ricordo male, l'anagrafica articoli nasce solo da Mexal e che e che diciamo vi dobbiamo passare alcune informazioni tipo genera biglietto sì o no, visibile se non i bundle, sì o no, l'evento, l'edizione, il tipo biglietto, l'anno accademico, eccetera eccetera eccetera. No, l'anno accademico no. l'anno accademico avevamo detto di no perché deve essere viene derivato in base alla data dell'ordine.

  
  

### **00:04:03**

  

**Fabrizio Paganelli:** E mi volevo mettere d'accordo un attimino con voi ehm su quali eh diciamo di queste, chiamiamole così dimensioni e vi devo già passare a voi questo perché perché eh l'anagrafica articoli di Mexal ha al massimo tre ehm tre campi attraverso i quali possiamo classificare i prodotti. Ehm e quindi ecco, mi volevo un attimino coordinare con voi di modo tale che quando lunedì andremo a parlare con la direzione sappiamo già dargli un un minimo di di linea di indirizzo. Ecco, non so come dire.

**Andrea Di Cicco:** Mhm. Ma

**Fabrizio Paganelli:** Allora, io Allora,

**Andrea Di Cicco:** vai.

**Fabrizio Paganelli:** aspetta che la apro, apro un attimo l'anagrafica su Mexal. Abbiamo, scusate un attimo. M.

**Elisa Migliano:** Fog, c' una Так. M.

**Fabrizio Paganelli:** Ce la posso fare? Non lo so.

**Andrea Di Cicco:** E senò provo a invocare io le PI, vedo che campi mi torna.

**Fabrizio Paganelli:** Ecco. No, no, adesso l'ho l'ho l'ho aperta. Allora, noi praticamente abbiamo eh un primo campo che si chiama

**Andrea Di Cicco:** Ok.

  
  

### **00:06:07**

  

**Fabrizio Paganelli:** eh natura. Faccio una premessa, questi campi ad oggi non sono per niente gestiti, non li gestiamo, eh, quindi siamo liberissimi di fare come è più comodo per noi, per voi, senza nessun vincolo, diciamo, in questo senso. Ecco, ripeto, noi qui abbiamo un campo che si chiama natura e che, diciamo, è il il campo più macro. Qui, ad esempio, io me lo immaginavo io. Eh eh potremmo mettere ehm un un codice che ci identifica se quel campo genera biglietto, sì, o genera biglietto no.

**Andrea Di Cicco:** Eh sì, volendo sì. Eh l'unica cosa è che io non lo vedo che mi torna dalle PI. Aspetta.

**Fabrizio Paganelli:** Ah.

**Andrea Di Cicco:** Nath, codice natura. Può darsi che lo vedo sempre vuoto,

**Fabrizio Paganelli:** Sì,

**Andrea Di Cicco:** però

**Fabrizio Paganelli:** infatti m non se c'è qualcosa dentro è,

**Andrea Di Cicco:** mamo,

**Fabrizio Paganelli:** diciamo, m come posso dire sporcizia del passato, però che ripeto non non vengono gestiti questi

**Andrea Di Cicco:** eh vediamo se ne trovo uno popolato, giusto perché io Qui il campo tramite integrazione è chiamato COD\_ Natura.

  
  

### **00:07:44**

  

**Andrea Di Cicco:** Immagino sia quello.

**Elena Spini:** Vuoi condividere Andre?

**Fabrizio Paganelli:** Mm.

**Elena Spini:** Così vediamo e magari anche per Aurel quando poi lo

**Andrea Di Cicco:** Sì,

**Elena Spini:** vedrà.

**Andrea Di Cicco:** aspetta

**Aurel mrruku:** Sto già guardando eh la collection che hai passato,

**Andrea Di Cicco:** che

**Elena Spini:** Ah, ok.

**Aurel mrruku:** Andre,

**Elena Spini:** Ah, cioè è vero,

**Andrea Di Cicco:** Sì,

**Elena Spini:** però allora solo per me,

**Andrea Di Cicco:** sì, sì.

**Aurel mrruku:** vero?

**Andrea Di Cicco:** Eh,

**Elena Spini:** se vi va di condividere per i comuni mortali che che non guardano Postman. Grazie.

**Andrea Di Cicco:** c perché non lo vedo mai mai popolato. preso tipo 27 degli ultimi articoli modificati e

**Fabrizio Paganelli:** Io se provo anche a andare a guardare nel nelle tabelle aziendali,

**Andrea Di Cicco:** aspetta eh, provo a prenderne di più.

**Elisa Migliano:** No.

**Andrea Di Cicco:** Perché immagino che tu vedi un nome, io ne vedo un altro, quindi Sì.

**Fabrizio Paganelli:** fammi vedere se faccio l'F1 Ч. Se io vado qui, allora allora altri dati anagrafici. No, non ho la possibilità di vedere il nome del campo tecnico.

  
  

### **00:09:23**

  

**Andrea Di Cicco:** E vabbè, semmai la chiediamo a Mirko, se non sbaglio.

**Fabrizio Paganelli:** M io, guarda, se vuoi ne posso creare una e tu riesci a vederlo istantaneamente?

**Andrea Di Cicco:** Eh

**Fabrizio Paganelli:** Allora, provo a creare una natura.

**Andrea Di Cicco:** sì.

**Fabrizio Paganelli:** tabelle aziendali, natura e articoli. Nuovo tipo faccio codice 1 genera biglietto. Ok. e poi vado in anagrafica articoli e qui provo a mettergli questo. Ok, adesso ci dovrebbe essere un uno dentro il codice articolo CS\_00154.

**Andrea Di Cicco:** No, proviamo a prenderli a togliere il filtro. data ultima modifica è popolato sul prodotto.

**Fabrizio Paganelli:** Non lo so,

**Andrea Di Cicco:** Mh,

**Fabrizio Paganelli:** non lo so perché io dall'anagrafica articolo non lo vedo.

**Andrea Di Cicco:** non lo vedi.

**Fabrizio Paganelli:** No.

**Andrea Di Cicco:** CS hai detto 00154. Ok,

**Fabrizio Paganelli:** CS\_00154.

**Andrea Di Cicco:** happy team.

**Fabrizio Paganelli:** Sì.

**Andrea Di Cicco:** Ok.

**Fabrizio Paganelli:** Ok.

**Andrea Di Cicco:** Ovviamente io che sto cercato, eh. natura uno.

  
  

### **00:11:41**

  

**Andrea Di Cicco:** Sì, lo vedo popolato.

**Fabrizio Paganelli:** Ok.

**Andrea Di Cicco:** Ok, quindi sì, volendo si può utilizzare il campo per definire se un

**Fabrizio Paganelli:** Ok.

**Andrea Di Cicco:** prodotto sia ehm utilizzato per generare Okay.

**Aurel mrruku:** M.

**Andrea Di Cicco:** o meno, quindi magari diamo come convenzione che non lo so, sì, true, vero? Non lo so, come vogliamo identificare il codice per capire che genera biglietto.

**Fabrizio Paganelli:** Ok.

**Andrea Di Cicco:** Però poi ovviamente, cioè bisogna stare attenti che chiunque vada a generare un prodotto si attenga a quella perifrasi, perché da quello che ho capito è un campo libero lato vostro, quindi potrebbero inserire di tutto o non so quante persone mettono mano sui prodotti,

**Fabrizio Paganelli:** Eh no, diciamo che non è un campo libero,

**Andrea Di Cicco:** però

**Fabrizio Paganelli:** è un campo che eh diciamo ha relazionata un'altra tabella con l'elenco delle nature gestite,

**Andrea Di Cicco:** Ok.

**Fabrizio Paganelli:** quindi cioè non posso metterci dentro Pippo perché se se non è già presente Pippo nell'anagrafica di base lì non gli posso mettere niente.

**Andrea Di Cicco:** Mh mh. Ok. Ok. Quindi magari eh quando decidiamo il valore da mettere

  
  

### **00:12:58**

  

**Fabrizio Paganelli:** Ok.

**Andrea Di Cicco:** tra il set, tra l'insieme dei valori possibili di questo campo, basta che ci condividi il valore che hai messo e poi noi in base a quello dall'integrazione lo traduciamo su sales, forse lo facciamo diventare eh il campo che determina se genera o meno il biglietto. Quindi questo ok.

**Elena Spini:** Lo possiamo decidere ora se uno è tu o qualcos'altro?

**Fabrizio Paganelli:** Magari possiamo fare così che io lunedì gli do questa

**Andrea Di Cicco:** M.

**Elena Spini:** Ci deve pensare. Ah, già. Ok, ok, scusa.

**Fabrizio Paganelli:** gli do do la direzione questa cosa,

**Elena Spini:** Ev.

**Fabrizio Paganelli:** poi eh gliela faccio vedere e poi vi passo l'anagrafica,

**Elena Spini:** Ok,

**Fabrizio Paganelli:** vi ripasso tutta l'anagrafica già revisionata, insomma,

**Elena Spini:** va bene. Conferma lunedì.

**Fabrizio Paganelli:** ehm su questa cosa qui, allora, perché noi oggi Oggi come oggi abbiamo circa 1000 codici articolo dentro la grafica che sono anche il retaggio di tutta una gestione passata eccetera eccetera. Ehm, secondo voi io in questo campo, quindi dovrei mettere gener. Posso anche mettere un un terzo numero, diciamo il numero tre che mi identifica che non deve essere caricato su Sales Force.

  
  

### **00:14:30**

  

**Andrea Di Cicco:** Eh

**Aurel mrruku:** Intendi,

**Andrea Di Cicco:** sì.

**Aurel mrruku:** scusa, intendi non caricato su Sales Force oppure non attivo su Sales Force?

**Fabrizio Paganelli:** Eh, non lo so, perché io quello che volevo fare era fare in modo che i tutor quando vanno in un ordine a a a inserire il codice articolo in un ordine Ordine. Vorrei che vedessero un set limitato. ai codici articolo che sono al momento in vigore. Non volevo passare su sales force 1000 codici prodotto perché dopo corriamo il rischio che i tutorzino dei codici articolo che non devono essere più utilizzati. Non so come spiegarmi.

**Andrea Di Cicco:** è praticamente una disattivazione di un prodotto. Ok.

**Aurel mrruku:** Sì.

**Andrea Di Cicco:** Eh sì, magari puoi aggiungere il valore disattivo,

**Fabrizio Paganelli:** Esatto.

**Andrea Di Cicco:** inattivo e e in quel modo noi sappiamo che se quel prodotto ha quel valore inattivo lo disabilitiamo,

**Aurel mrruku:** Ma ma preferisco un altro campo,

**Andrea Di Cicco:** però

**Aurel mrruku:** questo è il punto, perché poi devo fare io de automatismi nel momento dell'ingresso dei

**Fabrizio Paganelli:** Mm.

**Aurel mrruku:** prodotti e praticamente quei prodotti

  
  

### **00:15:48**

  

**Fabrizio Paganelli:** Ho

**Aurel mrruku:** sanno il tre.

**Fabrizio Paganelli:** capito.

**Aurel mrruku:** Io dopo l'inserimento, quindi lo devo elaborare come come record. Gli devo dire,"Guarda, questo lo devi disattivare."

**Fabrizio Paganelli:** Mh.

**Andrea Di Cicco:** e

**Fabrizio Paganelli:** Perché io potrei utilizzare anche un un campo che è uno stato del codice articolo che abbiamo su Mexal, nel senso che noi possiamo dire su Mexal se quel codice articolo è ehm annullato. E solo che in questo modo tu lo caricheresti come una grafica, dico bene, però faresti in modo che il codice articolo è disattivato, per cui chiunque vada a inserire un ordine poi non lo vede. Se può fare anche così.

**Andrea Di Cicco:** Eh sì, però aspetta, su Mexal hai detto che c'è un campo che identifica se un prodotto è attivo o

**Fabrizio Paganelli:** Allora,

**Andrea Di Cicco:** meno.

**Fabrizio Paganelli:** su Mexal c'è un un bottone. Quando io apro un codice articolo c'è un

**Andrea Di Cicco:** Ok.

**Fabrizio Paganelli:** bottone che mi dice annulla barra ripristina.

**Andrea Di Cicco:** Ok.

**Fabrizio Paganelli:** Quindi se io lo clicco, quel codice articolo, quello che abbiamo detto prima, va in stato di annullato.

  
  

### **00:17:23**

  

**Andrea Di Cicco:** Ok.

**Fabrizio Paganelli:** Quindi io effettivamente potrei usare questo per fare ehm questa ulteriore distinzione legata al fatto se renderlo attivo o non attivo su sales force.

**Andrea Di Cicco:** Sì, dobbiamo solamente capire qual è il campo su cui è mappata questa questa modifica.

**Fabrizio Paganelli:** Eh

**Andrea Di Cicco:** Ad esempio, l'ultimo prodotto che tu mi hai inviato, no? Cioè che che hai modificato App Team.

**Fabrizio Paganelli:** sì, sì.

**Andrea Di Cicco:** Se proviamo. Aspetta, facciamo così. Control A, contrl C. Vi faccio un compare. Hai modo di disattivarlo tu questo prodotto? Giusto perché voglio fare un compare dei Jason per capire qual è il campo,

**Fabrizio Paganelli:** M.

**Andrea Di Cicco:** cioè se esiste un campo che posso vedere lato Sales Force che mi dice che questo prodotto è disattivato su Mexal. Immagino di sì. È solo che sono una spadaffiata di campi

**Fabrizio Paganelli:** Mh. E prova

**Andrea Di Cicco:** e aspetta questo. Affronta resto e trova differenze. Questo è uno. Ok. Ok, ha trovato una differenza.

  
  

### **00:19:09**

  

**Andrea Di Cicco:** No, mh non c'è perché l'unica differenza che è che ho trovato è la data data ricalcolo elaborazione, quindiamo

**Fabrizio Paganelli:** riprovo adesso perché non avevo dato un OK.

**Andrea Di Cicco:** gestione annullato. Eccolo. Da no, da n è passato S. Poi non so perché qua ha aggiunto degli, cioè ha tolto il punto zero, però però dovrebbe essere questo qui il campo.

**Fabrizio Paganelli:** Hai hai un nome tecnico del campo?

**Andrea Di Cicco:** Gest. annullato. Aspetta, te lo metto in chat. Questo qui. Allora, quando è attivo il valore è n, quando è inattivo il valore è S.

**Fabrizio Paganelli:** M. Il tema è in questo caso qui e e adesso mi confronto anche con l'Elisa, è che se noi annulliamo un codice articolo su Mexal temo che succeda un mezzo casino in termini diazione anche su quelle

**Andrea Di Cicco:** Fatturazione

**Fabrizio Paganelli:** vecchie.

**Elisa Migliano:** Niente. Sì, Fabi, io condivido. Non andrei a eliminarli.

**Fabrizio Paganelli:** Eh,

**Elisa Migliano:** Ho detto condivido. Non andrei a eliminarli.

  
  

### **00:21:39**

  

**Fabrizio Paganelli:** no, no, ma non vengono eliminati i codice prodotto, vengono solo flegati e vanno a finire in uno stato AD annullato.

**Elisa Migliano:** CR

**Fabrizio Paganelli:** Però il tema è che quando poi dopo io riapro una fattura vecchia dove all'interno c'è quel prodotto ho o temo che non lo vediamo più, capito? È una cosa assurda, me ne rendo conto. Ma tipo te,

**Elisa Migliano:** Bisognerebbe fare delle prove con dei prodotti che abbiamo eliminato all'interno sono delle

**Fabrizio Paganelli:** Lisa ti

**Elisa Migliano:** fatture.

**Fabrizio Paganelli:** Aspetta che vado la faccio la prova.

**Elisa Migliano:** Ok.

**Fabrizio Paganelli:** Adesso guardo l'ultima fattura che abbiamo emesso che è tipo questo qui,

**Elisa Migliano:** M.

**Fabrizio Paganelli:** la terrazza. Che cos'è che ha? Food Marketing Festival Gold, il CS58. Allora, se io questo qui lo vado ad annullare. Ok, adesso è annullato. Rientro nella fattura e che cosa succede? V in un MS stamattina lo vedo. Continuo a vederlo regolarmente. Sto guardando la fattura che hai fatto alla terrazza.

  
  

### **00:23:28**

  

**Fabrizio Paganelli:** Non ci dovrebbero essere impatti.

**Andrea Di Cicco:** Ehm, ma ci sono fatture che sono un po' sdatate, nel senso se io creo l'ordine oggi è possibile che la fattura viene generata tra 3 giorni e in Quel bisognerebbe

**Fabrizio Paganelli:** Sì.

**Andrea Di Cicco:** verificare quel caso, cioè io disattivo il prodotto e la fattura si genera poi dopo. Perché quello è l'unico scenario che mi verrebbe il dubbio, però se ti si avrano comunque le fatture vecchie in teoria, però ripeto, questa è Mexal, quindi

**Fabrizio Paganelli:** No, no, ma diciamo dopo quando noi andiamo a quando normalmente annulliamo i prodotti li annulliamo, ma in riferimento a robe molto vecchie, quindi eh quando li annulliamo siamo sicuri che non abbiamo ordini futuri da fatturare su quell'articolo.

**Elisa Migliano:** Allora,

**Andrea Di Cicco:** Oh.

**Elisa Migliano:** in realtà è successo un paio di volte che i clienti, cioè, scusate, i tutor facessero dei preventivi nel mentre noi annullassimo dei codici prodotto, eh, e che magari poi il cliente accetta quel preventivo e quindi poi non ci passava su Mexal perché ovviamente quel preventivo era annullato, quindi dopo lo cambiavamo noi a mano perché Mexal ti dice il motivo per il quale non è passato e quindi poi lo cambiavamo cambiavamo noi il codice.

  
  

### **00:25:07**

  

**Fabrizio Paganelli:** Questo qui succede ne in quei codici articolo ST degli streaming, se non ricordo male,

**Elisa Migliano:** No,

**Fabrizio Paganelli:** vero?

**Elisa Migliano:** no, è successo anche tipo con pienissimo live che gli abbiamo cambiato il nome,

**Andrea Di Cicco:** f\*\*\*.

**Elisa Migliano:** cioè con un po' di cose è successo.

**Fabrizio Paganelli:** Mh. Probabilmente se noi utilizziamo questo flag di annullato è senz'altro la strada più pulita. Diciamo che se ci succede dopo dobbiamo andare,

**Andrea Di Cicco:** Sì,

**Fabrizio Paganelli:** siamo noi che dopo dobbiamo andare a gestire a mano l'ordine, la fattura e utilizzando il codice prodotto

**Andrea Di Cicco:** però se tu lo annulli,

**Fabrizio Paganelli:** nuovo.

**Andrea Di Cicco:** cioè se tu disabiliti, diciamo disabilitiamo il prodotto su Sales Force, eh, l'utente non è in grado di selezionarlo.

**Fabrizio Paganelli:** Neanche l'utente, un utente master come sarà l'utente amministrazione.

**Andrea Di Cicco:** Esatto. Perché non gli compare proprio perché quel

**Fabrizio Paganelli:** Ah, neanche neanche l'utente master.

**Andrea Di Cicco:** prodotto no l'utente

**Fabrizio Paganelli:** E allora è un problema questo,

**Andrea Di Cicco:** se perché tu devi creare poi ordini con quel prodotto disabilitato

  
  

### **00:26:21**

  

**Fabrizio Paganelli:** no? No, se se vediamo che in fase di fatturazione l'ordine non passa perché il prodotto è disabilitato, noi andiamo ehm nell'ordine e modifichiamo il codice prodotto nell'ordine, mettiamo il codice prodotto nuovo nell'ordine.

**Andrea Di Cicco:** Allora, aspetta, facciamo, cioè ci sono due discorsi.

**Fabrizio Paganelli:** Ok.

**Andrea Di Cicco:** Il primo è io disabilito il prodotto, quindi se faccio una nuova vendita quel prodotto nel carrello non lo vedo e quindi non lo posso selezionare.

**Fabrizio Paganelli:** Ok.

**Andrea Di Cicco:** supponiamo il caso tuo, il caso in cui io ho selezionato un prodotto che era attivo quando l'ho

**Fabrizio Paganelli:** Sì,

**Andrea Di Cicco:** inserito e poi è stato disattivato successivamente.

**Fabrizio Paganelli:** sì, sì,

**Andrea Di Cicco:** Sull'ordine compare quel prodotto, però ovviamente poi non posso risarlo,

**Fabrizio Paganelli:** sì.

**Andrea Di Cicco:** quindi se vado a fare una modifica non la posso non posso risonare quel prodotto, però posso andare a modificarlo in modo da mettere il nuovo codice prodotto, quello sì.

**Fabrizio Paganelli:** Ok, così penso che vada bene. Lisa, te cosa dici?

**Elisa Migliano:** Sì, sì, per me va bene così. Cioè, diciamo che è un po' come adesso, tranne che adesso, anche se i codici prodotto sono annullati su Zo, sono visibili, ma è meglio nel renderli visibili,

  
  

### **00:27:36**

  

**Andrea Di Cicco:** Cioè alla fine la Eh sì,

**Elisa Migliano:** eh, cioè assolutamente ha senso. Cioè,

**Andrea Di Cicco:** nel eh perché lo scopo è proprio quello,

**Elisa Migliano:** se li metto annullati non devono essere visibili. Sì, sì,

**Andrea Di Cicco:** che poi tu eviti di avere durante la vendita un prodotto che in realtà è annullato.

**Elisa Migliano:** giusto chiaro. Sì, sì,

**Andrea Di Cicco:** Quindi poi ovviamente se tu l'hai disabilitato puoi comunque farci reportistica,

**Elisa Migliano:** giustissimo.

**Andrea Di Cicco:** quindi nel senso tu puoi rivedere tutto lo storico,

**Elisa Migliano:** Perfetto.

**Andrea Di Cicco:** capire chi ha avuto quel quel prodotto e così.

**Elisa Migliano:** Sì, sì, il pregresso si può vedere tutto.

**Andrea Di Cicco:** Esatto. Sì,

**Elisa Migliano:** Sì, sì,

**Andrea Di Cicco:** sì.

**Elisa Migliano:** va benissimo.

**Andrea Di Cicco:** Però non lo puoi selezionare per la vendita.

**Elisa Migliano:** Giusto. Perfetto.

**Fabrizio Paganelli:** Allora, io adesso nel frattempo ho rimesso a posto quei due che avevamo

**Andrea Di Cicco:** Ok.

**Fabrizio Paganelli:** modificato,

**Andrea Di Cicco:** Ok. Happy team.

**Fabrizio Paganelli:** quindi Food Marketing Festival è di nuovo attivo.

  
  

### **00:28:21**

  

**Fabrizio Paganelli:** Adesso è il CS\_ 00154 e di nuovo attivo. Ok, quindi usiamo il flag annullato per far sì che poi dopo quando l'articolo passa su Ses Force abbia una sorta di flag di inattivo di in modo tale che non sia visibile dagli utenti che devono inserire l'ordine. Ok.

**Andrea Di Cicco:** Esatto.

**Fabrizio Paganelli:** Flag annullato su forse disattivo disattivato. Chiaramente se ci sbagliamo, anziché annullare uno dove annullare l'altro, eh lo lo lo andiamo a ripristinare tra i non annullati. Il giorno dopo ti si riattiva tutto, immagino.

**Andrea Di Cicco:** Sì, sì, sì, sì,

**Fabrizio Paganelli:** Ok.

**Andrea Di Cicco:** perché ovviamente vai in modifica. No, noi andremo a vedere quelle che sono le differenze tra quello che c'è su Mexal e su Sales,

**Fabrizio Paganelli:** Ok.

**Andrea Di Cicco:** forse andremo ad aggiornare i

**Fabrizio Paganelli:** Eh,

**Andrea Di Cicco:** valori.

**Fabrizio Paganelli:** quindi questo qui è a posto. Eh, poi dopo abbiamo un altro campo sempre all'interno dell'anagrafica articoli e che si chiama

**Andrea Di Cicco:** Mhm.

  
  

### **00:29:46**

  

**Fabrizio Paganelli:** categoria statistica. Eh, io utilizzerei questo per individuare fare quello che è l'evento tipo camerieri, tutti i codici articolo che fanno parte di camerieri venditori, tutti i codici articolo che fanno parte di Food Marketing Festival, tutti i codici articolo che fanno parte di FP team eccetera eccetera eccetera.

**Andrea Di Cicco:** M sì, cioè mh sì. Però io ne vedo tre. Sigla categor, cioè vado a intuito, eh, perché poi son nomi storpiati. Sigla categoria cat sta e numero cat sta. Immagino che sia questo che suy time lo vedo vuoto.

**Fabrizio Paganelli:** Aspetta che provo a rimetterlo anche lì, così facciamo.

**Andrea Di Cicco:** Ok.

**Fabrizio Paganelli:** Allora, categoria statistica. Questo qui è Team. Ok. Ok, ok. Ecco, l'ho appena valorizzato. Ci dovresti trovarci dentro un codice che è C01.

**Andrea Di Cicco:** Allora, io vedo qui C e numero un quindi lo spezza perché la C

**Fabrizio Paganelli:** Ah,

**Andrea Di Cicco:** è tipo la sigla e poi c'è un numero

**Fabrizio Paganelli:** ok. Provo a cambiarlo così vediamo le modifiche se effettivamente quello

  
  

### **00:31:43**

  

**Andrea Di Cicco:** Mhm.

**Fabrizio Paganelli:** lì.

**Andrea Di Cicco:** Sì.

**Fabrizio Paganelli:** Ok, adesso dovresti vedere P02 P2,

**Andrea Di Cicco:** Sì, quindi comunque si spezza,

**Fabrizio Paganelli:** eh.

**Aurel mrruku:** Quale?

**Andrea Di Cicco:** però magari Sì.

**Aurel mrruku:** Che prodotto era questo? EPT

**Andrea Di Cicco:** Eh, devi cercare sigla cat sta.

**Aurel mrruku:** c\*\*\*\*. C però. Ah,

**Andrea Di Cicco:** Hai rimandato adesso?

**Aurel mrruku:** ok. P. Ok, adesso. Ok, perfetto. Grazie. P2.

**Andrea Di Cicco:** Mh mh. Eh, però magari puoi fare, che ne so, categoria evento ev il nome dell'evento. tipo sigla categoria, c'è una convenzione per capire se streaming live poi. numero categoria è proprio il codice dell'evento o il nome dell'evento?

**Fabrizio Paganelli:** dicevi a me, Andrea? Sì, sì, possiamo fare così.

**Andrea Di Cicco:** Sì.

**Fabrizio Paganelli:** creo una lista di categorie, ogni categoria è un evento e quindi voi vi troverete un determinato codice che raggruppa tutti gli articoli di Food Marketing Festival e via dicendo.

  
  

### **00:33:19**

  

**Andrea Di Cicco:** Ok, Aurel, che dubbio hai? Ti vedo con la fronte aggrottata.

**Aurel mrruku:** Non ho capito bene come come hai pensato il raggruppamento di questi prodotti in base di categoria, quindi la tua API, intendo la tua struttura mi è chiaro per lato API come quindi tutti i prodotti che hanno su questo campo un certo numero devo mettere io hardcore su sales force se hanno questo numero devi popolare la categoria di quel prodotto.

**Andrea Di Cicco:** No, questo è categoria statistica. Eh, non è la categoria del prodotto questo, eh questo ti dice ti dice praticamente eh l'evento relativo a questo prodotto.

**Aurel mrruku:** questo porto qui. Quindi questi prodotti sono vendibili solo per quegli eventi,

**Andrea Di Cicco:** Sì,

**Fabrizio Paganelli:** Sì,

**Andrea Di Cicco:** sì.

**Aurel mrruku:** quindi dobbiamo in qualche modo collegare quelle campagne. Не.

**Andrea Di Cicco:** Eh sì.

**Fabrizio Paganelli:** Il collegamento con le campagne dovrebbe venire dal campo natura che abbiamo detto prima, perché è lì che gli diciamo genera biglietto sì o genera biglietto no. Quindi se genera biglietto è sì va collegato con con la campagna.

**Andrea Di Cicco:** E

**Aurel mrruku:** È un po' più complesso perché la campagna, non so se Elena ha già spiegato quello che abbiamo discusso sulle campagne, sulle strutture delle campagne.

  
  

### **00:35:26**

  

**Aurel mrruku:** Elena, puoi aiutare? C. No, no, no.

**Elena Spini:** Arrivo, arrivo. Ho sentito Elena mentre rientrava.

**Aurel mrruku:** Sì. Eh, no, stavo parlando riguardo alle strutture delle campagne,

**Elena Spini:** Eccomi.

**Aurel mrruku:** sono state discusse, vero? perché è un po' complessa la situazione.

**Elena Spini:** Allora,

**Aurel mrruku:** Quindi stiamo dicendo che ci saranno dei prodotti collegati alle campagne perché sono prodotti che devono essere venduti solo in quelle campagne là. Ma nel ciclo di vita delle campagne, se ti ricordi, abbiamo detto che dobbiamo avere un contenitore che avrà dei

**Elena Spini:** Corretto.

**Aurel mrruku:** figli.

**Elena Spini:** Esatto,

**Aurel mrruku:** Quindi tutti questi prodotti devono essere collegati coi figli.

**Elena Spini:** corretto. Cioè, per intenderci, Fabrizio, eh quando abbiamo fatto il giro settimana scorsa che abbiamo parlato eh ti ricordi che Rebecca c mi aveva fatto vedere

**Fabrizio Paganelli:** Mh.

**Elena Spini:** evento edizione, ti ricordi come gestite voi su Zoo questa questo

**Fabrizio Paganelli:** Sì,

**Elena Spini:** giro? Oh\!

**Fabrizio Paganelli:** sì.

**Elena Spini:** Eh, e poi avevamo fatto la proposta eh di eh tenere comunque l'oggetto campagna su Sales Force dove campagna padre uguale evento, il vostro evento su Zoo e campagne, figlie sono tutte le indicazioni di eh edizioni,

  
  

### **00:37:01**

  

**Fabrizio Paganelli:** Mm.

**Elena Spini:** praticamente sono le varie edizioni, ad esempio Food Marketing Festival, campagna generica, chiamiamola così. Invece edizione Food Marketing Festival mh settembre 2026 è il figlio,

**Fabrizio Paganelli:** Ok.

**Elena Spini:** quindi come se fosse la vostra edizione. Quando eh su Sales Force a noi arriverà il prodotto con genera biglietto. Sì, adesso non non ho capito quale quale sarà la il codice,

**Andrea Di Cicco:** Ecco qui.

**Elena Spini:** il finale. A noi serve l'indicazione dell'edizione per quel per quel prodotto che così le diamo il prodotto a quella campagna figlia che sarebbe all'edizione,

**Aurel mrruku:** Sì,

**Elena Spini:** giusto?

**Aurel mrruku:** quindi deve essere un'informazione a livello di prodotto, però questa informazione lo puoi avere solo dopo aver generato la campagna figlia su Sales Force, oppure possiamo usare lo stesso codice che usate sia nella generazione del prodotto che della campagna figlia, ma devono per forza avere un punto in comune la campagna figlia con il prodotto.

**Elena Spini:** Sarà una sorta di, chiamiamola così, un'action che andrà fatta dalla Rebecca di turno che quando manualmente,

**Aurel mrruku:** Tutto

**Elena Spini:** perché avevamo detto che manualmente andremo a creare le edizioni.

  
  

### **00:38:35**

  

**Elena Spini:** le campagne figlie dovrà aggiungere anche il riferimento con il prodotto.

**Fabrizio Paganelli:** Allora, io ti dico quello che mi ricordo l'altra volta. Noi avevamo detto che da Mexal tu hai l'indicazione se quel determinato codice articolo deve generare un biglietto, sì o no. Ok? E questo qui è quello che adesso. Adesso abbiamo detto di mettere dentro la natura, dentro il campo Mexal che si chiama natura. Poi dopo eh se quel biglietto genera se quel articolo nel momento in cui entra nell'ordine deve generare un biglietto, hai l'indicazione dell'evento a cui quel quell'articolo si riferisce nel campo che abbiamo detto adesso, la categoria statistica. Quindi io ti, ad esempio,

**Aurel mrruku:** Ok,

**Fabrizio Paganelli:** per EP team ti dirò eh codice articolo CS0054 genere biglietto. Sì. Poi all'interno della categoria statistica ci sarà il nome di

**Aurel mrruku:** quindi sarà il padre praticamente la campagna padre.

**Elena Spini:** però evento.

**Fabrizio Paganelli:** quell'evento.

**Elena Spini:** Ah, ok. Sì.

**Aurel mrruku:** nella campagna padre avrà fleggato la campagna figlia che è attiva in quel periodo là e quindi in automatico il prodotto verrà collegato con la campagna

  
  

### **00:40:00**

  

**Fabrizio Paganelli:** No, non avevamo detto così l'altro giorno.

**Aurel mrruku:** figlia.

**Fabrizio Paganelli:** Noi abbiamo detto generare biglietto sì no. Se generare biglietto è sì attraverso il campo categoria statistica, io ti dico qual è l'evento. Poi le la l'edizione deve essere generata in base alla data in cui in base alla data dell'ordine in cui quel codice articolo è inserito. Non so se ti ricordi Elena.

**Elena Spini:** Sì, ma aspetta perché poi avevamo detto che comunque questa cosa dell'ordine non mi tornava e quando avevamo parlato di padre e figlio avevamo detto che le edizioni erano fatte a mano.

**Fabrizio Paganelli:** Sì, l'anagrafica dell'edizione io la possiamo anche andare a mettere dentro a mano.

**Elena Spini:** Ok.

**Fabrizio Paganelli:** Quindi ci sarà un'anagrafica delle edizioni dove l'amministrazione inserirà edizione Food Marketing Festival 25, poi edizione Food Marketing Festival 26, edizione Full Marketing Festival 27 e questi qui li possiamo inserire noi direttamente dentro salesce anche a mano, tanto non sono eh un numero esorbitante, è facilmente gestibile a mano, però ehm diciamo il l'aggiornamento se quel determinato ordine deve andare nella edizione nel Food Marketing Festival 25 oppure nell'edizione Food Marketing Festival 26. Questa qui può essere data soltanto incrociando eh con la data dell'ordine.

  
  

### **00:41:42**

  

**Elena Spini:** M però aspetta,

**Fabrizio Paganelli:** Vi ricordate che avevamo

**Elena Spini:** aspetta,

**Fabrizio Paganelli:** detto?

**Elena Spini:** noi avevamo pensato con Aurel poi dopo questa riunione che gli avevo detto di questa cosa, noi avevamo pensato di fare così, eh di cioè tu intendi la data dell'ordine, intendi il primo ordine che scende con questo prodotto? M.

**Fabrizio Paganelli:** No, no, No, no, no, no, no.

**Elena Spini:** Cos'è la data

**Fabrizio Paganelli:** Noi, come come abbiamo detto l'altra volta,

**Elena Spini:** dell'ordine?

**Fabrizio Paganelli:** facciamo l'esempio del Food Marketing Festival. Il Food Marketing Festival quest'anno ci sarà il 30 settembre 2026. Chi parteciperà, i nostri clienti che parteciperanno al Food Marketing Festival 2026 che si terrà il 30 di settembre hanno già fatto gli ordini. nell'anno precedente. Quindi se io metto primo ottobre 2025, tutti gli ordini che entrano tra il primo ottobre 25 e il 30 settembre 26 devono devono andare a finire nella campagna Food Marketing Festival 2026. Ma la la l'avevamo detto, almeno dopo, io non so cosa vi siete detti con Aurel, l'avevamo detto nell'ambito del del dell'ultima riunione che avevamo fatto.

  
  

### **00:43:06**

  

**Fabrizio Paganelli:** Noi adesso facciamo così.

**Andrea Di Cicco:** Aurel, sei muto.

**Aurel mrruku:** Scusa Andre, eh, stavo dicendo, ma quando noi abbiamo dei bundle e dei bundle ci sono dei biglietti che cadono sugli eventi diversi, come la gestisci?

**Fabrizio Paganelli:** Eh, in base alla data dell'ordine, se io in un bundle ho,

**Aurel mrruku:** Ma l'ordine sarà

**Fabrizio Paganelli:** è certo,

**Aurel mrruku:** uno.

**Fabrizio Paganelli:** ma io nel bundle ho eh ad esempio un EP team e potrei avere oggi eh parlo di oggi, oggi io inserisco un ordine in Quel bundle c'è Food Marketing Festival 26

**Aurel mrruku:** Sì.

**Fabrizio Paganelli:** e Food Marketing Festival, scusami, e il codice articolo EP Team. il Food Marketing Festival, ehm ci sarà il 30 settembre 26, quindi in quell'ordine quel quella riga articolo che ha eh il codice articolo di Food Marketing dovrà dovrà generare un biglietto e nella campagna dovrà essere indicato Food Marketing Festival 2026, Team che ci sarà il il 31 di marzo del 27 sullo stesso ordine dovrà dovrà andare a finire per Epite Team EPAM edizione 2027.

**Aurel mrruku:** Ma come farà a andare sul 2027?

  
  

### **00:44:30**

  

**Aurel mrruku:** Perché l'ordine, quando l'offerta viene chiusa, l'ordine viene generato.

**Fabrizio Paganelli:** Allora, noi noi noi abbiamo dovremmo avere che era quella che dicevamo l'altra volta, no? Noi abbiamo una tabella dove gli diremo Food Marketing Festival 2027 e di fianco gli dobbiamo mettere una data da data inizio a data fine. Quindi Food Marketing Festival 27 dal primo ottobre 25 al 30 settembre 26 che questo qui è un range di data ordine. Se l'ordine, qualsiasi ordine mi entra con una data compresa in questo range dovrà essere assegnato a Food Marketing Festival 27. Se nello stesso ordine c'è anche EP Team 2027 e chiaramente su Team avrò un range diverso. Avrò, ad esempio, dal primo aprile 26 al 30 al 31 di marzo 27. Ok? In questo caso qui la la l'ordine che io stacco oggi, anche se compreso nello stesso ordine dell'altro food marketing, va a splittare eh la campagna su due edizioni diverse.

**Elena Spini:** Eh, ma forse perché voi ragionate con due ordini diversi è riuscito a fare questa cosa.

**Fabrizio Paganelli:** No, no, l'ordino lo stesso. Io io

  
  

### **00:45:55**

  

**Elena Spini:** Ma tu prendi forse, cioè,

**Fabrizio Paganelli:** oggi

**Elena Spini:** come fai a mettere nella cioè l'edizione, diciamo, di del 2027, cioè ti prendi la

**Fabrizio Paganelli:** Allora, scus scusate, eh eh lo faccio un attimo mano, lo lo rifaccio perché m ehm Allora, lo rifacciamo. Noi dovremmo avere una tabella, ok? dove diciamo bene per tutti gli ordini che vanno dal primo di ottobre 25 al ehm 30 settembre 26, dove dentro c'è il codice articolo CS00158 che è il Food Marketing Festival, se l'ordine cade in questo range di date devi assegnare eh quel biglietto all'edizione Food Marketing Festival 27. Poi nella stessa tabella avrò un altro record dove gestisco l'edizione 2027 di Epite Team, quindi avrò un range di date diverso. Ad esempio, dal primo aprile 25 al, scusate, dal primo aprile 26 al 31 marzo 27. Se io all'interno degli ordini che cadono all'interno di questo intervallo di date mi trovo EP Team, allora eh il codice articolo inserito inserito all'interno dell'ordine dovrà avere edizione EPTeam 27

  
  

### **00:47:27**

  

**Elena Spini:** a livello di riga, quindi non di ordine, perché l'ordine sarà sempre del boh,

**Fabrizio Paganelli:** a livello di riga ordine.

**Elena Spini:** non lo so.

**Fabrizio Paganelli:** Chiaro? Certo. a livello di riga ordine.

**Elena Spini:** In effetti quello che avevamo pensato Aurel,

**Fabrizio Paganelli:** M.

**Elena Spini:** cioè non può esistere perché noi avevamo fatto delle logiche per mettere eh la ti ricordi solo quella attiva in base alla campagna attiva.

**Aurel mrruku:** Eh

**Elena Spini:** Però in effetti non si può fare questa cosa perché se prendi il bundle, cioè come fai? E ho solo E Tipo come questo esempio, Food Marketing 26 attivo. Ok, Food Marketing 26 attivo. Metto eh il biglietto, metto No, aspetta, eh considero la campagna figlia, food marketing, marketing 26 perché è attiva, però in realtà se nello stesso ordine io anche Food Marketing Festival 27, dove lo metto?

**Aurel mrruku:** Non mi è chiaro a livello di bundle. Quando noi parliamo di ordine mandiamo tutto su. Però qua non stiamo parlando a livello di ordine, stiamo parlando a livello di trunch

**Elena Spini:** Eh sì, esatto. è che la logica va a livello di tranche di fondo,

  
  

### **00:48:40**

  

**Aurel mrruku:** dell'ordine.

**Elena Spini:** di righe, di ordine.

**Fabrizio Paganelli:** Eh, ma la trash avrà una data ordine, no? Io ho avrò l'ordine dei avrò un ordine del bundle che è intestata data ordine un io faccio un ordine

**Aurel mrruku:** Con con data ordine cosa intendi?

**Fabrizio Paganelli:** oggi vado al magazzino della MAR, voglio comprare un prosciutto. Faccio un ordine,

**Aurel mrruku:** Sì, sì.

**Fabrizio Paganelli:** oggi è il 26 agosto.

**Aurel mrruku:** Oggi oggi hai fatto un ordine di quattro

**Fabrizio Paganelli:** Eh,

**Aurel mrruku:** biglietti,

**Fabrizio Paganelli:** oggi ho fatto un ordine di quattro biglietti, quindi l'ordine

**Aurel mrruku:** ma due di questi biglietti sono del 2026 e altri due del

**Fabrizio Paganelli:** eh

**Aurel mrruku:** 2027, però l'ordine di oggi è del 2026,

**Fabrizio Paganelli:** l'ordine di oggi, ma come dicevamo perfettamente,

**Aurel mrruku:** quindi non è data d'ordine.

**Fabrizio Paganelli:** l'ordine di oggi tutte le righe ordine avranno la stessa data dell'ordine.

**Aurel mrruku:** Sì, 2026.

**Fabrizio Paganelli:** Perfetto. Poi di fianco ho quella famosa tabella che dicevamo di fare anche noi a mano direttamente su SESP senza fare, diciamo, flussi perché sul Mexal non è gestita sta cosa.

  
  

### **00:49:49**

  

**Fabrizio Paganelli:** In quella tabella ci sarà articolo per articolo, data inizio e data fine, ok? e poi di fianco ci sarà l'edizione. Poi io dovrò incrociare eh eh in eh dovrò andare a vedere in base alla data dell'ordine in in se quella data è compresa in un determinato range mi dovrà segnare Food Marketing Festival 27, chiaramente sul codice articolo del food marketing. Se invece quel in quel nello stesso ordine ho EPeam, l'EPTeam avrà l'edizione EPeam 27 avrà un range di date diverso, ma oggi e riesco già a capire che è Food Marketing Festival 27, cioè M.

**Aurel mrruku:** Forse ci meglio se ci prendiamo un'ora e facciamo proprio degli esempi concreti

**Fabrizio Paganelli:** Mh.

**Aurel mrruku:** sull'Excel come sta facendo Andrea adesso. Mettiamo un esempio di ordine con diversi prodotti che cadono su eh praticamente campagne diverse. K. Cosa intendiamo per data d'ordine? Il range sulle campagne più o meno l'ho capito. Anche il collegamento con le campagne l'ho capito. Mi manca solo il punto in cui associ la riga dell'ordine con la

**Fabrizio Paganelli:** Eh,

**Aurel mrruku:** campagna.

  
  

### **00:51:16**

  

**Fabrizio Paganelli:** ma infatti è il punto che dicevamo l'altro giorno con Elena che dovremmo fare noi su Salesfor una tabella aggiuntiva dove gli diciamo da data a data codice evento e in base a quelle due date, cioè non lo so,

**Elena Spini:** Le campagne figlie corrispondono a quel a quella l'edizione,

**Fabrizio Paganelli:** magari

**Elena Spini:** quindi la campagna figlia dal primo ottobre al 30 ottobre, tutte le altre date per le altre edizioni corrispondono a quel codice articolo.

**Fabrizio Paganelli:** qui adesso vedo vedo un un Excel che prima non non avevo non vedevo

**Elena Spini:** Ка.

**Fabrizio Paganelli:** visibile. però dovrebbe essere così. Esatto. Da a food marketing da a 27. Poi io io nei miei ordini posso avere anche 100.000 codici articolo. Se quest'ordine qui è stato staccato o come il 30 di aprile 26 andrà a finire nell'edizione Food Marketing Festival 26. Se invece quest'ordine qui è stato staccato il 30 di novembre 26, andrà a finire nell'edizione Food Marketing Festival

**Aurel mrruku:** Quello chiaro,

**Fabrizio Paganelli:** 27.

**Aurel mrruku:** però quando dici staccare l'ordine lì è la confusione.

  
  

### **00:52:36**

  

**Aurel mrruku:** Non stiamo parlando della quando l'ordine,

**Elena Spini:** diriga

**Aurel mrruku:** però quando si stacca la riga, la riga va insieme all'ordine. Tutte le righe vanno su con

**Elena Spini:** e la tranche.

**Fabrizio Paganelli:** Ho capito, le tranche avranno la stessa data ordine,

**Aurel mrruku:** l'ordine.

**Fabrizio Paganelli:** no? Tutte le tranche di un ordine. Fa ipotizzo un bundle che ho 20 righe articolo dentro. A prescindere da come poi dopo io deciderò di fare le tranche, le righe articolo di quel bundle avranno tutte la stessa data ordine in in base a quella data ordine

**Aurel mrruku:** Corretto? M avrà la data della tranche,

**Fabrizio Paganelli:** di No,

**Aurel mrruku:** non è la data

**Fabrizio Paganelli:** è la data dell'ordine, perché io le tranche ci servono a noi solo per definire i

**Aurel mrruku:** dell'ordine.

**Fabrizio Paganelli:** pagamenti. Quello che quello che comanda è la data dell'ordine. Io in un bundle avrò 20 righe.

**Aurel mrruku:** Nell'esempio che ha Andrea qua davanti, la riga 10 e la riga 11 avranno la stessa data.

  
  

### **00:53:37**

  

**Fabrizio Paganelli:** avranno la stessa data dell'ordine.

**Aurel mrruku:** Sì,

**Fabrizio Paganelli:** Esatto.

**Aurel mrruku:** però la riga 11 deve essere associata con l'edizione 27, però la data se tu la data è la stessa,

**Fabrizio Paganelli:** Esatto.

**Aurel mrruku:** come fa a capire se la prima se la riga 10 è sul 26 la riga 11 Yes. Il

**Fabrizio Paganelli:** Ma scusate, eh,

**Aurel mrruku:** 27.

**Fabrizio Paganelli:** se qui di fianco a a se in questa tabella gli mettiamo anche la data dell'ordine, queste qui sono le righe articolo,

**Aurel mrruku:** Metti eh sotto il 10 e 11 sono le righe d'articol.

**Fabrizio Paganelli:** giusto?

**Aurel mrruku:** Sopra sono le campagne,

**Fabrizio Paganelli:** Esatto.

**Aurel mrruku:** sono gli eventi.

**Fabrizio Paganelli:** Esatto. Se se qui mettiamo se qui in questa tabella qui di fianco gli mettiamo la data dell'ordine

**Aurel mrruku:** Metti anche Ma metti, non so

**Elena Spini:** oggi

**Aurel mrruku:** oggi

**Elena Spini:** Sì.

**Aurel mrruku:** 2608 che non se mai. Metti anche sotto. Ok.

  
  

### **00:54:48**

  

**Fabrizio Paganelli:** Bene, queste due righe articol data ordine 26 agosto 26. Io vado nella tabella di sopra, vedo che che il 26 agosto 26 è associato alla riga 5.

**Aurel mrruku:** Sì,

**Fabrizio Paganelli:** A queste due righe articolo gli associo l'edizione Food Marketing Festival 27.

**Aurel mrruku:** corretto. Tutte e due avranno 27.

**Fabrizio Paganelli:** Sì, però eh adesso qui questo qui è semplificato. Se noi proviamo a fare un bundle,

**Aurel mrruku:** Eh

**Fabrizio Paganelli:** io qui potrei avere, ad esempio, eh qui ad esempio puoi mettere un EPTAM e un Food Marketing Festival. Mettete pure a piacere la data dell'ordine.

**Aurel mrruku:** Mettigli la stessa

**Fabrizio Paganelli:** Ok.

**Aurel mrruku:** Sì,

**Fabrizio Paganelli:** Io chiaramente qua sopra dovrò dovrò avere popolato anche una stessa

**Aurel mrruku:** la campagna sì per il Food Marketing

**Fabrizio Paganelli:** tabella.

**Aurel mrruku:** Festival. Ma lasciale uguale. Fa niente, Andre. Oppure vuoi mettere 27 Marking Festival, vuoi mettere il 2728? Puoi giocare sulla data del team a sto punto?

  
  

### **00:56:54**

  

**Aurel mrruku:** E sotto sarebbe 26. Sì, corretto.

**Fabrizio Paganelli:** Perché, ad esempio, da qui si vede bene come ragioniamo. Noi adesso faremo il Food Marketing Festival il 30 di settembre, faremo il Food Marketing Festival 26. Durante quell'evento noi venderemo una serie dei bundle al al all'interno dei quali ci saranno tutti i codici articolo degli eventi di pianissimo. Ehm e da qui all'anno prossimo. Però, ad esempio, ci sarà il codice articolo Spinissimo Live che ci sarà a novembre del 26, quando io stacco quell'ordine in data 30 nov 30, scusate 30 settembre 26 il pienissimo live, adesso qui non c'è, ma ci sarà pienissimo live 2026 che avrà da data a data dal primo dicembre 25 al 30 di novembre.

**Aurel mrruku:** Ok,

**Fabrizio Paganelli:** 26 Quindi

**Aurel mrruku:** allora mi è chiaro, forse ho capito più facile di quello che stavamo discutendo, quindi basta che la fascia delle date degli eventi li metti eh praticamente non vuol dire che Epam 2026 abbia le date del 2026. Tu puoi mettere data a piacere e quando viene staccato l'ordine va a controllare le

  
  

### **00:58:25**

  

**Fabrizio Paganelli:** Sì.

**Aurel mrruku:** date. Non vuol dire che sono del 2026, possono essere date messe a piacere. Quindi se voi siete bravi a configurare le date, io mi baso solo su quelle date e siamo tranquilli.

**Fabrizio Paganelli:** Esattamente.

**Aurel mrruku:** Ok,

**Andrea Di Cicco:** Ah.

**Fabrizio Paganelli:** Noi dobbiamo essere svizzeri nella gestione di questa

**Aurel mrruku:** quindi eh gli ha dato delle campagne

**Elena Spini:** Date

**Fabrizio Paganelli:** tabella.

**Aurel mrruku:** figlie Elena. Quindi, praticamente non mettono il flag campagna attiva, però mettono è la stessa cosa alla fine,

**Elena Spini:** ok

**Aurel mrruku:** mettono solo le date, faccio io il check nel momento in cui si genera l'ordine a quale campagna Figlia si deve collegare.

**Elena Spini:** capiamo sì questa cosa perché poi in realtà avevamo pensato di fare la logica di post evento, quando quindi la campagna è finita perché campagna finita vuol dire che l'evento è stato fatto. Dopo 3 giorni mettere tutti i biglietti a non consumati quelli che

**Aurel mrruku:** E è facile.

**Elena Spini:** non

**Aurel mrruku:** È facile perché post campagna tu c'hai la data di fine della campagna,

**Elena Spini:** Ok?

  
  

### **00:59:35**

  

**Aurel mrruku:** quindi tu fai dei da a da a

**Elena Spini:** Quindi questo da A non è la data di inizio fine campagna.

**Aurel mrruku:** è data a fine campagna figlia.

**Fabrizio Paganelli:** Allora,

**Elena Spini:** Sì, perché prima hai detto le date a caso.

**Fabrizio Paganelli:** intendiamoci bene, intendiamoci bene perché da a io Io la intendo data

**Aurel mrruku:** Ok,

**Fabrizio Paganelli:** dell'ordine. Ok. da A, io intendo data ordine edizione è la mia

**Aurel mrruku:** mettiamo mettiamo anche un'altra data.

**Fabrizio Paganelli:** campagna,

**Aurel mrruku:** Non non ci costa niente perché li stiamo configurando a mano.

**Elena Spini:** Infatti la la terrei

**Fabrizio Paganelli:** tipo qui nella colonna G si può inserire data dell'evento e dove dopo anche che anche

**Elena Spini:** diversa.

**Fabrizio Paganelli:** qui noi glielo metteremo a mano.

**Aurel mrruku:** No.

**Elena Spini:** Sì, infatti.

**Fabrizio Paganelli:** Noi sappiamo che il full marketing dal 27 ci sarà il 30 di settembre, lì gli mettiamo 30 settembre.

**Elena Spini:** Sì, meglio.

**Fabrizio Paganelli:** Esatto. Nel Full Marketing Festival 26.

**Elena Spini:** Così noi facciamo la logica della disattivazione eventuale di chi non è arrivato.

  
  

### **01:00:31**

  

**Elena Spini:** Disattivazione che non si sono presentati sulla logica di data

**Fabrizio Paganelli:** Eh, esatto.

**Elena Spini:** evento.

**Fabrizio Paganelli:** Però questo qui è un aspetto che viene dopo l'evento a posteriori.

**Elena Spini:** Sì, sì,

**Fabrizio Paganelli:** Tutto quello che se prima noi lo dobbiamo gestire in base alla data dell'ordine.

**Elena Spini:** sì,

**Aurel mrruku:** Corretto,

**Fabrizio Paganelli:** No.

**Aurel mrruku:** corretto.

**Elena Spini:** ok.

**Aurel mrruku:** È

**Andrea Di Cicco:** Comunque sollevo solo un punto per, cioè nel senso la logica così funziona.

**Aurel mrruku:** chiaro.

**Andrea Di Cicco:** L'unica restrizione è che se in futuro vorrete fare un bundle, che penso fosse questa un po' la cosa che aveva confuso Aurel, cioè tu immagina vuoi fare un band che si chiama Big Happy Team che ti dà i biglietti per il 2026 2027-202 in quell'ordine non riesci a gestire le edizioni perché te li andrà a mettere tutti quanti nell'edizione in cui tu sei andato a comprare i biglietti.

**Fabrizio Paganelli:** No,

**Andrea Di Cicco:** Ok,

**Fabrizio Paganelli:** noi questa qui è una cosa che non facciamo. Non facciamo.

**Andrea Di Cicco:** ok, ok.

**Fabrizio Paganelli:** Magari può succ quello che può succedere e e mi riallaccio a quello che diceva prima Elena, può succedere che una persona non viene all'evento.

  
  

### **01:01:37**

  

**Fabrizio Paganelli:** Ah,

**Andrea Di Cicco:** Mm.

**Fabrizio Paganelli:** mi sono stato male, non sono potuto venire, è un cliente bravo, eccetera eccetera, spende tanto. Noi che cosa facciamo? Anziché bruciarglielo quel biglietto e annullarglielo, glielo andiamo a riassegnare e e glielo mettiamo disponibile per l'evento futuro, capito? Noi capita che c'è qualche cliente che non viene, però sono è una gestione che facciamo, diciamo, manualmente di andargli è come se gli dessimo un biglietto omaggio per l'edizione successiva. Non so se riesco a spiegargli.

**Andrea Di Cicco:** Sì, sì, sì. No, è chiaro, è chiaro.

**Aurel mrruku:** A man. A sto punto gli dobbiamo dare anche la possibilità di collegare nel momento in cui li generi questo biglietto a mano di collegare anche il biglietto alla campagna figlia successiva, quindi all'evento successivo, perché c'è l'automatismo. Poi se non si presenta anche il secondo evento gli devi mandare la notifica. Non so se vi è chiaro, Elena,

**Elena Spini:** Mi sono distratta, scusa. Sto facendo tardi un'altra riunione,

  
  

### **01:02:49**

  

**Aurel mrruku:** allora stavo dicendo,

**Elena Spini:** mi sono persa. Sto scrivendo, sono in ritardo.

**Aurel mrruku:** no,

**Elena Spini:** Vai.

**Aurel mrruku:** stavo dicendo che praticamente se si fa un cambiamento manuale Hi. del biglietto, quindi dell'asset. Noi l'asset lo dobbiamo collegare anche alla campagna figlia, quindi anche all'evento successivo, altrimenti rischi che non lo colleghi all'evento successivo e l'automatismo che il reminder se non si presenta non scatta

**Elena Spini:** Sì,

**Aurel mrruku:** più.

**Elena Spini:** mi torno.

**Aurel mrruku:** Ok.

**Elena Spini:** altra casistica aggiunta

**Aurel mrruku:** Almeno è chiaro.

**Andrea Di Cicco:** Ok.

**Elena Spini:** e io devo volare da un'altra parte

**Andrea Di Cicco:** Ok. E io chiedo un attimo una cosa a Fabrizio.

**Elena Spini:** e vai.

**Andrea Di Cicco:** Fabrizio, adesso provo a fare dei test.

**Elena Spini:** Grazie. Co?

**Andrea Di Cicco:** Ciao Elena.

**Fabrizio Paganelli:** Ciao.

**Andrea Di Cicco:** Provo a fare dei test.

**Elisa Migliano:** Tchau.

**Fabrizio Paganelli:** Co.

**Andrea Di Cicco:** Ciao, prova a fare dei test in produzione e ti mando degli ID dei clienti perché non voglio rompe niente,

**Fabrizio Paganelli:** M.

  
  

### **01:04:01**

  

**Andrea Di Cicco:** perché però purtroppo solamente in produzione posso fare i test. Eh, ti mando poi gli ID dei clienti che ho creato.

**Fabrizio Paganelli:** Sì.

**Andrea Di Cicco:** Ehm, quindi solo se me li puoi controllare se sono stati creati correttamente, che c'hanno tutti i campi e che non ho distrutto niente, insomma.

**Fabrizio Paganelli:** Mh.

**Andrea Di Cicco:** Eh ah

**Fabrizio Paganelli:** mi rimandi già oggi

**Andrea Di Cicco:** se tu mi dici,

**Fabrizio Paganelli:** oppure?

**Andrea Di Cicco:** "Guarda, io sto per staccare, te li faccio domani mattina senza

**Fabrizio Paganelli:** Ehm,

**Andrea Di Cicco:** problemi".

**Fabrizio Paganelli:** allora, perché io non sono in ufficio questi giorni,

**Andrea Di Cicco:** Ah,

**Fabrizio Paganelli:** a meno che metti scrivi sia a me fabrizio.

**Andrea Di Cicco:** ok.

**Fabrizio Paganelli:** Ad amministrazione@ che legge l'Elisa, dopo troviamo il modo di darci un'occhiata.

**Andrea Di Cicco:** Ok. Ah, ok, ok. Scusa, non sapevo che non stavo in ufficio. Ok. Eh, va bene,

**Fabrizio Paganelli:** Ok.

**Andrea Di Cicco:** perché più che altro perché dobbiamo chiudere un attimo il giro su, cioè devo fare dei test veri e non vorrei, siccome è produzione, mi preoccupa un po' sempre fare i test,

  
  

### **01:05:06**

  

**Fabrizio Paganelli:** Oppure se li fai adesso,

**Andrea Di Cicco:** quindi

**Fabrizio Paganelli:** proprio dopo la la riunione, magari rimaniamo collegati e lo lo guardiamo in modo istantaneo, se

**Andrea Di Cicco:** eh come vuoi,

**Fabrizio Paganelli:** vuoi.

**Andrea Di Cicco:** se vuoi, tanto io ce li ho pronti, quindi

**Fabrizio Paganelli:** Ah, possiamo anche fare così. Io volevo però prima finire un attimino il giro dell'anagrafica articoli, perché sempre le altre volte avevamo detto con Aurel di diciamo di gestire nell'anagrafica anche un flag che

**Andrea Di Cicco:** Mhm.

**Fabrizio Paganelli:** quel codice sia visibile solo nei bundle, sì o no?

**Andrea Di Cicco:** Ok.

**Fabrizio Paganelli:** E un altro che ci serve è il tipo biglietto. Siccome noi sostanzialmente abbiamo esaurito i campi su Mexal, questi ulteriori due, diciamo, elementi li possiamo gestire a mano S. su Salespo aggiuntivo su CESP che non arriva da

**Aurel mrruku:** Sì, eh sì, senza problemi.

**Fabrizio Paganelli:** Mexal.

**Aurel mrruku:** Ovviamente poi non se vuoi due prodotti come abbiamo fatto per fare i test, uno per generare il biglietto e l'altro per non generare il biglietto, devi per forza avere due prodotti, non lo puoi fare un unico prodotto, capito?

  
  

### **01:06:23**

  

**Aurel mrruku:** Quindi devi generare due codici diversi, anche se è lo stesso prodotto. Questo

**Fabrizio Paganelli:** Sì, sì, sì, sì, certo. Cioè io se un codice articolo è visibile,

**Aurel mrruku:** intendevo.

**Fabrizio Paganelli:** se non è il bundle, avrà il codice A. L'altro codice che è visibile a tutor avrà il codice B. Questo è chiaro.

**Aurel mrruku:** Sì.

**Fabrizio Paganelli:** Sì.

**Aurel mrruku:** Quindi devi creare due prodotti lato Mexal scendono su

**Fabrizio Paganelli:** Next.

**Aurel mrruku:** Sales Force.

**Fabrizio Paganelli:** Sì.

**Aurel mrruku:** Uno dei due gli metti il flag visibile per bundle.

**Fabrizio Paganelli:** Ok. Va bene. Dopo adesso io vi volevo fare vedere anche quest'altra cosa che non so, magari voi magari mi potete dare voi un suggerimento per quasi quasi vi posso condividere lo

**Andrea Di Cicco:** Certo.

**Fabrizio Paganelli:** schermo.

**Aurel mrruku:** Sì.

**Fabrizio Paganelli:** Qui noi abbiamo Ecco, vedete?

**Aurel mrruku:** Ecco, adesso sì.

**Fabrizio Paganelli:** Qui noi abbiamo un ulteriore campo che si chiama è questo qua, il gruppo merceologico. Il gruppo merceologico è un un elemento che può essere gestito a gerarchie, vedete?

  
  

### **01:07:38**

  

**Fabrizio Paganelli:** Codice livello padre e il figlio, eccetera eccetera. In base a tutto quello che ci siamo detti fino ad ora. Ehm, perché io potrei anche metterlo qui visibile solo in bundle, sì o no, tipo biglietto, eh, però non lo so voi m come la vedete voi questa cosa qui su su tramite le api, voglio dire, scusate.

**Aurel mrruku:** Allora

**Andrea Di Cicco:** Sulle PI ci dovrebbe essere il campo merch questo è sempre Happy Team

**Fabrizio Paganelli:** Sì. Ah, però qui,

**Andrea Di Cicco:** livello.

**Fabrizio Paganelli:** scusa. Ah, sì. Gruppo merceologico uno gli ho messo. Sì.

**Andrea Di Cicco:** Sì, infatti vedo uno codice. Sì,

**Aurel mrruku:** Kom. GRP merch, vero?

**Andrea Di Cicco:** sì, sì,

**Aurel mrruku:** Andre.

**Andrea Di Cicco:** vedo uno. Ho livello livello non lo vedo. Po. No, vedo solo il valore di prima.

**Fabrizio Paganelli:** Solo solo questo,

**Andrea Di Cicco:** Solo uno.

**Fabrizio Paganelli:** solo questo qui,

**Andrea Di Cicco:** Sì,

**Fabrizio Paganelli:** vedi? Mh, provo, aspetta,

**Andrea Di Cicco:** sì,

  
  

### **01:09:16**

  

**Fabrizio Paganelli:** voglio fare una prova.

**Aurel mrruku:** M.

**Fabrizio Paganelli:** Se provo a cambiarlo, provo a vedere se adesso vedi due.

**Andrea Di Cicco:** vediamo. Sì.

**Fabrizio Paganelli:** Ok. Eh, va bene dai, però ecco, rimane il fatto che dovremmo gestire alcuni campi all'interno dell'anagrafica prodotto di Sesfold, dovremmo gestire alcuni campi eh che non derivano da da Mexal perché Mexal non ha sufficienti classificatori statistici, non so

**Aurel mrruku:** Eh, guarda, possiamo anche fare una cosa che è un po'

**Fabrizio Paganelli:** M.

**Aurel mrruku:** complessa, ma se ci sono due flag, per esempio, tipo eh generazione biglietto e bundle possiamo mettere 1 generazione biglietto no bundle 2 no generazione biglietto no bundle 3 no generazione biglietto bundle e 4 generazione biglieto e bundle quindi combini facciamo una combinazione di quattro valori per definire due casi

**Fabrizio Paganelli:** Ah,

**Aurel mrruku:** Così.

**Fabrizio Paganelli:** quindi tu mi stai dicendo qui nella natura, in questa natura qui creo quattro codici che coprono tutti i vari

**Aurel mrruku:** Sì, sì,

**Fabrizio Paganelli:** casi.

**Aurel mrruku:** sì. Ovviamente se sono o se sono tre casistiche poi diventano otto

  
  

### **01:11:05**

  

**Fabrizio Paganelli:** Ah, chiaro, chiaro.

**Aurel mrruku:** codici.

**Fabrizio Paganelli:** Diciamo che sì, effettivamente potremmo utilizzare, intanto abbiamo genera biglietto che può essere sì o no,

**Aurel mrruku:** Sì.

**Fabrizio Paganelli:** tipo biglietto che può essere eh, scusate, è visibile se nei bundle, sì o no? È fine,

**Aurel mrruku:** E fine,

**Fabrizio Paganelli:** eh.

**Aurel mrruku:** infatti 1 2 3 4 e in base a quello che ci passa sappiamo se è un band, se deve essere visto sul bandle e se deve generare un biglieto.

**Fabrizio Paganelli:** Eh, e poi Ah, sì, così, diciamo, con questi tre campi qui possiamo definire eh genera

**Aurel mrruku:** No.

**Fabrizio Paganelli:** biglietto e visibile bundle, l'evento che lo metteremo eh l'evento che lo metteremo qui e poi magari posso possiamo utilizzare il gruppo merciologico per mettere il tipo di biglietto.

**Aurel mrruku:** Sì.

**Fabrizio Paganelli:** era il terzo.

**Aurel mrruku:** Tipo di quanti tipi di biglietti erano?

**Fabrizio Paganelli:** Ah, c'è eh Executive e sono due o tre executive

**Aurel mrruku:** No,

**Fabrizio Paganelli:** Gold e Diamond. Altre cose, Lisa, che adesso non mi vengono in

  
  

### **01:12:12**

  

**Aurel mrruku:** perché io preferisco di usare Eh,

**Fabrizio Paganelli:** mente,

**Aurel mrruku:** vabbè, se sono tre meglio se lasciamo un campo a sé.

**Fabrizio Paganelli:** eh.

**Aurel mrruku:** Stavo pensando di mettere gener biglietto. Sì, no. E poi eh tutto il resto è è più facile. Per esempio, se è zero genera biglietto, no? Se da uno in su sono tipologie di biglietti.

**Fabrizio Paganelli:** Sì,

**Aurel mrruku:** Vedo Andrea che no il

**Fabrizio Paganelli:** dopo c'è anche visibile solo in bundle M

**Aurel mrruku:** bundle,

**Fabrizio Paganelli:** si

**Aurel mrruku:** il campo natura lasciamo per il bundle.

**Andrea Di Cicco:** No.

**Aurel mrruku:** Invece l'altro campo diciamo se è zero genera biglietto

**Fabrizio Paganelli:** Mm.

**Aurel mrruku:** è non è false, se è uno è una tipologia di biglietto, se due è un'altra tipologia di biglietto e così via.

**Andrea Di Cicco:** Boh. Secondo me poi diventa un po' complicato,

**Fabrizio Paganelli:** Ah.

**Andrea Di Cicco:** però voi, cioè e se deve sta nel bundle e

**Aurel mrruku:** Perché Andre il

**Andrea Di Cicco:** generare un

  
  

### **01:13:26**

  

**Aurel mrruku:** bando ha il campo a

**Andrea Di Cicco:** biglietto

**Aurel mrruku:** sé.

**Andrea Di Cicco:** e se un evento non genera tipologie di biglietti, ma sono tutti standard.

**Aurel mrruku:** Ma se una tipologia di biglietto vuol dire che c'è il biglietto deve essere generato o mi sbaglio?

**Andrea Di Cicco:** Sì, quello

**Fabrizio Paganelli:** Adesso magari Noi facciamo una prova,

**Andrea Di Cicco:** sì.

**Fabrizio Paganelli:** facciamo una prova come in base alle regole che c di cui abbiamo detto fino ad ora. Tanto creerò dei codici articolo nuovi,

**Aurel mrruku:** Ja.

**Fabrizio Paganelli:** per cui non

**Andrea Di Cicco:** Ok.

**Fabrizio Paganelli:** mh e poi magari dopo una volta che l'abbiamo fatto, una volta che anche la direzione ci ha provato la cosa eh magari facciamo un test.

**Aurel mrruku:** Ok.

**Fabrizio Paganelli:** io dai conto che nella prossima settimana questo questo lavoro sul codice articolo di terminarlo, insomma. Va bene. Eh,

**Andrea Di Cicco:** Ok,

**Fabrizio Paganelli:** se vogliamo provare il discorso del dell'anagrafica articoli, io ci sono, insomma. Eh, scusate, della dell'anagrafica

**Andrea Di Cicco:** allora ti rubo lo schermo.

**Fabrizio Paganelli:** clienti.

  
  

### **01:14:56**

  

**Andrea Di Cicco:** Dimmi se vedi.

**Fabrizio Paganelli:** Sì. M.

**Andrea Di Cicco:** Allora, vediamo. Eh, non l'ho ancora sparata, quindi non so se funziona, però però sembra che è andato ok. E il codice cliente. Ah no, scusate, ho fatto una ricerca. Niente s centrore gestionale tipo nazionalità errato pure Questo mandatorio.

**Fabrizio Paganelli:** Questo qui è un campo che è fondamentale per noi,

**Andrea Di Cicco:** Sì. No, pensavo codice paese fosse

**Fabrizio Paganelli:** eh, perché nella normativa sammarinese questo qui,

**Andrea Di Cicco:** sufficiente.

**Fabrizio Paganelli:** tipo nazionalità, nell'anagrafica, diciamo, nella nella schermata di Mexal, si chiama residenza fiscale.

**Andrea Di Cicco:** Ah, ok.

**Fabrizio Paganelli:** Ed è fondamentale perché dobbiamo sempre distinguere tra Italia, San Marino, ci sono ci sono alcuni elementi, sono Italia, San Marino,

**Andrea Di Cicco:** Ok.

**Fabrizio Paganelli:** città del Vaticano, Unione Europea ed extra Unione Europea. Per noi distinguere in base alla al codice del paese distinguere questi cinque elementi è fondamentale perché impatta sulle regole di trasmissione delle fatture all'ufficio tributario.

**Andrea Di Cicco:** E invece il codice listino.

  
  

### **01:17:06**

  

**Fabrizio Paganelli:** il codice listino. Puoi mettere l'uno perché noi gestiamo, fammi vedere che che perché noi gestiamo un attimo,

**Andrea Di Cicco:** Ah,

**Fabrizio Paganelli:** eh, vado dentro una una un cliente

**Andrea Di Cicco:** ok. Che poi noi sui prodotti abbiamo due listini,

**Fabrizio Paganelli:** e Sì,

**Andrea Di Cicco:** uno e due,

**Fabrizio Paganelli:** puoi Sì,

**Andrea Di Cicco:** è quello a cui si riferisce.

**Fabrizio Paganelli:** puoi usare l'uno perché ci stiamo

**Andrea Di Cicco:** E qu E quand'è che usate l'uno e quand'è che usate il due invece?

**Fabrizio Paganelli:** usiamo solo l'uno.

**Andrea Di Cicco:** Ah, ok. data codice. Ah, questo deve essere un numero. Valuta essere errato. essere contro. preso troppo. Tutti sti campi non c'erano sulla documentazione. Valuta. Mettiamo uno. Proviamo. Ok. dovrebbe averlo creato. Il codice cliente è 501.08721

**Fabrizio Paganelli:** 08 8

**Andrea Di Cicco:** 72.

**Fabrizio Paganelli:** 721 Non lo vedo.

  
  

### **01:18:36**

  

**Andrea Di Cicco:** Sì.

**Fabrizio Paganelli:** Aspetta eh che faccio un refresh. 08721. Sì. Test

**Andrea Di Cicco:** M esatto.

**Fabrizio Paganelli:** Roni.

**Andrea Di Cicco:** Ok. Eh,

**Aurel mrruku:** Perfetto.

**Andrea Di Cicco:** posso creare pure un ordine oppure mi picchi?

**Fabrizio Paganelli:** No, no, non c'è problema con quello.

**Andrea Di Cicco:** Ok.

**Fabrizio Paganelli:** Sì.

**Aurel mrruku:** Ma su Riga cosa hai messo?

**Andrea Di Cicco:** E il di riga sono serve per identificare la riga.

**Aurel mrruku:** Andre

**Andrea Di Cicco:** Questo qui è tutta la struttura che serve poi per andare a gestire le singole fatture nel caso di bundle, quando vengono fatte trance diverse con fatture diverse.

**Aurel mrruku:** fa una mappatura una n invasa alla tranche e il

**Andrea Di Cicco:** Sì. Mh mh yes e

**Aurel mrruku:** prodotto mi devi spiegare sta roba. Grazie.

**Andrea Di Cicco:** leggi il

**Fabrizio Paganelli:** Dopo Andrea su questa cosa qui dell'anagrafica clienti, magari ci riserviamo un'altra oretta io, te e le anche Aurel e l'Elisa, perché ci sono alcuni aspetti tipo la categoria provvigioni, eccetera eccetera eccetera dove è bene che li svisceriamo prima.

  
  

### **01:20:22**

  

**Andrea Di Cicco:** Eh, Esatto. No, perché poi sull'Excel io avevo messo tutti i campi che al momento voi condividete con eh con Zoo,

**Fabrizio Paganelli:** Sì.

**Andrea Di Cicco:** però io immagino che poi ci sono dei campi in più che magari voi volete su Sales Force che devono essere portati su Mexal e viceversa e stessa cosa pure qui sulla creazione cliente. Comunque nel frattempo si è creato l'ordine, eh OC11. Ehm, perché pure qui valuta valuta uno, però per me il codice uno, devo capire che cosa significa, cioè se uno è euro oppure uno è dollaro.

**Fabrizio Paganelli:** M.

**Andrea Di Cicco:** Quindi questo qui poi sono cose che dobbiamo un attimino capire,

**Fabrizio Paganelli:** Sì, sì.

**Andrea Di Cicco:** però già che funziona la struttura già

**Fabrizio Paganelli:** L'ordine

**Andrea Di Cicco:** è Sì.

**Fabrizio Paganelli:** passato.

**Andrea Di Cicco:** E questo non ti dà fastidio a livello di perché mh come si chiama? Mirko mi aveva detto di inserirlo sulla serie 10 invece che su serie 1,

**Fabrizio Paganelli:** Mh.

**Andrea Di Cicco:** quindi non dovrebbe darti fastidio con produzione. Questo poi non lo so.

**Fabrizio Paganelli:** No, no, non non c'è problema.

**Andrea Di Cicco:** E

  
  

### **01:21:40**

  

**Fabrizio Paganelli:** Lo lo vedo in effetti sulla serie

**Andrea Di Cicco:** ok.

**Fabrizio Paganelli:** 10,

**Andrea Di Cicco:** Ma ti ha ti ha già generato la fattura poi a te?

**Fabrizio Paganelli:** però no.

**Andrea Di Cicco:** No. Ok.

**Aurel mrruku:** Vedo che l'ordine in il tipo è il sospeso,

**Fabrizio Paganelli:** No.

**Aurel mrruku:** quindi di

**Andrea Di Cicco:** Come?

**Aurel mrruku:** tipo tipo No,

**Andrea Di Cicco:** Ah, perché l'hai

**Aurel mrruku:** no,

**Andrea Di Cicco:** richiamato?

**Aurel mrruku:** vedo sulla schermata di Fabrizio vedo S sospeso.

**Andrea Di Cicco:** Ah\!

**Fabrizio Paganelli:** M No,

**Aurel mrruku:** Ok,

**Fabrizio Paganelli:** questo qui non Nel momento in cui poi dopo io vado a trasformare quest'ordine qui in fattura, eh, va direttamente in con un altro flag e passa la fattura.

**Aurel mrruku:** quindi

**Fabrizio Paganelli:** Non se apro questo qui,

**Aurel mrruku:** ok.

**Fabrizio Paganelli:** vedi? Anche questo qui ha lo stato qui di sospeso, ma nelle righe articolo ce l'hai.

**Aurel mrruku:** Ok,

**Fabrizio Paganelli:** E, vedi questo qui io riesco a trasformarlo direttamente in fattura.

**Aurel mrruku:** quindi ho capito.

  
  

### **01:22:42**

  

**Andrea Di Cicco:** Ma ma la fattura la vuoi generare tu o te la devo mandare io?

**Aurel mrruku:** Ja.

**Fabrizio Paganelli:** No, la fattura eh per il momento facciamo che la la pilotiamo noi da Mexal,

**Andrea Di Cicco:** Ok,

**Fabrizio Paganelli:** poi dopo magari questo potrebbe essere uno sviluppo da fare tra 6 mesi quando entreremo a regime e e capiremo eventuali ulteriori automatismi, ma per il momento preferisco che venga pilotata solo da Mexal la fatturazione.

**Andrea Di Cicco:** ok, ok. No, era solo perché ehm l'avevo, cioè l'avevo trovato il Jason, però se mi dici così meglio perché è abbastanza complesso, quindi

**Fabrizio Paganelli:** Sì, sì, sì. Però ecco, vedete ancora il mio schermo? E qui, ad esempio, io adesso apro un ordine buono.

**Aurel mrruku:** Sì.

**Andrea Di Cicco:** Quindi

**Fabrizio Paganelli:** Qui ci sono tutta una serie di numeri che vengono prealimentati e che devono seguire determinate regole. Quindi magari è quello che è per questo che vi dicevo se di riservarci un'oretta in più anche per vederli passo passo, ehm perché poi dopo altrimenti ci si blocca la fatturazione se questi determinati campi non

**Andrea Di Cicco:** Ok.

**Fabrizio Paganelli:** sono configurati in modo corretto.

  
  

### **01:23:56**

  

**Fabrizio Paganelli:** Tipo, tipo anche qui vedete la causale, eh il numero questo uno qui, questo qui è un sezionale, quindi sono tutti regole che impattano sugli aspetti fiscali barra dell'ufficio tributario che è bene che mappiamo tutti prima di di andare a regime. Ecco, qui ad esempio su un'anagrafica articoli,

**Andrea Di Cicco:** Mhm.

**Fabrizio Paganelli:** visto che prima su un'anagrafica clienti e in quella in quel in quell'articolo 501 08721, qui ci sono ulteriori sottoschermate tipo condizioni documenti di

**Andrea Di Cicco:** Sì.

**Fabrizio Paganelli:** magazzino dove oltre al listino di vendita deve essere alimentato la gente, deve essere alimentato questo campo qui che definisce diciamo una categoria provvigione.

**Andrea Di Cicco:** Mhm.

**Fabrizio Paganelli:** Questo qui a noi c'è necessario per fare il calcolo delle provigioni

**Andrea Di Cicco:** Ok,

**Aurel mrruku:** Ok,

**Fabrizio Paganelli:** e quindi eh

**Andrea Di Cicco:** va bene dai. Allora,

**Fabrizio Paganelli:** eh sì

**Andrea Di Cicco:** poi li rivediamo nel dettaglio quando torni.

**Fabrizio Paganelli:** sì,

**Andrea Di Cicco:** Va bene, ti lascio le tue ferie.

**Fabrizio Paganelli:** bene.

**Andrea Di Cicco:** Grazie.

**Aurel mrruku:** Grazie.

**Fabrizio Paganelli:** Sì. Ok. Ciao,

**Andrea Di Cicco:** Ciao.

**Fabrizio Paganelli:** grazie a tutti.

**Aurel mrruku:** Ciao.

**Andrea Di Cicco:** Ciao.

**Fabrizio Paganelli:** Ciao. Ciao Elisa, mi senti?

**Elisa Migliano:** Telefono. Ciao.

**Fabrizio Paganelli:** Ti chiamo.

**Elisa Migliano:** Sì, Fabri,

**Fabrizio Paganelli:** Chiamo un

**Elisa Migliano:** va bene, va bene. Ciao.

**Fabrizio Paganelli:** attimo.

  
  

### **Trascrizione terminata dopo 01:25:45**

  

*Questa trascrizione modificabile è stata generata dal computer e potrebbe contenere errori. È possibile anche modificare manualmente il testo dopo la creaz