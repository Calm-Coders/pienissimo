[ROMI-PIENISSIMO] - Integrazione MEXAL (Fatturazione) - July 02
VIEW RECORDING - 104 mins (No highlights): 

---

0:01 - Elena Spini (ROMI Company)
  Allora nego il mio, nego il mio perché sennò suona ogni 2x3.

0:14 - Andrea Di Cicco
  Eccoci qua.

0:24 - Marco
  Facciamo che posare l'alcino al televisore? Sì, mi sa che l'ha messo però lì per... l'ha messo apposta lì. L'ha fatto apposta a metterlo lì?  Sì, l messo lì. Ma perché l'ha messo lì? Chiedi che l'ho messo lì, però ci saranno perché...

0:41 - Elena Spini (ROMI Company)
  Siete bloccati? Io sono nascosto, eh? Ciao! Infatti mi chiedevo dove l'avete nascosto il partito. Il della riunione. Il partecipante boomer della riunione.  Marco è sparito, lo dobbiamo aspettare, o anche lui è nascosto? Eccolo, è nascosto. Allora, focus di oggi è tutta la parte di integrazione di Mexal, quindi riprendiamo un po' dal punto che c'eravamo, dove c'eravamo lasciati l'altra volta.  Vi ho visto frizzati, ora no? Mi sentite sempre? Sì. Ok, dicevo, quindi l'altra volta c'eravamo lasciati che avremmo fatto i vari check per capire se effettivamente  L'integrazione Salesforce da Mexal poteva avvenire tramite API. Aspettavamo la documentazione di Mexal, ma forse non c'è arrivata, o forse neanche tu l trovata?

2:14 - Marco
  Non l'ho trovata, la devo cercare meglio.

2:17 - Elena Spini (ROMI Company)
  Ok, quindi in realtà non sappiamo ancora se avremo la possibilità di usare l'API o sì?

2:25 - Marco
  No, la possibilità di usare l'API ce l'abbiamo perché, ripeto, abbiamo acquistato le licenze ormai diverso tempo fa, quindi quelle ce le abbiamo.  Magari era da capire se lavorare tramite API oppure come facciamo adesso tramite file CSV che vengono generati ogni notte.  Allora, io adesso ho anche provato a fare una sorta di ragionamento in questo senso. Penso, però magari lo volevo condividere con voi per capire cosa ne pensate, perché allora, fare l'integrazione tramite API, io non ho idea di quanto tempo ci posso volere.  Di fatto il discorso di far parlare due sistemi tramite i file CSV abbiamo già qualcosa, nel senso che per dire il nostro reparto sviluppo si è già interfacciato con le persone di Mexal tramite questi CSV strutturati in un certo modo, quando andiamo a flussare i dati da un ambiente all'altro, ad oggi non abbiamo particolari problemi.  Diciamo che adesso entrare in uno scenario nuovo anche di integrazione tramite API, non so, ditemi voi come la vedete, se è un scenario dove potremmo incontrare problemi oppure no.

4:01 - Andrea Di Cicco
  Diciamo, posta così la domanda, è un po' sibillina la risposta, nel senso dipende dal sistema esterno, io senza documentazione, non so che API hanno, non so che fanno le API, io non ti so dire, cioè magari il punto è, sicuramente quello che perdi è l'aggiornamento in tempo reale o near real time, quindi in un tempo prossimamente reale, quello lo perdi e perché l'aggiornamento, l'invio viene fatto solamente una volta al giorno, quindi tu vedrai le fatturazioni solamente il giorno successivo a quando sono state inviate a Nexal, quindi quella è una cosa che va presa in conto.  Sui tempi, diciamo che è un'integrazione in cui c'è uno scambio di file, è comunque un'integrazione più complessa. Questo rispetto a un API, quello è poco ma sicuro.  Anche lì dipende quanti API devono essere invocate per gestire la stessa cosa, nel senso che se mi dici che ho un'unica API rispetto a 10 API da richiamare per poter sostituire l'integrazione con file, cambia il discorso ovviamente.  Quindi non so darti una risposta precisa non conoscendo il sistema e non sapendo che cosa succede effettivamente su quel sistema.  Quindi non ti posso dare una risposta. Per noi va bene anche costruire la stessa architettura delle SIS, non è un problema.  Se è già sistemato e tutto quanto, basta che ci condividete il file che viene caricato, in modo tale che noi abbiamo visibilità su quelle che sono le informazioni e capiamo...  Dove e come abbiamo tutte le informazioni su Salesforce, in che punto le metteremo su Salesforce e basta e procediamo allo stesso identico modo.  Quindi è un po' questo il punto. Non conoscendo Nexal e come si integra, va benissimo anche utilizzare le SIS, però più che altro se quello che avete al momento vi crea limitazioni, vi crea delle difficoltà, quello poi ovviamente si rifletterà pure sul 2B con Salesforce, se ci sono.  Poi se non ci sono e mi dici guarda, a me l'integrazione va benissimo, quella che c'è adesso, vogliamo replicare la stessa identica integrazione, io ti dico a me va benissimo, cioè non va bene così.  Basta che ci viene condiviso il file, sia quello che dovremmo mandare a loro, immagino quello che poi loro ci mandano a noi e capire un attimino come è strutturato proprio per fare un data model che poi...  e sia utilizzabile per l'integrazione.

7:09 - Elena Spini (ROMI Company)
  Cosa ti preoccupa dell'integrazione, PIA e Fabrizio?

7:17 - Marco
  No, io la ragionavo nel senso che, visto che siamo abbastanza stretti con i tempi, e siccome quella parte lì, diciamo, dei flussi contabili tra CRM e Mexal, e da Mexal verso il CRM, in qualche modo è fatta, e magari, dicevo, visto che siamo già stretti con i tempi, in generale, abbiamo già un pezzettino fatto, magari quello lì lo lasciamo così com'è.  Sì, però è di...

7:50 - Andrea Di Cicco
  Sì, ovviamente... Ah, scusa, scusa che ti hai rifritto. Vai, vai.

7:55 - Marco
  Dicevo, ci saranno dei tempi sia per fare l'integrazione tramite il CSV... c Sì, tutto... E dei tempi per fare l'integrazione via API, quindi si trattava di capire, come dire, una vostra valutazione di quanto magari potrebbe essere più complicato in un modo piuttosto che nell'altro?

8:18 - Andrea Di Cicco
  Ripeto, non sapendo le integrazioni io non posso fare una stima, in generale un'integrazione tramite API è più facile rispetto a un'integrazione con Fathom, quello è poco ma sicuro.  Però dall'altro lato va pure considerato, giustamente come dici tu, stiamo con i tempi stretti, se facciamo integrazioni con gli API magari sarà necessario più coinvolgimento da parte di Mexal per poter gestire, per capire magari il flusso, come funzionano queste API, invece se utilizziamo il file già così com'è, una volta che capiamo quali sono le informazioni, che il flusso funziona e così via, abbiamo finito.  E utilizzeremo quello lì. La sicurezza che ti posso dare è che risparmiamo sulla parte di analisi a livello di tempistica.  Quello è sicuro. Possiamo prendere per assunto di farlo così e poi magari in futuro valutare se ci saranno ulteriori esigenze di passare all'API.  Vediamo. Però almeno ottimizziamo in questo modo. Un'altra cosa, ma il file dove viene caricato? Direttamente su Maxal? Oppure utilizzate una sorta di DB di frontiera?

9:41 - Marco
  Abbiamo praticamente una cartella FTP, dove praticamente sono parcheggiati questi file, sia gli ordini che sul CRM vanno in stato.  Chiuso, acquisito, quindi da fatturare, vengono trasportati su questa cartella. Poi dopo c'è una procedura che io attivo da Mexal, gli dico, importa gli ordini, Mexal va dentro questa cartella, mi incarica gli ordini che io poi dopo posso fatturare.  Poi cosa succede? durante la notte c'è un'elaborazione che gira su Mexal, vengono salvati i dati su questa stessa cartella e poi il CRM alle tre e mezza mi pare che si giri, alle tre e mezza va a tingere i dati contabili da questa cartella e fa tutti gli aggiornamenti che deve fare.  Ok.

10:45 - Andrea Di Cicco
  E si prende le fatture praticamente?

10:47 - Marco
  Prende le fatture, prende gli incassi, eccetera, eccetera, sì. Prende l'anagrafica clienti, l'anagrafica agenti, l'anagrafica prodotti, per fare i dati, per fare la fattura.

10:59 - Elena Spini (ROMI Company)
  Sì.

11:01 - Andrea Di Cicco
  Ok, e per accedere a questa cartella FTP, se ci sono particolari autenticazioni?

11:10 - Marco
  C'è uno user e una password. Ok. Dopo, adesso tecnicamente non mi chiedere dov'è e dove non è, perché non lo so esattamente neanche io.  Io ho l'accesso, posso vedere i file, però non so dove mi hanno dato uno user e una password e riesco ad accedervi tranquillamente.

11:30 - Andrea Di Cicco
  E, ok, sicuramente se riuscite a inviarci una copia sia del file che viene inviato a Nexal, sia del file che poi Nexal manda indietro, quello sicuramente ci aiuta a capire le informazioni che vengono scambiate.  Ti chiedo questo più che altro per il data model, perché poi l'altro giorno discutevamo pure del fatto che magari se un ordine aveva più rateizzazioni, al momento...  Vengono creati più ordini, però voglio capire se questa è una cosa dovuta proprio al CRM o una cosa proprio richiesta da Mexal, quindi questo qui lo capiamo un attimino.

12:11 - Marco
  A questa cosa qui provo a risponderti io. Diciamo che pur non conoscendo la genesi iniziale, allora, il tema che questi ordini padre venivano spacchettati in più ordini figli, uno per ogni determinata scadenza, e poi il fatto che ad ogni ordine fosse sottato uno ed una sola fattura è dovuto ad un'impostazione.  Non so se è decisa a livello direzionale, ha decisa a livello di responsabile amministrativo che c'era prima, questo non posso dire, comunque era stata data questo tipo di impostazione.  Un ordine, una fattura. Poi dopo nel corso del tempo, soprattutto nel corso degli ultimi mesi, diciamo è stata come dire un attimino cambiata idea, dice no ma perché devi avere, perché sullo stesso ordine non lo puoi fatturare altre volte eccetera eccetera, però magari chi ha avuto questa idea si è dimenticato del passato.  Io questo non lo so. Tanto sta che ho fatto una, con le persone di Mexal, ho fatto una verifica, gli ho detto bene, guardate, gli detto noi ad oggi abbiamo questa situazione qui, un ordine, una fattura.  Potremmo fare in modo che per lo stesso ordine possiamo fare più fatture in base alla data di scadenza? La risposta è stata fatta, è stata certo che sì, quindi tecnicamente  Su Mexal è possibile fatturare un ordine in più tranche predefinite. La condizione è che nel momento in cui io inserisco l'ordine su Mexal, in ogni riga ordine ci sia una data di scadenza.  Io l'altro giorno quando abbiamo visto quegli esempi fatti dove nelle varie ordine avevo messo anche nell'ultima colonna la data di scadenza, quello lì era una cosa che è stata involontaria, francamente, perché poi io la domanda a quelli dei Mexal l'ho fatta dopo.  Quindi fondamentalmente con quel file abbiamo pochino anticipato. Quello che poi dopo è quello che possiamo effettivamente fare. Quindi loro mi hanno detto, sì tu puoi inserire un ordine da 12.000 euro, esattamente, inserire in ogni riga ordine una scadetta, poi quando vai a fatturare quell'ordine, puoi decidere se fatturare un pezzettino, tutto o soltanto in base a quel campo data scadenza che fondamentalmente è un filtro, è un filtro di fatturazione.  Ok. Non so se mi sia spiegato, cioè quando noi andiamo a fatturare abbiamo un menu dove dice bene procedimi alla fatturazione differita, mi prendi tutti gli ordini dove?  La scadenza della riga ordine compresa da data a data.

16:04 - Andrea Di Cicco
  Ok, ok. No, è chiaro, vabbè, quindi ovviamente basta un ordine, importante mettere più scadenze separate, ma gliele posso inviare tutte insieme, cioè supponiamo che io faccio un ordine oggi, no?  E faccio 5 rate per quest'ordine, con scadenza mensile. Posso inviartele subito oggi tutte e 5? Giusto, no? Sì. voi ho capito.  E poi tanto sarà lui a gestirle sulla base della scadenza. Esattamente. mi manderà l'update, immagino quando saranno pagate, mi manda solo quelle che sono pagate.  Ok.

16:47 - Marco
  Meglio? Così è un po' più leggera la cosa. Anche perché, poi anche, diciamo, forse più facile, anche per il commerciale, il commerciale, una volta che è inscritto l'unico pacchetto, non ci deve più...  Lasciarlo, ci pensiamo noi, fatturarlo noi. Esatto.

17:08 - Elena Spini (ROMI Company)
  Invece adesso questa cosa non la potevate fare invece dal CRM, da ZOO, giusto? Cioè non riuscivate a gestire questa cosa?

17:21 - Marco
  No, in realtà avremmo potuto farlo anche da ZOO. Il tema qual era? Il tema era una, come dire, un must a livello alto, nel senso che non potevamo fare, diciamo, fatture di tutto l'ordine.  L'ordine, l'ordine padre, doveva essere spacchettato in più ordine per avere delle fatture piccole, non so come dire, insomma. Però ecco, non c'era...

17:56 - Elena Spini (ROMI Company)
  Cioè, ricordo che avevate detto che avevate trovato una sorta di work. Però avete detto che era questa cosa dei blocchi, che però non vi piaceva, giusto?

18:07 - Marco
  Ripeto, la cosa dei blocchi non piace più adesso, due anni e mezzo fa, tre anni fa, e si piaceva.

18:14 - Elena Spini (ROMI Company)
  Perfetto, ok, va bene, ok, quindi potenzialmente, allora giusto per rifare il giro, quindi potenzialmente abbiamo detto che un ordine che a noi arriva, tipo questo ordine facciamo ad esempio da palco, arriva quest'ordine da palco, quest'ordine A a conto E o N tranche, mi arriva direttamente l'ordine sul CRM, e adesso un'altra cosa che dobbiamo capire, dobbiamo capire poi effettivamente come quest'ordine ci arriva, ok, ma a voi, lasciando un attimo questo in...  A voi su Mexal, per la fatturazione, basta che vi arriva per ogni riga, tipo ad esempio, camerieri venditori, piuttosto che food marketing festival, il codice prodotto e la data di scadenza.  Poi, voi fate delle logiche di fatturazione che torneranno indietro direttamente sul CRM, a cui noi non dobbiamo più fare logiche.  Vi mandiamo le righe e voi mandate le fatture.

19:40 - Marco
  Allora, mi avvicino perché non vedo niente. Devo ringrandire?

19:50 - Elena Spini (ROMI Company)
  Ah, ok.

19:50 - Marco
  Questo era l'esempio della vendita da palco.

19:54 - Elena Spini (ROMI Company)
  Allora, questo qui è l'esempio della vendita da palco.

19:57 - Marco
  Allora, provo anche... anche ad aggiungere un qualche cosa perché vedi lassù noi diciamo questo pacchetto viene predefinito prima dell'evento.  Ok. Ok, c'è. Quindi in ogni evento ce ne possono essere più di questi pacchetti. Quindi questo per esempio l'hanno con pienissimo, ma ci potrebbe essere Academy 26, che ne so, Staff Pack, oppure Academy 26 Marketing Pack.  Ce ne possono essere 3-4, in alcuni casi anche 5 di questi pacchetti che vengono proposti in vendita durante l'evento.  Sono tutti uguali per tutti i clienti. Quando in questo caso qui a noi lo andiamo a configurare questo pacchetto, noi...  Poi ad oggi lo configuriamo su Mexal, diciamo, la base di partenza è Mexal, ma non so se magari, perché, ecco, scusate, faccio un po' di casino, perché anche tutti questi codici articolo che voi vedete qui, quelli in azzurro, blo, blo, blo, blo, blo, eccetera, eccetera, no?  Esatto, blocco 1, blocco 2, blocco 3, eccetera, eccetera. Anche quelli lì sono codici articolo che tre anni fa piacevano tantissimo, oggi non piacciono più, quindi ci dovremmo sganciare anche un attimino da questa logica.  Quindi noi dobbiamo creare, non so se, senz'altro ci sarà, tipo, su Zoho avevamo i, c'erano i CPQ, se non ricordo male, che noi non abbiamo usato.  Sostanzialmente si crea su un codice... Un codice, chiamiamolo Pippo, è strutturato... Un'azienda, ergo, un'azienda, un account, perché se non gli dici Pippo non capisco che è un esempio di un'azienda, magari.

22:19 - Elena Spini (ROMI Company)
  Vabbè, prova a dirmi cosa vorresti dire, perché adesso stiamo parlando di account, ma voi mi state parlando di pacchetti, quindi sono ancora più confusa.  Quindi, continua con il tuo esempio. Va bene Pippo, non ti preoccupare, poi capiamo cos'è. Non ho capito.

22:35 - Marco
  l'hai detto, vabbè, continua con esempio. No, no, non ho capito.

22:39 - Elena Spini (ROMI Company)
  Non ho capito.

22:41 - Marco
  No, io ho detto account, e lei detto, esempio, si crea su Pippo, Pippo cos'è in questo caso l'azienda, l'account?  No, io ho detto, creiamo un codice, un oggetto che ha codice Pippo, ok. Non litigata, non litigata. E codice prodotto.  Non ho capito. Che cosa sarebbe Pippo? Così capisco anch'io. C'è un codice prodotto? È presente quando abbiamo fatto il standard pack, eccetera, eccetera, che abbiamo detto abbiamo su Zoe CPQ, facciamo un test, allora io quindi creo un oggetto all'interno di un CPQ, questo oggetto deve avere un determinato codice e questo codice può essere Pippo, all'interno di Pippo è contenuto una lista di codice e articolo uguale a quello che adesso noi vediamo lì.  Pippo un codice, è un codice, però riguarda i prodotti, potevo dire, riguarda i prodotti, tant'altro, esatto. E questo Pippo contiene, se non mi piace Pippo, chiamiamolo Pluto, contiene al suo interno la lista di quei codici prodotti così come adesso li vediamo visualizzati nella lavanda.  Ciao. Bene. Bene, per me poi. Il tutor, quando deve inserire un ordine collegato a questo pacchetto, anziché andarsi a scrivere tutti quei codici che vediamo noi lì nella lavagna, richiama l'oggetto Pluto, quantità 1, e una volta che la conferma gli si esplodono tutti quei codici.  E''ottimizzazione del processo di lavoro. E' più chiaro così Andrea e Elena?

24:30 - Elena Spini (ROMI Company)
  Sì, no, è chiaro, è chiaro il passaggio.

24:34 - Marco
  Invece che inserire tre prodotti, io inserisco un codice che già ce li ha in pancia e quindi mi si contira in automatico e così abbiamo ottimizzato i tempi di creazione, di invio di un preventivo.  Quindi è una sorta di bundle.

24:51 - Andrea Di Cicco
  È un bundle, esattamente.

24:54 - Marco
  Quindi quando ci sono gli eventi, noi dobbiamo creare... ... Prima dell'evento, 3, 4, 5-bundle, la seconda di quello che la direzione decide di proporre in vendita.
  ACTION ITEM: Verify Salesforce licenses support bundle/CPQ; update Elena/Sabatino - WATCH: https://fathom.video/calls/730585136?timestamp=1507.9999  Nel momento in cui il cliente aderisce, questi bundle dove li possiamo creare? Possiamo creare direttamente su Salesforce?

25:18 - Andrea Di Cicco
  Allora, stavo verificando perché praticamente sulla base delle licenze che hai si possono fare e non fare su Salesforce. Ti spiego, perché ci sono licenze dedicate che ti permettono proprio di creare i bundle su Salesforce e gestirli direttamente dentro Salesforce.  Sto verificando se quella che avete voi permette di fare questa cosa qui. Però comunque i prodotti, listini, prezzi e tutto, quello va configurato lato Salesforce.  E poi eventualmente capiamo come gestire questi potenziali bundle.

25:52 - Marco
  Perché noi di bundle ne abbiamo una marea, perché tutte le volte che c'è un evento, Lavoriamo solo con quello.  praticamente solo con quelli.

26:01 - Elena Spini (ROMI Company)
  Eh, non ho infatti. Però prima hai detto, noi partiamo da Mexal, cioè quindi non sarebbe più così.

26:08 - Marco
  Adesso partiamo da Mexal perché siamo costretti a partire da Mexal.

26:12 - Elena Spini (ROMI Company)
  Quindi sei d'accordo nel... cioè, siamo tutti d'accordo nel fatto che se effettivamente questa cosa si potrà fare su Salesforce con le licenze attuali, o capiamo come, partiamo da Salesforce nel creare il bundle.

26:29 - Andrea Di Cicco
  Però, secondo me, va pure fatto comunque su Mexal, perché se tu mandi, che ne so, a bundle Pippo, a Mexal, Mexal lo deve riconoscere in qualche modo.  Questo sono d'accordo.

26:44 - Elena Spini (ROMI Company)
  Quindi va fatta la doppia configurazione comunque.

26:48 - Andrea Di Cicco
  Quello non lo so, non so come funziona Mexal, se ha bisogno dei prodotti lì.

26:53 - Marco
  Ma poi se il bundle viene creato solo su Salesforce... momento... ... ... ... Grazie. Nel momento in cui io inserisco un ordine con quel bundle, nelle righe ordine c'è la lista dei codici prodotti, giusto?  Non compare il codice bundle? Come funziona?

27:12 - Andrea Di Cicco
  Esatto, cioè il bundle sarebbe un insieme di sottoprodotti fondamentalmente, quindi tu dovresti avere tutti i sottoprodotti con i loro relativi codici, e poi bisogna capire se Nexal, Mexal è in grado di avere il codice del bundle padre e quindi recepisce tutto quanto o deve avere tutti quelli dei figli.  Quello, non so come funziona.

27:40 - Marco
  Allora, chiaramente i codici prodotto figli su Mexal ci devono essere, perché poi dopo Mexal fattura i codici prodotto figli.  Mi viene da dire, non è necessario che ci sia anche il codice prodotto bundle, perché nel codice prodotto bundle Nexal non serve.  Non ne fa niente, neanche al cliente.

28:05 - Elena Spini (ROMI Company)
  Però bisogna capire, cioè, quando poi io, ad esempio, guarda questo, questo immagino che sarebbe il, questo tipo Z, immagino che sarebbe il nostro bundle, codice blocco 308 e qua sta il prezzo, tutti questi altri codici sono a zero.

28:23 - Marco
  Eh, ma, eh, ripeto, questo qui è come facciamo adesso, ma di fianco lì dovremmo metterci come ci piacerebbe fare, tra l'altro, ehm, perché uno degli elementi è che, vi ho pur detto prima, i blocchi fino a tre anni fa piacevano, eh, da due, tre mesi a questa parte, i codici articolo che qui iniziano con bloc non piacciono più.  Quindi, la direzione dice, io non voglio vedere che ad un cliente gli arriva una fattura con un codice articolo blu, trattiva,  Io voglio vedere che siano valorizzati i codici sottostanti, quindi il CS002, CS001, adesso non vedo una mazza, non so se mi sono visto spiegare.

29:17 - Elena Spini (ROMI Company)
  Sì, sì, io ho capito, quindi potenzialmente potrebbe essere, facciamo un esempio con questo qua che mi viene più semplice forse, quindi allora guardiamo questo qua, blocco questo qua, lo ringrandisco, ok, Academy, quindi potenzialmente questo bloc 309 potrebbe essere a zero, e invece il 1500 potrebbe essere su il corso camerieri venditori 1500 con codice CS01, magari questo bloc potrebbe essere potenzialmente solo un insieme di prodotti per quell'evento.  che è stato creato solo su Salesforce e rimane solo su Salesforce. Potrebbe aver senso? Sì.

30:09 - Marco
  Diciamo che noi adesso, che cosa facciamo? Noi andiamo a creare su Mexal un codice articolo che contiene tutta questa sbrodolata di articoli qua, esattamente così come adesso.  Non Noi dovremmo... Non ti vedono se lo indichi. Ah no, perché hai messo il... hai messo qui il... il portatile...  io d'accordo qua che non vedo un... No no, loro non vedono se tu indichi loro non ti vedono. Se faccio così?  Faccio loro non vedono che cosa indichi da... ma tanto se indichi loro non vedono che cosa stai indicando.

30:57 - Elena Spini (ROMI Company)
  Prova a dirlo.

31:01 - Marco
  Allora, te hai evidenziato le tre righe, la prima riga, quella dove c'è Z, BLO, eccetera, eccetera, non la vogliono vedere.  Ci deve essere solo la riga 2 e la riga 3, esatto, non chiaramente codice articolo o maggio, valorizzate per un totale di 1.500.

31:39 - Andrea Di Cicco
  Domanda, a livello operativo, no? Supponiamo, io parlo per il 2B, per il futuro, è chiaro quello che intendi, è una lavorazione su bundle, quindi va bene, però quello che voglio capire è, quando tu immagini in futuro, crei un ordine?  Quindi apri il carrello e nel carrello inserisci blocco 2 Academy 2026. La tua necessità è quella di andare a modificare i figli del bundle o modifichi direttamente il bundle.  Praticamente, quello che voglio dire è, è possibile che camerieri venditori executive omaggio abbia, che ne so, un prezzo scontato e happy time non abbia sconto o che la quantità di quello che sta dentro è diversa, magari il primo a quantità 1, il secondo a quantità 2, oppure lavorate proprio a livello di pacchetto.  Nel senso, il bundle è questo, il pacchetto è fisso, se applico uno sconto lo applico su tutto il bundle.  Non so se è chiara la domanda.

33:09 - Marco
  Poi dopo, ad esempio, quello che può succedere è che viene proposto in vendita quel blocco a 1.500 euro, e questo qui è uguale per tutti i clienti che comprano durante l'evento Academy 2026.  Non è che lo andiamo a modificare nel corso del tempo. Finita la vendita dell'Academy 2026, quel bundle lì non lo useremo mai più.

33:46 - Andrea Di Cicco
  Ok, quello non è un problema perché su Salesforce puoi attivare e disattivare. Quindi praticamente posso... Poi dopo che cosa può succedere?

33:55 - Marco
  Può succedere che dopo l'Academy noi facciamo la Mastery, può succedere che alla... Mastery vendiamo sempre in un bundle camerini venditori e epitim con quantità diverse, con prezzi diversi, ma questo verrà solo ed esclusivamente all'Academy e il bundle che creeremo ad hoc per l'Academy lo usiamo durante l'Academy, finito l'evento dell'Academy non utilizzeremo mai più e così via.  Tu calcola che noi adesso abbiamo all'incirca 100, 102, 103, abbiamo circa 102, 103 pacchetti all'interno dei quali sono contenuti complessivamente oltre 350 blocchi, quelli che lì vedete che sono pacchetti, più 350 codici che sono blocchi.  Ma quei codici li abbiamo usati una tantum durante quell'evento e poi non li useremo mai più.

35:00 - Andrea Di Cicco
  Ok, però ogni tanto vi salta la connessione, quindi ho capito il concetto solo per essere chiaro su una domanda, quindi Block Academy ha questi due blocchi, questi due sottoblocchi, però se io ti vendo Block Academy, quello che sta dentro non lo modifico, cioè ti prendi Block Academy e ci deve essere sempre due camerieri e due happy time?  Ma perché lo dovrei modificare?

35:31 - Marco
  No, non lo modifico, però non ho capito perché dovrei modificarlo. No, non è che devi, è una domanda per capire la...

35:39 - Andrea Di Cicco
  È le casistiche, cioè a me serve capire come strutturare il carrello, ti faccio un esempio, tu compri un iPhone, ok, metti il carrello nell'iPhone, l'iPhone non può avere particolari.  No, sono quelli, ok, ok, questo è importante perché... A base di questo, noi modelliamo in un certo modo. Perché se devi andare a modificare quello che sta all'interno del bundle, mi crea un problema a livello di carrello.  Tutto lì.

36:12 - Marco
  No, Una volta che il cliente accutta, quando entra l'ordine, l'ordine è quello. Nessuno lo andrà mai a modificare. Ok.

36:25 - Andrea Di Cicco
  Va bene.

36:27 - Marco
  Questa cosa qui, secondo me, è importante perché, a parte il fatto che questi bundle pubbano il 40-45% del nostro fatturato, però è importante anche perché, per dire, con la stessa logica, potremmo impostare tutte le attività di quando le campagne commerciali spot che hanno, per dire, la validità di un mesetto come ad esempio.  Questo è quello che poi dopo voi vedete lì, vendite tutor combo, nella scheda vendite tutor combo, la logica è simile a questa, perché diciamo l'origine della vendita non sarà una vendita da palco, ma una...  Esatto.

37:30 - Elena Spini (ROMI Company)
  E solo per conferma, perché sempre ogni tanto vi sentiamo a scatti, quindi è un po' così, e il requisito dovrebbe essere che prendiamo sempre queste nostre tre righe, che il prodotto contenitore, non chiamiamolo più blocco, quindi il pacchetto che viene configurato con ad esempio Academy 2026, due righe, il prezzo sia...  Sulle righe, non sul pacchetto? Esattamente. Va bene, su questo ci dobbiamo fare un attimo una pensata.

38:14 - Marco
  Se sono omaggio bisogna indicare il best. Ma infatti la Daniela, sempre che non ci sia un cambiamento di idea dell'ultimo minuto, lei nei bundle non vuole vedere le righe a zero, ma vuole vedere un valore direttamente sulle righe.  Però, cioè, tu valorizzi un omaggio, giusto? Dopo non useremo. Adesso usiamo il codice prodotto marzo, dopo useremo il codice prodotto quello vero.  Eh, però dopo io lo vado a scontare, quello, perché non glielo faccio creare.

38:48 - Elena Spini (ROMI Company)
  Certo.

38:49 - Marco
  Quindi te lo valorizzi e lo sconto. Quindi la logica di base è quella di non far vedere che una cosa vale zero, in termini, diciamo, più commerciali, ma riuscire a fuori che ti ho dato due biglietti.  Perché lì in realtà mancherebbe una colonna,'è unità di misura, quantità, mancherebbe prezzo di listino e sconto, c'è prezzo netto.  Quindi noi oggi diciamo al cliente, perché dopo sai, se glielo metti sotto il naso, lo vedono, se non glielo dici, uno dice, è chiaro che se è omaggio avrà un valore, però sai, siccome poi i clienti arrivano e rompono le scatole per la qualunque, invece in questa maniera, diciamo, vada, il valore era 3.000, è pagato 1.500, perché questi te lo scontate del 100%, quindi non li chiamiamo più omaggio, li chiameremo in un altro modo.  No, anziché usare camerieri, venditori e esecchi di omaggio, CS0001, useremo CS0002, camerieri, venditori e esecchi, useremo un altro codice.  Senso del perché.

40:05 - Elena Spini (ROMI Company)
  Va bene, dai, su questo abbiamo capito e dobbiamo fare un attimo ancora una pensata, perché questa cosa della creazione dei pacchetti sta uscendo adesso, quindi capiamo se effettivamente con le licenze che avete si può fare qualcosa, ci possiamo inventare qualcosa comunque.  Ok, quindi torniamo al tema fatturazione, quindi è importante mandare le righe d'ordine con la scadenza, così che Mexal poi può fare le fatture in autonomia e voi, Mexal, mandate le fatture direttamente su Salesforce, ora.  Aspetta, avevo una domanda. L'ordine che ci viene mandato, quindi ad esempio questo, prendiamo sempre il nostro vendito da palco, c'è un QR code che inquadra l'utente che sta all'evento, inquadra e arriva a un certo punto su WooCommerce e paga l'acconto.  L'ordine che nell'exis oggi vi arriva su Zoho, è l'ordine totale o è l'ordine dell'acconto con tutte le righe? Cioè come funziona questa parte?

41:36 - Marco
  Ora, il cliente scansiona il QR code, procede al pagamento, ipotizziamo che paga con carta di credito. In questo caso la generazione degli ordini avviene tutto in automatico, se paga con bonifico la generazione degli ordini avviene, ecco se qui scendi, scendendo, scendi un po' nel...  Bene, lasciamo... Facciamo qui.

42:01 - Elena Spini (ROMI Company)
  Sì, facciamo il caso semplice, cartè di credito.

42:05 - Marco
  Vai giù, scendi, nel momento in cui l'ordine su WooCommerce va in stato completato, si genera su Zoho sia l'ordine bundle che tutti gli ordini figli.  Si generano entrambi ad oggi su Zoho, vedi? Poi si generano tutti gli ordini figli. L'ordine bundle, bundle. Il primo ordine figlio, che è quello per cui il cliente ha pagato l'appunto, va in stato chiuso, acquisito, mentre quelli successivi vanno in stato di creato.

42:44 - Elena Spini (ROMI Company)
  Funziona così adesso.

42:45 - Marco
  Quindi fondamentalmente oggi, nel momento in cui l'ordine passa da WooCommerce verso Zoho, perché il cliente in qualche modo ha pagato, si genera su Zoho un ordine bundle che deve...  Contiene tutti gli ordini Fildi e poi si generano tutti gli ordini Fildi.

43:09 - Elena Spini (ROMI Company)
  Ok, questo è lo segno. Quindi in realtà c'è l'indicazione che quest'ordine è bundle, è proprio lo stato dell'ordine stesso.  Invece l'ordine completato che effettivamente paga è l'acconto. Potenzialmente qua si potrebbe più o meno fare la stessa cosa, Andrea, con la cosa che avevamo pensato.  Cioè ordine che arriva bundle e poi le rate, anziché ordini. Sì, sì.

44:01 - Andrea Di Cicco
  Perfetto, va bene.

44:04 - Elena Spini (ROMI Company)
  E qua sarebbe un po' come quello che abbiamo visto prima, il codice, questo blocco con la stessa logica. Invece, scusate, per la cosa della zero euro, che cosa avete detto?  Che non volete più vedere zero euro per gli omaggi? Cioè, ad esempio, questo 1800 sarebbe un manuale operativo. E questo?  Questi due codici?

44:37 - Marco
  Cambieremo i codici prodotto. Quindi, nell'ordine, bisognerà che la riga ordine che ha codice prodotto, che inizia per blu, non ci sia.  Poi gli altri codici articolo, quindi in quel caso lì, CS0002, CS0001, CS... 0, 129, eccetera, eccetera. Non useremo quei codici lì, ma ne useremo altri di codici che abbiamo già codificato in anagrafica e che non si chiameranno sold out omaggio, ma si chiamerà sold out, non si chiamerà odb live omaggio, ma si chiamerà odb live a pagamento, fondamentale.  E ci saranno dei prezzi?

45:22 - Elena Spini (ROMI Company)
  Ah, per forza.

45:25 - Marco
  Quelli lì sono prodotti che hanno un prezzo di listino, una quantità, uno sconto, eccetera. Va bene, perfetto.

45:34 - Elena Spini (ROMI Company)
  Va bene, tanto poi quelli li dobbiamo importare, quindi si vedrà quello che verrà importato. Era solo per capire questa cosa dello zero euro che stavate parlando prima.  Va bene. Ripeto, questo qui è come facciamo adesso, ma non è come vorremmo fare.

45:58 - Marco
  Magari ti prendiamo... Quello che possiamo fare è prendere questo fuorio, non si sente, no, no, sta peggiorando la situazione.  Ah, ora, fin quando non finiscono, non va.

46:42 - Sabatino Rinaldi ( Pienissimo)
  E non si è sentito nulla, provate a chiudere la webcam e lasciare solo il microfono aperto, così regge di più.  Non so se ci sentono, dubito. No, mi sa che sono proprio frizzati.

46:57 - Elena Spini (ROMI Company)
  Sono fermi.

47:02 - Marco
  Sì. Ci sentiamo.

47:14 - Sabatino Rinaldi ( Pienissimo)
  Ok, bravo, tenete la webcam spenta, il microfono acceso, se no non si blocca di continuo.

47:24 - Elena Spini (ROMI Company)
  Ci sentite?

47:28 - Marco
  Adesso sì.

47:35 - Elena Spini (ROMI Company)
  Fabrizio?

47:40 - Marco
  Sempre a tratti, prova. Ho detto che ho trovato una proposta. Niente, dai faccio una cosa, vado io di là, dai, no non la finiamo.

48:00 - Sabatino Rinaldi ( Pienissimo)
  Vado io di là Elena e mi collego da lì. Ok, ok. Ci senti?

49:17 - Elena Spini (ROMI Company)
  Sì. Ora sì.

49:30 - Sabatino Rinaldi ( Pienissimo)
  Adesso vi sentiamo.

49:33 - Elena Spini (ROMI Company)
  Ok, non so, stava dicendo Fabrizio qualcosa a questo documento e poi ha iniziato tutto il blocco. No, stavo dicendo che non ho inteso male.

49:45 - Sabatino Rinaldi ( Pienissimo)
  La volta scorsa ci avevate detto che avevate una proposta da sottoporci.

49:52 - Elena Spini (ROMI Company)
  Sì, allora, era per la gestione delle rate che abbiamo pensato. In realtà poi effettivamente quando lo andiamo a scrivere in un grafico è una cosa un più tecnica, quindi la gestione delle rate la possiamo fare ed è quello che volevamo giusto un attimo capire effettivamente che cosa vi aspettavate per poi effettivamente proporlo magari anche in un grafico e tutto.  Però comunque la cosa delle rate si può fare e si possono fare le rate con la data di pagamento come ci hai chiesto.  Dobbiamo un attimo verificare per il tema del pacchetto. Quello sì, la cosa di avere un pacchetto a zero con le righe d'ordine.  Però verifichiamo e vi facciamo sapere. Un pacchetto con le righe a zero con le righe d'ordine?

50:47 - Sabatino Rinaldi ( Pienissimo)
  Cosa vuol dire?

50:47 - Elena Spini (ROMI Company)
  Il pacchetto a zero, abbiamo detto, con le righe di prodotto praticamente. No? Quello che abbiamo detto adesso.

50:57 - Sabatino Rinaldi ( Pienissimo)
  No, oltre... Ma lo dici? Temo che non mi sia spiegato bene.

51:06 - Elena Spini (ROMI Company)
  Ok.

51:07 - Sabatino Rinaldi ( Pienissimo)
  Questo qui è un pacchetto che vale 9.800, ok? Quello che tu vedi è un bundle che complessivamente vale 9.800, se non mi ricordo male.  Allora, noi che cosa vorremmo fare? Che?

51:27 - Elena Spini (ROMI Company)
  Questo qui è il pacchetto come lo facciamo adesso, bene, così non lo vogliamo più.

51:31 - Sabatino Rinaldi ( Pienissimo)
  Come lo vorremmo? Lo vorremmo che le righe articolo che qui vedi evidenziate in azzurro non devono esistere, non ci devono essere.  Ok. Ok. Tutte le altre, quindi tutte le righe articolo nella fattispecie carattere nero dovranno essere, dovremo utilizzare dei codici prodotto che nello specifico non saranno questi ma saranno un altro codice.  Dove avremo i codici prodotto veri, non i codici prodotto omaggio. Perché noi, cosa succede? Che così come adesso, noi valorizzando il blocco, dobbiamo per forza mettere gli articoli, utilizzare i codici articolo omaggio.  Ok. O più il blocco, perché il blocco non piace più a nessuno e non lo vogliamo più, dovremo utilizzare i codici articolo effettivi.  Quindi, il bundle sarà, un bundle che complessivamente avrà 9.008. E sarà composto da la riga 60, 61, 62, con determinati codici articolo che corrisponderanno al sold-out, all'ODB live, al manual operativo, quantità 1, prezzo, quello vero, sconto X.  Complessivamente, la somma dei tre articoli dovrà dare un netto di 1.800. E così di seguito per tutti gli altri.  Quindi, non ci dovrà più essere la riga 60, scusa perché vado di qua. Non ci dovrà essere. più la riga 63, ma ci dovrà essere solo la riga 64-65, camerieri venditori executive e happy team, quantità, prezzo, sconto, la somma con le due righe, 5.

53:15 - Elena Spini (ROMI Company)
  Ma prima non abbiamo detto che ci dovrebbe essere la possibilità di, che ne so, non chiamiamolo più blocco, chiamiamolo pacchetto.  Pacchetto Academy 2026 deve contenere camerieri venditori e happy team? Sì, perché mi sa che questo, cioè, quindi, me, cioè, l'ordine, aspetta, scusa, finisco, l'ordine bundle è formato da le righe, diciamo, nere, ok, che però ci sono in realtà uno, due, tre, quattro, cinque, sei pacchetti.

53:56 - Sabatino Rinaldi ( Pienissimo)
  No, allora, io sono io che non sono capace a spiegarlo, provate. Dirglielo a voi.

54:02 - Andrea Di Cicco
  Ele, no, perché questo, perché quelli erano, l'ho capito adesso, bundle nel bundle, è tutto quanto un bundle, cioè, sold out omaggio, o DB live omaggio, manuale operativo, camerieri venditori, AP team, questo era tutto un unico bundle, quello di prima erano questi, questi blu, sono bundle nel bundle.  Che non li vogliamo più avere.

54:32 - Sabatino Rinaldi ( Pienissimo)
  I blu, in sono le rate, i blu, in realtà, sono le rate, che non le vogliamo più avere. Ok.  Va bene. bundle, tutto è il bundle. Togliete, togliete le righe blu, che quelle non le vogliamo più avere, tutto è il bundle.

54:49 - Elena Spini (ROMI Company)
  Quindi, in realtà, cioè, quando si vuole creare un pacchetto di questo tipo, che era, si chiamava Academy 2026, ok?  Quindi, quindi, In questo momento, Academy 2026, se io sono l'utente che configura il pacchetto, mi devo segnare tutti i codici prodotti neri.  Punto.

55:11 - Sabatino Rinaldi ( Pienissimo)
  Esattamente. Oh, ok.

55:14 - Elena Spini (ROMI Company)
  Esattamente.

55:15 - Sabatino Rinaldi ( Pienissimo)
  Va bene.

55:16 - Elena Spini (ROMI Company)
  E comunque questo non deve avere prezzo. ci saranno più.

55:22 - Sabatino Rinaldi ( Pienissimo)
  I codici articoli che si chiamano BLO non li porteremo neanche su Salesforce. Sono articoli che moriranno.

55:34 - Andrea Di Cicco
  Va bene.

55:35 - Elena Spini (ROMI Company)
  Vabbè, poi tanto queste, cioè, dovremo fare l'import dei dati di prodotti, quindi di questi codici, quando siete pronti, cioè, e li avete configurati, noi li importiamo così come ci dite.  Quindi se non ci saranno i BLO ci saranno solo i CS con la descrizione corretta. Noi su questo decidete voi, ecco, che cosa, che cosa.  Quali saranno i codici? Va bene, quindi allora, questa cosa dei pacchetti sarebbe solo la parte delle riche nere. Ok, mi ero segnata forse un'altra domanda?  No, forse l'abbiamo visto prima, cioè ci sarà in un qualche modo l'ordine che viene definito come bundle da, abbiamo detto, VCommerce, stato ordine bundle, così, ah no, vendita tutor invece non è così, perché verrà creato direttamente dal tutor in Salesforce, corretto?  Quindi sarà il tutor che metterà codice per codice in ogni pacchetto che vuole vendere, combo, insomma, preventivo che vuole fare.

57:15 - Sabatino Rinaldi ( Pienissimo)
  Sì. Ok.

57:17 - Elena Spini (ROMI Company)
  Su questo in realtà vi dobbiamo fare la proposta noi, sulla parte del rinnovo e di gestione dei rinnovi. Non so, sul lato tecnico che manca per la parte di Mexal?  Dobbiamo vedere i file che vengono inviati. Ma questi file, Fabrizio, quando ce li potresti dare? Ve li dobbiamo E senza questo in realtà siamo un po' bloccati su...  Ah, se lo so...

58:00 - Sabatino Rinaldi ( Pienissimo)
  Sapevo, ve li davo anche la volta scorsa. Rimaniamo subito dopo finita la call. Sì, la prossima volta ci fate vedere qualcosa.

58:11 - Andrea Di Cicco
  Sì, che magari abbiamo pure domande su qualcosa che ci sarà dentro per capire che cosa sono effettivamente alcuni valori.  Ok.

58:25 - Elena Spini (ROMI Company)
  Invece poi per la configurazione, cioè se effettivamente andiamo per la via di gestire questa integrazione tramite file come il vostro esiste, poi la parte di aggiornamento che Mexal non deve più parlare con Zoho, ma deve parlare con Salesforce.  Sei autonomo per fare questo passaggio, Fabrizio? O dobbiamo fare un passaggio con i tecnici di Mexal? Io non so un informatico, quindi...

58:59 - Sabatino Rinaldi ( Pienissimo)
  Grazie. Grazie. Grazie. Grazie. Grazie. Non sono autonomo, quindi...

59:02 - Andrea Di Cicco
  Ma, no, nel senso, forse, quando questo file viene preso da Mexal, poi rimandato e così via, viene poi cancellato?  O resta lì?

59:16 - Sabatino Rinaldi ( Pienissimo)
  I file vengono sovrascritti. Ok, quindi poi bisognerà capire che quando... Il file degli ordini, una volta che Mexal importa l'ordine, il file dell'ordine viene spostato su un'altra cartella.  In un'altra cartella. Mentre invece, che so, l'anagrafica clienti, l'anagrafica pacotti, la lista delle strutture, eccetera, eccetera, ti vengono tutte le noti aggiornati e sovrascritti.  Quindi stiamo parlando di più file, però?

59:54 - Andrea Di Cicco
  No, no, è un file unico. Ok. Va bene.

1:00:07 - Sabatino Rinaldi ( Pienissimo)
  O meglio, c un file per l'anagrafica clienti, un file per l'anagrafica prodotti, in questo senso qui. E allora sono più file.  Poi dopo, ogni notte, il file dell'anagrafica clienti viene sovroscritto a quello del precedente. Cioè il file padre è unico.  padre è unico. Poi ogni volta, cioè sono più file unici che ogni giorno si aggiornano. Quindi non è che, ad esempio, file anagrafica è sempre lo stesso e ogni giorno si aggiorna.  File contabile è sempre lo stesso e ogni giorno si aggiorna. No, scusa.

1:00:46 - Andrea Di Cicco
  File anagrafica...

1:00:49 - Elena Spini (ROMI Company)
  Del cliente, la fatturazione.

1:00:52 - Sabatino Rinaldi ( Pienissimo)
  Sì, la fatturazione. Allora, cioè il file dell'anagrafica clienti è un file unico ogni notte si aggiorna. Qui c'è un file con l'anagrafica di...  Gli agenti è un file unico ogni notte si aggiorna, il file delle fatture messe è un file unico ogni notte si aggiorna, lo scadenziario è un unico ogni notte aggiorna, così via.  Quindi sono n file, non so, non mi ricordo quanti, sono n file che si aggiorna ogni notte, ma non è che viene creato un file nuovo tutte le notti, capito?  Non è che c'è una galattica clienti. Sì, diciamo che se sono dieci file, sono sempre quei dieci file, non diventano venti, trenta, quaranta, cinquanta, rimandano sempre dieci, per sempre si sovrascrivono.

1:01:33 - Andrea Di Cicco
  Ok, allora quindi due questioni. Prima questione, non è un solo file, ma sono dieci file, quindi sono dieci integrazioni diverse.  Secondo punto è, ovviamente nel momento in cui ci sarà un dual run, quindi quando sia Zoho che Salesforce lavoreranno nello stesso momento, dobbiamo stare...  Attenti a sincronizzare bene le informazioni, perché altrimenti rischiamo che le varie sovrascrittore dei file ti perdono le varie cose.  Quindi, quando ci mandate l'esempio, non mandate solo l'esempio di un unico file, ma di tutti e dieci file, perché sono dieci tipologie di informazioni diverse.
  ACTION ITEM: Email Elena/Andrea: 8 Mexal CSVs + API docs + other modules + WooCommerce keys; then Andrea analyze/propose - WATCH: https://fathom.video/calls/730585136?timestamp=3730.9999

1:02:21 - Sabatino Rinaldi ( Pienissimo)
  Ti mandiamo la cartella. Ti mandiamo direttamente una cartella via mail, zippata. Ok. A chi la mandiamo? A Elena o a direttamente a È uguale, tanto poi semmai me la giro.

1:02:33 - Andrea Di Cicco
  Mandala a Elena, così la carica e poi...

1:02:36 - Elena Spini (ROMI Company)
  Mettete anche Andrea, oltremmeno.

1:02:39 - Andrea Di Cicco
  Non scappi. Ok. Io comunque, cioè, non...

1:02:47 - Elena Spini (ROMI Company)
  Allora, ho capito il tema del... Cioè, perché Mexal... Allora, aspetta, rifacciamo. Il tema dell'aggiornamento dell'anagrafica e di questa creazione della...  della cartella, cioè è per attualmente serve a l'aggiornamento dell'anagrafica, per avere l'aggiornamento dell'anagrafica anche su Mexal, questo è il tema?

1:03:15 - Andrea Di Cicco
  Sì, è il billing account praticamente, perché a volte le informazioni billing account vengono mandate insieme all'ordine, quindi tu quando carichi l'ordine mandi pure il billing account con tutte le info, invece loro hanno spacchettato proprio per entità e quindi hanno un file per ogni entità.  Quanti ne abbiamo contati di questi file?

1:03:40 - Elena Spini (ROMI Company)
  Una decina da quello che ho capito.

1:03:42 - Andrea Di Cicco
  Di preciso.

1:03:44 - Sabatino Rinaldi ( Pienissimo)
  Scusa, vado dal PC così te lo dico. Te lo dice ora, guarda, va a vedere dal computer. Ho fatto una modifica, ieri faceva dei test, uno con mail e stessa partita IVA di prima, e un altro con stessa mail e una partita IVA di Firenze.  E il manual di Facebook l'abbiamo fatta.

1:04:15 - Elena Spini (ROMI Company)
  Ma avete fatto delle modifiche, sì.

1:04:17 - Sabatino Rinaldi ( Pienissimo)
  Ho fatto, ma quando ho chiamato proprio un nodo, non è più lo stesso. Quindi hai messo un mail e in partita IVA come...  Quale c'è cosa che funziona? Da Fathom, quello che diceva, quello che diceva. No, un altro, mi avevo fatto io.  Quello che ha detto, quando gli ha detto quella cosa di zoo, che non entra. Ecco, l'ho fatta. Eh, sì.  Ah, il problema che deve essere quello, quindi. Sono troppo forte, hai visto? Quanto non mi sono dicendo solo. Sono io.  Ah, lì, sì, tazzo. Sì, tazzo. Tantissimo. Qualcuno non c'è, se non mi è così. Nessuno ti dirà bravo in questa vecchia.  Grazie. Allora i file sono 8, dopo diciamo che voi in base anche a come sostituiate questi file ci farete la proposta anche se è conveniente passare tramite API oppure tramite file Io questa cosa non te la posso fare se non mi dici quali API hanno loro, cioè come è?  Ah ma dopo ti diciamo che il manuale dell'API.

1:06:53 - Andrea Di Cicco
  Ok, perché senza quello io non so farti una stima di quello che si può fare, non si può fare.  Considera se facciamo le API hanno un impatto anche loro. Loro nel senso che dovremmo capire poi i flussi come funzionano tramite API e se devono essere fatte modifiche lato loro.  Quindi va fatta un'ulteriore analisi. Io comunque farò quest'analisi qui e vediamo un attimino se mi mandi documenti. Senza documenti io non posso analizzarlo.

1:07:22 - Elena Spini (ROMI Company)
  Quindi i documenti che ci servono sono gli otto file che voi utilizzate nell'ESIS e il documento API di Mexal.  Esatto. Ok?

1:07:36 - Sabatino Rinaldi ( Pienissimo)
  Sì, sì. Ok, perfetto.

1:07:39 - Elena Spini (ROMI Company)
  Ti vedo piccolino Fabrizio, ma mi sembra titubante. Tutto ok? Ante?

1:07:50 - Sabatino Rinaldi ( Pienissimo)
  Preoccupato, non lo so.

1:07:51 - Elena Spini (ROMI Company)
  No, sono molto preoccupato.

1:07:53 - Sabatino Rinaldi ( Pienissimo)
  No, no. Comunque sono sicuro che ce faremo. No, assolutamente.

1:08:00 - Elena Spini (ROMI Company)
  Certo che ce la faremo, però ecco, quando si toccano i temi di integrazione, si vanno a toccare dei temi delicati e soprattutto anche dall'altra parte ci deve essere disponibilità del team tecnico, in questo caso di referenti MEXAL, solo questo, se si va a cambiare qualcosa e si va a cambiare la logica da API, quindi questo sicuramente.  Comunque, allora, dato che ora attendiamo questa parte, diciamo, lato vostro, direi di anticipare i temi invece del meeting successivo, così che poi magari arriviamo col tema integrazione, con qualche proposta in più e qualche logica in più la prossima volta.  Stesso discorso lo dobbiamo fare per l'integrazione di WooCommerce. Perché noi gli ordini che dobbiamo ricevere, anzi che sono praticamente quelli da palco e poi successivamente quelli di libri, videocorsi, e poi non mi ricordo più se Pienissimo Pro lo acquistano dove?  Cioè è una cosa... Tramite la carta, non passano da WooCommerce. Ok, non è WooCommerce, ok, quello lo lasciamo per dopo.  Quindi solo la vendita da palco e i prodotti videocorsi e libri passano da WooCommerce. Quindi in questo caso anche abbiamo bisogno dell'API, su questo siamo pronti, abbiamo...

1:09:43 - Sabatino Rinaldi ( Pienissimo)
  Quello vai tranquilla, tanto lo facciamo noi internamente, quindi ti mando tutto io, possiamo fare API, webbook, plugin, quello che vi pare.  o meglio, come si intera meglio con Salesforce, così facciamo. Ok.

1:09:58 - Elena Spini (ROMI Company)
  Ma voi non avete una...

1:10:00 - Sabatino Rinaldi ( Pienissimo)
  Un plugin con WooCommerce. Salesforce non ha un plugin con WooCommerce. Vedo sul marketplace. Se abbiamo quello, l'abbiamo fatto. Se no, tramite API possiamo far tutto.  Poi abbiamo l'inti client e client secret. Abbiamo tutto, quindi davvero lì siamo liberi di giocare come vogliamo.

1:10:26 - Elena Spini (ROMI Company)
  E su questo l'integrazione sarà solo che Salesforce riceve in lettura l'ordine.

1:10:37 - Sabatino Rinaldi ( Pienissimo)
  Salesforce riceve in lettura l'ordine e deve poi mappare tutti i campi. Ad esempio, se un ordine ha più prodotti collegati, mi aspetto che ci siano tutte le voci poi su Salesforce.  Salesforce. Così come sarei obrevati. Una difficoltà che abbiamo con Zoho, così che la dico e vi dico... E' che spesso noi su WooCommerce creiamo, te li chiamo bundle, o anzi no, facciamo proprio ad esempio un unico evento che costa 97 euro, magari facciamo il 2x1, quindi l'utente mette quantità 2 e invece di pagare 97 euro per 2 paga solo 97 euro, però ha due biglietti.  Su Zo, Zo fa fatica a ricevere questo messaggio, nel senso non capisce che abbiamo fatto un 2x1, ma mette quantità 1 e 97 euro, oppure mette quantità 2 e moltiplica 97 euro per 2.  Quindi in pratica, per fartela breve, non arriva il 2x1 con valore totale 97 euro, ma c'è sempre un casino.  Quindi questa è una roba che in un modo o nell'altro spero che risolviamo insieme. Cioè, magari a voi non succede questo problema.  No, perché abbiamo il discount, quindi...

1:12:00 - Andrea Di Cicco
  Metti quantità 2 al 50%.

1:12:04 - Sabatino Rinaldi ( Pienissimo)
  Ottimo, è importante che si fa facile.

1:12:08 - Andrea Di Cicco
  Ok, un plugin forse ci dovrebbe essere, una sorta di connettore, però verifichiamo, perché i connettori ti dicono sempre che ci stanno, sono belli, funzionano tutti, si sincronizza tutto, poi non funziona mai nulla.

1:12:22 - Sabatino Rinaldi ( Pienissimo)
  Allora, per voi va bene farlo tramite API, per me le API sono sempre la soluzione migliore, quindi lo facciamo tramite API, così giriamo davvero quello che vogliamo, come lo vogliamo.  Esatto. E non siamo schiavi di eventuali aggiornamenti del plugin, eccetera. C'è stata l'integrazione tramite plugin di Zofid, e io penso che un plugin così di merda non l'abbiamo mai inventato.  Hai capito?

1:12:46 - Elena Spini (ROMI Company)
  Dai, allora, siamo tutti d'accordo. Da WooCommerce poi in realtà, oltre all'ordine, arriverà l'anagrafico.

1:13:00 - Sabatino Rinaldi ( Pienissimo)
  Da WooCommerce l'ordine deve arrivare ovviamente tutti i dati del cliente, quindi che siano mail, partita IVA, ragione sociale, indirizzi di spedizione, tutte queste cose qui.  E dobbiamo sempre assicurarci che se un cliente è già nella nostra anagrafica di Salesforce e va a fare un ordine, ovviamente non si duplica, il merito deve essere fatto per email e per partita IVA, queste sono le informazioni in base, diciamo, per capire, per non fare errori.  Sui clienti c'era anche quel discorso che avevamo fatto al suo tempo,'era ancora, come si chiamava? Qual è stato? Daniele?  Eh? Daniele? No,'era l'altra ragazzo, Vittorio, mi sbaglio? No, dai, il primo, il commerciale, com'è che si chiamava? Ma nostro?

1:13:51 - Elena Spini (ROMI Company)
  Sì, sì, sì. Andrea? Ah, si chiamava?

1:13:54 - Sabatino Rinaldi ( Pienissimo)
  Vittorio, mi chiamava. Vittorio si chiamava? Sì, comunque sia lì, il discorso era già... Sì, sì. Su una grafica clienti, noi abbiamo il collegamento con Anticipate, barra Anticipate, che controlla l'azienda.  Questa è la cosa dove c'era una delle prime, mi sapevo. Era una delle prime, dove questa cosa era venuta comunque già fuori, anche quando c'era ancora l'elena, se non ricordo male.  Allora, ma che ne hai detto?

1:14:25 - Elena Spini (ROMI Company)
  Aspetta, vado a riprendere gli appunti e su questo mi ero segnata. Ok, quindi ce l'hai. Aspetta, Satisfate Credit Safe.

1:14:37 - Sabatino Rinaldi ( Pienissimo)
  Esatto, perché una volta si chiamava Credit Safe, è diventato Anticipate, comunque sia quando viene...

1:14:44 - Elena Spini (ROMI Company)
  Spire la solvibilità creditizia del progetto.

1:14:50 - Sabatino Rinaldi ( Pienissimo)
  Oltre a quello, nel momento in cui entra nel CRM una nuova partita IVA, c'è la chiamata a questa Anticipate, dove ti riporta in automatico...

1:15:01 - Elena Spini (ROMI Company)
  Però su questo, attenzione, perché avevamo detto che dovete fare un passaggio voi, perché c'era forse Daniela, che non so, aveva qualcosa da ridire.  Io mi ero segnata, si vedi. Devono ancora capire.

1:15:16 - Sabatino Rinaldi ( Pienissimo)
  C'era Daniela qua, in colla, ha detto se fosse possibile farlo a monte o senza anticipare, chissà, quando era la 360, 2, 0, erano tutti qua.  Anche io c'era. Va bene. Era all'inizio.

1:15:35 - Elena Spini (ROMI Company)
  Sì, sì. Va bene.

1:15:37 - Sabatino Rinaldi ( Pienissimo)
  Sì, io voglio tornare. Perché quello lì è una cosa che a noi in questi ultimi due anni e mezzo ci ha salvato.  È fondamentale questa cosa qua. Perché i clienti, nel 70% dei casi, quando vanno su WooCommerce a scrivere la partita IVA, scrivono le robe alla cazzo.  E poi dopo, quando noi fatturiamo... Facciamo il fattore alla cazzo, scusate, ma noi a San Marino siamo abbastanza dei contadini, quindi parliamo di come ci viene.

1:16:10 - Elena Spini (ROMI Company)
  Tranquillo, tranquillo. Se ci serve ti dico anche quando l'abbiamo detto, se può servire. Vediamo se lo trovo. Le capre.

1:16:18 - Sabatino Rinaldi ( Pienissimo)
  Sì, magari, Elena, quando l detto, così magari riprendiamo la registrazione e vediamo cosa ha detto Darmine. Io ho utilizzato lo stesso Darmine e Cabro e mi è venuto in mente.  Eh, bravo. Quindi quella lì,'integrazione è fondamentale, anche perché con quella integrazione lì si vanno a recuperare i dati delle gare a rappresentante.  E se iniziamo a far firmare i contratti con bla bla bla bla bla bla bla bla bla, non possiamo non prescindere da tutto quello ambaradano.  Grazie. Grazie. Grazie. Grazie. Grazie. Grazie. Grazie. Grazie. Grazie. Sì, facciamo l'interazione di WooCommerce, ora io diciamo. Se non per esempio è In base a quello lì è il sistema esterno proprio.

1:17:16 - Elena Spini (ROMI Company)
  Oggi mi state aggiungendo a ogni cosa mille cose. Avete aggiunto i pacchetti, l'interazione di Satisfate, quindi dobbiamo rimodularci.

1:17:29 - Sabatino Rinaldi ( Pienissimo)
  Pacchetti e Satisfate l'abbiamo sempre detto fin dall'inizio.

1:17:34 - Elena Spini (ROMI Company)
  No, i pacchetti, quello a 0 euro, eccetera, però dai, adesso si può fare. Allora, si è parlato di credit save nei documenti, meeting, demo sales del 3 giugno.

1:17:58 - Sabatino Rinaldi ( Pienissimo)
  Fabrizio ha spiegato che l'azienda...

1:18:00 - Elena Spini (ROMI Company)
  Zojoo ha un'integrazione API con CreditSafe su Zoho per recuperare automaticamente informazioni fondamentali come partita iva, ragione sociale, indirizzo della sede regale.  Questo è vero? Ce l'avete già? Certo. Su Zoho, ok. Danilo ha precisato che sebbene lo strumento permette di vedere la solidità dell'azienda, attualmente viene usato più per le certificazioni, per la certificazione della correttezza del dato.  Il mercato è licenza di valutare e semplimentare il controllo CreditSafe anche con il nuovo sistema. Per scopi di solvità creditizia.
  ACTION ITEM: Email Elena: Anticipay/CreditSafe docs + recording reference - WATCH: https://fathom.video/calls/730585136?timestamp=4740.9999  Vi mando tutto quello che mi ha dato.

1:19:15 - Andrea Di Cicco
  La chiave che viene usata è il nome dell'azienda oppure la partita IVA direttamente? La partita IVA. Però se su WooCommerce inserisce una partita IVA sbagliata?

1:19:33 - Sabatino Rinaldi ( Pienissimo)
  Secondo me se inserisce una partita IVA sbagliata abbiamo questo sistema a verificare come ce l'abbiamo osservato noi in anagrafica.  No, in realtà ci entra e poi quando abbiamo il cliente. Ah, ok. No, se la partita IVA sbagliata non vi può fare, ci mi dico cosa che c'è, non fa niente.  Perché poi da voi si blocca la fattura, quindi se vuoi poter fare il cliente. Ah, per forza. Non ti può passare un ordine se la partita IVA sbagliata.  Cioè fatturi a una... Scusate, sistema non, tipo, te sei fabrizio.piglioccelagrinso.com, non fa un match per mail, quando, dal CRM, scusa, se è su WooCommerce, uno mette una partitaiva sbagliata, ma la mail, noi ce l'abbiamo nella grafica, e dentro all'ordine.  Sì. Ok. Poi non c'è una regola che... L'ordine, l'ordine lì deve essere fatturato, ci sta. Quindi, quella cosa si fa, l'import degli ordini su McSale, se la partitaiva è sbagliata, l'ordine su McSale, l'ordine importato, si blocca.  Ah, dove lo ci sono? Però, l'ordine, prima di arrivare su McSale, dove passa? Su Zor? Su Zor, sì, sì.  E su Zor, noi, questa verifica, la regola non possiamo fare, cioè, sul CRM in generale, non si può fare.  Se vuoi bloccare l'ordine, prima che... Ma in che senso? Ho capito. Ma guarda che adesso arriva il McSale dell'ambizione.  Grazie. Ho capito? E io vorrei, che se può fare, forse CRM non lo fanno, ma un passaggio che dicevo, vedi che è arrivato sto tizio che c'ha sta mail, ma la partita arriva sbagliata, però la partita di con giusta ce l'abbiamo perché già abbiamo la mail di chiesto contatto.  No, aspetta, aspetta. Io ti parlo, cioè, noi stiamo parlando di casi in cui l'azienda non esiste su CRM. ok, ok.  In casi esistenti invece, ovviamente, viene fatto. No, no, no. Quindi se è proprio un nuovo, un livro, una persona nuova, non abbiamo l'azienda.

1:21:36 - Elena Spini (ROMI Company)
  Quindi scusate, cioè, se poi effettivamente mettono una partita IVA sbagliata su WooCommerce, cosa succede?

1:21:43 - Sabatino Rinaldi ( Pienissimo)
  Allora, se il contatto non esiste, cioè, scusami, se l'azienda non ce l'abbiamo sul CRM, entra comunque l'azienda falsa, diciamo, e poi c'è un alert da Anticipate, dicendo che appunto...  Quell'azienda non è registrata e quindi in quel caso contattiamo il cliente, perché comunque sono lasciati i dati. Per il caso in cui invece il cliente abbia sbagliato a mettere la partita IVA, ma noi già ce l'abbiamo il cliente, ci entra nell'altra azienda.

1:22:26 - Elena Spini (ROMI Company)
  E questo alert che dice che riceviamo l'Anticipate, dove lo ricevete? Nel CRM?

1:22:34 - Sabatino Rinaldi ( Pienissimo)
  Sì, è un sistema di messaggi all'interno del CRM, ma per scelta, il nostro sviluppo ce l'ha voluta mettere lì, molto bene, la vediamo subito.  Mi sa che c'era anche la rispettività di farlo per i mail. Perché probabilmente, adesso io a questo non me lo ricordo, però praticamente quando...  Anticipei gli dice guarda che io mi stai passando una partita io inesistente, e Anticipei che fa anche la maradana, però dopo Andrea ce l implementato e arrivi subito in passaggio su FIT, ma...  Questo c'è Andrea, sì sì, per me lì, non lo so, però secondo me è quello sviluppo che sarà il sistema.  stato Andrea, sì sì, e mi fa dare un'analogazione di consulenza, che è un topo su FIT, che arriva a notizia.

1:23:25 - Andrea Di Cicco
  Domanda, gestisce pure le anagrafiche estere questo sistema?

1:23:31 - Sabatino Rinaldi ( Pienissimo)
  V-converse, sì. Sì, abbiamo tanti clienti all'estero, e quando compilano il form, c'è il chip... Ah no, aspetta, mi dimmi, dici di anticipare il controllo che fa?

1:23:50 - Andrea Di Cicco
  Eh, esatto, cioè nel senso, per capire se va impostata una logica che dice che, ne so, anagrafiche estera, schippa l'integrazione per verificare se la partita io...

1:24:03 - Sabatino Rinaldi ( Pienissimo)
  Questo non me lo ricordo, bisogna sentire con Andrea, anche perché mi sa che ci sono solo le partite italiane, mi prego.

1:24:22 - Elena Spini (ROMI Company)
  Quindi il sistema comunque è anti-c-pay, non è credit safe, non c'è da niente stati space.

1:24:26 - Sabatino Rinaldi ( Pienissimo)
  Credit safe, dopo abbiamo cambiato, diventato anti-c-pay, però no, è esattamente lo stesso.

1:24:33 - Elena Spini (ROMI Company)
  Sì, che era, giusto per capire, perché mi ero segnata questo. E quindi potenzialmente vorreste questo controllo anche sul CRM, immagino.

1:24:45 - Andrea Di Cicco
  Sì, lo dobbiamo fare noi per tutto quanto, praticamente. Ogni volta che viene inserita la partita IVA, dobbiamo far scattare l'integrazione.

1:24:53 - Elena Spini (ROMI Company)
  Siete d'accordo di metterlo dopo, nella fase 2? Il controllo?

1:25:02 - Sabatino Rinaldi ( Pienissimo)
  Ah, lo mettiamo meglio. Ovvio che ci sono mille integrazioni da fare, quindi non è che mettere occhio a Mexal.  Ah, però se porti dentro un cliente del castro, capito? Toccherebbe in realtà metterlo di pari passo con Mexal, cioè con l'integrazione di Mexal insieme, perché poi vanno a braccetto.  L'informazione che arriva a Mexal deve essere condita, quindi devono essere integrate insieme, secondo me, secondo noi.

1:25:35 - Elena Spini (ROMI Company)
  Secondo me sono d'accordo, però secondo me siamo veramente un po' dilazionando i tempi e aggiungendo cose. Però, vabbè, capiamo.  Vi facciamo sapere la prossima volta su questo. Se riusciamo ad aggiungerlo, sono io felice nel dirvi tutto. E... Allora, Andrea, tu hai qualche altra domanda?

1:26:10 - Andrea Di Cicco
  No, per il momento no.
  ACTION ITEM: Request DocuSign license quote - WATCH: https://fathom.video/calls/730585136?timestamp=5209.9999

1:26:13 - Elena Spini (ROMI Company)
  Vediamo se nel mio file ho qualcosa d'altro. Allora, l'altra volta avevamo detto, già che c'è tempo, parliamo di questo, un secondo.  Tema... Ah, anzi, prima, siete riusciti a fare un passaggio per DocuSign, tema licenze? Vi hanno contattato, avete fatto la richiesta?

1:27:09 - Sabatino Rinaldi ( Pienissimo)
  No, non ancora, te la faccio entro la settimana prossima. Sì, no, era, cioè, così, giusto per capire.

1:27:18 - Elena Spini (ROMI Company)
  Sì, e poi ti aggiorno.

1:27:23 - Sabatino Rinaldi ( Pienissimo)
  Va bene. Adesso a metterci mano.

1:27:28 - Elena Spini (ROMI Company)
  Allora, in realtà, volevo farvi vedere questi due documenti, giusto per capire anche io, che l'altra volta avevo capito, cioè, non avevo aperto tutta la cartella che mi avevi mandato con tutte le varie tipologie di documenti, quindi magari me lo sono perso anche io, Però, già che lo vedo nella mia lista di punti, questo è uno e poi c'è questo.

1:28:00 - Sabatino Rinaldi ( Pienissimo)
  Elena, scusa, se non sbaglio nella minuta alla fine c'era che avremmo, c'era la vostra proposta per vedere il livello di disegnato, workflow, secondo le vostre logiche, della vendita, del processo di vendita, dei ricordi dell'opportunity, la differenza con l'idea quant'altro, e noi avevamo proposto il nostro, è detto che ci presentavate una soluzione Series Force Oriente.  C'hai ragione, ma non l'ho.

1:28:38 - Elena Spini (ROMI Company)
  Io ho detto, vado a rivedere, ridisegnare il flusso, guarda, ce l'ho entro il 7, quindi mi avvalgo della facoltà di prendere tempo, c'era la due date al 7, perché in base anche a quello, c'avevo bisogno di fare dei passaggi anche con i ragazzi.  del team, eccetera, però ce l'ho, ce non è a to-de-list da fare. Ok, grazie.

1:29:06 - Sabatino Rinaldi ( Pienissimo)
  Eh no, a voi.

1:29:09 - Elena Spini (ROMI Company)
  Questo pure in realtà era un tema che avevamo comunque, avevamo richiesto i documenti per la settimana prossima, però già che ce l'avete mandato, volevo un attimo rivederlo.  Quindi, questo, partiamo da questo, sono le condizioni generali che mandate ogni volta che viene mandato, acquisito, comprato un corso?

1:29:39 - Sabatino Rinaldi ( Pienissimo)
  Se non sbaglio, questo viene mandato insieme all'ordine preventivo, non vedete? Allora, questo qua viene mandato con l'ordine, esatto, cioè con il preventivo, chiamiamolo preventivo, quindi il tutor chiama il cliente, gli dice, guarda...  Fammi un preventivo per X biglietti, ok? E mandiamo questo. E questo sarà quello che poi deve firmare? Esatto, in fondo c'erano anche il repilogo dell'ordine, però vabbè l'ho tolto perché era di un cliente, diciamo.

1:30:27 - Elena Spini (ROMI Company)
  Quindi in realtà viene mandato questo più preventivo? Sì, vengono mandati insieme. E queste condizioni generali sono sempre uguali?

1:30:39 - Sabatino Rinaldi ( Pienissimo)
  No, il file è lo stesso, è semplicemente che io ve'ho tolto nel PDF, l'ordine. No, no, è sempre un'ordine.

1:30:47 - Elena Spini (ROMI Company)
  Queste condizioni, cioè ho capito che il preventivo è formato da condizioni generali più preventivo in sé, economico, ok? La domanda è, queste condizioni generali dei corsi valgono per tutti i corsi?  Sì, uguale per tutti. E se invece il preventivo non è sui corsi ma è solo su eventi? Forse è la stessa cosa.  Cosa? Corso o evento per noi è la stessa cosa.

1:31:23 - Sabatino Rinaldi ( Pienissimo)
  la stessa cosa, ok, perfetto.

1:31:25 - Elena Spini (ROMI Company)
  Quindi ogni volta che si manda un preventivo si manda questo più l'offerta economica, diciamo, in un documento.

1:31:31 - Sabatino Rinaldi ( Pienissimo)
  Per i corsi preventivi, sì. Poi per altri servizi eravamo rimasti martedì scorsi, martedì scusami, che ci dovevamo inviare, che lo faccio oggi e domani, le altre tipologie di moduli che vengono inviati con la piattaforma, con il servizio marketing, eccetera.

1:31:53 - Elena Spini (ROMI Company)
  Sì, su quello, anche su questo avevamo comunque una due date del sette. Io adesso ho aperto questo perché questi me li avevano...  Andati come esempi Sabatino. Poi per il resto aspettiamo la vostra. Era giusto per capire quando vengono mandati. Ok. Invece, questo è scheda di partecipazione ai corsi da firmare.  Esatto.

1:32:15 - Sabatino Rinaldi ( Pienissimo)
  Questo qua è quello che ricevono quando noi mandiamo il biglietto. Inizia a custodire proprio il biglietto e la parte di policy, la parte per entrare l'evento, la parte di privacy nell'essere firmato e fotografato all'interno dell'aula.  Ok.

1:32:41 - Elena Spini (ROMI Company)
  Con il nuovo flusso che avevamo definito. Quindi su questo, aspetta, vediamo se questo ce l'ho, ve lo posso far vedere.  Un secondo.
  ACTION ITEM: Draft digital participation form; share w/ Elena/Andrea - WATCH: https://fathom.video/calls/730585136?timestamp=5577.9999

1:33:08 - Sabatino Rinaldi ( Pienissimo)
  E poi su questa parte qui della scheda di partecipazione ai corsi da firmare, io sto lavorando proprio a una cosa per renderlo totalmente digitale, quindi se riesco ve lo faccio vedere e poi lo possiamo integrare, se non riesco, amen.

1:33:28 - Elena Spini (ROMI Company)
  Quindi questo non lo devo guardare più? Perché cambierà?

1:33:31 - Sabatino Rinaldi ( Pienissimo)
  Guardare anche più volte al giorno per ricordarlo, però se io riesco vi do questa soluzione che è molto possibile.

1:33:38 - Elena Spini (ROMI Company)
  No, ma aspetta, perché in realtà, cioè, quello che volevo capire è che in vista del flusso che abbiamo, che poi vi presentiamo, che abbiamo riscritto, no?  Che ha confermato anche Daniela, quindi che noi dobbiamo mandare prima la documentazione per il trattamento dei dati personali e serve...  La firma di dopo-sign, eccetera. E poi dopo mandiamo il biglietto. Volevo capire quali erano i documenti dei trattamenti dei dati personali.  Però forse è questo al punto 2, allegato a? È tutto, dal 2 in poi.

1:34:13 - Sabatino Rinaldi ( Pienissimo)
  Dal 2 in poi sono i documenti da filmare e in pratica l'1 diventerà invece il documento che arriverà nel momento in cui vi mandano tutto filmato.  Sì, perché l'1 è il QR code, cioè proprio per...

1:34:24 - Elena Spini (ROMI Company)
  Ok, quindi dal 2 in poi è quello che effettivamente dobbiamo mandare, che poi lui dovrà firmare su DocuSign per capire effettivamente i punti firma.  E l'1 invece è il biglietto.

1:34:39 - Sabatino Rinaldi ( Pienissimo)
  Sì, l'1 è il biglietto, che una volta che l'hanno firmato, quello lì è... possono venire tranquillamente con quello.

1:34:45 - Elena Spini (ROMI Company)
  Sì, che poi in realtà questo poi sarà da aggiungere, perché stampa l'intero documento, eccetera, non esisterà più. Ah, scatto.

1:34:52 - Sabatino Rinaldi ( Pienissimo)
  Quindi questo poi è da rivedere.

1:34:57 - Elena Spini (ROMI Company)
  Verificare la correttezza... Vabbè, in realtà... Grazie Tutto questo da vedere, ok? Conseguire documento, in che questo non sarà, mostrare il QR code, scheda di partecipazione.

1:35:12 - Sabatino Rinaldi ( Pienissimo)
  E nel frattempo, mi è venuta una domanda, mi sono ricordato di una roba, il WooCommerce, abbiamo due WooCommerce, ok?  Che in realtà svolgono funzioni un po' diverse, uno ha solo di base il libro e altre robe che facciamo noi del marketing, quando serve, mentre l'altro WooCommerce invece è proprio il WooCommerce degli eventi, delle vendite da palco, eccetera, eccetera.  Mi è venuto solo questo dubbio. E un'altra cosa che volevo chiedere, preferite che per la call di quando parleremo di WooCommerce, vi consegni già tutte le chiavi, CA, CK, CS, tutte quelle robe lì o no?

1:35:56 - Andrea Di Cicco
  Se vuoi, sì, però vediamo, capiamo un attimo... Come fare l'integrazione, nel senso... Sì, nel senso quella me la mando in un minuto.  Ok, sì, sì. Poi se ce l'hai, l'importante è capire un attimo come impostare l'integrazione, perché se noi siamo il sistema che riceve e siamo bravi, possiamo utilizzare pure le BI standard di Salesforce, che sono già predisposte e non dobbiamo fare niente, praticamente nulla.  E quindi per quello vorrei un attimo capire se riusciamo a gestire tutto tramite quelle lì. Così almeno lato nostro è costo zero e quindi significa che pure WooCommerce, diciamo, non avrebbe problemi sotto quel punto di vista, insomma.  L'integrazione. E su quello possiamo andare più veloci. Ok.

1:36:47 - Elena Spini (ROMI Company)
  La prossima riunione sarebbe martedì. Se noi riusciamo ad avere i file domani? Quelle lì, quali, dici? Quali file? Sia di Mexale.  Mexale. Allora, di WooCommerce, cosa ti serve, Andre? Ah, WooCommerce abbiamo detto che la dobbiamo proprio discutere tutta Exynos, perché tanto su quello siamo, sono liberi, no?

1:37:12 - Andrea Di Cicco
  Ho capito bene.

1:37:13 - Elena Spini (ROMI Company)
  poi effettivamente, cioè, possiamo già discutere di tutto martedì.

1:37:18 - Sabatino Rinaldi ( Pienissimo)
  Domani ti mandiamo quei file, gli 8 file di Fabrizio, più la documentazione API, in un modo o nell'altro le recuperiamo.  Per me li possiamo mandare anche... Ah beh, sì, oggi domani, dai. E inizia, invece, ti manda gli altri moduli, quelli lì, che mandiamo insieme ai preventivi, quello che ci hai fatto vedere prima.  Documenti forniti dai clienti, li è quello lì.

1:37:47 - Elena Spini (ROMI Company)
  Perfetto, quindi per la prossima riunione direi di fare così. Svisceriamo eventuali dubbi, perplessità, emersi a fronte dei temi di integrazione e a fronte dell'analisi.  I dati e documentazione che ci date e poi rivediamo il giro, come appunto dicevamo prima, del tema delle opportunity, lead opportunity, eccetera, che visto l'altra volta in ottica Salesforce.  Quando questo?

1:38:16 - Sabatino Rinaldi ( Pienissimo)
  Martedì. Martedì, pomeriggio avevamo detto. Sì, giovedì, sei quasi, è il prossimo? Io torno in quindici a lavorare, quindi andiamo a vedere che io ci sono, direi che il primo giorno, la prima data utile, si daranno martedì e mercoledì e giovedì sedici.  Sì, sì, è un po'. Sennò guardate voi, o se no provo a collegarmi, io ci provo e poi vediamo questo viene fuori, mi collegano dal telefonino, dove sarò.  Poi ci vediamo alla fine, così non possiamo stare a tutto. Sì, magari, magari al fine... Va bene, su quello ci sentiamo, ci sentiamo in live, ti mando messaggio.  Esatto, così riesci, ma di base abbiamo la registrazione, della riunione che facciamo ancora ora, abbiamo la registrazione. Magari intercettiamo delle cose, perché il concetto era che nella minuta, Elena, che ci hai mandato, su questo aspetto qua, c'era l'indicazione che è come se noi avessimo già deciso di seguire comunque la vostra soluzione.  Noi in realtà prima vogliamo vedere che cosa ci proponete per capire quanto dovremmo modificare di quello che in questo momento stiamo mettendo in piedi.  Per la parte, dici, dell'altra volta di Lead Opportunity?

1:39:45 - Elena Spini (ROMI Company)
  Sì, esatto, esatto. Va bene.

1:39:48 - Sabatino Rinaldi ( Pienissimo)
  È chiaro, la logica Salesforce è personalmente condivisibile, però prima di chiaramente poi ci sarà anche un coinvolgimento di Daniela sotto questo aspetto.  Va bene, su quello ci sentiamo, ci sentiamo in live, ti mando messaggio. Esatto, così riesci, ma di base abbiamo la registrazione, della riunione che facciamo ancora ora, abbiamo la registrazione.

1:40:15 - Elena Spini (ROMI Company)
  Magari intercettiamo delle cose, perché il concetto era che nella minuta, Elena, che ci hai mandato, su questo aspetto qua, c'era l'indicazione che è come se noi avessimo già deciso di seguire comunque la vostra soluzione.  Noi in realtà prima vogliamo vedere che cosa ci proponete per capire quanto dovremmo modificare di quello che in questo momento stiamo mettendo in piedi.  Per la parte, dici, dell'altra volta di Lead Opportunity? Sì, esatto, esatto. Va bene. È chiaro, la logica Salesforce è personalmente condivisibile, però prima di chiaramente poi ci sarà anche un coinvolgimento di Daniela sotto questo aspetto.
  ACTION ITEM: Ask Daniela to join Tue call - WATCH: https://fathom.video/calls/730585136?timestamp=6049.9999  Poi l'ultima parola, chiaramente, della direzione. Ma infatti, lunedì che c'è Daniela qui, magari le chiedo proprio di partecipare anche le martedì, in modo tale che così abbiamo un punto fermo su questa storia.  Sì, perché noi vi facciamo la proposta e se qualcosa non va, considerate che per traguardare un po' gli obiettivi che ci siamo detti, quindi, settimana prossima io vorrei avere il quadro chiaro di cosa effettivamente andrà fatto e configurato, anche perché poi la settimana ancora successiva scriverò il documento che poi vi condivido e poi dovrete confermare e accettare e poi si parte.
  ACTION ITEM: Prepare data model Excel for Tue call; then collect field lists from Sabatino/Fabrizio - WATCH: https://fathom.video/calls/730585136?timestamp=6109.9999  Quindi su questi sono temi che dobbiamo sicuramente definire, mettere un punto, ecco. Però discutiamone, sì, sì, assolutamente. E lo facciamo martedì.

1:41:55 - Sabatino Rinaldi ( Pienissimo)
  Quindi martedì questo, più integrazione.

1:42:00 - Elena Spini (ROMI Company)
  E poi martedì vorrei iniziare, se riusciamo, a parlarvi anche del data model, che sarà quell'Excel diviso per diversi sheet, così come queste vendita palco, vendita tutor, per ogni oggetto, Salesforce, in cui voi dovrete andare a darci poi l'indicazione dei vostri campi, delle vostre regole, più che altro campi, per poi andare a costruire effettivamente quello che sarà il CRM.  Ad esempio, la scheda, non so, dell'anagrafica deve avere questi campi. La scheda del contatto deve avere questi campi. Potete semplicemente estrarli, fare un'estrazione da quello che avete nelle SIS su ZOO e fare scrematura, se effettivamente vi siete accorti che magari dei campi non vi interessano, non li usate più.

1:42:54 - Sabatino Rinaldi ( Pienissimo)
  Chiaro. Ok.

1:43:01 - Elena Spini (ROMI Company)
  Io penso di avere finito.

1:43:09 - Sabatino Rinaldi ( Pienissimo)
  Andiamo a mangiare prima. Quindi ti mandiamo tutta questa roba.

1:43:14 - Elena Spini (ROMI Company)
  Io mando sempre la minuta come al solito, così vi ricordo tutto.

1:43:20 - Sabatino Rinaldi ( Pienissimo)
  Scusi, in martedì guardiamo integrazione WooCommerce, vediamo.

1:43:25 - Andrea Di Cicco
  In realtà si chiama integrazione WooCommerce, ma noi ne abbiamo già comunque parlato.

1:43:29 - Elena Spini (ROMI Company)
  Noi facciamo le nostre, diciamo, riflessioni, facciamo sapere cosa effettivamente ci serve e tutto, ma parliamo, direi, macro-argomenti.

1:43:52 - Andrea Di Cicco
  Va bene. Questi sono i due temi. Magari aggiorno anche il focus del meeting, così. Cioè, oggi l'abbiamo detto, poi magari settimana prossima diciamo, ah, cosa dobbiamo parlare?  E ce lo dimentichiamo. No, ma io ho tutto segnato, scritto, che è già... C'è tanta roba. Sì. Sì, aggiorno io, aggiorno io.  Quindi vi arriverà la mail del giornamento. Va bene, grazie. Ok. Bene, direi che ci possiamo vedere martedì. Perfetto. Grazie.  Non riposateli troppo, ma... Non c'è il rischio, mi sa. Ciao a tutti, buon appetito. Ciao, ciao, ciao, ciao, ciao.