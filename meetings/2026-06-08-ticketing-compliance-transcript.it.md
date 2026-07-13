[ROMI-PIENISSIMO] – Focus Requisiti: Ticketing & Compliance - June 08
VIEW RECORDING - 70 mins (No highlights): 

---

0:00 - Elena Spini (ROMI Company)
  Grazie a rivedere un po' il processo dell'acquisto del biglietto, che dicevamo l'altra volta che l'abbiamo poi lasciato un po' più velocemente, così, quindi se siete d'accordo vi condivido, adesso per tenere sott'occhio una parte, allora, vedete?  Sì, sì.

0:44 - Sabatino Rinaldi ( Pienissimo)
  Ok, perfetto.

0:46 - Elena Spini (ROMI Company)
  Allora, l'altra volta avevamo iniziato un po' diciamo, proporvi quello che poteva essere l'idea di un flusso, però ci tenevo un attimo a rivivere...  un po' tutti i vari passaggi e poi capire un po' meglio quello che effettivamente voi vi aspettate e noi che effettivamente abbiamo capito.  Quindi, allora, questo è un oggetto che si chiama Asset, che servirà a noi per effettivamente andare a rappresentare l'unione di ordini e contatti.  Per ora, diciamo, prendetelo così, poi effettivamente anche noi dobbiamo fare tutte le nostre valutazioni interne, per ora abbiamo iniziato a pensare in questo modo.  Poi, se magari dovesse cambiare l'oggetto e per ora, essendo una org di demo, mi è venuto di utilizzare l'Asset perché è un oggetto stabile.

1:39 - Sabatino Rinaldi ( Pienissimo)
  Te roppo un secondo, giusto, per capire. Noi, con questa call di oggi, abbiamo terminato la parte di visualizzazione delle demo, giusto?  Basteremo direttamente qua la parte pratica per mettere...

1:51 - Elena Spini (ROMI Company)
  Sì, no, realtà questa è una parte della parte pratica, perché è per ridefinire un po' il requisito e capire poi effettivamente un po' meglio anche noi.

2:00 - Sabatino Rinaldi ( Pienissimo)
  Sì, perché poi alla fine ci dedicheremo poi nello specifico, nella pratica, la gestiamo un po' come terza parte, senso ad hoc, solo per quella parte lì.  Come? Noi gestiremo poi nella pratica successivamente sia la parte sales sia la parte marketing, mentre ai biglietti, magazzino, tutto quello che concerne la parte biglietti, dedicheremo proprio magari una sessione dedicata.  Sì, assolutamente.

2:31 - Elena Spini (ROMI Company)
  Cioè, per ora è per capire se effettivamente abbiamo capito bene la soluzione, dato che tutto il resto, diciamo, è un po' così, un po' più standard, poi questo qua è un po' più, diciamo, particolare e dato che volevo aver capito effettivamente il tutto, per ora vi faccio vedere, diciamo, ad super alto livello questa immagine che abbiamo avuto, poi passeremo ai diversi punti open point che mi sono segnata, però ecco, per arrivare...  Ad aver capito bene il quadro, quindi ho fatto questo meeting dedicato. Anche perché poi Daniela l'altra volta si era staccata, quindi ecco, ci tenevo a rivedere questa parte.  Poi quello che faremo sarà, ad esempio, abbiamo visto l'altra volta i lead, gli account, i contatti, andremo a fare meeting dedicati solo per questa parte, per tutti gli aspetti invece, diciamo così, funzionali e tecnici.  Allora, quello che vi dicevo è quindi, c'è questo oggetto che si chiama, prendiamo per buono che sia l'asset, ma sarà l'unione di quelli che sono gli ordini e i contatti per noi.  Perché abbiamo detto che quando noi riceviamo l'ordine, tipo che sia ordine di acquisto di un biglietto, di un evento, noi possiamo avere due scenari.  Lo scenario 1, è quello ordine con pagamento di... Carta di credito, diciamo, lo scenario facile. Si crea l'ordine, pagamento è andato, ordine chiuso, ok?  E avevo messo lo status stand-by, questo l'avevo aggiunto, perché avevamo parlato di tenere in stand-by quelli che sono i biglietti, però forse questo non è il caso per l'ordine chiuso pagato con carta di credito.  Quindi, mi ricorreggo, ci sono due scenari sugli ordini, quello chiuso subito con la carta di credito o quello col bonifico.  Quello col bonifico abbiamo detto che dovremmo aspettare un'azione manuale da parte di un utente che a un certo momento mi dica, ok, l'ordine effettivamente è stato pagato, perché è pienissimo, ricevuto il pagamento, per me questo ordine è stato, stato, viene aggiornato, pagato.  Vi faccio un esempio, qua ci sono gli stati, qua adesso è active, ma potrebbe essere, non so, pagato, per esempio.  Questo stato mi fa aggiornare... Ora, tornando al mio evento, che è il mio asset, quello che succede e quello che vi vorremmo proporre, se effettivamente potrebbe avere senso, è che per ogni contatto che vengono invitati a questi eventi, da capire effettivamente poi anche come questi contatti vengono, quali dei contatti relativi all'account vengono scelti per l'evento, da capire come ci sarà questo check, perché mi sembrava di aver capito che non tutti i contatti relativi a un account potrebbero essere invitati, dipende da quello che vi sa.

5:45 - Sabatino Rinaldi ( Pienissimo)
  Magari un'azienda col titolare ha iscritto in anagrafica almeno 10 con 10 collaboratori, però magari per l'edizione di camere di venditore li vuole portare tre, ha un'altra dei restanti set, e quindi non...  Non sempre sono tutti, magari poi soprattutto cosa succede nella situazione è che un anno c'hai quei dieci collaboratori, un anno dopo sono altri dieci diversi, quindi potenzialmente un account che ha dieci contatti, al momento dell'acquisto del biglietto, i biglietti potrebbero essere solo per sei, corretto?  Sì, cambia anche poi il prezzo ovviamente, perché per ogni persona vale il prezzo. Per ogni? Più persone ci sono, meno persone ci sono, più il prezzo vale ovviamente.  Valerà, però queste sono le logiche che avete voi, diciamo, a livello del vostro e-commerce. Esatto, quello che non si vede.  Ok, perfetto.

6:39 - Elena Spini (ROMI Company)
  Questo sicuramente è un punto che ci segniamo per noi da capire, come effettivamente possiamo mostrare poi questi contatti, ma prendiamo per buono che qua effettivamente ci sono tutti i contatti a cui noi dobbiamo assegnare un biglietto.  Ok? Quindi se io vado, disegno su Google. Il mio contatto Lauren, per esempio, qua avrò idealmente tutti i miei biglietti, ma quello che vorrei proporvi io è, dato che abbiamo parlato del fatto che avete, diciamo così, una problematica di tutti i contatti si devono stampare l'informativa della documentazione privacy, accettazione privacy, divulgazione, eccetera, la mia idea, la nostra idea è se effettivamente noi mandiamo un'informativa di questi documenti per mail a fronte dell'effettivo, diciamo, chiusura dell'ordine perché effettivamente è stato confermato che è stato pagato, noi gli inviamo i documenti i quali dovranno essere firmati a livello digitale, parlavamo di DocuSign, ma poi da capire quale sarà il tool.  volta che ci tornano indietro i documenti tutti firmati, allora solo in quel momento verrà generato il QR code, ovvero il biglietto dell'evento.  Non so se questa struttura potrebbe avere senso.

8:15 - Sabatino Rinaldi ( Pienissimo)
  Allora, detta così, per me ha senso. Sono però decisioni sempre della direzione. Comunque ti anticipo che Daniela a breve entra.  Ok. Vi faccio un... Poi lo rispiego.

8:29 - Elena Spini (ROMI Company)
  Non so se magari non si è capito.

8:32 - Sabatino Rinaldi ( Pienissimo)
  Ci sono state chiaro. Una volta che ci assicuriamo che il cliente paghi, quindi il pagamento è dato a buon fine.  Esatto. L'ordine è stato pagato. Esatto. Fatturato, pagato, quello che sia. Ok. Ha mandato, gli mandiamo poi in un secondo momento, quindi a tutti i partecipanti che hanno diritto al biglietto, una mail con la firma digitale per consentire a tutti i permessi lo consentire.  Solo che così vuol dire che tu a MUM devi già sapere che... Chi viene al momento? Beh, l'hai acquistato.  Eh, però Danilo acquista l'azienda, cioè un'azienda acquista per tipo 6 dipendenti. E non mi sapevo, cioè non dice è acquistato per Andrea e per Elena?  No, potrebbe essere uno step da venire. Come diceva prima Sabatino, nella ristorazione i camerieri ruotano con una certa frequenza.  Quindi cosa succede? Io che sono ristoratore, oggi ad esempio contro 10 biglietti per partecipare a capire dei venditori, che ci sarà in novembre del 2026, oppure anche magari in marzo del 2027, poi li pago anche magari, perché può succedere che già qualcuno un pochino più ingegnerà, che ci paghi già oggi, diciamo così, estremezziamo, però da qui a novembre io non so chi devi portare, quindi quella compilazione delle  D'elento dei nominativi, dei miei collaboratori che praticeranno l'ingresso, magari lo faccio il giorno prima, sempre estremizzando, il giorno prima dell'evento, e non è detto che siano tutti i contatti che sono codificati all'interno del CRN.  Magari qualcuno ci viene e non è mai stato presente e lo inseriamo in cui noi. Può succedere che io vi porto dietro sei camerieri, di cui tre magari sono già registrati, tre li ho assunti una settimana fa, e quindi non sono magari neanche registrati sul CRN.  La cosa più logica che mi viene da pensare, che secondo me qui è una cosa che dobbiamo fare noi, è che sia il titolare che comunichi a noi i collaboratori che devono partecipare per quella data.  Quindi da parte nostra avere una comunicazione col titolare, tale per cui lui ci informa di chi sono i partecipanti, e noi a quei partecipanti in automatico manderemo questa...  Però c'è da tenere conto che, mentre per eventi un pochino più importanti come può essere l'Acadio, Mastery, dove partecipa magari solo il titolare, con la moglie o con il direttore generale, nei corsi un pochino più operativi, quindi canali rivenditori, piuttosto che il food marketing, eccetera, eccetera, viene gente che sono collaboratori che, ripeto, possono cambiare.  Quindi teniamo in conto che spesso il titolare lo sarà il giorno prima di partire. però magari piuttosto si fa un cambio nominativo.  Cioè, il nominativo lo facciamo anche adesso. No, però, se è che tutto quanto lo meccanismo si basa sui contatti che sono già presenti, teniamo conto che magari quando lui viene, ci sono, ah, si porta dietro le persone il cui contatto non è presente.  Ma eventualmente potrebbe essere anche una ipotesi in cui noi la andiamo a titolare e il titolare inoltre la richiesta.

12:02 - Andrea Di Cicco
  Sì, ma la domanda che ho io è relativa al documento che devono firmare. Quello solitamente viene firmato il giorno prima, poco prima dell'evento, se dimenticiamo di firmarlo.

12:22 - Elena Spini (ROMI Company)
  Quando fanno il giorno stesso se l'avevano il giorno stesso perché lo portano fisicamente, no? Però c'era stato chiesto appunto di ideare qualcosa di diverso e allora io mi stavo ricollegando al fatto che comunque voi il biglietto lo mandate 60 giorni prima.  Quindi per me magari, non dico il giorno dell'acquisto dell'ordine, ma magari potenzialmente 60 giorni prima, come effettivamente fate adesso, si manda la comunicazione da capire effettivamente questo problema dei contatti e poi una volta che tu firmi hai il biglietto.  Cioè questa era un po' la mia idea, però effettivamente se mi dite che puoi cambiare i contatti...

13:07 - Sabatino Rinaldi ( Pienissimo)
  No, hai ragione anche te, perché hai idea, perché ci sono tante dinamiche diverse su queste. Una cosa che mi viene in mente, quando mi hai fatto vedere la sezione dove lì nella dashboard in basso a destra c'erano i nomi dei contatti?

13:27 - Elena Spini (ROMI Company)
  Sì, intendi qua?

13:29 - Sabatino Rinaldi ( Pienissimo)
  Esatto, questi qui sono i contatti che tu di base hai già in anagrafica dell'azienda. Dell'account, corretto, sì.

13:39 - Elena Spini (ROMI Company)
  Dell'account, sì.

13:40 - Sabatino Rinaldi ( Pienissimo)
  E in questa, in quella fase lì, in quella dashboard lì, si può anche mettere manualmente in contatto da lì?  Cioè questa è una dashboard, entri nella sezione dedicata e lo aggiungi te.

13:54 - Elena Spini (ROMI Company)
  Sì, potenzialmente puoi creare tu l'account. Sì, l'account, puoi creare, scusa, il contatto. Contatto, fai new e aggiungi un contatto.  E qua c'è la schermata per aggiungere il contatto. Quindi questo sì si può fare, però sempre che lo devi sapere, prima.

14:11 - Sabatino Rinaldi ( Pienissimo)
  Ma non, cioè, nel caso in cui, nello scenario in cui noi lo inviassimo al titolare, il titolare poi pian piano compila o inoltre la comunicazione ai suoi dipendenti e qualora uno di essi non ce l'avessimo nel CRM, si genera.  Non so se mi sono spiegata bene.

14:33 - Andrea Di Cicco
  Sì, allora, praticamente ti spiego un attimo in un'esperienza che è simile, quello come è gestita la cosa, perché in pratica, in generale, chi fa l'ordine non è detto neanche che sia il titolare dell'azienda, poi non so nella casistica vostra, però solitamente potrebbe essere tipo una segretaria o qualcuno che è comunque d'amministrazione.  Esatto, che gestisce. Per quanto riguarda, praticamente si parte dalla creazione dell'ordine. Dopo il pagamento dell'ordine si invia un'email con una richiesta di partecipanti.  Praticamente il referente, qui poi capiamo un attimo anche a seconda delle licenze che avete, praticamente nell'esperienza passata che succedeva che questa email conteneva un link che ti apriva una schermata in cui ti faceva inserire quelli che fossero i partecipanti.  Nel momento in cui tu inserivi i partecipanti, questi venivano poi automaticamente creati su Salesforce, in modo tale che tu riuscissi a gestire tutta la lista di nominativi afferenti a quei biglietti, perché poi se è necessario gestire anche la firma dell'accettazione per privacy e così via, quello da qualche parte va tracciato.  Insomma per evitare che avete problemi di archivi cartacei. Quindi una volta che l'utente che ha fatto l'ordine compila quelli che sono i partecipanti all'evento, si può mandare questa richiesta di firma di questo documento e poi da richiesta firma del documento si invia il QR code, il biglietto.  Quindi è un po' questo l'approccio che viene eseguito. Però diciamo che sostanzialmente loro hanno questo invio di richiesta partecipanti fatto automaticamente quando viene pagato.  Quindi l'utente riceve questa email di richiesta partecipanti subito, però nulla vieta di dire questa email la mandiamo, che ne so, due mesi prima dell'evento, un mese prima dell'evento, possiamo, sulle tempistiche ci possiamo lavorare insomma.  Poi ovviamente viene dato anche all'utente. L'utente che lavora all'interno della piattaforma ha la possibilità di mandare un reminder, nel senso che se vedo che per un determinato ordine non sono stati assegnati i biglietti ai partecipanti, posso inviare un reminder per quel determinato cliente perché ancora non ha inserito i partecipanti.  Quindi però qui le cose che tra virgolette vanno definite sono un po' l'approccio che si vuole eseguire, cioè quando queste persone devono firmare questo documento e quando si ha la lista dei partecipanti, che è la cosa un po' più importante, perché se la lista viene data il giorno stesso dell'evento, allora cambia un po' l'approccio.

17:44 - Sabatino Rinaldi ( Pienissimo)
  Allora, considera che noi anche, ti prendo un po' tutti i punti, anche la parte di invio 60 giorni prima, in realtà poi quell'invio di 60 giorni prima viene fatto anche 30 giorni prima, così come 15 giorni prima, così come addirittura il giorno prima.  Prima. E in quella fase lì noi puntiamo comunque a fare nuove iscrizioni, quindi è molto probabile che due giorni prima dell'evento qualcuno continui ad acquistare in quel momento lì.  Noi infatti questa cosa qui, l'invio dei biglietti, la gestione di chi ha compilato, chi non ha compilato, la gestiamo tramite funnel.  Banalmente tutto parte da un tag di iscrizione. Nel momento in cui un'azienda compra e quindi abbiamo ricevuto l'ordine, abbiamo ricevuto il pagamento, entra in un funnel con uno specifico tag e c'è tutta l'altra fila di scarico il biglietto, compile i dati, non l'hai ancora fatto, fallo, mancano i giorni, manca un giorno, e l'ora del giorno dell'evento.  Motivo per cui anche tantissime persone arrivano nei nostri eventi senza nemmeno il foglio, cioè vengono senza niente, perché o non lo fanno o si sono iscritti dal giorno prima, quindi per un motivo o per un altro.  E così, a meno che non fai sold out di una sala, quindi dici ok, hanno già 500 persone, non ne possono entrare altre, allora lì è diverso, però di base fino al giorno prima magari noi accettiamo comunque ordini.

19:16 - Andrea Di Cicco
  Ok, però come dici tu è possibile che qualcuno magari, Elena, che gestisce un'azienda, ha comprato 10 piglietti e venga lì senza averne compilato neanche uno, e quindi poi deve essere gestito tutto durante la mattinata dell'evento?  Sì.

19:37 - Sabatino Rinaldi ( Pienissimo)
  Ok. E deve essere poi forza di cose gestito, perché poi noi da lì, comunque quelle informazioni di check-in ci servono per diversi aspetti, per anche lato marketing, così come lato commerciale, e così come capire come andate per il vivente delle sale.  Sì, effettivamente sarà la scannerizzazione famosa del quel cuore.

19:59 - Elena Spini (ROMI Company)
  Esatto. Quindi potenzialmente, come ha detto Andrea, adesso per ricapire questo concetto, potenzialmente io il giorno stesso dell'evento potrei trovarmi a dover compilare tutti i documenti e generarmi il mio biglietto.

20:17 - Sabatino Rinaldi ( Pienissimo)
  Sì, esatto. Che al momento sono cose che voi fate manualmente, immagino, quindi una sorta di hostess.

20:26 - Andrea Di Cicco
  Ma Rautano...

20:27 - Sabatino Rinaldi ( Pienissimo)
  Cioè, esatto, non è proprio manualmente. Tipo, ti faccio anche l'esempio di un evento gratuito, che sarà poi il primo che facciamo, che è il tour.  Al tour, lì non hai bisogno di comprare nessun biglietto, però noi comunque la trafila di mio biglietto la facciamo.  Cosa succede? Che se al tour viene qualcuno che non ha il biglietto cartaceo, non ha i documenti compilati, perché poi i documenti, bene o male, sono quelli, cioè la privacy, eccetera, eccetera.  Quando arriva e non ha il biglietto, noi dal nostro sistema, che abbiamo internamente, faccio una... Verifica con nome, cognome, mail e telefono, non per forza tutti e tre insieme, o uno o l'altro tutti e tre, e verifico che realmente quella persona si è effettivamente iscritta all'evento.  In base a questa verifica, io sono sereno, genero io la parte di QR code, eccetera, eccetera, e me lo porto nel sistema.

21:21 - Andrea Di Cicco
  Ok?

21:21 - Sabatino Rinaldi ( Pienissimo)
  O comunque deve firmare sempre la solita rapida. Tra l'altro, te adesso parlavi del tour, al tour magari possono partecipare anche aziende che noi non abbiamo codificate all'interno del CRM, perché gente nuova.  Magari se è gente che non si è nemmeno iscritta alla form, è arrivata lì, all'ultimo, sì. Perché praticamente noi abbiamo il tour del food marketing, quest'anno non lo so il food marketing, ma tendenzialmente erano eventi a gratuity.  Quindi persone venivano, non esiste fattura, non esiste incasso. Esiste iscrizione. Esiste iscrizione, prendono, vengono. Però c'è un ordine a zero.  Sì, c'è un ordine a zero, quindi di base in realtà, se si sono iscritti dal form, alla fine la trafila dei Vieti, seppure un ordine a zero, è comunque identica.  Esatto. Cioè loro hanno comunque il contratto, è come se avessero pagato in realtà. Però c un ordine a zero e quindi quella documentazione c'è.  Può dire però che magari un'azienda tipo Andrea, che ha un ristorante, si trova a passare davanti alla sala dei congressi, entra perché è un ristoratore e quindi deve fare tutto da zero.  Quindi lì deve andare tutti i 10-15 fogli di contratto e se deve firmare uno ad una. Allora, in realtà, sugli eventi gratuiti questa cosa è cambiata quest'anno, ovvero che lo sviluppo ha fatto un link.  Quindi è tutto, è un link dove i clienti compilano semplicemente con delle... Penso delle risposte automatiche e basta, solo però per gli eventi gratuiti.

23:06 - Andrea Di Cicco
  Ok, quindi sotto un certo punto di vista diciamo per in generale dobbiamo gestire due necessità, prima è quella di una compilazione anche dei partecipanti che possa venire prima per tutti quelli che sono magari ristoratori che hanno comprato biglietti con tanto anticipo, quindi hanno tempo di compilare tutta questa parte qui.  Quindi dall'altro lato serve pure un qualcosa che permetta lato vostro il giorno dell'evento di andare a risolvere pure tutte queste casistiche dell'ultimo momento, chiamiamole così, in modo rapido, perché io mi immagino magari voi con tablet o qualcosa state lì, vi si presenta un tizio e vi dice io voglio partecipare all'evento, quindi se per favore mi iscrivete.  Di solito a me lo scende.

24:00 - Sabatino Rinaldi ( Pienissimo)
  Il è che ovviamente le tutor commerciali sono sempre in stretto contatto con i clienti. I clienti ci avvisano che, esempio, il weekend hanno fatto un bonifico piuttosto che un pagamento con carta di credito, girano le copie contabili, comunque la ricezione del pagamento, le tutor, e le tutor ci informano di questo pagamento.  Quindi, bene o male, quando siamo in corso d'evento, siamo sempre, cioè siamo a conoscenza che c'è stato questo pagamento e chi è il cliente.  Ok. Però, sempre dato da, la maggior parte però, sono bonifici, non sono neanche pagamenti con carta di credito da, magari, pensare di poterlo anche automatizzare, essendo con carta.

24:47 - Andrea Di Cicco
  Sì, perché il bonifico, purtroppo, è complicata l'automatizzazione.

24:53 - Sabatino Rinaldi ( Pienissimo)
  Perché io approfitto di questo, di questa parentesi che abbiamo fatto tra carte di credito. Per fare un cappello un po' a questo discorso degli asset, perché ne parlavamo prima tutti e tre insieme, è una cosa che dico ma magari la ripeto perché magari ve l'abbiamo già detta, però prima ci dicevamo noi tre che noi abbiamo diverse modalità di ricezione degli ordini, vendite da parte, vendite da tutto, i pacchetti, i suverar, ma a prescindere dalle varie sistemi con cui riceviamo gli ordini, uno dei concetti fondamentali che sono cari un po' a noi dall'amministrazione ma soprattutto anche alla direzione è che nel momento in cui si genera l'ordine il biglietto deve essere in qualche modo caricato, quindi quando io faccio l'ordine quel biglietto è lì parcheggiato.  Poi Poi successivamente emetterà una fattura. Noi non fatturiamo sempre immediatamente alla generazione degli ordini, mi faccio riferimento ad esempio alle vendite da parco.  Nel momento in cui fatturiamo quell'ordine ancora quel biglietto rimane lì parcheggiato in un limbo. Cosa succede? Che quel biglietto risulta disponibile solo esclusivamente se la fattura in cui è contenuto quel codice articolo che fa riferimento a quel biglietto è integralmente pagata.  Questa qui è una cosa che serve alla direzione, ma anche all'ufficio commerciale e al marketing per capire quanti biglietti abbiamo potenzialmente a disposizione, come dire, come monte biglietti X.  Di questo monte X quanti hanno già pagato e quindi possono effettivamente partecipare, Y? Poi ecco, alla fine di questo...  Questo cinema qui, ossia quando il cliente ha pagato e quel biglietto assume lo stato disponibile, si scatena questo meccanismo che voi ci state facendo vedere adesso tramite gli asset, che poi dopo dei quali ci sarà l'invio dei biglietti, la scansione del QR code, eccetera, eccetera.  Nel momento in cui, e qui chiudo, il cliente arriva col QR code, lo scansiona, quel biglietto che era disponibile deve essere scaricato e si azzera la disponibilità dei biglietti per quel cliente.  In questo modo, diciamo, ho cercato di sintetizzare quanto più possibile, in questo modo la direzione ha tutte le informazioni qualitative e quantitative che possono servire per tenere sotto monitoraggio tutto questo meccanismo.  Tenete presente che noi adesso, brevissimamente, su Zoho, che cosa abbiamo fatto per far fronte a queste cose? Abbiamo creato.  Abbiamo creato un archivio parallelo che l'abbiamo chiamato magazzino biglietti. In questo archivio viene generato un movimento di carico nel momento in cui si mette l'ordine.  Nel momento in cui viene pagata la fattura associata a quell'ordine, in questo magazzino biglietti quel movimento diventa disponibile. Nel momento in cui il cliente viene all'evento, scansione al QR code, si genera un movimento di scarico, in modo tale che su quel cliente la soma algebrica dei movimenti nel magazzino biglietti risulta zero.  Così noi sappiamo che per quel cliente tot biglietti acquistati, tot biglietti utilizzati, fine. Chiaramente per chi non è venuto sappiamo ancora chi sono i clienti che hanno i biglietti a disposizione, che hanno pagato ma non sono tenuti, e via di seguito.  Perché poi in base a questi tipi di informazioni si generano tutta una serie. Le deviazioni che adesso non sto qui a dire, bruciature e biglietti, se uno salte le devizioni, non le salte, eccetera, eccetera, ma sono più che altri meccanismi operativi interi nostri.  Non so se ho detto cose che magari hanno aggiunto qualcosa, se ho detto cose che...

29:18 - Elena Spini (ROMI Company)
  No, questo era chiaro, infatti era quello che cercavo di, diciamo, riassumere in questo status stand-by, che per me era un po' quello che è, un acquisto che sta immagazzando.  Io volevo, diciamo, slegare il tema biglietti a questo ordine, uguale biglietto, perché pensavo di metterci di mezzo il finché non accetti la privacy, io il biglietto non te lo genero.  La mia idea è quella. L'idea non è male. L'idea non è Un ordine per me non è uguale a un biglietto, finché tu non accetti il tutto.  L'idea Ora ti genero il QR code.

30:02 - Sabatino Rinaldi ( Pienissimo)
  Ma non so se mi puoi seguire bene, perché sennò non dobbiamo rivedere la soluzione. Ma una cosa, perché noi abbiamo la situazione in cui in un determinato ordine ci possono essere più righe articolo che fanno riferimento ad eventi diversi.  Abbiamo perso la condizione? Sì, stiamo, sì, stiamo. Questo qui, come impatta rispetto a questo processo? Perché adesso qui...

30:34 - Elena Spini (ROMI Company)
  Secondo me sarebbero ordini diversi, slegati a diversi asset. Cioè, ogni ordine un asset diverso. Ad esempio, questo è l'evento per ottobre, ad esempio.  E qua, vabbè, vedete diversi ordini, ma perché ce n'erano diversi. Però mi aspetto un ordine, io in realtà.

30:55 - Sabatino Rinaldi ( Pienissimo)
  Però è che cosa succede? Ti dico come facciamo adesso, però... Vai, scusate.

31:04 - Elena Spini (ROMI Company)
  E se poi dopo acquisti anche, che ne so, l'ordine di dicembre, cioè acquisti il biglietto per l'evento di dicembre, hai evento ordine di dicembre allegato allo stesso ordine potenzialmente, da capire come questo ce lo dobbiamo immaginare, però una deve essere legata a diversi ordini.

31:23 - Andrea Di Cicco
  Poi immagino che tu già hai mostrato un po' l'evento campagna, no? Che voglio utilizzarlo un po'.

31:28 - Elena Spini (ROMI Company)
  Ah ok, perché praticamente diciamo ci sarà un oggetto un po' a cappello che dirà evento di Allora aspetta, facciamo subito, ad esempio in Lore, abbiamo il nostro evento campagna, che sarà questo, status potrebbe essere tipo non ancora avvenuto oppure avvenuto o in corso da capire, poi ogni volta che io entro nell'evento, o tutti partecipano.  Tanti all'evento. E qua mi aspettavo il ha partecipato, fatto il check-in, non ha fatto il check-in.

32:10 - Andrea Di Cicco
  Adesso il nome può essere un po' forbiante perché si chiama campagna, ma in realtà spesso questo viene utilizzato sia per le campagne di marketing, ma anche per definire degli eventi, degli eventi che devono succedere in modo tale da avere il listato di tutte le persone che sono i partecipanti.  Quindi sostanzialmente se tu devi andare a fare un, penso che la domanda fosse relativa al fatto, se io ho un cliente che mi ha comprato due eventi, due biglietti per un evento a marzo e uno a luglio, come faccio a gestire questi flussi in maniera più puntuale per quelli di marzo e quelli di luglio?  Mi ricollego a quest'oggetto campagna perché da quest'oggetto campagna avrò tutta la vista di tutti quelli che sono i partecipanti e qui posso andare magari a creare un pulsante che mi fa i...  Reminder o magari un batch, cioè un oggetto, un qualcosa di schedulato, che va a mandare reminder per richiedere la lista di tutti quelli che sono i possibili partecipanti, in modo tale che non vado a chiedere, magari c'è un evento adesso, prossimo mese, un evento l'anno prossimo, non vado a richiedere i partecipanti pure per l'evento l'anno prossimo a quel cliente che ha comprato, nello stesso ordine, due partecipazioni ai venti.  Non so se questo è un po' risposto alla domanda.

33:36 - Sabatino Rinaldi ( Pienissimo)
  Quindi se ho capito bene, e non sono sicuro di aver capito bene, se io amministrazione, fatturo e incasso un ordine fatto dal reparto commerciale, all'interno del quale sono contenuti il Food Marketing Festival di settembre, il pienissimo live di novembre e il cameriere e i venditori di dicembre.  Io posso avere situazioni del genere che in un ordine ci sono tre codici articoli che fanno riferimento a tre eventi che si verificheranno in tre mesi diversi.  Questo vuol dire che quell'ordine porterà in questo oggetto qui, asset, le tre righe ordine su tre eventi diversi.

34:25 - Andrea Di Cicco
  Sì, perché praticamente che succede? Quando tu crei un ordine, nell'ordine hai una sorta di carrello che ti permette di definire quelli che sono i vari eventi.  Quindi che succede? Ti si vanno ad aggiungere tre prodotti all'interno del tuo carrello. Ognuno di questi prodotti si va a tradurre in una riga diversa perché sono prodotti diversi.  In questo modo riesci a gestire in maniera puntuale ogni riga separatamente. perché essendo prodotti diversi... Io mi aspetto anche che hanno prezzi diversi, scontistiche diverse, date diverse, e quindi è necessario avere tutto quanto splittato, cioè una riga per ogni prodotto acquistato.  A prossimo per farvi una domanda a questo punto.

35:15 - Elena Spini (ROMI Company)
  Sarebbero, scusa, per farvi anche vedere visivamente, sarebbero, quando lui dice righe d'ordine, sarebbero questi. Cioè, ad esempio, qua ci potrebbe essere scritto evento di settembre, oppure evento di novembre.

35:32 - Andrea Di Cicco
  Ok.

35:35 - Sabatino Rinaldi ( Pienissimo)
  Approfitto per fare una domanda. Noi, attualmente, ad esempio, per il Food Marketing Festival, utilizziamo un codice prodotto che è trasversale rispetto alle edizioni del Food Marketing Festival stesso.  Quindi, che sia stato filmato... usiamo per totani, cioè non c'è una distinzione del prodotto dell'anno. trasversale agli anni.

35:58 - Andrea Di Cicco
  Ok. Con questa tipologia.

36:00 - Sabatino Rinaldi ( Pienissimo)
  In questo caso qui, che cosa significa dal punto di vista operativo nostro? Che dovremmo creare un codice articolo per ogni evento, ogni anno, ossia dovrò creare un codice articolo Food Marketing Festival 26, un altro codice articolo Food Marketing Festival 27 e via dicendo?

36:18 - Andrea Di Cicco
  Allora, in realtà qua ci sono vari approcci, dipende un po' anche come questo codice viene utilizzato pure sugli altri sistemi.  Nel senso, se tu mi dici, guarda, ad oggi noi utilizziamo lo stesso codice per sempre ad interim, in quel caso tu puoi crearti questo oggetto campagna un po' che ti va a racchiudere l'evento, immagino che sia un evento che accade una volta l'anno, due volte l'anno, con un periodo di validità, e lasciare questo codice uguale, ma fare leva poi su quelle che sono le date di partecipazione dell

37:04 - Sabatino Rinaldi ( Pienissimo)
  Adesso inseriamo ogni evento, che varia negli anni, inseriamo l'anno di competenza dell'evento, in modo tale che quando si genera nel movimento di biglietti come carico, sappiamo a che anno di riferimento fa quella tipologia di evento, quel biglietto.  Inoltre, possiamo fare dei ragionamenti massivi se top clienti non hanno partecipato a un evento tipo camere di eventi di marzo, sappiamo quanta gente non è venuta, sappiamo chi non dovrà venire, eccetera, eccetera.

37:45 - Andrea Di Cicco
  Sì, diciamo che è un po' questo qui l'oggetto, questo che sta mostrando adesso Elena, quello che ti fa racchiudere tutte queste informazioni, che è l'oggetto campagna, in cui, come diceva prima lei, nella related list, quindi, nella base...  La di un po' particolarità, cioè di dettaglio di tutti quelli che sono i partecipanti, puoi vedere tutto lo stato dei partecipanti, quindi ad esempio se tu qui ne vedi solamente una parte, ma se clicchi su Be All, tu hai la possibilità di avere tutta la lista completa dei partecipanti, filtrarli, vedi in alto a destra c'è quella sorta di imbuto che ti permette di filtrare, quindi magari puoi filtrare per lo stato, in modo tale che tu hai questa vista, chiara, poi ovviamente c'è pure tutta una parte di report e dashboard che è ancora più raffinata, che ti permette di confrontare magari più eventi, la partecipazione, calcolare dei KPI, insomma che vi possono essere utili, però diciamo questa cosa del codice prodotto, quello può essere semplicemente risolto andando anche a insistere sulla data di ogni evento in modo tale da risolvere il problema.  Intanto quello che succederà praticamente a livello di carrello tu troverai il nome del prodotto con la relativa data immagino, clicchi su quel prodotto e poi a noi diciamo quel codice lato nostro non è che abbia al momento non ha proprio un significato specifico, poi magari capiamo se a livello di integrazioni possa avere un significato più specifico anche lato nostro, però per noi non è assolutamente un problema gestirlo insomma.

39:27 - Elena Spini (ROMI Company)
  Anche perché comunque per il tema ordini e prodotti avevamo detto che era solo in lettura, quindi cioè non vedo, per ora non vedo criticità ecco.

39:42 - Sabatino Rinaldi ( Pienissimo)
  Ok.

39:44 - Andrea Di Cicco
  Poi lo capiremo nel dettaglio.

39:46 - Elena Spini (ROMI Company)
  Ma io se posso ho una domanda proprio, come gestita attualmente la parte dello scanner il giorno dell'evento? Cioè con cosa scannerizzate questo QR code?  Abbiamo Abbiamo sempre...

40:00 - Sabatino Rinaldi ( Pienissimo)
  Sempre una piattaforma sviluppata da noi internamente che scansiona il QR code e lo manda al magazzino, diciamo, lato CRM dallo scantato, nel senso ci avvisa che quella persona fisica si è presentata all'evento e di conseguenza attribuisce un tag, il tag è arrivato, e poi nel magazzino c'è il discorso che vi faceva Fabrizio di scarico del biglietto.  Ma banalmente con i cellulari? Sì, con i cellulari. Ognuno dei ragazzi ha sul cellulare una app dedicata, inquadrano il QR code, verificano che siano tutte le firme gattacee, inquadrano e scaricano, fanno il check del biglietto.  Dopodiché questi biglietti vengono dichiarati come usati nel magazzino e poi si bruciano, insomma, il calometto. Ciao Daniele, non ti avevo visto arrivare.  Ciao Elena.

40:56 - Elena Spini (ROMI Company)
  Ciao Andrea. Ciao. Ciao. Fare, già che c'è Daniela, il giro del biglietti e capire un po' meglio se effettivamente ha senso.

41:08 - Sabatino Rinaldi ( Pienissimo)
  Sì, così più che altro affrontiamo il discorso che abbiamo fatto all'inizio.

41:12 - Elena Spini (ROMI Company)
  Della documentazione, sempre premesso da capire il tema, poi effettivamente giorno dell'evento, come dobbiamo organizzarci. Allora, cerchiamo di fare un po' di...  rivediamo il tutto. Quindi, allora, dicevamo, questo è un oggetto che viene chiamato asset, è un oggetto standard, per ora mi sono immaginata l'asset da capire se poi effettivamente useremo questo o un altro.  È semplicemente un oggetto che ci permette di immagazzinare nella stessa pagina ordini e contatti, perché è quello che ci serve.  Quindi, siamo detti che una persona va sul vostro e-commerce e... Compra il biglietto. Quello che succede invece nel CRM è che ci arriva l'ordine, gli ordini sono potenzialmente questi, mi immagino che per ogni asset ci sia un solo ordine, quindi qua pensa un solo ordine, perché abbiamo detto che, non so, il ristorante di turno va e acquista il biglietto per l'evento per, boh, 5 suoi contatti.

42:26 - Sabatino Rinaldi ( Pienissimo)
  Ok? Ok.

42:27 - Elena Spini (ROMI Company)
  Acquista l'ordine, vede l'ordine, arriva l'ordine su Salesforce, abbiamo detto che se è carta di credito, l'ordine passa, si chiude, è pagato per noi e questo inizia a scatenare tutto il processo dei biglietti.  Se invece l'ordine è pagato con bonifico, deve stare così sospeso finché un vostro operatore effettivamente accerti questo pagamento.

42:59 - Sabatino Rinaldi ( Pienissimo)
  Sì, finché l'amministrazione...

43:04 - Elena Spini (ROMI Company)
  Fabrizio forse sarà l'onere di quest'azione. Fabrizio è l'onere di questa azione, sono loro due le casse.

43:14 - Sabatino Rinaldi ( Pienissimo)
  Attualmente non siamo noi che andiamo a fare il click, ma c'è una procedura automatica che gira di notte, legge lo scadenziario clienti, va a verificare tutti i clienti che hanno le fatture chiuse, quindi pagate, e poi in automatico mi va ad aggiornare la disponibilità dei via.  Che è sul sistema Mexal?

43:35 - Elena Spini (ROMI Company)
  Sì, da Mexal a Zo.

43:38 - Sabatino Rinaldi ( Pienissimo)
  Ok, perfetto.

43:40 - Elena Spini (ROMI Company)
  Possiamo comunque includerlo nelle nostre procedure automatizzate che verranno gestite quando facciamo quell'integrazione. Sì. Per ora, diciamo, potrebbe essere per tutti i pagamenti in bonifico, avevamo detto che doveva essere automatico, perché per settembre non ci sarà questa cosa.  Mi confermate?

44:03 - Sabatino Rinaldi ( Pienissimo)
  In realtà noi per settembre dovremmo avere, da parte anche di biglietti, ci farebbe comodo, soprattutto per...

44:13 - Elena Spini (ROMI Company)
  Sì, no, no, parlo di Nexal, quindi questa procedura...

44:17 - Sabatino Rinaldi ( Pienissimo)
  matissima proprio il collegamento? Esatto. quando dobbiamo fatturare, chi fa al food marketing, dobbiamo fatturare a mano, siamo fritti, perché food marketing ci arrivano 100-150 fatture al giorno, Ma perché cosa ci arrivano 100-150 fatture?  Cioè, quando faremo un food marketing, che si intreranno tutti gli ordini da vendita da palco, No, lei però sta dicendo un'altra cosa, non sta dicendo questo, si parla di vendita da palco, invece lei sta parlando dei biglietti, d'automatismo dei biglietti pagati.  Eh, ma come facciamo a mano? Cioè, tutte le fatture che adesso noi mettiamo da adesso fino a... Prima del food marketing.  Andiamo su CRM, a mano ogni fattura a sbloccare il biglietto? Cioè non so se vi rendete conto. Noi lo facciamo anche, non c'è problema, però te Lisa cosa dici?  No, stai pensando, però sono due cose diverse.

45:18 - Elena Spini (ROMI Company)
  Abbiamo detto che la parte di Mexal per settembre è veramente, veramente stringente perché c'eravano andate altre tempistiche, quindi abbiamo detto per settembre, dato che ci sarà il prossimo evento, faremo tutto quello che fa la parte del CRM che però poi vi andrà in dismissione.  Quindi tutto quello che è la generazione di biglietti ci sarà, quello che mancherà è effettivamente l'ordine su Salesforce si crea, dovrà generare una fattura, questa parte qua è mancante.

45:50 - Sabatino Rinaldi ( Pienissimo)
  Una fatturazione è mancata. Sì.

45:54 - Elena Spini (ROMI Company)
  Però è matematismo.

45:56 - Sabatino Rinaldi ( Pienissimo)
  E quindi tutta l'interazione... 'integrazione con Mexal, a sto punto, mi vengo a dire, o no? Sì, corretto. Quindi la disponibilità dei biglietti, la parte della fatturazione.  No, la disponibilità dei biglietti, invece, cioè la disponibilità dei biglietti. la disponibilità dei biglietti, ma dovrai fare manualmente la verifica se il biglietto è evadibile oppure no.  Il sistema funziona. È per farlo funzionare.'automatismo che avrai. Bene, virgola. Chi ce la mette a manualità? Perché non so se vi rendete conto, tutto il cinema che si scatena con la fatturazione del tutto, la fatturazione del food marketing pre-e post-evento, pre-evento quando la gente compra i biglietti per partecipare, che non è il caso del tour, che va bene, ma quando c'è il tour, il tour lo sotturiamo noi dal di là.  Ma che giorno sarà il tour? Cioè, parliamo di giorni. Aspetta un secondo, fermatevi un secondo. Un attimo stop al televoto.  Noi, ZO, non abbiamo dismesso ancora. Quindi tu, fatturazione, avremo un momento in cui dobbiamo usare il performance. Fino a ottobre noi dobbiamo per forza usare tutti e due si sereni.  Siamoci sereni. Cioè non puoi fare on-off così perché ci facciamo malissimo. Quindi noi dobbiamo sapere, abbiamo fino ad ottobre, Zoho, tutta la parte di fatturazione, vedete, da palco, eccetera, eccetera, rimangono anche su Zoho, dovremmo fare delle repliche anche su Salesforce in sta fase.  Questa è la parte veramente rognosa perché finché non c'è l'integrazione, cioè noi useremo i biglietti, gli sta biglietti con la parte lì e la dobbiamo andare a fare duplicati anche di là, per forza di cose.  Però poi la fatturazione automatica che dice lui, noi teniamo Zoho. L'unica cosa che forse è stata da Zoho è Foodmagic.  Però calcoliamo che Zoho, mi sa che scade, giusto? Zoho, il 31 di ottobre, però abbiamo tempo, però abbiamo tempo, si fa per dire, perché tra agosto, che siamo tutti in ferie, settembre che c'è il tour e il food, quando la facciamo stiamo...  Posso magari richiedere a loro? No, no, ma io lo dico per ragionare in scena, Elena, noi abbiamo in scadenza ZOO al 31 di ottobre, quindi quello per noi è importante perché se dismettiamo il CRM non possiamo non aver integrato il software amministrativo.  Quindi noi per il marketing riusciamo, faremo lavoro doppio e utilizzeremo sia ZOO per tutta la parte di fatturazione di oro di Gapalco, sia SETO tra l'inserimento dati così da avere lo storico.  Poi però bisogna...

48:39 - Elena Spini (ROMI Company)
  Questo VintoFood che data ha?

48:43 - Sabatino Rinaldi ( Pienissimo)
  29 settembre. Ok, e la parte del tour? Le due settimane prima, tra il 7 e il 19 settembre. Sì, il 19 settembre.  Più o meno, come Rangela. Proprio perché volevo dire io, adesso sono di là. Non ci possiamo permettere di iniziare l'integrazione con Mexal, tra Salesforce e Mexal, il primo di settembre o il primo di ottobre, secondo me dobbiamo iniziare prima.  Ma se alla base non hai la struttura dietro, come fai ad iniziare a integrare qualcosa? È come mettere un infotainment in una macchina per un'ertelare.  Non so poi come funziona, effettivamente per te operativamente nella nostra via di Palli. No, no, ma io mi metto in 12 ore e sta su tutto a mano, non è un problema.  senza che discutiamo tra noi, Fabri, perché se fai una discussione con lui, che è che 10 ore di interno, perché loro ci dicono, al 31 di ottobre noi che cosa riusciamo a fare?  Perché va bene il 29 di settembre in cui facciamo la doppia operazione, ma poi dal 30 di settembre in poi, fino ad arrivare al 31, cosa riusciamo a fare in termini di integrazione?  Perché poi dopo, ripeto, calcoliamo anche nelle varie notte quotidiane che in settembre siamo praticamente tutti dirottati su altre cose, non lascio venire.  Vai Elena, scusa.

50:19 - Elena Spini (ROMI Company)
  No, sì, quello che stavo tentando di dire è che così adesso su due piedi, cioè le date mi sembrano super stringenti, ma capiamo con effettivamente tutti i meeting che dobbiamo fare di analisi cosa poi ne verrà fuori.  E poi lì ci sappiamo dare delle date più significative. Sicuramente l'obiettivo sarà arrivare a questo 31-10 almeno ad avere il più possibile.  Mi sentirei di cercare di tranquillizzarti e di dire a Fabrizio che al 31-10 ci sarà tutto, lo spero, dobbiamo farci anche noi dei calcoli.  Cioè nel senso...

50:54 - Sabatino Rinaldi ( Pienissimo)
  poi dobbiamo capire nella lista delle cose che abbiamo da fare, che cosa si può posticipare rispetto... Esatto, quello che diventa...  Sì, sì, esatto. Ma poi ci sono delle cose che possiamo aspettare un attimo perché non ci fermano l'operatività, ovviamente se noi blocchiamo l'integrazione tra software amministrativo e CRM, a noi ci si blocca l'azienda, quindi capisco la sua agitazione.

51:20 - Andrea Di Cicco
  No, anche perché diciamo, a livello di integrazioni, cioè sicuramente l'integrazione ha un impatto anche a livello di flussi che dobbiamo gestire, quindi comunque l'analisi anche di quella parte lì, cioè non è che la faremo dal primo di settembre, è un qualcosa che dovremmo fare molto prima perché dobbiamo capire quali sono effettivamente gli impatti anche a livello di data model, flusso di gestione e così via.  E l'altra cosa poi importante è capire pure effettivamente quali sono le integrazioni, magari sono due integrazioni in sciocche che uno dice, vabbè, in una settimana le ho fatte.  Infatti secondo me prima...

52:00 - Sabatino Rinaldi ( Pienissimo)
  Andare in ansia, abbiamo fatto la stima dello sforzo, sapendo quali sono le strade, uno dice delle loro, siamo anche disponibili a magari metterci un po' più lenti su altri pezzi e magari dare priorità a questa, perché così teniamo il meno l'operativo, però, insomma, in qualche modo la facciamo.

52:14 - Andrea Di Cicco
  E l'altra cosa importante, ovviamente, poi sarà la disponibilità pure dell'altro partner che gestisce l'integrazione per potersi integrare con noi, quello...

52:31 - Elena Spini (ROMI Company)
  Stiamo un po' sforando con i tempi, se siete d'accordo tornerai un attimo al tema del biglietto e questa parte di integrazione la lascerei, tanto che comunque ci dobbiamo tornare.  Quindi, dicevamo, appunto, ci sono questi ordini, idealmente, inizialmente, ci sarà un'attività manuale per, quantomeno, gli ordini con bonifico, finché non avremo, idealmente, per inizio settembre.  Facciamo così, poi da capire quando ci sarà Mexal tramite integrazione, come avverrà questo check automatico, come ce l'avete adesso, si dice ok, perfetto, questo ordine è stato pagato e quello che pensavamo di fare è che per ogni contatto che è collegato a questo account, che ha fatto l'acquisto, da capire poi effettivamente, perché qua è emerso il tema, non tutti i contatti magari sono invitati all'evento, da capire poi effettivamente come questo possa effettivamente avvenire, ma ad ogni contatto, e qua mi riapro il contatto di prima, io potrei avere, e quello che pensavamo di fare era, una lista di file, un file unico da capire, che contenga tutte quelle che sono le informativa privacy, non di Google.  L dei dati, tutta la parte di documentazione che andrebbe firmata, che voi attualmente firmate in cartaceo fisico. La nostra idea era, ve la mandiamo o la mandiamo 60 giorni prima dell'evento, 30 giorni da capire, a ogni contatto che la deve firmare con DocuSign da capire, qualsiasi applicativo che possa fare abilizzato la firma digitale, firma tutta la documentazione richiesta e una volta che firma ottiene il QR code, ovvero il biglietto dell'evento.  Su questo bisogna capire però effettivamente se questa cosa vi va bene, perché attualmente voi invece ordine uguale biglietto.

54:52 - Sabatino Rinaldi ( Pienissimo)
  Per me, attualmente ordine uguale biglietto e poi dopo rilasciamo alla fase... È analogica a tutta la stampa, la scrittura, eccetera, eccetera.  Esatto, esatto.

55:04 - Elena Spini (ROMI Company)
  Quindi capire se ha senso anticipare il tutto in modo da vincolare la firma al biglietto. Ha senso, non ha senso.  Questa potrebbe essere la nostra proposta, ma da capire se effettivamente è per voi.

55:18 - Sabatino Rinaldi ( Pienissimo)
  Siamo da donarla, Elena, perché potrebbe essere avere tutti i sensi del mondo per noi come azienda, ma non vorrei ci rallenti la parte, diciamo, di scarico del biglietto.  Soprattutto una cosa che abbiamo detto anche, Elena, quella che il dipendente, il referente, comunque chi l'è in veria, non sa poi che dipendenti portare all'evento, soprattutto 60 giorni prima.  60 giorni prima no, però poi cazzo quando arriviamo a due settimane.

55:46 - Elena Spini (ROMI Company)
  60 giorni prima no, abbiamo detto anche di aggiungere la parte che proponeva Andrea, ovvero verrà chiesto al proprietario dell'azienda, quindi al referente, Grazie.  Grazie. Di compilare i partecipanti. I partecipanti poi vengono creati e potenzialmente possiamo fare dei reminder per dire vedi che non sono stati inviati questi biglietti.  E si rinviene i biglietti. Biglietti, documentazione, scusa, per poi accedere al biglietto.

56:19 - Sabatino Rinaldi ( Pienissimo)
  Allora, casistiche sono diverse perché dipende dalla fonte. Perché quando sono eventi gratuiti, più forzi la mano, più c il rischio che il cliente non ti utilizzi poi il biglietto.  Perché poi l'essere umano è così. Quando ha della roba pagata poco, ti restituisce poco. Bisognerebbe capire un attimino come muovere questa roba, poi ci dobbiamo un attimo ragionare.  A me l'idea di avere i file prima non mi dispiace. Dobbiamo soltanto capire come muoverci. Potremmo anche creare uno stato di biglietti in attesa di compilazione che fanno un funnel di reminder al cliente.  Sì, sì, questa è la c'è. Sì, possiamo aggiungere la fase di funnel, quella parte di compilazione, senza farli arrivare.  Poi ci sarà sempre quello che se lo dimentichi e ti si presenta al corso, perché noi dobbiamo ragionare per lo sciopo.

57:25 - Elena Spini (ROMI Company)
  Sì, poi magari si può fare anche a livello, ad esempio, di contatto, che ne so, mi stai dicendo, Loren Bailey si presenta all'evento, mi ha detto che non ha fatto niente, gli si può mettere un pulsante qua all'utente che è lì all'ingresso e gli si manda l'email istantanea.  E poi deve seguire comunque la procedura, perché comunque mi sembrere di aver capito che già oggi fate una cosa del genere con gli eventi del tour gratuito, con i link.

57:54 - Sabatino Rinaldi ( Pienissimo)
  No, ma tutti, anche i corsi di pagamento si presentano, si sono dimenticati i fogli nel hotel. Potenzialmente potrebbe essere anche, cioè, quello che gli possiamo fare, ma potrebbe anche, cioè, non sarà sicuramente la totalità delle persone che sono così, però, cioè, no, è un 20-80, perché farei tutto, se non sbaglio, un 20-80 ti compilerà prima il biglietto, l'altro 80% per lo meno proviamo a farlo digitalmente, anche perché, anche noi, è vero che teniamo tutti i fogli iscritti, però, quando te vai in magazzino, fai il segno in aramaico, sperando che trovi quel cazzo di contratto.
  ACTION ITEM: Define Campaign Participant object + Files/QR; propose storage/cleanup plan to Sabatino - WATCH: https://fathom.video/calls/700474570?timestamp=3513.9999  Quindi, noi facciamo firmare tutti i documenti del mondo, di tutela, per poi andare a diventare scemi per cercarli. Perché poi, quel documento che loro compilano via mail, noi ce lo troviamo nella sezione file, giusto?

58:44 - Elena Spini (ROMI Company)
  Ecco, su questo, sì, l'idea è quella, tenere su file il PDF della privacy e potenzialmente anche il QR code.  Beh, quel code ci devo pensare, perché magari lo farei anche a livello di partecipazione. Non lo so, su questo devo un attimo capire cosa effettivamente conviene, perché o a livello di contatto, però qua per esempio se uno partecipa a 10-20 poi stanno tutti qua dentro, e boh, devo un attimo capire, oppure a livello dell'evento singolo, quindi l'evento singolo è ad esempio evento del 3-10, io ho per ogni partecipante effettivamente se ha partecipato o meno.  da qui capire se possiamo aggiungere anche la lista dei file di cui stiamo parlando. Su questo tenetelo un po' in stand-by, quando effettivamente studiamo la proposta definitiva, io vi faccio sapere dove finiscono questi biglietti, ma questo status è poi quello che si effettivamente aggiornerà una volta che viene scannerizzato il QR code, praticamente.  Quindi se è presentato, c'è chi ne effettuato, non lo so, oppure no show. E da qua poi facciamo tutte le logiche.  Grazie. Quindi il partecipante alla campagna. La cosa che mi preme farvi notare è che tutti i biglietti che andiamo a mettere, tutti i documenti PDF che andiamo a mettere per la privacy occupano spazio.  Quindi è vero che non avete il problema del magazzino pieno di fogli, ma avrete il problema dello storage di Salesforce.  Quindi su questo bisogna capire, cioè potenzialmente si possono fare delle logiche che... però noi potremmo fare anche uno scarico, cioè a certo punto possiamo fare un backup su un cloud, cioè in qualche modo lo ricordiamo.  Volevo arrivare a quello, cioè potenzialmente si possono pensare a delle logiche del tipo, non so, dopo 30 giorni dell'evento, voi vi siete scaricati tutti i file e c'è una pulizia, tipo un batch notturno che toglie tutti i file, ad esempio.  Sì, quello sicuramente. Quanto è che abbiamo di storage, 5G?

1:01:00 - Sabatino Rinaldi ( Pienissimo)
  5-terra mi sembra, ricordo male.

1:01:03 - Elena Spini (ROMI Company)
  No, mi sembra meno.-terra mi sembra un po' tanto.

1:01:07 - Sabatino Rinaldi ( Pienissimo)
  Se non sbaglio, era una trentina di gigi. Ma non ho già coltue.

1:01:12 - Elena Spini (ROMI Company)
  Puoi vedere tu al volo adesso, Andre? Eh, guarda, basta che vai in setup.

1:01:18 - Andrea Di Cicco
  No, sì, adesso sono sulla orga di demo per quello.

1:01:21 - Elena Spini (ROMI Company)
  Ah, ok. Puoi andare tu al volo, se no spengo e riaccendo un attimo. Vai, verifico io, ma... Se non sbaglio, l'avevo controllato, ma era tipo settimana scorsa e non ho una buona memoria.  Se non sbaglio, era una trentina di gigi che non è tanto. 5-terra sarebbe bellissimo, ma mi sa che costano un po'.

1:01:39 - Sabatino Rinaldi ( Pienissimo)
  Ma poi ci può fare anche qualcosa che teniamo a fare per fare lo storico, però è l'appi, mentre la fanno un po'.

1:01:47 - Elena Spini (ROMI Company)
  Questo è un po' il punto che ci tenevo a precisare, ecco.

1:01:52 - Sabatino Rinaldi ( Pienissimo)
  Dunque, dai, quella in qualche modo la risolviamo, che sia così, che sia un'app interna, che sia, cioè... Però sì, la linea è questa.  Cioè riuscire a poter utilizzare veramente il meno carta possibile meglio ancora.

1:02:05 - Elena Spini (ROMI Company)
  Sì, però ecco, nel mentre possiamo, diciamo come next step, attiviamo tutti i vari meeting per le analisi e chiedo di fare anche voi un passaggio interno per capire un po' meglio se effettivamente ha senso questo inizio di proposte che abbiamo votato oggi.  Ecco, per quello volevo anticipare il...

1:02:27 - Sabatino Rinaldi ( Pienissimo)
  Infatti, quello che volevo chiederti è, noi ora abbiamo finito, diciamo, la parte dove ci avete mostrato un po' tutte le aree, quelle che sono le vostre idee, basate sulle prime call.  Adesso iniziamo invece nella parte un po' più tecnica. Corretto. Ma andiamo avanti. Corretto. Magari ci prendiamo un po' di tempo noi questa settimana per metterci insieme, mettere insieme i pezzi di quello che abbiamo visto e la settimana prossima iniziare a...
  ACTION ITEM: Schedule Sales + Marketing analysis sessions w/ Sabatino; then schedule Mexal integration + Contracts/Subscriptions - WATCH: https://fathom.video/calls/700474570?timestamp=3764.9999  Volentieri. Volentieri. In settimana ci sentiamo noi, io e te, per fissare subito gli appuntamenti. Così noi ci vediamo un attimo e andiamo avanti poi.  Tanto alla fine abbiamo visto tutto. L'unica parte di base in termini proprio strutturali è l'aspetto marketing, che ne andava bene tutto, se non le terminologie, ma quella è la meno.  La gestione dei contratti di Performance Plus, non ricordo male, non l'abbiamo visto. L'hai vista te, quindi quando io non c'era?  l'abbiamo ancora vista. No,'abbiamo ancora vista. L'abbiamo ancora vista. La gestione? Dei contratti con multiscadenza, contratti con gli annuali con più scadenze.  Ok.

1:03:39 - Elena Spini (ROMI Company)
  Su questo faccio un attimo un passaggio io, perché quelli dovrebbero arrivare sempre da Mexal?

1:03:47 - Sabatino Rinaldi ( Pienissimo)
  No, quello lì è praticamente… No, no, è un giro ordine commerciale, non è Mexal, è semplicemente che sono ordini di un servizio di agenzia, che è un servizio annuale, dove magari noi codifichiamo 4-5 scadenze.  E non abbiamo solo gli eventi. è un giro. Abbiamo gli eventi, abbiamo l'agenzia, abbiamo altri servizi.

1:04:02 - Elena Spini (ROMI Company)
  Ok, quindi è un evento, ci sono, diciamo, non so come dire, oggetti a parte che seguono un flusso a parte?

1:04:11 - Sabatino Rinaldi ( Pienissimo)
  Sì, sì.

1:04:12 - Elena Spini (ROMI Company)
  Ok, e vi interessa?

1:04:14 - Sabatino Rinaldi ( Pienissimo)
  Noi abbiamo un contratto con un cliente, che può essere un cliente che ha comprato corsi, che decide che il marketing non se lo vuole fare lui internamente, lo fa fare a noi che abbiamo un'agenzia di marketing.  è un contratto che costa 24.000 euro, che il cliente ci parte con 3-4 tansha e dove si erano al servizio e c una multifatturazione.  Quindi, che viene creato manualmente? Allora, ad oggi è il reparto commerciale che inserisce... Un ordine. Quest'ordine. Un ordine di vendita.  Il tema qual è? È che questi contratti hanno una validità annuale e che possono essere rinnovati. Quindi che cosa succede?  Avremo bisogno di avere... È una sorta di pannello con tutti questi contratti dove si capisce quando inizia, quando finisce e quando finisce se va rinnovo, sì o no.  E poi tenere anche monitorato per ogni contratto l'attività di fatturazione e di incasso perché poi dopo bisogna dare informazione al reparto che regola il servizio se quel determinato cliente è in regola per i pagamenti, se non è in regola, se ha uno scaduto grave il reparto deve bloccare le regole.  Quindi diciamo dal punto di vista dell'arrivo dell'informazione ad oggi la facciamo inserendo un semplice preventivo che poi si trasforma in ordine di vendita, l'ordine di vendita e poi diventa un contratto quando il cliente ce lo firma.  Però in realtà questo qui non è che è proprio, sarebbe tecnicamente un ordine, è un contratto dove è prevista una cifra complessiva, una determinata frequenza di lepidazione, determinata frequenza Grazie.  È ordine con pluriscadenze, non è un singolo one-shot, è un ordine annuale.

1:06:05 - Elena Spini (ROMI Company)
  Ok, quindi c'è quest'ordine, diciamo così, speciale con pluriscadenze che deve generare un contratto a fronte di determinate situazioni. Esatto, esatto.

1:06:14 - Sabatino Rinaldi ( Pienissimo)
  Ok, va bene. Un abbonamento andrà sentita fuori. Sì, in realtà, le scadenze sono diverse. La fondamentale che ci può dare una mano è capire per ogni cliente che ha quel tipo di contratto, quando quel contratto gli va a scadenza, se deve essere rinnovato sì o no, e inserire il contratto di rinnovo e capire contratto per contratto, data una cifra di 20.000 euro l'anno, quanto io di quel contratto ho già fatturato e di quello che ho già fatturato, quanto ho incassato.  Perché, ripeto, il reparto che è al servizio dei nostri clienti, sono informazioni che deve avere questo.

1:06:56 - Elena Spini (ROMI Company)
  Va bene, su questo ci facciamo anche una pensata. Sarà anche un meeting sicuramente dedicato di analisi di questa parte, comunque l'oggetto diciamo standard è quello di contratto, banalmente, però poi andrà aggiunta la parte che dicevamo adesso di ordine, di reminder, eccetera, quindi però sicuramente questa sarà una parte dedicata.
  ACTION ITEM: Email Elena lead/opportunity form links - WATCH: https://fathom.video/calls/700474570?timestamp=4033.9999  Quindi c una specifica in più sugli ordini. Sì, è un altro prodotto che vendiamo, insomma, cioè noi vendiamo i porti, abbiamo anche… Sabatino, scusa, invece nell'ultima minuta ti avevo chiesto se magari questo, prendilo come punto durante la settimana, i link che avete, che vorrei vedere un po' gli esempi di generazione lead e opportunity, quelli che parlavamo l'altra volta.  Proprio un esempio di… Sì, un esempio di forma che avete.

1:07:55 - Sabatino Rinaldi ( Pienissimo)
  Bene, va bene. Normalmente no, ma… Sì, sì, perfetto.

1:08:00 - Elena Spini (ROMI Company)
  E poi ci sentiamo noi in settimana per mettere i vari meeting. Io potenzialmente punterei a fare magari un meeting di analisi, diciamo, parte sales e iniziare anche la parte marketing.  Sì, però magari di fare i passi in termini di terminologie. Sì, esatto, però almeno iniziamo a parallelizzare.

1:08:23 - Andrea Di Cicco
  Però, capiamo.

1:08:26 - Sabatino Rinaldi ( Pienissimo)
  Siamo in giornata che ti mando quei link in questi giorni per fissare i meeting. Ottimo. Andrea, per caso ti riuscito a fare quella verifica?

1:08:35 - Andrea Di Cicco
  Sì, te l'ho messo in chat. Aspetta che non sei aggiornato dal telebolo.

1:08:41 - Elena Spini (ROMI Company)
  Sono 35,2 giga di file storage.

1:08:45 - Andrea Di Cicco
  mi sono male con la memoria.

1:08:47 - Elena Spini (ROMI Company)
  Mi ricordavo un 30. Non sono 30 tera.

1:08:53 - Sabatino Rinaldi ( Pienissimo)
  Vabbè, Quindi mi ricordo un 5 mila. Vabbè, capito, c'erano giga e quello.
  ACTION ITEM: Email meeting minutes to Elena + Andrea - WATCH: https://fathom.video/calls/700474570?timestamp=4139.9999

1:08:59 - Andrea Di Cicco
  Guarda. Se fossero stati Tera, penso che non lavorare più in vita.

1:09:10 - Sabatino Rinaldi ( Pienissimo)
  Dai, va benissimo, vi mando la venuta come al solito e poi ci riaggiorniamo.

1:09:16 - Elena Spini (ROMI Company)
  Ok. Ok.

1:09:17 - Sabatino Rinaldi ( Pienissimo)
  Ciao a tutti.