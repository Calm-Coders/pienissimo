[ROMI-PIENISSIMO] - Flusso Lead/Opty + Logiche Integrazioni  - July 07
VIEW RECORDING - 148 mins (No highlights): 

---

0:00 - Elena Spini (ROMI Company)
  e ad Andrea si sono occupati un po' di rivedere tutte quelle che sono le logiche del tema di integrazione di Mexal.  Ciao a tutti, piacere.

0:12 - Aurel mrruku
  Ciao, ciao a tutti.

0:13 - Fabrizio Paganelli
  Ciao, ciao.

0:16 - Elena Spini (ROMI Company)
  Dunque, dunque, dunque, allora, per quanto riguarda il tema Mexal, giusto due parole, ah eccolo, buona Andrea. Due parole per quanto riguarda la verifica che dovevamo fare, ovvero integrazione tramite file o integrazione API.  Ora, dato che i file da 1 sono 8, pensare di organizzare il tutto tramite file è uno dispendioso da parte nostra, nel senso proprio il livello di tempistiche, e anche non, diciamo così, non è proprio la bestia.  practice che anche consiglia Salesforce e su questo abbiamo fatto un po' di analisi su quelli che sono i file di API che ci avete condiviso.  Abbiamo delle domande poi un po' più tecniche su questo, però ecco, questo era solo per iniziare a darvi i nostri feedback su questo.  So che lato vostro c'era un tema del riteniamoci lesis e abbiamo meno lavoro da fare, però obiettivamente lato nostro se fosse stato un file lo potevamo anche permettere, ma sono otto file da gestire, quindi è veramente un'integrazione molto complicata, quindi gestire il tutto tramite file, rivedendo il contratto non era neanche a perimetro, ma vabbè, avremmo fatto un passaggio sopra, il contratto dice proprio che l'integrazione dovrebbe essere fatta con le API.  Se si vuole formalizzare anche questo punto, ma vabbè, non ci si affermiamo su questo, anche perché avremmo potuto gestirla se fosse stato magari anche più, diciamo così, fattibile.  Ma essendo proprio tanta mole di lavoro e tanti dati, è un po' più importante l'effort, soprattutto per le tempistiche che ci siamo dati.  Quindi sarà richiesto sicuramente una... servirà qualcuno lato Mexal in grado di supportarci in questa parte, perché noi faremo lo sviluppo lato Salesforce, ma servirà anche qualcuno lato Mexal che possa creare il tutto.

2:47 - Fabrizio Paganelli
  Diciamo che, come dicevamo l'altra volta, strada O, strada B per noi era equivalente. Quello che mi premeva a me è come...  Abbiamo avuto un modo di dire già dalla volta scorsa era, ripeto, fare una sorta di valutazione. Se voi ritenete che questa qui sia la strada più semplice, migliore, soprattutto dal punto di vista delle pratiche, diciamo, più va bene, insomma.

3:20 - Andrea Di Cicco
  A livello, ti spiego pure anche a livello proprio di costi, nel senso che in generale il formato FTP Salesforce non lo gestisce, però voi avete Marketing Cloud Growth che alleva su Data Cloud, quindi lavorando un po' su Data Cloud si poteva fare questo giochino e utilizzare il file.  Nel momento in cui sono diventati 8 file, abbiamo capito che sono 8 file, lì il problema è che ti aumentano tanto i costi, si complica molto di più l'integrazione e tutto quanto, invece...  Il lavoro che abbiamo fatto è stato quello di prendere tutta la documentazione che abbiamo visto, quella tecnica proprio dell'API, e capire come fare il mapping delle integrazioni.  Quindi una prima bozza di possibili API che loro già espongono, poi un'altra domanda, poi te la faccio dopo, di quale API espongono, quello già l'abbiamo fatta.  Me ne resta fuori solamente una, che è quella degli agenti, ma credo che non è che voi create tutti i giorni agenti, quindi praticamente quello lì si può creare.  La volta che viene assunta una nuova persona, l'agente si crea manualmente su Nexal, si prende il codice, si riporta su Salesforce, e l'integrazione va.  Quindi tramite REST è la cosa più facile, più facile e più veloce dal lato nostro, e senza costi aggiuntivi.

4:50 - Fabrizio Paganelli
  Va bene, io il fatto che, dai, ripeto, il fatto che voi abbiate fatto questo tipo di analisi, siamo giunti a questo tipo di valutazione,  Per me va benissimo anche procedere tramite API, insomma, non assolutamente, poi come dicevi tu, c'è anche la logica del best practice, oltre che il tema dei costi, ma più che altro a ci interessa che il lavoro sia fatto bene, quindi ben vengo, insomma, va bene.

5:22 - Andrea Di Cicco
  Sì, diciamo che se poi tu in futuro vuoi sostituire Nexal con un altro sistema tramite REST è più facile piuttosto che tramite file, insomma, cioè, sicuramente è più flessibile la cosa.  Va benissimo. Solo una domanda, visto che ci siamo, nei file che mi hai mandato, mi hai mandato una cartella che era IN e una cartella che era OUT, immagino che IN siano le informazioni che dal CRM mandate verso Nexal, giusto?

5:48 - Fabrizio Paganelli
  E adesso non me le ricordo, però diciamo che dal CRM, noi dal, aspetta che le vado a riguardare quelle  Se vuoi ti condivido perché ce l'ho qui tanto aperta. Perfetto, perfetto.

6:10 - Andrea Di Cicco
  Allora, dimmi se vedi. Sì. Ok, perché in noi abbiamo agenti, clienti, condizioni di pagamento, destinazioni, fatture, ordini, prodotti e scoperto clienti.

6:30 - Fabrizio Paganelli
  Sì, che questo qui è tutto quello che da Mexal viene trasferito sul CRM. Quindi sono loro che chiamano noi con queste informazioni.  Esattamente.

6:42 - Andrea Di Cicco
  Ok, quindi in, da Mexal al CRM. Ok, e invece quindi out è quello che mandiamo noi che è solo l'ordine.

6:59 - Fabrizio Paganelli
  È solo l'ordine.

7:00 - Andrea Di Cicco
  Allora bisognerebbe capire se nel file che loro hanno condiviso, se queste sono sia le inbound che le outbound, client, error, queste sicuramente sono tutte chiamate inbound, quindi tutte quelle che possono arrivare verso Nexal, ma le possono riutilizzare anche verso i sistemi.  Stemi esterni? Stesso non lo so. Stesso nel documento non lo dice. Parla dei dettagli, questo va l'attimo capito con loro.

8:21 - Aurel mrruku
  In teoria devono condividere una collection oppure un webbook, Andrea. Di solito si usano le collection e ti dicono con dei esempi precisi sulle chiamate in uscita.

8:40 - Fabrizio Paganelli
  Volete che vi metta in contatto con la persona della Passpartout che ci segue, che anche lui è un informatico, tecnico magari tra voi?  Sì, sì, sì.

8:54 - Andrea Di Cicco
  È il tizio che sta in copia nell'email che avevi mandato. Massimiliano, Massimo, aspetta, Paganelli, Paganelli, ora di tipo, no, Andrea Parmigiani, no, Andrea Parmigiani è un nostro collega di Pienissimo.

9:22 - Fabrizio Paganelli
  Ok, io adesso magari...

9:24 - Andrea Di Cicco
  la Marco, forse Marco M? No, Marco M, Marco Montesi, il...

9:30 - Fabrizio Paganelli
  la niente, sta sparandomi a caso, ok, perfetto. No, no, no, non ho messo loro. Comunque magari adesso io chiamo questa persona, glielo anticipo e poi magari faccio in modo di mettermi in contatto telefonicamente o via mail, comunque sia...  Ok, ok, grazie.

9:54 - Elena Spini (ROMI Company)
  Sì, Fabrizio, perfetto, direi che possiamo fare tutto il... Il Mexal è in questo modo. Magari ovviamente tu anticipa il tema che bisognerà costruire una nuova integrazione tramite API, così almeno tanto di cosa parliamo, e poi ci iniziamo a sentire per mail e eventualmente video call se servirà, ecco.  Va bene. Però almeno smarchiamo tutti questi punti. Va bene. Perfetto, perfetto. Ragazzi, su questo avevamo altro? O faremo poi tutto a seguire?  Il tema Mexal è?

10:39 - Andrea Di Cicco
  Facciamo poi, vediamo un attimo con loro. Perfetto, non mi sto dimenticando nulla.

10:47 - Elena Spini (ROMI Company)
  Invece un'altra cosa un po' più, diciamo così, tecnica che abbiamo iniziato a pensare che è uscita l'ultima volta che ci siamo sentiti, era il tema dei bundle e dei pacchetti.  Facendoci un po' di ragionamenti, su Salesforce ci sono delle licenze aggiuntive che servirebbero, ma possiamo adottare una soluzione custom che ci viene forse a nostro aiuto, ma ci servirebbe sapere una cosa importante, ovvero, noi abbiamo detto che un ordine può essere fatto da bundle, cioè da più bundle, cioè quindi che un tutor va e sceglie bundle 1, bundle 2, dove bundle 1 ha due prodotti, bundle 2 ha tre prodotti.  La domanda è, ma potrebbero esserci ordini che contengono sia bundle che prodotti singoli?

11:54 - Fabrizio Paganelli
  Allora, normalmente uno... Un ordine, per come siamo impostati oggi, non contiene più bundle. Un ordine è un bundle. Ok.

12:12 - Elena Spini (ROMI Company)
  Ok, no, pensavo, cioè mi ricordo quelli da palco che erano sicuramente un bundle, ma pensavo che il tutor potesse vendere anche più bundle, invece no.  Cioè, nello stesso ordine non può mettere più bundle.

12:26 - Fabrizio Paganelli
  Ok, ok, ok, perfetto. Dopo, magari vedo di recuperare quel file Excel che vi ho girato, che magari se cerco di spiegarmi anche in modo visivo, perché se no… Se vuoi ce l'ho, se vuoi lo condivido.

12:53 - Elena Spini (ROMI Company)
  Va bene. Parliamo dell'Excel tipologia di vendita.

12:58 - Fabrizio Paganelli
  Esattamente, sì. Ok. Allora, praticamente noi, noi quando, in questo caso qui, vabbè, è una vendita da palco, ma diciamo lo stesso tipo di ragionamento si può replicare anche in altri contesti.  Noi cosa succede? Che prima dell'inizio dell'evento, noi strutturiamo questo bundle qui, che tu vedi esattamente così com'è. Questo con la riga rosa.

13:42 - Elena Spini (ROMI Company)
  Sì, che contiene tutta questa lista di codici articolo. Corretto. Ok.

13:53 - Fabrizio Paganelli
  Il fatto che, per noi è questo qui il bundle, è tutto questo il bundle.

14:04 - Elena Spini (ROMI Company)
  Quindi è semplicemente un insieme di prodotti, quindi un contenitore con un insieme di prodotti.

14:11 - Aurel mrruku
  Esattamente.

14:14 - Elena Spini (ROMI Company)
  E il tutor è uguale, cioè o sceglie i prodotti singoli o sceglie il bundle, ma non li può mettere assieme?  No, no.

14:26 - Fabrizio Paganelli
  In questo caso, in questo caso qui sono vendite da palco, quindi l'ordine è totalmente automatico. Il tutor qui non ci mette le mani.  No, sì, sì, questo sì.

14:38 - Elena Spini (ROMI Company)
  La vendita da palco mi è chiaro. Prima dell'evento si fa il bundle e rimarrà sempre questo. Il problema era cosa fa il tutor.

14:47 - Fabrizio Paganelli
  Ok, il tutor ha diverse possibilità di vendita. Allora, può vendere dei pacchetti che sarebbero... La seconda scheda, quello che voi avete adesso qui evidenziato.  Questo pacchetto segue più o meno la stessa logica delle vendite da palco. Però che cosa succede? Possono essere diversificati cliente per cliente.  Quindi, ad esempio, può succedere che adesso i tutor stanno vendendo una lista di prodotti che stanno chiamando summer, promo summer.  Quindi Marco, il responsabile commerciale, ha detto, bene, durante la promo summer creiamo un pacchetto che contiene, vado qui, che contiene Food Marketing Festival, 1,97 euro, uno omaggio, uno di camerieri venditori, pienissimo live, il totale qui è adesso al di là del numero, 1000 euro.  Voi dovete vendere questo pacchetto a 1000 euro. Quello è e quello i tutor devono vendere. Non c'è storia. Magari il tutor può concedere uno sconto integrativo, potrebbe accadere che il tutor, una volta che nell'ordine inserisce questo bundle, può succedere che magari, perché siccome il cliente è particolarmente, anziché mettere 200 euro di sconto, viene a mettere 210, quello potrebbe succedere.  Ma in linea teorica, quando il tutor vende un pacchetto, quello è e quello deve rimanere.

16:32 - Elena Spini (ROMI Company)
  Ok, ma facciamo finta che questi qua fanno parte del pacchetto Summer. Sì. Non succederà mai che io, tutor, possa vendere il pacchetto Summer più la riga Academy.  Quello lì potrebbe succedere.

16:52 - Fabrizio Paganelli
  Questo potrebbe succedere. Perché quando il tutor si approccia con... Il cliente, oltre a vendergli questo pacchetto summer, potrebbe succedere che guarda ti aggiungo l'academy, quello potrebbe succedere.  Questo era il tema no Aurel che dicevamo? Sì, prego.

17:17 - Aurel mrruku
  Praticamente quello che stavamo pensando era di usare un contenitore che è praticamente il banner e collegare i prodotti con questo contenitore.  Ovviamente il prezzo non sarà poi il prezzo del prodotto, ma sarà il prezzo del bundle e lo usi come una riga nell'ordine.  Quindi il bundle, se vuoi espandere il bundle, vedi tutti i prodotti di quel bundle. La prima domanda era se tu puoi vendere più di un bundle su un ordine?  Hai già risposto no. La seconda domanda è se tu vuoi aggiungere un altro prodotto, non stai parlando della stessa entità, ma stai mettendo insieme, scusa il gioco delle parole, o parlando stessa entità.  Un insieme dei prodotti con un prezzo e un altro prodotto con il prezzo del prodotto che ovviamente avrà un listino, perché mi aspetto che tutti i prodotti abbiano un listino, che quel listino può variare in base al cliente e le scontistiche possono essere automatici oppure manuali anche in base al cliente.  Vuol dire che a livello di prodotto dobbiamo prevedere delle logiche di scontistica basando sul listino, invece a livello di bundle possiamo fare solo sconto manuale diciamo.

18:39 - Fabrizio Paganelli
  Allora il tema è questo, che quando facciamo il pacchetto sia esso bundle da palco che sia esso promo da tutor, promo predeterminata da tutor, quantità, prezzo di listino, sconto è netto?  E in quale momento gli aggiungi un altro prodotto?

19:07 - Aurel mrruku
  Perché forse ha più senso aggiungere per un cliente un prodotto direttamente sul bundle e vendere tutto con un bundle.  Perché c'è la necessità di fare un ordine con un bundle e poi dopo aggiungere diversi prodotti?

19:28 - Fabrizio Paganelli
  Allora, diciamo che adesso ci dovrebbe rispondere Marco. Io, come dire, non seguendo la parte commerciale, faccio un pochino più difficoltà a capire se magari è un evento che può capitare.  Però, ripeto, adesso stanno vendendo questa promo Summer, prezzo netto 1.990, però, secondo me, io come amministrativo non escludo che il tutor, nel momento in cui fa l'attrattiva cliente,  Magari a quel bundle da 1990 gli va ad aggiungere un ulteriore rigarticolo dove gli vende anche l'Academy. L'alternativa sarebbe fare due ordini separati, però uno dice vabbè ti vendo il bundle 1990 ti faccio un ordine, poi ti do anche l'Academy e ti faccio un altro ordine a parte.  Quello potrebbe essere un'opzione. Diciamo che non escludo che, ripeto, qui sarebbe bene che ci fosse stato Marco, in questo caso qui.

20:34 - Sabatino Rinaldi ( Pienissimo)
  Più o meno cerco di rispondere io al perché. O Daniela Proppo, forse? Sì, anche. Però di base, se noi andiamo a modificare il bundle aggiungendo un altro prodotto perché il tutor ha venduto un prodotto in più non incluso nel bundle, più che in termini di ordine di fatturazione non ci sono troppi problemi, però  O c'è un problema poi in termini di statistica, non riusciamo più a, cioè se aggiungiamo un prodotto che non c'entra nulla con quel bundle e X commerciali aggiungono i prodotti che vogliono, va a finire che noi perdiamo la statistica.

21:14 - Elena Spini (ROMI Company)
  Scusa, non stiamo dicendo di aggiungere prodotti al bundle, stiamo dicendo esiste la possibilità che per un ordine un tutor vende il pacchetto con i prodotti che avete scelto, che sono per tutti uguali, e poi in più, come un'altra riga dell'ordine, ad esempio la riga Academy, il pacchetto più un altro prodotto Academy, questo è il problema.

21:44 - Fabrizio Paganelli
  Anche dal mio punto di vista, come diceva Sabatino, secondo me sarebbe più pulito dire, bene, cliente a Fabrizio Paganelli, ti vendo il pacchetto Summer a 1990, ti faccio un ordine, poi se vuoi anche l'Academy ti faccio un ordine separato.  Secondo me così sarebbe più pulito, questo che diciamo, no? Però ecco, magari che problema darebbe aggiungere una riga ordine ad un ordine dove c'è dentro c'è già un bundle?

22:14 - Aurel mrruku
  Il problema è strutturale perché un prodotto è un'entità a sé, invece il bundle è un insieme di entità e quando tu li metti sullo stesso ordine, se tu hai la possibilità di cambiare la quantità sul prodotto, devi in qualche modo customizzare che sul bundle non puoi cambiare la quantità.  Se tu cambi la quantità sul bundle, in automatico a tutti i prodotti di quel bundle devi triggerare, devi fare in modo che la quantità coincida con quella dell'insieme, quindi del bundle.  Ho capito. Ovviamente poi ci sono anche diversi discorsi in base al listino, perché Salesforce ha già di standard che un prodotto deve avere un listino di prezzi, invece il bundle in questo caso non avrà un listino di prezzi, il bundle avrà un prezzo fisso definito nel momento in cui te configuri quel bundle.

23:34 - Elena Spini (ROMI Company)
  Quindi possiamo definire che abbiamo bundle e prodotti separati, non virali insieme?

23:43 - Aurel mrruku
  Posso suggerire qualcosa, semplicemente un'idea. Se non vogliamo proprio vedere nella schermata dell'ordine, nella stessa schermata, poi su un'altra schermata lo possiamo far vedere, i bundle, quindi espandere il  Vedere tutti i prodotti del bundle, ma il bundle come un record, lo posso gestire facilmente, perché ti dico, considerami come un record, sia il bundle che il prodotto, che c'entra niente con il prodotto standard di Salesforce.  Così, tu hai un prezzo fisso sul bundle, e io ti dico, sul bundle non puoi cambiare il prezzo, tranne aggiungi uno sconto aggiuntivo, invece ti tratto anche il prodotto, scusa il termine anche qua, come un bundle.  O meglio, come la stessa struttura, solo a livello di order, a livello di ordine. So che è un po' complicato a spiegarlo, forse cerco anche a fare un schermino.  Però, secondo me loro volevano le righe, da quello che ho capito.

24:50 - Elena Spini (ROMI Company)
  Sì, sì.

24:52 - Fabrizio Paganelli
  Cioè, noi quando mi mettono in pang di un tutor, inserisco l'ordine, quell'ordine è il pacchetto summer, quindi va... Vado nella riga articolo e scriverò codice X 1990, quantità 1 1990, mi deve venire fuori la lista dei prodotti componenti quel bundle, quella deve venire fuori, perché poi dopo c'è tutto un tema legato al fatto che i prodotti componenti diventano biglietti per entrare ai corsi.

25:31 - Aurel mrruku
  Allora, non è che non si può fare, solo che poi dobbiamo customizzare totalmente lo standard di Salesforce, quindi la schermata, la tabellina che ha insieme i bundle, i prodotti, si devono mettere n condizioni in base a quello che stai caricando, e non solo, quando tu crei l'ordine, ovviamente devi anche cercare il prodotto oppure il bundle, quindi in qualche modo dobbiamo dire, quando vuoi cercare il bundle, premi  Un fleghettino che fa il sersolo sui bundle, invece quando vuoi cercare il prodotto fai il sersolo sui prodotti.

26:09 - Fabrizio Paganelli
  Io però ho capito il tema, però vorrei fare un passo indietro, perché tanto noi il tema è che noi il 50% delle vendite le facciamo tramite bundle, quindi com'è possibile che non sia venuto fuori prima il tema del bundle, già quando abbiamo fatto l'analisi iniziale, prima che diciamo fosse definita l'offerta e che non sia stato considerato all'interno delle licenze?  Adesso quando arriva la Daniela, questa qui è la prima cosa da dirle, perché non penso che sarà molto felice di questo tipo di notizia, cioè ripeto, tanto che vendiamo tramite bundle,  Lo sapevamo tutti fin dall'inizio, perché, ripeto, vendiamo più del 50% delle nostre vendite, sono attraverso il discorso bundle.

27:15 - Elena Spini (ROMI Company)
  Fabrizio, sono d'accordo con te, ottima domanda. Noi questo file l'abbiamo avuto settimana scorsa, quindi il tema del bundle è uscito l'ultima volta in quella riunione.  No, però al di là del file che l'abbiamo dato la settimana scorsa.

27:33 - Fabrizio Paganelli
  No, ma proprio anche parlando. All'inizio, all'inizio, quando parlavamo, dicevamo le vendite da palco, eccetera, eccetera, certi tipi di argomenti li abbiamo trattati diverse volte.  Secondo me, visto che abbiamo, diciamo, una grossa componente delle vendite effettuate tramite i bundle, probabilmente vale la pena queste licenze che le abbiamo, almeno ci semplifichiamo la vita.  Se no partiamo già zoppi. Però bisogna capire in termini di licenze quanto sarebbe, capire anche la Daniela, poi dopo che cosa ne pensa di questo tipo di situazione che si è verificata.  Non so, te cosa dici Sabatino?

28:19 - Sabatino Rinaldi ( Pienissimo)
  No, sono d'accordo, nel senso è un argomento che per noi è importante, perché se poi, allora, se la soluzione tecnica la otteniamo lo stesso, così come siamo, bene, però essendo una cosa per noi di, come dice Fabrizio, il 50% delle nostre vendite è basato su quello, noi in un modo o nell'altro la soluzione bisogna trovarla e soprattutto capire il perché non abbiamo questa licenza, cioè.

28:50 - Fabrizio Paganelli
  Più che altro, anche perché, cioè, a me andrebbe bene trovare una soluzione diversa, ma mi sembra di capire che ci sono un po' di limitazioni, un po' di...  In particolarità, non vorremmo partire subito costruendo un accrocchio, capito cosa voglio dire, perché già ne abbiamo fatti parecchi di accrocchi nel CRM attuale, vorremmo partire, come dicevamo all'inizio, con le pratiche operative migliori, al top, quindi, ripeto, se c da comprare una licenza, dipende quanto costa in più questa licenza, non sono io che decido sì o no l'importo, però, secondo me, la Daniela, nel momento in cui arriva, bisogna fargliela presentazione, tu, immediatamente, questo tipo di considerazione.

29:41 - Sabatino Rinaldi ( Pienissimo)
  Sono d'accordo.

29:48 - Elena Spini (ROMI Company)
  Su questo capiamo effettivamente con la... con Daniela dopo e capiamo, magari facciamo anche una proposta di che cosa si potrebbe fare con la soluzione custom di cui parlava anche Aurel e la soluzione che invece serve nella licenza aggiuntiva.  Sì, dobbiamo fare… Cioè, dipende di chi crea il bundle, cioè non sarà una licenza.

30:20 - Andrea Di Cicco
  Allora, io direi, facciamo così, abbiamo preso i requisiti sulla parte di carrello, facciamo una stima lato tecnico dell'effort necessario per poter implementare con una customizzazione nella cosa, che poi cercheremo di sfruttare il più possibile lo standard, ma diciamo la cosa un po' più complessa, non si crea l'accrocchio, ma è solo per renderla facilmente visibile a voi, è solo quello.  Perché poi alla fine, a livello di creazione, è solamente andare a mettere un oggetto che vi crea il collegamento tra tutti.  È solo poi una questione di visualizzazione lato vostro. che a livello di front-end vi mostra la cosa. Quindi facciamo un attimo una stima tecnica.  Poi magari facciamo un passaggio con Galotto che ha gestito pienissimo. Ele? Sì, sì. Allora facciamo poi magari un passaggio un attimo con Galotto e vediamo un attimino lui che ci dice.  E così riso che...

31:20 - Fabrizio Paganelli
  Magari se potete fateci magari anche vedere quale sarebbe la differenza tra operare con i bundle oppure operare con questa diciamo customizzazione.  Di modo tale che ci rendiamo conto, capito? Perché ripeto, noi siamo abbastanza articolati come azienda e siamo anche abbastanza, come posso dire, soggetti a cambiamenti.  Per cui se abbiamo un sistema diciamo che... Cresce in modo nativo, secondo determinate logiche, è meglio piuttosto che, ripeto, a fare delle cose customizzate, che poi magari se facciamo la cosa customizzata, tra un mese cambiamo determinate modalità e la cosa customizzata non va più bene, capito?  Quindi non so se mi sono riuscito a spiegare.

32:52 - Elena Spini (ROMI Company)
  No, Questo in realtà ha senso Dobbiamo vederlo anche con te, Fabrizio, dobbiamo aspettare invece Daniela, perché questa era un po' una parte che forse più seguiva il ragazzo che segue la parte commerciale.

33:16 - Fabrizio Paganelli
  Io sul tema Lead Opportunity, a meno che non sia sabatino aggiornato, io qualsiasi cosa dico, non riesco di dire delle stupidate, quindi preferisco non… Allora, voi sulla parte Lead Opportunity ci volete far vedere quello che avete implementato?

33:38 - Elena Spini (ROMI Company)
  No, no ho implementato, volevo far vedervi il flusso, il flusso che avevate chiesto di ridesegnare, ci avevano detto, ridesegniamo il flusso che ci avevate dato in ottica Salesforce.

33:50 - Sabatino Rinaldi ( Pienissimo)
  Ok, quanto tempo pensi che ci vuole per farcelo vedere?

33:53 - Elena Spini (ROMI Company)
  È un flusso in cui dobbiamo discutere degli stati, delle action da fare e… quali… Ok. Stiamo mettendo tante cose per Daniela, per quello.

34:07 - Fabrizio Paganelli
  Anche questo era un argomento anche per Daniela.

34:11 - Elena Spini (ROMI Company)
  Esatto, cioè è una cosa così.

34:15 - Sabatino Rinaldi ( Pienissimo)
  E direi che possiamo, se riusciamo a vederlo un po' più tardi, che si collega anche Daniela.

34:21 - Elena Spini (ROMI Company)
  Ok, poi altro tema che mi ero segnata, in realtà erano dei punti aperti che avevamo lato marketing, quindi questo non so se posso parlare con te Sabatino, perché marketing avevamo fatto una riunione, due settimane fa forse, e ci aspettavamo delle risposte, quindi non so se hai novità su questo.  Allora la riunione era la riunione del 23, sui form che dobbiamo girarvi con Matteo.

34:57 - Sabatino Rinaldi ( Pienissimo)
  C'è il tema del sottodominio.

35:00 - Elena Spini (ROMI Company)
  Il tema dei form, e senza quelli, noi però siamo un po' bloccati sul tema marketing, quindi non riusciamo a fare altro.

35:11 - Sabatino Rinaldi ( Pienissimo)
  Su questa cosa qui, smuovo Matteo e cerchiamo di dare il prima possibile, perché se ne occupa lui.

35:21 - Elena Spini (ROMI Company)
  Ok, se vuoi metto in chat la minuta. Sì, ce l'ho prima, sembra quella lì, però sì, se me la metto in chat la giro di nuovo.  Esatto, per cercarla così. E qua c'è tutto il tema delle varie richieste, ed era il 23 giugno la mandata.

35:58 - Sabatino Rinaldi ( Pienissimo)
  Stare dietro a Matteo. E' uno dei lavori più difficili che ho in pienissimo.

36:06 - Elena Spini (ROMI Company)
  Ok, beh, quindi finito questo, in realtà c'è la parte dei lead opportunity, o c'hai altro ancora da dirci? Poi in realtà vi volevo condividere a questo punto il piano, che sicuramente interesserà anche a Daniela, però a questo punto iniziamo a parlarne un po' anche con voi.  E poi ho finito i miei temi, credo. Aspetta, vabbiamo a vedere altri open point che ho. No, ma anche il discorso WooCommerce di cui parlare.

36:39 - Fabrizio Paganelli
  E c'era anche, non so se vi ricordate, avevo chiesto il tema, non mi ricordo come l'avevate chiamato, che mi avevate detto che ce l'avevamo, quello che ci potrebbe sostituire l'attuale Zoo Analytics.

36:56 - Elena Spini (ROMI Company)
  Ah, bravo, quello sì, un tema. Aspetta, aspetta che prendo i miei appunti. Allora su quello Data Cloud era, il tema di Data Cloud abbiamo fatto un passaggio su questo e mi sarei riallacciata con il piano ma praticamente senza dati non possiamo permetterci di utilizzare Data Cloud e considerando il piano e le varie tempistiche che ci siamo dati l'eventuale import che andremo a fare sarà per inizio settembre.  Quindi prima di quella data Data Cloud sarebbe inutilizzabile.

37:34 - Fabrizio Paganelli
  Ok, quindi prima del primo settembre niente. Sì, idealmente sì.

37:43 - Elena Spini (ROMI Company)
  Considera che diciamo così, adesso poi rivediamo il piano, diciamo primo settembre idealmente, ma primo settembre vuol dire che noi siamo in grado di avere i dati nella piattaforma e per traguardare questo...  Questo dato c'era tutta una logica di pulizia dei dati che dovvate gestire. ricordo che quando parlavamo tipo degli account dicevate che avevate un sacco di duplicati, corretto?

38:14 - Fabrizio Paganelli
  capito, sì sì ho capito.

38:18 - Elena Spini (ROMI Company)
  Parlavamo...

38:19 - Fabrizio Paganelli
  Quindi niente diciamo che lo dobbiamo, questo lavoro di analytics eccetera eccetera lo possiamo fare soltanto alla fine quando abbiamo già implementato tutto quanto per cui...  Sì corretto. Quindi niente andiamo...

38:32 - Elena Spini (ROMI Company)
  Sì tipo avevate una cosa come 6.000 tra l'idea account ma in tanti erano duplicati e eravamo più o meno a 7.500 paganti.  Quindi quello che dobbiamo portare sulla piattaforma sono dati puliti perché se no andiamo già a sporcare quello che era la piattaforma.

38:53 - Fabrizio Paganelli
  Ma noi questo qui non lo possiamo utilizzare neanche attraverso... Perciò, diciamo, perché io adesso in una prima battuta su questo data cloud non avrei necessità di importare i dati del CRM.  Ma comunque per la configurazione servono. Quindi niente, allora adesso mi raccordo con Elisa, facciamo quel lavoro che diciamo proviamo a farlo con altri strumenti, poi nel momento in cui saremo pronti lo implementeremo anche su Salesforce, va bene?  Perfetto.

39:32 - Elena Spini (ROMI Company)
  Allora, questi di marketing abbiamo detto che poi ci pensa Matteo.

39:40 - Sabatino Rinaldi ( Pienissimo)
  Fortuna che il marketing non dipende dal CRM, se no eravamo fregati.

39:46 - Elena Spini (ROMI Company)
  No, comunque ora Matteo lo smuovo su sta roba qui e cerco di farlo vedere possibile.

39:52 - Sabatino Rinaldi ( Pienissimo)
  Per favore.

39:53 - Fabrizio Paganelli
  Così ci liberiamo il marketing.

39:55 - Elena Spini (ROMI Company)
  Ah, invece poi un altro tema di cui possiamo parlare intanto, è tema datato. DocuSign, su quello siete riusciti a fare qualcosa?

40:05 - Sabatino Rinaldi ( Pienissimo)
  Allora, su quello, su quello in realtà io mi sono registrato i 30 giorni di free trial, in realtà ce'ho già qui aperto, l'ho fatto proprio ieri, se mi fa accedere magari sarebbe più bello.  A me sembra che qui in realtà, lato nostro, basta pagare. Ci serve la licenza, sì. Cioè, nel senso, vedo già la parte di...  Guarda, ti condivido lo schermo, se ti può tornare utile. Ti condivido lo schermo? Sì, Ok, perché... Io qui vedo, vedete?

41:05 - Fabrizio Paganelli
  Adesso sì, sì.

41:07 - Sabatino Rinaldi ( Pienissimo)
  Ok, se io vado in integrazione App Center, c'è già Salesforce.

41:23 - Aurel mrruku
  Ovviamente per installare Salesforce, dopo usare su Salesforce, forse c'è anche qua sulla guida un pacchetto che si installa all'interno di Salesforce, che lo deve scaricare da AppExchange, che è praticamente App Store di Salesforce.

41:36 - Sabatino Rinaldi ( Pienissimo)
  Quindi l'integrazione, cioè nel senso, noi una volta che facciamo l'abbonamento qui a DocuSign, l'integrazione la facciamo tramite l'App Center?  Tramite AppExchange praticamente di Salesforce.

41:50 - Aurel mrruku
  Quindi quello che ci interessa è proprio l'utenza di DocuSign, perché quando collegheremo Salesforce con DocuSign, tutta la parte di Bill  deve andare a chi deve pagare alla fine, quindi a una vostra utenza. Di solito quando facciamo integrazione con DocuSign parliamo anche con un commerciale lato DocuSign per trattare un po' anche sul prezzo, il piano, eccetera, perché di solito DocuSign ti fa pagare in base al documento firmato, quindi per n documenti firmati c'è un tot prezzo.  se mi sbaglio, sparo un po', non so, se sono cambiati i costi, ma era tipo 2-3 euro o quasi 2 euro se mi sbaglio alla firma, quindi a documento firmato.  Ok, e questi numeri li dovete discutere con qualcuno lato commerciale? No, certo.

42:56 - Sabatino Rinaldi ( Pienissimo)
  Quello che vi voglio chiedere è, dato che dobbiamo essere noi ad A trattare con questo commerciale, noi gli dobbiamo, cioè ci è utile spiegargli che questa licenza ci serve per l'integrazione con Salesforce, bla bla bla.  A lui interessa poco perché il documento, cosa succede?

43:14 - Aurel mrruku
  Quando tu ti integri con Salesforce, Salesforce il documento lo invia al DocuSign e DocuSign poi lo invia al cliente.  Quindi quando tu ricevi un documento di DocuSign, un documento da firmare con DocuSign, tu lo vedi il documento che ti invia a DocuSign, non il documento che ti invia a Salesforce.  Poi quando tu firmi, il documento va a DocuSign e DocuSign poi lo invia a Salesforce. Ok. Quindi se riesci anche a mandare una mail...  Io ho parlato, DocuSign, i ragazzi con cui ho parlato erano italiani, quindi naturalmente hanno diversi uffici anche in Italia, anche la parte commerciale era tutta italiana.

44:13 - Sabatino Rinaldi ( Pienissimo)
  Quindi basta non parliamo con un commerciale oppure io devo andare qui, comprare e abbiamo fatto.

44:18 - Aurel mrruku
  Meglio che parli con un commerciale. No, no, certo, certo, era per capire. Poi ti dico anche un'altra cosa, nel momento in cui ti hai installato DocuSign su Salesforce, ogni user su Salesforce deve essere abilitato per mandare documenti via DocuSign con dei permessi ad hoc.  Perché quando arriva la mail al cliente, arriva con la mail dello user di Salesforce. Quindi nel nostro caso, da quello che ho capito io, a voi basta un user.  Quindi sarebbe. Perché il documento verrà inviato in modo asincrono quando, da quello che stavamo parlando anche con Elena, to giorni prima dell'evento.  Quindi non è un'azione manuale che si deve fare sulla piattaforma, ma è un'azione automatica che succede con delle tempistiche da decidere da noi e da business.

45:25 - Sabatino Rinaldi ( Pienissimo)
  Sì, di base, noi, verrà mandato dall'account, dalla mail, diciamo, che è padrona del funnel, chiamiamola così, quindi partirà tutto dallo stesso contatto.  Quindi di base basta un profilo, come dici te.

45:43 - Aurel mrruku
  Sì, un utente, un utente, senso.

45:45 - Sabatino Rinaldi ( Pienissimo)
  Esatto, se l'utente è, non lo so, marketing, chiocciapensio.com, è solo lui, giusto? Intendi questo? In teoria, sì, sì. Ok, però i permessi che possiamo mettere si mettono da...  DocuSign perché lo collega a DocuSign quindi da qui.

46:03 - Aurel mrruku
  Allora, i permessi, ci sono i permessi di Salesforce e i permessi che ti fornisce il DocuSign. Quando tu scarichi il pacchetto su Salesforce, la mail di Salesforce, degli user di Salesforce deve coincidere con la mail degli user di DocuSign e alle user di Salesforce ti puoi dare il permesso a The Admin come su DocuSign.

46:24 - Fabrizio Paganelli
  Che bel giro che hanno fatto, va bene.

46:30 - Aurel mrruku
  Poi, quando lo metti in piedi il flusso è molto molto facile a gestirlo perché poi entrai direttamente qua e puoi vedere tutte le mail, lo stato del envelope lo chiamano a loro, quindi se è stato inviato, se è stato firmato, in che data, eccetera.

46:49 - Sabatino Rinaldi ( Pienissimo)
  Chiaro, quindi niente, allora seguo il vostro consiglio del commerciale piuttosto che comprare diretti così.

47:00 - Aurel mrruku
  Ovviamente più grandi sono le numeriche, meglio tratti anche col commerciale, quindi se c'hai dei numeri quando fare la call con lui dicendo guarda noi abbiamo di solito all'anno tot documenti da firmare, lui ti dirà delle fasce di prezzo che… Sì, basta dirgli quindi i partecipanti ai nostri eventi e il numero di partecipanti totale di tutti gli eventi annuali e su quello si fa il prezzo, va bene?

47:33 - Sabatino Rinaldi ( Pienissimo)
  Sì, va bene, grazie.

47:38 - Aurel mrruku
  Grazie a te.

47:42 - Elisa Migliano
  Noi abbiamo anche un tema che sono i read che mandiamo tramite ZoSign, non so Fabri era una di quelle cose che volevamo dire poi alla fine non siamo mai riusciti.  Sì, hai fatto bene a ricordarlo perché questo qui è effettivamente…

48:00 - Fabrizio Paganelli
  Ci siamo, almeno che mi ricordo io, ci siamo dimenticati noi, nel senso che quando noi mandiamo via i contratti, che erano, diciamo che sono quei documenti che abbiamo mandato via Elisa, oltre a quella all'invio del contratto, noi spesso ai clienti che accettano di pagare tramite RID, mandiamo via questa comunicazione dove dentro c'è allegato un modulo RID che il cliente deve sottoscrivere, consegnare alla sua banca e restituirsi a noi firmato.  E attualmente lo facciamo, questo ciclo, tramite Zosign, quindi non so se può essere integrato sempre tramite questo nuovo strumento.  Hai fatto bene ricordarlo Elisa perché io mi stavo sinceramente dimenticando di queste cose, di dirla oggi intendo.

48:49 - Sabatino Rinaldi ( Pienissimo)
  E quindi anche quello è un documento da firmare?

48:53 - Fabrizio Paganelli
  È un documento che il cliente deve firmare? modulo, esatto, che poi dopo deve portare in banca, quindi...

49:00 - Elisa Migliano
  Non so se ci possono essere altri modi, ma...

49:05 - Elena Spini (ROMI Company)
  Ma quanti pagano in questo modo?

49:09 - Fabrizio Paganelli
  Da noi pagano tantissimi clienti, pagano con modalità RID.

49:20 - Aurel mrruku
  Riuscite a dare un esempio concreto? Perché forse non ho capito il ciclo di vita di questo documento.

49:28 - Elena Spini (ROMI Company)
  Scusa Aurel, una cosa anche per capire, sarebbe tutto il giro che abbiamo visto dei pagamenti per bonifico bancario? No, è un'altra cosa.

49:37 - Fabrizio Paganelli
  Diciamo che, allora, dopo magari l'Elisa vi fa vedere visivamente il documento, se c'è modo di condividerlo. Allora, noi facciamo i nostri ordini, facciamo le nostre fatture, diciamo che 50%, 50%, 50% ci pagano con bonifico bancario.  L'altro 50% ci paga tramite... Modalità di pagamento RID. Il RID sostanzialmente è una sorta di addebito automatico che viene fatto un po' come la RIDA fondamentalmente.  un addebito automatico che esiste un flusso di informazioni tra la nostra banca e la banca del nostro cliente dove la nostra banca dice alle banche dei nostri clienti Guardate che il cliente tal dei tali al 31 di luglio deve pagare 500 euro.  Questo qui è il flusso, il tracciato dati,'importo, il numero di fatture, eccetera, eccetera. Quindi c'è una sorta di addebito, vi addebito nella banca dei clienti e accredito alla nostra banca automatico alla fine del mese.  Per poter fare questo però è necessario che il nostro cliente autorizzi a questo addebito automatico. È un po' come quando a noi a casa nostra paghiamo le utenze telefoniche o energia o luce.  tramite la debita automatica, stessa cosa, il RID. È come le domiciliazioni che sono della banca, dai. Esattamente, le domiciliazioni delle utenze domestiche, la modalità è la stessa, però è necessario che il nostro cliente sottoscriva questo documento, perché altrimenti, se non esiste l'autorizzazione da parte del cliente, è una sua firma, è una sorta di, come posso dire, non voglio usare i termini giuridici sbagliati, ma è sorta di appropriazione in debita, fondamentalmente.

51:32 - Aurel mrruku
  Ma l'atto, l'atto legale, la firma si può fare digitale? Perché è da capire, perché non tutte le banche accettano firme digitali.  Non so.

51:50 - Fabrizio Paganelli
  Noi abbiamo, faglimo a vedere.

51:53 - Elisa Migliano
  Sì, l'avevo mandato Sabatino, così magari riusciva a mettere in chat, perché non riesco. Noi non abbiamo mai riscontrato dei problemi a riguardo sulla firma digitale, cioè tutte le banche, tutti i clienti non ci hanno mai mostrato questo dubbio comunque.

52:14 - Aurel mrruku
  Voglio palesemente una firma digitale perché c'è solo sign sopra, quindi va bene. Si la prende come certificata? Ok, chiaro, quindi invece i dati su questo documento ovviamente si popolano in automatico da parte del CRM?

52:35 - Elisa Migliano
  No, tutti i campi lì, a parte i primi tre campi che sono il numero, che è il nostro codice sterile di MXAL, e l'ha scritta pienissimo la prima e seconda, tutto il resto compila il cliente.  Ok. E a netto ovviamente le dati nostre, quindi pienissimo, SM sono dati nostri, Strada Rovete è un dato nostro, K, Falciano.  Però i dati del cliente personale li... Quindi questo pezzo qui lo compila il cliente, questo è il nostro, questo sopra è tutto nostro, questo è il nostro, questo lo compila, si precompila in automatico perché è DocuSign, più la firma.

53:21 - Elena Spini (ROMI Company)
  Ma è Mexal che crea questo documento? No, è DocuSign.

53:28 - Aurel mrruku
  Sarebbe DocuSign praticamente, un template, un template, però è template dinamico quindi devi far prevedere quei tag là che sono le informazioni che deve mettere il cliente prima della firma e metterli ovviamente come campi obbligatori altrimenti succede un casino.  E ovviamente poi questo documento voi lo collegate con firma.

54:02 - Elisa Migliano
  No, noi dopo inseriamo a mano questi dati anagrafici e comunque delle coordinate bancarie all'interno dell'anagrafica del cliente su Nexal.  Ok. E poi andiamo ad agganciare la fattura con la modalità di pagamento del RIV, però tutto su Nexal.

54:24 - Elena Spini (ROMI Company)
  Sul CRM, Aurel, secondo me, si creerà questo documento nel momento che ci manderanno la fattura. Relativa a un ordine.

54:34 - Aurel mrruku
  Sì, ma stavo pensando, perché noi tecnicamente possiamo anche automatizzare nel momento in cui loro firmano, quando firmano, va su DocuSan, DocuSan ci porta questo documento, questo documento lo possiamo mettere sotto il contatto che sarebbe praticamente, o sotto l'account che sarebbe l'azienda o sotto il contatto che è il referente.

54:55 - Elisa Migliano
  Allora, noi adesso attualmente vediamo questi moduli compilati all'interno. Ok, ok.

55:04 - Fabrizio Paganelli
  Anche perché in uno dei primi campi che avete visto in quel modulo c'era un codice, quello lì è il codice cliente che è presente su Mexal, tema contabile, senza di quello l'incasso da parte del cliente non va a buon fine perché è una delle informazioni fondamentali che devono esserci nel flusso di trasmissione dei dati da nostra banca alla loro, quindi è necessario che quel codice corrisponde esattamente al codice cliente presente su Mexal, cosa che per clienti nuovi non è detto che ci sia, cioè nel senso che se io ho un nuovo cliente, sono il tutor, inserisco l'account all'interno del CRM, poi dopo questo cliente,  Il codice cliente di Mexal lo attribuisce al sistema contabile, come siamo strutturati adesso. Magari dopo con le API funzionerà in modo diverso.

56:10 - Aurel mrruku
  Mi aspetto che questo cliente all'inizio non sarà un customer, sarà un prospect, quando non ha creato l'ordine. Quando crea l'ordine, l'ordine deve andare su GRP, praticamente sull'altro sistema, e in quel modo là, se l'ordine è stato generato, con successo, poi l'account deve diventare customer, anche lato Salesforce, e solo in quel momento deve partire questo flusso di generazione di questo documento qua.  Esattamente, esattamente sì. Quindi, tornando su le API, non quelle che volano, ma le API. Stiamo anche dicendo che in e out non è proprio quello che c'era scritto là, in vuol dire che tutti quelli che arrivano su Salesforce, ma si deve prevedere anche un inserimento da CRM a IRP dell'account che molto realmente andrà insieme all'ordine se quell'account è prospect.

57:28 - Sabatino Rinaldi ( Pienissimo)
  Io comunque appena ho scritto ai commerciali di DocuSign, sperando che mi rispondano alle breve e niente, però poi chiudiamo anche con loro e quando abbiamo tutto, vi avviso.

57:43 - Elena Spini (ROMI Company)
  Comunque Aurel, non esisterà mai un caso in cui sei prospect e fai un ordine.

57:52 - Aurel mrruku
  Quindi lì proprio disabilitiamo la possibilità di che... Se sei un ordine, se sei un cliente, perché con...

58:00 - Elena Spini (ROMI Company)
  Con loro, ecco, su questo infatti era la parte che dovevo far vedere con Daniela. Se tu vuoi un preventivo, sei un cliente, perché hai un'intenzione a pagare.  Sì. Ok.

58:12 - Aurel mrruku
  Ma c'è un momento in cui quel prospect va su ERP, per forza.

58:20 - Elena Spini (ROMI Company)
  Se tu hai creato su Salesforce un account, oppure non crei gli account su Salesforce. No, li crei, ma perché deve andare il lead su ERP?

58:33 - Aurel mrruku
  Sto dicendo, tu quando crei un account su Salesforce, quell'account in qualche momento, il ciclo di vita dell'account, deve diventare customer, vero?  Sì, un account è un customer. Non è detto. Noi qua stiamo dicendo, tutti gli account che sono su ERP sono customer, perché hanno questo codice.  Poi ne parliamo. Sì, infatti, infatti.

59:03 - Elena Spini (ROMI Company)
  Poi vediamo questa cosa tecnica, però vabbè, ho capito, ma nì, cioè, ho capito cosa intendi, cioè che magari non hanno il codice, non sono allineati i sistemi.  Ok, non può poter generare un ordine. Questo, questo poi dai, lo capiamo, va bene. Già che stavamo guardando i documenti, perché non parliamo dei documenti che stavamo vedendo Aurel per il tema della privacy?  Condivido io. Sì.

59:38 - Aurel mrruku
  E le varie firme.

59:40 - Elena Spini (ROMI Company)
  Sì. E poi mi ricollego alla mail di Sabatino che mi ha mandato un sacco di ordini e volevo capire effettivamente quelli che documenti erano, in che momento li mandiamo.  Allora, quali li dividi? In che ora? Allora, questo era uno dei primi che ci avevate mandato, condizioni generale a fronte dell'acquisto di un corso, si vede?

1:00:15 - Sabatino Rinaldi ( Pienissimo)
  Sì.

1:00:16 - Elena Spini (ROMI Company)
  Ok, quindi qua abbiamo visto che come dato dinamico, chiamiamo così, c'è il cliente, quindi il nome del cliente, cioè sarebbe il nome del ristorante, in realtà, e il il referente del ristorante.

1:00:43 - Sabatino Rinaldi ( Pienissimo)
  Qui c'è Elisa che sicuro ci risponde meglio, però credo che il cliente, in quel caso sia il nome e cognome del cliente.  Ok, ragione sociale. Ragione sociale.

1:00:55 - Elena Spini (ROMI Company)
  Sì. Quindi qua sarebbe, allora, il nome della camera.

1:01:00 - Aurel mrruku
  Sì, esatto.

1:01:02 - Elena Spini (ROMI Company)
  Ragione sociale, nome account e il nome del contatto che è il referente. Esatto, sì, che poi lì in realtà sono già dei campi firma.

1:01:17 - Elisa Migliano
  In che senso sono dei campi firma? il cliente, vabbè, c'è Elisa Test, poi c'è il rappresentante legale protempore e qui c'è la firma del cliente, cioè anche qua potrebbe fare la firma al cliente.  C'è proprio un campo firma.

1:01:32 - Aurel mrruku
  Ok, ma qua sotto... Cioè qua comunque...

1:01:37 - Elisa Migliano
  Cioè è come se al posto di Giuliano Lanterti si fosse la c'è la firma.

1:01:41 - Elena Spini (ROMI Company)
  Ok, perfetto, perfetto. Perfetto. È uguale sotto e qua ci immagino che non ci sarà la data. Esatto. Che deve essere dinamica.  E questo documento lo mandiamo... Anche qua un altro, ma uguale. Lo mandiamo ogni volta che si vende un evento o un corso?

1:02:11 - Elisa Migliano
  Esatto.

1:02:19 - Elena Spini (ROMI Company)
  Ok. Invece, datemi un secondo, che prendo la mail dell'altro giorno, ricondivido. Qua invece avevamo diversi documenti. Quindi qua parliamo del servizio di Performance Plus, quindi immagino il servizio diciamo di annuale, semestrale, non mi ricordo quanto era, annuale, ok, con le diverse rate, diverse logiche di rinnovo eccetera che c'eravamo detti, detti, iniziato a dire.  Qua invece ogni volta che si vende il servizio di Performance Plus di un anno si manda questo documento? È un contratto, quindi sì.  Ok. Domanda. Contratto.

1:03:50 - Aurel mrruku
  Vai. Questo contratto quindi si genera una volta all'anno e si salva sul CRM e poi viene inviato questo template?  Oppure si deve generare in modo dinamico ogni volta che abbiamo questo tipo di contratto nel flusso dell'ordine?

1:04:09 - Elisa Migliano
  Allora, noi attualmente diciamo che su zona struttura è completamente diversa, c'era un pulsante con una selezione di moduli che abbiamo creato noi poi con il tempo e ogni prodotto o ogni macro categoria di prodotti a cui era collegato un contratto venire inviata.  questo uguale, anche questo noi appunto lo invievamo con Zosang. Sul futuro non so come sinceramente vogliamo procedere, sarebbe anche bello che venisse magari in automatico, magari leggendo i codici prodotto, non lo so.

1:04:52 - Elena Spini (ROMI Company)
  Ma questo, il servizio è di performance? Antplast è sempre uguale o ci possono essere diverse righe di prodotto?

1:05:07 - Elisa Migliano
  Allora, le righe di prodotto sì, ma semplicemente perché abbiamo adattato più righe, allora intanto ci può essere semplicemente uno che è rinnovo e quindi avrà un altro nome di prodotto, ma io ragionerei troppo per nome prodotto ma per codice piuttosto.  Però si può tenere anche a mente di comunque inviarlo in maniera manuale, passato nel termine, nel senso che piuttosto il tutor si clicca un pulsante, si sceglie quale modello inviare e lo invia, altrimenti, non so, Fabrizio, anche te magari la tua riguardo.

1:05:45 - Fabrizio Paganelli
  Allora, il discorso della Performance Plus è quel tema di cui abbiamo sempre parlato, a cui io ce l'ho molto a cuore, dove vi ho sempre detto qui abbiamo bisogno di un qualche cosa che ci permette di avere...  Per un contratto, perché questo qui ha durata annuale, da data a data, dove ci può essere la fatturazione mensile, trimestrale o quadrimestrale, a seconda dell'accordo con i clienti.  Quindi diciamo che in questo caso qui il contratto andrebbe inviato, siccome alla fine l'ordine è un ordine unico, fondamentalmente, spacchettato in tante righe articolo, vedete una per ogni scadenza di pagamento.  Quindi in questo caso qui sono 20 le nostre rate. Esattamente. Quindi noi avremmo un ordine bundle, passatemi il termine, anzi, dovrebbe essere così.

1:06:39 - Elena Spini (ROMI Company)
  mi Bundle, io me lo stavo immaginando, e qua ho un altro schema da farvi proporre, ma non è ancora, volevo tenermelo per giovedì.

1:06:49 - Fabrizio Paganelli
  Ma benissimo.

1:06:50 - Elena Spini (ROMI Company)
  In realtà mi ero immaginata proprio, anziché bundle, che bundle secondo me sono i bundoli, lasciamo a parte, questi li vorrei chiamare tipo, non so, performance plus, qualcosa di  Per identificare che sono quelli con possibilità di rinnovo.

1:07:06 - Fabrizio Paganelli
  Perfetto, va benissimo. Ecco, però noi avremmo praticamente un ordine unico, complessivamente sono 20.000 euro, qui dobbiamo fatturare a tranche mensili da 1.700 euro, nel momento in cui il tutor fa la proposta al cliente, il cliente accetta, il cliente paga la prima tranche, in quel momento lì, cosa dovremmo fare?  Dovremmo inviargli il contratto al cliente, quindi potrebbe essere un'azione, come dire, che fa manualmente qualcuno, o il commerciale, o l'amministrazione, che nel momento in cui rileviamo, diciamo, l'accettazione da parte del cliente, gli viene inviato il contratto, con un tecnicismo, non so se sia possibile farlo, simile a quello che diceva l'Elisa.

1:07:56 - Aurel mrruku
  Ho già in mente una mezza soluzione, quindi... Praticamente possiamo andare sull'ordine di quel cliente che contiene questo performance plus, l'unico punto che non mi è chiaro è quando capisce il commerciale che è stato pagato la prima tranche.

1:08:17 - Fabrizio Paganelli
  Diciamo che a due... Vai Lirio, vai. No, ero io, ero io.

1:08:23 - Elisa Migliano
  Vai, vai.

1:08:24 - Elena Spini (ROMI Company)
  No, ho detto, su quello ci sono delle logiche Aurel sull'integrazione di Mexal. Cioè, loro fanno delle verifiche manuali e poi effettivamente, no, anzi, fanno delle verifiche manuali e poi aggiornano effettivamente se il pagamento è stato fatto automatico, in realtà automatico, tipo carta di credito, vanno in automatico, quindi quello poi è stato pagato.  Invece con, se fosse tipo bonifico, il pagamento rimane sospeso fin tanto che Elisa, non mi ricordo chi lo fa, Elisa controlla se effettivamente col pagamento è andato a

1:09:01 - Elisa Migliano
  In questo caso in realtà l'invio del contratto non dipende tanto dalla prima transce di pagamento, ma dalla ricezione di interesse del cliente, nel senso che se il cliente conferma l'acconto che pagherà e invia anche copia contabile, che di solito fanno così, un brutto vizio che hanno al tutor, loro gli inviano il contratto.

1:09:28 - Aurel mrruku
  Ok, ma a questo punto è meglio che facciamo un meccanismo manuale direttamente sull'ordine. La prima transce. Diamo una possibilità di inviare, solo che volevo capire quando dobbiamo attivare la possibilità di inviare questo contratto, ma diciamo se l'ordine è invinta, se il soldato commerciale può entrare su quell'ordine, possiamo fare sempre le due.

1:09:56 - Elisa Migliano
  Sì, solo che molti clienti giustamente... Prima di iniziare, essendo che ci sono anche all'interno i termini contrattuali e tutte le parti legate alla privacy, il cliente tende a volerlo vedere prima il contratto di pagare, o per quello che noi spesso lo facciamo vedere prima, o lo diamo già prima.

1:10:21 - Elena Spini (ROMI Company)
  Se non sbaglio, forse avevamo detto di fare al pagamento, eh sì, pagamento, alla firma del contratto, o sbaglio? Che cosa?  Perché avevamo detto, tanto sappi, far partire il, cioè dire che l'ordine è, partirà con le sue tranche e tutto, cioè non era tanto far valere il pagamento della prima tranche, quanto la firma del contratto stesso, perché poi il cliente si pagherà, perché ormai ha firmato un contratto, non avevamo detto questo?

1:10:55 - Elisa Migliano
  Allora, in merito non eravamo particolarmente entrati, però sì, cioè di base... Quando appunto il cliente mi conferma di voler procedere col servizio, io gli mando il contratto, tutte le termine di condizioni e come in questo caso sotto l'ordine, ma in realtà per riepilogo.  Successivamente lui me lo manda e come me lo manda poco dopo mi paga anche. Ma è anche la nostra tutela, perché se lui paga, ma poi noi non abbiamo mai un contratto stipulato, lui non ce lo firma, non abbiamo tutta questa sicurezza, diciamo.  Sì, noi...

1:11:34 - Elena Spini (ROMI Company)
  Potrebbe essere anche, scusa, un'azione manuale magari da parte del tutor che tipo preme un pulsante e dice ok, inviade il contratto.  Sì, esatto, come diceva adesso, esatto, esatto.

1:11:45 - Elisa Migliano
  Quello che mi preoccupa è la generazione di questo contratto.

1:11:48 - Aurel mrruku
  I tutor sono specializzati a capire che questo contratto è fatto in modo corretto, con tranche divise correttamente. Guarda, la generazione sarà automatica del fatto...  Ma ovviamente per arrivare fino alla generazione dobbiamo anche capire come raddrizzare il documento in modo corretto.

1:12:12 - Elisa Migliano
  Allora, scusami se ti interrompo, perché di base noi stiamo guardando la fine del contratto con un ordine di cui ancora non abbiamo ben parlato.  Quindi sicuramente i tutor sono attualmente bravi, tra virgolette, a poterlo stirare, ma non è quello che vogliamo. Cioè, gli ordini, come vi ho sempre detto, che vedete adesso, non sono gli ordini che ci dovranno essere su Salesforce, soprattutto perché sono alla fine dei template di ordini che utilizziamo per tantissimi servizi e sarebbe bello farle anche una sorta appunto di template unico, in modo tale che il tutor possa richiamarlo e non trascriverlo tutto a mano.  Perché attualmente è quello che sta succedendo. No, non mi sono spesso bene.

1:13:05 - Elena Spini (ROMI Company)
  Se devo aprire un altro ordine rispetto a questo, dimmi te, mi sembra che li avevi mandati te questi a Sabatino.  Sì, li avevo mandati, scusami, allora Aurel, continuo pure.

1:13:15 - Aurel mrruku
  Allora, quando parlo di generazione in modo automatico, vuol dire che nessuno scriverà il template a mano, ma deve essere guidato, perché se ci sono due, tre, quattro tipi di template, anche se abbiamo detto che ci sarà solo uno, mi aspetto che non tutti i template saranno uguali, in base agli ordini, dobbiamo guidare, per esempio, se dà la possibilità di spalmare le rate in sei mesi, o dodici mesi, o ventiquattro mesi.  Provo a risponderti io?

1:13:53 - Fabrizio Paganelli
  Sì. Ho capito bene. In realtà, quando noi mandiamo questo contratto, questo contratto... La prima parte descrittiva, tutta questa qui che vi sta facendo vedere adesso non so chi se l'Elisa o l'Elena, dove quello che cambia diciamo è solamente la ragione sociale del cliente eccetera eccetera.  In fondo a questa parte diciamo descrittiva c'è copia dell'ordine quindi in realtà quando noi mandiamo il contratto il contratto è composto da quella prima parte descrittiva che ce l'ha validata l'avvocato eccetera eccetera che è uguale per tutti i clienti tranne le sue informazioni grafiche a cui viene accodato questa parte qui che vedete adesso che questo qui è il preventivo.  il preventivo può essere diverso a seconda dell'ordine esatto ma tutta questa parte numerica sopra non c'è scritto nulla non so se questo è chiaro è chiaro solo che questa parte è semplicemente una foto

1:15:00 - Aurel mrruku
  Fotografia della parte economica dell'ordine, oppure una cosa elaborata, perché se mi dite che Performance Plus sarà semplicemente Performance Plus per 12 mesi con la somma finale dell'ordine, oppure anche a livello di user interface di Salesforce, quando tu compri una Performance Plus, lo devi suddividere in 12 tranche, direttamente a livello di order, capito la differenza?

1:15:34 - Fabrizio Paganelli
  No, ma questo qui non è altro che l'accodamento della stampa dell'ordine.

1:15:38 - Aurel mrruku
  Ok, ok, allora stiamo parlando della stessa vista su tutti gli ordini, quindi è chiaro.

1:15:47 - Fabrizio Paganelli
  Dopo, se il cliente ha 12 rate, avrò una stampa dell'ordine con 12 riga articolo, 1.7 l'una. Se il cliente ha 4 rate, avrò 4 riga articolo da 5.000 euro l  Però l'importo totale è sempre questo da 20.000? L'importo totale può essere 20.000, 20.400, dopo magari ad un determinato cliente gli possono dare i 200 euro di sconto, ci può dare.

1:16:14 - Elena Spini (ROMI Company)
  Vabbè, al netto dello sconto eventuale, però il codice dell'articolo performance plus, servizio performance plus, sarà sempre uno.

1:16:24 - Fabrizio Paganelli
  Esattamente, sì. Qui c'è lo stesso, su questo ordine Mi hai fatto preoccupare, comunque, silenzio. Su questo, su questo ordine qui, qui hai 12 riga articolo, in ogni riga articolo, le 12 riga articolo hanno lo stesso codice prodotto, adesso qui non si vede il codice, ma il codice prodotto è unico.  Sì, perché è sempre Ripetuto per 12 volte. Quando ci sono le tranche da 5.000 euro l'una, ci sarà performance plus tranche trimestrale o quadrimestrale, che avrà un altro codice, ma saranno quattro righe da...  5.000 euro l'uno.

1:17:01 - Aurel mrruku
  Posso fare una domanda che succede spesso sui preventivi o le fatture. Come gestite i casi in cui la divisione non può essere, diciamo, un numero completo?  Quindi ci sono numeri periodici quando fai la divisione, esempio ai 9.000?

1:17:24 - Fabrizio Paganelli
  No, noi facciamo in modo che quando creiamo i bundle, eccetera, eccetera, facciamo in modo di creare dei bundle che hanno un netto arrotondato per bene, insomma, per cercare di evitare di far diventare passi commerciali quando vanno a inserire gli ordini.  Ok, perfetto. Dopo magari a volte non è sempre facile, facciamo degli accrochi, però il bundle sicuramente lo facciamo bene.  Quello che dici tu può capitare quando i tutor... Fanno dei bundle personalizzati per i singoli clienti, quindi fanno un ordine, scusate, in questo caso mi sono espresso male, non è bundle, ma è un ordine con ad esempio 20 rig articolo, con codici articolo diversi, e loro lì quando fanno la trattativa col cliente vanno a cesellare, eccetera, eccetera.  Loro magari possono andare ad arrotondare una rig articolo, però è una gestione, come dire, ad hoc che fanno i clienti in situazioni un po' particolari, ecco.

1:18:31 - Aurel mrruku
  Ok, ovviamente ci serviranno, poi Elena, dobbiamo andare riga per riga su questo template a capire se dobbiamo fare un po' di lifting quando generiamo noi il documento al lato Salesforce.

1:18:50 - Elena Spini (ROMI Company)
  Perché loro hanno diversi temi legali, quindi perché dobbiamo fare lifting? Quindi dobbiamo fare copia in colla di quello che c'è?  Sì, da quello che ho capito sì, perché non penso che volete rivedere i documenti, no? Forse tu Aurel intendevi la stampa dell'ordine?

1:19:13 - Aurel mrruku
  Non solo la stampa, anche la struttura. La struttura. Vedo che non è normalizzato, per esempio. Cosa vuol dire normalizzato?  Che la parte sinistra e la parte destra non sono stessa riga, oppure i spazi, i caratteri.

1:19:28 - Elena Spini (ROMI Company)
  Ah, vabbè, ma per quello sì, possiamo fare quello che vogliamo. Noi intendevo proprio di contenuto, pensavo che dicevi, Al massimo 4-5, sono, vero?

1:19:36 - Aurel mrruku
  Ok, ok, no, vabbè, ma per quello non penso che sia un Quanto è pesante questo documento, giusto per avere un'idea?  No, non lo so. A livello di dimensioni? No, no, a livello di dimensioni è più di, spero, più di 4 mega.  No, è 131 kilobyte. Va benissimo.

1:19:55 - Sabatino Rinaldi ( Pienissimo)
  Mi piace che hai notato che non era normalizzato. Io l'avevo.

1:20:00 - Aurel mrruku
  Nei ultimi 4 anni, soprattutto sui documenti generati da Salesforce, vi dico già che se il documento si fa dal button, quindi dal bottone là, possiamo fare quello che vogliamo a livello di logo, foto, colori, testo, scrittura, eccetera.  Se si deve generare il modo automatico del server, per esempio due giorni prima dell'evento, siamo un po' più limitati, perché il lato server e la libreria non è molto ricca nella generazione del PDF.  L'ho già spaventato con il tema dei biglietti. Poi dobbiamo capire anche la dimensione, perché se ci sono tanti order, questi documenti di solito su altri clienti li salvano su SharePoint.  Google Drive e tengono solo il link del documento sull'ordine per scaricarlo. È un processo a sé che spesso lo usano perché Salesforce ti fa pagare caro lo storage dei file, quindi sopra i 10 GB se mi sbaglio poi devi pagare storage.  Non so nel vostro caso la quantità dei documenti che avete sul vostro CRM, giusto per avere un'idea di quanto peso.

1:21:35 - Elena Spini (ROMI Company)
  usano tanti, altrimenti no, lo so. Aspetta, lasciamo rispondere loro.

1:21:43 - Sabatino Rinaldi ( Pienissimo)
  Documenti penso che ne abbiamo.

1:21:46 - Elena Spini (ROMI Company)
  Avete un'idea di quanto?

1:21:47 - Elisa Migliano
  Sì, ma non so, non saprei quantificare.

1:21:51 - Sabatino Rinaldi ( Pienissimo)
  Sì, sono tanti, secondo me può pesare sullo storage. Su questo ora avevamo già fatto dei...

1:22:00 - Elena Spini (ROMI Company)
  Sì, avevamo già parlato, mi sa. Comunque sì, un'altra soluzione, esatto, poteva essere l'idea di ottenere solo in qualche sharepoint questi documenti, però sì, poi vediamo.  Ma adesso io vorrei capire un attimo questa mail, perché ho visto diversi documenti, quindi ad esempio, torniamo sul tema, ho fatto un ordine di performance plus, questa è un'altra scheda statica che inviamo?

1:22:35 - Elisa Migliano
  Sì, questo qui è praticamente quello che noi andiamo a offrire al cliente, quindi ci sono tutti i servizi che andremo a fare, cioè una panoramica generale, e questo qua lo inviamo con l'ordine, non col contratto.  Non col contratto. O tutte e due, cioè adesso, aspetta, perché ho dei dubbi anch'io, datemi... Un attimo. No, ok, adesso viene inviata solamente con… Allora, in teoria in tutti e due i casi, nel senso che può essere inviata sia tramite il contratto, in allegato sia anche la scheda di quello che andremo a fare, che quando il tutor manda l'ordine, il repilogo del servizio e manda anche la scheda.  Quindi potenzialmente insieme?

1:23:45 - Elena Spini (ROMI Company)
  Sì. Ok. E sono solo questi due? Questi ho visto sono altre cose?

1:23:54 - Elisa Migliano
  sono altri, per Performance Plus quello. Ok. Per Performance Plus sono questi due, quindi contratto più scheda.

1:24:02 - Aurel mrruku
  Ma quindi stiamo prevedendo un invio manuale, quindi quando dico manuale è un altro, ok, perfetto.

1:24:13 - Elisa Migliano
  Cioè, allora, io vi dico così, poi sentiamo anche Marco e Daniela come meglio pensano. Io direi bottone. Vai, vai.

1:24:24 - Elena Spini (ROMI Company)
  No, era per capire di quei numeri stiamo parlando, cioè quanti effettivamente ordini di Performance Plus vengono venduti. dai tutor.

1:24:35 - Fabrizio Paganelli
  Calcola che ad oggi è un servizio che proponiamo indicativamente a un centenaro di clienti.

1:24:42 - Elena Spini (ROMI Company)
  Quindi un bottone potrebbe essere anche una cosa fattibile.

1:24:48 - Fabrizio Paganelli
  Sì, secondo me sì, adesso ripeto, sentiamo cosa dice Marco anche, e quindi avremo 100 contratti e sperando che, diciamo,  Tutti i clienti siano soddisfatti, quando andranno a rinnovo avremo 100 rinnovi, più i nuovi clienti, più altri 100 contratti nuovi.

1:25:08 - Elena Spini (ROMI Company)
  E così via, ha pure 200, ma ve lo auguro.

1:25:12 - Sabatino Rinaldi ( Pienissimo)
  All'infinito. No, è così, è così, non ce lo devi augurare. Esatto, va bene.

1:25:20 - Elena Spini (ROMI Company)
  Questi invece, ne ho altri tre, quindi ad esempio apriamo questo. Allora, questo qui è l'office.

1:25:30 - Elisa Migliano
  offerta che viene inviata con l'ordine e basta, che in realtà neanche con l'ordine, con proprio il preventivo, per i servizi della piattaforma.  Noi attualmente abbiamo quattro moduli della piattaforma, io adesso ve ho inviato uno perché in realtà cambia qualcosa, cioè cambia i moduli che ci sono sotto, che ci sono dentro, ma cambiano di poco.  Quindi viene inviato uno giusto per capire il... Grazie. Grazie. Il flusso. Comunque quando il tutor fa un ordine della Pienissimo Pro, in questo caso Premium, invia questo modulo.  E in questo caso non è un servizio che fatturiamo noi in quanto è l'altra azienda. Eh, infatti stavo dicendo, ma mi ricordo bene, ma stiamo parlando di quelli che è software SRL.

1:26:25 - Elena Spini (ROMI Company)
  Esatto. Ok. Quindi comunque voi fate, cioè fate l'ordine e fate anche il preventivo su questi prodotti della software SRL.

1:26:38 - Aurel mrruku
  E ovviamente nel momento in cui state componendo l'offerta ci avete uno stato dove fate invia preventivo al cliente e qualcuno entra nell'offerta e preme su invia preventivo e questo preventivo si deve firmare?  C'è qualcosa di...

1:27:00 - Elisa Migliano
  No, questo qua è una presa a conoscenza per il cliente, in realtà, dei servizi che ci sono all'interno, non c'è nulla da...

1:27:07 - Aurel mrruku
  Quindi, breve, lasciamo stare DocuSign, stiamo parlando di un flusso dove viene mandato una mail mail, esatto, con un allegato.  Ok, poi ovviamente dobbiamo anche pensare un po' sul template della mail e dentro un PDF, l'allegato otteniamo PDF, perché è molto più facile.  Sappiatelo che Google, i provider di mail, se supera, se mi sbaglio, 2 MB il file, non te lo fa vedere come un PDF, ma rompe un po' la mail.  Quindi dobbiamo cercare per forza di essere meno di 2 MB di file o 2 o 4.5, non mi ricordo molto bene adesso.  Riguardo ai preventivi, fino adesso non ho visto nessuna foto tranne il logo sopra, sarà sempre così?

1:28:11 - Elisa Migliano
  Oppure ci saranno dei prodotti con dei… qua, però non abbiamo mai messo foto oltre in realtà al logo, quindi non so se Sabatino vuol rispondere in merito, se ci possono essere delle ulteriori sviluppi in merito, ma… Perché se è così poi dobbiamo prevedere un'immagine per prodotto.

1:28:34 - Sabatino Rinaldi ( Pienissimo)
  Io direi che possiamo anche farne meno delle immagini. Keep it simple. Tanto ormai il cliente è già conquistato, se gli mandiamo questo, abbiamo fatto, quindi basta fargli vedere il bello.

1:28:51 - Elena Spini (ROMI Company)
  Scusa Elisa, ma è un preventivo, diciamo, di un prodotto vostro? È uguale alla stessa… Che non sia così particolare come il Pienissimo Pro che poi è della software SRL?

1:29:05 - Elisa Migliano
  Sì, allora, il template è uguale, sì, sì. L'abbiamo unificato su tutti. Perfetto.

1:29:12 - Elena Spini (ROMI Company)
  Quindi qua ci sarà offerta Academy?

1:29:16 - Elisa Migliano
  Aspetta, questo qua però non lo invieremo mai, questo qui è un allegato che abbiamo fatto ad hoc su quello.  Io pensavo che con ordine intendessi proprio la tabella con importo e scadenza, eccetera.

1:29:28 - Elena Spini (ROMI Company)
  Tipo un preventivo che puoi inviare, prima stavamo guardando qua, il tutor con i vari pacchetti, per esempio. Invia il preventivo, che potrebbe essere un potenziale ordine se effettivamente poi il cliente conferma, come lo inviate?

1:29:49 - Elisa Migliano
  Allora, se è una tipologia di ordine normale, passami il termine, nel senso che all'interno non c'è una decisione lato direzionale.  Grazie. Grazie. Grazie. Da palco, loro semplicemente mandano l'ordine, non c'è nessun contratto, non c'è nulla stipulato, non c'è nulla che mandiamo in allegato.  E come gli dice?

1:30:14 - Fabrizio Paganelli
  Perché Elena, i contratti tramite DocuSign, noi li mandiamo solo per i pacchetti grossi, quindi la Performance Plus, le vendite da palco dell'anno con Pienissimo, anche le vendite da palco più piccole, se non ricordo Elisa, correggimi se sbaglio.

1:30:35 - Elisa Migliano
  Sì, c'è tutto quello che è bundle, viene mandato col contratto.

1:30:39 - Fabrizio Paganelli
  Il pacchetto, diciamo, che prevede l'anno con Pienissimo, stiamo parlando di circa 10.000 euro di valore complessivo annuo, fatto direttamente dal tutor in modo personalizzato, diciamo, non viene inviato il contratto nel caso di piccoli ordini, quindi io compro tre biglietti di Camerini Rivelli.  Venditori non stiamo a mandare il contratto, capito? Oppure compro solo l'EPITIM, non mandiamo il contratto. Normalmente il contratto lo mandiamo quando si prevede con il cliente una dinamica annuale molto più corposa.

1:31:17 - Elena Spini (ROMI Company)
  Ok, aspetta, allora facciamo un attimo un passaggio ancora indietro, perché voi state parlando di ordine e contratti, quindi ammettiamo che effettivamente l'offerta sia andata accettata dal cliente, ma nel momento in cui io, tutor, ti propongo, non lo so, questo pacchetto che vedevamo prima, ti dico effettivamente costa, non lo so, 2.000 e basta, senza mandarti niente?

1:31:42 - Elisa Migliano
  No, ti mandiamo l'ordine. Quello che tu vedi sotto in allegato nei PDF che ho mandato, ti mandiamo questo qua, l'ultimo, però c'è scritto SO, prova, quello dovrebbe essere forse l'anno.  Ah no, hai sempre dei corsi, ma vabbè, poco importa. Ah, questo era quello di prima.

1:32:08 - Elena Spini (ROMI Company)
  Ah no, ecco.

1:32:09 - Fabrizio Paganelli
  Ecco, però...

1:32:10 - Elisa Migliano
  Ok, praticamente questa qua è la parte finale, perché c'è un contratto, appunto come hai detto tu, il cliente ha già accettato l'offerta, eccetera.  In fase iniziale il tutor cosa manda? Manda l'ultimo foglio che tu vedi, ovviamente non lo mandiamo col contratto, lo mandiamo a parte.

1:32:24 - Elena Spini (ROMI Company)
  Perfetto, questo vorrei Si manda praticamente alla stampa dell'ordine.

1:32:28 - Fabrizio Paganelli
  Esatto.

1:32:28 - Elisa Migliano
  Si manda alla stampa dell'ordine. Con un modello email ad hoc su...

1:32:33 - Elena Spini (ROMI Company)
  Potenziale ordine, ricordatevi, perché poi lo dovrete usare Salesforce, che sarebbe il preventivo.

1:32:40 - Elisa Migliano
  Il preventivo, infatti.

1:32:42 - Fabrizio Paganelli
  Impareremo anche i linguaggi, noi adesso con Zossi ci siamo un po' imbastarditi, chiamiamo ordini preventivi, preventivi ordini.

1:32:51 - Elena Spini (ROMI Company)
  Aurel, glielo faccio notare così, sorridendo, perché l'altra volta ci siamo ammazzati per capire una cosa, che diciamo, entrambi a la stessa...  Questa cosa va con le parole diverse, quindi per quello.

1:33:03 - Fabrizio Paganelli
  Abbiamo delle difficoltà anche noi, ti dico la verità, perché spesso e volentieri noi che siamo più operativi, su zoo si chiamano preventivi, noi tra di noi parliamo di preventivi, poi andiamo a parlare con la direzione, il linguaggio che abbiamo, preventivi, diciamo preventivi, ci sgridano perché giustamente quello non è un preventivo in ordine, giustamente.  E dopo sull'etichetta siamo abbastanza, come dire, siamo abbastanza sensibili, quindi giustamente quello che dicevi tu è correttissimo, noi mandiamo via una stampa di un preventivo, nel momento in cui il cliente lo accetta, quel preventivo diventa un ordine.

1:33:45 - Elena Spini (ROMI Company)
  E sarebbe praticamente, scusa Aurelio, finisco, questa pagina, queste ultime due pagine, il preventivo, una volta che è ordine diventa praticamente tutta la parte sopra che è il contratto più il preventivo.  Sì, esatto.

1:34:32 - Aurel mrruku
  Invia preventivo, generi questo file PDF e lo invia via mail. Dal momento in cui hai inviato il preventivo, tu hai la possibilità di alternare la composizione di quell'offerta?  Sì. E se sì, deve rimandare il preventivo?

1:35:00 - Elisa Migliano
  Ok, non c'è un obbligo. Allora, sì, diciamo che non ci sono dei blocchi, quindi il tutor può modificarlo anche 500 volte il preventivo, prima che diventi un ordine.

1:35:16 - Aurel mrruku
  Ok, perfetto. Nel momento in cui te hai fatto tutte le modifiche sull'offerta e sei convinto che questa offerta poi diventa un ordine, che azione fai a livello di CRM?  Lo metti in vinta, penso.

1:35:37 - Elisa Migliano
  No, in vinto va con la ricezione dell'incasso, quindi il tutor non lo mette in vinto, lo mette su preventivo inviato.

1:35:48 - Aurel mrruku
  Ok, però se lo metto su preventivo inviato, stiamo dicendo che il preventivo inviato è quando tu hai inviato il preventivo.  Sì, allora le casistiche su...

1:36:00 - Elisa Migliano
  O è preventivo inviato e io quando io amministrazione ricevo l'incasso è su quel cliente perché ho il riferimento dell'ordine, vedo che è collegato a quello.  Oppure altrimenti i clienti hanno la brutta abitudine di mandare la copia contabile al tutor e di conseguenza abbiamo creato questo stato di stallo che si chiama accettato copia contabile ricevuta.

1:36:25 - Fabrizio Paganelli
  Perché fondamentalmente noi non abbiamo un momento in cui abbiamo la sigla e il timbro con la cera lacca dove il cliente ci dice ok accetto il preventivo e quindi si trasforma in ordine.  Spesso e volentieri, come diceva giustamente adesso l'Elisa, il tutor manda il preventivo al cliente. Il cliente non accetta nulla, semplicemente ci arriva il bonifico.  Ok.

1:37:00 - Aurel mrruku
  Volevo arrivare a questo punto qua. Nel momento in cui si va su questi due stati, che può essere che non ne mancano, sono due stati, può essere un stato con dei flag dietro, possiamo generare il PDF dell'ordine lato frontend, quindi lato, cosa vuol dire lato frontend?  Da un'azione fatta da un utente, non dal server, quindi se io vado in un certo stato, se fliego una cosa, in automatico genero il PDF dell'ordine.  E poi, 3 giorni, 5 giorni prima dell'evento, uso questo PDF generato con la sigla di DocuSign e lo invio tramite DocuSign per firmarlo.  Così io non devo generare il PDF tre giorni o cinque giorni, poi decidiamo quando, prima dell'evento per essere firmato dai partecipanti praticamente.  Però sono due cose diverse.

1:38:26 - Fabrizio Paganelli
  Un conto è la firma del contratto. Un conto è la firma di tutta la documentazione dove c'è la privacy, il patto di non concorrenza, il patto di riservatezza, che facciamo firmare ai partecipanti all'evento tre giorni prima che entrino.  Sono due momenti diversi.

1:38:46 - Aurel mrruku
  Quindi ti dici che proprio i documenti del contratto sono il ciclo di vita dell'offerta, poi i documenti della partecipazione sono gli utenti che devono...  Mettere i loro dati, generare un documento in modo automatico, poi firmare quel documento, chiaro.

1:39:06 - Fabrizio Paganelli
  Perché ad esempio in quel contratto che faceva vedere prima l'Elena, c'era l'anno con Pienissimo, dove dentro magari viene comprato oggi, ipotizza, quindi il cliente lo sottoscrive oggi quel contratto e all'interno di quel contratto sono comprese sotto nelle righe ordine magari 4 biglietti camerieri venditori, ma camerieri venditori ci sarà a marzo del 2027, chiaro, capito, quindi e dopo lì si scatena tutto il cinema della documentazione che facciamo firmare ai nostri clienti dove dicono ah non copio, non riservatezza, non divulgazione, eccetera, eccetera, sono due momenti completamente diversi, correggetemi se sbaglio Sabatino e Elisa.

1:39:56 - Elisa Migliano
  Sì, sì, no, è giusto, sono due momenti diversi e sono due ordini diversi. Mettere i loro dati, generare un documento in modo automatico, poi firmare quel documento, chiaro.

1:40:06 - Aurel mrruku
  Perché ad esempio in quel contratto che faceva vedere prima l'Elena, c'era l'anno con Pienissimo, dove dentro magari viene comprato oggi, ipotizza, quindi il cliente lo sottoscrive oggi quel contratto e all'interno di quel contratto sono comprese sotto nelle righe ordine magari 4 biglietti camerieri venditori, ma camerieri venditori ci sarà a marzo del 2027, chiaro, capito, quindi e dopo lì si scatena tutto il cinema della documentazione che facciamo firmare ai nostri clienti dove dicono ah non copio, non riservatezza, non divulgazione, eccetera, eccetera, sono due momenti completamente diversi, correggetemi se sbaglio Sabatino e Elisa.

1:40:56 - Sabatino Rinaldi ( Pienissimo)
  Sì, sì, no, è giusto, sono due momenti diversi e sono due ordini diversi. Due tipologie possono essere anche di ordini diverse.

1:41:03 - Aurel mrruku
  Ok, quindi quando Sabatino, quando parlerai con DocuSign, tieni in considerazione che ci sono tre tipologie di documenti da firmare praticamente.  L'ordine, ci sarà accettazione, diciamo, il documento per farlo accettare sull'evento e ci sarà anche il documento che avete fatto vedere all'inizio che era quello dove metteva i dati bancari.  Il RID. Il RID.

1:41:47 - Fabrizio Paganelli
  Sì, sì, no, me l'avevo già segnato.

1:41:49 - Elisa Migliano
  Noi abbiamo il documento ordine, quindi l'ordine di qualsiasi tipo di contratto che eroghiamo, il documento di accettazione dei termini e condizioni.  Per i nostri eventi e il documento del RID. Ok. Sarevo già segnato. Ok, stiamo parlando anche di quattro template diversi fino adesso, quindi i tre documenti con i template che abbiamo appena detto e ci sarà poi anche il template del preventivo che è una sottoparte del documento dell'ordine praticamente.

1:42:30 - Aurel mrruku
  Dalla mia esperienza, quasi su tutti i ordini c'era anche il documento di condizioni generali per l'accettazione, si chiamava così.

1:42:41 - Elisa Migliano
  Voi lo dovete prevedere su tutti questi documenti?

1:42:46 - Aurel mrruku
  Mi sembra che sia già compreso in quello che faceva vedere. Dei ordini?

1:42:52 - Fabrizio Paganelli
  Allora, le condizioni generali sono già all'interno dei contratti, mentre l'accettazione è una cosa che non abbiamo mai avuto.

1:43:00 - Sabatino Rinaldi ( Pienissimo)
  O meglio, è una cosa che potevamo fare con Zosying, tramite appunto Zosying, quindi il contratto e il preventivo, e al cliente arrivava una mail con accetto-rifiuto, e successivamente quello poi siano dei trigger che mandavano il contratto, eccetera.  Ma noi è una cosa che non avevamo mai attuato, sull'accetto e il rifiuto, invece le condizioni generali sono già all'interno di tutti i contratti.  Lo volete prevedere? Perché di solito sta sempre, se hai firmato, ci sarà sotto. Tu lo dici con il contratto o con il preventivo?  No, col preventivo fai niente, perché sul preventivo non devono firmare, ma sui documenti che mandate per accettazione sull'evento? Fa vedere uno di quei documenti.  Abbiamo perso Elena? Sì, l'abbiamo persa da un posto. Io credo che abbia avuto un problema di connessione perché è totalmente sparita.

1:44:16 - Daniela Morgese ( Pienissimo)
  È uscita e non è più rientrata.

1:44:19 - Aurel mrruku
  Intanto si è collegata a Daniela, quindi in realtà ci farebbe molto comodo che Elena tornasse ora. Però non le arrivano nemmeno i WhatsApp, quindi credo che le ha appena caduta la linea.

1:44:31 - Daniela Morgese ( Pienissimo)
  Ciao a tutti. Ciao Daniela. Dani. Dani, già che ci sei ti aggiorno su una cosa che abbiamo parlato ora.

1:44:41 - Sabatino Rinaldi ( Pienissimo)
  Noi abbiamo fatto l'iscrizione a DocuSign, ho fatto la prova diciamo di prova e abbiamo contattato ora i loro commerciali per farci fare perché sotto consiglio loro di Aurel ci diceva proprio di contrattare direttamente con...  Il commerciale per avere un prezzo vantaggioso, spiegando tutte le nostre limiti, la quantità di investimenti. Quindi fatto, io ho mandato la mail, aspetto che mi rispondano, una volta che abbiamo il prezzo, compriamo, abbiamo fatto poi.  Cioè l'interazione produttiva. no, no, se se no, se no, no, se no, se no. Un po' alti. Sono del sud Italia, sono bravo in quello.  Sarà fatto, Perfetto.

1:45:32 - Daniela Morgese ( Pienissimo)
  Sarà fatto.

1:45:35 - Sabatino Rinaldi ( Pienissimo)
  Va bene, va bene.

1:45:36 - Aurel mrruku
  Sam, ti vuole dire qualcosa? Sì.

1:45:39 - Daniela Morgese ( Pienissimo)
  Sì, no, perché in realtà ti abbiamo aspettato proprio per vedere la parte, il workflow commerciale che ci volevano proporre.

1:45:47 - Fabrizio Paganelli
  Quindi, per ora Elena, le è caduta la linea. Ma appena scritto. Sì, esatto, anche a me. Sta riavviando. Speriamo che riesci a far tutto.  Perdi app Questi, tur되ostetera. Quindi, almeno uguale se anciab cuore Sì, nel frattempo ti aggiorniamo su quello che stavamo vedendo ora, ci siamo dedicati un po' a tutta la parte di preventivi, ordini, termini e condizioni, proprio l'aspetto tecnico, come gestirli.

1:46:17 - Elena Spini (ROMI Company)
  Quindi in realtà stavamo parlando principalmente Fabrizio e Elisa con Aurel ed Elena su questa parte qui, ma direi che più andiamo avanti, più su quell'aspetto lì, stiamo trovando una quadra per interagire con Salesforce.

1:46:31 - Fabrizio Paganelli
  Correggimi se sbaglio, Aurel, su questa cosa. No, tutto come l'hai detto. Noi sulla parte invece interfaccia MXAL, come siamo?  Così faccio le domande nell'attesa che arrivi l'Elena. Allora, prima c'era anche Andrea, se non ricordo male, la volta scorsa gli avevo fatto fare una sorta di valutazione, di analisi.  Su quale poteva essere migliore la strada. O continuare, vedo che c'è l'Elena, quindi magari siccome ho appena iniziato ricomincio.  Elena, Daniela mi chiedeva. Perdonatemi, scusate l'interruzione, ma mi è morto tutto improvvisamente mentre stavo parlando. Ce l'ho fatta. Vai, eccomi.  Daniela mi chiedeva aggiornamenti in merito al discorso dell'interfaccia Salesforce-Mexal. Allora stavo dicendo che voi avete fatto un'analisi in corso di questi ultimi giorni dove avete valutato se poteva essere meglio continuare così come stiamo facendo tramite, diciamo, un'interfaccia che prevedeva lo scambio di informazioni tramite file CSV oppure lavorare con le API di Mexal.  La conclusione è stata che sarebbe molto meglio e anche... Grazie. Grazie. E' molto più allineato quelle che sono le migliori pratiche, diciamo, gestionali, utilizzare l'API.  Per cui adesso io, Daniela, adesso mi sono preso l'impegno di fare una chiamata alle persone della Creosoft. Magari sento con chi è meglio, immagino che sia Mirko, si chiama Mirko la persona che ci segue, che è il tecnico.  Ok. Siamo rimasti che magari io faccio parlare direttamente Mirko con le persone di ROMI, di modo tale che si chiariscono nei loro tecnicismi in modo più adeguato, insomma, quindi...  Va bene, va bene, va benissimo. C'era un tema, se possibile, parlare due minuti prima del discorso dei flussi, che ha a che fare con gli aspetti delle licenze, perché è venuto fuori, adesso anche qui tu Elena, correggimi se sbaglio, che per poter gestire i bundle...  Noi abbiamo bisogno di comprare delle licenze che attualmente non sono previste nel nostro pacchetto. Allora io ho detto, ma come?

1:49:08 - Elena Spini (ROMI Company)
  Il 50% del fatturato che facciamo è tramite i bundle. Abbiamo fatto 7, 8, 9 incontri fino ad ora, oltre a tutti i vari appuntamenti commerciali, diciamo, di preacquisto.  Com'è possibile che non abbiamo nelle licenze che abbiamo comprato i bundle? Perché i bundle, mi sembra strano che nessuno abbia detto che vendiamo tramite i bundle.  Abbiamo detto sicuramente. Quindi voglio dire, attualmente, perché il tema è questo, che potremmo anche lavorare con le licenze così come abbiamo adesso, ma però facendo delle customizzazioni.  Allora io dicevo, cavoli, ma abbiamo comprato un prodotto nuovo, dobbiamo partire con le customizzazioni? Non mi sembra a caso.  Uno, bisogna capire come mai... Non è venuto fuori sta cosa e nell'offerta che ci è stata fatta non è stata quotata anche il discorso dei bundle.  Allora su questo se posso anche aggiungere sicuramente il tema del bundle si è sviscerato maggiormente adesso perché abbiamo dati alla mano cosa effettivamente vuol dire un bundle per voi eccetera.  Come abbiamo ben visto c'è tante volte magari si parla di una cosa ma si intende un'altra quindi finché non avevamo neanche contezza di cosa effettivamente potesse dire bundle effettivamente per voi poteva essere magari semplicemente un insieme di prodotti punto.  Adesso invece che abbiamo capito cosa effettivamente deve fare il sistema oggi siamo arrivati che abbiamo fatto un'analisi interna più tecnico per capire cosa effettivamente può fare la piattaforma abbiamo detto signori qua c'è un tema che effettivamente se vogliamo fare le logiche che dobbiamo che ci sono.  Questo è richiesto di fare, qua bisogna fare delle logiche di customizzazione. Oppure, avevamo detto, e non so se Daniela forse magari tu ci può dire, il tema qua cos'era?  Era effettivamente quando un tutor vende un pacchetto, può vendere un pacchetto in sé e basta o vende il pacchetto più una riga di prodotto a parte?

1:51:28 - Daniela Morgese ( Pienissimo)
  Perché se effettivamente vendiamo il pacchetto e basta, ce la riusciamo a gestire con la soluzione standard barra customizzata con solo l'oggetto di fondo, Aurel, no?  Non la parte UI praticamente. Esatto, c'è solo una cosa che comunque già useremo, cioè è normale usare oggetti anche che si prestano più per le esigenze che si chiamano custom, non standard.

1:51:57 - Fabrizio Paganelli
  E su questo è ok, ma in quanto è usare l'oggetto? Fathom e basta, un conto è andare un po' a snaturare tutte quelle che sono le logiche.

1:52:05 - Daniela Morgese ( Pienissimo)
  Questo per dirti che la domanda era, un tutor può vendere bundle più riga di prodotto a parte oppure vende solo il pacchetto e basta e poi una riga di prodotto magari possiamo fare un ordine a parte?

1:52:23 - Fabrizio Paganelli
  Allora, questo per forza, nel senso che noi nei preventivi, quando facciamo preventivazione, per esempio un bundle potrebbe essere un anno con pienissimo a 6.900, oppure un bundle con un anno di pienissimo che può essere camerieri di venditori più piattaforma, non accade mai che il tutor vende un bundle più un prodotto in più, questo non succede, almeno che io abbia idea, ma è successo, anche perché sono due dinamiche diversi.

1:52:48 - Daniela Morgese ( Pienissimo)
  Ha risolto un grave problema in realtà. Perché in realtà, questo lo dicevamo anche all'inizio, perché in realtà quando un tutor fa una trattativa col cliente, magari, che ne so, e adesso come si chiama?

1:53:00 - Fabrizio Paganelli
  Promo Summer gli vende una sorta di... Poi gli dice, vabbè, ti do anche l'Academy, quindi adesso come adesso, magari inserisci...  cioè non lo so. fa due preventivi, fa due preventivi, non è mai successo che tu l'unico preventivo gli metti quello qui l'Academy, ma i marketing l'abbia visto, cioè, sinceramente.  E infatti a questo tipo di conclusione eravamo già arrivati anche prima. Però, quello che poi dopo abbiamo detto, bene, però, visto che comunque sia noi il termine bundle lo usiamo anche su Zoho, mi sembra strano che non sia mai venuto fuori, fino ad oggi, il discorso che gestiamo i bundle.

1:53:44 - Daniela Morgese ( Pienissimo)
  Capito cosa vuol dire i film? No, ma se... No, Quello che sta dicendo l'Elena, che probabilmente il grado di complessibilità, una demo commerciale, viene una demo tecnica, quello che ha detto lei.

1:53:57 - Aurel mrruku
  Ok, però magari, io dicevo... Prima, quando ancora tu non c'eri, dopo tra di noi dicevamo, bene, però magari fateci vedere come funziona il vostro modulo bundle rispetto a come funziona il discorso di gestire bundle tramite la customizzazione, perché magari ci va bene lo stesso usare la customizzazione, ma magari vedendolo, adesso io sinceramente faccio fatica a dirti, ah, va bene, allora usiamo la customizzazione.  Magari se vedo nella pratica un certo esempio, eccetera, eccetera, riusciamo meglio tutti noi di Pienissimo a capire se quel tipo di customizzazione può essere adeguato oppure no, perché magari non è adeguata, non so se hai da che spiegarmi.  Qual è la differenza, Elena, tra la customizzazione e il modulo bundle? Cioè, quindi, cosa si sostiene? Posso rispondere io?

1:54:51 - Daniela Morgese ( Pienissimo)
  Vai, vai, vai, Aurel.

1:54:52 - Aurel mrruku
  Allora, quando si compri le licenze non si comprano per il modulo bundle. Praticamente si chiama Revenue Cloud, oppure vecchio CPQ.  Praticamente CPQ è la configurazione del price sulla quote. La configurazione del price sulla quote prevede anche la possibilità di fare dei bundle.  E i bundle sono praticamente dei contenitori con dietro delle logiche di prezzo che CPQ, che poi è diventato Revenue Cloud, li configura direttamente sulla piattaforma da, fatemi passare il termine standard, ma non è standard, semplicemente qualcosa sviluppato da un team che poi l'ha messo come pacchetto e tu paghi licenze per usare delle funzionalità di quel pacchetto.  E' una sorta di configuratore. Configuratore. CPQ è configure price praticamente, quote price. E invece da standard ovviamente possiamo fare un pezzo di quello che hanno fatto loro, ma se vogliamo usare tutta la logica della configurazione del prezzo del bundle, ovviamente c'è più effort, dobbiamo spendere più tempo sia la parte back-end che la parte front-end, sia la parte del calco del prezzo, eccetera, eccetera, se la parte di visualizzazione.  Per esempio, Revenue Cloud ha già un preventivo suo, che fino a un certo punto può andare bene all'80% dei casi.  Revenue Cloud ha un pricing engine, si chiama, che tu, un configuratore di prezzo, che tu lo configuri per quando hai milioni di prodotti e vuoi fare customizzazioni real-time, anche direttamente dal portale.  Quindi Grazie. tutti. tutti. Per esempio su Fastweb dove ho usato CPQ, loro facevano le offerte mensili, settimanali, e tu facevi questi bundle con numero SIM, telefono, pacchetto internet, facevi collaborazione con Sky e facevi questi pacchetti.

1:57:19 - Daniela Morgese ( Pienissimo)
  Invece nel nostro caso qua il bundle è semplicemente un contenitore che avrà un prezzo, non ci sono delle logiche del prezzo dietro le quinte.

1:57:32 - Elena Spini (ROMI Company)
  Il problema nostro è che sulla visualizzazione se tu metti un prodotto con un insieme di prodotti nello stesso ordine, con la schermata standard di Salesforce, non lo puoi far vedere il tree, quindi il contenuto del bundle, ma solo il bundle.  Ovviamente la puoi customizzare e sulla customizzazione... Noi ovviamente dobbiamo spendere un po' più di tempo, stiamo parlando di una settimana forse di lavoro per far vedere questa parte qua.

1:58:07 - Aurel mrruku
  Quindi scusami Aurel, giusto per farmi capire se ho capito, allora se io faccio un bundle che magari mi dura, o due bundle che mi durano tre mesi, usare il configuratore è sovrappotato rispetto all'utilizzo che ne facciamo, dico bene?  Sì. Ok, perché è quando tu devi farmi capito, esattamente. E soprattutto se hai delle regole particolari anche, scusa Daniela se aggiungo, se hai delle regole particolari, come sembrava che prima stavi iniziando a dire no, però devi aggiungere le righe d'ordine nonostante hai messo il bundle.

1:58:40 - Daniela Morgese ( Pienissimo)
  E lì abbiamo iniziato a dire ok, allora quindi ci sono delle customizzazioni, si può fare, ma ci sono delle customizzazioni aggiuntive.  Ma se già stiamo dicendo che se metto una riga di prodotto è una cosa, se metto un bundle è un altro ordine, allora effettivamente non ha senso.  Grazie. di queste licenze, ma perché a parte che è un costo anche per voi, ma poi non sfruttereste neanche la totalità delle licenze in questo senso.  Revenue Cloud, vi do anche questa spiegazione per capire quanto può diventare poi complessa l'introduzione del Revenue Cloud. Revenue Cloud non ce l'ha l'idea di un bundle e il prezzo finale del bundle.  La Revenue Cloud c'ha l'idea del bundle, i prodotti, su ogni prodotto c'è delle logiche del prezzo che ti fanno il prezzo del bundle.  Invece nel vostro caso...

1:59:39 - Aurel mrruku
  E questo, aspettate, però a me questo non mi dispiace, perché, allora, per capire, noi oggi usiamo il bundle come prodotto, ok?  E' chiaro che se io uso il bundle come prodotto, quando dovrò andare a fare una statistica di quanti camerieri venditori ho venduto, io devo riuscire...  o mi dite che io riesco a fare come fonte che il cameriere venditore... venditori sono top di bundle summer e quindi ci arriviamo allo stesso, se no io quando devo fare il fatturato del prodotto camerieri venditori avrò un fatturato che sarà falsato.  Infatti questo è vi dico l'esigenza finale, capito? Cioè io oggi vendo 10 un anno con Pienissimo, che è un bundle, dove ci sono tutti i corsi di Pienissimo, ovviamente è un prezzo diverso.  Ok, quindi quando io vado poi a dire quanto fatturato ho fatto con camerieri venditori, la quotazione del cameriere di venditori rispetto all'anno con Pienissimo, da dove la prendo?  Se il bundle mi diventa un unico prodotto? Forse è il momento di preparare qualcosa anche noi Elena per far capire come possiamo dimostrare il concetto di bundle lato Salesforce, perché il bundle visivamente è un contenitore.  Il contenitore ha una riga e quella riga è il prodotto. Il prodotto di solito ha un listino di prezzo che può variare da cliente a cliente oppure da stato a stato.  Ma sul bundle ci sono casi in cui te non vuoi un pacchetto ma vuoi due pacchetti. Ma decidi di fare in offerta se compri due pacchetti, sto parlando sempre di Revenue Cloud, hai 30% su uno dei prodotti di quel pacchetto.  E su questo è molto bravo Revenue Cloud.

2:01:39 - Daniela Morgese ( Pienissimo)
  Invece nel nostro caso noi possiamo agganciare, dobbiamo per forza agganciare tutti i prodotti al contenitore, ma il prezzo non è la somma dei prezzi del prodotto per quel listino, ma sarà un prezzo, lo possiamo fare che sia anche...

2:02:00 - Aurel mrruku
  La Soma con dei sconti, eccetera.

2:02:03 - Fabrizio Paganelli
  Ovviamente dobbiamo customizzarlo. Ma sarà il prezzo del bundle con questi prodotti? Perché io non mi aspetto che voi vendete un prodotto dentro un bundle con lo stesso prezzo che ha quel prodotto, se lo vedi singolarmente.  Assolutamente. E mi aspetto che lo sconto sarà sul totale del bundle, non sarà un sconto di un prodotto di quel bundle, se fa parte di quel bundle.  Però quando io vado a fare una statistica e la leggo al prodotto, che non è un bundle, ma è il cameriere venditori del caso, io avrò il prezzo di cameriere venditori per quel che riguarda il bundle, che quota parte me lo devi misurare, perché se no io avrò la metà del fatturato su cameriere venditori.  Qui bisogna, scusate se bisogna che… sotto praticamente lo… Ho capito. Questa qui è una cosa che per noi è strategica, quindi bisogna che ci facciate vedere come funziona il discorso del bundle e come funziona il discorso della customizzazione.  Noi abbiamo proprio bisogno di vederlo visivamente, perché se no temo che così a parole facciamo fatica a capirci. Quindi vi chiedo la cortesia, magari per la prossima volta, magari approfittiamo anche di una volta che è disponibile la Daniela, queste due cose, vediamole.

2:03:31 - Aurel mrruku
  Fabrizio, magari ceriamoli qualche esempio di nostro bundle così loro lo possono vedere. Io li ho già dati, però il tema è che se noi non ci rendiamo conto adesso di come funziona in un caso e come funziona in un altro, siamo in difficoltà nel momento di dire sì ad un caso piuttosto che sì all'altro, perché bisogna che questo, ripeto, siccome questo qui è un aspetto strategico per noi,

2:04:00 - Elena Spini (ROMI Company)
  Bisogna che sia assolutamente chiaro, limpido e cristallino prima di prendere qualsiasi decisione. Quindi, ripeto, fateci vedere degli esempi perché con quelli riusciamo a capire e a darvi un riscontro.

2:04:14 - Fabrizio Paganelli
  Soprattutto rendiamo, come dire, partecipe anche la Daniela, poi dopo come dal punto di vista operativo andremo a lavorare, ma lei dal punto di vista strategico ha bisogno di capire la differenza tra le due soluzioni.  Io dico questo. Il problema è che su Revenue Cloud, almeno nei ultimi 5 anni, la maggior parte dei progetti è stato portare quello che c'era su Revenue Cloud sullo standard di Salesforce customizzando.  Io non so, Elena, se c'è qualche progetto che ha lavorato recentemente che usa Revenue Cloud non customizzato praticamente. Facciamo fare un passaggio con Andrea, ma penso neanch'io, quindi in realtà...

2:05:00 - Aurel mrruku
  Secondo me, da quello che avete detto un po' l'esigenza adesso, al netto di quel tema della fatturazione, quindi capire cosa effettivamente mi ha portato la riga d'ordine, mi sembra decisamente sovrastimato pensare a Raven Cloud, però capisco l'esigenza.

2:05:20 - Daniela Morgese ( Pienissimo)
  Però ecco, ripeto, fateci vedere, perché se noi non vediamo, temo che facciamo fatica a renderci conto un po' tutti, sia lato diciamo noi operativi, ma anche lato direzionale, abbiamo bisogno di avere la certezza di come girerà questo meccanismo, perché ripeto, è per noi strategico, noi quelli che oggi noi chiamiamo bundle, le vendite tramite bundle coprono circa il 50% del fatturato dell'azienda, quindi è fondamentale che qualsiasi decisione prendiamo su questo punto la prendiamo in modo consapevole, sia voi che noi, che soprattutto la...

2:06:02 - Elena Spini (ROMI Company)
  Elena, io direi di coinvolgere Andrea così forse contatto direttamente Salesforce perché loro penso che sono molto interessati a spiegare come usare Revenue Cloud perché se vogliono vendere le licenze saranno molto felici a spiegare quale è il pro di Revenue Cloud.

2:06:52 - Daniela Morgese ( Pienissimo)
  E A parte il Revenue Cloud, come funziona il... Scusa dei bundle customizzati, non ce lo potete far vedere in modo semplice?  Allora sì, possiamo fartelo vedere, però non giovedì, Fabrizio, perché dobbiamo costruire, dobbiamo fare almeno nell'ambiente di test almeno un giro, perché c'è un oggetto custom da costruire, quindi un minimo di configurazione, l'altro nostro c'è.  Quello che però non ti posso far vedere settimana prossima è la parte del revenue cloud, perché non so se troviamo un progetto da farvi vedere.

2:07:31 - Fabrizio Paganelli
  No, io forse mi ho spiegato male. A noi ragazzi, scusa Fabrizio, solo un secondo, cioè noi non vogliamo complicare la sequenza, noi vi spieghiamo come giriamo, ok?  Ci dedichiamo un altro tempo per dire come giriamo e le necessità che abbiamo dal punto di vista commerciale, ma anche di restituzione statistica.  Perché noi abbiamo, i prodotti sono sempre quelli, non ci sono robe più, quindi i corsi sono sempre quelli, vengono soltanto agganciati con pacchetti diversi a prezzi diversi.

2:08:00 - Sabatino Rinaldi ( Pienissimo)
  La necessità che abbiamo noi, e quindi capiamo se la customizzazione è una roba semplice, è quella di poter poi dire, quando vado a fare analisi statistica per capire come si compone il mio fatturato di un certo corso, devo richiamare anche una quota a parte del prezzo del bundle, perché ovviamente mi mancano informazioni altrimenti.  Questa è l'esigenza, semplice, semplice. Sì, però io quello che cercavo di dire, ho capito che non avete esempi da farci vedere con Revenue Cloud, benissimo, però fateci vedere per cortesia almeno come funziona questo bundle customizzato, chiamiamolo come voi, la soluzione semplice, com'è che l'avete chiamato, fateci vedere la customizzazione, perché ripeto, secondo me bisogna che su questo punto siamo assolutamente consapevoli che questa customizzazione è adeguata, o no, dobbiamo essere consapevoli prima di partire.

2:09:00 - Elena Spini (ROMI Company)
  Aggiungo dicendo che in realtà noi in questa call ci siamo scambiati tutte le informazioni importanti, cioè sapete noi cosa vogliamo, ossia una delle cose più importanti è proprio la parte statistica, cioè noi dobbiamo sapere tramite i bundle quanti singoli prodotti abbiamo venduto e quindi questa è la cosa più importante.

2:09:22 - Sabatino Rinaldi ( Pienissimo)
  l'informazione tecnica su come sono i nostri bundle attuali ce l'avete, quindi è quella che abbiamo visto nel file Excel sia oggi sia l'altra volta, quindi di base è procedere su quella linea lì, sulla base di quello che ci siamo detti, sulla base delle informazioni che già avete.  Credo che infatti avete tutto per procedere, giusto Elena?

2:09:44 - Elena Spini (ROMI Company)
  Sì, sì, sì, corretto.

2:09:46 - Sabatino Rinaldi ( Pienissimo)
  Però c'è, esatto, per giovedì, perché era il prossimo, la prossima riunione, cioè non ci riusciamo, anche perché cioè ormai è tardi, domani è un'altra giornata e poi c'è già giovedì, quindi giovedì lo termine...

2:10:04 - Elena Spini (ROMI Company)
  Va bene, insomma, va bene anche se lo vediamo tra una settimana, non è un problema se non lo vediamo giovedì, però vediamolo, questo che dico io.  C'è un'altra Elisa in attesa che mi è uscito, però la vedo anche qua, a me. Elisa qui, forse si è collegata da un Si è stoppiata, ok.  Ok, quindi questa cosa ce la fate vedere prima possibile entro settimana prossima, quindi.

2:10:32 - Sabatino Rinaldi ( Pienissimo)
  Sì, per quanto riguarda la parte del flusso commerciale, riusciamo a vederlo ora, se sono troppo lunghi, come... Io mi posso trattenere.  Se Daniela dà disponibilità, la vedrei adesso. Ah, io sono le mani.

2:10:49 - Elena Spini (ROMI Company)
  Ok, perfetto, Elena direi di vederla, così approfittiamo di Daniela, se no abbiamo troppo tempo la prossima volta. Sì, detto che comunque questa...  A parte qua ne avevamo discussa con il referente commerciale, non mi ricordo come si chiama. Marco, Marco. Marco, Marco Montesi.  Quindi forse pure lui servirebbe, però non lo so, alla fine Daniela. Ma tanto se te la provo io, fidati che Marco la prova.  Esatto, va bene, perfetto. No, infatti poi sei sentito detto, tanto poi alla fine è Daniela che decide, quindi va bene, stavo a cavallo.  E Elena, faccio un attimo una breve parentesi per Daniela. Cioè questa cosa qui che ci state facendo vedere nasce da quel workflow che vi abbiamo fatto vedere noi, che avevamo accordato anche con Daniela.  Quindi questa è la vostra proposta, la vostra proposta basata su quello che vi abbiamo fatto vedere noi nel nostro workflow.  Ok. Che era questo flusso.

2:11:52 - Aurel mrruku
  Solo che andando poi ad analizzare questo flusso che ci avevate condiviso, abbiamo trovato le prime... Diciamo incongruenze, chiamiamole così, in quelle che sono le terminologie di Salesforce e le terminologie vostre, perché da quello che ci spiegava Marco, effettivamente queste erano delle logiche che voi avevate scelto di adottare.  Ora, io gli ho detto, vi facciamo questa proposta, perché in realtà Salesforce fa delle logiche un po' differenti e lui ha detto, ok, facciamo questa proposta, capiamo se effettivamente sarà un cambio di direzione che possiamo anche noi adottare, altrimenti continuiamo come abbiamo fatto.  Allora, cosa succede qua? Qua parliamo di lead e di opportunità. Lead praticamente sono tutti i potenziali, Aurel, devi uscire.  Io devo uscire, se volete ho trovato già un progetto che ho lavorato sei mesi fa, che ho customizzato un bundle, vi posso rubare due minuti?  Poi devo andare? Posso? Ok, vai, Switch. Praticamente, questo è un progetto abbastanza grande. A livello di offerta, praticamente quello che abbiamo fatto è, abbiamo creato un prodotto che è praticamente il bundle, e dentro il prodotto altri prodotti, se vedete qua.  Per esempio, LN Mono 2D ha questi pezzi, e su questi pezzi alcuni non hanno un prezzo, perché hanno deciso di, se tu hai comprato tutto il bundle, di non pagare per quella parte là, e invece si possono aggiungere anche dei prodotti che hanno un prezzo aggiuntivo, che sono questi qua.  Qua sono su CCT, praticamente è cattivo. Peterbiller sono i macchinari pesanti.

2:14:02 - Daniela Morgese ( Pienissimo)
  La configurazione del bundle, ovviamente qua l'abbiamo fatto su una pagina un po' più diversa, ma pensatelo anche qua dentro, dove hai il bundle con un prezzo di listino, che sarebbe praticamente il prezzo totale, e quando lo espandi il bundle ha dentro i prodotti.  Quindi questa è una, ovviamente veloce, dietro ci sono diverse regole di sconto, se vedete qua ci sono sconti in base alla quantità di pezzi che hai comprato, in base a chi è il cliente, ci sono anche sconti in base a quanto è costato il prodotto, quindi se il prodotto è costato, qua stiamo parlando di migliaia di euro, quindi sopra i mezzo milione di euro, allora mettono sconto di 5%.

2:14:59 - Aurel mrruku
  Grazie. Grazie. Ovviamente tutte queste regole le possiamo gestire con la customizzazione. Ascoltami, su questo siamo abbastanza lineati, nel senso che io posso dire, per esempio, un anno compilissimo costa 9.800 euro anziché 20.000 euro, che comunque è figlio del fatto che io magari ho una scontistica del 40% su tutti i prodotti, o il 50% o il 60%.  Quindi per noi è ancora più facile, perché non hai la scontistica sempre la stessa, i prodotti sono sempre gli stessi, capito?  È ancora più semplice del minimo, massimo, è un bundle, prezzo e pricing definito. Quando io vado a chiamare la statistica del prodotto, che ne so, a camerieri venditori che sta dando il bundle, anziché avere due biglietti che costeranno 800 euro, avrò due biglietti che costeranno 300 euro con sconto 60% di una cazzata, adesso, capito?  Sì, allora, quello che abbiamo fatto in certi casi su diversi bundle è... Se un prodotto, facciamo un esempio concreto, 100 euro di bundle, prodotto costava 60 euro, sono due prodotti e hai venduto 50 euro a prodotto.

2:16:12 - Fabrizio Paganelli
  Quello che possiamo far vedere è che il bundle ha il prezzo finale, ma sul prodotto mettiamo il prezzo scontato, quindi il prezzo iniziale del prodotto e il prezzo spalmato del prodotto dal totale praticamente.

2:16:34 - Aurel mrruku
  Quindi, se qua era 100, ma il prodotto costava 60, noi possiamo fare 100, 50, 50. Così, tu vedi a livello… Ok, che il prezzo sulla base del prodotto che è stato fatto.  Corretto, così, se tu fai delle statistiche a livello di prodotto, tu sai che quel prodotto è stato venduto dentro quel bundle, ma non è stato venduto con il prezzo…

2:17:00 - Daniela Morgese ( Pienissimo)
  Con listino, ma con il prezzo del bundle.

2:17:03 - Fabrizio Paganelli
  Con il prezzo da bundle, questo è l'interno, questa è la cosa che interessa finire, se il corretto è il corretto tiro.  Dopo quando si fattura, che cosa si fattura, o meglio, nell'ordine e in fattura, che cosa compare?

2:17:20 - Daniela Morgese ( Pienissimo)
  Compare solo il codice del bundle o anche tutti i componenti del bundle? Praticamente, sulla fattura, abbiamo fatto in modo che tu fai vedere il nome del bundle e tutti gli elementi di quel bundle, shiftati di uno.  Molto normalmente c'è già un preventivo qua, devo trovare un preventivo, vabbè, forse faccio... Scusate, facciamo una domanda diversa, tu come vorresti?

2:17:58 - Fabrizio Paganelli
  Vorresti una fattura con... No, me dopo noi in fattura dobbiamo esporre i singoli componenti, quindi nell'anno con pienissimo, totale 10.000 euro, dobbiamo esporre i cambiari di venditori, la mastery,'academy, no?

2:18:19 - Daniela Morgese ( Pienissimo)
  Però questo dove? Nella fattura? Aspetta, ferma, di dove? Nella fattura? Sì,'ordine che nella fattura. All'ordine sicuramente, nella fattura dobbiamo capire se ha senso oppure no, Fabri.  Nel senso che quando noi andiamo a fatturare, io ti fatturo un anno con pienissimo e ti fatturo tre scadenze, quattro scadenze, cinque scadenze.

2:18:38 - Fabrizio Paganelli
  Io non ho bisogno di raccontare al mio cliente che con quale scadenza ti sto fatturando la mastery. Segui?

2:18:44 - Aurel mrruku
  Anzi, potrebbe essere per noi il controproducente che magari lui dice, vedi, io la mastery te l'ho pagata, posso non farmi il cameriere di venditori, cosa che hanno fatto da noi, se sono pigliati il prezzo oppure no.

2:18:54 - Daniela Morgese ( Pienissimo)
  Ti segui nel ragionamento? No, ho capito, bisogna anche lì dopo andare a vedere. Grazie Però verificare anche, perché poi dopo, non dimentichiamoci che, cosa succede?

2:19:05 - Aurel mrruku
  Che poi dopo i biglietti per partecipare a quel determinato evento si sbloccano nel momento in cui la fattura è pagata, per cui se in fattura non ho i piccoli componenti.  aspetta, questo perché oggi è così, ma io non lo sta dicendo che io potrei fare, queste sono le cose che dobbiamo verificare, io posso fare internamente, noi un'associazione ordine a prodotto, ok?

2:19:27 - Daniela Morgese ( Pienissimo)
  e fatturo quello, ma nel corso di fattura posso decidere di scrivere seconda rata di un anno copilissimo, terza rata di un anno copilissimo.  Dopo questo qui lo possiamo decidere, però ecco, volevo capire in fattura dopo che cosa compare, se compare… liberi di decidere noi quello che vogliamo.  Eh, capito. Io posso anche decidere che se tu a certo punto mi fermi il pagamento io non ti aumento i biglietti dopo, non c'è scritto in nessuna parte, capito?

2:20:00 - Elena Spini (ROMI Company)
  Tu mi stai comprando il prodotto un anno con pienissimo, non dei corsi, stai comprando tutto il pacchetto.

2:20:07 - Fabrizio Paganelli
  Una cosa da tenere in considerazione è che spesso i prodotti sul bundle non hanno il prezzo del prodotto sul bundle, per esempio qua non abbiamo cose aggiuntive, è là da capire se vogliamo far vedere una tabella dei prodotti senza un prezzo?  Ah, io sì, io ai clienti non gli voglio far sapere i prezzi, perché io poi una Mastery la potrei vendere 5.000 euro soltanto una Mastery, tipito.  Io ti dico che l'anno con pienissimo costa 9.800, il valore sarebbe 25.000 euro, buona, quello è il mio prezzo finale.

2:20:40 - Elena Spini (ROMI Company)
  Come non fate il popolo? Che noi internamente abbiamo necessità di fare statistica legata al prodotto interno, io l'altro te, non si farò mai vedere che pago in a Mastery 2.000 euro quando si dice sul mercato 95.900, quindi così me lo deprezzo il prodotto.

2:21:00 - Fabrizio Paganelli
  Diciamo che quello che ho visto io tecnicamente è che sembrerebbe che possa andare bene, poi dopo si tratta di decidere, ma queste qui sono decisioni che magari Daniela prenderete tu.  Sono robe che decidiamo noi stanno facendo Fabrizio, però l'importante è capire che così gira, così come l'ha fatto vedere Aurel, gira il concetto.  Poi dopo se abbiamo anche la possibilità di, dopo, nel momento in cui lavoreremo, decidere se fatturare i singoli articoli oppure no, oppure non far vedere questo, non far vedere quell'altro.  fatturare la rata, esatto, fatturo la rata, non fatturare la rata, quello e poi lo vediamo dopo, dai. Considera che poi c'è veramente, adesso sembra che è tutto, che non vi stiamo facendo vedere niente, ma perché anche noi dobbiamo mettere insieme i pezzi, ma poi quando andiamo a configurare la piattaforma, ve la facciamo vedere settimana con settimana?  Quindi lo decidiamo assieme, però capisco il feeling che dici, non vedo niente. Hai ragione, ragione. Elena, però quando mi dici avete il bando o non avete le licenze, potremmo usare la customizzazione, noi per potervi dire sì usate la customizzazione oppure no e compriamo le licenze abbiamo bisogno di capire visivamente che cosa succede, che cosa non succede e il perché di una scelta o il perché di un'altra, se no anche così noi siamo completamente disorientati, capito?

2:22:23 - Daniela Morgese ( Pienissimo)
  Quindi questa cosa che abbiamo visto adesso grazie a ci ha secondo me dato delle delucidazioni importanti, in più mi rincuora ancora di più proprio perché come avete detto adesso poi dopo possiamo decidere come fare l'ordine ma soprattutto possiamo decidere anche come fatturare dopo, quindi decideremo se fatturare i singoli articoli piuttosto che non fatturare i articoli, fatturare le rate.

2:22:51 - Sabatino Rinaldi ( Pienissimo)
  Se voi ci date la garanzia che c'è una customizzazione così spinta che ci può permettere di gestire queste situazioni.  In modo completamente personalizzato, come ci avete fatto vedere, per me la soluzione va bene, insomma, però, ripeto, senza aver visto nulla, facevamo fatica a dirvi una cosa piuttosto che un'altra, chiaramente.  Io vi devo lasciare, chiedo scusa, ma sono un po' di ritardo. Grazie, Aurel, grazie, grazie. Grazie a voi, ciao.  Ciao, grazie mille, Aurel. Ciao. Allora, torniamo alla parte commerciale.

2:23:37 - Elena Spini (ROMI Company)
  Elena, sei con noi? Abbiamo un backup di nuovo? Ah, spero di no, però non risponde. Niente, questa parte commerciale non riusciremo a vederla.  Niente, non sa da fare, non sa da fare. Questo è quello che ci hanno proposto loro, Sab? Allora, questa cosa che ci vogliono far vedere è la loro proposta sulla base di come gliel'abbiamo spiegata noi e di come ragiona Salesforce a differenza di come gliel'abbiamo spiegata noi.  Comunque, Elena è uscita dalla call e l'abbiamo persa.

2:24:19 - Daniela Morgese ( Pienissimo)
  Spero che riesci a tornare perché non mi va di perdere altro tempo poi in un altro giorno. Elena Spini ha un partito.  Ah, ecco, c'è, di nuovo. Mi sentite? Sì, adesso sì. Aspetta, sono dal cellulare e sto avendo dei problemi di connessione.

2:24:41 - Elena Spini (ROMI Company)
  Mi sentite sempre?

2:24:43 - Daniela Morgese ( Pienissimo)
  Sì, ci sentiamo. Ok, sto avendo dei problemi di connessione e sto anche vedendo che si sta facendo sempre più tardi, quindi se siete d'accordo rimandiamo il tema, siccome è un flusso che non è che riesco a raccontarvi in due parole.

2:25:01 - Sabatino Rinaldi ( Pienissimo)
  Allora, riprovarci giovedì, dato che siamo andati super lunghi oggi? Ma a che ora avete questa call, ragazzi? Scusate che giovedì di nuovo non c'è Marco, eh?  Allora, giovedì c'è, allora, 11 e 1.

2:25:18 - Elena Spini (ROMI Company)
  Dall'11 a 1? sono, giovedì. Io non ci sono, ragazzi. Quindi se avete bisogno di me, ho la registrata, io poi la provo, e sennò non so più aiutarvi.

2:25:30 - Sabatino Rinaldi ( Pienissimo)
  Allora, di basso le call sono tutte registrate, giusto Elena? Magari, fatemi, eh, sub, se te mi fai uno stralcio, eh, no, se te magari mi fai una registrazione e mi fai uno stralcio della parte legata proprio a questa parte qui, io me la guardo tanto all'una e mezza dove finire dal cliente, me la guardo e vi rispondo in tempo, in tempo utile.  Ok, io posso, tanto Elena, vedo che ogni volta registri anche la, proprio la call in sé, quindi si vede quello che ci mostri oltre al...  Quello che ci dici. Di basse potremmo fare così.

2:26:02 - Daniela Morgese ( Pienissimo)
  Più che altro, se magari lei vuole aggiungere qualcosa.

2:26:08 - Sabatino Rinaldi ( Pienissimo)
  Ah, ma poi io faccio da portavoce nel caso, quindi possiamo fare così.

2:26:13 - Daniela Morgese ( Pienissimo)
  No, perché sennò davvero perdiamo troppo tempo agli allunghi. Sono d'accordo. Dobbiamo sbrigarci su questa roba. C'era tutto il tema del data model.  Va bene, allora facciamo così. Noi giovedì ne parliamo. Il pezzo dedicato alla parte sales, mi prendo la registrazione, me la taglio, la invio alla Daniela e poi...

2:26:38 - Sabatino Rinaldi ( Pienissimo)
  Eh, così, nel primo pomeriggio sto già a rispondervi, capito? Non ho problemi. Sì. Anche se ci fosse stato Marco, comunque so per certo che un check con la Daniela dovevamo fare, quindi procediamo comunque così.  Si cambia molto, sì, sì. Facciamo così. bene.

2:26:54 - Daniela Morgese ( Pienissimo)
  allora direi niente, Dani, scusa se ti abbiamo fatto, anzi, se comunque è stata molto utile per...

2:27:00 - Elena Spini (ROMI Company)
  Comunque abbiamo risolto la roba di Pando, esatto, almeno una cosa l'abbiamo risolta.

2:27:05 - Daniela Morgese ( Pienissimo)
  Perfetto, possiamo andare avanti. Facciamo così e allora ci vediamo giovedì, Elena.

2:27:10 - Fabrizio Paganelli
  Sì, ma vedrai che giovedì noi, un attimo poi ti diciamo roba e non è che ci fermiamo giovedì, tanto si tratta soltanto di interciarsi un attimo nei tempi.  Sì, esatto, esatto.

2:27:21 - Daniela Morgese ( Pienissimo)
  Va bene, va bene. Voi ragazzi, quando fate queste cose ricordatevi sempre, eh ragazzi, dico solo una cosa, quando fate queste cose ricordatevi sempre poi qual è il dato statistico che dobbiamo andare ad analizzare, perché il nostro tema Tavico è quello, non è solo il fare, ma è le dashboard finali, eh.

2:27:38 - Fabrizio Paganelli
  Sì, sì, no, ma infatti questo è stato l'argomento principale, la statistica di non perdere quel dato lì, lo diceva anche Fabri poi all'inizio.  Incastrandolo con le varie robe, fatturazione, eccetera. Perfetto. Ciao giovedì, ciao a tutti, ciao a tutti, ciao a tutti, ciao a tutti, ciao Fabrizio sei rimasto te?  Io ci sono, sì. Eh, stamattino lì con te? Eh, mi sa che no, nessun ufficio, siamo solo io e te collegati.  Eh, più che altro per capire, sì, siamo solo io e te, te lo dici, ma poi te ti faccio una chiamata Fabrizio, facciamo prima.  Sì, sì, ci sentiamo per telefono, sì, bene. Ciao,