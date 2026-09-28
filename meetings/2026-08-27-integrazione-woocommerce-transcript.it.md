# **ð Note**  

 ago 27, 2026

## **\[ROMI-PIENISSIMO\] - Integrazione WooCommerce**

invitato [Elena Spini](mailto:e.spini@romicompany.com) <sabatino.r@pienissimo.com> [Aurel mrruku](mailto:a.mrruku@romicompany.com) [Andrea Di Cicco](mailto:a.dicicco@romicompany.com) <amministrazione@pienissimo.com> <fabrizio.p@pienissimo.com>

Allegati [\[ROMI-PIENISSIMO\] - Integrazione WooCommerce](https://calendar.google.com/calendar/event?eid=NWM5bzV0OHExZGZxcWxkMnIwcm4ya2tqMjggZS5zcGluaUByb21pY29tcGFueS5jb20)

Record delle riunioni [Trascrizione](https://docs.google.com/document/d/1EgEzGO3qtD8r0eC_uleobil6WnJgknpRvoZDG--IPIw/edit?usp=drive_web&tab=t.wz3ay4edz3nm) [Registrazione](https://drive.google.com/file/d/1UjJNRMmX73UGC-ZFOu_ngWIKJVSwDUwv/view?usp=drive_web) 

  
  

### **Riepilogo**

Definizione architettura Webhook per integrazione WooCommerce con Salesforce tramite analisi scenari operativi e test payload tecnici.  
  
**Architettura integrazione Webhook**  
Analisi sull'implementazione di webhook per la sincronizzazione dati tra WooCommerce e Salesforce. Scelta di utilizzare wrapper JSON strutturati per gestire la complessità delle informazioni.  
  
**Scenari e flussi operativi**  
Definizione di 3 scenari principali per la gestione di anagrafiche e ordini. Conferma del flusso end-to-end con integrazione dell'ID opportunità per i tracciamenti.  
  
**Pianificazione test tecnici**  
Decisione di validare l'invio dati tramite file PHP di test. Necessità di includere specifiche simulazioni di vendite da palco con valori elevati nei test tecnici.

  
  

### **Decisioni**

## **Concordato**

  - **Metodo di integrazione tecnica definito** L'integrazione tra WooCommerce e Salesforce sarà implementata tramite un plugin personalizzato che utilizza action hook PHP per inviare il payload al cambio di stato dell'ordine, superando le limitazioni dei webhook standard.
  - **Inclusione vendita da palco nei test** Le procedure di test tecnico per l'integrazione includeranno obbligatoriamente la simulazione della "vendita da palco" per garantire la corretta gestione delle transazioni ad alto valore.

  

Abbiamo **aggiornato la sezione Decisioni** in base al tuo feedback.

Facci sapere cosa ne pensi: [Utili](https://google.qualtrics.com/jfe/form/SV_5bXzKQfylMIhSXc?isHelpful=True&entryPoint=decisions&confid=OL__rOjoFvpkaCxdLQFRDxIXOBEBMgUIigIgABgDCA&isGoogler=False) o [Non utile](https://google.qualtrics.com/jfe/form/SV_5bXzKQfylMIhSXc?isHelpful=False&entryPoint=decisions&confid=OL__rOjoFvpkaCxdLQFRDxIXOBEBMgUIigIgABgDCA&isGoogler=False)

  
  

### **Passaggi successivi**

  - \[Sabatino Rinaldi, Aurel mrruku, Elisa Migliano\] Testare integrazione Webhook: Eseguire il test tecnico dell'integrazione tra WooCommerce e Salesforce. Verificare il corretto passaggio del payload tra i due sistemi.
  - \[Sabatino Rinaldi, Aurel mrruku\] Simulare vendite palco: Effettuare simulazioni specifiche per la vendita da palco durante la fase di test. Garantire il corretto funzionamento del flusso di acquisto e pagamento per questa modalità operativa.
  - \[Aurel mrruku\] Mappare campi Salesforce: Definire la mappatura corretta dei dati inviati dal webhook all'interno di Salesforce. Utilizzare la struttura dati validata dai test tecnici effettuati.

  
  

### **Dettagli**

  - **Obiettivi dell'integrazione tecnica di WooCommerce e architettura dei Webhook**: Elena Spini ha aperto la riunione focalizzandosi sull'integrazione tecnica di WooCommerce tramite l'uso di Webhook. Andrea Di Cicco ha posto il problema di stabilire quanti webhook implementare, proponendo di valutare la creazione di un webhook separato per le informazioni anagrafiche del cliente e uno per i dati dell'ordine, oppure un webhook unico per evitare la duplicazione dei campi con Mexal, tema ripreso anche da Sabatino Rinaldi. Aurel mrruku ha confermato la disponibilità a gestire la complessità dei dati tramite wrapper JSON strutturati, mentre Sabatino Rinaldi ha condiviso lo schermo per mostrare le impostazioni avanzate di WooCommerce dedicate ai Webhook.
  - **Definizione degli scenari di business per la gestione anagrafica e degli ordini**: Elena Spini ha delineato tre scenari operativi principali per l'integrazione: il primo riguarda un cliente nuovo non censito su Salesforce, per cui è prevista la ricezione completa di anagrafica aziendale, contatti e dati d'acquisto; il secondo riguarda un account già esistente su Salesforce, che richiede la sola creazione dell'ordine; il terzo scenario prevede il passaggio di un link generato da Salesforce contenente l'ID dell'opportunità associata a un'attività di recall, da integrare nel carrello di WooCommerce.
  - **Confronto tra Webhook e API e gestione dei trigger di stato degli ordini**: Sabatino Rinaldi ha espresso perplessità sull'uso dei Webhook rispetto alle API, ritenendo i primi più limitati nella gestione di informazioni complesse o esportazioni massive, basandosi sulla propria esperienza con la piattaforma Pienissimo. Aurel mrruku ha chiarito che i Webhook servono a trasmettere i dati verso Salesforce e ha chiesto come venga attivata la comunicazione, evidenziando la necessità di intercettare i cambiamenti di stato degli ordini (come lo stato di lavorazione o completamento) tramite azioni PHP personalizzate o hook di WordPress, dal momento che il sistema deve scrivere direttamente su Salesforce.
  - **Struttura del payload JSON e preparazione dei test tecnici tramite PHP**: Aurel mrruku e Sabatino Rinaldi hanno esaminato la struttura del payload JSON necessaria per mappare correttamente cliente, ordine e singole linee di prodotti sul sistema Salesforce. Sabatino Rinaldi si è impegnato a creare un endpoint e un file di test PHP (denominato SF tracker PHP) per verificare la trasmissione dei dati, concordando con Aurel mrruku l'esecuzione di un test rapido per validare l'invio dei dati prima di procedere con la mappatura definitiva dei campi.
  - **Integrazione dell'ID opportunità e conferma dei flussi operativi end-to-end**: Andrea Di Cicco ha verificato la gestione tecnica dell'ID dell'opportunità, e Aurel mrruku ha confermato il flusso funzionale in cui Salesforce genera un'opportunità che invia un'email con un link tracciato contenente l'ID; il cliente clicca sul link accedendo a WooCommerce, dove il completamento dell'ordine in un determinato stato innesca l'invio automatico dei dati a Salesforce, sia per i clienti già censiti sia per le nuove anagrafiche. Elena Spini ha approvato il flusso descritto.
  - **Simulazione delle vendite da palco e pianificazione della sessione di test pomeridiana**: Fabrizio Paganelli ha sollevato un punto critico, richiedendo esplicitamente di simulare nei test non solo acquisti standard di libri o streaming dal costo di 97 euro, ma soprattutto le vendite da palco tramite scansione di codici QR in sala, a causa della rilevanza economica notevole di tali transazioni (8.900 o 9.000 euro e oltre). Sabatino Rinaldi e Aurel mrruku hanno concordato sull'importanza della verifica tecnica di questa specifica casistica. Infine, Elena Spini ha organizzato una sessione di test operativa tra le 15:00 e le 17:00 (fissata alle 16:00) tra Sabatino Rinaldi e Aurel mrruku, con la partecipazione facoltativa di Elisa Migliano.

  
  

*Dovresti rivedere le note di Gemini per assicurarti che siano accurate.* [*Ricevi suggerimenti e scopri come Gemini prende appunti*](https://support.google.com/meet/answer/14754931)

*Qual è la qualità di* ***queste note specifiche?*** [*Rispondi a un breve sondaggio*](https://google.qualtrics.com/jfe/form/SV_5bXzKQfylMIhSXc?confid=OL__rOjoFvpkaCxdLQFRDxIXOBEBMgUIigIgABgDCA&detailLevel=standard&hasImages=False&entryPoint=footerMain&isGoogler=False)*? Facci sapere cosa ne pensi e quanto le note siano state utili per le tue esigenze.****  
***

# **ð Trascrizione***  
*

 ago 27, 2026

## **\[ROMI-PIENISSIMO\] - Integrazione WooCommerce - Trascrizione**

### **00:00:18**

  

**Aurel mrruku:** Buongiorno.

**Fabrizio Paganelli:** Ciao, buongiorno.

**Aurel mrruku:** Come va?

**Fabrizio Paganelli:** Si devono ancora collegare gli altri,

**Aurel mrruku:** Sì, sì.

**Fabrizio Paganelli:** vero? Ok.

**Andrea Di Cicco:** Ciao, buongiorno.

**Fabrizio Paganelli:** Ciao,

**Aurel mrruku:** Ciao

**Fabrizio Paganelli:** buondì.

**Aurel mrruku:** Andre.

**Andrea Di Cicco:** No.

**Elena Spini:** Ciao,

**Fabrizio Paganelli:** Ciao Elena.

**Elena Spini:** buongiorno. Come va?

**Fabrizio Paganelli:** Bene.

**Elena Spini:** Aspettiamo il buon Sabatino.

**Fabrizio Paganelli:** Eh

**Elena Spini:** M.

**Elisa Migliano:** Ciao a tutti.

**Elena Spini:** Ciao,

**Fabrizio Paganelli:** Ciao No.

**Elena Spini:** stiamo aspettando Sabatino.

**Elisa Migliano:** Lo devo andare a chiamare. Eh,

**Elena Spini:** Se puoi sì, volentieri.

**Fabrizio Paganelli:** Ja.

**Elena Spini:** Casomai si è dimenticato di noi. Grazie. Вот.

**Elisa Migliano:** Ok, dovrebbe entrare a breve in

**Elena Spini:** Sì,

**Elisa Migliano:** teoria.

**Elena Spini:** lo vedo. Eccolo. Hanno accettato. Sei muto. Te parli con noi.

**Sabatino Rinaldi:** Eccomi. Scusate, ma ero preso da 1000

  
  

### **00:04:46**

  

**Elisa Migliano:** Ups.

**Sabatino Rinaldi:** robe,

**Elena Spini:** Tranquillo, tranquillo. E buongiorno.

**Sabatino Rinaldi:** quindi

**Elena Spini:** Allora, faccio partire come al solito la registrazione.

**Sabatino Rinaldi:** Quindi

**Elena Spini:** Ecco. Ehm, dunque il focus di oggi deve essere la parte di integrazione tecnica di WooCommerce. Avevamo detto che avverrà tramite Webhook web, non dico bene?

**Elisa Migliano:** Sì.

**Elena Spini:** E e su questo lascio la parola a loro

**Elisa Migliano:** Yeah.

**Elena Spini:** e fate tutte domande che ci servono sapere, insomma, quello che manca. Avevamo detto che avremmo fatto ehm la configurazione del PHP e identificazione degli ID prodotti, eccetera. Quindi cerchiamo di capire tutte le parti fondamentali per questa per questi step. Mi taccio così.

**Andrea Di Cicco:** M.

**Elena Spini:** Non mi deridere Andrea che ti vedo.

**Andrea Di Cicco:** No, no, figurati, figurati, figurati.

**Fabrizio Paganelli:** M.

**Sabatino Rinaldi:** Arrivo.

**Andrea Di Cicco:** No, allora, eh dobbiamo capire innanzitutto quanti webhook vogliamo fare perché eh in teoria le informazioni che ci arrivano sono sia quelle del cliente sostanzialmente, sia le informazioni relative agli ordini. Quindi mh la cosa ottimale sarebbe farne uno per il cliente, per le informazioni anagrafica del cliente, uno invece relativo alle informazioni dell'ordine.

  
  

### **00:06:38**

  

**Andrea Di Cicco:** Ehm non so se su questo come che ne pensi, come la vedi e dobbiamo capire poi a livello di flusso quando si vanno a innestare in realtà all'interno del flusso su Wcommerce dove si vanno a innestare queste integrazioni, cioè in quale punto in quale

**Sabatino Rinaldi:** Ah, sì, è da capire perché per come l'avevamo vista l'altra volta con quel documento lì,

**Andrea Di Cicco:** Lio

**Sabatino Rinaldi:** mi sa che era in realtà tramite PI, quindi era direttamente un'altra roba e però non vedo particolari problemi fare con un web. Aspetta che cerco una cosa.

**Andrea Di Cicco:** se ne può fare anche uno unico. Poi pure tu, Aurel, non so che ne pensi se farne uno unico o farne due separati.

**Sabatino Rinaldi:** Så

**Aurel mrruku:** Io infatti dipende anche dalla complessità,

**Andrea Di Cicco:** Dipende.

**Aurel mrruku:** eh, perché ti un'occhiata quanti campi sono, che valori sono, se sono strutture su quel rapper. Per me non è che cambia tanto avere due rapper complessi oppure avere un rapper gigantesco. Poi ovviamente se ci sono problemi su uno, se fai solo una chiamata sono problemi su un rapper e su un'entità in qualche modo dobbiamo anche tracciarlo.

  
  

### **00:08:07**

  

**Sabatino Rinaldi:** Allora,

**Aurel mrruku:** No.

**Sabatino Rinaldi:** prendo il documento che avevamo fatto. Eccolo qua. Ci avete scritto sopra sul documento.

**Andrea Di Cicco:** Io

**Sabatino Rinaldi:** Ok. No,

**Andrea Di Cicco:** no.

**Sabatino Rinaldi:** perché

**Elena Spini:** Non penso, sai,

**Sabatino Rinaldi:** no era una No,

**Elena Spini:** perché ti dà problemi.

**Sabatino Rinaldi:** no, era una curiosità,

**Elena Spini:** Ok,

**Sabatino Rinaldi:** non non vedevo nulla di strano,

**Elena Spini:** ok.

**Sabatino Rinaldi:** eh. E ok, allora quindi come vogliamo Vogliamo procedere perché di base già il fatto che lo facciamo tramite web cambia un po' il giro del codice semplicemente del PHP, ma non penso sia un problema. Il più è cosa vogliamo fare in questa sessione. Vi creiamo già un webbook.

**Andrea Di Cicco:** Eh, cioè se riusciamo a arrivare fino a quel punto che poi lato nostro dobbiamo solamente rifare l'integrazione, cioè nel senso che abbiamo pronto tutto per per lo sviluppo, sarebbe la optimum,

**Sabatino Rinaldi:** Allora, creiamo il web.

**Andrea Di Cicco:** più che altro per capire le informazioni, la struttura quanto è grossa,

**Sabatino Rinaldi:** Sì, aspetta che accedo allo

**Andrea Di Cicco:** tutto,

  
  

### **00:09:43**

  

**Sabatino Rinaldi:** shop.

**Andrea Di Cicco:** anche perché poi il punto è che noi abbiamo l'integrazione con e-commerce e poi l'integrazione con Mexal, quindi poi dovremmo fare un attimo il un merge di quelle che

**Sabatino Rinaldi:** Ok,

**Andrea Di Cicco:** sono le informazioni che arrivano da WooCommerce, quelle che arrivano su Mexal onde evitare di creare 12.000 da campi e e ridurre il numero di campi.

**Sabatino Rinaldi:** eccolo qui. che abbiamo il sistema di email più lento della storia. site ecolo qui. Shop. Pienissimo. Ah\!

**Andrea Di Cicco:** M.

**Sabatino Rinaldi:** Sì, perché di base se noi facciamo il web a voi vi serve giustamente le informazioni del web, io devo modificare, presumo, il mio PHP e di base integrarlo in WooCommerce,

**Andrea Di Cicco:** Mhm.

**Sabatino Rinaldi:** quindi quello è il lavoro mio e tutto il resto è il lavoro vostro. Quindi WooCommerce impostazioni

**Andrea Di Cicco:** Yes.

**Sabatino Rinaldi:** e avanzate Webhook. Ah, mo guarda, vi condivido lo schermo, forse è meglio. Schermo due. Vai. Vedete?

**Aurel mrruku:** Sì.

**Andrea Di Cicco:** Yeah.

**Sabatino Rinaldi:** Facciamo aggiungi Webbook.

  
  

### **00:12:03**

  

**Sabatino Rinaldi:** Allora, voi già sapete i punti da toccare o ce li studiamo live?

**Andrea Di Cicco:** Eh, penso che ci dobbiamo studiare live. Non so se Elena avevi fatto già una pensata. Ok.

**Elena Spini:** Ma punti da toccare per dove

**Sabatino Rinaldi:** per creare il web,

**Andrea Di Cicco:** in quali punti mettere mettere

**Elena Spini:** si

**Sabatino Rinaldi:** cosa mettere,

**Andrea Di Cicco:** Webhook,

**Sabatino Rinaldi:** cosa qual è l'URL, anche perché poi in realtà essendo un Book.

**Andrea Di Cicco:** Eh,

**Elena Spini:** Cioè, allora Allora, secondo me abbiamo due scenari, poi non so se possono essere inglobati in uno unico. Io vi racconto quello che ci siamo detti finora. Noi abbiamo detto che c'è lo scenario in cui eh abbiamo il un cliente che compra qualcosa su WooCommerce, facciamo finta che noi non lo conosciamo su Sales Force, quindi è tutta una un una configurazione di anagrafica completamente nuova. Quindi mi arriva questo ordine da questo cliente che non conosco, quindi mi aspetto che devo ricevere tutta la parte dell'anagrafica, quindi chi è l'azienda, chi è il contatto e che cosa sta comprando. Scenario uno. Scenario due invece quando invece il l'account è l'azienda è un'azienda

  
  

### **00:13:32**

  

**Andrea Di Cicco:** Sì.

**Elena Spini:** esistente, conosco sia l'account che il tizio che sta comprando, quindi devo andare solo in creazione dell'ordine. scenario due, diciamo, questi erano i primi scenari che avevamo pensato. Poi si è aggiunto, diciamo, un terzo scenario per tutte quelle logiche di opportunity che devono essere fatte come se fossero un recall da tutor, che avevamo detto che dovevamo creare il link ehm direttamente ehm noi da Sales Force in un certo momento, cioè non è che noi creiamo il link, eh ci verrà passato il link, a questo link aggiungiamo il l'ID dell'opportunity che verrà verrà inserita nel link che dovremo passare a WooCommerce, no? Anzi, nel link che dovremo passare al cliente che poi sul carrello di VCM, giusto? Ok,

**Sabatino Rinaldi:** Sì.

**Aurel mrruku:** Sì.

**Elena Spini:** quindi ora mh rispetto a

**Andrea Di Cicco:** Quindi ci

**Elena Spini:** questo a a questo giro,

**Andrea Di Cicco:** serve,

**Elena Spini:** queste sono le casistiche.

**Andrea Di Cicco:** quindi sicuramente c'è la parte da una grafica. Ah, qui perché se selezioni argomento codice promozione creato

**Sabatino Rinaldi:** Però, cioè, io non so voi in passato come avete fatto eccetera, però a me mi sembra che il web è un tantino limitato come sistema.

  
  

### **00:15:13**

  

**Sabatino Rinaldi:** Uno perché bisogna creare un web per qualsiasi cosa vogliamo fare, due perché è limitato nel tipo di informazioni che vogliamo prenderci rispetto alle PI che bene o male sei libero di fare qualsiasi cosa ti passa per la testa. Cioè, metti caso, un dico così per ragionare, eh, non succederà mai, tranquilli, però metti caso che un giorno mi decidiamo che da salesce vogliamo fare un export di tutti gli ordini di Wcommerce per un determinato prodotto, per dire con l'EPI lo fai in un attimo, col Webbook devi un attimo lo fai, ma devi un attimo bestemmiare e poi lo fai. Non lo so, eh, cioè, nel senso, poi siete voi che dovete fare l'integrazione. Io mi baso su quello che ho fatto io, però di sicuro voi da quel punto di vista avete più esperienza.

**Aurel mrruku:** Ma eh una cosa che non sto capendo, eh questi webook sono per trasmettere su sales vero?

**Sabatino Rinaldi:** Sì, esatto. Io avrei bisogno infatti della vostra chiave.

**Aurel mrruku:** Sì, quelle li fornisco io nel momento in cui decidiamo che tipologia di

**Sabatino Rinaldi:** Ok.

**Aurel mrruku:** autenticazione sarà standard con una chiave. Spero che sia facile anche per te, ma eh a sto punto basta che definiamo il payload.

  
  

### **00:16:41**

  

**Aurel mrruku:** Con payload intendo proprio i valori sulla struttura che passi. con la struttura pensa un Jason praticamente.

**Sabatino Rinaldi:** Sì.

**Aurel mrruku:** Quindi da qua tu hai modo di tracciare i

**Sabatino Rinaldi:** Il problema è che a me mi sembra limitato su come

**Aurel mrruku:** campi.

**Sabatino Rinaldi:** lui come Wcommerce ti passa i dati, perché cioè vedi che non ti fa creare un un invatto una struttura Jason come vuoi te con

**Aurel mrruku:** Ho una struttura doc.

**Sabatino Rinaldi:** tutti i campi che vuoi te. Ma a me mi sembra che qui lui ti dica che argomento vuoi, cioè nel senso che cosa vuoi passare a Sales Force utente creato e basta. Non è che mi fa fare una multiselection, mi fa fare solo una selezione. Quindi significa che io con questo singolo web ti sto passando il payload di tutti gli utenti creati. Fine.

**Aurel mrruku:** Ma non è che hai un No,

**Sabatino Rinaldi:** Così.

**Aurel mrruku:** una schermata successiva questa che ti dice anche i campi?

**Sabatino Rinaldi:** No, no, perché mi fa salvare po, cioè se metto salva non mi fa fare niente. Provo a salvarlo anche perché non ci sono informazioni, quindi boh. No, niente.

  
  

### **00:17:59**

  

**Sabatino Rinaldi:** me l'ha fatto. Av inventato anche una chiave.

**Aurel mrruku:** Quindi dobbiamo per forza. Ma il lato tu puoi fare questa

**Sabatino Rinaldi:** Vediamo un attimo. Cioè, forse sono due bottoni diversi.

**Aurel mrruku:** Да.

**Sabatino Rinaldi:** Questo è questo. No, è uguale. E lato API invece io posso su quell'EPI possiamo fare tutto in lettura e scrittura.

**Aurel mrruku:** Ok. E come tu hai modo di triggerare l'epi?

**Sabatino Rinaldi:** Che senso?

**Andrea Di Cicco:** Ча.

**Aurel mrruku:** Eh,

**Sabatino Rinaldi:** Traducciimelo.

**Aurel mrruku:** allora, eh per avviare la comunicazione devi mandare

**Sabatino Rinaldi:** Mh.

**Aurel mrruku:** un è praticamente nel momento in cui mandi l'ordine. Webhook molto probmente c'ha un meccanismo suo che triggera.

**Sabatino Rinaldi:** Mh.

**Aurel mrruku:** La comunicazione, l'EPI,

**Sabatino Rinaldi:** Mh.

**Aurel mrruku:** quando lo chiami il tuo PI per portare i dati a Sales

**Sabatino Rinaldi:** Ah. Cioè,

**Aurel mrruku:** Force,

**Sabatino Rinaldi:** te dici come facciamo a collegare la chiamata IPI a sales force sulla base delle informazioni che ci servono?

  
  

### **00:19:45**

  

**Aurel mrruku:** non sulla base, anche sulla base delle informazioni che ci serve, ma nel momento in cui quell'informazione serve su salesce.

**Sabatino Rinaldi:** Mh.

**Aurel mrruku:** Perché mi aspetto che nel momento in cui vuoi mandare l'ordine a sales force chiami l'IP per mandare l'ordine a sales force. Quando capisci che vuoi mandare l'ordine a Sales Force? Molto probabilmente quando l'ordine va in un certo stato.

**Sabatino Rinaldi:** Esatto. quando va nello stato in

**Aurel mrruku:** Sì. Hai qualcosa per triggerare la chiamata API quando

**Sabatino Rinaldi:** lavorazione.

**Aurel mrruku:** l'ordine va in un certo stato su su sul tuo sistema?

**Sabatino Rinaldi:** Da su WooCommerce. Ah

**Aurel mrruku:** Sì.

**Sabatino Rinaldi:** no,

**Andrea Di Cicco:** Что?

**Sabatino Rinaldi:** cioè quella lì, ad esempio, io ho collegato WCommerce alla mia piattaforma di di che ho fatto io di PIENISSIMO e da lì sono io che ho scritto eh ho messo sulla struttura per prendermi le informazioni da Wcommerce,

**Aurel mrruku:** Eh M.

**Sabatino Rinaldi:** cioè eh da da WooCommerce tramite PI che quindi avevo determinato inati campi. che quando avveniva quell'evento

**Aurel mrruku:** Eh, come sapevi che se veniva quell'evento?

  
  

### **00:21:09**

  

**Sabatino Rinaldi:** quando si verificava, ad esempio, su un ordine, quando quell'ordine passava in

**Aurel mrruku:** Ok,

**Sabatino Rinaldi:** lavorazione.

**Aurel mrruku:** ma come eh il tuo sistema come sapeva se l'ordine era passato in lavorazione? Quindi deve essere un trigger lato

**Sabatino Rinaldi:** Ah, ok. Sì, sì, sì, sì. Io in realtà questa cosa qui sulla piattaforma ho un

**Aurel mrruku:** DB.

**Sabatino Rinaldi:** Chrome che ogni tot di minuti va a controllare che è un sync, quindi ogni tot va a vedere che quell'ordine è in lavorazione.

**Aurel mrruku:** Quindi è una un processo asincrono, non un processo sincrono prima di tutto.

**Andrea Di Cicco:** Yeah.

**Aurel mrruku:** Poi la chiamata tu lo fai dalla tua piattaforma a WooCommerce,

**Sabatino Rinaldi:** Sì.

**Aurel mrruku:** non è il contrario.

**Sabatino Rinaldi:** No, dalla mia piattaforma WooCommerce.

**Aurel mrruku:** Eh, però E tu ce l'hai l'ordine sulla tua piattaforma?

**Sabatino Rinaldi:** Sì.

**Aurel mrruku:** Noi su SOS non ce l'abbiamo l'ordine perché l'ordine deve essere creato su Sal.

**Sabatino Rinaldi:** Eh, quindi deve essere Wcommerce che scrive su Sales Force.

**Aurel mrruku:** Sì,

  
  

### **00:22:28**

  

**Sabatino Rinaldi:** Ah, quindi come facciamo?

**Aurel mrruku:** dobbiamo capire su su WooCommerce cosa ti offre perché

**Sabatino Rinaldi:** Vabbè, ci sarà una documentazione di WooCommerce, no? sul come fare per collegarlo in scrittura ad altre piattaforme.

**Andrea Di Cicco:** tramite web che loro suggeriscono. No.

**Elena Spini:** Ma l'auto vostro non c'è un Mirco di turno che tipo gestisce la parte di Mexal, però per la parte più tecnica di Wcommerce?

**Sabatino Rinaldi:** M no, non abbiamo mai avuto bisogno, diciamo. M.

**Andrea Di Cicco:** Sì, sì. Cè l'unica l'unica cosa che c'è sono i Webhook.

**Aurel mrruku:** Qua e custom WordPress Hook dice qua è poco custom

**Andrea Di Cicco:** Come?

**Aurel mrruku:** praticamente.

**Sabatino Rinaldi:** Cioè, quindi qui mi dice che se lo facciamo tramite

**Aurel mrruku:** Eh,

**Sabatino Rinaldi:** Webhook.

**Aurel mrruku:** si fa un action su PHP che fa la chiamata. Sto chiedendo Ai, non non so quanto sia fattibile,

**Sabatino Rinaldi:** Sì, più che altro più che PHP questa la strada più semplice sarebbe ad

**Aurel mrruku:** No.

**Sabatino Rinaldi:** esempio su un ordine, quindi fai ordine aggiornato, URL di consegna è vostro,

  
  

### **00:25:24**

  

**Aurel mrruku:** Sì.

**Sabatino Rinaldi:** la chiave è vostra,

**Andrea Di Cicco:** Sì.

**Sabatino Rinaldi:** versione API è questa qui. E è questo.

**Aurel mrruku:** Sì, ma è in qualche modo su sul

**Andrea Di Cicco:** Eh

**Aurel mrruku:** sistema io qua sto guardando il Webhook praticamente c'ha un un body e nel body c'hai un payload e nel payload fai la mappatura dei campi, quello che dovevamo fare oggi. in base a quello che ci serve, l'informazione che ci serve. E come hai fatto tutto il payload? Farò io l'atto sales force, i rapper si chiamano per fare la mappatura in modo corretto. A noi ci ci manca la prima parte, quindi come mettere in piedi sul tuo sistema il webhook e il payload.

**Sabatino Rinaldi:** Allora,

**Aurel mrruku:** Sto guardando.

**Sabatino Rinaldi:** di base noi con un web del genere, questo qui,

**Aurel mrruku:** Sì.

**Sabatino Rinaldi:** se creiamo un web di questo tipo, con questo tipo di argomento Significa che in salesce vi arriverà qualsiasi tipo di

**Aurel mrruku:** E

**Sabatino Rinaldi:** ordine in qualsiasi stato, quindi nel payload che vi arriva vi arriverà ogni

**Andrea Di Cicco:** Sì.

**Aurel mrruku:** e invece qua sta dicendo

  
  

### **00:26:48**

  

**Sabatino Rinaldi:** ordine. Quello che dovete fare voi è ignorare tutti gli stati che non sono in processing o in completed completed,

**Aurel mrruku:** Che

**Sabatino Rinaldi:** come c\*\*\*\* si dice? No.

**Aurel mrruku:** sì, va bene, però tu non stai definendo la struttura, mi stai mandando tutto e su quel tutto non mi stai mandando l'account, praticamente il cliente, mi stai mandando solo l'ordine

**Sabatino Rinaldi:** Sì.

**Aurel mrruku:** e ci manca il prezzo del del cliente che stavamo parlando prima,

**Andrea Di Cicco:** Так.

**Aurel mrruku:** cioè passare tutto insieme con tutto insieme intendevano intendevamo la struttura del cliente

**Sabatino Rinaldi:** Ok.

**Aurel mrruku:** e la struttura dell'ordine se il cliente non è stato censito su salesource perché come t'ho detto sto leggendo Hai, perché non ho idea come funziona Wcommerce. Eh, praticamente qua sto leggendo un codice PHP che è un action praticamente che scatta nel momento in cui c'è una transizione dello stato dell'ordine, quindi si lato vostro si può anche intercettare lo stato, il cambiamento dello stato in un certo stato dell'ordine.

**Sabatino Rinaldi:** Cioè, in pratica questa roba

**Aurel mrruku:** Ne.

  
  

### **00:28:25**

  

**Sabatino Rinaldi:** qui allora order company Ok. Web Custom via PHP e quindi è

**Aurel mrruku:** E questo sto leggendo anch'io.

**Sabatino Rinaldi:** semplice anche in quel caso impostare tutta la struttura del

**Aurel mrruku:** E E infatti là è molto più facile perché nel payload,

**Sabatino Rinaldi:** cliente.

**Aurel mrruku:** se vedi l'esempio del payload,

**Sabatino Rinaldi:** Sì, sì,

**Aurel mrruku:** tu puoi prendere qualsiasi cosa.

**Sabatino Rinaldi:** sì, sì. Tu c'hai event o Ah, addirittura qui sono anche già collegato al discorso dell'altra volta, quindi lui ti passa l'event, l'opportunity di l'order order ID, number, status, totale, ok, billing, quindi tutte le informazioni del cliente ship.

**Aurel mrruku:** i molto probabilmente dell'ordine e tutte le informazioni

**Sabatino Rinaldi:** Esatto. Guarda,

**Aurel mrruku:** dellitem stato,

**Sabatino Rinaldi:** aspettatino.

**Aurel mrruku:** quantità, eccetera.

**Sabatino Rinaldi:** Cioè, questo è il

**Aurel mrruku:** Eh,

**Sabatino Rinaldi:** payload.

**Aurel mrruku:** quello sto guardando anch'io.

**Sabatino Rinaldi:** Questo è il payload e questo è un esempio. basato su anche il collegamento che avevamo fatto noi sempre tramite

  
  

### **00:30:04**

  

**Aurel mrruku:** Se vedi c'è il customer,

**Sabatino Rinaldi:** PHP.

**Aurel mrruku:** l'ID del customer. Molto probmente puoi prendere anche altre informazioni dal customer, nome, cognome, partite IVA, eccetera.

**Sabatino Rinaldi:** Eccole qua.

**Aurel mrruku:** Ok?

**Sabatino Rinaldi:** Qui mancano Ah,

**Aurel mrruku:** Eh eh fiscal.

**Sabatino Rinaldi:** no, è qui. Ah, ship fiscal.

**Aurel mrruku:** Vabbè, fai anche così mi va bene, perché ci penso io poi a mapparli correttamente su Sales Force. Eh, mi serve anche la parte del la parte del item dell'ordine, praticamente la sottostruttura dell'ordine,

**Andrea Di Cicco:** Ah.

**Aurel mrruku:** intendo.

**Sabatino Rinaldi:** sottuttura dell'ordine

**Elena Spini:** Da cosa è composto l'ordine,

**Aurel mrruku:** Sì, sì.

**Elena Spini:** le righe sarebbero,

**Sabatino Rinaldi:** Eh, che qui non

**Elena Spini:** non so Ne.

**Sabatino Rinaldi:** c'è.

**Aurel mrruku:** Ma molto probabilmente li puoi prendere senza problemi perché è connesso sul

**Sabatino Rinaldi:** Sì, sì, non è un problema.

**Aurel mrruku:** DB. Poi ovviamente dobbiamo fare dei test perché spesso spara volate.

  
  

### **00:31:29**

  

**Aurel mrruku:** Eh

**Sabatino Rinaldi:** H Ah, top. Addirittura questa info non è male, non ci può tornare utile. Ok.

**Aurel mrruku:** Subscription, non è che ci interessa tanto. Mi aspetto una lista di oggetti. Eh, qua, qua, qua,

**Sabatino Rinaldi:** Ecco

**Aurel mrruku:** qua. Perfetto.

**Sabatino Rinaldi:** qua.

**Aurel mrruku:** Eh, ci questo ci serve.

**Sabatino Rinaldi:** Guarda, lo copio, te lo butto su quel documento che abbiamo in fondo. Oh.

**Aurel mrruku:** Se riesci a fare un test ancora meglio, quindi fai un test verso un server sono quelli pubblici, giusto per vedere se riesci a passare dei dati. Yes. prima di definire i payload, intendo, non so se mai

**Sabatino Rinaldi:** T'ho capito che c\*\*\*\*.

**Aurel mrruku:** capito. Opportunity utile opionale indirizzi quasi mai vè ti sta dicendo ti sta quello che abbiamo visto sopra ti stai dicendo quali campi sono quelli più

**Sabatino Rinaldi:** Sì, sì, prima ha fatto l'esempio.

**Aurel mrruku:** usati.

**Sabatino Rinaldi:** pratico. Come uscirebbe?

**Aurel mrruku:** Allora, fai fai un check con un server qualsiasi, se sono open, in poco tempo riesci a testarlo.

  
  

### **00:33:53**

  

**Aurel mrruku:** Se va bene basta che mi passi la struttura e inizio a fare su Sales Force la mappatura.

**Sabatino Rinaldi:** Ma

**Aurel mrruku:** Quando poi prima è meglio è prima di passarmi la struttura,

**Sabatino Rinaldi:** Ora.

**Aurel mrruku:** prima di decidere che questa è la struttura testiamo che mandiamo i dati

**Sabatino Rinaldi:** Ok. Il problema. Vabbè, tanto non mi serve quel PHP.

**Aurel mrruku:** anche se però Per ogni struttura metti due campi, non se metti due campi puoi mettere anche 10 campi, non è un problema. Quindi ordine, cliente, orderine, quindi le linee, i prodotti praticamente venduti su su

**Sabatino Rinaldi:** No,

**Aurel mrruku:** quell'ordine.

**Sabatino Rinaldi:** più che altro fammi capire come faccio a fare questo test rapido.

**Aurel mrruku:** Questo test rapido, praticamente ci sono dei server online.

**Sabatino Rinaldi:** Ok.

**Aurel mrruku:** Basta che chiedi anche a lei che ti aiuta che ti mettono a disposizione un URL che puoi passare qualsiasi eh Jason là. fai l'azione sul tuo sistema, quindi col passaggio dello stato, come avevamo visto prima, quindi devi fare un con una action sul cambiamento dello stato dell'ordine e vedi se spara questo Jason in questo API, praticamente questo server.

  
  

### **00:35:46**

  

**Aurel mrruku:** Sennò ci mettiamo insieme un'ora dopo e facciamo dei test insieme. Ti preparo io il server da da appuntare.

**Sabatino Rinaldi:** Consente account. Non.

**Aurel mrruku:** Allora, qua sto leggendo che WooCommerce dice ha già dei webhook sull'order. dater

**Sabatino Rinaldi:** Dove lo stai leggendo? Ok,

**Aurel mrruku:** create, order update and order delete su topics sotto Vedi corto o pixel order create order update and order delete.

**Sabatino Rinaldi:** aspetta che un attimo che qui mi sa che riusciamo a fare il test. Allora, mi ha fatto l'end point. Funziona. Ora ti preparo il file PHP. Pronto per il test con l'URL già dentro. File pronto di test. Test verificato. Quindi faccio così. fammi capire un attimo che sta facendo. Eh, vado, ci vediamo dopo. Vediamo

**Aurel mrruku:** eh suggerisce di fare un piccolo plugin mettendo in in

**Sabatino Rinaldi:** dopo.

**Aurel mrruku:** piedi praticamente quello che la struttura che hai fatto vedere prima. Quindi qua dice che non la consiglia perché passerebbe tutti gli stati o passerebbe i cambiamenti, o meglio, passerebbe sempre la struttura su ogni cambiamento dello stato e suggerisce di fare quello che stai facendo te prima, un plugin piccolo, quindi con po con una action che la action controlla lo stato dell'ordine.

  
  

### **00:38:50**

  

**Aurel mrruku:** No.

**Sabatino Rinaldi:** Yeah. Ok. Eh sì, tocca però che con calma ci mettiamo a fare questo test, dai.

**Aurel mrruku:** Sì,

**Sabatino Rinaldi:** Anche perché lui mi dice come procedere.

**Aurel mrruku:** sì.

**Sabatino Rinaldi:** Installa SF trackerph. PHP in VP. L'or test non devi modificare niente. Fai l'ordine di test, completa l'ordine. Eh, ok. Appena l'ordine entra in processing complete, il payload arriva, clicca sulla richiesta senza verificare Jason

**Aurel mrruku:** Ma fa niente, basta che gli passi il Jason,

**Sabatino Rinaldi:** formattato.

**Aurel mrruku:** poi ci penso io l'ato sales force a a alla mappatura.

**Sabatino Rinaldi:** Ok. Eh, come vogliamo

**Aurel mrruku:** Eh,

**Sabatino Rinaldi:** fare?

**Aurel mrruku:** come vuoi, anche più tardi, se hai tempo, ci mettiamo insieme a fare un esempio per

**Sabatino Rinaldi:** Aspetta che ho perso,

**Aurel mrruku:** capire se riusciamo a

**Sabatino Rinaldi:** non trovo nemmeno più la col. Ah, ecco. Ok.

**Aurel mrruku:** triggerare l'azione per mandare il la struttura, quindi scattare il processo di comunicazione perché è una comunicazione outbound lato vostro inbound lato sales force.

  
  

### **00:40:26**

  

**Aurel mrruku:** Se questa comunicazione ha i dati, anche per il momento cinque dati incroci bastano, quindi un dato sulla struttura dell'ordine, un dato sulla struttura del del cliente, un dato sulla struttura del prodotto. Allora, siamo a posto. Basta che definiamo come prendere quei dati su quel scrittino, quel quella cosa che dobbiamo fare insieme lato WooCommerce e ci

**Sabatino Rinaldi:** Ok.

**Aurel mrruku:** siamo.

**Sabatino Rinaldi:** Eh sì, dai, facciamolo noi, ci pensiamo un'oretta, tanto secondo me ci mettiamo

**Aurel mrruku:** Ok. Eh,

**Sabatino Rinaldi:** poco.

**Aurel mrruku:** allora io c'ho un altra No, non c'ho un'altracolto. Ho mentito. Dico un attimo come sono

**Andrea Di Cicco:** Eh,

**Aurel mrruku:** messo.

**Andrea Di Cicco:** scusa, è giusto per sicurezza, ma poi quella cosa dell'ID dell'opportunity

**Aurel mrruku:** Quello ha detto che si fa.

**Andrea Di Cicco:** Ok,

**Aurel mrruku:** Quello ha detto che praticamente cosa succede? Eh

**Andrea Di Cicco:** cioè noi facciamo il web che ce lo manda e poi chiamiamo la l'arrest che gli

**Aurel mrruku:** sì,

  
  

### **00:41:34**

  

**Andrea Di Cicco:** manda l'opportunità di

**Sabatino Rinaldi:** Cioè, in pratica lui qui già mi faceva vedere perché io sono sulla stessa chat che vi ho fatto vedere l'altra volta,

**Aurel mrruku:** sì.

**Andrea Di Cicco:** Ok.

**Sabatino Rinaldi:** cioè dove ho creato Questa cosa qui la vedete la chat? Vedete?

**Andrea Di Cicco:** Sì,

**Sabatino Rinaldi:** Ok, io non vedo più voi.

**Andrea Di Cicco:** sì.

**Sabatino Rinaldi:** Vabbè, fa niente. e lui qui sulla base di quel PHP che vi mostrei l'altra volta ha già inserito l'informazione.

**Andrea Di Cicco:** Ah, ok,

**Sabatino Rinaldi:** Ora in questo caso è già compilato,

**Andrea Di Cicco:** perfetto.

**Sabatino Rinaldi:** però se vado a vedere nella struttura Esatto, te lo va a riprendere.

**Andrea Di Cicco:** Ok, bene. No, era giusto per sicurezza che che magari sara persa poi quella cosa.

**Sabatino Rinaldi:** Bene, quindi dobbiamo fare questa cosa. Se funziona,

**Aurel mrruku:** Ci siamo.

**Sabatino Rinaldi:** siamo a cavallo.

**Aurel mrruku:** Quindi, praticamente, giusto per spiegare anche a te, Elena, eh il lato funzionale è quello che hai descritto prima, quindi su Salesf si crea unopportunity di una certa tipologia.

  
  

### **00:42:44**

  

**Aurel mrruku:** Questo opportunity genererà praticamente una mail con un link. Quel link avrà l'ID del dell'opportunity, viene mandato al via mail al cliente,

**Elena Spini:** Scusate

**Aurel mrruku:** il cliente preme su link, il link fatter su WooCommerce. Su WooCommerce si fanno le action. Quando si crea l'ordine su e va su un certo stato, WooCommerce in automatico manda l'ordine con tutti i dati su su saleswce. Capito bene, vero?

**Elena Spini:** A me torna.

**Aurel mrruku:** Ok.

**Sabatino Rinaldi:** Sì.

**Aurel mrruku:** Eh, ovviamente in questo caso il cliente c'è su sales force perché se stiamo se stiamo mandando la la mail vuol dire che

**Elena Spini:** Beh, sì,

**Aurel mrruku:** c abbiamo i dati del

**Elena Spini:** questo è il caso che il cliente è già conosciuto.

**Aurel mrruku:** cliente.

**Elena Spini:** Invece per il caso che il cliente va solo su Wcommerce,

**Fabrizio Paganelli:** Ok.

**Aurel mrruku:** E nel momento nel caso in cui il cliente va solo su WooCommerce, la stessa cosa succede ma senza la prima parte.

**Elena Spini:** abbiamo

**Aurel mrruku:** Quindi su WooCommerce scatta un automatismo quando l'ordine va a un certo stato e l'ordine viene su salesce con tutte le informazioni del cliente del cliente dei prodotti che sono collegati a

  
  

### **00:43:57**

  

**Elena Spini:** perfetto.

**Aurel mrruku:** quell'ordine.

**Elena Spini:** Ottimo. Ehm, fate voi un test oggi,

**Aurel mrruku:** Sì.

**Elena Spini:** vi riuscite a sentirei o senò domani?

**Aurel mrruku:** Se eh meglio oggi che poi domani

**Elena Spini:** Non lo so.

**Aurel mrruku:** venerdì ci dimentichiamo poi le cose. Oggi io sono libero dalle 3:00 alle 5

**Sabatino Rinaldi:** Sei libero dalle 3:00 alle 5:00, quindi dovremmo fare alle 4.

**Aurel mrruku:** se riesci. Ok,

**Elena Spini:** ve lo mando io e fate voi.

**Aurel mrruku:** perfetto.

**Elena Spini:** Io non mi collego,

**Aurel mrruku:** Sì,

**Elena Spini:** però va

**Aurel mrruku:** grazie

**Sabatino Rinaldi:** Bene.

**Elena Spini:** bene.

**Aurel mrruku:** Elena.

**Elena Spini:** E non so, Fabrizio, Elisa, volete esserci? Vi interessa? Volete supervisionare?

**Fabrizio Paganelli:** No, da dal mio punto di vista possiamo anche non Sì,

**Elena Spini:** Torna tutto.

**Sabatino Rinaldi:** Sì, sì, sì. No,

**Fabrizio Paganelli:** almeno io io oggi non riesco No,

**Sabatino Rinaldi:** no, son d'accordo, Fabri, anche perché non c'è nulla da discutere, è solo una cosa

  
  

### **00:45:00**

  

**Fabrizio Paganelli:** però io volevo sollevare una questione che secondo me è importante.

**Sabatino Rinaldi:** Да.

**Fabrizio Paganelli:** Noi da Wcommerce riceviamo gli ordini sia per il libro per esempio oppure gli stream, ma usiamo Wcommerce in modo pesante per il tema delle vendite da palco. Quindi, quando fate i test simulate sia la vendita normale, ma soprattutto, mi raccomando, simuliamo la vendita da palco, perché quella lì deve, nel momento in cui il cliente è in sala, decide di acquistare, decide di pagare, deve fluire tutto correttamente e deve fluire in modo semplice per il cliente e veloce. Quindi dopo io qui sono tutti meccanismi che e tecnicismi che faccio fatica a capire, sono sincero, però quello che mi raccomando di fare è appunto fare quando fate i test fate le simulazioni su queste due casistiche perché se ci blocchiamo su una vendita di un libro o di uno stream che costa €97, pazienza. Ma se ci blocchiamo su una vendita da palco che magari sono in gioco anche €8.900 €900 o più, dopo lì diventa un problema grosso. Quindi

**Sabatino Rinaldi:** Sì,

**Aurel mrruku:** Ja.

**Sabatino Rinaldi:** che secondo me poi la vendita da palco è anche abbastanza più semplice perché in

  
  

### **00:46:13**

  

**Fabrizio Paganelli:** ripeto

**Sabatino Rinaldi:** pratica è un'azione diretta direttamente fatta direttamente dal cliente, nel senso da vendita da palco è quando il cliente scansiona il famoso quel code di cui abbiamo parlato 1000 volte e acquista da

**Fabrizio Paganelli:** sì.

**Sabatino Rinaldi:** WooCommerce. Quindi da WCommerce noi dobbiamo prevedere una un invio a sales force di quell'ordine lì, quindi è secondo me anche più semplice, però sì,

**Fabrizio Paganelli:** Sì.

**Sabatino Rinaldi:** facciamo test anche su quello.

**Fabrizio Paganelli:** Eh, perché poi

**Sabatino Rinaldi:** È la stessa cosa in realtà, Aurel, perché anche lì lo stato dell'ordine deve essere o in lavorazione o

**Aurel mrruku:** Sì, sì, sì.

**Fabrizio Paganelli:** dopo

**Aurel mrruku:** Eh, allora, eh il lato tecnico non mi aspetto sorprese.

**Sabatino Rinaldi:** completato.

**Aurel mrruku:** Forse quando facciamo la mappatura dei campi dobbiamo essere più attenti e ovviamente noi faremo un test tecnico oggi o prima possibile, poi dobbiamo fare anche un test funzionale su diversi casi perché

**Sabatino Rinaldi:** Chiaro,

**Fabrizio Paganelli:** Eh,

**Sabatino Rinaldi:** chiaro.

**Aurel mrruku:** Non.

**Fabrizio Paganelli:** perché poi dopo sulla vendita tramite WooCommerce con origine da palco.

**Sabatino Rinaldi:** Sì.

**Fabrizio Paganelli:** Dopo lì si scatenano tutto una serie di meccanismi successivi che sono l'invio del contratto, bla bla bla bla bla bla. Quindi, eh, ripeto, è è fondamentale verificare che tecnicamente funzioni tutto bene su questa cosa qui. Magari tu Elisa, io ripeto oggi pomeriggio non ce la faccio, tu Elisa se vuoi partecipare mettiti d'accordo con Sabatino. Vedi anche tu che tra l'altro su certe cose sei anche più eh hai anche più sensibilità operativa maggiore della mia. Quindi Elisa

**Elisa Migliano:** Va bene, va bene. Yeah.

**Fabrizio Paganelli:** 5 minuti a partire da ora.

**Sabatino Rinaldi:** Boh. Io allora direi che ci vediamo alle 4:00.

**Aurel mrruku:** K. Grazie.

**Andrea Di Cicco:** Grazie.

**Elena Spini:** Ok,

**Andrea Di Cicco:** Ciao a tutti.

**Elisa Migliano:** a voi.

**Sabatino Rinaldi:** a voi.

**Elisa Migliano:** Buona giornata.

**Fabrizio Paganelli:** Ciao.

**Elena Spini:** ciao ciao ciao.

**Elisa Migliano:** Ciao. Ciao.

**Sabatino Rinaldi:** Co?

**Fabrizio Paganelli:** Ciao a tutti. Sì.

  
  

### **Trascrizione terminata dopo 00:48:20**

  

*Questa trascrizione modificabile è stata generata dal computer e potrebbe contenere errori. È possibile anche modificare manualmente il testo dopo la creaz
