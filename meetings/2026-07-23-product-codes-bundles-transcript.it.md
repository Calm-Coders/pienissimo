[ROMI-PIENISSIMO] - Check Codici Prodotto - July 23
VIEW RECORDING - 45 mins (No highlights): https://fathom.video/share/m3e3vvzF4i-1wKCYVVmB67z5wgUs6k4v

---

0:00 - Aurel mrruku (ROMI Company)
Per capire meglio il file che mi hai mandato. Alcune cose sono intuitive, ma volevo capire un po' più le sette livelli, praticamente. Sto cercando di capire che legami ci sono tra i livelli, perché li vedo i dati, per esempio, vedo dei prodotti che sono censiti su diversi livelli. Più o meno ho fatto un'idea, ma forse è meglio che mi spieghi un attimo.

0:31 - Fabrizio Paganelli
Sì, allora, ti anticipo subito. I sette livelli in realtà sono il retaggio di tutta una serie di epoche storiche, quindi alcuni francamente non li utilizziamo più. Come ti dicevo nella mail di ieri, guarda principalmente il livello 0 e il livello 6, che poi è quello che ho utilizzato.

1:00 - Aurel mrruku (ROMI Company)
Ok, facciamo, non so se vedi il mio schermo? Sì, lo vedo piccolo, ma lui aspetta che faccia un po' di zoom. Allora, poi ho notato una cosa molto strana, sulla prima colonna, c'è Elena, ciao Elena. Ciao, scusatevi partito senza aspettare, chiedo scusa. No, no, hai fatto bene, hai fatto bene.

1:31 - Elena Spini
Io ho molto stracchi, ma tanto sei tu quello che devi ascoltare di più.

1:36 - Aurel mrruku (ROMI Company)
Perfetto, ho messo anche la registrazione. Bravo, grazie Aurel. Allora, ho notato che nella prima colonna ci sono tre tipologie, A, Z, se mi sbaglio è la C o la P? Sì. La C. Ho notato che la Z e la C, Sono bundle, tipo pacchetti, o almeno così li ho interpretati io. Esattamente. Quindi, ok, e che differenza c'è tra la tipologia del bundle Z e la tipologia del bundle C? Ho visto anche la nomenclatura, qua è BLEO, invece dall'altra parte era PC qualcosa, package se mi sbaglio, aspetta che era pack.

2:33 - Fabrizio Paganelli
Sì, diciamo che quella lì è un'infrastruttura che mi spiegavano le persone con cui ho parlato, che è stata costruita principalmente per le imprese fashion, campionari, cose varie. Noi ce la siamo un pochino adattata, però quella lì è l'infrastruttura con cui noi... Facciamo il bundle su Mexal, quindi ad esempio c'è quelli che sono i codici articolo che iniziano per pack, che mi sembra che sia C se non ricordo male.

3:17 - Aurel mrruku (ROMI Company)
Sì, ma praticamente il dubbio mio era che ho visto pack con CK finale, come qua, ma anche pack PAK.

3:31 - Fabrizio Paganelli
Ma quello è semplicemente un codice, ci potevo scrivere anche Pippo e Pluto, non cambiava niente. Quello è un codice, quello è il codice articolo, la seconda colonna è il codice articolo.

3:42 - Aurel mrruku (ROMI Company)
Ok, quindi il codice articolo è semplicemente qualcosa di univoco che usate per codificare il record. Invece la C sta dicendo che è un bundle e la Z è un bundle. Invece A sono altri prodotti, tutti gli altri prodotti.

4:04 - Fabrizio Paganelli
Sì, la C è il pacchetto, il bundle, poi dove c'è la Z diciamo che sarebbe la rata, giusto per avere il parallelo rispetto a quello che ci dicevamo ieri.

4:21 - Aurel mrruku (ROMI Company)
Ok, quindi un pacchetto in qualche modo legato ai prodotti che sono nel bundle?

4:33 - Fabrizio Paganelli
Allora, diciamo che tutto questo, in questa infrastruttura qui, se diciamo il sistema su Salesforce girerà come abbiamo detto ieri, non abbiamo più bisogno di farli, noi non avremo più bisogno di fare i C, i Z, i blocchi e i pack su Mexal. Però, giusto per capire, noi quando dovevamo creare i bundle su Mexal, cosa facevamo? Creavamo prima il codice articolo che inizia per blo, quindi artip z, codice articolo, quello che inizia per blo trattino. Creavamo quel codice articolo lì. Quello lì è un codice articolo che ha un prezzo di listino, nella quarta colonna, ha un prezzo di listino. Bene, e quelle lì sono le rate del bundle. Quando noi avevamo creato tutte le rate che dovevano essere comprese in un bundle, a quel punto andavamo a creare il bundle. Il bundle è quello che ha l'artip che inizia per C, e codice articolo che inizia per P-A-C-K. Nel momento in cui su Mexal si crea il bundle, bisogna associare sia i blocchi, ossia i codici articolo che iniziano per blo, ma anche tutti gli articoli che sono componenti di quel blocco barra rata. Ma sono tutti articoli che hanno prezzo. 0.

6:00 - Aurel mrruku (ROMI Company)
Quindi diciamo che… Perché io praticamente l'ho letto in questo modo, fatto anche un esempio qua grafico. Allora, sul Performance Plus Pack Tour 2025, che è Pack 88, ha un valore, che è praticamente un bundle, e questo valore viene suddiviso in 12 rate. Quindi così l'ho interpretato io. E mi è sembrato una cosa molto sensata. Volevo capire che voi, tecnicamente, adesso, non avete il censimento del prodotto nella rata. Avete solo il prezzo della rata, quindi il valore della rata. Quindi avete un bundle di rate, diciamo. Ovviamente poi il bundle dall'altra parte di riferimento coi prodotti l'avete su un'altra struttura.

7:00 - Fabrizio Paganelli
In realtà noi quando facciamo l'ordine e quando facciamo la fattura, all'interno delle righe ordine, della riga fattura, c'è anche il singolo codice articolo che fa parte di quella rata, però non è valorizzato, perché tecnicamente Maxal non ti permette di valorizzarlo, Maxal ti permette di valorizzare soltanto il codice articolo che inizia per Blu. Quindi che cosa abbiamo dovuto fare? Per far capire al cliente che cosa gli stavamo fatturando, abbiamo messo dentro una lista di codice articolo, ma che sono codice articoli omaggio, che hanno valore zero. Io guarda, se vuoi ti condivido il mio schermo, giusto per far capire meglio.

7:42 - Elena Spini
Ma Fabrizio, scusa, dato che adesso stiamo vedendo poi a quello che sarà il 2B, la gestione della logica con i blocchi, non so se ne avete avuto modo di parlare con Daniela, si farà? Grazie. Grazie. Continuerà ad essere?

8:01 - Fabrizio Paganelli
L'abbiamo detto ieri, si fattura, noi creeremo, si fattura la riga, però adesso sto vedendo di nuovo, bloc, bloc, bloc, ripeto, ripeto, io vi ho dato tutta l'anagrafica prodotto, poi vi ho detto, non guardate l'anagrafica completa, guardate solo l'estratto che vi ho fatto, perché nell'anagrafica completa c'è tutta una valanga di roba, che ad oggi non ha più nessun senso, codici articoli vecchi, i blocchi e i PEC come li avevamo codificati quella volta, eccetera, eccetera, i blocchi abbiamo detto che faremo come abbiamo detto nella riunione di ieri.

8:46 - Aurel mrruku (ROMI Company)
È chiaro, volevo giusto capire il legame, perché volevo anche prima capire tutto il processo, io ho guardato i tab significativi e ci sono, volevo solo capire se c'era... Qualcosa che mi stava sfuggendo. Volevo anche capire qual era il modello usato fino adesso.

9:07 - Fabrizio Paganelli
Io guarda, giusto per conoscenza vi faccio vedere, guarda, vi condivido lo schermo, se ce la faccio, condividi, schermo. Allora, se io vado qua, mi vedete? Sì. Allora, qua, nell'anagrafico articoli, se io cerco i pack, questo qui era il bundle, andiamo a uno degli ultimi. Oppure prendiamo anche quello che mi avevi fatto vedere tu, il 78, mi sembra che fosse.

9:47 - Aurel mrruku (ROMI Company)
Sì, sì.

9:50 - Fabrizio Paganelli
Vedi, questo qui è come è configurato il pack e qua, in questa parte qua, ci sono i componenti del pacchetto. Quindi io questo qui ho il codice articolo PEC 78 che è tipologia campionario, qua su vedete, che è composto da un codice articolo BLO che è di tipo prestazione Z, quantità 1, qui vedi che non abbiamo la possibilità di mettere il prezzo perché prende in fattura il prezzo di listino di questo qua. E poi abbiamo questo CSV 002 che praticamente è l'articolo, l'item che è contenuto all'interno di questo blocco che però è valorizzato a zero, adesso qui non si vede. Quindi questo qui è il blocco 225 quindi è la prima rata, poi c'è il blocco 226 la seconda rata che ha dentro lo stesso item che aveva quello precedente, vedete? Se io vado, vado qua, provo a inserire un ordine.

11:01 - Aurel mrruku (ROMI Company)
Uscerà proprio il prodotto quando metti l'ordine, naturalmente, vero? Sì, sì, sì.

11:08 - Fabrizio Paganelli
Allora, tipo documento, OC, nuovo. Vedete, mi esplode tutto così. È chiarissimo, è tutto chiaro. Dopo, magari possiamo, guarda, possiamo giusto per, adesso questo qui era un caso di, come si dice, di un blocco un particolare. Allora, se noi prendiamo, per esempio, uno di quelli che proponiamo, Durante gli eventi, prendiamo uno degli ultimi, ecco tipo questo qui, l'anno compienissimo, 1, ecco vedete, blocco 1 sarebbe la prima rata in fase di accontro, 900 euro, e poi tutto quello che compone questo primo blocco, blocco 2, la seconda rata, e poi tutti i singoli articoli che compongono la seconda rata, e così via, fino alla concorrenza del valore completo.

12:31 - Aurel mrruku (ROMI Company)
Invece su Salesforce praticamente avrai praticamente la data, il prodotto, col prezzo per quel bundle e la data, che la data serve praticamente il blocco. Esatto. Ok, ok, perfetto. Per me è tutto chiaro, penso che ho tutte le informazioni necessarie almeno per iniziare anche a metter in piedi su Salesforce dei bundle con dei prodotti già. Sì.

13:01 - Elena Spini
Giusto per risicurezza, quindi ci stiamo dicendo che i blocchi non ci saranno più perché quello che sarà una volta che si esploderà il bundle saranno le righe direttamente dai prodotti con indicazione di data e poi ieri abbiamo detto che raggruppiamo noi in base alla data per rata. Esatto.

13:24 - Aurel mrruku (ROMI Company)
Tanto per intenderci.

13:27 - Fabrizio Paganelli
Questo non c'è, questo non c'è, questo non c'è, questo non c'è, ci saranno questi. Qualcuno ci chiede ma non ci sono più.

13:37 - Elena Spini
Giusto per super estremamente.

13:39 - Fabrizio Paganelli
dopo questo qui, quando voi elaborerete il documento di progetto, questa parte qui la mettiamo evidenziata in giallo fosforescente, nero su bianco, con dei bordi, con dei bordi spessi, 15 centimetri di giallo fluorescente. Ultimo totale. Si dovrà mettere il timbro su quel documento di progetto, avrà perfettamente evidente che poi dopo noi, quando fattureremo, non ci saranno più i blocchi, perché così era stato chiesto, ma saranno visualizzati al cliente solo questi codici articolo qui, però chiaramente valorizzati con prezzi, i dati, tutto quello che abbiamo detto.

14:25 - Elena Spini
Ottimo, perfetto, particolare amicizia lunga, ci siamo.

14:31 - Fabrizio Paganelli
Dopo, io sono sicuro che verrà il momento che cambieremo idea, lo sono sicuro, perché ormai… No, non dirlo che poi dopo sia vera, già mi avete sconvolto ieri, a me e ad Aurel, con DocuSign. Ah, per i DocuSign, ah sì sì.

14:49 - Elena Spini
Eh, ma anche perché… Sì sì, stiamo andando avanti. No. Vabbè, dai, fa niente.

14:58 - Fabrizio Paganelli
Lì, lì, non è… Per lavarmi nelle mani, però diciamo che è un elemento che non ho, che non ho, non abbiamo il pallino nelle mani, com'è che si dice? Lo so, boh, vabbè, ho capito però.

15:16 - Aurel mrruku (ROMI Company)
Allora, io l'Excel ce l'ho, i 200 e qualcosa erano elementi ce li ho, prova a metterli su Salesforce e forse tra una settimana, quando sarà il prossimo incontro, vi faccio proprio vedere un esempio di bundle, non con i prezzi e tutto, perché ancora ci sto lavorando sulla parte dei prezzi, sì, ma non le date, come si chiama? Le rate, rate, non le rate, quindi metto solo il bundle per il momento e poi forse verso, vabbè, siamo già ad agosto, verso fine agosto. Io mi fermerò un paio di settimane a metà agosto. Vi farò anche vedere come si fa il pacchetto, il bundle, con le rate e i prezzi sui elementi del bundle. Ok.

16:22 - Fabrizio Paganelli
Una domanda che però ve la rifaccio, ma mi pare che me l'avevate già detto. Noi quando creeremo il bundle abbiamo diverse opzioni, giusto? Ossia, i 9.800, supponiamo che il bundle abbia valore di 9.800, i 9.800 li possiamo riproporzionare in automatico e poi le rate, oppure è tutto a mano? Va bene comunque, sì. Io ho dato tutte e due le possibilità perché non sapevo il desiderato.

16:52 - Aurel mrruku (ROMI Company)
Ho messo un prezzo di bundle e un prezzo che si autocalcola dai elementi. Menti del bundle. Ok. Ovviamente poi anche sulle rate in qualche modo dovete metterla a mano se tu metti il prezzo del bundle.

17:09 - Fabrizio Paganelli
Vi chiedo scusa che sto ricevendo una telefonata a cui devo assolutamente rispondere, solo due minuti, scusatemi.

23:00 - Elena Spini
Aurel, scusa, io mi devo staccare, sei in muto, però penso che è Ok, no problem, ciao, ciao, grazie.

24:40 - Fabrizio Paganelli
Eccomi, scusate. Elena ha dovuto staccare.

24:47 - Aurel mrruku (ROMI Company)
Poi stavo discutendo un attimo sulle tipologie di bundle, praticamente come categorizzare i bundle. Riesci a dirmi?

25:02 - Fabrizio Paganelli
Sì, guarda, te lo faccio vedere da qua, giusto per allora, noi qua, quando facciamo, andiamo direttamente, anzi faccio così, guarda, vado su questo, allora questo lo sposto, qui abbiamo livello 4, se non ricordo male, ecco, è anche livello 3, vado a memoria, esatto. Allora, qui facciamo così, così è un pochino più chiara, mettiamo come filtro nell'articolo. Facciamo la sua descrizione, se no col codice per scatole, niente, così piaccicappa, trattino.

26:22 - Aurel mrruku (ROMI Company)
A livello 4 abbiamo il tipo di pacchetto, vero?

26:31 - Fabrizio Paganelli
Ok, allora nel livello 4, esatto, c'è il tipo di pacchetto, noi normalmente come tipo di pacchetto abbiamo l'anno compienissimo, l'anno compienissimo ripetente, potremmo avere un anno con la performance plus. Io vedo tre praticamente. Sì, perché quello con la performance plus non lo abbiamo mai codificato, diciamo, ad oggi, però ecco, sono questi due. E quelli fondamentali. Hanno con pienissimo, hanno con pienissimo ripetente. Oppure dopo ci sono degli altri pacchetti dove ci sono dei corsi misti che non hanno proprio un'identità. Alla direzione interessa l'anno con pienissimo perché praticamente è quando il cliente si iscrive ai nostri corsi per un intero anno accademico. E poi dopo quello che ci serve è capire qual è l'evento nel quale quel pacchetto è stato proposto. Quindi noi abbiamo i vari corsi, quindi Academy 23, 24, 25, Food Marketing Festival 22, 23, 24, 25. In ogni evento possiamo proporre in vendita più pacchetti e quindi, guarda, facciamo così, ti metto anche questo qui. Quindi, vedi, nell'Academy 24 abbiamo proposto in vendita quattro pacchetti, cinque pacchetti, di cui due all'anno con pienissimo erano leggermente diversi e due all'anno con pienissimo ripetente. Nell'Academy 26 ne abbiamo proposti in vendita 6, erano tutti...

28:07 - Aurel mrruku (ROMI Company)
Ok, quindi quando fai il pacchetto tu devi prima categorizzare in base all'anno.

28:16 - Fabrizio Paganelli
Io devo categorizzare in base a qual è l'evento nel quale propongo quel pacchetto, che sarebbe questo.

28:26 - Aurel mrruku (ROMI Company)
Ma l'evento intendo, ce l'hai sempre a livello 3 con l'informazione? Sì. Però vedo che sul livello 3 abbiamo 42 record. In che senso? 42 record diversi, quindi 42 possibilità di scelta.

28:50 - Fabrizio Paganelli
Sì, perché poi dopo vedi, ci sono tutte queste cose qua più particolari, promo, starter pack, rottamazione, SIGEP, OSCE. Superofferta e anche cose vecchie. Diciamo che noi tendenzialmente i corsi, quelli grossi, dove noi categorizzeremo sono Academy, ODB, Sold Out, Camerieri Venditori, Pienissimo Live, Food Marketing Festival e Mastery. Diciamo che abbiamo 7 eventi importanti all'anno, quindi noi avremo… A voi interessa, ok ho capito, ma riesci a darmi la lista così?

29:36 - Aurel mrruku (ROMI Company)
queste 7 scelte li faccio con una pick list, nel momento in cui te crei il pacchetto, devi per forza selezionare uno di questi eventi.

29:48 - Fabrizio Paganelli
Però dopo io quelli lì ho bisogno che tutti gli anni di crearne di nuovi. Puoi aggiungere dei valori in più.

29:54 - Aurel mrruku (ROMI Company)
Ok. Aggiungere, disabilitare i valori in più. Ok.

30:00 - Fabrizio Paganelli
Allora guarda, vuoi che te li scriva? Se riesci è ancora meglio.

30:05 - Aurel mrruku (ROMI Company)
Faccio così, apro la posta, così lo facciamo direttamente insieme.

30:13 - Fabrizio Paganelli
Allora.

30:18 - Aurel mrruku (ROMI Company)
Io devo prevedere un campo evento, un campo tipo di pacchetto. Esatto. E anche l'anno penso, vero? Oppure l'evento, no, l'evento non ha l'anno.

30:34 - Fabrizio Paganelli
Di solito io faccio così, facciamo così, Academy, Academy 2025 e poi dove avrò dentro tutti i pacchetti che verranno venduti all'Academy 2025 e poi possiamo fare Academy 2026 dove metterò dentro tutti i pacchetti che venderemo all'Academy 2026 e così via. Quindi c'è l'academy, camerieri, partiamo da questo, food, ma allora.

31:09 - Aurel mrruku (ROMI Company)
Ti posso chiedere, lascia l'academy, le due academy lasciali proprio all'inizio, poi, ok, perfetto.

31:25 - Fabrizio Paganelli
Tour, Food Marketing Festival, c'è Pienissimo, live.

31:38 - Aurel mrruku (ROMI Company)
Ma le academy non sono nella stessa lista, sono un altro campo. L'academy, diciamo, è l'anno in cui tu stai creando quel pacchetto, invece Tour, Food Marketing Festival, Pienissimo, sono gli eventi che tu vendi in quell'anno. No, no.

32:01 - Fabrizio Paganelli
Allora, il nostro anno, cerco di ridirlo, guarda, questo lo tolgo. Il nostro anno accademico inizia quando facciamo il tour, poi dopo il tour c'è il Food Marketing Festival, il Pienissimo Live. Dopo il Pienissimo Live c'è l'Academy, poi c'è il Sold Out, c'è il Sold Out, c'è l'ODB Live, poi c'è Camerieri e Venditori, Happy Team, c'è Happy Team, ma durante l'Happy Team non vendiamo niente, e c'è la Mastery. Questi qui sono tutti gli eventi che sono all'interno di un anno accademico. Ok, chiaro. Quando io vado a creare i bundle che saranno venduti... All tour, quei bundle li metterò, li classificherò tour 2025. Quando poi l'anno successivo...

33:12 - Aurel mrruku (ROMI Company)
Non c'è neanche bisogno, perché ti dico che su Salesforce tu puoi fare delle picklist con delle dipendenze. Cosa vuol dire? Tu dai la possibilità di scegliere anno 2025 e poi in un altro campo vedrai solo gli eventi associati al 2025. Per questo ti ho detto, io vedo tutto all'interno dell'anno. Però ci siamo, stiamo dicendo la stessa cosa, solo che... Perfetto. Quindi se mi scrivi anno, perché io prendo...

33:45 - Fabrizio Paganelli
Campo evento, anno accademico, campo evento, anno accademico, non so come metterlo.

33:54 - Aurel mrruku (ROMI Company)
All'inizio, prima del campo evento, diciamo, anno accademico, campo anno... Accademico che è il master del campo evento. Metti un esempio poi. Master del campo evento. Cosa vuol dire? Master vuol dire che è l'anno accademico che ha sotto insieme dei eventi.

34:24 - Fabrizio Paganelli
Quindi io quando andrò a creare un pack gli dirò anno accademico 2025.

34:28 - Aurel mrruku (ROMI Company)
E ti darà la possibilità di selezionare solo i campi che sono associati a quell'anno accademico. Ma questo vuol dire che te ogni anno devi creare questo studio insieme a mano. Lo sai, lo fai così dentro.

34:46 - Fabrizio Paganelli
Ok. Quindi anno accademico, campo evento e poi tipologia di bundle.

34:56 - Aurel mrruku (ROMI Company)
E la tipologia di bundle ha a che fare con l'evento? No.

35:02 - Fabrizio Paganelli
Io in ciascuno di questi eventi posso dire che venderò un anno con Pienissimo, potrei vendere l'anno con Pienissimo ripetente, oppure altro. E non ha un anno a che fa neanche con l'anno accademico?

35:24 - Aurel mrruku (ROMI Company)
No. Ok, perfetto.

35:25 - Fabrizio Paganelli
Perché io durante il food marketing posso fare l'anno con Pienissimo, come non farlo? Magari decido di farlo un anno al Pienissimo live, un anno sì, un anno no. È una cosa che sono completamente slegati. Mentre in un determinato anno io, a meno che non sospendiamo degli eventi, vengono fatti tutti questi eventi, i bundle possono essere proposti. Poi altro, magari ci inventeremo qualche cosa qua, non si sa.

35:55 - Aurel mrruku (ROMI Company)
Sarà molto facile aggiungere altri valori, non ho un problema. Quindi in due minuti, una... Admini non devi fare nessun rilascio, niente.

36:02 - Fabrizio Paganelli
La stessa cosa qui, bla bla bla bla, ci potrebbero essere… Però il problema sarà quando… Problema?

36:10 - Aurel mrruku (ROMI Company)
La difficoltà o il lavoro sarà, quando tu crei l'anno accademico, per forza devi creare il sottoinsieme dei eventi che vanno sotto quell'anno accademico, altrimenti tu non avrai nessun evento se non li metti a mano, questa è l'idea. Ok, ok. Ok, perfetto allora.

36:28 - Fabrizio Paganelli
Dopo noi l'anno accademico, l'anno accademico per noi va da settembre a maggio.

36:42 - Aurel mrruku (ROMI Company)
Tecnicamente… Funziona così. A me interessa poco a livello di bundle, perché tu avrai proprio un valore all'anno accademico che scriverei quello che vuoi te e lo selezioni, quel valore, non è che ho una misura… Grazie. del tempo, se sei, diciamo, se questo inizia, finisce a maggio, se tu sei a giugno e scegli l'anno accademico, io non faccio nessun controllo che tu sei a giugno e stai scegliendo un anno accademico vecchio, non so se hai mai capito. Sì, sì. Che fa questi mandi deve fare attenzione, altrimenti non ho modo per...

37:26 - Fabrizio Paganelli
Perché, no, più che altro, perché poi dopo noi l'anno accademico, qui io più che anno accademico farei anno solare. Ok. Io più che anno accademico farei anno solare, perché l'anno accademico per noi è un concetto un po' diverso, un concetto che va da maggio a settembre e l'anno accademico lo utilizziamo come campo per la generazione dei biglietti. Quindi non vorrei che mettendo qui nei bundle il discorso... So dell'anno accademico andiamo a fare confusione perché sono due concetti diversi.

38:03 - Aurel mrruku (ROMI Company)
Chiaro, chiarissimo. Così va bene come ti ho scritto. Va benissimo. Te l'invio, te l'invio. Ok. Perfetto. Grazie mille, ho abbastanza informazione per iniziare a fare degli esempi concreti.

38:20 - Fabrizio Paganelli
Dopo io una cosa vi volevo dire, se hai un altro minuto che ha a che fare con questa, ecco qua, vi volevo specificare questo, l'avrete già notato, ogni evento, in ogni evento ci possono essere più tipologie di biglietti, quindi questo qui è il biglietto, ad esempio nell'accademy c'è il biglietto a pagamento, possiamo dare dei biglietti omaggio, oppure i clienti possono comprare dei biglietti, hanno già comprato un pacchetto, vogliono far partecipare ad esempio un collaboratore in più e quindi c'è un biglietto aggiuntivo. Queste qui sono tutte cose che, diciamo, dopo impatteranno il livello di generazione dei biglietti, però immagino che questo argomento lo possiamo… In teoria sono prodotti diversi, vero?

39:12 - Aurel mrruku (ROMI Company)
Sì. Quindi nel momento in cui fai il bundle, selezioni il prodotto desiderato, in automatico avrai l'informazione dell'articolo là.

39:22 - Fabrizio Paganelli
Sì, però quello che volevo dire, a prescindere dal bundle, oppure dal fatto che il prodotto sia dentro un bundle, oppure dal fatto che il prodotto venga venduto direttamente dal tutor, o venga comprato direttamente dal cliente sul sito, sono questi quattro codici articolo che devono generare un biglietto.

39:44 - Aurel mrruku (ROMI Company)
No, chiaro, poi sulla generazione del biglietto, allora, importante è capire che è un evento che genera un biglietto, poi se la tipologia dell'articolo non è… Non unico, noi facciamo un insieme di articoli che possono generare un biglietto. Spero che questi articoli, questi codici, non è che li cambiate, vero? Sono unici. Ok, rimarranno così, perché poi devi codificare ogni volta, anche a livello di codice, quali sono gli articoli che generano il biglietto. Forse facciamo una tabella, così lo manteniamo anche a livello di amministratore, di sistema, così non dobbiamo ritoccare il codice ogni volta che voi volete aggiungere o togliere un articolo dall'insieme di articoli che devono generare un biglietto.

40:43 - Fabrizio Paganelli
E' quello che dicevamo un'altra volta, che se nell'anagrafico articoli, quando la importeremo su Salesforce, voi potete aggiungere un flag genera biglietto sì o no, avevamo detto, era genera biglietto sì o no, ce n'era un altro, era l'altra cosa che era.

41:04 - Aurel mrruku (ROMI Company)
E sta cosa lo facciamo a livello di codice dell'articolo. Ti dico già che lo puoi mantenere come sistema admin, lo puoi abilitare, disabilitare senza l'intervento di un sviluppatore. Faremo in modo che te, quando entri sul sistema, un giorno decidi di non vendere più questo come biglietto.

41:35 - Fabrizio Paganelli
Ok, va bene. Dopo, ecco, tu dicevi, ne creerete altri? Io ho detto no. Effettivamente la creazione dei codici articolo è una cosa abbastanza rara. Non li cambiamo molto spesso, i codici articolo. Quando metteremo Salesforce, io dovrò creare dei codici articolo, uno per ogni evento, quindi Academy. Sono per i camerieri venditori, eccetera, eccetera, che noi dovremmo utilizzare solo ed esclusivamente nei bundle. Quindi io dovrò avere un altro codice Academy, che magari tra parentesi gli metto B, per capire bundle, che quello lì potrà essere utilizzato solo ed esclusivamente nei bundle. E non lo possono usare i tutor quando fanno una vendita diretta, perché il tema è legato al calcolo delle provisioni, perché sostanzialmente le vendite dei bundle, gli agenti non percepiscono le provisioni sulle vendite dei bundle.

42:41 - Aurel mrruku (ROMI Company)
Chiaro, ma invece di farmi, vabbè, fai il codice, poi ne dobbiamo parlare, perché non mi serve solo, per me è molto difficile andare a leggere una lettera sul, è meglio se ho un flag a livello di prodotto. Sì, sì, va bene.

43:00 - Fabrizio Paganelli
Va bene, sì sì, io farò Academy, tra parentesi, B, che lo flaggerò come da utilizzare solo nei bundle.

43:07 - Aurel mrruku (ROMI Company)
Corretto.

43:09 - Fabrizio Paganelli
Sì, faremo così, però ecco, dovrò creare altri 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, altri 10 codici articoli oltre a questi.

43:22 - Aurel mrruku (ROMI Company)
Riesci già a metterti avanti, perché mi serviranno, penso, prima di settembre questi codici articolo. Io già metterò, ho almeno anche 5 esempi, 3 esempi, giusto per iniziare a lavorare a livello di codice nel momento in cui si fa la selezione.

43:47 - Fabrizio Paganelli
E me lo segno, te li faccio per domani. Non c'è così tanta fretta, ma serve. Più che altro lo sai qual è il tema, anche se adesso io creo dei codici articolo. Non ho modo di renderli invisibili su sito, e quindi dopo va a finire che me li usano. No, fa niente, creo un esempio, dammi un esempio Fasulo io e mi faccio… Te ad esempio qui te ne puoi creare uno anche a caso, che lo chiami CS9914, capito?

44:24 - Aurel mrruku (ROMI Company)
Chiaro, aggiungo io direttamente su Salesforce allora il flag, e poi ti dico come ho fatto, cosa devi fare te per avere la stessa struttura che farò io sul coach. Esatto, esatto. Ok, va bene, direi che è tutto, grazie mille, è stato davvero molto utile questa call.

44:44 - Fabrizio Paganelli
Bene, mi fa piacere. Ciao. Ciao, grazie.

44:49 - Aurel mrruku (ROMI Company)
Ciao, ciao.
