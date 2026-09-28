# **ð Note**  

 ago 27, 2026

## **\[ROMI-PIENISSIMO\] - Test Integrazione WooCommerce**

invitato [Elena Spini](mailto:e.spini@romicompany.com) <sabatino.r@pienissimo.com> [Aurel mrruku](mailto:a.mrruku@romicompany.com)

Allegati [\[ROMI-PIENISSIMO\] - Test Integrazione WooCommerce](https://calendar.google.com/calendar/event?eid=NWtxMDJkNGNzdHZmamM0cTJ2Z2R2cWlqZWsgZS5zcGluaUByb21pY29tcGFueS5jb20)

Record delle riunioni [Trascrizione](https://docs.google.com/document/d/1oqiqR46V77BA7GuyFnrrptgb-2zgmwSBYl4cGPZg_6o/edit?usp=drive_web&tab=t.1a6pjf8ccibc) [Registrazione](https://drive.google.com/file/d/1UR-NKQmIRc8rjguIKAjTbBiuJtX9nO5I/view?usp=drive_web) 

  
  

### **Riepilogo**

Revisione del sistema di tracciamento vendite WooCommerce con configurazione plugin e integrazione dati Salesforce confermata.  
  
**Configurazione plugin e ordini**  
Il sistema automatizza il tracciamento ordini per WooCommerce tramite un plugin dedicato, gestendo vari stati di pagamento. Il processo assicura l'invio dati per transazioni in lavorazione o completate.  
  
**Analisi payload e dati**  
La mappatura dei dati include campi essenziali come ID ordine, dati cliente e codice prodotto. È stato confermato che la verifica della partita IVA non rallenta il flusso principale.  
  
**Decisione finale integrazione**  
È stato deciso di eseguire i test finali direttamente su Salesforce la prossima settimana utilizzando un token di autenticazione dedicato.

  
  

### **Decisioni**

## **Concordato**

  - **Implementazione plugin per integrazione** L'integrazione tra WooCommerce e Salesforce sarà gestita tramite un plugin dedicato, in sostituzione degli script PHP, per garantire maggiore flessibilità e controllo sui processi.
  - **Gestione verifica Partita IVA** La verifica della Partita IVA non verrà implementata durante la fase di arrivo dell'ordine da WooCommerce, poichè la convalida sarà eseguita in seguito durante la fase di invio dell'ordine a Mexal.
  - **Pianificazione test su Salesforce** L'ambiente di test sarà configurato puntando direttamente a Salesforce con autenticazione tramite token, fissando i test di integrazione completi per la settimana successiva.

  

Abbiamo **aggiornato la sezione Decisioni** in base al tuo feedback.

Facci sapere cosa ne pensi: [Utili](https://google.qualtrics.com/jfe/form/SV_5bXzKQfylMIhSXc?isHelpful=True&entryPoint=decisions&confid=a44e_yV30j94xkyyOB4EDxIXOBEBMgUIigIgABgDCA&isGoogler=False) o [Non utile](https://google.qualtrics.com/jfe/form/SV_5bXzKQfylMIhSXc?isHelpful=False&entryPoint=decisions&confid=a44e_yV30j94xkyyOB4EDxIXOBEBMgUIigIgABgDCA&isGoogler=False)

  
  

### **Passaggi successivi**

  - \[Sabatino Rinaldi\] Inviare Payload: Inviare tramite email a Aurel mrruku il payload del processo, includendo Andrea Tico in copia conoscenza.
  - \[Aurel mrruku\] Preparare Integrazione: Preparare l'ambiente di integrazione, fornendo l'endpoint e i parametri di autenticazione necessari per collegare il plugin a Salesforce.
  - \[Il gruppo\] Effettuare Test: Effettuare i test di collegamento e integrazione direttamente su Salesforce durante la prossima settimana.
  - \[Sabatino Rinaldi\] Disattivare Plugin: Disattivare il plugin di test per evitare che i dati fluiscano verso il server temporaneo.

  
  

### **Dettagli**

  - **Creazione dei carrelli e test su WooCommerce**: Sabatino Rinaldi spiega che i carrelli vengono gestiti tramite Funnel Kit, un plugin di WooCommerce per WordPress. Per effettuare i test, Sabatino Rinaldi crea un prodotto di prova denominato "test salesce" del valore economico di 50 euro e definisce un URL di checkout collegato all'ID dell'opportunità di Salesforce ([00:02:01](https://docs.google.com/document/d/1oqiqR46V77BA7GuyFnrrptgb-2zgmwSBYl4cGPZg_6o/edit?ouid=100243958128504204165#heading=h.jn7x7az33p5j)).
  - **Configurazione del plugin e gestione degli stati degli ordini**: Per automatizzare il tracciamento, Sabatino Rinaldi ha sviluppato un apposito plugin (arrivato alla versione 1.3) anziché utilizzare script PHP diretti. Il sistema invia automaticamente i dati per gli ordini che si trovano nello stato "in lavorazione" o "completato", indipendentemente dal metodo di pagamento (bonifico bancario, carta o PayPal), come verificato da Sabatino Rinaldi durante i test ([00:04:34](https://docs.google.com/document/d/1oqiqR46V77BA7GuyFnrrptgb-2zgmwSBYl4cGPZg_6o/edit?ouid=100243958128504204165#heading=h.vs7nm4dai55j)).
  - **Analisi del payload e mappatura dei dati dell'ordine**: Sabatino Rinaldi mostra il funzionamento del webhook con esito HTTP 200 e la funzione per il reinvio manuale a Salesforce. Vengono analizzati i campi del payload, tra cui la chiave dell'ordine WooCommerce, i dati dei clienti, la partita IVA, la sorgente di tracciamento e il codice prodotto (richiesto da Max e Fabrizio) necessario per il corretto abbinamento su Salesforce ([00:07:36](https://docs.google.com/document/d/1oqiqR46V77BA7GuyFnrrptgb-2zgmwSBYl4cGPZg_6o/edit?ouid=100243958128504204165#heading=h.tgj6t2vk7004)).
  - **Gestione della verifica della partita IVA**: Aurel mrruku e Sabatino Rinaldi affrontano il tema del controllo della partita IVA, concordando sul fatto che tale verifica non appesantisce il flusso originario da WooCommerce, poiché viene gestita da Andrea nell'ambito dello sviluppo o successivamente quando l'ordine viene inoltrato a Mexal tramite Salesforce ([00:11:57](https://docs.google.com/document/d/1oqiqR46V77BA7GuyFnrrptgb-2zgmwSBYl4cGPZg_6o/edit?ouid=100243958128504204165#heading=h.geuvn1fxct09)).
  - **Pianificazione dei passaggi successivi e test su Salesforce**: Aurel mrruku chiede a Sabatino Rinaldi di inviare il file di testo contenente il payload via email, inserendo Andrea Tico in copia carbone (CC). Aurel mrruku fornirà successivamente un token di autenticazione per le chiamate API verso Salesforce. Sabatino Rinaldi disattiva il plugin di test e i partecipanti concordano di eseguire i test finali direttamente su Salesforce la settimana successiva ([00:13:50](https://docs.google.com/document/d/1oqiqR46V77BA7GuyFnrrptgb-2zgmwSBYl4cGPZg_6o/edit?ouid=100243958128504204165#heading=h.vcvhm9yk1cl9)).

  
  

*Dovresti rivedere le note di Gemini per assicurarti che siano accurate.* [*Ricevi suggerimenti e scopri come Gemini prende appunti*](https://support.google.com/meet/answer/14754931)

*Qual è la qualità di* ***queste note specifiche?*** [*Rispondi a un breve sondaggio*](https://google.qualtrics.com/jfe/form/SV_5bXzKQfylMIhSXc?confid=a44e_yV30j94xkyyOB4EDxIXOBEBMgUIigIgABgDCA&detailLevel=standard&hasImages=False&entryPoint=footerMain&isGoogler=False)*? Facci sapere cosa ne pensi e quanto le note siano state utili per le tue esigenze.****  
***

# **ð Trascrizione***  
*

 ago 27, 2026

## **\[ROMI-PIENISSIMO\] - Test Integrazione WooCommerce - Trascrizione**

### **00:02:01**

  

**Aurel mrruku:** Ciao. Senti,

**Sabatino Rinaldi:** Si sent eccoci. Sì, sì, scusa, ero stavo scrivendo.

**Aurel mrruku:** anch'io avevo le cuffie spente per quello stavo parlando, ma silenzio totale.

**Sabatino Rinaldi:** Eccoci.

**Aurel mrruku:** Allora, come va?

**Sabatino Rinaldi:** Bene, bene, ho risolto, dai. Sembra che vada bene.

**Aurel mrruku:** Bravo. Mi fai vedere così capisco anch'io cosa cosa

**Sabatino Rinaldi:** Sì, aspetta che chiudo la porta

**Aurel mrruku:** preparare.

**Sabatino Rinaldi:** qui. Allora, guarda, ho ripulito i test, così lo facciamo live adesso,

**Aurel mrruku:** Ok,

**Sabatino Rinaldi:** così nel frattempo ti spiego il giro che ho fatto.

**Aurel mrruku:** un attimo che registro.

**Sabatino Rinaldi:** Vai. Sì.

**Aurel mrruku:** Allora

**Sabatino Rinaldi:** Ok,

**Aurel mrruku:** Allora,

**Sabatino Rinaldi:** allora schermo due.

**Aurel mrruku:** vai.

**Sabatino Rinaldi:** Allora, una cosa che non avevamo detto è che noi di base i carrelli li facciamo utilizzando Funnel Kit, che è un plugin di di WordPress di WordPress. di WooCommerce. Quindi in realtà i carrelli li creiamo da qui.

  
  

### **00:03:22**

  

**Sabatino Rinaldi:** Io la prima cosa che ho fatto adesso è creare da WooCommerce un prodotto che l'ho chiamato test salesce.

**Aurel mrruku:** Ok.

**Sabatino Rinaldi:** Gli ho dato semplicemente il nome e valore economico €50. Poi sono venuto qui e ho creato quello che dovrebbe essere il mio URL del checkout, quindi del carrello che ha questa impostazione

**Aurel mrruku:** Ok. Praticamente è come dire,

**Sabatino Rinaldi:** qui.

**Aurel mrruku:** questo è il posto dove tu devi ascoltare l'evento,

**Sabatino Rinaldi:** Esatto. Esatto.

**Aurel mrruku:** vero?

**Sabatino Rinaldi:** Di conseguenza, a questo punto qui non serve più nell'URL inserire il l'ID prodotto perché prende il nome del funnel che in questo caso contiene già il prodotto all'interno. Infatti, come puoi vedere, questo qui è l'URL con questid opportunity test e questo è il link ufficiale,

**Aurel mrruku:** Che

**Sabatino Rinaldi:** cioè di base. Quindi il link uscito da Sales Force sarà questo qui con

**Aurel mrruku:** ok.

**Sabatino Rinaldi:** l'opportunity del del contatto.

**Aurel mrruku:** Sì.

**Sabatino Rinaldi:** Quindi proseguendo con la creazione dell'ordine, vedi il prodotto è questo,

**Aurel mrruku:** Sì,

**Sabatino Rinaldi:** quantità uno eccetera eccetera.

  
  

### **00:04:34**

  

**Aurel mrruku:** sì.

**Sabatino Rinaldi:** Metto qui procedi. Aspetta un attimo che volevo fare una cosa per capire. Non mi ricordo se ho spento qualcosa. Mi sa di no. Vabbè, proviamo. Bonifico bancario. Effetto l'ordine. Ah, no, ecco, sono un c\*\*\*\*\*\*\*. Sono sono un c\*\*\*\*\*\*\*. Mi è venuto in mente quando ho cliccato. p\*\*\*\* p\*\*\*\*\*\*, avevo spento il Ah, ecco perché un'altra cosa, bene che ho sbagliato, perché così ti spiego. Un'altra cosa che ho fatto è stato non fare il PHP, ma creare un plugin comodo perché così Esatto,

**Aurel mrruku:** Sì, molto più

**Sabatino Rinaldi:** molto più comodo.

**Aurel mrruku:** comodo.

**Sabatino Rinaldi:** Infatti ora sono ero arrivata alla versione 1.3 perché ho modificato dei parametri stata facendo. La riattivo così mi va. Vediamo se è entrato qualcosa. Non so.

**Aurel mrruku:** Quindi questo plagin sarà sempre attivato sul vostro

**Sabatino Rinaldi:** Esatto,

**Aurel mrruku:** sistema.

  
  

### **00:05:38**

  

**Sabatino Rinaldi:** sarà un plugin sempre attivo e di base ho visto già che in realtà già come impostato

**Aurel mrruku:** Ok,

**Sabatino Rinaldi:** adesso, entrano tutti i tipi di ordine in stato eh in lavorazione completato.

**Aurel mrruku:** prima nel plugin te gli hai proprio detto solo gli ordini di questo stato li devi

**Sabatino Rinaldi:** Esatto. gli ho detto,

**Aurel mrruku:** Ok.

**Sabatino Rinaldi:** è stata solo questa cosa qui e arrivano già se vengono effettuati con bonifico bancario, con carta o con PayPal, arrivano tutti. Me ne sono accorto perché mentre facevo dei test ci sono stati degli ordini reali e quindi io me li vedevo lì nel server finto che c'era,

**Aurel mrruku:** Ah, ok,

**Sabatino Rinaldi:** ho detto com'è possibile?

**Aurel mrruku:** capito il

**Sabatino Rinaldi:** E perché è già attivata? che in realtà c'è comodo perché noi su salce poi deve arrivare qualsiasi tipo di ordine,

**Aurel mrruku:** plugin. Sì, sì,

**Sabatino Rinaldi:** quindi già va bene.

**Aurel mrruku:** sì.

**Sabatino Rinaldi:** Ora vabbè, attivato il plugin, rifaccio l'ordine e procedi. Procedi. Bonifico bancario.

  
  

### **00:06:31**

  

**Sabatino Rinaldi:** Effetto l'ordine. Ok, ordine effettuato. Quindi vado qui in ordine.

**Aurel mrruku:** sul payload nel plugin hai potuto tracciare tutti i

**Sabatino Rinaldi:** Sì,

**Aurel mrruku:** campi, quindi Ok,

**Sabatino Rinaldi:** ora ti faccio vedere. E vabbè, questo dopo lo cancello.

**Aurel mrruku:** perfetto.

**Sabatino Rinaldi:** Andiamo in questo. Allora, come vedi, già qui compare la mappatura del dell'ID.

**Aurel mrruku:** Perfetto,

**Sabatino Rinaldi:** Io volendo poi una volta che ho cambiato lo stato che ora lo metto in lavorazione,

**Aurel mrruku:** perfetto.

**Sabatino Rinaldi:** a parte che qui nelle note ora non c'è nulla, ma appena aggiorno lo stato in lavorazione o incompletato, quello che

**Aurel mrruku:** Mh.

**Sabatino Rinaldi:** sia,

**Aurel mrruku:** Apparzione.

**Sabatino Rinaldi:** Esatto, mi appare l'informazione del web, cioè del del processo.

**Aurel mrruku:** Ok. Sì,

**Sabatino Rinaldi:** Dov uscire 200.

**Aurel mrruku:** sì.

**Sabatino Rinaldi:** Eccolo qui. Web schato.

**Aurel mrruku:** Perfetto,

**Sabatino Rinaldi:** HTTP 200. E qui,

  
  

### **00:07:36**

  

**Aurel mrruku:** perfetto.

**Sabatino Rinaldi:** volendo, se dovessimo fare delle modifiche su quest'ordine, ho bisogno che rientri su sales force. Posso semplicemente fare reinvio web a sales force.

**Aurel mrruku:** Perfetto. Una meraviglia.

**Sabatino Rinaldi:** Quindi da qui.

**Aurel mrruku:** Quindi hai controllo totale sul processo anche forzando la

**Sabatino Rinaldi:** Esatto. Sì, esatto.

**Aurel mrruku:** chiamata.

**Sabatino Rinaldi:** E da qui dovre Eccolo qui. Post. E qui è tutto il payload che guarda, se vuoi lo copi,

**Aurel mrruku:** Me lo passi, infatti.

**Sabatino Rinaldi:** te lo passo dopo,

**Aurel mrruku:** Perfetto. Sì,

**Sabatino Rinaldi:** quindi sì,

**Aurel mrruku:** me la passi via mail così ce l'abbiamo tracciato. Eh,

**Sabatino Rinaldi:** evento.

**Aurel mrruku:** ok. processing gli passi l'opportunity di tutti i dati dell'ordine.

**Sabatino Rinaldi:** Quindi

**Aurel mrruku:** La order key. Cos'è la chiave?

**Sabatino Rinaldi:** dove lo vedi? Eh sì, no,

**Aurel mrruku:** La WooCommerce.

  
  

### **00:08:25**

  

**Sabatino Rinaldi:** questa è la chiave di dell'order di e-commerce. Sì.

**Aurel mrruku:** Ok. In teoria a me serve poco, no? In teoria sì, serve per sapere che ho un order creato da WooCommerce.

**Sabatino Rinaldi:** Esatto.

**Aurel mrruku:** Molto probabilmente devo creare una tipologia di ordine con quella chiave.

**Sabatino Rinaldi:** Sì.

**Aurel mrruku:** Quindi se quella chiave è creato da WooCommerce. Perfetto. Ok. ai valori dell'ordine. Il customer non mi interessa tantissimo, quindi

**Sabatino Rinaldi:** Questo l'ho mappato perché alcuni dati non arriva Tipo questi dati qui non mi arrivava li ho mappati così come li voleva fare nel kit.

**Aurel mrruku:** perfetto. E allora partita IVA dove c'è là che non la vedo. Forse nel Ok.

**Sabatino Rinaldi:** Eccola

**Aurel mrruku:** Ok.

**Sabatino Rinaldi:** qui.

**Aurel mrruku:** E i prodotti? Ah, c'è anche la parte di tracking team source se si fa da Perfetto.

**Sabatino Rinaldi:** Sì, sì, sì, sì, l'ho messa apposta perché mi è venuta in mente questa cosa che non interessa,

  
  

### **00:09:22**

  

**Aurel mrruku:** Ok. Ok.

**Sabatino Rinaldi:** quindi

**Aurel mrruku:** Quindi capisci anche da dove è arrivato l'ordine volendo. Eh,

**Sabatino Rinaldi:** esatto.

**Aurel mrruku:** anche su Sales Force Product ID. Eh, vabbè,

**Sabatino Rinaldi:** Ad esempio qui lo SC che a noi serve in questa fase.

**Aurel mrruku:** gli hai fatto te.

**Sabatino Rinaldi:** Io quando ho creato l'ordine non l'ho inserito, però è un dato che prende perché vedo le virgolette vuote verdi,

**Aurel mrruku:** Ok,

**Sabatino Rinaldi:** quindi significa che è il codice prodotto che è diverso.

**Aurel mrruku:** la SC cos'è?

**Sabatino Rinaldi:** È il codice prodotto che vuole Max, che vuole Fabrizio sempre,

**Aurel mrruku:** Ok,

**Sabatino Rinaldi:** che di cui parla sempre.

**Aurel mrruku:** quindi quando loro settano i prodotti mettono un codice prodotto che avrò anch'io su Salus quando mi portano i prodotti

**Sabatino Rinaldi:** Sì,

**Aurel mrruku:** su Sal.

**Sabatino Rinaldi:** esatto, esatto,

**Aurel mrruku:** Quindi su questo farò il match molto probabilmente.

**Sabatino Rinaldi:** esatto.

**Aurel mrruku:** Ok.

**Sabatino Rinaldi:** Quindi nome del prodotto test sales force,

  
  

### **00:10:09**

  

**Aurel mrruku:** Ok.

**Sabatino Rinaldi:** quantità subtotale

**Aurel mrruku:** È uno stato,

**Sabatino Rinaldi:** totale

**Aurel mrruku:** no, non c'è uno stato dei quindi paga. No,

**Sabatino Rinaldi:** lo stato

**Aurel mrruku:** no, no.

**Sabatino Rinaldi:** dell'ordine.

**Aurel mrruku:** A livello di di item non ce ne sono stato. A livello di è tutto pagato nel momento in cui si fa l'ordine,

**Sabatino Rinaldi:** Sì, sì, esatto.

**Aurel mrruku:** vero?

**Sabatino Rinaldi:** Perché tu quando vai in lavorazione completato è tutto

**Aurel mrruku:** Ok. Vabbè,

**Sabatino Rinaldi:** pagato.

**Aurel mrruku:** giusto tener Quindi se mi arriva un order da WooCommerce di tutti le linee sono impagato, eh.

**Sabatino Rinaldi:** Sì, anche attualmente su Woo a noi ci entrano solo ordini che sono stati

**Aurel mrruku:** Ok, perfetto.

**Sabatino Rinaldi:** pagati.

**Aurel mrruku:** Ok, allora hai fatto

**Sabatino Rinaldi:** Aspetta un attimo.

**Aurel mrruku:** tutto.

**Sabatino Rinaldi:** Ah, ma te basta che mi dai un po' di tempo, io posso venire a lavorare con te e rivoluzioniamo Self.

**Aurel mrruku:** Bellissimo, no?

  
  

### **00:10:58**

  

**Aurel mrruku:** È è molto molto più comodo

**Sabatino Rinaldi:** Aspetta un attimo, mi son perso il carrello.

**Aurel mrruku:** così.

**Sabatino Rinaldi:** Ah no, ero qui su Website. E sì, poi non so se ci sono altre informazioni.

**Aurel mrruku:** Vabbè, gli glielo do in

**Sabatino Rinaldi:** Ah, sì, vabbè, queste informazioni qui le le che vuole fare il kit,

**Aurel mrruku:** passa.

**Sabatino Rinaldi:** quindi nome locale, ragione sociale, partita IVA.

**Aurel mrruku:** Ah, questi erano a livello di di customer, vero?

**Sabatino Rinaldi:** tu ce li hai sia a livello di WooCommerce,

**Aurel mrruku:** Ok, anche a livello di Ma non devono essere uguali,

**Sabatino Rinaldi:** sia come eh li vuole Funnel Kit.

**Aurel mrruku:** vero?

**Sabatino Rinaldi:** Eh no, sono su questo non saprei nemmeno spiegare bene, ma possiamo tranquillamente lasciarlo così.

**Aurel mrruku:** Ok, va bene. Quindi tengo solo quelli del customer e creo il customer se non la trovo su Sales

**Sabatino Rinaldi:** Sì, sì, esatto.

**Aurel mrruku:** Force.

**Sabatino Rinaldi:** nel caso te c'hai tutto il pelodo, quindi poi volendo puoi anche capire se servono in realtà queste qui.

**Aurel mrruku:** Ok.

  
  

### **00:11:57**

  

**Aurel mrruku:** E invece il CK La partita IVA l'avete già fatto in questo in questa

**Sabatino Rinaldi:** No, questo check sulla partita IVA non viene fatto in questa fase,

**Aurel mrruku:** fase?

**Sabatino Rinaldi:** ma è una cosa che di cui si sta occupando Andrea dello sviluppo che avete parlato voi ieri,

**Aurel mrruku:** Sì,

**Sabatino Rinaldi:** l'altro ieri.

**Aurel mrruku:** sì, ma intendo quindi perché è stato detto che quando sale l'ordine si fa il check della partita IVA, ma a questo punto noi dobbiamo fare anche un check quando arriva un ordine già da da Wo-commerce.

**Sabatino Rinaldi:** che quindi lo fai su Sales

**Aurel mrruku:** Sì, sì,

**Sabatino Rinaldi:** Force.

**Aurel mrruku:** però fino oggi è stato detto che il check sulla partita IVA, il lato sales force, si fa quando sales force si invia all'ordine.

**Sabatino Rinaldi:** Aspetta, però il check sulla partita IVA quando Sales Force invia

**Aurel mrruku:** Adesso stiamo Non c'entra niente

**Sabatino Rinaldi:** l'ordine.

**Aurel mrruku:** con questo fluso,

**Sabatino Rinaldi:** Eh,

**Aurel mrruku:** quindi deve essere fatta anche un altro check. quando un ordine arriva su salesce,

**Sabatino Rinaldi:** chiaro. Sì, sì, per forza,

  
  

### **00:13:03**

  

**Aurel mrruku:** perché se l'ordine e che

**Sabatino Rinaldi:** perché altrimenti poi in fatturazione Fabrizio ha lo stesso problema perché gli si gli si presenta un

**Aurel mrruku:** che No,

**Sabatino Rinaldi:** ordine e non c'è il cesso da

**Aurel mrruku:** ma che che sto dicendo? Che sto dicendo?

**Sabatino Rinaldi:** per

**Aurel mrruku:** Quando l'ordine viene inviato poi a Mexal si fa il check là.

**Sabatino Rinaldi:** Eh,

**Aurel mrruku:** È facile,

**Sabatino Rinaldi:** esatto,

**Aurel mrruku:** è facile.

**Sabatino Rinaldi:** esatto quello intendevo.

**Aurel mrruku:** No, non c'è bisogno. Io sono Non è non c'è bisogno che ci facciamo la testa in questo punto del del flusso. Ok. Ok. Non hai idea quanto sono

**Sabatino Rinaldi:** Sì,

**Aurel mrruku:** contento.

**Sabatino Rinaldi:** io direi che in realtà, se ci viene in mente anche qualche altra idea, mi sento molto flessibile sul poter fare quello che ci pare, eh, perché facendolo mi sono reso conto che effettivamente è abbastanza

**Aurel mrruku:** Perfetto.

**Sabatino Rinaldi:** ehm Esatto.

**Aurel mrruku:** Customabile il bellissimo. Eh,

  
  

### **00:13:50**

  

**Sabatino Rinaldi:** Esatto.

**Aurel mrruku:** allora fai così, mandami via mail il payload, inizio a preparare io il puntamento che devi puntare, non come hai puntato su questo server, punterai poi su Sales Force.

**Sabatino Rinaldi:** Sì, sì, infatti questo qui è un plugin di test. Di conseguenza devo

**Aurel mrruku:** Tieni in considerazione che io ti devo fornire anche un autenticazione con

**Sabatino Rinaldi:** cambiar

**Aurel mrruku:** un token che lo userai, quindi met lo metterai nel header per chiamare sales force.

**Sabatino Rinaldi:** chiaro.

**Aurel mrruku:** E abbiamo fatto.

**Sabatino Rinaldi:** Bene.

**Aurel mrruku:** Ti preparo l'ambiente.

**Sabatino Rinaldi:** Aspetta.

**Aurel mrruku:** Settimana prossima penso che possiamo fare anche i test direttamente in

**Sabatino Rinaldi:** Sì, esatto. Così facciamo tutti i test,

**Aurel mrruku:** salesce.

**Sabatino Rinaldi:** anche quelli che vuole Fabrizio, li facciamo direttamente quando abbiamo il collegamento con Saleswalls, così vediamo tutte le cose come vanno, perché secondo me è inutile farlo ora, anche perché ho visto prima che entrano tutti gli ordini anche senza l'opportunity che entravano gli ordini reali, quindi mi vien facile da pensare che entreranno anche i test che faremo dopo. Dai,

**Aurel mrruku:** Sì, sì.

  
  

### **00:14:55**

  

**Aurel mrruku:** Ok, perfetto.

**Sabatino Rinaldi:** allora ti mando questa mail. Eh, tanto la tua mail c ti mando il per tanto la tua mail ce l'ho e siamo a posto.

**Aurel mrruku:** e basta. Il lato mio serve niente.

**Sabatino Rinaldi:** Aspetto te.

**Aurel mrruku:** Poi ovviamente io su quella mail poi ti devo rispondere dicendo guarda,

**Sabatino Rinaldi:** Allora,

**Aurel mrruku:** devi chiamare Sales force in questo endp qua con questi parametri qua con di header proprio.

**Sabatino Rinaldi:** quando ci sei me li mandi e io ci guardo. Nel frattempo spengo quel plugin prima che mi dimentico, sennò entrano dati su server non nostri. plugin installati. No, tra l'altro è davvero figo, più che altro il fatto che nell'ordine compaia proprio l'opportunità del cliente e compare proprio il bottone che ci permette di aggire manuale,

**Aurel mrruku:** rimande. Sì, sì, sì.

**Sabatino Rinaldi:** quindi tanta roba. molto felice di questo. Allora,

**Aurel mrruku:** No, ma se se tu hai praticamente la possibilità

**Sabatino Rinaldi:** disattivo.

**Aurel mrruku:** di tracciare tutte le informazioni, puoi fare tutto quello che ti pare a livello di integrazione,

**Sabatino Rinaldi:** Eh, no, infatti. No, no, tanta roba.

**Aurel mrruku:** quindi

**Sabatino Rinaldi:** Non mi aspettavo nemmeno io che riuscissimo a farlo così.

**Aurel mrruku:** meno male.

**Sabatino Rinaldi:** Sì, dai. Allora, quindi te la mando adesso questa mail a Elena

**Aurel mrruku:** Metti anche Andrea Tico in CC se

**Sabatino Rinaldi:** Aurel.

**Aurel mrruku:** riesci.

**Sabatino Rinaldi:** Ok.

**Aurel mrruku:** Ok,

**Sabatino Rinaldi:** Ah, guarda, scrivo direttamente ecco il payload e te lo incollo senza troppi giri.

**Aurel mrruku:** grazie. Ti saluto.

**Sabatino Rinaldi:** Faccio così.

**Aurel mrruku:** Allora, ti faccio sapere e ci sentiamo.

**Sabatino Rinaldi:** Ah, l'unico problema No, guarda,

**Aurel mrruku:** Sì.

**Sabatino Rinaldi:** ti faccio un file di testo perché sennò te lo mette tutto per esteso sulla mail.

**Aurel mrruku:** Ah, ok.

**Sabatino Rinaldi:** Vabbè, dai, nel frattempo te la mando.

**Aurel mrruku:** Grazie.

**Sabatino Rinaldi:** Ciao,

**Aurel mrruku:** Co?

**Sabatino Rinaldi:** buona giornata. Ciao. Ciao

  
  

### **Trascrizione terminata dopo 00:17:13**

  

*Questa trascrizione modificabile è stata generata dal computer e potrebbe contenere errori. È possibile anche modificare manualmente il testo dopo la creaz
